killer_bind = class {}
LinkLuaModifier("modifier_killer_bind", "abilities/bosses/killer_bind", LUA_MODIFIER_MOTION_NONE)

function killer_bind:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    local maxDistance = self:GetSpecialValueFor("max_distance")

    local pfx = ParticleManager:CreateParticle(
        "particles/econ/items/grimstroke/gs_fall20_immortal/gs_fall20_immortal_soulbind.vpcf", PATTACH_ABSORIGIN_FOLLOW,
        caster)
    ParticleManager:SetParticleControl(pfx, 1, target:GetAbsOrigin())

    target:AddNewModifier(caster, self, "modifier_killer_bind", {
        partnerIdx = caster:entindex(),
        maxDistance = maxDistance,
        duration = -1,
        pfxCP1 = pfx
    })

    Timers:CreateTimer(0.3, function()
        caster:AddNewModifier(caster, self, "modifier_killer_bind", {
            partnerIdx = target:entindex(),
            maxDistance = maxDistance,
            duration = -1,
        })
    end)

    caster:EmitSound("ability.killer.bind.cast")
    caster:EmitSound("ability.killer.bind.target")
    target:EmitSound("ability.killer.bind.partner")
end

------------------------------------------------------------

modifier_killer_bind = class {}

function modifier_killer_bind:IsHidden() return false end

function modifier_killer_bind:IsPurgable() return false end

function modifier_killer_bind:OnCreated(kv)
    if not IsServer() then return end
    local parent = self:GetParent()
    self.partner = EntIndexToHScript(kv.partnerIdx)
    self.maxDistance = kv.maxDistance
    self.pfxCP1 = kv.pfxCP1
    self:StartIntervalThink(0.03)

    self.pfx = ParticleManager:CreateParticle(
        "particles/econ/items/grimstroke/gs_fall20_immortal/gs_fall20_immortal_soul_debuff.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        parent)
    ParticleManager:SetParticleControl(self.pfx, 2, parent:GetAbsOrigin())

    if self.pfxCP1 then
        parent:EmitSound("ability.killer.bind.loop")
    end
end

function modifier_killer_bind:OnRefresh(kv)
    self:OnDestroy()
    self:OnCreated(kv)
end

function modifier_killer_bind:OnDestroy()
    if not IsServer() then return end

    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)

    if self.pfxCP1 then
        ParticleManager:DestroyParticle(self.pfxCP1, false)
        ParticleManager:ReleaseParticleIndex(self.pfxCP1)
    end

    if not self.partner or self.partner:IsNull() then return end
    self.partner:RemoveModifierByName("modifier_killer_bind")
    local parent = self:GetParent()
    parent:StopSound("ability.killer.bind.loop")
end

function modifier_killer_bind:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    local parentPos = parent:GetAbsOrigin()
    local partnerPos = self.partner:GetAbsOrigin()

    local v = parentPos - partnerPos
    local dist = #v
    local dir = v:Normalized()
    if dist > self.maxDistance then
        parent:SetAbsOrigin(partnerPos + dir * self.maxDistance)
    end

    if self.pfxCP1 then
        ParticleManager:SetParticleControl(self.pfxCP1, 1, parentPos)
    end

    ParticleManager:SetParticleControl(self.pfx, 2, parent:GetAbsOrigin())
end
