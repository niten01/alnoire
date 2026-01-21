

function TeleportToTarget(trigger)
    local activator = trigger.activator
    local caller = trigger.caller
    local triggerName = caller:GetName()
    local targetName = triggerName .. "_target"
    if not targetName then
        print('No target for trigger teleport: ' .. triggerName) return end
    print('Target name ' .. targetName)
    local targetEntity = Entities:FindByName(nil, targetName)

    if not targetEntity then
        print("Cant find target for this teleport trigger " .. triggerName)
        return
    end

    local playerID = activator:GetPlayerID()
    local targetPos = targetEntity:GetAbsOrigin()
    local targetAngles = targetEntity:GetAngles()
    activator:SetAbsOrigin(targetPos)
    FindClearSpaceForUnit(activator, targetPos, true)
    activator:SetAngles(targetAngles.x, targetAngles.y, targetAngles.z)
    

    PlayerResource:SetCameraTarget(playerID, activator)
    activator:SetContextThink("ReleaseCamera", function()
        PlayerResource:SetCameraTarget(playerID, nil)
        return nil 
    end, 0.03) 

    
    local pfx = ParticleManager:CreateParticle("particles/items_fx/blink_dagger_end.vpcf", PATTACH_ABSORIGIN, activator)
    ParticleManager:ReleaseParticleIndex(pfx)
    activator:Stop()
    print("Teleported " .. activator:GetUnitName() .. " to " .. targetName)
end


