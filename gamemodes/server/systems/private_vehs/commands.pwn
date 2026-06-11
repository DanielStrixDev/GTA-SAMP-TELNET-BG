CMD:vehres(playerid, params[])
{
    new haveprivate = 0;
    new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));

    for (new privateVehID = 1; privateVehID < MAX_PRIVATEVEHS; privateVehID++)
    {
        if (PrivateVeh[privateVehID][pvOwner][0] != '\0' &&
                strcmp(PrivateVeh[privateVehID][pvOwner], playername, true) == 0)
        {
            if (IsValidPrivateVehicle(privateVehID))
            {
                SetVehicleToRespawn(PrivateVeh[privateVehID][pvID]);
                haveprivate = 1;
            }
        }
    }

    if (haveprivate == 0)
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш лично превозно средство!");

    // Лог само при успех
    printf("[vehres] Играч %s респаун-на личните си превозни средства!", playername);

    format(string256, 256, "Own Vehicle: Ти respawn-на твоите лични превозни средства!");
    SendClientMessage(playerid, 0xB8860BFF, string256);
    return 1;
}

CMD:vehnorespawn(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);

    if (!IsPlayerInAnyVehicle(playerid))
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозно средство!");
    }
    new slot = VehicleToPrivateSlot[vehicleid];

    if (slot == -1 || PrivateVeh[slot][pvOwner][0] == '\0')
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Това не е лично превозно средство!");
    }
    new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));

    if (strcmp(PrivateVeh[slot][pvOwner], playername, true) != 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Това не е твоето превозно средство!");
    }
    PrivateVehSetRespawn(slot, -1);

    printf("[vehnorespawn] Играч %s сложи NO RESPAWN на колата си (VehicleID=%d, Slot=%d)",
           playername, vehicleid, slot);

    SendClientMessage(playerid, 0xB8860BFF, "Ти сложи NO RESPAWN на твоето превозно средство!");
    SendClientMessage(playerid, 0xB8860BFF, "SERVER: Превозното средство ще бъде NO RESPAWN след рестартиране на сървъра!");
    return 1;
}

CMD:vehsave(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if (!IsPlayerInAnyVehicle(playerid))
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозно средство!");
    }
    
    new slot = VehicleToPrivateSlot[vehicleid];
    if (slot == -1 || PrivateVeh[slot][pvOwner][0] == '\0')
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Това не е лично превозно средство!");
    }
    
    new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    if (strcmp(PrivateVeh[slot][pvOwner], playername, true) != 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Това не е твоето превозно средство!");
    }
    
    new Float:angleveh;
    GetVehicleZAngle(vehicleid, angleveh);
    new Float:vehx, Float:vehy, Float:vehz;
    GetVehiclePos(vehicleid, vehx, vehy, vehz);
    PrivateVehSetPos(slot, vehx, vehy, vehz, angleveh);
    
    printf("[vehsave] Играч %s запази позицията на колата си (Slot=%d, VehicleID=%d, Pos=%.2f,%.2f,%.2f, Angle=%.2f)",
        playername, slot, vehicleid, vehx, vehy, vehz, angleveh);
    
    SendClientMessage(playerid, 0xBFFF80FF, "Новата позиция на твоето превозно средство ще бъде валидна след рестарт!");
    return 1;
}

CMD:respawnv(playerid, params[])
{
    if (GetPlayerVehicleID(playerid) < 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозно средство!");
    if (PlayerInfo[playerid][pAdmin] >= 5)
    {
        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
        printf("[respawnv] Админ %s (ID:%d) респаун-на кола ID: %d", GetPlayerNickname(playerid), playerid, GetPlayerVehicleID(playerid));
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}

CMD:vehrespawn(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    
    if (!IsPlayerInAnyVehicle(playerid))
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозно средство!");
    }
    
    new slot = VehicleToPrivateSlot[vehicleid];
    
    if (slot == -1 || PrivateVeh[slot][pvOwner][0] == '\0')
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Това не е лично превозно средство!");
    }
    
    new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    
    if (strcmp(PrivateVeh[slot][pvOwner], playername, true) != 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Това не е твоето превозно средство!");
    }
    
    new seconds;
    if (sscanf(params, "d", seconds))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /vehrespawn [секунди]");
        return 1;
    }
    
    if (seconds < 1 || seconds > 999999)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Секундите трябва да са от 1 до 999999!");
        return 1;
    }
    
    PrivateVehSetRespawn(slot, seconds);
    
    printf("[vehrespawn] Играч %s сложи %d секунди respawn на колата си (Slot=%d, VehicleID=%d)",
        playername, seconds, slot, vehicleid);
    
    SendClientMessage(playerid, 0xB8860BFF, "Ти сложи време за Respawn на твоето превозно средство!");
    SendClientMessage(playerid, 0xB8860BFF, "SERVER: Превозното средство ще бъде с времето за RESPAWN след рестартиране на сървъра!");
    
    return 1;
}

CMD:vehcolor(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    
    if (!IsPlayerInAnyVehicle(playerid))
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозно средство!");
    }
    
    new slot = VehicleToPrivateSlot[vehicleid];
    
    if (slot == -1 || PrivateVeh[slot][pvOwner][0] == '\0')
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Това не е лично превозно средство!");
    }
    
    new playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    
    if (strcmp(PrivateVeh[slot][pvOwner], playername, true) != 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Това не е твоето превозно средство!");
    }
    
    new color1, color2;
    if (sscanf(params, "dd", color1, color2))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /vehcolor [цвят1] [цвят2]");
        return 1;
    }
    
    if (color1 < 0 || color1 > 255 || color2 < 0 || color2 > 255)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Цветовете трябва да са от 0 до 255!");
        return 1;
    }
    
    PrivateVehSetColor(slot, color1, color2);
    ChangeVehicleColor(vehicleid, color1, color2);
    
    printf("[vehcolor] Играч %s промени цвета на колата си (Slot=%d, VehicleID=%d) на (%d,%d)",
        playername, slot, vehicleid, color1, color2);
    
    SendClientMessage(playerid, 0xB8860BFF, "Ти промени цвета на твоето превозно средство!");
    
    return 1;
}