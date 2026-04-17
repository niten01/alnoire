modifier_ski_cold = class({})

function modifier_ski_cold:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
    }
end

function modifier_ski_cold:IsHidden()
    return false
end

function modifier_ski_cold:IsDebuff()
    return true
end

function modifier_ski_cold:OnCreated()
    local parent = self:GetParent()
    self.pfx = {}
    local pfx = ParticleManager:CreateParticle(
        "particles/econ/items/winter_wyvern/winter_wyvern_ti7/wyvern_cold_embrace_ti7buff_flakes.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, parent)
    table.insert(self.pfx, pfx)

    pfx = ParticleManager:CreateParticle(
        "particles/econ/items/ancient_apparition/aa_blast_ti_5/ancient_apparition_ice_blast_ice_b_ti5.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, parent)
    ParticleManager:SetParticleControlEnt(pfx, 3, parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
    table.insert(self.pfx, pfx)

    pfx = ParticleManager:CreateParticle(
        "particles/econ/items/ancient_apparition/aa_blast_ti_5/ancient_apparition_ice_blast_ice_c_ti5.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, parent)
    ParticleManager:SetParticleControlEnt(pfx, 3, parent, PATTACH_POINT_FOLLOW, "attach_hitloc", Vector(0, 0, 0), true)
    table.insert(self.pfx, pfx)

    parent:EmitSound("sfx.ski_cold.apply")
end

function modifier_ski_cold:OnDestroy()
    for _, pfx in ipairs(self.pfx) do
        ParticleManager:DestroyParticle(pfx, false)
        ParticleManager:ReleaseParticleIndex(pfx)
    end
end

function modifier_ski_cold:OnTakeDamage(params)
    if not IsServer() then return end
    local parent = self:GetParent()
    if params.unit ~= parent then return end

    local healthPercentage = parent:GetHealth() / parent:GetMaxHealth()
    if healthPercentage < 0.5 then
        parent:EmitSound("sfx.ski_cold.kill")
        parent:Kill(parent, parent)
        local pfx = ParticleManager:CreateParticle(
            "particles/econ/items/ancient_apparition/aa_blast_ti_5/ancient_apparition_ice_blast_explode_ti5.vpcf",
            PATTACH_ABSORIGIN_FOLLOW, parent)
        Timers:CreateTimer(1, function()
            ParticleManager:ReleaseParticleIndex(pfx)
        end)
    end
end
