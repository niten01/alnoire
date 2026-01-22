modifier_clash_unit = class({})

function modifier_clash_unit:IsHidden()
    return true
end

function modifier_clash_unit:IsPurgable()
    return false
end

function modifier_clash_unit:RemoveOnDeath()
    return true
end
