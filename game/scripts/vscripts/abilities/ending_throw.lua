-- Created by Elfansoer
--[[
Ability checklist (erase if done/checked):
- Scepter Upgrade
- Break behavior
- Linken/Reflect behavior
- Spell Immune/Invulnerable/Invisible behavior
- Illusion behavior
- Stolen behavior
]]
--------------------------------------------------------------------------------
ending_throw = class({})
LinkLuaModifier("modifier_generic_arc_lua", "abilities/ending_throw", LUA_MODIFIER_MOTION_BOTH)

--------------------------------------------------------------------------------
-- Init Abilities
function ending_throw:Precache(context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_marci.vsndevts", context)
    PrecacheResource("particle", "particles/units/heroes/hero_marci/marci_dispose_aoe_damage.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_marci/marci_dispose_debuff.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_marci/marci_dispose_land_aoe.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_marci/marci_grapple.vpcf", context)
end

function ending_throw:Spawn()
    if not IsServer() then return end
    self:SetLevel(1)
end

--------------------------------------------------------------------------------
-- Ability Cast Filter
function ending_throw:CastFilterResultTarget(hTarget)
    if self:GetCaster() == hTarget then
        return UF_FAIL_CUSTOM
    end

    local nResult = UnitFilter(
        hTarget,
        DOTA_UNIT_TARGET_TEAM_BOTH,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_CREEP,
        DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES,
        self:GetCaster():GetTeamNumber()
    )
    if nResult ~= UF_SUCCESS then
        return nResult
    end

    return UF_SUCCESS
end

function ending_throw:GetCustomCastErrorTarget(hTarget)
    if self:GetCaster() == hTarget then
        return "#dota_hud_error_cant_cast_on_self"
    end

    return ""
end

--------------------------------------------------------------------------------
-- Ability Start
function ending_throw:OnSpellStart()
    -- unit identifier
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()

    -- cancel if linken
    if target:TriggerSpellAbsorb(self) then return end

    -- load data
    local duration = self:GetSpecialValueFor("air_duration")
    local height = self:GetSpecialValueFor("air_height")
    local distance = self:GetSpecialValueFor("throw_distance_behind")

    local radius = self:GetSpecialValueFor("landing_radius")
    local stun = self:GetSpecialValueFor("stun_duration")
    local damage = self:GetSpecialValueFor("impact_damage")

    -- set target pos
    local targetpos = caster:GetOrigin() - caster:GetForwardVector() * distance
    targetpos = GetSafeBlinkDestination(target:GetAbsOrigin(), targetpos)
    local totaldist = (target:GetOrigin() - targetpos):Length2D()

    -- create arc
    local arc = target:AddNewModifier(
        caster,                     -- player source
        self,                       -- ability source
        "modifier_generic_arc_lua", -- modifier name
        {
            target_x = targetpos.x,
            target_y = targetpos.y,
            duration = duration,
            distance = totaldist,
            height = height,
            fix_end = false,
            fix_duration = false,
            isStun = true,
            isForward = true,
            activity = ACT_DOTA_FLAIL,
        } -- kv
    )
    arc:SetEndCallback(function()
        -- find enemies
        local enemies = FindUnitsInRadius(
            caster:GetTeamNumber(),                         -- int, your team number
            target:GetOrigin(),                             -- point, center point
            nil,                                            -- handle, cacheUnit. (not known)
            radius,                                         -- float, radius. or use FIND_UNITS_EVERYWHERE
            DOTA_UNIT_TARGET_TEAM_ENEMY,                    -- int, team filter
            DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, -- int, type filter
            0,                                              -- int, flag filter
            0,                                              -- int, order filter
            false                                           -- bool, can grow cache
        )

        -- precache damage
        local damageTable = {
            -- victim = target,
            attacker = caster,
            damage = damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self, --Optional.
        }

        for _, enemy in pairs(enemies) do
            -- stun
            enemy:AddNewModifier(
                caster,             -- player source
                self,               -- ability source
                "modifier_stunned_wrap", -- modifier name
                { duration = stun } -- kv
            )

            -- damage
            damageTable.victim = enemy
            ApplyDamage(damageTable)

            -- play effects
            self:PlayEffects2(enemy:GetOrigin())
        end

        -- destroy trees
        GridNav:DestroyTreesAroundPoint(target:GetOrigin(), radius, false)

        -- play effects
        local allied = target:GetTeamNumber() == caster:GetTeamNumber()
        self:PlayEffects1(target:GetOrigin(), radius, allied)
    end)

    -- play effects
    self:PlayEffects3(caster, target, duration)
    self:PlayEffects4(caster)
end

--------------------------------------------------------------------------------
-- Effects
function ending_throw:PlayEffects1(point, radius, allied)
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_marci/marci_dispose_land_aoe.vpcf"
    local sound_cast = "Hero_Marci.Grapple.Impact"
    if allied then
        sound_cast = "Hero_Marci.Grapple.Impact.Ally"
    end

    -- Create Particle
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 0, point)
    ParticleManager:SetParticleControl(effect_cast, 1, Vector(radius, 0, 0))
    ParticleManager:ReleaseParticleIndex(effect_cast)

    -- Create Sound
    EmitSoundOnLocationWithCaster(point, sound_cast, self:GetCaster())
end

function ending_throw:PlayEffects2(point)
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_marci/marci_dispose_aoe_damage.vpcf"
    local sound_cast = "Hero_Marci.Grapple.Stun"

    -- Create Particle
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(effect_cast, 1, point)
    ParticleManager:ReleaseParticleIndex(effect_cast)

    -- Create Sound
    EmitSoundOnLocationWithCaster(point, sound_cast, self:GetCaster())
end

function ending_throw:PlayEffects3(caster, target, duration)
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_marci/marci_dispose_debuff.vpcf"
    local sound_cast = "Hero_Marci.Grapple.Target"

    -- Create Particle
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT_FOLLOW, caster)
    ParticleManager:SetParticleControlEnt(
        effect_cast,
        0,
        target,
        PATTACH_POINT_FOLLOW,
        "attach_hitloc",
        Vector(0, 0, 0), -- unknown
        true             -- unknown, true
    )
    ParticleManager:SetParticleControlEnt(
        effect_cast,
        1,
        target,
        PATTACH_POINT_FOLLOW,
        "attach_hitloc",
        Vector(0, 0, 0), -- unknown
        true             -- unknown, true
    )
    ParticleManager:SetParticleControl(effect_cast, 5, Vector(duration, 0, 0))
    ParticleManager:ReleaseParticleIndex(effect_cast)

    -- Create Sound
    EmitSoundOn(sound_cast, target)
end

function ending_throw:PlayEffects4(caster)
    -- Get Resources
    local particle_cast = "particles/units/heroes/hero_marci/marci_grapple.vpcf"
    local sound_cast = "Hero_Marci.Grapple.Cast"

    -- Create Particle
    local effect_cast = ParticleManager:CreateParticle(particle_cast, PATTACH_POINT_FOLLOW, caster)
    ParticleManager:SetParticleControlEnt(
        effect_cast,
        1,
        caster,
        PATTACH_POINT_FOLLOW,
        "attach_attack1",
        Vector(0, 0, 0), -- unknown
        true             -- unknown, true
    )
    ParticleManager:SetParticleControlEnt(
        effect_cast,
        2,
        caster,
        PATTACH_POINT_FOLLOW,
        "attach_attack2",
        Vector(0, 0, 0), -- unknown
        true             -- unknown, true
    )
    ParticleManager:ReleaseParticleIndex(effect_cast)

    -- Create Sound
    EmitSoundOn(sound_cast, caster)
end

-------------------------------------

-- Created by Elfansoer
--[[
	Generic Jump Arc

	kv data (default):
	-- direction, provide just one (or none for default):
		dir_x/y (forward), for direction
		target_x/y (forward), for target point
	-- horizontal motion, provide 2 of 3, duration-only (for vertical arc), or all 3
		speed (0)
		duration (0)
		distance (0): zero means no horizontal motion
	-- vertical motion.
		height (0): max height. zero means no vertical motion
		start_offset (0), height offset from ground at start of jump
		end_offset (0), height offset from ground at end of jump
	-- arc types
		fix_end (true): if true, landing z-pos is the same as jumping z-pos, not respecting on landing terrain height (Pounce)
		fix_duration (true): if false, arc ends when unit touches ground, not respecting duration (Shield Crash)
		fix_height (true): if false, arc max height depends on jump distance, height provided is max-height (Tree Dance)
	-- other
		isStun (false), parent is stunned
		isRestricted (false), parent is command restricted
		isForward (false), lock parent forward facing
		activity (none), activity when leaping
]]
--------------------------------------------------------------------------------
modifier_generic_arc_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_generic_arc_lua:IsHidden()
    return true
end

function modifier_generic_arc_lua:IsDebuff()
    return false
end

function modifier_generic_arc_lua:IsStunDebuff()
    return false
end

function modifier_generic_arc_lua:IsPurgable()
    return true
end

function modifier_generic_arc_lua:GetAttributes()
    return MODIFIER_ATTRIBUTE_MULTIPLE
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_generic_arc_lua:OnCreated(kv)
    if not IsServer() then return end
    self.interrupted = false
    self:SetJumpParameters(kv)
    self:Jump()
end

function modifier_generic_arc_lua:OnRefresh(kv)
    self:OnCreated(kv)
end

function modifier_generic_arc_lua:OnRemoved()
end

function modifier_generic_arc_lua:OnDestroy()
    if not IsServer() then return end

    -- preserve height
    local pos = self:GetParent():GetOrigin()

    self:GetParent():RemoveHorizontalMotionController(self)
    self:GetParent():RemoveVerticalMotionController(self)

    -- preserve height if has end offset
    if self.end_offset ~= 0 then
        self:GetParent():SetOrigin(pos)
    end

    if self.endCallback then
        self.endCallback(self.interrupted)
    end
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_generic_arc_lua:DeclareFunctions()
    local funcs = {
        MODIFIER_PROPERTY_DISABLE_TURNING,
    }
    if self:GetStackCount() > 0 then
        table.insert(funcs, MODIFIER_PROPERTY_OVERRIDE_ANIMATION)
    end

    return funcs
end

function modifier_generic_arc_lua:GetModifierDisableTurning()
    if not self.isForward then return end
    return 1
end

function modifier_generic_arc_lua:GetOverrideAnimation()
    return self:GetStackCount()
end

--------------------------------------------------------------------------------
-- Status Effects
function modifier_generic_arc_lua:CheckState()
    local state = {
        [MODIFIER_STATE_STUNNED] = self.isStun or false,
        [MODIFIER_STATE_COMMAND_RESTRICTED] = self.isRestricted or false,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }

    return state
end

--------------------------------------------------------------------------------
-- Motion Effects
function modifier_generic_arc_lua:UpdateHorizontalMotion(me, dt)
    if self.fix_duration and self:GetElapsedTime() >= self.duration then return end

    -- set relative position
    local pos = me:GetOrigin() + self.direction * self.speed * dt
    me:SetOrigin(pos)
end

function modifier_generic_arc_lua:UpdateVerticalMotion(me, dt)
    if self.fix_duration and self:GetElapsedTime() >= self.duration then return end

    local pos = me:GetOrigin()
    local time = self:GetElapsedTime()

    -- set relative position
    local height = pos.z
    local speed = self:GetVerticalSpeed(time)
    pos.z = height + speed * dt
    me:SetOrigin(pos)

    if not self.fix_duration then
        local ground = GetGroundHeight(pos, me) + self.end_offset
        if pos.z <= ground then
            -- below ground, set height as ground then destroy
            pos.z = ground
            me:SetOrigin(pos)
            self:Destroy()
        end
    end
end

function modifier_generic_arc_lua:OnHorizontalMotionInterrupted()
    self.interrupted = true
    self:Destroy()
end

function modifier_generic_arc_lua:OnVerticalMotionInterrupted()
    self.interrupted = true
    self:Destroy()
end

--------------------------------------------------------------------------------
-- Motion Helper
function modifier_generic_arc_lua:SetJumpParameters(kv)
    self.parent = self:GetParent()

    -- load types
    self.fix_end = true
    self.fix_duration = true
    self.fix_height = true
    if kv.fix_end then
        self.fix_end = kv.fix_end == 1
    end
    if kv.fix_duration then
        self.fix_duration = kv.fix_duration == 1
    end
    if kv.fix_height then
        self.fix_height = kv.fix_height == 1
    end

    -- load other types
    self.isStun = kv.isStun == 1
    self.isRestricted = kv.isRestricted == 1
    self.isForward = kv.isForward == 1
    self.activity = kv.activity or 0
    self:SetStackCount(self.activity)

    -- load direction
    if kv.target_x and kv.target_y then
        local origin = self.parent:GetOrigin()
        local dir = Vector(kv.target_x, kv.target_y, 0) - origin
        dir.z = 0
        dir = dir:Normalized()
        self.direction = dir
    end
    if kv.dir_x and kv.dir_y then
        self.direction = Vector(kv.dir_x, kv.dir_y, 0):Normalized()
    end
    if not self.direction then
        self.direction = self.parent:GetForwardVector()
    end

    -- load horizontal data
    self.duration = kv.duration
    self.distance = kv.distance
    self.speed = kv.speed
    if not self.duration then
        self.duration = self.distance / self.speed
    end
    if not self.distance then
        self.speed = self.speed or 0
        self.distance = self.speed * self.duration
    end
    if not self.speed then
        self.distance = self.distance or 0
        self.speed = self.distance / self.duration
    end

    -- load vertical data
    self.height = kv.height or 0
    self.start_offset = kv.start_offset or 0
    self.end_offset = kv.end_offset or 0

    -- calculate height positions
    local pos_start = self.parent:GetOrigin()
    local pos_end = pos_start + self.direction * self.distance
    local height_start = GetGroundHeight(pos_start, self.parent) + self.start_offset
    local height_end = GetGroundHeight(pos_end, self.parent) + self.end_offset
    local height_max

    -- determine jumping height if not fixed
    if not self.fix_height then
        -- ideal height is proportional to max distance
        self.height = math.min(self.height, self.distance / 4)
    end

    -- determine height max
    if self.fix_end then
        height_end = height_start
        height_max = height_start + self.height
    else
        -- calculate height
        local tempmin, tempmax = height_start, height_end
        if tempmin > tempmax then
            tempmin, tempmax = tempmax, tempmin
        end
        local delta = (tempmax - tempmin) * 2 / 3

        height_max = tempmin + delta + self.height
    end

    -- set duration
    if not self.fix_duration then
        self:SetDuration(-1, false)
    else
        self:SetDuration(self.duration, true)
    end

    -- calculate arc
    self:InitVerticalArc(height_start, height_max, height_end, self.duration)
end

function modifier_generic_arc_lua:Jump()
    -- apply horizontal motion
    if self.distance > 0 then
        if not self:ApplyHorizontalMotionController() then
            self.interrupted = true
            self:Destroy()
        end
    end

    -- apply vertical motion
    if self.height > 0 then
        if not self:ApplyVerticalMotionController() then
            self.interrupted = true
            self:Destroy()
        end
    end
end

function modifier_generic_arc_lua:InitVerticalArc(height_start, height_max, height_end, duration)
    local height_end = height_end - height_start
    local height_max = height_max - height_start

    -- fail-safe1: height_max cannot be smaller than height delta
    if height_max < height_end then
        height_max = height_end + 0.01
    end

    -- fail-safe2: height-max must be positive
    if height_max <= 0 then
        height_max = 0.01
    end

    -- math magic
    local duration_end = (1 + math.sqrt(1 - height_end / height_max)) / 2
    self.const1 = 4 * height_max * duration_end / duration
    self.const2 = 4 * height_max * duration_end * duration_end / (duration * duration)
end

function modifier_generic_arc_lua:GetVerticalPos(time)
    return self.const1 * time - self.const2 * time * time
end

function modifier_generic_arc_lua:GetVerticalSpeed(time)
    return self.const1 - 2 * self.const2 * time
end

--------------------------------------------------------------------------------
-- Helper
function modifier_generic_arc_lua:SetEndCallback(func)
    self.endCallback = func
end
