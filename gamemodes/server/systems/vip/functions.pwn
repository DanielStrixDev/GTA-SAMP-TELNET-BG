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

stock SetPlayerVipLabel(playerid)
{
    if (PlayerInfo[playerid][pVIPLabel] == 1)
    {
        UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, " ");
        format(VipText3D[playerid], 26, "");
        PlayerLabel[playerid] = CreateDynamic3DTextLabel(VipText3D[playerid], 0x800000FF, 0.0, 0.0, 0.0, 15.0, playerid, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), -1, 15.0);
    }
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

stock OnPlayerSpawnAsVIP(playerid)
{
    if (PlayerInfo[playerid][pVip] >= 4 || CheckFreeVIP() == 1)
    {
        SetPlayerArmour(playerid, 100);
    }
}