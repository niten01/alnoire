logarithmus_clone = class {}

function logarithmus_clone:OnUpgrade()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local alt = caster:FindAbilityByName("logarithmus_alt_clone")
  assert(alt)
  alt:SetLevel(self:GetLevel())
end

function logarithmus_clone:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local distance = self:GetCastRange(casterPos, nil)
  local flyTime = self:GetSpecialValueFor("fly_time")
  local fwd = caster:GetForwardVector()
  local back = -fwd
  local endPos = GetSafeBlinkDestination(casterPos, casterPos + back * distance, distance)
  local realDistance = #(endPos - casterPos)
  local speed = realDistance / flyTime
  caster:Stop()
  caster:AddNewModifier(caster, self, "modifier_move", {
    directionX = back.x,
    directionY = back.y,
    duration = flyTime,
    speed = speed,
    activity = ACT_DOTA_CAST_ABILITY_6
  })

  local jumpPfx = ParticleManager:CreateParticle("particles/logarithmus_step_simplified.vpcf", PATTACH_ABSORIGIN, caster)
  ParticleManager:SetParticleControl(jumpPfx, 0, casterPos)
  ParticleManager:SetParticleControl(jumpPfx, 1, endPos)
  ParticleManager:ReleaseParticleIndex(jumpPfx)

  local clonePfx = ParticleManager:CreateParticle("particles/logarithmus_remnant.vpcf", PATTACH_WORLDORIGIN, nil)
  ParticleManager:SetParticleControl(clonePfx, 0, casterPos)
  ParticleManager:SetParticleControl(clonePfx, 1, casterPos + back)
  ParticleManager:SetParticleControl(clonePfx, 2, Vector(1, 0, 0)) -- idle_aggressive

  caster:EmitSound("ability.logarithmus.clone.cast")

  local swingSeqDuration = caster:SequenceDuration("attack_front")
  local swingDelay = self:GetSpecialValueFor("swing_delay")
  local swingAttackPoint = swingSeqDuration * self:GetSpecialValueFor("swing_animation_point_norm")
  Timers:CreateTimer(swingDelay, function()
    ParticleManager:SetParticleControl(clonePfx, 2, Vector(16, 0, 0)) -- attack_front

    -- destroy clone
    Timers:CreateTimer(swingSeqDuration, function()
      ParticleManager:DestroyParticle(clonePfx, false)
      ParticleManager:ReleaseParticleIndex(clonePfx)
      EmitSoundOnLocationWithCasterSafe(casterPos, "ability.logarithmus.clone.dissolve", caster)
    end)

    -- actual swing mid-animation
    Timers:CreateTimer(swingAttackPoint, function()
      local swingPfx = ParticleManager:CreateParticle("particles/logarithmus_clone_swing.vpcf", PATTACH_WORLDORIGIN, nil)
      ParticleManager:SetParticleControlTransformForward(swingPfx, 0, casterPos, fwd)

      EmitSoundOnLocationWithCasterSafe(casterPos, "ability.logarithmus.clone.swing", caster)

      local radius = self:GetSpecialValueFor("swing_radius")
      local angleWidth = self:GetSpecialValueFor("swing_angle_width")
      local enemies = FindEnemiesInSegment(DOTA_TEAM_GOODGUYS, casterPos, fwd * radius, angleWidth)
      for _, ent in ipairs(enemies) do
        PlayLogarithmusImpaleEffect(ent, casterPos)
        ApplyDamage({
          victim = ent,
          attacker = caster,
          damage = self:GetAbilityDamage(),
          damage_type = self:GetAbilityDamageType(),
          ability = self,
        })
      end

      if #enemies > 0 then
        IncrementLogarithmusStacks(caster)
      else
        -- BreakLogarithmusCombo(caster)
      end
    end)
  end)
end
