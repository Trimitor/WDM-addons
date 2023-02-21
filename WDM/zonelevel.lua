local WDM = LibStub("AceAddon-3.0"):GetAddon("WDM")
local ZoneLevel = WDM:NewModule("ZoneLevel", "AceHook-3.0")

local LBZ = LibStub("LibBabble-Zone-3.0", true)
local BZ = LBZ and LBZ:GetLookupTable() or setmetatable({}, {__index = function(t,k) return k end})

local defaults = { profile = {
    ["show_minimap"] = false,
    ["show_zonelevel"] = false,
    ["show_taxinode"] = true,
    ["show_taxinode_opposite"] = false,
    ["show_taxinode_continent"] = true,
    ["show_taxinode_continent_opposite"] = false,
    ["show_instance"] = true,
    ["debugmode"] = false,
},}

local zones = {
    ["Moonglade"] = {0,0},
    ["Deeprun Tram"] = {0,80},
    ["Ironforge"] = {0,80},
    ["Silvermoon City"] = {0,80},
    ["Stormwind City"] = {0,80},
    ["Undercity"] = {0,80},
    ["Darnassus"] = {0,80},
    ["Orgrimmar"] = {0,80},
    ["The Exodar"] = {0,80},
    ["Thunder Bluff"] = {0,80},
    ["Shattrath City"] = {0,80},
    ["Dalaran"] = {0,80},
    ["Dun Morogh"] = {1,10},
    ["Elwynn Forest"] = {1,10},
    ["Eversong Woods"] = {1,10},
    ["Tirisfal Glades"] = {1,10},
    ["Azuremyst Isle"] = {1,10},
    ["Durotar"] = {1,10},
    ["Mulgore"] = {1,10},
    ["Teldrassil"] = {1,10},
    ["The Veiled Sea"] = {1,10},
    ["Ghostlands"] = {10,20},
    ["Loch Modan"] = {10,20},
    ["Silverpine Forest"] = {10,20},
    ["Westfall"] = {10,20},
    ["Bloodmyst Isle"] = {10,20},
    ["Darkshore"] = {10,20},
    ["The Barrens"] = {10,25},
    ["Redridge Mountains"] = {15,25},
    ["Stonetalon Mountains"] = {15,27},
    ["Duskwood"] = {18,30},
    ["Ashenvale"] = {18,30},
    ["Hillsbrad Foothills"] = {20,30},
    ["Wetlands"] = {20,30},
    ["Thousand Needles"] = {25,35},
    ["Alterac Mountains"] = {30,40},
    ["Arathi Highlands"] = {30,40},
    ["Desolace"] = {30,40},
    ["Stranglethorn Vale"] = {30,45},
    ["Badlands"] = {35,45},
    ["Swamp of Sorrows"] = {35,45},
    ["Dustwallow Marsh"] = {35,45},
    ["Feralas"] = {40,50},
    ["Tanaris"] = {40,50},
    ["Searing Gorge"] = {43,50},
    ["The Hinterlands"] = {45,50},
    ["Blasted Lands"] = {45,55},
    ["Azshara"] = {48,55},
    ["Felwood"] = {48,55},
    ["Un'Goro Crater"] = {48,55},
    ["Burning Steppes"] = {50,58},
    ["Western Plaguelands"] = {51,58},
    ["Blackrock Mountain"] = {52,60},
    ["Eastern Plaguelands"] = {53,60},
    ["Winterspring"] = {53,60},
    ["Plaguelands: The Scarlet Enclave"] = {55,58},
    ["Deadwind Pass"] = {55,60},
    ["Silithus"] = {55,60},
    ["Hellfire Peninsula"] = {58,63},
    ["Zangarmarsh"] = {60,64},
    ["Terokkar Forest"] = {62,65},
    ["Nagrand"] = {64,67},
    ["Blade's Edge Mountains"] = {65,68},
    ["Netherstorm"] = {67,70},
    ["Shadowmoon Valley"] = {67,70},
    ["Borean Tundra"] = {68,72},
    ["Howling Fjord"] = {68,72},
    ["Isle of Quel'Danas"] = {70,70},
    ["Dragonblight"] = {71,74},
    ["Grizzly Hills"] = {73,75},
    ["Crystalsong Forest"] = {74,76},
    ["Zul'Drak"] = {74,77},
    ["Sholazar Basin"] = {76,78},
    ["Hrothgar's Landing"] = {77,80},
    ["Icecrown"] = {77,80},
    ["The Storm Peaks"] = {77,80},
    ["Wintergrasp"] = {77,80},
}

function ZoneLevel:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("WDMdb", defaults, true)
end

function ZoneLevel:GetLevelByZone(mzone)
    local lvh;
    for lzone, levels in pairs(zones) do
        if mzone == BZ[lzone] then
            if UnitLevel("player") < 60 then lvh = levels[1] - 2 else lvh = levels[1] - 1 end
            if ( levels[1] <= 0 ) then return GRAY_FONT_COLOR_CODE.. " ("..levels[1].. "-" ..levels[2].. ")"
                elseif ( UnitLevel("player") < lvh ) then return RED_FONT_COLOR_CODE.. " ("..levels[1].. "-" ..levels[2].. ")"
                elseif ( UnitLevel("player") > levels[2] + 3 ) then return GRAY_FONT_COLOR_CODE.. " ("..levels[1].. "-" ..levels[2].. ")"
                elseif ( UnitLevel("player") >= levels[2] and UnitLevel("player") <= levels[2] + 3 ) then return GREEN_FONT_COLOR_CODE.. " ("..levels[1].. "-" ..levels[2].. ")"
                elseif ( UnitLevel("player") > levels[1] and UnitLevel("player") < levels[2] ) then return YELLOW_FONT_COLOR_CODE.. " ("..levels[1].. "-" ..levels[2].. ")"
                elseif ( UnitLevel("player") >= lvh and UnitLevel("player") <= levels[1] ) then return ORANGE_FONT_COLOR_CODE.. " ("..levels[1].. "-" ..levels[2].. ")"
            end
        end
    end
end

function ZoneLevel:SetZoneLevel(zone)
    if self.db.profile["show_zonelevel"] then 
        if self:GetLevelByZone(zone) then 
            return zone .. self:GetLevelByZone(zone)
        else 
            return zone 
        end
    else 
        return zone 
    end
end

function ZoneLevel:WorldMapButton_OnUpdate()
	if WorldMapFrameAreaLabel:GetText() then
        WorldMapFrameAreaLabel:SetText(ZoneLevel:SetZoneLevel(WorldMapFrameAreaLabel:GetText()))
	end

end
 
function ZoneLevel:OnEnable()
    self:SecureHookScript(WorldMapButton, "OnUpdate", "WorldMapButton_OnUpdate")
end
 
function ZoneLevel:OnDisable()
    self:UnhookAll()
end