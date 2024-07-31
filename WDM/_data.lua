local WDM = LibStub("AceAddon-3.0"):GetAddon("WDM")
local DData = WDM:NewModule("DungeonData", "AceHook-3.0")
local L = LibStub("AceLocale-3.0"):GetLocale("WDM")

local Astrolabe = DongleStub("Astrolabe-0.4")
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
    ["microdungeons"] = false,
    ["debugmode"] = false,
},} 

-- Texture
local atlasTex = "Interface\\AddOns\\WDM\\Textures\\ObjectIconsAtlas"
local atlasIcons = {
    ["dungeon"]={22, 22, 0.912109, 0.955078, 0.0449219, 0.0664062, false, false},
	["raid"]={22, 22, 0.689453, 0.732422, 0.166016, 0.1875, false, false},

    ["taxinode_alliance"]={18, 18, 0.958984, 0.994141, 0.0449219, 0.0625, false, false},
	["taxinode_horde"]={18, 18, 0.474609, 0.509766, 0.177734, 0.195312, false, false},
	["taxinode_neutral"]={18, 18, 0.513672, 0.548828, 0.177734, 0.195312, false, false},

    ["taxinode_continent_alliance"]={27, 27, 0.00195312, 0.0546875, 0.608398, 0.634766, false, false},
	["taxinode_continent_horde"]={27, 27, 0.00195312, 0.0546875, 0.636719, 0.663086, false, false},
	["taxinode_continent_neutral"]={27, 27, 0.00195312, 0.0546875, 0.665039, 0.691406, false, false},
}

-- Datas
local contCoords = {
    [1] = { 17066.5996094,    -19733.2109375,     12799.9003906,  -11733.2998047, }, -- Kalimdor
    [2] = { 18171.9707031,    -22569.2109375,     11176.34375,    -15973.34375,   }, -- Eastern Kingdoms
    [3] = { 12996.0390625,    -4468.0390625,      5821.359375,    -5821.359375,   }, -- Outland
    [4] = { 9217.15234375,    -8534.24609375,     10593.375,      -1240.89001465, }, -- Northrend
}

local atlasPOI = {
        --  {   faction,   x coord,    y coord,      name }
    ["taxinode"] = {
        [1] = {
            {   "neutral",     -6110.0,    -1140.0,      L["taxinode_marshalsrefuge"]          },
            {   "neutral",     -898.0,     -3769.0,      L["taxinode_ratchet"]                 },
            {   "neutral",     3981.0,     -1321.0,      L["taxinode_emeraldsanctuary"]        },
            {   "neutral",     -4568.0,    -3223.0,      L["taxinode_mudsprocket"]             },
            {   "alliance",    8203.0,     5643.0,       L["taxinode_bloodwatch"]              },
            {   "alliance",    6076.0,     5811.0,       L["taxinode_theexodar"]               },
            {   "alliance",    8640.0,     841.0,        L["taxinode_ruttheranvillage"]        },
            {   "alliance",    6343.0,     561.0,        L["taxinode_auberdine"]               },
            {   "alliance",    2828.0,     -284.0,       L["taxinode_astranaar"]               },
            {   "alliance",    -4491.0,    -778.0,       L["taxinode_thalanaar"]               },
            {   "alliance",    -3828.0,    -4517.0,      L["taxinode_theramore"]               },
            {   "alliance",    2682.0,     1466.0,       L["taxinode_stonetalonpeak"]          },
            {   "alliance",    136.0,      1326.0,       L["taxinode_nijelspoint"]             },
            {   "alliance",    -7224.0,    -3738.0,      L["taxinode_gadgetzan"]               },
            {   "alliance",    -4370.0,    3340.0,       L["taxinode_feathermoon"]             },
            {   "alliance",    7454.0,     -2491.0,      L["taxinode_moonglade"]               },
            {   "alliance",    6800.0,     -4742.0,      L["taxinode_everlook"]                },
            {   "alliance",    2718.0,     -3880.0,      L["taxinode_talrendispoint"]          },
            {   "alliance",    6204.0,     -1951.0,      L["taxinode_talonbranchglade"]        },
            {   "alliance",    -6758.0,    775.0,        L["taxinode_cenarionhold"]            },
            {   "alliance",    3002.0,     -3206.0,      L["taxinode_forestsong"]              },
            {   "horde",       -1196.0,    26.0,         L["taxinode_thunderbluff"]            },
            {   "horde",       1676.0,     -4313.0,      L["taxinode_orgrimmar"]               },
            {   "horde",       -437.0,     -2596.0,      L["taxinode_crossroads"]              },
            {   "horde",       968.0,      1042.0,       L["taxinode_sunrockretreat"]          },
            {   "horde",       -5407.0,    -2419.0,      L["taxinode_freewindpost"]            },
            {   "horde",       -1770.0,    3262.0,       L["taxinode_shadowpreyvillage"]       },
            {   "horde",       -7045.0,    -3779.0,      L["taxinode_gadgetzan"]               },
            {   "horde",       -4421.0,    198.0,        L["taxinode_campmojache"]             },
            {   "horde",       3664.0,     -4390.0,      L["taxinode_valormok"]                },
            {   "horde",       -2384.0,    -1880.0,      L["taxinode_camptaurajo"]             },
            {   "horde",       6815.0,     -4610.0,      L["taxinode_everlook"]                },
            {   "horde",       -3149.0,    -2842.0,      L["taxinode_brackenwallvillage"]      },
            {   "horde",       5064.0,     -338.0,       L["taxinode_bloodvenompost"]          },
            {   "horde",       3373.0,     994.0,        L["taxinode_zoramgaroutpost"]         },
            {   "horde",       2305.0,     -2520.0,      L["taxinode_splintertreepost"]        },
            {   "horde",       7466.0,     -2122.0,      L["taxinode_moonglade"]               },
            {   "horde",       -6810.0,    841.0,        L["taxinode_cenarionhold"]            },
        },
        [2] = {
            {   "neutral",     10612.0,    -4511.0,      L["taxinode_shatteredsunstagingarea"] },
            {   "neutral",     4389.0,     -5349.0,      L["taxinode_zulaman"]                 },
            {   "neutral",     2348.0,     -5669.0,      L["taxinode_acherus"]                 },
            {   "neutral",     1943.0,     -2561.0,      L["taxinode_thondorilriver"]          },
            {   "alliance",    -8835.0,    490.0,        L["taxinode_stormwind"]               },
            {   "alliance",    -10628.0,   1037.0,       L["taxinode_sentinelhill"]            },
            {   "alliance",    -9435.0,    -2234.0,      L["taxinode_lakeshire"]               },
            {   "alliance",    -3793.0,    -782.0,       L["taxinode_menethilharbor"]          },
            {   "alliance",    -5424.0,    -2929.0,      L["taxinode_thelsamar"]               },
            {   "alliance",    -4821.0,    -1152.0,      L["taxinode_ironforge"]               },
            {   "alliance",    -8365.0,    -2736.0,      L["taxinode_morgansvigil"]            },
            {   "alliance",    -10513.0,   -1258.0,      L["taxinode_darkshire"]               },
            {   "alliance",    -715.0,     -512.0,       L["taxinode_southshore"]              },
            {   "alliance",    -1240.0,    -2513.0,      L["taxinode_refugepointe"]            },
            {   "alliance",    -14477.0,   464.0,        L["taxinode_bootybay"]                },
            {   "alliance",    -6559.0,    -1169.0,      L["taxinode_thoriumpoint"]            },
            {   "alliance",    282.0,      -2001.0,      L["taxinode_aeriepeak"]               },
            {   "alliance",    -11110.0,   -3437.0,      L["taxinode_nethergardekeep"]         },
            {   "alliance",    928.0,      -1429.0,      L["taxinode_chillwindcamp"]           },
            {   "alliance",    2269.0,     -5345.0,      L["taxinode_lightshopechapel"]        },
            {   "alliance",    -11340.0,   -219.0,       L["taxinode_rebelcamp"]               },
            {   "horde",       -12417.0,   144.0,        L["taxinode_gromgol"]                 },
            {   "horde",       473.0,      1533.0,       L["taxinode_thesepulcher"]            },
            {   "horde",       2.0,        -857.0,       L["taxinode_tarrenmill"]              },
            {   "horde",       -917.0,     -3496.0,      L["taxinode_hammerfall"]              },
            {   "horde",       -14448.0,   506.0,        L["taxinode_bootybay"]                },
            {   "horde",       -6632.0,    -2178.0,      L["taxinode_kargath"]                 },
            {   "horde",       -6559.0,    -1100.0,      L["taxinode_thoriumpoint"]            },
            {   "horde",       -631.0,     -4720.0,      L["taxinode_revantuskvillage"]        },
            {   "horde",       1567.0,     266.0,        L["taxinode_undercity"]               },
            {   "horde",       -10459.0,   -3279.0,      L["taxinode_stonard"]                 },
            {   "horde",       2328.0,     -5290.0,      L["taxinode_lightshopechapel"]        },
            {   "horde",       -7504.0,    -2190.0,      L["taxinode_flamecrest"]              },
            {   "horde",       1730.0,     -743.0,       L["taxinode_thebulwark"]              },
            {   "horde",       5195.0,     -4382.0,      L["taxinode_tranquillien"]            },
            {   "horde",       6976.0,     -4765.0,      L["taxinode_silvermooncity"]          },
        },  
        [3] = {  
            {   "neutral",     3085.0,     3600.0,       L["taxinode_area52"]                  },
            {   "neutral",     -1831.0,    5298.0,       L["taxinode_shattrath"]               },
            {   "neutral",     -3062.0,    741.0,        L["taxinode_altarofshatar"]           },
            {   "neutral",     4160.0,     2957.0,       L["taxinode_thestormspire"]           },
            {   "neutral",     2973.0,     1848.0,       L["taxinode_cosmowrench"]             },
            {   "neutral",     -4067.0,    1127.0,       L["taxinode_sanctumofthestars"]       },
            {   "neutral",     2975.0,     5499.0,       L["taxinode_evergrove"]               },
            {   "alliance",    -665.0,     2715.0,       L["taxinode_honorhold"]               },
            {   "alliance",    199.0,      4238.0,       L["taxinode_templeoftelhamat"]        },
            {   "alliance",    210.0,      6065.0,       L["taxinode_telredor"]                },
            {   "alliance",    -2723.0,    7302.0,       L["taxinode_telaar"]                  },
            {   "alliance",    -2995.0,    3873.0,       L["taxinode_allerianstronghold"]      },
            {   "alliance",    -323.0,     1027.0,       L["taxinode_darkportala"]             },
            {   "alliance",    2187.0,     6794.0,       L["taxinode_sylvanaar"]               },
            {   "alliance",    -3980.0,    2156.0,       L["taxinode_wildhammerstronghold"]    },
            {   "alliance",    279.0,      1489.0,       L["taxinode_shatterpoint"]            },
            {   "alliance",    1860.0,     5528.0,       L["taxinode_toshleysstation"]         },
            {   "alliance",    963.0,      7399.0,       L["taxinode_oreborharborage"]         },
            {   "horde",       2023.0,     4702.0,       L["taxinode_moknathalvillage"]        },
            {   "horde",       2451.0,     6022.0,       L["taxinode_thunderlordstronghold"]   },
            {   "horde",       233.0,      2632.0,       L["taxinode_thrallmar"]               },
            {   "horde",       223.0,      7812.0,       L["taxinode_zabrajin"]                },
            {   "horde",       -2563.0,    4426.0,       L["taxinode_stonebreakerhold"]        },
            {   "horde",       -1256.0,    7136.0,       L["taxinode_garadar"]                 },
            {   "horde",       -176.0,     1028.0,       L["taxinode_darkportalh"]             },
            {   "horde",       -584.0,     4104.0,       L["taxinode_falconwatch"]             },
            {   "horde",       -3018.0,    2556.0,       L["taxinode_shadowmoonvillage"]       },
            {   "horde",       -1314.0,    2355.0,       L["taxinode_spinebreakerridge"]       },
            {   "horde",       87.0,       5213.0,       L["taxinode_swampratpost"]            },
        },  
        [4] = {  
            {   "neutral",     3571.0,     5957.0,       L["taxinode_amberledge"]              },
            {   "neutral",     3647.0,     244.0,        L["taxinode_wyrmresttemple"]          },
            {   "neutral",     3573.0,     6661.0,       L["taxinode_transitusshield"]         },
            {   "neutral",     5587.0,     5830.0,       L["taxinode_nesingwarybasecamp"]      },
            {   "neutral",     2917.0,     4043.0,       L["taxinode_unupe"]                   },
            {   "neutral",     2793.0,     906.0,        L["taxinode_moaki"]                   },
            {   "neutral",     787.0,      -2889.0,      L["taxinode_kamagua"]                 },
            {   "neutral",     5505.0,     4745.0,       L["taxinode_riversheart"]             },
            {   "neutral",     5218.0,     -1299.0,      L["taxinode_ebonwatch"]               },
            {   "neutral",     5192.0,     -2207.0,      L["taxinode_lightsbreach"]            },
            {   "neutral",     5523.0,     -2674.0,      L["taxinode_theargentstand"]          },
            {   "neutral",     5780.0,     -3598.0,      L["taxinode_zimtorga"]                },
            {   "neutral",     5813.0,     453.0,        L["taxinode_dalaran"]                 },
            {   "neutral",     6188.0,     -1056.0,      L["taxinode_k3"]                      },
            {   "neutral",     7855.0,     -732.0,       L["taxinode_gromarshcrash-site"]      },
            {   "neutral",     8475.0,     -337.0,       L["taxinode_bouldercragsrefuge"]      },
            {   "neutral",     8861.0,     -1322.0,      L["taxinode_ulduar"]                  },
            {   "neutral",     8407.0,     2700.0,       L["taxinode_theshadowvault"]          },
            {   "neutral",     6162.0,     -62.0,        L["taxinode_theargentvanguard"]       },
            {   "neutral",     6893.0,     -4118.0,      L["taxinode_gundrak"]                 },
            {   "neutral",     6401.0,     464.0,        L["taxinode_crusaderspinnacle"]       },
            {   "neutral",     7429.0,     4231.0,       L["taxinode_deathsrise"]              },
            {   "neutral",     7309.0,     -2612.0,      L["taxinode_dunnifflelem"]            },
            {   "neutral",     8481.0,     891.0,        L["taxinode_argenttournamentgrounds"] },
            {   "alliance",    6673.0,     -256.0,       L["taxinode_frosthold"]               },
            {   "alliance",    5102.0,     2187.0,       L["taxinode_valiancelandingcamp"]     },
            {   "alliance",    567.0,      -5012.0,      L["taxinode_valgardeport"]            },
            {   "alliance",    1343.0,     -3287.0,      L["taxinode_westguardkeep"]           },
            {   "alliance",    2467.0,     -5028.0,      L["taxinode_fortwildervar"]           },
            {   "alliance",    4126.0,     5309.0,       L["taxinode_fizzcrankairstrip"]       },
            {   "alliance",    4582.0,     -4254.0,      L["taxinode_westfallbrigade"]         },
            {   "alliance",    4606.0,     1410.0,       L["taxinode_fordragonhold"]           },
            {   "alliance",    3712.0,     -694.0,       L["taxinode_wintergardekeep"]         },
            {   "alliance",    2272.0,     5171.0,       L["taxinode_valiancekeep"]            },
            {   "alliance",    3447.0,     -2754.0,      L["taxinode_amberpinelodge"]          },
            {   "alliance",    3506.0,     1990.0,       L["taxinode_starsrest"]               },
            {   "alliance",    5032.0,     -521.0,       L["taxinode_windrunnersoverlook"]     },
            {   "horde",       5023.0,     3686.0,       L["taxinode_warsongcamp"]             },
            {   "horde",       2649.0,     -4394.0,      L["taxinode_campwinterhoof"]          },
            {   "horde",       400.0,      -4542.0,      L["taxinode_newagamand"]              },
            {   "horde",       2922.0,     6244.0,       L["taxinode_warsonghold"]             },
            {   "horde",       3863.0,     1523.0,       L["taxinode_agmarshammer"]            },
            {   "horde",       2106.0,     -2968.0,      L["taxinode_apothecarycamp"]          },
            {   "horde",       3248.0,     -662.0,       L["taxinode_venomspite"]              },
            {   "horde",       3446.0,     4088.0,       L["taxinode_taunkalevillage"]         },
            {   "horde",       4473.0,     5708.0,       L["taxinode_borgorokoutpost"]         },
            {   "horde",       4941.0,     1167.0,       L["taxinode_korkoronvanguard"]        },
            {   "horde",       3261.0,     -2265.0,      L["taxinode_conquesthold"]            },
            {   "horde",       3874.0,     -4520.0,      L["taxinode_camponeqwah"]             },
            {   "horde",       1919.0,     -6176.0,      L["taxinode_vengeancelanding"]        },
            {   "horde",       7798.0,     -2810.0,      L["taxinode_camptunkalo"]             },
            {   "horde",       5587.0,     -694.0,       L["taxinode_sunreaverscommand"]       },
        },
    },
    ["taxinode_continent"] = {
        [1] = {
            { "neutral", -999.103, -3823.233, L["taxinode_continent_bootybay"] },
            { "alliance", -4001.794, -4726.519, L["taxinode_continent_menethilharbor"] },
            { "alliance", 6421.85, 818.768, L["taxinode_continent_stormwind"] },
            { "alliance", 6579.306, 768.255, L["taxinode_continent_teldrassil"] },
            { "alliance", 6542.416, 926.931, L["taxinode_continent_exodar"] },
            { "horde", 1192.31, -4143.297, L["taxinode_continent_warsonghold"] },
            { "horde", 1134.284, -4141.549, L["taxinode_continent_thunderbluff"] },
            { "horde", -1029.529, 365.004, L["taxinode_continent_durotar"] },
            { "horde", 1368.056, -4632.364, L["taxinode_continent_gromgol"] },
            { "horde", 1312.351, -4654.377, L["taxinode_continent_brill"] },
        },
        [2] = {
            { "alliance", -8644.71, 1329.167, L["taxinode_continent_auberdine"] },
            { "alliance", -8290.688, 1405.741, L["taxinode_continent_valiancekeep"] },
            { "alliance", -3896.958, -600.345, L["taxinode_continent_theramore"] },
            { "alliance", -3726.68, -585.331, L["taxinode_continent_daggercapbay"] },
            { "neutral", -14284.961, 558.216, L["taxinode_continent_ratchet"] },
            { "horde", -12448.642, 218.476, L["taxinode_continent_durotar"] },
            { "horde", 2067.855, 297.069, L["taxinode_continent_durotar"] },
            { "horde", 2056.812, 231.009, L["taxinode_continent_gromgol"] },
            { "horde", -12401.333, 207.287, L["taxinode_continent_brill"] },
            { "horde", 2058.611, 373.441, L["taxinode_continent_vengeancelanding"] },
        },
        [4] = {
            { "alliance", 2231.213, 5132.484, L["taxinode_continent_stormwind"] },
            { "alliance", 590.962, -5101.727, L["taxinode_continent_menethilharbor"] },
            { "horde", 2837.348, 6185.007, L["taxinode_continent_durotar"] },
            { "neutral", 2635.748, 824.325, L["taxinode_continent_kamagua"] },
            { "neutral", 791.73, -2796.873, L["taxinode_continent_moaki"] },
            { "neutral", 2618.897, 954.482, L["taxinode_continent_unupe"] },
            { "neutral", 2818.209, 4014.899, L["taxinode_continent_moaki"] },
            { "horde", 1983.33, -6088.723, L["taxinode_continent_brill"] },
        },
    },
    ["instance"] = {
        [1] = {
            {   "dungeon",     1813.0,     -4415.0,    BZ["Ragefire Chasm"],             LFG_TYPE_DUNGEON, },
            {   "dungeon",     -742.0,     -2213.0,    BZ["Wailing Caverns"],            LFG_TYPE_DUNGEON, },
            {   "dungeon",     -4657.0,    -2519.0,    BZ["Razorfen Downs"],             LFG_TYPE_DUNGEON, },
            {   "dungeon",     -4470.0,    -1678.0,    BZ["Razorfen Kraul"],             LFG_TYPE_DUNGEON, },
            {   "dungeon",     -6793.0,    -2892.0,    BZ["Zul'Farrak"],                 LFG_TYPE_DUNGEON, },
            {   "dungeon",     -1423.0,    2925.0,     BZ["Maraudon"],                   LFG_TYPE_DUNGEON, },
            {   "dungeon",     4141.0,     885.0,      BZ["Blackfathom Deeps"],          LFG_TYPE_DUNGEON, },
            {   "dungeon",     -4457.6,    1333.0,     BZ["Dire Maul"],                  LFG_TYPE_DUNGEON, },
            {   "raid",        -4718.5,    -3736.0,    BZ["Onyxia's Lair"],              LFG_TYPE_RAID,    },
        },          
        [2] = {         
            {   "dungeon",     -8780.0,    834.0,      BZ["The Stockade"],               LFG_TYPE_DUNGEON, },
            {   "dungeon",     -5163.0,    927.0,      BZ["Gnomeregan"],                 LFG_TYPE_DUNGEON, },
            {   "dungeon",     3376.0,     -3379.0,    BZ["Stratholme"],                 LFG_TYPE_DUNGEON, },
            {   "dungeon",     -11076.0,   1527.0,     BZ["The Deadmines"],              LFG_TYPE_DUNGEON, },
            {   "dungeon",     -10448.0,   -3821.0,    BZ["The Temple of Atal'Hakkar"],  LFG_TYPE_DUNGEON, },
            {   "dungeon",     -233.0,     1568.0,     BZ["Shadowfang Keep"],            LFG_TYPE_DUNGEON, },
            {   "dungeon",     2872.6,     -764.0,     BZ["Scarlet Monastery"],          LFG_TYPE_DUNGEON, },
            {   "dungeon",     -6611.0,    -3704.0,    BZ["Uldaman"],                    LFG_TYPE_DUNGEON, },
            {   "dungeon",     -6091.5,    -3183.0,    BZ["Uldaman"],                    LFG_TYPE_DUNGEON, },
            {   "dungeon",     1270.0,     -2556.0,    BZ["Scholomance"],                LFG_TYPE_DUNGEON, },
            {   "dungeon",     10483.0,    -4939.0,    BZ["Magisters' Terrace"],         LFG_TYPE_DUNGEON, },
            {   "raid",        4486.0,     -5468.0,    BZ["Zul'Aman"],                   LFG_TYPE_RAID,    },
            {   "raid",        -11916.0,   -1219.0,    BZ["Zul'Gurub"],                  LFG_TYPE_RAID,    },
            {   "raid",        10155.5,    -4374.0,    BZ["Sunwell Plateau"],            LFG_TYPE_RAID,    },
            {   "raid",        -11112.5,   -2005.5,    BZ["Karazhan"],                   LFG_TYPE_RAID,    },
    
        },
        [3] = {
            {   "dungeon",     -303.0,     3165.0,     BZ["The Blood Furnace"],          LFG_TYPE_DUNGEON, },
            {   "dungeon",     -363.0,     3079.0,     BZ["Hellfire Ramparts"],          LFG_TYPE_DUNGEON, },
            {   "dungeon",     -308.0,     3070.0,     BZ["The Shattered Halls"],        LFG_TYPE_DUNGEON, },
            {   "dungeon",     -3164.0,    4941.0,     BZ["Mana-Tombs"],                 LFG_TYPE_DUNGEON, },
            {   "dungeon",     -3556.0,    4943.0,     BZ["Shadow Labyrinth"],           LFG_TYPE_DUNGEON, },
            {   "dungeon",     -3362.0,    5140.0,     BZ["Auchenai Crypts"],            LFG_TYPE_DUNGEON, },
            {   "dungeon",     -3363.0,    4744.0,     BZ["Sethekk Halls"],              LFG_TYPE_DUNGEON, },
            {   "dungeon",     547.0,      7009.0,     BZ["The Slave Pens"],             LFG_TYPE_DUNGEON, },
            {   "dungeon",     607.6,      6954.6,     BZ["The Steamvault"],             LFG_TYPE_DUNGEON, },
            {   "dungeon",     565.0,      6875.0,     BZ["The Underbog"],               LFG_TYPE_DUNGEON, },
            {   "dungeon",     3413.6,     1483.0,     BZ["The Botanica"],               LFG_TYPE_DUNGEON, },
            {   "dungeon",     2862.0,     1546.0,     BZ["The Mechanar"],               LFG_TYPE_DUNGEON, },
            {   "dungeon",     3310.0,     1336.6,     BZ["The Arcatraz"],               LFG_TYPE_DUNGEON, },
            {   "raid",        -335.0,     3127.0,     BZ["Magtheridon's Lair"],         LFG_TYPE_RAID,    },
            {   "raid",        3530.0,     5126.0,     BZ["Gruul's Lair"],               LFG_TYPE_RAID,    },
            {   "raid",        548.6,      6941.0,     BZ["Serpentshrine Cavern"],       LFG_TYPE_RAID,    },
            {   "raid",        3087.0,     1374.0,     BZ["The Eye"],                    LFG_TYPE_RAID,    },
            {   "raid",        -3650.0,    317.0,      BZ["Black Temple"],               LFG_TYPE_RAID,    },
    
    
        },
        [4] = {
            {   "dungeon",     9183.0,     -1385.0,    BZ["Halls of Lightning"],         LFG_TYPE_DUNGEON, },
            {   "dungeon",     8922.0,     -970.0,     BZ["Halls of Stone"],             LFG_TYPE_DUNGEON, },
            {   "dungeon",     6970.0,     -4402.0,    BZ["Gundrak"],                    LFG_TYPE_DUNGEON, },
            {   "dungeon",     6702.0,     -4660.5,    BZ["Gundrak"],                    LFG_TYPE_DUNGEON, },
            {   "dungeon",     3897.0,     6985.0,     BZ["The Nexus"],                  LFG_TYPE_DUNGEON, },
            {   "dungeon",     4006.0,     6998.0,     BZ["The Oculus"],                 LFG_TYPE_DUNGEON, },
            {   "dungeon",     8588.0,     792.0,      BZ["Trial of the Champion"],      LFG_TYPE_DUNGEON, },
            {   "dungeon",     5671.6,     2003.0,     BZ["The Forge of Souls"],         LFG_TYPE_DUNGEON, },
            {   "dungeon",     5629.0,     1974.0,     BZ["Halls of Reflection"],        LFG_TYPE_DUNGEON, },
            {   "dungeon",     5592.0,     2010.0,     BZ["Pit of Saron"],               LFG_TYPE_DUNGEON, },
            {   "dungeon",     5689.0,     498.0,      BZ["The Violet Hold"],            LFG_TYPE_DUNGEON, },
            {   "dungeon",     3673.0,     2173.0,     BZ["Azjol-Nerub"],                LFG_TYPE_DUNGEON, },
            {   "dungeon",     4774.0,     -2028.0,    BZ["Drak'Tharon Keep"],           LFG_TYPE_DUNGEON, },
            {   "dungeon",     1228.0,     -4862.4,    BZ["Utgarde Keep"],               LFG_TYPE_DUNGEON, },
            {   "dungeon",     1237.0,     -4859.0,    BZ["Utgarde Pinnacle"],           LFG_TYPE_DUNGEON, },
            {   "dungeon",     3640.0,     2030.0,     BZ["Ahn'kahet: The Old Kingdom"], LFG_TYPE_DUNGEON, },
            {   "raid",        9345.5,     -1115.0,    BZ["Ulduar"],                     LFG_TYPE_RAID,    },
            {   "raid",        3865.0,     6987.0,     BZ["The Eye of Eternity"],        LFG_TYPE_RAID,    },
            {   "raid",        5482.0,     2839.0,     BZ["Vault of Archavon"],          LFG_TYPE_RAID,    },
            {   "raid",        3668.0,     -1268.0,    BZ["Naxxramas"],                  LFG_TYPE_RAID,    },
            {   "raid",        8515.0,     714.0,      BZ["Trial of the Crusader"],      LFG_TYPE_RAID,    },
            {   "raid",        3448.0,     261.5,      BZ["The Obsidian Sanctum"],       LFG_TYPE_RAID,    },
            {   "raid",        3601.0,     196.0,      BZ["The Ruby Sanctum"],           LFG_TYPE_RAID,    },
            {   "raid",        5874.0,     2111.0,     BZ["Icecrown Citadel"],           LFG_TYPE_RAID,    },
        },
    },
}

function DData:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("WDMdb", defaults, true)
end

function DData:CreateAtlasPOI(index)
    local button = CreateFrame("Button", "WorldMapFrameAtlasPOI"..index, WorldMapButton);
        button:SetWidth(32);
        button:SetHeight(32);
        button:RegisterForClicks("LeftButtonUp", "RightButtonUp");
        button:SetScript("OnEnter", WorldMapPOI_OnEnter);
        button:SetScript("OnLeave", WorldMapPOI_OnLeave);
        button:SetScript("OnClick", WorldMapPOI_OnClick);

    local texture = button:CreateTexture(button:GetName().."Texture", "BACKGROUND");
        texture:SetWidth(16);
        texture:SetHeight(16);
        texture:SetPoint("CENTER", 0, 0);
        texture:SetTexture(atlasTex);
    
    local glow = button:CreateTexture(button:GetName().."GlowTexture", "OVERLAY");
        glow:SetBlendMode("ADD");
        glow:SetAlpha(0.0);
        glow:SetAllPoints(texture);
        glow:SetTexture(atlasTex);

    local highlight = button:CreateTexture(button:GetName().."HighlightTexture", "HIGHLIGHT");
        highlight:SetBlendMode("ADD");
        highlight:SetAlpha(0.4);
        highlight:SetAllPoints(texture);
        highlight:SetTexture(atlasTex);
end

function DData:AstrolabeCoords(xcoord, ycoord, continent)
    local conty1, conty2, contx1, contx2 = unpack(contCoords[continent]);
    local ycoord = abs(ycoord - conty1) / abs(conty2 - conty1);
    local xcoord = abs(xcoord - contx1) / abs(contx2 - contx1);

    return ycoord, xcoord;
end

function DData:GetListAtlasPOI(continent)
    local generated_array = {}
    local currentZone = GetCurrentMapZone()
    for category, content in pairs(atlasPOI) do
        if self.db.profile["show_"..category] and content[continent] then
            for _, val in pairs(content[continent]) do
                local faction, x, y, name, desc = unpack(val)
                local twidth, theight, tleft, tright, ttop, tbottom = self:GetAtlasTextureCoords(category, faction)
                if not self:isBlockedPOI(category, faction) then
                    x, y = self:AstrolabeCoords(x, y, continent)
                    x, y = Astrolabe:TranslateWorldMapPosition(continent, 0, x, y, continent, currentZone)
                    if x and y and y < 1 and y > 0 and x < 1 and x > 0 and currentZone ~= 0 then
                        tinsert(generated_array, { faction, x, y, name, desc or "", twidth, theight, tleft, tright, ttop, tbottom })
                    end
                end
            end
        end
    end
    return generated_array
end


function DData:isBlockedPOI(category, faction)
    local playerfaction, _ = UnitFactionGroup("player")
    return not self.db.profile["show_"..category.."_opposite"] and (( playerfaction:lower() == "horde" and faction:lower() == "alliance" ) or 
            ( playerfaction:lower() == "alliance" and faction:lower() == "horde" ))
end

function DData:GetAtlasTextureCoords(category, faction)
    local atc = atlasIcons[category.."_"..faction] or atlasIcons[category] or atlasIcons[faction]
    return unpack(atc)
end

-- debug
function DData:DebugCoords()
    if self.db.profile["debugmode"] then 
        local C, Z, x, y = Astrolabe:GetCurrentPlayerPosition()
        if contCoords[C] and Z == 0 then
            DEFAULT_CHAT_FRAME:AddMessage("Local coords: (y: " .. tonumber(string.format("%.3f", x)) .. ", x: " .. tonumber(string.format("%.3f", y)) .. ")" )
            local conty1, conty2, contx1, contx2 = unpack(contCoords[C]);
            local ycoord = -x * abs(conty2 - conty1) + conty1;
            local xcoord = -y * abs(contx2 - contx1) + contx1;
            DEFAULT_CHAT_FRAME:AddMessage("Global coords: (y: " .. tonumber(string.format("%.3f", xcoord)) .. ", x: " .. tonumber(string.format("%.3f", ycoord)) .. ")" )
        end
    end
end