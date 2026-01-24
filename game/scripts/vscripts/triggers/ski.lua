require("internal.gameevents")
local OnSkiEnd = CreateGameEvent('OnSkiEnd')

function SkiGameStart(trigger, event)
    local activator = event.activator
    print("[ALNOIRE] STARTED SKI")
    activator:AddNewModifier(activator, nil, "modifier_ski", { duration = -1 })
    local wearable = SpawnEntityFromTableSynchronous("prop_dynamic", {
        model = "models/sanya/wearables/sanya_ski.vmdl",
    })

    wearable:FollowEntity(activator, true)
    AddAnimationTranslate(activator, "windrun")
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