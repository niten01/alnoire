sanya_towel_summon_return = class({})

function sanya_towel_summon_return:Spawn()
    if IsServer() then
        self:SetLevel(1)
        self:SetHidden(true)
        local caster = self:GetCaster()
        caster.towel_summon_return = self
    end
end

function sanya_towel_summon_return:GetCastRange()
    local caster = self:GetCaster()
    local pair_abil = caster:FindAbilityByName('sanya_towel_summon')
    if not pair_abil then return end
    return pair_abil:GetCastRange() or 100
end

function sanya_towel_summon_return:OnSpellStart()
    local caster = self:GetCaster()
    if caster.summon and caster.summon:IsAlive() then
        self.channel_pfx_owner = ParticleManager:CreateParticle("particles/econ/events/fall_2021/agh_aura_fall_2021_parent.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        self.channel_pfx_summon = ParticleManager:CreateParticle("particles/econ/events/fall_2022/agh/agh_aura_fall2022_lvl2.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster.summon)
        caster:StartGestureWithPlaybackRate(ACT_DOTA_DISABLED, 0.25)
    end
end

function sanya_towel_summon_return:OnUpgrade()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local alt_skill = caster.towel_summon
    if alt_skill and alt_skill:GetLevel() < self:GetLevel() then
        alt_skill:SetLevel(self:GetLevel())
    end
    
end

function sanya_towel_summon_return:OnChannelFinish(bInterrupted)
    local caster = self:GetCaster()
    caster:FadeGesture( ACT_DOTA_DISABLED )
    if self.channel_pfx_owner then
        ParticleManager:DestroyParticle(self.channel_pfx_owner, true)
        ParticleManager:ReleaseParticleIndex(self.channel_pfx_owner)
        self.channel_pfx_owner = nil
    end

    if self.channel_pfx_summon then
        ParticleManager:DestroyParticle(self.channel_pfx_summon, true)
        ParticleManager:ReleaseParticleIndex(self.channel_pfx_summon)
        self.channel_pfx_summon = nil
    end

    if not bInterrupted then
        if caster.summon and caster.summon:IsAlive() then
            local spawn_pos = caster:GetAbsOrigin() + caster:GetForwardVector() * -150
            FindClearSpaceForUnit(caster.summon, spawn_pos, true)
            -- caster.summon:StartGesture( ACT_DOTA_SPAWN )
            local pfx = ParticleManager:CreateParticle("particles/econ/events/fall_2022/blink/blink_dagger_fall_2022_embers.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster.summon)
            ParticleManager:ReleaseParticleIndex(pfx)
            ParticleManager:DestroyParticle(pfx, true)
        end

    else
        local pfx_interrupted = ParticleManager:CreateParticle("particles/econ/items/antimage_female/monsterhunter_kirin/antimage_manabreak_slow_body_flash.vpcf", PATTACH_POINT_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(pfx_interrupted)
    end
end
