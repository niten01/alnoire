ball_slide = class {}
LinkLuaModifier("modifier_ball_slide", "abilities/bosses/ball_slide.lua", LUA_MODIFIER_MOTION_NONE)

function ball_slide:GetIntrinsicModifierName() return "modifier_ball_slide" end

------------------------------------------------------------------

modifier_ball_slide = class {}

function modifier_ball_slide:IsHidden() return true end

function modifier_ball_slide:IsPurgable() return false end

function modifier_ball_slide:CheckState()
    return {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true
    }
end

function modifier_ball_slide:OnCreated(kv)
    if not IsServer() then return end

    local parent = self:GetParent()
    local ability = parent:FindAbilityByName("ball_slide")
    assert(ability)
    self.friction = ability:GetSpecialValueFor("friction")
    self.bounceFactor = ability:GetSpecialValueFor("bounce_factor")

    self.hitSpeed = ability:GetSpecialValueFor("hit_speed")
    self.velocity = Vector(0, 0, 0)
    self.lastTime = GameRules:GetGameTime()

    -- if self:ApplyHorizontalMotionController() == false then
    --     self:Destroy()
    -- end
    self:StartIntervalThink(0.03)
end

function modifier_ball_slide:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
end

function modifier_ball_slide:OnTakeDamage(params)
    if not IsServer() then return end
    local parent = self:GetParent()
    local parentPos = parent:GetAbsOrigin()
    if params.unit ~= parent then return end

    local attackerPos = params.attacker:GetAbsOrigin()
    local direction = (parentPos - attackerPos):Normalized()
    direction.z = 0
    self.velocity = self.velocity + direction * self.hitSpeed

    parent:EmitSound("ball.hit")
end

function modifier_ball_slide:OnIntervalThink()
    if not IsServer() then return end
    local curTime = GameRules:GetGameTime()
    local dt = curTime - self.lastTime
    self.lastTime = curTime
    self:UpdateHorizontalMotion(self:GetParent(), dt)
end

function modifier_ball_slide:UpdateHorizontalMotion(me, dt)
    local pos = me:GetAbsOrigin()
    local nextPos = pos + self.velocity * dt

    if not GridNav:IsTraversable(nextPos) or GridNav:IsBlocked(nextPos) then
        self:HandleBounce(pos)
        return
    end

    -- me:FaceTowards(nextPos)
    me:SetAbsOrigin(nextPos)
    -- FindClearSpaceForUnit(me, nextPos, true)

    self.velocity = self.velocity * self.friction
end

function modifier_ball_slide:HandleBounce(current_pos)
    local test_dist = 30
    local x_blocked = not GridNav:IsTraversable(current_pos +
        Vector(self.velocity.x > 0 and test_dist or -test_dist, 0, 0))
    local y_blocked = not GridNav:IsTraversable(current_pos +
        Vector(0, self.velocity.y > 0 and test_dist or -test_dist, 0))

    if x_blocked then
        self.velocity.x = -self.velocity.x * self.bounceFactor
    end
    if y_blocked then
        self.velocity.y = -self.velocity.y * self.bounceFactor
    end

    local parent = self:GetParent()
    parent:EmitSound("ball.hit")
end

function modifier_ball_slide:OnDestroy()
    if not IsServer() then return end
    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetOrigin(), true)
end
