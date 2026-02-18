island_guard_root = class {}

function island_guard_root:ShowWarning()
  local scatterRadius = self:GetSpecialValueFor("scatter_radius")
  local numAreas = self:GetSpecialValueFor("num_areas")
  local areaRadius = self:GetSpecialValueFor("area_radius")

  local caster = self:GetCaster()
  assert(caster)
  local casterPos = caster:GetAbsOrigin()
  self.points = RandomPointsInCircle(casterPos, scatterRadius, numAreas, 100)
  for _, point in ipairs(self.points) do
    local pfx = ParticleManager:CreateParticle(
      "particles/units/heroes/heroes_underlord/underlord_root_pre.vpcf", PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(pfx, 0, point)
    ParticleManager:ReleaseParticleIndex(pfx)
  end

  caster:EmitSound("ability.island_guard.root.warning")

  return 1
end

function island_guard_root:GetBehavior()
  return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
end

function island_guard_root:OnSpellStart()
  local caster = self:GetCaster()
  assert(caster)
  local areaDuration = self:GetSpecialValueFor("area_duration")

  assert(self.points)
  self.pfxs = {}
  for _, point in ipairs(self.points) do
    EmitSoundOnLocationWithCaster(point, "ability.island_guard.root.hit", caster)

    local pfx = ParticleManager:CreateParticle(
      "particles/units/heroes/heroes_underlord/abyssal_underlord_root_wave.vpcf", PATTACH_WORLDORIGIN, caster)
    ParticleManager:SetParticleControl(pfx, 0, point)
    table.insert(self.pfxs, pfx)
  end

  self.remainingDuration = areaDuration
  Timers:CreateTimer(0, function()
    return self:AreasThink()
  end)
end

function island_guard_root:AreasThink()
  local interval = 0.1
  local areaRadius = self:GetSpecialValueFor("area_radius")
  local rootDuration = self:GetSpecialValueFor("root_duration")
  local rootCooldown = self:GetSpecialValueFor("root_cooldown")

  local curTime = GameRules:GetGameTime()
  for _, point in ipairs(self.points) do
    local enemies = FindEnemiesForAIInRadius(point, areaRadius)
    for _, ent in ipairs(enemies) do
      if not ent:HasModifier("modifier_rooted") and
          curTime - (ent.islandGuardLastRooted or -1) > rootCooldown then
        ent.islandGuardLastRooted = curTime
        ent:AddNewModifier(self:GetCaster(), self, "modifier_rooted", { duration = rootDuration })
      end
    end
  end

  self.remainingDuration = self.remainingDuration - interval
  if self.remainingDuration <= 0 then
    for _, pfx in ipairs(self.pfxs) do
      ParticleManager:DestroyParticle(pfx, false)
      ParticleManager:ReleaseParticleIndex(pfx)
    end
    return nil
  else
    return interval
  end
end
