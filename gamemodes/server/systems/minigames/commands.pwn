CMD:derbyon(playerid, params[])
{
    if (isTurfMember[playerid] == true) return SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да ползваш тази команда до като търфиш!");
    if (PlayerInfo[playerid][pHookT] > 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да влезнеш в мини-игра докато ловиш риба!");
    if (onWork[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти в момента работиш и неможе да си в мини-игра.");
    if (PlayerInfo[playerid][pAFK] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да влезеш в мини-игра в момента!");
    if (playerInDMON[playerid] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече си в мини-игра!");
    if (IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си пешеходец за да се присъединиш към мини-играта!");
    if (PlayerInfo[playerid][pWanted] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си издирван!");
        return 1;
    }
    if (PlayerInfo[playerid][pADuty] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си ADMIN ON-DUTY!");
        return 1;
    }
    if (PlayerInfo[playerid][pAFK] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в AFK режим и не можеш да се телепортираш!");
        return 1;
    }
    if (PlayerInfo[playerid][pJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в админ затвора и не можеш да се телепортираш!");
        return 1;
    }
    if (PlayerInfo[playerid][pPJail] > 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Ти си в затвора и не можеш да се телепортираш!");
        return 1;
    }
    if (PlayerInfo[playerid][pIPDDuty] >= 1)
    {
        SendClientMessage(playerid, COLOR_GRAD1, "Не можеш да използваш тази команда, до като си POLICE ON-DUTY!");
        return 1;
    }
    if (PlayerInfo[playerid][pIFCDuty] == 1) return SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да използваш тази команда, докато си IFC ON-DUTY!");
    if (derbyPlayersCount == 10) return SendClientMessage(playerid, COLOR_GRAD1, "Няма свободни места в дербито!");
    if (derbyStarted == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Дербито вече е започнало!");
    if (derbyJoinTimer >= 1) return SendClientMessage(playerid, COLOR_GRAD1, "В дербито може да се влиза през секунда!");
    if (derbyTimerToGame >= 1) return SendClientMessage(playerid, COLOR_GRAD1, "Трябва да мине определено време от предишното дерби за да започне друго!");
    if (IsInMinigame(playerid)) return SendClientMessage(playerid, COLOR_GRAD1, "Вие вече сте в мини-игра!");
    if (PlayerInfo[playerid][pBankSpawn] > 0) return SendClientMessage(playerid, COLOR_GRAD1, "В дербито може да се влиза през секунда!");

    PlayerJoinDerby(playerid, 1);

    return 1;
}

CMD:derbyoff(playerid, params[])
{
    if (derbyStarted == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Дербито вече е започнало и неможе да го напуснеш!");
    if (!isDerbyPlayer[playerid]) return SendClientMessage(playerid, COLOR_GRAD1, "Вие не сте в дербито!");
    if (playerJoinMinigameTimer[playerid] > 0) return SendClientMessage(playerid, COLOR_GRAD1, "Можеш да напуснеш дербито след 60 секунди!");

    PlayerLeaveDerby(playerid);
    return 1;
}