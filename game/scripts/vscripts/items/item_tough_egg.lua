item_tough_egg = class({})
LinkLuaModifier("modifier_tough_egg_buff", "items/item_tough_egg", LUA_MODIFIER_MOTION_NONE)


function item_tough_egg:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    caster:EmitSound("items.tough_egg.cast")
    caster:AddNewModifier(self:GetCaster(), self, "modifier_tough_egg_buff", {
        duration = self:GetSpecialValueFor("duration"),
    })
end

--------------------------------------------------------------------------------

modifier_tough_egg_buff = class({})

function modifier_tough_egg_buff:IsHidden() return false end

function modifier_tough_egg_buff:IsPurgable() return true end

function modifier_tough_egg_buff:OnCreated()
    if not IsServer() then return end
    self.pfx = ParticleManager:CreateParticle("particles/items2_fx/manta_phase.vpcf", PATTACH_ABSORIGIN_FOLLOW,
        self:GetParent())
end

function modifier_tough_egg_buff:OnDestroy()
    if not IsServer() then return end
    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
end

function modifier_tough_egg_buff:CheckState()
    return {
        [MODIFIER_STATE_MAGIC_IMMUNE] = true,
    }
end

function modifier_tough_egg_buff:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_INCOMING_DAMAGE_PERCENTAGE,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
        MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
        MODIFIER_EVENT_ON_MODIFIER_ADDED,
    }
end

function modifier_tough_egg_buff:GetAbsoluteNoDamageMagical()
    return 1
end

function modifier_tough_egg_buff:GetAbsoluteNoDamagePhysical()
    return 1
end

function modifier_tough_egg_buff:GetAbsoluteNoDamagePure()
    return 1
end

function modifier_tough_egg_buff:OnModifierAdded(params)
    if params.unit == self:GetParent() and params.added_buff:IsDebuff() then
        DebugPrint(params.added_buff:GetName())
        params.added_buff:Destroy()
    end
end

function modifier_tough_egg_buff:GetModifierIncomingDamage_Percentage()
    SendOverheadEventMessage(nil, OVERHEAD_ALERT_EVADE, self:GetParent(), 0, nil)
    return -100
end

function modifier_tough_egg_buff:GetTexture()
    return "item_tough_egg"
end
