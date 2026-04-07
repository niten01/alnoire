modifier_island_traps_participant = class {}

function modifier_island_traps_participant:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_island_traps_participant:CheckState()
    return {
        [MODIFIER_STATE_SILENCED] = true,
        [MODIFIER_STATE_MUTED] = true,
    }
end

function modifier_island_traps_participant:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_DISABLE_HEALING,
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
    }
end

function modifier_island_traps_participant:GetModifierConstantHealthRegen()
    return -99999
end

function modifier_island_traps_participant:GetDisableHealing()
    return 1
end

function modifier_island_traps_participant:GetModifierMoveSpeed_Absolute()
    return 300
end