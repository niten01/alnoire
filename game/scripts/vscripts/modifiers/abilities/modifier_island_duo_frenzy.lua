modifier_island_duo_frenzy = class {}

function modifier_island_duo_frenzy:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_CASTTIME_PERCENTAGE
    }
end

function modifier_island_duo_frenzy:GetModifierPercentageCasttime()
    return -50
end