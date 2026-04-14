sanya_towel_summon = class({})

function sanya_towel_summon:Spawn()
    if IsServer() then
        self:SetLevel(1)
        local caster = self:GetCaster()
        caster.towel_summon = self
    end
end

function sanya_towel_summon:GetCooldown()
    return self:GetSpecialValueFor('cooldown')
end

function sanya_towel_summon:OnAbilityPhaseStart()
    local caster = self:GetCaster()
    local inFrontOfCaster = caster:GetAbsOrigin() + caster:GetForwardVector() * 100
    inFrontOfCaster = GetSafeBlinkDestination(caster:GetAbsOrigin(), inFrontOfCaster)
    local pfx = ParticleManager:CreateParticle("particles/sanya_summon_emerge.vpcf", PATTACH_WORLDORIGIN,
        self:GetCaster())
    ParticleManager:SetParticleControl(pfx, 0, inFrontOfCaster)
    ParticleManager:ReleaseParticleIndex(pfx)
    caster:EmitSound("ability.towel_master.towel_summon.buildup")

    self.summonSpawnPoint = inFrontOfCaster
end

function sanya_towel_summon:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local playerID = caster:GetPlayerOwnerID()
    assert(self.summonSpawnPoint)
    local unit = CreateUnitByName("towel_summon", self.summonSpawnPoint, true, caster, caster:GetOwner(),
        caster:GetTeamNumber())
    unit:SetControllableByPlayer(playerID, true)
    unit:SetOwner(caster)
    unit:SetIdleAcquire(false)
    caster.summon = unit


    UpgradeBear(self, unit)
    unit:AddNewModifier(caster, self, "modifier_summon_distance_check", {})
    unit:SetBaseMoveSpeed(caster:GetBaseMoveSpeed())
    local pfx = ParticleManager:CreateParticle("particles/creatures/aghanim/portal_summon_b0a.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, unit)
    ParticleManager:ReleaseParticleIndex(pfx)
    pfx = ParticleManager:CreateParticle("particles/sanya_summon_emerge_impact_smoke.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, unit)
    ParticleManager:ReleaseParticleIndex(pfx)

    unit:EmitSound("ability.towel_master.towel_summon.spawn")

    self:SetFrozenCooldown(true)
    caster:SwapAbilities("sanya_towel_summon", "sanya_towel_summon_return", false, true)
    local spell_return = caster:FindAbilityByName("sanya_towel_summon_return")
    if spell_return then
        spell_return:StartCooldown(0.5)
    end
end

function sanya_towel_summon:OnHeroLevelUp()
    local caster = self:GetCaster()
    local summon = caster.summon
    if not summon then return end
    UpgradeBear(self, summon)

    local level = caster:GetLevel()
    if TOWEL_MASTER_ULT_LEVELS[level] then
        local currentLevel = self:GetLevel()
        self:SetLevel(math.min(currentLevel + 1, self:GetMaxLevel()))
        local current_points = caster:GetAbilityPoints()
        if current_points > 0 then
            caster:SetAbilityPoints(current_points - 1)
        end
    end
end

function sanya_towel_summon:OnUpgrade()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local alt_skill = caster.towel_summon_return
    if alt_skill and alt_skill:GetLevel() < self:GetLevel() then
        alt_skill:SetLevel(self:GetLevel())
    end
    local summon = caster.summon
    if not summon then return end
    UpgradeBear(self, summon)
end

function sanya_towel_summon:GetCastRange()
    return self:GetSpecialValueFor('radius') or 1200
end

-- function sanya_towel_summon:UpgradeBear(bear)
--     if not bear then return end
--     local ab1 = bear:GetAbilityByIndex(0)
--     local ab2 = bear:GetAbilityByIndex(1)
--     local ab3 = bear:GetAbilityByIndex(2)
--     local targetLvl1 = self:GetSpecialValueFor("overpower_level")
--     local targetLvl2 = self:GetSpecialValueFor("dash_level")
--     local targetLvl3 = self:GetSpecialValueFor("explosion_level")
--     ab1:SetLevel(targetLvl1)
--     ab2:SetLevel(targetLvl2)
--     ab3:SetLevel(targetLvl3)
--     -- if ab_level == 1 then
--     --     return
--     -- end
--     -- if ab_level == 2 then
--     --     ab1:SetLevel(1)
--     --     ab2:SetLevel(1)
--     --     return
--     -- end
--     -- if ab_level == 3 then
--     --     ab1:SetLevel(2)
--     --     ab2:SetLevel(2)
--     --     ab3:SetLevel(1)
--     --     return
--     -- end
--     -- if ab_level == 4 then
--     --     ab1:SetLevel(2)
--     --     ab2:SetLevel(2)
--     --     ab3:SetLevel(2)
--     --     return
--     -- end
-- end
