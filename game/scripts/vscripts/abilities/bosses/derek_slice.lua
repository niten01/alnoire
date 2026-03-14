derek_slice = class {}

-- function derek_slice:ShowWarning(targetPos)
--   local caster = self:GetCaster()
--   local casterPos = self:GetAbsOrigin()
--   local delay = self:GetSpecialValueFor("warning_delay")
--   ShowGenericLineWarning(casterPos, targetPos, delay + self:GetCastPoint())
-- end

function derek_slice:Spawn()
  if not IsServer() then return end
  self.actParticleName = {
    [ACT_DOTA_ATTACK] = "particles/derek_swipe_right.vpcf",
    [ACT_DOTA_ATTACK2] = "particles/derek_swipe_left.vpcf",
  }
end

function derek_slice:OnSpellStart()
  if not IsServer() then return end
  local radius = self:GetSpecialValueFor("radius")
  local caster = self:GetCaster()
  local casterPos = self:GetAbsOrigin()
  local targetPos = self:GetCursorPosition()
  local v = targetPos - casterPos
  local dist = #v - radius / 2
  local dir = v:Normalized()
  local time = self:GetSpecialValueFor("jump_time")
  caster.derekCasting = true

  local pfx = ParticleManager:CreateParticle("particles/derek_move.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
  caster:AddNewModifier(caster, self, "modifier_move_ease", {
    directionX = dir.x,
    directionY = dir.y,
    duration = time,
    distance = dist,
    pfx = pfx,
  })

  caster:EmitSound("ability.derek.dash")
  caster:EmitSound("derek.vo.grunt")

  local hitDelay = self:GetSpecialValueFor("hit_after_jump_delay")
  local damage = self:GetSpecialValueFor("damage")
  local spread = self:GetSpecialValueFor("spread")
  local animAttackPoint = self:GetSpecialValueFor("anim_attack_point")

  Timers:CreateTimer(hitDelay + time, function()
    local act, particleName = GetRandomTableKV(self.actParticleName)
    caster:StartGesture(act)

    Timers:CreateTimer(animAttackPoint, function()
      local pfx = ParticleManager:CreateParticle(particleName, PATTACH_ABSORIGIN, caster)
      ParticleManager:ReleaseParticleIndex(pfx)
      caster:EmitSound("ability.derek.swing")

      local casterPos = caster:GetAbsOrigin()
      local v = casterPos + caster:GetForwardVector() * radius
      local enemies = FindEnemiesInSegment(DOTA_TEAM_BADGUYS, casterPos, v, spread)
      for _, ent in ipairs(enemies) do
        ApplyDamage({
          victim = ent,
          attacker = caster,
          damage = damage,
          damage_type = self:GetAbilityDamageType(),
          ability = self,
        })

        PlayDerekBloodEffects(ent, -caster:GetForwardVector())
      end

      caster.derekCasting = false
    end)
  end)
end
