if not IsServer() then
    return
end


function Spawn(entityKeyValues)
    if not thisEntity or not IsServer() then return end
    local uppercut = thisEntity:FindAbilityByName('tusk_walrus_punch')
    uppercut.forcedBehavior = DOTA_ABILITY_BEHAVIOR_UNIT_TARGET
end
