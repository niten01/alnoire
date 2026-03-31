LinkLuaModifier("modifier_desert_troll_fevor", "abilities/desert/desert_troll_fevor.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_desert_troll_fevor_stacks", "abilities/desert/desert_troll_fevor.lua", LUA_MODIFIER_MOTION_NONE)

desert_troll_fevor = class({})

function desert_troll_fevor:GetIntrinsicModifierName()
	return "modifier_desert_troll_fevor"
end

modifier_desert_troll_fevor = class({})

function modifier_desert_troll_fevor:IsHidden() return true end

function modifier_desert_troll_fevor:IsPurgable() return false end

function modifier_desert_troll_fevor:OnCreated()
	if not IsServer() then return end
	local abil = self:GetAbility()
	if not abil then return end
	self.maxStacks = abil:GetSpecialValueFor('maxStacks')
	self.stacksDuration = abil:GetSpecialValueFor('stacksDuration')
end

function modifier_desert_troll_fevor:DeclareFunctions()
	return {
		MODIFIER_EVENT_ON_ATTACK_LANDED
	}
end

function modifier_desert_troll_fevor:OnAttackLanded(params)
	if not IsServer() then return end
	if params.attacker ~= self:GetParent() then return end

	local caster = self:GetParent()
	local ability = self:GetAbility()
	local modifier = caster:AddNewModifier(caster, ability, "modifier_desert_troll_fevor_stacks", {
		duration = self.stacksDuration
	})

	if modifier then
		if modifier:GetStackCount() < self.maxStacks then
			modifier:IncrementStackCount()
		end
		modifier:ForceRefresh()
	end
end

modifier_desert_troll_fevor_stacks = class({})

function modifier_desert_troll_fevor_stacks:IsHidden() return false end

function modifier_desert_troll_fevor_stacks:IsPurgable() return false end

function modifier_desert_troll_fevor_stacks:OnCreated()
	local abil = self:GetAbility()
	if abil then
		self.attackSpeedPerAttack = abil:GetSpecialValueFor('attackSpeedPerAttack')
	else
		self.attackSpeedPerAttack = 0
	end
end

function modifier_desert_troll_fevor_stacks:OnRefresh()
	self:OnCreated()
end

function modifier_desert_troll_fevor_stacks:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
		MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS
	}
end

function modifier_desert_troll_fevor_stacks:GetModifierAttackSpeedBonus_Constant()
	return self:GetStackCount() * self.attackSpeedPerAttack
end

function modifier_desert_troll_fevor_stacks:GetModifierModifierActivityAbility()
	if self:GetStackCount() >= 5 then
		return "frenzy"
	end
	return ""
end
