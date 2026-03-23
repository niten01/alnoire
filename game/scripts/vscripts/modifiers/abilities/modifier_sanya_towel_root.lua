modifier_sanya_towel_root = class({})

function modifier_sanya_towel_root:IsHidden()return false end
function modifier_sanya_towel_root:IsPurgable() return true end

function modifier_sanya_towel_root:OnCreated()
    if not IsServer() then return end
    local pfx = ParticleManager:CreateParticle("particles/sanya_towel_root_wines.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    self:AddParticle(pfx, false, false, -1, false, false)
end

function modifier_sanya_towel_root:CheckState()
    return {
        [MODIFIER_STATE_ROOTED] = true,
    }
end

function modifier_sanya_towel_root:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
    }
end


function modifier_sanya_towel_root:GetModifierIncomingDamage_Percentage(params)
    if not IsServer() then return end
    local attacker = params.attacker
    local owner = self:GetCaster() 

    if attacker and attacker:GetOwner() == owner then
        return self:GetAbility():GetSpecialValueFor("damage_amp_pct")
    end
    
    return 0
end