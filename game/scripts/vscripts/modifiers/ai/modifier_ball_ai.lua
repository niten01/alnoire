modifier_ball_ai = class({})

function modifier_ball_ai:IsHidden() return true end

function modifier_ball_ai:IsPurgable() return false end

function modifier_ball_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return end
    local beaconState = beaconData.state
    local target = beaconData.target

    if DefaultAiTick(unit) then
        if beaconData.state == "retreat" then
            PackManager:ResetPackPosition("pack_ball")
        end
        AdjustTickRate(unit)
        self:StartIntervalThink(beaconData.currentCreepInterval)
        return
    end

    if beaconState == 'aggro' and target and target:IsAlive() then
        if CastAbility(unit, target, "ball_jump") then return end
        if CastAbility(unit, target, "ball_dash") then return end
    end
end
