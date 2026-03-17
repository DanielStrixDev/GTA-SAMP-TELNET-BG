CMD:sellfish(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 4, -1353.9404, 2057.6685, 53.1172))
    {
        return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си до магазина за продаване на риба!");
    }
    if (BizInfo[0][bOwner] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Бизнесът няма притежател и не можеш да продаваш тук!");
        return 1;
    }
    if (GetPlayerFishCount(playerid) == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Нямаш нито една риба, която да продадеш!");
    new string512[512];
    new string22302result[2230];
    new stringFishName[50];
    new stringWeightPrice[150];
    for (new i = 0; i < MAX_CAUGHTFISHES; i++)
    {
        if (PlayerInfo[playerid][pFishslot][i] > 0)
        {
            new fish = PlayerInfo[playerid][pFishslot][i];
            format(stringFishName, 50, "%s", GetFishName(fish));
            new weight = PlayerInfo[playerid][pFishSlotWeight][i];
            new price = GetFishPrice(fish, weight);
            format(stringWeightPrice, 150, "%d кг. Стойност $%d", weight, price);

            format(string512, 512, "{FFFFFF}%s - %s\n", stringFishName, stringWeightPrice);
            strcat(string22302result, string512);
        }
        if (PlayerInfo[playerid][pFishslot][i] == 0)
        {
            format(string512, 512, "{FF0000}Празен слот\n");
            strcat(string22302result, string512);
        }
    }
    //goto fish
    ShowPlayerDialog(playerid, 51, DIALOG_STYLE_LIST, "Sell Fish", string22302result, "Продай", "Излез");
    return 1;
}

CMD:fish(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 20, -1378.5165, 2111.5034, 42.2000) && IsNearFishBoat(playerid) == -1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не си на място за ловуване на риба!");
        return 1;
    }
    if (GetPlayerFreeFishSlot(playerid) == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш свободно място за риба!");
    if (PlayerInfo[playerid][pHookT] > 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече ловиш риба!");
    TogglePlayerControllable(playerid, 0);
    ApplyAnimation(playerid, "SAMP", "FishingIdle", 3.0, 1, 1, 0, 0, 0);
    ApplyAnimation(playerid, "SAMP", "FishingIdle", 3.0, 1, 1, 0, 0, 0);
    PlayerInfo[playerid][pStruv] -= 1;
    SendClientMessage(playerid, 0xC600C6FF, "Fishing: Ти метна въдицата, нека видим дали ще хванеш нещо!");
    PlayerInfo[playerid][pHookT] = 10;
    return 1;
}