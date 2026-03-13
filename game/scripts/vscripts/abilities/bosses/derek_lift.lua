derek_lift = class {}
LinkLuaModifier("modifier_derek_lift", "abilities/bosses/derek_lift.lua", LUA_MODIFIER_MOTION_NONE)

function derek_lift:ShowWarning()
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local delay = self:GetSpecialValueFor("warning_delay")
  local radius = self:GetSpecialValueFor("radius")
  ShowGenericCircleWarning(casterPos, radius, delay + self:GetCastPoint())
  return delay
end

function derek_lift:OnSpellStart()
  if not IsServer() then return end
  local caster    = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local radius    = self:GetSpecialValueFor("radius")
  local damage    = self:GetSpecialValueFor("damage")

  local pfx       = ParticleManager:CreateParticle("particles/derek_lift.vpcf", PATTACH_ABSORIGIN, caster)
  ParticleManager:SetParticleControl(pfx, 3, Vector(radius - 80, 0, 0))
  ParticleManager:ReleaseParticleIndex(pfx)

  caster:EmitSound("ability.derek.lift.cast")

  local enemies = FindEnemiesForAIInRadius(casterPos, radius)
  for _, ent in ipairs(enemies) do
    ApplyDamage({
      victim = ent,
      attacker = caster,
      damage = damage,
      damage_type = self:GetAbilityDamageType(),
      ability = self,
    })

    ent:AddNewModifier(caster, self, "modifier_derek_lift", {
      height = self:GetSpecialValueFor("lift_height"),
      duration = self:GetSpecialValueFor("lift_duration"),
    })
  end
end

------------------------------------------------------------

modifier_derek_lift = class {}

function modifier_derek_lift:IsHidden() return false end

function modifier_derek_lift:IsDebuff() return true end

function modifier_derek_lift:IsStunDebuff() return true end

function modifier_derek_lift:IsPurgable() return true end

function modifier_derek_lift:OnCreated(kv)
  if IsServer() then
    self.liftHeight = 200

    self.startTime = GameRules:GetGameTime()
    self.elapsedTime = 0
    self.currentZ = self:GetParent():GetAbsOrigin().z

    self:SetHasCustomTransmitterData(true)

    self:StartIntervalThink(0.01)
    self:OnIntervalThink()

    local parent = self:GetParent()
    parent:StartGesture(ACT_DOTA_DISABLED)
  end
end

function modifier_derek_lift:OnDestroy()
  if not IsServer() then return end
  local parent = self:GetParent()
  parent:FadeGesture(ACT_DOTA_DISABLED)
end

function modifier_derek_lift:AddCustomTransmitterData()
  return {
    currentZ = self.currentZ,
  }
end

function modifier_derek_lift:HandleCustomTransmitterData(data)
  self.currentZ = data.currentZ
end

function modifier_derek_lift:DeclareFunctions()
  return {
    MODIFIER_PROPERTY_VISUAL_Z_DELTA,
  }
end

function modifier_derek_lift:GetVisualZDelta()
  return self.currentZ
end

function modifier_derek_lift:OnIntervalThink()
  if IsServer() then
    self.elapsedTime = GameRules:GetGameTime() - self.startTime
    local x = self.elapsedTime / self:GetDuration()

    self.currentZ = self.liftHeight * (1 - math.pow(2 * x - 1, 8))
    self:SendBuffRefreshToClients()
  end
end

function modifier_derek_lift:CheckState()
  return {
    [MODIFIER_STATE_STUNNED] = true,
    [MODIFIER_STATE_ROOTED] = true,
    [MODIFIER_STATE_DISARMED] = true,
    [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
  }
end

function modifier_derek_lift:GetEffectName()
  return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_derek_lift:GetEffectAttachType()
  return PATTACH_OVERHEAD_FOLLOW
end
