-- Texture 
WDMIcon_Dungeon = "Interface\\AddOns\\WDM\\Textures\\dungeon.tga"
WDMIcon_Raid = "Interface\\AddOns\\WDM\\Textures\\raid.tga"
WDMIcon_POI = "Interface\\AddOns\\WDM\\Textures\\poiicons.tga"

WDMData_CustomPOI = {
    --  {   id,   x coord,    y coord,     z coord,  continent (area id), name }
    ["flightmasters"] = { -- 178 (Neutral), 179 (Horde), 180 (Alliance)
        {   178,  -6110.0,    -1140.0,    -186.0,     1,      POI_FLIGHTMASTER_UNGOROCRATER1             }, -- "Marshal's Refuge, Un'Goro Crater"
        {   178,  -898.0,     -3769.0,    11.0,       1,      POI_FLIGHTMASTER_THEBARRENS1               }, -- "Ratchet, The Barrens"
        {   178,  3085.0,     3600.0,     144.0,      530,    POI_FLIGHTMASTER_NETHERSTORM1              }, -- "Area 52, Netherstorm"
        {   178,  -1831.0,    5298.0,     -12.0,      530,    POI_FLIGHTMASTER_TEROKKARFOREST1           }, -- "Shattrath, Terokkar Forest"
        {   178,  -3062.0,    741.0,      -10.0,      530,    POI_FLIGHTMASTER_SHADOWMOONVALLEY1         }, -- "Altar of Sha'tar, Shadowmoon Valley"
        {   178,  4160.0,     2957.0,     352.0,      530,    POI_FLIGHTMASTER_NETHERSTORM2              }, -- "Stormspire, Netherstorm"
        {   178,  2973.0,     1848.0,     141.0,      530,    POI_FLIGHTMASTER_NETHERSTORM3              }, -- "Cosmowrench, Netherstorm"
        {   178,  -4067.0,    1127.0,     43.0,       530,    POI_FLIGHTMASTER_SHADOWMOONVALLEY2         }, -- "Sanctum of the Stars, Shadowmoon Valley"
        {   178,  2975.0,     5499.0,     143.0,      530,    POI_FLIGHTMASTER_BLADESEDGEMOUNTAINS1      }, -- "Evergrove, Blade's Edge Mountains"
        {   178,  3981.0,     -1321.0,    251.0,      1,      POI_FLIGHTMASTER_FELWOOD1                  }, -- "Emerald Dragonshrine, Felwood"
        {   178,  -4568.0,    -3223.0,    34.0,       1,      POI_FLIGHTMASTER_DUSTWALLOWMARSH1          }, -- "Mudsprocket, Dustwallow Marsh"
        {   178,  3571.0,     5957.0,     136.0,      571,    POI_FLIGHTMASTER_BOREANTUNDRA1             }, -- "Amber Ledge, Borean Tundra"
        {   178,  6789.0,     -7749.0,    126.0,      530,    POI_FLIGHTMASTER_GHOSTLANDS1               }, -- "Zul'Aman, Ghostlands"
        {   178,  3647.0,     244.0,      52.0,       571,    POI_FLIGHTMASTER_DRAGONBLIGHT1             }, -- "Wyrmrest, Dragonblight"
        {   178,  3573.0,     6661.0,     195.0,      571,    POI_FLIGHTMASTER_BOREANTUNDRA2             }, -- "Transitus Shield, Coldarra"
        {   178,  5587.0,     5830.0,     -67.0,      571,    POI_FLIGHTMASTER_SHOLAZARBASIN1            }, -- "Nesingwary Base Camp, Sholazar Basin"
        {   178,  2917.0,     4043.0,     1.0,        571,    POI_FLIGHTMASTER_BOREANTUNDRA3             }, -- "Unu'pe, Borean Tundra"
        {   178,  2793.0,     906.0,      22.0,       571,    POI_FLIGHTMASTER_DRAGONBLIGHT2             }, -- "Moa'ki, Dragonblight"
        {   178,  787.0,      -2889.0,    6.0,        571,    POI_FLIGHTMASTER_HOWLINGFJORD1             }, -- "Kamagua, Howling Fjord"
        {   178,  5505.0,     4745.0,     -194.0,     571,    POI_FLIGHTMASTER_SHOLAZARBASIN2            }, -- "River's Heart, Sholazar Basin"
        {   178,  5218.0,     -1299.0,    242.0,      571,    POI_FLIGHTMASTER_ZULDRAK1                  }, -- "Ebon Watch, Zul'Drak"
        {   178,  5192.0,     -2207.0,    239.0,      571,    POI_FLIGHTMASTER_ZULDRAK2                  }, -- "Light's Breach, Zul'Drak"
        {   178,  5523.0,     -2674.0,    304.0,      571,    POI_FLIGHTMASTER_ZULDRAK3                  }, -- "The Argent Stand, Zul'Drak"
        {   178,  5780.0,     -3598.0,    387.0,      571,    POI_FLIGHTMASTER_ZULDRAK4                  }, -- "Zim'Torga, Zul'Drak"
        {   178,  5813.0,     453.0,      658.0,      571,    POI_FLIGHTMASTER_DALARAN1                  }, -- "Dalaran"
        {   178,  2348.0,     -5669.0,    382.0,      0,      POI_FLIGHTMASTER_EASTERNPLAGUELANDS1       }, -- "Acherus: The Ebon Hold"
        {   178,  6188.0,     -1056.0,    409.0,      571,    POI_FLIGHTMASTER_THESTORMPEAKS1            }, -- "K3, The Storm Peaks"
        {   178,  7855.0,     -732.0,     1177.0,     571,    POI_FLIGHTMASTER_THESTORMPEAKS2            }, -- "Grom'arsh Crash-Site, The Storm Peaks"
        {   178,  8475.0,     -337.0,     906.0,      571,    POI_FLIGHTMASTER_THESTORMPEAKS3            }, -- "Bouldercrag's Refuge, The Storm Peaks"
        {   178,  8861.0,     -1322.0,    1033.0,     571,    POI_FLIGHTMASTER_THESTORMPEAKS4            }, -- "Ulduar, The Storm Peaks"
        {   178,  8407.0,     2700.0,     655.0,      571,    POI_FLIGHTMASTER_ICECROWN1                 }, -- "The Shadow Vault, Icecrown"
        {   178,  6162.0,     -62.0,      388.0,      571,    POI_FLIGHTMASTER_ICECROWN2                 }, -- "Argent Vanguard, Icecrown"
        {   178,  6893.0,     -4118.0,    467.0,      571,    POI_FLIGHTMASTER_ZULDRAK5                  }, -- "Gundrak, Zul'Drak"
        {   178,  6401.0,     464.0,      512.0,      571,    POI_FLIGHTMASTER_ICECROWN3                 }, -- "Crusaders' Pinnacle, Icecrown"
        {   178,  7429.0,     4231.0,     314.0,      571,    POI_FLIGHTMASTER_ICECROWN4                 }, -- "Death's Rise, Icecrown"
        {   178,  7309.0,     -2612.0,    814.0,      571,    POI_FLIGHTMASTER_THESTORMPEAKS5            }, -- "Dun Niffelem, The Storm Peaks"
        {   178,  8481.0,     891.0,      547.0,      571,    POI_FLIGHTMASTER_ICECROWN5                 }, -- "Argent Tournament Grounds, Icecrown"
        {   178,  1943.0,     -2561.0,    60.0,       0,      POI_FLIGHTMASTER_WESTERNPLAGUELANDS1       }, -- "Thondroril River, Western Plaguelands"
        {   178,  13012.0,    -6910.0,    9.0,        530,    POI_FLIGHTMASTER_ISLEOFQUELDANAS1          }, -- "Shattered Sun Staging Area"
        {   180,  6673.0,     -256.0,     962.0,      571,    POI_FLIGHTMASTER_THESTORMPEAKS6            }, -- "Frosthold, The Storm Peaks"
        {   180,  5102.0,     2187.0,     365.0,      571,    POI_FLIGHTMASTER_WINTERGRASP1              }, -- "Valiance Landing Camp, Wintergrasp"
        {   180,  -8835.0,    490.0,      109.0,      0,      POI_FLIGHTMASTER_ELWYNN1                   }, -- "Stormwind City, Elwynn"
        {   180,  -10628.0,   1037.0,     34.0,       0,      POI_FLIGHTMASTER_WESTFALL1                 }, -- "Sentinel Hill, Westfall"
        {   180,  -9435.0,    -2234.0,    69.0,       0,      POI_FLIGHTMASTER_REDRIDGEMOUNTAINS1        }, -- "Lakeshire, Redridge Mountains"
        {   180,  -3793.0,    -782.0,     9.0,        0,      POI_FLIGHTMASTER_WETLANDS1                 }, -- "Menethil Harbor, Wetlands"
        {   180,  -5424.0,    -2929.0,    347.0,      0,      POI_FLIGHTMASTER_LOCHMODAN1                }, -- "Thelsamar, Loch Modan"
        {   180,  -4821.0,    -1152.0,    502.0,      0,      POI_FLIGHTMASTER_DUNMOROGH1                }, -- "Ironforge, Dun Morogh"
        {   180,  -8365.0,    -2736.0,    185.0,      0,      POI_FLIGHTMASTER_BURNINGSTEPPES1           }, -- "Morgan's Vigil, Burning Steppes"
        {   180,  -10513.0,   -1258.0,    41.0,       0,      POI_FLIGHTMASTER_DUSKWOOD1                 }, -- "Darkshire, Duskwood"
        {   180,  -715.0,     -512.0,     26.0,       0,      POI_FLIGHTMASTER_HILLSBRAD1                }, -- "Southshore, Hillsbrad"
        {   180,  -1240.0,    -2513.0,    21.0,       0,      POI_FLIGHTMASTER_ARATHI1                   }, -- "Refuge Pointe, Arathi"
        {   180,  -14477.0,   464.0,      36.0,       0,      POI_FLIGHTMASTER_STRANGLETHORNVALE1        }, -- "Booty Bay, Stranglethorn Vale"
        {   180,  -6559.0,    -1169.0,    309.0,      0,      POI_FLIGHTMASTER_SEARINGGORGE1             }, -- "Thorium Point, Searing Gorge"
        {   180,  8640.0,     841.0,      23.0,       1,      POI_FLIGHTMASTER_TELDRASSIL1               }, -- "Rut'theran Village, Teldrassil"
        {   180,  6343.0,     561.0,      16.0,       1,      POI_FLIGHTMASTER_DARKSHORE1                }, -- "Auberdine, Darkshore"
        {   180,  2828.0,     -284.0,     106.0,      1,      POI_FLIGHTMASTER_ASHENVALE1                }, -- "Astranaar, Ashenvale"
        {   180,  -4491.0,    -778.0,     -40.0,      1,      POI_FLIGHTMASTER_FERALAS1                  }, -- "Thalanaar, Feralas"
        {   180,  -3828.0,    -4517.0,    10.0,       1,      POI_FLIGHTMASTER_DUSTWALLOWMARSH2          }, -- "Theramore, Dustwallow Marsh"
        {   180,  2682.0,     1466.0,     233.0,      1,      POI_FLIGHTMASTER_STONETALONMOUNTAINS1      }, -- "Stonetalon Peak, Stonetalon Mountains"
        {   180,  136.0,      1326.0,     193.0,      1,      POI_FLIGHTMASTER_DESOLACE1                 }, -- "Nijel's Point, Desolace"
        {   180,  -7224.0,    -3738.0,    8.0,        1,      POI_FLIGHTMASTER_TANARIS1                  }, -- "Gadgetzan, Tanaris"
        {   180,  282.0,      -2001.0,    194.0,      0,      POI_FLIGHTMASTER_THEHINTERLANDS1           }, -- "Aerie Peak, The Hinterlands"
        {   180,  -4370.0,    3340.0,     12.0,       1,      POI_FLIGHTMASTER_FERALAS2                  }, -- "Feathermoon Stronghold, Feralas"
        {   180,  -11110.0,   -3437.0,    79.0,       0,      POI_FLIGHTMASTER_BLASTEDLANDS1             }, -- "Nethergarde Keep, Blasted Lands"
        {   180,  7454.0,     -2491.0,    462.0,      1,      POI_FLIGHTMASTER_MOONGLADE1                }, -- "Moonglade"
        {   180,  6800.0,     -4742.0,    701.0,      1,      POI_FLIGHTMASTER_WINTERSPRING1             }, -- "Everlook, Winterspring"
        {   180,  2718.0,     -3880.0,    101.0,      1,      POI_FLIGHTMASTER_ASZHARA1                  }, -- "Talrendis, Azshara"
        {   180,  6204.0,     -1951.0,    571.0,      1,      POI_FLIGHTMASTER_FELWOOD2                  }, -- "Talonbranch Glade, Felwood"
        {   180,  928.0,      -1429.0,    64.0,       0,      POI_FLIGHTMASTER_WESTERNPLAGUELANDS2       }, -- "Chillwind Camp, Western Plaguelands"
        {   180,  2269.0,     -5345.0,    87.0,       0,      POI_FLIGHTMASTER_EASTERNPLAGUELANDS2       }, -- "Light's Hope Chapel, Eastern Plaguelands"
        {   180,  -6758.0,    775.0,      89.0,       1,      POI_FLIGHTMASTER_SILITHUS1                 }, -- "Cenarion Hold, Silithus"
        {   180,  -665.0,     2715.0,     94.0,       530,    POI_FLIGHTMASTER_HELLFIREPENINSULA1        }, -- "Honor Hold, Hellfire Peninsula"
        {   180,  -1930.0,    -11956.0,   57.0,       530,    POI_FLIGHTMASTER_BLOODMYSTISLE1            }, -- "Blood Watch, Bloodmyst Isle"
        {   180,  -4057.0,    -11788.0,   8.0,        530,    POI_FLIGHTMASTER_AZUREMYSTISLE1            }, -- "The Exodar"
        {   180,  199.0,      4238.0,     121.0,      530,    POI_FLIGHTMASTER_HELLFIREPENINSULA2        }, -- "Temple of Telhamat, Hellfire Peninsula"
        {   180,  210.0,      6065.0,     148.0,      530,    POI_FLIGHTMASTER_ZANGARMARSH1              }, -- "Telredor, Zangarmarsh"
        {   180,  -2723.0,    7302.0,     88.0,       530,    POI_FLIGHTMASTER_NAGRAND1                  }, -- "Telaar, Nagrand"
        {   180,  -2995.0,    3873.0,     9.0,        530,    POI_FLIGHTMASTER_TEROKKARFOREST2           }, -- "Allerian Stronghold, Terokkar Forest"
        {   180,  -323.0,     1027.0,     54.0,       530,    POI_FLIGHTMASTER_HELLFIREPENINSULA3        }, -- "The Dark Portal, Alliance"
        {   180,  2187.0,     6794.0,     183.0,      530,    POI_FLIGHTMASTER_BLADESEDGEMOUNTAINS2      }, -- "Sylvanaar, Blade's Edge Mountains"
        {   180,  -3980.0,    2156.0,     105.0,      530,    POI_FLIGHTMASTER_SHADOWMOONVALLEY3         }, -- "Wildhammer Stronghold, Shadowmoon Valley"
        {   180,  279.0,      1489.0,     -15.0,      530,    POI_FLIGHTMASTER_HELLFIREPENINSULA4        }, -- "Shatter Point, Hellfire Peninsula"
        {   180,  1860.0,     5528.0,     277.0,      530,    POI_FLIGHTMASTER_BLADESEDGEMOUNTAINS3      }, -- "Toshley Station, Blade's Edge Mountains"
        {   180,  963.0,      7399.0,     29.0,       530,    POI_FLIGHTMASTER_ZANGARMARSH2              }, -- "Orebor Harborage, Zangarmarsh"
        {   180,  3002.0,     -3206.0,    190.0,      1,      POI_FLIGHTMASTER_ASHENVALE2                }, -- "Forest Song, Ashenvale"
        {   180,  567.0,      -5012.0,    11.0,       571,    POI_FLIGHTMASTER_HOWLINGFJORD2             }, -- "Valgarde Port, Howling Fjord"
        {   180,  1343.0,     -3287.0,    174.0,      571,    POI_FLIGHTMASTER_HOWLINGFJORD3             }, -- "Westguard Keep, Howling Fjord"
        {   180,  2467.0,     -5028.0,    283.0,      571,    POI_FLIGHTMASTER_HOWLINGFJORD4             }, -- "Fort Wildervar, Howling Fjord"
        {   180,  -11340.0,   -219.0,     75.0,       0,      POI_FLIGHTMASTER_STRANGLETHORNVALE2        }, -- "Rebel Camp, Stranglethorn Vale"
        {   180,  4126.0,     5309.0,     28.0,       571,    POI_FLIGHTMASTER_BOREANTUNDRA4             }, -- "Fizzcrank Airstrip, Borean Tundra"
        {   180,  4582.0,     -4254.0,    182.0,      571,    POI_FLIGHTMASTER_GRIZZLYHILLS1             }, -- "Westfall Brigade Encampment, Grizzly Hills"
        {   180,  4606.0,     1410.0,     194.0,      571,    POI_FLIGHTMASTER_DRAGONBLIGHT3             }, -- "Fordragon Hold, Dragonblight"
        {   180,  3712.0,     -694.0,     215.0,      571,    POI_FLIGHTMASTER_DRAGONBLIGHT4             }, -- "Wintergarde Keep, Dragonblight"
        {   180,  2272.0,     5171.0,     11.0,       571,    POI_FLIGHTMASTER_BOREANTUNDRA5             }, -- "Valiance Keep, Borean Tundra"
        {   180,  3447.0,     -2754.0,    199.0,      571,    POI_FLIGHTMASTER_GRIZZLYHILLS2             }, -- "Amberpine Lodge, Grizzly Hills"
        {   180,  3506.0,     1990.0,     65.0,       571,    POI_FLIGHTMASTER_DRAGONBLIGHT5             }, -- "Stars' Rest, Dragonblight"
        {   180,  5032.0,     -521.0,     226.0,      571,    POI_FLIGHTMASTER_CRYSTALSONGFOREST1        }, -- "Windrunner's Overlook, Crystalsong Forest"
        {   179,  5023.0,     3686.0,     363.0,      571,    POI_FLIGHTMASTER_WINTERGRASP2              }, -- "Warsong Camp, Wintergrasp"
        {   179,  2023.0,     4702.0,     150.0,      530,    POI_FLIGHTMASTER_BLADESEDGEMOUNTAINS4      }, -- "Mok'Nathal Village, Blade's Edge Mountains"
        {   179,  -12417.0,   144.0,      3.0,        0,      POI_FLIGHTMASTER_STRANGLETHORNVALE3        }, -- "Grom'gol Base Camp, Stranglethorn Vale"
        {   179,  473.0,      1533.0,     131.0,      0,      POI_FLIGHTMASTER_SILVERPINEFOREST1         }, -- "The Sepulcher, Silverpine Forest"
        {   179,  2.0,        -857.0,     58.0,       0,      POI_FLIGHTMASTER_HILLSBRAD2                }, -- "Tarren Mill, Hillsbrad"
        {   179,  -917.0,     -3496.0,    70.0,       0,      POI_FLIGHTMASTER_ARATHI2                   }, -- "Hammerfall, Arathi"
        {   179,  -14448.0,   506.0,      26.0,       0,      POI_FLIGHTMASTER_STRANGLETHORNVALE4        }, -- "Booty Bay, Stranglethorn Vale"
        {   179,  -6632.0,    -2178.0,    244.0,      0,      POI_FLIGHTMASTER_BADLANDS1                 }, -- "Kargath, Badlands"
        {   179,  -1196.0,    26.0,       177.0,      1,      POI_FLIGHTMASTER_MULGORE1                  }, -- "Thunder Bluff, Mulgore"
        {   179,  -6559.0,    -1100.0,    310.0,      0,      POI_FLIGHTMASTER_SEARINGGORGE2             }, -- "Thorium Point, Searing Gorge"
        {   179,  1676.0,     -4313.0,    61.0,       1,      POI_FLIGHTMASTER_DUROTAR1                  }, -- "Orgrimmar, Durotar"
        {   179,  -437.0,     -2596.0,    95.0,       1,      POI_FLIGHTMASTER_THEBARRENS2               }, -- "Crossroads, The Barrens"
        {   179,  968.0,      1042.0,     104.0,      1,      POI_FLIGHTMASTER_STONETALONMOUNTAINS2      }, -- "Sun Rock Retreat, Stonetalon Mountains"
        {   179,  -631.0,     -4720.0,    5.0,        0,      POI_FLIGHTMASTER_THEHINTERLANDS2           }, -- "Revantusk Village, The Hinterlands"
        {   179,  -5407.0,    -2419.0,    89.0,       1,      POI_FLIGHTMASTER_THOUSANDNEEDLES1          }, -- "Freewind Post, Thousand Needles"
        {   179,  1567.0,     266.0,      -43.0,      0,      POI_FLIGHTMASTER_TIRISFAL1                 }, -- "Undercity, Tirisfal"
        {   179,  -10459.0,   -3279.0,    21.0,       0,      POI_FLIGHTMASTER_SWAMPOFSORROWS1           }, -- "Stonard, Swamp of Sorrows"
        {   179,  -1770.0,    3262.0,     5.0,        1,      POI_FLIGHTMASTER_DESOLACE2                 }, -- "Shadowprey Village, Desolace"
        {   179,  -7045.0,    -3779.0,    10.0,       1,      POI_FLIGHTMASTER_TANARIS2                  }, -- "Gadgetzan, Tanaris"
        {   179,  -4421.0,    198.0,      25.0,       1,      POI_FLIGHTMASTER_FERALAS3                  }, -- "Camp Mojache, Feralas"
        {   179,  3664.0,     -4390.0,    113.0,      1,      POI_FLIGHTMASTER_AZSHARA2                  }, -- "Valormok, Azshara"
        {   179,  -2384.0,    -1880.0,    95.0,       1,      POI_FLIGHTMASTER_THEBARRENS3               }, -- "Camp Taurajo, The Barrens"
        {   179,  6815.0,     -4610.0,    710.0,      1,      POI_FLIGHTMASTER_WINTERSPRING2             }, -- "Everlook, Winterspring"
        {   179,  -3149.0,    -2842.0,    34.0,       1,      POI_FLIGHTMASTER_DUSTWALLOWMARSH3          }, -- "Brackenwall Village, Dustwallow Marsh"
        {   179,  5064.0,     -338.0,     367.0,      1,      POI_FLIGHTMASTER_FELWOOD3                  }, -- "Bloodvenom Post, Felwood"
        {   179,  3373.0,     994.0,      5.0,        1,      POI_FLIGHTMASTER_ASHENVALE3                }, -- "Zoram'gar Outpost, Ashenvale"
        {   179,  2305.0,     -2520.0,    103.0,      1,      POI_FLIGHTMASTER_ASHENVALE4                }, -- "Splintertree, Ashenvale"
        {   179,  2328.0,     -5290.0,    81.0,       0,      POI_FLIGHTMASTER_EASTERNPLAGUELANDS3       }, -- "Light's Hope Chapel, Eastern Plaguelands"
        {   179,  7466.0,     -2122.0,    492.0,      1,      POI_FLIGHTMASTER_MOONGLADE2                }, -- "Moonglade"
        {   179,  -7504.0,    -2190.0,    165.0,      0,      POI_FLIGHTMASTER_BURNINGSTEPPES2           }, -- "Flame Crest, Burning Steppes"
        {   179,  -6810.0,    841.0,      49.0,       1,      POI_FLIGHTMASTER_SILITHUS2                 }, -- "Cenarion Hold, Silithus"
        {   179,  7595.0,     -6782.0,    86.0,       530,    POI_FLIGHTMASTER_GHOSTLANDS2               }, -- "Tranquillien, Ghostlands"
        {   179,  9376.0,     -7165.0,    9.0,        530,    POI_FLIGHTMASTER_EVERSONGWOODS1            }, -- "Silvermoon City"
        {   179,  233.0,      2632.0,     88.0,       530,    POI_FLIGHTMASTER_HELLFIREPENINSULA5        }, -- "Thrallmar, Hellfire Peninsula"
        {   179,  223.0,      7812.0,     22.0,       530,    POI_FLIGHTMASTER_ZANGARMARSH3              }, -- "Zabra'jin, Zangarmarsh"
        {   179,  -2563.0,    4426.0,     39.0,       530,    POI_FLIGHTMASTER_TEROKKARFOREST3           }, -- "Stonebreaker Hold, Terokkar Forest"
        {   179,  -1256.0,    7136.0,     57.0,       530,    POI_FLIGHTMASTER_NAGRAND2                  }, -- "Garadar, Nagrand"
        {   179,  -176.0,     1028.0,     54.0,       530,    POI_FLIGHTMASTER_HELLFIREPENINSULA6        }, -- "The Dark Portal, Horde"
        {   179,  -584.0,     4104.0,     91.0,       530,    POI_FLIGHTMASTER_HELLFIREPENINSULA7        }, -- "Falcon Watch, Hellfire Peninsula"
        {   179,  2451.0,     6022.0,     154.0,      530,    POI_FLIGHTMASTER_BLADESEDGEMOUNTAINS5      }, -- "Thunderlord Stronghold, Blade's Edge Mountains"
        {   179,  -3018.0,    2556.0,     79.0,       530,    POI_FLIGHTMASTER_SHADOWMOONVALLEY4         }, -- "Shadowmoon Village, Shadowmoon Valley"
        {   179,  -1314.0,    2355.0,     89.0,       530,    POI_FLIGHTMASTER_HELLFIREPENINSULA8        }, -- "Spinebreaker Ridge, Hellfire Peninsula"
        {   179,  87.0,       5213.0,     23.0,       530,    POI_FLIGHTMASTER_ZANGARMARSH4              }, -- "Swamprat Post, Zangarmarsh"
        {   179,  2649.0,     -4394.0,    283.0,      571,    POI_FLIGHTMASTER_HOWLINGFJORD5             }, -- "Camp Winterhoof, Howling Fjord"
        {   179,  400.0,      -4542.0,    245.0,      571,    POI_FLIGHTMASTER_HOWLINGFJORD6             }, -- "New Agamand, Howling Fjord"
        {   179,  2922.0,     6244.0,     208.0,      571,    POI_FLIGHTMASTER_BOREANTUNDRA6             }, -- "Warsong Hold, Borean Tundra"
        {   179,  3863.0,     1523.0,     90.0,       571,    POI_FLIGHTMASTER_DRAGONBLIGHT6             }, -- "Agmar's Hammer, Dragonblight"
        {   179,  2106.0,     -2968.0,    148.0,      571,    POI_FLIGHTMASTER_HOWLINGFJORD7             }, -- "Apothecary Camp, Howling Fjord"
        {   179,  3248.0,     -662.0,     166.0,      571,    POI_FLIGHTMASTER_DRAGONBLIGHT7             }, -- "Venomspite, Dragonblight"
        {   179,  3446.0,     4088.0,     16.0,       571,    POI_FLIGHTMASTER_BOREANTUNDRA7             }, -- "Camp Tunka'le, Borean Tundra"
        {   179,  4473.0,     5708.0,     81.0,       571,    POI_FLIGHTMASTER_BOREANTUNDRA8             }, -- "Bor'gorok Outpost, Borean Tundra"
        {   179,  4941.0,     1167.0,     239.0,      571,    POI_FLIGHTMASTER_DRAGONBLIGHT8             }, -- "Kor'kron Vangaurd, Dragonblight"
        {   179,  3261.0,     -2265.0,    114.0,      571,    POI_FLIGHTMASTER_GRIZZLYHILLS3             }, -- "Conquest Hold, Grizzly Hills"
        {   179,  3874.0,     -4520.0,    217.0,      571,    POI_FLIGHTMASTER_GRIZZLYHILLS4             }, -- "Camp Oneqwah, Grizzly Hills"
        {   179,  1919.0,     -6176.0,    24.0,       571,    POI_FLIGHTMASTER_HOWLINGFJORD8             }, -- "Vengeance Landing, Howling Fjord"
        {   179,  7798.0,     -2810.0,    1217.0,     571,    POI_FLIGHTMASTER_THESTORMPEAKS7            }, -- "Camp Tunka'lo, The Storm Peaks"
        {   179,  5587.0,     -694.0,     206.0,      571,    POI_FLIGHTMASTER_WINTERGRASP3              }, -- "Sunreaver's Command, Wintergrasp"
        {   179,  1730.0,     -743.0,     59.0,       0,      POI_FLIGHTMASTER_TIRISFAL2                 }, -- "The Bulwark, Tirisfal"
    },  
}   