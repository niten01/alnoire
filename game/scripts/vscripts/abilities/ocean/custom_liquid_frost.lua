LinkLuaModifier("modifier_custom_liquid_frost_debuff", "abilities/ocean/custom_liquid_frost.lua",
	LUA_MODIFIER_MOTION_NONE)

custom_liquid_frost = class({})

function custom_liquid_frost:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local target = self:GetCursorTarget()
	local projSpeed = self:GetSpecialValueFor('proj_speed') or 900

	local projInfo = {
		Target = target,
		Source = caster,
		Ability = self,
		EffectName = "particles/units/heroes/hero_jakiro/jakiro_liquid_ice_projectile.vpcf",
		iMoveSpeed = projSpeed,
		vSourceLoc = caster:GetAbsOrigin(),
		dDodgeable = true,
		bReplaceExisting = false,
		flExpireTime = GameRules:GetGameTime() + 30,
		bProvidesVision = true,
		iVisionRadius = 200,
		iVisionTeamNumber = caster:GetTeamNumber()
	}
	ProjectileManager:CreateTrackingProjectile(projInfo)
	EmitSoundOn("Hero_Ancient_Apparition.ChillingTouch.Cast", caster)
end

function custom_liquid_frost:OnProjectileHit(target, location)
	if not IsServer() or not target then return end

	local caster = self:GetCaster()
	local radius = self:GetSpecialValueFor('aoe_radius') or 200
	local duration = self:GetSpecialValueFor('debuff_duration') or 5.0
	local damage = self:GetSpecialValueFor('damage_on_touch') or 100


	local pfx = ParticleManager:CreateParticle('particles/units/heroes/hero_jakiro/jakiro_liquid_ice.vpcf',
		PATTACH_ABSORIGIN, target)
	ParticleManager:SetParticleControl(pfx, 2, Vector(radius, radius, radius))
	ParticleManager:ReleaseParticleIndex(pfx)
	EmitSoundOn("Hero_Ancient_Apparition.ChillingTouch.Target", target)

	local enemies = FindUnitsInRadius(
		caster:GetTeamNumber(),
		target:GetAbsOrigin(),
		nil,
		radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC + DOTA_UNIT_TARGET_BUILDING,
		DOTA_UNIT_TARGET_FLAG_NONE,
		FIND_ANY_ORDER,
		false
	)


	for _, enemy in ipairs(enemies) do
		local damageTable = {
			victim = enemy,
			attacker = caster,
			damage = damage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self
		}
		ApplyDamage(damageTable)
		enemy:AddNewModifier(caster, self, "modifier_custom_liquid_frost_debuff", { duration = duration })
	end
	return true
end

-------------------------------
---
modifier_custom_liquid_frost_debuff = class({})

function modifier_custom_liquid_frost_debuff:IsHidden() return false end

function modifier_custom_liquid_frost_debuff:IsPurgable() return true end

function modifier_custom_liquid_frost_debuff:IsDebuff() return true end

function modifier_custom_liquid_frost_debuff:OnCreated()
	if not IsServer() then return end
	local abil = self:GetAbility()
	self.slowAmount = abil:GetSpecialValueFor('slow_amount') or 30
	self.attackSpeedSlow = abil:GetSpecialValueFor('attack_slow') or 35
end

function modifier_custom_liquid_frost_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
	}
end

function modifier_custom_liquid_frost_debuff:GetModifierMoveSpeedBonus_Constant()
	if self.slowAmount then
		return -self.slowAmount
	end
end

function modifier_custom_liquid_frost_debuff:GetModifierAttackSpeedBonus_Constant()
	if self.attackSpeedSlow then
		return -self.attackSpeedSlow
	end
end

function modifier_custom_liquid_frost_debuff:GetEffectName()
	return "particles/econ/courier/courier_roshan_frost/courier_roshan_frost_ambient.vpcf"
end

function modifier_custom_liquid_frost_debuff:StatusEffectPriority()
	return MODIFIER_PRIORITY_ULTRA
end
