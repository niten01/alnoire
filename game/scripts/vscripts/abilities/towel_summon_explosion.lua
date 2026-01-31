LinkLuaModifier("modifier_towel_summon_delayed_explode", "modifiers/abilities/modifier_towel_summon_delayed_explode", LUA_MODIFIER_MOTION_NONE)
towel_summon_explosion = class({})

function towel_summon_explosion:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    if caster:HasModifier("modifier_towel_summon_delayed_explode") then return end
    caster:AddNewModifier( caster, self, 'modifier_towel_summon_delayed_explode', {duration = self:GetSpecialValueFor('delay')} )
end