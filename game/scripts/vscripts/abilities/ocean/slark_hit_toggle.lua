LinkLuaModifier('modifier_slark_hit_toggle_on', 'abilities/ocean/slark_hit_toggle', LUA_MODIFIER_MOTION_NONE)
slark_hit_toggle = class({})

function slark_hit_toggle:OnToggle()
    local caster = self:GetCaster()
    local state = self:GetToggleState()

    if state then
        caster:AddNewModifier(caster, self, "modifier_slark_hit_toggle_on", {})
        EmitSoundOn("Hero_Abaddon.BorrowedTime", caster)
    else
        caster:RemoveModifierByName("modifier_slark_hit_toggle_on")
    end
end

---------------------------
---
modifier_slark_hit_toggle_on = class({})

function modifier_slark_hit_toggle_on:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_EVENT_ON_TAKEDAMAGE,
    }
end

function modifier_slark_hit_toggle_on:GetModifierIncomingDamage_Percentage(params)
    if not IsServer() then return end
    return -100
end

function modifier_slark_hit_toggle_on:GetStatusEffectName()
    return "particles/status_fx/status_effect_abaddon_borrowed_time.vpcf"
end

function modifier_slark_hit_toggle_on:StatusEffectPriority()
    return MODIFIER_PRIORITY_ULTRA
end

function modifier_slark_hit_toggle_on:OnCreated()
    if not IsServer() then return end
    local abil = self:GetAbility()
    local parent = self:GetParent()
    self.healMult = abil:GetSpecialValueFor('healMult') or 1.2
    local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_abaddon/abaddon_borrowed_time.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, parent)
    self:AddParticle(pfx, false, false, -1, false, false)
end

function modifier_slark_hit_toggle_on:OnTakeDamage(params)
    if not IsServer() then return end
    local parent = self:GetParent()
    if params.unit == parent then
        local healAmount = params.original_damage
        local finalHeal = healAmount
        if self.healMult then
            finalHeal = finalHeal * self.healMult
        end
        parent:Heal(finalHeal, self:GetAbility())
        local pfx = ParticleManager:CreateParticle("particles/generic_gameplay/generic_lifesteal.vpcf",
            PATTACH_ABSORIGIN_FOLLOW, parent)
        ParticleManager:ReleaseParticleIndex(pfx)
        SendOverheadEventMessage(
            nil,
            OVERHEAD_ALERT_HEAL,
            parent,
            finalHeal,
            nil
        )
    end
end
