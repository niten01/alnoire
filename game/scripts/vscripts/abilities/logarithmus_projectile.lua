logarithmus_projectile = class {}

function logarithmus_projectile:Spawn()
end

function logarithmus_projectile:GetVectorTargetStartRadius()
  return self:GetSpecialValueFor("projectile_radius")
end

function logarithmus_projectile:GetVectorTargetRange()
  return self:GetSpecialValueFor("vector_range")
end

function logarithmus_projectile:OnVectorCastStart(vStartLocation, vDirection)
  if not IsServer() then return end
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local speed = self:GetSpecialValueFor("projectile_speed")
  local radius = self:GetSpecialValueFor("projectile_radius")

  local fistIdx = caster:ScriptLookupAttachment("attach_fist_L")
  local startPos = caster:GetAttachmentOrigin(fistIdx)

  vStartLocation.z = casterPos.z
  local endPos = vStartLocation + vDirection * self:GetVectorTargetRange()

  local parabolaInfo = PointsParabola(startPos, vStartLocation, endPos)

  local parabolaIter = parabolaInfo:UnstableIterator()
  local pfx = ParticleManager:CreateParticle(
    "particles/logarithmus_projectile.vpcf", PATTACH_WORLDORIGIN, nil)
  ParticleManager:SetParticleControl(pfx, 0, startPos)
  ParticleManager:SetParticleControl(pfx, 2, Vector(speed - 150, 0, 0))
  local function destroyPfx()
    ParticleManager:DestroyParticle(pfx, false)
    ParticleManager:ReleaseParticleIndex(pfx)
  end

  local travelTime = parabolaInfo:Length() / speed
  local interval = 0.01
  local lastTime = GameRules:GetGameTime()
  local prevPoint = nil
  Timers:CreateTimer(0, function()
    local curTime = GameRules:GetGameTime()
    local dt = curTime - lastTime
    lastTime = curTime

    local curPoint = parabolaIter(dt / travelTime)
    if not curPoint then
      destroyPfx()
      return nil
    end
    curPoint.z = startPos.z

    ParticleManager:SetParticleControl(pfx, 1, curPoint)

    local enemies = FindEnemiesForSanyaInRadius(curPoint, radius)
    for _, ent in ipairs(enemies) do
      destroyPfx()
      self:OnProjectileHit(ent, (prevPoint and curPoint - prevPoint) or Vector(0, 0, 0))
      return nil
    end
    prevPoint = curPoint
    return interval
  end)
end

function logarithmus_projectile:OnProjectileHit(target, direction)
  if not IsServer() or not target then return end
  local caster = self:GetCaster()
  local targetPos = target:GetAbsOrigin()
  direction = direction:Normalized()
  direction.z = 0
  local dirEmpty = #direction == 0
  if dirEmpty then
    direction = caster:GetForwardVector()
  end
  local endPos = targetPos - direction * 30

  FindClearSpaceForUnit(caster, endPos, true)
  caster:SetForwardVector(direction)
  caster:FaceTowards(targetPos)
  ApplyDamage({
    victim = target,
    attacker = caster,
    damage = self:GetAbilityDamage(),
    damage_type = self:GetAbilityDamageType(),
    ability = self,
  })
end
