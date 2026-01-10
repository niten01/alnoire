modifier_model = class({})

function modifier_model:IsHidden() return true end
function modifier_model:IsPurgable() return false end

function modifier_model:DeclareFunctions()
  return {
    MODIFIER_PROPERTY_MODEL_CHANGE,
    MODIFIER_PROPERTY_MODEL_SCALE,
  }
end

function modifier_model:GetModifierModelChange()
  local lvl = self:GetParent():GetLevel()

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

function modifier_model:GetModifierModelScale()
  local lvl = self:GetParent():GetLevel()
  if lvl >= 20 then return 0.3 end
  return 0
end
