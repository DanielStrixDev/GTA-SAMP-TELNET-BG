CMD:vehres(playerid, params[])
{
    new haveprivate = 0;
    for (new alv = 1; alv < MAX_PRIVATEVEHS; alv++)
    {
        if (strcmp(PrivateVeh[alv][pvOwner], GetPlayerNickname(playerid), true) == 0)
        {
            SetVehicleToRespawn(PrivateVeh[alv][pvID]);
            haveprivate = 1;
        }
    }
    if (haveprivate == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш лично превозно средство!");
    format(string256, 256, "Own Vehicle: Ти respawn-на твоите лични превозни средства!");
    SendClientMessage(playerid, 0xB8860BFF, string256);
    return 1;
}
CMD:vehnorespawn(playerid, params[])
{
    new vehiclestring[64];
    new haveprivate = 0;
    new inveh = 0;
    for (new alv = 1; alv < MAX_PRIVATEVEHS; alv++)
    {
        if (strcmp(PrivateVeh[alv][pvOwner], GetPlayerNickname(playerid), true) == 0)
        {
            haveprivate = 1;
            if (IsPlayerInVehicle(playerid, PrivateVeh[alv][pvID]))
            {
                PrivateVehSetRespawn(alv, -1);
                inveh = 1;
            }
        }
    }
    if (haveprivate == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш лично превозно средство!");
    if (inveh == 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в своето превозно средство!");
    }
    SendClientMessage(playerid, 0xB8860BFF, "Ти сложи NO RESPAWN на твоето превозно средство!");
    SendClientMessage(playerid, 0xB8860BFF, "SERVER: Превозното средство ще бъде NO RESPAWN след рестартиране на сървъра!");
    return 1;
}


CMD:vehsave(playerid, params[])
{
    new haveprivate = 0;
    new inveh = 0;
    new vehiclestring[64];
    new Float:angleveh;
    GetVehicleZAngle(GetPlayerVehicleID(playerid), angleveh);
    new Float:vehx, Float:vehy, Float:vehz;
    new saveli = 0;
    GetVehiclePos(GetPlayerVehicleID(playerid), vehx, vehy, vehz);
    for (new alv = 1; alv < MAX_PRIVATEVEHS; alv++) //MAX_PRIVATEVEHS
    {
        if (strcmp(PrivateVeh[alv][pvOwner], GetPlayerNickname(playerid), true) == 0)
        {
            haveprivate = 1;
            if (IsPlayerInVehicle(playerid, PrivateVeh[alv][pvID]))
            {
                PrivateVehSetPos(alv, vehx, vehy, vehz, angleveh);
                inveh = 1;
            }
        }
    }
    if (haveprivate == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш лично превозно средство!");
    if (inveh == 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в своето превозно средство!");
    SendClientMessage(playerid, 0xBFFF80FF, "Новата позиция на твоето превозно средство ще бъде валидна след рестарт!");
    return 1;
}
CMD:respawnv(playerid, params[])
{
    if (GetPlayerVehicleID(playerid) < 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в превозно средство!");
    if (PlayerInfo[playerid][pAdmin] >= 5)
    {
        SetVehicleToRespawn(GetPlayerVehicleID(playerid));
    }
    else
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Нямаш права за да ползваш командата!");
    }
    return 1;
}
CMD:vehrespawn(playerid, params[])
{
    // Check if player has private vehicle
    new hasPrivateVehicle = 0;
    for (new i = 1; i < MAX_PRIVATEVEHS; i++)
    {
        if (strcmp(PrivateVeh[i][pvOwner], GetPlayerNickname(playerid), true) == 0)
        {
            hasPrivateVehicle = 1;
            break;
        }
    }
    
    if (!hasPrivateVehicle)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш лично превозно средство!");
        return 1;
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
    
    // Find and update the vehicle the player is in
    new inVehicle = 0;
    new currentVehicle = GetPlayerVehicleID(playerid);
    
    for (new i = 1; i < MAX_PRIVATEVEHS; i++)
    {
        if (strcmp(PrivateVeh[i][pvOwner], GetPlayerNickname(playerid), true) == 0)
        {
            if (currentVehicle == PrivateVeh[i][pvID])
            {
                PrivateVehSetRespawn(i, seconds);
                inVehicle = 1;
                break;
            }
        }
    }
    
    if (!inVehicle)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в своето превозно средство!");
        return 1;
    }
    
    SendClientMessage(playerid, 0xB8860BFF, "Ти сложи време за Respawn на твоето превозно средство!");
    SendClientMessage(playerid, 0xB8860BFF, "SERVER: Превозното средство ще бъде с времето за RESPAWN след рестартиране на сървъра!");
    
    return 1;
}

CMD:vehcolor(playerid, params[])
{
    new color1, color2;
    if (sscanf(params, "dd", color1, color2))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /vehcolor [color 1] [color 2]");
        return 1;
    }
    
    if (color1 < 0 || color1 > 255 || color2 < 0 || color2 > 255)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Цветовете трябва да са от 0 до 255!");
        return 1;
    }
    
    // Check if player has private vehicle
    new hasPrivateVehicle = 0;
    new inOwnVehicle = 0;
    new currentVehicle = GetPlayerVehicleID(playerid);
    
    for (new i = 1; i < MAX_PRIVATEVEHS; i++)
    {
        if (strcmp(PrivateVeh[i][pvOwner], GetPlayerNickname(playerid), true) == 0)
        {
            hasPrivateVehicle = 1;
            
            if (currentVehicle == PrivateVeh[i][pvID])
            {
                inOwnVehicle = 1;
                PrivateVehSetColor(i, color1, color2);
                ChangeVehicleColor(PrivateVeh[i][pvID], color1, color2);
                break;
            }
        }
    }
    
    if (!hasPrivateVehicle)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш лично превозно средство!");
        return 1;
    }
    
    if (!inOwnVehicle)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си в своето превозно средство!");
        return 1;
    }
    
    SendClientMessage(playerid, 0xB8860BFF, "Ти промени цвета на твоето превозно средство!");
    
    return 1;
}

