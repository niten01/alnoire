item_orb_of_poison = class {}
LinkLuaModifier("modifier_item_orb_of_poison", "items/item_orb_of_poison", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_orb_of_poison_poison", "items/item_orb_of_poison", LUA_MODIFIER_MOTION_NONE)


function item_orb_of_poison:GetIntrinsicModifierName()
  return "modifier_item_orb_of_poison"
end

---------------------------------------------------

function modifier_item_orb_of_poison:IsHidden() return true end
function modifier_item_orb_of_poison:IsPurgable() return false end

modifier_item_orb_of_poison = class {}

function modifier_item_orb_of_poison:DeclareFunctions()
  return {
    MODIFIER_EVENT_ON_ATTACK_LANDED
  }
end

function modifier_item_orb_of_poison:OnAttackLanded(keys)
  if keys.attacker ~= self:GetParent() then return end
  local ability = self:GetAbility()
  keys.target:AddNewModifier(self:GetParent(), ability, "modifier_item_orb_of_poison_poison", {
    duration = ability:GetSpecialValueFor("duration"),
    damage = ability:GetSpecialValueFor("damage"),
    interval = ability:GetSpecialValueFor("interval"),
  })
end

-----------------------------------------------------

modifier_item_orb_of_poison_poison = class {}

function modifier_item_orb_of_poison_poison:IsHidden() return false end

function modifier_item_orb_of_poison_poison:IsDebuff() return true end

function modifier_item_orb_of_poison_poison:OnCreated(kv)
  if not IsServer() then return end
  self.damage = kv.damage
  self:StartIntervalThink(kv.interval)
  self.pfx = ParticleManager:CreateParticle("particles/items2_fx/orb_of_venom.vpcf", PATTACH_ABSORIGIN_FOLLOW,
    self:GetParent())
end

function modifier_item_orb_of_poison_poison:OnDestroy()
  if not IsServer() then return end
  ParticleManager:DestroyParticle(self.pfx, false)
  ParticleManager:ReleaseParticleIndex(self.pfx)
end

function modifier_item_orb_of_poison_poison:OnIntervalThink()
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
