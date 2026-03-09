LinkLuaModifier( "modifier_ball_jump", "abilities/bosses/ball_jump.lua.lua", LUA_MODIFIER_MOTION_NONE )
--Abilities
if ball_jump == nil then
	ball_jump = class({})
end
function ball_jump:GetIntrinsicModifierName()
	return "modifier_ball_jump"
end
---------------------------------------------------------------------
--Modifiers
if modifier_ball_jump == nil then
	modifier_ball_jump = class({})
end
function modifier_ball_jump:OnCreated(params)
	if IsServer() then
	end
end
function modifier_ball_jump:OnRefresh(params)
	if IsServer() then
	end
end
function modifier_ball_jump:OnDestroy()
	if IsServer() then
	end
end
function modifier_ball_jump:DeclareFunctions()
	return {
	}
end