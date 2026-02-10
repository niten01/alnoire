LinkLuaModifier("modifier_axe_sustain", "modifiers/jungle/modifier_axe_sustain", LUA_MODIFIER_MOTION_NONE)

if not IsServer() then return end

function Spawn()
    if not thisEntity or not IsServer() then return end
    if not thisEntity.spawnPos or thisEntity.spawnPos:IsNull() then
        thisEntity.spawnPos = thisEntity:GetAbsOrigin()
    end
    thisEntity:SetIdleAcquire(false)
    thisEntity:SetAcquisitionRange(0)
    thisEntity:Stop()
    thisEntity:SetContextThink("DenyAxeThink", DenyAxeThink, IDLE_THINK_INTERVAL)
    thisEntity:AddNewModifier(thisEntity, nil, 'modifier_axe_sustain', {})
end

function DenyAxeThink()
    local unit = thisEntity
    local beacon = unit.packTarget
    if not unit:IsAlive() then return nil end
    if not beacon or beacon:IsNull() then return IDLE_THINK_INTERVAL end
    
    local target = beacon.target
    local denyTarget = beacon.denyTarget
    local beaconState = beacon.state
    local currentPos = unit:GetAbsOrigin()
    local distToSpawn = (currentPos - unit.spawnPos):Length2D()

    if beacon.axe_alone and beacon.axe_alone == true then
        if unit:HasModifier('modifier_axe_sustain') then
            unit:RemoveModifierByName('modifier_axe_sustain')
        end
    end

    if unit:GetCurrentActiveAbility() or unit:IsChanneling() then
        return BATTLE_THINK_INTERVAL
    end

    if beaconState == 'aggro' and target and target:IsAlive() then
        local currentTime = GameRules:GetGameTime()
        unit.aggroStartTime = unit.aggroStartTime or currentTime
        if CastAllAbilities(unit, target) then
            return BATTLE_THINK_INTERVAL
        end
    end


    if beaconState == 'aggro' and denyTarget and denyTarget:IsAlive() then
        
        ExecuteOrderFromTable({
            UnitIndex = unit:entindex(),
            OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
            TargetIndex = denyTarget:entindex(),
            Queue = true,
        })
        return BATTLE_THINK_INTERVAL
    end
    if beaconState == 'retreat' or beaconState == 'idle' then
        MoveHome(unit)
    end

    if beaconState == 'aggro' or beaconState == 'retreat' or beacon.somebodyNear or distToSpawn > 150 then
        print('- axe battle')
        return BATTLE_THINK_INTERVAL
    end
    print('- axe idle')
    return IDLE_THINK_INTERVAL
end