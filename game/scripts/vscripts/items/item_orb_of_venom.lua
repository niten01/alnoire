item_orb_of_venom = class {}
LinkLuaModifier("modifier_item_orb_of_venom", "items/item_orb_of_venom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_orb_of_venom_poison", "items/item_orb_of_venom_poison", LUA_MODIFIER_MOTION_NONE)


function item_orb_of_venom:GetIntrinsicModifierName()
  return "modifier_item_orb_of_venom"
end

---------------------------------------------------

modifier_item_orb_of_venom = class {}

function modifier_item_orb_of_venom:DeclareFunctions()
  return {
    MODIFIER_EVENT_ON_ATTACK_LANDED
  }
end

function modifier_item_orb_of_venom:OnAttackLanded(keys)
end

-----------------------------------------------------

modifier_item_orb_of_venom_poison = class {}

function modifier_item_orb_of_venom_poison:IsHidden() return false end
function modifier_item_orb_of_venom_poison:IsDebuff() return true end

function modifier_item_orb_of_venom_poison:OnCreated(kv)
  self.damage = kv.damage
  self:StartIntervalThink(kv.interval)
end

function modifier_item_orb_of_venom_poison:OnIntervalThink()
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
end
