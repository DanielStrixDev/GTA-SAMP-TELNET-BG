#include <YSI_Coding\y_hooks>


hook OnPlayerText(playerid, text[])
{
    printf("[say] %s(id:%d): %s", GetPlayerNickname(playerid), playerid, text);
    if (cbchat[playerid] > 0 && PlayerInfo[playerid][pOrganisator] == 0)
    {
        format(string256, 256, "[CB: %d] %s(%d): %s", cbchat[playerid], GetPlayerNickname(playerid), playerid, text[0]);
        for (new i; i < MAX_PLAYERS; i++)
        {
            if (cbchat[i] == cbchat[playerid] || PlayerInfo[i][pTogCB] == 1)
            {
                SendClientMessage(i, 0xFF9933FF, string256);
                return Y_HOOKS_BREAK_RETURN_0;
            }
        }
    }
    if (cbchat[playerid] > 0 && PlayerInfo[playerid][pOrganisator] == 1)
    {
        format(string256, 256, "[CB: %d] %s(%d): {FF0000}%s", cbchat[playerid], GetPlayerNickname(playerid), playerid, text[0]);
        for (new i; i < MAX_PLAYERS; i++)
        {
            if (cbchat[i] == cbchat[playerid] || PlayerInfo[i][pTogCB] == 1)
            {
                SendClientMessage(i, 0xFF9933FF, string256);
                return Y_HOOKS_BREAK_RETURN_0;
            }
        }
    }
}
