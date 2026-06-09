#include <YSI_Coding\y_hooks>


/*
* Chat
*/
stock SendFMessage(playerid, string[])
{
    new TEAM = PlayerInfo[playerid][pTeam];
    for (new allPlayers = 0; allPlayers < MAX_PLAYERS; allPlayers++)
    {
        if (PlayerInfo[allPlayers][pTeam] == TEAM)
        {
            if (fignore[allPlayers][playerid] == allPlayers || PlayerInfo[allPlayers][pTogFaction])
            {
                continue;
            }
            if (PlayerInfo[playerid][pTeam] == FACTION_INTENSE_POLICE)
            {
                if (PlayerInfo[playerid][pDeltaForce])
                {
                    SendClientMessage(allPlayers, 0xA4A400FF, string);
                    continue;
                }
            }

            if (PlayerInfo[allPlayers][pRank] == 6)
            {
                SendClientMessage(allPlayers, 0x40BF00FF, string);
            }
            else
            {
                SendClientMessage(allPlayers, 0x33CCFFFF, string);
            }
        }
    }
}

stock SendFactionMessage(TEAM, color, string[])
{
    for (new allPlayers = 0; allPlayers < MAX_PLAYERS; allPlayers++)
    {
        if (PlayerInfo[allPlayers][pTeam] == TEAM)
        {
            SendClientMessage(allPlayers, color, string);
        }
    }
}

/*
* Rank Skins
*/
stock DefineGangRankSkins()
{
    gangRankSkin[FACTION_VIP][1] = 29;
    gangRankSkin[FACTION_VIP][2] = 126;
    gangRankSkin[FACTION_VIP][3] = 101;
    gangRankSkin[FACTION_VIP][4] = 100;
    gangRankSkin[FACTION_VIP][5] = 19;
    gangRankSkin[FACTION_VIP][6] = 186; // VIP GANG
    gangRankSkin[FACTION_GROVE][1] = 105;
    gangRankSkin[FACTION_GROVE][2] = 149;
    gangRankSkin[FACTION_GROVE][3] = 86;
    gangRankSkin[FACTION_GROVE][4] = 106;
    gangRankSkin[FACTION_GROVE][5] = 107;
    gangRankSkin[FACTION_GROVE][6] = 107; // GSF GANG
    gangRankSkin[FACTION_BALLAS][1] = 103;
    gangRankSkin[FACTION_BALLAS][2] = 103;
    gangRankSkin[FACTION_BALLAS][3] = 102;
    gangRankSkin[FACTION_BALLAS][4] = 102;
    gangRankSkin[FACTION_BALLAS][5] = 104;
    gangRankSkin[FACTION_BALLAS][6] = 104; // BALLAS GANG
    gangRankSkin[FACTION_VAGOS][1] = 109;
    gangRankSkin[FACTION_VAGOS][2] = 109;
    gangRankSkin[FACTION_VAGOS][3] = 110;
    gangRankSkin[FACTION_VAGOS][4] = 110;
    gangRankSkin[FACTION_VAGOS][5] = 108;
    gangRankSkin[FACTION_VAGOS][6] = 108; // VAGOS GANG
    gangRankSkin[FACTION_AZTECAS][1] = 114;
    gangRankSkin[FACTION_AZTECAS][2] = 116;
    gangRankSkin[FACTION_AZTECAS][3] = 114;
    gangRankSkin[FACTION_AZTECAS][4] = 116;
    gangRankSkin[FACTION_AZTECAS][5] = 116;
    gangRankSkin[FACTION_AZTECAS][6] = 115; // AZTECAS GANG
    gangRankSkin[FACTION_CRIPZ][1] = 177;
    gangRankSkin[FACTION_CRIPZ][2] = 176;
    gangRankSkin[FACTION_CRIPZ][3] = 156;
    gangRankSkin[FACTION_CRIPZ][4] = 176;
    gangRankSkin[FACTION_CRIPZ][5] = 21;
    gangRankSkin[FACTION_CRIPZ][6] = 21; // CRIPZ GANG
    gangRankSkin[FACTION_TRIADS][1] = 117;
    gangRankSkin[FACTION_TRIADS][2] = 117;
    gangRankSkin[FACTION_TRIADS][3] = 118;
    gangRankSkin[FACTION_TRIADS][4] = 117;
    gangRankSkin[FACTION_TRIADS][5] = 120;
    gangRankSkin[FACTION_TRIADS][6] = 120; // TRIADS GANG
    gangRankSkin[FACTION_RIFA][1] = 173;
    gangRankSkin[FACTION_RIFA][2] = 174;
    gangRankSkin[FACTION_RIFA][3] = 174;
    gangRankSkin[FACTION_RIFA][4] = 175;
    gangRankSkin[FACTION_RIFA][5] = 173;
    gangRankSkin[FACTION_RIFA][6] = 174; // RIFA GANG
    gangRankSkin[FACTION_SOA][1] = 73;
    gangRankSkin[FACTION_SOA][2] = 291;
    gangRankSkin[FACTION_SOA][3] = 247;
    gangRankSkin[FACTION_SOA][4] = 100;
    gangRankSkin[FACTION_SOA][5] = 248;
    gangRankSkin[FACTION_SOA][6] = 248; // SOA GANG
    gangRankSkin[FACTION_NANG][1] = 124;
    gangRankSkin[FACTION_NANG][2] = 121;
    gangRankSkin[FACTION_NANG][3] = 121;
    gangRankSkin[FACTION_NANG][4] = 122;
    gangRankSkin[FACTION_NANG][5] = 123;
    gangRankSkin[FACTION_NANG][6] = 123; // NANG GANG
    gangRankSkin[FACTION_ITALIAN][1] = 111;
    gangRankSkin[FACTION_ITALIAN][2] = 112;
    gangRankSkin[FACTION_ITALIAN][3] = 112;
    gangRankSkin[FACTION_ITALIAN][4] = 125;
    gangRankSkin[FACTION_ITALIAN][5] = 124;
    gangRankSkin[FACTION_ITALIAN][6] = 126; // ITALIAN GANG
    gangRankSkin[FACTION_BOUNTY][1] = 112;
    gangRankSkin[FACTION_BOUNTY][2] = 112;
    gangRankSkin[FACTION_BOUNTY][3] = 124;
    gangRankSkin[FACTION_BOUNTY][4] = 101;
    gangRankSkin[FACTION_BOUNTY][5] = 293;
    gangRankSkin[FACTION_BOUNTY][6] = 293; // BOUNTY GANG
    gangRankSkin[FACTION_THUGLIFE][1] = 80;
    gangRankSkin[FACTION_THUGLIFE][2] = 180;
    gangRankSkin[FACTION_THUGLIFE][3] = 126;
    gangRankSkin[FACTION_THUGLIFE][4] = 177;
    gangRankSkin[FACTION_THUGLIFE][5] = 293;
    gangRankSkin[FACTION_THUGLIFE][6] = 293; // Thug Life GANG
    gangRankSkin[FACTION_CREW][1] = 101;
    gangRankSkin[FACTION_CREW][2] = 101;
    gangRankSkin[FACTION_CREW][3] = 100;
    gangRankSkin[FACTION_CREW][4] = 125;
    gangRankSkin[FACTION_CREW][5] = 126;
    gangRankSkin[FACTION_CREW][6] = 126; // 119th Street Crew GANG
    gangRankSkin[FACTION_INTENSE_POLICE][1] = 287;
    gangRankSkin[FACTION_INTENSE_POLICE][2] = 287;
    gangRankSkin[FACTION_INTENSE_POLICE][3] = 287;
    gangRankSkin[FACTION_INTENSE_POLICE][4] = 287;
    gangRankSkin[FACTION_INTENSE_POLICE][5] = 287;
    gangRankSkin[FACTION_INTENSE_POLICE][6] = 287; // IPD GANG
    gangRankSkin[FACTION_SOLDIER][1] = 3;
    gangRankSkin[FACTION_SOLDIER][2] = 3;
    gangRankSkin[FACTION_SOLDIER][3] = 185;
    gangRankSkin[FACTION_SOLDIER][4] = 185;
    gangRankSkin[FACTION_SOLDIER][5] = 296;
    gangRankSkin[FACTION_SOLDIER][6] = 296; // SOLDIER GANG
    gangRankSkin[FACTION_YAKUZA][1] = 59;
    gangRankSkin[FACTION_YAKUZA][2] = 60;
    gangRankSkin[FACTION_YAKUZA][3] = 186;
    gangRankSkin[FACTION_YAKUZA][4] = 294;
    gangRankSkin[FACTION_YAKUZA][5] = 123;
    gangRankSkin[FACTION_YAKUZA][6] = 123; // YAKUZA GANG
    gangRankSkin[FACTION_SYNDICATE][1] = 217;
    gangRankSkin[FACTION_SYNDICATE][2] = 250;
    gangRankSkin[FACTION_SYNDICATE][3] = 217;
    gangRankSkin[FACTION_SYNDICATE][4] = 250;
    gangRankSkin[FACTION_SYNDICATE][5] = 249;
    gangRankSkin[FACTION_SYNDICATE][6] = 249; // SYNDICATE GANG
    gangRankSkin[FACTION_BLOODMAFIA][1] = 22;
    gangRankSkin[FACTION_BLOODMAFIA][2] = 20;
    gangRankSkin[FACTION_BLOODMAFIA][3] = 22;
    gangRankSkin[FACTION_BLOODMAFIA][4] = 29;
    gangRankSkin[FACTION_BLOODMAFIA][5] = 19;
    gangRankSkin[FACTION_BLOODMAFIA][6] = 19; // BLOOD GANG
    gangRankSkin[FACTION_MS13][1] = 49;
    gangRankSkin[FACTION_MS13][2] = 47;
    gangRankSkin[FACTION_MS13][3] = 49;
    gangRankSkin[FACTION_MS13][4] = 47;
    gangRankSkin[FACTION_MS13][5] = 292;
    gangRankSkin[FACTION_MS13][6] = 292; // MS13 GANG
    gangRankSkin[FACTION_BGMAFIA][1] = 223;
    gangRankSkin[FACTION_BGMAFIA][2] = 217;
    gangRankSkin[FACTION_BGMAFIA][3] = 299;
    gangRankSkin[FACTION_BGMAFIA][4] = 185;
    gangRankSkin[FACTION_BGMAFIA][5] = 126;
    gangRankSkin[FACTION_BGMAFIA][6] = 126; // BGM GANG - RDY
    gangRankSkin[FACTION_343][1] = 7;
    gangRankSkin[FACTION_343][2] = 7;
    gangRankSkin[FACTION_343][3] = 48;
    gangRankSkin[FACTION_343][4] = 48;
    gangRankSkin[FACTION_343][5] = 47;
    gangRankSkin[FACTION_343][6] = 47; // 343 GANG
}

/*
* Leave Gang
*/
LeaveGangPlayerAffect(playerid)
{
    if (IsPlayerInAnyVehicle(playerid) == 1 && PlayerInfo[playerid][pADuty] == 0)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "* Твоят скин не се смени, защото не си пешеходец *");
    }
    else
    {
        if (adutyskinchanged[playerid] == 0)
        {
            SetPlayerSkin(playerid, spawnselectedskin[playerid]);
        }
    }
    PlayerInfo[playerid][pSpawnO] = 1;
    SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Твоят spawn беше променен на Civil spawn!");
    if (PlayerInfo[playerid][pADuty] == 0)
    {
        SetPlayerColor(playerid, 0xFFFFFFFF);
    }
    PlayerInfo[playerid][pRank] = 1;
    PlayerInfo[playerid][pTeam] = 0;
    PlayerInfo[playerid][pFWarns] = 0;
    PlayerInfo[playerid][pHelperLeader] = 0;
    PlayerInfo[playerid][pSpecialForce] = 0;
    PlayerInfo[playerid][pDeltaForce] = 0;
    if (PlayerInfo[playerid][pVip] > 3 || CheckFreeVIP() == 1) SetPVarInt(playerid, "color", 0);
}
hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if (vehicleid == aztecasVehs[12])
    {
        if (PlayerInfo[playerid][pTeam] != 5)
        {
            new Float:cx, Float:cy, Float:cz;
            GetPlayerPos(playerid, cx, cy, cz);
            SetPlayerPos(playerid, cx, cy, cz);
            new string256z[256];
            format(string256z, 256, "Това превозно средство принадлежи на Varrio Los Aztecas");
            return SendClientMessage(playerid, 0x636363FF, string256z);
        }
    }
    if (vehicleid == ballasVehs[10])
    {
        if (PlayerInfo[playerid][pTeam] != 3)
        {
            new Float:cx, Float:cy, Float:cz;
            GetPlayerPos(playerid, cx, cy, cz);
            SetPlayerPos(playerid, cx, cy, cz);
            new string256z[256];
            format(string256z, 256, "Това превозно средство принадлежи на Rolling Heights Ballas");
            return SendClientMessage(playerid, 0x636363FF, string256z);
        }
    }
    if (vehicleid == cripzVehs[9])
    {
        if (PlayerInfo[playerid][pTeam] != 6)
        {
            new Float:cx, Float:cy, Float:cz;
            GetPlayerPos(playerid, cx, cy, cz);
            SetPlayerPos(playerid, cx, cy, cz);
            new string256z[256];
            format(string256z, 256, "Това превозно средство принадлежи на Vinewood Cripz");
            return SendClientMessage(playerid, 0x636363FF, string256z);
        }
    }
    if (vehicleid == cripzVehs[9])
    {
        if (PlayerInfo[playerid][pTeam] != 6)
        {
            new Float:cx, Float:cy, Float:cz;
            GetPlayerPos(playerid, cx, cy, cz);
            SetPlayerPos(playerid, cx, cy, cz);
            new string256z[256];
            format(string256z, 256, "Това превозно средство принадлежи на Vinewood Cripz");
            return SendClientMessage(playerid, 0x636363FF, string256z);
        }
    }
    if (!ispassenger)
    {
        if (isVipGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_VIP)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_VIP][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isGroveGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_GROVE)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_GROVE][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isBallasGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_BALLAS)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_BALLAS][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isVagosGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_VAGOS)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_VAGOS][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isAztecasGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_AZTECAS)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_AZTECAS][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isCripzGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_CRIPZ)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_CRIPZ][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isTriadsGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_TRIADS)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_TRIADS][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isRifaGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_RIFA)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_RIFA][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isSoaGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_SOA)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_SOA][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isNangGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_NANG)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_NANG][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isItalianGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_ITALIAN)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_ITALIAN][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isBountyGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_BOUNTY)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_BOUNTY][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isThugLifeGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_THUGLIFE)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_THUGLIFE][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isCrewGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_CREW)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_CREW][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isIntensePDGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_INTENSE_POLICE][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
            if (isIntensePDGangVehDUTY[vehicleid] == true)
            {
                if (!PlayerInfo[playerid][pIPDDuty])
                {
                    new Float:cx, Float:cy, Float:cz;
                    GetPlayerPos(playerid, cx, cy, cz);
                    SetPlayerPos(playerid, cx, cy, cz);
                    new string256z[256];
                    return SendClientMessage(playerid, 0x636363FF, "Трябва да си на смяна за да караш това превозно средство!");
                }
            }
        }
    }
    if (!ispassenger)
    {
        if (isSoldierGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_SOLDIER)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_SOLDIER][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isYakuzaGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_YAKUZA)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_YAKUZA][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isSyndicateGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_SYNDICATE)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_SYNDICATE][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isBloodMafiaGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_BLOODMAFIA)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_BLOODMAFIA][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isMS13GangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_MS13)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_MS13][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (isBGMafiaGangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_BGMAFIA)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_BGMAFIA][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }
    if (!ispassenger)
    {
        if (is343GangVeh[vehicleid] == true)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_343)
            {
                new Float:cx, Float:cy, Float:cz;
                GetPlayerPos(playerid, cx, cy, cz);
                SetPlayerPos(playerid, cx, cy, cz);
                new string256z[256];
                format(string256z, 256, "Това превозно средство принадлежи на %s", TeamInfo[FACTION_343][tName]);
                return SendClientMessage(playerid, 0x636363FF, string256z);
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}
//

hook OnPlayerSpawn(playerid)
{
    if (hideIPD == 1)
    {
        if (PlayerInfo[playerid][pTeam] == 15)
        {
            SetPlayerColor(playerid, 0xFFFFFF00);
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if (hittype == BULLET_HIT_TYPE_VEHICLE)
    {
        for (new i = 0; i < sizeof(intensePDVehs); i++)
        {
            if (isIntensePDGangVeh[hitid] == true)
            {
                if (isIntensePDGangVehDUTY[hitid] == true)
                {
                    if (!PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE && !PlayerInfo[playerid][pADuty])
                    {
                        new now = gettime();
                        if (now - lastCriminalPoliceCar[playerid] >= 30)
                        {
                            lastCriminalPoliceCar[playerid] = now;
                            GivePlayerWantedLevel(playerid, 1, "Стрелба по полицейска кола");
                        }
                    }
                }
            }
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

/*
* Police
*/
hook OnPlayerDeath(playerid, killerid, reason)
{
    if (PlayerInfo[killerid][pIPDDuty] && PlayerInfo[playerid][pWanted] > 0 && killerid != playerid)
    {
        CaughtedWanted(playerid, killerid);
    }
    
    return Y_HOOKS_CONTINUE_RETURN_1;
}