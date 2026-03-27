if not IsServer() then
    return
end


function Spawn(entityKeyValues)
    if not thisEntity or not IsServer() then return end
    local leech = thisEntity:FindAbilityByName('treant_leech_seed')
    leech.forcedBehavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
    local ult = thisEntity:FindAbilityByName('dark_treant_ult')
    ult.forcedBehavior = DOTA_ABILITY_BEHAVIOR_NO_TARGET
end
