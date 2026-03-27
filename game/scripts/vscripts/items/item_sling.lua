item_sling = item_sling or class {}

function item_sling:OnAbilityPhaseStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    if target:GetName() ~= "npc_gorilla" then
        caster:Stop()
    end
end

function item_sling:OnSpellStart()
    local caster = self:GetCaster()
    local target = self:GetCursorTarget()
    if target:GetName() ~= "npc_gorilla" then return end

    caster:EmitSound("items.sling.cast")

    ProjectileManager:CreateTrackingProjectile({
        vSourceLoc = caster:GetAbsOrigin() + Vector(0, 0, 300),
        Target = target,
        iMoveSpeed = 1000,
        bDodgeable = false,
        bIgnoreObstructions = true,
        Ability = self,
        Source = caster,
        EffectName = "particles/base_attacks/ranged_siege_good.vpcf"
    })
end

function item_sling:OnProjectileHit(target, location)
    if not target then return end
    if not IsServer() then return end

    EmitSoundOnLocationWithCasterSafe(location, "items.sling.hit", self:GetCaster())

    ApplyDamage({
        victim = target,
        attacker = self:GetCaster(),
        damage = 1,
        damage_type = DAMAGE_TYPE_PURE,
        ability = self,
    })
end
