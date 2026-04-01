perekup_shuffleshot = class {}
LinkLuaModifier("modifier_shuffleshot_dot", "abilities/bosses/perekup_shuffleshot.lua", LUA_MODIFIER_MOTION_NONE)

local function RandomDamageType()
    return ({ DAMAGE_TYPE_PHYSICAL, DAMAGE_TYPE_MAGICAL, DAMAGE_TYPE_PURE })[RandomInt(1, 3)]
end

function perekup_shuffleshot:GetRandAbilityValue(name)
    return RandomFloat(self:GetLevelSpecialValueFor(name, 0), self:GetLevelSpecialValueFor(name, 1))
end

function perekup_shuffleshot:Spawn()
    if not IsServer() then return end

    local caster = self:GetCaster()
    self.effects = {
        damage = function(target)
            target:EmitSound("ability.perekup.damage")
            local pfx = ParticleManager:CreateParticle(
                "particles/units/heroes/hero_riki/riki_backstab.vpcf",
                PATTACH_ROOTBONE_FOLLOW,
                target
            )
            ParticleManager:ReleaseParticleIndex(pfx)
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
            target:EmitSound("ability.perekup.heal")
            local pfx = ParticleManager:CreateParticle(
                "particles/econ/events/seasonal_reward_line_fall_2025/radiant_fountain_regen_fallrewardline_2025_heal_symbols_start_burst.vpcf",
                PATTACH_ABSORIGIN_FOLLOW,
                target)
            ParticleManager:ReleaseParticleIndex(pfx)
            target:Heal(self:GetRandAbilityValue("heal"), self)
        end,
        stun = function(target)
            target:EmitSound("ability.perekup.stun")
            target:AddNewModifier(caster, self, "modifier_stunned", {
                duration = self:GetRandAbilityValue("stun_duration")
            })
        end,
        root = function(target)
            target:EmitSound("ability.perekup.root")
            local pfx = ParticleManager:CreateParticle(
                "particles/units/heroes/hero_warlock/warlock_fatal_bonds_icon_chains.vpcf",
                PATTACH_OVERHEAD_FOLLOW,
                target)
            local duration = self:GetRandAbilityValue("root_duration")
            Timers:CreateTimer(duration, function()
                ParticleManager:DestroyParticle(pfx, false)
                ParticleManager:ReleaseParticleIndex(pfx)
            end)
            target:AddNewModifier(caster, self, "modifier_rooted", {
                duration = duration
            })
        end
    }

    self.particles = {
        "particles/econ/items/beastmaster/mh_beastmaster/mh_beastmaster_golden_wildaxe.vpcf",
        "particles/perekup_snowball.vpcf",
        "particles/perekup_shit.vpcf",
        "particles/dev/library/base_tracking_projectile_model.vpcf",
        "particles/econ/items/bristleback/ti7_head_nasal_goo/bristleback_ti7_nasal_goo_proj_ball_r.vpcf",
        "particles/econ/items/dragon_knight/dk_persona/dk_persona_dragon_tail_dragon_form_proj_core.vpcf",
        "particles/perekup_hammer_1.vpcf",
        "particles/econ/items/ancient_apparition/aa_2021_immortal/aa_2021_immortal_chilling_projectile_model.vpcf",
        "particles/econ/items/weaver/weaver_golden_immortal_ti7/weaver_golden_swarm_projectile_ti7_main_model.vpcf",
        "particles/events/crownfall/survivors/imperia_portal_projectile_model.vpcf",
        "particles/events/crownfall/fighting_game/fighting_game_tusk_ice_shards_projectile_stout_model.vpcf",
        "particles/units/heroes/hero_dark_willow/dark_willow_bramble_projectile_model.vpcf",
        "particles/units/heroes/hero_ringmaster/ringmaster_strongman_potion_projectile_model.vpcf",
        "particles/units/heroes/hero_ringmaster/ringmaster_weighted_pie_projectile_model_original.vpcf",
        "particles/econ/items/elder_titan/elder_titan_2021/elder_titan_2021_earth_splitter_orb_projectile.vpcf",
        "particles/hw_fx/hw_candy_2022_projectile_k.vpcf",
    }

    self.patterns = {
        "arc",
        "circle",
        "shotgun",
    }

    self.warnings = {
        arc = bind(self.ArcWarning, self),
        circle = bind(self.CircleWarning, self),
        shotgun = bind(self.ShotgunWarning, self),
    }

    self.casts = {
        arc = bind(self.ArcCast, self),
        circle = bind(self.ArcCast, self),
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
    local rnd = RandomFloat(-2500, 2500)
    if math.abs(rnd) <= 10 then rnd = 100 end
    local endPos = casterPos + dir * dist * 2 + right * rnd
    self.arcInfo = PointsArc(casterPos, targetPos, endPos)
    ShowGenericCurveWarning(self.arcInfo, self:GetSpecialValueFor("projectile_radius"),
        self:GetSpecialValueFor("warning_delay") + self:GetCastPoint())
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
    ShowGenericCurveWarning(self.arcInfo, self:GetSpecialValueFor("projectile_radius"),
        self:GetSpecialValueFor("warning_delay") + self:GetCastPoint())
end

function perekup_shuffleshot:ShotgunWarning(targetPos)
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local dir = (targetPos - casterPos):Normalized()
    local distance = self:GetSpecialValueFor("distance")
    local endPos = casterPos + dir * distance
    self.endPoints = PointsFan(casterPos, endPos, RandomInt(1, 7), RandomFloat(5, 60))
    for _, point in ipairs(self.endPoints) do
        ShowGenericLineWarning(casterPos, point, self:GetSpecialValueFor("projectile_radius"),
            self:GetSpecialValueFor("warning_delay") + self:GetCastPoint())
    end
end

function perekup_shuffleshot:DetectHit(point)
    local radius = self:GetSpecialValueFor("projectile_radius")
    local enemies = FindEnemiesForAIInRadius(point, radius)
    for _, ent in ipairs(enemies) do
        self:OnProjectileHit(ent)
        return true
    end
end

function perekup_shuffleshot:ArcCast()
    -- local speed = self:GetSpecialValueFor("speed")
    assert(self.arcInfo)
    -- local numPoints = (self.arcInfo:Length() / speed) / 0.01
    local numPoints = 50
    local arcIter = self.arcInfo:StableIterator(numPoints)
    local curPoint = arcIter()
    local pfx = ParticleManager:CreateParticle(
        GetRandomTableElement(self.particles), PATTACH_WORLDORIGIN,
        nil)
    local destroy = function()
        ParticleManager:DestroyParticle(pfx, false)
        ParticleManager:ReleaseParticleIndex(pfx)
    end
    Timers:CreateTimer(0, function()
        curPoint.z = GetGroundHeight(curPoint, nil) + 200
        ParticleManager:SetParticleControl(pfx, 0, curPoint)
        ParticleManager:SetParticleControl(pfx, 3, curPoint)
        curPoint = arcIter()

        if curPoint then
            ParticleManager:SetParticleControl(pfx, 1, curPoint)
            if self:DetectHit(curPoint) then
                destroy()
                return nil
            end
            return 0.01
        end

        destroy()
        return nil
    end)
end

function perekup_shuffleshot:ShotgunCast()
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    assert(self.endPoints)

    for _, point in ipairs(self.endPoints) do
        local step = 30
        local dir = (point - casterPos)
        local dist = #dir
        dir = dir:Normalized()
        dir.z = 0
        local point = casterPos

        local pfx = ParticleManager:CreateParticle(
            GetRandomTableElement(self.particles), PATTACH_WORLDORIGIN,
            nil)
        local destroy = function()
            ParticleManager:DestroyParticle(pfx, false)
            ParticleManager:ReleaseParticleIndex(pfx)
        end
        Timers:CreateTimer(0, function()
            point.z = GetGroundHeight(point, nil) + 200
            ParticleManager:SetParticleControl(pfx, 0, point)
            ParticleManager:SetParticleControl(pfx, 3, point)
            point = point + dir * step
            dist = dist - step
            ParticleManager:SetParticleControl(pfx, 1, point)

            if self:DetectHit(point) or dist <= 0 then
                destroy()
                return nil
            end

            return 0.01
        end)
        -- ProjectileManager:CreateLinearProjectile({
        --     Ability = self,
        --     EffectName = "particles/gorilla_clone_trail.vpcf",
        --     vSpawnOrigin = self.startPoint,
        --     vVelocity = dir * speed,
        --     fDistance = #(point - casterPos),
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
    end
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

function perekup_shuffleshot:OnProjectileHit(target)
    if not target then return end

    target:EmitSound("ability.perekup.hit")
    GetRandomTableElement(self.effects)(target)
end

function perekup_shuffleshot:ShowWarning(targetPos)
    self.currentPattern = GetRandomTableElement(self.patterns)
    self.warnings[self.currentPattern](targetPos)

    return self:GetSpecialValueFor("warning_delay")
end

function perekup_shuffleshot:OnSpellStart()
    self.casts[self.currentPattern]()
    self:GetCaster():EmitSound("ability.perekup.throw")
end

------------------------------------------------------------

modifier_shuffleshot_dot = class {}

function modifier_shuffleshot_dot:OnCreated(kv)
    if not IsServer() then return end
    local interval = 0.3
    self.damagePerTick = kv.damage / (self:GetDuration() / interval)
    self.damageType = RandomDamageType()
    self.attacker = self:GetAbility():GetCaster()
    self:StartIntervalThink(interval)

    self.pfx = ParticleManager:CreateParticle(
        "particles/econ/items/viper/viper_ti7_immortal/viper_poison_crimson_debuff_ti7.vpcf", PATTACH_ABSORIGIN_FOLLOW,
        self:GetParent())

    self:GetParent():EmitSound("ability.perekup.dot")
end

function modifier_shuffleshot_dot:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
end

function modifier_shuffleshot_dot:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    ApplyDamage({
        victim = parent,
        attacker = self.attacker,
        damage = self.damagePerTick,
        damage_type = RandomDamageType(),
        ability = self,
    })
end
