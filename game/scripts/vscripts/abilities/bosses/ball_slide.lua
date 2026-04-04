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

    self.radius = ability:GetSpecialValueFor("damage_radius")
    self.dps = ability:GetSpecialValueFor("dps")
    self.minDamageVelocity = ability:GetSpecialValueFor("min_damage_vel")

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
    self.velocity.z = 0
    local pos = me:GetAbsOrigin()
    local nextPos = pos + self.velocity * dt
    local safeNextPos = GetSafeBlinkDestination(pos, nextPos)

    if #self.velocity < 5 then
        self.velocity = Vector(0, 0, 0)
        return
    end

    if math.abs((safeNextPos - pos):Length2D() - (nextPos - pos):Length2D()) > 1 then
        self:HandleBounce(safeNextPos)
        nextPos = safeNextPos
    end

    me:SetForwardVector(self.velocity:Normalized())
    me:FaceTowards(pos + self.velocity*2)

    if not me:HasModifier("modifier_vertical_jump") then
        nextPos.z = GetGroundHeight(nextPos, me)
    end

    me:SetAbsOrigin(nextPos)
    -- FindClearSpaceForUnit(me, nextPos, true)

    self.velocity = self.velocity * self.friction

    if #self.velocity >= self.minDamageVelocity then
        local enemies = FindEnemiesForAIInRadius(pos, self.radius)
        for _, ent in ipairs(enemies) do
            ApplyDamage({
                victim = ent,
                attacker = me,
                damage = self.dps * dt,
                damage_type = DAMAGE_TYPE_PHYSICAL,
                ability = self:GetAbility()
            })
        end
    end
end

function modifier_ball_slide:HandleBounce(current_pos)
    local test_dist = 1 + SAFE_BLINK_HULL_RADIUS
    -- self.velocity = -self.velocity
    local xTest = Vector(self.velocity.x > 0 and test_dist or -test_dist, 0, 0)
    local yTest = Vector(0, self.velocity.y > 0 and test_dist or -test_dist, 0)
    local x_blocked = not GridNav:IsTraversable(current_pos + xTest) or GridNav:IsBlocked(current_pos + xTest)
    local y_blocked = not GridNav:IsTraversable(current_pos +
        yTest) or GridNav:IsBlocked(current_pos + yTest)

    local parent = self:GetParent()
    if x_blocked then
        self.velocity.x = -self.velocity.x * self.bounceFactor
        parent:EmitSound("ball.hit")
    end
    if y_blocked then
        self.velocity.y = -self.velocity.y * self.bounceFactor
        parent:EmitSound("ball.hit")
    end
end

function modifier_ball_slide:OnDestroy()
    if not IsServer() then return end
    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetOrigin(), true)
end
