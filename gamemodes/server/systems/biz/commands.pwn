CMD:bizname(playerid, params[])
{
    if (PlayerInfo[playerid][pBizO] == -1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш бизнес!");
        return CMD_SUCCESS;
    }

    new name[256];
    if (sscanf(params, "s[256]", name))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /bizname [name]");
        return CMD_SUCCESS;
    }

    if (strfind(name, "||", true) != -1 || strfind(name, "|", true) != -1 || strfind(name, "~", true) != -1 || strfind(name, ",", true) != -1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не можеш да използваш забранени символи!");
        return CMD_SUCCESS;
    }

    if (strlen(name) < 1 || strlen(name) > 20)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Името на бизнеса трябва да бъде между 1 и 20 символа!");
        return CMD_SUCCESS;
    }

    SendClientMessage(playerid, 0x00CCCCFF, "Ти промени името на твоя бизнес!");
    format(BizInfo[PlayerInfo[playerid][pBizO]][bName], 256, "%s", name);

    return CMD_SUCCESS;
}

CMD:fee(playerid, params[])
{
    if (PlayerInfo[playerid][pBizO] == -1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш бизнес!");
        return CMD_SUCCESS;
    }

    new amount;
    if (sscanf(params, "i", amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /fee [amount]");
        return CMD_SUCCESS;
    }

    new playersBiz = PlayerInfo[playerid][pBizO];

    if (BizInfo[playersBiz][bType] == 27)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Твоят бизнес не може да има цена за вход!");
        return CMD_SUCCESS;
    }

    if (amount < 1 || amount > 50)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Цената на входа трябва да бъде между $1 и $50!");
        return CMD_SUCCESS;
    }

    SendClientMessage(playerid, 0x00CCCCFF, "Ти промени цената за вход в твоя бизнес!");
    BizInfo[playersBiz][bFee] = amount;

    return CMD_SUCCESS;
}

CMD:createbiz(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new price, type, level, payout, ep, epskill, mskill;
    if (sscanf(params, "iiiiiii", price, type, level, payout, ep, epskill, mskill))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /createbiz [price] [type 1-30] [level 1-9999] [payout 1-999999] [ep] [epskill] [mskill]");
        SendClientMessage(playerid, 0x00CCCCFF, "Options: 1: 24/7, 2: Bar, 3: Ammu, 4: License, 5: 24/7, 6: ProLaps, 7: Office");
        SendClientMessage(playerid, 0x00CCCCFF, "Options: 8: BurShot, 9: HorseBet, 10: 24/7, 11: Urban, 12: Ammu, 13: Ammu 14: Disco");
        SendClientMessage(playerid, 0x00CCCCFF, "Options: 15: SexShop, 16: Gym, 17: Gym, 18: Casino, 19: StripClub, 20: DMBizz");
        SendClientMessage(playerid, 0x00CCCCFF, "Options: 21: FourDragons Casino, 22: Caligulas Casino, 23: Bar, 24: Rusty Brounns");
        SendClientMessage(playerid, 0x00CCCCFF, "Options: 25: CluckinBell, 26: Restaurant, 27: N.E., 28: Advert, 29: Drugs, 30: Drugs");
        return CMD_SUCCESS;
    }

    // Validations
    if (price < 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Цената трябва да е по-голяма от $0!");
        return CMD_SUCCESS;
    }

    if (type < 1 || type > 30)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този тип е невалиден!");
        return CMD_SUCCESS;
    }

    if (level < 1 || level > 9999)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нивото на бизнеса трябва да е от 1 до 9999!");
        return CMD_SUCCESS;
    }

    if (payout < 1 || payout > 999999)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "PayOut на бизнеса трябва да е от 1 до 999999!");
        return CMD_SUCCESS;
    }

    if (GetPlayerVirtualWorld(playerid) != 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да създадеш бизнес в този Virtual World!");
        return CMD_SUCCESS;
    }

    if (GetPlayerInterior(playerid) != 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да създадеш бизнес в този Interior!");
        return CMD_SUCCESS;
    }

    // Get player position
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    // Get business name based on type
    new bizname[64];
    switch (type)
    {
        case 1, 5, 10:
            format(bizname, sizeof(bizname), "Store");
        case 2, 23:
            format(bizname, sizeof(bizname), "Bar");
        case 3, 12, 13:
            format(bizname, sizeof(bizname), "Ammu-nation");
        case 4: format(bizname, sizeof(bizname), "DMV");
        case 6: format(bizname, sizeof(bizname), "Prolaps");
        case 7: format(bizname, sizeof(bizname), "Office");
        case 8: format(bizname, sizeof(bizname), "Burger Shot");
        case 9: format(bizname, sizeof(bizname), "Horse Bet");
        case 11: format(bizname, sizeof(bizname), "Urban");
        case 14: format(bizname, sizeof(bizname), "Disco");
        case 15: format(bizname, sizeof(bizname), "Sex Shop");
        case 16, 17:
            format(bizname, sizeof(bizname), "Gym");
        case 18: format(bizname, sizeof(bizname), "Casino");
        case 19: format(bizname, sizeof(bizname), "Strip Club");
        case 20: format(bizname, sizeof(bizname), "DM Biz");
        case 21: format(bizname, sizeof(bizname), "4 Dragons");
        case 22: format(bizname, sizeof(bizname), "CaligulaS");
        case 24, 26:
            format(bizname, sizeof(bizname), "Restaurant");
        case 25: format(bizname, sizeof(bizname), "Cluckin Bell");
        case 27: format(bizname, sizeof(bizname), "Not Enterable");
        case 28: format(bizname, sizeof(bizname), "Advertisiment");
        case 29, 30:
            format(bizname, sizeof(bizname), "Drug Factory");
    }

    new fee = (type != 27) ? 50 : 0;

    // Create database entry
    new query[1024];
    mysql_format(Database, query, sizeof(query),
                 "INSERT INTO businesses (x, y, z, price, type, level, pay_out, ep, ep_skill, ms_skill, locked, owner, owner_name, name, fee) " \
                 "VALUES (%f, %f, %f, %d, %d, %d, %d, %d, %d, %d, 0, 0, 'None', '%s', %d);",
                 x, y, z, price, type, level, payout, ep, epskill, mskill, bizname, fee
                );

    mysql_query(Database, query, true);
    new biz_id = cache_insert_id();

    // Initialize business info
    BizInfo[biz_id][bX] = x;
    BizInfo[biz_id][bY] = y;
    BizInfo[biz_id][bZ] = z;
    BizInfo[biz_id][bPayOut] = payout;
    BizInfo[biz_id][bOwner] = 0;
    BizInfo[biz_id][bLocked] = 0;
    BizInfo[biz_id][bEP] = ep;
    BizInfo[biz_id][bLevel] = level;
    BizInfo[biz_id][bEPSkill] = epskill;
    BizInfo[biz_id][bMSkill] = mskill;
    BizInfo[biz_id][bEarnings] = 0;
    BizInfo[biz_id][bFee] = fee;
    BizInfo[biz_id][bPrice] = price;
    BizInfo[biz_id][bType] = type;

    format(BizInfo[biz_id][bOwnerName], 256, "None");
    format(BizInfo[biz_id][bName], 256, "%s", bizname);

    // Create pickup and 3D text
    bizpickup[biz_id] = CreatePickup(1272, 1, x, y, z, 0);
    BizByPickup[bizpickup[biz_id]] = biz_id;
    //BizByPickup
    if (ep >= 1)
    {
        new text[256];
        format(text, sizeof(text), "{00FF00}Ако притежаваш този бизнес\nще получаваш {FFFFFF}%d EP {00FF00}на всеки {FF0000}Payday", ep);
        BizInfo[biz_id][bText] = Create3DTextLabel(text, 0x00FF00AA, x, y, z, 25.0, 0, 1);
    }
    else
    {
        BizInfo[biz_id][bText] = INVALID_3DTEXT_ID;
    }

    CheckMaxBizID();

    SendClientMessage(playerid, 0x00CCCCFF, "Ти успешно създаде нов бизнес!");
    return CMD_SUCCESS;
}

CMD:bizhelp(playerid, params[])
{
    if (PlayerInfo[playerid][pBizO] == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш бизнес!");
    SendClientMessage(playerid, 0x00CCCCFF, "Команди: /sellbiz /enter /exit /biz /lockbiz /unlockbiz /psellbiz");
    SendClientMessage(playerid, 0x00CCCCFF, "Команди: /bizinfo /bizname /fee /earnings /bizaccept(/ba) /bizcancel(/bc)");
    SendClientMessage(playerid, 0x00CCCCFF, "Команди: /bizswitch /bizswitchaccept(/bsa) /bizswitchcancel(/bsc)");
    return 1;
}
CMD:biz(playerid, params[])
{
    if (PlayerInfo[playerid][pBizO] == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш бизнес!");
    SendClientMessage(playerid, 0x00CCCCFF, "Следвай червения маркер, той ще те отведе до твоя бизнес!");
    new playersBiz = PlayerInfo[playerid][pBizO];
new Float:
    playerBizX = BizInfo[playersBiz][bX];
new Float:
    playerBizY = BizInfo[playersBiz][bY];
new Float:
    playerBizZ = BizInfo[playersBiz][bZ];
    SetPlayerCheckpoint(playerid, playerBizX, playerBizY, playerBizZ, 4.0);
    gpsOn[playerid] = true;
    return 1;
}

CMD:dmv(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 4, -2026.8839, -115.1081, 1035.1719))
    {
        return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да се намираш в училище за шофьори!");
    }

    if (BizInfo[enteredbiz[playerid]][bOwner] == 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Бизнесът няма притежател и не можеш да си купиш книжка от тук!");
    }

    new licensetype;
    if (sscanf(params, "i", licensetype))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /dmv [license number]");
        SendClientMessage(playerid, COLOR_YELLOW, "{003AE6}License Numbers: 1: Лодка, 2: Влак/Трамвай, 3: Хеликоптер, 4: Самолет");
        SendClientMessage(playerid, COLOR_YELLOW, "{003AE6}Трябва да имаш следните левели минимум за всяка шофьорска книжка:");
        SendClientMessage(playerid, COLOR_YELLOW, "{003AE6}Лодка - 8 левел, Влак/Трамвай - 10 левел, Хеликоптер - 12 левел, Самолет - 15 левел");
        SendClientMessage(playerid, COLOR_YELLOW, "{003AE6}Цените за да вземеш определена шофьорска книжка са:");
        SendClientMessage(playerid, COLOR_YELLOW, "{003AE6}Лодка - $5000, Влак/Трамвай - $10000, Хеликоптер - $15000, Самолет - $25000");
        return 1;
    }

    switch (licensetype)
    {
        case 1: // Лодка
        {
            if (PlayerInfo[playerid][pCash] < 5000)
            {
                return SendClientMessage(playerid, COLOR_GRAD1, "Нямаш достатъчно пари, за да си купиш шофьорска книжка за лодка!");
            }
            if (PlayerInfo[playerid][pLevel] < 8)
            {
                return SendClientMessage(playerid, COLOR_GRAD1, "Нямаш достатъчно голямо ниво, за да си купиш шофьорска книжка за лодка!");
            }
            if (PlayerInfo[playerid][pLodka] >= 1)
            {
                return SendClientMessage(playerid, COLOR_GRAD1, "Ти вече имаш шофьорска книжка за лодка!");
            }

            SendClientMessage(playerid, COLOR_YELLOW, "{003AE6}Ти си купи шофьорска книжка за лодка!");
            GivePlayerCash(playerid, -5000);
            BizInfo[enteredbiz[playerid]][bEarnings] += 5000;
            PlayerInfo[playerid][pLodka] = 1;
        }
        case 2: // Влак/Трамвай
        {
            if (PlayerInfo[playerid][pCash] < 10000)
            {
                return SendClientMessage(playerid, COLOR_GRAD1, "Нямаш достатъчно пари, за да си купиш шофьорска книжка за влак/трамвай!");
            }
            if (PlayerInfo[playerid][pLevel] < 10)
            {
                return SendClientMessage(playerid, COLOR_GRAD1, "Нямаш достатъчно голямо ниво, за да си купиш шофьорска книжка за влак/трамвай!");
            }
            if (PlayerInfo[playerid][pVlak] >= 1)
            {
                return SendClientMessage(playerid, COLOR_GRAD1, "Ти вече имаш шофьорска книжка за влак/трамвай!");
            }

            SendClientMessage(playerid, COLOR_YELLOW, "{003AE6}Ти си купи шофьорска книжка за влак/трамвай!");
            GivePlayerCash(playerid, -10000);
            BizInfo[enteredbiz[playerid]][bEarnings] += 10000;
            PlayerInfo[playerid][pVlak] = 1;
        }
        case 3: // Хеликоптер
        {
            if (PlayerInfo[playerid][pCash] < 15000)
            {
                return SendClientMessage(playerid, COLOR_GRAD1, "Нямаш достатъчно пари, за да си купиш шофьорска книжка за хеликоптер!");
            }
            if (PlayerInfo[playerid][pLevel] < 12)
            {
                return SendClientMessage(playerid, COLOR_GRAD1, "Нямаш достатъчно голямо ниво, за да си купиш шофьорска книжка за хеликоптер!");
            }
            if (PlayerInfo[playerid][pHelikopter] >= 1)
            {
                return SendClientMessage(playerid, COLOR_GRAD1, "Ти вече имаш шофьорска книжка за хеликоптер!");
            }

            SendClientMessage(playerid, COLOR_YELLOW, "{003AE6}Ти си купи шофьорска книжка за хеликоптер!");
            GivePlayerCash(playerid, -15000);
            BizInfo[enteredbiz[playerid]][bEarnings] += 15000;
            PlayerInfo[playerid][pHelikopter] = 1;
        }
        case 4: // Самолет
        {
            if (PlayerInfo[playerid][pCash] < 25000)
            {
                return SendClientMessage(playerid, COLOR_GRAD1, "Нямаш достатъчно пари, за да си купиш шофьорска книжка за самолет!");
            }
            if (PlayerInfo[playerid][pLevel] < 15)
            {
                return SendClientMessage(playerid, COLOR_GRAD1, "Нямаш достатъчно голямо ниво, за да си купиш шофьорска книжка за самолет!");
            }
            if (PlayerInfo[playerid][pSamolet] >= 1)
            {
                return SendClientMessage(playerid, COLOR_GRAD1, "Ти вече имаш шофьорска книжка за самолет!");
            }

            SendClientMessage(playerid, COLOR_YELLOW, "{003AE6}Ти си купи шофьорска книжка за самолет!");
            GivePlayerCash(playerid, -25000);
            BizInfo[enteredbiz[playerid]][bEarnings] += 25000;
            PlayerInfo[playerid][pSamolet] = 1;
        }
        default:
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /dmv [license number]");
            SendClientMessage(playerid, COLOR_YELLOW, "{003AE6}License Numbers: 1: Лодка, 2: Влак/Трамвай, 3: Хеликоптер, 4: Самолет");
            SendClientMessage(playerid, COLOR_YELLOW, "{003AE6}Трябва да имаш следните левели минимум за всяка шофьорска книжка:");
            SendClientMessage(playerid, COLOR_YELLOW, "{003AE6}Лодка - 8 левел, Влак/Трамвай - 10 левел, Хеликоптер - 12 левел, Самолет - 15 левел");
            SendClientMessage(playerid, COLOR_YELLOW, "{003AE6}Цените за да вземеш определена шофьорска книжка са:");
            SendClientMessage(playerid, COLOR_YELLOW, "{003AE6}Лодка - $5000, Влак/Трамвай - $10000, Хеликоптер - $15000, Самолет - $25000");
        }
    }

    return 1;
}

CMD:buy(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 4, -30.9303, -28.3415, 1003.5573) && !IsPlayerInRangeOfPoint(playerid, 4, -23.3775, -55.2958, 1003.5469) &&
            !IsPlayerInRangeOfPoint(playerid, 4, 287.8558, -109.2027, 1001.5156) && !IsPlayerInRangeOfPoint(playerid, 4, -1353.9404, 2057.6685, 53.1172) &&
            !IsPlayerInRangeOfPoint(playerid, 4, 369.5925, -6.7357, 1001.8589) && !IsPlayerInRangeOfPoint(playerid, 4, 450.5178, -84.4856, 999.5547) &&
            !IsPlayerInRangeOfPoint(playerid, 4, 203.8465, -44.4779, 1001.8047) && !IsPlayerInRangeOfPoint(playerid, 4, 206.9638, -129.8357, 1003.5078))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си в магазин за да използваш тази команда!");
        return 1;
    }

    new level;
    if (sscanf(params, "d", level))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /buy [номер]");
        return 1;
    }

    // Clothing stores
    if (IsPlayerInRangeOfPoint(playerid, 4, 203.8465, -44.4779, 1001.8047) || IsPlayerInRangeOfPoint(playerid, 4, 206.9638, -129.8357, 1003.5078))
    {
        if (BizInfo[enteredbiz[playerid]][bOwner] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Бизнесът няма притежател и не можеш да си купиш дрехи от тук!");
            return 1;
        }
        if (PlayerInfo[playerid][pCash] < 300)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $300 за да си купиш дрехи!");
            return 1;
        }
        if (level < 1 || level > 4)
        {
            SendClientMessage(playerid, COLOR_YELLOW, "Използвай: /buy [1-4]");
            return 1;
        }

        switch (level)
        {
            case 1: SetPlayerSkin(playerid, 3);
            case 2: SetPlayerSkin(playerid, 23);
            case 3: SetPlayerSkin(playerid, 24);
            case 4: SetPlayerSkin(playerid, 47);
        }

        SendClientMessage(playerid, 0xFFFFFFFF, "Ти си купи нови дрехи за $300!");
        GivePlayerCash(playerid, -300);
        BizInfo[enteredbiz[playerid]][bEarnings] += 300;
        return 1;
    }

    // Restaurants (24/7 and Burgershot)
    if (IsPlayerInRangeOfPoint(playerid, 4, 376.6553, -68.1552, 1001.5151) || IsPlayerInRangeOfPoint(playerid, 4, 2548.3892, -1293.2520, 1044.1250) || IsPlayerInRangeOfPoint(playerid, 4, 450.5178, -84.4856, 999.5547))
    {
        if (BizInfo[enteredbiz[playerid]][bOwner] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Бизнесът няма притежател и не можеш да пазаруваш от тук!");
            return 1;
        }
        if (level < 1 || level > 8)
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /buy [product number]");
            SendClientMessage(playerid, 0xFFFF80FF, "Product numbers: 1: Tea $1, 2: Coffe $1, 3: Cola $2, 4: Toast $2, 5: Soup $3, 6: Chips $4");
            SendClientMessage(playerid, 0xFFFF80FF, "Product numbers: 7: Burger $7, 8: Double Whopper Cheese Burger $20");
            return 1;
        }

        new Float:healthp;
        GetPlayerHealth(playerid, healthp);

        switch (level)
        {
            case 1:
            {
                if (healthp > 90) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да си поръчаш това!");
                SetPlayerHealth(playerid, healthp + 10);
                GivePlayerCash(playerid, -1);
                BizInfo[enteredbiz[playerid]][bEarnings] += 1;
                SendClientMessage(playerid, 0xFFFF80FF, "Ти си купи двоен чай и това ти струваше $1!");
            }
            case 2:
            {
                if (healthp > 90) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да си поръчаш това!");
                SetPlayerHealth(playerid, healthp + 10);
                GivePlayerCash(playerid, -1);
                BizInfo[enteredbiz[playerid]][bEarnings] += 1;
                SendClientMessage(playerid, 0xFFFF80FF, "Ти си купи кафе и това ти струваше $1!");
            }
            case 3:
            {
                if (healthp > 80) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да си поръчаш това!");
                SetPlayerHealth(playerid, healthp + 20);
                GivePlayerCash(playerid, -2);
                BizInfo[enteredbiz[playerid]][bEarnings] += 2;
                SendClientMessage(playerid, 0xFFFF80FF, "Ти си купи кола и това ти струваше $2!");
            }
            case 4:
            {
                if (healthp > 80) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да си поръчаш това!");
                SetPlayerHealth(playerid, healthp + 20);
                GivePlayerCash(playerid, -2);
                BizInfo[enteredbiz[playerid]][bEarnings] += 2;
                SendClientMessage(playerid, 0xFFFF80FF, "Ти си купи тост и това ти струваше $2!");
                ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 0, 0);
            }
            case 5:
            {
                if (healthp > 70) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да си поръчаш това!");
                SetPlayerHealth(playerid, healthp + 30);
                GivePlayerCash(playerid, -3);
                BizInfo[enteredbiz[playerid]][bEarnings] += 3;
                SendClientMessage(playerid, 0xFFFF80FF, "Ти си купи супа и това ти струваше $3!");
                ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 0, 0);
            }
            case 6:
            {
                if (healthp > 60) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да си поръчаш това!");
                SetPlayerHealth(playerid, healthp + 40);
                GivePlayerCash(playerid, -4);
                BizInfo[enteredbiz[playerid]][bEarnings] += 4;
                SendClientMessage(playerid, 0xFFFF80FF, "Ти си купи чипс и това ти струваше $4!");
                ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 0, 0);
            }
            case 7:
            {
                if (healthp > 30) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да си поръчаш това!");
                SetPlayerHealth(playerid, healthp + 70);
                GivePlayerCash(playerid, -7);
                BizInfo[enteredbiz[playerid]][bEarnings] += 7;
                SendClientMessage(playerid, 0xFFFF80FF, "Ти си купи бургер и това ти струваше $7!");
                ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 0, 0);
            }
            case 8:
            {
                if (healthp > 20) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да си поръчаш това!");
                SetPlayerHealth(playerid, healthp + 80);
                GivePlayerCash(playerid, -20);
                BizInfo[enteredbiz[playerid]][bEarnings] += 20;
                SendClientMessage(playerid, 0xFFFF80FF, "Ти си купи двоен чиз бургер и това ти струваше $20!");
                ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 0, 0);
            }
        }
        return 1;
    }

    // Cluckin' Bell
    if (IsPlayerInRangeOfPoint(playerid, 4, 369.5925, -6.7357, 1001.8589))
    {
        if (BizInfo[enteredbiz[playerid]][bOwner] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Бизнесът няма притежател и не можеш да пазаруваш от тук!");
            return 1;
        }
        if (level < 1 || level > 4)
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /buy [menu number]");
            SendClientMessage(playerid, 0xFFFF80FF, "Menu numbers: 1: Cluckin' Little Meal $2, 2: Cluckin' Big Meal $5, 3: Cluckin' Hude Meal $10, 4: Salad Meal $10");
            return 1;
        }

        new Float:healthp;
        GetPlayerHealth(playerid, healthp);

        switch (level)
        {
            case 1:
            {
                if (healthp > 90) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да си поръчаш това!");
                SetPlayerHealth(playerid, healthp + 10);
                GivePlayerCash(playerid, -2);
                BizInfo[enteredbiz[playerid]][bEarnings] += 2;
                SendClientMessage(playerid, 0xFFFF80FF, "Ти си купи меню Cluckin' Little Meal и това ти струваше $2!");
                ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 0, 0);
            }
            case 2:
            {
                if (healthp > 80) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да си поръчаш това!");
                SetPlayerHealth(playerid, healthp + 20);
                GivePlayerCash(playerid, -5);
                BizInfo[enteredbiz[playerid]][bEarnings] += 5;
                SendClientMessage(playerid, 0xFFFF80FF, "Ти си купи меню Cluckin' Big Meal и това ти струваше $5!");
                ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 0, 0);
            }
            case 3:
            {
                if (healthp > 70) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да си поръчаш това!");
                SetPlayerHealth(playerid, healthp + 30);
                GivePlayerCash(playerid, -10);
                BizInfo[enteredbiz[playerid]][bEarnings] += 10;
                SendClientMessage(playerid, 0xFFFF80FF, "Ти си купи меню Cluckin' Huge Meal и това ти струваше $10!");
                ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 0, 0);
            }
            case 4:
            {
                if (healthp > 60) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да си поръчаш това!");
                SetPlayerHealth(playerid, healthp + 40);
                GivePlayerCash(playerid, -10);
                BizInfo[enteredbiz[playerid]][bEarnings] += 10;
                SendClientMessage(playerid, 0xFFFF80FF, "Ти си купи меню Salad Meal и това ти струваше $10!");
                ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 1, 1, 0, 0);
            }
        }
        return 1;
    }

    // Fishing store
    if (IsPlayerInRangeOfPoint(playerid, 4, -1353.9404, 2057.6685, 53.1172))
    {
        if (BizInfo[0][bOwner] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Бизнесът няма притежател и не можеш да пазаруваш от тук!");
            return 1;
        }
        new stringguns[600];
        format(stringguns, 600, "{FFFFFF}Въдица - {40BF00}$350\n{FFFFFF}Стръв(50x) - {40BF00}$100");
        return ShowPlayerDialog(playerid, DIALOG_BUYFISH, DIALOG_STYLE_LIST, "Fishing Store:", stringguns, "Купи", "Излез");
    }

    // Ammunation
    if (IsPlayerInRangeOfPoint(playerid, 4, 287.8558, -109.2027, 1001.5156) || IsPlayerInRangeOfPoint(playerid, 4, -1395.4200, 1245.6000, 1039.8672) ||
            IsPlayerInRangeOfPoint(playerid, 67, 1302.0842, 0.8015, 1001.0249))
    {
        if (BizInfo[enteredbiz[playerid]][bOwner] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Бизнесът няма притежател и не можеш да си купиш напитка от тук!");
            return 1;
        }
        new stringguns[600];
        format(stringguns, 600, "9mm\nSilenced 9mm\nDesert Eagle\nShotgun\nSawnoff\nMP5\nUzi\nTec9\nAK-47\nM4\nCountry Rifle\nSniper Rifle");
        ShowPlayerDialog(playerid, DIALOG_BUYGUNS, DIALOG_STYLE_LIST, "Ammunation:", stringguns, "Избери", "Излез");
        return 1;
    }

    // General store (items)
    if (IsPlayerInRangeOfPoint(playerid, 4, -30.9303, -28.3415, 1003.5573) || IsPlayerInRangeOfPoint(playerid, 4, -23.3775, -55.2958, 1003.5469))
    {
        if (level < 1 || level > 15)
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /buy [item number]");
            SendClientMessage(playerid, 0x91FF8DFF, "Item numbers: 1: Dice $3, 2: Flowers $5, 3: Bat $15, 4: Cane $25, 5: Shovel $30, 6: Pool Cue $80,");
            SendClientMessage(playerid, 0x91FF8DFF, "Item numbers: 7: Cigarettes (x20) $100, 8: Brass Knuckles $120, 9: Fuel Container $150, 10: Knife $150");
            SendClientMessage(playerid, 0x91FF8DFF, "Item numbers: 11: Golf Club $155, 12: Paraschute $250, 13: Katana $250, 14: Radio $1500, 15: Briefcase: $5000");
            return 1;
        }

        switch (level)
        {
            case 1:
            {
                if (PlayerInfo[playerid][pDice] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече имаш зарче!");
                if (PlayerInfo[playerid][pLevel] < 3) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си поне 3 левел за да си купиш зарче!");
                if (PlayerInfo[playerid][pCash] < 3) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $3 за да си купиш зарче!");
                PlayerInfo[playerid][pDice] = 1;
                SendClientMessage(playerid, 0x91FF8DFF, "Ти купи зарче и това ти струваше $3!");
                GivePlayerCash(playerid, -3);
                BizInfo[enteredbiz[playerid]][bEarnings] += 3;
            }
            case 2:
            {
                if (PlayerInfo[playerid][pCash] < 5) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $5 за да си купиш цветя!");
                GivePlayerCash(playerid, -5);
                BizInfo[enteredbiz[playerid]][bEarnings] += 5;
                SendClientMessage(playerid, 0x91FF8DFF, "Ти купи цветя и това ти струваше $5!");
                GivePlayerWeapon(playerid, 14, 1);
            }
            case 3:
            {
                if (PlayerInfo[playerid][pCash] < 15) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $15 за да си купиш бухалка!");
                GivePlayerCash(playerid, -15);
                BizInfo[enteredbiz[playerid]][bEarnings] += 15;
                SendClientMessage(playerid, 0x91FF8DFF, "Ти купи бухалка и това ти струваше $15!");
                GivePlayerWeapon(playerid, 5, 1);
            }
            case 4:
            {
                if (PlayerInfo[playerid][pCash] < 25) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $25 за да си купиш бастун!");
                GivePlayerCash(playerid, -25);
                BizInfo[enteredbiz[playerid]][bEarnings] += 25;
                SendClientMessage(playerid, 0x91FF8DFF, "Ти купи бастун и това ти струваше $25!");
                GivePlayerWeapon(playerid, 15, 1);
            }
            case 5:
            {
                if (PlayerInfo[playerid][pCash] < 30) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $30 за да си купиш лопата!");
                GivePlayerCash(playerid, -30);
                BizInfo[enteredbiz[playerid]][bEarnings] += 30;
                SendClientMessage(playerid, 0x91FF8DFF, "Ти купи лопата и това ти струваше $30!");
                GivePlayerWeapon(playerid, 6, 1);
            }
            case 6:
            {
                if (PlayerInfo[playerid][pCash] < 80) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $80 за да си купиш щека!");
                GivePlayerCash(playerid, -80);
                BizInfo[enteredbiz[playerid]][bEarnings] += 80;
                SendClientMessage(playerid, 0x91FF8DFF, "Ти купи щека и това ти струваше $80!");
                GivePlayerWeapon(playerid, 7, 1);
            }
            case 7:
            {
                if (PlayerInfo[playerid][pLevel] < 3) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си поне 3 левел за да си купиш цигари!");
                if (PlayerInfo[playerid][pCash] < 100) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $100 за да си купиш цигари!");
                SendClientMessage(playerid, 0x91FF8DFF, "Ти купи цигари и това ти струваше $100!");
                PlayerInfo[playerid][pCigarettes] += 20;
                GivePlayerCash(playerid, -100);
                BizInfo[enteredbiz[playerid]][bEarnings] += 100;
            }
            case 8:
            {
                if (PlayerInfo[playerid][pCash] < 120) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $120 за да си купиш бокс!");
                GivePlayerCash(playerid, -120);
                BizInfo[enteredbiz[playerid]][bEarnings] += 120;
                SendClientMessage(playerid, 0x91FF8DFF, "Ти купи бокс и това ти струваше $120!");
                GivePlayerWeapon(playerid, 1, 1);
            }
            case 9:
            {
                if (PlayerInfo[playerid][pFuelcase] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече имаш бутилка за гас!");
                if (PlayerInfo[playerid][pLevel] < 6) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си поне 6 левел за да си купиш бутилка за гас!");
                if (PlayerInfo[playerid][pCash] < 150) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $150 за да си купиш бутилка за гас!");
                SendClientMessage(playerid, 0x91FF8DFF, "Ти купи бутилка за гас и това ти струваше $150!");
                PlayerInfo[playerid][pFuelcase] = 1;
                GivePlayerCash(playerid, -150);
                BizInfo[enteredbiz[playerid]][bEarnings] += 150;
            }
            case 10:
            {
                if (PlayerInfo[playerid][pCash] < 150) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $150 за да си купиш нож!");
                GivePlayerCash(playerid, -150);
                BizInfo[enteredbiz[playerid]][bEarnings] += 150;
                SendClientMessage(playerid, 0x91FF8DFF, "Ти купи нож и това ти струваше $150!");
                GivePlayerWeapon(playerid, 4, 1);
            }
            case 11:
            {
                if (PlayerInfo[playerid][pCash] < 155) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $155 за да си купиш стик за голф!");
                GivePlayerCash(playerid, -155);
                BizInfo[enteredbiz[playerid]][bEarnings] += 155;
                SendClientMessage(playerid, 0x91FF8DFF, "Ти купи стик за голф и това ти струваше $155!");
                GivePlayerWeapon(playerid, 2, 1);
            }
            case 12:
            {
                if (PlayerInfo[playerid][pCash] < 250) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $250 за да си купиш парашут!");
                GivePlayerCash(playerid, -250);
                BizInfo[enteredbiz[playerid]][bEarnings] += 250;
                SendClientMessage(playerid, 0x91FF8DFF, "Ти купи парашут и това ти струваше $250!");
                GivePlayerWeapon(playerid, 46, 1);
            }
            case 13:
            {
                if (PlayerInfo[playerid][pCash] < 250) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $250 за да си купиш меч!");
                GivePlayerCash(playerid, -250);
                BizInfo[enteredbiz[playerid]][bEarnings] += 250;
                SendClientMessage(playerid, 0x91FF8DFF, "Ти купи меч и това ти струваше $250!");
                GivePlayerWeapon(playerid, 8, 1);
            }
            case 14:
            {
                if (PlayerInfo[playerid][pRadio] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече имаш радио!");
                if (PlayerInfo[playerid][pLevel] < 2) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си поне 2 левел за да си купиш радио!");
                if (PlayerInfo[playerid][pCash] < 1500) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $1500 за да си купиш радио!");
                SendClientMessage(playerid, 0x91FF8DFF, "Ти купи радио и това ти струваше $1500!");
                PlayerInfo[playerid][pRadio] = 1;
                GivePlayerCash(playerid, -1500);
                BizInfo[enteredbiz[playerid]][bEarnings] += 1500;
            }
            case 15:
            {
                if (PlayerInfo[playerid][pBriefcase] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече имаш куфарче!");
                if (PlayerInfo[playerid][pLevel] < 5) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си поне 5 левел за да си купиш куфарче!");
                if (PlayerInfo[playerid][pCash] < 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $5000 за да си купиш куфарче!");
                SendClientMessage(playerid, 0x91FF8DFF, "Ти купи куфарче и това ти струваше $5000!");
                PlayerInfo[playerid][pBriefcase] = 1;
                GivePlayerCash(playerid, -5000);
                BizInfo[enteredbiz[playerid]][bEarnings] += 5000;
            }
        }
        return 1;
    }

    return 1;
}

CMD:lockbiz(playerid, params[])
{
    if (PlayerInfo[playerid][pBizO] > -1)
    {
        BizInfo[PlayerInfo[playerid][pBizO]][bLocked] = 1;
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Ти не притежаваш бизнес!");
    }
    return 1;
}
CMD:unlockbiz(playerid, params[])
{
    if (PlayerInfo[playerid][pBizO] > -1)
    {
        BizInfo[PlayerInfo[playerid][pBizO]][bLocked] = 0;
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Ти не притежаваш бизнес!");
    }
    return 1;
}
CMD:bizinfo(playerid, params[])
{
    if (PlayerInfo[playerid][pBizO] == -1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш бизнес!");
    }
    SendClientMessage(playerid, 0x00CCCCFF, "________________________");
    format(string256, 256, "Име на бизнеса: %s", BizInfo[PlayerInfo[playerid][pBizO]][bName]);
    SendClientMessage(playerid, 0x00CCCCFF, string256);
    format(string256, 256, "Цена за вход: $%d", BizInfo[PlayerInfo[playerid][pBizO]][bFee]);
    SendClientMessage(playerid, 0x00CCCCFF, string256);
    format(string256, 256, "Печалба: $%d", BizInfo[PlayerInfo[playerid][pBizO]][bEarnings]);
    SendClientMessage(playerid, 0x00CCCCFF, string256);
    format(string256, 256, "Заплащане: $%d", BizInfo[PlayerInfo[playerid][pBizO]][bPayOut]);
    SendClientMessage(playerid, 0x00CCCCFF, string256);
    SendClientMessage(playerid, 0x00CCCCFF, "________________________");
    return 1;
}
CMD:earnings(playerid, params[])
{
    if (PlayerInfo[playerid][pBizO] == -1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш бизнес!");
    }
    if (BizInfo[PlayerInfo[playerid][pBizO]][bEarnings] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти в момента нямаш пари в бизнеса, които да прибереш!");
    new stringEarnings[256];
    format(stringEarnings, 256, "Ти взе $%d от твоя бизнес!", BizInfo[PlayerInfo[playerid][pBizO]][bEarnings]);
    SendClientMessage(playerid, 0x00CCCCFF, stringEarnings);
    GivePlayerCash(playerid, BizInfo[PlayerInfo[playerid][pBizO]][bEarnings]);
    BizInfo[PlayerInfo[playerid][pBizO]][bEarnings] = 0;
    return 1;
}
/*
    CMD:sellbiz(playerid, params[])
{
    new housenoerror = 0;
    if (PlayerInfo[playerid][pBizO] == -1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш бизнес!");
        return 1;
    }
    new biz = PlayerInfo[playerid][pBizO];

    if (IsPlayerInRangeOfPoint(playerid, 3, BizInfo[biz][bX], BizInfo[biz][bY], BizInfo[biz][bZ]))
    {
        if (!IsValidBiz(biz))
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Твоята къща е изтрита, свържи се с администратор!");
            return 1;
        }
        housenoerror = 1;
        format(BizInfo[biz][bOwnerName], 256, "None");
        BizInfo[biz][bOwner] = 0;

        SaveBiz(biz);

        GivePlayerCash(playerid, BizInfo[biz][bPrice] / 2);
        format(string256[playerid], 256, "Tи продаде бизнеса си за $%d!", BizInfo[biz][bPrice] / 2);
        SendClientMessage(playerid, 0x00CCCCFF, string256[playerid]);
        PlayerInfo[playerid][pBizO] = -1;

    }
    if (housenoerror == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не се намираш близо до бизнеса си!");
    }
    return 1;
}

*/
CMD:buybiz(playerid, params[])
{
    new bizznoerror = 0;
    new alb = IsPlayerNearBiz(playerid);
    if (alb >= 0)
    {
        if (PlayerInfo[playerid][pBizO] > -1)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече притежаваш бизнес!");
            return 1;
        }
        if (BizInfo[alb][bOwner] == 1)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Този бизнес вече има притежател!");
            return 1;
        }
        if (BizInfo[alb][bLevel] > PlayerInfo[playerid][pLevel])
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно голямо ниво за този бизнес!");
            return 1;
        }
        if (BizInfo[alb][bPrice] > PlayerInfo[playerid][pCash])
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно пари за този бизнес!");
            return 1;
        }
        if (BizInfo[alb][bEPSkill] > PlayerInfo[playerid][pEPS])
        {
            new stringRequirement[256];
            format(stringRequirement, 256, "Трябва да имаш поне %d EP Skill за да купиш този бизнес!", BizInfo[alb][bEPSkill]);
            SendClientMessage(playerid, 0xB4B5B7FF, stringRequirement);
            return 1;
        }
        if (BizInfo[alb][bMSkill] > PlayerInfo[playerid][pMS])
        {
            new stringRequirement[256];
            format(stringRequirement, 256, "Трябва да имаш поне %d Money Skill за да купиш този бизнес!", BizInfo[alb][bMSkill]);
            SendClientMessage(playerid, 0xB4B5B7FF, stringRequirement);
            return 1;
        }
        bizznoerror = 1;
        PlayerInfo[playerid][pBizO] = alb;
        format(BizInfo[alb][bOwnerName], 256, "%s", GetPlayerNickname(playerid));
        BizInfo[alb][bOwner] = 1;
        BizInfo[alb][bEarnings] = 0;
        GivePlayerCash(playerid, -BizInfo[alb][bPrice]);
        new stringbiz[256];
        format(stringbiz, 256, "Честито, ти си купи бизнес на стойност $%d!", BizInfo[alb][bPrice]);
        SendClientMessage(playerid, 0x00CCCCFF, stringbiz);

    }
    if (bizznoerror == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не се намираш близо до бизнес!");
    }
    return 1;
}

CMD:sellbiz(playerid, params[])
{
    new housenoerror = 0;
    if (PlayerInfo[playerid][pBizO] == -1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш бизнес!");
        return 1;
    }
    new biz = PlayerInfo[playerid][pBizO];

    if (IsPlayerInRangeOfPoint(playerid, 3, BizInfo[biz][bX], BizInfo[biz][bY], BizInfo[biz][bZ]))
    {
        if (!IsValidBiz(biz))
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Твоята къща е изтрита, свържи се с администратор!");
            return 1;
        }
        housenoerror = 1;
        format(BizInfo[biz][bOwnerName], 256, "None");
        BizInfo[biz][bOwner] = 0;

        SaveBiz(biz);

        GivePlayerCash(playerid, BizInfo[biz][bPrice] / 2);
        format(string256[playerid], 256, "Tи продаде бизнеса си за $%d!", BizInfo[biz][bPrice] / 2);
        SendClientMessage(playerid, 0x00CCCCFF, string256[playerid]);
        PlayerInfo[playerid][pBizO] = -1;

    }
    if (housenoerror == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не се намираш близо до бизнеса си!");
    }
    return 1;
}

CMD:infobiz(playerid, params[])
{
    new alb = IsPlayerNearBiz(playerid);
    if (alb >= 0)
    {
        SendClientMessage(playerid, 0x00CCCCFF, "________________________");
        format(string256, 256, "Име на бизнеса: %s", BizInfo[alb][bName]);
        SendClientMessage(playerid, 0x00CCCCFF, string256);
        format(string256, 256, "Цена за вход: $%d", BizInfo[alb][bFee]);
        SendClientMessage(playerid, 0x00CCCCFF, string256);
        format(string256, 256, "Печалба: $%d", BizInfo[alb][bEarnings]);
        SendClientMessage(playerid, 0x00CCCCFF, string256);
        format(string256, 256, "Заплащане: $%d", BizInfo[alb][bPayOut]);
        SendClientMessage(playerid, 0x00CCCCFF, string256);
        SendClientMessage(playerid, 0x00CCCCFF, "________________________");
        new stringbiz[256];
        format(stringbiz, 256, "Бизнесът има изисквания: %d EP Skill и %d Money Skill", BizInfo[alb][bEPSkill], BizInfo[alb][bMSkill]);
        SendClientMessage(playerid, 0x00CCCCFF, stringbiz);
        return 1;
    }

    SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си близо до бизнес!");
    return 1;
}


CMD:bizswitchaccept(playerid, params[])
{
    if (bizSwitchReceiver[playerid] == -1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не ти е предлаган бизнес за размяна!");

    new senderid = bizSwitchReceiver[playerid];

    new stringReceiver[256];
    format(stringReceiver, sizeof(stringReceiver), "Ти прие поканата за размяна на бизнеси на %s", GetPlayerNickname(senderid));
    SendClientMessage(playerid, 0x00CCCCFF, stringReceiver);

    new currentReceiverBiz = PlayerInfo[senderid][pBizO];

    new stringSender[256];
    format(stringSender, sizeof(stringSender), "%s прие твоята покана за размяна на бизнеси", GetPlayerNickname(playerid));
    SendClientMessage(senderid, 0x00CCCCFF, stringSender);

    new currentSenderBiz = PlayerInfo[playerid][pBizO];

    PlayerInfo[playerid][pBizO] = currentReceiverBiz;
    PlayerInfo[senderid][pBizO] = currentSenderBiz;

    BoughtHouse(playerid, currentReceiverBiz);
    BoughtHouse(senderid, currentSenderBiz);

    bizSwitchReceiver[playerid] = -1;
    bizSwitchSender[senderid] = -1;
    bizSwitching[playerid] = false;
    bizSwitching[senderid] = false;

    return 1;
}

CMD:bizswitchcancel(playerid, params[])
{
    if (bizSwitchReceiver[playerid] == -1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не ти е предлаган бизнес за размяна!");

    new senderid = bizSwitchReceiver[playerid];

    new stringReceiver[256];
    format(stringReceiver, sizeof(stringReceiver), "Ти отказа поканата за размяна на бизнеси на %s", GetPlayerNickname(senderid));
    SendClientMessage(playerid, 0x00CCCCFF, stringReceiver);

    new stringSender[256];
    format(stringSender, sizeof(stringSender), "%s отказа твоята покана за размяна на бизнеси", GetPlayerNickname(playerid));
    SendClientMessage(senderid, 0x00CCCCFF, stringSender);

    bizSwitchReceiver[playerid] = -1;
    bizSwitchSender[senderid] = -1;
    bizSwitching[playerid] = false;
    bizSwitching[senderid] = false;

    return 1;
}

CMD:bizswitch(playerid, params[])
{
    if (PlayerInfo[playerid][pBizO] == -1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш бизнес!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /bizswitch [playerid]");
        return 1;
    }

    if (targetid == playerid)
        return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да размениш бизнеса си със себе си!");

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, COLOR_GRAD1, "Посоченото ID не е в сървъра!");

    if (PlayerInfo[targetid][pBizO] == -1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч няма бизнес!");

    if (bizSwitchSender[playerid] != -1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече си изпратил покана за размяна на бизнеси!");

    if (bizSwitchReceiver[playerid] != -1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече имаш покана за размяна на бизнеси!");

    if (bizSwitchSender[targetid] != -1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч вече има покана за размяна на бизнеси!");

    if (bizSwitchReceiver[targetid] != -1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч вече има покана за размяна на бизнеси!");

    bizSwitchSender[playerid] = targetid;
    bizSwitchReceiver[targetid] = playerid;
    bizSwitching[playerid] = true;
    bizSwitching[targetid] = true;

    new stringSender[256];
    format(stringSender, sizeof(stringSender), "Ти изпрати покана за размяна на бизнеси до %s", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0x00CCCCFF, stringSender);

    new stringReceiver[256];
    format(stringReceiver, sizeof(stringReceiver), "%s ти изпрати покана за размяна на бизнеси.", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0x00CCCCFF, stringReceiver);
    SendClientMessage(targetid, 0x00CCCCFF, "Използвай /bsa за да приемеш или /bsc за да откажеш");

    return 1;
}
