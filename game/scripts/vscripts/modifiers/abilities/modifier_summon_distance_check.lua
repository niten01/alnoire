modifier_summon_distance_check = class({})

function modifier_summon_distance_check:IsHidden() return false end
function modifier_summon_distance_check:IsPurgable() return false end

function modifier_summon_distance_check:OnCreated()
    if not IsServer() then return end
    self:StartIntervalThink(0.2)
end

function modifier_summon_distance_check:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH, 
    }
end

function modifier_summon_distance_check:OnIntervalThink()
    local unit = self:GetParent()
    local owner = unit:GetOwner()
    local ability = self:GetAbility()
    if not owner or not owner:IsAlive() or not ability then return end

    local radius = ability:GetCastRange(owner:GetAbsOrigin(), nil)
    local distance = (unit:GetAbsOrigin() - owner:GetAbsOrigin()):Length2D()

    if distance > radius then
        if not unit:HasModifier("modifier_stunned") then
            unit:AddNewModifier(owner, ability, "modifier_stunned", {duration = -1})
            self.nfx = ParticleManager:CreateParticle("particles/generic_gameplay/generic_stunned.vpcf", PATTACH_OVERHEAD_FOLLOW, unit)
        end
    else
        if unit:HasModifier("modifier_stunned") then
            unit:RemoveModifierByName("modifier_stunned")
            if self.nfx then
                ParticleManager:DestroyParticle(self.nfx, false)
                self.nfx = nil
            end
        end
    end
end

function modifier_summon_distance_check:OnDeath(params)
    local ability = self:GetAbility()
    local unit = self:GetParent()
    local owner = unit:GetOwner()
    local caster = ability:GetCaster()

    if params.unit == self:GetParent() then
        if ability then
            ability:StartCooldown(ability:GetSpecialValueFor('summon_cooldown'))
            
            if caster then
                caster.summon = nil
            end
        end
    end
    
end