LinkLuaModifier( "modifier_dark_drow_hg_passive", "abilities/desert/dark_drow_hg_passive.lua", LUA_MODIFIER_MOTION_NONE )
--Abilities
if dark_drow_hg_passive == nil then
	dark_drow_hg_passive = class({})
end
function dark_drow_hg_passive:GetIntrinsicModifierName()
	return "modifier_dark_drow_hg_passive"
end
---------------------------------------------------------------------
--Modifiers
if modifier_dark_drow_hg_passive == nil then
	modifier_dark_drow_hg_passive = class({})
end
function modifier_dark_drow_hg_passive:OnCreated(params)
	if IsServer() then
	end
end
function modifier_dark_drow_hg_passive:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_dark_drow_hg_passive:OnDestroy()
	if IsServer() then
	end
end
function modifier_dark_drow_hg_passive:DeclareFunctions()
	return {
	}
end