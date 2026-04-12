modifier_item_sanya_flask_heal = class({})

function modifier_item_sanya_flask_heal:IsHidden() return false end

function modifier_item_sanya_flask_heal:IsPurgable() return true end

function modifier_item_sanya_flask_heal:IsDebuff() return false end

function modifier_item_sanya_flask_heal:GetTexture()
    return "forest_troll_high_priest_heal_amp_aura"
end

function modifier_item_sanya_flask_heal:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
        MODIFIER_PROPERTY_HEALTH_REGEN_PERCENTAGE,
    }
end

function modifier_item_sanya_flask_heal:GetModifierHealthRegenPercentage()
    return self.hp_regen_percent
end

function modifier_item_sanya_flask_heal:OnCreated()
    if not IsServer() then
        return
    end
    local abil = self:GetAbility()
    self.hp_regen_percent = abil:GetSpecialValueFor('hp_regen_percent')
    local unit = self:GetParent()
    local pfx = ParticleManager:CreateParticle(
        'particles/econ/items/pugna/pugna_ti9_immortal/pugna_ti9_immortal_netherblast_flash_b.vpcf', PATTACH_ABSORIGIN,
        unit)
    ParticleManager:ReleaseParticleIndex(pfx)
end

function modifier_item_sanya_flask_heal:OnTakeDamage(params)
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
