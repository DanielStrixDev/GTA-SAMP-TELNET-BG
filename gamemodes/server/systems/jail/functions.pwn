stock SetPlayerToJailSpawn(playerid)
{
    ResetPlayerWeapons(playerid);
    SetPlayerVirtualWorld(playerid, 1);
    SetPlayerInterior(playerid, 4);
    SetPlayerPos(playerid, 299.7077, 303.4193, 999.1484);
    SetPlayerAttachedObject(playerid, 1, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);
    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CUFFED);
}

stock SetPlayerToPoliceJailSpawn(playerid)
{
    SetPlayerInterior(playerid, 3);
    SendClientMessage(playerid, 0x0040FFFF, "Jail: Ти все още си в затвора на полицията!");
    SetPlayerPos(playerid, 197.9882, 175.4870, 1003.0234);
    ResetPlayerWeapons(playerid);
}