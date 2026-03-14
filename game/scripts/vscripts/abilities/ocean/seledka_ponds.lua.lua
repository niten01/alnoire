LinkLuaModifier( "modifier_seledka_ponds", "abilities/ocean/seledka_ponds.lua.lua", LUA_MODIFIER_MOTION_NONE )
--Abilities
if seledka_ponds == nil then
	seledka_ponds = class({})
end
function seledka_ponds:GetIntrinsicModifierName()
	return "modifier_seledka_ponds"
end
---------------------------------------------------------------------
--Modifiers
if modifier_seledka_ponds == nil then
	modifier_seledka_ponds = class({})
end
function modifier_seledka_ponds:OnCreated(params)
	if IsServer() then
	end
end
function modifier_seledka_ponds:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_seledka_ponds:OnDestroy()
	if IsServer() then
	end
end
function modifier_seledka_ponds:DeclareFunctions()
	return {
	}
end