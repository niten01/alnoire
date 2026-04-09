LinkLuaModifier('modifier_nyx_underground', "abilities/desert/nyx_bury", LUA_MODIFIER_MOTION_NONE)

nyx_bury = class({})

function nyx_bury:OnToggle()
    local unit = self:GetCaster()
    local state = self:GetToggleState()
    local undergroundTimeMin = self:GetSpecialValueFor('undergroundTimeMin')
    local vulnurableTimeMin = self:GetSpecialValueFor('vulnurableTimeMin')
    local undergroundTimeMax = self:GetSpecialValueFor('undergroundTimeMax')
    local vulnurableTimeMax = self:GetSpecialValueFor('vulnurableTimeMax')

    if state then
        local undergroundTime = undergroundTimeMin + (math.random() * (undergroundTimeMax - undergroundTimeMin))
        unit:StartGesture(ACT_DOTA_CAST_ABILITY_4)
        EmitSoundOn("Hero_NyxAssassin.Burrow.In", unit)
        local pfx = ParticleManager:CreateParticle('particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow.vpcf',
            PATTACH_ABSORIGIN_FOLLOW, unit)
        ParticleManager:ReleaseParticleIndex(pfx)
        self.mound = SpawnEntityFromTableSynchronous("prop_dynamic", {
            model = "models/heroes/nerubian_assassin/mound.vmdl",
            origin = unit:GetAbsOrigin(),
            angles = Vector(0, RandomFloat(0, 180), 0),
        })
        self:StartCooldown(undergroundTime)
        Timers:CreateTimer(1.4, function()
            if not unit or unit:IsNull() or not unit:IsAlive() then return end
            unit.nyxIsUnderground = true
            unit:AddNoDraw()
            unit:AddNewModifier(unit, self, "modifier_nyx_underground", { duration = undergroundTime })
        end)
    else
        local vulnurableTime = vulnurableTimeMin + (math.random() * (vulnurableTimeMax - vulnurableTimeMin))
        unit:RemoveModifierByName('modifier_nyx_underground')
        unit:StartGesture(ACT_DOTA_CAST_BURROW_END)
        local pfx = ParticleManager:CreateParticle(
            'particles/units/heroes/hero_nyx_assassin/nyx_assassin_burrow_exit.vpcf',
            PATTACH_ABSORIGIN_FOLLOW, unit)
        ParticleManager:ReleaseParticleIndex(pfx)
        unit:RemoveNoDraw()
        if self.mound and not self.mound:IsNull() then
            UTIL_Remove(self.mound)
            self.mound = nil
        end
        self:StartCooldown(vulnurableTime)
        EmitSoundOn("Hero_NyxAssassin.Burrow.Out", unit)
        unit.nyxIsUnderground = false
        Timers:CreateTimer(0.7, function()
            if not unit or unit:IsNull() or not unit:IsAlive() then return end
            unit:AddNewModifier(unit, self, "modifier_stunned_wrap", { duration = vulnurableTime })
        end)
    end
end

----------------------
---
modifier_nyx_underground = class({})

function modifier_nyx_underground:IsHidden()
    return true
end

function modifier_nyx_underground:IsPurgable()
    return false
end

function modifier_nyx_underground:CheckState()
    return {
        [MODIFIER_STATE_NO_HEALTH_BAR] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_ATTACK_IMMUNE] = true,
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end
