CMD:lock(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 3 && CheckFreeVIP() == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    if (driver[playerid] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си в превозно средство като щофьор!");
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (i == playerid) continue;
        SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid), i, 0, 1);
    }
    vehLocker[playerid] = GetPlayerVehicleID(playerid);
    SendClientMessage(playerid, 0x9ACD32FF, "* Вие заключихте вратите на превозното средство *");
    SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Когато излезете от превозното средство вратите автоматично ще се отключат!");
    return 1;
}
CMD:unlock(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 3 && CheckFreeVIP() == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    if (driver[playerid] == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си в превозно средство като щофьор!");
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (i == playerid) continue;
        SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid), i, 0, 0);
    }
    SendClientMessage(playerid, 0x9ACD32FF, "* Вие отключихте вратите на превозното средство *");
    return 1;
}

CMD:sgchange(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 5 || CheckFreeVIP() == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    if (PlayerInfo[playerid][pChantichki] == 0)
    {
        PlayerInfo[playerid][pChantichki] = 1;
    }
    else
    {
        PlayerInfo[playerid][pChantichki] = 0;
    }
    return 1;
}

CMD:eject(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 6 && CheckFreeVIP() == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    if (driver[playerid] == 0)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си в превозно средство като шофьор!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /eject [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (targetid == playerid)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да изгониш себе си от превозното средство!");
        return CMD_SUCCESS;
    }

    new playerVehicle = GetPlayerVehicleID(playerid);
    if (!IsPlayerInVehicle(targetid, playerVehicle))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този играч не е в твоето превозно средство!");
        return CMD_SUCCESS;
    }

    RemovePlayerFromVehicle(targetid);
    return CMD_SUCCESS;
}

CMD:hyd(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] >= 1 || CheckFreeVIP() == 1)
    {
        if (IsPlayerInAnyVehicle(playerid))
        {
            if (inevent[playerid] == 1 && ehyd == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Командата /hyd е забранена в евента!");
            if (GetPlayerVehicleID(playerid) != 448 && GetPlayerVehicleID(playerid) != 461 && GetPlayerVehicleID(playerid) != 462 && GetPlayerVehicleID(playerid) != 463 &&
                    GetPlayerVehicleID(playerid) != 468 && GetPlayerVehicleID(playerid) != 481 && GetPlayerVehicleID(playerid) != 509 && GetPlayerVehicleID(playerid) != 510 &&
                    GetPlayerVehicleID(playerid) != 521 && GetPlayerVehicleID(playerid) != 522 && GetPlayerVehicleID(playerid) != 581 && GetPlayerVehicleID(playerid) != 586 &&
                    GetPlayerVehicleID(playerid) != 417 && GetPlayerVehicleID(playerid) != 425 && GetPlayerVehicleID(playerid) != 447 && GetPlayerVehicleID(playerid) != 460 &&
                    GetPlayerVehicleID(playerid) != 469 && GetPlayerVehicleID(playerid) != 476 && GetPlayerVehicleID(playerid) != 487 && GetPlayerVehicleID(playerid) != 488 &&
                    GetPlayerVehicleID(playerid) != 497 && GetPlayerVehicleID(playerid) != 511 && GetPlayerVehicleID(playerid) != 512 && GetPlayerVehicleID(playerid) != 513 &&
                    GetPlayerVehicleID(playerid) != 519 && GetPlayerVehicleID(playerid) != 520 && GetPlayerVehicleID(playerid) != 548 && GetPlayerVehicleID(playerid) != 553 &&
                    GetPlayerVehicleID(playerid) != 563 && GetPlayerVehicleID(playerid) != 577 && GetPlayerVehicleID(playerid) != 592 && GetPlayerVehicleID(playerid) != 593 &&
                    GetPlayerVehicleID(playerid) != 538 &&
                    GetPlayerVehicleID(playerid) != 537)
            {
                AddVehicleComponent(GetPlayerVehicleID(playerid), 1087);
                PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
            }
            else
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да добавиш хидравлика на това превозно средство!");
            }
        }
        else
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозно средство!");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    }
    return 1;
}
CMD:nos(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] >= 1 || CheckFreeVIP() == 1)
    {
        if (IsPlayerInAnyVehicle(playerid))
        {
            if (inevent[playerid] == 1 && enos == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Командата /nos е забранена в евента!");
            if (GetPlayerVehicleID(playerid) != 448 && GetPlayerVehicleID(playerid) != 461 && GetPlayerVehicleID(playerid) != 462 && GetPlayerVehicleID(playerid) != 463 &&
                    GetPlayerVehicleID(playerid) != 468 && GetPlayerVehicleID(playerid) != 481 && GetPlayerVehicleID(playerid) != 509 && GetPlayerVehicleID(playerid) != 510 &&
                    GetPlayerVehicleID(playerid) != 521 && GetPlayerVehicleID(playerid) != 522 && GetPlayerVehicleID(playerid) != 581 && GetPlayerVehicleID(playerid) != 586 &&
                    GetPlayerVehicleID(playerid) != 417 && GetPlayerVehicleID(playerid) != 425 && GetPlayerVehicleID(playerid) != 447 && GetPlayerVehicleID(playerid) != 460 &&
                    GetPlayerVehicleID(playerid) != 469 && GetPlayerVehicleID(playerid) != 476 && GetPlayerVehicleID(playerid) != 487 && GetPlayerVehicleID(playerid) != 488 &&
                    GetPlayerVehicleID(playerid) != 497 && GetPlayerVehicleID(playerid) != 511 && GetPlayerVehicleID(playerid) != 512 && GetPlayerVehicleID(playerid) != 513 &&
                    GetPlayerVehicleID(playerid) != 519 && GetPlayerVehicleID(playerid) != 520 && GetPlayerVehicleID(playerid) != 548 && GetPlayerVehicleID(playerid) != 553 &&
                    GetPlayerVehicleID(playerid) != 563 && GetPlayerVehicleID(playerid) != 577 && GetPlayerVehicleID(playerid) != 592 && GetPlayerVehicleID(playerid) != 593 &&
                    GetPlayerVehicleID(playerid) != 538 &&
                    GetPlayerVehicleID(playerid) != 537)
            {
                PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
                if (PlayerInfo[playerid][pInfiniteNos] == 0)
                {
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1008);
                }
                else
                {
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
                }
            }
            else
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да добавиш нитро на това превозно средство!");
            }
        }
        else
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозно средство!");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    }
    return 1;
}
CMD:cnos(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] >= 2 || CheckFreeVIP() == 1)
    {
        if (PlayerInfo[playerid][pInfiniteNos] == 0)
        {
            SendClientMessage(playerid, 0x0066FFFF, "Твоето нитро вече е безкрайно!");
            PlayerInfo[playerid][pInfiniteNos] = 1;
            PlayerInfo[playerid][pInfiniteNosTimer] = 2;
            if (IsPlayerInAnyVehicle(playerid))
            {
                AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
            }
        }
        else
        {
            PlayerInfo[playerid][pInfiniteNos] = 0;
            if (IsPlayerInAnyVehicle(playerid))
            {
                AddVehicleComponent(GetPlayerVehicleID(playerid), 1008);
            }
            SendClientMessage(playerid, 0x0066FFFF, "Твоето нитро вече е краино!");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    }
    return 1;
}
CMD:flip(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] >= 1 || CheckFreeVIP() == 1)
    {
        if (!IsPlayerInAnyVehicle(playerid))
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си в превозно средство!");
            return 1;
        }
        if (inevent[playerid] == 1 && eflip == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Командата /flip е забранена в евента!");
        GetPlayerPos(playerid, X[playerid], Y[playerid], Z[playerid]);
        new Float:currentVehAngle;
        GetVehicleZAngle(GetPlayerVehicleID(playerid), currentVehAngle);
        SetVehiclePos(GetPlayerVehicleID(playerid), X[playerid], Y[playerid], Z[playerid]);
        SetVehicleZAngle(GetPlayerVehicleID(playerid), currentVehAngle);
        SendClientMessage(playerid, 0xFFFFFFFF, "* Вие преобърнахте вашето превозно средство *");
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    }
    return 1;
}

CMD:ramphelp(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 3 && CheckFreeVIP() == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    SendClientMessage(playerid, 0xFF0000FF, "* Информация за рампите *");
    SendClientMessage(playerid, 0xFFFFFFFF, "Използвай /ramping за да позволиш/забраниш рампите за себе си.");
    SendClientMessage(playerid, 0xFFFFFFFF, "Използвай /myramp [1-5] за да смениш твоята рампа.");
    SendClientMessage(playerid, 0xFFFFFFFF, "За да се появи рампа до теб натисни бутона ляв CTRL или опитай друг, които ти тръгва!");
    return 1;
}
CMD:ramping(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 3 && CheckFreeVIP() == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    if (enabledramp[playerid] == 0)
    {
        enabledramp[playerid] = 1;
        SendClientMessage(playerid, 0xFFFF00FF, "Ти позволи рампите за себе си!");
        SendClientMessage(playerid, 0xFFFF00FF, "За да се появи рампа пред теб натисни бутона ляв CTRL или опитай друг, които ти тръгва!");
    }
    else
    {
        SendClientMessage(playerid, 0xFFFF00FF, "Ти забрани рампите за себе си!");
        DestroyDynamicObject(rampobject[playerid]);
        enabledramp[playerid] = 0;
    }
    return 1;
}

CMD:viphelp(playerid, params[])
{
    new string2230[512];
    new string2230result[1500];
    strcat(string2230result, "{00FF00}VIP MOD системата е услуга която ви дава по-голям набор от команди и бонуси\n");
    format(string2230, 512, "{00FF00}VIP MOD системата може да се получи чрез канене на хора VIP левелите са до 6-ти левел\n\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}------------= Бонуси =--------------\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{00FF00}\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF} \n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{00FF00}---= VIP Level 1 =---\n\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}•Когато убиеш играч получаваш $250, а когато умреш губиш $50\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{00FF00}---= VIP Level 2 =---\n\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}•На всеки Payday получаваш 1EP и $1000\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{00FF00}---= VIP Level 3 =---\n\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}•На всеки Payday получаваш 2EP и $2000\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}•Времето за чакане на нова работа е 30 минути\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{00FF00}---= VIP Level 4 =---\n\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}•На всеки Payday получаваш 3EP и $3000\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}•Времето за чакане на нова работа е 30 минути\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}•При всеки SPAWN те пуска с 100 ARMOUR\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}•Ще имаш закачен 3D текст на главата - VIP\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}•Ще имаш лазер на оръжията - M4 и MP5\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}•Ще получаваш 2EP за всяка свършена работа\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{00FF00}---= VIP Level 5 =---\n\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}•На всеки Payday получаваш 4EP и $4000\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}•При всеки SPAWN ще те пуска с 5 гранати\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{00FF00}---= VIP Level 6 =---\n\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}•На всеки Payday получаваш 5EP и $5000\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}•При всеки SPAWN ще те пуска с още 5 гранати\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}•Времето за чакане на нова работа е 20 минути\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}•Ще получаваш 3EP за всяка свършена работа\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}•Когато си в кола и натиснеш Y превозното средство ще се FLIP-ва\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}•Kaто убиеш играч ще получаваш $500\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{00FF00}Цъкни на бутона Команди за да видиш всички VIP команди \n");
    strcat(string2230result, string2230);
    ShowPlayerDialog(playerid, 4, DIALOG_STYLE_MSGBOX, "{FFFFFF}VIP {008000}MOD {FF0000}BONUS", string2230result, "Команди", "Затвори");
    return 1;
}

CMD:vguns(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] >= 3 || CheckFreeVIP() == 1)
    {
        if (PlayerInfo[playerid][pVGuns] > 0)
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Не е изминало нужното време от последното използване на командата!");
            return 1;
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_CIVILIAN)
        {
            SendClientMessage(playerid, 0x33AA33FF, "SERVER: Ти си добави Sawn-off и M4!");
            GivePlayerWeapon(playerid, 31, 50);
            GivePlayerWeapon(playerid, 26, 55);
            PlayerInfo[playerid][pVGuns] = 15 * 60;
        }
        else
        {
            SendClientMessage(playerid, 0x33AA33FF, "SERVER: Ти си добави Sniper Rifle и Knife");
            GivePlayerWeapon(playerid, 34, 15);
            GivePlayerWeapon(playerid, 4, 1);
            PlayerInfo[playerid][pVGuns] = 15 * 60;
        }
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш достатъчно VIP права за да ползваш командата!");
    }
    return 1;
}
CMD:tune(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 3 || CheckFreeVIP() == 1 && !IsPlayerInRangeOfPoint(playerid, 4.0, 1247.9263, -2051.8269, 59.5036) && !IsPlayerInRangeOfPoint(playerid, 4.0, 1248.8352, -2058.9548, 59.4665) && !IsPlayerInRangeOfPoint(playerid, 4.0, 2404.2773, 1023.2300, 10.5474) && !IsPlayerInRangeOfPoint(playerid, 4.0, 2404.1978, 1029.6959, 10.5400))
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    }
    if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си в превозно средство като шофьор!");
        return 1;
    }
    if (inevent[playerid] == 1 && etune == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Командата /tune е забранена в евента!");
    ShowMenuForPlayer(TuningMenu, playerid);
    TogglePlayerControllable(playerid, 0);
    InTuneGarage[playerid] = true;
    return 1;
}
CMD:vrefuel(playerid, params[])
{
    new vehicle;
    vehicle = GetPlayerVehicleID(playerid);
    if (PlayerInfo[playerid][pVip] >= 3 || CheckFreeVIP() == 1)
    {
        if (vehicle > 0)
        {
            if (PlayerInfo[playerid][pRefuel20LitTimer] == 0)
            {
                if (vehfuel[GetPlayerVehicleID(playerid)] >= 80) return SendClientMessage(playerid, 0xB4B5B7FF, "Твоето превозно средство има над 80 литра!");
                vehfuel[GetPlayerVehicleID(playerid)] += 20;
                SendClientMessage(playerid, 0xFFFF00FF, "Ти добави 20 литра бензин на твоето превозно средство");
                PlayerInfo[playerid][pRefuel20LitTimer] = 6 * 60;
            }
            else
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Не са минали 6 минути от последното използване на командата!");
            }
        }
        else
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозно средство!");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    }
    return 1;
}

CMD:aviptext(playerid, params[])
{
    new targetid, text[256];
    if (sscanf(params, "us[256]", targetid, text))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /aviptext [playerid] [text]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (targetid == playerid)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да смениш своя 3D текст!");
        return CMD_SUCCESS;
    }

    if (strlen(text) < 1 || strlen(text) > 25)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва символите да бъдат между 1 и 25!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pVip] < 6 && CheckFreeVIP() == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч няма достатъчно VIP права за да му сложиш текст!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pADuty] == 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч е ADMIN ON-DUTY!");
        return CMD_SUCCESS;
    }

    // Remove old label
    UpdateDynamic3DTextLabelText(PlayerLabel[targetid], 0x800000FF, " ");
    format(VipText3D[targetid], 26, "");

    // Create new label
    PlayerLabel[targetid] = CreateDynamic3DTextLabel(text, 0xCC0000FF, 0.0, 0.0, 0.0, 15.0, targetid, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(targetid), GetPlayerInterior(targetid), -1, 15.0);

    new stringaa[256];
    format(stringaa, sizeof(stringaa), "VIP Label: Ти смени 3D текста на главата на %s на %s", GetPlayerNickname(targetid), text);
    SendClientMessage(playerid, 0xFF3737FF, stringaa);

    format(stringaa, sizeof(stringaa), "VIP Label: %s смени твоят 3D текст на главата ти на %s", GetPlayerNickname(playerid), text);
    SendClientMessage(targetid, 0xFF3737FF, stringaa);

    format(VipText3D[targetid], 26, "%s", text);
    PlayerInfo[targetid][pVIPLabel] = 1;

    return CMD_SUCCESS;
}

CMD:viptext(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 6 && CheckFreeVIP() == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pADuty] == 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си ON-DUTY!");
        return CMD_SUCCESS;
    }

    new text[256];
    if (sscanf(params, "s[256]", text))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /viptext [text]");
        return CMD_SUCCESS;
    }

    if (strlen(text) < 1 || strlen(text) > 25)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва символите да бъдат между 1 и 25!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pCash] < 5000)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $5000 за да смениш текста на главата си!");
        return CMD_SUCCESS;
    }

    PlayerInfo[playerid][pCash] -= 5000;

    // Remove old label
    UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, " ");
    format(VipText3D[playerid], 26, "");

    // Create new label
    PlayerLabel[playerid] = CreateDynamic3DTextLabel(text, 0xCC0000FF, 0.0, 0.0, 0.0, 15.0, playerid, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 15.0);

    new stringaa[256];
    format(stringaa, sizeof(stringaa), "VIP Label: Ти смени твоят 3D текст на главата ти на %s", text);
    SendClientMessage(playerid, 0xFF3737FF, stringaa);

    format(VipText3D[playerid], 26, "%s", text);
    PlayerInfo[playerid][pVIPLabel] = 1;

    return CMD_SUCCESS;
}

CMD:viplabel(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 4 && CheckFreeVIP() == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pADuty] == 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си ON-DUTY!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pVIPLabel] == 0)
    {
        // Remove old label
        UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, " ");
        format(VipText3D[playerid], 26, "");

        // Create VIP label
        format(VipText3D[playerid], 26, "VIP");
        PlayerLabel[playerid] = CreateDynamic3DTextLabel(VipText3D[playerid], 0x800000FF, 0.0, 0.0, 0.0, 15.0, playerid, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 15.0);

        PlayerInfo[playerid][pVIPLabel] = 1;
        SendClientMessage(playerid, 0xFF3737FF, "VIP Label: Вече над главата ти пише 'VIP'.");
    }
    else
    {
        // Remove VIP label
        PlayerInfo[playerid][pVIPLabel] = 0;
        UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, " ");

        new stringaaa[256];
        format(stringaaa, sizeof(stringaaa), "VIP Label: Вече над главата ти няма да пише '%s'.", VipText3D[playerid]);
        SendClientMessage(playerid, 0xFF3737FF, stringaaa);

        format(VipText3D[playerid], 26, "");
    }

    return CMD_SUCCESS;
}

CMD:laser(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 4 && CheckFreeVIP() == 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    }
    if (PlayerInfo[playerid][pLaser] == 0)
    {
        if (PlayerInfo[playerid][pTeam] == FACTION_VIP)
        {
            SetPVarInt(playerid, "color", 18643);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_GROVE)
        {
            SetPVarInt(playerid, "color", 19083);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_RIFA)
        {
            SetPVarInt(playerid, "color", 19080);
        }
        if (PlayerInfo[playerid][pTeam] == FACTION_INTENSE_POLICE)
        {
            SetPVarInt(playerid, "color", 19080);
        }
        PlayerInfo[playerid][pLaser] = 1;
        SendClientMessage(playerid, 0xF97804FF, "VIP Laser: Ти добави лазера.");
        return CMD_SUCCESS;
    }
    else
    {
        PlayerInfo[playerid][pLaser] = 0;
        SetPVarInt(playerid, "color", 0);
        SendClientMessage(playerid, 0xF97804FF, "VIP Laser: Ти си махна лазера.");
    }
    return CMD_SUCCESS;
}

CMD:parrot(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 4 && CheckFreeVIP() == 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    }
    if (PlayerInfo[playerid][pParrot] == 0)
    {
        SendClientMessage(playerid, 0xF97804FF, "Ти си сложи папагал!");
        SetPlayerAttachedObject(playerid, 10, 19078, 15, 0.073592, 0.024750, 0.023458, 164.272216, 87.050361, 0.000000, 1.000000, 0.968321, 1.118647) && EditAttachedObject(playerid, 10);
        PlayerInfo[playerid][pParrot] = 1;
        return CMD_SUCCESS;
    }
    else
    {
        PlayerInfo[playerid][pParrot] = 0;
        RemovePlayerAttachedObject(playerid, 10);
        SendClientMessage(playerid, 0xF97804FF, "Ти си махна папагала!");
    }
    return CMD_SUCCESS;
}

CMD:jetpack(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] >= 2 || CheckFreeVIP() == 1)
    {
        if (PlayerInfo[playerid][pJail] > 0)
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да използваш тази команда, докато си в затвора!");
            return 1;
        }
        if (PlayerInfo[playerid][pPJail] > 0)
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да използваш тази команда, докато си в затвора!");
            return 1;
        }
        if (playerInDuel[playerid] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си в дуел!");
        }
        if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си в евент!");
        if (playerInDMON[playerid] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си в DMON!");
        }
        if (PlayerInfo[playerid][pWanted] > 0)
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да използваш тази команда, докато си заподозрян!");
            return 1;
        }
        if (onWork[playerid] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да използваш тази команда, докато си на работа!");
        if (inevent[playerid] == 1 && ejetpack == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Командата /healme е забранена в евента!");
        if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
        if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
        SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш достатъчно VIP права за да ползваш командата!");
    }
    return 1;
}

CMD:clothes(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 6 && CheckFreeVIP() == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    if (loadedClothes[playerid] == false)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "* Ти зареди твоите обжекти, използвай /clothes за достъп до тях *");
        loadedClothes[playerid] = true;
    }
    else if (loadedClothes[playerid] == true)
    {
        new string2230[512];
        new string2230result[1500];
        for (new i = 1; i < 9; i++)
        {
            new clothID = PlayerInfo[playerid][pClothes][i];
            format(string2230, 512, "{FFFFFF}Слот %d {FFFF00}[%s]\n", i, GetClothName(clothID));
            strcat(string2230result, string2230);
        }
        ShowPlayerDialog(playerid, DIALOG_CLOTHES, DIALOG_STYLE_LIST, "Clothes:", string2230result, "Избери", "Излез");
    }
    return 1;
}

CMD:advert(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 2 && CheckFreeVIP() == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш тази команда!");
        return CMD_SUCCESS;
    }

    if (!IsPlayerInRangeOfPoint(playerid, 4, 1720.5767, -1671.2698, 20.2241))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си в Artium за да пуснеш обява!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pCash] < 500)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $500!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pAdvertTime] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Все още не можеш да пускаш обяви!");
        return CMD_SUCCESS;
    }

    if (BizInfo[enteredbiz[playerid]][bOwner] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Бизнесът няма притежател и не можеш да пуснеш обява от тук!");
        return CMD_SUCCESS;
    }

    new text[256];
    if (sscanf(params, "s[256]", text))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /advert [text]");
        SendClientMessage(playerid, 0xFFFFFFFF, "Цена: $500");
        return CMD_SUCCESS;
    }

    // Process the advert
    GivePlayerCash(playerid, -500);

    new advertstring[700];
    format(advertstring, sizeof(advertstring), "Advert From %s(%d): %s", GetPlayerNickname(playerid), playerid, text);
    SendClientMessageToAll(0xFAF305FF, advertstring);

    PlayerInfo[playerid][pAdvertTime] = 30 * 60;
    BizInfo[enteredbiz[playerid]][bEarnings] += 500;

    return CMD_SUCCESS;
}

CMD:listguns(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] == 0 && CheckFreeVIP() != 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш тази команда!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /listguns [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    new sweapon, sammo, gunname[100];
    new weaponCount = 0;

    // Send header
    new string256[256];
    format(string256, sizeof(string256), "*** Оръжията на %s ***", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFFFFFF, string256);

    // List all weapons
    for (new i = 0; i < 12; i++)
    {
        GetPlayerWeaponData(targetid, i, sweapon, sammo);
        GetWeaponName(sweapon, gunname, sizeof(gunname));

        if (sweapon != 0)
        {
            format(string256, sizeof(string256), "%s (%d)", gunname, sammo);
            SendClientMessage(playerid, 0xFFFF00FF, string256);
            weaponCount++;
        }
    }

    // If no weapons found
    if (weaponCount == 0)
    {
        format(string256, sizeof(string256), "%s няма оръжия в себе си!", GetPlayerNickname(targetid));
        SendClientMessage(playerid, 0xFFFFFFFF, string256);
    }

    return CMD_SUCCESS;
}

CMD:v(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] > 0 || CheckFreeVIP() == 1)
    {
        if (isTurfMember[playerid])
        {
            return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да използваш тази команда, докато си участник в търф атака!");
        }
        if (GetPlayerVirtualWorld(playerid) != 0) return SendClientMessage(playerid, COLOR_GRAD1, "Можеш да използваш тази команда само във Virtual World 0");
        new Float:x, Float:y, Float:z;
        GetPlayerPos(playerid, x, y, z); // forgot playerid here in your code

        if (IsValidVehicle(vbike[playerid]))
        {
            DestroyVehicle(vbike[playerid]);
        }

        vbike[playerid] = AddStaticVehicle(481, x, y, z, 0.0, random(40), random(40)); // BMX
        SetVehiclePos(vbike[playerid], x, y, z);
        LinkVehicleToInterior(vbike[playerid], GetPlayerInterior(playerid));
        SetVehicleVirtualWorld(vbike[playerid], GetPlayerVirtualWorld(playerid));
        PutPlayerInVehicle(playerid, vbike[playerid], 0);
        SendClientMessage(playerid, 0xffff00ff, "Вие си пуснахте колело!");
        SetPlayerArmedWeapon(playerid, 0);
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    }
    return 1;
}

CMD:vtimers(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] > 0 || CheckFreeVIP() == 1)
    {
        new heal = PlayerInfo[playerid][pHealT] / 60;
        new fix = PlayerInfo[playerid][pFixT] / 60;
        new vguns = PlayerInfo[playerid][pVGuns] / 60;


        new str[256];
        new string2230result[2230];
        format(str, 256, "{ffffff}Оставащо време до:");
        SendClientMessage(playerid, 0xffffffff, str);

        format(str, 256, "/healme: {ff0000}%d {ffffff}мин. {ffff00}/fix: {ff0000}%d {ffffff}мин. {ffff00}/vguns: {ff0000}%d {ffffff}мин..",
               heal, fix, vguns);
        SendClientMessage(playerid, 0xffff00ff, str);

    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    }
    return 1;
}

CMD:isafk(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] <= 0 && CheckFreeVIP() != 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /isafk [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pAFK] == 0)
    {
        SendClientMessage(playerid, 0xD6F34AFF, "Този играч не е в AFK режим!");
    }
    else if (PlayerInfo[targetid][pAFK] < 60)
    {
        new string256[256];
        format(string256, sizeof(string256), "Този играч е в AFK режим от %d секунди!", PlayerInfo[targetid][pAFK]);
        SendClientMessage(playerid, 0xD6F34AFF, string256);
    }
    else
    {
        new string256[256];
        format(string256, sizeof(string256), "Този играч е в AFK режим от %d минути!", PlayerInfo[targetid][pAFK] / 60);
        SendClientMessage(playerid, 0xD6F34AFF, string256);
    }

    return CMD_SUCCESS;
}

CMD:mybank(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] >= 3)
    {
        new stringBank[256];
        format(stringBank, 256, "Твоята банкова сметка съдържа $%d", PlayerInfo[playerid][pAccount]);
        SendClientMessage(playerid, 0x33aa33FF, stringBank);
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    }
    return 1;
}

CMD:isactive(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 2)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /isactive [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    new stringActive[256];
    
    if (PlayerInfo[targetid][pAFK] > 0)
    {
        format(stringActive, sizeof(stringActive), "Играчът %s е в AFK режим", GetPlayerNickname(targetid));
        SendClientMessage(playerid, 0xFFFFFFFF, stringActive);
        return CMD_SUCCESS;
    }
    
    if (IsPlayerPaused(targetid))
    {
        if (playerAfkSeconds[targetid] >= 1 && playerAfkMinutes[targetid] == 0)
        {
            format(stringActive, sizeof(stringActive), "Играчът %s е в ESC менюто от %d секунди", GetPlayerNickname(targetid), playerAfkSeconds[targetid]);
            SendClientMessage(playerid, 0xFFFFFFFF, stringActive);
            return CMD_SUCCESS;
        }
        
        if (playerAfkMinutes[targetid] >= 1)
        {
            format(stringActive, sizeof(stringActive), "Играчът %s е в ESC менюто от %d минути", GetPlayerNickname(targetid), playerAfkMinutes[targetid]);
            SendClientMessage(playerid, 0xFFFFFFFF, stringActive);
            return CMD_SUCCESS;
        }
    }
    
    format(stringActive, sizeof(stringActive), "Играчът %s е активен", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFFFFFF, stringActive);
    
    return CMD_SUCCESS;
}

CMD:kill(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] > 1 || CheckFreeVIP() == 1)
    {
        if (cmn1[playerid] > 0)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се самоубиеш, докато си CMN1!");
        }
        if (playerInDuel[playerid] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се самоубиеш, докато си в дуел!");
        }
        if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си в евент!");
        if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
        if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
        if (playerInDMON[playerid] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се самоубиеш, докато си в DMON!");
        }
        SetPlayerHealth(playerid, 0);
        SendClientMessage(playerid, 0xFFFF00FF, "Ти си луд, защото се самоуби!");
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    }
    return 1;
}
CMD:tires(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 6 && CheckFreeVIP() == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
        return 1;
    }
    if (inevent[playerid] == 1 && efix == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Командата /tires е забранена в евента!");
    if (PlayerInfo[playerid][pFixT] == 0)
    {
        if (IsPlayerInAnyVehicle(playerid))
        {
            new Panels, Doors, Lights, Tires;
            new vehicleid = GetPlayerVehicleID(playerid);
            GetVehicleDamageStatus(vehicleid, Panels, Doors, Lights, Tires);
            UpdateVehicleDamageStatus(vehicleid, Panels, Doors, Lights, 0);
            //UpdateVehicleDamageStatus(vehicleid, Panels, Doors, Lights, (Tires | 0b00));
            PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
            PlayerInfo[playerid][pFixT] = 30 * 60;
            SendClientMessage(playerid, 0xFFFFFFFF, "* Вие поправихте гумите на вашето превозно средство *");
        }
        else
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозно средство!");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не е изминало нужното време от последното използване на командата!");
    }
    return 1;
}
CMD:fix(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 2 && CheckFreeVIP() == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
        return 1;
    }
    if (inevent[playerid] == 1 && efix == 0) return SendClientMessage(playerid, COLOR_GRAD1, "Командата /fix е забранена в евента!");
    if (PlayerInfo[playerid][pFixT] == 0)
    {
        if (IsPlayerInAnyVehicle(playerid))
        {
            SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
            RepairVehicle(GetPlayerVehicleID(playerid));
            PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
            PlayerInfo[playerid][pFixT] = 30 * 60;
        }
        else
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозно средство!");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не е изминало нужното време от последното използване на командата!");
    }
    return 1;
}

CMD:cc(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 2 && CheckFreeVIP() != 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");

    if (!IsPlayerInAnyVehicle(playerid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозно средство!");

    new color1, color2;
    if (sscanf(params, "ii", color1, color2))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /cc [color1] [color2]");
        return 1;
    }

    ChangeVehicleColor(GetPlayerVehicleID(playerid), color1, color2);
    SendClientMessage(playerid, 0xFFFF00FF, "* Ти смени цвета на колата си *");
    
    return 1;
}

CMD:pj(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 2 && CheckFreeVIP() != 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");

    if (!IsPlayerInAnyVehicle(playerid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозно средство!");

    new paintjob;
    if (sscanf(params, "i", paintjob))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /pj [0-5]");
        return 1;
    }

    ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), paintjob);
    SendClientMessage(playerid, 0xFFFF00FF, "Ти пребоядиса твоята кола!");
    
    return 1;
}

CMD:para(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] > 2 || CheckFreeVIP() == 1)
    {
        GivePlayerWeapon(playerid, 46, 1);
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    }
    return 1;
}

CMD:sound(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 2 && CheckFreeVIP() != 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
    }

    new soundid;
    if (sscanf(params, "i", soundid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /sound [sound id]");
        return 1;
    }

    SendClientMessage(playerid, 0xFFFF00FF, "Ти си пусна звук!");
    PlayerPlaySound(playerid, soundid, 0.0, 0.0, 0.0);
    
    return 1;
}

CMD:vipusers(playerid, params[])
{
    new vipusers;
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerInfo[i][pVip] >= 1)
        {
            vipusers += 1;
        }
    }
    format(string256, 256, "Онлайн VIP играчи(%d):", vipusers);
    SendClientMessage(playerid, 0x40BF00FF, string256);
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerInfo[i][pVip] >= 1)
        {
            format(string256, 256, "%s (ID: %d) - VIP Level: %d", GetPlayerNickname(i), i, PlayerInfo[i][pVip]);
            SendClientMessage(playerid, 0xFFB366FF, string256);
        }
    }
    if (vipusers == 0)
    {
        format(string256, 256, "Няма онлайн VIP играчи в момента!");
        SendClientMessage(playerid, 0xFFB366FF, string256);
    }
    return 1;
}

CMD:myramp(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 3 && CheckFreeVIP() == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
        return 1;
    }
    
    if (enabledramp[playerid] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си позволил рампите за себе си!");
        return 1;
    }
    
    new ramp;
    if (sscanf(params, "d", ramp))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /myramp [1-5]");
        return 1;
    }
    
    if (ramp < 1 || ramp > 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Рампите са от 1 до 5!");
        return 1;
    }
    
    if (enabledramp[playerid] == ramp)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече си избрал тази рампа!");
        return 1;
    }
    
    enabledramp[playerid] = ramp;
    SendClientMessage(playerid, 0xFFFF00FF, "Ти смени твоята рампа!");
    
    return 1;
}

CMD:vipchat(playerid, params[])
{
    if (PlayerInfo[playerid][pVip] < 1 && CheckFreeVIP() != 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш достатъчно VIP права за да ползваш командата!");
        return 1;
    }
    
    new message[128];
    if (sscanf(params, "s[128]", message))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /vipchat [text]");
        return 1;
    }
    
    new vipMessage[256];
    format(vipMessage, sizeof(vipMessage), "[VIP CHAT] %s(ID:%d): %s", GetPlayerNickname(playerid), playerid, message);
    
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && (PlayerInfo[i][pVip] > 0 || CheckFreeVIP() == 1))
        {
            SendClientMessage(i, 0xE65B00FF, vipMessage);
        }
    }
    
    return 1;
}
