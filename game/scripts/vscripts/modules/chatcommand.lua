--[[
===== ChatCommand =====
Makes it easier to create commands from anywhere in your code.
Does not break when using script_reload
Usage:
  -Create a function MyFunction(keys)             OR     function SomeClass:SomeFunction(keys)
    keys are those delivered from the 'player_chat' event
  -Use ChatCommand:LinkDevCommand("-MyTrigger", MyFunction, context)
    Use this to call this function everytime someone's chat starts with -MyTrigger
created by Zarnotox with a lot of constructive help from the mod data guys https://discord.gg/Z7eCcGT (THIS IS NOT THE OAA DISCORD, THIS IS THE MODDATA DISCORD. YOU DID NOT FIND THE SECRET. check it out!)
]]

ChatCommand = ChatCommand or {}

function ChatCommand:Init()
  GameEvents:OnPlayerUsedChat(bind(self.OnPlayerChat, self))
end

-- Function to create the link
function ChatCommand:LinkDevCommand(command, func)
  self.dev_commands = self.dev_commands or {}
  self.dev_commands[command] = func
end

-- Function to create the link
function ChatCommand:LinkCommand(command, func)
  self.commands = self.commands or {}
  self.commands[command] = func
end

-- Function that's called when somebody chats
function ChatCommand:OnPlayerChat(event)
  self.dev_commands = self.dev_commands or {}
  self.commands = self.commands or {}
  local text = string.lower(event.text)
  local splitted = split(text, " ")
  local commandName = splitted[1]
  table.remove(splitted, 1)

  if self.commands[commandName] ~= nil then
    ChatCommand:DoCommand(event, self.commands[commandName], splitted)
  elseif (IsInToolsMode() or GameRules:IsCheatMode()) and self.dev_commands[commandName] ~= nil then
    ChatCommand:DoCommand(event, self.dev_commands[commandName], splitted)
  end
end

function ChatCommand:DoCommand(event, func, args)
  func(event, args)
end

return ChatCommand
