island_fiend_blink = class {}

function island_fiend_blink:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local targetPos = self:GetCursorPosition()
    local dist = (casterPos - targetPos):Length()
    local dir = (targetPos - casterPos):Normalized()
    targetPos = GetSafeBlinkDestination(casterPos, casterPos + dir * (dist - caster:GetHullRadius()))
    targetPos.z = GetGroundHeight(targetPos, caster)

    local pfx = ParticleManager:CreateParticle(
        "particles/econ/events/ti6/blink_dagger_start_ti6.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, casterPos)
    ParticleManager:ReleaseParticleIndex(pfx)

    pfx = ParticleManager:CreateParticle(
        "particles/econ/events/ti6/blink_dagger_end_ti6.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, targetPos)
    ParticleManager:ReleaseParticleIndex(pfx)

    EmitSoundOnLocationWithCaster(targetPos, "ability.island_fiend.blink", caster)

    FindClearSpaceForUnit(caster, targetPos, true)
end
