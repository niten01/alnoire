if not IsServer() then
    return
end


function Spawn(entityKeyValues)
    if not thisEntity or not IsServer() then return end
    local ult = thisEntity:FindAbilityByName('desert_huskar_push')
    if ult then
        local offset = ult:GetSpecialValueFor('offset')
        ult.offset = offset or 150
    end
end
