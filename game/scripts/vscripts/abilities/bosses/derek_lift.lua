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
  local caster = self:GetCaster()
  local casterPos = caster:GetAbsOrigin()
  local radius = self:GetSpecialValueFor("radius")
  local damage = self:GetSpecialValueFor("damage")

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
    self.liftHeight = kv.height or 300
    self.liftDuration = kv.liftTime or 0.5

    self.startTime = GameRules:GetGameTime()
    self.elapsedTime = 0

    self:StartIntervalThink(0.03)
  end
end

function modifier_derek_lift:OnIntervalThink()
  if IsServer() then
    self.elapsedTime = GameRules:GetGameTime() - self.startTime

    local parent = self:GetParent()
    local current_height = 0

    if self.elapsedTime < self.liftDuration then
      current_height = (self.elapsedTime / self.liftDuration) * self.liftHeight
    else
      current_height = self.liftHeight
    end

    parent:SetVisualZDelta(current_height)
  end
end

function modifier_derek_lift:OnDestroy()
  if IsServer() then
    self:GetParent():SetVisualZDelta(0)
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
