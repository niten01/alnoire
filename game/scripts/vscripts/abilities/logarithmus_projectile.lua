logarithmus_projectile = class {}

function logarithmus_projectile:Spawn()
end

function logarithmus_projectile:GetVectorTargetStartRadius()
    return self:GetSpecialValueFor("projectile_radius")
end

function logarithmus_projectile:GetVectorTargetRange()
    return self:GetSpecialValueFor("vector_range")
end

function logarithmus_projectile:OnVectorCastStart(vStartLocation, vDirection)
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local turnMaxRange = self:GetCastRange(casterPos, nil)
    local speed = self:GetSpecialValueFor("projectile_speed")
    local radius = self:GetSpecialValueFor("projectile_radius")

    local dir = (vStartLocation - casterPos)
    dir.z = 0
    local clampedTurnPos = casterPos + dir:Normalized() * math.min(turnMaxRange, #dir)
    dir = dir:Normalized()

    local safeTurnPos = GetSafeBlinkDestination(casterPos, clampedTurnPos)
    local noTurn =  #(clampedTurnPos -casterPos) < #(safeTurnPos - casterPos)

    if noTurn then
      ProjectileManager:CreateLinearProjectile({
              Ability = self,
              EffectName = "particles/gorilla_clone_trail.vpcf",
              vSpawnOrigin = self.startPoint,
              vVelocity = dir * speed,
              fDistance = #(safeTurnPos - casterPos),
              fStartRadius = radius,
              fEndRadius = radius,
              Source = caster,
              bHasFrontalCone = false,
              iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
              iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
              bProvidesVision = true,
              iVisionRadius = 500,
              iVisionTeamNumber = caster:GetTeamNumber()
          })
    else
      vDirection.z = 0
      local arcInfo = PointsArc(casterPos, safeTurnPos, vDirection * self:GetVectorTargetRange())
      local totalTime = arcInfo:Length() / speed
      local arcIter = arcInfo:UnstableIterator()
      local pfx = ParticleManager:CreateParticle("particles/econ/items/beastmaster/mh_beastmaster/mh_beastmaster_golden_wildaxe.vpcf", PATTACH_WORLDORIGIN, nil)
      Timers:CreateTimer(0, function()
        -- TODO
        return FrameTime()
      end)
    end



    -- local pfx = ParticleManager:CreateParticle("particles/logarithmus_projectile_simplified.vpcf", PATTACH_ABSORIGIN, caster)
    -- ParticleManager:SetParticleControl(pfx, 0, casterPos)
    -- ParticleManager:SetParticleControl(pfx, 1, turnPos)
    -- ParticleManager:ReleaseParticleIndex(pfx)
    --
    -- local hitPos = turnPos + vDirection * self:GetVectorTargetRange()
    -- hitPos.z = casterPos.z
    --
    -- caster:SetAbsOrigin(turnPos)
    -- FindClearSpaceForUnit(caster, turnPos, true)
    -- caster:SetForwardVector(vDirection)
    -- caster:FaceTowards(hitPos)
    --
    -- pfx = ParticleManager:CreateParticle("particles/logarithmus_projectile.vpcf", PATTACH_WORLDORIGIN, nil)
    -- ParticleManager:SetParticleControl(pfx, 0, turnPos)
    -- ParticleManager:SetParticleControl(pfx, 1, hitPos)
    -- ParticleManager:ReleaseParticleIndex(pfx)
    --
    -- PlayLogarithmusBladeEffect(caster, 1.0)
    --
    -- local enemies = FindEnemiesForSanyaInLine(turnPos, hitPos, self:GetSpecialValueFor("stab_width"))
    -- for _, ent in ipairs(enemies) do
    --     PlayLogarithmusImpaleEffect(ent, turnPos)
    --     ApplyDamage({
    --         victim = ent,
    --         attacker = caster,
    --         damage = self:GetAbilityDamage(),
    --         damage_type = self:GetAbilityDamageType(),
    --         ability = self,
    --     })
    -- end
    --
    -- if #enemies > 0 then
    --     self.sequentialUses = self.sequentialUses + 1
    --     if self.sequentialUses < self:GetSpecialValueFor("max_sequential_uses") then
    --         caster:AddNewModifier(caster, self, "modifier_logarithmus_projectile_recastable", {
    --             duration = self:GetSpecialValueFor("recast_decay")
    --         })
    --     else
    --         self.sequentialUses = 0
    --     end
    -- end
end

function logarithmus_projectile:OnProjectileHit(target, location)
  if not IsServer() or not target then return end
  local caster = self:GetCaster()

  FindClearSpaceForUnit(caster, location, true)
  local fwd = (target:GetAbsOrigin() - location):Normalized()
  caster:SetForwardVector(fwd)
  caster:FaceTowards(target)
  ApplyDamage({
      victim = target,
      attacker = caster,
      damage = self:GetAbilityDamage(),
      damage_type = self:GetAbilityDamageType(),
      ability = self,
  })
end

