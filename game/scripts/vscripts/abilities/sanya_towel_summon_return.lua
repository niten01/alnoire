sanya_towel_summon_return = class({})

function sanya_towel_summon_return:Spawn()
    if IsServer() then
        self:SetLevel(1)
        self:SetHidden(true)
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