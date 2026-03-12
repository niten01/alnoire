derek_axes = class {}

function derek_axes:OnAbilityPhaseStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local zOffset = 100
    local startPos = casterPos + Vector(0, 0, zOffset)

    local targetPos = self:GetCursorPosition()
    local v = targetPos - startPos
    local dir = v:Normalized()
    local endOffset = RandomFloat(self:GetLevelSpecialValueFor("end_target_offset", 0),
        self:GetLevelSpecialValueFor("end_target_offset", 1))
    local dist = #v + endOffset
    local endPos = startPos + dir * dist
    local midPoint = startPos + dir * (dist / 2)
    local side = dir:Cross(Vector(0, 0, 1)):Normalized()
    local spread = self:GetSpecialValueFor("spread")
    local mid1, mid2 = midPoint + side * spread, midPoint - side * spread

    self.curves = {
        PointsParabola(startPos, mid1, endPos),
        PointsParabola(startPos, mid2, endPos),
    }

    local radius = self:GetSpecialValueFor("radius")
    ShowGenericCurveWarning(self.curves[1], radius, self:GetCastPoint())
    ShowGenericCurveWarning(self.curves[2], radius, self:GetCastPoint())
end

function derek_axes:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    assert(self.curves)

    caster:EmitSound("ability.derek.axes.cast")
    caster:EmitSound("derek.vo.grunt")

    local time = self:GetSpecialValueFor("fly_time_oneway")
    for _, curve in pairs(self.curves) do
        local arcIter = curve:UnstableIteratorElapsed()
        local curPoint = arcIter()
        local pfx = ParticleManager:CreateParticle(
            "particles/econ/items/beastmaster/mh_beastmaster/mh_beastmaster_wildaxe.vpcf", PATTACH_WORLDORIGIN,
            nil)
        local destroy = function()
            ParticleManager:DestroyParticle(pfx, false)
            ParticleManager:ReleaseParticleIndex(pfx)
        end
        local startTime = GameRules:GetGameTime()
        local prevPoint = curPoint
        Timers:CreateTimer(0, function()
            curPoint.z = casterPos.z
            ParticleManager:SetParticleControl(pfx, 0, curPoint)

            local elapsed = GameRules:GetGameTime() - startTime
            prevPoint = curPoint
            curPoint = arcIter(elapsed / time)

            if curPoint then
                if self:DetectHit(curPoint, curPoint - prevPoint) then
                    destroy()
                    return nil
                end
                return 0.01
            end

            destroy()
            return nil
        end)
    end
end

function derek_axes:DetectHit(point, dir)
    local radius = self:GetSpecialValueFor("radius")
    local enemies = FindEnemiesForAIInRadius(point, radius)
    for _, ent in ipairs(enemies) do
        self:OnProjectileHit(ent, dir)
        return true
    end
end

function derek_axes:OnProjectileHit(target, dir)
    if not IsServer() then return end
    if not target then return end
    local caster = self:GetCaster()
    local damage = self:GetSpecialValueFor("axe_damage")
    local damageType = self:GetAbilityDamageType()
    ApplyDamage({
        victim = target,
        attacker = caster,
        damage = damage,
        damage_type = damageType,
        ability = self,
    })

    PlayDerekBloodEffects(target, dir)
end
