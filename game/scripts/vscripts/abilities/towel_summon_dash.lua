towel_summon_dash = class({})

LinkLuaModifier("modifier_towel_summon_dash", "modifiers/abilities/modifier_towel_summon_dash", LUA_MODIFIER_MOTION_HORIZONTAL)

function towel_summon_dash:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local owner = caster:GetOwner()

    if not caster:HasModifier("modifier_towel_summon_dash") then
        caster:AddNewModifier(caster, self, "modifier_towel_summon_dash", {})
    end
    
end
