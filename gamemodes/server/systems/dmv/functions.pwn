#include <YSI_Coding\y_hooks>

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    printf("[TEST] %s (ID: %d) влез в %d (ID: %d)", GetPlayerNickname(playerid), playerid, GetVehicleModel(vehicleid), vehicleid);
    if (ispassenger) return Y_HOOKS_CONTINUE_RETURN_1;
        
    if (IsBoat(vehicleid) && PlayerInfo[playerid][pLodka] == 0)
    {
        DenyVehicleEntry(playerid, "Ти нямаш шофьорска книжка за лодка!");
        return Y_HOOKS_CONTINUE_RETURN_1;
    }
    
    if (IsPlane(vehicleid) && PlayerInfo[playerid][pSamolet] == 0)
    {
        DenyVehicleEntry(playerid, "Ти нямаш шофьорска книжка за самолет!");
        return Y_HOOKS_CONTINUE_RETURN_1;
    }
    
    if (IsHelicopter(vehicleid) && PlayerInfo[playerid][pHelikopter] == 0)
    {
        DenyVehicleEntry(playerid, "Ти нямаш шофьорска книжка за хеликоптер!");
        return Y_HOOKS_CONTINUE_RETURN_1;
    }
    
    if (IsTrain(vehicleid) && PlayerInfo[playerid][pVlak] == 0)
    {
        DenyVehicleEntry(playerid, "Ти нямаш шофьорска книжка за влак!");
        return Y_HOOKS_CONTINUE_RETURN_1;
    }
    
    return Y_HOOKS_CONTINUE_RETURN_1;
}
