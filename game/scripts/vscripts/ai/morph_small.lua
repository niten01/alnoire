if not IsServer() then return end

function Spawn(params)
    if not thisEntity or not IsServer() then return end
    local waveForm = thisEntity:FindAbilityByName("morphling_waveform")
    waveForm.forcedBehavior = DOTA_ABILITY_BEHAVIOR_POINT
end
