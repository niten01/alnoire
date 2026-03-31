modifier_siege_dj = class({})

function modifier_siege_dj:OnCreated()
    if not IsServer() then return end
    self.packEnt = Entities:FindByName(nil, "pack_desert_act4_dire_creeps")
    self.needSounds = true
    self:StartIntervalThink(BATTLE_THINK_INTERVAL)
end

function modifier_siege_dj:OnIntervalThink()
    if not IsServer() then return end
    local parent = self:GetParent()
    if not self.packData then
        self.packData = parent.packTargetData
        return
    end
    if not self.needSounds then
        self:Destroy()
        return
    end
    local state = self.packData.state
    if state == 'aggro' then
        EmitSoundOn('DireCreeps.Horn', self.packEnt)
        EmitSoundOn('DireCreeps.Crowd', self.packEnt)
        self.needSounds = false
    end
end
