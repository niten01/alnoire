LinkLuaModifier( "modifier_ending_throw", "abilities/ending_throw.lua.lua", LUA_MODIFIER_MOTION_NONE )
--Abilities
if ending_throw == nil then
	ending_throw = class({})
end
function ending_throw:GetIntrinsicModifierName()
	return "modifier_ending_throw"
end
---------------------------------------------------------------------
--Modifiers
if modifier_ending_throw == nil then
	modifier_ending_throw = class({})
end
function modifier_ending_throw:OnCreated(params)
	if IsServer() then
	end
end
function modifier_ending_throw:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_ending_throw:OnDestroy()
	if IsServer() then
	end
end
function modifier_ending_throw:DeclareFunctions()
	return {
	}
end