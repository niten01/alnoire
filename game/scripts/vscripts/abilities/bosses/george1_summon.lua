george1_summon = class {}

function george1_summon:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local numSkeletons = self:GetSpecialValueFor("num_skeletons")
    local radius = self:GetSpecialValueFor("radius")

    caster:EmitSound("ability.george.summon.cast")

    local points = RandomPointsInCircle(casterPos, radius, numSkeletons, 200)
    for _, point in ipairs(points) do
        point.z = GetGroundHeight(point, nil)
        local pfx = ParticleManager:CreateParticle("particles/neutral_fx/skeleton_spawn.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(pfx, 0, point)
        ParticleManager:ReleaseParticleIndex(pfx)

        CreateUnitByNameAsync(
            "npc_george_summon",
            point,
            true,
            nil,
            nil,
            DOTA_TEAM_BADGUYS,
            function(npc) end
        )
    end
end
