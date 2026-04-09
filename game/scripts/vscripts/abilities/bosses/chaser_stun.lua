chaser_stun = class {}

function chaser_stun:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local target = self:GetCursorTarget()

  local speed = self:GetSpecialValueFor("speed")
  local timeout = self:GetSpecialValueFor("timeout")

  caster:EmitSound("ability.chaser.stun.cast")

  ProjectileManager:CreateTrackingProjectile({
    vSourceLoc = caster:GetAbsOrigin() + Vector(0, 0, 300),
    Target = target,
    iMoveSpeed = speed,
    bDodgeable = false,
    bIgnoreObstructions = true,
    Ability = self,
    Source = caster,
    EffectName = "particles/chaser_stun_projectile.vpcf",
    flExpireTime = GameRules:GetGameTime() + timeout,
  })
end

function chaser_stun:OnProjectileHit(target, location)
  if not IsServer() then return end
  if not target then return end
  local caster = self:GetCaster()
  local damage = self:GetSpecialValueFor("damage")
  local stunDuration = self:GetSpecialValueFor("stun_duration")
  local damageType = self:GetAbilityDamageType()
  ApplyDamage({
    victim = target,
    attacker = caster,
    damage = damage,
    damage_type = damageType,
    ability = self,
  })
  target:AddNewModifier(caster, self, "modifier_stunned_wrap", { duration = stunDuration })

  if IsValidEntity(caster) then
    caster:EmitSound("ability.chaser.stun.hit")
  end
  return true
end
