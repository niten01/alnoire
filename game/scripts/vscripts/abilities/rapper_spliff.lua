rapper_spliff = class {}
LinkLuaModifier("modifier_rapper_spliff_shield", "abilities/rapper_spliff.lua", LUA_MODIFIER_MOTION_NONE)

function rapper_spliff:OnSpellStart()
    if not IsServer() then return end

    local caster = self:GetCaster()
    if not caster:HasModifier("modifier_rapper_spliff_shield") then
        caster:AddNewModifier(caster, self, "modifier_rapper_spliff_shield", {})
    end

    self.pfx = ParticleManager:CreateParticle("particles/rapper_spliff_head_smoke.vpcf", PATTACH_CUSTOMORIGIN, caster)
    ParticleManager:SetParticleControlEnt(self.pfx, 0, caster, PATTACH_POINT_FOLLOW, "attach_head", Vector(0, 0, 0), true)

    local maxShield = self:GetSpecialValueFor("max_shield")
    local shield = caster:FindModifierByName("modifier_rapper_spliff_shield")
    if shield and shield.currentShield == maxShield then
        caster:EmitSound("ability.rapper.spliff.cast.max")
    else
        caster:EmitSound("ability.rapper.spliff.cast")
    end
end

function rapper_spliff:OnUpgrade()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local shield = caster:FindModifierByName("modifier_rapper_spliff_shield")
    if shield then
        shield:ForceRefresh()
    end
end

function rapper_spliff:OnChannelThink(interval)
    if not IsServer() then return end

    local caster = self:GetCaster()
    local shield = caster:FindModifierByName("modifier_rapper_spliff_shield")
    if not shield then
        shield = caster:AddNewModifier(caster, self, "modifier_rapper_spliff_shield", {})
    end

    local shieldPerSec = self:GetSpecialValueFor("shield_per_sec")
    shield:AddShield(shieldPerSec * interval)
end

function rapper_spliff:OnChannelFinish(bInterrupted)
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
end

------------------------------------------------------------

modifier_rapper_spliff_shield = class {}

function modifier_rapper_spliff_shield:IsHidden() return false end

function modifier_rapper_spliff_shield:IsDebuff() return false end

function modifier_rapper_spliff_shield:IsPurbable() return true end

function modifier_rapper_spliff_shield:AddShield(amount)
    self.currentShield = self.currentShield + amount
    if self.currentShield > self.maxShield then
        self.currentShield = self.maxShield
        self:GetParent():InterruptChannel()
    end
    self:SendBuffRefreshToClients()
end

function modifier_rapper_spliff_shield:OnCreated()
    if not IsServer() then return end

    self.maxShield = self:GetAbility():GetSpecialValueFor("max_shield")
    self.currentShield = 1

    self:SetHasCustomTransmitterData(true)

    local parent = self:GetParent()
    self.pfx = ParticleManager:CreateParticle("particles/rapper_spliff_shield.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, parent)
end

function modifier_rapper_spliff_shield:OnRefresh()
    if not IsServer() then return end
    self.maxShield = self:GetAbility():GetSpecialValueFor("max_shield")
end

function modifier_rapper_spliff_shield:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)

    local parent = self:GetParent()
    parent:EmitSound("ability.rapper.spliff.break")
end

function modifier_rapper_spliff_shield:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_CONSTANT,
        MODIFIER_EVENT_ON_TAKEDAMAGE
    }
end

function modifier_rapper_spliff_shield:OnTakeDamage(params)
    if not IsServer() then return end
    if params.unit ~= self:GetParent() then return end

    local parent = self:GetParent()
    local activeAbility = parent:GetCurrentActiveAbility()
    if parent:IsChanneling() and activeAbility and activeAbility:GetAbilityName() == "rapper_spliff" then
        parent:InterruptChannel()
    end
end

function modifier_rapper_spliff_shield:GetModifierIncomingDamageConstant(params)
    if not IsServer() then
        if params.report_max then
            return self.maxShield
        else
            return self.currentShield
        end
    end

    if params.damage > self.currentShield then
        self:Destroy()
        return -self.currentShield
    else
        self.currentShield = self.currentShield - params.damage

        self:SendBuffRefreshToClients()

        return -params.damage
    end
end

function modifier_rapper_spliff_shield:AddCustomTransmitterData()
    local data = {
        maxShield = self.maxShield,
        currentShield = self.currentShield
    }

    return data
end

function modifier_rapper_spliff_shield:HandleCustomTransmitterData(data)
    self.maxShield = data.maxShield
    self.currentShield = data.currentShield
end
