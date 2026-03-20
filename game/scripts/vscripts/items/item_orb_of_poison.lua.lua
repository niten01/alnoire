LinkLuaModifier( "modifier_item_orb_of_poison", "items/item_orb_of_poison.lua.lua", LUA_MODIFIER_MOTION_NONE )
--Abilities
if item_orb_of_poison == nil then
	item_orb_of_poison = class({})
end
function item_orb_of_poison:GetIntrinsicModifierName()
	return "modifier_item_orb_of_poison"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_orb_of_poison == nil then
	modifier_item_orb_of_poison = class({})
end
function modifier_item_orb_of_poison:OnCreated(params)
	if IsServer() then
	end
end
function modifier_item_orb_of_poison:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_item_orb_of_poison:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_orb_of_poison:DeclareFunctions()
	return {
	}
end