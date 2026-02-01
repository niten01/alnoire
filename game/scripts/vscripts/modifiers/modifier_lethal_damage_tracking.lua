modifier_lethal_damage_tracking = class({})

function modifier_lethal_damage_tracking:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MIN_HEALTH,
        MODIFIER_EVENT_ON_TAKEDAMAGE,
    }
end

function modifier_lethal_damage_tracking:GetMinHealth()
    return 1
end

function modifier_lethal_damage_tracking:OnTakeDamage(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end

    if (params.unit:GetHealth() - params.damage) <= 1 and params.damage > 0 then
        local attackerPlayerID = params.attacker:GetPlayerOwnerID()
            or params.attacker:GetPlayerOwner():GetPlayerID()
        OnCancelLethalDamageEvent(extend(params, {
            attackerPlayerID = attackerPlayerID
        }))
    end
end
