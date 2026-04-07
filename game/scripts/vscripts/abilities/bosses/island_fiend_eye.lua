island_fiend_eye = class {}

function island_fiend_eye:ShowWarning(targetPos)
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local delay = self:GetSpecialValueFor("warning_delay")
    local radius = self:GetSpecialValueFor("proj_radius")
    local v = targetPos - casterPos
    v.z = 0
    local dist = #v
    local dir = v:Normalized()
    local midPoint = casterPos + dir * dist
    local endPos = casterPos + 2 * dir * dist
    local right = dir:Cross(Vector(0, 0, 1)):Normalized()
    local bias = RandomFloat(
        self:GetLevelSpecialValueFor("mid_spread_minmax", 0),
        self:GetLevelSpecialValueFor("mid_spread_minmax", 1)
    )

    self.curves = {
        PointsParabola(casterPos, midPoint, endPos),
        PointsParabola(casterPos, midPoint + right * bias, endPos),
        PointsParabola(casterPos, midPoint - right * bias, endPos),
    }

    for _, curve in ipairs(self.curves) do
        ShowGenericCurveWarning(curve, radius, delay + self:GetCastPoint())
    end

    return delay
end

function island_fiend_eye:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local radius = self:GetSpecialValueFor("proj_radius")
    local speed = self:GetSpecialValueFor("proj_speed")
    local damage = self:GetAbilityDamage()
    local zOffset = 30
    assert(self.curves)

    for _, curve in ipairs(self.curves) do
        local parabolaIter = curve:UnstableIterator()
        local point = casterPos
        local time = curve:Length() / speed
        point.z = casterPos.z + zOffset

        local pfx = ParticleManager:CreateParticle(
            "particles/econ/items/shadow_fiend/sf_desolation/sf_base_attack_desolation.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(pfx, 0, point)
        ParticleManager:SetParticleControl(pfx, 2, Vector(speed - 100, 0, 0))
        local function destroyPfx()
            ParticleManager:DestroyParticle(pfx, false)
            ParticleManager:ReleaseParticleIndex(pfx)
        end

        local point = parabolaIter()
        local prevTime = GameRules:GetGameTime()
        Timers:CreateTimer(0, function()
            point.z = casterPos.z + zOffset
            ParticleManager:SetParticleControl(pfx, 1, point)

            local enemies = FindEnemiesForAIInRadius(point, radius)
            for _, ent in ipairs(enemies) do
                ApplyDamage({
                    victim = ent,
                    attacker = caster,
                    damage = damage,
                    damage_type = DAMAGE_TYPE_MAGICAL,
                    ability = self,
                })

                shadowraze.ApplyModifier(self, ent, self:GetSpecialValueFor("raze_stacks_per_hit"))
                destroyPfx()
                return nil
            end

            local curTime = GameRules:GetGameTime()
            local dt = curTime - prevTime
            prevTime = curTime
            point = parabolaIter(dt / time)
            if not point then
                destroyPfx()
                return nil
            end

            return 0.01
        end)
    end
end
