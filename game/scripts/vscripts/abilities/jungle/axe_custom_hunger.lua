LinkLuaModifier('modifier_axe_custom_hunger_debuff', 'abilities/jungle/axe_custom_hunger', LUA_MODIFIER_MOTION_NONE)
axe_custom_hunger = class({})

function axe_custom_hunger:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    local duration = self:GetSpecialValueFor('duration')


    if target:TriggerSpellAbsorb(self) then return end
    if target then
        target:EmitSound("Hero_Axe.Battle_Hunger")
        target:AddNewModifier(caster, self, 'modifier_axe_custom_hunger_debuff', { duration = duration })
    end
end

function axe_custom_hunger:GetCastAnimation()
    return ACT_DOTA_OVERRIDE_ABILITY_2
end

function axe_custom_hunger:GetCastPoint()
    return 0.9
end

---------------------

modifier_axe_custom_hunger_debuff = class({})

function modifier_axe_custom_hunger_debuff:IsHidden() return false end

function modifier_axe_custom_hunger_debuff:IsPurgable() return true end

function modifier_axe_custom_hunger_debuff:IsDebuff() return true end

function modifier_axe_custom_hunger_debuff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_axe_custom_hunger_debuff:GetModifierMoveSpeedBonus_Constant()
    local abil = self:GetAbility()
    local msConst = abil:GetSpecialValueFor('slowAmount')
    return -msConst or -50
end

function modifier_axe_custom_hunger_debuff:OnCreated()
    if not IsServer() then return end
    local abil = self:GetAbility()
    self.dmgPerSec = abil:GetSpecialValueFor('damagePerSec') or 100
    local target = self:GetParent()
    self:StartIntervalThink(1.0)
end

function modifier_axe_custom_hunger_debuff:OnIntervalThink()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local parent = self:GetParent()
    local ability = self:GetAbility()

    -- Наносим урон
    local damageTable = {
        victim = parent,
        attacker = caster,
        damage = self.dmgPerSec,
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = ability,
    }
    ApplyDamage(damageTable)
end

function modifier_axe_custom_hunger_debuff:GetEffectName()
    return "particles/econ/items/axe/axe_cinder/axe_cinder_battle_hunger.vpcf"
end

function modifier_axe_custom_hunger_debuff:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end

function modifier_axe_custom_hunger_debuff:OnDeath(params)
    if not IsServer() then return end
    if params.attacker == self:GetParent() then
        self:Destroy()
    end
end
