#include <YSI_Coding\y_hooks>

/*
* Stats
*/
stock ResetPlayerStats(playerid)
{
    PlayerInfo[playerid][pRobberLead] = 0;
    PlayerInfo[playerid][pRobber] = 0;
    PlayerInfo[playerid][pBan] = 0;
    PlayerInfo[playerid][pBlock] = 0;
    PlayerInfo[playerid][pKick] = 0;
    PlayerInfo[playerid][pRefuel20LitTimer] = 0;
    PlayerInfo[playerid][pFixT] = 0;
    PlayerInfo[playerid][pHealT] = 0;
    PlayerInfo[playerid][pFuel] = 0;
    PlayerInfo[playerid][pTogFaction] = 0;
    PlayerInfo[playerid][pTogLeader] = 0;
    PlayerInfo[playerid][pStartIntro] = 0;
    PlayerInfo[playerid][pReSpawn] = 0;
    PlayerInfo[playerid][pIntro] = 0;
    PlayerInfo[playerid][pIntro1] = 0;
    PlayerInfo[playerid][pIntro2] = 0;
    PlayerInfo[playerid][pIFCDuty] = 0;
    PlayerInfo[playerid][pIntro3] = 0;
    PlayerInfo[playerid][pRefuelTankIFC] = 0;
    PlayerInfo[playerid][pIntro4] = 0;
    PlayerInfo[playerid][pIntro5] = 0;
    PlayerInfo[playerid][pIntro6] = 0;
    PlayerInfo[playerid][pTogCB] = 0;
    PlayerInfo[playerid][pRegistred] = 0;
    PlayerInfo[playerid][pAdmin] = 0;
    PlayerInfo[playerid][pADMINMute] = 0;
    PlayerInfo[playerid][pReadTA] = 0;
    PlayerInfo[playerid][pArmour2] = 0;
    PlayerInfo[playerid][pHealth2] = 0;
    PlayerInfo[playerid][pHookT] = 0;
    PlayerInfo[playerid][pKasaLV] = 0;
    PlayerInfo[playerid][pMoonshineEffectTime] = 0;
    PlayerInfo[playerid][pRadio] = 0;
    PlayerInfo[playerid][pDice] = 0;
    PlayerInfo[playerid][pReactionTestsWon] = 0;
    PlayerInfo[playerid][pCigarettes] = 0;
    PlayerInfo[playerid][pBriefcase] = 0;
    PlayerInfo[playerid][pChantichki] = 0;
    PlayerInfo[playerid][pDMONKills2] = 0;
    PlayerInfo[playerid][pIPDDuty] = 0;
    PlayerInfo[playerid][pFuelcase] = -1;
    PlayerInfo[playerid][pBizEP] = 0;
    PlayerInfo[playerid][pBizCash] = 0;
    PlayerInfo[playerid][pJob] = 0;
    PlayerInfo[playerid][pNone] = 0;
    PlayerInfo[playerid][pNo] = 0;
    PlayerInfo[playerid][pStruv] = 0;

    for (new i; i < MAX_CAUGHTFISHES; i++)
    {
        PlayerInfo[playerid][pFishslot][i] = 0;
    }
    for (new i; i < MAX_CAUGHTFISHES; i++)
    {
        PlayerInfo[playerid][pFishSlotWeight][i] = 0;
    }
    for (new i; i < 9; i++)
    {
        PlayerInfo[playerid][pClothes][i] = 0;
    }
    for (new i = 1; i < MAX_PRIVATEVEHS; i++)
    {
        PlayerInfo[playerid][pPrivateVeh][i] = 0;
    }
    PlayerInfo[playerid][pYes] = 0;
    PlayerInfo[playerid][pPizzaTimerWorkAgain] = 0;
    PlayerInfo[playerid][pBoatTimerWorkAgain] = 0;
    PlayerInfo[playerid][pOrganisator] = 0;
    PlayerInfo[playerid][pCoalmineTimerWorkAgain] = 0;
    PlayerInfo[playerid][pSweeperTimerWorkAgain] = 0;
    PlayerInfo[playerid][pPilotTimerWorkAgain] = 0;
    PlayerInfo[playerid][pDeliverTimerWorkAgain] = 0;
    PlayerInfo[playerid][pBusTimerWorkAgain] = 0;
    PlayerInfo[playerid][pTruckTimerWorkAgain] = 0;
    PlayerInfo[playerid][pOffice] = 0;
    PlayerInfo[playerid][pCMN1] = 0;
    PlayerInfo[playerid][pStreetRaceSuccess] = 0;
    PlayerInfo[playerid][pMoneyboxSuccess] = 0;
    PlayerInfo[playerid][pAdvertTime] = 0;
    PlayerInfo[playerid][pIFC] = 0;
    PlayerInfo[playerid][pSpecialForce] = 0;
    PlayerInfo[playerid][pDeltaForce] = 0;
    PlayerInfo[playerid][pHelperLeader] = 0;
    PlayerInfo[playerid][pEvent] = 0;
    PlayerInfo[playerid][pManage] = 0;
    PlayerInfo[playerid][pRNMute] = 0;
    PlayerInfo[playerid][pAWarns] = 0;
    PlayerInfo[playerid][pLodka] = 0;
    PlayerInfo[playerid][pVlak] = 0;
    PlayerInfo[playerid][pSamolet] = 0;
    PlayerInfo[playerid][pHelikopter] = 0;
    PlayerInfo[playerid][pDeathmatchSuccess] = 0;
    PlayerInfo[playerid][pADuty] = 0;
    PlayerInfo[playerid][pMoonshine] = 0;
    PlayerInfo[playerid][pMoonshine1] = 0;
    PlayerInfo[playerid][pWeed1] = 0;
    PlayerInfo[playerid][pHeroin1] = 0;
    PlayerInfo[playerid][pCocaine1] = 0;
    PlayerInfo[playerid][pWeed] = 0;
    PlayerInfo[playerid][pCocaine] = 0;
    PlayerInfo[playerid][pDMONKills] = 0;
    PlayerInfo[playerid][pHeroin] = 0;
    PlayerInfo[playerid][pHook] = 0;
    PlayerInfo[playerid][pStyle] = 0;
    PlayerInfo[playerid][pGLeader] = 0;
    PlayerInfo[playerid][pASkin] = 0;
    PlayerInfo[playerid][pParrot] = 0;
    PlayerInfo[playerid][pTest] = 0;
    PlayerInfo[playerid][pVip] = 0;
    PlayerInfo[playerid][pPlayerRefuelTimer] = 0;
    PlayerInfo[playerid][pVIPLabel] = 0;
    PlayerInfo[playerid][pWarns] = 0;
    PlayerInfo[playerid][pTGoto] = 0;
    PlayerInfo[playerid][pTSpec] = 0;
    PlayerInfo[playerid][pTimeJail] = 0;
    PlayerInfo[playerid][pTimeMute] = 0;
    PlayerInfo[playerid][pTeam] = 0;
    PlayerInfo[playerid][pRank] = 1;
    PlayerInfo[playerid][pLevel] = 0;
    PlayerInfo[playerid][pEP] = 0;
    PlayerInfo[playerid][pEPS] = 0;
    PlayerInfo[playerid][pMS] = 0;
    PlayerInfo[playerid][pCash] = 0;
    PlayerInfo[playerid][pBSpec] = 0;
    PlayerInfo[playerid][pJail] = 0;
    PlayerInfo[playerid][pComingBan] = 0;
    PlayerInfo[playerid][pLastPayday] = 0;
    PlayerInfo[playerid][pAHide] = 0;
    PlayerInfo[playerid][pWeaponS] = 0;
    PlayerInfo[playerid][pHouseO] = -1;
    PlayerInfo[playerid][pSpawnO] = 0;
    PlayerInfo[playerid][pBizO] = -1;
    PlayerInfo[playerid][pMuted] = 0;
    PlayerInfo[playerid][pKills] = 0;
    PlayerInfo[playerid][pDeaths] = 0;
    PlayerInfo[playerid][pJailReason] = 0;
    PlayerInfo[playerid][pMuteReason] = 0;
    PlayerInfo[playerid][pLMuted] = 0;
    PlayerInfo[playerid][pAMuted] = 0;
    PlayerInfo[playerid][pFMuted] = 0;
    PlayerInfo[playerid][pFWarns] = 0;
    PlayerInfo[playerid][pYear] = 0;
    PlayerInfo[playerid][pMonth] = 0;
    PlayerInfo[playerid][pDay] = 0;
    PlayerInfo[playerid][pHours] = 0;
    PlayerInfo[playerid][pMinutes] = 0;
    PlayerInfo[playerid][pSeconds] = 0;
    PlayerInfo[playerid][pAFK] = 0;
    PlayerInfo[playerid][pActiveCheck] = 0;
    PlayerInfo[playerid][pAccount] = 0;
    PlayerInfo[playerid][pLaser] = 0;
    PlayerInfo[playerid][pWanted] = 0;
    PlayerInfo[playerid][pGSM] = 0;
    PlayerInfo[playerid][pPJail] = 0;
    PlayerInfo[playerid][pTogPM] = 0;
    PlayerInfo[playerid][pIgnorePM] = 0;
    PlayerInfo[playerid][pRefuelCan] = 0;
    PlayerInfo[playerid][pRefuelTube] = 0;
    PlayerInfo[playerid][pInfiniteNos] = 0;
    PlayerInfo[playerid][pLastPM] = -1;
    format(adminprefix[playerid], 35, "");
    format(adminprefix[playerid], 35, "");
    format(VipText3D[playerid], 26, "");
    format(viptextformat[playerid], 35, "");
    format(stringvehicle[playerid], 115, "");
    logged[playerid] = 0;
    streetRacePlayerColorChange[playerid] = 0;
    playerInDeathmatch[playerid] = false;
    playerJoinMinigameTimer[playerid] = 0;
    attachedviptext[playerid] = 0;
    oldvehid[playerid] = -1;
    isDerbyPlayer[playerid] = false;
    playerAfkSeconds[playerid] = 0;
    playerAfkMinutes[playerid] = 0;
    AFKDetect[playerid] = 0;
    rezachka[playerid] = 0;
    gLastUpdate[playerid] = GetTickCount();
    spawned[playerid] = 0;
    zaplatakinti[playerid] = 0;
    deathmatchKills[playerid] = 0;
    gpsOn[playerid] = false;
    playerInDuel[playerid] = 0;
    InTuneGarage[playerid] = false;
    playerInDMON[playerid] = 0;
    hidename[playerid] = 0;
    adutyskinchanged[playerid] = 0;
    ifcFuelTextOn[playerid] = false;
    lastpaydaykinti[playerid] = 0;
    firstskin[playerid] = 29;
    logged[playerid] = 0;
    playerInStreetRace[playerid] = false;
    lastkey[playerid] = -1;
    oldkey[playerid] = -1;
    radioff[playerid] = 0;
    cmn1[playerid] = 0;
    cbchat[playerid] = 0;
    replyPm[playerid] = false;
    santaHat[playerid] = false;
    enabledramp[playerid] = 0;
    nospam2[playerid] = 0;
    godmode[playerid] = 0;
    loadedClothes[playerid] = false;
    playerWithMoneyBox[playerid] = false;
    selectedTmpClothID[playerid] = 0;
    WhatCar[playerid] = 0;
    g_bump[playerid] = false;
    g_veh[playerid] = -1;
    acuffed[playerid] = 0;
    scripterMode[playerid] = 0;
    specing[playerid] = 0;
    onWork[playerid] = 0;
    radion[playerid] = 0;
    duelsender[playerid] = -1;
    rampobject[playerid] = -1;
    houseSwitchSender[playerid] = -1;
    houseSwitchReceiver[playerid] = -1;
    bizSwitchSender[playerid] = -1;
    bizSwitchReceiver[playerid] = -1;
    bizSwitching[playerid] = false;
    houseSwitching[playerid] = false;
    houseSelling[playerid] = false;
    AntiFallOfBike[playerid] = 0;
    duelsend[playerid] = -1;
    refuelcisterna[playerid] = 0;
    enteredbiz[playerid] = 0;
    enteredhouse[playerid] = 0;
    hitmanby[playerid] = -1;
    hitmanprice[playerid] = 0;
    refuelcan[playerid] = 0;
    nameon[playerid] = 1;
    introon[playerid] = 0;
    inevent[playerid] = 0;
    firstspawn[playerid] = 1;
    pDrunkLevelLast[playerid] = 0;
    timec[playerid] = 0;
    sitec[playerid] = 0;
    pFPS[playerid] = 30;
    onhousepick2[playerid] = 0;
    fly[playerid] = 0;
    Speed[playerid] = 0;
    kmh[playerid] = 0;
    Jump[playerid] = 0;
    duelzalog[playerid] = 0;
    afterjobcheckpoint[playerid] = 0;
    hideexitserver[playerid] = 0;
    driver[playerid] = 0;
    requestspawn2[playerid] = 0;
    playerInDMON[playerid] = 0;
    playerInDuel[playerid] = 0;
    hitmaner[playerid] = -1;
    marked[playerid] = 0;
    togchat[playerid] = 0;
    isinhousepickup[playerid] = 0;
    passenger[playerid] = false;
    nospawnselect[playerid] = 0;
    streetRaceSecondsCounter[playerid] = 0;
    BigEar[playerid] = 0;
    requestspawn[playerid] = 0;
    speedo[playerid] = 0;
    //active[playerid]=0;
    lottonumber[playerid] = 0;
    X[playerid] = 0.0;
    Y[playerid] = 0.0;
    Z[playerid] = 0.0;
    AX[playerid] = 0.0;
    AY[playerid] = 0.0;
    AZ[playerid] = 0.0;
    AZA[playerid] = 0.0;
    AINT[playerid] = 0;
    AVW[playerid] = 0;
    para1[playerid] = -1;
    spawnselectedskin[playerid] = 0;
    commandspam[playerid] = 0;
    textspam[playerid] = 0;
    wrongpassword[playerid] = 0;
    loadedtexts[playerid] = 0;
    TeamInvite[playerid] = -1;
    GotoInvite[playerid] = -1;
    GotoInviteAccepted[playerid] = false;
    loadedtext[playerid] = 0;
    attachedviptext[playerid] = 0;
    spec[playerid] = 0;
    houseSellSender[playerid] = -1;
    houseSellReceiver[playerid] = -1;
    houseSwitchSender[playerid] = -1;
    houseSwitchReceiver[playerid] = -1;
    objectright[playerid] = 0;
    vehhealth[playerid] = 0.0;
    lastCriminalDrug[playerid] = gettime() - 1201;
    lastCriminalPoliceCar[playerid] = gettime() - 1201;
    lastADuty[playerid] = gettime() - 1201;
    lastCriminalPoliceUser[playerid] = gettime() - 1201;
    for (new allids; allids < MAX_PLAYERS; allids++)
    {
        ignore[allids][playerid] = -1;
        fignore[allids][playerid] = -1;
    }
    format(VipText3D[playerid], 26, "");
    UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, " ");
    gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gCurrentPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    for (new x = 0; x < SELECTION_ITEMS; x++) gSelectionItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
    gItemAt[playerid] = 0;
    //reststats - location - close
    //resttexts - location - open
    TextDrawHideForPlayer(playerid, Intro[0]);
    TextDrawHideForPlayer(playerid, Intro[1]);
    TextDrawHideForPlayer(playerid, Intro[2]);
    TextDrawHideForPlayer(playerid, Intro[3]);
    TextDrawHideForPlayer(playerid, Intro[4]);
    TextDrawHideForPlayer(playerid, Intro[5]);
    TextDrawHideForPlayer(playerid, epText[playerid]);
    TextDrawHideForPlayer(playerid, levelText[playerid]);
    TextDrawHideForPlayer(playerid, epsText[playerid]);
    TextDrawHideForPlayer(playerid, msText[playerid]);
    //resttexts - location - close
    //resttimers - location - openp
    PlayerInfo[playerid][pFuel] = 0;
    PlayerInfo[playerid][pDuelCountTimer] = 0;
    PlayerInfo[playerid][pDuelCountTimer2] = 0;
    PlayerInfo[playerid][pDuelCountTimer3] = 0;
    PlayerInfo[playerid][pDuelCountTimer4] = 0;
    PlayerInfo[playerid][pKick] = 0;
    PlayerInfo[playerid][pFixT] = 0;
    PlayerInfo[playerid][pHealT] = 0;
    PlayerInfo[playerid][pHideDMONKillText] = 0;
    PlayerInfo[playerid][pVGuns] = 0;
    PlayerInfo[playerid][pRefuel20LitTimer] = 0;
    PlayerInfo[playerid][pInfiniteNosTimer] = 0;
    PlayerInfo[playerid][pBankSpawn] = 0;
    PlayerInfo[playerid][pStartIntro] = 0;
    PlayerInfo[playerid][pIntro] = 0;
    PlayerInfo[playerid][pIntro1] = 0;
    PlayerInfo[playerid][pIntro2] = 0;
    PlayerInfo[playerid][pIntro3] = 0;
    PlayerInfo[playerid][pIntro4] = 0;
    PlayerInfo[playerid][pIntro5] = 0;
    PlayerInfo[playerid][pIntro6] = 0;
    PlayerInfo[playerid][pAfterWork] = 0;
    PlayerInfo[playerid][pCmn1Timer] = 0;
}

/*
* Color and Skins
*/

stock RestartPlayerSkin(playerid)
{
    new hisTeam = PlayerInfo[playerid][pTeam];
    if (hisTeam == 1 && PlayerInfo[playerid][pRank] == 1)
    {
        if (firstskin[playerid] == 1) SetPlayerSkin(playerid, 28);
        if (firstskin[playerid] == 2) SetPlayerSkin(playerid, 29);
        if (firstskin[playerid] == 3) SetPlayerSkin(playerid, 30);
        if (firstskin[playerid] == 4) SetPlayerSkin(playerid, 143);
        if (firstskin[playerid] == 5) SetPlayerSkin(playerid, 144);
        if (firstskin[playerid] == 6) SetPlayerSkin(playerid, 145);
        if (firstskin[playerid] == 7) SetPlayerSkin(playerid, 146);
        if (firstskin[playerid] == 8) SetPlayerSkin(playerid, 101);
        if (firstskin[playerid] == 9) SetPlayerSkin(playerid, 98);
        if (firstskin[playerid] == 10) SetPlayerSkin(playerid, 60);
        if (firstskin[playerid] == 11) SetPlayerSkin(playerid, 59);
        if (firstskin[playerid] == 12) SetPlayerSkin(playerid, 55);
        if (firstskin[playerid] == 13) SetPlayerSkin(playerid, 56);
        if (firstskin[playerid] == 14) SetPlayerSkin(playerid, 17);
        if (firstskin[playerid] == 15) SetPlayerSkin(playerid, 141);
        if (firstskin[playerid] == 16) SetPlayerSkin(playerid, 237);
        if (firstskin[playerid] == 17) SetPlayerSkin(playerid, 244);
        if (firstskin[playerid] == 18) SetPlayerSkin(playerid, 246);
        if (firstskin[playerid] == 19) SetPlayerSkin(playerid, 93);
        if (firstskin[playerid] == 20) SetPlayerSkin(playerid, 91);
        if (firstskin[playerid] == 21) SetPlayerSkin(playerid, 90);
    }
    SetPlayerSkin(playerid, gangRankSkin[PlayerInfo[playerid][pTeam]][PlayerInfo[playerid][pRank]]);
    if (PlayerInfo[playerid][pTeam] == FACTION_INTENSE_POLICE && PlayerInfo[playerid][pIPDDuty] == 0)
    {
        SetPlayerSkin(playerid, 303);
    }
    if (PlayerInfo[playerid][pTeam] == FACTION_INTENSE_POLICE && PlayerInfo[playerid][pIPDDuty] == 1)
    {
        if (PlayerInfo[playerid][pRank] == 1) SetPlayerSkin(playerid, 280);
        if (PlayerInfo[playerid][pRank] == 2) SetPlayerSkin(playerid, 281);
        if (PlayerInfo[playerid][pRank] == 3) SetPlayerSkin(playerid, 282);
        if (PlayerInfo[playerid][pRank] == 4) SetPlayerSkin(playerid, 284);
        if (PlayerInfo[playerid][pRank] == 5) SetPlayerSkin(playerid, 283);
        if (PlayerInfo[playerid][pRank] == 6) SetPlayerSkin(playerid, 288);
        if (PlayerInfo[playerid][pSpecialForce]) SetPlayerSkin(playerid, 285);
        if (PlayerInfo[playerid][pDeltaForce]) SetPlayerSkin(playerid, 287);
    }
    if (helperLeaderGangRankSkin[hisTeam] != 0 && PlayerInfo[playerid][pHelperLeader] == 1)
    {
        SetPlayerSkin(playerid, helperLeaderGangRankSkin[hisTeam]);
    }
}
stock RestartPlayerColor(playerid)
{
    if (PlayerInfo[playerid][pADuty] == 0) // &&  playerInDuel[playerid]==0 && cmn1[playerid]==0 && PlayerInfo[playerid][pAFK]==0 && playerInStreetRace[playerid]==false
    {
        if (PlayerInfo[playerid][pInvisible] == 0)
        {
            SetPlayerColor(playerid, TeamInfo[PlayerInfo[playerid][pTeam]][tRCOLOR]);
            if (PlayerInfo[playerid][pTeam] == FACTION_CIVILIAN)
            {
                SetPlayerColor(playerid, 0xFFFFFFFF);
            }
        }
        else
        {
            SetPlayerColor(playerid, 0xFFFFFF00);
        }
    }

    if (IsPlayerInHidenTeam(playerid))
    {
        SetPlayerColor(playerid, 0xFFFFFF00);
    }
}

/*
* VIP
*/
stock RestartVIPLaser(playerid)
{
    new level = PlayerInfo[playerid][pTeam];
    if (PlayerInfo[playerid][pLaser] == 1)
    {
        if (PlayerInfo[playerid][pVip] > 3 || CheckFreeVIP() == 1)
        {
            SetPVarInt(playerid, "color", 0);
            if (PlayerInfo[playerid][pTeam] == FACTION_VIP)
            {
                SetPVarInt(playerid, "color", 18643);
            }
            if (PlayerInfo[playerid][pTeam] == FACTION_GROVE)
            {
                SetPVarInt(playerid, "color", 19083);
            }
            if (PlayerInfo[playerid][pTeam] == FACTION_RIFA)
            {
                PlayerInfo[playerid][pLaser] = 1;
                SetPVarInt(playerid, "color", 19080);
            }
            if (PlayerInfo[playerid][pTeam] == FACTION_INTENSE_POLICE)
            {
                SetPVarInt(playerid, "color", 19080);
            }
        }
    }
}

/*
* AFK
*/
stock IsPlayerPaused(playerid)
{
    if (playerAfkSeconds[playerid] >= 1 && spawned[playerid] == 1)
    {
        return true;
    }
    return false;
}

stock GivePlayerAfkTimerSecond(playerid)
{
    if (IsPlayerConnected(playerid))
    {
        if (spawned[playerid])
        {
            playerAfkSeconds[playerid] += 1;
            if (playerAfkSeconds[playerid] == 60)
            {
                playerAfkMinutes[playerid] += 1;
                playerAfkSeconds[playerid] = 0;
            }
        }
    }
}

/*
* Positions
*/
stock bool:GetPosInFrontOfPoint(& Float:OutputX, & Float:OutputY, Float:Angle, Float:Distance)
{
    if (!Distance) return false;
    OutputX += floatmul(Distance, floatsin(-Angle, degrees));
    OutputY += floatmul(Distance, floatcos(-Angle, degrees));
    return true;
}

/*
* Vehicles
*/
stock IsPlayerInRangeOfVehicle(playerid, vehicleid, Float:Range)
{
    new Float:Pos[3];
    GetVehiclePos(vehicleid, Pos[0], Pos[1], Pos[2]);
    return IsPlayerInRangeOfPoint(playerid, Range, Pos[0], Pos[1], Pos[2]);
}

/*
* Weapons
*/
stock RemovePlayerWeapon(playerid, weaponid)
{
    new plyWeapons[12];
    new plyAmmo[12];
    for (new slot = 0; slot != 12; slot++)
    {
        new wep, ammo;
        GetPlayerWeaponData(playerid, slot, wep, ammo);
        if (wep != weaponid)
        {
            GetPlayerWeaponData(playerid, slot, plyWeapons[slot], plyAmmo[slot]);
        }
    }
    ResetPlayerWeapons(playerid);
    for (new slot = 0; slot != 12; slot++)
    {
        GivePlayerWeapon(playerid, plyWeapons[slot], plyAmmo[slot]);
    }
}

/*
* Nickname
*/
stock GetPlayerNickname(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}

/*
* Ban
*/
public BanExPublic(playerid, reason[])
{
    hideexitserver[playerid] = 1;
    PlayerInfo[playerid][pBan] = 0;
    PlayerInfo[playerid][pBlock] = 1;
    BanEx(playerid, reason);
}


/*
* Player Texts
*/
stock LoadPlayerTexts(playerid)
{
    levelText[playerid] = TextDrawCreate(457.000000, 1.000000, "");
    TextDrawAlignment(levelText[playerid], 0);
    TextDrawBackgroundColor(levelText[playerid], 0x000000ff);
    TextDrawFont(levelText[playerid], 3);
    TextDrawLetterSize(levelText[playerid], 0.2800, 1.4000);
    TextDrawSetProportional(levelText[playerid], 1);
    TextDrawSetShadow(levelText[playerid], 1);

    epText[playerid] = TextDrawCreate(522.000000, 1.000000, "");
    TextDrawAlignment(epText[playerid], 0);
    TextDrawBackgroundColor(epText[playerid], 0x000000ff);
    TextDrawFont(epText[playerid], 3);
    TextDrawLetterSize(epText[playerid], 0.2800, 1.4000);
    TextDrawSetProportional(epText[playerid], 1);
    TextDrawSetShadow(epText[playerid], 1);

    epsText[playerid] = TextDrawCreate(457.000000, 11.000000, "");
    TextDrawAlignment(epsText[playerid], 0);
    TextDrawBackgroundColor(epsText[playerid], 0x000000ff);
    TextDrawFont(epsText[playerid], 3);
    TextDrawLetterSize(epsText[playerid], 0.2800, 1.4000);
    TextDrawSetProportional(epsText[playerid], 1);
    TextDrawSetShadow(epsText[playerid], 1);

    msText[playerid] = TextDrawCreate(522.000000, 11.000000, "");
    TextDrawAlignment(msText[playerid], 0);
    TextDrawBackgroundColor(msText[playerid], 0x000000ff);
    TextDrawFont(msText[playerid], 3);
    TextDrawLetterSize(msText[playerid], 0.2800, 1.4000);
    TextDrawSetProportional(msText[playerid], 1);
    TextDrawSetShadow(msText[playerid], 1);

    ifcFuelText[playerid] = TextDrawCreate(510.5190, 363.0, "~n~~n~~n~~y~PT: 0L"); //369
    TextDrawBackgroundColor(ifcFuelText[playerid], 250);
    TextDrawFont(ifcFuelText[playerid], 1);
    TextDrawLetterSize(ifcFuelText[playerid], 0.4099, 1.5000);
    TextDrawColor(ifcFuelText[playerid], -1);
    TextDrawSetOutline(ifcFuelText[playerid], 1);
    TextDrawSetProportional(ifcFuelText[playerid], 1);


    vehstatus[playerid] = TextDrawCreate(510.5190, 363.0, ""); //369
    TextDrawBackgroundColor(vehstatus[playerid], 250);
    TextDrawFont(vehstatus[playerid], 1);
    TextDrawLetterSize(vehstatus[playerid], 0.3900, 1.4700);
    TextDrawColor(vehstatus[playerid], -1);
    TextDrawSetOutline(vehstatus[playerid], 1);
    TextDrawSetProportional(vehstatus[playerid], 1);
}

/*
* Updates player text on head
*/

stock UpdatePlayerHeadText(playerid)
{
    DestroyDynamic3DTextLabel(PlayerLabel[playerid]);
    PlayerLabel[playerid] = CreateDynamic3DTextLabel("", 0x800000FF, 0.0, 0.0, 0.0, 15.0, playerid, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 15.0);

    UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, VipText3D[playerid]);
    if (PlayerInfo[playerid][pADuty])
    {
        UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0xE60000FF, "ADMIN ON-DUTY");
    }
    if (PlayerInfo[playerid][pWanted] >= 1 && !PlayerInfo[playerid][pADuty])
    {
        new stringSuspect[128];
        format(stringSuspect, 128, "SUSPECTED {ff0000}[%d]", PlayerInfo[playerid][pWanted]);

        UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_IPD_CHAT, stringSuspect);
    }
}


/*
* Player Coordinates
*/
stock SetPlayerToLastCoors(playerid)
{
    SetPlayerPos(playerid, LastCoor[playerid][sPx], LastCoor[playerid][sPy], LastCoor[playerid][sPz]);
    SetPlayerFacingAngle(playerid, LastCoor[playerid][sAngle]);
    SetPlayerInterior(playerid, LastCoor[playerid][sPint]);
    SetPlayerVirtualWorld(playerid, LastCoor[playerid][sVw]);
}
stock GetPlayerLastCoors(playerid)
{
    GetPlayerPos(playerid, LastCoor[playerid][sPx], LastCoor[playerid][sPy], LastCoor[playerid][sPz]);
    LastCoor[playerid][sPint] = GetPlayerInterior(playerid);
    LastCoor[playerid][sVw] = GetPlayerVirtualWorld(playerid);
    GetPlayerFacingAngle(playerid, LastCoor[playerid][sAngle]);
}

/*
* Suspect
*/
stock SetSuspectStars(playerid)
{
    if (PlayerInfo[playerid][pWanted] >= 7)
    {
        PlayerInfo[playerid][pWanted] = 6;
    }
    SetPlayerWantedLevel(playerid, PlayerInfo[playerid][pWanted]);
}

stock GivePlayerWantedLevel(playerid, level, const reason[], hide = false)
{
    PlayerInfo[playerid][pWanted] += level;
    if (PlayerInfo[playerid][pWanted] >= 6)
    {
        PlayerInfo[playerid][pWanted] = 6;
    }
    SetPlayerWantedLevel(playerid, PlayerInfo[playerid][pWanted]);
    UpdatePlayerHeadText(playerid);

    format(string256, 256, "[SUSPECT]{0040FF} Ти си заподозрян в престъпление: %s, ниво на издирване: %d", reason, PlayerInfo[playerid][pWanted]);
    SendClientMessage(playerid, 0xFF0000ff, string256);

    if (!hide)
    {
        format(string256, 256, "[MDC] {FF0000}%s{0040FF} е издирван с ниво: %d. Нарушение: %s", GetPlayerNickname(playerid), PlayerInfo[playerid][pWanted], reason);
        SendFactionMessage(FACTION_INTENSE_POLICE, 0x0040FFff, string256);
    }
}

stock CaughtedWanted(playerid, killerid)
{
    new stringpolice[256];
    format(stringpolice, 256, "[WASTED] {0040FF}Ти беше заловен от полицай %s, защото си извършил престъпление!", GetPlayerNickname(killerid));
    SendClientMessage(playerid, 0xFF0000FF, stringpolice);
    if (PlayerInfo[playerid][pADuty] == 0)
    {
        PlayerInfo[playerid][pPJail] = 1 * 60;
        SendClientMessage(playerid, 0xFF0000FF, "[WASTED] {0040FF} Сега ще си в затвора за 1 минути и губиш $900!");
        GivePlayerCash(killerid, 900);
        GivePlayerCash(playerid, -900);
        if (PlayerInfo[playerid][pWanted] == 2)
        {
            PlayerInfo[playerid][pPJail] = 2 * 60;
            SendClientMessage(playerid, 0xFF0000FF, "[WASTED] {0040FF} Сега ще си в затвора за 2 минути и губиш $1800!");
            GivePlayerCash(killerid, 1800);
            GivePlayerCash(playerid, -1800);
        }
        if (PlayerInfo[playerid][pWanted] == 3)
        {
            PlayerInfo[playerid][pPJail] = 3 * 60;
            SendClientMessage(playerid, 0xFF0000FF, "[WASTED] {0040FF} Сега ще си в затвора за 3 минути и губиш $2700!");
            GivePlayerCash(killerid, 2700);
            GivePlayerCash(playerid, -2700);
        }
        if (PlayerInfo[playerid][pWanted] == 4)
        {
            PlayerInfo[playerid][pPJail] = 4 * 60;
            SendClientMessage(playerid, 0xFF0000FF, "[WASTED] {0040FF} Сега ще си в затвора за 4 минути и губиш $3600!");
            GivePlayerCash(killerid, 3600);
            GivePlayerCash(playerid, -3600);
        }
        if (PlayerInfo[playerid][pWanted] == 5)
        {
            PlayerInfo[playerid][pPJail] = 5 * 60;
            SendClientMessage(playerid, 0xFF0000FF, "[WASTED] {0040FF} Сега ще си в затвора за 5 минути и губиш $4500!");
            GivePlayerCash(killerid, 4500);
            GivePlayerCash(playerid, -4500);
        }
        if (PlayerInfo[playerid][pWanted] == 6)
        {
            PlayerInfo[playerid][pPJail] = 6 * 60;
            SendClientMessage(playerid, 0xFF0000FF, "[WASTED] {0040FF} Сега ще си в затвора за 6 минути и губиш $5400!");
            GivePlayerCash(killerid, 5400);
            GivePlayerCash(playerid, -5400);
        }
        format(string256, 256, "[MDC] {FF0000}%s{3366ff} успя да залови престъпник %s с ниво на издирване", GetPlayerNickname(killerid), GetPlayerNickname(playerid), PlayerInfo[playerid][pWanted]);
        SendFactionMessage(FACTION_INTENSE_POLICE, 0xFF0000FF, string256);
        PlayerInfo[playerid][pWanted] = 0;
        SetSuspectStars(playerid);
    }
}

/*
* Drugs
*/

stock LoseDrugs(playerid, killerid)
{
    if (PlayerInfo[playerid][pWeed] >= 1)
    {
        if (PlayerInfo[playerid][pWeed] == 1)
        {
            format(string256, 256, "Ти загуби твоя грам трева!");
            SendClientMessage(playerid, 0xFF2D2DFF, string256);
            format(string256, 256, "Ти отмъкна 1 грам трева от %s", GetPlayerNickname(playerid));
            SendClientMessage(playerid, 0xFF2D2DFF, string256);
        }
        else
        {
            format(string256, 256, "Ти загуби твоите %d грама трева!", PlayerInfo[playerid][pWeed]);
            SendClientMessage(playerid, 0xFF2D2DFF, string256);
            format(string256, 256, "Ти отмъкна %d грама трева от %s", GetPlayerNickname(playerid), PlayerInfo[playerid][pWeed]);
            SendClientMessage(playerid, 0xFF2D2DFF, string256);
        }
        PlayerInfo[killerid][pWeed] += PlayerInfo[playerid][pWeed];
        PlayerInfo[playerid][pWeed] = 0;
    }
    if (PlayerInfo[playerid][pCocaine] >= 1)
    {
        if (PlayerInfo[playerid][pCocaine] == 1)
        {
            format(string256, 256, "Ти загуби твоя грам кокаин!");
            SendClientMessage(playerid, 0xFF2D2DFF, string256);
            format(string256, 256, "Ти отмъкна 1 грам кокаин от %s", GetPlayerNickname(playerid));
            SendClientMessage(playerid, 0xFF2D2DFF, string256);
        }
        else
        {
            format(string256, 256, "Ти загуби твоите %d кокаин трева!", PlayerInfo[playerid][pCocaine]);
            SendClientMessage(playerid, 0xFF2D2DFF, string256);
            format(string256, 256, "Ти отмъкна %d грама кокаин от %s", GetPlayerNickname(playerid), PlayerInfo[playerid][pCocaine]);
            SendClientMessage(playerid, 0xFF2D2DFF, string256);
        }
        PlayerInfo[killerid][pCocaine] += PlayerInfo[playerid][pCocaine];
        PlayerInfo[playerid][pCocaine] = 0;
    }
    if (PlayerInfo[playerid][pHeroin] >= 1)
    {
        if (PlayerInfo[playerid][pHeroin] == 1)
        {
            format(string256, 256, "Ти загуби твоя грам хероин!");
            SendClientMessage(playerid, 0xFF2D2DFF, string256);
            format(string256, 256, "Ти отмъкна 1 грам хероин от %s", GetPlayerNickname(playerid));
            SendClientMessage(playerid, 0xFF2D2DFF, string256);
        }
        else
        {
            format(string256, 256, "Ти загуби твоите %d хероин трева!", PlayerInfo[playerid][pHeroin]);
            SendClientMessage(playerid, 0xFF2D2DFF, string256);
            format(string256, 256, "Ти отмъкна %d грама хероин от %s", GetPlayerNickname(playerid), PlayerInfo[playerid][pHeroin]);
            SendClientMessage(playerid, 0xFF2D2DFF, string256);
        }
        PlayerInfo[killerid][pHeroin] += PlayerInfo[playerid][pHeroin];
        PlayerInfo[playerid][pHeroin] = 0;
    }
    if (PlayerInfo[playerid][pMoonshine] >= 1)
    {
        if (PlayerInfo[playerid][pMoonshine] == 1)
        {
            format(string256, 256, "Ти загуби твоя литър спиртно питие!");
            SendClientMessage(playerid, 0xFF2D2DFF, string256);
            format(string256, 256, "Ти отмъкна 1 литър спиртно питие от %s", GetPlayerNickname(playerid));
            SendClientMessage(playerid, 0xFF2D2DFF, string256);
        }
        else
        {
            format(string256, 256, "Ти загуби твоите %d литра спиртно питие!", PlayerInfo[playerid][pMoonshine]);
            SendClientMessage(playerid, 0xFF2D2DFF, string256);
            format(string256, 256, "Ти отмъкна %d литра спиртно питие от %s", GetPlayerNickname(playerid), PlayerInfo[playerid][pMoonshine]);
            SendClientMessage(playerid, 0xFF2D2DFF, string256);
        }
        PlayerInfo[killerid][pMoonshine] += PlayerInfo[playerid][pMoonshine];
        PlayerInfo[playerid][pMoonshine] = 0;
    }
}

/*
* Checkpoints
*/
DisableAllCheckPoints(playerid)
{
    DisablePlayerRaceCheckpoint(playerid);
    DisablePlayerCheckpoint(playerid);
}
DisableAllCheckPointsWithCon(playerid)
{
    if (onWork[playerid] == 0 && gpsOn[playerid] == false)
    {
        DisablePlayerRaceCheckpoint(playerid);
        DisablePlayerCheckpoint(playerid);
    }
}

/*
* IP
*/
GetPlayerCurrentIP(playerid)
{
    new playerIP[35];
    GetPlayerIp(playerid, playerIP, 35);
    UpdatePlayeridDatabaseSTR("ip", playerIP, playerid);
}

/*
* Virtual World
*/
stock SetPlayerToVirtualWorldNull(playerid)
{

    if (IsPlayerInAnyVehicle(playerid))
    {
        new hisVeh = GetPlayerVehicleID(playerid);
        SetPlayerVirtualWorld(playerid, 0);
        SetVehicleVirtualWorld(hisVeh, 0);
        PutPlayerInVehicle(playerid, hisVeh, 0);
    }
    else if (!IsPlayerInAnyVehicle(playerid))
    {
        SetPlayerVirtualWorld(playerid, 0);
    }
}

/*
* Clothes
*/
stock GetClothName(clothID)
{
    new clothName[60];
    switch (clothID)
    {

        case 0:
        {
            format(clothName, 60, "Empty");
        }

    }
    return clothName;
}

/*
* Stats
*/
ShowPlayerStats(playerReceive, playerStats)
{
    new gangname[100];
    new isbizzowner[5];
    new bizznumber = -1;
    new ishouseowner[5];
    new housenumber = -1;
    new isofficeowner[5];
    new isinjob[5];

    if (PlayerInfo[playerStats][pJob] == 1) format(isinjob, 5, "Yes");
    if (PlayerInfo[playerStats][pJob] == 0) format(isinjob, 5, "No");

    format(gangname, 100, "%s", TeamInfo[PlayerInfo[playerStats][pTeam]][tName]);
    new ranktext[256];

    switch (PlayerInfo[playerStats][pRank])
    {
        case 1: format(ranktext, 256, "%s", TeamInfo[PlayerInfo[playerStats][pTeam]][tRank1]);
        case 2: format(ranktext, 256, "%s", TeamInfo[PlayerInfo[playerStats][pTeam]][tRank2]);
        case 3: format(ranktext, 256, "%s", TeamInfo[PlayerInfo[playerStats][pTeam]][tRank3]);
        case 4: format(ranktext, 256, "%s", TeamInfo[PlayerInfo[playerStats][pTeam]][tRank4]);
        case 5: format(ranktext, 256, "%s", TeamInfo[PlayerInfo[playerStats][pTeam]][tRank5]);
        case 6: format(ranktext, 256, "%s", TeamInfo[PlayerInfo[playerStats][pTeam]][tRank6]);
    }

    if (GetPlayerOfficeID(playerStats) == 0) format(isofficeowner, 5, "No");
    if (GetPlayerOfficeID(playerStats) >= 1) format(isofficeowner, 5, "Yes");

    if (PlayerInfo[playerStats][pBizO] > -1)
    {
        bizznumber = PlayerInfo[playerStats][pBizO];
        format(isbizzowner, 5, "Yes");
    }
    if (PlayerInfo[playerStats][pBizO] == -1)
    {
        format(isbizzowner, 5, "No");
        bizznumber = 0;
    }

    if (PlayerInfo[playerStats][pHouseO] > -1)
    {
        housenumber = PlayerInfo[playerStats][pHouseO];
        format(ishouseowner, 5, "Yes");
    }
    if (PlayerInfo[playerStats][pHouseO] == -1)
    {
        format(ishouseowner, 5, "No");
        housenumber = maxhouses;
    }

    new string256[1024];
    format(string256, 1024, "Статистиката на %s\n\n", GetPlayerNickname(playerStats));

    new statsText[1024];

    if (freevip == 1)
    {
        format(statsText, 1024, "Level: %d | Admin Level: %d | VIP Level: %d | EP Skill: %d | Money Skill: %d | Weapon Skill: %d\n",
               PlayerInfo[playerStats][pLevel], PlayerInfo[playerStats][pAdmin], PlayerInfo[playerStats][pVip],
               PlayerInfo[playerStats][pEPS], PlayerInfo[playerStats][pMS], PlayerInfo[playerStats][pWeaponS]);
    }
    else
    {
        format(statsText, 1024, "Level: %d | Admin Level: %d | VIP Level: FREE | EP Skill: %d | Money Skill: %d | Weapon Skill: %d\n",
               PlayerInfo[playerStats][pLevel], PlayerInfo[playerStats][pAdmin], PlayerInfo[playerStats][pEPS],
               PlayerInfo[playerStats][pMS], PlayerInfo[playerStats][pWeaponS]);
    }

    format(string256, 1024, "%sCash: $%d | Kills: %d | Deaths: %d | House: %s(%d) | Bizz: %s(%d) | Office: %s(%d) | Job: %s | EP: %d/%d\n",
           statsText,
           PlayerInfo[playerStats][pCash], PlayerInfo[playerStats][pKills], PlayerInfo[playerStats][pDeaths],
           ishouseowner, housenumber, isbizzowner, bizznumber, isofficeowner, GetPlayerOfficeID(playerStats),
           isinjob, PlayerInfo[playerStats][pEP], PlayerInfo[playerStats][pLevel] + 6);

    format(statsText, 1024, "%sMoneybox: %d/4 | Streetrace: %d/4 | Deathmatch: %d/4 | CMN1 Kills: %d/4\n",
           string256, PlayerInfo[playerStats][pMoneyboxSuccess], PlayerInfo[playerStats][pStreetRaceSuccess],
           PlayerInfo[playerStats][pDeathmatchSuccess], PlayerInfo[playerStats][pCMN1]);

    format(string256, 1024, "%sWanted Level: %d | Police Jail Time: %d минути",
           statsText, PlayerInfo[playerStats][pWanted], PlayerInfo[playerStats][pPJail]);

    format(statsText, 1024, "%sFaction: %s | Faction Rank: %s(%d) | Faction Mute Time: %d минути | Faction Warns: %d/3\n",
           string256, gangname, ranktext, PlayerInfo[playerStats][pRank], PlayerInfo[playerStats][pFMuted], PlayerInfo[playerStats][pFWarns]);

    format(string256, 1024, "%sMute Time: %d минути | Jail Time: %d минути | R&N Mute Time: %d минути | Warns: %d/5 | Admin Warns: %d/4\n",
           statsText, (PlayerInfo[playerStats][pMuted] / 60), PlayerInfo[playerStats][pJail] / 60, PlayerInfo[playerStats][pRNMute],
           PlayerInfo[playerStats][pWarns], PlayerInfo[playerStats][pAWarns]);

    format(statsText, 1024, "%s\n{FFFFFF}Играно време след получаването на последния Payday: %d минути",
           string256, PlayerInfo[playerStats][pLastPayday]);

    ShowPlayerDialog(playerReceive, 3000, DIALOG_STYLE_MSGBOX, "Статистика", statsText, "Close", "");
}

/*
* Positions
*/
public ProxDetector(Float:radi, playerid, string[], col1, col2, col3, col4, col5)
{
    if (IsPlayerConnected(playerid))
    {
        new Float:posx, Float:posy, Float:posz;
        new Float:oldposx, Float:oldposy, Float:oldposz;
        new Float:tempposx, Float:tempposy, Float:tempposz;
        GetPlayerPos(playerid, oldposx, oldposy, oldposz);
        //radi = 2.0; //Trigger Radius
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i))
            {
                if (!BigEar[i])
                {
                    GetPlayerPos(i, posx, posy, posz);
                    tempposx = (oldposx - posx);
                    tempposy = (oldposy - posy);
                    tempposz = (oldposz - posz);
                    //printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
                    if (((tempposx < radi / 16) && (tempposx > -radi / 16)) && ((tempposy < radi / 16) && (tempposy > -radi / 16)) && ((tempposz < radi / 16) && (tempposz > -radi / 16)))
                    {
                        SendClientMessage(i, col1, string);
                    }
                    else if (((tempposx < radi / 8) && (tempposx > -radi / 8)) && ((tempposy < radi / 8) && (tempposy > -radi / 8)) && ((tempposz < radi / 8) && (tempposz > -radi / 8)))
                    {
                        SendClientMessage(i, col2, string);
                    }
                    else if (((tempposx < radi / 4) && (tempposx > -radi / 4)) && ((tempposy < radi / 4) && (tempposy > -radi / 4)) && ((tempposz < radi / 4) && (tempposz > -radi / 4)))
                    {
                        SendClientMessage(i, col3, string);
                    }
                    else if (((tempposx < radi / 2) && (tempposx > -radi / 2)) && ((tempposy < radi / 2) && (tempposy > -radi / 2)) && ((tempposz < radi / 2) && (tempposz > -radi / 2)))
                    {
                        SendClientMessage(i, col4, string);
                    }
                    else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
                    {
                        SendClientMessage(i, col5, string);
                    }
                }
                else
                {
                    SendClientMessage(i, col1, string);
                }
            }
        }
    } //not connected
    return 1;
}

Float:GetXYInFrontOfPlayer(playerid, & Float:q, & Float:w, Float:distance)
{
    new Float:a;
    GetPlayerPos(playerid, q, w, a);
    if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
    else GetPlayerFacingAngle(playerid, a);
    q += (distance * floatsin(-a, degrees));
    w += (distance * floatcos(-a, degrees));
    return a;
}
Float:GetXYBehindPlayer(playerid, & Float:q, & Float:w, Float:distance)
{
    new Float:a;
    GetPlayerPos(playerid, q, w, a);
    if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
    else GetPlayerFacingAngle(playerid, a);
    q += (distance * -floatsin(-a, degrees));
    w += (distance * -floatcos(-a, degrees));
    return a;
}

/*
* Hooks
*/

hook OnPlayerUpdate(playerid)
{
    AFKDetect[playerid] = gettime();

    /*
    * Checks if player is ESC At Turf
    */
    if (IsPlayerPaused(playerid) && isTurfMember[playerid])
    {
        if (PlayerInfo[playerid][pKick] == 0)
        {
            SendClientMessage(playerid, COLOR_RED, "SERVER: Ти беше KICKED, понеже беше ESC AFK на Turf!");
            PlayerInfo[playerid][pKick] = 1;
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerSpawn(playerid)
{
    spawned[playerid] = 1;
    UpdatePlayerHeadText(playerid);
    GivePlayerWeaponSkillWeapons(playerid);

    if (IsPlayerFirstSpawn(playerid))
    {
        SetPlayerFirstSpawn(playerid);
    }
    if (PlayerInfo[playerid][pSpawnO] == 0)
    {
        SetPlayerToOfficeSpawn(playerid);
    }
    if (PlayerInfo[playerid][pSpawnO] == 1)
    {
        SetPlayerToCivilianSpawn(playerid);
    }
    if (PlayerInfo[playerid][pSpawnO] == 3)
    {
        SetPlayerToIfcSpawn(playerid);
    }
    if (PlayerInfo[playerid][pSpawnO] == 2)
    {
        SetPlayerToFactionSpawn(playerid);
    }

    RestartPlayerColor(playerid);
    RestartVIPLaser(playerid);
    OnPlayerSpawnAsVIP(playerid);
    RestartPlayerSkin(playerid);
    CheckAdutySkinChange(playerid);
    SetSuspectStars(playerid);

    if (PlayerInfo[playerid][pSpawnO] == 4)
    {
        SetPlayerToHouseSpawn(playerid);
    }
    if (PlayerInfo[playerid][pSpawnO] == 5)
    {
        SetPlayerToBizSpawn(playerid);
    }
    if (PlayerInfo[playerid][pADuty] == 0)
    {
        SetPlayerVipLabel(playerid);
    }
    if (PlayerInfo[playerid][pADuty] == 1)
    {
        SetPlayerAdutyOnSpawn(playerid);
    }

    /*
    * After normal spawns
    */
    if (IsPlayerInDMON(playerid))
    {
        SetPlayerToDmonSpawn(playerid);
    }
    if (IsPlayerInDeathmatchMission(playerid))
    {
        SpawnInDeathmatchMission(playerid);
    }
    if (PlayerInfo[playerid][pAFK] > 0)
    {
        SetPlayerToAfkSpawn(playerid);
    }
    if (PlayerInfo[playerid][pPJail] > 0)
    {
        SetPlayerToPoliceJailSpawn(playerid);
    }
    if (PlayerInfo[playerid][pJail] > 0)
    {
        SetPlayerToJailSpawn(playerid);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    /*
    * Checks if vehicle is locked
    */
    if (vehLocker[playerid] != -1)
    {
        if (newstate == PLAYER_STATE_PASSENGER || newstate == PLAYER_STATE_ONFOOT)
        {
            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                SetVehicleParamsForPlayer(vehLocker[playerid], i, 0, 0);
            }
        }
    }
    if (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER || newstate == PLAYER_STATE_ONFOOT)
    {
        vehLocker[playerid] = -1;
    }

    /*
    * Sets armed weapon to id 0
    */
    if (newstate == PLAYER_STATE_DRIVER)
    {
        SetPlayerArmedWeapon(playerid, 0);
        g_veh[playerid] = GetPlayerVehicleID(playerid);
    }
    if (AntiFallOfBike[playerid] == 1)
    {
        if (GetVehicleModel(g_veh[playerid]) == 509 || GetVehicleModel(g_veh[playerid]) == 510 || GetVehicleModel(g_veh[playerid]) == 481)
        {
            new Float:Health;
            GetPlayerHealth(playerid, Health);
            if (newstate == PLAYER_STATE_ONFOOT && oldstate == PLAYER_STATE_DRIVER && lastkey[playerid] != 16 && Health > 0.0)
            {
                PutPlayerInVehicle(playerid, g_veh[playerid], 0);
            }
        }
    }
    if (newstate == PLAYER_STATE_DRIVER)
    {
        drive[GetPlayerVehicleID(playerid)] = 1;
    }
    if (newstate == PLAYER_STATE_PASSENGER)
    {
        passenger[playerid] = true;
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 431 ||
                GetVehicleModel(GetPlayerVehicleID(playerid)) == 437 ||
                GetVehicleModel(GetPlayerVehicleID(playerid)) == 508 ||
                GetVehicleModel(GetPlayerVehicleID(playerid)) == 431 ||
                GetVehicleModel(GetPlayerVehicleID(playerid)) == 573)
        {
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, GetPlayerVehicleID(playerid));
            SetPlayerPos(playerid, 2021.8448, 2235.1274, 2103.9536);
            SetPlayerFacingAngle(playerid, 180.7037);
            SetCameraBehindPlayer(playerid);
        }
    }
    if (newstate == PLAYER_STATE_DRIVER)
    {
        driver[playerid] = 1;
        PlayerInfo[playerid][pFuel] = 25;
    }
    if (newstate != PLAYER_STATE_DRIVER)
    {
        driver[playerid] = 0;
        PlayerInfo[playerid][pFuel] = -1;
    }
    if (newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
    {
        if (loadedtext[playerid] == 0)
        {
            if (speedo[playerid] == 0)
            {
                TextDrawShowForPlayer(playerid, vehstatus[playerid]);
            }
            loadedtext[playerid] = 1;
        }
        GetVehicleHealth(GetPlayerVehicleID(playerid), vehhealth[playerid]);
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) != 481 &&
                GetVehicleModel(GetPlayerVehicleID(playerid)) != 509 &&
                GetVehicleModel(GetPlayerVehicleID(playerid)) != 510 &&
                GetVehicleModel(GetPlayerVehicleID(playerid)) != 481)
        {
            if (speedo[playerid] == 0)
            {
                if (kmh[playerid] == 0)
                {
                    format(stringvehicle[playerid], 115, "~w~Speed: %dkm/h~n~~g~Health: %.0f~n~~r~Fuel: %dL", GetVehicleKmh(GetPlayerVehicleID(playerid)), vehhealth[playerid], vehfuel[GetPlayerVehicleID(playerid)]);
                }
                else
                {
                    new vehicleid, Float:speed_x, Float:speed_y, Float:speed_z, final_speed_int;
                    vehicleid = GetPlayerVehicleID(playerid);
                    GetVehicleVelocity(vehicleid, speed_x, speed_y, speed_z);
                    final_speed_int = GetVehicleKmh(vehicleid);
                    format(stringvehicle[playerid], 115, "~w~Speed: %dm/s~n~~g~Health: %.0f~n~~r~Fuel: %dL", final_speed_int, vehhealth[playerid], vehfuel[GetPlayerVehicleID(playerid)]);
                }
            }
        }
        else
        {
            if (speedo[playerid] == 0)
            {
                if (kmh[playerid] == 0)
                {
                    format(stringvehicle[playerid], 115, "~w~Speed: %dkm/h~n~~g~Health: %.0f", GetVehicleKmh(GetPlayerVehicleID(playerid)), vehhealth[playerid]);
                }
                else
                {
                    new vehicleid, Float:speed_x, Float:speed_y, Float:speed_z, final_speed_int;
                    vehicleid = GetPlayerVehicleID(playerid);
                    GetVehicleVelocity(vehicleid, speed_x, speed_y, speed_z);
                    final_speed_int = GetVehicleKmh(vehicleid);
                    format(stringvehicle[playerid], 115, "~w~Speed: %dm/s~n~~g~Health: %.0f", final_speed_int, vehhealth[playerid]);
                }
            }
        }
        TextDrawSetString(vehstatus[playerid], stringvehicle[playerid]);
    }
    if (oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_ONFOOT || oldstate == PLAYER_STATE_PASSENGER && newstate == PLAYER_STATE_ONFOOT || oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_WASTED || oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_SPECTATING || oldstate == PLAYER_STATE_PASSENGER && newstate == PLAYER_STATE_SPECTATING ||
            oldstate == PLAYER_STATE_DRIVER && newstate == PLAYER_STATE_SPECTATING)
    {
        if (loadedtext[playerid] == 1)
        {
            TextDrawHideForPlayer(playerid, vehstatus[playerid]);
            loadedtext[playerid] = 0;
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
    drive[vehicleid] = 0;
    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if (GetVehicleModel(vehicleid) == 481)
    {
        SetPlayerArmedWeapon(playerid, 0);
    }

    if (isTurfMember[playerid])
    {
        new Float:cx, Float:cy, Float:cz;
        GetPlayerPos(playerid, cx, cy, cz);
        SetPlayerPos(playerid, cx, cy, cz);
        return SendClientMessage(playerid, COLOR_GRAD1, "Влизането в превозни средства, докато си в търф атака е забранено !");
    }
    if (eev == 0 && inevent[playerid] == 1)
    {
        new Float:cx, Float:cy, Float:cz;
        GetPlayerPos(playerid, cx, cy, cz);
        SetPlayerPos(playerid, cx, cy, cz);
        return SendClientMessage(playerid, COLOR_GRAD1, "Влизането в превозни средства в евента е забранено !");
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerGiveDamage(playerid, damagedid, Float: amount, weaponid, bodypart)
{
    if (weaponid == 34 && bodypart == 9) // Sniper rifle + head
    {
        // Kill the victim
        SetPlayerHealth(damagedid, 0.0);
        GameTextForPlayer(playerid, "~r~HEADSHOT!", 3000, 3);
        // Victim visual/sound
        GameTextForPlayer(damagedid, "~r~HEADSHOT!", 3000, 3);
        PlayerPlaySound(damagedid, 17802, 0.0, 0.0, 0.0);
    }

    if (damagedid != INVALID_PLAYER_ID && damagedid != playerid)
    {
        if (PlayerInfo[damagedid][pIPDDuty] && !PlayerInfo[playerid][pIPDDuty] && !PlayerInfo[playerid][pADuty])
        {
            new now = gettime();
            if (now - lastCriminalPoliceUser[playerid] >= 30)
            {
                lastCriminalPoliceUser[playerid] = now;
                GivePlayerWantedLevel(playerid, 1, "Стрелба по полицaй");
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

/*
* Player command
*/
public OnPlayerCommandReceived(playerid, cmdtext[])
{
    printf("[i-zcmd] %s (ID: %d): %s", GetPlayerNickname(playerid), playerid, cmdtext);

    // Prevent commands if not logged in
    if (logged[playerid] == 0)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Трябва да влезеш в акаунта преди да ползваш команда!");
        return 0;
    }

    // Command spam timer
    if (PlayerInfo[playerid][pCommandSpamTimer] == 0)
    {
        PlayerInfo[playerid][pCommandSpamTimer] = 8;
    }
    if (PlayerInfo[playerid][pAdmin] < 5)
    {
        commandspam[playerid] += 1;
    }
    if (commandspam[playerid] == 9)
    {
        format(string115, 115, "SERVER: %s was kicked by THE SERVER [Reason: Command Spam]", GetPlayerNickname(playerid));
        SendClientMessageToAll(0xE60000FF, string115);
        PlayerInfo[playerid][pKick] = 1;
        return 0;
    }

    return 1;
}

/*
* Time
*/
stock ResetPlayerTime(playerid)
{
    SetPlayerWeather(playerid, 1);
    if (hours == 0)
    {
        SetPlayerTime(playerid, 0, 0);
    }
    if (hours == 6)
    {
        SetPlayerTime(playerid, 0, 0);
    }
    if (hours == 12)
    {
        SetPlayerTime(playerid, 12, 0);
    }
    if (hours == 18)
    {
        SetPlayerTime(playerid, 23, 0);
    }
    if (hours == 1)
    {
        SetPlayerTime(playerid, 0, 0);
    }
    if (hours == 7)
    {
        SetPlayerTime(playerid, 6, 0);
    }
    if (hours == 13)
    {
        SetPlayerTime(playerid, 12, 0);
    }
    if (hours == 19)
    {
        SetPlayerTime(playerid, 23, 0);
    }
    if (hours == 2)
    {
        SetPlayerTime(playerid, 0, 0);
    }
    if (hours == 8)
    {
        SetPlayerTime(playerid, 6, 0);
    }
    if (hours == 14)
    {
        SetPlayerTime(playerid, 12, 0);
    }
    if (hours == 20)
    {
        SetPlayerTime(playerid, 0, 0);
    }
    if (hours == 3)
    {
        SetPlayerTime(playerid, 0, 0);
    }
    if (hours == 9)
    {
        SetPlayerTime(playerid, 12, 0);
    }
    if (hours == 15)
    {
        SetPlayerTime(playerid, 12, 0);
    }
    if (hours == 21)
    {
        SetPlayerTime(playerid, 0, 0);
    }
    if (hours == 4)
    {
        SetPlayerTime(playerid, 0, 0);
    }
    if (hours == 10)
    {
        SetPlayerTime(playerid, 12, 0);
    }
    if (hours == 16)
    {
        SetPlayerTime(playerid, 12, 0);
    }
    if (hours == 22)
    {
        SetPlayerTime(playerid, 0, 0);
    }
    if (hours == 5)
    {
        SetPlayerTime(playerid, 0, 0);
    }
    if (hours == 11)
    {
        SetPlayerTime(playerid, 12, 0);
    }
    if (hours == 17)
    {
        SetPlayerTime(playerid, 12, 0);
    }
    if (hours == 23)
    {
        SetPlayerTime(playerid, 0, 0);
    }
}

/*
* On player death
*/
hook OnPlayerDeath(playerid, killerid, reason)
{
    SendDeathMessage(killerid, playerid, reason);
    PlayerInfo[playerid][pDeaths] += 1;
    PlayerInfo[killerid][pKills] += 1;

    // Remove player label from screen
    if (PlayerInfo[playerid][pADuty] == 1)
    {
        UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, " ");
    }
    if (PlayerInfo[playerid][pVIPLabel] == 1)
    {
        UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, " ");
    }

    // Get cash from dead person
    if (killerid != playerid)
    {
        if (PlayerInfo[killerid][pVip] == 0)
        {
            GivePlayerCash(killerid, 100);
        }
        if (PlayerInfo[killerid][pVip] > 0 || CheckFreeVIP() == 1)
        {
            GivePlayerCash(killerid, 200);
        }
        if (PlayerInfo[killerid][pVip] == 6 || CheckFreeVIP() == 1)
        {
            GivePlayerCash(killerid, 600);
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerText(playerid, text[])
{
    if (logged[playerid] == 0)
    {
        SendClientMessage(playerid, 0xBFC0C2FF, "Трябва да влезеш в акаунта преди да пишеш в чата!");
        return Y_HOOKS_BREAK_RETURN_0;
    }
    if (PlayerInfo[playerid][pMuted] > 0 || PlayerInfo[playerid][pADMINMute] == 1)
    {
        SendClientMessage(playerid, 0xBFC0C2FF, "Ти си заглушен в чата!");
        return Y_HOOKS_BREAK_RETURN_0;
    }
    if (togchat[playerid] == 1 && cbchat[playerid] == 0)
    {
        SendClientMessage(playerid, 0xBFC0C2FF, "Ти си игнорирал да ти идват съобщения от главния чат!");
        return Y_HOOKS_BREAK_RETURN_0;
    }

    /*
    * CB Chat
    */
    if (cbchat[playerid] == 0)
    {
        if (PlayerInfo[playerid][pTextSpamTimer] == 0)
        {
            PlayerInfo[playerid][pTextSpamTimer] = 8;
        }
        if (PlayerInfo[playerid][pAdmin] < 5)
        {
            textspam[playerid] += 1;
        }
        if (textspam[playerid] == 8)
        {
            format(string256, 256, "ADMIN: %s was muted by THE SERVER for 100 minutes. [Reason: Спам]", GetPlayerNickname(playerid));
            SendClientMessageToAll(0xE60000FF, string256);
            PlayerInfo[playerid][pMuted] = 120 * 100;
            PlayerInfo[playerid][pMuteReason] = 3;
            return Y_HOOKS_BREAK_RETURN_0;
        }

        format(string256, 256, "{FFFFFF}(%d): {FFFFFF}%s", playerid, text[0]);
        SendPlayerMessageToAll(playerid, string256);
        return Y_HOOKS_BREAK_RETURN_0;
    }
}

stock GivePlayerArmour(playerid, points)
{
    new Float:armour;
    GetPlayerArmour(playerid, armour);
    if (armour + points > 100)
    {
        armour = 100;
    }
    SetPlayerArmour(playerid, armour);
}

stock GetPlayerOfficeID(playerid)
{
    for (new i = 1; i < MAX_OFFICES; i++)
    {
        if (OfficeInfo[i][isOwned] == 1 && strcmp(OfficeInfo[i][OwnerName], GetPlayerNickname(playerid), true) == 0)
        {
            return i;
        }
    }
    return -1;
}


stock SpawnOutside(playerid, Float:pos[][3], Float:angles[], size)
{
    new spawn = random(size);
    SetPlayerPos(playerid, pos[spawn][0], pos[spawn][1], pos[spawn][2]);
    SetPlayerFacingAngle(playerid, angles[spawn]);
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerInterior(playerid, 0);
    SetCameraBehindPlayer(playerid);
}

stock SpawnInterior(playerid, Float:x, Float:y, Float:z, world, interior, Float:angle = 0.0, armour = 0)
{
    if (armour > 0)
    {
        SetPlayerArmour(playerid, armour);
    }
    SetPlayerPos(playerid, x, y, z);
    SetPlayerFacingAngle(playerid, angle);
    SetPlayerVirtualWorld(playerid, world);
    SetPlayerInterior(playerid, interior);
    SetCameraBehindPlayer(playerid);
}

stock SetPlayerChristmasHat(playerid)
{
    santaHat[playerid] = true;
    santaHatObject[playerid] = SetPlayerAttachedObject(playerid, 9, 19065, 2, 0.120000, 0.040000, -0.003500, 0, 100, 100, 1.4, 1.4, 1.4);
    SendClientMessage(playerid, 0xFFFFFFFF, "CHRISTMAS: Ако искаш да премахнеш коледната шапка от главата ти, напиши /removehat");
    SendClientMessage(playerid, 0xFFFFFFFF, "CHRISTMAS: Ако искаш пак да си я сложиш, напиши /santahat");
}

stock IsPlayerFirstSpawn(playerid)
{
    firstspawn[playerid] = 1;
}

stock SetPlayerFirstSpawn(playerid)
{
    requestspawn2[playerid] = 1;
    nospawnselect[playerid] = 1;
    StopAudioStreamForPlayer(playerid);
    firstspawn[playerid] = 0;
    if (month == 12)
    {
        SetPlayerChristmasHat(playerid);
    }
}

stock DenyVehicleEntry(playerid, const message[])
{
    new Float:cx, Float:cy, Float:cz;
    GetPlayerPos(playerid, cx, cy, cz);
    SetPlayerPos(playerid, cx, cy, cz);
    SendClientMessage(playerid, 0x636363FF, message);
}