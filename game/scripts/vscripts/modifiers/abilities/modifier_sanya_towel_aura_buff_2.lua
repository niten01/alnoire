modifier_sanya_towel_aura_buff_2 = class({})

function modifier_sanya_towel_aura_buff_2:IsHidden() return false end
function modifier_sanya_towel_aura_buff_2:IsPurgable() return false end
function modifier_sanya_towel_aura_buff_2:IsDebuff() return false end

function modifier_sanya_towel_aura_buff_2:GetModifierPreAttack_BonusDamage()
    local ability = self:GetAbility()
    local bonus_damage = ability:GetSpecialValueFor('bonus_damage')
    return bonus_damage
end

function modifier_sanya_towel_aura_buff_2:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_PREATTACK_BONUS_DAMAGE,
    }
end

function modifier_sanya_towel_aura_buff_2:OnCreated()
    if not IsServer() then return end
    local parent = self:GetParent()
    local ability = self:GetAbility()
    self.damage_percent = ability:GetSpecialValueFor('hp_per_sec')
    local pfx = ParticleManager:CreateParticle("particles/sanya_towel_aura_red_summon.vpcf", PATTACH_ABSORIGIN_FOLLOW, parent)
    self:AddParticle( pfx, false, false, -1, false, false )
    self:StartIntervalThink(1.0)
end

function modifier_sanya_towel_aura_buff_2:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    if not parent:IsAlive() then return end
    local cur_health = parent:GetHealth()
    local damage_per_tick = cur_health * (self.damage_percent / 100)
    ApplyDamage(
        {
            victim=parent,
            attacker=parent,
            damage=damage_per_tick,
            damage_type=DAMAGE_TYPE_PURE,
            damage_flags=DOTA_DAMAGE_FLAG_HPLOSS + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
        }
    )
end