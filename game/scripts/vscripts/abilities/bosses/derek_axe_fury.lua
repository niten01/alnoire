derek_axe_fury = class {}
LinkLuaModifier("modifier_derek_axe_fury", "abilities/bosses/derek_axe_fury", LUA_MODIFIER_MOTION_NONE)

function derek_axe_fury:OnSpellStart()
  if not IsServer() then return end
  local caster = self:GetCaster()
  caster:AddNewModifier(caster, self, "modifier_derek_axe_fury", {
    duration = -1
  })
end

function derek_axe_fury:OnChannelFinish(bInterrupted)
  if not IsServer() then return end
  local caster = self:GetCaster()
  caster:RemoveModifierByName("modifier_derek_axe_fury")
end

function derek_axe_fury:Fire(targetPos)
end

-----------------------------------------------------------

modifier_derek_axe_fury = class {}

function modifier_derek_axe_fury:OnCreated(kv)
  if not IsServer() then return end
  local ability = self:GetAbility()
  self.damage = ability:GetSpecialValueFor("damage")
end
