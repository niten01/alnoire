logarithmus_ult = class {}
LinkLuaModifier("modifier_logarithmus_ult", "abilities/logarithmus_ult", LUA_MODIFIER_MOTION_NONE)

function logarithmus_ult:Spawn()
    self.altAbilityMap = {
        logarithmus_anchor = "logarithmus_alt_anchor",
        logarithmus_step = "logarithmus_alt_step",
        logarithmus_throw = "logarithmus_alt_throw",
        logarithmus_projectile = "logarithmus_alt_projectile",
        logarithmus_clone = "logarithmus_alt_clone",
    }
    self.lastAbilityName = nil

    if not IsServer() then return end
    self:SetLevel(1)
end

function logarithmus_ult:GetIntrinsicModifierName()
    return "modifier_logarithmus_ult"
end

function logarithmus_ult:OnSpellStart()
    if not IsServer() then return end
    if not self.lastAbilityName then return end
    local caster = self:GetCaster()
    local altAbilityName = self.altAbilityMap[self.lastAbilityName]
    assert(altAbilityName)
    caster:SwapAbilities("logarithmus_ult", altAbilityName, false, true)
end

------------------------------------------------------------

modifier_logarithmus_ult = class {}

function modifier_logarithmus_ult:IsHidden() return true end

function modifier_logarithmus_ult:IsPurgable() return false end

function modifier_logarithmus_ult:IsPermanent() return true end

function modifier_logarithmus_ult:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST
    }
end

function modifier_logarithmus_ult:OnAbilityFullyCast(params)
    local abilityName = params.ability:GetAbilityName()
    if string.find(abilityName, "_alt_") then
        if IsServer() then
            self:GetCaster():SwapAbilities("logarithmus_ult", abilityName, true, false)
        end
    else
        local ability = self:GetAbility()
        if not ability.altAbilityMap[abilityName] then return end
        ability.lastAbilityName = abilityName
    end
end
