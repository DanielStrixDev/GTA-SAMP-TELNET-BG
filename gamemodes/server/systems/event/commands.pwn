CMD:nameoff(playerid, params[])
{
    if (inevent[playerid] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в евента!");
    if (ename == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Командите /nameon и /nameoff са забранени!");
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        ShowPlayerNameTagForPlayer(i, playerid, 0);
    }
    format(string256, sizeof(string256), "Вече играчите няма да виждат твоето име!", GetPlayerNickname(playerid));
    SendClientMessage(playerid, 0x80FF00FF, string256);
    return 1;
}
CMD:nameon(playerid, params[])
{
    if (inevent[playerid] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в евент!");
    if (ename == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Командите /nameon и /nameoff са забранени!");
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        ShowPlayerNameTagForPlayer(i, playerid, 1);
    }
    format(string256, sizeof(string256), "Вече играчите ще виждат твоето име!", GetPlayerNickname(playerid));
    SendClientMessage(playerid, 0x80FF00FF, string256);
    return 1;
}

CMD:startevent1(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    if (startedevent > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Все още има евент!");
        return 1;
    }

    if (eventmembers > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Все още има играчи от стария евент!");
        return 1;
    }

    new eventName[128];
    if (sscanf(params, "s[128]", eventName))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /startevent1 [event name]");
        return 1;
    }

    // Set event properties
    SetPlayerVirtualWorld(playerid, 1);
    eventclosed = 0;
    eev = 1;
    PlayerInfo[playerid][pOrganisator] = 1;
    cbchat[playerid] = 1;
    startedevent = 2;
    eenter = 0;
    efight = 0;
    ejetpack = 0;
    dhealme = 1;
    etune = 1;
    efix = 1;
    enos = 1;
    ehyd = 1;
    eramp = 0;
    eventlimit = 1000;

    // Get event position
    GetPlayerPos(playerid, eventx, eventy, eventz);
    eventinterior = GetPlayerInterior(playerid);

    // Send game text to all players
    new gameText[256];
    format(gameText, sizeof(gameText), "~r~ %s ~n~ ~w~ TYPE: ~g~/joinevent ~n~ ~p~ WITH AWARD!!!", eventName);

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            GameTextForPlayer(i, gameText, 5000, 3);
        }
    }

    // Send join message
    new message[256];
    format(message, sizeof(message), "%s: {80FF00}Напишете {F2FF00}/joinevent{80FF00} за да се присъедините към евента.{FFFFFF}  С НАГРАДА!", eventName);
    SendClientMessageToAll(0xFF0000FF, message);

    SendClientMessage(playerid, 0xFF9933FF, "CB Channel: Твоят CB Channel беше прехвърлен на 1.");

    return 1;
}

CMD:setarmourall(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    if (startedevent == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        return 1;
    }

    new armour;
    if (sscanf(params, "d", armour))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /setarmourall [armour]");
        return 1;
    }

    if (armour < 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Armour-а трябва да е положително число!");
        return 1;
    }

    new message[128];
    format(message, sizeof(message), "{FF0000}%s{80FF00} сложи жилетката на всички в евента да е %d!", GetPlayerNickname(playerid), armour);
    SendClientMessageToAll(0x80FF00FF, message);

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && inevent[i])
        {
            SetPlayerArmour(i, float(armour));
        }
    }

    return 1;
}


CMD:unfreezeall(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] > 0)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        format(string256, sizeof(string256), "{FF0000}%s{80FF00} отмрази всички в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string256);
        for (new i; i < MAX_PLAYERS; i++)
        {
            if (inevent[i])
            {
                TogglePlayerControllable(i, 1);
            }
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:freezeall(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] > 0)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        format(string256, sizeof(string256), "{FF0000}%s{80FF00} замрази всички в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string256);
        for (new i; i < MAX_PLAYERS; i++)
        {
            if (inevent[i])
            {
                TogglePlayerControllable(i, 0);
            }
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:removelimit(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] > 0)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        eventlimit = 10000;
        format(string256, sizeof(string256), "{FF0000}%s{80FF00} премахна лимита за влизането в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string256);
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:blueteam(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] != 1)
    {
        return SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /blueteam [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
    }

    if (inevent[targetid] == 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е от евента!");
    }

    SetPlayerColor(targetid, 0x00A2F3FF);

    //new string256[256];
    format(string256, sizeof(string256), "Ти премести %s в синия отбор.", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFFFFFF, string256);

    return 1;
}

CMD:redteam(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] != 1)
    {
        return SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /redteam [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
    }

    if (inevent[targetid] == 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е от евента!");
    }

    SetPlayerColor(targetid, 0xFF0000FF);

    //new string256[256];
    format(string256, sizeof(string256), "Ти премести %s в червения отбор.", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFFFFFF, string256);

    return 1;
}

CMD:ncolor(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] != 1)
    {
        return SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }

    new targetid, colorid;
    if (sscanf(params, "ui", targetid, colorid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /ncolor [playerid] [color id]");
        SendClientMessage(playerid, COLOR_RED, "1 - Бял 2 - Зелен 3 - Червен 4 - Оранжев");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
    }

    if (inevent[targetid] == 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е от евента!");
    }

    switch (colorid)
    {
        case 1:
        {
            SetPlayerColor(targetid, 0xFFFFFFFF); // Бял
        }
        case 2:
        {
            SetPlayerColor(targetid, 0x28BF0EFF); // Зелен
        }
        case 3:
        {
            SetPlayerColor(targetid, 0xFF0000FF); // Червен
        }
        case 4:
        {
            SetPlayerColor(targetid, 0xFF5733FF); // Оранжев
        }
        default:
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /ncolor [playerid] [color id]");
            SendClientMessage(playerid, COLOR_RED, "1 - Бял 2 - Зелен 3 - Червен 4 - Оранжев");
            return 1;
        }
    }

    //new string256[256];
    format(string256, sizeof(string256), "Ти промени цвета на %s на номер %d", GetPlayerNickname(targetid), colorid);
    SendClientMessage(playerid, 0xFFFFFFFF, string256);

    return 1;
}

CMD:eventint(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    if (startedevent == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        return 1;
    }

    new interiorid;
    if (sscanf(params, "d", interiorid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /eventint [interior id]");
        return 1;
    }

    if (interiorid < 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Interior ID-то трябва да е положително число!");
        return 1;
    }

    new message[128];
    format(message, sizeof(message), "{FF0000}%s{80FF00} сложи Interior ID на евента да е %d!", GetPlayerNickname(playerid), interiorid);
    SendClientMessageToAll(0x80FF00FF, message);

    eventinterior = interiorid;

    return 1;
}

CMD:sethpall(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    if (startedevent == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        return 1;
    }

    new health;
    if (sscanf(params, "d", health))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /sethpall [health]");
        return 1;
    }

    if (health < 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Health-а трябва да е положително число!");
        return 1;
    }

    new message[128];
    format(message, sizeof(message), "{FF0000}%s{80FF00} сложи кръвта на всички в евента да е %d!", GetPlayerNickname(playerid), health);
    SendClientMessageToAll(0x80FF00FF, message);

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && inevent[i])
        {
            SetPlayerHealth(i, float(health));
        }
    }

    return 1;
}


CMD:setskinall(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    if (startedevent == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        return 1;
    }

    new skinid;
    if (sscanf(params, "d", skinid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /setskinall [skin id]");
        return 1;
    }

    if (skinid < 0 || skinid > 311) // Valid skin IDs are 0-311 in SA-MP
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Skin ID-то трябва да е между 0 и 311!");
        return 1;
    }

    new message[128];
    format(message, sizeof(message), "{FF0000}%s{80FF00} сложи скинът на всички в евента да е ID %d!", GetPlayerNickname(playerid), skinid);
    SendClientMessageToAll(0x80FF00FF, message);

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && inevent[i])
        {
            SetPlayerSkin(i, skinid);
        }
    }

    return 1;
}



CMD:endevent1(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    if (startedevent == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        return CMD_SUCCESS;
    }

    // Show game text to all players
    new gametext[128];
    format(gametext, sizeof(gametext), "~w~EVENT ~g~WINNER:~n~~r~NO");
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            GameTextForPlayer(i, gametext, 5000, 3);
        }
    }

    // Reset event for all players
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            if (inevent[i] > 0)
            {
                if (cbchat[i] > 0)
                {
                    SendClientMessage(i, 0xFF9933FF, "CB Channel: Твоят CB Channel беше изключен!");
                    cbchat[i] = 0;
                }
            }
            PlayerInfo[i][pOrganisator] = 0;
        }
    }

    // Send winner announcement
    new announcement[128];
    format(announcement, sizeof(announcement), "EVENT {00B300}WINNER: {FF0000}NO");
    SendClientMessageToAll(0xFFFFFFFF, announcement);

    // Reset event variables
    startedevent = 0;
    eventmembers = 0;

    return CMD_SUCCESS;
}

CMD:stopevent(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] > 0)
    {
        format(string256, sizeof(string256), "Присъединяването в евента приключи");
        SendClientMessageToAll(0x5065D9FF, string256);
        format(string256, sizeof(string256), "~w~EVENT ~g~JOIN ~r~OVER");
        eventclosed = 1;
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            GameTextForPlayer(i, string256, 5000, 3);
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:endevent(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    if (startedevent == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /endevent [winner id]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (inevent[targetid] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е в евента!");
        return CMD_SUCCESS;
    }

    // Show winner game text
    new gametext[128];
    format(gametext, sizeof(gametext), "~w~EVENT ~g~WINNER:~n~~r~%s", GetPlayerNickname(targetid));
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            GameTextForPlayer(i, gametext, 5000, 3);
        }
    }

    // Reset event for all players
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && inevent[i] > 0)
        {
            if (cbchat[i] > 0)
            {
                SendClientMessage(i, 0xFF9933FF, "CB Channel: Твоят CB Channel беше изключен!");
                cbchat[i] = 0;
            }
            PlayerInfo[i][pOrganisator] = 0;
        }
    }

    // Send winner announcement
    new announcement[128];
    format(announcement, sizeof(announcement), "EVENT {00B300}WINNER: {FF0000}%s", GetPlayerNickname(targetid));
    SendClientMessageToAll(0xFFFFFFFF, announcement);

    // Reset event variables
    startedevent = 0;
    eventmembers = 0;

    return CMD_SUCCESS;
}

CMD:endevent2(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    if (startedevent == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        return CMD_SUCCESS;
    }

    new winners[256];
    if (sscanf(params, "s[256]", winners))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /endevent2 [winners]");
        return CMD_SUCCESS;
    }

    // Show winner game text
    new gametext[256];
    format(gametext, sizeof(gametext), "~w~EVENT ~g~WINNER:~n~~r~%s", winners);
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            GameTextForPlayer(i, gametext, 5000, 3);
        }
    }

    // Reset event for all players
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && inevent[i] > 0)
        {
            if (cbchat[i] > 0)
            {
                SendClientMessage(i, 0xFF9933FF, "CB Channel: Твоят CB Channel беше изключен!");
                cbchat[i] = 0;
            }
            PlayerInfo[i][pOrganisator] = 0;
        }
    }

    // Send winner announcement
    new announcement[256];
    format(announcement, sizeof(announcement), "EVENT {00B300}WINNER: {FF0000}%s", winners);
    SendClientMessageToAll(0xFFFFFFFF, announcement);

    // Reset event variables
    startedevent = 0;
    eventmembers = 0;

    return CMD_SUCCESS;
}

CMD:setweatherall(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    if (startedevent == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        return CMD_SUCCESS;
    }

    new weatherid;
    if (sscanf(params, "i", weatherid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /setweatherall [weather id]");
        return CMD_SUCCESS;
    }

    if (weatherid < 0 || weatherid > 45)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Времето трябва да бъде от 0 до 45!");
        return CMD_SUCCESS;
    }

    // Set weather for all players in event
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && inevent[i])
        {
            SetPlayerWeather(i, weatherid);
        }
    }

    // Send notification
    new announcement[128];
    format(announcement, sizeof(announcement), "{FF0000}%s{80FF00} сложи Weather ID на всички играчи в евента да е %d!", GetPlayerNickname(playerid), weatherid);
    SendClientMessageToAll(0x80FF00FF, announcement);

    return CMD_SUCCESS;
}

CMD:invisibleall(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (einvisible2 == 1)
        {
            format(string256, sizeof(string256), "{FF0000}%s{80FF00} направи виски играчи в евента видими!", GetPlayerNickname(playerid));
            SendClientMessageToAll(0x80FF00FF, string256);
            einvisible2 = 0;
            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                if (inevent[i])
                {
                    SetPlayerColor(i, 0x00FF00FF);
                }
            }
        }
        if (einvisible2 == 0)
        {
            format(string256, sizeof(string256), "{FF0000}%s{80FF00} направи виски играчи в евента невидими!", GetPlayerNickname(playerid));
            SendClientMessageToAll(0x80FF00FF, string256);
            einvisible2 = 1;
            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                if (inevent[i])
                {
                    SetPlayerColor(i, 0xFFFFFF00);
                }
            }
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:erefuel(playerid, params[])
{
    if (inevent[playerid] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в евента!");
    if (!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозно средство!");
    if (GetVehicleModel(GetPlayerVehicleID(playerid)) != 481 &&
            GetVehicleModel(GetPlayerVehicleID(playerid)) != 509 &&
            GetVehicleModel(GetPlayerVehicleID(playerid)) != 510 &&
            GetVehicleModel(GetPlayerVehicleID(playerid)) != 481)
    {
        if (vehfuel[GetPlayerVehicleID(playerid)] == 100)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Твоето превозно средство вече има 100 литра бензин!");
            return 1;
        }
        format(string256, 256, "Вие заредихте успешно {FFFF00}100{FFFFFF} литра във вашето превозно средство.");
        SendClientMessage(playerid, 0xFFFFFFFFF, string256);
        vehfuel[GetPlayerVehicleID(playerid)] = 100;
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да заредиш това превозно средство с бензин!");
    }
    return 1;
}

CMD:joinevent(playerid, params[])
{
    if (eventclosed == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Евентът е затворен!");
    if (eventmembers > eventlimit - 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Достигнат е лимитър за влизане в евента!");
    if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
    if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече си в евент!");
    if (GetPlayerVehicleID(playerid) != 0 && spawned[playerid] == 1 && eev == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си пешеходец за да влзеш в евента!");
    if (cmn1[playerid] > 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да влезеш, докато си CMN1!");
    }
    if (playerInDuel[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да влезеш, докато си в дуел!");
    }
    if (playerInDMON[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да влезеш, докато си в DMON!");
    }
    if (PlayerInfo[playerid][pADuty] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да влезеш, защото си ADMIN ON-DUTY!");
    if (PlayerInfo[playerid][pIFCDuty] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си IFC ON-DUTY!");
    if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (PlayerInfo[playerid][pOrganisator] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да влезеш, защото си организатора му!");
    inevent[playerid] = 1;
    ResetPlayerWeapons(playerid);
    SetPlayerInterior(playerid, eventinterior);
    SetPlayerColor(playerid, 0x00FF00FF);
    eventmembers += 1;
    SetPlayerArmour(playerid, 0);
    SetPlayerHealth(playerid, 100);
    SendClientMessage(playerid, 0xFF9933FF, "CB Channel: Твоят CB Channel беше прехвърлен на 1, защото влезе в евент!");
    SetPlayerPos(playerid, eventx, eventy, eventz);
    SetPlayerVirtualWorld(playerid, 1);
    cbchat[playerid] = 1;
    if (efight == 0 && eenter == 0)
    {
        SendClientMessage(playerid, COLOR_RED, "ВНИМАНИЕ: Не удряй или стреляй и не натискай F, ENTER или TAB преди админа да е позволил !");
    }
    format(string256, sizeof(string256), "%s {80FF00}се пресъедини към евента. За да се пресъединиш и ти напиши {FF0000}/joinevent .", GetPlayerNickname(playerid));
    SendClientMessageToAll(0xFF0000FF, string256);
    return 1;
}
CMD:leftevent(playerid, params[])
{
    if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
    if (inevent[playerid] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в евент!");
    SetPlayerHealth(playerid, 0);
    SendClientMessage(playerid, 0x80FF00FF, "Ти напусна евента!");
    return 1;
}

CMD:setvhpall(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] < 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    if (startedevent == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        return 1;
    }

    new health;
    if (sscanf(params, "d", health))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /setvhpall [vehicle health]");
        return 1;
    }

    if (health < 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Health-а трябва да е положително число!");
        return 1;
    }

    format(string256, sizeof(string256), "{FF0000}%s{80FF00} сложи %d Health на всички превозни средства в евента!", GetPlayerNickname(playerid), health);
    SendClientMessageToAll(0x80FF00FF, string256);

    for (new vehicleid = 0; vehicleid < MAX_VEHICLES; vehicleid++)
    {
        if (eventveh[vehicleid] == 1)
        {
            SetVehicleHealth(vehicleid, float(health));
        }
    }

    return 1;
}

CMD:settime(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    if (startedevent == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        return CMD_SUCCESS;
    }

    new targetid, hour;
    if (sscanf(params, "ui", targetid, hour))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /settime [playerid] [time]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (inevent[targetid] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е в евента!");
        return CMD_SUCCESS;
    }

    if (hour < 0 || hour > 23)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Часът трябва да бъде от 0 до 23!");
        return CMD_SUCCESS;
    }

    SetPlayerTime(targetid, hour, 0);

    //new string256[256];
    format(string256, sizeof(string256), "* %s смени твоя час на %dч. *", GetPlayerNickname(playerid), hour);
    SendClientMessage(targetid, 0xFF0000FF, string256);

    return CMD_SUCCESS;
}
CMD:setlimit(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    if (startedevent == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        return 1;
    }

    new limit;
    if (sscanf(params, "d", limit))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /setlimit [limit]");
        return 1;
    }

    if (limit < 1 || limit > 1000)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Лимитът може да бъде от 1 до 1000 човека!");
        return 1;
    }

    eventlimit = limit;

    new message[128];
    format(message, sizeof(message), "{FF0000}%s{80FF00} сложи лимита за влизането в евента да е %d!", GetPlayerNickname(playerid), limit);
    SendClientMessageToAll(0x80FF00FF, message);

    return 1;
}

CMD:givegunall(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    if (startedevent == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        return 1;
    }

    new weaponid;
    if (sscanf(params, "d", weaponid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /givegunall [weaponid]");
        SendClientMessage(playerid, 0x33AA33FF, "____________________________________________");
        SendClientMessage(playerid, 0xBFC0C2FF, "41: Spraycan 42: Fire Extinguisher 43: Camera 44: Nightvision Goggles 45: Infared Vision 46: Parachute");
        SendClientMessage(playerid, 0xBFC0C2FF, "1: Brass Knuckles 2: Golf Club 3: Nite Stick 4: Knife 5: Baseball Bat 6: Shovel 7: Pool Cue 8: Katana 9: Chainsaw");
        SendClientMessage(playerid, 0xBFC0C2FF, "10: Purple Dildo 11: Small White Vibrator 12: Large White Vibrator 13: Silver Vibrator 14: Flowers 15: Cane 16: Frag Grenade");
        SendClientMessage(playerid, 0xBFC0C2FF, "17: Tear Gas 18: Molotov Cocktail 19: Vehicle Missile 20: Hydra Flare 21: Jetpack 22: 9mm 23: Silenced 9mm 24: Desert Eagle");
        SendClientMessage(playerid, 0xBFC0C2FF, "25: Shotgun 26: Sawnoff Shotgun 27: Combat Shotgun 28: Micro SMG (Mac 10) 29: SMG (MP5) 30: AK-47 31: M4 32: Tec-9 33: Country Rifle");
        SendClientMessage(playerid, 0xBFC0C2FF, "34: Sniper Rifle 35: Rocket Launcher 36: HS Rocket Launcher 37: Flamethrower 38: Minigun 39: Satchel Charge 40: Detonator");
        SendClientMessage(playerid, 0xBFC0C2FF, "41: Spraycan 42: Fire Extinguisher 43: Camera 44: Nightvision Goggles 45: Infared Vision 46: Parachute");
        SendClientMessage(playerid, 0x33AA33FF, "____________________________________________");
        return 1;
    }

    if (weaponid < 1 || weaponid > 46)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /givegunall [weaponid]");
        SendClientMessage(playerid, 0x33AA33FF, "____________________________________________");
        SendClientMessage(playerid, 0xBFC0C2FF, "41: Spraycan 42: Fire Extinguisher 43: Camera 44: Nightvision Goggles 45: Infared Vision 46: Parachute");
        SendClientMessage(playerid, 0xBFC0C2FF, "1: Brass Knuckles 2: Golf Club 3: Nite Stick 4: Knife 5: Baseball Bat 6: Shovel 7: Pool Cue 8: Katana 9: Chainsaw");
        SendClientMessage(playerid, 0xBFC0C2FF, "10: Purple Dildo 11: Small White Vibrator 12: Large White Vibrator 13: Silver Vibrator 14: Flowers 15: Cane 16: Frag Grenade");
        SendClientMessage(playerid, 0xBFC0C2FF, "17: Tear Gas 18: Molotov Cocktail 19: Vehicle Missile 20: Hydra Flare 21: Jetpack 22: 9mm 23: Silenced 9mm 24: Desert Eagle");
        SendClientMessage(playerid, 0xBFC0C2FF, "25: Shotgun 26: Sawnoff Shotgun 27: Combat Shotgun 28: Micro SMG (Mac 10) 29: SMG (MP5) 30: AK-47 31: M4 32: Tec-9 33: Country Rifle");
        SendClientMessage(playerid, 0xBFC0C2FF, "34: Sniper Rifle 35: Rocket Launcher 36: HS Rocket Launcher 37: Flamethrower 38: Minigun 39: Satchel Charge 40: Detonator");
        SendClientMessage(playerid, 0xBFC0C2FF, "41: Spraycan 42: Fire Extinguisher 43: Camera 44: Nightvision Goggles 45: Infared Vision 46: Parachute");
        SendClientMessage(playerid, 0x33AA33FF, "____________________________________________");
        return 1;
    }

    new weaponname[32];
    GetWeaponName(weaponid, weaponname, sizeof(weaponname));

    new message[128];
    format(message, sizeof(message), "{FF0000}%s{80FF00} даде %s на всички играчи в евента!", GetPlayerNickname(playerid), weaponname);
    SendClientMessageToAll(0x80FF00FF, message);

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && inevent[i])
        {
            GivePlayerWeapon(i, weaponid, 500);
        }
    }

    return 1;
}

CMD:egiveep(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] != 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, amount;
    if (sscanf(params, "ui", targetid, amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /egiveep [playerid] [level]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (amount < 1 || amount > 10)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "EP трябва да е по-голямо от 0 и по-малко от 10!");
        return 1;
    }

    if (inevent[targetid] == 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е от евента!");

    PlayerInfo[targetid][pEP] += amount;
    GivePlayerEP(targetid, amount);
    
    new string115[115];
    format(string115, sizeof(string115), "* Ти увеличи с %d левела на %s *", amount, GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFFFFFF, string115);
    
    format(string115, sizeof(string115), "* %s ти даде %d EP *", GetPlayerNickname(playerid), amount);
    SendClientMessage(targetid, 0xFFFF00FF, string115);
    
    return 1;
}
