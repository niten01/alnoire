if not IsServer() then return end

function Spawn(params)
    if not thisEntity or not IsServer() then return end
    local waveForm = thisEntity:FindAbilityByName("morphling_waveform")
    waveForm.offset = 400
end
