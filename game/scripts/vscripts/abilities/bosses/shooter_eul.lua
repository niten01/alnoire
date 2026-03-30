shooter_eul = class {}
LinkLuaModifier("modifier_shooter_eul", "abilities/bosses/shooter_eul", LUA_MODIFIER_MOTION_NONE)

function shooter_eul:OnSpellStart()
    if not IsServer() then return end
    local target = self:GetCursorTarget()
    target:AddNewModifier(self:GetCaster(), self, "modifier_shooter_eul", {
        duration = self:GetSpecialValueFor("duration")
    })
    self:GetCaster():EmitSound("ability.shooter.eul.cast")
end

------------------------------------------------------

modifier_shooter_eul = class {}

function modifier_shooter_eul:IsHidden() return false end

function modifier_shooter_eul:IsDebuff() return true end

function modifier_shooter_eul:IsStunDebuff() return true end

function modifier_shooter_eul:IsPurgable() return true end

function modifier_shooter_eul:OnCreated(kv)
    if IsServer() then
        self.liftHeight = 300

        self.startTime = GameRules:GetGameTime()
        self.elapsedTime = 0
        self.currentZ = self:GetParent():GetAbsOrigin().z

        self:SetHasCustomTransmitterData(true)

        self:StartIntervalThink(0.01)
        self:OnIntervalThink()

        local parent = self:GetParent()
        parent:StartGesture(ACT_DOTA_DISABLED)

        local pfx = ParticleManager:CreateParticle("particles/items_fx/cyclone.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
        self:AddParticle(pfx, false, false, -1, false, false)
    end
end

function modifier_shooter_eul:OnDestroy()
    if not IsServer() then return end
    local parent = self:GetParent()
    parent:FadeGesture(ACT_DOTA_DISABLED)
end

function modifier_shooter_eul:AddCustomTransmitterData()
    return {
        currentZ = self.currentZ,
    }
end

function modifier_shooter_eul:HandleCustomTransmitterData(data)
    self.currentZ = data.currentZ
end

function modifier_shooter_eul:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_VISUAL_Z_DELTA,
    }
end

function modifier_shooter_eul:GetVisualZDelta()
    return self.currentZ
end

function modifier_shooter_eul:OnIntervalThink()
    if IsServer() then
        self.elapsedTime = GameRules:GetGameTime() - self.startTime
        local x = self.elapsedTime / self:GetDuration()

        self.currentZ = self.liftHeight * (1 - math.pow(2 * x - 1, 6) + 0.1 * math.sin(20 * x))
        self:SendBuffRefreshToClients()
    end
end

function modifier_shooter_eul:CheckState()
    return {
        [MODIFIER_STATE_STUNNED] = true,
        [MODIFIER_STATE_ROOTED] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_shooter_eul:GetEffectName()
    return "particles/generic_gameplay/generic_stunned.vpcf"
end

function modifier_shooter_eul:GetEffectAttachType()
    return PATTACH_OVERHEAD_FOLLOW
end
