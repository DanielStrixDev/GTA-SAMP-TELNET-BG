/*
· SA-MP Gamemode: Intense версия: 1.5 RC2
· Copyright © 2018-2026, 
· Всички права са запазени.
*/
//main - location - open
#include <a_samp>
#include <streamer>
#include <Dini>
#include <sort>
#include <MD5>
#include <sscanf2>
#include <a_mysql>
#include <izcmd>

//#include <colandreas>
#pragma tabsize 0

new MySQL: Database;

#if !defined IsValidVehicle
native IsValidVehicle(vehicleid);
#endif
#define RELEASED(%0) \
(((newkeys & (%0)) != (%0)) && ((oldkeys & (%0)) == (%0)))

//==============================================================================
//          -- > Database
//==============================================================================
#define CONNECT_SQL_OPERATIONS true

#define SERVER_LOCAL 0
#define SERVER_HOST 1
#define CURRENT_SERVER SERVER_LOCAL

#if CURRENT_SERVER == SERVER_LOCAL
	#define DB_HOST "localhost"
	#define DB_USER "root"
	#define DB_NAME "intense"
	#define DB_PASSWORD ""
#endif

#if CURRENT_SERVER == SERVER_HOST
	#define DB_HOST "144.76.57.59"
	#define DB_USER "u2942922_sdQM1hFr42"
	#define DB_NAME "s2942922_db1743390669159"
	#define DB_PASSWORD "kpHMpPVefsL5BWWVAi@t3U^."
#endif

//==============================================================================
//          -- > /// Database ///
//==============================================================================

//==============================================================================
//          -- > Strings
//==============================================================================
new string256[256];
new string115[115];
new string175[175];
new string115n2[115];
new stringvehicle[501][115];
new string[256];
//==============================================================================
//          -- > /// Strings ///
//==============================================================================

//==============================================================================
//          -- > Gamemode Includes
//==============================================================================

// DEFINES
#include "server/colors.pwn"
#include "server/systems/factions/defines.pwn"
#include "server/defines.pwn"
#include "server/locations.pwn"

// VARS
#include "server/vars.pwn"
#include "server/systems/biz/vars.pwn"
#include "server/systems/minigames/vars.pwn"
#include "server/systems/dmon/vars.pwn"
#include "server/systems/duel/vars.pwn"
#include "server/systems/event/vars.pwn"
#include "server/systems/factions/vars.pwn"
#include "server/systems/house/vars.pwn"
#include "server/systems/missions/vars.pwn"
#include "server/systems/office/vars.pwn"
#include "server/systems/player/vars.pwn"
#include "server/systems/private_vehs/vars.pwn"
#include "server/systems/turfs/vars.pwn"
#include "server/systems/vehicles/vars.pwn"
#include "server/systems/vip/vars.pwn"
#include "server/systems/record/vars.pwn"

// FUNCTIONS
#include "server/forwards.pwn"
#include "server/connection.pwn"
#include "server/pickups.pwn"
#include "server/systems/minigames/functions.pwn"
#include "server/systems/vehicles/functions.pwn"
#include "server/systems/private_vehs/functions.pwn"
#include "server/systems/factions/functions.pwn"
#include "server/systems/office/functions.pwn"
#include "server/systems/robbery/functions.pwn"
#include "server/systems/player/functions.pwn"
#include "server/systems/turfs/functions.pwn"
#include "server/systems/house/functions.pwn"
#include "server/systems/biz/functions.pwn"
#include "server/systems/vip/functions.pwn"
#include "server/systems/record/functions.pwn"
#include "server/systems/fishing/functions.pwn"
#include "server/systems/missions/functions.pwn"
#include "server/systems/dmon/functions.pwn"
#include "server/systems/jobs/functions.pwn"
#include "server/functions.pwn"

// DATABASE
#include "server/systems/player/db.pwn"
#include "server/systems/office/db.pwn"
#include "server/systems/private_vehs/db.pwn"
#include "server/systems/vip/db.pwn"
#include "server/systems/turfs/db.pwn"
#include "server/systems/missions/db.pwn"
#include "server/systems/factions/db.pwn"
#include "server/systems/biz/db.pwn"
#include "server/systems/record/db.pwn"
#include "server/systems/house/db.pwn"

// COMMANDS
#include "server/systems/biz/commands.pwn"
#include "server/systems/house/commands.pwn"
#include "server/systems/vip/commands.pwn"
#include "server/systems/jobs/commands.pwn"
#include "server/systems/robbery/commands.pwn"
#include "server/systems/player/commands.pwn"
#include "server/systems/missions/commands.pwn"
#include "server/systems/admin/commands.pwn"
#include "server/systems/factions/commands.pwn"
#include "server/systems/turfs/commands.pwn"
#include "server/systems/duel/commands.pwn"
#include "server/systems/lottery/commands.pwn"
#include "server/systems/general/commands.pwn"
#include "server/systems/fuel_company/commands.pwn"
#include "server/systems/dmon/commands.pwn"
#include "server/systems/top/commands.pwn"
#include "server/systems/office/commands.pwn"
#include "server/systems/fishing/commands.pwn"
#include "server/systems/cb_chat/commands.pwn"
#include "server/systems/dmv/commands.pwn"
#include "server/systems/drugs/commands.pwn"
#include "server/systems/hitman/commands.pwn"
#include "server/systems/event/commands.pwn"
#include "server/systems/private_vehs/commands.pwn"
#include "server/systems/minigames/commands.pwn"

// IMPORTANT
#include "server/general_timers.pwn"
#include "server/db.pwn"
#include "server/objects.pwn"
#include "server/dialogs.pwn"
#include "server/keys.pwn"

//==============================================================================
//          -- > /// Gamemode Includes ///
//==============================================================================


main()
{
    printf("Сървърът беше пуснат успешно.");
    printf("[- GTAINT -][O-F-F-I-C-I-A-L][0.3.7] · версия: 1.5 RC2\n\n");
    printf("·Copyright (C) 2018-2026, Daniel Miroslavov Andreev");
    printf("·Всички права са запазени.\n\n");
}

public OnGameModeInit()
{
    //main - location 3 - open
    printf("Ако конзолата не се пусне до 15 секунди, натиснете ENTER.");
    printf("Ако сървърът не дава да се влиза в него до 2 минути след пускането му, натиснете ENTER.");
    SetGameModeText("INTENSE 1.5 RC2");
    SendRconCommand("hostname [- GTAINT -][O-F-F-I-C-I-A-L][0.3.7]");
    SendRconCommand("rcon_password 123123");
    //SendRconCommand("loadfs ls_elevator");
    SendRconCommand("weburl none");
    SendRconCommand("mapname Las Venturas");
    SendRconCommand("language Bulgarian");
    SendRconCommand("reloadbans");
    SendRconCommand("lanmode 0");
    MySQLConnect();
    SQLConnect_Operations();
    SetTimer("GeneralTimer1s", 1000, 1);
    SetTimer("GeneralTimer500ms", 500, 1);
    DisableInteriorEnterExits();
    EnableStuntBonusForAll(0);
    DefineGangRankSkins();
    LoadRecords();
    GetDateAndHours();
    LoadTurfs();
    LoadPrivateVehicles();
    if (month == 12)
    {
        AddXmasObjects();
    }
    LoadOfficeCenter();
    LoadStreetRaces();
    LoadFactions();
    LoadHouses();
    LoadBizz();
    LoadFreeVIP();

    for (new i = 0; i < 25; i++)
    {
        fuelStationsFuel[i] = 5000;
    }
    for (new aveh = 0; aveh < MAX_VEHICLES; aveh++)
    {
        VehicleInfo[aveh][vAdminVehSpawnedBy] = -1;
        vehfuel[aveh] = 100;
    }
    //main - location 3 - close
    //texts - location 2 - open
    RESTART = TextDrawCreate(400.000000, 328.000000, " ");
    TextDrawBackgroundColor(RESTART, 250);
    TextDrawFont(RESTART, 1);
    TextDrawLetterSize(RESTART, 0.2700, 1.5500);
    TextDrawColor(RESTART, -1);
    TextDrawSetOutline(RESTART, 1);
    TextDrawSetProportional(RESTART, 1);

    ClockDate = TextDrawCreate(5.000000, 421.000000, "");
    TextDrawBackgroundColor(ClockDate, 250);
    TextDrawFont(ClockDate, 1);
    TextDrawLetterSize(ClockDate, 0.3, 1.8000);
    TextDrawColor(ClockDate, -1);
    TextDrawSetOutline(ClockDate, 1);
    TextDrawSetProportional(ClockDate, 1);

    DMONKillText = TextDrawCreate(528.000000, 328.000000, "~g~ + 1 Kill~n~+ 25 Armour");
    TextDrawAlignment(DMONKillText, 0);
    TextDrawBackgroundColor(DMONKillText, 0x000000ff);
    TextDrawFont(DMONKillText, 1);
    TextDrawLetterSize(DMONKillText, 0.2800, 1.8000);
    TextDrawSetProportional(DMONKillText, 1);
    TextDrawSetShadow(DMONKillText, 1);

    intensetext = TextDrawCreate(547.0, 24.0, "~w~in~g~te~r~nse");
    TextDrawBackgroundColor(intensetext, 250);
    TextDrawFont(intensetext, 1);
    TextDrawLetterSize(intensetext, 0.5, 2);
    TextDrawColor(intensetext, -1);
    TextDrawSetOutline(intensetext, 1);
    TextDrawSetProportional(intensetext, 1);

    Intro[0] = TextDrawCreate(642.0, 1.0, "~n~");
    TextDrawLetterSize(Intro[0], 0.5, 49.5);
    TextDrawUseBox(Intro[0], 1);
    TextDrawBoxColor(Intro[0], 0x000000FF);
    TextDrawTextSize(Intro[0], -2.0, 0.0);

    if (month == 1 && day < 10)
    {
        new stringYear[256];
        format(stringYear, 256, "~w~~h~HAPPY ~g~NEW ~r~YEAR ~y~%d", year);
        Intro[1] = TextDrawCreate(190.000000, 190.000000, stringYear);
        TextDrawFont(Intro[1], 2);
        TextDrawLetterSize(Intro[1], 0.570000, 1.799999);
    }
    else
    {
        Intro[1] = TextDrawCreate(190.000000, 190.000000, "~w~~h~INTENSE ~g~team");
        TextDrawFont(Intro[1], 2);
        TextDrawLetterSize(Intro[1], 0.570000, 1.799999);
        Intro[2] = TextDrawCreate(310.000000, 190.000000, "        ~r~presents...");
        TextDrawFont(Intro[2], 2);
        TextDrawColor(Intro[2], 0xFFFFFFFF);
        TextDrawLetterSize(Intro[2], 0.570000, 1.799999);
    }
    Intro[3] = TextDrawCreate(190.0, 202.0, ".");
    TextDrawFont(Intro[3], 1);
    TextDrawLetterSize(Intro[3], 23.250051, 1.099999);
    Intro[4] = TextDrawCreate(304.00, 223.0, "~w~Bulgarian ~g~intense ~r~s-e-r-v-e-r");
    TextDrawFont(Intro[4], 2);
    TextDrawLetterSize(Intro[4], 0.340000, 1.099999);
    Intro[5] = TextDrawCreate(331.0, 235.0, "~w~official ~g~site ~r~soon");
    TextDrawFont(Intro[5], 2);
    TextDrawLetterSize(Intro[5], 0.340000, 1.099999);
    //texts - location 2 - close
    //classes - location - open
    AddPlayerClass(28, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(29, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(30, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(143, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(144, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(145, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(146, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(101, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(98, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(60, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(59, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(55, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(56, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(17, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(141, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(237, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(244, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(246, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(93, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(91, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    AddPlayerClass(90, 1481.2080, -1770.6204, 18.7958, 359.4039, -1, -1, -1, -1, -1, -1);
    //classes - location - close
    //3dtextlabels - location - open
    CreateDynamic3DTextLabel("Такса за вход $50\n{FFFF00}/enter", 0x3FBF03AA, 478.2492, -19.3125, 1000.6797, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 5.0);
    Create3DTextLabel("{FF0000}За да влезеш в бизнеса {FFFFFF}24/7{FF0000} отиди до синята къщичка и напиши {FFFFFF}/enter\n{FF0000}За да излезеш от бизнеса напиши {FFFFFF}/exit{FF0000} до вратата.\n{FF0000}Като влезеш в бизнеса отиди до жълтия удивителен и напиши {FFFFFF}/buy{FF0000} за да видиш какво можеш да си купиш.", 0x08FF08FF, 2181.8801, 1991.3766, 10.8203, 20, 0);
    Create3DTextLabel("{FF0000}За да влезеш в{FFFFFF} бизнеса за шофьорски книжки{FF0000} отиди до синята къщичка и напиши {FFFFFF}/enter\n{FF0000}За да излезеш от бизнеса напиши {FFFFFF}/exit {FF0000}до вратата\nКато влезеш в бизнеса отиди до монитора с въртяща се книжка и \nнапиши {FFFFFF}/dmv{FF0000} за да видиш каква шофьорска книжка може да си вземеш.", 0x08FF08FF, 1933.1718, 2184.6824, 10.8125, 20, 0);
    Create3DTextLabel("{0040FF}Само за Intense Police Department\n{00FF00}Натисни {FF0000}SCROLL{00FF00} за да отвориш портата, ако си пеша.\nНатисни {FF0000}2 (над W){00FF00} за да отвориш портата, ако си с превозно средство. ", 0x08FF08FF, 2336.8582, 2443.3186, 6.1081, 20, 0);
    Create3DTextLabel("{0040FF}Само за Intense Police Department\n{00FF00}Натисни {FF0000}SCROLL{00FF00} за да отвориш бариерата, ако си пеша.\nНатисни {FF0000}2 (над W){00FF00} за да отвориш бариерата, ако си с превозно средство. ", 0x08FF08FF, 2237.7688, 2453.5955, 10.7848, 20, 0);
    Create3DTextLabel("{FF0000}VIP's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", 0xFFFFFFFF, 1230.4954, -2005.5513, 60.8984, 10, 0);
    Create3DTextLabel("San Fierro Triads's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", COLOR_RTRIADS, 1969.2216, 953.4484, 10.8203, 10, 0);
    Create3DTextLabel("Italian Mafia's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", COLOR_RITALIAN, -691.5956, 935.6432, 13.6328, 10, 0);
    Create3DTextLabel("{0040FF}IPD's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", 0xFFFFFFFF, 252.5214, 70.3983, 1003.6406, 10, 1); //ipd gun
    Create3DTextLabel("{33AA33}Grove's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", 0xFFFFFFFF, 2497.0251, -1703.2537, 1014.7422, 10, 1);
    Create3DTextLabel("{276BA9}Syndicate Texas's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", 0xFFFFFFFF, 2497.0251, -1703.2537, 1014.7422, 10, 2);
    Create3DTextLabel("{0080FF}Rifa's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", 0xFFFFFFFF, 2449.6282, -1696.3843, 1013.5078, 10, 1);
    Create3DTextLabel("{FF40FF}Bulgarian Mafia's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", 0xFFFFFFFF, 1267.0983, -784.8137, 1091.9063, 10, 1);
    Create3DTextLabel("Mara Salvatrucha 13's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", COLOR_RMS13, -38.7398, 1078.9197, 20.2060, 10, 0);
    Create3DTextLabel("{33AA33}Grove Street Families\n{FF4000}Натисни {FFFF00}ENTER{FF4000} за да влезеш", 0xFFFFFFFF, 2495.3496, -1690.8401, 14.7656, 10, 0, 0);
    Create3DTextLabel("{33AA33}Grove Street Families\n{FF4000}Натисни {FFFF00}ENTER{FF4000} за да излезеш", 0xFFFFFFFF, 2496.0054, -1692.1809, 1014.7422, 10, 1, 0); //2496.049804,-1695.238159,1014.742187
    Create3DTextLabel("{FF0000}Напиши {FFFFFF}/plate{FF0000} за да смениш номера на твоята кола", 0xFFFFFFFF, 1838.5139, -1856.2627, 13.3828, 10, 0);
    Create3DTextLabel("{FF0000}Напиши {FFFFFF}/plate{FF0000} за да смениш номера на твоята кола", 0xFFFFFFFF, -1786.8502, 1205.3788, 25.1250, 10, 0);
    Create3DTextLabel("{FF0000}Напиши {FFFFFF}/plate{FF0000} за да смениш номера на твоята кола", 0xFFFFFFFF, 2005.9323, 2298.5537, 10.8203, 10, 0);
    Create3DTextLabel("{FF0000}За да влезете в бизнеса напишете {FFFFFF}/enter", 0xFFFFFFFF, 1942.1660, 2184.6045, 10.8203, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да влезете в бизнеса напишете {FFFFFF}/enter\n{FF0000}Когато искате да излезете от него напишете {FFFFFF}/exit ", 0xFFFFFFFF, 1122.7079, -2037.0201, 69.8942, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 1203.2736, -2011.3766, 85.1735, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 1706.1938, 1448.5729, 10.8181, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 1240.1112, -2038.7124, 61.8419, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 1125.4641, -2029.7620, 75.8093, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 1510.7715, -1607.2186, 15.3986, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 1176.9319, -2037.2865, 69.1413, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 1152.7411, 1342.2012, 10.8203, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да видите правилата на сървъра използвайте командата {FFFFFF}/rules ", 0xFFFFFFFF, 1125.4333, -2044.1055, 75.8093, 20, 0, 0);
    //Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ",0xFFFFFFFF,1538.7894,-1690.8087,13.5469,20,0,0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 1480.1886, -1639.7046, 14.1484, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 2115.0881, 962.9519, 15.7348, 20, 0, 0);
    Create3DTextLabel("{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 1347.9866, -1742.0200, 13.3906, 20, 0, 0);
    Create3DTextLabel("{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 1174.8677, -2037.0220, 77.3178, 20, 0, 0);
    Create3DTextLabel("{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 1246.3448, -2052.0242, 64.5867, 20, 0, 0);
    Create3DTextLabel("{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 2097.7795, 963.0507, 15.7348, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да влезете в бизнеса напишете {FFFFFF}/enter ", 0xFFFFFFFF, 2194.6130, 1990.9689, 12.2969, 15, 0, 0);
    //Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ",0xFFFFFFFF,1481.1449,-1739.6332,13.5469,20,0,0);
    Create3DTextLabel("{FF0000}За да си тунинговате колата влезте вътре и пишете {FFFFFF}/tune ", 0xFFFFFFFF, 1249.7540, -2058.7312, 59.7104, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да си тунинговате колата влезте вътре и пишете {FFFFFF}/tune ", 0xFFFFFFFF, 1248.7421, -2051.7422, 59.7570, 20, 0, 0);
    Create3DTextLabel("{FF0000}{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 1262.4489, -2026.9534, 59.3499, 20, 0, 0);
    Create3DTextLabel("{FF0000}{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 1262.4489, -2026.9534, 59.3499, 20, 0, 0);
    Create3DTextLabel("{FF0000}{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 1538.1416, -1674.9762, 13.5469, 20, 0, 0);
    Create3DTextLabel("{FF0000}{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 2397.0432, 1019.7305, 10.8203, 20, 0, 0);
    Create3DTextLabel("{FF0000}{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 2005.7382, 1545.0450, 13.5198, 20, 0, 0);
    Create3DTextLabel("{C600C6}Натисни {FFFFFF}ENTER{C600C6} за да преминеш в другия {FFFFFF}Virtual World", 0xFFFFFFFF, -1392.2205, 2111.2021, 42.1264, 20, 0, 0);
    Create3DTextLabel("{C600C6}Натисни {FFFFFF}ENTER{C600C6} за да преминеш в другия {FFFFFF}Virtual World", 0xFFFFFFFF, -1392.2205, 2111.2021, 42.1264, 20, 1, 0);
    Create3DTextLabel("{FF0000}Ако искате да се телепортирате можете да използвате някой от тези телепорти:\n{FFFFFF}/dm /dm2 /ls /lv ", 0xFFFFFFFF, 1240.0763, -2036.8870, 59.9441, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да се качите в колата като шофьор използвайте {FFFFFF}F {FF0000}или {FFFFFF}ENTER\n{FF0000}За да се качите като пътник натиснете {FFFFFF}G\n{FF0000}За да се покажете през прозореца натиснете {FFFFFF}CAPS LOCK{FF0000} или {FFFFFF}H", 0xFFFFFFFF, 1240.4271, -2007.6287, 59.9621, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да се качите в колата като шофьор използвайте {FFFFFF}F {FF0000}или {FFFFFF}ENTER\n{FF0000}За да се качите като пътник натиснете {FFFFFF}G\n{FF0000}За да се покажете през прозореца натиснете {FFFFFF}CAPS LOCK{FF0000} или {FFFFFF}H", 0xFFFFFFFF, 1240.7898, -2049.2617, 59.9841, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да се качите в колата като шофьор използвайте {FFFFFF}F {FF0000}или {FFFFFF}ENTER\n{FF0000}За да се качите като пътник натиснете {FFFFFF}G\n{FF0000}За да се покажете през прозореца натиснете {FFFFFF}CAPS LOCK{FF0000} или {FFFFFF}H", 0xFFFFFFFF, 1279.9983, -2045.3997, 59.1966, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да се качите в колата като шофьор използвайте {FFFFFF}F {FF0000}или {FFFFFF}ENTER\n{FF0000}За да се качите като пътник натиснете {FFFFFF}G\n{FF0000}За да се покажете през прозореца натиснете {FFFFFF}CAPS LOCK{FF0000} или {FFFFFF}H", 0xFFFFFFFF, 1278.9470, -2007.0658, 59.0642, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да пишете в сървъра натиснете {FFFFFF}T {FF0000}или {FFFFFF}~\n{FF0000}За да видите всички команди напишете {FFFFFF}/help", 0xFFFFFFFF, 1203.2736, -2011.3766, 85.1735, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да пишете в сървъра натиснете {FFFFFF}T {FF0000}или {FFFFFF}~\n{FF0000}За да видите всички команди напишете {FFFFFF}/help", 0xFFFFFFFF, 1183.0652, -2011.4884, 85.1735, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да пишете в сървъра натиснете {FFFFFF}T {FF0000}или {FFFFFF}~\n{FF0000}За да видите всички команди напишете {FFFFFF}/help", 0xFFFFFFFF, 1183.2747, -2062.8635, 85.1735, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да пишете в сървъра натиснете {FFFFFF}T {FF0000}или {FFFFFF}~\n{FF0000}За да видите всички команди напишете {FFFFFF}/help", 0xFFFFFFFF, 1204.5096, -2063.1487, 84.7134, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да пишете в сървъра натиснете {FFFFFF}T {FF0000}или {FFFFFF}~\n{FF0000}За да видите всички команди напишете {FFFFFF}/help", 0xFFFFFFFF, 1243.5411, -2044.7922, 75.9834, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да пишете в сървъра натиснете {FFFFFF}T {FF0000}или {FFFFFF}~\n{FF0000}За да видите всички команди напишете {FFFFFF}/help", 0xFFFFFFFF, 1241.7443, -2007.1014, 76.0035, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да пишете в сървъра натиснете {FFFFFF}T {FF0000}или {FFFFFF}~\n{FF0000}За да видите всички команди напишете {FFFFFF}/help", 0xFFFFFFFF, 1280.7434, -2006.4984, 74.9713, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да пишете в сървъра натиснете {FFFFFF}T {FF0000}или {FFFFFF}~\n{FF0000}За да видите всички команди напишете {FFFFFF}/help", 0xFFFFFFFF, 1280.3582, -2041.9338, 75.0235, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да започнеш {FFFFFF}Boat Job {FF0000}влез в някоя от лодките и напиши {FFFFFF}/boat", -1, 2127.8530, -87.0102, 2.1304, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}За да започнеш {FFFFFF}Coalmine Job {FF0000}влез в някой от самосвалите и напиши {FFFFFF}/coalmine", -1, 852.7022, 851.3765, 13.3516, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}За да започнеш {FFFFFF}Pilot Job {FF0000}влез в някой от самолетите и напиши {FFFFFF}/pilot", -1, 402.0841, 2529.5537, 16.5748, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}За да започнеш {FFFFFF}Truck Job {FF0000}влез в някой от камионите и напиши {FFFFFF}/truck", -1, 76.4991, -258.7651, 1.5781, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}За да започнеш {FFFFFF}Bus Job {FF0000}влез в някой от автобусите и напиши {FFFFFF}/bus", -1, -543.4083, 2592.2168, 53.5156, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}За да започнеш {FFFFFF}Pizzaboy Job {FF0000}влез в някой от моторите и напиши {FFFFFF}/pizza", -1, 1363.4863, 249.8157, 19.5669, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}За да започнеш {FFFFFF}Deliver Job {FF0000}влез в някой от камионите и напиши {FFFFFF}/deliver", -1, -15.7992, -316.2803, 5.4229, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}За да вдигате левел трябва да събирате {FFFFFF}EP.\n {FF0000}На всеки кръгъл час има Payday и получавате {FFFFFF}1 EP\n{FF0000}EP можете да събирате от мисиите Moneybox, Streetrace, Deathmatch.\nОт {FFFFFF}/stats{FF0000} може да видите колко EP имате.\nЗа да вдигнете вашия левел напишете {FFFFFF}/buylevel\n{FF0000}За повече информация моля посетете нашия форум!", 0xFFFFFFFF, 1210.2579, -2036.9921, 69.0078, 20, 0, 0);
    Create3DTextLabel("{FFFFFF}Използвай {008000}/tow\n{FF0000}за да закачите кола", -1, 1015.7611, -1025.3098, 32.1016, 20.0, 0, 0);
    Create3DTextLabel("{FFFFFF}Използвай {008000}/tow\n{FF0000}за да закачите кола", -1, 1652.8636, 2200.3342, 12.1981, 20.0, 0, 0);
    Create3DTextLabel("{FFFFFF}Механик\n{FF4000}Напиши {FFFF00}/mduty{FF4000} за да си смениш скина\nИзползвай {FFFF00}/mdutyoff{FF4000} за да го премахнеш", -1, 1015.9524, -1026.5002, 32.1016, 20.0, 0, 0);
    Create3DTextLabel("{FFFFFF}Механик\n{FF4000}Напиши {FFFF00}/mduty{FF4000} за да си смениш скина\nИзползвай {FFFF00}/mdutyoff{FF4000} за да го премахнеш", -1, 1652.8765, 2199.9587, 10.8203, 20.0, 0, 0);
    Create3DTextLabel("{FF0000}Зареди цистерната\n{FFFF00}/refillpt", -1, 264.4190, 1455.0266, 10.5859, 30.0, 0, 0);

    //vip teleports - open
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}Boat Job\n{FF0000}Трябва да си {FFFFFF}8 левел{FF0000} за да работиш тази работа!", -1, 1237.1945, -2004.9026, 59.8630, 40.0, 0, 1);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}мястото за ловене на риба", -1, 1247.4926, -2047.3232, 59.9830, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}Coalmine Job", -1, 1226.9058, -2004.3683, 62.9966, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}бизнеса 24/7", -1, 1213.1379, -2004.4064, 68.9335, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}бизнеса за шофьорски книжки", -1, 1213.1505, -2068.9939, 68.9775, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш във {FFFFFF}VIP базата", -1, -1334.0717, 2061.0530, 52.7941, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш във {FFFFFF}VIP базата", -1, 849.7452, 849.4290, 13.2172, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}Sweeper Job", -1, 1221.8916, -2004.3669, 65.1029, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш във {FFFFFF}VIP базата", -1, 592.5229, 1232.9878, 11.7188, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}Pilot Job", -1, 1216.6649, -2004.4821, 65.1027, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш във {FFFFFF}VIP базата", -1, 396.6920, 2529.6890, 16.5576, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}Truck Job", -1, 1237.1299, -2068.8193, 59.8614, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш във {FFFFFF}VIP базата", -1, 76.3090, -263.6589, 1.5781, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}Bus Job", -1, 1226.6023, -2069.1226, 62.9998, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш във {FFFFFF}VIP базата", -1, -542.4196, 2586.2869, 53.5156, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}Pizzaboy Job", -1, 1232.2550, -2068.9458, 60.8984, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш във {FFFFFF}VIP базата", -1, 1363.7058, 253.9488, 19.5669, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}Deliver Job", -1, 1216.4745, -2069.0505, 65.1019, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш във {FFFFFF}VIP базата", -1, -15.7632, -319.8665, 5.4229, 40.0, 0, 0);
    //vip teleports - close

    //fish - open
    Create3DTextLabel("{C600C6}Натисни {FFFFFF}ENTER{C600C6} за да преминеш в другия {FFFFFF}Virtual World", 0xFFFFFFFF, -1392.2205, 2111.2021, 42.1264, 20, 0, 0);
    Create3DTextLabel("{C600C6}Натисни {FFFFFF}ENTER{C600C6} за да преминеш в другия {FFFFFF}Virtual World", 0xFFFFFFFF, -1392.2205, 2111.2021, 42.1264, 20, 1, 0);
    Create3DTextLabel("{C600C6}Напиши {FFFFFF}/buy{C600C6} за да купиш въдица или стръв\n{C600C6}Напиши {FFFFFF}/sellfish{C600C6} за да продадеш рибата\n\nЕдин килограм риба - {00BF00}$10", 0xFFFFFFFF, -1354.0990, 2057.6885, 53.1172, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да почнеш да ловиш риба трябва да си купиш въдица и стръв от бизнеса срещу теб.\nПосле трябва да си до кея или в лодка за да ловиш риба.\nЗа да метнеш въдицата напиши {FFFFFF}/fish{FF0000},а за да видиш твоите риби напиши {FFFFFF}/fish\n{FF0000}За да изхвърлиш риба напиши {FFFFFF}/putback{FF0000}, а за да изхвърлиш всички риби напиши {FFFFFF}/putallback", 0xFFFFFFFF, -1334.7002, 2057.7271, 52.9066, 20, 0, 0);
    //fish - close

    //gas stations texts - location - open
    fuelStationText[0] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 1004.0327, -937.5370, 42.3281, 40, 0, 0);
    fuelStationText[1] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 1942.3719, -1772.8666, 13.6406, 40, 0, 0);
    fuelStationText[2] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, -1606.7223, -2713.3562, 48.5335, 40, 0, 0);
    fuelStationText[3] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, -2026.7813, 156.5509, 29.0391, 40, 0, 0);
    fuelStationText[4] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, -2243.8149, -2559.8899, 31.9219, 40, 0, 0);
    fuelStationText[5] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, -1676.2601, 413.5443, 7.1797, 40, 0, 0);
    fuelStationText[6] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 2201.8296, 2475.1350, 10.8203, 40, 0, 0);
    fuelStationText[7] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 615.3391, 1690.0454, 6.9922, 40, 0, 0);
    fuelStationText[8] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, -1328.2731, 2677.5278, 50.0625, 40, 0, 0);
    fuelStationText[9] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 70.3842, 1219.0177, 18.8116, 40, 0, 0);
    fuelStationText[10] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 2113.3835, 919.5655, 10.8203, 40, 0, 0);
    fuelStationText[11] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 2641.0115, 1106.6252, 10.8203, 40, 0, 0);
    fuelStationText[12] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 2146.7964, 2747.8115, 10.8203, 40, 0, 0);
    fuelStationText[13] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 1595.7935, 2199.5996, 10.8203, 40, 0, 0);
    fuelStationText[14] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, -1471.1836, 1863.7598, 32.6328, 40, 0, 0);
    fuelStationText[15] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 655.7673, -565.0798, 16.3359, 40, 0, 0);
    fuelStationText[16] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 1381.8230, 459.1453, 20.3452, 40, 0, 0);
    //gas stations texts - location - close
    Create3DTextLabel("{FF0000}Cell 2\n{FFFFFF}ENTER", 0x08FF08FF, 266.2491, 84.4284, 1001.7091, 6, 1);
    Create3DTextLabel("{FF0000}Cell 1\n{FFFFFF}ENTER", 0x08FF08FF, 266.2492, 88.6102, 1001.7091, 6, 1);
    //3dtextlabels - location - close
    //IFC cars - location - open
    AddStaticVehicle(411, 253.5484, 1421.1823, 10.2937, 270.3137, 1, 1); // 1
    AddStaticVehicle(411, 252.2402, 1395.5558, 10.3130, 270.6192, 0, 0); // 2
    AddStaticVehicle(411, 251.1108, 1371.1488, 10.3136, 267.5901, 79, 79); // infernussin
    //IFC cars - location - close
    //порти - location - close
    mechanicDutyVehs[0] = AddStaticVehicle(525, 1013.5110, -1008.8167, 31.9396, 182.8166, 2, 2); // tow1
    mechanicDutyVehs[1] = AddStaticVehicle(525, 1013.4527, -1016.3772, 31.9344, 179.2090, 3, 3); // tow2
    mechanicDutyVehs[2] = AddStaticVehicle(525, 1013.4238, -1024.0668, 31.9341, 179.0988, 86, 86); // tow3
    mechanicDutyVehs[3] = AddStaticVehicle(525, 1649.4435, 2195.0776, 10.6423, 179.4986, 2, 2); // car1
    mechanicDutyVehs[4] = AddStaticVehicle(525, 1643.7000, 2194.9663, 10.6532, 179.4869, 3, 3); // car2
    mechanicDutyVehs[5] = AddStaticVehicle(525, 1638.0636, 2194.9373, 10.6503, 179.9552, 5, 5); // car3
    mechanicDutyVehs[6] = AddStaticVehicle(525, 1632.8521, 2194.8706, 10.6565, 186.1603, 6, 6); // car4
    mechanicDutyVehs[7] = AddStaticVehicle(525, 1626.6609, 2194.7981, 10.6556, 178.8269, 86, 86); // car5
    //carshop - location - open
    carshopcars2[0] = AddStaticVehicle(411, -1420.4337, 1100.1154, 1039.9402, 104.6863, 201, 201);
    carshopobjects[0] = CreateObject(18646, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars2[0], -0.43060, -0.07840, 0.75010, 0.00000, 0.00000, 0.00000);
    LinkVehicleToInterior(carshopcars2[0], 15);
    carshopcars2[1] = AddStaticVehicle(560, -1412.7379, 1101.3435, 1039.9102, 95.3560, 198, 198);
    carshopobjects[0] = CreateObject(359, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[1] = CreateObject(362, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[2] = CreateObject(362, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars2[1], -0.04339, -0.14813, 0.80910, 0.00000, 0.00000, 89.00000);
    AttachObjectToVehicle(carshopobjects[1], carshopcars2[1], -0.69998, 0.24154, 0.69210, 87.00000, 32.00000, 93.00000);
    AttachObjectToVehicle(carshopobjects[2], carshopcars2[1], 0.77690, 0.33100, 0.69210, -91.00000, 32.00000, 93.00000);
    LinkVehicleToInterior(carshopcars2[1], 15);
    carshopcars2[2] = AddStaticVehicle(470, -1403.6010, 1102.5607, 1040.1947, 95.9597, 0, 0);
    carshopobjects[0] = CreateObject(3267, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars2[2], -0.05540, -0.84780, 0.59140, 0.00000, 0.00000, 0.00000);
    LinkVehicleToInterior(carshopcars2[2], 15);
    carshopcars2[3] = AddStaticVehicle(578, -1390.5123, 1102.8654, 1040.8193, 82.5598, 160, 0);
    carshopobjects[0] = CreateObject(2669, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars2[3], 0.00780, -0.31770, 0.94820, 0.00000, 0.00000, 0.00000);
    LinkVehicleToInterior(carshopcars2[3], 15);
    carshopcars2[4] = AddStaticVehicle(451, -1378.7549, 1100.9178, 1039.8777, 80.6452, 3, 3);
    LinkVehicleToInterior(carshopcars2[4], 15);
    carshopcars2[5] = AddStaticVehicle(409, -1365.6467, 1097.3064, 1039.9639, 69.2179, 0, 0);
    carshopobjects[0] = CreateObject(19314, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars2[5], 0.00160, 3.57950, 0.21160, 120.00000, 90.00000, 0.00000);
    LinkVehicleToInterior(carshopcars2[5], 15);
    carshopcars2[6] = AddStaticVehicle(411, -1440.3612, 1092.9755, 1039.9569, 117.9431, 0, 0);
    LinkVehicleToInterior(carshopcars2[6], 15);
    carshopobjects[0] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[1] = CreateObject(1161, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[2] = CreateObject(1161, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[3] = CreateObject(1059, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[4] = CreateObject(1146, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[5] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[6] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[7] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[8] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[9] = CreateObject(1027, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[10] = CreateObject(1027, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars2[6], -0.300000, 0.000000, 0.675000, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[1], carshopcars2[6], 1.049999, 2.174999, -0.599999, 0.000005, 180.899887, 180.899963);
    AttachObjectToVehicle(carshopobjects[2], carshopcars2[6], -1.049999, -1.950001, -0.599999, 0.000005, 180.899887, 361.799743);
    AttachObjectToVehicle(carshopobjects[3], carshopcars2[6], 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[4], carshopcars2[6], -0.074999, -2.325000, 0.375000, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[5], carshopcars2[6], 0.225000, 0.000000, 0.674999, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[6], carshopcars2[6], 0.000000, 1.800000, 0.149999, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[7], carshopcars2[6], 0.000000, 1.650000, 0.150000, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[8], carshopcars2[6], 0.000000, 1.950000, 0.150000, -10.800001, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[9], carshopcars2[6], -1.049999, -0.824999, -0.599999, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[10], carshopcars2[6], 0.974999, -0.824999, -0.599999, 0.000000, 0.000000, 0.000000);
    carshopcars2[7] = AddStaticVehicle(415, -1428.3811, 1098.0699, 1039.9996, 103.7194, 74, 74);
    carshopobjects[0] = CreateObject(18646, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopcars2[7], carshopobjects[0], 0.30450, 0.46970, 0.26350, 0.00000, 0.00000, 0.00000);
    LinkVehicleToInterior(carshopcars2[7], 15);
    AttachObjectToVehicle(carshopcars2[8], carshopobjects[0], 0.00160, 3.57950, 0.21160, 120.00000, 90.00000, 0.00000);
    LinkVehicleToInterior(carshopcars2[8], 15);
    SetVehicleVirtualWorld(carshopcars2[0], 1);
    SetVehicleVirtualWorld(carshopcars2[1], 1);
    SetVehicleVirtualWorld(carshopcars2[2], 1);
    SetVehicleVirtualWorld(carshopcars2[3], 1);
    SetVehicleVirtualWorld(carshopcars2[4], 1);
    SetVehicleVirtualWorld(carshopcars2[5], 1);
    SetVehicleVirtualWorld(carshopcars2[6], 1);
    SetVehicleVirtualWorld(carshopcars2[7], 1);
    SetVehicleVirtualWorld(carshopcars2[8], 1);
    carshopcars[0] = AddStaticVehicle(411, -1420.4337, 1100.1154, 1039.9402, 104.6863, 201, 201);
    carshopobjects[0] = CreateObject(18646, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars[0], -0.43060, -0.07840, 0.75010, 0.00000, 0.00000, 0.00000);
    LinkVehicleToInterior(carshopcars[0], 15);
    carshopcars[1] = AddStaticVehicle(560, -1412.7379, 1101.3435, 1039.9102, 95.3560, 198, 198);
    carshopobjects[0] = CreateObject(359, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[1] = CreateObject(362, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[2] = CreateObject(362, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars[1], -0.04339, -0.14813, 0.80910, 0.00000, 0.00000, 89.00000);
    AttachObjectToVehicle(carshopobjects[1], carshopcars[1], -0.69998, 0.24154, 0.69210, 87.00000, 32.00000, 93.00000);
    AttachObjectToVehicle(carshopobjects[2], carshopcars[1], 0.77690, 0.33100, 0.69210, -91.00000, 32.00000, 93.00000);
    LinkVehicleToInterior(carshopcars[1], 15);
    carshopcars[2] = AddStaticVehicle(470, -1403.6010, 1102.5607, 1040.1947, 95.9597, 0, 0);
    carshopobjects[0] = CreateObject(3267, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars[2], -0.05540, -0.84780, 0.59140, 0.00000, 0.00000, 0.00000);
    LinkVehicleToInterior(carshopcars[2], 15);
    carshopcars[3] = AddStaticVehicle(578, -1390.5123, 1102.8654, 1040.8193, 82.5598, 160, 0);
    carshopobjects[0] = CreateObject(2669, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars[3], 0.00780, -0.31770, 0.94820, 0.00000, 0.00000, 0.00000);
    LinkVehicleToInterior(carshopcars[3], 15);
    carshopcars[4] = AddStaticVehicle(451, -1378.7549, 1100.9178, 1039.8777, 80.6452, 3, 3);
    LinkVehicleToInterior(carshopcars[4], 15);
    carshopcars[5] = AddStaticVehicle(409, -1365.6467, 1097.3064, 1039.9639, 69.2179, 0, 0);
    carshopobjects[0] = CreateObject(19314, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars[5], 0.00160, 3.57950, 0.21160, 120.00000, 90.00000, 0.00000);
    LinkVehicleToInterior(carshopcars[5], 15);
    carshopcars[6] = AddStaticVehicle(411, -1440.3612, 1092.9755, 1039.9569, 117.9431, 0, 0);
    LinkVehicleToInterior(carshopcars[6], 15);
    carshopobjects[0] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[1] = CreateObject(1161, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[2] = CreateObject(1161, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[3] = CreateObject(1059, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[4] = CreateObject(1146, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[5] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[6] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[7] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[8] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[9] = CreateObject(1027, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[10] = CreateObject(1027, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars[6], -0.300000, 0.000000, 0.675000, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[1], carshopcars[6], 1.049999, 2.174999, -0.599999, 0.000005, 180.899887, 180.899963);
    AttachObjectToVehicle(carshopobjects[2], carshopcars[6], -1.049999, -1.950001, -0.599999, 0.000005, 180.899887, 361.799743);
    AttachObjectToVehicle(carshopobjects[3], carshopcars[6], 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[4], carshopcars[6], -0.074999, -2.325000, 0.375000, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[5], carshopcars[6], 0.225000, 0.000000, 0.674999, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[6], carshopcars[6], 0.000000, 1.800000, 0.149999, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[7], carshopcars[6], 0.000000, 1.650000, 0.150000, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[8], carshopcars[6], 0.000000, 1.950000, 0.150000, -10.800001, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[9], carshopcars[6], -1.049999, -0.824999, -0.599999, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[10], carshopcars[6], 0.974999, -0.824999, -0.599999, 0.000000, 0.000000, 0.000000);
    carshopcars[7] = AddStaticVehicle(415, -1428.3811, 1098.0699, 1039.9996, 103.7194, 74, 74);
    carshopobjects[0] = CreateObject(18646, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopcars[7], carshopobjects[0], 0.30450, 0.46970, 0.26350, 0.00000, 0.00000, 0.00000);
    LinkVehicleToInterior(carshopcars[7], 15);
    AttachObjectToVehicle(carshopcars[8], carshopobjects[0], 0.00160, 3.57950, 0.21160, 120.00000, 90.00000, 0.00000);
    LinkVehicleToInterior(carshopcars[8], 15);
    Create3DTextLabel("{FFFF00}Информация:\n{FF0000}Всички превозни средства могат да се закупят за определен играч и за банда.\nКогато го закупите за банда цената е по евтина с 5 лв.\nДо всяко превозно средство са написани цените, които струват за определен играч!\nАко имате идеи за нови превозни средства споделете ги на дискорд {FFFFFF}didkoandreevofficial", 0xFFFFFFFF, -1444.0856, 1087.5129, 1040.7969, 10, 1);
    Create3DTextLabel("{FFFF00}Информация:\n{FF0000}Всички превозни средства могат да се закупят за определен играч и за банда.\nКогато го закупите за банда цената е по евтина с 5 лв.\nДо всяко превозно средство са написани цените, които струват за определен играч!\nАко имате идеи за нови превозни средства споделете ги на дискорд {FFFFFF}didkoandreevofficial", 0xFFFFFFFF, -1444.0856, 1087.5129, 1040.7969, 10, 0);
    Create3DTextLabel("{FF0000}Ако искате да закупите кола пишете на дискорд - {FFFFFF}didkoandreevofficial", 0xFFFFFFFF, 2006.8207, 1167.4012, 10.8203, 10, 0);
    Create3DTextLabel("{FF0000}Ако искате да закупите кола пишете на дискорд - {FFFFFF}didkoandreevofficial", 0xFFFFFFFF, 1411.5128, -1699.5909, 13.5395, 10, 0);
    Create3DTextLabel("{FFFF00}Infernus с тунинг\n{FFFFFF}Цена: {40BF00}20 лв. по касата\n{FF0000}ВНИМАНИЕ: Колата може да е само черна, защото броните са черни!", 0xFFFFFFFF, -1443.0841, 1091.4852, 1040.2311, 20, 0);
    Create3DTextLabel("{FFFF00}Cheetah с полицейски буркан отвътре\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Бурканът свети само когато е тъмно!", 0xFFFFFFFF, -1431.2561, 1097.3242, 1040.2306, 20, 0);
    Create3DTextLabel("{FFFF00}Infernus с полицейски буркан отвътре\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Бурканът свети само когато е тъмно!", 0xFFFFFFFF, -1423.4561, 1099.3093, 1040.2233, 20, 0);
    Create3DTextLabel("{FFFF00}Sultan с Minigun и RPG\n{FFFFFF}Цена: {40BF00}10 лв. по касата\n{FF0000}ВНИМАНИЕ: Minigun-ните и RPG-то НЕ стрелят!", 0xFFFFFFFF, -1415.6876, 1101.0677, 1040.2094, 20, 0);
    Create3DTextLabel("{FFFF00}Patriot с оръдие за ракети\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Оръдието с ракети НЕ стреля!", 0xFFFFFFFF, -1406.2703, 1102.2839, 1040.2030, 20, 0);
    Create3DTextLabel("{FFFF00}DFT-30 с контейнер\n{FFFFFF}Цена: {40BF00}15 лв. по касата\n{FF0000}ВНИМАНИЕ: Вратите на контейнера могат да се отварят и затварят с команда!", 0xFFFFFFFF, -1395.2511, 1103.4880, 1040.1986, 20, 0);
    Create3DTextLabel("{FFFF00}Turismo с огън\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Огъня може да се слага на всяка кола!", 0xFFFFFFFF, -1381.5884, 1101.3951, 1040.1764, 20, 0);
    Create3DTextLabel("{FFFF00}Лимозина с рога\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Рогата може да се слага на всяка кола!", 0xFFFFFFFF, -1369.5228, 1098.7689, 1040.1676, 20, 0);
    Create3DTextLabel("{FFFF00}Infernus с тунинг\n{FFFFFF}Цена: {40BF00}20 лв. по касата\n{FF0000}ВНИМАНИЕ: Колата може да е само черна, защото броните са черни!", 0xFFFFFFFF, -1443.0841, 1091.4852, 1040.2311, 20, 1);
    Create3DTextLabel("{FFFF00}Cheetah с полицейски буркан отвътре\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Бурканът свети само когато е тъмно!", 0xFFFFFFFF, -1431.2561, 1097.3242, 1040.2306, 20, 1);
    Create3DTextLabel("{FFFF00}Infernus с полицейски буркан отвътре\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Бурканът свети само когато е тъмно!", 0xFFFFFFFF, -1423.4561, 1099.3093, 1040.2233, 20, 1);
    Create3DTextLabel("{FFFF00}Sultan с Minigun и RPG\n{FFFFFF}Цена: {40BF00}10 лв. по касата\n{FF0000}ВНИМАНИЕ: Minigun-ните и RPG-то НЕ стрелят!", 0xFFFFFFFF, -1415.6876, 1101.0677, 1040.2094, 20, 1);
    Create3DTextLabel("{FFFF00}Patriot с оръдие за ракети\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Оръдието с ракети НЕ стреля!", 0xFFFFFFFF, -1406.2703, 1102.2839, 1040.2030, 20, 1);
    Create3DTextLabel("{FFFF00}DFT-30 с контейнер\n{FFFFFF}Цена: {40BF00}15 лв. по касата\n{FF0000}ВНИМАНИЕ: Вратите на контейнера могат да се отварят и затварят с команда!", 0xFFFFFFFF, -1395.2511, 1103.4880, 1040.1986, 20, 1);
    Create3DTextLabel("{FFFF00}Turismo с огън\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Огъня може да се слага на всяка кола!", 0xFFFFFFFF, -1381.5884, 1101.3951, 1040.1764, 20, 1);
    Create3DTextLabel("{FFFF00}Лимозина с рога\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Рогата може да се слага на всяка кола!", 0xFFFFFFFF, -1369.5228, 1098.7689, 1040.1676, 20, 1);
    //carshop - location - close
    //menus - location - open
    DefineTuneMenu();
    //menus - location - close
    //pickups - location - open
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
    IPDPickup[2] = CreatePickup(1318, 1, -1605.6638,710.3925,13.8672, 0);
    IPDPickup[3] = CreatePickup(1318, 1, 246.3961,87.8423,1003.6406, 1);
    IPDPickup[4] = CreatePickup(1318, 1, 2287.0984,2432.3669,10.8203, 0);
    IPDPickup[5] = CreatePickup(1318, 1, 242.2486,66.3642,1003.6406, 1);
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
    grovehealarmour[1] = CreatePickup(1242, 1, 2498.2009, -1705.7358, 1014.7422, 1); //AddPlayerClass(1,2498.1658,-1705.5845,1014.7422,0.5868,0,0,0,0,0,0); // 
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
    //vip teleports - close
    //pickups - location - close
    //vehicles - location - open
    fishBoat1[0] = AddStaticVehicle(453, -1364.9620, 2105.0552, 40.2413, 312.2090, 1, 1); // lodka1
    fishBoat1[1] = AddStaticVehicle(453, -1361.4890, 2100.8291, 40.2132, 307.5796, 1, 1); // lodka2
    fishBoat1[2] = AddStaticVehicle(453, -1357.1643, 2096.5186, 40.2492, 314.6524, 1, 1); // lodka3
    fishBoat1[3] = AddStaticVehicle(453, -1379.9890, 2136.7983, 40.2849, 248.7483, 1, 1); // lodka4
    fishBoat1[4] = AddStaticVehicle(453, -1383.1028, 2130.6077, 40.2275, 242.2711, 1, 1); // lodka5
    fishBoat1[5] = AddStaticVehicle(453, -1358.2734, 2134.8970, 40.3629, 178.7726, 1, 1); // lodka6
    fishBoat2[0] = AddStaticVehicle(453, -1364.9620, 2105.0552, 40.2413, 312.2090, 1, 1); // lodka1
    fishBoat2[1] = AddStaticVehicle(453, -1361.4890, 2100.8291, 40.2132, 307.5796, 1, 1); // lodka2
    fishBoat2[2] = AddStaticVehicle(453, -1357.1643, 2096.5186, 40.2492, 314.6524, 1, 1); // lodka3
    fishBoat2[3] = AddStaticVehicle(453, -1379.9890, 2136.7983, 40.2849, 248.7483, 1, 1); // lodka4
    fishBoat2[4] = AddStaticVehicle(453, -1383.1028, 2130.6077, 40.2275, 242.2711, 1, 1); // lodka5
    fishBoat2[5] = AddStaticVehicle(453, -1358.2734, 2134.8970, 40.3629, 178.7726, 1, 1); // lodka6
    for (new i = 0; i < 6; i++)
    {
        SetVehicleVirtualWorld(fishBoat2[i], 1);
    }

    derbytypecar1[1] = AddStaticVehicle(559, -1967.6910, 3117.8047, 116.5250, 90.0189, 0, 0);
    derbytypecar1[2] = AddStaticVehicle(535, -2005.9907, 3077.5483, 116.6330, 269.8782, 21, 21);
    derbytypecar1[3] = AddStaticVehicle(600, -2007.1895, 3238.7617, 116.5942, 179.1579, 3, 3);
    derbytypecar1[4] = AddStaticVehicle(541, -1928.7631, 3279.7585, 116.5137, 180.3685, 52, 53);
    derbytypecar1[5] = AddStaticVehicle(415, -1896.2786, 3279.8789, 116.6600, 180.0912, 84, 84);
    derbytypecar1[6] = AddStaticVehicle(579, -1895.7048, 3153.5156, 101.4379, 89.1011, 22, 22);
    derbytypecar1[7] = AddStaticVehicle(412, -1935.4741, 3215.1226, 102.9278, 179.8446, 86, 86);
    derbytypecar1[8] = AddStaticVehicle(479, -2015.8408, 3184.5261, 102.8833, 270.5159, 2, 2);
    derbytypecar1[9] = AddStaticVehicle(560, -2015.9592, 3153.8970, 102.7897, 270.5407, 6, 6);
    derbytypecar1[10] = AddStaticVehicle(411, -2015.5110, 3122.3530, 102.8158, 270.1569, 1, 1);
    AddVehicleComponent(derbytypecar1[1], 1010);
    AddVehicleComponent(derbytypecar1[2], 1010);
    AddVehicleComponent(derbytypecar1[3], 1010);
    AddVehicleComponent(derbytypecar1[4], 1010);
    AddVehicleComponent(derbytypecar1[5], 1010);
    AddVehicleComponent(derbytypecar1[6], 1010);
    AddVehicleComponent(derbytypecar1[7], 1010);
    AddVehicleComponent(derbytypecar1[8], 1010);
    AddVehicleComponent(derbytypecar1[9], 1010);
    AddVehicleComponent(derbytypecar1[10], 1010);
    SetVehicleVirtualWorld(derbytypecar1[1], 4);
    SetVehicleVirtualWorld(derbytypecar1[2], 4);
    SetVehicleVirtualWorld(derbytypecar1[3], 4);
    SetVehicleVirtualWorld(derbytypecar1[4], 4);
    SetVehicleVirtualWorld(derbytypecar1[5], 4);
    SetVehicleVirtualWorld(derbytypecar1[6], 4);
    SetVehicleVirtualWorld(derbytypecar1[7], 4);
    SetVehicleVirtualWorld(derbytypecar1[8], 4);
    SetVehicleVirtualWorld(derbytypecar1[9], 4);
    SetVehicleVirtualWorld(derbytypecar1[10], 4);

    carpilot[1] = AddStaticVehicle(511, 382.7576, 2536.0332, 17.9922, 176.6510, 3, 3); // pilot1
    carpilot[2] = AddStaticVehicle(511, 359.8245, 2536.8083, 18.0109, 177.6166, 3, 3); // pilot2
    carpilot[3] = AddStaticVehicle(511, 268.3786, 2535.4526, 18.0536, 180.3932, 3, 3); // pilot3
    carpilot[4] = AddStaticVehicle(511, 243.3229, 2535.4875, 18.0442, 179.8697, 3, 3); // pilot4
    carpilot[5] = AddStaticVehicle(511, 363.8391, 2470.6494, 17.8039, 359.7092, 3, 3); // pilot5
    carsweeper[1] = AddStaticVehicle(574, 570.7686, 1217.6624, 11.5150, 212.5410, 1, 1); // sweepcar
    carsweeper[2] = AddStaticVehicle(574, 572.4439, 1218.8262, 11.4516, 211.8157, 1, 1); // sweepcar2
    carsweeper[3] = AddStaticVehicle(574, 577.4621, 1220.9525, 11.4364, 212.9591, 1, 1); // sweepcar3
    carsweeper[4] = AddStaticVehicle(574, 578.9632, 1221.9869, 11.4364, 212.8099, 1, 1); // sweepcar4
    carcoalmine[1] = AddStaticVehicleEx(406, 858.2269, 879.6721, 14.7627, 201.0449, 1, 1, 5); //
    carcoalmine[2] = AddStaticVehicleEx(406, 850.8806, 876.3572, 14.9247, 202.1210, 1, 1, 5); //
    carcoalmine[3] = AddStaticVehicleEx(406, 843.9622, 873.7372, 14.7720, 202.0721, 1, 1, 5); //
    carcoalmine[4] = AddStaticVehicleEx(406, 837.6867, 870.4841, 14.7916, 201.2635, 1, 1, 5); //
    afterwork[0] = CreateVehicle(411, 832.4344, 837.6809, 11.5070, 20.8823, 0, 0, 900); // veh1
    afterwork[1] = CreateVehicle(411, 835.9622, 838.5618, 11.8255, 21.4923, 1, 1, 900); // veh
    afterwork[2] = CreateVehicle(411, 839.2482, 839.3900, 12.1361, 19.7798, 7, 7, 900); // veh
    afterwork[3] = CreateVehicle(522, 841.9667, 840.9456, 12.2186, 22.4552, 0, 0, 900); // veh
    afterwork[4] = CreateVehicle(522, 843.3854, 841.7632, 12.3236, 26.6766, 1, 1, 900); // veh
    afterwork[5] = CreateVehicle(522, 845.2407, 842.2749, 12.5161, 14.0011, 7, 7, 900); // veh
    afterwork[6] = CreateVehicle(411, 615.0783, 1227.1151, 11.4458, 118.5010, 0, 0, 900); // veh
    afterwork[7] = CreateVehicle(411, 613.5852, 1230.2531, 11.4458, 118.3363, 1, 1, 900); // veh
    afterwork[8] = CreateVehicle(411, 611.6678, 1232.9268, 11.4458, 118.2612, 7, 7, 900); // veh
    afterwork[9] = CreateVehicle(522, 609.0194, 1236.0812, 11.2933, 115.5268, 0, 0, 900); // veh
    afterwork[10] = CreateVehicle(522, 608.2195, 1237.7094, 11.2850, 108.2882, 1, 1, 900); // veh
    afterwork[11] = CreateVehicle(522, 608.1815, 1238.8450, 11.2928, 115.8031, 7, 7, 900); // veh
    afterwork[12] = CreateVehicle(411, 425.6216, 2529.6577, 16.3437, 184.5891, 0, 0, 900); // veh
    afterwork[13] = CreateVehicle(411, 422.0308, 2528.8699, 16.3254, 185.0556, 1, 1, 900); // veh
    afterwork[14] = CreateVehicle(411, 418.9781, 2528.9233, 16.3172, 179.7733, 7, 7, 900); // veh
    afterwork[15] = CreateVehicle(522, 415.1333, 2528.9492, 16.1791, 175.1624, 0, 0, 900); // veh
    afterwork[16] = CreateVehicle(522, 414.0790, 2528.9260, 16.1763, 166.9628, 1, 1, 900); // veh
    afterwork[17] = CreateVehicle(522, 412.5888, 2528.7742, 16.1676, 171.5464, 7, 7, 900); // veh
    afterwork[18] = CreateVehicle(411, 47.3786, -253.7540, 1.3749, 265.0179, 0, 0, 900); // veh
    afterwork[19] = CreateVehicle(411, 46.9400, -256.5018, 1.4171, 270.1889, 1, 1, 900); // veh
    afterwork[20] = CreateVehicle(411, 47.0149, -259.3380, 1.4477, 268.6745, 7, 7, 900); // veh
    afterwork[21] = CreateVehicle(522, 46.4583, -262.1669, 1.3404, 262.7072, 0, 0, 900); // veh
    afterwork[22] = CreateVehicle(522, 46.8016, -263.2418, 1.3455, 263.0025, 1, 1, 900); // veh
    afterwork[23] = CreateVehicle(522, 46.7809, -264.1643, 1.3557, 262.4278, 7, 7, 900); // veh
    afterwork[24] = CreateVehicle(411, 1378.1586, 269.0237, 19.2940, 338.4818, 0, 0, 900); // veh
    afterwork[25] = CreateVehicle(411, 1381.5187, 267.4872, 19.2940, 337.8664, 1, 1, 900); // veh
    afterwork[26] = CreateVehicle(411, 1384.6252, 266.0334, 19.2940, 334.1597, 7, 7, 900); // veh
    afterwork[27] = CreateVehicle(522, 1387.2539, 263.5329, 19.1194, 337.2061, 0, 0, 900); // veh
    afterwork[28] = CreateVehicle(522, 1387.9193, 263.0052, 19.1409, 336.3415, 1, 1, 900); // veh
    afterwork[29] = CreateVehicle(522, 1388.9036, 262.2971, 19.1392, 335.0469, 7, 7, 900); // veh
    afterwork[30] = CreateVehicle(411, -539.4708, 2565.8433, 53.1425, 268.6549, 0, 0, 900); // veh
    afterwork[31] = CreateVehicle(411, -539.5480, 2563.2871, 53.1418, 268.1252, 1, 1, 900); // veh
    afterwork[32] = CreateVehicle(411, -539.3613, 2560.2180, 53.1418, 268.8858, 7, 7, 900); // veh
    afterwork[33] = CreateVehicle(522, -540.8374, 2556.6814, 52.9886, 269.0560, 0, 0, 900); // veh
    afterwork[34] = CreateVehicle(522, -540.7065, 2555.1716, 52.9886, 263.3294, 1, 1, 900); // veh
    afterwork[35] = CreateVehicle(522, -540.2985, 2553.9404, 52.9845, 260.8280, 7, 7, 900); // veh
    afterwork[36] = CreateVehicle(411, 0.4873, -333.9484, 5.1568, 93.2239, 0, 0, 900); // veh
    afterwork[37] = CreateVehicle(411, 0.5126, -336.6106, 5.1568, 88.4291, 1, 1, 900); // veh
    afterwork[38] = CreateVehicle(411, -0.2487, -339.4753, 5.1568, 86.2355, 7, 7, 900); // veh
    afterwork[39] = CreateVehicle(522, -1.0375, -343.6505, 5.0041, 89.6106, 0, 0, 900); // veh
    afterwork[40] = CreateVehicle(522, -1.4598, -344.5724, 5.0028, 92.8479, 1, 1, 900); // veh
    afterwork[41] = CreateVehicle(522, -2.0090, -346.2775, 5.0055, 85.8586, 7, 7, 900); // veh
    for (new i = 0; i < 42; i++)
    {
        ToggleEngine(afterwork[i], VEHICLE_PARAMS_OFF);
    }
    fuelremarke[0] = AddStaticVehicle(584, 271.4840, 1341.2374, 11.7400, 0.5160, 0, 0); // remarke1
    fuelremarke[1] = AddStaticVehicle(584, 263.8116, 1340.9697, 11.7545, 0.3961, 0, 0); // remarke2
    fuelremarke[2] = AddStaticVehicle(584, 280.3829, 1341.1115, 11.7410, 1.0650, 0, 0); // remarke3
    fueltruck[0] = AddStaticVehicle(403, 284.3264, 1360.4240, 11.1927, 88.2289, 0, 0); // veh1
    //ToggleEngine(fueltruck[0], VEHICLE_PARAMS_OFF);
    fueltruck[1] = AddStaticVehicle(403, 284.4374, 1371.9625, 11.1927, 90.2667, 8, 8); // veh2
    //ToggleEngine(fueltruck[1], VEHICLE_PARAMS_OFF);
    fueltruck[2] = AddStaticVehicle(403, 284.4071, 1365.9193, 11.1926, 89.6312, 9, 9); // veh3
    //ToggleEngine(fueltruck[2], VEHICLE_PARAMS_OFF);
    carbus[1] = AddStaticVehicle(431, -521.3267, 2569.4219, 53.5132, 358.5933, 1, 1); // bus
    carbus[2] = AddStaticVehicle(431, -512.0872, 2553.7710, 53.5170, 88.0071, 1, 1); // bus
    carbus[3] = AddStaticVehicle(431, -513.0065, 2548.9106, 53.5151, 88.9376, 1, 1); // bus
    carbus[4] = AddStaticVehicle(431, -510.6169, 2579.8213, 53.5219, 87.5477, 1, 1); // bus
    carbus[5] = AddStaticVehicle(431, -511.0210, 2582.8525, 53.5136, 86.0736, 1, 1); // bus
    carpizza[1] = AddStaticVehicle(448, 1356.7051, 243.4740, 19.1688, 65.4089, 3, 6); // piza
    carpizza[2] = AddStaticVehicle(448, 1355.9683, 241.1347, 19.1421, 62.2654, 3, 6); // piza2
    carpizza[3] = AddStaticVehicle(448, 1356.5350, 242.4410, 19.1596, 63.2474, 3, 6); // piza3
    carpizza[4] = AddStaticVehicle(448, 1363.1876, 259.8902, 19.1605, 69.1960, 3, 6); // piza4
    carpizza[5] = AddStaticVehicle(448, 1364.0146, 260.9592, 19.1494, 63.5487, 3, 6); // piza5
    carpizza[6] = AddStaticVehicle(448, 1364.0315, 262.2966, 19.1587, 61.9309, 3, 6); // piza6
    cartruck[1] = AddStaticVehicle(515, 65.7177, -285.2350, 2.6372, 1.4777, 0, 0); // Job - Truck Car 1
    cartruck[2] = AddStaticVehicle(514, 53.2033, -285.1273, 2.3195, 358.3466, 3, 3); // Job - Truck Car 2
    cartruck[3] = AddStaticVehicle(403, 35.6616, -266.8764, 2.7455, 266.1551, 24, 24); // Job - Truck Car 3
    cartruck[4] = AddStaticVehicle(515, 43.0861, -231.5357, 2.6533, 266.6200, 3, 3); // Job - Truck Car 4
    cartruck[5] = AddStaticVehicle(514, 44.8290, -224.5736, 2.2295, 268.1153, 0, 0); // Job - Truck Car 5
    cardeliver[1] = AddStaticVehicle(609, -31.8258, -290.1678, 5.4251, 269.3731, 86, 86); // Deliver - Car1
    cardeliver[2] = AddStaticVehicle(609, -23.2258, -273.9886, 5.4273, 179.0741, 86, 86); // Deliver - Car2
    cardeliver[3] = AddStaticVehicle(609, 0.3479, -301.1396, 5.4233, 89.4623, 86, 86); // Deliver - Car3
    cardeliver[4] = AddStaticVehicle(609, 0.0413, -311.8060, 5.4393, 89.6039, 86, 86); // Deliver - Car4
    cardeliver[5] = AddStaticVehicle(609, -0.0081, -322.3448, 5.4393, 89.5987, 86, 86); // Deliver - Car5
    vipVehs[1] = CreateVehicle(579, 1140.7024, -2030.0927, 68.9443, 271.9881, 181, 181, 900); // vipcar1
    vipVehs[2] = CreateVehicle(409, 1243.9410, -2021.2043, 59.7309, 177.9704, 181, 181, 900); // vipcar2
    vipVehs[3] = CreateVehicle(409, 1243.9419, -2037.4746, 59.7307, 181.8856, 181, 181, 900); // vipcar3
    vipVehs[4] = CreateVehicle(468, 1274.2704, -2048.9709, 58.9283, 178.9933, 181, 181, 900); // vipcar4
    vipVehs[5] = CreateVehicle(468, 1276.4502, -2048.5881, 58.8944, 193.5808, 181, 181, 900); // vipcar5
    vipVehs[6] = CreateVehicle(468, 1279.2736, -2048.9507, 58.8003, 190.0562, 181, 181, 900); // vipcar6
    vipVehs[7] = CreateVehicle(560, 1277.1289, -2042.6338, 58.7295, 92.2990, 181, 181, 900); // vipcar7
    vipVehs[8] = CreateVehicle(560, 1277.3984, -2031.0327, 58.6496, 83.0665, 181, 181, 900); // vipcar8
    vipVehs[9] = CreateVehicle(560, 1277.5686, -2024.5355, 58.6122, 80.3641, 181, 181, 900); // vipcar9
    vipVehs[10] = CreateVehicle(411, 1277.0298, -2010.4761, 58.6602, 183.4705, 181, 181, 900); // vipcar10
    vipVehs[11] = CreateVehicle(411, 1270.0671, -2010.0409, 58.8562, 177.6457, 181, 181, 900); // vipcar11
    vipVehs[12] = CreateVehicle(411, 1244.2449, -2009.8389, 59.6042, 181.7225, 181, 181, 900); // vipcar12
    vipVehs[13] = CreateVehicle(522, 1237.1691, -2007.3179, 59.4209, 261.3344, 181, 181, 900); // vipcar13
    vipVehs[14] = CreateVehicle(522, 1237.4316, -2030.3452, 60.5957, 269.5838, 181, 181, 900); // vipcar14
    vipVehs[15] = CreateVehicle(522, 1237.6796, -2042.7904, 60.5584, 271.8774, 181, 181, 900); // vipcar15
    vipVehs[16] = CreateVehicle(522, 1175.1260, -2041.3722, 68.5540, 185.4893, 181, 181, 900); // vipcar16
    vipVehs[17] = CreateVehicle(522, 1175.0313, -2032.8108, 68.5775, 0.9233, 181, 181, 900); // vipcar17
    vipVehs[18] = CreateVehicle(579, 1140.4346, -2041.7124, 69.0015, 270.5126, 181, 181, 900); // vipcar18
    vipVehs[19] = CreateVehicle(562, 1138.6312, -2063.9949, 68.6584, 2.5424, 181, 181, 900);
    vipVehs[20] = CreateVehicle(559, 1138.4088, -2010.0665, 68.6807, 181.0400, 181, 181, 900);
    vipVehs[21] = CreateVehicle(513, 1264.4708, -2009.5179, 59.8866, 178.2558, 181, 0, 900);
    vipVehs[22] = CreateVehicle(513, 1252.4545, -2009.0323, 60.2322, 175.9293, 181, 0, 900);

    vipVehs[23] = CreateVehicle(565, 1369.3691, -2036.2728, 55.7907, 97.9695, 1, 1, 900);
    vipVehs[24] = CreateVehicle(560, 1368.1836, -2029.9252, 55.7226, 97.3020, 1, 1, 900);
    vipVehs[25] = CreateVehicle(576, 1366.6332, -2023.7151, 55.6430, 97.4405, 1, 1, 900);
    vipVehs[26] = CreateVehicle(535, 1366.3467, -2017.2739, 55.6911, 97.4858, 1, 1, 900);
    vipVehs[27] = CreateVehicle(534, 1365.0499, -2011.0005, 55.5734, 97.9078, 1, 1, 900);
    vipVehs[28] = CreateVehicle(575, 1364.4288, -2004.6128, 55.3218, 97.9375, 1, 1, 900);
    vipVehs[29] = CreateVehicle(561, 1363.7311, -1998.1807, 55.4385, 97.5317, 1, 1, 900);
    vipVehs[30] = CreateVehicle(603, 1338.6970, -2036.9438, 56.4600, 277.2449, 0, 0, 900);
    vipVehs[31] = CreateVehicle(567, 1338.1980, -2030.4966, 56.3650, 277.1607, 1, 1, 900);
    vipVehs[32] = CreateVehicle(567, 1337.4781, -2024.1407, 56.2766, 277.3607, 1, 1, 900);
    vipVehs[33] = CreateVehicle(483, 1336.2733, -2017.8456, 56.2976, 277.1776, 1, 1, 900);
    vipVehs[34] = CreateVehicle(562, 1334.8486, -2011.5480, 55.8763, 277.7780, 1, 1, 900);
    vipVehs[35] = CreateVehicle(558, 1334.3204, -2005.1951, 55.7860, 277.7154, 1, 1, 900);
    vipVehs[36] = CreateVehicle(415, 1333.3846, -1998.8451, 55.8204, 277.9221, 1, 1, 900);
    vipVehs[37] = CreateVehicle(480, 1332.7406, -1992.5273, 55.7602, 278.0070, 1, 3, 900);
    vipVehs[38] = CreateVehicle(562, 1168.7881, -2063.9421, 68.6574, 358.6059, 181, 181, 900);
    vipVehs[39] = CreateVehicle(559, 1168.9164, -2009.8586, 68.6512, 179.3755, 181, 181, 900);
    vipVehs[40] = CreateVehicle(510, 1237.1449, -2041.1643, 60.6230, 266.7683, 181, 181, 900);
    vipVehs[41] = CreateVehicle(510, 1237.3176, -2032.4642, 60.6253, 270.9919, 181, 181, 900);

    ChangeVehiclePaintjob(vipVehs[23], 1);
    ChangeVehiclePaintjob(vipVehs[24], 1);
    ChangeVehiclePaintjob(vipVehs[25], 0);
    ChangeVehiclePaintjob(vipVehs[26], 2);
    ChangeVehiclePaintjob(vipVehs[27], 1);
    ChangeVehiclePaintjob(vipVehs[28], 0);
    ChangeVehiclePaintjob(vipVehs[29], 1);
    ChangeVehiclePaintjob(vipVehs[31], 1);
    ChangeVehiclePaintjob(vipVehs[32], 2);
    ChangeVehiclePaintjob(vipVehs[33], 0);
    ChangeVehiclePaintjob(vipVehs[34], 1);
    ChangeVehiclePaintjob(vipVehs[35], 1);
    AddVehicleComponent(vipVehs[23], 1035);
    AddVehicleComponent(vipVehs[24], 1035);
    AddVehicleComponent(vipVehs[25], 1035);
    AddVehicleComponent(vipVehs[26], 1035);
    AddVehicleComponent(vipVehs[27], 1035);
    AddVehicleComponent(vipVehs[28], 1035);
    AddVehicleComponent(vipVehs[29], 1035);
    AddVehicleComponent(vipVehs[31], 1035);
    AddVehicleComponent(vipVehs[32], 1035);
    AddVehicleComponent(vipVehs[33], 1035);
    AddVehicleComponent(vipVehs[34], 1035);
    AddVehicleComponent(vipVehs[35], 1035);
    AddVehicleComponent(vipVehs[23], 1147);
    AddVehicleComponent(vipVehs[24], 1147);
    AddVehicleComponent(vipVehs[25], 1147);
    AddVehicleComponent(vipVehs[26], 1147);
    AddVehicleComponent(vipVehs[27], 1147);
    AddVehicleComponent(vipVehs[28], 1147);
    AddVehicleComponent(vipVehs[29], 1147);
    AddVehicleComponent(vipVehs[31], 1147);
    AddVehicleComponent(vipVehs[32], 1147);
    AddVehicleComponent(vipVehs[33], 1147);
    AddVehicleComponent(vipVehs[34], 1147);
    AddVehicleComponent(vipVehs[35], 1147);

    for (new i; i < sizeof(vipVehs); i++)
    {
        isVipGangVeh[vipVehs[i]] = true;
    }
    soldierVehs[1] = CreateVehicle(409, -1754.4410, 938.3846, 24.6129, 270.5095, 171, 171, 900); //Stretch
    soldierVehs[2] = CreateVehicle(560, -1777.6790, 957.8425, 24.5874, 269.9056, 171, 171, 900); //Sultan
    soldierVehs[3] = CreateVehicle(560, -1730.1558, 957.8041, 24.5873, 90.0371, 171, 171, 900); //Sultan
    soldierVehs[4] = CreateVehicle(411, -1764.1466, 947.2263, 24.5391, 269.7079, 171, 171, 900); //Infernus
    soldierVehs[5] = CreateVehicle(411, -1746.6165, 947.1942, 24.5377, 269.2019, 171, 171, 900); //Infernus
    soldierVehs[6] = CreateVehicle(579, -1730.8681, 945.4312, 24.7422, 178.1536, 171, 171, 900); //Huntley
    soldierVehs[7] = CreateVehicle(579, -1777.0849, 945.6668, 24.7440, 180.4462, 171, 171, 900); //Huntley
    soldierVehs[8] = CreateVehicle(487, -1724.0946, 955.3264, 25.0706, 179.4173, 171, 171, 900); //Maverick
    soldierVehs[9] = CreateVehicle(522, -1739.0638, 962.4121, 24.4531, 162.8123, 171, 171, 900); //NRG-500
    soldierVehs[10] = CreateVehicle(522, -1737.6507, 962.4368, 24.4540, 160.2843, 171, 171, 900); //NRG-500
    for (new i; i < sizeof(soldierVehs); i++)
    {
        isSoldierGangVeh[soldierVehs[i]] = true;
    }
    yakuzaVehs[1] = CreateVehicle(411, 2586.6418, 2780.4836, 10.5473, 89.7078, 251, 251, 900); //Infernus
    yakuzaVehs[2] = CreateVehicle(411, 2570.3603, 2791.9453, 10.5473, 180.6495, 251, 251, 900); //Infernus
    yakuzaVehs[3] = CreateVehicle(560, 2574.4729, 2768.8718, 10.5252, 359.9030, 251, 251, 900); //Sultan
    yakuzaVehs[4] = CreateVehicle(579, 2566.2109, 2769.1118, 10.7518, 359.2712, 251, 251, 900); //Huntley
    yakuzaVehs[5] = CreateVehicle(579, 2586.4331, 2772.6333, 10.7529, 89.5541, 251, 251, 900); //Huntley
    yakuzaVehs[6] = CreateVehicle(560, 2562.0100, 2792.0656, 10.5255, 179.2442, 251, 251, 900); //Sultan
    yakuzaVehs[7] = CreateVehicle(562, 2557.8300, 2768.9558, 10.4797, 359.6143, 251, 251, 900); //Elegy
    yakuzaVehs[8] = CreateVehicle(487, 2541.2998, 2769.2536, 11.1501, 359.7666, 251, 251, 900); //Maverick
    yakuzaVehs[9] = CreateVehicle(522, 2583.3645, 2794.2092, 10.3880, 128.7462, 251, 251, 900); //NRG-500
    yakuzaVehs[10] = CreateVehicle(522, 2585.6254, 2794.2553, 10.3881, 127.4658, 251, 251, 900); //NRG-500
    for (new i; i < sizeof(yakuzaVehs); i++)
    {
        isYakuzaGangVeh[yakuzaVehs[i]] = true;
    }
    syndicateVehs[1] = CreateVehicle(579, 1783.7011, 2821.2512, 10.7664, 343.0036, 79, 79, 900); //Huntley
    syndicateVehs[2] = CreateVehicle(579, 1749.5639, 2820.7910, 10.7672, 17.6556, 79, 79, 900); //Huntley
    syndicateVehs[3] = CreateVehicle(411, 1778.0570, 2801.7602, 10.5630, 344.4429, 79, 79, 900); //Infernus
    syndicateVehs[4] = CreateVehicle(560, 1755.2161, 2801.8525, 10.5383, 16.5927, 79, 79, 900); //Sultan
    syndicateVehs[5] = CreateVehicle(487, 1766.6214, 2767.2133, 10.9074, 0.0176, 79, 79, 900); //Maverick
    syndicateVehs[6] = CreateVehicle(451, 1766.5034, 2780.9904, 10.5423, 91.5007, 79, 79, 900); //Turismo
    syndicateVehs[7] = CreateVehicle(541, 1766.8874, 2853.9028, 10.4572, 271.1266, 79, 79, 900); //Bullet
    syndicateVehs[8] = CreateVehicle(522, 1779.9742, 2774.1992, 10.6723, 46.1928, 79, 79, 900); //NRG-500
    syndicateVehs[9] = CreateVehicle(522, 1779.6837, 2772.7128, 10.6914, 50.1116, 79, 79, 900); //NRG-500
    for (new i; i < sizeof(syndicateVehs); i++)
    {
        isSyndicateGangVeh[syndicateVehs[i]] = true;
    }
    bloodMafiaVehs[1] = CreateVehicle(487, 1131.1058, -1232.8121, 25.4786, 359.0727, 3, 3, 900); //Maverick
    bloodMafiaVehs[2] = CreateVehicle(560, 1092.8414, -1225.3471, 15.5251, 180.4128, 3, 3, 900); //Sultan
    bloodMafiaVehs[3] = CreateVehicle(578, 1116.0975, -1247.3536, 16.4970, 0.4791, 3, 3, 900); //DFT-30
    bloodMafiaVehs[4] = CreateVehicle(439, 1097.3837, -1225.5856, 15.7161, 181.0876, 3, 3, 900); //Stallion
    bloodMafiaVehs[5] = CreateVehicle(541, 1102.0024, -1225.0908, 15.4486, 180.2831, 3, 3, 900); //Bullet
    bloodMafiaVehs[6] = CreateVehicle(522, 1106.9692, -1224.3183, 15.3949, 183.6737, 3, 3, 900); //NRG-500
    bloodMafiaVehs[7] = CreateVehicle(522, 1105.3911, -1224.3166, 15.3949, 181.0514, 3, 3, 900); //NRG-500
    bloodMafiaVehs[8] = CreateVehicle(451, 1109.9226, -1225.4902, 15.5302, 179.8953, 3, 3, 900); //Turismo
    bloodMafiaVehs[9] = CreateVehicle(579, 1085.8339, -1250.1539, 15.7590, 269.1950, 3, 3, 900); //Huntley
    bloodMafiaVehs[10] = CreateVehicle(411, 1085.5162, -1241.4329, 15.5542, 269.3987, 3, 3, 900); //Infernus
    for (new i; i < sizeof(bloodMafiaVehs); i++)
    {
        isBloodMafiaGangVeh[bloodMafiaVehs[i]] = true;
    }
    ms13Vehs[1] = CreateVehicle(522, -43.7467, 1090.7900, 19.3100, 313.1989, 98, 98, 900); // mara car1
    ms13Vehs[2] = CreateVehicle(522, -41.3642, 1090.5417, 19.3100, 312.1312, 98, 98, 900); // mara car2
    ms13Vehs[3] = CreateVehicle(566, -25.8431, 1117.7206, 19.5322, 180.2623, 98, 98, 900); // mara car3
    ms13Vehs[4] = CreateVehicle(567, -9.1512, 1113.1694, 19.7791, 180.2317, 98, 98, 900); // mara car4
    ms13Vehs[5] = CreateVehicle(411, 4.9422, 1083.8176, 19.4745, 90.6888, 98, 98, 900); // mara car5
    ms13Vehs[6] = CreateVehicle(411, -2.7396, 1083.7994, 19.4710, 89.5072, 98, 98, 900); // mara car6
    ms13Vehs[7] = CreateVehicle(579, 0.4540, 1067.7860, 19.8970, 90.2868, 98, 98, 900); // mara car7
    ms13Vehs[8] = CreateVehicle(560, -30.3721, 1066.7074, 19.4498, 359.9763, 98, 98, 900); // mara car8
    ms13Vehs[9] = CreateVehicle(560, -30.3590, 1084.8069, 19.4481, 359.4691, 98, 98, 900); // mara car9
    ms13Vehs[10] = CreateVehicle(487, -43.7323, 1083.2986, 23.3676, 269.2445, 98, 98, 900); // mara car10
    for (new i; i < sizeof(ms13Vehs); i++)
    {
        isMS13GangVeh[ms13Vehs[i]] = true;
    }
    bgMafiaVehs[0] = CreateVehicle(487, 1291.2058, -789.7775, 96.6011, 179.8307, 0, 0, 900); // BGM Car 1
    bgMafiaVehs[1] = CreateVehicle(560, 1243.4724, -809.0154, 87.8661, 303.3171, 0, 0, 900); // BGM Car 2
    bgMafiaVehs[2] = CreateVehicle(560, 1235.8627, -811.3358, 87.5092, 275.4814, 0, 0, 900); // BGM Car 3
    bgMafiaVehs[3] = CreateVehicle(560, 1227.4371, -811.8135, 87.2921, 271.7863, 0, 0, 900); // BGM Car 4
    bgMafiaVehs[4] = CreateVehicle(579, 1225.8682, -803.0211, 88.5512, 271.9268, 0, 0, 900); // BGM Car 5
    bgMafiaVehs[5] = CreateVehicle(579, 1232.8867, -802.7137, 88.6010, 273.3310, 0, 0, 900); // BGM Car 6
    bgMafiaVehs[6] = CreateVehicle(562, 1213.3787, -830.7581, 84.7358, 52.4480, 0, 0, 900); // BGM Car 7
    bgMafiaVehs[7] = CreateVehicle(559, 1219.3944, -834.1917, 84.2755, 66.2540, 0, 0, 900); // BGM Car 8
    bgMafiaVehs[8] = CreateVehicle(411, 1242.9226, -803.3868, 83.8676, 178.9484, 0, 0, 900); // BGM Car 9
    bgMafiaVehs[9] = CreateVehicle(487, 1291.2115, -789.7786, 96.6327, 179.8968, 0, 0, 900); // BGM Car 10
    for (new i; i < sizeof(bgMafiaVehs); i++)
    {
        isBGMafiaGangVeh[bgMafiaVehs[i]] = true;
    }
    Gang343Vehs[0] = CreateVehicle(560, -813.5150, 1566.0947, 26.7411, 180.0169, 0, 30, -1); //Sultan
    Gang343Vehs[1] = CreateVehicle(567, -813.4089, 1555.0924, 26.9023, 359.1227, 0, 169, -1); //Savanna
    Gang343Vehs[2] = CreateVehicle(541, -820.8497, 1542.1290, 26.7335, 308.8533, 0, 0, -1); //Bullet
    Gang343Vehs[3] = CreateVehicle(451, -821.9215, 1577.9213, 26.7548, 228.5114, 0, 253, -1); //Turismo
    Gang343Vehs[4] = CreateVehicle(579, -793.9832, 1542.1098, 26.9094, 88.5361, 0, 118, -1); //Huntley
    Gang343Vehs[5] = CreateVehicle(411, -793.1918, 1572.3433, 26.7002, 91.5546, 0, 148, -1); //Infernus
    Gang343Vehs[6] = CreateVehicle(487, -822.4821, 1568.9770, 30.4314, 270.8357, 0, 0, -1); //Maverick
    Gang343Vehs[7] = CreateVehicle(487, -823.2189, 1555.6975, 30.8420, 270.8032, 0, 0, -1); //Maverick
    Gang343Vehs[8] = CreateVehicle(522, -794.7127, 1564.0701, 26.6853, 125.8678, 0, 0, -1); //NRG-500
    Gang343Vehs[9] = CreateVehicle(522, -795.6697, 1565.4379, 26.6849, 127.0733, 0, 0, -1); //NRG-500*
    for (new i; i < sizeof(Gang343Vehs); i++)
    {
        is343GangVeh[Gang343Vehs[i]] = true;
    }
    groveVehs[1] = CreateVehicle(522, 2482.3757, -1652.5487, 13.0282, 142.6509, 86, 86, 900);
    groveVehs[2] = CreateVehicle(566, 2498.3342, -1649.1823, 13.3081, 157.4072, 86, 86, 900);
    groveVehs[3] = CreateVehicle(492, 2515.5366, -1665.1935, 13.5741, 91.9201, 86, 86, 900);
    groveVehs[4] = CreateVehicle(429, 2516.7124, -1672.0027, 13.6131, 60.6237, 86, 0, 900);
    groveVehs[5] = CreateVehicle(411, 2509.9509, -1686.9349, 13.2954, 50.8308, 86, 86, 900);
    groveVehs[6] = CreateVehicle(567, 2488.0681, -1682.6639, 13.1949, 92.3377, 86, 86, 900);
    groveVehs[7] = CreateVehicle(560, 2473.2893, -1695.6903, 13.1662, 0.0001, 86, 86, 900);
    groveVehs[8] = CreateVehicle(560, 2473.2490, -1704.8604, 13.1925, 359.8790, 86, 86, 900);
    groveVehs[9] = CreateVehicle(482, 2466.2520, -1688.1406, 13.6778, 267.1897, 86, 86, 900);
    groveVehs[10] = CreateVehicle(579, 2470.4138, -1670.1687, 13.2181, 11.2582, 86, 86, 900);
    groveVehs[11] = CreateVehicle(409, 2443.2847, -1644.2251, 13.3183, 181.7236, 86, 86, 900);
    groveVehs[12] = CreateVehicle(562, 2425.2075, -1636.3978, 13.0753, 180.8151, 86, 86, 900);
    for (new i; i < sizeof(groveVehs); i++)
    {
        isGroveGangVeh[groveVehs[i]] = true;
    }
    ballasVehs[1] = CreateVehicle(517, 2142.6514, -1413.9413, 24.6928, 89.5360, 242, 0, 900); // kola1 - ballas
    ballasVehs[2] = CreateVehicle(522, 2150.4158, -1412.9873, 25.4909, 181.1308, 242, 0, 900); // motor - ballas
    ballasVehs[3] = CreateVehicle(522, 2150.4785, -1416.4919, 25.4929, 180.3405, 242, 0, 900); // motor2 - ballas
    ballasVehs[4] = CreateVehicle(560, 2157.7717, -1423.7246, 25.2054, 89.1576, 242, 242, 900); // sultan - ballas
    ballasVehs[5] = CreateVehicle(536, 2141.6545, -1429.4076, 24.3500, 89.7899, 242, 242, 900); // kola2 - ballas
    ballasVehs[6] = CreateVehicle(566, 2155.0444, -1454.5491, 25.3726, 90.0047, 242, 242, 900); // kola3 - ballas
    ballasVehs[7] = CreateVehicle(576, 2162.3745, -1454.5953, 25.1046, 90.2217, 242, 242, 900); // kola4 - ballas
    ballasVehs[8] = CreateVehicle(487, 2163.9646, -1465.8907, 25.7057, 1.0011, 242, 0, 900); // heli - ballas
    ballasVehs[9] = CreateVehicle(411, 2130.9939, -1491.8048, 23.5404, 359.6788, 242, 242, 900); // infernus - ballas
    ballasVehs[10] = CreateVehicle(508, 2121.8989, -1495.8799, 24.3548, 323.1362, 242, 242, 900); // kola za interior - ballas
    ballascars10text = Create3DTextLabel("{C2A2DA}Само за Rolling Heights Ballas\n{00FF00}Натисни {FF0000}G {00FF00}за да влезеш в караваната.\nНатисни {FF0000}ENTER {00FF00}за да излезеш, когато си в нея.", 0x00FF00FF, 0.0, 0.0, 0.0, 15.0, 0, 1);
    Attach3DTextLabelToVehicle(ballascars10text, ballasVehs[10], 0.0, 0.0, 0.0);
    ballasVehs[11] = CreateVehicle(481, 2128.7788, -1497.3928, 23.4840, 358.7587, 242, 242, 900); // kolelo - ballas
    ballasVehs[12] = CreateVehicle(481, 2130.0701, -1497.3970, 23.4555, 1.2986, 242, 242, 900); // kolelo2 - ballas
    for (new i; i < sizeof(ballasVehs); i++)
    {
        isBallasGangVeh[ballasVehs[i]] = true;
    }
    vagosVehs[1] = CreateVehicle(474, 1880.3109, 2286.1875, 10.7425, 269.7603, 6, 6, 900); // vagos1
    vagosVehs[2] = CreateVehicle(412, 1909.2897, 2289.5784, 10.6562, 91.3783, 6, 6, 900); // vagos2
    vagosVehs[3] = CreateVehicle(541, 1912.0590, 2302.3689, 10.4453, 0.6415, 6, 6, 900); // bulleta
    vagosVehs[4] = CreateVehicle(534, 1911.9614, 2309.6794, 10.5437, 359.1782, 6, 6, 900); // vagos4
    vagosVehs[5] = CreateVehicle(411, 1912.0503, 2318.0942, 10.5474, 356.3801, 6, 6, 900); // vagos5
    vagosVehs[6] = CreateVehicle(560, 1912.1449, 2325.5798, 10.5248, 356.6646, 6, 6, 900); // vagos6
    vagosVehs[7] = CreateVehicle(411, 1909.1853, 2348.1267, 10.6149, 273.3006, 6, 6, 900); // infernus
    vagosVehs[8] = CreateVehicle(487, 1875.9656, 2290.4939, 16.1995, 269.9442, 6, 0, 900); // helivagos1
    vagosVehs[9] = CreateVehicle(487, 1875.6268, 2339.5623, 16.1990, 269.4076, 6, 0, 900); // helivagos2
    vagosVehs[10] = CreateVehicle(506, 1890.2362, 2323.3767, 10.5249, 180.8689, 6, 6, 900); // vagoscar
    for (new i; i < sizeof(vagosVehs); i++)
    {
        isVagosGangVeh[vagosVehs[i]] = true;
    }
    triadsVehs[1] = CreateVehicle(522, 1947.9634, 949.1880, 10.3873, 230.9314, 0, 0, 900); // triads2
    triadsVehs[2] = CreateVehicle(522, 1949.7938, 950.5921, 10.3918, 232.6649, 0, 0, 900); // triads1
    triadsVehs[3] = CreateVehicle(409, 1964.9244, 938.4307, 10.5423, 269.1901, 0, 0, 900); // triads3
    triadsVehs[4] = CreateVehicle(560, 1957.6072, 938.5424, 10.4487, 268.5377, 0, 0, 900); // triads4
    triadsVehs[5] = CreateVehicle(579, 1951.4574, 938.7516, 10.6755, 268.7814, 0, 0, 900); // triads5
    triadsVehs[6] = CreateVehicle(409, 1882.8169, 963.8494, 10.6203, 270.8264, 0, 0, 900); // triads6
    triadsVehs[7] = CreateVehicle(409, 1882.9513, 957.3453, 10.6203, 270.1068, 0, 0, 900); // triads7
    triadsVehs[8] = CreateVehicle(560, 1911.7120, 963.5993, 10.5250, 184.1433, 0, 0, 900); // triads8
    triadsVehs[9] = CreateVehicle(411, 1916.3330, 963.6063, 10.5474, 183.2727, 0, 0, 900); // triads9
    triadsVehs[10] = CreateVehicle(578, 1930.8434, 949.9053, 11.4402, 90.0164, 0, 0, 900); // triads10
    for (new i; i < sizeof(triadsVehs); i++)
    {
        isTriadsGangVeh[triadsVehs[i]] = true;
    }
    aztecasVehs[1] = CreateVehicle(560, 752.0851, -503.2887, 16.9567, 180.3046, 2, 2, 900); // sultan - aztecas
    aztecasVehs[2] = CreateVehicle(560, 752.1932, -495.7025, 17.0342, 179.0867, 2, 2, 900); // sultan2 - aztecas
    aztecasVehs[3] = CreateVehicle(522, 748.9619, -522.2308, 15.9083, 180.3538, 2, 2, 900); // motor - aztecas
    aztecasVehs[4] = CreateVehicle(522, 747.5856, -521.9755, 15.9080, 180.3337, 2, 2, 900); // motor2 - aztecas
    aztecasVehs[5] = CreateVehicle(579, 762.8350, -514.2790, 16.7327, 180.0451, 2, 2, 900); // djipka - aztecas
    aztecasVehs[6] = CreateVehicle(579, 762.8936, -506.9639, 17.2283, 179.3087, 2, 2, 900); // djipka2 - aztecas
    aztecasVehs[7] = CreateVehicle(567, 771.9294, -545.5295, 16.6317, 358.3828, 2, 2, 900); // kola - aztecas
    aztecasVehs[8] = CreateVehicle(411, 785.6984, -502.3122, 16.9807, 180.6297, 2, 2, 900); // infernus - aztecas
    aztecasVehs[9] = CreateVehicle(411, 785.8930, -510.4932, 16.5555, 181.4656, 2, 2, 900); // infernus - aztecas
    aztecasVehs[10] = CreateVehicle(487, 743.9529, -541.0137, 16.6115, 358.6243, 2, 2, 900); // heli - aztecas
    aztecasVehs[11] = CreateVehicle(562, 750.7774, -545.9088, 16.4508, 359.3824, 2, 2, 900); // elegy - aztecas
    aztecasVehs[12] = CreateVehicle(573, 726.5473, -516.5283, 16.9103, 179.7132, 2, 2, 900); // interior - aztecas
    aztecascars12text = Create3DTextLabel("{33CCFF}Само за Varrio Los Aztecas\n{00FF00}Натисни {FF0000}G {00FF00}за да влезеш в камиона.\nНатисни {FF0000}ENTER {00FF00}за да излезеш, когато си в него.", 0x00FF00FF, 0.0, 0.0, 0.0, 15.0, 0, 1);
    Attach3DTextLabelToVehicle(aztecascars12text, aztecasVehs[12], 0.0, 0.0, 0.0);
    for (new i; i < sizeof(aztecasVehs); i++)
    {
        isAztecasGangVeh[aztecasVehs[i]] = true;
    }
    italianVehs[1] = CreateVehicle(533, -689.1786, 968.2943, 11.8831, 93.4251, 0, 0, 900); // Italian Mafia Car1
    italianVehs[2] = CreateVehicle(445, -688.9850, 963.5048, 12.0415, 88.5025, 0, 0, 900); // Italian Mafia Car2
    italianVehs[3] = CreateVehicle(579, -679.3967, 963.2996, 12.0695, 89.6264, 0, 0, 900); // Italian Mafia Car3
    italianVehs[4] = CreateVehicle(579, -679.9169, 968.8642, 12.0639, 92.4501, 0, 0, 900); // Italian Mafia Car4
    italianVehs[5] = CreateVehicle(487, -656.1565, 954.9906, 12.2760, 178.0132, 0, 0, 900); // Italian Mafia Car5
    italianVehs[6] = CreateVehicle(421, -674.0872, 946.0048, 12.0159, 28.7546, 0, 0, 900); // Italian Mafia Car6
    italianVehs[7] = CreateVehicle(545, -682.3112, 946.6027, 11.9397, 23.2160, 0, 0, 900); // Italian Mafia Car7
    italianVehs[8] = CreateVehicle(522, -693.6101, 944.4960, 11.8058, 271.0218, 0, 0, 900); // Italian Mafia Car8
    italianVehs[9] = CreateVehicle(522, -690.4867, 944.4437, 11.7571, 88.6222, 0, 0, 900); // Italian Mafia Car9
    for (new i; i < sizeof(italianVehs); i++)
    {
        isItalianGangVeh[italianVehs[i]] = true;
    }
    nangVehs[1] = CreateVehicle(487, 2622.4138, 1879.6233, 10.9970, 178.6253, 21, 21, 900); // nang1
    nangVehs[2] = CreateVehicle(409, 2619.7512, 1833.4093, 10.7184, 178.8567, 21, 21, 900); // nang2
    nangVehs[3] = CreateVehicle(409, 2619.5876, 1816.2043, 10.7149, 179.8992, 21, 21, 900); // nang3
    nangVehs[4] = CreateVehicle(522, 2633.1260, 1837.3751, 10.4041, 92.0362, 21, 21, 900); // nang4
    nangVehs[5] = CreateVehicle(522, 2633.3562, 1838.3010, 10.4482, 85.0043, 21, 21, 900); // nang5
    nangVehs[6] = CreateVehicle(518, 2631.2344, 1808.0491, 10.4913, 92.0208, 21, 21, 900); // nang6
    nangVehs[7] = CreateVehicle(560, 2630.7720, 1858.4489, 10.5257, 88.0735, 21, 21, 900); // nang7
    nangVehs[8] = CreateVehicle(562, 2630.7546, 1855.1859, 10.4795, 91.5200, 21, 21, 900); // nang8
    nangVehs[9] = CreateVehicle(559, 2631.0073, 1852.1052, 10.4766, 86.3341, 21, 21, 900); // nang9
    nangVehs[10] = CreateVehicle(567, 2602.9399, 1802.3368, 10.6974, 88.6509, 21, 21, 900); // nang10
    for (new i; i < sizeof(nangVehs); i++)
    {
        isNangGangVeh[nangVehs[i]] = true;
    }
    soaVehs[1] = CreateVehicle(463, 2607.5100, 2328.5344, 10.3606, 209.8055, 0, 0, 900); // soa1
    soaVehs[2] = CreateVehicle(463, 2609.4705, 2328.9753, 10.3566, 208.2699, 0, 0, 900); // soa2
    soaVehs[3] = CreateVehicle(463, 2610.9456, 2329.4771, 10.3568, 209.6774, 0, 0, 900); // soa3
    soaVehs[4] = CreateVehicle(463, 2612.0383, 2329.6987, 10.3569, 209.8093, 0, 0, 900); // soa4
    soaVehs[5] = CreateVehicle(463, 2613.3054, 2330.0266, 10.3569, 206.1571, 0, 0, 900); // soa5
    soaVehs[6] = CreateVehicle(463, 2614.3750, 2330.3340, 10.3566, 206.5669, 0, 0, 900); // soa6
    soaVehs[7] = CreateVehicle(461, 2619.5137, 2330.8586, 10.4088, 188.5789, 0, 0, 900); // soa7
    soaVehs[8] = CreateVehicle(554, 2624.4563, 2343.3042, 10.8312, 39.4545, 79, 0, 900); // soa8
    soaVehs[9] = CreateVehicle(554, 2640.7495, 2349.6467, 10.7933, 220.9568, 79, 0, 900); // soa9
    soaVehs[10] = CreateVehicle(434, 2632.3479, 2350.0049, 10.7170, 118.1949, 0, 0, 900); // soa10
    for (new i; i < sizeof(soaVehs); i++)
    {
        isSoaGangVeh[soaVehs[i]] = true;
    }
    rifaVehs[1] = CreateVehicle(496, -2197.5461, 965.4709, 79.7530, 270.4769, 152, 152, 900); // rifacar
    rifaVehs[2] = CreateVehicle(560, -2197.2048, 971.6678, 79.6639, 271.0227, 152, 152, 900); // rifacar
    rifaVehs[3] = CreateVehicle(560, -2197.3442, 977.9351, 79.6632, 271.3475, 152, 152, 900); // rifacar
    rifaVehs[4] = CreateVehicle(411, -2197.3025, 983.6387, 79.7338, 269.3553, 152, 152, 900); // rifacar
    rifaVehs[5] = CreateVehicle(567, -2196.9644, 989.8078, 79.8977, 269.2165, 152, 152, 900); // rifacar
    rifaVehs[6] = CreateVehicle(541, -2197.5020, 996.1154, 79.6346, 270.3678, 152, 152, 900); // rifacar
    rifaVehs[7] = CreateVehicle(495, -2197.2754, 1002.1566, 80.2880, 270.2743, 152, 152, 900); // rifacar
    rifaVehs[8] = CreateVehicle(522, -2198.6465, 1007.2259, 79.5743, 270.2843, 152, 152, 900); // rifacar
    rifaVehs[9] = CreateVehicle(522, -2198.4402, 1008.5887, 79.5686, 269.3019, 152, 152, 900); // rifacar
    rifaVehs[10] = CreateVehicle(487, -2214.6382, 1049.4929, 80.1886, 180.5292, 152, 152, 900); // rifacar
    rifaVehs[11] = CreateVehicle(513, -2205.5764, 973.1305, 85.4048, 2.3496, 0, 152, 900); // rifacar
    for (new i; i < sizeof(rifaVehs); i++)
    {
        isRifaGangVeh[rifaVehs[i]] = true;
    }

    // ID 411 (Infernus) - в началото
    intensePDVehs[0] = CreateVehicle(411, 1536.1382, -1670.6512, 13.0512, 0.7688, 0, 0, 900); // lspd
    intensePDVehs[1] = CreateVehicle(411, -1602.8589, 723.5639, 11.1457, 270.0789, 0, 0, 900);  // heli 1
    intensePDVehs[2] = CreateVehicle(411, -1609.1545, 723.7385, 12.2860, 270.2191, 0, 0, 900);  // heli 1
    intensePDVehs[3] = CreateVehicle(411, -1573.7810, 710.2883, -5.5151, 268.2603, 0, 0, 900); // sfp12
    intensePDVehs[4] = CreateVehicle(411, -1608.4790, 692.5464, -5.5151, 180.8416, 0, 0, 900);  // sfp13
    intensePDVehs[5] = CreateVehicle(411, -1616.5317, 691.5095, -5.5151, 179.1578, 0, 0, 900); 

    // ID 522 - след това
    intensePDVehs[6] = CreateVehicle(522, 1578.6757, -1604.5576, 12.8507, 165.8881, 0, 0, 900); // lspd - sirena
    intensePDVehs[7] = CreateVehicle(522, 1541.5675, -1660.5764, 13.1191, 50.8811, 0, 0, 900); // lspd
    intensePDVehs[8] = CreateVehicle(522, 1540.3372, -1663.0706, 13.1191, 63.9225, 0, 0, 900); // lspd
    intensePDVehs[9] = CreateVehicle(522, -1625.6361, 692.4774, -5.6904, 0.0000, 0, 0, 900); 
    intensePDVehs[10] = CreateVehicle(522, -1627.1006, 691.9947, -5.6656, 6.8663, 0, 0, 900); 
    intensePDVehs[11] = CreateVehicle(522, -1628.2644, 692.0035, -5.6862, 11.3340, 0, 0, 900); 

    // ID 560 - след това
    intensePDVehs[12] = CreateVehicle(560, 1536.1824, -1676.4670, 13.0971, 358.1916, 0, 0, 900); // lpd
    intensePDVehs[13] = CreateVehicle(560, 2294.8218, 2418.4224, 10.4658, 90.3843, 0, 0, 900); 
    intensePDVehs[14] = CreateVehicle(560, 2287.3413, 2418.2878, 10.4668, 91.5691, 0, 0, 900); 
    intensePDVehs[15] = CreateVehicle(560, 2279.9746, 2418.1211, 10.4656, 88.7879, 0, 0, 900); 
    intensePDVehs[16] = CreateVehicle(560, 2273.6748, 2418.1306, 10.4486, 90.6060, 0, 0, 900); 

    // Всички останали превозни средства
    intensePDVehs[17] = CreateVehicle(487, 1518.5498, -1657.1406, 13.6963, 268.7212, 0, 0, 900); // lspd heli
    intensePDVehs[18] = CreateVehicle(523, 1581.5049, -1604.4323, 12.9482, 157.5093, 1, 1, 900); // lspd
    intensePDVehs[19] = CreateVehicle(523, 1584.8009, -1604.6736, 12.9451, 146.7304, 0, 1, 900); // lspd
    intensePDVehs[20] = CreateVehicle(596, 1602.4288, -1615.0887, 13.1566, 89.2218, 0, 1, 900); // lspd
    intensePDVehs[21] = CreateVehicle(596, 1602.4105, -1620.5344, 13.1169, 91.2412, 0, 1, 900); // lspd
    intensePDVehs[22] = CreateVehicle(599, 1602.5525, -1630.8962, 13.6331, 87.6259, 0, 1, 900); // lspd
    intensePDVehs[23] = CreateVehicle(525, 1545.2478, -1609.5088, 13.2090, 268.9330, 53, 53, 900); // lspd tow truckl
    intensePDVehs[24] = CreateVehicle(599, 1602.6306, -1625.6815, 13.6845, 91.4508, 0, 1, 900); // veh new
    intensePDVehs[25] = CreateVehicle(497, -1673.6982, 697.5632, 30.7748, 87.0447, 0, 0, 900);  // heli 1
    intensePDVehs[26] = CreateVehicle(497, -1672.6749, 711.7892, 30.7710, 90.9230, 0, 0, 900);  // heli 2
    intensePDVehs[27] = CreateVehicle(497, -1688.7531, 704.7490, 30.8516, 0.0001, 0, 0, 900);  // heli 3
    intensePDVehs[28] = CreateVehicle(597, -1589.5455, 673.4875, 6.9573, 357.5952, 2, 1, 900);  // sfp1
    intensePDVehs[29] = CreateVehicle(597, -1594.3623, 673.0530, 6.9556, 357.5556, 2, 1, 900);  // sfp2
    intensePDVehs[30] = CreateVehicle(597, -1600.7976, 672.3998, 6.9558, 356.8631, 2, 1, 900);  // sfp3
    intensePDVehs[31] = CreateVehicle(601, -1616.9824, 651.7155, 6.9463, 179.8854, 0, 0, 900);  // sfp4
    intensePDVehs[32] = CreateVehicle(601, -1592.9884, 651.9330, 6.9463, 180.6861, 0, 0, 900);  // sfp5
    intensePDVehs[33] = CreateVehicle(581, -1581.0945, 674.6801, 6.7885, 358.0248, 0, 0, 900);  // sfp6
    intensePDVehs[34] = CreateVehicle(581, -1580.0282, 674.6340, 6.7739, 0.0020, 0, 0, 900);  // sfp7
    intensePDVehs[35] = CreateVehicle(581, -1582.3605, 674.4676, 6.7772, 7.3160, 0, 0, 900);  // sfp8
    intensePDVehs[36] = CreateVehicle(528, -1612.8768, 731.7792, -5.1970, 179.8327, 0, 0, 900);  // sfp9
    intensePDVehs[37] = CreateVehicle(528, -1600.6814, 750.5339, -5.1983, 359.3145, 0, 0, 900);  // sfp10
    intensePDVehs[38] = CreateVehicle(528, -1604.6685, 750.1108, -5.1990, 0.7827, 0, 0, 900);  // sfp11
    intensePDVehs[39] = CreateVehicle(598, 2251.6960, 2461.1604, 10.5647, 0.7289, 0, 1, 900);  // policecar1
    intensePDVehs[40] = CreateVehicle(598, 2281.7688, 2477.1084, 10.5665, 359.6116, 0, 1, 900);  // policecar2
    intensePDVehs[41] = CreateVehicle(599, 2278.2905, 2443.0581, 11.0037, 359.6354, 0, 1, 900);  // policecar3
    intensePDVehs[42] = CreateVehicle(599, 2269.5115, 2442.8984, 11.0052, 0.0001, 0, 1, 900);  // policecar4
    intensePDVehs[43] = CreateVehicle(427, 2313.4092, 2490.0430, 3.4570, 89.8919, 0, 1, 900);  // policecar5
    intensePDVehs[44] = CreateVehicle(427, 2300.4929, 2456.4758, 3.4689, 270.9489, 0, 1, 900);  // policecar6
    intensePDVehs[45] = CreateVehicle(601, 2315.9565, 2470.5745, 3.0322, 89.3433, 0, 1, 900);  // policecar7
    intensePDVehs[46] = CreateVehicle(598, 2241.8032, 2437.7478, 3.0233, 270.0572, 0, 1, 900);  // policecar8
    intensePDVehs[47] = CreateVehicle(523, 2277.7908, 2476.9065, 10.3955, 3.4096, 0, 1, 900);  // bike1
    intensePDVehs[48] = CreateVehicle(523, 2251.6497, 2441.2209, 10.3816, 181.8576, 0, 1, 900);  // bike2
    intensePDVehs[49] = CreateVehicle(497, 2312.0928, 2452.2563, 10.9972, 179.6904, 0, 1, 900);  // hili


    for (new i = 17; i <= 49; i++)
    {
        isIntensePDGangVehDUTY[intensePDVehs[i]] = true;
    }
    for (new i; i < sizeof(intensePDVehs); i++)
    {
        isIntensePDGangVeh[intensePDVehs[i]] = true;
    }

    crewVehs[1] = CreateVehicle(411, 311.4506, -1328.3651, 53.1399, 75.1864, 11, 11, 900); // nova
    crewVehs[2] = CreateVehicle(560, 312.0785, -1331.8235, 53.1406, 72.4239, 11, 11, 900); // nova
    crewVehs[3] = CreateVehicle(522, 295.1516, -1337.9702, 53.0159, 29.9148, 11, 11, 900); // nova
    crewVehs[4] = CreateVehicle(522, 294.4095, -1338.3842, 53.0166, 33.3519, 11, 11, 900); // nova
    crewVehs[5] = CreateVehicle(556, 291.3259, -1338.8458, 53.8150, 30.4666, 11, 11, 900); // nova
    crewVehs[6] = CreateVehicle(562, 283.6886, -1337.2506, 53.0961, 334.5271, 11, 11, 900); // nova
    crewVehs[7] = CreateVehicle(562, 299.2004, -1321.4900, 53.1074, 175.4064, 11, 11, 900); // nova
    crewVehs[8] = CreateVehicle(522, 304.9951, -1318.8513, 53.0205, 174.2306, 11, 11, 900); // nova
    crewVehs[9] = CreateVehicle(522, 305.8908, -1319.0862, 53.0156, 177.7132, 11, 11, 900); // nova

    for (new i; i < sizeof(crewVehs); i++)
    {
        isCrewGangVeh[crewVehs[i]] = true;
    }
    thugLifeVehs[1] = CreateVehicle(536, 499.1353, -1546.9138, 17.6004, 33.6026, 210, 210, 900); // car1
    thugLifeVehs[2] = CreateVehicle(411, 484.7022, -1538.8474, 18.8513, 23.5399, 210, 210, 900); // car1
    thugLifeVehs[3] = CreateVehicle(566, 489.4933, -1524.2977, 19.7925, 16.1943, 210, 210, 900); // car1
    thugLifeVehs[4] = CreateVehicle(482, 474.8501, -1511.5087, 20.6526, 305.0338, 210, 210, 900); // car1
    thugLifeVehs[5] = CreateVehicle(567, 488.0786, -1501.9819, 20.3090, 353.0443, 210, 210, 900); // car1
    thugLifeVehs[6] = CreateVehicle(522, 476.4594, -1488.7264, 19.7806, 279.6104, 210, 0, 900); // car1
    thugLifeVehs[7] = CreateVehicle(522, 475.9096, -1487.0114, 19.7075, 287.6581, 210, 0, 900); // car1
    thugLifeVehs[8] = CreateVehicle(566, 491.3945, -1482.8320, 19.4348, 15.3997, 210, 210, 900); // car1
    thugLifeVehs[9] = CreateVehicle(517, 487.2245, -1467.0896, 18.4881, 338.8649, 210, 0, 900); // car1
    thugLifeVehs[10] = CreateVehicle(560, 496.0072, -1470.9349, 18.3100, 332.8391, 210, 210, 900);

    for (new i; i < sizeof(thugLifeVehs); i++)
    {
        isThugLifeGangVeh[thugLifeVehs[i]] = true;
    }
    bountyVehs[1] = CreateVehicle(411, 660.6033, -1283.4000, 13.2719, 180.1347, 154, 154, 900); // bhunters1
    bountyVehs[2] = CreateVehicle(579, 660.3755, -1276.7418, 13.4738, 183.3500, 154, 154, 900); // bhunters2
    bountyVehs[3] = CreateVehicle(562, 660.0196, -1270.5104, 13.2035, 181.9810, 154, 154, 900); // bhunters3
    bountyVehs[4] = CreateVehicle(560, 669.5075, -1282.5005, 13.2498, 180.0450, 154, 154, 900); // bhunters4
    bountyVehs[5] = CreateVehicle(409, 669.4095, -1274.9530, 13.3426, 179.6351, 154, 154, 900); // bhunters5
    bountyVehs[6] = CreateVehicle(560, 669.6331, -1266.8650, 13.2453, 178.6060, 154, 154, 900); // bhunters6
    bountyVehs[7] = CreateVehicle(481, 688.2662, -1286.6830, 13.0898, 117.8503, 154, 154, 900); // bhunters7
    bountyVehs[8] = CreateVehicle(481, 688.2577, -1287.6053, 13.0891, 125.6551, 154, 154, 900); // bhunters8
    bountyVehs[9] = CreateVehicle(487, 742.4998, -1259.4336, 13.7324, 269.1596, 154, 154, 900); // bhunters9
    bountyVehs[10] = CreateVehicle(487, 765.3352, -1259.5431, 13.7472, 266.0747, 154, 154, 900); // bhunters10
    for (new i; i < sizeof(bountyVehs); i++)
    {
        isBountyGangVeh[bountyVehs[i]] = true;
    }
    cripzVehs[1] = CreateVehicle(411, 282.6102, -1160.0824, 80.6411, 225.3297, 53, 53, 900); // infernus - vcripz
    cripzVehs[2] = CreateVehicle(411, 286.7418, -1156.0349, 80.6380, 225.1132, 53, 53, 900); // infernus2 - vcripz
    cripzVehs[3] = CreateVehicle(487, 263.3456, -1171.7356, 79.6268, 278.1578, 53, 53, 900); // heli - cripz
    cripzVehs[4] = CreateVehicle(560, 278.0644, -1174.9341, 80.4535, 288.3980, 53, 53, 900); // sultan - vcripz
    cripzVehs[5] = CreateVehicle(560, 280.8209, -1177.5951, 80.5118, 290.0709, 53, 53, 900); // sultan2 - vcripz
    cripzVehs[6] = CreateVehicle(562, 286.8073, -1183.2435, 80.5736, 290.7241, 53, 53, 900); // elegy - cripz
    cripzVehs[7] = CreateVehicle(562, 283.8889, -1180.3596, 80.5570, 292.7408, 53, 53, 900); // elegy2 - cripz
    cripzVehs[8] = CreateVehicle(541, 273.3555, -1159.8564, 80.5399, 224.3608, 53, 53, 900); // kola - vcripz
    cripzVehs[9] = CreateVehicle(573, 288.1286, -1147.2111, 81.5615, 222.8329, 53, 53, 900); // interior - vcripz
    cripzcars9text = Create3DTextLabel("{000099}Само за Vinewood Cripz\n{00FF00}Натисни {FF0000}G {00FF00}за да влезеш в камиона.\nНатисни {FF0000}ENTER {00FF00}за да излезеш, когато си в него.", 0x00FF00FF, 0.0, 0.0, 0.0, 15.0, 0, 1);
    Attach3DTextLabelToVehicle(cripzcars9text, cripzVehs[9], 0.0, 0.0, 0.0);
    cripzVehs[10] = CreateVehicle(522, 305.4707, -1159.1051, 80.4810, 131.6496, 53, 53, 900); // motor - vcripz
    cripzVehs[11] = CreateVehicle(522, 304.4301, -1157.9576, 80.4809, 136.7975, 53, 53, 900); // motor2 - vcripz
    cripzVehs[12] = CreateVehicle(579, 317.2428, -1166.5176, 80.8455, 133.5803, 53, 53, 900); // djip - vcripz
    for (new i; i < sizeof(cripzVehs); i++)
    {
        isCripzGangVeh[cripzVehs[i]] = true;
    }
    AddStaticVehicleEx(537, 602.2946, 1285.0413, 13.3495, 300.1335, 1, 1, 900); // veh
    AddStaticVehicleEx(538, 2864.7500, 1343.2275, 12.1256, 0.0000, 1, 1, 900); // vlak
    AddStaticVehicleEx(449, 1449.6514, 2632.2500, 11.2473, 270.0000, 1, 74, 900); // 2
    AddStaticVehicleEx(449, 1417.1182, 2632.2500, 11.2473, 90.0000, 1, 74, 900); // 1
    CreateVehicle(492, 771.5253, -1334.1238, 13.2469, 359.8254, 64, 0, 900);
    CreateVehicle(467, 1376.2993, -993.1086, 29.0882, 354.3479, 48, 0, 900); // car1
    CreateVehicle(420, 2200.8689, 1277.5786, 10.6284, 90.6522, 6, 6, 900); // car1
    CreateVehicle(559, 2201.0156, 1285.6396, 10.4998, 90.2617, 11, 11, 900); // car2
    CreateVehicle(420, 2200.7776, 1293.7927, 10.6284, 89.2013, 6, 6, 900); // car3
    CreateVehicle(416, 1177.6736, -1308.3738, 13.9052, 269.5979, 1, 3, 900); // car
    CreateVehicle(463, 1419.7723, -1323.8895, 13.0992, 85.9360, 46, 0, 900); // car
    CreateVehicle(471, 1250.3735, -1229.2214, 13.0730, 183.1282, 51, 51, 900); // car
    CreateVehicle(522, 2099.8950, 943.9579, 10.3912, 268.7346, 5, 85, 900); // car
    CreateVehicle(521, 1994.6298, 1075.9277, 10.3904, 354.3320, 5, 6, 900); // car
    CreateVehicle(603, 1866.7584, 1179.1772, 10.5856, 179.8083, 0, 1, 900); // car
    CreateVehicle(471, 1707.7780, 1253.3064, 10.1819, 1.6518, 1, 3, 900); // car
    CreateVehicle(445, 1685.8378, 1316.6997, 10.6322, 179.6370, 66, 66, 900); // car
    CreateVehicle(541, 1640.8036, 1296.2123, 10.3646, 269.7993, 16, 0, 900); // car
    CreateVehicle(438, 1701.2408, 1406.9891, 10.5765, 322.9780, 6, 6, 900); // car
    CreateVehicle(420, 1698.8855, 1420.6882, 10.5292, 312.4913, 6, 6, 900); // car
    CreateVehicle(587, 1698.1412, 1471.9504, 10.4319, 262.1092, 98, 98, 900); // car
    CreateVehicle(522, 1698.4799, 1482.5646, 10.3257, 257.0431, 3, 1, 900); // car
    CreateVehicle(560, 1704.2808, 1498.6833, 10.4875, 245.7231, 80, 80, 900); // car
    CreateVehicle(416, 1624.0270, 1822.6215, 10.8584, 1.9184, 1, 3, 900); // car
    CreateVehicle(416, 1591.6675, 1821.1727, 11.0130, 359.5998, 3, 1, 900); // car
    CreateVehicle(468, 1609.7186, 1851.3127, 10.4882, 182.6533, 6, 6, 900); // car
    CreateVehicle(411, 1673.1298, 1834.5892, 10.4783, 179.0714, 61, 61, 900); // car
    CreateVehicle(451, 1685.2889, 1851.3425, 10.4465, 89.9739, 114, 114, 900); // car
    CreateVehicle(506, 1742.8035, 1912.5298, 10.4819, 271.3684, 3, 3, 900); // car
    CreateVehicle(544, 1763.7312, 2074.6404, 10.9848, 181.4266, 3, 3, 900); // car
    CreateVehicle(407, 1757.2053, 2075.1086, 10.9696, 180.9546, 3, 3, 900); // car
    CreateVehicle(522, 1527.8496, 2204.9924, 10.3920, 181.4801, 0, 0, 900); // car
    CreateVehicle(541, 1386.1497, 2249.2932, 10.4589, 89.6190, 3, 4, 900); // car
    CreateVehicle(506, 442.9023, -1802.7012, 5.2099, 354.2754, 72, 0, 900);
    CreateVehicle(562, 1465.7566, 2352.7119, 10.4478, 357.7283, 3, 4, 900); // car
    CreateVehicle(471, 1806.2070, 2623.6116, 10.2252, 178.7413, 6, 0, 900); // car
    CreateVehicle(481, 959.9683, -1522.0959, 13.0149, 359.8105, 57, 0, 900);
    CreateVehicle(418, 1849.3011, 2578.9045, 10.8492, 0.3017, 7, 7, 900); // car
    CreateVehicle(521, 367.5635, -1340.2676, 14.1076, 119.6715, 80, 0, 900);
    CreateVehicle(477, 1110.8416, -1630.7823, 13.2713, 90.0069, 53, 0, 900);
    CreateVehicle(507, 343.8066, -1808.6891, 4.2620, 179.5384, 73, 0, 900);
    CreateVehicle(522, 361.6628, -2029.4879, 7.3878, 307.3224, 43, 43, 900); //
    CreateVehicle(462, 361.6710, -2033.1227, 7.4226, 310.4334, 33, 33, 900); //
    CreateVehicle(510, 183.8260, -1581.6919, 13.1857, 48.3526, 76, 0, 900);
    CreateVehicle(411, 374.7554, -2024.4861, 7.4067, 357.6782, 50, 50, 900); //
    CreateVehicle(560, 375.0436, -2015.5992, 7.3990, 359.3605, 3, 3, 900); //
    CreateVehicle(462, 1422.0930, 2842.7683, 10.4136, 243.2839, 44, 44, 900); // car
    CreateVehicle(518, 437.6488, -1295.2046, 14.8682, 32.1277, 79, 0, 900);
    CreateVehicle(533, 1470.1700, 2839.4609, 10.5652, 180.2008, 12, 12, 900); // car
    CreateVehicle(415, 1529.5582, 2827.1646, 10.5410, 89.7498, 6, 6, 900); // car
    CreateVehicle(603, 1527.8746, 2858.9084, 10.6582, 265.3276, 125, 0, 900); // car
    CreateVehicle(439, 1682.0747, 2762.7502, 10.6553, 179.5395, 65, 65, 900); // car
    CreateVehicle(549, 2531.2766, 2511.3635, 10.4234, 91.4351, 2, 4, 900); // car
    CreateVehicle(535, 2460.6541, 2528.2312, 10.4951, 1.5184, 3, 3, 900); // car
    CreateVehicle(477, 2402.5583, 2557.0559, 10.6130, 270.3061, 1, 1, 900); // car
    CreateVehicle(562, 2239.6018, 2235.8860, 10.4459, 269.6897, 3, 0, 900); // car
    CreateVehicle(560, 2503.9712, 2238.2419, 10.3764, 89.0506, 0, 5, 900); // car
    CreateVehicle(522, 2441.2786, 2013.2446, 10.3922, 268.6646, 66, 66, 900); // car
    CreateVehicle(536, 2486.2520, 1991.3601, 10.6100, 359.6808, 6, 7, 900); // car
    CreateVehicle(559, 2363.2822, 2089.0911, 10.4186, 1.2506, 254, 2, 900); // car
    CreateVehicle(521, 2236.4492, 2130.2256, 10.3938, 271.5005, 3, 4, 900); // car
    CreateVehicle(510, 2100.4424, 2169.3293, 10.4026, 2.0098, 3, 0, 900); // car
    CreateVehicle(475, 2102.9392, 2082.5645, 10.6711, 89.0067, 0, 0, 900); // car
    CreateVehicle(411, 2186.5762, 1974.9695, 10.4760, 89.0564, 158, 158, 900); // car
    CreateVehicle(579, 2203.2639, 1788.1034, 10.6066, 1.9540, 17, 17, 900); // car
    CreateVehicle(461, 2156.2139, 1788.2894, 10.4033, 0.1878, 12, 12, 900); // car
    CreateVehicle(542, 2174.2043, 1821.9380, 10.5990, 179.8946, 22, 22, 900); // car
    CreateVehicle(422, 2604.6572, 1378.2987, 10.7430, 89.8924, 56, 4, 900); // car
    CreateVehicle(578, 2647.7517, 813.0166, 6.0297, 90.5862, 4, 4, 900); // car
    CreateVehicle(551, 2647.5747, 744.8439, 10.6319, 181.4257, 67, 67, 900); // car
    CreateVehicle(424, 981.2684, -1332.2112, 13.2060, 273.1884, 22, 22, 900); // car
    CreateVehicle(434, 1016.4972, -1360.9585, 13.2592, 90.3659, 100, 100, 900); // car2
    CreateVehicle(461, 2540.3374, 741.3383, 10.4002, 272.2441, 25, 25, 900); // car
    CreateVehicle(461, 1553.9242, -1785.0142, 13.1305, 90.0535, 43, 0, 900); // car
    CreateVehicle(475, 974.3016, -1305.6052, 13.2307, 179.8655, 131, 131, 900);
    CreateVehicle(570, 1749.2616, -1953.7760, 14.9954, 269.9383, 1, 1, 900); // train LS
    //vehicles - location - close
    CreateServerObjects();
    //CreateObject(16773, 2335.417236, 2484.029785, 6.957778,  0.000000,0.000000,89.1308);
    //CreateObject(16773, 2335.417236, 2484.029785, 0.557772,  0.000000,0.000000,89.1308);
    //objects - location - close
    //respawn cars - location - open
    for (new cars = 0; cars < MAX_VEHICLES; cars++)
    {
        SetVehicleToRespawn(cars);
    }
    //respawn cars - location - close
    LockAllJobVehicles();
    return 1;
}
public OnGameModeExit()
{

    for (new i; i < MAX_PLAYERS; i++)
    {
        SavePlayerStats(i);
    }
    for (new i; i < MAX_PLAYERS; i++)
    {
        //reststats - location 2 - open
        logged[i] = 0;
        loadedtexts[i] = 0;
        firstspawn[i] = 1;
        wrongpassword[i] = 0;
        para1[i] = -1;
        //reststats - location 2 - close
        //resttexts - location 2 - open
        TextDrawHideForPlayer(i, Intro[0]);
        TextDrawHideForPlayer(i, Intro[1]);
        TextDrawHideForPlayer(i, Intro[2]);
        TextDrawHideForPlayer(i, Intro[3]);
        TextDrawHideForPlayer(i, Intro[4]);
        TextDrawHideForPlayer(i, Intro[5]);
        //TextDrawHideForPlayer(i, Clock);
        TextDrawHideForPlayer(i, epText[i]);
        TextDrawHideForPlayer(i, levelText[i]);
        TextDrawHideForPlayer(i, epsText[i]);
        TextDrawHideForPlayer(i, msText[i]);
        //resttexts - location 2 - close
        //resttimers - location 2 - openp
        PlayerInfo[i][pFuel] = 0;
        PlayerInfo[i][pKick] = 0;
        PlayerInfo[i][pFixT] = 0;
        PlayerInfo[i][pHealT] = 0;
        PlayerInfo[i][pVGuns] = 0;
        PlayerInfo[i][pRefuel20LitTimer] = 0;
        PlayerInfo[i][pBan] = 0;
        PlayerInfo[i][pAFKBack] = 0;
        PlayerInfo[i][pStartIntro] = 0;
        PlayerInfo[i][pTextSpamTimer] = 0;
        PlayerInfo[i][pCommandSpamTimer] = 0;
        PlayerInfo[i][pIntro] = 0;
        PlayerInfo[i][pIntro1] = 0;
        PlayerInfo[i][pIntro2] = 0;
        PlayerInfo[i][pIntro3] = 0;
        PlayerInfo[i][pIntro4] = 0;
        PlayerInfo[i][pIntro5] = 0;
        PlayerInfo[i][pIntro6] = 0;
        //resttimers - location 2 - close
    }
    CloseDB();
    return 1;
}



public OnPlayerRequestClass(playerid, classid)
{
    firstskin[playerid] = classid;
    spawned[playerid] = 29;
    SetPVarInt(playerid, "color", 0);
    if (nospawnselect[playerid] == 1)
    {
        SpawnPlayer(playerid);
        SpawnPlayer(playerid);
        nospawnselect[playerid] = 2;
    }
    switch (classid)
    {
        case 0..2:
        {
            SetPlayerPos(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerCameraPos(playerid, 2179.9398, 1284.6965, 43.4799);
            SetPlayerCameraLookAt(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerFacingAngle(playerid, 88.68);
            GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~Drug Dealer", 2300, 3);
        }
        case 3..6:
        {
            SetPlayerPos(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerCameraPos(playerid, 2179.9398, 1284.6965, 43.4799);
            SetPlayerCameraLookAt(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerFacingAngle(playerid, 88.68);
            GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~Drug Maker", 2300, 3);
        }
        case 7..10:
        {
            SetPlayerPos(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerCameraPos(playerid, 2179.9398, 1284.6965, 43.4799);
            SetPlayerCameraLookAt(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerFacingAngle(playerid, 88.68);
            GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Normal Ped Man", 2300, 3);
        }
        case 11..12:
        {
            SetPlayerPos(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerCameraPos(playerid, 2179.9398, 1284.6965, 43.4799);
            SetPlayerCameraLookAt(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerFacingAngle(playerid, 88.68);
            GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Normal Ped Woman", 2300, 3);
        }
        case 13:
        {
            SetPlayerPos(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerCameraPos(playerid, 2179.9398, 1284.6965, 43.4799);
            SetPlayerCameraLookAt(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerFacingAngle(playerid, 88.68);
            GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~BUSSINESMAN", 2300, 3);
        }
        case 14:
        {
            SetPlayerPos(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerCameraPos(playerid, 2179.9398, 1284.6965, 43.4799);
            SetPlayerCameraLookAt(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerFacingAngle(playerid, 88.68);
            GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~BUSSINESWOMAN", 2300, 3);
        }
        case 15..17:
        {
            SetPlayerPos(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerCameraPos(playerid, 2179.9302, 1284.6965, 43.4799);
            SetPlayerCameraLookAt(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerFacingAngle(playerid, 88.68);
            GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~p~PROSTITUTE", 2300, 3);
        }
        case 18..23:
        {
            SetPlayerPos(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerCameraPos(playerid, 2179.9398, 1284.6965, 43.4799);
            SetPlayerCameraLookAt(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerFacingAngle(playerid, 88.68);
            GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~p~WOMAN", 2300, 3);
        }
    }
    return 1;
}
public ReSpawnTimer(playerid)
{
    requestspawn2[playerid] = 0;
    SpawnPlayer(playerid);
    return 1;
}
public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if (GetPVarInt(playerid, "skinc_active") == 0) return 0;
    if (clickedid == Text:INVALID_TEXT_DRAW)
    {
        DestroySelectionMenu(playerid);
        SetPVarInt(playerid, "skinc_active", 0);
        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
        return 1;
    }
    return 0;
}
public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if (GetPVarInt(playerid, "skinc_active") == 0) return 0;
    new curpage = GetPVarInt(playerid, "skinc_page");
    if (playertextid == gNextButtonTextDrawId[playerid])
    {
        if (curpage < (GetNumberOfPages() - 1))
        {
            SetPVarInt(playerid, "skinc_page", curpage + 1);
            ShowPlayerModelPreviews(playerid);
            UpdatePageTextDraw(playerid);
            PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
        }
        else
        {
            PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
        }
        return 1;
    }
    if (playertextid == gPrevButtonTextDrawId[playerid])
    {
        if (curpage > 0)
        {
            SetPVarInt(playerid, "skinc_page", curpage - 1);
            ShowPlayerModelPreviews(playerid);
            UpdatePageTextDraw(playerid);
            PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
        }
        else
        {
            PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
        }
        return 1;
    }
    new x = 0;
    while (x != SELECTION_ITEMS)
    {
        if (playertextid == gSelectionItems[playerid][x])
        {
            HandlePlayerItemSelection(playerid, x);
            PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
            DestroySelectionMenu(playerid);
            CancelSelectTextDraw(playerid);
            SetPVarInt(playerid, "skinc_active", 0);
            return 1;
        }
        x++;
    }
    return 0;
}

public OnPlayerConnect(playerid)
{
    //TogglePlayerSpectating(playerid, false);
    if (month == 12)
    {
        RemovePlayerObjectsForXmas(playerid);
    }

    ResetPlayerStats(playerid);
    CreateDMONText(playerid);
    LoadPlayerTexts(playerid);
    CheckPlayerForBlock(playerid);
    if (serverrestarttimer > 0)
    {
        TextDrawShowForPlayer(playerid, RESTART);
    }
    if (PlayerInfo[playerid][pWarns] > 4 || PlayerInfo[playerid][pBlock] == 1)
    {
        ForceClassSelection(playerid);
        SendClientMessage(playerid, 0xE60000FF, "Този акаунт е баннат от сървъра!");
        PlayerInfo[playerid][pKick] = 1;
        ForceClassSelection(playerid);
        return 1;
    }
    SendClientMessage(playerid,0xFFFF00FF,"Добре Дошъл в {FFFFFF}[> GTAINT <] {40BF00}[O-F-F-I-C-I-A-L] {FF0000}[0.3.7] {FFFFFF}[Версия: 1.5 © sTrIx 2026 - official site soon]");
    TogglePlayerSpectating(playerid, true);
    ForceClassSelection(playerid);
    PlayerInfo[playerid][pStartIntro] = 1;
    PlayAudioStreamForPlayer(playerid, audiostreams[random(sizeof(audiostreams))]);
    RemoveBuildingsForPlayer(playerid);
    AddMapIconsForPlayer(playerid);
    GetPlayerCurrentIP(playerid);
    return 1;
}


public OnPlayerDisconnect(playerid, reason)
{
    if (IsPlayerConnected(playerid))
    {
        //new houseSwitchSender[MAX_PLAYERS]=-1;
        //new houseSwitchReceiver[MAX_PLAYERS]=-1;
        ExitWithMoneyBox(playerid);
        ExitWithCMN1(playerid);
        ExitInTurfAttack(playerid);
        if (playerInStreetRace[playerid] == true)
        {
            LeaveStreetRace(playerid);
        }
        if (houseSellSender[playerid] != -1)
        {
            new stringSender[256];
            new sendedHouseInviteID = houseSellSender[playerid];
            houseSellReceiver[sendedHouseInviteID] = -1;
            houseSelling[sendedHouseInviteID] = false;
            format(stringSender, 256, "%s излезе от сървъра и поканата му за продажба на къща отпадна", GetPlayerNickname(playerid));
            SendClientMessage(sendedHouseInviteID, 0x00FF40FF, stringSender);
        }
        if (houseSellReceiver[playerid] != -1)
        {
            new stringReceiver[256];
            new receivedHouseInviteID = houseSellReceiver[playerid];
            houseSellSender[receivedHouseInviteID] = -1;
            houseSelling[receivedHouseInviteID] = false;
            format(stringReceiver, 256, "%s излезе от сървъра и поканата ти за продажба на къща отпадна", GetPlayerNickname(playerid));
            SendClientMessage(receivedHouseInviteID, 0x00FF40FF, stringReceiver);
        }
        if (houseSwitchSender[playerid] != -1)
        {
            new stringSender[256];
            new sendedHouseInviteID = houseSwitchSender[playerid];
            houseSwitchReceiver[sendedHouseInviteID] = -1;
            houseSwitching[sendedHouseInviteID] = false;
            format(stringSender, 256, "%s излезе от сървъра и поканата му за размяна на къщи отпадна", GetPlayerNickname(playerid));
            SendClientMessage(sendedHouseInviteID, 0x00FF40FF, stringSender);
        }
        if (houseSwitchReceiver[playerid] != -1)
        {
            new stringReceiver[256];
            new receivedHouseInviteID = houseSwitchReceiver[playerid];
            houseSwitchSender[receivedHouseInviteID] = -1;
            houseSwitching[receivedHouseInviteID] = false;
            format(stringReceiver, 256, "%s излезе от сървъра и поканата ти за размяна на къщи отпадна", GetPlayerNickname(playerid));
            SendClientMessage(receivedHouseInviteID, 0x00FF40FF, stringReceiver);
        }
        if (bizSwitchSender[playerid] != -1)
        {
            new stringSender[256];
            new sendedBizInviteID = bizSwitchSender[playerid];
            bizSwitchReceiver[sendedBizInviteID] = -1;
            bizSwitching[sendedBizInviteID] = false;
            format(stringSender, 256, "%s излезе от сървъра и поканата му за размяна на бизнеси отпадна", GetPlayerNickname(playerid));
            SendClientMessage(sendedBizInviteID, 0x00CCCCFF, stringSender);
        }
        if (bizSwitchReceiver[playerid] != -1)
        {
            new stringReceiver[256];
            new receivedBizInviteID = bizSwitchReceiver[playerid];
            bizSwitchSender[receivedBizInviteID] = -1;
            bizSwitching[receivedBizInviteID] = false;
            format(stringReceiver, 256, "%s излезе от сървъра и поканата ти за размяна на бизнеси отпадна", GetPlayerNickname(playerid));
            SendClientMessage(receivedBizInviteID, 0x00CCCCFF, stringReceiver);
        }
        if (vehLocker[playerid] != -1)
        {
            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                SetVehicleParamsForPlayer(vehLocker[playerid], i, 0, 0);
            }
        }
        else
        {
            vehLocker[playerid] = -1;
        }
        //saveaccs - location - open
        SavePlayerStats(playerid);
        //saveaccs - location - close
        format(adminprefix[playerid], 35, "");
        format(adminprefix[playerid], 35, "");
        format(viptextformat[playerid], 35, "");
        format(stringvehicle[playerid], 115, "");
        DestroyDynamicObject(rampobject[playerid]);
        new stringmoneybox[256];
        if (playerInDeathmatch[playerid] == true)
        {
            LeaveDeathmatch(playerid);
        }
        if (PlayerInfo[playerid][pRobberLead] == 1)
        {
            PlayerInfo[playerid][pRobber] = 0;
            PlayerInfo[playerid][pRobberLead] = 0;
            GameTextForPlayer(playerid, "   ", 1000, 3);
            for (new i; i < MAX_PLAYERS; i++)
            {
                if (PlayerInfo[i][pRobber] == 1)
                {
                    GameTextForPlayer(i, "   ", 1000, 3);
                    PlayerInfo[i][pRobber] = 0;
                }
            }
            if (inevent[playerid] == 1)
            {
                eventmembers -= 1;
            }
            robberyMembers = 0;
            robCollectedMoney = 0;
            startedrob = 0;
            robberyTimerToCollect = 0;
            robberyPlace = 0;
            robberyToStopTimer = 0;
            SendClientMessageToAll(0xFF8200FF, "Robbery: Обирът се спира автоматично, защото лидерът излезе от сървъра !");
        }
        if (GetPlayerVehicleID(playerid) > -1)
        {
            drive[GetPlayerVehicleID(playerid)] = 0;
        }
        if (playerInDuel[playerid] == 1)
        {
            RestartPlayerColor(duelprotivnik[playerid]);
            new stringduel[256];
            GivePlayerCash(playerid, -duelzalog[playerid]);
            GivePlayerCash(duelprotivnik[playerid], duelzalog[playerid]);
            PlayerInfo[duelprotivnik[playerid]][pDuelCountTimer] = 0;
            PlayerInfo[duelprotivnik[playerid]][pDuelCountTimer2] = 0;
            PlayerInfo[duelprotivnik[playerid]][pDuelCountTimer3] = 0;
            PlayerInfo[duelprotivnik[playerid]][pDuelCountTimer4] = 0;
            format(stringduel, 256, "Duel: Ти победи служебно, защото %s излезе от сървъра и получаваш $%d от залога", GetPlayerNickname(playerid), duelzalog[playerid]);
            SendClientMessage(duelprotivnik[playerid], 0xFFE400FF, stringduel);
            duelzalog[duelprotivnik[playerid]] = 0;
            SetPlayerPos(duelprotivnik[duelprotivnik[playerid]], prediduelX[duelprotivnik[playerid]], prediduelY[duelprotivnik[playerid]], prediduelZ[duelprotivnik[playerid]]);
            SetPlayerHealth(duelprotivnik[playerid], prediduelhealth[duelprotivnik[playerid]]);
            SetPlayerArmour(duelprotivnik[playerid], prediduelarmour[duelprotivnik[playerid]]);
            SetPlayerInterior(duelprotivnik[playerid], prediduelinterior[duelprotivnik[playerid]]);
            SetPlayerVirtualWorld(duelprotivnik[playerid], prediduelvw[duelprotivnik[playerid]]);
            duelsend[duelprotivnik[playerid]] = -1;
            duelsender[duelprotivnik[playerid]] = -1;
            duelprotivnik[duelprotivnik[playerid]] = -1;
        }
        if (duelsend[playerid] > -1)
        {
            new string[256];
            format(string, 256, "Duel: %s излезе от сървъра и поканата за дуел е отменена", GetPlayerNickname(duelsender[duelsend[playerid]]));
            SendClientMessage(duelsender[playerid], 0xFFE400FF, string);
            duelsend[playerid] = -1;
            playerInDuel[duelsend[playerid]] = 0;
            duelsender[duelsend[playerid]] = -1;
        }
        if (duelsender[playerid] > -1)
        {
            new string[256];
            format(string, 256, "Duel: %s излезе от сървъра и поканата за дуел е отменена", GetPlayerNickname(playerid));
            SendClientMessage(duelsender[playerid], 0xFFE400FF, string);
            duelsender[playerid] = -1;
            playerInDuel[duelsender[playerid]] = 0;
            duelsend[duelsender[playerid]] = -1;
        }
        if (hitmanby[playerid] != -1)
        {
            format(string256, 256, "Hitman: %s излезе от сървъра и цената за главата му е отменена", GetPlayerNickname(playerid));
            SendClientMessageToAll(0xA4A400FF, string256);
            GivePlayerCash(hitmanby[playerid], hitmanprice[playerid]);
            hitmaner[hitmanby[playerid]] = -1;
        }
        if (hitmaner[playerid] != -1)
        {
            format(string256, 256, "Hitman: %s излезе от сървъра и цената за главата на %s е отменена", GetPlayerNickname(playerid), GetPlayerNickname(hitmaner[playerid]));
            SendClientMessageToAll(0xA4A400FF, string256);
            GivePlayerCash(hitmaner[playerid], hitmanprice[para1[playerid]]);
            hitmanby[hitmaner[playerid]] = -1;
        }
        if (ingmx == 0)
        {
            if (hideexitserver[playerid] == 0)
            {
                new noerrorstring2[115];
                format(noerrorstring2, 115, "%s {FFFFFF}излезе от сървъра !", GetPlayerNickname(playerid));
                SendClientMessageToAll(0xFF1400FF, noerrorstring2);
            }
        }
        
        if (IsInMinigame(playerid))
        {
            if (isDerbyPlayer[playerid])
            {
                PlayerLeaveDerby(playerid);
            }
        }
        //resttimers - location - openp
        PlayerInfo[playerid][pFuel] = 0;
        PlayerInfo[playerid][pKick] = 0;
        PlayerInfo[playerid][pFixT] = 0;
        PlayerInfo[playerid][pHealT] = 0;
        PlayerInfo[playerid][pVGuns] = 0;
        PlayerInfo[playerid][pRefuel20LitTimer] = 0;
        PlayerInfo[playerid][pInfiniteNosTimer] = 0;
        PlayerInfo[playerid][pIntro] = 0;
        PlayerInfo[playerid][pIntro1] = 0;
        PlayerInfo[playerid][pIntro2] = 0;
        PlayerInfo[playerid][pIntro3] = 0;
        PlayerInfo[playerid][pIntro4] = 0;
        PlayerInfo[playerid][pIntro5] = 0;
        PlayerInfo[playerid][pIntro6] = 0;
        //resttimers - location - close
        //MAX_PLAYERS-=1;
        if (PlayerInfo[playerid][pADuty] == 1)
        {
            UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, " ");
        }
        if (PlayerInfo[playerid][pVIPLabel] == 1)
        {
            UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, " ");
        }
    }
    return 1;
}

public OnPlayerSpawn(playerid)
{
    SetSuspectStars(playerid);
    ShowPlayerTurfs(playerid);
    spawned[playerid] = 1;
    towTruckSkin[playerid] = false;
    //SetTimerEx("OnPlayerUpdate", 62, true, "i", playerid);
    SetPlayerVirtualWorld(playerid, 0);
    if (PlayerInfo[playerid][pStyle] == 0)
    {
        SetPlayerFightingStyle(playerid, FIGHT_STYLE_NORMAL);
    }
    if (PlayerInfo[playerid][pStyle] == 1)
    {
        SetPlayerFightingStyle(playerid, FIGHT_STYLE_GRABKICK);
    }
    if (PlayerInfo[playerid][pStyle] == 2)
    {
        SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING);
    }
    if (PlayerInfo[playerid][pStyle] == 3)
    {
        SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU);
    }
    if (PlayerInfo[playerid][pStyle] == 4)
    {
        SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD);
    }
    if (PlayerInfo[playerid][pStyle] == 5)
    {
        SetPlayerFightingStyle(playerid, FIGHT_STYLE_ELBOW);
    }
    if (PlayerInfo[playerid][pTeam] == FACTION_VIP)
    {
        SetPVarInt(playerid, "color", 18643);
    }
    if (PlayerInfo[playerid][pTeam] == FACTION_GROVE)
    {
        SetPVarInt(playerid, "color", 19083);
    }
    if (PlayerInfo[playerid][pTeam] == FACTION_RIFA)
    {
        SetPVarInt(playerid, "color", 19080);
    }
    if (PlayerInfo[playerid][pTeam] == FACTION_INTENSE_POLICE)
    {
        SetPVarInt(playerid, "color", 19080);
    }
    if (PlayerInfo[playerid][pLaser] == 1)
    {
        if (objectright[playerid] == 0)
        {
            objectright[playerid] = 1;
        }
    }
    if (PlayerInfo[playerid][pWeaponS] == 1)
    {
        GivePlayerWeapon(playerid, 23, 30);
        GivePlayerWeapon(playerid, 25, 50);
        GivePlayerWeapon(playerid, 29, 100);
        GivePlayerWeapon(playerid, 30, 60);
    }
    if (PlayerInfo[playerid][pWeaponS] == 2)
    {
        GivePlayerWeapon(playerid, 23, 50);
        GivePlayerWeapon(playerid, 25, 70);
        GivePlayerWeapon(playerid, 29, 200);
        GivePlayerWeapon(playerid, 30, 100);
    }
    if (PlayerInfo[playerid][pWeaponS] == 3)
    {
        GivePlayerWeapon(playerid, 23, 80);
        GivePlayerWeapon(playerid, 25, 80);
        GivePlayerWeapon(playerid, 29, 250);
        GivePlayerWeapon(playerid, 30, 150);
    }
    if (PlayerInfo[playerid][pWeaponS] == 4)
    {
        GivePlayerWeapon(playerid, 23, 100);
        GivePlayerWeapon(playerid, 25, 100);
        GivePlayerWeapon(playerid, 29, 300);
        GivePlayerWeapon(playerid, 30, 200);
    }
    if (PlayerInfo[playerid][pWeaponS] == 5)
    {
        GivePlayerWeapon(playerid, 22, 80);
        GivePlayerWeapon(playerid, 27, 50);
        GivePlayerWeapon(playerid, 28, 200);
        GivePlayerWeapon(playerid, 31, 70);
        GivePlayerWeapon(playerid, 5, 1);
    }
    if (PlayerInfo[playerid][pWeaponS] == 6)
    {
        GivePlayerWeapon(playerid, 22, 80);
        GivePlayerWeapon(playerid, 27, 70);
        GivePlayerWeapon(playerid, 28, 300);
        GivePlayerWeapon(playerid, 31, 100);
        GivePlayerWeapon(playerid, 33, 20);
        GivePlayerWeapon(playerid, 5, 1);
    }
    if (PlayerInfo[playerid][pWeaponS] == 7)
    {
        GivePlayerWeapon(playerid, 22, 100);
        GivePlayerWeapon(playerid, 27, 100);
        GivePlayerWeapon(playerid, 28, 500);
        GivePlayerWeapon(playerid, 31, 200);
        GivePlayerWeapon(playerid, 33, 40);
        GivePlayerWeapon(playerid, 5, 1);
    }
    if (PlayerInfo[playerid][pWeaponS] == 8)
    {
        GivePlayerWeapon(playerid, 24, 30);
        GivePlayerWeapon(playerid, 26, 50);
        GivePlayerWeapon(playerid, 32, 200);
        GivePlayerWeapon(playerid, 31, 100);
        GivePlayerWeapon(playerid, 34, 30);
        GivePlayerWeapon(playerid, 5, 1);
    }
    if (PlayerInfo[playerid][pWeaponS] == 9)
    {
        GivePlayerWeapon(playerid, 24, 50);
        GivePlayerWeapon(playerid, 26, 80);
        GivePlayerWeapon(playerid, 32, 300);
        GivePlayerWeapon(playerid, 31, 200);
        GivePlayerWeapon(playerid, 34, 40);
        GivePlayerWeapon(playerid, 5, 1);
    }
    if (PlayerInfo[playerid][pWeaponS] == 10)
    {
        GivePlayerWeapon(playerid, 24, 100);
        GivePlayerWeapon(playerid, 26, 100);
        GivePlayerWeapon(playerid, 32, 500);
        GivePlayerWeapon(playerid, 31, 300);
        GivePlayerWeapon(playerid, 34, 50);
        GivePlayerWeapon(playerid, 4, 1);
    }
    if (attachedviptext[playerid] == 1)
    {}
    if (PlayerInfo[playerid][pVip] == 5 || CheckFreeVIP() == 1)
    {
        if (PlayerInfo[playerid][pChantichki] == 0)
            GivePlayerWeapon(playerid, 16, 5);
        else
            GivePlayerWeapon(playerid, 39, 5);
    }
    if (PlayerInfo[playerid][pVip] == 6 || CheckFreeVIP() == 1)
    {
        if (PlayerInfo[playerid][pChantichki] == 0)
            GivePlayerWeapon(playerid, 16, 5);
        else
            GivePlayerWeapon(playerid, 39, 5);
    }
    if (PlayerInfo[playerid][pVip] >= 4 || CheckFreeVIP() == 1)
    {
        SetPlayerArmour(playerid, 100);
    }
    if (requestspawn[playerid] == 1)
    {
        GameTextForPlayer(playerid, "     ", 1000, 3);
    }
    if (firstspawn[playerid] == 1)
    {
        requestspawn2[playerid] = 1;
        nospawnselect[playerid] = 1;
        //ForceClassSelection(playerid);
        StopAudioStreamForPlayer(playerid);
        firstspawn[playerid] = 0;
        GameTextForPlayer(playerid, "     ", 1000, 3);
        if (month == 12)
        {
            santaHat[playerid] = true;
            santaHatObject[playerid] = SetPlayerAttachedObject(playerid, 9, 19065, 2, 0.120000, 0.040000, -0.003500, 0, 100, 100, 1.4, 1.4, 1.4);
            SendClientMessage(playerid, 0xFFFFFFFF, "CHRISTMAS: Ако искаш да премахнеш коледната шапка от главата ти, напиши /removehat");
            SendClientMessage(playerid, 0xFFFFFFFF, "CHRISTMAS: Ако искаш пак да си я сложиш, напиши /santahat");
        }
    }
    if (PlayerInfo[playerid][pSpawnO] == 1)
    {
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerInterior(playerid, 0);
        new spawn = random(10);
        if (spawn == 0)
        {
            SetPlayerPos(playerid, 2178.9063, 1285.6537, 10.8203);
            SetPlayerFacingAngle(playerid, 270.3970);
        }
        if (spawn == 1)
        {
            SetPlayerPos(playerid, 1027.0188, -1344.9539, 13.7266);
            SetPlayerFacingAngle(playerid, 1.2900);
        }
        if (spawn == 2)
        {
            SetPlayerPos(playerid, 2216.9980, -1170.4368, 25.7266);
            SetPlayerFacingAngle(playerid, 359.7421);
        }
        if (spawn == 3)
        {
            SetPlayerPos(playerid, 2097.3970, 2490.7754, 14.8390);
            SetPlayerFacingAngle(playerid, 179.1149);
        }
        if (spawn == 4)
        {
            SetPlayerPos(playerid, 386.7134, -2028.5282, 7.8359);
            SetPlayerFacingAngle(playerid, 89.3663);
        }
        if (spawn == 5)
        {
            SetPlayerPos(playerid, 1676.4705, -1634.6233, 14.2266);
            SetPlayerFacingAngle(playerid, 269.8728);
        }
        if (spawn == 6)
        {
            SetPlayerPos(playerid, 2225.3550, 1838.6611, 10.8203);
            SetPlayerFacingAngle(playerid, 90.2421);
        }
        if (spawn == 7)
        {
            SetPlayerPos(playerid, 2551.8250, 2244.6887, 10.8203);
            SetPlayerFacingAngle(playerid, 167.6396);
        }
        if (spawn == 8)
        {
            SetPlayerPos(playerid, 1742.8735, -1863.2289, 13.5753);
            SetPlayerFacingAngle(playerid, 359.7475);
        }
        if (spawn == 9)
        {
            SetPlayerPos(playerid, 1688.3342, 1447.8641, 10.7678);
            SetPlayerFacingAngle(playerid, 269.8827);
        }
        if (spawn == 10)
        {
            SetPlayerPos(playerid, 2216.9980, -1170.4368, 25.7266);
            SetPlayerFacingAngle(playerid, 359.7421);
        }
        SetCameraBehindPlayer(playerid);
    }
    if (PlayerInfo[playerid][pSpawnO] == 3)
    {
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerPos(playerid, 280.9982, 1410.2089, 10.4179);
    }
    if (PlayerInfo[playerid][pSpawnO] == 2)
    {
        if (PlayerInfo[playerid][pTeam] == FACTION_VIP)
        {
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            new spawn = random(5);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, 1204.3077, -2066.5664, 84.7134);
                SetPlayerFacingAngle(playerid, 2.7804);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, 1183.0295, -2008.9454, 85.1735);
                SetPlayerFacingAngle(playerid, 182.6776);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, 1242.3442, -2003.8608, 76.0035);
                SetPlayerFacingAngle(playerid, 179.7874);
            }
            if (spawn == 3)
            {
                SetPlayerPos(playerid, 1281.2172, -2002.7297, 74.8102);
                SetPlayerFacingAngle(playerid, 174.3698);
            }
            if (spawn == 4)
            {
                SetPlayerPos(playerid, 1281.2172, -2002.7297, 74.8102);
                SetPlayerFacingAngle(playerid, 174.3698);
            }
            if (spawn == 5)
            {
                SetPlayerPos(playerid, 1281.2172, -2002.7297, 74.8102);
                SetPlayerFacingAngle(playerid, 179.7682);
            }
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_BALLAS)
        {
            new spawn = random(2);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, 2146.5444, -1432.6128, 25.5391);
                SetPlayerFacingAngle(playerid, 90.9074);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, 2147.8428, -1489.3254, 26.6198);
                SetPlayerFacingAngle(playerid, 88.7140);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, 2146.5444, -1432.6128, 25.5391);
                SetPlayerFacingAngle(playerid, 90.9074);
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_TRIADS)
        {
            new spawn = random(2);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, 1958.0376, 951.1666, 10.8203);
                SetPlayerFacingAngle(playerid, 180.1847);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, 1969.9386, 942.0911, 10.8126);
                SetPlayerFacingAngle(playerid, 176.1113);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, 1928.6168, 945.8361, 10.8127);
                SetPlayerFacingAngle(playerid, 85.2205);
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_AZTECAS)
        {
            new spawn = random(2);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, 743.6805, -498.7406, 18.0129);
                SetPlayerFacingAngle(playerid, 276.3322);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, 745.5961, -511.2993, 18.0129);
                SetPlayerFacingAngle(playerid, 176.9813);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, 739.9612, -554.7196, 18.0129);
                SetPlayerFacingAngle(playerid, 5.9559);
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_CRIPZ)
        {
            new spawn = random(2);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, 297.6942, -1155.6418, 80.9099);
                SetPlayerFacingAngle(playerid, 125.8933);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, 320.8712, -1170.3861, 80.9141);
                SetPlayerFacingAngle(playerid, 88.6063);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, 274.3722, -1167.7781, 80.8616);
                SetPlayerFacingAngle(playerid, 276.8981);
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_BGMAFIA)
        {
            SetPlayerArmour(playerid, 100);
            SetPlayerPos(playerid, 1267.1464, -777.3041, 1091.9063);
            SetPlayerVirtualWorld(playerid, 1);
            SetPlayerInterior(playerid, 5);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_RIFA)
        {
            SetPlayerPos(playerid, 2449.8516, -1688.9565, 1013.5078);
            SetPlayerFacingAngle(playerid, 182.1234);
            SetPlayerVirtualWorld(playerid, 1);
            SetPlayerInterior(playerid, 2);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_SOLDIER)
        {
            SetPlayerArmour(playerid, 100);
            SetPlayerPos(playerid, 2331.0933, -1137.6527, 1054.3047);
            SetPlayerVirtualWorld(playerid, 1);
            SetPlayerInterior(playerid, 12);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_SOA)
        {
            new spawn = random(2);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, 2615.6545, 2313.8264, 10.8203);
                SetPlayerFacingAngle(playerid, 253.6507);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, 2622.7986, 2335.3406, 10.8203);
                SetPlayerFacingAngle(playerid, 185.9700);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, 2655.8208, 2347.8174, 10.8203);
                SetPlayerFacingAngle(playerid, 149.9362);
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_NANG)
        {
            new spawn = random(2);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, 2621.7190, 1825.1489, 11.0234);
                SetPlayerFacingAngle(playerid, 91.7867);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, 2635.7065, 1797.4092, 11.0234);
                SetPlayerFacingAngle(playerid, 87.7133);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, 2599.0176, 1812.4899, 10.9766);
                SetPlayerFacingAngle(playerid, 279.7651);
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_BOUNTY)
        {
            SetPlayerArmour(playerid, 100);
            new spawn = random(2);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, 681.9958, -1276.5922, 13.5755);
                SetPlayerFacingAngle(playerid, 88.3163);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, 673.2634, -1292.6874, 13.6328);
                SetPlayerFacingAngle(playerid, 82.0496);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, 658.6101, -1251.8407, 13.7522);
                SetPlayerFacingAngle(playerid, 190.7540);
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_THUGLIFE)
        {
            new spawn = random(2);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, 491.4981, -1514.3501, 20.4358);
                SetPlayerFacingAngle(playerid, 1.1300);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, 480.5826, -1495.5084, 20.3957);
                SetPlayerFacingAngle(playerid, 89.8041);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, 480.3297, -1482.4331, 19.8992);
                SetPlayerFacingAngle(playerid, 92.3108);
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_INTENSE_POLICE)
        {
            new spawn = random(2);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, 248.4185, 75.8314, 1003.6406);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, 253.4204, 65.2763, 1003.6406);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, 237.9575, 74.1665, 1005.0391);
            }
            SetPlayerArmour(playerid, 100);
            SetPlayerVirtualWorld(playerid, 1);
            SetPlayerInterior(playerid, 6);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_CREW)
        {
            new spawn = random(2);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, 309.5213, -1333.9890, 53.4476);
                SetPlayerFacingAngle(playerid, 91.9914);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, 317.7553, -1330.7593, 53.1995);
                SetPlayerFacingAngle(playerid, 91.9914);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, 298.8723, -1334.7021, 53.4421);
                SetPlayerFacingAngle(playerid, 88.8813);
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_ITALIAN)
        {
            new spawn = random(2);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, -688.8886, 938.8144, 13.6328);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, -688.0349, 926.8151, 13.6293);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, -708.7231, 950.2300, 12.4724);
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_VAGOS)
        {
            SetPlayerArmour(playerid, 100);
            new spawn = random(2);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, 1881.9993, 2339.8398, 10.9799);
                SetPlayerFacingAngle(playerid, 264.6255);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, 1910.1119, 2349.9846, 10.9799);
                SetPlayerFacingAngle(playerid, 176.9813);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, 1883.3551, 2295.4844, 10.9799);
                SetPlayerFacingAngle(playerid, 267.4223);
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_MS13)
        {
            new spawn = random(2);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, -37.7534, 1079.9067, 20.0710);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, -22.8780, 1063.8611, 19.7422);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, -7.8116, 1075.0288, 19.7422);
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_SYNDICATE)
        {
            SetPlayerArmour(playerid, 100);
            new spawn = random(2);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, 1757.1570, 2766.8816, 10.8359);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, 1749.6184, 2797.0723, 10.8359);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, 1783.9874, 2787.4541, 10.8359);
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_BLOODMAFIA)
        {
            new spawn = random(2);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, 1100.7185, -1220.8761, 17.8047);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, 1117.1194, -1237.0652, 15.9510);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, 1122.6483, -1247.2380, 25.3020);
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_343)
        {
            new spawn = random(2);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, -799.6035, 1569.4238, 27.1172);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, -814.1357, 1542.5577, 27.1172);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, -800.3713, 1531.4137, 27.1172);
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_YAKUZA)
        {
            new spawn = random(2);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, 2584.7444, 2787.1177, 10.8203);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, 2581.6055, 2747.6665, 10.8203);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, 2531.0698, 2794.3374, 10.8203);
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_GROVE)
        {
            new spawn = random(5);
            if (spawn == 0)
            {
                SetPlayerPos(playerid, 2496.0024, -1709.4805, 1014.7422);
                SetPlayerFacingAngle(playerid, 2.1533);
            }
            if (spawn == 1)
            {
                SetPlayerPos(playerid, 2496.0024, -1709.4805, 1014.7422);
                SetPlayerFacingAngle(playerid, 2.1533);
            }
            if (spawn == 2)
            {
                SetPlayerPos(playerid, 2496.0024, -1709.4805, 1014.7422);
                SetPlayerFacingAngle(playerid, 2.1533);
            }
            if (spawn == 3)
            {
                SetPlayerPos(playerid, 2492.2722, -1703.3955, 1018.3438);
                SetPlayerFacingAngle(playerid, 179.7682);
            }
            if (spawn == 4)
            {
                SetPlayerPos(playerid, 2492.2722, -1703.3955, 1018.3438);
                SetPlayerFacingAngle(playerid, 179.7682);
            }
            if (spawn == 5)
            {
                SetPlayerPos(playerid, 2496.0024, -1709.4805, 1014.7422);
                SetPlayerFacingAngle(playerid, 2.1533);
            }
            SetPlayerVirtualWorld(playerid, 1);
            SetPlayerInterior(playerid, 3);
            SetCameraBehindPlayer(playerid);
        }
    }
    RestartPlayerColor(playerid);
    RestartVIPLaser(playerid);
    RestartPlayerSkin(playerid);
    if (adutyskinchanged[playerid] == 0)
    {
        spawnselectedskin2[playerid] = GetPlayerSkin(playerid);
        spawnselectedskin[playerid] = GetPlayerSkin(playerid);
    }
    else
    {
        spawnselectedskin2[playerid] = GetPlayerSkin(playerid);
        spawnselectedskin[playerid] = PlayerInfo[playerid][pASkin];
    }
    if (PlayerInfo[playerid][pSpawnO] == 4)
    {
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, HouseInfo[PlayerInfo[playerid][pHouseO]][hX], HouseInfo[PlayerInfo[playerid][pHouseO]][hY], HouseInfo[PlayerInfo[playerid][pHouseO]][hZ]);
    }
    if (PlayerInfo[playerid][pSpawnO] == 5)
    {
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, BizInfo[PlayerInfo[playerid][pBizO]][bX], BizInfo[PlayerInfo[playerid][pBizO]][bY], BizInfo[PlayerInfo[playerid][pBizO]][bZ]);
    }
    if (PlayerInfo[playerid][pADuty] == 0)
    {
        if (PlayerInfo[playerid][pVIPLabel] == 1)
        {
            UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, " ");
            format(VipText3D[playerid], 26, "");
            PlayerLabel[playerid] = CreateDynamic3DTextLabel(VipText3D[playerid], 0x800000FF, 0.0, 0.0, 0.0, 15.0, playerid, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 15.0);
        }
    }
    if (PlayerInfo[playerid][pADuty] == 1)
    {
        SetPlayerColor(playerid, 0x7BFFFFFF);
        adutyskinchanged[playerid] = 1;
        SendClientMessage(playerid, 0x40BF00FF, "Ти все-още си On-Duty и трябва да помагаш на играчите");
        SetPlayerSkin(playerid, PlayerInfo[playerid][pASkin]);
        if (godmode[playerid] == 1)
        {
            SetPlayerHealth(playerid, 99999);
            SetPlayerArmour(playerid, 99999);
        }
        ResetPlayerWeapons(playerid);
    }
    UpdatePlayerHeadText(playerid);
    if (PlayerInfo[playerid][pJail] > 0)
    {
        ResetPlayerWeapons(playerid);
        SetPlayerVirtualWorld(playerid, 1);
        SetPlayerInterior(playerid, 4);
        SetPlayerPos(playerid, 299.7077, 303.4193, 999.1484);
        SetPlayerAttachedObject(playerid, 1, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CUFFED);
    }
    if (PlayerInfo[playerid][pAFK] > 0)
    {
        ResetPlayerWeapons(playerid);
        SetPlayerInterior(playerid, 15);
        SetPlayerColor(playerid, 0xD6F34AFF);
        SetPlayerPos(playerid, 2215.454833, -1147.475585, 1025.796875);
        SetPlayerVirtualWorld(playerid, playerid + 500);
    }
    if (playerInDMON[playerid] == 1)
    {
        SetPlayerVirtualWorld(playerid, 3233);
        SetPlayerColor(playerid, 0xFFFF81FF);
        ResetPlayerWeapons(playerid);
        SetPlayerArmour(playerid, 0);
        new r = random(sizeof(DmonRandomWeapons));
        GivePlayerWeapon(playerid, DmonRandomWeapons[r][0], DmonRandomWeapons[r][1]);
        if (dmonArena == 1)
        {
            new spawnpos = randomex(1, 5);
            if (spawnpos < 3)
            {
                SetPlayerPos(playerid, 1411.2889, 1.3799, 1000.9237);
            }
            if (spawnpos > 2)
            {
                SetPlayerPos(playerid, 1360.4244, -39.4643, 1007.8828);
            }
            SetPlayerInterior(playerid, 1);
        }
        if (dmonArena == 2)
        {
            new spawnpos = randomex(1, 5);
            if (spawnpos < 3)
            {
                SetPlayerPos(playerid, -1426.4996, 1054.9972, 1038.4913);
            }
            if (spawnpos > 2)
            {
                SetPlayerPos(playerid, -1473.7843, 948.4413, 1036.7908);
            }
            SetPlayerInterior(playerid, 15);
        }
    }
    if (hideIPD == 1)
    {
        if (PlayerInfo[playerid][pTeam] == 15)
        {
            SetPlayerColor(playerid, 0xFFFFFF00);
        }
    }
    if (playerInDeathmatch[playerid] == true)
    {
        DisablePlayerCheckpoint(playerid);
        DisablePlayerRaceCheckpoint(playerid);
        SetPlayerVirtualWorld(playerid, 1);
        SetPlayerInterior(playerid, 0);
        SetPlayerHealth(playerid, 100);
        SetPlayerArmour(playerid, 0);
        ResetPlayerWeapons(playerid);
        GivePlayerWeapon(playerid, deathmatchGun, 10000);
        if (deathmatchFightArea == 1)
        {
            new randomSpawn = randomex(1, 3);
            if (randomSpawn == 1)
            {
                SetPlayerPos(playerid, DeathmatchPlace1Spawn1);
            }
            else if (randomSpawn == 2)
            {
                SetPlayerPos(playerid, DeathmatchPlace1Spawn2);
            }
            else if (randomSpawn == 3)
            {
                SetPlayerPos(playerid, DeathmatchPlace1Spawn3);
            }
        }
        else if (deathmatchFightArea == 2)
        {
            new randomSpawn = randomex(1, 3);
            if (randomSpawn == 1)
            {
                SetPlayerPos(playerid, DeathmatchPlace2Spawn1);
            }
            else if (randomSpawn == 2)
            {
                SetPlayerPos(playerid, DeathmatchPlace2Spawn2);
            }
            else if (randomSpawn == 3)
            {
                SetPlayerPos(playerid, DeathmatchPlace2Spawn3);
            }
        }
    }
    if (PlayerInfo[playerid][pPJail] > 0)
    {
        SetPlayerInterior(playerid, 3);
        SendClientMessage(playerid, 0x0040FFFF, "Jail: Ти все още си в затвора на полицията!");
        SetPlayerPos(playerid, 197.9882, 175.4870, 1003.0234);
        ResetPlayerWeapons(playerid);
    }
    return 1;
}
public OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
    if (weaponid == 34 && bodypart == 9) // Sniper rifle + head
    {
        // Kill the victim
        SetPlayerHealth(damagedid, 0.0);
        GameTextForPlayer(playerid, "~r~HEADSHOT!", 3000, 3);
        // Victim visual/sound
        GameTextForPlayer(damagedid, "~r~HEADSHOT!", 3000, 3);
        PlayerPlaySound(damagedid, 17802, 0.0, 0.0, 0.0);
    }
    if (damagedid != INVALID_PLAYER_ID && damagedid != playerid)
    {
        if (PlayerInfo[damagedid][pIPDDuty] && !PlayerInfo[playerid][pIPDDuty] && !PlayerInfo[playerid][pADuty])
        {
            new now = gettime();
            if (now - lastCriminalPoliceUser[playerid] >= 30)
            {
                lastCriminalPoliceUser[playerid] = now;
                GivePlayerWantedLevel(playerid, 1, "Стрелба по полицaй");
            }
        }
    }
}

public OnPlayerDeath(playerid, killerid, reason)
{
    SendDeathMessage(killerid, playerid, reason);
    if (playerInStreetRace[playerid] == true)
    {
        LeaveStreetRace(playerid);
    }
    DeathInTurfAttack(playerid);
    KilledWithMoneyBox(playerid);
    KilledWithCMN1(killerid, playerid);
    PlayerInfo[playerid][pDMONKills2] = 0;
    inevent[playerid] = 0;
    if (IsInMinigame(playerid))
    {
        if (isDerbyPlayer[playerid])
        {
            PlayerLeaveDerby(playerid);
        }
    }
    if (playerInDeathmatch[killerid] == true && playerInDeathmatch[playerid] == true)
    {
        if (deathmatchStarted == true)
        {
            deathmatchKills[killerid] += 1;
            format(string256, 256, "%d", deathmatchKills[killerid]);
            GameTextForPlayer(killerid, string256, 1000, 1);
        }
    }
    if (vehLocker[playerid] != -1)
    {
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            SetVehicleParamsForPlayer(vehLocker[playerid], i, 0, 0);
        }
    }
    else
        vehLocker[playerid] = -1;
    if (GetPlayerState(killerid) == PLAYER_STATE_DRIVER)
    {
        SetPlayerHealth(killerid, 0);
        SendClientMessage(killerid, 0xE60000FF, "SERVER: Ти беше убит за Drive-By убийство!");
    }
    if (onWork[playerid] == 1)
    {
        onWork[playerid] = 0;
        DisablePlayerRaceCheckpoint(playerid);
        DisablePlayerCheckpoint(playerid);
        SendClientMessage(playerid, 0xB35900FF, "Job: Ти умря и загуби твоята работа, но може да се пробваш отново!");
    }
    if (PlayerInfo[killerid][pIPDDuty] && PlayerInfo[playerid][pWanted] > 0 && killerid != playerid)
    {
        CaughtedWanted(playerid, killerid);
    }
    if (PlayerInfo[playerid][pMoonshineEffectTime] > 0 || PlayerInfo[playerid][pWeed] > 0 || PlayerInfo[playerid][pCocaine] > 0 || PlayerInfo[playerid][pHeroin] > 0)
    {
        PlayerInfo[playerid][pMoonshineEffectTime] = 0;
        SetPlayerWeather(playerid, 1);
    }
    if (killerid != INVALID_PLAYER_ID && killerid != playerid)
    {
        LoseDrugs(playerid, killerid);
    }
    if (isTurfMember[playerid] == true && isGangAttackingTurf[PlayerInfo[playerid][pTeam]] == true)
    {
        startturf = 0;
        new attackerFaction = PlayerInfo[playerid][pTeam];
        new turfAttacked = TeamInfo[attackerFaction][tTurfAttacked];
        new turfOwner = TurfInfo[turfAttacked][TurfOwner];
        format(string256, 256, "[FACTION CHAT] {FF0000}%s{C800FF} Играчът напусна очертанията и отпадна от атака!", GetPlayerNickname(playerid));
        SendFactionMessage(attackerFaction, 0xC800FFFF, string256);
        inTurfAttackMembers[attackerFaction]--;
        isTurfMember[playerid] = false;
        if (inTurfAttackMembers[attackerFaction] == 0)
        {
            format(string256, 256, "Turf War: {FF0000}%s{C800FF} не успя да превземе %s територията на %s!", TeamInfo[attackerFaction][tName], TurfInfo[turfAttacked][TurfName],
                TeamInfo[turfOwner][tName]);
            SendClientMessageToAll(0xC800FFFF, string256);
            FailTurfAttack(attackerFaction);
        }
    }
    if (inevent[playerid] == 1 || PlayerInfo[playerid][pOrganisator] == 1)
    {
        if (cbchat[playerid] > 0)
        {
            SendClientMessage(playerid, 0xFF9933FF, "CB Chanel: Твоят CB Chanel беше изключен, защото вече не си в евента!");
        }
        cbchat[playerid] = 0;
        eventmembers -= 1;
        inevent[playerid] = 0;
        cbchat[playerid] = 0;
        if (hidename[playerid] == 1)
        {
            hidename[playerid] = 0;
            for (new i; i < MAX_PLAYERS; i++)
            {
                ShowPlayerNameTagForPlayer(i, playerid, 1);
            }
        }
        SetPlayerWeather(playerid, 1);
        if (hours == 0)
        {
            SetPlayerTime(playerid, 0, 0);
        }
        if (hours == 6)
        {
            SetPlayerTime(playerid, 0, 0);
        }
        if (hours == 12)
        {
            SetPlayerTime(playerid, 12, 0);
        }
        if (hours == 18)
        {
            SetPlayerTime(playerid, 23, 0);
        }
        if (hours == 1)
        {
            SetPlayerTime(playerid, 0, 0);
        }
        if (hours == 7)
        {
            SetPlayerTime(playerid, 6, 0);
        }
        if (hours == 13)
        {
            SetPlayerTime(playerid, 12, 0);
        }
        if (hours == 19)
        {
            SetPlayerTime(playerid, 23, 0);
        }
        if (hours == 2)
        {
            SetPlayerTime(playerid, 0, 0);
        }
        if (hours == 8)
        {
            SetPlayerTime(playerid, 6, 0);
        }
        if (hours == 14)
        {
            SetPlayerTime(playerid, 12, 0);
        }
        if (hours == 20)
        {
            SetPlayerTime(playerid, 0, 0);
        }
        if (hours == 3)
        {
            SetPlayerTime(playerid, 0, 0);
        }
        if (hours == 9)
        {
            SetPlayerTime(playerid, 12, 0);
        }
        if (hours == 15)
        {
            SetPlayerTime(playerid, 12, 0);
        }
        if (hours == 21)
        {
            SetPlayerTime(playerid, 0, 0);
        }
        if (hours == 4)
        {
            SetPlayerTime(playerid, 0, 0);
        }
        if (hours == 10)
        {
            SetPlayerTime(playerid, 12, 0);
        }
        if (hours == 16)
        {
            SetPlayerTime(playerid, 12, 0);
        }
        if (hours == 22)
        {
            SetPlayerTime(playerid, 0, 0);
        }
        if (hours == 5)
        {
            SetPlayerTime(playerid, 0, 0);
        }
        if (hours == 11)
        {
            SetPlayerTime(playerid, 12, 0);
        }
        if (hours == 17)
        {
            SetPlayerTime(playerid, 12, 0);
        }
        if (hours == 23)
        {
            SetPlayerTime(playerid, 0, 0);
        }
    }
    new stringmoneybox[256];
    PlayerInfo[playerid][pDeaths] += 1;
    PlayerInfo[killerid][pKills] += 1;
    if (playerInDMON[playerid] == 1 && playerInDMON[killerid] == 1)
    {
        PlayerInfo[killerid][pDMONKills2] += 1;
        PlayerInfo[killerid][pDMONKills] += 1;
        TextDrawShowForPlayer(killerid, DMONKillText);
        PlayerInfo[killerid][pHideDMONKillText] = 3;
        if (PlayerInfo[killerid][pDMONKills] >= 20)
        {
            GivePlayerEP(playerid, 1);
            PlayerInfo[killerid][pDMONKills] = 0;
            SendClientMessage(killerid, 0xFFFF81FF, "DM Area: Ти събра 20 убийства и за награда получаваш + 1 EP!");
        }
        if (PlayerInfo[killerid][pDMONKills2] > RecordInfo[0][record])
        {
            new stringaz[256];
            format(stringaz, 256, "~w~DM AREA~n~~n~~r~NEW RECORD: ~g~%d", PlayerInfo[killerid][pDMONKills2]);
            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                GameTextForPlayer(i, stringaz, 3000, 3);
            }
            new stringa[256];
            if (RecordInfo[0][record] > 20)
            {
                format(stringa, 256, "TOP: %s надмина %s по най-много убийства без умиране в {FF0000}DM Area", GetPlayerNickname(killerid), RecordInfo[0][recordPlayer]);
                SendClientMessageToAll(0x80FF80FF, stringa);
                format(stringa, 256, "TOP: Новият резултат е %d убийства без умиране!", PlayerInfo[killerid][pDMONKills2]);
                SendClientMessageToAll(0x80FF80FF, stringa);
            }
            else
            {
                format(stringa, 256, "TOP: %s направи рекорд по най-много убийства без умиране в {FF0000}DM Area", GetPlayerNickname(killerid));
                SendClientMessageToAll(0x80FF80FF, stringa);
                format(stringa, 256, "TOP: Новият резултат е %d убийства без умиране!", PlayerInfo[killerid][pDMONKills2]);
                SendClientMessageToAll(0x80FF80FF, stringa);
            }
            RecordInfo[0][record] = PlayerInfo[killerid][pDMONKills2];
            new dmon[64];
            SaveRecords();
            PlayerInfo[killerid][pDMONKills2] = 0;
        }
        new stringtext[115];
        TextDrawHideForPlayer(killerid, DMON[killerid]);
        format(stringtext, 115, " ~r~Kills: ~w~%d/~g~20", PlayerInfo[killerid][pDMONKills]);
        TextDrawSetString(DMON[killerid], stringtext);
        TextDrawShowForPlayer(killerid, DMON[killerid]);
        new Float:myarmour;
        GetPlayerArmour(killerid, myarmour);
        SetPlayerArmour(killerid, myarmour + 25);
    }
    if (playerInDuel[playerid] == 1)
    {
        new level = PlayerInfo[duelprotivnik[playerid]][pTeam];
        RestartPlayerColor(duelprotivnik[playerid]);
        new stringduel[256];
        GivePlayerCash(playerid, -duelzalog[playerid]);
        GivePlayerCash(duelprotivnik[playerid], duelzalog[playerid]);
        GameTextForPlayer(duelprotivnik[playerid], "~g~WINNER", 5000, 3);
        format(stringduel, 256, "Ти спечели дуела срещу %s и получаваш $%d от залога.", GetPlayerNickname(playerid), duelzalog[playerid]);
        SendClientMessage(duelprotivnik[playerid], 0xFFE400FF, stringduel);
        format(stringduel, 256, "Ти загуби дуела срещу %s и загуби $%d от залога.", GetPlayerNickname(duelprotivnik[playerid]), duelzalog[playerid]);
        SendClientMessage(playerid, 0xFFE400FF, stringduel);
        duelzalog[playerid] = 0;
        PlayerInfo[duelprotivnik[playerid]][pDuelCountTimer] = 0;
        PlayerInfo[duelprotivnik[playerid]][pDuelCountTimer2] = 0;
        PlayerInfo[duelprotivnik[playerid]][pDuelCountTimer3] = 0;
        PlayerInfo[duelprotivnik[playerid]][pDuelCountTimer4] = 0;
        PlayerInfo[playerid][pDuelCountTimer] = 0;
        PlayerInfo[playerid][pDuelCountTimer2] = 0;
        PlayerInfo[playerid][pDuelCountTimer3] = 0;
        PlayerInfo[duelprotivnik[playerid]][pDuelCountTimer4] = 0;
        duelzalog[duelprotivnik[playerid]] = 0;
        SetPlayerPos(duelprotivnik[playerid], prediduelX[duelprotivnik[playerid]], prediduelY[duelprotivnik[playerid]], prediduelZ[duelprotivnik[playerid]]);
        SetPlayerHealth(duelprotivnik[playerid], prediduelhealth[duelprotivnik[playerid]]);
        SetPlayerArmour(duelprotivnik[playerid], prediduelarmour[duelprotivnik[playerid]]);
        SetPlayerInterior(duelprotivnik[playerid], prediduelinterior[duelprotivnik[playerid]]);
        SetPlayerVirtualWorld(duelprotivnik[playerid], prediduelvw[duelprotivnik[playerid]]);
        duelsend[playerid] = -1;
        duelsend[duelprotivnik[playerid]] = -1;
        playerInDuel[duelprotivnik[playerid]] = 0;
        playerInDuel[playerid] = 0;
        duelsender[playerid] = -1;
        duelsender[duelprotivnik[playerid]] = -1;
        duelprotivnik[duelprotivnik[playerid]] = -1;
        duelprotivnik[playerid] = -1;
    }
    if (PlayerInfo[playerid][pRobberLead] == 1)
    {
        PlayerInfo[playerid][pRobber] = 0;
        PlayerInfo[playerid][pRobberLead] = 0;
        GameTextForPlayer(playerid, "   ", 1000, 3);
        for (new i; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pRobber] == 1)
            {
                GameTextForPlayer(i, "   ", 1000, 3);
                PlayerInfo[i][pRobber] = 0;
            }
        }
        robberyMembers = 0;
        robCollectedMoney = 0;
        startedrob = 0;
        robberyTimerToCollect = 0;
        robberyPlace = 0;
        robberyToStopTimer = 0;
        SendClientMessage(playerid, 0xFF8200FF, "Robbery: Ти беше убит и обирът е прекратен !");
        SendClientMessageToAll(0xFF8200FF, "Robbery: Обирът се спира автоматично, защото лидерът беше убит !");
    }
    if (PlayerInfo[playerid][pRobberLead] == 0 && PlayerInfo[playerid][pRobber] == 1)
    {
        PlayerInfo[playerid][pRobber] = 0;
        GameTextForPlayer(playerid, "   ", 1000, 3);
        robberyMembers -= 1;
        SendClientMessage(playerid, 0xFF8200FF, "Robbery: Ти беше убит и си отстранен от обира !");
    }
    if (hitmanby[playerid] != -1)
    {
        new hitmanstring[256];
        format(hitmanstring, 256, "Hitman: %s уби %s и спечели $%d", GetPlayerNickname(killerid), GetPlayerNickname(playerid), hitmanprice[playerid]);
        SendClientMessageToAll(0xA4A400FF, hitmanstring);
        GivePlayerCash(killerid, hitmanprice[playerid]);
        hitmaner[hitmanby[playerid]] = -1;
        hitmanprice[playerid] = 0;
        hitmanby[playerid] = -1;
    }
    if (PlayerInfo[playerid][pVip] == 0)
    {
        GivePlayerCash(playerid, -100);
    }
    if (PlayerInfo[playerid][pVip] > 0 || CheckFreeVIP() == 1)
    {
        GivePlayerCash(playerid, -50);
    }
    if (killerid != playerid)
    {
        if (PlayerInfo[killerid][pVip] == 0)
        {
            GivePlayerCash(killerid, 100);
        }
        if (PlayerInfo[killerid][pVip] > 0 || CheckFreeVIP() == 1)
        {
            GivePlayerCash(killerid, 200);
        }
        if (PlayerInfo[killerid][pVip] == 6 || CheckFreeVIP() == 1)
        {
            GivePlayerCash(killerid, 600);
        }
    }
    if (PlayerInfo[playerid][pADuty] == 1)
    {
        UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, " ");
    }
    if (PlayerInfo[playerid][pVIPLabel] == 1)
    {
        UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, " ");
    }

    return 1;
}


public OnVehicleSpawn(vehicleid)
{
    eventveh[vehicleid] = 0;
    LoadVehTune(vehicleid);
    LoadPrivateVehsTune(vehicleid);
    return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
    eventveh[vehicleid] = 0;
    return 1;
}
public OnPlayerText(playerid, text[])
{
    if (logged[playerid] == 0)
    {
        SendClientMessage(playerid, 0xBFC0C2FF, "Трябва да влезеш в акаунта преди да пишеш в чата!");
        return 0;
    }
    if (PlayerInfo[playerid][pMuted] != 0 || PlayerInfo[playerid][pADMINMute] == 1 || PlayerInfo[playerid][pMuteReason] > 0 && PlayerInfo[playerid][pAdmin] < 5)
    {
        SendClientMessage(playerid, 0xBFC0C2FF, "Ти си заглушен в чата!");
        return 0;
    }
    if (togchat[playerid] == 1 && cbchat[playerid] == 0)
    {
        SendClientMessage(playerid, 0xBFC0C2FF, "Ти си игнорирал да ти идват съобщения от главния чат!");
        return 0;
    }
    printf("[say] %s(id:%d): %s", GetPlayerNickname(playerid), playerid, text);
    if (cbchat[playerid] > 0 && PlayerInfo[playerid][pOrganisator] == 0)
    {
        format(string256, 256, "[CB: %d] %s(%d): %s", cbchat[playerid], GetPlayerNickname(playerid), playerid, text[0]);
        for (new i; i < MAX_PLAYERS; i++)
        {
            if (cbchat[i] == cbchat[playerid] || PlayerInfo[i][pTogCB] == 1)
            {
                SendClientMessage(i, 0xFF9933FF, string256);
                return 0;
            }
        }
    }
    if (cbchat[playerid] > 0 && PlayerInfo[playerid][pOrganisator] == 1)
    {
        format(string256, 256, "[CB: %d] %s(%d): {FF0000}%s", cbchat[playerid], GetPlayerNickname(playerid), playerid, text[0]);
        for (new i; i < MAX_PLAYERS; i++)
        {
            if (cbchat[i] == cbchat[playerid] || PlayerInfo[i][pTogCB] == 1)
            {
                SendClientMessage(i, 0xFF9933FF, string256);
                return 0;
            }
        }
    }
    if (cbchat[playerid] == 0)
    {
        if (PlayerInfo[playerid][pTextSpamTimer] == 0)
        {
            PlayerInfo[playerid][pTextSpamTimer] = 8;
        }
        if (PlayerInfo[playerid][pAdmin] < 5)
        {
            textspam[playerid] += 1;
        }
        if (textspam[playerid] == 8)
        {
            format(string256, 256, "ADMIN: %s was muted by THE SERVER for 100 minutes. [Reason: Спам]", GetPlayerNickname(playerid));
            SendClientMessageToAll(0xE60000FF, string256);
            PlayerInfo[playerid][pMuted] = 120 * 100;
            PlayerInfo[playerid][pMuteReason] = 3;
            return 0;
        }

        format(string256, 256, "{FFFFFF}(%d): {FFFFFF}%s", playerid, text[0]);
        SendPlayerMessageToAll(playerid, string256);
        return 0;
    }
    return 1;
}

public OnPlayerCommandReceived(playerid, cmdtext[])
{
    printf("[i-zcmd] %s (ID: %d): %s", GetPlayerNickname(playerid), playerid, cmdtext);
    
    // Prevent commands if not logged in
    if (logged[playerid] == 0) 
    {
        return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да влезеш в акаунта преди да ползваш команда!");
    }

    // Command spam timer
    if (PlayerInfo[playerid][pCommandSpamTimer] == 0)
    {
        PlayerInfo[playerid][pCommandSpamTimer] = 8;
    }
    if (PlayerInfo[playerid][pAdmin] < 5)
    {
        commandspam[playerid] += 1;
    }
    if (commandspam[playerid] == 9)
    {
        format(string115, 115, "SERVER: %s was kicked by THE SERVER [Reason: Command Spam]", GetPlayerNickname(playerid));
        SendClientMessageToAll(0xE60000FF, string115);
        PlayerInfo[playerid][pKick] = 1;
        return 0;
    }

    return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if (GetVehicleModel(vehicleid) == 481)
    {
        SetPlayerArmedWeapon(playerid, 0);
    }
    if(VehicleInfo[vehicleid][vIsHouseVeh])
    {
        if (PlayerInfo[playerid][pHouseO] != VehicleInfo[vehicleid][vHouseID])
        {
            if (!ispassenger)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                SendClientMessage(playerid, 0x636363FF, "Ти не притежаваш това превозно средство!");
            }
        }
    }
    //if(OnPlayerUpdate(playerid) == 0)
    //{
    //SetTimerEx("OnPlayerUpdate", 62, true, "i", playerid);
    //}
    if (isTurfMember[playerid])
    {
        new Float:cx, Float:cy, Float:cz;
        GetPlayerPos(playerid, cx, cy, cz);
        SetPlayerPos(playerid, cx, cy, cz);
        return SendClientMessage(playerid, COLOR_GRAD1, "Влизането в превозни средства, докато си в търф атака е забранено !");
    }
    if (eev == 0 && inevent[playerid] == 1)
    {
        new Float:cx, Float:cy, Float:cz;
        GetPlayerPos(playerid, cx, cy, cz);
        SetPlayerPos(playerid, cx, cy, cz);
        return SendClientMessage(playerid, COLOR_GRAD1, "Влизането в превозни средства в евента е забранено !");
    }
    if (!ispassenger)
    {
        if (vehicleid == mechanicDutyVehs[0] || vehicleid == mechanicDutyVehs[1] || vehicleid == mechanicDutyVehs[2] ||
            vehicleid == mechanicDutyVehs[3] || vehicleid == mechanicDutyVehs[4] || vehicleid == mechanicDutyVehs[5] ||
            vehicleid == mechanicDutyVehs[6] || vehicleid == mechanicDutyVehs[7])
        {
            if (towTruckSkin[playerid] == false)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                SendClientMessage(playerid, COLOR_RED, "Трябва да си със скин на механик за да караш Tow Truck !");
            }
        }
    }
    //-----------------------------
    new stringprivate[256];
    for (new alv = 1; alv < MAX_PRIVATEVEHS; alv++)
    {
        if (vehicleid == PrivateVeh[alv][pvID])
        {
            if (!ispassenger)
            {
                if (strcmp(PrivateVeh[alv][pvOwner], GetPlayerNickname(playerid), true) > 0 || strcmp(PrivateVeh[alv][pvOwner], GetPlayerNickname(playerid), true) < 0)
                {
                    if (PrivateVeh[alv][pvIsOwned] == 1)
                    {
                        new Float:cx, Float:cy, Float:cz;
                        GetPlayerPos(playerid, cx, cy, cz);
                        SetPlayerPos(playerid, cx, cy, cz);
                        format(stringprivate, 256, "Това превозно средство принадлежи на %s", PrivateVeh[alv][pvOwner]);
                        SendClientMessage(playerid, 0x636363FF, stringprivate);
                        return 1;
                    }
                }
            }
        }
    }
    //-----------------------------
    for (new i2 = 0; i2 < 9; i2++)
    {
        if (vehicleid == carshopcars[i2])
        {
            if (!ispassenger)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                return SendClientMessage(playerid, 0x636363FF, "Купи си превозното средство и ще го караш !");
            }
        }
        if (vehicleid == carshopcars2[i2])
        {
            if (!ispassenger)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                return SendClientMessage(playerid, 0x636363FF, "Купи си превозното средство и ще го караш !");
            }
        }
    }
    if (vehicleid == aztecasVehs[12])
    {
        if (PlayerInfo[playerid][pTeam] != 5)
        {
            new Float:cx, Float:cy, Float:cz;
            GetPlayerPos(playerid, cx, cy, cz);
            SetPlayerPos(playerid, cx, cy, cz);
            new string256z[256];
            format(string256z, 256, "Това превозно средство принадлежи на Varrio Los Aztecas");
            return SendClientMessage(playerid, 0x636363FF, string256z);
        }
    }
    if (vehicleid == ballasVehs[10])
    {
        if (PlayerInfo[playerid][pTeam] != 3)
        {
            new Float:cx, Float:cy, Float:cz;
            GetPlayerPos(playerid, cx, cy, cz);
            SetPlayerPos(playerid, cx, cy, cz);
            new string256z[256];
            format(string256z, 256, "Това превозно средство принадлежи на Rolling Heights Ballas");
            return SendClientMessage(playerid, 0x636363FF, string256z);
        }
    }
    if (vehicleid == cripzVehs[9])
    {
        if (PlayerInfo[playerid][pTeam] != 6)
        {
            new Float:cx, Float:cy, Float:cz;
            GetPlayerPos(playerid, cx, cy, cz);
            SetPlayerPos(playerid, cx, cy, cz);
            new string256z[256];
            format(string256z, 256, "Това превозно средство принадлежи на Vinewood Cripz");
            return SendClientMessage(playerid, 0x636363FF, string256z);
        }
    }
    if (vehicleid == cripzVehs[9])
    {
        if (PlayerInfo[playerid][pTeam] != 6)
        {
            new Float:cx, Float:cy, Float:cz;
            GetPlayerPos(playerid, cx, cy, cz);
            SetPlayerPos(playerid, cx, cy, cz);
            new string256z[256];
            format(string256z, 256, "Това превозно средство принадлежи на Vinewood Cripz");
            return SendClientMessage(playerid, 0x636363FF, string256z);
        }
    }
    if (!ispassenger)
    {
        if (isVipGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_VIP)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_VIP][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isGroveGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_GROVE)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_GROVE][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isBallasGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_BALLAS)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_BALLAS][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isVagosGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_VAGOS)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_VAGOS][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isAztecasGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_AZTECAS)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_AZTECAS][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isCripzGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_CRIPZ)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_CRIPZ][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isTriadsGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_TRIADS)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_TRIADS][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isRifaGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_RIFA)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_RIFA][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isSoaGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_SOA)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_SOA][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isNangGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_NANG)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_NANG][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isItalianGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_ITALIAN)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_ITALIAN][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isBountyGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_BOUNTY)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_BOUNTY][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isThugLifeGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_THUGLIFE)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_THUGLIFE][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isCrewGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_CREW)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_CREW][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isIntensePDGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_INTENSE_POLICE][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
            if (isIntensePDGangVehDUTY[vehicleid] == true)
            {
                if (!PlayerInfo[playerid][pIPDDuty])
                {
                    new Float:cx, Float:cy, Float:cz;
                    GetPlayerPos(playerid, cx, cy, cz);
                    SetPlayerPos(playerid, cx, cy, cz);
                    new string256z[256];
                    return SendClientMessage(playerid, 0x636363FF, "Трябва да си на смяна за да караш това превозно средство!");
                }
            }
        }
    }
    if (!ispassenger)
    {
        if (isSoldierGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_SOLDIER)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_SOLDIER][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isYakuzaGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_YAKUZA)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_YAKUZA][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isSyndicateGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_SYNDICATE)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_SYNDICATE][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isBloodMafiaGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_BLOODMAFIA)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_BLOODMAFIA][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isMS13GangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_MS13)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_MS13][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isBGMafiaGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_BGMAFIA)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_BGMAFIA][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (is343GangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_343)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_343][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (GetVehicleModel(vehicleid) == 454 || GetVehicleModel(vehicleid) == 472 || GetVehicleModel(vehicleid) == 473 || GetVehicleModel(vehicleid) == 484 || GetVehicleModel(vehicleid) == 430 || GetVehicleModel(vehicleid) == 446 || GetVehicleModel(vehicleid) == 452 || GetVehicleModel(vehicleid) == 453 || GetVehicleModel(vehicleid) == 493 || GetVehicleModel(vehicleid) == 595)
    {
        if (!ispassenger)
        {
            if (PlayerInfo[playerid][pLodka] == 0)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                SendClientMessage(playerid, 0x636363FF, "Ти нямаш шофьорска книжка за лодка!");
                return 0;
            }
        }
    }
    if (GetVehicleModel(vehicleid) == 460 || GetVehicleModel(vehicleid) == 476 || GetVehicleModel(vehicleid) == 511 || GetVehicleModel(vehicleid) == 512 || GetVehicleModel(vehicleid) == 513 || GetVehicleModel(vehicleid) == 519 || GetVehicleModel(vehicleid) == 520 || GetVehicleModel(vehicleid) == 553 || GetVehicleModel(vehicleid) == 577 || GetVehicleModel(vehicleid) == 592)
    {
        if (!ispassenger)
        {
            if (PlayerInfo[playerid][pSamolet] == 0)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                SendClientMessage(playerid, 0x636363FF, "Ти нямаш шофьорска книжка за самолет!");
                return 0;
            }
        }
    }
    if (GetVehicleModel(vehicleid) == 417 || GetVehicleModel(vehicleid) == 425 || GetVehicleModel(vehicleid) == 447 || GetVehicleModel(vehicleid) == 460 || GetVehicleModel(vehicleid) == 469 || GetVehicleModel(vehicleid) == 487 || GetVehicleModel(vehicleid) == 488 || GetVehicleModel(vehicleid) == 497 || GetVehicleModel(vehicleid) == 548 || GetVehicleModel(vehicleid) == 563)
    {
        if (!ispassenger)
        {
            if (PlayerInfo[playerid][pHelikopter] == 0)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                SendClientMessage(playerid, 0x636363FF, "Ти нямаш шофьорска книжка за хеликоптер!");
                return 0;
            }
        }
    }
    if (GetVehicleModel(vehicleid) == 537 || GetVehicleModel(vehicleid) == 538)
    {
        if (!ispassenger)
        {
            if (PlayerInfo[playerid][pVlak] == 0)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                SendClientMessage(playerid, 0x636363FF, "Ти нямаш шофьорска книжка за влак!");
                return 0;
            }
        }
    }
    if (!ispassenger)
    {
        for (new i2 = 0; i2 < 43; i2++)
        {
            if (vehicleid == afterwork[i2])
            {
                if (PlayerInfo[playerid][pAfterWork] == 0)
                {
                    new Float:cx, Float:cy, Float:cz;
                    GetPlayerPos(playerid, cx, cy, cz);
                    SetPlayerPos(playerid, cx, cy, cz);
                    SendClientMessage(playerid, 0x636363FF, "Не можеш да караш това превозно средство, защото не си завършил скоро работа!");
                }
            }
        }
    }
    if (vehicleid == carpizza[5] || vehicleid == carpizza[4] || vehicleid == carpizza[3] || vehicleid == carpizza[2] || vehicleid == carpizza[1])
    {
        SendClientMessage(playerid, 0xB35900FF, "Pizza Deliver: За да започнеш работа като доставчик на пици напиши /pizza.");
    }
    if (vehicleid == carsweeper[5] || vehicleid == carsweeper[4] || vehicleid == carsweeper[3] || vehicleid == carsweeper[2] || vehicleid == carsweeper[1])
    {
        SendClientMessage(playerid, 0xB35900FF, "Sweeper: За да започнеш работа като чистач на улици напиши /sweep.");
    }
    if (vehicleid == carcoalmine[5] || vehicleid == carcoalmine[4] || vehicleid == carcoalmine[3] || vehicleid == carcoalmine[2] || vehicleid == carcoalmine[1])
    {
        SendClientMessage(playerid, 0xB35900FF, "Coalmine: За да започнеш работа като шофьор на самосвал напиши /coalmine.");
    }
    if (vehicleid == carpilot[5] || vehicleid == carpilot[4] || vehicleid == carpilot[3] || vehicleid == carpilot[2] || vehicleid == carpilot[1])
    {
        SendClientMessage(playerid, 0xB35900FF, "Pilot: За да започнеш работа като пилот напиши /pilot.");
    }
    if (vehicleid == carbus[5] || vehicleid == carbus[4] || vehicleid == carbus[3] || vehicleid == carbus[2] || vehicleid == carbus[1])
    {
        SendClientMessage(playerid, 0xB35900FF, "Bus: За да започнеш работа като шофьр напиши /bus.");
    }
    if (vehicleid == carboat[5] || vehicleid == carboat[4] || vehicleid == carboat[3] || vehicleid == carboat[2] || vehicleid == carboat[1])
    {
        SendClientMessage(playerid, 0xB35900FF, "Boat: За да започнеш работа като шофьр на лодка напиши /boat.");
    }
    if (vehicleid == cardeliver[5] || vehicleid == cardeliver[4] || vehicleid == cardeliver[3] || vehicleid == cardeliver[2] || vehicleid == cardeliver[1])
    {
        SendClientMessage(playerid, 0xB35900FF, "Deliver: За да започнеш работа като доставчик напиши /deliver.");
    }
    if (vehicleid == cartruck[5] || vehicleid == cartruck[4] || vehicleid == cartruck[3] || vehicleid == cartruck[2] || vehicleid == cartruck[1])
    {
        SendClientMessage(playerid, 0xB35900FF, "Truck: За да започнеш работа като тираджия напиши /truck.");
    }
    if (!ispassenger)
    {
        for (new i2 = 0; i2 < 4; i2++)
        {
            if (vehicleid == fueltruck[i2])
            {
                if (PlayerInfo[playerid][pIFC] == 0)
                {
                    SendClientMessage(playerid, 0x636363FF, "Не можеш да караш това превозно средство, защото не си член на IFC!");
                    new Float:cx, Float:cy, Float:cz;
                    GetPlayerPos(playerid, cx, cy, cz);
                    SetPlayerPos(playerid, cx, cy, cz);
                }
                if (PlayerInfo[playerid][pIFCDuty] == 0)
                {
                    new Float:cx, Float:cy, Float:cz;
                    GetPlayerPos(playerid, cx, cy, cz);
                    SetPlayerPos(playerid, cx, cy, cz);
                    SendClientMessage(playerid, 0x636363FF, "Не можеш да караш това превозно средство, защото не си на служба!");
                }
            }
        }
    }
    return 1;
}
public OnPlayerExitVehicle(playerid, vehicleid)
{
    if (isDerbyPlayer[playerid])
    {
        SendClientMessage(playerid, 0xE5503BFF, "Derby: Не можеш да излезеш от превозното средство, докато си в дербито!");
        new Float:cx, Float:cy, Float:cz;
        GetPlayerPos(playerid, cx, cy, cz);
        SetPlayerPos(playerid, cx, cy, cz);
        PutPlayerInVehicle(playerid, vehicleid, 0);
    }

    if (GetVehicleTrailer(vehicleid) == fuelremarke[0] || GetVehicleTrailer(vehicleid) == fuelremarke[1] || GetVehicleTrailer(vehicleid) == fuelremarke[2])
    {
        TextDrawHideForPlayer(playerid, vehstatus2[playerid]);
    }
    drive[vehicleid] = 0;
    if (onWork[playerid] == 1)
    {
        new Float:cx, Float:cy, Float:cz;
        GetPlayerPos(playerid, cx, cy, cz);
        SetPlayerPos(playerid, cx, cy, cz);
        PutPlayerInVehicle(playerid, vehicleid, 0);
    }
    if (loadedtext[playerid] == 1)
    {
        TextDrawHideForPlayer(playerid, vehstatus2[playerid]);
        TextDrawHideForPlayer(playerid, vehstatus[playerid]);
        loadedtext[playerid] = 0;
    }
    return 1;
}
public OnTrailerUpdate(playerid, vehicleid)
{
    new withTank = 0;
    if (PlayerInfo[playerid][pIFCDuty] == 0)
    {
        if (GetVehicleTrailer(GetPlayerVehicleID(playerid)) == fuelremarke[0] || GetVehicleTrailer(GetPlayerVehicleID(playerid)) == fuelremarke[1] || GetVehicleTrailer(GetPlayerVehicleID(playerid)) == fuelremarke[2])
        {
            DetachTrailerFromVehicle(GetPlayerVehicleID(playerid));
            GetPlayerPos(playerid, X[playerid], Y[playerid], Z[playerid]);
            SetVehiclePos(GetPlayerVehicleID(playerid), X[playerid] + 1, Y[playerid] + 1, Z[playerid]);
            SendClientMessage(playerid, COLOR_GRAD1, "Трябва да влезеш на смяна за да закачиш ремаркето!");
        }
    }
    for (new i; i < 3; i++)
    {
        if (GetVehicleTrailer(GetPlayerVehicleID(playerid)) == fuelremarke[i])
        {
            new stringveha[115];
            format(stringveha, 115, "~n~~n~~n~~y~PT: %dL", vehfuel2[GetVehicleTrailer(GetPlayerVehicleID(playerid))]);
            TextDrawSetString(vehstatus2[playerid], stringveha);
            TextDrawShowForPlayer(playerid, vehstatus2[playerid]);
            vehStatus2On[playerid] = true;
        }
    }


    //TextDrawHideForPlayer(playerid,vehstatus2[playerid]);

    return 0;
}
public OnPlayerStateChange(playerid, newstate, oldstate)
{
    //SetTimerEx("OnPlayerUpdate", 62, true, "i", playerid);

    if (newstate == PLAYER_STATE_DRIVER)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        if (vehicleid == mechanicDutyVehs[0] || vehicleid == mechanicDutyVehs[1] || vehicleid == mechanicDutyVehs[2] ||
            vehicleid == mechanicDutyVehs[3] || vehicleid == mechanicDutyVehs[4] || vehicleid == mechanicDutyVehs[5] ||
            vehicleid == mechanicDutyVehs[6] || vehicleid == mechanicDutyVehs[7])
        {
            ToggleEngine(vehicleid, VEHICLE_PARAMS_OFF);
            SendClientMessage(playerid, 0x808000FF, "Трябва да платиш $150 за да ползваш Tow Truck! /epay или /exit ?");
        }
    }
    if (vehLocker[playerid] != -1)
    {
        if (newstate == PLAYER_STATE_PASSENGER || newstate == PLAYER_STATE_ONFOOT)
        {
            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                SetVehicleParamsForPlayer(vehLocker[playerid], i, 0, 0);
            }
        }
    }
    if (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER || newstate == PLAYER_STATE_ONFOOT)
    {
        vehLocker[playerid] = -1;
    }
    if (newstate == PLAYER_STATE_DRIVER)
    {
        SetPlayerArmedWeapon(playerid, 0);
        g_veh[playerid] = GetPlayerVehicleID(playerid);
    }
    if (AntiFallOfBike[playerid] == 1)
    {
        if (GetVehicleModel(g_veh[playerid]) == 509 || GetVehicleModel(g_veh[playerid]) == 510 || GetVehicleModel(g_veh[playerid]) == 481)
        {
            new Float:Health;
            GetPlayerHealth(playerid, Health);
            if (newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER && lastkey[playerid] != 16 && Health > 0.0)
            {
                PutPlayerInVehicle(playerid, g_veh[playerid], 0);
            }
        }
    }
    if (newstate == PLAYER_STATE_DRIVER)
    {
        drive[GetPlayerVehicleID(playerid)] = 1;
    }
    if (newstate == PLAYER_STATE_PASSENGER)
    {
        passenger[playerid] = true;
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 431 ||
            GetVehicleModel(GetPlayerVehicleID(playerid)) == 437 ||
            GetVehicleModel(GetPlayerVehicleID(playerid)) == 508 ||
            GetVehicleModel(GetPlayerVehicleID(playerid)) == 431 ||
            GetVehicleModel(GetPlayerVehicleID(playerid)) == 573)
        {
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, GetPlayerVehicleID(playerid));
            SetPlayerPos(playerid, 2021.8448, 2235.1274, 2103.9536);
            SetPlayerFacingAngle(playerid, 180.7037);
            SetCameraBehindPlayer(playerid);
        }
    }
    if (newstate == PLAYER_STATE_DRIVER)
    {
        driver[playerid] = 1;
        PlayerInfo[playerid][pFuel] = 25;
    }
    if (newstate != PLAYER_STATE_DRIVER)
    {
        driver[playerid] = 0;
        PlayerInfo[playerid][pFuel] = -1;
    }
    if (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
        if (loadedtext[playerid] == 0)
        {
            if (speedo[playerid] == 0)
            {
                TextDrawShowForPlayer(playerid, vehstatus[playerid]);
            }
            loadedtext[playerid] = 1;
        }
        GetVehicleHealth(GetPlayerVehicleID(playerid), vehhealth[playerid]);
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) != 481 &&
            GetVehicleModel(GetPlayerVehicleID(playerid)) != 509 &&
            GetVehicleModel(GetPlayerVehicleID(playerid)) != 510 &&
            GetVehicleModel(GetPlayerVehicleID(playerid)) != 481)
        {
            if (speedo[playerid] == 0)
            {
                if (kmh[playerid] == 0)
                {
                    format(stringvehicle[playerid], 115, "~w~Speed: %dkm/h~n~~g~Health: %.0f~n~~r~Fuel: %dL", GetVehicleKmh(GetPlayerVehicleID(playerid)), vehhealth[playerid], vehfuel[GetPlayerVehicleID(playerid)]);
                }
                else
                {
                    new vehicleid, Float:speed_x, Float:speed_y, Float:speed_z, final_speed_int;
                    vehicleid = GetPlayerVehicleID(playerid);
                    GetVehicleVelocity(vehicleid, speed_x, speed_y, speed_z);
                    final_speed_int = GetVehicleKmh(vehicleid);
                    format(stringvehicle[playerid], 115, "~w~Speed: %dm/s~n~~g~Health: %.0f~n~~r~Fuel: %dL", final_speed_int, vehhealth[playerid], vehfuel[GetPlayerVehicleID(playerid)]);
                }
            }
        }
        else
        {
            if (speedo[playerid] == 0)
            {
                if (kmh[playerid] == 0)
                {
                    format(stringvehicle[playerid], 115, "~w~Speed: %dkm/h~n~~g~Health: %.0f", GetVehicleKmh(GetPlayerVehicleID(playerid)), vehhealth[playerid]);
                }
                else
                {
                    new vehicleid, Float:speed_x, Float:speed_y, Float:speed_z, final_speed_int;
                    vehicleid = GetPlayerVehicleID(playerid);
                    GetVehicleVelocity(vehicleid, speed_x, speed_y, speed_z);
                    final_speed_int = GetVehicleKmh(vehicleid);
                    format(stringvehicle[playerid], 115, "~w~Speed: %dm/s~n~~g~Health: %.0f", final_speed_int, vehhealth[playerid]);
                }
            }
        }
        TextDrawSetString(vehstatus[playerid], stringvehicle[playerid]);
    }
    if (oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT || oldstate == PLAYER_STATE_PASSENGER && newstate == PLAYER_STATE_ONFOOT || oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_WASTED || oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_SPECTATING || oldstate == PLAYER_STATE_PASSENGER && newstate == PLAYER_STATE_SPECTATING ||
        oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_SPECTATING)
    {
        if (loadedtext[playerid] == 1)
        {
            TextDrawHideForPlayer(playerid, vehstatus[playerid]);
            loadedtext[playerid] = 0;
        }
    }
    return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
    if (IsPlayerInRangeOfPoint(playerid, 5.0, DeathmatchCheckpoint1) || IsPlayerInRangeOfPoint(playerid, 5.0, DeathmatchCheckpoint2))
    {
        if (GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            if (PlayerInfo[playerid][pADuty] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да влезеш, когато си ADMIN ON Duty!");
            if (onWork[playerid] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "В момента си на раобта и не можеш да влезеш !");
            if (cmn1[playerid] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да влезеш в Deathmatch, докато си CMN1!");
            DisablePlayerCheckpoint(playerid);
            DisablePlayerRaceCheckpoint(playerid);
            playerInDeathmatch[playerid] = true;
            SetPlayerInterior(playerid, 0);
            SetPlayerHealth(playerid, 100);
            SetPlayerArmour(playerid, 0);
            ResetPlayerWeapons(playerid);
            GivePlayerWeapon(playerid, deathmatchGun, 10000);
            SendClientMessage(playerid, COLOR_DEATHMATCH, "Deathmatch: Ти влезе в битката! Не удряй и не стреляй, докато тя не започне!");
            SendClientMessage(playerid, COLOR_DEATHMATCH, "Deathmatch: За да излезеш  от нея напиши /leavedm");
            GetPlayerLastCoors(playerid);
            SetPlayerVirtualWorld(playerid, 1);
            deathmatchPlayers += 1;
            if (deathmatchPlayers == 2)
            {
                deathmatchStartTimer = 120;
                SendClientMessageToAll(COLOR_DEATHMATCH, "Deathmatch: След 120 секунди ще стартира битката, побързайте, които не са дошли!");
            }
            if (deathmatchPlayers < 2)
            {
                deathmatchStartTimer = 0;
            }
            if (deathmatchFightArea == 1)
            {
                new randomSpawn = randomex(1, 3);
                if (randomSpawn == 1)
                {
                    SetPlayerPos(playerid, DeathmatchPlace1Spawn1);
                }
                else if (randomSpawn == 2)
                {
                    SetPlayerPos(playerid, DeathmatchPlace1Spawn2);
                }
                else if (randomSpawn == 3)
                {
                    SetPlayerPos(playerid, DeathmatchPlace1Spawn3);
                }
            }
            else if (deathmatchFightArea == 2)
            {
                new randomSpawn = randomex(1, 3);
                if (randomSpawn == 1)
                {
                    SetPlayerPos(playerid, DeathmatchPlace2Spawn1);
                }
                else if (randomSpawn == 2)
                {
                    SetPlayerPos(playerid, DeathmatchPlace2Spawn2);
                }
                else if (randomSpawn == 3)
                {
                    SetPlayerPos(playerid, DeathmatchPlace2Spawn3);
                }
            }
        }
    }


    if (IsPlayerInRangeOfPoint(playerid, 5.0, MoneyBoxDeliverpoint1) || IsPlayerInRangeOfPoint(playerid, 5.0, MoneyBoxDeliverpoint2) ||
        IsPlayerInRangeOfPoint(playerid, 5.0, MoneyBoxDeliverpoint3) || IsPlayerInRangeOfPoint(playerid, 5.0, MoneyBoxDeliverpoint4))
    { //goto
        if (GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            GivePlayerCMN1Status(playerid);
            cmn1Mission[playerid] = MISSION_MONEYBOX;
            new stringmoneybox[115];
            format(stringmoneybox, 115, "~w~YOU WON:~n~~g~$%d", cmn1Money);
            GameTextForPlayer(playerid, stringmoneybox, 3000, 3);
            format(stringmoneybox, 115, "Moneybox: %s успешно занесе куфара и спечели $%d", GetPlayerNickname(playerid), cmn1Money);
            SendClientMessageToAll(0x40BF00FF, stringmoneybox);
            GivePlayerWantedLevel(playerid, 1, "Грабеж на пари");
            format(stringmoneybox, 115, "CMN1: %s е заподозрян в грабеж,убий го и ще получиш CMN1 Kill.", GetPlayerNickname(playerid));
            SendClientMessageToAll(0xF97804FF, stringmoneybox);
            SendClientMessage(playerid, 0xF97804FF, "CMN1: Трябва да оцелееш 5 минути за да не си преследван повече.");
            playerWithMoneyBox[playerid] = false;
            missionActive = MISSION_NONE;
            for (new i; i < MAX_PLAYERS; i++)
            {
                if (onWork[i] == 0 && gpsOn[i] == false)
                {
                    DisablePlayerCheckpoint(i);
                }
            }
            isMoneyBoxGet = false;
            whoHaveMoneyBox = -1;
        }
    }


    if (PlayerInfo[playerid][pBizO] > -1)
    {
        gpsOn[playerid] = false;
        new playersBiz = PlayerInfo[playerid][pBizO];
        new Float: playerBizX = BizInfo[playersBiz][bX];
        new Float: playerBizY = BizInfo[playersBiz][bY];
        new Float: playerBizZ = BizInfo[playersBiz][bZ];
        if (IsPlayerInRangeOfPoint(playerid, 4.0, playerBizX, playerBizY, playerBizZ))
        {
            SendClientMessage(playerid, 0xffff00FF, "Ти пристигна до твоя бизнес!");
            DisablePlayerCheckpoint(playerid);
        }
    }
    if (PlayerInfo[playerid][pHouseO] > -1)
    {
        gpsOn[playerid] = false;
        new playersHouse = PlayerInfo[playerid][pHouseO];
        new Float: playerHouseX = HouseInfo[playersHouse][hX];
        new Float: playerHouseY = HouseInfo[playersHouse][hY];
        new Float: playerHouseZ = HouseInfo[playersHouse][hZ];
        if (IsPlayerInRangeOfPoint(playerid, 4.0, playerHouseX, playerHouseY, playerHouseZ))
        {
            SendClientMessage(playerid, 0xffff00FF, "Ти пристигна до твоята къща!");
            DisablePlayerCheckpoint(playerid);
        }
    }
    if (onWork[playerid] == 1)
    {
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 431)
        {
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint1))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint2, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint2))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint3, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint3))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint4, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint4))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint5, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint5))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint6, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint6))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint7, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint7))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint8, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint8))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint9, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint9))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint10, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint10))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint11, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint11))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint12, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint12))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint13, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint13))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint14, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint14))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint15, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint15))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint16, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint16))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint17, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint17))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint18, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint18))
            {
                SetPlayerCheckpoint(playerid, BusTakePoint, 4.0);
                SendClientMessage(playerid, 0xB35900FF, "Ти премина през всички червени маркери, сега трябва да върнеш буса.");
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusTakePoint))
            {
                PlayerInfo[playerid][pAfterWork] = 30 * 60;
                DisablePlayerCheckpoint(playerid);
                SendClientMessage(playerid, 0xB35900FF, "Ти премина през всички маркери и получаваш 5,000$ и 5 EP.");
                GivePlayerMoney(playerid, 5000);
                GivePlayerEP(playerid, 5);
                onWork[playerid] = 0;
                ToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_OFF);
                if (PlayerInfo[playerid][pVip] < 3)
                {
                    PlayerInfo[playerid][pBusTimerWorkAgain] = 60 * 60;
                }
                if (PlayerInfo[playerid][pVip] >= 3 && PlayerInfo[playerid][pVip] < 6)
                {
                    PlayerInfo[playerid][pBusTimerWorkAgain] = 30 * 60;
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 30 минути.");
                }
                if (PlayerInfo[playerid][pVip] == 6 || CheckFreeVIP() == 1)
                {
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 20 минути.");
                    SendClientMessage(playerid, 0xB35900FF, "Ти спечели 3 EP, защото си VIP Level 6.");
                    PlayerInfo[playerid][pBusTimerWorkAgain] = 20 * 60;
                    GivePlayerEP(playerid, 3);
                }
                RestartPlayerColor(playerid);
                GivePlayerMission(playerid);
            }
        }
    }
    if (onWork[playerid] == 1)
    {
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 406)
        {
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineCheckPoint1))
            {
                SetPlayerCheckpoint(playerid, CoalmineCheckPoint2, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineCheckPoint2))
            {
                SetPlayerCheckpoint(playerid, CoalmineCheckPoint3, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineCheckPoint3))
            {
                SetPlayerCheckpoint(playerid, CoalmineCheckPoint4, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineCheckPoint4))
            {
                SetPlayerCheckpoint(playerid, CoalmineCheckPoint5, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineCheckPoint5))
            {
                SetPlayerCheckpoint(playerid, CoalmineCheckPoint6, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineCheckPoint6))
            {
                SetPlayerCheckpoint(playerid, CoalmineCheckPoint7, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineCheckPoint7))
            {
                SetPlayerCheckpoint(playerid, CoalmineCheckPoint8, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineCheckPoint8))
            {
                SetPlayerCheckpoint(playerid, CoalmineTakePoint, 4.0);
                SendClientMessage(playerid, 0xB35900FF, "Ти премина през всички червени маркери, сега трябва да върнеш самосвала.");
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineTakePoint))
            {
                //
                DisablePlayerCheckpoint(playerid);
                PlayerInfo[playerid][pAfterWork] = 30 * 60;
                SendClientMessage(playerid, 0xB35900FF, "Ти премина през всички маркери и получаваш 5,000$ и 5 EP.");
                GivePlayerMoney(playerid, 5000);
                GivePlayerEP(playerid, 5);
                onWork[playerid] = 0;
                ToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_OFF);
                if (PlayerInfo[playerid][pVip] < 3)
                {
                    PlayerInfo[playerid][pCoalmineTimerWorkAgain] = 60 * 60;
                }
                if (PlayerInfo[playerid][pVip] >= 3 && PlayerInfo[playerid][pVip] < 6)
                {
                    PlayerInfo[playerid][pCoalmineTimerWorkAgain] = 30 * 60;
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 30 минути.");
                }
                if (PlayerInfo[playerid][pVip] == 6 || CheckFreeVIP() == 1)
                {
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 20 минути.");
                    SendClientMessage(playerid, 0xB35900FF, "Ти спечели 3 EP, защото си VIP Level 6.");
                    PlayerInfo[playerid][pCoalmineTimerWorkAgain] = 20 * 60;
                    GivePlayerEP(playerid, 3);
                }
                RestartPlayerColor(playerid);
                GivePlayerMission(playerid);
            }
        }
    }
    if (onWork[playerid] == 1)
    {
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 574)
        {
            if (IsPlayerInRangeOfPoint(playerid, 4.0, SweepCheckPoint1))
            {
                SetPlayerCheckpoint(playerid, SweepCheckPoint2, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, SweepCheckPoint2))
            {
                SetPlayerCheckpoint(playerid, SweepCheckPoint3, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, SweepCheckPoint3))
            {
                SetPlayerCheckpoint(playerid, SweepCheckPoint4, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, SweepCheckPoint4))
            {
                SetPlayerCheckpoint(playerid, SweepCheckPoint5, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, SweepCheckPoint5))
            {
                SetPlayerCheckpoint(playerid, SweepCheckPoint6, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, SweepCheckPoint6))
            {
                SetPlayerCheckpoint(playerid, SweepTakePoint, 4.0);
                SendClientMessage(playerid, 0xB35900FF, "Ти премина през всички червени маркери, сега трябва да върнеш превозното средство.");
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, SweepTakePoint))
            {
                //
                DisablePlayerCheckpoint(playerid);
                PlayerInfo[playerid][pAfterWork] = 30 * 60;
                SendClientMessage(playerid, 0xB35900FF, "Ти почисти всички улици и получаваш 5,000$ и 5 EP.");
                GivePlayerMoney(playerid, 5000);
                GivePlayerEP(playerid, 5);
                onWork[playerid] = 0;
                ToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_OFF);
                if (PlayerInfo[playerid][pVip] < 3)
                {
                    PlayerInfo[playerid][pSweeperTimerWorkAgain] = 60 * 60;
                }
                if (PlayerInfo[playerid][pVip] >= 3 && PlayerInfo[playerid][pVip] < 6)
                {
                    PlayerInfo[playerid][pSweeperTimerWorkAgain] = 30 * 60;
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 30 минути.");
                }
                if (PlayerInfo[playerid][pVip] == 6 || CheckFreeVIP() == 1)
                {
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 20 минути.");
                    SendClientMessage(playerid, 0xB35900FF, "Ти спечели 3 EP, защото си VIP Level 6.");
                    PlayerInfo[playerid][pSweeperTimerWorkAgain] = 20 * 60;
                    GivePlayerEP(playerid, 3);
                }
                RestartPlayerColor(playerid);
                GivePlayerMission(playerid);
            }
        }
    }
    if (onWork[playerid] == 1)
    {
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 448)
        {
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaCheckPoint1))
            {
                SetPlayerCheckpoint(playerid, PizzaCheckPoint2, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaCheckPoint2))
            {
                SetPlayerCheckpoint(playerid, PizzaCheckPoint3, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaCheckPoint3))
            {
                SetPlayerCheckpoint(playerid, PizzaCheckPoint4, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaCheckPoint4))
            {
                SetPlayerCheckpoint(playerid, PizzaCheckPoint5, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaCheckPoint5))
            {
                SetPlayerCheckpoint(playerid, PizzaCheckPoint6, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaCheckPoint6))
            {
                SetPlayerCheckpoint(playerid, PizzaCheckPoint7, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaCheckPoint7))
            {
                SetPlayerCheckpoint(playerid, PizzaCheckPoint8, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaCheckPoint8))
            {
                SetPlayerCheckpoint(playerid, PizzaTakePoint, 4.0);
                SendClientMessage(playerid, 0xB35900FF, "Ти премина през всички червени маркери, сега трябва да върнеш мотора.");
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaTakePoint))
            {
                //
                DisablePlayerCheckpoint(playerid);
                PlayerInfo[playerid][pAfterWork] = 30 * 60;
                SendClientMessage(playerid, 0xB35900FF, "Ти достави всички пици и получаваш 5,000$ и 5 EP.");
                GivePlayerMoney(playerid, 5000);
                GivePlayerEP(playerid, 5);
                onWork[playerid] = 0;
                ToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_OFF);
                if (PlayerInfo[playerid][pVip] < 3)
                {
                    PlayerInfo[playerid][pPizzaTimerWorkAgain] = 60 * 60;
                }
                if (PlayerInfo[playerid][pVip] >= 3 && PlayerInfo[playerid][pVip] < 6)
                {
                    PlayerInfo[playerid][pPizzaTimerWorkAgain] = 30 * 60;
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 30 минути.");
                }
                if (PlayerInfo[playerid][pVip] == 6 || CheckFreeVIP() == 1)
                {
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 20 минути.");
                    SendClientMessage(playerid, 0xB35900FF, "Ти спечели 3 EP, защото си VIP Level 6.");
                    PlayerInfo[playerid][pPizzaTimerWorkAgain] = 20 * 60;
                    GivePlayerEP(playerid, 3);
                }
                RestartPlayerColor(playerid);
                GivePlayerMission(playerid);
            }
        }
    }
    if (onWork[playerid] == 1)
    {
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 511)
        {
            if (IsPlayerInRangeOfPoint(playerid, 5.0, PilotCheckPoint1))
            {
                DisablePlayerCheckpoint(playerid);
                SetPlayerCheckpoint(playerid, PilotCheckPoint2, 5.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 5.0, PilotCheckPoint2))
            {
                DisablePlayerCheckpoint(playerid);
                SetPlayerCheckpoint(playerid, PilotCheckPoint3, 5.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 5.0, PizzaCheckPoint3))
            {
                DisablePlayerCheckpoint(playerid);
                SetPlayerCheckpoint(playerid, PilotTakePoint, 5.0);
                SendClientMessage(playerid, 0xB35900FF, "Ти премина през всички червени маркери, сега трябва да върнеш самолета.");
            }
            if (IsPlayerInRangeOfPoint(playerid, 10.0, PilotTakePoint))
            {
                //
                DisablePlayerCheckpoint(playerid);
                PlayerInfo[playerid][pAfterWork] = 30 * 60;
                //
                SendClientMessage(playerid, 0xB35900FF, "Ти достави всички пратки и получаваш 5,000$ и 5 EP.");
                GivePlayerMoney(playerid, 5000);
                GivePlayerEP(playerid, 5);
                onWork[playerid] = 0;
                ToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_OFF);
                if (PlayerInfo[playerid][pVip] < 3)
                {
                    PlayerInfo[playerid][pPilotTimerWorkAgain] = 60 * 60;
                }
                if (PlayerInfo[playerid][pVip] >= 3 && PlayerInfo[playerid][pVip] < 6)
                {
                    PlayerInfo[playerid][pPilotTimerWorkAgain] = 30 * 60;
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 30 минути.");
                }
                if (PlayerInfo[playerid][pVip] == 6 || CheckFreeVIP() == 1)
                {
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 20 минути.");
                    SendClientMessage(playerid, 0xB35900FF, "Ти спечели 3 EP, защото си VIP Level 6.");
                    PlayerInfo[playerid][pPilotTimerWorkAgain] = 20 * 60;
                    GivePlayerEP(playerid, 3);
                }
                RestartPlayerColor(playerid);
                GivePlayerMission(playerid);
            }
        }
    }
    if (onWork[playerid] == 1)
    {
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 609)
        {
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint1))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint2, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint2))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint3, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint3))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint4, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint4))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint5, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint5))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint6, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint6))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint7, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint7))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint8, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint8))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint9, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint9))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint10, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint10))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint11, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint11))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint12, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint12))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint13, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint13))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint14, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint14))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint15, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint15))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint16, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint16))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint17, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint17))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint18, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint18))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint19, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint19))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint20, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint20))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint21, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint21))
            {
                SetPlayerCheckpoint(playerid, DeliverTakePoint, 4.0);
                SendClientMessage(playerid, 0xB35900FF, "Ти премина през всички червени маркери, сега трябва да върнеш буса.");
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverTakePoint))
            {
                //
                DisablePlayerCheckpoint(playerid);
                PlayerInfo[playerid][pAfterWork] = 30 * 60;
                SendClientMessage(playerid, 0xB35900FF, "Ти достави всички пратки и получаваш 5,000$ и 5 EP.");
                GivePlayerMoney(playerid, 5000);
                GivePlayerEP(playerid, 5);
                onWork[playerid] = 0;
                ToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_OFF);
                if (PlayerInfo[playerid][pVip] < 3)
                {
                    PlayerInfo[playerid][pDeliverTimerWorkAgain] = 60 * 60;
                }
                if (PlayerInfo[playerid][pVip] >= 3 && PlayerInfo[playerid][pVip] < 6)
                {
                    PlayerInfo[playerid][pDeliverTimerWorkAgain] = 30 * 60;
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 30 минути.");
                }
                if (PlayerInfo[playerid][pVip] == 6 || CheckFreeVIP() == 1)
                {
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 20 минути.");
                    SendClientMessage(playerid, 0xB35900FF, "Ти спечели 3 EP, защото си VIP Level 6.");
                    PlayerInfo[playerid][pDeliverTimerWorkAgain] = 20 * 60;
                    GivePlayerEP(playerid, 3);
                }
                RestartPlayerColor(playerid);
                GivePlayerMission(playerid);
            }
        }
    }
    //}
    return 1;
}


public OnPlayerEnterRaceCheckpoint(playerid)
{

    if (playerInStreetRace[playerid] == true && streetRaceStarted == true)
    {
        if (streetRaceTypeIndex == 1)
        {
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceSprintCheckPoint1)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceSprintCheckPoint2, StreetRaceSprintCheckPoint3, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceSprintCheckPoint2)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceSprintCheckPoint3, StreetRaceSprintCheckPoint4, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceSprintCheckPoint3)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceSprintCheckPoint4, StreetRaceSprintFinalPoint, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceSprintCheckPoint4)) SetPlayerRaceCheckpoint(playerid, 1, StreetRaceSprintFinalPoint, StreetRaceSprintFinalPoint, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceSprintFinalPoint))
            {

                PlayerFinishingRace(playerid);

            }
        }
        else if (streetRaceTypeIndex == 2)
        {
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDriftCheckPoint1)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceDriftCheckPoint2, StreetRaceDriftCheckPoint3, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDriftCheckPoint2)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceDriftCheckPoint3, StreetRaceDriftCheckPoint4, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDriftCheckPoint3)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceDriftCheckPoint4, StreetRaceDriftFinalPoint, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDriftCheckPoint4)) SetPlayerRaceCheckpoint(playerid, 1, StreetRaceDriftFinalPoint, StreetRaceDriftFinalPoint, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDriftFinalPoint))
            {

                PlayerFinishingRace(playerid);

            }
        }
        else if (streetRaceTypeIndex == 3)
        {
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDragCheckPoint1)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceDragCheckPoint2, StreetRaceDragCheckPoint3, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDragCheckPoint2)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceDragCheckPoint3, StreetRaceDragCheckPoint4, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDragCheckPoint3)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceDragCheckPoint4, StreetRaceDragFinalPoint, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDragCheckPoint4)) SetPlayerRaceCheckpoint(playerid, 1, StreetRaceDragFinalPoint, StreetRaceDragFinalPoint, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDragFinalPoint))
            {

                PlayerFinishingRace(playerid);

            }
        }
        else if (streetRaceTypeIndex == 4)
        {
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceLapsCheckPoint1)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceLapsCheckPoint2, StreetRaceLapsCheckPoint3, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceLapsCheckPoint2)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceLapsCheckPoint3, StreetRaceLapsCheckPoint4, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceLapsCheckPoint3)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceLapsCheckPoint4, StreetRaceLapsFinalPoint, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceLapsCheckPoint4)) SetPlayerRaceCheckpoint(playerid, 1, StreetRaceLapsFinalPoint, StreetRaceLapsFinalPoint, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceLapsFinalPoint))
            {

                PlayerFinishingRace(playerid);

            }
        }
        else if (streetRaceTypeIndex == 5)
        {
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceOffroadCheckPoint1)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceOffroadCheckPoint2, StreetRaceOffroadCheckPoint3, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceOffroadCheckPoint2)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceOffroadCheckPoint3, StreetRaceOffroadCheckPoint4, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceOffroadCheckPoint3)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceOffroadCheckPoint4, StreetRaceOffroadFinalPoint, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceOffroadCheckPoint4)) SetPlayerRaceCheckpoint(playerid, 1, StreetRaceOffroadFinalPoint, StreetRaceOffroadFinalPoint, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceOffroadFinalPoint))
            {

                PlayerFinishingRace(playerid);

            }
        }
    }

    if (IsInStreetRaceStartingPoint(playerid) != -1)
    {
        if (PlayerInfo[playerid][pADuty] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да влезеш в състезанието, когато си ADMIN ON Duty!");
        if (onWork[playerid] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да влезеш в състезанието, когато си на работа !");
        if (!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си в превозно средство за да влезеш в състезанието!");
        if (driver[playerid] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си шофьор за да влезеш в състезанието!");
        if (cmn1[playerid] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да влезеш в състезанието, докато си CMN1!");
        DisablePlayerRaceCheckpoint(playerid);
        new hisVeh = GetPlayerVehicleID(playerid);
        SetPlayerVirtualWorld(playerid, 1);
        SetVehicleVirtualWorld(hisVeh, 1);
        PutPlayerInVehicle(playerid, hisVeh, 0);
        streetRacePlayers += 1;
        playerInStreetRace[playerid] = true;
        streetRacePlayerColorChange[playerid] = 2;
        if (streetRacePlayers == 1)
        {
            format(string256, 256, "StreetRace: %s влезе в състезанието. Трябва още един човек, преди то да започне!", GetPlayerNickname(playerid));
            SendClientMessageToAll(COLOR_STREETRACE, string256);
            if (streetRaceStartTimer > 0) streetRaceStartTimer = 0;
        }
        else if (streetRacePlayers == 2)
        {
            format(string256, 256, "StreetRace: %s влезе в състезанието, то ще започне след 2 минути!", GetPlayerNickname(playerid));
            SendClientMessageToAll(COLOR_STREETRACE, string256);
            streetRaceStartTimer = 2 * 60;
        }
        else if (streetRacePlayers == 10)
        {
            format(string256, 256, "StreetRace: %s влезе в състезанието, то ще започне след 10 секунди!", GetPlayerNickname(playerid));
            SendClientMessageToAll(COLOR_STREETRACE, string256);
            streetRaceStartTimer = 10;
        }
        SendClientMessage(playerid, COLOR_STREETRACE, "StreetRace: За да излезеш от състезанието напиши /leaverace");
    }


    if (IsPlayerInRangeOfPoint(playerid, 5.0, MoneyBoxCheckpoint1) || IsPlayerInRangeOfPoint(playerid, 5.0, MoneyBoxCheckpoint2) ||
        IsPlayerInRangeOfPoint(playerid, 5.0, MoneyBoxCheckpoint3) || IsPlayerInRangeOfPoint(playerid, 5.0, MoneyBoxCheckpoint4))
    { //goto
        if (GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            if (PlayerInfo[playerid][pADuty] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да вземеш куфара, когато си ADMIN ON Duty!");
            if (onWork[playerid] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да вземеш куфара, когато си на работа !");
            if (cmn1[playerid] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да взмеш куфара, докато си CMN1!");
            SendClientMessage(playerid, 0x40BF00FF, "Moneybox: Сега занеси куфара до другия червен маркер за да спечелиш пари!");
            format(string256, 256, "Moneybox: %s взе куфара с пари. Не му позволявайте да достигне до следващия червен маркер!", GetPlayerNickname(playerid));
            SendClientMessageToAll(0x40BF00FF, string256);
            moneyBoxDPID = random(allMoneyBoxDeliverPoints);
            playerWithMoneyBox[playerid] = true;
            whoHaveMoneyBox = playerid;
            isMoneyBoxGet = true;
            for (new allPlayers; allPlayers < MAX_PLAYERS; allPlayers++)
            {
                if (IsPlayerConnected(allPlayers))
                {
                    GivePlayerMBDeliverPoint(allPlayers);
                }
            }
        }
    }
    return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:Current = GetPlayerMenu(playerid);
    if (Current == TuningMenu)
    {
        switch (row)
        {
            case 0:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Paintjobs, playerid);
                }
            case 1:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Colors, playerid);
                }
            case 2:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Exhausts, playerid);
                }
            case 3:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Frontbumper, playerid);
                }
            case 4:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Rearbumper, playerid);
                }
            case 5:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Roof, playerid);
                }
            case 6:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Spoilers, playerid);
                }
            case 7:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Sideskirts, playerid);
                }
            case 8:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Wheels, playerid);
                }
            case 9:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Others, playerid);
                }
        }
    }
    if (Current == Paintjobs)
    {
        switch (row)
        {
            case 0:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 560 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 || // Broadway
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 535 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehiclePaintjob(car, 0);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added paintjob to car");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] Paintjob is only for Wheel Arch Angrls and Loco Low Co types of cars");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 560 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 || // Broadway
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 535 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehiclePaintjob(car, 1);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added paintjob to car");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] Paintjob is only for Wheel Arch Angrls and Loco Low Co types of cars");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 560 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 || // Broadway
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 535 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehiclePaintjob(car, 2);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added paintjob to car");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] Paintjob is only for Wheel Arch Angrls and Loco Low Co types of cars");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 3:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 560 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 || // Broadway
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 535 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehiclePaintjob(car, 3);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added paintjob to car");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] Paintjob is only for Wheel Arch Angrls and Loco Low Co types of cars");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 4:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 560 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 || // Broadway
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 535 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehiclePaintjob(car, 4);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added paintjob to car");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] Paintjob is only for Wheel Arch Angrls and Loco Low Co types of cars");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 5:
            {
                ShowMenuForPlayer(TuningMenu, playerid);
            }
        }
    }
    if (Current == Colors)
    {
        switch (row)
        {
            case 0:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 0, 0);
                    ShowMenuForPlayer(Colors, playerid);
                }
                else
                {
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 1, 1);
                    ShowMenuForPlayer(Colors, playerid);
                }
                else
                {
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 3, 3);
                    ShowMenuForPlayer(Colors, playerid);
                }
                else
                {
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 3:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 79, 79);
                    ShowMenuForPlayer(Colors, playerid);
                }
                else
                {
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 4:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 86, 86);
                    ShowMenuForPlayer(Colors, playerid);
                }
                else
                {
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 5:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 6, 6);
                    ShowMenuForPlayer(Colors, playerid);
                }
                else
                {
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 6:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 126, 126);
                    ShowMenuForPlayer(Colors, playerid);
                }
                else
                {
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 7:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 66, 66);
                    ShowMenuForPlayer(Colors, playerid);
                }
            case 8:
                ShowMenuForPlayer(Colors1, playerid);
        }
    }
    if (Current == Colors1)
    {
        switch (row)
        {
            case 0:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 24, 24);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully repainted to car");
                    ShowMenuForPlayer(Colors1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 123, 123);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully repainted to car");
                    ShowMenuForPlayer(Colors1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 53, 53);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully repainted to car");
                    ShowMenuForPlayer(Colors1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 3:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 93, 93);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully repainted to car");
                    ShowMenuForPlayer(Colors1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 4:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 83, 83);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully repainted to car");
                    ShowMenuForPlayer(Colors1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 5:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 60, 60);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully repainted to car");
                    ShowMenuForPlayer(Colors1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 6:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 126, 126);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully repainted to car");
                    ShowMenuForPlayer(Colors1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 7:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 110, 110);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully repainted to car");
                    ShowMenuForPlayer(Colors1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 8:
                ShowMenuForPlayer(TuningMenu, playerid);
        }
    }
    if (Current == Exhausts)
    {
        switch (row)
        {
            case 0:
            {
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562)
                    {
                        AddVehicleComponent(car, 1034);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Exhaust component on Elegy");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565)
                    {
                        AddVehicleComponent(car, 1046);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Exhaust component on Flash");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559)
                    {
                        AddVehicleComponent(car, 1065);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Exhaust component on Jetser");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561)
                    {
                        AddVehicleComponent(car, 1064);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Exhaust component on Stratum");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                    {
                        AddVehicleComponent(car, 1028);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Exhaust component on Sultan");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
                    {
                        AddVehicleComponent(car, 1089);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Exhaust component on Uranus");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 1:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562)
                    {
                        AddVehicleComponent(car, 1037);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Exhaust component on Elegy");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565)
                    {
                        AddVehicleComponent(car, 1045);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Exhaust component on Flash");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559)
                    {
                        AddVehicleComponent(car, 1066);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow exaust component on Jester");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561)
                    {
                        AddVehicleComponent(car, 1059);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Exhaust component on Stratum");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                    {
                        AddVehicleComponent(car, 1029);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Exhaust component on Sultan");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
                    {
                        AddVehicleComponent(car, 1092);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Exhaust component on Uranus");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 535)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575) // Brodway
                    {
                        AddVehicleComponent(car, 1044);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer Exhaust component on Brodway");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534) // Remington
                    {
                        AddVehicleComponent(car, 1126);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer Exhaust component on Remington");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savanna
                    {
                        AddVehicleComponent(car, 1129);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer Exhaust component on Savana");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1104);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer Exhaust component on Blade");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) // Slamvan
                    {
                        AddVehicleComponent(car, 1113);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer Exhaust component on Slamvan");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 576) // Tornado
                    {
                        AddVehicleComponent(car, 1136);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer Exhaust component on Tornado");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 3:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 535)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575) // Brodway
                    {
                        AddVehicleComponent(car, 1043);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin Exhaust component on Brodway");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534) // Remington
                    {
                        AddVehicleComponent(car, 1127);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin Exhaust component on Remingon");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savanna
                    {
                        AddVehicleComponent(car, 1132);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin Exhaust component on Savana");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1105);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin Exhaust component on Blade");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) // Slamvan
                    {
                        AddVehicleComponent(car, 1114);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin Exhaust component on Slamvan");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 576) // Tornado
                    {
                        AddVehicleComponent(car, 1135);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin Exhaust component on Tornado");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 4:
                ShowMenuForPlayer(TuningMenu, playerid);
        }
    }
    if (Current == Frontbumper)
    {
        switch (row)
        {
            case 0:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1171);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien front bumper component on Elegy");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1153);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien front bumper component on Flash");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jester
                    {
                        AddVehicleComponent(car, 1160);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien front bumper component on Jester");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1155);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien front bumper component on Stratum");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1169);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien front bumper component on Sultan");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1166);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien front bumper component on Uraus");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1172);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow front bumper component on Elegy");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1152);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow front bumper component on Flash");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jetser
                    {
                        AddVehicleComponent(car, 1173);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow front bumper component on Jester");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1157);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow front bumper component on Stratum");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1170);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow front bumper component on Sultan");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1165);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow front bumper component on Uranus");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 535)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575) // Brodway
                    {
                        AddVehicleComponent(car, 1174);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer front bumper component on Brodway");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534) // Remington
                    {
                        AddVehicleComponent(car, 1179);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer front bumper component on Remington");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savanna
                    {
                        AddVehicleComponent(car, 1189);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer front bumper component on Savana");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1182);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer front bumper component on Blade");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) // Slamvan
                    {
                        AddVehicleComponent(car, 1115);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer front bumper component on Slamvan");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 576) // Tornado
                    {
                        AddVehicleComponent(car, 1191);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer front bumper component on Tornado");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 3:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 576)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575) // Brodway
                    {
                        AddVehicleComponent(car, 1175);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin front bumper component on Brodway");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534) // Remington
                    {
                        AddVehicleComponent(car, 1185);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin front bumper component on Remington");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savanna
                    {
                        AddVehicleComponent(car, 1188);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin front bumper component on Savana");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1181);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin front bumper component on Blade");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) // Slamvan
                    {
                        AddVehicleComponent(car, 1116);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin front bumper component on Slamvan");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 576) // Tornado
                    {
                        AddVehicleComponent(car, 1190);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin front bumper component on Tornado");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 4:
                ShowMenuForPlayer(TuningMenu, playerid);
        }
    }
    if (Current == Rearbumper)
    {
        switch (row)
        {
            case 0:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1149);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien rear bumper component on Elegy");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1150);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien rear bumper component on Flash");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jester
                    {
                        AddVehicleComponent(car, 1159);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien rear bumper component on Jester");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1154);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien rear bumper component on Stratum");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1141);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien rear bumper component on Sultan");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1168);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien rear bumper component on Uranus");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1148);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow rear bumper component on Elegy");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1151);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow rear bumper component on Flash");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jetser
                    {
                        AddVehicleComponent(car, 1161);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow rear bumper component on Jester");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1156);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow rear bumper component on Stratum");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1140);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow rear bumper component on Sultan");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1167);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow rear bumper component on Uranus");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 535)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575) // Brodway
                    {
                        AddVehicleComponent(car, 1176);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer rear bumper component on Brodway");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534) // Remington
                    {
                        AddVehicleComponent(car, 1180);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer rear bumper component on Remington");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savanna
                    {
                        AddVehicleComponent(car, 1187);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer rear bumper component on Savana");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1184);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer rear bumper component on Blade");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) // Slamvan
                    {
                        AddVehicleComponent(car, 1109);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer rear bumper component on Slamvan");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 576) // Tornado
                    {
                        AddVehicleComponent(car, 1192);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer rear bumper component on Tornado");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 3:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 535)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575) // Brodway
                    {
                        AddVehicleComponent(car, 1177);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin rear bumper component on Brodway");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534) // Remington
                    {
                        AddVehicleComponent(car, 1178);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin rear bumper component on Remington");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savanna
                    {
                        AddVehicleComponent(car, 1186);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin rear bumper component on Savana");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1183);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin rear bumper component on Blade");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) // Slamvan
                    {
                        AddVehicleComponent(car, 1110);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin rear bumper component on Slamvan");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 576) // Tornado
                    {
                        AddVehicleComponent(car, 1193);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin rear bumper component on Tornado");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 4:
                ShowMenuForPlayer(TuningMenu, playerid);
        }
    }
    //==============================================================================
    //==============================================================================
    if (Current == Roof)
    {
        switch (row)
        {
            case 0:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1035);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien roof vent component on Elegy");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1054);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien roof vent component on Flash");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jester
                    {
                        AddVehicleComponent(car, 1067);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien roof vent component on Jester");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1055);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien roof vent component on Stratum");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1032);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien roof vent component on Sultan");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1088);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien roof vent component on Uranus");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1035);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow roof vent component on Elegy");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1053);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow roof vent component on Flash");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jetser
                    {
                        AddVehicleComponent(car, 1068);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow roof vent component on Jester");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1061);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow roof vent component on Stratum");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1033);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow roof vent component on Sultan");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1091);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow roof vent component on Uranus");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 536)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savana
                    {
                        AddVehicleComponent(car, 1130);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Hardtop Roof component on Brodway");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1128);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Hardtop Roof component on Blade");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types Savana and Blade");
                    ShowMenuForPlayer(Roof, playerid);
                }
            case 3:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 536)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savana
                    {
                        AddVehicleComponent(car, 1131);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Softtop Roof component on Brodway");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1103);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Softtop Roof component on Blade");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types Savana and Blade");
                    ShowMenuForPlayer(Roof, playerid);
                }
            case 4:
            {
                ShowMenuForPlayer(TuningMenu, playerid);
            }
        }
    }
    if (Current == Spoilers)
    {
        switch (row)
        {
            case 0:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1147);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Spoilers component on Elegy");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1049);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Spoilers component on Flash");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jester
                    {
                        AddVehicleComponent(car, 1162);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Spoilers component on Jester");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1158);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Spoilers component on Stratum");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1138);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Spoilers component on Sultan");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1164);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Spoilers component on Uranus");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1146);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Spoilers component on Elegy");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1150);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Spoilers component on Flash");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jetser
                    {
                        AddVehicleComponent(car, 1158);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Spoilers component on Jester");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1060);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Spoilers component on Stratum");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1139);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Spoilers component on Sultan");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1163);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Spoilers component on Uranus");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to X-Flow Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
            {
                ShowMenuForPlayer(TuningMenu, playerid);
            }
        }
    }
    if (Current == Sideskirts)
    {
        switch (row)
        {
            case 0:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1036);
                        AddVehicleComponent(car, 1040);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Side Skirts component on Elegy");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1047);
                        AddVehicleComponent(car, 1051);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Sideskirts vent component on Flash");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jester
                    {
                        AddVehicleComponent(car, 1069);
                        AddVehicleComponent(car, 1071);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Side Skirts component on Jester");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1056);
                        AddVehicleComponent(car, 1062);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Side Skirts component on Stratum");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1026);
                        AddVehicleComponent(car, 1027);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Side Skirts bumper component on Sultan");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1090);
                        AddVehicleComponent(car, 1094);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Side Skirts component on Uranus");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1039);
                        AddVehicleComponent(car, 1041);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Side Skirts component on Elegy");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1048);
                        AddVehicleComponent(car, 1052);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Side Skirts component on Flash");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jetser
                    {
                        AddVehicleComponent(car, 1070);
                        AddVehicleComponent(car, 1072);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Side Skirts component on Jester");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1057);
                        AddVehicleComponent(car, 1063);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Side Skirts component on Stratum");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1031);
                        AddVehicleComponent(car, 1030);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Side Skirts component on Sultan");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1093);
                        AddVehicleComponent(car, 1095);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Side Skirts component on Uranus");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 567)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575) // Brodway
                    {
                        AddVehicleComponent(car, 1042);
                        AddVehicleComponent(car, 1099);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chrome Strip Side Skirts component on Brodway");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savana
                    {
                        AddVehicleComponent(car, 1102);
                        AddVehicleComponent(car, 1133);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chrome Strip Side Skirts component on Savana");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 576) // Tornado
                    {
                        AddVehicleComponent(car, 1134);
                        AddVehicleComponent(car, 1137);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chrome Strip Side Skirts component on Tornado");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1108);
                        AddVehicleComponent(car, 1107);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chrome Strip Side Skirts component on Blade");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types Brodway, Savana Tornado and Blade");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 3:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 534)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534) // Remington
                    {
                        AddVehicleComponent(car, 1122);
                        AddVehicleComponent(car, 1101);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chrome Flames Side Skirts component on Remington");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car type Remington ");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 4:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 ||
                    GetVehicleModel(GetPlayerVehicleID(playerid)) == 534)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534) // Remington
                    {
                        AddVehicleComponent(car, 1106);
                        AddVehicleComponent(car, 1124);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chrome Arches Side Skirts component on Remington");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car type Remington ");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 5:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) // Slamvan
                    {
                        AddVehicleComponent(car, 1118);
                        AddVehicleComponent(car, 1120);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chrome Trim Side Skirts component on Slamvan");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car type Slamvan ");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 6:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) // Slamvan
                    {
                        AddVehicleComponent(car, 1119);
                        AddVehicleComponent(car, 1121);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chrome Wheelcovers component on Slamvan");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car type Slamvan ");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 7:
                ShowMenuForPlayer(TuningMenu, playerid);
        }
    }
    if (Current == Wheels)
    {
        switch (row)
        {
            case 0:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1025);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Offroad Wheels ");
                    ShowMenuForPlayer(Wheels, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1074);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Mega Wheels");
                    ShowMenuForPlayer(Wheels, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1076);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wires Wheels");
                    ShowMenuForPlayer(Wheels, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 3:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1078);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Twist Wheels");
                    ShowMenuForPlayer(Wheels, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(Wheels, playerid);
                }
            case 4:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1081);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Grove Wheels");
                    ShowMenuForPlayer(Wheels, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 5:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1082);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Import Wheels");
                    ShowMenuForPlayer(Wheels, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 6:
            {
                new car = GetPlayerVehicleID(playerid);
                AddVehicleComponent(car, 1085);
                SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Atomic Wheels");
                ShowMenuForPlayer(Wheels, playerid);
            }
            case 7:
            {
                new car = GetPlayerVehicleID(playerid);
                AddVehicleComponent(car, 1096);
                SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Ahab Wheels");
                ShowMenuForPlayer(Wheels, playerid);
            }
            case 8:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1097);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Virtual Wheels");
                    ShowMenuForPlayer(Wheels, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 9:
            {
                new car = GetPlayerVehicleID(playerid);
                AddVehicleComponent(car, 1098);
                SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Access Wheels");
                ShowMenuForPlayer(Wheels, playerid);
            }
            case 10:
            {
                ShowMenuForPlayer(Wheels1, playerid);
            }
            case 11:
            {
                ShowMenuForPlayer(TuningMenu, playerid);
            }
        }
    }
    if (Current == Wheels1)
    {
        switch (row)
        {
            case 0:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1084);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Trance Wheels ");
                    ShowMenuForPlayer(Wheels1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 1:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1073);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Shadow Wheels");
                    ShowMenuForPlayer(Wheels1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 2:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1075);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Rimshine Wheels");
                    ShowMenuForPlayer(Wheels1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 3:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1077);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Classic Wheels");
                    ShowMenuForPlayer(Wheels1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(Wheels, playerid);
                }
            }
            case 4:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1079);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Cutter Wheels");
                    ShowMenuForPlayer(Wheels1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 5:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1080);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Switch Wheels");
                    ShowMenuForPlayer(Wheels1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 6:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1083);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Dollar Wheels");
                    ShowMenuForPlayer(Wheels1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 7:
            {
                {
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
        }
    }
    if (Current == Nitro)
    {
        switch (row)
        {
            case 0:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1008);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added 2x Nitro to car ");
                    ShowMenuForPlayer(Others, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1009);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added 5x Nitro to car");
                    ShowMenuForPlayer(Others, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(Others, playerid);
                }
            case 2:
            {
                new car = GetPlayerVehicleID(playerid);
                AddVehicleComponent(car, 1010);
                SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added 10x Nitro to car");
                ShowMenuForPlayer(Others, playerid);
            }
            case 3:
            {
                ShowMenuForPlayer(Others, playerid);
            }
        }
    }
    if (Current == Others)
    {
        switch (row)
        {
            case 0:
            {
                new car = GetPlayerVehicleID(playerid);
                AddVehicleComponent(car, 1087);
                SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Hydraulics to car ");
                ShowMenuForPlayer(TuningMenu, playerid);
            }
            case 1:
            {
                new car = GetPlayerVehicleID(playerid);
                AddVehicleComponent(car, 1086);
                SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Stereo Bass bost system ");
                ShowMenuForPlayer(TuningMenu, playerid);
            }
            case 2:
            {
                ShowMenuForPlayer(Nitro, playerid);
            }
            case 3:
            {
                ShowMenuForPlayer(TuningMenu, playerid);
            }
        }
    }
    return 0;
}
public OnPlayerExitedMenu(playerid)
{
    return 1;
}
public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
    return 1;
}
public OnRconLoginAttempt(ip[], password[], success)
{
    if (!success)
    {
        new pip[30];
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            GetPlayerIp(i, pip, 30);
            if (!strcmp(ip, pip, true))
            {
                SendClientMessage(i, 0xE60000FF, "SERVER: Ти се опита да влезеш с RCON паролата на сървъра и сега си KICKED!");
                PlayerInfo[i][pKick] = 1;
            }
        }
    }
    return 1;
}
public OnPlayerUpdate(playerid)
{
    // MOJE BI TRQBWA DA SE MAHNE
    //SetTimerEx("OnPlayerUpdate", 62, true, "i", playerid);
    // MOJE BI TRQBWA DA SE MAHNE
    //if - location - open
    //if(loadedtext[playerid]==1)
    //{
    AFKDetect[playerid] = gettime();

    if (IsPlayerPaused(playerid) && isTurfMember[playerid])
    {
        if (PlayerInfo[playerid][pKick] == 0)
        {
            SendClientMessage(playerid, COLOR_RED, "SERVER: Ти беше KICKED, понеже беше ESC AFK на Turf!");
            PlayerInfo[playerid][pKick] = 1;
        }
    }

    if (IsPlayerInRangeOfPoint(playerid, 250.0, 1204.3077, -2066.5664, 84.7134) && PlayerInfo[playerid][pIPDDuty] == 0) //spawn
    {
        GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~TI SI BLIZO DO ~r~VIP BAZATA ~n~~w~I NE MOJESH DA POLZVASH ORUJIQ", 2000, 3);
        SetPlayerArmedWeapon(playerid, 0);
    }
    new Float:x, Float:y, Float:z, Float:angle;
    new keys, updown, leftright;
    if (fly[playerid] == 1)
    {
        GetPlayerKeys(playerid, keys, updown, leftright);
        if (updown == KEY_UP)
        {
            if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
            {
                GetPlayerPos(playerid, x, y, z);
                GetXYInFrontOfPlayer(playerid, x, y, 5.0);
                SetPlayerPos(playerid, x, y, z);
                SetCameraBehindPlayer(playerid);
            }
            else if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                new playercar = GetPlayerVehicleID(playerid);
                GetVehiclePos(playercar, x, y, z);
                GetXYInFrontOfPlayer(playerid, x, y, 5.0);
                SetVehiclePos(playercar, x, y, z);
            }
        }
        else if (updown == KEY_DOWN)
        {
            if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
            {
                GetPlayerPos(playerid, x, y, z);
                GetXYBehindPlayer(playerid, x, y, 5.0);
                SetPlayerPos(playerid, x, y, z);
                SetCameraBehindPlayer(playerid);
            }
            else if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                new playercar = GetPlayerVehicleID(playerid);
                GetVehiclePos(playercar, x, y, z);
                GetXYBehindPlayer(playerid, x, y, 5.0);
                SetVehiclePos(playercar, x, y, z);
            }
        }
        if (leftright == KEY_LEFT)
        {
            if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
            {
                GetPlayerFacingAngle(playerid, angle);
                SetPlayerFacingAngle(playerid, angle + 10);
                SetCameraBehindPlayer(playerid);
            }
            else if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                new playercar = GetPlayerVehicleID(playerid);
                GetVehicleZAngle(playercar, angle);
                SetVehicleZAngle(playercar, angle + 10);
            }
        }
        else if (leftright == KEY_RIGHT)
        {
            if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
            {
                GetPlayerFacingAngle(playerid, angle);
                SetPlayerFacingAngle(playerid, angle - 10);
                SetCameraBehindPlayer(playerid);
            }
            else if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                new playercar = GetPlayerVehicleID(playerid);
                GetVehicleZAngle(playercar, angle);
                SetVehicleZAngle(playercar, angle - 10);
            }
        }
        if (keys == KEY_JUMP)
        {
            if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
            {
                GetPlayerPos(playerid, x, y, z);
                SetPlayerPos(playerid, x, y, z + 5);
                SetCameraBehindPlayer(playerid);
            }
            else if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                new playercar = GetPlayerVehicleID(playerid);
                GetVehiclePos(playercar, x, y, z);
                SetVehiclePos(playercar, x, y, z + 5);
            }
        }
        else if (keys == KEY_SPRINT)
        {
            if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
            {
                GetPlayerPos(playerid, x, y, z);
                SetPlayerPos(playerid, x, y, z - 5);
                SetCameraBehindPlayer(playerid);
            }
            else if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                new playercar = GetPlayerVehicleID(playerid);
                GetVehiclePos(playercar, x, y, z);
                SetVehiclePos(playercar, x, y, z - 5);
            }
        }
    }
    new drunknew;
    drunknew = GetPlayerDrunkLevel(playerid);
    if (drunknew < 100)
    { // go back up, keep cycling.
        SetPlayerDrunkLevel(playerid, 2000);
    }
    else
    {
        if (pDrunkLevelLast[playerid] != drunknew)
        {
            new wfps = pDrunkLevelLast[playerid] - drunknew;
            if ((wfps > 0) && (wfps < 200))
                pFPS[playerid] = wfps;
            pDrunkLevelLast[playerid] = drunknew;
        }
    }
    if (GetPlayerVehicleID(playerid) > -1)
    {
        if (objectright[playerid] == 1)
        {
            objectright[playerid] = 0;
            RemovePlayerAttachedObject(playerid, 0);
        }
        GetVehicleHealth(GetPlayerVehicleID(playerid), vehhealth[playerid]);
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) != 481 &&
            GetVehicleModel(GetPlayerVehicleID(playerid)) != 509 &&
            GetVehicleModel(GetPlayerVehicleID(playerid)) != 510 &&
            GetVehicleModel(GetPlayerVehicleID(playerid)) != 481)
        {
            if (speedo[playerid] == 0)
            {
                if (kmh[playerid] == 0)
                {
                    format(stringvehicle[playerid], 115, "~w~Speed: %dkm/h~n~~g~Health: %.0f~n~~r~Fuel: %dL", GetVehicleKmh(GetPlayerVehicleID(playerid)), vehhealth[playerid], vehfuel[GetPlayerVehicleID(playerid)]);
                    TextDrawSetString(vehstatus[playerid], stringvehicle[playerid]);
                }
                else
                {
                    new vehicleid, Float:speed_x, Float:speed_y, Float:speed_z, final_speed_int;
                    vehicleid = GetPlayerVehicleID(playerid);
                    GetVehicleVelocity(vehicleid, speed_x, speed_y, speed_z);
                    final_speed_int = GetVehicleKmh(vehicleid);
                    format(stringvehicle[playerid], 115, "~w~Speed: %dm/s~n~~g~Health: %.0f~n~~r~Fuel: %dL", final_speed_int, vehhealth[playerid], vehfuel[GetPlayerVehicleID(playerid)]);
                    TextDrawSetString(vehstatus[playerid], stringvehicle[playerid]);
                }
            }
        }
        else
        {
            if (speedo[playerid] == 0)
            {
                if (kmh[playerid] == 0)
                {
                    format(stringvehicle[playerid], 115, "~w~Speed: %dkm/h~n~~g~Health: %.0f", GetVehicleKmh(GetPlayerVehicleID(playerid)), vehhealth[playerid]);
                    TextDrawSetString(vehstatus[playerid], stringvehicle[playerid]);
                }
                else
                {
                    new vehicleid, Float:speed_x, Float:speed_y, Float:speed_z, final_speed_int;
                    vehicleid = GetPlayerVehicleID(playerid);
                    GetVehicleVelocity(vehicleid, speed_x, speed_y, speed_z);
                    final_speed_int = GetVehicleKmh(vehicleid);
                    format(stringvehicle[playerid], 115, "~w~Speed: %dm/s~n~~g~Health: %.0f", final_speed_int, vehhealth[playerid]);
                    TextDrawSetString(vehstatus[playerid], stringvehicle[playerid]);
                }
            }
        }
        //}
    }
    if (!IsPlayerInAnyVehicle(playerid))
    {
        if (PlayerInfo[playerid][pLaser] == 1)
        {
            if (PlayerInfo[playerid][pVip] > 3 || CheckFreeVIP() == 1)
            {
                if (objectright[playerid] == 0)
                {
                    objectright[playerid] = 1;
                }
                RemovePlayerAttachedObject(playerid, 0);
                if ((IsPlayerInAnyVehicle(playerid)) || (IsPlayerInWater(playerid))) return 1;
                switch (GetPlayerWeapon(playerid))
                {
                    case 31:
                    {
                        if (IsPlayerAiming(playerid))
                        {
                            if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
                            {
                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 standing aiming
                                    0.528249, -0.020266, 0.068052, -6.621746, 352.552642, 355.084289);
                            }
                            else
                            {
                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 crouched aiming
                                    0.528249, -0.020266, 0.068052, -1.621746, 356.202667, 355.084289);
                            }
                        }
                        else
                        {
                            if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
                            {
                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 standing not aiming
                                    0.503249, -0.02376, 0.065051, -11.131746, 357.302734, 354.484222);
                            }
                            else
                            {
                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 crouched not aiming
                                    0.503249, -0.02376, 0.065051, -11.131746, 357.302734, 354.484222);
                            }
                        }
                    }
                    case 29:
                    {
                        if (IsPlayerAiming(playerid))
                        {
                            if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
                            {
                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 standing aiming
                                    0.298249, -0.02776, 0.158052, -11.631746, 359.302673, 357.584259);
                            }
                            else
                            {
                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 crouched aiming
                                    0.298249, -0.02776, 0.158052, 8.368253, 358.302673, 352.584259);
                            }
                        }
                        else
                        {
                            if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
                            {
                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 standing not aiming
                                    0.293249, -0.027759, 0.195051, -12.131746, 354.302734, 352.484222);
                            }
                            else
                            {
                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 crouched not aiming
                                    0.293249, -0.027759, 0.195051, -12.131746, 354.302734, 352.484222);
                            }
                        }
                    }
                }
            }
        }
    }
    //if - location - close
    return 1;
}
public OnPlayerStreamIn(playerid, forplayerid)
{
    return 1;
}
public OnPlayerStreamOut(playerid, forplayerid)
{
    return 1;
}
public OnVehicleStreamIn(vehicleid, forplayerid)
{
    return 1;
}
public OnVehicleStreamOut(vehicleid, forplayerid)
{
    return 1;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid,
    Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ,
    Float:fRotX, Float:fRotY, Float:fRotZ,
    Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    SetPlayerAttachedObject(playerid, index, modelid, boneid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ);
    if (index == 9)
    {
        SendClientMessage(playerid, 0x33AA33FF, "SERVER: Ти успешно запази координатите на обжекта!");
    }
    return 1;
}
public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
    new Float:oldX, Float:oldY, Float:oldZ, Float:oldRotX, Float:oldRotY, Float:oldRotZ;
    GetObjectPos(objectid, oldX, oldY, oldZ);
    GetObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
    if (!playerobject) // If this is a global object, sync the position for other players
    {
        if (!IsValidObject(objectid)) return 1;
        SetObjectPos(objectid, fX, fY, fZ);
        SetObjectRot(objectid, fRotX, fRotY, fRotZ);
    }
    if (response == EDIT_RESPONSE_FINAL)
    {
        //if(attachedPlayerObject[objectid]==true)
        //{
        SetObjectPos(objectid, fX, fY, fZ);
        SetObjectRot(objectid, fRotX, fRotY, fRotZ);
        //}
    }
    if (response == EDIT_RESPONSE_FINAL)
    {
        //	if(objectid==objectut[playerid])
        //	{
        //		AttachObjectToVehicle(objectut[playerid], GetPlayerVehicleID(playerid), fX, fY, fZ, fRotX, fRotY, fRotZ);
        //	}
    }
    if (response == EDIT_RESPONSE_CANCEL)
    {
        //The player cancelled, so put the object back to it's old position
        if (!playerobject) //Object is not a playerobject
        {
            SetObjectPos(objectid, oldX, oldY, oldZ);
            SetObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
        }
        else
        {
            SetPlayerObjectPos(playerid, objectid, oldX, oldY, oldZ);
            SetPlayerObjectRot(playerid, objectid, oldRotX, oldRotY, oldRotZ);
        }
    }
    return 1;
}
public CorDetector(Float:radi, playerid, targetid)
{
    if (IsPlayerConnected(playerid) && IsPlayerConnected(targetid))
    {
        new Float:posx, Float:posy, Float:posz;
        new Float:oldposx, Float:oldposy, Float:oldposz;
        new Float:tempposx, Float:tempposy, Float:tempposz;
        GetPlayerPos(playerid, oldposx, oldposy, oldposz);
        //radi = 2.0; //Trigger Radius
        GetPlayerPos(targetid, posx, posy, posz);
        tempposx = (oldposx - posx);
        tempposy = (oldposy - posy);
        tempposz = (oldposz - posz);
        printf("DEBUG: X:%f Y:%f Z:%f", posx, posy, posz);
        if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
        {
            return 1;
        }
    }
    return 0;
}
public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
    return 1;
}
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if (hittype == BULLET_HIT_TYPE_VEHICLE)
    {
        for (new i = 0; i < sizeof(intensePDVehs); i++)
        {
            if (isIntensePDGangVeh[hitid] == true)
            {
                if (isIntensePDGangVehDUTY[hitid] == true)
                {
                    if (!PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE && !PlayerInfo[playerid][pADuty])
                    {
                        new now = gettime();
                        if (now - lastCriminalPoliceCar[playerid] >= 30)
                        {
                            lastCriminalPoliceCar[playerid] = now;
                            GivePlayerWantedLevel(playerid, 1, "Стрелба по полицейска кола");
                        }
                    }
                }
            }
        }
    }
    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid, bodypart)
{
    return 0;
}