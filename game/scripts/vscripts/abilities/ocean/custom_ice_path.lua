LinkLuaModifier("modifier_custom_ice_path_thinker", "abilities/custom_ice_path.lua", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_custom_ice_path_stun", "abilities/custom_ice_path.lua", LUA_MODIFIER_MOTION_NONE)

custom_ice_path = class({})

function custom_ice_path:OnSpellStart()
	if not IsServer() then return end

	local caster = self:GetCaster()
	local point = self:GetCursorPosition()
	local caster_pos = caster:GetAbsOrigin()

	-- Параметры из KV
	local duration = self:GetSpecialValueFor("duration")
	local path_delay = self:GetSpecialValueFor("path_delay")
	local range = self:GetCastRange(point, nil) + caster:GetCastRangeBonus()

	-- Вычисляем направление и конечную точку
	local direction = (point - caster_pos):Normalized()
	direction.z = 0
	local end_pos = caster_pos + direction * range

	-- Создаем синклер (невидимый юнит-контроллер пути)
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

	self.path_radius = self.ability:GetSpecialValueFor("path_radius")
	self.path_delay = self.ability:GetSpecialValueFor("path_delay")
	self.stun_duration = self.ability:GetSpecialValueFor("stun_duration")
	self.damage = self.ability:GetSpecialValueFor("damage")

	self.is_active = false -- Лед станет активным только после задержки

	-- Создаем эффект "предвестника" (слабое свечение)
	self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_jakiro/jakiro_ice_path.vpcf",
		PATTACH_WORLDORIGIN, nil)
	ParticleManager:SetParticleControl(self.pfx, 0, self.start_pos)
	ParticleManager:SetParticleControl(self.pfx, 1, self.end_pos)
	ParticleManager:SetParticleControl(self.pfx, 2, Vector(self.path_delay + self:GetDuration(), 0, 0))

	-- Таймер активации льда
	self:StartIntervalThink(self.path_delay)
end

function modifier_custom_ice_path_thinker:OnIntervalThink()
	if not IsServer() then return end

	if not self.is_active then
		-- ЛЕД ПОЯВИЛСЯ
		self.is_active = true
		EmitSoundOnLocationWithCaster(self.start_pos, "Hero_Jakiro.IcePath", self.caster)

		-- Теперь проверяем коллизию часто (каждые 0.1 сек), пока лед стоит
		self:StartIntervalThink(0.1)
	end

	-- Поиск врагов в линии
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
		-- Если враг еще не оглушен этим путем (или мы хотим обновлять стан)
		if not enemy:HasModifier("modifier_custom_ice_path_stun") then
			enemy:AddNewModifier(self.caster, self.ability, "modifier_custom_ice_path_stun",
				{ duration = self.stun_duration })

			ApplyDamage({
				victim = enemy,
				attacker = self.caster,
				damage = self.damage,
				damage_type = DAMAGE_TYPE_MAGICAL,
				ability = self.ability
			})
		end
	end
end

function modifier_custom_ice_path_thinker:OnDestroy()
	if not IsServer() then return end
	if self.pfx then
		ParticleManager:DestroyParticle(self.pfx, false)
		ParticleManager:ReleaseParticleIndex(self.pfx)
	end
	UTIL_Remove(self:GetParent()) -- Удаляем невидимого юнита
end

--------------------------------------------------------------------------------

modifier_custom_ice_path_stun = class({})

function modifier_custom_ice_path_stun:CheckState()
	return { [MODIFIER_STATE_STUNNED] = true, [MODIFIER_STATE_FROZEN] = true }
end

function modifier_custom_ice_path_stun:GetEffectName()
	return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_custom_ice_path_stun:GetEffectAttachType()
	return PATTACH_OVERHEAD_FOLLOW
end
