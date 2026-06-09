#include <YSI_Coding\y_hooks>

stock IsPlayerInRobPlace(playerid)
{
    if (IsPlayerInRangeOfPoint(playerid, 7, ROB_CALIGULA_COORS) && robberyPlace == ROB_CALIGULA) return true;
    if (IsPlayerInRangeOfPoint(playerid, 7, ROB_ARTIUM_COORS) && robberyPlace == ROB_ARTIUM) return true;
    if (IsPlayerInRangeOfPoint(playerid, 7, ROB_BOAT_COORS) && robberyPlace == ROB_BOAT) return true;
    return false;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    if (PlayerInfo[playerid][pRobberLead] == 1)
    {
        PlayerInfo[playerid][pRobber] = 0;
        PlayerInfo[playerid][pRobberLead] = 0;
        GameTextForPlayer(playerid, "   ", 1000, 3);
        for (new i; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pRobber] == 1)
            {
                GameTextForPlayer(i, "   ", 1000, 3);
                PlayerInfo[i][pRobber] = 0;
            }
        }
        robberyMembers = 0;
        robCollectedMoney = 0;
        startedrob = 0;
        robberyTimerToCollect = 0;
        robberyPlace = 0;
        robberyToStopTimer = 0;
        SendClientMessage(playerid, 0xFF8200FF, "Robbery: Ти беше убит и обирът е прекратен !");
        SendClientMessageToAll(0xFF8200FF, "Robbery: Обирът се спира автоматично, защото лидерът беше убит !");
    }
    if (PlayerInfo[playerid][pRobberLead] == 0 && PlayerInfo[playerid][pRobber] == 1)
    {
        PlayerInfo[playerid][pRobber] = 0;
        GameTextForPlayer(playerid, "   ", 1000, 3);
        robberyMembers -= 1;
        SendClientMessage(playerid, 0xFF8200FF, "Robbery: Ти беше убит и си отстранен от обира !");
    }
    
    return Y_HOOKS_CONTINUE_RETURN_1;
}