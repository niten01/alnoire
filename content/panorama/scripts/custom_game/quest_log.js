(function () {
    const localPlayerId = Game.GetLocalPlayerID();

    function RenderQuests(questlog) {
        const list = $("#QuestList");
        if (!list) return;

        list.RemoveAndDeleteChildren();

        const quests = questlog || {}

        const noQuests = $("#NoQuestsLabel")
        if (Object.keys(quests).length == 0) {
            noQuests.style.visibility = "visible"
            return;
        }

        noQuests.style.visibility = "collapse"
        for (const [_, q] of Object.entries(quests)) {
            const item = $.CreatePanel("Panel", list, "");
            item.AddClass("QuestItem");

            const name = $.CreatePanel("Label", item, "");
            name.AddClass("QuestName");
            name.text = q.name || "<Unnamed quest>";

            const step = $.CreatePanel("Label", item, "");
            step.AddClass("QuestStep");
            step.text = q.stepDescription || "";
        }
    }

    GameUI.CustomUIConfig().ToggleQuestLog = function ToggleQuestLog() {
        const root = $.GetContextPanel();
        if (!root) return;

        const collapsed = root.BHasClass("Collapsed");
        root.SetHasClass("Collapsed", !collapsed);
    };

    function FetchQuestLog() {
        return CustomNetTables.GetTableValue("questlog", String(localPlayerId));
    }

    function RefreshFromNetTable() {
        RenderQuests(FetchQuestLog())
    }

    CustomNetTables.SubscribeNetTableListener("questlog", function (tableName, key, data) {
        if (key === String(localPlayerId)) {
            RenderQuests(data);
        }
    });

    $.Schedule(0.0, RefreshFromNetTable);
})();

// Make the function name visible to inline XML onactivate="ToggleQuestLog()"
function ToggleQuestLog() {
    GameUI.CustomUIConfig().ToggleQuestLog();
}
