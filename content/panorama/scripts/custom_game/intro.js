(function () {
    const container = $("#IntroContainer")
    const video = $("#IntroVideo")

    function OnStateChange() {
        var state = Game.GetState();

        if (state === DOTA_GameState.DOTA_GAMERULES_STATE_GAME_IN_PROGRESS) {
            StartIntro();
        }
    }

    function StartIntro() {
        $.Msg("Start intro")

        container.AddClass("ShowVideo");
        video.Play();

        $.Schedule(30.0, SkipIntro);
    }

    function SkipIntro() {
        $.Msg("Stop intro")
        video.Stop();
        video.AddClass("Hide")
        container.RemoveClass("ShowVideo");
        container.AddClass("Hide")
        $.GetContextPanel().style.visibility = "collapse"
    }

    $("#SkipButton").SetPanelEvent("onactivate", () => {
        SkipIntro()
    })

    video.SetPanelEvent("onactivate", () => {
        video.Play()
    })


    GameEvents.Subscribe("game_rules_state_change", OnStateChange);
})();
