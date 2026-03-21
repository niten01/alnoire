LinkLuaModifier( "modifier_item_orb_of_decrepitude", "items/item_orb_of_decrepitude.lua.lua", LUA_MODIFIER_MOTION_NONE )
--Abilities
if item_orb_of_decrepitude == nil then
	item_orb_of_decrepitude = class({})
end
function item_orb_of_decrepitude:GetIntrinsicModifierName()
	return "modifier_item_orb_of_decrepitude"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_orb_of_decrepitude == nil then
	modifier_item_orb_of_decrepitude = class({})
end
function modifier_item_orb_of_decrepitude:OnCreated(params)
	if IsServer() then
	end
end
function modifier_item_orb_of_decrepitude:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_item_orb_of_decrepitude:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_orb_of_decrepitude:DeclareFunctions()
	return {
	}
end