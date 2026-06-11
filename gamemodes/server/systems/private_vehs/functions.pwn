#include <YSI_Coding\y_hooks>

stock LoadPrivateVehsTune(vehicleid)
{
    if (vehicleid == PrivateVeh[1][pvID])
    {
        if (IsValidDynamicObject(PrivateVeh[1][pvObject][0]))
        {
            DestroyDynamicObject(PrivateVeh[1][pvObject][0]);
        }
        PrivateVeh[1][pvObject][0] = CreateDynamicObject(18646, 0, 0, -1000, 0, 0, 0, 100);
        AttachDynamicObjectToVehicle(PrivateVeh[1][pvObject][0], vehicleid, -0.43060, -0.07840, 0.75010, 0.00000, 0.00000, 0.00000);
    }
    if (vehicleid == PrivateVeh[2][pvID])
    {
        ChangeVehiclePaintjob(vehicleid, 2);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    else if (vehicleid == PrivateVeh[3][pvID])
    {
        ChangeVehiclePaintjob(vehicleid, 2);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    else if (vehicleid == PrivateVeh[4][pvID])
    {
        ChangeVehiclePaintjob(vehicleid, 2);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    else if (vehicleid == PrivateVeh[7][pvID])
    {
        if (IsValidDynamicObject(PrivateVeh[7][pvObject][0]))
        {
            DestroyDynamicObject(PrivateVeh[7][pvObject][0]);
            DestroyDynamicObject(PrivateVeh[7][pvObject][1]);
            DestroyDynamicObject(PrivateVeh[7][pvObject][2]);
        }
        PrivateVeh[7][pvObject][0] = CreateDynamicObject(18646, 0, 0, -1000, 0, 0, 0, 100);
        AttachDynamicObjectToVehicle(PrivateVeh[7][pvObject][0], vehicleid, -0.43060, -0.07840, 0.75010, 0.00000, 0.00000, 0.00000);
        PrivateVeh[7][pvObject][1] = CreateDynamicObject(18694, 0.0, 0.0, -1000.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0, 300.0);
        AttachDynamicObjectToVehicle(PrivateVeh[7][pvObject][1], vehicleid, 0.057, -2.234, -1.870, 0.000, 0.000, 175.799);
        PrivateVeh[7][pvObject][2] = CreateDynamicObject(1003, 0.0, 0.0, -1000.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0, 300.0);
        AttachDynamicObjectToVehicle(PrivateVeh[7][pvObject][2], vehicleid, -0.030, -2.571, 0.100, 0.000, 0.000, 0.000);
    }
    else if (vehicleid == PrivateVeh[12][pvID])
    {
        if (IsValidDynamicObject(PrivateVeh[12][pvObject][0]))
        {
            DestroyDynamicObject(PrivateVeh[12][pvObject][0]);
            DestroyDynamicObject(PrivateVeh[12][pvObject][1]);
            DestroyDynamicObject(PrivateVeh[12][pvObject][2]);
            Delete3DTextLabel(PrivateVeh[12][pv3DText]);
        }
        PrivateVeh[12][pvObject][0] = CreateDynamicObject(18648, 0.0, 0.0, -1000.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0, 300.0);
        AttachDynamicObjectToVehicle(PrivateVeh[12][pvObject][0], vehicleid, -1.040, 0.000, -0.610, 0.000, 0.000, 0.000);
        PrivateVeh[12][pvObject][1] = CreateDynamicObject(18648, 0.0, 0.0, -1000.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0, 300.0);
        AttachDynamicObjectToVehicle(PrivateVeh[12][pvObject][1], vehicleid, 1.020, 0.000, -0.610, 0.000, 0.000, 0.000);
        PrivateVeh[12][pvObject][2] = CreateDynamicObject(1159, 0.0, 0.0, -1000.0, 0.0, 0.0, 0.0, -1, -1, -1, 300.0, 300.0);
        AttachDynamicObjectToVehicle(PrivateVeh[12][pvObject][2], vehicleid, 1.051, -1.861, -0.250, 0.000, 0.000, 0.000);
        PrivateVeh[12][pv3DText] = Create3DTextLabel("Don't Touch", 0x33CCFFFF, 0.0, 0.0, 0.0, 15.0, 0, 1);
        Attach3DTextLabelToVehicle(PrivateVeh[12][pv3DText], PrivateVeh[12][pvID], 0.0, 0.0, 0.0);
    } //goto private
}

stock LoadPrivateVehicleModels()
{
    PrivateVeh[0][pvModel] = 411;
    PrivateVeh[1][pvModel] = 411;
    PrivateVeh[2][pvModel] = 560;
    PrivateVeh[3][pvModel] = 565;
    PrivateVeh[4][pvModel] = 565;
    PrivateVeh[5][pvModel] = 560;
    PrivateVeh[6][pvModel] = 562;
    PrivateVeh[7][pvModel] = 411;
    PrivateVeh[8][pvModel] = 560;
    PrivateVeh[9][pvModel] = 579;
    PrivateVeh[10][pvModel] = 562;
    PrivateVeh[11][pvModel] = 565;
    PrivateVeh[12][pvModel] = 411;
}

stock LoadPrivateVehicleColors()
{
    for (new i = 0; i < 13; i++)
    {
        PrivateVeh[i][pvColor1] = 1;
        PrivateVeh[i][pvColor2] = 1;
    }
}

stock IsValidPrivateVehicle(privateVehID)
{
    new vehicleid = PrivateVeh[privateVehID][pvID];
    if (vehicleid >= 1 && vehicleid < MAX_VEHICLES && IsValidVehicle(vehicleid))
    {
        return true;
    }
    return false;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    new stringprivate[256];
    new slot = VehicleToPrivateSlot[vehicleid];
    if (slot != -1 && !ispassenger)
    {
        printf("Player %d entered vehicle %d", playerid, vehicleid);
        printf("Slot %d", slot);
        if (PrivateVeh[slot][pvOwner][0] == '\0' || strcmp(PrivateVeh[slot][pvOwner], GetPlayerNickname(playerid), true) != 0)
        {
            new Float:cx, Float:cy, Float:cz;
            GetPlayerPos(playerid, cx, cy, cz);
            SetPlayerPos(playerid, cx, cy, cz);

            if (PrivateVeh[slot][pvOwner][0] == '\0')
            {
                format(stringprivate, 256, "“ова превозно средство н€ма притежател");
            }
            else
            {
                format(stringprivate, 256, "“ова превозно средство принадлежи на %s", PrivateVeh[slot][pvOwner]);
            }
            SendClientMessage(playerid, 0x636363FF, stringprivate);

        }
        return Y_HOOKS_CONTINUE_RETURN_1;
    }



    if (vehInShop[vehicleid])
    {
        if (!ispassenger)
        {
            new Float:cx, Float:cy, Float:cz;
            GetPlayerPos(playerid, cx, cy, cz);
            SetPlayerPos(playerid, cx, cy, cz);
            SendClientMessage(playerid, 0x636363FF, " упи си превозното средство и ще го караш !");
            return Y_HOOKS_CONTINUE_RETURN_1;
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}