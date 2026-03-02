gorilla_arc = class {}
LinkLuaModifier("modifier_gorilla_arc", "abilities/bosses/gorilla_arc.lua", LUA_MODIFIER_MOTION_NONE)

function gorilla_arc:ShowWarning(targetPos)
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local delay = self:GetSpecialValueFor("warning_delay")
    local radius = self:GetSpecialValueFor("capture_radius")
    local distance = self:GetSpecialValueFor("distance")


    local fwd = (targetPos - casterPos):Normalized()
    local rightDir = fwd:Cross(Vector(0, 0, 1)):Normalized()
    local endTarget = GetSafeBlinkDestination(casterPos, casterPos + rightDir * distance, distance)
    local leftTarget = GetSafeBlinkDestination(casterPos, casterPos - rightDir * distance, distance)
    if #(leftTarget - casterPos) < #(endTarget - casterPos) then
        endTarget = leftTarget
    end

    local arcInfo = PointsArc(casterPos, targetPos, endTarget)
    ShowGenericArcWarning(arcInfo, radius, delay)
    self.arcInfo = arcInfo
    return delay
end

function gorilla_arc:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local radius = self:GetSpecialValueFor("capture_radius")
    local ummDuration = self:GetSpecialValueFor("umm_duration")
    local damage = self:GetSpecialValueFor("damage")

    assert(self.arcInfo)
    caster.gorillaArcInfo = self.arcInfo
    caster:AddNewModifier(caster, self, "modifier_gorilla_arc", { duration = self:GetSpecialValueFor("travel_time") })
    caster:AddNewModifier(caster, self, "modifier_gorilla_capture", {
        radius = radius,
        ummDuration = ummDuration,
        damage = damage
    })

    caster:EmitSound("ability.gorilla.arc")
end

---------------------------------------------------------------

modifier_gorilla_arc = class {}

function modifier_gorilla_arc:IsHidden() return true end

function modifier_gorilla_arc:IsPurgable() return false end

function modifier_gorilla_arc:OnCreated(kv)
    if not IsServer() then return end
    local parent = self:GetParent()
    assert(parent.gorillaArcInfo)
    self.arcInfo = parent.gorillaArcInfo
    parent.gorillaArcInfo = nil
    local interval = 0.01
    self.iter = self.arcInfo:StableIterator(self:GetDuration() / interval)
    self.point = self.iter()
    self.z = parent:GetAbsOrigin().z
    self:StartIntervalThink(interval)

    parent:StartGesture(ACT_DOTA_RUN)

    self.pfx = ParticleManager:CreateParticle(
        "particles/units/heroes/hero_primal_beast/primal_beast_onslaught_charge_active.vpcf", PATTACH_ABSORIGIN_FOLLOW,
        parent)
    ParticleManager:SetParticleControlEnt(self.pfx, 0, parent, PATTACH_ABSORIGIN_FOLLOW, "", Vector(300, 0, 0), true)
end

function modifier_gorilla_arc:OnDestroy()
    if not IsServer() then return end
    local parent = self:GetParent()
    parent:FadeGesture(ACT_DOTA_RUN)
    FindClearSpaceForUnit(parent, parent:GetAbsOrigin(), true)

    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
end

function modifier_gorilla_arc:OnIntervalThink()
    local parent = self:GetParent()
    local nextPoint = self.iter()
    if nextPoint == nil then
        self:Destroy()
        return
    end
    nextPoint.z = self.z
    self.point.z = self.z
    parent:SetAbsOrigin(self.point)
    parent:SetForwardVector((nextPoint - self.point):Normalized())
    self.point = nextPoint
end
