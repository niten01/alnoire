gorilla_dash = class {}

function gorilla_dash:ShowWarning(targetPos)
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local dir = (targetPos - casterPos):Normalized()
    local distance = self:GetSpecialValueFor("distance")
    local delay = self:GetSpecialValueFor("warning_delay")
    local dest = GetSafeBlinkDestination(casterPos, casterPos + dir * distance, distance)
    self.targetPos = dest
    ShowGenericLineWarning(casterPos, self.targetPos, self:GetSpecialValueFor("capture_radius"), delay)
    return delay
end

function gorilla_dash:OnSpellStart()
    local caster = self:GetCaster()
    assert(caster)
    assert(self.targetPos)

    local radius = self:GetSpecialValueFor("capture_radius")
    local speed = self:GetSpecialValueFor("speed")
    local ummDuration = self:GetSpecialValueFor("umm_duration")
    local damage = self:GetSpecialValueFor("damage")
    local dir = (self.targetPos - caster:GetAbsOrigin())
    local time = #dir / speed
    caster:AddNewModifier(caster, self, "modifier_move", {
        directionX = dir.x,
        directionY = dir.y,
        speed = speed,
        duration = time,
        activity = ACT_DOTA_RUN,
    })

    local pfx = ParticleManager:CreateParticle(
        "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf", PATTACH_ABSORIGIN_FOLLOW,
        caster)
    ParticleManager:SetParticleControlEnt(pfx, 0, caster, PATTACH_ABSORIGIN_FOLLOW, "", Vector(300, 0, 0), true)

    local checkInterval = 0.1
    local remainingTime = time
    Timers:CreateTimer(0, function()
        local enemies = FindEnemiesForAIInRadius(caster:GetAbsOrigin(), radius)
        local someoneFound = false
        for _, ent in ipairs(enemies) do
            caster:RemoveModifierByName("modifier_move")
            if ent:IsSpiritBearCustom() then
                ent:Kill(self, caster)
            end
            ent:AddNewModifier(caster, self, "modifier_gorilla_umm", { duration = ummDuration, damage = damage })
            caster:AddNewModifier(caster, self, "modifier_gorilla_umm", { duration = ummDuration, damage = 0 })
            someoneFound = true
        end

        remainingTime = remainingTime - checkInterval
        if someoneFound or remainingTime <= 0 then
            ParticleManager:DestroyParticle(pfx, false)
            ParticleManager:ReleaseParticleIndex(pfx)
            return nil
        else
            return checkInterval
        end
    end)
end
