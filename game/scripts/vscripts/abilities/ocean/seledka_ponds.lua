LinkLuaModifier('modifier_seledka_pond_thinker', 'abilities/ocean/seledka_ponds', LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier('modifier_seledka_pond_effect', 'abilities/ocean/seledka_ponds', LUA_MODIFIER_MOTION_NONE)



seledka_ponds = class({})


function seledka_ponds:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local numPonds = self:GetSpecialValueFor('numPonds') or 4
    local pondRadius = self:GetSpecialValueFor('pondRadius') or 400
    local castRange = self:GetCastRange(caster:GetAbsOrigin(), nil)

    self:CreatePond(caster:GetAbsOrigin())
    local spawnedPonds = { caster:GetAbsOrigin() }
    local maxAttempts = 50
    local attempts = 0
    local locationFound = 0
    while locationFound < numPonds - 1 and attempts < maxAttempts do
        attempts = attempts + 1
        local randomOffset = RandomVector(1):Normalized() * RandomFloat(0, castRange)
        local targetPos = caster:GetAbsOrigin() + randomOffset

        local isGoodTerrain = GridNav:IsTraversable(targetPos) and
            not GridNav:IsNearbyTree(targetPos, pondRadius * 0.5, true)

        if isGoodTerrain then
            local isOverlapping = false
            for _, existingPos in ipairs(spawnedPonds) do
                if (targetPos - existingPos):Length2D() < pondRadius * 1.5 then
                    isOverlapping = true
                    break
                end
            end

            local pathBlocked = GridNav:IsBlocked(targetPos) or not GridNav:CanFindPath(caster:GetAbsOrigin(), targetPos)
            if not isOverlapping and not pathBlocked then
                table.insert(spawnedPonds, targetPos)
                locationFound = locationFound + 1
                self:CreatePond(targetPos)
            end
        end
    end
end

function seledka_ponds:CreatePond(position)
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor('pondDuration') or 10.0
    local radius = self:GetSpecialValueFor('pondRadius') or 400

    CreateModifierThinker(
        caster,
        self,
        "modifier_seledka_pond_thinker",
        { duration = duration },
        position,
        caster:GetTeamNumber(),
        false
    )

    local particle = ParticleManager:CreateParticle("particles/seledka_puddle_1.vpcf",
        PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(particle, 0, position)
    ParticleManager:SetParticleControl(particle, 1, Vector(radius, 1, 1))
    ParticleManager:SetParticleControl(particle, 17, Vector(radius, 0, 0))


    Timers:CreateTimer(duration, function()
        ParticleManager:DestroyParticle(particle, false)
        ParticleManager:ReleaseParticleIndex(particle)
    end)
    print("[SLARDAR] Пруд создан в точке: " .. tostring(position))
end

function seledka_ponds:OnAbilityPhaseStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    EmitSoundOn("Hero_Slardar.Amplify_Damage", caster)
    EmitSoundOn("Seledka.Ponds.Phrases", caster)
end

-------------------------
--- Thinker
modifier_seledka_pond_thinker = class({})

function modifier_seledka_pond_thinker:IsAura() return true end

function modifier_seledka_pond_thinker:GetAuraRadius() return self:GetAbility():GetSpecialValueFor("pondRadius") end

function modifier_seledka_pond_thinker:GetModifierAura() return "modifier_seledka_pond_effect" end

function modifier_seledka_pond_thinker:GetAuraSearchTeam() return DOTA_UNIT_TARGET_TEAM_BOTH end

function modifier_seledka_pond_thinker:GetAuraSearchType() return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end

function modifier_seledka_pond_thinker:GetAuraDuration() return 0.1 end

-----------------------
--- Effect modifier
modifier_seledka_pond_effect = class({})

function modifier_seledka_pond_effect:IsDebuff()
    return not self.is_friendly
end

function modifier_seledka_pond_effect:IsHidden() return false end

function modifier_seledka_pond_effect:IsPurgable() return false end

function modifier_seledka_pond_effect:OnRefresh()
    self:OnCreated()
end

function modifier_seledka_pond_effect:OnCreated()
    local parent = self:GetParent()
    local caster = self:GetCaster()
    local abil = self:GetAbility()

    if not abil or abil:IsNull() then return end
    self.is_friendly = (parent:GetTeamNumber() == caster:GetTeamNumber())
    self.hpRegen = abil:GetSpecialValueFor('pondBuffHpRegen') or 35.0
    self.armorReduction = abil:GetSpecialValueFor('pondDebuffArmorReduse') or 10
    self.fixedSpeed = abil:GetSpecialValueFor('pondDebuffFixedSpeed') or 160
    self.attackSpeedBonus = abil:GetSpecialValueFor('pondBuffAttackSpeedAmp') or 40
end

function modifier_seledka_pond_effect:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_HEALTH_REGEN_CONSTANT,
        MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
        MODIFIER_PROPERTY_MOVESPEED_MAX_OVERRIDE,
        MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,

    }
end

function modifier_seledka_pond_effect:CheckState()
    return {
        [MODIFIER_STATE_TETHERED] = true,
    }
end

function modifier_seledka_pond_effect:GetModifierConstantHealthRegen()
    if self.is_friendly and self.hpRegen then
        return self.hpRegen
    end
    return 0
end

function modifier_seledka_pond_effect:GetModifierPhysicalArmorBonus()
    if self.is_friendly == false and self.armorReduction then
        return -self.armorReduction
    end
    return 0
end

function modifier_seledka_pond_effect:GetModifierMoveSpeed_MaxOverride()
    if self.is_friendly == false and self.fixedSpeed then
        return self.fixedSpeed
    end
    return 0
end

function modifier_seledka_pond_effect:GetModifierAttackSpeedBonus_Constant()
    if self.is_friendly and self.attackSpeedBonus then
        return self.attackSpeedBonus
    end
    return 0
end
