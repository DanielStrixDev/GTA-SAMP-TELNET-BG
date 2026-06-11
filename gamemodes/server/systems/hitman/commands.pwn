CMD:bounties(playerid, params[])
{
    new hitmans = 0;
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (hitmanprice[i] >= 1)
        {
            hitmans += 1;
        }
    }
    format(string256, 256, "Онлайн играчи със заложени цени на главите им(%d):", hitmans);
    SendClientMessage(playerid, 0x40BF00FF, string256);
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (hitmanprice[i] >= 1)
        {
            format(string256, 256, "%s (ID: %d) - Цена: %d", GetPlayerNickname(i), i, hitmanprice[i]);
            SendClientMessage(playerid, 0xA4A400FF, string256);
        }
    }
    if (hitmans == 0)
    {
        SendClientMessage(playerid, 0xE60000FF, "Няма онлайн играчи със заложени цени за главите им!");
    }
    return CMD_SUCCESS;
}

CMD:hitman(playerid, params[])
{
    new targetid, amount;
    if (sscanf(params, "ui", targetid, amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /hitman [playerid] [cash]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (targetid == playerid)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да заложиш пари за себе си!");
        return CMD_SUCCESS;
    }

    if (amount < 1000000 || amount > 100000000)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Парите трябва да са от 1 000 000 до 100 000 000!");
        return CMD_SUCCESS;
    }

    if (amount > PlayerInfo[playerid][pCash])
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш толкова пари!");
        return CMD_SUCCESS;
    }

    // Place the hit
    GivePlayerHitmanCash(playerid, targetid, amount);
    GivePlayerCash(playerid, -amount);

    // Send notifications
    //new string256[256];
    format(string256, sizeof(string256), "Hitman: %s заложи $%d за главата на %s", GetPlayerNickname(playerid), amount, GetPlayerNickname(targetid));
    SendClientMessageToAll(0xA4A400FF, string256);
    
    format(string256, sizeof(string256), "Hitman: Ти заложи $%d за главата на %s", amount, GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xA4A400FF, string256);
    
    return CMD_SUCCESS;
}
