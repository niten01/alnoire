modifier_stunned_wrap = class {}

function modifier_stunned_wrap:OnCreated()
    if not IsServer() then return end
    if not self:GetParent():IsMagicImmune() then
        self:GetParent():AddNewModifier(self:GetCaster(), self:GetAbility(), "modifier_stunned", {
            duration = self:GetDuration()
        })
    end
    self:Destroy()
end
