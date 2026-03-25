logarithmus_alt_anchor = class {}

function logarithmus_alt_anchor:Spawn()
    if not IsServer() then return end
    self:SetHidden(true)
end

function logarithmus_alt_anchor:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local fwd = caster:GetForwardVector()
    local offset = self:GetSpecialValueFor("forward_offset")
    local altAnchorPos = casterPos + fwd * offset

    local pfx = ParticleManager:CreateParticle("particles/logarithmus_alt_anchor.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, altAnchorPos)

    EmitSoundOnLocationWithCasterSafe(altAnchorPos, "ability.logarithmus.alt_anchor.cast", caster)

    Timers:CreateTimer(self:GetSpecialValueFor("delay"), function()
        ParticleManager:DestroyParticle(pfx, false)
        ParticleManager:ReleaseParticleIndex(pfx)

        local pfx = ParticleManager:CreateParticle("particles/logarithmus_explosion.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(pfx, 0, altAnchorPos)
        ParticleManager:ReleaseParticleIndex(pfx)

        EmitSoundOnLocationWithCasterSafe(altAnchorPos, "ability.logarithmus.alt_anchor.hit", caster)

        local enemies = FindEnemiesForSanyaInRadius(altAnchorPos, self:GetSpecialValueFor("radius"))
        for _, ent in pairs(enemies) do
            PlayLogarithmusImpaleEffect(ent, altAnchorPos)
            ApplyDamage({
                victim = ent,
                attacker = caster,
                damage = self:GetAbilityDamage(),
                damage_type = self:GetAbilityDamageType(),
                ability = self,
            })
        end

        if #enemies > 0 then
            IncrementLogarithmusStacks(caster)
        end
    end)
end
