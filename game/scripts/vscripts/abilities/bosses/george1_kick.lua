george1_kick = class {}

function george1_kick:ShowWarning(targetPos)
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local range = self:GetCastRange(casterPos, nil)
    local width = self:GetSpecialValueFor("width")
    local delay = self:GetSpecialValueFor("warning_delay")
    local v = targetPos - casterPos
    self.endPos = casterPos + v:Normalized() * range
    ShowGenericLineWarning(casterPos, self.endPos, width, delay + self:GetCastPoint())
    return delay
end

function george1_kick:OnAbilityPhaseStart()
    if not IsServer() then return end
    assert(self.endPos)

    local caster = self:GetCaster()
    caster:FaceTowards(self.endPos)
    caster:EmitSound("ability.george1.kick.swing")
end

function george1_kick:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local casterPos = caster:GetAbsOrigin()
    local width = self:GetSpecialValueFor("width")
    local damage = self:GetSpecialValueFor("damage")
    local maxDist = self:GetSpecialValueFor("distance")
    local pushTime = self:GetSpecialValueFor("travel_time")


    local enemies = FindEnemiesForAIInLine(casterPos, self.endPos, width)

    if #enemies > 0 then
        caster:EmitSound("ability.george1.kick.hit")
    end
    caster:EmitSound("ability.george1.kick.swing2")

    for _, ent in ipairs(enemies) do
        ApplyDamage({
            victim = ent,
            attacker = caster,
            damage = damage,
            damage_type = self:GetAbilityDamageType(),
            ability = self,
        })

        local entPos = ent:GetAbsOrigin()
        local v = self.endPos - casterPos
        local dest = GetSafeBlinkDestination(entPos, entPos + v:Normalized() * maxDist, maxDist)

        ent:AddNewModifier(caster, self, "modifier_move_ease", {
            directionX = v.x,
            directionY = v.y,
            duration = pushTime,
            distance = #(dest - entPos),
            activity = ACT_DOTA_FLAIL,
        })
    end
end
