/*
* GENERAL
*/
stock IsNull(const string[])
{
    return string[0] == '\0' || string[0] == ' ';
}

strtok(const string[], & index)
{
    new length = strlen(string);
    while ((index < length) && (string[index] <= ' '))
    {
        index++;
    }
    new offset = index;
    new result[20];
    while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
    {
        result[index - offset] = string[index];
        index++;
    }
    result[index - offset] = EOS;
    return result;
}
IsNumeric(const string[])
{
    for (new i = 0, j = strlen(string); i < j; i++)
    {
        if (string[i] > '9' || string[i] < '0') return 0;
    }
    return 1;
}
ReturnUser(text[], playerid = INVALID_PLAYER_ID)
{
    new pos = 0;
    while (text[pos] < 0x21)
    {
        if (text[pos] == 0) return INVALID_PLAYER_ID;
        pos++;
    }
    new userid = INVALID_PLAYER_ID;
    if (IsNumeric(text[pos]))
    {
        userid = strval(text[pos]);
        if (userid >= 0 && userid < MAX_PLAYERS)
        {
            if (!IsPlayerConnected(userid))
            {
                userid = INVALID_PLAYER_ID;
            }
            else
            {
                return userid;
            }
        }
    }
    new len = strlen(text[pos]);
    new name[MAX_PLAYER_NAME];
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            GetPlayerName(i, name, sizeof(name));
            if (strcmp(name, text[pos], true, len) == 0)
            {
                if (len == strlen(name))
                {
                    return i;
                }
                else
                {
                    count++;
                    userid = i;
                }
            }
        }
    }
    if (count != 1)
    {
        if (playerid != INVALID_PLAYER_ID)
        {
            if (count)
            {
                SendClientMessage(playerid, 0xFF0000AA, "Multiple users found, please narrow search");
            }
            else
            {
                SendClientMessage(playerid, 0xFF0000AA, "No matching user found");
            }
        }
        userid = INVALID_PLAYER_ID;
    }
    return userid;
}

/*
* RANDOM
*/
stock randomex(min, max)
{
    //Credits to y_less
    new rand = random(max - min) + min;
    return rand;
}

/*
* STRING
*/
stock strreplace(string[], const search[], const replacement[], bool:ignorecase = false, pos = 0, limit = -1, maxlength = sizeof(string))
{
    // No need to do anything if the limit is 0.
    if (limit == 0)
        return 0;
    new
    sublen = strlen(search),
        replen = strlen(replacement),
        bool:packed = ispacked(string),
        maxlen = maxlength,
        len = strlen(string),
        count5 = 0;
    // "maxlen" holds the max string length (not to be confused with "maxlength", which holds the max. array size).
    // Since packed strings hold 4 characters per array slot, we multiply "maxlen" by 4.
    if (packed)
        maxlen *= 4;
    // If the length of the substring is 0, we have nothing to look for..
    if (!sublen)
        return 0;
    // In this line we both assign the return value from "strfind" to "pos" then check if it's -1.
    while (-1 != (pos = strfind(string, search, ignorecase, pos)))
    {
        // Delete the string we found
        strdel(string, pos, pos + sublen);
        len -= sublen;
        // If there's anything to put as replacement, insert it. Make sure there's enough room first.
        if (replen && len + replen < maxlen)
        {
            strins(string, replacement, pos, maxlength);
            pos += replen;
            len += replen;
        }
        // Is there a limit of number of replacements, if so, did we break it?
        if (limit != -1 && ++count5 >= limit)
            break;
    }
    return count5;
}

/*
* Weapons
*/
stock IsPlayerAiming(playerid)
{
    new anim = GetPlayerAnimationIndex(playerid);
    if (((anim >= 1160) && (anim <= 1163)) || (anim == 1167) || (anim == 1365) ||
        (anim == 1643) || (anim == 1453) || (anim == 220)) return 1;
    return 0;
}

/*
* Objects
*/
stock AddMapIconsForPlayer(playerid)
{
    SetPlayerMapIcon(playerid, 0, 2006.8207, 1167.4012, 10.8203, 55, 0);
    SetPlayerMapIcon(playerid, 1, 1175.7617, -2036.1178, 70.4141, 43, 0);
    SetPlayerMapIcon(playerid, 2, 1786.6913, -1303.6777, 13.7710, 44, 0);
    SetPlayerMapIcon(playerid, 3, 1411.5128, -1699.5909, 13.5395, 55, 0);
    SetPlayerMapIcon(playerid, 4, -1378.5165, 2111.5034, 42.2000, 9, 0);
    SetPlayerMapIcon(playerid, 5, 2127.8530, -87.0102, 2.1304, 51, 0);
    SetPlayerMapIcon(playerid, 6, 852.8712, 851.4919, 13.3516, 51, 0);
    SetPlayerMapIcon(playerid, 7, 587.8735, 1229.1365, 11.7188, 51, 0);
    SetPlayerMapIcon(playerid, 8, 402.0841, 2529.5537, 16.5748, 51, 0);
    SetPlayerMapIcon(playerid, 9, 76.4918, -258.7651, 1.5781, 51, 0);
    SetPlayerMapIcon(playerid, 10, 1363.4241, 249.8157, 19.5669, 51, 0);
    SetPlayerMapIcon(playerid, 11, -15.7992, -316.2803, 5.4229, 51, 0);
    SetPlayerMapIcon(playerid, 12, -543.4209, 2592.2168, 53.5156, 51, 0);
    SetPlayerMapIcon(playerid, 13, 2145.2683, 2834.1897, 10.8203, 36, 0);
    SetPlayerMapIcon(playerid, 14, 2447.7651, -1963.3743, 13.5469, 36, 0);
    SetPlayerMapIcon(playerid, 15, 2799.0291, -2393.8811, 13.9560, 23, 0);
}
stock RemoveBuildingsForPlayer(playerid)
{
    RemoveBuildingForPlayer(playerid, 1596, -1132.6953, 1073.9922, 1354.7500, 0.25);
    RemoveBuildingForPlayer(playerid, 1596, -973.5625, 1046.0703, 1353.9688, 0.25);
    RemoveBuildingForPlayer(playerid, 16094, 191.1406, 1870.0391, 21.4766, 0.25);
    RemoveBuildingForPlayer(playerid, 1411, 347.1953, 1799.2656, 18.7578, 0.25);
    RemoveBuildingForPlayer(playerid, 985, 2497.4063, 2777.0703, 11.5313, 0.25);
    RemoveBuildingForPlayer(playerid, 986, 2497.4063, 2769.1094, 11.5313, 0.25);
    RemoveBuildingForPlayer(playerid, 1411, 342.9375, 1796.2891, 18.7578, 0.25);
}

stock RemovePlayerObjectsForXmas(playerid)
{
    RemoveBuildingForPlayer(playerid, 1280, 1493.130, -1639.449, 13.453, 0.250);
}

stock AddXmasObjects()
{
    new tmpobjid;
    //lv near ls - open
    tmpobjid = CreateDynamicObject(1232, 1818.874511, 843.170715, 12.440773, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1232, 1776.325073, 843.170715, 12.440773, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3472, 1816.378051, 865.682617, 8.457870, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3472, 1818.288696, 823.382324, 8.457870, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3472, 1776.059326, 823.382324, 8.457870, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3472, 1776.059326, 863.862426, 8.457870, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3918, 1751.309204, 851.463867, 0.307352, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1796.937255, 848.823730, 10.121256, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(731, 1796.901245, 841.665527, 9.477696, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1796.937255, 836.592895, 10.121256, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1801.298095, 844.002929, 10.121256, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1792.187866, 844.002929, 10.121256, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3472, 1796.591552, 841.749389, 12.653235, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3918, 1726.129882, 827.223571, 0.887351, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3918, 1714.790161, 827.223571, 0.887351, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3918, 1703.370361, 827.223571, 0.887351, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3918, 1703.370361, 817.882263, 0.887351, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3918, 1714.839721, 817.882263, 0.887351, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3918, 1714.839721, 817.882263, 0.887351, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3918, 1672.889160, 832.122070, -1.702652, 0.000000, -0.199999, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19833, 1759.995605, 820.532775, 10.239291, 0.000000, 0.000000, -60.699993, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19833, 1757.142822, 818.932739, 10.239291, 0.000000, 0.000000, 136.700012, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19833, 1759.246093, 816.950744, 10.239291, 0.000000, 0.000000, 136.700012, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3534, 1799.915527, 842.795715, 26.927688, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3534, 1799.915527, 842.795715, 35.217697, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3534, 1793.984985, 842.795715, 35.217697, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3534, 1793.984985, 837.255737, 25.897693, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    //near df ls - open
    tmpobjid = CreateDynamicObject(3918, 826.174194, -1801.971557, 6.393503, 0.000000, 7.099998, -91.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3918, 855.079956, -1806.704223, 3.245041, 1.199999, 0.400001, -89.900001, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3918, 855.060119, -1795.334228, 3.234421, 1.199999, 0.400001, -89.900001, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3918, 855.099487, -1816.263549, 3.108327, 1.199999, 0.400001, -89.900001, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19076, 844.703491, -1855.840454, 11.537346, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18654, 839.158752, -1851.845336, 11.713728, 0.000000, 0.000000, 167.900054, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18654, 839.261962, -1857.042480, 11.713728, 0.000000, 0.000000, 167.900054, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18654, 839.318054, -1860.787109, 11.713728, 0.000000, 0.000000, 167.900054, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18654, 841.050903, -1863.010009, 11.713728, 0.000000, 0.000000, -132.799957, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18654, 843.724426, -1864.160766, 11.713728, 0.000000, 0.000000, -117.599967, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18654, 846.436706, -1864.326293, 11.713728, 0.000000, 0.000000, -78.499977, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18654, 849.092590, -1863.786010, 11.713728, 0.000000, 0.000000, -72.099990, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18654, 851.052795, -1863.153076, 11.713728, 0.000000, 0.000000, -66.800010, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18654, 841.945190, -1848.217651, 11.713728, 0.000000, 0.000000, 121.199974, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18654, 847.036071, -1847.588989, 11.713728, 0.000000, 0.000000, 78.799972, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(18654, 850.479309, -1848.270874, 11.713728, 0.000000, 0.000000, 78.799972, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19054, 844.317687, -1855.126220, 13.003446, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19054, 846.357788, -1855.126220, 13.003446, 0.000000, 0.000000, -34.000003, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19341, 845.909667, -1854.888183, 12.586122, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19056, 844.434570, -1856.790771, 12.520775, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19056, 845.824584, -1856.510498, 12.520775, 0.000000, 0.000000, -22.400001, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19279, 843.790222, -1865.554321, 12.229921, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19279, 846.830444, -1865.554321, 12.229921, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19279, 849.270446, -1865.554321, 12.229921, 0.000000, 0.000000, 7.499998, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19279, 851.391845, -1865.275268, 12.489923, 0.000000, 0.000000, 7.499998, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19279, 851.380432, -1846.800048, 12.489923, 0.000000, 0.000000, 162.200027, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19279, 848.117248, -1847.086791, 12.489923, 0.000000, 0.000000, 167.900039, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19279, 844.444030, -1847.382690, 12.489923, 0.000000, 0.000000, -173.999954, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19279, 840.903198, -1847.755615, 12.489923, 0.000000, 0.000000, -158.499969, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19279, 839.798950, -1852.263916, 12.489923, 0.000000, 0.000000, -120.099937, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19279, 839.895935, -1854.608520, 12.489923, 0.000000, 0.000000, -107.999969, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19279, 840.059570, -1857.437622, 12.489923, 0.000000, 0.000000, -79.299987, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19279, 840.640625, -1860.512817, 12.489923, 0.000000, 0.000000, -68.300018, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19279, 851.093017, -1856.353515, 12.659922, 0.000000, 0.000000, 106.799957, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19279, 851.365051, -1851.372192, 12.659922, 0.000000, 0.000000, 106.799957, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19279, 851.416381, -1860.883422, 12.659922, 0.000000, 0.000000, 52.399955, -1, -1, -1, 300.00, 300.00);
    //near df ls - close
    //grove
    tmpobjid = CreateDynamicObject(19054, 2493.585693, -1687.499023, 13.044038, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19054, 2497.156005, -1687.499023, 13.044038, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19076, 2510.633789, -1694.010498, 11.715305, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19063, 2490.961181, -1689.843627, 16.310142, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19063, 2498.790527, -1689.843627, 16.310142, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19061, 2497.736816, -1689.931396, 16.234943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19061, 2493.797119, -1689.931396, 16.234943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19063, 2494.822265, -1689.843627, 16.310142, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19061, 2490.054931, -1689.931396, 16.234943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19062, 2496.437500, -1689.907592, 16.336297, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19062, 2492.347167, -1689.907592, 16.336297, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19059, 2515.632812, -1689.888916, 15.628143, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19059, 2513.182373, -1692.079223, 15.628143, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19060, 2521.788085, -1677.478515, 17.063268, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19060, 2521.788085, -1678.948730, 17.063268, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19061, 2523.407958, -1659.160644, 17.039932, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19061, 2523.407958, -1657.780029, 17.039932, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19062, 2514.977783, -1651.203247, 15.853446, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19062, 2512.555419, -1649.874389, 15.853446, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19056, 2506.948242, -1652.636718, 13.009641, 0.000000, 0.000000, -39.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19056, 2509.631103, -1657.822143, 13.219640, 0.000000, 0.000000, -62.299999, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19055, 2500.945800, -1647.428344, 13.064141, 0.000000, 0.000000, -9.900000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19055, 2496.878417, -1647.114990, 13.064141, 0.000000, 0.000000, -9.900000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19063, 2499.634033, -1644.002929, 15.558877, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19063, 2497.302734, -1644.002929, 15.558877, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19059, 2487.649902, -1647.716430, 15.876352, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19059, 2485.939941, -1647.716430, 15.876352, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19054, 2488.932128, -1649.681884, 13.119666, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19054, 2485.490478, -1649.681884, 13.119666, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19076, 2444.271484, -1672.417724, 12.061472, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    //ls near police
    tmpobjid = CreateDynamicObject(970, 1491.724731, -1636.015258, 14.396038, 0.000000, 0.000000, 103.399948, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1490.659667, -1633.668579, 14.396038, 0.000000, 0.000000, 121.000015, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1488.051513, -1630.471069, 14.396038, 0.000000, 0.000000, 137.300079, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1484.691650, -1628.183471, 14.396038, 0.000000, 0.000000, 153.600082, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1480.732055, -1627.098266, 14.396038, 0.000000, 0.000000, 175.500152, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1476.670532, -1627.411254, 14.396038, 0.000000, 0.000000, -166.999710, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1472.949829, -1628.992553, 14.396038, 0.000000, 0.000000, -148.399703, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1469.906982, -1631.717163, 14.396038, 0.000000, 0.000000, -128.699615, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1467.952026, -1635.145263, 14.396038, 0.000000, 0.000000, -110.599601, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1467.137939, -1639.068237, 14.396038, 0.000000, 0.000000, -92.599594, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1467.527709, -1643.107910, 14.396038, 0.000000, 0.000000, -76.099617, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1469.221069, -1646.838134, 14.396038, 0.000000, 0.000000, -55.299617, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1472.097900, -1649.682983, 14.396038, 0.000000, 0.000000, -33.599617, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1475.842407, -1651.436523, 14.396038, 0.000000, 0.000000, -17.399614, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1479.827514, -1652.142700, 14.396038, 0.000000, 0.000000, -1.799615, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1483.773315, -1651.574218, 14.396038, 0.000000, 0.000000, 18.500394, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1487.250732, -1649.668457, 14.396038, 0.000000, 0.000000, 38.800354, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1489.772338, -1646.814697, 14.396038, 0.000000, 0.000000, 57.400341, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14407, 1494.771484, -1640.054687, 10.974942, 0.000000, 0.000000, -88.799987, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1490.969970, -1644.712890, 14.396038, 0.000000, 0.000000, 65.900306, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14467, 1493.029174, -1635.865112, 15.713924, 0.000000, 0.000000, 94.499954, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(14467, 1493.581420, -1642.903686, 15.713924, 0.000000, 0.000000, 87.799942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3877, 1490.398315, -1633.707641, 15.579391, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3877, 1490.398315, -1633.707641, 15.579391, 0.000000, 0.000000, 30.200000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3877, 1484.205810, -1627.938598, 15.579391, 0.000000, 0.000000, 30.200000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3877, 1487.742065, -1630.336303, 15.579391, 0.000000, 0.000000, 30.200000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3877, 1467.353759, -1642.201293, 15.579391, 0.000000, 0.000000, 30.200000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3877, 1468.366333, -1645.174316, 15.579391, 0.000000, 0.000000, 30.200000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3877, 1470.710449, -1648.484008, 15.579391, 0.000000, 0.000000, 30.200000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3877, 1473.293579, -1650.438354, 15.579391, 0.000000, 0.000000, 30.200000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3877, 1468.814208, -1633.295532, 15.579391, 0.000000, 0.000000, 30.200000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3877, 1471.848388, -1629.921752, 15.579391, 0.000000, 0.000000, 30.200000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3877, 1478.578979, -1627.253051, 15.579391, 0.000000, 0.000000, 30.200000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3877, 1467.077758, -1638.285888, 15.579391, 0.000000, 0.000000, 30.200000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3877, 1482.035400, -1652.083984, 15.579391, 0.000000, 0.000000, 30.200000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3877, 1478.683837, -1652.229980, 15.579391, 0.000000, 0.000000, 30.200000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3877, 1486.248779, -1650.339233, 15.579391, 0.000000, 0.000000, 30.200000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3877, 1490.401367, -1646.002075, 15.579391, 0.000000, 0.000000, 30.200000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3524, 1492.554931, -1636.214965, 14.877551, 0.000000, 0.000000, 98.299964, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3524, 1493.125000, -1643.306396, 14.877551, 0.000000, 0.000000, 98.299964, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(654, 1479.527099, -1638.791625, 13.272961, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19076, 1478.453735, -1638.910766, 12.492962, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3472, 1479.758178, -1640.452758, 11.142171, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3472, 1480.209228, -1637.751220, 11.142171, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
}

/*
* Fuel
*/
stock FuelStationClose(playerid)
{
    if (IsPlayerInRangeOfPoint(playerid, 10, 1004.0327, -937.5370, 42.3281))
    {
        return 0;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 1942.3719, -1772.8666, 13.6406))
    {
        return 1;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, -1606.7223, -2713.3562, 48.5335))
    {
        return 2;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, -2026.7813, 156.5509, 29.0391))
    {
        return 3;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, -2243.8149, -2559.8899, 31.9219))
    {
        return 4;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, -1676.2601, 413.5443, 7.1797))
    {
        return 5;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 2201.8296, 2475.1350, 10.8203))
    {
        return 6;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 615.3391, 1690.0454, 6.9922))
    {
        return 7;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, -1328.2731, 2677.5278, 50.0625))
    {
        return 8;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 70.3842, 1219.0177, 18.8116))
    {
        return 9;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 2113.3835, 919.5655, 10.8203))
    {
        return 10;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 2641.0115, 1106.6252, 10.8203))
    {
        return 11;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 2146.7964, 2747.8115, 10.8203))
    {
        return 12;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 1595.7935, 2199.5996, 10.8203))
    {
        return 13;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, -1471.1836, 1863.7598, 32.6328))
    {
        return 14;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 655.7673, -565.0798, 16.3359))
    {
        return 15;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 1381.8230, 459.1453, 20.3452))
    {
        return 16;
    }
    return 0;
}

/*
* Animations
*/
stock IsPlayerInWater(playerid)
{
    new anim = GetPlayerAnimationIndex(playerid);
    if (((anim >= 1538) && (anim <= 1542)) || (anim == 1544) || (anim == 1250) || (anim == 1062)) return 1;
    return 0;
}

/*
* Money
*/
stock GivePlayerCash(playerid, money)
{
    PlayerInfo[playerid][pCash] += money;
    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, PlayerInfo[playerid][pCash]);
    return PlayerInfo[playerid][pCash];
}

/*
* TextDraws for Stats
*/
stock OnLoginShowTexts(playerid)
{
    format(string256, 256, "~g~EP: ~w~%d/~g~%d", PlayerInfo[playerid][pEP], PlayerInfo[playerid][pLevel] + 6, PlayerInfo[playerid][pEPS]);
    TextDrawSetString(epText[playerid], string256);
    format(string256, 256, "~g~LEVEL: ~w~%d", PlayerInfo[playerid][pLevel]);
    TextDrawSetString(levelText[playerid], string256);
    format(string256, 256, "~g~EPSKILL: ~w~%d", PlayerInfo[playerid][pEPS]);
    TextDrawSetString(epsText[playerid], string256);
    format(string256, 256, "~g~MSKILL: ~w~%d", PlayerInfo[playerid][pMS]);
    TextDrawSetString(msText[playerid], string256);
    TextDrawShowForPlayer(playerid, levelText[playerid]);
    TextDrawShowForPlayer(playerid, epText[playerid]);
    TextDrawShowForPlayer(playerid, epsText[playerid]);
    TextDrawShowForPlayer(playerid, msText[playerid]);
}

stock ActualizeDownStats(playerid)
{
    if (IsPlayerConnected(playerid))
    {
        format(string256, 256, "~g~Level: ~w~%d   ~r~EP Skill:~n~             ~w~%d", PlayerInfo[playerid][pLevel], PlayerInfo[playerid][pEPS]);
        TextDrawSetString(levelText[playerid], string256);
    }
}

/*
* Stats
*/
stock GivePlayerEP(playerid, ep)
{
    if (IsPlayerConnected(playerid))
    {
        PlayerInfo[playerid][pEP] += ep;
        format(string256, 256, "~g~EP: ~w~%d/~g~%d", PlayerInfo[playerid][pEP], PlayerInfo[playerid][pLevel] + 6, PlayerInfo[playerid][pEPS]);
        TextDrawSetString(epText[playerid], string256);
    }
}
stock GivePlayerLevel(playerid, level)
{
    if (IsPlayerConnected(playerid))
    {
        SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
        PlayerInfo[playerid][pLevel] += level;
        format(string256, 256, "~g~LEVEL: ~w~%d", PlayerInfo[playerid][pLevel]);
        TextDrawSetString(levelText[playerid], string256);
    }
}
stock GivePlayerMS(playerid, ms)
{
    if (IsPlayerConnected(playerid))
    {
        PlayerInfo[playerid][pMS] += ms;
        SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
        format(string256, 256, "~g~MSKILL: ~w~%d", PlayerInfo[playerid][pMS]);
        TextDrawSetString(msText[playerid], string256);
    }
}
stock GivePlayerEPS(playerid, eps)
{
    if (IsPlayerConnected(playerid))
    {
        PlayerInfo[playerid][pEPS] += eps;
        format(string256, 256, "~g~EPSKILL: ~w~%d", PlayerInfo[playerid][pEPS]);
        TextDrawSetString(epsText[playerid], string256);
    }
}

/*
* Dialog Menu
*/
GetNumberOfPages()
{
    if ((gTotalItems >= SELECTION_ITEMS) && (gTotalItems % SELECTION_ITEMS) == 0)
    {
        return (gTotalItems / SELECTION_ITEMS);
    }
    else return (gTotalItems / SELECTION_ITEMS) + 1;
}

PlayerText:CreateCurrentPageTextDraw(playerid, Float:Xpos, Float:Ypos)
{
    new PlayerText:txtInit;
    txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, "0/0");
    PlayerTextDrawUseBox(playerid, txtInit, 0);
    PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
    PlayerTextDrawFont(playerid, txtInit, 1);
    PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}
PlayerText:CreatePlayerDialogButton(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height, button_text[])
{
    new PlayerText:txtInit;
    txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, button_text);
    PlayerTextDrawUseBox(playerid, txtInit, 1);
    PlayerTextDrawBoxColor(playerid, txtInit, 0x000000FF);
    PlayerTextDrawBackgroundColor(playerid, txtInit, 0x000000FF);
    PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
    PlayerTextDrawFont(playerid, txtInit, 1);
    PlayerTextDrawSetShadow(playerid, txtInit, 0); // no shadow
    PlayerTextDrawSetOutline(playerid, txtInit, 0);
    PlayerTextDrawColor(playerid, txtInit, 0x4A5A6BFF);
    PlayerTextDrawSetSelectable(playerid, txtInit, 1);
    PlayerTextDrawAlignment(playerid, txtInit, 2);
    PlayerTextDrawTextSize(playerid, txtInit, Height, Width); // The width and height are reversed for centering.. something the game does <g>
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}
PlayerText:CreatePlayerHeaderTextDraw(playerid, Float:Xpos, Float:Ypos, header_text[])
{
    new PlayerText:txtInit;
    txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, header_text);
    PlayerTextDrawUseBox(playerid, txtInit, 0);
    PlayerTextDrawLetterSize(playerid, txtInit, 1.25, 3.0);
    PlayerTextDrawFont(playerid, txtInit, 0);
    PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}
PlayerText:CreatePlayerBackgroundTextDraw(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height)
{
    new PlayerText:txtBackground = CreatePlayerTextDraw(playerid, Xpos, Ypos, "                                            ~n~"); // enough space for everyone
    PlayerTextDrawUseBox(playerid, txtBackground, 1);
    PlayerTextDrawBoxColor(playerid, txtBackground, 0x4A5A6BBB);
    PlayerTextDrawLetterSize(playerid, txtBackground, 5.0, 5.0);
    PlayerTextDrawFont(playerid, txtBackground, 0);
    PlayerTextDrawSetShadow(playerid, txtBackground, 0);
    PlayerTextDrawSetOutline(playerid, txtBackground, 0);
    PlayerTextDrawColor(playerid, txtBackground, 0x000000FF);
    PlayerTextDrawTextSize(playerid, txtBackground, Width, Height);
    PlayerTextDrawBackgroundColor(playerid, txtBackground, 0x4A5A6BBB);
    PlayerTextDrawShow(playerid, txtBackground);
    return txtBackground;
}
PlayerText:CreateModelPreviewTextDraw(playerid, modelindex, Float:Xpos, Float:Ypos, Float:width, Float:height)
{
    new PlayerText:txtPlayerSprite = CreatePlayerTextDraw(playerid, Xpos, Ypos, ""); // it has to be set with SetText later
    PlayerTextDrawFont(playerid, txtPlayerSprite, TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawColor(playerid, txtPlayerSprite, 0xFFFFFFFF);
    PlayerTextDrawBackgroundColor(playerid, txtPlayerSprite, 0x88888899);
    PlayerTextDrawTextSize(playerid, txtPlayerSprite, width, height); // Text size is the Width:Height
    PlayerTextDrawSetPreviewModel(playerid, txtPlayerSprite, modelindex);
    PlayerTextDrawSetSelectable(playerid, txtPlayerSprite, 1);
    PlayerTextDrawShow(playerid, txtPlayerSprite);
    return txtPlayerSprite;
}
DestroyPlayerModelPreviews(playerid)
{
    new x = 0;
    while (x != SELECTION_ITEMS)
    {
        if (gSelectionItems[playerid][x] != PlayerText:INVALID_TEXT_DRAW)
        {
            PlayerTextDrawDestroy(playerid, gSelectionItems[playerid][x]);
            gSelectionItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
        }
        x++;
    }
}
ShowPlayerModelPreviews(playerid)
{
    new x = 0;
    new Float:BaseX = DIALOG_BASE_X;
    new Float:BaseY = DIALOG_BASE_Y - (SPRITE_DIM_Y * 0.33); // down a bit
    new linetracker = 0;
    new itemat = GetPVarInt(playerid, "skinc_page") * SELECTION_ITEMS;
    // Destroy any previous ones created
    DestroyPlayerModelPreviews(playerid);
    while (x != SELECTION_ITEMS && itemat < gTotalItems)
    {
        if (linetracker == 0)
        {
            BaseX = DIALOG_BASE_X + 25.0; // in a bit from the box
            BaseY += SPRITE_DIM_Y + 1.0; // move on the Y for the next line
        }
        gSelectionItems[playerid][x] = CreateModelPreviewTextDraw(playerid, gItemList[itemat], BaseX, BaseY, SPRITE_DIM_X, SPRITE_DIM_Y);
        gSelectionItemsTag[playerid][x] = gItemList[itemat];
        BaseX += SPRITE_DIM_X + 1.0; // move on the X for the next sprite
        linetracker++;
        if (linetracker == ITEMS_PER_LINE) linetracker = 0;
        itemat++;
        x++;
    }
}
UpdatePageTextDraw(playerid)
{
    new PageText[64 + 1];
    format(PageText, 64, "%d/%d", GetPVarInt(playerid, "skinc_page") + 1, GetNumberOfPages());
    PlayerTextDrawSetString(playerid, gCurrentPageTextDrawId[playerid], PageText);
}
CreateSelectionMenu(playerid)
{
    gBackgroundTextDrawId[playerid] = CreatePlayerBackgroundTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y + 20.0, DIALOG_WIDTH, DIALOG_HEIGHT);
    gHeaderTextDrawId[playerid] = CreatePlayerHeaderTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, HEADER_TEXT);
    gCurrentPageTextDrawId[playerid] = CreateCurrentPageTextDraw(playerid, DIALOG_WIDTH - 30.0, DIALOG_BASE_Y + 15.0);
    gNextButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_WIDTH - 30.0, DIALOG_BASE_Y + DIALOG_HEIGHT + 100.0, 50.0, 16.0, NEXT_TEXT);
    gPrevButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_WIDTH - 90.0, DIALOG_BASE_Y + DIALOG_HEIGHT + 100.0, 50.0, 16.0, PREV_TEXT);
    ShowPlayerModelPreviews(playerid);
    UpdatePageTextDraw(playerid);
}
DestroySelectionMenu(playerid)
{
    DestroyPlayerModelPreviews(playerid);
    PlayerTextDrawDestroy(playerid, gHeaderTextDrawId[playerid]);
    PlayerTextDrawDestroy(playerid, gBackgroundTextDrawId[playerid]);
    PlayerTextDrawDestroy(playerid, gCurrentPageTextDrawId[playerid]);
    PlayerTextDrawDestroy(playerid, gNextButtonTextDrawId[playerid]);
    PlayerTextDrawDestroy(playerid, gPrevButtonTextDrawId[playerid]);
    gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gCurrentPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
}
HandlePlayerItemSelection(playerid, selecteditem)
{
    // In this case we change the player's skin
    if (gSelectionItemsTag[playerid][selecteditem] >= 0 && gSelectionItemsTag[playerid][selecteditem] < 319)
    {
        if (PlayerInfo[playerid][pADuty] == 1)
        {
            SetPlayerSkin(playerid, gSelectionItemsTag[playerid][selecteditem]);
        }
        PlayerInfo[playerid][pASkin] = gSelectionItemsTag[playerid][selecteditem];
        return;
    }
}

/*
* Gets Date and Hours
*/
stock GetDateAndHours()
{
    getdate(year, month, day);
    gettime(hours, minutes, seconds);
    hours += 2;
    updatedseconds = seconds;
    if (hours == 0) SetWorldTime(0);
    if (hours == 6) SetWorldTime(0);
    if (hours == 12) SetWorldTime(12);
    if (hours == 18) SetWorldTime(23);
    if (hours == 1) SetWorldTime(0);
    if (hours == 7) SetWorldTime(6);
    if (hours == 13) SetWorldTime(12);
    if (hours == 19) SetWorldTime(23);
    if (hours == 2) SetWorldTime(0);
    if (hours == 8) SetWorldTime(6);
    if (hours == 14) SetWorldTime(12);
    if (hours == 20) SetWorldTime(0);
    if (hours == 3) SetWorldTime(0);
    if (hours == 9) SetWorldTime(12);
    if (hours == 15) SetWorldTime(12);
    if (hours == 21) SetWorldTime(0);
    if (hours == 4) SetWorldTime(0);
    if (hours == 10) SetWorldTime(12);
    if (hours == 16) SetWorldTime(12);
    if (hours == 22) SetWorldTime(0);
    if (hours == 5) SetWorldTime(0);
    if (hours == 11) SetWorldTime(12);
    if (hours == 17) SetWorldTime(12);
    if (hours == 23) SetWorldTime(0);
}

/*
* Tuning menu
*/
stock DefineTuneMenu()
{
    TuningMenu = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    AddMenuItem(TuningMenu, 0, "Paint Jobs");
    AddMenuItem(TuningMenu, 0, "Colors");
    AddMenuItem(TuningMenu, 0, "Exhausts");
    AddMenuItem(TuningMenu, 0, "Front Bumper");
    AddMenuItem(TuningMenu, 0, "Rear Bumper");
    AddMenuItem(TuningMenu, 0, "Roof");
    AddMenuItem(TuningMenu, 0, "Spoilers");
    AddMenuItem(TuningMenu, 0, "Side Skirts");
    AddMenuItem(TuningMenu, 0, "Wheels");
    AddMenuItem(TuningMenu, 0, "Others");
    // Paintjobs
    Paintjobs = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Paintjobs, 0, "PaintJobs");
    AddMenuItem(Paintjobs, 0, "Paintjob 1");
    AddMenuItem(Paintjobs, 0, "Paintjob 2");
    AddMenuItem(Paintjobs, 0, "Paintjob 3");
    AddMenuItem(Paintjobs, 0, "Paintjob 4");
    AddMenuItem(Paintjobs, 0, "Paintjob 5");
    AddMenuItem(Paintjobs, 0, "Main Menu");
    // Colors
    Colors = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Colors, 0, "Colors");
    AddMenuItem(Colors, 0, "Black");
    AddMenuItem(Colors, 0, "White");
    AddMenuItem(Colors, 0, "Red");
    AddMenuItem(Colors, 0, "Blue");
    AddMenuItem(Colors, 0, "Green");
    AddMenuItem(Colors, 0, "Yellow");
    AddMenuItem(Colors, 0, "Pink");
    AddMenuItem(Colors, 0, "Brown");
    AddMenuItem(Colors, 0, "Next Page");
    // Colors 2
    Colors1 = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Colors1, 0, "Colors");
    AddMenuItem(Colors1, 0, "Grey");
    AddMenuItem(Colors1, 0, "Gold");
    AddMenuItem(Colors1, 0, "Dark Blue");
    AddMenuItem(Colors1, 0, "Light Blue");
    AddMenuItem(Colors1, 0, "Green");
    AddMenuItem(Colors1, 0, "Light Grey");
    AddMenuItem(Colors1, 0, "Dark Red");
    AddMenuItem(Colors1, 0, "Dark Brown");
    AddMenuItem(Colors1, 0, "Main Menu");
    // Exhausts
    Exhausts = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Exhausts, 0, "Exhausts");
    AddMenuItem(Exhausts, 0, "Wheel Arch Alien Exhaust");
    AddMenuItem(Exhausts, 0, "Wheel Arch X-Flow Exhaust");
    AddMenuItem(Exhausts, 0, "Loco Low-Co Chromer Exhaust");
    AddMenuItem(Exhausts, 0, "Loco Low-Co Slamin Exhaust");
    AddMenuItem(Exhausts, 0, "Main Menu");
    // Front bumpers
    Frontbumper = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Frontbumper, 0, "Frontbumpers");
    AddMenuItem(Frontbumper, 0, "Wheel Arch Alien bumper");
    AddMenuItem(Frontbumper, 0, "Wheel Arch X-Flow bumper");
    AddMenuItem(Frontbumper, 0, "Loco Low-Co Chromer bumper");
    AddMenuItem(Frontbumper, 0, "Loco Low-Co Slamin bumper");
    AddMenuItem(Frontbumper, 0, "Main Menu");
    // Rear bumpers
    Rearbumper = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Rearbumper, 0, "Rearbumpers");
    AddMenuItem(Rearbumper, 0, "Wheel Arch Alien bumper");
    AddMenuItem(Rearbumper, 0, "Wheel Arch X-Flow bumper");
    AddMenuItem(Rearbumper, 0, "Loco Low-Co Chromer bumper");
    AddMenuItem(Rearbumper, 0, "Loco Low-Co Slamin bumper");
    AddMenuItem(Rearbumper, 0, "Main Menu");
    // Roof
    Roof = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Roof, 0, "Roof");
    AddMenuItem(Roof, 0, "Wheel Arch Alien Roof Vent");
    AddMenuItem(Roof, 0, "Wheel Arch X-Flow Roof Vent");
    AddMenuItem(Roof, 0, "Loco Low-Co Hardtop Roof");
    AddMenuItem(Roof, 0, "Loco Low-Co Softtop Roof");
    AddMenuItem(Roof, 0, "Main Menu");
    // Spoilers
    Spoilers = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Spoilers, 0, "Spoliers");
    AddMenuItem(Spoilers, 0, "Alien Spoiler");
    AddMenuItem(Spoilers, 0, "X-Flow Spoiler");
    AddMenuItem(Spoilers, 0, "Main Menu");
    // Side skirts
    Sideskirts = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Sideskirts, 0, "SideSkirts");
    AddMenuItem(Sideskirts, 0, "Wheel Arch Alien Side Skirts");
    AddMenuItem(Sideskirts, 0, "Wheel Arch X-Flow Side Skirts");
    AddMenuItem(Sideskirts, 0, "Loco Low-Co Chrome Strip");
    AddMenuItem(Sideskirts, 0, "Loco Low-Co Chrome Flames");
    AddMenuItem(Sideskirts, 0, "Loco Low-Co Chrome Arches");
    AddMenuItem(Sideskirts, 0, "Loco Low-Co Chrome Trim");
    AddMenuItem(Sideskirts, 0, "Loco Low-Co Wheelcovers");
    AddMenuItem(Sideskirts, 0, "Main Menu");
    // Wheels
    Wheels = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Wheels, 0, "Wheels");
    AddMenuItem(Wheels, 0, "Offroad");
    AddMenuItem(Wheels, 0, "Mega");
    AddMenuItem(Wheels, 0, "Wires");
    AddMenuItem(Wheels, 0, "Twist");
    AddMenuItem(Wheels, 0, "Grove");
    AddMenuItem(Wheels, 0, "Import");
    AddMenuItem(Wheels, 0, "Atomic");
    AddMenuItem(Wheels, 0, "Ahab");
    AddMenuItem(Wheels, 0, "Virtual");
    AddMenuItem(Wheels, 0, "Access");
    AddMenuItem(Wheels, 0, "Next Page");
    AddMenuItem(Wheels, 0, "Main Menu");
    // wheels 2
    Wheels1 = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Wheels1, 0, "Wheels");
    AddMenuItem(Wheels1, 0, "Trance");
    AddMenuItem(Wheels1, 0, "Shadow");
    AddMenuItem(Wheels1, 0, "Rimshine");
    AddMenuItem(Wheels1, 0, "Classic");
    AddMenuItem(Wheels1, 0, "Cutter");
    AddMenuItem(Wheels1, 0, "Switch");
    AddMenuItem(Wheels1, 0, "Dollar");
    AddMenuItem(Wheels1, 0, "Main Menu");
    // Nitro
    Nitro = CreateMenu("TuningMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Nitro, 0, "Nitro");
    AddMenuItem(Nitro, 0, "2x Nitrous");
    AddMenuItem(Nitro, 0, "5x Nitrous");
    AddMenuItem(Nitro, 0, "10x Nitrous");
    AddMenuItem(Nitro, 0, "Main Menu");
    // Others
    Others = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Others, 0, "Other addons");
    AddMenuItem(Others, 0, "Hydraulics");
    AddMenuItem(Others, 0, "Car Stereo");
    AddMenuItem(Others, 0, "Nitro");
    AddMenuItem(Others, 0, "Main Menu");
}