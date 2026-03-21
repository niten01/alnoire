item_malignance = class {}
LinkLuaModifier("modifier_malignance_buff", "items/item_malignance", LUA_MODIFIER_MOTION_NONE)

function item_malignance:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    caster:EmitSound("items.malignance.cast")
    caster:AddNewModifier(self:GetCaster(), self, "modifier_malignance_buff", {
        duration = self:GetSpecialValueFor("duration"),
    })
end

------------------------------------------------------------------

modifier_malignance_buff = class {}

function modifier_malignance_buff:IsHidden() return false end

function modifier_malignance_buff:IsPurgable() return true end

function modifier_malignance_buff:OnCreated(kv)
    local ability = self:GetAbility()
    if ability then
        self.critChance = ability:GetSpecialValueFor("chance_pct")
        self.damageMult = ability:GetSpecialValueFor("crit_pct") / 100
    end
end

function modifier_malignance_buff:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
    }
end

function modifier_malignance_buff:OnTakeDamage(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.damage_category ~= DOTA_DAMAGE_CATEGORY_SPELL then return end
    if bit.band(params.damage_flags, DOTA_DAMAGE_FLAG_REFLECTION) ~= 0 then return end

    if not RollPercentage(self.critChance) then return end

    local bonusDamage = params.original_damage * (self.damageMult - 1)
    ApplyDamage({
        victim = params.unit,
        attacker = params.attacker,
        damage = bonusDamage,
        damage_type = params.damage_type,
        damage_flags = DOTA_DAMAGE_FLAG_REFLECTION + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION,
        ability = params.inflictor,
    })

    self:GetParent():EmitSound("items.malignance.crit")

    SendOverheadEventMessage(nil, OVERHEAD_ALERT_BONUS_SPELL_DAMAGE, params.unit,
        params.original_damage * self.damageMult, nil)
end

function modifier_malignance_buff:GetTexture()
    return "item_malignance"
end
