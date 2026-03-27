modifier_gorilla_invulnerable = class({})

function modifier_gorilla_invulnerable:IsHidden() return true end

function modifier_gorilla_invulnerable:IsPurgable() return false end

function modifier_gorilla_invulnerable:CheckState()
    return {
        [MODIFIER_STATE_ATTACK_IMMUNE] = true,
    }
end

function modifier_gorilla_invulnerable:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
end

function modifier_gorilla_invulnerable:GetModifierIncomingDamage_Percentage(params)
    if params.inflictor and params.inflictor:GetAbilityName() == "item_sling" then
        return 0
    end
    return -100
end
