island_guard_laser = class {}

function island_guard_laser:ShowWarning(targetPos)
  local width = self:GetSpecialValueFor("width")
  local length = self:GetSpecialValueFor("length")

  local caster = self:GetCaster()
  assert(caster)
  local casterPos = caster:GetAbsOrigin()

  -- TODO
  local pfx = ParticleManager:CreateParticle(
    "particles/units/heroes/heroes_underlord/underlord_root_pre.vpcf", PATTACH_WORLDORIGIN, caster)
  ParticleManager:SetParticleControl(pfx, 0, point)
  ParticleManager:ReleaseParticleIndex(pfx)

  caster:EmitSound("ability.island_guard.root.warning")

  return 1
end

function island_guard_laser:GetBehavior()
  return DOTA_ABILITY_BEHAVIOR_POINT
end

function island_guard_laser:OnSpellStart()
  local width = self:GetSpecialValueFor("width")
  local length = self:GetSpecialValueFor("length")
  local caster = self:GetCaster()

  local pfx = ParticleManager:CreateParticle(
    "particles/units/heroes/heroes_underlord/underlord_root_pre.vpcf", PATTACH_WORLDORIGIN, caster)
  ParticleManager:SetParticleControl(pfx, 0, point)
  ParticleManager:ReleaseParticleIndex(pfx)

  local enemies = FindEnemiesForAIInLine(caster:GetAbsOrigin(), )
  -- TODO
end
