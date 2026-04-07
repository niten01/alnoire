if not IsServer() then
    return
end


function Spawn(entityKeyValues)
    if not thisEntity or not IsServer() then return end
    local rite = thisEntity:FindAbilityByName('chaser_rite')
    local stun = thisEntity:FindAbilityByName('chaser_stun')
    if rite then
        rite:SetLevel(1)
    end
    if stun then
        stun:SetLevel(1)
    end
end
