modifier_bufferbear_ai = class({})

function modifier_bufferbear_ai:OnIntervalThink()
    if not IsServer() then return end
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end

    local beaconData = unit.packTargetData
    if not beaconData then
        self:StartIntervalThink(BATTLE_THINK_INTERVAL)
        return
    end

    local isBusyThisTick = false
    if unit:IsChanneling() or unit:GetCurrentActiveAbility() then
        isBusyThisTick = true
    end
    if not isBusyThisTick and beaconData.state == "aggro" then
        local abilityShield = unit:FindAbilityByName("bear_shield")
        if abilityShield and abilityShield:GetLevel() > 0 and abilityShield:IsFullyCastable() then
            local allies = FindUnitsInRadius(
                unit:GetTeamNumber(),
                unit:GetAbsOrigin(),
                nil,
                abilityShield:GetCastRange(),
                DOTA_UNIT_TARGET_TEAM_FRIENDLY,
                DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
                DOTA_UNIT_TARGET_FLAG_NONE,
                FIND_ANY_ORDER,
                false
            )

            local shieldCandidate = nil
            local latestDamageTime = -1

            for _, ally in pairs(allies) do
                if ally ~= unit and ally.packTargetData == beaconData and ally:IsAlive() then
                    local damageTime = ally:GetLastDamageTime()
                    if damageTime > latestDamageTime and (GameRules:GetGameTime() - damageTime) < 5 then
                        latestDamageTime = damageTime
                        shieldCandidate = ally
                    end
                end
            end

            if shieldCandidate then
                isBusyThisTick = true
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(),
                    OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
                    TargetIndex = shieldCandidate:entindex(),
                    AbilityIndex = abilityShield:entindex(),
                    Queue = false,
                })
            end
        end
    end


    if not isBusyThisTick and not unit:IsMoving() then
        if not self.isTaunting then
            unit:StartGestureWithFade(ACT_DOTA_DISABLED, 0.2, 0.2)
            self.isTaunting = true
        end
    else
        if self.isTaunting then
            -- print("Stopping Dance!")
            unit:FadeGesture(ACT_DOTA_DISABLED)
            self.isTaunting = false
        end
    end

    self:StartIntervalThink(beaconData.currentCreepInterval or 0.2)
end
