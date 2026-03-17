george_puddles = class {}

function george_puddles:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local numAreas = self:GetSpecialValueFor("num_areas")
    local areaRadius = self:GetSpecialValueFor("area_radius")
    local spawnRadius = self:GetSpecialValueFor("spawn_radius")
    local duration = self:GetSpecialValueFor("duration")
    local warningDelay = self:GetSpecialValueFor("warning_delay")
    local dps = self:GetSpecialValueFor("dps")
    local interval = 0.1
    local damage = dps * interval

    local points = RandomPointsInCircle(casterPos, spawnRadius, numAreas, areaRadius)

    for _, point in ipairs(points) do
        point.z = GetGroundHeight(point, nil)

        local startTime = RandomFloat(self:GetLevelSpecialValueFor("start_delay", 0),
            self:GetLevelSpecialValueFor("start_delay", 1))

        Timers:CreateTimer(startTime - warningDelay, function()
            ShowGenericCircleWarning(point, areaRadius, warningDelay)
        end)

        local pfx = nil
        local start = GameRules:GetGameTime()
        Timers:CreateTimer(startTime, function()
            if not pfx then
                pfx = ParticleManager:CreateParticle("particles/george_puddle.vpcf", PATTACH_WORLDORIGIN, nil)
                ParticleManager:SetParticleControl(pfx, 0, point)
                ParticleManager:SetParticleControl(pfx, 10, Vector(areaRadius, 0, 0))

                EmitSoundOnLocationWithCaster(point, "ability.george.puddles.spawn", caster)
            end

            local enemies = FindEnemiesForAIInRadius(point, areaRadius)
            for _, ent in ipairs(enemies) do
                ApplyDamage({
                    victim = ent,
                    attacker = caster,
                    damage = damage,
                    damage_type = self:GetAbilityDamageType(),
                    ability = self,
                })
                ApplyGeorgeBurn(ent, self)
            end

            local elapsed = GameRules:GetGameTime() - start
            if elapsed > duration + startTime then
                ParticleManager:DestroyParticle(pfx, false)
                ParticleManager:ReleaseParticleIndex(pfx)
                return nil
            else
                return interval
            end
        end)
    end
end
