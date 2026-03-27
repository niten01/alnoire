goden_tentacles = class {}
LinkLuaModifier("modifier_goden_tentacles", "abilities/bosses/goden_tentacles", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_goden_tentacles_fly", "abilities/bosses/goden_tentacles", LUA_MODIFIER_MOTION_VERTICAL)

function goden_tentacles:OnAbilityPhaseStart()
    if not IsServer() then return end

    local caster = self:GetCaster()
    local pos = caster:GetAbsOrigin()
    pos.z = 300
    local pfx = ParticleManager:CreateParticle(
        "particles/econ/items/naga/naga_ti10_immortal_head/naga_ti10_immortal_song_waves.vpcf",
        PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, pos)
    Timers:CreateTimer(3, function()
        ParticleManager:DestroyParticle(pfx, false)
        ParticleManager:ReleaseParticleIndex(pfx)
    end)

    caster:EmitSound("ability.goden.tentacles.roar_start")
end

function goden_tentacles:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()

    ScreenShake(casterPos, 10, 3, self:GetChannelTime(), 5000, 0, true)
    caster:AddNewModifier(caster, self, "modifier_goden_tentacles", {
        duration = -1,
    })

    caster:EmitSound("ability.goden.tentacles.roar")
end

function goden_tentacles:OnChannelFinish()
    if not IsServer() then return end
    local caster = self:GetCaster()
    caster:RemoveModifierByName("modifier_goden_tentacles")
end

-----------------------------------------------------------

modifier_goden_tentacles = class {}

function modifier_goden_tentacles:IsHidden() return true end

function modifier_goden_tentacles:IsPurgable() return false end

function modifier_goden_tentacles:OnCreated(kv)
    if not IsServer() then return end
    local ability = self:GetAbility()
    self:StartIntervalThink(ability:GetSpecialValueFor("interval"))
end

function modifier_goden_tentacles:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    local parentPos = parent:GetAbsOrigin()
    local ability = self:GetAbility()
    local radius = ability:GetSpecialValueFor("radius")
    local damage = ability:GetSpecialValueFor("damage")
    local stunDuration = ability:GetSpecialValueFor("stun_duration")
    local tentacleRadius = ability:GetSpecialValueFor("tentacle_radius")

    local pos = RandomPointsInCircle(parentPos, radius, 1, 100)[1]
    pos.z = GetGroundHeight(pos, nil)

    local pfx = ParticleManager:CreateParticle(
        "particles/econ/items/kunkka/divine_anchor/hero_kunkka_dafx_skills/kunkka_spell_torrent_bubbles_fxset.vpcf",
        PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, pos)
    ParticleManager:ReleaseParticleIndex(pfx)

    EmitSoundOnLocationWithCasterSafe(pos, "ability.goden.tentacles.pre", parent)

    Timers:CreateTimer(ability:GetSpecialValueFor("tentacle_delay"), function()
        pfx = ParticleManager:CreateParticle(
            "particles/econ/items/kunkka/kunkka_weapon_whaleblade/kunkka_spell_torrent_splash_whaleblade.vpcf",
            PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(pfx, 0, pos)
        ParticleManager:ReleaseParticleIndex(pfx)

        EmitSoundOnLocationWithCasterSafe(pos, "ability.goden.tentacles.geyser", parent)

        local enemies = FindEnemiesForAIInRadius(pos, tentacleRadius)
        for _, ent in ipairs(enemies) do
            ApplyDamage({
                victim = ent,
                attacker = parent,
                damage = damage,
                damage_type = DAMAGE_TYPE_MAGICAL,
                ability = ability
            })
            ent:AddNewModifier(parent, ability, "modifier_goden_tentacles_fly", {
                duration = stunDuration,
                height = ability:GetSpecialValueFor("fly_height")
            })
        end
    end)
end

----------------------------------------------------------

modifier_goden_tentacles_fly = class {}

function modifier_goden_tentacles_fly:OnCreated(kv)
    if not IsServer() then return end
    self.height = kv.height

    local parent = self:GetParent()
    parent:StartGesture(ACT_DOTA_DISABLED)
    if self:ApplyVerticalMotionController() then
        self.time = 0
    else
        self:Destroy()
    end
end

function modifier_goden_tentacles_fly:OnDestroy()
    if not IsServer() then return end
    local parent = self:GetParent()
    parent:FadeGesture(ACT_DOTA_DISABLED)
end

function modifier_goden_tentacles_fly:CheckState()
    return {
        [MODIFIER_STATE_STUNNED] = true,
    }
end

function modifier_goden_tentacles_fly:UpdateVerticalMotion(me, dt)
    local x = self:GetRemainingTime() / self:GetDuration()
    local height = self.height * (-4 * x * x + 4 * x)
    local ground_z = GetGroundHeight(me:GetAbsOrigin(), me)
    local origin = me:GetAbsOrigin()
    origin.z = ground_z + height
    me:SetAbsOrigin(origin)
end
