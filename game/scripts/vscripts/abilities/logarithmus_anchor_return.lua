logarithmus_anchor_return = class {}

function logarithmus_anchor_return:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local anchorMod = caster:FindModifierByName("modifier_logarithmus_anchor")
  assert(anchorMod and anchorMod.anchorLocation)
  local anchorPos = anchorMod.anchorLocation
  anchorPos = GetSafeBlinkDestination(casterPos, anchorPos, #(anchorPos - casterPos))

  local pfx = ParticleManager:CreateParticle("particles/logarithmus_step_simplified.vpcf", PATTACH_ABSORIGIN, caster)
  ParticleManager:SetParticleControl(pfx, 0, casterPos)
  ParticleManager:SetParticleControl(pfx, 1, anchorPos)
  ParticleManager:ReleaseParticleIndex(pfx)

  local enemies = FindEnemiesForSanyaInLine(casterPos, anchorPos, self:GetSpecialValueFor("width"))
  for _, ent in pairs(enemies) do
    ApplyDamage({
      victim = ent,
      attacker = caster,
      damage = self:GetAbilityDamage(),
      damage_type = self:GetAbilityDamageType(),
      ability = self,
    })
  end

  FindClearSpaceForUnit(caster, anchorPos, true)
  local dir = (anchorPos - casterPos):Normalized()
  caster:SetForwardVector(dir)
  caster:FaceTowards(anchorPos + dir * 100)
end
