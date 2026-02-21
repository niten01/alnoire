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
    PrintTable(pack)
    pack.debugPfx = {
        DrawDebugCircle(packEntity, pack.rangeAggro),
        DrawDebugCircle(packEntity, pack.rangeRetreat),
        DrawDebugCircle(packEntity, pack.rangeFastTickRate),
    }

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

    for _, pfx in ipairs(pack.debugPfx or {}) do
        DestroyDebugCircle(pfx)
    end
    self:ForAllAliveUnits(pack, function(unit)
        self:SetUnitAIActive(unit, false)
    end)
    pack.state = 'off'
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
    local rangeFastTickRate = pack.rangeFastTickRate
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
    elseif pack.state == 'aggro' then
        if dist > rangeRetreat or not target:IsAlive() then
            pack.state = 'retreat'
            pack.target = nil
        else
            pack.target = target
        end
    elseif pack.state == 'retreat' and dist > rangeAggro then
        pack.state = 'idle'
    end

    return BATTLE_THINK_INTERVAL
end

function PackManager:PackTargetDenyThink(packTargetEnt, packTargetData)
    if not packTargetEnt then return nil end
    if not packTargetData then return nil end
    if #packTargetData.units == 0 then return IDLE_THINK_INTERVAL end

    if not AnyAlive(packTargetData) then
        print("[ALNOIRE] All units in pack " .. packTargetEnt:GetName() .. " are dead. Disabling beacon thinker.")
        packTargetData.state = "dead"
        return nil
    end

    local rangeFastTickRate = packTargetData.rangeFastTickRate
    local rangeAggro = packTargetData.rangeAggro
    local rangeRetreat = packTargetData.rangeRetreat
    local pos = packTargetEnt:GetAbsOrigin()

    local enemies = FindUnitsInRadius(
        DOTA_TEAM_BADGUYS, pos, nil, rangeFastTickRate,
        DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
        FIND_CLOSEST, false
    )


    if #enemies == 0 then
        packTargetData.state = "idle"
        packTargetData.target = nil
        packTargetData.denyTarget = nil
        packTargetData.somebodyNear = false
        return IDLE_THINK_INTERVAL
    end

    local allies = FindUnitsInRadius(
        DOTA_TEAM_BADGUYS, pos, nil, rangeFastTickRate,
        DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
        DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false
    )

    if #allies == 1 then
        packTargetData.axe_alone = true
        packTargetData.denyTarget = nil
        --print('----axe alone')
    end

    local bestDeny = nil
    local lowestHP = 50.1
    for _, ally in pairs(allies) do
        if ally and not ally:IsNull() and ally:IsAlive() and ally:GetHealthPercent() < lowestHP then
            lowestHP = ally:GetHealthPercent()
            bestDeny = ally
        end
    end
    if not packTargetData.axe_alone then
        packTargetData.denyTarget = bestDeny
    end
    packTargetData.somebodyNear = true
    local target = enemies[1]
    local dist = (target:GetAbsOrigin() - pos):Length2D()

    if (packTargetData.state == 'idle' or packTargetData.state == 'retreat' or packTargetData.state == 'prepare') and dist <= rangeAggro then
        packTargetData.state = 'aggro'
        packTargetData.target = target
    elseif packTargetData.state == 'aggro' then
        if dist > rangeRetreat or not target:IsAlive() then
            packTargetData.state = 'retreat'
            packTargetData.target = nil
        else
            packTargetData.target = target
        end
    elseif packTargetData.state == 'retreat' and dist > rangeAggro then
        packTargetData.state = 'idle'
    end

    --print('--- beacon battle')
    return BATTLE_THINK_INTERVAL
end

function PackManager:HasActiveFights()
    for _, pack in EntityData:AllByType("pack") do
        if pack.state == 'aggro' then return true end
    end
    return false
end

return PackManager
