SpawnManager = SpawnManager or class {}

function SpawnManager:Init(game)
    self.game = game

    GameEvents:OnHeroInGame(bind(self.OnHeroInGame, self))
    GameEvents:OnGameInProgress(bind(self.OnGameInProgress, self))
    GameEvents:OnNPCSpawned(bind(self.OnNPCSpawned, self))
end

function SpawnManager:OnGameInProgress()
    if not IsServer() then return end

    for entName, spawnerData in pairs(EntityData:AllByType("spawner")) do
        for _, marker in ipairs(Entities:FindAllByName(entName)) do
            DebugPrint("[ALNOIRE] Spawner entity found: ", entName)
            self:SpawnNPC(spawnerData, marker)
        end
    end
end

function SpawnManager:OnHeroInGame(hero)
    if not IsServer() then return end

    if not hero:HasModifier("modifier_anim_translate_thinker") then
        hero:AddNewModifier(hero, nil, "modifier_anim_translate_thinker", { duration = -1 })
    end
    --hero:AddNewModifier(hero, nil, "modifier_test_eyes", { duration = -1 })

    ChatCommand:LinkCommand("-a", function()
        DebugPrint("sdkfjalksdf")
        hero:ApplyAbsVelocityImpulse(Vector(100, 0, 0))
    end)
end

function SpawnManager:SpawnNPC(spawnerData, marker)
    local npc = CreateUnitByName(
        spawnerData.npc,
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

    if spawnerData.type == "story" then
        npc:SetIdleAcquire(false)
        npc:SetAcquisitionRange(0)

        npc:AddNewModifier(npc, nil, "modifier_invulnerable", {})
        npc:AddNewModifier(npc, nil, "modifier_phased", {})
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

return SpawnManager
