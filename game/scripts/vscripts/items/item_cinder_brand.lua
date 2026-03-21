item_cinder_brand = class {}
LinkLuaModifier("modifier_cinder_brand_owner", "items/item_cinder_brand", LUA_MODIFIER_MOTION_NONE)

function item_cinder_brand:GetIntrinsicModifierName()
    return "modifier_cinder_brand_owner"
end

----------------------------------------------------------------------

modifier_cinder_brand_owner = class {}

function modifier_cinder_brand_owner:IsHidden() return true end

function modifier_cinder_brand_owner:IsPurgable() return false end

function modifier_cinder_brand_owner:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK,
    }
end

function modifier_cinder_brand_owner:OnCreated()
    local ability = self:GetAbility()
    if ability then
        self.chancePct = ability:GetSpecialValueFor("chance_pct")
        self.radius = ability:GetSpecialValueFor("radius")
        self.damage = ability:GetSpecialValueFor("damage")
    end
end

modifier_cinder_brand_owner.OnRefresh = modifier_cinder_brand_owner.OnCreated

function modifier_cinder_brand_owner:OnAttack(params)
    if not IsServer() then return end

    local parent = self:GetParent()
    local ability = self:GetAbility()
    local target = params.target

    if params.no_attack_cooldown or params.attacker ~= parent or parent:IsRangedAttacker() then return end
    if not RollPercentage(self.chancePct) then return end

    local pfx = ParticleManager:CreateParticle("particles/custom_items/cinder_brand_explosion.vpcf", PATTACH_ABSORIGIN_FOLLOW, target)
    ParticleManager:SetParticleControl(pfx, 1, target:GetAbsOrigin() + parent:GetForwardVector() * 30)
    ParticleManager:SetParticleControlEnt(pfx, 3, target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), false)
    ParticleManager:ReleaseParticleIndex(pfx)

    parent:EmitSound("items.cinder_brand.hit")

    local enemies = FindEnemiesForSanyaInRadius(target:GetAbsOrigin(), self.radius)

    for _, enemy in ipairs(enemies) do
        ApplyDamage({
            victim = enemy,
            attacker = parent,
            damage = self.damage,
            damage_type = ability:GetAbilityDamageType(),
            ability = self,
        })
    end
end
