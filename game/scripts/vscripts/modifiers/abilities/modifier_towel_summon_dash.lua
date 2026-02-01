modifier_towel_summon_dash = class({})
LinkLuaModifier("modifier_towel_summon_dash_knockback", "modifiers/abilities/modifier_towel_summon_dash_knockback", LUA_MODIFIER_MOTION_BOTH)
function modifier_towel_summon_dash:IsHidden() return true end
function modifier_towel_summon_dash:IsPurgable() return false end
function modifier_towel_summon_dash:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_OVERRIDE_ANIMATION,
    }
end

function modifier_towel_summon_dash:CheckState()
    if not IsServer() then return end
    return {
        --[MODIFIER_STATE_STUNNED] = false, 
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true, 
        [MODIFIER_STATE_COMMAND_RESTRICTED] = true,
        [MODIFIER_STATE_ATTACK_IMMUNE] = true,

    }
end

function modifier_towel_summon_dash:GetOverrideAnimation()
    return ACT_DOTA_RUN
end

function modifier_towel_summon_dash:OnCreated()
    if not IsServer() then return end
    self.parent = self:GetParent()
    local playerID = self.parent:GetMainControllingPlayer()
    self.owner = PlayerResource:GetSelectedHeroEntity(playerID)

    local ability = self:GetAbility()
    self.speed = ability:GetSpecialValueFor('speed') or 100
    self.radius = ability:GetSpecialValueFor('radius') or 100
    self.damage = ability:GetSpecialValueFor('damage') or 100
    self.hit_units = {}

    if self:ApplyHorizontalMotionController() == false then
        self:Destroy()
    end
end

function modifier_towel_summon_dash:UpdateHorizontalMotion(me, dt)
    if not IsServer() then return end

    if not self.owner or not self.owner:IsAlive() then 
        self:Destroy()
        return
    end

    local owner_pos = self.owner:GetAbsOrigin()
    local current_pos = self.parent:GetAbsOrigin()

    local direction = (owner_pos - current_pos):Normalized()
    local distance = (owner_pos - current_pos):Length2D()

    if distance < 120 then
        self:Destroy()
        return
    end

    local next_pos = current_pos + direction * self.speed * dt
    self.parent:SetAbsOrigin(next_pos)
    self.parent:FaceTowards(owner_pos)

    local enemies = FindUnitsInRadius(
        self.parent:GetTeamNumber(),
        next_pos,
        nil,
        self.radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false
    )

    for _, enemy in pairs(enemies) do
        if not self.hit_units[enemy:GetEntityIndex()] then
            self.hit_units[enemy:GetEntityIndex()] = true
            
            local enemy_pos = enemy:GetAbsOrigin()
            local parent_pos = self.parent:GetAbsOrigin()
            local dash_dir = self.parent:GetForwardVector()
            local rel_vector = (enemy_pos - parent_pos):Normalized()
            local side_dir = Vector(-dash_dir.y, dash_dir.x, 0) 
            local dot = rel_vector:Dot(side_dir)
            if dot < 0 then
                side_dir = -side_dir
            end
            local final_push_dir = (side_dir * 2.0 + dash_dir * 0.1):Normalized()

            enemy:AddNewModifier(self.parent, self:GetAbility(), "modifier_towel_summon_dash_knockback", {
                duration = 0.3,
                x = final_push_dir.x,
                y = final_push_dir.y,
                speed = 300
            })
            
            ApplyDamage({
                victim = enemy,
                attacker = self.parent,
                damage = self.damage,
                damage_type = DAMAGE_TYPE_MAGICAL,
                ability = self:GetAbility()
            })
        end
    end

end


function modifier_towel_summon_dash:OnDestroy()
    if not IsServer() then return end
    self.parent:FadeGesture(ACT_DOTA_RUN)
    FindClearSpaceForUnit(self.parent, self.parent:GetAbsOrigin(), true)
end
