trap_skeleton = class {}
LinkLuaModifier("modifier_trap_skeleton", "abilities/trap_skeleton", LUA_MODIFIER_MOTION_NONE)

function trap_skeleton:GetIntrinsicModifierName()
    return "modifier_trap_skeleton"
end

------------------------------------------------------

modifier_trap_skeleton = class {}

function modifier_trap_skeleton:IsHidden() return true end

function modifier_trap_skeleton:IsPurgable() return false end

function modifier_trap_skeleton:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_ATTACK_LANDED
    }
end

function modifier_trap_skeleton:OnAttackLanded(params)
    if not IsServer() then return end
    if params.attacker ~= self:GetParent() then return end
    ApplyDamage({
        victim = params.target,
        attacker = self:GetParent(),
        damage = EpsTraps:GetDamage(params.target),
        damage_type = DAMAGE_TYPE_PURE,
        ability = self:GetAbility()
    })
end

function modifier_trap_skeleton:OnCreated()
    if not IsServer() then return end
    local ability = self:GetAbility()
    self.range = ability:GetSpecialValueFor("range")
    self:StartIntervalThink(ability:GetSpecialValueFor("fire_interval"))

    DrawDebugCircle(self:GetParent():GetAbsOrigin(), self.range)
end

function modifier_trap_skeleton:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    local parentPos = parent:GetAbsOrigin()
    local enemies = FindEnemiesForAIInRadius(parentPos, self.range)

    if #enemies > 0 then
        parent:StartGesture(ACT_DOTA_ATTACK)
        parent:FaceTowards(enemies[1]:GetAbsOrigin())
        Timers:CreateTimer(0.33, function()
            for _, ent in ipairs(enemies) do
                parent:PerformAttack(ent, true, true, true, true, true, false, true)
            end
        end)
    end
end
