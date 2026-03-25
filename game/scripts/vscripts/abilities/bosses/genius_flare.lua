genius_flare = class {}

function genius_flare:ShowWarning(targetPos)
    local delay = self:GetSpecialValueFor("warning_delay")
    local areaRadius = self:GetSpecialValueFor("radius")
    ShowGenericCircleWarning(targetPos, areaRadius, delay)
    self.targetPos = targetPos
    return delay
end

function genius_flare:OnSpellStart()
    local caster = self:GetCaster()
    assert(caster)
    local areaRadius = self:GetSpecialValueFor("radius")
    local areaDuration = self:GetSpecialValueFor("duration")
    local tickRate = self:GetSpecialValueFor("tick_rate")

    assert(self.targetPos)
    self.pfx = {}
    EmitSoundOnLocationWithCasterSafe(self.targetPos, "ability.genius.flare.cast", caster)
    EmitSoundOnLocationWithCasterSafe(self.targetPos, "ability.genius.flare.loop", caster)

    local pfx = ParticleManager:CreateParticle(
        "particles/econ/items/skywrath_mage/skywrath_arcana/skywrath_arcana_mystic_flare_v2_ambient.vpcf",
        PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(pfx, 0, self.targetPos)
    ParticleManager:SetParticleControl(pfx, 1, Vector(areaRadius, areaDuration, tickRate))
    ParticleManager:ReleaseParticleIndex(pfx)

    local areaInfo = {
        pos = self.targetPos,
        remainingDuration = areaDuration
    }
    Timers:CreateTimer(0, function()
        return self:AreasThink(areaInfo)
    end)
end

function genius_flare:AreasThink(info)
    local tickRate = self:GetSpecialValueFor("tick_rate")
    local dps = self:GetSpecialValueFor("damage_per_second")
    local damage = dps * tickRate
    local areaRadius = self:GetSpecialValueFor("radius")

    local enemies = FindEnemiesForAIInRadius(info.pos, areaRadius)
    for _, ent in ipairs(enemies) do
        EmitSoundOnLocationForPlayer("ability.genius.flare.hit", ent:GetAbsOrigin(), ent:GetPlayerOwnerID())
        ApplyDamage({
            victim = ent,
            attacker = self:GetCaster(),
            damage = damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self
        })
    end

    info.remainingDuration = info.remainingDuration - tickRate
    if info.remainingDuration <= 0 then
        return nil
    else
        return tickRate
    end
end
