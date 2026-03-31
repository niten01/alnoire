modifier_lean_power_logarithmus = class {}

function modifier_lean_power_logarithmus:IsHidden() return false end

function modifier_lean_power_logarithmus:IsPurgable() return false end

function modifier_lean_power_logarithmus:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_lean_power_logarithmus:OnCreated()
    if not IsServer() then return end
    self.stacksThreshold = self:GetAbility():GetSpecialValueFor("stacks_threshold")
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_lean_power_logarithmus:GetTexture()
    return "item_percocet_xavier"
end
