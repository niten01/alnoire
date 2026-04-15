(function() {
    GameEvents.Subscribe("show_ability_notification", function(data) {
        var container = $("#NotifList");
        
        var notif = $.CreatePanel("Panel", container, "");
        notif.AddClass("AbilityNotif");
        
        var img = $.CreatePanel("DOTAAbilityImage", notif, "");
        img.abilityname = data.ability_name;
        img.AddClass("AbilityIcon");
        
        var label = $.CreatePanel("Label", notif, "");
        label.text = data.message;
        label.AddClass("NotifText");

        $.Schedule(0.1, function() { notif.AddClass("NotifShow"); });

        $.Schedule(data.duration || 5, function() {
            notif.RemoveClass("NotifShow");
            $.Schedule(0.3, function() { notif.DeleteAsync(0); });
        });
    });
})();