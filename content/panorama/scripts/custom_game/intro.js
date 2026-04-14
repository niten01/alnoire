(function () {
    const container = $("#IntroContainer")
    const video = $("#IntroVideo")
    let hidden = true

    function StartIntro() {
        $.Msg("Start intro")

        video.Play();
        video.RemoveClass("Hide")
        container.RemoveClass("Hide")
        $.GetContextPanel().style.visibility = "visible"

        $.Schedule(30.0, SkipIntro);
        hidden = false
    }

    function SkipIntro() {
        $.Msg("Stop intro")
        video.Stop();
        video.AddClass("Hide")
        video.style.visibility = "collapse"
        container.AddClass("Hide")
        container.style.visibility = "collapse"
        $.GetContextPanel().style.visibility = "collapse"
        hidden = true
    }

    $("#SkipButton").SetPanelEvent("onactivate", () => {
        SkipIntro()
    })

    video.SetPanelEvent("onactivate", () => {
        if (!hidden) {
            video.Play()
        }
    })

    GameEvents.Subscribe("start_intro", StartIntro);
    GameEvents.Subscribe("stop_intro", SkipIntro);
})();
