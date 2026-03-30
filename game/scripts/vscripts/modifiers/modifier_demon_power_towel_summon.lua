modifier_demon_power_towel_summon = class {}

function modifier_demon_power_towel_summon:IsHidden() return false end

function modifier_demon_power_towel_summon:IsPurgable() return false end

function modifier_demon_power_towel_summon:GetAttributes()
    return MODIFIER_ATTRIBUTE_PERMANENT
end

function modifier_demon_power_towel_summon:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
        MODIFIER_PROPERTY_MIN_HEALTH,
    }
end

function modifier_demon_power_towel_summon:OnTakeDamage(event)
    if event.unit ~= self:GetParent() then return end
    local parent = self:GetParent()
    if parent:GetHealth() - event.damage <= 1 then
        parent:SetHealth(parent:GetMaxHealth())

        local pfx = ParticleManager:CreateParticle(
            "particles/units/heroes/hero_tidehunter/tidehunter_krakenshell_purge.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
        ParticleManager:ReleaseParticleIndex(pfx)

        parent:EmitSound("ability.towel_summon.reincarnate")

        self:Destroy()
    end
end

function modifier_demon_power_towel_summon:GetMinHealth()
    return 1
end

function modifier_demon_power_towel_summon:OnCreated()
    if not IsServer() then return end
    CreateDemonPowerEffects(self)
end

function modifier_demon_power_towel_summon:OnDestroy()
    if not IsServer() then return end
    DestroyDemonPowerEffects(self)
end

function modifier_demon_power_towel_summon:GetTexture()
    return "nevermore_dark_lord"
end
