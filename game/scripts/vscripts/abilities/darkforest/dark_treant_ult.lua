LinkLuaModifier('modifier_dark_treant_ult_rooted', 'abilities/darkforest/dark_treant_ult', LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier('modifier_treant_summon_spawning', 'abilities/darkforest/dark_treant_ult', LUA_MODIFIER_MOTION_NONE)
dark_treant_ult = class({})

function dark_treant_ult:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local radius = self:GetSpecialValueFor('radius') or 800
    local duration = self:GetSpecialValueFor('rootDuration') or 3.0
    local initialDamage = self:GetSpecialValueFor('initialDamage') or 150
    local numSummons = self:GetSpecialValueFor('numSummons') or 4
    local summonLifetime = self:GetSpecialValueFor('summonLifetime') or 20.0
    local summonName = "npc_dark_treant_summon"
    local summonRadius = self:GetSpecialValueFor('summonRadius')

    EmitSoundOn('Hero_Treant.Overgrowth.Cast', caster)
    local pfx = ParticleManager:CreateParticle('particles/units/heroes/hero_treant/treant_overgrowth_cast.vpcf',
        PATTACH_ABSORIGIN, caster)
    ParticleManager:ReleaseParticleIndex(pfx)
    local enemies = FindEnemiesForAIInRadius(caster:GetAbsOrigin(), radius)
    for _, enemy in ipairs(enemies) do
        local damageTable = {
            victim = enemy,
            attacker = caster,
            damage = initialDamage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self,
        }
        ApplyDamage(damageTable)
        enemy:AddNewModifier(caster, self, 'modifier_dark_treant_ult_rooted', { duration = duration })
    end
    for i = 1, numSummons do
        local randomOffset = RandomVector(RandomFloat(100, summonRadius))
        local spawnPos = caster:GetAbsOrigin() + randomOffset
        local summon = CreateUnitByName(
            summonName,
            spawnPos,
            true,
            caster,
            caster,
            caster:GetTeamNumber()
        )
        if summon then
            summon:AddNewModifier(summon, nil, 'modifier_treant_summon_spawning', { duration = 3.0 })
            local pfx = ParticleManager:CreateParticle(
                "particles/econ/items/natures_prophet/natures_prophet_weapon_sufferwood/furion_teleport_end_team_sufferwood_model.vpcf",
                PATTACH_WORLDORIGIN, summon)
            ParticleManager:SetParticleControl(pfx, 1, summon:GetAbsOrigin())
            ParticleManager:ReleaseParticleIndex(pfx)

            if summonLifetime > 0 then
                summon:AddNewModifier(caster, self, "modifier_kill", { duration = summonLifetime })
            end
            summon:AddNewModifier(summon, nil, 'modifier_default_creep_ai', {})
            summon.spawnPos = summon:GetAbsOrigin()
            summon.spawnForward = summon:GetForwardVector()
            summon.ai_modifier = "modifier_default_creep_ai"
            summon.spawnerName = nil
            local packName = "pack_darkforest_act3_treant"
            PackManager:AddUnit(packName, summon)
        end
    end
end

---------------------------
---
modifier_dark_treant_ult_rooted = class({})
function modifier_dark_treant_ult_rooted:IsPurgable()
    return true
end

function modifier_dark_treant_ult_rooted:IsDebuff()
    return true
end

function modifier_dark_treant_ult_rooted:CheckState()
    return {
        [MODIFIER_STATE_ROOTED] = true
    }
end

function modifier_dark_treant_ult_rooted:OnCreated()
    if not IsServer() then return end
    local parent = self:GetParent()
    EmitSoundOn('Hero_Treant.Overgrowth.Target', parent)
    local pfx = ParticleManager:CreateParticle('particles/units/heroes/hero_treant/treant_overgrowth_vines.vpcf',
        PATTACH_ABSORIGIN, parent)
    ParticleManager:ReleaseParticleIndex(pfx)
end

-----------------------------
---
modifier_treant_summon_spawning = class({})
function modifier_treant_summon_spawning:IsPurgable()
    return false
end

function modifier_treant_summon_spawning:IsHidden()
    return true
end

function modifier_treant_summon_spawning:IsDebuff()
    return false
end

function modifier_treant_summon_spawning:CheckState()
    return {
        [MODIFIER_STATE_ROOTED] = true,
        [MODIFIER_STATE_INVISIBLE] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_FROZEN] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_ATTACK_IMMUNE] = true,
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_DISARMED] = true,
    }
end
