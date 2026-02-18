island_guard_firestorm = class {}

function island_guard_firestorm:ShowWarning()
  local oneWaveDelay = 1
  local numWaves = self:GetSpecialValueFor("num_waves")
  local shotsPerWave = self:GetSpecialValueFor("shots_per_wave")
  local radiusIncrease = self:GetSpecialValueFor("wave_radius_increase")

  local caster = self:GetCaster()
  assert(caster)
  local casterPos = caster:GetAbsOrigin()
  self.waves = {}
  self.wavesDelays = {}
  for i = 1, numWaves, 1 do
    local wavePoints = PointsAlongRing(casterPos, radiusIncrease * i, shotsPerWave, (i - 1) * math.pi / 6)
    local waveDelay = (i - 1) * oneWaveDelay
    table.insert(self.waves, wavePoints)
    table.insert(self.wavesDelays, waveDelay)
    Timers:CreateTimer(waveDelay, function()
      for _, point in ipairs(wavePoints) do
        local pfx = ParticleManager:CreateParticle(
          "particles/units/heroes/heroes_underlord/underlord_firestorm_pre.vpcf", PATTACH_WORLDORIGIN, caster)
        ParticleManager:SetParticleControl(pfx, 0, point)
        ParticleManager:ReleaseParticleIndex(pfx)
      end
    end)
  end


  caster:EmitSound("ability.island_guard.firestorm.warning")

  return 1
end

function island_guard_firestorm:GetBehavior()
  return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
end

function island_guard_firestorm:OnSpellStart()
  local caster = self:GetCaster()
  assert(caster)
  local radius = self:GetSpecialValueFor("radius")
  local damage = self:GetSpecialValueFor("damage")

  assert(self.waves)
  assert(self.wavesDelays)
  for i, wave in ipairs(self.waves) do
    Timers:CreateTimer(self.wavesDelays[i], function()
      for _, point in ipairs(wave) do
        EmitSoundOnLocationWithCaster(point, "ability.island_guard.firestorm.hit", caster)

        local pfx = ParticleManager:CreateParticle(
          "particles/units/heroes/heroes_underlord/abyssal_underlord_firestorm_wave.vpcf", PATTACH_WORLDORIGIN, caster)
        ParticleManager:SetParticleControl(pfx, 0, point)
        ParticleManager:ReleaseParticleIndex(pfx)

        local enemies = FindEnemiesForAIInRadius(point, radius)
        for _, ent in ipairs(enemies) do
          ApplyDamage({
            victim = ent,
            attacker = caster,
            damage = damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self,
          })
        end
      end
    end)
  end
end
