CMD:sellhouse(playerid, params[])
{
    //if(isinhousepickup[playerid]==1)
    //{
    new housenoerror = 0;
    if (PlayerInfo[playerid][pHouseO] == -1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш къща!");
        return 1;
    }
    new house = PlayerInfo[playerid][pHouseO];

    if (IsPlayerInRangeOfPoint(playerid, 3, HouseInfo[house][hX], HouseInfo[house][hY], HouseInfo[house][hZ]))
    {
        if (!IsValidHouse(house))
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Твоята къща е изтрита, свържи се с администратор!");
            return 1;
        }

        housenoerror = 1;
        format(HouseInfo[house][hOwnerName], 256, "None");
        HouseInfo[house][hOwner] = 0;
        SaveHouse(house);

        GivePlayerCash(playerid, HouseInfo[house][hPrice] / 2);
        format(string256[playerid], 256, "Ти продаде къщата си за $%d!", HouseInfo[house][hPrice] / 2);
        SendClientMessage(playerid, 0x00FF40FF, string256[playerid]);
        PlayerInfo[playerid][pHouseO] = -1;
        PlayerInfo[playerid][pArmour2] = 0;

    }
    if (housenoerror == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не се намираш близо до къщата си!");
    }
    return 1;
}

CMD:houseview(playerid, params[])
{
    if (PlayerInfo[playerid][pHouseO] == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш къща!");
    new house = PlayerInfo[playerid][pHouseO];
    format(string256, 256, "Health пакети: {FBB917}%d", PlayerInfo[playerid][pHealth2]);
    SendClientMessage(playerid, 0xFFFFFFFF, string256);
    format(string256, 256, "Armour пакети: {FBB917}%d", PlayerInfo[playerid][pArmour2]);
    SendClientMessage(playerid, 0xFFFFFFFF, string256);
    return 1;
}
CMD:househelp(playerid, params[])
{
    if (PlayerInfo[playerid][pHouseO] == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш къща!");
    SendClientMessage(playerid, 0x00FF40FF, "Команди: /sellhouse /enter /exit /home /lockhouse /unlockhouse /health /armour");
    SendClientMessage(playerid, 0x00FF40FF, "Команди: /psellhouse /housevsave /houseview /respawnveh /housev /housevcolor /houseaccept(/ha)");
    SendClientMessage(playerid, 0x00FF40FF, "Команди: /housecancel(/hc) /myveh /houseswitch /houseswitchaccept(/hsa) /houseswitchcancel(/hsc)");
    return 1;
}

CMD:home(playerid, params[])
{
    if (PlayerInfo[playerid][pHouseO] == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш къща!");
    SendClientMessage(playerid, 0x00FF40FF, "Следвай червения маркер, той ще те отведе до твоята къща!");
    new playersHouse = PlayerInfo[playerid][pHouseO];
new Float:
    playerHouseX = HouseInfo[playersHouse][hX];
new Float:
    playerHouseY = HouseInfo[playersHouse][hY];
new Float:
    playerHouseZ = HouseInfo[playersHouse][hZ];
    SetPlayerCheckpoint(playerid, playerHouseX, playerHouseY, playerHouseZ, 4.0);
    gpsOn[playerid] = true;
    return 1;
}

CMD:housevcolor(playerid, params[])
{
    if (PlayerInfo[playerid][pHouseO] == -1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш къща!");

    if (HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] == 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш лично превозно средство!");

    new color1, color2;
    if (sscanf(params, "ii", color1, color2))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /housevcolor [color1] [color2]");
        return 1;
    }

    // Validate color range (0-255 for vehicle colors)
    if (color1 < 0 || color1 > 255 || color2 < 0 || color2 > 255)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Цветовете трябва да са между 0 и 255!");
        return 1;
    }

    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = color1;
    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = color2;
    SaveHouse(PlayerInfo[playerid][pHouseO]);

    SendClientMessage(playerid, 0x00FF40FF, "Ти смени цветовете на твоето превозно средство, те ще бъдат валидни след рестарт на сървъра!");

    return 1;
}
CMD:housevsave(playerid, params[])
{
    if (PlayerInfo[playerid][pHouseO] == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш къща!");
    if (HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш лично превозно средство!");
    if (PlayerInfo[playerid][pBizO] > -1)
    {
        if (!IsPlayerInRangeOfPoint(playerid, 35, HouseInfo[PlayerInfo[playerid][pHouseO]][hX], HouseInfo[PlayerInfo[playerid][pHouseO]][hY], HouseInfo[PlayerInfo[playerid][pHouseO]][hZ]) &&
                !IsPlayerInRangeOfPoint(playerid, 35, BizInfo[PlayerInfo[playerid][pBizO]][bX], BizInfo[PlayerInfo[playerid][pBizO]][bY], BizInfo[PlayerInfo[playerid][pBizO]][bZ]))
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Ти не се намираш близо до къщата или бизнеса си!");
            return 1;
        }
    }
    else
    {
        if (!IsPlayerInRangeOfPoint(playerid, 35, HouseInfo[PlayerInfo[playerid][pHouseO]][hX], HouseInfo[PlayerInfo[playerid][pHouseO]][hY], HouseInfo[PlayerInfo[playerid][pHouseO]][hZ]))
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Ти не се намираш близо до къщата си!");
            return 1;
        }
    }
    if (GetPlayerVehicleID(playerid) != HouseInfo[PlayerInfo[playerid][pHouseO]][hcVeh]) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си в твоето превозно средство!");
    if (cmn1[playerid] > 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш командата, докато си CMN1!");
    }
    if (playerInDuel[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш командата, докато си в дуел!");
    }
    if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш командата, докато си в евент!");
    if (playerInDMON[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш командата, докато си в DMON!");
    }
    if (GetPlayerInterior(playerid) != 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да RESPAWN-неш твоето превозно средство в Interior!");
    if (GetPlayerVirtualWorld(playerid) != 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да RESPAWN-неш твоето превозно средство в Virtual World!");
    if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    SendClientMessage(playerid, 0x00FF40FF, "Ти запамети позицията на твоето превозно средство, то ще бъде там след рестарт на сървъра!");
    new Float:x2, Float:y2, Float:z2, Float:angle;

    GetVehiclePos(GetPlayerVehicleID(playerid), x2, y2, z2);
    GetVehicleZAngle(GetPlayerVehicleID(playerid), angle);

    HouseInfo[PlayerInfo[playerid][pHouseO]][hcA] = angle;
    HouseInfo[PlayerInfo[playerid][pHouseO]][hcX] = x2;
    HouseInfo[PlayerInfo[playerid][pHouseO]][hcY] = y2;
    HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ] = z2;
    SaveHouse(PlayerInfo[playerid][pHouseO]);
    return 1;
}
CMD:respawnveh(playerid, params[])
{
    if (PlayerInfo[playerid][pHouseO] == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш къща!");
    if (HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш лично превозно средство!");
    if (!IsPlayerInRangeOfPoint(playerid, 35, HouseInfo[PlayerInfo[playerid][pHouseO]][hX], HouseInfo[PlayerInfo[playerid][pHouseO]][hY], HouseInfo[PlayerInfo[playerid][pHouseO]][hZ]))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не се намираш близо до къщата си!");
        return 1;
    }
    if (GetPlayerVehicleID(playerid) != 0 && spawned[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си пешеходец за да използваш тази команда!");
    if (cmn1[playerid] > 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш командата, докато си CMN1!");
    }
    if (playerInDuel[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш командата, докато си в дуел!");
    }
    if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш командата, докато си в евент!");
    if (playerInDMON[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш командата, докато си в DMON!");
    }
    if (GetPlayerInterior(playerid) != 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да RESPAWN-неш твоето превозно средство в Interior!");
    if (GetPlayerVirtualWorld(playerid) != 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да RESPAWN-неш твоето превозно средство в Virtual World!");
    if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    SendClientMessage(playerid, 0x00FF40FF, "Ти RESPAWN-на твоето превозно средство!");
    if (HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] > 0)
    {
        DestroyVehicle(HouseInfo[PlayerInfo[playerid][pHouseO]][hcVeh]);
    }
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    HouseInfo[PlayerInfo[playerid][pHouseO]][hcVeh] = CreateVehicle(HouseInfo[PlayerInfo[playerid][pHouseO]][hcV], x, y, z, HouseInfo[PlayerInfo[playerid][pHouseO]][hcA], HouseInfo[PlayerInfo[playerid][pHouseO]][hcC], HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2], 1800000);
    PutPlayerInVehicle(playerid, HouseInfo[PlayerInfo[playerid][pHouseO]][hcVeh], 0);
    return 1;
}

CMD:housev(playerid, params[])
{
    if (PlayerInfo[playerid][pHouseO] == -1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не притежаваш къща!");
        return 1;
    }
    ShowPlayerDialog(playerid, 41, DIALOG_STYLE_LIST, "House Vehicles:", "От Level 5 нагоре - {00BF00}$30,000\nОт Level 7 нагоре - {00BF00}$60,000\nОт Level 10 нагоре - {00BF00}$100,000\nОт Level 15 нагоре - {00BF00}$160, 000\nОт Level 17 нагоре - {00BF00}$200,000\nОт Level 20 нагоре - {00BF00}$250,000", "Избери", "Излез");
    return 1;
}

CMD:houseid(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
        return 1;
    }
    for (new alh = 0; alh < maxhouses; alh++) // Dynamic Houses
    {
        if (IsPlayerInRangeOfPoint(playerid, 3, HouseInfo[alh][hX], HouseInfo[alh][hY], HouseInfo[alh][hZ]))
        {
            new stringhouse[256];
            format(stringhouse, 256, "HOUSE - {FF0000}%d", alh);
            SendClientMessage(playerid, 0xFFFFFFFF, stringhouse);
        }
        else return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си близо до къща!");
    }
    return 1;
}

CMD:houseswitchaccept(playerid, params[])
{
    if (houseSwitchReceiver[playerid] == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не ти е предлагана къща за размяна!");
    new stringReceiver[256];
    format(stringReceiver, 256, "Ти прие поканата за размяна на къщи на %s", GetPlayerNickname(houseSwitchReceiver[playerid]));
    SendClientMessage(playerid, 0x00FF40FF, stringReceiver);
    new currentReceiverHouse = PlayerInfo[houseSwitchReceiver[playerid]][pHouseO];
    //-------------------------------------------------------------------------//
    new stringSender[256];
    format(stringSender, 256, "%s прие твоята покана за размяна на къщи", GetPlayerNickname(playerid));
    SendClientMessage(houseSwitchReceiver[playerid], 0x00FF40FF, stringSender);
    new currentSenderHouse = PlayerInfo[playerid][pHouseO];
    //-----------------------------------------------------------------------//
    PlayerInfo[playerid][pHouseO] = currentReceiverHouse;
    PlayerInfo[houseSwitchReceiver[playerid]][pHouseO] = currentSenderHouse;
    BoughtHouse(playerid, currentReceiverHouse); // gets information for PLAYERID
    BoughtHouse(houseSwitchReceiver[playerid], currentSenderHouse); //gets information for SENDERID
    //-----------------------------------------------------------------------//
    new SenderID = houseSwitchReceiver[playerid];
    houseSwitchReceiver[playerid] = -1; //sender ID GET
    houseSwitchSender[SenderID] = -1; //receiver ID GET
    houseSwitching[playerid] = false;
    houseSwitching[SenderID] = false;
    return 1;
}
CMD:hsa(playerid, params[]) return cmd_houseswitchaccept(playerid, params);

CMD:houseswitchcancel(playerid, params)
{
    if (houseSwitchReceiver[playerid] == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не ти е предлагана къща за размяна!");
    new stringReceiver[256];
    format(stringReceiver, 256, "Ти отказа поканата за размяна на къщи на %s", GetPlayerNickname(houseSwitchReceiver[playerid]));
    SendClientMessage(playerid, 0x00FF40FF, stringReceiver);
    //-------------------------------------------------------------------------//
    new stringSender[256];
    format(stringSender, 256, "%s отказа твоята покана за размяна на къщи", GetPlayerNickname(playerid));
    SendClientMessage(houseSwitchReceiver[playerid], 0x00FF40FF, stringSender);
    //-----------------------------------------------------------------------//
    new SenderID = houseSwitchReceiver[playerid];
    houseSwitchReceiver[playerid] = -1; //sender ID GET
    houseSwitchSender[SenderID] = -1; //receiver ID GET
    houseSwitching[playerid] = false;
    houseSwitching[SenderID] = false;
    return 1;
}
CMD:hsc(playerid, params[]) return cmd_houseswitchaccept(playerid, params);

CMD:houseswitch(playerid, params[])
{
    if (PlayerInfo[playerid][pHouseO] == -1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш къща!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /houseswitch [playerid]");
        return 1;
    }

    if (targetid == playerid)
        return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да размениш къщата си със себе си!");

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, COLOR_GRAD1, "Посоченото ID не е в сървъра!");

    if (PlayerInfo[targetid][pHouseO] == -1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч няма къща!");

    if (houseSwitchSender[playerid] != -1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече си изпратил покана за размяна на къщи!");

    if (houseSwitchReceiver[playerid] != -1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече имаш покана за размяна на къщи!");

    if (houseSwitchSender[targetid] != -1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч вече има покана за размяна на къщи!");

    if (houseSwitchReceiver[targetid] != -1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч вече има покана за размяна на къщи!");

    houseSwitchSender[playerid] = targetid;
    houseSwitchReceiver[targetid] = playerid;
    houseSwitching[playerid] = true;
    houseSwitching[targetid] = true;

    new stringSender[256];
    format(stringSender, sizeof(stringSender), "Ти изпрати покана за размяна на къщи до %s", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0x00FF40FF, stringSender);

    new stringReceiver[256];
    format(stringReceiver, sizeof(stringReceiver), "%s ти изпрати покана за размяна на къщи.", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0x00FF40FF, stringReceiver);
    SendClientMessage(targetid, 0x00FF40FF, "Използвай /hsa за да приемеш или /hsc за да откажеш");

    return 1;
}

CMD:health(playerid, params[])
{
    if (PlayerInfo[playerid][pHouseO] == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш къща!");
    if (enteredhouse[playerid] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в къщата си!");
    if (PlayerInfo[playerid][pHealth2] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш пакети!");
        return 1;
    }
    SetPlayerHealth(playerid, 100);
    PlayerInfo[playerid][pHealth2] -= 1;
    return 1;
}
CMD:armour(playerid, params[])
{
    if (PlayerInfo[playerid][pHouseO] == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш къща!");
    if (enteredhouse[playerid] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в къщата си!");
    if (PlayerInfo[playerid][pArmour2] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш пакети!");
        return 1;
    }
    SetPlayerArmour(playerid, 100);
    PlayerInfo[playerid][pArmour2] -= 1;
    return 1;
}
CMD:buyarmour(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 4, 2568.4888, -1296.4260, 1037.7734))
    {
        return 1;
    }
    if (PlayerInfo[playerid][pHouseO] == -1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш къща!");
        return 1;
    }
    if (PlayerInfo[playerid][pCash] < 20000)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш $20000 за да си купиш пакети!");
        return 1;
    }
    SendClientMessage(playerid, 0x00FF00FF, "Ти си купи 10 пакета жилетки за $20000!");
    PlayerInfo[playerid][pCash] -= 20000;
    PlayerInfo[playerid][pArmour2] += 10;
    return 1;
}

CMD:lockhouse(playerid, params[])
{
    if (PlayerInfo[playerid][pHouseO] > -1)
    {
        HouseInfo[PlayerInfo[playerid][pHouseO]][hLocked] = 1;
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш къща!");
    }
    return 1;
}
CMD:unlockhouse(playerid, params[])
{
    if (PlayerInfo[playerid][pHouseO] > -1)
    {
        HouseInfo[PlayerInfo[playerid][pHouseO]][hLocked] = 0;
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш къща!");
    }
    return 1;
}

CMD:buyhouse(playerid, params[])
{
    //if(isinhousepickup[playerid]==1)
    //{
    new housenoerror = 0;
    new houseBoughtID;
    for (new alh = 0; alh < maxhouses; alh++) // Dynamic Houses
    {
        if (IsPlayerInRangeOfPoint(playerid, 3, HouseInfo[alh][hX], HouseInfo[alh][hY], HouseInfo[alh][hZ]))
        {
            if (PlayerInfo[playerid][pHouseO] > -1)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече притежаваш къща!");
                return 1;
            }
            if (HouseInfo[alh][hOwner] == 1)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Тази къща вече има притежател!");
                return 1;
            }
            if (HouseInfo[alh][hLevel] > PlayerInfo[playerid][pLevel])
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно голямо ниво за тази къща!");
                return 1;
            }
            if (HouseInfo[alh][hPrice] > PlayerInfo[playerid][pCash])
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно пари за тази къща!");
                return 1;
            }
            housenoerror = 1;
            PlayerInfo[playerid][pHouseO] = alh;
            houseBoughtID = alh;
            BoughtHouse(playerid, alh);
            GivePlayerCash(playerid, HouseInfo[alh][hPrice]);
        }
    }
    if (housenoerror == 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не се намираш близо до къща!");
    }
    new stringBoughtHouse[256];
    format(stringBoughtHouse, 256, "Честито, ти си купи къща на стойност $%d!", HouseInfo[houseBoughtID][hPrice]);
    SendClientMessage(playerid, 0x00FF40FF, stringBoughtHouse);
    return 1;
}
