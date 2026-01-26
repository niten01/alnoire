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