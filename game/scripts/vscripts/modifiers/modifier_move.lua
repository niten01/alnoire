modifier_move = class {}

function modifier_move:OnCreated(kv)
    if not IsServer() then return end

    self.direction = Vector(kv.directionX, kv.directionY, 0):Normalized()
    self.speed = kv.speed
    self.time = self:GetDuration()
    self.distance = self.speed * self.time
    self.travelled = 0
    local parent = self:GetParent()
    if kv.activity then
        parent:StartGesture(kv.activity)
        self.activity = kv.activity
    end

    if self:ApplyHorizontalMotionController() then
        self.time = 0
    else
        self:Destroy()
    end
end

function modifier_move:OnDestroy()
    if self.activity then
        self:GetParent():FadeGesture(self.activity)
    end
end

function modifier_move:UpdateHorizontalMotion(me, dt)
    local step = self.speed * dt
    self.travelled = self.travelled + step

    local new_pos = me:GetAbsOrigin() + self.direction * step
    me:SetAbsOrigin(new_pos)

    if self.travelled >= self.distance then
        me:InterruptMotionControllers(true)
        self:Destroy()
    end
end
