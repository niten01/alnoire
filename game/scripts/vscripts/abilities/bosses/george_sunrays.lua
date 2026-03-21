george_sunrays = class {}

function george_sunrays:OnAbilityPhaseStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local length = self:GetSpecialValueFor("length")
    local numRays = self:GetSpecialValueFor("num_rays")
    local width = self:GetSpecialValueFor("width")
    self.points = PointsAlongRing(casterPos, length, numRays, RandomFloat(0, math.pi))

    for _, point in ipairs(self.points) do
        ShowGenericLineWarning(casterPos, point, width, self:GetCastPoint())
    end
end

function george_sunrays:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local length = self:GetSpecialValueFor("length")
    local width = self:GetSpecialValueFor("width")
    assert(self.points)
    local interval = 0.03
    local angleStep = self:GetSpecialValueFor("angular_velocity") * interval
    local damage = self:GetSpecialValueFor("dps") * interval

    self.stop = false

    local hitlocIdx = caster:ScriptLookupAttachment("attach_hitloc")
    local hitloc = caster:GetAttachmentOrigin(hitlocIdx)

    caster:EmitSound("ability.george.sunrays.cast")
    caster:EmitSound("ability.george.sunrays.loop")
    Timers:CreateTimer(self:GetChannelTime(), function()
        caster:StopSound("ability.george.sunrays.loop")
    end)

    self.timers = {}

    for _, point in ipairs(self.points) do
        point.z = hitloc.z
        local angle = math.atan2(point.y - casterPos.y, point.x - casterPos.x)

        local pfx = ParticleManager:CreateParticle("particles/george_ray.vpcf",
            PATTACH_ABSORIGIN_FOLLOW, caster)
        ParticleManager:SetParticleControlEnt(pfx, 0, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0),
            false)
        ParticleManager:SetParticleControlEnt(pfx, 9, caster, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0),
            false)
        ParticleManager:SetParticleControl(pfx, 1, point)

        local tid = Timers:CreateTimer(interval, function()
            angle = angle + angleStep

            point.x = casterPos.x + length * math.cos(angle)
            point.y = casterPos.y + length * math.sin(angle)

            ParticleManager:SetParticleControl(pfx, 1, point)

            local enemies = FindEnemiesForAIInLine(casterPos, point, width)
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

            if self.stop then
                ParticleManager:DestroyParticle(pfx, false)
                ParticleManager:ReleaseParticleIndex(pfx)
                return nil
            end
            return interval
        end)
        table.insert(self.timers, tid)
    end
end

function george_sunrays:OnChannelFinish(bInterrupted)
    if not IsServer() then return end

    self.stop = true
    local caster = self:GetCaster()
    caster:StopSound("ability.george.sunrays.loop")
end
