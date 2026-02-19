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

function sanya_towel_summon:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local playerID = caster:GetPlayerOwnerID()
    local unit = CreateUnitByName("towel_summon", caster:GetAbsOrigin(), true, caster, caster:GetOwner(), caster:GetTeamNumber())
    unit:SetControllableByPlayer(playerID, true)
    unit:SetOwner(caster)
    unit:SetIdleAcquire(false)
    caster.summon = unit


    self:UpgradeBear(self, unit)
    unit:AddNewModifier(caster, self, "modifier_summon_distance_check", {})
    unit:SetBaseMoveSpeed(caster:GetBaseMoveSpeed())
    local pfx = ParticleManager:CreateParticle("particles/creatures/aghanim/portal_summon_b0a.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
    ParticleManager:ReleaseParticleIndex(pfx)
    pfx = ParticleManager:CreateParticle("particles/sanya_summon_emerge.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
    ParticleManager:ReleaseParticleIndex(pfx)
    caster:EmitSound("ability.towel_master.towel_summon.spawn")
    self:SetFrozenCooldown(true)
    caster:SwapAbilities("sanya_towel_summon", "sanya_towel_summon_return", false, true)
    local spell_return = caster:FindAbilityByName("sanya_towel_summon_return")
    if spell_return then
        spell_return:StartCooldown(0.5)
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
    self:UpgradeBear(self, summon)
end

function sanya_towel_summon:GetCastRange()
    return self:GetSpecialValueFor('radius') or 1200
end

function sanya_towel_summon:UpgradeBear(ability, bear)
    if not ability or not bear then return end
    local ab_level = ability:GetLevel()
    local ab1 = bear:GetAbilityByIndex(0)
    local ab2 = bear:GetAbilityByIndex(1)
    local ab3 = bear:GetAbilityByIndex(2)
    if ab_level == 1 then
        return
    end
    if ab_level == 2 then
        ab1:SetLevel(1)
        ab2:SetLevel(1)
        return
    end
    if ab_level == 3 then
        ab1:SetLevel(2)
        ab2:SetLevel(2)
        ab3:SetLevel(1)
        return
    end
    if ab_level == 4 then
        ab1:SetLevel(2)
        ab2:SetLevel(2)
        ab3:SetLevel(2)
        return
    end
end
