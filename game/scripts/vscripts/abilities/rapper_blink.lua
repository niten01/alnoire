rapper_blink = class {}

function rapper_blink:OnSpellStart()
    if not IsServer() then return end
    local caster      = self:GetCaster()
    local casterPos   = caster:GetAbsOrigin()
    local targetPos   = self:GetCursorPosition()

    local maxDistance = self:GetSpecialValueFor("range")
    local destination = GetSafeBlinkDestination(casterPos, targetPos, maxDistance)

    local pfx         = ParticleManager:CreateParticle(
        "particles/econ/events/fall_2022/blink/blink_dagger_fall_2022_start.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, casterPos)
    ParticleManager:ReleaseParticleIndex(pfx)

    pfx = ParticleManager:CreateParticle("particles/econ/events/fall_2022/blink/blink_dagger_end_fall2022.vpcf",
        PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, destination)
    ParticleManager:ReleaseParticleIndex(pfx)

    ExecuteOrderFromTable({
        UnitIndex = caster:entindex(),
        OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
        Position = destination,
        Queue = false
    })

    FindClearSpaceForUnit(caster, destination, true)
    ProjectileManager:ProjectileDodge(caster)
end

function rapper_blink:GetCastRange(vLocation, hTarget)
    if IsClient() then
        return self:GetSpecialValueFor("range")
    end
    return 0
end