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
    local point = casterPos + fwd * offset
    local safePoint = GetSafeBlinkDestination(casterPos, point, offset)
    if offset - #(safePoint - casterPos) < 10 then
        safePoint = casterPos - fwd * offset
    end
    safePoint = GetClearSpaceForUnit(caster, point)

    local pfx = ParticleManager:CreateParticle("particles/logarithmus_alt_anchor.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, safePoint)

    Timers:CreateTimer(self:GetSpecialValueFor("delay"), function()
        ParticleManager:DestroyParticle(pfx, false)
        ParticleManager:ReleaseParticleIndex(pfx)
        local enemies = FindEnemiesForSanyaInRadius(safePoint, self:GetSpecialValueFor("radius"))
        for _, ent in pairs(enemies) do
            ApplyDamage({
                victim = ent,
                attacker = caster,
                damage = self:GetAbilityDamage(),
                damage_type = self:GetAbilityDamageType(),
                ability = self,
            })
        end
    end)
end
