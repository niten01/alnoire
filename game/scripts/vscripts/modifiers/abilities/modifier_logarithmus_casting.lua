modifier_logarithmus_casting = class {}

function modifier_logarithmus_casting:IsHidden() return true end

function modifier_logarithmus_casting:IsPurgable() return false end

function modifier_logarithmus_casting:CheckState()
    return {
        [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
        [MODIFIER_STATE_IGNORING_STOP_ORDERS] = true,
        [MODIFIER_STATE_SILENCED] = true,
        [MODIFIER_STATE_DISARMED] = true,
    }
end
