logarithmus_ult = class {}
LinkLuaModifier("modifier_logarithmus_ult", "abilities/logarithmus_ult", LUA_MODIFIER_MOTION_NONE)

function logarithmus_ult:Spawn()
    self.altAbilityMap = {
        logarithmus_anchor = "logarithmus_alt_anchor",
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
    DebugPrint(altAbilityName)
    if not altAbilityName then
        DebugPrint("No alt ability for: " .. self.lastAbilityName)
        return
    end
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
    DebugPrint(abilityName)
    if string.find(abilityName, "_alt_") then
        if IsServer() then
            self:GetCaster():SwapAbilities("logarithmus_ult", abilityName, true, false)
        end
    elseif abilityName ~= "logarithmus_ult" then
        self:GetAbility().lastAbilityName = abilityName
    end
end