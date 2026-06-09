CMD:drugs(playerid, params[])
{
    format(string256, 256, "Спиртно питие: %d литра, Трева: %d грам(а), Кокаин %d грам(а), Хероин %d грам(а)", PlayerInfo[playerid][pMoonshine], PlayerInfo[playerid][pWeed], PlayerInfo[playerid][pCocaine], PlayerInfo[playerid][pHeroin]);
    SendClientMessage(playerid, 0xFF2D2DFF, string256);
    return 1;
}



CMD:bcase(playerid, params[])
{
    if (PlayerInfo[playerid][pBriefcase] == 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш куфарче!");

    new action[32];
    if (sscanf(params, "s[32]", action))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /briefcase(/bcase) [hold/hide/store/get/view]");
        return 1;
    }

    // GET action
    if (strcmp(action, "get", true) == 0)
    {
        if (!IsPlayerAttachedObjectSlotUsed(playerid, 4))
            return SendClientMessage(playerid, 0xB4B5B7FF, "Ти в момента не държиш куфара в ръце!");

        new drug[32], amount;
        if (sscanf(params, "s[32]s[32]d", action, drug, amount))
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /briefcase(/bcase) get [drug name] [gram/liter]");
            SendClientMessage(playerid, 0xFF2D2DFF, "Drug names: Moonshine, Weed, Cocaine, Heroin");
            return 1;
        }

        if (amount < 1 || amount > 1000)
            return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да съхраняваш дрога с количество от 1 до 1000!");

        //new string256[256];
        if (strcmp(drug, "moonshine", true) == 0)
        {
            if (amount > PlayerInfo[playerid][pMoonshine1])
                return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш толкова литра спиртно питие в куфара!");

            PlayerInfo[playerid][pMoonshine1] -= amount;
            PlayerInfo[playerid][pMoonshine] += amount;

            if (amount == 1)
                SendClientMessage(playerid, 0xFF2D2DFF, "Ти взе 1 литър спиртно питие от твоя куфар!");
            else
            {
                format(string256, sizeof(string256), "Ти взе %d литра спиртно питие от твоя куфар!", amount);
                SendClientMessage(playerid, 0xFF2D2DFF, string256);
            }
        }
        else if (strcmp(drug, "cocaine", true) == 0)
        {
            if (amount > PlayerInfo[playerid][pCocaine1])
                return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш толкова грама кокаин в куфара!");

            PlayerInfo[playerid][pCocaine1] -= amount;
            PlayerInfo[playerid][pCocaine] += amount;

            if (amount == 1)
                SendClientMessage(playerid, 0xFF2D2DFF, "Ти взе 1 грам кокаин от твоя куфар!");
            else
            {
                format(string256, sizeof(string256), "Ти взе %d грама кокаин от твоя куфар!", amount);
                SendClientMessage(playerid, 0xFF2D2DFF, string256);
            }
        }
        else if (strcmp(drug, "heroin", true) == 0)
        {
            if (amount > PlayerInfo[playerid][pHeroin1])
                return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш толкова грама хероин в куфара!");

            PlayerInfo[playerid][pHeroin1] -= amount;
            PlayerInfo[playerid][pHeroin] += amount;

            if (amount == 1)
                SendClientMessage(playerid, 0xFF2D2DFF, "Ти взе 1 грам хероин от твоя куфар!");
            else
            {
                format(string256, sizeof(string256), "Ти взе %d грама хероин от твоя куфар!", amount);
                SendClientMessage(playerid, 0xFF2D2DFF, string256);
            }
        }
        else if (strcmp(drug, "weed", true) == 0)
        {
            if (amount > PlayerInfo[playerid][pWeed1])
                return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш толкова грама трева в куфара!");

            PlayerInfo[playerid][pWeed1] -= amount;
            PlayerInfo[playerid][pWeed] += amount;

            if (amount == 1)
                SendClientMessage(playerid, 0xFF2D2DFF, "Ти взе 1 грам трева от твоя куфар!");
            else
            {
                format(string256, sizeof(string256), "Ти взе %d грама трева от твоя куфар!", amount);
                SendClientMessage(playerid, 0xFF2D2DFF, string256);
            }
        }
        else
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /briefcase(/bcase) get [drug name] [gram/liter]");
            SendClientMessage(playerid, 0xFF2D2DFF, "Drug names: Moonshine, Weed, Cocaine, Heroin");
        }
    }
    // VIEW action
    else if (strcmp(action, "view", true) == 0)
    {
        if (!IsPlayerAttachedObjectSlotUsed(playerid, 4))
            return SendClientMessage(playerid, 0xB4B5B7FF, "Ти в момента не държиш куфара в ръце!");

        //new string256[256];
        format(string256, sizeof(string256), "Спиртно питие: %d литра, Трева: %d грам(а), Кокаин %d грам(а), Хероин %d грам(а)", 
            PlayerInfo[playerid][pMoonshine1], PlayerInfo[playerid][pWeed1], PlayerInfo[playerid][pCocaine1], PlayerInfo[playerid][pHeroin1]);
        SendClientMessage(playerid, 0xFF2D2DFF, string256);
    }
    // STORE action
    else if (strcmp(action, "store", true) == 0)
    {
        if (!IsPlayerAttachedObjectSlotUsed(playerid, 4))
            return SendClientMessage(playerid, 0xB4B5B7FF, "Ти в момента не държиш куфара в ръце!");

        new drug[32], amount;
        if (sscanf(params, "s[32]s[32]d", action, drug, amount))
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /briefcase(/bcase) store [drug name] [gram/liter]");
            SendClientMessage(playerid, 0xFF2D2DFF, "Drug names: Moonshine, Weed, Cocaine, Heroin");
            return 1;
        }

        if (amount < 1 || amount > 1000)
            return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да съхраняваш дрога с количество от 1 до 1000!");

        //new string256[256];
        if (strcmp(drug, "moonshine", true) == 0)
        {
            if (amount > PlayerInfo[playerid][pMoonshine])
                return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш толкова литра спиртно питие!");

            if (amount + PlayerInfo[playerid][pMoonshine1] > 1000)
                return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да съхраняваш дрога с количество от 1 до 1000!");

            PlayerInfo[playerid][pMoonshine] -= amount;
            PlayerInfo[playerid][pMoonshine1] += amount;

            if (amount == 1)
                SendClientMessage(playerid, 0xFF2D2DFF, "Ти съхрани 1 литър спиртно питие в твоя куфар!");
            else
            {
                format(string256, sizeof(string256), "Ти съхрани %d литра спиртно питие в твоя куфар!", amount);
                SendClientMessage(playerid, 0xFF2D2DFF, string256);
            }
        }
        else if (strcmp(drug, "weed", true) == 0)
        {
            if (amount > PlayerInfo[playerid][pWeed])
                return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш толкова грама трева!");

            if (amount + PlayerInfo[playerid][pWeed1] > 1000)
                return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да съхраняваш дрога с количество от 1 до 1000!");

            PlayerInfo[playerid][pWeed] -= amount;
            PlayerInfo[playerid][pWeed1] += amount;

            if (amount == 1)
                SendClientMessage(playerid, 0xFF2D2DFF, "Ти съхрани 1 грам трева в твоя куфар!");
            else
            {
                format(string256, sizeof(string256), "Ти съхрани %d грама трева в твоя куфар!", amount);
                SendClientMessage(playerid, 0xFF2D2DFF, string256);
            }
        }
        else if (strcmp(drug, "cocaine", true) == 0)
        {
            if (amount > PlayerInfo[playerid][pCocaine])
                return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш толкова грама кокаин!");

            if (amount + PlayerInfo[playerid][pCocaine1] > 1000)
                return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да съхраняваш дрога с количество от 1 до 1000!");

            PlayerInfo[playerid][pCocaine] -= amount;
            PlayerInfo[playerid][pCocaine1] += amount;

            if (amount == 1)
                SendClientMessage(playerid, 0xFF2D2DFF, "Ти съхрани 1 грам кокаин в твоя куфар!");
            else
            {
                format(string256, sizeof(string256), "Ти съхрани %d грама кокаин в твоя куфар!", amount);
                SendClientMessage(playerid, 0xFF2D2DFF, string256);
            }
        }
        else if (strcmp(drug, "heroin", true) == 0)
        {
            if (amount > PlayerInfo[playerid][pHeroin])
                return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш толкова грама хероин!");

            if (amount + PlayerInfo[playerid][pHeroin1] > 1000)
                return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да съхраняваш дрога с количество от 1 до 1000!");

            PlayerInfo[playerid][pHeroin] -= amount;
            PlayerInfo[playerid][pHeroin1] += amount;

            if (amount == 1)
                SendClientMessage(playerid, 0xFF2D2DFF, "Ти съхрани 1 грам хероин в твоя куфар!");
            else
            {
                format(string256, sizeof(string256), "Ти съхрани %d грама хероин в твоя куфар!", amount);
                SendClientMessage(playerid, 0xFF2D2DFF, string256);
            }
        }
        else
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /briefcase(/bcase) store [drug name] [gram/liter]");
            SendClientMessage(playerid, 0xFF2D2DFF, "Drug names: Moonshine, Weed, Cocaine, Heroin");
        }
    }
    // HIDE action
    else if (strcmp(action, "hide", true) == 0)
    {
        if (IsPlayerAttachedObjectSlotUsed(playerid, 4))
            RemovePlayerAttachedObject(playerid, 4);
    }
    // HOLD action
    else if (strcmp(action, "hold", true) == 0)
    {
        new hand[32];
        if (sscanf(params, "s[32]s[32]", action, hand))
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /briefcase(/bcase) hold [left/right]");
            return 1;
        }

        if (strcmp(hand, "left", true) == 0)
        {
            if (IsPlayerAttachedObjectSlotUsed(playerid, 4))
                RemovePlayerAttachedObject(playerid, 4);
            SetPlayerAttachedObject(playerid, 4, 1210, 5, 0.250000, 0.100000, 0.000000, 0.000000, 264.337768, 21.619852, 1.000000, 1.000000, 1.000000);
        }
        else if (strcmp(hand, "right", true) == 0)
        {
            if (IsPlayerAttachedObjectSlotUsed(playerid, 4))
                RemovePlayerAttachedObject(playerid, 4);
            SetPlayerAttachedObject(playerid, 4, 1210, 6, 0.250000, 0.100000, 0.000000, 0.000000, 264.337768, 21.619852, 1.000000, 1.000000, 1.000000);
        }
        else
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /briefcase(/bcase) hold [left/right]");
        }
    }
    // Invalid action
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Невалидна опция!");
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /briefcase(/bcase) [hold/hide/store/get/view]");
    }
    return 1;
}
CMD:briefcase(playerid, params[]) return cmd_bcase(playerid, params);

CMD:buydrug(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 4, -1395.4200, 1245.6000, 1039.8672) && !IsPlayerInRangeOfPoint(playerid, 4, 2548.3892, -1293.2520, 1044.1250))
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си във фабрика за дрога за да използваш тази команда!");
    }

    if (BizInfo[enteredbiz[playerid]][bOwner] == 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Бизнесът няма притежател и не можеш да пазаруваш от тук!");
    }

    new drug[32], amount;
    if (sscanf(params, "s[32]d", drug, amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /buydrug [drug name] [gram/liter]");
        SendClientMessage(playerid, 0xFFFF00FF, "Drug names: Moonshine $5000, Weed $6000, Cocaine $8000, Heroin $9000");
        SendClientMessage(playerid, 0xFF2D2DFF, "Всяка цена е за грам/литър и всеки наркотик има ефект!");
        SendClientMessage(playerid, 0xFF2D2DFF, "При употреба на 1 литър Weed (трева) получаваш 20 HEALTH и резачка (за 13 сек.)");
        SendClientMessage(playerid, 0xFF2D2DFF, "При употреба на 1 литър Moonshine (спиртно питие) получаваш 20 HEALTH и резачка (за 13 сек.)");
        SendClientMessage(playerid, 0xFF2D2DFF, "При употреба на 1 литър Cocaine (кокаин) получаваш 20 HEALTH и резачка (за 13 сек.)");
        SendClientMessage(playerid, 0xFF2D2DFF, "При употреба на 1 литър Heroin (хероин) получаваш 20 HEALTH и резачка (за 13 сек.)");
        SendClientMessage(playerid, 0xFF2D2DFF, "ВНИМАНИЕ: Ако бъдеш убит и имаш дрога в себе си ще я загубиш затова използвай куфар да я съхраняваш!");
        SendClientMessage(playerid, 0xFF2D2DFF, "Куфар (briefcase) можеш да вземеш от бизнес 24/7 Shop или General Store!");
        return 1;
    }

    if (amount < 1 || amount > 100000)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да въведеш стойност на грама/литъра, по-голяма от 0!");
    }

    //new string256[256];
    if (strcmp(drug, "moonshine", true) == 0)
    {
        new cost = amount * 5000;
        if (PlayerInfo[playerid][pCash] < cost)
            return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш достатъчно пари!");

        PlayerInfo[playerid][pMoonshine] += amount;
        GivePlayerCash(playerid, -cost);
        BizInfo[enteredbiz[playerid]][bEarnings] += cost;

        if (amount == 1)
            format(string256, sizeof(string256), "Ти си купи %d литър спиртно питие и това ти струваше $%d", amount, cost);
        else
            format(string256, sizeof(string256), "Ти си купи %d литра спиртно питие и това ти струваше $%d", amount, cost);

        SendClientMessage(playerid, 0xFF2D2DFF, string256);
    }
    else if (strcmp(drug, "weed", true) == 0)
    {
        new cost = amount * 6000;
        if (PlayerInfo[playerid][pCash] < cost)
            return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш достатъчно пари!");

        PlayerInfo[playerid][pWeed] += amount;
        GivePlayerCash(playerid, -cost);
        BizInfo[enteredbiz[playerid]][bEarnings] += cost;

        if (amount == 1)
            format(string256, sizeof(string256), "Ти си купи %d грам трева и това ти струваше $%d", amount, cost);
        else
            format(string256, sizeof(string256), "Ти си купи %d грама трева и това ти струваше $%d", amount, cost);

        SendClientMessage(playerid, 0xFF2D2DFF, string256);
    }
    else if (strcmp(drug, "cocaine", true) == 0)
    {
        new cost = amount * 8000;
        if (PlayerInfo[playerid][pCash] < cost)
            return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш достатъчно пари!");

        PlayerInfo[playerid][pCocaine] += amount;
        GivePlayerCash(playerid, -cost);
        BizInfo[enteredbiz[playerid]][bEarnings] += cost;

        if (amount == 1)
            format(string256, sizeof(string256), "Ти си купи %d грам кокаин и това ти струваше $%d", amount, cost);
        else
            format(string256, sizeof(string256), "Ти си купи %d грама кокаин и това ти струваше $%d", amount, cost);

        SendClientMessage(playerid, 0xFF2D2DFF, string256);
    }
    else if (strcmp(drug, "heroin", true) == 0)
    {
        new cost = amount * 9000;
        if (PlayerInfo[playerid][pCash] < cost)
            return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш достатъчно пари!");

        PlayerInfo[playerid][pHeroin] += amount;
        GivePlayerCash(playerid, -cost);
        BizInfo[enteredbiz[playerid]][bEarnings] += cost;

        if (amount == 1)
            format(string256, sizeof(string256), "Ти си купи %d грам хероин и това ти струваше $%d", amount, cost);
        else
            format(string256, sizeof(string256), "Ти си купи %d грама хероин и това ти струваше $%d", amount, cost);

        SendClientMessage(playerid, 0xFF2D2DFF, string256);
    }
    else
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Невалиден наркотик!");
    }

    new now = gettime();
    if (now - lastCriminalDrug[playerid] >= 30)
    {
        lastCriminalDrug[playerid] = now;
        GivePlayerWantedLevel(playerid, 1, "Употреба на дрога");
    }
    
    return 1;
}

CMD:usedrug(playerid, params[])
{
    new drug[32];
    if (sscanf(params, "s[32]", drug))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /usedrug [drug name]");
        SendClientMessage(playerid, 0xFF2D2DFF, "Drug names: Moonshine, Weed, Cocaine, Heroin");
        return 1;
    }

    if (strcmp(drug, "moonshine", true) == 0)
    {
        if (PlayerInfo[playerid][pMoonshineEffectTime] > 0)
            return SendClientMessage(playerid, 0xB4B5B7FF, "В момента си под действието на наркотик!");

        if (PlayerInfo[playerid][pMoonshine] == 0)
            return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш спиртно питие!");

        SetPlayerWeather(playerid, 42);
        new Float:health;
        GetPlayerHealth(playerid, health);
        SetPlayerHealth(playerid, health + 20.0);
        
        if (GetPlayerWeapon(playerid) == 9) 
            rezachka[playerid] = 1;
        GivePlayerWeapon(playerid, 9, 1);
        
        PlayerInfo[playerid][pMoonshine] -= 1;
        PlayerInfo[playerid][pMoonshineEffectTime] = 13;
        
        SendClientMessage(playerid, 0xFF2D2DFF, "Ти използва спиртно питие! (+20 Health, Chainsaw for 13 seconds)");
    }
    else if (strcmp(drug, "cocaine", true) == 0)
    {
        if (PlayerInfo[playerid][pCocaineEffectTime] > 0)
            return SendClientMessage(playerid, 0xB4B5B7FF, "В момента си под действието на наркотик!");

        if (PlayerInfo[playerid][pCocaine] == 0)
            return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш кокаин!");

        SetPlayerWeather(playerid, 50);
        new Float:armour;
        GetPlayerArmour(playerid, armour);
        SetPlayerArmour(playerid, armour + 25.0);
        
        if (GetPlayerWeapon(playerid) == 9) 
            rezachka[playerid] = 1;
        GivePlayerWeapon(playerid, 9, 1);
        
        PlayerInfo[playerid][pCocaine] -= 1;
        PlayerInfo[playerid][pCocaineEffectTime] = 8;
        
        SendClientMessage(playerid, 0xFF2D2DFF, "Ти използва кокаин! (+25 Armor, Chainsaw for 8 seconds)");
    }
    else if (strcmp(drug, "weed", true) == 0)
    {
        if (PlayerInfo[playerid][pWeedEffectTime] > 0)
            return SendClientMessage(playerid, 0xB4B5B7FF, "В момента си под действието на наркотик!");

        if (PlayerInfo[playerid][pWeed] == 0)
            return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш трева!");

        SetPlayerWeather(playerid, 50);
        new Float:health;
        GetPlayerHealth(playerid, health);
        SetPlayerHealth(playerid, health + 50.0);
        
        if (GetPlayerWeapon(playerid) == 9) 
            rezachka[playerid] = 1;
        GivePlayerWeapon(playerid, 9, 1);
        
        PlayerInfo[playerid][pWeed] -= 1;
        PlayerInfo[playerid][pWeedEffectTime] = 10;
        
        SendClientMessage(playerid, 0xFF2D2DFF, "Ти използва трева! (+50 Health, Chainsaw for 10 seconds)");
    }
    else if (strcmp(drug, "heroin", true) == 0)
    {
        if (PlayerInfo[playerid][pHeroinEffectTime] > 0)
            return SendClientMessage(playerid, 0xB4B5B7FF, "В момента си под действието на наркотик!");

        if (PlayerInfo[playerid][pHeroin] == 0)
            return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш хероин!");

        SetPlayerWeather(playerid, 100);
        new Float:armour;
        GetPlayerArmour(playerid, armour);
        SetPlayerArmour(playerid, armour + 50.0);
        
        if (GetPlayerWeapon(playerid) == 9) 
            rezachka[playerid] = 1;
        GivePlayerWeapon(playerid, 9, 1);
        
        PlayerInfo[playerid][pHeroin] -= 1;
        PlayerInfo[playerid][pHeroinEffectTime] = 10;
        
        SendClientMessage(playerid, 0xFF2D2DFF, "Ти използва хероин! (+50 Armor, Chainsaw for 10 seconds)");
    }
    else
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /usedrug [drug name]");
        SendClientMessage(playerid, 0xFF2D2DFF, "Drug names: Moonshine, Weed, Cocaine, Heroin");
    }
    
    return 1;
}

