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

/*
* Special Vehicles
*/
stock IsBoat(vehicleid)
{
    new model = GetVehicleModel(vehicleid);
    switch (model)
    {
        case 454, 472, 473, 484, 430, 446, 452, 453, 493, 595:
            return true;
    }
    return false;
}

stock IsPlane(vehicleid)
{
    new model = GetVehicleModel(vehicleid);
    switch (model)
    {
        case 460, 476, 511, 512, 513, 519, 520, 553, 577, 592:
            return true;
    }
    return false;
}

stock IsHelicopter(vehicleid)
{
    new model = GetVehicleModel(vehicleid);
    switch (model)
    {
        case 417, 425, 447, 460, 469, 487, 488, 497, 548, 563:
            return true;
    }
    return false;
}

stock IsTrain(vehicleid)
{
    new model = GetVehicleModel(vehicleid);
    switch (model)
    {
        case 537, 538:
            return 1;
    }
    return false;
}

stock IsAirVehicle(vehicleid)
{
    return IsPlane(vehicleid) || IsHelicopter(vehicleid);
}

stock IsWaterVehicle(vehicleid)
{
    return IsBoat(vehicleid);
}