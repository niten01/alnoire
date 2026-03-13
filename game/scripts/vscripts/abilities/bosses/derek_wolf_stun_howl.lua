derek_wolf_stun_howl = class {}

function derek_wolf_stun_howl:ShowWarning()
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local delay = self:GetSpecialValueFor("warning_delay")
  local radius = self:GetSpecialValueFor("radius")
  ShowGenericCircleWarning(casterPos, radius, delay + self:GetCastPoint())
  return delay
end

function derek_wolf_stun_howl:OnSpellStart()
  if not IsServer() then return end
  local caster    = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local radius    = self:GetSpecialValueFor("radius")
  local damage    = self:GetSpecialValueFor("damage")

  local mouthIdx= caster:ScriptLookupAttachment("attach_mouth")
  local mouthPos = caster:GetAttachmentOrigin(mouthIdx)

  local pfx       = ParticleManager:CreateParticle("particles/derek_wolf_stun_howl.vpcf", PATTACH_WORLDORIGIN, nil)
  ParticleManager:SetParticleControl(pfx, 0,  Vector(casterPos.x, casterPos.y, mouthPos.z + 50))
  ParticleManager:SetParticleControl(pfx, 1, Vector(80, 0, 0))
  ParticleManager:SetParticleControl(pfx, 5, Vector(radius - 200, 0, 0))
  ParticleManager:ReleaseParticleIndex(pfx)

  caster:EmitSound("ability.derek.wolf_stun_howl.cast")

  local enemies = FindEnemiesForAIInRadius(casterPos, radius)
  for _, ent in ipairs(enemies) do
    ApplyDamage({
      victim = ent,
      attacker = caster,
      damage = damage,
      damage_type = self:GetAbilityDamageType(),
      ability = self,
    })

    ent:AddNewModifier(caster, self, "modifier_stunned", {
      duration = self:GetSpecialValueFor("stun_duration"),
    })
  end
end