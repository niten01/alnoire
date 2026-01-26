modifier_blink_evade = class({})

------------------------------------------------------------
-- Basic info
------------------------------------------------------------
---
---

function modifier_blink_evade:GetTexture() return "abaddon_death_coil" end
function modifier_blink_evade:IsHidden() return false end
function modifier_blink_evade:IsDebuff() return false end
function modifier_blink_evade:IsPurgable() return false end
function modifier_blink_evade:RemoveOnDeath() return true end


------------------------------------------------------------
-- Init
------------------------------------------------------------

function modifier_blink_evade:OnCreated(kv)
    if not IsServer() then return end

    self.max_evades = kv.evades or 3
    self.evades_left = self.max_evades
    self.blink_range = kv.blink_range or 250
    self.evade_cooldown = kv.cooldown or 0.3

    self.last_evade_time = -999
    self.evade_record = nil

    self:SetStackCount(self.evades_left)
end

------------------------------------------------------------
-- Declare functions
------------------------------------------------------------

function modifier_blink_evade:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_RECORD,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
    }
end

------------------------------------------------------------
-- Attack hook (key logic)
------------------------------------------------------------

function modifier_blink_evade:OnAttackRecord(params)
    if not IsServer() then return end
    if params.target ~= self:GetParent() then return end
    if self.evades_left <= 0 then return end

    local now = GameRules:GetGameTime()
    if now - self.last_evade_time < self.evade_cooldown then
        return
    end

    local attacker = params.attacker
    if not attacker or attacker:IsNull() or not attacker:IsAlive() then
        return
    end

    -- consume charge
    self.evades_left = self.evades_left - 1
    self:SetStackCount(self.evades_left)

    self.last_evade_time = now
    self.evade_record = params.record

    -- blink
    self:BlinkBehind(attacker)

    -- remove modifier if empty
    if self.evades_left <= 0 then
        self:Destroy()
    end
end

------------------------------------------------------------
-- Block damage ONLY for this attack
------------------------------------------------------------

function modifier_blink_evade:GetAbsoluteNoDamagePhysical(params)
    if params.record == self.evade_record then
        return 1
    end
    return 0
end

------------------------------------------------------------
-- Blink logic
------------------------------------------------------------

function modifier_blink_evade:BlinkBehind(attacker)
    local parent = self:GetParent()

    local forward = attacker:GetForwardVector()
    local blink_pos = attacker:GetAbsOrigin() - forward * self.blink_range
    blink_pos = GetGroundPosition(blink_pos, parent)
    local side = attacker:GetRightVector()
    local offset = RandomFloat(-50, 50)
    blink_pos = blink_pos + side * offset

    -- FX start
    local p1 = ParticleManager:CreateParticle(
        "particles/items_fx/blink_dagger_start.vpcf",
        PATTACH_WORLDORIGIN,
        parent
    )
    ParticleManager:SetParticleControl(p1, 0, parent:GetAbsOrigin())
    ParticleManager:ReleaseParticleIndex(p1)

    -- teleport
    FindClearSpaceForUnit(parent, blink_pos, true)

    -- FX end
    local p2 = ParticleManager:CreateParticle(
        "particles/items_fx/blink_dagger_end.vpcf",
        PATTACH_WORLDORIGIN,
        parent
    )
    ParticleManager:SetParticleControl(p2, 0, blink_pos)
    ParticleManager:ReleaseParticleIndex(p2)
end

