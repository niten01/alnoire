BarrelClick = BarrelClick or class({})

local MINIGAME_DURATION = 45.0
local INITIAL_SPAWN_INTERVAL = 1.2
local MIN_SPAWN_INTERVAL = 0.1
local BARREL_LIFETIME = 2.0
local MAX_MULTIPLIER = 3.0
local AREA_RADIUS = 600
local BET_AMOUNT = 200

function BarrelClick:Init()
    self.betAmount = BET_AMOUNT
end

function BarrelClick:Start(playerID)
    if self.isRunning then return end

    local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
    assert(hero)

    self.giverNPC = Entities:FindByName(nil, "npc_brewmaster")
    assert(self.giverNPC)
    if hero:GetGold() < BET_AMOUNT then
        Dialogue:ShowDialogueBubbleEx(self.giverNPC, "Возвращайся когда накопишь " .. tostring(BET_AMOUNT) .. " золота!",
            5)
        return
    else
        Dialogue:ShowDialogueBubbleEx(self.giverNPC, "Ломай бочки!", 2)
        hero:ModifyGold(-BET_AMOUNT, true, DOTA_ModifyGold_PurchaseItem)
    end

    hero:AddItemByName("item_barrel_hammer")

    local ptName = "barrel_click_" .. tostring(playerID)
    if not PlayerTables:TableExists(ptName) then
        PlayerTables:CreateTable(ptName, {
            multiplier = 0,
        })
    end

    self.playerID = playerID
    self.hero = hero
    self.startTime = GameRules:GetGameTime()

    self.currentMultiplier = 0.0
    self.currentSpawnInterval = INITIAL_SPAWN_INTERVAL
    self.isRunning = true
    self.activeBarrels = {}

    self.center = Entities:FindByName(nil, "barrel_click_center")
    assert(self.center)
    self.center = self.center:GetAbsOrigin()

    self:SpawnLoop()
    self:UpdateLoop()
end

function BarrelClick:SpawnLoop()
    if not self.isRunning then return end

    local spawnPos = self.center + RandomVector(RandomFloat(0, AREA_RADIUS))

    local barrel = CreateUnitByName("npc_minigame_barrel", spawnPos, true, nil, nil, DOTA_TEAM_NEUTRALS)
    barrel:AddNewModifier(nil, nil, "modifier_gorilla_invulnerable", { duration = -1 })

    local barrelEntIndex = barrel:GetEntityIndex()
    self.activeBarrels[barrelEntIndex] = true

    Timers:CreateTimer(BARREL_LIFETIME, function()
        if IsValidEntity(barrel) and barrel:IsAlive() then
            self:EndGame(false)
        end
    end)

    local elapsed = GameRules:GetGameTime() - self.startTime
    local progress = math.min(elapsed / MINIGAME_DURATION, 1.0)
    self.currentSpawnInterval = INITIAL_SPAWN_INTERVAL - progress * (INITIAL_SPAWN_INTERVAL - MIN_SPAWN_INTERVAL)

    Timers:CreateTimer(self.currentSpawnInterval, function()
        if elapsed < MINIGAME_DURATION and self.isRunning then
            self:SpawnLoop()
        elseif elapsed >= MINIGAME_DURATION then
            self:EndGame(true)
        end
    end)
end

function BarrelClick:UpdateLoop()
    Timers:CreateTimer(0.1, function()
        if not self.isRunning then return nil end

        local elapsed = GameRules:GetGameTime() - self.startTime
        local progress = math.min(elapsed / MINIGAME_DURATION, 1.0)

        self.currentMultiplier = progress * MAX_MULTIPLIER

        PlayerTables:SetTableValue("barrel_click_" .. tostring(self.playerID), {
            multiplier = self.currentMultiplier
        })

        return 0.1
    end)
end

function BarrelClick:OnBarrelClicked(barrelHandle)
    if not self.isRunning then return end

    local entIndex = barrelHandle:GetEntityIndex()
    if self.activeBarrels[entIndex] then
        self.activeBarrels[entIndex] = nil

        EmitSoundOn("Hero_Ratchet.Spatula.Impact", barrelHandle)
        local pfx = ParticleManager:CreateParticle("particles/dev/library/base_dust_hit.vpcf", PATTACH_ABSORIGIN,
            barrelHandle)
        ParticleManager:ReleaseParticleIndex(pfx)

        barrelHandle:Kill(nil, self.hero)
    end
end

function BarrelClick:EndGame(success)
    if not self.isRunning then return end
    self.isRunning = false

    Dialogue:ShowDialogueBubbleEx(self.giverNPC, "Вот твой выигрыш!", 5)

    local finalPayout = 0
    if success then
        finalPayout = math.floor(self.betAmount * self.currentMultiplier)
        self.hero:ModifyGold(finalPayout, true, DOTA_ModifyGold_BountyRune)
    else
    end

    for entIndex, _ in pairs(self.activeBarrels) do
        local unit = EntIndexToHScript(entIndex)
        if IsValidEntity(unit) then unit:ForceKill(false) end
    end
end

return BarrelClick
