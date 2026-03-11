ball_jump = class {}

function ball_jump:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local target = self:GetCursorPosition()
    local duration = self:GetSpecialValueFor("jump_duration")
    local height = self:GetSpecialValueFor("jump_height")
    local warningDuration = self:GetSpecialValueFor("warning_duration")
    local radius = self:GetSpecialValueFor("radius")
    local slideSpeed = self:GetSpecialValueFor("landing_slide_speed")
    local damage = self:GetSpecialValueFor("damage")
    local v = (target - caster:GetAbsOrigin())
    local slide = caster:FindModifierByName("modifier_ball_slide")
    assert(slide)
    slide.velocity = Vector(0, 0, 0)

    caster:EmitSound("ball.jump.swing")

    caster:AddNewModifier(caster, self, "modifier_vertical_jump", {
        duration = duration,
        height = height,
    })

    caster:AddNewModifier(caster, self, "modifier_move", {
        duration = duration,
        directionX = v.x,
        directionY = v.y,
        speed = #v / duration,
    })

    Timers:CreateTimer(duration - warningDuration, function()
        ShowGenericCircleWarning(target, radius, warningDuration)
    end)

    Timers:CreateTimer(duration, function()
        slide.velocity = v:Normalized() * slideSpeed 
        local enemies = FindEnemiesForAIInRadius(target, radius)
        for _, ent in ipairs(enemies) do
            ApplyDamage({
                victim = ent,
                attacker = caster,
                damage = damage,
                damage_type = self:GetAbilityDamageType(),
                ability = self
            })
        end

        local pfx = ParticleManager:CreateParticle("particles/neutral_fx/roshan_slam.vpcf", PATTACH_WORLDORIGIN, nil)
        ParticleManager:SetParticleControl(pfx, 0, target)
        ParticleManager:SetParticleControl(pfx, 1, Vector(radius, 0, 0))

        caster:EmitSound("ball.jump.impact")
    end)
end
