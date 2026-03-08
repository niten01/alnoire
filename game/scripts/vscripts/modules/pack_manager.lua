PackManager = PackManager or {}

function PackManager:Init()
    GameEvents:OnGameInProgress(bind(self.OnGameInProgress, self))
    ChatCommand:LinkDevCommand("-junglerespawn", function(event, args)
        self:RespawnPack(args[1])
        self:ActivatePack(args[1])
    end)
end

function PackManager:OnGameInProgress()
    if not IsServer() then return end
    for packName, packData in EntityData:AllByType('pack') do
        packData.spawners = {}
        for spawnerName, spawnerData in EntityData:AllByType('spawner') do
            if spawnerData.packID and spawnerData.packID == packName then
                table.insert(packData.spawners, spawnerName)
            end
        end

        if packData.activateAfterUnitsSpawned then
            self:ActivatePack(packName)
        end
    end
end

function PackManager:ActivatePack(packName)
    assert(packName)
    DebugPrint("[ALNOIRE] Activating pack: " .. packName)
    local pack = self:GetPack(packName)
    if pack.state ~= 'off' then return end

    local packEntity = Entities:FindByName(nil, packName)
    if not packEntity then
        DebugPrint("[???] (PackManager) no entity for pack: ", packName)
        return
    end
    pack.debugPfx = {
        DrawDebugCircle(packEntity, pack.rangeAggro),
        DrawDebugCircle(packEntity, pack.rangeRetreat),
        DrawDebugCircle(packEntity, pack.rangeFastTickRate),
    }

    pack.pos = packEntity:GetAbsOrigin()
    pack.vId = AddFOWViewer(DOTA_TEAM_BADGUYS, packEntity:GetAbsOrigin(), pack.rangeAggro, 36000, false)
    DebugPrint("[ALNOIRE] Added fow viewer for pack: " .. packName)
    local thinkerFn = nil
    if pack.thinker == "default" then
        thinkerFn = function()
            return self:PackTargetDefaultThink(packEntity, pack)
        end
    elseif pack.thinker == "axe" then
        thinkerFn = function()
            return self:PackTargetDenyThink(packEntity, pack)
        end
    else
        error("[ALNOIRE](PackManager) no such thinker for name: ", pack.thinker)
    end

    assert(thinkerFn)
    packEntity:SetContextThink("PackTargetThink", thinkerFn, BATTLE_THINK_INTERVAL)
    thinkerFn()
    pack.state = 'aggro'

    PackManager:ForAllAliveUnits(pack, function(unit)
        self:SetUnitAIActive(unit, true)
    end)

    local enemies = FindEnemiesForAIInRadius(pack.pos, pack.rangeRetreat)
    if #enemies > 0 then
        self:OnAggro(pack, enemies[1])
    end
end

function PackManager:SetUnitAIActive(unit, bActive)
    if not IsServer() then return end
    assert(unit.ai_modifier, "No ai_modifier for unit: " .. unit:GetName())
    local modifier = unit:FindModifierByName(unit.ai_modifier)
    if modifier then
        SetAIModifierActive(modifier, bActive)
    else
        print("[PackManager] WARNING: Could not find modifier " .. unit.ai_modifier .. " on unit " .. unit:GetUnitName())
    end
end

function PackManager:ResetPackPosition(packName)
    local pack = self:GetPack(packName)
    assert(pack, "No such pack: " .. packName)

    self:ForAllAliveUnits(pack, function(unit)
        if unit.spawnPos then unit:SetAbsOrigin(unit.spawnPos) end
        if unit.spawnForward then unit:SetForwardVector(unit.spawnForward) end
    end)
end

function PackManager:ForAllAliveUnits(pack, fn)
    for _, unit in ipairs(pack.units) do
        if unit and not unit:IsNull() and unit:IsAlive() then
            fn(unit)
        end
    end
end

function PackManager:DeactivatePack(packName)
    assert(packName)
    DebugPrint("[ALNOIRE] Deactivating pack: " .. packName)
    local pack = self:GetPack(packName)
    if pack.state == 'off' then return end

    if self.vId then
        RemoveFOWViewer(DOTA_TEAM_BADGUYS, self.vId)
    else
        DebugPrint("[ALNOIRE] Deactivating fow viewer for pack: " .. packName)
    end
    for _, pfx in ipairs(pack.debugPfx or {}) do
        DestroyDebugCircle(pfx)
    end
    self:ForAllAliveUnits(pack, function(unit)
        self:SetUnitAIActive(unit, false)
    end)
    pack.state = 'off'

    self:OnRetreat(pack, nil)
end

function PackManager:AddUnit(packName, npc)
    local pack = self:GetPack(packName)
    assert(pack, "Invalid packName")
    table.insert(pack.units, npc)
    npc.packTargetData = pack
    if pack.state ~= 'off' then
        self:SetUnitAIActive(npc, true)
    end
    DebugPrint("[ALNOIRE] Added " .. npc:GetName() .. " to pack: " .. packName)
end

function PackManager:RespawnPack(packName)
    DebugPrint("[ALNOIRE] Respawning pack: " .. packName)
    local pack = self:GetPack(packName)
    local oldState = pack.state
    self:ForAllAliveUnits(pack, function(unit)
        unit:RemoveSelf() -- agressive remove to not trigger anything accidentally
    end)
    pack.units = {}
    for _, spawnerName in ipairs(pack.spawners) do
        SpawnManager:SpawnNPC(spawnerName)
    end

    -- pack could deactivate itself during respawn
    if oldState ~= 'off' then
        self:ActivatePack(packName)
    end
end

function PackManager:GetPack(packName)
    return EntityData:ByName(packName)
end

local OnPackWipedEvent = CreateGameEvent 'OnPackWiped'
function PackManager:PackTargetDefaultThink(packEnt, pack)
    if not packEnt or packEnt:IsNull() then return nil end
    if not pack then return nil end
    if pack.state == 'off' then return nil end
    if #pack.units == 0 then return IDLE_THINK_INTERVAL end
    if not AnyAlive(pack) then
        print("[ALNOIRE] All units in pack " .. packEnt:GetName() .. " are dead. Disabling beacon thinker.")
        self:DeactivatePack(pack.name)
        OnPackWipedEvent({
            packName = pack.name
        })
        return nil
    end
    local rangeFastTickRate = math.max(pack.rangeFastTickRate, pack.rangeRetreat)
    local rangeAggro = pack.rangeAggro
    local rangeRetreat = pack.rangeRetreat
    local pos = packEnt:GetAbsOrigin()

    local enemiesAggro = FindUnitsInRadius(
        DOTA_TEAM_BADGUYS,
        pos,
        nil,
        rangeFastTickRate,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
        FIND_CLOSEST,
        false
    )

    local enemiesInFOW = FindUnitsInRadius(
        DOTA_TEAM_BADGUYS,
        pos,
        nil,
        rangeFastTickRate,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
        FIND_CLOSEST,
        false
    )
    if #enemiesInFOW == 0 then
        pack.state = "idle"
        pack.target = nil
        pack.somebodyNear = false
        return IDLE_THINK_INTERVAL
    end

    pack.somebodyNear = true
    if #enemiesAggro == 0 then
        return BATTLE_THINK_INTERVAL
    end
    local target = enemiesAggro[1]
    local dist = (target:GetAbsOrigin() - pos):Length2D()

    if (pack.state == 'idle' or pack.state == 'retreat' or pack.state == 'prepare') and dist <= rangeAggro then
        pack.state = 'aggro'
        pack.target = target
        self:OnAggro(pack, target)
    elseif pack.state == 'aggro' then
        if dist > rangeRetreat or not target:IsAlive() then
            pack.state = 'retreat'
            pack.target = nil
            self:OnRetreat(pack, target)
        else
            pack.target = target
        end
    elseif pack.state == 'retreat' and dist > rangeAggro then
        pack.state = 'idle'
    end

    return BATTLE_THINK_INTERVAL
end

function PackManager:HasActiveFights()
    for _, pack in EntityData:AllByType("pack") do
        if pack.state == 'aggro' then return true end
    end
    return false
end

function PackManager:OnAggro(pack, target)
    DebugPrint("OnAggro")
    if pack.music then
        Music:StartCustomMusic(target:GetPlayerOwnerID(), pack.music)
    end

    for _, door in ipairs(pack.doors) do
        DoorManager:Close(door)
    end
end

function PackManager:OnRetreat(pack, target)
    local pids = target and { target:GetPlayerOwnerID() } or {}
    if not target then
        for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
            table.insert(pids, playerID)
        end
    end
    DebugPrint("OnRetreat")
    if pack.music then
        for _, pid in ipairs(pids) do
            Music:StopCustomMusic(pid)
        end
    end

    for _, door in ipairs(pack.doors) do
        DoorManager:Open(door)
    end
end

return PackManager
