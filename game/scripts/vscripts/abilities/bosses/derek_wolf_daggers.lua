derek_wolf_daggers = class {}

function derek_wolf_daggers:ShowWarning()
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local warningDelay = self:GetSpecialValueFor("warningDelay")
    local delay = self:GetCastPoint() + self:GetSpecialValueFor("warning_delay")
    local distance = self:GetSpecialValueFor("distance")
    local numShots = self:GetSpecialValueFor("num_shots")
    local width = self:GetSpecialValueFor("proj_width")
    self.points = PointsAlongRing(casterPos, distance, numShots)

    for _, point in ipairs(self.points) do
        ShowGenericLineWarning(casterPos, point, width, delay)
    end

    return warningDelay
end

function derek_wolf_daggers:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local distance = self:GetSpecialValueFor("distance")

    assert(self.points)
    for _, point in ipairs(self.points) do
        local dir = (point - casterPos):Normalized()
        dir.z = 0

        local projInfo = {
            Ability = self,
            EffectName = "particles/derek_linear_proj_v2.vpcf",
            vSpawnOrigin = casterPos,
            fDistance = distance,
            fStartRadius = self:GetSpecialValueFor("proj_width"),
            fEndRadius = self:GetSpecialValueFor("proj_width"),
            Source = caster,
            bHasFrontalCone = false,
            bReplaceExisting = false,
            iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
            iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            vVelocity = dir * self:GetSpecialValueFor("proj_speed"),
            bProvidesVision = false,
        }

        ProjectileManager:CreateLinearProjectile(projInfo)
    end
end

function derek_wolf_daggers:OnProjectileHit(target, location)
    if not IsServer() then return end
    if not target then return end
    local caster = self:GetCaster()
    local damage = self:GetSpecialValueFor("damage")
    local damageType = self:GetAbilityDamageType()
    PlayDerekBloodEffects(target, location - target:GetAbsOrigin())
    ApplyDamage({
        victim = target,
        attacker = caster,
        damage = damage,
        damage_type = damageType,
        ability = self,
    })
end
