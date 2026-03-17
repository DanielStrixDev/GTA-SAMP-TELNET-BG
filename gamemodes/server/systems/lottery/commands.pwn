
CMD:checklotto(playerid, params[])
{
    format(string256, 256, "Стойноста на джакпота е $%d!", lottowin);
    SendClientMessage(playerid, 0xFF00FFFF, string256);
    return 1;
}

CMD:lotto(playerid, params[])
{
    new number;
    if (sscanf(params, "d", number))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /lotto [1-100]");
        return 1;
    }
    
    if (number < 1 || number > 100)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Числата в лотарията трябва да са от 1 до 100!");
        return 1;
    }
    
    if (lottonumber[playerid] != 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да заложиш повече от веднъж на лотарията!");
        return 1;
    }
    
    if (PlayerInfo[playerid][pCash] < 200)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябват ти поне $200 за да заложиш на тото!");
        return 1;
    }
    
    new message[256];
    format(message, sizeof(message), "Ти закупи фиш и числото на което заложи е %d.", number);
    SendClientMessage(playerid, 0xFF00FFFF, message);
    
    format(message, sizeof(message), "Тегленето на лотарията ще бъде в %d:59 часа. Джакпотът е $%d!", hours, lottowin);
    SendClientMessage(playerid, 0xFF00FFFF, message);
    
    GivePlayerCash(playerid, -200);
    lottonumber[playerid] = number;
    
    return 1;
}

