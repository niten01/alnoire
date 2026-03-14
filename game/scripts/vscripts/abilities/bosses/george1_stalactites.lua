george1_stalactites = class {}

function george1_stalactites:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local numAreas = self:GetSpecialValueFor("num_points")
    local spawnRadius = self:GetSpecialValueFor("spawn_radius")
    local areaRadius = self:GetSpecialValueFor("radius")
    local damage = self:GetSpecialValueFor("damage")

    ScreenShake(casterPos, 10, 3, 3, 3000, 0, true)
    caster:EmitSound("ability.george1.stalactites.cast")

    local points = RandomPointsInCircle(casterPos, spawnRadius, numAreas, 100)
    for _, point in ipairs(points) do
        point.z = GetGroundHeight(point, nil) + 20

        local delay = RandomFloat(self:GetLevelSpecialValueFor("delay", 0), self:GetLevelSpecialValueFor("delay", 1))
        ShowGenericCircleWarning(point, areaRadius, delay)
        Timers:CreateTimer(delay, function()
            local pfx = ParticleManager:CreateParticle(
                "particles/george1_stalactite.vpcf",
                PATTACH_WORLDORIGIN, nil)
            ParticleManager:SetParticleControl(pfx, 0, point)
            local start = Vector(point.x, point.y, 5000)
            ParticleManager:SetParticleControl(pfx, 6, start)
            ParticleManager:ReleaseParticleIndex(pfx)

            ScreenShake(point, 10, 5, 0.5, 1000, 0, true)

            EmitSoundOnLocationWithCaster(point, "ability.george1.stalactites.hit", caster)

            local enemies = FindEnemiesForAIInRadius(point, areaRadius)
            for _, ent in ipairs(enemies) do
                ApplyDamage({
                    victim = ent,
                    attacker = caster,
                    damage = damage,
                    damage_type = self:GetAbilityDamageType(),
                    ability = self,
                })
            end
        end)
    end
end
