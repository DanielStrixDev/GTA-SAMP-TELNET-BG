CMD:refillgs(playerid, params[])
{
    if (PlayerInfo[playerid][pIFC] == 0) return SendClientMessage(playerid, 0xE60000FF, "Трябва да си член на Intense Fuel Company!");
    new isWithFuelVeh = 0;
    if (GetVehicleTrailer(GetPlayerVehicleID(playerid)) == fuelremarke[0] || GetVehicleTrailer(GetPlayerVehicleID(playerid)) == fuelremarke[1] || GetVehicleTrailer(GetPlayerVehicleID(playerid)) == fuelremarke[2])
    {
        isWithFuelVeh = 1;
    }
    if (isWithFuelVeh == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозното средство за разнасяне на бензин!");
        return 1;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 1004.0327, -937.5370, 42.3281) ||
            IsPlayerInRangeOfPoint(playerid, 10, 1942.3719, -1772.8666, 13.6406) ||
            IsPlayerInRangeOfPoint(playerid, 10, -1606.7223, -2713.3562, 48.5335) ||
            IsPlayerInRangeOfPoint(playerid, 10, -2026.7813, 156.5509, 29.0391) ||
            IsPlayerInRangeOfPoint(playerid, 10, -2243.8149, -2559.8899, 31.9219) ||
            IsPlayerInRangeOfPoint(playerid, 10, -1676.2601, 413.5443, 7.1797) ||
            IsPlayerInRangeOfPoint(playerid, 10, 2201.8296, 2475.1350, 10.8203) ||
            IsPlayerInRangeOfPoint(playerid, 10, 615.3391, 1690.0454, 6.9922) ||
            IsPlayerInRangeOfPoint(playerid, 10, -1328.2731, 2677.5278, 50.0625) ||
            IsPlayerInRangeOfPoint(playerid, 10, 70.3842, 1219.0177, 18.8116) ||
            IsPlayerInRangeOfPoint(playerid, 10, 2113.3835, 919.5655, 10.8203) ||
            IsPlayerInRangeOfPoint(playerid, 10, 2641.0115, 1106.6252, 10.8203) ||
            IsPlayerInRangeOfPoint(playerid, 10, 2146.7964, 2747.8115, 10.8203) ||
            IsPlayerInRangeOfPoint(playerid, 10, 1595.7935, 2199.5996, 10.8203) ||
            IsPlayerInRangeOfPoint(playerid, 10, -1471.1836, 1863.7598, 32.6328) ||
            IsPlayerInRangeOfPoint(playerid, 10, 655.7673, -565.0798, 16.3359) ||
            IsPlayerInRangeOfPoint(playerid, 10, 1381.8230, 459.1453, 20.3452))
    {
        if (IsPlayerInRangeOfPoint(playerid, 10, 1004.0327, -937.5370, 42.3281) && fuelStationsFuel[0] == 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 1942.3719, -1772.8666, 13.6406) && fuelStationsFuel[1] == 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -1606.7223, -2713.3562, 48.5335) && fuelStationsFuel[2] == 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -2026.7813, 156.5509, 29.0391) && fuelStationsFuel[3] == 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -2243.8149, -2559.8899, 31.9219) && fuelStationsFuel[4] == 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -1676.2601, 413.5443, 7.1797) && fuelStationsFuel[5] == 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 2201.8296, 2475.1350, 10.8203) && fuelStationsFuel[6] == 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 615.3391, 1690.0454, 6.9922) && fuelStationsFuel[7] == 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -1328.2731, 2677.5278, 50.0625) && fuelStationsFuel[8] == 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 70.3842, 1219.0177, 18.8116) && fuelStationsFuel[9] == 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 2113.3835, 919.5655, 10.8203) && fuelStationsFuel[10] == 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 2641.0115, 1106.6252, 10.8203) && fuelStationsFuel[11] == 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 2146.7964, 2747.8115, 10.8203) && fuelStationsFuel[12] == 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 1595.7935, 2199.5996, 10.8203) && fuelStationsFuel[13] == 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -1471.1836, 1863.7598, 32.6328) && fuelStationsFuel[14] == 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 655.7673, -565.0798, 16.3359) && fuelStationsFuel[15] == 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 1381.8230, 459.1453, 20.3452) && fuelStationsFuel[16] == 5000) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията има достатъчно бензин.");
        new neededFuel = 5000 - fuelStationsFuel[FuelStationClose(playerid)];
        if (vehfuel2[GetVehicleTrailer(GetPlayerVehicleID(playerid))] < neededFuel)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно бензин за да заредиш бензиностанцията!");
            return 1;
        }
        new refuelstring[500];
        format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш");
        Update3DTextLabelText(fuelStationText[FuelStationClose(playerid)], 0xFFFFFFFF, refuelstring);
        vehfuel2[GetVehicleTrailer(GetPlayerVehicleID(playerid))] -= neededFuel;
        fuelStationsFuel[FuelStationClose(playerid)] = 5000;
        new profitFuel = neededFuel + 1030;
        GivePlayerCash(playerid, profitFuel);
        GivePlayerEP(playerid, 2);
        format(string256, 256, "Ти зареди бензиностанцията с %d литра и твоята печалба е {3FDE00}$%d + 2 EP", neededFuel, profitFuel);
        SendClientMessage(playerid, 0xFFFFFFFF, string256);
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Вие не сте до бензиностанция!");
    }
    return 1;
}
CMD:refillpt(playerid, params[])
{
    if (IsPlayerInRangeOfPoint(playerid, 5, 264.4341, 1454.9220, 10.5859))
    {
        new isWithFuelVeh = 0;
        if (GetVehicleTrailer(GetPlayerVehicleID(playerid)) == fuelremarke[0] || GetVehicleTrailer(GetPlayerVehicleID(playerid)) == fuelremarke[1] || GetVehicleTrailer(GetPlayerVehicleID(playerid)) == fuelremarke[2])
        {
            isWithFuelVeh = 1;
        }
        if (isWithFuelVeh == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозното средство за разнасяне на бензин!");
            return 1;
        }
        new string500[500];
        if (10000 - vehfuel2[GetVehicleTrailer(GetPlayerVehicleID(playerid))] == 1)
        {
            format(string500, 500, "{FF0000}Моля въведете с колко литра искате да заредите цистерната.\n{FFFFFF}За да заредите цистерната до горе са ти нужни {FFFF00}1 литър.", 10000 - vehfuel2[GetPlayerVehicleID(playerid)]);
            ShowPlayerDialog(playerid, 44, DIALOG_STYLE_INPUT, "{0040FF}Цистерна", string500, "Презареди", "Затвори");
        }
        if (10000 - vehfuel2[GetVehicleTrailer(GetPlayerVehicleID(playerid))] < 1)
        {
            format(string500, 500, "{FF0000}Моля въведете с колко литра искате да заредите цистерната.\n{FFFFFF}За да заредите цистерната до горе са ти нужни {FFFF00}0 литра.", 10000 - vehfuel2[GetPlayerVehicleID(playerid)]);
            ShowPlayerDialog(playerid, 44, DIALOG_STYLE_INPUT, "{0040FF}Цистерна", string500, "Презареди", "Затвори");
        }
        if (10000 - vehfuel2[GetVehicleTrailer(GetPlayerVehicleID(playerid))] > 1)
        {
            format(string500, 500, "{FF0000}Моля въведете с колко литра искате да заредите цистерната.\n{FFFFFF}За да заредите цистерната до горе са ти нужни {FFFF00}%d литра.", 10000 - vehfuel2[GetVehicleTrailer(GetPlayerVehicleID(playerid))]);
            ShowPlayerDialog(playerid, 44, DIALOG_STYLE_INPUT, "{0040FF}Цистерна", string500, "Презареди", "Затвори");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Вие не сте до мястото за зареждане!");
        return 1;
    }
    return 1;
}
CMD:refillfc(playerid, params[])
{
    if (IsPlayerInRangeOfPoint(playerid, 10, 1004.0327, -937.5370, 42.3281) ||
            IsPlayerInRangeOfPoint(playerid, 10, 1942.3719, -1772.8666, 13.6406) ||
            IsPlayerInRangeOfPoint(playerid, 10, -1606.7223, -2713.3562, 48.5335) ||
            IsPlayerInRangeOfPoint(playerid, 10, -2026.7813, 156.5509, 29.0391) ||
            IsPlayerInRangeOfPoint(playerid, 10, -2243.8149, -2559.8899, 31.9219) ||
            IsPlayerInRangeOfPoint(playerid, 10, -1676.2601, 413.5443, 7.1797) ||
            IsPlayerInRangeOfPoint(playerid, 10, 2201.8296, 2475.1350, 10.8203) ||
            IsPlayerInRangeOfPoint(playerid, 10, 615.3391, 1690.0454, 6.9922) ||
            IsPlayerInRangeOfPoint(playerid, 10, -1328.2731, 2677.5278, 50.0625) ||
            IsPlayerInRangeOfPoint(playerid, 10, 70.3842, 1219.0177, 18.8116) ||
            IsPlayerInRangeOfPoint(playerid, 10, 2113.3835, 919.5655, 10.8203) ||
            IsPlayerInRangeOfPoint(playerid, 10, 2641.0115, 1106.6252, 10.8203) ||
            IsPlayerInRangeOfPoint(playerid, 10, 2146.7964, 2747.8115, 10.8203) ||
            IsPlayerInRangeOfPoint(playerid, 10, 1595.7935, 2199.5996, 10.8203) ||
            IsPlayerInRangeOfPoint(playerid, 10, -1471.1836, 1863.7598, 32.6328) ||
            IsPlayerInRangeOfPoint(playerid, 10, 655.7673, -565.0798, 16.3359) ||
            IsPlayerInRangeOfPoint(playerid, 10, 1381.8230, 459.1453, 20.3452))
    {
        if (PlayerInfo[playerid][pFuelcase] == -1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш туба за бензин!");
        if (IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_RED, "Трябва да си пешеходец за да заредиш тубата си за бензин!");
        if (PlayerInfo[playerid][pFuelcase] > 99) return SendClientMessage(playerid, 0xB4B5B7FF, "Твоята туба за бензин е заредена до горе!");
        if (IsPlayerInRangeOfPoint(playerid, 10, 1004.0327, -937.5370, 42.3281) && fuelStationsFuel[0] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма бензин, елате по-късно.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 1942.3719, -1772.8666, 13.6406) && fuelStationsFuel[1] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма бензин, елате по-късно.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -1606.7223, -2713.3562, 48.5335) && fuelStationsFuel[2] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма бензин, елате по-късно.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -2026.7813, 156.5509, 29.0391) && fuelStationsFuel[3] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма бензин, елате по-късно.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -2243.8149, -2559.8899, 31.9219) && fuelStationsFuel[4] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма бензин, елате по-късно.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -1676.2601, 413.5443, 7.1797) && fuelStationsFuel[5] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма бензин, елате по-късно.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 2201.8296, 2475.1350, 10.8203) && fuelStationsFuel[6] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма бензин, елате по-късно.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 615.3391, 1690.0454, 6.9922) && fuelStationsFuel[7] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма бензин, елате по-късно.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -1328.2731, 2677.5278, 50.0625) && fuelStationsFuel[8] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма бензин, елате по-късно.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 70.3842, 1219.0177, 18.8116) && fuelStationsFuel[9] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма бензин, елате по-късно.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 2113.3835, 919.5655, 10.8203) && fuelStationsFuel[10] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма бензин, елате по-късно.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 2641.0115, 1106.6252, 10.8203) && fuelStationsFuel[11] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма бензин, елате по-късно.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 2146.7964, 2747.8115, 10.8203) && fuelStationsFuel[12] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма бензин, елате по-късно.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 1595.7935, 2199.5996, 10.8203) && fuelStationsFuel[13] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма бензин, елате по-късно.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -1471.1836, 1863.7598, 32.6328) && fuelStationsFuel[14] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма бензин, елате по-късно.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 655.7673, -565.0798, 16.3359) && fuelStationsFuel[15] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма бензин, елате по-късно.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 1381.8230, 459.1453, 20.3452) && fuelStationsFuel[16] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма бензин, елате по-късно.");
        new string500[500];
        if (100 - PlayerInfo[playerid][pFuelcase] == 1)
        {
            format(string500, 500, "{00FF00}Добре дошли в бензиностанцията !\n{FFFFFF}Моля въведете с колко литра искате да заредите вашата туба с бензин.\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{FFFFFF}За да заредиш до горе ти нужен {FFFF00}1 литър.");
            ShowPlayerDialog(playerid, 38, DIALOG_STYLE_INPUT, "{0040FF}Бензиностанция", string500, "Презареди", "Затвори");
        }
        if (100 - PlayerInfo[playerid][pFuelcase] < 1)
        {
            format(string500, 500, "{00FF00}Добре дошли в бензиностанцията !\n{FFFFFF}Моля въведете с колко литра искате да заредите вашата туба с бензин.\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{FFFFFF}За да заредиш до горе са ти нужни {FFFF00}0 литра.");
            ShowPlayerDialog(playerid, 38, DIALOG_STYLE_INPUT, "{0040FF}Бензиностанция", string500, "Презареди", "Затвори");
        }
        if (100 - PlayerInfo[playerid][pFuelcase] > 1)
        {
            format(string500, 500, "{00FF00}Добре дошли в бензиностанцията !\n{FFFFFF}Моля въведете с колко литра искате да заредите вашата туба с бензин.\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{FFFFFF}За да заредиш до горе са ти нужни {FFFF00}%d литра.", 100 - PlayerInfo[playerid][pFuelcase]);
            ShowPlayerDialog(playerid, 38, DIALOG_STYLE_INPUT, "{0040FF}Бензиностанция", string500, "Презареди", "Затвори");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Вие не сте до бензиностанция!");
        return 1;
    }
    return 1;
}

CMD:ifc(playerid, params[])
{
    new ifcusers;
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerInfo[i][pIFC] >= 1)
        {
            ifcusers += 1;
        }
    }
    format(string256, 256, "Онлайн членове на Intense Fuel Company(%d):", ifcusers);
    SendClientMessage(playerid, 0xFFFF00FF, string256);
    new ifctext[32];
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerInfo[i][pIFCDuty] == 1)
        {
            ifctext = "On Duty";
        }
        else if (PlayerInfo[i][pIFCDuty] == 0)
        {
            ifctext = "Off Duty";
        }
        if (PlayerInfo[i][pIFC] >= 1 && PlayerInfo[i][pAdmin] < 5)
        {
            format(string256, 256, "%s (ID: %d) %s", GetPlayerNickname(i), i, ifctext);
            SendClientMessage(playerid, COLOR_RED, string256);
        }
        if (PlayerInfo[i][pIFC] >= 1 && PlayerInfo[i][pAdmin] >= 5)
        {
            format(string256, 256, "%s(ID: %d) %s {FFFF00}[Шеф]", GetPlayerNickname(i), i, ifctext);
            SendClientMessage(playerid, COLOR_RED, string256);
        }
    }
    if (ifcusers == 0)
    {
        format(string256, 256, "Няма онлайн членове на Intense Fuel Company в момента!");
        SendClientMessage(playerid, COLOR_RED, string256);
    }
    return 1;
}

CMD:leaveifc(playerid, params[])
{
    new confirmation[16];
    if (sscanf(params, "s[16]", confirmation))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /leaveifc [confirm]");
        return 1;
    }

    if (strcmp(confirmation, "confirm", true) != 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /leaveifc [confirm]");
        return 1;
    }

    if (PlayerInfo[playerid][pIFC] != 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Intense Fuel Company!");
        return 1;
    }

    // Leave IFC
    PlayerInfo[playerid][pIFC] = 0;
    PlayerInfo[playerid][pIFCDuty] = 0;

    // Send confirmation message
    new message[128];
    format(message, sizeof(message), "* %s ти напусна Intense Fuel Company *", GetPlayerNickname(playerid));
    SendClientMessage(playerid, 0xA4FFA4FF, message);

    // Handle skin change if on duty
    if (PlayerInfo[playerid][pADuty] == 0 && PlayerInfo[playerid][pIFCDuty] == 1)
    {
        if (IsPlayerInAnyVehicle(playerid))
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "* Твоят скин не се смени, защото не си пешеходец *");
        }
        else
        {
            SetPlayerSkin(playerid, spawnselectedskin[playerid]);
        }
    }

    // Handle spawn point change if set to IFC spawn
    if (PlayerInfo[playerid][pSpawnO] == 3)
    {
        PlayerInfo[playerid][pSpawnO] = 2;
        SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Твоят spawn беше променен на Faction spawn!");
    }

    return 1;
}
CMD:getifc(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /getifc [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (PlayerInfo[targetid][pIFC] == 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е член на IFC!");

    PlayerInfo[targetid][pIFC] = 0;

    //new string256[256];
    format(string256, sizeof(string256), "* %s те махна от Intense Fuel Company *", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0xA4FFA4FF, string256);

    if (IsPlayerInAnyVehicle(targetid) == 1 && PlayerInfo[targetid][pADuty] == 0)
    {
        SendClientMessage(targetid, 0xFFFFFFFF, "* Твоят скин не се смени, защото не си пешеходец *");
    }

    if (IsPlayerInAnyVehicle(targetid) == 0 && PlayerInfo[targetid][pADuty] == 0)
    {
        SetPlayerSkin(targetid, spawnselectedskin[targetid]);
    }

    if (PlayerInfo[targetid][pSpawnO] == 3)
    {
        PlayerInfo[targetid][pSpawnO] = 2;
        PlayerInfo[targetid][pIFCDuty] = 0;
        SendClientMessage(targetid, 0xFFFFFFFF, "SERVER: Твоят spawn беше променен на Faction spawn!");
    }

    format(string256, sizeof(string256), "* Ти махна %s от Intense Fuel Company *", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xA4FFA4FF, string256);

    return 1;
}

CMD:makeifc(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /makeifc [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (PlayerInfo[targetid][pIFC] == 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч е член на IFC!");

    PlayerInfo[targetid][pIFC] = 1;

    //new string256[256];
    format(string256, sizeof(string256), "* %s те направи член на Intense Fuel Company, поздравления *", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0xA4FFA4FF, string256);

    format(string256, sizeof(string256), "* Ти направи %s член на Intense Fuel Company *", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xA4FFA4FF, string256);

    return 1;
}

