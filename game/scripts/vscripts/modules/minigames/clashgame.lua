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
    self.lastSpellCastTime = 0
    self.firstSpellDelay = 3
    self.spellCooldown = 5

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
    self.bad_creep_ranged_name = "npc_clash_creep_dire_ranged"
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

        GameRules:GetGameModeEntity():SetContextThink("ClashSpellThinker", function()
            if not self.isActive then return nil end

            local currentTime = GameRules:GetGameTime()
            if not self.startTime then self.startTime = currentTime end
            if (currentTime - self.startTime) >= self.firstSpellDelay then
                if (currentTime - self.lastSpellCastTime) >= self.spellCooldown then
                    if self:TryCastKingSpell() then
                        self.lastSpellCastTime = currentTime
                    end
                end
            end
            return 1.0
        end, 1.0)
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
                for i = 0, unit:GetAbilityCount() - 1 do
                    local abil = unit:GetAbilityByIndex(i)
                    if abil then
                        abil:SetLevel(1)
                    end
                end
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
    local cur_unit = self.bad_creep_name
    if team and team == DOTA_TEAM_GOODGUYS then
        cur_unit = self.good_creep_name
    end
    for i = 1, 4 do
        if i == 4 and team == DOTA_TEAM_BADGUYS then
            cur_unit = self.bad_creep_ranged_name
        elseif i == 4 and team == DOTA_TEAM_GOODGUYS then
            break
        end
        local unit = CreateUnitByName(cur_unit, spawnPos + RandomVector(100), true, nil, nil, team)
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
        DOTA_TEAM_BADGUYS,
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

function ClashGame:TryCastKingSpell()
    if not self.king_tower_bad or self.king_tower_bad:IsNull() or not self.king_tower_bad:IsAlive() then
        return false
    end

    local targetPointNames = { "target_dire_spell_left", "target_dire_spell_right" }
    local possibleEnemyPositions = {}

    for _, name in pairs(targetPointNames) do
        local pointEnt = Entities:FindByName(nil, name)
        if pointEnt then
            local enemies = FindUnitsInRadius(
                DOTA_TEAM_BADGUYS,
                pointEnt:GetAbsOrigin(),
                nil,
                700,
                DOTA_UNIT_TARGET_TEAM_ENEMY,
                DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
                DOTA_UNIT_TARGET_FLAG_NONE,
                FIND_ANY_ORDER,
                false
            )

            for _, enemy in pairs(enemies) do
                table.insert(possibleEnemyPositions, enemy:GetAbsOrigin())
            end
        end
    end

    if #possibleEnemyPositions > 0 then
        local castPosition = possibleEnemyPositions[math.random(#possibleEnemyPositions)]

        local abilIndex = math.random(0, 2)
        local ability = self.king_tower_bad:GetAbilityByIndex(abilIndex)

        if ability and ability:IsFullyCastable() then
            local abilityName = ability:GetAbilityName()
            print("[CLASH] King Tower casting spell " .. abilityName)

            if abilityName == "zuus_lightning_bolt" then
                local castsDone = 0
                local maxCasts = 3
                local delay = 0.5

                self.king_tower_bad:SetContextThink(DoUniqueString("zeus_burst"), function()
                    if castsDone < maxCasts then
                        if self.king_tower_bad and not self.king_tower_bad:IsNull() then
                            EmitSoundOnLocationForPlayer("Hero_Zuus.LightningBolt.Cast", castPosition, 0)

                            self.king_tower_bad:CastAbilityOnPosition(castPosition, ability, -1)

                            ability:EndCooldown()

                            castsDone = castsDone + 1
                            return delay
                        end
                    end
                    return nil
                end, 0)
            else
                EmitSoundOnLocationForPlayer("Hero_Invoker.SunStrike.Cast", castPosition, 0)
                self.king_tower_bad:CastAbilityOnPosition(castPosition, ability, -1)
            end

            return true
        end
    end

    return false
end

return ClashGame
