PackManager = PackManager or {}

function PackManager:Init()
    GameEvents:OnGameInProgress(bind(self.OnGameInProgress, self))
    ChatCommand:LinkDevCommand("-junglerespawn", function(event, args)
    self:RespawnPack(args[1])
  end)
end

function PackManager:OnGameInProgress()
    if not IsServer() then return end
    for packTargetName, packData in EntityData:AllByType('pack') do
        if packData.activateAfterUnitsSpawned then
            self:ActivatePackTarget(packTargetName)
            print('pack target activated')
        end
    end
end

function PackManager:ActivatePackTarget(packTargetName)
    if not packTargetName then return end
    local packTargetData = EntityData:ByName(packTargetName)
    local packTargetEntity = Entities:FindByName(nil, packTargetName)
    if not packTargetEntity then
        DebugPrint("[ALNOIRE](PackManager) no entity for pack: ", packTargetName)
        return
    end
    DrawDebugCircle(packTargetEntity, packTargetData.rangeAggro)
    DrawDebugCircle(packTargetEntity, packTargetData.rangeRetreat)
    DrawDebugCircle(packTargetEntity, packTargetData.rangeFastTickRate)

    if packTargetData.thinker == "default" then
        packTargetEntity:SetContextThink("PackTargetDefaultThink", function()
        return self:PackTargetDefaultThink(packTargetEntity, packTargetData) 
        end, IDLE_THINK_INTERVAL)

    elseif packTargetData.thinker == "axe" then
        packTargetEntity:SetContextThink("PackTargetDenyThink", function()
        return self:PackTargetDenyThink(packTargetEntity, packTargetData) 
        end, IDLE_THINK_INTERVAL)


    else
        DebugPrint("[ALNOIRE](PackManager) no such thinker for name: ", packTargetData.thinker)
    end
    packTargetData.state = 'idle'
end


function PackManager:RespawnPack(packTargetName)
    
end

function PackManager:PackTargetDefaultThink(packTargetEnt, packTargetData)
    if not packTargetEnt or packTargetEnt:IsNull() then return nil end
    if not packTargetData or packTargetData:IsNull() then return nil end
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