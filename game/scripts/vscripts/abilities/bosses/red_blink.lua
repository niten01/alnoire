red_blink = class {}

function red_blink:ShowWarning()
    local delay = 0.3
    local radius = self:GetSpecialValueFor("radius")
    ShowGenericCircleWarning(self:GetCaster():GetAbsOrigin(), radius, delay)
    return delay
end

function red_blink:OnSpellStart()
    local caster = self:GetCaster()
    local radius = self:GetSpecialValueFor("radius")
    local damage = self:GetSpecialValueFor("damage")

    local pfx = ParticleManager:CreateParticle(
        "particles/econ/items/lina/lina_ti7/lina_spell_light_strike_array_ti7_gold.vpcf", PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
    ParticleManager:SetParticleControl(pfx, 1, Vector(radius, 10, 1))
    ParticleManager:ReleaseParticleIndex(pfx)
    EmitSoundOnLocationWithCasterSafe(caster:GetAbsOrigin(), "ability.red.blink.cast", caster)

    local enemies = FindEnemiesForAIInRadius(caster:GetAbsOrigin(), radius)
    for _, ent in ipairs(enemies) do
        ApplyDamage({
            victim = ent,
            attacker = self:GetCaster(),
            damage = damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self
        })
    end

    caster:SetAbsOrigin(self:GetCursorPosition())
    local pfx = ParticleManager:CreateParticle(
        "particles/econ/items/lina/lina_ti7/lina_spell_light_strike_array_ti7_gold.vpcf", PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
    ParticleManager:SetParticleControl(pfx, 1, Vector(radius, 10, 5))
    ParticleManager:ReleaseParticleIndex(pfx)
    EmitSoundOnLocationWithCasterSafe(caster:GetAbsOrigin(), "ability.red.blink.cast", caster)
end
