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

    local button = CreateFrame("Button", "WDM_WorldMapButton", WorldMapFrame)
    button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")
    button:SetPoint("TOPRIGHT", WorldMapButton, "TOPRIGHT", -4, -2);
    button:SetFrameLevel(99)
    button:SetSize(32, 32)

    local background = button:CreateTexture(nil, "BACKGROUND")
    background:SetSize(25, 25)
    background:SetPoint("TOPLEFT", 2, -4)
    background:SetTexture("Interface\\Minimap\\UI-Minimap-Background")

    local icon = button:CreateTexture(nil, "ARTWORK")
    icon:SetSize(20, 20)
    icon:SetPoint("TOPLEFT", 6, -5)
    icon:SetTexture("Interface\\Minimap\\Tracking\\None")

    local border = button:CreateTexture(nil, "OVERLAY")
    border:SetSize(54, 54)
    border:SetPoint("TOPLEFT")
    border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

    local menuFrame;
    button:SetScript("OnClick", function(self, button, down)
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
            --worldMapAtlasPOI.mapLinkID = 0;
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

    local textureWidth = 1024
    local textureHeight = 1024

    local x1 = math.ceil(tleft * textureWidth)
    local x2 = math.ceil(tleft * textureWidth) + (math.ceil(tright * textureWidth) - math.ceil(tleft * textureWidth))
    local y1 = math.ceil(ttop * textureHeight)
    local y2 = math.ceil(ttop * textureHeight) + (math.ceil(tbottom * textureHeight) - math.ceil(ttop * textureHeight))

    return
        "|TInterface\\AddOns\\WDM\\textures\\objecticonsatlas:".. twidth ..":".. theight.. ":0:0:" ..
        textureWidth .. ":" .. textureHeight .. ":" ..
        x1 .. ":" .. x2 .. ":" .. y1 .. ":" .. y2 .. "|t " ..
        L["show_" .. category .. "_" .. faction .. "_text"]
end

local function AlignQuestieWithWDM()
    local questieButton = _G["Questie_WorldMapButton"]
    local wdmButton = _G["WDM_WorldMapButton"]

    if questieButton and wdmButton then
        questieButton:ClearAllPoints()
        questieButton:SetPoint("RIGHT", wdmButton, "LEFT", 0, 0)
        questieButton:Show()
        return true
    end

    return false
end

local function WaitForQuestieToAlign()
    local waitFrame = CreateFrame("Frame")
    local elapsed = 0
    local interval = 0.5
    waitFrame:SetScript("OnUpdate", function(self, delta)
        elapsed = elapsed + delta
        if elapsed >= interval then
            elapsed = 0
            if AlignQuestieWithWDM() then
                self:SetScript("OnUpdate", nil)
            end
        end
    end)
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:SetScript("OnEvent", function()
    if IsAddOnLoaded("Questie-335") then
        WaitForQuestieToAlign()
    end
end)


function AtlasPOI:WorldMapFrame_Update()
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

