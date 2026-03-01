rapper_blink = class {}
LinkLuaModifier("modifier_rapper_postblink", "abilities/rapper_blink.lua", LUA_MODIFIER_MOTION_NONE)

function rapper_blink:OnSpellStart()
    if not IsServer() then return end
    local caster      = self:GetCaster()
    local casterPos   = caster:GetAbsOrigin()
    local targetPos   = self:GetCursorPosition()

    local maxDistance = self:GetSpecialValueFor("range")
    local destination = GetSafeBlinkDestination(casterPos, targetPos, maxDistance)

    EmitSoundOnLocationWithCaster(casterPos, "ability.rapper.blink.from", caster)
    local pfx = ParticleManager:CreateParticle(
        "particles/econ/events/fall_2022/blink/blink_dagger_fall_2022_start.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, casterPos)
    ParticleManager:ReleaseParticleIndex(pfx)

    EmitSoundOnLocationWithCaster(destination, "ability.rapper.blink.to", caster)
    EmitSoundOnLocationWithCaster(destination, "ability.rapper.blink.sfx", caster)
    pfx = ParticleManager:CreateParticle("particles/econ/events/fall_2022/blink/blink_dagger_end_fall2022.vpcf",
        PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(pfx, 0, destination)
    ParticleManager:ReleaseParticleIndex(pfx)

    ExecuteOrderFromTable({
        UnitIndex = caster:entindex(),
        OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
        Position = destination,
        Queue = false
    })

    FindClearSpaceForUnit(caster, destination, true)
    ProjectileManager:ProjectileDodge(caster)

    caster:AddNewModifier(caster, self, "modifier_rapper_postblink", {
        duration = self:GetSpecialValueFor("buff_duration")
    })
end

function rapper_blink:GetCastRange(vLocation, hTarget)
    if IsClient() then
        return self:GetSpecialValueFor("range")
    end
    return 0
end

--------------------------------------------------

modifier_rapper_postblink = class {}

function modifier_rapper_postblink:IsHidden() return false end

function modifier_rapper_postblink:IsDebuff() return false end

function modifier_rapper_postblink:IsPurgable() return false end

function modifier_rapper_postblink:OnCreated()
    if IsServer() then
        local parent = self:GetParent()
        self.pfx = ParticleManager:CreateParticle("particles/rapper_blink_buff.vpcf",
            PATTACH_ABSORIGIN_FOLLOW, parent)
    end

    self.msReduction = self:GetAbility():GetSpecialValueFor("ms_reduction")
    self.attackRangeBonus = self:GetAbility():GetSpecialValueFor("attack_range_bonus")
end

function modifier_rapper_postblink:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
end

function modifier_rapper_postblink:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
        MODIFIER_PROPERTY_ATTACK_RANGE_BONUS,
    }
end

function modifier_rapper_postblink:GetModifierMoveSpeedBonus_Constant()
    return -self.msReduction
end

function modifier_rapper_postblink:GetModifierAttackRangeBonus()
    return self.attackRangeBonus
end
