if not IsServer() then return end

local AGRO_RANGE = 900
local LEASH_RANGE = 3000
local THINK_INTERVAL = 0.5
local EULS_DELAY = 7
local EULS_COOLDOWN = 15

function Spawn(entityKeyValues)
    if not thisEntity or not IsServer() then return end
    thisEntity:SetIdleAcquire(false)
    thisEntity:SetAcquisitionRange(0)
    thisEntity:Stop()

    if IsServer() then
    thisEntity:AddNewModifier(
        thisEntity,
        nil,
        "modifier_blink_evade",
        {
            evades = 3,
            blink_range = 700,
            cooldown = 0.3
        }
    )
end
    thisEntity.hFireball = thisEntity:FindAbilityByName("lich_frost_nova")

    thisEntity:SetContextThink("CustomEnemyThink", CustomEnemyThink, 0.5)
end

function CustomEnemyThink()
    if not IsValidEntity(thisEntity) or not thisEntity:IsAlive() then
        return -1
    end

    if GameRules:IsGamePaused() then
        return THINK_INTERVAL
    end

    if thisEntity:IsChanneling() or thisEntity:IsOutOfGame() then
        return THINK_INTERVAL
    end

    -- init (1 раз)
    if not thisEntity.bInitialized then
        InitEnemy()
    end

    local enemies = FindEnemies()
    if #enemies > 0 and not thisEntity.fCombatStartTime then
        thisEntity.fCombatStartTime = GameRules:GetGameTime()
    end
    local distFromHome = (thisEntity:GetAbsOrigin() - thisEntity.vSpawnPos):Length2D()

    if distFromHome > LEASH_RANGE or #enemies == 0 then
        return RetreatHome()
    end

    local target = enemies[1]
    if not target then
        return THINK_INTERVAL
    end

    if TryUseEuls(target) then 
        Timers:CreateTimer(function ()
            
        end)
        return 2
    end
    if TryCastFireball(target) then return 1.5 end

    thisEntity:MoveToTargetToAttack(target)

    return THINK_INTERVAL
end

function InitEnemy()
    thisEntity.bInitialized = true
    thisEntity.vSpawnPos = thisEntity:GetAbsOrigin()

    thisEntity:SetIdleAcquire(true)
    thisEntity:SetAcquisitionRange(AGRO_RANGE)

    thisEntity.fCombatStartTime = nil
    thisEntity.fLastEulsTime = -999
    thisEntity.bPauseAfterEulsUsed = false
end

function FindEnemies()
    return FindUnitsInRadius(
        thisEntity:GetTeamNumber(),
        thisEntity:GetAbsOrigin(),
        nil,
        AGRO_RANGE,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO,
        DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE,
        FIND_CLOSEST,
        false
    )
end

function TryCastFireball(target)
    local ability = thisEntity.hFireball
    if not ability or not ability:IsFullyCastable() then
        return false
    end

    ExecuteOrderFromTable({
        UnitIndex = thisEntity:entindex(),
        OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
        TargetIndex = target:entindex(),
        AbilityIndex = ability:entindex(),
        Queue = false
    })

    return true
end


function TryUseEuls(target)
    if not thisEntity.fCombatStartTime then
        return false
    end

    local now = GameRules:GetGameTime()
    if now - thisEntity.fCombatStartTime < EULS_DELAY then
        return false
    end

    if now - thisEntity.fLastEulsTime < EULS_COOLDOWN then
        return false
    end

    for i = 0, 5 do
        local item = thisEntity:GetItemInSlot(i)
        if item and item:GetName() == "item_cyclone" and item:IsFullyCastable() then
            ExecuteOrderFromTable({
                UnitIndex = thisEntity:entindex(),
                OrderType = DOTA_UNIT_ORDER_CAST_TARGET,
                TargetIndex = target:entindex(),
                AbilityIndex = item:entindex(),
                Queue = false
            })
            if not thisEntity.bPauseAfterEulsUsed then
                thisEntity.bPauseAfterEulsUsed = true

                Timers:CreateTimer(1.0, function()
                    if not GameRules:IsGamePaused() then
                        PauseGame(true)
                        GameRules:SendCustomMessage("летать + сосать 1000 - 7", 0, 0)

                    end
                end)
            end
            thisEntity.fLastEulsTime = now
            PlayChatWheelSoundForPlayer(target:GetPlayerID(), "ChatWheel.TakeThat")
            return true
        end
    end

    return false
end


function PlayChatWheelSoundForPlayer(playerID, soundName)
    local player = PlayerResource:GetPlayer(playerID)
    if player then
        EmitSoundOn(soundName, player)
    end
end


function RetreatHome()
    ExecuteOrderFromTable({
        UnitIndex = thisEntity:entindex(),
        OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
        Position = thisEntity.vSpawnPos,
        Queue = false
    })

    local distance = (thisEntity:GetAbsOrigin() - thisEntity.vSpawnPos):Length2D()
    local speed = thisEntity:GetIdealSpeed()

    return distance / speed + 0.2
end
