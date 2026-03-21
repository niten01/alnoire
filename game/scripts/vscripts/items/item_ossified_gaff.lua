item_ossified_gaff = class {}
LinkLuaModifier("modifier_item_ossified_gaff_owner", "items/item_ossified_gaff", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_ossified_gaff", "items/item_ossified_gaff", LUA_MODIFIER_MOTION_NONE)


function item_ossified_gaff:GetIntrinsicModifierName()
    return "modifier_item_ossified_gaff_owner"
end

---------------------------------------------------

modifier_item_ossified_gaff_owner = class {}

function modifier_item_ossified_gaff_owner:IsHidden() return true end

function modifier_item_ossified_gaff_owner:IsPurgable() return false end

function modifier_item_ossified_gaff_owner:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_item_ossified_gaff_owner:OnAttackLanded(keys)
    if keys.attacker ~= self:GetParent() then return end
    local ability = self:GetAbility()
    keys.target:AddNewModifier(self:GetParent(), ability, "modifier_item_ossified_gaff", {
        duration = ability:GetSpecialValueFor("duration"),
        poisonDPS = ability:GetSpecialValueFor("poison_dps"),
    })
end

-----------------------------------------------------

modifier_item_ossified_gaff = class {}

function modifier_item_ossified_gaff:IsHidden() return false end

function modifier_item_ossified_gaff:IsDebuff() return true end

function modifier_item_ossified_gaff:OnCreated(kv)
    local ability = self:GetAbility()
    if ability then
        self.msReduction = ability:GetSpecialValueFor("ms_reduction")
    end

    if not IsServer() then return end

    local interval = 0.5
    self.poisonDamage = kv.poisonDPS * interval
    self:StartIntervalThink(interval)
    self.pfx = ParticleManager:CreateParticle("particles/items2_fx/orb_of_venom.vpcf", PATTACH_ABSORIGIN_FOLLOW,
        self:GetParent())
end

function modifier_item_ossified_gaff:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
end

function modifier_item_ossified_gaff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
end

function modifier_item_ossified_gaff:GetModifierMoveSpeedBonus_Constant()
    return -self.msReduction
end

function modifier_item_ossified_gaff:OnIntervalThink()
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

function modifier_item_ossified_gaff:GetTexture()
    return "item_ossified_gaff"
end
