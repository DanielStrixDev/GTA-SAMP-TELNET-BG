public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
    lastkey[playerid] = newkeys;
    oldkey[playerid] = oldkeys;
    if (newkeys & KEY_FIRE)
    {
        if (playerInDeathmatch[playerid] == true)
        {
            if (deathmatchStarted == false) //goto
            {
                SetPlayerHealth(playerid, 0);
                SendClientMessage(playerid, COLOR_DEATHMATCH, "Deathmatch: Не удряй, преди да започне битката!");
            }
        }
    }

    if (Jump[playerid] == 1)
    {
        if (IsValidVehicle(GetPlayerVehicleID(playerid)) == 1)
        {
            if (newkeys & 2)
            {
                new Float:SuperJump[3];
                GetVehicleVelocity(GetPlayerVehicleID(playerid), SuperJump[0], SuperJump[1], SuperJump[2]);
                SetVehicleVelocity(GetPlayerVehicleID(playerid), SuperJump[0], SuperJump[1], SuperJump[2] + 1);
            }
        }
    }
    if (newkeys & 16)
    {
        if (InTuneGarage[playerid] == true)
        {
            TogglePlayerControllable(playerid, true);
        }
    }
    if (newkeys & 1)
    {
        if (enabledramp[playerid] == 1)
        {
            if (GetPlayerVehicleID(playerid) > 0)
            {
                new Float:XX;
new Float:
                YY;
new Float:
                ZZ;
                new Float:AA;
                GetVehicleZAngle(GetPlayerVehicleID(playerid), AA);
                GetVehiclePos(GetPlayerVehicleID(playerid), XX, YY, ZZ);
                GetPosInFrontOfPoint(XX, YY, AA, 15.0);
                DestroyDynamicObject(rampobject[playerid]);
                rampobject[playerid] = CreateDynamicObject(1655, XX, YY, ZZ - 0.2, 0.0, 0.0, AA, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid);
            }
        }
        if (enabledramp[playerid] == 2)
        {
            if (GetPlayerVehicleID(playerid) > 0)
            {
                new Float:XX;
new Float:
                YY;
new Float:
                ZZ;
                new Float:AA;
                GetVehicleZAngle(GetPlayerVehicleID(playerid), AA);
                GetVehiclePos(GetPlayerVehicleID(playerid), XX, YY, ZZ);
                GetPosInFrontOfPoint(XX, YY, AA, 15.0);
                DestroyDynamicObject(rampobject[playerid]);
                rampobject[playerid] = CreateDynamicObject(1634, XX, YY, ZZ - 0.2, 0.0, 0.0, AA, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid);
            }
        }
        if (enabledramp[playerid] == 3)
        {
            if (GetPlayerVehicleID(playerid) > 0)
            {
                new Float:XX;
new Float:
                YY;
new Float:
                ZZ;
                new Float:AA;
                GetVehicleZAngle(GetPlayerVehicleID(playerid), AA);
                GetVehiclePos(GetPlayerVehicleID(playerid), XX, YY, ZZ);
                GetPosInFrontOfPoint(XX, YY, AA, 15.0);
                DestroyDynamicObject(rampobject[playerid]);
                rampobject[playerid] = CreateDynamicObject(1631, XX, YY, ZZ - 0.2, 0.0, 0.0, AA, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid);
            }
        }
        if (enabledramp[playerid] == 4)
        {
            if (GetPlayerVehicleID(playerid) > 0)
            {
                new Float:XX;
new Float:
                YY;
new Float:
                ZZ;
                new Float:AA;
                GetVehicleZAngle(GetPlayerVehicleID(playerid), AA);
                GetVehiclePos(GetPlayerVehicleID(playerid), XX, YY, ZZ);
                GetPosInFrontOfPoint(XX, YY, AA, 15.0);
                DestroyDynamicObject(rampobject[playerid]);
                rampobject[playerid] = CreateDynamicObject(8302, XX, YY, ZZ - 0.2, 0.0, 0.0, AA, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid);
            }
        }
        if (enabledramp[playerid] == 5)
        {
            if (GetPlayerVehicleID(playerid) > 0)
            {
                new Float:XX;
new Float:
                YY;
new Float:
                ZZ;
                new Float:AA;
                GetVehicleZAngle(GetPlayerVehicleID(playerid), AA);
                GetVehiclePos(GetPlayerVehicleID(playerid), XX, YY, ZZ);
                GetPosInFrontOfPoint(XX, YY, AA, 15.0);
                DestroyDynamicObject(rampobject[playerid]);
                rampobject[playerid] = CreateDynamicObject(1503, XX, YY, ZZ - 0.2, 0.0, 0.0, AA, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid), playerid);
            }
        }
        //CreateDynamicObject(modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = 300.0);
    }
    if (newkeys & 16)
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 1555.2531, -1675.6143, 16.1953) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Intense Police Department!");
            SetPlayerInterior(playerid, 6);
            SetPlayerPos(playerid, 246.6557, 65.1160, 1003.6406);
            SetPlayerFacingAngle(playerid, 359.9001);
            SetPlayerVirtualWorld(playerid, 1);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 246.7372, 63.0483, 1003.6406) && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerInterior(playerid) == 6)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Intense Police Department!");
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerPos(playerid, 1555.2531, -1675.6143, 16.1953);
            SetPlayerFacingAngle(playerid, 272.0170);
            SetCameraBehindPlayer(playerid);
        }
        // sf
        if (IsPlayerInRangeOfPoint(playerid, 3.0, -1605.6638, 710.3925, 13.8672) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Intense Police Department!");
            SetPlayerInterior(playerid, 6);
            SetPlayerPos(playerid, 246.3961, 87.8423, 1003.6406);
            SetPlayerFacingAngle(playerid, 359.9001);
            SetPlayerVirtualWorld(playerid, 1);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 246.3961, 87.8423, 1003.6406) && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerInterior(playerid) == 6)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Intense Police Department!");
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerPos(playerid, -1605.6638, 710.3925, 13.8672);
            SetPlayerFacingAngle(playerid, 272.0170);
            SetCameraBehindPlayer(playerid);
        }
        // lv
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 2287.0984, 2432.3669, 10.8203) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Intense Police Department!");
            SetPlayerInterior(playerid, 6);
            SetPlayerPos(playerid, 242.2486, 66.3642, 1003.6406);
            SetPlayerFacingAngle(playerid, 359.9001);
            SetPlayerVirtualWorld(playerid, 1);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 242.2486, 66.3642, 1003.6406) && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerInterior(playerid) == 6)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Intense Police Department!");
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerPos(playerid, 2287.0984, 2432.3669, 10.8203);
            SetPlayerFacingAngle(playerid, 272.0170);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 691.5796, -1275.8766, 13.5607) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            if (PlayerInfo[playerid][pTeam] != 12) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Bounty Hunters!");
            SetPlayerInterior(playerid, 5);
            SetPlayerVirtualWorld(playerid, 2);
            SetPlayerPos(playerid, 1261.3009, -785.4238, 1091.9063);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 1261.3009, -785.4238, 1091.9063) && GetPlayerVirtualWorld(playerid) == 2 && GetPlayerInterior(playerid) == 5)
        {
            if (PlayerInfo[playerid][pTeam] != 12) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Bounty Hunters!");
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, 691.5796, -1275.8766, 13.5607);
            SetPlayerVirtualWorld(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 1259.6387, -785.5069, 92.0313) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            if (PlayerInfo[playerid][pTeam] != 21) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Bulgarian Mafia!");
            SetPlayerInterior(playerid, 5);
            SetPlayerVirtualWorld(playerid, 1);
            SetPlayerPos(playerid, 1261.3009, -785.4238, 1091.9063);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 1261.3009, -785.4238, 1091.9063) && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerInterior(playerid) == 5)
        {
            if (PlayerInfo[playerid][pTeam] != 21) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Bulgarian Mafia!");
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, 1259.6387, -785.5069, 92.0313);
            SetPlayerVirtualWorld(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        //Cripz - location - open
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 140.2198, 1365.9974, 1083.8594) && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerInterior(playerid) == 5) // vij tuka iska interior 0 i world 0 koet sh reche ot vunka da vliza v house
        {
            if (PlayerInfo[playerid][pTeam] != 6) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Vinewood Cripz!");
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerPos(playerid, 300.2113, -1154.4961, 81.3665);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 300.2113, -1154.4961, 81.3665) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0) // tuk iska ot virtual world 1 i interior id t.e. da izlizash ot house
        {
            if (PlayerInfo[playerid][pTeam] != 6) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Vinewood Cripz!");
            SetPlayerInterior(playerid, 5);
            SetPlayerPos(playerid, 140.1744, 1366.1003, 1083.8594);
            SetPlayerVirtualWorld(playerid, 1);
            SetCameraBehindPlayer(playerid);
        }
        //Cripz - location - close
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 2146.7976, -1470.4761, 26.0426) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            if (PlayerInfo[playerid][pTeam] != 3) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Rolling Heights Ballas!");
            SetPlayerInterior(playerid, 5);
            SetPlayerVirtualWorld(playerid, 1);
            SetPlayerPos(playerid, 318.5974, 1115.6239, 1083.8828);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 318.5974, 1115.6239, 1083.8828) && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerInterior(playerid) == 5)
        {
            if (PlayerInfo[playerid][pTeam] != 3) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Rolling Heights Ballas!");
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, 2146.7976, -1470.4761, 26.0426);
            SetPlayerVirtualWorld(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, -1754.2659, 964.0753, 24.8906) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            if (PlayerInfo[playerid][pTeam] != 16) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Soldier Boys!");
            SetPlayerInterior(playerid, 12);
            SetPlayerVirtualWorld(playerid, 1);
            SetPlayerPos(playerid, 2324.4341, -1149.4835, 1050.7101);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 2324.4341, -1149.4835, 1050.7101) && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerInterior(playerid) == 12)
        {
            if (PlayerInfo[playerid][pTeam] != 16) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Soldier Boys!");
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, -1754.2659, 964.0753, 24.8906);
            SetPlayerVirtualWorld(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 1083.0112, -1226.7196, 15.8203) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            if (PlayerInfo[playerid][pTeam] != 19) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Blood Mafia!");
            SetPlayerInterior(playerid, 1);
            SetPlayerVirtualWorld(playerid, 3);
            SetPlayerPos(playerid, 1416.6842, 3.6414, 1000.9269);
            SetPlayerFacingAngle(playerid, 90.9424);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 1416.6842, 3.6414, 1000.9269) && GetPlayerVirtualWorld(playerid) == 3 && GetPlayerInterior(playerid) == 1)
        {
            if (PlayerInfo[playerid][pTeam] != 19) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Blood Mafia!");
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, 1083.0112, -1226.7196, 15.8203);
            SetPlayerFacingAngle(playerid, 270.7975);
            SetPlayerVirtualWorld(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 2595.7300, 2790.6204, 10.8203) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            if (PlayerInfo[playerid][pTeam] != 17) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Yakuza!");
            SetPlayerInterior(playerid, 1);
            SetPlayerVirtualWorld(playerid, 2);
            SetPlayerPos(playerid, 1416.6842, 3.6414, 1000.9269);
            SetPlayerFacingAngle(playerid, 90.9424);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 1416.6842, 3.6414, 1000.9269) && GetPlayerVirtualWorld(playerid) == 2 && GetPlayerInterior(playerid) == 1)
        {
            if (PlayerInfo[playerid][pTeam] != 17) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Yakuza!");
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, 2595.7300, 2790.6204, 10.8203);
            SetPlayerFacingAngle(playerid, 270.7975);
            SetPlayerVirtualWorld(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, -2173.5759, 974.2741, 80.0000) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            if (PlayerInfo[playerid][pTeam] != 8) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на San Fierro Rifa!");
            SetPlayerInterior(playerid, 1);
            SetPlayerVirtualWorld(playerid, 1);
            SetPlayerPos(playerid, 1416.6842, 3.6414, 1000.9269);
            SetPlayerFacingAngle(playerid, 90.9424);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 1416.6842, 3.6414, 1000.9269) && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerInterior(playerid) == 1)
        {
            if (PlayerInfo[playerid][pTeam] != 8) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на San Fierro Rifa!");
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, -2173.5759, 974.2741, 80.0000);
            SetPlayerFacingAngle(playerid, 270.7975);
            SetPlayerVirtualWorld(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        //
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 1260.7024, -781.2197, 1091.9063) && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerInterior(playerid) == 5)
        {
            if (PlayerInfo[playerid][pTeam] != 21) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Bulgarian Mafia!");
            SetPlayerInterior(playerid, 1);
            SetPlayerVirtualWorld(playerid, 4);
            SetPlayerPos(playerid, 1416.6842, 3.6414, 1000.9269);
            SetPlayerFacingAngle(playerid, 90.9424);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 1416.6842, 3.6414, 1000.9269) && GetPlayerVirtualWorld(playerid) == 4 && GetPlayerInterior(playerid) == 1)
        {
            if (PlayerInfo[playerid][pTeam] != 21) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Bulgarian Mafia!");
            SetPlayerInterior(playerid, 5);
            SetPlayerPos(playerid, 1260.7024, -781.2197, 1091.9063);
            SetPlayerFacingAngle(playerid, 270.7975);
            SetPlayerVirtualWorld(playerid, 1);
            SetCameraBehindPlayer(playerid);
        }
        //
        //
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 2496.049804, -1695.238159, 1014.742187) && GetPlayerVirtualWorld(playerid) == 2 && GetPlayerInterior(playerid) == 3)
        {
            if (PlayerInfo[playerid][pTeam] != 18)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Syndicate Texas!");
                return 1;
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, 1733.4287, 2814.9548, 14.2735);
            SetPlayerFacingAngle(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 1733.4287, 2814.9548, 14.2735) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            if (PlayerInfo[playerid][pTeam] != 18)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Syndicate Texas!");
                return 1;
            }
            SetPlayerVirtualWorld(playerid, 2);
            SetPlayerInterior(playerid, 3);
            SetPlayerPos(playerid, 2496.049804, -1695.238159, 1014.742187);
            SetCameraBehindPlayer(playerid);
        }
        //
        if (IsPlayerInRangeOfPoint(playerid, 7.0, 2496.049804, -1695.238159, 1014.742187) && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerInterior(playerid) == 3)
        {
            if (PlayerInfo[playerid][pTeam] != 2)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Grove Street Families!");
                return 1;
            }
            SetPlayerVirtualWorld(playerid, 0);
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, 2495.3496, -1690.8401, 14.7656);
            SetPlayerFacingAngle(playerid, 0);
            SetCameraBehindPlayer(playerid);
        }
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 2495.3496, -1690.8401, 14.7656) && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
        {
            if (PlayerInfo[playerid][pTeam] != 2)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Grove Street Families!");
                return 1;
            }
            SetPlayerVirtualWorld(playerid, 1);
            SetPlayerInterior(playerid, 3);
            SetPlayerPos(playerid, 2496.049804, -1695.238159, 1014.742187);
            SetCameraBehindPlayer(playerid);
        }
    }
    if (inevent[playerid] == 1 && eenter == 0)
    {
        if (newkeys & 16)
        {
            if (PlayerInfo[playerid][pEvent] == 0)
            {
                SetPlayerHealth(playerid, 0);
            }
        }
    }
    if (inevent[playerid] == 1 && efight == 0)
    {
        if (newkeys & 4)
        {
            if (PlayerInfo[playerid][pEvent] == 0)
            {
                SetPlayerHealth(playerid, 0);
            }
        }
    }
    if (Jump[playerid] == 1)
    {
        if (newkeys & KEY_JUMP)
        {
            new Float:SuperJump[3];
            GetPlayerVelocity(playerid, SuperJump[0], SuperJump[1], SuperJump[2]);
            SetPlayerVelocity(playerid, SuperJump[0], SuperJump[1], SuperJump[2] + 6);
        }
    }
    //TELEPORTS - OPEN
    if (newkeys & 16)
    {
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 1237.1945, -2004.9026, 59.8630))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 2127.8530, -87.0102, 2.1304);
            SetPlayerFacingAngle(playerid, 270.5640);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 1247.4926, -2047.3232, 59.9830))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, -1334.5356, 2057.6985, 52.9396);
            SetPlayerFacingAngle(playerid, 270.5640);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 1213.1505, -2068.9939, 68.9775))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 1933.1718, 2184.6824, 10.8125);
            SetPlayerFacingAngle(playerid, 271.0992);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 852.7022, 851.3765, 13.3516))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 852.7022, 851.3765, 13.3516);
            SetPlayerFacingAngle(playerid, 270.5640);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 1226.9058, -2004.3683, 62.9966))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 852.8712, 851.4919, 13.3516);
            SetPlayerFacingAngle(playerid, 270.8762);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, -1334.0717, 2061.0530, 52.7941))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 1221.7103, -2037.3132, 65.2266);
            SetPlayerFacingAngle(playerid, 270.5640);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 849.7452, 849.4290, 13.2172))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 1221.7103, -2037.3132, 65.2266);
            SetPlayerFacingAngle(playerid, 270.5640);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 1221.8916, -2004.3669, 65.1029))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 587.8756, 1229.1365, 11.7188);
            SetPlayerFacingAngle(playerid, 270.5640);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 592.5229, 1232.9878, 11.7188))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 1221.7103, -2037.3132, 65.2266);
            SetPlayerFacingAngle(playerid, 270.5640);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 1216.6649, -2004.4821, 65.1027))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 402.0841, 2529.5537, 16.5748);
            SetPlayerFacingAngle(playerid, 270.5640);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 396.6920, 2529.6890, 16.5576))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 1221.7103, -2037.3132, 65.2266);
            SetPlayerFacingAngle(playerid, 270.5640);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 1237.1299, -2068.8193, 59.8614))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 76.4991, -258.7651, 1.5781);
            SetPlayerFacingAngle(playerid, 88.8651);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 76.3090, -263.6589, 1.5781))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 1221.7103, -2037.3132, 65.2266);
            SetPlayerFacingAngle(playerid, 270.5640);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 1226.6023, -2069.1226, 62.9998))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, -543.4083, 2592.2168, 53.5156);
            SetPlayerFacingAngle(playerid, 270.7858);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, -542.4196, 2586.2869, 53.5156))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 1221.7103, -2037.3132, 65.2266);
            SetPlayerFacingAngle(playerid, 270.5640);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 1232.2550, -2068.9458, 60.8984))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 1363.4863, 249.8157, 19.5669);
            SetPlayerFacingAngle(playerid, 270.5640);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 1363.7058, 253.9488, 19.5669))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 1221.7103, -2037.3132, 65.2266);
            SetPlayerFacingAngle(playerid, 270.5640);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 1216.4745, -2069.0505, 65.1019))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, -15.7992, -316.2803, 5.4229);
            SetPlayerFacingAngle(playerid, 270.5640);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, -15.7632, -319.8665, 5.4229))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 1221.7103, -2037.3132, 65.2266);
            SetPlayerFacingAngle(playerid, 270.5640);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 2138.3521,-86.4459,2.8588))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 1221.7103, -2037.3132, 65.2266);
            SetPlayerFacingAngle(playerid, 270.5640);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 279.1491, 1833.1394, 18.0874))
        {
            if (PlayerInfo[playerid][pTeam] != 15)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Intense Police Department!");
            }
            SetPlayerPos(playerid, -2250.2004, 2344.7747, 4.9807);
        }
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 2176.9324, 1990.1615, 10.8203))
        {
            if (GetPlayerVirtualWorld(playerid) == 0)
            {
                SendClientMessage(playerid, 0xC600C6FF, "Ти беше прехвърлен в другия Virtual World!");
                return SetPlayerVirtualWorld(playerid, 1);
            }
            if (GetPlayerVirtualWorld(playerid) == 1)
            {
                SendClientMessage(playerid, 0xC600C6FF, "Ти се върна в главния Virtual World!");
                return SetPlayerVirtualWorld(playerid, 0);
            }
        }
    }
    //TELEPORTS - CLOSE
    new Car, State, Float:x, Float:y, Float:z;
    Car = GetPlayerVehicleID(playerid);
    State = GetPlayerState(playerid);
    if (RELEASED(KEY_FIRE))
    {
        if (State == PLAYER_STATE_DRIVER)
        {
            if (Speed[playerid] == 1)
            {
                GetVehicleVelocity(Car, x, y, z);
                SetVehicleVelocity(Car, x * 2, y * 2, z * 2);
            }
        }
    }
    if (IsPlayerInRangeOfPoint(playerid, 1.0, 279.1491, 1833.1394, 18.0874))
    {
        if (PlayerInfo[playerid][pTeam] != 15)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Intense Police Department!");
        }
        SetPlayerPos(playerid, -2250.2004, 2344.7747, 4.9807);
    }
    if (GetVehicleModel(GetPlayerVirtualWorld(playerid)) == 431 ||
            GetVehicleModel(GetPlayerVirtualWorld(playerid)) == 437 ||
            GetVehicleModel(GetPlayerVirtualWorld(playerid)) == 508 ||
            GetVehicleModel(GetPlayerVirtualWorld(playerid)) == 431 ||
            GetVehicleModel(GetPlayerVirtualWorld(playerid)) == 573)
    {
        if (newkeys & 16)
        {
            new Float:vehx, Float:vehy, Float:vehz;
            GetVehiclePos(GetPlayerVirtualWorld(playerid), vehx, vehy, vehz);
            SetPlayerVirtualWorld(playerid, GetVehicleVirtualWorld(GetPlayerVirtualWorld(playerid)));
            //SetPlayerInterior(playerid,GetVehicleInterior(GetPlayerVirtualWorld(playerid)));
            SetPlayerInterior(playerid, 0);
            SetPlayerPos(playerid, vehx - 2, vehy, vehz);
        }
    }
    if (newkeys & 16)
    {
        if (IsPlayerInRangeOfPoint(playerid, 1.0, 1213.1766, -2004.3656, 68.9331))
        {
            if (PlayerInfo[playerid][pTeam] != 1)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            }
            SetPlayerPos(playerid, 2178.2373, 1990.8092, 10.8203);
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, 0);
        }
    }
    if (newkeys & 16)
    {
        if (IsPlayerInRangeOfPoint(playerid, 2.5, 267.1508, 82.2370, 1001.0391))
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Intense Police Department!");
            }
            if (lspdCell1open == false)
            {
                MoveObject(lspdCell1, 266.352783, 83.219932, 1001.280395, 3);
                lspdCell1open = true;
            }
            else
            {
                MoveObject(lspdCell1, 266.282501, 80.981002, 1001.280395, 3);
                lspdCell1open = false;
            }
        }
    }
    if (newkeys & 16)
    {
        if (IsPlayerInRangeOfPoint(playerid, 2.5, 267.0193, 86.9113, 1001.0391))
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Intense Police Department!");
            }
            if (lspdCell2open == false)
            {
                MoveObject(lspdCell2, 266.486785, 87.487892, 1001.280395, 3);
                lspdCell2open = true;
            }
            else
            {
                MoveObject(lspdCell2, 266.434112, 85.750198, 1001.271728, 3);
                lspdCell2open = false;
            }
        }
    }
    if (IsPlayerInRangeOfPoint(playerid, 15.0, 2237.7688, 2453.5955, 10.7848))
    {
        if (newkeys & KEY_SUBMISSION)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Intense Police Department!");
            }
            lvpdB1Timer = 10;
            MoveObject(lvpd1, 2238.197509, 2450.464599, 10.341962, 5.00, -4.799997, -1.600025, -89.499954); //-1.600025, -89.499954
            SendClientMessage(playerid, 0x0040FFFF, "IPD Barrier: Бариерата ще се затвори след 10 секунди!");
        }
    }
    if (IsPlayerInRangeOfPoint(playerid, 15.0, 2336.8582, 2443.3186, 6.1081))
    {
        if (newkeys & KEY_SUBMISSION)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE)
            {
                return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Intense Police Department!");
            }
            lvpdB2Timer = 10;
            MoveObject(lvpd2, 2335.417236, 2444.029785, 0.557772, 2.00, 0.000000, 0.000000, 59.200016);
            SendClientMessage(playerid, 0x0040FFFF, "IPD Gate: Портата ще се затвори след 10 секунди!");
        }
    }
    if (newkeys & 512)
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 1230.4954, -2005.5513, 60.8984) && GetPlayerVirtualWorld(playerid) == 0)
        {
            if (PlayerInfo[playerid][pTeam] != 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на VIP!");
            ShowPlayerDialog(playerid, 10, DIALOG_STYLE_LIST, "{FF0000}VIP's Gunmachine:", "Knife\nBaseball Bat\n9mm\nSilenced 9mm\nDesert Eagle\nShotgun\nSawnoff\nCombat Shotgun\nUzi\nMP5\nTec9\nAK47\nM4\nCountry Rifle\nSniper Rifle", "Избери", "Излез");
        }
    }
    if (newkeys & 512)
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, -691.5956, 935.6432, 13.6328) && GetPlayerVirtualWorld(playerid) == 0)
        {
            if (PlayerInfo[playerid][pTeam] != 11) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Italian Mafia!");
            ShowPlayerDialog(playerid, 10, DIALOG_STYLE_LIST, "{A9F5E1}Italian Mafia's Gunmachine:", "Knife\nBaseball Bat\n9mm\nSilenced 9mm\nDesert Eagle\nShotgun\nSawnoff\nCombat Shotgun\nUzi\nMP5\nTec9\nAK47\nM4\nCountry Rifle\nSniper Rifle", "Избери", "Излез");
        }
    }
    if (newkeys & 512)
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 1969.2216, 953.4484, 10.8203) && GetPlayerVirtualWorld(playerid) == 0)
        {
            if (PlayerInfo[playerid][pTeam] != 7) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на San Fierro Triads!");
            ShowPlayerDialog(playerid, 10, DIALOG_STYLE_LIST, "{F97804}Triads's Gunmachine:", "Knife\nBaseball Bat\n9mm\nSilenced 9mm\nDesert Eagle\nShotgun\nSawnoff\nCombat Shotgun\nUzi\nMP5\nTec9\nAK47\nM4\nCountry Rifle\nSniper Rifle", "Избери", "Излез");
        }
    }
    if (newkeys & 512)
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 252.5214, 70.3983, 1003.6406) && GetPlayerVirtualWorld(playerid) == 1)
        {
            if (PlayerInfo[playerid][pTeam] != FACTION_INTENSE_POLICE) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Intense Police Department!");
            ShowPlayerDialog(playerid, 10, DIALOG_STYLE_LIST, "{0040FF}IPD's Gunmachine:", "Knife\nBaseball Bat\n9mm\nSilenced 9mm\nDesert Eagle\nShotgun\nSawnoff\nCombat Shotgun\nUzi\nMP5\nTec9\nAK47\nM4\nCountry Rifle\nSniper Rifle\nRPG\nHeatseeker\nBomb", "Избери", "Излез");
        }
    }
    if (newkeys & 512)
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 2497.0251, -1703.2537, 1014.7422) && GetPlayerVirtualWorld(playerid) == 1)
        {
            if (PlayerInfo[playerid][pTeam] != 2) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Grove Street Families!");
            ShowPlayerDialog(playerid, 10, DIALOG_STYLE_LIST, "{33AA33}Grove's Gunmachine:", "Knife\nBaseball Bat\n9mm\nSilenced 9mm\nDesert Eagle\nShotgun\nSawnoff\nCombat Shotgun\nUzi\nMP5\nTec9\nAK47\nM4\nCountry Rifle\nSniper Rifle", "Избери", "Излез");
        }
    }
    if (newkeys & 512)
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 2497.0251, -1703.2537, 1014.7422) && GetPlayerVirtualWorld(playerid) == 2)
        {
            if (PlayerInfo[playerid][pTeam] != 18) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Syndicate Texas!");
            ShowPlayerDialog(playerid, 10, DIALOG_STYLE_LIST, "{276BA9}Syndicate Texas's Gunmachine:", "Knife\nBaseball Bat\n9mm\nSilenced 9mm\nDesert Eagle\nShotgun\nSawnoff\nCombat Shotgun\nUzi\nMP5\nTec9\nAK47\nM4\nCountry Rifle\nSniper Rifle", "Избери", "Излез");
        }
    }
    if (newkeys & 512)
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 2449.6282, -1696.3843, 1013.5078) && GetPlayerVirtualWorld(playerid) == 1)
        {
            if (PlayerInfo[playerid][pTeam] != 8) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на San Fierro Rifa!");
            ShowPlayerDialog(playerid, 10, DIALOG_STYLE_LIST, "{0080FF}Rifa's Gunmachine:", "Knife\nBaseball Bat\n9mm\nSilenced 9mm\nDesert Eagle\nShotgun\nSawnoff\nCombat Shotgun\nUzi\nMP5\nTec9\nAK47\nM4\nCountry Rifle\nSniper Rifle", "Избери", "Излез");
        }
    }
    if (newkeys & 512)
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 1267.0983, -784.8137, 1091.9063) && GetPlayerVirtualWorld(playerid) == 1)
        {
            if (PlayerInfo[playerid][pTeam] != 21) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Bulgarian Mafia!");
            ShowPlayerDialog(playerid, 10, DIALOG_STYLE_LIST, "{FF40FF}Bulgarian Mafia's Gunmachine:", "Knife\nBaseball Bat\n9mm\nSilenced 9mm\nDesert Eagle\nShotgun\nSawnoff\nCombat Shotgun\nUzi\nMP5\nTec9\nAK47\nM4\nCountry Rifle\nSniper Rifle", "Избери", "Излез");
        }
    }
    if (newkeys & 512)
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, -38.7398, 1078.9197, 20.2060) && GetPlayerVirtualWorld(playerid) == 0)
        {
            if (PlayerInfo[playerid][pTeam] != 20) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си член на Mara Salvatrucha 13!");
            ShowPlayerDialog(playerid, 10, DIALOG_STYLE_LIST, "{B7E1FF}Mara Salvatrucha 13's Gunmachine:", "Knife\nBaseball Bat\n9mm\nSilenced 9mm\nDesert Eagle\nShotgun\nSawnoff\nCombat Shotgun\nUzi\nMP5\nTec9\nAK47\nM4\nCountry Rifle\nSniper Rifle", "Избери", "Излез");
        }
    }
    if (newkeys & 16)
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 1801.0879, -1303.3047, 131.7344))
        {
            SetPlayerFacingAngle(playerid, 269.5069);
            SetPlayerPos(playerid, 1791.7509, -1303.8427, 125.7266);
        }
    }
    if (newkeys & 16)
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 1570.4105, -1337.3629, 16.4844) && GetPlayerVirtualWorld(playerid) == 0)
        {
            GivePlayerWeapon(playerid, WEAPON_PARACHUTE, 1);
            SetPlayerFacingAngle(playerid, 172.0359);
            SetPlayerPos(playerid, 1548.6501, -1363.8597, 326.2183);
        }
    }
    if (newkeys & 16)
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, 1548.6501, -1363.8597, 326.2183) && GetPlayerVirtualWorld(playerid) == 0)
        {
            SetPlayerPos(playerid, 1570.4105, -1337.3629, 16.4844);
        }
    }
    if (PlayerInfo[playerid][pVip] == 6 || CheckFreeVIP() == 1)
    {
        if (newkeys & KEY_YES)
        {
            if (driver[playerid] == 1)
            {
                GetPlayerPos(playerid, X[playerid], Y[playerid], Z[playerid]);
                new Float:currentVehAngle;
                GetVehicleZAngle(GetPlayerVehicleID(playerid), currentVehAngle);
                SetVehiclePos(GetPlayerVehicleID(playerid), X[playerid], Y[playerid], Z[playerid]);
                SetVehicleZAngle(GetPlayerVehicleID(playerid), currentVehAngle);
            }
        }
    }
    return 1;
}
