local WDM = LibStub("AceAddon-3.0"):NewAddon("WDM", "AceEvent-3.0", "AceHook-3.0", "AceConsole-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("WDM")

local options = {
    name = "WoW Dungeon Maps",
    handler = WDM,
    type = "group",
    args = {
        show_minimap = {
            type = "toggle",
            name = L["show_minimap_text"],
            desc = L["show_minimap_warn_text"],
            get = "GetMinimap",
            set = "ToggleMinimap",
            descStyle = "inline",
            width = "double",
        },
        microdungeons = {
            type = "toggle",
            name = L["microdungeons_text"],
            desc = L["microdungeons_warn_text"],
            get = "GetMicrodungeons",
            set = "ToggleMicrodungeons",
            descStyle = "inline",
            width = "double",
        },
    },
}

local defaults = { profile = {
    ["show_minimap"] = false,
    ["show_zonelevel"] = false,
    ["show_taxinode"] = true,
    ["show_taxinode_opposite"] = false,
    ["show_taxinode_continent"] = true,
    ["show_taxinode_continent_opposite"] = false,
    ["show_instance"] = true,
    ["microdungeons"] = false,
    ["debugmode"] = false,
},}


function WDM:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("WDMdb", defaults, true)

    LibStub("AceConfig-3.0"):RegisterOptionsTable("WDM", options)
    self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("WDM", "WoW Dungeon Maps")
    self:RegisterChatCommand("wdm", "ChatCommand")
end

function WDM:ChatCommand(input)
    if not input or input:trim() == "" then
        InterfaceOptionsFrame_OpenToCategory(self.optionsFrame)
    elseif input == "debug" then
        -- Toggle the debug option
        self:SetDebug(nil, not self:GetDebug())
    else
        LibStub("AceConfigCmd-3.0"):HandleCommand("wdm", "WDM", input)
    end
end

function WDM:GetDebug(info)
    return self.db.profile.debugmode
end

function WDM:SetDebug(info, value)
    self.db.profile.debugmode = value
    if self.db.profile.debugmode then
        print("[WDM] Debugging |c00569C08enabled|r")
    else
        print("[WDM] Debugging |c00FD1A36disabled|r")
    end
end

function WDM:GetMicrodungeons(info)
    return self.db.profile.microdungeons
end

function WDM:GetMinimap(info)
    return self.db.profile.show_minimap
end

function WDM:ToggleMicrodungeons(info, value)
    self.db.profile.microdungeons = value
end

function WDM:ToggleMinimap(info, value)
    self.db.profile.show_minimap = value
end