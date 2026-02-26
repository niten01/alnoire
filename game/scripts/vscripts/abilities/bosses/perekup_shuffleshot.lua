perekup_shuffleshot = class {}
LinkLuaModifier("modifier_shuffleshot_dot", "abilities/bosses/perekup_shuffleshot.lua", LUA_MODIFIER_MOTION_NONE)

local function RandomDamageType()
    return ({ DAMAGE_TYPE_PHYSICAL, DAMAGE_TYPE_MAGICAL, DAMAGE_TYPE_PURE })[RandomInt(1, 3)]
end

function perekup_shuffleshot:GetRandAbilityValue(name)
    return RandomFloat(self:GetLevelSpecialValueFor(name, 1), self:GetLevelSpecialValueFor(name, 2))
end

function perekup_shuffleshot:Spawn()
    if not IsServer() then return end

    local caster = self:GetCaster()
    self.effects = {
        damage = function(target)
            ApplyDamage({
                victim = target,
                attacker = caster,
                damage = self:GetRandAbilityValue("damage"),
                damage_type = RandomDamageType(),
                ability = self,
            })
        end,
        dot = function(target)
            target:AddNewModifier(caster, self, "modifier_shuffleshot_dot", {
                duration = self:GetRandAbilityValue("dot_duration"),
                damage = self:GetRandAbilityValue("damage"),
            })
        end,
        heal = function(target)
            target:Heal(self:GetRandAbilityValue("heal"), self)
        end,
        stun = function(target)
            target:AddNewModifier(caster, self, "modifier_stunned", {
                duration = self:GetRandAbilityValue("stun_duration")
            })
        end,
        root = function(target)
            target:AddNewModifier(caster, self, "modifier_rooted", {
                duration = self:GetRandAbilityValue("root_duration")
            })
        end
    }

    self.particles = {
        -- "particles/econ/items/mirana/mirana_crescent_arrow/mirana_spell_crescent_arrow.vpcf"
        -- "particles/econ/items/beastmaster/mh_beastmaster/mh_beastmaster_white_stag_wildaxe.vpcf",
        -- "particles/base_attacks/ranged_siege_bad.vpcf",
        -- "particles/econ/items/puck/puck_alliance_set/puck_illusory_orb_aproset_linear_projectile.vpcf",
        -- "particles/perekup_snowball.vpcf",
        -- "particles/econ/events/ti9/ti9_monkey_projectile_object.vpcf",
        -- "particles/dev/library/base_tracking_projectile_model.vpcf",
        -- "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_nasal_goo_proj_ball_r.vpcf",
        "particles/econ/items/dragon_knight/dk_persona/dk_persona_dragon_tail_dragon_form_proj_core.vpcf",
    }

    self.patterns = {
        "arc",
        -- "circle",
        -- "shotgun",
    }

    self.warnings = {
        arc = bind(self.ArcWarning, self),
        circle = bind(self.CircleWarning, self),
        shotgun = bind(self.ShotgunWarning, self),
    }

    self.casts = {
        arc = bind(self.ArcCast, self),
        circle = bind(self.CircleCast, self),
        shotgun = bind(self.ShotgunCast, self),
    }

    self.currentPattern = nil
end

function perekup_shuffleshot:ArcWarning(targetPos)
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local dir = (targetPos - casterPos):Normalized()
    local dist = (targetPos - casterPos):Length()
    local right = dir:Cross(Vector(0, 0, 1)):Normalized()
    local rnd = RandomFloat(-1500, 1500)
    if math.abs(rnd) <= 10 then rnd = 100 end
    local endPos = casterPos + dir * dist * 2 + right * rnd
    self.arcInfo = PointsArc(casterPos, targetPos, endPos)
    ShowGenericArcWarning(self.arcInfo, self:GetSpecialValueFor("projectile_radius"),
        self:GetSpecialValueFor("warning_delay"))
end

function perekup_shuffleshot:CircleWarning(targetPos)
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local dir = (targetPos - casterPos):Normalized()
    local right = dir:Cross(Vector(0, 0, 1)):Normalized()
    local rnd = RandomFloat(-50, 50)
    if math.abs(rnd) <= 10 then rnd = 50 end
    local endPos = casterPos + right * rnd
    self.arcInfo = PointsArc(casterPos, targetPos, endPos)
    ShowGenericArcWarning(self.arcInfo, self:GetSpecialValueFor("projectile_radius"),
        self:GetSpecialValueFor("warning_delay"))
end

function perekup_shuffleshot:ShotgunWarning(targetPos)
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local dir = (targetPos - casterPos):Normalized()
    local distance = self:GetSpecialValueFor("distance")
    local endPos = casterPos + dir * distance
    self.endPoints = PointsFan(casterPos, endPos, RandomInt(1, 7), RandomFloat(10, 60))
    for _, point in ipairs(self.endPoints) do
        ShowGenericLineWarning(casterPos, point, self:GetSpecialValueFor("projectile_radius"),
            self:GetSpecialValueFor("warning_delay"))
    end
end

function perekup_shuffleshot:ArcCast()
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local speed = self:GetSpecialValueFor("speed")
    local radius = self:GetSpecialValueFor("projectile_radius")
    assert(self.arcInfo)
    -- local numPoints = (self.arcInfo:Length() / speed) / 0.01
    local numPoints = 50
    self.arcIter = self.arcInfo:Iterate(numPoints)
    self.curPoint = self.arcIter()
    self.pfx = ParticleManager:CreateParticle(
        GetRandomTableElement(self.particles), PATTACH_WORLDORIGIN,
        nil)
    Timers:CreateTimer(0, function()
        if not self.curPoint then
            ParticleManager:DestroyParticle(self.pfx, false)
            ParticleManager:ReleaseParticleIndex(self.pfx)
            return nil
        end

        self.curPoint.z = 200
        ParticleManager:SetParticleControl(self.pfx, 3, self.curPoint)
        self.curPoint = self.arcIter()
        if self.curPoint then
            ParticleManager:SetParticleControl(self.pfx, 1, self.curPoint)
        end
        return 0.01
    end)

    -- DebugPrint(self.arcInfo:Length(), numPoints)
    -- self.projectile = ProjectileManager:CreateLinearProjectile({
    --     Ability = self,
    --     EffectName = GetRandomTableElement(self.particles),
    --     vSpawnOrigin = casterPos,
    --     vVelocity = caster:GetForwardVector() * speed,
    --     fDistance = self.arcInfo:Length(),
    --     fStartRadius = radius,
    --     fEndRadius = radius,
    --     Source = caster,
    --     bHasFrontalCone = false,
    --     iUnitTargetTeam = DOTA_UNIT_TARGET_TEAM_ENEMY,
    --     iUnitTargetType = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    --     bProvidesVision = true,
    --     iVisionRadius = 500,
    --     iVisionTeamNumber = caster:GetTeamNumber()
    -- })
    -- DebugPrint(self.cnt, FrameTime())
    -- self.cnt = 0
end

function perekup_shuffleshot:OnProjectileThink(location)
    self.cnt = self.cnt + 1
    if self.currentPattern == "shotgun" then return end

    if not self.curPoint then
        -- ProjectileManager:DestroyLinearProjectile(self.projectile)
        return
    end

    local speed = self:GetSpecialValueFor("speed")
    local dir = (self.curPoint - location):Normalized()
    ProjectileManager:UpdateLinearProjectileDirection(self.projectile, dir * speed, 5000)
    self.curPoint = self.arcIter()
end

function perekup_shuffleshot:OnProjectileHit(target, location)
    if not target then return end
    GetRandomTableElement(self.effects)(target)
end

function perekup_shuffleshot:ShowWarning(targetPos)
    self.currentPattern = GetRandomTableElement(self.patterns)
    self.warnings[self.currentPattern](targetPos)

    return self:GetSpecialValueFor("warning_delay")
end

function perekup_shuffleshot:OnSpellStart()
    self.casts[self.currentPattern]()
end

------------------------------------------------------------

modifier_shuffleshot_dot = class {}

function modifier_shuffleshot_dot:OnCreated(kv)
    if not IsServer() then return end
    local interval = 0.3
    self.damagePerTick = kv.damage / (self:GetDuration() / interval)
    self.damageType = RandomDamageType()
    self:StartIntervalThink(interval)
end

function modifier_shuffleshot_dot:OnIntervalThink()
    local parent = self:GetParent()
    ApplyDamage({
        victim = parent,
        attacker = self:GetAbility():GetCaster(),
        damage = self.damagePerTick,
        damage_type = RandomDamageType(),
        ability = self,
    })
end
