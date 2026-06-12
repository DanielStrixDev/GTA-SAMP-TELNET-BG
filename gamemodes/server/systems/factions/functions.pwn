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
* Faction Spawn
*/
stock SetPlayerToFactionSpawn(playerid)
{
    if (PlayerInfo[playerid][pSpawnO] == 2)
    {
        new team = PlayerInfo[playerid][pTeam];
        new spawn;

        if (team == FACTION_VIP)
        {
            new Float:pos[6][3] =
            {
                {1204.3077, -2066.5664, 84.7134},
                {1183.0295, -2008.9454, 85.1735},
                {1242.3442, -2003.8608, 76.0035},
                {1281.2172, -2002.7297, 74.8102},
                {1281.2172, -2002.7297, 74.8102},
                {1281.2172, -2002.7297, 74.8102}
            };
            new Float:angles[6] = {2.7804, 182.6776, 179.7874, 174.3698, 174.3698, 179.7682};
            SpawnOutside(playerid, pos, angles, 6);
        }
        else if (team == FACTION_BALLAS)
        {
            new Float:pos[3][3] =
            {
                {2146.5444, -1432.6128, 25.5391},
                {2147.8428, -1489.3254, 26.6198},
                {2146.5444, -1432.6128, 25.5391}
            };
            new Float:angles[3] = {90.9074, 88.7140, 90.9074};
            SpawnOutside(playerid, pos, angles, 3);
        }
        else if (team == FACTION_TRIADS)
        {
            new Float:pos[3][3] =
            {
                {1958.0376, 951.1666, 10.8203},
                {1969.9386, 942.0911, 10.8126},
                {1928.6168, 945.8361, 10.8127}
            };
            new Float:angles[3] = {180.1847, 176.1113, 85.2205};
            SpawnOutside(playerid, pos, angles, 3);
        }
        else if (team == FACTION_AZTECAS)
        {
            new Float:pos[3][3] =
            {
                {743.6805, -498.7406, 18.0129},
                {745.5961, -511.2993, 18.0129},
                {739.9612, -554.7196, 18.0129}
            };
            new Float:angles[3] = {276.3322, 176.9813, 5.9559};
            SpawnOutside(playerid, pos, angles, 3);
        }
        else if (team == FACTION_CRIPZ)
        {
            new Float:pos[3][3] =
            {
                {297.6942, -1155.6418, 80.9099},
                {320.8712, -1170.3861, 80.9141},
                {274.3722, -1167.7781, 80.8616}
            };
            new Float:angles[3] = {125.8933, 88.6063, 276.8981};
            SpawnOutside(playerid, pos, angles, 3);
        }
        else if (team == FACTION_BGMAFIA)
        {
            SpawnInterior(playerid, 1267.1464, -777.3041, 1091.9063, 1, 5, 0.0, 100);
        }
        else if (team == FACTION_RIFA)
        {
            SpawnInterior(playerid, 2449.8516, -1688.9565, 1013.5078, 1, 2, 182.1234);
        }
        else if (team == FACTION_SOLDIER)
        {
            SpawnInterior(playerid, 2331.0933, -1137.6527, 1054.3047, 1, 12, 0.0, 100);
        }
        else if (team == FACTION_SOA)
        {
            new Float:pos[3][3] =
            {
                {2615.6545, 2313.8264, 10.8203},
                {2622.7986, 2335.3406, 10.8203},
                {2655.8208, 2347.8174, 10.8203}
            };
            new Float:angles[3] = {253.6507, 185.9700, 149.9362};
            SpawnOutside(playerid, pos, angles, 3);
        }
        else if (team == FACTION_NANG)
        {
            new Float:pos[3][3] =
            {
                {2621.7190, 1825.1489, 11.0234},
                {2635.7065, 1797.4092, 11.0234},
                {2599.0176, 1812.4899, 10.9766}
            };
            new Float:angles[3] = {91.7867, 87.7133, 279.7651};
            SpawnOutside(playerid, pos, angles, 3);
        }
        else if (team == FACTION_BOUNTY)
        {
            new Float:pos[3][3] =
            {
                {681.9958, -1276.5922, 13.5755},
                {673.2634, -1292.6874, 13.6328},
                {658.6101, -1251.8407, 13.7522}
            };
            new Float:angles[3] = {88.3163, 82.0496, 190.7540};
            SpawnOutside(playerid, pos, angles, 3);
            SetPlayerArmour(playerid, 100);
        }
        else if (team == FACTION_THUGLIFE)
        {
            new Float:pos[3][3] =
            {
                {491.4981, -1514.3501, 20.4358},
                {480.5826, -1495.5084, 20.3957},
                {480.3297, -1482.4331, 19.8992}
            };
            new Float:angles[3] = {1.1300, 89.8041, 92.3108};
            SpawnOutside(playerid, pos, angles, 3);
        }
        else if (team == FACTION_INTENSE_POLICE)
        {
            new Float:pos[3][3] =
            {
                {248.4185, 75.8314, 1003.6406},
                {253.4204, 65.2763, 1003.6406},
                {237.9575, 74.1665, 1005.0391}
            };
            SpawnInterior(playerid, pos[spawn][0], pos[spawn][1], pos[spawn][2], 1, 6, 0.0, 100);
        }
        else if (team == FACTION_CREW)
        {
            new Float:pos[3][3] =
            {
                {309.5213, -1333.9890, 53.4476},
                {317.7553, -1330.7593, 53.1995},
                {298.8723, -1334.7021, 53.4421}
            };
            new Float:angles[3] = {91.9914, 91.9914, 88.8813};
            SpawnOutside(playerid, pos, angles, 3);
        }
        else if (team == FACTION_ITALIAN)
        {
            new Float:pos[3][3] =
            {
                {-688.8886, 938.8144, 13.6328},
                {-688.0349, 926.8151, 13.6293},
                {-708.7231, 950.2300, 12.4724}
            };
            new Float:angles[3] = {91.9914, 91.9914, 88.8813};
            SpawnOutside(playerid, pos, angles, 3);
        }
        else if (team == FACTION_VAGOS)
        {
            new Float:pos[3][3] =
            {
                {1881.9993, 2339.8398, 10.9799},
                {1910.1119, 2349.9846, 10.9799},
                {1883.3551, 2295.4844, 10.9799}
            };
            new Float:angles[3] = {264.6255, 176.9813, 267.4223};
            SpawnOutside(playerid, pos, angles, 3);
            SetPlayerArmour(playerid, 100);
        }
        else if (team == FACTION_MS13)
        {
            new Float:pos[3][3] =
            {
                {-37.7534, 1079.9067, 20.0710},
                {-22.8780, 1063.8611, 19.7422},
                {-7.8116, 1075.0288, 19.7422}
            };
            new Float:angles[3] = {91.9914, 91.9914, 88.8813};
            SpawnOutside(playerid, pos, angles, 3);
        }
        else if (team == FACTION_SYNDICATE)
        {
            new Float:pos[3][3] =
            {
                {1757.1570, 2766.8816, 10.8359},
                {1749.6184, 2797.0723, 10.8359},
                {1783.9874, 2787.4541, 10.8359}
            };
            new Float:angles[3] = {91.9914, 91.9914, 88.8813};
            SpawnOutside(playerid, pos, angles, 3);
            SetPlayerArmour(playerid, 100);
        }
        else if (team == FACTION_BLOODMAFIA)
        {
            new Float:pos[3][3] =
            {
                {1100.7185, -1220.8761, 17.8047},
                {1117.1194, -1237.0652, 15.9510},
                {1122.6483, -1247.2380, 25.3020}
            };
            new Float:angles[3] = {91.9914, 91.9914, 88.8813};
            SpawnOutside(playerid, pos, angles, 3);
        }
        else if (team == FACTION_343)
        {
            new Float:pos[3][3] =
            {
                {-799.6035, 1569.4238, 27.1172},
                {-814.1357, 1542.5577, 27.1172},
                {-800.3713, 1531.4137, 27.1172}
            };
            new Float:angles[3] = {91.9914, 91.9914, 88.8813};
            SpawnOutside(playerid, pos, angles, 3);
        }
        else if (team == FACTION_YAKUZA)
        {
            new Float:pos[3][3] =
            {
                {2584.7444, 2787.1177, 10.8203},
                {2581.6055, 2747.6665, 10.8203},
                {2531.0698, 2794.3374, 10.8203}
            };
            new Float:angles[3] = {91.9914, 91.9914, 88.8813};
            SpawnOutside(playerid, pos, angles, 3);
        }
        else if (team == FACTION_GROVE)
        {
            new Float:pos[6][3] =
            {
                {2496.0024, -1709.4805, 1014.7422},
                {2496.0024, -1709.4805, 1014.7422},
                {2496.0024, -1709.4805, 1014.7422},
                {2492.2722, -1703.3955, 1018.3438},
                {2492.2722, -1703.3955, 1018.3438},
                {2496.0024, -1709.4805, 1014.7422}
            };
            new Float:angles[6] = {2.1533, 2.1533, 2.1533, 179.7682, 179.7682, 2.1533};
            SpawnInterior(playerid, pos[spawn][0], pos[spawn][1], pos[spawn][2], 1, 3, angles[spawn]);
        }
    }
}

/*
* Civil Spawn
*/
stock SetPlayerToCivilianSpawn(playerid)
{
    SetPlayerVirtualWorld(playerid, 0);
    SetPlayerInterior(playerid, 0);
    new spawn = random(10);
    if (spawn == 0)
    {
        SetPlayerPos(playerid, 2178.9063, 1285.6537, 10.8203);
        SetPlayerFacingAngle(playerid, 270.3970);
    }
    if (spawn == 1)
    {
        SetPlayerPos(playerid, 1027.0188, -1344.9539, 13.7266);
        SetPlayerFacingAngle(playerid, 1.2900);
    }
    if (spawn == 2)
    {
        SetPlayerPos(playerid, 2216.9980, -1170.4368, 25.7266);
        SetPlayerFacingAngle(playerid, 359.7421);
    }
    if (spawn == 3)
    {
        SetPlayerPos(playerid, 2097.3970, 2490.7754, 14.8390);
        SetPlayerFacingAngle(playerid, 179.1149);
    }
    if (spawn == 4)
    {
        SetPlayerPos(playerid, 386.7134, -2028.5282, 7.8359);
        SetPlayerFacingAngle(playerid, 89.3663);
    }
    if (spawn == 5)
    {
        SetPlayerPos(playerid, 1676.4705, -1634.6233, 14.2266);
        SetPlayerFacingAngle(playerid, 269.8728);
    }
    if (spawn == 6)
    {
        SetPlayerPos(playerid, 2225.3550, 1838.6611, 10.8203);
        SetPlayerFacingAngle(playerid, 90.2421);
    }
    if (spawn == 7)
    {
        SetPlayerPos(playerid, 2551.8250, 2244.6887, 10.8203);
        SetPlayerFacingAngle(playerid, 167.6396);
    }
    if (spawn == 8)
    {
        SetPlayerPos(playerid, 1742.8735, -1863.2289, 13.5753);
        SetPlayerFacingAngle(playerid, 359.7475);
    }
    if (spawn == 9)
    {
        SetPlayerPos(playerid, 1688.3342, 1447.8641, 10.7678);
        SetPlayerFacingAngle(playerid, 269.8827);
    }
    if (spawn == 10)
    {
        SetPlayerPos(playerid, 2216.9980, -1170.4368, 25.7266);
        SetPlayerFacingAngle(playerid, 359.7421);
    }
    SetCameraBehindPlayer(playerid);
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

stock CheckGangVehicle(playerid, vehicleid, bool:gangVehArray[], faction, const gangName[])
{
    if (gangVehArray[vehicleid] && PlayerInfo[playerid][pTeam] != faction)
    {
        new message[128];
        format(message, sizeof(message), "Това превозно средство принадлежи на %s", gangName);
        DenyVehicleEntry(playerid, message);
        return 0;
    }
    return 1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    // Проверка за специални единични коли (дори и като пасажер)
    if (vehicleid == aztecasVehs[12] && PlayerInfo[playerid][pTeam] != FACTION_AZTECAS)
    {
        DenyVehicleEntry(playerid, "Това превозно средство принадлежи на Varrio Los Aztecas");
        return Y_HOOKS_CONTINUE_RETURN_1;
    }
    
    if (vehicleid == ballasVehs[10] && PlayerInfo[playerid][pTeam] != FACTION_BALLAS)
    {
        DenyVehicleEntry(playerid, "Това превозно средство принадлежи на Rolling Heights Ballas");
        return Y_HOOKS_CONTINUE_RETURN_1;
    }
    
    if (vehicleid == cripzVehs[9] && PlayerInfo[playerid][pTeam] != FACTION_CRIPZ)
    {
        DenyVehicleEntry(playerid, "Това превозно средство принадлежи на Vinewood Cripz");
        return Y_HOOKS_CONTINUE_RETURN_1;
    }
    
    if (ispassenger) return Y_HOOKS_CONTINUE_RETURN_1;
    
    // Проверка за всички банди (само за шофьори)
    if (!CheckGangVehicle(playerid, vehicleid, isVipGangVeh, FACTION_VIP, TeamInfo[FACTION_VIP][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isGroveGangVeh, FACTION_GROVE, TeamInfo[FACTION_GROVE][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isBallasGangVeh, FACTION_BALLAS, TeamInfo[FACTION_BALLAS][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isVagosGangVeh, FACTION_VAGOS, TeamInfo[FACTION_VAGOS][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isAztecasGangVeh, FACTION_AZTECAS, TeamInfo[FACTION_AZTECAS][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isCripzGangVeh, FACTION_CRIPZ, TeamInfo[FACTION_CRIPZ][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isTriadsGangVeh, FACTION_TRIADS, TeamInfo[FACTION_TRIADS][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isRifaGangVeh, FACTION_RIFA, TeamInfo[FACTION_RIFA][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isSoaGangVeh, FACTION_SOA, TeamInfo[FACTION_SOA][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isNangGangVeh, FACTION_NANG, TeamInfo[FACTION_NANG][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isItalianGangVeh, FACTION_ITALIAN, TeamInfo[FACTION_ITALIAN][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isBountyGangVeh, FACTION_BOUNTY, TeamInfo[FACTION_BOUNTY][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isThugLifeGangVeh, FACTION_THUGLIFE, TeamInfo[FACTION_THUGLIFE][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isCrewGangVeh, FACTION_CREW, TeamInfo[FACTION_CREW][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isSoldierGangVeh, FACTION_SOLDIER, TeamInfo[FACTION_SOLDIER][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isYakuzaGangVeh, FACTION_YAKUZA, TeamInfo[FACTION_YAKUZA][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isSyndicateGangVeh, FACTION_SYNDICATE, TeamInfo[FACTION_SYNDICATE][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isBloodMafiaGangVeh, FACTION_BLOODMAFIA, TeamInfo[FACTION_BLOODMAFIA][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isMS13GangVeh, FACTION_MS13, TeamInfo[FACTION_MS13][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, isBGMafiaGangVeh, FACTION_BGMAFIA, TeamInfo[FACTION_BGMAFIA][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, is343GangVeh, FACTION_343, TeamInfo[FACTION_343][tName])) return Y_HOOKS_CONTINUE_RETURN_1;
    if (!CheckGangVehicle(playerid, vehicleid, is343GangVeh, FACTION_INTENSE_POLICE, TeamInfo[FACTION_INTENSE_POLICE][tName])) return Y_HOOKS_CONTINUE_RETURN_1;

    // Полицейски проверки
    if (isIntensePDGangVehDUTY[vehicleid] && !PlayerInfo[playerid][pIPDDuty])
    {
        DenyVehicleEntry(playerid, "Трябва да си на смяна за да караш това превозно средство!");
        return Y_HOOKS_CONTINUE_RETURN_1;
    }
    
    return Y_HOOKS_CONTINUE_RETURN_1;
}

stock IsPlayerInHidenTeam(playerid)
{
    if (PlayerInfo[playerid][pTeam] == FACTION_INTENSE_POLICE && hideIPD == 1)
    {
        return true;
    }

    return false;
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