IntroMovie = IntroMovie or class {}

function IntroMovie:Init()
    GameEvents:OnGameInProgress(function()
        Timers:CreateTimer(1, function()
            CustomGameEventManager:Send_ServerToAllClients("start_intro", {})
        end)
    end)
end

return IntroMovie
