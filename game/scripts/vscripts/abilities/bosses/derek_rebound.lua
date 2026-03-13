derek_rebound = class {}

function derek_rebound:ShowWarning(targetPos)
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local radius = self:GetSpecialValueFor("radius")
  local delay = self:GetSpecialValueFor("warning_delay")
  ShowGenericCircleWarning(casterPos, radius, delay)
  self.targetPos = targetPos
  caster:SetCursorPosition(targetPos)
  return delay
end

function derek_rebound:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  caster.derekCasting = true
  local radius = self:GetSpecialValueFor("radius")
  local spread = self:GetSpecialValueFor("spread")
  assert(self.targetPos)
  local v = (self.targetPos - casterPos):Normalized() * radius
  local enemies = FindEnemiesInSegment(DOTA_TEAM_BADGUYS, casterPos, v, spread)
  local damage = self:GetSpecialValueFor("damage")
  for _, ent in ipairs(enemies) do
    ApplyDamage({
      victim = ent,
      attacker = caster,
      damage = damage,
      damage_type = self:GetAbilityDamageType(),
      ability = self,
    })
    PlayDerekBloodEffects(ent, -caster:GetForwardVector())
  end

  local pfx = ParticleManager:CreateParticle("particles/derek_cross_swipe.vpcf", PATTACH_ABSORIGIN, caster)
  ParticleManager:ReleaseParticleIndex(pfx)


  local jumpDistatnce = self:GetSpecialValueFor("jump_distance")
  local fwd = caster:GetForwardVector()
  local endPos = GetSafeBlinkDestination(casterPos, casterPos - fwd * jumpDistatnce, jumpDistatnce)
  local dist = #(endPos - casterPos)
  local time = self:GetSpecialValueFor("jump_time")

  caster:EmitSound("ability.derek.dash")
  caster:EmitSound("derek.vo.grunt")

  pfx = ParticleManager:CreateParticle("particles/derek_move.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
  caster:AddNewModifier(caster, self, "modifier_move_ease", {
    directionX = -fwd.x,
    directionY = -fwd.y,
    duration = time,
    distance = dist,
    activity = ACT_DOTA_CAST_ABILITY_6,
    pfx = pfx,
  })

  Timers:CreateTimer(time, function()
    caster.derekCasting = false
  end)
end
