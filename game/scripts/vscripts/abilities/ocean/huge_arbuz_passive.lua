LinkLuaModifier("modifier_huge_arbuz_passive", "abilities/ocean/huge_arbuz_passive.lua", LUA_MODIFIER_MOTION_NONE)
if huge_arbuz_passive == nil then
	huge_arbuz_passive = class({})
end
function huge_arbuz_passive:GetIntrinsicModifierName()
	return "modifier_huge_arbuz_passive"
end

---------------------------------------------------------------------
--Modifiers
if modifier_huge_arbuz_passive == nil then
	modifier_huge_arbuz_passive = class({})
end


function modifier_huge_arbuz_passive:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_MODEL_SCALE,
		MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
		MODIFIER_PROPERTY_AOE_BONUS_CONSTANT,
		MODIFIER_EVENT_ON_DEATH,
	}
end

function modifier_huge_arbuz_passive:OnDeath(params)
	if not IsServer() then return end
	local parent = self:GetParent()
	if params.unit == parent then
		local anchor = Entities:FindByName(nil, "npc_dota_unit_tidehunter_anchor")
		if anchor then
			anchor:ForceKill(false)
		end
	end
end

function modifier_huge_arbuz_passive:GetModifierModelScale()
	local parent = self:GetParent()
	local abil = self:GetAbility()
	if not abil or abil:IsNull() then return 0 end
	local modelScaleMax = abil:GetSpecialValueFor('modelScaleMaxPercent') or 100
	local healthPctRaw = parent:GetHealthPercent()
	local healthPct = parent:GetHealthPercent() / 100

	if IsServer() and self.thresholds and self.phrases then
		for threshold, canPlay in pairs(self.thresholds) do
			if healthPctRaw <= threshold and canPlay then
				local currentPhrase = self.phrases[threshold]
				EmitSoundOn(currentPhrase, parent)
				self.thresholds[threshold] = false
			end

			if healthPctRaw > threshold + 5 then
				self.thresholds[threshold] = true
			end
		end
	end

	local power = abil:GetSpecialValueFor('power')
	local intensity = math.pow(1 - healthPct, power)
	local currentScale = intensity * modelScaleMax
	return currentScale
end

function modifier_huge_arbuz_passive:GetModifierAoEBonusConstant()
	local parent = self:GetParent()
	local abil = self:GetAbility()

	local aoeMax = abil:GetSpecialValueFor('maxAoeIncrease') or 400
	local healthPct = parent:GetHealthPercent() / 100
	local power = abil:GetSpecialValueFor('power') or 3

	local intensity = math.pow(1 - healthPct, power)

	local currentAoE = intensity * aoeMax
	return currentAoE
end

function modifier_huge_arbuz_passive:GetModifierIncomingDamage_Percentage()
	local parent = self:GetParent()
	local abil = self:GetAbility()
	local damageReductionMaxPercent = abil:GetSpecialValueFor('damageReductionMaxPercent') or 80.0
	damageReductionMaxPercent = -damageReductionMaxPercent
	local healthPct = parent:GetHealthPercent() / 100

	local power = abil:GetSpecialValueFor('power')
	local intensity = math.pow(1 - healthPct, power)
	local currentReduction = intensity * damageReductionMaxPercent

	-- print('сопротивление урону тогда ' .. currentReduction)
	return currentReduction
end

function modifier_huge_arbuz_passive:OnCreated()
	if not IsServer() then return end
	self.thresholds = {
		[50] = true,
		[30] = true,
		[10] = true
	}
	self.phrases = {
		[50] = "Arbuz.HalfHp",
		[30] = "Arbuz.ThirdHp",
		[10] = "Arbuz.TenPercentHp"
	}
	local parent = self:GetParent()
	local abil = self:GetAbility()
	local baseHp = parent:GetMaxHealth()
	local damageReductionMaxPercent = abil:GetSpecialValueFor('damageReductionMaxPercent')

	local r_max = damageReductionMaxPercent / 100
	local power = abil:GetSpecialValueFor('power')
	local k = 1 / (1 - (r_max / (power + 1)))
	local totalRealHp = baseHp * k

	print('---------------------------------------------')
	print('[ARBUZ] Базовое HP: ' .. baseHp)
	print('[ARBUZ] Макс. резист: ' .. damageReductionMaxPercent .. '%')
	print('[ARBUZ] Коэффициент живучести (K): ' .. string.format("%.2f", k))
	print('[ARBUZ] ЧТОБЫ УБИТЬ, НУЖНО НАНЕСТИ: ' .. string.format("%.1f", totalRealHp))
	print('---------------------------------------------')
end
