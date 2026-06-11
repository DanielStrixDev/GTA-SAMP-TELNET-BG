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
            TextDrawSetString(ifcFuelText[playerid], stringveha);
            TextDrawShowForPlayer(playerid, ifcFuelText[playerid]);
            ifcFuelTextOn[playerid] = true;
        }
    }
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{

    if (GetVehicleTrailer(vehicleid) == fuelremarke[0] || GetVehicleTrailer(vehicleid) == fuelremarke[1] || GetVehicleTrailer(vehicleid) == fuelremarke[2])
    {
        TextDrawHideForPlayer(playerid, ifcFuelText[playerid]);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

/*
* IFC Spawn
*/
stock SetPlayerToIfcSpawn(playerid)
{
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerPos(playerid, 280.9982, 1410.2089, 10.4179);
}

/*
* Fuel Trailer
*/
stock IsPlayerInFuelTrailer(playerid)
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if (!vehicleid) return 0;

    new trailerid = GetVehicleTrailer(vehicleid);
    for (new i = 0; i < 3; i++)
    {
        if (trailerid == fuelremarke[i]) return 1;
    }
    return 0;
}

/*
* Fuel Station Refuel
*/
stock RefuelFuelStation(playerid, stationId)
{
    if (fuelStationsFuel[stationId] >= 5000)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        return 0;
    }

    new vehicleid = GetPlayerVehicleID(playerid);
    new trailerid = GetVehicleTrailer(vehicleid);
    new neededFuel = 5000 - fuelStationsFuel[stationId];

    if (vehfuel2[trailerid] < neededFuel)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно бензин за да заредиш бензиностанцията!");
        return 0;
    }

    vehfuel2[trailerid] -= neededFuel;
    fuelStationsFuel[stationId] = 5000;
    new profitFuel = neededFuel + 1030;
    GivePlayerCash(playerid, profitFuel);
    GivePlayerEP(playerid, 2);

    new refuelstring[500];
    new message[256];
    format(refuelstring, sizeof(refuelstring), "{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш");
    Update3DTextLabelText(fuelStationText[stationId], 0xFFFFFFFF, refuelstring);
    format(message, sizeof(message), "Ти зареди бензиностанцията с %d литра и твоята печалба е {3FDE00}$%d + 2 EP",
           neededFuel, profitFuel);
    SendClientMessage(playerid, 0xFFFFFFFF, message);

    return 1;
}

/*
* Player enter GPS marker
*/
hook OnPlayerEnterCheckpoint(playerid)
{
    if (gpsType[playerid] == GPS_TYPE_FUELSTATION)
    {
        new stationId = GetPlayerNearFuelStation(playerid);
        if (stationId != -1 && IsPlayerInRangeOfPoint(playerid, 10.0, gpsX[playerid], gpsY[playerid], gpsZ[playerid]))
        {            
            DisablePlayerCheckpoint(playerid);
            gpsType[playerid] = -1;
            gpsX[playerid] = 0;
            gpsY[playerid] = 0;
            gpsZ[playerid] = 0;
            
            return Y_HOOKS_CONTINUE_RETURN_1;
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}