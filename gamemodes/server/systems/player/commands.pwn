CMD:radioff(playerid, params[])
{
    if (PlayerInfo[playerid][pRadio] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш радио!");
    if (radion[playerid] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Радиото вече е спряно!");
    radion[playerid] = 0;
    StopAudioStreamForPlayer(playerid);
    SendClientMessage(playerid, 0x9ACD32FF, "* Ти изключи радиото *");
    return 1;
}

CMD:changepass(playerid, params[])
{
    if (isnull(params))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /changepass [password]");
        return CMD_SUCCESS;
    }

    if (strlen(params) < 4 || strlen(params) > 20)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Паролата трябва да е от 4 до 20 символа!");
        return CMD_SUCCESS;
    }

    if (strfind(params, "||", true) != -1 || strfind(params, "|", true) != -1 || strfind(params, "~", true) != -1 || strfind(params, ",", true) != -1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не можеш да използваш забранени символи!");
    }

    SavePlayerPassword(playerid, params);

    new string256[256];
    format(string256, sizeof(string256), "SERVER: Ти промени твоята парола на {FFFF00}%s", params);
    SendClientMessage(playerid, 0xFFFFFFFF, string256);
    return CMD_SUCCESS;
}

CMD:fc(playerid, params[])
{
    new string500[500];
    new closeddialog = 3500;
    if (PlayerInfo[playerid][pFuelcase] == -1) return SendClientMessage(playerid, COLOR_RED, "Ти нямаш туба за бензин!");
    format(string500, 500, "Вашата туба бензин има {C14124}%d L", PlayerInfo[playerid][pFuelcase]);
    ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, "{FF0000}Туба бензин", string500, "Затвори", "");
    return 1;
}
CMD:fuelcan(playerid, params[])
{
    if (PlayerInfo[playerid][pFuelcase] == -1) return SendClientMessage(playerid, COLOR_RED, "Ти нямаш туба за бензин!");
    if (!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED, "Трябва да се качиш в превозно средство за да заредиш!");
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
        SendClientMessage(playerid, COLOR_RED, "Трябва да си в превозно средство като шофьор!");
        return 1;
    }
    if (GetVehicleModel(GetPlayerVehicleID(playerid)) != 481 &&
            GetVehicleModel(GetPlayerVehicleID(playerid)) != 509 &&
            GetVehicleModel(GetPlayerVehicleID(playerid)) != 510 &&
            GetVehicleModel(GetPlayerVehicleID(playerid)) != 481)
    {
        if (PlayerInfo[playerid][pFuelcase] == 0) return SendClientMessage(playerid, COLOR_RED, "Ти нямаш бензин в тубата!");
        new string500[500];
        if (100 - vehfuel[GetPlayerVehicleID(playerid)] == 1)
        {
            format(string500, 500, "{FFFF00}Моля въведете с колко литра искате да заредите вашето превозно средство.\n{FFFFFF}За да заредиш до горе ти нужен {FFFF00}1 литър.");
            ShowPlayerDialog(playerid, 39, DIALOG_STYLE_INPUT, "{0040FF}Бензиностанция", string500, "Презареди", "Затвори");
        }
        if (100 - vehfuel[GetPlayerVehicleID(playerid)] < 1)
        {
            format(string500, 500, "{FFFF00}Моля въведете с колко литра искате да заредите вашето превозно средство.\n{FFFFFF}За да заредиш до горе са ти нужни {FFFF00}0 литра.");
            ShowPlayerDialog(playerid, 39, DIALOG_STYLE_INPUT, "{FF0000}Туба бензин", string500, "Презареди", "Затвори");
        }
        if (100 - vehfuel[GetPlayerVehicleID(playerid)] > 1)
        {
            format(string500, 500, "{FFFF00}Моля въведете с колко литра искате да заредите вашето превозно средство.\n{FFFFFF}За да заредиш до горе са ти нужни {FFFF00}%d литра.", 100 - vehfuel[GetPlayerVehicleID(playerid)]);
            ShowPlayerDialog(playerid, 39, DIALOG_STYLE_INPUT, "{FF0000}Туба бензин", string500, "Презареди", "Затвори");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можете да заредите бензин в това превозно средство!");
        return 1;
    }
    return 1;
}

CMD:myfps(playerid, params[])
{
    format(string115, 115, "Your FPS: %d", pFPS[playerid]);
    SendClientMessage(playerid, 0x27D3A1FF, string115);
    return 1;
}

CMD:statistic(playerid, params[])
{
    if (statisticset[playerid] == 1)
    {
        format(string256, 256, "* Вие сложихте статистиката на вашия екран *");
        SendClientMessage(playerid, 0xFFFF00FF, string256);
        TextDrawShowForPlayer(playerid, levelText[playerid]);
        TextDrawShowForPlayer(playerid, epText[playerid]);
        TextDrawShowForPlayer(playerid, epsText[playerid]);
        TextDrawShowForPlayer(playerid, msText[playerid]);
        statisticset[playerid] = 0;
        return 1;
    }
    if (statisticset[playerid] == 0)
    {
        format(string256, 256, "* Вие премахнахте статистиката на вашия екран *");
        SendClientMessage(playerid, 0xFFFF00FF, string256);
        TextDrawHideForPlayer(playerid, epText[playerid]);
        TextDrawHideForPlayer(playerid, levelText[playerid]);
        TextDrawHideForPlayer(playerid, epsText[playerid]);
        TextDrawHideForPlayer(playerid, msText[playerid]);
        statisticset[playerid] = 1;
    }
    return 1;
}
CMD:leavefaction(playerid, params[])
{
    new confirmation[16];
    if (sscanf(params, "s[16]", confirmation))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /leavefaction [confirm]");
        return CMD_SUCCESS;
    }

    if (strcmp(confirmation, "confirm", true) != 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /leavefaction [confirm]");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pTeam] == FACTION_CIVILIAN)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в банда/мафия!");
        return CMD_SUCCESS;
    }

    if (isTurfMember[playerid])
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да напуснеш банда/мафията, докато си в атака на територия!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pRank] == 6)
    {
        new string256[256];
        format(string256, sizeof(string256), "%s махна неговото лидерство!", GetPlayerNickname(playerid));

        // Send to all faction members
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
            {
                SendClientMessage(i, 0xF97804FF, string256);
            }
        }
    }

    PlayerInfo[playerid][pIPDDuty] = 0;

    new string256[256];
    format(string256, sizeof(string256), "[FACTION CHAT] %s напусна бандата/мафията по негово желание!", GetPlayerNickname(playerid));

    // Send to all faction members
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            SendClientMessage(i, 0x33CCFFFF, string256);
        }
    }

    LeaveGangPlayerAffect(playerid);
    return CMD_SUCCESS;
}

CMD:stats(playerid, params[])
{
    ShowPlayerStats(playerid, playerid);
    return 1;
}

CMD:transfer(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 3, 2316.6213, -9.9516, 26.7422))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си близо в банката, за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid, amount;
    if (sscanf(params, "ui", targetid, amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /transfer [playerid] [money]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (targetid == playerid)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да дадеш на себеси пари!");
        return CMD_SUCCESS;
    }

    if (amount < 1 || amount > 1000000)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Парите трябва да са от 1 до 1 000 000 !");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pAccount] < amount)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш толкова пари в общата си сума!");
        return CMD_SUCCESS;
    }

    // Perform the transfer
    PlayerInfo[playerid][pAccount] -= amount;
    PlayerInfo[targetid][pAccount] += amount;

    // Send confirmation messages
    new string256[256];
    format(string256, sizeof(string256), "%s изпрати пари в твоята обща сума на стойност $%d.", GetPlayerNickname(playerid), amount);
    SendClientMessage(targetid, 0xFFFF00FF, string256);

    format(string256, sizeof(string256), "Ти изпрати $%d в общата сума на %s.", amount, GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFFFFFF, string256);

    return CMD_SUCCESS;
}

CMD:removehat(playerid, params[])
{
    if (month == 12)
    {
        if (santaHat[playerid] == true)
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Ти премахна твоята шапка!");
            santaHat[playerid] = false;
            RemovePlayerAttachedObject(playerid, 9);
        }
        else if (santaHat[playerid] == false)
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Нямаш закачена шапка на себе си!");
        }
    }
    return 1;
}
CMD:removegps(playerid, params[])
{
    if (gpsOn[playerid] == false) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш сложена GPS локация!");
    DisablePlayerCheckpoint(playerid);
    return 1;
}
CMD:bank(playerid, params[])
{
    if (IsPlayerInRangeOfPoint(playerid, 3, 2316.6213, -9.9516, 26.7422))
    {
        ShowPlayerDialog(playerid, 19, DIALOG_STYLE_LIST, "Банка", "Обща сума\nИзтегли пари\nВнеси пари", "Избери", "Назад");
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си в банката, за да ползваш командата!");
    }
    return 1;
}
CMD:atm(playerid, params[])
{
    if (IsPlayerInRangeOfPoint(playerid, 3, 1539.162475, -1613.974609, 13.134112) ||
            IsPlayerInRangeOfPoint(playerid, 3, 387.170196, -1827.512084, 7.415833) ||
            IsPlayerInRangeOfPoint(playerid, 3, 378.918457, -2060.627929, 7.453046) ||
            IsPlayerInRangeOfPoint(playerid, 3, 672.134521, -503.247589, 15.964093) ||
            IsPlayerInRangeOfPoint(playerid, 3, 2490.404541, 923.318664, 10.840134) ||
            IsPlayerInRangeOfPoint(playerid, 3, 2181.033691, 2462.734130, 10.424777) ||
            IsPlayerInRangeOfPoint(playerid, 3, -174.470657, 1138.796386, 19.313276) ||
            IsPlayerInRangeOfPoint(playerid, 3, -1486.528686, 2583.155517, 55.317409) ||
            IsPlayerInRangeOfPoint(playerid, 3, -2492.394775, 2366.457519, 9.587511) ||
            IsPlayerInRangeOfPoint(playerid, 3, 1239.006103, -2041.014038, 59.432590) ||
            IsPlayerInRangeOfPoint(playerid, 3, 210.3416, 1808.8025, 21.8672) ||
            IsPlayerInRangeOfPoint(playerid, 3, 2194.2756, 1986.2014, 12.2969) ||
            IsPlayerInRangeOfPoint(playerid, 3, 398.4085, -1805.4634, 7.8379))
    {
        //ApplyAnimation(playerid,"INT_SHOP","shop_pay",4.0,1,0,0,0,0);
        ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "Банкомат", "Обща сума\nИзтегли пари\nПлати нарушение", "Избери", "Назад");
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си близо до банкомат, за да ползваш командата!");
    }
    return 1;
}

CMD:buyws(playerid, params[])
{
    new confirmation[16];
    if (sscanf(params, "s[16]", confirmation))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /buyws [confirm]");
        return CMD_SUCCESS;
    }

    if (strcmp(confirmation, "confirm", true) != 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /buyws [confirm]");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pWeaponS] >= 10)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече достигна 10 Weapon Skill!");
        return CMD_SUCCESS;
    }

    new string256[256];
    new currentWS = PlayerInfo[playerid][pWeaponS];
    new requiredEP = 0;

    // Check EP requirements based on current weapon skill level
    if (currentWS < 4)
    {
        requiredEP = 5;
    }
    else if (currentWS >= 4 && currentWS < 7)
    {
        requiredEP = 10;
    }
    else if (currentWS >= 7)
    {
        requiredEP = 20;
    }

    if (PlayerInfo[playerid][pEP] < requiredEP)
    {
        format(string256, sizeof(string256), "Трябват ти %d EP за да вдигнеш твоя Weapon Skill!", requiredEP);
        SendClientMessage(playerid, 0xB4B5B7FF, string256);
        return CMD_SUCCESS;
    }

    // Increase weapon skill
    PlayerInfo[playerid][pWeaponS]++;

    // Deduct EP
    GivePlayerEP(playerid, -requiredEP);

    // Send success message
    format(string256, sizeof(string256), "Поздравления Ти вдигна твоя Weapon Skill на %d!", PlayerInfo[playerid][pWeaponS]);
    SendClientMessage(playerid, 0xF97804FF, string256);

    return CMD_SUCCESS;
}

CMD:buylevel(playerid, params[])
{
    if (PlayerInfo[playerid][pEP] < PlayerInfo[playerid][pLevel] + 6)
    {
        format(string256, 256, "Трябват ти %d EP за да вдигнеш твоя Level!", PlayerInfo[playerid][pLevel] + 6);
        SendClientMessage(playerid, 0xB4B5B7FF, string256);
        return 1;
    }
    GivePlayerEP(playerid, -(PlayerInfo[playerid][pLevel] + 6));
    GivePlayerLevel(playerid, 1);
    SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
    GivePlayerEP(playerid, 0);
    GivePlayerLevel(playerid, 0);
    format(string256, 256, "Честито, ти вдигна своето ниво на %d!", PlayerInfo[playerid][pLevel]);
    SendClientMessage(playerid, 0xF97804FF, string256);
    return 1;
}

CMD:buyes(playerid, params[])
{
    new confirmation[16];
    if (sscanf(params, "s[16]", confirmation))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /buyes [confirm]");
        return CMD_SUCCESS;
    }

    if (strcmp(confirmation, "confirm", true) != 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /buyes [confirm]");
        return CMD_SUCCESS;
    }

    new string256[256];

    // Check if player has reached maximum EP Skill
    if (PlayerInfo[playerid][pEPS] >= 200)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече си достигнал 200 EP Skill и не можеш да си купиш повече!");
        return CMD_SUCCESS;
    }

    new requiredEP;

    if (PlayerInfo[playerid][pEPS] == 0)
    {
        // First level costs 50 EP
        requiredEP = 50;

        if (PlayerInfo[playerid][pEP] < requiredEP)
        {
            format(string256, sizeof(string256), "Трябват ти %d EP за да вдигнеш твоя EP Skill!", requiredEP);
            SendClientMessage(playerid, 0xB4B5B7FF, string256);
            return CMD_SUCCESS;
        }

        GivePlayerEP(playerid, -requiredEP);
        GivePlayerEPS(playerid, 1);
        format(string256, sizeof(string256), "* Честито, ти вдигна твоя EP Skill на 1, Поздравления! *");
        SendClientMessage(playerid, 0xF97804FF, string256);
    }
    else
    {
        // Subsequent levels cost current EPS * 50
        requiredEP = PlayerInfo[playerid][pEPS] * 50;

        if (PlayerInfo[playerid][pEP] < requiredEP)
        {
            format(string256, sizeof(string256), "Трябват ти %d EP за да вдигнеш твоя EP Skill!", requiredEP);
            SendClientMessage(playerid, 0xB4B5B7FF, string256);
            return CMD_SUCCESS;
        }

        GivePlayerEP(playerid, -requiredEP);
        GivePlayerEPS(playerid, 1);
        format(string256, sizeof(string256), "* Честито, ти вдигна твоя EP Skill на %d, Поздравления! *", PlayerInfo[playerid][pEPS]);
        SendClientMessage(playerid, 0xF97804FF, string256);
    }

    return CMD_SUCCESS;
}

CMD:buyms(playerid, params[])
{
    new confirmation[16];
    if (sscanf(params, "s[16]", confirmation))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /buyms [confirm]");
        return CMD_SUCCESS;
    }

    if (strcmp(confirmation, "confirm", true) != 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /buyms [confirm]");
        return CMD_SUCCESS;
    }

    new string256[256];

    // Check if player has reached maximum Money Skill
    if (PlayerInfo[playerid][pMS] >= 200)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече си достигнал 200 Money Skill и не можеш да си купиш повече!");
        return CMD_SUCCESS;
    }

    new requiredCash;

    if (PlayerInfo[playerid][pMS] == 0)
    {
        // First level costs $1,000,000
        requiredCash = 1000000;

        if (PlayerInfo[playerid][pCash] < requiredCash)
        {
            format(string256, sizeof(string256), "Трябват ти $%d за да вдигнеш твоя Money Skill!", requiredCash);
            SendClientMessage(playerid, 0xB4B5B7FF, string256);
            return CMD_SUCCESS;
        }

        GivePlayerCash(playerid, -requiredCash);
        GivePlayerMS(playerid, 1);
        format(string256, sizeof(string256), "* Честито, ти вдигна твоя Money Skill на 1, Поздравления! *");
        SendClientMessage(playerid, 0xF97804FF, string256);
    }
    else
    {
        // Subsequent levels cost current MS * $1,000,000
        requiredCash = PlayerInfo[playerid][pMS] * 1000000;

        if (PlayerInfo[playerid][pCash] < requiredCash)
        {
            format(string256, sizeof(string256), "Трябват ти $%d за да вдигнеш твоя Money Skill!", requiredCash);
            SendClientMessage(playerid, 0xB4B5B7FF, string256);
            return CMD_SUCCESS;
        }

        GivePlayerCash(playerid, -requiredCash);
        GivePlayerMS(playerid, 1);
        format(string256, sizeof(string256), "* Честито, ти вдигна твоя Money Skill на %d, Поздравления! *", PlayerInfo[playerid][pMS]);
        SendClientMessage(playerid, 0xF97804FF, string256);
    }

    return CMD_SUCCESS;
}

CMD:drop(playerid, params[])
{
    new item;
    if (sscanf(params, "i", item))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /drop [item number]");
        SendClientMessage(playerid, COLOR_YELLOW, "Item Numbers: 1: Fuelcan, 2: Dice, 3: Briefcase, 4: Cigarettes, 5: Radio");
        SendClientMessage(playerid, COLOR_YELLOW, "Item Numbers: 6: Moonshine, 7: Weed, 8: Cocaine, 9: Heroin, 10: Boat License");
        SendClientMessage(playerid, COLOR_YELLOW, "Item Numbers: 11: Train License, 12: Helicopter License, 13: Airplane License");
        return CMD_SUCCESS;
    }

    switch (item)
    {
        case 1: // Fuelcan
        {
            if (PlayerInfo[playerid][pFuelcase] == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш туба за бензин!");
            SendClientMessage(playerid, COLOR_YELLOW, "Ти изхвърли своята туба за бензин.");
            PlayerInfo[playerid][pFuelcase] = -1;
        }
        case 2: // Dice
        {
            if (PlayerInfo[playerid][pDice] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш зарче в себе си!");
            SendClientMessage(playerid, COLOR_YELLOW, "Ти изхвърли своето зарче.");
            PlayerInfo[playerid][pDice] = 0;
        }
        case 3: // Briefcase
        {
            if (PlayerInfo[playerid][pBriefcase] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш куфарче в себе си!");
            SendClientMessage(playerid, COLOR_YELLOW, "Ти изхвърли своето куфарче.");
            PlayerInfo[playerid][pBriefcase] = 0;
        }
        case 4: // Cigarettes
        {
            if (PlayerInfo[playerid][pCigarettes] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш цигари в себе си!");
            SendClientMessage(playerid, COLOR_YELLOW, "Ти изхвърли своите цигари.");
            PlayerInfo[playerid][pCigarettes] = 0;
        }
        case 5: // Radio
        {
            if (PlayerInfo[playerid][pRadio] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш радио в себе си!");
            SendClientMessage(playerid, COLOR_YELLOW, "Ти изхвърли своето радио.");
            PlayerInfo[playerid][pRadio] = 0;
        }
        case 6: // Moonshine
        {
            if (PlayerInfo[playerid][pMoonshine] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш спиртно питие в себе си!");
            SendClientMessage(playerid, COLOR_YELLOW, "Ти изхвърли своето спиртно питие.");
            PlayerInfo[playerid][pMoonshine] = 0;
        }
        case 7: // Weed
        {
            if (PlayerInfo[playerid][pWeed] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш марихуана в себе си!");
            SendClientMessage(playerid, COLOR_YELLOW, "Ти изхвърли своята марихуана.");
            PlayerInfo[playerid][pWeed] = 0;
        }
        case 8: // Cocaine
        {
            if (PlayerInfo[playerid][pCocaine] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш кокаин в себе си!");
            SendClientMessage(playerid, COLOR_YELLOW, "Ти изхвърли своя кокаин.");
            PlayerInfo[playerid][pCocaine] = 0;
        }
        case 9: // Heroin
        {
            if (PlayerInfo[playerid][pHeroin] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш хероин в себе си!");
            SendClientMessage(playerid, COLOR_YELLOW, "Ти изхвърли своя хероин.");
            PlayerInfo[playerid][pHeroin] = 0;
        }
        case 10: // Boat License
        {
            if (PlayerInfo[playerid][pLodka] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш книжка за лодка в себе си!");
            SendClientMessage(playerid, COLOR_YELLOW, "Ти изхвърли своята книжка за лодка.");
            PlayerInfo[playerid][pLodka] = 0;
        }
        case 11: // Train License
        {
            if (PlayerInfo[playerid][pVlak] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш книжка за влак в себе си!");
            SendClientMessage(playerid, COLOR_YELLOW, "Ти изхвърли своята книжка за влак.");
            PlayerInfo[playerid][pVlak] = 0;
        }
        case 12: // Helicopter License
        {
            if (PlayerInfo[playerid][pHelikopter] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш книжка за хеликоптер в себе си!");
            SendClientMessage(playerid, COLOR_YELLOW, "Ти изхвърли своята книжка за хеликоптер.");
            PlayerInfo[playerid][pHelikopter] = 0;
        }
        case 13: // Airplane License
        {
            if (PlayerInfo[playerid][pSamolet] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш книжка за самолет в себе си!");
            SendClientMessage(playerid, COLOR_YELLOW, "Ти изхвърли своята книжка за самолет.");
            PlayerInfo[playerid][pSamolet] = 0;
        }
        default:
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /drop [item number]");
            SendClientMessage(playerid, COLOR_YELLOW, "Item Numbers: 1: Fuelcan, 2: Dice, 3: Briefcase, 4: Cigarettes, 5: Radio");
            SendClientMessage(playerid, COLOR_YELLOW, "Item Numbers: 6: Moonshine, 7: Weed, 8: Cocaine, 9: Heroin, 10: Boat License");
            SendClientMessage(playerid, COLOR_YELLOW, "Item Numbers: 11: Train License, 12: Helicopter License, 13: Airplane License");
        }
    }

    return CMD_SUCCESS;
}

CMD:togchat(playerid, params[])
{
    if (togchat[playerid] == 0)
    {
        togchat[playerid] = 1;
        SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Сега няма да можеш да виждаш какво пишат в главния чат!");
        return 1;
    }
    if (togchat[playerid] == 1)
    {
        togchat[playerid] = 0;
        SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Сега ще можеш да виждаш какво пишат в главиня чат!");
    }
    return 1;
}


CMD:radio(playerid, params[])
{
    if (PlayerInfo[playerid][pRadio] == 0)
        return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш радио!");

    new station[32];
    if (sscanf(params, "s[32]", station))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /radio [radio name]");
        SendClientMessage(playerid, 0x9ACD32FF, "Radio names: City, Njoy, Zrock, Dubstep, Fresh, Veronika, NRJ, Severozapad, Ultra");
        SendClientMessage(playerid, 0x9ACD32FF, "Radio names: 1Rock, Payner, Galaxy, Veselina");
        SendClientMessage(playerid, 0x9ACD32FF, "Използвай '/radio off' за да не чуваш радиото в колата!");
        SendClientMessage(playerid, 0x9ACD32FF, "Използвай '/radio check' за да провериш кой радио канал слушаш!");
        return 1;
    }

    if (strcmp(station, "check", true) == 0)
    {
        if (radion[playerid] == 0 || radioff[playerid] == 1)
            return SendClientMessage(playerid, 0x9ACD32FF, "Твоето радио не е пуснато!");

        switch (radion[playerid])
        {
            case 1: SendClientMessage(playerid, 0x9ACD32FF, "Ти в момента слушаш радио City");
            case 2: SendClientMessage(playerid, 0x9ACD32FF, "Ти в момента слушаш радио Njoy");
            case 3: SendClientMessage(playerid, 0x9ACD32FF, "Ти в момента слушаш радио Zrock");
            case 4: SendClientMessage(playerid, 0x9ACD32FF, "Ти в момента слушаш радио Dubstep");
            case 5: SendClientMessage(playerid, 0x9ACD32FF, "Ти в момента слушаш радио Fresh");
            case 6: SendClientMessage(playerid, 0x9ACD32FF, "Ти в момента слушаш радио Veronika");
            case 7: SendClientMessage(playerid, 0x9ACD32FF, "Ти в момента слушаш радио NRJ");
            case 8: SendClientMessage(playerid, 0x9ACD32FF, "Ти в момента слушаш радио Severozapad");
            case 9: SendClientMessage(playerid, 0x9ACD32FF, "Ти в момента слушаш радио Ultra");
            case 10: SendClientMessage(playerid, 0x9ACD32FF, "Ти в момента слушаш радио 1Rock");
            case 11: SendClientMessage(playerid, 0x9ACD32FF, "Ти в момента слушаш радио Payner");
            case 12: SendClientMessage(playerid, 0x9ACD32FF, "Ти в момента слушаш радио Galaxy");
            case 13: SendClientMessage(playerid, 0x9ACD32FF, "Ти в момента слушаш радио Veselina");
        }
    }
    else if (strcmp(station, "off", true) == 0)
    {
        if (radioff[playerid] == 0)
        {
            radioff[playerid] = 1;
            PlayAudioStreamForPlayer(playerid, "https://www.google.com/");
        }
        else
        {
            radioff[playerid] = 0;
            SendClientMessage(playerid, 0x9ACD32FF, "* Ти вече отново ще чуваш радиото в колата *");
            StopAudioStreamForPlayer(playerid);
        }
    }
    else
    {
        // Radio station selection
        if (strcmp(station, "city", true) == 0)
        {
            radioff[playerid] = 0;
            radion[playerid] = 1;
            SendClientMessage(playerid, 0x9ACD32FF, "* Ти пусна радио City *");
            PlayAudioStreamForPlayer(playerid, "http://149.13.0.80/city64.m3u");
        }
        else if (strcmp(station, "njoy", true) == 0)
        {
            radioff[playerid] = 0;
            radion[playerid] = 2;
            SendClientMessage(playerid, 0x9ACD32FF, "* Ти пусна радио Njoy *");
            PlayAudioStreamForPlayer(playerid, "http://live.btvradio.bg/njoy.mp3.m3u");
        }
        else if (strcmp(station, "zrock", true) == 0)
        {
            radioff[playerid] = 0;
            radion[playerid] = 3;
            SendClientMessage(playerid, 0x9ACD32FF, "* Ти пусна радио Zrock *");
            PlayAudioStreamForPlayer(playerid, "http://live.btvradio.bg/z-rock.mp3.m3u");
        }
        else if (strcmp(station, "dubstep", true) == 0)
        {
            radioff[playerid] = 0;
            radion[playerid] = 4;
            SendClientMessage(playerid, 0x9ACD32FF, "* Ти пусна радио Dubstep *");
            PlayAudioStreamForPlayer(playerid, "http://listen.di.fm/public3/dubstep.pls");
        }
        else if (strcmp(station, "fresh", true) == 0)
        {
            radioff[playerid] = 0;
            radion[playerid] = 5;
            SendClientMessage(playerid, 0x9ACD32FF, "* Ти пусна радио Fresh *");
            PlayAudioStreamForPlayer(playerid, "http://193.108.24.21:8000/fresh.m3u");
        }
        else if (strcmp(station, "veronika", true) == 0)
        {
            radioff[playerid] = 0;
            radion[playerid] = 6;
            SendClientMessage(playerid, 0x9ACD32FF, "* Ти пусна радио Veronika *");
            PlayAudioStreamForPlayer(playerid, "http://149.13.0.81/veronika64.m3u");
        }
        else if (strcmp(station, "nrj", true) == 0)
        {
            radioff[playerid] = 0;
            radion[playerid] = 7;
            SendClientMessage(playerid, 0x9ACD32FF, "* Ти пусна радио NRJ *");
            PlayAudioStreamForPlayer(playerid, "http://149.13.0.81/nrj64.m3u");
        }
        else if (strcmp(station, "severozapad", true) == 0)
        {
            radioff[playerid] = 0;
            radion[playerid] = 8;
            SendClientMessage(playerid, 0x9ACD32FF, "* Ти пусна радио Severozapad *");
            PlayAudioStreamForPlayer(playerid, "http://stream-bg.net:8020/severozapad.m3u");
        }
        else if (strcmp(station, "ultra", true) == 0)
        {
            radioff[playerid] = 0;
            radion[playerid] = 9;
            SendClientMessage(playerid, 0x9ACD32FF, "* Ти пусна радио Ultra *");
            PlayAudioStreamForPlayer(playerid, "http://ultranet.biz/ultrapernik.m3u");
        }
        else if (strcmp(station, "1rock", true) == 0)
        {
            radioff[playerid] = 0;
            radion[playerid] = 10;
            SendClientMessage(playerid, 0x9ACD32FF, "* Ти пусна радио 1Rock *");
            PlayAudioStreamForPlayer(playerid, "http://149.13.0.81/1rock128.m3u");
        }
        else if (strcmp(station, "payner", true) == 0)
        {
            radioff[playerid] = 0;
            radion[playerid] = 11;
            SendClientMessage(playerid, 0x9ACD32FF, "* Ти пусна радио Payner *");
            PlayAudioStreamForPlayer(playerid, "http://78.129.224.11:29120/listen.pls");
        }
        else if (strcmp(station, "galaxy", true) == 0)
        {
            radioff[playerid] = 0;
            radion[playerid] = 12;
            SendClientMessage(playerid, 0x9ACD32FF, "* Ти пусна радио Galaxy *");
            PlayAudioStreamForPlayer(playerid, "http://87.117.228.65:35961.pls");
        }
        else if (strcmp(station, "veselina", true) == 0)
        {
            radioff[playerid] = 0;
            radion[playerid] = 13;
            SendClientMessage(playerid, 0x9ACD32FF, "* Ти пусна радио Veselina *");
            PlayAudioStreamForPlayer(playerid, "http://31.13.223.148:8000/veselina/mp3");
        }
        else
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Няма такова радио!");
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /radio [radio name]");
            SendClientMessage(playerid, 0x9ACD32FF, "Radio names: City, Njoy, Zrock, Dubstep, Fresh, Veronika, NRJ, Severozapad, Ultra");
            SendClientMessage(playerid, 0x9ACD32FF, "Radio names: 1Rock, Payner, Galaxy, Veselina");
        }
    }

    return 1;
}

CMD:santahat(playerid, params[])
{
    if (month != 12)
        return 1;

    new hatID;
    if (sscanf(params, "i", hatID))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /santahat [1-3]");
        return 1;
    }

    if (hatID < 1 || hatID > 3)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Шапките са от 1 до 3!");

    switch (hatID)
    {
        case 1: santaHatObject[playerid] = SetPlayerAttachedObject(playerid, 9, 19064, 2, 0.120000, 0.040000, -0.003500, 0, 100, 100, 1.4, 1.4, 1.4);
        case 2: santaHatObject[playerid] = SetPlayerAttachedObject(playerid, 9, 19065, 2, 0.120000, 0.040000, -0.003500, 0, 100, 100, 1.4, 1.4, 1.4);
        case 3: santaHatObject[playerid] = SetPlayerAttachedObject(playerid, 9, 19066, 2, 0.120000, 0.040000, -0.003500, 0, 100, 100, 1.4, 1.4, 1.4);
    }

    SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Използвай бутоните за да нагласиш обжекта. Когато си готов натисни дискетата или ESC за да се сейфа!");
    EditAttachedObject(playerid, 9);
    santaHat[playerid] = true;

    return 1;
}

CMD:drink(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 4, 497.4557, -75.6231, 998.7578) && !IsPlayerInRangeOfPoint(playerid, 4, 499.3484, -20.5936, 1000.6797) &&
            !IsPlayerInRangeOfPoint(playerid, 4, 1215.0492, -12.2688, 1000.9219) && !IsPlayerInRangeOfPoint(playerid, 4, 287.8558, -109.2027, 1001.5156) && !IsPlayerInRangeOfPoint(playerid, 4, -224.7806, 1404.6755, 27.7734) &&
            !IsPlayerInRangeOfPoint(playerid, 4, 2537.1509, -1286.3304, 1054.6406))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си в бар за да използваш тази команда!");
        return 1;
    }
    if (BizInfo[enteredbiz[playerid]][bOwner] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Бизнесът няма притежател и не можеш да си купиш напитка от тук!");
        return 1;
    }
    ShowPlayerDialog(playerid, 23, DIALOG_STYLE_LIST, "Напитки", "{FFFFFF}Бира - {40BF00}$50\n{FFFFFF}Вино - {40BF00}$60\n{FFFFFF}Водка - {40BF00}$100", "Избери", "Излез");
    return 1;
}

CMD:healme(playerid, params[])
{
    if (playerInDuel[playerid] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Ти си в дуел и не можеш да ползваш тази команда!");
    //if(inevent[playerid]==1) return SendClientMessage(playerid,0xB4B5B7FF,"Не можеш да използваш тази команда, докато си в евент!");
    if (inevent[playerid] == 1 && dhealme == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Командата /healme е забранена в евента!");
    if (PlayerInfo[playerid][pVip] >= 3 || freevip == 1)
    {
        if (PlayerInfo[playerid][pHealT] <= 0)
        {
            SetPlayerHealth(playerid, 100);
            SetPlayerArmour(playerid, 100);
            SendClientMessage(playerid, 0x008000FF, "Ти зареди твоята кръв и жилетка на 100!");
            PlayerInfo[playerid][pHealT] = 6 * 60;
        }
        else
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Не е изминало нужното време от последното използване на командата!");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    }
    return 1;
}
CMD:dice(playerid, params[])
{
    new dice1 = randomex(1, 7);
    if (PlayerInfo[playerid][pDice] == 1)
    {
        new zarstring[256];
        format(zarstring, 256, "%s метна зарче и се падна числото %d", GetPlayerNickname(playerid), dice1);
        ProxDetector(15.0, playerid, zarstring, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш зарче за хвърляне!");
    }
    return 1;
}
CMD:heal(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 67, 1302.0842, 0.8015, 1001.0249) && !IsPlayerInRangeOfPoint(playerid, 4, 287.8558, -109.2027, 1001.5156) &&
            !IsPlayerInRangeOfPoint(playerid, 4, -1395.4200, 1245.6000, 1039.8672))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си в бизнес за оръжия или DM за да използваш тази команда!");
        return 1;
    }
    if (PlayerInfo[playerid][pCash] < 100)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $100 за да си купиш жилетка!");
        return 1;
    }
    if (BizInfo[enteredbiz[playerid]][bOwner] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Бизнесът няма притежател и не можеш да си купиш жилетка от тук!");
        return 1;
    }
    new Float:armour;
    GetPlayerArmour(playerid, armour);
    if (armour == 100) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече имаш 100 процента жилетка!");
    SetPlayerArmour(playerid, 100);
    //SetPlayerHealth(playerid,100);
    GivePlayerCash(playerid, -100);
    BizInfo[enteredbiz[playerid]][bEarnings] += 100;
    return 1;
}

CMD:back(playerid, params[])
{
    if (PlayerInfo[playerid][pAFK] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в AFK режим!");
        return 1;
    }
    if (PlayerInfo[playerid][pAFKBack] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се върнеш 3 минути след като си написал /afk!");
        return 1;
    }
    SetPlayerHealth(playerid, 0);
    format(string256, 256, "AFK: %s се върна в играта!", GetPlayerNickname(playerid));
    SendClientMessageToAll(0xD6F34AFF, string256);
    PlayerInfo[playerid][pAFK] = 0;
    return 1;
}
CMD:afk(playerid, params[])
{
    if (PlayerInfo[playerid][pAFK] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече си AFK!");
        return 1;
    }
    if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (PlayerInfo[playerid][pADuty] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да влезеш в AFK в момента!");
    if (PlayerInfo[playerid][pWanted] > 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да влезеш в AFK в момента!");
    if (cmn1[playerid] > 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да влезеш в AFK в момента1!");
    if (playerInDuel[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да влезеш в AFK в момента!");
    if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да влезеш в AFK в момента!");
    if (PlayerInfo[playerid][pJail] != 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да влезеш в AFK в момента!");
    if (PlayerInfo[playerid][pPJail] != 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да влезеш в AFK в момента!");
    if (playerInDMON[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да влезеш в AFK в момента!");
    ResetPlayerWeapons(playerid);
    SetPlayerInterior(playerid, 15);
    SetPlayerColor(playerid, 0xD6F34AFF);
    SetPlayerPos(playerid, 2215.454833, -1147.475585, 1025.796875);
    format(string256, 256, "AFK: %s излезе в почивка!", GetPlayerNickname(playerid));
    SendClientMessageToAll(0xD6F34AFF, string256);
    SendClientMessage(playerid, 0xD6F34AFF, "AFK: Използвай /back като се върнеш!");
    PlayerInfo[playerid][pAFK] = 1;
    PlayerInfo[playerid][pAFKBack] = 3 * 60;
    SetPlayerVirtualWorld(playerid, playerid);
    return 1;
}

CMD:mdutyoff(playerid, params[])
{
    if (IsPlayerInRangeOfPoint(playerid, 3, 1652.8765, 2199.9587, 10.8203) || IsPlayerInRangeOfPoint(playerid, 3, 1015.9524, -1026.5002, 32.1016))
    {
        if (towTruckSkin[playerid] == false)
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Твоят скин не е на механик!");
            return 1;
        }
        RestartPlayerSkin(playerid);
        towTruckSkin[playerid] = false;
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си до гаража за механици!");
    }
    return 1;
}

CMD:mduty(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 3, 1652.8765, 2199.9587, 10.8203) && !IsPlayerInRangeOfPoint(playerid, 3, 1015.9524, -1026.5002, 32.1016))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си до гаража за механици!");
        return 1;
    }

    new skinSelect;
    if (sscanf(params, "d", skinSelect))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /mduty [1-2]");
        SendClientMessage(playerid, 0xFFFF00FF, "Цена: $50");
        return 1;
    }

    if (skinSelect < 1 || skinSelect > 2)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Скиновете на механиците са от 1 до 2!");
        return 1;
    }

    if (PlayerInfo[playerid][pCash] < 50)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да станеш механик!");
        return 1;
    }

    GivePlayerCash(playerid, -50);
    towTruckSkin[playerid] = true;

    switch (skinSelect)
    {
        case 1: SetPlayerSkin(playerid, 42);
        case 2: SetPlayerSkin(playerid, 50);
    }

    return 1;
}

CMD:spawn(playerid, params[])
{
    new option;
    if (sscanf(params, "d", option))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /spawn [0-5]");
        SendClientMessage(playerid, 0xFFFF00FF, "0: Office, 1: Civil, 2: Faction, 3: IFC, 4: House, 5: Bizz");
        return 1;
    }

    if (option < 0 || option > 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Тази опция не съществува!");
        return 1;
    }

    switch (option)
    {
        case 0:
        {
            if (PlayerInfo[playerid][pSpawnO] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Твоят spawn вече е на Office!");
            SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Ти промени твоя spawn на Office spawn!");
        }
        case 1:
        {
            if (PlayerInfo[playerid][pSpawnO] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Твоят spawn вече е на Civl!");
            SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Ти промени твоя spawn на Civil spawn!");
        }
        case 2:
        {
            if (PlayerInfo[playerid][pTeam] == FACTION_CIVILIAN)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в банда/мафия!");
                return 1;
            }
            if (PlayerInfo[playerid][pSpawnO] == 2) return SendClientMessage(playerid, 0xB4B5B7FF, "Твоят spawn вече е на Faction!");
            SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Ти промени твоя spawn на Faction spawn!");
        }
        case 3:
        {
            if (PlayerInfo[playerid][pSpawnO] == 3) return SendClientMessage(playerid, 0xB4B5B7FF, "Твоят spawn вече е на Intense Fuel Company!");
            if (PlayerInfo[playerid][pIFC] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Intense Fuel Company!");
            SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Ти промени твоя spawn на IFC spawn!");
        }
        case 4:
        {
            if (PlayerInfo[playerid][pSpawnO] == 4) return SendClientMessage(playerid, 0xB4B5B7FF, "Твоят spawn вече е на къща!");
            if (PlayerInfo[playerid][pHouseO] == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш къща!");
            SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Ти промени твоя spawn на House spawn!");
        }
        case 5:
        {
            if (PlayerInfo[playerid][pSpawnO] == 5) return SendClientMessage(playerid, 0xB4B5B7FF, "Твоят spawn вече е на бизнес!");
            if (PlayerInfo[playerid][pBizO] == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш бизнес!");
            SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Ти промени твоя spawn на Bizz spawn!");
        }
    }

    PlayerInfo[playerid][pSpawnO] = option;
    return 1;
}

CMD:c(playerid, params[])
{
    if (startedevent == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента има евент и не можеш да пускаш брояч!");
    if (activecount == 0)
    {
        format(string256, 256, "*** %s started count ***", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x33CCFFFF, string256);
        GameTextForAll("~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~-~y~ 3 ~g~-", 1500, 3);
        activecount = 1;
        counttime0 = 2;
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента има активен брояч!");
    }
    return 1;
}
CMD:poll(playerid, params[])
{
    if (voteTimer < 1)
    {
        format(string256, 256, "В момента няма гласуване!");
        SendClientMessage(playerid, 0xB4B5B7FF, string256);
        return 1;
    }
    if (PlayerInfo[playerid][pYes] == 1 || PlayerInfo[playerid][pNo] == 1)
    {
        format(string256, 256, "Ти вече си гласувал!");
        SendClientMessage(playerid, 0xB4B5B7FF, string256);
        return 1;
    }
    format(string256, 256, "{60FA00}%s", voteQuestion);
    ShowPlayerDialog(playerid, 11, DIALOG_STYLE_MSGBOX, "VOTЕ:", string256, "ДА", "НЕ");
    return 1;
}

CMD:epay(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if (vehicleid == mechanicDutyVehs[0] || vehicleid == mechanicDutyVehs[1] || vehicleid == mechanicDutyVehs[2] ||
            vehicleid == mechanicDutyVehs[3] || vehicleid == mechanicDutyVehs[4] || vehicleid == mechanicDutyVehs[5] ||
            vehicleid == mechanicDutyVehs[6] || vehicleid == mechanicDutyVehs[7])
    {
        if (PlayerInfo[playerid][pCash] < 150) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш $150 !");
        GivePlayerCash(playerid, -150);
        SendClientMessage(playerid, 0x808000FF, "Сега ще можеш да ползваш Tow Truck-a докато не излезеш от него. Използвай /tow за да закачаш или откачаш коли!");
        SendClientMessage(playerid, 0x9ACD32FF, "* Ти включи двигателят на превозното средство *");
        ToggleEngine(vehicleid, VEHICLE_PARAMS_ON);
        return 1;
    }
    return 1;
}

CMD:exit(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if (vehicleid == mechanicDutyVehs[0] || vehicleid == mechanicDutyVehs[1] || vehicleid == mechanicDutyVehs[2] ||
            vehicleid == mechanicDutyVehs[3] || vehicleid == mechanicDutyVehs[4] || vehicleid == mechanicDutyVehs[5] ||
            vehicleid == mechanicDutyVehs[6] || vehicleid == mechanicDutyVehs[7])
    {
        RemovePlayerFromVehicle(playerid);
        return 1;
    }
    if (IsPlayerInRangeOfPoint(playerid, 2, 478.3596, -22.0018, 1002.2813))
    {
        SetPlayerPos(playerid, 478.2492, -19.3125, 1000.6797);
    }
    CheckPlayerExitBiz(playerid);
    CheckPlayerExitHouse(playerid);
    if (IsPlayerInRangeOfPoint(playerid, 3.0, -1444.0856, 1087.5129, 1040.7969) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 15)
    {
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, 2006.8207, 1167.4012, 10.8203);
        SetPlayerFacingAngle(playerid, 1040.7969);
        SetCameraBehindPlayer(playerid);
    }
    if (IsPlayerInRangeOfPoint(playerid, 3.0, -1444.0856, 1087.5129, 1040.7969) && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerInterior(playerid) == 15)
    {
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, 1411.5128, -1699.5909, 13.5395);
        SetPlayerFacingAngle(playerid, 1040.7969);
        SetPlayerVirtualWorld(playerid, 0);
        SetCameraBehindPlayer(playerid);
    }
    if (IsPlayerInRangeOfPoint(playerid, 3.0, 2467.6345, -1698.2460, 1013.5078) && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerInterior(playerid) == 2)
    {
        if (PlayerInfo[playerid][pTeam] != 8) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на San Fierro Rifa!");
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, -2182.9065, 956.6106, 80.0000);
        SetPlayerFacingAngle(playerid, 92.8459);
        SetPlayerVirtualWorld(playerid, 0);
        SetCameraBehindPlayer(playerid);
    }
    return 1;
}


CMD:enter(playerid, params[])
{
    if (IsPlayerInRangeOfPoint(playerid, 2, 478.2492, -19.3125, 1000.6797))
    {
        SetPlayerPos(playerid, 478.3596, -22.0018, 1002.2813);
        GivePlayerCash(playerid, -50);
        BizInfo[enteredbiz[playerid]][bEarnings] += 50;
    }
    new alb = playerInBizPickup[playerid];

    if (IsPlayerNearBiz(alb))
    {
        if (BizInfo[alb][bLocked] == 1)
        {
            GameTextForPlayer(playerid, "locked", 3000, 1);
            return SendClientMessage(playerid, 0x499BD4FF, "Бизнесът е заключен и не можеш да влезеш !");
        }
        if (BizInfo[alb][bFee] > PlayerInfo[playerid][pCash] && PlayerInfo[playerid][pBizO] != alb)
        {
            return SendClientMessage(playerid, 0xFFFFFFFF, "Нямаш достатъчно пари за да влезеш в бизнеса !");
        }
        if (PlayerInfo[playerid][pBizO] != alb)
        {
            GivePlayerCash(playerid, -BizInfo[alb][bFee]);
            BizInfo[alb][bEarnings] += BizInfo[alb][bFee];
        }
        enteredbiz[playerid] = alb;
        if (BizInfo[alb][bType] == 1) // 24/7 Business
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the shop.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, -27.3025, -57.6649, 1003.5469);
            SetPlayerFacingAngle(playerid, 357.5915);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 6);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s's ? ??????? ?? (( /buy )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            // return 1;
        }
        if (BizInfo[alb][bType] == 2) // Bar Business
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the shop.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 501.980987, -69.150199, 998.757812);
            SetPlayerFacingAngle(playerid, 179.826400);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 11);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s's ? ???? ?? (( /drinks )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //  return 1;
        }
        if (BizInfo[alb][bType] == 3) // Ammunation Business
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the shop.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 296.8089, -112.0065, 1001.5156);
            SetPlayerFacingAngle(playerid, 76.7251);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 6);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s's ? ???????? ?? ?? ?????? (( /Buyweapon )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            // return 1;
        }
        if (BizInfo[alb][bType] == 4) // + Club Business
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the shop.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, -2026.9447, -103.6024, 1035.1832);
            SetPlayerFacingAngle(playerid, 183.4428);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 3);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s's ? ?????????? ?? (( /buyvehicle )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //  return 1;
        }
        if (BizInfo[alb][bType] == 5) // Advertisement Agency
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the shop.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, -27.3512, -31.7518, 1003.5573);
            SetPlayerFacingAngle(playerid, 86.7239);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 4);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s's ? ?????????? ?? ??????? (( /buyfishtools )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //  return 1;
        }
        if (BizInfo[alb][bType] == 6) // Fast Food
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the shop.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 207.054992, -138.804992, 1003.507812);
            SetPlayerFacingAngle(playerid, 182.1137);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 3);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s's ? ???????? ?? ?? ????? (( /buyclothes )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            // return 1;
        }
        if (BizInfo[alb][bType] == 7) // Casino
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 1494.4723, 1303.5813, 1093.2891);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 3);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ?????? (( /dmv )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //return 1;
        }
        if (BizInfo[alb][bType] == 8) // Casino
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 362.8670, -75.1642, 1001.5078);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 10);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ????? ??????? (( /buy )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            // return 1;
        }
        if (BizInfo[alb][bType] == 9) // Casino
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 834.6642, 7.5311, 1004.1870);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 3);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
        }
        if (BizInfo[alb][bType] == 10) // 24/7
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, -25.9455, -141.5480, 1003.5469);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 16);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            // return 1;
        }
        if (BizInfo[alb][bType] == 11) // 24/7
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 203.7447, -50.6649, 1001.8047);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 1);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //  return 1;
        }
        if (BizInfo[alb][bType] == 12) // 24/7
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 285.9084, -86.7750, 1001.5229);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 4);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //  return 1;
        }
        if (BizInfo[alb][bType] == 13) // ammo
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 315.7523, -143.6341, 999.6016);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 7);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //   return 1;
        }
        if (BizInfo[alb][bType] == 14) // ammo
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 493.4793, -24.9576, 1000.6719);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 17);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            // return 1;
        }
        if (BizInfo[alb][bType] == 15) // ammo
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 744.6210, 1436.3411, 1102.7031);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 6);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //  return 1;
        }
        if (BizInfo[alb][bType] == 16) // ammo
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 773.9693, -78.8193, 1000.6628);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 7);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            // return 1;
        }
        if (BizInfo[alb][bType] == 17) // ammo
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 774.1560, -50.4766, 1000.5859);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 6);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            // return 1;
        }
        if (BizInfo[alb][bType] == 18) // ammo
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 1133.2222, -15.8171, 1000.6797);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 12);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            // return 1;
        }
        if (BizInfo[alb][bType] == 19) // ammo
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 1204.7975, -13.8216, 1000.9219);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 2);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            // return 1;
        }
        if (BizInfo[alb][bType] == 20) // ammo
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 1306.8253, 3.2698, 1001.0272);
            SetPlayerFacingAngle(playerid, 90.3947);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 18);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //  return 1;
        }
        if (BizInfo[alb][bType] == 21) // ammo
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 2018.6144, 1017.7792, 996.8750);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 10);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //  return 1;
        }
        if (BizInfo[alb][bType] == 22) // ammo
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 2234.1011, 1714.4489, 1012.3828);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 1);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //return 1;
        }
        if (BizInfo[alb][bType] == 23) // ammo
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, -229.1534, 1401.3180, 27.7656);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 18);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //  return 1;
        }
        if (BizInfo[alb][bType] == 24) // ammo
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 377.0852, -193.3047, 1000.6328);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 17);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //  return 1;
        }
        if (BizInfo[alb][bType] == 25) // ammo
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 364.9964, -11.8438, 1001.8516);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 9);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //  return 1;
        }
        if (BizInfo[alb][bType] == 26) // ammo
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 460.5563, -88.6419, 999.5547);
            SetPlayerFacingAngle(playerid, 0.4216);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 4);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //  return 1;
        }
        if (BizInfo[alb][bType] == 28) // ammo
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 1727.7561, -1638.0088, 20.2230);
            SetPlayerFacingAngle(playerid, 172.4654);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 18);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //  return 1;
        }
        if (BizInfo[alb][bType] == 29) // ammo
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, 2541.9399, -1304.0100, 1025.0703);
            SetPlayerFacingAngle(playerid, 345.3745);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 2);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //  return 1;
        }
        if (BizInfo[alb][bType] == 30) // ammo
        {
            //format(string, sizeof(string), "* %s pushes the door and enters the casino.", RPN(playerid));
            //SendNearbyMessage(playerid, 15, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
            SetPlayerPos(playerid, -1395.4200, 1245.6000, 1039.8672);
            SetPlayerFacingAngle(playerid, 92.1224);
            SetCameraBehindPlayer(playerid);
            SetPlayerInterior(playerid, 16);
            SetPlayerVirtualWorld(playerid, alb + 500);
            //format(string, sizeof(string), "** ????? ????? ??? %s ??? ??????? ?? ?? ????????? (( /bet )) **", BizInfo[b][bOwner]);
            //SendClientMessage(playerid, COLOR_ORANGE, string);
            //  return 1;
        }
        if (BizInfo[alb][bType] == 27) // 24/7 Business
        {
            SendClientMessage(playerid, 0x499BD4FF, "В този бизнес не може да се влиза !");
        }

    }
    new alh = playerInHousePickup[playerid];
    if (IsValidHouse(alh))
    {
        if (IsPlayerInRangeOfPoint(playerid, 3, HouseInfo[alh][hX], HouseInfo[alh][hY], HouseInfo[alh][hZ]))
        {
            if (HouseInfo[alh][hLocked] == 1 && PlayerInfo[playerid][pHouseO] != alh)
            {
                GameTextForPlayer(playerid, "locked", 3000, 1);
                return SendClientMessage(playerid, 0x00FF40FF, "Къщата е заключена и не можеш да влезеш!");
            }
            SetPlayerVirtualWorld(playerid, alh + 50);
            enteredhouse[playerid] = alh;
            if (HouseInfo[alh][hInterior] == 1)
            {
                SetPlayerPos(playerid, 2283.04, -1140.28, 1050.90);
                SetPlayerFacingAngle(playerid, 267.0980);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 11);
            }
            if (HouseInfo[alh][hInterior] == 2)
            {
                SetPlayerPos(playerid, 243.72, 304.91, 999.15);
                SetPlayerFacingAngle(playerid, 267.3974);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 1);
            }
            if (HouseInfo[alh][hInterior] == 3)
            {
                SetPlayerPos(playerid, 2308.77, -1212.94, 1049.02);
                SetPlayerFacingAngle(playerid, 359.8550);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 6);
            }
            if (HouseInfo[alh][hInterior] == 4)
            {
                SetPlayerPos(playerid, 377.15, 1417.41, 1081.33);
                SetPlayerFacingAngle(playerid, 1.6415);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 15);
            }
            if (HouseInfo[alh][hInterior] == 5)
            {
                SetPlayerPos(playerid, 446.99, 1397.07, 1084.30);
                SetPlayerFacingAngle(playerid, 359.1347);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 2);
            }
            if (HouseInfo[alh][hInterior] == 6)
            {
                SetPlayerPos(playerid, 2237.59, -1081.64, 1049.02);
                SetPlayerFacingAngle(playerid, 89.1791);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 2);
            }
            if (HouseInfo[alh][hInterior] == 7)
            {
                SetPlayerPos(playerid, 260.85, 1237.24, 1084.26);
                SetPlayerFacingAngle(playerid, 359.8550);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 9);
            }
            if (HouseInfo[alh][hInterior] == 8)
            {
                SetPlayerPos(playerid, 2807.48, -1174.76, 1025.57);
                SetPlayerFacingAngle(playerid, 89.4224);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 8);
            }
            if (HouseInfo[alh][hInterior] == 9)
            {
                SetPlayerPos(playerid, 83.03, 1322.28, 1083.87);
                SetPlayerFacingAngle(playerid, 0.7248);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 9);
            }
            if (HouseInfo[alh][hInterior] == 10)
            {
                SetPlayerPos(playerid, 2495.98, -1692.08, 1014.74);
                SetPlayerFacingAngle(playerid, 359.5183);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 3);
            }
            if (HouseInfo[alh][hInterior] == 11)
            {
                SetPlayerPos(playerid, -42.5628, 1405.5011, 1084.4297);
                SetPlayerFacingAngle(playerid, 359.5183);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 8);
            }
            if (HouseInfo[alh][hInterior] == 12)
            {
                SetPlayerPos(playerid, -68.7704, 1352.9250, 1080.2109);
                SetPlayerFacingAngle(playerid, 359.5183);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 6);
            }
            if (HouseInfo[alh][hInterior] == 13)
            {
                SetPlayerPos(playerid, 83.0758, 1322.2808, 1083.8662);
                SetPlayerFacingAngle(playerid, 359.5183);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 9);
            }
            if (HouseInfo[alh][hInterior] == 14)
            {
                SetPlayerPos(playerid, 140.2254, 1365.9796, 1083.8594);
                SetPlayerFacingAngle(playerid, 359.5183);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 5);
            }
            if (HouseInfo[alh][hInterior] == 15)
            {
                SetPlayerPos(playerid, 223.1015, 1287.0764, 1082.1406);
                SetPlayerFacingAngle(playerid, 359.5183);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 1);
            }
            if (HouseInfo[alh][hInterior] == 16)
            {
                SetPlayerPos(playerid, 225.8726, 1021.4523, 1084.0177);
                SetPlayerFacingAngle(playerid, 359.5183);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 7);
            }
            if (HouseInfo[alh][hInterior] == 17)
            {
                SetPlayerPos(playerid, 226.2984, 1114.3319, 1080.9929);
                SetPlayerFacingAngle(playerid, 359.5183);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 5);
            }
            if (HouseInfo[alh][hInterior] == 18)
            {
                SetPlayerPos(playerid, 261.0904, 1284.2944, 1080.2578);
                SetPlayerFacingAngle(playerid, 359.5183);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 4);
            }
            if (HouseInfo[alh][hInterior] == 19)
            {
                SetPlayerPos(playerid, 309.0916, 313.6412, 1003.3047);
                SetPlayerFacingAngle(playerid, 359.5183);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 4);
            }
            if (HouseInfo[alh][hInterior] == 20)
            {
                SetPlayerPos(playerid, 318.5932, 1114.4792, 1083.8828);
                SetPlayerFacingAngle(playerid, 359.5183);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 5);
            }
            if (HouseInfo[alh][hInterior] == 21)
            {
                SetPlayerPos(playerid, 327.9635, 1477.7430, 1084.4375);
                SetPlayerFacingAngle(playerid, 359.5183);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 15);
            }
            if (HouseInfo[alh][hInterior] == 22)
            {
                SetPlayerPos(playerid, 1260.6464, -785.4418, 1091.9063);
                SetPlayerFacingAngle(playerid, 359.5183);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 5);
            }
            if (HouseInfo[alh][hInterior] == 23)
            {
                SetPlayerPos(playerid, 2468.8413, -1698.4177, 1013.5078);
                SetPlayerFacingAngle(playerid, 359.5183);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 2);
            }
            if (HouseInfo[alh][hInterior] == 24)
            {
                SetPlayerPos(playerid, 2196.8506, -1204.2477, 1049.0234);
                SetPlayerFacingAngle(playerid, 359.5183);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 6);
            }
            if (HouseInfo[alh][hInterior] == 25)
            {
                SetPlayerPos(playerid, 2270.3855, -1210.4730, 1047.5625);
                SetPlayerFacingAngle(playerid, 359.5183);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 10);
            }
            if (HouseInfo[alh][hInterior] == 26)
            {
                SetPlayerPos(playerid, 2324.5479, -1149.5146, 1050.7101);
                SetPlayerFacingAngle(playerid, 359.5183);
                SetCameraBehindPlayer(playerid);
                SetPlayerInterior(playerid, 12);
            }
        }
    }
    if (IsPlayerInRangeOfPoint(playerid, 3.0, 1411.5128, -1699.5909, 13.5395) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerInterior(playerid, 15);
        SetPlayerPos(playerid, -1444.0856, 1087.5129, 1040.7969);
        SetPlayerFacingAngle(playerid, 1040.7969);
        SetPlayerVirtualWorld(playerid, 1);
        SetCameraBehindPlayer(playerid);
    }
    if (IsPlayerInRangeOfPoint(playerid, 3.0, 2006.8207, 1167.4012, 10.8203) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerInterior(playerid, 15);
        SetPlayerPos(playerid, -1444.0856, 1087.5129, 1040.7969);
        SetPlayerFacingAngle(playerid, 1040.7969);
        SetCameraBehindPlayer(playerid);
    }
    if (IsPlayerInRangeOfPoint(playerid, 3.0, -2182.9065, 956.6106, 80.0000) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
    {
        if (PlayerInfo[playerid][pTeam] != 8) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на San Fierro Rifa!");
        SetPlayerInterior(playerid, 2);
        SetPlayerVirtualWorld(playerid, 1);
        SetPlayerPos(playerid, 2467.6345, -1698.2460, 1013.5078);
        SetPlayerFacingAngle(playerid, 92.8459);
        SetCameraBehindPlayer(playerid);
    }
    return 1;
}


CMD:unignore(playerid, params[])
{
    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /unignore [ID на играч]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този играч, който сте въвели не в онлайн в момента");
        return CMD_SUCCESS;
    }

    if (playerid == targetid)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да премахнеш игнориране от себе си!");
        return CMD_SUCCESS;
    }

    if (ignore[playerid][targetid] == 0)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Ти не си игнорирал този играч!");
        return CMD_SUCCESS;
    }

    ignore[playerid][targetid] = 0;

    new togapmstring[256];
    format(togapmstring, sizeof(togapmstring), "Ти премахна игнорирането на %s от твоите лични съобщения!", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0xFFFF00FF, togapmstring);

    format(togapmstring, sizeof(togapmstring), "* %s премахна игнорирането от неговите лични съобщения!", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFF00FF, togapmstring);

    return CMD_SUCCESS;
}
CMD:ignore(playerid, params[])
{
    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /ignore [ID на играч]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този играч, който сте въвели не в онлайн в момента");
        return 1;
    }

    if (playerid == targetid)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да игнорираш себе си!");
        return 1;
    }

    if (ignore[playerid][targetid] == 1)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Ти вече си игнорирал този играч!");
        return 1;
    }

    ignore[playerid][targetid] = 1;

    new togapmstring[256];
    format(togapmstring, sizeof(togapmstring), "Ти игнорира %s от твоите лични съобщения!", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFF00FF, togapmstring);

    format(togapmstring, sizeof(togapmstring), "* %s те игнорира от личните си съобщения!", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0xFFFF00FF, togapmstring);

    return 1;
}

CMD:pm(playerid, params[])
{
    new targetid, message[128];
    if (sscanf(params, "ds[128]", targetid, message))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /pm [playerid] [text]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return 1;
    }

    if (playerid == targetid)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да изпратиш лично съобщение до себе си!");
        return 1;
    }

    if (PlayerInfo[playerid][pIgnorePM] == 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си игнорирал своите лични съобщения!");
        return 1;
    }

    if (PlayerInfo[targetid][pIgnorePM] == 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Играчът е игнорирал своите лични съобщения!");
        return 1;
    }

    if (ignore[targetid][playerid] == 1)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този играч ти е забранил да му изпращаш съобщения!");
        return 1;
    }

    if (strlen(message) < 1)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /pm [playerid] [text]");
        return 1;
    }

    // Set reply target
    replyPm[playerid] = true;
    PlayerInfo[playerid][pLastPM] = targetid;

    // Send messages to both players
    new pmString[256];

    // To receiver
    format(pmString, sizeof(pmString), "* PM from %s(ID: %d): %s", GetPlayerNickname(playerid), playerid, message);
    SendClientMessage(targetid, 0xFFFF00FF, pmString);

    // To sender
    format(pmString, sizeof(pmString), "* PM to %s(ID: %d): %s", GetPlayerNickname(targetid), targetid, message);
    SendClientMessage(playerid, 0xFFFF00FF, pmString);

    // AFK notification
    if (PlayerInfo[targetid][pAFK] > 0)
    {
        SendClientMessage(playerid, 0x636363FF, "Играчът е AFK и може да не види твоето съобщение!");
    }

    // Send to players with PM logging enabled
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pTogPM] == 1)
        {
            new logString[256];
            format(logString, sizeof(logString), "* PM from %s(ID: %d) to %s(ID: %d): %s",
                   GetPlayerNickname(playerid), playerid, GetPlayerNickname(targetid), targetid, message);
            SendClientMessage(i, 0xFFFF00FF, logString);
        }
    }

    return 1;
}
CMD:dm(playerid, params[])
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
    if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда в момента!");
    if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда в момента!");
    if (PlayerInfo[playerid][pPJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в затвора и не можеш да се телепортираш!");
        return 1;
    }
    new Float:pHealth;
    GetPlayerHealth(playerid, pHealth);
    new Float:pArmour;
    GetPlayerArmour(playerid, pArmour);
    if (pHealth <= 99 && pArmour <= 99)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си под 100 жилетка и 100 кръв!");
        return 1;
    }
    SetPlayerPos(playerid, 2391.9109, 1038.5081, 10.8203);
    SetPlayerFacingAngle(playerid, 177.0329);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SendClientMessage(playerid, 0xFFFFFFFF, "Ти успешно се телепортира на DM");
    SetCameraBehindPlayer(playerid);
    return 1;
}
CMD:dm2(playerid, params[])
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
    if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (PlayerInfo[playerid][pPJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в затвора и не можеш да се телепортираш!");
        return 1;
    }
    new Float:pHealth;
    GetPlayerHealth(playerid, pHealth);
    new Float:pArmour;
    GetPlayerArmour(playerid, pArmour);
    if (pHealth <= 99 && pArmour <= 99)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си под 100 жилетка и 100 кръв!");
        return 1;
    }
    SetPlayerPos(playerid, -2062.0593, -111.3933, 35.3256);
    SetPlayerFacingAngle(playerid, 177.0329);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SendClientMessage(playerid, 0xFFFFFFFF, "Ти успешно се телепортира на DM 2");
    SetCameraBehindPlayer(playerid);
    return 1;
}

CMD:r(playerid, params[])
{
    if (replyPm[playerid] == false)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си изпратил лично съобщение до никого!");
        return 1;
    }

    new targetid = PlayerInfo[playerid][pLastPM];

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return 1;
    }

    if (PlayerInfo[targetid][pIgnorePM] == 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Играчът е игнорирал своите лични съобщения!");
        return 1;
    }

    if (PlayerInfo[playerid][pVip] < 2 && CheckFreeVIP() == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
        return 1;
    }

    if (PlayerInfo[playerid][pIgnorePM] == 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си игнорирал своите лични съобщения!");
        return 1;
    }

    // Check if target has ignored the player
    if (ignore[targetid][playerid] == 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч е игнорирал твоите лични съобщения!");
        return 1;
    }

    new message[128];
    if (sscanf(params, "s[128]", message))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /r [text]");
        return 1;
    }

    // Send messages to both players
    new pmString[256];

    // To receiver
    format(pmString, sizeof(pmString), "* PM from %s(ID: %d): %s", GetPlayerNickname(playerid), playerid, message);
    SendClientMessage(targetid, 0xFFFF00FF, pmString);

    // To sender
    format(pmString, sizeof(pmString), "* PM to %s(ID: %d): %s", GetPlayerNickname(targetid), targetid, message);
    SendClientMessage(playerid, 0xFFFF00FF, pmString);

    // AFK notification
    if (PlayerInfo[targetid][pAFK] > 0)
    {
        SendClientMessage(playerid, 0x636363FF, "Играчът е AFK и може да не види твоето съобщение!");
    }

    // Send to players with PM logging enabled
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pTogPM] == 1)
        {
            new logString[256];
            format(logString, sizeof(logString), "* PM from %s(ID: %d) to %s(ID: %d): %s",
                   GetPlayerNickname(playerid), playerid, GetPlayerNickname(targetid), targetid, message);
            SendClientMessage(i, 0xFFFF00FF, logString);
        }
    }

    return 1;
}

CMD:pay(playerid, params[])
{
    new targetid, amount;
    if (sscanf(params, "ui", targetid, amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /pay [playerid] [стойност]");
        return 1;
    }

    if (amount < 1 || amount > 100000000)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Парите трябва да са от 1 до 100 000 000.");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Посоченото ID не е в сървъра!");
        return 1;
    }

    if (!CorDetector(4.0, playerid, targetid))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Ти не си близо до играчът на който искаш да дадеш пари!");
        return 1;
    }

    if (PlayerInfo[playerid][pCash] < amount)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш толкова пари!");
        return 1;
    }

    GivePlayerCash(playerid, -amount);
    GivePlayerCash(targetid, amount);

    new stringpay[128];
    format(stringpay, sizeof(stringpay), "{FFFFFF}Ти даде пари на {FFFFFF}%s {FFFFFF}на стойност {40BF00}$%d.", GetPlayerNickname(targetid), amount);
    SendClientMessage(playerid, 0xFFFFFFFF, stringpay);

    format(stringpay, sizeof(stringpay), "{FFFFFF}Ти получи пари на стойност {40BF00}$%d {FFFFFF}от {FFFFFF}%s.", amount, GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0xFFFFFFFF, stringpay);

    return 1;
}

CMD:kasa(playerid, params[])
{
    new stringKasa[256];
    format(stringKasa, 256, "КАСА: {FFFFFF}Вие притежавате {33AA33}%.2f лв{FFFFFF}, регистрирани на вашия профил!", PlayerInfo[playerid][pKasaLV]);
    SendClientMessage(playerid, 0xFFFF00FF, stringKasa);
    return 1;
}

CMD:tog(playerid, params[])
{
    new option;
    if (sscanf(params, "d", option))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /tog [chat number]");
        SendClientMessage(playerid, 0xFFFF00FF, "Chat Numbers: 1: Global, 2: Admin, 3: Test Admin, 4: Faction, 5: Leader");
        return 1;
    }

    if (option < 1 || option > 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Тази опция не съществува!");
        return 1;
    }

    switch (option)
    {
        case 1: // Global chat
        {
            if (togchat[playerid] == 0)
            {
                SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Сега няма да можеш да виждаш какво пишат в главния чат!");
                togchat[playerid] = 1;
            }
            else
            {
                SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Сега ще можеш да виждаш какво пишат в главния чат!");
                togchat[playerid] = 0;
            }
        }

        case 2: // Admin chat
        {
            if (PlayerInfo[playerid][pAdmin] == 0)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
                return 1;
            }

            if (PlayerInfo[playerid][pAHide] == 0)
            {
                SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Сега няма да можеш да виждаш какво пишат в ADMIN чата!");
                PlayerInfo[playerid][pAHide] = 1;
            }
            else
            {
                SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Сега ще можеш да виждаш какво пишат в ADMIN чата!");
                PlayerInfo[playerid][pAHide] = 0;
            }
        }

        case 3: // Test Admin chat
        {
            if (PlayerInfo[playerid][pTest] == 0)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
                return 1;
            }

            if (PlayerInfo[playerid][pAHide] == 0)
            {
                SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Сега няма да можеш да виждаш какво пишат в TEST ADMIN чата!");
                PlayerInfo[playerid][pAHide] = 1;
            }
            else
            {
                SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Сега ще можеш да виждаш какво пишат в TEST ADMIN чата!");
                PlayerInfo[playerid][pAHide] = 0;
            }
        }

        case 4: // Faction chat
        {
            if (PlayerInfo[playerid][pTeam] == FACTION_CIVILIAN)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в банда/мафия!");
                return 1;
            }

            if (PlayerInfo[playerid][pTogFaction] == 0)
            {
                SendClientMessage(playerid, 0x33CCFFFF, "SERVER: Сега няма да виждаш какво пишат във FACTION чата!");
                PlayerInfo[playerid][pTogFaction] = 1;
            }
            else
            {
                SendClientMessage(playerid, 0x33CCFFFF, "SERVER: Сега ще виждаш какво пишат във FACTION чата!");
                PlayerInfo[playerid][pTogFaction] = 0;
            }
        }

        case 5: // Leader chat
        {
            if (PlayerInfo[playerid][pRank] < 6)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
                return 1;
            }

            if (PlayerInfo[playerid][pTogLeader] == 0)
            {
                SendClientMessage(playerid, 0xD9CCC8FF, "SERVER: Сега няма да виждаш какво пишат във LEADER чата!");
                PlayerInfo[playerid][pTogLeader] = 1;
            }
            else
            {
                SendClientMessage(playerid, 0xD9CCC8FF, "SERVER: Сега ще виждаш какво пишат във LEADER чата!");
                PlayerInfo[playerid][pTogLeader] = 0;
            }
        }
    }

    return 1;
}

CMD:accept(playerid, params[])
{
    if (GotoInvite[playerid] == -1)
    {
        return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш заявка за телепортация!");
    }

    new Float:plocx, Float:plocy, Float:plocz;
    new adminID = GotoInvite[playerid];
    GetPlayerPos(playerid, plocx, plocy, plocz);
    SetPlayerInterior(playerid, GetPlayerInterior(playerid));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(playerid));
    if (GetPlayerState(adminID) == 2)
    {
        SetVehiclePos(GetPlayerVehicleID(adminID), plocx, plocy + 4, plocz);
    }
    else
    {
        SetPlayerPos(adminID, plocx, plocy + 2, plocz);
    }
    format(string115, 115, "Ти прие заявката на %s и той се телепортира до теб", GetPlayerNickname(adminID));
    SendClientMessage(playerid, 0xFFFF00FF, string115);
    format(string115, 115, "%s прие твоята заявка и ти беше телепортиран до него", GetPlayerNickname(playerid));
    SendClientMessage(adminID, 0xFFFFFFFF, string115);
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAHide] == 0)
        {
            format(string115, 115, "Teleport: %s се телепортира до %s", GetPlayerNickname(adminID), GetPlayerNickname(playerid));
            SendClientMessage(i, 0xE60000FF, string115);
        }
    }

    GotoInvite[playerid] = -1;
    return 1;
}
CMD:reject(playerid, params[])
{
    if (GotoInvite[playerid] == -1)
    {
        return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш заявка за телепортация!");
    }
    new adminID = GotoInvite[playerid];
    format(string115, 115, "Ти отказа заявката на %s да се телепортира до теб", GetPlayerNickname(adminID));
    SendClientMessage(playerid, 0xFFFF00FF, string115);
    format(string115, 115, "%s отказа твоята заявка за телепортация", GetPlayerNickname(playerid));
    SendClientMessage(adminID, 0xFFFFFFFF, string115);

    GotoInvite[playerid] = -1;
    return 1;
}