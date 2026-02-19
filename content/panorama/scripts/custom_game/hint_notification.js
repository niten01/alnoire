(function() {
    var hintPanel = $("#HintPanel");
    var hintLabel = $("#HintLabel");
    var hideTimer = null;

    function ShowHint(data) {
        hintLabel.text = $.Localize(data.text || "No Text Provided");

        hintPanel.RemoveClass("Hidden");

        if (hideTimer) { $.CancelScheduled(hideTimer); }
        
        hideTimer = $.Schedule(data.duration || 5.0, function() {
            hintPanel.AddClass("Hidden");
            hideTimer = null;
        });
    }

    GameEvents.Subscribe("show_hint_event", ShowHint);
})();