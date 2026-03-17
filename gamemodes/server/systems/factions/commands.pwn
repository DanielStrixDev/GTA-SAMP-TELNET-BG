CMD:nfwarn(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] < 6)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new nickname[32];
    if (sscanf(params, "s[32]", nickname))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /nfwarn [nickname]");
        return 1;
    }

    if (strlen(nickname) < 1 || strlen(nickname) > 23)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Името трябва да бъде с до 23 символа!");
        return 1;
    }

    if (!IsNicknameInDB(nickname))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не съществува играч с такъв nickname!");

    new foundPlayer = INVALID_PLAYER_ID;
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            if (strcmp(nickname, GetPlayerNickname(i), true) == 0)
            {
                foundPlayer = i;
                break;
            }
        }
    }

    if (foundPlayer != INVALID_PLAYER_ID) // Online player
    {
        if (PlayerInfo[foundPlayer][pTeam] != PlayerInfo[playerid][pTeam])
            return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е от твоята банда/мафия!");

        PlayerInfo[foundPlayer][pFWarns]++;

        new string256[256];
        format(string256, sizeof(string256), "[FACTION CHAT] %s was FACTION warned by %s [%d/5]",
               GetPlayerNickname(foundPlayer), GetPlayerNickname(playerid), PlayerInfo[foundPlayer][pFWarns]);

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
            {
                SendClientMessage(i, 0x33CCFFFF, string256);
            }
        }

        if (PlayerInfo[foundPlayer][pFWarns] >= 5)
        {
            LeaveGangPlayerAffect(foundPlayer);
        }
    }
    else // Offline player
    {
        new offlinePlayerGang = GetUserValueInt(nickname, "team");
        new offlinePlayerWarns = GetUserValueInt(nickname, "f_warns");

        if (offlinePlayerGang != PlayerInfo[playerid][pTeam])
            return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е от твоята банда/мафия!");

        offlinePlayerWarns++;

        new string256[256];
        format(string256, sizeof(string256), "[FACTION CHAT] %s was FACTION warned by %s [%d/5]",
               nickname, GetPlayerNickname(playerid), offlinePlayerWarns);

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
            {
                SendClientMessage(i, 0x33CCFFFF, string256);
            }
        }

        if (offlinePlayerWarns >= 5)
        {
            UpdatePlayerDatabaseINT("team", 0, nickname);
            UpdatePlayerDatabaseINT("f_warns", 0, nickname);
        }
        else
        {
            UpdatePlayerDatabaseINT("f_warns", offlinePlayerWarns, nickname);
        }
    }

    return 1;
}

CMD:nuninvite(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] < 6)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new nickname[32];
    if (sscanf(params, "s[32]", nickname))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /nuninvite [nickname]");
        return 1;
    }

    if (strlen(nickname) < 1 || strlen(nickname) > 23)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Името трябва да бъде с до 23 символа!");
        return 1;
    }

    if (!IsNicknameInDB(nickname))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не съществува играч с такъв nickname!");

    if (strcmp(nickname, GetPlayerNickname(playerid), true) == 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да изгониш себе си от банда/мафията!");

    new foundPlayer = INVALID_PLAYER_ID;
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            if (strcmp(nickname, GetPlayerNickname(i), true) == 0)
            {
                foundPlayer = i;
                break;
            }
        }
    }

    if (foundPlayer != INVALID_PLAYER_ID) // Online player
    {
        if (PlayerInfo[foundPlayer][pRank] >= 6)
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да изгониш лидер от твоята банда/мафия!");

        if (PlayerInfo[foundPlayer][pTeam] != PlayerInfo[playerid][pTeam])
            return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е от твоята банда/мафия!");

        new string256[256];
        format(string256, sizeof(string256), "[FACTION CHAT] %s изгони %s от %s!",
               GetPlayerNickname(playerid), GetPlayerNickname(foundPlayer), TeamInfo[PlayerInfo[playerid][pTeam]][tName]);

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
            {
                SendClientMessage(i, 0x33CCFFFF, string256);
            }
        }

        LeaveGangPlayerAffect(foundPlayer);
    }
    else // Offline player
    {
        new offlinePlayerGang = GetUserValueInt(nickname, "pTeam");
        if (offlinePlayerGang != PlayerInfo[playerid][pTeam])
            return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е от твоята банда/мафия!");

        new string256[256];
        format(string256, sizeof(string256), "[FACTION CHAT] %s изгони %s от %s!",
               GetPlayerNickname(playerid), nickname, TeamInfo[PlayerInfo[playerid][pTeam]][tName]);

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
            {
                SendClientMessage(i, 0x33CCFFFF, string256);
            }
        }

        UpdatePlayerDatabaseINT("team", 0, nickname);
        UpdatePlayerDatabaseINT("f_warns", 0, nickname);
    }

    return 1;
}
CMD:uninvite(playerid, params[])
{
    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /uninvite [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pRank] < 6)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pRank] > 5 && PlayerInfo[playerid][pGLeader] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да изгониш лидер!");
        return CMD_SUCCESS;
    }

    if (targetid == playerid)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да изгониш себе си!");
        return CMD_SUCCESS;
    }

    if (isTurfMember[targetid])
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да изгониш играч, който е в атака на територия!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pTeam] == PlayerInfo[playerid][pTeam])
    {
        new string256[256];
        format(string256, sizeof(string256), "[FACTION CHAT] %s изгони %s от %s!", GetPlayerNickname(playerid), GetPlayerNickname(targetid), TeamInfo[PlayerInfo[playerid][pTeam]][tName]);

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
            {
                SendClientMessage(i, 0x33CCFFFF, string256);
            }
        }
        LeaveGangPlayerAffect(targetid);
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Човекът, който искаш да изгониш не е от твоята банда/мафия!");
    }

    return CMD_SUCCESS;
}

CMD:cinvite(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] != 6)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /cinvite [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (TeamInvite[targetid] != PlayerInfo[playerid][pTeam])
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този човек няма покана от теб за влизане в банда/мафия!");

    TeamInvite[targetid] = -1;

    new string115[115];
    format(string115, sizeof(string115), "[FACTION CHAT] %s отказа поканата до %s да влезе в твоята банда/мафия.", GetPlayerNickname(playerid), GetPlayerNickname(targetid));

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            SendClientMessage(i, 0x33CCFFFF, string115);
        }
    }

    format(string115, sizeof(string115), "%s отказа поканата си да влезеш в %s.", GetPlayerNickname(playerid), TeamInfo[PlayerInfo[playerid][pTeam]][tName]);
    SendClientMessage(targetid, 0x33CCFFFF, string115);

    return 1;
}

CMD:invite(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] != 6)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /invite [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (PlayerInfo[targetid][pTeam] >= 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този човек вече има банда/мафия!");

    TeamInvite[targetid] = PlayerInfo[playerid][pTeam];

    new string115[115];
    format(string115, sizeof(string115), "[FACTION CHAT] %s покани %s да влезе в твоята банда/мафия.", GetPlayerNickname(playerid), GetPlayerNickname(targetid));

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            SendClientMessage(i, 0x33CCFFFF, string115);
        }
    }

    format(string115, sizeof(string115), "%s те покани да влезеш в банда/мафия %s", GetPlayerNickname(playerid), TeamInfo[PlayerInfo[playerid][pTeam]][tName]);
    SendClientMessage(targetid, 0x33CCFFFF, string115);
    SendClientMessage(targetid, 0x33CCFFFF, "Напиши /acceptfaction(/af) за да влезеш или /cancelfaction(/cf) за да откажеш!");

    return 1;
}

CMD:fhelp(playerid, params[])
{
    new string2230[512];
    new string2230result[1500];
    format(string2230, 512, "{00FF00}---Команди за банда/мафия---\n\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}/acceptfaction(/af) - приемате покана\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}/cancelfaction(/cf) - отказвате покана\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}/faction(/f) - пишете в чата на банда/мафията\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}/leavefaction - напускате бандата\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}/members - показва онлайн играчите от вашата банда/мафия\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}/fturfs - показва кои и колко територии притежава твоята банда/мафия\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}/fignore - за да игнорираш някой да не му виждаш съобщенията във FACTION чата\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}/funignore - за да премахнеш игнорирането на играч и да му виждаш съобщенията във FACTION чата\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}/factioncommands(/fcmds) - показва командите, които са само за определа банда/мафия\n");
    strcat(string2230result, string2230);
    ShowPlayerDialog(playerid, 9, DIALOG_STYLE_MSGBOX, "{33CCFF}FACTION HELP", string2230result, "Други", "Затвори");
    return 1;
}

CMD:frespawn(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] < 6)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }
    if (PlayerInfo[playerid][pTeam] == FACTION_VIP)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isVipGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_GROVE)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isGroveGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_BALLAS)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isBallasGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_VAGOS)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isVagosGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_AZTECAS)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isAztecasGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_CRIPZ)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isCripzGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_TRIADS)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isTriadsGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_RIFA)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isRifaGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_SOA)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isSoaGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_NANG)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isNangGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_ITALIAN)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isItalianGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_BOUNTY)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isBountyGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_THUGLIFE)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isThugLifeGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_CREW)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isCrewGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_INTENSE_POLICE)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isIntensePDGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_SOLDIER)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isSoldierGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_YAKUZA)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isYakuzaGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_SYNDICATE)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isSyndicateGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_BLOODMAFIA)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isBloodMafiaGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_MS13)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isMS13GangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_BGMAFIA)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isBGMafiaGangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_343)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (is343GangVeh[cars] == true)
            {
                SetVehicleToRespawn(cars);
            }
        }
    }
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            format(string256, 256, "[FACTION CHAT] All Vehicles has been respawned by %s", GetPlayerNickname(playerid));
            SendClientMessage(i, 0x33CCFFFF, string256);
        }
    }
    return 1;
}
CMD:frefuel(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] < 6)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }
    if (PlayerInfo[playerid][pTeam] == FACTION_VIP)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isVipGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_GROVE)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isGroveGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_BALLAS)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isBallasGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_VAGOS)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isVagosGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_AZTECAS)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isAztecasGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_CRIPZ)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isCripzGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_TRIADS)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isTriadsGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_RIFA)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isRifaGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_SOA)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isSoaGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_NANG)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isNangGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_ITALIAN)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isItalianGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_BOUNTY)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isBountyGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_THUGLIFE)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isThugLifeGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_CREW)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isCrewGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_INTENSE_POLICE)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isIntensePDGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_SOLDIER)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isSoldierGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_YAKUZA)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isYakuzaGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_SYNDICATE)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isSyndicateGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_BLOODMAFIA)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isBloodMafiaGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_MS13)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isMS13GangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_BGMAFIA)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (isBGMafiaGangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    else if (PlayerInfo[playerid][pTeam] == FACTION_343)
    {
        for (new cars = 0; cars < MAX_VEHICLES; cars++)
        {
            if (is343GangVeh[cars] == true)
            {
                vehfuel[cars] = 100;
            }
        }
    }
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            format(string256, 256, "[FACTION CHAT] %s зареди всички превозни средства със 100 литра бензин!", GetPlayerNickname(playerid));
            SendClientMessage(i, 0x33CCFFFF, string256);
        }
    }
    return 1;
}

CMD:setrankname(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] <= 5 || PlayerInfo[playerid][pTeam] <= 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new rankid, rankname[256];
    if (sscanf(params, "is[256]", rankid, rankname))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /setrankname [1-6] [name]");
        return CMD_SUCCESS;
    }

    if (rankid < 1 || rankid > 6)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Невалиден ранк!");
        return CMD_SUCCESS;
    }

    if (strlen(rankname) < 1 || strlen(rankname) > 25)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Символите трябва да бъдат между 1 и 25 знака!");
        return CMD_SUCCESS;
    }

    if (strfind(rankname, "||", true) != -1 || strfind(rankname, "|", true) != -1 ||
            strfind(rankname, "~", true) != -1 || strfind(rankname, ",", true) != -1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не можеш да използваш забранени символи!");
        return CMD_SUCCESS;
    }

    new faction = PlayerInfo[playerid][pTeam];
    new string256[256];

    switch (rankid)
    {
        case 1:
        {
            format(string256, sizeof(string256), "[FACTION CHAT] %s промени името на ранк: %d(%s) на: %s",
                   GetPlayerNickname(playerid), rankid, TeamInfo[faction][tRank1], rankname);

            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                if (PlayerInfo[i][pTeam] == faction)
                {
                    SendClientMessage(i, 0x33CCFFFF, string256);
                }
            }
            format(TeamInfo[faction][tRank1], 256, "%s", rankname);
        }
        case 2:
        {
            format(string256, sizeof(string256), "[FACTION CHAT] %s промени името на ранк: %d(%s) на: %s",
                   GetPlayerNickname(playerid), rankid, TeamInfo[faction][tRank2], rankname);

            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                if (PlayerInfo[i][pTeam] == faction)
                {
                    SendClientMessage(i, 0x33CCFFFF, string256);
                }
            }
            format(TeamInfo[faction][tRank2], 256, "%s", rankname);
        }
        case 3:
        {
            format(string256, sizeof(string256), "[FACTION CHAT] %s промени името на ранк: %d(%s) на: %s",
                   GetPlayerNickname(playerid), rankid, TeamInfo[faction][tRank3], rankname);

            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                if (PlayerInfo[i][pTeam] == faction)
                {
                    SendClientMessage(i, 0x33CCFFFF, string256);
                }
            }
            format(TeamInfo[faction][tRank3], 256, "%s", rankname);
        }
        case 4:
        {
            format(string256, sizeof(string256), "[FACTION CHAT] %s промени името на ранк: %d(%s) на: %s",
                   GetPlayerNickname(playerid), rankid, TeamInfo[faction][tRank4], rankname);

            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                if (PlayerInfo[i][pTeam] == faction)
                {
                    SendClientMessage(i, 0x33CCFFFF, string256);
                }
            }
            format(TeamInfo[faction][tRank4], 256, "%s", rankname);
        }
        case 5:
        {
            format(string256, sizeof(string256), "[FACTION CHAT] %s промени името на ранк: %d(%s) на: %s",
                   GetPlayerNickname(playerid), rankid, TeamInfo[faction][tRank5], rankname);

            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                if (PlayerInfo[i][pTeam] == faction)
                {
                    SendClientMessage(i, 0x33CCFFFF, string256);
                }
            }
            format(TeamInfo[faction][tRank5], 256, "%s", rankname);
        }
        case 6:
        {
            format(string256, sizeof(string256), "[FACTION CHAT] %s промени името на ранк: %d(%s) на: %s",
                   GetPlayerNickname(playerid), rankid, TeamInfo[faction][tRank6], rankname);

            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                if (PlayerInfo[i][pTeam] == faction)
                {
                    SendClientMessage(i, 0x33CCFFFF, string256);
                }
            }
            format(TeamInfo[faction][tRank6], 256, "%s", rankname);
        }
    }

    SaveFaction(faction);
    return CMD_SUCCESS;
}

CMD:setrank(playerid, params[])
{
    new targetid, level2;
    if (sscanf(params, "ui", targetid, level2))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /setrank [playerid] [rank]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е онлайн!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pRank] < 6)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си лидер!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pTeam] != PlayerInfo[playerid][pTeam])
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е от твоята банда/мафия!");
        return CMD_SUCCESS;
    }

    if (targetid == playerid)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да смениш своя ранк!");
        return CMD_SUCCESS;
    }

    if (level2 < 1 || level2 > 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ранковете са от 1 до 5!");
        return CMD_SUCCESS;
    }

    // Get current rank name
    new ranktext[256];
    new faction = PlayerInfo[targetid][pTeam];
    new currentRank = PlayerInfo[targetid][pRank];

    switch (currentRank)
    {
        case 1: format(ranktext, sizeof(ranktext), "%s", TeamInfo[faction][tRank1]);
        case 2: format(ranktext, sizeof(ranktext), "%s", TeamInfo[faction][tRank2]);
        case 3: format(ranktext, sizeof(ranktext), "%s", TeamInfo[faction][tRank3]);
        case 4: format(ranktext, sizeof(ranktext), "%s", TeamInfo[faction][tRank4]);
        case 5: format(ranktext, sizeof(ranktext), "%s", TeamInfo[faction][tRank5]);
        case 6: format(ranktext, sizeof(ranktext), "%s", TeamInfo[faction][tRank6]);
    }

    // Set new rank
    PlayerInfo[targetid][pRank] = level2;

    // Send messages
    new string256[256];
    format(string256, sizeof(string256), "%s промени твоят ранк на %s(%d)", GetPlayerNickname(playerid), ranktext, level2);
    SendClientMessage(targetid, 0x33CCFFFF, string256);

    format(string256, sizeof(string256), "[FACTION CHAT] %s промени ранка на %s на %s(%d)", GetPlayerNickname(playerid), GetPlayerNickname(targetid), ranktext, level2);

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            SendClientMessage(i, 0x33CCFFFF, string256);
        }
    }

    RestartPlayerSkin(targetid);
    return CMD_SUCCESS;
}
CMD:factioncommands(playerid, params[])
{
    if (PlayerInfo[playerid][pTeam] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в банда/мафия!");
    }
    if (PlayerInfo[playerid][pTeam] == 15)
    {
        SendClientMessage(playerid, COLOR_IPD_CHAT, "Intense Police Department: {FFFFFF}/hideipd /showdf /specialforce /unspecialforce /dfrules /dfcars /mdc /mdcshow");
        SendClientMessage(playerid, COLOR_IPD_CHAT, "Intense Police Department: {FFFFFF}/deltaforce /undeltaforce /mdchide");
    }
    if (PlayerInfo[playerid][pTeam] == 1)
    {
        SendClientMessage(playerid, 0xFF4500FF, "VIP: {FFFFFF}/ls /lv /vipbase");
        SendClientMessage(playerid, 0xFF4500FF, "VIP Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == 2)
    {
        SendClientMessage(playerid, 0x33AA33FF, "Grove Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == 3)
    {
        SendClientMessage(playerid, 0xBC73DEFF, "Ballas Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == 4)
    {
        SendClientMessage(playerid, 0xDFEF1FFF, "Vagos Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == 5)
    {
        SendClientMessage(playerid, 0x00BFFFAA, "Aztecas Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == 6)
    {
        SendClientMessage(playerid, 0x0000CCFF, "Cripz Leader: {FFFFFF}/frefuel /frespawn");
    }
    //<--------------------------------->
    if (PlayerInfo[playerid][pTeam] == 7)
    {
        SendClientMessage(playerid, 0xF97804FF, "Triads Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == 8)
    {
        SendClientMessage(playerid, COLOR_STREETRACE, "Rifa Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == 9)
    {
        SendClientMessage(playerid, 0x7F7F7FFF, "Soa Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == 10)
    {
        SendClientMessage(playerid, 0x4D2C2FFF, "Da Nang Boys Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == 11)
    {
        SendClientMessage(playerid, 0xA9F5E1FF, "Italian Mafia Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == 12)
    {
        SendClientMessage(playerid, 0x8ADB3FFF, "Bounty Hunters Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == 13)
    {
        SendClientMessage(playerid, 0x0040FFFF, "LSPD Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == FACTION_CREW)
    {
        SendClientMessage(playerid, COLOR_R116ST, "116th Street Crew Leader: {FFFFFF}/frefuel /frespawn");
    }
    //<--------------------------------->
    if (PlayerInfo[playerid][pTeam] == FACTION_INTENSE_POLICE)
    {
        SendClientMessage(playerid, COLOR_IPD_CHAT, "Intense Police Department Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == FACTION_SOLDIER)
    {
        SendClientMessage(playerid, COLOR_RSOLDIER, "Soldier Boys Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == FACTION_YAKUZA)
    {
        SendClientMessage(playerid, COLOR_RYAKUZA, "Yakuza Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == FACTION_SYNDICATE)
    {
        SendClientMessage(playerid, COLOR_RSYNDICATE, "Syndicate Texas Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == FACTION_BLOODMAFIA)
    {
        SendClientMessage(playerid, COLOR_RBLOODMAFIA, "Blood Mafia Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == FACTION_MS13)
    {
        SendClientMessage(playerid, COLOR_RMS13, "Mara Salvatrucha 13 Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == FACTION_BGMAFIA)
    {
        SendClientMessage(playerid, COLOR_RBGM, "Bulgarian Mafia Leader: {FFFFFF}/frefuel /frespawn");
    }
    if (PlayerInfo[playerid][pTeam] == FACTION_343)
    {
        SendClientMessage(playerid, COLOR_R343, "343 Black Street Avenue Leader: {FFFFFF}/frefuel /frespawn");
    }
    return 1;
}
CMD:fcmds(playerid, params[]) return cmd_factioncommands(playerid, params);

CMD:ls(playerid, params[])
{
    if (PlayerInfo[playerid][pTeam] != 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си от VIP за да използваш тази команда!");
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
    if (GetPlayerVehicleID(playerid) != 0 && spawned[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си пешеходец за да се телепортираш!");
    if (cmn1[playerid] > 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си CMN1!");
    }
    if (playerInDuel[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в дуел!");
    }
    if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в евент!");
    if (playerInDMON[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в DMON!");
    }
    if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    new Float:pHealth;
    GetPlayerHealth(playerid, pHealth);
    new Float:pArmour;
    GetPlayerArmour(playerid, pArmour);
    if (pHealth <= 99 && pArmour <= 99)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш 100 кръв и 100 жилетка за да се телепортираш!");
        return 1;
    }
    SendClientMessage(playerid, 0xFF3737FF, "VIP: Ти се телепортира в Los Santos");
    SetPlayerPos(playerid, 1537.7205, -1691.0510, 13.5469);
    SetPlayerFacingAngle(playerid, 90.5010);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetCameraBehindPlayer(playerid);
    return 1;
}
CMD:lv(playerid, params[])
{
    if (PlayerInfo[playerid][pTeam] != 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си от VIP за да използваш тази команда!");
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
    if (GetPlayerVehicleID(playerid) != 0 && spawned[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си пешеходец за да се телепортираш!");
    if (cmn1[playerid] > 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си CMN1!");
    }
    if (playerInDuel[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в дуел!");
    }
    if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в евент!");
    if (playerInDMON[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в DMON!");
    }
    if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    new Float:pHealth;
    GetPlayerHealth(playerid, pHealth);
    new Float:pArmour;
    GetPlayerArmour(playerid, pArmour);
    if (pHealth <= 99 && pArmour <= 99)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш 100 кръв и 100 жилетка за да се телепортираш!");
        return 1;
    }
    SendClientMessage(playerid, 0xFF3737FF, "VIP: Ти се телепортира в Las Venturas");
    SetPlayerPos(playerid, 1699.6941, 1434.8165, 10.6869);
    SetPlayerFacingAngle(playerid, 272.8860);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetCameraBehindPlayer(playerid);
    return 1;
}
CMD:vipbase(playerid, params[])
{
    if (PlayerInfo[playerid][pTeam] != 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си от VIP за да използваш тази команда!");
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
    if (GetPlayerVehicleID(playerid) != 0 && spawned[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си пешеходец за да се телепортираш!");
    if (cmn1[playerid] > 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си CMN1!");
    }
    if (playerInDuel[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в дуел!");
    }
    if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в евент!");
    if (playerInDMON[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в DMON!");
    }
    if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    new Float:pHealth;
    GetPlayerHealth(playerid, pHealth);
    new Float:pArmour;
    GetPlayerArmour(playerid, pArmour);
    if (pHealth <= 99 && pArmour <= 99)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш 100 кръв и 100 жилетка за да се телепортираш!");
        return 1;
    }
    SendClientMessage(playerid, 0xFF3737FF, "VIP: Ти се телепортира в базата");
    SetPlayerPos(playerid, 1252.4546, -2032.9832, 59.6335);
    SetPlayerFacingAngle(playerid, 269.6020);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetCameraBehindPlayer(playerid);
    return 1;
}

CMD:invisible(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] >= 3 || CheckFreeVIP() == 1)
    {
        if (isTurfMember[playerid] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да бъдеш невидим, докато нападаш територия!");
        }
        if (cmn1[playerid] > 0)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да бъдеш невидим, докато си CMN1!");
        }
        if (playerInDuel[playerid] > 0)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да бъдеш невидим, докато си Duel!");
        }
        if (inevent[playerid] == 1 && einvisible == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Командата /invisible е забранена в евента!");
        if (PlayerInfo[playerid][pInvisible] == 0)
        {
            SetPlayerColor(playerid, 0xFFFFFF00);
            SendClientMessage(playerid, 0xFFFFFFFF, "Ти вече си невидим на картата.");
        }
        else
        {
            RestartPlayerColor(playerid);
            SendClientMessage(playerid, 0xFFFFFFFF, "Ти вече си видим на картата.");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    }
    return 1;
}
CMD:visible(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] >= 3 || CheckFreeVIP() == 1)
    {
        if (PlayerInfo[playerid][pInvisible] == 1)
        {
            PlayerInfo[playerid][pInvisible] = 0;
            RestartPlayerColor(playerid);
            SendClientMessage(playerid, 0xFFFFFFFF, "You are now visible on the map.");
        }
        else
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "You are already visible!");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "You don't have enough VIP privileges to use this command!");
    }
    return 1;
}

CMD:showdf(playerid, params[])
{
    if (PlayerInfo[playerid][pTeam] == 15 && PlayerInfo[playerid][pRank] == 6)
    {
        if (hideIPD == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Intense Police Department вече е на видим режим!");
        format(string256, 256, "[FACTION CHAT] %s превключи Police Departement на видим режим!", GetPlayerNickname(playerid));
        hideIPD = 0;
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
            {
                SendClientMessage(i, 0x33CCFFFF, string256);
            }
        }
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pTeam] == 15)
            {
                RestartPlayerColor(i);
            }
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си лидер на Intense Police Department!");
    }
    return 1;
}

CMD:fmuted(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] == 6 && PlayerInfo[playerid][pTeam] > 0)
    {
        SendClientMessage(playerid, 0x40BF00FF, "Онлайн заглушени играчи в твоята банда/мафия:");
        new muted = 0;
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pFMuted] > 0 && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
            {
                format(string256, 256, "%s (ID:%d)", GetPlayerNickname(i), i);
                muted = 1;
            }
        }
        if (muted == 0) SendClientMessage(playerid, 0xE60000FF, "Няма онлайн заглушени играчи във FACTION чата.");
        else SendClientMessage(playerid, 0xFFFFFFFF, string256);
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:checkfwarn(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] < 6)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /checkfwarn [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pTeam] != PlayerInfo[targetid][pTeam])
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е от твоята банда/мафия!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pFWarns] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч няма нито едно FACTION предупреждение!");
        return CMD_SUCCESS;
    }

    new string2562[256];
    format(string2562, sizeof(string2562), "%s има %d FACTION предупреждения", GetPlayerNickname(targetid), PlayerInfo[targetid][pFWarns]);
    SendClientMessage(playerid, 0x33CCFFFF, string2562);

    return CMD_SUCCESS;
}

CMD:checktogf(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] < 6)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /checktogf [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pTeam] != PlayerInfo[targetid][pTeam])
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Този играч не е от твоята банда/мафия!");
        return CMD_SUCCESS;
    }

    new stringFaction[256];
    if (PlayerInfo[targetid][pTogFaction] == 0)
    {
        format(stringFaction, sizeof(stringFaction), "%s в момента вижда FACTION чата!", GetPlayerNickname(targetid));
    }
    else
    {
        format(stringFaction, sizeof(stringFaction), "%s в момента не вижда FACTION чата!", GetPlayerNickname(targetid));
    }
    SendClientMessage(playerid, 0x33CCFFFF, stringFaction);

    return CMD_SUCCESS;
}

CMD:ismember(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] < 6)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /ismember [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pTeam] == PlayerInfo[targetid][pTeam])
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Този играч е от твоята банда/мафия!");
    }
    else
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Този играч не е от твоята банда/мафия!");
    }

    return CMD_SUCCESS;
}

CMD:funmute(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] < 6)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /factionunmute(/funmute) [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pTeam] != PlayerInfo[targetid][pTeam])
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този играч не е от твоята банда/мафия!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pFMuted] == 0)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този играч не е заглушен в FACTION чата!");
        return CMD_SUCCESS;
    }

    PlayerInfo[targetid][pFMuted] = 0;

    new string256[256];
    format(string256, sizeof(string256), "[FACTION CHAT] %s was FACTION unmuted by %s", GetPlayerNickname(targetid), GetPlayerNickname(playerid));

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            SendClientMessage(i, 0x33CCFFFF, string256);
        }
    }

    return CMD_SUCCESS;
}

CMD:factionunmute(playerid, params[]) return cmd_funmute(playerid, params);
//
CMD:ftmute(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] < 6)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid, timeMinutes, reason[256];
    if (sscanf(params, "uis[256]", targetid, timeMinutes, reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /factiontimemute(/ftmute) [playerid] [time] [reason]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (timeMinutes < 1 || timeMinutes > 1000)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Трябва минутите да бъдат между 1 и 1000!");
        return CMD_SUCCESS;
    }

    if (isnull(reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /factiontimemute(/ftmute) [playerid] [time] [reason]");
        return CMD_SUCCESS;
    }

    PlayerInfo[targetid][pFMuted] = timeMinutes;

    new string256[256];
    format(string256, sizeof(string256), "[FACTION CHAT] %s was FACTION muted by %s for %d minutes. [Reason: %s]", GetPlayerNickname(targetid), GetPlayerNickname(playerid), timeMinutes, reason);

    new playerTeam = PlayerInfo[playerid][pTeam];
    SendFactionMessage(playerTeam, 0x33CCFFFF, string256);

    return CMD_SUCCESS;
}

CMD:factiontimemute(playerid, params[]) return cmd_ftmute(playerid, params);

CMD:fmute(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] < 6)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Ти не си лидер!");
        return CMD_SUCCESS;
    }

    new targetid, reason[256];
    if (sscanf(params, "us[256]", targetid, reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /factionmute(/fmute) [playerid] [reason]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pTeam] != PlayerInfo[targetid][pTeam])
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този играч не е от твоята банда/мафия!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pFMuted] != 0)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този играч вече е заглушен в FACTION чата!");
        return CMD_SUCCESS;
    }

    // Mute the player (1000000 seconds = very long mute)
    PlayerInfo[targetid][pFMuted] = 1000000;

    // Send notification to all faction members
    new string256[256];
    format(string256, sizeof(string256), "[FACTION CHAT] %s was FACTION muted by %s [Reason: %s]", GetPlayerNickname(targetid), GetPlayerNickname(playerid), reason);

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            SendClientMessage(i, 0x33CCFFFF, string256);
        }
    }

    return CMD_SUCCESS;
}

CMD:factionmute(playerid, params[]) return cmd_fmute(playerid, params);

CMD:fmuteall(playerid, params[])
{
    if (PlayerInfo[playerid][pTeam] != 0 && PlayerInfo[playerid][pRank] == 6)
    {
        if (TeamInfo[PlayerInfo[playerid][pTeam]][tMute] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Всички играчи в твоята банда вече са заглушени!");
        format(string256, 256, "[FACTION CHAT] All players were FACTION muted by %s!", GetPlayerNickname(playerid));
        TeamInfo[PlayerInfo[playerid][pTeam]][tMute] = 1;
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
            {
                SendClientMessage(i, 0x33CCFFFF, string256);
            }
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си лидер!");
    }
    return 1;
}
CMD:factionmuteall(playerid, params[]) return cmd_fmuteall(playerid, params);


CMD:funmuteall(playerid, params[])
{
    if (PlayerInfo[playerid][pTeam] != 0 && PlayerInfo[playerid][pRank] == 6)
    {
        if (TeamInfo[PlayerInfo[playerid][pTeam]][tMute] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Всички играчи в твоята банда вече са отглушени!");
        format(string256, 256, "[FACTION CHAT] All players were FACTION unmuted by %s!", GetPlayerNickname(playerid));
        TeamInfo[PlayerInfo[playerid][pTeam]][tMute] = 0;
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
            {
                SendClientMessage(i, 0x33CCFFFF, string256);
                PlayerInfo[i][pFMuted] = 0;
            }
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си лидер!");
    }
    return 1;
}
CMD:factionunmuteall(playerid, params[]) return cmd_funmuteall(playerid, params);

CMD:hideipd(playerid, params[])
{
    if (PlayerInfo[playerid][pTeam] == 15 && PlayerInfo[playerid][pRank] == 6)
    {
        if (hideIPD == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Intense Police Department вече е на невидим режим!");
        hideIPD = 1;
        format(string256, 256, "[FACTION CHAT] %s превключи Intense Police Department на невидим режим!", GetPlayerNickname(playerid));
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
            {
                SendClientMessage(i, 0x33CCFFFF, string256);
            }
        }
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pTeam] == 15 && playerInDuel[i] == 0 && cmn1[i] == 0)
            {
                SetPlayerColor(i, 0xFFFFFF00); //gethere
            }
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си лидер на Intense Police Department!");
    }
    return 1;
}

CMD:lc(playerid, params[])
{
    if (PlayerInfo[playerid][pTeam] < 1 || PlayerInfo[playerid][pRank] != 6)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new message[128];
    if (sscanf(params, "s[128]", message))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /lc [text]");
        return 1;
    }

    if (PlayerInfo[playerid][pMuted] != 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си заглушен в чата!");
        return 1;
    }

    new rankText[64];
    switch (PlayerInfo[playerid][pRank])
    {
        case 1: format(rankText, sizeof(rankText), "%s", TeamInfo[PlayerInfo[playerid][pTeam]][tRank1]);
        case 2: format(rankText, sizeof(rankText), "%s", TeamInfo[PlayerInfo[playerid][pTeam]][tRank2]);
        case 3: format(rankText, sizeof(rankText), "%s", TeamInfo[PlayerInfo[playerid][pTeam]][tRank3]);
        case 4: format(rankText, sizeof(rankText), "%s", TeamInfo[PlayerInfo[playerid][pTeam]][tRank4]);
        case 5: format(rankText, sizeof(rankText), "%s", TeamInfo[PlayerInfo[playerid][pTeam]][tRank5]);
        case 6: format(rankText, sizeof(rankText), "%s", TeamInfo[PlayerInfo[playerid][pTeam]][tRank6]);
    }

    new leaderMessage[256];
    format(leaderMessage, sizeof(leaderMessage), "[LEADER CHAT] %s на [%s]: %s",
           GetPlayerNickname(playerid), TeamInfo[PlayerInfo[playerid][pTeam]][tName], message);

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) &&
                PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam] &&
                PlayerInfo[i][pRank] == 6 &&
                PlayerInfo[i][pTogLeader] == 0)
        {
            SendClientMessage(i, 0xD9CCC8FF, leaderMessage);
        }
    }

    return 1;
}

CMD:f(playerid, params[])
{
    if (PlayerInfo[playerid][pTeam] < 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в банда/мафия!");
        return 1;
    }

    new message[128];
    if (sscanf(params, "s[128]", message))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: (/f)action [text]");
        return 1;
    }

    if (PlayerInfo[playerid][pFMuted] != 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си заглушен във FACTION CHAT!");
        return 1;
    }

    if (TeamInfo[PlayerInfo[playerid][pTeam]][tMute] == 1 && PlayerInfo[playerid][pRank] != 6)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си заглушен във FACTION CHAT!");
        return 1;
    }

    new rankText[64];
    switch (PlayerInfo[playerid][pRank])
    {
        case 1: format(rankText, sizeof(rankText), "%s", TeamInfo[PlayerInfo[playerid][pTeam]][tRank1]);
        case 2: format(rankText, sizeof(rankText), "%s", TeamInfo[PlayerInfo[playerid][pTeam]][tRank2]);
        case 3: format(rankText, sizeof(rankText), "%s", TeamInfo[PlayerInfo[playerid][pTeam]][tRank3]);
        case 4: format(rankText, sizeof(rankText), "%s", TeamInfo[PlayerInfo[playerid][pTeam]][tRank4]);
        case 5: format(rankText, sizeof(rankText), "%s", TeamInfo[PlayerInfo[playerid][pTeam]][tRank5]);
        case 6: format(rankText, sizeof(rankText), "%s", TeamInfo[PlayerInfo[playerid][pTeam]][tRank6]);
    }

    // Special ranks for police factions
    if (PlayerInfo[playerid][pTeam] == FACTION_INTENSE_POLICE)
    {
        if (PlayerInfo[playerid][pSpecialForce])
        {
            format(rankText, sizeof(rankText), "SWAT");
        }
        else if (PlayerInfo[playerid][pDeltaForce])
        {
            format(rankText, sizeof(rankText), "Военен");
        }
    }

    new factionMessage[256];
    format(factionMessage, sizeof(factionMessage), "[FACTION CHAT] %s(%d) %s(ID:%d): %s",
           rankText, PlayerInfo[playerid][pRank], GetPlayerNickname(playerid), playerid, message);

    SendFMessage(playerid, factionMessage);

    return 1;
}
CMD:faction(playerid, params[]) return cmd_f(playerid, params);

CMD:members(playerid, params[])
{
    if (PlayerInfo[playerid][pTeam] != 0)
    {
        new string2300[2300], str[256];
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
            {
                new ranktext[64];
                switch (PlayerInfo[i][pRank])
                {
                    case 1: format(ranktext, sizeof(ranktext), "%s", TeamInfo[PlayerInfo[i][pTeam]][tRank1]);
                    case 2: format(ranktext, sizeof(ranktext), "%s", TeamInfo[PlayerInfo[i][pTeam]][tRank2]);
                    case 3: format(ranktext, sizeof(ranktext), "%s", TeamInfo[PlayerInfo[i][pTeam]][tRank3]);
                    case 4: format(ranktext, sizeof(ranktext), "%s", TeamInfo[PlayerInfo[i][pTeam]][tRank4]);
                    case 5: format(ranktext, sizeof(ranktext), "%s", TeamInfo[PlayerInfo[i][pTeam]][tRank5]);
                    case 6: format(ranktext, sizeof(ranktext), "%s", TeamInfo[PlayerInfo[i][pTeam]][tRank6]);
                }

                if (PlayerInfo[i][pRank] < 6)
                {
                    format(str, sizeof(str), "{33CCFF}%s (ID: %d){FFFFFF} - Rank: %s(%d)\n",
                           GetPlayerNickname(i), i, ranktext, PlayerInfo[i][pRank]);
                    strcat(string2300, str);
                }
                else if (PlayerInfo[i][pRank] == 6 && PlayerInfo[i][pGLeader] == 0)
                {
                    format(str, sizeof(str), "{FF8200}Лидер:{33CCFF} %s (ID: %d) - %s(%d)\n",
                           GetPlayerNickname(i), i, ranktext, PlayerInfo[i][pRank]);
                    strcat(string2300, str);
                }
                else if (PlayerInfo[i][pRank] == 6 && PlayerInfo[i][pGLeader] == 1)
                {
                    format(str, sizeof(str), "{FF0000}Главен лидер:{33CCFF} %s (ID: %d) - %s(%d)\n",
                           GetPlayerNickname(i), i, ranktext, PlayerInfo[i][pRank]);
                    strcat(string2300, str);
                }
            }
        }

        ShowPlayerDialog(playerid, 3001, DIALOG_STYLE_MSGBOX, "{FFFF00}Членове на твоята банда/мафия", string2300, "Изход", "");
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в банда/мафия!");
    }
    return 1;
}


CMD:leaders(playerid, params[])
{
    new onlineleaders2 = 0;
    new leadersText[1500]; // Holds the formatted text for the dialog
    new string256[256];

    // Count online leaders
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            if (PlayerInfo[i][pRank] == 6)
            {
                onlineleaders2 += 1;
            }
        }
    }

    format(string256, sizeof(string256), "Онлайн лидери на банди/мафии (%d):", onlineleaders2);

    // Prepare the dialog string with the leaders information
    new onlineleaders = 0;
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerInfo[i][pRank] == 6)
        {
            onlineleaders = 1;
            new teamName[65];
            format(teamName, 65, "%s", TeamInfo[PlayerInfo[i][pTeam]][tName]);
            if (PlayerInfo[i][pGLeader] == 1)
            {
                format(string256, sizeof(string256), "{33CCFF}Главен лидер: %s на банда/мафия - {00FF00}%s\n", GetPlayerNickname(i), teamName);
                strcat(leadersText, string256);
            }
            if (PlayerInfo[i][pGLeader] == 0)
            {
                format(string256, sizeof(string256), "{33CCFF}Лидер: %s на банда/мафия - {00FF00}%s\n", GetPlayerNickname(i), teamName);
                strcat(leadersText, string256);
            }
        }
    }

    new dialogclosestring[256];
    new closeddialog = 3501; // Dialog ID for leaders
    format(dialogclosestring, sizeof(dialogclosestring), "Онлайн лидери на банди/мафии (%d):", onlineleaders2);

    if (onlineleaders > 0)
    {
        ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, dialogclosestring, leadersText, "Затвори", "");
    }
    else
    {
        ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, dialogclosestring, "{E60000}Няма онлайн лидери в момента!", "Затвори", "");
    }

    return 1;
}




CMD:nunfwarn(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] != 6)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new targetName[MAX_PLAYER_NAME];
    if (sscanf(params, "s[24]", targetName))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /nunfwarn [nickname]");
        return 1;
    }

    if (strlen(targetName) < 1 || strlen(targetName) > 30)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Името трябва да бъде с до 30 символа!");
        return 1;
    }

    if (!IsNicknameInDB(targetName))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този nickname не съществува!");
        return 1;
    }

    new factionWarns = GetUserValueInt(targetName, "f_warns");
    new targetFaction = GetUserValueInt(targetName, "team");

    if (targetFaction != PlayerInfo[playerid][pTeam])
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е от твоята банда/мафия!");
        return 1;
    }

    if (factionWarns == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч няма FACTION предупреждения!");
        return 1;
    }

    factionWarns--;
    UpdatePlayerDatabaseINT("f_warns", factionWarns, targetName);

    // Update online player if found
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && strcmp(targetName, GetPlayerNickname(i), true) == 0)
        {
            if (PlayerInfo[i][pFWarns] > 0)
            {
                PlayerInfo[i][pFWarns]--;
            }
            break;
        }
    }

    format(string, sizeof(string), "[FACTION CHAT] %s was FACTION unwarned by %s", targetName, GetPlayerNickname(playerid));

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            SendClientMessage(i, 0x33CCFFFF, string);
        }
    }

    return 1;
}

CMD:nftmute(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] < 6)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new targetName[MAX_PLAYER_NAME], muteTime;
    if (sscanf(params, "s[24]d", targetName, muteTime))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /nftmute [nickname] [time]");
        return 1;
    }

    if (strlen(targetName) < 1 || strlen(targetName) > 30)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Името трябва да бъде с до 30 символа!");
        return 1;
    }

    if (muteTime < 1 || muteTime > 1000)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Трябва минутите да бъдат между 1 и 1000!");
        return 1;
    }

    if (!IsNicknameInDB(targetName))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не съществува играч с такъв nickname!");
        return 1;
    }

    new targetFaction = GetUserValueInt(targetName, "team");
    if (targetFaction != PlayerInfo[playerid][pTeam])
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е от твоята банда/мафия!");
        return 1;
    }

    new foundPlayer = -1;
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && strcmp(targetName, GetPlayerNickname(i), true) == 0)
        {
            foundPlayer = i;
            break;
        }
    }

    if (foundPlayer != -1)
    {
        // Online player
        PlayerInfo[foundPlayer][pFMuted] = muteTime * 60;
    }
    else
    {
        // Offline player
        UpdatePlayerDatabaseINT("f_mute", muteTime * 60, targetName);
    }

    format(string, sizeof(string), "[FACTION CHAT] %s was FACTION muted by %s for %d minutes.",
           targetName, GetPlayerNickname(playerid), muteTime);

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            SendClientMessage(i, 0x33CCFFFF, string);
        }
    }

    return 1;
}

CMD:nfmute(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] < 6)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new targetName[MAX_PLAYER_NAME];
    if (sscanf(params, "s[24]", targetName))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /nfmute [nickname]");
        return 1;
    }

    if (strlen(targetName) < 1 || strlen(targetName) > 30)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Името трябва да бъде с до 30 символа!");
        return 1;
    }

    if (!IsNicknameInDB(targetName))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не съществува играч с такъв nickname!");
        return 1;
    }

    new targetFaction = GetUserValueInt(targetName, "team");
    if (targetFaction != PlayerInfo[playerid][pTeam])
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е от твоята банда/мафия!");
        return 1;
    }

    new foundPlayer = -1;
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && strcmp(targetName, GetPlayerNickname(i), true) == 0)
        {
            foundPlayer = i;
            break;
        }
    }

    if (foundPlayer != -1)
    {
        // Online player - permanent mute (large value)
        PlayerInfo[foundPlayer][pFMuted] = 1000000;
    }
    else
    {
        // Offline player - permanent mute
        UpdatePlayerDatabaseINT("f_muted", 1000000, targetName);
    }

    format(string, sizeof(string), "[FACTION CHAT] %s was FACTION muted by %s",
           targetName, GetPlayerNickname(playerid));

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            SendClientMessage(i, 0x33CCFFFF, string);
        }
    }

    return 1;
}

CMD:funignore(playerid, params[])
{
    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /funignore [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (playerid == targetid)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да премахнеш игнориране от себе си!");
        return CMD_SUCCESS;
    }

    // Check if player is already not ignoring the target
    new alreadyNotIgnoring = 0;
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (fignore[i][playerid] == targetid)
        {
            alreadyNotIgnoring = 1;
            break;
        }
    }

    if (!alreadyNotIgnoring)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече не си игнорирал този играч!");
        return CMD_SUCCESS;
    }

    // Remove from ignore list
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (fignore[i][playerid] == targetid)
        {
            fignore[i][playerid] = -1;
            break;
        }
    }

    new togapmstring[256];
    format(togapmstring, sizeof(togapmstring), "Ти премахна игнорирането на %s и сега ще виждаш неговите съобщения във FACTION чата!", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0x33CCFFFF, togapmstring);

    return CMD_SUCCESS;
}

CMD:fignore(playerid, params[])
{
    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /fignore [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pTeam] != PlayerInfo[targetid][pTeam])
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е от твоята банда/мафия!");
        return CMD_SUCCESS;
    }

    if (playerid == targetid)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да игнорираш себе си!");
        return CMD_SUCCESS;
    }

    // Check if already ignoring
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (fignore[playerid][i] == targetid)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече си игнорирал този играч!");
            return CMD_SUCCESS;
        }
    }

    // Add to ignore list
    new added = 0;
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (fignore[playerid][i] == -1 && !added)
        {
            fignore[playerid][i] = targetid;
            added = 1;
            break;
        }
    }

    new togapmstring[256];
    format(togapmstring, sizeof(togapmstring), "Ти игнорира %s да не виждаш неговите съобщения във FACTION чата!", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0x33CCFFFF, togapmstring);

    return CMD_SUCCESS;
}
CMD:ifcduty(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 3.0, 283.4191, 1387.8158, 10.5859))
    {
        return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си на мястото за влизане в служба!");
    }
    if (PlayerInfo[playerid][pADuty] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си ADMIN ON-DUTY!");
        return 1;
    }
    if (PlayerInfo[playerid][pIFC] == 0) return SendClientMessage(playerid, 0xE60000FF, "Трябва да си член на Intense Fuel Company!");
    if (PlayerInfo[playerid][pIFCDuty] == 1)
    {
        SendClientMessage(playerid, 0xA4FFA4FF, "* Вие вече не сте на служба в Intense Fuel Company *");
        PlayerInfo[playerid][pIFCDuty] = 0;
        return SetPlayerSkin(playerid, spawnselectedskin[playerid]);
    }
    else
    {
        SendClientMessage(playerid, 0xA4FFA4FF, "* Вие вече сте на служба в Intense Fuel Company *");
        PlayerInfo[playerid][pIFCDuty] = 1;
        SetPlayerSkin(playerid, 202);
    }
    return 1;
}
CMD:policeduty(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 3.0, 256.8192, 63.6511, 1003.6406))
    {
        return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си на мястото за влизане в служба!");
    }
    if (PlayerInfo[playerid][pADuty] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си ADMIN ON-DUTY!");
        return 1;
    }
    if (PlayerInfo[playerid][pTeam] != 15) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си член на Intense Police Department!");
    if (PlayerInfo[playerid][pWanted] >= 1) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да не си издиравн за да влезеш на смяна!");
    new stringPolice[256];

    if (PlayerInfo[playerid][pIPDDuty] == 1)
    {
        format(stringPolice, 256, "[FACTION CHAT] %s излезе от служба!", GetPlayerNickname(playerid));
        SendFactionMessage(FACTION_INTENSE_POLICE, COLOR_IPD_CHAT, stringPolice);
        PlayerInfo[playerid][pIPDDuty] = 0;
    }
    else
    {
        format(stringPolice, 256, "[FACTION CHAT] %s влезе в служба!", GetPlayerNickname(playerid));
        SendFactionMessage(FACTION_INTENSE_POLICE, COLOR_IPD_CHAT, stringPolice);
        PlayerInfo[playerid][pIPDDuty] = 1;
    }
    RestartPlayerSkin(playerid);
    RestartPlayerColor(playerid);
    return 1;
}
/*CMD:mdcshow(playerid, params[])
{
    if (PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Тази команда е само за Intense Police Department!");
        return 1;
    }
    if (!PlayerInfo[playerid][pSpecialForce] && !PlayerInfo[playerid][pDeltaForce])
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Тази команда е само за Special Force и Delta Force!");
        return 1;
    }
    if (!PlayerInfo[playerid][pIPDDuty])
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Тази команда е само за служители на смяна!");
        return 1;
    }

    format(string115, 115, "Вие поставихте маркер върху издирваните играчи");
    SendClientMessage(playerid, COLOR_IPD_CHAT, string115);

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerInfo[i][pWanted] >= 1)
        {
            SetPlayerMarkerForPlayer(playerid, i, COLOR_IPD_CHAT);
        }
    }
    return 1;
}*/
CMD:mdcshow(playerid, params[])
{
    // Check if player is in the Intense Police Department
    if (PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE)
        return SendClientMessage(playerid, COLOR_GRAD1, "This command is only for the Intense Police Department!"), 1;

    // Check if player is in a special unit
    if (!PlayerInfo[playerid][pSpecialForce] && !PlayerInfo[playerid][pDeltaForce])
        return SendClientMessage(playerid, COLOR_GRAD1, "This command is only for Special Force or Delta Force members!"), 1;

    // Check if player is on duty
    if (!PlayerInfo[playerid][pIPDDuty])
        return SendClientMessage(playerid, COLOR_GRAD1, "You must be on duty to use this command!"), 1;

    SendClientMessage(playerid, COLOR_IPD_CHAT, "You have placed markers on wanted suspects.");

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (!IsPlayerConnected(i) || i == playerid) continue; // Skip disconnected players and self

        if (PlayerInfo[i][pWanted] >= 1)
        {
            new color;
            // Marker color based on wanted level
            if (PlayerInfo[i][pWanted] <= 2)
                color = 0xFFFF00AA; // Yellow (low wanted)
            else if (PlayerInfo[i][pWanted] <= 4)
                color = 0xFFA500AA; // Orange (medium wanted)
            else
                color = 0xFF0000AA; // Red (high wanted)

            SetPlayerMarkerForPlayer(playerid, i, color);
        }
        else
        {
            // Hide the marker if player is not wanted
            SetPlayerMarkerForPlayer(playerid, i, 0);
        }
    }
    return 1;
}

CMD:mdchide(playerid, params[])
{
    if (PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Тази команда е само за Intense Police Department!");
        return 1;
    }
    if (!PlayerInfo[playerid][pSpecialForce] && !PlayerInfo[playerid][pDeltaForce])
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Тази команда е само за Special Force и Delta Force!");
        return 1;
    }
    SendClientMessage(playerid, COLOR_IPD_CHAT, "Вие премахнахте маркера от картата!");

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            SetPlayerMarkerForPlayer(playerid, i, GetPlayerColor(i));
        }
    }
    return 1;
}

CMD:mdc(playerid, params[])
{
    if (PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Тази команда е само за Intense Police Department!");
        return 1;
    }

    new mdcCount = 0;
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            if (PlayerInfo[i][pWanted] >= 1)
            {
                mdcCount += 1;
            }
        }
    }

    if (mdcCount == 0)
    {
        return SendClientMessage(playerid, COLOR_IPD_CHAT, "Няма онлайн издирвани играчи!");
    }

    new stringMDC[256];
    format(stringMDC, 256, "Онлайн издирвани играчи(%d):", mdcCount);
    SendClientMessage(playerid, COLOR_IPD_CHAT, stringMDC);
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerInfo[i][pWanted] >= 1)
        {
            format(stringMDC, 256, "%s(%d): Wanted Level: %d", GetPlayerNickname(i), i, PlayerInfo[i][pWanted]);
            SendClientMessage(playerid, 0xFF0000FF, stringMDC);
        }
    }
    return 1;
}

CMD:deltaforce(playerid, params[])
{
    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /deltaforce [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (PlayerInfo[playerid][pRank] != 6 || PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    if (PlayerInfo[targetid][pTeam] != 15)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е член на Intense Police Department!");

    if (PlayerInfo[targetid][pDeltaForce] == 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч вече е Delta Force!");

    if (PlayerInfo[targetid][pRank] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч трябва първо да бъде 5 ранг!");

    PlayerInfo[targetid][pSpecialForce] = 0;
    PlayerInfo[targetid][pDeltaForce] = 1;
    
    new string256[256];
    format(string256, sizeof(string256), "[FACTION CHAT] %s добави %s към Delta Force членовете на Intense Police Department!", GetPlayerNickname(playerid), GetPlayerNickname(targetid));
    
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            SendClientMessage(i, COLOR_IPD_CHAT, string256);
        }
    }
    
    return 1;
}

CMD:specialforce(playerid, params[])
{
    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /specialforce [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (PlayerInfo[playerid][pRank] != 6 || PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    if (PlayerInfo[targetid][pTeam] != 15)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е член на Intense Police Department!");

    if (PlayerInfo[targetid][pSpecialForce] == 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч вече е SWAT!");

    if (PlayerInfo[targetid][pRank] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч трябва първо да бъде 5 ранг!");

    PlayerInfo[targetid][pDeltaForce] = 0;
    PlayerInfo[targetid][pSpecialForce] = 1;
    
    new string256[256];
    format(string256, sizeof(string256), "[FACTION CHAT] %s добави %s към SWAT членовете на Intense Police Department!", GetPlayerNickname(playerid), GetPlayerNickname(targetid));
    
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            SendClientMessage(i, COLOR_IPD_CHAT, string256);
        }
    }
    
    return 1;
}

CMD:unspecialforce(playerid, params[])
{
    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /unspecialforce [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (PlayerInfo[targetid][pTeam] != 15)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е член на Intense Police Department!");

    if (PlayerInfo[playerid][pRank] != 6 || PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    if (PlayerInfo[targetid][pSpecialForce] == 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е SWAT!");

    PlayerInfo[targetid][pSpecialForce] = 0;
    PlayerInfo[targetid][pIPDDuty] = 0;
    
    new string256[256];
    format(string256, sizeof(string256), "%s премахна %s от SWAT членовете на Intense Police Department!", GetPlayerNickname(playerid), GetPlayerNickname(targetid));
    
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            SendClientMessage(i, COLOR_IPD_CHAT, string256);
        }
    }
    
    return 1;
}

CMD:undeltaforce(playerid, params[])
{
    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /undeltaforce [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (PlayerInfo[targetid][pTeam] != 15)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е член на Intense Police Department!");

    if (PlayerInfo[playerid][pRank] != 6 || PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    if (PlayerInfo[targetid][pDeltaForce] == 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е Delta Force!");

    PlayerInfo[targetid][pDeltaForce] = 0;
    PlayerInfo[targetid][pIPDDuty] = 0;
    
    new string256[256];
    format(string256, sizeof(string256), "%s премахна %s от Delta Force членовете на Intense Police Department!", GetPlayerNickname(playerid), GetPlayerNickname(targetid));
    
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            SendClientMessage(i, COLOR_IPD_CHAT, string256);
        }
    }
    
    return 1;
}
CMD:af(playerid, params[])
{
    if (TeamInvite[playerid] == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш покана за банда/мафия!");
    PlayerInfo[playerid][pTeam] = TeamInvite[playerid];
    TeamInvite[playerid] = -1;
    PlayerInfo[playerid][pSpecialForce] = 0;
    PlayerInfo[playerid][pDeltaForce] = 0;
    PlayerInfo[playerid][pHelperLeader] = 0;
    format(string115, 115, "[FACTION CHAT] %s влезе в твоята банда/мафия.", GetPlayerNickname(playerid));
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            SendClientMessage(i, 0x33CCFFFF, string115);
        }
    }
    RestartPlayerColor(playerid);
    RestartVIPLaser(playerid);
    if (IsPlayerInAnyVehicle(playerid) == 1 && PlayerInfo[playerid][pADuty] == 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "* Твоят скин не се смени, защото не си пешеходец *");
    }
    if (PlayerInfo[playerid][pSpawnO] != 2)
    {
        PlayerInfo[playerid][pSpawnO] = 2;
        SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Твоят spawn беше променен на Faction spawn!");
    }
    if (IsPlayerInAnyVehicle(playerid) == 1 && PlayerInfo[playerid][pADuty] == 0)
    {
        return 1;
    }
    RestartPlayerSkin(playerid);
    return 1;
}
CMD:acceptfaction(playerid, params[]) return cmd_af(playerid, params);

CMD:joinvip(playerid, params[])
{
    if (PlayerInfo[playerid][pLevel] > 20) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не можеш да влезеш във VIP, защото си над 20 левел!");
    if (PlayerInfo[playerid][pTeam] != 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече си в банда/мафия!");
    PlayerInfo[playerid][pTeam] = FACTION_VIP;
    PlayerInfo[playerid][pRank] = 1;
    SendClientMessage(playerid, 0x33CCFFFF, "Ти влезе в банда/мафия VIP, Честито!");
    format(string115, 115, "[FACTION CHAT] JOINVIP: %s влезе в твоята банда/мафия.", GetPlayerNickname(playerid));
    if (IsPlayerInAnyVehicle(playerid) == 1 && PlayerInfo[playerid][pADuty] == 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "* Твоят скин не се смени, защото не си пешеходец *");
    }
    else
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
    if (PlayerInfo[playerid][pSpawnO] != 2)
    {
        PlayerInfo[playerid][pSpawnO] = 2;
        SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Твоят spawn беше променен на Faction spawn!");
    }
    if (IsPlayerInAnyVehicle(playerid) == 1 && PlayerInfo[playerid][pADuty] == 0)
    {
        return 1;
    }
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            SendClientMessage(i, 0x33CCFFFF, string115);
        }
    }
    if (PlayerInfo[playerid][pVip] > 3 || CheckFreeVIP() == 1)
    {
        SetPVarInt(playerid, "color", 0);
        PlayerInfo[playerid][pLaser] = 1;
    }
    if (PlayerInfo[playerid][pADuty] == 0)
    {
        SetPlayerColor(playerid, 0xFF3737FF);
    }
    return 1;
}

CMD:cf(playerid, params[])
{
    if (TeamInvite[playerid] == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш покана за банда/мафия!");
    format(string115, 115, "%s отказа да влезе в твоята банда/мафия.", GetPlayerNickname(playerid));
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerInfo[i][pTeam] == TeamInvite[playerid])
        {
            SendClientMessage(playerid, 0x33CCFFFF, string115);
        }
    }
    TeamInvite[playerid] = -1;
    return 1;
}
CMD:cancelfaction(playerid, params[]) return cmd_cf(playerid, params);


