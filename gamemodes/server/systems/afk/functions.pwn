stock SetPlayerToAfkSpawn(playerid)
{
    ResetPlayerWeapons(playerid);
    SetPlayerInterior(playerid, 15);
    SetPlayerColor(playerid, 0xD6F34AFF);
    SetPlayerPos(playerid, 2215.454833, -1147.475585, 1025.796875);
    SetPlayerVirtualWorld(playerid, playerid + 500);
}