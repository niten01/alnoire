require('internal.gameevents')

ClashGame = ClashGame or {}

ClashGame.isActive = false



function ClashGame:Init()
    self.config = {
        { point = "spawn_radiant_left",  team = DOTA_TEAM_GOODGUYS, target = "spawn_mega_left" },
        { point = "spawn_radiant_right", team = DOTA_TEAM_GOODGUYS, target = "spawn_mega_right" },
        { point = "spawn_dire_left",     team = DOTA_TEAM_BADGUYS,  target = "agro_for_dire_left" },
        { point = "spawn_dire_right",    team = DOTA_TEAM_BADGUYS,  target = "agro_for_dire_right" },
    }

    self.king_tower_good = nil
    self.king_tower_bad = nil

    self.tower_config = {
        { point = "bad_tower_left",   npc = "npc_dota_custom_tower_bad",       team = DOTA_TEAM_BADGUYS },
        { point = "bad_tower_right",  npc = "npc_dota_custom_tower_bad",       team = DOTA_TEAM_BADGUYS },
        { point = "bad_tower_king",   npc = "npc_dota_custom_king_tower_bad",  team = DOTA_TEAM_BADGUYS },
        { point = "good_tower_right", npc = "npc_dota_custom_tower_good",      team = DOTA_TEAM_GOODGUYS },
        { point = "good_tower_left",  npc = "npc_dota_custom_tower_good",      team = DOTA_TEAM_GOODGUYS },
        { point = "good_tower_king",  npc = "npc_dota_custom_king_tower_good", team = DOTA_TEAM_GOODGUYS },

    }

    self.good_creep_name = "npc_clash_creep_radiant"
    self.bad_creep_name = "npc_clash_creep_dire"
    self.mega_creep_name = "npc_clash_creep_mega_sanya_1"
    GameEvents:OnQuestTrigger(function(event)
        if event.triggerName ~= "trigger_clash_arena" then return end

        if self.isActive then return end
        DebugPrint("[ALNOIRE] Started CLASHGAME")
        self.isActive = true
        self:SpawnTowers()
        self:SpawnAllWaves()
        GameRules:GetGameModeEntity():SetContextThink("ClashSpawner", function()
            if not self.isActive then return nil end
            self:SpawnAllWaves()
            self:SpawnMegaCreep()
            return 30.0
        end, 20.0)
    end)
end

function ClashGame:SpawnTowers()
    print("Spawning towers ... ")
    for _, data in pairs(self.tower_config) do
        local spawnerName = data.point
        local spawner = Entities:FindByName(nil, spawnerName)
        local unitName = data.npc
        local unitTeam = data.team
        if spawner then
            local spawnerPos = spawner:GetAbsOrigin()
            local unit = CreateUnitByName(
                unitName,
                spawnerPos,
                false,
                nil,
                nil,
                unitTeam
            )
            local fwd = spawner:GetForwardVector()
            fwd.z = 0
            unit:FaceTowards(unit:GetAbsOrigin() + fwd * 100)
            unit:SetForwardVector(fwd)

            unit:RemoveAllModifiers(0, true, true, true)
            if string.find(unitName, 'king') then
                unit:AddNewModifier(unit, nil, 'modifier_invulnerable', {})
                unit:AddNewModifier(unit, nil, 'modifier_king_tower', {})
                if string.find(unitName, 'good') then
                    self.king_tower_good = unit
                else
                    self.king_tower_bad = unit
                end
            else
                unit:AddNewModifier(unit, nil, 'modifier_tower', {})
            end
            unit:AddNewModifier(unit, nil, 'modifier_clash_unit', {})
        else
            print("No spawner for tower")
        end
    end
end

function ClashGame:SpawnAllWaves()
    if not self.isActive then return end
    print("Attempting to spawn waves...")
    for _, data in pairs(self.config) do
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
    if not self.isActive then return end
    local target = Entities:FindByName(nil, targetName)
    local spawnPos = spawner:GetAbsOrigin()
    for i = 1, 3 do
        local unit = CreateUnitByName(self.bad_creep_name, spawnPos + RandomVector(100), true, nil, nil, team)
        unit:AddNewModifier(unit, nil, 'modifier_clash_unit', {})
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

                print("Success: Unit " .. self.bad_creep_name .. " sent to target " .. targetName)
            else
                print("ERROR: target " .. targetName .. " NOT FOUND")
            end
        else
            print("ERROR: Failed to create unit " .. self.bad_creep_name)
        end
    end
end

function ClashGame:SpawnMegaCreep()
    if not self.isActive then return end
    local rand = math.random()
    local spawnPos
    local target
    if rand >= 0.5 then
        spawnPos = Entities:FindByName(nil, "spawn_mega_left")
        target = Entities:FindByName(nil, "agro_for_dire_left")
    else
        spawnPos = Entities:FindByName(nil, "spawn_mega_right")
        target = Entities:FindByName(nil, "agro_for_dire_right")
    end
    if not spawnPos then return end
    local unit = CreateUnitByName(self.mega_creep_name, spawnPos:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_BADGUYS)
    unit:AddNewModifier(unit, nil, 'modifier_clash_unit', {})
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

function ClashGame:OnTowerKilled(towerName)
    if string.find(towerName, 'bad') then
        self.king_tower_bad:RemoveModifierByName('modifier_invulnerable')
    else
        self.king_tower_good:RemoveModifierByName('modifier_invulnerable')
    end
end

function ClashGame:OnKingTowerKilled(team)
    local is_winner = false
    if team == DOTA_TEAM_BADGUYS then
        print("[ALNOIRE] АЛЕКСАНДР ПОБЕДИЛ! клеш рояль")
        is_winner = true
    else
        print("[ALNOIRE] АЛЕКСАНДР ПРОЕБАЛ! клеш рояль")
        is_winner = false
    end
    self.isActive = false
    self:KillAll()
end

function ClashGame:KillAll()
    local names_to_kill = {}
    for _, data in pairs(self.tower_config) do
        table.insert(names_to_kill, data.npc)
    end
    table.insert(names_to_kill, self.bad_creep_name)
    table.insert(names_to_kill, self.good_creep_name)
    local units = FindUnitsInRadius(
        DOTA_TEAM_NEUTRALS,
        Vector(0, 0, 0),
        nil,
        FIND_UNITS_EVERYWHERE,
        DOTA_UNIT_TARGET_TEAM_BOTH,
        DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BUILDING,
        DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_INVULNERABLE,
        FIND_ANY_ORDER,
        false
    )
    for _, unit in pairs(units) do
        if unit and unit:HasModifier('modifier_clash_unit') then
            unit:RemoveAllModifiers(0, true, true, true)
            unit:ForceKill(false)
        end
    end
end

return ClashGame
