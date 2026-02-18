ogre_bruiser_pull = class {}
LinkLuaModifier("modifier_ogre_pull", "abilities/bosses/ogre_bruiser_pull.lua", LUA_MODIFIER_MOTION_HORIZONTAL)

function ogre_bruiser_pull:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET + DOTA_ABILITY_BEHAVIOR_AOE
end

function ogre_bruiser_pull:OnSpellStart()
    local caster = self:GetCaster()
    assert(caster)
    local casterPos = caster:GetAbsOrigin()
    local radius = self:GetSpecialValueFor("radius")
    local pullDuration = 0.4 -- animation based

    local attIdx = caster:ScriptLookupAttachment("attach_weapon")
    local pos = caster:GetAttachmentOrigin(attIdx)

    caster:EmitSound("ability.ogre_bruiser.pull")

    local pfx = ParticleManager:CreateParticle("particles/ogre_bruiser_pull.vpcf", PATTACH_POINT, caster)
    ParticleManager:SetParticleControl(pfx, 0, pos)
    ParticleManager:SetParticleControl(pfx, 1, Vector(radius, 0, 0))
    ParticleManager:ReleaseParticleIndex(pfx)

    local enemies = FindEnemiesForAIInRadius(pos, radius)
    for _, ent in ipairs(enemies) do
        ent.ogrePullTarget = pos
        ent:AddNewModifier(caster, self, "modifier_ogre_pull", { duration = pullDuration })
    end

    ScreenShake(casterPos, 10, 0.3, 0.5, 3000, 0, true)
end

-----------------------------------------------------------


modifier_ogre_pull = class {}

function modifier_ogre_pull:OnCreated()
    if not IsServer() then return end
    local parent = self:GetParent()
    local ability = self:GetAbility()
    local speed = ability:GetSpecialValueFor("pull_speed")
    local target = parent.ogrePullTarget
    parent.ogrePullTarget = nil
    assert(target)
    local time = self:GetDuration()
    local dir = target - parent:GetAbsOrigin()
    self.distance = speed * time
    self.speed = speed
    self.direction = dir:Normalized()
    self.travelled = 0

    parent:AddNewModifier(ability:GetCaster(), ability, "modifier_stunned", { duration = self:GetDuration() })
    if self:ApplyHorizontalMotionController() then
        self.time = 0
    else
        self:Destroy()
    end
end

function modifier_ogre_pull:UpdateHorizontalMotion(me, dt)
    local step = self.speed * dt
    self.travelled = self.travelled + step

    local new_pos = me:GetAbsOrigin() + self.direction * step
    me:SetAbsOrigin(new_pos)

    if self.travelled >= self.distance then
        me:InterruptMotionControllers(true)
        self:Destroy()
    end
end
