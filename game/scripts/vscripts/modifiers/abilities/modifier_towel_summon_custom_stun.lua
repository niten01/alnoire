modifier_towel_summon_custom_stun = class({})

function modifier_towel_summon_custom_stun:IsHidden() return false end
function modifier_towel_summon_custom_stun:IsPurgable() return false end
function modifier_towel_summon_custom_stun:IsDebuff() return true end
function modifier_towel_summon_custom_stun:RemoveOnDeath() return true end

function modifier_towel_summon_custom_stun:CheckState()
    if not IsServer() then return end
    return {
        [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
        [MODIFIER_STATE_DISARMED] = true,

    }
end

function modifier_towel_summon_custom_stun:OnCreated()
    if not IsServer() then return end
    local unit = self:GetParent()
    if not unit then return end
    unit:Stop()
    unit:EmitSound("ability.towel_master.towel_summon.stun")
    local pfx_stun = ParticleManager:CreateParticle("particles/generic_gameplay/generic_stunned.vpcf", PATTACH_OVERHEAD_FOLLOW, unit)
    self:AddParticle(pfx_stun, false, false, -1, false, false)
    unit:StartGesture(ACT_DOTA_DISABLED)
    for i = 0, unit:GetAbilityCount() - 1 do
        local abil = unit:GetAbilityByIndex(i)
        if abil then
            abil:SetActivated(false)
            -- if abil:GetAbilityName() ~= "towel_summon_dash" then
            --     abil:SetActivated(false)
            -- end
        end
    end
end

function modifier_towel_summon_custom_stun:OnDestroy()
    if not IsServer() then return end
    local unit = self:GetParent()
    if not unit then return end
    unit:FadeGesture(ACT_DOTA_DISABLED)
    for i = 0, unit:GetAbilityCount() - 1 do
        local abil = unit:GetAbilityByIndex(i)
        if abil then
            abil:SetActivated(true)
        end
    end
    unit:Stop()
end
