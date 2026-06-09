#include <YSI_Coding\y_hooks>

/*
* Hook
*/
hook OnVehicleSpawn(vehicleid)
{
    LoadVehTune(vehicleid);
    LoadPrivateVehsTune(vehicleid);
    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
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
    if (GetPlayerState(killerid) == PLAYER_STATE_DRIVER)
    {
        SetPlayerHealth(killerid, 0);
        SendClientMessage(killerid, 0xE60000FF, "SERVER: Ти беше убит за Drive-By убийство!");
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

