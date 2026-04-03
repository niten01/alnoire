LinkLuaModifier('modifier_startfight_gesture', 'modifiers/desert/modifier_desert_dire_animation',
    LUA_MODIFIER_MOTION_NONE)
modifier_desert_dire_animation = class({})

function modifier_desert_dire_animation:IsHidden()
    return true
end

function modifier_desert_dire_animation:IsPurgable()
    return false
end

function modifier_desert_dire_animation:OnCreated()
    if not IsServer() then return end
    self.packEnt = Entities:FindByName(nil, "pack_desert_act4_dire_creeps")
    self.needAnimation = true
    self:StartIntervalThink(BATTLE_THINK_INTERVAL)
end

function modifier_desert_dire_animation:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    if not self.packData then
        self.packData = parent.packTargetData
        return
    end
    if not self.needAnimation then
        self:Destroy()
        return
    end
    local state = self.packData.state
    if state == 'aggro' then
        parent:AddNewModifier(parent, nil, "modifier_startfight_gesture", { duration = 1.6 })
        self.needAnimation = false
    end
end

modifier_startfight_gesture = class({})

function modifier_startfight_gesture:IsHidden()
    return true
end

function modifier_startfight_gesture:IsPurgable()
    return false
end

function modifier_startfight_gesture:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION
    }
end

function modifier_startfight_gesture:CheckState()
    return {
        [MODIFIER_STATE_IGNORING_MOVE_AND_ATTACK_ORDERS] = true,
        [MODIFIER_STATE_IGNORING_MOVE_ORDERS] = true,
        [MODIFIER_STATE_IGNORING_STOP_ORDERS] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_ROOTED] = true,
    }
end

function modifier_startfight_gesture:GetOverrideAnimation()
    return ACT_DOTA_VICTORY
end
