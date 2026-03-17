george_stun = class {}

function george_stun:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local target = FindSanyaInRadius(casterPos, 99999)
    if not target then return end

    local radius = self:GetSpecialValueFor("radius")
    local interval = self:GetSpecialValueFor("interval")
    local delay = self:GetSpecialValueFor("delay")
    local damage = self:GetSpecialValueFor("damage")
    local stunDuration = self:GetSpecialValueFor("stun_duration")

    local numStrikes = RandomInt(self:GetLevelSpecialValueFor("num_strikes", 0),
        self:GetLevelSpecialValueFor("num_strikes", 1))

    local count = 0
    Timers:CreateTimer(0, function()
        local pos = target:GetAbsOrigin()
        ShowGenericCircleWarning(pos, radius, delay)
        Timers:CreateTimer(delay, function()
            local pfx = ParticleManager:CreateParticle(
                "particles/econ/items/lina/lina_ti7/lina_spell_light_strike_array_ti7_gold.vpcf", PATTACH_WORLDORIGIN,
                nil)
            ParticleManager:SetParticleControl(pfx, 0, pos)
            ParticleManager:SetParticleControl(pfx, 1, Vector(radius, 0, 0))
            ParticleManager:ReleaseParticleIndex(pfx)

            EmitSoundOnLocationWithCaster(pos, "ability.george.stun.hit", caster)

            local enemies = FindEnemiesForAIInRadius(pos, radius)
            for _, ent in ipairs(enemies) do
                ApplyDamage({
                    victim = ent,
                    attacker = caster,
                    damage = damage,
                    damage_type = self:GetAbilityDamageType(),
                    ability = self,
                })
                ent:AddNewModifier(caster, self, "modifier_stunned", { duration = stunDuration })
                ApplyGeorgeBurn(ent, self)
            end
        end)

        count = count + 1
        if count >= numStrikes then
            return nil
        end
        return interval
    end)
end
