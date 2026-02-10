PackManager = PackManager or {}

function PackManager:Init()
    GameEvents:OnGameInProgress(bind(self.OnGameInProgress, self))
    ChatCommand:LinkDevCommand("-junglerespawn", function(event, args)
    self:SpawnPack(args[1])
  end)
end

function PackManager:OnGameInProgress()
    if not IsServer() then return end
    for packTargetName, packData in EntityData:AllByType('pack') do
        self:SpawnPack(packTargetName)
    end
    
end

function PackManager:SpawnPack(packTargetName)
    DebugPrint("[ALNOIRE] Trying to spawn pack: ", packTargetName)
    local data = EntityData:ByName(packTargetName)
    local packTargetEntity = Entities:FindByName(nil, packTargetName)
    if not packTargetEntity then
        DebugPrint("[ALNOIRE] No packTargetEntity was found for: ", packTargetName)
        return
    end
    packTargetEntity.state = data.state or "idle"
    packTargetEntity.data = data

    packTargetEntity.units = {}
    
    for _, foe in pairs(data.foes) do
        local unitName = foe.unitName
        local spawner = foe.spawnPoint
        for _, spawnerEnt in ipairs(Entities:FindAllByName(spawner)) do
            local abs = spawnerEnt:GetAbsOrigin()
            CreateUnitByNameAsync(
                unitName,
                abs,
                false,
                nil,
                nil,
                DOTA_TEAM_BADGUYS,
                function (unit)
                    unit.packTarget = packTargetEntity
                    unit.spawnPos = abs
                    table.insert(packTargetEntity.units, unit)
                end
            )
            
            DebugPrint("[ALNOIRE] Created pack unit: ", unitName)
        end
    end

    DrawDebugCircle(packTargetEntity, data.rangeAggro)
    DrawDebugCircle(packTargetEntity, data.rangeRetreat)
    DrawDebugCircle(packTargetEntity, data.rangeFastTickRate)

    if data.thinker == "default" then
        packTargetEntity:SetContextThink("PackTargetDefaultThink", function()
        return self:PackTargetDefaultThink(packTargetEntity) 
        end, IDLE_THINK_INTERVAL)

    elseif data.thinker == "axe" then
        packTargetEntity:SetContextThink("PackTargetDenyThink", function()
        return self:PackTargetDenyThink(packTargetEntity) 
        end, IDLE_THINK_INTERVAL)
    end

    
end

function PackManager:PackTargetDefaultThink(packTargetEntity)
    if not packTargetEntity or packTargetEntity:IsNull() then return nil end

    if not AnyAlive(packTargetEntity) then
        print("[ALNOIRE] All units in pack " .. packTargetEntity:GetName() .. " are dead. Disabling beacon thinker.")
        packTargetEntity.state = "dead"
        return nil
    end


    print(packTargetEntity.state)
    local data = packTargetEntity.data
    local pos = packTargetEntity:GetAbsOrigin()

    local enemies = FindUnitsInRadius(
        DOTA_TEAM_BADGUYS,               
        pos,
        nil,
        data.rangeFastTickRate, 
        DOTA_UNIT_TARGET_TEAM_ENEMY,    
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
        FIND_CLOSEST,
        false
    )
    if #enemies == 0 then
        packTargetEntity.state = "idle"
        packTargetEntity.target = nil
        packTargetEntity.somebodyNear = false
        return IDLE_THINK_INTERVAL
    end

    packTargetEntity.somebodyNear = true
    local target = enemies[1]
    local dist = (target:GetAbsOrigin() - pos):Length2D()

    if (packTargetEntity.state == 'idle' or packTargetEntity.state == 'retreat' or packTargetEntity.state == 'prepare') and dist <= data.rangeAggro then
        packTargetEntity.state = 'aggro'
        packTargetEntity.target = target

    elseif packTargetEntity.state == 'aggro' then
        if dist > data.rangeRetreat or not target:IsAlive() then
            packTargetEntity.state = 'retreat'
            packTargetEntity.target = nil
        else
            packTargetEntity.target = target
        end

    elseif packTargetEntity.state == 'retreat' and dist > data.rangeAggro then
        packTargetEntity.state = 'idle'
    end

    return BATTLE_THINK_INTERVAL
end


function PackManager:PackTargetDenyThink(packTargetEntity)
    if not packTargetEntity or packTargetEntity:IsNull() then return nil end

    if not AnyAlive(packTargetEntity) then
        print("[ALNOIRE] All units in pack " .. packTargetEntity:GetName() .. " are dead. Disabling beacon thinker.")
        packTargetEntity.state = "dead"
        return nil
    end

    local data = packTargetEntity.data
    local pos = packTargetEntity:GetAbsOrigin()

    local enemies = FindUnitsInRadius(
        DOTA_TEAM_BADGUYS, pos, nil, data.rangeFastTickRate, 
        DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS + DOTA_UNIT_TARGET_FLAG_NOT_ATTACK_IMMUNE,
        FIND_CLOSEST, false
    )


    if #enemies == 0 then
        packTargetEntity.state = "idle"
        packTargetEntity.target = nil
        packTargetEntity.denyTarget = nil 
        packTargetEntity.somebodyNear = false
        print('--- beacon idle')
        return IDLE_THINK_INTERVAL
    end

    local allies = FindUnitsInRadius(
        DOTA_TEAM_BADGUYS, pos, nil, data.rangeFastTickRate,
        DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_HERO,
        DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false
    )

    if #allies == 1 then
        packTargetEntity.axe_alone = true
        packTargetEntity.denyTarget = nil
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
    if not packTargetEntity.axe_alone then
        packTargetEntity.denyTarget = bestDeny 
    end
    packTargetEntity.somebodyNear = true
    local target = enemies[1]
    local dist = (target:GetAbsOrigin() - pos):Length2D()

    if (packTargetEntity.state == 'idle' or packTargetEntity.state == 'retreat' or packTargetEntity.state == 'prepare') and dist <= data.rangeAggro then
        packTargetEntity.state = 'aggro'
        packTargetEntity.target = target

    elseif packTargetEntity.state == 'aggro' then
        if dist > data.rangeRetreat or not target:IsAlive() then
            packTargetEntity.state = 'retreat'
            packTargetEntity.target = nil
        else
            packTargetEntity.target = target
        end

    elseif packTargetEntity.state == 'retreat' and dist > data.rangeAggro then
        packTargetEntity.state = 'idle'
    end

    --print('--- beacon battle')
    return BATTLE_THINK_INTERVAL
end


return PackManager