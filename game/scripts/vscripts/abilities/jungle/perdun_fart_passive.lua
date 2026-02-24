LinkLuaModifier("modifier_perdun_aura", "abilities/jungle/perdun_fart_passive", LUA_MODIFIER_MOTION_NONE)

perdun_fart_passive = class({})

function perdun_fart_passive:GetIntrinsicModifierName()
    return "modifier_perdun_aura"
end

-----------------------

modifier_perdun_aura = class({})

function modifier_perdun_aura:IsHidden()
    return true
end

function modifier_perdun_aura:IsPurgable()
    return false
end

function modifier_perdun_aura:IsDebuff()
    return false
end

function modifier_perdun_aura:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_perdun_aura:OnCreated()
    if not IsServer() then return end
    local parent = self:GetParent()
    local abil = self:GetAbility()
    self.initialDamage = abil:GetSpecialValueFor('initialDamage') or 70
    self.damagePerUnit = abil:GetSpecialValueFor('damagePerUnit') or 15
    self.initialRadius = abil:GetSpecialValueFor('initialRadius') or 500
    self.radiusPerUnit = abil:GetSpecialValueFor('radiusPerUnit') or 100
    self.actualRadius = self.initialRadius
    self.lastRadius = self.actualRadius
    self.actualDamage = self.initialDamage
    self.pfx1 = ParticleManager:CreateParticle("particles/units/heroes/hero_pudge/pudge_rot.vpcf",
        PATTACH_ABSORIGIN_FOLLOW, parent)
    ParticleManager:SetParticleControl(self.pfx1, 1, Vector(self.initialRadius, self.initialRadius, self.initialRadius))
    self:AddParticle(self.pfx1, true, false, -1, false, false)
    self:StartIntervalThink(1.0)
end

function modifier_perdun_aura:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    if not parent.packTargetData then return end
    local beaconData = parent.packTargetData
    self.flower = beaconData.flower
    local abil = self:GetAbility()

    local enemies = FindEnemiesForAIInRadius(parent:GetAbsOrigin(), self.actualRadius)
    for _, enemy in pairs(enemies) do
        if enemy and enemy:IsAlive() then
            local damageTable = {
                victim = enemy,
                attacker = parent,
                damage = self.actualDamage,
                damage_type = DAMAGE_TYPE_MAGICAL,
                ability = abil
            }
            ApplyDamage(damageTable)
        end
    end
end

function modifier_perdun_aura:OnDeath(params)
    if params.unit:GetUnitName() == self.flower then
        self.actualRadius = self.actualRadius - self.radiusPerUnit
        if self.actualRadius <= 0 then self.actualRadius = 100 end
        self.actualDamage = self.actualDamage - self.damagePerUnit
        if self.actualDamage <= 0 then self.actualDamage = 10 end

        if self.pfx1 then
            ParticleManager:SetParticleControl(self.pfx1, 1,
                Vector(self.actualRadius, self.actualRadius, self.actualRadius))
            self.lastRadius = self.actualRadius
            -- print('поменял пердуну радиус')
            -- print(self.actualRadius)
        end
    end
end
