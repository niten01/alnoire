modifier_logarithmus_casting = class {}

function modifier_logarithmus_casting:IsHidden() return true end

function modifier_logarithmus_casting:IsPurgable() return false end

function modifier_logarithmus_casting:OnCreated(kv)
    self.invulnerable = kv.invulnerable
end

function modifier_logarithmus_casting:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
    }
end

function modifier_logarithmus_casting:GetModifierIncomingDamage_Percentage()
    if not self.invulnerable then return 0 end
    DebugPrint(self.invulnerable)
    return -100
end

function modifier_logarithmus_casting:CheckState()
    return {
        [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
        [MODIFIER_STATE_IGNORING_STOP_ORDERS] = true,
        [MODIFIER_STATE_SILENCED] = true,
        [MODIFIER_STATE_DISARMED] = true,
    }
end
