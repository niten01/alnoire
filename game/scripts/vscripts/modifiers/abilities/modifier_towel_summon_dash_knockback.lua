modifier_towel_summon_dash_knockback = class({})

function modifier_towel_summon_dash_knockback:IsHidden() return true end

function modifier_towel_summon_dash_knockback:IsPurgable() return false end

function modifier_towel_summon_dash_knockback:CheckState()
    if not IsServer() then return end
    return {
        --[MODIFIER_STATE_STUNNED] = false, 
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true, 
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true
    }
end

function modifier_towel_summon_dash_knockback:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
        
end

function modifier_towel_summon_dash_knockback:GetOverrideAnimation()
    return ACT_DOTA_FLAIL
end

function modifier_towel_summon_dash_knockback:OnCreated(params)
    if not IsServer() then return end
    self.direction = Vector(params.x, params.y, 0):Normalized()
    self.speed = params.speed or 300
    
    self.peak_height = 100 
    self.duration = self:GetDuration()
    self.time_elapsed = 0

    if self:ApplyHorizontalMotionController() == false or self:ApplyVerticalMotionController() == false then 
        self:Destroy()
    end
end

function modifier_towel_summon_dash_knockback:UpdateHorizontalMotion(me, dt)
    if not IsServer() then return end
    local next_pos = me:GetAbsOrigin() + self.direction * self.speed * dt
    me:SetAbsOrigin(next_pos)
end

function modifier_towel_summon_dash_knockback:UpdateVerticalMotion(me, dt)
    if not IsServer() then return end
    self.time_elapsed = self.time_elapsed + dt

    local x = self.time_elapsed / self.duration
    local height = 4 * self.peak_height * x * (1 - x)
    local pos = me:GetAbsOrigin()
    pos.z = GetGroundHeight(pos, me) + height
    me:SetAbsOrigin(pos)
end

function modifier_towel_summon_dash_knockback:OnDestroy()
    if not IsServer() then return end
    local final_pos = self:GetParent():GetAbsOrigin()
    final_pos.z = GetGroundHeight(final_pos, self:GetParent())
   
end