(function () {

  const SPEAKER_PORTRAIT = {
    "...": "default",
    "???": "tormentor",
    "БОГ": "tormentor",
    "Старушка": "shamanka",
    "Банда троллей": "gate_trolls",
    "Синий Принц": "blue_prince",
    "Крип-рогач": "rogach",
    "Человек-усач": "mustache",
    "Боб": "bob",
    "Быдло": "monkey_king",
    "Пьяная панда": "brewmaster",
    "Панда": "brewmaster_good",
    "Голова умнотуп": "ogre_left",
    "Голова подначка": "ogre_right",
    "Сиамский огр": "ogre_both",
    "Бочка": "flask_barrel",
    "Гид": "guide",
    "Камыш": "kamish",
    "Демоны Тени": "island_duo",
    "Пропавший Король": "george_1",
    "Джордж Богоподобный": "george_2",
    "Дерек": "derek",
    "xaviersobased": "npc_xavier",
    "Неизвестный": "eps",
    "Эпштейн": "eps",
    "Подозрительный терминал": "fake_subway",
    "Терминал М.Е.Т.Р.О.": "subway",
    "Красный": "red",
    "Зелёный": "green",
    "Синий": "blue",
    "Убийца": "killer",
    "Воин Эпштейна": "island_guard",
    "Раздраженный крип": "predvestnik",
    "Крип Предвестник": "predvestnik",
    "Учёный": "scientist",
    "Крип-алхимик": "alchemist",
    "Крип-загадка": "mystery",
    "Сказитель": "storyteller",
    "Крип с мечтой": "dream",
    "Крип-нигер": "nga",
    "Представительный человек": "perekup",
    "Перекуп": "perekup",
    "Крип-вышибала": "bouncer",
    "Житель Пустоши": "wasteland",
    "Глава": "leader",
    "Кот-бочка": "barrel_cats",
    "Хранительница": "lanaya",
    "Скулшутер": "shooter",
    "Крип-гений": "genius",
    "Огр-громила": "ogre_bruiser",
    "Отшельник": "hermit",
    "Гангстер": "gangster",
  }

  const root = $.GetContextPanel();
  const speakerName = $("#SpeakerName");
  const speakerTitle = $("#SpeakerTitle");
  const speakerPortrait = $("#SpeakerPortrait");
  const textLabel = $("#DialogueText");
  const choicesRoot = $("#Choices");
  const continueHint = $("#ContinueHint");
  const skipButton = $("#SkipButton");

  let typingToken = 0;
  let fullText = "";
  let isTyping = false;

  function clearChoices() {
    choicesRoot.RemoveAndDeleteChildren();
  }

  function setOpen(isOpen) {
    if (isOpen) {
      root.AddClass("IsOpen");
    }
    else {
      root.RemoveClass("IsOpen");
    }

    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_TIMEOFDAY, !isOpen);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_TOP_HEROES, !isOpen);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_FLYOUT_SCOREBOARD, !isOpen);

    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_PANEL, !isOpen);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_ACTION_MINIMAP, !isOpen);

    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_PANEL, !isOpen);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_SHOP, !isOpen);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_ITEMS, !isOpen);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_QUICKBUY, !isOpen);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_COURIER, !isOpen);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_GOLD, !isOpen);
    GameUI.SetDefaultUIEnabled(DotaDefaultUIElement_t.DOTA_DEFAULT_UI_INVENTORY_PROTECT, !isOpen);
  }

  function typewriter(text, cps) {
    typingToken++;
    const token = typingToken;

    fullText = text || "";
    isTyping = true;
    textLabel.text = "";

    const charsPerTick = Math.max(1, Math.floor(cps / 20));
    let i = 0;

    function tick() {
      if (token !== typingToken) return;
      if (!isTyping) return;

      i = Math.min(fullText.length, i + charsPerTick);
      textLabel.text = fullText.substring(0, i);

      if (i >= fullText.length) {
        isTyping = false;
        return;
      }
      $.Schedule(0.05, tick);
    }
    tick();
  }

  function finishTyping() {
    if (!isTyping) return;
    isTyping = false;
    textLabel.text = fullText;
  }

  function show(payload) {
    speakerName.text = payload.speaker || "<unnamed>";
    speakerTitle.text = payload.title || "";
    speakerTitle.visible = !!payload.title;
    speakerPortrait.SetImage(
      `file://{images}/custom_game/portraits/${SPEAKER_PORTRAIT[payload.speaker || "default"]}.psd`
    )

    clearChoices();

    // const choicesKeys = Object.keys(payload.choices)
    // if (choicesKeys.length == 1 && payload.choices[choicesKeys[0]].text == "...") {
    //   payload.choices = {}
    // }

    const hasChoices = Object.keys(payload.choices).length > 0;
    continueHint.visible = !hasChoices;

    typewriter(payload.text || "", payload.cps || 65);

    for (const [luaIdx, c] of Object.entries(payload.choices)) {
      const btn = $.CreatePanel("TextButton", choicesRoot, "");
      btn.AddClass("DialogueChoice");

      const lbl = $.CreatePanel("Label", btn, "");
      lbl.text = c.text;

      btn.SetPanelEvent("onmouseover", () => {
        choicesRoot.Children().forEach(p => p.RemoveClass("IsSelected"));
        btn.AddClass("IsSelected");
      });

      btn.SetPanelEvent("onactivate", () => {
        GameEvents.SendCustomGameEventToServer("dialogue_choice", { choiceLuaIndex: parseInt(luaIdx) });
      });
    }

    skipButton.visible = payload.allowSkip === true;
    skipButton.SetPanelEvent("onactivate", () => {
      GameEvents.SendCustomGameEventToServer("dialogue_skip", {});
    });

    setOpen(true);
  }

  function hide() {
    typingToken++;
    isTyping = false;
    clearChoices();
    setOpen(false);
  }

  function onKeyDown() {
    if (!root.BHasClass("IsOpen")) return;
    if (choicesRoot.GetChildCount() > 0) return;

    if (isTyping) finishTyping();
    else GameEvents.SendCustomGameEventToServer("dialogue_choice", { choiceLuaIndex: 1 });
  }

  GameEvents.Subscribe("dialogue_show", show);
  GameEvents.Subscribe("dialogue_hide", hide);

  // Game.AddCommand("+DialogueContinue", onKeyDown, "", 0);
  // Game.AddCommand("-DialogueContinue", onKeyDown, "", 0);
})();
