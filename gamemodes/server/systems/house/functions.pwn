#include <YSI_Coding\y_hooks>

/*
* Pickup
*/
public RemoveHousePick(playerid)
{
    onhousepick2[playerid] = 0;
    if (onhousepick2[playerid] == 0)
    {
        KillTimer(housetimer[playerid]);
        isinhousepickup[playerid] = 0;
    }
    playerInHousePickup[playerid] = 0;
}

/*
* Exit
*/
stock CheckPlayerExitHouse(playerid)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    new vw = GetPlayerVirtualWorld(playerid);
    new houseid = vw - 50;

    // Проверяваме дали играчът е на някоя от изходните позиции
    if (
        IsPlayerInRangeOfPoint(playerid, 3, 2324.5479, -1149.5146, 1050.7101) ||
        IsPlayerInRangeOfPoint(playerid, 3, 2270.3855, -1210.4730, 1047.5625) ||
        IsPlayerInRangeOfPoint(playerid, 3, 2196.8506, -1204.2477, 1049.0234) ||
        IsPlayerInRangeOfPoint(playerid, 3, 2468.8413, -1698.4177, 1013.5078) ||
        IsPlayerInRangeOfPoint(playerid, 3, 1260.6464, -785.4418, 1091.9063) ||
        IsPlayerInRangeOfPoint(playerid, 3, 327.9635, 1477.7430, 1084.4375) ||
        IsPlayerInRangeOfPoint(playerid, 3, 318.5932, 1114.4792, 1083.8828) ||
        IsPlayerInRangeOfPoint(playerid, 3, 309.0916, 313.6412, 1003.3047) ||
        IsPlayerInRangeOfPoint(playerid, 3, 261.0904, 1284.2944, 1080.2578) ||
        IsPlayerInRangeOfPoint(playerid, 3, 226.2984, 1114.3319, 1080.9929) ||
        IsPlayerInRangeOfPoint(playerid, 3, 225.8726, 1021.4523, 1084.0177) ||
        IsPlayerInRangeOfPoint(playerid, 3, 223.1015, 1287.0764, 1082.1406) ||
        IsPlayerInRangeOfPoint(playerid, 3, 140.2254, 1365.9796, 1083.8594) ||
        IsPlayerInRangeOfPoint(playerid, 3, 83.0758, 1322.2808, 1083.8662) ||
        IsPlayerInRangeOfPoint(playerid, 3, -68.7704, 1352.9250, 1080.2109) ||
        IsPlayerInRangeOfPoint(playerid, 3, -42.5628, 1405.5011, 1084.4297) ||
        IsPlayerInRangeOfPoint(playerid, 3, 2495.98, -1692.08, 1014.74) ||
        IsPlayerInRangeOfPoint(playerid, 3, 83.03, 1322.28, 1083.87) ||
        IsPlayerInRangeOfPoint(playerid, 3, 2807.48, -1174.76, 1025.57) ||
        IsPlayerInRangeOfPoint(playerid, 3, 260.85, 1237.24, 1084.26) ||
        IsPlayerInRangeOfPoint(playerid, 3, 2237.59, -1081.64, 1049.02) ||
        IsPlayerInRangeOfPoint(playerid, 3, 446.99, 1397.07, 1084.30) ||
        IsPlayerInRangeOfPoint(playerid, 3, 377.15, 1417.41, 1081.33) ||
        IsPlayerInRangeOfPoint(playerid, 3, 2308.77, -1212.94, 1049.02) ||
        IsPlayerInRangeOfPoint(playerid, 3, 243.72, 304.91, 999.15) ||
        IsPlayerInRangeOfPoint(playerid, 3, 2283.04, -1140.28, 1050.90)
    )
    {
        if (HouseInfo[houseid][hLocked] == 1)
        {
            GameTextForPlayer(playerid, "locked", 3000, 1);
            return SendClientMessage(playerid, 0x00FF40FF, "Къщата е заключена и не можеш да излезеш !");
        }

        // Телепортираме играча навън
        SetPlayerPos(playerid, HouseInfo[houseid][hX], HouseInfo[houseid][hY], HouseInfo[houseid][hZ]);
        SetPlayerInterior(playerid, 0);
        SetCameraBehindPlayer(playerid);
        SetPlayerVirtualWorld(playerid, 0);
        return 1;
    }
    return 0;
}

/*
* Is valid house
*/
stock IsValidHouse(houseid)
{
    if (houseid < 0) return false;
    if (HouseInfo[houseid][hInterior] >= 1)
    {
        return true;
    }

    return false;
}

/*
* Private vehicle
*/
hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if (VehicleInfo[vehicleid][vIsHouseVeh])
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
    return Y_HOOKS_CONTINUE_RETURN_1;
}

/*
* Hook
*/
hook OnPlayerEnterCheckpoint(playerid)
{
    if (PlayerInfo[playerid][pHouseO] > -1)
    {
        gpsOn[playerid] = false;
        new playersHouse = PlayerInfo[playerid][pHouseO];
new Float:
        playerHouseX = HouseInfo[playersHouse][hX];
new Float:
        playerHouseY = HouseInfo[playersHouse][hY];
new Float:
        playerHouseZ = HouseInfo[playersHouse][hZ];
        if (IsPlayerInRangeOfPoint(playerid, 4.0, playerHouseX, playerHouseY, playerHouseZ))
        {
            SendClientMessage(playerid, 0xffff00FF, "Ти пристигна до твоята къща!");
            DisablePlayerCheckpoint(playerid);
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

/*
* Is Player Near House
*/
stock IsPlayerNearHouse(playerid)
{
    new houseid = playerInHousePickup[playerid];
    if (IsValidHouse(houseid))
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[houseid][hX], HouseInfo[houseid][hY], HouseInfo[houseid][hZ]))
        {
            return houseid;
        }
    }
    return -1;
}

/*
* Enter Pickup
*/
hook OnPlayerPickUpPickup(playerid, pickupid)
{
    new houseid = HouseByPickup[pickupid];
    if (IsValidHouse(houseid))
    {
        isinhousepickup[playerid] = 1;
        onhousepick2[playerid] = 1;
        playerInHousePickup[playerid] = houseid;
    }

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
    return Y_HOOKS_CONTINUE_RETURN_1;
}

