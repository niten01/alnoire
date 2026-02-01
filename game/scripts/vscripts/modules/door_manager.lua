DoorManager = DoorManager or {}

function DoorManager:Init()
    ChatCommand:LinkDevCommand("-d", function(event, args)
        self:Open(args[1])
    end)
end

function DoorManager:Open(doorName)
    local data = EntityData:ByName(doorName)
    if not data then
        error("No data for door: " .. doorName)
        return
    end

    for _, clipEnt in ipairs(Entities:FindAllByName(data.clipEntity)) do
        DoEntFireByInstanceHandle(clipEnt, "Disable", "", 0, nil, nil)
    end

    if data.openAnimation then
        for _, doorEnt in ipairs(Entities:FindAllByName(doorName)) do
            DoEntFireByInstanceHandle(doorEnt, "SetAnimation", data.openAnimation, 0, nil, nil)
        end
    end
end

return DoorManager
