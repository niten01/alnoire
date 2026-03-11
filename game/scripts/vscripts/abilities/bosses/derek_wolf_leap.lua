derek_wolf_leap = class {}

function derek_wolf_leap:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local targetPos = self:GetCursorPosition()
  local jumpDistance = self:GetSpecialValueFor("jump_distance")

  local dest = GetOptimalStrafeDestination(caster, targetPos, jumpDistance)
  local strafeV = (dest - casterPos)
  local realDist = #strafeV

  local jumpTime = self:GetSpecialValueFor("jump_distance")
  local jumpHeight = self:GetSpecialValueFor("jump_height")
  caster:AddNewModifier(caster, self, "modifier_move", {
    directionX = strafeV.x,
    directionY = strafeV.y,
    duration = jumpTime,
    speed = realDist / jumpTime,
    activity = ACT_DOTA_RUN,
  })

  caster:AddNewModifier(caster, self, "modifier_vertical_jump", {
    duration = jumpTime,
    height = jumpHeight,
  })

  local sanya = FindSanyaInRadius(casterPos, 9999)

  local projSpeed = self:GetSpecialValueFor("proj_speed")
  local projDist = self:GetSpecialValueFor("proj_distance")
  local projRadius = self:GetSpecialValueFor("proj_radius")
  Timers:CreateTimer(jumpTime, function()
    if not sanya then return end
    local sanyaPos = sanya:GetAbsOrigin()
    local dir = sanyaPos - casterPos
    ProjectileManager:CreateLinearProjectile({
      Ability = self,
      EffectName = "particles/gorilla_clone_trail.vpcf",
      vSpawnOrigin = caster:GetAbsOrigin(),
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
  local damage = self:GetSpecialValueFor("damage")
  local damageType = self:GetAbilityDamageType()
  ApplyDamage({
    victim = target,
    attacker = caster,
    damage = damage,
    damage_type = damageType,
    ability = self,
  })
end
