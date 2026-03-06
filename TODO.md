## models
* тянучка
    * models/items/broodmother/bride_of_the_web_head/bride_of_the_web_head.vmdl
    * marci
* george
    * models/creeps/ice_biome/undeadtusk/undead_tuskskeleton_armor01.vmdl
    * models/items/doom/lvbu_head/lvbu_head.vmdl
* derek
    * models/heroes/beastmaster/beastmaster.vmdl
    * models/items/terrorblade/terrorblade_ultimate_depravity_head/terrorblade_ultimate_depravity_head.vmdl

* zeus usach
    * lightning_zeus_victory

random stuff:
* models/heroes/bane/grip.vmdl (spooky)
* models/items/undying/flesh_golem/grim_harvest_golem/grim_harvest_golem.vmdl (spooky)


## music
    * дерек (помедленнее, пофундаментальнее)
    * джордж (дарк солс мюзик)
    * алхимики (тайны)
    * расставить лупы

## classes

particles:
* particles/units/heroes/hero_marci/marci_rebound_charge_projectile_streak.vpcf

### towel_master
саммон - 4 лвлва    : 1 -> 0 0 0 
                    : 2 -> 1 1 0 
                    : 3 -> 2 2 1
                    : 4 -> 2 2 2
остальные - 3 лвла
блинк - 1

дальник, самонер

тычки замедляют

* переключаемая аура типа хилки доктора (хил самона+кримзон/баши/мс+универсальное уклонение)
* дэш
* аое контроль (в который медведь больше дамажит)
* бег   (ГОТОВО)
* контролируемый медведь, который станится при выходе за ренж (ГОТОВО)
    * overpower
    * primal beast dash

### rapper
дальник, райткликер

* бег
* блинк, замедляет после применения, + дальность тычки
    particles/units/heroes/hero_pangolier/pangolier_swashbuckler_dash_rope.vpcf
* шефнуть оппа - как у снайпера 1x6
* пассивка с флоу - сбивается уроном, копится за тычки, дает урон
* косячок - chanelling, копит щит, сбивается
* страйф лечебка - тратит флоу, делает неуязвимым и хил от урона от тарана, на макс стаках еще какой-то эффект

### логарифмус
милишник, прокастер

* бег
<!-- * врожденка - дизарм пока не нажмет спел -->
<!-- * пока бъешь -кд спелов, когда попадаешь спелами - +скорость атаки -->
* попадание скилами дает стаки, атаки разряжают стаки

* выстрел, если попал - тп к врагу (мб векторное применение - с какой стороны попал, с той прилетел)
* альт выстрел - духи виспа, стакают замедло

* астрал степ тройной, рефреш при попадании (мб с векторным применением, блинк без урона + тычка)
* aльт степ - дэш с крутилкой

* кидает меч на точку и возвращает. два раза наносит урон
* альт меч - после первого урона тепает к мечу

* отскок (любой скилл с разрывом дистанции) (оставляет клона, отлетеает назад, клон через задержку делает аое тычку)
* альт отскок - юнит таргет, маленький ренж, 4 клона один из них это ты бьют автоатакой 

* маяк на который возвращаешься и дамажишь по пути возвращения
* альт маяк - ремик шторма

* ульта берет последний скил и делает его альт версию на время  (по нажатию)

* particles/units/heroes/hero_void_spirit/astral_step/astral_step_portal_selected.vpcf