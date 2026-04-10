derek_wolf_bite = class {}

function derek_wolf_bite:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local target = self:GetCursorTarget()
    local targetPos = target:GetAbsOrigin()
    local radius = self:GetSpecialValueFor("radius")
    caster.derekCasting = true

    local targets = Entities:FindAllByName("wolf_target")
    assert(#targets > 0, "No wolf targets found")
    local randStartPoint = targets[RandomInt(1, #targets)]:GetAbsOrigin()

    local v = targetPos - randStartPoint
    local dir = v:Normalized()

    local mouthIdx = caster:ScriptLookupAttachment("attach_mouth")
    local mouthPos = caster:GetAttachmentOrigin(mouthIdx)
    local mouthDelta = #(casterPos - mouthPos)
    local dist = #v - mouthDelta

    EmitSoundOnLocationWithCasterSafe(casterPos, "ability.derek.wolf_bite.blink", caster)
    caster:SetAbsOrigin(randStartPoint)
    caster:SetForwardVector(dir)
    caster:FaceTowards(targetPos)

    local pfx = ParticleManager:CreateParticle(
        "particles/econ/items/phantom_assassin/pa_crimson_witness_2021/pa_crimson_witness_blur_start.vpcf",
        PATTACH_ABSORIGIN,
        caster)
    ParticleManager:ReleaseParticleIndex(pfx)

    local jumpTime = self:GetSpecialValueFor("jump_time")
    local animAttackPoint = self:GetSpecialValueFor("anim_attack_point")

    pfx = ParticleManager:CreateParticle("particles/derek_move.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
    caster:AddNewModifier(caster, self, "modifier_move_ease", {
        directionX = dir.x,
        directionY = dir.y,
        duration = jumpTime,
        distance = dist,
        pfx = pfx,
    })
    caster:StartGesture(ACT_DOTA_ATTACK_EVENT)

    local damage = self:GetSpecialValueFor("damage")
    local damageType = self:GetAbilityDamageType()
    local spread = self:GetSpecialValueFor("spread")

    Timers:CreateTimer(animAttackPoint, function()
        caster.derekCasting = false

        EmitSoundOnLocationWithCasterSafe(caster:GetAbsOrigin(), "ability.derek.wolf_bite.bite", caster)

        local pfx = ParticleManager:CreateParticle("particles/derek_wolf_bite.vpcf", PATTACH_ABSORIGIN_FOLLOW, caster)
        ParticleManager:ReleaseParticleIndex(pfx)

        local casterPos = caster:GetAbsOrigin()
        local enemies = FindEnemiesInSector(DOTA_TEAM_BADGUYS,
            casterPos + caster:GetForwardVector() * mouthDelta,
            caster:GetForwardVector() * radius,
            spread)

        for _, ent in ipairs(enemies) do
            ApplyDamage({
                victim = ent,
                attacker = caster,
                damage = damage,
                damage_type = damageType,
                ability = self,
            })
            PlayDerekBloodEffects(ent, -caster:GetForwardVector())
        end
    end)
end
