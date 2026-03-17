george1_summon = class {}

function george1_summon:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local numSkeletons = self:GetSpecialValueFor("num_skeletons")
    local radius = self:GetSpecialValueFor("radius")

    caster:EmitSound("ability.george.summon.cast")

    for _, spawnerEnt in ipairs(Entities:FindAllByName("spawner_george_summon")) do
        local point = spawnerEnt:GetAbsOrigin()
        point.z = GetGroundHeight(point, nil)
        local pfx = ParticleManager:CreateParticle("particles/neutral_fx/skeleton_spawn.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(pfx, 0, point)
        ParticleManager:ReleaseParticleIndex(pfx)
    end

    SpawnManager:SpawnNPC("spawner_george_summon")
    -- CreateUnitByNameAsync(
    --     "npc_george_summon",
    --     point,
    --     true,
    --     nil,
    --     nil,
    --     DOTA_TEAM_BADGUYS,
    --     function(npc)
    --         npc:SetEntityName("npc_george_summon")
    --     end
    -- )
end
