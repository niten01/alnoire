LinkLuaModifier("modifier_mk_passive_stacks", "abilities/bosses/mk_passive_custom", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_mk_stack_debuff", "abilities/bosses/mk_passive_custom", LUA_MODIFIER_MOTION_NONE)
mk_passive_custom = class({})

function mk_passive_custom:GetIntrinsicModifierName()
    return "modifier_mk_passive_stacks"
end

-----------------------------------------------------------


modifier_mk_passive_stacks = class({})

function modifier_mk_passive_stacks:IsHidden() return false end

function modifier_mk_passive_stacks:IsPurgable() return false end

function modifier_mk_passive_stacks:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_mk_passive_stacks:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    if params.target:IsBuilding() or params.target:IsOther() then return end
    local abil = self:GetAbility()
    local maxStacks = abil:GetSpecialValueFor('max_stacks')
    local target = params.target
    local modifier_name = "modifier_mk_stack_debuff"
    local duration = abil:GetSpecialValueFor('stacksDuration')
    local mod = target:AddNewModifier(self:GetParent(), self:GetAbility(), modifier_name, { duration = duration })
    if mod then
        if mod:GetStackCount() < maxStacks then
            mod:IncrementStackCount()
        elseif mod:GetStackCount() == maxStacks then
            mod:SetStackCount(1)
        end
    end
end

modifier_mk_stack_debuff = class({})

function modifier_mk_stack_debuff:IsDebuff() return true end

function modifier_mk_stack_debuff:IsPurgable() return false end

function modifier_mk_stack_debuff:GetTexture() return "monkey_king_jingu_mastery" end

function modifier_mk_stack_debuff:OnCreated()
    if not IsServer() then return end
    self:SetStackCount(0)
    self.pfxNumber = ParticleManager:CreateParticle(
        "particles/units/heroes/hero_monkey_king/monkey_king_quad_tap_stack.vpcf", PATTACH_OVERHEAD_FOLLOW,
        self:GetParent())
    self:AddParticle(self.pfxNumber, false, false, -1, false, true)
end

function modifier_mk_stack_debuff:OnStackCountChanged(oldStackCount)
    if not IsServer() then return end
    if self.pfxNumber then
        local counter = self:GetStackCount()
        ParticleManager:SetParticleControl(self.pfxNumber, 1, Vector(counter, counter, counter))
    end
end

function modifier_mk_stack_debuff:OnDestroy()
    if not IsServer() then return end
    if self.pfxNumber then
        ParticleManager:DestroyParticle(self.pfxNumber, false)
        ParticleManager:ReleaseParticleIndex(self.pfxNumber)
    end
end
