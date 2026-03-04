logarithmus_alt_step = class {}
LinkLuaModifier("modifier_logarithmus_alt_step", "abilities/logarithmus_alt_step", LUA_MODIFIER_MOTION_NONE)

function logarithmus_alt_step:GetCastRange(vLocation, hTarget)
    if IsClient() then
        return self:GetSpecialValueFor("dash_range")
    end
    return 0
end


function logarithmus_alt_step:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()

    local blinkPos = self:GetCursorPosition()
    blinkPos.z = casterPos.z
    blinkPos = GetSafeBlinkDestination(casterPos, blinkPos, self:GetSpecialValueFor("dash_range"))

    -- local pfx = ParticleManager:CreateParticle("particles/logarithmus_step_simplified.vpcf", PATTACH_ABSORIGIN, caster)
    -- ParticleManager:SetParticleControl(pfx, 0, casterPos)
    -- ParticleManager:SetParticleControl(pfx, 1, blinkPos)
    -- ParticleManager:ReleaseParticleIndex(pfx)

    local hitPos = blinkPos + vDirection * self:GetVectorTargetRange()
    hitPos.z = casterPos.z

    caster:SetAbsOrigin(blinkPos)
    FindClearSpaceForUnit(caster, blinkPos, true)
    caster:SetForwardVector(vDirection)
    caster:FaceTowards(hitPos)

    pfx = ParticleManager:CreateParticle("particles/logarithmus_step.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, blinkPos)
    ParticleManager:SetParticleControl(pfx, 1, hitPos)
    ParticleManager:ReleaseParticleIndex(pfx)

    PlayLogarithmusBladeEffect(caster, 1.0)

    local enemies = FindEnemiesForSanyaInLine(blinkPos, hitPos, self:GetSpecialValueFor("stab_width"))
    for _, ent in ipairs(enemies) do
        PlayLogarithmusImpaleEffect(ent, blinkPos)
        ApplyDamage({
            victim = ent,
            attacker = caster,
            damage = self:GetAbilityDamage(),
            damage_type = self:GetAbilityDamageType(),
            ability = self,
        })
    end
end


------------------------------------------------------------------

modifier_logarithmus_alt_step = class {}


