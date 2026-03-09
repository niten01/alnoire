modifier_vertical_jump = class {}

function modifier_vertical_jump:OnCreated(kv)
    if not IsServer() then return end
    self.height = kv.height

    local parent = self:GetParent()
    parent:StartGesture(ACT_DOTA_DISABLED)
    if self:ApplyVerticalMotionController() then
        self.time = 0
    else
        self:Destroy()
    end
end

function modifier_vertical_jump:OnDestroy()
    if not IsServer() then return end
    local parent = self:GetParent()
    parent:FadeGesture(ACT_DOTA_DISABLED)
end

function modifier_vertical_jump:CheckState()
    return {
        [MODIFIER_STATE_STUNNED] = true,
    }
end

function modifier_vertical_jump:UpdateVerticalMotion(me, dt)
    local x = self:GetRemainingTime() / self:GetDuration()
    local height = self.height * (-4 * x * x + 4 * x)
    local ground_z = GetGroundHeight(me:GetAbsOrigin(), me)
    local origin = me:GetAbsOrigin()
    origin.z = ground_z + height
    me:SetAbsOrigin(origin)
end
