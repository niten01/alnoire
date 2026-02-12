local QuestStatus = require('modules.quest.quest_status')
return {
entries = {
d_untitled_passage = {
priority = 0,
conditions = {
{ interact="npc_brewmaster",type="interact" },
{ questID="q_pandas",status=QuestStatus.INACTIVE,type="quest" },
{ var="act",value={ 1, 2, 3 },type="var" },
},
},
d_untitled_passage_11 = {
priority = 0,
conditions = {
{ ent_var="beaten",value={ false },npc="npc_island_guard",type="ent_var" },
{ trigger="trigger_island_fight_1",npc="npc_island_guard",type="trigger" },
},
},
d_untitled_passage_12 = {
priority = 0,
conditions = {
{ trigger="trigger_gate_trolls",npc="npc_troll",type="trigger" },
},
},
d_untitled_passage_13 = {
priority = 0,
conditions = {
{ var="act",value={ 0 },type="var" },
{ trigger="trigger_guide_first",npc="npc_guide",type="trigger" },
},
},
d_untitled_passage_14 = {
priority = 0,
conditions = {
{ interact="npc_guide",type="interact" },
{ questID="q_main_quest_act_1",status=QuestStatus.ACTIVE,step={ 1, 2 },type="quest" },
},
},
d_untitled_passage_15 = {
priority = 0,
conditions = {
{ var="act",value={ 0 },type="var" },
{ trigger="trigger_rebirth",npc="npc_tormentor",type="trigger" },
},
},
d_untitled_passage_16 = {
priority = 0,
conditions = {
{ interact="npc_tormentor",type="interact" },
{ var="act",value={ 0 },type="var" },
},
},
d_untitled_passage_17 = {
priority = 100,
conditions = {
{ interact="npc_creep_rogach",type="interact" },
{ ent_var="first_met_global",value={ true },npc="npc_creep_rogach",type="ent_var" },
},
},
d_untitled_passage_18 = {
priority = 0,
conditions = {
{ interact="npc_creep_rogach",type="interact" },
},
},
d_untitled_passage_19 = {
priority = 100,
conditions = {
{ trigger="trigger_usach_stopit",npc="npc_mustache",type="trigger" },
{ ent_var="first_met_global",value={ true },npc="npc_mustache",type="ent_var" },
},
},
d_untitled_passage_2 = {
priority = 0,
conditions = {
{ beat="npc_red",type="beat" },
},
},
d_untitled_passage_20 = {
priority = 0,
conditions = {
{ interact="npc_mustache",type="interact" },
},
},
d_untitled_passage_21 = {
priority = 0,
conditions = {
{ interact="npc_creep_bob",type="interact" },
{ ent_var="first_met_global",value={ true },npc="npc_creep_bob",type="ent_var" },
},
},
d_untitled_passage_22 = {
priority = 0,
conditions = {
{ interact="npc_creep_bob",type="interact" },
{ ent_var="first_met_global",value={ false },npc="npc_creep_bob",type="ent_var" },
},
},
d_untitled_passage_23 = {
priority = 0,
conditions = {
{ interact="npc_blue_prince",type="interact" },
{ var="act",value={ 1 },type="var" },
{ questID="q_clash_royale",status=QuestStatus.INACTIVE,type="quest" },
},
},
d_untitled_passage_24 = {
priority = 0,
conditions = {
{ interact="npc_blue_prince",type="interact" },
{ questID="q_clash_royale",status=QuestStatus.ACTIVE,step={ 1 },type="quest" },
},
},
d_untitled_passage_25 = {
priority = 0,
conditions = {
{ interact="npc_blue_prince",type="interact" },
{ questID="q_clash_royale",status=QuestStatus.REJECTED,type="quest" },
},
},
d_untitled_passage_26 = {
priority = 0,
conditions = {
{ trigger="trigger_bidlo",npc="npc_monkey_king",type="trigger" },
},
},
d_untitled_passage_27 = {
priority = 0,
conditions = {
{ beat="npc_monkey_king",type="beat" },
},
},
d_untitled_passage_33 = {
priority = 0,
conditions = {
{ trigger="trigger_slish_kamish",npc="npc_rape_victim",type="trigger" },
},
},
d_untitled_passage_34 = {
priority = 0,
conditions = {
{ interact="npc_rape_victim",type="interact" },
},
},
d_untitled_passage_40 = {
priority = 0,
conditions = {
{ interact="npc_ogre_magi",type="interact" },
{ questID="q_ogres",status=QuestStatus.INACTIVE,type="quest" },
{ var="act",value={ 1 },type="var" },
},
},
d_untitled_passage_41 = {
priority = 0,
conditions = {
{ interact="npc_ogre_magi",type="interact" },
{ questID="q_ogres",status=QuestStatus.ACTIVE,type="quest" },
{ questID="q_ogres",status=QuestStatus.ACTIVE,step={ 1, 2, 3 },type="quest" },
},
},
d_untitled_passage_42 = {
priority = 0,
conditions = {
{ interact="npc_ogre_bruiser",type="interact" },
{ questID="q_ogres",status=QuestStatus.ACTIVE,step={ 1 },type="quest" },
},
},
d_untitled_passage_43 = {
priority = 0,
conditions = {
{ beat="npc_ogre_bruiser",type="beat" },
},
},
d_untitled_passage_44 = {
priority = 0,
conditions = {
{ interact="npc_ogre_magi",type="interact" },
{ questID="q_ogres",status=QuestStatus.ACTIVE,step={ 4 },type="quest" },
},
},
d_untitled_passage_45 = {
priority = 0,
conditions = {
{ interact="npc_ogre_magi",type="interact" },
{ questID="q_ogres",status=QuestStatus.COMPLETED,type="quest" },
},
},
d_untitled_passage_46 = {
priority = 0,
conditions = {
{ trigger="trigger_island_first",type="trigger" },
{ var="act",value={ 1, 2 },type="var" },
},
},
d_untitled_passage_47 = {
priority = 0,
conditions = {
{ trigger="trigger_island_second",type="trigger" },
{ var="act",value={ 1, 2 },type="var" },
},
},
d_untitled_passage_48 = {
priority = 0,
conditions = {
{ var="act",value={ 1, 2 },type="var" },
{ trigger="trigger_island_fight_1",npc="npc_island_guard",type="trigger" },
},
},
d_untitled_passage_49 = {
priority = 0,
conditions = {
{ trigger="trigger_island_third",type="trigger" },
{ var="act",value={ 1, 2 },type="var" },
},
},
d_untitled_passage_59 = {
priority = 100,
conditions = {
{ trigger="trigger_village_enter",npc="npc_templar_assasin",type="trigger" },
},
},
d_untitled_passage_60 = {
priority = 80,
conditions = {
{ interact="npc_templar_assasin",type="interact" },
{ var="knows_village_password",value={ false },type="var" },
},
},
d_untitled_passage_61 = {
priority = 90,
conditions = {
{ interact="npc_templar_assasin",type="interact" },
{ var="knows_village_password",value={ true },type="var" },
{ var="has_village_pass",value={ false },type="var" },
},
},
d_untitled_passage_63 = {
priority = 0,
conditions = {
{ interact="npc_blue_prince",type="interact" },
{ questID="q_clash_royale",status=QuestStatus.ACTIVE,step={ 3 },type="quest" },
},
},
d_untitled_passage_64 = {
priority = 0,
conditions = {
{ interact="npc_ogre_bruiser",type="interact" },
{ questID="q_ogres",status=QuestStatus.INACTIVE,type="quest" },
},
},
d_untitled_passage_65 = {
priority = 0,
conditions = {
{ interact="npc_ogre_magi",type="interact" },
{ questID="q_ogres",status=QuestStatus.REJECTED,type="quest" },
},
},
d_untitled_passage_66 = {
priority = 0,
conditions = {
{ interact="npc_blue_prince",type="interact" },
{ questID="q_clash_royale",status=QuestStatus.COMPLETED,type="quest" },
},
},
d_untitled_passage_67 = {
priority = 0,
conditions = {
{ interact="npc_monkey_king",type="interact" },
{ ent_var="beaten",value={ true },npc="npc_monkey_king",type="ent_var" },
},
},
d_untitled_passage_68 = {
priority = 0,
conditions = {
{ interact="npc_ogre_magi",type="interact" },
{ var="act",value={ 2, 3, 4 },type="var" },
{ questID="q_ogres",status="incomplete",type="quest" },
},
},
d_untitled_passage_69 = {
priority = 0,
conditions = {
{ interact="npc_monkey_king",type="interact" },
{ ent_var="beaten",value={ false },npc="npc_monkey_king",type="ent_var" },
},
},
d_untitled_passage_70 = {
priority = 0,
conditions = {
{ var="act",value={ 2, 3, 4 },type="var" },
{ interact="npc_blue_prince",type="interact" },
{ questID="q_clash_royale",status="incomplete",type="quest" },
},
},
d_untitled_passage_71 = {
priority = 0,
conditions = {
{ interact="npc_brewmaster",type="interact" },
{ questID="q_pandas",status=QuestStatus.REJECTED,type="quest" },
},
},
d_untitled_passage_72 = {
priority = 0,
conditions = {
{ trigger="trigger_beginning",type="trigger" },
{ var="act",value={ 0 },type="var" },
},
},
d_untitled_passage_73 = {
priority = 0,
conditions = {
{ var="act",value={ 0 },type="var" },
{ trigger="trigger_school_shooter_1",npc="npc_sniper",type="trigger" },
},
},
d_untitled_passage_74 = {
priority = 0,
conditions = {
{ interact="npc_predvestnik",type="interact" },
{ var="act",value={ 1 },type="var" },
{ questID="q_main_quest_act_1",status=QuestStatus.ACTIVE,step={ 1 },type="quest" },
},
},
d_untitled_passage_75 = {
priority = 0,
conditions = {
{ interact="npc_predvestnik",type="interact" },
{ questID="q_main_quest_1",status=QuestStatus.ACTIVE,step={ 2 },type="quest" },
{ var="act",value={ 1 },type="var" },
},
},
d_untitled_passage_76 = {
priority = 0,
conditions = {
{ interact="npc_mystery",type="interact" },
{ var="act",value={ 1 },type="var" },
},
},
d_untitled_passage_77 = {
priority = 100,
conditions = {
{ interact="npc_scientist",type="interact" },
{ var="act",value={ 1 },type="var" },
{ ent_var="first_met_global",value={ true },npc="npc_scientist",type="ent_var" },
},
},
d_untitled_passage_78 = {
priority = 60,
conditions = {
{ interact="npc_templar_assasin",type="interact" },
{ var="has_village_pass",value={ true },type="var" },
},
},
d_untitled_passage_79 = {
priority = 0,
conditions = {
{ interact="npc_alchemist",type="interact" },
},
},
d_untitled_passage_8 = {
priority = 0,
conditions = {
{ interact="npc_shamanka",type="interact" },
{ var="act",value={ 0 },type="var" },
},
},
d_untitled_passage_80 = {
priority = 70,
conditions = {
{ interact="npc_scientist",type="interact" },
},
},
d_untitled_passage_81 = {
priority = 0,
conditions = {
{ interact="npc_concert_guard",type="interact" },
{ var="act",value={ 1 },type="var" },
},
},
d_untitled_passage_82 = {
priority = 0,
conditions = {
{ trigger="trigger_no_skis",type="trigger" },
{ var="has_ski",value={ false },type="var" },
},
},
d_untitled_passage_83 = {
priority = 0,
conditions = {
{ interact="npc_predvestnik",type="interact" },
{ questID="q_main_quest_act_1",status=QuestStatus.ACTIVE,step={ 3 },type="quest" },
{ has_item="item_crystal_ball",type="has_item" },
},
},
d_untitled_passage_84 = {
priority = 0,
conditions = {
{ trigger="trigger_gorilla",npc="npc_gorilla",type="trigger" },
},
},
d_untitled_passage_85 = {
priority = 0,
conditions = {
{ ent_var="beaten",value={ false },npc="npc_red",type="ent_var" },
{ interact="npc_red",type="interact" },
{ questID="q_pandas",status=QuestStatus.ACTIVE,step={ 1 },type="quest" },
{ ent_var="first_met_global",value={ false },npc="npc_red",type="ent_var" },
},
},
d_untitled_passage_86 = {
priority = 0,
conditions = {
{ trigger="trigger_after_gorilla",npc="npc_guide",type="trigger" },
{ var="act",value={ 1 },type="var" },
},
},
d_untitled_passage_9 = {
priority = 0,
conditions = {
{ var="act",value={ 0 },type="var" },
{ trigger="trigger_choose_hero",npc="npc_shamanka",type="trigger" },
},
},
d_redhlup = {
priority = 0,
conditions = {
{ interact="npc_red",type="interact" },
{ questID="q_pandas",status=QuestStatus.ACTIVE,step={ 1 },type="quest" },
{ ent_var="first_met_global",value={ true },npc="npc_red",type="ent_var" },
},
},
d_secretending = {
priority = 0,
conditions = {
{ kill="npc_shooter",type="kill" },
{ var="act",value={ 0 },type="var" },
},
},
d_subwaycity = {
priority = 0,
conditions = {
{ interact="npc_subway_city",type="interact" },
},
},
d_subwaytocity = {
priority = 0,
conditions = {
{ interact="npc_subway_to_city",type="interact" },
},
},
d_bouncerhaveticket = {
priority = 0,
conditions = {
{ interact="npc_concert_guard",type="interact" },
{ var="act",value={ 2 },type="var" },
{ has_item="item_concert_ticket",type="has_item" },
{ var="has_concert_pass",value={ false },type="var" },
},
},
d_bouncernoticket = {
priority = 0,
conditions = {
{ interact="npc_concert_guard",type="interact" },
{ var="act",value={ 2 },type="var" },
{ no_item="item_concert_ticket",type="no_item" },
{ var="has_concert_pass",value={ false },type="var" },
},
},
d_dreamafterquestgive = {
priority = 0,
conditions = {
{ interact="npc_dream",type="interact" },
{ questID="q_concert",status=QuestStatus.ACTIVE,step={ 1 },type="quest" },
},
},
d_dreamafterreject = {
priority = 0,
conditions = {
{ interact="npc_dream",type="interact" },
{ questID="q_concert",status=QuestStatus.REJECTED,type="quest" },
},
},
d_dreamfirstmet = {
priority = 0,
conditions = {
{ trigger="trigger_black_creep",npc="npc_dream",type="trigger" },
{ var="act",value={ 2 },type="var" },
},
},
d_dreamonconcert = {
priority = 0,
conditions = {
{ interact="npc_dream",type="interact" },
{ var="act",value={ 2 },type="var" },
{ questID="q_concert",status=QuestStatus.COMPLETED,type="quest" },
},
},
d_dreamturnin = {
priority = 0,
conditions = {
{ questID="q_concert",status=QuestStatus.ACTIVE,step={ 2 },type="quest" },
{ interact="npc_dream",type="interact" },
{ has_item="item_concert_ticket",type="has_item" },
},
},
d_epskillers = {
priority = 0,
conditions = {
{ trigger="trigger_epstein_killer",npc="npc_killer",type="trigger" },
},
},
d_epskillersagain = {
priority = 0,
conditions = {
{ trigger="trigger_epstein_killer",npc="npc_killer",type="trigger" },
},
},
d_fairytale = {
priority = 0,
conditions = {
{ interact="npc_storyteller",type="interact" },
{ ent_var="first_met_global",value={ true },npc="npc_storyteller",type="ent_var" },
},
},
d_fairytaleagain = {
priority = 0,
conditions = {
{ ent_var="first_met_global",value={ false },npc="npc_storyteller",type="ent_var" },
{ interact="npc_storyteller",type="interact" },
},
},
d_geniusfightagain = {
priority = 0,
conditions = {
{ interact="npc_genius",type="interact" },
{ var="act",value={ 2, 3 },type="var" },
{ ent_var="first_met_global",value={ false },npc="npc_genius",type="ent_var" },
},
},
d_geniusfirstmet = {
priority = 0,
conditions = {
{ interact="npc_genius",type="interact" },
{ var="act",value={ 2, 3 },type="var" },
{ ent_var="first_met_global",value={ true },npc="npc_genius",type="ent_var" },
},
},
d_greenfightagain = {
priority = 0,
conditions = {
{ interact="npc_green",type="interact" },
{ ent_var="first_met_global",value={ false },npc="npc_green",type="ent_var" },
{ var="green_test_tried",value={ true },type="var" },
},
},
d_greenfirstmet = {
priority = 0,
conditions = {
{ interact="npc_green",type="interact" },
{ var="green_test_tried",value={ false },type="var" },
},
},
d_greenlose = {
priority = 0,
conditions = {
{ green_strong_hit=false,type="green_test" },
},
},
d_greenwin = {
priority = 0,
conditions = {
{ green_strong_hit=true,type="green_test" },
},
},
d_guideact2 = {
priority = 0,
conditions = {
{ interact="npc_guide",type="interact" },
{ var="act",value={ 2 },type="var" },
},
},
d_hermitagain = {
priority = 0,
conditions = {
{ interact="npc_hermit",type="interact" },
{ ent_var="first_met_global",value={ false },npc="npc_hermit",type="ent_var" },
},
},
d_hermitfirstmet = {
priority = 0,
conditions = {
{ interact="npc_hermit",type="interact" },
{ questID="q_main_quest_act_2",status=QuestStatus.ACTIVE,step={ 3 },type="quest" },
{ ent_var="first_met_global",value={ true },npc="npc_hermit",type="ent_var" },
},
},
d_leaderagain1 = {
priority = 0,
conditions = {
{ interact="npc_leader",type="interact" },
{ ent_var="first_met_in_act",value={ false },npc="npc_leader",type="ent_var" },
{ var="act",value={ 2 },type="var" },
{ questID="q_main_quest_act_2",status=QuestStatus.ACTIVE,type="quest" },
},
},
d_leaderfirstmet = {
priority = 0,
conditions = {
{ interact="npc_leader",type="interact" },
{ questID="q_main_quest_act_2",status=QuestStatus.ACTIVE,step={ 2 },type="quest" },
},
},
d_leaderpass3 = {
priority = 0,
conditions = {
{ interact="npc_leader",type="interact" },
{ questID="q_main_quest_act_3",status=QuestStatus.ACTIVE,step={ 1 },type="quest" },
},
},
d_leadersecond = {
priority = 100,
conditions = {
{ interact="npc_leader",type="interact" },
{ questID="q_main_quest_act_2",status=QuestStatus.ACTIVE,step={ 4 },type="quest" },
},
},
d_mustacheact2 = {
priority = 80,
conditions = {
{ interact="npc_mustache",type="interact" },
{ var="act",value={ 2 },type="var" },
{ ent_var="first_met_in_act",value={ true },npc="npc_mustache",type="ent_var" },
},
},
d_mysteryinteract2 = {
priority = 0,
conditions = {
{ interact="npc_mystery",type="interact" },
{ var="act",value={ 2 },type="var" },
},
},
d_rogachact2 = {
priority = 80,
conditions = {
{ interact="npc_creep_rogach",type="interact" },
{ var="act",value={ 2 },type="var" },
{ ent_var="first_met_in_act",value={ true },npc="npc_creep_rogach",type="ent_var" },
},
},
d_seller1 = {
priority = 0,
conditions = {
{ interact="npc_perekup",type="interact" },
{ questID="q_concert",status=QuestStatus.ACTIVE,step={ 1 },type="quest" },
{ var="act",value={ 2 },type="var" },
{ ent_var="first_met_global",value={ true },npc="npc_perekup",type="ent_var" },
},
},
d_sellerfightagain = {
priority = 0,
conditions = {
{ ent_var="beaten",value={ false },npc="npc_perekup",type="ent_var" },
{ interact="npc_perekup",type="interact" },
{ var="act",value={ 2 },type="var" },
{ questID="q_concert",status=QuestStatus.ACTIVE,step={ 1 },type="quest" },
{ ent_var="first_met_global",value={ false },npc="npc_perekup",type="ent_var" },
{ var="perekup_good_ending",value={ false },type="var" },
},
},
d_sellernofight = {
priority = 0,
conditions = {
{ interact="npc_perekup",type="interact" },
{ var="perekup_good_ending",value={ true },type="var" },
},
},
d_sellernoquest = {
priority = 0,
conditions = {
{ interact="npc_perekup",type="interact" },
{ questID="q_concert",status=QuestStatus.INACTIVE,type="quest" },
},
},
d_shamankaact2questactive = {
priority = 0,
conditions = {
{ questID="q_main_quest_act_2",status=QuestStatus.ACTIVE,step={ 4 },type="quest" },
{ interact="npc_shamanka",type="interact" },
},
},
d_shamankaact2questcomplete = {
priority = 0,
conditions = {
{ interact="npc_shamanka",type="interact" },
{ questID="q_main_quest_act_2",status=QuestStatus.COMPLETED,type="quest" },
},
},
d_xavierafterfight = {
priority = 0,
conditions = {
{ interact="npc_xavier",type="interact" },
{ ent_var="first_met_global",value={ true },npc="npc_xavier",type="ent_var" },
{ var="concert_crowd_beaten",value={ true },type="var" },
},
},
d_xavieragain = {
priority = 0,
conditions = {
{ interact="npc_xavier",type="interact" },
{ ent_var="first_met_global",value={ false },npc="npc_xavier",type="ent_var" },
{ var="concert_crowd_beaten",value={ true },type="var" },
},
},
d_xavierfightagain = {
priority = 0,
conditions = {
{ trigger="trigger_concert_crowd",type="trigger" },
{ var="concert_crowd_beaten",value={ false },type="var" },
{ var="concert_crowd_met",value={ true },type="var" },
},
},
d_xavierstart = {
priority = 0,
conditions = {
{ trigger="trigger_concert_crowd",type="trigger" },
{ var="concert_crowd_met",value={ false },type="var" },
},
},
},
nodes = {
d_novye_ludi = {
text = [[Да, такие как ты. Их не заинтересовала жизнь с нами, потому они обосновались отдельно. В Королевстве сейчас живут только последователи Короля.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Понятно.]],
next = "d_h6",
},
},
},
d_utopat_v_ovatsiyah = {
text = [[*Жар окутывает твою спину. Невыносимый жар. Тебе не нужно оборачиваться, чтобы понять кто это.*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Ярость.*]],
next = "d_yarost",
},
},
},
d_vzyat_kamen = {
text = [[Увидимся тогда! Нам пора продолжать. Слава Королю!]],
speaker = [[Человек-учёный]],
npc = "npc_scientist",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_vzyat_predmet = {
text = [[Врата в Королевство перед тобой. Ступай и накажи грешника.]],
speaker = [[Старушка]],
npc = "npc_shamanka",
choices = {
{
text = [[Кого?]],
next = "d_kogo",
},
},
},
d_vzyat_s_pola_kamen = {
text = [[*Ты чувствуешь его вес, он настоящий.*]],
speaker = [[...]],
npc = "npc_tormentor",
choices = {
{
text = [[*Метнуть камень в сооружение.*]],
next = "d_metnut_kamen_v_sooruzhenie",
},
},
},
d_vybrat_svou_sudbu = {
text = [[Вот, возьми талисман. Один человек попросил отдать это кому-то с невероятно сильным внутренним миром. Думаю лучше экземпляра я и не встречу.]],
speaker = [[Старушка]],
npc = "npc_shamanka",
choices = {
{
text = [[*Взять предмет*]],
next = "d_vzyat_predmet",
actions = {
{ itemName="item_key_part_2",type="give_item" },
},
},
},
},
d_da_skuchnovato = {
text = [[*Ты откинулся на спинку и ни о чём не думаешь.*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[*Начать думать.*]],
next = "d_nachat_dumat",
},
{
text = [[*Продолжать не думать.*]],
next = "d_prodolzhat_ne_dumat",
},
},
},
d_zachem_ya_eto_skazal = {
text = [[Запомни эти слова. Здесь моя работа окончена.]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[Запомнить для чего?]],
next = "d_zapomnit_dlya_chego",
actions = {
{ npc="npc_mystery",type="remove" },
},
},
},
},
d_metnut_kamen_v_sooruzhenie = {
text = [[*Твой бросок на что-то повлиял. Золотая фигура издала тихий звук.*]],
speaker = [[...]],
npc = "npc_tormentor",
choices = {
{
text = [[*Подойти поближе и прислушаться.*]],
next = "d_podojti_poblizhe_i_prislushatsya",
},
},
},
d_nabludat = {
text = [[*Предвестник зажигает несколько свечек. Он садится и кладёт руки на шар. Всё это сопровождается его глубокими вдохами и едва слышным мычанием.*]],
speaker = [[Крип-предвестник апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[...]],
next = "d_p4",
},
},
},
d_nachat_bitvu = {
text = [[]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_nachat_dumat = {
text = [[*Почему люди покупают лотерейные билеты, зная, что ничего не выйграют?*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[*Потому что они глупые, но с надеждой?*]],
next = "d_o2",
},
{
text = [[*Потому что думают, что заработать как-то иначе невозможно?*]],
next = "d_o2",
},
},
},
d_nachat_oboronyatsya = {
text = [[]],
speaker = [[Банда троллей]],
npc = "npc_troll",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_nachat_siyat = {
text = [[]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_ne_snimat = {
text = [[*Он смотрит в твои глаза, но ты не можешь разобрать какие эмоции он чувствует в данный момент.*]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Уходи и больше никогда не появляйся здесь.]],
next = "d_uhodi_i_bolshe_nikogda_ne_poyavlyajsya_zdes",
},
},
},
d_nemnogo_otojti = {
text = [[*Вооружённая фигура распахивает дверь и влетает в кабинет.*]],
speaker = [[Скул Шутер]],
npc = "npc_sniper",
choices = {
{
text = [[*Это скул шутер?!*]],
next = "d_eto_skul_shuter",
},
},
},
d_nu_pochemu_ya_to = {
text = [[]],
speaker = [[...]],
npc = "npc_gorilla",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_osmotretsya = {
text = [[*Странно, после выхода из подземного перехода, путь назад просто исчез.*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[Хммм...]],
next = "d_hmmm",
},
},
},
d_podojti_k_kripu = {
text = [[Ты здесь недавно, да? Знаешь, что там?]],
speaker = [[Крип-камыш]],
npc = "npc_rape_victim",
choices = {
{
text = [[Заброшенный лес.]],
next = "d_zabroshennyj_les",
},
},
},
d_podojti_poblizhe_i_prislushatsya = {
text = [[РАВНОЦЕННЫЙ ОБМЕН - ОСНОВА ЭТОГО МИРА.]],
speaker = [[???]],
npc = "npc_tormentor",
choices = {
{
text = [[Чего?]],
next = "d_chego",
},
},
},
d_podojti_poblizhe = {
text = [[Меня зовут Боб.]],
speaker = [[Боб]],
npc = "npc_creep_bob",
choices = {
{
text = [[А меня зову...]],
next = "d_a_menya_zovu",
},
},
},
d_pojdu_chtol_posmotru = {
text = [[*Преподователь продолжает что-то писать на доске. Ты по-тихому поднялся.*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_popravit_yajtsa = {
text = [[Человек, который твёрдо знает, чего он желает. Человек, который, несмотря на обстоятельства, делает то, что он хочет. Ты ещё более ценный чем я думала.]],
speaker = [[Старушка]],
npc = "npc_shamanka",
choices = {
{
text = [[*Протянуть руку.*]],
next = "d_protyanut_ruku",
},
},
},
d_potyanut_ruku_k_shtanam = {
text = [[*Женщина сначала удивилась, а после обрадовалась.*]],
speaker = [[Старушка]],
npc = "npc_shamanka",
choices = {
{
text = [[*Поправить яйца.*]],
next = "d_popravit_yajtsa",
},
},
},
d_predvestie_uzhe_sbylos = {
text = [[*Горилла замечает тебя. Огромная туша двигается тебе наствречу.*]],
speaker = [[...]],
npc = "npc_gorilla",
choices = {
{
text = [[*Ну почему я то?!*]],
next = nil,
actions = {
{ target="kill",npc="npc_gorilla",type="fight_start" },
{ type="gorilla_fight_start" },
{ npc="npc_rape_victim",type="kill" },
},
},
},
},
d_prigotovitsya = {
text = [[]],
speaker = [[Воин Эпштейна]],
npc = "npc_island_guard",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_prigrozit_kulakom = {
text = [[Оуу кей, братан. Ты воистину царь! Слава царю!]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[Какой дар преподнесёшь мне сегодня?]],
next = "d_kakoj_dar_prepodnesesh_mne_segodnya",
},
},
},
d_pridetsya_chtoto_pridumat = {
text = [[Надеюсь ты сможешь. Я люблю этот шар!]],
speaker = [[Крип Предвестник Апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_prinyat_vyzov = {
text = [[]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_prodolzhat_ne_dumat = {
text = [[*...*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[...]],
next = "d_o",
},
},
},
d_protyanut_ruku = {
text = [[Впервые такое вижу. Твоя душа кричит, виднеются десятки различных "сущностей", однако, наподобие сперматозоидам, многие из них погибают, не сумев достигнуть цели. Это твои желания, скрытые за десятками стен эмоций.]],
speaker = [[Старушка]],
npc = "npc_shamanka",
choices = {
{
text = [[Вау.]],
next = "d_vau",
},
},
},
d_razbit_bochku_pinkom = {
text = [[НЕЕЕЕТ, ЧТО ТЫ НАДЕЛАЛ?! ВСЁ ВЫЛИЛОСЬ. Я ТЕБЯ СЕЙЧАС...]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[Ты ж говорил, что она пустая.]],
next = "d_ty_zh_govoril_chto_ona_pustaya",
},
},
},
d_snyat_s_nego_mantiu = {
text = [[*Оттолкнув твою руку, он хватает дубину и ударяет себя по голове.*]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Что...]],
next = "d_chto",
},
},
},
d_ty_klanyaeshsya_v_otvet = {
text = [[*Послышался шум динамиков.*
Ты... Меня впечталил, конечно.]],
speaker = [[Эпштейн]],
npc = nil,
choices = {
{
text = [[Рад.]],
next = "d_rad",
},
},
},
d_udarit_lbom_emu_po_litsu = {
text = [[АРГХХ... Ты что делаешь сука, А?!]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[Моей мамы тут нет, она жива, чмо.]],
next = "d_j",
},
},
},
d_ujti = {
text = [[*Обе головы продолжают спорить.*]],
speaker = [[Крип-сиамский огр]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_uhmylnutsya_i_nachat_hlupat = {
text = [[ЧТО]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Начать щёлкать пальцами параллельно хлюпанью.*]],
next = "d_hlupsnap",
actions = {
{ music="hlup_snap",type="music_start" },
},
},
{
text = [[*Начать притоптывать в такт хлюпанья.*]],
next = "d_hlupstomp",
actions = {
{ music="hlup_stomp",type="music_start" },
},
},
},
},
d_hm = {
text = [[*Послышался чей-то крик.*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[*Пойду чтоль посмотрю.*]],
next = "d_pojdu_chtol_posmotru",
},
},
},
d_eto_skul_shuter = {
text = [[ЭЙ, БЕДОЛАГИ. СЕГОДНЯ Я НЕ В НАСТРОЕНИИ. КАК ДУМАЕТЕ, ВРЕМЯ ПОСТРЕЛЯТЬ?]],
speaker = [[Скул Шутер]],
npc = "npc_sniper",
choices = {
{
text = [[...]],
next = "d_o3",
},
},
},
d_ya_pochuvstvoval_priblizhenie_smerti_ya_tochno_umer_gde_ya = {
text = [[*Потрогав своё тело, ты убеждаешься, что в нём нет пулевых ранений.*]],
speaker = [[...]],
npc = "npc_tormentor",
choices = {
{
text = [[*Взять с пола камень.*]],
next = "d_vzyat_s_pola_kamen",
},
},
},
d_yarost = {
text = [[Я ПРИНИМАЮ ТВОЙ ВЫЗОВ.]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Принять вызов.*]],
next = nil,
actions = {
{ target="talk",npc="npc_red",type="fight_start" },
},
},
},
},
d_empty = {
text = [[Вообщем, ты их точно не пропустишь, у них очень выразительные цвета: Красный - злобный малый, Зелёный - твердолобый упырь, Синий - непредсказуемый болван.]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
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
d_14 = {
text = [[Как будто ты всё-таки старше.]],
speaker = [[???]],
npc = nil,
choices = {
{
text = [[Кстати, у тебя знакомый голос.]],
next = "d_kstati_u_tebya_znakomyj_golos",
},
},
},
d_20 = {
text = [[Очень грустно... Чтож, раз уж ты бесполезен, порадуй меня хотя бы шоу.]],
speaker = [[???]],
npc = nil,
choices = {
{
text = [[Кстати, у тебя знакомый голос.]],
next = "d_kstati_u_tebya_znakomyj_golos",
},
},
},
d_untitled_passage = {
text = [[*Перед твоим взором - покачивающаяся панда. Сильный запах алкоголя ударяет тебе в нос.*]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[Что пьёшь?]],
next = "d_chto_pesh",
},
},
},
d_untitled_passage_11 = {
text = [[НАПАДАЙ.]],
speaker = [[Воин Эпштейна]],
npc = "npc_island_guard",
choices = {
{
text = [[*Приготовиться*]],
next = nil,
actions = {
{ target="kill",type="fight_start" },
},
},
},
},
d_untitled_passage_12 = {
text = [[*Из ниоткуда явилось три зубастых существа.*]],
speaker = [[Банда троллей]],
npc = "npc_troll",
choices = {
{
text = [[Вы вообще что такое?]],
next = "d_vy_voobsche_chto_takoe",
},
},
},
d_untitled_passage_13 = {
text = [[*Перед тобой девушка необычайной красоты. Она помахивает тебе рукой.*]],
speaker = [[Человек-гид]],
npc = "npc_guide",
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
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_15 = {
text = [[*Открыв глаза, ты видишь лишь обожённую землю и постройку странной формы.*]],
speaker = [[...]],
npc = "npc_tormentor",
choices = {
{
text = [[*Я почувствовал приближение смерти. Я точно умер. Где я.*]],
next = "d_ya_pochuvstvoval_priblizhenie_smerti_ya_tochno_umer_gde_ya",
actions = {
{ npc="npc_shooter",type="remove" },
},
},
},
},
d_untitled_passage_16 = {
text = [[*Тишина.*]],
speaker = [[???]],
npc = "npc_tormentor",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_17 = {
text = [[Эй, чувак, здарова.]],
speaker = [[Крип-рогач]],
npc = "npc_creep_rogach",
choices = {
{
text = [[Здарова.]],
next = "d_zdarova",
},
},
},
d_untitled_passage_18 = {
text = [[Будь сильным, приятель.]],
speaker = [[Крип-рогач]],
npc = "npc_creep_rogach",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_19 = {
text = [[СТОЯЯЯЯЯЯЯТЬ!!]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[Чё ты кричишь?]],
next = "d_che_ty_krichish",
},
},
},
d_untitled_passage_2 = {
text = [[*Потерпев поражение, Красный остыл, на лице его родилось спокойствие.*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Ну как?]],
next = "d_nu_kak",
},
},
},
d_untitled_passage_20 = {
text = [[ВПЕРЁД КАЧАТЬСЯ! СЛАВА КОРОЛЮ!]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_21 = {
text = [[*Крип-головастик произносит слова, очень сильно напрягая голову.*]],
speaker = [[Боб]],
npc = "npc_creep_bob",
choices = {
{
text = [[*Подойти поближе.*]],
next = "d_podojti_poblizhe",
},
},
},
d_untitled_passage_22 = {
text = [[*Крип неподвижно стоит.*]],
speaker = [[Боб]],
npc = "npc_creep_bob",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_23 = {
text = [[Человек. Хочешь разбогатеть?]],
speaker = [[Синий Принц]],
npc = "npc_blue_prince",
choices = {
{
text = [[Смотря что предлагаешь.]],
next = "d_smotrya_chto_predlagaesh",
},
},
},
d_untitled_passage_24 = {
text = [[Врата. Проходи через них.]],
speaker = [[Синий Принц]],
npc = "npc_blue_prince",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_25 = {
text = [[Помочь Принцу. Ты готов?]],
speaker = [[Синий Принц]],
npc = "npc_blue_prince",
choices = {
{
text = [[Да.]],
next = "d_i9",
actions = {
{ questID="q_clash_royale",type="quest_start" },
},
},
{
text = [[Не хочу.]],
next = "d_ne_hochu",
},
},
},
d_untitled_passage_26 = {
text = [[*Услышав твои шаги, человек необычной внешности расправляет плечи и подходит к тебе вплотную.*]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[Ты человек или крип?]],
next = "d_ty_chelovek_ili_krip",
},
},
},
d_untitled_passage_27 = {
text = [[Л... Ладно. Немного перегнул, но мы в рассчёте, верно? Слава Королю!]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[Неа, теперь я твой царь.]],
next = "d_nea_teper_ya_tvoj_tsar",
},
},
},
d_untitled_passage_33 = {
text = [[Пс... Эй, ты. Подойди.]],
speaker = [[Крип-камыш]],
npc = "npc_rape_victim",
choices = {
{
text = [[*Подойти к крипу.*]],
next = "d_podojti_k_kripu",
},
},
},
d_untitled_passage_34 = {
text = [[Вали уже.]],
speaker = [[Крип-камыш]],
npc = "npc_rape_victim",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_40 = {
text = [[*Тебя заинтересовало необычное существо с двумя головами. Но, рассмотрев их лица, ты понял, что диалог будет не из простых.*]],
speaker = [[...]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Вы единое целое или две личности?]],
next = "d_vy_edinoe_tseloe_ili_dve_lichnosti",
},
},
},
d_untitled_passage_41 = {
text = [[Заброшенный...]],
speaker = [[Голова умнотуп]],
npc = "npc_ogre_magi",
choices = {
{
text = [[...]],
next = "d_les",
},
},
},
d_untitled_passage_42 = {
text = [[*Крип причудливой внешности излучает необычайное спокойствие.*]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Ты случайно не Огр-громила?]],
next = "d_ty_sluchajno_ne_ogrgromila",
},
},
},
d_untitled_passage_43 = {
text = [[*Огр-громила пал. Он лежит на земле и смотрит в небо. К нему пришло осознание, что это скорее всего последний раз, когда он может насладиться существованием.*]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[...]],
next = "d_m9",
},
},
},
d_untitled_passage_44 = {
text = [[1: Ооо, это же ты! Добрый человек-помощник.
2: Реально! Это та спичка!]],
speaker = [[Сиамский огр]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Мантии на интеллект не существует.]],
next = "d_mantii_na_intellekt_ne_suschestvuet",
},
},
},
d_untitled_passage_45 = {
text = [[*Ты не решаешься возвращаться к ним.*]],
speaker = [[...]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_46 = {
text = [[*Кажется тебя обманули, но ты продолжаешь верить. Кстати, кто такая цмка?*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[*Осмотреться.*]],
next = "d_osmotretsya",
},
},
},
d_untitled_passage_47 = {
text = [[Совсем не ожидал, что ты пройдёшь. Мои поздравления.]],
speaker = [[Эпштейн]],
npc = nil,
choices = {
{
text = [[Цмка где.]],
next = "d_tsmka_gde",
},
},
},
d_untitled_passage_48 = {
text = [[*Взгляда достаточно, чтобы понять, - это явно не цмка.*]],
speaker = [[Воин Эпштейна]],
npc = "npc_island_guard",
choices = {
{
text = [[Обидно.]],
next = "d_obidno",
},
},
},
d_untitled_passage_49 = {
text = [[*Ты используешь ключ и открываешь клетку.*]],
speaker = [[Крип-кот в бочке]],
npc = nil,
choices = {
{
text = [[Вы свободны, убегайте.]],
next = "d_vy_svobodny_ubegajte",
},
},
},
d_untitled_passage_59 = {
text = [[*Девушка с угрожающим видом останавливает тебя. Почему-то есть ощущение, что её руки пролили много крови.*]],
speaker = [[Человек-хранитель]],
npc = "npc_templar_assasin",
choices = {
{
text = [[Что-то не так?]],
next = "d_chtoto_ne_tak",
},
},
},
d_untitled_passage_60 = {
text = [[*Её не обмануть. Ты чувствуешь, что поединок тоже не вариант, у неё слишком сильная аура. Придётся реально найти кого-то.*]],
speaker = [[Человек-хранитель]],
npc = "npc_templar_assasin",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_61 = {
text = [[*Ты приветствуешь хранительницу.*]],
speaker = [[Человек-хранитель]],
npc = "npc_templar_assasin",
choices = {
{
text = [[Мне кажется я знаю пароль.]],
next = "d_mne_kazhetsya_ya_znau_parol",
},
},
},
d_untitled_passage_63 = {
text = [[Человек. Ты великий воин. Земли теперь полностью мои.]],
speaker = [[Синий Принц]],
npc = "npc_blue_prince",
choices = {
{
text = [[Круто, как там с наградой?]],
next = "d_kruto_kak_tam_s_nagradoj",
actions = {
{ questID="q_clash_royal",type="quest_end" },
},
},
},
},
d_untitled_passage_64 = {
text = [[Тебе что-то нужно, человек?
*Спросил крип с необычайно спокойным голосом.*]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Думаю нет.]],
next = "d_dumau_net",
},
},
},
d_untitled_passage_65 = {
text = [[Всё-таки поможешь нам?!]],
speaker = [[Сиамский огр]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Ладно ладно.]],
next = "d_ladno",
actions = {
{ questID="q_ogres",type="quest_start" },
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
speaker = [[Крип-Синий Принц]],
npc = "npc_blue_prince",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_67 = {
text = [[Не обращай на меня внимание. Иди дальше, давай.]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_68 = {
text = [[Похоже мы больше никогда не встретимся с ним...]],
speaker = [[Сиамский огр]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_69 = {
text = [[В себя поверил, А?!]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[Я готов.]],
next = "d_ya_gotov",
},
},
},
d_untitled_passage_70 = {
text = [[Мои владения. Потеряны...]],
speaker = [[Крип-Синий Принц]],
npc = "npc_blue_prince",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_71 = {
text = [[*Панда бубнит и пердит.*]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[Всё-таки помогу тебе.]],
next = "d_j10",
actions = {
{ questID="q_pandas",type="quest_start" },
},
},
{
text = [[Продолжай пить.]],
next = "d_j11",
},
},
},
d_untitled_passage_72 = {
text = [[*Обычный день в институте. Так ещё и лекция по тупому предмету.*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[*Да... скучновато.*]],
next = "d_da_skuchnovato",
},
},
},
d_untitled_passage_73 = {
text = [[*Подойдя к двери, ты слышишь приближающиеся шаги. Мурашки проходят по твоему телу.*]],
speaker = [[...]],
npc = "npc_sniper",
choices = {
{
text = [[*Немного отойти.*]],
next = "d_nemnogo_otojti",
actions = {
{ spawn="spawner_shooter_1",type="spawn" },
},
},
},
},
d_untitled_passage_74 = {
text = [[*Раздражённый крип перепрыгивает с ноги на ногу, ходя вокруг кучки сверкающих осколков.*]],
speaker = [[Раздраженный крип]],
npc = "npc_predvestnik",
choices = {
{
text = [[Не подскажешь, где найти предвестника?]],
next = "d_ne_podskazhesh_gde_najti_predvestnika",
},
},
},
d_untitled_passage_75 = {
text = [[Думаю тебе пригодятся молоток и гвозди.]],
speaker = [[Крип Предвестник Апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_76 = {
text = [[*Странное аморфное существо держит в руках переливающийся камень. Вокруг него разброссано много таких же камней, но треснутых.*]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[Что ты такое?]],
next = "d_chto_ty_takoe",
},
},
},
d_untitled_passage_77 = {
text = [[*Увлечённый работой человек копошиться в куче бумаг. На них ты замечаешь знакомые математические символы.*]],
speaker = [[Человек-учёный]],
npc = "npc_scientist",
choices = {
{
text = [[Оо, у вас тут математика?]],
next = "d_oo_u_vas_tut_matematika",
},
},
},
d_untitled_passage_78 = {
text = [[Я слежу за тобой.]],
speaker = [[Человек-хранитель]],
npc = "npc_templar_assasin",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_79 = {
text = [[Не мешай мне мешать!]],
speaker = [[Крип-алхимик]],
npc = "npc_alchemist",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_8 = {
text = [[Ступай.]],
speaker = [[Старушка]],
npc = "npc_shamanka",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_80 = {
text = [[Сейчас мы заняты, приходи позже.]],
speaker = [[Человек-учёный]],
npc = "npc_scientist",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_81 = {
text = [[*Накачанный крип очень громко пыхтит.*]],
speaker = [[Крип-вышибала]],
npc = "npc_concert_guard",
choices = {
{
text = [[Что тут за концерт?]],
next = "d_chto_tut_za_kontsert",
},
},
},
d_untitled_passage_82 = {
text = [[*Дальше ступать опасно. Есть большой шанс увязнуть в снегу.*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_untitled_passage_83 = {
text = [[*Приунывший предсказатель собирает с пола шишки.*]],
speaker = [[Крип-предвестник апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[Вот твой шар.]],
next = "d_vot_tvoj_shar",
actions = {
{ itemName="item_crystal_ball",type="take_item" },
},
},
},
},
d_untitled_passage_84 = {
text = [[*Это... Горилла.*]],
speaker = [[...]],
npc = "npc_gorilla",
choices = {
{
text = [[*Предвестие уже сбылось?*]],
next = "d_predvestie_uzhe_sbylos",
},
},
},
d_untitled_passage_85 = {
text = [[Я ПРИНИМАЮ ТВОЙ ВЫЗОВ.]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Начать сиять.*]],
next = nil,
actions = {
{ target="talk",npc="npc_red",type="fight_start" },
},
},
},
},
d_untitled_passage_86 = {
text = [[*Гид восторженно подбегает к тебе.*
Алекс! Ты наш спаситель, всё Королевство благодарит тебя за этот великий подвиг!]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Да это я.]],
next = "d_p12",
},
},
},
d_untitled_passage_9 = {
text = [[*Женщина со странной аурой начала тщательно тебя рассматривать.*]],
speaker = [[Старушка]],
npc = "npc_shamanka",
choices = {
{
text = [[Здрасте, не подскажете где я?]],
next = "d_zdraste_ne_podskazhete_gde_ya",
},
},
},
d_z_eto_camost_a_camost_eto_z = {
text = [[Теперь ты член этой Деревни. Если расскажешь кому-либо о нашей деятельности, я казню тебя без колебаний.]],
speaker = [[Человек-хранитель]],
npc = "npc_templar_assasin",
choices = {
{
text = [[Спасибо, верю.]],
next = "d_spasibo_veru",
},
},
},
d_z_eto_samost_a_samost_eto_z = {
text = [[Истина.]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[*Зачем я это сказал?*]],
next = "d_zachem_ya_eto_skazal",
},
},
},
d_a10 = {
text = [[ПОСЛУШАЙ МУДРОГО ДЯДЮ И ИДИ НАХУЙ.]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Он и вправду очень скучает по тебе, понимаешь?]],
next = "d_on_i_vpravdu_ochen_skuchaet_po_tebe_ponimaesh",
},
},
},
d_a2 = {
text = [[*Существо было удивлено, что ты решил с ним заговорить.*]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[...]],
next = "d_tak_chto",
},
},
},
d_a3 = {
text = [[С тех пор как они перестали следовать моим приказам, жизнь пошла по дну. Люди меня стороняться и обходят. Жена даже из дома выгнала, представляешь?]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[Расскажи о сыновьях.]],
next = "d_rasskazhi_o_synovyah",
},
},
},
d_a4 = {
text = [[Я думал люди только и могут кричать о величии их Пропавшего Короля. Сидят на жопе и ничего кроме этого не делают. Неужто ты мне поможешь?]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[Ты первый крип, что упомянул Короля. Что тебе о нём известно?]],
next = "d_ty_pervyj_krip_chto_upomyanul_korolya_chto_tebe_o_nem_izvestno",
},
},
},
d_g = {
text = [[Мы самые кровожадные воры Заброшенного леса: Урюк, Дирюк и Бе...]],
speaker = [[Банда троллей]],
npc = "npc_troll",
choices = {
{
text = [[Не не, мне не важно кто вы, я спрашивал, что за раса у вас.]],
next = "d_ne_ne_mne_ne_vazhno_kto_vy_ya_sprashival_chto_za_rasa_u_vas",
},
},
},
d_grape_vortex = {
text = [[]],
speaker = [[default]],
npc = nil,
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_h = {
text = [[Я - гид этого Королевства. Все прибывшие в первую очередь встречаются со мной.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Ты знаешь как я сюда попал?]],
next = "d_ty_znaesh_kak_ya_suda_popal",
},
},
},
d_h10 = {
text = [[Прекрасное имя.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Да.]],
next = "d_da__1",
},
},
},
d_h2 = {
text = [[Нет, наши души где-то в промежутке.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[То есть я не смогу вернуться?]],
next = "d_to_est_ya_ne_smogu_vernutsya",
},
},
},
d_h3 = {
text = [[Я удивлена, что ты дошёл до сюда. Обычно на всех новоприбывших нападают крипы у ворот.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Я убил их.]],
next = "d_ya_ubil_ih",
},
},
},
d_h4 = {
text = [[На востоке - Пустошь. Ступившего в них ожидает только смерть...]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[*Далее.*]],
next = "d_h5",
},
},
},
d_h5 = {
text = [[На севере - Система подземных путей М.Е.Т.Р.О. (Межрассовая Единая Тоннельно-Рельсовая Объединённая система), ведущих на территории, где поселились "новые" люди.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [["Новые" люди?]],
next = "d_novye_ludi",
},
},
},
d_h6 = {
text = [[Чтож, пора рассказать о нашем Королевстве, я же всё-таки гид. Что тебе интересно?]],
speaker = [[Человек-гид]],
npc = "npc_guide",
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
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_h8 = {
text = [[На юго-западе - Владения двух Каменных Принцов. Они никак не могут поделить свои земли.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[*Далее.*]],
next = "d_h4",
},
},
},
d_hlupsnap = {
text = [[*Лицо Красного замерло в ужасной гримасе. Он оскорблён, но при этом его разум не способен осознать и постчиь истинного замысла за твоими последними действиями.*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Значительно повысить темп хлюпанья.*]],
next = "d_hlupsnaptempo",
actions = {
{ music="hlup_snap_tempo",type="music_start" },
},
},
{
text = [[*Делать акцент на каждое четвёртое хлюпанье.*]],
next = "d_hlupsnapaccent",
actions = {
{ music="hlup_snap_accent",type="music_start" },
},
},
},
},
d_hlupsnapaccent = {
text = [[*Красный настолько был ошарашен происходящим, что никак не мог понять, какой должна быть его реакция. Осознание того, что он не может постичь действий другого, а тем более себя, начало подпитывать страшный гнев в его теле.*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Начать делать lip trill, дабы добавить устойчивую басовую основу.*]],
next = "d_hlupsnapaccentbass",
actions = {
{ music="hlup_snap_accent_bass",type="music_start" },
},
},
{
text = [[*Начинать подпискивать, дабы расширить диапозон между низкими и высокими частотами.*]],
next = "d_hlupsnapaccentvox",
actions = {
{ music="hlup_snap_accent_vox",type="music_start" },
},
},
},
},
d_hlupsnapaccentbass = {
text = [[*Наступает момент кульминации. Лицо Красного уже залилось алым градиентом, вот вот его терпение лопнет и он пойдёт в твою сторону. Однако останавливаться сейчас нельзя, толпа прохожих внимательно следит за твоими движениями. Пришло время поставить точку...*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Сыграть рифф на ширинке с разрешением в тонику.*]],
next = "d_hlupsnapaccentbassriff",
actions = {
{ music="hlup_snap_accent_bass_riff",type="music_start" },
},
},
{
text = [[*Отбить ботинками завершающую каденцию.*]],
next = "d_hlupsnapaccentbasscad",
actions = {
{ music="hlup_snap_accent_bass_cad",type="music_start" },
},
},
},
},
d_hlupsnapaccentbasscad = {
text = [[*Все замерли. От сильнейшего топтания твои ботинки покрылись чёрной пеленой, но ты этого даже не заметил, ведь взор твой был устремлён в небеса. В результате страстных движений, земля была окрашена тёмными узорами невиданной красоты."]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Словно иглы, мои ботинки вышили эти орнаменты для вас, земляне.]],
next = "d_slovno_igly_moi_botinki_vyshili_eti_ornamenty_dlya_vas_zemlyane",
actions = {
{ type="music_stop" },
},
},
},
},
d_hlupsnapaccentbassriff = {
text = [[*Все замерли. Лишь эхом отдаётся последняя нота. В это соло была вложена вся душа, что ты и не заметил, как замок отлетел. Словно медиатор, он лежит между указательным и большим пальцами. Ширинку больше, увы, не застегнуть.]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[С этого момента цепи конуры более не смогут сдержать моего бульдога. Ты свободен.]],
next = "d_s_etogo_momenta_tsepi_konury_bolee_ne_smogut_sderzhat_moego_buldoga_ty_svoboden",
actions = {
{ type="music_stop" },
},
},
},
},
d_hlupsnapaccentvox = {
text = [[*Наступает момент кульминации. Лицо Красного уже залилось алым градиентом, вот вот его терпение лопнет и он пойдёт в твою сторону. Однако останавливаться сейчас нельзя, толпа прохожих внимательно следит за твоими движениями. Пришло время поставить точку...*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Сыграть рифф на ширинке с разрешением в тонику.*]],
next = "d_hlupsnapaccentvoxriff",
actions = {
{ music="hlup_snap_accent_vox_riff",type="music_start" },
},
},
{
text = [[*Отбить ботинками завершающую каденцию.*]],
next = "d_hlupsnapaccentvoxcad",
actions = {
{ music="hlup_snap_accent_vox_cad",type="music_start" },
},
},
},
},
d_hlupsnapaccentvoxcad = {
text = [[*Все замерли. От сильнейшего топтания твои ботинки покрылись чёрной пеленой, но ты этого даже не заметил, ведь взор твой был устремлён в небеса. В результате страстных движений, земля была окрашена тёмными узорами невиданной красоты."]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Словно иглы, мои ботинки вышили эти орнаменты для вас, земляне.]],
next = "d_slovno_igly_moi_botinki_vyshili_eti_ornamenty_dlya_vas_zemlyane",
actions = {
{ type="music_stop" },
},
},
},
},
d_hlupsnapaccentvoxriff = {
text = [[*Все замерли. Лишь эхом отдаётся последняя нота. В это соло была вложена вся душа, что ты и не заметил, как замок отлетел. Словно медиатор, он лежит между указательным и большим пальцами. Ширинку больше, увы, не застегнуть.]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[С этого момента цепи конуры более не смогут сдержать моего бульдога. Ты свободен.]],
next = "d_s_etogo_momenta_tsepi_konury_bolee_ne_smogut_sderzhat_moego_buldoga_ty_svoboden",
actions = {
{ type="music_stop" },
},
},
},
},
d_hlupsnaptempo = {
text = [[*Красный настолько был ошарашен происходящим, что никак не мог понять, какой должна быть его реакция. Осознание того, что он не может постичь действий другого, а тем более себя, начало подпитывать страшный гнев в его теле.*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Начать делать lip trill, дабы добавить устойчивую басовую основу.*]],
next = "d_hlupsnaptempobass",
actions = {
{ music="hlup_snap_tempo_bass",type="music_start" },
},
},
{
text = [[*Начинать подпискивать, дабы расширить диапозон между низкими и высокими частотами.*]],
next = "d_hlupsnaptempovox",
actions = {
{ music="hlup_snap_tempo_vox",type="music_start" },
},
},
},
},
d_hlupsnaptempobass = {
text = [[*Наступает момент кульминации. Лицо Красного уже залилось алым градиентом, вот вот его терпение лопнет и он пойдёт в твою сторону. Однако останавливаться сейчас нельзя, толпа прохожих внимательно следит за твоими движениями. Пришло время поставить точку...*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Сыграть рифф на ширинке с разрешением в тонику.*]],
next = "d_hlupsnaptempobassriff",
actions = {
{ music="hlup_snap_tempo_bass_riff",type="music_start" },
},
},
{
text = [[*Отбить ботинками завершающую каденцию.*]],
next = "d_hlupsnaptempobasscad",
actions = {
{ music="hlup_snap_tempo_bass_cad",type="music_start" },
},
},
},
},
d_hlupsnaptempobasscad = {
text = [[*Все замерли. От сильнейшего топтания твои ботинки покрылись чёрной пеленой, но ты этого даже не заметил, ведь взор твой был устремлён в небеса. В результате страстных движений, земля была окрашена тёмными узорами невиданной красоты."]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Словно иглы, мои ботинки вышили эти орнаменты для вас, земляне.]],
next = "d_slovno_igly_moi_botinki_vyshili_eti_ornamenty_dlya_vas_zemlyane",
actions = {
{ type="music_stop" },
},
},
},
},
d_hlupsnaptempobassriff = {
text = [[*Все замерли. Лишь эхом отдаётся последняя нота. В это соло была вложена вся душа, что ты и не заметил, как замок отлетел. Словно медиатор, он лежит между указательным и большим пальцами. Ширинку больше, увы, не застегнуть.]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[С этого момента цепи конуры более не смогут сдержать моего бульдога. Ты свободен.]],
next = "d_s_etogo_momenta_tsepi_konury_bolee_ne_smogut_sderzhat_moego_buldoga_ty_svoboden",
actions = {
{ type="music_stop" },
},
},
},
},
d_hlupsnaptempovox = {
text = [[*Наступает момент кульминации. Лицо Красного уже залилось алым градиентом, вот вот его терпение лопнет и он пойдёт в твою сторону. Однако останавливаться сейчас нельзя, толпа прохожих внимательно следит за твоими движениями. Пришло время поставить точку...*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Сыграть рифф на ширинке с разрешением в тонику.*]],
next = "d_hlupsnaptempovoxriff",
actions = {
{ music="hlup_snap_tempo_vox_riff",type="music_start" },
},
},
{
text = [[*Отбить ботинками завершающую каденцию.*]],
next = "d_hlupsnaptempovoxcad",
actions = {
{ music="hlup_snap_tempo_vox_cad",type="music_start" },
},
},
},
},
d_hlupsnaptempovoxcad = {
text = [[*Все замерли. От сильнейшего топтания твои ботинки покрылись чёрной пеленой, но ты этого даже не заметил, ведь взор твой был устремлён в небеса. В результате страстных движений, земля была окрашена тёмными узорами невиданной красоты."]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Словно иглы, мои ботинки вышили эти орнаменты для вас, земляне.]],
next = "d_slovno_igly_moi_botinki_vyshili_eti_ornamenty_dlya_vas_zemlyane",
actions = {
{ type="music_stop" },
},
},
},
},
d_hlupsnaptempovoxriff = {
text = [[*Все замерли. Лишь эхом отдаётся последняя нота. В это соло была вложена вся душа, что ты и не заметил, как замок отлетел. Словно медиатор, он лежит между указательным и большим пальцами. Ширинку больше, увы, не застегнуть.]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[С этого момента цепи конуры более не смогут сдержать моего бульдога. Ты свободен.]],
next = "d_s_etogo_momenta_tsepi_konury_bolee_ne_smogut_sderzhat_moego_buldoga_ty_svoboden",
actions = {
{ type="music_stop" },
},
},
},
},
d_hlupstomp = {
text = [[*Лицо Красного замерло в ужасной гримасе. Он оскорблён, но при этом его разум не способен осознать и постчиь истинного замысла за твоими последними действиями.*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Значительно повысить темп хлюпанья.*]],
next = "d_hlupstomptempo",
actions = {
{ music="hlup_stomp_tempo",type="music_start" },
},
},
{
text = [[*Делать акцент на каждое четвёртое хлюпанье.*]],
next = "d_hlupstompaccent",
actions = {
{ music="hlup_stomp_accent",type="music_start" },
},
},
},
},
d_hlupstompaccent = {
text = [[*Красный настолько был ошарашен происходящим, что никак не мог понять, какой должна быть его реакция. Осознание того, что он не может постичь действий другого, а тем более себя, начало подпитывать страшный гнев в его теле.*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Начать делать lip trill, дабы добавить устойчивую басовую основу.*]],
next = "d_hlupstompaccentbass",
actions = {
{ music="hlup_stomp_accent_bass",type="music_start" },
},
},
{
text = [[*Начинать подпискивать, дабы расширить диапозон между низкими и высокими частотами.*]],
next = "d_hlupstompaccentvox",
actions = {
{ music="hlup_stomp_accent_vox",type="music_start" },
},
},
},
},
d_hlupstompaccentbass = {
text = [[*Наступает момент кульминации. Лицо Красного уже залилось алым градиентом, вот вот его терпение лопнет и он пойдёт в твою сторону. Однако останавливаться сейчас нельзя, толпа прохожих внимательно следит за твоими движениями. Пришло время поставить точку...*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Сыграть рифф на ширинке с разрешением в тонику.*]],
next = "d_hlupstompaccentbassriff",
actions = {
{ music="hlup_stomp_accent_bass_riff",type="music_start" },
},
},
{
text = [[*Отбить ботинками завершающую каденцию.*]],
next = "d_hlupstompaccentbasscad",
actions = {
{ music="hlup_stomp_accent_bass_cad",type="music_start" },
},
},
},
},
d_hlupstompaccentbasscad = {
text = [[*Все замерли. От сильнейшего топтания твои ботинки покрылись чёрной пеленой, но ты этого даже не заметил, ведь взор твой был устремлён в небеса. В результате страстных движений, земля была окрашена тёмными узорами невиданной красоты."]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Словно иглы, мои ботинки вышили эти орнаменты для вас, земляне.]],
next = "d_slovno_igly_moi_botinki_vyshili_eti_ornamenty_dlya_vas_zemlyane",
actions = {
{ type="music_stop" },
},
},
},
},
d_hlupstompaccentbassriff = {
text = [[*Все замерли. Лишь эхом отдаётся последняя нота. В это соло была вложена вся душа, что ты и не заметил, как замок отлетел. Словно медиатор, он лежит между указательным и большим пальцами. Ширинку больше, увы, не застегнуть.]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[С этого момента цепи конуры более не смогут сдержать моего бульдога. Ты свободен.]],
next = "d_s_etogo_momenta_tsepi_konury_bolee_ne_smogut_sderzhat_moego_buldoga_ty_svoboden",
actions = {
{ type="music_stop" },
},
},
},
},
d_hlupstompaccentvox = {
text = [[*Наступает момент кульминации. Лицо Красного уже залилось алым градиентом, вот вот его терпение лопнет и он пойдёт в твою сторону. Однако останавливаться сейчас нельзя, толпа прохожих внимательно следит за твоими движениями. Пришло время поставить точку...*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Сыграть рифф на ширинке с разрешением в тонику.*]],
next = "d_hlupstompaccentvoxriff",
actions = {
{ music="hlup_stomp_accent_vox_riff",type="music_start" },
},
},
{
text = [[*Отбить ботинками завершающую каденцию.*]],
next = "d_hlupstompaccentvoxcad",
actions = {
{ music="hlup_stomp_accent_vox_cad",type="music_start" },
},
},
},
},
d_hlupstompaccentvoxcad = {
text = [[*Все замерли. От сильнейшего топтания твои ботинки покрылись чёрной пеленой, но ты этого даже не заметил, ведь взор твой был устремлён в небеса. В результате страстных движений, земля была окрашена тёмными узорами невиданной красоты."]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Словно иглы, мои ботинки вышили эти орнаменты для вас, земляне.]],
next = "d_slovno_igly_moi_botinki_vyshili_eti_ornamenty_dlya_vas_zemlyane",
actions = {
{ type="music_stop" },
},
},
},
},
d_hlupstompaccentvoxriff = {
text = [[*Все замерли. Лишь эхом отдаётся последняя нота. В это соло была вложена вся душа, что ты и не заметил, как замок отлетел. Словно медиатор, он лежит между указательным и большим пальцами. Ширинку больше, увы, не застегнуть.]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[С этого момента цепи конуры более не смогут сдержать моего бульдога. Ты свободен.]],
next = "d_s_etogo_momenta_tsepi_konury_bolee_ne_smogut_sderzhat_moego_buldoga_ty_svoboden",
actions = {
{ type="music_stop" },
},
},
},
},
d_hlupstomptempo = {
text = [[*Красный настолько был ошарашен происходящим, что никак не мог понять, какой должна быть его реакция. Осознание того, что он не может постичь действий другого, а тем более себя, начало подпитывать страшный гнев в его теле.*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Начать делать lip trill, дабы добавить устойчивую басовую основу.*]],
next = "d_hlupstomptempobass",
actions = {
{ music="hlup_stomp_tempo_bass",type="music_start" },
},
},
{
text = [[*Начинать подпискивать, дабы расширить диапозон между низкими и высокими частотами.*]],
next = "d_hlupstomptempovox",
actions = {
{ music="hlup_stomp_tempo_vox",type="music_start" },
},
},
},
},
d_hlupstomptempobass = {
text = [[*Наступает момент кульминации. Лицо Красного уже залилось алым градиентом, вот вот его терпение лопнет и он пойдёт в твою сторону. Однако останавливаться сейчас нельзя, толпа прохожих внимательно следит за твоими движениями. Пришло время поставить точку...*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Сыграть рифф на ширинке с разрешением в тонику.*]],
next = "d_hlupstomptempobassriff",
actions = {
{ music="hlup_stomp_tempo_bass_riff",type="music_start" },
},
},
{
text = [[*Отбить ботинками завершающую каденцию.*]],
next = "d_hlupstomptempobasscad",
actions = {
{ music="hlup_stomp_tempo_bass_cad",type="music_start" },
},
},
},
},
d_hlupstomptempobasscad = {
text = [[*Все замерли. От сильнейшего топтания твои ботинки покрылись чёрной пеленой, но ты этого даже не заметил, ведь взор твой был устремлён в небеса. В результате страстных движений, земля была окрашена тёмными узорами невиданной красоты."]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Словно иглы, мои ботинки вышили эти орнаменты для вас, земляне.]],
next = "d_slovno_igly_moi_botinki_vyshili_eti_ornamenty_dlya_vas_zemlyane",
actions = {
{ type="music_stop" },
},
},
},
},
d_hlupstomptempobassriff = {
text = [[*Все замерли. Лишь эхом отдаётся последняя нота. В это соло была вложена вся душа, что ты и не заметил, как замок отлетел. Словно медиатор, он лежит между указательным и большим пальцами. Ширинку больше, увы, не застегнуть.]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[С этого момента цепи конуры более не смогут сдержать моего бульдога. Ты свободен.]],
next = "d_s_etogo_momenta_tsepi_konury_bolee_ne_smogut_sderzhat_moego_buldoga_ty_svoboden",
actions = {
{ type="music_stop" },
},
},
},
},
d_hlupstomptempovox = {
text = [[*Наступает момент кульминации. Лицо Красного уже залилось алым градиентом, вот вот его терпение лопнет и он пойдёт в твою сторону. Однако останавливаться сейчас нельзя, толпа прохожих внимательно следит за твоими движениями. Пришло время поставить точку...*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Сыграть рифф на ширинке с разрешением в тонику.*]],
next = "d_hlupstomptempovoxriff",
actions = {
{ music="hlup_stomp_tempo_vox_riff",type="music_start" },
},
},
{
text = [[*Отбить ботинками завершающую каденцию.*]],
next = "d_hlupstomptempovoxcad",
actions = {
{ music="hlup_stomp_tempo_vox_cad",type="music_start" },
},
},
},
},
d_hlupstomptempovoxcad = {
text = [[*Все замерли. От сильнейшего топтания твои ботинки покрылись чёрной пеленой, но ты этого даже не заметил, ведь взор твой был устремлён в небеса. В результате страстных движений, земля была окрашена тёмными узорами невиданной красоты."]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Словно иглы, мои ботинки вышили эти орнаменты для вас, земляне.]],
next = "d_slovno_igly_moi_botinki_vyshili_eti_ornamenty_dlya_vas_zemlyane",
actions = {
{ type="music_stop" },
},
},
},
},
d_hlupstomptempovoxriff = {
text = [[*Все замерли. Лишь эхом отдаётся последняя нота. В это соло была вложена вся душа, что ты и не заметил, как замок отлетел. Словно медиатор, он лежит между указательным и большим пальцами. Ширинку больше, увы, не застегнуть.]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[С этого момента цепи конуры более не смогут сдержать моего бульдога. Ты свободен.]],
next = "d_s_etogo_momenta_tsepi_konury_bolee_ne_smogut_sderzhat_moego_buldoga_ty_svoboden",
actions = {
{ type="music_stop" },
},
},
},
},
d_i = {
text = [[Вообщем хорошего дня тебе, друг. В нашем Королестве всегда весело.]],
speaker = [[Крип-рогач]],
npc = "npc_creep_rogach",
choices = {
{
text = [[И тебе хорошего.]],
next = "d_i_tebe_horoshego",
},
},
},
d_i2 = {
text = [[Зверь Пустоши меня просто в землю втопчет... Нет ни одного существа, кто ему ровня. Радует, что он не нападает, а только обороняется...]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[Тогда зачем с ним связываться?]],
next = "d_togda_zachem_s_nim_svyazyvatsya",
},
},
},
d_i3 = {
text = [[Как думаешь, почему людей так мало?]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[Ну... может разъехались.]],
next = "d_nu_mozhet_razehalis",
},
},
},
d_i4 = {
text = [[*После этих слов, усач резко изменился. Вся задорность исчезла. Остался только его глубокий голос.*]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[Что это за взгляд?]],
next = "d_i5",
},
},
},
d_i5 = {
text = [[Ты умрёшь, уходи.]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[Чего усатый?]],
next = "d_chego_usatyj",
},
},
},
d_i6 = {
text = [[Меня зовут Боб!]],
speaker = [[Боб]],
npc = "npc_creep_bob",
choices = {
{
text = [[Помощь нужна?]],
next = "d_pomosch_nuzhna",
},
},
},
d_i7 = {
text = [[Как меня зовут?!]],
speaker = [[Боб]],
npc = "npc_creep_bob",
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
speaker = [[Боб]],
npc = "npc_creep_bob",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_i9 = {
text = [[Отлично. Проходи.]],
speaker = [[Синий Принц]],
npc = "npc_blue_prince",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_j = {
text = [[Выходи один на один, уёбок.]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[Начнём дуэль.]],
next = nil,
actions = {
{ target="talk",npc="npc_monkey_king",type="fight_start" },
},
},
},
},
d_j10 = {
text = [[Постарайся уж, а то пока я не смогу их контролировать, жена меня домой не пустит.]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[Базар.]],
next = nil,
actions = {
{ npc="npc_brewmaster",type="remove" },
{ spawn="spawner_red",type="spawn" },
{ spawn="spawner_green",type="spawn" },
},
},
},
},
d_j11 = {
text = [[Ты такой же человек как и все остальные...]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_l10 = {
text = [[И тот дракон харкнул в брата огнём. Я почуял опасность, потому плюнул в огненный шар и потушил его! Так он и спасся.]],
speaker = [[Голова подначка]],
npc = "npc_ogre_magi",
choices = {
{
text = [[...]],
next = "d_l11",
},
},
},
d_l11 = {
text = [[Вообще-то это я его спас, оттащив брата за дубину, которой он замахивался. Из-за меня дракон промахнулся!]],
speaker = [[Голова умнотуп]],
npc = "npc_ogre_magi",
choices = {
{
text = [[...]],
next = "d_l12",
},
},
},
d_l12 = {
text = [[Никто не поверит в твои бредни, ты тот ещё пень!]],
speaker = [[Голова подначка]],
npc = "npc_ogre_magi",
choices = {
{
text = [[...]],
next = "d_ya_voobsche_ne_pomnu",
},
},
},
d_l13 = {
text = [[Брат сказал, что сделает нас умнее. Он отправился искать Мантию на интеллект.]],
speaker = [[Голова умнотуп]],
npc = "npc_ogre_magi",
choices = {
{
text = [[...]],
next = "d_hotya_kuda",
},
},
},
d_l14 = {
text = [[2: Похоже Мантию стоит отдать тебе!!
1: Хорошо ты его!]],
speaker = [[Сиамский огр]],
npc = "npc_ogre_magi",
choices = {
{
text = [[*Я что, реально тупее их?*]],
next = "d_l15",
},
},
},
d_l15 = {
text = [[Когда найдёшь его - скажи, чтоб шёл домой!]],
speaker = [[Голова умнотуп]],
npc = "npc_ogre_magi",
choices = {
{
text = [[...]],
next = "d_i_mantiu",
},
},
},
d_l5 = {
text = [[*2-ая голова начала говорить пискляво и резко.*
А колёса твои где? Хихи хи. Неужто уже зима, на лыжи пересел?]],
speaker = [[Голова подначка]],
npc = "npc_ogre_magi",
choices = {
{
text = [[...]],
next = "d_l6",
},
},
},
d_l6 = {
text = [[Как по твоему я поставлю лыжи на коня. Ты вообще не понимаешь чтоли..? У них копыта.]],
speaker = [[Голова умнотуп]],
npc = "npc_ogre_magi",
choices = {
{
text = [[...]],
next = "d_l7",
},
},
},
d_l7 = {
text = [[Никак! Сейчас же лето. Воооо! Я бы налепил на них ролики!]],
speaker = [[Голова подначка]],
npc = "npc_ogre_magi",
choices = {
{
text = [[...]],
next = "d_l8",
},
},
},
d_l8 = {
text = [[На кого?]],
speaker = [[Голова умнотуп]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Эх...]],
next = "d_eh",
},
},
},
d_l9 = {
text = [[Хиихи хих. Не может быть! После встречи с гидом он стал мокреньким, так мы его только согреем!]],
speaker = [[Голова подначка]],
npc = "npc_ogre_magi",
choices = {
{
text = [[В принципе я понял, вы два даунича.]],
next = "d_v_printsipe_ya_ponyal_vy_dva_daunicha",
},
},
},
d_m = {
text = [[Я не могу снять её.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Причина?]],
next = "d_prichina",
},
},
},
d_m1 = {
text = [[До Мантии, моя жизнь была примитивной и бессмысленной, сейчас же полна новых открытий и откровений.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Ты ведь обещал отдать Мантию им.]],
next = "d_ty_ved_obeschal_otdat_mantiu_im",
},
},
},
d_m2 = {
text = [[Моя позиция тверда, ничто не изменит её. Уходи.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Тебе всегда было плевать на них.]],
next = "d_o6",
},
{
text = [[Знаешь... Мне грустно смотреть на тебя.]],
next = "d_o6",
},
},
},
d_m3 = {
text = [[Не нравится мне убивать. Это глупо, тем более ты хороший человек.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Мне тоже, однако выбора нет.]],
next = "d_mne_tozhe_odnako_vybora_net",
},
},
},
d_m4 = {
text = [[*Огр хватает твою руку.*
Сорвав её, я умру, ты ведь это понимаешь?]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Нет. Я оставлю тебя в живых.]],
next = "d_net_ya_ostavlu_tebya_v_zhivyh",
},
},
},
d_m5 = {
text = [[*Несколько минут ты смотришь на его труп. В мылсях мелькают фразы из вашего диалога. Ты не решаешься взять мантию.*]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_m6 = {
text = [[*Он отправился жить. Ты уверен, это его последний день в этих землях.*]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_m7 = {
text = [[Так и где этот болван?!]],
speaker = [[Голова подначка]],
npc = "npc_ogre_magi",
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
speaker = [[Крип-сиамский огр]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_m9 = {
text = [[Ты победил в честном поединке.
*Сказано это было очень спокойно и уверенно. Он ждёт твоих действий.*]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Почему ты не пытаешься сбежать?]],
next = "d_pochemu_ty_ne_pytaeshsya_sbezhat",
},
},
},
d_n = {
text = [[Чудненькое имя. А сколько тебе лет?]],
speaker = [[???]],
npc = nil,
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
speaker = [[Эпштейн]],
npc = nil,
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_n9 = {
text = [[Однако, если тебя признают, то выдадут кодовую фразу. Произнеси её и я позволю тебе пройти.]],
speaker = [[Человек-хранитель]],
npc = "npc_templar_assasin",
choices = {
{
text = [[Хмм...]],
next = "d_hmm",
},
},
},
d_o = {
text = [[*...*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[...]],
next = "d_o1",
},
},
},
d_o1 = {
text = [[*Вдруг в коридоре послышался едва заметный хлопок. Взрыв? Выстрел?*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[*Хм?*]],
next = "d_hm",
},
},
},
d_o10 = {
text = [[Тогда почему она есть у нас?]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[Чтобы выжить.]],
next = "d_o11",
},
{
text = [[Чтобы предстать перед Судом.]],
next = "d_o11",
},
},
},
d_o11 = {
text = [[*Существо протянуло руку.*]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[Хм?]],
next = "d_hm__2",
},
},
},
d_o12 = {
text = [[Тогда почему Бог позволил сделать это?]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[Он справедлив.]],
next = "d_o11",
},
{
text = [[Мы - его часть.]],
next = "d_o11",
},
},
},
d_o13 = {
text = [[Тогда какой смысл науки?]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[Познать мир.]],
next = "d_o11",
},
{
text = [[Я люблю решать математику.]],
next = "d_o11",
},
},
},
d_o2 = {
text = [[*А почему морковь - это овощ, если она сладкая?*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[*Потому что она твёрдая?*]],
next = "d_o1",
},
{
text = [[*Потому что она растёт под землёй?*]],
next = "d_o1",
},
},
},
d_o3 = {
text = [[ЭЙ, ТЫ, НОСАТЫЙ. ДАВАЙ СРАЗИМСЯ. ЕСЛИ ДРАКА БУДЕТ СКУЧНОЙ, ТО Я РАССТРЕЛЯЮ ВСЕХ ЗДЕСЬ, ПОНЯЛ? ПОГНАЛИ!]],
speaker = [[Скул Шутер]],
npc = "npc_sniper",
choices = {
{
text = [[Ч.. что?]],
next = nil,
actions = {
{ target="kill",npc="npc_shooter",type="fight_start" },
},
},
},
},
d_o4 = {
text = [[И потому тот город опустел и со временем превратился в Пустошь. Все, кто там проживают - последователи Короля, однако им не выпал шанс хотя бы увидеть его. Страшная судьба...]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[Стоп, а как они ладят с Зверем?]],
next = "d_stop_a_kak_oni_ladyat_s_zverem",
},
},
},
d_o5 = {
text = [[Как вообще я могу быть счастливым, пока они такие не послушные? Это не жизнь. Приходится запивать горе своё. Пока они не воссоединяться, не смогу найти себе места.]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[...]],
next = "d_a3",
},
},
},
d_o6 = {
text = [[Оставь слова при себе.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Ты же понимаешь, что я не уйду?]],
next = "d_ty_zhe_ponimaesh_chto_ya_ne_ujdu",
},
},
},
d_o7 = {
text = [[А?! Ты ещё здесь? Вообщем есть неурядица. Приходили крипочки-хулиганы и начали играть в футбол моим драгоценным шаром! Они разбили его!]],
speaker = [[Крип Предвестник Апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[Сожалею.]],
next = "d_sozhaleu",
},
{
text = [[Я б так же сделал.]],
next = "d_ya_b_tak_zhe_sdelal",
},
},
},
d_o8 = {
text = [[Хмм... ничем. А. Нет! Сквозь него я могу видеть испытания уготовленные нам, смертным! Ты.. наверное видел кратер в лесу, да?]],
speaker = [[Крип Предвестник Апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[Да, большая яма.]],
next = "d_da_bolshaya_yama",
},
},
},
d_o9 = {
text = [[Тогда зачем ему наказывать верных и спасать грешников?]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[Незачем.]],
next = "d_o11",
},
{
text = [[Пути Господни неисповедимы.]],
next = "d_o11",
},
},
},
d_p = {
text = [[Вместе с коллегой мы узнали.. Да! Алхимия существует! Спустя кучу тестов и опытов стало известно, что здесь главенствует правило Равноценного обмена!]],
speaker = [[Человек-учёный]],
npc = "npc_scientist",
choices = {
{
text = [[Это как?]],
next = "d_eto_kak",
},
},
},
d_p1 = {
text = [[Допустим, мне нужна бумага, но у меня есть только вода и кусок древесины. С помощью алхимии я могу в один момент переделать эти материалы в полноценную бумагу, ведь она как раз-таки и состоит из воды и опилок. Вот так!]],
speaker = [[Человек-учёный]],
npc = "npc_scientist",
choices = {
{
text = [[Что значит "в один момент"? Как это вообще происходит?]],
next = "d_chto_znachit_v_odin_moment_kak_eto_voobsche_proishodit",
},
},
},
d_p10 = {
text = [[ДА..  ДА..    ДАРОВАНА..                          ЖИЗНЬ.]],
speaker = [[Крип-предвестник апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[...]],
next = "d_p11",
},
},
},
d_p11 = {
text = [[*Предвестник падает в обморок.*]],
speaker = [[Крип-предвестник апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[И как мне на это реагировать?]],
next = "d_i_kak_mne_na_eto_reagirovat",
},
},
},
d_p12 = {
text = [[Вот возьми. Это, конечно, не сравнится с величиной твоего подвига, но я обязана тебя отблагодарить.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Спасибо типо.]],
next = "d_spasibo_tipo",
actions = {
{ questID="q_main_quest_1",type="quest_end" },
},
},
},
},
d_p13 = {
text = [[И ещё. Приходил один странный крип, загадочный. Он просил передать, чтобы ты встретился с ним. Он ожидает тебя в Королевстве. Удачи!]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Хм...]],
next = "d_p14",
actions = {
{ questID="q_main_quest_act_2",type="quest_start" },
},
},
},
},
d_p14 = {
text = [[*Ты очень устал, однако придётся двигаться дальше.*]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_p2 = {
text = [[На данный момент есть только прототип - несовершенный Философский камень, потому он ломается после одного использования. Зато мы можем сделать кучу таких!]],
speaker = [[Человек-учёный]],
npc = "npc_scientist",
choices = {
{
text = [[Прикольно.]],
next = "d_prikolno",
},
},
},
d_p3 = {
text = [[У моего коллеги амнезия. Приходтся постоянно рассказывать ему курсы всех предметов с 1 по 11 класс, так ещё и план бакалавриата и магистратуры...]],
speaker = [[Человек-учёный]],
npc = "npc_scientist",
choices = {
{
text = [[Если бы я встретил вас при жизни, то может поступил бы в Кэмпридж...]],
next = "d_esli_by_ya_vstretil_vas_pri_zhizni_to_mozhet_postupil_by_v_kempridzh",
},
},
},
d_p4 = {
text = [[*По какой-то причине свечи начинают сильно разгораться. Тепло, что исходит от них не греет, а наоборот - обмараживает.*]],
speaker = [[Крип-предвестник апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[...]],
next = "d_p5",
},
},
},
d_p5 = {
text = [[*Шар начинает постепенно темнеть и покрываться чем-то наподобие плесени. Свечки затухли, и крип, с опустевшими глазами начинает обрывисто говорить...*]],
speaker = [[Крип-предвестник апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[...]],
next = "d_p6",
},
},
},
d_p6 = {
text = [[ОН И.. ИДЁТ.      МОНСТР...                    ГОРИЛЛА..      И...]],
speaker = [[Крип-предвестник апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[...]],
next = "d_p7",
},
},
},
d_p7 = {
text = [[ЖИ.. ЖИВОТНАЯ   ПОХОТЬ...       ЕГО..    ТЯГА...         ЧТО...        ИСПЕПЕЛЯЕТ...]],
speaker = [[Крип-предвестник апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[...]],
next = "d_p8",
},
},
},
d_p8 = {
text = [[ОНО..       Б.. БУДЕТ        НАСИЛОВАТЬ..    КАЖДОГО...           ГРЯДЁТ..]],
speaker = [[Крип-предвестник апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[...]],
next = "d_p9",
},
},
},
d_p9 = {
text = [[КОРОЛЕ..  ВСКАЯ..     БИТВА..            ПОСЛЕДНЕМУ..    ВЫЖИВШЕМУ...         БУДЕТ...]],
speaker = [[Крип-предвестник апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[...]],
next = "d_p10",
},
},
},
d_redhlup = {
text = [[*Существо красного цвета с мрачным видом смотрит в твою сторону. С некоторой периодичностью у него дёргается глаз.*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Ты ведь Красный?]],
next = "d_ty_ved_krasnyj",
},
},
},
d_secretending = {
text = [[СНЯЛ ВЕРИГИ...]],
speaker = [[default]],
npc = nil,
choices = {
{
text = [[grape vortex]],
next = nil,
actions = {
{ type="win" },
},
},
},
},
d_subwaycity = {
text = [[Куда Вам билет?]],
speaker = [[Терминал М.Е.Т.Р.О.]],
npc = "npc_subway_city",
choices = {
{
text = [[Горнолыжный склон]],
next = nil,
actions = {
{ target="tp_target_ski",type="teleport" },
},
},
{
text = [[Скрытая деревня]],
next = nil,
actions = {
{ target="tp_target_village",type="teleport" },
},
},
{
text = [[Площадка для проведения мероприятий]],
next = nil,
actions = {
{ target="tp_target_concert",type="teleport" },
},
},
{
text = [[Гетто]],
next = nil,
actions = {
{ target="tp_target_ghetto",type="teleport" },
},
},
{
text = [[Я передумал]],
next = nil,
},
},
},
d_subwaytocity = {
text = [[Отсюда можно вернуться в город.]],
speaker = [[Терминал М.Е.Т.Р.О.]],
npc = "npc_subway_to_city",
choices = {
{
text = [[Город]],
next = nil,
actions = {
{ target="tp_target_city",type="teleport" },
},
},
{
text = [[Я передумал]],
next = nil,
},
},
},
d_terminalclose = {
text = [[]],
speaker = [[Терминал М.Е.Т.Р.О.]],
npc = "npc_subway_city",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_a_gde_mne_ih_iskat = {
text = [[Где-то в этом мире, сам не знаю. Я вижу их постоянно, но не могу усмирить. Может и тебе посчастливиться встретить их.]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[Красный - гневный, Зелёный - упрямый, Синий - своевольный. Запомнил.]],
next = "d_a4",
},
},
},
d_a_gde_on = {
text = [[Он покинул нас.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[В каком смысле?]],
next = "d_v_kakom_smysle",
},
},
},
d_a_gde_sam_meteorit = {
text = [[*Крип задумался.*
И вправду... Где он?]],
speaker = [[Крип Предвестник Апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[Так это, ты сможешь выдать новое предсказание?]],
next = "d_tak_eto_ty_smozhesh_vydat_novoe_predskazanie",
},
},
},
d_a_esli_ya_projdu = {
text = [[Тогда с цмки одежда сама сползёт.]],
speaker = [[Эпштейн]],
npc = nil,
choices = {
{
text = [[Принято.]],
next = "d_prinyato",
actions = {
{ questID="q_island_escape",type="quest_start" },
},
},
},
},
d_a_esli_ya_hochu_tuda_popast = {
text = [[Тогда нужно, чтобы кто-то из наших посчитал тебя достойным и позволил присоединиться к нашим исследованиям.]],
speaker = [[Человек-хранитель]],
npc = "npc_templar_assasin",
choices = {
{
text = [[А как мне получить эту рекомендацию?]],
next = "d_a_kak_mne_poluchit_etu_rekomendatsiu",
},
},
},
d_a_zvat_to_ih_kak = {
text = [[Имена?.. Хм... Не припоминаю, я к ним всегда обращаюсь по цвету.]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
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
d_a_iz_chego_eta_zhizha_sostoit = {
text = [[Тебе лучше не знать.]],
speaker = [[Человек-учёный]],
npc = "npc_scientist",
choices = {
{
text = [[...]],
next = "d_p2",
},
},
},
d_a_kak_zhe_korol = {
text = [[Ты давай, ротик прикрывай. Пока Короля нету, правлю здесь я.]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[То есть Король - чмо?]],
next = "d_to_est_korol_chmo",
},
},
},
d_a_kak_zhe = {
text = [[В Заброшенном лесу проживает крип-предвестник, и каждые 3 года он рассказывает о приближающейся опасности.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Ого.]],
next = "d_ogo",
},
},
},
d_a_kak_mne_poluchit_etu_rekomendatsiu = {
text = [[Не имею понятия. Охрана тайн - вот моя миссия.]],
speaker = [[Человек-хранитель]],
npc = "npc_templar_assasin",
choices = {
{
text = [[...]],
next = "d_n9",
},
},
},
d_a_kripy_eto_kto = {
text = [[Мы не знаем, но они населяли эти земли ещё до появления людей. Кстати, некоторые крипы хорошие, они даже проживают с нами.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Ты сказала, что людей мало. Почему?]],
next = "d_ty_skazala_chto_ludej_malo_pochemu",
},
},
},
d_a_kto_vystupaet_to = {
text = [[Легенда.]],
speaker = [[Крип-вышибала]],
npc = "npc_concert_guard",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_a_kuda_on_otpravilsya = {
text = [[Он пошёл на запад! Боюсь ты не знаешь где это, хих.]],
speaker = [[Голова подначка]],
npc = "npc_ogre_magi",
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
speaker = [[Боб]],
npc = "npc_creep_bob",
choices = {
{
text = [[...]],
next = "d_i6",
},
},
},
d_a_pochemu_teper_tam_vse_zabrosheno = {
text = [[Потому что с приходом Короля, каждый захотел жить под его покровительством. Следовательно, все те за стенами начали переселяться в наш город. Однако из-за прошлых конфликтов приняли далеко не всех.]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[...]],
next = "d_o4",
},
},
},
d_a_pochemu_ty_ne_verneshsya_domoj = {
text = [[Почему? Ты должен сам понимать.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Нет, не понимаю.]],
next = "d_net_ne_ponimau",
},
},
},
d_a_u_kogo_ya_b_tozhe_podvypil = {
text = [[Не скажу.]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[Почему?]],
next = "d_pochemu",
},
},
},
d_a_che_sam_ne_pojdesh_togda_a = {
text = [[*Усач громко вздохнул.*
Я и сам слишком слаб...]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[...]],
next = "d_i2",
},
},
},
d_aleks = {
text = [[Круто. А я крип-рогач, знаешь почему?]],
speaker = [[Крип-рогач]],
npc = "npc_creep_rogach",
choices = {
{
text = [[Возможно из-за рогов.]],
next = "d_vozmozhno_izza_rogov",
},
},
},
d_bazar = {
text = [[]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_beru_kachestvom = {
text = [[Берёшь куда?]],
speaker = [[Сиамский огр]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Проехали, так чем он вам отплатил?]],
next = "d_l13",
},
},
},
d_bog = {
text = [[Есть ли у Бога мораль?]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[Да.]],
next = "d_o9",
},
{
text = [[Нет.]],
next = "d_o10",
},
},
},
d_bolshe_voprosov_netu = {
text = [[Хорошо. Кстати, я так и не спросила твоего имени...]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Меня зовут...]],
next = "d_menya_zovut",
},
},
},
d_bhh_haaa_eosh = {
text = [[Вход в деревню не доступен болванам.]],
speaker = [[Человек-хранитель]],
npc = "npc_templar_assasin",
choices = {
{
text = [[Умереть.]],
next = nil,
actions = {
{ attacker="npc_templar_assasin",type="die" },
},
},
},
},
d_byvaj = {
text = [[Тогда, как вернёшься, я сниму их с тебя и убегу, слышишь?!]],
speaker = [[Крип-камыш]],
npc = "npc_rape_victim",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_v_kakom_smysle = {
text = [[*Она не отвечает.*]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Понятно.]],
next = "d_h6",
},
},
},
d_v_printsipe_ya_ponyal_vy_dva_daunicha = {
text = [[НЕТ! Мы довольно смышлённые, даже думать умеем! А вдвоём наш разум увеличивается в три раза!]],
speaker = [[Голова умнотуп]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Почему в три.]],
next = "d_pochemu_v_tri",
},
},
},
d_v_sebe = {
text = [[2: Как можно вообще потеряться в себе, он внутри своей головы живёт?
1: Это невозможно. скорее всего он заблудился.]],
speaker = [[Крип-сиамский огр]],
npc = "npc_ogre_magi",
choices = {
{
text = [[*Уйти.*]],
next = "d_ujti",
actions = {
{ questID="q_ogres",type="quest_end" },
},
},
},
},
d_valyaj = {
text = [[Знал ли ты, что на месте Пустоши стоял город, подобно нашему?]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[Нет.]],
next = "d_net",
},
},
},
d_vau = {
text = [[Прямо сейчас я послала достаточный импульс, который позволит избранным прорваться и сделать тебя совершенным. Достойными оказались трое.]],
speaker = [[Старушка]],
npc = "npc_shamanka",
choices = {
{
text = [[Towel Master.]],
next = "d_vybrat_svou_sudbu",
actions = {
{ hero="npc_dota_hero_sanya_towel_master",type="change_hero" },
},
},
{
text = [[Кварц-Ксеон.]],
next = "d_vybrat_svou_sudbu",
actions = {
{ hero="npc_dota_hero_sanya_rapper",type="change_hero" },
},
},
{
text = [[Интегралус.]],
next = "d_vybrat_svou_sudbu",
actions = {
{ hero="npc_dota_hero_sanya_logarithmus",type="change_hero" },
},
},
},
},
d_vash_brat_tak_skazal = {
text = [[Так ты нашёл его? Он всё ещё ходит с той огромной дубиной, да?]],
speaker = [[Голова умнотуп]],
npc = "npc_ogre_magi",
choices = {
{
text = [[...]],
next = "d_m7",
},
},
},
d_vizhu_ty_s_ludmi_horosho_ladish = {
text = [[Да, мы и люди - инь янь, понимаешь? Всё время вместе. Но...]],
speaker = [[Крип-рогач]],
npc = "npc_creep_rogach",
choices = {
{
text = [[Но?]],
next = "d_no__1",
},
},
},
d_vozmozhno_izza_rogov = {
text = [[В точку, братан.]],
speaker = [[Крип-рогач]],
npc = "npc_creep_rogach",
choices = {
{
text = [[Вижу ты с людьми хорошо ладишь?]],
next = "d_vizhu_ty_s_ludmi_horosho_ladish",
},
},
},
d_voobschem_ty_pidorasik = {
text = [[ЧЕГО?!]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*Ухмыльнуться и начать хлюпать.*]],
next = "d_uhmylnutsya_i_nachat_hlupat",
actions = {
{ music="hlup",type="music_start" },
},
},
},
},
d_vot_tvoj_shar = {
text = [[*Выронив из рук все шишки, он подлетает к тебе и выхватывает шар. Руки крипа нетерпеливо крутят его во все стороны, пока лучи солнца бликуют об хрустальную поверхность прямо тебе в глаза.*]],
speaker = [[Крип-предвестник апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[Всё хватит. Ты обещал сделать предсказание.]],
next = "d_vse_hvatit_ty_obeschal_sdelat_predskazanie",
},
},
},
d_vsego = {
text = [[Великая мудрость... Что ж, свидимся позже.]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Пока.]],
next = nil,
actions = {
{ npc="npc_red",type="remove" },
},
},
},
},
d_vse_hvatit_ty_obeschal_sdelat_predskazanie = {
text = [[Ооух точно! Ради тебя и твоего рода я дам вам предупреждения от высших... Начинаю.]],
speaker = [[Крип-предвестник апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[*Наблюдать.*]],
next = "d_nabludat",
},
},
},
d_vy_voobsche_chto_takoe = {
text = [[*Главный начал разговор.*
Ооо новичок подъехал, мы таких любим.]],
speaker = [[Банда троллей]],
npc = "npc_troll",
choices = {
{
text = [[...]],
next = "d_g",
},
},
},
d_vy_edinoe_tseloe_ili_dve_lichnosti = {
text = [[*1-ая голова начала говорить медленным занудным тоном.*
Я Шофёр лимузина. Вожу важных персон. На машине... На конях...]],
speaker = [[Голова умнотуп]],
npc = "npc_ogre_magi",
choices = {
{
text = [[...]],
next = "d_l5",
},
},
},
d_vy_rodstvenniki_primi_ego_takim_kakim_est_i_eto_budet_vzaimno = {
text = [[ТЫ ДЕБИЛЬНЫЙ ДАУН. ПРЯМ ДАУНСКИЙ ДЕБИЛ.]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Отец любит тебя. Он ждёт тебя. Вернись домой. Семья - самое важное на свете.]],
next = "d_otets_lubit_tebya_on_zhdet_tebya_vernis_domoj_semya_samoe_vazhnoe_na_svete",
},
},
},
d_vy_svobodny_ubegajte = {
text = [[*Поочерёдно крипы встали и поклонились тебе.*]],
speaker = [[Крип-кот в бочке]],
npc = nil,
choices = {
{
text = [[*Ты кланяешься в ответ.*]],
next = "d_ty_klanyaeshsya_v_otvet",
},
},
},
d_vysvobozhdenie = {
text = [[Высвобождение? А высвобождение чего?]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Всего.]],
next = "d_vsego",
},
},
},
d_gde_tsmka = {
text = [[Чуть дальше. Скажи, красавчик, сколько тебе лет?]],
speaker = [[???]],
npc = nil,
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
d_getto = {
text = [[]],
speaker = [[Терминал М.Е.Т.Р.О.]],
npc = "npc_subway_city",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_gornolyzhnyj_sklon = {
text = [[]],
speaker = [[Терминал М.Е.Т.Р.О.]],
npc = "npc_subway_city",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_gorod = {
text = [[]],
speaker = [[Терминал М.Е.Т.Р.О.]],
npc = "npc_subway_to_city",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_da = {
text = [[*Усач разлился хохотом*
Не думал, что в мире остались люди с яйцами!]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[Огромными, прошу заметить.]],
next = "d_ogromnymi_proshu_zametit",
},
},
},
d_da_bolshaya_yama = {
text = [[Метеорит упал в то место. Это предсказал мой шар! Целых три года назад!!]],
speaker = [[Крип Предвестник Апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[А где сам метеорит?]],
next = "d_a_gde_sam_meteorit",
},
},
},
d_da_oni_svoebraznye_no_hotya_by_provedaj_ih = {
text = [[Тебе не понять насколько мерзки они для меня.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Но...]],
next = "d_no",
},
},
},
d_da__1 = {
text = [[Алекс, а такой красивый юноша мог бы выполнить скромную просьбу юной девушки.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[А как же.]],
next = "d_a_kak_zhe",
},
},
},
d_da_i_ya_obozhau_reshat = {
text = [[Ого! Наконец-то смышлённый человек забрёл в этот мир. Чудеса! Значит мы поладим с тобой.]],
speaker = [[Человек-учёный]],
npc = "npc_scientist",
choices = {
{
text = [[Ты упомянул алхимию. Разве она существует?]],
next = "d_ty_upomyanul_alhimiu_razve_ona_suschestvuet",
},
},
},
d_davajte_sami = {
text = [[Похоже мы больше никогда не встретим брата...]],
speaker = [[Голова умнотуп]],
npc = "npc_ogre_magi",
choices = {
{
text = [[...]],
next = "d_sudba_ploho",
},
},
},
d_daj_togda_hlebnut_iz_tvoego_bochonka = {
text = [[Охох, всё содержимое уже во мне.
*Панда шлёпает себя по пузу, а потом стучит по бочке, намекая, что она пустая, однако слышно, что в ней ещё немного осталось.*]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[Я слышу, что пиво ещё есть.]],
next = "d_ya_slyshu_chto_pivo_esche_est",
},
},
},
d_derevya_i_dikie_kripy = {
text = [[Дубина, там сокровища, слышишь??]],
speaker = [[Крип-камыш]],
npc = "npc_rape_victim",
choices = {
{
text = [[Это хорошо, по пути прихвачу.]],
next = "d_eto_horosho_po_puti_prihvachu",
},
},
},
d_dzheffri_ejnshtejn = {
text = [[Эпштейн.]],
speaker = [[Эпштейн]],
npc = nil,
choices = {
{
text = [[Кранштейн.]],
next = "d_kranshtejn",
},
},
},
d_do_svidaniya = {
text = [[]],
speaker = [[Старушка]],
npc = "npc_shamanka",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_dopustim = {
text = [[*Неизвестное придало тебе сил двигаться дальше.*]],
speaker = [[...]],
npc = "npc_tormentor",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_dumau_net = {
text = [[Тогда возвращайся в безопасноcть, в этом лесу куча кровожадных существ.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_dumau_on_prav = {
text = [[*Обе головы хором ответили.*
У нас два мозга, а у тебя один. Не сравнивай нас с собой!]],
speaker = [[Сиамский огр]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Беру качеством.]],
next = "d_beru_kachestvom",
},
},
},
d_esli_by_ya_vstretil_vas_pri_zhizni_to_mozhet_postupil_by_v_kempridzh = {
text = [[Будь благодарен тому, что сможешь обучиться этому сейчас! Присоединяйся как-нибудь к нам и станешь умнейшим в этих краях. Так и сможешь исследовать вселенную!]],
speaker = [[Человек-учёный]],
npc = "npc_scientist",
choices = {
{
text = [[Может. Кстати, а можно мне один Философский камень?]],
next = "d_mozhet_kstati_a_mozhno_mne_odin_filosofskij_kamen",
},
},
},
d_zhmot = {
text = [[*После таких слов, он разозлился, поставил бочку на землю и пнул её в тебя.*]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[*Разбить бочку пинком.*]],
next = "d_razbit_bochku_pinkom",
},
},
},
d_zabroshennyj_les = {
text = [[Неее, я имею ввиду, что там ВНУТРИ.]],
speaker = [[Крип-камыш]],
npc = "npc_rape_victim",
choices = {
{
text = [[Деревья... и дикие крипы?]],
next = "d_derevya_i_dikie_kripy",
},
},
},
d_zapomnit_dlya_chego = {
text = [[*Существо исчезло.*]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_zdarova = {
text = [[Ты попал в наш дом, ты новый житель, бро.]],
speaker = [[Крип-рогач]],
npc = "npc_creep_rogach",
choices = {
{
text = [[Приятно.]],
next = "d_priyatno",
},
},
},
d_zdraste_ne_podskazhete_gde_ya = {
text = [[Чувствую перед собой сильную энергию... Неужто пришёл тот, кто освободит наше измученное Королевство?]],
speaker = [[Старушка]],
npc = "npc_shamanka",
choices = {
{
text = [[Что?]],
next = "d_chto__1",
},
},
},
d_znaesh_ya_peredumal = {
text = [[*Красный с энтузиазмом глазеет в твою сторону. Его губы начинают дрожать, новое оскорбление вот вот вылетит из них со свистом.*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Вообщем ты пидорасик.]],
next = "d_voobschem_ty_pidorasik",
},
},
},
d_i_vpravdu_uzhas = {
text = [[Ты показал свою силу, добравшись живым до сюда. Можешь ли ты узнать, какой будет следующая катастрофа, чтобы мы были готовы?]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Конечно.]],
next = "d_h7",
actions = {
{ questID="q_main_quest_act_1",type="quest_start" },
},
},
{
text = [[Слушаюсь и повинуюсь.]],
next = "d_h7",
actions = {
{ questID="q_main_quest_act_1",type="quest_start" },
},
},
},
},
d_i_kak_mne_na_eto_reagirovat = {
text = [[*Пора возвращаться к гиду.*]],
speaker = [[Крип-предвестник апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_i_mantiu = {
text = [[И мантию прихвати нам!]],
speaker = [[Голова подначка]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Ладно.]],
next = "d_ladno",
actions = {
{ questID="q_ogres",type="quest_start" },
},
},
{
text = [[Давайте сами.]],
next = "d_davajte_sami",
actions = {
{ questID="q_ogres",type="quest_reject" },
},
},
},
},
d_i_ne_posporish = {
text = [[]],
speaker = [[Воин Эпштейна]],
npc = "npc_island_guard",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_i_tvoj_brat_daj_ugadau_tozhe_prints = {
text = [[Верно. Красный Принц. Земля досталась нам от отца. Вечная борьба.]],
speaker = [[Синий Принц]],
npc = "npc_blue_prince",
choices = {
{
text = [[И тебе помочь отвоевать её?]],
next = "d_i_tebe_pomoch_otvoevat_ee",
},
},
},
d_i_tebe_pomoch_otvoevat_ee = {
text = [[Верно. Брат мой - последователь капитализма. Куча денег. Куча сильных бойцов. Я не имею такового.]],
speaker = [[Синий Принц]],
npc = "npc_blue_prince",
choices = {
{
text = [[Но ты же мне заплатишь?]],
next = "d_no_ty_zhe_mne_zaplatish",
},
},
},
d_i_tebe_horoshego = {
text = [[*Рогач стучит себя по груди и махает тебе, пока ты уходишь.*]],
speaker = [[Крип-рогач]],
npc = "npc_creep_rogach",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_i_chto_delat_budem = {
text = [[Ты будешь проходить полосу препятствий, а я смотреть. Ты умирать, а я наслаждаться.]],
speaker = [[Эпштейн]],
npc = nil,
choices = {
{
text = [[А если я пройду?]],
next = "d_a_esli_ya_projdu",
},
},
},
d_i_chto_togda_delat = {
text = [[КАЧАТЬСЯ! Лишь комбинация сильного духа и тела позволит человеку возвыситься до его уровня. Я обязан стать сильнее!]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[Я тогда тоже буду.]],
next = "d_ya_togda_tozhe_budu",
},
},
},
d_i__1 = {
text = [[Он наш брат! Братьев ценить нужно! Даже человек должен это понять.]],
speaker = [[Голова умнотуп]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Ну могу да.]],
next = "d_nu_mogu_da",
},
},
},
d_ischez_s_radarov = {
text = [[Исчез с радаров!]],
speaker = [[Голова умнотуп]],
npc = "npc_ogre_magi",
choices = {
{
text = [[И?]],
next = "d_i__1",
},
},
},
d_kak_pojdet = {
text = [[Подожди подожди, а кто тебе рассказал об их существовании? Это я!]],
speaker = [[Крип-камыш]],
npc = "npc_rape_victim",
choices = {
{
text = [[Не помню такого.]],
next = "d_ne_pomnu_takogo",
},
},
},
d_kakoj_dar_prepodnesesh_mne_segodnya = {
text = [[Какой ещё дар?! Ааа... я понял! Информация же пойдёт, да?]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[Валяй.]],
next = "d_valyaj",
},
},
},
d_kogo = {
text = [[Небеса с тобой. Слава Королю!]],
speaker = [[Старушка]],
npc = "npc_shamanka",
choices = {
{
text = [[До свидания.]],
next = nil,
actions = {
{ questID="q_reach_city",type="quest_start" },
},
},
},
},
d_kranshtejn = {
text = [[*Тишина.*]],
speaker = [[Эпштейн]],
npc = nil,
choices = {
{
text = [[И что делать будем?]],
next = "d_i_chto_delat_budem",
},
},
},
d_kruto_kak_tam_s_nagradoj = {
text = [[Возьми. Большая награда. Для большого человека.]],
speaker = [[Синий Принц]],
npc = "npc_blue_prince",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_kstati_u_tebya_znakomyj_golos = {
text = [[Серьёзно? Не знал, что у меня есть фанаты даже здесь. Я Джеффри...]],
speaker = [[Эпштейн]],
npc = nil,
choices = {
{
text = [[Джеффри Эйнштейн.]],
next = "d_dzheffri_ejnshtejn",
},
},
},
d_ladno_togda_chast_otsyplu_mozhet_byt = {
text = [[Всмысле может быть?!]],
speaker = [[Крип-камыш]],
npc = "npc_rape_victim",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_ladno_poka = {
text = [[*В стороне ты заметил вход в подземные пути.*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_ladno = {
text = [[*Огр дал сам себе пять.*]],
speaker = [[Сиамский огр]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_les = {
text = [[ЛЕС!]],
speaker = [[Голова подначка]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_mamu_ne_trogaj = {
text = [[Поздно. Облапана до предела.]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[*Ударить лбом ему по лицу.*]],
next = "d_udarit_lbom_emu_po_litsu",
},
},
},
d_mantii_na_intellekt_ne_suschestvuet = {
text = [[Как так?!]],
speaker = [[Сиамский огр]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Ваш брат так сказал.]],
next = "d_vash_brat_tak_skazal",
},
},
},
d_mantiya_proklyata = {
text = [[Нет. Я просто не хочу быть прежним. Сейчас я владею всеми знаниями мира, это высшее наслаждение.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[...]],
next = "d_m1",
},
},
},
d_menya_zovut = {
text = [[*Девушка в предвкушении.*]],
speaker = [[Человек-гид]],
npc = "npc_guide",
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
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Они беспокоются за тебя, вернёшься к ним?]],
next = "d_oni_bespokoutsya_za_tebya_verneshsya_k_nim",
},
},
},
d_mne_kazhetsya_ya_znau_parol = {
text = [[Говори.]],
speaker = [[Человек-хранитель]],
npc = "npc_templar_assasin",
choices = {
{
text = [[Z - это Cамость, а Cамость - это Z.]],
next = "d_z_eto_camost_a_camost_eto_z",
actions = {
{ var="has_village_pass",value=true,type="set_var" },
{ door="door_village",type="open_door" },
},
},
},
},
d_mne_tozhe_odnako_vybora_net = {
text = [[Тогда начнём.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[*Начать битву*]],
next = nil,
actions = {
{ target="talk",npc="npc_ogre_bruiser",type="fight_start" },
},
},
},
},
d_mnogo_chego = {
text = [[Много хорошего... И... Много великого, да.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[А где он?]],
next = "d_a_gde_on",
},
},
},
d_mozhet_kstati_a_mozhno_mne_odin_filosofskij_kamen = {
text = [[Конечно! Только не показывай простолюдинам. Используй в тайне!]],
speaker = [[Человек-учёный]],
npc = "npc_scientist",
choices = {
{
text = [[*Взять камень.*]],
next = "d_vzyat_kamen",
actions = {
{ itemName="item_philosopher_pebble",type="give_item" },
},
},
},
},
d_my_v_limbe = {
text = [[Да, наши души где-то промежутке.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[То есть я не смогу вернуться?]],
next = "d_to_est_ya_ne_smogu_vernutsya",
},
},
},
d_navernoe_no_umirat_neohota = {
text = [[ЭТО ПРАВДА. ОДНАКО У МЕНЯ ПРИКАЗ, ИЗВИНИ.]],
speaker = [[Воин Эпштейна]],
npc = "npc_island_guard",
choices = {
{
text = [[Понимаю.]],
next = "d_ponimau",
},
},
},
d_nadeyalsya_chto_smozhem_vstretitsya_vzhivuu = {
text = [[Ты, к сожалению, староват.]],
speaker = [[Эпштейн]],
npc = nil,
choices = {
{
text = [[...]],
next = "d_n1",
},
},
},
d_nauka = {
text = [[Может ли наука превзойти Бога?]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[Да.]],
next = "d_o12",
},
{
text = [[Нет.]],
next = "d_o13",
},
},
},
d_nachnem_duel = {
text = [[]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_ne_ne_mne_ne_vazhno_kto_vy_ya_sprashival_chto_za_rasa_u_vas = {
text = [[Разорвём на части этого черта!!]],
speaker = [[Банда троллей]],
npc = "npc_troll",
choices = {
{
text = [[*Начать обороняться.*]],
next = nil,
actions = {
{ npc="npc_gate_troll_uruk",target="kill",type="fight_start" },
{ npc="npc_gate_troll_biruk",target="kill",type="fight_start" },
{ npc="npc_gate_troll_diruk",target="kill",type="fight_start" },
},
},
},
},
d_ne_nuzhno_poverte = {
text = [[Мне кажется он не спичка... Больше он походит на человека. Если мы его подожжём, он сгорит, понимаешь?]],
speaker = [[Голова умнотуп]],
npc = "npc_ogre_magi",
choices = {
{
text = [[...]],
next = "d_l9",
},
},
},
d_ne_obet_a_obed = {
text = [[*Ты слышишь странный звук. Грудь ощущается тяжёлой. Повернув голову вниз, ты замечаешь сквозную дыру. Похоже она попала прям в сердце.*]],
speaker = [[Человек-хранитель]],
npc = "npc_templar_assasin",
choices = {
{
text = [[Бххъ... хааа... еошъъ....]],
next = "d_bhh_haaa_eosh",
},
},
},
d_ne_podskazhesh_gde_najti_predvestnika = {
text = [[Ай я оой ёёёй... Мой бедный шарик. Хрустальный шарик.]],
speaker = [[Раздраженный крип]],
npc = "npc_predvestnik",
choices = {
{
text = [[Ээй. Ало.]],
next = "d_eej_alo",
},
},
},
d_ne_pomnu_takogo = {
text = [[Э?]],
speaker = [[Крип-камыш]],
npc = "npc_rape_victim",
choices = {
{
text = [[Бывай.]],
next = "d_byvaj",
},
},
},
d_ne_ponyal = {
text = [[Войдёшь в Пустоши и тебе напихают настолько сильно... Даже не знаю, есть ли слова, чтобы описать насколько...]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[А чё сам не пойдёшь тогда, а?]],
next = "d_a_che_sam_ne_pojdesh_togda_a",
},
},
},
d_ne_hochu = {
text = [[Ты. Подумай ещё.]],
speaker = [[Синий Принц]],
npc = "npc_blue_prince",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_ne_ya_prishel_uznat_novoe_predskazanie = {
text = [[Аааа... Понятно.
*Крип начал палкой двигать осколки.*]],
speaker = [[Крип Предвестник Апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[Так что?]],
next = "d_o7",
},
},
},
d_nea_teper_ya_tvoj_tsar = {
text = [[Ээу, после битвы совсем оборзел чтоли?!]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[*Пригрозить кулаком*]],
next = "d_prigrozit_kulakom",
},
},
},
d_net_ne_ponimau = {
text = [[Нынешнему мне не о чем говорить с ними. У вас был диалог, думаю несложно догадаться о чём я.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Да, они своебразные, но хотя бы проведай их.]],
next = "d_da_oni_svoebraznye_no_hotya_by_provedaj_ih",
},
},
},
d_net = {
text = [[И наши города были в напряжных таких отношениях. Не воевали, конечно, но злоба была всякая.]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[А почему теперь там всё заброшено?]],
next = "d_a_pochemu_teper_tam_vse_zabrosheno",
},
},
},
d_net_ya_ostavlu_tebya_v_zhivyh = {
text = [[Не выйдет. Я умру как личность.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[*Снять с него Мантию.*]],
next = "d_snyat_s_nego_mantiu",
actions = {
{ npc="npc_ogre_bruiser",type="kill" },
},
},
{
text = [[*Не снимать.*]],
next = "d_ne_snimat",
},
},
},
d_no_ty_zhe_mne_zaplatish = {
text = [[Верно.]],
speaker = [[Синий Принц]],
npc = "npc_blue_prince",
choices = {
{
text = [[Хм...]],
next = "d_hm__1",
},
},
},
d_no = {
text = [[Ты сейчас начнёшь рассказывать о наших воспоминаниях, братских узах и о том, как они меня однажды спасли. Не нужно этого.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[...]],
next = "d_m2",
},
},
},
d_no__1 = {
text = [[Среди крипов куча злыдней, чёрт... Да и люди бывают теми ещё подонками...]],
speaker = [[Крип-рогач]],
npc = "npc_creep_rogach",
choices = {
{
text = [[Понимаю тебя.]],
next = "d_ponimau_tebya",
},
},
},
d_nu_i_horosho = {
text = [[СРАЖЕНИЕ ЗА КОГО-ТО ДРУГОГО ПРИДАСТ ТЕБЕ МОТИВАЦИИ ДРАТЬСЯ В ПОЛНУЮ СИЛУ.]],
speaker = [[Воин Эпштейна]],
npc = "npc_island_guard",
choices = {
{
text = [[Так-то да.]],
next = "d_takto_da",
},
},
},
d_nu_kak = {
text = [[Знаешь... Лучше. Твои удары усмирили мой гнев. Что-то я уж больно вспылил, даже неприятно вспоминать кем я был минуту назад. Благодарю за возвращение в спокойное состояние.]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Так ты вернёшься домой?]],
next = "d_tak_ty_verneshsya_domoj",
},
},
},
d_nu_mogu_da = {
text = [[Мы с ним взрывали петарды в лесу, как на нас вышел огромный дракон. Он мог летать. С помощью крыльев.]],
speaker = [[Голова умнотуп]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Ага.]],
next = "d_l10",
},
},
},
d_nu_mozhet_razehalis = {
text = [[Он убил всех. Остались только мы, что побоялись идти с остальными.]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[И что тогда делать?]],
next = "d_i_chto_togda_delat",
},
},
},
d_obidno = {
text = [[ЖАЛКО ТЕБЯ РАЗОЧАРОВЫВАТЬ.]],
speaker = [[Воин Эпштейна]],
npc = "npc_island_guard",
choices = {
{
text = [[Опять не повезло...]],
next = "d_opyat_ne_povezlo",
},
},
},
d_ogo = {
text = [[Время пророчества близко, но неизвестно чего ожидать. Мы бы спросили его, но в лесу полно опасных крипов, а мы люди - сейчас слабы.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[И вправду ужас.]],
next = "d_i_vpravdu_uzhas",
},
},
},
d_ogromnymi_proshu_zametit = {
text = [[Ого! Ну и боевой дух! Только вот ты ещё слабачок.]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[Не понял.]],
next = "d_ne_ponyal",
},
},
},
d_on_i_vpravdu_ochen_skuchaet_po_tebe_ponimaesh = {
text = [[ПРИКИНЬ, ТЫ ШЕРСТЬ.]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Вы родственники. Прими его таким, каким есть, и это будет взаимно.]],
next = "d_vy_rodstvenniki_primi_ego_takim_kakim_est_i_eto_budet_vzaimno",
},
},
},
d_on_ne_vernetsya = {
text = [[*Обе головы переглянулись в недоумении.*
Почему?!]],
speaker = [[Крип-сиамский огр]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Он потерялся.]],
next = "d_on_poteryalsya",
},
},
},
d_on_poteryalsya = {
text = [[Где?!]],
speaker = [[Крип-сиамский огр]],
npc = "npc_ogre_magi",
choices = {
{
text = [[В себе.]],
next = "d_v_sebe",
},
},
},
d_on_srazhalsya_s_drakonom_posle_pobedy_on_pal = {
text = [[*Они начали смотреть в разные стороны.*]],
speaker = [[Крип-сиамский огр]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Ценой своей жизни он спас поселение добрых крипов.]],
next = "d_tsenoj_svoej_zhizni_on_spas_poselenie_dobryh_kripov",
},
},
},
d_on_umer = {
text = [[*Головы замолкли.*]],
speaker = [[Крип-сиамский огр]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Он сражался с драконом. После победы, он пал.]],
next = "d_on_srazhalsya_s_drakonom_posle_pobedy_on_pal",
},
},
},
d_oni_bespokoutsya_za_tebya_verneshsya_k_nim = {
text = [[Теперь не могу. Но каких-то пару дней назад всё ещё был шанс.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Это связано с Мантией?]],
next = "d_eto_svyazano_s_mantiej",
},
},
},
d_oo_u_vas_tut_matematika = {
text = [[*Услышав любимое слово, человек резко повернулся к тебе.*
Да! Математика, физика, астрономия и алхимия - всё это есть у нас, молодой человек! Вы новенький тут?]],
speaker = [[Человек-учёный]],
npc = "npc_scientist",
choices = {
{
text = [[Да. И я обожаю решать.]],
next = "d_da_i_ya_obozhau_reshat",
},
},
},
d_opyat_ne_povezlo = {
text = [[ЧЕМ БЫСТРЕЕ УМРЁШЬ, ТЕМ БЫСТРЕЕ ПРОЙДЁТ ГРУСТЬ.]],
speaker = [[Воин Эпштейна]],
npc = "npc_island_guard",
choices = {
{
text = [[Наверное, но умирать неохота...]],
next = "d_navernoe_no_umirat_neohota",
},
},
},
d_otets_lubit_tebya_on_zhdet_tebya_vernis_domoj_semya_samoe_vazhnoe_na_svete = {
text = [[ПИСЕЧНАЯ ПОДСТАВКА - ТВОЙ ВЕЛИКИЙ ТИТУЛ. А ВООБЩЕ У ТЕБЯ НОС КАК...]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Знаешь, я передумал.]],
next = "d_znaesh_ya_peredumal",
},
},
},
d_otkuda_ty_voobsche_govorish = {
text = [[Остров усеян динамиками, а что?]],
speaker = [[Эпштейн]],
npc = nil,
choices = {
{
text = [[Надеялся, что сможем встретиться вживую.]],
next = "d_nadeyalsya_chto_smozhem_vstretitsya_vzhivuu",
},
},
},
d_otkuda_ty_eto_skazal = {
text = [[ГОРДЫНЯ - РАЗРУШИТЕЛЬ СУЩЕГО.]],
speaker = [[???]],
npc = "npc_tormentor",
choices = {
{
text = [[Подскажи где я.]],
next = "d_podskazhi_gde_ya",
},
},
},
d_plata_za_informatsiu = {
text = [[Верно подмечено!]],
speaker = [[Крип-камыш]],
npc = "npc_rape_victim",
choices = {
{
text = [[Ладно тогда, часть отсыплю, может быть.]],
next = "d_ladno_togda_chast_otsyplu_mozhet_byt",
},
},
},
d_ploschadka_dlya_provedeniya_meropriyatij = {
text = [[]],
speaker = [[Терминал М.Е.Т.Р.О.]],
npc = "npc_subway_city",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_podskazhi_gde_ya = {
text = [[*Фигура замолкла.*]],
speaker = [[???]],
npc = "npc_tormentor",
choices = {
{
text = [[Допустим.]],
next = "d_dopustim",
},
},
},
d_pozaimstvoval_mozhet_ukral = {
text = [[Не твоё дело.]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[Расскажи откуда, мне для друга надо.]],
next = "d_pochemu",
},
},
},
d_poka = {
text = [[]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_pomosch_nuzhna = {
text = [[Меня зовут... эм...
*Крип начал перебирать варианты.*]],
speaker = [[Боб]],
npc = "npc_creep_bob",
choices = {
{
text = [[...]],
next = "d_i7",
},
},
},
d_ponimau_tebya = {
text = [[Но мы всё равно вместе, понимаешь, Ален? Мы душевно связаны.]],
speaker = [[Крип-рогач]],
npc = "npc_creep_rogach",
choices = {
{
text = [[Респект.]],
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
speaker = [[Воин Эпштейна]],
npc = "npc_island_guard",
choices = {
{
text = [[Те, наверное, как раз жерты Эпштейна, да?]],
next = "d_te_navernoe_kak_raz_zherty_epshtejna_da",
},
},
},
d_ponyatno = {
text = [[Знаешь... Если бы ты тогда сражался за нас, то исход мог бы быть совершенно другим... Хотя забудь.]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[Понятно. Хороший дар ты преподнёс, благодарен тебе.]],
next = "d_ponyatno_horoshij_dar_ty_prepodnes_blagodaren_tebe",
},
},
},
d_ponyatno_horoshij_dar_ty_prepodnes_blagodaren_tebe = {
text = [[Получается так...]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_pochemu_v_tri = {
text = [[Потому что в 4!]],
speaker = [[Голова подначка]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Я короч пошёл.]],
next = "d_ya_koroch_poshel",
},
},
},
d_pochemu_ty_ne_pytaeshsya_sbezhat = {
text = [[В этом нет нужды. Моя жизнь теперь в твоих руках.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[*Потянуться к Мантии.*]],
next = "d_m4",
},
},
},
d_pochemu = {
text = [[Какая мне выгода?]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[Дай тогда хлебнуть из твоего бочонка.]],
next = "d_daj_togda_hlebnut_iz_tvoego_bochonka",
},
},
},
d_privet = {
text = [[Приветствую, рада видеть новые лица в нашем Королевстве.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[А ты кто?]],
next = "d_h",
},
},
},
d_prikolno = {
text = [[Мы стараемся раскрыть все тайны этого мира и добиться великих результатов! Я уверен, что здесь скрыто нечто большее. Но к сожалению, узнаем мы это не скоро...]],
speaker = [[Человек-учёный]],
npc = "npc_scientist",
choices = {
{
text = [[Почему?]],
next = "d_p3",
},
},
},
d_prinyato = {
text = [[Тогда вперёд.]],
speaker = [[Эпштейн]],
npc = nil,
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_prichina = {
text = [[Осознание. Возвращение в прошлую жизнь недопустимо.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Мантия проклята?]],
next = "d_mantiya_proklyata",
},
},
},
d_priyatno = {
text = [[Как звать тебя?]],
speaker = [[Крип-рогач]],
npc = "npc_creep_rogach",
choices = {
{
text = [[Алекс.]],
next = "d_aleks",
},
},
},
d_prosto_tak_do_takoj_stepeni_ne_napivautsya_chto_ne_tak = {
text = [[Да беда ужасная настигла. У меня есть три сына, понимаешь, а они сбежали от папки своего, не хотят ладить со мной.]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[...]],
next = "d_o5",
},
},
},
d_rad = {
text = [[Но и сильно разочаровал. Ты забрал мой товар, так что с этих пор - оглядывайся.]],
speaker = [[Эпштейн]],
npc = nil,
choices = {
{
text = [[Ладно, пока.]],
next = "d_ladno_poka",
},
},
},
d_rasskazhi_o_synovyah = {
text = [[Ооох, они прекрасные, но в последнее время на них что-то нашло, не подчиняются старику. Бывало заставляли меня делать ужасные вещи: воровать, буянить, даже нападать на окружающих... Ох, ужас...]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[...]],
next = "d_empty",
},
},
},
d_s_etogo_momenta_tsepi_konury_bolee_ne_smogut_sderzhat_moego_buldoga_ty_svoboden = {
text = [[Вдруг, как домино, люди начали окутывать тебя аплодисментами и восторженными возгласами. Тебе начало казаться, что из-за их шума земля начала дрожать. После такого остаётся делать только одну вещь...*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*... утопать в овациях.*]],
next = "d_utopat_v_ovatsiyah",
},
},
},
d_skolko_za_chas = {
text = [[Приветствую, не переживай, вход в город бесплатный, можешь находиться здесь столько, сколько тебе нужно.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[...]],
next = "d_h",
},
},
},
d_skrytaya_derevnya = {
text = [[]],
speaker = [[Терминал М.Е.Т.Р.О.]],
npc = "npc_subway_city",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_slovno_igly_moi_botinki_vyshili_eti_ornamenty_dlya_vas_zemlyane = {
text = [[Вдруг, как домино, люди начали окутывать тебя аплодисментами и восторженными возгласами. Тебе начало казаться, что из-за их шума земля начала дрожать. После такого остаётся делать только одну вещь...*]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[*... утопать в овациях.*]],
next = "d_utopat_v_ovatsiyah",
},
},
},
d_smotrya_chto_predlagaesh = {
text = [[Я - Синий Принц. Сын великого Булыжника. Однако у Булыжника. Два сына.]],
speaker = [[Синий Принц]],
npc = "npc_blue_prince",
choices = {
{
text = [[И твой брат, дай угадаю, тоже принц?]],
next = "d_i_tvoj_brat_daj_ugadau_tozhe_prints",
},
},
},
d_sozhaleu = {
text = [[Верно. Ужасное событие, возможно это кара Божья!]],
speaker = [[Крип Предвестник Апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[Чем шар ценен?]],
next = "d_o8",
},
},
},
d_spasibo_tipo = {
text = [[Со сменой суток, в Королевстве можешь встретиить новые лица. Возможно, тебе захочется пообщаться с горожанами.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Ладно.]],
next = "d_p13",
},
},
},
d_spasibo_veru = {
text = [[Добро пожаловать.]],
speaker = [[Человек-хранитель]],
npc = "npc_templar_assasin",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_stop_a_kak_oni_ladyat_s_zverem = {
text = [[Эээ... Этого я не знаю. Я сыканул пойти на охоту с остальными, так что не знаю какая там обстановка.]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[Понятно.]],
next = "d_ponyatno",
},
},
},
d_sudba_ploho = {
text = [[Судьба плохо обходится с умными, брат...]],
speaker = [[Голова подначка]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_tak_ty_verneshsya_domoj = {
text = [[Да, и только благодаря тебе. У меня кстати есть вопрос: какая цель была у твоего перформанса?]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Высвобождение.]],
next = "d_vysvobozhdenie",
},
},
},
d_tak_chto = {
text = [[Ааргъх... Это какое-то пиво. Позаимствовал у людей.]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
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
d_tak_eto_ty_smozhesh_vydat_novoe_predskazanie = {
text = [[Только с шаром. Без шара никак! Давай ты его починишь! Я слышал, что люди хорошо мастерят, так давай же!]],
speaker = [[Крип Предвестник Апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[Я попробую.]],
next = "d_ya_poprobuu",
actions = {
{ itemName="item_broken_crystal_ball",type="give_item" },
},
},
},
},
d_takto_da = {
text = [[ЧЕМ СЛОЖНЕЕ БИТВА, ТЕМ ВЕСЕЛЕЕ.]],
speaker = [[Воин Эпштейна]],
npc = "npc_island_guard",
choices = {
{
text = [[И не поспоришь.]],
next = nil,
actions = {
{ target="kill",type="fight_start" },
},
},
},
},
d_te_navernoe_kak_raz_zherty_epshtejna_da = {
text = [[ДА.]],
speaker = [[Воин Эпштейна]],
npc = "npc_island_guard",
choices = {
{
text = [[У тебя есть ключ от клетки?]],
next = "d_u_tebya_est_kluch_ot_kletki",
},
},
},
d_tebya_zovut_aleks = {
text = [[Алекс... Алекс?]],
speaker = [[Боб]],
npc = "npc_creep_bob",
choices = {
{
text = [[Да.]],
next = "d_i8",
},
},
},
d_tebya_zovut_bob = {
text = [[Боб... Точно! Спасибо!!]],
speaker = [[Боб]],
npc = "npc_creep_bob",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_tebya_zovut_dzhon = {
text = [[Джон... Джон?]],
speaker = [[Боб]],
npc = "npc_creep_bob",
choices = {
{
text = [[Да.]],
next = "d_i8",
},
},
},
d_tebya_ischet_otets_vozvraschajsya_domoj = {
text = [[ТЫ ЧЁ, ЕБЛАН? ХАХАХА, КАКОЙ ОТЕЦ???]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Ты знаешь о ком я говорю. Он ждёт, когда ты воссоединишься с ним и своими братьями.]],
next = "d_ty_znaesh_o_kom_ya_govoru_on_zhdet_kogda_ty_vossoedinishsya_s_nim_i_svoimi_bratyami",
},
},
},
d_tiho_k_chemu_voobsche_eta_istoriya = {
text = [[А к тому, что брат захотел нас отблагодарить за спасение... Вот...]],
speaker = [[Голова подначка]],
npc = "npc_ogre_magi",
choices = {
{
text = [[...]],
next = "d_hot_my_i_starshe",
},
},
},
d_to_est_korol_chmo = {
text = [[ЧЁ СКАЗАЛ? Радуйся последним минутам, пока у тебя есть зубы.]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[*Встать в боевую стойку.*]],
next = "d_j",
},
},
},
d_to_est_ya_ne_smogu_vernutsya = {
text = [[Отсюда нет выхода, так что можешь считать это своей новой жизнью.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[...]],
next = "d_h3",
},
},
},
d_togda_zachem_s_nim_svyazyvatsya = {
text = [[Он - немезис людского рода.]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[...]],
next = "d_i3",
},
},
},
d_ty_ved_krasnyj = {
text = [[МОЖЕТ БЫТЬ, А ТЕБЕ ЧТО НАДО, СОПЛЯЧОК?]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[Тебя ищет отец, возвращайся домой.]],
next = "d_tebya_ischet_otets_vozvraschajsya_domoj",
},
},
},
d_ty_ved_obeschal_otdat_mantiu_im = {
text = [[Верно, но я поддался искушению. Поверь, моим братьям Мантия будет только во вред.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[А почему ты не вернёшься домой?]],
next = "d_a_pochemu_ty_ne_verneshsya_domoj",
},
},
},
d_ty_zh_govoril_chto_ona_pustaya = {
text = [[*Некоторое время он всё ещё был зол, однако, вспомнив причину пьянства, начал плакать.*]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[Просто так до такой степени не напиваются. Что не так?]],
next = "d_prosto_tak_do_takoj_stepeni_ne_napivautsya_chto_ne_tak",
},
},
},
d_ty_zhe_ponimaesh_chto_ya_ne_ujdu = {
text = [[Да. Упёртость - удел недалёких. Я понимал, что без драки не обойдётся.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[...]],
next = "d_m3",
},
},
},
d_ty_znaesh_kak_ya_suda_popal = {
text = [[Да, ты умер будучи человеком.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
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
text = [[ААААА, ТО ЕСТЬ У МЕНЯ ЕЩЁ И БРАТЬЯ ЕСТЬ, ВО ПРИКОЛ.]],
speaker = [[Красный]],
npc = "npc_red",
choices = {
{
text = [[...]],
next = "d_a10",
},
},
},
d_ty_pervyj_krip_chto_upomyanul_korolya_chto_tebe_o_nem_izvestno = {
text = [[Ааа... О нём мало знаю. Мне кажется когда-то я его даже видел... Или нет?.. Вроде кто-то напал на него. Но когда?]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[Хорошо. Я помогу тебе.]],
next = "d_j10",
actions = {
{ questID="q_pandas",type="quest_start" },
},
},
{
text = [[Понятно. Удачи тебе в поисках.]],
next = "d_j11",
actions = {
{ questID="q_pandas",type="quest_reject" },
},
},
},
},
d_ty_skazala_chto_ludej_malo_pochemu = {
text = [[*Лицо девушки застыло. Опомнившись, она отвела взгляд.*]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Забудь.]],
next = "d_h6",
},
},
},
d_ty_sluchajno_ne_ogrgromila = {
text = [[Да, это я.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[Меня послал твой брат... Или точнее братья.]],
next = "d_menya_poslal_tvoj_brat_ili_tochnee_bratya",
},
},
},
d_ty_upomyanul_alhimiu_razve_ona_suschestvuet = {
text = [[Отличный вопрос! Вообще нет, однако в этом мире правила другие. Сначала я испугался смерти, однако, увидев что происходит тут, просто расцвёл! Куча загадок требует ответов.]],
speaker = [[Человек-учёный]],
npc = "npc_scientist",
choices = {
{
text = [[...]],
next = "d_p",
},
},
},
d_ty_chelovek_ili_krip = {
text = [[Эу, крип это твоя мама. Я царь здесь понял?]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
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
d_u_tebya_est_kluch_ot_kletki = {
text = [[ЕСТЬ.]],
speaker = [[Воин Эпштейна]],
npc = "npc_island_guard",
choices = {
{
text = [[Ну и хорошо.]],
next = "d_nu_i_horosho",
},
},
},
d_umeret = {
text = [[]],
speaker = [[Человек-хранитель]],
npc = "npc_templar_assasin",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_uhodi_i_bolshe_nikogda_ne_poyavlyajsya_zdes = {
text = [[Спасибо. Никогда не забуду твоего милосердия. Извини, что пришлось разбираться со всем этим.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[...]],
next = "d_m6",
actions = {
{ npc="npc_ogre_bruiser",type="remove" },
},
},
},
},
d_hm__1 = {
text = [[Защити мои постройки. Разрушь его. Таково задание. Берешься?]],
speaker = [[Синий Принц]],
npc = "npc_blue_prince",
choices = {
{
text = [[Да.]],
next = "d_i9",
actions = {
{ questID="q_clash_royale",type="quest_start" },
{ door="door_clash_royale",type="open_door" },
},
},
{
text = [[Не хочу.]],
next = "d_ne_hochu",
actions = {
{ questID="q_clash_royale",type="quest_reject" },
},
},
},
},
d_hm__2 = {
text = [[*Вдруг ты услышал голос внутри себя. Ты начал непроизвольно повторять.*]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[Z - это самость, а самость - это Z.]],
next = "d_z_eto_samost_a_samost_eto_z",
actions = {
{ var="knows_village_password",value=true,type="set_var" },
},
},
},
},
d_hmm = {
text = [[*Нужно найти кого-то, кто выглядит умным...*]],
speaker = [[Человек-хранитель]],
npc = "npc_templar_assasin",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_hmmm = {
text = [[*Из ниоткуда разнёсся мягкий голос.*
Добро пожаловать на мой остров! Как тебя зовут?]],
speaker = [[???]],
npc = nil,
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
d_hot_my_i_starshe = {
text = [[Хоть мы и старше, он сказал, что мы глуповаты. Думаю, он не прав.]],
speaker = [[Голова умнотуп]],
npc = "npc_ogre_magi",
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
d_hotya_kuda = {
text = [[Хотя куда умнее то!]],
speaker = [[Голова подначка]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Что за Мантия?]],
next = "d_chto_za_mantiya",
},
},
},
d_tsenoj_svoej_zhizni_on_spas_poselenie_dobryh_kripov = {
text = [[*Все четыре глаза поочерёдно заслезились.*]],
speaker = [[Крип-сиамский огр]],
npc = "npc_ogre_magi",
choices = {
{
text = [[*Уйти.*]],
next = "d_m8",
actions = {
{ questID="q_ogres",type="quest_end" },
},
},
},
},
d_tsmka_gde = {
text = [[Сейчас она придёт, пока можешь отдохнуть.]],
speaker = [[Эпштейн]],
npc = nil,
choices = {
{
text = [[Откуда ты вообще говоришь?]],
next = "d_otkuda_ty_voobsche_govorish",
},
},
},
d_ch_chto = {
text = [[]],
speaker = [[Скул Шутер]],
npc = "npc_sniper",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_chego_usatyj = {
text = [[Что слышал. Я не хочу видеть, чтобы кто-то ещё пал от его руки.]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[Я умею драться так-то.]],
next = "d_ne_ponyal",
},
},
},
d_chego = {
text = [[ЖЕРТВА ПЕРВОГО ДАЛА ПАДШИМ НАДЕЖДУ.]],
speaker = [[???]],
npc = "npc_tormentor",
choices = {
{
text = [[Откуда ты это сказал?]],
next = "d_otkuda_ty_eto_skazal",
},
},
},
d_chto_velikogo_on_sovershil = {
text = [[Он... эм... *Она задумалась.* Много всего...]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Много чего?]],
next = "d_mnogo_chego",
},
},
},
d_chto_za_korol = {
text = [[*Девушка покраснела*
Король... Его зовут Джордж. Джордж Богоподобный. Он лучший человек... Идеальный во всём.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Что великого он совершил?]],
next = "d_chto_velikogo_on_sovershil",
},
},
},
d_chto_za_mantiya = {
text = [[Любой, кто наденет её, станет самым умным в мире!]],
speaker = [[Голова умнотуп]],
npc = "npc_ogre_magi",
choices = {
{
text = [[А куда он отправился?]],
next = "d_a_kuda_on_otpravilsya",
},
},
},
d_chto_za_portal_szadi = {
text = [[Никто не знает. Он не работает.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Понятно.]],
next = "d_h6",
},
},
},
d_chto_za_predelami_korolevstva = {
text = [[На западе - Заброшенный лес. Там проживают дикие крипы.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[*Далее.*]],
next = "d_h8",
},
},
},
d_chto_znachit_v_odin_moment_kak_eto_voobsche_proishodit = {
text = [[Ох, точно! Я же не объяснил как направлять эту силу. Видишь около себя разноцветную консистенцию? После затвердевания из неё получются Философские камни, которые как раз и делают все преобразования в считанные секунды!]],
speaker = [[Человек-учёный]],
npc = "npc_scientist",
choices = {
{
text = [[Понятно.]],
next = "d_p2",
},
{
text = [[А из чего эта жижа состоит?]],
next = "d_a_iz_chego_eta_zhizha_sostoit",
},
},
},
d_chto_pesh = {
text = [[*Панда плюнула в твою сторону, но не попала.*]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[Это было необязательно. Так что пьёшь то?]],
next = "d_a2",
},
},
},
d_chto_tut_za_kontsert = {
text = [[Он ещё не начался. Приходи позже. И не забудь билет.]],
speaker = [[Крип-вышибала]],
npc = "npc_concert_guard",
choices = {
{
text = [[А кто выступает то?]],
next = "d_a_kto_vystupaet_to",
},
},
},
d_chto_ty_takoe = {
text = [[Те, что с разумом. Способны ли постичь непостижимое?]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[Ээ?]],
next = "d_ee",
},
},
},
d_chtoto_ne_tak = {
text = [[Скрытая деревня имеет много тайн. Я дала обет, что буду защищать их от чужих глаз. Уходи, если дорога жизнь.]],
speaker = [[Человек-хранитель]],
npc = "npc_templar_assasin",
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
d_chto = {
text = [[*Свет в его глазах угасает.*]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[...]],
next = "d_m5",
},
},
},
d_chto__1 = {
text = [[Путник, ты попал в наши земли не просто так. У тебя есть миссия, Королевству нужен заступник.]],
speaker = [[Старушка]],
npc = "npc_shamanka",
choices = {
{
text = [[Я умер пару минут назад, если что.]],
next = "d_ya_umer_paru_minut_nazad_esli_chto",
},
},
},
d_che_ty_krichish = {
text = [[Вижу по твоим глазам, ты как я! Хочешь испытаний, хочешь проверить себя!]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[Да!]],
next = "d_da",
},
{
text = [[Не, я просто заблудился.]],
next = "d_i4",
},
},
},
d_eto_zachem = {
text = [[Я способна пробуждать скрытые возможности тела человека. Коснись меня и твоя истинная форма проявится.]],
speaker = [[Старушка]],
npc = "npc_shamanka",
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
d_eto_kak = {
text = [[Чтобы что-то получить, тебе нужно что-то равноценное. Словами тяжело объяснить, потому давай примером.]],
speaker = [[Человек-учёный]],
npc = "npc_scientist",
choices = {
{
text = [[...]],
next = "d_p1",
},
},
},
d_eto_svyazano_s_mantiej = {
text = [[Да.]],
speaker = [[Огр-громила]],
npc = "npc_ogre_bruiser",
choices = {
{
text = [[...]],
next = "d_m",
},
},
},
d_eto_sleva = {
text = [[Ого! Люди всё-таки тоже могут думать. Ваух!]],
speaker = [[Голова подначка]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Вообщем Заброшенный лес.]],
next = "d_l15",
},
},
},
d_eto_horosho_po_puti_prihvachu = {
text = [[Только ты поделишься с мной, ммм...]],
speaker = [[Крип-камыш]],
npc = "npc_rape_victim",
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
d_eh = {
text = [[Смотри! Этот паренёк вообще как спичка! Давай проведём им по шершавому!]],
speaker = [[Голова подначка]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Не нужно, поверьте.]],
next = "d_ne_nuzhno_poverte",
},
},
},
d_ee = {
text = [[Бог или Наука?]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[Бог.]],
next = "d_bog",
},
{
text = [[Наука.]],
next = "d_nauka",
},
},
},
d_eej_alo = {
text = [[*Крип отпрыгнул.*
Мммм... Человеческое дитя, видать тебя послали из Королевства помочь мне?]],
speaker = [[Раздраженный крип]],
npc = "npc_predvestnik",
choices = {
{
text = [[Не, я пришёл узнать новое предсказание.]],
next = "d_ne_ya_prishel_uznat_novoe_predskazanie",
},
},
},
d_ya_aleks_voobscheto = {
text = [[Разве? Прости меня, перепутал немного. Некрасиво получилось, да...]],
speaker = [[Крип-рогач]],
npc = "npc_creep_rogach",
choices = {
{
text = [[Бывает.]],
next = "d_i",
},
},
},
d_ya_b_tak_zhe_sdelal = {
text = [[Что?! Н.. но зачем. Это же порча священного имущества. Тебя могут покарать те, кто сверху!]],
speaker = [[Крип Предвестник Апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[Типо прикольно. А чем шар ценен то?]],
next = "d_o8",
},
},
},
d_ya_voobsche_ne_pomnu = {
text = [[Я вообще не помню, чтоб ты что-то делал. Значит ты этого не делал!]],
speaker = [[Голова умнотуп]],
npc = "npc_ogre_magi",
choices = {
{
text = [[Тихо, к чему вообще эта история?]],
next = "d_tiho_k_chemu_voobsche_eta_istoriya",
},
},
},
d_ya_gotov = {
text = [[Выходи один на один, уёбок.]],
speaker = [[Быдло]],
npc = "npc_monkey_king",
choices = {
{
text = [[Начнём.]],
next = nil,
actions = {
{ target="talk",npc="npc_monkey_king",type="fight_start" },
},
},
},
},
d_ya_koroch_poshel = {
text = [[Стой! Мы просим твою помощь. Брат наш, Огр-громила, ПОТЕРЯЛСЯ!]],
speaker = [[Голова подначка]],
npc = "npc_ogre_magi",
choices = {
{
text = [[...]],
next = "d_ischez_s_radarov",
},
},
},
d_ya_poprobuu = {
text = [[*Надо взять осколки и каким-то способом починить шар. Но тут всё в крошку, смогу ли я найти искусного мастера?*]],
speaker = [[Крип Предвестник Апокалипсиса]],
npc = "npc_predvestnik",
choices = {
{
text = [[*Придётся что-то придумать.*]],
next = "d_pridetsya_chtoto_pridumat",
},
},
},
d_ya_slyshu_chto_pivo_esche_est = {
text = [[Неа.]],
speaker = [[Пьяная панда]],
npc = "npc_brewmaster",
choices = {
{
text = [[Жмот.]],
next = "d_zhmot",
},
},
},
d_ya_togda_tozhe_budu = {
text = [[МОЛОДЧИНА!]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_ya_ubil_ih = {
text = [[Это отличная новость! Мы не могли обеспечить защиту этих врат, так как нас, людей, осталось единицы.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[А крипы это кто?]],
next = "d_a_kripy_eto_kto",
},
},
},
d_ya_umer_paru_minut_nazad_esli_chto = {
text = [[*Проигноривовав твои слова, она протягивает руку и чего-то ждёт. Ты чувствуешь, как её потрясывает.*]],
speaker = [[Старушка]],
npc = "npc_shamanka",
choices = {
{
text = [[Это зачем?]],
next = "d_eto_zachem",
},
},
},
d_concertbouncerpass = {
text = [[]],
speaker = [[default]],
npc = nil,
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_diefromgreen2 = {
text = [[]],
speaker = [[default]],
npc = nil,
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_a_kem = {
text = [[*Им*]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[...]],
next = "d_b",
},
},
},
d_v_chem_zhe_ya_oshibsya = {
text = [[]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_vzyat_nagradu = {
text = [[Вот тебе следующее задание: собери все части ключа и почини с помощью алхимиков. После, возвращайся ко мне и всё обдумаем.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Ну ладно.]],
next = "d_nu_ladno",
actions = {
{ questID="q_main_quest_act_3",type="quest_start" },
},
},
},
},
d_vletet_v_nego = {
text = [[]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_vlozhit_vse_svoi_usiliya = {
text = [[Я выпустил магнитный заряд, но он был очень слабым, ведь птица не заслуживает смерти. Однако я могу менять силу импульса.]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[А?]],
next = "d_a__1",
},
},
},
d_vybor_linii_povedeniya_provokatsiya = {
text = [[*Ему на голову села небольшая птица. Издав импульс неизвестного происхождения, он пугает её, отчего та улетает.*]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Зря ты это сделал.]],
next = "d_d4",
},
},
},
d_vybor_linii_povedeniya_fizicheskaya_sila = {
text = [[*Ему на голову села небольшая птица. Издав импульс неизвестного происхождения, он пугает птицу, отчего та улетает.*]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[*Пока он отвлёкся, забежать ему за спину.*]],
next = "d_poka_on_otvleksya_zabezhat_emu_za_spinu",
},
},
},
d_dat_emu_schelban = {
text = [[*Раздался звонкий звук, слышный на всё королевство. Спустя мгновение раздался уже глухой звук. И он явно был совершён не тобой.*]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[*А кем?*]],
next = "d_a_kem",
},
},
},
d_zamahnutsya_so_vsej_sily = {
text = [[]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_nachat_tyanut_esche_silnee = {
text = [[Что ты делаешь?]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Раз ты не хочешь идти со мной, я просто понесу тебя.]],
next = "d_raz_ty_ne_hochesh_idti_so_mnoj_ya_prosto_ponesu_tebya",
},
},
},
d_obernut_svoi_nogi_vokrug_nego_i_nachat_tyanut_vesom_tela = {
text = [[Тщетные попытки, думаю на этом хватит.]],
speaker = [[Зелёный]],
npc = "npc_green",
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
d_otdat_bilet = {
text = [[Проходи.]],
speaker = [[Крип-вышибала]],
npc = "npc_concert_guard",
choices = {
{
text = [[Ура. ]],
next = nil,
actions = {
{ itemName="item_concert_ticket",type="take_item" },
{ var="has_concert_pass",value=true,type="set_var" },
{ door="door_concert",type="open_door" },
},
},
},
},
d_otojti_na_bezopasnoe_rasstoyanie = {
text = [[*Повисла тишина.*]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Если хочешь убедиться, то проведи рукой по голове.]],
next = "d_esli_hochesh_ubeditsya_to_provedi_rukoj_po_golove",
},
},
},
d_poka_on_otvleksya_zabezhat_emu_za_spinu = {
text = [[*Ты обхватываешь его сзади и начинаешь тянуть, словно репку.*]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[*Начать тянуть ещё сильнее.*]],
next = "d_nachat_tyanut_esche_silnee",
},
},
},
d_pokazat_zhopu = {
text = [[Невероятно!]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[Согласен.]],
next = "d_q5",
},
},
},
d_pomahat_biletom = {
text = [[Ооооо, тогда увидимся там!]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Пока.]],
next = nil,
actions = {
{ npc="npc_dream",type="remove" },
{ spawn="spawner_dream_concert",type="spawn" },
},
},
},
},
d_poteret_emu_nosik = {
text = [[*Подойдя поближе ты замечаешь, что его нос уже сверкает золотом. Подобное желание приходило в голову явно многим. Ты начинаешь тереть его нос. Он всё ещё неподвижно наблюдает, но, опустив брови, его взгляд становится более сердитым.*]],
speaker = [[Зелёный]],
npc = "npc_green",
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
d_pohozhe_gdeto_v_skrytoj_derevne = {
text = [[*Есть шанс, что этот Глава прояснит некоторые вещи.*]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_pohozhe_do_nih_vse_esche_ne_doshlo = {
text = [[*Начался хаос. Все начали избивать друг друга. Ты решил не оставаться в стороне.*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[*Сорваться с цепи.*]],
next = nil,
actions = {
{ var="concert_crowd_met",value=true,type="set_var" },
{ pack="pack_concert_crowd",type="fight_start" },
},
},
},
},
d_prekratit = {
text = [[Разумное решение, ты был в моменте от гибели.]],
speaker = [[Зелёный]],
npc = "npc_green",
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
d_sorvatsya_s_tsepi = {
text = [[]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_stop_esli_on_zdes_neuzhto = {
text = [[*Да... Xavier умер как и ты. Однако эта мысль, наоборот, успокивает тебя, ведь ты можешь жить с ним бок о бок столько, сколько хочешь.*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[ДА.]],
next = "d_da__2",
},
},
},
d_tebya_probivaet_na_slezu_ot_voshischeniya = {
text = [[Однако мне неоткуда черпать инфу, как таким стать. В Королевстве никто не знает о тонкостях их жизни.]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Я могу тебе как-нибудь помочь?]],
next = "d_ya_mogu_tebe_kaknibud_pomoch",
},
},
},
d_ty_zabiraesh_bilety = {
text = [[Приятно иметь с вами дело, молодой человек.]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Взаимно.]],
next = "d_vzaimno",
actions = {
{ var="perekup_good_ending",value=true,type="set_var" },
},
},
{
text = [[*Всё равно избить его.*]],
next = "d_l2",
},
},
},
d_ujti_s_pozorom = {
text = [[*Ты уходишь с позором.*]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_0_monet = {
text = [[0 монет!!!]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[ПОКУПАЮ!]],
next = "d_pokupau",
},
},
},
d_1_moneta = {
text = [[6 монет!]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[3 монеты!]],
next = "d_3_monety",
},
},
},
d_2_monety = {
text = [[3 монеты!]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[1 монета!]],
next = "d_l",
},
},
},
d_3_monety = {
text = [[5 монет!]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[2 монеты!]],
next = "d_2_monety",
},
},
},
d_7_monet_po_420_eto_2940_a_bilety_stoyat_50_ne_shoditsya = {
text = [[Так... Так.. Так я шёл тебе на компромиссы! Изначальная цена была гораздо больше!]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Тогда предлагаю торг.]],
next = "d_togda_predlagau_torg",
},
},
},
d_b = {
text = [[Неуважение.]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Упс...]],
next = nil,
actions = {
{ attacker="npc_green",type="die" },
},
},
},
},
d_bouncerhaveticket = {
text = [[Билет.]],
speaker = [[Крип-вышибала]],
npc = "npc_concert_guard",
choices = {
{
text = [[*Отдать билет.*]],
next = "d_otdat_bilet",
},
},
},
d_bouncernoticket = {
text = [[Билет.]],
speaker = [[Крип-вышибала]],
npc = "npc_concert_guard",
choices = {
{
text = [[У меня нету.]],
next = "d_u_menya_netu",
},
},
},
d_d = {
text = [[*Зелёный показывает явное безразличие.*]],
speaker = [[Зелёный]],
npc = "npc_green",
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
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[*Выбор линии поведения - провокация*]],
next = "d_d3",
},
},
},
d_d3 = {
text = [[Слабость.]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Помнишь ту птицу? Зря ты её спугнул.]],
next = "d_d4",
},
},
},
d_d4 = {
text = [[Почему?]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Она оставила тебе подарок - белое пятно на твоей макушке.]],
next = "d_ona_ostavila_tebe_podarok_beloe_pyatno_na_tvoej_makushke",
},
},
},
d_d5 = {
text = [[Твои действия показали мой слабый характер. С этого момента я буду более осознанным и осведомлённым.]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Хорош.]],
next = "d_horosh",
},
},
},
d_diefromgreen = {
text = [[]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_dreamafterquestgive = {
text = [[Он в Коралловом лесу. Надеюсь у тебя получится!]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_dreamafterreject = {
text = [[О... Ты что-то придумал?]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Я тебе подсоблю.]],
next = "d_j4",
actions = {
{ questID="q_concert",type="quest_start" },
},
},
{
text = [[Ещё нет.]],
next = "d_j3",
},
},
},
d_dreamfirstmet = {
text = [[Эй, приветствую мой хоуми.]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[И тебе привет.]],
next = "d_i_tebe_privet",
},
},
},
d_dreamonconcert = {
text = [[*Он пристально смотрит на сцену. Ничто не способно отвлечь его.*]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_dreamturnin = {
text = [[Вазап, броу! Как дела?]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Вот твой билет, черномазый.]],
next = "d_vot_tvoj_bilet_chernomazyj",
actions = {
{ itemName="item_concert_ticket",type="take_item" },
},
},
},
},
d_dreamturninbye = {
text = [[]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_e = {
text = [[Даже если это правда, я не подчинюсь существу слабее меня.]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Здесь дело не в том, кто сильнее или слабее. Просто у тебя на голове насрано.]],
next = "d_zdes_delo_ne_v_tom_kto_silnee_ili_slabee_prosto_u_tebya_na_golove_nasrano",
},
},
},
d_epskillers = {
text = [[Ты! Не двигаться.
*Тебя окликает неизвестное существо.*]],
speaker = [[Убийца]],
npc = "npc_killer",
choices = {
{
text = [[Чего тебе?]],
next = "d_chego_tebe",
},
},
},
d_epskillersagain = {
text = [[Эпштейн передаёт тебе привет.]],
speaker = [[Убийца]],
npc = "npc_killer",
choices = {
{
text = [[Бля.]],
next = nil,
actions = {
{ target="kill",npc="npc_killer",type="fight_start" },
},
},
},
},
d_f = {
text = [[В первом ты преуспел, теперь пришло время показать силу. Если одним ударом ты сможешь заставить меня шелохнуться, так уж и быть - исполню твоё желание. Вложи всю силу в удар.]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[*Замахнуться со всей силы.*]],
next = nil,
actions = {
{ type="green_test_start" },
},
},
},
},
d_fairytale = {
text = [[Послушай мой рассказ.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[Это надолго?]],
next = "d_eto_nadolgo",
},
},
},
d_fairytaleagain = {
text = [[*Не стоит его беспокоить.*]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_geniusfightagain = {
text = [[Ты должен умереть во благо всему.]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[Не хочу как-то.]],
next = nil,
actions = {
{ target="kill",npc="npc_genius",type="fight_start" },
},
},
},
},
d_geniusfirstmet = {
text = [[Кто впустил сюда этого неуча?
*Ехидно произнёс крип.*]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[А тебе что?]],
next = "d_a_tebe_chto",
},
},
},
d_greenclosewin = {
text = [[]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_greenfightagain = {
text = [[Вложи всю силу в удар.]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[*Замахнуться со всей силы.*]],
next = nil,
actions = {
{ type="green_test_start" },
},
},
},
},
d_greenfirstmet = {
text = [[*Существо зелёного цвета стоит, соединив руки перед собой. Ощущается будто бы он прирос к земле.*]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Ты живой?]],
next = "d_ty_zhivoj",
},
},
},
d_greenlose = {
text = [[Тебе следует поменять название приёма. Это больше смахивает на кулак, дрочащий хуи. Развивайся и приходи ещё.]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[*Уйти с позором.*]],
next = "d_ujti_s_pozorom",
},
},
},
d_greenwin = {
text = [[Невероятная сила...]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Внешка не важна, понимаешь? Сила внутри.]],
next = "d_vneshka_ne_vazhna_ponimaesh_sila_vnutri",
},
},
},
d_guideact2 = {
text = [[Как же хорошо в Королевсте.]],
speaker = [[Человек-гид]],
npc = "npc_guide",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_hermitagain = {
text = [[Первую часть я отдал старушке-медиуму, вторую - спрятал на соседней Снежной горе, а третью - скормил самому могучему крипу Искажённого леса.]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_hermitfirstmet = {
text = [[*Одинокий человек угрюмо смотрит на сверкающий от солнца снег.*]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Это ты, тот выживший, что смог сбежать от Зверя?]],
next = "d_eto_ty_tot_vyzhivshij_chto_smog_sbezhat_ot_zverya",
},
},
},
d_hermitigetit = {
text = [[Эти места были выбраны не просто так. Только человек с крепким телом и духом сможет заполучить их все. Только сильнейшему дозволено распоряжаться тем, как использовать этот ключ.]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Я готов.]],
next = "d_hermitimready",
},
},
},
d_hermitimready = {
text = [[*Он кивнул.*]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Кстати, есть ли у Зверя какие-то слабости?]],
next = "d_kstati_est_li_u_zverya_kakieto_slabosti",
},
},
},
d_j2 = {
text = [[Однако мне не попасть туда...]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Как так?]],
next = "d_kak_tak",
},
},
},
d_j3 = {
text = [[Ну... ладно...]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_j4 = {
text = [[Серьёзно?! Но как?]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Есть способ. Скаже где он.]],
next = "d_est_sposob_skazhe_gde_on",
},
},
},
d_k = {
text = [[Эта сказака о двух кроликах, нашедших сад Нефелима.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k1",
},
},
},
d_k1 = {
text = [[Первый кролик имел белоснежную окраску. Он бегал по лесу, как вдруг обнаружил необычайно высокий забор. Будучи крохой, ему не составило труда протиснуться.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k2",
},
},
},
d_k10 = {
text = [[Он был очень ленивым. Узнав о том, что Нефелим может исполнить любое желание, ему пришла в голову интересная идея.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k23",
},
},
},
d_k11 = {
text = [["Жертвую жизнями половины морковок на то, чтобы другая половина начала сама маршировать мне в живот,"- вскрикнул он.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k12",
},
},
},
d_k12 = {
text = [[Больше недели морковки шли в его пасть, оставалось лишь пережёвывать их. Очень рад он был такой жизни.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k13",
},
},
},
d_k13 = {
text = [[Однако случилось непредвиденное. Морковок в саду было нечётное количество. И последняя морковка, не околдаванная чарами Нефелима, осознала, что произошло.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k14",
},
},
},
d_k14 = {
text = [[Захотев спасти сородичей, она подошла к кролику и проткнула его брюхо.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k15",
},
},
},
d_k15 = {
text = [[Вспоров живот, морковка увидела, что спасать уже некого. Слишком поздно.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k16",
},
},
},
d_k16 = {
text = [[Параллельно этому, из-за опустошения полей, взрыхлённая земля обвалилась, засыпав нору, созданную первым кроликом.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k17",
},
},
},
d_k17 = {
text = [[Отныне все звери, попавшие в сад, оставались здесь до конца своих дней. Кто-то веселился, кто-то горевал. Однако все лицезрели истерзанный труп чёрного кролика.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k18",
},
},
},
d_k18 = {
text = [[Это было наказанием, совершённым демонической половиной Нефелима. Она сковала душу чёрного кролика с его мёртвым телом, заставив того постоянно чувствовать боль.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k19",
},
},
},
d_k19 = {
text = [[Навечно.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k24",
},
},
},
d_k2 = {
text = [[Перед его глазами раскинулся серебристый сад. Вокруг были огроменные поля моркови и ручьи кристальной воды. Прекасное место.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k20",
},
},
},
d_k20 = {
text = [[Однако, когда он обернулся, то заметил, что все расщелины в заборе захлопнулись. Кролику отсюда уже не выбраться.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k3",
},
},
},
d_k21 = {
text = [[Кролик быстро осознал, насколько ужасное это место. Он не мог вынести мысли, что кто-то тоже может оказаться в этой ловушке.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k7",
},
},
},
d_k22 = {
text = [[Какое-то время спустя в сады попал и чёрный кролик.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k10",
},
},
},
d_k23 = {
text = [[Позвав его, кролик указал пальцем на обширные поля.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k11",
},
},
},
d_k24 = {
text = [[Навечно...]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[В этом что-то есть.]],
next = "d_v_etom_chtoto_est",
},
},
},
d_k3 = {
text = [[Послышались шаги. Перед ним явился владелец сада - Нефилим. Он произнёс: "Ты - первый, кто смог попасть сюда. Поздравляю."]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k4",
},
},
},
d_k4 = {
text = [[Кролик спросил: "А ты же выпустишь меня обратно?"
Нефилим покачал головой, добавив: "Теперь это - твой дом."]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k5",
},
},
},
d_k5 = {
text = [["Не расстраивайся, я могу исполнить любое твоё желание, однако заплатить придётся чьей-то жизнью. Выбирай кого угодно."]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k6",
},
},
},
d_k6 = {
text = [[Любой другой мог бы быть опьянён таким предложением, но только не он.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k21",
},
},
},
d_k7 = {
text = [[Поэтому, собравшись с духом, кролик произнёс: "Выкопай нору, что позволит любому вошедшему вернуться домой. Моей жизни должно быть достаточно."]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k8",
},
},
},
d_k8 = {
text = [[Ангельская половина Нефелима была восхищена его решимостью, так что, исполнив желание, одарила кролика безболезненной смертью и упокоила его душу.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k9",
},
},
},
d_k9 = {
text = [[С тех пор любой зверёк, попавший в сад, в скором времени покидал его, возвращаясь в леса.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k22",
},
},
},
d_l = {
text = [[2 монеты!]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[1 монета!]],
next = "d_l1",
},
},
},
d_l1 = {
text = [[1 монета!]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[0 монет!]],
next = "d_0_monet",
},
},
},
d_l2 = {
text = [[*Ты принимаешь агрессивную позу.*]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Каково это скупать билеты, заставляя бедных страдать?]],
next = "d_kakovo_eto_skupat_bilety_zastavlyaya_bednyh_stradat",
},
},
},
d_l3 = {
text = [[Билеты на данный момент по самой большой скидке: всего 500 золота за штуку!]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Дорого.]],
next = "d_dorogo",
},
},
},
d_l4 = {
text = [[*От счастья он запрыгал.*
Спасибо, спасибо!! Ты реально оу джи, кекс! Ты лучший!!]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Хорошо, хорошо. Я кстати тоже пойду.]],
next = "d_horosho_horosho_ya_kstati_tozhe_pojdu",
},
},
},
d_leaderagain1 = {
text = [[Чтобы открыть проход в Коралловый лес, подойди поближе к двери и произнеси заклинание вслух: "Stringus Colllapsus".]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_leaderfirstmet = {
text = [[*Тебя окликает человек в опрятном костюме.*
Здравствуй, Алекс.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Привет.]],
next = "d_leaderhey",
},
},
},
d_leaderhey = {
text = [[Я - Глава Скрытой деревни, а также - нынешний Глава Королевства.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Всмысле, а как же ваш всемилюбимый Король?]],
next = "d_vsmysle_a_kak_zhe_vash_vsemilubimyj_korol",
},
},
},
d_leaderhintclose = {
text = [[]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_leaderpass3 = {
text = [[Заклинание от врат в Искажённый лес: "Logarithmus solvus".]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Понял.]],
next = nil,
},
{
text = [[Я забыл где находятся части ключа...]],
next = "d_ya_zabyl_gde_nahodyatsya_chasti_klucha",
},
},
},
d_leadersecond = {
text = [[С возвращением.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Почему-ты не сказал, что Зверь - это человек?]],
next = "d_pochemuty_ne_skazal_chto_zver_eto_chelovek",
},
},
},
d_mustacheact2 = {
text = [[ОГО, МАЛЕЦ! Ты оказывается не промах.]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[В каком плане?]],
next = "d_v_kakom_plane",
},
},
},
d_mysteryinteract2 = {
text = [[*Это же тот, что был в кратере метеорита.*]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[О чём был наш прошлый разговор?]],
next = "d_o_chem_byl_nash_proshlyj_razgovor",
},
},
},
d_q = {
text = [[Пока он был правителем, жизнь была невероятной! Крипы и люди постоянно развивались и достигали новых высот где только можно: медицина, наука, сельское хозяйство, архитектура... Это была словно утопия.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[...]],
next = "d_q1",
},
},
},
d_q1 = {
text = [[Однако на смену солнцу всегда приходит луна. Однажды явился Зверь и безжалостно расстерзал нашего прекрасного Короля...
*У Главы пошла слеза.*]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[...]],
next = "d_q2",
},
},
},
d_q10 = {
text = [[Какое-то время он смотрел на меня, а после сказал: "Не трать свою жизнь на месть, уходи и оставь меня. Передай остальным, чтобы тоже бросили это дело и продолжили жить."]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[...]],
next = "d_q11",
},
},
},
d_q11 = {
text = [[*Лицо отшельника стало заметно грустнее.*
После, Дерек попросил сделать ещё одну вещь...  А именно: запереть его в древних покоях, что находятся на краю Пустоши.]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[...]],
next = "d_q12",
},
},
},
d_q12 = {
text = [["С ключом делай, что хочешь. Если не сможешь смириться с гибелью товарищей, то возвращайся, и я дам тебе последний бой. Однако, предпочёл бы, чтобы дверь была заперта и забыта. В итоге выбор всё равно за тобой."]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[...]],
next = "d_q13",
},
},
},
d_q13 = {
text = [[После нашего разговора, я не решился вовзращаться в Королевство в одиночку.]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Почему он тебя пощадил?]],
next = "d_pochemu_on_tebya_poschadil",
},
},
},
d_q14 = {
text = [[П-почему выжил именно я?!]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Я не знаю.]],
next = "d_ya_ne_znau",
},
{
text = [[Дерек этого хотел.]],
next = "d_derek_etogo_hotel",
},
},
},
d_q15 = {
text = [[...]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[...]],
next = "d_q17",
},
},
},
d_q16 = {
text = [[*Тишина.*]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[...]],
next = "d_q15",
},
},
},
d_q17 = {
text = [[Знаешь... Спасибо, что пришёл.]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Пожалуйста, наверное...]],
next = "d_pozhalujsta_navernoe",
},
},
},
d_q18 = {
text = [[Только вот я не просто его выбросил... Перед этим, мной было принято решение разломать ключ на три части...]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Эм... Допустим.]],
next = "d_em_dopustim",
},
},
},
d_q19 = {
text = [[Через несколько минут ярость покинула его голову - Зверь снова стал человеком.]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[...]],
next = "d_q10",
},
},
},
d_q2 = {
text = [[Невероятный гнев охватил всех людей, и, собравшись гиганстким войском, они загнали Зверя в Пустошь, дав ему там бой. Но никто не знал...]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[...]],
next = "d_q3",
},
},
},
d_q3 = {
text = [[...что загнанный в угол зверь - самый страшный противник. Почти все полегли. Только один человек смог сбежать, но вместо того, чтобы вернуться в Королевство, он ушёл в Снежные горы. Причину никто так и не знает...]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Думаете этот выживший одолел Зверя?]],
next = "d_dumaete_etot_vyzhivshij_odolel_zverya",
},
},
},
d_q4 = {
text = [[*Крип непонимающе взглянул.*
И что?]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[Эээээ...]],
next = "d_q5",
},
},
},
d_q5 = {
text = [[Прекращай этот фарс и, наконец, продемонстрируй развитость своего ума. Я позволю тебе решить задачку, к которой сам всё ещё не смог подступиться. Посмотрим, чего ты стоишь.]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[Ладно давай.]],
next = "d_ladno_davaj",
},
},
},
d_q6 = {
text = [[*Крип вздохнул с грустью.*
Зачем я пошёл на поводу у крестьянина и потратил столько драгоценного времени...]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[Это неправильный ответ?]],
next = "d_eto_nepravilnyj_otvet",
},
},
},
d_q7 = {
text = [[*Крип замер. По его глазам видно, как он перебирает кучу вариантов и пытается найти просчёт в твоих исчислениях.*
Ты...]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[Поражён умом свинопаса?]],
next = "d_porazhen_umom_svinopasa",
},
},
},
d_q8 = {
text = [[Израненный Дерек, словно демон, выискивал нас по одному и цеплялся когтями, пока сердце жертвы не переставало стучать... С каждым ранением он становился жестчё и беспощаднее. Даже толпой у нас не было шансов...]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Дерек? Зверь - это человек?]],
next = "d_derek_zver_eto_chelovek",
},
},
},
d_q9 = {
text = [[Я продолжу... 
Мои пятки были в крови и я просто застыл, однако Дерек не спешил нападать. Он... он просто остановился, начав глубоко дышать... Вдох... Выдох... Вдох.]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[...]],
next = "d_q19",
},
},
},
d_r = {
text = [[Отличная работа.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[*Взять награду.*]],
next = "d_vzyat_nagradu",
actions = {
{ questID="q_main_quest_act_2",type="quest_end" },
},
},
},
},
d_r1 = {
text = [[Мы с тобой - два человека, которые жили и умерли на Земле, но по какой-то причине нам позволили остаться здесь. Так почему бы не сделать этот мир лучшим местом и не насладиться последними мгновениями жизни, что нам даровали?]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[И вправду...]],
next = "d_i_vpravdu",
},
{
text = [[Мне без разницы как-то.]],
next = "d_mne_bez_raznitsy_kakto",
},
},
},
d_r2 = {
text = [[Если бы ты знал, что это насекомое - человек, то смог бы так просто убить его?]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[При встречи с Дереком я бы так и так понял, что он не животное.]],
next = "d_pri_vstrechi_s_derekom_ya_by_tak_i_tak_ponyal_chto_on_ne_zhivotnoe",
},
},
},
d_r3 = {
text = [[Ступай же и соверши предначертанное. Пусть тяжесть его греха обернется невыносимым бременем расплаты.]],
speaker = [[Старушка]],
npc = "npc_shamanka",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_rogachact2 = {
text = [[Вау братишка, ты прям размазал эту гориллу!]],
speaker = [[Крип-рогач]],
npc = "npc_creep_rogach",
choices = {
{
text = [[Было дело.]],
next = "d_bylo_delo",
},
},
},
d_seller1 = {
text = [[*Солидный человек с прямой спиной улыбчиво тебя приветствует.*]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Билеты на концерт. Это же ты их продаёшь?]],
next = "d_bilety_na_kontsert_eto_zhe_ty_ih_prodaesh",
},
},
},
d_sellerfightagain = {
text = [[*Чувствуя твою агрессию, перекуп начинает обороняться.*]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[*Влететь в него.*]],
next = nil,
actions = {
{ target="kill",npc="npc_perekup",type="fight_start" },
},
},
},
},
d_sellernofight = {
text = [[Приходите ещё!]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_sellernoquest = {
text = [[Что-то ищете, молодой человек?]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Нет, просто гуляю.]],
next = "d_net_prosto_gulyau",
},
},
},
d_shamankaact2questactive = {
text = [[Чувствую как ты стал сильнее, молодец. Одолел уже грешника?]],
speaker = [[Старушка]],
npc = "npc_shamanka",
choices = {
{
text = [[Почему вы дали мне часть ключа?]],
next = "d_pochemu_vy_dali_mne_chast_klucha",
},
},
},
d_shamankaact2questcomplete = {
text = [[Чувствую как ты стал сильнее, молодец. Одолел уже грешника?]],
speaker = [[Старушка]],
npc = "npc_shamanka",
choices = {
{
text = [[Почему вы дали мне часть ключа?]],
next = "d_pochemu_vy_dali_mne_chast_klucha",
},
},
},
d_whereisleader = {
text = [[*Существо исчезает.*]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[*Похоже где-то в Скрытой деревне.*]],
next = "d_pohozhe_gdeto_v_skrytoj_derevne",
},
},
},
d_xavierafterfight = {
text = [[*Xavier notices your devotion.*
That was dope, you're feeling me, yeah]],
speaker = [[xaviersobased]],
npc = "npc_xavier",
choices = {
{
text = [[Реально?! Я очень рад.]],
next = "d_realno_ya_ochen_rad",
},
},
},
d_xavieragain = {
text = [[*Ты не можешь отовать глаз. Это слишком прекрасно.*]],
speaker = [[xaviersobased]],
npc = "npc_xavier",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_xavierfightagain = {
text = [[*Начался хаос. Все начали избивать друг друга. Ты решил не оставаться в стороне.*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[*Сорваться с цепи.*]],
next = nil,
actions = {
{ target="kill",type="fight_start" },
},
},
},
},
d_xavierstart = {
text = [[*Ты не веришь своим глазам. Это же Xavier. Настоящий.*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[ЧТО?!]],
next = "d_chto__2",
},
},
},
d_xavieryes = {
text = [[You proved yourself for real like, um... like youre my hood-bro now. I'm glad that... that I can continue my work here, yeah.]],
speaker = [[xaviersobased]],
npc = "npc_xavier",
choices = {
{
text = [[Конечно, мой GOAT.]],
next = "d_konechno_moj_goat",
},
},
},
d_a_zachem_on_pozvolil_zaperet_sebya = {
text = [[*Взгляд отшельника застыл.*
Я не знаю.]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[И что ты собираешься делать?]],
next = "d_i_chto_ty_sobiraeshsya_delat",
},
},
},
d_a_zachem_tebe = {
text = [[Тут неподалёку есть гетто, но там все живут по понятиям, а я ничего не знаю... Даже говорить с ними боюсь, ведь у них свой диалект какой-то...]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Прийти неподготовленным в гетто так-то опасно.]],
next = "d_prijti_nepodgotovlennym_v_getto_takto_opasno",
},
},
},
d_a_kak_ty_perezhil_s_nim_vstrechu = {
text = [[Я? Когда она ворвалась в Королевство, так сразу с ноги в неё влетел, после чего мы сцепились. Была жёсткая битва! Однако, поняв, что я ей не ровня, просто сбежала в сторону леса.]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[И я её как раз подхватил.]],
next = "d_i_ya_ee_kak_raz_podhvatil",
},
},
},
d_a_tebe_chto = {
text = [[Такой абориген не имеет права разговарить с элитой. Возвращайся в своё село пасти свиней.]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[Ты дебил.]],
next = "d_ty_debil",
},
{
text = [[Чем я тебе не угодил?]],
next = "d_chem_ya_tebe_ne_ugodil",
},
},
},
d_a = {
text = [[Подари же всем нам надежду... Слава Королю.]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_a__1 = {
text = [[*Зелёный выпускает ошеломляющий разряд, отчего ближайшие камни отлетают во все стороны. Впрочем, как и ты. Но для тебя это летальный исход.*]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Умереть. ]],
next = nil,
actions = {
{ attacker="npc_green",type="die" },
},
},
},
},
d_aleks_umret_za_tebya_ty_legenda_ty_m = {
text = [[*Тебя перебил человек из толпы, схватив за плечо.*
Слышь, щегол. Я главный фанат Ксавьера, уяснил?!]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[Съеби.]],
next = "d_sebi",
},
},
},
d_aaaaaharr_arghe_shuufuvuu = {
text = [[*Твоё яростное сердцебиение перебивает его голос, отчего ты не можешь разобрать текст. Хотя ты в любом случае не можешь.*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[*Стоп, если он здесь... Неужто?..*]],
next = "d_stop_esli_on_zdes_neuzhto",
},
},
},
d_aga = {
text = [[Даже тогда, когда я был уверен в правоте оппонента, я старался убедить себя в обратном и шёл на дешёвые прииёмы: угрозы, запугивания и даже избиения.]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[...]],
next = "d_d5",
},
},
},
d_aga_tak_kto_takoj_derek = {
text = [[Предатель, изменник, грешник и просто самый мерзкий человек...]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Зачем ему убивать Короля?]],
next = "d_zachem_emu_ubivat_korolya",
},
},
},
d_bilety_na_kontsert_eto_zhe_ty_ih_prodaesh = {
text = [[Да-с. По самым низким ценам, и, конечно, самые лучшие. В первый ряд!]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
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
d_blya = {
text = [[]],
speaker = [[Убийца]],
npc = "npc_killer",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_budu_hranit_etot_dar_vechno = {
text = [[*He smiles and throw some signs with his hands. Xavier picks up microphone and continues performing. Flow's back on track.*]],
speaker = [[xaviersobased]],
npc = "npc_xavier",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_bylo_delo = {
text = [[Я всем рассказал про тебя, так что не удивляйся, если незнакомцы будут обращаться по имени. Ты наш герой бро.]],
speaker = [[Крип-рогач]],
npc = "npc_creep_rogach",
choices = {
{
text = [[Спасибо бро.]],
next = "d_spasibo_bro",
},
},
},
d_v_pustoshi_krip_predlagal_mne_za_150_otdat = {
text = [[Оооох, думаю тебя обманывают, паренёк... Нигде по таким ценам не продают.]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Пошли со мной, покажу.]],
next = "d_poshli_so_mnoj_pokazhu",
},
},
},
d_v_kakom_plane = {
text = [[Ты в одиночку одолел монстра-гориллу! Тут так-то моя заслуга, ведь после встречи с такими кулаками и усами, эта горилла сильно ослабла.
*Потягивает ус.*]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[Не так уж и ослабла...]],
next = "d_ne_tak_uzh_i_oslabla",
},
{
text = [[А как ты пережил с ним встречу?]],
next = "d_a_kak_ty_perezhil_s_nim_vstrechu",
},
},
},
d_v_obschem_ya_pogovoril_s_otshelnikom_on_skazal_sleduuschee = {
text = [[*Глава внимательно слушает.*]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Пересказать разговор с отшельником.]],
next = "d_r",
},
},
},
d_v_etom_chtoto_est = {
text = [[*Человек-сказитель, не проронив ни слова, закрыл глаза и начал медитировать.*]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_vam_nuzhen_voin = {
text = [[Верно, но я не буду тебя заставлять. Просто оглянись и задумайся...]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[...]],
next = "d_r1",
},
},
},
d_vzaimno = {
text = [[*Довольный перекуп пересчитывает невидимые монеты, пока ты вертишь билеты у себя в руках.*]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_vneshka_ne_vazhna_ponimaesh_sila_vnutri = {
text = [[Знаешь... Ты октрыл мне глаза. Всё время я смотрел на остальных сверху вниз, но почему? Даже не пытался выслушать их. Может ли быть такое, что... я просто надменный?]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[*С уважением кивнуть.*]],
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
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Не сходится.]],
next = "d_ne_shoditsya",
},
},
},
d_vot_tvoj_bilet_chernomazyj = {
text = [[*Он взял билет, словно реликвию. Сначала посмотрел на него, потом на тебя, потом на него. А потом снова на тебя...*]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[...]],
next = "d_l4",
},
},
},
d_vrode_zapomnil = {
text = [[Тогда отправляйся.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_vsmysle_a_kak_zhe_vash_vsemilubimyj_korol = {
text = [[Как ты знаешь, он сейчас отсутствует. А если точнее... Он мёртв.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[И ты получается первый кто подхватился, да?]],
next = "d_i_ty_poluchaetsya_pervyj_kto_podhvatilsya_da",
},
},
},
d_vybor = {
text = [[*В моменте он остепенился, впервые в его глазах появился огонёк жизни.*
Хм... Хорошо. Возможно, ты и есть тот, кто должен был оказаться на моём месте.]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[...]],
next = "d_q18",
},
},
},
d_glava_skazal_chto_ty_mozhesh_znat_chtoto_o_zvere = {
text = [[Глава, да? Понятно...]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Ты упомянул, что Зверь тебя отпустил?]],
next = "d_ty_upomyanul_chto_zver_tebya_otpustil",
},
},
},
d_glava = {
text = [[Правильно. Связующее звено.]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[А где он?]],
next = "d_whereisleader",
actions = {
{ npc="npc_mystery",type="remove" },
{ door="door_village_leader",type="open_door" },
},
},
},
},
d_govori = {
text = [[Меня заинтересовал твой кулак, дробящий камни. Меня, Твердолобого, никто за всё время не смог меня ни переубедить, ни сдвинуть...]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[...]],
next = "d_f",
},
},
},
d_da__2 = {
text = [[*Ноги начали вести тебя ближе к сцене. Словно собака, ты готов показать всем насколько ты предан своему хозяину. Вобрав кучу воздуха через свой нос, ты заряжаешь самый громкий крик, который человек способен воспроизвести.*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[КСАВЬЕР Я ТВОЙ САМЫЙ ГЛАВНЫЙ ФАНАТ!!!!!!!!!]],
next = "d_ksaver_ya_tvoj_samyj_glavnyj_fanat",
},
},
},
d_davaj = {
text = [[Кстати, есть чем протереть мне голову?]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Как я помню, панда носит с собой полотенце.]],
next = "d_kak_ya_pomnu_panda_nosit_s_soboj_polotentse",
},
},
},
d_derek_etogo_hotel = {
text = [[Но зачем?]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Чтобы ты предостерёг людей от неминуемой гибели.]],
next = "d_chtoby_ty_predostereg_ludej_ot_neminuemoj_gibeli",
},
},
},
d_derek_zver_eto_chelovek = {
text = [[Получается он тебе не сказал...]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[...]],
next = "d_q9",
},
},
},
d_dopustim_a_zachem_pozval_menya_to = {
text = [[Ты меня поразил, Алекс. Ты не только начал помогать горожанам, так и спас всех от участи, которая будет пострашней гибели. Благодарю от имени всего Королевтсва.
*Он едва кивнул головой.*]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Ну типо да.]],
next = "d_nu_tipo_da",
},
},
},
d_dorogo = {
text = [[Ни в коем случае! У кого ни спросите, дешевле нету!]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[На сайте концерта за 100 отдают.]],
next = "d_na_sajte_kontserta_za_100_otdaut",
},
{
text = [[В Пустоши крип предлагал мне за 150 отдать.]],
next = "d_v_pustoshi_krip_predlagal_mne_za_150_otdat",
},
},
},
d_dumaete_etot_vyzhivshij_odolel_zverya = {
text = [[Я уверен, что это не так.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Какая моя цель сейчас?]],
next = "d_kakaya_moya_tsel_sejchas",
},
},
},
d_esli_hochesh_ubeditsya_to_provedi_rukoj_po_golove = {
text = [[*Он не предпринимает никаких действий, но ты замечаешь, как от напряжения, его тело немного начинает увеличиваться в размерах.*]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Ты знал, что твой отец - врач? Пошли со мной и тебя подлатают, он уж точно знает как помочь.]],
next = "d_ty_znal_chto_tvoj_otets_vrach_poshli_so_mnoj_i_tebya_podlataut_on_uzh_tochno_znaet_kak_pomoch",
},
},
},
d_est_sposob_skazhe_gde_on = {
text = [[Он... Эм... Вроде был в Коралловом лесу, но точно не знаю где.]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Что за Коралловый лес?]],
next = "d_chto_za_korallovyj_les",
},
},
},
d_zhalko_chto_ty_ne_vidish_sama_priroda_odarila_tebya_belosnezhnoj_kipoj = {
text = [[Какой ещё кипой? Обмануть меня не получится, я ничего не чувствую на своей голове.]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Может куча там аж до черепа пробила?]],
next = "d_mozhet_kucha_tam_azh_do_cherepa_probila",
},
},
},
d_zato_kakih_moi_tenge_azh_1993_goda_ty_dazhe_predstavit_ne_mozhesh_ih_tsennost = {
text = [[1993-ый год... Так там каждую монету можно продать по 420 золота!]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Во во.]],
next = "d_vo_vo",
},
},
},
d_zachem_emu_ubivat_korolya = {
text = [[Я... я даже представить не могу. Возможно, он и есть Сатана?]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Скажи хотя бы где был убит Король, я бы осмотрелся.]],
next = "d_skazhi_hotya_by_gde_byl_ubit_korol_ya_by_osmotrelsya",
},
},
},
d_zdes_delo_ne_v_tom_kto_silnee_ili_slabee_prosto_u_tebya_na_golove_nasrano = {
text = [[Где связь?]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Низкий интеллект твой вечный спутник, так что не забивай голову.]],
next = "d_nizkij_intellekt_tvoj_vechnyj_sputnik_tak_chto_ne_zabivaj_golovu",
},
},
},
d_i_vpravdu = {
text = [[Рад, что могу разделить эту ношу с кем-то таким же понимающим.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Я готов помочь.]],
next = "d_ya_gotov_pomoch",
},
},
},
d_i_znaesh_li_moj_kulak_drobit_kamni_a_tut_peredo_mnoj_statuya_tak_chto_poslednij_shans_pojti_so_mnoj = {
text = [[Признаю, в твоих словах есть доля правды. Может быть мне и вправду стоит обращать внимание на слова простаков, а не просто их избивать. Я готов встретиться с "отцом", однако ты должен ответить за слова.]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Говори.]],
next = "d_govori",
},
},
},
d_i_tebe_privet = {
text = [[Положи свою чёрную задницу сюда, да.]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Чего чего?).]],
next = "d_chego_chego",
},
},
},
d_i_ty_poluchaetsya_pervyj_kto_podhvatilsya_da = {
text = [[Взял инициативу. Но ты не подумай, у меня великие цели. Каждый день я тружусь во благо Королевства, поэтому приходится управлять всем из безопасности, ведь, если со мной что-то случится, всё рухнет.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Допустим, а зачем позвал меня то?]],
next = "d_dopustim_a_zachem_pozval_menya_to",
},
},
},
d_i_chto_ty_sobiraeshsya_delat = {
text = [[Я... н-не знаю...
*Он оцепенел.*]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[...]],
next = "d_q14",
},
},
},
d_i_ya_ee_kak_raz_podhvatil = {
text = [[Отличная командная работа, Алекс!]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[Ты тоже хорош.]],
next = "d_ty_tozhe_horosh",
},
},
},
d_izza_tebya_malenkij_niger_ne_mozhet_popast_na_kontsert_ponimaesh = {
text = [[Он может, если купит билет.]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Перекупы вы суки..]],
next = "d_perekupy_vy_suki",
},
},
},
d_izvinyaj_mne_dva_bileta_nado_a_te_rebyatki_davali_skidku_na_pokupku_ot_dvuh = {
text = [[Стой, стой, стой, стой! Совсем забыл рассказать о главной акции: два билета по цене одного! Очень выгодно!]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Хм... неплохо, но даже так мне не хватит, у меня 50 золота.]],
next = "d_hm_neploho_no_dazhe_tak_mne_ne_hvatit_u_menya_50_zolota",
},
},
},
d_ksaver_ya_tvoj_samyj_glavnyj_fanat = {
text = [[*Гул невероятной мощи начал резонировать от стен, усиливаясь с каждый отскоком. Ничего, кроме тебя, не было слышно. Нескольких людей сбило с ног.*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[АЛЕКС УМРЁТ ЗА ТЕБЯ, ТЫ ЛЕГЕНДА, ТЫ М...]],
next = "d_aleks_umret_za_tebya_ty_legenda_ty_m",
},
},
},
d_kak_tak = {
text = [[Билетов нет в продаже. Один человек скупил кучу и перепродаёт с наценкой больше 500 процентов! У меня нет таких денег...]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Я тебе подсоблю.]],
next = "d_j4",
actions = {
{ questID="q_concert",type="quest_start" },
},
},
{
text = [[Понятно, но давай потом как-нибудь.]],
next = "d_j3",
},
},
},
d_kak_ty_postupil = {
text = [[Наихудшим образом. Я, можно сказать, снял с себя ответственность, выкинув ключ. Теперь это не моя забота...]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Скажи, где мне его найти.]],
next = "d_skazhi_gde_mne_ego_najti",
},
},
},
d_kak_eto = {
text = [[А ты сам кто? И зачем пришёл по мою душу?]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Глава сказал, что ты можешь знать что-то о Звере.]],
next = "d_glava_skazal_chto_ty_mozhesh_znat_chtoto_o_zvere",
},
},
},
d_kak_ya_pomnu_panda_nosit_s_soboj_polotentse = {
text = [[Тогда путь намечен, прощай.]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Уйти.]],
next = nil,
actions = {
{ npc="npc_green",type="remove" },
},
},
},
},
d_kakaya_moya_tsel_sejchas = {
text = [[Найди отшельника в Снежных горах и узнай, что тот видел в роковую ночь. Может быть ему известна слабость Зверя.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Награда будет?]],
next = "d_nagrada_budet",
},
},
},
d_kakih_drugih = {
text = [[Части разных лесов соедины между собой дверьми, которые я закрыл на печати, дабы опасные существа не пробирались в Королевство.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Там за дверью случайно не Коралловый лес?]],
next = "d_tam_za_dveru_sluchajno_ne_korallovyj_les",
},
},
},
d_kakovo_eto_skupat_bilety_zastavlyaya_bednyh_stradat = {
text = [[О чём речь? Я официальный диллер.]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Из-за тебя маленький нигер не может попасть на концерт, понимаешь?]],
next = "d_izza_tebya_malenkij_niger_ne_mozhet_popast_na_kontsert_ponimaesh",
},
},
},
d_konechno_moj_goat = {
text = [[Shout out to all my fans here, that's the gang, that's the gang, um, especially you, Alex. Take this small shi, its a gift from me to you bro.]],
speaker = [[xaviersobased]],
npc = "npc_xavier",
choices = {
{
text = [[Буду хранить этот дар вечно...]],
next = "d_budu_hranit_etot_dar_vechno",
},
},
},
d_kstati_est_li_u_zverya_kakieto_slabosti = {
text = [[Нету, ведь он сражается, чтобы выжить.]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[А...]],
next = "d_a",
},
},
},
d_ladno_davaj = {
text = [[Посчитай-ка интегральчик от 0 до 2: 
x * (x^2 + 1)^3]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[63]],
next = "d_q6",
},
{
text = [[-15/16]],
next = "d_q6",
},
{
text = [[78]],
next = "d_q7",
},
{
text = [[-1.815]],
next = "d_q6",
},
},
},
d_ladno_a_kakaya_vneshnost_u_perekupa = {
text = [[Синий плащ и большая борода.]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Мне пора.]],
next = "d_mne_pora",
},
},
},
d_menya_poslal_tvoj_otets = {
text = [[Не припоминаю, чтобы у меня был отец.]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Ты ведь Зелёный?]],
next = "d_ty_ved_zelenyj",
},
},
},
d_mne_bez_raznitsy_kakto = {
text = [[*Глава на мгновение задумался.*
Слышал, что ты любишь решать, верно? Представь, что завтра нас всех не станет. Больше никаких примеров... Больше никаких задачек... И даже оценки не от кого не получить...]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Н..Нет! Не позволю такому случится! Я буду бороться!]],
next = "d_ya_gotov_pomoch",
},
},
},
d_mne_pora = {
text = [[Но где ты возьмёшь столько денег?!]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_mne_pohuuj = {
text = [[Твоя низкая самооценка сподвигает использовать такой примитивный инструмент. Он мне уже наскучил, покажи что-нибудь другое.]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[*Показать жопу.*]],
next = "d_pokazat_zhopu",
},
},
},
d_mozhet_kucha_tam_azh_do_cherepa_probila = {
text = [[*Хотя физиономия Зелёного остаётся такой же, взгляд его уже нельзя назвать спокойным.*]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[*Отойти на безопасное расстояние.*]],
next = "d_otojti_na_bezopasnoe_rasstoyanie",
},
},
},
d_na_sajte_kontserta_za_100_otdaut = {
text = [[Что ещё за сайт?
*Настороженно спросил перекуп.*]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Ну сайт. Где билеты онлайн покупают.]],
next = "d_nu_sajt_gde_bilety_onlajn_pokupaut",
},
},
},
d_navernoe_nado_da = {
text = [[Зато ты научился хорошо уворачиваться и контратаковать. Я видел, Алекс, - это было бесподобно!]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[Изнасилованным не особо хотелось быть.]],
next = "d_ty_tozhe_horosh",
},
},
},
d_nagrada_budet = {
text = [[Конечно. И кстати, мне сообщили, что ты устранил опасных крипов на территории Заброшенного леса. Предлагаю продолжить это и в других лесах.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Каких других?]],
next = "d_kakih_drugih",
},
},
},
d_ne_dumau = {
text = [[*Существо не показало никакой реакции.*]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Меня послал твой отец.]],
next = "d_menya_poslal_tvoj_otets",
},
},
},
d_ne_osobo = {
text = [[*Он приуныл.*
Ну вот... Мне никогда не стать нигером...]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[А зачем тебе?]],
next = "d_a_zachem_tebe",
},
},
},
d_ne_shoditsya = {
text = [[Что не так?!]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[7 монет по 420 - это 2940. А билеты стоят 50. Не сходится.]],
next = "d_7_monet_po_420_eto_2940_a_bilety_stoyat_50_ne_shoditsya",
},
},
},
d_ne_tak_uzh_i_oslabla = {
text = [[Если ты так думаешь, значит ослаб ты! Продолжай качаться и наверстаешь.]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[Наверное надо, да...]],
next = "d_navernoe_nado_da",
},
},
},
d_ne_hochu_kakto = {
text = [[]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_net_ne_hvatit = {
text = [[Помнишь ту птицу? Заметил, что с ней случилось?]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[*Вложить все свои усилия.*]],
next = "d_vlozhit_vse_svoi_usiliya",
},
},
},
d_net_prosto_gulyau = {
text = [[*После твоих слов, он начал проявлять безразличие.*]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_nizkij_intellekt_tvoj_vechnyj_sputnik_tak_chto_ne_zabivaj_golovu = {
text = [[*Существо поворачивает голову в твою сторону. Это первый раз, когда оно совершило движение.*]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Только умный способен выслушать и взвесить все за и против, а ты просто упёртый. Вот и всё.]],
next = "d_tolko_umnyj_sposoben_vyslushat_i_vzvesit_vse_za_i_protiv_a_ty_prosto_upertyj_vot_i_vse",
},
},
},
d_nu_da = {
text = [[Долгое время я не мог решиться... С одной стороны, утаивание ключа - благое действие, однако бесчестное. С другой, бой с Дереком - это страшная смерть...]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Как ты поступил?]],
next = "d_kak_ty_postupil",
},
},
},
d_nu_davaj = {
text = [[Данная легенда передавалась из поколения в поколение. Я - последний её носитель.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[...]],
next = "d_k",
},
},
},
d_nu_ladno = {
text = [[А ещё, дверь, ведущая к монстру, что поглотил часть ключа, находится в Искажённом лесу. Самом страшном месте, после Пустоши конечно. Держи заклинание от врат в этот лес: "Logarithmus solvus".]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_nu_sajt_gde_bilety_onlajn_pokupaut = {
text = [[Обманывать меня решил?! В этом мире нету интернета, паренёк. Я передумал. Для тебя билет - 1000 золота.]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[*Пригрозить ему.*]],
next = "d_l2",
},
},
},
d_nu_tipo_da = {
text = [[Расклад у нас сейчас такой: людей осталось мало, а враждебные крипы постоянно совершают убийства и грабежи. Мы не можем давать отпор.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Вам нужен воин?]],
next = "d_vam_nuzhen_voin",
},
},
},
d_o_chem_byl_nash_proshlyj_razgovor = {
text = [[Это была и есть проверка. Те, кто обладают качествами, попадают в Скрытую деревню.]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[Ты - член деревни. А по факту то кто?.]],
next = "d_ty_chlen_derevni_a_po_faktu_to_kto",
},
},
},
d_oj_ya_pereputal_u_menya_ne_zoloto_a_tenge = {
text = [[Тенге... Получается по курсу это где-то... СЕМЬ ЗОЛОТА??!?!]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Зато каких! Мои тенге аж 1993 года. Ты даже представить не можешь их ценность.]],
next = "d_zato_kakih_moi_tenge_azh_1993_goda_ty_dazhe_predstavit_ne_mozhesh_ih_tsennost",
},
},
},
d_ona_ostavila_tebe_podarok_beloe_pyatno_na_tvoej_makushke = {
text = [[*Зелёный поднимает глаза наверх, пытаясь рассмотреть. Ему это не удаётся.*]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Жалко, что ты не видишь. Сама природа одарила тебя белоснежной кипой.]],
next = "d_zhalko_chto_ty_ne_vidish_sama_priroda_odarila_tebya_belosnezhnoj_kipoj",
},
},
},
d_pokupau = {
text = [[ПРОДАНО!]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[*Ты забираешь билеты.*]],
next = "d_ty_zabiraesh_bilety",
actions = {
{ npc="npc_perekup",type="force_give_drop" },
},
},
},
},
d_perekupy_vy_suki = {
text = [[*Чувствуя твою агрессию, перекуп начинает обороняться.*]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[*Влететь в него.*]],
next = nil,
actions = {
{ target="kill",npc="npc_perekup",type="fight_start" },
},
},
},
},
d_pozhalujsta_navernoe = {
text = [[*Отшельник немного успокоился.*
Тебе наверное интересно, что стало с ключом?]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Ну да.]],
next = "d_nu_da",
},
},
},
d_poluchaetsya_ty_neuch_a_ya_krutoj_tipo = {
text = [[]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_porazhen_umom_svinopasa = {
text = [[*Злость распирает его.*
Какое-то ничтожество смогло обойти величайшего гения в математике?! Я не смогу отмыться от этого позора ещё долгое время... Ты обязан заплатить за такое издевательство!]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[Получается ты неуч, а я крутой типо.]],
next = nil,
actions = {
{ target="kill",npc="npc_genius",type="fight_start" },
},
},
},
},
d_pochemu_vy_dali_mne_chast_klucha = {
text = [[Я же говорила, что один человек попросил передать это кому-то с непоколебимой волей. До тебя приходили одни слабаки, а прикоснувшись к твоему духу, у меня аж мурашки пошли. Хе-хе.]],
speaker = [[Старушка]],
npc = "npc_shamanka",
choices = {
{
text = [[...]],
next = "d_r3",
},
},
},
d_pochemu_on_tebya_poschadil = {
text = [[Я не знаю.]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[А зачем он позволил запереть себя.]],
next = "d_a_zachem_on_pozvolil_zaperet_sebya",
},
},
},
d_pochemuty_ne_skazal_chto_zver_eto_chelovek = {
text = [[*Под ногами пробегает красный муравей. Спустя мгновение Глава раздавливает его ногой.*]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[...]],
next = "d_r2",
},
},
},
d_poshli_so_mnoj_pokazhu = {
text = [[*Слово Пустошь повлияло на перекупа.*
Нееет, я пожалуй тут останусь... И давай, чтоб ты не рисковал, я тебе за 140 отдам, а?]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Извиняй, мне два билета надо, а те ребятки давали скидку на покупку от двух.]],
next = "d_izvinyaj_mne_dva_bileta_nado_a_te_rebyatki_davali_skidku_na_pokupku_ot_dvuh",
},
},
},
d_pri_vstrechi_s_derekom_ya_by_tak_i_tak_ponyal_chto_on_ne_zhivotnoe = {
text = [[Но теперь ты колеблешься. А колебание ведёт к поражению.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Ага. Так кто такой Дерек?]],
next = "d_aga_tak_kto_takoj_derek",
},
},
},
d_prijti_nepodgotovlennym_v_getto_takto_opasno = {
text = [[Но я очень хочу! Это моя мечта: стать первым крипом-нигером!]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[*Тебя пробивает на слезу от восхищения.*]],
next = "d_tebya_probivaet_na_slezu_ot_voshischeniya",
},
},
},
d_prostite = {
text = [[Впрочем уже поздно что-то менять. Если верить словам отшельника, первая часть ключа находятся у старушки, вторая – на одном из пиков Снежных гор, третью же оберегают челюсти чудовища Искаженного леса.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Спасибо, запомнил.]],
next = nil,
},
},
},
d_raz_ty_ne_hochesh_idti_so_mnoj_ya_prosto_ponesu_tebya = {
text = [[*Зелёный усмехается. Ты всё ещё пытаешься оторвать его от земли.*]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[*Обернуть свои ноги вокруг него и начать тянуть весом тела.*]],
next = "d_obernut_svoi_nogi_vokrug_nego_i_nachat_tyanut_vesom_tela",
},
},
},
d_realno_ya_ochen_rad = {
text = [[That shi was lit.]],
speaker = [[xaviersobased]],
npc = "npc_xavier",
choices = {
{
text = [[У тебя прям крутые треки. И ты крутой.]],
next = "d_u_tebya_pryam_krutye_treki_i_ty_krutoj",
},
},
},
d_skazhi_hotya_by_gde_byl_ubit_korol_ya_by_osmotrelsya = {
text = [[Никто не знает, где это было. Никто даже не находил его труп. Дерек явно попытался скрыть его тело, однако это не поможет ему избежать наказания...]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[В общем, я поговорил с отшельником, он сказал следующее...]],
next = "d_v_obschem_ya_pogovoril_s_otshelnikom_on_skazal_sleduuschee",
},
},
},
d_skazhi_gde_mne_ego_najti = {
text = [[Что это тебе даст?]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Выбор.]],
next = "d_vybor",
},
},
},
d_spasibo_bro = {
text = [[Ты идёшь с миром, и мир идёт с тобой.]],
speaker = [[Крип-рогач]],
npc = "npc_creep_rogach",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_spasibo_zapomnil = {
text = [[]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_sebi = {
text = [[*Одним ударом ты отправил псевдофаната в нокаут. Только вот остальные тоже возомнили себя преданными поклонниками. Все начали доказывать это друг другу.*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[*Похоже до них всё ещё не дошло...*]],
next = "d_pohozhe_do_nih_vse_esche_ne_doshlo",
},
},
},
d_tam_za_dveru_sluchajno_ne_korallovyj_les = {
text = [[Да. Чтобы открыть её, подойди поближе и произнеси заклинание вслух: "Stringus Collapsus". Будет отлично, если сможешь заодно освободить и эти территории.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Вроде запомнил.]],
next = "d_vrode_zapomnil",
},
},
},
d_togda_predlagau_torg = {
text = [[*Уверенный в своих умениях перекуп соглашается.*]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[1 монета!]],
next = "d_1_moneta",
},
},
},
d_tolko_umnyj_sposoben_vyslushat_i_vzvesit_vse_za_i_protiv_a_ty_prosto_upertyj_vot_i_vse = {
text = [[*Зелёный впервые призадумался.*]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[И знаешь ли, мой кулак дробит камни, а тут передо мной статуя. Так что последний шанс пойти со мной.]],
next = "d_i_znaesh_li_moj_kulak_drobit_kamni_a_tut_peredo_mnoj_statuya_tak_chto_poslednij_shans_pojti_so_mnoj",
},
},
},
d_ty_chlen_derevni_a_po_faktu_to_kto = {
text = [[Мне ещё предстоит это выяснить. Пока что я служу Главе. И он хочет тебя видеть. Встреться с ним.]],
speaker = [[Крип-загадка]],
npc = "npc_mystery",
choices = {
{
text = [[Глава?]],
next = "d_glava",
},
},
},
d_ty_budto_statuya_znal = {
text = [[Что нужно примитивному существу от Твердолобого?]],
speaker = [[Зелёный]],
npc = "npc_green",
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
speaker = [[Зелёный]],
npc = "npc_green",
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
d_ty_debil = {
text = [[Обыкновенное поведение примата: использование нецензурной брани в целях показать своё превосходство, однако этим ты только подтверждаешь своё невежество.]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[Мне похууй.]],
next = "d_mne_pohuuj",
},
},
},
d_ty_zhivoj = {
text = [[*Только после этих слов он замечает тебя и начинает пристально осматривать твою фигуру, при этом не шевельнув ни мускулом.*]],
speaker = [[Зелёный]],
npc = "npc_green",
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
d_ty_znal_chto_tvoj_otets_vrach_poshli_so_mnoj_i_tebya_podlataut_on_uzh_tochno_znaet_kak_pomoch = {
text = [[Я никуда не пойду. И зачем мне врач?]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Сейчас по новостям крутят, что птицы переносят вирус. Его жертвы начинают становиться ебучими баранами.]],
next = "d_e",
},
},
},
d_ty_tipo_niger = {
text = [[*Крип восторженно подлетает.*
Похож?! Реально похож?!]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Не особо.]],
next = "d_ne_osobo",
},
},
},
d_ty_tozhe_horosh = {
text = [[Однако в Пустошь тебе ещё рано. Там таких горилл десятки.]],
speaker = [[Человек-усач]],
npc = "npc_mustache",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_ty_upomyanul_chto_zver_tebya_otpustil = {
text = [[Да... Ту ночь я никогда не забуду. Люди умирали пачками, мои друзья бездыханно лежали под ногами, а моё тело зажималось и дрожало от страха.]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[...]],
next = "d_q8",
},
},
},
d_u_menya_est_k_tebe_delo = {
text = [[Почему мне должно быть не всё равно?]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Меня послал твой отец.]],
next = "d_menya_poslal_tvoj_otets",
},
},
},
d_u_menya_netu = {
text = [[Тогда проваливай.]],
speaker = [[Крип-вышибала]],
npc = "npc_concert_guard",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
d_u_tebya_pryam_krutye_treki_i_ty_krutoj = {
text = [[It's good, like, it's good cuz when i died, i thought there wont be hood around here bro...
But luckily it's here you feel me?]],
speaker = [[xaviersobased]],
npc = "npc_xavier",
choices = {
{
text = [[Да!]],
next = "d_xavieryes",
},
},
},
d_hm_neploho_no_dazhe_tak_mne_ne_hvatit_u_menya_50_zolota = {
text = [[ПЯТЬДЕСЯТ?! Это очень мало, знаете ли...]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Эхх... значит не попасть моему дедушке-ветерану калеке на концерт своего любимого рэпера...]],
next = "d_ehh_znachit_ne_popast_moemu_dedushkeveteranu_kaleke_na_kontsert_svoego_lubimogo_repera",
},
},
},
d_horosh = {
text = [[Мне пора идти, есть много перед кем нужно извиниться. Мы ещё обязательно увидимся.]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Давай.]],
next = "d_davaj",
},
},
},
d_horosho_horosho_ya_kstati_tozhe_pojdu = {
text = [[Но как??]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[*Помахать билетом.*]],
next = "d_pomahat_biletom",
actions = {
{ questID="q_concert",type="quest_end" },
},
},
},
},
d_chto__2 = {
text = [[*У тебя участилось дыхание, стало тяжело дышать, но тебя это даже впирает. Ты всё ещё не можешь принять того, что видишь.*]],
speaker = [[...]],
npc = nil,
choices = {
{
text = [[Ааааахарр... Аргхэ.. Шууфувуу...]],
next = "d_aaaaaharr_arghe_shuufuvuu",
},
},
},
d_chego_tebe = {
text = [[Эпштейн передаёт тебе привет.]],
speaker = [[Убийца]],
npc = "npc_killer",
choices = {
{
text = [[Бля.]],
next = nil,
actions = {
{ target="kill",npc="npc_killer",type="fight_start" },
},
},
},
},
d_chego_chego = {
text = [[Всё чётко, хоть и синие мальчики гоняются за мной, ты не трясись, всё холодное.]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Ты типо нигер?]],
next = "d_ty_tipo_niger",
},
},
},
d_chem_ya_tebe_ne_ugodil = {
text = [[В Скрытую деревню испокон веков попадали только самые выдающиеся и умнейшие крипы и люди этих земель. Посмотри на себя, твой внешний вид показывает, что ты - примитивное существо.]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[Я вообще-то математикой увлекаюсь.]],
next = "d_ya_voobscheto_matematikoj_uvlekaus",
},
},
},
d_chto_za_korallovyj_les = {
text = [[Мне говорили, что это где-то неподалёку.]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[Ладно, а какая внешность у перекупа?]],
next = "d_ladno_a_kakaya_vneshnost_u_perekupa",
},
},
},
d_chtoby_ty_predostereg_ludej_ot_neminuemoj_gibeli = {
text = [[А почему именно я?]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[...]],
next = "d_q15",
},
},
},
d_em_dopustim = {
text = [[Первую часть я отдал старушке-медиуму, вторую - спрятал на соседнем пике Снежных гор, а третью - скормил самому могучему крипу Искажённого леса.]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Понятно.]],
next = "d_hermitigetit",
},
},
},
d_eto_ego_mechta_poslednee_chto_derzhit_deda_na_etoj_zemle = {
text = [[Так уж и быть... Ради твоего дедушки - 50 золота.]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Ой, я перепутал, у меня не золото, а тенге.]],
next = "d_oj_ya_pereputal_u_menya_ne_zoloto_a_tenge",
},
},
},
d_eto_nadolgo = {
text = [[Великое требует времени.]],
speaker = [[Человек-сказитель]],
npc = "npc_storyteller",
choices = {
{
text = [[Ну давай.]],
next = "d_nu_davaj",
},
},
},
d_eto_nepravilnyj_otvet = {
text = [[Ты этого даже без меня не смог понять... Таким пустоголовым ничтожествам нету места в Скрытой деревне. Позволь спасти тебя от страданий...]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[*В чём же я ошибся?*]],
next = nil,
actions = {
{ target="kill",npc="npc_genius",type="fight_start" },
},
},
},
},
d_eto_ty_tot_vyzhivshij_chto_smog_sbezhat_ot_zverya = {
text = [[Сбежать? Нет...
*Ответил он хриплым голосом.*
Он сам меня отпустил.]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[Как это?]],
next = "d_kak_eto",
},
},
},
d_ehh_znachit_ne_popast_moemu_dedushkeveteranu_kaleke_na_kontsert_svoego_lubimogo_repera = {
text = [[Ветерану?.. Калеке?.. Эм... А он прям... очень хочет попасть туда?..]],
speaker = [[Человек-перекуп]],
npc = "npc_perekup",
choices = {
{
text = [[Это его мечта. Последнее, что держит деда на этой земле.]],
next = "d_eto_ego_mechta_poslednee_chto_derzhit_deda_na_etoj_zemle",
},
},
},
d_ya_voobscheto_matematikoj_uvlekaus = {
text = [[Хмм... Соизволь тогда показать свои навыки.]],
speaker = [[Крип-гений]],
npc = "npc_genius",
choices = {
{
text = [[Я много решал.]],
next = "d_q4",
},
{
text = [[Я тщательно решал.]],
next = "d_q4",
},
{
text = [[Я бросал дела, лишь бы порешать.]],
next = "d_q4",
},
},
},
d_ya_gotov_pomoch = {
text = [[Прекрасно. Перед тем как продолжить, хочу рассказать кое что о нашем Короле, Джордже Богоподобном...
*Глава говорит это с огромной гордостью.*]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[...]],
next = "d_q",
},
},
},
d_ya_zabyl_gde_nahodyatsya_chasti_klucha = {
text = [[Я начинаю думать, что твое присутствие в деревне – плод чьей-то нерассудительной щедрости. Кажется мой протеже поторопился, рассказывая тебе пароль.]],
speaker = [[Глава]],
npc = "npc_leader",
choices = {
{
text = [[Простите...]],
next = "d_prostite",
},
},
},
d_ya_mogu_tebe_kaknibud_pomoch = {
text = [[Хмм... Точно! Скоро будет концерт известного чёрного рэпера! Послушав его, я точно наберусь знаний!]],
speaker = [[Крип с мечтой]],
npc = "npc_dream",
choices = {
{
text = [[...]],
next = "d_j2",
},
},
},
d_ya_ne_znau = {
text = [[*Неожиданно с дерева упал огромный кусок снега.*]],
speaker = [[Человек-отшельник]],
npc = "npc_hermit",
choices = {
{
text = [[...]],
next = "d_q16",
},
},
},
concert_bouncer_pass = {
text = [[]],
speaker = [[Крип-вышибала]],
npc = "npc_concert_guard",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
die_from_green_2 = {
text = [[]],
speaker = [[Зелёный]],
npc = "npc_green",
choices = {
{
text = [[Закрыть.]],
next = nil,
},
},
},
},
}