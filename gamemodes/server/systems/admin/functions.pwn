stock SetPlayerAdutyOnSpawn(playerid)
{
    SetPlayerColor(playerid, 0x7BFFFFFF);
    adutyskinchanged[playerid] = 1;
    SendClientMessage(playerid, 0x40BF00FF, "Ти все-още си On-Duty и трябва да помагаш на играчите");
    SetPlayerSkin(playerid, PlayerInfo[playerid][pASkin]);
    if (godmode[playerid] == 1)
    {
        SetPlayerHealth(playerid, 99999);
        SetPlayerArmour(playerid, 99999);
    }
    ResetPlayerWeapons(playerid);
}

stock CheckAdutySkinChange(playerid)
{
    if (adutyskinchanged[playerid] == 0)
    {
        spawnselectedskin2[playerid] = GetPlayerSkin(playerid);
        spawnselectedskin[playerid] = GetPlayerSkin(playerid);
    }
    else
    {
        spawnselectedskin2[playerid] = GetPlayerSkin(playerid);
        spawnselectedskin[playerid] = PlayerInfo[playerid][pASkin];
    }
}