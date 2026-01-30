local QuestStatus = require('modules.quest.quest_status')
return {
    entries = {
        d_untitled_passage = {
            priority = 0,
            conditions = {
                { interact = "npc_brewmaster", type = "interact" },
                { questID = "q_pandas",        status = QuestStatus.INACTIVE, type = "quest" },
            },
        },
        d_untitled_passage_11 = {
            priority = 0,
            conditions = {
                { interact = "npc_brewmaster", type = "interact" },
                { questID = "q_pandas",        status = QuestStatus.ACTIVE, step = 1, type = "quest" },
            },
        },
        d_untitled_passage_12 = {
            priority = 0,
            conditions = {
                { trigger = "trigger_gate_trolls", type = "trigger" },
            },
        },
        d_untitled_passage_13 = {
            priority = 0,
            conditions = {
                { trigger = "trigger_guide_first", type = "trigger" },
                { var = "act",                     value = 1,       type = "var" },
            },
        },
        d_untitled_passage_14 = {
            priority = 0,
            conditions = {
                { interact = "npc_guide", type = "interact" },
                { var = "firstMet",       value = false,    type = "var" },
                { var = "act",            value = 1,        type = "var" },
            },
        },
        d_untitled_passage_15 = {
            priority = 0,
            conditions = {
                { trigger = "trigger_rebirth", type = "trigger" },
                { var = "act",                 value = 1,       type = "var" },
                { visited = false,             type = "visit" },
            },
        },
        d_untitled_passage_16 = {
            priority = 0,
            conditions = {
                { interact = "npc_tormentor", type = "interact" },
                { var = "act",                value = 1,        type = "var" },
                { visited = true,             type = "visit" },
            },
        },
        d_untitled_passage_17 = {
            priority = 100,
            conditions = {
                { interact = "npc_creep_rogach", type = "interact" },
                { var = "act",                   value = 1,        type = "var" },
                { ent_var = "first_met_global",  value = true,     npc = "npc_creep_rogach", type = "ent_var" },
            },
        },
        d_untitled_passage_18 = {
            priority = 0,
            conditions = {
                { interact = "npc_creep_rogach", type = "interact" },
                { var = "firstMet",              value = false,    type = "var" },
                { var = "act",                   value = 1,        type = "var" },
            },
        },
        d_untitled_passage_19 = {
            priority = 0,
            conditions = {
                { interact = "npc_mustache", type = "interact" },
                { var = "firstMet",          value = true,     type = "var" },
                { var = "act",               value = 1,        type = "var" },
            },
        },
        d_untitled_passage_20 = {
            priority = 0,
            conditions = {
                { interact = "npc_mustache", type = "interact" },
                { var = "act",               value = 1,        type = "var" },
                { var = "firstMet",          value = false,    type = "var" },
            },
        },
        d_untitled_passage_21 = {
            priority = 0,
            conditions = {
                { interact = "npc_creep_bob", type = "interact" },
                { var = "act",                value = 1,        type = "var" },
                { var = "firstMet",           value = true,     type = "var" },
            },
        },
        d_untitled_passage_22 = {
            priority = 0,
            conditions = {
                { interact = "npc_creep_bob", type = "interact" },
                { var = "firstMet",           value = false,    type = "var" },
                { var = "act",                value = 1,        type = "var" },
            },
        },
        d_untitled_passage_23 = {
            priority = 0,
            conditions = {
                { interact = "npc_blue_prince", type = "interact" },
                { questID = "q_clash_royale",   status = QuestStatus.INACTIVE, type = "quest" },
            },
        },
        d_untitled_passage_24 = {
            priority = 0,
            conditions = {
                { interact = "npc_blue_prince", type = "interact" },
                { questID = "q_clash_royale",   status = QuestStatus.ACTIVE, step = 1, type = "quest" },
            },
        },
        d_untitled_passage_25 = {
            priority = 0,
            conditions = {
                { interact = "npc_blue_prince", type = "interact" },
                { questID = "q_clash_royale",   status = QuestStatus.REJECTED, type = "quest" },
            },
        },
        d_untitled_passage_26 = {
            priority = 0,
            conditions = {
                { trigger = "trigger_bidlo", type = "trigger" },
            },
        },
        d_untitled_passage_27 = {
            priority = 0,
            conditions = {
                { beat = "npc_monkey_king", type = "beat" },
            },
        },
        d_untitled_passage_33 = {
            priority = 0,
            conditions = {
                { interact = "npc_rape_victim",     type = "interact" },
                { trigger = "trigger_slish_kamish", type = "trigger" },
            },
        },
        d_untitled_passage_34 = {
            priority = 0,
            conditions = {
                { interact = "npc_rape_victim", type = "interact" },
                { var = "firstMet",             value = false,    type = "var" },
            },
        },
        d_untitled_passage_40 = {
            priority = 0,
            conditions = {
                { interact = "npc_ogre_magi", type = "interact" },
                { questID = "q_ogres",        status = QuestStatus.INACTIVE, type = "quest" },
            },
        },
        d_untitled_passage_41 = {
            priority = 0,
            conditions = {
                { interact = "npc_ogre_magi", type = "interact" },
                { questID = "q_ogres",        status = QuestStatus.ACTIVE, step = 1, type = "quest" },
            },
        },
        d_untitled_passage_42 = {
            priority = 0,
            conditions = {
                { interact = "npc_ogre_bruiser", type = "interact" },
                { questID = "q_ogres",           status = QuestStatus.ACTIVE, step = 1, type = "quest" },
            },
        },
        d_untitled_passage_43 = {
            priority = 0,
            conditions = {
                { beat = "npc_ogre_bruiser",     type = "beat" },
                { interact = "npc_ogre_bruiser", type = "interact" },
            },
        },
        d_untitled_passage_44 = {
            priority = 0,
            conditions = {
                { interact = "npc_ogre_magi", type = "interact" },
                { questID = "q_ogres",        status = QuestStatus.ACTIVE, step = 2, type = "quest" },
            },
        },
        d_untitled_passage_45 = {
            priority = 0,
            conditions = {
                { interact = "npc_ogre_magi", type = "interact" },
                { questID = "q_ogres",        status = QuestStatus.COMPLETED, type = "quest" },
            },
        },
        d_untitled_passage_46 = {
            priority = 0,
            conditions = {
                { interact = "npc_Epstein",         type = "interact" },
                { trigger = "trigger_island_first", type = "trigger" },
                { var = "act",                      value = "1/2",    type = "var" },
            },
        },
        d_untitled_passage_47 = {
            priority = 0,
            conditions = {
                { interact = "npc_Epstein",          type = "interact" },
                { trigger = "trigger_island_second", type = "trigger" },
                { var = "act",                       value = "1/2",    type = "var" },
            },
        },
        d_untitled_passage_48 = {
            priority = 0,
            conditions = {
                { interact = "npc_Epstein_guard",     type = "interact" },
                { trigger = "trigger_island_fight_1", type = "trigger" },
                { var = "act",                        value = "1/2",    type = "var" },
            },
        },
        d_untitled_passage_49 = {
            priority = 0,
            conditions = {
                { interact = "npc_Epstein",         type = "interact" },
                { trigger = "trigger_island_third", type = "trigger" },
                { var = "act",                      value = "1/2",    type = "var" },
            },
        },
        d_untitled_passage_63 = {
            priority = 0,
            conditions = {
                { questID = "q_clash_royale",   status = QuestStatus.ACTIVE, step = 3, type = "quest" },
                { interact = "npc_blue_prince", type = "interact" },
            },
        },
        d_untitled_passage_64 = {
            priority = 0,
            conditions = {
                { interact = "npc_ogre_bruiser", type = "interact" },
                { questID = "q_ogres",           status = QuestStatus.INACTIVE, type = "quest" },
            },
        },
        d_untitled_passage_65 = {
            priority = 0,
            conditions = {
                { interact = "npc_ogre_magi", type = "interact" },
                { questID = "q_ogres",        status = QuestStatus.REJECTED, type = "quest" },
            },
        },
        d_untitled_passage_66 = {
            priority = 0,
            conditions = {
                { interact = "npc_blue_prince", type = "interact" },
                { questID = "q_clash_royale",   status = QuestStatus.COMPLETED, type = "quest" },
            },
        },
        d_untitled_passage_67 = {
            priority = 0,
            conditions = {
                { interact = "npc_monkey_king", type = "interact" },
                { ent_var = "beaten",           value = true,     type = "ent_var" },
            },
        },
        d_untitled_passage_68 = {
            priority = 70,
            conditions = {
                { ent_var = "first_met_cur_act", value = true, npc = "npc_creep_rogach", type = "ent_var" },
                { var = "act",                   value = 1,    type = "var" },
            },
        },
        d_untitled_passage_69 = {
            priority = 0,
            conditions = {
                { interact = "npc_monkey_king", type = "interact" },
                { trigger = "trigger_bidlo",    type = "trigger" },
            },
        },
        d_untitled_passage_8 = {
            priority = 0,
            conditions = {
                { interact = "npc_shamanka", type = "interact" },
                { var = "act",               value = 1,        type = "var" },
                { visited = true,            type = "visit" },
            },
        },
        d_untitled_passage_9 = {
            priority = 0,
            conditions = {
                { trigger = "trigger_choose_hero", type = "trigger" },
                { var = "act",                     value = 1,       type = "var" },
                { visited = false,                 type = "visit" },
            },
        },
    },
    nodes = {
        d_novye_ludi = {
            text =
            [[Да, такие как ты. Их не заинтересовала жизнь с нами, потому они обосновались отдельно от нас. В Королевстве сейчас живут только последователи Короля. ]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Понятно.]],
                    next = "d_h6",
                },
            },
        },
        d_utopat_v_ovatsiyah = {
            text = [[*Жар окутывает твою спину. Невыносимый жар. Тебе не нужно оборачиваться, чтобы понять кто это.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Ярость.]],
                    next = "d_yarost",
                },
            },
        },
        d_a_kem = {
            text = [[*Им*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_b",
                },
            },
        },
        d_vzyat_predmet = {
            text = [[Врата в Королевство перед тобой. Ступай и накажи грешника.]],
            speaker = [[npc_shamanka]],
            choices = {
                {
                    text = [[Кого?]],
                    next = "d_kogo",
                },
            },
        },
        d_vzyat_s_pola_kamen = {
            text = [[*Ты чувствуешь его вес, он настоящий.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Метнуть камень в сооружение.*]],
                    next = "d_metnut_kamen_v_sooruzhenie",
                },
            },
        },
        d_vlozhit_vse_svoi_usiliya = {
            text =
            [[Я выпустил магнитный заряд, но он был очень слабым, ведь птица не заслуживает смерти. Однако я могу менять силу импульса.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[А?]],
                    next = "d_a",
                },
            },
        },
        d_vybor_linii_povedeniya_provokatsiya = {
            text =
            [[*Ему на голову села небольшая птица. Издав импульс неизвестного происхождения, он пугает её, отчего та улетает.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Зря ты это сделал.]],
                    next = "d_d4",
                },
            },
        },
        d_vybor_linii_povedeniya_fizicheskaya_sila = {
            text =
            [[*Ему на голову села небольшая птица. Издав импульс неизвестного происхождения, он пугает птицу, отчего та улетает.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Пока он отвлёкся, забежать ему за спину.*]],
                    next = "d_poka_on_otvleksya_zabezhat_emu_za_spinu",
                },
            },
        },
        d_vybrat_svou_sudbu = {
            text =
            [[Вот, возьми талисман. Один человек попросил отдать это кому-то с невероятно сильным внутренним миром. Думаю лучше экземпляра я и не встречу.]],
            speaker = [[npc_shamanka]],
            choices = {
                {
                    text = [[*Взять предмет*]],
                    next = "d_vzyat_predmet",
                    actions = {
                        { itemName = "key_part_1", type = "give_item" },
                    },
                },
            },
        },
        d_dat_emu_schelban = {
            text =
            [[*Раздался звонкий звук, слышный на всё королевство. Спустя мгновение раздался уже глухой звук. И он явно был совершён не тобой.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*А кем?*]],
                    next = "d_a_kem",
                },
            },
        },
        d_delat_aktsent_na_kazhdoe_chetvertoe_hlupane = {
            text =
            [[*Красный настолько был ошарашен происходящим, что никак не мог понять, какой должна быть его реакция. Осознание того, что он не может постичь действий другого, а тем более себя, начало подпитывать страшный гнев в его теле.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Начать делать lip trill, дабы добавить устойчивую басовую основу.*]],
                    next = "d_nachat_delat_lip_trill_daby_dobavit_ustojchivuu_basovuu_osnovu",
                },
                {
                    text = [[*Начинать подпискивать, дабы расширить диапозон между низкими и высокими частотами.*]],
                    next = "d_nachinat_podpiskivat_daby_rasshirit_diapozon_mezhdu_nizkimi_i_vysokimi_chastotami",
                },
            },
        },
        d_znachitelno_povysit_temp_hlupanya = {
            text =
            [[*Красный настолько был ошарашен происходящим, что никак не мог понять, какой должна быть его реакция. Осознание того, что он не может постичь действий другого, а тем более себя, начало подпитывать страшный гнев в его теле.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Начать делать lip trill, дабы добавить устойчивую басовую основу.*]],
                    next = "d_nachat_delat_lip_trill_daby_dobavit_ustojchivuu_basovuu_osnovu",
                },
                {
                    text = [[*Начинать подпискивать, дабы расширить диапозон между низкими и высокими частотами.*]],
                    next = "d_nachinat_podpiskivat_daby_rasshirit_diapozon_mezhdu_nizkimi_i_vysokimi_chastotami",
                },
            },
        },
        d_metnut_kamen_v_sooruzhenie = {
            text = [[*Твой бросок на что-то повлиял. Золотая фигура издала тихий звук.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Подойти поближе и прислушаться.*]],
                    next = "d_podojti_poblizhe_i_prislushatsya",
                },
            },
        },
        d_nazhat_na_sochnuu_krasnuu_knopku = {
            text = [[Симфония.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Этот мир спасён.]],
                    next = "d_etot_mir_spasen",
                },
            },
        },
        d_nachat_bitvu = {
            text = [[]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_nachat_delat_lip_trill_daby_dobavit_ustojchivuu_basovuu_osnovu = {
            text =
            [[*Наступает момент кульминации. Лицо Красного уже залилось алым градиентом, вот вот его терпение лопнет и он пойдёт в твою сторону. Однако останавливаться сейчас нельзя, толпа прохожих внимательно следит за твоими движениями. Пришло время поставить точку...*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Сыграть рифф на ширинке с разрешением в тонику.*]],
                    next = "d_sygrat_riff_na_shirinke_s_razresheniem_v_toniku",
                },
                {
                    text = [[*Отбить ботинками каденцию.*]],
                    next = "d_otbit_botinkami_kadentsiu",
                },
            },
        },
        d_nachat_oboronyatsya = {
            text = [[]],
            speaker = [[npc_creep_troll]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_nachat_pritoptyvat_v_takt_hlupanya = {
            text =
            [[*Лицо Красного замерло в ужасной гримасе. Он оскорблён, но при этом его разум не способен осознать и постчиь истинного замысла за твоими последними действиями.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Значительно повысить темп хлюпанья.*]],
                    next = "d_znachitelno_povysit_temp_hlupanya",
                },
                {
                    text = [[*Делать акцент на каждое четвёртое хлюпанье.*]],
                    next = "d_delat_aktsent_na_kazhdoe_chetvertoe_hlupane",
                },
            },
        },
        d_nachat_tyanut_esche_silnee = {
            text = [[Что ты делаешь?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Раз ты не хочешь идти со мной, я просто понесу тебя.]],
                    next = "d_raz_ty_ne_hochesh_idti_so_mnoj_ya_prosto_ponesu_tebya",
                },
            },
        },
        d_nachat_schelkat_paltsami_parallelno_hlupanu = {
            text =
            [[*Лицо Красного замерло в ужасной гримасе. Он оскорблён, но при этом его разум не способен осознать и постчиь истинного замысла за твоими последними действиями.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Значительно повысить темп хлюпанья.*]],
                    next = "d_znachitelno_povysit_temp_hlupanya",
                },
                {
                    text = [[*Делать акцент на каждое четвёртое хлюпанье.*]],
                    next = "d_delat_aktsent_na_kazhdoe_chetvertoe_hlupane",
                },
            },
        },
        d_nachinat_podpiskivat_daby_rasshirit_diapozon_mezhdu_nizkimi_i_vysokimi_chastotami = {
            text =
            [[*Наступает момент кульминации. Лицо Красного уже залилось алым градиентом, вот вот его терпение лопнет и он пойдёт в твою сторону. Однако останавливаться сейчас нельзя, толпа прохожих внимательно следит за твоими движениями. Пришло время поставить точку...*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Сыграть рифф на ширинке с разрешением в тонику.*]],
                    next = "d_sygrat_riff_na_shirinke_s_razresheniem_v_toniku",
                },
                {
                    text = [[*Отбить ботинками каденцию.*]],
                    next = "d_otbit_botinkami_kadentsiu",
                },
            },
        },
        d_ne_snimat = {
            text = [[*Он смотрит в твои глаза, но ты не можешь разобрать какие эмоции он чувствует в данный момент.*]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Уходи и больше никогда не появляйся здесь.]],
                    next = "d_uhodi_i_bolshe_nikogda_ne_poyavlyajsya_zdes",
                },
            },
        },
        d_obernut_svoi_nogi_vokrug_nego_i_nachat_tyanut_vesom_tela = {
            text = [[Тщетные попытки, думаю на этом хватит.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Нет, не хватит.]],
                    next = "d_net_ne_hvatit",
                },
                {
                    text = [[Может и хватит.]],
                    next = "d_d2",
                },
            },
        },
        d_osmotretsya = {
            text = [[*Странно, после выхода из подземного перехода, путь назад просто исчез.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Хммм...]],
                    next = "d_hmmm",
                },
            },
        },
        d_otbit_botinkami_kadentsiu = {
            text =
            [[*Тишина. От сильнейшего топтания твои ботинки покрылись чёрной пеленой, но ты этого даже не заметил, ведь взор твой был устремлён в небеса. В результате страстных движений, земля была окрашена тёмными узорами невиданной красоты."]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Словно иглы, мои ботинки вышили эти орнаменты для вас, земляне.]],
                    next = "d_slovno_igly_moi_botinki_vyshili_eti_ornamenty_dlya_vas_zemlyane",
                },
            },
        },
        d_otojti_na_bezopasnoe_rasstoyanie = {
            text = [[*Повисла тишина.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Если хочешь убедиться, то проведи рукой по голове.]],
                    next = "d_esli_hochesh_ubeditsya_to_provedi_rukoj_po_golove",
                },
            },
        },
        d_podojti_k_kripu = {
            text = [[Ты здесь недавно, да? Знаешь, что там?]],
            speaker = [[npc_rape_victim]],
            choices = {
                {
                    text = [[Заброшенный лес.]],
                    next = "d_zabroshennyj_les",
                },
            },
        },
        d_podojti_poblizhe_i_prislushatsya = {
            text = [[РАВНОЦЕННЫЙ ОБМЕН - ОСНОВА ЭТОГО МИРА.]],
            speaker = [[npc_tormentor]],
            choices = {
                {
                    text = [[Чего?]],
                    next = "d_chego",
                },
            },
        },
        d_podojti_poblizhe = {
            text = [[Меня зовут Боб.]],
            speaker = [[npc_creep_bob]],
            choices = {
                {
                    text = [[А меня зову...]],
                    next = "d_a_menya_zovu",
                },
            },
        },
        d_poka_on_otvleksya_zabezhat_emu_za_spinu = {
            text = [[*Ты обхватываешь его сзади и начинаешь тянуть, словно репку.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Начать тянуть ещё сильнее.*]],
                    next = "d_nachat_tyanut_esche_silnee",
                },
            },
        },
        d_pomahat_biletom = {
            text = [[Ооооо, тогда увидимся там!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_popravit_yajtsa = {
            text =
            [[Человек, который твёрдо знает, чего он желает. Человек, который, несмотря на обстоятельства, делает то, что он хочет. Ты ещё более ценный чем я думала.]],
            speaker = [[npc_shamanka]],
            choices = {
                {
                    text = [[*Протянуть руку.*]],
                    next = "d_protyanut_ruku",
                },
            },
        },
        d_poteret_emu_nosik = {
            text =
            [[*Подойдя поближе ты замечаешь, что его нос уже сверкает золотом. Подобное желание приходило в голову явно многим. Ты начинаешь тереть его нос. Он всё ещё неподвижно наблюдает, но, опустив брови, его взгляд становится более сердитым.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Начать тереть сильнее.*]],
                    next = "d_b",
                },
                {
                    text = [[*Прекратить.*]],
                    next = "d_prekratit",
                },
            },
        },
        d_potyanut_ruku_k_shtanam = {
            text = [[*Женщина сначала удивилась, а после обрадовалась.*]],
            speaker = [[npc_shamanka]],
            choices = {
                {
                    text = [[*Поправить яйца.*]],
                    next = "d_popravit_yajtsa",
                },
            },
        },
        d_pohozhe_do_nih_vse_esche_ne_doshlo = {
            text = [[*Начался хаос. Все начали избивать друг друга. Ты решил не оставаться в стороне.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_prekratit = {
            text = [[Разумное решение, ты был в моменте от гибели.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Не думаю.]],
                    next = "d_ne_dumau",
                },
                {
                    text = [[У меня есть к тебе дело.]],
                    next = "d_u_menya_est_k_tebe_delo",
                },
            },
        },
        d_protyanut_ruku = {
            text =
            [[Впервые такое вижу. Твоя душа кричит, виднеются десятки различных "сущностей", однако, наподобие сперматозоидам, многие из них погибают, не сумев достигнуть цели. Это твои желания, скрытые за десятками стен эмоций.]],
            speaker = [[npc_shamanka]],
            choices = {
                {
                    text = [[Вау.]],
                    next = "d_vau",
                },
            },
        },
        d_razbit_bochku_pinkom = {
            text = [[НЕЕЕЕТ, ЧТО ТЫ НАДЕЛАЛ?! ВСЁ ВЫЛИЛОСЬ. Я ТЕБЯ СЕЙЧАС...]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[Ты ж говорил, что она пустая.]],
                    next = "d_ty_zh_govoril_chto_ona_pustaya",
                },
            },
        },
        d_snyat_s_nego_mantiu = {
            text = [[*Оттолкнув твою руку, он хватает дубину и ударяет себя по голове.*]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Что...]],
                    next = "d_chto__1",
                },
            },
        },
        d_sorvat_detonator_s_hvosta_kotabochki = {
            text =
            [[*Мир замер. Ты будто в слоу-мо. Крипы начали поворачиваться в твою сторону, что-то крича. Такие медленные. Рука твоя уже на готове, готова влетать.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Нажать на сочную красную кнопку.*]],
                    next = "d_n5",
                },
            },
        },
        d_stop_esli_on_zdes_neuzhto = {
            text =
            [[*Да... Xavier умер как и ты. Однако эта мысль, наоборот, успокивает тебя, ведь ты можешь жить с ним бок о бок столько, сколько хочешь.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[ДА.]],
                    next = "d_da",
                },
            },
        },
        d_sygrat_riff_na_shirinke_s_razresheniem_v_toniku = {
            text =
            [[*Тишина. Лишь эхом отдаётся последняя нота. В это соло была вложена вся душа, что ты и не заметил, как замок отлетел. Словно медиатор, он лежит между указательным и большим пальцами. Ширинку больше, увы, не застегнуть. ]],
            speaker = [[default]],
            choices = {
                {
                    text = [[С этого момента цепи конуры более не смогут сдержать моего бульдога. Ты свободен.]],
                    next = "d_s_etogo_momenta_tsepi_konury_bolee_ne_smogut_sderzhat_moego_buldoga_ty_svoboden",
                },
            },
        },
        d_tebya_probivaet_na_slezu_ot_voshischeniya = {
            text =
            [[Однако мне неоткуда черпать инфу, как таким стать. В Королевстве никто не знает о тонкостях их жизни.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Я могу тебе как-нибудь помочь?]],
                    next = "d_ya_mogu_tebe_kaknibud_pomoch",
                },
            },
        },
        d_ty_zabiraesh_bilety = {
            text = [[Приятно иметь с вами дело, молодой человек.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Взаимно.]],
                    next = "d_vzaimno",
                },
                {
                    text = [[*Всё равно избить его.*]],
                    next = "d_l2",
                },
            },
        },
        d_ty_klanyaeshsya_v_otvet = {
            text = [[*Послышался шум динамиков.*Ты... Меня впечталил, конечно.]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[Рад.]],
                    next = "d_rad",
                },
            },
        },
        d_udarit_lbom_emu_po_litsu = {
            text = [[АРГХХ... Ты что делаешь сука, А?!]],
            speaker = [[npc_monkey_king]],
            choices = {
                {
                    text = [[Моей мамы тут нет, она жива, чмо.]],
                    next = "d_j",
                },
            },
        },
        d_ujti_s_pozorom = {
            text = [[*Ты уходишь с позором.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_ujti = {
            text = [[*Обе головы продолжают спорить.*]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_uhmylnutsya_i_nachat_hlupat = {
            text = [[ЧТО ]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Начать щёлкать пальцами параллельно хлюпанью.*]],
                    next = "d_nachat_schelkat_paltsami_parallelno_hlupanu",
                },
                {
                    text = [[*Начать притоптывать в такт хлюпанья.*]],
                    next = "d_nachat_pritoptyvat_v_takt_hlupanya",
                },
            },
        },
        d_ya_pochuvstvoval_priblizhenie_smerti_ya_tochno_umer_gde_ya = {
            text = [[*Потрогав своё тело, ты убеждаешься, что в нём нет пулевых ранений.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Взять с пола камень.*]],
                    next = "d_vzyat_s_pola_kamen",
                },
            },
        },
        d_empty = {
            text =
            [[Вообщем, ты их точно не пропустишь, у них очень выразительные цвета: Красный - злобный малый, Зелёный - твердолобый упырь, Синий - непредсказуемый болван.]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[А звать то их как?]],
                    next = "d_a_zvat_to_ih_kak",
                },
                {
                    text = [[Красный - гневный, Зелёный - упрямый, Синий - своевольный. Запомнил.]],
                    next = "d_a4",
                },
            },
        },
        d_aleks_obuzdavshij_ten = {
            text = [[М.. Мы... Дожны.. должны.. его одолеть... *Демонов трясёт от страха*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[На колени перед владыкой.]],
                    next = "d_na_koleni_pered_vladykoj",
                },
            },
        },
        d_chuvstvovat_zhivyh_suschestv_v_radiuse_1_km = {
            text = [[*Фитиль загорелся. Куча разноцветных вспышек оцепила небо, их было видно даже днём.*Ура!!!!!!!!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Давайте покончим с этим.]],
                    next = "d_davajte_pokonchim_s_etim",
                },
            },
        },
        d_0_monet = {
            text = [[0 монет!!!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[ПОКУПАЮ!]],
                    next = "d_pokupau",
                },
            },
        },
        d_1_moneta = {
            text = [[6 монет!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[3 монеты!]],
                    next = "d_3_monety",
                },
            },
        },
        d_14 = {
            text = [[Как будто ты всё-таки старше.]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[Кстати, у тебя знакомый голос.]],
                    next = "d_kstati_u_tebya_znakomyj_golos",
                },
            },
        },
        d_2_monety = {
            text = [[3 монеты!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[1 монета!]],
                    next = "d_l",
                },
            },
        },
        d_20 = {
            text = [[Очень грустно... Чтож, раз уж ты бесполезен, порадуй меня хотя бы шоу.]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[Кстати, у тебя знакомый голос.]],
                    next = "d_kstati_u_tebya_znakomyj_golos",
                },
            },
        },
        d_3_monety = {
            text = [[5 монет!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[2 монеты!]],
                    next = "d_2_monety",
                },
            },
        },
        d_7_monet_po_420_eto_2940_a_bilety_stoyat_50_ne_shoditsya = {
            text = [[Так... Так.. Так я шёл тебе на компромиссы! Изначальная цена была гораздо больше!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Тогда предлагаю торг.]],
                    next = "d_togda_predlagau_torg",
                },
            },
        },
        d_ember_spirit = {
            text = [[В каком виде луковые кольца САМЫЕ вкусные?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[С соусом.]],
                    next = "d_g18",
                },
                {
                    text = [[В бургере.]],
                    next = "d_g18",
                },
                {
                    text = [[С пивом.]],
                    next = "d_g18",
                },
                {
                    text = [[Луковые кольца говно.]],
                    next = "d_lukovye_koltsa_govno",
                },
            },
        },
        d_untitled_passage = {
            text = [[*Перед твоим взором - покачивающаяся панда. Сильный запах алкоголя ударяет тебе в нос.*]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[Что пьёшь?]],
                    next = "d_chto_pesh",
                },
            },
        },
        d_untitled_passage_1 = {
            text =
            [[*Существо красного цвета с мрачным видом смотрит в твою сторону. С некоторой периодичностью у него дёргается глаз.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Ты ведь Красный?]],
                    next = "d_ty_ved_krasnyj",
                },
            },
        },
        d_untitled_passage_10 = {
            text = [[Удачи в твоих странствиях!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_11 = {
            text = [[*Панда бубнит и пердит.*]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_12 = {
            text = [[*Из ниоткуда явилось три зубастых существа.*]],
            speaker = [[npc_creep_troll]],
            choices = {
                {
                    text = [[Вы вообще что такое?]],
                    next = "d_vy_voobsche_chto_takoe",
                },
            },
        },
        d_untitled_passage_13 = {
            text = [[*Перед тобой девушка необычайной красоты. Она помахивает тебе рукой.*]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Привет.]],
                    next = "d_privet",
                },
                {
                    text = [[Сколько за час?]],
                    next = "d_skolko_za_chas",
                },
            },
        },
        d_untitled_passage_14 = {
            text = [[Крип-предвестник проживает в Заброшенном лесу. Найди его ради Королевства!]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_15 = {
            text = [[*Открыв глаза, ты видишь лишь обожённую землю и постройку странной формы.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Я почувствовал приближение смерти. Я точно умер. Где я.*]],
                    next = "d_ya_pochuvstvoval_priblizhenie_smerti_ya_tochno_umer_gde_ya",
                },
            },
        },
        d_untitled_passage_16 = {
            text = [[*Тишина.*]],
            speaker = [[npc_tormentor]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_17 = {
            text = [[Эй, чувак, здарова.]],
            speaker = [[npc_creep_rogach]],
            choices = {
                {
                    text = [[Здарова.]],
                    next = "d_zdarova",
                },
            },
        },
        d_untitled_passage_18 = {
            text = [[Будь сильным, приятель.]],
            speaker = [[npc_creep_rogach]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_19 = {
            text = [[СТОЯЯЯЯЯЯЯТЬ!!]],
            speaker = [[npc_mustache]],
            choices = {
                {
                    text = [[Чё ты кричишь?]],
                    next = "d_che_ty_krichish",
                },
            },
        },
        d_untitled_passage_2 = {
            text = [[*Потерпев поражение, Красный остыл, на лице его родилось спокойствие.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Ну как?]],
                    next = "d_nu_kak",
                },
            },
        },
        d_untitled_passage_20 = {
            text = [[ВПЕРЁД КАЧАТЬСЯ! СЛАВА КОРОЛЮ!]],
            speaker = [[npc_mustache]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_21 = {
            text = [[*Крип-головастик произносит слова, очень сильно напрягая голову.*]],
            speaker = [[npc_creep_bob]],
            choices = {
                {
                    text = [[*Подойти поближе.*]],
                    next = "d_podojti_poblizhe",
                },
            },
        },
        d_untitled_passage_22 = {
            text = [[*Крип неподвижно стоит.*]],
            speaker = [[npc_creep_bob]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_23 = {
            text = [[Человек. Хочешь разбогатеть?]],
            speaker = [[npc_blue_prince]],
            choices = {
                {
                    text = [[Смотря что предлагаешь.]],
                    next = "d_smotrya_chto_predlagaesh",
                },
            },
        },
        d_untitled_passage_24 = {
            text = [[Врата. Проходи через них.]],
            speaker = [[npc_blue_prince]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_25 = {
            text = [[Помочь Принцу. Ты готов?]],
            speaker = [[npc_blue_prince]],
            choices = {
                {
                    text = [[Да.]],
                    next = "d_i9",
                    actions = {
                        { questID = "q_clash_royale", type = "quest_start" },
                    },
                },
                {
                    text = [[Не хочу.]],
                    next = "d_ne_hochu",
                },
            },
        },
        d_untitled_passage_26 = {
            text = [[*Увидя тебя, человек необычной внешности расправляет плечи и подходит к тебе вплотную.*]],
            speaker = [[npc_monkey_king]],
            choices = {
                {
                    text = [[Ты человек или крип?]],
                    next = "d_ty_chelovek_ili_krip",
                },
            },
        },
        d_untitled_passage_27 = {
            text = [[Л... Ладно. Немного перегнул, но мы в рассчёте, верно? Слава Королю!]],
            speaker = [[npc_monkey_king]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_28 = {
            text = [[Эй, приветствую мой хоуми.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[И тебе привет.]],
                    next = "d_i_tebe_privet",
                },
            },
        },
        d_untitled_passage_29 = {
            text = [[О... Ты что-то придумал?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Я тебе подсоблю.]],
                    next = "d_j4",
                },
                {
                    text = [[Ещё нет.]],
                    next = "d_j3",
                },
            },
        },
        d_untitled_passage_3 = {
            text = [[*Существо зелёного цвета стоит, соединив руки перед собой. Ощущается будто бы он прирос к земле.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Ты живой?]],
                    next = "d_ty_zhivoj",
                },
            },
        },
        d_untitled_passage_30 = {
            text = [[Надеюсь у тебя получится!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_31 = {
            text = [[Послушай мой рассказ.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Это надолго?]],
                    next = "d_eto_nadolgo",
                },
            },
        },
        d_untitled_passage_32 = {
            text = [[*Не стоит его беспокоить.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_33 = {
            text = [[Пс... Эй, ты. Подойди.]],
            speaker = [[npc_rape_victim]],
            choices = {
                {
                    text = [[*Подойти к крипу.*]],
                    next = "d_podojti_k_kripu",
                },
            },
        },
        d_untitled_passage_34 = {
            text = [[Вали уже.]],
            speaker = [[npc_rape_victim]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_35 = {
            text = [[*Солидный человек с прямой спиной улыбчиво тебя приветствует.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Билеты на концерт. Это же ты их продаёшь?]],
                    next = "d_bilety_na_kontsert_eto_zhe_ty_ih_prodaesh",
                },
            },
        },
        d_untitled_passage_36 = {
            text = [[Приходите ещё!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_37 = {
            text = [[Вазап, броу! Как дела?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Вот твой билет, черномазый.]],
                    next = "d_vot_tvoj_bilet_chernomazyj",
                },
            },
        },
        d_untitled_passage_38 = {
            text = [[*Ты не веришь своим глазам. Это же Xavier. Настоящий.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[ЧТО?!]],
                    next = "d_chto",
                },
            },
        },
        d_untitled_passage_39 = {
            text = [[*Он пристально смотрит на сцену. Ничто не способно отвлечь его.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_4 = {
            text = [[Невероятная сила...]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Внешка не важна, понимаешь? Сила внутри.]],
                    next = "d_vneshka_ne_vazhna_ponimaesh_sila_vnutri",
                },
            },
        },
        d_untitled_passage_40 = {
            text =
            [[*Тебя заинтересовало необычное существо с двумя головами. Но, рассмотрев их лица, ты понял, что диалог будет не из простых.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Вы единое целое или две личности?]],
                    next = "d_vy_edinoe_tseloe_ili_dve_lichnosti",
                },
            },
        },
        d_untitled_passage_41 = {
            text = [[1: Заброшенный...2: ЛЕС!]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_42 = {
            text = [[*Крип причудливой внешности излучает необычайное спокойствие.*]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Ты случайно не Огр-громила?]],
                    next = "d_ty_sluchajno_ne_ogrgromila",
                },
            },
        },
        d_untitled_passage_43 = {
            text =
            [[*Огр-громила пал. Он лежит на земле и смотрет в небо. Он понимает, что это скорее всего последний раз, когда он может насладиться существованием.*]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[...]],
                    next = "d_m9",
                },
            },
        },
        d_untitled_passage_44 = {
            text = [[1: Ооо, это же ты! Добрый человек-помощник.2: Реально! Это та спичка!]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[Мантии на интеллект не существует.]],
                    next = "d_mantii_na_intellekt_ne_suschestvuet",
                },
            },
        },
        d_untitled_passage_45 = {
            text = [[*Ты не решаешься возвращаться к ним.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_46 = {
            text = [[*Кажется тебя обманули, но ты продолжаешь верить.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Осмотреться.*]],
                    next = "d_osmotretsya",
                },
            },
        },
        d_untitled_passage_47 = {
            text = [[Совсем не ожидал, что ты пройдёшь. Мои поздравления.]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[Цмка где.]],
                    next = "d_tsmka_gde",
                },
            },
        },
        d_untitled_passage_48 = {
            text = [[*Взгляда достаточно, чтобы понять, - это явно не цмка.*]],
            speaker = [[npc_Epstein_guard]],
            choices = {
                {
                    text = [[Обидно.]],
                    next = "d_obidno",
                },
            },
        },
        d_untitled_passage_49 = {
            text = [[*Ты используешь ключ и открываешь клетку.*]],
            speaker = [[npc_cat_barrel]],
            choices = {
                {
                    text = [[Вы свободны, убегайте.]],
                    next = "d_vy_svobodny_ubegajte",
                },
            },
        },
        d_untitled_passage_5 = {
            text =
            [[Тебе следует поменять название приёма. Это больше смахивает на кулак, дрочащий хуи. Развивайся и приходи ещё.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Уйти с позором.*]],
                    next = "d_ujti_s_pozorom",
                },
            },
        },
        d_untitled_passage_50 = {
            text = [[*Кучка крипов. Это они, те кого ты спас с острова.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[О, это же вы.]],
                    next = "d_o_eto_zhe_vy",
                },
            },
        },
        d_untitled_passage_51 = {
            text = [[Ты! Не двигаться.*Тебя окликает неизвестное существо.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Чего тебе?]],
                    next = "d_chego_tebe",
                },
            },
        },
        d_untitled_passage_52 = {
            text = [[Ооо, с возвращением! ]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Дом, милый дом.]],
                    next = "d_dom_milyj_dom",
                },
            },
        },
        d_untitled_passage_53 = {
            text = [[Эй эй эй, куда ты идёшь?!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[К тебе в гости.]],
                    next = "d_k_tebe_v_gosti",
                },
            },
        },
        d_untitled_passage_54 = {
            text = [[Испорченная душа... В тебе виднеется потенциал.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Всмысле испорченная?]],
                    next = "d_vsmysle_isporchennaya",
                },
            },
        },
        d_untitled_passage_55 = {
            text = [[Как вернёшься, мы используем детонатор!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_56 = {
            text = [[*Крипы чуть не взорвались от радости, увидев тебя.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Где детонатор?]],
                    next = "d_gde_detonator",
                },
            },
        },
        d_untitled_passage_57 = {
            text = [[Вы легенда!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_58 = {
            text =
            [[*Ты закладываешь бомбу рядом с другой взрывчаткой. Этого точно хватит, чтоб подорвать весь остров.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Готово.]],
                    next = "d_gotovo",
                },
            },
        },
        d_untitled_passage_59 = {
            text =
            [[*Девушка с угрожающим видом останавливает тебя. Почему-то есть ощущение, что её руки пролили много крови.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Что-то не так?]],
                    next = "d_chtoto_ne_tak",
                },
            },
        },
        d_untitled_passage_6 = {
            text = [[*Ты замечаешь существо, двигающееся в хаотичном порядке.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Эй ты.]],
                    next = "d_ej_ty",
                },
            },
        },
        d_untitled_passage_60 = {
            text =
            [[*Её не обмануть. Ты чувствуешь, что поединок тоже не вариант, у неё слишком сильная аура. Придётся реально найти кого-то.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_61 = {
            text = [[*Ты приветствуешь хранительницу.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Мне кажется я знаю пароль.]],
                    next = "d_mne_kazhetsya_ya_znau_parol",
                },
            },
        },
        d_untitled_passage_62 = {
            text = [[]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_63 = {
            text = [[Человек. Ты великий воин. Земли теперь полностью мои.]],
            speaker = [[npc_blue_prince]],
            choices = {
                {
                    text = [[Круто, как там с наградой?]],
                    next = "d_kruto_kak_tam_s_nagradoj",
                    actions = {
                        { questID = "q_clash_royale", type = "quest_end" },
                    },
                },
            },
        },
        d_untitled_passage_64 = {
            text = [[Тебе что-то нужно, человек?*Спросил крип с необычайно спокойным голосом.*]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_65 = {
            text = [[Всё-таки поможешь нам?!]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[Ладно ладно.]],
                    next = "d_ladno",
                    actions = {
                        { questID = "q_ogres", type = "quest_start" },
                    },
                },
                {
                    text = [[Умные делают всё сами.]],
                    next = "d_davajte_sami",
                },
            },
        },
        d_untitled_passage_66 = {
            text = [[Теперь богач я. Брат бедный.]],
            speaker = [[npc_blue_prince]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_67 = {
            text = [[Не обращай на меня внимание. Иди дальше, давай.]],
            speaker = [[npc_monkey_king]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_68 = {
            text = [[привет ща акт 2]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_69 = {
            text = [[В себя поверил, А?!]],
            speaker = [[npc_monkey_king]],
            choices = {
                {
                    text = [[Я готов.]],
                    next = "d_ya_gotov",
                },
            },
        },
        d_untitled_passage_7 = {
            text =
            [[*Приближаясь к знакомой уже панде, ты замечаешь сильные изменения. Он больше не пьёт, морда его довольная, а тело более подтянутое.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Привет, панда. Вижу жизнь твоя налаживается.]],
                    next = "d_privet_panda_vizhu_zhizn_tvoya_nalazhivaetsya",
                },
            },
        },
        d_untitled_passage_8 = {
            text = [[Ступай.]],
            speaker = [[npc_shamanka]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_untitled_passage_9 = {
            text = [[*Женщина со странной аурой начала тщательно тебя рассматривать.*]],
            speaker = [[npc_shamanka]],
            choices = {
                {
                    text = [[Здрасте, не подскажите где я?]],
                    next = "d_zdraste_ne_podskazhite_gde_ya",
                },
            },
        },
        d_z_eto_camost_a_camost_eto_z = {
            text =
            [[Теперь ты член этой Деревни. Если расскажешь кому-либо о нашей деятельности, я казню тебя без колебаний.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Спасибо, верю.]],
                    next = "d_spasibo_veru",
                },
            },
        },
        d_a10 = {
            text = [[ПОСЛУШАЙ МУДРОГО ДЯДЮ И ИДИ НАХУЙ.]],
            speaker = [[default]],
            choices = {
                {
                    text =
                    [[Он и вправду очень скучает по тебе, понимаешь? Ему просто хочется, чтобы вы с братьями были вместе.]],
                    next =
                    "d_on_i_vpravdu_ochen_skuchaet_po_tebe_ponimaesh_emu_prosto_hochetsya_chtoby_vy_s_bratyami_byli_vmeste",
                },
            },
        },
        d_a2 = {
            text = [[*Существо было удивлено, что ты решил с ним заговорить.*]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[...]],
                    next = "d_tak_chto",
                },
            },
        },
        d_a3 = {
            text =
            [[С тех пор как они перестали слушаться меня, жизнь пошла по дну. Люди меня стороняться и обходят. Жена даже из дома выгнала, представляешь? ]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[Расскажи о сыновьях.]],
                    next = "d_rasskazhi_o_synovyah",
                },
            },
        },
        d_a4 = {
            text =
            [[Я думал люди только и могут кричать о величии их Пропавшего Короля. Сидят на жопе и ничего кроме этого не делают. Неужто ты мне поможешь?]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[Расскажи что-то о Короле.]],
                    next = "d_rasskazhi_chtoto_o_korole",
                },
            },
        },
        d_b = {
            text = [[Неуважение.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_d = {
            text = [[*Зелёный показывает явное безразличие.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Выбор линии поведения - физическая сила*]],
                    next = "d_vybor_linii_povedeniya_fizicheskaya_sila",
                },
                {
                    text = [[*Выбор линии поведения - провокация*]],
                    next = "d_vybor_linii_povedeniya_provokatsiya",
                },
            },
        },
        d_d2 = {
            text = [[*Пришло время менять стратегию.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Выбор линии поведения - провокация*]],
                    next = "d_d3",
                },
            },
        },
        d_d3 = {
            text = [[Слабость.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Помнишь ту птицу? Зря ты её спугнул.]],
                    next = "d_d4",
                },
            },
        },
        d_d4 = {
            text = [[Почему?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Она оставила тебе подарок - белое пятно на твоей макушке.]],
                    next = "d_ona_ostavila_tebe_podarok_beloe_pyatno_na_tvoej_makushke",
                },
            },
        },
        d_d5 = {
            text =
            [[Твои действия показали мой слабый характер. С этого момента я буду более осознанным и осведомлённым.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Хорош.]],
                    next = "d_horosh",
                },
            },
        },
        d_e = {
            text = [[Даже если это правда, я не подчинюсь существу слабее меня.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Здесь дело не в том, кто сильнее или слабее. Просто у тебя на голове насрано.]],
                    next = "d_zdes_delo_ne_v_tom_kto_silnee_ili_slabee_prosto_u_tebya_na_golove_nasrano",
                },
            },
        },
        d_f = {
            text =
            [[В первом ты преуспел, теперь пришло время показать силу. Если одним ударом ты сможешь сдвинуть меня, так уж и быть - исполню твоё желание. Нападай.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_g = {
            text = [[Мы самые кровожадные воры Заброшенного леса: Урюк, Дирюк и Бе...]],
            speaker = [[npc_creep_troll]],
            choices = {
                {
                    text = [[Не не, мне не важно кто вы, я спрашивал, что за раса у вас.]],
                    next = "d_ne_ne_mne_ne_vazhno_kto_vy_ya_sprashival_chto_za_rasa_u_vas",
                },
            },
        },
        d_g10 = {
            text = [[УЧИ уроки. Похоже нам с тобой не по пути.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Ненавижу физику! Давай ещё раз.]],
                    next = "d_g9",
                },
            },
        },
        d_g11 = {
            text = [[Что есть счастье?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Есть.]],
                    next = "d_g12",
                },
                {
                    text = [[Гулять.]],
                    next = "d_g12",
                },
                {
                    text = [[Решать.]],
                    next = "d_reshat",
                },
                {
                    text = [[Играть.]],
                    next = "d_g12",
                },
            },
        },
        d_g12 = {
            text = [[НЕ СОГЛАСЕН. Похоже нам с тобой не по пути.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Гррр.. Давай ещё раз!]],
                    next = "d_g9",
                },
            },
        },
        d_g13 = {
            text = [[Почему ТЫ ВЫБРАЛ macan. Ты что тупой?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Обливаясь холодным потом, ты извиняешься и просишь ещё одну попытку.*]],
                    next = "d_g9",
                },
            },
        },
        d_g14 = {
            text = [[Опиши дорожный знак "Главная дорога".]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Яйца.]],
                    next = "d_yajtsa",
                },
                {
                    text = [[Главный на дороге.]],
                    next = "d_g15",
                },
                {
                    text = [[Цветной.]],
                    next = "d_g15",
                },
                {
                    text = [[Солнце из майнкрафта.]],
                    next = "d_g15",
                },
            },
        },
        d_g15 = {
            text = [[ПОЛНОЕ отсутствие визуального ВОСПРИЯТИЯ. Похоже нам с тобой не попути.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Не особо понял.]],
                    next = "d_g9",
                },
            },
        },
        d_g16 = {
            text = [[Как ТЫ ВООБЩЕ мог так ответить, А? Похоже нам с тобой не по пути.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Это очевидно Шторм. Что я выбираю?*]],
                    next = "d_g9",
                },
            },
        },
        d_g17 = {
            text = [[Я и вправду люблю ШТОРМ СПИРИТА, но он не мой любимый. Похоже нам с тобой не по пути.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Панда называл его Непредсказуемым болваном. Точное описание.* ]],
                    next = "d_g9",
                },
            },
        },
        d_g18 = {
            text = [[Почувствуй пламя моих цепей!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Не гасите мои угли...]],
                    next = "d_g9",
                },
            },
        },
        d_g19 = {
            text = [[Ты НЕ ВНИК в суть. Похоже нам с тобой не по пути.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Суть чего? Ладно, давай ещё раз.]],
                    next = "d_g9",
                },
            },
        },
        d_g2 = {
            text = [[*Он начинает хихикать*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_g3",
                },
            },
        },
        d_g20 = {
            text = [[СПАСИБО, Я ВСЁ ПОНЯЛ, СПАСИБО. ВТОРОЕ ПРИШЕСТВИЕ НАЯВУ. Я СДЕРЖУ ТВОЁ ОБЕЩАНИЕ. Аминь.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Аминь.]],
                    next = "d_g21",
                },
            },
        },
        d_g21 = {
            text =
            [[*Он вошёл в невидимость и убежал. Хоть ты его и не видел, но ты знал, что Синий, с этого момента, вознёсся.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_g3 = {
            text = [[А знаешь КТО Я?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Нет.]],
                    next = "d_g4",
                },
                {
                    text = [[И не хочу знать.]],
                    next = "d_g4",
                },
            },
        },
        d_g4 = {
            text = [[Я - ШТООООРМ СПИИРИИИИИИТ!!!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Нет]],
                    next = "d_net",
                },
                {
                    text = [[Почти уверен, что нет.]],
                    next = "d_pochti_uveren_chto_net",
                },
                {
                    text = [[Ну может чуть-чуть]],
                    next = "d_nu_mozhet_chutchut",
                },
            },
        },
        d_g5 = {
            text = [[*Он отскакивает обратно, ходит из стороны в сторону, чувствуя себя преданным.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_voobschem_ty_sinij",
                },
            },
        },
        d_g6 = {
            text =
            [[ООО ОО, я придумал!!! Давай ДАВАЙ если ты пройдешь тест на совместимость со МНОЙ, то я что угодно сделаю. ДА]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Ладно.]],
                    next = "d_g7",
                },
                {
                    text = [[Ты же понимаешь, что я могу тебя просто избить и забрать?]],
                    next = "d_ty_zhe_ponimaesh_chto_ya_mogu_tebya_prosto_izbit_i_zabrat",
                },
            },
        },
        d_g7 = {
            text = [[Тогда начинаем!!!!!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Морально подготовиться.*]],
                    next = "d_g9",
                },
            },
        },
        d_g8 = {
            text = [[Нееееет, КТО БЫ ЭТО ВООБЩЕ ВЗЯЛ??? Похоже нам с тобой не по пути.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Давай ещё раз!]],
                    next = "d_g9",
                },
            },
        },
        d_g9 = {
            text = [[Ты попал на необитаемый остров. ТЫ можешь взять только одну вещь, какую?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Кружку.]],
                    next = "d_g8",
                },
                {
                    text = [[Монополию.]],
                    next = "d_monopoliu",
                },
                {
                    text = [[Полотенце.]],
                    next = "d_g8",
                },
                {
                    text = [[Ножовку по металлу.]],
                    next = "d_g8",
                },
            },
        },
        d_h = {
            text = [[Я - гид этого Королевства. Все прибывшие в первую очередь встречаются со мной.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Ты знаешь как я сюда попал?]],
                    next = "d_ty_znaesh_kak_ya_suda_popal",
                },
            },
        },
        d_h10 = {
            text = [[Прекрасное имя.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Да.]],
                    next = "d_da__2",
                },
            },
        },
        d_h2 = {
            text = [[Нет, наши души где-то в промежутке. ]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[То есть я не смогу вернуться?]],
                    next = "d_to_est_ya_ne_smogu_vernutsya",
                },
            },
        },
        d_h3 = {
            text = [[Я удивлена, что ты дошёл до сюда. Обычно на всех новоприбывших нападают крипы у ворот.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Я убил их.]],
                    next = "d_ya_ubil_ih",
                },
            },
        },
        d_h4 = {
            text = [[На востоке - Пустоши. Ступившего в них ожидает только смерть...]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[*Далее.*]],
                    next = "d_h5",
                },
            },
        },
        d_h5 = {
            text = [[На севере - Система подземных путей, ведущих на территории, где поселились "новые" люди.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [["Новые" люди?]],
                    next = "d_novye_ludi",
                },
            },
        },
        d_h6 = {
            text = [[Чтож, пора рассказать о нашем Королевстве, я же всё-таки гид. Что тебе интересно?]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Что за пределами Королевства?]],
                    next = "d_chto_za_predelami_korolevstva",
                },
                {
                    text = [[Что за портал сзади?]],
                    next = "d_chto_za_portal_szadi",
                },
                {
                    text = [[Что за Король?]],
                    next = "d_chto_za_korol",
                },
                {
                    text = [[Больше вопросов нету.]],
                    next = "d_bolshe_voprosov_netu",
                },
            },
        },
        d_h7 = {
            text = [[Жду не дождусь результатов. Слава Королю!]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_h8 = {
            text = [[На юго-западе - Владения двух Каменных Принцов. Они никак не могут поделить свои земли.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[*Далее.*]],
                    next = "d_h4",
                },
            },
        },
        d_i = {
            text = [[Вообщем хорошего дня тебе, друг. В нашем Королестве всегда весело.]],
            speaker = [[npc_creep_rogach]],
            choices = {
                {
                    text = [[И тебе хорошего.]],
                    next = "d_i_tebe_horoshego",
                },
            },
        },
        d_i2 = {
            text =
            [[Владыка пустоши меня просто в землю втопчет... Нет ни одного существа, кто ему ровня. Радует, что он не нападает, а только обороняется...]],
            speaker = [[npc_mustache]],
            choices = {
                {
                    text = [[Тогда зачем с ним связываться?]],
                    next = "d_togda_zachem_s_nim_svyazyvatsya",
                },
            },
        },
        d_i3 = {
            text = [[Как думаешь, почему людей так мало?]],
            speaker = [[npc_mustache]],
            choices = {
                {
                    text = [[Ну... может разъехались.]],
                    next = "d_nu_mozhet_razehalis",
                },
            },
        },
        d_i4 = {
            text =
            [[*После этих слов, усач резко изменился. Вся задорность исчезла. Остался только его глубокий голос.*]],
            speaker = [[npc_mustache]],
            choices = {
                {
                    text = [[Что это за взгляд?]],
                    next = "d_i5",
                },
            },
        },
        d_i5 = {
            text = [[Ты умрёшь, уходи.]],
            speaker = [[npc_mustache]],
            choices = {
                {
                    text = [[Чего усатый?]],
                    next = "d_chego_usatyj",
                },
            },
        },
        d_i6 = {
            text = [[Меня зовут Боб!]],
            speaker = [[npc_creep_bob]],
            choices = {
                {
                    text = [[Помощь нужна?]],
                    next = "d_pomosch_nuzhna",
                },
            },
        },
        d_i7 = {
            text = [[Как меня зовут?!]],
            speaker = [[npc_creep_bob]],
            choices = {
                {
                    text = [[Тебя зовут Боб.]],
                    next = "d_tebya_zovut_bob",
                },
                {
                    text = [[Тебя зовут Джон.]],
                    next = "d_tebya_zovut_dzhon",
                },
                {
                    text = [[Тебя зовут Алекс.]],
                    next = "d_tebya_zovut_aleks",
                },
            },
        },
        d_i8 = {
            text = [[*Крип сильно расстроился. Его не покидает ощущение, что что-то не так.*]],
            speaker = [[npc_creep_bob]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_i9 = {
            text = [[Отлично. Проходи.]],
            speaker = [[npc_blue_prince]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_j = {
            text = [[Выходи один на один, уёбок.]],
            speaker = [[npc_monkey_king]],
            choices = {
                {
                    text = [[Начнём дуэль.]],
                    next = "d_nachnem_duel",
                    actions = {
                        { target = "talk", type = "fight_start" },
                    },
                },
            },
        },
        d_j2 = {
            text = [[Однако мне не попасть туда...]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Как так?]],
                    next = "d_kak_tak",
                },
            },
        },
        d_j3 = {
            text = [[Ну... ладно...]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_j4 = {
            text = [[Серьёзно?! Но как?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Я найду перекупа и заберу билеты. Скажи где он.]],
                    next = "d_ya_najdu_perekupa_i_zaberu_bilety_skazhi_gde_on",
                },
            },
        },
        d_k = {
            text = [[Эта сказака о двух кроликах, нашедших сад Нефелима.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k1",
                },
            },
        },
        d_k1 = {
            text =
            [[Первый кролик имел белоснежную окраску. Он бегал по лесу, как вдруг обнаружил необычайно высокий забор. Будучи крохой, ему не составило труда протиснуться.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k2",
                },
            },
        },
        d_k10 = {
            text =
            [[Он был очень ленивым. Узнав о том, что Нефелим может исполнить любое желание, ему пришла в голову интересная идея.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k23",
                },
            },
        },
        d_k11 = {
            text =
            [["Жертвую жизнями половины морковок на то, чтобы другая половина начала сама маршировать мне в живот,"- вскрикнул он.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k12",
                },
            },
        },
        d_k12 = {
            text =
            [[Больше недели морковки шли в его пасть, оставалось лишь пережёвывать их. Очень рад он был такой жизни.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k13",
                },
            },
        },
        d_k13 = {
            text =
            [[Однако случилось непредвиденное. Морковок в саду было нечётное количество. И последняя морковка, не околдаванная чарами Нефелима, осознала, что произошло.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k14",
                },
            },
        },
        d_k14 = {
            text = [[Захотев отомстить за других, она подошла к кролику и проткнула его брюхо. ]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k15",
                },
            },
        },
        d_k15 = {
            text = [[Вспоров его живот, морковка увидела, что своих сородичей ей уже не спасти.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k16",
                },
            },
        },
        d_k16 = {
            text =
            [[Параллельно этому, из-за опустошения полей, взрыхлённая земля обвалилась, засыпав нору, созданную первым кроликом.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k17",
                },
            },
        },
        d_k17 = {
            text =
            [[Отныне все звери, попавшие в сад, оставались здесь до конца своих дней. Кто-то веселился, кто-то горевал. Однако все лицезрели истерзанный труп чёрного кролика.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k18",
                },
            },
        },
        d_k18 = {
            text =
            [[Это было наказанием, совершённым демонической половиной Нефелима. Она сковала душу чёрного кролика с его мёртвым телом, заставив того постоянно чувствовать боль.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k19",
                },
            },
        },
        d_k19 = {
            text = [[Навечно.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k24",
                },
            },
        },
        d_k2 = {
            text =
            [[Перед его глазами раскинулся серебристый сад. Вокруг были огроменные поля моркови и ручьи кристальной воды. Прекасное место.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k20",
                },
            },
        },
        d_k20 = {
            text =
            [[Однако, когда он обернулся, то заметил, что все расщелины в заборе захлопнулись. Кролику отсюда уже не выбраться.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k3",
                },
            },
        },
        d_k21 = {
            text =
            [[Кролик быстро осознал, насколько ужасное это место. Он не мог вынести мысли, что кто-то тоже может оказаться в этой ловушке.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k7",
                },
            },
        },
        d_k22 = {
            text = [[Какое-то время спустя в сады попал и чёрный кролик.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k10",
                },
            },
        },
        d_k23 = {
            text = [[Позвав его, кролик указал пальцем на обширные поля.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k11",
                },
            },
        },
        d_k24 = {
            text = [[Навечно...]],
            speaker = [[default]],
            choices = {
                {
                    text = [[В этом что-то есть.]],
                    next = "d_v_etom_chtoto_est",
                },
            },
        },
        d_k3 = {
            text =
            [[Послышались шаги. Перед ним явился владелец сада - Нефилим. Он произнёс: "Ты - первый, кто смог попасть сюда. Поздравляю."]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k4",
                },
            },
        },
        d_k4 = {
            text =
            [[Кролик спросил: "А ты же выпустишь меня обратно?"Нефилим покачал головой, добавив: "Теперь это - твой дом."]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k5",
                },
            },
        },
        d_k5 = {
            text =
            [["Не расстраивайся, я могу исполнить любое твоё желание, однако заплатить придётся чьей-то жизнью. Выбирай кого угодно." ]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k6",
                },
            },
        },
        d_k6 = {
            text = [[Любой другой мог бы быть опьянён таким предложением, но только не он.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k21",
                },
            },
        },
        d_k7 = {
            text =
            [[Поэтому, собравшись с духом, кролик произнёс: "Выкопай нору, что позволит любому вошедшему вернуться домой. Моей жизни должно быть достаточно."]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k8",
                },
            },
        },
        d_k8 = {
            text =
            [[Ангельская половина Нефелима была восхищена его решимостью, так что, исполнив желание, одарила кролика безболезненной смертью и упокоила его душу. ]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k9",
                },
            },
        },
        d_k9 = {
            text = [[С тех пор любой зверёк, попавший в сад, в скором времени покидал его, возвращаясь в леса.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k22",
                },
            },
        },
        d_l = {
            text = [[2 монеты!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[1 монета!]],
                    next = "d_l1",
                },
            },
        },
        d_l1 = {
            text = [[1 монета!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[0 монет!]],
                    next = "d_0_monet",
                },
            },
        },
        d_l10 = {
            text =
            [[И тот дракон харкнул в брата огнём. Я почуял, что он может подгореть, потому плюнул в него, чтоб напугать! Так он и увернулся.]],
            speaker = [[npc_ogre_magi_fast]],
            choices = {
                {
                    text = [[...]],
                    next = "d_l11",
                },
            },
        },
        d_l11 = {
            text =
            [[Вообще-то это я его спас, оттащив брата за дубину, которой он замахивался. Дракон промахнулся из-за меня!]],
            speaker = [[npc_ogre_magi_slow]],
            choices = {
                {
                    text = [[...]],
                    next = "d_l12",
                },
            },
        },
        d_l12 = {
            text =
            [[2: Никто не поверит в твои бредни, ты слишком медлительный для такого!1: Я вообще не помню, чтоб ты что-то делал. Значит ты этого не делал!]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[Тихо, к чему вообще эта история?]],
                    next = "d_tiho_k_chemu_voobsche_eta_istoriya",
                },
            },
        },
        d_l13 = {
            text =
            [[1: Брат сказал, что сделает нас умнее. Он отправился искать Мантию на интеллект.2: Хотя куда умнее то!]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[Что за Мантия?]],
                    next = "d_chto_za_mantiya",
                },
            },
        },
        d_l14 = {
            text = [[2: Похоже Мантию стоит отдать тебе!!1: Хорошо ты его!]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[*Я что, реально тупее их?*]],
                    next = "d_l15",
                },
            },
        },
        d_l15 = {
            text = [[1: Когда найдёшь его - скажи, чтоб шёл домой!2: И мантию прихвати нам!]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[Ладно.]],
                    next = "d_ladno",
                    actions = {
                        { questID = "q_ogres", type = "quest_start" },
                    },
                },
                {
                    text = [[Давайте сами.]],
                    next = "d_davajte_sami",
                },
            },
        },
        d_l2 = {
            text = [[*Ты принимаешь агрессивную позу.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Каково это скупать билеты, заставляя бедных страдать?]],
                    next = "d_kakovo_eto_skupat_bilety_zastavlyaya_bednyh_stradat",
                },
            },
        },
        d_l3 = {
            text = [[Билеты на данный момент по самой большой скидке: всего 500 золота за штуку!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Дорого.]],
                    next = "d_dorogo",
                },
            },
        },
        d_l4 = {
            text = [[*От счастья он запрыгал.*Спасибо, спасибо!! Ты реально оу джи, кекс! Ты лучший!!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Хорошо, хорошо. Я кстати тоже пойду.]],
                    next = "d_horosho_horosho_ya_kstati_tozhe_pojdu",
                },
            },
        },
        d_l5 = {
            text =
            [[*2-ая голова начала говорить пискляво и резко.*А колёса твои где? Хихи хи. Неужто уже зима, на лыжи пересел?]],
            speaker = [[npc_ogre_magi_fast]],
            choices = {
                {
                    text = [[...]],
                    next = "d_l6",
                },
            },
        },
        d_l6 = {
            text = [[Как по твоему я поставлю лыжи на коня. Ты вообще не понимаешь чтоли..? У них копыта.]],
            speaker = [[npc_ogre_magi_slow]],
            choices = {
                {
                    text = [[...]],
                    next = "d_l7",
                },
            },
        },
        d_l7 = {
            text = [[Никак! Сейчас же лето. Воооо! Я бы налепил на них ролики!]],
            speaker = [[npc_ogre_magi_fast]],
            choices = {
                {
                    text = [[...]],
                    next = "d_l8",
                },
            },
        },
        d_l8 = {
            text = [[На кого?]],
            speaker = [[npc_ogre_magi_slow]],
            choices = {
                {
                    text = [[Эх...]],
                    next = "d_eh",
                },
            },
        },
        d_l9 = {
            text = [[Хиихи хих. Не может быть! После встречи с гидом он стал мокреньким, так мы его только согреем!]],
            speaker = [[npc_ogre_magi_fast]],
            choices = {
                {
                    text = [[В принципе я понял, вы два даунича.]],
                    next = "d_v_printsipe_ya_ponyal_vy_dva_daunicha",
                },
            },
        },
        d_m = {
            text = [[Я не могу снять её.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Причина?]],
                    next = "d_prichina",
                },
            },
        },
        d_m1 = {
            text =
            [[До Мантии, моя жизнь была примитивной и бессмысленной, сейчас же полна новых открытий и откровений. ]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Ты ведь обещал отдать Мантию им.]],
                    next = "d_ty_ved_obeschal_otdat_mantiu_im",
                },
            },
        },
        d_m2 = {
            text = [[Моя позиция тверда, ничто не изменит её. Уходи.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Знаешь... Мне грустно смотреть на тебя.]],
                    next = "d_znaesh_mne_grustno_smotret_na_tebya",
                },
            },
        },
        d_m3 = {
            text = [[Не нравится мне убивать. Это глупо, тем более ты хороший человек.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Мне тоже, однако выбора нет.]],
                    next = "d_mne_tozhe_odnako_vybora_net",
                },
            },
        },
        d_m4 = {
            text = [[*Огр хватает твою руку.*Сорвав её, я умру, ты ведь это понимаешь?]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Нет. Я оставлю тебя в живых.]],
                    next = "d_net_ya_ostavlu_tebya_v_zhivyh",
                },
            },
        },
        d_m5 = {
            text =
            [[*Несколько минут ты смотришь на его труп. В мылсях мелькают фразы из вашего диалога. Ты решаешься не брать мантию.*]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_m6 = {
            text = [[*Он отправился жить. Ты уверен, это его последний день в этих землях.*]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_m7 = {
            text = [[Так и где этот болван?!]],
            speaker = [[npc_ogre_magi_fast]],
            choices = {
                {
                    text = [[Он не вернётся.]],
                    next = "d_on_ne_vernetsya",
                },
                {
                    text = [[Он умер.]],
                    next = "d_on_umer",
                },
            },
        },
        d_m8 = {
            text = [[*Огр обнял сам себя.*]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_m9 = {
            text =
            [[Ты победил в честном поединке.*Сказано это было очень спокойно и уверенно. Он ждёт твоих действий.*]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Почему ты не пытаешься сбежать?]],
                    next = "d_pochemu_ty_ne_pytaeshsya_sbezhat",
                },
            },
        },
        d_n = {
            text = [[Чудненькое имя. А сколько тебе лет?]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[20.]],
                    next = "d_20",
                },
                {
                    text = [[14.]],
                    next = "d_14",
                },
            },
        },
        d_n1 = {
            text = [[О, вот и наша героиня прибыла, иди к ней!]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_n2 = {
            text =
            [[После, из деревьев вышли какие-то люди и связали нас, бросив в клетку. Мы ниичего не видели, однако уверены, там что-то важное.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Понимаю к чему вы ведёте.]],
                    next = "d_ponimau_k_chemu_vy_vedete",
                },
            },
        },
        d_n3 = {
            text = [[Так вы давно охотитесь за этим Эпштейном?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Да, он грязный тип.]],
                    next = "d_da_on_gryaznyj_tip",
                },
            },
        },
        d_n4 = {
            text = [[От неё не сбежать - она часть тебя. Позволь ей слиться с тобой.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Зачем?]],
                    next = "d_zachem",
                },
            },
        },
        d_n5 = {
            text = [[Симфония.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Этот мир спасён.]],
                    next = "d_n6",
                },
            },
        },
        d_n6 = {
            text = [[*Крипы застыли от ужаса.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Расслабтесь, котики. Сам Эпштейн сказал, что остров пуст.]],
                    next = "d_rasslabtes_kotiki_sam_epshtejn_skazal_chto_ostrov_pust",
                },
            },
        },
        d_n7 = {
            text = [[Что это значит?!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Сегодня ты умрёшь во второй раз.]],
                    next = "d_n8",
                },
            },
        },
        d_n8 = {
            text =
            [[*Он впервые занервничал.*Л..Ладно извини за всё, я реально вёл себя плохо. Что я могу сделать для тебя?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Сядь. Закрой глаза и считай до тысячи.]],
                    next = "d_syad_zakroj_glaza_i_schitaj_do_tysyachi",
                },
            },
        },
        d_n9 = {
            text = [[Однако, если тебя, то он выдаст тебе кодовую фразу. Произнеси её и я позволю тебе пройти.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Хмм...]],
                    next = "d_hmm",
                },
            },
        },
        d_a_gde_mne_ih_iskat = {
            text =
            [[Где-то в этом мире, сам не знаю. Я вижу их постоянно, но не могу усмирить. Может и тебе посчастливиться встретить их.]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[Красный - гневный, Зелёный - упрямый, Синий - своевольный. Запомнил.]],
                    next = "d_a4",
                },
            },
        },
        d_a_gde_on = {
            text = [[Он покинул нас.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[В каком смысле?]],
                    next = "d_v_kakom_smysle",
                },
            },
        },
        d_a_esli_ya_projdu = {
            text = [[Тогда с цмки одежда сама сползёт.]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[Принято.]],
                    next = "d_prinyato",
                },
            },
        },
        d_a_esli_ya_hochu_tuda_popast = {
            text =
            [[Тогда нужно, чтобы кто-то из наших посчитал тебя достойным и позволил присоединиться к нашим исследованиям.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[А как мне получить эту рекомендацию?]],
                    next = "d_a_kak_mne_poluchit_etu_rekomendatsiu",
                },
            },
        },
        d_a_zachem_tebe = {
            text =
            [[Тут неподалёку есть гетто, но там все живут по понятиям, а я ничего не знаю... Даже говорить с ними боюсь, ведь у них своя уникальная манера речи...]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Прийти неподготовленным в гетто реально опасно.]],
                    next = "d_prijti_nepodgotovlennym_v_getto_realno_opasno",
                },
            },
        },
        d_a_zvat_to_ih_kak = {
            text = [[Имена?.. Хм... Не припоминаю, я к ним всегда обращаюсь по цвету.]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[А где мне их искать?]],
                    next = "d_a_gde_mne_ih_iskat",
                },
                {
                    text = [[Красный - гневный, Зелёный - упрямый, Синий - своевольный. Запомнил.]],
                    next = "d_a4",
                },
            },
        },
        d_a_kak_zhe_korol = {
            text = [[Ты давай, ротик прикрывай. Пока Короля нету, правлю здесь я.]],
            speaker = [[npc_monkey_king]],
            choices = {
                {
                    text = [[То есть Король - чмо?]],
                    next = "d_to_est_korol_chmo",
                },
            },
        },
        d_a_kak_zhe = {
            text =
            [[В Заброшенном лесу проживает крип-предвестник, и каждые 3 года он рассказывает о приближающейся опасности.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Ого.]],
                    next = "d_ogo",
                },
            },
        },
        d_a_kak_mne_poluchit_etu_rekomendatsiu = {
            text = [[Не имею понятия. Охрана тайн - вот моя миссия.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_n9",
                },
            },
        },
        d_a_kripy_eto_kto = {
            text =
            [[Мы не знаем, но они населяли эти земли ещё до появления людей. Кстати, некоторые крипы хорошие, они даже проживают с нами.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Ты сказала, что людей мало. Почему?]],
                    next = "d_ty_skazala_chto_ludej_malo_pochemu",
                },
            },
        },
        d_a_kuda_on_otpravilsya = {
            text = [[Он пошёл на запад! Боюсь ты не знаешь где это, хих.]],
            speaker = [[npc_ogre_magi_fast]],
            choices = {
                {
                    text = [[Это сверху.]],
                    next = "d_l14",
                },
                {
                    text = [[Это справа.]],
                    next = "d_l14",
                },
                {
                    text = [[Это слева.]],
                    next = "d_eto_sleva",
                },
                {
                    text = [[Это снизу.]],
                    next = "d_l14",
                },
            },
        },
        d_a_menya_zovu = {
            text = [[Меня зовут Боб.]],
            speaker = [[npc_creep_bob]],
            choices = {
                {
                    text = [[...]],
                    next = "d_i6",
                },
            },
        },
        d_a_pochemu_ty_ne_verneshsya_domoj = {
            text = [[Почему? Ты должен сам понимать.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Нет, не понимаю.]],
                    next = "d_net_ne_ponimau",
                },
            },
        },
        d_a_u_kogo_ya_b_tozhe_podvypil = {
            text = [[Не скажу.]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[Почему?]],
                    next = "d_pochemu",
                },
            },
        },
        d_a_che_sam_ne_pojdesh_togda_a = {
            text = [[*Усач громко вздохнул.*Я и сам слишком слаб...]],
            speaker = [[npc_mustache]],
            choices = {
                {
                    text = [[...]],
                    next = "d_i2",
                },
            },
        },
        d_a_nu_da = {
            text =
            [[Ты возьмёшь взрывчатку, отправишься на остров и пройдешь через секкретный проход в деревьях. Поставишь бомбу и, пройдя полосу, вернёшься через станцию подземных путей. Готов?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Взорвём Эпштейна!]],
                    next = "d_vzorvem_epshtejna",
                },
                {
                    text = [[Ща занят, ребятня.]],
                    next = "d_scha_zanyat_rebyatnya",
                },
            },
        },
        d_a = {
            text =
            [[*Зелёный выпускает ошеломляющий разряд, отчего ближайшие камни отлетают во все стороны. Впрочем, как и ты. Но для тебя это летальный исход.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_aleks_umret_za_tebya_ty_legenda_ty_m = {
            text = [[*Тебя перебил человек из толпы, схватив за плечо.*Слышь, щегол. Я главный фанат Ксавьера, уяснил?!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Съеби.]],
                    next = "d_sebi",
                },
            },
        },
        d_aaaaaharr_arghe_shuufuvuu = {
            text =
            [[*Твоё яростное сердцебиение перебивает его голос, отчего ты не можешь разобрать текст. Хотя ты в любом случае не можешь.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Стоп, если он здесь... Неужто?..*]],
                    next = "d_stop_esli_on_zdes_neuzhto",
                },
            },
        },
        d_aga = {
            text =
            [[Даже тогда, когда я был уверен в правоте оппонента, я старался убедить себя в обратном и шёл на дешёвые прииёмы: угрозы, запугивания и даже избиения.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_d5",
                },
            },
        },
        d_aleks = {
            text = [[Круто. А я крип-рогач, знаешь почему?]],
            speaker = [[npc_creep_rogach]],
            choices = {
                {
                    text = [[Возможно из-за рогов.]],
                    next = "d_vozmozhno_izza_rogov",
                },
            },
        },
        d_amin = {
            text = [[ПОЗДРАВЛЯЮ ТЫ ПРОШЁЛ ТЕСТ!! Отныне МЫ с тобой БРАТЬЯ на века!!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Насчёт братьев, возвращайся к ним.]],
                    next = "d_naschet_bratev_vozvraschajsya_k_nim",
                },
            },
        },
        d_beru_kachestvom = {
            text = [[Берёшь куда?]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[Проехали, так чем он вам отплатил?]],
                    next = "d_l13",
                },
            },
        },
        d_bilety_na_kontsert_eto_zhe_ty_ih_prodaesh = {
            text = [[Да-с. По самым низким ценам, и, конечно, самые лучшие. В первый ряд!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Пригрозить ему.*]],
                    next = "d_l2",
                },
                {
                    text = [[*Торговаться с ним.*]],
                    next = "d_l3",
                },
            },
        },
        d_bolshe_voprosov_netu = {
            text = [[Хорошо. Кстати, я так и не спросила твоего имени...]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Меня зовут...]],
                    next = "d_menya_zovut",
                },
            },
        },
        d_bhh_haaa_eosh = {
            text = [[Вход в деревню не доступен болванам.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_byvaj = {
            text = [[Тогда, как вернёшься, я сниму их с тебя и убегу, слышишь?!]],
            speaker = [[npc_rape_victim]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_v_pustoshah_krip_predlagal_mne_za_150_otdat = {
            text = [[Оооох, думаю тебя обманывают, паренёк... Нигде по таким ценам не продают.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Пошли со мной, покажу.]],
                    next = "d_poshli_so_mnoj_pokazhu",
                },
            },
        },
        d_v_kakom_smysle = {
            text = [[*Она не отвечает.*]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Понятно.]],
                    next = "d_h6",
                },
            },
        },
        d_v_printsipe_ya_ponyal_vy_dva_daunicha = {
            text = [[НЕТ! Мы довольно смышлённые, даже думать умеем! А вдвоём наш разум увеличивается в три раза!]],
            speaker = [[npc_ogre_magi_slow]],
            choices = {
                {
                    text = [[Почему в три.]],
                    next = "d_pochemu_v_tri",
                },
            },
        },
        d_v_sebe = {
            text =
            [[2: Как можно вообще потеряться в себе, он внутри своей головы живёт?1: Это невозможно. скорее всего он заблудиился.]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[*Уйти.*]],
                    next = "d_ujti",
                    actions = {
                        { questID = "q_ogres", type = "quest_end" },
                    },
                },
            },
        },
        d_v_etom_chtoto_est = {
            text = [[*Человек-сказитель, не проронив ни слова, закрыл глаза и начал медитировать.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_vau = {
            text =
            [[Прямо сейчас я послала достаточный импульс, который позволит избранным прорваться и сделать тебя совершенным. Достойными оказались трое.]],
            speaker = [[npc_shamanka]],
            choices = {
                {
                    text = [[*Выбрать свою судьбу.*]],
                    next = "d_vybrat_svou_sudbu",
                },
            },
        },
        d_vash_brat_tak_skazal = {
            text = [[Так ты нашёл его? Он всё ещё ходит с той огромной дубиной, да?]],
            speaker = [[npc_ogre_magi_slow]],
            choices = {
                {
                    text = [[...]],
                    next = "d_m7",
                },
            },
        },
        d_verno = {
            text =
            [[Как вообще я могу быть счастливым, пока они порознь? Это не жизнь. Приходится запивать горе своё. Пока они не воссоединяться, не смогу найти себе места.]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[...]],
                    next = "d_a3",
                },
            },
        },
        d_vzaimno = {
            text = [[*Довольный перекуп пересчитывает невидимые монеты, пока ты вертишь билеты у себя в руках.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_vzorvem_epshtejna = {
            text =
            [[*Тебе выдали зелёную бочку. Выглядит она не впечатляюще, однако взрывная сила у неё - колоссальная.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_vizhu_ty_s_ludmi_horosho_ladish = {
            text = [[Да, мы и люди - инь янь, понимаешь? Всё время вместе. Но...]],
            speaker = [[npc_creep_rogach]],
            choices = {
                {
                    text = [[Но?]],
                    next = "d_no__1",
                },
            },
        },
        d_vneshka_ne_vazhna_ponimaesh_sila_vnutri = {
            text =
            [[Знаешь, ты октрыл мне глаза. Всё время я смотрел на остальных сверху вниз, но почему? Даже не пытался выслушать их. Может ли быть такое, что... я просто надменный?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*С уважением кивнуть.*.]],
                    next = "d_aga",
                },
                {
                    text = [[Ага.]],
                    next = "d_aga",
                },
            },
        },
        d_vo_vo = {
            text = [[Хорошо, хорошо... Семь твоих монет на два билета. По рукам?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Не сходится.]],
                    next = "d_ne_shoditsya",
                },
            },
        },
        d_vozmozhno_izza_rogov = {
            text = [[В точку, братан.]],
            speaker = [[npc_creep_rogach]],
            choices = {
                {
                    text = [[Вижу ты с людьми хорошо ладишь?]],
                    next = "d_vizhu_ty_s_ludmi_horosho_ladish",
                },
            },
        },
        d_voobschem_ty_sinij = {
            text = [[Сразу отвечу: никуда Я НЕ ПОЙДУ. В данный момент я - ВОЛК, значит где-то существует КАПКАН..]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Я не надеюсь, что ты меня послушаешь, но надеюсь что ты вернёшься к отцу и братьям...]],
                    next = "d_ya_ne_nadeus_chto_ty_menya_poslushaesh_no_nadeus_chto_ty_verneshsya_k_ottsu_i_bratyam",
                },
                {
                    text = [[Я думал ты шторм спирит.]],
                    next = "d_ya_dumal_ty_shtorm_spirit",
                },
            },
        },
        d_voobschem_ty_pidorasik = {
            text = [[ЧЕГО?!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Ухмыльнуться и начать хлюпать.*]],
                    next = "d_uhmylnutsya_i_nachat_hlupat",
                    actions = {
                        { music = "hlup1", type = "music_start" },
                    },
                },
            },
        },
        d_vot_tvoj_bilet_chernomazyj = {
            text =
            [[*Он взял билет, словно реликвию. Сначала посмотрел на него, потом на тебя, потом на него. А потом снова на тебя...*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_l4",
                },
            },
        },
        d_vsego = {
            text = [[Великая мудрость... Что ж, свидимся позже.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_vsmysle_isporchennaya = {
            text = [[У каждого есть своя Тень. Та, что ходит за тобой по пятам. Та, от которой не скрыться.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_n4",
                },
            },
        },
        d_vy_voobsche_chto_takoe = {
            text = [[*Главный начал разговор.*Ооо новичок подъехал, мы таких любим.]],
            speaker = [[npc_creep_troll]],
            choices = {
                {
                    text = [[...]],
                    next = "d_g",
                },
            },
        },
        d_vy_edinoe_tseloe_ili_dve_lichnosti = {
            text =
            [[*1-ая голова начала говорить медленным занудным тоном.*ТЫ... ээээ.. Я Шофёр лимузина. Вожу важных персон. На машине... На конях...]],
            speaker = [[ogre_magi_slow]],
            choices = {
                {
                    text = [[...]],
                    next = "d_l5",
                },
            },
        },
        d_vy_ochen_raznye_no_vy_vse_bratya_primi_ih_takimi_kakie_est_i_oni_proyavyat_uvazhenie_i_k_tebe_vy_snova_stanete_semej = {
            text = [[ТЫ ДЕБИЛЬНЫЙ ДАУН. ПРЯМ ДАУНСКИЙ ДЕБИЛ.]],
            speaker = [[default]],
            choices = {
                {
                    text =
                    [[Отец любит тебя, и братья любят. Все ждут тебя. Вернись домой, умоляю тебя. Семья - самое важное на свете.]],
                    next =
                    "d_otets_lubit_tebya_i_bratya_lubyat_vse_zhdut_tebya_vernis_domoj_umolyau_tebya_semya_samoe_vazhnoe_na_svete",
                },
            },
        },
        d_vy_svobodny_ubegajte = {
            text = [[*Поочерёдно крипы встали и поклонились тебе.*]],
            speaker = [[npc_cat_barrel]],
            choices = {
                {
                    text = [[*Ты кланяешься в ответ.*]],
                    next = "d_ty_klanyaeshsya_v_otvet",
                },
            },
        },
        d_vysvobozhdenie = {
            text = [[Высвобождение? А высвобождение чего?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Всего.]],
                    next = "d_vsego",
                },
            },
        },
        d_gde_detonator = {
            text = [[У нас! А на острове случайно не остались заложники, какими однажды были мы.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Эм... Вроде нет.]],
                    next = "d_em_vrode_net",
                },
            },
        },
        d_gde_tsmka = {
            text = [[Чуть дальше. Скажи, красавчик, сколько тебе лет?]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[20.]],
                    next = "d_20",
                },
                {
                    text = [[14.]],
                    next = "d_14",
                },
            },
        },
        d_govori = {
            text =
            [[Меня заинтересовал твой кулак, дробящий камни. Меня, Твердолобого, никто за всё время не смог меня ни переубедить, ни сдвинуть...]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_f",
                },
            },
        },
        d_gotovo = {
            text = [[*Резкий звук доносится из динамиков.*ЧТО ГОТОВО?!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Я санта клаус сегодня.]],
                    next = "d_ya_santa_klaus_segodnya",
                },
            },
        },
        d_da = {
            text =
            [[*Ноги начали вести тебя ближе к сцене. Словно собака, ты готов показать всем насколько ты предан своему хозяину. Вобрав кучу воздуха через свой нос, ты заряжаешь самый громкий крик, который человек способен воспроизвести.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[КСАВЬЕР Я ТВОЙ САМЫЙ ГЛАВНЫЙ ФАНАТ!!!!!!!!!]],
                    next = "d_ksaver_ya_tvoj_samyj_glavnyj_fanat",
                },
            },
        },
        d_da_net_mne_dazhe_ponravilos_s_toboj_razgovarivat_momentami = {
            text = [[ДА?!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Пизда. Оставайся собой, но старайся уделять внимание собеседнику.]],
                    next = "d_pizda_ostavajsya_soboj_no_starajsya_udelyat_vnimanie_sobesedniku",
                },
            },
        },
        d_da_nichego_takogo = {
            text =
            [[Мы попались на такую примитивную ловушку. Вечный позор нам. А ведь мы даже не знаем кто такая цмка...*Все крипы поникли в лице.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Я тоже попался.]],
                    next = "d_ya_tozhe_popalsya",
                },
                {
                    text = [[Я отправился спасать вас.]],
                    next = "d_ya_otpravilsya_spasat_vas",
                },
            },
        },
        d_da_ya = {
            text = [[А кто рассказал о нас?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Эээ... Я детектив. Сам нашёл.]],
                    next = "d_n3",
                },
            },
        },
        d_da__1 = {
            text = [[*Усач разлился хохотом*Не думал, что в мире остались люди с яйцами!]],
            speaker = [[npc_mustache]],
            choices = {
                {
                    text = [[Огромными, прошу заметить.]],
                    next = "d_ogromnymi_proshu_zametit",
                },
            },
        },
        d_da_on_gryaznyj_tip = {
            text = [[Мы хотим отплатить ему за то, что он сделал. Не поможете нам?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Какой план у вас?]],
                    next = "d_kakoj_plan_u_vas",
                },
            },
        },
        d_da_oni_svoebraznye_no_hotya_by_provedaj_ih = {
            text = [[Тебе не понять насколько мерзки они для меня. ]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Но...]],
                    next = "d_no",
                },
            },
        },
        d_da__2 = {
            text = [[Алекс, а такой красивый юноша мог бы выполнить скромную просьбу юной девушки.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[А как же.]],
                    next = "d_a_kak_zhe",
                },
            },
        },
        d_davaj = {
            text = [[Кстати, есть чем протереть мне голову?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Как я помню, панда носит с собой полотенце.]],
                    next = "d_kak_ya_pomnu_panda_nosit_s_soboj_polotentse",
                },
            },
        },
        d_davajte_pokonchim_s_etim = {
            text = [[*Кот-бочка снимает со своего хвоста детонатор и с честью протягивает тебе.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Нажать на сочную красную кнопку.*]],
                    next = "d_nazhat_na_sochnuu_krasnuu_knopku",
                },
            },
        },
        d_davajte_sami = {
            text = [[1: Похоже мы больше никогда не встретим брата...2: Судьба плохо обходится с умными, брат...]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_daj_togda_hlebnut_iz_tvoego_bochonka = {
            text =
            [[Охох, всё содержимое уже во мне.*Панда шлёпает себя по пузу, а потом стучит по бочке, намекая, что она пустая, однако слышно, что в ней ещё немного осталось.*]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[Я слышу, что пиво ещё есть.]],
                    next = "d_ya_slyshu_chto_pivo_esche_est",
                },
            },
        },
        d_demony_zvuchit_interesno = {
            text = [[Ладно. Я понял. Участь страшнее смерти ожидает тебя за поворотом. Удачи.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_derevya_i_dikie_kripy = {
            text = [[Дубина, там сокровища, слышишь??]],
            speaker = [[npc_rape_victim]],
            choices = {
                {
                    text = [[Это хорошо, по пути прихвачу.]],
                    next = "d_eto_horosho_po_puti_prihvachu",
                },
            },
        },
        d_dzheffri_ejnshtejn = {
            text = [[Эпштейн.]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[Кранштейн.]],
                    next = "d_kranshtejn",
                },
            },
        },
        d_dom_milyj_dom = {
            text = [[Зачем вернулся? Ты же понимаешь, что отсюда уже не выйдешь?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Один раз сбежал, смогу и второй.]],
                    next = "d_odin_raz_sbezhal_smogu_i_vtoroj",
                },
            },
        },
        d_dopustim = {
            text = [[*Неизвестное придало тебе сил двигаться дальше.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_dorogo = {
            text = [[Ни в коем случае! У кого ни спросите, дешевле нету!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[На сайте концерта за 100 отдают.]],
                    next = "d_na_sajte_kontserta_za_100_otdaut",
                },
                {
                    text = [[В Пустошах крип предлагал мне за 150 отдать.]],
                    next = "d_v_pustoshah_krip_predlagal_mne_za_150_otdat",
                },
            },
        },
        d_dumau_on_prav = {
            text = [[*Обе головы хором ответили.*У нас два мозга, а у тебя один. Не сравнивай нас с собой!]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[Беру качеством.]],
                    next = "d_beru_kachestvom",
                },
            },
        },
        d_dumau_hvatit = {
            text =
            [[*Твоя душа настолько чиста и сильна, что ты одной лишь силой воли смог остановить перевоплощение в демона, сохранив свой рассудок.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Я сейчас начну стрелять лазерами из глаз.]],
                    next = "d_ya_sejchas_nachnu_strelyat_lazerami_iz_glaz",
                },
            },
        },
        d_ego_vneshnost = {
            text = [[Говорят у него синий плащ и большая борода.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Мне пора.]],
                    next = "d_mne_pora",
                },
            },
        },
        d_esli_by_v_tvoih_slovah_hot_inogda_poyavlyalas_logika_i_smysl_vse_bylo_by_normalno = {
            text = [[ДА?.. Может так и есть... Получается мне БЫТЬ как остальные? Уныло.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Да нет, мне даже понравилось с тобой разговаривать. Моментами...]],
                    next = "d_da_net_mne_dazhe_ponravilos_s_toboj_razgovarivat_momentami",
                },
            },
        },
        d_esli_hochesh_ubeditsya_to_provedi_rukoj_po_golove = {
            text =
            [[*Он не предпринимает никаких действий, но ты замечаешь, как от напряжения, его тело немного начинает увеличиваться в размерах.*]],
            speaker = [[default]],
            choices = {
                {
                    text =
                    [[Ты знал, что твой отец - врач? Пошли со мной и тебя подлатают, он уж точно знает как помочь.]],
                    next =
                    "d_ty_znal_chto_tvoj_otets_vrach_poshli_so_mnoj_i_tebya_podlataut_on_uzh_tochno_znaet_kak_pomoch",
                },
            },
        },
        d_zhalko_chto_ty_ne_vidish_sama_priroda_odariila_tebya_belosnezhnoj_kipoj = {
            text = [[Какой ещё кипой? Обмануть меня не получится, я ничего не чувствую на своей голове.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Может куча там аж до черепа пробила?]],
                    next = "d_mozhet_kucha_tam_azh_do_cherepa_probila",
                },
            },
        },
        d_zhmot = {
            text = [[*После таких слов, он разозлился, поставил бочку на землю и пнул её в тебя.*]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[*Разбить бочку пинком.*]],
                    next = "d_razbit_bochku_pinkom",
                },
            },
        },
        d_zabroshennyj_les = {
            text = [[Неее, я имею ввиду, что там ВНУТРИ.]],
            speaker = [[npc_rape_victim]],
            choices = {
                {
                    text = [[Деревья... и дикие крипы?]],
                    next = "d_derevya_i_dikie_kripy",
                },
            },
        },
        d_zamolknite_nichtozhestva_s_etogo_momenta_imenuus_ya_kak = {
            text = [[*Демоны застыли в ужасе.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...Алекс, обуздавший Тень.]],
                    next = "d_aleks_obuzdavshij_ten",
                },
            },
        },
        d_zato_kakih_moi_tenge_azh_1993_goda_ty_dazhe_predstavit_ne_mozhesh_ih_tsennost = {
            text = [[1993-ый год... Так там каждую монету можно продать по 420 золота!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Во во.]],
                    next = "d_vo_vo",
                },
            },
        },
        d_zachem = {
            text = [[Дабы тьма могла окутать тело твоё и наречь исчадием ужаса. Животная сущность взывает к этому.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Мне и так нормально.]],
                    next = "d_mne_i_tak_normalno",
                },
                {
                    text = [[Пусть же тьма поглотит меня...]],
                    next = "d_pust_zhe_tma_poglotit_menya",
                },
            },
        },
        d_zdarova = {
            text = [[Ты попал в наш дом, ты новый житель, бро.]],
            speaker = [[npc_creep_rogach]],
            choices = {
                {
                    text = [[Приятно.]],
                    next = "d_priyatno",
                },
            },
        },
        d_zdes_delo_ne_v_tom_kto_silnee_ili_slabee_prosto_u_tebya_na_golove_nasrano = {
            text = [[Где связь?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Низкий интеллект твой вечный спутник, так что не забивай голову.]],
                    next = "d_nizkij_intellekt_tvoj_vechnyj_sputnik_tak_chto_ne_zabivaj_golovu",
                },
            },
        },
        d_zdraste_ne_podskazhite_gde_ya = {
            text =
            [[Чувствую перед собой сильную энергию... Неужто пришёл тот, кто освободит наше измученное Королевство?]],
            speaker = [[npc_shamanka]],
            choices = {
                {
                    text = [[Что?]],
                    next = "d_chto__2",
                },
            },
        },
        d_znaesh_ya_peredumal = {
            text =
            [[*Красный с энтузиазмом глазеет в твою сторону. Его губы начинают дрожать, новое оскорбление вот вот вылетит из них со свистом.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Вообщем ты пидорасик.]],
                    next = "d_voobschem_ty_pidorasik",
                },
            },
        },
        d_znaesh_mne_grustno_smotret_na_tebya = {
            text = [[Оставь слова при себе.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Ты же понимаешь, что я не уйду?]],
                    next = "d_ty_zhe_ponimaesh_chto_ya_ne_ujdu",
                },
            },
        },
        d_i_vpravdu_uzhas = {
            text =
            [[Ты показал свою силу, добравшись живым до сюда. Можешь ли ты узнать, какой будет следующая катастрофа, чтобы мы были готовы?]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Конечно.]],
                    next = "d_h7",
                    actions = {
                        { questID = "q_main_quest_act_1", type = "quest_start" },
                    },
                },
                {
                    text = [[Слушаюсь и повинуюсь.]],
                    next = "d_h7",
                    actions = {
                        { questID = "q_main_quest_act_1", type = "quest_start" },
                    },
                },
            },
        },
        d_i_znaesh_li_moj_kulak_drobit_kamni_a_tut_peredo_mnoj_statuya_tak_chto_poslednij_shans_pojti_so_mnoj = {
            text =
            [[Признаю, в твоих словах есть доля правды. Может быть мне и вправду стоит обращать внимание на слова простаков, а не просто их избивать. Я готов встретиться с "отцом", однако ты должен ответить за слова. ]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Говори.]],
                    next = "d_govori",
                },
            },
        },
        d_i_tvoj_brat_daj_ugadau_tozhe_prints = {
            text = [[Верно. Красный Принц. Земля досталась нам от отца. Вечная борьба.]],
            speaker = [[npc_blue_prince]],
            choices = {
                {
                    text = [[И тебе помочь отвоевать её?]],
                    next = "d_i_tebe_pomoch_otvoevat_ee",
                },
            },
        },
        d_i_tebe_pomoch_otvoevat_ee = {
            text = [[Верно. Брат мой - последователь капитализма. Куча денег. Куча сильных бойцов. Я не имею такового.]],
            speaker = [[npc_blue_prince]],
            choices = {
                {
                    text = [[Но ты же мне заплатишь?]],
                    next = "d_no_ty_zhe_mne_zaplatish",
                },
            },
        },
        d_i_tebe_privet = {
            text = [[Положи свою чёрную задницу сюда, да.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Чего чего?).]],
                    next = "d_chego_chego",
                },
            },
        },
        d_i_tebe_horoshego = {
            text = [[*Рогач стучит себя по груди и махает тебе, пока ты уходишь.*]],
            speaker = [[npc_creep_rogach]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_i_chto_delat_budem = {
            text = [[Ты проходить полосу препятствий, а я смотреть. Ты умирать, а я наслаждаться.]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[А если я пройду?]],
                    next = "d_a_esli_ya_projdu",
                },
            },
        },
        d_i_chto_togda_delat = {
            text =
            [[КАЧАТЬСЯ! Лишь комбинация сильного духа и тела позволит человеку возвыситься до его уровня. Я обязан стать сильнее!]],
            speaker = [[npc_mustache]],
            choices = {
                {
                    text = [[Я тогда тоже буду.]],
                    next = "d_ya_togda_tozhe_budu",
                },
            },
        },
        d_i__1 = {
            text = [[Он наш брат! Братьев ценить нужно! Даже человек должен это понять.]],
            speaker = [[npc_ogre_magi_slow]],
            choices = {
                {
                    text = [[Ну могу да.]],
                    next = "d_nu_mogu_da",
                },
            },
        },
        d_izza_tebya_malenkij_niger_ne_mozhet_popast_na_kontsert_ponimaesh = {
            text = [[Он может, если купит билет.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Перекупы вы суки..]],
                    next = "d_perekupy_vy_suki",
                },
            },
        },
        d_izvinyaj_mne_dva_bileta_nado_a_te_rebyatki_davali_skidku_na_pokupku_ot_dvuh = {
            text =
            [[Стой, стой, стой, стой! Совсем забыл рассказать о главной акции: два билета по цене одного! Очень выгодно!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Хм... неплохо, но даже так мне не хватит, у меня 50 золота.]],
                    next = "d_hm_neploho_no_dazhe_tak_mne_ne_hvatit_u_menya_50_zolota",
                },
            },
        },
        d_interesno_etot_ostrov_identichen_tomu_chto_byl_v_realnosti = {
            text = [[Ступишь дальше и ты будешь молить пощады у моих стражей-демонов.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Демоны... Звучит интересно.]],
                    next = "d_demony_zvuchit_interesno",
                },
            },
        },
        d_k_tebe_v_gosti = {
            text = [[Разворачивайся немедленно. Даю последнее предупреждение.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Интересно, этот остров идентичен тому, что был в реальности?]],
                    next = "d_interesno_etot_ostrov_identichen_tomu_chto_byl_v_realnosti",
                },
            },
        },
        d_ksaver_ya_tvoj_samyj_glavnyj_fanat = {
            text =
            [[*Гул невероятной мощи начал резонировать от стен, усиливаясь с каждый отскоком. Ничего, кроме тебя, не было слышно. Нескольких людей сбило с ног.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[АЛЕКС УМРЁТ ЗА ТЕБЯ, ТЫ ЛЕГЕНДА, ТЫ М...]],
                    next = "d_aleks_umret_za_tebya_ty_legenda_ty_m",
                },
            },
        },
        d_kak_pojdet = {
            text = [[Подожди подожди, а кто тебе рассказал об их существовании? Это я!]],
            speaker = [[npc_rape_victim]],
            choices = {
                {
                    text = [[Не помню такого.]],
                    next = "d_ne_pomnu_takogo",
                },
            },
        },
        d_kak_tak = {
            text =
            [[Билетов нет в продаже. Один человек скупил кучу и перепродаёт с наценкой больше 500 процентов! У меня нет таких денег...]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Я тебе подсоблю.]],
                    next = "d_j4",
                },
                {
                    text = [[Понятно, но давай потом как-нибудь.]],
                    next = "d_j3",
                },
            },
        },
        d_kak_ya_pomnu_panda_nosit_s_soboj_polotentse = {
            text = [[Тогда путь намечен, прощай.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_kakovo_eto_skupat_bilety_zastavlyaya_bednyh_stradat = {
            text = [[О чём речь? Я официальный диллер.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Из-за тебя маленький нигер не может попасть на концерт, понимаешь?]],
                    next = "d_izza_tebya_malenkij_niger_ne_mozhet_popast_na_kontsert_ponimaesh",
                },
            },
        },
        d_kakoj_plan_u_vas = {
            text =
            [[Мы любим мастерить всякие бомбочки, так что хотим взорвать остров!*Крипы по бокам начали запускать петарды от ввозбуждения.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Прикольно, но остров то большой.]],
                    next = "d_prikolno_no_ostrov_to_bolshoj",
                },
            },
        },
        d_klyanus = {
            text = [[Хорошо... 1, 2, 3, 4, 5, 6, 7, 8...]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Отлично, продолжай.]],
                    next = "d_otlichno_prodolzhaj",
                },
            },
        },
        d_kogo = {
            text = [[Небеса с тобой. Слава Королю!]],
            speaker = [[npc_shamanka]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_kranshtejn = {
            text = [[*Тишина.*]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[И что делать будем?]],
                    next = "d_i_chto_delat_budem",
                },
            },
        },
        d_kruto_kak_tam_s_nagradoj = {
            text = [[Возьми. Большая награда. Для большого человека.]],
            speaker = [[npc_blue_prince]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_kstati_tvoi_synovya_obeschali_vernutsya_no_ih_ne_vidat_gde_oni = {
            text = [[Какие сыновья?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_kstati_u_tebya_znakomyj_golos = {
            text = [[Серьёзно? Не знал, что у меня есть фанаты даже здесь. Я Джеффри...]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[Джеффри Эйнштейн.]],
                    next = "d_dzheffri_ejnshtejn",
                },
            },
        },
        d_ladno_togda_chast_otsyplu_mozhet_byt = {
            text = [[Всмысле может быть?!]],
            speaker = [[npc_rape_victim]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_ladno_poka = {
            text = [[*В стороне ты заметил вход в подземные пути.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_ladno_pomogu_tebe = {
            text = [[Постарайся уж, а то пока я не смогу их контролировать, жена меня домой не пустит.]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_ladno = {
            text = [[*Огр дал сам себе пять.*]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_lukovye_koltsa_govno = {
            text = [[Воистину, Аминь...]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Аминь.]],
                    next = "d_amin",
                },
            },
        },
        d_mamu_ne_trogaj = {
            text = [[Поздно. Облапана до предела.]],
            speaker = [[npc_monkey_king]],
            choices = {
                {
                    text = [[*Ударить лбом ему по лицу.*]],
                    next = "d_udarit_lbom_emu_po_litsu",
                },
            },
        },
        d_mantii_na_intellekt_ne_suschestvuet = {
            text = [[Как так?!]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[Ваш брат так сказал.]],
                    next = "d_vash_brat_tak_skazal",
                },
            },
        },
        d_mantiya_proklyata = {
            text = [[Нет. Я просто не хочу быть прежним. Сейчас я владею всеми знаниями мира, это высшее наслаждение.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[...]],
                    next = "d_m1",
                },
            },
        },
        d_menya_zovut = {
            text = [[*Девушка в предвкушении.*]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[...Алекс.]],
                    next = "d_h10",
                },
                {
                    text = [[Я - Алекс.]],
                    next = "d_h10",
                },
                {
                    text = [[Звать меня Алекс.]],
                    next = "d_h10",
                },
            },
        },
        d_menya_poslal_tvoj_brat_ili_tochnee_bratya = {
            text = [[Понимаю.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Они беспокоются за тебя, вернёшься к ним?]],
                    next = "d_oni_bespokoutsya_za_tebya_verneshsya_k_nim",
                },
            },
        },
        d_menya_poslal_tvoj_otets = {
            text = [[Не припоминаю, чтобы у меня был отец.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Ты ведь Зелёный?]],
                    next = "d_ty_ved_zelenyj",
                },
            },
        },
        d_mne_i_tak_normalno = {
            text = [[Пусть схватка с нами покажет тебе, насколько Тень - великий дар.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_mne_kazhetsya_ya_znau_parol = {
            text = [[Говори.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Z - это Cамость, а Cамость - это Z.]],
                    next = "d_z_eto_camost_a_camost_eto_z",
                },
            },
        },
        d_mne_pora = {
            text = [[Но где ты возьмёшь столько денег?!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_mne_tozhe_odnako_vybora_net = {
            text = [[Тогда начнём.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[*Начать битву*]],
                    next = "d_nachat_bitvu",
                    actions = {
                        { target = "talk", type = "fight_start" },
                    },
                },
            },
        },
        d_mnogo_chego = {
            text = [[Много хорошего... И... Много великого, да.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[А где он?]],
                    next = "d_a_gde_on",
                },
            },
        },
        d_mozhet_kucha_tam_azh_do_cherepa_probila = {
            text = [[*Хотя физиономия Зелёного остаётся такой же, взгляд его уже нельзя назвать спокойным.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Отойти на безопасное расстояние.*]],
                    next = "d_otojti_na_bezopasnoe_rasstoyanie",
                },
            },
        },
        d_monopoliu = {
            text = [[Люстра горит. Тёплая комната. Ноги в тапочках....]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Эффект бабочки.]],
                    next = "d_g19",
                },
                {
                    text = [[Кухня.]],
                    next = "d_g19",
                },
                {
                    text = [[Один дома.]],
                    next = "d_g19",
                },
                {
                    text = [[Не смотрел.]],
                    next = "d_ne_smotrel",
                },
            },
        },
        d_my_v_limbe = {
            text = [[Да, наши души где-то промежутке.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[То есть я не смогу вернуться?]],
                    next = "d_to_est_ya_ne_smogu_vernutsya",
                },
            },
        },
        d_na_koleni_pered_vladykoj = {
            text =
            [[*Теневой демон смог успокоить себя..*Давай же, Исчадие тьмы, одолеем его ради нашего хозяина. Мы перед ним в неоплатном долгу.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_na_sajte_kontserta_za_100_otdaut = {
            text = [[Что ещё за сайт?*Настороженно спросил перекуп.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Ну сайт. Где билеты онлайн покупают.]],
                    next = "d_nu_sajt_gde_bilety_onlajn_pokupaut",
                },
            },
        },
        d_navernoe_no_umirat_neohota = {
            text = [[ЭТО ПРАВДА. ОДНАКО У МЕНЯ ПРИКАЗ, ИЗВИНИ.]],
            speaker = [[npc_Epstein_guard]],
            choices = {
                {
                    text = [[Понимаю.]],
                    next = "d_ponimau",
                },
            },
        },
        d_nadeyalsya_chto_smozhem_vstretitsya_vzhivuu = {
            text = [[Ты, к сожалению, староват.]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[...]],
                    next = "d_n1",
                },
            },
        },
        d_naschet_bratev_vozvraschajsya_k_nim = {
            text = [[*После упоминания братьев, он замешкался и начал крутить головой из стороны в сторону.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[У нас был уговор, я выполнил свою часть, теперь твоя очередь.]],
                    next = "d_u_nas_byl_ugovor_ya_vypolnil_svou_chast_teper_tvoya_ochered",
                },
            },
        },
        d_nachnem_duel = {
            text = [[]],
            speaker = [[npc_monkey_king]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_ne_dumau = {
            text = [[*Существо не показало никакой реакции.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Меня послал твой отец.]],
                    next = "d_menya_poslal_tvoj_otets",
                },
            },
        },
        d_ne_znal_chto_dazhe_v_mire_mertvyh_upotreblyaut = {
            text = [[НЕТ НЕТ нет... Никаких наркотиков нигде не существует, королевство чистое на 99.1%.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Передо мной противоречие.]],
                    next = "d_peredo_mnoj_protivorechie",
                },
            },
        },
        d_ne_ne_mne_ne_vazhno_kto_vy_ya_sprashival_chto_za_rasa_u_vas = {
            text = [[Разорвём на части этого черта!!]],
            speaker = [[npc_creep_troll]],
            choices = {
                {
                    text = [[*Начать обороняться.*]],
                    next = "d_nachat_oboronyatsya",
                    actions = {
                        { target = "kill", type = "(fight_start" },
                    },
                },
            },
        },
        d_ne_nuzhno_poverte = {
            text =
            [[Мне кажется он не спичка... Больше он походит на человека. Если мы его подожжём, он сгорит, понимаешь?]],
            speaker = [[npc_ogre_magi_slow]],
            choices = {
                {
                    text = [[...]],
                    next = "d_l9",
                },
            },
        },
        d_ne_obet_a_obed = {
            text =
            [[*Ты слышишь странный звук. Грудь ощущается тяжёлой. Повернув голову вниз, ты замечаешь сквозную дыру. Похоже она попала прям в сердце.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Бххъ... хааа... еошъъ....]],
                    next = "d_bhh_haaa_eosh",
                },
            },
        },
        d_ne_osobo = {
            text = [[*Он приуныл.*Ну вот... Мне никогда не стать нигером...]],
            speaker = [[default]],
            choices = {
                {
                    text = [[А зачем тебе?]],
                    next = "d_a_zachem_tebe",
                },
            },
        },
        d_ne_pomnu_takogo = {
            text = [[Э?]],
            speaker = [[npc_rape_victim]],
            choices = {
                {
                    text = [[Бывай.]],
                    next = "d_byvaj",
                },
            },
        },
        d_ne_ponyal = {
            text =
            [[Войдёшь в Пустоши и тебе напихают настолько сильно... Даже не знаю, есть ли слова, чтобы описать насколько...  ]],
            speaker = [[npc_mustache]],
            choices = {
                {
                    text = [[А чё сам не пойдёшь тогда, а?]],
                    next = "d_a_che_sam_ne_pojdesh_togda_a",
                },
            },
        },
        d_ne_smotrel = {
            text = [[Первый закон Ньютона.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[- - - > < - - -]],
                    next = "d_g10",
                },
                {
                    text = [[- - - - - - - >]],
                    next = "d_g11",
                },
                {
                    text = [[< - - - - - - >]],
                    next = "d_g10",
                },
                {
                    text = [[- > < - - > < -]],
                    next = "d_g10",
                },
            },
        },
        d_ne_shoditsya = {
            text = [[Что не так?!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[7 монет по 420 - это 2940. А билеты стоят 50. Не сходится.]],
                    next = "d_7_monet_po_420_eto_2940_a_bilety_stoyat_50_ne_shoditsya",
                },
            },
        },
        d_ne_hochu = {
            text = [[Ты. Подумай ещё.]],
            speaker = [[npc_blue_prince]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_net = {
            text =
            [[*Существо широко раздвинуло ноги, свесив руки и голову. Оно очень расстроилось. Твой глаз уловил момент, когда оно обронило единственную слезу..*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Вообщем ты Синий.]],
                    next = "d_voobschem_ty_sinij",
                },
            },
        },
        d_net_ne_ponimau = {
            text = [[Нынешнему мне не о чем говорить с ними. У вас был диалог, думаю несложно догадаться о чём я.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Да, они своебразные, но хотя бы проведай их.]],
                    next = "d_da_oni_svoebraznye_no_hotya_by_provedaj_ih",
                },
            },
        },
        d_net_ne_hvatit = {
            text = [[Помнишь ту птицу? Заметил, что с ней случилось?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Вложить все свои усилия.*]],
                    next = "d_vlozhit_vse_svoi_usiliya",
                },
            },
        },
        d_net_ya_ostavlu_tebya_v_zhivyh = {
            text = [[Не выйдет. Я умру как личность.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[*Снять с него Мантию.*]],
                    next = "d_snyat_s_nego_mantiu",
                },
                {
                    text = [[*Не снимать.*]],
                    next = "d_ne_snimat",
                },
            },
        },
        d_nizkij_intellekt_tvoj_vechnyj_sputnik_tak_chto_ne_zabivaj_golovu = {
            text = [[*Существо поворачивает голову в твою сторону. Это первый раз, когда оно совершило движение.*]],
            speaker = [[default]],
            choices = {
                {
                    text =
                    [[Только умный способен выслушать и взвесить все за и против, а ты просто упёртый. Вот и всё.]],
                    next = "d_tolko_umnyj_sposoben_vyslushat_i_vzvesit_vse_za_i_protiv_a_ty_prosto_upertyj_vot_i_vse",
                },
            },
        },
        d_no_ty_zhe_mne_zaplatish = {
            text = [[Верно.]],
            speaker = [[npc_blue_prince]],
            choices = {
                {
                    text = [[Хм...]],
                    next = "d_hm",
                },
            },
        },
        d_no = {
            text =
            [[Ты сейчас начнёшь рассказывать о наших воспоминаниях, братских узах и о том, как они меня однажды спасли. Не нужно этого.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[...]],
                    next = "d_m2",
                },
            },
        },
        d_no__1 = {
            text = [[Среди крипов куча злыдней, чёрт... Да и люди бывают теми ещё подонками...]],
            speaker = [[npc_creep_rogach]],
            choices = {
                {
                    text = [[Понимаю тебя.]],
                    next = "d_ponimau_tebya",
                },
            },
        },
        d_nu_davaj = {
            text = [[Данная легенда передавалась из поколения в поколение. Я - последний её носитель.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_k",
                },
            },
        },
        d_nu_i_horosho = {
            text = [[СРАЖЕНИЕ ЗА КОГО-ТО ДРУГОГО ПРИДАСТ ТЕБЕ МОТИВАЦИИ ДРАТЬСЯ В ПОЛНУЮ СИЛУ.]],
            speaker = [[npc_Epstein_guard]],
            choices = {
                {
                    text = [[Так-то да.]],
                    next = "d_takto_da",
                },
            },
        },
        d_nu_kak = {
            text =
            [[Знаешь... Лучше. Твои удары усмирили мой гнев. Что-то я уж больно вспылил, даже неприятно вспоминать кем я был минуту назад. Благодарю за возвращение в спокойное состояние.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Так ты вернёшься домой?]],
                    next = "d_tak_ty_verneshsya_domoj",
                },
            },
        },
        d_nu_mogu_da = {
            text =
            [[Мы с ним взрывали петарды в тёмном лесу, как на нас вышел огромный дракон. Он мог летать. С помощью крыльев.]],
            speaker = [[npc_ogre_magi_slow]],
            choices = {
                {
                    text = [[Ага.]],
                    next = "d_l10",
                },
            },
        },
        d_nu_mozhet_chutchut = {
            text = [[*Существо влетело в тебя и крепко обняло, прошептав слова:* Ты единственный, кто меня понимает.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Вообщем ты Синий.]],
                    next = "d_g5",
                },
            },
        },
        d_nu_sajt_gde_bilety_onlajn_pokupaut = {
            text =
            [[Обманывать меня решил?! В этом мире нету интернета, паренёк. Я передумал. Для тебя билет - 1000 золота.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Пригрозить ему.*]],
                    next = "d_l2",
                },
            },
        },
        d_nu_mozhet_razehalis = {
            text = [[Он убил всех. Остались только мы, что побоялись идти с остальными.]],
            speaker = [[npc_mustache]],
            choices = {
                {
                    text = [[И что тогда делать?]],
                    next = "d_i_chto_togda_delat",
                },
            },
        },
        d_o_eto_zhe_vy = {
            text = [[Вы наш спаситель! Спасибо большое, мистер.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Да ничего такого.]],
                    next = "d_da_nichego_takogo",
                },
            },
        },
        d_obidno = {
            text = [[ЖАЛКО ТЕБЯ РАЗОЧАРОВЫВАТЬ.]],
            speaker = [[npc_Epstein_guard]],
            choices = {
                {
                    text = [[Опять не повезло...]],
                    next = "d_opyat_ne_povezlo",
                },
            },
        },
        d_ogo = {
            text =
            [[Время пророчества близко, но неизвестно чего ожидать. Мы бы спросили его, но в лесу полно опасных крипов, а мы люди - сейчас слабы.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[И вправду ужас.]],
                    next = "d_i_vpravdu_uzhas",
                },
            },
        },
        d_ogromnymi_proshu_zametit = {
            text = [[Ого! Ну и боевой дух! Только вот ты ещё слабачок.]],
            speaker = [[npc_mustache]],
            choices = {
                {
                    text = [[Не понял.]],
                    next = "d_ne_ponyal",
                },
            },
        },
        d_odin_raz_sbezhal_smogu_i_vtoroj = {
            text =
            [[У нас здесь небольшое изменение. Одна шаманка согласилась навести на мой остров огромный поток воздуха. Это значительно усложняет путь.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Спасибо.]],
                    next = "d_spasibo",
                },
            },
        },
        d_oj_ya_pereputal_u_menya_ne_zoloto_a_tenge = {
            text = [[Тенге... Получается по курсу это где-то... СЕМЬ ЗОЛОТА??!?!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Зато каких! Мои тенге аж 1993 года. Ты даже представить не можешь их ценность.]],
                    next = "d_zato_kakih_moi_tenge_azh_1993_goda_ty_dazhe_predstavit_ne_mozhesh_ih_tsennost",
                },
            },
        },
        d_on_i_vpravdu_ochen_skuchaet_po_tebe_ponimaesh_emu_prosto_hochetsya_chtoby_vy_s_bratyami_byli_vmeste = {
            text = [[ПРИКИНЬ, ТЫ ШЕРСТЬ.]],
            speaker = [[default]],
            choices = {
                {
                    text =
                    [[Вы очень разные, но вы все братья. Прими их такими, какие есть, и они проявят уважение и к тебе. Вы снова станете семьёй.]],
                    next =
                    "d_vy_ochen_raznye_no_vy_vse_bratya_primi_ih_takimi_kakie_est_i_oni_proyavyat_uvazhenie_i_k_tebe_vy_snova_stanete_semej",
                },
            },
        },
        d_on_ne_vernetsya = {
            text = [[*Обе головы переглянулись в недоумении.*Почему?!]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[Он потерялся.]],
                    next = "d_on_poteryalsya",
                },
            },
        },
        d_on_poteryalsya = {
            text = [[Где?!]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[В себе.]],
                    next = "d_v_sebe",
                },
            },
        },
        d_on_srazhalsya_s_drakonom_posle_pobedy_on_pal = {
            text = [[*Они начали смотреть в разные стороны.*]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[Ценой своей жизни он спас поселение добрых крипов.]],
                    next = "d_tsenoj_svoej_zhizni_on_spas_poselenie_dobryh_kripov",
                },
            },
        },
        d_on_umer = {
            text = [[*Головы замолкли.*]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[Он сражался с драконом. После победы, он пал.]],
                    next = "d_on_srazhalsya_s_drakonom_posle_pobedy_on_pal",
                },
            },
        },
        d_ona_ostavila_tebe_podarok_beloe_pyatno_na_tvoej_makushke = {
            text = [[*Зелёный поднимает глаза наверх, пытаясь рассмотреть. Ему это не удаётся.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Жалко, что ты не видишь. Сама природа одариила тебя белоснежной кипой.]],
                    next = "d_zhalko_chto_ty_ne_vidish_sama_priroda_odariila_tebya_belosnezhnoj_kipoj",
                },
            },
        },
        d_oni_bespokoutsya_za_tebya_verneshsya_k_nim = {
            text = [[Теперь не могу. Но каких-то пару дней назад всё ещё был шанс.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Это связано с Мантией?]],
                    next = "d_eto_svyazano_s_mantiej",
                },
            },
        },
        d_opyat_ne_povezlo = {
            text = [[ЧЕМ БЫСТРЕЕ УМРЁШЬ, ТЕМ БЫСТРЕЕ ПРОЙДЁТ ГРУСТЬ.]],
            speaker = [[npc_Epstein_guard]],
            choices = {
                {
                    text = [[Наверное, но умирать неохота...]],
                    next = "d_navernoe_no_umirat_neohota",
                },
            },
        },
        d_otets_lubit_tebya_i_bratya_lubyat_vse_zhdut_tebya_vernis_domoj_umolyau_tebya_semya_samoe_vazhnoe_na_svete = {
            text = [[ПИСЕЧНАЯ ПОДСТАВКА - ТВОЙ ВЕЛИКИЙ ТИТУЛ. А ВООБЩЕ У ТЕБЯ НОС КАК...]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Знаешь, я передумал.]],
                    next = "d_znaesh_ya_peredumal",
                },
            },
        },
        d_otkuda_ty_voobsche_govorish = {
            text = [[Остров усеян динамиками, а что?]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[Надеялся, что сможем встретиться вживую.]],
                    next = "d_nadeyalsya_chto_smozhem_vstretitsya_vzhivuu",
                },
            },
        },
        d_otkuda_ty_eto_skazal = {
            text = [[ГОРДЫНЯ - РАЗРУШИТЕЛЬ СУЩЕГО.]],
            speaker = [[npc_tormentor]],
            choices = {
                {
                    text = [[Подскажи где я.]],
                    next = "d_podskazhi_gde_ya",
                },
            },
        },
        d_otlichno_prodolzhaj = {
            text = [[*Пришло время сматываться отсюда.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_pokupau = {
            text = [[ПРОДАНО!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Ты забираешь билеты.*]],
                    next = "d_ty_zabiraesh_bilety",
                },
            },
        },
        d_peredo_mnoj_protivorechie = {
            text = [[*Существо довольно улыбается.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Получается ты Синий?]],
                    next = "d_poluchaetsya_ty_sinij",
                },
            },
        },
        d_perekupy_vy_suki = {
            text = [[*Чувствуя твою агрессию, перекуп начинает обороняться.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_pizda_ostavajsya_soboj_no_starajsya_udelyat_vnimanie_sobesedniku = {
            text =
            [[*Синий упал от твоих слов. Шок произошёл из-за, на первый взгляд, невозможной комбинации: подъёба и мудрости.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Я ж мог не подъёбывать, но я захотел, и при этом донес до тебя мысль.]],
                    next = "d_ya_zh_mog_ne_podebyvat_no_ya_zahotel_i_pri_etom_dones_do_tebya_mysl",
                },
            },
        },
        d_plata_za_informatsiu = {
            text = [[Верно подмечено!]],
            speaker = [[npc_rape_victim]],
            choices = {
                {
                    text = [[Ладно тогда, часть отсыплю, может быть.]],
                    next = "d_ladno_togda_chast_otsyplu_mozhet_byt",
                },
            },
        },
        d_podskazhi_gde_ya = {
            text = [[*Фигура замолкла.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Допустим.]],
                    next = "d_dopustim",
                },
            },
        },
        d_pozaimstvoval_mozhet_ukral = {
            text = [[Не твоё дело.]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[Расскажи откуда, мне для друга надо.]],
                    next = "d_pochemu",
                },
            },
        },
        d_poluchaetsya_ty_sinij = {
            text = [[Неа... нет.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Назовись, а то как мне к тебе обращаться?]],
                    next = "d_g4",
                },
            },
        },
        d_pomosch_nuzhna = {
            text = [[Меня зовут... эм...*Крип начал перебирать варианты.*]],
            speaker = [[npc_creep_bob]],
            choices = {
                {
                    text = [[...]],
                    next = "d_i7",
                },
            },
        },
        d_ponimau_k_chemu_vy_vedete = {
            text = [[А ты бы смог отправиться туда и заложить бомбу, мистер?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Э, а что я?]],
                    next = "d_e_a_chto_ya",
                },
            },
        },
        d_ponimau_tebya = {
            text = [[Но мы вместе всё равно, понимаешь, Ален? Мы душевно связаны.]],
            speaker = [[npc_creep_rogach]],
            choices = {
                {
                    text = [[Респект тебе.]],
                    next = "d_i",
                },
                {
                    text = [[Я Алекс вообще-то.]],
                    next = "d_ya_aleks_voobscheto",
                },
            },
        },
        d_ponimau = {
            text = [[*Вдруг ты замечаешь клетку с крипами: исхудалыми и грустными.*]],
            speaker = [[npc_Epstein_guard]],
            choices = {
                {
                    text = [[Те, наверное, как раз жерты Эпстина, да?]],
                    next = "d_te_navernoe_kak_raz_zherty_epstina_da",
                },
            },
        },
        d_ponyatnoe_delo_govorya_s_toboj_nevozmozhno_ponyat_chto_proishodit = {
            text = [[*Синий удивлённо и напуганно начал на тебя смотреть.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Если бы в твоих словах хоть иногда появлялась логика и смысл, всё было бы нормально.]],
                    next = "d_esli_by_v_tvoih_slovah_hot_inogda_poyavlyalas_logika_i_smysl_vse_bylo_by_normalno",
                },
            },
        },
        d_pochemu_v_tri = {
            text = [[Потому что в 4!]],
            speaker = [[npc_ogre_magi_fast]],
            choices = {
                {
                    text = [[Я короч пошёл.]],
                    next = "d_ya_koroch_poshel",
                },
            },
        },
        d_pochemu_ty_ne_pytaeshsya_sbezhat = {
            text = [[В этом нет нужды. Моя жизнь теперь в твоих руках.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[*Потянуться к Мантии.*]],
                    next = "d_m4",
                },
            },
        },
        d_pochemu = {
            text = [[Какая мне выгода?]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[Дай тогда хлебнуть из твоего бочонка.]],
                    next = "d_daj_togda_hlebnut_iz_tvoego_bochonka",
                },
            },
        },
        d_pochti_uveren_chto_net = {
            text = [[*Существо село в позу Мыслителя и начало бубнеть, пытаясь понять, чего ему не хватает.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Вообщем ты Синий.]],
                    next = "d_voobschem_ty_sinij",
                },
            },
        },
        d_poshli_so_mnoj_pokazhu = {
            text =
            [[*Слово Пустоши повлияло на перекупа.*Нееет, я пожалуй тут останусь... И давай, чтоб ты не рисковал, я тебе за 130 отдам, а?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Извиняй, мне два билета надо, а те ребятки давали скидку на покупку от двух.]],
                    next = "d_izvinyaj_mne_dva_bileta_nado_a_te_rebyatki_davali_skidku_na_pokupku_ot_dvuh",
                },
            },
        },
        d_privet_panda_vizhu_zhizn_tvoya_nalazhivaetsya = {
            text = [[Оооо, здравствуй, приятель. Ты не поверишь, сколько всего в моей жизни произошло. ]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Я вижу, пить перестал, да?]],
                    next = "d_ya_vizhu_pit_perestal_da",
                },
            },
        },
        d_privet = {
            text = [[Приветствую, рада видеть новые лица в нашем Королевстве.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[А ты кто?]],
                    next = "d_h",
                },
            },
        },
        d_prijti_nepodgotovlennym_v_getto_realno_opasno = {
            text = [[Но я очень хочу! Это моя мечта: стать первым крипом-нигером!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Тебя пробивает на слезу от восхищения.*]],
                    next = "d_tebya_probivaet_na_slezu_ot_voshischeniya",
                },
            },
        },
        d_prikolno_no_ostrov_to_bolshoj = {
            text =
            [[Попав туда, Эпштейн приказал проходить полосу препятствий, но мы отказались и просто стояли в начале.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_n2",
                },
            },
        },
        d_prinyato = {
            text = [[Тогда вперёд.]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_prichina = {
            text = [[Осознание. Возвращение в прошлую жизнь недопустимо.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Мантия проклята?]],
                    next = "d_mantiya_proklyata",
                },
            },
        },
        d_priyatno = {
            text = [[Как звать тебя?]],
            speaker = [[npc_creep_rogach]],
            choices = {
                {
                    text = [[Алекс.]],
                    next = "d_aleks",
                },
            },
        },
        d_prosto_tak_do_takoj_stepeni_ne_napivautsya_chto_ne_tak = {
            text =
            [[Да беда ужасная настигла. У меня есть три сына, понимаешь, а они сбежали от папки своего, не хотят ладить друг с другом. Никак не могу донести до них мысль, что нужно жить всем вместе в гармонии. Тогда и жизнь станет лучше, правда ведь?]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[...]],
                    next = "d_verno",
                },
                {
                    text = [[Верно.]],
                    next = "d_verno",
                },
            },
        },
        d_pust_zhe_tma_poglotit_menya = {
            text =
            [[*Демоны выставляют руки в твою сторону. Они произносят неизвестные речи, из-за чего Тень начинает втягиваться в тебя.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Щекотно.]],
                    next = "d_schekotno",
                },
            },
        },
        d_rad_za_tebya = {
            text =
            [[Представь, даже жена меня домой пустила. Когда спросил её о причине, то она ответила, что со мной стало приятней общаться и что я перестал перечить и доводить до конфликтов. Хорошо, что чудеса случаются.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Кстати, твои сыновья обещали вернуться, но их не видать. Где они?]],
                    next = "d_kstati_tvoi_synovya_obeschali_vernutsya_no_ih_ne_vidat_gde_oni",
                },
            },
        },
        d_rad = {
            text = [[Но и сильно разочаровал. Ты забрал мой товар, так что с этих пор - оглядывайся.]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[Ладно, пока.]],
                    next = "d_ladno_poka",
                },
            },
        },
        d_raz_ty_ne_hochesh_idti_so_mnoj_ya_prosto_ponesu_tebya = {
            text = [[*Зелёный усмехается. Ты всё ещё пытаешься оторвать его от земли.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Обернуть свои ноги вокруг него и начать тянуть весом тела.*]],
                    next = "d_obernut_svoi_nogi_vokrug_nego_i_nachat_tyanut_vesom_tela",
                },
            },
        },
        d_rasskazhi_o_synovyah = {
            text =
            [[Ооох, они прекрасные, но в последнее время на них что-то нашло, не подчиняются старику. Бывало заставляли меня делать ужасные вещи: воровать, буянить, даже нападать на окружающих... Ох, ужас...]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[...]],
                    next = "d_empty",
                },
            },
        },
        d_rasskazhi_chtoto_o_korole = {
            text =
            [[О нём мало знаю. Мне кажется когда-то я его даже видел... Или нет?.. Точно! Его кто-то убил, после чего люди начали гневаться и зачем-то идти в пустоши... ]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[Ладно, помогу тебе.]],
                    next = "d_ladno_pomogu_tebe",
                },
            },
        },
        d_rasslabtes_kotiki_sam_epshtejn_skazal_chto_ostrov_pust = {
            text = [[Почему ты раньше этого не сказал?! Зачем обманул нас и выхватил детонатор?!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Так прикольнее получилось.]],
                    next = "d_tak_prikolnee_poluchilos",
                },
            },
        },
        d_reshat = {
            text = [[ЛУЧШИЙ репер КТО?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[MACAN.]],
                    next = "d_g13",
                },
                {
                    text = [[xaviersobased.]],
                    next = "d_g14",
                },
                {
                    text = [[Fakemink.]],
                    next = "d_g14",
                },
                {
                    text = [[хулагу 3g.]],
                    next = "d_g14",
                },
            },
        },
        d_s_etogo_momenta_tsepi_konury_bolee_ne_smogut_sderzhat_moego_buldoga_ty_svoboden = {
            text =
            [[Вдруг, как домино, люди начали окутывать тебя аплодисментами и восторженными возгласами. Тебе начало казаться, что из-за их шума земля начала дрожать. После такого остаётся делать только одну вещь...*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*... утопать в овациях.*]],
                    next = "d_utopat_v_ovatsiyah",
                },
            },
        },
        d_szadi_vas_epshtejn = {
            text = [[ЧТО?!*Они все вместе резко обернулись.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Сорвать детонатор с хвоста кота-бочки.*]],
                    next = "d_sorvat_detonator_s_hvosta_kotabochki",
                },
            },
        },
        d_skolko_za_chas = {
            text =
            [[Приветствую, не переживай, вход в город бесплатный, можешь находиться здесь столько, сколько тебе нужно.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[...]],
                    next = "d_h",
                },
            },
        },
        d_slovno_igly_moi_botinki_vyshili_eti_ornamenty_dlya_vas_zemlyane = {
            text =
            [[Вдруг, как домино, люди начали окутывать тебя аплодисментами и восторженными возгласами. Тебе начало казаться, что из-за их шума земля начала дрожать. После такого остаётся делать только одну вещь...*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*... утопать в овациях.*]],
                    next = "d_utopat_v_ovatsiyah",
                },
            },
        },
        d_smotrya_chto_predlagaesh = {
            text = [[Я - Синий Принц. Сын великого Булыжника. Однако у Булыжника. Два сына.]],
            speaker = [[npc_blue_prince]],
            choices = {
                {
                    text = [[И твой брат, дай угадаю, тоже принц?]],
                    next = "d_i_tvoj_brat_daj_ugadau_tozhe_prints",
                },
            },
        },
        d_spasibo_veru = {
            text = [[Добро пожаловать.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_spasibo = {
            text = [[*Эпштейн в предвкушении.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_sposobnostu = {
            text = [[Какой?!*Крипы в предвкушении. Фейерверки теперь повёрнуты не в твою сторону, а вверх.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...чувствовать живых существ в радиусе 1 км.]],
                    next = "d_chuvstvovat_zhivyh_suschestv_v_radiuse_1_km",
                },
            },
        },
        d_sebi = {
            text =
            [[*Одним ударом ты отправил псевдофаната в нокаут. Только вот остальные тоже возомнили себя преданными поклонниками. Все начали доказывать это друг другу.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Похоже до них всё ещё не дошло...*]],
                    next = "d_pohozhe_do_nih_vse_esche_ne_doshlo",
                },
            },
        },
        d_syad_zakroj_glaza_i_schitaj_do_tysyachi = {
            text = [[Если я это сделаю, ты не будешь делать ничего дикого?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Клянусь.]],
                    next = "d_klyanus",
                },
            },
        },
        d_tak_prikolnee_poluchilos = {
            text =
            [[*Они не знали, как и реагировать. Однако, даже после всего этого, они улыбаются. Ты их спаситель. И спаситель всех этих земель.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_tak_ty_verneshsya_domoj = {
            text = [[Да, и только благодаря тебе. У меня кстати есть вопрос: какая цель была у твоего перформанса?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Высвобождение.]],
                    next = "d_vysvobozhdenie",
                },
            },
        },
        d_tak_ty_pojdesh_domoj_ili_kak_semya_zhdet = {
            text = [[Ясно...]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Что?]],
                    next = "d_g6",
                },
            },
        },
        d_tak_chto = {
            text = [[Ааргъх... Это какое-то пиво. Позаимствовал у людей.]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[А у кого? Я б тоже подвыпил.]],
                    next = "d_a_u_kogo_ya_b_tozhe_podvypil",
                },
                {
                    text = [[Позаимствовал? Может украл?]],
                    next = "d_pozaimstvoval_mozhet_ukral",
                },
            },
        },
        d_takto_da = {
            text = [[ЧЕМ СЛОЖНЕЕ БИТВА, ТЕМ ВЕСЕЛЕЕ.]],
            speaker = [[npc_Epstein_guard]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_tam_nikogo_net_koroche_davajte_bystree = {
            text = [[Зачем спешить?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Эпштейн может сбежать, пока мы тут болтаем.]],
                    next = "d_epshtejn_mozhet_sbezhat_poka_my_tut_boltaem",
                },
            },
        },
        d_te_navernoe_kak_raz_zherty_epstina_da = {
            text = [[ДА.]],
            speaker = [[npc_Epstein_guard]],
            choices = {
                {
                    text = [[У тебя есть ключ от клетки?]],
                    next = "d_u_tebya_est_kluch_ot_kletki",
                },
            },
        },
        d_tebya_zovut_aleks = {
            text = [[Алекс... Алекс?]],
            speaker = [[npc_creep_bob]],
            choices = {
                {
                    text = [[Да.]],
                    next = "d_i8",
                },
            },
        },
        d_tebya_zovut_bob = {
            text = [[Боб... Точно! Спасибо!!]],
            speaker = [[npc_creep_bob]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_tebya_zovut_dzhon = {
            text = [[Джон... Джон? ]],
            speaker = [[npc_creep_bob]],
            choices = {
                {
                    text = [[Да.]],
                    next = "d_i8",
                },
            },
        },
        d_tebya_ischet_otets_vozvraschajsya_domoj = {
            text = [[ТЫ ЧЁ, ЕБЛАН? ХАХАХА, КАКОЙ ОТЕЦ???]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Ты знаешь о ком я говорю. Он ждёт, когда ты воссоединишься с ним и своими братьями.]],
                    next = "d_ty_znaesh_o_kom_ya_govoru_on_zhdet_kogda_ty_vossoedinishsya_s_nim_i_svoimi_bratyami",
                },
            },
        },
        d_tiho_k_chemu_voobsche_eta_istoriya = {
            text =
            [[2: А к тому, что брат захотел нас отблагодарить за спасение... Вот...1: Хоть мы и старше, он сказал, что мы глуповаты. Думаю, он не прав.]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[Думаю он прав.]],
                    next = "d_dumau_on_prav",
                },
                {
                    text = [[И чем он отплатил вам?]],
                    next = "d_l13",
                },
            },
        },
        d_to_est_korol_chmo = {
            text = [[ЧЁ СКАЗАЛ? Радуйся последним минутам, пока у тебя есть зубы.]],
            speaker = [[npc_monkey_king]],
            choices = {
                {
                    text = [[*Встать в боевую стойку.*]],
                    next = "d_j",
                },
            },
        },
        d_to_est_ya_ne_smogu_vernutsya = {
            text = [[Отсюда нет выхода, так что можешь считать это своей новой жизнью.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[...]],
                    next = "d_h3",
                },
            },
        },
        d_togda_zachem_s_nim_svyazyvatsya = {
            text = [[Он - немезис людского рода. ]],
            speaker = [[npc_mustache]],
            choices = {
                {
                    text = [[...]],
                    next = "d_i3",
                },
            },
        },
        d_togda_predlagau_torg = {
            text = [[*Уверенный в своих умениях перекуп соглашается.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[1 монета!]],
                    next = "d_1_moneta",
                },
            },
        },
        d_tolko_umnyj_sposoben_vyslushat_i_vzvesit_vse_za_i_protiv_a_ty_prosto_upertyj_vot_i_vse = {
            text = [[*Зелёный впервые призадумался.*]],
            speaker = [[default]],
            choices = {
                {
                    text =
                    [[И знаешь ли, мой кулак дробит камни, а тут передо мной статуя. Так что последний шанс пойти со мной.]],
                    next =
                    "d_i_znaesh_li_moj_kulak_drobit_kamni_a_tut_peredo_mnoj_statuya_tak_chto_poslednij_shans_pojti_so_mnoj",
                },
            },
        },
        d_ty_budto_statuya_znal = {
            text = [[Что нужно примитивному существу от Твердолобого?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Меня послал твой отец.]],
                    next = "d_menya_poslal_tvoj_otets",
                },
                {
                    text = [[*Дать ему щелбан.*]],
                    next = "d_dat_emu_schelban",
                },
            },
        },
        d_ty_ved_zelenyj = {
            text = [[У меня несколько имён, и да, это одно из них.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Тогда как ты мог его забыть? А братьев хоть помнишь: Красного и Синего?]],
                    next = "d_d",
                },
                {
                    text = [[А ведь он ждёт тебя дома.]],
                    next = "d_d",
                },
            },
        },
        d_ty_ved_krasnyj = {
            text = [[МОЖЕТ БЫТЬ, А ТЕБЕ ЧТО НАДО, СОПЛЯЧОК?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Тебя ищет отец, возвращайся домой.]],
                    next = "d_tebya_ischet_otets_vozvraschajsya_domoj",
                },
            },
        },
        d_ty_ved_obeschal_otdat_mantiu_im = {
            text = [[Верно, но я поддался искушению. Поверь, моим братьям Мантия будет только во вред.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[А почему ты не вернёшься домой?]],
                    next = "d_a_pochemu_ty_ne_verneshsya_domoj",
                },
            },
        },
        d_ty_zh_govoril_chto_ona_pustaya = {
            text = [[*Некоторое время он всё ещё был зол, однако, вспомнив причину пьянства, начал плакать.*]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[Просто так до такой степени не напиваются. Что не так?]],
                    next = "d_prosto_tak_do_takoj_stepeni_ne_napivautsya_chto_ne_tak",
                },
            },
        },
        d_ty_zhe_ponimaesh_chto_ya_mogu_tebya_prosto_izbit_i_zabrat = {
            text = [[Неаааааа, У МЕНЯ же есть....  НЕВИДИМОСТЬ.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[И вправду.]],
                    next = "d_g7",
                },
                {
                    text = [[У шторм спирита нет такого скилла.]],
                    next = "d_u_shtorm_spirita_net_takogo_skilla",
                },
            },
        },
        d_ty_zhe_ponimaesh_chto_ya_ne_ujdu = {
            text = [[Да. Упёртость - удел недалёких. Я понимал, что без драки не обойдётся.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[...]],
                    next = "d_m3",
                },
            },
        },
        d_ty_zhivoj = {
            text =
            [[*Только после этих слов он замечает тебя и начинает пристально осматривать твою фигуру, при этом не шевельнув ни мускулом.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Ты будто статуя, знал?]],
                    next = "d_ty_budto_statuya_znal",
                },
                {
                    text = [[*Потереть ему носик.*]],
                    next = "d_poteret_emu_nosik",
                },
            },
        },
        d_ty_znaesh_kak_ya_suda_popal = {
            text = [[Да, ты умер будучи человеком.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Это ад или рай?]],
                    next = "d_h2",
                },
                {
                    text = [[Я реинкарнировал?]],
                    next = "d_h2",
                },
                {
                    text = [[Мы в лимбе?]],
                    next = "d_my_v_limbe",
                },
            },
        },
        d_ty_znaesh_o_kom_ya_govoru_on_zhdet_kogda_ty_vossoedinishsya_s_nim_i_svoimi_bratyami = {
            text = [[ААААА, ТО ЕСТЬ У МЕНЯ ЕЩЁ И БРАТЬЯ ЕСТЬ, ВО ПРИКОЛ. ]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_a10",
                },
            },
        },
        d_ty_znal_chto_tvoj_otets_vrach_poshli_so_mnoj_i_tebya_podlataut_on_uzh_tochno_znaet_kak_pomoch = {
            text = [[Я никуда не пойду. И зачем мне врач?]],
            speaker = [[default]],
            choices = {
                {
                    text =
                    [[Сейчас по новостям крутят, что птицы переносят вирус. Его жертвы начинают становиться ебучими баранами.]],
                    next = "d_e",
                },
            },
        },
        d_ty_skazala_chto_ludej_malo_pochemu = {
            text = [[*Лицо девушки застыло. Опомнившись, она отвела взгляд.*]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Забудь.]],
                    next = "d_h6",
                },
            },
        },
        d_ty_slu = {
            text = [[Ты случайно не СИНИЙ? А?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Это был мой вопрос.]],
                    next = "d_eto_byl_moj_vopros",
                },
                {
                    text = [[Я чёрный.]],
                    next = "d_g2",
                },
            },
        },
        d_ty_sluchajno_ne_ogrgromila = {
            text = [[Да, это я.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[Меня послал твой брат... Или точнее братья.]],
                    next = "d_menya_poslal_tvoj_brat_ili_tochnee_bratya",
                },
            },
        },
        d_ty_tipo_niger = {
            text = [[*Крип восторженно подлетает.*Похож?! Реально похож?!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Не особо.]],
                    next = "d_ne_osobo",
                },
            },
        },
        d_ty_chelovek_ili_krip = {
            text = [[Эу, крип это твоя мама. Я царь здесь понял?]],
            speaker = [[npc_monkey_king]],
            choices = {
                {
                    text = [[А как же Король?]],
                    next = "d_a_kak_zhe_korol",
                },
                {
                    text = [[Маму не трогай.]],
                    next = "d_mamu_ne_trogaj",
                },
            },
        },
        d_u_menya_est_k_tebe_delo = {
            text = [[Почему мне должно быть не всё равно?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Меня послал твой отец.]],
                    next = "d_menya_poslal_tvoj_otets",
                },
            },
        },
        d_u_nas_byl_ugovor_ya_vypolnil_svou_chast_teper_tvoya_ochered = {
            text =
            [[АааААа... Не думаю, что ЭТО возможно... Тем более я НЕ ХОЧУ ни с кем быть, ведь когда Я начинаю говорить с КЕМ-ТО, то они убегают ОТ МЕНЯ...]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Понятное дело, говоря с тобой невозможно понять, что происходит.]],
                    next = "d_ponyatnoe_delo_govorya_s_toboj_nevozmozhno_ponyat_chto_proishodit",
                },
            },
        },
        d_u_tebya_est_kluch_ot_kletki = {
            text = [[ЕСТЬ.]],
            speaker = [[npc_Epstein_guard]],
            choices = {
                {
                    text = [[Ну и хорошо.]],
                    next = "d_nu_i_horosho",
                },
            },
        },
        d_u_shtorm_spirita_net_takogo_skilla = {
            text = [[ЗАТКНИСЬ.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Сделать сигму.*]],
                    next = "d_g7",
                },
            },
        },
        d_uhodi_i_bolshe_nikogda_ne_poyavlyajsya_zdes = {
            text = [[Спасибо. Никогда не забуду твоего милосердия. Извини, что пришлось разбираться со всем этим.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[...]],
                    next = "d_m6",
                },
            },
        },
        d_hm = {
            text = [[Защити мои постройки. Разрушь его. Таково задание. Берешься?]],
            speaker = [[npc_blue_prince]],
            choices = {
                {
                    text = [[Да.]],
                    next = "d_i9",
                    actions = {
                        { questID = "q_clash_royale", type = "quest_start" },
                    },
                },
                {
                    text = [[Не хочу.]],
                    next = "d_ne_hochu",
                },
            },
        },
        d_hm_neploho_no_dazhe_tak_mne_ne_hvatit_u_menya_50_zolota = {
            text = [[ПЯТЬДЕСЯТ?! Это очень мало, знаете ли...]],
            speaker = [[default]],
            choices = {
                {
                    text =
                    [[Эхх... значит не попасть моему дедушке-ветерану калеке на концерт своего любимого рэпера...]],
                    next = "d_ehh_znachit_ne_popast_moemu_dedushkeveteranu_kaleke_na_kontsert_svoego_lubimogo_repera",
                },
            },
        },
        d_hmm = {
            text = [[*Нужно найти кого-то, кто выглядит умным...*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_hmmm = {
            text = [[Добро пожаловать на мой остров! Как тебя зовут?]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[Алекс.]],
                    next = "d_n",
                },
                {
                    text = [[Где цмка?]],
                    next = "d_gde_tsmka",
                },
            },
        },
        d_horosh = {
            text = [[Мне пора идти, есть много перед кем нужно извиниться. Мы ещё обязательно увидимся.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Давай.]],
                    next = "d_davaj",
                },
            },
        },
        d_horosho_horosho_ya_kstati_tozhe_pojdu = {
            text = [[Но как??]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Помахать билетом.*]],
                    next = "d_pomahat_biletom",
                },
            },
        },
        d_tsenoj_svoej_zhizni_on_spas_poselenie_dobryh_kripov = {
            text = [[*Все четыре глаза поочерёдно заслезились.*]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[*Уйти.*]],
                    next = "d_m8",
                    actions = {
                        { questID = "q_ogres", type = "quest_end" },
                    },
                },
            },
        },
        d_tsmka_gde = {
            text = [[Сейчас она придёт, пока можешь отдохнуть.]],
            speaker = [[npc_Epstein]],
            choices = {
                {
                    text = [[Откуда ты вообще говоришь?]],
                    next = "d_otkuda_ty_voobsche_govorish",
                },
            },
        },
        d_chto = {
            text =
            [[*У тебя участилось дыхание, стало тяжело дышать, но тебя это даже впирает. Ты всё ещё не можешь принять того, что видишь.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Ааааахарр... Аргхэ.. Шууфувуу...]],
                    next = "d_aaaaaharr_arghe_shuufuvuu",
                },
            },
        },
        d_chego_tebe = {
            text = [[Эпштейн передаёт тебе привет.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_chego_usatyj = {
            text = [[Что слышал. Я не хочу видеть, чтобы кто-то ещё пал от его руки.]],
            speaker = [[npc_mustache]],
            choices = {
                {
                    text = [[Я умею драться так-то.]],
                    next = "d_ne_ponyal",
                },
            },
        },
        d_chego_chego = {
            text = [[Всё чётко, хоть и синие мальчики гоняются за мной, ты не трясись, всё холодное.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Ты типо нигер?]],
                    next = "d_ty_tipo_niger",
                },
            },
        },
        d_chego = {
            text = [[ЖЕРТВА ПЕРВОГО ДАЛА ПАДШИМ НАДЕЖДУ.]],
            speaker = [[npc_tormentor]],
            choices = {
                {
                    text = [[Откуда ты это сказал?]],
                    next = "d_otkuda_ty_eto_skazal",
                },
            },
        },
        d_chto_velikogo_on_sovershil = {
            text = [[Он... эм... *Она задумалась.* Много всего...]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Много чего?]],
                    next = "d_mnogo_chego",
                },
            },
        },
        d_chto_za_korol = {
            text =
            [[*Девушка покраснела*Король... Его зовут Джордж. Джордж Богоподобный. Он лучший человек... Идеальный во всём.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Что великого он совершил?]],
                    next = "d_chto_velikogo_on_sovershil",
                },
            },
        },
        d_chto_za_mantiya = {
            text = [[Любой, кто оденет её, станет самым умным в мире!]],
            speaker = [[npc_ogre_magi_slow]],
            choices = {
                {
                    text = [[А куда он отправился?]],
                    next = "d_a_kuda_on_otpravilsya",
                },
            },
        },
        d_chto_za_portal_szadi = {
            text = [[Никто не знает. Он не работает.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[Понятно.]],
                    next = "d_h6",
                },
            },
        },
        d_chto_za_predelami_korolevstva = {
            text = [[На западе - Заброшенный лес. Там проживают дикие крипы.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[*Далее.*]],
                    next = "d_h8",
                },
            },
        },
        d_chto_pesh = {
            text = [[*Панда плюнула в твою сторону, но не попала.*]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[Это было необязательно. Так что пьёшь то?]],
                    next = "d_a2",
                },
            },
        },
        d_chto_s_toboj = {
            text = [[*Он дважды стучит по пузу и наводит на тебя палец.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Ты слу...]],
                    next = "d_ty_slu",
                },
            },
        },
        d_chtoto_ne_tak = {
            text =
            [[Деревня алхимиков имеет много тайн. Я дала обет, что буду защищать их от чужих глаз. Уходи, если дорога жизнь.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[А если я хочу туда попасть?]],
                    next = "d_a_esli_ya_hochu_tuda_popast",
                },
                {
                    text = [[Не обет, а обед!]],
                    next = "d_ne_obet_a_obed",
                },
            },
        },
        d_chto__1 = {
            text = [[*Свет в его глазах угасает.*]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[...]],
                    next = "d_m5",
                },
            },
        },
        d_chto__2 = {
            text = [[Путник, ты попал в наши земли не просто так. У тебя есть миссия, Королевству нужен заступник.]],
            speaker = [[npc_shamanka]],
            choices = {
                {
                    text = [[Я умер пару минут назад, если что.]],
                    next = "d_ya_umer_paru_minut_nazad_esli_chto",
                },
            },
        },
        d_che_s_litsom_u_vas = {
            text =
            [[Мы думали только глупеньких, вроде нас, можно обмануть. А вы взрослый и умный, мистер. Ну мы так думали.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Эээ... Я вас обманул, я детектив. Веду слежку за этим островом.]],
                    next = "d_n3",
                },
            },
        },
        d_che_ty_krichish = {
            text = [[Вижу по твоим глазам, ты как я! Хочешь испытаний, хочешь проверить себя!]],
            speaker = [[npc_mustache]],
            choices = {
                {
                    text = [[Да!]],
                    next = "d_da__1",
                },
                {
                    text = [[Не, я просто заблудился.]],
                    next = "d_i4",
                },
            },
        },
        d_scha_zanyat_rebyatnya = {
            text = [[*Крипы расстроились и от скуки начали кидать в друг друга бомбочки.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_schekotno = {
            text = [[*Ты чувствуешь прилив сил, что-то чёрное начало струиться по твоим венам. Очи твои покраснели.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Думаю хватит.]],
                    next = "d_dumau_hvatit",
                },
            },
        },
        d_e_a_chto_ya = {
            text = [[Ты сильный, победил могучего стража.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[А, ну да.]],
                    next = "d_a_nu_da",
                },
            },
        },
        d_ej_ty = {
            text =
            [[*Существо резко поворачивается в твою сторону, совершив оборот в 180 градусов. После чего оно подпрыгивает.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Что с тобой?]],
                    next = "d_chto_s_toboj",
                },
            },
        },
        d_em_vrode_net = {
            text = [[Это не круто, мистер, а если мы заденем кого-нибудь, не думал?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Там никого нет, короче давайте быстрее.]],
                    next = "d_tam_nikogo_net_koroche_davajte_bystree",
                },
            },
        },
        d_epshtejn_mozhet_sbezhat_poka_my_tut_boltaem = {
            text =
            [[Докажи, что там никого нет. Мы не хотим использовать наше оружие во вред невинным.*Двое по бокам навели на тебя хлопушки.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Я был в каждой комнате, точно пусто.]],
                    next = "d_ya_byl_v_kazhdoj_komnate_tochno_pusto",
                },
            },
        },
        d_eto_byl_moj_vopros = {
            text = [[А это... был МОЙ ответ...]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Не знал, что даже в мире мёртвых употребляют.]],
                    next = "d_ne_znal_chto_dazhe_v_mire_mertvyh_upotreblyaut",
                },
            },
        },
        d_eto_ego_mechta_poslednee_chto_derzhit_deda_na_etoj_zemle = {
            text = [[Так уж и быть... Ради твоего дедушки - 50 золота.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Ой, я перепутал, у меня не золото, а тенге.]],
                    next = "d_oj_ya_pereputal_u_menya_ne_zoloto_a_tenge",
                },
            },
        },
        d_eto_zachem = {
            text =
            [[Я способна пробуждать скрытые возможности тела человека. Коснись меня и твоя истинная форма проявится.]],
            speaker = [[npc_shamanka]],
            choices = {
                {
                    text = [[*Протянуть руку.*]],
                    next = "d_protyanut_ruku",
                },
                {
                    text = [[*Потянуть руку к штанам.*]],
                    next = "d_potyanut_ruku_k_shtanam",
                },
            },
        },
        d_eto_nadolgo = {
            text = [[Великое требует времени.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Ну давай.]],
                    next = "d_nu_davaj",
                },
                {
                    text = [[Я занят.]],
                    next = "d_ya_zanyat",
                },
            },
        },
        d_eto_svyazano_s_mantiej = {
            text = [[Да.]],
            speaker = [[npc_ogre_bruiser]],
            choices = {
                {
                    text = [[...]],
                    next = "d_m",
                },
            },
        },
        d_eto_sleva = {
            text = [[Ого! Люди всё-таки тоже могут думать. Ваух!]],
            speaker = [[npc_ogre_magi_fast]],
            choices = {
                {
                    text = [[Вообщем Заброшенный лес.]],
                    next = "d_l15",
                },
            },
        },
        d_eto_horosho_po_puti_prihvachu = {
            text = [[Только ты поделишься с мной, ммм...]],
            speaker = [[npc_rape_victim]],
            choices = {
                {
                    text = [[Плата за информацию?]],
                    next = "d_plata_za_informatsiu",
                },
                {
                    text = [[Как пойдёт.]],
                    next = "d_kak_pojdet",
                },
            },
        },
        d_etot_mir_spasen = {
            text =
            [[Огромное спасибо, мистер. Благодаря тебе, тут стало намного безопаснее. *Крипы кланяются тебе. Ты стал их кумиром.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_eh = {
            text = [[Смотри! Этот паренёк вообще как спичка! Давай проведём им по шершавому!]],
            speaker = [[npc_ogre_magi_fast]],
            choices = {
                {
                    text = [[Не нужно, поверьте.]],
                    next = "d_ne_nuzhno_poverte",
                },
            },
        },
        d_ehh_znachit_ne_popast_moemu_dedushkeveteranu_kaleke_na_kontsert_svoego_lubimogo_repera = {
            text = [[Ветерану?.. Калеке?.. Эм... А он прям... очень хочет попасть туда?..]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Это его мечта. Последнее, что держит деда на этой земле.]],
                    next = "d_eto_ego_mechta_poslednee_chto_derzhit_deda_na_etoj_zemle",
                },
            },
        },
        d_ya_aleks_voobscheto = {
            text = [[Разве? Прости меня, перепутал немного. Некрасиво получилось, да...]],
            speaker = [[npc_creep_rogach]],
            choices = {
                {
                    text = [[Бывает.]],
                    next = "d_i",
                },
            },
        },
        d_ya_byl_v_kazhdoj_komnate_tochno_pusto = {
            text = [[*Эти слова не завоевали их доверия.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Я обладаю.]],
                    next = "d_ya_obladau",
                },
                {
                    text = [[СЗАДИ ВАС ЭПШТЕЙН!!!]],
                    next = "d_szadi_vas_epshtejn",
                },
            },
        },
        d_ya_vizhu_pit_perestal_da = {
            text =
            [[Да, и не только. Вся моя жизнь пошла в гору, особенно отношения с другими существами. Точно не уверен почему это произошло, но очень доволен, что так вышло.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Рад за тебя.]],
                    next = "d_rad_za_tebya",
                },
            },
        },
        d_ya_gotov = {
            text = [[Выходи один на один, уёбок.]],
            speaker = [[npc_monkey_king]],
            choices = {
                {
                    text = [[Начнём.]],
                    next = "d_nachnem_duel",
                    actions = {
                        { target = "talk", type = "fight_start" },
                    },
                },
            },
        },
        d_ya_dumal_ty_shtorm_spirit = {
            text = [[ХАХА ХА ха... ХА.. хахааа... Может ты и есть ТОТ, кто разрушит КАПКАН?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Так ты пойдёшь домой или как? Семья ждёт.]],
                    next = "d_tak_ty_pojdesh_domoj_ili_kak_semya_zhdet",
                },
            },
        },
        d_ya_zh_mog_ne_podebyvat_no_ya_zahotel_i_pri_etom_dones_do_tebya_mysl = {
            text = [[*Синий взлетел. Глаза его полыхали. Озарение.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_g20",
                },
            },
        },
        d_ya_zanyat = {
            text = [[Буду ждать.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_ya_koroch_poshel = {
            text = [[1: Стой! Мы просим твою помощь. Брат наш, Огр-громила, ПОТЕРЯЛСЯ!2:Исчез с радаров!]],
            speaker = [[npc_ogre_magi_both]],
            choices = {
                {
                    text = [[И?]],
                    next = "d_i__1",
                },
            },
        },
        d_ya_mogu_tebe_kaknibud_pomoch = {
            text =
            [[Хмм... Точно! Скоро будет концерт известного чёрного рэпера! Послушав его, я точно наберусь знаний!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[...]],
                    next = "d_j2",
                },
            },
        },
        d_ya_najdu_perekupa_i_zaberu_bilety_skazhi_gde_on = {
            text = [[Он... Эм... Вроде был в Заброшенном лесу, но точно не знаю где.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Его внешность?]],
                    next = "d_ego_vneshnost",
                },
            },
        },
        d_ya_ne_nadeus_chto_ty_menya_poslushaesh_no_nadeus_chto_ty_verneshsya_k_ottsu_i_bratyam = {
            text =
            [[*Пока ты произносишь свою фразу, он начинает тянуть свой нос, смотря на твой. Возможно, он насмехается? Или вообще пытается добиться такого же размера путём растяжки?*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[*Почему это вообще в моих мыслях?*]],
                    next = "d_g6",
                },
            },
        },
        d_ya_obladau = {
            text = [[Чем?]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Способностью...]],
                    next = "d_sposobnostu",
                },
            },
        },
        d_ya_otpravilsya_spasat_vas = {
            text = [[Ого!! Вы такой крутой!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Да я.]],
                    next = "d_da_ya",
                },
            },
        },
        d_ya_santa_klaus_segodnya = {
            text = [[Что ты положил туда?!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Уголь.]],
                    next = "d_n7",
                },
            },
        },
        d_ya_sejchas_nachnu_strelyat_lazerami_iz_glaz = {
            text =
            [[*Демоны в недоумении.*Как это вообще возможно? Никому не удавалось заполучить преимущества Тени и при этом остаться человеком!]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Замолкните ничтожества... С этого момента, именуюсь я, как...]],
                    next = "d_zamolknite_nichtozhestva_s_etogo_momenta_imenuus_ya_kak",
                },
            },
        },
        d_ya_slyshu_chto_pivo_esche_est = {
            text = [[Неа.]],
            speaker = [[npc_brewmaster]],
            choices = {
                {
                    text = [[Жмот.]],
                    next = "d_zhmot",
                },
            },
        },
        d_ya_togda_tozhe_budu = {
            text = [[МОЛОДЧИНА!]],
            speaker = [[npc_mustache]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
        d_ya_tozhe_popalsya = {
            text = [[*Они смотрят на тебя с удивлением, никто не может поверить в это.*]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Чё с лицом у вас?]],
                    next = "d_che_s_litsom_u_vas",
                },
            },
        },
        d_ya_ubil_ih = {
            text =
            [[Это отличная новость! Мы не могли обеспечить защиту этих врат, так как нас, людей, осталось единицы.]],
            speaker = [[npc_guide]],
            choices = {
                {
                    text = [[А крипы это кто?]],
                    next = "d_a_kripy_eto_kto",
                },
            },
        },
        d_ya_umer_paru_minut_nazad_esli_chto = {
            text =
            [[*Проигноривовав твои слова, она протягивает руку и чего-то ждёт. Ты чувствуешь, как её потрясывает.*]],
            speaker = [[npc_shamanka]],
            choices = {
                {
                    text = [[Это зачем?]],
                    next = "d_eto_zachem",
                },
            },
        },
        d_yajtsa = {
            text = [[Кто МОЙ любимый ДУХ.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Void Spirit.]],
                    next = "d_g16",
                },
                {
                    text = [[Earth Spirit.]],
                    next = "d_g16",
                },
                {
                    text = [[Storm Spirit.]],
                    next = "d_g17",
                },
                {
                    text = [[Ember Spirit.]],
                    next = "d_ember_spirit",
                },
            },
        },
        d_yarost = {
            text = [[Я ПРИНИМАЮ ТВОЙ ВЫЗОВ.]],
            speaker = [[default]],
            choices = {
                {
                    text = [[Закрыть.]],
                    next = nil,
                },
            },
        },
    },
}
