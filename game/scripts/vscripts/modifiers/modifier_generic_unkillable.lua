modifier_generic_unkillable = class {}

function modifier_generic_unkillable:IsHidden() return true end
function modifier_generic_unkillable:IsPurgable() return false end

function modifier_generic_unkillable:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MIN_HEALTH
    }
end

function modifier_generic_unkillable:GetMinHealth()
    return 1
end