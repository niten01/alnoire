modifier_dialogue_player = modifier_dialogue_player or class({})

function modifier_dialogue_player:IsHidden()
    return true
end

function modifier_dialogue_player:IsPurgable()
    return false
end

function modifier_dialogue_player:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    }
end

function modifier_dialogue_player:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_dialogue_player:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_dialogue_player:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_dialogue_player:CheckState()
    return {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_SILENCED] = true,
    }
end

function modifier_dialogue_player:OnCreated()
    if not IsServer() then return end
    local parent = self:GetParent()
    parent:Stop()
end

-- function modifier_dialogue_player:OnDestroy()
--     local parent = self:GetParent()
-- end
