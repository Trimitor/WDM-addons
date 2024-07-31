local WDM = LibStub("AceAddon-3.0"):GetAddon("WDM")
local MD = WDM:NewModule("MicroDungeons", "AceHook-3.0")

local LBZ = LibStub("LibBabble-Zone-3.0", true)
local BZ = LBZ and LBZ:GetLookupTable() or
               setmetatable({}, {__index = function(t, k) return k end})

local LBSZ = LibStub("LibBabble-SubZone-3.0", true)
local BSZ = LBSZ and LBSZ:GetLookupTable() or
                setmetatable({}, {__index = function(t, k) return k end})

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

local data = {
    { -- Kalimdor
        ["Ashenvale"] = 43,
        ["Azshara"] = 181,
        ["Azuremyst Isle"] = 464,
        ["Bloodmyst Isle"] = 476,
        ["Darkshore"] = 42,
        ["Darnassus"] = 381,
        ["Desolace"] = 101,
        ["Durotar"] = 4,
        ["Dustwallow Marsh"] = 141,
        ["Felwood"] = 182,
        ["Feralas"] = 121,
        ["Moonglade"] = 241,
        ["Mulgore"] = 9,
        ["Orgrimmar"] = 321,
        ["Silithus"] = 261,
        ["Stonetalon Mountains"] = 81,
        ["Tanaris"] = 161,
        ["Teldrassil"] = 41,
        ["The Barrens"] = 11,
        ["The Exodar"] = 471,
        ["Thousand Needles"] = 61,
        ["Thunder Bluff"] = 362,
        ["Un'Goro Crater"] = 201,
        ["Winterspring"] = 281
    }, { -- Eastern Kingdoms
        ["Alterac Mountains"] = 15,
        ["Arathi Highlands"] = 16,
        ["Badlands"] = 17,
        ["Blasted Lands"] = 19,
        ["Burning Steppes"] = 29,
        ["Deadwind Pass"] = 32,
        ["Dun Morogh"] = 27,
        ["Duskwood"] = 34,
        ["Eastern Plaguelands"] = 23,
        ["Elwynn Forest"] = 30,
        ["Eversong Woods"] = 462,
        ["Ghostlands"] = 463,
        ["Hillsbrad Foothills"] = 24,
        ["Ironforge"] = 341,
        ["Isle of Quel'Danas"] = 499,
        ["Loch Modan"] = 35,
        ["Redridge Mountains"] = 36,
        ["Searing Gorge"] = 28,
        ["Silvermoon City"] = 480,
        ["Silverpine Forest"] = 21,
        ["Stormwind City"] = 301,
        ["Stranglethorn Vale"] = 37,
        ["Swamp of Sorrows"] = 38,
        ["The Hinterlands"] = 26,
        ["Tirisfal Glades"] = 20,
        ["Undercity"] = 382,
        ["Western Plaguelands"] = 22,
        ["Westfall"] = 39,
        ["Wetlands"] = 40
    }
}

local subzones = {
    ["Elwynn Forest"] = {
        ["Fargodeep Mine"] = 1001,
        ["Jasperlode Mine"] = 1019,
        ["Echo Ridge Mine"] = 1003
    },
    ["Dun Morogh"] = {
        ["Coldridge Pass"] = 1006,
        ["Frostmane Hold"] = 1008,
        ["Gol'Bolar Quarry"] = 1011,
        -- ["Frostmane Hovel"] = 1009,
        ["Gnomeregan"] = 1010
    }
}

local mdlevels = {
    ["Fargodeepmine1_"] = {"Elwynn", 1, 1001},
    ["Fargodeepmine2_"] = {"Elwynn", 2, 1002},
    ["EchoRidgeMine3_"] = {"Northshire", 3, 1003},
    ["GoldCoastQuarry4_"] = {"Westfall", 4, 1004},
    ["JangolodeMine5_"] = {"Westfall", 5, 1005},
    ["ColdridgePass6_"] = {"DunMorogh", 6, 1006},
    ["TheGrizzledDen7_"] = {"DunMorogh", 7, 1007},
    ["FrostmaneHold8_"] = {"NewTinkertown", 8, 1008},
    ["FrostmaneHovel9_"] = {"ColdridgeValley", 9, 1009},
    ["GnomereganEntrance10_"] = {"DunMorogh", 10, 1010},
    ["GolBolarQuarry11_"] = {"DunMorogh", 11, 1011},
    ["NightWebsHollow12_"] = {"Tirisfal", 12, 1012},
    ["ScarletMonasteryEntrance13_"] = {"Tirisfal", 13, 1013},
    ["BlackrockMountain14_"] = {"BurningSteppes", 14, 1014},
    ["BlackrockMountain15_"] = {"BurningSteppes", 15, 1015},
    ["BlackrockMountain16_"] = {"BurningSteppes", 16, 1016},
    ["DeadminesWestfall17_"] = {"Westfall", 17, 1017},
    ["Uldaman18_"] = {"Badlands", 18, 1018},
    ["JasperlodeMine19_"] = {"Elwynn", 19, 1019},
    ["Ogrimmar"] = {"Orgrimmar", 0, 321},
    ["Ogrimmar1_"] = {"Orgrimmar", 1, 1020},
    ["ShadowthreadCave2_"] = {"Teldrassil", 2, 1021},
    ["FelRock3_"] = {"Teldrassil", 3, 1022},
    ["BanethilBarrowden4_"] = {"Teldrassil", 4, 1023},
    ["BanethilBarrowden5_"] = {"Teldrassil", 5, 1024},
    ["PalemaneRock6_"] = {"Mulgore", 6, 1025},
    ["TheVentureCoMine7_"] = {"Mulgore", 7, 1026},
    ["BurningBladeCoven8_"] = {"Durotar", 8, 1027},
    ["TiragardeKeep10_"] = {"Durotar", 10, 1028},
    ["TiragardeKeep11_"] = {"Durotar", 11, 1029},
    ["SkullRock12_"] = {"Durotar", 12, 1030},
    ["TwilightsRun13_"] = {"Silithus", 13, 1031},
    ["TheSlitheringScar14_"] = {"UngoroCrater", 14, 1032},
    ["TheNoxiousLair15_"] = {"Tanaris", 15, 1033},
    ["TheGapingChasm16_"] = {"Tanaris", 16, 1034},
    ["CavernsofTime17_"] = {"Tanaris", 17, 1035},
    ["CavernsofTime18_"] = {"Tanaris", 18, 1036},
    ["DustwindCave19_"] = {"Durotar", 19, 1037},
    ["WailingCavernsBarrens20_"] = {"Barrens", 20, 1038},
    ["MaraudonOutside21_"] = {"Desolace", 21, 1039},
    ["MaraudonOutside22_"] = {"Desolace", 22, 1040},
    ["AmaniCatacombs1_"] = {"Ghostlands", 1, 1041},
    ["TidesHollow2_"] = {"AzermystIsle", 2, 1042},
    ["StillpineHold3_"] = {"AzermystIsle", 3, 1043}
}

function MD:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("WDMdb", defaults, true)
    
    self.zone_names = {}
    self.zone_data = {}

    for key, idata in pairs(data) do
        local names = {}
        local name_data = {}
        for name, zdata in pairs(idata) do
            tinsert(names, BZ[name])
            name_data[BZ[name]] = zdata
        end
        table.sort(names)
        self.zone_names[key] = names

        local zone_data = {}
        for k, v in pairs(names) do zone_data[k] = name_data[v] end
        self.zone_data[key] = zone_data
    end
    data = nil

    self.mdlevels = {}

    for key, value in pairs(mdlevels) do
        if self.mdlevels[key] == nil then self.mdlevels[key] = {} end

        for k, v in pairs(mdlevels) do
            local k_match = string.match(k, "(.-)%d*_$") or k -- изменено здесь
            local key_match = string.match(key, "(.-)%d*_$") or key -- изменено здесь

            if k_match == key_match then
                table.insert(self.mdlevels[key], v)
            end
        end
    end

    for key, value in pairs(self.mdlevels) do
        table.sort(value, function(a, b) return a[2] < b[2] end)
    end

    mdlevels = nil

    self.sub_zones = {}

    for key, value in pairs(subzones) do
        local names = {}
        local lkey = BZ[key]
        for name, zdata in pairs(value) do tinsert(names, BSZ[name]) end
        table.sort(names)

        self.sub_zones[lkey] = names
    end

    subzones = nil

end

function MD:OnEnable()
    self:SecureHook("WorldMapLevelDropDown_Update")
    self:SecureHook("WorldMapZoneDropDown_Update")
    WorldMapLevelUpButton:HookScript("OnClick", DungeonMapLevelUp_OnClick)
    WorldMapLevelDownButton:HookScript("OnClick", DungeonMapLevelDown_OnClick)
end

function MD:WorldMapLevelDropDown_Update()
    local mapName, _, _ = GetMapInfo()
    if not self.mdlevels[mapName] or not self.db.profile.microdungeons then return end

    UIDropDownMenu_Initialize(WorldMapLevelDropDown,
                              MicroDungeonLevelDropDown_Initialize);
    UIDropDownMenu_SetWidth(WorldMapLevelDropDown, 130);

    UIDropDownMenu_SetSelectedID(WorldMapLevelDropDown,
                                 GetCurrentMicroDungeonLevel());

    WorldMapLevelDropDown:Show();
    if (WORLDMAP_SETTINGS.size ~= WORLDMAP_WINDOWED_SIZE) then
        WorldMapLevelUpButton:Show();
        WorldMapLevelDownButton:Show();
    end
    if self.mdlevels[mapName][GetCurrentMicroDungeonLevel()][2] ~= 0 then
        for i = 1, NUM_WORLDMAP_ATLAS_POI do
            _G["WorldMapFrameAtlasPOI" .. i]:Hide()
        end
    end
end

function DungeonMapLevelUp_OnClick(self)
    local mapName, _, _ = GetMapInfo()
    if not MD.mdlevels[mapName] then return end

    if GetCurrentMicroDungeonLevel() > 1 then
        UIDropDownMenu_SetSelectedID(WorldMapLevelDropDown,
                                     GetCurrentMicroDungeonLevel() - 1);
        SetMapByID(MD.mdlevels[mapName][GetCurrentMicroDungeonLevel() - 1][3]);
        PlaySound("UChatScrollButton");
    end
end

function DungeonMapLevelDown_OnClick(self)
    local mapName, _, _ = GetMapInfo()
    if not MD.mdlevels[mapName] then return end

    if GetCurrentMicroDungeonLevel() < #MD.mdlevels[mapName] then
        UIDropDownMenu_SetSelectedID(WorldMapLevelDropDown,
                                     GetCurrentMicroDungeonLevel() + 1);
        SetMapByID(MD.mdlevels[mapName][GetCurrentMicroDungeonLevel() + 1][3]);
        PlaySound("UChatScrollButton");
    end
end

function GetCurrentMicroDungeonLevel()
    local mapName, _, _ = GetMapInfo()
    local curmdlist = MD.mdlevels[mapName]
    local match = tonumber(string.match(mapName, "%d+"))
    if match == nil then match = 0 end

    for i = 1, #curmdlist do if curmdlist[i][2] == match then return i end end
end

function MicroDungeonLevelDropDown_Initialize()
    local info = UIDropDownMenu_CreateInfo()
    local level = GetCurrentMicroDungeonLevel()
    local curmd = MD.mdlevels[GetMapInfo()]

    for i = 1, #curmd do
        local mapname = curmd[i][1]:upper();
        local floorNum = curmd[i][2];
        local floorname = _G["DUNGEON_FLOOR_" .. mapname .. floorNum];
        info.text = floorname or string.format(FLOOR_NUMBER, floorNum);
        info.func = MicroDungeonLevelButton_OnClick;
        info.checked = (i == level);
        UIDropDownMenu_AddButton(info);
    end
end

function MicroDungeonLevelButton_OnClick(self)
    UIDropDownMenu_SetSelectedID(WorldMapLevelDropDown, self:GetID());
    SetMapByID(MD.mdlevels[GetMapInfo()][self:GetID()][3]);
end

function MD:WorldMapZoneDropDown_Update()
    if not self.zone_names[GetCurrentMapContinent()] or not self.db.profile.microdungeons then return end
    UIDropDownMenu_Initialize(WorldMapZoneDropDown,
                              WDMZoneDropDown_Initialize);
    UIDropDownMenu_SetWidth(WorldMapZoneDropDown, 130);

    if ((GetCurrentMapContinent() == 0) or
        (GetCurrentMapContinent() == WORLDMAP_COSMIC_ID)) then
        UIDropDownMenu_ClearAll(WorldMapZoneDropDown);
    else
        UIDropDownMenu_SetSelectedID(WorldMapZoneDropDown, MD:WDM2Blizz());
    end

end

function WDMZoneDropDown_Initialize()
    local info = UIDropDownMenu_CreateInfo();
    local zone_names = MD.zone_names[GetCurrentMapContinent()];
    for k, v in pairs(zone_names) do
        info.text = v;
        info.func = WDMZoneButton_OnClick;
        info.checked = (k == MD:WDM2Blizz());
        -- TODO: create submenus
        UIDropDownMenu_AddButton(info);
    end
end

function WDMZoneButton_OnClick(self)
    UIDropDownMenu_SetSelectedID(WorldMapZoneDropDown, self:GetID());
    SetMapByID(MD.zone_data[GetCurrentMapContinent()][self:GetID()]);
end

function MD:WDM2Blizz()
    local blizMapID = GetCurrentMapZone()
    if blizMapID == 0 then return nil end
    local blizMapName = select(blizMapID, GetMapZones(GetCurrentMapContinent()))
    for k, v in pairs(self.zone_names[GetCurrentMapContinent()]) do
        if v == blizMapName then
            return k
        end
    end
    return nil
end

function MD:OnDisable()
    self:UnhookAll()
    WorldMapLevelDropDown_Update()
    WorldMapZoneDropDown_Update()
end
