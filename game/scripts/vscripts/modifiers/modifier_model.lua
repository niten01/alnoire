modifier_model = class({})

function modifier_model:IsHidden() return true end

function modifier_model:IsPurgable() return false end

function modifier_model:DeclareFunctions()
  return {
    MODIFIER_PROPERTY_MODEL_CHANGE,
    MODIFIER_PROPERTY_MODEL_SCALE,
  }
end

function ai:OnIntervalThink()
  local beaconData = unit.packTargetData

  if DefaultCreepLogic(unit) then
    return
  end

  -- деремся сука
end

function modifier_model:GetModifierModelChange()
  local lvl = self:GetParent():GetLevel()
  self:StartIntervalThink(1)

  print("[xxx] lol")
  return "models/sanya/sanya.vmdl"
  --   if lvl >= 20 then
  --     return "models/creeps/roshan/roshan.vmdl"      -- example path
  --   elseif lvl >= 10 then
  --     return "models/heroes/dragon_knight/dragon_knight.vmdl"
  --   else
  --     return nil -- use normal hero model
  --   end
end

function modifier_model:OnIntervalThink()
  local unit = self:GetParent()
  if not unit or unit:IsNull() then return end

  local seq = unit.GetSequence and unit:GetSequence() or "<no GetSequence>"
  local cycle = unit.GetCycle and unit:GetCycle() or -1

  print(string.format("[ANIM] %s (ent=%d) seq=%s cycle=%.2f",
    unit:GetUnitName(), unit:entindex(), tostring(seq), cycle))
end

function modifier_model:GetModifierModelScale()
  local lvl = self:GetParent():GetLevel()
  if lvl >= 20 then return 0.3 end
  return 0
end
