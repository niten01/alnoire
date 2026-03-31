modifier_lean_power_rapper = class {}

function modifier_lean_power_rapper:IsHidden() return false end

function modifier_lean_power_rapper:IsPurgable() return false end

function modifier_lean_power_rapper:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_lean_power_rapper:OnCreated()
    if not IsServer() then return end
    self.chancePct = self:GetAbility():GetSpecialValueFor("chance_pct")
    self.damage = self:GetAbility():GetSpecialValueFor("damage")
    self.radius = self:GetAbility():GetSpecialValueFor("radius")
end

function modifier_lean_power_rapper:GetTexture()
    return "item_percocet_xavier"
end
