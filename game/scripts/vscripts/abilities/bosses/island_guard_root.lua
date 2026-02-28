island_guard_root = class {}

function island_guard_root:ShowWarning()
  local scatterRadius = self:GetSpecialValueFor("scatter_radius")
  local numAreas = self:GetSpecialValueFor("num_areas")
  local areaRadius = self:GetSpecialValueFor("area_radius")
  local minDist = self:GetSpecialValueFor("min_distance_from_caster")

  local caster = self:GetCaster()
  assert(caster)
  local casterPos = caster:GetAbsOrigin()
  self.points = RandomPointsInCircle(casterPos, scatterRadius, numAreas, minDist)
  for _, point in ipairs(self.points) do
    point.z = casterPos.z
    local pfx = ParticleManager:CreateParticle(
      "particles/units/heroes/heroes_underlord/underlord_pitofmalice_pre.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, point)
    ParticleManager:SetParticleControl(pfx, 1, Vector(areaRadius, 0, 0))
    ParticleManager:ReleaseParticleIndex(pfx)
  end

  caster:EmitSound("ability.island_guard.root.warning")

  return 1
end

function island_guard_root:GetBehavior()
  return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
end

function island_guard_root:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  assert(caster)
  local areaRadius = self:GetSpecialValueFor("area_radius")
  local areaDuration = self:GetSpecialValueFor("area_duration")

  assert(self.points)
  self.pfxs = {}
  for _, point in ipairs(self.points) do
    EmitSoundOnLocationWithCaster(point, "ability.island_guard.root.hit", caster)

    local pfx = ParticleManager:CreateParticle(
      "particles/units/heroes/heroes_underlord/underlord_pitofmalice.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, point)
    ParticleManager:SetParticleControl(pfx, 1, Vector(areaRadius, 0, 0))
    ParticleManager:SetParticleControl(pfx, 2, Vector(areaDuration, 0, 0))
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
          curTime - (ent.islandGuardLastRooted or -1) > rootCooldown + rootDuration then
        ent.islandGuardLastRooted = curTime
        ent:EmitSound("ability.island_guard.root.catch")
        ent:AddNewModifier(self:GetCaster(), self, "modifier_rooted", { duration = rootDuration })
        local rootPfx = ParticleManager:CreateParticle(
          "particles/units/heroes/heroes_underlord/abyssal_underlord_pitofmalice_stun.vpcf", PATTACH_ABSORIGIN_FOLLOW,
          ent)
        ParticleManager:SetParticleControlEnt(rootPfx, 0, ent, PATTACH_ABSORIGIN_FOLLOW, "", Vector(0, 0, 0), true)
        Timers:CreateTimer(rootDuration, function()
          ParticleManager:DestroyParticle(rootPfx, false)
          ParticleManager:ReleaseParticleIndex(rootPfx)
        end)
      end
    end
  end

  self.remainingDuration = self.remainingDuration - interval
  if self.remainingDuration <= 0 then
    for _, pfx in ipairs(self.pfxs) do
      -- ParticleManager:DestroyParticle(pfx, false)
      ParticleManager:ReleaseParticleIndex(pfx)
    end
    return nil
  else
    return interval
  end
end
