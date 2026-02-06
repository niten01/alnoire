PackManager = PackManager or {}

function PackManager:Init()
    GameEvents:OnGameInProgress(bind(self.OnGameInProgress, self))
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
                end
            )
            DebugPrint("[ALNOIRE] Created pack unit: ", unitName)
        end
    end

    self:DrawDebugCircle(packTargetEntity, data.rangeAggro)
    self:DrawDebugCircle(packTargetEntity, data.rangeRetreat)
    self:DrawDebugCircle(packTargetEntity, data.rangeFastTickRate)
    packTargetEntity:SetContextThink("PackTargetDefaultThink", function()
        return self:PackTargetDefaultThink(packTargetEntity)
    end, IDLE_THINK_INTERVAL)
end

function PackManager:PackTargetDefaultThink(packTargetEntity)
    if not packTargetEntity or packTargetEntity:IsNull() then return nil end
    --print(packTargetEntity.state)
    local data = packTargetEntity.data
    local pos = packTargetEntity:GetAbsOrigin()

    local enemies = FindUnitsInRadius(
        DOTA_TEAM_BADGUYS,                -- Мы знаем, что ищем для "плохих парней"
        pos,
        nil,
        data.rangeFastTickRate, 
        DOTA_UNIT_TARGET_TEAM_ENEMY,      -- Враги для Bad Guys (Radiant/Dire)
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_FOW_VISIBLE + DOTA_UNIT_TARGET_FLAG_NO_INVIS,
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


function PackManager:DrawDebugCircle(entity, radius)
    local pfx = ParticleManager:CreateParticle("particles/sanya_debug_radius_ring.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, entity:GetAbsOrigin()) 
    ParticleManager:SetParticleControl(pfx, 2, Vector(radius, 0, 0)) 
    return pfx
end

return PackManager