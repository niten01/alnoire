modifier_disabled_vis = modifier_disabled_vis or class({})

function modifier_disabled_vis:IsHidden()
    return true
end

function modifier_disabled_vis:IsPurgable()
    return false
end

function modifier_disabled_vis:CheckState()
    return {
        [MODIFIER_STATE_STUNNED] = true
    }
end

function modifier_disabled_vis:OnCreated()
    if not IsServer() then return end
    local parent = self:GetParent()
    parent:StartGesture(ACT_DOTA_DISABLED)
end

function modifier_disabled_vis:OnDestroy()
    local parent = self:GetParent()
    parent:FadeGesture(ACT_DOTA_DISABLED)
end
