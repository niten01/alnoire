goden_summon = class {}

function goden_summon:OnAbilityPhaseStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    caster:EmitSound("ability.goden.summon.cast.roar")
end

function goden_summon:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local spawnDelay = 0.3
    local spawnInterval = 0.5

    local spawners = {
        "spawner_goden_summon_1",
        "spawner_goden_summon_2",
        "spawner_goden_summon_3",
        "spawner_goden_summon_4",
        "spawner_goden_summon_5",
    }

    for i, spawner in ipairs(spawners) do
        local ent = Entities:FindByName(nil, spawner)
        assert(ent, "Add " .. spawner .. "spawner, dumbass")
        local pos = ent:GetAbsOrigin()
        pos.z = GetGroundHeight(pos, nil)

        Timers:CreateTimer(spawnInterval * (i - 1), function()
            local pfx = ParticleManager:CreateParticle(
                "particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_splash_fxset.vpcf",
                PATTACH_WORLDORIGIN, nil)
            ParticleManager:SetParticleControl(pfx, 0, pos)
            ParticleManager:ReleaseParticleIndex(pfx)

            EmitSoundOnLocationWithCaster(pos, "ability.goden.summon.cast.water", caster)

            Timers:CreateTimer(spawnDelay, function()
                SpawnManager:SpawnNPC(spawner)
                EmitSoundOnLocationWithCaster(pos, "ability.goden.summon.spawn", caster)
            end)
        end)
    end
end
