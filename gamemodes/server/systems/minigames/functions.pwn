#include <YSI_Coding\y_hooks>

stock IsInMinigame(playerid)
{
    if (isDerbyPlayer[playerid])
    {
        return true;
    }

    return false;
}

stock PlayerJoinDerby(playerid, type)
{
    new stringDerby[256];
    if (type == 1)
    {
        format(stringDerby, 256, "Derby: %s влезе в играта - /derbyon", GetPlayerNickname(playerid));
        SendClientMessageToAll(0xE5503BFF, stringDerby);
        isDerbyPlayer[playerid] = true;
        derbyPlayersCount += 1;
        SetPlayerColor(playerid, 0x5f580eFF);

        if (derbyPlayersCount == 2)
        {
            SendClientMessageToAll(0xE5503BFF, "Derby: Дербито ще започне след 60 секунди.");
            derbyStartTimer = 60;
        }
        if (derbyPlayersCount == 10)
        {
            SendClientMessageToAll(0xE5503BFF, "Derby: В дербито се събраха 10 човека и ще започне след 10 секунди.");
            derbyStartTimer = 10;
        }
    }
    SetDerbyPlayerToPos(playerid, derbyPlayersCount, type);
}

stock SetDerbyPlayerToPos(playerid, position, type)
{
    if (derbyJoinPos[0] == 0 && type == 1)
    {
        SetVehicleVirtualWorld(derbytypecar1[1], 3);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 3);
        PutPlayerInVehicle(playerid, derbytypecar1[1], 0);
        TogglePlayerControllable(playerid, 0);
        derbyJoinPos[0] = 1;
        playerDerbyPosition[playerid] = 0;
    }
    else if (derbyJoinPos[1] == 0 && type == 1)
    {
        SetVehicleVirtualWorld(derbytypecar1[2], 3);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 3);
        PutPlayerInVehicle(playerid, derbytypecar1[2], 0);
        TogglePlayerControllable(playerid, 0);
        derbyJoinPos[1] = 1;
        playerDerbyPosition[playerid] = 1;
    }
    else if (derbyJoinPos[2] == 0 && type == 1)
    {
        SetVehicleVirtualWorld(derbytypecar1[3], 3);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 3);
        PutPlayerInVehicle(playerid, derbytypecar1[3], 0);
        TogglePlayerControllable(playerid, 0);
        derbyJoinPos[2] = 1;
        playerDerbyPosition[playerid] = 2;
    }
    else if (derbyJoinPos[3] == 0 && type == 1)
    {
        SetVehicleVirtualWorld(derbytypecar1[4], 3);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 3);
        PutPlayerInVehicle(playerid, derbytypecar1[4], 0);
        TogglePlayerControllable(playerid, 0);
        derbyJoinPos[3] = 1;
        playerDerbyPosition[playerid] = 3;
    }
    else if (derbyJoinPos[4] == 0 && type == 1)
    {
        SetVehicleVirtualWorld(derbytypecar1[5], 3);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 3);
        PutPlayerInVehicle(playerid, derbytypecar1[5], 0);
        TogglePlayerControllable(playerid, 0);
        derbyJoinPos[4] = 1;
        playerDerbyPosition[playerid] = 4;
    }
    else if (derbyJoinPos[5] == 0 && type == 1)
    {
        SetVehicleVirtualWorld(derbytypecar1[6], 3);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 3);
        PutPlayerInVehicle(playerid, derbytypecar1[6], 0);
        TogglePlayerControllable(playerid, 0);
        derbyJoinPos[5] = 1;
        playerDerbyPosition[playerid] = 5;
    }
    else if (derbyJoinPos[6] == 0 && type == 1)
    {
        SetVehicleVirtualWorld(derbytypecar1[7], 3);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 3);
        PutPlayerInVehicle(playerid, derbytypecar1[7], 0);
        TogglePlayerControllable(playerid, 0);
        derbyJoinPos[6] = 1;
        playerDerbyPosition[playerid] = 6;
    }
    else if (derbyJoinPos[7] == 0 && type == 1)
    {
        SetVehicleVirtualWorld(derbytypecar1[8], 3);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 3);
        PutPlayerInVehicle(playerid, derbytypecar1[8], 0);
        TogglePlayerControllable(playerid, 0);
        derbyJoinPos[7] = 1;
        playerDerbyPosition[playerid] = 7;
    }
    else if (derbyJoinPos[8] == 0 && type == 1)
    {
        SetVehicleVirtualWorld(derbytypecar1[9], 3);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 3);
        PutPlayerInVehicle(playerid, derbytypecar1[9], 0);
        TogglePlayerControllable(playerid, 0);
        derbyJoinPos[8] = 1;
        playerDerbyPosition[playerid] = 8;
    }
    else if (derbyJoinPos[9] == 0 && type == 1)
    {
        SetVehicleVirtualWorld(derbytypecar1[10], 3);
        SetPlayerInterior(playerid, 0);
        SetPlayerVirtualWorld(playerid, 3);
        PutPlayerInVehicle(playerid, derbytypecar1[10], 0);
        TogglePlayerControllable(playerid, 0);
        derbyJoinPos[9] = 1;
        playerDerbyPosition[playerid] = 9;
    }

    new vehicleid = GetPlayerVehicleID(playerid);
    SetVehicleHealth(vehicleid, 1000);
}

stock EndDerbyGame(timerEnd)
{
    derbyStartTimer = 0;
    derbyJoinTimer = 0;
    derbyEndTimer = 0;
    derbyPlayersCount = 0;
    derbyStarted = 0;
    derbyTimerToGame = 15 * 60;
}

stock KillDerbyPlayers()
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (isDerbyPlayer[i])
        {
            SetPlayerHealth(i, 0);
            ResetDerbyPosition(i);
            isDerbyPlayer[i] = false;
        }
    }
}

stock ResetDerbyPosition(playerid)
{
    new positionID = playerDerbyPosition[playerid];
    derbyJoinPos[positionID] = 0;
}

stock PlayerLeaveDerby(playerid)
{
    if (IsInMinigame(playerid))
    {
        if (isDerbyPlayer[playerid])
        {
            new stringDerby[256];
            derbyPlayersCount -= 1;
            if (derbyStarted)
            {
                if (derbyPlayersCount >= 3)
                {
                    SendClientMessage(playerid, 0xE5503BFF, "Derby: Ти отпадна от играта!");
                }
                else if (derbyPlayersCount == 2)
                {
                    GivePlayerEP(playerid, 3);
                    format(stringDerby, 256, "Derby: %s завърши на трето място в играта и печели 3 EP!", GetPlayerNickname(playerid));
                    SendClientMessageToAll(0xE5503BFF, stringDerby);
                }
                else if (derbyPlayersCount == 1)
                {
                    GivePlayerEP(playerid, 4);
                    format(stringDerby, 256, "Derby: %s завърши на второ място в играта и печели 4 EP!", GetPlayerNickname(playerid));
                    SendClientMessageToAll(0xE5503BFF, stringDerby);
                    KillDerbyPlayers();
                }
                else if (derbyPlayersCount == 0)
                {
                    GivePlayerEP(playerid, 5);
                    format(stringDerby, 256, "Derby: Победителят в играта е %s и той/тя печели 5 EP!", GetPlayerNickname(playerid));
                    SendClientMessageToAll(0xE5503BFF, stringDerby);
                    SendClientMessageToAll(0xE5503BFF, "Derby: Играта свърши, след 15 минути ще бъде стартирана нова!");
                    EndDerbyGame(false);
                }
            }
            else
            {
                if (derbyPlayersCount == 1)
                {
                    SendClientMessageToAll(0xE5503BFF, "Derby: Дербито остана с 1 играч и няма да стартира!");
                    derbyStartTimer = 0;
                }
            }
            ResetDerbyPosition(playerid);
            isDerbyPlayer[playerid] = false;
            SetPlayerHealth(playerid, 0);
        }
    }
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
    if (isDerbyPlayer[playerid])
    {
        SendClientMessage(playerid, 0xE5503BFF, "Derby: Не можеш да излезеш от превозното средство, докато си в дербито!");
        new Float:cx, Float:cy, Float:cz;
        GetPlayerPos(playerid, cx, cy, cz);
        SetPlayerPos(playerid, cx, cy, cz);
        PutPlayerInVehicle(playerid, vehicleid, 0);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

/*
* On player death
*/
hook OnPlayerDeath(playerid, killerid, reason)
{
    if (IsInMinigame(playerid))
    {
        if (isDerbyPlayer[playerid])
        {
            PlayerLeaveDerby(playerid);
        }
    }
}