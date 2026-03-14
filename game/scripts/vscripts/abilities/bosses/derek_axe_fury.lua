derek_axe_fury = class {}
LinkLuaModifier("modifier_derek_axe_fury", "abilities/bosses/derek_axe_fury", LUA_MODIFIER_MOTION_NONE)

function derek_axe_fury:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local target = self:GetCursorTarget()

  self.target = target

  target:AddNewModifier(caster, self, "modifier_derek_axe_fury", {
    duration = -1
  })

  self.pfx = ParticleManager:CreateParticle("particles/derek_axe_fury_channel.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)

  caster:EmitSound("ability.derek.axe_fury.loop")
end

function derek_axe_fury:OnChannelFinish(bInterrupted)
  if not IsServer() then return end
  local caster = self:GetCaster()
  caster:StopSound("ability.derek.axe_fury.loop")

  ParticleManager:DestroyParticle(self.pfx, false)
  ParticleManager:ReleaseParticleIndex(self.pfx)

  if not self.target or self.target:IsNull() then return end
  self.target:RemoveModifierByName("modifier_derek_axe_fury")
end

function derek_axe_fury:Fire(targetPos)
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local shotSpeed = self:GetSpecialValueFor("speed")
  local shotRadius = self:GetSpecialValueFor("radius")
  local shotDist = self:GetSpecialValueFor("distance")
  local dir = (targetPos - casterPos):Normalized()

  caster:EmitSound("ability.derek.swing")
  ScreenShake(casterPos, 7, 3, 1.5, 9999, 0, true)

  ProjectileManager:CreateLinearProjectile({
    Ability = self,
    EffectName = "particles/derek_slice_proj.vpcf",
    vSpawnOrigin = casterPos,
    vVelocity = dir * shotSpeed,
    fDistance = shotDist,
    fStartRadius = shotRadius,
    fEndRadius = shotRadius,
    Source = caster,
    bHasFrontalCone = false,
    iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
    iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    bProvidesVision = true,
    iVisionRadius = 500,
    iVisionTeamNumber = caster:GetTeamNumber()
  })
end

function derek_axe_fury:OnProjectileHit(target, location)
  if not IsServer() then return end
  if not target then return end
  local caster = self:GetCaster()
  local damage = self:GetSpecialValueFor("damage")
  local damageType = self:GetAbilityDamageType()
  ApplyDamage({
    victim = target,
    attacker = caster,
    damage = damage,
    damage_type = damageType,
    ability = self,
  })

  local targetPos = target:GetAbsOrigin()
  EmitSoundOnLocationWithCaster(targetPos, "ability.derek.strafe.hit", caster)

  local pfx = ParticleManager:CreateParticle(
    "particles/units/heroes/hero_beastmaster/beastmaster_wildaxes_hit.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
  ParticleManager:ReleaseParticleIndex(pfx)
end

-----------------------------------------------------------

modifier_derek_axe_fury = class {}

function modifier_derek_axe_fury:OnCreated(kv)
  if not IsServer() then return end
  local ability = self:GetAbility()
  local interval = ability:GetSpecialValueFor("interval")
  self:StartIntervalThink(interval)
end

function modifier_derek_axe_fury:OnIntervalThink()
  if not IsServer() then return end
  local parent = self:GetParent()
  self:GetAbility():Fire(parent:GetAbsOrigin())
end
