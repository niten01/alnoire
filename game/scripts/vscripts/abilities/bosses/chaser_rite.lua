chaser_rite = class {}

function chaser_rite:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local targetPos = self:GetCursorPosition()
  local delay = self:GetSpecialValueFor("delay")
  local radius = self:GetSpecialValueFor("radius")
  local damage = self:GetSpecialValueFor("damage")

  local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_ring.vpcf",
    PATTACH_WORLDORIGIN, nil)
  ParticleManager:SetParticleControl(pfx, 0, targetPos)
  ParticleManager:SetParticleControl(pfx, 1, Vector(radius, 1, radius))

  caster:EmitSound("ability.chaser.rite.cast")

  Timers:CreateTimer(delay, function()
    ParticleManager:DestroyParticle(pfx, false)
    ParticleManager:ReleaseParticleIndex(pfx)

    caster:EmitSound("ability.chaser.rite.explode")

    local enemies = FindEnemiesForAIInRadius(targetPos, radius)
    for _, ent in ipairs(enemies) do
      ApplyDamage({
        victim = ent,
        attacker = caster,
        damage = damage,
        damage_type = self:GetAbilityDamageType(),
        ability = self,
      })
    end
  end)
end
