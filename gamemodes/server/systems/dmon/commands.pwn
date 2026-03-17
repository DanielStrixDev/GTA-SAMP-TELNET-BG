CMD:dmoff(playerid, params[])
{
    if (playerInDMON[playerid] == 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в DMON!");
    }
    SetPlayerHealth(playerid, 0);
    playerInDMON[playerid] = 0;
    TextDrawHideForPlayer(playerid, DMON[playerid]);
    new level = PlayerInfo[playerid][pTeam];
    RestartPlayerColor(playerid);
    return 1;
}
CMD:dmon(playerid, params[])
{
    if (PlayerInfo[playerid][pAFK] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в AFK режим и не можеш да се телепортираш!");
        return 1;
    }
    if (PlayerInfo[playerid][pJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в админ затвора и не можеш да се телепортираш!");
        return 1;
    }
    if (PlayerInfo[playerid][pPJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в затвора и не можеш да се телепортираш!");
        return 1;
    }
    if (PlayerInfo[playerid][pDmon20SecWait] > 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Не са изминали 20 секунди откакто си написал /dmon!");
    if (cmn1[playerid] > 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да влезеш в арената, докато си CMN1!");
    }
    if (playerInDuel[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да влезеш в арената, докато си в дуел!");
    }
    if (playerInDMON[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече си в DMON!");
    }
    if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (PlayerInfo[playerid][pADuty] > 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти си ADMIN ON-DUTY и не можеш да влезеш в DMON!");
    if (PlayerInfo[playerid][pIFCDuty] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си IFC ON-DUTY!");
    if (IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си пешеходец за да си във DM зоната!");
    ResetPlayerWeapons(playerid);
    format(string, 256, "DM Area: %s влезе в DM арената!", GetPlayerNickname(playerid));
    SendClientMessageToAll(0xFFFF81FF, string);
    SendClientMessage(playerid, 0xFFFF81FF, "DM Area: Моля, използвайте /dmoff за да излезете от DM арената!");
    playerInDMON[playerid] = 1;
    new stringtext[115];
    PlayerInfo[playerid][pDmon20SecWait] = 20;
    TextDrawHideForPlayer(playerid, DMON[playerid]);
    format(stringtext, 115, " ~r~Kills: ~w~%d/~g~20", PlayerInfo[playerid][pDMONKills]);
    TextDrawSetString(DMON[playerid], stringtext);
    TextDrawShowForPlayer(playerid, DMON[playerid]);
    SetPlayerColor(playerid, 0xFFFF81FF);
    SetPlayerPosInDMON(playerid);
    GivePlayerGunInDMON(playerid);
    SetPlayerHealth(playerid, 100);
    SetPlayerArmour(playerid, 0);
    return 1;
}
