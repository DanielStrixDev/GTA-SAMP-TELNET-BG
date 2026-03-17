CMD:robbery(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 4, 2145.2324, 2834.2690, 10.8203) && !IsPlayerInRangeOfPoint(playerid, 4, 2447.8630, -1963.3013, 13.5469))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си на място за започване на обир!");
        return CMD_SUCCESS;
    }
    
    if (isnull(params))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /robbery [start/end/invite/kick/leave/check]");
        return CMD_SUCCESS;
    }
    
    new action[32];
    if (sscanf(params, "s[32]", action))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /robbery [start/end/invite/kick/leave/check]");
        return CMD_SUCCESS;
    }
    
    if (strcmp(action, "check", true) == 0)
    {
        if (startedrob == 0)
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Можеш да стартираш обир още сега!");
        }
        else
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "В момента има обир!");
        }
        return CMD_SUCCESS;
    }
    
    if (strcmp(action, "leave", true) == 0)
    {
        if (PlayerInfo[playerid][pRobber] == 1)
        {
            if (robCollectedMoney > 0)
            {
                SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да напуснеш обира, след като той е почнал!");
            }
            else
            {
                if (PlayerInfo[playerid][pRobberLead] == 1)
                {
                    SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да напуснеш обира, защото си негов лидер!");
                    return CMD_SUCCESS;
                }
                
                new stringrobbery[128];
                format(stringrobbery, sizeof(stringrobbery), "Robbery: %s напусна обира.", GetPlayerNickname(playerid));
                
                for (new i = 0; i < MAX_PLAYERS; i++)
                {
                    if (PlayerInfo[i][pRobber] == 1 || PlayerInfo[i][pRobberLead] == 1)
                    {
                        SendClientMessage(i, 0xFF8200FF, stringrobbery);
                    }
                }
                PlayerInfo[playerid][pRobber] = 0;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Ти не си участник в обира!");
        }
        return CMD_SUCCESS;
    }
    
    if (strcmp(action, "kick", true) == 0)
    {
        if (PlayerInfo[playerid][pRobberLead] == 0)
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Ти не си лидер на обир!");
            return CMD_SUCCESS;
        }
        
        new targetid;
        if (sscanf(params, "s[32]u", action, targetid))
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /robbery kick [playerid]");
            return CMD_SUCCESS;
        }
        
        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Посоченото ID не е в сървъра!");
            return CMD_SUCCESS;
        }
        
        if (targetid == playerid)
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да изгониш себе си от обира!");
            return CMD_SUCCESS;
        }
        
        if (PlayerInfo[targetid][pRobber] == 0)
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Този играч не участва в обира!");
            return CMD_SUCCESS;
        }
        
        new stringrobbery[128];
        format(stringrobbery, sizeof(stringrobbery), "Robbery: %s изгони %s от обира.", GetPlayerNickname(playerid), GetPlayerNickname(targetid));
        
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pRobber] == 1 || PlayerInfo[i][pRobberLead] == 1)
            {
                SendClientMessage(i, 0xFF8200FF, stringrobbery);
            }
        }
        
        PlayerInfo[targetid][pRobber] = 0;
        robberyMembers--;
        return CMD_SUCCESS;
    }
    
    if (strcmp(action, "invite", true) == 0)
    {
        if (PlayerInfo[playerid][pRobberLead] == 0)
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Ти не си лидер на обир!");
            return CMD_SUCCESS;
        }
        
        new targetid;
        if (sscanf(params, "s[32]u", action, targetid))
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /robbery invite [playerid]");
            return CMD_SUCCESS;
        }
        
        if (!IsPlayerConnected(targetid))
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Посоченото ID не е в сървъра!");
            return CMD_SUCCESS;
        }
        
        if (PlayerInfo[targetid][pRobber] == 1)
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Този играч вече участва в обира!");
            return CMD_SUCCESS;
        }
        
        if (!CorDetector(4.0, playerid, targetid))
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Този играч не е близо до теб!");
            return CMD_SUCCESS;
        }
        
        if (PlayerInfo[targetid][pIFCDuty] == 1)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Този играч е IFC ON-DUTY!");
            return CMD_SUCCESS;
        }
        
        if (PlayerInfo[targetid][pADuty] == 1)
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Този играч е ADMIN ON-DUTY!");
            return CMD_SUCCESS;
        }
        
        new stringrobbery[128];
        format(stringrobbery, sizeof(stringrobbery), "Robbery: %s вкара %s в обира.", GetPlayerNickname(playerid), GetPlayerNickname(targetid));
        
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pRobber] == 1 || PlayerInfo[i][pRobberLead] == 1)
            {
                SendClientMessage(i, 0xFF8200FF, stringrobbery);
            }
        }
        
        PlayerInfo[targetid][pRobber] = 1;
        robberyMembers++;
        SetPlayerSkin(targetid, 25);
        return CMD_SUCCESS;
    }
    
    if (strcmp(action, "start", true) == 0)
    {
        if (PlayerInfo[playerid][pIFCDuty] == 1)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си IFC ON-DUTY!");
            return CMD_SUCCESS;
        }
        
        if (PlayerInfo[playerid][pADuty] == 1)
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да започнеш обир като ADMIN ON-DUTY!");
            return CMD_SUCCESS;
        }
        
        if (robberyMembers > 0)
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Вече има започнат обир!");
            return CMD_SUCCESS;
        }
        
        if (robberyTimeToStartAgain != 0)
        {
            SendClientMessage(playerid, COLOR_GRAD1, "Трябва да изчакаш да мине времето за правене на нов обир!");
            return CMD_SUCCESS;
        }
        
        PlayerInfo[playerid][pRobber] = 1;
        PlayerInfo[playerid][pRobberLead] = 1;
        robberyMembers = 1;
        robCollectedMoney = 0;
        startedrob = 1;
        SetPlayerSkin(playerid, 24);
        robberyTimerRobberToStart = 15 * 60;
        
        SendClientMessage(playerid, 0xFF8200FF, "Robbery: Ти започна обир, намери място където да крадеш !");
        SendClientMessage(playerid, 0xFF8200FF, "Robbery: Имаш 15 минути да намериш място за крадене !");
        return CMD_SUCCESS;
    }
    
    if (strcmp(action, "end", true) == 0)
    {
        if (PlayerInfo[playerid][pRobberLead] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си лидер на обир!");
            return CMD_SUCCESS;
        }
        
        SendClientMessageToAll(0xFF8200FF, "Robbery: Лидерът на обира го прекрати !");
        
        if (robCollectedMoney == 0)
        {
            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                if (PlayerInfo[i][pRobber] == 1)
                {
                    PlayerInfo[i][pRobber] = 0;
                    new stringrobbery[128];
                    format(stringrobbery, sizeof(stringrobbery), "Robbery: Ти получи своя дял от обира - $%d.", robCollectedMoney / robberyMembers);
                    SendClientMessage(i, 0xFF8200FF, stringrobbery);
                    GivePlayerCash(i, robCollectedMoney / robberyMembers);
                }
            }
            PlayerInfo[playerid][pRobberLead] = 0;
            robberyMembers = 0;
        }
        
        if (robCollectedMoney > 0)
        {
            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                if (PlayerInfo[i][pRobber] == 1)
                {
                    PlayerInfo[i][pRobber] = 0;
                }
            }
            PlayerInfo[playerid][pRobberLead] = 0;
            robberyMembers = 0;
            robCollectedMoney = 0;
        }
        
        robberyTimeToStartAgain = 30 * 60;
        return CMD_SUCCESS;
    }
    
    SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /robbery [start/end/invite/kick/leave/check]");
    return CMD_SUCCESS;
}

CMD:rob(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 4, ROB_CALIGULA_COORS) && !IsPlayerInRangeOfPoint(playerid, 4, ROB_ARTIUM_COORS) && !IsPlayerInRangeOfPoint(playerid, 4, ROB_BOAT_COORS))
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си на място за обир!");
        return 1;
    }
    if (PlayerInfo[playerid][pRobberLead] == 0)
    {
        return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си лидер за да започнеш обир!");
    }
    if (robberyMembers < 2 && scripterMode[playerid] == 0)
    {
        return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да има още един участник в обира!");
    }
    if (robCollectedMoney > 10)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Обирът вече е започнат!");
        return 1;
    }
    if (IsPlayerInRangeOfPoint(playerid, 4, ROB_CALIGULA_COORS))
    {
        robberyPlace = ROB_CALIGULA;
        SendClientMessage(playerid, 0xFF8200FF, "Robbery: Някой се опитва да ограби Caligula's Casino, отиди и го спри!");
    }
    if (IsPlayerInRangeOfPoint(playerid, 4, ROB_ARTIUM_COORS))
    {
        robberyPlace = ROB_ARTIUM;
        SendClientMessage(playerid, 0xFF8200FF, "Robbery: Някой се опитва да ограби Atrium, отиди и го спри !");
    }
    if (IsPlayerInRangeOfPoint(playerid, 4, ROB_BOAT_COORS))
    {
        robberyPlace = ROB_BOAT;
        SendClientMessage(playerid, 0xFF8200FF, "Robbery: Някой се опитва да ограби кораба в San Fierro, отиди и го спри !");
    }
    robCollectedMoney = 70;
    robberyTimerToCollect = 2;
    robberyTimerRobberToStart = 0;
    return 1;
}
