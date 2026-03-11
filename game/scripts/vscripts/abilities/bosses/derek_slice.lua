derek_slice = class {}

-- function derek_slice:ShowWarning(targetPos)
--   local caster = self:GetCaster()
--   local casterPos = self:GetAbsOrigin()
--   local delay = self:GetSpecialValueFor("warning_delay")
--   ShowGenericLineWarning(casterPos, targetPos, delay + self:GetCastPoint())
-- end


function derek_slice:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local casterPos = self:GetAbsOrigin()
  local targetPos = self:GetCursorPosition()
  local v = targetPos - casterPos
  local dist = #v
  local dir = v:Normalized()
  local time = self:GetSpecialValueFor("jump_time")

  caster:AddNewModifier(caster, self, "modifier_move", {
    directionX = dir.x,
    directionY = dir.y,
    duration = time,
    speed = dist / time,
    activity = ACT_DOTA_CAST_ABILITY_6
  })

  local hitDelay = self:GetSpecialValueFor("hit_delay")
  local damage = self:GetSpecialValueFor("damage")
  local radius = self:GetSpecialValueFor("radius")
  local spread = self:GetSpecialValueFor("spread")

  Timers:CreateTimer(hitDelay, function()
    local enemies = FindEnemiesInSegment(casterPos, radius, spread)
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
