item_shivas_seal = class({})
LinkLuaModifier("modifier_shivas_seal_debuff", "items/item_shivas_seal", LUA_MODIFIER_MOTION_NONE)


function item_shivas_seal:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local radius = self:GetCastRange(caster:GetAbsOrigin(), nil)
    local time = self:GetSpecialValueFor("expand_time")
    local speed = radius / time

    caster:EmitSound("items.shivas_seal.cast")

    local pfx = ParticleManager:CreateParticle("particles/items2_fx/shivas_guard_active.vpcf", PATTACH_ABSORIGIN_FOLLOW,
        caster)
    ParticleManager:SetParticleControl(pfx, 1, Vector(speed, 1, speed))
    ParticleManager:SetParticleControlEnt(pfx, 2, caster, PATTACH_ABSORIGIN_FOLLOW, "", Vector(0, 0, 0), false)

    Timers:CreateTimer(time, function()
        ParticleManager:DestroyParticle(pfx, false)
        ParticleManager:ReleaseParticleIndex(pfx)
    end)

    local pulse = caster:AddNewModifier(caster, self, "modifier_generic_ring", {
        end_radius = radius,
        width = 30,
        speed = speed,
        target_team = DOTA_UNIT_TARGET_TEAM_ENEMY,
        target_type = DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,
    })

    pulse:SetCallback(function(enemy)
        ApplyDamage({
            victim = enemy,
            attacker = caster,
            damage = self:GetSpecialValueFor("damage"),
            damage_type = self:GetAbilityDamageType(),
            ability = self,
        })
        enemy:AddNewModifier(caster, self, "modifier_shivas_seal_debuff", {
            duration = self:GetSpecialValueFor("duration")
        })
    end)
end

--------------------------------------------------------------------------------

modifier_shivas_seal_debuff = class({})

function modifier_shivas_seal_debuff:IsHidden() return false end

function modifier_shivas_seal_debuff:IsPurgable() return true end

function modifier_shivas_seal_debuff:IsDebuff() return true end

function modifier_shivas_seal_debuff:OnCreated()
    local ability = self:GetAbility()
    if ability then
        self.msReduction = ability:GetSpecialValueFor("ms_reduction")
    end

    if not IsServer() then return end
    local pfx = ParticleManager:CreateParticle("particles/items2_fx/shivas_guard_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW,
        self:GetParent())
    ParticleManager:SetParticleControl(pfx, 1, self:GetCaster():GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(pfx)
end

function modifier_shivas_seal_debuff:OnDestroy()
    if not IsServer() then return end
end

function modifier_shivas_seal_debuff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
    }
end

function modifier_shivas_seal_debuff:GetModifierMoveSpeedBonus_Constant()
    return -self.msReduction
end

function modifier_shivas_seal_debuff:GetTexture()
    return "item_shivas_seal"
end
