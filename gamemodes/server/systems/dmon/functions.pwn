#include <YSI_Coding\y_hooks>

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

/*
* Hook
*/
hook OnPlayerSpawn(playerid)
{
    if (playerInDMON[playerid] == 1)
    {
        SetPlayerVirtualWorld(playerid, 3233);
        SetPlayerColor(playerid, 0xFFFF81FF);
        ResetPlayerWeapons(playerid);
        SetPlayerArmour(playerid, 0);
        new r = random(sizeof(DmonRandomWeapons));
        GivePlayerWeapon(playerid, DmonRandomWeapons[r][0], DmonRandomWeapons[r][1]);
        if (dmonArena == 1)
        {
            new spawnpos = randomex(1, 5);
            if (spawnpos < 3)
            {
                SetPlayerPos(playerid, 1411.2889, 1.3799, 1000.9237);
            }
            if (spawnpos > 2)
            {
                SetPlayerPos(playerid, 1360.4244, -39.4643, 1007.8828);
            }
            SetPlayerInterior(playerid, 1);
        }
        if (dmonArena == 2)
        {
            new spawnpos = randomex(1, 5);
            if (spawnpos < 3)
            {
                SetPlayerPos(playerid, -1426.4996, 1054.9972, 1038.4913);
            }
            if (spawnpos > 2)
            {
                SetPlayerPos(playerid, -1473.7843, 948.4413, 1036.7908);
            }
            SetPlayerInterior(playerid, 15);
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

stock ShowPlayerNewKillOnDmon(playerid)
{
    TextDrawShowForPlayer(playerid, DMONKillText);
    PlayerInfo[playerid][pHideDMONKillText] = 3;
}

stock PlayerReachDmonRecord(playerid)
{
    new stringaz[256];
    format(stringaz, 256, "~w~DM AREA~n~~n~~r~NEW RECORD: ~g~%d", PlayerInfo[playerid][pDMONKills2]);
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        GameTextForPlayer(i, stringaz, 3000, 3);
    }
    new stringa[256];
    if (RecordInfo[0][record] > 20)
    {
        format(stringa, 256, "TOP: %s надмина %s по най-много убийства без умиране в {FF0000}DM Area", GetPlayerNickname(playerid), RecordInfo[0][recordPlayer]);
        SendClientMessageToAll(0x80FF80FF, stringa);
        format(stringa, 256, "TOP: Новият резултат е %d убийства без умиране!", PlayerInfo[playerid][pDMONKills2]);
        SendClientMessageToAll(0x80FF80FF, stringa);
    }
    else
    {
        format(stringa, 256, "TOP: %s направи рекорд по най-много убийства без умиране в {FF0000}DM Area", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF80FF, stringa);
        format(stringa, 256, "TOP: Новият резултат е %d убийства без умиране!", PlayerInfo[playerid][pDMONKills2]);
        SendClientMessageToAll(0x80FF80FF, stringa);
    }
    RecordInfo[0][record] = PlayerInfo[playerid][pDMONKills2];
    new dmon[64];
    SaveRecords();
    PlayerInfo[playerid][pDMONKills2] = 0;
}

stock PlayerNewKillOnDmon(playerid)
{
    new stringtext[115];
    TextDrawHideForPlayer(playerid, DMON[playerid]);
    format(stringtext, 115, " ~r~Kills: ~w~%d/~g~20", PlayerInfo[playerid][pDMONKills]);
    TextDrawSetString(DMON[playerid], stringtext);
    TextDrawShowForPlayer(playerid, DMON[playerid]);
}

/*
* On player death
*/
hook OnPlayerDeath(playerid, killerid, reason)
{
    // Remove Duel Kills from player
    if (playerInDMON[playerid] == 1)
    {
        PlayerInfo[playerid][pDMONKills2] = 0;
    }

    if (playerInDMON[playerid] == 1 && playerInDMON[killerid] == 1)
    {
        PlayerInfo[killerid][pDMONKills2] += 1;
        PlayerInfo[killerid][pDMONKills] += 1;
        ShowPlayerNewKillOnDmon(killerid);
        PlayerNewKillOnDmon(killerid);
        GivePlayerArmour(killerid, 25);

        // Collect 20 Kills on DMON
        if (PlayerInfo[killerid][pDMONKills] >= 20)
        {
            GivePlayerEP(killerid, 1);
            PlayerInfo[killerid][pDMONKills] = 0;
            SendClientMessage(killerid, 0xFFFF81FF, "DM Area: Ти събра 20 убийства и за награда получаваш + 1 EP!");
        }

        if (PlayerInfo[killerid][pDMONKills2] > RecordInfo[0][record])
        {
            PlayerReachDmonRecord(killerid);
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}