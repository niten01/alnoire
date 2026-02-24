modifier_invulnerable = class({})

function modifier_invulnerable:IsHidden() return true end
function modifier_invulnerable:IsPurgable() return false end

function modifier_invulnerable:CheckState()
    return {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_NO_HEALTH_BAR] = false, 
    }
end

function modifier_invulnerable:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    }
end

function modifier_invulnerable:GetAbsoluteNoDamagePhysical() return 1 end
function modifier_invulnerable:GetAbsoluteNoDamageMagical() return 1 end
function modifier_invulnerable:GetAbsoluteNoDamagePure() return 1 end