derek_wolf_leap = class {}

function derek_wolf_leap:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  caster.derekCasting = true
  caster:Stop()

  local target = self:GetCursorTarget()
  local targetPos = target:GetAbsOrigin()
  local jumpDistance = self:GetSpecialValueFor("jump_distance")

  local dest = GetOptimalStrafeDestination(casterPos, targetPos, jumpDistance)
  dest.z = GetGroundHeight(dest, nil)
  local strafeV = (dest - casterPos)
  local realDist = #strafeV

  local jumpTime = self:GetSpecialValueFor("jump_time")
  local jumpHeight = self:GetSpecialValueFor("jump_height")

  caster:EmitSound("ability.derek.wolf_leap.cast")

  local pfx = ParticleManager:CreateParticle("particles/derek_move.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
  caster:SetForwardVector(strafeV)
  caster:FaceTowards(casterPos + strafeV)
  caster:AddNewModifier(caster, self, "modifier_move", {
    directionX = strafeV.x,
    directionY = strafeV.y,
    duration = jumpTime,
    speed = realDist / jumpTime,
    activity = ACT_DOTA_CAST_ABILITY_3,
    pfx = pfx,
  })

  caster:AddNewModifier(caster, self, "modifier_vertical_jump", {
    duration = jumpTime,
    height = jumpHeight,
  })

  local projSpeed = self:GetSpecialValueFor("proj_speed")
  local projDist = self:GetSpecialValueFor("proj_distance")
  local projRadius = self:GetSpecialValueFor("proj_radius")
  Timers:CreateTimer(jumpTime, function()
    caster.derekCasting = false
    local pfx = ParticleManager:CreateParticle(
      "particles/econ/items/phoenix/phoenix_ti10_immortal/phoenix_ti10_fire_spirit_ground.vpcf", PATTACH_ABSORIGIN,
      caster)
    ParticleManager:SetParticleControl(pfx, 1, Vector(400, 0, 0))
    ParticleManager:ReleaseParticleIndex(pfx)

    local sanyaPos = target:GetAbsOrigin()
    local casterPos = caster:GetAbsOrigin()
    local dir = (sanyaPos - casterPos):Normalized()
    ProjectileManager:CreateLinearProjectile({
      Ability = self,
      EffectName = "particles/derek_linear_proj_v2.vpcf",
      vSpawnOrigin = casterPos,
      vVelocity = dir * projSpeed,
      fDistance = projDist,
      fStartRadius = projRadius,
      fEndRadius = projRadius,
      Source = caster,
      bHasFrontalCone = false,
      iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
      iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
      bProvidesVision = true,
      iVisionRadius = 500,
      iVisionTeamNumber = caster:GetTeamNumber()
    })
  end)
end

function derek_wolf_leap:OnProjectileHit(target, location)
  if not IsServer() then return end
  if not target then return end
  local caster = self:GetCaster()
  local damage = self:GetSpecialValueFor("proj_damage")
  local damageType = self:GetAbilityDamageType()
  PlayDerekBloodEffects(target, location - target:GetAbsOrigin())
  ApplyDamage({
    victim = target,
    attacker = caster,
    damage = damage,
    damage_type = damageType,
    ability = self,
  })
end
