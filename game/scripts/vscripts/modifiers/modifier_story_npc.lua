modifier_story_npc = modifier_story_npc or class({})

function modifier_story_npc:IsHidden()
	return true
end

function modifier_story_npc:IsPurgable()
	return false
end

function modifier_story_npc:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_MAGICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PURE,
	}
end

function modifier_story_npc:GetAbsoluteNoDamageMagical()
	return 1
end

function modifier_story_npc:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_story_npc:GetAbsoluteNoDamagePure()
	return 1
end

function modifier_story_npc:CheckState()
	return {
		[MODIFIER_STATE_INVULNERABLE] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR] = true,
		[MODIFIER_STATE_NOT_ON_MINIMAP] = true,
		[MODIFIER_STATE_NO_HEALTH_BAR_FOR_ENEMIES]   = true,
		[MODIFIER_STATE_NO_HEALTH_BAR_FOR_OTHER_PLAYERS]   = true,
	}
end

function modifier_story_npc:OnCreated()
	local parent = self:GetParent()
	parent:Stop()
	parent.bAcquisitionRange = parent:GetAcquisitionRange()
	parent:SetIdleAcquire(false)
	parent:SetAcquisitionRange(0)
	parent.oldDayVisionRange = parent:GetDayTimeVisionRange()
	parent.oldNightVisionRange = parent:GetNightTimeVisionRange()
	parent:SetDayTimeVisionRange(0)
	parent:SetNightTimeVisionRange(0)
	if not parent:HasModifier("modifier_phased") then
		parent:AddNewModifier(parent, nil, "modifier_phased", {})
	end
end

function modifier_story_npc:OnDestroy()
	local parent = self:GetParent()
	parent:SetIdleAcquire(true)
	parent:SetAcquisitionRange(1000)
	parent:SetDayTimeVisionRange(parent.oldDayVisionRange or 700)
	parent:SetNightTimeVisionRange(parent.oldNightVisionRange or 700)
	parent:SetNightTimeVisionRange(0)
	if parent:HasModifier("modifier_phased") then
		parent:RemoveModifierByName("modifier_phased")
	end
end
