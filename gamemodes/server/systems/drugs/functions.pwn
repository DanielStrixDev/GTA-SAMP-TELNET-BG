#include <YSI_Coding\y_hooks>

stock ResetPlayerDrugs(playerid)
{
    PlayerInfo[playerid][pMoonshineEffectTime] = 0;
    PlayerInfo[playerid][pWeed] = 0;
    PlayerInfo[playerid][pCocaine] = 0;
    PlayerInfo[playerid][pHeroin] = 0;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    if (PlayerInfo[playerid][pMoonshineEffectTime] > 0 || PlayerInfo[playerid][pWeed] > 0 || PlayerInfo[playerid][pCocaine] > 0 || PlayerInfo[playerid][pHeroin] > 0)
    {
        ResetPlayerDrugs(playerid);
        SetPlayerWeather(playerid, 1);
    }
    if (killerid != INVALID_PLAYER_ID && killerid != playerid)
    {
        LoseDrugs(playerid, killerid);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}