goden_spin = class {}

function goden_spin:OnAbilityPhaseStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    caster:EmitSound("ability.goden.spin.cast.roar")
end

function goden_spin:GetBackswingTime()
    return 1.27
end

function goden_spin:OnSpellStart()
    if not IsServer() then return end
    local caster    = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local damage    = self:GetSpecialValueFor("damage")
    local radius    = self:GetCastRange(casterPos, nil)

    caster:AddNewModifier(caster, self, "modifier_logarithmus_casting", { duration = self:GetBackswingTime() })

    self.pfx = ParticleManager:CreateParticle(
        "particles/econ/items/juggernaut/armor_of_the_favorite/juggernaut_blade_fury_favoriteblade.vpcf",
        PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.pfx, 0, casterPos)
    ParticleManager:SetParticleControl(self.pfx, 5, Vector(radius, 0, 0))

    caster:EmitSound("ability.goden.spin.cast")

    local enemies = FindEnemiesForAIInRadius(casterPos, radius)
    for _, ent in ipairs(enemies) do
        ApplyDamage({
            victim = ent,
            attacker = caster,
            damage = damage,
            damage_type = self:GetAbilityDamageType(),
        })
    end

    Timers:CreateTimer(self:GetBackswingTime(), function()
        ParticleManager:DestroyParticle(self.pfx, true)
        ParticleManager:ReleaseParticleIndex(self.pfx)
        self.pfx = nil
    end)
end
