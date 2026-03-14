LinkLuaModifier( "modifier_derek_wolf_daggers", "abilities/bosses/derek_wolf_daggers.lua.lua", LUA_MODIFIER_MOTION_NONE )
--Abilities
if derek_wolf_daggers == nil then
	derek_wolf_daggers = class({})
end
function derek_wolf_daggers:GetIntrinsicModifierName()
	return "modifier_derek_wolf_daggers"
end
---------------------------------------------------------------------
--Modifiers
if modifier_derek_wolf_daggers == nil then
	modifier_derek_wolf_daggers = class({})
end
function modifier_derek_wolf_daggers:OnCreated(params)
	if IsServer() then
	end
end
function modifier_derek_wolf_daggers:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_derek_wolf_daggers:OnDestroy()
	if IsServer() then
	end
end
function modifier_derek_wolf_daggers:DeclareFunctions()
	return {
	}
end