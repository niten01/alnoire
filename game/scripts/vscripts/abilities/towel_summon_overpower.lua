towel_summon_overpower = class({})
LinkLuaModifier("modifier_towel_summon_overpower", "modifiers/abilities/modifier_towel_summon_overpower", LUA_MODIFIER_MOTION_NONE)

function towel_summon_overpower:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    caster:AddNewModifier(caster, self, 'modifier_towel_summon_overpower', {duration = self:GetSpecialValueFor('buff_duration') or 10.0})
end