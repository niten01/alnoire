item_orb_of_decay = class {}
LinkLuaModifier("modifier_item_orb_of_decay", "items/item_orb_of_decay", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_orb_of_decay_tgt", "items/item_orb_of_decay", LUA_MODIFIER_MOTION_NONE)


function item_orb_of_decay:GetIntrinsicModifierName()
  return "modifier_item_orb_of_decay"
end

---------------------------------------------------

modifier_item_orb_of_decay = class {}

function modifier_item_orb_of_decay:IsHidden() return true end

function modifier_item_orb_of_decay:IsPurgable() return false end

function modifier_item_orb_of_decay:DeclareFunctions()
  return {
    MODIFIER_EVENT_ON_ATTACK_LANDED
  }
end

function modifier_item_orb_of_decay:OnAttackLanded(keys)
  if keys.attacker ~= self:GetParent() then return end
  local ability = self:GetAbility()
  keys.target:AddNewModifier(self:GetParent(), ability, "modifier_item_orb_of_decay_tgt", {
    duration = ability:GetSpecialValueFor("duration"),
    damage = ability:GetSpecialValueFor("damage"),
    interval = ability:GetSpecialValueFor("interval"),
  })
end

-----------------------------------------------------

modifier_item_orb_of_decay_tgt = class {}

function modifier_item_orb_of_decay_tgt:IsHidden() return false end

function modifier_item_orb_of_decay_tgt:IsDebuff() return true end

function modifier_item_orb_of_decay_tgt:OnCreated(kv)
  if not IsServer() then return end
  self.damage = kv.damage
  self:StartIntervalThink(kv.interval)
  self.pfx = ParticleManager:CreateParticle("particles/items2_fx/orb_of_venom.vpcf", PATTACH_ABSORIGIN_FOLLOW,
    self:GetParent())
end

function modifier_item_orb_of_decay_tgt:OnDestroy()
  if not IsServer() then return end
  ParticleManager:DestroyParticle(self.pfx, false)
  ParticleManager:ReleaseParticleIndex(self.pfx)
end

function modifier_item_orb_of_decay_tgt:OnIntervalThink()
  if not IsServer() then return end
  local parent = self:GetParent()
  local ability = self:GetAbility()
  ApplyDamage({
    victim = parent,
    attacker = ability:GetCaster(),
    damage = self.damage,
    damage_type = DAMAGE_TYPE_MAGICAL,
    ability = ability,
  })
  SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_POISON_DAMAGE, parent,
    self.damage, nil)
end

function modifier_item_orb_of_decay_tgt:GetTexture()
  return "item_orb_of_decay"
end
