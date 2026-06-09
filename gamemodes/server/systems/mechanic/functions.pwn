#include <YSI_Coding\y_hooks>

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{

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

    return Y_HOOKS_CONTINUE_RETURN_1;
}