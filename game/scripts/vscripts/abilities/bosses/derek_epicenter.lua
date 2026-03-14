derek_epicenter = class {}

function derek_epicenter:OnAbilityPhaseStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  caster:EmitSound("derek.vo.epicenter.cast")
end

function derek_epicenter:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local numAreas = self:GetSpecialValueFor("num_areas")
  local spawnRadius = self:GetSpecialValueFor("spawn_radius")
  local areaRadius = self:GetSpecialValueFor("area_radius")
  local warningDelay = self:GetSpecialValueFor("warning_delay")
  local interval = self:GetSpecialValueFor("interval")
  local numPulses = self:GetSpecialValueFor("num_pulses")
  local damage = self:GetSpecialValueFor("damage")
  for _ = 1, numAreas, 1 do
    local counter = 0
    Timers:CreateTimer(0, function()
      local point = RandomPointsInCircle(casterPos, spawnRadius, 1, 100)[1]
      point.z = GetGroundHeight(point, nil) + 20
      ShowGenericCircleWarning(point, areaRadius, warningDelay)
      Timers:CreateTimer(warningDelay, function()
        local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_sandking/sandking_epicenter.vpcf",
          PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(pfx, 0, point)
        ParticleManager:SetParticleControl(pfx, 1, Vector(areaRadius + 200, 1, 1))
        ParticleManager:ReleaseParticleIndex(pfx)

        EmitSoundOnLocationWithCaster(point, "ability.derek.epicenter.pulse", caster)

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
      counter = counter + 1
      if counter < numPulses then
        return interval
      end
      return nil
    end)
  end
end
