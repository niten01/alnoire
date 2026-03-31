modifier_lean_power_towel_summon = class {}

function modifier_lean_power_towel_summon:IsHidden() return false end

function modifier_lean_power_towel_summon:IsPurgable() return false end

function modifier_lean_power_towel_summon:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_lean_power_towel_summon:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED,
    }
end

function modifier_lean_power_towel_summon:OnAttackLanded(event)
    if not IsServer() then return end
    if event.attacker ~= self:GetParent() then return end
    local parent = self:GetParent()
    if not RollPercentage(self.chancePct) then return end

    PlayLeanSplash(parent, self.radius)
    local enemies = FindEnemiesForSanyaInRadius(parent:GetAbsOrigin(), self.radius)
    for _, ent in ipairs(enemies) do
        ApplyDamage({
            victim = ent,
            attacker = parent,
            damage = self.damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self,
        })
    end

    local sanya = FindSanyaInRadius(parent:GetAbsOrigin(), 9999)
    if not sanya then return end

    PlayLeanSplash(sanya, self.radius)

    local enemies = FindEnemiesForSanyaInRadius(sanya:GetAbsOrigin(), self.radius)
    for _, ent in ipairs(enemies) do
        ApplyDamage({
            victim = ent,
            attacker = parent,
            damage = self.damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self,
        })
    end
end

function modifier_lean_power_towel_summon:OnCreated(kv)
    if not IsServer() then return end
    self.chancePct = kv.chancePct
    self.damage = kv.damage
    self.radius = kv.radius
end

function modifier_lean_power_towel_summon:OnDestroy()
    if not IsServer() then return end
end

function modifier_lean_power_towel_summon:GetTexture()
    return "item_percocet_xavier"
end
