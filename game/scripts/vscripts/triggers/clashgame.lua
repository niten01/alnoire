require('internal.gameevents')

local OnClashGameEnter = CreateGameEvent('OnClashGameEnter')
function StartClashGame(trigger)
    local activator = trigger.activator
    if not activator or not activator:IsRealHero() then return end
    print("activated trigger clash")

    OnClashGameEnter({
        playerID = activator:GetPlayerID()
    })

end