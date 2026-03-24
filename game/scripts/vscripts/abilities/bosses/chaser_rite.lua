chaser_rite = class {}

function chaser_rite:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local targetPos = self:GetCursorPosition()
  local delay = self:GetSpecialValueFor("delay")
  local radius = self:GetSpecialValueFor("radius")
  local damage = self:GetSpecialValueFor("damage")

  Timers:CreateTimer(delay, function()
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
