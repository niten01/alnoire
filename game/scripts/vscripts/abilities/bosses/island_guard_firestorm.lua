island_guard_firestorm = class {}

function island_guard_firestorm:ShowWarning()
    local caster = self:GetCaster()
    assert(caster)
    local casterPos = caster:GetAbsOrigin()
    self.points = PointsAlongRing(casterPos, 500, 5)

    for _, point in ipairs(self.points) do
        local pfx = ParticleManager:CreateParticle(
            "particles/units/heroes/heroes_underlord/underlord_firestorm_pre.vpcf", PATTACH_WORLDORIGIN, caster)
        ParticleManager:SetParticleControl(pfx, 0, point)
        ParticleManager:ReleaseParticleIndex(pfx)
    end

    caster:EmitSound("ability.island_guard.firestorm.warning")

    return 2
end

function island_guard_firestorm:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_POINT + DOTA_ABILITY_BEHAVIOR_AOE
end

function island_guard_firestorm:OnSpellStart()
    local caster = self:GetCaster()
    assert(caster)
    local radius = self:GetSpecialValueFor("radius")
    local damage = self:GetSpecialValueFor("damage")

    local attIdx = caster:ScriptLookupAttachment("attach_weapon")
    local pos = caster:GetAttachmentOrigin(attIdx)

    assert(self.points)
    for _, point in ipairs(self.points) do
        EmitSoundOnLocationWithCaster(point, "ability.island_guard.firestorm.hit", caster)

        local pfx = ParticleManager:CreateParticle(
            "particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave.vpcf", PATTACH_WORLDORIGIN, caster)
        ParticleManager:SetParticleControl(pfx, 0, point)
        ParticleManager:ReleaseParticleIndex(pfx)

        local enemies = FindEnemiesForAI(point, radius)
        for _, ent in ipairs(enemies) do
            ApplyDamage({
                victim = ent,
                attacker = caster,
                damage = damage,
                damage_type = DAMAGE_TYPE_MAGICAL,
                ability = self,
            })
        end
    end
end
