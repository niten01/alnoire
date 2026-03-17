LinkLuaModifier( "modifier_george_puddles", "abilities/bosses/george_puddles.lua.lua", LUA_MODIFIER_MOTION_NONE )
--Abilities
if george_puddles == nil then
	george_puddles = class({})
end
function george_puddles:GetIntrinsicModifierName()
	return "modifier_george_puddles"
end
---------------------------------------------------------------------
--Modifiers
if modifier_george_puddles == nil then
	modifier_george_puddles = class({})
end
function modifier_george_puddles:OnCreated(params)
	if IsServer() then
	end
end
function modifier_george_puddles:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_george_puddles:OnDestroy()
	if IsServer() then
	end
end
function modifier_george_puddles:DeclareFunctions()
	return {
	}
end