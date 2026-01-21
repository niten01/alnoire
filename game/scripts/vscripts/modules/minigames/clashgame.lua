ClashGame = ClashGame or class {}

ClashGame.isActive = false



function ClashGame:Init(game)
    print("Inited CLASHGAME")
    print("OnClashGameEnter:", GameEvents.OnClashGameEnter)
    self.game = game
    local config = {
        {point = "spawn_radiant_left", team = DOTA_TEAM_GOODGUYS, target = "spawn_mega_left"},
        {point = "spawn_radiant_right", team = DOTA_TEAM_GOODGUYS, target = "spawn_mega_right"},
        {point = "spawn_dire_left", team = DOTA_TEAM_BADGUYS, target = "agro_for_dire_left"},
        {point = "spawn_dire_right", team = DOTA_TEAM_BADGUYS, target = "agro_for_dire_right"},
    }

    GameEvents:OnClashGameEnter(function(event)
        DebugPrint("Started CLASHGAME")
        ClashGame.isActive = true
        self:SpawnAllWaves(config)
        GameRules:GetGameModeEntity():SetContextThink("ClashSpawner", function()
            if not ClashGame.isActive then return nil end
            ClashGame:SpawnAllWaves()
            ClashGame:SpawnMegaCreep()
            return 30.0 
        end, 20.0)
    end)
end

function ClashGame:SpawnAllWaves(config)
    print("Attempting to spawn waves...")
    for _, data in pairs(config) do
        local spawner = Entities:FindByName(nil, data.point)
        if spawner then
            print("Spawner found: " .. data.point)
            self:CreateCreepGroup(spawner, data.team, data.target)
        else
            print("ERROR: Spawner NOT FOUND: " .. data.point)
        end
    end
end

function ClashGame:CreateCreepGroup(spawner, team, targetName)
    local target = Entities:FindByName(nil, targetName)
    local spawnPos = spawner:GetAbsOrigin()
    local creepName = "npc_xavier"
    for i = 1, 3 do
        local unit = CreateUnitByName(creepName, spawnPos + RandomVector(100), true, nil, nil, team)
        
        if unit then
            if target then
                unit:SetContextThink("InitialOrder", function()
                    
                    ExecuteOrderFromTable({
                        UnitIndex = unit:entindex(), 
                        OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, 
                        Position = target:GetAbsOrigin(), 
                        Queue = false 
                    })

                    return nil 
                end, 0.1)

                print("Success: Unit " .. creepName .. " sent to target " .. targetName)
            else 
                print("ERROR: target " .. targetName .. " NOT FOUND")
            end
        else
            print("ERROR: Failed to create unit " .. creepName)
        end
    end
end

function ClashGame:SpawnMegaCreep()
    local target = Entities:FindByName(nil, "agro_for_dire_left")
    local spawnPos = Entities:FindByName(nil, "spawn_mega_left")
    if not spawnPos then return end
    local megacreepName = "mega_sanya"
    local unit = CreateUnitByName(megacreepName, spawnPos:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_BADGUYS)
    if unit then
        if target then
            unit:SetContextThink("InitialOrder", function()
                ExecuteOrderFromTable({
                    UnitIndex = unit:entindex(), 
                    OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE, 
                    Position = target:GetAbsOrigin(), 
                    Queue = false
                })
                return nil
            end, 0.1)
        end
    end
end

return ClashGame