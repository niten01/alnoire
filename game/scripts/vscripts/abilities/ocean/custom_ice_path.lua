LinkLuaModifier("modifier_custom_ice_path_thinker", "abilities/ocean/custom_ice_path", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_ice_path_stun", "abilities/ocean/custom_ice_path", LUA_MODIFIER_MOTION_NONE)

custom_ice_path = class({})

function custom_ice_path:OnSpellStart()
	if not IsServer() then return end

	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local caster_pos = caster:GetAbsOrigin()

	local duration = self:GetSpecialValueFor("duration")
	local path_delay = self:GetSpecialValueFor("pathDelay")
	local range = self:GetCastRange(point, nil) + caster:GetCastRangeBonus()

	local direction = (point - caster_pos):Normalized()
	direction.z = 0
	local end_pos = caster_pos + direction * range

	CreateModifierThinker(
		caster,
		self,
		"modifier_custom_ice_path_thinker",
		{
			duration = duration + path_delay,
			end_x = end_pos.x,
			end_y = end_pos.y,
			end_z = end_pos.z
		},
		caster_pos,
		caster:GetTeamNumber(),
		false
	)

	EmitSoundOn("Hero_Jakiro.IcePath.Cast", caster)
end

--------------------------------------------------------------------------------

modifier_custom_ice_path_thinker = class({})

function modifier_custom_ice_path_thinker:OnCreated(kv)
	if not IsServer() then return end

	self.ability = self:GetAbility()
	self.caster = self:GetCaster()

	self.start_pos = self:GetParent():GetAbsOrigin()
	self.end_pos = Vector(kv.end_x, kv.end_y, kv.end_z)

	local visual_start = self.start_pos + Vector(0, 0, 15)
	local visual_end = self.end_pos + Vector(0, 0, 15)

	self.path_delay = self.ability:GetSpecialValueFor("pathDelay")
	self.stun_duration = self.ability:GetSpecialValueFor("stunDuration")
	self.path_radius = 150

	self.is_active = false
	self.hit_units = {}

	self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_jakiro/jakiro_ice_path.vpcf",
		PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.pfx, 0, visual_start)
	ParticleManager:SetParticleControl(self.pfx, 1, visual_end)
	ParticleManager:SetParticleControl(self.pfx, 2, Vector(self.path_delay + self:GetDuration(), 0, 0))

	self:StartIntervalThink(self.path_delay)
end

function modifier_custom_ice_path_thinker:OnIntervalThink()
	if not IsServer() then return end

	if not self.is_active then
		self.is_active = true
		EmitSoundOnLocationWithCaster(self.start_pos, "Hero_Jakiro.IcePath", self.caster)
		self:StartIntervalThink(0.05)
	end

	local enemies = FindUnitsInLine(
		self.caster:GetTeamNumber(),
		self.start_pos,
		self.end_pos,
		nil,
		self.path_radius,
		DOTA_UNIT_TARGET_TEAM_ENEMY,
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
		DOTA_UNIT_TARGET_FLAG_NONE
	)

	for _, enemy in pairs(enemies) do
		local entIndex = enemy:GetEntityIndex()

		if not self.hit_units[entIndex] then
			enemy:AddNewModifier(self.caster, self.ability, "modifier_custom_ice_path_stun", {
				duration = self.stun_duration
			})

			self.hit_units[entIndex] = true
		end
	end
end

function modifier_custom_ice_path_thinker:OnDestroy()
	if not IsServer() then return end

	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
		self.pfx = nil
	end

	local thinker = self:GetParent()
	if thinker and not thinker:IsNull() then
		Timers:CreateTimer(0.1, function()
			if thinker and not thinker:IsNull() then
				thinker:Remove()
			end
		end)
	end
end

--------------------------------------------------------------------------------

modifier_custom_ice_path_stun = class({})

function modifier_custom_ice_path_stun:CheckState()
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_FROZEN] = true }
end

function modifier_custom_ice_path_stun:GetEffectName()
	return "particles/units/heroes/hero_jakiro/jakiro_icepath_debuff.vpcf"
end

function modifier_custom_ice_path_stun:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
