local WDM = LibStub("AceAddon-3.0"):GetAddon("WDM")
local MM = WDM:NewModule("Minimap", "AceHook-3.0")

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

function MM:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("WDMdb", defaults, true)
end

function MM:OnEnable()
    if self.db.profile["show_minimap"] then
        MiniMapWorldMapButtonIcon:Hide()
        MiniMapWorldBorder:Hide()

        MiniMapWorldMapButton:SetSize(32, 32)
        MiniMapWorldMapButton:SetPoint("TOPRIGHT", -2, 23)
        
        MiniMapWorldMapButton:SetNormalTexture("Interface\\AddOns\\WDM\\textures\\ui-minimap-worldmapsquare")
        MiniMapWorldMapButton:SetPushedTexture("Interface\\AddOns\\WDM\\textures\\ui-minimap-worldmapsquare")
        MiniMapWorldMapButton:SetHighlightTexture("Interface\\BUTTONS\\UI-Common-MouseHilight")

        MiniMapWorldMapButton:GetNormalTexture():SetTexCoord(0, 1, 0, 0.5)
        MiniMapWorldMapButton:GetPushedTexture():SetTexCoord(0, 1, 0.5, 1)

        MiniMapWorldMapButton:GetHighlightTexture():SetSize(28,28)
        MiniMapWorldMapButton:GetHighlightTexture():SetPoint("TOPRIGHT", 2, -2)

        
        MinimapZoneTextButton:SetSize(140,12)
        MinimapZoneTextButton:SetPoint("CENTER", 0, 83)

        MinimapZoneText:SetSize(140,12)
        MinimapZoneText:SetPoint("CENTER", MinimapZoneTextButton, "TOP", 0, -6)


        -- GameTime (Calendar)
        GameTimeFrame:SetPoint("TOPRIGHT", 20, -2)
        
        -- Mail
        MiniMapMailFrame:SetPoint("TOPRIGHT", 24, -37)
    end
end