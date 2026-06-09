#include <YSI_Coding\y_hooks>

stock RemoveDuelCount(playerid)
{
    new playerAgainst = duelprotivnik[playerid];

    PlayerInfo[playerAgainst][pDuelCountTimer] = 0;
    PlayerInfo[playerAgainst][pDuelCountTimer2] = 0;
    PlayerInfo[playerAgainst][pDuelCountTimer3] = 0;
    PlayerInfo[playerAgainst][pDuelCountTimer4] = 0;
    PlayerInfo[playerid][pDuelCountTimer] = 0;
    PlayerInfo[playerid][pDuelCountTimer2] = 0;
    PlayerInfo[playerid][pDuelCountTimer3] = 0;
    PlayerInfo[playerid][pDuelCountTimer4] = 0;
}

stock SetPlayerToBeforeDuelPos(playerid)
{
    new playerAgainst = duelprotivnik[playerid];

    SetPlayerPos(playerAgainst, prediduelX[playerAgainst], prediduelY[playerAgainst], prediduelZ[playerAgainst]);
    SetPlayerHealth(playerAgainst, prediduelhealth[playerAgainst]);
    SetPlayerArmour(playerAgainst, prediduelarmour[playerAgainst]);
    SetPlayerInterior(playerAgainst, prediduelinterior[playerAgainst]);
    SetPlayerVirtualWorld(playerAgainst, prediduelvw[playerAgainst]);
}

stock GivePlayerDuelMoney(playerid)
{
    new playerAgainst = duelprotivnik[playerid];
    new betMoney = duelzalog[playerid];

    GivePlayerCash(playerid, -betMoney);
    GivePlayerCash(playerAgainst, betMoney);
}

stock RemoveDuelVars(playerid)
{
    new playerAgainst = duelprotivnik[playerid];
    
    duelzalog[playerid] = 0;
    duelzalog[playerAgainst] = 0;
    duelsend[playerid] = -1;
    duelsend[playerAgainst] = -1;
    playerInDuel[playerAgainst] = 0;
    playerInDuel[playerid] = 0;
    duelsender[playerid] = -1;
    duelsender[playerAgainst] = -1;
    duelprotivnik[playerAgainst] = -1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    if (playerInDuel[playerid] == 1)
    {
        new playerAgainst = duelprotivnik[playerid];
        new betMoney = duelzalog[playerid];
        new stringduel[256];

        GameTextForPlayer(playerAgainst, "~g~WINNER", 5000, 3);
        format(stringduel, 256, "Ти спечели дуела срещу %s и получаваш $%d от залога.", GetPlayerNickname(playerid), betMoney);
        SendClientMessage(playerAgainst, 0xFFE400FF, stringduel);
        format(stringduel, 256, "Ти загуби дуела срещу %s и загуби $%d от залога.", GetPlayerNickname(playerAgainst), betMoney);
        SendClientMessage(playerid, 0xFFE400FF, stringduel);
        RemoveDuelCount(playerid);
        SetPlayerToBeforeDuelPos(playerid);
        RestartPlayerColor(playerAgainst);
        RemoveDuelVars(playerid);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}