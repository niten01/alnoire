genius_rain = class {}
LinkLuaModifier("modifier_rain_slippery", "abilities/bosses/genius_rain.lua", LUA_MODIFIER_MOTION_HORIZONTAL)

function genius_rain:OnSpellStart()
    local caster = self:GetCaster()
    local radius = self:GetSpecialValueFor("radius")
    local duration = self:GetSpecialValueFor("duration")
    local maxSpeed = self:GetSpecialValueFor("max_speed")

    local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_oracle/oracle_scepter_rain_of_destiny.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, caster)
    ParticleManager:SetParticleControl(pfx, 1, Vector(radius, 0, 0))
    caster:EmitSound("ability.genius.rain.loop")

    local interval = 0.3
    local remainingDuration = duration
    Timers:CreateTimer(interval, function()
        local enemies = FindEnemiesForAIInRadius(caster:GetAbsOrigin(), radius)
        for _, ent in ipairs(enemies) do
            if not ent:HasModifier("modifier_rain_slippery") then
                ent:AddNewModifier(caster, self, "modifier_rain_slippery",
                    { duration = remainingDuration, maxSpeed = maxSpeed})
            end
        end
        remainingDuration = remainingDuration - interval
        if remainingDuration <= 0 then
            ParticleManager:DestroyParticle(pfx, false)
            ParticleManager:ReleaseParticleIndex(pfx)
            caster:StopSound("ability.genius.rain.loop")
            return nil
        else
            return interval
        end
    end)
end

------------------------------------------------------------

modifier_rain_slippery = class {}

function modifier_rain_slippery:OnCreated(kv)
    if not IsServer() then return end

    self.velocity = Vector(0, 0, 0)
    self.maxSpeed = kv.maxSpeed
    self.acceleration = 10
    self.friction = 0.98
    self.stopThreshold = 10
    self.interval = 0.01

    local parent = self:GetParent()
    parent:StartGesture(ACT_DOTA_FLAIL)
    self:StartIntervalThink(self.interval)
end

function modifier_rain_slippery:OnDestroy()
    if not IsServer() then return end
    self:GetParent():FadeGesture(ACT_DOTA_FLAIL)
end

function modifier_rain_slippery:UpdateHorizontalMotion(me, dt)
end

function modifier_rain_slippery:OnIntervalThink()
    local parent = self:GetParent()
    local currentPos = parent:GetAbsOrigin()
    parent:SetMustReachEachGoalEntity(false)

    local wishDir = parent:GetForwardVector()
    wishDir.z = 0
    self.velocity = self.velocity + (wishDir * self.acceleration)

    if self.velocity:Length2D() > self.maxSpeed then
        self.velocity = self.velocity:Normalized() * self.maxSpeed
    end

    local nextPos = currentPos + (self.velocity * self.interval)

    if GridNav:IsTraversable(nextPos) and not GridNav:IsBlocked(nextPos) then
        parent:SetAbsOrigin(nextPos)
    else
        self.velocity = -self.velocity 
    end
end

function modifier_rain_slippery:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_TURN_RATE_PERCENTAGE,
        MODIFIER_PROPERTY_MOVESPEED_BASE_OVERRIDE,
    }
end

function modifier_rain_slippery:GetModifierTurnRate_Percentage()
    return -80
end

function modifier_rain_slippery:GetModifierMoveSpeedBaseOverride()
    return 100
end

function modifier_rain_slippery:CheckState()
    return {
        [MODIFIER_STATE_CANNOT_MISS] = true,
        [MODIFIER_STATE_ROOTED] = true,
    }
end
