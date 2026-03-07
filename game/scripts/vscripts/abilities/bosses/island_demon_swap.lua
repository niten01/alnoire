island_demon_swap = class {}

function island_demon_swap:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()

    local allies = FindEnemiesForSanyaInRadius(casterPos, 9999)
    local illusions = {}
    for _, ally in pairs(allies) do
        if ally:GetName() == "npc_island_demon_illusion" then
            table.insert(illusions, ally)
        end
    end

    if #illusions == 0 then return end

    local randIdx = RandomInt(1, #illusions)
    local target = illusions[randIdx]
    local targetPos = target:GetAbsOrigin()

    local pfx = ParticleManager:CreateParticle(
        'particles/econ/items/vengeful/vengeful_arcana/vengeful_arcana_nether_swap_v3.vpcf', PATTACH_ABSORIGIN, caster)
    ParticleManager:SetParticleControl(pfx, 1, targetPos)
    ParticleManager:ReleaseParticleIndex(pfx)

    pfx = ParticleManager:CreateParticle(
        'particles/econ/items/vengeful/vengeful_arcana/vengeful_arcana_nether_swap_v3.vpcf', PATTACH_ABSORIGIN, target)
    ParticleManager:SetParticleControl(pfx, 1, casterPos)
    ParticleManager:ReleaseParticleIndex(pfx)

    target:SetAbsOrigin(casterPos)
    caster:SetAbsOrigin(targetPos)
end
