modifier_lean_power_logarithmus = class {}

function modifier_lean_power_logarithmus:IsHidden() return false end

function modifier_lean_power_logarithmus:IsPurgable() return false end

function modifier_lean_power_logarithmus:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_lean_power_logarithmus:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_TOOLTIP
    }
end

function modifier_lean_power_logarithmus:OnCreated()
    self.stacksThreshold = self:GetAbility():GetSpecialValueFor("stacks_threshold")
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_lean_power_logarithmus:GetTexture()
    return "item_percocet_xavier"
end

function modifier_lean_power_logarithmus:OnTooltip()
    return self.stacksThreshold
end
