SpawnManager = SpawnManager or class {}

function SpawnManager:Init(game)
    self.game = game

    GameEvents:OnHeroInGame(bind(self.OnHeroInGame, self))
    GameEvents:OnGameInProgress(bind(self.OnGameInProgress, self))
    GameEvents:OnNPCSpawned(bind(self.OnNPCSpawned, self))
end

function SpawnManager:OnGameInProgress()
    if not IsServer() then return end

    for _, marker in ipairs(Entities:FindAllByClassname("info_target")) do
        local name = marker:GetName()
        print(name)
        local isEnemy = marker:Attribute_GetIntValue("IsEnemy", 0)
        local unitName = ExtractNamePayload(name, "spawn__")
        if not unitName then return end
        DebugPrint("[ALNOIRE] Spawner entity found: ", name)
        if isEnemy ~= 0 then
            self:SpawnEnemyNpc(unitName, marker)
        else
            self:SpawnStoryNPC(unitName, marker)
        end
        
        ::continue::
    end
end

function SpawnManager:OnHeroInGame(hero)
    if not IsServer() then return end

    if not hero:HasModifier("modifier_anim_translate_thinker") then
        hero:AddNewModifier(hero, nil, "modifier_anim_translate_thinker", { duration = -1 })
    end
end

function SpawnManager:SpawnStoryNPC(name, marker)
    local npc = CreateUnitByName(
        name,
        marker:GetAbsOrigin(),
        false,
        nil,
        nil,
        DOTA_TEAM_NEUTRALS
    )
    local fwd = marker:GetForwardVector()
    fwd.z = 0
    npc:FaceTowards(npc:GetAbsOrigin() + fwd * 100)
    npc:SetForwardVector(fwd)

    npc:SetIdleAcquire(false)
    npc:SetAcquisitionRange(0)

    npc:AddNewModifier(npc, nil, "modifier_invulnerable", {})
    npc:AddNewModifier(npc, nil, "modifier_phased", {})

end

function SpawnManager:SpawnEnemyNpc(name, marker)
    local npc = CreateUnitByName(
        name,
        marker:GetAbsOrigin(),
        false,
        nil,
        nil,
        DOTA_TEAM_NEUTRALS
    )
    local fwd = marker:GetForwardVector()
    fwd.z = 0
    npc:FaceTowards(npc:GetAbsOrigin() + fwd * 100)
    npc:SetForwardVector(fwd)
end


function SpawnManager:OnNPCSpawned(keys)
    ---@type CDOTA_BaseNPC
    local unit = keys.unit
    local unitName = unit:GetUnitName()

    DebugPrint(unitName)
    if unitName == "npc_gorilla" then
        AddAnimationTranslate(unit, "torment")
    elseif unitName == "npc_rape_victim" then
        AddAnimationTranslate(unit, "torment")
    end
end

return SpawnManager