sanya_towel_summon_return = class({})

function sanya_towel_summon_return:Spawn()
    if IsServer() then
        self:SetLevel(1)
        self:SetHidden(true)
        local caster = self:GetCaster()
        caster.towel_summon_return = self
    end
end

function sanya_towel_summon_return:OnSpellStart()
    local caster = self:GetCaster()
    if caster.summon and caster.summon:IsAlive() then
        local spawn_pos = caster:GetAbsOrigin() + caster:GetForwardVector() * -150
        FindClearSpaceForUnit(caster.summon, spawn_pos, true)
        caster.summon:StartGesture( ACT_DOTA_SPAWN )
        local pfx = ParticleManager:CreateParticle("particles/econ/events/fall_2022/blink/blink_dagger_fall_2022_embers.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster.summon)
        ParticleManager:ReleaseParticleIndex(pfx)
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