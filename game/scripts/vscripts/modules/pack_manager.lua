PackManager = PackManager or {}

function PackManager:Init()
    GameEvents:OnGameInProgress(bind(self.OnGameInProgress, self))
    ChatCommand:LinkDevCommand("-junglerespawn", function(event, args)
        self:RespawnPack(args[1])
    end)
end

function PackManager:OnGameInProgress()
    if not IsServer() then return end
    for packName, packData in EntityData:AllByType('pack') do
        PrintTable(packData, 2)
        if packData.activateAfterUnitsSpawned then
            self:ActivatePackTarget(packName)
        end
    end
end

function PackManager:ActivatePackTarget(packName)
    DebugPrint("[ALNOIRE] Activating pack: " .. packName)
    assert(packName)
    local pack = self:GetPack(packName)
    if pack.state ~= 'off' then
        DebugPrint("[???] (PackManager) skipping already activated pack")
        return
    end
    local packEntity = Entities:FindByName(nil, packName)
    if not packEntity then
        DebugPrint("[???] (PackManager) no entity for pack: ", packName)
        return
    end
    DrawDebugCircle(packEntity, pack.rangeAggro)
    DrawDebugCircle(packEntity, pack.rangeRetreat)
    DrawDebugCircle(packEntity, pack.rangeFastTickRate)

    if pack.thinker == "default" then
        packEntity:SetContextThink("PackTargetDefaultThink", function()
            return self:PackTargetDefaultThink(packEntity, pack)
        end, IDLE_THINK_INTERVAL)
    elseif pack.thinker == "axe" then
        packEntity:SetContextThink("PackTargetDenyThink", function()
            return self:PackTargetDenyThink(packEntity, pack)
        end, IDLE_THINK_INTERVAL)
    else
        DebugPrint("[ALNOIRE](PackManager) no such thinker for name: ", pack.thinker)
    end
    pack.state = 'idle'
end

function PackManager:AddUnit(packName, npc)
    local pack = self:GetPack(packName)
    assert(pack, "Invalid packName")
    table.insert(pack.units, npc)
    npc.packTargetData = pack
    DebugPrint("[ALNOIRE] Added " .. npc:GetName() .. " to pack: " .. packName)
end

function PackManager:RespawnPack(packTargetName)
    local pack = self:GetPack(packTargetName)
end

function PackManager:GetPack(packName)
    return EntityData:ByName(packName)
end

function PackManager:PackTargetDefaultThink(packTargetEnt, packTargetData)
    if not packTargetEnt or packTargetEnt:IsNull() then return nil end
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
    if #enemies == 0 then
        packTargetData.state = "idle"
        packTargetData.target = nil
        packTargetData.somebodyNear = false
        return IDLE_THINK_INTERVAL
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
        print('--- beacon idle')
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

return PackManager
