require("internal.gameevents")
local OnSkiEnd = CreateGameEvent('OnSkiEnd')

function SkiGameStart(trigger, event)
    local activator = event.activator
    print("[ALNOIRE] STARTED SKI")
    activator:AddNewModifier(activator, nil, "modifier_ski", { duration = -1 })
end

function SkiGameEnd(trigger, event)
    local activator = event.activator
    print("[ALNOIRE] ENDED SKI")
    activator:RemoveModifierByName("modifier_ski")
    OnSkiEnd({
        playerID = activator:GetPlayerID()
    })

    RemoveAnimationTranslate(activator)
end

function AddSkiCold(trigger, event)
    local activator = event.activator

    if not activator:HasModifier("modifier_ski_cold") then
        activator:AddNewModifier(activator, nil, "modifier_ski_cold", { duration = -1 })
    end
end
