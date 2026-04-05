modifier_chaser_stuns_ai = class({})

function modifier_chaser_stuns_ai:IsHidden() return true end

function modifier_chaser_stuns_ai:IsPurgable() return false end

function modifier_chaser_stuns_ai:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
end

function modifier_chaser_stuns_ai:OnTakeDamage(params)
    if not IsServer() then return end
    local parent = self:GetParent()
    if params.unit ~= parent then return end

    if params.unit:GetHealth() <= 1 then
        parent:EmitSound("chaser.disappear")
        parent:EmitSound("chaser.laugh")
        local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_chaos_knight/chaos_knight_phantasm.vpcf",
            PATTACH_ABSORIGIN_FOLLOW, parent)
        Timers:CreateTimer(1, function()
            ParticleManager:DestroyParticle(pfx, false)
            ParticleManager:ReleaseParticleIndex(pfx)
            local pfx = ParticleManager:CreateParticle(
                "particles/units/heroes/hero_chaos_knight/chaos_knight_reality_rift.vpcf", PATTACH_ABSORIGIN, parent)
            ParticleManager:SetParticleControl(pfx, 1, parent:GetAbsOrigin())
            ParticleManager:SetParticleControlTransform(pfx, 2, parent:GetAbsOrigin(), VectorToAngles(Vector(0, -90, 0)))
            ParticleManager:ReleaseParticleIndex(pfx)
            UTIL_Remove(parent)
        end)
    end
end

function modifier_chaser_stuns_ai:OnIntervalThink()
    local unit = self:GetParent()
    if not unit:IsAlive() then return nil end
    local beaconData = unit.packTargetData
    if not beaconData then return end
    local beaconState = beaconData.state
    local target = beaconData.target

    if DefaultAiTick(unit) then
        AdjustTickRate(unit)
        self:StartIntervalThink(beaconData.currentCreepInterval)
        return
    end

    if beaconState == 'aggro' and target and target:IsAlive() then
        if CastAbility(unit, target, "chaser_stun") then return end
    end
end
