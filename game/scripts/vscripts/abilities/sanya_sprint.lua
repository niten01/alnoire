LinkLuaModifier("modifier_custom_sprint", "modifiers/abilities/modifier_custom_sprint", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_sprint_passive", "modifiers/abilities/modifier_custom_sprint_passive", LUA_MODIFIER_MOTION_NONE)
sanya_sprint = class({})

function sanya_sprint:Spawn()
    if IsServer() then
        self:SetLevel(1)
        local caster = self:GetCaster()
        caster:AddNewModifier(caster, self, "modifier_custom_sprint_passive", {})
    end
end

function sanya_sprint:OnToggle()
    local caster = self:GetCaster()
    if self:GetToggleState() then
        caster:AddNewModifier(caster, self, "modifier_custom_sprint", {})
    else
        caster:RemoveModifierByName("modifier_custom_sprint")
    end
end