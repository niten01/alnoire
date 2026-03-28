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
        MODIFIER_EVENT_ON_ATTACK_LANDED,
        MODIFIER_PROPERTY_TOOLTIP,
        MODIFIER_PROPERTY_TOOLTIP2,
        MODIFIER_PROPERTY_SPELL_AMPLIFY_PERCENTAGE
    }
end

function modifier_logarithmus_concentration:GetModifierSpellAmplify_Percentage()
    local ability = self:GetAbility()
    return ability:GetSpecialValueFor("spell_amp_pct")
end

function modifier_logarithmus_concentration:GetBonusDamage()
    local ability = self:GetAbility()
    return self:GetStackCount() * ability:GetSpecialValueFor("magical_damage_per_stack")
end

function modifier_logarithmus_concentration:GetLifestealFraction()
    local ability = self:GetAbility()
    local lifestealFraction = self:GetStackCount() * ability:GetSpecialValueFor("lifesteal_pct_per_stack") / 100
    lifestealFraction = math.max(1, lifestealFraction)
    return lifestealFraction
end

function modifier_logarithmus_concentration:OnAttackLanded(params)
    if params.attacker ~= self:GetParent() then return end
    local stackCount = self:GetStackCount()
    if stackCount == 0 then return end

    if IsServer() then
        local parent = self:GetParent()
        local ability = self:GetAbility()
        local damage = self:GetBonusDamage()
        local lifestealFraction = self:GetLifestealFraction()
        ApplyDamage({
            victim = params.target,
            attacker = parent,
            damage = damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self,
        })
        parent:HealWithParams(damage * lifestealFraction, ability, false, true, parent, true)

        local pfx = ParticleManager:CreateParticle("particles/logarithmus_lifesteal.vpcf", PATTACH_ABSORIGIN_FOLLOW,
            parent)
        ParticleManager:ReleaseParticleIndex(pfx)
    end

    self:SetStackCount(0)
end

function modifier_logarithmus_concentration:OnTooltip()
    return self:GetBonusDamage()
end

function modifier_logarithmus_concentration:OnTooltip2()
    return self:GetBonusDamage() * self:GetLifestealFraction()
end
