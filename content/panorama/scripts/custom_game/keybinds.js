$.Msg("[keybinds.js] Loaded");

const KEY_BINDS = {
    // abilityName: keyBind
}

const ABILITY_LAYOUT_INDEX = {
    // abilityName: index
}

function RegisterKeyBind(keyBind, callback) {
    let uniqueCommandName = "+" + "custom_" + keyBind + "_" + Date.now();
    Game.AddCommand(uniqueCommandName, callback, "", 0);
    Game.CreateCustomKeyBind(keyBind, uniqueCommandName);
    $.Msg(`Registered keybinding "${keyBind}" on command "${uniqueCommandName}"`)
}

function DrawKeyBinds() {
    var unit = Players.GetLocalPlayerPortraitUnit();
    var player = Players.GetPlayerHeroEntityIndex(Players.GetLocalPlayer());
    if (unit != player) return
    const container = $.GetContextPanel();
    const hud = $.GetContextPanel().FindAncestor("DotaHud");

    for (const [abilityName, key] of Object.entries(KEY_BINDS)) {
        const rowIdx = ABILITY_LAYOUT_INDEX[abilityName]
        const abilityContainer = hud.FindChildTraverse(`Ability${rowIdx}`)
        if (!abilityContainer) continue

        const hotkeyLbl = abilityContainer.FindChildTraverse("HotkeyText")
        hotkeyLbl.text = key
        const hotkeyContainer = abilityContainer.FindChildTraverse("Hotkey")
        hotkeyContainer.style.visibility = "visible"
    }
}

function CastAbility(abilityName) {
    GameEvents.SendCustomGameEventToServer("keybind_cast_ability", {
        abilityName: abilityName
    });
}

function RegisterBind(data) {
    KEY_BINDS[data.abilityName] = data.key
    ABILITY_LAYOUT_INDEX[data.abilityName] = data.layoutIndex
    RegisterKeyBind(data.key, () => {
        if (KEY_BINDS[data.abilityName] != data.key) return

        CastAbility(data.abilityName)
    })
    DrawKeyBinds()
}

(function () {
    GameEvents.Subscribe("dota_player_update_selected_unit", DrawKeyBinds);
    GameEvents.Subscribe("dota_player_update_query_unit", DrawKeyBinds);
    GameEvents.Subscribe("game_rules_state_change", () => {
        $.Schedule(3, DrawKeyBinds);
    });

    GameEvents.Subscribe("keybind_register_bind", RegisterBind)
})();