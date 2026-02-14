modifier_mk_summon_idle = class({})

function modifier_mk_summon_idle:IsHidden() return false end
function modifier_mk_summon_idle:IsPurgable() return false end

function modifier_mk_summon_idle:CheckState()
    return {
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_UNTARGETABLE] = true,
    }
end

function modifier_mk_summon_idle:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MODEL_CHANGE
    }
end

function modifier_mk_summon_idle:GetModifierModelChange()
    return "models/props_gameplay/banana_prop_closed_mk.vmdl"
end