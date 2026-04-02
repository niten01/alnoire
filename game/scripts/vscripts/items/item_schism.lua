item_schism = class {}
LinkLuaModifier("modifier_schism_owner", "items/item_schism", LUA_MODIFIER_MOTION_NONE)

function item_schism:GetIntrinsicModifierName()
    return "modifier_schism_owner"
end

----------------------------------------------------------------------

modifier_schism_owner = class {}

function modifier_schism_owner:IsHidden() return true end

function modifier_schism_owner:IsPurgable() return false end

function modifier_schism_owner:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK,
        MODIFIER_PROPERTY_DAMAGEOUTGOING_PERCENTAGE
    }
end

function modifier_schism_owner:OnCreated()
    local ability = self:GetAbility()
    if ability then
        self.damageReductionPct = ability:GetSpecialValueFor("damage_reduction_pct")
        self.chancePct = ability:GetSpecialValueFor("chance_pct")
    end
end

modifier_schism_owner.OnRefresh = modifier_schism_owner.OnCreated

function modifier_schism_owner:OnAttack(params)
    if not IsServer() then return end

    local parent = self:GetParent()
    local ability = self:GetAbility()
    local target = params.target

    if params.attacker ~= parent or not parent:IsRangedAttacker() then return end
    if not RollPercentage(self.chancePct) then return end

    local enemies = FindEnemiesForSanyaInRadius(target:GetAbsOrigin(), ability:GetSpecialValueFor("search_radius"))

    local count = 0
    for _, enemy in ipairs(enemies) do
        if enemy == params.target then goto continue end

        self.splitShot = true
        parent:PerformAttack(enemy, true, true, true, false, true, false, false)
        self.splitShot = false

        count = count + 1

        if count >= ability:GetSpecialValueFor("additional_targets") then
            break
        end
        ::continue::
    end
end

function modifier_schism_owner:GetModifierDamageOutgoing_Percentage(params)
    if self.splitShot then
        return -self.damageReductionPct
    end
    return 0
end
