if not IsServer() then return end

function Spawn()
    if not thisEntity or not IsServer() then return end
    thisEntity:SetIdleAcquire(false)
    thisEntity:SetAcquisitionRange(0)
    thisEntity:Stop()
    thisEntity:SetContextThink("DenyAxeThink", DenyAxeThink, IDLE_THINK_INTERVAL)
    thisEntity:AddNewModifier(nil, nil, "modifier_axe_sustain", {})
end

function DenyAxeThink()
    local unit = thisEntity
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return BATTLE_THINK_INTERVAL end

    local beaconState = beaconData.state
    if not beaconState or beaconState == 'off' or beaconState == 'dead' then return IDLE_THINK_INTERVAL end
    
    local target = beaconData.target
    local denyTarget = beaconData.denyTarget
    local currentPos = unit:GetAbsOrigin()
    local distToSpawn = (currentPos - unit.spawnPos):Length2D()

    if beaconData.axe_alone == true then
        if unit:HasModifier('modifier_axe_sustain') then
            unit:RemoveModifierByName('modifier_axe_sustain')
            unit:SetIdleAcquire(true)
            unit:SetAcquisitionRange(beaconData.rangeAggro)
            return BATTLE_THINK_INTERVAL
        end
    end

    if unit:GetCurrentActiveAbility() or unit:IsChanneling() then
        return BATTLE_THINK_INTERVAL
    end

    if beaconState == 'aggro' and denyTarget and denyTarget:IsAlive() then
        if unit:GetAggroTarget() ~= denyTarget then
            ExecuteOrderFromTable({
                UnitIndex = unit:entindex(),
                OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
                TargetIndex = denyTarget:entindex(),
                Queue = false,
            })
        end
        return BATTLE_THINK_INTERVAL
    end

    if beaconState == 'aggro' and target and target:IsAlive() then
        local currentTime = GameRules:GetGameTime()
        if (currentTime - (unit.lastCastTime or 0)) >= 2.5 then
            if CastAllAbilities(unit, target) then
                unit.lastCastTime = currentTime 
                return BATTLE_THINK_INTERVAL
            end
        end
    end

    if beaconState == 'retreat' then
        MoveHome(unit)
    end

    if beaconState == 'retreat' or beaconState == 'idle' then
        if unit:GetHealthPercent() < 100 then
            unit:Heal(unit:GetMaxHealth() * 0.1, nil)
        end
    end

    if beaconState == 'aggro' or beaconState == 'retreat' or beaconData.somebodyNear or distToSpawn > 150 then
        return BATTLE_THINK_INTERVAL
    end

    return IDLE_THINK_INTERVAL
end