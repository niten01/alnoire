modifier_custom_sprint = class({})

function modifier_custom_sprint:IsHidden() return false end

function modifier_custom_sprint:IsPurgable() return false end

function modifier_custom_sprint:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_EVENT_ON_TAKEDAMAGE,
        MODIFIER_EVENT_ON_ATTACK_LANDED,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
    }
end

function modifier_custom_sprint:GetActivityTranslationModifiers()
    return 'haste'
end


function modifier_custom_sprint:GetModifierMoveSpeedBonus_Constant()
    return self:GetAbility():GetSpecialValueFor('sprint_speed')
end

function modifier_custom_sprint:OnCreated()
    local parent = self:GetParent()
    self.trailPfx = ParticleManager:CreateParticle("particles/sanya_sprint_trail.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
end

function modifier_custom_sprint:OnDestroy()
    ParticleManager:DestroyParticle(self.trailPfx, false)
    ParticleManager:ReleaseParticleIndex(self.trailPfx)
end

function modifier_custom_sprint:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker == self:GetParent() then
        self:DisableSprint()
    end
end

function modifier_custom_sprint:OnTakeDamage(params)
    if not IsServer() then return end
    if params.unit == self:GetParent() and params.attacker ~= self:GetParent() then
        self:DisableSprint()
    end
end

function modifier_custom_sprint:DisableSprint()
    local ability = self:GetAbility()
    local caster = self:GetCaster()

    if ability and ability:GetToggleState() then
        ability:ToggleAbility()
        ability:StartCooldown(5.0)
        caster:RemoveModifierByName("modifier_custom_sprint")
        local pfx = ParticleManager:CreateParticle("particles/generic_gameplay/generic_manaburn.vpcf",
            PATTACH_ABSORIGIN_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(pfx)
    end
end
