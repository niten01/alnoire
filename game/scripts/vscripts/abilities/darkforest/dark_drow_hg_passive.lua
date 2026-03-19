LinkLuaModifier("modifier_dark_drow_hg_passive", "abilities/darkforest/dark_drow_hg_passive.lua",
	LUA_MODIFIER_MOTION_NONE)
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

function modifier_dark_drow_hg_passive:IsHidden()
	return true
end

function modifier_dark_drow_hg_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PROJECTILE_NAME,
		MODIFIER_PROPERTY_PROCATTACK_BONUS_DAMAGE_PHYSICAL
	}
end

function modifier_dark_drow_hg_passive:IsAttackingFromHighGround(params)
	local attacker = params.attacker
	local target = params.target

	if attacker and target then
		local attackerZ = attacker:GetAbsOrigin().z
		local targetZ = target:GetAbsOrigin().z
		return attackerZ > (targetZ + 100)
	end
	return false
end

function modifier_dark_drow_hg_passive:OnAttackStart()
	if not IsServer() then return end
end

local PARTICLE_NORMAL = "particles/econ/items/drow/drow_arcana/drow_arcana_base_attack_v2.vpcf"
local PARTICLE_MARKSMAN = "particles/econ/items/drow/drow_arcana/drow_arcana_marksmanship_attack.vpcf"
function modifier_dark_drow_hg_passive:GetModifierProjectileName()
	if not IsServer() then return end
	local parent = self:GetParent()
	local target = parent:GetAttackTarget()
	if target and self:IsAttackingFromHighGround({ attacker = parent, target = target }) then
		return PARTICLE_MARKSMAN
	end
	return PARTICLE_NORMAL
end

function modifier_dark_drow_hg_passive:GetModifierProcAttack_BonusDamage_Physical(params)
	if not IsServer() then return end
	if self:IsAttackingFromHighGround(params) then
		local abil = self:GetAbility()
		local bonusDamage = abil:GetSpecialValueFor('bonusDamage')
		local pfx = ParticleManager:CreateParticle(
			'particles/econ/items/drow/drow_arcana/drow_arcana_crit_or_marksmanship_proc.vpcf', PATTACH_ABSORIGIN_FOLLOW,
			params.target)
		ParticleManager:ReleaseParticleIndex(pfx)
		if bonusDamage then
			return bonusDamage
		end
	end
	return 0
end
