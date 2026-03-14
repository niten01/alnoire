LinkLuaModifier( "modifier_derek_wolf_stun_howl", "abilities/bosses/derek_wolf_stun_howl.lua.lua", LUA_MODIFIER_MOTION_NONE )
--Abilities
if derek_wolf_stun_howl == nil then
	derek_wolf_stun_howl = class({})
end
function derek_wolf_stun_howl:GetIntrinsicModifierName()
	return "modifier_derek_wolf_stun_howl"
end
---------------------------------------------------------------------
--Modifiers
if modifier_derek_wolf_stun_howl == nil then
	modifier_derek_wolf_stun_howl = class({})
end
function modifier_derek_wolf_stun_howl:OnCreated(params)
	if IsServer() then
	end
end
function modifier_derek_wolf_stun_howl:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_derek_wolf_stun_howl:OnDestroy()
	if IsServer() then
	end
end
function modifier_derek_wolf_stun_howl:DeclareFunctions()
	return {
	}
end