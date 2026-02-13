return {
    ------------------------------------------------------------
    --- Spawners
    ------------------------------------------------------------
    spawner = {
        __common = {
            team = DOTA_TEAM_GOODGUYS,
            modifiers = {},
            deferred = false,
            injectedAttributes = {},
        },

        spawner_subway_city = {
            npc = "npc_subway_city",
            modifiers = { "modifier_story_npc" },
        },
        spawner_subway_to_city = {
            npc = "npc_subway_to_city",
            modifiers = { "modifier_story_npc" },
        },

        spawner_xavier = {
            npc = "npc_xavier",
            modifiers = { "modifier_story_npc" },
        },
        spawner_shooter_1 = {
            npc = "npc_shooter",
            deferred = true,
            modifiers = { "modifier_story_npc" },
        },
        spawner_gorilla = {
            npc = "npc_gorilla",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_blue_prince = {
            npc = "npc_blue_prince",
            modifiers = { "modifier_story_npc" },
        },
        spawner_tormentor = {
            npc = "npc_tormentor",
            modifiers = { "modifier_story_npc" },
        },
        spawner_shamanka = {
            npc = "npc_shamanka",
            modifiers = { "modifier_story_npc" },
        },
        spawner_gate_troll_left = {
            npc = "npc_gate_troll_biruk",
            modifiers = { "modifier_story_npc" },
        },
        spawner_gate_troll_right = {
            npc = "npc_gate_troll_diruk",
            modifiers = { "modifier_story_npc" },
        },
        spawner_gate_troll_center = {
            npc = "npc_gate_troll_uruk",
            modifiers = { "modifier_story_npc" },
        },
        spawner_guide_city_entrance = {
            npc = "npc_guide",
            modifiers = { "modifier_story_npc" },
        },
        spawner_guide_forest_entrance = {
            npc = "npc_guide",
            deferred = true,
            modifiers = { "modifier_story_npc" },
        },
        spawner_creep_rogach = {
            npc = "npc_creep_rogach",
            modifiers = { "modifier_story_npc" },
        },
        spawner_creep_bob = {
            npc = "npc_creep_bob",
            modifiers = { "modifier_story_npc" },
        },
        spawner_mustache = {
            npc = "npc_mustache",
            modifiers = { "modifier_story_npc" },
        },
        spawner_monkey_king = {
            npc = "npc_monkey_king",
            modifiers = { "modifier_story_npc" },
            packID = "pack_monkey_king",
        },
        spawner_brewmaster = {
            npc = "npc_brewmaster",
            modifiers = { "modifier_story_npc" },
        },
        spawner_ogre_magi = {
            npc = "npc_ogre_magi",
            modifiers = { "modifier_story_npc" },
        },
        spawner_ogre_bruiser = {
            npc = "npc_ogre_bruiser",
            modifiers = { "modifier_story_npc" },
        },
        spawner_rape_victim = {
            npc = "npc_rape_victim",
            modifiers = { "modifier_story_npc" },
        },
        spawner_rape_victim_2 = {
            npc = "npc_rape_victim",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_predvestnik = {
            npc = "npc_predvestnik",
            modifiers = { "modifier_story_npc" },
        },
        spawner_mystery = {
            npc = "npc_mystery",
            modifiers = { "modifier_story_npc" },
        },
        spawner_mystery_2 = {
            npc = "npc_mystery",
            modifiers = { "modifier_story_npc" },
        },
        spawner_templar_assasin = {
            npc = "npc_templar_assasin",
            modifiers = { "modifier_story_npc" },
        },
        spawner_alchemist = {
            npc = "npc_alchemist",
            modifiers = { "modifier_story_npc" },
        },
        spawner_scientist = {
            npc = "npc_scientist",
            modifiers = { "modifier_story_npc" },
        },
        spawner_red = {
            npc = "npc_red",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_green = {
            npc = "npc_green",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_concert_guard = {
            npc = "npc_concert_guard",
            modifiers = { "modifier_story_npc" },
        },
        spawner_trap_arrow = {
            npc = "npc_trap_arrow",
            team = DOTA_TEAM_BADGUYS,
            modifiers = { "modifier_story_npc" },
            injectedAttributes = { "trap_delay", "trap_interval" }
        },
        spawner_trap_fire = {
            npc = "npc_trap_fire",
            team = DOTA_TEAM_BADGUYS,
            modifiers = { "modifier_story_npc" },
            injectedAttributes = { "trap_delay", "trap_interval" }
        },
        spawner_trap_spikes = {
            npc = "npc_trap_spikes",
            team = DOTA_TEAM_BADGUYS,
            modifiers = { "modifier_story_npc" },
        },
        spawner_trap_pendulum = {
            npc = "npc_trap_pendulum",
            team = DOTA_TEAM_BADGUYS,
            -- modifiers = { "modifier_story_npc" },
            injectedAttributes = { "trap_delay", "trap_speed" }
        },
        spawner_storyteller = {
            npc = "npc_storyteller",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_leader = {
            npc = "npc_leader",
            modifiers = { "modifier_story_npc" },
        },
        spawner_perekup = {
            npc = "npc_perekup",
            modifiers = { "modifier_story_npc" },
        },
        spawner_hermit = {
            npc = "npc_hermit",
            modifiers = { "modifier_story_npc" },
        },
        spawner_dream = {
            npc = "npc_dream",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },

        -- jungle
        spawner_lizards_venomancer = {
            npc = "npc_jungle_venomancer",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_lizards"
        },
        spawner_lizards_creep_melee = {
            npc = "npc_jungle_creep_melee",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_lizards"
        },
        spawner_lizards_creep_range = {
            npc = "npc_jungle_creep_range",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_lizards"
        },

        spawner_axe_axe = {
            npc = "npc_jungle_axe",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_axe"
        },
        spawner_axe_sisipisi = {
            npc = "npc_jungle_sisipisi",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_axe",
        },

        spawner_dream_concert = {
            npc = "npc_dream",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_genius = {
            npc = "npc_genius",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },

        spawner_concert_fan_ranged = {
            npc = "npc_ghetto_ranged",
            modifiers = { "modifier_story_npc" },
            deferred = true,
            packID = "pack_concert_crowd",
        },
    },


    ------------------------------------------------------------
    --- Packs
    ------------------------------------------------------------
    pack = {
        __common = {
            spawners = {},
            units = {},
            activateAfterUnitsSpawned = true,
            somebodyNear = false,
            rangeFastTickRate = 2000,
            rangeRetreat = 1300,
            rangeAggro = 600,
            thinker = "default",
            state = "off",

            target = nil,
        },

        pack_forest_act1_lizards = {
            spawners = {
                "spawner_lizards_venomancer",
                "spawner_lizards_creep_melee",
                "spawner_lizards_creep_range",
            },
        },

        pack_forest_act1_axe = {
            thinker = "axe",
            denyTarget = nil,
            spawners = {
                "spawner_axe_axe",
                "spawner_axe_sisipisi",
            },
        },

        pack_concert_crowd = {
            rangeFastTickRate = 1300,
            rangeRetreat = 1300,
            rangeAggro = 1300,
            denyTarget = nil,
            activateAfterUnitsSpawned = false,
            spawners = {
                "spawner_concert_fan_ranged",
            },
        },
        pack_monkey_king = {
            rangeFastTickRate = 600,
            rangeRetreat = 600,
            rangeAggro = 600,
            denyTarget = nil,
            activateAfterUnitsSpawned = false,
            spawners = {
                "spawner_monkey_king",
            },
        },
    },

    ------------------------------------------------------------
    --- Zones
    ------------------------------------------------------------
    zone = {
        zone_classroom_1 = { musicSet = "classroom_1", respawnPoint = "respawn_prologue" },
        zone_prologue = { musicSet = "silence", respawnPoint = "respawn_prologue" },
        zone_forest_1 = { musicSet = "forest", respawnPoint = "respawn_forest_1" },
        zone_city = { musicSet = "city", respawnPoint = "respawn_city", },
        zone_wastelands = { musicSet = "wastelands", respawnPoint = "respawn_wastelands" },
        zone_ghetto = { musicSet = "ghetto", respawnPoint = "respawn_ghetto" },
    },

    ------------------------------------------------------------
    --- NPCs
    ------------------------------------------------------------
    npc = {
        __common = {
            first_met_global = true,
            first_met_in_act = true,
            beaten = false,
            can_give_quest = false,
            isStory = true,
            drop = {}
        },
        npc_perekup = {
            drop = {
                "item_concert_ticket",
                "item_concert_ticket",
            }
        }
    },

    ------------------------------------------------------------
    --- Doors
    ------------------------------------------------------------
    door = {
        door_prologue = {
            clipEntity = "clip_door_prologue",
            openAnimation = "cf_palace_door_open",
        },
        door_clash_royale = {
            clipEntity = "clip_door_clash_royale",
            openAnimation = "open",
        },
        door_forest_1_reward = {
            clipEntity = "clip_door_forest_1_reward",
            openAnimation = "cf_palace_door_open",
            requiresButtons = {
                "button_forest_1_reward_1",
                "button_forest_1_reward_2",
                "button_forest_1_reward_3",
                "button_forest_1_reward_4",
                "button_forest_1_reward_5",
            },
        },
        door_forest_1_shortcut = {
            clipEntity = "clip_door_forest_1_shortcut",
            openAnimation = "cf_palace_door_open",
            requiresButtons = {
                "button_forest_1_shortcut"
            },
        },
        door_forest_2 = {
            clipEntity = "clip_door_forest_2",
            openAnimation = "cf_palace_door_open",
            requiresPassword = "stringus collapsus",
        },
        door_forest_3 = {
            clipEntity = "clip_door_forest_3",
            openAnimation = "open",
            requiresPassword = "logarithmus solvus",
        },
        door_village = {
            clipEntity = "clip_door_village",
        },
        door_village_leader = {
            clipEntity = "clip_door_village_leader",
            openAnimation = "cf_palace_door_open",
        },
        door_concert = {
            clipEntity = "clip_door_concert"
        },
        door_ski = {
            clipEntity = "clip_door_ski"
        },
    },

    ------------------------------------------------------------
    --- Buttons
    ------------------------------------------------------------
    button = {
        button_forest_1_shortcut = {
            trigger = "button_trigger_forest_1_shortcut"
        },

        button_forest_1_reward_1 = {
            trigger = "button_trigger_forest_1_reward_1"
        },
        button_forest_1_reward_2 = {
            trigger = "button_trigger_forest_1_reward_2"
        },
        button_forest_1_reward_3 = {
            trigger = "button_trigger_forest_1_reward_3"
        },
        button_forest_1_reward_4 = {
            trigger = "button_trigger_forest_1_reward_4"
        },
        button_forest_1_reward_5 = {
            trigger = "button_trigger_forest_1_reward_5"
        },
    },
}
