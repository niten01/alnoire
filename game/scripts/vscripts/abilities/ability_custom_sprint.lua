ability_custom_sprint = class({})


function ability_custom_sprint:OnToggle()
    local caster = self:GetCaster()
    if self:GetToggleState() then
        caster:AddNewModifier(caster, self, "modifier_custom_sprint", {})
    else
        caster:RemoveModifierByName("modifier_custom_sprint")
    end
end

function ability_custom_sprint:OnUpgrade()
    if IsServer() then
        local caster = self:GetCaster()
        caster:AddNewModifier(caster, self, "modifier_custom_sprint_passive", {})
    end
end