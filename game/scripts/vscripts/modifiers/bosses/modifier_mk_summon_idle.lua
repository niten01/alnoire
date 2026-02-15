modifier_mk_summon_idle = class({})

function modifier_mk_summon_idle:IsHidden() return false end
function modifier_mk_summon_idle:IsPurgable() return false end


function modifier_mk_summon_idle:CheckState()
    return {
        [MODIFIER_STATE_NO_UNIT_COLLISION] = true,
        [MODIFIER_STATE_UNTARGETABLE] = true,
        [MODIFIER_STATE_UNSELECTABLE] = true,
    }
end

function modifier_mk_summon_idle:OnCreated()
    if not IsServer() then return end
    local parent = self:GetParent()
    parent:AddNoDraw()

    self.banana = SpawnEntityFromTableSynchronous("prop_dynamic", {
        model = "models/props_gameplay/banana_prop_closed_mk.vmdl",
        origin = parent:GetAbsOrigin(),
        angles = Vector(0, 0, 0),
    })
end



function modifier_mk_summon_idle:OnDestroy()
    if not IsServer() then return end
    
    local parent = self:GetParent()
    if self.banana and not self.banana:IsNull() then
        UTIL_Remove(self.banana)
        self.banana = nil
    end
    parent:RemoveNoDraw()
    local pfx = ParticleManager:CreateParticle(
        "particles/econ/items/monkey_king/arcana/monkey_arcana_cloud_start.vpcf",
        PATTACH_ABSORIGIN_FOLLOW,
        parent
    )
    ParticleManager:ReleaseParticleIndex(pfx)
    
    local pfx2 = ParticleManager:CreateParticle("particles/econ/events/fall_2022/blink/blink_dagger_fall_2022_smokepoof.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetParent())
    ParticleManager:ReleaseParticleIndex(pfx2)

    EmitSoundOn("Hero_MonkeyKing.Transform.Off", parent)
end