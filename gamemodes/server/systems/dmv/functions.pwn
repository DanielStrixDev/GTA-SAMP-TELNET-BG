#include <YSI_Coding\y_hooks>

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{

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
                return Y_HOOKS_CONTINUE_RETURN_1;
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
                return Y_HOOKS_CONTINUE_RETURN_1;
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
                return Y_HOOKS_CONTINUE_RETURN_1;
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
                return Y_HOOKS_CONTINUE_RETURN_1;
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}