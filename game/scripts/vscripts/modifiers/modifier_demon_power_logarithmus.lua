modifier_demon_power_logarithmus = class {}

function modifier_demon_power_logarithmus:IsHidden() return true end

function modifier_demon_power_logarithmus:IsPurgable() return false end

function modifier_demon_power_logarithmus:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_demon_power_logarithmus:OnCreated()
    if not IsServer() then return end
    CreateDemonPowerEffects(self)
end

function modifier_demon_power_logarithmus:OnDestroy()
    if not IsServer() then return end
    DestroyDemonPowerEffects(self)
end

--------------------------------------------------------------------

modifier_demon_power_logarithmus_combo = class {}

function modifier_demon_power_logarithmus_combo:IsHidden() return false end

function modifier_demon_power_logarithmus_combo:IsPurgable() return false end

function modifier_demon_power_logarithmus_combo:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_TOOLTIP,
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
end

function modifier_demon_power_logarithmus_combo:OnTooltip()
    return self:GetLifestealFraction() * 100
end

function modifier_demon_power_logarithmus_combo:GetLifestealFraction()
    return (self:GetStackCount() * self.lifestealPctPerStack) / 100
end

function modifier_demon_power_logarithmus_combo:OnCreated()
    local abilityValues = GetAbilityKeyValuesByName("item_demon_power_logarithmus").AbilityValues
    self.lifestealPctPerStack = tonumber(abilityValues.lifesteal_pct_per_stack)

    if not IsServer() then return end

    self:SetHasCustomTransmitterData(true)
end

function modifier_demon_power_logarithmus_combo:OnStackCountChanged()
    if not IsServer() then return end
    self:SendBuffRefreshToClients()
end

function modifier_demon_power_logarithmus_combo:AddCustomTransmitterData()
    return {
        stackCount = self:GetStackCount(),
    }
end

function modifier_demon_power_logarithmus_combo:HandleCustomTransmitterData(data)
    self:SetStackCount(data.stackCount)
end

function modifier_demon_power_logarithmus_combo:OnTakeDamage(event)
    local parent = self:GetParent()
    if event.attacker ~= parent or event.unit == parent or not event.inflictor then
        return
    end

    if bit.band(event.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) == DOTA_DAMAGE_FLAG_REFLECTION then
        return
    end

    local healAmount = self:GetLifestealFraction() * event.damage
    print(healAmount)
    if healAmount <= 0 then return end

    parent:Heal(healAmount, event.inflictor)

    local pfx = ParticleManager:CreateParticle("particles/logarithmus_demon_power_lifesteal.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, parent)
    ParticleManager:ReleaseParticleIndex(pfx)
end

function modifier_demon_power_logarithmus_combo:OnDestroy()
    if not IsServer() then return end
    self:GetParent():EmitSound("ability.logarithmus.combo_break")
end

function modifier_demon_power_logarithmus_combo:GetTexture()
    return "nevermore_dark_lord"
end
