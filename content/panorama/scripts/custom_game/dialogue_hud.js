(function () {
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
    if (isOpen) root.AddClass("IsOpen");
    else root.RemoveClass("IsOpen");

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

    const charsPerTick = Math.max(1, Math.floor((cps || 40) / 20));
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
    // payload:
    // {
    //   speaker: "Sven",
    //   title: "Storm Hammer Enthusiast",
    //   text: "Hello there...",
    //   cps: 45,
    //   choices: [{ id:"a", text:"Option A" }, ...],
    //   allowSkip: true
    // }

    speakerName.text = payload.speaker || "???";
    speakerTitle.text = payload.title || "";
    speakerTitle.visible = !!payload.title;
    speakerPortrait.SetImage(`file://{images}/custom_game/portraits/${payload.speakerNPC || "default"}.psd`)

    clearChoices();

    // const choicesKeys = Object.keys(payload.choices)
    // if (choicesKeys.length == 1 && payload.choices[choicesKeys[0]].text == "...") {
    //   payload.choices = {}
    // }

    const hasChoices = Object.keys(payload.choices).length > 0;
    continueHint.visible = !hasChoices;

    typewriter(payload.text || "", payload.cps || 45);

    for (const [luaIdx, c] of Object.entries(payload.choices)) {
      const btn = $.CreatePanel("TextButton", choicesRoot, "");
      btn.AddClass("DialogueChoice");

      const lbl = $.CreatePanel("Label", btn, "");
      lbl.text = c.text;

      btn.SetPanelEvent("onmouseover", () => {
        // purely cosmetic “selected” glow
        choicesRoot.Children().forEach(p => p.RemoveClass("IsSelected"));
        btn.AddClass("IsSelected");
      });

      btn.SetPanelEvent("onactivate", () => {
        $.Msg(c.id)
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

  // “Space to continue”: if typing, finish; otherwise tell server “advance”.
  function onKeyDown() {
    $.Msg("sdlkf")
    // Key handling can be done via GameUI.SetMouseCallback / keybind systems,
    // but simplest is: only enable this when you already have a keybind or you
    // call it from your own input system.
    if (!root.BHasClass("IsOpen")) return;
    if (choicesRoot.GetChildCount() > 0) return;

    if (isTyping) finishTyping();
    else GameEvents.SendCustomGameEventToServer("dialogue_choice", { choiceLuaIndex: 1 });
  }

  // Wire your custom events
  GameEvents.Subscribe("dialogue_show", show);
  GameEvents.Subscribe("dialogue_hide", hide);

  // Game.AddCommand("+DialogueContinue", onKeyDown, "", 0);
  // Game.AddCommand("-DialogueContinue", onKeyDown, "", 0);
})();
