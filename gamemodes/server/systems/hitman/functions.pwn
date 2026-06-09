#include <YSI_Coding\y_hooks>

hook OnPlayerDeath(playerid, killerid, reason)
{
    if (hitmanby[playerid] != -1)
    {
        new hitmanstring[256];
        format(hitmanstring, 256, "Hitman: %s уби %s и спечели $%d", GetPlayerNickname(killerid), GetPlayerNickname(playerid), hitmanprice[playerid]);
        SendClientMessageToAll(0xA4A400FF, hitmanstring);
        GivePlayerCash(killerid, hitmanprice[playerid]);
        hitmaner[hitmanby[playerid]] = -1;
        hitmanprice[playerid] = 0;
        hitmanby[playerid] = -1;
    }
    
    return Y_HOOKS_CONTINUE_RETURN_1;
}