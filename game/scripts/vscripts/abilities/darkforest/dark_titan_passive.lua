LinkLuaModifier("modifier_dark_titan_passive", "abilities/darkforest/dark_titan_passive.lua", LUA_MODIFIER_MOTION_NONE)
--Abilities
if dark_titan_passive == nil then
	dark_titan_passive = class({})
end
function dark_titan_passive:GetIntrinsicModifierName()
	return "modifier_dark_titan_passive"
end

---------------------------------------------------------------------
--Modifiers
if modifier_dark_titan_passive == nil then
	modifier_dark_titan_passive = class({})
end

function modifier_dark_titan_passive:OnCreated()
	local abil = self:GetAbility()
	if not abil then return end
	self.critChance = abil:GetSpecialValueFor('critChance')
	self.critMult = abil:GetSpecialValueFor('critMult')
end

function modifier_dark_titan_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_PREATTACK_CRITICALSTRIKE,
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
end

function modifier_dark_titan_passive:GetModifierPreAttack_CriticalStrike(params)
	if not IsServer() then return end

	if RollPercentage(self.critChance) then
		self.isCrit = true
		return self.critMult
	end

	self.isCrit = false
	return nil
end

function modifier_dark_titan_passive:OnAttackLanded(params)
	if not IsServer() then return end

	if params.attacker == self:GetParent() and self.isCrit then
		self.isCrit = false
		local target = params.target
		EmitSoundOn("DOTA_Item.Daedelus.Crit", target)
	end
end
