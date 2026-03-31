BarrelClick = BarrelClick or class({})

local MINIGAME_DURATION = 45.0 
local INITIAL_SPAWN_INTERVAL = 1.2 
local MIN_SPAWN_INTERVAL = 0.3 
local BARREL_LIFETIME = 2.0 
local MAX_MULTIPLIER = 3.0
local AREA_RADIUS = 600

function BarrelClick:Init(playerID, hero, betAmount, centerVector)
    self.nPlayerID = playerID
    self.hHero = hero
    self.nBetAmount = betAmount
    self.vCenter = centerVector
    
    self.fStartTime = GameRules:GetGameTime()
    self.fCurrentMultiplier = 0.0
    self.fCurrentSpawnInterval = INITIAL_SPAWN_INTERVAL
    self.bIsRunning = true
    self.hActiveBarrels = {}

    CustomNetTables:SetTableValue("minigame_stats", "barrel_multiplier_" .. tostring(playerID), { 
        multiplier = 0,
        endTime = self.fStartTime + MINIGAME_DURATION 
    })

    self:SpawnLoop()
    self:UpdateLoop()
end

function BarrelClick:SpawnLoop()
    if not self.bIsRunning then return end

    -- Calculate random position in circle
    local spawnPos = self.vCenter + RandomVector(RandomFloat(0, AREA_RADIUS))
    
    -- Create the barrel unit
    -- Note: Ensure you have "npc_dota_minigame_barrel" defined in your npc_units_custom.txt
    local barrel = CreateUnitByName("npc_dota_minigame_barrel", spawnPos, true, nil, nil, DOTA_TEAM_NEUTRALS)
    barrel:AddNewModifier(nil, nil, "modifier_phased", {duration = -1})
    
    local barrelEntIndex = barrel:GetEntityIndex()
    self.hActiveBarrels[barrelEntIndex] = true

    -- Set timer for barrel expiration (The Fail Condition)
    Timers:CreateTimer(BARREL_LIFETIME, function()
        if IsValidEntity(barrel) and barrel:IsAlive() then
            self:EndGame(false) -- Player failed to click in time
        end
    end)

    -- Schedule next spawn with increasing pace
    local elapsed = GameRules:GetGameTime() - self.fStartTime
    local progress = math.min(elapsed / MINIGAME_DURATION, 1.0)
    self.fCurrentSpawnInterval = Lerp(progress, INITIAL_SPAWN_INTERVAL, MIN_SPAWN_INTERVAL)

    Timers:CreateTimer(self.fCurrentSpawnInterval, function()
        if elapsed < MINIGAME_DURATION and self.bIsRunning then
            self:SpawnLoop()
        elseif elapsed >= MINIGAME_DURATION then
            self:EndGame(true) -- Success!
        end
    end)
end

function BarrelClick:UpdateLoop()
    Timers:CreateTimer(0.1, function()
        if not self.bIsRunning then return nil end

        local elapsed = GameRules:GetGameTime() - self.fStartTime
        local progress = math.min(elapsed / MINIGAME_DURATION, 1.0)
        
        -- Multiplier scales from 0 to MAX_MULTIPLIER
        self.fCurrentMultiplier = progress * MAX_MULTIPLIER
        
        -- Update NetTable for UI
        CustomNetTables:SetTableValue("minigame_stats", "barrel_multiplier_" .. tostring(self.nPlayerID), { 
            multiplier = self.fCurrentMultiplier 
        })

        return 0.1
    end)
end

-- Call this function from your item's OnSpellStart logic
function BarrelClick:OnBarrelClicked(barrelHandle)
    if not self.bIsRunning then return end

    local entIndex = barrelHandle:GetEntityIndex()
    if self.hActiveBarrels[entIndex] then
        self.hActiveBarrels[entIndex] = nil
        
        -- Visual/Sound effect
        EmitSoundOn("Hero_Ratchet.Spatula.Impact", barrelHandle)
        local pfx = ParticleManager:CreateParticle("particles/dev/library/base_dust_hit.vpcf", PATTACH_ABSORIGIN, barrelHandle)
        ParticleManager:ReleaseParticleIndex(pfx)

        barrelHandle:Kill(nil, self.hHero)
    end
end

function BarrelClick:EndGame(bSuccess)
    if not self.bIsRunning then return end
    self.bIsRunning = false

    local finalPayout = 0
    if bSuccess then
        finalPayout = math.floor(self.nBetAmount * self.fCurrentMultiplier)
        self.hHero:ModifyGold(finalPayout, true, DOTA_ModifyGold_Unspecified)
        print("Minigame Complete! Multiplier: " .. self.fCurrentMultiplier .. " Payout: " .. finalPayout)
    else
        print("Minigame Failed! Barrel expired.")
    end

    -- Cleanup
    for entIndex, _ in pairs(self.hActiveBarrels) do
        local unit = EntIndexToHScript(entIndex)
        if IsValidEntity(unit) then unit:ForceKill(false) end
    end
    
    -- Notify UI
    CustomNetTables:SetTableValue("minigame_stats", "barrel_multiplier_" .. tostring(self.nPlayerID), { 
        multiplier = self.fCurrentMultiplier,
        isOver = true,
        success = bSuccess
    })
end

return BarrelClick