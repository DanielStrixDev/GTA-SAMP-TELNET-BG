#include <YSI_Coding\y_hooks>

/*
* Missions
*/
stock GivePlayerMission(playerid)
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

stock OnPlayerEnterGiveMission(playerid)
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


/*
* Deathmatch
*/

stock LeaveDeathmatch(playerid)
{
    if (playerInDeathmatch[playerid] == true)
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

/*
* Moneybox
*/
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

stock GivePlayerMBCheckPoint(playerid)
{
    if (onWork[playerid] == 0 && gpsOn[playerid] == false)
    {
        DisablePlayerRaceCheckpoint(playerid);
        DisablePlayerCheckpoint(playerid);
        if (moneyBoxCPID == 0) SetPlayerRaceCheckpoint(playerid, 2, MoneyBoxCheckpoint1_X, MoneyBoxCheckpoint1_Y, MoneyBoxCheckpoint1_Z, MoneyBoxCheckpoint1_X, MoneyBoxCheckpoint1_Y, MoneyBoxCheckpoint1_Z, 3.0);
        else if (moneyBoxCPID == 1) SetPlayerRaceCheckpoint(playerid, 2, MoneyBoxCheckpoint2_X, MoneyBoxCheckpoint2_Y, MoneyBoxCheckpoint2_Z, MoneyBoxCheckpoint2_X, MoneyBoxCheckpoint2_Y, MoneyBoxCheckpoint2_Z, 3.0);
        else if (moneyBoxCPID == 2) SetPlayerRaceCheckpoint(playerid, 2, MoneyBoxCheckpoint3_X, MoneyBoxCheckpoint3_Y, MoneyBoxCheckpoint3_Z, MoneyBoxCheckpoint3_X, MoneyBoxCheckpoint3_Y, MoneyBoxCheckpoint3_Z, 3.0);
        else if (moneyBoxCPID == 3) SetPlayerRaceCheckpoint(playerid, 2, MoneyBoxCheckpoint4_X, MoneyBoxCheckpoint4_Y, MoneyBoxCheckpoint4_Z, MoneyBoxCheckpoint4_X, MoneyBoxCheckpoint4_Y, MoneyBoxCheckpoint4_Z, 3.0);
    }
}

stock GivePlayerMBDeliverPoint(playerid)
{
    if (onWork[playerid] == 0 && gpsOn[playerid] == false)
    {
        DisablePlayerRaceCheckpoint(playerid);
        DisablePlayerCheckpoint(playerid);
        if (moneyBoxDPID == 0) SetPlayerCheckpoint(playerid, MoneyBoxDeliverpoint1_X, MoneyBoxDeliverpoint1_Y, MoneyBoxDeliverpoint1_Z, 3.0);
        else if (moneyBoxDPID == 1) SetPlayerCheckpoint(playerid, MoneyBoxDeliverpoint2_X, MoneyBoxDeliverpoint2_Y, MoneyBoxDeliverpoint2_Z, 3.0);
        else if (moneyBoxDPID == 2) SetPlayerCheckpoint(playerid, MoneyBoxDeliverpoint3_X, MoneyBoxDeliverpoint3_Y, MoneyBoxDeliverpoint3_Z, 3.0);
        else if (moneyBoxDPID == 3) SetPlayerCheckpoint(playerid, MoneyBoxDeliverpoint4_X, MoneyBoxDeliverpoint4_Y, MoneyBoxDeliverpoint4_Z, 3.0);
    }
}


/*
* Street Race
*/
stock GiveSRaceFirstCheckpoint(playerid)
{
    if (streetRaceTypeIndex == 1) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceSprintCheckPoint1_X, StreetRaceSprintCheckPoint1_Y, StreetRaceSprintCheckPoint1_Z, StreetRaceSprintCheckPoint2_X, StreetRaceSprintCheckPoint2_Y, StreetRaceSprintCheckPoint2_Z, 5.0);
    if (streetRaceTypeIndex == 2) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceDriftCheckPoint1_X, StreetRaceDriftCheckPoint1_Y, StreetRaceDriftCheckPoint1_Z, StreetRaceDriftCheckPoint2_X, StreetRaceDriftCheckPoint2_Y, StreetRaceDriftCheckPoint2_Z, 5.0);
    if (streetRaceTypeIndex == 3) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceDragCheckPoint1_X, StreetRaceDragCheckPoint1_Y, StreetRaceDragCheckPoint1_Z, StreetRaceDragCheckPoint2_X, StreetRaceDragCheckPoint2_Y, StreetRaceDragCheckPoint2_Z, 5.0);
    if (streetRaceTypeIndex == 4) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceLapsCheckPoint1_X, StreetRaceLapsCheckPoint1_Y, StreetRaceLapsCheckPoint1_Z, StreetRaceLapsCheckPoint2_X, StreetRaceLapsCheckPoint2_Y, StreetRaceLapsCheckPoint2_Z, 5.0);
    if (streetRaceTypeIndex == 5) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceOffroadCheckPoint1_X, StreetRaceOffroadCheckPoint1_Y, StreetRaceOffroadCheckPoint1_Z, StreetRaceOffroadCheckPoint2_X, StreetRaceOffroadCheckPoint2_Y, StreetRaceOffroadCheckPoint2_Z, 5.0);
}

stock IsInStreetRaceStartingPoint(playerid)
{
    if (GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0 && playerInStreetRace[playerid] == false)
    {
        if (streetRaceTypeIndex == 1 && IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceSprintWaitPoint_X, StreetRaceSprintWaitPoint_Y, StreetRaceSprintWaitPoint_Z)) return 0;
        if (streetRaceTypeIndex == 2 && IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDriftWaitPoint_X, StreetRaceDriftWaitPoint_Y, StreetRaceDriftWaitPoint_Z)) return 1;
        if (streetRaceTypeIndex == 3 && IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDragWaitPoint_X, StreetRaceDragWaitPoint_Y, StreetRaceDragWaitPoint_Z)) return 2;
        if (streetRaceTypeIndex == 4 && IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceLapsWaitPoint_X, StreetRaceLapsWaitPoint_Y, StreetRaceLapsWaitPoint_Z)) return 3;
        if (streetRaceTypeIndex == 5 && IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceOffroadWaitPoint_X, StreetRaceOffroadWaitPoint_Y, StreetRaceOffroadWaitPoint_Z)) return 4;
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
            SetPlayerCheckpoint(playerid, DeathmatchCheckpoint1_X, DeathmatchCheckpoint1_Y, DeathmatchCheckpoint1_Z, 5.0);
        }
    }
    else if (missionCheckpointIndex == 2)
    {
        if (onWork[playerid] == 0 && gpsOn[playerid] == false)
        {
            SetPlayerCheckpoint(playerid, DeathmatchCheckpoint2_X, DeathmatchCheckpoint2_Y, DeathmatchCheckpoint2_Z, 5.0);
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
                    SetPlayerRaceCheckpoint(playerid, 2, StreetRaceSprintWaitPoint_X, StreetRaceSprintWaitPoint_Y, StreetRaceSprintWaitPoint_Z, StreetRaceSprintWaitPoint_X, StreetRaceSprintWaitPoint_Y, StreetRaceSprintWaitPoint_Z, 5.0); //goto
                }
                case 2:
                {
                    SetPlayerRaceCheckpoint(playerid, 2, StreetRaceDriftWaitPoint_X, StreetRaceDriftWaitPoint_Y, StreetRaceDriftWaitPoint_Z, StreetRaceDriftWaitPoint_X, StreetRaceDriftWaitPoint_Y, StreetRaceDriftWaitPoint_Z, 5.0); //goto
                }
                case 3:
                {
                    SetPlayerRaceCheckpoint(playerid, 2, StreetRaceDragWaitPoint_X, StreetRaceDragWaitPoint_Y, StreetRaceDragWaitPoint_Z, StreetRaceDragWaitPoint_X, StreetRaceDragWaitPoint_Y, StreetRaceDragWaitPoint_Z, 5.0); //goto
                }
                case 4:
                {
                    SetPlayerRaceCheckpoint(playerid, 2, StreetRaceLapsWaitPoint_X, StreetRaceLapsWaitPoint_Y, StreetRaceLapsWaitPoint_Z, StreetRaceLapsWaitPoint_X, StreetRaceLapsWaitPoint_Y, StreetRaceLapsWaitPoint_Z, 5.0); //goto
                }
                case 5:
                {
                    SetPlayerRaceCheckpoint(playerid, 2, StreetRaceOffroadWaitPoint_X, StreetRaceOffroadWaitPoint_Y, StreetRaceOffroadWaitPoint_Z, StreetRaceOffroadWaitPoint_X, StreetRaceOffroadWaitPoint_Y, StreetRaceOffroadWaitPoint_Z, 5.0); //goto
                }
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
    if (playerInStreetRace[playerid])
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

/*
* CMN1
*/
stock GivePlayerCMN1Status(playerid)
{
    cmn1Money = randomex(10000, 50000);
    GivePlayerCash(playerid, cmn1Money);
    cmn1[playerid] = 1;
    PlayerInfo[playerid][pCmn1Timer] = 60 * 5;
    cmn1PlayerColorChange[playerid] = 2;
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

/*
* Hook
*/
public OnPlayerEnterRaceCheckpoint(playerid)
{
    if (IsPlayerInRangeOfPoint(playerid, 5.0, MoneyBoxCheckpoint1_X, MoneyBoxCheckpoint1_Y, MoneyBoxCheckpoint1_Z) || IsPlayerInRangeOfPoint(playerid, 5.0, MoneyBoxCheckpoint2_X, MoneyBoxCheckpoint2_Y, MoneyBoxCheckpoint2_Z) ||
            IsPlayerInRangeOfPoint(playerid, 5.0, MoneyBoxCheckpoint3_X, MoneyBoxCheckpoint3_Y, MoneyBoxCheckpoint3_Z) || IsPlayerInRangeOfPoint(playerid, 5.0, MoneyBoxCheckpoint4_X, MoneyBoxCheckpoint4_Y, MoneyBoxCheckpoint4_Z))
    {
        if (GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            if (PlayerInfo[playerid][pADuty] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да вземеш куфара, когато си ADMIN ON Duty!");
            if (onWork[playerid] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да вземеш куфара, когато си на работа !");
            if (cmn1[playerid] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да взмеш куфара, докато си CMN1!");
            SendClientMessage(playerid, 0x40BF00FF, "Moneybox: Сега занеси куфара до другия червен маркер за да спечелиш пари!");
            format(string256, 256, "Moneybox: %s взе куфара с пари. Не му позволявайте да достигне до следващия червен маркер!", GetPlayerNickname(playerid));
            SendClientMessageToAll(0x40BF00FF, string256);
            moneyBoxDPID = random(allMoneyBoxDeliverPoints);
            playerWithMoneyBox[playerid] = true;
            whoHaveMoneyBox = playerid;
            isMoneyBoxGet = true;
            for (new allPlayers; allPlayers < MAX_PLAYERS; allPlayers++)
            {
                if (IsPlayerConnected(allPlayers))
                {
                    GivePlayerMBDeliverPoint(allPlayers);
                }
            }
        }
    }

    if (playerInStreetRace[playerid] == true && streetRaceStarted == true)
    {
        if (streetRaceTypeIndex == 1)
        {
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceSprintCheckPoint1_X, StreetRaceSprintCheckPoint1_Y, StreetRaceSprintCheckPoint1_Z)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceSprintCheckPoint2_X, StreetRaceSprintCheckPoint2_Y, StreetRaceSprintCheckPoint2_Z, StreetRaceSprintCheckPoint3_X, StreetRaceSprintCheckPoint3_Y, StreetRaceSprintCheckPoint3_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceSprintCheckPoint2_X, StreetRaceSprintCheckPoint2_Y, StreetRaceSprintCheckPoint2_Z)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceSprintCheckPoint3_X, StreetRaceSprintCheckPoint3_Y, StreetRaceSprintCheckPoint3_Z, StreetRaceSprintCheckPoint4_X, StreetRaceSprintCheckPoint4_Y, StreetRaceSprintCheckPoint4_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceSprintCheckPoint3_X, StreetRaceSprintCheckPoint3_Y, StreetRaceSprintCheckPoint3_Z)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceSprintCheckPoint4_X, StreetRaceSprintCheckPoint4_Y, StreetRaceSprintCheckPoint4_Z, StreetRaceSprintFinalPoint_X, StreetRaceSprintFinalPoint_Y, StreetRaceSprintFinalPoint_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceSprintCheckPoint4_X, StreetRaceSprintCheckPoint4_Y, StreetRaceSprintCheckPoint4_Z)) SetPlayerRaceCheckpoint(playerid, 1, StreetRaceSprintFinalPoint_X, StreetRaceSprintFinalPoint_Y, StreetRaceSprintFinalPoint_Z, StreetRaceSprintFinalPoint_X, StreetRaceSprintFinalPoint_Y, StreetRaceSprintFinalPoint_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceSprintFinalPoint_X, StreetRaceSprintFinalPoint_Y, StreetRaceSprintFinalPoint_Z))
            {

                PlayerFinishingRace(playerid);

            }
        }
        else if (streetRaceTypeIndex == 2)
        {
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDriftCheckPoint1_X, StreetRaceDriftCheckPoint1_Y, StreetRaceDriftCheckPoint1_Z)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceDriftCheckPoint2_X, StreetRaceDriftCheckPoint2_Y, StreetRaceDriftCheckPoint2_Z, StreetRaceDriftCheckPoint3_X, StreetRaceDriftCheckPoint3_Y, StreetRaceDriftCheckPoint3_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDriftCheckPoint2_X, StreetRaceDriftCheckPoint2_Y, StreetRaceDriftCheckPoint2_Z)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceDriftCheckPoint3_X, StreetRaceDriftCheckPoint3_Y, StreetRaceDriftCheckPoint3_Z, StreetRaceDriftCheckPoint4_X, StreetRaceDriftCheckPoint4_Y, StreetRaceDriftCheckPoint4_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDriftCheckPoint3_X, StreetRaceDriftCheckPoint3_Y, StreetRaceDriftCheckPoint3_Z)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceDriftCheckPoint4_X, StreetRaceDriftCheckPoint4_Y, StreetRaceDriftCheckPoint4_Z, StreetRaceDriftFinalPoint_X, StreetRaceDriftFinalPoint_Y, StreetRaceDriftFinalPoint_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDriftCheckPoint4_X, StreetRaceDriftCheckPoint4_Y, StreetRaceDriftCheckPoint4_Z)) SetPlayerRaceCheckpoint(playerid, 1, StreetRaceDriftFinalPoint_X, StreetRaceDriftFinalPoint_Y, StreetRaceDriftFinalPoint_Z, StreetRaceDriftFinalPoint_X, StreetRaceDriftFinalPoint_Y, StreetRaceDriftFinalPoint_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDriftFinalPoint_X, StreetRaceDriftFinalPoint_Y, StreetRaceDriftFinalPoint_Z))
            {

                PlayerFinishingRace(playerid);

            }
        }
        else if (streetRaceTypeIndex == 3)
        {
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDragCheckPoint1_X, StreetRaceDragCheckPoint1_Y, StreetRaceDragCheckPoint1_Z)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceDragCheckPoint2_X, StreetRaceDragCheckPoint2_Y, StreetRaceDragCheckPoint2_Z, StreetRaceDragCheckPoint3_X, StreetRaceDragCheckPoint3_Y, StreetRaceDragCheckPoint3_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDragCheckPoint2_X, StreetRaceDragCheckPoint2_Y, StreetRaceDragCheckPoint2_Z)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceDragCheckPoint3_X, StreetRaceDragCheckPoint3_Y, StreetRaceDragCheckPoint3_Z, StreetRaceDragCheckPoint4_X, StreetRaceDragCheckPoint4_Y, StreetRaceDragCheckPoint4_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDragCheckPoint3_X, StreetRaceDragCheckPoint3_Y, StreetRaceDragCheckPoint3_Z)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceDragCheckPoint4_X, StreetRaceDragCheckPoint4_Y, StreetRaceDragCheckPoint4_Z, StreetRaceDragFinalPoint_X, StreetRaceDragFinalPoint_Y, StreetRaceDragFinalPoint_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDragCheckPoint4_X, StreetRaceDragCheckPoint4_Y, StreetRaceDragCheckPoint4_Z)) SetPlayerRaceCheckpoint(playerid, 1, StreetRaceDragFinalPoint_X, StreetRaceDragFinalPoint_Y, StreetRaceDragFinalPoint_Z, StreetRaceDragFinalPoint_X, StreetRaceDragFinalPoint_Y, StreetRaceDragFinalPoint_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceDragFinalPoint_X, StreetRaceDragFinalPoint_Y, StreetRaceDragFinalPoint_Z))
            {

                PlayerFinishingRace(playerid);

            }
        }
        else if (streetRaceTypeIndex == 4)
        {
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceLapsCheckPoint1_X, StreetRaceLapsCheckPoint1_Y, StreetRaceLapsCheckPoint1_Z)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceLapsCheckPoint2_X, StreetRaceLapsCheckPoint2_Y, StreetRaceLapsCheckPoint2_Z, StreetRaceLapsCheckPoint3_X, StreetRaceLapsCheckPoint3_Y, StreetRaceLapsCheckPoint3_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceLapsCheckPoint2_X, StreetRaceLapsCheckPoint2_Y, StreetRaceLapsCheckPoint2_Z)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceLapsCheckPoint3_X, StreetRaceLapsCheckPoint3_Y, StreetRaceLapsCheckPoint3_Z, StreetRaceLapsCheckPoint4_X, StreetRaceLapsCheckPoint4_Y, StreetRaceLapsCheckPoint4_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceLapsCheckPoint3_X, StreetRaceLapsCheckPoint3_Y, StreetRaceLapsCheckPoint3_Z)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceLapsCheckPoint4_X, StreetRaceLapsCheckPoint4_Y, StreetRaceLapsCheckPoint4_Z, StreetRaceLapsFinalPoint_X, StreetRaceLapsFinalPoint_Y, StreetRaceLapsFinalPoint_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceLapsCheckPoint4_X, StreetRaceLapsCheckPoint4_Y, StreetRaceLapsCheckPoint4_Z)) SetPlayerRaceCheckpoint(playerid, 1, StreetRaceLapsFinalPoint_X, StreetRaceLapsFinalPoint_Y, StreetRaceLapsFinalPoint_Z, StreetRaceLapsFinalPoint_X, StreetRaceLapsFinalPoint_Y, StreetRaceLapsFinalPoint_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceLapsFinalPoint_X, StreetRaceLapsFinalPoint_Y, StreetRaceLapsFinalPoint_Z))
            {

                PlayerFinishingRace(playerid);

            }
        }
        else if (streetRaceTypeIndex == 5)
        {
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceOffroadCheckPoint1_X, StreetRaceOffroadCheckPoint1_Y, StreetRaceOffroadCheckPoint1_Z)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceOffroadCheckPoint2_X, StreetRaceOffroadCheckPoint2_Y, StreetRaceOffroadCheckPoint2_Z, StreetRaceOffroadCheckPoint3_X, StreetRaceOffroadCheckPoint3_Y, StreetRaceOffroadCheckPoint3_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceOffroadCheckPoint2_X, StreetRaceOffroadCheckPoint2_Y, StreetRaceOffroadCheckPoint2_Z)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceOffroadCheckPoint3_X, StreetRaceOffroadCheckPoint3_Y, StreetRaceOffroadCheckPoint3_Z, StreetRaceOffroadCheckPoint4_X, StreetRaceOffroadCheckPoint4_Y, StreetRaceOffroadCheckPoint4_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceOffroadCheckPoint3_X, StreetRaceOffroadCheckPoint3_Y, StreetRaceOffroadCheckPoint3_Z)) SetPlayerRaceCheckpoint(playerid, 0, StreetRaceOffroadCheckPoint4_X, StreetRaceOffroadCheckPoint4_Y, StreetRaceOffroadCheckPoint4_Z, StreetRaceOffroadFinalPoint_X, StreetRaceOffroadFinalPoint_Y, StreetRaceOffroadFinalPoint_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceOffroadCheckPoint4_X, StreetRaceOffroadCheckPoint4_Y, StreetRaceOffroadCheckPoint4_Z)) SetPlayerRaceCheckpoint(playerid, 1, StreetRaceOffroadFinalPoint_X, StreetRaceOffroadFinalPoint_Y, StreetRaceOffroadFinalPoint_Z, StreetRaceOffroadFinalPoint_X, StreetRaceOffroadFinalPoint_Y, StreetRaceOffroadFinalPoint_Z, 5.0);
            if (IsPlayerInRangeOfPoint(playerid, 5.0, StreetRaceOffroadFinalPoint_X, StreetRaceOffroadFinalPoint_Y, StreetRaceOffroadFinalPoint_Z))
            {

                PlayerFinishingRace(playerid);

            }
        }
    }

    if (IsInStreetRaceStartingPoint(playerid) != -1)
    {
        if (PlayerInfo[playerid][pADuty] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да влезеш в състезанието, когато си ADMIN ON Duty!");
        if (onWork[playerid] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да влезеш в състезанието, когато си на работа !");
        if (!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си в превозно средство за да влезеш в състезанието!");
        if (driver[playerid] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си шофьор за да влезеш в състезанието!");
        if (cmn1[playerid] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да влезеш в състезанието, докато си CMN1!");
        DisablePlayerRaceCheckpoint(playerid);
        new hisVeh = GetPlayerVehicleID(playerid);
        SetPlayerVirtualWorld(playerid, 1);
        SetVehicleVirtualWorld(hisVeh, 1);
        PutPlayerInVehicle(playerid, hisVeh, 0);
        streetRacePlayers += 1;
        playerInStreetRace[playerid] = true;
        streetRacePlayerColorChange[playerid] = 2;
        if (streetRacePlayers == 1)
        {
            format(string256, 256, "StreetRace: %s влезе в състезанието. Трябва още един човек, преди то да започне!", GetPlayerNickname(playerid));
            SendClientMessageToAll(COLOR_STREETRACE, string256);
            if (streetRaceStartTimer > 0) streetRaceStartTimer = 0;
        }
        else if (streetRacePlayers == 2)
        {
            format(string256, 256, "StreetRace: %s влезе в състезанието, то ще започне след 2 минути!", GetPlayerNickname(playerid));
            SendClientMessageToAll(COLOR_STREETRACE, string256);
            streetRaceStartTimer = 2 * 60;
        }
        else if (streetRacePlayers == 10)
        {
            format(string256, 256, "StreetRace: %s влезе в състезанието, то ще започне след 10 секунди!", GetPlayerNickname(playerid));
            SendClientMessageToAll(COLOR_STREETRACE, string256);
            streetRaceStartTimer = 10;
        }
        SendClientMessage(playerid, COLOR_STREETRACE, "StreetRace: За да излезеш от състезанието напиши /leaverace");
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterCheckpoint(playerid)
{
    if (IsPlayerInRangeOfPoint(playerid, 5.0, DeathmatchCheckpoint1_X, DeathmatchCheckpoint1_Y, DeathmatchCheckpoint1_Z) || IsPlayerInRangeOfPoint(playerid, 5.0, DeathmatchCheckpoint2_X, DeathmatchCheckpoint2_Y, DeathmatchCheckpoint2_Z))
    {
        if (GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            if (PlayerInfo[playerid][pADuty] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да влезеш, когато си ADMIN ON Duty!");
            if (onWork[playerid] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "В момента си на раобта и не можеш да влезеш !");
            if (cmn1[playerid] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да влезеш в Deathmatch, докато си CMN1!");
            DisablePlayerCheckpoint(playerid);
            DisablePlayerRaceCheckpoint(playerid);
            playerInDeathmatch[playerid] = true;
            SetPlayerInterior(playerid, 0);
            SetPlayerHealth(playerid, 100);
            SetPlayerArmour(playerid, 0);
            ResetPlayerWeapons(playerid);
            GivePlayerWeapon(playerid, deathmatchGun, 10000);
            SendClientMessage(playerid, COLOR_DEATHMATCH, "Deathmatch: Ти влезе в битката! Не удряй и не стреляй, докато тя не започне!");
            SendClientMessage(playerid, COLOR_DEATHMATCH, "Deathmatch: За да излезеш  от нея напиши /leavedm");
            GetPlayerLastCoors(playerid);
            SetPlayerVirtualWorld(playerid, 1);
            deathmatchPlayers += 1;
            if (deathmatchPlayers == 2)
            {
                deathmatchStartTimer = 120;
                SendClientMessageToAll(COLOR_DEATHMATCH, "Deathmatch: След 120 секунди ще стартира битката, побързайте, които не са дошли!");
            }
            if (deathmatchPlayers < 2)
            {
                deathmatchStartTimer = 0;
            }
            SetPlayerPosToDeathmatchSpawn(playerid);
        }
    }


    if (IsPlayerInRangeOfPoint(playerid, 5.0, MoneyBoxDeliverpoint1_X, MoneyBoxDeliverpoint1_Y, MoneyBoxDeliverpoint1_Z) || IsPlayerInRangeOfPoint(playerid, 5.0, MoneyBoxDeliverpoint2_X, MoneyBoxDeliverpoint2_Y, MoneyBoxDeliverpoint2_Z) ||
            IsPlayerInRangeOfPoint(playerid, 5.0, MoneyBoxDeliverpoint3_X, MoneyBoxDeliverpoint3_Y, MoneyBoxDeliverpoint3_Z) || IsPlayerInRangeOfPoint(playerid, 5.0, MoneyBoxDeliverpoint4_X, MoneyBoxDeliverpoint4_Y, MoneyBoxDeliverpoint4_Z))
    {
        //goto
        if (GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            GivePlayerCMN1Status(playerid);
            cmn1Mission[playerid] = MISSION_MONEYBOX;
            new stringmoneybox[115];
            format(stringmoneybox, 115, "~w~YOU WON:~n~~g~$%d", cmn1Money);
            GameTextForPlayer(playerid, stringmoneybox, 3000, 3);
            format(stringmoneybox, 115, "Moneybox: %s успешно занесе куфара и спечели $%d", GetPlayerNickname(playerid), cmn1Money);
            SendClientMessageToAll(0x40BF00FF, stringmoneybox);
            GivePlayerWantedLevel(playerid, 1, "Грабеж на пари");
            format(stringmoneybox, 115, "CMN1: %s е заподозрян в грабеж,убий го и ще получиш CMN1 Kill.", GetPlayerNickname(playerid));
            SendClientMessageToAll(0xF97804FF, stringmoneybox);
            SendClientMessage(playerid, 0xF97804FF, "CMN1: Трябва да оцелееш 5 минути за да не си преследван повече.");
            playerWithMoneyBox[playerid] = false;
            missionActive = MISSION_NONE;
            for (new i; i < MAX_PLAYERS; i++)
            {
                if (onWork[i] == 0 && gpsOn[i] == false)
                {
                    DisablePlayerCheckpoint(i);
                }
            }
            isMoneyBoxGet = false;
            whoHaveMoneyBox = -1;
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

stock IsPlayerInDeathmatchMission(playerid)
{
    if (playerInDeathmatch[playerid] == true)
    {
        return true;
    }
    return false;
}

stock SpawnInDeathmatchMission(playerid)
{
    DisablePlayerCheckpoint(playerid);
    DisablePlayerRaceCheckpoint(playerid);
    SetPlayerVirtualWorld(playerid, 1);
    SetPlayerInterior(playerid, 0);
    SetPlayerHealth(playerid, 100);
    SetPlayerArmour(playerid, 0);
    ResetPlayerWeapons(playerid);
    GivePlayerWeapon(playerid, deathmatchGun, 10000);
    SetPlayerPosToDeathmatchSpawn(playerid);
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    if (playerInStreetRace[playerid] == true)
    {
        LeaveStreetRace(playerid);
    }
    if (playerInDeathmatch[killerid] == true && playerInDeathmatch[playerid] == true)
    {
        if (deathmatchStarted == true)
        {
            deathmatchKills[killerid] += 1;
            format(string256, 256, "%d", deathmatchKills[killerid]);
            GameTextForPlayer(killerid, string256, 1000, 1);
        }
    }
    KilledWithMoneyBox(playerid);
    KilledWithCMN1(killerid, playerid);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

stock SetPlayerPosToDeathmatchSpawn(playerid)
{
    if (deathmatchFightArea == 1)
    {
        new randomSpawn = randomex(1, 3);
        if (randomSpawn == 1)
        {
            SetPlayerPos(playerid, DeathmatchPlace1Spawn1_X, DeathmatchPlace1Spawn1_Y, DeathmatchPlace1Spawn1_Z);
        }
        else if (randomSpawn == 2)
        {
            SetPlayerPos(playerid, DeathmatchPlace1Spawn2_X, DeathmatchPlace1Spawn2_Y, DeathmatchPlace1Spawn2_Z);
        }
        else if (randomSpawn == 3)
        {
            SetPlayerPos(playerid, DeathmatchPlace1Spawn3_X, DeathmatchPlace1Spawn3_Y, DeathmatchPlace1Spawn3_Z);
        }
    }
    else if (deathmatchFightArea == 2)
    {
        new randomSpawn = randomex(1, 3);
        if (randomSpawn == 1)
        {
            SetPlayerPos(playerid, DeathmatchPlace2Spawn1_X, DeathmatchPlace2Spawn1_Y, DeathmatchPlace2Spawn1_Z);
        }
        else if (randomSpawn == 2)
        {
            SetPlayerPos(playerid, DeathmatchPlace2Spawn2_X, DeathmatchPlace2Spawn2_Y, DeathmatchPlace2Spawn2_Z);
        }
        else if (randomSpawn == 3)
        {
            SetPlayerPos(playerid, DeathmatchPlace2Spawn3_X, DeathmatchPlace2Spawn3_Y, DeathmatchPlace2Spawn3_Z);
        }
    }
}
stock HandleMoneyBoxDrop(playerid)
{
    if (!isMoneyBoxGet) return;
    if (!playerWithMoneyBox[playerid]) return;

    new msg[256];
    format(msg, sizeof(msg), "Moneybox: %s изпусна куфара с пари. Отиди до червения маркер и го вземи!", GetPlayerNickname(playerid));
    SendClientMessageToAll(0x40BF00FF, msg);

    lostMoneyBox = true;
    playerWithMoneyBox[playerid] = false;
    whoHaveMoneyBox = -1;
    GetPlayerPos(playerid, LX, LY, LZ);

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && onWork[i] == 0 && gpsOn[i] == false)
        {
            SetPlayerCheckpoint(i, LX, LY, LZ, 5.0);
        }
    }
}