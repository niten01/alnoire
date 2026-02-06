(function () {
    const localPlayerId = Game.GetLocalPlayerID();
    let quests = {}

    function GetNewQuests(questlog) {
        const oldQuests = [...Object.values(quests)]
        const newQuests = [...Object.values(questlog)]
        let result = []
        for (const nq of newQuests) {
            if (!oldQuests.find(q => JSON.stringify(q) === JSON.stringify(nq))) {
                result.push(nq)
            }
        }

        return result
    }

    Set.prototype.find = function () {
        return Array.prototype.find.apply([...this], arguments);
    };

    function RenderQuests(questlog) {
        const list = $("#QuestList");
        if (!list) return;

        const newQuests = GetNewQuests(questlog || {})
        list.RemoveAndDeleteChildren();

        quests = questlog || {}

        const noQuests = $("#NoQuestsLabel")
        if (Object.keys(quests).length == 0) {
            noQuests.style.visibility = "visible"
            return;
        }

        noQuests.style.visibility = "collapse"
        for (const [_, q] of Object.entries(quests)) {
            const id = "QuestItem_" + q.questID
            const item = $.CreatePanel("Panel", list, id);
            item.AddClass("QuestItem");
            if (newQuests.find(nq => nq.name == q.name)) {
                const questTab = $("#QuestTab")
                item.AddClass("QuestItemBlink")
                questTab.AddClass("QuestTabBlink")
                $.Schedule(0.5, () => {
                    const item = $("#" + id)
                    if (item)
                        item.RemoveClass("QuestItemBlink")
                    questTab.RemoveClass("QuestTabBlink")
                })
            }

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

function ToggleQuestLog() {
    GameUI.CustomUIConfig().ToggleQuestLog();
}
