SpawnManager = SpawnManager or class {}

function SpawnManager:Init(game)
    self.game = game

    GameEvents:OnHeroInGame(bind(self.OnHeroInGame, self))
end

function SpawnManager:OnHeroInGame(hero)
    if not IsServer() then return end

    if not hero:HasModifier("modifier_anim_translate_thinker") then
        hero:AddNewModifier(hero, nil, "modifier_anim_translate_thinker", { duration = -1 })
    end

    self:SpawnStoryNPC(Vector(-200, -200, 0))
end

function SpawnManager:SpawnStoryNPC(pos)
    local npc = CreateUnitByName(
        "npc_dota_creature_gnoll_assassin",
        pos,
        true,
        nil,
        nil,
        DOTA_TEAM_NEUTRALS
    )

    npc:SetIdleAcquire(false)
    npc:SetAcquisitionRange(0)
    npc:SetForwardVector(Vector(1, 0, 0))

    npc:AddNewModifier(npc, nil, "modifier_invulnerable", {})
    npc:AddNewModifier(npc, nil, "modifier_phased", {})

    -- Start proximity polling
    -- self:StartNPCProximityThink(npc, 275)
end

return SpawnManager
