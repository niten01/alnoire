BarrelClick = BarrelClick or class({})

local MINIGAME_DURATION = 15.0
local INITIAL_SPAWN_INTERVAL = 1.0
local TIER_INTERVAL_STEP = 0.13
local TIER_LIFETIME_STEP = 0.1
local INITIAL_BARREL_LIFETIME = 2.0
local AREA_RADIUS = 500
local BARREL_BOUNTY = 9 -- max win approx.: 1413

function BarrelClick:Init()
    self.tier = 1
    self.interval = INITIAL_SPAWN_INTERVAL
    self.lifetime = INITIAL_BARREL_LIFETIME
    self.tierRecord = 0
    self.bcsp = false

    GameEvents:OnGameInProgress(function()
        self.tierTextEnt = Entities:FindByName(nil, "barrel_click_tier_text")
        assert(self.tierTextEnt)
        self.tierRecordTextEnt = Entities:FindByName(nil, "barrel_click_tier_record_text")
        assert(self.tierRecordTextEnt)
    end)

    ChatCommand:LinkDevCommand("-bcsp", function(event, args)
        self.bcsp = not self.bcsp
    end)
end

function BarrelClick:BuildArena()
    DoEntFireByInstanceHandle(self.tierTextEnt, "Enable", "", 0, nil, nil)
    DoEntFireByInstanceHandle(self.tierRecordTextEnt, "Enable", "", 0, nil, nil)
    for _, ent in ipairs(Entities:FindAllByName("barrel_click_prop")) do
        DoEntFireByInstanceHandle(ent, "Enable", "", 0, nil, nil)
    end
end

function BarrelClick:Start(playerID)
    if self.isRunning then return end

    local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
    assert(hero)

    self.giverNPC = Entities:FindByName(nil, "npc_brewmaster_good")
    assert(self.giverNPC)
    Dialogue:ShowDialogueBubbleEx(self.giverNPC, "Ломай бочки!", 2)

    self.item = SafeGiveItem(playerID, "item_quelling_blade")

    self.playerID = playerID
    self.hero = hero
    self.startTime = GameRules:GetGameTime()

    self.isRunning = true
    self.activeBarrels = {}

    self.center = Entities:FindByName(nil, "barrel_click_center")
    assert(self.center)
    self.center = self.center:GetAbsOrigin()

    local countdown = 3
    local pfx = ParticleManager:CreateParticle(
        "particles/barrel_click_countdown.vpcf", PATTACH_OVERHEAD_FOLLOW,
        self.hero)
    ParticleManager:SetParticleControlEnt(pfx, 3, self.hero, PATTACH_OVERHEAD_FOLLOW, "", Vector(0, 0, 0), true)
    Timers:CreateTimer(0, function()
        if countdown < 0 then
            ParticleManager:DestroyParticle(pfx, false)
            ParticleManager:ReleaseParticleIndex(pfx)
            Timers:CreateTimer(0, bind(self.SpawnLoop, self))
            self.hero:EmitSound("barrel_click.start")
            return nil
        end
        ParticleManager:SetParticleControl(pfx, 2, Vector(countdown, 0, 0))
        countdown = countdown - 1
        self.hero:EmitSound("barrel_click.countdown")

        return 0.5
    end)
end

function BarrelClick:SpawnLoop()
    if not self.isRunning then return nil end

    local spawnPos = self.center + RandomVector(RandomFloat(0, AREA_RADIUS))

    local barrel = CreateUnitByName("npc_minigame_barrel", spawnPos, true, nil, nil, DOTA_TEAM_NEUTRALS)
    barrel:AddNewModifier(nil, nil, "modifier_invulnerable", { duration = -1 })

    local barrelEntIndex = barrel:GetEntityIndex()
    self.activeBarrels[barrelEntIndex] = true

    Timers:CreateTimer(self.lifetime, function()
        if IsValidEntity(barrel) and barrel:IsAlive() then
            self:EndGame(false)
        end
    end)

    local elapsed = GameRules:GetGameTime() - self.startTime

    if elapsed < MINIGAME_DURATION and self.isRunning then
        return self.interval
    elseif elapsed >= MINIGAME_DURATION then
        self:EndGame(true)
        return nil
    end
end

function BarrelClick:OnBarrelClicked(barrelHandle)
    if not self.isRunning then return end

    local entIndex = barrelHandle:GetEntityIndex()
    if self.activeBarrels[entIndex] then
        self.activeBarrels[entIndex] = nil

        local elapsed = GameRules:GetGameTime() - self.startTime
        if elapsed > self.tierRecord then
            self.hero:ModifyGold(BARREL_BOUNTY, true, DOTA_ModifyGold_BountyRune)

            local pfx = ParticleManager:CreateParticle(
                "particles/units/heroes/hero_bounty_hunter/bounty_hunter_cutpurse.vpcf", PATTACH_ABSORIGIN,
                barrelHandle)
            ParticleManager:SetParticleControlEnt(pfx, 1, self.hero, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0,
                0), false)
            ParticleManager:ReleaseParticleIndex(pfx)
            barrelHandle:EmitSound("barrel_click.coin")
        end
        barrelHandle:EmitSound("barrel_click.click")

        local pfx = ParticleManager:CreateParticle("particles/dev/library/base_dust_hit.vpcf", PATTACH_ABSORIGIN,
            barrelHandle)
        ParticleManager:ReleaseParticleIndex(pfx)

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

    local elapsed = GameRules:GetGameTime() - self.startTime
    self.tierRecord = math.max(self.tierRecord, math.min(MINIGAME_DURATION, elapsed))

    if success then
        self.tier = self.tier + 1
        self.interval = self.interval - TIER_INTERVAL_STEP
        self.lifetime = self.lifetime - TIER_LIFETIME_STEP
        self.tierTextEnt:SetMessage(tostring(self.tier))
        self.tierRecord = 0
        Dialogue:ShowDialogueBubbleEx(self.giverNPC, "Молодец! В следующий раз будет сложнее!", 5)
    else
        Dialogue:ShowDialogueBubbleEx(self.giverNPC, "Попробуй еще раз!", 5)
    end

    self.tierRecordTextEnt:SetMessage(string.format("%.0fs", self.tierRecord))

    for entIndex, _ in pairs(self.activeBarrels) do
        local unit = EntIndexToHScript(entIndex)
        if IsValidEntity(unit) then UTIL_Remove(unit) end
    end

    if self.bcsp then
        Timers:CreateTimer(1.0, function()
            self:Start(self.playerID)
        end)
    end
end

return BarrelClick
