sanya_towel_summon = class({})

function sanya_towel_summon:Spawn()
    if IsServer() then
        self:SetLevel(1)
    end
end

function sanya_towel_summon:OnSpellStart()
    local caster = self:GetCaster()
    local playerID = caster:GetPlayerOwnerID()
    if caster.summon then
        if caster.summon:IsAlive() then
            FindClearSpaceForUnit(caster.summon, caster:GetAbsOrigin(), true)
            return
        end
        
    end


    local unit = CreateUnitByName("towel_summon", caster:GetAbsOrigin(), true, caster, caster:GetOwner(), caster:GetTeamNumber())
    unit:SetControllableByPlayer(playerID, true)
    unit:SetOwner(caster)
    caster.summon = unit
    unit:AddNewModifier(caster, self, "modifier_summon_distance_check", {})
    local pfx = ParticleManager:CreateParticle("particles/creatures/aghanim/portal_summon_b0a.vpcf", PATTACH_ABSORIGIN_FOLLOW, unit)
    ParticleManager:ReleaseParticleIndex(pfx)
    
end

