CMD:duel(playerid, params[])
{
    new targetid, bet;
    if (sscanf(params, "ui", targetid, bet))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /duel [playerid] [money]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (playerInDuel[targetid] == 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "В момента играчът е в друг дуел!");

    if (playerInDuel[playerid] == 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "В момента си в друг дуел!");

    if (targetid == playerid)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да поканиш себе си на дуел!");

    if (PlayerInfo[targetid][pADuty] > 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч в момента е ADMIN ON-DUTY!");

    if (PlayerInfo[playerid][pADuty] > 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да играеш дуел, докато си ADMIN ON-DUTY!");

    if (bet < 100 || bet > 1000000)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Залогът трябва да е между $100 и $1,000,000!");

    if (PlayerInfo[playerid][pCash] < bet)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш толкова пари за залог!");

    if (PlayerInfo[targetid][pCash] < bet)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Играчът няма толкова пари за залог!");

    if (duelsender[playerid] > -1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Вече си изпратил покана за дуел на друг играч!");

    if (duelsend[playerid] > -1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Имаш покана за дуел от друг играч в момента!");

    if (playerInDMON[playerid] == 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "В момента си в DMON!");

    format(string, sizeof(string), "Duel: Ти изпрати покана за дуел на %s. Ако искаш да отмениш поканата напиши /cduel", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFE400FF, string);

    format(string, sizeof(string), "Duel: %s те покани на дуел със залог $%d. Напиши /yes за да приемеш или /no за да откажеш!", GetPlayerNickname(playerid), bet);
    SendClientMessage(targetid, 0xFFE400FF, string);

    duelsender[targetid] = playerid;
    duelsend[playerid] = targetid;
    duelzalog[playerid] = bet;

    return 1;
}

CMD:cduel(playerid, params[])
{
    if (duelsend[playerid] > -1)
    {
        new duelstring[256];
        format(duelstring, 256, "Duel: Ти отмени поканата за дуел, която изпрати на %s", GetPlayerNickname(duelsend[playerid]));
        SendClientMessage(playerid, 0xFFE400FF, duelstring);
        format(duelstring, 256, "Duel: %s отказа поканата си за дуел", GetPlayerNickname(duelsender[duelsend[playerid]]));
        SendClientMessage(duelsender[playerid], 0xFFE400FF, duelstring);
        duelsender[duelsend[playerid]] = -1;
        duelsend[playerid] = -1;
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Ти не си поканил никого на дуел!");
    }
    return 1;
}
CMD:yes(playerid, params[])
{
    if (duelsender[playerid] > -1)
    {
        if (PlayerInfo[playerid][pIFCDuty] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си IFC ON-DUTY!");
        if (PlayerInfo[playerid][pADuty] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да играеш дуел, докато си ADMIN ON-DUTY!");
        if (PlayerInfo[playerid][pAFK] > 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в AFK режим и не можеш да играеш дуел!");
            return 1;
        }
        if (PlayerInfo[playerid][pJail] > 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в админ затвора и не можеш да играеш дуел!");
            return 1;
        }
        if (PlayerInfo[playerid][pPJail] > 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в затвора и не можеш да играеш дуел!");
            return 1;
        }
        if (cmn1[playerid] > 0)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да играеш дуел, докато си CMN1!");
        }
        if (playerInDuel[playerid] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да играеш пак, докато си в дуел!");
        }
        if (playerInDMON[playerid] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не да играеш, докато си в DMON!");
        }
        if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си в евент!");
        if (PlayerInfo[playerid][pADuty] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не да играеш, докато си ADMIN ON-DUTY!");
        }
        if (cmn1[duelsender[playerid]] > 0)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да играеш дуел, докато играчът е CMN1!");
        }
        if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
        if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
        if (playerInDuel[duelsender[playerid]] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да играеш, докато играчът е в дуел!");
        }
        if (playerInDMON[duelsender[playerid]] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да играеш, играчът е в DMON!");
        }
        if (PlayerInfo[duelsender[playerid]][pADuty] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не да играеш, играчът е ADMIN ON-DUTY!");
        }
        format(string, 256, "Duel: Ти прие поканата за дуел на %s", GetPlayerNickname(duelsender[playerid]));
        SendClientMessage(playerid, 0xFFE400FF, string);
        format(string, 256, "Duel: %s прие поканата ти за дуел", GetPlayerNickname(playerid));
        SendClientMessage(duelsender[playerid], 0xFFE400FF, string);
        playerInDuel[playerid] = 1;
        playerInDuel[duelsender[playerid]] = 1;
        duelprotivnik[playerid] = duelsender[playerid];
        duelprotivnik[duelsender[playerid]] = playerid;
        GetPlayerPos(playerid, prediduelX[playerid], prediduelY[playerid], prediduelZ[playerid]);
        GetPlayerHealth(playerid, prediduelhealth[playerid]);
        GetPlayerArmour(playerid, prediduelarmour[playerid]);
        prediduelvw[playerid] = GetPlayerVirtualWorld(playerid);
        prediduelinterior[playerid] = GetPlayerInterior(playerid);
        prediduelvw[duelsender[playerid]] = GetPlayerVirtualWorld(playerid);
        prediduelinterior[duelsender[playerid]] = GetPlayerInterior(playerid);
        SetPlayerVirtualWorld(playerid, 500 + playerid);
        SetPlayerInterior(playerid, 1);
        SetPlayerPos(playerid, 1410.3407, -1.3358, 1000.9233);
        PlayerInfo[duelsender[playerid]][pDuelCountTimer] = 1;
        duelzalog[playerid] = duelzalog[duelsender[playerid]];
        GetPlayerPos(playerid, prediduelX[duelsender[playerid]], prediduelY[duelsender[playerid]], prediduelZ[duelsender[playerid]]);
        GetPlayerHealth(playerid, prediduelhealth[duelsender[playerid]]);
        GetPlayerArmour(playerid, prediduelarmour[duelsender[playerid]]);
        prediduelvw[duelsender[playerid]] = GetPlayerVirtualWorld(duelsender[playerid]);
        SetPlayerVirtualWorld(duelsender[playerid], 500 + playerid);
        SetPlayerInterior(duelsender[playerid], 1);
        SetPlayerPos(duelsender[playerid], 1373.1509, -33.9499, 1000.9219);
        TogglePlayerControllable(playerid, 0);
        TogglePlayerControllable(duelsender[playerid], 0);
        SetPlayerHealth(playerid, 100);
        SetPlayerHealth(duelsender[playerid], 100);
        SetPlayerArmour(playerid, 100);
        SetPlayerArmour(duelsender[playerid], 100);
        SetPlayerFacingAngle(playerid, 123.8814);
        SetPlayerFacingAngle(duelsender[playerid], 313.3936);
        prediduelvw[duelsender[playerid]] = GetPlayerVirtualWorld(duelsender[playerid]);
        prediduelinterior[duelsender[playerid]] = GetPlayerInterior(duelsender[playerid]);
        SetPlayerColor(duelsender[playerid], 0xFF9068FF);
        SetPlayerColor(playerid, 0xFF9068FF);
        SetCameraBehindPlayer(playerid);
        SetCameraBehindPlayer(duelsender[playerid]);
        SetPlayerArmedWeapon(playerid, 0);
        SetPlayerArmedWeapon(duelsender[playerid], 0);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Никой не ти е пратил покана за дуел!");
    }
    return 1;
}
CMD:no(playerid, params[])
{
    if (duelsender[playerid] == -1)
    {
        return SendClientMessage(playerid, COLOR_GRAD1, "Никой не ти е пратил покана за дуел!");
    }
    new string356[356];
    format(string356, 356, "Duel: Ти отказа поканата за дуел на %s", GetPlayerNickname(duelsender[playerid]));
    SendClientMessage(playerid, 0xFFE400FF, string356);
    format(string356, 356, "Duel: %s отказа поканата ти за дуел", GetPlayerNickname(playerid));
    SendClientMessage(duelsender[playerid], 0xFFE400FF, string356);
    new duelsendera = duelsender[playerid];
    duelsender[playerid] = -1;
    duelsend[duelsendera] = -1;
    return 1;
}
