require('internal.gameevents')

local OnClashGameEnter = CreateGameEvent('OnClashGameEnter')
function StartClashGame(_, event)
    local activator = event.activator
    if not activator or not activator:IsRealHero() then return end

    OnClashGameEnter({
        playerID = activator:GetPlayerID()
    })

end