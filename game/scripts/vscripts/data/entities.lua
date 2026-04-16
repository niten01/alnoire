return {
    ------------------------------------------------------------
    --- Spawners
    ------------------------------------------------------------
    spawner = {
        __common                      = {
            team = DOTA_TEAM_GOODGUYS,
            modifiers = {},
            deferred = false,
            injectedAttributes = {},
            packID = nil,
        },

        spawner_subway_city           = {
            npc = "npc_subway_city",
            modifiers = { "modifier_story_npc" },
        },
        spawner_subway_to_city        = {
            npc = "npc_subway_to_city",
            modifiers = { "modifier_story_npc" },
        },
        spawner_subway_fake           = {
            npc = "npc_subway_fake",
            modifiers = { "modifier_story_npc" },
        },
        spawner_subway_fake_return    = {
            npc = "npc_subway_fake_return",
            modifiers = { "modifier_story_npc" },
        },

        spawner_flask_barrel          = {
            npc = "npc_flask_barrel",
            modifiers = { "modifier_story_npc" },
        },

        spawner_derek_keyhole         = {
            npc = "npc_derek_keyhole",
            modifiers = { "modifier_story_npc" },
        },

        spawner_courier_knight        = { npc = "npc_courier_knight", modifiers = { "modifier_story_npc" } },
        spawner_courier_bug           = { npc = "npc_courier_bug", modifiers = { "modifier_story_npc" } },
        spawner_courier_alkash        = { npc = "npc_courier_alkash", modifiers = { "modifier_story_npc" } },
        spawner_courier_pivo          = { npc = "npc_courier_pivo", modifiers = { "modifier_story_npc" } },
        spawner_courier_chicken       = { npc = "npc_courier_chicken", modifiers = { "modifier_story_npc" } },
        spawner_courier_carpet        = { npc = "npc_courier_carpet", modifiers = { "modifier_story_npc" } },
        spawner_courier_pudge         = { npc = "npc_courier_pudge", modifiers = { "modifier_story_npc" } },
        spawner_courier_hamster       = { npc = "npc_courier_hamster", modifiers = { "modifier_story_npc" } },
        spawner_courier_koala         = { npc = "npc_courier_koala", modifiers = { "modifier_story_npc" } },
        spawner_courier_shopkeeper    = { npc = "npc_courier_shop", modifiers = { "modifier_story_npc" } },
        spawner_courier_cat           = { npc = "npc_courier_cat", modifiers = { "modifier_story_npc" } },
        spawner_courier_drone         = { npc = "npc_courier_drone", modifiers = { "modifier_story_npc" } },
        spawner_courier_donkeys       = { npc = "npc_courier_donkeys", modifiers = { "modifier_story_npc" } },
        spawner_courier_bh            = { npc = "npc_courier_bh", modifiers = { "modifier_story_npc" } },
        spawner_courier_chest         = { npc = "npc_courier_chest", modifiers = { "modifier_story_npc" } },
        spawner_courier_skeleton      = { npc = "npc_courier_skeleton", modifiers = { "modifier_story_npc" } },
        spawner_courier_crocodile     = { npc = "npc_courier_crocodile", modifiers = { "modifier_story_npc" } },
        spawner_courier_sniffer       = { npc = "npc_courier_sniffer", modifiers = { "modifier_story_npc" } },
        spawner_courier_smart         = { npc = "npc_courier_smart", modifiers = { "modifier_story_npc" } },

        spawner_courier_tomato        = { npc = "npc_courier_tomato", modifiers = { "modifier_story_npc" } },
        spawner_courier_psycho        = { npc = "npc_courier_psycho", modifiers = { "modifier_story_npc" } },
        spawner_courier_gardener      = { npc = "npc_courier_gardener", modifiers = { "modifier_story_npc" } },
        spawner_courier_ant           = { npc = "npc_courier_ant", modifiers = { "modifier_story_npc" } },
        spawner_courier_garden_dog    = { npc = "npc_courier_garden_dog", modifiers = { "modifier_story_npc" } },

        spawner_courier_roshanchik    = { npc = "npc_courier_roshanchik", modifiers = { "modifier_story_npc" } },
        spawner_courier_bober         = { npc = "npc_courier_bober", modifiers = { "modifier_story_npc" } },
        spawner_courier_rabbit        = { npc = "npc_courier_rabbit", modifiers = { "modifier_story_npc" } },
        spawner_courier_boar          = { npc = "npc_courier_boar", modifiers = { "modifier_story_npc" } },
        spawner_courier_raccoon       = { npc = "npc_courier_raccoon", modifiers = { "modifier_story_npc" } },
        spawner_courier_parrot        = { npc = "npc_courier_parrot", modifiers = { "modifier_story_npc" } },
        spawner_courier_mushroom_1    = { npc = "npc_courier_mushroom_1", modifiers = { "modifier_story_npc" } },
        spawner_courier_mushroom_2    = { npc = "npc_courier_mushroom_2", modifiers = { "modifier_story_npc" } },
        spawner_courier_mushroom_3    = { npc = "npc_courier_mushroom_3", modifiers = { "modifier_story_npc" } },
        spawner_courier_muhomor       = { npc = "npc_courier_muhomor", modifiers = { "modifier_story_npc" } },
        spawner_courier_plant         = { npc = "npc_courier_plant", modifiers = { "modifier_story_npc" } },
        spawner_courier_octopus_1     = { npc = "npc_courier_octopus_1", modifiers = { "modifier_story_npc" } },
        spawner_courier_octopus_2     = { npc = "npc_courier_octopus_2", modifiers = { "modifier_story_npc" } },
        spawner_courier_purple        = { npc = "npc_courier_purple", modifiers = { "modifier_story_npc" } },
        spawner_courier_sea_horse     = { npc = "npc_courier_sea_horse", modifiers = { "modifier_story_npc" } },
        spawner_courier_turtle        = { npc = "npc_courier_turtle", modifiers = { "modifier_story_npc" } },
        spawner_courier_crab          = { npc = "npc_courier_crab", modifiers = { "modifier_story_npc" } },
        spawner_courier_axolotl       = { npc = "npc_courier_axolotl", modifiers = { "modifier_story_npc" } },
        spawner_courier_navi          = { npc = "npc_courier_navi", modifiers = { "modifier_story_npc" } },
        spawner_courier_cripple_dog   = { npc = "npc_courier_cripple_dog", modifiers = { "modifier_story_npc" } },
        spawner_courier_demon         = { npc = "npc_courier_demon", modifiers = { "modifier_story_npc" } },
        spawner_courier_evil_shop     = { npc = "npc_courier_evil_shop", modifiers = { "modifier_story_npc" } },
        spawner_courier_doom          = { npc = "npc_courier_doom", modifiers = { "modifier_story_npc" } },
        spawner_courier_statue        = { npc = "npc_courier_statue", modifiers = { "modifier_story_npc" } },
        spawner_courier_bones         = { npc = "npc_courier_bones", modifiers = { "modifier_story_npc" } },
        spawner_courier_babka_2       = { npc = "npc_courier_babka_2", modifiers = { "modifier_story_npc" } },
        spawner_courier_blue_frog     = { npc = "npc_courier_blue_frog", modifiers = { "modifier_story_npc" } },
        spawner_courier_pig           = { npc = "npc_courier_pig", modifiers = { "modifier_story_npc" } },
        spawner_courier_furion        = { npc = "npc_courier_furion", modifiers = { "modifier_story_npc" } },

        spawner_courier_winter_cat    = { npc = "npc_courier_winter_cat", modifiers = { "modifier_story_npc" } },

        spawner_courier_aghanim       = { npc = "npc_courier_aghanim", modifiers = { "modifier_story_npc" } },
        spawner_courier_grandpa       = { npc = "npc_courier_grandpa", modifiers = { "modifier_story_npc" } },
        spawner_courier_gold_hamster  = { npc = "npc_courier_gold_hamster", modifiers = { "modifier_story_npc" } },
        spawner_courier_gold_cat      = { npc = "npc_courier_gold_cat", modifiers = { "modifier_story_npc" } },
        spawner_courier_gold_wizard   = { npc = "npc_courier_gold_wizard", modifiers = { "modifier_story_npc" } },
        spawner_courier_blue_zombie   = { npc = "npc_courier_blue_zombie", modifiers = { "modifier_story_npc" } },
        spawner_courier_taksa         = { npc = "npc_courier_taksa", modifiers = { "modifier_story_npc" } },
        spawner_courier_demon_book    = { npc = "npc_courier_demon_book", modifiers = { "modifier_story_npc" } },
        spawner_courier_gold_dp       = { npc = "npc_courier_gold_dp", modifiers = { "modifier_story_npc" } },
        spawner_courier_black_wizard  = { npc = "npc_courier_black_wizard", modifiers = { "modifier_story_npc" } },
        spawner_courier_pudge_dog     = { npc = "npc_courier_pudge_dog", modifiers = { "modifier_story_npc" } },

        spawner_xavier                = {
            npc = "npc_xavier",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_xavier_ending         = {
            npc = "npc_xavier",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_shooter_1             = {
            npc = "npc_shooter",
            deferred = true,
            modifiers = { "modifier_story_npc" },
            ai_modifier = "modifier_shooter_ai",
            packID = "pack_shooter_classroom",
            team = DOTA_TEAM_BADGUYS,
        },
        spawner_shooter_ending        = {
            npc = "npc_shooter_ending",
            deferred = true,
            modifiers = { "modifier_story_npc" },
            ai_modifier = "modifier_shooter_ending_ai",
            packID = "pack_shooter_classroom",
            team = DOTA_TEAM_BADGUYS,
        },
        spawner_shooter_hall_1        = {
            npc = "npc_shooter_ending_mini",
            deferred = true,
            ai_modifier = "modifier_default_creep_ai",
            packID = "pack_shooter_hall_1",
            team = DOTA_TEAM_BADGUYS,
        },
        spawner_shooter_hall_2        = {
            npc = "npc_shooter_ending_mini",
            deferred = true,
            ai_modifier = "modifier_default_creep_ai",
            packID = "pack_shooter_hall_2",
            team = DOTA_TEAM_BADGUYS,
        },
        spawner_shooter_hall_3        = {
            npc = "npc_shooter_ending_mini",
            deferred = true,
            ai_modifier = "modifier_default_creep_ai",
            packID = "pack_shooter_hall_3",
            team = DOTA_TEAM_BADGUYS,
        },
        spawner_gorilla               = {
            npc = "npc_gorilla",
            modifiers = { "modifier_story_npc", "modifier_gorilla_invulnerable" },
            deferred = true,
            packID = "pack_gorilla",
            ai_modifier = "modifier_gorilla_ai",
        },
        spawner_island_creeps         = {
            npc = "npc_cat_barrel",
            modifiers = { "modifier_story_npc" },
        },
        spawner_blue_prince           = {
            npc = "npc_blue_prince",
            modifiers = { "modifier_story_npc" },
        },
        spawner_tormentor             = {
            npc = "npc_tormentor",
            modifiers = { "modifier_story_npc" },
        },
        spawner_shamanka              = {
            npc = "npc_shamanka",
            modifiers = { "modifier_story_npc" },
        },
        spawner_gate_troll_left       = {
            npc = "npc_gate_troll_biruk",
            modifiers = { "modifier_story_npc" },
            packID = "pack_gate_trolls",
            ai_modifier = "modifier_default_creep_ai",
        },
        spawner_gate_troll_right      = {
            npc = "npc_gate_troll_diruk",
            modifiers = { "modifier_story_npc" },
            packID = "pack_gate_trolls",
            ai_modifier = "modifier_default_creep_ai",
        },
        spawner_gate_troll_center     = {
            npc = "npc_gate_troll_uruk",
            modifiers = { "modifier_story_npc" },
            packID = "pack_gate_trolls",
            ai_modifier = "modifier_default_creep_ai",
        },
        spawner_guide_city_entrance   = {
            npc = "npc_guide",
            modifiers = { "modifier_story_npc" },
        },
        spawner_guide_forest_entrance = {
            npc = "npc_guide",
            deferred = true,
            modifiers = { "modifier_story_npc" },
        },
        spawner_guide_finale          = {
            npc = "npc_guide",
            deferred = true,
            modifiers = { "modifier_story_npc" },
        },
        spawner_creep_rogach          = {
            npc = "npc_creep_rogach",
            modifiers = { "modifier_story_npc" },
        },
        spawner_creep_bob             = {
            npc = "npc_creep_bob",
            modifiers = { "modifier_story_npc" },
        },
        spawner_mustache              = {
            npc = "npc_mustache",
            modifiers = { "modifier_story_npc" },
        },
        spawner_monkey_king           = {
            npc = "npc_monkey_king",
            modifiers = { "modifier_story_npc" },
            packID = "pack_monkey_king",
            ai_modifier = "modifier_mk_ai",
        },
        spawner_monkey_king_summon    = {
            npc = "npc_monkey_king_summon",
            modifiers = { "modifier_story_npc", "modifier_mk_summon_idle" },
            packID = "pack_monkey_king",
            ai_modifier = "modifier_mk_ai",
        },
        spawner_brewmaster            = {
            npc = "npc_brewmaster",
            modifiers = { "modifier_story_npc" },
        },
        spawner_brewmaster_good       = {
            npc = "npc_brewmaster_good",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_brewmaster_minigame   = {
            npc = "npc_brewmaster_good",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_ogre_magi             = {
            npc = "npc_ogre_magi",
            modifiers = { "modifier_story_npc" },
        },
        spawner_ogre_bruiser          = {
            npc = "npc_ogre_bruiser",
            modifiers = { "modifier_story_npc" },
            packID = "pack_ogre_bruiser",
            ai_modifier = "modifier_ogre_bruiser_ai",
        },
        spawner_rape_victim           = {
            npc = "npc_rape_victim",
            modifiers = { "modifier_story_npc" },
        },
        spawner_rape_victim_2         = {
            npc = "npc_rape_victim",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_predvestnik           = {
            npc = "npc_predvestnik",
            modifiers = { "modifier_story_npc" },
        },
        spawner_mystery               = {
            npc = "npc_mystery",
            modifiers = { "modifier_story_npc" },
        },
        spawner_mystery_2             = {
            npc = "npc_mystery",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_templar_assasin       = {
            npc = "npc_templar_assasin",
            modifiers = { "modifier_story_npc" },
        },
        spawner_alchemist             = {
            npc = "npc_alchemist",
            modifiers = { "modifier_story_npc" },
        },
        spawner_scientist             = {
            npc = "npc_scientist",
            modifiers = { "modifier_story_npc" },
        },
        spawner_training_dummy        = {
            npc = "npc_training_dummy",
            modifiers = { "modifier_training_dummy", "modifier_immobile" },
            team = DOTA_TEAM_BADGUYS,
        },
        spawner_red                   = {
            npc = "npc_red",
            modifiers = { "modifier_story_npc" },
            deferred = true,
            packID = "pack_red",
            ai_modifier = "modifier_red_ai",
        },
        spawner_green                 = {
            npc = "npc_green",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_concert_guard         = {
            npc = "npc_concert_guard",
            modifiers = { "modifier_story_npc" },
        },
        spawner_trap_arrow            = {
            npc = "npc_trap_arrow",
            team = DOTA_TEAM_BADGUYS,
            modifiers = { "modifier_story_npc" },
            injectedAttributes = { "trap_delay", "trap_interval", "trap_speed" }
        },
        spawner_trap_fire             = {
            npc = "npc_trap_fire",
            team = DOTA_TEAM_BADGUYS,
            modifiers = { "modifier_story_npc" },
            injectedAttributes = { "trap_delay", "trap_interval" }
        },
        spawner_trap_spikes           = {
            npc = "npc_trap_spikes",
            team = DOTA_TEAM_BADGUYS,
            -- modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_trap_fake_spikes      = {
            npc = "npc_trap_fake_spikes",
            team = DOTA_TEAM_BADGUYS,
            -- modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_trap_pendulum         = {
            npc = "npc_trap_pendulum",
            team = DOTA_TEAM_BADGUYS,
            modifiers = { "modifier_story_npc" },
            injectedAttributes = { "trap_delay", "trap_speed" }
        },
        spawner_trap_skeleton         = {
            npc = "npc_trap_skeleton",
            team = DOTA_TEAM_BADGUYS,
            modifiers = { "modifier_story_npc" },
        },
        spawner_storyteller           = {
            npc = "npc_storyteller",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_wasteland             = {
            npc = "npc_wasteland",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_leader                = {
            npc = "npc_leader",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_perekup               = {
            npc = "npc_perekup",
            modifiers = { "modifier_story_npc", "modifier_immobile" },
            packID = "pack_perekup",
            ai_modifier = "modifier_perekup_ai",
        },
        spawner_hermit                = {
            npc = "npc_hermit",
            modifiers = { "modifier_story_npc" },
        },
        spawner_dream                 = {
            npc = "npc_dream",
            modifiers = { "modifier_story_npc" },
            deferred = true,
            packID = "pack_dream_bad_ending",
            ai_modifier = "modifier_default_creep_ai",
        },
        spawner_dream_golden          = {
            npc = "npc_dream_golden",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },

        spawner_island_guard          = {
            npc = "npc_island_guard",
            modifiers = { "modifier_story_npc", "modifier_immobile" },
            packID = "pack_island_guard",
            ai_modifier = "modifier_island_guard_ai",
        },
        spawner_goden                 = {
            npc = "npc_goden",
            packID = "pack_goden",
            ai_modifier = "modifier_goden_ai",
            team = DOTA_TEAM_BADGUYS,
        },
        spawner_goden_summon_1        = {
            npc = "npc_goden_summon",
            packID = "pack_goden",
            ai_modifier = "modifier_default_creep_ai",
            team = DOTA_TEAM_BADGUYS,
            deferred = true,
        },
        spawner_goden_summon_2        = {
            npc = "npc_goden_summon",
            packID = "pack_goden",
            ai_modifier = "modifier_default_creep_ai",
            team = DOTA_TEAM_BADGUYS,
            deferred = true,
        },
        spawner_goden_summon_3        = {
            npc = "npc_goden_summon",
            packID = "pack_goden",
            ai_modifier = "modifier_default_creep_ai",
            team = DOTA_TEAM_BADGUYS,
            deferred = true,
        },
        spawner_goden_summon_4        = {
            npc = "npc_goden_summon",
            packID = "pack_goden",
            ai_modifier = "modifier_default_creep_ai",
            team = DOTA_TEAM_BADGUYS,
            deferred = true,
        },
        spawner_goden_summon_5        = {
            npc = "npc_goden_summon",
            packID = "pack_goden",
            ai_modifier = "modifier_default_creep_ai",
            team = DOTA_TEAM_BADGUYS,
            deferred = true,
        },
        spawner_ball                  = {
            npc = "npc_ball",
            packID = "pack_ball",
            ai_modifier = "modifier_ball_ai",
            -- modifiers = { "modifier_ball_slide" },
            team = DOTA_TEAM_BADGUYS,
        },
        spawner_chaser                = {
            npc = "npc_chaser_final",
            packID = "pack_chaser",
            ai_modifier = "modifier_chaser_final_ai",
            team = DOTA_TEAM_BADGUYS,
        },
        spawner_chaser_stuns          = {
            npc = "npc_chaser",
            packID = "pack_desert_act4_viperstealer",
            ai_modifier = "modifier_chaser_stuns_ai",
            modifiers = { "modifier_generic_unkillable" },
            team = DOTA_TEAM_BADGUYS,
        },
        spawner_chaser_rites          = {
            npc = "npc_chaser",
            packID = "pack_desert_act4_dire_creeps",
            ai_modifier = "modifier_chaser_rites_ai",
            modifiers = { "modifier_generic_unkillable", "modifier_desert_dire_animation" },
            team = DOTA_TEAM_BADGUYS,
        },

        spawner_derek                 = {
            npc = "npc_derek",
            packID = "pack_derek",
            ai_modifier = "modifier_derek_ai",
            modifiers = { "modifier_story_npc" },
        },
        spawner_george                = {
            npc = "npc_george",
            packID = "pack_george",
            ai_modifier = "modifier_george_ai",
            modifiers = { "modifier_story_npc" },
        },
        spawner_george_summon         = {
            npc = "npc_george_summon",
            packID = "pack_george",
            ai_modifier = "modifier_default_creep_ai",
            deferred = true,
            team = DOTA_TEAM_BADGUYS,
        },

        -- jungle
        spawner_lizards_venomancer    = {
            npc = "npc_jungle_venomancer",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_lizards",
            ai_modifier = "modifier_default_creep_ai"
        },
        spawner_lizards_creep_melee   = {
            npc = "npc_jungle_creep_melee",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_lizards",
            ai_modifier = "modifier_default_creep_ai"
        },
        spawner_lizards_creep_range   = {
            npc = "npc_jungle_creep_range",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_lizards",
            ai_modifier = "modifier_default_creep_ai"
        },

        spawner_pomidorko             = {
            npc = "npc_jungle_pomidorko",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_bears",
            ai_modifier = "modifier_default_creep_ai"
        },
        spawner_icebear               = {
            npc = "npc_jungle_icebear",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_bears",
            ai_modifier = "modifier_default_creep_ai"
        },
        spawner_bufferbear            = {
            npc = "npc_jungle_bufferbear",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_bears",
            ai_modifier = "modifier_bufferbear_ai"
        },

        spawner_apple_melee           = {
            npc = "npc_jungle_apple_melee",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_apples",
            ai_modifier = "modifier_default_creep_ai"
        },

        spawner_apple_ranged          = {
            npc = "npc_jungle_apple_ranged",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_apples",
            ai_modifier = "modifier_default_creep_ai"
        },

        spawner_axe_axe               = {
            npc = "npc_jungle_axe",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_axe",
            ai_modifier = "modifier_axe_ai"
        },
        spawner_axe_sisipisi          = {
            npc = "npc_jungle_sisipisi",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_axe",
            ai_modifier = "modifier_default_creep_ai"
        },

        spawner_roshan_big            = {
            npc = "npc_jungle_roshan",
            modifiers = { "modifier_cust_rosh" },
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_roshan",
            ai_modifier = "modifier_default_creep_ai",
        },
        spawner_miniroshan            = {
            npc = "npc_jungle_miniroshan",
            modifiers = { "modifier_cust_rosh" },
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_roshan",
            ai_modifier = "modifier_default_creep_ai",
        },


        spawner_techies_1             = {
            npc = "npc_jungle_techies_1",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_techies_1",
            ai_modifier = "modifier_techies_ai"
        },
        spawner_techies_2             = {
            npc = "npc_jungle_techies_2",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_techies_2",
            ai_modifier = "modifier_techies_ai"
        },
        spawner_techies_3             = {
            npc = "npc_jungle_techies_3",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_techies_3",
            ai_modifier = "modifier_techies_ai"
        },
        spawner_shroom_melee          = {
            npc = "npc_jungle_shroom_melee",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_shrooms",
            ai_modifier = "modifier_shrooms_ai"
        },
        spawner_shroom_ranged         = {
            npc = "npc_jungle_shroom_ranged",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_shrooms",
            ai_modifier = "modifier_shrooms_ai"
        },
        spawner_shroom_furion         = {
            npc = "npc_jungle_shroom_furion",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_shrooms",
            ai_modifier = "modifier_shrooms_furion_ai"
        },

        spawner_gnoll                 = {
            npc = "npc_jungle_gnoll",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_dragnolls",
            ai_modifier = "modifier_default_creep_ai"
        },

        spawner_ancdragon             = {
            npc = "npc_jungle_ancdragon",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_dragnolls",
            ai_modifier = "modifier_default_creep_ai"
        },

        spawner_perdun                = {
            npc = "npc_jungle_perdun",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_perdun",
            ai_modifier = "modifier_default_creep_ai"
        },

        spawner_perdun_flower         = {
            npc = "npc_jungle_perdun_flower",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_forest_act1_perdun",
            ai_modifier = "modifier_default_creep_ai"
        },

        spawner_ocean_creep           = {
            npc = "npc_ocean_creep_range",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_catapa",
            ai_modifier = "modifier_default_creep_ai"
        },
        spawner_ocean_siege           = {
            npc = "npc_ocean_siege",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_catapa",
            ai_modifier = "modifier_default_creep_ai"
        },

        spawner_tusik_mini_a          = {
            npc = "npc_ocean_tusik_mini_a",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_tusiki",
            ai_modifier = "modifier_tusik_uppercut_ai"
        },

        spawner_tusik_mini_b_1        = {
            npc = "npc_ocean_tusik_mini_b_1",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_tusiki",
            ai_modifier = "modifier_tusik_shard_ai"
        },

        spawner_tusik_mini_b_2        = {
            npc = "npc_ocean_tusik_mini_b_2",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_tusiki",
            ai_modifier = "modifier_tusik_shard_ai"
        },

        spawner_tusik_papa            = {
            npc = "npc_ocean_tusik_papa",
            modifiers = { "modifier_tusik_papa_hide" },
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_tusiki",
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_tadpole_ranged_1      = {
            npc = "npc_ocean_tadpole_ranged_1",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_tadpoles_ranged",
            ai_modifier = "modifier_tadpole_ranged_ai",
        },

        spawner_tadpole_ranged_2      = {
            npc = "npc_ocean_tadpole_ranged_2",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_tadpoles_ranged",
            ai_modifier = "modifier_tadpole_ranged_ai",
        },

        spawner_tadpole_ranged_3      = {
            npc = "npc_ocean_tadpole_ranged_3",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_tadpoles_ranged",
            ai_modifier = "modifier_tadpole_ranged_ai",
        },

        spawner_tadpole_big_melee     = {
            npc = "npc_ocean_tadpole_big_melee",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_tadpoles_big",
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_tadpole_big_range_1   = {
            npc = "npc_ocean_tadpole_big_range_1",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_tadpoles_big",
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_tadpole_big_range_2   = {
            npc = "npc_ocean_tadpole_big_range_2",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_tadpoles_big",
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_spider_fire           = {
            npc = "npc_ocean_spider_fire",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_spiders",
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_spider_ice            = {
            npc = "npc_ocean_spider_ice",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_spiders",
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_arbuz                 = {
            npc = "npc_ocean_tidehunter",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_arbuz",
            ai_modifier = "modifier_default_creep_ai",
            modifiers = { "modifier_item_aghanims_shard" }
        },

        spawner_seledka               = {
            npc = "npc_ocean_seledka",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_seledka",
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_morph_big             = {
            npc = "npc_ocean_morph_big",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_morphs",
            ai_modifier = "modifier_default_creep_ai",
            modifiers = { "modifier_morph_big" }
        },

        spawner_morph_small           = {
            npc = "npc_ocean_morph_small",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_morphs",
            ai_modifier = "modifier_morph_small_ai",
            modifiers = { "modifier_morph_small" }
        },

        spawner_slark                 = {
            npc = "npc_ocean_SLARK",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_slark",
            ai_modifier = "modifier_slark_ai",
        },

        spawner_bomber_melee_1        = {
            npc = "npc_ocean_bombardier_melee_1",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_bombers",
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_bomber_melee_2        = {
            npc = "npc_ocean_bombardier_melee_2",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_bombers",
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_bomber_ranged         = {
            npc = "npc_ocean_bombardier_ranged",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_ocean_act2_bombers",
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_dark_drow             = {
            npc = "npc_dark_drow",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_drow",
            ai_modifier = "modifier_dark_drow_ai",
        },

        spawner_dark_ursa             = {
            npc = "npc_dark_ursa",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_ursa",
            ai_modifier = "modifier_dark_ursa_ai",
        },

        spawner_dark_titan_1          = {
            npc = "npc_dark_titan_1",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_titans",
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_dark_titan_2          = {
            npc = "npc_dark_titan_2",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_titans",
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_dark_pudge            = {
            npc = "npc_dark_pudge",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_pupu",
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_dark_pugna            = {
            npc = "npc_dark_pugna",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_pupu",
            ai_modifier = "modifier_dark_pugna_ai",
        },

        spawner_dark_greevil_first_1  = {
            npc = "npc_dark_greevil",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_greevils",
            ai_modifier = "modifier_dark_greevil_ai",
        },
        spawner_dark_greevil_first_2  = {
            npc = "npc_dark_greevil",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_greevils",
            ai_modifier = "modifier_dark_greevil_ai",
        },
        spawner_dark_greevil_first_3  = {
            npc = "npc_dark_greevil",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_greevils",
            ai_modifier = "modifier_dark_greevil_ai",
        },
        spawner_dark_greevil_first_4  = {
            npc = "npc_dark_greevil",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_greevils",
            ai_modifier = "modifier_dark_greevil_ai",
        },
        spawner_dark_greevil_first_5  = {
            npc = "npc_dark_greevil",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_greevils",
            ai_modifier = "modifier_dark_greevil_ai",
        },
        spawner_dark_greevil_second_1 = {
            npc = "npc_dark_greevil",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_greevils",
            ai_modifier = "modifier_dark_greevil_ai",
        },
        spawner_dark_greevil_second_2 = {
            npc = "npc_dark_greevil",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_greevils",
            ai_modifier = "modifier_dark_greevil_ai",
        },
        spawner_dark_greevil_second_3 = {
            npc = "npc_dark_greevil",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_greevils",
            ai_modifier = "modifier_dark_greevil_ai",
        },
        spawner_dark_greevil_second_4 = {
            npc = "npc_dark_greevil",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_greevils",
            ai_modifier = "modifier_dark_greevil_ai",
        },
        spawner_dark_greevil_second_5 = {
            npc = "npc_dark_greevil",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_greevils",
            ai_modifier = "modifier_dark_greevil_ai",
        },
        spawner_dark_shaker_1         = {
            npc = "npc_dark_shaker_1",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_shakers",
            ai_modifier = "modifier_dark_shaker_ai",
            modifiers = { 'modifier_item_ultimate_scepter' }
        },
        spawner_dark_shaker_2         = {
            npc = "npc_dark_shaker_2",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_shakers",
            ai_modifier = "modifier_dark_shaker_ai",
            modifiers = { 'modifier_item_ultimate_scepter' }
        },

        spawner_dark_shaker_3         = {
            npc = "npc_dark_shaker_3",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_shakers",
            ai_modifier = "modifier_dark_shaker_ai",
            modifiers = { 'modifier_item_ultimate_scepter' }
        },

        spawner_dark_treant           = {
            npc = "npc_dark_treant",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_darkforest_act3_treant",
            ai_modifier = "modifier_dark_treant_ai",
        },

        spawner_desert_nyx_1          = {
            npc = "npc_desert_nyx_1",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_desert_act4_nyxs",
            ai_modifier = "modifier_desert_nyx_ai",
        },

        spawner_desert_nyx_2          = {
            npc = "npc_desert_nyx_2",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_desert_act4_nyxs",
            ai_modifier = "modifier_desert_nyx_ai",
        },

        spawner_desert_nyx_3          = {
            npc = "npc_desert_nyx_3",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_desert_act4_nyxs",
            ai_modifier = "modifier_desert_nyx_ai",
        },

        spawner_desert_viper          = {
            npc = "npc_desert_viper",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_desert_act4_viperstealer",
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_desert_lifestealer    = {
            npc = "npc_desert_lifestealer",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_desert_act4_viperstealer",
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_desert_huskar         = {
            npc = "npc_desert_huskar",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_desert_act4_trollhuskar",
            ai_modifier = "modifier_desert_huskar_ai",
        },

        spawner_desert_troll          = {
            npc = "npc_desert_troll",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_desert_act4_trollhuskar",
            modifiers = { 'modifier_desert_troll' },
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_desert_dire_melee     = {
            npc = "npc_desert_dire_melee",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_desert_act4_dire_creeps",
            modifiers = { "modifier_desert_dire_animation" },
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_desert_dire_range     = {
            npc = "npc_desert_dire_range",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_desert_act4_dire_creeps",
            modifiers = { "modifier_desert_dire_animation" },
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_desert_dire_siege     = {
            npc = "npc_desert_dire_siege",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_desert_act4_dire_creeps",
            modifiers = { "modifier_desert_dire_animation" },
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_desert_dire_siege_dj  = {
            npc = "npc_desert_dire_siege",
            team = DOTA_TEAM_BADGUYS,
            packID = "pack_desert_act4_dire_creeps",
            modifiers = { "modifier_siege_dj", "modifier_desert_dire_animation" },
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_dream_concert         = {
            npc = "npc_dream",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_genius                = {
            npc = "npc_genius",
            modifiers = { "modifier_story_npc" },
            deferred = true,
            packID = "pack_genius",
            ai_modifier = "modifier_genius_ai",
        },

        spawner_concert_fan_ranged    = {
            npc = "npc_ghetto_ranged",
            modifiers = { "modifier_story_npc" },
            deferred = true,
            packID = "pack_concert_crowd",
            ai_modifier = "modifier_default_creep_ai",
        },
        spawner_concert_fan_melee     = {
            npc = "npc_ghetto_melee",
            modifiers = { "modifier_story_npc" },
            deferred = true,
            packID = "pack_concert_crowd",
            ai_modifier = "modifier_default_creep_ai",
        },
        spawner_concert_lina          = {
            npc = "npc_concert_lina",
            modifiers = { "modifier_story_npc" },
            deferred = true,
            packID = "pack_concert_crowd",
            ai_modifier = "modifier_default_creep_ai",
        },
        spawner_concert_legion        = {
            npc = "npc_concert_legion",
            modifiers = { "modifier_story_npc" },
            deferred = true,
            packID = "pack_concert_crowd",
            ai_modifier = "modifier_default_creep_ai",
        },
        spawner_concert_meepo         = {
            npc = "npc_concert_meepo",
            modifiers = { "modifier_story_npc" },
            deferred = true,
            packID = "pack_concert_crowd",
            ai_modifier = "modifier_default_creep_ai",
        },
        spawner_concert_wk            = {
            npc = "npc_concert_wk",
            modifiers = { "modifier_story_npc" },
            deferred = true,
            packID = "pack_concert_crowd",
            ai_modifier = "modifier_default_creep_ai",
        },

        spawner_gangster              = {
            npc = "npc_gangster",
            modifiers = { "modifier_story_npc" },
            packID = "pack_ghetto",
            ai_modifier = "modifier_default_creep_ai",
            deferred = true,
        },
        spawner_gangster_3            = {
            npc = "npc_gangster",
            modifiers = { "modifier_story_npc" },
            packID = "pack_ghetto_3",
            ai_modifier = "modifier_default_creep_ai",
            deferred = true,
        },
        spawner_ghetto_ranged         = {
            npc = "npc_ghetto_ranged",
            modifiers = { "modifier_story_npc" },
            packID = "pack_ghetto",
            ai_modifier = "modifier_default_creep_ai",
            deferred = true,
        },
        spawner_ghetto_melee          = {
            npc = "npc_ghetto_melee",
            modifiers = { "modifier_story_npc" },
            packID = "pack_ghetto",
            ai_modifier = "modifier_default_creep_ai",
            deferred = true,
        },
        spawner_gangster_2            = {
            npc = "npc_gangster",
            modifiers = { "modifier_story_npc" },
            packID = "pack_ghetto_2",
            ai_modifier = "modifier_default_creep_ai",
            deferred = true,
        },
        spawner_ghetto_ranged_2       = {
            npc = "npc_ghetto_ranged",
            modifiers = { "modifier_story_npc" },
            packID = "pack_ghetto_2",
            ai_modifier = "modifier_default_creep_ai",
            deferred = true,
        },
        spawner_ghetto_melee_2        = {
            npc = "npc_ghetto_melee",
            modifiers = { "modifier_story_npc" },
            packID = "pack_ghetto_2",
            ai_modifier = "modifier_default_creep_ai",
            deferred = true,
        },
        spawner_ghetto_ranged_3       = {
            npc = "npc_ghetto_ranged",
            modifiers = { "modifier_story_npc" },
            packID = "pack_ghetto_3",
            ai_modifier = "modifier_default_creep_ai",
            deferred = true,
        },
        spawner_ghetto_melee_3        = {
            npc = "npc_ghetto_melee",
            modifiers = { "modifier_story_npc" },
            packID = "pack_ghetto_3",
            ai_modifier = "modifier_default_creep_ai",
            deferred = true,
        },
        spawner_blue                  = {
            npc = "npc_blue",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_cat_barrel_city       = {
            npc = "npc_cat_barrel",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_island_fiend          = {
            npc = "npc_island_fiend",
            modifiers = { "modifier_story_npc", "modifier_generic_unkillable" },
            packID = "pack_island_duo",
            ai_modifier = "modifier_island_fiend_ai",
        },
        spawner_island_demon          = {
            npc = "npc_island_demon",
            modifiers = { "modifier_story_npc", "modifier_generic_unkillable" },
            packID = "pack_island_duo",
            ai_modifier = "modifier_island_demon_ai",
        },
        spawner_island_demon_illusion = {
            npc = "npc_island_demon_illusion",
            modifiers = {},
            -- is linked manually
            -- packID = "pack_island_duo",
            ai_modifier = "modifier_island_demon_illusion_ai",
            team = DOTA_TEAM_BADGUYS,
            deferred = true,
        },
        spawner_bomb_place            = {
            npc = "npc_bomb_place",
            modifiers = { "modifier_story_npc" },
        },
        spawner_bomb                  = {
            npc = "npc_bomb",
            modifiers = { "modifier_story_npc" },
            deferred = true,
        },
        spawner_killer                = {
            npc = "npc_killer",
            modifiers = { "modifier_story_npc" },
            packID = "pack_killer",
            ai_modifier = "modifier_killer_ai",
            deferred = true,
        },
    },

    ------------------------------------------------------------
    --- Item spawners
    ------------------------------------------------------------
    item_spawner = {
        item_spawner_lean = {
            item = "item_lean",
        },
        item_spawner_seed = {
            item = "item_sanya_flask_seed",
        },
        item_spawner_egg = {
            item = "item_tough_egg",
        },
        item_spawner_poison_note = {
            item = "item_poison_note",
        },
        item_spawner_first_note = {
            item = "item_first_note",
        },
        item_spawner_flask = {
            item = "item_sanya_flask",
        },
        item_spawner_ski = {
            item = "item_ski",
        },
        item_spawner_key_part_1 = {
            item = "item_key_part_1",
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
            stayActivatedOnPlayerDeath = false,
            somebodyNear = false,
            rangeFastTickRate = 2000,
            rangeRetreat = 1300,
            rangeAggro = 600,
            currentCreepInterval = BATTLE_THINK_INTERVAL,
            thinker = "default",
            state = "off",

            target = nil,
            music = nil,
            doors = {},
            xpBounty = 0,
            goldBounty = 0,
            refillsFlask = true,
        },

        pack_shooter_classroom = {
            activateAfterUnitsSpawned = false,
            stayActivatedOnPlayerDeath = true,
            rangeFastTickRate = 1600,
            rangeRetreat = 5400,
            rangeAggro = 1000,
        },
        pack_shooter_hall_1 = {
            activateAfterUnitsSpawned = false,
            stayActivatedOnPlayerDeath = true,
            rangeFastTickRate = 3000,
            rangeRetreat = 3000,
            rangeAggro = 1000,
        },
        pack_shooter_hall_2 = {
            activateAfterUnitsSpawned = false,
            stayActivatedOnPlayerDeath = true,
            rangeFastTickRate = 3000,
            rangeRetreat = 3000,
            rangeAggro = 1000,
        },
        pack_shooter_hall_3 = {
            activateAfterUnitsSpawned = false,
            stayActivatedOnPlayerDeath = true,
            rangeFastTickRate = 3000,
            rangeRetreat = 3000,
            rangeAggro = 1000,
        },

        pack_forest_act1_lizards = {
            stayActivatedOnPlayerDeath = true,
            rangeFastTickRate = 6500,
            rangeRetreat = 5400,
            rangeAggro = 1000,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_forest_act1_bears = {
            stayActivatedOnPlayerDeath = true,
            rangeFastTickRate = 2000,
            rangeRetreat = 1150,
            rangeAggro = 700,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_forest_act1_apples = {
            stayActivatedOnPlayerDeath = true,
            rangeFastTickRate = 2400,
            rangeRetreat = 1600,
            rangeAggro = 900,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_forest_act1_axe = {
            stayActivatedOnPlayerDeath = true,
            rangeFastTickRate = 1500,
            rangeRetreat = 1000,
            rangeAggro = 800,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_forest_act1_roshan = {
            stayActivatedOnPlayerDeath = true,
            rangeFastTickRate = 1500,
            rangeRetreat = 900,
            rangeAggro = 750,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_forest_act1_techies_1 = {
            rangeFastTickRate = 900,
            rangeAggro = 300,
            rangeRetreat = 500,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 0.5,
            goldBounty = 50,
        },
        pack_forest_act1_techies_2 = {
            rangeFastTickRate = 900,
            rangeAggro = 300,
            rangeRetreat = 500,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 0.5,
            goldBounty = 50,
        },
        pack_forest_act1_techies_3 = {
            rangeFastTickRate = 900,
            rangeAggro = 300,
            rangeRetreat = 500,
            stayActivatedOnPlayerDeath = true,
        },

        pack_forest_act1_shrooms = {
            rangeFastTickRate = 1400,
            rangeAggro = 600,
            rangeRetreat = 900,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_forest_act1_dragnolls = {
            rangeFastTickRate = 1900,
            rangeAggro = 950,
            rangeRetreat = 1300,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_forest_act1_perdun = {
            rangeFastTickRate = 1500,
            rangeRetreat = 1000,
            rangeAggro = 600,
            stayActivatedOnPlayerDeath = true,
            flower = "npc_jungle_perdun_flower",
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_ocean_act2_catapa = {
            rangeFastTickRate = 3500,
            rangeRetreat = 2500,
            rangeAggro = 1800,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_ocean_act2_tusiki = {
            rangeFastTickRate = 3500,
            rangeRetreat = 2400,
            rangeAggro = 700,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_ocean_act2_tadpoles_ranged = {
            rangeFastTickRate = 4500,
            rangeRetreat = 3000,
            rangeAggro = 840,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_ocean_act2_tadpoles_big = {
            rangeFastTickRate = 4300,
            rangeRetreat = 2800,
            rangeAggro = 530,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_ocean_act2_spiders = {
            rangeFastTickRate = 2000,
            rangeRetreat = 1300,
            rangeAggro = 800,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_ocean_act2_arbuz = {
            rangeFastTickRate = 3700,
            rangeRetreat = 1900,
            rangeAggro = 650,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_ocean_act2_seledka = {
            rangeFastTickRate = 4000,
            rangeRetreat = 2200,
            rangeAggro = 650,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_ocean_act2_morphs = {
            rangeFastTickRate = 4000,
            rangeRetreat = 2300,
            rangeAggro = 650,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_ocean_act2_slark = {
            rangeFastTickRate = 900,
            rangeRetreat = 350,
            rangeAggro = 300,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_ocean_act2_bombers = {
            rangeFastTickRate = 5000,
            rangeRetreat = 9999999,
            rangeAggro = 350,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_darkforest_act3_drow = {
            rangeFastTickRate = 2000,
            rangeRetreat = 1400,
            rangeAggro = 650,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 200,
        },

        pack_darkforest_act3_ursa = {
            rangeFastTickRate = 6000,
            rangeRetreat = 4000,
            rangeAggro = 750,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 200,
        },

        pack_darkforest_act3_titans = {
            rangeFastTickRate = 2500,
            rangeRetreat = 1300,
            rangeAggro = 1100,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 200,
        },

        pack_darkforest_act3_pupu = {
            rangeFastTickRate = 3000,
            rangeRetreat = 1700,
            rangeAggro = 1000,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 200,
        },

        pack_darkforest_act3_greevils = {
            rangeFastTickRate = 3200,
            rangeRetreat = 2200,
            rangeAggro = 1000,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 200,
        },

        pack_darkforest_act3_shakers = {
            rangeFastTickRate = 2600,
            rangeRetreat = 1400,
            rangeAggro = 1100,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 200,
        },

        pack_darkforest_act3_treant = {
            rangeFastTickRate = 2400,
            rangeRetreat = 1300,
            rangeAggro = 950,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 200,
        },

        pack_desert_act4_nyxs = {
            rangeFastTickRate = 2200,
            rangeRetreat = 1200,
            rangeAggro = 1000,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_desert_act4_viperstealer = {
            rangeFastTickRate = 2200,
            rangeRetreat = 1400,
            rangeAggro = 950,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_desert_act4_trollhuskar = {
            rangeFastTickRate = 2000,
            rangeRetreat = 1400,
            rangeAggro = 600,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_desert_act4_dire_creeps = {
            rangeFastTickRate = 2200,
            rangeRetreat = 2500,
            rangeAggro = 1000,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
            goldBounty = 100,
        },

        pack_concert_crowd = {
            rangeFastTickRate = 1900,
            rangeRetreat = 2000,
            rangeAggro = 1300,
            activateAfterUnitsSpawned = false,
            xpBounty = 1,
        },
        pack_monkey_king = {
            rangeFastTickRate = 5600,
            rangeRetreat = 5000,
            rangeAggro = 500,
            activateAfterUnitsSpawned = false,
            xpBounty = 1,
            goldBounty = 500,
        },
        pack_gate_trolls = {
            rangeRetreat = 1600,
            rangeAggro = 900,
            activateAfterUnitsSpawned = false,
            xpBounty = 1,
            goldBounty = 300,
        },
        pack_island_guard = {
            rangeRetreat = 2700,
            rangeAggro = 1300,
            activateAfterUnitsSpawned = false,
            stayActivatedOnPlayerDeath = true,
            goldBounty = 400,
        },
        pack_island_duo = {
            rangeFastTickRate = 2000,
            rangeRetreat = 1300,
            rangeAggro = 900,
            activateAfterUnitsSpawned = false,
            stayActivatedOnPlayerDeath = false,
            music = "music.island_duo.phase1",
            doors = {
                "door_island_duo"
            },
            xpBounty = 2,
        },
        pack_killer = {
            activateAfterUnitsSpawned = false,
            stayActivatedOnPlayerDeath = true,
            rangeFastTickRate = 6000,
            rangeRetreat = 5000,
            rangeAggro = 5000,
            xpBounty = 1,
            goldBounty = 200,
        },
        pack_goden = {
            activateAfterUnitsSpawned = true,
            stayActivatedOnPlayerDeath = true,
            rangeFastTickRate = 2400,
            rangeRetreat = 1600,
            rangeAggro = 1000,
            xpBounty = 1,
            goldBounty = 300,
        },
        pack_ball = {
            activateAfterUnitsSpawned = true,
            stayActivatedOnPlayerDeath = true,
            rangeFastTickRate = 3000,
            rangeRetreat = 2000,
            rangeAggro = 1030,
            doors = {
                "door_ball"
            },
            xpBounty = 1,
            goldBounty = 400,
        },
        pack_chaser = {
            activateAfterUnitsSpawned = true,
            stayActivatedOnPlayerDeath = true,
            rangeFastTickRate = 5000,
            rangeRetreat = 999999,
            rangeAggro = 700,
            xpBounty = 2,
            goldBounty = 100,
        },
        pack_derek = {
            activateAfterUnitsSpawned = false,
            stayActivatedOnPlayerDeath = false,
            rangeFastTickRate = 3000,
            rangeRetreat = 2200,
            rangeAggro = 2000,
            doors = {
                "door_derek"
            }
        },
        pack_george = {
            activateAfterUnitsSpawned = false,
            stayActivatedOnPlayerDeath = false,
            doors = {
                "door_george",
            },
            rangeFastTickRate = 3000,
            rangeRetreat = 2000,
            rangeAggro = 1700,
        },
        pack_ogre_bruiser = {
            activateAfterUnitsSpawned = false,
            stayActivatedOnPlayerDeath = true,
            xpBounty = 1,
        },
        pack_gorilla = {
            activateAfterUnitsSpawned = false,
            rangeFastTickRate = 2000,
            rangeRetreat = 1850,
            rangeAggro = 1000,
            xpBounty = 1,
        },
        pack_red = {
            rangeRetreat = 6000,
            rangeFastTickRate = 6000,
            rangeAggro = 6000,
            activateAfterUnitsSpawned = false,
            music = "hlup_full",
            xpBounty = 1,
        },
        pack_perekup = {
            activateAfterUnitsSpawned = false,
        },
        pack_genius = {
            activateAfterUnitsSpawned = false,
            rangeRetreat = 4800,
            rangeFastTickRate = 6000,
            rangeAggro = 1500,
            xpBounty = 1,
            goldBounty = 400,
        },

        pack_ghetto = {
            rangeFastTickRate = 5000,
            rangeRetreat = 6000,
            rangeAggro = 1000,
            activateAfterUnitsSpawned = false,
            stayActivatedOnPlayerDeath = true,
        },
        pack_ghetto_2 = {
            rangeFastTickRate = 1850,
            rangeRetreat = 1850,
            rangeAggro = 1100,
            activateAfterUnitsSpawned = false,
            stayActivatedOnPlayerDeath = true,
        },
        pack_ghetto_3 = {
            rangeFastTickRate = 3200,
            rangeRetreat = 3200,
            rangeAggro = 800,
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
        zone_forest_1 = { musicSet = "forest1", respawnPoint = "respawn_forest_1" },
        zone_clash = { musicSet = "clash", respawnPoint = "respawn_clash", noCombatMusic = true },
        zone_forest_2 = { musicSet = "forest2", respawnPoint = "respawn_forest_2" },
        zone_forest_3 = { musicSet = "forest3", respawnPoint = "respawn_forest_3" },
        zone_city = { musicSet = "city", respawnPoint = "respawn_city", noCombatMusic = true },
        zone_ski = { musicSet = "ski", respawnPoint = "respawn_city", noCombatMusic = true },
        zone_academy = { musicSet = "academy", respawnPoint = "respawn_academy", noCombatMusic = true, },
        zone_academy_entrance = { musicSet = "silence", respawnPoint = "respawn_city" },
        zone_wastelands = { musicSet = "wastelands", respawnPoint = "respawn_wastelands" },
        zone_ghetto = { musicSet = "ghetto", respawnPoint = "respawn_city" },
        zone_ghetto_entrance = { musicSet = "silence", respawnPoint = "respawn_city" },
        zone_concert_entrance = { musicSet = "silence", respawnPoint = "respawn_city" },
        zone_concert_muted = { musicSet = "concert_muted", respawnPoint = "respawn_concert" },
        zone_concert = { musicSet = "concert", respawnPoint = "respawn_concert" },
        zone_cave = { musicSet = "cave", respawnPoint = "respawn_cave", noCombatMusic = true },

        zone_island = { musicSet = "silence", respawnPoint = "respawn_island" },
        zone_island_check_1 = { musicSet = "island", respawnPoint = "respawn_island_check_1" },
        zone_island_check_2 = { musicSet = "island", respawnPoint = "respawn_island_check_2" },
        zone_island_check_3 = { musicSet = "island", respawnPoint = "respawn_island_check_3" },
        zone_island_check_4 = { musicSet = "island", respawnPoint = "respawn_island_check_4" },
        zone_island_check_5 = { musicSet = "island", respawnPoint = "respawn_island_check_5" },
        zone_island_check_6 = { musicSet = "island", respawnPoint = "respawn_island_check_6" },
        zone_island_check_7 = { musicSet = "island", respawnPoint = "respawn_island_check_7" },
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
        npc_ball = {
            drop = {
                "item_key_part_3",
            },
        },
    },

    ------------------------------------------------------------
    --- Doors
    ------------------------------------------------------------
    door = {
        door_prologue = {
            clipEntity = "clip_door_prologue",
            openAnimation = "gate_open",
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
            openAnimation = "gate_wooden_destruction",
            requiresPassword = "stringus collapsus",
            openSound = "sfx.wooden_door.open",
        },
        door_forest_3 = {
            clipEntity = "clip_door_forest_3",
            openAnimation = "gate_wooden_locked_02_opening",
            requiresPassword = "logarithmus solvus",
            openSound = "sfx.metal_door.open",
        },
        door_forest_3_shortcut = {
            clipEntity = "clip_door_forest_3_shortcut",
            openAnimation = "forest_3_open",
            openSound = "sfx.door_palace.open",
            requiresButtons = {
                "button_forest_3_shortcut"
            },
        },
        door_village = {
            clipEntity = "clip_door_village",
        },
        door_village_leader = {
            clipEntity = "clip_door_village_leader",
            openAnimation = "open",
            closeAnimation = "close",
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
        door_george = {
            clipEntity = "clip_door_george"
        },
        door_ball = {
            clipEntity = "clip_door_ball"
        },
        door_island_duo = {
            clipEntity = "clip_door_island_duo"
        },
        door_derek = {
            clipEntity = "clip_door_derek",
            openAnimation = "cf_palace_door_open",
            closeAnimation = "cf_palace_door_close",
            openSound = "sfx.door_palace.open",
        },
        door_cave = {
            clipEntity = "clip_door_cave",
            requiresPassword = "carcer immortalium",
            openAnimation = "open",
            particle = "particles/cave_door_open.vpcf",
        },
        door_classroom = {
            clipEntity = "clip_door_classroom",
        },
    },

    ------------------------------------------------------------
    --- Buttons
    ------------------------------------------------------------
    button = {
        button_forest_1_shortcut = {
            trigger = "button_trigger_forest_1_shortcut"
        },
        button_forest_3_shortcut = {
            trigger = "button_trigger_forest_3_shortcut"
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
