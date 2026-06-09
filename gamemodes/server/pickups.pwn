#include <YSI_Coding\y_hooks>

/*
* General Pickups
*/
new ATMPICKUP[15];
new BIZPICKUP[22];
new FISHING;
new ROBPICKUP[2];
new ROBPICKUP2[3];
new ROBPICKUPBOX[2];
new VILNAPICKUP;
new TowerPickup[3];
new CarShopPickup[3];
new CarShopPickup2[3];
new ElevatorPickup[3];
new BankPickup[9];
new BankCommandPickup[3];
new WSPickup;
new OfficePickup;

/*
* Faction Pickups
*/
new BloodPickup[2];
new YakuzaPickup[2];
new BGMPickup[4];
new BallasPickup[2];
new SoldierPickup[2];
new RifaPickup[3];
new IPDPickup[6];
new CripzPickup[2];
new SyndicatePickup[2];
new BountyPickup[2];
new IPDDUTY;
new IFCDUTY;

/*
* Faction Heal and Armour
*/
new viphealarmour[2];
new grovehealarmour[2];
new ipdHealArmour[2];
new rifahealarmour[2];
new soldierhealarmour[2];
new cripzhealarmour[2];
new bgmhealarmour[2];
new yakuzahealarmour[2];
new blackstreethealarmour[2];
new syndicatehealarmour[2];
new bloodhealarmour[2];
new ms13healarmour[2];
new vagoshealarmour[2];
new triadshealarmour[2];
new italianhealarmour[2];
new nanghealarmour[2];
new bountyhealarmour[2];

/*
* Pickups
*/
hook OnGameModeInit()
{
    IFCDUTY = CreatePickup(1275, 1, 283.4191, 1387.8158, 10.5859, 0);
    WSPickup = CreatePickup(1239, 1, 305.5214, -141.7592, 1004.0625, 0);
    IPDDUTY = CreatePickup(1239, 1, 256.8192, 63.6511, 1003.6406, 1);
    CreatePickup(1239, 1, 2005.9323, 2298.5537, 10.8203, 0);
    CreatePickup(1239, 1, 1838.5139, -1856.2627, 13.3828, 0);
    CreatePickup(1275, 1, 1015.9524, -1026.5002, 32.1016, 0);
    CreatePickup(1275, 1, 1652.8765, 2199.9587, 10.8203, 0);
    CreatePickup(1318, 1, -1392.2205, 2111.2021, 42.1264, -1);
    IPDPickup[0] = CreatePickup(1318, 1, 1555.2531, -1675.6143, 16.1953, 0);
    IPDPickup[1] = CreatePickup(1318, 1, 246.7372, 63.0483, 1003.6406, 1);
    IPDPickup[2] = CreatePickup(1318, 1, -1605.6638, 710.3925, 13.8672, 0);
    IPDPickup[3] = CreatePickup(1318, 1, 246.3961, 87.8423, 1003.6406, 1);
    IPDPickup[4] = CreatePickup(1318, 1, 2287.0984, 2432.3669, 10.8203, 0);
    IPDPickup[5] = CreatePickup(1318, 1, 242.2486, 66.3642, 1003.6406, 1);
    BloodPickup[0] = CreatePickup(1318, 1, 1083.0112, -1226.7196, 15.8203, 0);
    BloodPickup[1] = CreatePickup(1318, 1, 1416.6842, 3.6414, 1000.9269, 3);
    YakuzaPickup[0] = CreatePickup(1318, 1, 2595.7300, 2790.6204, 10.8203, 0);
    YakuzaPickup[1] = CreatePickup(1318, 1, 1416.6842, 3.6414, 1000.9269, 2);
    RifaPickup[0] = CreatePickup(1318, 1, -2182.9065, 956.6106, 80.0000, 0);
    RifaPickup[1] = CreatePickup(1318, 1, -2173.5759, 974.2741, 80.0000, 0);
    RifaPickup[2] = CreatePickup(1318, 1, 1416.6842, 3.6414, 1000.9269, 1);
    SyndicatePickup[0] = CreatePickup(1318, 1, 1733.4287, 2814.9548, 14.2735, 0);
    SyndicatePickup[1] = CreatePickup(1318, 1, 2496.049804, -1695.238159, 1014.742187, 2);
    CripzPickup[0] = CreatePickup(1318, 1, 300.2113, -1154.4961, 81.3665, 0);
    CripzPickup[1] = CreatePickup(1318, 1, 140.1744, 1366.1003, 1083.8594, 1);
    SoldierPickup[0] = CreatePickup(1318, 1, 2324.4341, -1149.4835, 1050.7101, 1);
    SoldierPickup[1] = CreatePickup(1318, 1, -1754.2659, 964.0753, 24.8906, 0);
    BallasPickup[0] = CreatePickup(1318, 1, 2146.7976, -1470.4761, 26.0426, 0);
    BallasPickup[1] = CreatePickup(1318, 1, 318.5974, 1115.6239, 1083.8828, 1);
    BountyPickup[0] = CreatePickup(1318, 1, 691.5796, -1275.8766, 13.5607, 0);
    BountyPickup[1] = CreatePickup(1318, 1, 1261.3009, -785.4238, 1091.9063, 2);
    BGMPickup[0] = CreatePickup(1318, 1, 1259.6387, -785.5069, 92.0313, 0);
    BGMPickup[1] = CreatePickup(1318, 1, 1261.3009, -785.4238, 1091.9063, 1);
    BGMPickup[2] = CreatePickup(1318, 1, 1260.7024, -781.2197, 1091.9063, 1);
    BGMPickup[3] = CreatePickup(1318, 1, 1416.6842, 3.6414, 1000.9269, 4);
    CarShopPickup2[0] = CreatePickup(1318, 1, 1411.5128, -1699.5909, 13.5395, 0);
    CarShopPickup2[1] = CreatePickup(1318, 1, -1444.0856, 1087.5129, 1040.7969, 1);
    CarShopPickup[0] = CreatePickup(1318, 1, 2006.8207, 1167.4012, 10.8203, 0);
    CarShopPickup[1] = CreatePickup(1318, 1, -1444.0856, 1087.5129, 1040.7969, 0);
    TowerPickup[0] = CreatePickup(1318, 1, 1570.4105, -1337.3629, 16.4844, 0);
    TowerPickup[1] = CreatePickup(1318, 1, 1548.6501, -1363.8597, 326.2183, 0);
    OfficePickup = CreatePickup(1318, 1, 1794.0231, -1301.7737, 13.5050, 0);
    BankPickup[5] = CreatePickup(1274, 1, -1492.1313, 920.0684, 7.1875);
    BankPickup[0] = CreatePickup(1274, 1, 1481.0358, -1772.3138, 18.7958);
    BankPickup[1] = CreatePickup(1274, 1, 2412.5020, 1123.8976, 10.8203);
    BankPickup[2] = CreatePickup(1274, 1, 2305.5884, -16.3410, 26.7496, 1);
    BankPickup[3] = CreatePickup(1274, 1, 2305.5884, -16.3410, 26.7496, 2);
    BankPickup[4] = CreatePickup(1274, 1, 2305.5884, -16.3410, 26.7496, 3);
    //BankPickup[6]=CreatePickup(1274, 1, 2315.5828,-0.0715,26.7422,1);
    //BankPickup[7]=CreatePickup(1274, 1, 2315.5828,-0.0715,26.7422,2);
    //BankPickup[8]=CreatePickup(1274, 1, 2315.5828,-0.0715,26.7422,3);
    BankCommandPickup[0] = CreatePickup(1274, 1, 2316.6213, -9.9516, 26.7422, 1);
    BankCommandPickup[1] = CreatePickup(1274, 1, 2316.6213, -9.9516, 26.7422, 2);
    BankCommandPickup[2] = CreatePickup(1274, 1, 2316.6213, -9.9516, 26.7422, 3);
    bountyhealarmour[0] = CreatePickup(1240, 1, 1264.1427, -778.0394, 1091.9063, 2);
    bountyhealarmour[1] = CreatePickup(1242, 1, 1264.1427, -778.0394, 1091.9063, 2);
    ms13healarmour[0] = CreatePickup(1240, 1, -39.4799, 1077.1060, 20.2422, 0);
    ms13healarmour[1] = CreatePickup(1242, 1, -39.4799, 1077.1060, 20.2422, 0);
    vagoshealarmour[0] = CreatePickup(1240, 1, 1879.9246, 2337.5054, 10.9799, 0);
    vagoshealarmour[1] = CreatePickup(1242, 1, 1879.9246, 2337.5054, 10.9799, 0);
    triadshealarmour[0] = CreatePickup(1240, 1, 1967.2881, 953.4484, 10.8203, 0);
    triadshealarmour[1] = CreatePickup(1242, 1, 1967.2881, 953.4484, 10.8203, 0);
    italianhealarmour[0] = CreatePickup(1240, 1, -684.9741, 942.3038, 13.6328, 0);
    italianhealarmour[1] = CreatePickup(1242, 1, -684.9741, 942.3038, 13.6328, 0);
    nanghealarmour[0] = CreatePickup(1240, 1, 2632.2979, 1815.6191, 11.0161, 0);
    nanghealarmour[1] = CreatePickup(1242, 1, 2632.2979, 1815.6191, 11.0161, 0);
    bloodhealarmour[0] = CreatePickup(1240, 1, 1083.0128, -1229.4845, 15.8203, 0);
    bloodhealarmour[1] = CreatePickup(1242, 1, 1083.0128, -1229.4845, 15.8203, 0);
    cripzhealarmour[0] = CreatePickup(1240, 1, 140.3037, 1368.5403, 1083.8630, 1);
    cripzhealarmour[1] = CreatePickup(1242, 1, 140.3037, 1368.5403, 1083.8630, 1);
    bgmhealarmour[0] = CreatePickup(1240, 1, 1267.1973, -787.3447, 1091.9063, 1);
    bgmhealarmour[1] = CreatePickup(1242, 1, 1267.1973, -787.3447, 1091.9063, 1);
    syndicatehealarmour[0] = CreatePickup(1240, 1, 1736.4424, 2803.6094, 11.3438, 0);
    syndicatehealarmour[1] = CreatePickup(1242, 1, 1736.4424, 2803.6094, 11.3438, 0);
    blackstreethealarmour[0] = CreatePickup(1240, 1, -818.2010, 1551.0867, 27.1172, 0);
    blackstreethealarmour[1] = CreatePickup(1242, 1, -818.2010, 1551.0867, 27.1172, 0);
    yakuzahealarmour[0] = CreatePickup(1240, 1, 2594.0845, 2793.8118, 10.8203, 0);
    yakuzahealarmour[1] = CreatePickup(1242, 1, 2594.0845, 2793.8118, 10.8203, 0);
    grovehealarmour[0] = CreatePickup(1240, 1, 2498.2009, -1705.7358, 1014.7422, 1);
    grovehealarmour[1] = CreatePickup(1242, 1, 2498.2009, -1705.7358, 1014.7422, 1);
    soldierhealarmour[0] = CreatePickup(1240, 1, 2324.3743, -1147.4288, 1050.7101, 1);
    soldierhealarmour[1] = CreatePickup(1242, 1, 2324.3743, -1147.4288, 1050.7101, 1);
    viphealarmour[0] = CreatePickup(1240, 1, 1262.4489, -2026.9534, 59.3499, 0);
    viphealarmour[1] = CreatePickup(1242, 1, 1262.4489, -2026.9534, 59.3499, 0);
    ipdHealArmour[0] = CreatePickup(1240, 1, 256.7960, 70.0962, 1003.6406, 1);
    ipdHealArmour[1] = CreatePickup(1242, 1, 256.7960, 70.0962, 1003.6406, 1);
    rifahealarmour[0] = CreatePickup(1240, 1, 2451.2534, -1696.0654, 1013.5078, 1);
    rifahealarmour[1] = CreatePickup(1242, 1, 2451.2534, -1696.0654, 1013.5078, 1);
    ElevatorPickup[0] = CreatePickup(1318, 1, 1806.0117, -1303.7578, 125.7266, 0);
    ElevatorPickup[1] = CreatePickup(1318, 1, 1801.1755, -1303.1967, 131.7344, 0);
    ROBPICKUP2[0] = CreatePickup(1274, 1, 2144.2419, 1639.6534, 993.5761, -1);
    ROBPICKUP2[1] = CreatePickup(1274, 1, 1710.7833, -1643.9384, 27.2035, -1);
    ROBPICKUP2[2] = CreatePickup(1274, 1, -1292.2670, 490.4918, 11.1953, -1);
    ROBPICKUPBOX[0] = CreatePickup(1254, 1, 2799.0291, -2393.8811, 13.9560, -1);
    ROBPICKUP[0] = CreatePickup(1314, 1, 2447.8630, -1963.3013, 13.5469);
    ROBPICKUP[1] = CreatePickup(1314, 1, 2145.2324, 2834.2690, 10.8203);
    FISHING = CreatePickup(1239, 1, -1378.9862, 2110.7991, 42.2000, -1);
    VILNAPICKUP = CreatePickup(1318, 1, 279.1491, 1833.1394, 18.0874, 0);
    ATMPICKUP[1] = CreatePickup(1274, 1, 1538.5005, -1614.0280, 13.5469, 0);
    ATMPICKUP[2] = CreatePickup(1274, 1, 386.5083, -1827.4729, 7.8359, 0);
    ATMPICKUP[3] = CreatePickup(1274, 1, 1239.6632, -2041.0039, 59.9210, 0);
    ATMPICKUP[4] = CreatePickup(1274, 1, 379.5750, -2060.4958, 7.8359, 0);
    ATMPICKUP[5] = CreatePickup(1274, 1, 672.7897, -503.1278, 16.3359, 0);
    ATMPICKUP[6] = CreatePickup(1274, 1, 2489.7417, 923.2555, 11.0234, 0);
    ATMPICKUP[7] = CreatePickup(1274, 1, 2181.0786, 2461.8982, 10.8203, 0);
    ATMPICKUP[8] = CreatePickup(1274, 1, -174.5244, 1139.4585, 19.7500, 0);
    ATMPICKUP[9] = CreatePickup(1274, 1, -1487.1859, 2583.0183, 55.8359, 0);
    ATMPICKUP[10] = CreatePickup(1274, 1, -2491.7312, 2366.4600, 10.2736, 0);
    ATMPICKUP[11] = CreatePickup(1274, 1, 210.3036, 1809.4667, 21.8672, 0);
    ATMPICKUP[12] = CreatePickup(1274, 1, 2194.2754, 1986.2334, 12.2969, 0);
    ATMPICKUP[13] = CreatePickup(1274, 1, 398.4085, -1805.4634, 7.8379, 0);
    BIZPICKUP[0] = CreatePickup(1239, 1, 497.4557, -75.6231, 998.7578, -1);
    BIZPICKUP[1] = CreatePickup(1239, 1, 287.8558, -109.2027, 1001.5156, -1);
    BIZPICKUP[2] = CreatePickup(1581, 1, -2026.8839, -115.1081, 1035.1719, -1);
    BIZPICKUP[3] = CreatePickup(1239, 1, -30.9303, -28.3415, 1003.557, -1);
    BIZPICKUP[4] = CreatePickup(1239, 1, 206.9638, -129.8357, 1003.5078, -1);
    BIZPICKUP[5] = CreatePickup(1239, 1, 376.6553, -68.1552, 1001.5151, -1);
    BIZPICKUP[6] = CreatePickup(1239, 1, 822.8092, 1.7616, 1004.1797, -1);
    BIZPICKUP[7] = CreatePickup(1239, 1, 203.8465, -44.4779, 1001.8047, -1);
    BIZPICKUP[8] = CreatePickup(1239, 1, 499.3484, -20.5936, 1000.6797, -1);
    BIZPICKUP[9] = CreatePickup(1239, 1, 755.7616, 1440.6393, 1102.7031, -1);
    BIZPICKUP[10] = CreatePickup(1239, 1, 773.6641, -72.9778, 1000.6484, -1);
    BIZPICKUP[11] = CreatePickup(1239, 1, 1215.0492, -12.2688, 1000.9219, -1);
    BIZPICKUP[12] = CreatePickup(1239, 1, 369.5925, -6.7357, 1001.8589, -1);
    BIZPICKUP[13] = CreatePickup(1239, 1, 450.5178, -84.4856, 999.5547, -1);
    BIZPICKUP[14] = CreatePickup(1239, 1, 1720.5767, -1671.2698, 20.2241, -1);
    BIZPICKUP[15] = CreatePickup(1239, 1, -23.3775, -55.2958, 1003.5469, -1);
    BIZPICKUP[16] = CreatePickup(1239, 1, 773.0745, -39.3959, 1000.6865, -1);
    BIZPICKUP[17] = CreatePickup(1239, 1, 2568.4888, -1296.4260, 1037.7734, -1);
    BIZPICKUP[18] = CreatePickup(1239, 1, 2548.3892, -1293.2520, 1044.1250, -1);
    BIZPICKUP[19] = CreatePickup(1239, 1, 2537.1509, -1286.3304, 1054.6406, -1);
    BIZPICKUP[20] = CreatePickup(1239, 1, -1395.4200, 1245.6000, 1039.8672, -1);
    CreatePickup(1240, 2, 2029.7926, 1550.6443, 13.1209, 0);
    CreatePickup(1242, 2, 2028.0229, 1540.1416, 13.1209, 0);
    CreatePickup(1240, 2, 1492.2445, -1639.6790, 15.0469, 0);
    CreatePickup(1242, 2, 1466.9248, -1638.8812, 15.0469, 0);
    //vip teleports - open
    CreatePickup(1318, 0, -1334.0717, 2061.0530, 52.7941, -1);
    CreatePickup(1318, 0, 1247.4926, -2047.3232, 59.9830, -1);
    CreatePickup(1318, 0, 1213.1379, -2004.4064, 68.9335, -1);
    CreatePickup(1318, 0, 1213.1505, -2068.9939, 68.9775, -1);
    CreatePickup(1318, 0, 1226.9058, -2004.3683, 62.9966, -1); //boat job
    CreatePickup(1318, 0, 1237.1945, -2004.9026, 59.8630, -1); //coalmine job
    CreatePickup(1318, 0, 849.7452, 849.4290, 13.2172, -1); //coalmine vipbase
    CreatePickup(1318, 0, 1221.8916, -2004.3669, 65.1029, -1); //sweeper job
    CreatePickup(1318, 0, 592.5229, 1232.9878, 11.7188, -1); //sweeperjob vipbase
    CreatePickup(1318, 0, 1216.6649, -2004.4821, 65.1027, -1); //pilot job
    CreatePickup(1318, 0, 396.6920, 2529.6890, 16.5576, -1); //pilot job vipbase
    CreatePickup(1318, 0, 1237.1299, -2068.8193, 59.8614, -1); //truck job
    CreatePickup(1318, 0, 76.3090, -263.6589, 1.5781, -1); //truck job vipbase
    CreatePickup(1318, 0, 1226.6023, -2069.1226, 62.9998, -1); //bus job
    CreatePickup(1318, 0, -542.4196, 2586.2869, 53.5156, -1); //bus job vipbase
    CreatePickup(1318, 0, 1232.2550, -2068.9458, 60.8984, -1); //pizzaboy job
    CreatePickup(1318, 0, 1363.7058, 253.9488, 19.5669, -1); //pizzaboy job vipbase
    CreatePickup(1318, 0, 1216.4745, -2069.0505, 65.1019, -1); //deliver job
    CreatePickup(1318, 0, -15.7632, -319.8665, 5.4229, -1); //deliver job vipbase

    return Y_HOOKS_CONTINUE_RETURN_1;
}

/*
* Pickup Callback
*/
public OnPlayerPickUpPickup(playerid, pickupid)
{
    new Float:health;
    GetPlayerHealth(playerid, health);
    new Float:armour;
    GetPlayerArmour(playerid, armour);
    if (pickupid == rifahealarmour[0] && PlayerInfo[playerid][pTeam] == 8 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == rifahealarmour[1] && PlayerInfo[playerid][pTeam] == 8 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == ipdHealArmour[0] && PlayerInfo[playerid][pTeam] == 15 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == ipdHealArmour[1] && PlayerInfo[playerid][pTeam] == 15 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == viphealarmour[0] && PlayerInfo[playerid][pTeam] == 1 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == viphealarmour[1] && PlayerInfo[playerid][pTeam] == 1 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == grovehealarmour[0] && PlayerInfo[playerid][pTeam] == 2 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == grovehealarmour[1] && PlayerInfo[playerid][pTeam] == 2 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == soldierhealarmour[0] && PlayerInfo[playerid][pTeam] == 16 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == soldierhealarmour[1] && PlayerInfo[playerid][pTeam] == 16 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == cripzhealarmour[0] && PlayerInfo[playerid][pTeam] == 6 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == cripzhealarmour[1] && PlayerInfo[playerid][pTeam] == 6 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == bgmhealarmour[0] && PlayerInfo[playerid][pTeam] == 21 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == bgmhealarmour[1] && PlayerInfo[playerid][pTeam] == 21 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == yakuzahealarmour[0] && PlayerInfo[playerid][pTeam] == 17 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == yakuzahealarmour[1] && PlayerInfo[playerid][pTeam] == 17 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == blackstreethealarmour[0] && PlayerInfo[playerid][pTeam] == 22 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == blackstreethealarmour[1] && PlayerInfo[playerid][pTeam] == 22 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == syndicatehealarmour[0] && PlayerInfo[playerid][pTeam] == 18 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == syndicatehealarmour[1] && PlayerInfo[playerid][pTeam] == 18 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == bloodhealarmour[0] && PlayerInfo[playerid][pTeam] == 19 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == bloodhealarmour[1] && PlayerInfo[playerid][pTeam] == 19 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == ms13healarmour[0] && PlayerInfo[playerid][pTeam] == 20 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == ms13healarmour[1] && PlayerInfo[playerid][pTeam] == 20 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == vagoshealarmour[0] && PlayerInfo[playerid][pTeam] == 4 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == vagoshealarmour[1] && PlayerInfo[playerid][pTeam] == 4 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == triadshealarmour[0] && PlayerInfo[playerid][pTeam] == 4 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == triadshealarmour[1] && PlayerInfo[playerid][pTeam] == 4 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == italianhealarmour[0] && PlayerInfo[playerid][pTeam] == 4 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == italianhealarmour[1] && PlayerInfo[playerid][pTeam] == 4 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == nanghealarmour[0] && PlayerInfo[playerid][pTeam] == 10 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == nanghealarmour[1] && PlayerInfo[playerid][pTeam] == 10 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == bountyhealarmour[0] && PlayerInfo[playerid][pTeam] == 12 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == bountyhealarmour[1] && PlayerInfo[playerid][pTeam] == 12 && armour < 100.0) SetPlayerArmour(playerid, 100);
    new alh = HouseByPickup[pickupid];
    if (IsValidHouse(alh))
    {
        isinhousepickup[playerid] = 1;
        onhousepick2[playerid] = 1;
        playerInHousePickup[playerid] = alh;
        //housetimer[playerid] = SetTimerEx("RemoveHousePick", 900, true, "i", playerid);
    }
    new alb = BizByPickup[pickupid];
    if (IsValidBiz(alb))
    {
        isinbizpickup[playerid] = 1;
        onbizpick2[playerid] = 1;
        playerInBizPickup[playerid] = alb;
        //biztimer[playerid] = SetTimerEx("RemoveBizPick", 900, true, "i", playerid);
    }
    new bizid = playerInBizPickup[pickupid];
    if (IsValidBiz(bizid))
    {
        if (IsPlayerInRangeOfPoint(playerid, 3, BizInfo[bizid][bX], BizInfo[bizid][bY], BizInfo[bizid][bZ]))
        {
            new bizstring[356];
            if (BizInfo[bizid][bOwner] == 0 && BizInfo[bizid][bFee] == 0)
            {
                format(bizstring, 356, "~y~Bussines For Sale~n~~r~%s~n~~w~PRICE:~g~ $%d~n~ ~w~Level: ~b~%d ~n~~w~PAYOUT: ~g~$%d",
                       BizInfo[bizid][bName], BizInfo[bizid][bPrice], BizInfo[bizid][bLevel], BizInfo[bizid][bPayOut]);
                GameTextForPlayer(playerid, bizstring, 1500, 3);
                return 1;
            }
            if (BizInfo[bizid][bOwner] == 0 && BizInfo[bizid][bFee] > 0)
            {
                format(bizstring, 356, "~y~Bussines For Sale~n~~r~%s~n~~w~PRICE:~g~ $%d~n~ ~w~Level: ~b~%d ~n~~w~ENTER FEE: ~y~$%d ~n~~w~PAYOUT: ~g~$%d",
                       BizInfo[bizid][bName], BizInfo[bizid][bPrice], BizInfo[bizid][bLevel], BizInfo[bizid][bFee], BizInfo[bizid][bPayOut]);
                GameTextForPlayer(playerid, bizstring, 1500, 3);
                return 1;
            }
            if (BizInfo[bizid][bOwner] == 1 && BizInfo[bizid][bFee] == 0)
            {
                format(bizstring, 356, "~r~%s~n~~w~Owner:~g~ %s ~n~~w~Level: ~b~%d ~n~~w~PAYOUT: ~g~$%d",
                       BizInfo[bizid][bName], BizInfo[bizid][bOwnerName], BizInfo[bizid][bLevel], BizInfo[bizid][bPayOut]);
                GameTextForPlayer(playerid, bizstring, 1500, 3);
                return 1;
            }
            if (BizInfo[bizid][bOwner] == 1 && BizInfo[bizid][bFee] > 0)
            {
                format(bizstring, 356, "~r~%s~n~~w~Owner:~g~ %s ~n~~w~Level: ~b~%d ~w~~n~ENTER FEE: ~y~$%d ~n~~w~PAYOUT: ~g~$%d",
                       BizInfo[bizid][bName], BizInfo[bizid][bOwnerName], BizInfo[bizid][bLevel], BizInfo[bizid][bFee], BizInfo[bizid][bPayOut]);
                GameTextForPlayer(playerid, bizstring, 1500, 3);
                return 1;
            }
        }
    }
    new houseid = playerInHousePickup[playerid];
    if (IsValidHouse(houseid))
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[houseid][hX], HouseInfo[houseid][hY], HouseInfo[houseid][hZ]))
        {
            new housestring[256];
            if (HouseInfo[houseid][hOwner] == 1)
            {
                format(housestring, sizeof(housestring), "~w~Owner:~g~ %s~n~~w~Level: ~b~ %d~n~",
                       HouseInfo[houseid][hOwnerName],
                       HouseInfo[houseid][hLevel]);
                GameTextForPlayer(playerid, housestring, 1500, 3);
                return 1;
            }

            static const roomDesc[][] =
            {
                "3 ROOMS", "1 ROOM", "1 ROOM", "5 ROOMS", "6 ROOMS",
                "3 ROOMS", "3 ROOMS", "3 ROOMS", "7 ROOMS", "3 ROOMS",
                "4 ROOMS", "4 ROOMS", "7 ROOMS", "7 ROOMS", "4 ROOMS",
                "9 ROOMS", "9 ROOMS", "5 ROOMS", "2 ROOMS", "5 ROOMS",
                "5 ROOMS", "22 ROOMS", "4 ROOMS", "5 ROOMS", "5 ROOMS",
                "4 ROOMS"
            };

            new interior = HouseInfo[houseid][hInterior];
            new rooms[32] = "UNKNOWN";
            if (interior >= 1 && interior <= sizeof(roomDesc))
                format(rooms, sizeof(rooms), "%s", roomDesc[interior - 1]);

            format(housestring, sizeof(housestring),
                   "~y~House For Sale~n~~w~Description:~p~ %s~n~~w~Price:~g~ $%d~n~~w~Level: ~b~%d",
                   rooms, HouseInfo[houseid][hPrice], HouseInfo[houseid][hLevel]);

            GameTextForPlayer(playerid, housestring, 1500, 3);
            return 1;
        }
    }
    if (pickupid == BankPickup[5] && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerPos(playerid, 2307.1792, -15.6580, 28.3014);
        SetPlayerFacingAngle(playerid, 267.51);
        TogglePlayerControllable(playerid, 0);
        SetCameraBehindPlayer(playerid);
        PlayerInfo[playerid][pBankSpawn] = 3;
        SetPlayerVirtualWorld(playerid, 3);
        return 1;
    }
    if (pickupid == BankPickup[0] && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerPos(playerid, 2307.1792, -15.6580, 28.3014);
        SetPlayerFacingAngle(playerid, 267.51);
        TogglePlayerControllable(playerid, 0);
        SetCameraBehindPlayer(playerid);
        PlayerInfo[playerid][pBankSpawn] = 3;
        SetPlayerVirtualWorld(playerid, 1);
        return 1;
    }
    //other bank pickups - location - open
    if (pickupid == BankPickup[6] && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, 322.4386, 111.3972, 1003.2194);
        SetPlayerFacingAngle(playerid, 267.51);
        TogglePlayerControllable(playerid, 0);
        SetCameraBehindPlayer(playerid);
        PlayerInfo[playerid][pBankSpawn] = 3;
        SetPlayerVirtualWorld(playerid, 1);
        return 1;
    }
    if (pickupid == BankPickup[7] && GetPlayerVirtualWorld(playerid) == 2 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, 322.4386, 111.3972, 1003.2194);
        SetPlayerFacingAngle(playerid, 267.51);
        TogglePlayerControllable(playerid, 0);
        SetCameraBehindPlayer(playerid);
        PlayerInfo[playerid][pBankSpawn] = 3;
        SetPlayerVirtualWorld(playerid, 1);
        return 1;
    }
    if (pickupid == BankPickup[8] && GetPlayerVirtualWorld(playerid) == 3 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, 322.4386, 111.3972, 1003.2194);
        SetPlayerFacingAngle(playerid, 267.51);
        TogglePlayerControllable(playerid, 0);
        SetCameraBehindPlayer(playerid);
        PlayerInfo[playerid][pBankSpawn] = 3;
        SetPlayerVirtualWorld(playerid, 1);
        return 1;
    }
    //other bank pickups - location - close
    if (pickupid == BankPickup[1] && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerPos(playerid, 2307.1792, -15.6580, 28.3014);
        SetPlayerFacingAngle(playerid, 267.51);
        TogglePlayerControllable(playerid, 0);
        SetCameraBehindPlayer(playerid);
        PlayerInfo[playerid][pBankSpawn] = 3;
        SetPlayerVirtualWorld(playerid, 2);
        return 1;
    }
    if (pickupid == BankPickup[2] && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerPos(playerid, 1481.3755, -1769.8796, 18.7958);
        SetPlayerFacingAngle(playerid, 0.3163);
        SetCameraBehindPlayer(playerid);
        SetPlayerVirtualWorld(playerid, 0);
        return 1;
    }
    if (pickupid == BankPickup[3] && GetPlayerVirtualWorld(playerid) == 2 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerPos(playerid, 2414.5371, 1123.8458, 10.8203);
        SetPlayerFacingAngle(playerid, 272.9833);
        SetCameraBehindPlayer(playerid);
        SetPlayerVirtualWorld(playerid, 0);
        return 1;
    }
    if (pickupid == BankPickup[4] && GetPlayerVirtualWorld(playerid) == 3 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerPos(playerid, -1494.9438, 920.4615, 7.1875);
        SetPlayerFacingAngle(playerid, 92.1882);
        SetCameraBehindPlayer(playerid);
        SetPlayerVirtualWorld(playerid, 0);
        return 1;
    }
    if (pickupid == BankCommandPickup[0])
    {
        GameTextForPlayer(playerid, "~g~LOS SANTOS BANK ~n~~w~/bank /transfer", 2000, 3);
        return 1;
    }
    if (pickupid == BankCommandPickup[1])
    {
        GameTextForPlayer(playerid, "~g~LAS VENTURAS BANK ~n~~w~/bank /transfer", 2000, 3);
        return 1;
    }
    if (pickupid == BankCommandPickup[2])
    {
        GameTextForPlayer(playerid, "~g~SAN FIERRO BANK ~n~~w~/bank /transfer", 2000, 3);
        return 1;
    }
    if (pickupid == IFCDUTY)
    {
        GameTextForPlayer(playerid, "~g~IFC DUTY~n~~w~/ifcduty", 2000, 3);
        return 1;
    }
    if (pickupid == WSPickup)
    {
        GameTextForPlayer(playerid, "~r~WEAPON SKILL~n~~w~/buyws", 2000, 3);
        return 1;
    }
    if (pickupid == IPDDUTY)
    {
        GameTextForPlayer(playerid, "~b~Intense Police Department DUTY~n~~w~/policeduty", 2000, 3);
        return 1;
    }
    if (pickupid == RifaPickup[0])
    {
        GameTextForPlayer(playerid, "~b~RIFA HOUSE~n~~w~TYPE ~r~/ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == CripzPickup[0])
    {
        GameTextForPlayer(playerid, "~b~VCRIPZ HOUSE~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == CripzPickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BGMPickup[2])
    {
        GameTextForPlayer(playerid, "~p~BGMAFIA DM BIZ~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BGMPickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BGMPickup[0])
    {
        GameTextForPlayer(playerid, "~p~BGMAFIA HOUSE~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BountyPickup[0])
    {
        GameTextForPlayer(playerid, "~g~BOUNTY HUNTERS HOUSE~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BountyPickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BGMPickup[3])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == SoldierPickup[0])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == SoldierPickup[1])
    {
        GameTextForPlayer(playerid, "~p~SOLDIER HOUSE~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BallasPickup[0])
    {
        GameTextForPlayer(playerid, "~p~BALLAS HOUSE~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BallasPickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == RifaPickup[1])
    {
        GameTextForPlayer(playerid, "~b~RIFA DM BIZ~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == RifaPickup[2])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BloodPickup[0])
    {
        GameTextForPlayer(playerid, "~r~BLOOD MAFIA DM BIZ~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BloodPickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == YakuzaPickup[0])
    {
        GameTextForPlayer(playerid, "~y~YAKUZA DM BIZ~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == YakuzaPickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == SyndicatePickup[0])
    {
        GameTextForPlayer(playerid, "~b~SYNDICATE TEXAS HOUSE~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == SyndicatePickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == IPDPickup[0])
    {
        GameTextForPlayer(playerid, "~b~IPD LS~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == IPDPickup[1])
    {
        GameTextForPlayer(playerid, "~b~TELEPORT LS~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == IPDPickup[2])
    {
        GameTextForPlayer(playerid, "~b~IPD SF~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == IPDPickup[3])
    {
        GameTextForPlayer(playerid, "~b~TELEPORT SF~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == IPDPickup[4])
    {
        GameTextForPlayer(playerid, "~b~IPD LV~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == IPDPickup[5])
    {
        GameTextForPlayer(playerid, "~b~TELEPORT LV~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == OfficePickup)
    {
        GameTextForPlayer(playerid, "~w~INTENSE ~g~OFFICE ~r~CENTER~n~~n~~y~TYPE /buyoffice~n~~p~INFO: ~w~/helpoffice /office", 2000, 3);
        return 1;
    }
    if (pickupid == TowerPickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == TowerPickup[0])
    {
        GameTextForPlayer(playerid, "~g~LOS SANTOS TOWER~n~~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == ROBPICKUP[0])
    {
        GameTextForPlayer(playerid, "~r~robbery start point~n~~w~/robbery", 2000, 3);
        return 1;
    }
    if (pickupid == ROBPICKUP[1])
    {
        GameTextForPlayer(playerid, "~r~robbery start point~n~~w~/robbery", 2000, 3);
        return 1;
    }
    if (pickupid == ROBPICKUP2[0])
    {
        GameTextForPlayer(playerid, "~g~TO START STEALING MONEY~w~~n~TYPE /rob", 2000, 3);
        return 1;
    }
    if (pickupid == ROBPICKUP2[1])
    {
        GameTextForPlayer(playerid, "~g~TO START STEALING MONEY~w~~n~TYPE /rob", 2000, 3);
        return 1;
    }
    if (pickupid == ROBPICKUP2[2])
    {
        GameTextForPlayer(playerid, "~g~TO START STEALING MONEY~w~~n~TYPE /rob", 2000, 3);
        return 1;
    }
    if (pickupid == ElevatorPickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~enter", 2000, 3);
        return 1;
    }
    if (pickupid == ElevatorPickup[0])
    {
        GivePlayerWeapon(playerid, WEAPON_PARACHUTE, 1);
        SetPlayerPos(playerid, 1803.9323, -1300.1918, 131.7344);
        return 1;
    }
    if (pickupid == CarShopPickup[0])
    {
        GameTextForPlayer(playerid, "~b~INTENSE SHOWROOM ~n~~w~TYPE: ~r~/enter", 2000, 3);
        return 1;
    }
    if (pickupid == CarShopPickup[1])
    {
        GameTextForPlayer(playerid, "~w~TYPE: ~r~/EXIT", 2000, 3);
        return 1;
    }
    if (pickupid == CarShopPickup2[0])
    {
        GameTextForPlayer(playerid, "~b~INTENSE SHOWROOM ~n~~w~TYPE: ~r~/enter", 2000, 3);
        return 1;
    }
    if (pickupid == CarShopPickup2[1])
    {
        GameTextForPlayer(playerid, "~w~TYPE: ~r~/EXIT", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[0])
    {
        GameTextForPlayer(playerid, "~b~BAR~n~~w~/DRINK", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[1])
    {
        GameTextForPlayer(playerid, "~g~Ammu-nation~n~~w~/buy~n~/HEAL~r~ FOR ARMOUR ONLY $100", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[2])
    {
        GameTextForPlayer(playerid, "~b~DRIVING SCHOOL~n~~w~/DMV", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[3])
    {
        GameTextForPlayer(playerid, "~g~GENERAL STORE~n~~w~/BUY", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[4])
    {
        GameTextForPlayer(playerid, "~r~CLOTHES SHOP~n~~w~/buy", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[5])
    {
        GameTextForPlayer(playerid, "~y~BURGER SHOT~n~~w~/BUY", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[6])
    {
        return 1;
    }
    if (pickupid == BIZPICKUP[7])
    {
        GameTextForPlayer(playerid, "~r~CLOTHES SHOP~n~~w~/buy", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[8])
    {
        GameTextForPlayer(playerid, "~g~DISCO~n~~w~/DRINK", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[9])
    {
        GameTextForPlayer(playerid, "~p~SEX SHOP~n~~w~/BUY", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[10])
    {
        GameTextForPlayer(playerid, "~w~LEARN NEW WAYS TO ~g~FIGHT!~n~~n~~b~/train", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[16])
    {
        GameTextForPlayer(playerid, "~w~LEARN NEW WAYS TO ~g~FIGHT!~n~~n~~b~/train", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[17])
    {
        GameTextForPlayer(playerid, "~r~HOUSE ARMOUR~n~~b~10 PACKAGES~w~ - ~g~$20000~n~~w~/buyarmour", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[18])
    {
        GameTextForPlayer(playerid, "~r~DRUG STORE~n~~w~/buydrug", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[19])
    {
        GameTextForPlayer(playerid, "~b~BAR~n~~w~/DRINK", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[20])
    {
        GameTextForPlayer(playerid, "~b~DRUGS/GUNS/HEAL~n~~w~/BUYDRUG ~g~/BUY ~r~/HEAL", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[11])
    {
        GameTextForPlayer(playerid, "~g~STRIP CLUB~n~~w~/DRINK", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[12])
    {
        GameTextForPlayer(playerid, "~y~CLUCKIN' BELL~n~~w~/BUY", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[13])
    {
        GameTextForPlayer(playerid, "~r~Restaurant~n~~w~/BUY", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[14])
    {
        GameTextForPlayer(playerid, "~g~ADVERTISIMENT~n~~w~/ADVERT", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[15])
    {
        GameTextForPlayer(playerid, "~g~GENERAL STORE~n~~w~/BUY", 2000, 3);
        return 1;
    }
    if (pickupid == VILNAPICKUP)
    {
        GameTextForPlayer(playerid, "~y~village zone~n~~r~PRESS ~w~ENTER", 2000, 3);
        return 1;
    }
    for (new i2 = 0; i2 < 14; i2++)
    {
        if (pickupid == ATMPICKUP[i2])
        {
            GameTextForPlayer(playerid, "~w~USE ~g~/ATM", 2000, 3);
            return 1;
        }
    }
    return 1;
}