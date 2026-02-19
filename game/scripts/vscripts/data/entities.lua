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
            packID = nil,
        },

        spawner_subway_city = {
            npc = "npc_subway_city",
            modifiers = { "modifier_story_npc" },
        },
        spawner_subway_to_city = {
            npc = "npc_subway_to_city",
            modifiers = { "modifier_story_npc" },
        },
        spawner_subway_fake = {
            npc = "npc_subway_fake",
            modifiers = { "modifier_story_npc" },
        },
        spawner_subway_fake_return = {
            npc = "npc_subway_fake_return",
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
            packID = "pack_gorilla",
        },
        spawner_island_creeps = {
            npc = "npc_cat_barrel",
            modifiers = { "modifier_story_npc" },
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
            packID = "pack_gate_trolls",
        },
        spawner_gate_troll_right = {
            npc = "npc_gate_troll_diruk",
            modifiers = { "modifier_story_npc" },
            packID = "pack_gate_trolls",
        },
        spawner_gate_troll_center = {
            npc = "npc_gate_troll_uruk",
            modifiers = { "modifier_story_npc" },
            packID = "pack_gate_trolls",
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
            ai_modifier = "modifier_mk_ai",
        },
        spawner_monkey_king_summon = {
            npc = "npc_monkey_king_summon",
            modifiers = { "modifier_story_npc", "modifier_mk_summon_idle" },
            packID = "pack_monkey_king",
            ai_modifier = "modifier_mk_ai",
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
            packID = "pack_ogre_bruiser",
            ai_modifier = "modifier_ogre_bruiser_ai",
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
            packID = "pack_red",
            ai_modifier = "modifier_default_creep_ai",
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
            modifiers = { "modifier_story_npc" },
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
            packID = "pack_perekup",
        },
        spawner_hermit = {
            npc = "npc_hermit",
            modifiers = { "modifier_story_npc" },
        },
        spawner_dream = {
            npc = "npc_dream",
            modifiers = { "modifier_story_npc" },
            deferred = true,
            packID = "pack_dream_bad_ending",
            ai_modifier = "modifier_default_creep_ai",
        },
        spawner_dream_golden = {
            npc = "npc_dream_golden",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },

        spawner_island_guard = {
            npc = "npc_island_guard",
            modifiers = { "modifier_story_npc" },
            packID = "pack_island_guard",
            ai_modifier = "modifier_island_guard_ai",
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

        spawner_roshan_big = {
            npc = "npc_jungle_roshan",
            modifiers = { "modifier_cust_rosh" },
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_roshan",
            ai_modifier = "modifier_default_creep_ai"
        },
        spawner_miniroshan = {
            npc = "npc_jungle_miniroshan",
            modifiers = { "modifier_cust_rosh" },
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_roshan",
            ai_modifier = "modifier_default_creep_ai"
        },


        spawner_techies_1 = {
            npc = "npc_jungle_techies",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_techies",
            ai_modifier = "modifier_techies_ai"
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
            packID = "pack_genius"
        },

        spawner_concert_fan_ranged = {
            npc = "npc_ghetto_ranged",
            modifiers = { "modifier_story_npc" },
            deferred = true,
            packID = "pack_concert_crowd",
            ai_modifier = "modifier_default_creep_ai",
        },
        spawner_concert_fan_melee = {
            npc = "npc_ghetto_melee",
            modifiers = { "modifier_story_npc" },
            deferred = true,
            packID = "pack_concert_crowd",
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_gangster = {
            npc = "npc_gangster",
            modifiers = { "modifier_story_npc" },
            packID = "pack_ghetto",
            ai_modifier = "modifier_default_creep_ai",
        },
        spawner_ghetto_ranged = {
            npc = "npc_ghetto_ranged",
            modifiers = { "modifier_story_npc" },
            packID = "pack_ghetto",
            ai_modifier = "modifier_default_creep_ai",
        },
        spawner_ghetto_melee = {
            npc = "npc_ghetto_melee",
            modifiers = { "modifier_story_npc" },
            packID = "pack_ghetto",
            ai_modifier = "modifier_default_creep_ai",
        },
        spawner_blue = {
            npc = "npc_blue",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_cat_barrel_city = {
            npc = "npc_cat_barrel",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_island_fiend = {
            npc = "npc_island_fiend",
            modifiers = { "modifier_story_npc" },
            packID = "pack_island_duo",
            ai_modifier = "modifier_default_creep_ai",
        },
        spawner_island_shadow_demon = {
            npc = "npc_island_shadow_demon",
            modifiers = { "modifier_story_npc" },
            packID = "pack_island_duo",
            ai_modifier = "modifier_default_creep_ai",
        },
        spawner_bomb_place = {
            npc = "npc_bomb_place",
            modifiers = { "modifier_story_npc" },
        },
        spawner_bomb = {
            npc = "npc_bomb",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
    },

    ------------------------------------------------------------
    --- Item spawners
    ------------------------------------------------------------
    item_spawner = {
        item_spawner_lean = {
            item = "item_lean"
        }
    },

    ------------------------------------------------------------
    --- Packs
    ------------------------------------------------------------
    pack = {
        __common = {
            spawners = {},
            units = {},
            activateAfterUnitsSpawned = true,
            stayActivatedOnPlayerDeath = false,
            somebodyNear = false,
            rangeFastTickRate = 2000,
            rangeRetreat = 1300,
            rangeAggro = 600,
            currentCreepInterval = BATTLE_THINK_INTERVAL,
            thinker = "default",
            state = "off",

            target = nil,
        },

        pack_forest_act1_lizards = {
            stayActivatedOnPlayerDeath = true
        },

        pack_forest_act1_axe = {
            thinker = "axe",
            denyTarget = nil,
            stayActivatedOnPlayerDeath = true

        },

        pack_forest_act1_roshan = {
            stayActivatedOnPlayerDeath = true
        },

        pack_forest_act1_techies = {
            rangeFastTickRate = 2000,
            rangeAggro = 600,
            stayActivatedOnPlayerDeath = true,
        },

        pack_mk = {
            activateAfterUnitsSpawned = true,
        },

        pack_concert_crowd = {
            rangeFastTickRate = 1300,
            rangeRetreat = 1300,
            rangeAggro = 1300,
            activateAfterUnitsSpawned = false,
        },
        pack_monkey_king = {
            rangeRetreat = 600,
            rangeAggro = 600,
            activateAfterUnitsSpawned = false,
        },
        pack_gate_trolls = {
            rangeRetreat = 1000,
            rangeAggro = 600,
            activateAfterUnitsSpawned = false,
        },
        pack_island_guard = {
            activateAfterUnitsSpawned = false,
            stayActivatedOnPlayerDeath = true,
        },
        pack_island_duo = {
            activateAfterUnitsSpawned = false,
            stayActivatedOnPlayerDeath = true,
        },
        pack_ogre_bruiser = {
            activateAfterUnitsSpawned = false,
        },
        pack_gorilla = {
            activateAfterUnitsSpawned = false,
        },
        pack_red = {
            activateAfterUnitsSpawned = false,
        },
        pack_perekup = {
            activateAfterUnitsSpawned = false,
        },
        pack_genius = {
            activateAfterUnitsSpawned = false,
        },

        pack_ghetto = {
            rangeRetreat = 1300,
            rangeAggro = 1300,
            activateAfterUnitsSpawned = false,
            stayActivatedOnPlayerDeath = true,
        },
        pack_dream_bad_ending = {
            rangeFastTickRate = 9999999,
            rangeRetreat = 9999999,
            rangeAggro = 9999999,
            activateAfterUnitsSpawned = false,
            stayActivatedOnPlayerDeath = true,
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
        },
        npc_island_guard = {
            drop = {
                "item_cage_key",
            }
        },
    },

    ------------------------------------------------------------
    --- Doors
    ------------------------------------------------------------
    door = {
        door_prologue = {
            clipEntity = "clip_door_prologue",
            openAnimation = "cf_palace_door_open",
            openSound = "sfx.door_palace.open",
        },
        door_island_secret = {
            clipEntity = "clip_door_island_secret",
        },
        door_clash_royale = {
            clipEntity = "clip_door_clash_royale",
            openAnimation = "open",
            closeAnimation = "close",
        },
        door_city_forest = {
            clipEntity = "clip_door_city_forest",
            openAnimation = "gate_open",
            closeAnimation = "gate_close",
        },
        door_forest_1_reward = {
            clipEntity = "clip_door_forest_1_reward",
            openAnimation = "cf_palace_door_open",
            openSound = "sfx.door_palace.open",
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
            openSound = "sfx.door_palace.open",
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
        door_ghetto = {
            clipEntity = "clip_door_ghetto"
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
