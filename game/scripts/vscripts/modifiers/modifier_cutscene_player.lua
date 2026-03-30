modifier_cutscene_player = modifier_cutscene_player or class({})

function modifier_cutscene_player:IsHidden()
    return true
end

function modifier_cutscene_player:IsPurgable()
    return false
end

function modifier_cutscene_player:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_PROPERTY_MOVESPEED_ABSOLUTE,
    }
end

function modifier_cutscene_player:GetModifierMoveSpeed_Absolute()
    return self.ms
end

function modifier_cutscene_player:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_cutscene_player:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_cutscene_player:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_cutscene_player:CheckState()
    return {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
    }
end

function modifier_cutscene_player:OnCreated(kv)
    self.ms = kv.ms or 150
end

-- function modifier_cutscene_player:OnDestroy()
--     local parent = self:GetParent()
-- end
