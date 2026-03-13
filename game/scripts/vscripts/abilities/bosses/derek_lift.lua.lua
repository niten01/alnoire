LinkLuaModifier( "modifier_derek_lift", "abilities/bosses/derek_lift.lua.lua", LUA_MODIFIER_MOTION_NONE )
--Abilities
if derek_lift == nil then
	derek_lift = class({})
end
function derek_lift:GetIntrinsicModifierName()
	return "modifier_derek_lift"
end
---------------------------------------------------------------------
--Modifiers
if modifier_derek_lift == nil then
	modifier_derek_lift = class({})
end
function modifier_derek_lift:OnCreated(params)
	if IsServer() then
	end
end
function modifier_derek_lift:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_derek_lift:OnDestroy()
	if IsServer() then
	end
end
function modifier_derek_lift:DeclareFunctions()
	return {
	}
end