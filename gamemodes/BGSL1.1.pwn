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
#include <a_mysql>
#include <izcmd>
//#include <crashdetect>
#include <YSI_Coding\y_hooks>
#include <sscanf2>

//#include <colandreas>
//#pragma tabsize 0

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
//new string256[256];
new string115[115];
new string175[175];
new string115n2[115];
new stringvehicle[501][115];
new string256[256];
//new string[256];
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
#include "server/systems/fuel/vars.pwn"
#include "server/systems/gps/vars.pwn"

// FUNCTIONS
#include "server/forwards.pwn"
#include "server/connection.pwn"
#include "server/classes.pwn"
#include "server/functions.pwn"
#include "server/systems/vehicles/functions.pwn"
#include "server/systems/private_vehs/functions.pwn"
#include "server/systems/office/functions.pwn"
#include "server/systems/robbery/functions.pwn"
#include "server/systems/turfs/functions.pwn"
#include "server/systems/house/functions.pwn"
#include "server/systems/biz/functions.pwn"
#include "server/systems/vip/functions.pwn"
#include "server/systems/record/functions.pwn"
#include "server/systems/fishing/functions.pwn"
#include "server/systems/missions/functions.pwn"
#include "server/systems/mechanic/functions.pwn"
#include "server/systems/cb_chat/functions.pwn"
#include "server/systems/hitman/functions.pwn"
#include "server/systems/duel/functions.pwn"
#include "server/systems/drugs/functions.pwn"
#include "server/systems/factions/functions.pwn"
#include "server/systems/fuel_company/functions.pwn"
#include "server/systems/jobs/functions.pwn"
#include "server/systems/minigames/functions.pwn"
#include "server/systems/player/db.pwn"
#include "server/systems/player/functions.pwn"
#include "server/systems/vehicles/functions.pwn"
#include "server/systems/weaponskills/functions.pwn"
#include "server/systems/dmon/functions.pwn"
#include "server/systems/afk/functions.pwn"
#include "server/systems/jail/functions.pwn"
#include "server/systems/admin/functions.pwn"
#include "server/systems/fuel/functions.pwn"

// DATABASE
#include "server/db.pwn"
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
#include "server/dialogs.pwn"
#include "server/keys.pwn"
#include "server/objects.pwn"
#include "server/pickups.pwn"
#include "server/player.pwn"
#include "server/textdraws.pwn"
#include "server/textlabels.pwn"
#include "server/vehicles.pwn"

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
    // Print info
    printf("Ако конзолата не се пусне до 15 секунди, натиснете ENTER.");
    printf("Ако сървърът не дава да се влиза в него до 2 минути след пускането му, натиснете ENTER.");

    // Server functions
    SetGameModeText("INTENSE 1.5 RC2");
    SendRconCommand("hostname [- GTAINT -][O-F-F-I-C-I-A-L][0.3.7]");
    SendRconCommand("rcon_password 123123");
    SendRconCommand("loadfs ls_elevator");
    SendRconCommand("weburl none");
    SendRconCommand("mapname Las Venturas");
    SendRconCommand("language Bulgarian");
    SendRconCommand("reloadbans");
    SendRconCommand("lanmode 0");
    DisableInteriorEnterExits();
    EnableStuntBonusForAll(0);

    // Vars and Functions
    LoadPlayerClasses();
    LoadGamemodeFunctions();

    // Database
    MySQLConnect();
    SQLConnect_Operations();
    LoadDatabaseInformation();

    // Timers
    SetTimer("GeneralTimer1s", 1000, 1);
    SetTimer("GeneralTimer500ms", 500, 1);
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
        ResetPlayerStats(i);
    }
    CloseDB();
    return 1;
}