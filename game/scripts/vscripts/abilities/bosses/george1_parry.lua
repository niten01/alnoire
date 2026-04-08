george1_parry = class {}
LinkLuaModifier("modifier_george_parry", "abilities/bosses/george1_parry.lua", LUA_MODIFIER_MOTION_NONE)

function george1_parry:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local duration = self:GetSpecialValueFor("duration")

    caster:EmitSound("ability.george1.parry.cast")

    caster:AddNewModifier(caster, self, "modifier_george_parry", {
        duration = duration
    })

    local cd = RandomFloat(self:GetLevelSpecialValueFor("cooldown", 0), self:GetLevelSpecialValueFor("cooldown", 1))
    self:StartCooldown(cd)
end

---------------------------------------------------------------------------

modifier_george_parry = class {}

function modifier_george_parry:IsHidden() return false end
function modifier_george_parry:IsPurgable() return false end

function modifier_george_parry:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_TAKEDAMAGE,
    }
end

function modifier_george_parry:OnCreated()
    if not IsServer() then return end

    local parent = self:GetParent()
    self.pfx = ParticleManager:CreateParticle("particles/george_parry.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
end

function modifier_george_parry:OnDestroy()
    if not IsServer() then return end

    ParticleManager:DestroyParticle(self.pfx, false)
    ParticleManager:ReleaseParticleIndex(self.pfx)
end

function modifier_george_parry:OnTakeDamage(params)
    if not IsServer() then return end
    local parent = self:GetParent()
    local ability = self:GetAbility()
    if params.unit ~= parent then return end
    local threshold = ability:GetSpecialValueFor("damage_threshold")
    if params.original_damage < threshold then return end

    local stunDuration = ability:GetSpecialValueFor("stun_duration")
    local damage = ability:GetSpecialValueFor("damage")


    ApplyDamage({
        victim = params.attacker,
        attacker = parent,
        damage = damage,
        damage_type = ability:GetAbilityDamageType(),
        ability = self,
    })

    params.attacker:AddNewModifier(parent, ability, "modifier_stunned", {
        duration = stunDuration
    })
end
