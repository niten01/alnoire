item_staff_of_madness = class({})
LinkLuaModifier("modifier_staff_of_madness_thinker", "items/item_staff_of_madness", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_staff_of_madness_buff", "items/item_staff_of_madness", LUA_MODIFIER_MOTION_NONE)

function item_staff_of_madness:GetAOERadius()
    return self:GetSpecialValueFor("aoe_radius")
end

function item_staff_of_madness:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local point = self:GetCursorPosition()
    local duration = self:GetSpecialValueFor("duration")

    caster:EmitSound("items.staff_of_madness.cast")

    CreateModifierThinker(
        caster,
        self,
        "modifier_staff_of_madness_thinker",
        { duration = duration },
        point,
        caster:GetTeamNumber(),
        false
    )
end

--------------------------------------------------------------------------------

modifier_staff_of_madness_thinker = class {}

function modifier_staff_of_madness_thinker:OnCreated()
    self.radius = self:GetAbility():GetAOERadius()
    if not IsServer() then return end

    local pfx = ParticleManager:CreateParticle(
    "particles/custom_items/staff_of_madness_aoe.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, self:GetParent():GetAbsOrigin())
    ParticleManager:SetParticleControl(pfx, 1, Vector(self.radius, 1, 1))
    self:AddParticle(pfx, false, false, -1, false, false)
end

function modifier_staff_of_madness_thinker:IsAura() return true end

function modifier_staff_of_madness_thinker:GetModifierAura() return "modifier_staff_of_madness_buff" end

function modifier_staff_of_madness_thinker:GetAuraRadius() return self.radius end

function modifier_staff_of_madness_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_FRIENDLY end

function modifier_staff_of_madness_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end

--------------------------------------------------------------------------------

modifier_staff_of_madness_buff = class({})

function modifier_staff_of_madness_buff:IsHidden() return false end

function modifier_staff_of_madness_buff:IsPurgable() return true end

function modifier_staff_of_madness_buff:IsDebuff() return false end

function modifier_staff_of_madness_buff:OnCreated()
    local ability = self:GetAbility()
    if ability then
        self.armorReduction = ability:GetSpecialValueFor("armor_reduction")
        self.lifestealFrac = ability:GetSpecialValueFor("lifesteal_pct") / 100
    end

    if not IsServer() then return end
    local pfx = ParticleManager:CreateParticle("particles/items2_fx/mask_of_madness.vpcf", PATTACH_ABSORIGIN_FOLLOW,
        self:GetParent())
    self:AddParticle(pfx, false, false, -1, false, false)
end

function modifier_staff_of_madness_buff:CheckState()
    return {
        [MODIFIER_STATE_SILENCED] = true
    }
end

function modifier_staff_of_madness_buff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_EVENT_ON_ATTACK_LANDED,
    }
end

function modifier_staff_of_madness_buff:GetModifierPhysicalArmorBonus()
    return -self.armorReduction
end

function modifier_staff_of_madness_buff:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end

    local heal = params.original_damage * self.lifestealFrac
    self:GetParent():Heal(heal, self:GetAbility())

    local pfx = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:ReleaseParticleIndex(pfx)
end

function modifier_staff_of_madness_buff:GetTexture()
    return "item_staff_of_madness"
end
