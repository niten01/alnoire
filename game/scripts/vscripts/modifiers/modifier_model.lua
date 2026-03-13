modifier_model = class({})

function modifier_model:IsHidden() return true end

function modifier_model:IsPurgable() return false end

function modifier_model:DeclareFunctions()
  return {
    MODIFIER_PROPERTY_MODEL_CHANGE,
    MODIFIER_PROPERTY_MODEL_SCALE,
  }
end

function modifier_model:OnCreated(kv)
  self.model = kv.model
  self.scale = kv.scale
end

function modifier_model:GetModifierModelChange()
  self:StartIntervalThink(1)

  return self.model

  end

function modifier_model:GetModifierModelScale()
  return self.scale
end
