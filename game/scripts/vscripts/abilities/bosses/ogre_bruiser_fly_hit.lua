ogre_bruiser_fly_hit = class {}
LinkLuaModifier("modifier_ogre_fly", "abilities/bosses/ogre_bruiser_fly_hit.lua", LUA_MODIFIER_MOTION_HORIZONTAL)

function ogre_bruiser_fly_hit:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_POINT
end

function ogre_bruiser_fly_hit:OnAbilityPhaseStart()
    local caster = self:GetCaster()
    assert(caster)
    caster:EmitSound("ability.ogre_bruiser.swing")
    local jumpDelay = 1.41
    local flyTime   = self:GetCastPoint() - jumpDelay
    local targetEnt = FindSanyaInRadius(caster:GetAbsOrigin(), 9999)
    if not targetEnt then
        caster:Stop()
        return
    end
    self.activeTimer = Timers:CreateTimer(jumpDelay, function()
        local target = targetEnt:GetAbsOrigin()
        caster.flyTarget = target
        if not caster:HasModifier("modifier_move") then
            local dir = (target - caster:GetAbsOrigin())
            local speed = #dir / flyTime
            caster:AddNewModifier(nil, nil, "modifier_move", {
                directionX = dir.x,
                directionY = dir.y,
                speed = speed,
                duration = flyTime
            })
        end
    end)
end

function ogre_bruiser_fly_hit:OnAbilityPhaseInterrupted()
    if self.activeTimer then
        Timers:RemoveTimer(self.activeTimer)
        self.activeTimer = nil
    end

    local caster = self:GetCaster()
    if caster and caster:HasModifier("modifier_ogre_fly") then
        caster:RemoveModifierByName("modifier_ogre_fly")
    end
end

function ogre_bruiser_fly_hit:OnSpellStart()
    self.activeTimer = nil
    local caster = self:GetCaster()
    assert(caster)
    local casterPos = caster:GetAbsOrigin()
    local radius = self:GetSpecialValueFor("radius")
    local damage = self:GetSpecialValueFor("damage")

    local attIdx = caster:ScriptLookupAttachment("attach_weapon")
    local pos = caster:GetAttachmentOrigin(attIdx)

    caster:EmitSound("ability.ogre_bruiser.impact")

    local pfx = ParticleManager:CreateParticle("particles/neutral_fx/ogre_bruiser_smash.vpcf", PATTACH_POINT, caster)
    ParticleManager:SetParticleControl(pfx, 0, pos)
    ParticleManager:ReleaseParticleIndex(pfx)

    local enemies = FindEnemiesForAIInRadius(pos, radius)
    for _, ent in ipairs(enemies) do
        ApplyDamage({
            victim = ent,
            attacker = caster,
            damage = damage,
            damage_type = DAMAGE_TYPE_PHYSICAL,
            ability = self,
        })
    end

    ScreenShake(casterPos, 10, 0.3, 0.5, 3000, 0, true)
end

-----------------------------------------------------------


modifier_ogre_fly = class {}

function modifier_ogre_fly:OnCreated()
    if not IsServer() then return end

    local parent = self:GetParent()
    local target = parent.flyTarget
    parent.flyTarget = nil
    assert(target)
    local time = self:GetDuration()
    assert(time)
    local dir = target - parent:GetAbsOrigin()
    local dist = #dir
    local weaponOffset = 200
    self.distance = dist - weaponOffset
    self.speed = self.distance / time
    self.direction = dir:Normalized()
    self.travelled = 0
    self.target = target

    if self:ApplyHorizontalMotionController() then
        self.time = 0
    else
        self:Destroy()
    end
end

function modifier_ogre_fly:UpdateHorizontalMotion(me, dt)
    local step = self.speed * dt
    self.travelled = self.travelled + step
    -- if info.travelled >= info.distance then
    --     step = info.distance - (info.travelled - step)
    -- end

    local new_pos = me:GetAbsOrigin() + self.direction * step
    me:SetAbsOrigin(new_pos)
    me:FaceTowards(self.target)

    if self.travelled >= self.distance then
        me:InterruptMotionControllers(true)
        self:Destroy()
    end
end
