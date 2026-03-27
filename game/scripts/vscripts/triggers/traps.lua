function OnTrapsEnter(trigger, event)
    local activator = event.activator
    if not activator or not activator:IsRealHero() or activator:IsSpiritBearCustom() then
        return
    end

    activator:AddNewModifier(nil, nil, "modifier_island_traps_participant", {
        duration = -1
    })
    activator:RemoveModifierByName("modifier_rapper_spliff_shield")
    EpsTraps:SetActivated(true)
end

function OnTrapsLeave(trigger, event)
    local activator = event.activator
    if not activator or not activator:IsRealHero() or activator:IsSpiritBearCustom() then
        return
    end

    activator:RemoveModifierByName("modifier_island_traps_participant")
    EpsTraps:SetActivated(false)
end
