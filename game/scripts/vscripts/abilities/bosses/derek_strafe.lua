derek_strafe = class {}

local function GetBisect(casterPos, targetPos, side)
  local vTarget = targetPos - casterPos
  local sidePos = casterPos + side * vTarget:Length()
  local midPoint = (sidePos + targetPos) / 2
  return (midPoint - casterPos):Normalized()
end

function derek_strafe:ShowWarning(targetPos)
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local distance = self:GetSpecialValueFor("distance")
  local delay = self:GetSpecialValueFor("warning_delay")

  local side = caster:GetRightVector()
  local strafeDir = GetBisect(casterPos, targetPos, side)
  local dest = GetSafeBlinkDestination(casterPos, casterPos + strafeDir * distance)
  local otherDir = GetBisect(casterPos, targetPos, -side)
  local otherDest = GetSafeBlinkDestination(casterPos, casterPos + otherDir * distance)
  if #(otherDest - casterPos) > #(dest - casterPos) then
    strafeDir = otherDir
    dest = otherDest
  end

  local shotDir = strafeDir:Cross(Vector(0, 0, 1)):Normalized()
  if #(targetPos - (casterPos + shotDir * 50)) > (targetPos - (casterPos - shotDir * 50)) then
    shotDir = -shotDir
  end

  local shotDistStep = self:GetSpecialValueFor("shot_dist_step")
  local projDist = self:GetSpecialValueFor("proj_distance")
  local projRadius = self:GetSpecialValueFor("proj_radius")
  self.strafeDir = strafeDir
  self.shotDir = shotDir
  self.shotStartPoints = {}
  local accum = 0
  while accum <= distance do
    local shotStartPos = casterPos + strafeDir * accum
    table.insert(self.shotStartPoints, shotStartPos)
    accum = accum + shotDistStep
    ShowGenericLineWarning(shotStartPos, shotStartPos + shotDir * projDist, projRadius, delay)
  end

  ShowGenericLineWarning(casterPos, dest, 50, delay)
  return delay
end

function derek_strafe:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  assert(self.shotDir)
  assert(self.shotStartPoints)
  assert(self.strafeDir)
  local strafeV = self.strafeDir * self:GetSpecialValueFor("distance")
  local time = self:GetSpecialValueFor("time")

  caster:AddNewModifier(caster, self, "modifier_move", {
    directionX = self.strafeDir.x,
    directionY = self.strafeDir.y,
    duration = time,
    speed = #strafeV / time,
    activity = ACT_DOTA_RUN,
  })

  local shotDistance = self:GetSpecialValueFor("proj_distance")
  local shotSpeed = self:GetSpecialValueFor("proj_speed")
  local shotRadius = self:GetSpecialValueFor("proj_radius")
  for _, shotStartPos in ipairs(self.shotStartPoints) do
    ProjectileManager:CreateLinearProjectile({
      Ability = self,
      EffectName = "particles/gorilla_clone_trail.vpcf",
      vSpawnOrigin = self.startPoint,
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
  end
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
end
