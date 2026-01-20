require("internal.gameevents")

local OnZoneEnterEvent = CreateGameEvent 'OnZoneEnter'
function ZoneOnStartTouch(trigger, event)
    local activator = event.activator
    if not activator or not activator:IsRealHero() then return end
    local zoneName = ExtractNamePayload(trigger:GetName(), "zone__")
    if not zoneName then return end

    OnZoneEnterEvent({
        zoneName = zoneName,
        playerID = activator:GetPlayerID()
    })
end
