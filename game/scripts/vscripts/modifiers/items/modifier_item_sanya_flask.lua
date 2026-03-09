modifier_item_sanya_flask = class({})

function modifier_item_sanya_flask:IsHidden() return false end

function modifier_item_sanya_flask:IsPurgable() return true end

function modifier_item_sanya_flask:IsDebuff() return false end

function modifier_item_sanya_flask:GetTexture()
    return "sanya_flask_modifier"
end

function modifier_item_sanya_flask:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
        MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
    }
end

function modifier_item_sanya_flask:GetModifierHealthRegenPercentage()
    local abil = self:GetAbility()
    return abil:GetSpecialValueFor('hp_regen_percent') or 10.0
end

function modifier_item_sanya_flask:OnCreated()
    if not IsServer() then
        return
    end
    local unit = self:GetParent()
    local pfx = ParticleManager:CreateParticle(
        'particles/econ/items/pugna/pugna_ti9_immortal/pugna_ti9_immortal_netherblast_flash_b.vpcf', PATTACH_ABSORIGIN,
        unit)
    ParticleManager:ReleaseParticleIndex(pfx)
end

function modifier_item_sanya_flask:OnTakeDamage(params)
    if not IsServer() then return end

    if params.unit == self:GetParent() then
        if params.damage > 0 then
            self:Destroy()
            local pfx = ParticleManager:CreateParticle('particles/items4_fx/spirit_vessel_damage_blast_burst.vpcf',
                PATTACH_ABSORIGIN, params.unit)
            ParticleManager:ReleaseParticleIndex(pfx)
        end
    end
end
