CMD:cbp(playerid, params[])
{
    if (cbchat[playerid] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти в момента не си превключил на нито един CB Chanel!");
    format(string256, 256, "Онлайн играчи в CB Chanel %d:", cbchat[playerid]);
    SendClientMessage(playerid, 0x40BF00FF, string256);
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (cbchat[playerid] == cbchat[i])
        {
            format(string256, 256, "%s (ID: %d)", GetPlayerNickname(i), i);
            SendClientMessage(playerid, 0xFFFFFFFF, string256);
        }
    }
    return 1;
}

CMD:cboff(playerid, params[])
{
    if (cbchat[playerid] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти в момента не си превключил на нито един CB Chanel!");
    SendClientMessage(playerid, 0xFF9933FF, "CB Chanel: Ти изключи твоя CB Chanel!");
    cbchat[playerid] = 0;
    return 1;
}

CMD:cb(playerid, params[])
{
    new channel;
    if (sscanf(params, "i", channel))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /cb [1-999]");
        return 1;
    }

    if (channel < 2 || channel > 999)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Числото трябва да е от 2 до 999!");

    cbchat[playerid] = channel;

    new string256[256];
    format(string256, sizeof(string256), "CB Channel: Ти си смени твоя CB Channel на %d.", channel);
    SendClientMessage(playerid, 0xFF9933FF, string256);

    return 1;
}
