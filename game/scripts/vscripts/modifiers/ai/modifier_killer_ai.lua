modifier_killer_ai = class({})

function modifier_killer_ai:IsHidden() return true end

function modifier_killer_ai:IsPurgable() return false end

function modifier_killer_ai:OnCreated()
    local parent = self:GetParent()
    self.waitProcast = false
end

function modifier_killer_ai:OnIntervalThink()
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
        if not target:HasModifier("modifier_killer_bind") then
            if CastAbility(unit, target, "killer_bind") then return end
        end
        if CastAbility(unit, target, "grimstroke_dark_artistry") then return end

        if not unit:GetAggroTarget() then
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                Position = target:GetAbsOrigin(),
                Queue = false,
            })
        end
    end
end
