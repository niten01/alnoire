modifier_demon_power_rapper = class {}

function modifier_demon_power_rapper:IsHidden() return false end

function modifier_demon_power_rapper:IsPurgable() return false end

function modifier_demon_power_rapper:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_demon_power_rapper:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_TOOLTIP
    }
end

function modifier_demon_power_rapper:OnTooltip()
    return self.shieldPerInterval / self.interval
end

function modifier_demon_power_rapper:OnCreated()
    local abilityValues = GetAbilityKeyValuesByName("item_demon_power_rapper").AbilityValues
    self.interval = 0.3
    self.shieldPerInterval = abilityValues.shield_per_sec * self.interval

    if not IsServer() then return end
    CreateDemonPowerEffects(self)
    self:StartIntervalThink(self.interval)
end

function modifier_demon_power_rapper:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    local shield = parent:FindModifierByName("modifier_rapper_spliff_shield")
    if not shield then
        shield = parent:AddNewModifier(parent, parent:FindAbilityByName("rapper_spliff"), "modifier_rapper_spliff_shield",
            {})
    end
    if not shield then return end

    shield:AddShield(self.shieldPerInterval)
end

function modifier_demon_power_rapper:OnDestroy()
    if not IsServer() then return end
    DestroyDemonPowerEffects(self)
end

function modifier_demon_power_rapper:GetTexture()
    return "nevermore_dark_lord"
end
