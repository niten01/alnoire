PackManager = PackManager or {}

function PackManager:Init()
    GameEvents:OnGameInProgress(bind(self.OnGameInProgress, self))
    GameEvents:OnEntityKilled(bind(self.OnEntityKilled, self))
end

function PackManager:OnGameInProgress()
    if not IsServer() then return end

    for packTargetName, packData in pairs(EntityData:AllByType('pack')) do
        self:SpawnPack(packTargetName)
    end
    
end

function PackManager:SpawnPack(packTargetName)
    DebugPrint("[ALNOIRE] Trying to spawn pack: ", packTargetName)
    local data = EntityData:ByName(packTargetName)
    for _, packTarget in ipairs(Entities:FindAllByName(packTargetName)) do
        local origin = packTarget:GetAbsOrigin()
        DebugPrint("\tFound pack target entity: (" .. origin.x .. ";" .. origin.y .. ")")
        local npc = CreateUnitByName(
            data.npc,
            origin,
            false,
            nil,
            nil,
            data.team
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

        if not EntityData:ByName(data.npc) then
            EntityData:AddEntity("npc", data.npc, {})
        end
    end

end