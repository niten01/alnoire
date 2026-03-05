modifier_goden_ai = class({})

function modifier_goden_ai:IsHidden() return true end

function modifier_goden_ai:IsPurgable() return false end

function modifier_goden_ai:OnIntervalThink()
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
        if CastRandomAvailableAbility(unit, target, {
                "goden_tentacles",
                "goden_spin",
                "goden_slam",
                "goden_skewer",
            }) then
            return
        end
        -- if CastAbility(unit, target, "goden_tentacles") then return end
        -- if CastAbility(unit, target, "goden_spin") then return end
        -- if CastAbility(unit, target, "goden_slam") then return end
        if CastAbility(unit, target, "goden_summon") then return end
        -- if CastAbility(unit, target, "goden_skewer") then return end

        if not unit:GetAggroTarget() and not unit:IsCommandRestricted() then
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
                Position = target:GetAbsOrigin(),
                Queue = false,
            })
        end
    end
end
