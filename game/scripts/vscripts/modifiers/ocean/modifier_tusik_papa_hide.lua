modifier_tusik_papa_hide = class({})

function modifier_tusik_papa_hide:IsHidden() return true end

function modifier_tusik_papa_hide:IsPurgable() return false end

function modifier_tusik_papa_hide:CheckState()
    return {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_UNTARGETABLE] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
        [MODIFIER_STATE_ROOTED] = true,
        [MODIFIER_STATE_DISARMED] = true,
        [MODIFIER_STATE_SILENCED] = true,
    }
end

function modifier_tusik_papa_hide:DeclareFunctions()
    return {
        MODIFIER_EVENT_ON_DEATH
    }
end

function modifier_tusik_papa_hide:OnDeath(params)
    if params.unit and string.find(string.lower(params.unit:GetUnitName()), "tusik_mini") then
        self.numTusiksMini = self.numTusiksMini - 1
        if self.numTusiksMini <= 0 then
            self:Destroy()
        end
    end
end

function modifier_tusik_papa_hide:showPuff()
    local parent = self:GetParent()
    local pfx = ParticleManager:CreateParticle(
        "particles/econ/items/monkey_king/arcana/monkey_arcana_cloud_start.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        parent
    )
    ParticleManager:ReleaseParticleIndex(pfx)

    local pfx2 = ParticleManager:CreateParticle(
        "particles/econ/events/fall_2022/blink/blink_dagger_fall_2022_smokepoof.vpcf", PATTACH_ABSORIGIN_FOLLOW,
        self:GetParent())
    ParticleManager:ReleaseParticleIndex(pfx2)
    EmitSoundOn("Hero_MonkeyKing.Transform.Off", parent)
end

function modifier_tusik_papa_hide:OnCreated()
    if not IsServer() then return end
    local parent = self:GetParent()
    parent:AddNoDraw()
    self.numTusiksMini = 3
    self:showPuff()
end

function modifier_tusik_papa_hide:OnDestroy()
    if not IsServer() then return end
    local banana_prop = Entities:FindByName(nil, "tusk_papa_banana")

    if banana_prop then
        UTIL_Remove(banana_prop)
    end

    local parent = self:GetParent()
    parent:RemoveNoDraw()
    self:showPuff()
end
