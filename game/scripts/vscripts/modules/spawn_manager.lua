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

    local spawnersCopy = {}
    for k, v in EntityData:AllByType("spawner") do spawnersCopy[k] = v end
    for spawnerName, spawnerData in pairs(spawnersCopy) do
        if spawnerData.deferred then goto continue end
        self:SpawnNPC(spawnerName)
        ::continue::
    end

    local defaultRespawnPos = self:GetRespawnPosByRespawnPointName("respawn_prologue")
    for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        self.playerRespawnPos[playerID] = defaultRespawnPos
    end

    for spawnerName, _ in EntityData:AllByType("item_spawner") do
        self:SpawnItem(spawnerName)
    end
end

function SpawnManager:OnHeroInGame(hero)
    if not IsServer() then return end

    -- if not hero:HasModifier("modifier_anim_translate_thinker") then
    --     hero:AddNewModifier(hero, nil, "modifier_anim_translate_thinker", { duration = -1 })
    -- end
    --hero:AddNewModifier(hero, nil, "modifier_test_eyes", { duration = -1 })
end

function SpawnManager:SpawnNPC(spawnerName)
    DebugPrint("[ALNOIRE] Trying to spawn NPC using spawner: ", spawnerName)
    assert(spawnerName)
    local spawnerData = EntityData:ByName(spawnerName)
    for _, spawnerEnt in ipairs(Entities:FindAllByName(spawnerName)) do
        local origin = spawnerEnt:GetAbsOrigin()
        DebugPrint("\tFound spawner entity: (" .. origin.x .. ";" .. origin.y .. ")")
        local npc = CreateUnitByName(
            spawnerData.npc,
            origin,
            false,
            nil,
            nil,
            spawnerData.team
        )
        self:InitNPC(spawnerData, spawnerEnt, npc)
    end
end

function SpawnManager:InitNPC(spawnerData, spawnerEnt, npc)
    assert(npc, "Failed to spawn: " .. spawnerData.npc)
    npc:SetEntityName(spawnerData.npc)
    local fwd = spawnerEnt:GetForwardVector()
    fwd.z = 0
    npc:FaceTowards(npc:GetAbsOrigin() + fwd * 100)
    npc:SetForwardVector(fwd)

    local injectedAttributes = {}
    for _, attrName in ipairs(spawnerData.injectedAttributes) do
        assert(spawnerEnt:HasAttribute(attrName),
            "Some spawner entity does't have " .. attrName .. " attribute, good luck finding it")
        local value = spawnerEnt:Attribute_GetFloatValue(attrName, -1)
        injectedAttributes[attrName] = value
    end
    npc.injectedAttributes = injectedAttributes

    for _, modifier in ipairs(spawnerData.modifiers or {}) do
        if not npc:HasModifier(modifier) then
            npc:AddNewModifier(npc, nil, modifier, {})
        end
    end

    if spawnerData.ai_modifier then
        npc:AddNewModifier(npc, nil, spawnerData.ai_modifier, {})
        npc.ai_modifier = spawnerData.ai_modifier
    end

    if not EntityData:ByName(spawnerData.npc) then
        EntityData:AddEntity("npc", spawnerData.npc, {})
    end
    local entData = EntityData:ByName(spawnerData.npc)
    entData.isStory = npc:HasModifier("modifier_story_npc")
    if spawnerData.packID then
        self:LinkUnitToPack(npc, spawnerData)
        npc.spawnPos = npc:GetAbsOrigin()
        npc.spawnForward = npc:GetForwardVector()
    end
end

function SpawnManager:LinkUnitToPack(npc, spawnerData)
    DebugPrint("[ALNOIRE] Trying to link unit to pack: ", npc:GetUnitName())
    PackManager:AddUnit(spawnerData.packID, npc)
end

function SpawnManager:SpawnItem(itemSpawnerName)
    DebugPrint("[ALNOIRE] Trying to spawn item using spawner: ", itemSpawnerName)
    local spawner = EntityData:ByName(itemSpawnerName)
    assert(spawner, "No such item spawner: " .. itemSpawnerName)
    for _, spawnerEnt in ipairs(Entities:FindAllByName(itemSpawnerName)) do
        local origin = spawnerEnt:GetAbsOrigin()
        DebugPrint("\tFound spawner entity: (" .. origin.x .. ";" .. origin.y .. ")")
        local item = CreateItem(spawner.item, nil, nil)
        CreateItemOnPositionSync(origin, item)
    end
end

function SpawnManager:OnNPCSpawned(keys)
    ---@type CDOTA_BaseNPC
    local unit = keys.unit
    local unitName = unit:GetUnitName()

    -- if unitName == "npc_gorilla" then
    --     AddAnimationTranslate(unit, "k")
    -- elseif unitName == "npc_rape_victim" then
    --     AddAnimationTranslate(unit, "torment")
    -- end
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
    if not hero or not hero:IsRealHero() or hero:IsSpiritBearCustom() then return end


    local playerID = hero:GetPlayerOwnerID()
    local respawnPos = self.playerRespawnPos[playerID]
    if not respawnPos then
        print("[???] No respawn pos for player")
    else
        hero:SetRespawnPosition(respawnPos)
    end
end

function SpawnManager:OnZoneEnter(event)
    local respawnPos = self:GetRespawnPosByRespawnPointName(event.respawnPoint)
    if not respawnPos then return end

    self.playerRespawnPos[event.playerID] = respawnPos
    DebugPrint("[ALNOIRE] Respawn point set: " ..
        event.respawnPoint .. " (" .. respawnPos.x .. ";" .. respawnPos.y .. ")")
end

return SpawnManager
