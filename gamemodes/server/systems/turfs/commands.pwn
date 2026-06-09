CMD:turfs(playerid, params[])
{
    new factions[MAX_TEAMS][2];
    for (new i = 0; i < MAX_TEAMS; i++)
    {
        factions[i][0] = i;
        factions[i][1] = TeamInfo[i][tTurfsCount];
    }
    SortDeepArray(factions, 1, .order = SORT_DESC);
    new factionID, factionTurfs, index = 1;
    new string2230[512];
    new string2230result[2230];
    for (new i = 0; i < MAX_TEAMS; i++)
    {
        factionTurfs = factions[i][1];
        factionID = factions[i][0];
        if (factionID != FACTION_CIVILIAN && factionID != FACTION_INTENSE_POLICE && factionID != FACTION_VIP)
        {
            format(string2230, 512, "{00FF00}%d. {33CCFF}%s притежава: {FF0000}%d територии\n", index, TeamInfo[factionID][tName], factionTurfs);
            strcat(string2230result, string2230);
            index++;
        }
        else
        {
            if (factionID == FACTION_CIVILIAN)
            {
                //civilianTurfs = factionTurfs;
            }
        }
    }
    format(string2230, 512, "\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}Брой Civilian територии: {FF0000}%d\n", TeamInfo[FACTION_CIVILIAN][tTurfsCount]);
    strcat(string2230result, string2230);
    ShowPlayerDialog(playerid, 3500, DIALOG_STYLE_MSGBOX, "Turfs", string2230result, "OK", "");
    return 1;
}

CMD:turfduration(playerid, params[])
{
    if (PlayerInfo[playerid][pTeam] == FACTION_VIP || PlayerInfo[playerid][pTeam] == FACTION_INTENSE_POLICE) return SendClientMessage(playerid, 0xB4B5B7FF, "Твоята банда не може да превзема територии!");
    SendClientMessage(playerid, 0xC800FFFF, "Твоята банда/мафия търфи 5 минути!");
    return 1;
}


CMD:turfattack(playerid, params[])
{
    new hh, mm, ss;
    gettime(hh, mm, ss); //if(hh < 10, hh > 23), hh > 23
    if (startturf == 1)
    {
        new playerTeam = PlayerInfo[playerid][pTeam];
        format(string256, 256, "Твоята банда ще може да прави атаки след %d минути!", TeamInfo[playerTeam][tAttackTurfTime] / 60);
        return SendClientMessage(playerid, 0xC800FFFF, string256);
    }
    if (GetPlayerVirtualWorld(playerid) >= 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в търф!");
    if (PlayerInfo[playerid][pADuty] == 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, защото си ADMIN ON-DUTY!");
        return 1;
    }
    if (IsPlayerInAnyVehicle(playerid))
        return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да ползваш тази команда до като си в превозно средство.");
    if (hh < 6 && hh >= 1)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Може да се атакуват територий от 6:00 сутринта до 01:00 ноща!");
        return 1;
    }
    //if(hh > 23)
    //{
    //SendClientMessage(playerid, COLOR_GRAD1, "Може да се атакуват територий от 10:00 сутринта до 23:00 вечерта!");
    //return 1;
    //}
    if (PlayerInfo[playerid][pRank] < 6 && PlayerInfo[playerid][pTeam] != FACTION_VAGOS && PlayerInfo[playerid][pTeam] != FACTION_CRIPZ && PlayerInfo[playerid][pTeam] != FACTION_GROVE && PlayerInfo[playerid][pTeam] != FACTION_NANG && PlayerInfo[playerid][pTeam] != FACTION_RIFA && PlayerInfo[playerid][pTeam] != FACTION_THUGLIFE && PlayerInfo[playerid][pTeam] != FACTION_BALLAS) return SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    if (PlayerInfo[playerid][pTeam] == FACTION_VIP || PlayerInfo[playerid][pTeam] == FACTION_INTENSE_POLICE) return SendClientMessage(playerid, 0xB4B5B7FF, "Твоята банда не може да превзема територии!");
    new playerTeam = PlayerInfo[playerid][pTeam];
    new turfid;
    if (TeamInfo[playerTeam][tAttackTurfTime] >= 61)
    {
        format(string256, 256, "Твоята банда ще може да прави атаки след %d минути!", TeamInfo[playerTeam][tAttackTurfTime] / 60);
        return SendClientMessage(playerid, 0xC800FFFF, string256);
    }
    if (TeamInfo[playerTeam][tAttackTurfTime] > 0 && TeamInfo[playerTeam][tAttackTurfTime] < 61)
    {
        format(string256, 256, "Твоята банда ще може да прави атаки след 1 минута!");
        return SendClientMessage(playerid, 0xC800FFFF, string256);
    }
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
new bool:
    isinturf = false;
    new turftakeid;
    for (new t = 0; t < MAX_TURFS; t++)
        //for(new t; t<MAX_TURFS; t++)
    {
        if (IsPlayerInTurf(playerid, TurfInfo[t][zMinX], TurfInfo[t][zMinY], TurfInfo[t][zMaxX], TurfInfo[t][zMaxY]))
        {
            turftakeid = t;
            isinturf = true;
        }
    }
    if (isinturf == false) return SendClientMessage(playerid, COLOR_GRAD1, "Ти не се намираш в територия!");
    for (new j = 0; j < MAX_PLAYERS; j++)
    {
        if (PlayerInfo[j][pTeam] == playerTeam)
        {
            if (IsPlayerInTurf(j, TurfInfo[turftakeid][zMinX], TurfInfo[turftakeid][zMinY], TurfInfo[turftakeid][zMaxX], TurfInfo[turftakeid][zMaxY]))
            {
                if (TurfInfo[turftakeid][TurfID] <= 18)
                {
                    format(string256, 256, "Това е главната територия на {FF0000}%s и не може да се търфи.", TeamInfo[TurfInfo[turftakeid][TurfOwner]][tName]);
                    return SendClientMessage(playerid, 0xC800FFFF, string256);
                }
                if (TurfInfo[turftakeid][TurfOwner] == playerTeam)
                {
                    format(string256, 256, "Тази територия принадлежи на твоята банда/мафия.");
                    return SendClientMessage(playerid, 0xC800FFFF, string256);
                }
                if (PlayerInfo[j][pADuty] == 0)
                {
                    if (GetPlayerVirtualWorld(j) == 0)
                    {
                        //if(IsPlayerInAttackedTurf(j))
                        //{
                        GivePlayerWantedLevel(j, 1, "Атака на територия", true);
                        isTurfMember[j] = true;
                        turfid = turftakeid;
                        inTurfAttackMembers[playerTeam] += 1;
                        if (IsPlayerInAnyVehicle(j))
                        {
                            RemovePlayerFromVehicle(j);
                        }
                    }
                }
            }
        }
    }
    //turfattacked2id = turfid;
    //turfattackedfac = PlayerInfo[playerid][pTeam];
    GangZoneFlashForAll(turfid, TeamInfo[playerTeam][tTCOLOR]);
    TurfInfo[turfid][TurfWarGang] = playerTeam;
    TeamInfo[playerTeam][tTurfAttacked] = turfid;
    startturf = 1;
    new turfOwner = TurfInfo[turfid][TurfOwner];
    format(string256, 256, "[FACTION CHAT] {FF0000}%s {C800FF}стартира атака на територия %s която принадлежи на %s!", GetPlayerNickname(playerid), TurfInfo[turfid][TurfName], TeamInfo[turfOwner][tName]);
    SendFactionMessage(playerTeam, 0xC800FFFF, string256);
    format(string256, 256, "Turf War: {FF0000}%s{C800FF} атакува територията %s която принадлежи на %s!", TeamInfo[playerTeam][tName], TurfInfo[turfid][TurfName],
           TeamInfo[turfOwner][tName]);
    SendClientMessageToAll(0xC800FFFF, string256);
    isGangAttackingTurf[playerTeam] = true;
    turfAttackTimer[playerTeam] = 300;
    TeamInfo[playerTeam][tAttackTurfTime] = 35 * 60;
    for (new mi; mi < MAX_PLAYERS; mi++)
    {
        if (PlayerInfo[mi][pTeam] == turfOwner)
        {
            if (turfOwner >= 2)
            {
                GameTextForPlayer(mi, "~r~Your gang is under the attack", 5000, 3);
            }
        }
    }
    return 1;
}



CMD:checkturf(playerid, params[])
{
    new Float:x, Float:y, Float:z;
    new gangb[32];
    new bool:isinturf = false;
    for (new t = 0; t < MAX_TURFS; t++)
    {
        GetPlayerPos(playerid, x, y, z);
        if (IsPlayerInTurf(playerid, TurfInfo[t][zMinX], TurfInfo[t][zMinY], TurfInfo[t][zMaxX], TurfInfo[t][zMaxY]))
        {
            if (TurfInfo[t][TurfID] <= 18)
            {
                new stringaaaa[256];
                format(stringaaaa, 256, "Това е главната територия на {FF0000}%s", TeamInfo[TurfInfo[t][TurfOwner]][tName]);
                SendClientMessage(playerid, 0xC800FFFF, stringaaaa);
                return isinturf = true;
            }
            format(string256, sizeof(string256), "Тази територия се казва %s и принадлeжи на {FF0000}%s", TurfInfo[t][TurfName], TeamInfo[TurfInfo[t][TurfOwner]][tName]);
            SendClientMessage(playerid, 0xC800FFFF, string256);
            isinturf = true;
        }
    }
    if (isinturf == false) return SendClientMessage(playerid, COLOR_GRAD1, "Ти не се намираш на територия!");
    return 1;
}

CMD:attackers(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] < 6) return SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    new playerTeam = PlayerInfo[playerid][pTeam];
    if (TeamInfo[playerTeam][tTurfAttacked] == 0)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Твоята банда не атакува територия!");
        return 1;
    }
    format(string256, 256, "Онлайн атакуващи играчи на територията:");
    SendClientMessage(playerid, 0xC800FFFF, string256);
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerInfo[playerid][pTeam] == PlayerInfo[i][pTeam])
        {
            if (isTurfMember[i] == true)
            {
                format(string256, 256, "%s (ID: %d)", GetPlayerNickname(i), i);
                SendClientMessage(playerid, 0xFFFFFFFF, string256);
            }
        }
    }
    return 1;
}

CMD:turftime(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] < 6) return SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    if (PlayerInfo[playerid][pTeam] == FACTION_VIP || PlayerInfo[playerid][pTeam] == FACTION_INTENSE_POLICE) return SendClientMessage(playerid, 0xB4B5B7FF, "Твоята банда не може да превзема територии!");
    new playerTeam = PlayerInfo[playerid][pTeam];
    if (TeamInfo[playerTeam][tAttackTurfTime] >= 61)
    {
        format(string256, 256, "Твоята банда ще може да прави атаки след %d минути!", TeamInfo[playerTeam][tAttackTurfTime] / 60);
        return SendClientMessage(playerid, 0xC800FFFF, string256);
    }
    if (TeamInfo[playerTeam][tAttackTurfTime] > 0 && TeamInfo[playerTeam][tAttackTurfTime] < 61)
    {
        format(string256, 256, "Твоята банда ще може да прави атаки след 1 минута!");
        return SendClientMessage(playerid, 0xC800FFFF, string256);
    }
    if (TeamInfo[playerTeam][tAttackTurfTime] == 0)
    {
        SendClientMessage(playerid, 0xC800FFFF, "Твоята банда може да направи атака още сега!");
    }
    return 1;
}

CMD:fturfs(playerid, params[])
{
    if (PlayerInfo[playerid][pTeam] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в банда/мафия!");
    if (PlayerInfo[playerid][pTeam] == FACTION_VIP || PlayerInfo[playerid][pTeam] == FACTION_INTENSE_POLICE) return SendClientMessage(playerid, 0xB4B5B7FF, "Твоята банда не може да превзема територии!");
    if (TeamInfo[PlayerInfo[playerid][pTeam]][tTurfsCount] == 0) return SendClientMessage(playerid, 0xC800FFFF, "Turf War: Твоята банда/мафия не притежава нито една територия!");
    new stringgang[256];
    format(stringgang, 256, "Turf War: Твоята банда/мафия притежава %d територии!", TeamInfo[PlayerInfo[playerid][pTeam]][tTurfsCount]);
    SendClientMessage(playerid, 0xC800FFFF, stringgang);
    return 1;
}
