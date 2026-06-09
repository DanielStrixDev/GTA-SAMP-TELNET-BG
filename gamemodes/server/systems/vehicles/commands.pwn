CMD:refuel(playerid, params[])
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
        if (!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозно средство!");
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) != 481 &&
                GetVehicleModel(GetPlayerVehicleID(playerid)) != 509 &&
                GetVehicleModel(GetPlayerVehicleID(playerid)) != 510 &&
                GetVehicleModel(GetPlayerVehicleID(playerid)) != 481)
        {
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
            if (100 - vehfuel[GetPlayerVehicleID(playerid)] == 1)
            {
                format(string500, 500, "{00FF00}Добре дошли в бензиностанцията !\n{FFFFFF}Моля въведете с колко литра искате да заредите вашето превозно средство.\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{FFFFFF}За да заредиш до горе ти нужен {FFFF00}1 литър.");
                ShowPlayerDialog(playerid, 18, DIALOG_STYLE_INPUT, "{0040FF}Бензиностанция", string500, "Презареди", "Затвори");
            }
            if (100 - vehfuel[GetPlayerVehicleID(playerid)] < 1)
            {
                format(string500, 500, "{00FF00}Добре дошли в бензиностанцията !\n{FFFFFF}Моля въведете с колко литра искате да заредите вашето превозно средство.\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{FFFFFF}За да заредиш до горе са ти нужни {FFFF00}0 литра.");
                ShowPlayerDialog(playerid, 18, DIALOG_STYLE_INPUT, "{0040FF}Бензиностанция", string500, "Презареди", "Затвори");
            }
            if (100 - vehfuel[GetPlayerVehicleID(playerid)] > 1)
            {
                format(string500, 500, "{00FF00}Добре дошли в бензиностанцията !\n{FFFFFF}Моля въведете с колко литра искате да заредите вашето превозно средство.\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{FFFFFF}За да заредиш до горе са ти нужни {FFFF00}%d литра.", 100 - vehfuel[GetPlayerVehicleID(playerid)]);
                ShowPlayerDialog(playerid, 18, DIALOG_STYLE_INPUT, "{0040FF}Бензиностанция", string500, "Презареди", "Затвори");
            }
        }
        else
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Не можете да заредите бензин в това превозно средство!");
            return 1;
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Вие не сте до бензиностанция!");
        return 1;
    }
    return 1;
}

CMD:tunehelp(playerid, params[])
{
    SendClientMessage(playerid, 0xFFFFFFFF, "Сървърът разполага с два безплатни тунинг гаража.");
    SendClientMessage(playerid, 0x008000FF, "Единият се намира в Las Venturas, а другия в Los Santos.");
    SendClientMessage(playerid, 0xFF0000FF, "От /tune се отваря менюто за тунинг!");
    return 1;
}
CMD:mph(playerid, params[])
{
    format(string, 256, "* Скороста вече ще я показва в m/s *");
    SendClientMessage(playerid, COLOR_YELLOW, string);
    kmh[playerid] = 1;
    return 1;
}
CMD:kph(playerid, params[])
{
    format(string, 256, "* Скороста вече ще я показва в km/h *");
    SendClientMessage(playerid, COLOR_YELLOW, string);
    kmh[playerid] = 0;
    return 1;
}
CMD:speedo(playerid, params[])
{
    if (speedo[playerid] == 0)
    {
        format(string, 256, "* Вие премахнахте вашия Speedo от екрана *");
        SendClientMessage(playerid, COLOR_YELLOW, string);
        speedo[playerid] = 1;
        if (GetPlayerVehicleID(playerid) > -1)
        {
            TextDrawHideForPlayer(playerid, vehstatus[playerid]);
            if (GetVehicleTrailer(GetPlayerVehicleID(playerid)) == fuelremarke[0] || GetVehicleTrailer(GetPlayerVehicleID(playerid)) == fuelremarke[1] || GetVehicleTrailer(GetPlayerVehicleID(playerid)) == fuelremarke[2])
            {
                TextDrawHideForPlayer(playerid, vehstatus2[playerid]);
            }
        }
        return 1;
    }
    if (speedo[playerid] == 1)
    {
        format(string, 256, "* Вие сложихте вашия Speedo на екрана *");
        SendClientMessage(playerid, COLOR_YELLOW, string);
        speedo[playerid] = 0;
        if (GetPlayerVehicleID(playerid) > -1)
        {
            TextDrawShowForPlayer(playerid, vehstatus[playerid]);
            if (GetVehicleTrailer(GetPlayerVehicleID(playerid)) == fuelremarke[0] || GetVehicleTrailer(GetPlayerVehicleID(playerid)) == fuelremarke[1] || GetVehicleTrailer(GetPlayerVehicleID(playerid)) == fuelremarke[2])
            {
                TextDrawShowForPlayer(playerid, vehstatus2[playerid]);
            }
        }
        return 1;
    }
    return 1;
}

CMD:tow(playerid, params[])
{
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_RED, "Трябва да си в Tow Truck!");
    new vehicleid = GetPlayerVehicleID(playerid);
    new Float:dist, Float:closedist = 8, closeveh;
    new Float:x, Float:y, Float:z;
    {
        if (IsTrailerAttachedToVehicle(vehicleid))
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Ти вече си закачил превозно средство!");
            return 1;
        }
    }
    for (new i = 0; i < MAX_VEHICLES; i++)
    {
        if (i != vehicleid && GetVehiclePos(i, x, y, z))
        {
            dist = GetPlayerDistanceFromPoint(playerid, x, y, z);
            if (dist < closedist)
            {
                closedist = dist;
                closeveh = i;
            }
        }
    }
    if (!closeveh) return SendClientMessage(playerid, COLOR_GRAD1, "Ти не си до превозно средство!");
    AttachTrailerToVehicle(closeveh, vehicleid);
    SendClientMessage(playerid, 0xFFFFFFFF, "Успешно закачи превозното средство.");
    return 1;
}
CMD:detach(playerid, params[])
{
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да се качиш в Tow Truck!");
    new vehicleid = GetPlayerVehicleID(playerid);
    new Float:dist, Float:closedist = 8;
    new Float:x, Float:y, Float:z;
    {
        if (IsTrailerAttachedToVehicle(vehicleid))
        {
            DetachTrailerFromVehicle(vehicleid);
            SendClientMessage(playerid, 0xFFFFFFFF, "Ти откачи превозното средство!");
        }
    }
    for (new i = 1; i < MAX_VEHICLES; i++)
    {
        if (i != vehicleid && GetVehiclePos(i, x, y, z))
        {
            dist = GetPlayerDistanceFromPoint(playerid, x, y, z);
            if (dist < closedist)
            {
                closedist = dist;
            }
        }
    }
    SendClientMessage(playerid, COLOR_GRAD1, "Ти не си закачил превозно средство!");
    return 1;
}

CMD:plate(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 10, 1838.5139, -1856.2627, 13.3828) &&
            !IsPlayerInRangeOfPoint(playerid, 10, -1786.8502, 1205.3788, 25.1250) &&
            !IsPlayerInRangeOfPoint(playerid, 10, 2005.9323, 2298.5537, 10.8203))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си до бизнес за сменяне на номерата на колата!");
        return 1;
    }

    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Ти не си шофьр!");
        return 1;
    }

    new plateText[9];
    if (sscanf(params, "s[9]", plateText))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /plate [text]");
        return 1;
    }

    if (strlen(plateText) < 1 || strlen(plateText) > 8)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Символите трябва да са от 1 до 8!");
        return 1;
    }

    if (PlayerInfo[playerid][pCash] < 500)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Трябва да имаш $500 за да смениш символите на превозното си средство!");
        return 1;
    }

    // Business 1 - LV Transfender
    if (IsPlayerInRangeOfPoint(playerid, 10, 2005.9323, 2298.5537, 10.8203))
    {
        if (BizInfo[1][bOwner] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Бизнесът няма притежател и не можеш да смениш текста на превозното си средство!");
            return 1;
        }

        ProcessPlateChange(playerid, plateText, 2);
        BizInfo[2][bEarnings] += 350;
    }
    // Business 2 - SF Transfender
    else if (IsPlayerInRangeOfPoint(playerid, 10, -1786.8502, 1205.3788, 25.1250))
    {
        if (BizInfo[2][bOwner] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Бизнесът няма притежател и не можеш да смениш текста на превозното си средство!");
            return 1;
        }

        ProcessPlateChange(playerid, plateText, 2);
        BizInfo[2][bEarnings] += 350;
    }
    // Business 3 - LS Transfender
    else if (IsPlayerInRangeOfPoint(playerid, 10, 1838.5139, -1856.2627, 13.3828))
    {
        if (BizInfo[3][bOwner] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Бизнесът няма притежател и не можеш да смениш текста на превозното си средство!");
            return 1;
        }

        ProcessPlateChange(playerid, plateText, 1);
        BizInfo[1][bEarnings] += 350;
    }

    return 1;
}

CMD:idveh(playerid, params[])
{
    if (GetPlayerVehicleID(playerid) > -1)
    {
        format(string256, 256, "ID-то на твоето превозно средство е {FF0000}%d", GetVehicleModel(GetPlayerVehicleID(playerid)));
        SendClientMessage(playerid, 0xFFFFFFFF, string256);
    }
    else
    {
        format(string256, 256, "Ти не си в превозно средство!");
        SendClientMessage(playerid, 0xB4B5B7FF, string256);
    }
    return 1;
}

CMD:eoff(playerid, params[])
{
    new vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);
    if (!vehicleid) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да се качиш в превозно средство!");
    if (passenger[playerid] == true)
    {
        SendClientMessage(playerid, COLOR_RED, "Трябва да си шофьор за да спреш двигателя !");
        return 1;
    }
    if (!vehicleid) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да се качиш в превозно средство!");
    if (vehicleid == mechanicDutyVehs[0] || vehicleid == mechanicDutyVehs[1] || vehicleid == mechanicDutyVehs[2] ||
            vehicleid == mechanicDutyVehs[3] || vehicleid == mechanicDutyVehs[4] || vehicleid == mechanicDutyVehs[5] ||
            vehicleid == mechanicDutyVehs[6] || vehicleid == mechanicDutyVehs[7])
    {
        return SendClientMessage(playerid, 0xE60000FF, "Не можеш да спреш двигателя на Tow Truck-а !");
    }
    if (vehicleid == carpizza[1] || vehicleid == carpizza[2] || vehicleid == carpizza[3] || vehicleid == carpizza[4] || vehicleid == carpizza[5] || vehicleid == carpizza[6] || vehicleid == carpizza[0])
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да спреш двигателя на превозно средство за работа !");
        return 1;
    }
    if (vehicleid == carboat[1] || vehicleid == carboat[2] || vehicleid == carboat[3] || vehicleid == carboat[4] || vehicleid == carboat[5] || vehicleid == carboat[6] || vehicleid == carboat[0])
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да спреш двигателя на превозно средство за работа !");
        return 1;
    }
    if (vehicleid == afterwork[0] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[1] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[2] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[3] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[4] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[5] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[6] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[7] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[8] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[9] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[10] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[11] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[12] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[13] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[14] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[15] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[16] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[17] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[18] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[19] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[20] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[21] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[22] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[23] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[24] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[25] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[26] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[27] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[28] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[29] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[30] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[31] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[32] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[33] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[34] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[35] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[36] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[37] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[38] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[39] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[40] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[41] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[42] && PlayerInfo[playerid][pAfterWork] == 0)
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да спреш двигателя на превозно средство за след работа !");
        return 1;
    }
    if (vehicleid == carcoalmine[1] || vehicleid == carcoalmine[2] || vehicleid == carcoalmine[3] || vehicleid == carcoalmine[4] || vehicleid == carcoalmine[5] || vehicleid == carcoalmine[6] || vehicleid == carcoalmine[0])
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да спреш двигателя на превозно средство за работа !");
        return 1;
    }
    if (vehicleid == carsweeper[1] || vehicleid == carsweeper[2] || vehicleid == carsweeper[3] || vehicleid == carsweeper[4] || vehicleid == carsweeper[5] || vehicleid == carsweeper[6] || vehicleid == carsweeper[0])
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да спреш двигателя на превозно средство за работа !");
        return 1;
    }
    if (vehicleid == carpilot[1] || vehicleid == carpilot[2] || vehicleid == carpilot[3] || vehicleid == carpilot[4] || vehicleid == carpilot[5] || vehicleid == carpilot[6] || vehicleid == carpilot[0])
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да спреш двигателя на превозно средство за работа !");
        return 1;
    }
    if (vehicleid == cardeliver[1] || vehicleid == cardeliver[2] || vehicleid == cardeliver[3] || vehicleid == cardeliver[4] || vehicleid == cardeliver[5] || vehicleid == cardeliver[6] || vehicleid == cardeliver[0])
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да спреш двигателя на превозно средство за работа !");
        return 1;
    }
    if (vehicleid == carbus[1] || vehicleid == carbus[2] || vehicleid == carbus[3] || vehicleid == carbus[4] || vehicleid == carbus[5] || vehicleid == carbus[6] || vehicleid == carbus[0])
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да спреш двигателя на превозно средство за работа !");
        return 1;
    }
    if (vehicleid == cartruck[1] || vehicleid == cartruck[2] || vehicleid == cartruck[3] || vehicleid == cartruck[4] || vehicleid == cartruck[5] || vehicleid == cartruck[6] || vehicleid == cartruck[0])
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да спреш двигателя на превозно средство за работа !");
        return 1;
    }
    if (mechanicDuty[playerid] == 0 && vehicleid == mechanicDutyVehs[0] || mechanicDuty[playerid] == 0 && vehicleid == mechanicDutyVehs[1] || mechanicDuty[playerid] == 0 && vehicleid == mechanicDutyVehs[2] ||
            mechanicDuty[playerid] == 0 && vehicleid == mechanicDutyVehs[3] || mechanicDuty[playerid] == 0 && vehicleid == mechanicDutyVehs[4] || mechanicDuty[playerid] == 0 && vehicleid == mechanicDutyVehs[5] ||
            mechanicDuty[playerid] == 0 && vehicleid == mechanicDutyVehs[6] || mechanicDuty[playerid] == 0 && vehicleid == mechanicDutyVehs[7])
    {
        SendClientMessage(playerid, COLOR_RED, "Не можеш да спреш двигателя на Tow Truck-а !");
        return 1;
    }
    new haveprivate = 0;
    for (new alv = 1; alv < MAX_PRIVATEVEHS; alv++)
    {
        if (strcmp(PrivateVeh[vehicleid][pvOwner], GetPlayerNickname(playerid), true) == 0)
        {
            haveprivate = 1;
        }
        if (haveprivate == 0)
        {
            SendClientMessage(playerid, 0xE60000FF, "Не можеш да спреш двигателя на това превозно средство, защото не го притежаваш !");
        }
    }
    format(string, 256, "* Ти изключи двигателят на превозното средство *");
    SendClientMessage(playerid, 0x9ACD32FF, string);
    VehicleToggleEngine(vehicleid, VEHICLE_PARAMS_OFF);
    return 1;
}
CMD:eon(playerid, params[])
{
    new vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);
    if (vehfuel[vehicleid] <= 0)
    {
        if (!vehicleid) return SendClientMessage(playerid, 0xE60000FF, "Не може да стартира двигателя, превозното средство няма бензин !");
        return 1;
    }
    if (passenger[playerid] == true)
    {
        SendClientMessage(playerid, COLOR_RED, "Трябва да си шофьор за да пуснеш двигателя !");
        return 1;
    }
    if (vehicleid == mechanicDutyVehs[0] || vehicleid == mechanicDutyVehs[1] || vehicleid == mechanicDutyVehs[2] ||
            vehicleid == mechanicDutyVehs[3] || vehicleid == mechanicDutyVehs[4] || vehicleid == mechanicDutyVehs[5] ||
            vehicleid == mechanicDutyVehs[6] || vehicleid == mechanicDutyVehs[7])
    {
        return SendClientMessage(playerid, 0xE60000FF, "Не можеш да стартираш двигателя на Tow Truck-а !");
    }
    if (!vehicleid) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да се качиш в превозно средство!");
    if (vehicleid == carpizza[1] || vehicleid == carpizza[2] || vehicleid == carpizza[3] || vehicleid == carpizza[4] || vehicleid == carpizza[5] || vehicleid == carpizza[6] || vehicleid == carpizza[0])
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да стартираш двигателя на превозно средство за работа !");
        return 1;
    }
    if (vehicleid == carboat[1] || vehicleid == carboat[2] || vehicleid == carboat[3] || vehicleid == carboat[4] || vehicleid == carboat[5] || vehicleid == carboat[6] || vehicleid == carboat[0])
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да стартираш двигателя на превозно средство за работа !");
        return 1;
    }
    if (vehicleid == afterwork[0] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[1] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[2] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[3] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[4] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[5] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[6] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[7] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[8] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[9] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[10] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[11] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[12] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[13] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[14] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[15] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[16] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[17] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[18] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[19] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[20] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[21] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[22] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[23] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[24] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[25] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[26] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[27] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[28] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[29] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[30] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[31] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[32] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[33] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[34] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[35] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[36] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[37] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[38] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[39] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[40] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[41] && PlayerInfo[playerid][pAfterWork] == 0 ||
            vehicleid == afterwork[42] && PlayerInfo[playerid][pAfterWork] == 0)
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да стартираш двигателя на превозно средство за след работа !");
        return 1;
    }
    if (vehicleid == carcoalmine[1] || vehicleid == carcoalmine[2] || vehicleid == carcoalmine[3] || vehicleid == carcoalmine[4] || vehicleid == carcoalmine[5] || vehicleid == carcoalmine[6] || vehicleid == carcoalmine[0])
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да стартираш двигателя на превозно средство за работа !");
        return 1;
    }
    if (vehicleid == carsweeper[1] || vehicleid == carsweeper[2] || vehicleid == carsweeper[3] || vehicleid == carsweeper[4] || vehicleid == carsweeper[5] || vehicleid == carsweeper[6] || vehicleid == carsweeper[0])
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да стартираш двигателя на превозно средство за работа !");
        return 1;
    }
    if (vehicleid == carpilot[1] || vehicleid == carpilot[2] || vehicleid == carpilot[3] || vehicleid == carpilot[4] || vehicleid == carpilot[5] || vehicleid == carpilot[6] || vehicleid == carpilot[0])
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да стартираш двигателя на превозно средство за работа !");
        return 1;
    }
    if (vehicleid == cardeliver[1] || vehicleid == cardeliver[2] || vehicleid == cardeliver[3] || vehicleid == cardeliver[4] || vehicleid == cardeliver[5] || vehicleid == cardeliver[6] || vehicleid == cardeliver[0])
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да стартираш двигателя на превозно средство за работа !");
        return 1;
    }
    if (vehicleid == carbus[1] || vehicleid == carbus[2] || vehicleid == carbus[3] || vehicleid == carbus[4] || vehicleid == carbus[5] || vehicleid == carbus[6] || vehicleid == carbus[0])
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да стартираш двигателя на превозно средство за работа !");
        return 1;
    }
    if (vehicleid == cartruck[1] || vehicleid == cartruck[2] || vehicleid == cartruck[3] || vehicleid == cartruck[4] || vehicleid == cartruck[5] || vehicleid == cartruck[6] || vehicleid == cartruck[0])
    {
        SendClientMessage(playerid, 0xE60000FF, "Не можеш да стартираш двигателя на превозно средство за работа !");
        return 1;
    }
    if (mechanicDuty[playerid] == 0 && vehicleid == mechanicDutyVehs[0] || mechanicDuty[playerid] == 0 && vehicleid == mechanicDutyVehs[1] || mechanicDuty[playerid] == 0 && vehicleid == mechanicDutyVehs[2] ||
            mechanicDuty[playerid] == 0 && vehicleid == mechanicDutyVehs[3] || mechanicDuty[playerid] == 0 && vehicleid == mechanicDutyVehs[4] || mechanicDuty[playerid] == 0 && vehicleid == mechanicDutyVehs[5] ||
            mechanicDuty[playerid] == 0 && vehicleid == mechanicDutyVehs[6] || mechanicDuty[playerid] == 0 && vehicleid == mechanicDutyVehs[7])
    {
        SendClientMessage(playerid, COLOR_RED, "Не можеш да стартираш двигателя на Tow Truck-а !");
        return 1;
    }
    new haveprivate = 0;
    for (new alv = 1; alv < MAX_PRIVATEVEHS; alv++)
    {
        if (strcmp(PrivateVeh[vehicleid][pvOwner], GetPlayerNickname(playerid), true) == 0)
        {
            haveprivate = 1;
        }
        if (haveprivate == 0)
        {
            SendClientMessage(playerid, 0xE60000FF, "Не можеш да стартираш двигателя на това превозно средство, защото не го притежаваш !");
        }
    }
    format(string, 256, "* Ти включи двигателят на превозното средство *");
    SendClientMessage(playerid, 0x9ACD32FF, string);
    VehicleToggleEngine(vehicleid, VEHICLE_PARAMS_ON);
    return 1;
}
CMD:alarmoff(playerid, params[])
{
    new vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);
    if (!vehicleid) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да се качиш в превозно средство!");
    format(string, 256, "* Ти изключи алармата на превозното средство *");
    SendClientMessage(playerid, 0x9ACD32FF, string);
    ToggleAlarm(vehicleid, VEHICLE_PARAMS_OFF);
    return 1;
}
CMD:alarmon(playerid, params[])
{
    new vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);
    if (!vehicleid) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да се качиш в превозно средство!");
    format(string, 256, "* Ти включи алармата на превозното средство *");
    SendClientMessage(playerid, 0x9ACD32FF, string);
    ToggleAlarm(vehicleid, VEHICLE_PARAMS_ON);
    return 1;
}
CMD:bonnetoff(playerid, params[])
{
    new vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);
    if (!vehicleid) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да се качиш в превозно средство!");
    format(string, 256, "* Ти отвори капака на превозното средство *");
    SendClientMessage(playerid, 0x9ACD32FF, string);
    ToggleBonnet(vehicleid, VEHICLE_PARAMS_OFF);
    return 1;
}
CMD:bonneton(playerid, params[])
{
    new vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);
    if (!vehicleid) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да се качиш в превозно средство!");
    format(string, 256, "* Ти затвори капака на превозното средство *");
    SendClientMessage(playerid, 0x9ACD32FF, string);
    ToggleBonnet(vehicleid, VEHICLE_PARAMS_ON);
    return 1;
}
CMD:loff(playerid, params[])
{
    new vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);
    if (!vehicleid) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да се качиш в превозно средство!");
    format(string, 256, "* Ти изключи фаровете на превозното средство *");
    SendClientMessage(playerid, 0x9ACD32FF, string);
    ToggleLights(vehicleid, VEHICLE_PARAMS_OFF);
    return 1;
}
CMD:lon(playerid, params[])
{
    new vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);
    if (!vehicleid) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да се качиш в превозно средство!");
    format(string, 256, "* Ти включи фаровете на превозното средство *");
    SendClientMessage(playerid, 0x9ACD32FF, string);
    ToggleLights(vehicleid, VEHICLE_PARAMS_ON);
    return 1;
}
CMD:bootoff(playerid, params[])
{
    new vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);
    if (!vehicleid) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да се качиш в превозно средство!");
    format(string, 256, "* Ти затвори багажника на превозното средство *");
    SendClientMessage(playerid, 0x9ACD32FF, string);
    ToggleBoot(vehicleid, VEHICLE_PARAMS_OFF);
    return 1;
}
CMD:booton(playerid, params[])
{
    new vehicleid;
    vehicleid = GetPlayerVehicleID(playerid);
    if (!vehicleid) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да се качиш в превозно средство!");
    format(string, 256, "* Ти отвори багажника на превозното средство *");
    SendClientMessage(playerid, 0x9ACD32FF, string);
    ToggleBoot(vehicleid, VEHICLE_PARAMS_ON);
    return 1;
}

