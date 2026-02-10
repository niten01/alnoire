if not IsServer() then return end

function Spawn(kv)
    if not thisEntity or not IsServer() then return end
    if not thisEntity.spawnPos or thisEntity.spawnPos:IsNull() then
        thisEntity.spawnPos = thisEntity:GetAbsOrigin()
    end
    thisEntity:SetIdleAcquire(false)
    thisEntity:SetAcquisitionRange(0)
    thisEntity:Stop()
    thisEntity:SetContextThink("DefaultCreepThink", DefaultCreepThink, IDLE_THINK_INTERVAL)
end

function DefaultCreepThink()
    local unit = thisEntity
    local beacon = unit.packTarget
    if not unit:IsAlive() then return nil end
    if not beacon or beacon:IsNull() then return IDLE_THINK_INTERVAL end

    local beaconState = beacon.state
    local target = beacon.target
    local currentPos = unit:GetAbsOrigin()
    local distToSpawn = (currentPos - unit.spawnPos):Length2D()


    if beaconState == 'aggro' then
        if not unit.aggroStartTime then
            unit.aggroStartTime = GameRules:GetGameTime()
        end
    else
        unit.aggroStartTime = nil
    end

    -- деремся сука
    if beaconState == 'aggro' and target and target:IsAlive() then
        if distToSpawn > beacon.data.rangeRetreat then 
            MoveHome(unit)
        else
            local currentTime = GameRules:GetGameTime()
            
            if unit:IsChanneling() or unit:GetCurrentActiveAbility() then
                return BATTLE_THINK_INTERVAL 
            end

            local timeInAggro = currentTime - (unit.aggroStartTime or 0)
            unit.lastCastTime = unit.lastCastTime or 0

            if timeInAggro >= 5 and (currentTime - unit.lastCastTime) >= 2 then
                if CastAllAbilities(unit, target)  then
                    unit.lastCastTime = currentTime
                    return BATTLE_THINK_INTERVAL 
                end
            end
            if unit:GetAggroTarget() ~= target then
                unit:MoveToTargetToAttack(target)
            end
        end

    -- бежим сука
    elseif beaconState == 'retreat' then
        MoveHome(unit)

    -- стоим сука
    elseif beaconState == 'idle' then
        if distToSpawn > 150 then
            MoveHome(unit)
        end
    end

    if beaconState == 'retreat' or beaconState == 'idle' then
        if unit:GetHealthPercent() < 100 then
            unit:Heal(unit:GetMaxHealth() * 0.1, nil)
        end
    end

    if beaconState == 'aggro' or beaconState == 'retreat' or beacon.somebodyNear or distToSpawn > 150 then
        --print('крип battle!')
        return BATTLE_THINK_INTERVAL
    end
    --print('крип idle!')
    return IDLE_THINK_INTERVAL
end
