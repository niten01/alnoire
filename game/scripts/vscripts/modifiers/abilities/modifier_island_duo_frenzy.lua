modifier_island_duo_frenzy = class {}

function modifier_island_duo_frenzy:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_CASTTIME_PERCENTAGE,
        MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE
    }
end

function modifier_island_duo_frenzy:OnCreated(kv)
    if not IsServer() then return end
    self.cdr = kv.cdr
end

function modifier_island_duo_frenzy:GetModifierPercentageCasttime()
    return 50
end

function modifier_island_duo_frenzy:GetModifierPercentageCooldown()
    return self.cdr
end