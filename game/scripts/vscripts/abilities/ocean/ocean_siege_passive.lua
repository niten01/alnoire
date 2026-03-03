LinkLuaModifier("modifier_ocean_siege", "abilities/ocean/ocean_siege_passive", LUA_MODIFIER_MOTION_NONE)
ocean_siege_passive = class({})


function ocean_siege_passive:GetIntrinsicModifierName()
    return "modifier_ocean_siege"
end

--------------------------------
modifier_ocean_siege = class({})

function modifier_ocean_siege:IsHidden()
    return true
end

function modifier_ocean_siege:IsPurgable()
    return false
end

function modifier_ocean_siege:IsDebuff()
    return false
end

function modifier_ocean_siege:CheckState()
    return {
        [MODIFIER_STATE_ATTACKS_DONT_REVEAL] = true,
    }
end
