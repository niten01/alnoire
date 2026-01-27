modifier_arc_motion_controller = class({})

function modifier_arc_motion_controller:IsHidden() return true end

function modifier_arc_motion_controller:IsPurgable() return false end

function modifier_arc_motion_controller:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
end

function modifier_arc_motion_controller:OnCreated()
    if not IsServer() then return end

    local parent = self:GetParent()
    if parent.jumpInfo then
        self.info = parent.jumpInfo
        parent.jumpInfo = nil

        -- self.dashStart = ParticleManager:CreateParticle(
        --     "particles/units/heroes/hero_kez/kez_sai_ultimate_crit.vpcf",
        --     PATTACH_ABSORIGIN_FOLLOW,
        --     parent)
        -- ParticleManager:SetParticleControlEnt(self.dashStart, 0, parent, PATTACH_POINT_FOLLOW, "attach_hitloc",
        --     Vector(0, 0, 0), false)
        -- local attachment = parent:ScriptLookupAttachment("attach_hitloc")
        -- local forward = self.info.direction
        -- local origin = parent:GetAttachmentOrigin(attachment) + forward * 50
        -- ParticleManager:SetParticleControlTransform(self.dashStart, 1, origin, VectorToAngles(forward))

        self.dashStart = ParticleManager:CreateParticle(
            "particles/sanya_towel_dash_splash.vpcf",
            PATTACH_ABSORIGIN_FOLLOW,
            parent)
        ParticleManager:SetParticleControlEnt(self.dashStart, 3, parent, PATTACH_POINT_FOLLOW, "attach_hitloc",
            Vector(0, 0, 0), true)

        self.dashTrail = ParticleManager:CreateParticle(
            "particles/sanya_towel_dash_trail.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
        ParticleManager:SetParticleControlEnt(self.dashTrail, 3, parent, PATTACH_ABSORIGIN_FOLLOW, "attach_hitloc",
            Vector(0, 0, 0), true)

        if self:ApplyHorizontalMotionController() then
            self.time = 0
        else
            self:Destroy()
        end
    else
        self:Destroy()
    end
end

function modifier_arc_motion_controller:UpdateHorizontalMotion(me, dt)
    local info = self.info
    if not info then return end

    local step = info.speed * dt
    info.travelled = info.travelled + step
    if info.travelled >= info.distance then
        step = info.distance - (info.travelled - step)
    end

    local new_pos = me:GetAbsOrigin() + info.direction * step
    me:SetAbsOrigin(new_pos)

    if info.travelled >= info.distance then
        me:InterruptMotionControllers(true)
        self:Destroy()
    end
end

function modifier_arc_motion_controller:UpdateVerticalMotion(me, dt)
    local info = self.info
    if not info then return end

    local x = info.travelled
    local d = info.distance
    local height = (4 * info.peak_height / (d * d)) * x * (d - x)
    local ground_z = GetGroundHeight(me:GetAbsOrigin(), me)
    local origin = me:GetAbsOrigin()
    origin.z = ground_z + height
    me:SetAbsOrigin(origin)
end

function modifier_arc_motion_controller:GetOverrideAnimation()
    return ACT_DOTA_CAST_ABILITY_1
end

function modifier_arc_motion_controller:OnDestroy()
    if IsServer() then
        ParticleManager:ReleaseParticleIndex(self.dashStart)
        ParticleManager:DestroyParticle(self.dashTrail, false)
        ParticleManager:ReleaseParticleIndex(self.dashTrail)
        local parent = self:GetParent()
        FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)
    end
end
