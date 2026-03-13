if not IsServer() then
    return
end


function Spawn(entityKeyValues)
    if not thisEntity or not IsServer() then return end
    local anchor = thisEntity:FindAbilityByName('tidehunter_dead_in_the_water')
    anchor.forcedBehavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end
