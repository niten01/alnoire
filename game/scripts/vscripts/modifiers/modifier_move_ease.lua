modifier_move_ease = class({})

function modifier_move_ease:OnCreated(kv)
    if not IsServer() then return end
    if self:GetParent():HasModifier("modifier_immobile") then
        self:Destory()
        return
    end

    self.direction = Vector(kv.directionX, kv.directionY, 0):Normalized()
    self.distance = kv.distance or 500
    self.duration = self:GetDuration()
    self.elapsedTime = 0
    self.startPos = self:GetParent():GetAbsOrigin()

    self.pfx = kv.pfx
    if kv.activity then
        self:GetParent():StartGesture(kv.activity)
        self.activity = kv.activity
    end

    if not self:ApplyHorizontalMotionController() then
        self:Destroy()
    end
end

function modifier_move_ease:OnDestroy()
    if not IsServer() then return end

    local parent = self:GetParent()
    parent:InterruptMotionControllers(true)

    if self.activity then
        parent:FadeGesture(self.activity)
    end

    if self.pfx then
        ParticleManager:DestroyParticle(self.pfx, false)
        ParticleManager:ReleaseParticleIndex(self.pfx)
    end

    ResolveNPCPositions(parent:GetAbsOrigin(), 128)
end

function modifier_move_ease:UpdateHorizontalMotion(me, dt)
    self.elapsedTime = self.elapsedTime + dt

    local pct = math.min(self.elapsedTime / self.duration, 1)

    local easePct = 1 - math.pow((1 - pct), 5)
    local currentDist = self.distance * easePct
    local nextPos = self.startPos + self.direction * currentDist

    me:SetAbsOrigin(nextPos)

    if pct >= 1 then
        self:Destroy()
    end
end

function modifier_move_ease:OnHorizontalMotionInterrupted()
    self:Destroy()
end
