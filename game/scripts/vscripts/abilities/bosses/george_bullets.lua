george_bullets = class({})

function george_bullets:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local projDistance = self:GetSpecialValueFor("proj_distance")
    local projSpeed = self:GetSpecialValueFor("proj_speed")
    local projRadius = self:GetSpecialValueFor("proj_radius")
    local shotInterval = self:GetSpecialValueFor("shot_interval")
    local spread = self:GetSpecialValueFor("spread")
    local numDirections = self:GetSpecialValueFor("num_directions")
    local numToChoose = self:GetSpecialValueFor("num_simultaneous_spawners")
    local duration = self:GetSpecialValueFor("duration")

    local allPoints = Entities:FindAllByName("george_bullets_point")

    local points = {}
    for i = 1, numToChoose, 1 do
        local idx = RandomInt(1, #allPoints)
        table.insert(points, allPoints[idx])
        table.remove(allPoints, idx)
    end

    for _, point in ipairs(points) do
        local startPos = point:GetAbsOrigin()
        local fwd = point:GetForwardVector()
        local shotEnds = PointsFan(startPos, startPos + fwd * projDistance, numDirections, spread / 2)
        local travDir = 1
        local curIdx = 1
        local startTime = GameRules:GetGameTime()
        Timers:CreateTimer(shotInterval, function()
            local curEnd = shotEnds[curIdx]
            local dir = (curEnd - startPos):Normalized()

            ProjectileManager:CreateLinearProjectile({
                Ability = self,
                EffectName = "particles/george_bullet.vpcf",
                vSpawnOrigin = startPos,
                vVelocity = dir * projSpeed,
                fDistance = projDistance,
                fStartRadius = projRadius,
                fEndRadius = projRadius,
                Source = caster,
                bHasFrontalCone = false,
                iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
                iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                bProvidesVision = true,
                iVisionRadius = 500,
                iVisionTeamNumber = caster:GetTeamNumber()
            })


            if curIdx + travDir > #shotEnds or curIdx + travDir < 1 then
                travDir = -travDir
            end

            curIdx = curIdx + travDir

            if GameRules:GetGameTime() - startTime > duration then
                return nil
            end
            return shotInterval
        end)
    end
end

function george_bullets:OnProjectileHit(target, location)
    if not IsServer() then return end
    if not target then return end
    local caster = self:GetCaster()
    local damage = self:GetSpecialValueFor("damage")
    local damageType = self:GetAbilityDamageType()
    ApplyDamage({
        victim = target,
        attacker = caster,
        damage = damage,
        damage_type = damageType,
        ability = self,
    })
    ApplyGeorgeBurn(target, self)

    EmitSoundOnLocationWithCasterSafe(location, "ability.george.bullets.hit", caster)

    return true
end
