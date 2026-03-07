island_fiend_requiem = class {}

function island_fiend_requiem:OnAbilityPhaseStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    caster:EmitSound("ability.island_fiend.requiem.cast")
end

function island_fiend_requiem:OnSpellStart()
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local radius = self:GetSpecialValueFor("proj_radius")
    local time = self:GetSpecialValueFor("fly_time")
    local points = PointsAlongRing(casterPos, self:GetSpecialValueFor("max_range"),
        self:GetSpecialValueFor("num_projectiles"))

    for _, point in ipairs(points) do
        point.z = casterPos.z
        DrawDebugCircle(point, radius, 2)
        local v = point - casterPos
        local dist = #v
        local speed = dist / time
        ProjectileManager:CreateLinearProjectile({
            Ability = self,
            vSpawnOrigin = casterPos,
            vVelocity = v:Normalized() * (speed),
            fDistance = dist,
            fStartRadius = radius,
            fEndRadius = radius,
            Source = caster,
            bHasFrontalCone = false,
            iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
            iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
            bProvidesVision = true,
            iVisionRadius = 500,
            iVisionTeamNumber = caster:GetTeamNumber()
        })

        local pfx = ParticleManager:CreateParticle(
            "particles/sf_requiem.vpcf",
            PATTACH_WORLDORIGIN,
            nil)
        ParticleManager:SetParticleControl(pfx, 0, casterPos)
        ParticleManager:SetParticleControlTransformForward(pfx, 1, point, v)
        ParticleManager:SetParticleControl(pfx, 2, Vector(0, 10, 0))
        ParticleManager:ReleaseParticleIndex(pfx)
    end

    caster:EmitSound("ability.island_fiend.requiem.explode")
end

function island_fiend_requiem:OnProjectileHit(hTarget, vLocation)
    if not IsServer() then return end
    if not hTarget then return end

    local damage = self:GetSpecialValueFor("damage_per_proj")
    ApplyDamage({
        victim = hTarget,
        attacker = self:GetCaster(),
        damage = damage,
        damage_type = DAMAGE_TYPE_MAGICAL
    })

    return false
end
