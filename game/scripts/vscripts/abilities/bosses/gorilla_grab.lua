gorilla_grab = class {}

function gorilla_grab:ShowWarning()
  local caster = self:GetCaster()
  local delay = self:GetSpecialValueFor("warning_delay")
  local radius = self:GetSpecialValueFor("radius")
  ShowGenericCircleWarning(caster:GetAbsOrigin(), radius, delay)
  return delay
end

function gorilla_grab:OnSpellStart()
  local caster = self:GetCaster()
  local radius = self:GetSpecialValueFor("radius")
  local duration = self:GetSpecialValueFor("umm_duration")
  local damage = self:GetSpecialValueFor("damage")
  local enemies = FindEnemiesForAIInRadius(caster:GetAbsOrigin(), radius)
  for _, ent in ipairs(enemies) do
    caster:AddNewModifier(caster, self, "modifier_gorilla_umm", { duration = duration, damage = 0 })
    ent:AddNewModifier(caster, self, "modifier_gorilla_umm", { duration = duration, damage = damage })
    break
  end
  caster:EmitSound("ability.gorilla.grab")
end
