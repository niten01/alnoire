rapper_souljah = class {}

function rapper_souljah:RandomEndPointInFan()
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local range = self:GetCastRange(casterPos, nil)

    local baseAngle = math.atan2(self.direction.y, self.direction.x)
    local fraction = RandomFloat(0, 1)

    local relativeAngle = -self.spreadRad + (fraction * (self.spreadRad * 2))
    local finalAngle = baseAngle + relativeAngle
    local endPos = Vector(
        casterPos.x + range * math.cos(finalAngle),
        casterPos.y + range * math.sin(finalAngle),
        0
    )
    return endPos
end

function rapper_souljah:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local target = self:GetCursorPosition()
    self.direction = (target - casterPos):Normalized()
    self.spreadRad = math.rad(self:GetSpecialValueFor("spread"))
    self.shotSpeed = self:GetSpecialValueFor("shot_speed")
    self.projectileRadius = self:GetSpecialValueFor("projectile_radius")

    local duration = self:GetChannelTime()
    self.numShots = self:GetSpecialValueFor("num_shots")
    self.elapsedTime = 0
    self.shotsFired = 0
    self.interval = duration / self.numShots
    self.alternateFire = false
end

function rapper_souljah:Fire()
    local caster = self:GetCaster()
    local endPos = self:RandomEndPointInFan()

    self.alternateFire = not self.alternateFire
    local attIdx = caster:ScriptLookupAttachment(self.alternateFire and "attach_attack1" or "attach_attack2")
    local startPos = caster:GetAttachmentOrigin(attIdx)
    local dir = (endPos - startPos):Normalized()
    dir.z = 0

    ProjectileManager:CreateLinearProjectile({
        Ability = self,
        EffectName = "particles/rapper_souljah_projectile.vpcf",
        vSpawnOrigin = startPos,
        vVelocity = dir * self.shotSpeed,
        fDistance = #(endPos - startPos),
        fStartRadius = self.projectileRadius,
        fEndRadius = self.projectileRadius,
        Source = caster,
        bHasFrontalCone = false,
        iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
        iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        bProvidesVision = true,
        iVisionRadius = 500,
        iVisionTeamNumber = caster:GetTeamNumber()
    })
end

function rapper_souljah:OnProjectileHit(target, location)
    if not target then return end
    local caster = self:GetCaster()

    caster:PerformAttack(target, true, true, true, false, false, false, false)
end

function rapper_souljah:OnChannelThink(dt)
    if not IsServer() then return end

    self.elapsedTime = self.elapsedTime + dt
    while self.shotsFired < self.numShots do
        local nextShotTime = (self.shotsFired + 1) * self.interval

        if self.elapsedTime >= nextShotTime then
            self:Fire()
            self.shotsFired = self.shotsFired + 1
        else
            break
        end
    end
end
