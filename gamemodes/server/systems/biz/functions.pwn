#include <YSI_Coding\y_hooks>

/*
* Pickup
*/
public RemoveBizPick(playerid)
{
    onbizpick2[playerid] = 0;
    if (onbizpick2[playerid] == 0)
    {
        KillTimer(biztimer[playerid]);
        isinbizpickup[playerid] = 0;
    }
    playerInBizPickup[playerid] = 0;
}

/*
* Exit
*/
stock CheckPlayerExitBiz(playerid)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    new vw = GetPlayerVirtualWorld(playerid);
    new bizid = vw - 500;

    //
    if (IsPlayerInRangeOfPoint(playerid, 3, -27.3025, -57.6649, 1003.5469) ||
            IsPlayerInRangeOfPoint(playerid, 3, 501.980987, -69.150199, 998.757812) ||
            IsPlayerInRangeOfPoint(playerid, 3, -2026.9447, -103.6024, 1035.1832) ||
            IsPlayerInRangeOfPoint(playerid, 3, 296.8089, -112.0065, 1001.5156) ||
            IsPlayerInRangeOfPoint(playerid, 3, 1260.6464, -785.4418, 1091.9063) ||
            IsPlayerInRangeOfPoint(playerid, 3, -27.3512, -31.7518, 1003.5573) ||
            IsPlayerInRangeOfPoint(playerid, 3, 207.054992, -138.804992, 1003.507812) ||
            IsPlayerInRangeOfPoint(playerid, 3, 1494.4723, 1303.5813, 1093.2891) ||
            IsPlayerInRangeOfPoint(playerid, 3, 362.8670, -75.1642, 1001.5078) ||
            IsPlayerInRangeOfPoint(playerid, 3, 834.6642, 7.5311, 1004.1870) ||
            IsPlayerInRangeOfPoint(playerid, 3, -25.9455, -141.5480, 1003.5469) ||
            IsPlayerInRangeOfPoint(playerid, 3, 203.7447, -50.6649, 1001.8047) ||
            IsPlayerInRangeOfPoint(playerid, 3, 285.9084, -86.7750, 1001.5229) ||
            IsPlayerInRangeOfPoint(playerid, 3, 315.7523, -143.6341, 999.6016) ||
            IsPlayerInRangeOfPoint(playerid, 3, 493.4793, -24.9576, 1000.6719) ||
            IsPlayerInRangeOfPoint(playerid, 3, 744.6210, 1436.3411, 1102.7031) ||
            IsPlayerInRangeOfPoint(playerid, 3, 773.9693, -78.8193, 1000.6628) ||
            IsPlayerInRangeOfPoint(playerid, 3, 774.1560, -50.4766, 1000.5859) ||
            IsPlayerInRangeOfPoint(playerid, 3, 1133.2222, -15.8171, 1000.6797) ||
            IsPlayerInRangeOfPoint(playerid, 3, 1204.7975, -13.8216, 1000.9219) ||
            IsPlayerInRangeOfPoint(playerid, 3, 1306.8253, 3.2698, 1001.0272) ||
            IsPlayerInRangeOfPoint(playerid, 3, 2018.6144, 1017.7792, 996.8750) ||
            IsPlayerInRangeOfPoint(playerid, 3, 2234.1011, 1714.4489, 1012.3828) ||
            IsPlayerInRangeOfPoint(playerid, 3, -229.1534, 1401.3180, 27.7656) ||
            IsPlayerInRangeOfPoint(playerid, 3, 377.0852, -193.3047, 1000.6328) ||
            IsPlayerInRangeOfPoint(playerid, 3, 364.9964, -11.8438, 1001.8516) ||
            IsPlayerInRangeOfPoint(playerid, 3, 460.5563, -88.6419, 999.5547) ||
            IsPlayerInRangeOfPoint(playerid, 3, 1727.7561, -1638.0088, 20.2230) ||
            IsPlayerInRangeOfPoint(playerid, 3, 2541.9399, -1304.0100, 1025.0703) ||
            IsPlayerInRangeOfPoint(playerid, 3, -1395.4200, 1245.6000, 1039.8672))
    {
        if (GetPlayerVirtualWorld(playerid) == bizid + 500)
        {
            if (BizInfo[bizid][bLocked] == 1)
            {
                GameTextForPlayer(playerid, "locked", 3000, 1);
                return SendClientMessage(playerid, 0x499BD4FF, "Бизнесът е заключен и не можеш да излезеш !");
            }
            SetPlayerPos(playerid, BizInfo[bizid][bX], BizInfo[bizid][bY], BizInfo[bizid][bZ]);
            SetPlayerInterior(playerid, 0);
            SetCameraBehindPlayer(playerid);
            SetPlayerVirtualWorld(playerid, 0);
        }
    }
}

/*
* Is valid biz
*/
stock IsValidBiz(bizid)
{
    //if (bizid < 0) return false;
    if (BizInfo[bizid][bType] >= 1)
    {
        return true;
    }

    return false;
}

/*
* Is Player Near Biz
*/
stock IsPlayerNearBiz(playerid)
{
    new alb = playerInBizPickup[playerid];
    if (IsValidBiz(alb))
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, BizInfo[alb][bX], BizInfo[alb][bY], BizInfo[alb][bZ]))
        {
            return alb;
        }
    }
    return -1;
}

/*
* Hook
*/
hook OnPlayerEnterCheckpoint(playerid)
{
    if (PlayerInfo[playerid][pBizO] > -1)
    {
        gpsOn[playerid] = false;
        new playersBiz = PlayerInfo[playerid][pBizO];
        new Float: playerBizX = BizInfo[playersBiz][bX];
        new Float: playerBizY = BizInfo[playersBiz][bY];
        new Float: playerBizZ = BizInfo[playersBiz][bZ];
        if (IsPlayerInRangeOfPoint(playerid, 4.0, playerBizX, playerBizY, playerBizZ))
        {
            SendClientMessage(playerid, 0xffff00FF, "Ти пристигна до твоя бизнес!");
            DisablePlayerCheckpoint(playerid);
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}