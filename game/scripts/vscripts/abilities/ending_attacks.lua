ending_attacks = class {}
LinkLuaModifier("modifier_ending_attacks_buff", "abilities/ending_attacks", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ending_attacks_recovery", "abilities/ending_attacks", LUA_MODIFIER_MOTION_NONE)

local function ChargeAttacks(parent, ability)
    if not IsServer() then return end
    parent:AddNewModifier(parent, ability, "modifier_ending_attacks_buff", {
        duration = -1
    })
end

function ending_attacks:Spawn()
    if not IsServer() then return end
    self:SetLevel(1)
    ChargeAttacks(self:GetCaster(), self)
    self:SetHidden(true)
end

-------------------------------------------------------------------------

modifier_ending_attacks_buff = class {}

function modifier_ending_attacks_buff:IsHidden() return true end

function modifier_ending_attacks_buff:OnCreated()
    self:SetStackCount(self:GetAbility():GetSpecialValueFor("num_attacks"))
end

function modifier_ending_attacks_buff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_IGNORE_ATTACKSPEED_LIMIT,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_PROCATTACK_FEEDBACK,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
    }
end

function modifier_ending_attacks_buff:GetActivityTranslationModifiers()
    return "unleash"
end

function modifier_ending_attacks_buff:GetModifierAttackSpeed_Limit()
    return 1
end

function modifier_ending_attacks_buff:GetModifierAttackSpeedBonus_Constant()
    return 1200
end

function modifier_ending_attacks_buff:GetModifierProcAttack_Feedback(params)
    if params.attacker ~= self:GetParent() then return end
    self:SetStackCount(self:GetStackCount() - 1)

    local parent = self:GetParent()
    local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_marci/marci_unleash_attack.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, parent)
    ParticleManager:SetParticleControlEnt(pfx, 1, params.target, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0),
        true)
    ParticleManager:ReleaseParticleIndex(pfx)

    if self:GetStackCount() <= 0 then
        local radius = self:GetAbility():GetSpecialValueFor("pulse_radius")
        local damage = self:GetAbility():GetSpecialValueFor("pulse_damage")

        local enemies = FindEnemiesForSanyaInRadius(params.target:GetAbsOrigin(), radius)
        for _, ent in ipairs(enemies) do
            ApplyDamage({
                victim = ent,
                attacker = parent,
                damage = damage,
                damage_type = DAMAGE_TYPE_PHYSICAL,
                ability = self,
            })
        end

        local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_marci/marci_unleash_pulse.vpcf",
            PATTACH_ABSORIGIN, params.target)
        ParticleManager:SetParticleControl(pfx, 1, Vector(radius, radius, radius))

        parent:EmitSound("sanya_ending.pulse")

        self:Destroy()
    end
end

function modifier_ending_attacks_buff:OnDestroy()
    if not IsServer() then return end
    self:GetParent():AddNewModifier(self:GetParent(), self:GetAbility(), "modifier_ending_attacks_recovery", {
        duration = self:GetAbility():GetSpecialValueFor("recovery_duration")
    })
end

-----------------------------------------------------

modifier_ending_attacks_recovery = class {}

function modifier_ending_attacks_recovery:IsHidden() return false end

function modifier_ending_attacks_recovery:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_FIXED_ATTACK
    }
end

function modifier_ending_attacks_buff:GetModifierFixedAttackRate()
    return 2.5
end

function modifier_ending_attacks_recovery:OnDestroy()
    ChargeAttacks(self:GetParent(), self:GetAbility())
end
