function OnTrapsEnter(trigger, event)
    local activator = event.activator
    if not activator or not activator:IsRealHero() or activator:IsSpiritBearCustom() then
        return
    end

    EpsTraps:SetActivated(true)
end

function OnTrapsLeave(trigger, event)
    local activator = event.activator
    if not activator or not activator:IsRealHero() or activator:IsSpiritBearCustom() then
        return
    end

    EpsTraps:SetActivated(false)
end
