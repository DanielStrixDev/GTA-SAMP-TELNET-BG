stock GivePlayerLostMoneyBox(playerWithMB, playerid)
{
    GetPlayerPos(playerWithMB, LX, LY, LZ);
    if (onWork[playerid] == 0 && gpsOn[playerid] == false)
    {
        SetPlayerCheckpoint(playerid, LX, LY, LZ, 5.0);
    }
}
stock ExitWithMoneyBox(playerid)
{
    if (isMoneyBoxGet == true)
    {
        if (playerWithMoneyBox[playerid] == true)
        {
            new stringmoneybox[256];
            format(stringmoneybox, 256, "Moneybox: %s изпусна куфара с пари. Отиди до червения маркер и пребири куфара.", GetPlayerNickname(playerid));
            SendClientMessageToAll(0x40BF00FF, stringmoneybox);
            lostMoneyBox = true;
            playerWithMoneyBox[playerid] = false;
            whoHaveMoneyBox = -1;
            GetPlayerPos(playerid, LX, LY, LZ);
            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                GivePlayerLostMoneyBox(playerid, i);
            }
        }
    }
}
stock KilledWithMoneyBox(playerid)
{
    if (isMoneyBoxGet == true)
    {
        if (playerWithMoneyBox[playerid] == true)
        {
            new stringmoneybox[256];
            format(stringmoneybox, 256, "Moneybox: %s изпусна куфара с пари. Отиди до червения маркер и пребири куфара.", GetPlayerNickname(playerid));
            SendClientMessageToAll(0x40BF00FF, stringmoneybox);
            lostMoneyBox = true;
            playerWithMoneyBox[playerid] = false;
            whoHaveMoneyBox = -1;
            GetPlayerPos(playerid, LX, LY, LZ);
            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                GivePlayerLostMoneyBox(playerid, i);
            }
        }
    }
}
stock KilledWithCMN1(killerid, playerid)
{
    if (cmn1[playerid] == 1)
    {
        if (killerid != INVALID_PLAYER_ID)
        {
            new cmn1string[256];
            format(cmn1string, 256, "CMN1: %s успя да убие %s и получава CMN1 Kill.", GetPlayerNickname(killerid), GetPlayerNickname(playerid));
            SendClientMessageToAll(0xF97804FF, cmn1string);
            PlayerInfo[killerid][pCMN1] += 1;
            if (PlayerInfo[killerid][pCMN1] == 4)
            {
                SendClientMessage(killerid, 0xF2E93EFF, "Ти събра 4 CMN1 убийства и за награда получаваш + 8EP");
                GivePlayerEP(killerid, 8);
                PlayerInfo[killerid][pCMN1] = 0;
            }
        }
        else if (killerid == INVALID_PLAYER_ID)
        {
            new cmn1string[256];
            format(cmn1string, 256, "CMN1: %s се самоуби и вече не е CMN1, но той загуби неговата точка от мисията!", GetPlayerNickname(playerid));
            SendClientMessageToAll(0xF97804FF, cmn1string);
        }
        //MinusOneCMN1(playerid);
        GivePlayerCash(playerid, -cmn1Money);
        cmn1[playerid] = 0;
        PlayerInfo[playerid][pCmn1Timer] = 0;
    }
}

stock ExitWithCMN1(playerid)
{
    if (cmn1[playerid] == 1)
    {
        new cmn1string[256];
        format(cmn1string, 256, "CMN1: %s излезе от сървъра и изгуби своята награда.", GetPlayerNickname(playerid));
        SendClientMessageToAll(0xF97804FF, cmn1string);
        GivePlayerCash(playerid, -cmn1Money);
        //MinusOneCMN1(playerid);
        cmn1[playerid] = 0;
        PlayerInfo[playerid][pCmn1Timer] = 0;
    }
}

stock MinusOneCMN1(playerid)
{

    switch (cmn1Mission[playerid])
    {
        case MISSION_DEATHMATCH:
        {
            if (PlayerInfo[playerid][pDeathmatchSuccess] > 0)
            {
                PlayerInfo[playerid][pDeathmatchSuccess] -= 1;
            }
            else if (PlayerInfo[playerid][pDeathmatchSuccess] == 0)
            {
                PlayerInfo[playerid][pDeathmatchSuccess] = 3;
            }
        }
        case MISSION_MONEYBOX:
        {
            if (PlayerInfo[playerid][pMoneyboxSuccess] > 0)
            {
                PlayerInfo[playerid][pMoneyboxSuccess] -= 1;
            }
            else if (PlayerInfo[playerid][pMoneyboxSuccess] == 0)
            {
                PlayerInfo[playerid][pMoneyboxSuccess] = 3;
            }
        }
        case MISSION_STREETRACE:
        {
            if (PlayerInfo[playerid][pStreetRaceSuccess] > 0)
            {
                PlayerInfo[playerid][pStreetRaceSuccess] -= 1;
            }
            else if (PlayerInfo[playerid][pStreetRaceSuccess] == 0)
            {
                PlayerInfo[playerid][pStreetRaceSuccess] = 3;
            }
        }

    }
}
stock LastPlayerInRace()
{
    new lastRacerID;
    for (new i; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            if (playerInStreetRace[i] == true)
            {
                lastRacerID = i;
            }
        }
    }
    return lastRacerID;
}
stock EndStreetRaceBeforeNewMission()
{
    streetRaceStartTimer = 0;
    streetRacePlayers = 0;
    for (new i; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            if (playerInStreetRace[i] == true)
            {
                DisablePlayerRaceCheckpoint(i);
                streetRacePlayerColorChange[i] = 0;
                playerInStreetRace[i] = false;
                RestartPlayerColor(i);
                SetPlayerToVirtualWorldNull(i);
            }
        }
    }

}
stock LeaveStreetRace(playerid)
{
    streetRacePlayerColorChange[playerid] = 0;
    playerInStreetRace[playerid] = false;
    RestartPlayerColor(playerid);
    DisablePlayerRaceCheckpoint(playerid);
    streetRacePlayers -= 1;
    new Float:health;
    GetPlayerHealth(playerid, health);
    if (health > 0)
    {
        SetPlayerToVirtualWorldNull(playerid);
    }

    if (streetRaceStarted == false) //goto 3
    {
        if (streetRacePlayers <= 1)
        {
            if (streetRaceStartTimer >= 1)
            {
                UnfreezeSRacePlayers();
                SendClientMessageToAll(COLOR_STREETRACE, "Streetrace: Състезанието няма да започне сега, защото не останаха играчи!");
            }
            streetRaceStartTimer = 0;
        }
    }
    else if (streetRaceStarted == true)
    {
        if (streetRacePlayers == 1) //last player wins the race
        {
            new lastRacerID = LastPlayerInRace();
            GivePlayerCMN1Status(lastRacerID);
            cmn1Mission[lastRacerID] = MISSION_STREETRACE;
            streetRaceSecondsCounter[lastRacerID] = 0;
            format(string256, 256, "Streetrace: Състезанието приключи, победител е %s, той спечели %d", GetPlayerNickname(lastRacerID), cmn1Money);
            SendClientMessageToAll(COLOR_STREETRACE, string256);
            GivePlayerWantedLevel(playerid, 1, "Състезание");
            format(string256, 256, "CMN1: %s е заподозрян в състезание,убий го и ще получиш CMN1 Kill.", GetPlayerNickname(lastRacerID));
            SendClientMessageToAll(0xF97804FF, string256);
            SendClientMessage(lastRacerID, 0xF97804FF, "CMN1: Трябва да оцелееш 5 минути за да не си преследван повече.");
            if (missionActive == MISSION_STREETRACE)
            {
                missionActive = MISSION_NONE;
            }
        }
        if (streetRacePlayers == 0)
        {
            streetRaceSecondsCounter[playerid] = 0;
            SendClientMessageToAll(COLOR_STREETRACE, "Streetrace: Състезанието завърши без победител!");
            streetRaceStarted = false;
            streetRacePlayers = 0;
            streetRaceStartTimer = 0;
            streetRaceTimerToEnd = 0;
        }
    }

}

stock UnfreezeSRacePlayers()
{
    for (new i; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            if (playerInStreetRace[i] == true)
            {
                TogglePlayerControllable(i, 1);
            }
        }
    }
}

stock FreezeSRacePlayers()
{
    for (new i; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            if (playerInStreetRace[i] == true)
            {
                TogglePlayerControllable(i, 0);
            }
        }
    }
}

stock LeaveDeathmatch(playerid)
{
    playerInDeathmatch[playerid] = false;
    deathmatchPlayers--;
    if (deathmatchPlayers < 2 && deathmatchStartTimer > 0)
    {
        deathmatchStartTimer = 0;
    }
    if (deathmatchEndTimer > 0)
    {
        if (deathmatchPlayers == 1)
        {
            for (new i; i < MAX_PLAYERS; i++)
            {
                if (IsPlayerConnected(i))
                {
                    if (playerInDeathmatch[i] == true)
                    {
                        deathmatchEndTimer = 0;
                        GivePlayerCMN1Status(i);
                        cmn1Mission[i] = MISSION_DEATHMATCH;
                        SetPlayerToLastCoors(i);
                        format(string256, 256, "Deathmatch: Битката приключи, победител е %s, той спечели %d", GetPlayerNickname(i), cmn1Money);
                        SendClientMessageToAll(COLOR_DEATHMATCH, string256);
                        GivePlayerWantedLevel(playerid, 1, "Убийство");
                        format(string256, 256, "CMN1: %s е заподозрян в убийства, убий го и ще получиш CMN1 Kill.", GetPlayerNickname(i));
                        SendClientMessageToAll(0xF97804FF, string256);
                        SendClientMessage(i, 0xF97804FF, "CMN1: Трябва да оцелееш 5 минути за да не си преследван повече.");
                        if (missionActive == MISSION_DEATHMATCH)
                        {
                            missionActive = MISSION_NONE;
                        }
                    }
                }
            }
        }
    }
}

stock GivePlayerCMN1Status(playerid)
{
    cmn1Money = randomex(10000, 50000);
    GivePlayerCash(playerid, cmn1Money);
    cmn1[playerid] = 1;
    PlayerInfo[playerid][pCmn1Timer] = 60 * 5;
    cmn1PlayerColorChange[playerid] = 2;
}

stock DeathInTurfAttack(playerid)
{
    new attackerFaction = PlayerInfo[playerid][pTeam];
    if (isTurfMember[playerid] == true && isGangAttackingTurf[attackerFaction] == true)
    {
        new turfAttacked = TeamInfo[attackerFaction][tTurfAttacked];
        new turfOwner = TurfInfo[turfAttacked][TurfOwner];
        format(string256, 256, "[FACTION CHAT] {FF0000}%s{C800FF} умря и отпадна от атаката на %s!", GetPlayerNickname(playerid), TeamInfo[turfOwner][tName]);
        SendFactionMessage(attackerFaction, 0xC800FFFF, string256);
        inTurfAttackMembers[attackerFaction]--;
        isTurfMember[playerid] = false;
        if (inTurfAttackMembers[attackerFaction] == 0)
        {
            startturf = 0;
            format(string256, 256, "Turf War: {FF0000}%s{C800FF} не успя да превземе %s територията на %s!", TeamInfo[attackerFaction][tName], TurfInfo[turfAttacked][TurfName],
                TeamInfo[turfOwner][tName]);
            SendClientMessageToAll(0xC800FFFF, string256);
            FailTurfAttack(attackerFaction);
        }
    }
}


stock ExitInTurfAttack(playerid)
{
    new attackerFaction = PlayerInfo[playerid][pTeam];
    if (isTurfMember[playerid] == true && isGangAttackingTurf[attackerFaction] == true)
    {
        new turfAttacked = TeamInfo[attackerFaction][tTurfAttacked];
        new turfOwner = TurfInfo[turfAttacked][TurfOwner];
        format(string256, 256, "[FACTION CHAT] {FF0000}%s{C800FF} излезе от сървъра и отпадна от атаката на %s!", GetPlayerNickname(playerid), TeamInfo[turfOwner][tName]);
        SendFactionMessage(attackerFaction, 0xC800FFFF, string256);
        inTurfAttackMembers[attackerFaction]--;
        if (inTurfAttackMembers[attackerFaction] == 0)
        {
            startturf = 0;
            format(string256, 256, "Turf War: {FF0000}%s{C800FF} не успя да превземе %s територията на %s!", TeamInfo[attackerFaction][tName], TurfInfo[turfAttacked][TurfName],
                TeamInfo[turfOwner][tName]);
            SendClientMessageToAll(0xC800FFFF, string256);
            FailTurfAttack(attackerFaction);
        }
    }
}


stock GiveSRaceFirstCheckpoint(playerid)
{
    if (streetRaceTypeIndex == 1) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceSprintCheckPoint1, StreetRaceSprintCheckPoint2, 5.0);
    if (streetRaceTypeIndex == 2) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceDriftCheckPoint1, StreetRaceDriftCheckPoint2, 5.0);
    if (streetRaceTypeIndex == 3) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceDragCheckPoint1, StreetRaceDragCheckPoint2, 5.0);
    if (streetRaceTypeIndex == 4) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceLapsCheckPoint1, StreetRaceLapsCheckPoint2, 5.0);
    if (streetRaceTypeIndex == 5) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceOffroadCheckPoint1, StreetRaceOffroadCheckPoint2, 5.0);
}

stock IsInStreetRaceStartingPoint(playerid)
{
    if (GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0 && playerInStreetRace[playerid] == false)
    {
        if (streetRaceTypeIndex == 1 && IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceSprintWaitPoint)) return 0;
        if (streetRaceTypeIndex == 2 && IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDriftWaitPoint)) return 1;
        if (streetRaceTypeIndex == 3 && IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDragWaitPoint)) return 2;
        if (streetRaceTypeIndex == 4 && IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceLapsWaitPoint)) return 3;
        if (streetRaceTypeIndex == 5 && IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceOffroadWaitPoint)) return 4;
    }
    return -1;
}

stock GivePlayerDeathmatchPoint(playerid)
{
    deathmatchFightArea = randomex(1, 3);
    new missionCheckpointIndex = randomex(1, 3);
    if (missionCheckpointIndex == 1)
    {
        if (onWork[playerid] == 0 && gpsOn[playerid] == false)
        {
            SetPlayerCheckpoint(playerid, DeathmatchCheckpoint1, 5.0);
        }
    }
    else if (missionCheckpointIndex == 2)
    {
        if (onWork[playerid] == 0 && gpsOn[playerid] == false)
        {
            SetPlayerCheckpoint(playerid, DeathmatchCheckpoint2, 5.0);
        }
    }
}

stock GivePlayerStreetRacePoint(playerid)
{
    if (streetRaceStarted == false)
    {
        if (onWork[playerid] == 0 && gpsOn[playerid] == false)
        {

            switch (streetRaceTypeIndex)
            {
                case 1:
                {
                    SetPlayerRaceCheckpoint(playerid, 2, StreetRaceSprintWaitPoint, StreetRaceSprintWaitPoint, 5.0); //goto
                }
                case 2:
                {
                    SetPlayerRaceCheckpoint(playerid, 2, StreetRaceDriftWaitPoint, StreetRaceDriftWaitPoint, 5.0); //goto
                }
                case 3:
                {
                    SetPlayerRaceCheckpoint(playerid, 2, StreetRaceDragWaitPoint, StreetRaceDragWaitPoint, 5.0); //goto
                }
                case 4:
                {
                    SetPlayerRaceCheckpoint(playerid, 2, StreetRaceLapsWaitPoint, StreetRaceLapsWaitPoint, 5.0); //goto
                }
                case 5:
                {
                    SetPlayerRaceCheckpoint(playerid, 2, StreetRaceOffroadWaitPoint, StreetRaceOffroadWaitPoint, 5.0); //goto
                }
            }

        }
    }
}

stock GivePlayerMoneyBoxPoint(playerid)
{
    if (isMoneyBoxGet == false)
    {
        GivePlayerMBCheckPoint(playerid);
    }
    else
    {
        GivePlayerMBDeliverPoint(playerid);
    }
}
GivePlayerMission(playerid)
{
    if (missionActive == MISSION_DEATHMATCH)
    {
        GivePlayerDeathmatchPoint(playerid);
    }
    if (missionActive == MISSION_MONEYBOX)
    {
        GivePlayerMoneyBoxPoint(playerid);
    }
    if (missionActive == MISSION_STREETRACE)
    {
        GivePlayerStreetRacePoint(playerid);
    }
}

OnPlayerEnterGiveMission(playerid)
{
    if (missionActive == MISSION_DEATHMATCH && deathmatchStarted == false)
    {
        SendClientMessage(playerid, COLOR_DEATHMATCH, "Deathmatch: Все още не е започнала битката и имаш шанс да се включиш в нея!");
        GameTextForPlayer(playerid, "~w~Mission~n~~r~Deathmatch", 1000, 1);
        GivePlayerDeathmatchPoint(playerid);
    }
    if (missionActive == MISSION_STREETRACE && streetRaceStarted == false)
    {
        new stringRace[256];
        format(stringRace, 256, "Streetrace: Все още не е започнало %s състезанието и имаш шанс да се включиш!", StreetRaceInfo[streetRaceTypeIndex][stTypeName]);
        SendClientMessage(playerid, COLOR_STREETRACE, stringRace);
        if (StreetRaceInfo[streetRaceTypeIndex][stWinTime] != 0)
        {
            format(stringRace, 256, "Streetrace: Най-доброто време на това състезание е %d секунди, отбелязано от %s", StreetRaceInfo[streetRaceTypeIndex][stWinTime], StreetRaceInfo[streetRaceTypeIndex][stWinner]);
            SendClientMessage(playerid, COLOR_STREETRACE, stringRace);
        }
        else if (StreetRaceInfo[streetRaceTypeIndex][stWinTime] == 0)
        {
            SendClientMessage(playerid, COLOR_STREETRACE, "Streetrace: Това състезание все още няма поставен рекорд!");
        }
        GameTextForPlayer(playerid, "~w~Mission~n~~b~Streetrace", 1000, 1);
        GivePlayerStreetRacePoint(playerid);
    }
    if (missionActive == MISSION_MONEYBOX)
    {
        SendClientMessage(playerid, 0x40BF00FF, "Moneybox: В момента има MoneyBox и имаш шанса да спечелиш пари!");
        GameTextForPlayer(playerid, "~w~Mission~n~~g~Moneybox", 1000, 1);
        GivePlayerMoneyBoxPoint(playerid);
    }
}

stock BestDMKiller()
{
    new tmpID;
    for (new i; i < MAX_PLAYERS; i++)
    {
        for (new j = MAX_PLAYERS; j >= 0; j--)
        {
            if (playerInDeathmatch[i] == true && playerInDeathmatch[j] == true)
            {
                if (deathmatchKills[i] > deathmatchKills[tmpID] && deathmatchKills[j] > deathmatchKills[tmpID])
                {
                    if (deathmatchKills[i] > deathmatchKills[j])
                    {
                        tmpID = i;
                    }
                }
            }
        }
    }
    return tmpID;
}

stock PlayerFinishingRace(playerid)
{

    switch (streetRacePositionIndex)
    {
        case 1:
        {
            streetRaceTimerToEnd = 60;
            GivePlayerCMN1Status(playerid);
            cmn1Mission[playerid] = MISSION_STREETRACE;
            format(string256, 256, "Streetrace: %s завърши пръв за %d секунди, той спечели $%d", GetPlayerNickname(playerid), streetRaceSecondsCounter[playerid], cmn1Money);
            SendClientMessageToAll(COLOR_STREETRACE, string256);
            if ((streetRaceSecondsCounter[playerid] < StreetRaceInfo[streetRaceTypeIndex][stWinTime]) || StreetRaceInfo[streetRaceTypeIndex][stWinTime] == 0)
            {
                format(string256, 256, "Streetrace: %s постави нов рекорд за това състезание - %d секунди", GetPlayerNickname(playerid), streetRaceSecondsCounter[playerid]);
                SendClientMessageToAll(COLOR_STREETRACE, string256);
                SaveNewRaceFinishTime(playerid, streetRaceTypeIndex, streetRaceSecondsCounter[playerid]);
            }
            GivePlayerWantedLevel(playerid, 1, "Състезание");
            format(string256, 256, "CMN1: %s е заподозрян в състезание,убий го и ще получиш CMN1 Kill.", GetPlayerNickname(playerid));
            SendClientMessageToAll(0xF97804FF, string256);
            SendClientMessage(playerid, 0xF97804FF, "CMN1: Трябва да оцелееш 5 минути за да не си преследван повече.");
            streetRacePositionIndex = 2;
            streetRaceSecondsCounter[playerid] = 0;
            streetRacePlayerColorChange[playerid] = 0;
            playerInStreetRace[playerid] = false;
            //goto - open
            //goto - close
        }
        case 2:
        {
            streetRacePositionIndex = 3;
        }
        case 3:
        {
            streetRacePositionIndex = 4;
        }
    }
    DisablePlayerRaceCheckpoint(playerid);
    SetPlayerToVirtualWorldNull(playerid);
}

stock GivePlayerMBDeliverPoint(playerid)
{
    if (onWork[playerid] == 0 && gpsOn[playerid] == false)
    {
        DisablePlayerRaceCheckpoint(playerid);
        DisablePlayerCheckpoint(playerid);
        if (moneyBoxDPID == 0) SetPlayerCheckpoint(playerid, MoneyBoxDeliverpoint1, 3.0);
        else if (moneyBoxDPID == 1) SetPlayerCheckpoint(playerid, MoneyBoxDeliverpoint2, 3.0);
        else if (moneyBoxDPID == 2) SetPlayerCheckpoint(playerid, MoneyBoxDeliverpoint3, 3.0);
        else if (moneyBoxDPID == 3) SetPlayerCheckpoint(playerid, MoneyBoxDeliverpoint4, 3.0);
    }
}

stock GivePlayerMBCheckPoint(playerid)
{
    if (onWork[playerid] == 0 && gpsOn[playerid] == false)
    {
        DisablePlayerRaceCheckpoint(playerid);
        DisablePlayerCheckpoint(playerid);
        if (moneyBoxCPID == 0) SetPlayerRaceCheckpoint(playerid, 2, MoneyBoxCheckpoint1, MoneyBoxCheckpoint1, 3.0);
        else if (moneyBoxCPID == 1) SetPlayerRaceCheckpoint(playerid, 2, MoneyBoxCheckpoint2, MoneyBoxCheckpoint2, 3.0);
        else if (moneyBoxCPID == 2) SetPlayerRaceCheckpoint(playerid, 2, MoneyBoxCheckpoint3, MoneyBoxCheckpoint3, 3.0);
        else if (moneyBoxCPID == 3) SetPlayerRaceCheckpoint(playerid, 2, MoneyBoxCheckpoint4, MoneyBoxCheckpoint4, 3.0);
    }
}
