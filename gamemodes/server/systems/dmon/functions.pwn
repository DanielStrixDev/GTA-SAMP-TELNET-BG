stock CreateDMONText(playerid)
{
    DMON[playerid] = TextDrawCreate(528.000000, 385.000000, " ~r~Kills: ~w~0/~g~20");
    TextDrawAlignment(DMON[playerid], 0);
    TextDrawBackgroundColor(DMON[playerid], 0x000000ff);
    TextDrawFont(DMON[playerid], 1);
    TextDrawLetterSize(DMON[playerid], 0.2800, 1.8000);
    TextDrawSetProportional(DMON[playerid], 1);
    TextDrawSetShadow(DMON[playerid], 1);
}

stock IfPlayerInDmonChangePos(playerid)
{
    if (playerInDMON[playerid] == 1)
    {
        new randomSpawnPos = randomex(1, 5);
        if (dmonArena == 1)
        {
            if (randomSpawnPos < 3)
            {
                SetPlayerPos(playerid, 1411.2889, 1.3799, 1000.9237);
            }
            if (randomSpawnPos > 2)
            {
                SetPlayerPos(playerid, 1360.4244, -39.4643, 1007.8828);
            }
            SetPlayerInterior(playerid, 1);
        }
        if (dmonArena == 2)
        {
            if (randomSpawnPos < 3)
            {
                SetPlayerPos(playerid, -1426.4996, 1054.9972, 1038.4913);
            }
            if (randomSpawnPos > 2)
            {
                SetPlayerPos(playerid, -1473.7843, 948.4413, 1036.7908);
            }
            SetPlayerInterior(playerid, 15);
        }
        SetPlayerVirtualWorld(playerid, 3233);
        SetCameraBehindPlayer(playerid);
    }
}

stock SetPlayerPosInDMON(playerid)
{
    new randomSpawnPos = randomex(1, 5);
    if (dmonArena == 1)
    {
        if (randomSpawnPos < 3)
        {
            SetPlayerPos(playerid, 1411.2889, 1.3799, 1000.9237);
        }
        if (randomSpawnPos > 2)
        {
            SetPlayerPos(playerid, 1360.4244, -39.4643, 1007.8828);
        }
        SetPlayerInterior(playerid, 1);
    }
    if (dmonArena == 2)
    {
        if (randomSpawnPos < 3)
        {
            SetPlayerPos(playerid, -1426.4996, 1054.9972, 1038.4913);
        }
        if (randomSpawnPos > 2)
        {
            SetPlayerPos(playerid, -1473.7843, 948.4413, 1036.7908);
        }
        SetPlayerInterior(playerid, 15);
    }
    SetPlayerVirtualWorld(playerid, 3233);
    SetCameraBehindPlayer(playerid);
}

stock GivePlayerGunInDMON(playerid)
{
    new r = random(sizeof(DmonRandomWeapons));
    GivePlayerWeapon(playerid, DmonRandomWeapons[r][0], DmonRandomWeapons[r][1]);
}