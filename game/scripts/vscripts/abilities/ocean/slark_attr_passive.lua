LinkLuaModifier("modifier_slark_attr_passive", "abilities/ocean/slark_attr_passive.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_slark_attr_debuff", "abilities/ocean/slark_attr_passive.lua", LUA_MODIFIER_MOTION_NONE)

--Abilities
if slark_attr_passive == nil then
	slark_attr_passive = class({})
end
function slark_attr_passive:GetIntrinsicModifierName()
	return "modifier_slark_attr_passive"
end

---------------------------------------------------------------------
--Modifiers
if modifier_slark_attr_passive == nil then
	modifier_slark_attr_passive = class({})
end

function modifier_slark_attr_passive:IsHidden()
	return true
end

function modifier_slark_attr_passive:OnCreated(params)
	if not IsServer() then return end
end

function modifier_slark_attr_passive:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
end

function modifier_slark_attr_passive:OnAttackLanded(params)
	if not IsServer() then return end
	local parent = self:GetParent()
	if params.attacker == parent then
		local abil = self:GetAbility()
		local duration = abil:GetSpecialValueFor('stackDuration')
		params.target:AddNewModifier(parent, abil, "modifier_slark_attr_debuff", { duration = duration })
	end
end

---------------------
---
modifier_slark_attr_debuff = class({})


function modifier_slark_attr_debuff:IsHidden()
	return false
end

function modifier_slark_attr_debuff:IsPurgable()
	return false
end

function modifier_slark_attr_debuff:IsDebuff()
	return true
end

function modifier_slark_attr_debuff:OnRefresh()
	if not IsServer() then return end
	self:IncrementStackCount()
	self:CheckDeath()
end

function modifier_slark_attr_debuff:OnCreated()
	if not IsServer() then return end
	local abil = self:GetAbility()
	self.strPerStack = abil:GetSpecialValueFor('strPerStack') or 2
	self.agilPerStack = abil:GetSpecialValueFor('agilPerStack') or 3
	self.stacksForDeath = abil:GetSpecialValueFor('stacksForDeath') or 50
	self.modelScalePerStack = abil:GetSpecialValueFor('modelScalePerStack') or 10.0
	self:SetStackCount(1)
	self:CheckDeath()
end

function modifier_slark_attr_debuff:CheckDeath()
	local parent = self:GetParent()
	local caster = self:GetCaster()
	local abil = self:GetAbility()

	if not abil then return end
	if self:GetStackCount() >= self.stacksForDeath then
		local pfx = ParticleManager:CreateParticle(
			"particles/slark_attr_passive_death_explosion.vpcf",
			PATTACH_ABSORIGIN_FOLLOW,
			parent)
		ParticleManager:ReleaseParticleIndex(pfx)
		EmitSoundOn('Hero_LifeStealer.Infest', parent)
		EmitSoundOn("Slark.Infested", caster)
		parent:Kill(abil, caster)
		self:Destroy()
	end
end

function modifier_slark_attr_debuff:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_AGILITY_BONUS,
		MODIFIER_PROPERTY_STATS_STRENGTH_BONUS,
		MODIFIER_PROPERTY_MODEL_SCALE,
	}
end

function modifier_slark_attr_debuff:GetModifierModelScale()
	if self.modelScalePerStack then
		return self:GetStackCount() * self.modelScalePerStack
	end
end

function modifier_slark_attr_debuff:GetModifierBonusStats_Agility()
	if self.agilPerStack then
		return self:GetStackCount() * self.agilPerStack
	end
	return 0
end

function modifier_slark_attr_debuff:GetModifierBonusStats_Strength()
	if self.strPerStack then
		return self:GetStackCount() * self.strPerStack
	end
	return 0
end
