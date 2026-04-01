BarrelClick = BarrelClick or class({})

local MINIGAME_DURATION = 25.0
local INITIAL_SPAWN_START_INTERVAL = 1.2
local INITIAL_SPAWN_END_INTERVAL = 0.6
local TIER_STEP = 0.2
local BARREL_LIFETIME = 2.0
local AREA_RADIUS = 600
local BARREL_BOUNTY = 20

function BarrelClick:Init()
    self.tier = 1
    self.startInterval = INITIAL_SPAWN_START_INTERVAL
    self.endInterval = INITIAL_SPAWN_END_INTERVAL

    GameEvents:OnGameInProgress(function()
        self.tierTextEnt = Entities:FindByName(nil, "barrel_click_tier_text")
        assert(self.tierTextEnt)
    end)
end

function BarrelClick:Start(playerID)
    if self.isRunning then return end

    local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
    assert(hero)

    self.giverNPC = Entities:FindByName(nil, "npc_brewmaster")
    assert(self.giverNPC)
    Dialogue:ShowDialogueBubbleEx(self.giverNPC, "Ломай бочки!", 2)

    self.item = SafeGiveItem(playerID, "item_barrel_hammer")

    self.playerID = playerID
    self.hero = hero
    self.startTime = GameRules:GetGameTime()

    self.currentSpawnInterval = self.startInterval
    self.isRunning = true
    self.activeBarrels = {}

    self.center = Entities:FindByName(nil, "barrel_click_center")
    assert(self.center)
    self.center = self.center:GetAbsOrigin()

    self:SpawnLoop()
end

function BarrelClick:SpawnLoop()
    if not self.isRunning then return end

    local spawnPos = self.center + RandomVector(RandomFloat(0, AREA_RADIUS))

    local barrel = CreateUnitByName("npc_minigame_barrel", spawnPos, true, nil, nil, DOTA_TEAM_NEUTRALS)
    barrel:AddNewModifier(nil, nil, "modifier_invulnerable", { duration = -1 })

    local barrelEntIndex = barrel:GetEntityIndex()
    self.activeBarrels[barrelEntIndex] = true

    Timers:CreateTimer(BARREL_LIFETIME, function()
        if IsValidEntity(barrel) and barrel:IsAlive() then
            self:EndGame(false)
        end
    end)

    local elapsed = GameRules:GetGameTime() - self.startTime
    local progress = math.min(elapsed / MINIGAME_DURATION, 1.0)
    self.currentSpawnInterval = self.startInterval - progress * (self.startInterval - self.endInterval)

    Timers:CreateTimer(self.currentSpawnInterval, function()
        if elapsed < MINIGAME_DURATION and self.isRunning then
            self:SpawnLoop()
        elseif elapsed >= MINIGAME_DURATION then
            self:EndGame(true)
        end
    end)
end

function BarrelClick:OnBarrelClicked(barrelHandle)
    if not self.isRunning then return end

    local entIndex = barrelHandle:GetEntityIndex()
    if self.activeBarrels[entIndex] then
        self.activeBarrels[entIndex] = nil

        self.hero:ModifyGold(BARREL_BOUNTY, true, DOTA_ModifyGold_BountyRune)

        EmitSoundOn("Hero_Ratchet.Spatula.Impact", barrelHandle)
        local pfx = ParticleManager:CreateParticle("particles/dev/library/base_dust_hit.vpcf", PATTACH_ABSORIGIN,
            barrelHandle)
        ParticleManager:ReleaseParticleIndex(pfx)
        local pfx = ParticleManager:CreateParticle(
            "particles/units/heroes/hero_bounty_hunter/bounty_hunter_cutpurse.vpcf", PATTACH_ABSORIGIN,
            barrelHandle)
        ParticleManager:SetParticleControl(pfx, 1, self.hero:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(pfx)

        barrelHandle:EmitSound("barrel_click.coin")

        UTIL_Remove(barrelHandle)
    end
end

function BarrelClick:EndGame(success)
    if not self.isRunning then return end
    self.isRunning = false


    if self.item:GetContainer() then
        UTIL_Remove(self.item:GetContainer())
    end
    UTIL_Remove(self.item)

    if success then
        self.tier = self.tier + 1
        self.startInterval = self.startInterval - TIER_STEP
        self.endInterval = self.endInterval - TIER_STEP
        self.tierTextEnt:SetMessage(tostring(self.tier))
        Dialogue:ShowDialogueBubbleEx(self.giverNPC, "Молодец! В следующий раз будет сложнее!", 5)
    else
        Dialogue:ShowDialogueBubbleEx(self.giverNPC, "Попробуй еще раз!", 5)
    end

    for entIndex, _ in pairs(self.activeBarrels) do
        local unit = EntIndexToHScript(entIndex)
        if IsValidEntity(unit) then unit:ForceKill(false) end
    end
end

return BarrelClick
