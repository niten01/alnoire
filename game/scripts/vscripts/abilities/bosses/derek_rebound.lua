derek_rebound = class {}

function derek_rebound:ShowWarning(targetPos)
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local dir = (targetPos - casterPos):Normalized()
  local radius = self:GetSpecialValueFor("radius")
  local delay = self:GetSpecialValueFor("warning_delay")
  local side = caster:GetRightVector()
  local arcInfo = PointsArc(casterPos, casterPos + dir * radius / 2, casterPos + side)
  ShowGenericArcWarning(arcInfo, radius, delay)
  return delay
end

function derek_rebound:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local radius = self:GetSpecialValueFor("radius")
  local spread = self:GetSpecialValueFor("spread")
  local enemies = FindEnemiesInSegment(casterPos, radius, spread)
  local damage = self:GetSpecialValueFor("damage")
  for _, ent in ipairs(enemies) do
    ApplyDamage({
      victim = ent,
      attacker = caster,
      damage = damage,
      damage_type = self:GetAbilityDamageType(),
      ability = self,
    })
  end

  local jumpDistatnce = self:GetSpecialValueFor("jump_distance")
  local fwd = caster:GetForwardVector()
  local endPos = GetSafeBlinkDestination(casterPos, casterPos - fwd * jumpDistatnce, jumpDistatnce)
  local dist = #(endPos - casterPos)
  local time = self:GetSpecialValueFor("jump_time")
  caster:AddNewModifier(caster, self, "modifier_move", {
    directionX = -fwd.x,
    directionY = -fwd.y,
    duration = time,
    speed = dist / time,
    activity = ACT_DOTA_CAST_ABILITY_6
  })
end
