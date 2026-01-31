require("internal.gameevents")

local OnZoneEnterEvent = CreateGameEvent 'OnZoneEnter'
function ZoneOnStartTouch(trigger, event)
    if not IsServer() then return end

    local activator = event.activator
    if not activator or not activator:IsRealHero() then return end
    local zoneData = EntityData:ByName(trigger:GetName())
    if not zoneData then
        DebugPrint("??? No zone entity data found for trigger: " .. trigger:GetName())
        return
    end
    zoneData.zoneName = trigger:GetName()

    OnZoneEnterEvent(extend(zoneData, {
        playerID = activator:GetPlayerID()
    }))
end
