#include <YSI_Coding\y_hooks>

/*
* Lock Job Vehicles
*/
LockAllJobVehicles()
{
    VehicleToggleEngine(carpizza[1], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carpizza[2], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carpizza[3], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carpizza[4], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carpizza[5], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carpilot[1], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carpilot[2], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carpilot[3], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carpilot[4], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carpilot[5], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carsweeper[1], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carsweeper[2], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carsweeper[3], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carsweeper[4], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carcoalmine[1], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carcoalmine[2], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carcoalmine[3], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carcoalmine[4], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(cardeliver[1], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(cardeliver[2], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(cardeliver[3], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(cardeliver[4], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(cardeliver[5], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(cartruck[1], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(cartruck[2], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(cartruck[3], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(cartruck[4], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(cartruck[5], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carbus[1], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carbus[2], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carbus[3], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carbus[4], VEHICLE_PARAMS_OFF);
    VehicleToggleEngine(carbus[5], VEHICLE_PARAMS_OFF);
}

hook OnPlayerExitVehicle(playerid, vehicleid)
{
    if (onWork[playerid] == 1)
    {
        new Float:cx, Float:cy, Float:cz;
        GetPlayerPos(playerid, cx, cy, cz);
        SetPlayerPos(playerid, cx, cy, cz);
        PutPlayerInVehicle(playerid, vehicleid, 0);
    }
    if (loadedtext[playerid] == 1)
    {
        TextDrawHideForPlayer(playerid, vehstatus2[playerid]);
        TextDrawHideForPlayer(playerid, vehstatus[playerid]);
        loadedtext[playerid] = 0;
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

/*
* Hook
*/
hook OnPlayerEnterCheckpoint(playerid)
{
    if (onWork[playerid] == 1)
    {
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 431)
        {
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint1))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint2, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint2))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint3, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint3))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint4, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint4))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint5, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint5))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint6, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint6))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint7, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint7))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint8, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint8))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint9, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint9))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint10, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint10))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint11, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint11))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint12, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint12))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint13, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint13))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint14, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint14))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint15, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint15))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint16, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint16))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint17, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint17))
            {
                SetPlayerCheckpoint(playerid, BusCheckPoint18, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusCheckPoint18))
            {
                SetPlayerCheckpoint(playerid, BusTakePoint, 4.0);
                SendClientMessage(playerid, 0xB35900FF, "Ти премина през всички червени маркери, сега трябва да върнеш буса.");
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, BusTakePoint))
            {
                PlayerInfo[playerid][pAfterWork] = 30 * 60;
                DisablePlayerCheckpoint(playerid);
                SendClientMessage(playerid, 0xB35900FF, "Ти премина през всички маркери и получаваш 5,000$ и 5 EP.");
                GivePlayerMoney(playerid, 5000);
                GivePlayerEP(playerid, 5);
                onWork[playerid] = 0;
                VehicleToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_OFF);
                if (PlayerInfo[playerid][pVip] < 3)
                {
                    PlayerInfo[playerid][pBusTimerWorkAgain] = 60 * 60;
                }
                if (PlayerInfo[playerid][pVip] >= 3 && PlayerInfo[playerid][pVip] < 6)
                {
                    PlayerInfo[playerid][pBusTimerWorkAgain] = 30 * 60;
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 30 минути.");
                }
                if (PlayerInfo[playerid][pVip] == 6 || CheckFreeVIP() == 1)
                {
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 20 минути.");
                    SendClientMessage(playerid, 0xB35900FF, "Ти спечели 3 EP, защото си VIP Level 6.");
                    PlayerInfo[playerid][pBusTimerWorkAgain] = 20 * 60;
                    GivePlayerEP(playerid, 3);
                }
                RestartPlayerColor(playerid);
                GivePlayerMission(playerid);
            }
        }
    }
    if (onWork[playerid] == 1)
    {
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 406)
        {
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineCheckPoint1))
            {
                SetPlayerCheckpoint(playerid, CoalmineCheckPoint2, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineCheckPoint2))
            {
                SetPlayerCheckpoint(playerid, CoalmineCheckPoint3, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineCheckPoint3))
            {
                SetPlayerCheckpoint(playerid, CoalmineCheckPoint4, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineCheckPoint4))
            {
                SetPlayerCheckpoint(playerid, CoalmineCheckPoint5, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineCheckPoint5))
            {
                SetPlayerCheckpoint(playerid, CoalmineCheckPoint6, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineCheckPoint6))
            {
                SetPlayerCheckpoint(playerid, CoalmineCheckPoint7, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineCheckPoint7))
            {
                SetPlayerCheckpoint(playerid, CoalmineCheckPoint8, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineCheckPoint8))
            {
                SetPlayerCheckpoint(playerid, CoalmineTakePoint, 4.0);
                SendClientMessage(playerid, 0xB35900FF, "Ти премина през всички червени маркери, сега трябва да върнеш самосвала.");
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, CoalmineTakePoint))
            {
                //
                DisablePlayerCheckpoint(playerid);
                PlayerInfo[playerid][pAfterWork] = 30 * 60;
                SendClientMessage(playerid, 0xB35900FF, "Ти премина през всички маркери и получаваш 5,000$ и 5 EP.");
                GivePlayerMoney(playerid, 5000);
                GivePlayerEP(playerid, 5);
                onWork[playerid] = 0;
                VehicleToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_OFF);
                if (PlayerInfo[playerid][pVip] < 3)
                {
                    PlayerInfo[playerid][pCoalmineTimerWorkAgain] = 60 * 60;
                }
                if (PlayerInfo[playerid][pVip] >= 3 && PlayerInfo[playerid][pVip] < 6)
                {
                    PlayerInfo[playerid][pCoalmineTimerWorkAgain] = 30 * 60;
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 30 минути.");
                }
                if (PlayerInfo[playerid][pVip] == 6 || CheckFreeVIP() == 1)
                {
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 20 минути.");
                    SendClientMessage(playerid, 0xB35900FF, "Ти спечели 3 EP, защото си VIP Level 6.");
                    PlayerInfo[playerid][pCoalmineTimerWorkAgain] = 20 * 60;
                    GivePlayerEP(playerid, 3);
                }
                RestartPlayerColor(playerid);
                GivePlayerMission(playerid);
            }
        }
    }
    if (onWork[playerid] == 1)
    {
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 574)
        {
            if (IsPlayerInRangeOfPoint(playerid, 4.0, SweepCheckPoint1))
            {
                SetPlayerCheckpoint(playerid, SweepCheckPoint2, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, SweepCheckPoint2))
            {
                SetPlayerCheckpoint(playerid, SweepCheckPoint3, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, SweepCheckPoint3))
            {
                SetPlayerCheckpoint(playerid, SweepCheckPoint4, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, SweepCheckPoint4))
            {
                SetPlayerCheckpoint(playerid, SweepCheckPoint5, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, SweepCheckPoint5))
            {
                SetPlayerCheckpoint(playerid, SweepCheckPoint6, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, SweepCheckPoint6))
            {
                SetPlayerCheckpoint(playerid, SweepTakePoint, 4.0);
                SendClientMessage(playerid, 0xB35900FF, "Ти премина през всички червени маркери, сега трябва да върнеш превозното средство.");
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, SweepTakePoint))
            {
                //
                DisablePlayerCheckpoint(playerid);
                PlayerInfo[playerid][pAfterWork] = 30 * 60;
                SendClientMessage(playerid, 0xB35900FF, "Ти почисти всички улици и получаваш 5,000$ и 5 EP.");
                GivePlayerMoney(playerid, 5000);
                GivePlayerEP(playerid, 5);
                onWork[playerid] = 0;
                VehicleToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_OFF);
                if (PlayerInfo[playerid][pVip] < 3)
                {
                    PlayerInfo[playerid][pSweeperTimerWorkAgain] = 60 * 60;
                }
                if (PlayerInfo[playerid][pVip] >= 3 && PlayerInfo[playerid][pVip] < 6)
                {
                    PlayerInfo[playerid][pSweeperTimerWorkAgain] = 30 * 60;
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 30 минути.");
                }
                if (PlayerInfo[playerid][pVip] == 6 || CheckFreeVIP() == 1)
                {
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 20 минути.");
                    SendClientMessage(playerid, 0xB35900FF, "Ти спечели 3 EP, защото си VIP Level 6.");
                    PlayerInfo[playerid][pSweeperTimerWorkAgain] = 20 * 60;
                    GivePlayerEP(playerid, 3);
                }
                RestartPlayerColor(playerid);
                GivePlayerMission(playerid);
            }
        }
    }
    if (onWork[playerid] == 1)
    {
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 448)
        {
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaCheckPoint1))
            {
                SetPlayerCheckpoint(playerid, PizzaCheckPoint2, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaCheckPoint2))
            {
                SetPlayerCheckpoint(playerid, PizzaCheckPoint3, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaCheckPoint3))
            {
                SetPlayerCheckpoint(playerid, PizzaCheckPoint4, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaCheckPoint4))
            {
                SetPlayerCheckpoint(playerid, PizzaCheckPoint5, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaCheckPoint5))
            {
                SetPlayerCheckpoint(playerid, PizzaCheckPoint6, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaCheckPoint6))
            {
                SetPlayerCheckpoint(playerid, PizzaCheckPoint7, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaCheckPoint7))
            {
                SetPlayerCheckpoint(playerid, PizzaCheckPoint8, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaCheckPoint8))
            {
                SetPlayerCheckpoint(playerid, PizzaTakePoint, 4.0);
                SendClientMessage(playerid, 0xB35900FF, "Ти премина през всички червени маркери, сега трябва да върнеш мотора.");
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, PizzaTakePoint))
            {
                //
                DisablePlayerCheckpoint(playerid);
                PlayerInfo[playerid][pAfterWork] = 30 * 60;
                SendClientMessage(playerid, 0xB35900FF, "Ти достави всички пици и получаваш 5,000$ и 5 EP.");
                GivePlayerMoney(playerid, 5000);
                GivePlayerEP(playerid, 5);
                onWork[playerid] = 0;
                VehicleToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_OFF);
                if (PlayerInfo[playerid][pVip] < 3)
                {
                    PlayerInfo[playerid][pPizzaTimerWorkAgain] = 60 * 60;
                }
                if (PlayerInfo[playerid][pVip] >= 3 && PlayerInfo[playerid][pVip] < 6)
                {
                    PlayerInfo[playerid][pPizzaTimerWorkAgain] = 30 * 60;
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 30 минути.");
                }
                if (PlayerInfo[playerid][pVip] == 6 || CheckFreeVIP() == 1)
                {
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 20 минути.");
                    SendClientMessage(playerid, 0xB35900FF, "Ти спечели 3 EP, защото си VIP Level 6.");
                    PlayerInfo[playerid][pPizzaTimerWorkAgain] = 20 * 60;
                    GivePlayerEP(playerid, 3);
                }
                RestartPlayerColor(playerid);
                GivePlayerMission(playerid);
            }
        }
    }
    if (onWork[playerid] == 1)
    {
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 511)
        {
            if (IsPlayerInRangeOfPoint(playerid, 5.0, PilotCheckPoint1))
            {
                DisablePlayerCheckpoint(playerid);
                SetPlayerCheckpoint(playerid, PilotCheckPoint2, 5.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 5.0, PilotCheckPoint2))
            {
                DisablePlayerCheckpoint(playerid);
                SetPlayerCheckpoint(playerid, PilotCheckPoint3, 5.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 5.0, PizzaCheckPoint3))
            {
                DisablePlayerCheckpoint(playerid);
                SetPlayerCheckpoint(playerid, PilotTakePoint, 5.0);
                SendClientMessage(playerid, 0xB35900FF, "Ти премина през всички червени маркери, сега трябва да върнеш самолета.");
            }
            if (IsPlayerInRangeOfPoint(playerid, 10.0, PilotTakePoint))
            {
                //
                DisablePlayerCheckpoint(playerid);
                PlayerInfo[playerid][pAfterWork] = 30 * 60;
                //
                SendClientMessage(playerid, 0xB35900FF, "Ти достави всички пратки и получаваш 5,000$ и 5 EP.");
                GivePlayerMoney(playerid, 5000);
                GivePlayerEP(playerid, 5);
                onWork[playerid] = 0;
                VehicleToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_OFF);
                if (PlayerInfo[playerid][pVip] < 3)
                {
                    PlayerInfo[playerid][pPilotTimerWorkAgain] = 60 * 60;
                }
                if (PlayerInfo[playerid][pVip] >= 3 && PlayerInfo[playerid][pVip] < 6)
                {
                    PlayerInfo[playerid][pPilotTimerWorkAgain] = 30 * 60;
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 30 минути.");
                }
                if (PlayerInfo[playerid][pVip] == 6 || CheckFreeVIP() == 1)
                {
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 20 минути.");
                    SendClientMessage(playerid, 0xB35900FF, "Ти спечели 3 EP, защото си VIP Level 6.");
                    PlayerInfo[playerid][pPilotTimerWorkAgain] = 20 * 60;
                    GivePlayerEP(playerid, 3);
                }
                RestartPlayerColor(playerid);
                GivePlayerMission(playerid);
            }
        }
    }
    if (onWork[playerid] == 1)
    {
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 609)
        {
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint1))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint2, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint2))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint3, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint3))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint4, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint4))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint5, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint5))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint6, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint6))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint7, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint7))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint8, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint8))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint9, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint9))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint10, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint10))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint11, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint11))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint12, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint12))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint13, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint13))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint14, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint14))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint15, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint15))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint16, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint16))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint17, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint17))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint18, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint18))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint19, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint19))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint20, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint20))
            {
                SetPlayerCheckpoint(playerid, DeliverCheckPoint21, 4.0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverCheckPoint21))
            {
                SetPlayerCheckpoint(playerid, DeliverTakePoint, 4.0);
                SendClientMessage(playerid, 0xB35900FF, "Ти премина през всички червени маркери, сега трябва да върнеш буса.");
            }
            if (IsPlayerInRangeOfPoint(playerid, 4.0, DeliverTakePoint))
            {
                //
                DisablePlayerCheckpoint(playerid);
                PlayerInfo[playerid][pAfterWork] = 30 * 60;
                SendClientMessage(playerid, 0xB35900FF, "Ти достави всички пратки и получаваш 5,000$ и 5 EP.");
                GivePlayerMoney(playerid, 5000);
                GivePlayerEP(playerid, 5);
                onWork[playerid] = 0;
                VehicleToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_OFF);
                if (PlayerInfo[playerid][pVip] < 3)
                {
                    PlayerInfo[playerid][pDeliverTimerWorkAgain] = 60 * 60;
                }
                if (PlayerInfo[playerid][pVip] >= 3 && PlayerInfo[playerid][pVip] < 6)
                {
                    PlayerInfo[playerid][pDeliverTimerWorkAgain] = 30 * 60;
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 30 минути.");
                }
                if (PlayerInfo[playerid][pVip] == 6 || CheckFreeVIP() == 1)
                {
                    SendClientMessage(playerid, 0xB35900FF, "Твоето време за чакане до нова работа е 20 минути.");
                    SendClientMessage(playerid, 0xB35900FF, "Ти спечели 3 EP, защото си VIP Level 6.");
                    PlayerInfo[playerid][pDeliverTimerWorkAgain] = 20 * 60;
                    GivePlayerEP(playerid, 3);
                }
                RestartPlayerColor(playerid);
                GivePlayerMission(playerid);
            }
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

/*
* Hook
*/
hook OnPlayerStateChange(playerid, newstate, oldstate)
{
    if (newstate == PLAYER_STATE_DRIVER)
    {
        new vehicleid = GetPlayerVehicleID(playerid);
        if (vehicleid == mechanicDutyVehs[0] || vehicleid == mechanicDutyVehs[1] || vehicleid == mechanicDutyVehs[2] ||
                vehicleid == mechanicDutyVehs[3] || vehicleid == mechanicDutyVehs[4] || vehicleid == mechanicDutyVehs[5] ||
                vehicleid == mechanicDutyVehs[6] || vehicleid == mechanicDutyVehs[7])
        {
            VehicleToggleEngine(vehicleid, VEHICLE_PARAMS_OFF);
            SendClientMessage(playerid, 0x808000FF, "Трябва да платиш $150 за да ползваш Tow Truck! /epay или /exit ?");
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if (vehicleid == carpizza[5] || vehicleid == carpizza[4] || vehicleid == carpizza[3] || vehicleid == carpizza[2] || vehicleid == carpizza[1])
    {
        SendClientMessage(playerid, 0xB35900FF, "Pizza Deliver: За да започнеш работа като доставчик на пици напиши /pizza.");
    }
    if (vehicleid == carsweeper[5] || vehicleid == carsweeper[4] || vehicleid == carsweeper[3] || vehicleid == carsweeper[2] || vehicleid == carsweeper[1])
    {
        SendClientMessage(playerid, 0xB35900FF, "Sweeper: За да започнеш работа като чистач на улици напиши /sweep.");
    }
    if (vehicleid == carcoalmine[5] || vehicleid == carcoalmine[4] || vehicleid == carcoalmine[3] || vehicleid == carcoalmine[2] || vehicleid == carcoalmine[1])
    {
        SendClientMessage(playerid, 0xB35900FF, "Coalmine: За да започнеш работа като шофьор на самосвал напиши /coalmine.");
    }
    if (vehicleid == carpilot[5] || vehicleid == carpilot[4] || vehicleid == carpilot[3] || vehicleid == carpilot[2] || vehicleid == carpilot[1])
    {
        SendClientMessage(playerid, 0xB35900FF, "Pilot: За да започнеш работа като пилот напиши /pilot.");
    }
    if (vehicleid == carbus[5] || vehicleid == carbus[4] || vehicleid == carbus[3] || vehicleid == carbus[2] || vehicleid == carbus[1])
    {
        SendClientMessage(playerid, 0xB35900FF, "Bus: За да започнеш работа като шофьр напиши /bus.");
    }
    if (vehicleid == carboat[5] || vehicleid == carboat[4] || vehicleid == carboat[3] || vehicleid == carboat[2] || vehicleid == carboat[1])
    {
        SendClientMessage(playerid, 0xB35900FF, "Boat: За да започнеш работа като шофьр на лодка напиши /boat.");
    }
    if (vehicleid == cardeliver[5] || vehicleid == cardeliver[4] || vehicleid == cardeliver[3] || vehicleid == cardeliver[2] || vehicleid == cardeliver[1])
    {
        SendClientMessage(playerid, 0xB35900FF, "Deliver: За да започнеш работа като доставчик напиши /deliver.");
    }
    if (vehicleid == cartruck[5] || vehicleid == cartruck[4] || vehicleid == cartruck[3] || vehicleid == cartruck[2] || vehicleid == cartruck[1])
    {
        SendClientMessage(playerid, 0xB35900FF, "Truck: За да започнеш работа като тираджия напиши /truck.");
    }
    if (!ispassenger)
    {
        for (new i2 = 0; i2 < 43; i2++)
        {
            if (vehicleid == afterwork[i2])
            {
                if (PlayerInfo[playerid][pAfterWork] == 0)
                {
                    new Float:cx, Float:cy, Float:cz;
                    GetPlayerPos(playerid, cx, cy, cz);
                    SetPlayerPos(playerid, cx, cy, cz);
                    SendClientMessage(playerid, 0x636363FF, "Не можеш да караш това превозно средство, защото не си завършил скоро работа!");
                }
            }
        }

        for (new i2 = 0; i2 < 4; i2++)
        {
            if (vehicleid == fueltruck[i2])
            {
                if (PlayerInfo[playerid][pIFC] == 0)
                {
                    SendClientMessage(playerid, 0x636363FF, "Не можеш да караш това превозно средство, защото не си член на IFC!");
                    new Float:cx, Float:cy, Float:cz;
                    GetPlayerPos(playerid, cx, cy, cz);
                    SetPlayerPos(playerid, cx, cy, cz);
                }
                if (PlayerInfo[playerid][pIFCDuty] == 0)
                {
                    new Float:cx, Float:cy, Float:cz;
                    GetPlayerPos(playerid, cx, cy, cz);
                    SetPlayerPos(playerid, cx, cy, cz);
                    SendClientMessage(playerid, 0x636363FF, "Не можеш да караш това превозно средство, защото не си на служба!");
                }
            }
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerDeath(playerid, killerid, reason)
{
    if (onWork[playerid] == 1)
    {
        onWork[playerid] = 0;
        DisablePlayerRaceCheckpoint(playerid);
        DisablePlayerCheckpoint(playerid);
        SendClientMessage(playerid, 0xB35900FF, "Job: Ти умря и загуби твоята работа, но може да се пробваш отново!");
    }
    
    return Y_HOOKS_CONTINUE_RETURN_1;
}