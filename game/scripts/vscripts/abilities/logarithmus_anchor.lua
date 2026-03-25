logarithmus_anchor = class {}
LinkLuaModifier("modifier_logarithmus_anchor", "abilities/logarithmus_anchor.lua", LUA_MODIFIER_MOTION_NONE)

function logarithmus_anchor:OnUpgrade()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local returnAbility = caster:FindAbilityByName("logarithmus_anchor_return")
    assert(returnAbility)
    if returnAbility:GetLevel() ~= self:GetLevel() then
        returnAbility:SetLevel(self:GetLevel())

        local alt = caster:FindAbilityByName("logarithmus_alt_anchor")
        assert(alt)
        alt:SetLevel(self:GetLevel())
    end
end

function logarithmus_anchor:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local fwd = caster:GetForwardVector()
    local offset = self:GetSpecialValueFor("forward_offset")
    local point = casterPos + fwd * offset
    local safePoint = GetSafeBlinkDestination(casterPos, point, offset)
    if offset - #(safePoint - casterPos) < 10 then
        safePoint = casterPos - fwd * offset
    end
    safePoint = GetClearSpaceForUnit(caster, point)
    caster:AddNewModifier(caster, self, "modifier_logarithmus_anchor", {
        locationX = safePoint.x,
        locationY = safePoint.y,
        duration = self:GetSpecialValueFor("duration")
    })
end

------------------------------------------------------------------

modifier_logarithmus_anchor = class {}

function modifier_logarithmus_anchor:IsHidden() return false end

function modifier_logarithmus_anchor:IsPurgable() return false end

function modifier_logarithmus_anchor:OnCreated(kv)
    if not IsServer() then return end
    local parent = self:GetParent()

    self.anchorLocation = Vector(kv.locationX, kv.locationY, self:GetParent():GetAbsOrigin().z)
    self.pfx = ParticleManager:CreateParticle("particles/logarithmus_anchor.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.pfx, 0, self.anchorLocation)

    EmitSoundOnLocationWithCasterSafe(self.anchorLocation, "ability.logarithmus.anchor.cast", parent)

    parent:SwapAbilities("logarithmus_anchor", "logarithmus_anchor_return", false, true)
end

function modifier_logarithmus_anchor:OnRefresh(kv)
    if not IsServer() then return end
    self:OnDestroy()
    self:OnCreated(kv)
end

function modifier_logarithmus_anchor:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
    local parent = self:GetParent()
    parent:SwapAbilities("logarithmus_anchor", "logarithmus_anchor_return", true, false)
end
