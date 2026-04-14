IntroMovie = IntroMovie or class {}

function IntroMovie:Init()
    GameEvents:OnGameInProgress(function()
        Timers:CreateTimer(1, function()
            CustomGameEventManager:Send_ServerToAllClients("start_intro", {})
        end)
    end)

    GameEvents:OnHeroInGame(function(hero)
        if hero:GetUnitName() ~= "npc_dota_hero_sanya" then
            CustomGameEventManager:Send_ServerToAllClients("stop_intro", {})
        end
    end)
end

return IntroMovie
