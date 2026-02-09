(function () {
    const container = $("#IntroContainer")
    const video = $("#IntroVideo")

    function StartIntro() {
        $.Msg("Start intro")

        video.Play();

        $.Schedule(30.0, SkipIntro);
    }

    function SkipIntro() {
        $.Msg("Stop intro")
        video.Stop();
        video.AddClass("Hide")
        container.AddClass("Hide")
        $.GetContextPanel().style.visibility = "collapse"
    }

    $("#SkipButton").SetPanelEvent("onactivate", () => {
        SkipIntro()
    })

    video.SetPanelEvent("onactivate", () => {
        video.Play()
    })

    GameEvents.Subscribe("start_intro", StartIntro);
})();
