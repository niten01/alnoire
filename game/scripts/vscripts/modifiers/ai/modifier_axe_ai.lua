modifier_axe_ai = class({})


function modifier_axe_ai:OnCreated()
    if not IsServer() then return end
    local unit = self:GetParent()
    local abilSustain = unit:FindAbilityByName("axe_sustain")
    abilSustain:ToggleAbility()
    self.abilSustain = abilSustain
end

function modifier_axe_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return end

    local beaconState = beaconData.state
    local beaconPos = beaconData.pos
    local isBusyThisTick = false

    if unit:HasModifier('modifier_axe_sustain') then
        local allies = FindUnitsInRadius(unit:GetTeamNumber(), beaconPos, nil, beaconData.rangeFastTickRate,
            DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_CREEP + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE,
            FIND_ANY_ORDER, false)
        local hasGroupMembers = false
        for _, ally in pairs(allies) do
            if ally ~= unit and ally:IsAlive() and ally.packTargetData == beaconData then
                hasGroupMembers = true
                break
            end
        end
        if not hasGroupMembers then
            self.abilSustain:ToggleAbility()
            -- unit:RemoveModifierByName('modifier_axe_sustain')
        end
    end

    if DefaultAiTick(unit) then
        isBusyThisTick = true
    else
        local target = beaconData.target
        if target and target:IsAlive() then
            if unit:IsChanneling() or unit:GetCurrentActiveAbility() then
                isBusyThisTick = true
            else
                if unit:HasModifier('modifier_axe_sustain') then
                    local alliesNearby = FindUnitsInRadius(unit:GetTeamNumber(), unit:GetAbsOrigin(), nil,
                        beaconData.rangeFastTickRate, DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                        DOTA_UNIT_TARGET_CREEP + DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)
                    local denyTarget = nil
                    for _, ally in pairs(alliesNearby) do
                        if ally ~= unit and ally.packTargetData == beaconData and ally:GetHealthPercent() < 50 then
                            denyTarget = ally
                            break
                        end
                    end

                    if denyTarget then
                        isBusyThisTick = true
                        if unit:GetAggroTarget() ~= denyTarget then
                            ExecuteOrderFromTable({
                                UnitIndex = unit:entindex(),
                                OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
                                TargetIndex = denyTarget:entindex(),
                                Queue = false,
                            })
                        end
                    end
                end
                if not isBusyThisTick then
                    local currentTime = GameRules:GetGameTime()
                    if (currentTime - (unit.lastCastTime or 0)) >= 2.5 then
                        if CastAllAbilities(unit, target) then
                            unit.lastCastTime = currentTime
                            isBusyThisTick = true
                        end
                    end
                end
                if not isBusyThisTick and not unit:HasModifier('modifier_axe_sustain') then
                    isBusyThisTick = true
                    if unit:GetAggroTarget() ~= target then
                        ExecuteOrderFromTable({
                            UnitIndex = unit:entindex(),
                            OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
                            TargetIndex = target:entindex(),
                            Queue = false,
                        })
                    end
                end
            end
        end
    end

    if not isBusyThisTick and not unit:IsMoving() then
        if not self.isTaunting then
            unit:StartGestureWithFade(ACT_DOTA_TELEPORT, 0.2, 0.2)
            self.isTaunting = true
        end
    else
        if self.isTaunting then
            unit:FadeGesture(ACT_DOTA_TELEPORT)
            self.isTaunting = false
        end
    end

    AdjustTickRate(unit)
    self:StartIntervalThink(beaconData.currentCreepInterval)
end
