modifier_gorilla_capture = class {}

function modifier_gorilla_capture:OnCreated(kv)
    local interval = 0.1
    self.radius = kv.radius
    self.ummDuration = kv.ummDuration
    self.damage = kv.damage
    self:StartIntervalThink(interval)
end


function modifier_gorilla_capture:OnIntervalThink(kv)
    
end