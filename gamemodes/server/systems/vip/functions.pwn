#include <YSI_Coding\y_hooks>

stock CheckFreeVIP()
{
    if (freevip == 1)
    {
        new y, m, d;
        getdate(y, m, d);

        if ((y > freevip_end_year) ||
            (y == freevip_end_year && m > freevip_end_month) ||
            (y == freevip_end_year && m == freevip_end_month && d >= freevip_end_day))
        {
            return 1;
        }
        return 1;
    }
    return 0;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    if (PlayerInfo[playerid][pVip] == 0)
    {
        GivePlayerCash(playerid, -100);
    }
    if (PlayerInfo[playerid][pVip] > 0 || CheckFreeVIP() == 1)
    {
        GivePlayerCash(playerid, -50);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}