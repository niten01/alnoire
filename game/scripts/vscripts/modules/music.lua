Music = Music or {}

local PlayerMusicState = class {}
function PlayerMusicState:constructor()
    self.musicSet = nil
    self.current = nil
    self.fade = nil
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
        hero:SetContextThink("MusicThinker", function()
            return self:HeroMusicThink(hero)
        end, MUSIC_THINK_INTERVAL)
    end)
end

function Music:StartCustomMusic(playerID, soundName)
    self.musicState[playerID].customMusic = soundName
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

    if hero:IsAttacking() or hero:GetAggroTarget() ~= nil then
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

return Music
