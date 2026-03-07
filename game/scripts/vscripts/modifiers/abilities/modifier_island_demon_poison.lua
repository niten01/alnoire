modifier_island_demon_poison = class {}

function modifier_island_demon_poison:IsHidden() return false end

function modifier_island_demon_poison:IsPurgable() return true end

function modifier_island_demon_poison:IsDebuff() return true end

function modifier_island_demon_poison:OnCreated()
    local ability = self:GetAbility()
    self.damagePerStack = ability:GetSpecialValueFor("damage_per_stack")
    self:SetStackCount(1)
end

function modifier_island_demon_poison:OnRefresh()
end

function modifier_island_demon_poison:OnDestroy()
    if not IsServer() then return end
    local parent = self:GetParent()

    parent:EmitSound("ability.island_demon.poison.damage")

    ApplyDamage({
        victim = parent,
        attacker = self:GetCaster(),
        damage = self:GetStackCount() * self.damagePerStack,
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = self:GetAbility(),
    })
end
