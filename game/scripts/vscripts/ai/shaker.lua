if not IsServer() then
    return
end


function Spawn(entityKeyValues)
    if not thisEntity or not IsServer() then return end
    local totem = thisEntity:FindAbilityByName('earthshaker_enchant_totem')
    totem.forcedBehavior = DOTA_ABILITY_BEHAVIOR_POINT
end
