LinkLuaModifier( "modifier_item_entrophia", "items/item_entrophia.lua.lua", LUA_MODIFIER_MOTION_NONE )
--Abilities
if item_entrophia == nil then
	item_entrophia = class({})
end
function item_entrophia:GetIntrinsicModifierName()
	return "modifier_item_entrophia"
end
---------------------------------------------------------------------
--Modifiers
if modifier_item_entrophia == nil then
	modifier_item_entrophia = class({})
end
function modifier_item_entrophia:OnCreated(params)
	if IsServer() then
	end
end
function modifier_item_entrophia:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_item_entrophia:OnDestroy()
	if IsServer() then
	end
end
function modifier_item_entrophia:DeclareFunctions()
	return {
	}
end