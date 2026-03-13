derek_wolf_explode_howl = class {}

function derek_wolf_explode_howl:Pull()
    local pullDuration = self:GetSpecialValueFor("pull_duration")
    local radius = self:GetSpecialValueFor("pull_radius")
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()

    local pfx = ParticleManager:CreateParticle("particles/derek_wolf_pull.vpcf", PATTACH_ABSORIGIN, caster)
    ParticleManager:ReleaseParticleIndex(pfx)

    caster:EmitSound("ability.derek.wolf_explode_howl.pull")

    local enemies = FindEnemiesForAIInRadius(casterPos, radius)
    for _, ent in ipairs(enemies) do
        local v = casterPos - ent:GetAbsOrigin()
        local dir = v:Normalized()
        local dist = #v
        ent:AddNewModifier(caster, self, "modifier_move", {
            directionX = dir.x,
            directionY = dir.y,
            duration = pullDuration,
            speed = dist / pullDuration,
            activity = ACT_DOTA_FLAIL,
        })
    end
end

function derek_wolf_explode_howl:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local radius = self:GetSpecialValueFor("radius")

    local mouthIdx = caster:ScriptLookupAttachment("attach_mouth")
    local mouthPos = caster:GetAttachmentOrigin(mouthIdx)

    self.pfx = ParticleManager:CreateParticle("particles/derek_wolf_pull_channel.vpcf", PATTACH_WORLDORIGIN, nil)
    ParticleManager:SetParticleControl(self.pfx, 0, mouthPos + Vector(0, 0, 20))
    ParticleManager:SetParticleControl(self.pfx, 3, Vector(radius, 0, 0))

    self:Pull()
    Timers:CreateTimer(self:GetSpecialValueFor("second_pull_delay"), function()
        if not caster:IsChanneling() then return end

        self:Pull()
    end)
end

function derek_wolf_explode_howl:OnChannelFinish(bInterrupted)
    if not IsServer() then return end

    if self.pfx then
        ParticleManager:DestroyParticle(self.pfx, false)
        ParticleManager:ReleaseParticleIndex(self.pfx)
    end

    if bInterrupted then return end
    local damage = self:GetSpecialValueFor("damage")
    local radius = self:GetSpecialValueFor("radius")

    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()

    local pfx = ParticleManager:CreateParticle("particles/econ/items/axe/axe_ti9_immortal/axe_ti9_call.vpcf",
        PATTACH_ABSORIGIN, caster)
    ParticleManager:SetParticleControl(pfx, 2, Vector(radius, radius, radius))
    ParticleManager:ReleaseParticleIndex(pfx)

    caster:EmitSound("ability.derek.wolf_explode_howl.explode")
    caster:EmitSound("ability.derek.wolf_explode_howl.explode_layer")
    caster:EmitSound("ability.derek.wolf_explode_howl.explode_layer2")

    local enemies = FindEnemiesForAIInRadius(casterPos, radius)
    for _, ent in ipairs(enemies) do
        ApplyDamage({
            victim = ent,
            attacker = caster,
            damage = damage,
            damage_type = self:GetAbilityDamageType(),
            ability = self,
        })
    end
end
