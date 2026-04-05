CityCutscene = class {}

function CityCutscene:Init()
    self.crowdNPCs = {
        "npc_courier_knight",
        "npc_courier_bug",
        "npc_courier_alkash",
        "npc_courier_pivo",
        "npc_courier_chicken",
        "npc_courier_carpet",
        "npc_courier_hamster",
        "npc_courier_koala",
        "npc_courier_shop",
        "npc_courier_cat",
        "npc_courier_donkeys",
        "npc_courier_bh",
        "npc_courier_chest",
        "npc_courier_skeleton",
        "npc_courier_crocodile",
        "npc_courier_sniffer",
        "npc_courier_smart",
        "npc_leader",
        "npc_ogre_magi",
        "npc_scientist",
        "npc_guide",
        "npc_blue_prince",
        "npc_hermit",
        "npc_creep_rogach",
    }

    self.crowdLines = {
        "Но как?",
        "Портал заработал?",
        "Мы свободны?",
        "В голове все перемешалось...",
        "Что будет дальше?",
        "Неужели этот день настал...",
        "Невероятно!",
        "Вперед, Алекс!",
        "Давай!",
        "У него получилось!",
        "Что за столпотворение?",
        "Всё как во сне.",
        "Предсказание сбылось!",
        "У него получилось!",
        "Пора прощаться.",
        "Алекс!",
        "Удачи!",
        "Не может быть...",
        "Наш герой!",
    }
end

function CityCutscene:CreateFinaleCrowd(portalEnt)
    local radius = 1100
    local minRadius = 700
    local minDistance = 250
    local center = portalEnt:GetAbsOrigin()
    local points = {}

    for _, npcName in ipairs(self.crowdNPCs) do
        local ent = Entities:FindByName(nil, npcName)
        assert(ent, "No ent for crowd: " .. npcName)
        while true do
            local point = RandomPointsInCircle(center, radius, 1, minRadius)[1]
            local minToRest = math.huge
            for _, other in ipairs(points) do
                minToRest = math.min(minToRest, #(other - point))
            end

            if minToRest >= minDistance then
                table.insert(points, point)
                FindClearSpaceForUnit(ent, point, true)
                ent:FaceTowards(center)
                break
            end
        end
    end

    local lineInterval = 0.3
    local lineDuration = 10
    self.crowdLineTID = Timers:CreateTimer(0, function()
        local npcName = self.crowdNPCs[RandomInt(1, #self.crowdNPCs)]
        local npc = Entities:FindByName(nil, npcName)
        assert(npc)
        local line = self.crowdLines[RandomInt(1, #self.crowdLines)]
        Dialogue:ShowDialogueBubbleEx(npc, line, lineDuration)
        return lineInterval
    end)
end

function CityCutscene:Start(playerID)
    Music:StartCustomMusic(playerID, "music.credits.city")

    for _, textEnt in ipairs(Entities:FindAllByName("credits_text")) do
        DoEntFireByInstanceHandle(textEnt, "Enable", "", 0, nil, nil)
    end

    local player = PlayerResource:GetPlayer(playerID)
    assert(player)
    CustomGameEventManager:Send_ServerToPlayer(player, "cutscene_show_bars", {})

    local portalEnt = Entities:FindByName(nil, "final_portal")
    assert(portalEnt)
    DoEntFireByInstanceHandle(portalEnt, "SetAnimation", "team_portal_channel_big", 0, nil, nil)

    self:CreateFinaleCrowd(portalEnt)

    local wp = Entities:FindByName(nil, "city_finale_waypoint")
    assert(wp)
    local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
    assert(hero)

    PlayerResource:SetCameraTarget(playerID, hero)
    GameRules:GetGameModeEntity():SetCameraSmoothCountOverride(30)
    hero:MoveToPosition(wp:GetAbsOrigin())
    hero:AddNewModifier(nil, nil, "modifier_cutscene_player", { duration = -1 })

    local checkInterval = 1
    local standTime = 6
    local fadeTime = 4
    Timers:CreateTimer(0, function()
        local wpPos = wp:GetAbsOrigin()
        wpPos.z = hero:GetAbsOrigin().z
        local dist = #(hero:GetAbsOrigin() - wpPos)
        if dist <= 3 then
            local portalCenterEnt = Entities:FindByName(nil, "final_portal_center")
            assert(portalCenterEnt)
            -- PlayerResource:SetCameraTarget(playerID, portalEnt)

            local portalPFX = ParticleManager:CreateParticle("particles/final_portal.vpcf", PATTACH_WORLDORIGIN, nil)
            local fwd = hero:GetAbsOrigin() - portalCenterEnt:GetAbsOrigin()
            fwd.z = 0
            ParticleManager:SetParticleControlTransformForward(portalPFX, 1, portalCenterEnt:GetAbsOrigin(),
                fwd:Normalized())

            Timers:CreateTimer(standTime, function()
                hero:RemoveModifierByName("modifier_cutscene_player")
                hero:MoveToPosition(portalCenterEnt:GetAbsOrigin())
                hero:AddNewModifier(nil, nil, "modifier_cutscene_player", { duration = -1 })

                CustomGameEventManager:Send_ServerToPlayer(player, "cutscene_show_fade", {})
                Timers:CreateTimer(fadeTime, function()
                    local tgt = Entities:FindByName(nil, "tp_target_mgtu")
                    assert(tgt)
                    hero:SetAbsOrigin(tgt:GetAbsOrigin())
                    hero:SetForwardVector(tgt:GetForwardVector())
                    PlayerResource:SetCameraTarget(playerID, nil)
                    CenterCameraOnUnit(playerID, hero)
                    GameRules:GetGameModeEntity():SetCameraSmoothCountOverride(8)

                    hero:RemoveModifierByName("modifier_cutscene_player")
                    CustomGameEventManager:Send_ServerToPlayer(player, "cutscene_hide", {})
                    self:Stop(playerID)
                    StoryDriver:HandleAction(playerID, { type = "change_hero", hero = "npc_dota_hero_sanya_ending" })

                    local hero = PlayerResource:GetBarebonesAssignedHero(playerID)
                    assert(hero)
                    hero:AddNewModifier(nil, nil, "modifier_ending_evade", { duration = -1 })
                end)
            end)
            return nil
        end
        return checkInterval
    end)
end

function CityCutscene:Stop(playerID)
    Timers:RemoveTimer(self.crowdLineTID)
    Music:StopCustomMusic(playerID)
end

return CityCutscene
