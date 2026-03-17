/*
* General Pickups
*/
new ATMPICKUP[15];
new BIZPICKUP[22];
new FISHING;
new ROBPICKUP[2];
new ROBPICKUP2[3];
new ROBPICKUPBOX[2];
new VILNAPICKUP;
new TowerPickup[3];
new CarShopPickup[3];
new CarShopPickup2[3];
new ElevatorPickup[3];
new BankPickup[9];
new BankCommandPickup[3];
new WSPickup;
new OfficePickup;

/*
* Faction Pickups
*/
new BloodPickup[2];
new YakuzaPickup[2];
new BGMPickup[4];
new BallasPickup[2];
new SoldierPickup[2];
new RifaPickup[3];
new IPDPickup[6];
new CripzPickup[2];
new SyndicatePickup[2];
new BountyPickup[2];
new IPDDUTY;
new IFCDUTY;

/*
* Faction Heal and Armour
*/
new viphealarmour[2];
new grovehealarmour[2];
new ipdHealArmour[2];
new rifahealarmour[2];
new soldierhealarmour[2];
new cripzhealarmour[2];
new bgmhealarmour[2];
new yakuzahealarmour[2];
new blackstreethealarmour[2];
new syndicatehealarmour[2];
new bloodhealarmour[2];
new ms13healarmour[2];
new vagoshealarmour[2];
new triadshealarmour[2];
new italianhealarmour[2];
new nanghealarmour[2];
new bountyhealarmour[2];

/*
* Pickup Callback
*/
public OnPlayerPickUpPickup(playerid, pickupid)
{
    new Float:health;
    GetPlayerHealth(playerid, health);
    new Float:armour;
    GetPlayerArmour(playerid, armour);
    if (pickupid == rifahealarmour[0] && PlayerInfo[playerid][pTeam] == 8 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == rifahealarmour[1] && PlayerInfo[playerid][pTeam] == 8 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == ipdHealArmour[0] && PlayerInfo[playerid][pTeam] == 15 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == ipdHealArmour[1] && PlayerInfo[playerid][pTeam] == 15 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == viphealarmour[0] && PlayerInfo[playerid][pTeam] == 1 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == viphealarmour[1] && PlayerInfo[playerid][pTeam] == 1 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == grovehealarmour[0] && PlayerInfo[playerid][pTeam] == 2 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == grovehealarmour[1] && PlayerInfo[playerid][pTeam] == 2 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == soldierhealarmour[0] && PlayerInfo[playerid][pTeam] == 16 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == soldierhealarmour[1] && PlayerInfo[playerid][pTeam] == 16 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == cripzhealarmour[0] && PlayerInfo[playerid][pTeam] == 6 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == cripzhealarmour[1] && PlayerInfo[playerid][pTeam] == 6 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == bgmhealarmour[0] && PlayerInfo[playerid][pTeam] == 21 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == bgmhealarmour[1] && PlayerInfo[playerid][pTeam] == 21 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == yakuzahealarmour[0] && PlayerInfo[playerid][pTeam] == 17 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == yakuzahealarmour[1] && PlayerInfo[playerid][pTeam] == 17 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == blackstreethealarmour[0] && PlayerInfo[playerid][pTeam] == 22 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == blackstreethealarmour[1] && PlayerInfo[playerid][pTeam] == 22 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == syndicatehealarmour[0] && PlayerInfo[playerid][pTeam] == 18 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == syndicatehealarmour[1] && PlayerInfo[playerid][pTeam] == 18 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == bloodhealarmour[0] && PlayerInfo[playerid][pTeam] == 19 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == bloodhealarmour[1] && PlayerInfo[playerid][pTeam] == 19 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == ms13healarmour[0] && PlayerInfo[playerid][pTeam] == 20 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == ms13healarmour[1] && PlayerInfo[playerid][pTeam] == 20 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == vagoshealarmour[0] && PlayerInfo[playerid][pTeam] == 4 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == vagoshealarmour[1] && PlayerInfo[playerid][pTeam] == 4 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == triadshealarmour[0] && PlayerInfo[playerid][pTeam] == 4 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == triadshealarmour[1] && PlayerInfo[playerid][pTeam] == 4 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == italianhealarmour[0] && PlayerInfo[playerid][pTeam] == 4 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == italianhealarmour[1] && PlayerInfo[playerid][pTeam] == 4 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == nanghealarmour[0] && PlayerInfo[playerid][pTeam] == 10 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == nanghealarmour[1] && PlayerInfo[playerid][pTeam] == 10 && armour < 100.0) SetPlayerArmour(playerid, 100);
    if (pickupid == bountyhealarmour[0] && PlayerInfo[playerid][pTeam] == 12 && health < 100.0) SetPlayerHealth(playerid, 100);
    if (pickupid == bountyhealarmour[1] && PlayerInfo[playerid][pTeam] == 12 && armour < 100.0) SetPlayerArmour(playerid, 100);
    new alh = HouseByPickup[pickupid];
    if (IsValidHouse(alh))
    {
        isinhousepickup[playerid] = 1;
        onhousepick2[playerid] = 1;
        playerInHousePickup[playerid] = alh;
        //housetimer[playerid] = SetTimerEx("RemoveHousePick", 900, true, "i", playerid);
    }
    new alb = BizByPickup[pickupid];
    if (IsValidBiz(alb))
    {
        isinbizpickup[playerid] = 1;
        onbizpick2[playerid] = 1;
        playerInBizPickup[playerid] = alb;
        //biztimer[playerid] = SetTimerEx("RemoveBizPick", 900, true, "i", playerid);
    }
    new bizid = playerInBizPickup[pickupid];
    if (IsValidBiz(bizid))
    {
        if (IsPlayerInRangeOfPoint(playerid, 3, BizInfo[bizid][bX], BizInfo[bizid][bY], BizInfo[bizid][bZ]))
        {
            new bizstring[356];
            if (BizInfo[bizid][bOwner] == 0 && BizInfo[bizid][bFee] == 0)
            {
                format(bizstring, 356, "~y~Bussines For Sale~n~~r~%s~n~~w~PRICE:~g~ $%d~n~ ~w~Level: ~b~%d ~n~~w~PAYOUT: ~g~$%d",
                       BizInfo[bizid][bName], BizInfo[bizid][bPrice], BizInfo[bizid][bLevel], BizInfo[bizid][bPayOut]);
                GameTextForPlayer(playerid, bizstring, 1500, 3);
                return 1;
            }
            if (BizInfo[bizid][bOwner] == 0 && BizInfo[bizid][bFee] > 0)
            {
                format(bizstring, 356, "~y~Bussines For Sale~n~~r~%s~n~~w~PRICE:~g~ $%d~n~ ~w~Level: ~b~%d ~n~~w~ENTER FEE: ~y~$%d ~n~~w~PAYOUT: ~g~$%d",
                       BizInfo[bizid][bName], BizInfo[bizid][bPrice], BizInfo[bizid][bLevel], BizInfo[bizid][bFee], BizInfo[bizid][bPayOut]);
                GameTextForPlayer(playerid, bizstring, 1500, 3);
                return 1;
            }
            if (BizInfo[bizid][bOwner] == 1 && BizInfo[bizid][bFee] == 0)
            {
                format(bizstring, 356, "~r~%s~n~~w~Owner:~g~ %s ~n~~w~Level: ~b~%d ~n~~w~PAYOUT: ~g~$%d",
                       BizInfo[bizid][bName], BizInfo[bizid][bOwnerName], BizInfo[bizid][bLevel], BizInfo[bizid][bPayOut]);
                GameTextForPlayer(playerid, bizstring, 1500, 3);
                return 1;
            }
            if (BizInfo[bizid][bOwner] == 1 && BizInfo[bizid][bFee] > 0)
            {
                format(bizstring, 356, "~r~%s~n~~w~Owner:~g~ %s ~n~~w~Level: ~b~%d ~w~~n~ENTER FEE: ~y~$%d ~n~~w~PAYOUT: ~g~$%d",
                       BizInfo[bizid][bName], BizInfo[bizid][bOwnerName], BizInfo[bizid][bLevel], BizInfo[bizid][bFee], BizInfo[bizid][bPayOut]);
                GameTextForPlayer(playerid, bizstring, 1500, 3);
                return 1;
            }
        }
    }
    new houseid = playerInHousePickup[playerid];
    if (IsValidHouse(houseid))
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, HouseInfo[houseid][hX], HouseInfo[houseid][hY], HouseInfo[houseid][hZ]))
        {
            new housestring[256];
            if (HouseInfo[houseid][hOwner] == 1)
            {
                format(housestring, sizeof(housestring), "~w~Owner:~g~ %s~n~~w~Level: ~b~ %d~n~",
                       HouseInfo[houseid][hOwnerName],
                       HouseInfo[houseid][hLevel]);
                GameTextForPlayer(playerid, housestring, 1500, 3);
                return 1;
            }

            static const roomDesc[][] =
            {
                "3 ROOMS", "1 ROOM", "1 ROOM", "5 ROOMS", "6 ROOMS",
                "3 ROOMS", "3 ROOMS", "3 ROOMS", "7 ROOMS", "3 ROOMS",
                "4 ROOMS", "4 ROOMS", "7 ROOMS", "7 ROOMS", "4 ROOMS",
                "9 ROOMS", "9 ROOMS", "5 ROOMS", "2 ROOMS", "5 ROOMS",
                "5 ROOMS", "22 ROOMS", "4 ROOMS", "5 ROOMS", "5 ROOMS",
                "4 ROOMS"
            };

            new interior = HouseInfo[houseid][hInterior];
            new rooms[32] = "UNKNOWN";
            if (interior >= 1 && interior <= sizeof(roomDesc))
                format(rooms, sizeof(rooms), "%s", roomDesc[interior - 1]);

            format(housestring, sizeof(housestring),
                   "~y~House For Sale~n~~w~Description:~p~ %s~n~~w~Price:~g~ $%d~n~~w~Level: ~b~%d",
                   rooms, HouseInfo[houseid][hPrice], HouseInfo[houseid][hLevel]);

            GameTextForPlayer(playerid, housestring, 1500, 3);
            return 1;
        }
    }
    if (pickupid == BankPickup[5] && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerPos(playerid, 2307.1792, -15.6580, 28.3014);
        SetPlayerFacingAngle(playerid, 267.51);
        TogglePlayerControllable(playerid, 0);
        SetCameraBehindPlayer(playerid);
        PlayerInfo[playerid][pBankSpawn] = 3;
        SetPlayerVirtualWorld(playerid, 3);
        return 1;
    }
    if (pickupid == BankPickup[0] && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerPos(playerid, 2307.1792, -15.6580, 28.3014);
        SetPlayerFacingAngle(playerid, 267.51);
        TogglePlayerControllable(playerid, 0);
        SetCameraBehindPlayer(playerid);
        PlayerInfo[playerid][pBankSpawn] = 3;
        SetPlayerVirtualWorld(playerid, 1);
        return 1;
    }
    //other bank pickups - location - open
    if (pickupid == BankPickup[6] && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, 322.4386, 111.3972, 1003.2194);
        SetPlayerFacingAngle(playerid, 267.51);
        TogglePlayerControllable(playerid, 0);
        SetCameraBehindPlayer(playerid);
        PlayerInfo[playerid][pBankSpawn] = 3;
        SetPlayerVirtualWorld(playerid, 1);
        return 1;
    }
    if (pickupid == BankPickup[7] && GetPlayerVirtualWorld(playerid) == 2 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, 322.4386, 111.3972, 1003.2194);
        SetPlayerFacingAngle(playerid, 267.51);
        TogglePlayerControllable(playerid, 0);
        SetCameraBehindPlayer(playerid);
        PlayerInfo[playerid][pBankSpawn] = 3;
        SetPlayerVirtualWorld(playerid, 1);
        return 1;
    }
    if (pickupid == BankPickup[8] && GetPlayerVirtualWorld(playerid) == 3 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerInterior(playerid, 0);
        SetPlayerPos(playerid, 322.4386, 111.3972, 1003.2194);
        SetPlayerFacingAngle(playerid, 267.51);
        TogglePlayerControllable(playerid, 0);
        SetCameraBehindPlayer(playerid);
        PlayerInfo[playerid][pBankSpawn] = 3;
        SetPlayerVirtualWorld(playerid, 1);
        return 1;
    }
    //other bank pickups - location - close
    if (pickupid == BankPickup[1] && GetPlayerVirtualWorld(playerid) == 0 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerPos(playerid, 2307.1792, -15.6580, 28.3014);
        SetPlayerFacingAngle(playerid, 267.51);
        TogglePlayerControllable(playerid, 0);
        SetCameraBehindPlayer(playerid);
        PlayerInfo[playerid][pBankSpawn] = 3;
        SetPlayerVirtualWorld(playerid, 2);
        return 1;
    }
    if (pickupid == BankPickup[2] && GetPlayerVirtualWorld(playerid) == 1 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerPos(playerid, 1481.3755, -1769.8796, 18.7958);
        SetPlayerFacingAngle(playerid, 0.3163);
        SetCameraBehindPlayer(playerid);
        SetPlayerVirtualWorld(playerid, 0);
        return 1;
    }
    if (pickupid == BankPickup[3] && GetPlayerVirtualWorld(playerid) == 2 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerPos(playerid, 2414.5371, 1123.8458, 10.8203);
        SetPlayerFacingAngle(playerid, 272.9833);
        SetCameraBehindPlayer(playerid);
        SetPlayerVirtualWorld(playerid, 0);
        return 1;
    }
    if (pickupid == BankPickup[4] && GetPlayerVirtualWorld(playerid) == 3 && GetPlayerInterior(playerid) == 0)
    {
        SetPlayerPos(playerid, -1494.9438, 920.4615, 7.1875);
        SetPlayerFacingAngle(playerid, 92.1882);
        SetCameraBehindPlayer(playerid);
        SetPlayerVirtualWorld(playerid, 0);
        return 1;
    }
    if (pickupid == BankCommandPickup[0])
    {
        GameTextForPlayer(playerid, "~g~LOS SANTOS BANK ~n~~w~/bank /transfer", 2000, 3);
        return 1;
    }
    if (pickupid == BankCommandPickup[1])
    {
        GameTextForPlayer(playerid, "~g~LAS VENTURAS BANK ~n~~w~/bank /transfer", 2000, 3);
        return 1;
    }
    if (pickupid == BankCommandPickup[2])
    {
        GameTextForPlayer(playerid, "~g~SAN FIERRO BANK ~n~~w~/bank /transfer", 2000, 3);
        return 1;
    }
    if (pickupid == IFCDUTY)
    {
        GameTextForPlayer(playerid, "~g~IFC DUTY~n~~w~/ifcduty", 2000, 3);
        return 1;
    }
    if (pickupid == WSPickup)
    {
        GameTextForPlayer(playerid, "~r~WEAPON SKILL~n~~w~/buyws", 2000, 3);
        return 1;
    }
    if (pickupid == IPDDUTY)
    {
        GameTextForPlayer(playerid, "~b~Intense Police Department DUTY~n~~w~/policeduty", 2000, 3);
        return 1;
    }
    if (pickupid == RifaPickup[0])
    {
        GameTextForPlayer(playerid, "~b~RIFA HOUSE~n~~w~TYPE ~r~/ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == CripzPickup[0])
    {
        GameTextForPlayer(playerid, "~b~VCRIPZ HOUSE~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == CripzPickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BGMPickup[2])
    {
        GameTextForPlayer(playerid, "~p~BGMAFIA DM BIZ~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BGMPickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BGMPickup[0])
    {
        GameTextForPlayer(playerid, "~p~BGMAFIA HOUSE~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BountyPickup[0])
    {
        GameTextForPlayer(playerid, "~g~BOUNTY HUNTERS HOUSE~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BountyPickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BGMPickup[3])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == SoldierPickup[0])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == SoldierPickup[1])
    {
        GameTextForPlayer(playerid, "~p~SOLDIER HOUSE~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BallasPickup[0])
    {
        GameTextForPlayer(playerid, "~p~BALLAS HOUSE~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BallasPickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == RifaPickup[1])
    {
        GameTextForPlayer(playerid, "~b~RIFA DM BIZ~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == RifaPickup[2])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BloodPickup[0])
    {
        GameTextForPlayer(playerid, "~r~BLOOD MAFIA DM BIZ~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == BloodPickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == YakuzaPickup[0])
    {
        GameTextForPlayer(playerid, "~y~YAKUZA DM BIZ~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == YakuzaPickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == SyndicatePickup[0])
    {
        GameTextForPlayer(playerid, "~b~SYNDICATE TEXAS HOUSE~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == SyndicatePickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == IPDPickup[0])
    {
        GameTextForPlayer(playerid, "~b~IPD LS~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == IPDPickup[1])
    {
        GameTextForPlayer(playerid, "~b~TELEPORT LS~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == IPDPickup[2])
    {
        GameTextForPlayer(playerid, "~b~IPD SF~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == IPDPickup[3])
    {
        GameTextForPlayer(playerid, "~b~TELEPORT SF~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == IPDPickup[4])
    {
        GameTextForPlayer(playerid, "~b~IPD LV~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == IPDPickup[5])
    {
        GameTextForPlayer(playerid, "~b~TELEPORT LV~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == OfficePickup)
    {
        GameTextForPlayer(playerid, "~w~INTENSE ~g~OFFICE ~r~CENTER~n~~n~~y~TYPE /buyoffice~n~~p~INFO: ~w~/helpoffice /office", 2000, 3);
        return 1;
    }
    if (pickupid == TowerPickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == TowerPickup[0])
    {
        GameTextForPlayer(playerid, "~g~LOS SANTOS TOWER~n~~n~~w~PRESS ~r~ENTER", 2000, 3);
        return 1;
    }
    if (pickupid == ROBPICKUP[0])
    {
        GameTextForPlayer(playerid, "~r~robbery start point~n~~w~/robbery", 2000, 3);
        return 1;
    }
    if (pickupid == ROBPICKUP[1])
    {
        GameTextForPlayer(playerid, "~r~robbery start point~n~~w~/robbery", 2000, 3);
        return 1;
    }
    if (pickupid == ROBPICKUP2[0])
    {
        GameTextForPlayer(playerid, "~g~TO START STEALING MONEY~w~~n~TYPE /rob", 2000, 3);
        return 1;
    }
    if (pickupid == ROBPICKUP2[1])
    {
        GameTextForPlayer(playerid, "~g~TO START STEALING MONEY~w~~n~TYPE /rob", 2000, 3);
        return 1;
    }
    if (pickupid == ROBPICKUP2[2])
    {
        GameTextForPlayer(playerid, "~g~TO START STEALING MONEY~w~~n~TYPE /rob", 2000, 3);
        return 1;
    }
    if (pickupid == ElevatorPickup[1])
    {
        GameTextForPlayer(playerid, "~w~PRESS ~r~enter", 2000, 3);
        return 1;
    }
    if (pickupid == ElevatorPickup[0])
    {
        GivePlayerWeapon(playerid, WEAPON_PARACHUTE, 1);
        SetPlayerPos(playerid, 1803.9323, -1300.1918, 131.7344);
        return 1;
    }
    if (pickupid == CarShopPickup[0])
    {
        GameTextForPlayer(playerid, "~b~INTENSE SHOWROOM ~n~~w~TYPE: ~r~/enter", 2000, 3);
        return 1;
    }
    if (pickupid == CarShopPickup[1])
    {
        GameTextForPlayer(playerid, "~w~TYPE: ~r~/EXIT", 2000, 3);
        return 1;
    }
    if (pickupid == CarShopPickup2[0])
    {
        GameTextForPlayer(playerid, "~b~INTENSE SHOWROOM ~n~~w~TYPE: ~r~/enter", 2000, 3);
        return 1;
    }
    if (pickupid == CarShopPickup2[1])
    {
        GameTextForPlayer(playerid, "~w~TYPE: ~r~/EXIT", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[0])
    {
        GameTextForPlayer(playerid, "~b~BAR~n~~w~/DRINK", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[1])
    {
        GameTextForPlayer(playerid, "~g~Ammu-nation~n~~w~/buy~n~/HEAL~r~ FOR ARMOUR ONLY $100", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[2])
    {
        GameTextForPlayer(playerid, "~b~DRIVING SCHOOL~n~~w~/DMV", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[3])
    {
        GameTextForPlayer(playerid, "~g~GENERAL STORE~n~~w~/BUY", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[4])
    {
        GameTextForPlayer(playerid, "~r~CLOTHES SHOP~n~~w~/buy", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[5])
    {
        GameTextForPlayer(playerid, "~y~BURGER SHOT~n~~w~/BUY", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[6])
    {
        return 1;
    }
    if (pickupid == BIZPICKUP[7])
    {
        GameTextForPlayer(playerid, "~r~CLOTHES SHOP~n~~w~/buy", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[8])
    {
        GameTextForPlayer(playerid, "~g~DISCO~n~~w~/DRINK", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[9])
    {
        GameTextForPlayer(playerid, "~p~SEX SHOP~n~~w~/BUY", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[10])
    {
        GameTextForPlayer(playerid, "~w~LEARN NEW WAYS TO ~g~FIGHT!~n~~n~~b~/train", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[16])
    {
        GameTextForPlayer(playerid, "~w~LEARN NEW WAYS TO ~g~FIGHT!~n~~n~~b~/train", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[17])
    {
        GameTextForPlayer(playerid, "~r~HOUSE ARMOUR~n~~b~10 PACKAGES~w~ - ~g~$20000~n~~w~/buyarmour", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[18])
    {
        GameTextForPlayer(playerid, "~r~DRUG STORE~n~~w~/buydrug", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[19])
    {
        GameTextForPlayer(playerid, "~b~BAR~n~~w~/DRINK", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[20])
    {
        GameTextForPlayer(playerid, "~b~DRUGS/GUNS/HEAL~n~~w~/BUYDRUG ~g~/BUY ~r~/HEAL", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[11])
    {
        GameTextForPlayer(playerid, "~g~STRIP CLUB~n~~w~/DRINK", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[12])
    {
        GameTextForPlayer(playerid, "~y~CLUCKIN' BELL~n~~w~/BUY", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[13])
    {
        GameTextForPlayer(playerid, "~r~Restaurant~n~~w~/BUY", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[14])
    {
        GameTextForPlayer(playerid, "~g~ADVERTISIMENT~n~~w~/ADVERT", 2000, 3);
        return 1;
    }
    if (pickupid == BIZPICKUP[15])
    {
        GameTextForPlayer(playerid, "~g~GENERAL STORE~n~~w~/BUY", 2000, 3);
        return 1;
    }
    if (pickupid == VILNAPICKUP)
    {
        GameTextForPlayer(playerid, "~y~village zone~n~~r~PRESS ~w~ENTER", 2000, 3);
        return 1;
    }
    for (new i2 = 0; i2 < 14; i2++)
    {
        if (pickupid == ATMPICKUP[i2])
        {
            GameTextForPlayer(playerid, "~w~USE ~g~/ATM", 2000, 3);
            return 1;
        }
    }
    return 1;
}