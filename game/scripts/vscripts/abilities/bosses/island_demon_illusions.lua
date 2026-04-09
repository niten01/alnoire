island_demon_illusions = class {}
LinkLuaModifier("modifier_island_demon_invulnerable", "abilities/bosses/island_demon_illusions",
    LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_island_demon_rand_cdr", "abilities/bosses/island_demon_illusions",
    LUA_MODIFIER_MOTION_NONE)

function island_demon_illusions:OnSpellStart()
    if not IsServer() then return end
    local caster = self:GetCaster()
    caster:AddNoDraw()

    self.pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_shadow_demon/shadow_demon_disruption.vpcf",
        PATTACH_WORLDORIGIN, nil)
    local pos = caster:GetAbsOrigin()
    pos.z = pos.z + 50
    ParticleManager:SetParticleControl(self.pfx, 0, pos)

    caster:EmitSound("ability.island_demon.illusions.cast")
end

function island_demon_illusions:OnChannelFinish(bInterrupted)
    if not IsServer() then return end

    if self.pfx then
        ParticleManager:DestroyParticle(self.pfx, false)
        ParticleManager:ReleaseParticleIndex(self.pfx)
        self.pfx = nil
    end

    if bInterrupted then return end
    local spawnerName = "spawner_island_demon_illusion"

    local caster = self:GetCaster()
    local points = {}
    for _, ent in ipairs(Entities:FindAllByName(spawnerName)) do
        table.insert(points, ent:GetAbsOrigin())
    end
    local realPosIdx = RandomInt(1, #points)
    local realPos = points[realPosIdx]

    local npcs = SpawnManager:SpawnNPC(spawnerName)

    local ai = caster:FindModifierByName("modifier_island_demon_ai")
    assert(ai)
    for _, npc in ipairs(npcs) do
        npc:AddNewModifier(caster, self, "modifier_island_demon_rand_cdr", {
            minCDR = (ai.phase == 2) and 20 or -10,
            maxCDR = (ai.phase == 2) and 70 or 50,
        })

        local pos = npc:GetAbsOrigin()

        local pfx = ParticleManager:CreateParticle("particles/units/heroes/hero_shadow_demon/shadow_demon_loadout.vpcf",
            PATTACH_ABSORIGIN, npc)
        ParticleManager:ReleaseParticleIndex(pfx)

        EmitSoundOnLocationWithCasterSafe(pos, "ability.island_demon.illusions.spawn", caster)

        if #(pos - realPos) < 10 then
            caster:SetAbsOrigin(realPos)
            caster:SetForwardVector(npc:GetForwardVector())
            caster:FaceTowards(realPos + npc:GetForwardVector())
            npc:RemoveSelf()
        else
            SpawnManager:LinkUnitToPack(npc, "pack_island_duo")
        end
    end

    caster:RemoveNoDraw()
end

------------------------------------------------------------

modifier_island_demon_invulnerable = class {}

function modifier_island_demon_invulnerable:CheckState()
    return {
        [MODIFIER_STATE_INVULNERABLE] = true,
        [MODIFIER_STATE_OUT_OF_GAME] = true,
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
    }
end

--------------------------------------------------------------

modifier_island_demon_rand_cdr = class {}

function modifier_island_demon_rand_cdr:IsHidden() return true end

function modifier_island_demon_rand_cdr:IsPurgable() return false end

function modifier_island_demon_rand_cdr:OnCreated(kv)
    if not IsServer() then return end
    self.cdrPct = RandomInt(kv.minCDR, kv.maxCDR)
end

function modifier_island_demon_rand_cdr:DeclareFunctions()
    return {
        MODIFIER_PROPERTY_COOLDOWN_PERCENTAGE
    }
end

function modifier_island_demon_rand_cdr:GetModifierPercentageCooldown()
    return self.cdrPct
end
