CMD:createhouse(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new price, interior_id, level;
    if (sscanf(params, "iii", price, interior_id, level))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /createhouse [price] [interior 1-20] [level]");
        return 1;
    }

    if (price < 1)
        return SendClientMessage(playerid, 0xFF0000FF, "Цената трябва да е по-голяма от 0!");

    if (interior_id < 1 || interior_id > 20)
        return SendClientMessage(playerid, 0xFF0000FF, "Interior ID трябва да е между 1 и 20!");

    if (level < 1)
        return SendClientMessage(playerid, 0xFF0000FF, "Нивото трябва да е поне 1!");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    new query[512];
    mysql_format(Database, query, sizeof(query),
                 "INSERT INTO houses (owner_name, owner, x, y, z,cx ,cy, cz, ca, cc, c_c2, cv, c_veh, locked, veh, " \
                 "level, price, interior, armour, health) " \
                 "VALUES ('None', 0, '%f', '%f', '%f', 0.0, 0.0, 0.0, 0.0, 0, 0, 0, 0, 0, 0, '%d', '%d', '%d', 0, 0);",
                 x, y, z, level, price, interior_id
                );

    mysql_query(Database, query, true);
    new houseid = cache_insert_id();

    HouseInfo[houseid][hX] = x;
    HouseInfo[houseid][hY] = y;
    HouseInfo[houseid][hZ] = z;
    HouseInfo[houseid][hOwner] = 0;
    HouseInfo[houseid][hLocked] = 0;
    HouseInfo[houseid][hcVeh] = 0;
    HouseInfo[houseid][hPrice] = price;
    HouseInfo[houseid][hInterior] = interior_id;
    HouseInfo[houseid][hLevel] = level;
    format(HouseInfo[houseid][hOwnerName], 256, "None");

    housepickup[houseid] = CreatePickup(1273, 1, x, y, z, 0);
    HouseByPickup[housepickup[houseid]] = houseid;
    CheckMaxHouseID();

    SendClientMessage(playerid, 0x00FF40FF, "Ти успешно създаде нова къща!");

    return 1;
}

CMD:getip(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /getip [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    new ip[16];
    GetPlayerIp(targetid, ip, sizeof(ip));

    new string115[115];
    format(string115, sizeof(string115), "%s's IP: %s", GetPlayerNickname(targetid), ip);
    SendClientMessage(playerid, 0xFFFF00FF, string115);

    return CMD_SUCCESS;
}

CMD:freeze(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /freeze [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    TogglePlayerControllable(targetid, 0);

    new string115[115];
    format(string115, sizeof(string115), "* Ти замрази %s *", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFF00FF, string115);

    format(string115, sizeof(string115), "* %s те замрази *", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0xFFFF00FF, string115);

    return CMD_SUCCESS;
}

CMD:explode(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /explode [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pAdmin] < 5 && PlayerInfo[targetid][pAdmin] >= 5)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да използваш тази команда върху администратор с 5-то ниво!");
        return CMD_SUCCESS;
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(targetid, x, y, z);
    CreateExplosion(x, y, z, 7, 1.0);

    new string115[115];
    format(string115, sizeof(string115), "* Ти взриви %s *", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFF00FF, string115);

    format(string115, sizeof(string115), "* %s те взриви *", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0xFFFF00FF, string115);

    format(string115, sizeof(string115), "Explode: %s взриви %s", GetPlayerNickname(playerid), GetPlayerNickname(targetid));
    SendClientMessageToAll(0xE60000FF, string115);

    return CMD_SUCCESS;
}

CMD:disarm(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /disarm [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    ResetPlayerWeapons(targetid);

    new string115[115];
    format(string115, sizeof(string115), "* Ти взе всички оръжия на %s *", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFFFFFF, string115);

    format(string115, sizeof(string115), "* %s взе всички твои оръжия *", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0xFFFF00FF, string115);

    return CMD_SUCCESS;
}

CMD:unfreeze(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /unfreeze [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    TogglePlayerControllable(targetid, 1);

    new string115[115];
    format(string115, sizeof(string115), "* Ти отмрази %s *", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFF00FF, string115);

    format(string115, sizeof(string115), "* %s те отмрази *", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0xFFFF00FF, string115);

    return CMD_SUCCESS;
}

CMD:isjailed(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /isjailed [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pJail] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е в затвора!");
        return CMD_SUCCESS;
    }

    // Get jail reason text
    new jailreason[128];
    switch (PlayerInfo[targetid][pJailReason])
    {
        case 1: jailreason = "Каране на Job Vehicle за собствени цели";
        case 2: jailreason = "Биене/Крадене на кола в тунинг гараж";
        case 3: jailreason = "Лъже играчите";
        case 4: jailreason = "DB без шофьор";
        case 5: jailreason = "Пречи на хората да работят";
        case 6: jailreason = "Грешен Report/Advert";
        case 7: jailreason = "Биене на TFC служител On-Duty";
        case 8: jailreason = "Glitch";
        case 9: jailreason = "Оплакване във форума";
        case 10: jailreason = "Грешно използване на /me или /do";
        case 11: jailreason = "AFK в Job Vehicle";
        case 12: jailreason = "Биене на ADMIN ON-DUTY";
        case 13: jailreason = "Самоубива се на DMON";
        case 14: jailreason = "Прочети правилата /rules";
        default:
            jailreason = "Неизвестна причина";
    }

    new string256[256];
    format(string256, sizeof(string256), "Този играч е в затвора и причината е - %s!", jailreason);
    SendClientMessage(playerid, 0xE60000FF, string256);

    return CMD_SUCCESS;
}

CMD:goto(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /goto [playerid]");
        return 1;
    }

    if (targetid == playerid)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш до себе си!");

    if (PlayerInfo[playerid][pTGoto] == 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш позволение да се телепортираш до играчите!");

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    new Float:plocx, Float:plocy, Float:plocz;
    GetPlayerPos(targetid, plocx, plocy, plocz);

    if (PlayerInfo[playerid][pAdmin] >= 5)
    {
        SetPlayerInterior(playerid, GetPlayerInterior(targetid));
        SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));

        if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
        {
            SetVehiclePos(GetPlayerVehicleID(playerid), plocx, plocy + 4.0, plocz);
        }
        else
        {
            SetPlayerPos(playerid, plocx, plocy + 2.0, plocz);
        }

        new string115[115];
        format(string115, sizeof(string115), "* %s се телепортира до теб *", GetPlayerNickname(playerid));
        SendClientMessage(targetid, 0xFFFF00FF, string115);

        format(string115, sizeof(string115), "* Ти се телепортира до %s *", GetPlayerNickname(targetid));
        SendClientMessage(playerid, 0xFFFFFFFF, string115);

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAHide] == 0)
            {
                format(string115, sizeof(string115), "Teleport: %s се телепортира до %s", GetPlayerNickname(playerid), GetPlayerNickname(targetid));
                SendClientMessage(i, 0xE60000FF, string115);
            }
        }
    }
    else
    {
        GotoInviteAccepted[targetid] = false;
        GotoInvite[targetid] = playerid;

        new string115[115];
        format(string115, sizeof(string115), "%s иска да се телепортира до теб!", GetPlayerNickname(playerid));
        SendClientMessage(targetid, 0xFFFF00FF, string115);
        SendClientMessage(targetid, 0xFFFF00FF, "Използвай /accept за да приемеш или /reject за да откажеш");

        format(string115, sizeof(string115), "* Ти изпрати заявка за телепортрация до %s *", GetPlayerNickname(targetid));
        SendClientMessage(playerid, 0xFFFFFFFF, string115);
    }

    return 1;
}

CMD:slap(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /slap [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (PlayerInfo[playerid][pAdmin] < 5 && PlayerInfo[targetid][pAdmin] >= 5)
        return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да използваш тази команда върху администратор с 5-то ниво!");

    new Float:slx, Float:sly, Float:slz;
    GetPlayerPos(targetid, slx, sly, slz);
    SetPlayerPos(targetid, slx, sly, slz + 5.0);

    new string115[115];
    format(string115, sizeof(string115), "you have been slapped by %s", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0xE60000FF, string115);

    format(string115, sizeof(string115), "you slapped %s", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xE60000FF, string115);

    return 1;
}

CMD:makemanage(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5 && !IsPlayerAdmin(playerid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /makemanage [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    PlayerInfo[targetid][pManage] = 1;

    new string115[115];
    format(string115, sizeof(string115), "* Ти даде Manage Admin на %s.", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0x408080FF, string115);

    format(string115, sizeof(string115), "* %s те направи Manage Admin, честито. *", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0x408080FF, string115);

    format(string115, sizeof(string115), "*** %s вече е Manage Admin, честито ***", GetPlayerNickname(targetid));
    SendClientMessageToAll(0xF97804FF, string115);

    return 1;
}

CMD:makeevent(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5 && !IsPlayerAdmin(playerid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /makeevent [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    PlayerInfo[targetid][pEvent] = 1;

    new string115[115];
    format(string115, sizeof(string115), "* Ти даде Event Admin на %s.", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0x408080FF, string115);

    format(string115, sizeof(string115), "* %s те направи Event Admin, честито. *", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0x408080FF, string115);

    format(string115, sizeof(string115), "*** %s вече е Event Admin, честито ***", GetPlayerNickname(targetid));
    SendClientMessageToAll(0xF97804FF, string115);

    return 1;
}

CMD:removemanage(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5 && !IsPlayerAdmin(playerid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /removemanage [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (PlayerInfo[targetid][pManage] == 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч няма Manage права!");

    PlayerInfo[targetid][pManage] = 0;

    new string115[115];
    format(string115, sizeof(string115), "* Ти премахна Manage правата на %s.", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0x408080FF, string115);

    format(string115, sizeof(string115), "* %s премахна твоите Manage права. *", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0x408080FF, string115);

    return 1;
}

CMD:removeevent(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5 && !IsPlayerAdmin(playerid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /removeevent [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (PlayerInfo[targetid][pEvent] == 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч няма Event права!");

    PlayerInfo[targetid][pEvent] = 0;

    new string115[115];
    format(string115, sizeof(string115), "* Ти премахна Event правата на %s.", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0x408080FF, string115);

    format(string115, sizeof(string115), "* %s премахна твоите Event права. *", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0x408080FF, string115);

    return 1;
}

CMD:getadmin(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5 && !IsPlayerAdmin(playerid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /getadmin [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (PlayerInfo[targetid][pAdmin] == 0 && PlayerInfo[targetid][pTest] == 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч няма администраторски права!");

    // Reset admin powers
    if (fly[targetid] == 1)
    {
        fly[targetid] = 0;
        TogglePlayerControllable(targetid, true);
    }

    if (Jump[targetid] == 1)
    {
        Jump[targetid] = 0;
    }

    if (Speed[targetid] == 1)
    {
        Speed[targetid] = 0;
    }

    PlayerInfo[targetid][pTest] = 0;
    scripterMode[targetid] = 0;
    AntiFallOfBike[targetid] = 0; // Fixed: was playerid, should be targetid
    PlayerInfo[targetid][pAdmin] = 0;
    PlayerInfo[targetid][pManage] = 0;
    PlayerInfo[targetid][pEvent] = 0;
    PlayerInfo[targetid][pReadTA] = 0;
    PlayerInfo[targetid][pTimeMute] = 0;
    PlayerInfo[targetid][pTSpec] = 0;

    new string115[115];
    format(string115, sizeof(string115), "* Ти премахна админ правата на %s.", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0x408080FF, string115);

    format(string115, sizeof(string115), "* %s премахна твоите админ права. *", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0x408080FF, string115);

    format(string115, sizeof(string115), "*** %s вече не е част от администраторския екип ***", GetPlayerNickname(targetid));
    SendClientMessageToAll(0xF97804FF, string115);

    return 1;
}

CMD:aduty(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pTest] == 1)
    {
        if (PlayerInfo[playerid][pWanted] > 0 && PlayerInfo[playerid][pADuty] == 0 && PlayerInfo[playerid][pAdmin] < 5)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си издирван!");
            return 1;
        }
        new now = gettime();
        if (now - lastADuty[playerid] < 60 && PlayerInfo[playerid][pAdmin] < 5)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да използваш ADUTY само през 1 минута!");
        }
        if (PlayerInfo[playerid][pIFCDuty] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си IFC ON-DUTY!");
        if (PlayerInfo[playerid][pRobber] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си в обир!");
        if (PlayerInfo[playerid][pWanted] >= 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си заподозрян!");
        if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си в евент!");
        if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
        if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
        if (PlayerInfo[playerid][pADuty] == 0)
        {
            PlayerInfo[playerid][pADuty] = 1;
            UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, " ");
            format(VipText3D[playerid], 26, "");
            PlayerLabel[playerid] = CreateDynamic3DTextLabel(VipText3D[playerid], 0x800000FF, 0.0, 0.0, 0.0, 15.0, playerid, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 15.0);
            PlayerLabel[playerid] = CreateDynamic3DTextLabel("ADMIN ON-DUTY", 0xE60000FF, 0.0, 0.0, 0.0, 15.0, playerid, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 15.0);
            SendClientMessage(playerid, 0x40BF00FF, "Ти сега си On-Duty и трябва да помагаш на играчите!");
            SetPlayerColor(playerid, 0x7BFFFFFF);
            // ЗАПАЗВАМЕ ОРЪЖИЯТА
            for (new slot = 0; slot < 13; slot++)
            {
                new weapon, ammo;
                GetPlayerWeaponData(playerid, slot, weapon, ammo);
                SavedWeapon[playerid][slot] = weapon;
                SavedAmmo[playerid][slot] = ammo;
            }

            // махаме оръжията
            ResetPlayerWeapons(playerid);

            if (IsPlayerInAnyVehicle(playerid) == 1)
            {
                SendClientMessage(playerid, 0xFFFFFFFF, "* Твоят скин не се смени, защото не си пешеходец *");
            }
            else
            {
                SetPlayerSkin(playerid, PlayerInfo[playerid][pASkin]);
                adutyskinchanged[playerid] = 1;
            }
        }
        else
        {
            UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, " ");
            format(VipText3D[playerid], 26, "");
            PlayerLabel[playerid] = CreateDynamic3DTextLabel(VipText3D[playerid], 0x800000FF, 0.0, 0.0, 0.0, 15.0, playerid, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 15.0);
            adutyskinchanged[playerid] = 0;
            PlayerInfo[playerid][pADuty] = 0;
            SendClientMessage(playerid, 0xE60000FF, "Ти сега си Off-Duty и можеш да играеш спокойно!");
            SetPlayerHealth(playerid, 100);
            if (fly[playerid] == 1)
            {
                fly[playerid] = 0;
                TogglePlayerControllable(playerid, true);
            }
            if (Jump[playerid] == 1)
            {
                Jump[playerid] = 0;
            }
            if (Speed[playerid] == 1)
            {
                Speed[playerid] = 0;
            }
            spawnselectedskin[playerid] = spawnselectedskin2[playerid];
            SetPlayerArmour(playerid, 100);
            new level = PlayerInfo[playerid][pTeam];
            format(VipText3D[playerid], 26, "");
            UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, " ");
            PlayerLabel[playerid] = CreateDynamic3DTextLabel(VipText3D[playerid], 0x800000FF, 0.0, 0.0, 0.0, 15.0, playerid, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 15.0);
            RestartPlayerColor(playerid);
            if (PlayerInfo[playerid][pTeam] == FACTION_CIVILIAN)
            {
                SetPlayerColor(playerid, 0xFFFFFFFF);
                if (IsPlayerInAnyVehicle(playerid) == 1)
                {
                    SendClientMessage(playerid, 0xFFFFFFFF, "* Твоят скин не се смени, защото не си пешеходец *");
                }
                else
                {
                    RestartPlayerSkin(playerid);
                } //goto 2
            }
            if (IsPlayerInAnyVehicle(playerid) == 1)
            {
                return SendClientMessage(playerid, 0xFFFFFFFF, "* Твоят скин не се смени, защото не си пешеходец *");
            }
            else
            {
                RestartPlayerSkin(playerid);
            }
            RestartPlayerColor(playerid);
            SetPlayerHealth(playerid, 100);
            SetPlayerArmour(playerid, 100);
            lastADuty[playerid] = gettime();

            // ВРЪЩАМЕ ОРЪЖИЯТА
            for (new slot = 0; slot < 13; slot++)
            {
                if (SavedWeapon[playerid][slot] != 0 && SavedAmmo[playerid][slot] > 0)
                {
                    GivePlayerWeapon(playerid, SavedWeapon[playerid][slot], SavedAmmo[playerid][slot]);
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

CMD:makeadmin(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5 && !IsPlayerAdmin(playerid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid, level;
    if (sscanf(params, "ui", targetid, level))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /makeadmin [playerid] [option]");
        SendClientMessage(playerid, 0x00FF00FF, "Options: 1: Test, 2: Helper, 3: Administrator, 4: Moderator");
        SendClientMessage(playerid, 0x00FF00FF, "Options: 5: Grand Administrator, 6: Owner, 7: Scripter");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (level < 1 || level > 7)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /makeadmin [playerid] [option]");
        SendClientMessage(playerid, 0x00FF00FF, "Options: 1: Test, 2: Helper, 3: Administrator, 4: Moderator");
        SendClientMessage(playerid, 0x00FF00FF, "Options: 5: Grand Administrator, 6: Owner, 7: Scripter");
        return CMD_SUCCESS;
    }

    new string115[115];

    // Reset admin powers and modes
    if (PlayerInfo[playerid][pTest] == 1) PlayerInfo[playerid][pAHide] = 0;

    if (fly[targetid] == 1)
    {
        fly[targetid] = 0;
        TogglePlayerControllable(targetid, true);
    }

    if (Jump[targetid] == 1)
    {
        Jump[targetid] = 0;
    }

    if (Speed[targetid] == 1)
    {
        Speed[targetid] = 0;
    }

    // Set admin level based on option
    switch (level)
    {
        case 1: // Test Admin
        {
            PlayerInfo[targetid][pTest] = 1;
            PlayerInfo[targetid][pAdmin] = 0;
            scripterMode[targetid] = 0;
            AntiFallOfBike[playerid] = 0;
            PlayerInfo[targetid][pTSpec] = 1;

            format(string115, sizeof(string115), "* Ти направи %s тест админ.", GetPlayerNickname(targetid));
            SendClientMessage(playerid, 0x408080FF, string115);
            format(string115, sizeof(string115), "* %s те направи тест админ, поздравления. *", GetPlayerNickname(playerid));
            SendClientMessage(targetid, 0x408080FF, string115);
            format(string115, sizeof(string115), "*** %s вече е тест админ, Честито! ***", GetPlayerNickname(targetid));
            SendClientMessageToAll(0xF97804FF, string115);
        }
        case 2: // Helper (Level 1)
        {
            PlayerInfo[targetid][pTest] = 0;
            PlayerInfo[targetid][pAdmin] = 1;
            scripterMode[targetid] = 0;
            AntiFallOfBike[playerid] = 0;
            PlayerInfo[targetid][pTSpec] = 1;

            format(string115, sizeof(string115), "* Ти направи %s 1 админ левел. *", GetPlayerNickname(targetid));
            SendClientMessage(playerid, 0x408080FF, string115);
            format(string115, sizeof(string115), "* %s те направи 1 админ левел, поздравления. *", GetPlayerNickname(playerid));
            SendClientMessage(targetid, 0x408080FF, string115);
            format(string115, sizeof(string115), "*** %s вече е админ с 1 левел права, Честито! ***", GetPlayerNickname(targetid));
            SendClientMessageToAll(0xF97804FF, string115);
        }
        case 3: // Administrator (Level 2)
        {
            PlayerInfo[targetid][pTest] = 0;
            PlayerInfo[targetid][pAdmin] = 2;
            scripterMode[targetid] = 0;
            PlayerInfo[targetid][pTSpec] = 1;
            AntiFallOfBike[playerid] = 0;

            format(string115, sizeof(string115), "* Ти направи %s 2 админ левел. *", GetPlayerNickname(targetid));
            SendClientMessage(playerid, 0x408080FF, string115);
            format(string115, sizeof(string115), "* %s те направи 2 админ левел, поздравления. *", GetPlayerNickname(playerid));
            SendClientMessage(targetid, 0x408080FF, string115);
            format(string115, sizeof(string115), "*** %s вече е админ с 2 левел права, Честито! ***", GetPlayerNickname(targetid));
            SendClientMessageToAll(0xF97804FF, string115);
        }
        case 4: // Moderator (Level 3)
        {
            PlayerInfo[targetid][pTest] = 0;
            scripterMode[targetid] = 0;
            AntiFallOfBike[playerid] = 0;
            PlayerInfo[targetid][pAdmin] = 3;
            PlayerInfo[targetid][pTimeMute] = 1;
            PlayerInfo[targetid][pTimeJail] = 1;

            format(string115, sizeof(string115), "* Ти направи %s 3 админ левел. *", GetPlayerNickname(targetid));
            SendClientMessage(playerid, 0x408080FF, string115);
            format(string115, sizeof(string115), "* %s те направи 3 админ левел, поздравления. *", GetPlayerNickname(playerid));
            SendClientMessage(targetid, 0x408080FF, string115);
            format(string115, sizeof(string115), "*** %s вече е админ с 3 левел права, Честито! ***", GetPlayerNickname(targetid));
            SendClientMessageToAll(0xF97804FF, string115);
        }
        case 5: // Grand Administrator (Level 4)
        {
            PlayerInfo[targetid][pTest] = 0;
            scripterMode[targetid] = 0;
            PlayerInfo[targetid][pAdmin] = 4;
            PlayerInfo[targetid][pTimeMute] = 1;
            PlayerInfo[targetid][pTimeJail] = 1;

            format(string115, sizeof(string115), "* Ти направи %s 4 админ левел. *", GetPlayerNickname(targetid));
            SendClientMessage(playerid, 0x408080FF, string115);
            format(string115, sizeof(string115), "* %s те направи 4 админ левел, поздравления. *", GetPlayerNickname(playerid));
            SendClientMessage(targetid, 0x408080FF, string115);
            format(string115, sizeof(string115), "*** %s вече е админ с 4 левел права, Честито! ***", GetPlayerNickname(targetid));
            SendClientMessageToAll(0xF97804FF, string115);
        }
        case 6: // Owner (Level 5)
        {
            PlayerInfo[targetid][pTest] = 0;
            PlayerInfo[targetid][pAdmin] = 5;
            PlayerInfo[targetid][pTimeMute] = 1;
            PlayerInfo[targetid][pTimeJail] = 1;

            format(string115, sizeof(string115), "* Ти направи %s 5 админ левел. *", GetPlayerNickname(targetid));
            SendClientMessage(playerid, 0x408080FF, string115);
            format(string115, sizeof(string115), "* %s те направи 5 админ левел, поздравления. *", GetPlayerNickname(playerid));
            SendClientMessage(targetid, 0x408080FF, string115);
            format(string115, sizeof(string115), "*** %s вече е админ с 5 левел права, Честито! ***", GetPlayerNickname(targetid));
            SendClientMessageToAll(0xF97804FF, string115);
        }
        case 7: // Scripter (Level 6)
        {
            PlayerInfo[targetid][pTest] = 0;
            PlayerInfo[targetid][pAdmin] = 6;
            PlayerInfo[targetid][pTimeMute] = 1;
            PlayerInfo[targetid][pTimeJail] = 1;

            format(string115, sizeof(string115), "* Ти направи %s 5 админ левел. *", GetPlayerNickname(targetid));
            SendClientMessage(playerid, 0x408080FF, string115);
            format(string115, sizeof(string115), "* %s те направи 5 админ левел, поздравления. *", GetPlayerNickname(playerid));
            SendClientMessage(targetid, 0x408080FF, string115);
            format(string115, sizeof(string115), "*** %s вече е админ с 5 левел права, Честито! ***", GetPlayerNickname(targetid));
            SendClientMessageToAll(0xF97804FF, string115);
        }
    }

    // Set admin prefix
    if (PlayerInfo[targetid][pTest] == 1)
    {
        adminprefix[targetid] = "Test Admin";
    }
    else if (PlayerInfo[targetid][pAdmin] == 1)
    {
        adminprefix[targetid] = "Helper";
    }
    else if (PlayerInfo[targetid][pAdmin] == 2)
    {
        adminprefix[targetid] = "Administrator";
    }
    else if (PlayerInfo[targetid][pAdmin] == 3)
    {
        adminprefix[targetid] = "Moderator";
    }
    else if (PlayerInfo[targetid][pAdmin] == 4)
    {
        adminprefix[targetid] = "Grand Admin";
    }
    else if (PlayerInfo[targetid][pAdmin] == 5)
    {
        adminprefix[targetid] = "Owner";
    }
    else if (PlayerInfo[targetid][pAdmin] == 6)
    {
        adminprefix[targetid] = "Scripter";
    }

    return CMD_SUCCESS;
}

CMD:givekasa(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    new Float:amount;
    if (sscanf(params, "uf", targetid, amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /givekasa [playerid] [bgn]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (amount <= 0.0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Числото трябва да е по-голямо от 0!");
        return 1;
    }

    PlayerInfo[targetid][pKasaLV] += amount;

    new string115[115];
    format(string115, sizeof(string115), "КАСА: %s ти даде %.2f лв в твоята каса", GetPlayerNickname(playerid), amount);
    SendClientMessage(targetid, 0xE60000FF, string115);

    format(string115, sizeof(string115), "КАСА: Ти даде %.2f лв в касата на %s", amount, GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xE60000FF, string115);

    return 1;
}

CMD:getkasa(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    new Float:amount;
    if (sscanf(params, "uf", targetid, amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /getkasa [playerid] [bgn]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (amount <= 0.0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Числото трябва да е по-голямо от 0!");
        return 1;
    }

    if (PlayerInfo[targetid][pKasaLV] < amount)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Играчът няма достатъчно пари в касата!");
        return 1;
    }

    PlayerInfo[targetid][pKasaLV] -= amount;

    new string115[115];
    format(string115, sizeof(string115), "КАСА: %s ти взе %.2f лв от твоята каса", GetPlayerNickname(playerid), amount);
    SendClientMessage(targetid, 0xE60000FF, string115);

    format(string115, sizeof(string115), "КАСА: Ти взе %.2f лв от касата на %s", amount, GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xE60000FF, string115);

    return 1;
}

CMD:checkkasa(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /checkkasa [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    new string115[115];
    format(string115, sizeof(string115), "Касата на {FFFF00}%s {FFFFFF}съдържа {FF0000}%.2f {FFFFFF}лв !", GetPlayerNickname(targetid), PlayerInfo[targetid][pKasaLV]);
    SendClientMessage(playerid, 0xFFFFFFFF, string115);

    return 1;
}
CMD:readta(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 3)
    {
        if (PlayerInfo[playerid][pReadTA] == 1)
        {
            SendClientMessage(playerid, 0xE60000FF, "Ти сега няма да виждаш какво пишат в TEST ADMIN чата!");
            return PlayerInfo[playerid][pReadTA] = 0;
        }
        else
        {
            SendClientMessage(playerid, 0xE60000FF, "Ти сега ще виждаш какво пишат в TEST ADMIN чата!");
            PlayerInfo[playerid][pReadTA] = 1;
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:resetturfs(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    if (startturf == 1) return SendClientMessage(playerid, COLOR_GRAD1, "В момента има търф");
    SendClientMessageToAll(0xC800FFFF, "Всички територии бяха рестартирани.");
    for (new t = 18; t < MAX_TURFS; t++)
    {
        TurfInfo[t][TurfOwner] = 0;
        SaveTurf(t);
        for (new i; i < MAX_PLAYERS; i++)
        {
            GangZoneShowForPlayer(i, t, TeamInfo[0][tTCOLOR]);
        }
    }
    for (new i; i < MAX_TEAMS; i++)
    {
        TeamInfo[i][tTurfsCount] = 0;
        TeamInfo[0][tTurfsCount] = 300;
        SaveFaction(i);
    }
    return 1;
}

CMD:getleader(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш достъп до тази административна команда!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /getleader [ID на играч]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този играч, който сте въвели не в онлайн в момента");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pRank] < 6)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този играч не е лидер!");
        return CMD_SUCCESS;
    }

    PlayerInfo[targetid][pIPDDuty] = 0;
    PlayerInfo[targetid][pRank] = 1;
    PlayerInfo[targetid][pTeam] = 0;
    GivePlayerEP(targetid, 0);

    new formatMessage[256];
    format(formatMessage, sizeof(formatMessage), "%s премахна лидерството на %s", GetPlayerNickname(playerid), GetPlayerNickname(targetid));
    SendClientMessageToAll(COLOR_RTRIADS, formatMessage);

    SendClientMessage(targetid, COLOR_RTRIADS, "Твоето лидерство беше премахнато!");
    RestartPlayerColor(targetid);
    RestartPlayerSkin(targetid);
    LeaveGangPlayerAffect(targetid);

    return CMD_SUCCESS;
}

CMD:checkwarns(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /checkwarns [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    new stringbank[256];
    format(stringbank, sizeof(stringbank), "%s има - %d Warns", GetPlayerNickname(targetid), PlayerInfo[targetid][pWarns]);
    SendClientMessage(playerid, 0xFFFFFFFF, stringbank);

    return CMD_SUCCESS;
}

CMD:unmuteall(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 5)
    {
        format(string256, 256, "ADMIN: ALL PLAYERS were unmuted by %s", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x00E600FF, string256);
        for (new i; i < MAX_PLAYERS; i++)
        {
            PlayerInfo[i][pMuteReason] = 0;
            PlayerInfo[i][pMuted] = 0;
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:muteall(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 5)
    {
        format(string256, 256, "ADMIN: ALL PLAYERS were muted by %s", GetPlayerNickname(playerid));
        SendClientMessageToAll(0xE60000FF, string256);
        for (new i; i < MAX_PLAYERS; i++) PlayerInfo[i][pMuteReason] = 6;
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:mute(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pTest] != 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid, option;
    if (sscanf(params, "ui", targetid, option))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /mute [playerid] [option]");
        SendClientMessage(playerid, 0x00FF00FF, "Options: 1: Спам, 2: Псуване/Обиждане, 3: Спам/Псуване/Обиждане");
        SendClientMessage(playerid, 0x00FF00FF, "Options: 4: Оплакване във форума, 5: Грешно използване на лидерския чат");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (option < 1 || option > 5)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /mute [playerid] [option]");
        SendClientMessage(playerid, 0x00FF00FF, "Options: 1: Спам, 2: Псуване/Обиждане, 3: Спам/Псуване/Обиждане");
        SendClientMessage(playerid, 0x00FF00FF, "Options: 4: Оплакване във форума, 5: Грешно използване на лидерския чат");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pMuted] != 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч вече е заглушен!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pAdmin] >= 5 && PlayerInfo[playerid][pAdmin] < 5)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да заглушиш администратор с 5-то ниво!");
        return CMD_SUCCESS;
    }

    new string256[256];
    switch (option)
    {
        case 1: // Спам
        {
            PlayerInfo[targetid][pMuted] = 100 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was muted by %s for 100 minutes. [Reason: Спам]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            SendClientMessageToAll(0xE60000FF, string256);
            PlayerInfo[targetid][pMuteReason] = 3;
        }
        case 2: // Псуване/Обиждане
        {
            PlayerInfo[targetid][pMuted] = 200 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was muted by %s for 200 minutes. [Reason: Псуване/Обиждане]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            SendClientMessageToAll(0xE60000FF, string256);
            PlayerInfo[targetid][pMuteReason] = 1;
        }
        case 3: // Спам/Псуване/Обиждане
        {
            PlayerInfo[targetid][pMuted] = 300 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was muted by %s for 300 minutes. [Reason: Спам/Псуване/Обиждане]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            SendClientMessageToAll(0xE60000FF, string256);
            PlayerInfo[targetid][pMuteReason] = 4;
        }
        case 4: // Оплакване във форума
        {
            PlayerInfo[targetid][pMuted] = 350 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was muted by %s for 350 minutes. [Reason: Оплакване във форума]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            SendClientMessageToAll(0xE60000FF, string256);
            PlayerInfo[targetid][pMuteReason] = 2;
        }
        case 5: // Грешно използване на лидерския чат
        {
            PlayerInfo[targetid][pMuted] = 400 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was muted by %s for 400 minutes. [Reason: Грешно използване на лидерския чат]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            SendClientMessageToAll(0xE60000FF, string256);
            PlayerInfo[targetid][pMuteReason] = 5;
        }
    }

    return CMD_SUCCESS;
}

CMD:mute2(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, reason[30];
    if (sscanf(params, "us[30]", targetid, reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /mute2 [playerid] [reason]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (strlen(reason) < 1 || strlen(reason) > 30)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Причината трябва да бъде с до 30 символа!");

    PlayerInfo[targetid][pADMINMute] = 1;
    format(PlayerInfo[targetid][pReasonMute], 256, "%s", reason);

    new string256[256];
    format(string256, sizeof(string256), "ADMIN: %s was ADMIN muted by %s [Reason: %s]", GetPlayerNickname(targetid), GetPlayerNickname(playerid), reason);
    SendClientMessageToAll(0xE60000FF, string256);

    return 1;
}

CMD:unwarn(playerid, params[])
{
    if (PlayerInfo[playerid][pManage] != 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, reason[256];
    if (sscanf(params, "us[256]", targetid, reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /unwarn [playerid] [reason]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (strlen(reason) < 1)
        return SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /unwarn [playerid] [reason]");

    if (PlayerInfo[targetid][pWarns] == 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч няма предупреждения!");

    PlayerInfo[targetid][pWarns] -= 1;

    new string256[256];
    format(string256, sizeof(string256), "ADMIN: %s премахна едно от предупрежденията на %s [%d/5] [Reason: %s]", GetPlayerNickname(playerid), GetPlayerNickname(targetid), PlayerInfo[targetid][pWarns], reason);
    SendClientMessageToAll(0x00E600FF, string256);

    return 1;
}

CMD:unawarn(playerid, params[])
{
    if (PlayerInfo[playerid][pManage] != 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid, reason[256];
    if (sscanf(params, "us[256]", targetid, reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /unawarn [playerid] [reason]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pAdmin] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е администратор!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pAWarns] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч няма админ предупреждения!");
        return CMD_SUCCESS;
    }

    PlayerInfo[targetid][pAWarns] -= 1;

    new string256[256];
    format(string256, sizeof(string256), "ADMIN: %s премахна едно от админ предупрежденията на %s [%d/5] [Reason: %s]",
           GetPlayerNickname(playerid), GetPlayerNickname(targetid), PlayerInfo[targetid][pAWarns], reason);
    SendClientMessageToAll(0x00E600FF, string256);

    return CMD_SUCCESS;
}

CMD:awarn(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid, reason[256];
    if (sscanf(params, "us[256]", targetid, reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /awarn [playerid] [reason]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pAdmin] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е администратор!");
        return CMD_SUCCESS;
    }

    PlayerInfo[targetid][pAWarns] += 1;

    new string256[256];
    format(string256, sizeof(string256), "ADMIN: %s сложи админ предупреждение на %s [%d/5] [Reason: %s]",
           GetPlayerNickname(playerid), GetPlayerNickname(targetid), PlayerInfo[targetid][pAWarns], reason);
    SendClientMessageToAll(0xE60000FF, string256);

    // Check if player reached 5 admin warns
    if (PlayerInfo[targetid][pAWarns] >= 5)
    {
        new demoteMessage[256];
        format(demoteMessage, sizeof(demoteMessage), "ADMIN: %s събра 5 админ предупреждения и сега той остана без админ права!",
               GetPlayerNickname(targetid));
        SendClientMessageToAll(0xE60000FF, demoteMessage);

        // Remove all admin privileges
        PlayerInfo[targetid][pTest] = 0;
        scripterMode[targetid] = 0;
        AntiFallOfBike[targetid] = 0;
        PlayerInfo[targetid][pAdmin] = 0;
        PlayerInfo[targetid][pManage] = 0;
        PlayerInfo[targetid][pEvent] = 0;
        PlayerInfo[targetid][pReadTA] = 0;
        PlayerInfo[targetid][pTimeMute] = 0;
        PlayerInfo[targetid][pTSpec] = 0;
    }

    return CMD_SUCCESS;
}

CMD:nunwarn(playerid, params[])
{
    if (PlayerInfo[playerid][pManage] != 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new nickname[MAX_PLAYER_NAME], reason[32];
    if (sscanf(params, "s[24]s[32]", nickname, reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /nunwarn [nickname] [reason]");
        return CMD_SUCCESS;
    }

    if (strlen(nickname) < 1 || strlen(nickname) > 30)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Името трябва да бъде с до 30 символа!");
        return CMD_SUCCESS;
    }

    if (strlen(reason) < 1 || strlen(reason) > 30)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Причината трябва да бъде с до 30 символа!");
        return CMD_SUCCESS;
    }

    if (!IsNicknameInDB(nickname))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този nickname не съществува!");
        return CMD_SUCCESS;
    }

    // Check if player is online
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && strcmp(nickname, GetPlayerNickname(i), true) == 0)
        {
            if (PlayerInfo[i][pWarns] == 0)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Този играч няма предупреждения!");
                return CMD_SUCCESS;
            }

            PlayerInfo[i][pWarns] -= 1;

            new string256[256];
            format(string256, sizeof(string256), "ADMIN: %s премахна едно от предупрежденията на %s [%d/5] [Reason: %s]",
                   GetPlayerNickname(playerid), nickname, PlayerInfo[i][pWarns], reason);
            SendClientMessageToAll(0x00E600FF, string256);
            return CMD_SUCCESS;
        }
    }

    // Player is offline, update database
    new warns = GetUserValueInt(nickname, "warns");
    if (warns == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч няма предупреждения!");
        return CMD_SUCCESS;
    }

    warns -= 1;
    UpdatePlayerDatabaseINT("warns", warns, nickname);

    new string256[256];
    format(string256, sizeof(string256), "ADMIN: %s премахна едно от предупрежденията на %s [%d/5] [Reason: %s]",
           GetPlayerNickname(playerid), nickname, warns, reason);
    SendClientMessageToAll(0x00E600FF, string256);

    return CMD_SUCCESS;
}


CMD:warn(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, reason[256];
    if (sscanf(params, "us[256]", targetid, reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /warn [playerid] [reason]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (strlen(reason) < 1)
        return SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /warn [playerid] [reason]");

    if (PlayerInfo[playerid][pAdmin] < 5 && PlayerInfo[targetid][pAdmin] >= 5)
        return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да използваш тази команда върху администратор с 5-то ниво!");

    PlayerInfo[targetid][pWarns] += 1;

    new string256[256];
    format(string256, sizeof(string256), "ADMIN: %s сложи предупреждение на %s [%d/5] [Reason: %s]", GetPlayerNickname(playerid), GetPlayerNickname(targetid), PlayerInfo[targetid][pWarns], reason);
    SendClientMessageToAll(0xE60000FF, string256);

    if (PlayerInfo[targetid][pWarns] >= 5)
    {
        new kickMessage[256];
        format(kickMessage, sizeof(kickMessage), "ADMIN: %s събра 5 предупреждения и сега е забранено да се играе с неговия акаунт!", GetPlayerNickname(targetid));
        SendClientMessageToAll(0xE60000FF, kickMessage);
        PlayerInfo[targetid][pKick] = 1;
    }

    return 1;
}

CMD:acuff(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /acuff [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (acuffed[targetid] == 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч вече има сложени белезници на ръцете!");

    acuffed[targetid] = 1;
    SetPlayerAttachedObject(targetid, 1, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);
    SetPlayerSpecialAction(targetid, SPECIAL_ACTION_CUFFED);

    new string256[256];
    format(string256, sizeof(string256), "ADMIN: %s ти сложи белезници на ръцете.", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0xFFFFFFFF, string256);

    format(string256, sizeof(string256), "ADMIN: Ти сложи белезници на ръцете на %s.", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFFFFFF, string256);

    return 1;
}

CMD:auncuff(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /auncuff [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (acuffed[targetid] == 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч няма белезници на ръцете!");

    RemovePlayerAttachedObject(targetid, 1);
    acuffed[targetid] = 0;
    SetPlayerSpecialAction(targetid, SPECIAL_ACTION_NONE);

    new string256[256];
    format(string256, sizeof(string256), "ADMIN: %s премахна твоите белезници от ръцете.", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0xFFFFFFFF, string256);

    format(string256, sizeof(string256), "ADMIN: Ти премахна белезниците от ръцете на %s.", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFFFFFF, string256);

    return 1;
}

CMD:god(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 4)
    {
        if (PlayerInfo[playerid][pADuty] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си ADMIN ON-DUTY!");
            return 1;
        }
        if (godmode[playerid] == 0)
        {
            godmode[playerid] = 1;
            SetPlayerHealth(playerid, 99999);
            SetPlayerArmour(playerid, 99999);
            return SendClientMessage(playerid, 0x40BF00FF, "GODMODE: Tи активира безсмъртния режим.");
        }
        if (godmode[playerid] == 1)
        {
            godmode[playerid] = 0;
            SetPlayerHealth(playerid, 100);
            SetPlayerArmour(playerid, 100);
            SendClientMessage(playerid, 0xE60000FF, "GODMODE: Tи деактивира безсмъртния режим.");
        }
    }
    else SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    return 1;
}

CMD:tgoto(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /tgoto [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    new string256[256];
    if (PlayerInfo[targetid][pTGoto] == 0)
    {
        PlayerInfo[targetid][pTGoto] = 1;
        format(string256, sizeof(string256), "ADMIN: Ти позволи на %s да се телепортира до играчите.", GetPlayerNickname(targetid));
        SendClientMessage(playerid, 0xE60000FF, string256);
        format(string256, sizeof(string256), "ADMIN: %s ти позволи да се телепортираш до играчите.", GetPlayerNickname(playerid));
        SendClientMessage(targetid, 0xE60000FF, string256);
    }
    else
    {
        PlayerInfo[targetid][pTGoto] = 0;
        format(string256, sizeof(string256), "ADMIN: Ти забрани на %s да се телепортира до играчите.", GetPlayerNickname(targetid));
        SendClientMessage(playerid, 0xE60000FF, string256);
        format(string256, sizeof(string256), "ADMIN: %s ти забрани да се телепортираш до играчите.", GetPlayerNickname(playerid));
        SendClientMessage(targetid, 0xE60000FF, string256);
    }
    return 1;
}

CMD:tspec(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /tspec [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    new string256[256];
    if (PlayerInfo[targetid][pTSpec] == 0)
    {
        PlayerInfo[targetid][pTSpec] = 1;
        format(string256, sizeof(string256), "ADMIN: Ти позволи на %s да наблюдава играчите.", GetPlayerNickname(targetid));
        SendClientMessage(playerid, 0xE60000FF, string256);
        format(string256, sizeof(string256), "ADMIN: %s ти позволи да наблюдаваш играчите.", GetPlayerNickname(playerid));
        SendClientMessage(targetid, 0xE60000FF, string256);
    }
    else
    {
        PlayerInfo[targetid][pTSpec] = 0;
        format(string256, sizeof(string256), "ADMIN: Ти забрани на %s да наблюдава играчите.", GetPlayerNickname(targetid));
        SendClientMessage(playerid, 0xE60000FF, string256);
        format(string256, sizeof(string256), "ADMIN: %s ти забрани да наблюдаваш играчите.", GetPlayerNickname(playerid));
        SendClientMessage(targetid, 0xE60000FF, string256);
    }
    return 1;
}

CMD:timejail(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /timejail [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    new string256[256];
    if (PlayerInfo[targetid][pTimeJail] == 0)
    {
        PlayerInfo[targetid][pTimeJail] = 1;
        format(string256, sizeof(string256), "ADMIN: Ти позволи на %s да вкарва играчи в затвора за време.", GetPlayerNickname(targetid));
        SendClientMessage(playerid, 0xE60000FF, string256);
        format(string256, sizeof(string256), "ADMIN: %s ти позволи да вкарваш играчи в админ затвора за време.", GetPlayerNickname(playerid));
        SendClientMessage(targetid, 0xE60000FF, string256);
    }
    else
    {
        PlayerInfo[targetid][pTimeJail] = 0;
        format(string256, sizeof(string256), "ADMIN: Ти забрани на %s да вкарва играчи в затвора за време.", GetPlayerNickname(targetid));
        SendClientMessage(playerid, 0xE60000FF, string256);
        format(string256, sizeof(string256), "ADMIN: %s ти забрани да вкарваш играчи в админ затвора за време.", GetPlayerNickname(playerid));
        SendClientMessage(targetid, 0xE60000FF, string256);
    }
    return 1;
}

CMD:timemute(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /timemute [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    new string256[256];
    if (PlayerInfo[targetid][pTimeMute] == 0)
    {
        PlayerInfo[targetid][pTimeMute] = 1;
        format(string256, sizeof(string256), "ADMIN: Ти позволи на %s да заглушава за време.", GetPlayerNickname(targetid));
        SendClientMessage(playerid, 0xE60000FF, string256);
        format(string256, sizeof(string256), "ADMIN: %s ти позволи да заглушаваш за време.", GetPlayerNickname(playerid));
        SendClientMessage(targetid, 0xE60000FF, string256);
    }
    else
    {
        PlayerInfo[targetid][pTimeMute] = 0;
        format(string256, sizeof(string256), "ADMIN: Ти забрани на %s да заглушава за време.", GetPlayerNickname(targetid));
        SendClientMessage(playerid, 0xE60000FF, string256);
        format(string256, sizeof(string256), "ADMIN: %s ти забрани да заглушаваш за време.", GetPlayerNickname(playerid));
        SendClientMessage(targetid, 0xE60000FF, string256);
    }
    return 1;
}

CMD:unblock(playerid, params[])
{
    if (PlayerInfo[playerid][pManage] < 1)
        return SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");

    new nickname[32];
    if (sscanf(params, "s[32]", nickname))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /unblock [nickname]");
        return 1;
    }

    if (!IsNicknameInDB(nickname))
        return SendClientMessage(playerid, COLOR_GRAD1, "Този nickname не съществува!");

    if (GetUserValueInt(nickname, "block") == 0)
        return SendClientMessage(playerid, COLOR_GRAD1, "Този nickname не е блокиран!");

    UpdatePlayerDatabaseINT("block", 0, nickname);

    if (GetUserValueInt(nickname, "warns") == 5)
    {
        UpdatePlayerDatabaseINT("warns", 0, nickname);
    }

    new string115[115];
    format(string115, sizeof(string115), "ADMIN: %s was unblocked by %s", nickname, GetPlayerNickname(playerid));
    SendClientMessageToAll(0x00E600FF, string115);

    return 1;
}

CMD:unban(playerid, params[])
{
    if (PlayerInfo[playerid][pManage] < 1)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new nickname[MAX_PLAYER_NAME];
    if (sscanf(params, "s[24]", nickname))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /unban [nickname]");
        return CMD_SUCCESS;
    }

    new Cache:resultCache;
    new query[256];
    format(query, sizeof(query), "SELECT 1 FROM users WHERE player_username = '%s' LIMIT 1", nickname);
    resultCache = mysql_query(Database, query);

    if (cache_num_rows() > 0)
    {
        new string256[256], string115[115];

        format(string256, sizeof(string256), "unbanip %s", GetIP(nickname));
        SendRconCommand(string256);
        SendRconCommand("reloadbans");

        format(string115, sizeof(string115), "ADMIN: [%d:%d:%d] %s was unbanned by %s", hours, minutes, seconds, nickname, GetPlayerNickname(playerid));
        SendClientMessageToAll(0x00E600FF, string115);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този nickname не съществува!");
    }

    cache_delete(resultCache);
    return CMD_SUCCESS;
}

CMD:fwarn(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] != 6)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /fwarn [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pTeam] != PlayerInfo[targetid][pTeam])
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е от твоята банда/мафия!");
        return CMD_SUCCESS;
    }

    new string256[256];

    if (PlayerInfo[targetid][pFWarns] < 4)
    {
        PlayerInfo[targetid][pFWarns] += 1;
        format(string256, sizeof(string256), "[FACTION CHAT] %s was FACTION warned by %s [%d/5]", GetPlayerNickname(targetid), GetPlayerNickname(playerid), PlayerInfo[targetid][pFWarns]);
    }
    else
    {
        PlayerInfo[targetid][pFWarns] += 1;
        format(string256, sizeof(string256), "[FACTION CHAT] %s was FACTION warned by %s [5/5]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));

        // Kick player from faction for reaching 5 warns
        new kickMessage[256];
        format(kickMessage, sizeof(kickMessage), "[FACTION CHAT] %s е изгонен от банда/мафията заради 5 FACTION WARNS", GetPlayerNickname(targetid));

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
            {
                SendClientMessage(i, 0x33CCFFFF, string256);
                SendClientMessage(i, 0x33CCFFFF, kickMessage);
            }
        }

        LeaveGangPlayerAffect(targetid);
        return CMD_SUCCESS;
    }

    // Send warning message to faction members
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            SendClientMessage(i, 0x33CCFFFF, string256);
        }
    }

    return CMD_SUCCESS;
}

CMD:unfwarn(playerid, params[])
{
    if (PlayerInfo[playerid][pRank] != 6)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /unfwarn [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pTeam] != PlayerInfo[targetid][pTeam])
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е от твоята банда/мафия!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pFWarns] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч няма FACTION предупреждения!");
        return CMD_SUCCESS;
    }

    PlayerInfo[targetid][pFWarns] -= 1;

    new string256[256];
    format(string256, sizeof(string256), "[FACTION CHAT] %s was FACTION unwarned by %s", GetPlayerNickname(targetid), GetPlayerNickname(playerid));

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pTeam] == PlayerInfo[playerid][pTeam])
        {
            SendClientMessage(i, 0x33CCFFFF, string256);
        }
    }

    return CMD_SUCCESS;
}

CMD:veh(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new vehicleid, color1, color2;
    if (sscanf(params, "dI(0)I(0)", vehicleid, color1, color2))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /veh [vehid] [color1] [color2]");
        return 1;
    }

    if (vehicleid < 400 || vehicleid > 611)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Номерата на превозните средства трябва да са от 400 до 611!");
        return 1;
    }

    if (color1 < 0 || color1 > 255)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Номерата на цветовете трябва да са от 0 до 255!");
        return 1;
    }

    if (color2 < 0 || color2 > 255)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Номерата на цветовете трябва да са от 0 до 255!");
        return 1;
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    new carid = CreateVehicle(vehicleid, x, y, z, 0.0, color1, color2, -1);
    LinkVehicleToInterior(carid, GetPlayerInterior(playerid));
    SetVehicleVirtualWorld(carid, GetPlayerVirtualWorld(playerid));
    PutPlayerInVehicle(playerid, carid, 0);

    VehicleInfo[carid][vAdminVehSpawnedBy] = playerid;
    spawnedcars += 1;

    format(string, sizeof(string), "Vehicle ID %d spawned!", GetPlayerVehicleID(playerid));
    SendClientMessage(playerid, 0xFFFFFFFF, string);

    return 1;
}

CMD:nwarn(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new targetName[MAX_PLAYER_NAME], reason[32];
    if (sscanf(params, "s[24]s[32]", targetName, reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /nwarn [nickname] [reason]");
        return 1;
    }

    if (strlen(targetName) < 1 || strlen(targetName) > 30)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Името трябва да бъде с до 30 символа!");
        return 1;
    }

    if (strlen(reason) < 1 || strlen(reason) > 30)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Причината трябва да бъде с до 30 символа!");
        return 1;
    }

    if (!IsNicknameInDB(targetName))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този nickname не съществува!");
        return 1;
    }

    new warns = GetUserValueInt(targetName, "warns");
    if (warns >= 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч вече има 5 предупреждения!");
        return 1;
    }

    warns += 1;
    UpdatePlayerDatabaseINT("warns", warns, targetName);

    // Update online player if found
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && strcmp(targetName, GetPlayerNickname(i), true) == 0)
        {
            PlayerInfo[i][pWarns] = warns;
            break;
        }
    }

    format(string, sizeof(string), "ADMIN: %s сложи предупреждение на %s [%d/5] [Reason: %s]",
           GetPlayerNickname(playerid), targetName, warns, reason);
    SendClientMessageToAll(0xE60000FF, string);

    if (warns >= 5)
    {
        new banString[128];
        format(banString, sizeof(banString), "ADMIN: %s was blocked by THE SERVER [Reason: get fifth warning]", targetName);
        SendClientMessageToAll(0xE60000FF, banString);
    }

    return 1;
}

CMD:gotocor(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new Float:x, Float:y, Float:z;
    if (sscanf(params, "fff", x, y, z))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /gotocor [coor x] [coor y] [coor z]");
        return 1;
    }

    SetPlayerPos(playerid, x, y, z);

    new string256[256];
    format(string256, sizeof(string256), "* Вие се телепортирахте успешно до координати %.1f, %.1f, %.1f! *", x, y, z);
    SendClientMessage(playerid, 0xFFFF00FF, string256);

    return 1;
}

CMD:check(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /check [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pAdmin] < 5 && PlayerInfo[targetid][pAdmin] >= 5)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да използваш тази команда върху администратор с 5-то ниво!");
        return CMD_SUCCESS;
    }

    ShowPlayerStats(playerid, targetid);
    return CMD_SUCCESS;
}

CMD:gotobank(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new location[16];
    if (sscanf(params, "s[16]", location))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /gotobank [ls/lv]");
        return CMD_SUCCESS;
    }

    // Check if player can teleport
    if (PlayerInfo[playerid][pAFK] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в AFK режим и не можеш да се телепортираш!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в админ затвора и не можеш да се телепортираш!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pPJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в затвора и не можеш да се телепортираш!");
        return CMD_SUCCESS;
    }

    if (cmn1[playerid] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си CMN1!");
        return CMD_SUCCESS;
    }

    if (playerInDuel[playerid] == 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в дуел!");
        return CMD_SUCCESS;
    }

    if (inevent[playerid] == 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в евент!");
        return CMD_SUCCESS;
    }

    if (playerInDMON[playerid] == 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в DMON!");
        return CMD_SUCCESS;
    }

    if (playerInDeathmatch[playerid] == true)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
        return CMD_SUCCESS;
    }

    if (playerInStreetRace[playerid] == true)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
        return CMD_SUCCESS;
    }

    // Teleport to the specified bank location
    if (strcmp(location, "ls", true) == 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "* Ти се телепортира на Los Santos Bank! *");
        SetPlayerPos(playerid, 1490.2128, -1741.8989, 13.5469);
        SetPlayerFacingAngle(playerid, 359.2968);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 0);
        SetCameraBehindPlayer(playerid);
    }
    else if (strcmp(location, "lv", true) == 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "* Ти се телепортира на Las Venturas Bank! *");
        SetPlayerPos(playerid, 2417.1665, 1121.0125, 10.8203);
        SetPlayerFacingAngle(playerid, 264.4303);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 0);
        SetCameraBehindPlayer(playerid);
    }
    else
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /gotobank [ls/lv]");
        return CMD_SUCCESS;
    }

    return CMD_SUCCESS;
}

CMD:gotodesert(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    if (PlayerInfo[playerid][pAFK] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в AFK режим и не можеш да се телепортираш!");
        return 1;
    }
    if (PlayerInfo[playerid][pJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в админ затвора и не можеш да се телепортираш!");
        return 1;
    }
    if (PlayerInfo[playerid][pPJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в затвора и не можеш да се телепортираш!");
        return 1;
    }
    if (cmn1[playerid] > 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си CMN1!");
    }
    if (playerInDuel[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в дуел!");
    }
    if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в евент!");
    if (playerInDMON[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в DMON!");
    }
    if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    SendClientMessage(playerid, 0xFFFFFFFF, "* Ти се телепортира на Desert! *");
    SetPlayerPos(playerid, -295.2643, 1537.3564, 75.5625);
    SetPlayerFacingAngle(playerid, 176.6348);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetCameraBehindPlayer(playerid);
    return 1;
}

CMD:gotols(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    if (PlayerInfo[playerid][pADuty] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си на админ смяна за да ползваш тази команда!");

    if (PlayerInfo[playerid][pAFK] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в AFK режим и не можеш да се телепортираш!");
        return 1;
    }
    if (PlayerInfo[playerid][pJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в админ затвора и не можеш да се телепортираш!");
        return 1;
    }
    if (PlayerInfo[playerid][pPJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в затвора и не можеш да се телепортираш!");
        return 1;
    }
    if (cmn1[playerid] > 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си CMN1!");
    }
    if (playerInDuel[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в дуел!");
    }
    if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в евент!");
    if (playerInDMON[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в DMON!");
    }
    if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    SendClientMessage(playerid, 0xFFFFFFFF, "* Ти се телепортира на Los Santos! *");
    SetPlayerPos(playerid, 1537.7205, -1691.0510, 13.5469);
    SetPlayerFacingAngle(playerid, 90.5010);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetCameraBehindPlayer(playerid);
    return 1;
}
CMD:gotolv(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    if (PlayerInfo[playerid][pADuty] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си на админ смяна за да ползваш тази команда!");

    if (PlayerInfo[playerid][pAFK] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в AFK режим и не можеш да се телепортираш!");
        return 1;
    }
    if (PlayerInfo[playerid][pJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в админ затвора и не можеш да се телепортираш!");
        return 1;
    }
    if (PlayerInfo[playerid][pPJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в затвора и не можеш да се телепортираш!");
        return 1;
    }
    if (cmn1[playerid] > 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си CMN1!");
    }
    if (playerInDuel[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в дуел!");
    }
    if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в евент!");
    if (playerInDMON[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в DMON!");
    }
    if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    SendClientMessage(playerid, 0xFFFFFFFF, "* Ти се телепортира на Las Venturas Airport! *");
    SetPlayerPos(playerid, 1699.6941, 1434.8165, 10.6869);
    SetPlayerFacingAngle(playerid, 272.8860);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetCameraBehindPlayer(playerid);
    return 1;
}
CMD:gotosf(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    if (PlayerInfo[playerid][pADuty] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си на админ смяна за да ползваш тази команда!");

    if (PlayerInfo[playerid][pAFK] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в AFK режим и не можеш да се телепортираш!");
        return 1;
    }
    if (PlayerInfo[playerid][pJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в админ затвора и не можеш да се телепортираш!");
        return 1;
    }
    if (PlayerInfo[playerid][pPJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в затвора и не можеш да се телепортираш!");
        return 1;
    }
    if (cmn1[playerid] > 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си CMN1!");
    }
    if (playerInDuel[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в дуел!");
    }
    if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в евент!");
    if (playerInDMON[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в DMON!");
    }
    if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    SendClientMessage(playerid, 0xFFFFFFFF, "* Ти се телепортира на San Fierro Airport! *");
    SetPlayerPos(playerid, -1416.9932, -296.2564, 14.1484);
    SetPlayerFacingAngle(playerid, 132.8014);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetCameraBehindPlayer(playerid);
    return 1;
}
CMD:gotomc(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    if (PlayerInfo[playerid][pAFK] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в AFK режим и не можеш да се телепортираш!");
        return 1;
    }
    if (PlayerInfo[playerid][pJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в админ затвора и не можеш да се телепортираш!");
        return 1;
    }
    if (PlayerInfo[playerid][pPJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в затвора и не можеш да се телепортираш!");
        return 1;
    }
    if (cmn1[playerid] > 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си CMN1!");
    }
    if (playerInDuel[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в дуел!");
    }
    if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в евент!");
    if (playerInDMON[playerid] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в DMON!");
    }
    if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
    SendClientMessage(playerid, 0xFFFFFFFF, "* Ти се телепортира на Mountain Chiliad! *");
    SetPlayerPos(playerid, -2311.1885, -1641.3820, 483.7031);
    SetPlayerFacingAngle(playerid, 216.9667);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    SetCameraBehindPlayer(playerid);
    return 1;
}

CMD:aunmute(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pTest] != 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /aunmute [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pAMuted] > 0)
    {
        PlayerInfo[targetid][pAMuted] = 0;

        new string256[256];
        format(string256, sizeof(string256), "ADMIN: %s was unmuted in ADMIN CHAT by %s", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
        SendClientMessageToAll(0x00E600FF, string256);
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е заглушен в ADMIN чата!");
    }

    return CMD_SUCCESS;
}

CMD:amute(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid, minutesz, reason[256];
    if (sscanf(params, "uis[256]", targetid, minutesz, reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /amute [playerid] [minutes] [reason]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (minutesz < 1)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /amute [playerid] [minutes] [reason]");
        return CMD_SUCCESS;
    }

    if (isnull(reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /amute [playerid] [minutes] [reason]");
        return CMD_SUCCESS;
    }

    PlayerInfo[targetid][pAMuted] = minutesz * 60;

    new string256[256];
    format(string256, sizeof(string256), "ADMIN: %s was muted in ADMIN CHAT by %s for %d minutes. [Reason: %s]", GetPlayerNickname(targetid), GetPlayerNickname(playerid), minutesz, reason);
    SendClientMessageToAll(COLOR_RED, string256);

    return CMD_SUCCESS;
}

CMD:allevent(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    new stringevent[256];
    new events = 0;
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (PlayerInfo[i][pEvent] >= 1)
        {
            events += 1;
        }
    }
    format(stringevent, 256, "Онлайн хора с евент права(%d):", events);
    SendClientMessage(playerid, 0x33CCFFFF, stringevent);
    if (events > 0)
    {
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pEvent] >= 1)
            {
                format(stringevent, 256, "%s е с евент права", GetPlayerNickname(i));
                SendClientMessage(playerid, 0xFFFFFFFF, stringevent);
            }
        }
    }
    else
    {
        format(stringevent, 256, "Няма онлайн евент администратори в момента!");
        SendClientMessage(playerid, COLOR_RED, stringevent);
    }
    return 1;
}

CMD:ip(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 5)
    {
        new ip[35];
        GetPlayerIp(playerid, ip, 35);
        format(string115, 115, "Your IP: %s\n", ip);
        SendClientMessage(playerid, 0xFFFF00FF, string115);
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:isadmin(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /isadmin [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pAdmin] == 0 && PlayerInfo[targetid][pTest] == 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Този играч няма администраторски права в сървъра!");
    }
    else
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Този играч има администраторски права в сървъра!");
    }

    return CMD_SUCCESS;
}

CMD:isevent(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /isevent [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pEvent] == 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Този играч няма Event Admin права в сървъра!");
    }
    else
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Този играч има Event Admin права в сървъра!");
    }

    return CMD_SUCCESS;
}


CMD:cbccheck(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /cbccheck [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    new stringa[256];
    if (cbchat[targetid] > 0)
    {
        format(stringa, sizeof(stringa), "%s - %d CB CHAT", GetPlayerNickname(targetid), cbchat[targetid]);
        SendClientMessage(playerid, 0xFF9933FF, stringa);
    }
    else
    {
        SendClientMessage(playerid, COLOR_RED, "Този играч не е в CB CHAT!");
    }

    return CMD_SUCCESS;
}

CMD:islevel(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /islevel [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    new stringa[256];
    format(stringa, sizeof(stringa), "%s - %d Level", GetPlayerNickname(targetid), PlayerInfo[targetid][pLevel]);
    SendClientMessage(playerid, 0xFFFFFFFF, stringa);

    return CMD_SUCCESS;
}
CMD:ismanage(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /ismanage [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pManage] == 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Този играч няма Manage Admin права в сървъра!");
    }
    else
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Този играч има Manage Admin права в сървъра!");
    }

    return CMD_SUCCESS;
}

CMD:isvip(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /isvip [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pVip] == 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Този играч няма VIP в сървъра!");
    }
    else
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Този играч има VIP в сървъра!");
    }

    return CMD_SUCCESS;
}

CMD:isleader(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /isleader [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pRank] >= 6)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Този играч има лидер в сървъра!");
    }
    else
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Този играч няма лидер в сървъра!");
    }

    return CMD_SUCCESS;
}

CMD:ismuted(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /ismuted [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pMuted] == 0 && PlayerInfo[targetid][pADMINMute] == 0)
    {
        SendClientMessage(playerid, 0xE60000FF, "Този играч не е заглушен!");
        return CMD_SUCCESS;
    }

    new string256[256];

    if (PlayerInfo[targetid][pADMINMute] == 1)
    {
        format(string256, sizeof(string256), "Този играч е заглушен за винаги с причина - %s!", PlayerInfo[targetid][pReasonMute]);
        SendClientMessage(playerid, 0xE60000FF, string256);
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pMuted] > 0)
    {
        new mutereason[46];
        switch (PlayerInfo[targetid][pMuteReason])
        {
            case 1: mutereason = "Спам";
            case 2: mutereason = "Псуване/Обиждане";
            case 3: mutereason = "Спам/Псуване/Обиждане";
            case 4: mutereason = "Оплакване във форума";
            case 5: mutereason = "Грешно използване на лидерския чат";
            case 6: mutereason = "Mute all";
            default:
                mutereason = "Неизвестна причина";
        }

        format(string256, sizeof(string256), "Този играч е заглушен и причината е - %s!", mutereason);
        SendClientMessage(playerid, 0xE60000FF, string256);
    }

    return CMD_SUCCESS;
}

CMD:asay(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new message[128];
    if (sscanf(params, "s[128]", message))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /asay [text]");
        return 1;
    }

    new adminMessage[256];
    format(adminMessage, sizeof(adminMessage), "Admin %s: %s", GetPlayerNickname(playerid), message);
    SendClientMessageToAll(0xFF33FFFF, adminMessage);

    return 1;
}

CMD:a(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    if (PlayerInfo[playerid][pAMuted] != 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си заглушен във ADMIN CHAT!");
        return 1;
    }

    if (PlayerInfo[playerid][pAHide] == 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си забранил да виждаш своя ADMIN CHAT!");
        return 1;
    }

    new message[128];
    if (sscanf(params, "s[128]", message))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: (/a)dminchat [text]");
        return 1;
    }

    new adminMessage[256];
    format(adminMessage, sizeof(adminMessage), "%s %s(%d): %s",
           adminprefix[playerid], GetPlayerNickname(playerid), playerid, message);

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAHide] == 0)
        {
            SendClientMessage(i, 0xE60000FF, adminMessage);
        }
    }

    return 1;
}
CMD:adminchat(playerid, params[]) return cmd_a(playerid, params);

CMD:setskin(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid, skinid;
    if (sscanf(params, "ui", targetid, skinid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /setskin [playerid] [skin id]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (skinid < 0 || skinid > 311) // SA-MP skin IDs range from 0 to 311
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Невалиден skin ID! Трябва да е между 0 и 311.");
        return CMD_SUCCESS;
    }

    // Notify online admins
    new string115[115];
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAHide] == 0)
        {
            format(string115, sizeof(string115), "* %s смени ID Skin на %s *", GetPlayerNickname(playerid), GetPlayerNickname(targetid));
            SendClientMessage(i, 0xFFFFFFFF, string115);
        }
    }

    // Notify the target player
    format(string115, sizeof(string115), "* %s смени твоя ID Skin на %d *", GetPlayerNickname(playerid), skinid);
    SendClientMessage(targetid, 0xFFFF00FF, string115);

    // Set the player's skin
    SetPlayerSkin(targetid, skinid);

    return CMD_SUCCESS;
}

CMD:givegun(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid, weaponid, ammo;
    if (sscanf(params, "uii", targetid, weaponid, ammo))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /givegun [playerid] [weaponid] [ammo]");
        SendClientMessage(playerid, 0x33AA33FF, "____________________________________________");
        SendClientMessage(playerid, 0xBFC0C2FF, "1: Brass Knuckles 2: Golf Club 3: Nite Stick 4: Knife 5: Baseball Bat 6: Shovel 7: Pool Cue 8: Katana 9: Chainsaw");
        SendClientMessage(playerid, 0xBFC0C2FF, "10: Purple Dildo 11: Small White Vibrator 12: Large White Vibrator 13: Silver Vibrator 14: Flowers 15: Cane 16: Frag Grenade");
        SendClientMessage(playerid, 0xBFC0C2FF, "17: Tear Gas 18: Molotov Cocktail 19: Vehicle Missile 20: Hydra Flare 21: Jetpack 22: 9mm 23: Silenced 9mm 24: Desert Eagle");
        SendClientMessage(playerid, 0xBFC0C2FF, "25: Shotgun 26: Sawnoff Shotgun 27: Combat Shotgun 28: Micro SMG (Mac 10) 29: SMG (MP5) 30: AK-47 31: M4 32: Tec-9 33: Country Rifle");
        SendClientMessage(playerid, 0xBFC0C2FF, "34: Sniper Rifle 35: Rocket Launcher 36: HS Rocket Launcher 37: Flamethrower 38: Minigun 39: Satchel Charge 40: Detonator");
        SendClientMessage(playerid, 0xBFC0C2FF, "41: Spraycan 42: Fire Extinguisher 43: Camera 44: Nightvision Goggles 45: Infared Vision 46: Parachute");
        SendClientMessage(playerid, 0x33AA33FF, "____________________________________________");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (weaponid < 1 || weaponid > 46)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Невалидно ID на оръжие! Трябва да бъде между 1 и 46.");
        return CMD_SUCCESS;
    }

    if (ammo < 1 || ammo > 10000)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Количеството амуниции трябва да бъде между 1 и 10000!");
        return CMD_SUCCESS;
    }

    new weaponname[32];
    GetWeaponName(weaponid, weaponname, sizeof(weaponname));

    // Handle jetpack separately
    if (weaponid == 21)
    {
        SetPlayerArmedWeapon(targetid, 0);
        SetPlayerSpecialAction(targetid, SPECIAL_ACTION_USEJETPACK);
        SetPlayerArmedWeapon(targetid, 0);
    }
    else
    {
        GivePlayerWeapon(targetid, weaponid, ammo);
    }

    // Notify the target player
    new string115[115];
    format(string115, sizeof(string115), "* %s ти даде оръжие %s *", GetPlayerNickname(playerid), weaponname);
    SendClientMessage(targetid, 0xFFFF00FF, string115);

    // Notify online admins
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAHide] == 0)
        {
            format(string115, sizeof(string115), "Gun: %s даде оръжие %s на %s!", GetPlayerNickname(playerid), weaponname, GetPlayerNickname(targetid));
            SendClientMessage(i, 0xE60000FF, string115);
        }
    }

    return CMD_SUCCESS;
}

CMD:sethp(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid, health;
    if (sscanf(params, "ui", targetid, health))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /sethp [playerid] [health]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (health < 0 || health > 100)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Здравето трябва да бъде между 0 и 100!");
        return CMD_SUCCESS;
    }

    // Notify the target player
    new string115[115];
    format(string115, sizeof(string115), "* %s промени твоя живот на %d *", GetPlayerNickname(playerid), health);
    SendClientMessage(targetid, 0xFFFF00FF, string115);

    // Notify online admins
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAHide] == 0)
        {
            format(string115, sizeof(string115), "Health: %s сложи %d Health на %s", GetPlayerNickname(playerid), health, GetPlayerNickname(targetid));
            SendClientMessage(i, 0xE60000FF, string115);
        }
    }

    SetPlayerHealth(targetid, float(health));
    return CMD_SUCCESS;
}

CMD:clearchat(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] > 2)
    {
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        SendClientMessageToAll(0xFFFFFFFF, " ");
        format(string115, 115, "ADMIN: Чатът на сървъра беше изтрит от %s", GetPlayerNickname(playerid));
        SendClientMessageToAll(0xFFFFFFFF, string115);
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:setarmour(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid, armour;
    if (sscanf(params, "ui", targetid, armour))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /setarmour [playerid] [armour]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (armour < 0 || armour > 100)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Бронята трябва да бъде между 0 и 100!");
        return CMD_SUCCESS;
    }

    // Notify the target player
    new string115[115];
    format(string115, sizeof(string115), "* %s промени твоя жилетка на %d *", GetPlayerNickname(playerid), armour);
    SendClientMessage(targetid, 0xFFFF00FF, string115);

    // Notify online admins
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAHide] == 0)
        {
            format(string115, sizeof(string115), "Armour: %s сложи %d Armour на %s", GetPlayerNickname(playerid), armour, GetPlayerNickname(targetid));
            SendClientMessage(i, 0xE60000FF, string115);
        }
    }

    SetPlayerArmour(targetid, float(armour));
    return CMD_SUCCESS;
}

CMD:setworld(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid, worldid;
    if (sscanf(params, "ui", targetid, worldid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /setworld [playerid] [virtualworld id]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (worldid < 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Virtual World ID трябва да бъде положително число!");
        return CMD_SUCCESS;
    }

    SetPlayerVirtualWorld(targetid, worldid);

    // Notify both players
    new string115[115];
    format(string115, sizeof(string115), "* Ти смени ID VirtualWorld на %s *", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFFFFFF, string115);

    format(string115, sizeof(string115), "* %s смени твоя ID VirtualWorld на %d *", GetPlayerNickname(playerid), worldid);
    SendClientMessage(targetid, 0xFFFF00FF, string115);

    return CMD_SUCCESS;
}

CMD:int(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new interiorid;
    if (sscanf(params, "i", interiorid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /int [interiorid]");
        return CMD_SUCCESS;
    }

    if (interiorid < 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Interior ID трябва да бъде положително число!");
        return CMD_SUCCESS;
    }

    // Set interior for all players
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            SetPlayerInterior(i, interiorid);
        }
    }

    // Notify all players
    new string256[256];
    format(string256, sizeof(string256), "* %s смени ID Interior на всички в сървъра на %d *", GetPlayerNickname(playerid), interiorid);
    SendClientMessageToAll(0xFFFF00FF, string256);

    return CMD_SUCCESS;
}

CMD:setint(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid, interiorid;
    if (sscanf(params, "ui", targetid, interiorid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /setint [playerid] [interiorid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (interiorid < 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Interior ID трябва да бъде положително число!");
        return CMD_SUCCESS;
    }

    SetPlayerInterior(targetid, interiorid);

    // Notify both players
    format(string, sizeof(string), "* Ти смени ID Interior на %s *", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFFFFFF, string);

    format(string, sizeof(string), "* %s смени твоя ID Interior на %d *", GetPlayerNickname(playerid), interiorid);
    SendClientMessage(targetid, COLOR_YELLOW, string);

    return CMD_SUCCESS;
}

CMD:crl(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    if (robberyMembers == 0)
    {
        SendClientMessage(playerid, COLOR_RED, "Няма онлайн играч лидер на обир в момента!");
    }
    else
    {
        for (new i; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pRobberLead] == 1)
            {
                format(string256, 256, "%s (ID: %d) е лидер на обира", GetPlayerNickname(i), i);
                SendClientMessage(playerid, 0x40BF00FF, string256);
            }
        }
    }
    return 1;
}
CMD:cmb(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    if (isMoneyBoxGet == false)
    {
        SendClientMessage(playerid, COLOR_RED, "Няма онлайн играч с куфара в момента!");
    }
    else
    {
        format(string256, 256, "%s (ID: %d) е играчът с куфара", GetPlayerNickname(whoHaveMoneyBox));
        SendClientMessage(playerid, 0x40BF00FF, string256);
    }
    return 1;
}
CMD:acuffed(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    new cuffedusers;
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (acuffed[i] >= 1)
        {
            cuffedusers += 1;
        }
    }
    format(string256, 256, "Онлайн играчи с белезници(%d):", cuffedusers);
    SendClientMessage(playerid, 0x40BF00FF, string256);
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (acuffed[i] == 1)
        {
            format(string256, 256, "%s", GetPlayerNickname(i));
            SendClientMessage(playerid, 0xFFB366FF, string256);
        }
    }
    if (cuffedusers == 0)
    {
        format(string256, 256, "Няма онлайн играчи с белезници в момента!");
        SendClientMessage(playerid, 0xFFB366FF, string256);
    }
    return 1;
}

CMD:gotomark(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] > 2)
    {
        if (marked[playerid] != 1)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си маркирал позиция!");
            return 1;
        }
        if (cmn1[playerid] > 0)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си CMN1!");
        }
        if (playerInDuel[playerid] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в дуел!");
        }
        if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си в евент!");
        if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в евент!");
        if (playerInDeathmatch[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
        if (playerInStreetRace[playerid] == true) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента не можеш да използваш тази команда!");
        if (playerInDMON[playerid] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се телепортираш, докато си в DMON!");
        }
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAHide] == 0)
            {
                format(string115, 115, "Mark: %s се телепортира до маркираната си позиция!", GetPlayerNickname(playerid));
                SendClientMessage(i, 0xE60000FF, string115);
            }
        }
        SetPlayerInterior(playerid, AINT[playerid]);
        SetPlayerVirtualWorld(playerid, AVW[playerid]);
        if (GetPlayerState(playerid) == 2)
        {
            SetVehicleVirtualWorld(GetPlayerVehicleID(playerid), AVW[playerid]);
            LinkVehicleToInterior(GetPlayerVehicleID(playerid), AINT[playerid]);
            SetVehiclePos(GetPlayerVehicleID(playerid), AX[playerid], AY[playerid], AZ[playerid]);
            SetVehicleZAngle(GetPlayerVehicleID(playerid), AZA[playerid]);
        }
        else
        {
            SetPlayerPos(playerid, AX[playerid], AY[playerid], AZ[playerid]);
            SetPlayerFacingAngle(playerid, AZA[playerid]);
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:mark(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] > 2)
    {
        if (GetPlayerState(playerid) == 2)
        {
            GetVehiclePos(GetPlayerVehicleID(playerid), AX[playerid], AY[playerid], AZ[playerid]);
            GetVehicleZAngle(playerid, AZA[playerid]);
        }
        else
        {
            GetPlayerFacingAngle(playerid, AZA[playerid]);
            GetPlayerPos(playerid, AX[playerid], AY[playerid], AZ[playerid]);
        }
        AINT[playerid] = GetPlayerInterior(playerid);
        AVW[playerid] = GetPlayerVirtualWorld(playerid);
        SendClientMessage(playerid, 0xFFFFFFFF, "* Позицията е запазена *");
        marked[playerid] = 1;
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAHide] == 0)
            {
                format(string115, 115, "Mark: %s си маркира позиция!", GetPlayerNickname(playerid));
                SendClientMessage(i, 0xE60000FF, string115);
            }
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:adutyskin(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] > 0)
    {
        if (IsPlayerInAnyVehicle(playerid) == 1 && PlayerInfo[playerid][pADuty] == 1)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си пешеходец за да си смениш скина!");
            return 1;
        }
        DestroySelectionMenu(playerid);
        SetPVarInt(playerid, "skinc_active", 1);
        CreateSelectionMenu(playerid);
        SelectTextDraw(playerid, 0xACCBF1FF);
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:afon(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    if (AntiFallOfBike[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече си пуснал Anti fall of bike!");
    AntiFallOfBike[playerid] = 1;
    GameTextForPlayer(playerid, "~w~Anti fall off bike is now ~g~on", 5000, 5);
    return 1;
}
CMD:afoff(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    if (AntiFallOfBike[playerid] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Anti fall of bike не е пуснат!");
    GameTextForPlayer(playerid, "~w~Anti fall off bike is now ~r~off", 5000, 5);
    AntiFallOfBike[playerid] = 0;
    return 1;
}
CMD:eventhelp(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        SendClientMessage(playerid, 0xFFFF00FF, "Event Admin команди:");
        SendClientMessage(playerid, 0x00FF00FF, "/startevent /startevent1 /ec /eenter /setvhpall /efight /givegunall /sethpall /setarmourall /eventint /startvote");
        SendClientMessage(playerid, 0x00FF00FF, "/endvote /endevent /endevent1 /endevent2 /stopevent /ename /dname /ejetpack /djetpack /setweatherall /settime");
        SendClientMessage(playerid, 0x00FF00FF, "/egiveep /eev /edv /ehealme /dhealme /setlimit /invisible /invisibleall");
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:togcb(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 3)
    {
        if (PlayerInfo[playerid][pTogCB] == 0)
        {
            SendClientMessage(playerid, 0xFF9933FF, "Ти вече ще виждаш всички CB Chanels!");
            PlayerInfo[playerid][pTogCB] = 1;
        }
        else
        {
            SendClientMessage(playerid, 0xFF9933FF, "Ти вече няма да виждаш всички CB Chanels!");
            PlayerInfo[playerid][pTogCB] = 0;
        }
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш достатачно права за да ползваш командата!");
    }
    return 1;
}
CMD:istogged(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш достатъчно права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /istogged [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    new textaa[32] = "", textaa2[32] = "", textaa3[32] = "", textaa4[32] = "";
    new notoggle = 1;

    // Check admin hide status
    if (PlayerInfo[targetid][pAHide] == 1)
    {
        if (PlayerInfo[targetid][pTest] == 0)
        {
            format(textaa, sizeof(textaa), "ADMIN ");
        }
        else
        {
            format(textaa, sizeof(textaa), "TEST ");
        }
        notoggle = 0;
    }

    // Check chat toggles
    if (togchat[targetid] == 1)
    {
        format(textaa2, sizeof(textaa2), "GLOBAL ");
        notoggle = 0;
    }

    if (PlayerInfo[targetid][pTogFaction] == 1)
    {
        format(textaa3, sizeof(textaa3), "FACTION ");
        notoggle = 0;
    }

    if (PlayerInfo[targetid][pTogLeader] == 1)
    {
        format(textaa4, sizeof(textaa4), "LEADER ");
        notoggle = 0;
    }

    new string2562[256];
    if (notoggle == 1)
    {
        format(string2562, sizeof(string2562), "%s не е скрил никой чат!", GetPlayerNickname(targetid));
        SendClientMessage(playerid, 0xFFFFFFFF, string2562);
    }
    else
    {
        format(string2562, sizeof(string2562), "%s - скрил чат %s%s%s%s",
               GetPlayerNickname(targetid), textaa, textaa2, textaa3, textaa4);
        SendClientMessage(playerid, 0xFFFFFFFF, string2562);
    }

    return CMD_SUCCESS;
}

CMD:mhelp(playerid, params[])
{
    if (PlayerInfo[playerid][pManage] != 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new string2230result[1500];
    strcat(string2230result, "{00FF00}---= Level Manage Admin Commands =---\n");
    strcat(string2230result, "{33CCCC}/unwarn - Махате предупреждение на даден играч\n");
    strcat(string2230result, "{33CCCC}/nunwarn - Махате WARN на играч който не е в сървъра\n");
    strcat(string2230result, "{33CCCC}/respawncars - Respawn колите\n");
    strcat(string2230result, "{33CCCC}/crespawncars - Прекратявате Respawn колите\n");
    strcat(string2230result, "{33CCCC}/unban - Махате BAN на даден играч\n");
    strcat(string2230result, "{33CCCC}/checkrescars - Проверявате кога е имало последно Respawn на колите\n");
    strcat(string2230result, "{33CCCC}/askrescars - Питате сървъра за Respawn на колите\n");
    strcat(string2230result, "{33CCCC}/caskrescars - Прекратяване на питането за Respawn на колете\n");
    strcat(string2230result, "{33CCCC}/checkaskres - Проверявате кога последно е имало питане за Respawn на колите\n");
    strcat(string2230result, "{33CCCC}/unblock - Премахвате block-а на даден играч");

    ShowPlayerDialog(playerid, 3500, DIALOG_STYLE_MSGBOX, "{FF0000}MANAGE АДМИН КОМАНДИ:", string2230result, "Изход", "");
    return CMD_SUCCESS;
}

CMD:startevent(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    if (startedevent > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Все още има евент!");
        return CMD_SUCCESS;
    }

    if (eventmembers > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Все още има играчи от стария евент!");
        return CMD_SUCCESS;
    }

    new eventname[256];
    if (sscanf(params, "s[256]", eventname))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /startevent [event name]");
        return CMD_SUCCESS;
    }

    // Set up event
    eventinterior = GetPlayerInterior(playerid);

    // Show game text to all players
    new gametext[256];
    format(gametext, sizeof(gametext), "~r~ %s ~n~ ~w~ TYPE: ~g~/joinevent ~n~ ~b~ NO AWARD!!!", eventname);

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            GameTextForPlayer(i, gametext, 5000, 3);
        }
    }

    // Set event variables
    SetPlayerVirtualWorld(playerid, 1);
    eventclosed = 0;
    eev = 1;
    startedevent = 1;
    eenter = 0;
    efight = 0;
    ejetpack = 0;
    dhealme = 1;
    etune = 1;
    efix = 1;
    enos = 1;
    ehyd = 1;
    eramp = 0;

    // Get event position
    GetPlayerPos(playerid, eventx, eventy, eventz);
    eventlimit = 1000;

    // Set player as organizer
    cbchat[playerid] = 1;
    PlayerInfo[playerid][pOrganisator] = 1;
    SendClientMessage(playerid, 0xFF9933FF, "CB Channel: Твоят CB Channel беше прехвърлен на 1.");

    // Announce event to all players
    new announcement[256];
    format(announcement, sizeof(announcement), "%s: {80FF00}Напишете {F2FF00}/joinevent{80FF00} за да се присъедините към евента.{FFFFFF}  БЕЗ НАГРАДА!", eventname);
    SendClientMessageToAll(0xFF0000FF, announcement);

    return CMD_SUCCESS;
}

CMD:ah(playerid, params[])
{
    new string2230[512];
    new string2230result[1500];
    if (PlayerInfo[playerid][pTest] == 0 && PlayerInfo[playerid][pAdmin] == 0)
    {
        new closeddialog = 3500;
        strcat(string2230result, "{B4B5B7}Нямаш права за да ползваш командата!\n");
        ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, "{FF0000}АДМИН КОМАНДИ:", string2230result, "Изход", "");
        return 1;
    }
    if (PlayerInfo[playerid][pTest] == 1)
    {
        strcat(string2230result, "{00FF00}---= Level Test Admin Commands =---\n");
        format(string2230, 512, "{FFFF00}/mute /muted /unmute /ta /kick");
        strcat(string2230result, string2230);
        new closeddialog = 3500;
        ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, "{FF0000}АДМИН КОМАНДИ:", string2230result, "Изход", "");
    }
    //other type - location - open
    if (PlayerInfo[playerid][pAdmin] == 1)
    {
        //			forothertype=1;
        strcat(string2230result, "{00FF00}---= Level 1 Admin Commands =---\n");
        format(string2230, 512, "{FFFF00}/mute /muted /unmute /specoff /kick\n\n");
        strcat(string2230result, string2230);
        new closeddialog = 3500;
        ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, "{FF0000}АДМИН КОМАНДИ:", string2230result, "Изход", "");
    }
    if (PlayerInfo[playerid][pAdmin] == 2)
    {
        //			forothertype=1;
        strcat(string2230result, "{00FF00}---= Level 1 Admin Commands =---\n");
        format(string2230, 512, "{FFFF00}/mute /muted /unmute /specoff /kick\n\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{00FF00}---= Level 2 Admin Commands =---\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{FFFF00}/mute /muted /ismuted /kick /ban /a /spec /specoff /jailed /unmute\n/slap /akill /aduty /adutyskin /togadmin /check /jail /unjail /isjailed\n\n");
        strcat(string2230result, string2230);
        new closeddialog = 3500;
        ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, "{FF0000}АДМИН КОМАНДИ:", string2230result, "Изход", "");
    }
    if (PlayerInfo[playerid][pAdmin] == 3)
    {
        //			forothertype=1;
        strcat(string2230result, "{00FF00}---= Level 1 Admin Commands =---\n");
        format(string2230, 512, "{FFFF00}/mute /muted /unmute /specoff /kick\n\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{00FF00}---= Level 2 Admin Commands =---\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{FFFF00}/mute /muted /ismuted /kick /ban /a /spec /specoff /jailed /unmute\n/slap /akill /aduty /adutyskin /togadmin /check /jail /unjail /isjailed\n\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{00FF00}---= Level 3 Admin Commands =---\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{FFFF00}/nban /mark /gotomark /setskin /setint /setworld /warn /gotodesert /readta /ta\n/sethp /setarmour /givegun /clearchat /gotomc /crl /cmb /ajail /veh /rban\n/gotols /gotolv /gotosf /amute /destroycar /destroycars /mute2 /gotobank\n/bizid /houseid /lastonline /gotohveh /checkbank /nwarn /togcb\n\n");
        strcat(string2230result, string2230);
        new closeddialog = 3500;
        ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, "{FF0000}АДМИН КОМАНДИ:", string2230result, "Изход", "");
    }
    if (PlayerInfo[playerid][pAdmin] == 4)
    {
        //			forothertype=1;
        strcat(string2230result, "{00FF00}---= Level 1 Admin Commands =---\n");
        format(string2230, 512, "{FFFF00}/mute /muted /unmute /specoff /kick\n\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{00FF00}---= Level 2 Admin Commands =---\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{FFFF00}/mute /muted /ismuted /kick /ban /a /spec /specoff /jailed /unmute\n/slap /akill /aduty /adutyskin /togadmin /check /jail /unjail /isjailed\n\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{00FF00}---= Level 3 Admin Commands =---\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{FFFF00}/nban /mark /gotomark /setskin /setint /setworld /warn /gotodesert /readta /ta\n/sethp /setarmour /givegun /clearchat /gotomc /crl /cmb /ajail /veh /rban\n/gotols /gotolv /gotosf /amute /destroycar /destroycars /mute2 /gotobank\n/bizid /houseid /lastonline /gotohveh /checkbank /block /togcb\n\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{00FF00}---= Level 4 Admin Commands =---\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{FFFF00}/startvote /endvote /nwarn /arefuelall /block /checkfuelcars /tspec /tgoto /timemute /timejail /istogged\n/cbccheck /fixveh /int /gotoveh /weather /arefuel /jump /speed /fly /isadmin /islevel /isevent\n/ismanage /isvip /isleader /allevent /aviptext /acuff /auncuff /acuffed /god /afon /afoff /respawncars\n/crespawncars /checkrescars /askrescars /caskrescars /checkaskers /checkwarns /ncheckwarns\n\n");
        strcat(string2230result, string2230);
        new closeddialog = 3500;
        ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, "{FF0000}АДМИН КОМАНДИ:", string2230result, "Изход", "");
    }
    if (PlayerInfo[playerid][pAdmin] >= 5)
    {
        strcat(string2230result, "{00FF00}---= Level 1 Admin Commands =---\n");
        format(string2230, 512, "{FFFF00}/mute /muted /unmute /specoff /kick\n\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{00FF00}---= Level 2 Admin Commands =---\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{FFFF00}/mute /muted /ismuted /kick /ban /a /spec /specoff /jailed /unmute\n/slap /akill /aduty /adutyskin /togadmin /check /jail /unjail /isjailed\n\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{00FF00}---= Level 3 Admin Commands =---\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{FFFF00}/nban /mark /gotomark /setskin /setint /setworld /warn /gotodesert /readta /ta\n/sethp /setarmour /givegun /clearchat /gotomc /crl /cmb /ajail /veh /rban\n/gotols /gotolv /gotosf /amute /destroycar /destroycars /mute2 /gotobank\n/bizid /houseid /lastonline /gotohveh /checkbank /togcb\n\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{00FF00}---= Level 4 Admin Commands =---\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{FFFF00}/startvote /nwarn /endvote /arefuelall /block /checkfuelcars /tspec /tgoto /timemute /timejail /istogged\n/cbccheck /fixveh /int /gotoveh /weather /arefuel /jump /speed /fly /isadmin /islevel /isevent\n/ismanage /isvip /isleader /allevent /aviptext /acuff /auncuff /acuffed /god /afon /afoff /respawncars\n/crespawncars /checkrescars /askrescars /caskrescars /checkaskers /checkwarns /ncheckwarns\n\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{00FF00}---= Level 5 Admin Commands =---\n");
        strcat(string2230result, string2230);
        format(string2230, 512, "{FFFF00}/makeadmin /makeevent /makeifc /getifc /ip /aka /makemanage /getadmin /makeleader /giveveh /getveh\n/aunmute /spawnpv /respawnv /makegleader /getleader /settimeall /givelevel /givems\n/givemsall /givees /giveesall /agiveep /giveepall /givecashall /givecash /gmx /removeevent /removemanage\n/setcash /setepskill /saveserver /freevip /etest /dtest /muteall /unmuteall /takemoney");
        strcat(string2230result, string2230);
        new closeddialog = 3500;
        ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, "{FF0000}АДМИН КОМАНДИ:", string2230result, "Изход", "");
    }
    return 1;
}
CMD:ahelp(playerid, params[]) return cmd_ah(playerid, params);

CMD:fixveh(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }
    if (IsPlayerInAnyVehicle(playerid))
    {
        SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
        RepairVehicle(GetPlayerVehicleID(playerid));
        PlayerPlaySound(playerid, 1133, 0.0, 0.0, 0.0);
        SendClientMessage(playerid, 0xFFFFFFFF, "* Вие поправихте вашето превозно средство *");
    }
    return 1;
}


CMD:ec(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
    if (eventActiveCount == 0)
    {
        format(string256, 256, "*** %s стартира брояча на евента, бъдете в готовност ***", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string256);
        GameTextForAll("~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~-~b~ 3 ~r~-", 1500, 3);
        eventActiveCount = 1;
        eventCount0 = 2;
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента има активен брояч!");
    }
    return 1;
}
CMD:eenter(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (eenter == 0)
        {
            eenter = 1;
            format(string, sizeof(string), "{FF0000}%s{80FF00} позволи натискането на F/ENTER в евента!", GetPlayerNickname(playerid));
            SendClientMessageToAll(0x80FF00FF, string);
        }
        else
        {
            eenter = 0;
            format(string, sizeof(string), "{FF0000}%s{80FF00} забрани натискането на F/ENTER в евента!", GetPlayerNickname(playerid));
            SendClientMessageToAll(0x80FF00FF, string);
        }
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:dname(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (ename == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Командите /nameon и /nameoff вече са забранени!");
        ename = 0;
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (inevent[i] == 1)
            {
                for (new i2 = 0; i2 < MAX_PLAYERS; i2++)
                {
                    ShowPlayerNameTagForPlayer(i2, i, 1);
                }
            }
        }
        format(string, sizeof(string), "{FF0000}%s{80FF00} забрани ползването на /nameon и /nameoff в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:etune(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (etune == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Командата /tune вече е позволена!");
        etune = 1;
        format(string, sizeof(string), "{FF0000}%s{80FF00} позволи ползването на /tune в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:ejetpack(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (ejetpack == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Командата /jetpack вече е позволена!");
        ejetpack = 1;
        format(string, sizeof(string), "{FF0000}%s{80FF00} позволи ползването на /jetpack в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:eev(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (eev == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Влизането в превозни средства вече е позволено!");
        eev = 1;
        format(string, sizeof(string), "{FF0000}%s{80FF00} позволи влизането в превозни средства в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:eflip(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (eflip == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ползването на /flip вече е позволено!");
        eflip = 1;
        format(string, sizeof(string), "{FF0000}%s{80FF00} позволи ползването на /flip в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:dtest(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 5)
    {
        if (scripterMode[playerid] == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента тест модът е изключен!");
        scripterMode[playerid] = 0;
        SendClientMessage(playerid, 0xFFFFFFFF, "Ти изключи тест модът!");
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:etest(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 5)
    {
        if (scripterMode[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента тест модът е включен!");
        scripterMode[playerid] = 1;
        SendClientMessage(playerid, 0xFFFFFFFF, "Ти включи тест модът!");
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:dflip(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (eflip == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ползването на /flip вече е забранено!");
        eflip = 0;
        format(string, sizeof(string), "{FF0000}%s{80FF00} забрани ползването на /flip в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:einvisible(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (einvisible == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ползването на /invisible вече е позволено!");
        einvisible = 1;
        format(string, sizeof(string), "{FF0000}%s{80FF00} позволи ползването на /invisible в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:dramp(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (eramp == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ползването на рампи вече е забранено!");
        eramp = 0;
        format(string, sizeof(string), "{FF0000}%s{80FF00} забрани пускането на рампи в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:eramp(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (eramp == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ползването на рампи вече е позволено!");
        eramp = 1;
        format(string, sizeof(string), "{FF0000}%s{80FF00} позволи пускането на рампи в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:ehyd(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (ehyd == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ползването на /hyd вече е позволено!");
        ehyd = 1;
        format(string, sizeof(string), "{FF0000}%s{80FF00} позволи ползването на /hyd в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:dhyd(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (ehyd == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ползването на /hyd вече е забранено!");
        ehyd = 0;
        format(string, sizeof(string), "{FF0000}%s{80FF00} забрани ползването на /hyd в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:enos(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (enos == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ползването на /nos вече е позволено!");
        enos = 1;
        format(string, sizeof(string), "{FF0000}%s{80FF00} позволи ползването на /nos в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:dnos(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (enos == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ползването на /nos вече е забранено!");
        enos = 0;
        format(string, sizeof(string), "{FF0000}%s{80FF00} забрани ползването на /nos в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:efix(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (efix == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ползването на /fix вече е позволено!");
        efix = 1;
        format(string, sizeof(string), "{FF0000}%s{80FF00} позволи ползването на /fix в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:dfix(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (efix == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ползването на /fix вече е забранено!");
        efix = 0;
        format(string, sizeof(string), "{FF0000}%s{80FF00} забрани ползването на /fix в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:ehealme(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (dhealme == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ползването на /healme вече е позволено!");
        dhealme = 1;
        format(string, sizeof(string), "{FF0000}%s{80FF00} позволи ползването на /healme в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:dhealme(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (dhealme == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ползването на /healme вече е забранено!");
        dhealme = 0;
        format(string, sizeof(string), "{FF0000}%s{80FF00} забрани ползването на /healme в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:edv(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (eev == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Влизането в превозни средства вече е забранено!");
        eev = 0;
        format(string, sizeof(string), "{FF0000}%s{80FF00} забрани влизането в превозни средства в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:djetpack(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (ejetpack == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Командата /jetpack вече е забранена!");
        ejetpack = 0;
        format(string, sizeof(string), "{FF0000}%s{80FF00} забрани ползването на /jetpack в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:ename(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (ename == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Командите /nameon и /nameoff вече са позволени!");
        ename = 1;
        format(string, sizeof(string), "{FF0000}%s{80FF00} позволи ползването на /nameon и /nameoff в евента!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0x80FF00FF, string);
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:efight(playerid, params[])
{
    if (PlayerInfo[playerid][pEvent] == 1)
    {
        if (startedevent == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");
        if (efight == 0)
        {
            efight = 1;
            format(string, sizeof(string), "{FF0000}%s{80FF00} позволи боя в евента!", GetPlayerNickname(playerid));
            SendClientMessageToAll(0x80FF00FF, string);
        }
        else
        {
            efight = 0;
            format(string, sizeof(string), "{FF0000}%s{80FF00} забрани боя в евента!", GetPlayerNickname(playerid));
            SendClientMessageToAll(0x80FF00FF, string);
        }
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:cnnn(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new type;
    new text[128];

    if (sscanf(params, "ds[128]", type, text))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /cnnn [type 1-4] [text]");
        return 1;
    }

    if (type == 2)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш id 2!");
        return 1;
    }

    if (type < 1 || type > 4)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Типът трябва да е от 1 до 4!");
        return 1;
    }

    new gameText[256];
    format(gameText, sizeof(gameText), "~w~%s", text);

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            GameTextForPlayer(i, gameText, 5000, type);
        }
    }

    return 1;
}

CMD:givecashall(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new amount;
    if (sscanf(params, "d", amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /givecashall [cash]");
        return 1;
    }

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            GivePlayerCash(i, amount);
        }
    }

    format(string, sizeof(string), "ADMIN: %s даде $%d на всички играчи в сървъра!", GetPlayerNickname(playerid), amount);
    SendClientMessageToAll(0xE60000FF, string);

    return 1;
}
CMD:gmx(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new minutes, reason[128];
    if (sscanf(params, "ds[128]", minutes, reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /gmx [minutes] [reason]");
        return 1;
    }

    if (minutes < 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Минутите трябва да са най-малко 1!");
        return 1;
    }

    if (minutes == 1)
        format(string, sizeof(string), "ADMIN: [ВАЖНО] Сървърът ще се рестартира след 1 минута [Причина: %s]", reason);
    else
        format(string, sizeof(string), "ADMIN: [ВАЖНО] Сървърът ще се рестартира след %d минути [Причина: %s]", minutes, reason);

    SendClientMessageToAll(COLOR_RED, string);
    serverrestarttimer = minutes * 60;

    for (new i; i < MAX_PLAYERS; i++)
    {
        TextDrawShowForPlayer(i, RESTART);
    }

    return 1;
}

CMD:giveepall(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new exp;
    if (sscanf(params, "d", exp))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /giveepall [EP]");
        return 1;
    }

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        GivePlayerEP(i, exp);
    }

    format(string, sizeof(string), "ADMIN: %s даде %d EP на всички играчи в сървъра!", GetPlayerNickname(playerid), exp);
    SendClientMessageToAll(0xE60000FF, string);

    return 1;
}

CMD:giveesall(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new exp;
    if (sscanf(params, "d", exp))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /giveesall [EP]");
        return 1;
    }

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        GivePlayerEPS(i, exp);
    }

    format(string, sizeof(string), "ADMIN: %s даде %d EP Skill на всички играчи в сървъра!", GetPlayerNickname(playerid), exp);
    SendClientMessageToAll(0xE60000FF, string);

    return 1;
}

CMD:givemsall(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new exp;
    if (sscanf(params, "d", exp))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /givemsall [EP]");
        return 1;
    }

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        GivePlayerMS(i, exp);
    }

    format(string, sizeof(string), "ADMIN: %s даде %d Money Skill на всички играчи в сървъра!", GetPlayerNickname(playerid), exp);
    SendClientMessageToAll(0xE60000FF, string);

    return 1;
}

CMD:givems(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid, amount;
    if (sscanf(params, "ui", targetid, amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /givems [playerid] [money skill]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (amount < 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Числото трябва да е по-голямо от 0!");
        return CMD_SUCCESS;
    }

    // Give money skill to player
    GivePlayerMS(targetid, amount);

    // Send notifications
    new string115[115];
    if (amount == 1)
    {
        format(string115, sizeof(string115), "* Ти даде %d Money Skill на %s *", amount, GetPlayerNickname(targetid));
        SendClientMessage(playerid, 0xFFFFFFFF, string115);

        format(string115, sizeof(string115), "* %s ти даде %d Money Skill *", GetPlayerNickname(playerid), amount);
        SendClientMessage(targetid, 0xFFFF00FF, string115);
    }
    else
    {
        format(string115, sizeof(string115), "* Ти даде %d Money Skills на %s *", amount, GetPlayerNickname(targetid));
        SendClientMessage(playerid, 0xFFFFFFFF, string115);

        format(string115, sizeof(string115), "* %s ти даде %d Money Skills *", GetPlayerNickname(playerid), amount);
        SendClientMessage(targetid, 0xFFFF00FF, string115);
    }

    return CMD_SUCCESS;
}

CMD:settimeall(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new hour;
    if (sscanf(params, "i", hour))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /settimeall [time]");
        return CMD_SUCCESS;
    }

    if (hour < 0 || hour > 23)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Часът трябва да бъде от 0 до 23!");
        return CMD_SUCCESS;
    }

    SetWorldTime(hour);

    new string256[256];
    format(string256, sizeof(string256), "ADMIN: Часът в сървъра беше сменен от %s на %d", GetPlayerNickname(playerid), hour);
    SendClientMessageToAll(0xE60000FF, string256);

    return CMD_SUCCESS;
}

CMD:caskrescars(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] > 3 || PlayerInfo[playerid][pManage] == 1)
    {
        if (respawnVehsVoteTimer == 0)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма гласуване!");
        }
        format(string256, 256, "ADMIN: %s отмени гласуването за RESPAWN на превозните средства!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0xE60000FF, string256);
        respawnVehsVoteTimer = 0;
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            PlayerInfo[i][pNone] = 0;
            PlayerInfo[i][pYes] = 0;
            PlayerInfo[i][pNo] = 0;
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:crespawncars(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] > 3 || PlayerInfo[playerid][pManage] == 1)
    {
        if (respawnVehsTimer == 0)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма пуснат брояч за RESPAWN CARS!");
        }
        format(string256, 256, "ADMIN: %s отмени RESPAWN на превозните средства!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0xE60000FF, string256);
        respawnVehsTimer = 0;
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:endvote(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] > 3 || PlayerInfo[playerid][pEvent] == 1)
    {
        if (voteTimer == 0)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма гласуване!");
        }
        format(string256, 256, "ADMIN: %s отмени гласуването, въпроса беше - %s", GetPlayerNickname(playerid), voteQuestion);
        SendClientMessageToAll(0xE60000FF, string256);
        voteTimer = 0;
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            PlayerInfo[i][pNone] = 0;
            PlayerInfo[i][pYes] = 0;
            PlayerInfo[i][pNo] = 0;
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:arefuel(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 481 &&
            GetVehicleModel(GetPlayerVehicleID(playerid)) == 509 &&
            GetVehicleModel(GetPlayerVehicleID(playerid)) == 510 &&
            GetVehicleModel(GetPlayerVehicleID(playerid)) == 481)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Това превозно средство не може да бъде заредено с бензин!");
    }
    if (GetPlayerVehicleID(playerid) == 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозно средство!");
    }
    if (vehfuel[GetPlayerVehicleID(playerid)] == 100)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Твоето превозно средство има 100 литра бензин!");
    }
    if (PlayerInfo[playerid][pWanted] >= 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да ползваш тази команда, докато си заподозрян!");
        return 1;
    }
    if (PlayerInfo[playerid][pPlayerRefuelTimer] > 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не са минали 6 минути от последното използване на командата!");
    }
    SendClientMessage(playerid, 0xFFFF00FF, "Ти добави 100 литра бензин на твоето превозно средство");
    vehfuel[GetPlayerVehicleID(playerid)] = 100;
    PlayerInfo[playerid][pPlayerRefuelTimer] = 6 * 60;
    return 1;
}
CMD:arefuelall(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    format(string256, 256, "REFUEL CARS: %s презареди всички превозни средства !", GetPlayerNickname(playerid));
    SendClientMessageToAll(0xE60000FF, string256);
    isMadeRefuel = 1;
    hhrefuel = hours;
    mmrefuel = minutes;
    ssrefuel = seconds;
    format(playerrefuel, 115, "%s", GetPlayerNickname(playerid));
    for (new cars = 0; cars < MAX_VEHICLES; cars++)
        vehfuel[cars] = 100;
    return 1;
}
CMD:checkfuelcars(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    if (isMadeRefuel == 0)
    {
        return SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Днес REFUEL CARS не е бил правен.");
    }
    format(string256, 256, "SERVER: Последният REFUEL CARS е направен от %s на %d.%d.%d г. в %d:%d:%d часа.", playerrefuel, day, month, year, hhrefuel, mmrefuel, ssrefuel);
    SendClientMessage(playerid, 0xFFFFFFFF, string256);
    return 1;
}
CMD:respawncars(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] > 3 || PlayerInfo[playerid][pManage] == 1)
    {
        format(string256, 256, "ADMIN: All vehicles will be respawned after 10 secounds by %s", GetPlayerNickname(playerid));
        SendClientMessageToAll(0xE60000FF, string256);
        respawnVehsTimer = 10;
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:askrescars(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] > 3 || PlayerInfo[playerid][pManage] == 1)
    {
        if (respawnVehsTimer != 0)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "В момента има очакване за Respawn Cars!");
        }
        if (respawnVehsVoteTimer != 0 || voteTimer != 0)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "В момента има гласуване!");
        }
        format(string256, 256, "ADMIN: %s стартира гласуване за RESPAWN на превозните средства!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0xE60000FF, string256);
        format(string256, 256, "VOTE RESPAWN CARS: Използвайте /vote за да гласувате, имате 15 секунди!", GetPlayerNickname(playerid));
        SendClientMessageToAll(0xE60000FF, string256);
        respawnVehsVoteTimer = 2 * 15;
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            PlayerInfo[i][pNone] = 0;
            PlayerInfo[i][pYes] = 0;
            PlayerInfo[i][pNo] = 0;
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:ta(playerid, params[])
{
    if (PlayerInfo[playerid][pTest] < 1 && PlayerInfo[playerid][pReadTA] != 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    if (PlayerInfo[playerid][pAMuted] != 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си заглушен във ADMIN CHAT!");
        return 1;
    }

    new message[128];
    if (sscanf(params, "s[128]", message))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /ta [text]");
        return 1;
    }

    new testAdminMessage[256];
    format(testAdminMessage, sizeof(testAdminMessage), "Test Admin %s(%d): %s", GetPlayerNickname(playerid), playerid, message);

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && (PlayerInfo[i][pTest] >= 1 || PlayerInfo[i][pReadTA] == 1))
        {
            SendClientMessage(i, 0xE60000FF, testAdminMessage);
        }
    }

    return 1;
}
CMD:startvote(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4 && PlayerInfo[playerid][pEvent] != 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new question[128];
    if (sscanf(params, "s[128]", question))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /startvote [question]");
        return 1;
    }

    if (voteTimer != 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента има гласуване!");
        return 1;
    }

    if (respawnVehsVoteTimer != 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "В момента има гласуване!");
        return 1;
    }

    // Announce the vote
    new voteAnnounce[256];
    format(voteAnnounce, sizeof(voteAnnounce), "ADMIN: %s стартира гласуване с въпрос - %s", GetPlayerNickname(playerid), question);
    SendClientMessageToAll(0xE60000FF, voteAnnounce);

    SendClientMessageToAll(0xE60000FF, "VOTE: Използвайте /poll за да гласувате, имате 30 секунди!");

    // Initialize vote
    voteTimer = 30; // Changed from 15 to 30 seconds as mentioned in the message
    format(voteQuestion, sizeof(voteQuestion), "%s", question);

    // Reset all player votes
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            PlayerInfo[i][pNone] = 0;
            PlayerInfo[i][pYes] = 0;
            PlayerInfo[i][pNo] = 0;
        }
    }

    return 1;
}
CMD:vote(playerid, params[])
{
    if (respawnVehsVoteTimer < 1)
    {
        format(string256, 256, "В момента няма гласуване!");
        SendClientMessage(playerid, 0xB4B5B7FF, string256);
        return 1;
    }
    if (PlayerInfo[playerid][pYes] == 1 || PlayerInfo[playerid][pNo] == 1)
    {
        format(string256, 256, "Ти вече си гласувал за RESPAWN CARS!");
        SendClientMessage(playerid, 0xB4B5B7FF, string256);
        return 1;
    }
    format(string256, 256, "{60FA00}Да бъдат ли RESPAWN-нати превозните средства ?", voteQuestion);
    ShowPlayerDialog(playerid, 11, DIALOG_STYLE_MSGBOX, "{60FA00}VOTЕ:", string256, "ДА", "НЕ");
    return 1;
}
CMD:destroycars(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] > 2)
    {
        if (spawnedcars > 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Всички спаунати превозни средства са унищожени!");
        }
        if (spawnedcars == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Няма спаунати превозни средства!");
            return 1;
        }
        for (new aveh = 0; aveh < MAX_VEHICLES; aveh++)
        {
            if (VehicleInfo[aveh][vAdminVehSpawnedBy] != -1)
            {
                spawnedcars = 0;
                DestroyVehicle(aveh);
            }
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:destroycar(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] > 2)
    {
        if (GetPlayerVehicleID(playerid) == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозно средство!");
            return 1;
        }
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти унищожи превозното средство!");
        if (VehicleInfo[GetPlayerVehicleID(playerid)][vAdminVehSpawnedBy] != -1)
        {
            spawnedcars -= 1;
        }
        DestroyVehicle(GetPlayerVehicleID(playerid));
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:weather(playerid, params[])
{
    if (!IsPlayerConnected(playerid)) return 0;

    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new weatherID;
    if (sscanf(params, "d", weatherID))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /weather [0-45]");
        return 1;
    }

    if (weatherID < 0 || weatherID > 45)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Времето трябва да бъде от 0 до 45!");
        return 1;
    }

    SetWeather(weatherID);

    format(string, sizeof(string), "ADMIN: Времето в сървъра беше сменено от %s на id: %d", GetPlayerNickname(playerid), weatherID);
    SendClientMessageToAll(0xE60000FF, string);

    return 1;
}

CMD:rnmute(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new targetName[MAX_PLAYER_NAME], reason[128], time = 2;
    if (sscanf(params, "s[24]s[128]d", targetName, reason, time))
    {
        if (sscanf(params, "s[24]s[128]", targetName, reason))
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /rnmute [nickname] [reason] [time]");
            return 1;
        }
    }

    if (!IsNicknameInDB(targetName))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този nickname не съществува!");
        return 1;
    }

    UpdatePlayerDatabaseINT("muted", time * 60, targetName);

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && strcmp(targetName, GetPlayerNickname(i), true) == 0)
        {
            PlayerInfo[i][pMuted] = time * 60;
            break;
        }
    }

    format(string, sizeof(string), "ADMIN: %s was R&N muted by %s for %d minutes [Reason: %s]", targetName, GetPlayerNickname(playerid), time, reason);
    SendClientMessageToAll(COLOR_RED, string);

    return 1;
}
CMD:unjail(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 2)
    {
        new targetid;
        if (sscanf(params, "u", targetid))
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /unjail [playerid]");
            return 1;
        }

        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
            return 1;
        }

        if (PlayerInfo[targetid][pJail] > 0)
        {
            PlayerInfo[targetid][pJail] = 0;
            SetPlayerHealth(targetid, 0);

            new string256[256];
            format(string256, sizeof(string256), "ADMIN: %s was unjailed by %s", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            SendClientMessageToAll(0x00E600FF, string256);
        }
        else
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е в админ затвора!");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:unmute(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pTest] == 1)
    {
        new targetid;
        if (sscanf(params, "u", targetid))
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /unmute [playerid]");
            return 1;
        }

        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
            return 1;
        }

        if (PlayerInfo[targetid][pMuted] > 0 || PlayerInfo[targetid][pADMINMute] == 1)
        {
            PlayerInfo[targetid][pMuted] = 0;
            PlayerInfo[targetid][pADMINMute] = 0;
            PlayerInfo[targetid][pLMuted] = 0;

            new string256[256];
            format(string256, sizeof(string256), "ADMIN: %s was unmuted by %s", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            SendClientMessageToAll(0x00E600FF, string256);
        }
        else
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Този играч не е заглушен!");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:muted(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 1 || PlayerInfo[playerid][pTest] == 1)
    {
        SendClientMessage(playerid, 0x40BF00FF, "Онлайн заглушени играчи:");
        new muted = 0;
        new string256[256];

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && (PlayerInfo[i][pMuted] > 0 || PlayerInfo[i][pADMINMute] == 1))
            {
                format(string256, sizeof(string256), "%s (ID:%d)", GetPlayerNickname(i), i);
                SendClientMessage(playerid, 0xFFFFFFFF, string256);
                muted = 1;
            }
        }

        if (muted == 0)
        {
            SendClientMessage(playerid, 0xE60000FF, "Няма онлайн заглушени играчи.");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:jailed(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 1)
    {
        SendClientMessage(playerid, 0x40BF00FF, "Онлайн играчи в затвора:");
        new jailed = 0;
        new string256[256];

        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (IsPlayerConnected(i) && PlayerInfo[i][pJail] > 0)
            {
                format(string256, sizeof(string256), "%s (ID:%d)", GetPlayerNickname(i), i);
                SendClientMessage(playerid, 0xFFFFFFFF, string256);
                jailed = 1;
            }
        }

        if (jailed == 0)
        {
            SendClientMessage(playerid, 0xE60000FF, "Няма онлайн играчи в затвора.");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:specoff(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] > 0 || PlayerInfo[playerid][pTest] == 1)
    {
        if (specing[playerid] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "В момента не наблюдаваш играч!");
            return 1;
        }
        TogglePlayerSpectating(playerid, 0);
        SetPlayerPos(playerid, LastCoor[playerid][sPx], LastCoor[playerid][sPy], LastCoor[playerid][sPz]);
        SetPlayerFacingAngle(playerid, LastCoor[playerid][sAngle]);
        SetPlayerInterior(playerid, LastCoor[playerid][sPint]);
        SetPlayerVirtualWorld(playerid, LastCoor[playerid][sVw]);
        specing[playerid] = 0;
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:aka(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /aka [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return 1;
    }

    new ip[16];
    GetPlayerIp(targetid, ip, sizeof(ip));

    new string1300result[1300];
    format(string1300result, sizeof(string1300result), "{FFFF80}AKA: %s (ID: %d) [IP: %s]\n", GetPlayerNickname(targetid), targetid, ip);
    strcat(string1300result, "{FFFF80}");
    strcat(string1300result, GetPlayerAka(targetid));

    new closeddialog = 3500;
    ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, "AKA", string1300result, "OK", "");
    return 1;
}

CMD:spec(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /spec [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return 1;
    }

    if (PlayerInfo[playerid][pTSpec] == 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш позволение да наблюдаваш играчите!");

    if (playerid == targetid)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да наблюдаваш себе си!");

    if (PlayerInfo[targetid][pBSpec] == 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч е забранил да го наблюдават!");

    if (PlayerInfo[playerid][pAdmin] < 5 && PlayerInfo[targetid][pAdmin] >= 5)
        return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да използваш тази команда върху администратор с 5-то ниво!");

    if (specing[playerid] == 0)
    {
        GetPlayerPos(playerid, LastCoor[playerid][sPx], LastCoor[playerid][sPy], LastCoor[playerid][sPz]);
        LastCoor[playerid][sPint] = GetPlayerInterior(playerid);
        LastCoor[playerid][sVw] = GetPlayerVirtualWorld(playerid);
        GetPlayerFacingAngle(playerid, LastCoor[playerid][sAngle]);
    }

    specing[playerid] = 1;
    TogglePlayerSpectating(playerid, 1);
    SetPlayerInterior(playerid, GetPlayerInterior(targetid));
    SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));

    if (IsPlayerInAnyVehicle(targetid))
    {
        new carid = GetPlayerVehicleID(targetid);
        PlayerSpectateVehicle(playerid, carid);
    }
    else
    {
        PlayerSpectatePlayer(playerid, targetid);
    }

    return 1;
}

CMD:jail(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, option;
    if (sscanf(params, "ui", targetid, option))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /jail [playerid] [option]");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 1: Каране на Job Vehicle за собствени цели, 2: Биене/Крадене на кола в тунинг гараж, 3: Лъже играчите, 4: DB без шофьор");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 5: Пречи на хората да работят, 6: Грешен Report/Advert, 7: Биене на TFC служител On-Duty, 8: Glitch, 9: Оплакване във форума");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 10: Грешно използване на /me или /do, 11: AFK в Job Vehicle, 12: Биене на ADMIN ON-DUTY, 13: Самоубива се на DMON");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 14: Прочети правилата /rules");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, COLOR_GRAD1, "Посоченото ID не е в сървъра!");

    if (PlayerInfo[targetid][pAdmin] >= 5 && PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да вкараш в затвора администратор с 5-то ниво!");

    if (option < 1 || option > 14)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /jail [playerid] [option]");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 1: Каране на Job Vehicle за собствени цели, 2: Биене/Крадене на кола в тунинг гараж, 3: Лъже играчите, 4: DB без шофьор");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 5: Пречи на хората да работят, 6: Грешен Report/Advert, 7: Биене на TFC служител On-Duty, 8: Glitch, 9: Оплакване във форума");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 10: Грешно използване на /me или /do, 11: AFK в Job Vehicle, 12: Биене на ADMIN ON-DUTY, 13: Самоубива се на DMON");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 14: Прочети правилата /rules");
        return 1;
    }

    if (PlayerInfo[targetid][pJail] != 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Този играч вече е в затвора!");

    // Jail the player
    ResetPlayerWeapons(targetid);
    SetPlayerVirtualWorld(targetid, 1);
    SetPlayerInterior(targetid, 4);
    SetPlayerPos(targetid, 299.7077, 303.4193, 999.1484);
    SetPlayerAttachedObject(targetid, 1, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);
    SetPlayerSpecialAction(targetid, SPECIAL_ACTION_CUFFED);

    new string256[256];
    switch (option)
    {
        case 1:
        {
            PlayerInfo[targetid][pJail] = 15 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was jailed by %s for 15 minutes. [Reason: Каране на Job Vehicle за собствени цели]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            PlayerInfo[targetid][pJailReason] = 1;
        }
        case 2:
        {
            PlayerInfo[targetid][pJail] = 15 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was jailed by %s for 15 minutes. [Reason: Биене/Крадене на кола в тунинг гараж]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            PlayerInfo[targetid][pJailReason] = 2;
        }
        case 3:
        {
            PlayerInfo[targetid][pJail] = 20 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was jailed by %s for 20 minutes. [Reason: Лъже играчите]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            PlayerInfo[targetid][pJailReason] = 3;
        }
        case 4:
        {
            PlayerInfo[targetid][pJail] = 20 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was jailed by %s for 20 minutes. [Reason: DB без шофьор]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            PlayerInfo[targetid][pJailReason] = 4;
        }
        case 5:
        {
            PlayerInfo[targetid][pJail] = 25 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was jailed by %s for 25 minutes. [Reason: Пречи на хората да работят]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            PlayerInfo[targetid][pJailReason] = 5;
        }
        case 6:
        {
            PlayerInfo[targetid][pJail] = 25 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was jailed by %s for 25 minutes. [Reason: Грешен Report/Advert]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            PlayerInfo[targetid][pJailReason] = 6;
        }
        case 7:
        {
            PlayerInfo[targetid][pJail] = 25 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was jailed by %s for 25 minutes. [Reason: Биене на TFC служител On-Duty]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            PlayerInfo[targetid][pJailReason] = 7;
        }
        case 8:
        {
            PlayerInfo[targetid][pJail] = 35 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was jailed by %s for 35 minutes. [Reason: Glitch]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            PlayerInfo[targetid][pJailReason] = 8;
        }
        case 9:
        {
            PlayerInfo[targetid][pJail] = 35 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was jailed by %s for 35 minutes. [Reason: Оплакване във форума]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            PlayerInfo[targetid][pJailReason] = 9;
        }
        case 10:
        {
            PlayerInfo[targetid][pJail] = 35 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was jailed by %s for 35 minutes. [Reason: Грешно използване на /me или /do]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            PlayerInfo[targetid][pJailReason] = 10;
        }
        case 11:
        {
            PlayerInfo[targetid][pJail] = 35 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was jailed by %s for 35 minutes. [Reason: AFK в Job Vehicle]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            PlayerInfo[targetid][pJailReason] = 11;
        }
        case 12:
        {
            PlayerInfo[targetid][pJail] = 40 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was jailed by %s for 40 minutes. [Reason: Биене на ADMIN ON-DUTY]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            PlayerInfo[targetid][pJailReason] = 12;
        }
        case 13:
        {
            PlayerInfo[targetid][pJail] = 15 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was jailed by %s for 15 minutes. [Reason: Самоубива се на DMON]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            PlayerInfo[targetid][pJailReason] = 13;
        }
        case 14:
        {
            PlayerInfo[targetid][pJail] = 20 * 60;
            format(string256, sizeof(string256), "ADMIN: %s was jailed by %s for 20 minutes. [Reason: Прочети правилата /rules]", GetPlayerNickname(targetid), GetPlayerNickname(playerid));
            PlayerInfo[targetid][pJailReason] = 14;
        }
    }

    SendClientMessageToAll(0xE60000FF, string256);
    return 1;
}

CMD:ajail(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new nickname[MAX_PLAYER_NAME], option;
    if (sscanf(params, "s[24]i", nickname, option))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /ajail [nickname] [option]");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 1: Каране на Job Vehicle за собствени цели, 2: Биене/Крадене на кола в тунинг гараж, 3: Лъже играчите, 4: DB без шофьор");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 5: Пречи на хората да работят, 6: Грешен Report/Advert, 7: Биене на TFC служител On-Duty, 8: Glitch, 9: Оплакване във форума");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 10: Грешно използване на /me или /do, 11: AFK в Job Vehicle, 12: Биене на ADMIN ON-DUTY, 13: Самоубива се на DMON");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 14: Прочети правилата /rules");
        return CMD_SUCCESS;
    }

    if (option < 1 || option > 14)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /ajail [nickname] [option]");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 1: Каране на Job Vehicle за собствени цели, 2: Биене/Крадене на кола в тунинг гараж, 3: Лъже играчите, 4: DB без шофьор");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 5: Пречи на хората да работят, 6: Грешен Report/Advert, 7: Биене на TFC служител On-Duty, 8: Glitch, 9: Оплакване във форума");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 10: Грешно използване на /me или /do, 11: AFK в Job Vehicle, 12: Биене на ADMIN ON-DUTY, 13: Самоубива се на DMON");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 14: Прочети правилата /rules");
        return CMD_SUCCESS;
    }

    if (!IsNicknameInDB(nickname))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този nickname не съществува!");
        return CMD_SUCCESS;
    }

    // Check if player is already jailed
    new foundOnline = 0;
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && strcmp(nickname, GetPlayerNickname(i), true) == 0)
        {
            foundOnline = 1;
            if (PlayerInfo[i][pJail] != 0)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Този играч вече е в затвора!");
                return CMD_SUCCESS;
            }
            break;
        }
    }

    if (!foundOnline && GetUserValueInt(nickname, "jail") > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч вече е в затвора!");
        return CMD_SUCCESS;
    }

    new string256[256];
    new jailTime = 0, jailReason = 0;

    switch (option)
    {
        case 1:
        {
            jailTime = 15 * 60;
            jailReason = 1;
        }
        case 2:
        {
            jailTime = 15 * 60;
            jailReason = 2;
        }
        case 3:
        {
            jailTime = 20 * 60;
            jailReason = 3;
        }
        case 4:
        {
            jailTime = 20 * 60;
            jailReason = 4;
        }
        case 5:
        {
            jailTime = 25 * 60;
            jailReason = 5;
        }
        case 6:
        {
            jailTime = 25 * 60;
            jailReason = 6;
        }
        case 7:
        {
            jailTime = 25 * 60;
            jailReason = 7;
        }
        case 8:
        {
            jailTime = 35 * 60;
            jailReason = 8;
        }
        case 9:
        {
            jailTime = 35 * 60;
            jailReason = 9;
        }
        case 10:
        {
            jailTime = 35 * 60;
            jailReason = 10;
        }
        case 11:
        {
            jailTime = 35 * 60;
            jailReason = 11;
        }
        case 12:
        {
            jailTime = 40 * 60;
            jailReason = 12;
        }
        case 13:
        {
            jailTime = 15 * 60;
            jailReason = 13;
        }
        case 14:
        {
            jailTime = 20 * 60;
            jailReason = 14;
        }
    }

    // Update database
    UpdatePlayerDatabaseINT("jail_reason", jailReason, nickname);
    UpdatePlayerDatabaseINT("jail", jailTime, nickname);

    // Get reason text for broadcast
    new reasonText[128];
    switch (option)
    {
        case 1: reasonText = "Каране на Job Vehicle за собствени цели";
        case 2: reasonText = "Биене/Крадене на кола в тунинг гараж";
        case 3: reasonText = "Лъже играчите";
        case 4: reasonText = "DB без шофьор";
        case 5: reasonText = "Пречи на хората да работят";
        case 6: reasonText = "Грешен Report/Advert";
        case 7: reasonText = "Биене на TFC служител On-Duty";
        case 8: reasonText = "Glitch";
        case 9: reasonText = "Оплакване във форума";
        case 10: reasonText = "Грешно използване на /me или /do";
        case 11: reasonText = "AFK в Job Vehicle";
        case 12: reasonText = "Биене на ADMIN ON-DUTY";
        case 13: reasonText = "Самоубива се на DMON";
        case 14: reasonText = "Прочети правилата /rules";
    }

    format(string256, sizeof(string256), "ADMIN: %s was jailed by %s for %d minutes. [Reason: %s]", nickname, GetPlayerNickname(playerid), jailTime / 60, reasonText);
    SendClientMessageToAll(0xE60000FF, string256);

    // Jail online player if found
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && strcmp(nickname, GetPlayerNickname(i), true) == 0)
        {
            PlayerInfo[i][pJailReason] = jailReason;
            PlayerInfo[i][pJail] = jailTime;
            ResetPlayerWeapons(i);
            SetPlayerVirtualWorld(i, 1);
            SetPlayerInterior(i, 4);
            SetPlayerPos(i, 299.7077, 303.4193, 999.1484);
            SetPlayerAttachedObject(i, 1, 19418, 6, -0.011000, 0.028000, -0.022000, -15.600012, -33.699977, -81.700035, 0.891999, 1.000000, 1.168000);
            SetPlayerSpecialAction(i, SPECIAL_ACTION_CUFFED);
            break;
        }
    }

    return CMD_SUCCESS;
}

CMD:checkbank(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /checkbank [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    new stringbank[256];
    format(stringbank, sizeof(stringbank), "Играчът %s има $%d в неговата обща сума!", GetPlayerNickname(targetid), PlayerInfo[targetid][pAccount]);
    SendClientMessage(playerid, 0x40BF00FF, stringbank);

    return CMD_SUCCESS;
}

CMD:ncheckwarns(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new nickname[MAX_PLAYER_NAME];
    if (sscanf(params, "s[24]", nickname))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /ncheckwarns [nickname]");
        return CMD_SUCCESS;
    }

    if (!IsNicknameInDB(nickname))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този nickname не съществува!");
        return CMD_SUCCESS;
    }

    // Check if player is online
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && strcmp(nickname, GetPlayerNickname(i), true) == 0)
        {
            new stringbank[256];
            format(stringbank, sizeof(stringbank), "%s има - %d Warns", nickname, PlayerInfo[i][pWarns]);
            SendClientMessage(playerid, 0xFFFFFFFF, stringbank);
            return CMD_SUCCESS;
        }
    }

    // Player is offline, get from database
    new stringbank[256];
    format(stringbank, sizeof(stringbank), "%s има - %d Warns", nickname, GetUserValueInt(nickname, "warns"));
    SendClientMessage(playerid, 0xFFFFFFFF, stringbank);

    return CMD_SUCCESS;
}


CMD:nban(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, reason[30];
    if (sscanf(params, "us[30]", targetid, reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /nban [playerid] [reason]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (strlen(reason) < 1 || strlen(reason) > 30)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Причината трябва да бъде с до 30 символа!");

    new string256[256];
    format(string256, sizeof(string256), "ADMIN: %s was blocked by %s [Reason: %s]", GetPlayerNickname(targetid), GetPlayerNickname(playerid), reason);
    SendClientMessageToAll(0xE60000FF, string256);

    PlayerInfo[targetid][pBlock] = 1;
    PlayerInfo[targetid][pKick] = 1;

    return 1;
}

CMD:rban(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new nickname[32], reason[32];
    if (sscanf(params, "s[32]s[32]", nickname, reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /rban [nickname] [reason]");
        return 1;
    }

    if (strlen(nickname) < 1 || strlen(nickname) > 30)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Името трябва да бъде с до 30 символа!");

    if (strlen(reason) < 1 || strlen(reason) > 30)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Причината трябва да бъде с до 30 символа!");

    if (!IsNicknameInDB(nickname))
        return SendClientMessage(playerid, COLOR_GRAD1, "Този nickname не съществува!");

    new string256[256];
    format(string256, sizeof(string256), "ADMIN: [%d:%d:%d] %s was banned by %s [Reason: %s]", hours, minutes, seconds, nickname, GetPlayerNickname(playerid), reason);
    SendClientMessageToAll(0xE60000FF, string256);

    new rconCommandString[115];
    format(rconCommandString, sizeof(rconCommandString), "banip %s", GetUserValueString(nickname, "ip"));
    SendRconCommand(rconCommandString);
    SendRconCommand("reloadbans");

    UpdatePlayerDatabaseINT("block", 1, nickname);

    return 1;
}

CMD:ban(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, reason[30];
    if (sscanf(params, "us[30]", targetid, reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /ban [playerid] [reason]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (PlayerInfo[targetid][pAdmin] > PlayerInfo[playerid][pAdmin])
    {
        new string256[256];
        format(string256, sizeof(string256), "SERVER: %s was kicked by THE SERVER [Reason: Ban a larger admin level]", GetPlayerNickname(playerid));
        SendClientMessageToAll(0xE60000FF, string256);
        PlayerInfo[playerid][pKick] = 1;
        return 1;
    }

    if (strlen(reason) < 1 || strlen(reason) > 30)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Причината трябва да бъде с до 30 символа!");

    new string256[256];
    format(string256, sizeof(string256), "ADMIN: [%d:%d:%d] %s was banned by %s [Reason: %s]", hours, minutes, seconds, GetPlayerNickname(targetid), GetPlayerNickname(playerid), reason);
    SendClientMessageToAll(0xE60000FF, string256);

    PlayerInfo[targetid][pBlock] = 1;
    SetTimerEx("BanExPublic", 1000, false, "ds", targetid, reason);

    return 1;
}

CMD:kick(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pTest] != 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, reason[256];
    if (sscanf(params, "us[256]", targetid, reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /kick [playerid] [reason]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (PlayerInfo[playerid][pAdmin] < 5 && PlayerInfo[targetid][pAdmin] >= 5)
        return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да използваш тази команда върху администратор с 5-то ниво!");

    if (strlen(reason) < 1)
        return SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /kick [playerid] [reason]");

    new string256[256];
    format(string256, sizeof(string256), "ADMIN: %s was kicked by %s [Reason: %s]", GetPlayerNickname(targetid), GetPlayerNickname(playerid), reason);
    SendClientMessageToAll(0xE60000FF, string256);

    PlayerInfo[targetid][pKick] = 1;

    return 1;
}

CMD:block(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new targetName[MAX_PLAYER_NAME], reason[32];
    if (sscanf(params, "s[24]s[32]", targetName, reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /block [nickname] [reason]");
        return 1;
    }

    if (strlen(targetName) < 1 || strlen(targetName) > 30)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Името трябва да бъде с до 30 символа!");
        return 1;
    }

    if (strlen(reason) < 1 || strlen(reason) > 30)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Причината трябва да бъде с до 30 символа!");
        return 1;
    }

    if (!IsNicknameInDB(targetName))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този nickname не съществува!");
        return 1;
    }

    if (GetUserValueInt(targetName, "block") == 1)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Този nickname е блокиран!");
        return 1;
    }

    // Block the player in database
    UpdatePlayerDatabaseINT("block", 1, targetName);

    // Block online player if found
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && strcmp(targetName, GetPlayerNickname(i), true) == 0)
        {
            PlayerInfo[i][pBlock] = 1;
            PlayerInfo[i][pKick] = 1;
            break;
        }
    }

    format(string, sizeof(string), "ADMIN: %s was blocked by %s [Reason: %s]", targetName, GetPlayerNickname(playerid), reason);
    SendClientMessageToAll(0xE60000FF, string);

    return 1;
}

CMD:getbiz(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права да използваш тази команда!");
        return 1;
    }

    new bizid;
    if (sscanf(params, "d", bizid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /getbiz [id]");
        return 1;
    }

    if (bizid < 0 || bizid >= maxbiz + 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Невалидно ID на бизнес.");
        return 1;
    }

    new file[64];
    if (!IsValidBiz(bizid))
    {
        SendClientMessage(playerid, 0xE60000FF, "Този бизнес не съществува.");
        return 1;
    }

    new bool:playerFound = false;

    // Find and remove business from online players
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pBizO] == bizid)
        {
            playerFound = true;
            PlayerInfo[i][pBizO] = -1;
            SendClientMessage(i, 0xFFFFFFFF, "Твоят бизнес беше освободен!");
            break;
        }
    }

    // Update business data
    format(BizInfo[bizid][bOwnerName], 256, "None");
    BizInfo[bizid][bOwner] = 0;

    SaveBiz(bizid);

    new msg[128];
    format(msg, sizeof(msg), "Ти освободи бизнес ID: %d", bizid);
    SendClientMessage(playerid, 0xFFFFFFFF, msg);

    if (!playerFound)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Няма играч с такъв бизнес.");
    }

    return 1;
}

CMD:removebiz(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права да използваш тази команда!");
        return 1;
    }

    new bizid;
    if (sscanf(params, "d", bizid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /removebiz [id]");
        return 1;
    }

    if (bizid < 0 || bizid >= maxbiz + 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Невалидно ID на бизнес.");
        return 1;
    }

    if (!IsValidBiz(bizid))
    {
        SendClientMessage(playerid, 0xE60000FF, "Този бизнес не съществува.");
        return 1;
    }

    new bool:playerFound = false;

    // Find and notify online players who own this business
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pBizO] == bizid)
        {
            playerFound = true;
            PlayerInfo[i][pBizO] = -1;
            SendClientMessage(i, 0xFFFFFFFF, "Твоят бизнес беше унищожен!");
            break;
        }
    }

    DestroyBiz(bizid);

    new msg[128];
    format(msg, sizeof(msg), "Ти унищожи бизнес ID: %d", bizid);
    SendClientMessage(playerid, 0xFFFFFFFF, msg);

    return 1;
}

CMD:gotobiz(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права да използваш тази команда.");
        return 1;
    }

    new bizid;
    if (sscanf(params, "d", bizid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /gotobiz [id]");
        return 1;
    }

    if (bizid < 0 || bizid >= maxbiz + 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Невалидно ID на бизнес.");
        return 1;
    }

    // Teleport to business
    SetPlayerPos(playerid, BizInfo[bizid][bX], BizInfo[bizid][bY], BizInfo[bizid][bZ] + 1.0);
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);

    new msg[128];
    format(msg, sizeof(msg), "Телепортирахте се до бизнес ID: %d.", bizid);
    SendClientMessage(playerid, 0x00E600FF, msg);

    return 1;
}

CMD:bizid(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
        return 1;
    }
    new bizid = IsPlayerNearBiz(playerid);
    if (bizid >= 0)
    {
        new stringbiz[256];
        format(stringbiz, 256, "BIZZ - {FF0000}%d", bizid);
        SendClientMessage(playerid, 0xFFFFFFFF, stringbiz);
        return 1;
    }


    SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си близо до бизнес!");
    return 1;
}

CMD:gotohveh(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new houseid;
    if (sscanf(params, "d", houseid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /gotohveh [house id]");
        return 1;
    }

    if (houseid < 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Невалидно ID на къща!");
        return 1;
    }

    if (!IsValidHouse(houseid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Тази къща не съществува!");
        return 1;
    }

    if (!IsValidVehicle(HouseInfo[houseid][hcVeh]))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Тази къща няма превозно средство!");
        return 1;
    }

    new Float:x, Float:y, Float:z;
    GetVehiclePos(HouseInfo[houseid][hcVeh], x, y, z);
    SetPlayerPos(playerid, x, y, z + 3.0);

    new message[128];
    format(message, sizeof(message), "* Ти успешно се телепортира до превозното средство на къща ID %d *", houseid);
    SendClientMessage(playerid, 0xFFFFFFFF, message);

    return 1;
}

CMD:gotoveh(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new vehicleid;
    if (sscanf(params, "d", vehicleid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /gotoveh [vehicle id]");
        return 1;
    }

    if (vehicleid < 0 || vehicleid > MAX_VEHICLES)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Невалидно ID на превозно средство!");
        return 1;
    }

    if (!IsValidVehicle(vehicleid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Това превозно средство не съществува!");
        return 1;
    }

    new Float:x, Float:y, Float:z;
    GetVehiclePos(vehicleid, x, y, z);
    SetPlayerPos(playerid, x, y, z + 3.0);

    new message[128];
    format(message, sizeof(message), "* Ти успешно се телепортира до превозното средство ID %d *", vehicleid);
    SendClientMessage(playerid, 0xFFFFFFFF, message);

    return 1;
}

CMD:giveveh(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, vehicleid;
    if (sscanf(params, "ui", targetid, vehicleid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /giveveh [playerid] [vehicleid 0-500]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (vehicleid < 0 || vehicleid > 500)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /giveveh [playerid] [vehicleid 0-500]");
        return 1;
    }

    if (vehicleid >= MAX_PRIVATEVEHS)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Това превозно средство все още не е създадено!");

    new string256[256];
    format(string256, sizeof(string256), "* %s ти даде превозно средство, честито *", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0xBFFF80FF, string256);

    format(string256, sizeof(string256), "* Ти даде превозно средство на %s *", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xBFFF80FF, string256);

    new vehiclesstring[64];
    format(vehiclesstring, sizeof(vehiclesstring), "/Vehicles/%d.ini", vehicleid);


    format(PrivateVeh[vehicleid][pvOwner], 40, "%s", GetPlayerNickname(targetid));
    PrivateVeh[vehicleid][pvIsOwned] = 1;
    SavePrivateVeh(vehicleid);
    return 1;
}

CMD:getveh(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new vehicleid;
    if (sscanf(params, "i", vehicleid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /getveh [vehicleid 1-500]");
        return 1;
    }

    if (vehicleid < 1 || vehicleid > 500)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /getveh [vehicleid 1-500]");
        return 1;
    }

    if (vehicleid >= MAX_PRIVATEVEHS)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Това превозно средство все още не е създадено!");

    if (PrivateVeh[vehicleid][pvOwner] == 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Това превозно средство няма притежател!");

    new string256[256];
    format(string256, sizeof(string256), "* Ти премахна собствеността на лично превозно средство ID: %d *", vehicleid);
    SendClientMessage(playerid, 0xBFFF80FF, string256);

    format(PrivateVeh[vehicleid][pvOwner], 40, "None");
    PrivateVeh[vehicleid][pvOwner] = 0;
    PrivateVeh[vehicleid][pvIsOwned] = 0;

    SavePrivateVeh(vehicleid);

    return 1;
}
CMD:makevip(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, level;
    if (sscanf(params, "ui", targetid, level))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /makevip [playerid] [level 1-6]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (level < 1 || level > 6)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /makevip [playerid] [level 1-6]");
        return 1;
    }

    PlayerInfo[targetid][pVip] = level;

    new string256[256];
    format(string256, sizeof(string256), "* %s те направи %d VIP левел, поздравления *", GetPlayerNickname(playerid), level);
    SendClientMessage(targetid, 0xE65B00FF, string256);

    format(string256, sizeof(string256), "* Ти направи %s VIP левел %d *", GetPlayerNickname(targetid), level);
    SendClientMessage(playerid, 0xE65B00FF, string256);

    if (level < 2)
    {
        PlayerInfo[targetid][pInfiniteNos] = 0;
        if (IsPlayerInAnyVehicle(targetid))
        {
            AddVehicleComponent(GetPlayerVehicleID(targetid), 1008);
        }
    }

    if (level > 3)
    {
        PlayerInfo[targetid][pLaser] = 1;

        switch (PlayerInfo[targetid][pTeam])
        {
            case FACTION_VIP: SetPVarInt(targetid, "color", 18643);
            case FACTION_GROVE: SetPVarInt(targetid, "color", 19083);
            case 13, FACTION_CREW:
                SetPVarInt(targetid, "color", 19080);
            case FACTION_RIFA: SetPVarInt(targetid, "color", 19080);
            case FACTION_INTENSE_POLICE: SetPVarInt(targetid, "color", 19080);
            default:
                SetPVarInt(targetid, "color", 0);
        }
    }
    else
    {
        PlayerInfo[targetid][pLaser] = 0;
        SetPVarInt(targetid, "color", 0);
    }

    return 1;
}

CMD:makegleader(playerid, params[])
{
    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /makegleader [playerid]");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[playerid][pAdmin] < 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pGLeader] == 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч вече е главен лидер!");
        return CMD_SUCCESS;
    }

    if (PlayerInfo[targetid][pRank] < 6)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Този играч трябва първо да бъде лидер!");
        return CMD_SUCCESS;
    }

    PlayerInfo[targetid][pGLeader] = 1;
    PlayerInfo[targetid][pRank] = 6;

    new teamName[60];
    format(teamName, sizeof(teamName), "%s", TeamInfo[PlayerInfo[targetid][pTeam]][tName]);

    new string256[256];
    format(string256, sizeof(string256), "*** Ти назначи %s за главен лидер на %s ***", GetPlayerNickname(targetid), teamName);
    SendClientMessage(playerid, 0xF97804FF, string256);

    format(string256, sizeof(string256), "*** Ти беше назначен от %s за главен лидер на %s ***", GetPlayerNickname(playerid), teamName);
    SendClientMessageToAll(0xF97804FF, string256);

    return CMD_SUCCESS;
}

CMD:makeleader(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return CMD_SUCCESS;
    }

    new targetid, teamid;
    if (sscanf(params, "ui", targetid, teamid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /makeleader [playerid] [team 1-22]");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 1: VIP, 2: Grove Street Families, 3: Rolling Heights Ballas");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 4: Los Santos Vagos, 5: Varrio Los Aztecas, 6: Vinewood Cripz");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 7: San Fierro Triads, 8: San Fierro Rifa, 9: Sons Of Anarchy");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 10: Da Nang Boys, 11: Italian Mafia, 12: Bounty Hunters");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 13: Thug Life, 14: 116th Street Crew");
        SendClientMessage(playerid, 0xFFFFFFFF, "Options: 15: Intense Police Department");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 16: Soldier Boys, 17: Yakuza 18: Syndicate Texas, 19: Blood Mafia");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 20: MS-13, 21: Bulgarian Mafia, 22: 343 Black Street");
        return CMD_SUCCESS;
    }

    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return CMD_SUCCESS;
    }

    if (teamid < 1 || teamid > 22)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /makeleader [playerid] [team 1-22]");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 1: VIP, 2: Grove Street Families, 3: Rolling Heights Ballas");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 4: Los Santos Vagos, 5: Varrio Los Aztecas, 6: Vinewood Cripz");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 7: San Fierro Triads, 8: San Fierro Rifa, 9: Sons Of Anarchy");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 10: Da Nang Boys, 11: Italian Mafia, 12: Bounty Hunters");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 13: Thug Life, 14: 116th Street Crew");
        SendClientMessage(playerid, 0xFFFFFFFF, "Options: 15: Intense Police Department");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 16: Soldier Boys, 17: Yakuza 18: Syndicate Texas, 19: Blood Mafia");
        SendClientMessage(playerid, 0xFFFF00FF, "Options: 20: MS-13, 21: Bulgarian Mafia, 22: 343 Black Street");
        return CMD_SUCCESS;
    }

    // Set player as leader
    if (teamid != 15) // If not IPD
    {
        PlayerInfo[targetid][pIPDDuty] = 0;
    }

    PlayerInfo[targetid][pHelperLeader] = 0;
    PlayerInfo[targetid][pTeam] = teamid;
    PlayerInfo[targetid][pRank] = 6;
    PlayerInfo[targetid][pGLeader] = 0;

    // Send messages
    new string256[256];
    format(string256, sizeof(string256), "*** %s беше назначен за лидер на банда/мафия %s ***", GetPlayerNickname(targetid), TeamInfo[teamid][tName]);
    SendClientMessageToAll(0xF97804FF, string256);

    format(string256, sizeof(string256), "Ти беше назначен за лидер в %s от %s.", TeamInfo[teamid][tName], GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0xF97804FF, string256);

    // Update player appearance and settings
    RestartVIPLaser(playerid);

    if (PlayerInfo[targetid][pADuty] == 0)
    {
        RestartPlayerColor(targetid);
        RestartPlayerSkin(targetid);
    }

    if (PlayerInfo[targetid][pADuty] == 0 && GetPlayerVehicleID(targetid) > 0)
    {
        SendClientMessage(targetid, 0xFFFFFFFF, "* Твоят скин не се смени, защото не си пешеходец *");
    }

    if (PlayerInfo[targetid][pSpawnO] != 2)
    {
        PlayerInfo[targetid][pSpawnO] = 2;
        SendClientMessage(targetid, 0xFFFFFFFF, "SERVER: Твоят spawn беше променен на Faction spawn!");
    }

    return CMD_SUCCESS;
}


CMD:akill(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 1 && PlayerInfo[playerid][pTest] != 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /akill [playerid]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    SetPlayerHealth(targetid, 0);

    new string115[115];
    format(string115, sizeof(string115), "You have been admin killed by %s", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0xE60000FF, string115);

    format(string115, sizeof(string115), "You killed %s", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xE60000FF, string115);

    return 1;
}

CMD:gethere(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 2)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid;
    if (sscanf(params, "u", targetid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /gethere [playerid]");
        return 1;
    }

    if (targetid == playerid)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да телепортираш себе си!");

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    SetPlayerInterior(targetid, GetPlayerInterior(playerid));
    SetPlayerVirtualWorld(targetid, GetPlayerVirtualWorld(playerid));
    SetPlayerPos(targetid, x, y + 2.0, z);

    new string115[115];
    format(string115, sizeof(string115), "* Ти беше телепортиран до %s *", GetPlayerNickname(playerid));
    SendClientMessage(targetid, 0xFFFFFFFF, string115);

    format(string115, sizeof(string115), "* Ти телепортира %s до теб *", GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFFFFFF, string115);

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && PlayerInfo[i][pAdmin] >= 1 && PlayerInfo[i][pAHide] == 0)
        {
            format(string115, sizeof(string115), "Teleport: %s телепортира %s до себе си!", GetPlayerNickname(playerid), GetPlayerNickname(targetid));
            SendClientMessage(i, 0xE60000FF, string115);
        }
    }

    return 1;
}

CMD:removefreevip(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    if (freevip == 1)
    {
        format(string256, 256, "* %s премахна безплатния VIP Level 6 за всички *", GetPlayerNickname(playerid));
        SendClientMessageToAll(0xE65B00FF, string256);
        freevip = 0;
    }
    else
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Безплатният VIP не е активиран!");
    }
    return 1;
}

CMD:jump(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 4)
    {
        if (PlayerInfo[playerid][pADuty] == 1)
        {
            if (Jump[playerid] == 1)
            {
                SendClientMessage(playerid, 0xFFFF00FF, "{FFFFFF}SERVER: Ти деактивира Jump Mode!");
                Jump[playerid] = 0;
                return 1;
            }
            if (Jump[playerid] == 0)
            {
                SendClientMessage(playerid, 0xFFFF00FF, "{FFFFFF}SERVER: Ти активира Jump Mode!");
                Jump[playerid] = 1;
            }
            else
            {
                SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си ADMIN ON-DUTY!");
        }
        return 1;
    }
}
CMD:speed(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 4)
    {
        if (PlayerInfo[playerid][pADuty] == 1)
        {
            if (PlayerInfo[playerid][pIFCDuty] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си IFC ON-DUTY!");
            if (Speed[playerid] == 1)
            {
                SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Ти деактивира Speed Mode!");
                Speed[playerid] = 0;
                return 1;
            }
            if (Speed[playerid] == 0)
            {
                SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Ти активира Speed Mode!");
                SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Натисни Лявото копче на мишката(LMB) или Alt, за да използваш Speed мода");
                Speed[playerid] = 1;
            }
            else
            {
                SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си ADMIN ON-DUTY!");
        }
        return 1;
    }
}

CMD:fly(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 4)
    {
        return SendClientMessage(playerid, COLOR_GRAD1, "Нямаш права за да ползваш командата!");
    }

    if (PlayerInfo[playerid][pADuty] != 1)
    {
        return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си ADMIN ON-DUTY!");
    }

    if (PlayerInfo[playerid][pIFCDuty] == 1)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си IFC ON-DUTY!");
    }

    new option[32];
    if (sscanf(params, "s[32]", option))
    {
        // Toggle mode if no parameter provided
        if (fly[playerid] == 1)
        {
            fly[playerid] = 0;
            SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Ти деактивира Fly Mode.");
            TogglePlayerControllable(playerid, true);
        }
        else
        {
            fly[playerid] = 1;
            SendClientMessage(playerid, COLOR_YELLOW, "{FFFFFF}SERVER: Ти активира Fly Mode.");
            TogglePlayerControllable(playerid, false);
        }
        return 1;
    }

    if (strcmp(option, "on", true) == 0)
    {
        fly[playerid] = 1;
        SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Ти активира Fly Mode!");
        TogglePlayerControllable(playerid, false);
    }
    else if (strcmp(option, "off", true) == 0)
    {
        fly[playerid] = 0;
        SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Ти деактивира Fly Mode!");
        TogglePlayerControllable(playerid, true);
    }
    else
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /fly [on/off]");
        SendClientMessage(playerid, 0xFFFFFFFF, "Ако не посочиш опция, командата ще превключва между ON и OFF");
    }

    return 1;
}

CMD:spawnpv(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new vehicleid;
    if (sscanf(params, "d", vehicleid))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /spawnpv [vehicle id 1-500]");
        return 1;
    }

    if (vehicleid < 1 || vehicleid > 500)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /spawnpv [vehicle id 1-500]");
        return 1;
    }

    if (!PrivateVehExists(vehicleid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Това превозно средство не съществува!");
        return 1;
    }

    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    // Respawn and position the vehicle
    SetVehicleToRespawn(PrivateVeh[vehicleid][pvID]);
    SetVehiclePos(PrivateVeh[vehicleid][pvID], x, y, z);
    SetVehicleVirtualWorld(PrivateVeh[vehicleid][pvID], 0);
    PutPlayerInVehicle(playerid, PrivateVeh[vehicleid][pvID], 0);

    new message[128];
    format(message, sizeof(message), "Ти спавнахте частно превозно средство ID: %d", vehicleid);
    SendClientMessage(playerid, 0xFFFFFFFF, message);

    return 1;
}

CMD:saveserver(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 5)
    {
        new teams[64];
        SendClientMessageToAll(0xE60000FF, "SERVER: - SAVE: Цялата статистика за сървъра в момента се ЗАПАМЕТЯВА АВТОМАТИЧНО!");
        SendClientMessageToAll(0xE60000FF, "SERVER: В момента всичко за акаунтите/къщите/бизнесите се запаметява!");
        SendClientMessageToAll(0xE60000FF, "SERVER: Докато всичко се запаметява сървъра ще изглежда че все едно не работи!");
        SendClientMessageToAll(0xE60000FF, "SERVER: Няма да можете да правите нищо в сървъра, но това е само докато нещата се запаметят!");
        SendClientMessageToAll(0xE60000FF, "SERVER: Моля,изчакайте докато всичко се запамети!");
        for (new alb = 1; alb < MAX_BIZZ; alb++)
        {
            SaveBiz(alb);
        }
        for (new i; i < MAX_PLAYERS; i++)
        {
            SavePlayerStats(i);
        }
        for (new i = 1; i < MAX_TEAMS; i++)
        {
            SaveFaction(i);
        }
        for (new i = 1; i < MAX_TURFS; i++)
        {
            SaveTurf(i);
        }
        SendClientMessageToAll(0xE60000FF, "SERVER: Всичко се запамети успешно, благодарим за вашето търпение!");
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:giveep(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, amount;
    if (sscanf(params, "ui", targetid, amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /giveep [playerid] [ep]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (amount < 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Числото трябва да е по-голямо от 0!");
        return 1;
    }

    if (startedevent == 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "В момента няма евент!");

    if (startedevent < 2)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Евентът е без награда!");

    if (inevent[targetid] == 1)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Играчът не е от евента!");

    GivePlayerEP(targetid, amount);

    new string115[115];
    format(string115, sizeof(string115), "ADMIN: %s даде %d EP на %s", GetPlayerNickname(playerid), amount, GetPlayerNickname(targetid));
    SendClientMessageToAll(0xE60000FF, string115);

    return 1;
}

CMD:agiveep(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, amount;
    if (sscanf(params, "ui", targetid, amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /agiveep [playerid] [ep]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (amount < 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Числото трябва да е по-голямо от 0!");
        return 1;
    }

    GivePlayerEP(targetid, amount);

    new string115[115];
    format(string115, sizeof(string115), "* Ти даде %d EP на %s *", amount, GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFFFFFF, string115);

    format(string115, sizeof(string115), "* %s ти даде %d EP *", GetPlayerNickname(playerid), amount);
    SendClientMessage(targetid, 0xFFFF00FF, string115);

    return 1;
}

CMD:givees(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, amount;
    if (sscanf(params, "ui", targetid, amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /givees [playerid] [ep skill]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (amount < 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Числото трябва да е по-голямо от 0!");
        return 1;
    }

    GivePlayerEPS(targetid, amount);

    new string115[115];
    format(string115, sizeof(string115), "* Ти увеличи EP Skill с %d на %s *", amount, GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFFFFFF, string115);

    if (amount == 1)
    {
        format(string115, sizeof(string115), "* %s ти даде %d EP Skill *", GetPlayerNickname(playerid), amount);
    }
    else
    {
        format(string115, sizeof(string115), "* %s ти даде %d EP Skills *", GetPlayerNickname(playerid), amount);
    }
    SendClientMessage(targetid, 0xFFFF00FF, string115);

    return 1;
}


CMD:setepskill(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, amount;
    if (sscanf(params, "ui", targetid, amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /setepskill [playerid] [ep]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    PlayerInfo[targetid][pEPS] = amount;
    ActualizeDownStats(targetid);

    new string115[115];
    format(string115, sizeof(string115), "* Ти сложи EP Skill на %s да е %d *", GetPlayerNickname(targetid), amount);
    SendClientMessage(playerid, 0xFFFFFFFF, string115);

    format(string115, sizeof(string115), "* %s сложи твоят EP Skill да е %d *", GetPlayerNickname(playerid), amount);
    SendClientMessage(targetid, 0xFFFF00FF, string115);

    return 1;
}

CMD:setcash(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, amount;
    if (sscanf(params, "ui", targetid, amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /setcash [playerid] [cash]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    PlayerInfo[targetid][pCash] = amount;
    GivePlayerCash(targetid, 0);

    new string115[115];
    format(string115, sizeof(string115), "* Ти сложи парите на %s да са $%d *", GetPlayerNickname(targetid), amount);
    SendClientMessage(playerid, 0xFFFFFFFF, string115);

    format(string115, sizeof(string115), "* %s сложи твоите пари да са $%d *", GetPlayerNickname(playerid), amount);
    SendClientMessage(targetid, 0xFFFF00FF, string115);

    return 1;
}

CMD:takemoney(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, amount;
    if (sscanf(params, "ui", targetid, amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /takemoney [playerid] [cash]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (amount < 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Парите трябва да са по-големи от 0!");
        return 1;
    }

    if (PlayerInfo[targetid][pCash] < amount)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Играчът няма достатъчно пари!");
        return 1;
    }

    GivePlayerCash(targetid, -amount);

    new string115[115];
    format(string115, sizeof(string115), "* Ти взе $%d от %s *", amount, GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFFFFFF, string115);

    format(string115, sizeof(string115), "* %s ти взе $%d *", GetPlayerNickname(playerid), amount);
    SendClientMessage(targetid, 0xFFFF00FF, string115);

    return 1;
}

CMD:givecash(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, amount;
    if (sscanf(params, "ui", targetid, amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /givecash [playerid] [cash]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (amount < 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Парите трябва да са по-големи от 0!");
        return 1;
    }

    GivePlayerCash(targetid, amount);

    new string115[115];
    format(string115, sizeof(string115), "* Ти даде $%d на %s *", amount, GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFFFFFF, string115);

    format(string115, sizeof(string115), "* %s ти даде $%d *", GetPlayerNickname(playerid), amount);
    SendClientMessage(targetid, 0xFFFF00FF, string115);

    return 1;
}

CMD:givelevel(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");

    new targetid, amount;
    if (sscanf(params, "ui", targetid, amount))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /givelevel [playerid] [level]");
        return 1;
    }

    if (!IsPlayerConnected(targetid))
        return SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");

    if (amount < 1)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Левелът трябва да е по-голям от 0!");
        return 1;
    }

    GivePlayerLevel(targetid, amount);
    SetPlayerScore(targetid, PlayerInfo[targetid][pLevel]);

    new string115[115];
    format(string115, sizeof(string115), "* Ти увеличи с %d левела на %s *", amount, GetPlayerNickname(targetid));
    SendClientMessage(playerid, 0xFFFFFFFF, string115);

    if (amount == 1)
    {
        format(string115, sizeof(string115), "* %s ти даде %d левел *", GetPlayerNickname(playerid), amount);
    }
    else
    {
        format(string115, sizeof(string115), "* %s ти даде %d левела *", GetPlayerNickname(playerid), amount);
    }
    SendClientMessage(targetid, 0xFFFF00FF, string115);

    return 1;
}


CMD:freevip(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 5)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
        return 1;
    }

    new days;
    if (sscanf(params, "d", days))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /freevip [days]");
        return 1;
    }

    if (days < 1)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Моля въведи валиден брой дни (минимум 1).");
        return 1;
    }

    // Activate VIP and calculate end date
    freevip = 1;

    new year, month, day;
    getdate(year, month, day);

    freevip_end_day = day + days;
    freevip_end_month = month;
    freevip_end_year = year;

    // Adjust date if day exceeds 30
    if (freevip_end_day > 30)
    {
        freevip_end_day -= 30;
        freevip_end_month += 1;
        if (freevip_end_month > 12)
        {
            freevip_end_month = 1;
            freevip_end_year += 1;
        }
    }

    SaveFreeVIP(); // Save to INI

    new message[256];
    format(message, sizeof(message), "* %s активира безплатен VIP Level 6 за всички за %d дни *", GetPlayerNickname(playerid), days);
    SendClientMessageToAll(0xE65B00FF, message);

    return 1;
}

CMD:lastonline(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] < 3)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права да използваш тази команда!");
        return 1;
    }

    new targetName[MAX_PLAYER_NAME];
    if (sscanf(params, "s[24]", targetName))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /lastonline [nickname]");
        return 1;
    }

    if (!IsNicknameInDB(targetName))
    {
        SendClientMessage(playerid, 0xE60000FF, "Няма такъв акаунт!");
        return 1;
    }

    // Read data
    new year = GetUserValueInt(targetName, "year");
    new month = GetUserValueInt(targetName, "month");
    new day = GetUserValueInt(targetName, "day");
    new hour = GetUserValueInt(targetName, "hours");
    new minute = GetUserValueInt(targetName, "minutes");
    new second = GetUserValueInt(targetName, "seconds");

    if (month == 0)
    {
        SendClientMessage(playerid, 0x00E600FF, "В този профил е влизано за пръв път!");
        return 1;
    }

    new monthName[20];
    switch (month)
    {
        case 1: monthName = "Януари";
        case 2: monthName = "Февруари";
        case 3: monthName = "Март";
        case 4: monthName = "Април";
        case 5: monthName = "Май";
        case 6: monthName = "Юни";
        case 7: monthName = "Юли";
        case 8: monthName = "Август";
        case 9: monthName = "Септември";
        case 10: monthName = "Октомври";
        case 11: monthName = "Ноември";
        case 12: monthName = "Декември";
        default:
            monthName = "Неизвестен";
    }

    new message[256];
    format(message, sizeof(message), "Акаунтът %s е влизал последно на %d %s %d година в %02d:%02d:%02d часа.",
           targetName, day, monthName, year, hour, minute, second);
    SendClientMessage(playerid, 0x00E600FF, message);

    return 1;
}

CMD:togtestadmin(playerid, params[])
{
    if (PlayerInfo[playerid][pTest] == 1)
    {
        if (PlayerInfo[playerid][pAHide] == 0)
        {
            PlayerInfo[playerid][pAHide] = 1;
            SendClientMessage(playerid, 0xE60000FF, "Сега няма да можеш да виждаш какво пишат в TEST ADMIN чата!");
        }
        else
        {
            PlayerInfo[playerid][pAHide] = 0;
            SendClientMessage(playerid, 0xE60000FF, "Сега ще виждаш какво пишат в TEST ADMIN чата!");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:togadmin(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 1)
    {
        if (PlayerInfo[playerid][pAHide] == 0)
        {
            PlayerInfo[playerid][pAHide] = 1;
            SendClientMessage(playerid, 0xE60000FF, "Сега няма да можеш да виждаш какво пишат в ADMIN чата!");
        }
        else
        {
            PlayerInfo[playerid][pAHide] = 0;
            SendClientMessage(playerid, 0xE60000FF, "Сега ще виждаш какво пишат в ADMIN чата!");
        }
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

