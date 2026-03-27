LinkLuaModifier( "modifier_chaser_passive", "abilities/bosses/chaser_passive.lua.lua", LUA_MODIFIER_MOTION_NONE )
--Abilities
if chaser_passive == nil then
	chaser_passive = class({})
end
function chaser_passive:GetIntrinsicModifierName()
	return "modifier_chaser_passive"
end
---------------------------------------------------------------------
--Modifiers
if modifier_chaser_passive == nil then
	modifier_chaser_passive = class({})
end
function modifier_chaser_passive:OnCreated(params)
	if IsServer() then
	end
end
function modifier_chaser_passive:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_chaser_passive:OnDestroy()
	if IsServer() then
	end
end
function modifier_chaser_passive:DeclareFunctions()
	return {
	}
end