local WDM = LibStub("AceAddon-3.0"):GetAddon("WDM")
local AtlasPOI = WDM:NewModule("AtlasPOI", "AceHook-3.0")
local DData = WDM:GetModule("DungeonData")

local Astrolabe = DongleStub("Astrolabe-0.4")
local L = LibStub("AceLocale-3.0"):GetLocale("WDM")

local defaults = {
    profile = {
        ["show_minimap"] = false,
        ["show_zonelevel"] = false,
        ["show_taxinode"] = true,
        ["show_taxinode_opposite"] = false,
        ["show_taxinode_continent"] = true,
        ["show_taxinode_continent_opposite"] = false,
        ["show_instance"] = true,
        ["microdungeons"] = false,
        ["debugmode"] = false
    }
}

NUM_WORLDMAP_ATLAS_POI = 0;

function AtlasPOI:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("WDMdb", defaults, true)
end

function AtlasPOI:AddTrackingOptions()
    local menu = {
        {text = L["atlas_tracking_title_text"], isTitle = true}, {
            text = self:GetAtlasTOtext("taxinode", false),
            keepShownOnClick = 1,
            checked = function() return self.db.profile.show_taxinode end,
            func = function()
                self.db.profile.show_taxinode = not self.db.profile
                                                    .show_taxinode
                WorldMapFrame_Update()
            end,
            hasArrow = true,
            menuList = {
                {
                    text = self:GetAtlasTOtext("taxinode", true),
                    keepShownOnClick = 1,
                    checked = function()
                        return self.db.profile.show_taxinode_opposite
                    end,
                    func = function()
                        self.db.profile.show_taxinode_opposite = not self.db
                                                                     .profile
                                                                     .show_taxinode_opposite
                        WorldMapFrame_Update()
                    end
                }
            }
        }, {
            text = self:GetAtlasTOtext("taxinode_continent", false),
            keepShownOnClick = 1,
            checked = function()
                return self.db.profile.show_taxinode_continent
            end,
            func = function()
                self.db.profile.show_taxinode_continent = not self.db.profile
                                                              .show_taxinode_continent
                WorldMapFrame_Update()
            end,
            hasArrow = true,
            menuList = {
                {
                    text = self:GetAtlasTOtext("taxinode_continent", true),
                    keepShownOnClick = 1,
                    checked = function()
                        return self.db.profile.show_taxinode_continent_opposite
                    end,
                    func = function()
                        self.db.profile.show_taxinode_continent_opposite =
                            not self.db.profile.show_taxinode_continent_opposite
                        WorldMapFrame_Update()
                    end
                }
            }
        }, {
            text = L["show_instance_text"],
            keepShownOnClick = 1,
            checked = function() return self.db.profile.show_instance end,
            func = function()
                self.db.profile.show_instance = not self.db.profile
                                                    .show_instance
                WorldMapFrame_Update()
            end
        }, {
            text = L["show_zonelevel_text"],
            keepShownOnClick = 1,
            checked = function()
                return self.db.profile.show_zonelevel
            end,
            func = function()
                self.db.profile.show_zonelevel = not self.db.profile
                                                     .show_zonelevel
                WorldMapFrame_Update()
            end
        }
    }

    AtlasTO = CreateFrame("Frame", nil, WorldMapButton)
    AtlasTO:SetSize(32, 32)
    AtlasTO:SetPoint("TOPRIGHT", -4, -4, WorldMapButton)

    AtlasTO.Background = AtlasTO:CreateTexture(nil, "BACKGROUND")
    AtlasTO.Icon = AtlasTO:CreateTexture(nil, "ARTWORK")
    AtlasTO.IconOverlay = AtlasTO:CreateTexture(nil, "OVERLAY")

    AtlasTO.Background:SetSize(25, 25)
    AtlasTO.Background:SetPoint("TOPLEFT", 2, -4)
    AtlasTO.Background:SetTexture("Interface\\Minimap\\UI-Minimap-Background")

    AtlasTO.Icon:SetSize(20, 20)
    AtlasTO.Icon:SetPoint("TOPLEFT", 6, -6)
    AtlasTO.Icon:SetTexture("Interface\\Minimap\\Tracking\\None")

    AtlasTO.IconOverlay:SetPoint("TOPLEFT", AtlasTO.Icon)
    AtlasTO.IconOverlay:SetPoint("BOTTOMRIGHT", AtlasTO.Icon)

    AtlasTO.Button = CreateFrame("Button", nil, AtlasTO)
    AtlasTO.Button:SetSize(32, 32)
    AtlasTO.Button:SetPoint("TOPLEFT")
    AtlasTO.Button:SetHighlightTexture(
        "Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    AtlasTO.Button.Border = AtlasTO.Button:CreateTexture(nil, "BORDER")

    AtlasTO.Button.Border:SetSize(54, 54)
    AtlasTO.Button.Border:SetPoint("TOPLEFT")
    AtlasTO.Button.Border:SetTexture(
        "Interface\\Minimap\\MiniMap-TrackingBorder")

    local menuFrame;
    AtlasTO.Button:SetScript("OnClick", function(self, button, down)
        if not menuFrame then
            menuFrame = CreateFrame("Frame", "MyMenuFrame", UIParent,
                                    "UIDropDownMenuTemplate")
        end
        EasyMenu(menu, menuFrame, self, 0, 0, "MENU", 0)
    end)

end

function AtlasPOI:ShowPOIs()

    local generated_array = DData:GetListAtlasPOI(GetCurrentMapContinent());
    local numAtlasPOI = #generated_array;
    if (NUM_WORLDMAP_ATLAS_POI < numAtlasPOI) then
        for i = NUM_WORLDMAP_ATLAS_POI + 1, numAtlasPOI do
            DData:CreateAtlasPOI(i);
        end
        NUM_WORLDMAP_ATLAS_POI = numAtlasPOI;
    end

    for i = 1, NUM_WORLDMAP_ATLAS_POI do
        local worldMapAtlasPOIName = "WorldMapFrameAtlasPOI" .. i;
        local worldMapAtlasPOI = _G[worldMapAtlasPOIName];
        if (i <= numAtlasPOI) then
            local faction, x, y, text, desc, twidth, theight, tleft, tright,
                  ttop, tbottom = unpack(generated_array[i]);
            _G[worldMapAtlasPOIName .. "Texture"]:SetSize(twidth, theight)
            _G[worldMapAtlasPOIName .. "GlowTexture"]:SetSize(twidth, theight)
            _G[worldMapAtlasPOIName .. "HighlightTexture"]:SetSize(twidth,
                                                                   theight)

            _G[worldMapAtlasPOIName .. "Texture"]:SetTexCoord(tleft, tright,
                                                              ttop, tbottom);
            _G[worldMapAtlasPOIName .. "GlowTexture"]:SetTexCoord(tleft, tright,
                                                                  ttop, tbottom);
            _G[worldMapAtlasPOIName .. "HighlightTexture"]:SetTexCoord(tleft,
                                                                       tright,
                                                                       ttop,
                                                                       tbottom);
            x = x * WorldMapButton:GetWidth();
            y = -y * WorldMapButton:GetHeight();
            worldMapAtlasPOI:SetPoint("CENTER", "WorldMapButton", "TOPLEFT", x,
                                      y);
            worldMapAtlasPOI.name = text;
            worldMapAtlasPOI.description = desc;
            worldMapAtlasPOI.mapLinkID = 0;
            worldMapAtlasPOI:Show();
        else
            worldMapAtlasPOI:Hide();
        end
    end
end

function AtlasPOI:GetAtlasTOtext(category, opposite)
    local faction, _ = UnitFactionGroup("player"):lower()
    if opposite then
        if faction == "alliance" then
            faction = "horde"
        else
            faction = "alliance"
        end
    end
    local twidth, theight, tleft, tright, ttop, tbottom =
        DData:GetAtlasTextureCoords(category, faction)
    -- print()
    return
        "|TInterface\\AddOns\\WDM\\textures\\objecticonsatlas:18:18:0:0:512:1024:" ..
            math.ceil(tleft * 512) .. ":" .. (math.ceil(tleft * 512) + twidth) ..
            ":" .. math.ceil(ttop * 1024) .. ":" ..
            (math.ceil(ttop * 1024) + theight) .. "|t " ..
            L["show_" .. category .. "_" .. faction .. "_text"]

end

function AtlasPOI:WorldMapFrame_Update()
    if WORLDMAP_SETTINGS.size == WORLDMAP_WINDOWED_SIZE then
        AtlasTO:SetScale(1 + WORLDMAP_SETTINGS.size)
    else
        AtlasTO:SetScale(1)
    end
    self:ShowPOIs()
    DData:DebugCoords()
end

function AtlasPOI:OnEnable()
    self:SecureHook("WorldMapFrame_Update")
    self:AddTrackingOptions()
end

function AtlasPOI:OnDisable()
    self:UnhookAll()
    WorldMapFrame_Update()
end
