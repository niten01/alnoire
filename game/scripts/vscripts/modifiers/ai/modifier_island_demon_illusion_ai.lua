modifier_island_demon_illusion_ai = class({})

function modifier_island_demon_illusion_ai:IsHidden() return true end

function modifier_island_demon_illusion_ai:IsPurgable() return false end

function modifier_island_demon_illusion_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return end
    local beaconState = beaconData.state
    local target = beaconData.target

    if DefaultAiTick(unit) then
        AdjustTickRate(unit)
        self:StartIntervalThink(beaconData.currentCreepInterval)
        return
    end

    if beaconState == 'aggro' and target and target:IsAlive() then
        if CastAbility(unit, target, "island_demon_poison") then return end
    end
end
