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

CMD:startmoneybox(playerid, params[])
{
    if (missionActive != MISSION_NONE) return SendClientMessage(playerid, COLOR_GRAD1, "Вече има активна мисия!");

    missionActive = MISSION_MONEYBOX;
    isMoneyBoxGet = false;
    whoHaveMoneyBox = -1;
    lostMoneyBox = false;
    moneyBoxCPID = random(allMoneyBoxCheckPoints);

    SendClientMessageToAll(0x40BF00FF, "Moneybox: Нова мисия е стартирана! Отиди до червения маркер и вземи куфара с пари!");

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            GivePlayerMoneyBoxPoint(i);
        }
    }

    return 1;
}

CMD:startrace(playerid, params[])
{
    if (missionActive != MISSION_NONE) return SendClientMessage(playerid, COLOR_GRAD1, "Вече има активна мисия!");

    missionActive = MISSION_STREETRACE;
    streetRaceStarted = false;
    streetRaceStartTimer = 0;
    streetRacePlayers = 0;
    streetRacePositionIndex = 1;
    streetRaceTypeIndex = 1 + random(5);

    SendClientMessageToAll(COLOR_STREETRACE, "Streetrace: Нова мисия е стартирана! Отиди до стартовата линия и се включи в състезанието!");

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            GivePlayerStreetRacePoint(i);
        }
    }

    return 1;
}

CMD:startdm(playerid, params[])
{
    if (missionActive != MISSION_NONE) return SendClientMessage(playerid, COLOR_GRAD1, "Вече има активна мисия!");

    missionActive = MISSION_DEATHMATCH;
    deathmatchStarted = false;
    deathmatchStartTimer = 0;
    deathmatchPlayers = 0;
    deathmatchEndTimer = 0;

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        deathmatchKills[i] = 0;
    }

    SendClientMessageToAll(COLOR_DEATHMATCH, "Deathmatch: Нова мисия е стартирана! Отиди до червения маркер и се включи в битката!");

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            GivePlayerDeathmatchPoint(i);
        }
    }

    return 1;
}