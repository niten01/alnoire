derek_strafe = class {}


function derek_strafe:ShowWarning(targetPos)
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local distance = self:GetSpecialValueFor("distance")
  local delay = self:GetSpecialValueFor("warning_delay")


  local dest = GetOptimalStrafeDestination(casterPos, targetPos, distance)
  local strafeV = dest - casterPos
  local strafeDir = strafeV:Normalized()
  local strafeDist = #strafeV

  local shotDir = strafeDir:Cross(Vector(0, 0, 1)):Normalized()
  if #(targetPos - (casterPos + shotDir * 50)) > #(targetPos - (casterPos - shotDir * 50)) then
    shotDir = -shotDir
  end

  local shotDistStep = self:GetSpecialValueFor("shot_dist_step")
  local projDist = self:GetSpecialValueFor("proj_distance")
  local projRadius = self:GetSpecialValueFor("proj_radius")
  self.strafeV = strafeV
  self.shotDir = shotDir
  self.shotStartPoints = {}
  local accum = 0
  while accum <= strafeDist do
    local shotStartPos = casterPos + strafeDir * accum
    table.insert(self.shotStartPoints, shotStartPos)
    accum = accum + shotDistStep
    ShowGenericLineWarning(shotStartPos, shotStartPos + shotDir * projDist, projRadius, delay)
  end

  ShowGenericLineWarning(casterPos, dest, 50, delay + self:GetCastPoint())
  return delay
end

function derek_strafe:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  caster.derekCasting = true

  assert(self.shotDir)
  assert(self.shotStartPoints)
  assert(self.strafeV)
  local time = self:GetSpecialValueFor("time")

  caster:EmitSound("ability.derek.dash")
  caster:EmitSound("derek.vo.grunt")

  local strafeDir = self.strafeV:Normalized()
  local pfx = ParticleManager:CreateParticle("particles/derek_move.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
  caster:AddNewModifier(caster, self, "modifier_move_ease", {
    directionX = strafeDir.x,
    directionY = strafeDir.y,
    duration = time,
    distance = #self.strafeV,
    activity = ACT_DOTA_CAST_ABILITY_6,
    pfx = pfx,
  })
  caster:FaceTowards(casterPos + self.shotDir)

  local shotDistance = self:GetSpecialValueFor("proj_distance")
  local shotSpeed = self:GetSpecialValueFor("proj_speed")
  local shotRadius = self:GetSpecialValueFor("proj_radius")
  local interval = time / (#self.shotStartPoints + 1)
  local i = 1
  Timers:CreateTimer(0, function()
    local shotStartPos = self.shotStartPoints[i]

    EmitSoundOnLocationWithCaster(shotStartPos, "ability.derek.strafe.throw", caster)

    ProjectileManager:CreateLinearProjectile({
      Ability = self,
      EffectName = "particles/derek_linear_proj.vpcf",
      vSpawnOrigin = shotStartPos,
      vVelocity = self.shotDir * shotSpeed,
      fDistance = shotDistance,
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

    i = i + 1
    if i > #self.shotStartPoints then
      caster.derekCasting = false
      return nil
    end
    return interval
  end)
end

function derek_strafe:OnProjectileHit(target, location)
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

  PlayDerekBloodEffects(target, -self.shotDir)
end
