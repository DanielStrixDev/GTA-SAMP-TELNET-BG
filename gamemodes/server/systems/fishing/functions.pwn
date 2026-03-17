
stock IsNearFishBoat(playerid)
{

    for (new i; i < 6; i++)
    {
        if (GetPlayerVirtualWorld(playerid) == 0)
        {
            if (IsPlayerInRangeOfVehicle(playerid, fishBoat1[i], 10)) return 1;
        }
        if (GetPlayerVirtualWorld(playerid) == 1)
        {
            if (IsPlayerInRangeOfVehicle(playerid, fishBoat2[i], 10)) return 1;
        }
    }

    return -1;
}

stock GetFishPrice(fishID, weightKG)
{
    new priceKG;
    switch (fishID)
    {
        case 1 : priceKG = 230;
        case 2 : priceKG = 530;
        case 3 : priceKG = 630;
        case 4 : priceKG = 810;
        case 5 : priceKG = 840;
    }
    new priceTotal = priceKG * weightKG;
    return priceTotal;
}

stock GetPlayerFishCount(playerid)
{
    new fishCount;
    for (new i; i < MAX_CAUGHTFISHES; i++)
    {
        if (PlayerInfo[playerid][pFishslot][i] != 0) fishCount++;
    }
    return fishCount;
}

stock GetPlayerFreeFishSlot(playerid)
{
    for (new fishSlotID; fishSlotID < MAX_CAUGHTFISHES; fishSlotID++)
    {
        if (PlayerInfo[playerid][pFishslot][fishSlotID] == 0) return fishSlotID;
    }
    return -1;
}

stock GetFishName(fishID)
{
    new fishName[50];
    switch (fishID)
    {
        case 1 : format(fishName, 50, "Пъстърва");
        case 2 : format(fishName, 50, "Скумрия");
        case 3 : format(fishName, 50, "Цаца");
        case 4 : format(fishName, 50, "Скат");
        case 5 : format(fishName, 50, "Омар");
    }
    return fishName;
}

stock CaughtFish(playerid)
{
    TogglePlayerControllable(playerid, 1);
    new caughtFish = random(12);
    new fishWeight = randomex(2, 20);
    new fishSlotFree = GetPlayerFreeFishSlot(playerid);
    if (caughtFish == 0)
    {
        format(string256, 256, "На въдицата ти се закачиха боклуци и не хвана нищо!");
    }
    if (caughtFish >= 1 && caughtFish <= 8)
    {
        PlayerInfo[playerid][pFishslot][fishSlotFree] = 1;
    }
    PlayerInfo[playerid][pFishSlotWeight][fishSlotFree] = fishWeight;
    format(string256, 256, "Ти хвана %s с тегло %d кг. и тя се запази в твоя Fish Slot %d!", GetFishName(caughtFish), fishWeight);
    SendClientMessage(playerid, 0xC600C6FF, string256);

}