require('internal.gameevents')

local OnButtonPressEvent = CreateGameEvent('OnButtonPress')
function ButtonOnStartTouch(trigger, event)
    local activator = event.activator
    if not activator or not activator:IsRealHero() then return end

    local triggerName = trigger:GetName()
    if not triggerName then
        error("[???] Unnamed button trigger")
        return
    end

    local buttonName = nil
    for name, b in EntityData:AllByType('button') do
        if b.trigger == triggerName then
            buttonName = name
            break
        end
    end
    if not buttonName then
        error("[???] Orphan button trigger: " .. triggerName)
        return
    end

    for _, ent in ipairs(Entities:FindAllByName(buttonName)) do
        DoEntFireByInstanceHandle(ent, "SetAnimation", "ancient_trigger001_down", 0, nil, nil)
    end

    OnButtonPressEvent({
        buttonName = buttonName,
        playerID = activator:GetPlayerID(),
    })
end
