Music = Music or class {}

local EPS = 0.001

local PlayerMusicState = class {}
function PlayerMusicState:constructor()
    self.current = nil
    self.fade = nil
    self.lastInCombat = -1000
    self.isBoss = false
    self.customMusic = nil
end

function Music:Init(game)
    self.game = game
    self.musicState = {}
    for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        self.musicState[playerID] = PlayerMusicState()
    end

    GameEvents:OnHeroInGame(function(hero)
        local player = PlayerResource:GetPlayer(hero:GetPlayerID())
        if not player then return end

        -- EmitGlobalSound("Music.Forest.Explore")
        -- Timers:CreateTimer(22.326, function()
        --     EmitGlobalSound("Music.Forest.Combat")
        -- end)

        hero:SetContextThink("MusicThinker", function()
            local playerID = hero:GetPlayerID()
            local state = self.musicState[playerID]
            local newSound = "Music.Forest.Explore"
            local t0 = GameRules:GetGameTime()

            if hero:IsAttacking() then
                state.lastInCombat = t0
            end

            if t0 - state.lastInCombat <= COMBAT_MUSIC_MIN_LENGTH then
                newSound = "Music.Forest.Combat"
            end

            if state.current ~= newSound then
                EmitGlobalSound(newSound)
                state.current = newSound
            end

            return 0.05
        end, 0.05)
        -- self:CrossfadeTo(hero:GetPlayerID(), "Music.Forest.Explore", 5)
        -- Timers:CreateTimer(15, function()
        --     self:CrossfadeTo(hero:GetPlayerID(), "Music.Forest.Combat", 3)
        -- end)
    end)
end

function Music:CrossfadeTo(playerID, newSound, fadeSeconds)
    DebugPrint("Start crossfade to " .. newSound)
    fadeSeconds = fadeSeconds or 2
    local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
    if not hero or hero:IsNull() then return end

    local state = self.musicState[playerID]
    local oldSound = state.current
    if oldSound == newSound then return end

    local startOldVol = 1.0
    local startNewVol = EPS

    if state.fade then
        startOldVol = state.fade.oldVol or startOldVol
        startNewVol = state.fade.newVol or startNewVol
    end

    startOldVol = math.max(startOldVol, EPS)
    startNewVol = math.max(startNewVol, EPS)

    if oldSound then
        hero:EmitSound(oldSound)
        hero:EmitSoundParams(oldSound, 0, math.max(startOldVol, EPS), 0)
    end
    hero:EmitSound(newSound)
    hero:EmitSoundParams(newSound, 0, math.max(startNewVol, EPS), 0)

    local t0 = GameRules:GetGameTime()
    state.fade = {
        t0 = t0,
        dur = fadeSeconds,
        oldSound = oldSound,
        newSound = newSound,
        oldVol0 = oldSound and startOldVol or nil,
        newVol0 = startNewVol,
        oldVol = oldSound and startOldVol or nil,
        newVol = startNewVol
    }

    hero:SetContextThink("MusicCrossfade_" .. tostring(playerID), function()
        return self:FadeThink(playerID)
    end, 0.1)
end

local function clamp(x)
    if x < 0 then return 0 end
    if x > 1 then return 1 end
    return x
end

local function lerp(a, b, t)
    return a + (b - a) * t
end

function Music:FadeThink(playerID)
    local state = self.musicState[playerID]
    local f = state.fade
    if not f then return nil end

    PrintTable(f)

    local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
    if not hero then
        state.fade = nil
        return nil
    end

    local t = (GameRules:GetGameTime() - f.t0) / f.dur
    t = clamp(t)

    local newVol = lerp(f.newVol0, 1.0, t)

    hero:EmitSoundParams(f.newSound, 0, math.max(newVol, EPS), 0)
    f.newVol = newVol

    if f.oldSound then
        local oldVol = lerp(f.oldVol0, EPS, t)
        hero:EmitSoundParams(f.oldSound, 0, math.max(oldVol, EPS), 0)
        f.oldVol = oldVol
    end

    if t >= 1.0 then
        if f.oldSound then
            StopSoundOn(f.oldSound, hero)
        end
        state.current = f.newSound
        state.f = nil
        return nil
    end

    return 0.1
end

return Music
