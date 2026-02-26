const PlayerTables = GameUI.CustomUIConfig().PlayerTables
const PT_NAME = "flow_bar_" + Game.GetLocalPlayerID()

$.Msg('[flow_bar.js] Loaded');

function UpdateStackBar() {
    var unit = Players.GetLocalPlayerPortraitUnit();

    let stackCount = PlayerTables.GetTableValue(PT_NAME, "stackCount")
    let maxStacks = PlayerTables.GetTableValue(PT_NAME, "maxStacks") || 100

    var fillPercent = (stackCount / maxStacks) * 100;
    $("#StackBarFill").style.width = fillPercent + "%";
    const label = $("#StackCountLabel")
    label.text = stackCount;

    $.GetContextPanel().SetHasClass("HighStacks", stackCount >= (maxStacks * 0.6));
    $.GetContextPanel().SetHasClass("MaxStacks", stackCount >= maxStacks);
    $.GetContextPanel().SetHasClass("MaxStacksShake", stackCount >= maxStacks);

    SetUIPosition(Entities.GetUnitName(unit) == "npc_dota_hero_sanya_rapper");
}

function SetUIPosition(replaceMana) {

    var container = $.GetContextPanel();
    var hud = $.GetContextPanel().FindAncestor("DotaHud");
    var manaBar = hud.FindChildTraverse("ManaContainer");

    for (const child of manaBar.Children()) {
        child.style.visibility = replaceMana ? "collapse" : "visible";
    }

    if (replaceMana && manaBar) {
        container.style.visibility = "visible";
        container.SetParent(manaBar);
        container.AddClass("ReplaceMana");
    } else {
        container.style.visibility = "collapse";
    }
}

(function () {
    GameEvents.Subscribe("dota_player_update_selected_unit", UpdateStackBar);
    GameEvents.Subscribe("dota_player_update_query_unit", UpdateStackBar);

    PlayerTables.SubscribeNetTableListener(PT_NAME, UpdateStackBar)
})();