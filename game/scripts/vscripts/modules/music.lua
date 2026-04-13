Music = Music or {}

local PlayerMusicState = class {}
function PlayerMusicState:constructor()
    self.musicSet = "silence"
    self.noCombat = nil
    self.current = nil
    self.lastInCombat = -1000
    self.customMusic = nil
end

function Music:Init()
    self.musicState = {}
    for playerID = 0, DOTA_MAX_TEAM_PLAYERS - 1 do
        self.musicState[playerID] = PlayerMusicState()
    end

    GameEvents:OnZoneEnter(function(event)
        if not event.musicSet then return end -- zone has no music change
        DebugPrint("[ALNOIRE] Switching music set: " .. event.musicSet)
        local state = self.musicState[event.playerID]
        state.musicSet = event.musicSet
        state.noCombat = event.noCombatMusic
    end)
    GameEvents:OnHeroInGame(function(hero)
        DebugPrint("[ALNOIRE] Starting music thinker for hero: " .. hero:GetName())
        hero:SetContextThink("MusicThinker", function()
            return self:HeroMusicThink(hero)
        end, MUSIC_THINK_INTERVAL)
    end)
    GameEvents:OnDialogueStart(bind(self.OnDialogueStart, self))
    GameEvents:OnEntityKilled(bind(self.OnEntityKilled, self))
    GameEvents:OnPackWiped(bind(self.OnPackWiped, self))
end

function Music:StartCustomMusic(playerID, soundName)
    local state = self.musicState[playerID]
    state.customMusic = soundName
    state.current = nil
    local player = PlayerResource:GetPlayer(playerID)
    if not player then return end
    EmitSoundOnClient(soundName, player)
    DebugPrint("[ALNOIRE] Set custom music: " .. soundName .. ", for player: " .. player:GetName())
end

function Music:StartCustomMusicForAll(soundName)
    for playerID, _ in pairs(self.musicState) do
        self:StartCustomMusic(playerID, soundName)
    end
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

    if not state.noCombat and PackManager:HasActiveFights() then
        state.lastInCombat = t0
    end

    if not state.noCombat and t0 - state.lastInCombat <= MUSIC_COMBAT_DECAY then
        newSoundState = "combat"
    end

    local newSound = newSoundZone .. "." .. newSoundState
    if state.current ~= newSound then
        local player = PlayerResource:GetPlayer(playerID)
        if not player then return end

        DebugPrint("[ALNOIRE] Change music state: " .. newSound)
        EmitSoundOnClient(newSound, player)
        state.current = newSound
    end

    return MUSIC_THINK_INTERVAL
end

function Music:OnDialogueStart(event)
    local playerID = event.playerID
    local nodeID = event.startNodeID
    if nodeID == "d_xavier_fight_start" or nodeID == "d_xavier_fight_again" then
        self:StartCustomMusic(playerID, "music.concert.precombat")
    elseif nodeID == "d_xavier_ending" then
        self:StartCustomMusic(playerID, "music.ending.dialogue")
    end
end

function Music:OnEntityKilled(event)
    local victim = event.killed_unit
    -- if victim:IsRealHero() and not victim:IsSpiritBearCustom() then
    --     local playerID = victim:GetPlayerOwnerID()
    --     self:StopCustomMusic(playerID)
    --     self.musicState[playerID].musicSet = "silence"
    --     Timers:CreateTimer(CUSTOM_RESPAWN_TIME + 5, function()
    --         local player = victim:GetPlayerOwner()
    --         StopSoundOn(self.musicState[playerID].current, player)
    --         EmitSoundOnClient(self.musicState[playerID].current, player)
    --         -- EmitGlobalSound(self.musicState[playerID].current)
    --     end)
    -- end
end

function Music:OnPackWiped(event)
    local pack = EntityData:ByName(event.packName)
    if not pack.music then return end
    for playerID, state in pairs(self.musicState) do
        self:StopCustomMusic(playerID)
    end
end

return Music
