LinkLuaModifier("modifier_flower_heal", "abilities/jungle/perdun_flower_passive", LUA_MODIFIER_MOTION_NONE)

perdun_flower_passive = class({})


function perdun_flower_passive:GetIntrinsicModifierName()
    return "modifier_flower_heal"
end

----------

modifier_flower_heal = class({})

function modifier_flower_heal:IsHidden() return false end

function modifier_flower_heal:IsPurbable() return false end

function modifier_flower_heal:IsDebuff() return false end

function modifier_flower_heal:OnCreated()
    if not IsServer() then return end
    local abil = self:GetAbility()
    self.healPerSec = 50
    if abil then
        self.healPerUnit = abil:GetSpecialValueFor('healAmountPerUnit')
    end
    self:StartIntervalThink(1.0)
end

function modifier_flower_heal:OnIntervalThink()
    if not IsServer() then return end
    local abil = self:GetAbility()
    local parent = self:GetParent()
    if not parent.packTargetData then return end
    local beaconData = parent.packTargetData
    local units = FindUnitsInRadius(
        parent:GetTeamNumber(),
        beaconData.pos,
        nil,
        beaconData.rangeRetreat,
        DOTA_UNIT_TARGET_TEAM_FRIENDLY,
        DOTA_UNIT_TARGET_ALL,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_CLOSEST,
        false
    )
    local flowersAlive = 0
    for _, unit in pairs(units) do
        if unit:GetUnitName() == beaconData.flower then
            flowersAlive = flowersAlive + 1
        end
    end
    if flowersAlive == 0 then
        EmitSoundOn("JunglePerdun.FlowersDead", parent)
        self:Destroy()
    end
    local healThatTick = self.healPerUnit * flowersAlive
    parent:Heal(healThatTick, abil)

    local pfx = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, parent)
    ParticleManager:ReleaseParticleIndex(pfx)
    SendOverheadEventMessage(nil, OVERHEAD_ALERT_HEAL, parent, healThatTick, nil)
end
