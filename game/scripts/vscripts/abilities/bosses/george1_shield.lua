george1_shield = class {}
LinkLuaModifier("modifier_george_shield", "abilities/bosses/george1_shield.lua", LUA_MODIFIER_MOTION_NONE)

function george1_shield:GetIntrinsicModifierName()
    return "modifier_george_shield"
end

------------------------------------------------------------

modifier_george_shield = class {}

function modifier_george_shield:IsHidden() return false end
function modifier_george_shield:IsPurgable() return false end

function modifier_george_shield:OnCreated()
    if not IsServer() then return end
    self:Refresh()
    self:SetHasCustomTransmitterData(true)
end

function modifier_george_shield:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
    }
end

function modifier_george_shield:AddCustomTransmitterData()
    local data = {
        charges = self.charges,
    }

    return data
end

function modifier_george_shield:HandleCustomTransmitterData(data)
    self.charges = data.charges
end

function modifier_george_shield:Refresh()
    self.charges = 4

    local parent = self:GetParent()
    self.pfx = ParticleManager:CreateParticle("particles/george_shield.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, parent)
    ParticleManager:SetParticleControl(self.pfx, 2, Vector(1, 0, 0))
    ParticleManager:SetParticleControl(self.pfx, 3, Vector(1, 0, 0))
    ParticleManager:SetParticleControl(self.pfx, 4, Vector(1, 0, 0))
    ParticleManager:SetParticleControl(self.pfx, 5, Vector(1, 0, 0))

    self:SendBuffRefreshToClients()
end

function modifier_george_shield:Break()
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)

    local parent = self:GetParent()
    parent:EmitSound("ability.george1.shield.break")

    parent:Stop()
    local stunDuration = self:GetAbility():GetSpecialValueFor("stun_duration")
    local reloadDuration = self:GetAbility():GetSpecialValueFor("reload_duration")
    parent:AddNewModifier(parent, self:GetAbility(), "modifier_stunned", {
        duration = stunDuration
    })
    Timers:CreateTimer(reloadDuration, function()
        self:Refresh()
    end)
end

function modifier_george_shield:GetModifierIncomingDamageConstant(params)
    local parent = self:GetParent()
    if not IsServer() then
        if params.report_max then
            return 4
        else
            return self.charges
        end
    end

    if self.charges <= 0 then
        return 0
    end

    if IsServer() then
        if self.charges == 1 then
            self:Break()
        else
            ParticleManager:SetParticleControl(self.pfx, self.charges + 1, Vector(0, 0, 0))
        end
    end

    self.charges = self.charges - 1
    self:SendBuffRefreshToClients()

    parent:EmitSound("ability.george1.shield.hit")
    return -params.damage
end
