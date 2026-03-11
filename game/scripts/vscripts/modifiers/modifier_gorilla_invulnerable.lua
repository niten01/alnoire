modifier_gorilla_invulnerable = class({})

function modifier_gorilla_invulnerable:IsHidden() return true end
function modifier_gorilla_invulnerable:IsPurgable() return false end

function modifier_gorilla_invulnerable:CheckState()
    return {
        [MODIFIER_STATE_INVULNERABLE] = true,
    }
end

function modifier_gorilla_invulnerable:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
    }
end

function modifier_gorilla_invulnerable:GetAbsoluteNoDamagePhysical() return 1 end
function modifier_gorilla_invulnerable:GetAbsoluteNoDamageMagical() return 1 end
function modifier_gorilla_invulnerable:GetAbsoluteNoDamagePure() return 1 end