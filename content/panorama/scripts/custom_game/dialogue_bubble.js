(function () {
    const label = $("#BubbleText")
    let fullText = "";
    let typingToken = 0;
    let isTyping = false

    function typewriter(text, cps) {
        typingToken++;
        const token = typingToken;

        fullText = text || "";
        isTyping = true;
        label.text = "";

        const charsPerTick = Math.max(1, Math.floor(cps / 20));
        let i = 0;

        function tick() {
            if (token !== typingToken) return;
            if (!isTyping) return;

            i = Math.min(fullText.length, i + charsPerTick);
            label.text = fullText.substring(0, i);

            if (i >= fullText.length) {
                isTyping = false;
                return;
            }
            $.Schedule(0.05, tick);
        }
        tick();
    }

    $.Schedule(0.1, () => {
        typewriter($.GetContextPanel().Data.text || "Pidaras ebaniy, zabil text dobaaaaaaaa", 55)
    })
    // label.text = $.GetContextPanel().Data.text || "PIDARAS EBANIY, ZABIL TEXT DOBAVIT AHAHAHAHA"
})();