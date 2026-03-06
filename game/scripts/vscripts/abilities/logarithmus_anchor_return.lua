logarithmus_anchor_return = class {}

function logarithmus_anchor_return:Spawn()
  if not IsServer() then return end
  self:SetHidden(true)
end

function logarithmus_anchor_return:OnUpgrade()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local anchorAbility = caster:FindAbilityByName("logarithmus_anchor")
  assert(anchorAbility)
  if anchorAbility:GetLevel() ~= self:GetLevel() then
    anchorAbility:SetLevel(self:GetLevel())

    local alt = caster:FindAbilityByName("logarithmus_alt_anchor")
    assert(alt)
    alt:SetLevel(self:GetLevel())
  end
end

function logarithmus_anchor_return:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local anchorMod = caster:FindModifierByName("modifier_logarithmus_anchor")
  assert(anchorMod and anchorMod.anchorLocation)
  local anchorPos = anchorMod.anchorLocation
  anchorPos = GetSafeBlinkDestination(casterPos, anchorPos, #(anchorPos - casterPos))

  local pfx = ParticleManager:CreateParticle("particles/logarithmus_step.vpcf", PATTACH_ABSORIGIN, caster)
  ParticleManager:SetParticleControl(pfx, 0, casterPos)
  ParticleManager:SetParticleControl(pfx, 1, anchorPos)
  ParticleManager:ReleaseParticleIndex(pfx)

  caster:EmitSound("ability.logarithmus.anchor_return.cast")

  local enemies = FindEnemiesForSanyaInLine(casterPos, anchorPos, self:GetSpecialValueFor("width"))
  for _, ent in pairs(enemies) do
    PlayLogarithmusImpaleEffect(ent, casterPos)
    ApplyDamage({
      victim = ent,
      attacker = caster,
      damage = self:GetAbilityDamage(),
      damage_type = self:GetAbilityDamageType(),
      ability = self,
    })
  end

  caster:Stop()
  FindClearSpaceForUnit(caster, anchorPos, true)
  local dir = (anchorPos - casterPos):Normalized()
  caster:SetForwardVector(dir)
  caster:FaceTowards(anchorPos + dir * 100)

  caster:RemoveModifierByName("modifier_logarithmus_anchor")
end
