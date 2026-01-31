modifier_ski = class({})

function modifier_ski:IsHidden() return false end

function modifier_ski:OnCreated(kv)
    if not IsServer() then return end

    self.min_speed = 300
    self.max_speed = 1500
    self.acceleration = 1
    self.crash_penalty = 0.3

    self.current_speed = self.min_speed

    self:StartIntervalThink(0.005)

    local parent = self:GetParent()
    self.wearable = SpawnEntityFromTableSynchronous("prop_dynamic", {
        model = "models/sanya/wearables/sanya_ski.vmdl",
    })

    self.wearable:FollowEntity(parent, true)
end

function modifier_ski:OnIntervalThink()
    local parent = self:GetParent()
    if not parent or parent:IsNull() or not parent:IsAlive() then return end

    local forward = parent:GetForwardVector()
    local pos = parent:GetAbsOrigin()
    local next_pos = pos + forward * (self.current_speed * 0.005)

    if GridNav:CanFindPath(pos, next_pos) and not GridNav:IsBlocked(next_pos) then
        parent:SetAbsOrigin(next_pos)

        self.is_crashed = false

        if self.current_speed < self.max_speed then
            self.current_speed = self.current_speed + self.acceleration
        end
    else
        if not self.is_crashed then
            local oldSpeed = self.current_speed
            self.current_speed = self.min_speed * self.crash_penalty
            self.is_crashed = true

            local damageTable = {
                victim = parent,
                attacker = parent,
                damage = oldSpeed * 0.1,
                damage_type = DAMAGE_TYPE_PURE,
                ability = nil,
            }
            ApplyDamage(damageTable)

            ScreenShake(pos, 5, 150, 0.25, 3000, 0, true)
        end
    end
end

function modifier_ski:CheckState()
    return {
        [MODIFIER_STATE_ROOTED] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

function modifier_ski:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
        MODIFIER_PROPERTY_TRANSLATE_ACTIVITY_MODIFIERS,
        MODIFIER_PROPERTY_TURN_RATE_OVERRIDE,
    }
end

function modifier_ski:GetModifierTurnRate_Override()
    local speed_factor = self.current_speed / self.max_speed
    return 0.2 - (speed_factor * 0.1)
end

function modifier_ski:GetOverrideAnimation()
    return ACT_DOTA_IDLE
end

function modifier_ski:GetActivityTranslationModifiers()
    return "windy"
end

function modifier_ski:OnDestroy()
    if not IsServer() then return end
    FindClearSpaceForUnit(self:GetParent(), self:GetParent():GetAbsOrigin(), true)
    self.wearable:RemoveSelf()
end
