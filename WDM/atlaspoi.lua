local WDM = LibStub("AceAddon-3.0"):GetAddon("WDM")
local AtlasPOI = WDM:NewModule("AtlasPOI", "AceHook-3.0")
local DData = WDM:GetModule("DungeonData")

local Astrolabe = DongleStub("Astrolabe-0.4")
local L = LibStub("AceLocale-3.0"):GetLocale("WDM")
	
local defaults = { profile = {}, }

NUM_WORLDMAP_ATLAS_POI = 0;

function AtlasPOI:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("WDMdb", defaults, true)
    --self:AddTrackingOptions()
end

function AtlasPOI:AddTrackingOptions()
    local _ = CreateFrame("Frame", "UIElementsFrame", WorldMapDetailFrame)
    UIElementsFrame:SetPoint("TOPLEFT", 0, 0, WorldMapDetailFrame)
    UIElementsFrame:SetPoint("BOTTOMRIGHT", 0, 0, WorldMapDetailFrame)

    UIElementsFrame.TrackingOptionsButton = CreateFrame("Frame", nil, UIElementsFrame)
    UIElementsFrame.TrackingOptionsButton:SetSize(32, 32)
    UIElementsFrame.TrackingOptionsButton:SetPoint("TOPRIGHT", -4, -4, UIElementsFrame)

    UIElementsFrame.TrackingOptionsButton.Background = UIElementsFrame.TrackingOptionsButton:CreateTexture(nil, "BACKGROUND")
    UIElementsFrame.TrackingOptionsButton.Icon = UIElementsFrame.TrackingOptionsButton:CreateTexture(nil, "ARTWORK")
    UIElementsFrame.TrackingOptionsButton.IconOverlay = UIElementsFrame.TrackingOptionsButton:CreateTexture(nil, "OVERLAY")

    UIElementsFrame.TrackingOptionsButton.Background:SetSize(25, 25)
    UIElementsFrame.TrackingOptionsButton.Background:SetPoint("TOPLEFT", 2, -4)
    UIElementsFrame.TrackingOptionsButton.Background:SetTexture("Interface\\Minimap\\UI-Minimap-Background")

    UIElementsFrame.TrackingOptionsButton.Icon:SetSize(20, 20)
    UIElementsFrame.TrackingOptionsButton.Icon:SetPoint("TOPLEFT", 6, -6)
    UIElementsFrame.TrackingOptionsButton.Icon:SetTexture("Interface\\Minimap\\Tracking\\None")

    UIElementsFrame.TrackingOptionsButton.IconOverlay:SetPoint("TOPLEFT", UIElementsFrame.TrackingOptionsButton.Icon)
    UIElementsFrame.TrackingOptionsButton.IconOverlay:SetPoint("BOTTOMRIGHT", UIElementsFrame.TrackingOptionsButton.Icon)

    UIElementsFrame.TrackingOptionsButton.Button = CreateFrame("Button", nil, UIElementsFrame.TrackingOptionsButton)
    UIElementsFrame.TrackingOptionsButton.Button:SetSize(32, 32)
    UIElementsFrame.TrackingOptionsButton.Button:SetPoint("TOPLEFT")

    UIElementsFrame.TrackingOptionsButton.Button.Border = UIElementsFrame.TrackingOptionsButton.Button:CreateTexture(nil, "BORDER")
    UIElementsFrame.TrackingOptionsButton.Button.Shine = UIElementsFrame.TrackingOptionsButton.Button:CreateTexture(nil, "OVERLAY")

    UIElementsFrame.TrackingOptionsButton.Button.Border:SetSize(54, 54)
    UIElementsFrame.TrackingOptionsButton.Button.Border:SetPoint("TOPLEFT")
    UIElementsFrame.TrackingOptionsButton.Button.Border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

    UIElementsFrame.TrackingOptionsButton.Button.Shine:SetSize(27, 27)
    UIElementsFrame.TrackingOptionsButton.Button.Shine:SetBlendMode("ADD")
    UIElementsFrame.TrackingOptionsButton.Button.Shine:SetPoint("TOPLEFT", 2, -2)
    UIElementsFrame.TrackingOptionsButton.Button.Shine:SetTexture("Interface\\ComboFrame\\ComboPoint")
    UIElementsFrame.TrackingOptionsButton.Button.Shine:SetTexCoord(0.5625, 1, 0, 1)
    UIElementsFrame.TrackingOptionsButton.Button.Shine:Hide()
end

function AtlasPOI:ShowPOIs()

    local generated_array = DData:GetListAtlasPOI(GetCurrentMapContinent());
    local numAtlasPOI = #generated_array;
    if ( NUM_WORLDMAP_ATLAS_POI < numAtlasPOI )then
        for i=NUM_WORLDMAP_ATLAS_POI+1, numAtlasPOI do
            DData:CreateAtlasPOI(i);
        end
        NUM_WORLDMAP_ATLAS_POI = numAtlasPOI;
    end

    for i = 1, NUM_WORLDMAP_ATLAS_POI do
        local worldMapAtlasPOIName = "WorldMapFrameAtlasPOI"..i;
        local worldMapAtlasPOI = _G[worldMapAtlasPOIName];
        if ( i <= numAtlasPOI ) then
            local faction, x, y, text, desc, twidth, theight, tleft, tright, ttop, tbottom = unpack(generated_array[i]);
            _G[worldMapAtlasPOIName.."Texture"]:SetSize(twidth, theight)
            _G[worldMapAtlasPOIName.."GlowTexture"]:SetSize(twidth, theight)
            _G[worldMapAtlasPOIName.."HighlightTexture"]:SetSize(twidth, theight)

            _G[worldMapAtlasPOIName.."Texture"]:SetTexCoord(tleft, tright, ttop, tbottom);
            _G[worldMapAtlasPOIName.."GlowTexture"]:SetTexCoord(tleft, tright, ttop, tbottom);
            _G[worldMapAtlasPOIName.."HighlightTexture"]:SetTexCoord(tleft, tright, ttop, tbottom);
            x = x * WorldMapButton:GetWidth();
            y = -y * WorldMapButton:GetHeight();
            worldMapAtlasPOI:SetPoint("CENTER", "WorldMapButton", "TOPLEFT", x, y );
            worldMapAtlasPOI.name = text;
            worldMapAtlasPOI.description = desc;
            worldMapAtlasPOI.mapLinkID = 0;
            worldMapAtlasPOI:Show();
        else
            worldMapAtlasPOI:Hide();
        end
    end
end

function AtlasPOI:WorldMapFrame_Update()
   self:ShowPOIs()
   DData:DebugCoords()
end

function AtlasPOI:OnEnable()
	self:SecureHook("WorldMapFrame_Update")
end

function AtlasPOI:OnDisable()
	self:UnhookAll()
	WorldMapFrame_Update()
end
