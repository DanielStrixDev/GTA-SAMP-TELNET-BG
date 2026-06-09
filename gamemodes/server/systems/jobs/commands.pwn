CMD:bus(playerid, params[])
{
    if (GetPlayerVehicleID(playerid) == carbus[1] || GetPlayerVehicleID(playerid) == carbus[2] || GetPlayerVehicleID(playerid) == carbus[3] || GetPlayerVehicleID(playerid) == carbus[4] || GetPlayerVehicleID(playerid) == carbus[5])
    {
        new pizzastring[256];
        if (PlayerInfo[playerid][pBusTimerWorkAgain] != 0)
        {
            format(pizzastring, 256, "Не можеш да работиш тази работа в момента.");
            SendClientMessage(playerid, COLOR_GRAD1, pizzastring);
            return 1;
        }
        if (PlayerInfo[playerid][pWanted] > 0 && PlayerInfo[playerid][pADuty] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си издирван!");
            return 1;
        }
        if (PlayerInfo[playerid][pADuty] > 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си ADMIN ON-DUTY!");
            return 1;
        }
        if (PlayerInfo[playerid][pIFCDuty] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си IFC ON-DUTY!");
        if (cmn1[playerid] > 0)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си CMN1!");
        }
        if (playerInDuel[playerid] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си в дуел!");
        }
        if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се работиш, докато си в евент!");
        if (playerInDMON[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си в DMON!");
        onWork[playerid] = 1;
        gpsOn[playerid] = false;
        SetPlayerColor(playerid, 0xD8844DFF);
        DisablePlayerRaceCheckpoint(playerid);
        DisablePlayerCheckpoint(playerid);
        VehicleToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_ON);
        SetPlayerCheckpoint(playerid, BusCheckPoint1, 4.0);
        format(pizzastring, 256, "Bus: Ти започна работа като шофьор на автобус и сега трябва да следваш червените маркери.");
        SendClientMessage(playerid, 0xB35900FF, pizzastring);
        return 1;
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си в превозното средство, за да започнеш работа!");
    }
    return 1;
}
CMD:coalmine(playerid, params[])
{
    if (GetPlayerVehicleID(playerid) == carcoalmine[1] || GetPlayerVehicleID(playerid) == carcoalmine[2] || GetPlayerVehicleID(playerid) == carcoalmine[3] || GetPlayerVehicleID(playerid) == carcoalmine[4])
    {
        new pizzastring[256];
        if (PlayerInfo[playerid][pCoalmineTimerWorkAgain] != 0)
        {
            format(pizzastring, 256, "Не можеш да работиш тази работа в момента.");
            SendClientMessage(playerid, COLOR_GRAD1, pizzastring);
            return 1;
        }
        if (PlayerInfo[playerid][pWanted] > 0 && PlayerInfo[playerid][pADuty] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си издирван!");
            return 1;
        }
        if (PlayerInfo[playerid][pADuty] > 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си ADMIN ON-DUTY!");
            return 1;
        }
        if (PlayerInfo[playerid][pIFCDuty] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си IFC ON-DUTY!");
        if (cmn1[playerid] > 0)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си CMN1!");
        }
        if (playerInDuel[playerid] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си в дуел!");
        }
        if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се работиш, докато си в евент!");
        if (playerInDMON[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си в DMON!");
        if (cmn1[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си CMN1!");
        onWork[playerid] = 1;
        gpsOn[playerid] = false;
        DisablePlayerRaceCheckpoint(playerid);
        DisablePlayerCheckpoint(playerid);
        SetPlayerColor(playerid, 0xD8844DFF);
        VehicleToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_ON);
        SetPlayerCheckpoint(playerid, CoalmineCheckPoint1, 4.0);
        format(pizzastring, 256, "Coalmine: Ти започна работа като шофьор на самосвал и сега трябва да следваш червените маркери.");
        SendClientMessage(playerid, 0xB35900FF, pizzastring);
        return 1;
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си в превозното средство, за да започнеш работа!");
    }
    return 1;
}
CMD:sweep(playerid, params[])
{
    if (GetPlayerVehicleID(playerid) == carsweeper[1] || GetPlayerVehicleID(playerid) == carsweeper[2] || GetPlayerVehicleID(playerid) == carsweeper[3] || GetPlayerVehicleID(playerid) == carsweeper[4])
    {
        new pizzastring[256];
        if (PlayerInfo[playerid][pSweeperTimerWorkAgain] != 0)
        {
            format(pizzastring, 256, "Не можеш да работиш тази работа в момента.");
            SendClientMessage(playerid, COLOR_GRAD1, pizzastring);
            return 1;
        }
        if (PlayerInfo[playerid][pWanted] > 0 && PlayerInfo[playerid][pADuty] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си издирван!");
            return 1;
        }
        if (PlayerInfo[playerid][pADuty] > 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си ADMIN ON-DUTY!");
            return 1;
        }
        if (PlayerInfo[playerid][pIFCDuty] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си IFC ON-DUTY!");
        if (cmn1[playerid] > 0)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си CMN1!");
        }
        if (playerInDuel[playerid] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си в дуел!");
        }
        if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се работиш, докато си в евент!");
        if (playerInDMON[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си в DMON!");
        onWork[playerid] = 1;
        gpsOn[playerid] = false;
        SetPlayerColor(playerid, 0xD8844DFF);
        DisablePlayerRaceCheckpoint(playerid);
        DisablePlayerCheckpoint(playerid);
        VehicleToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_ON);
        SetPlayerCheckpoint(playerid, SweepCheckPoint1, 4.0);
        format(pizzastring, 256, "Sweeper: Ти започна работа като чистач на улици и сега трябва да следваш червените маркери.");
        SendClientMessage(playerid, 0xB35900FF, pizzastring);
        return 1;
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си в превозното средство, за да започнеш работа!");
    }
    return 1;
}
CMD:leavejob(playerid, params[])
{
    if (onWork[playerid] == 1)
    {
        if (PlayerInfo[playerid][pWanted] > 0 && PlayerInfo[playerid][pADuty] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си издирван!");
            return 1;
        }
        if (PlayerInfo[playerid][pADuty] > 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си ADMIN ON-DUTY!");
            return 1;
        }
        if (PlayerInfo[playerid][pIFCDuty] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си IFC ON-DUTY!");
        new pizzastring[256];
        VehicleToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_OFF);
        format(pizzastring, 256, "Job: Ти напусна твоята работа, ела отново!");
        SendClientMessage(playerid, 0xB35900FF, pizzastring);
        onWork[playerid] = 0;
        DisablePlayerRaceCheckpoint(playerid);
        DisablePlayerCheckpoint(playerid);
        RestartPlayerColor(playerid);
        return 1;
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "В момента не си на работа и не можеш да използваш тази команда!");
    }
    return 1;
}
CMD:pizza(playerid, params[])
{
    if (GetPlayerVehicleID(playerid) == carpizza[1] || GetPlayerVehicleID(playerid) == carpizza[2] || GetPlayerVehicleID(playerid) == carpizza[3] || GetPlayerVehicleID(playerid) == carpizza[4] || GetPlayerVehicleID(playerid) == carpizza[5] || GetPlayerVehicleID(playerid) == carpizza[6])
    {
        if (PlayerInfo[playerid][pWanted] > 0 && PlayerInfo[playerid][pADuty] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си издирван!");
            return 1;
        }
        if (cmn1[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си CMN1!");
        if (PlayerInfo[playerid][pADuty] > 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си ADMIN ON-DUTY!");
            return 1;
        }
        if (PlayerInfo[playerid][pIFCDuty] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си IFC ON-DUTY!");
        new pizzastring[256];
        if (PlayerInfo[playerid][pPizzaTimerWorkAgain] != 0)
        {
            format(pizzastring, 256, "Не можеш да работиш тази работа в момента.");
            SendClientMessage(playerid, COLOR_GRAD1, pizzastring);
            return 1;
        }
        if (cmn1[playerid] > 0)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си CMN1!");
        }
        if (playerInDuel[playerid] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си в дуел!");
        }
        if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се работиш, докато си в евент!");
        if (playerInDMON[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си в DMON!");
        onWork[playerid] = 1;
        gpsOn[playerid] = false;
        SetPlayerColor(playerid, 0xD8844DFF);
        DisablePlayerRaceCheckpoint(playerid);
        DisablePlayerCheckpoint(playerid);
        PlayerInfo[playerid][pJob] = 1;
        VehicleToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_ON);
        SetPlayerCheckpoint(playerid, PizzaCheckPoint1, 4.0);
        format(pizzastring, 256, "Pizza Deliver: Ти започна работа като доставчик на пица и сега трябва да следваш червените маркери.");
        SendClientMessage(playerid, 0xB35900FF, pizzastring);
        return 1;
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си в мотора, за да започнеш работа!");
    }
    return 1;
}
CMD:deliver(playerid, params[])
{
    if (GetPlayerVehicleID(playerid) == cardeliver[1] || GetPlayerVehicleID(playerid) == cardeliver[2] || GetPlayerVehicleID(playerid) == cardeliver[3] || GetPlayerVehicleID(playerid) == cardeliver[4] || GetPlayerVehicleID(playerid) == cardeliver[5])
    {
        if (PlayerInfo[playerid][pWanted] > 0 && PlayerInfo[playerid][pADuty] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си издирван!");
            return 1;
        }
        if (cmn1[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си CMN1!");
        if (PlayerInfo[playerid][pADuty] > 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си ADMIN ON-DUTY!");
            return 1;
        }
        if (PlayerInfo[playerid][pIFCDuty] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си IFC ON-DUTY!");
        new pizzastring[500];
        if (PlayerInfo[playerid][pDeliverTimerWorkAgain] != 0)
        {
            format(pizzastring, 256, "Не можеш да работиш тази работа в момента.");
            SendClientMessage(playerid, COLOR_GRAD1, pizzastring);
            return 1;
        }
        if (cmn1[playerid] > 0)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си CMN1!");
        }
        if (playerInDuel[playerid] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си в дуел!");
        }
        if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се работиш, докато си в евент!");
        if (playerInDMON[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си в DMON!");
        onWork[playerid] = 1;
        gpsOn[playerid] = false;
        SetPlayerColor(playerid, 0xD8844DFF);
        DisablePlayerRaceCheckpoint(playerid);
        DisablePlayerCheckpoint(playerid);
        VehicleToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_ON);
        SetPlayerCheckpoint(playerid, DeliverCheckPoint1, 4.0);
        format(pizzastring, 500, "Deliver: Ти започна работа като доставчик и сега трябва да следваш червените маркери.");
        SendClientMessage(playerid, 0xB35900FF, pizzastring);
        return 1;
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си в буса, за да започнеш работа!");
    }
    return 1;
}
CMD:pilot(playerid, params[])
{
    if (GetPlayerVehicleID(playerid) == carpilot[1] || GetPlayerVehicleID(playerid) == carpilot[2] || GetPlayerVehicleID(playerid) == carpilot[3] || GetPlayerVehicleID(playerid) == carpilot[4] || GetPlayerVehicleID(playerid) == carpilot[5])
    {
        if (PlayerInfo[playerid][pWanted] > 0 && PlayerInfo[playerid][pADuty] == 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си издирван!");
            return 1;
        }
        if (PlayerInfo[playerid][pADuty] > 0)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си ADMIN ON-DUTY!");
            return 1;
        }
        if (PlayerInfo[playerid][pIFCDuty] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си IFC ON-DUTY!");
        if (cmn1[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си CMN1!");
        new pizzastring[500];
        if (PlayerInfo[playerid][pPilotTimerWorkAgain] != 0)
        {
            format(pizzastring, 256, "Не можеш да работиш тази работа в момента.");
            SendClientMessage(playerid, COLOR_GRAD1, pizzastring);
            return 1;
        }
        if (cmn1[playerid] > 0)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си CMN1!");
        }
        if (playerInDuel[playerid] == 1)
        {
            return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си в дуел!");
        }
        if (inevent[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да се работиш, докато си в евент!");
        if (playerInDMON[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да работиш, докато си в DMON!");
        onWork[playerid] = 1;
        gpsOn[playerid] = false;
        SetPlayerColor(playerid, 0xD8844DFF);
        DisablePlayerRaceCheckpoint(playerid);
        DisablePlayerCheckpoint(playerid);
        VehicleToggleEngine(GetPlayerVehicleID(playerid), VEHICLE_PARAMS_ON);
        SetPlayerCheckpoint(playerid, PilotCheckPoint1, 5.0);
        format(pizzastring, 500, "Pilot: Ти започна работа като пилот и сега трябва да следваш червените маркери.");
        SendClientMessage(playerid, 0xB35900FF, pizzastring);
        return 1;
    }
    else
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Трябва да си в самолета, за да започнеш работа!");
    }
    return 1;
}
