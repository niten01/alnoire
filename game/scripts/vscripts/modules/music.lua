Music = Music or {}

local PlayerMusicState = class {}
function PlayerMusicState:constructor()
    self.musicSet = "silence"
    self.current = nil
    self.lastInCombat = -1000
    self.isBoss = false
    self.customMusic = nil
end

function Music:Init()
    self.musicState = {}
    for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        self.musicState[playerID] = PlayerMusicState()
    end

    GameEvents:OnZoneEnter(function(event)
        DebugPrint("[ALNOIRE] Switching music set: " .. event.musicSet)
        self.musicState[event.playerID].musicSet = event.musicSet
    end)
    GameEvents:OnHeroInGame(function(hero)
        DebugPrint("[ALNOIRE] Starting music thinker for hero: " .. hero:GetName())
        hero:SetContextThink("MusicThinker", function()
            return self:HeroMusicThink(hero)
        end, MUSIC_THINK_INTERVAL)
    end)
    GameEvents:OnDialogueStart(bind(self.OnDialogueStart, self))
    GameEvents:OnEntityKilled(bind(self.OnEntityKilled, self))
end

function Music:StartCustomMusic(playerID, soundName)
    DebugPrint("[ALNOIRE] Set custom music: " .. soundName)
    local state = self.musicState[playerID]
    state.customMusic = soundName
    state.current = nil
    EmitGlobalSound(soundName)
end

function Music:StopCustomMusic(playerID)
    self.musicState[playerID].customMusic = nil
end

function Music:HeroMusicThink(hero)
    if not IsServer() then return end
    local playerID = hero:GetPlayerID()
    local state = self.musicState[playerID]
    if not state then return end

    if state.customMusic then return MUSIC_THINK_INTERVAL end
    if not state.musicSet then return MUSIC_THINK_INTERVAL end

    local newSoundZone = "music." .. state.musicSet
    local newSoundState = "explore"
    local t0 = GameRules:GetGameTime()

    if PackManager:HasActiveFights() then
        state.lastInCombat = t0
    end

    if t0 - state.lastInCombat <= MUSIC_COMBAT_DECAY then
        newSoundState = "combat"
    end

    local newSound = newSoundZone .. "." .. newSoundState
    if state.current ~= newSound then
        DebugPrint("[ALNOIRE] Change music state: " .. newSound)
        EmitGlobalSound(newSound)
        state.current = newSound
    end

    return MUSIC_THINK_INTERVAL
end

function Music:OnDialogueStart(event)
    local playerID = event.playerID
    local nodeID = event.startNodeID
    if nodeID == "d_xavierfightstart" or nodeID == "d_xavierfightagain" then
        self:StartCustomMusic(playerID, "music.concert.precombat")
    end
end

function Music:OnEntityKilled(event)
    local victim = event.killed_unit
    if victim:IsRealHero() and not victim:IsSpiritBearCustom() then
        local playerID = victim:GetPlayerOwnerID()
        self:StopCustomMusic(playerID)
        self.musicState[playerID].musicSet = "silence"
        Timers:CreateTimer(CUSTOM_RESPAWN_TIME+5, function()
            StopGlobalSound(self.musicState[playerID].current)
            EmitGlobalSound(self.musicState[playerID].current)
        end)
    end
end

return Music
