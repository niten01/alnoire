modifier_gorilla_capture = class {}

function modifier_gorilla_capture:OnCreated(kv)
    local interval = 0.1
    self.radius = kv.radius
    self.ummDuration = kv.ummDuration
    self.damage = kv.damage
    self:StartIntervalThink(interval)
end

function modifier_gorilla_capture:OnIntervalThink(kv)
    local parent = self:GetParent()
    local enemies = FindEnemiesForAIInRadius(parent:GetAbsOrigin(), self.radius)
    local someoneFound = false
    for _, ent in ipairs(enemies) do
        if ent:IsSpiritBearCustom() then
            ent:Kill(self, parent)
        end
        ent:AddNewModifier(parent, self, "modifier_gorilla_umm", { duration = self.ummDuration, damage = self.damage })
        parent:AddNewModifier(parent, self, "modifier_gorilla_umm", { duration = self.ummDuration, damage = 0 })
        someoneFound = true
    end

    if someoneFound then
        self:Destroy()
        parent:RemoveModifierByName("modifier_move")
        parent:RemoveModifierByName("modifier_gorilla_arc")
    end
end
