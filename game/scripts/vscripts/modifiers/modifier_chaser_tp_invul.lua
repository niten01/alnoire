modifier_chaser_tp_invul = class({})

function modifier_chaser_tp_invul:IsHidden()
    return true
end

function modifier_chaser_tp_invul:IsPurgable()
    return false
end

function modifier_chaser_tp_invul:CheckState()
    return {
        [MODIFIER_STATE_INVULNERABLE] = true,
    }
end

function modifier_chaser_tp_invul:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
end

function modifier_chaser_tp_invul:GetOverrideAnimation()
    return ACT_DOTA_CAST_ABILITY_4
end
