logarithmus_concentration = class {}
LinkLuaModifier("modifier_logarithmus_concentration", "abilities/logarithmus_concentration", LUA_MODIFIER_MOTION_NONE)

function logarithmus_concentration:Spawn()
    if not IsServer() then return end
    self:SetLevel(1)
end

function logarithmus_concentration:GetIntrinsicModifierName()
    return "modifier_logarithmus_concentration"
end

------------------------------------------------------------

modifier_logarithmus_concentration = class {}

function modifier_logarithmus_concentration:IsHidden() return false end

function modifier_logarithmus_concentration:IsPurgable() return false end

function modifier_logarithmus_concentration:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
        MODIFIER_EVENT_ON_ATTACK_LANDED,
    }
end

function modifier_logarithmus_concentration:OnAbilityFullyCast(params)
    if params.unit ~= self:GetParent() then return end
    self:IncrementStackCount()
end

function modifier_logarithmus_concentration:CalcMagicalDamage()
    local stackCount = self:GetStackCount()
    local ability = self:GetAbility()
    local damage = stackCount * ability:GetSpecialValueFor("magical_damage_per_stack")
    return damage
end

function modifier_logarithmus_concentration:OnAttackLanded(params)
    if params.attacker ~= self:GetParent() then return end
    local stackCount = self:GetStackCount()
    if stackCount == 0 then return end
    self:SetStackCount(0)

    if not IsServer() then return end

    local parent = self:GetParent()
    local ability = self:GetAbility()
    local damage = self:CalcMagicalDamage()
    local lifestealFraction = stackCount * ability:GetSpecialValueFor("lifesteal_pct_per_stack") / 100
    lifestealFraction = math.max(1, lifestealFraction)
    ApplyDamage({
        victim = params.target,
        attacker = parent,
        damage = damage,
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = self,
    })
    parent:HealWithParams(damage * lifestealFraction, ability, false, true, parent, true)
end
