modifier_story_lethal_damage_tracking = class({})

function modifier_story_lethal_damage_tracking:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MIN_HEALTH,
        MODIFIER_EVENT_ON_TAKEDAMAGE,
    }
end

function modifier_story_lethal_damage_tracking:GetMinHealth()
    return 1
end

function modifier_story_lethal_damage_tracking:OnTakeDamage(params)
    if not IsServer() then return end
    local parent = self:GetParent()
    if params.unit ~= parent then return end

    if params.unit:GetHealth() <= 1 then
        params.unit:SetHealth(1)
        DamageTracker:LogLethalDamage(params)
        if not parent:HasModifier("modifier_story_npc") then
            parent:AddNewModifier(parent, nil, "modifier_story_npc", { duration = -1 })
            parent:SetTeam(DOTA_TEAM_GOODGUYS)
        end
        self:Destroy()
    end
end
