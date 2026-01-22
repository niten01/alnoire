require("internal.gameevents")

local OnZoneEnterEvent = CreateGameEvent 'OnZoneEnter'
function ZoneOnStartTouch(trigger, event)
    local activator = event.activator
    if not activator or not activator:IsRealHero() then return end
    local zoneData = EntityData:ByName(trigger:GetName())
    if not zoneData then
        DebugPrint("??? No zone entity data found for trigger: " .. trigger:GetName())
        return
    end

    OnZoneEnterEvent({
        zoneName = zoneData.zone,
        playerID = activator:GetPlayerID()
    })
end
