derek_epicenter = class {}

function derek_epicenter:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local numAreas = self:GetSpecialValueFor("num_areas")
  local spawnRadius = self:GetSpecialValueFor("spawnRadius")
  local areaRadius = self:GetSpecialValueFor("area_radius")
  local warningDelay = self:GetSpecialValueFor("warning_delay")
  local interval = self:GetSpecialValueFor("interval")
  local numPulses = self:GetSpecialValueFor("num_pulses")
  local damage = self:GetSpecialValueFor("damage")
  for _ = 1, numAreas, 1 do
    local counter = 0
    Timers:CreateTimer(0, function()
      local point = RandomPointsInCircle(casterPos, spawnRadius, 1, 100)
      ShowGenericCircleWarning(point, areaRadius, warningDelay)
      Timers:CreateTimer(warningDelay, function()
        local enemies = FindEnemiesForAIInRadius(point, areaRadius)
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
      if counter < numPulses then
        return interval
      end
      return nil
    end)
  end
end
