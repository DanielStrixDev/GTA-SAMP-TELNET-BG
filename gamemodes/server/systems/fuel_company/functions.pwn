#include <YSI_Coding\y_hooks>

hook OnTrailerUpdate(playerid, vehicleid)
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
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{

    if (GetVehicleTrailer(vehicleid) == fuelremarke[0] || GetVehicleTrailer(vehicleid) == fuelremarke[1] || GetVehicleTrailer(vehicleid) == fuelremarke[2])
    {
        TextDrawHideForPlayer(playerid, vehstatus2[playerid]);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}