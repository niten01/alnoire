modifier_techies_ai = class({})

function modifier_techies_ai:IsHidden() return true end

function modifier_techies_ai:IsPurgable() return false end

function modifier_techies_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
        MODIFIER_EVENT_ON_ABILITY_START,
    }
end

function modifier_techies_ai:CheckState()
    return {
        [MODIFIER_STATE_FORCED_FLYING_VISION] = true,
    }
end

function modifier_techies_ai:OnAbilityFullyCast(event)
    if event.unit == self:GetParent() then
        self.bHappened = true
    end
end

function modifier_techies_ai:OnAbilityStart(event)
    if event.unit == self:GetParent() then
        self.bAbilityStarted = true
    end
end

function modifier_techies_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return end
    local beaconState = beaconData.state
    local target = beaconData.target
    print('unit target')
    print(target)
    if not DefaultAiTick(unit) then
        if not self.bHappened and not self.bAbilityStarted and beaconState == 'aggro' and target and target:IsAlive() then
            EmitSoundOn("JungleTech.Laugh.One", unit)
            local targetVel = target:GetForwardVector() * target:GetIdealSpeed()
            local targetPos = target:GetAbsOrigin()
            local leadTime = 1.5
            local castPos = targetPos + targetVel * leadTime
            local abil = unit:GetAbilityByIndex(0)
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_POSITION,
                AbilityIndex = abil:entindex(),
                Position = castPos,
                Queue = false,
            })
            print(castPos)
            print("-----")
            print(targetPos)
            print("-----")
            print(targetVel)
            print("-----")
        elseif self.bHappened then
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

    AdjustTickRate(unit)
    self:StartIntervalThink(beaconData.currentCreepInterval)
end
