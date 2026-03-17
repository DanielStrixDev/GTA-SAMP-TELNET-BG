CMD:leaverace(playerid, params[])
{
    if (playerInStreetRace[playerid] == false) return SendClientMessage(playerid, COLOR_GRAD1, "Вие не сте в Street Race!");
    LeaveStreetRace(playerid);
    SetPlayerVirtualWorld(playerid, 0);
    if (IsPlayerInAnyVehicle(playerid))
    {
        new hisVeh = GetPlayerVehicleID(playerid);
        SetVehicleVirtualWorld(hisVeh, 0);
        PutPlayerInVehicle(playerid, hisVeh, 0);
    }
    SendClientMessage(playerid, COLOR_STREETRACE, "StreetRace: Вие напуснахте състезанието!");
    GivePlayerMission(playerid);
    return 1;
}
CMD:leavedm(playerid, params[])
{
    if (playerInDeathmatch[playerid] == false) return SendClientMessage(playerid, COLOR_GRAD1, "Вие не сте в Deathmatch!");
    LeaveDeathmatch(playerid);
    SetPlayerHealth(playerid, 0);
    SendClientMessage(playerid, COLOR_DEATHMATCH, "Deathmatch: Вие напуснахте боя!");
    return 1;
}
