LinkLuaModifier("modifier_dark_pudge_passive", "abilities/darkforest/dark_pudge_passive.lua", LUA_MODIFIER_MOTION_NONE)

--Abilities
if dark_pudge_passive == nil then
	dark_pudge_passive = class({})
end
function dark_pudge_passive:GetIntrinsicModifierName()
	return "modifier_dark_pudge_passive"
end

---------------------------------------------------------------------
--Modifiers
if modifier_dark_pudge_passive == nil then
	modifier_dark_pudge_passive = class({})
end

function modifier_dark_pudge_passive:IsHidden()
	return true
end

function modifier_dark_pudge_passive:IsPurgable()
	return false
end

function modifier_dark_pudge_passive:OnCreated()
	if not IsServer() then return end
	local parent = self:GetParent()
	local pfx = ParticleManager:CreateParticle('particles/units/heroes/hero_pugna/pugna_decrepify.vpcf',
		PATTACH_ABSORIGIN_FOLLOW, parent)
	ParticleManager:ReleaseParticleIndex(pfx)
end

function modifier_dark_pudge_passive:CheckState()
	return {
		[MODIFIER_STATE_DISARMED] = true,
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
	}
end

function modifier_dark_pudge_passive:GetStatusEffectName()
	return "particles/status_fx/status_effect_ghost.vpcf"
end

function modifier_dark_pudge_passive:StatusEffectPriority()
	return MODIFIER_PRIORITY_ULTRA
end
