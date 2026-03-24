chaser_passive = class {}
LinkLuaModifier("modifier_chaser_passive", "abilities/bosses/chaser_passive", LUA_MODIFIER_MOTION_NONE)

function chaser_passive:GetIntrinsicModifierName()
  return "modifier_chaser_passive"
end

-----------------------------------------------------------

modifier_chaser_passive = class {}

function modifier_chaser_passive:OnCreated()
  local ability = self:GetAbility()
  if ability then
    self.hpThreshold = ability:GetSpecialValueFor("hp_threshold_pct") / 100
    self.maxASBonus = ability:GetSpecialValueFor("attack_speed_bonus")
    self.maxMSBonus = ability:GetSpecialValueFor("ms_bonus")
  end
  self.asBonus = 0
  self.msBonus = 0
  self:StartIntervalThink(0.5)
end

function modifier_chaser_passive:DeclareFunctions()
  return {
    MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
    MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
  }
end

function modifier_chaser_passive:GetModifierAttackSpeedBonus_Constant()
  return self.asBonus
end

function modifier_chaser_passive:GetModifierMoveSpeedBonus_Constant()
  return self.msBonus
end

function modifier_chaser_passive:OnIntervalThink()
  local sanya = FindSanyaInRadius(self:GetParent():GetAbsOrigin(), 99999)
  if not sanya or sanya:IsNull() or not sanya:IsAlive() then return end
  if not self.hpThreshold then return end

  local frac = sanya:GetHealth() / (sanya:GetMaxHealth() * self.hpThreshold)
  frac = 1 - math.min(1, frac)
  self.asBonus = frac * self.maxASBonus
  self.msBonus = frac * self.maxMSBonus
end
