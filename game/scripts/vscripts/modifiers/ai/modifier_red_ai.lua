modifier_red_ai = class({})

function modifier_red_ai:IsHidden() return true end

function modifier_red_ai:IsPurgable() return false end

function modifier_red_ai:OnCreated()
    self.blinkLeftTarget = Entities:FindByName(nil, "red_blink_left")
    self.blinkRightTarget = Entities:FindByName(nil, "red_blink_right")
    assert(self.blinkLeftTarget and self.blinkRightTarget, "No npc_red blink targets, add them, or use a proper map")

    self.blinkUsed = false
end

function modifier_red_ai:OnIntervalThink()
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
        if unit:HasModifier("modifier_red_radiance") then
            if not unit:GetAggroTarget() then
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_MOVE_TO_TARGET,
                    TargetIndex = target:entindex(),
                    Queue = false,
                })
            end
            return
        end

        if self.blinkUsed and CastAbility(unit, target, "red_machine_gun") then
            if unit.lastCastAbilityName == "red_machine_gun" then
                self.blinkUsed = false
            end
            return
        end

        if CastAbility(unit, target, "red_radiance") then return end
        if CastAbility(unit, target, "red_fireball") then return end

        -- everything on CD, do the trick
        local unitPos = unit:GetAbsOrigin()
        local blinkTarget = self.blinkLeftTarget:GetAbsOrigin()
        if #(unitPos - self.blinkRightTarget:GetAbsOrigin()) > #(unitPos - blinkTarget) then
            blinkTarget = self.blinkRightTarget:GetAbsOrigin()
        end
        if CastAbility(unit, blinkTarget, "red_blink") then
            self.blinkUsed = true
            return
        end
    end
end
