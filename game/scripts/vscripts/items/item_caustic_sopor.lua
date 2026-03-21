item_caustic_sopor = class {}
LinkLuaModifier("modifier_item_caustic_sopor_owner", "items/item_caustic_sopor", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_caustic_sopor", "items/item_caustic_sopor", LUA_MODIFIER_MOTION_NONE)


function item_caustic_sopor:GetIntrinsicModifierName()
    return "modifier_item_caustic_sopor_owner"
end

---------------------------------------------------

modifier_item_caustic_sopor_owner = class {}

function modifier_item_caustic_sopor_owner:IsHidden() return true end

function modifier_item_caustic_sopor_owner:IsPurgable() return false end

function modifier_item_caustic_sopor_owner:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_item_caustic_sopor_owner:OnAttackLanded(keys)
    if keys.attacker ~= self:GetParent() then return end
    local ability = self:GetAbility()
    keys.target:AddNewModifier(self:GetParent(), ability, "modifier_item_caustic_sopor", {
        duration = ability:GetSpecialValueFor("duration"),
        poisonDPS = ability:GetSpecialValueFor("poison_dps"),
    })
end

-----------------------------------------------------

modifier_item_caustic_sopor = class {}

function modifier_item_caustic_sopor:IsHidden() return false end

function modifier_item_caustic_sopor:IsDebuff() return true end

function modifier_item_caustic_sopor:OnCreated(kv)
    local ability = self:GetAbility()
    if ability then
        self.asReduction = ability:GetSpecialValueFor("attack_speed_reduction")
    end

    if not IsServer() then return end

    local interval = 0.5
    self.poisonDamage = kv.poisonDPS * interval
    self:StartIntervalThink(interval)
    self.pfx = ParticleManager:CreateParticle("particles/items2_fx/orb_of_venom.vpcf", PATTACH_ABSORIGIN_FOLLOW,
        self:GetParent())
end

function modifier_item_caustic_sopor:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
end

function modifier_item_caustic_sopor:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
    }
end

function modifier_item_caustic_sopor:GetModifierAttackSpeedBonus_Constant()
    return -self.asReduction
end

function modifier_item_caustic_sopor:OnIntervalThink()
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

function modifier_item_caustic_sopor:GetTexture()
    return "item_caustic_sopor"
end
