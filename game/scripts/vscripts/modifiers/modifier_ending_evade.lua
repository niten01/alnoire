modifier_ending_evade = class {}

function modifier_ending_evade:IsHidden() return true end

function modifier_ending_evade:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE
    }
end

function modifier_ending_evade:GetModifierIncomingDamage_Percentage()
    SendOverheadEventMessage(
        nil,
        OVERHEAD_ALERT_EVADE,
        self:GetParent(),
        0,
        nil
    )
    return -100
end
