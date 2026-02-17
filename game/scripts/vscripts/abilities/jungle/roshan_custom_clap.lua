LinkLuaModifier("modifier_roshan_custom_clap", "abilities/jungle/roshan_custom_clap", LUA_MODIFIER_MOTION_NONE)


roshan_custom_clap = class({})

function roshan_custom_clap:Spawn()
    if not IsServer() then return end
    if not self:GetCaster() then return end
    if self:GetCaster():GetUnitName() == "npc_jungle_miniroshan" then
        self:SetLevel(1)
    else self:SetLevel(2)
    end
end

function roshan_custom_clap:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local radius = self:GetSpecialValueFor('radius')
    local damage = self:GetSpecialValueFor('damage')
    local slow_amount = self:GetSpecialValueFor('slow_amount')
    local slow_duration = self:GetSpecialValueFor('slow_duration')
    local point = caster:GetAbsOrigin()
    local enemies = FindUnitsInRadius(
        caster:GetTeamNumber(),
        caster:GetAbsOrigin(),
        nil,
        radius,
        DOTA_UNIT_TARGET_TEAM_ENEMY,
        DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
        DOTA_UNIT_TARGET_FLAG_NONE,
        FIND_ANY_ORDER,
        false
    )

    
    for _, enemy in pairs(enemies) do
        ApplyDamage({
            victim = enemy,
            attacker = caster,
            damage = damage,
            damage_type = DAMAGE_TYPE_MAGICAL,
            ability = self,
        })
        local pfx = ParticleManager:CreateParticle( "particles/neutral_fx/roshan_slam.vpcf", PATTACH_POINT,  caster)
        ParticleManager:SetParticleControl(pfx, 0, caster:GetAbsOrigin())
        ParticleManager:ReleaseParticleIndex(pfx)
        enemy:AddNewModifier(caster, self, "modifier_roshan_custom_clap", {duration = slow_duration})
    end
end

function roshan_custom_clap:GetCooldown()
    return self:GetSpecialValueFor('cooldown')
end

function roshan_custom_clap:GetAOERadius()
    return self:GetSpecialValueFor('radius')
end

function roshan_custom_clap:GetCastAnimation()
    return ACT_DOTA_CAST_ABILITY_3
end

function roshan_custom_clap:GetBehavior()
    return DOTA_ABILITY_BEHAVIOR_NO_TARGET
end

----------------------
modifier_roshan_custom_clap = class({})

function modifier_roshan_custom_clap:IsHidden() return false end
function modifier_roshan_custom_clap:IsPurgable() return false end
function modifier_roshan_custom_clap:IsDebuff() return true end


function modifier_roshan_custom_clap:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT
    }
end

function modifier_roshan_custom_clap:GetModifierMoveSpeedBonus_Constant()
    local abil = self:GetAbility()
    if not abil then return 0 end
    return -abil:GetSpecialValueFor('slow_amount') or 0
end
