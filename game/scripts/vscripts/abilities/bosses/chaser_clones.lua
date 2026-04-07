chaser_clones = class({})

function chaser_clones:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local numSummons = self:GetSpecialValueFor('numSummons') or 4
    local summonLifetime = self:GetSpecialValueFor('summonLifetime') or 20.0
    local summonName = "npc_chaser_clone"
    local summonRadius = self:GetSpecialValueFor('summonRadius')

    caster:EmitSound("chaser.disappear")
    caster:EmitSound("chaser.laugh")
    local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_chaos_knight/chaos_knight_phantasm.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, caster)
    Timers:CreateTimer(1, function()
        ParticleManager:DestroyParticle(pfx, false)
        ParticleManager:ReleaseParticleIndex(pfx)
        local pfx = ParticleManager:CreateParticle(
            "particles/units/heroes/hero_chaos_knight/chaos_knight_reality_rift.vpcf", PATTACH_ABSORIGIN, caster)
        ParticleManager:SetParticleControl(pfx, 1, caster:GetAbsOrigin())
        ParticleManager:SetParticleControlTransform(pfx, 2, caster:GetAbsOrigin(), VectorToAngles(Vector(0, -90, 0)))
        ParticleManager:ReleaseParticleIndex(pfx)
    end)
    for i = 1, numSummons do
        local randomOffset = RandomVector(RandomFloat(100, summonRadius))
        local spawnPos = caster:GetAbsOrigin() + randomOffset
        spawnPos = GetSafeBlinkDestination(caster:GetAbsOrigin(), spawnPos, nil)
        local summon = CreateUnitByName(
            summonName,
            spawnPos,
            true,
            caster,
            caster,
            caster:GetTeamNumber()
        )
        if summon then
            if summonLifetime > 0 then
                summon:AddNewModifier(caster, self, "modifier_kill", { duration = summonLifetime })
            end
            summon:AddNewModifier(summon, nil, 'modifier_default_creep_ai', {})
            summon.spawnPos = summon:GetAbsOrigin()
            summon.spawnForward = summon:GetForwardVector()
            summon.ai_modifier = "modifier_default_creep_ai"
            summon.spawnerName = nil
            local packName = "pack_chaser"
            PackManager:AddUnit(packName, summon)
        end
    end
end

---------------------------
--
