LinkLuaModifier( "modifier_item_orb_of_desolation", "items/item_orb_of_desolation.lua.lua", LUA_MODIFIER_MOTION_NONE )
--Abilities
if item_orb_of_desolation == nil then
	item_orb_of_desolation = class({})
end
function item_orb_of_desolation:GetIntrinsicModifierName()
	return "modifier_item_orb_of_desolation"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_orb_of_desolation == nil then
	modifier_item_orb_of_desolation = class({})
end
function modifier_item_orb_of_desolation:OnCreated(params)
	if IsServer() then
	end
end
function modifier_item_orb_of_desolation:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_item_orb_of_desolation:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_orb_of_desolation:DeclareFunctions()
	return {
	}
end