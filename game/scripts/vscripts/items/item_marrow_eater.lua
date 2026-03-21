item_marrow_eater = class {}
LinkLuaModifier("modifier_item_marrow_eater_owner", "items/item_marrow_eater", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_marrow_eater", "items/item_marrow_eater", LUA_MODIFIER_MOTION_NONE)


function item_marrow_eater:GetIntrinsicModifierName()
    return "modifier_item_marrow_eater_owner"
end

---------------------------------------------------

modifier_item_marrow_eater_owner = class {}

function modifier_item_marrow_eater_owner:IsHidden() return true end

function modifier_item_marrow_eater_owner:IsPurgable() return false end

function modifier_item_marrow_eater_owner:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_item_marrow_eater_owner:OnAttackLanded(keys)
    if keys.attacker ~= self:GetParent() then return end
    local ability = self:GetAbility()
    keys.target:AddNewModifier(self:GetParent(), ability, "modifier_item_marrow_eater", {
        duration = ability:GetSpecialValueFor("duration"),
        poisonDPS = ability:GetSpecialValueFor("poison_dps"),
    })
end

-----------------------------------------------------

modifier_item_marrow_eater = class {}

function modifier_item_marrow_eater:IsHidden() return false end

function modifier_item_marrow_eater:IsDebuff() return true end

function modifier_item_marrow_eater:OnCreated(kv)
    local ability = self:GetAbility()
    if ability then
        self.msReduction = ability:GetSpecialValueFor("ms_reduction")
        self.armorReduction = ability:GetSpecialValueFor("armor_reduction")
    end

    if not IsServer() then return end

    local interval = 0.5
    self.poisonDamage = kv.poisonDPS * interval
    self:StartIntervalThink(interval)
    self.pfx = ParticleManager:CreateParticle("particles/items2_fx/orb_of_venom.vpcf", PATTACH_ABSORIGIN_FOLLOW,
        self:GetParent())
end

function modifier_item_marrow_eater:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
end

function modifier_item_marrow_eater:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
    }
end

function modifier_item_marrow_eater:GetModifierMoveSpeedBonus_Constant()
    return -self.msReduction
end

function modifier_item_marrow_eater:GetModifierPhysicalArmorBonus()
    return -self.armorReduction
end

function modifier_item_marrow_eater:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    local ability = self:GetAbility()
    ApplyDamage({
        victim = parent,
        attacker = ability:GetCaster(),
        damage = self.poisonDamage,
        damage_type = DAMAGE_TYPE_MAGICAL,
        ability = ability,
    })
    SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_POISON_DAMAGE, parent,
        self.poisonDamage, nil)
end

function modifier_item_marrow_eater:GetTexture()
    return "item_marrow_eater"
end
