#include <YSI_Coding\y_hooks>

/*
* Hook
*/
hook OnVehicleSpawn(vehicleid)
{
    eventveh[vehicleid] = 0;
    return Y_HOOKS_CONTINUE_RETURN_1;
}

/*
* On player death
*/
hook OnPlayerDeath(playerid, killerid, reason)
{
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
        ResetPlayerTime(playerid);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

/*
* Event vehicles
*/
hook OnVehicleSpawn(vehicleid)
{
    eventveh[vehicleid] = 0;

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnVehicleDeath(vehicleid, killerid)
{
    eventveh[vehicleid] = 0;

    return Y_HOOKS_CONTINUE_RETURN_1;
}