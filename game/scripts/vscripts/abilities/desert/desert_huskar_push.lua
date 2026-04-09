LinkLuaModifier('modifier_desert_huskar_push_jump', 'abilities/desert/desert_huskar_push', LUA_MODIFIER_MOTION_HORIZONTAL)

desert_huskar_push = class({})

function desert_huskar_push:OnSpellStart()
	if not IsServer() then return end
	local caster = self:GetCaster()
	local point = self:GetCursorPosition()

	local speed = self:GetSpecialValueFor('jumpSpeed')
	local distance = (point - caster:GetAbsOrigin()):Length2D()
	local duration = distance / speed

	caster:AddNewModifier(caster, self, "modifier_desert_huskar_push_jump",
		{
			duration = duration,
			x = point.x,
			y = point.y,
			z = point.z
		}
	)
	EmitSoundOn("Hero_Huskar.Life_Break", caster)
end

--------------------------------------------------------------------------------

modifier_desert_huskar_push_jump = class({})

function modifier_desert_huskar_push_jump:IsHidden() return true end

function modifier_desert_huskar_push_jump:OnCreated(kv)
	if not IsServer() then return end
	self.caster = self:GetParent()
	self.target_pos = Vector(kv.x, kv.y, kv.z)

	self.abil = self:GetAbility()
	if not self.abil then
		self:Destroy()
		return
	end

	self.speed = self.abil:GetSpecialValueFor('jumpSpeed')

	if self:ApplyHorizontalMotionController() == false then
		self:Destroy()
		return
	end

	self.caster:StartGesture(ACT_DOTA_CAST_LIFE_BREAK_START)
end

function modifier_desert_huskar_push_jump:OnDestroy()
	if not IsServer() then return end
	self.caster:FadeGesture(ACT_DOTA_CAST_LIFE_BREAK_START)
	self.caster:StartGesture(ACT_DOTA_CAST_LIFE_BREAK_END)
	self.caster:SetAbsOrigin(GetGroundPosition(self.caster:GetAbsOrigin(), self.caster))

	local radius = self.abil:GetSpecialValueFor('jumpImpactRadius')
	local initialDamage = self.abil:GetSpecialValueFor('initialDamage')

	local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_huskar/huskar_inner_fire.vpcf",
		PATTACH_ABSORIGIN, self.caster)
	ParticleManager:SetParticleControl(pfx, 1, Vector(radius, 0, 0))
	ParticleManager:SetParticleControl(pfx, 3, Vector(radius, 0, 0))
	ParticleManager:ReleaseParticleIndex(pfx)

	EmitSoundOn("Hero_Huskar.InnerFire.Cast", self.caster)
	local enemies = FindEnemiesForAIInRadius(self.caster:GetAbsOrigin(), radius)
	local pushDuration = self.abil:GetSpecialValueFor('pushDuration')
	local pushDistance = self.abil:GetSpecialValueFor('pushDistance')
	for _, enemy in pairs(enemies) do
		local v = enemy:GetAbsOrigin() - self.caster:GetAbsOrigin()
		local knockback_properties = {
			duration = pushDuration,
			directionX = v.x,
			directionY = v.y,
			speed = pushDistance / pushDuration,
			activity = ACT_DOTA_FLAIL,
		}
		local damageTable = {
			victim = enemy,
			attacker = self.caster,
			damage = initialDamage,
			damage_type = DAMAGE_TYPE_MAGICAL,
			ability = self,
		}
		ApplyDamage(damageTable)
		enemy:AddNewModifier(self.caster, self.abil, 'modifier_stunned_wrap', { duration = pushDuration })
		enemy:AddNewModifier(self.caster, self.abil, "modifier_move", knockback_properties)
	end
end

function modifier_desert_huskar_push_jump:UpdateHorizontalMotion(me, dt)
	if not IsServer() then return end

	local curr_pos = me:GetAbsOrigin()
	local dir = (self.target_pos - curr_pos):Normalized()
	dir.z = 0

	local next_pos = curr_pos + dir * self.speed * dt

	me:SetAbsOrigin(GetGroundPosition(next_pos, me))
end

function modifier_desert_huskar_push_jump:CheckState()
	return {
		[MODIFIER_STATE_STUNNED] = true,
		[MODIFIER_STATE_NO_UNIT_COLLISION] = true,
	}
end
