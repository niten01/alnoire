modifier_story_weak_hit_tracking = class({})

function modifier_story_weak_hit_tracking:DeclareFunctions()
  return {
    MODIFIER_PROPERTY_MIN_HEALTH,
    MODIFIER_EVENT_ON_TAKEDAMAGE,
  }
end

function modifier_story_weak_hit_tracking:GetMinHealth()
  return 1
end

function modifier_story_weak_hit_tracking:OnTakeDamage(params)
  if not IsServer() then return end
  local parent = self:GetParent()
  if params.unit ~= parent then return end
  local attackerPlayerID = params.attacker:GetPlayerOwnerID()
      or params.attacker:GetPlayerOwner():GetPlayerID()
  if not attackerPlayerID then
    DebugPrint("[???] Green hit not by player")
    return
  end
  local damage = params.damage
  local damageTarget = parent:GetMaxHealth() - 1
  DebugPrint("[ALNOIRE] Green hit with damage: "..damage..", target: " .. damageTarget)
  local event = {
    playerID = attackerPlayerID,
    win = damage >= damageTarget,
  }

  parent:SetHealth(parent:GetMaxHealth())
  if not parent:HasModifier("modifier_story_npc") then
    parent:AddNewModifier(parent, nil, "modifier_story_npc", { duration = -1 })
  end
  self:Destroy()
  OnGreenTestHitEvent(event)
end
