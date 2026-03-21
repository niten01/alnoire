item_blight_vesper = class {}
LinkLuaModifier("modifier_item_blight_vesper_owner", "items/item_blight_vesper", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_blight_vesper", "items/item_blight_vesper", LUA_MODIFIER_MOTION_NONE)


function item_blight_vesper:GetIntrinsicModifierName()
    return "modifier_item_blight_vesper_owner"
end

---------------------------------------------------

modifier_item_blight_vesper_owner = class {}

function modifier_item_blight_vesper_owner:IsHidden() return true end

function modifier_item_blight_vesper_owner:IsPurgable() return false end

function modifier_item_blight_vesper_owner:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_item_blight_vesper_owner:OnAttackLanded(keys)
    if keys.attacker ~= self:GetParent() then return end
    local ability = self:GetAbility()
    keys.target:AddNewModifier(self:GetParent(), ability, "modifier_item_blight_vesper", {
        duration = ability:GetSpecialValueFor("duration"),
        poisonDPS = ability:GetSpecialValueFor("poison_dps"),
    })
end

-----------------------------------------------------

modifier_item_blight_vesper = class {}

function modifier_item_blight_vesper:IsHidden() return false end

function modifier_item_blight_vesper:IsDebuff() return true end

function modifier_item_blight_vesper:OnCreated(kv)
    local ability = self:GetAbility()
    if ability then
        self.asReduction = ability:GetSpecialValueFor("attack_speed_reduction")
        self.magresReduction = ability:GetSpecialValueFor("mag_res_reduction")
    end

    if not IsServer() then return end

    local interval = 0.5
    self.poisonDamage = kv.poisonDPS * interval
    self:StartIntervalThink(interval)
    self.pfx = ParticleManager:CreateParticle("particles/items2_fx/orb_of_venom.vpcf", PATTACH_ABSORIGIN_FOLLOW,
        self:GetParent())
end

function modifier_item_blight_vesper:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
end

function modifier_item_blight_vesper:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
    }
end

function modifier_item_blight_vesper:GetModifierAttackSpeedBonus_Constant()
    return -self.asReduction
end

function modifier_item_blight_vesper:GetModifierMagicalResistanceBonus()
    return -self.magresReduction
end

function modifier_item_blight_vesper:OnIntervalThink()
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

function modifier_item_blight_vesper:GetTexture()
    return "item_blight_vesper"
end
