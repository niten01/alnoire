SpawnManager = SpawnManager or {}

function SpawnManager:Init()
    self.playerRespawnPos = {}

    GameEvents:OnHeroInGame(bind(self.OnHeroInGame, self))
    GameEvents:OnGameInProgress(bind(self.OnGameInProgress, self))
    GameEvents:OnNPCSpawned(bind(self.OnNPCSpawned, self))
    GameEvents:OnZoneEnter(bind(self.OnZoneEnter, self))
    GameEvents:OnEntityKilled(bind(self.OnEntityKilled, self))
end

function SpawnManager:OnGameInProgress()
    if not IsServer() then return end

    for spawnerName, spawnerData in pairs(EntityData:AllByType("spawner")) do
        if spawnerData.deferred then goto continue end
        self:SpawnNPC(spawnerName)
        ::continue::
    end

    local defaultRespawnPos = self:GetRespawnPosByRespawnPointName("respawn_prologue")
    for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        self.playerRespawnPos[playerID] = defaultRespawnPos
    end
end

function SpawnManager:OnHeroInGame(hero)
    if not IsServer() then return end

    if not hero:HasModifier("modifier_anim_translate_thinker") then
        hero:AddNewModifier(hero, nil, "modifier_anim_translate_thinker", { duration = -1 })
    end
    --hero:AddNewModifier(hero, nil, "modifier_test_eyes", { duration = -1 })
    -- This clears the "visited" history for a specific team
    GameRules:GetGameModeEntity():SetFogOfWarDisabled(false)
end

function SpawnManager:SpawnNPC(spawnerName)
    DebugPrint("[ALNOIRE] Trying to spawn using spawner: ", spawnerName)
    local data = EntityData:ByName(spawnerName)
    for _, spawnerEnt in ipairs(Entities:FindAllByName(spawnerName)) do
        local origin = spawnerEnt:GetAbsOrigin()
        DebugPrint("\tFound spawner entity: (" .. origin.x .. ";" .. origin.y .. ")")
        local npc = CreateUnitByName(
            data.npc,
            origin,
            false,
            nil,
            nil,
            DOTA_TEAM_NEUTRALS
        )
        npc:SetEntityName(data.npc)
        local fwd = spawnerEnt:GetForwardVector()
        fwd.z = 0
        npc:FaceTowards(npc:GetAbsOrigin() + fwd * 100)
        npc:SetForwardVector(fwd)

        for _, modifier in ipairs(data.modifiers or {}) do
            if not npc:HasModifier(modifier) then
                npc:AddNewModifier(npc, nil, modifier, {})
            end
        end

        EntityData:AddEntity("npc", data.npc, {})
    end
end

function SpawnManager:OnNPCSpawned(keys)
    ---@type CDOTA_BaseNPC
    local unit = keys.unit
    local unitName = unit:GetUnitName()

    if unitName == "npc_gorilla" then
        AddAnimationTranslate(unit, "torment")
    elseif unitName == "npc_rape_victim" then
        AddAnimationTranslate(unit, "torment")
    end
end

function SpawnManager:GetRespawnPosByRespawnPointName(respawnPointName)
    local respawnPointEntities = Entities:FindAllByName(respawnPointName)
    if TableLength(respawnPointEntities) > 1 then
        error("Multiple respawn points found for " .. respawnPointName)
        return nil
    end

    if TableLength(respawnPointEntities) == 0 then
        DebugPrint("[???] No respawn points found for " .. respawnPointName)
        return nil
    end
    local respawnPos = respawnPointEntities[1]:GetAbsOrigin()
    return respawnPos
end

function SpawnManager:OnEntityKilled(event)
    local hero = event.killed_unit
    if not hero or not hero:IsRealHero() then return end

    local playerID =  hero:GetPlayerOwnerID()
    hero:SetRespawnPosition(self.playerRespawnPos[playerID])
end

function SpawnManager:OnZoneEnter(event)
    local respawnPos = self:GetRespawnPosByRespawnPointName(event.respawnPoint)
    if not respawnPos then return end

    self.playerRespawnPos[event.playerID] = respawnPos
    DebugPrint("[ALNOIRE] Respawn point set: " ..
        event.respawnPoint .. " (" .. respawnPos.x .. ";" .. respawnPos.y .. ")")
end

return SpawnManager
