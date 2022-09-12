local WDM = LibStub("AceAddon-3.0"):NewAddon("WDM", "AceEvent-3.0", "AceHook-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("WDM")

local options = {
    name = "WoW Dungeon Maps",
    handler = WDM,
    type = "group",
    args = {},
}
local defaults = {
    profile =  {

    },
}


function WDM:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("WDMdb", defaults, true)

    LibStub("AceConfig-3.0"):RegisterOptionsTable("WDM", options)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("WDM", "WoW Dungeon Maps")
    self:RegisterChatCommand("wdm", "ChatCommand")
end

function WDM:ChatCommand(input)
    if not input or input:trim() == "" then
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
    else
        LibStub("AceConfigCmd-3.0"):HandleCommand("wdm", "WDM", input)
    end
end