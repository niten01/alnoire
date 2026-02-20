island_guard_laser = class {}

function island_guard_laser:GetEndPos(targetPos)
  local length = self:GetSpecialValueFor("length")
  local casterPos = self:GetCaster():GetAbsOrigin()
  local dir = (targetPos - casterPos):Normalized()
  return casterPos + dir * length
end

function island_guard_laser:ShowWarning(targetPos)
  local width = self:GetSpecialValueFor("width")
  local delay = 0.2

  local caster = self:GetCaster()
  assert(caster)
  local casterPos = caster:GetAbsOrigin()

  self.endPos = self:GetEndPos(targetPos)
  ShowGenericLineWarning(casterPos, self.endPos, width, delay)

  return delay
end

function island_guard_laser:GetBehavior()
  return DOTA_ABILITY_BEHAVIOR_POINT
end

function island_guard_laser:OnSpellStart()
  local width = self:GetSpecialValueFor("width")
  local damage = self:GetSpecialValueFor("damage")
  local caster = self:GetCaster()

  assert(self.endPos)
  local pfx = ParticleManager:CreateParticle(
    "particles/econ/items/tinker/tinker_ti10_immortal_laser/tinker_ti10_immortal_laser.vpcf", PATTACH_CUSTOMORIGIN,
    caster)
  ParticleManager:SetParticleControlEnt(pfx, 9, caster, PATTACH_POINT_FOLLOW, "attach_hand_l", Vector(0, 0, 0), true)
  ParticleManager:SetParticleControl(pfx, 1, self.endPos)
  ParticleManager:ReleaseParticleIndex(pfx)

  caster:EmitSound("ability.island_guard.laser.hit")

  local startPos = caster:GetAbsOrigin()
  startPos.z = 0
  self.endPos.z = 0
  local enemies = FindEnemiesForAIInLine(startPos, self.endPos, width)
  for _, ent in ipairs(enemies) do
    ApplyDamage({
      victim = ent,
      attacker = caster,
      damage = damage,
      damage_type = DAMAGE_TYPE_MAGICAL,
      ability = self,
    })
  end
end
