function ShowInteractHint()
    CustomGameEventManager:Send_ServerToAllClients("show_hint_event", {
        text = "Стоя рядом с персонажем,\nвыбери его (ЛКМ), чтобы взаимодействовать!",
        duration = 8.0
    })
end
