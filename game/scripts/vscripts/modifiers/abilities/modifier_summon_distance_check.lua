modifier_summon_distance_check = class({})
LinkLuaModifier("modifier_towel_summon_custom_stun", "modifiers/abilities/modifier_towel_summon_custom_stun", LUA_MODIFIER_MOTION_NONE)

function modifier_summon_distance_check:IsHidden() return false end
function modifier_summon_distance_check:IsPurgable() return false end

function modifier_summon_distance_check:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.2)
end

function modifier_summon_distance_check:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH, MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT, MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
    }
end

function modifier_summon_distance_check:GetActivityTranslationModifiers()
    if not self.speed_bonus or (self.speed_bonus == 0) then
        return 
    else 
        return 'haste'
    end
end

function modifier_summon_distance_check:GetModifierMoveSpeedBonus_Constant()
    return self.speed_bonus or 0
end

function modifier_summon_distance_check:OnIntervalThink()
    local unit = self:GetParent()
    local owner = unit:GetOwner()
    while unit:GetLevel() < owner:GetLevel() do
        unit:HeroLevelUp(false)
    end
    local ability = self:GetAbility()
    if not owner or not owner:IsAlive() or not ability then return end

    local target_speed = owner:GetIdealSpeed()
    if target_speed > unit:GetBaseMoveSpeed() then
        self.speed_bonus = target_speed - unit:GetBaseMoveSpeed()
    else 
        self.speed_bonus = 0
    end
    

    local radius = ability:GetCastRange(owner:GetAbsOrigin(), nil)
    local distance = (unit:GetAbsOrigin() - owner:GetAbsOrigin()):Length2D()

    if distance > radius then
        if not unit:HasModifier("modifier_towel_summon_custom_stun") then
            unit:AddNewModifier(owner, ability, "modifier_towel_summon_custom_stun", {duration = -1})
        end
    else
        if unit:HasModifier("modifier_towel_summon_custom_stun") then
            unit:RemoveModifierByName("modifier_towel_summon_custom_stun")
        end
    end
end

function modifier_summon_distance_check:OnDeath(params)
    local ability = self:GetAbility()
    local unit = self:GetParent()
    local owner = unit:GetOwner()
    local caster = ability:GetCaster()

    if params.unit == unit then
        if ability then
            ability:SetFrozenCooldown(false)
            if caster then
                caster:SwapAbilities("sanya_towel_summon_return", "sanya_towel_summon", false, true)
                caster.summon = nil
            end
        end
    elseif params.unit == owner then
        unit:ForceKill(false)
        if caster then
            ability:SetFrozenCooldown(false)
            caster:SwapAbilities("sanya_towel_summon_return", "sanya_towel_summon", false, true)
            caster.summon = nil
        end
    end
end