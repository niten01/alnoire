modifier_derek_ai = class({})

function modifier_derek_ai:IsHidden() return true end

function modifier_derek_ai:IsPurgable() return false end

function modifier_derek_ai:OnCreated()
    local parent = self:GetParent()
end

function modifier_derek_ai:ResetState()
    self.phase = 1
end

modifier_derek_ai.OnCreated = modifier_derek_ai.ResetState

function modifier_derek_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return end
    local beaconState = beaconData.state
    local target = beaconData.target

    if DefaultAiTick(unit) then
        if beaconData.state == "retreat" then
            self:ResetState()
        end
        AdjustTickRate(unit)
        self:StartIntervalThink(beaconData.currentCreepInterval)
        return
    end

    if beaconState == 'aggro' and target and target:IsAlive() then
        if self.phase == 1 then
            self:Phase1(unit, target)
        end
    end
end

function modifier_derek_ai:Phase1(unit, target)
    if unit.derekCasting then return end

    local distToTarget = #(unit:GetAbsOrigin() - target:GetAbsOrigin())
    local isClose = distToTarget <= 600

    if CastAbility(unit, target, "derek_epicenter") then return end
    if CastAbility(unit, target, "derek_strafe") then return end
    if CastAbility(unit, target, "derek_axe_fury") then return end
    if CastAbility(unit, target, "derek_lift", 0) then return end

    if isClose then
        if CastAbility(unit, target, "derek_rebound") then return end
    else
        if CastAbility(unit, target, "derek_axes") then return end
        if CastAbility(unit, target, "derek_slice") then return end
    end
end
