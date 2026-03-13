DamageTracker = class {}

function DamageTracker:Init()
    DebugPrint("[ALNOIRE] DamageTracker initialized")
end

local OnCancelLethalDamageEvent = CreateGameEvent 'OnCancelLethalDamage'
function DamageTracker:LogLethalDamage(damageEventParams)
    local attackerPlayerID = damageEventParams.attacker:GetPlayerOwnerID()
        or damageEventParams.attacker:GetPlayerOwner():GetPlayerID()
    OnCancelLethalDamageEvent(extend(damageEventParams, {
        attackerPlayerID = attackerPlayerID
    }))
end

return DamageTracker
