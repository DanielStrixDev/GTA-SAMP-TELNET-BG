/*
* Checks if player name is in database
*/

stock IsNicknameInDB(const nickname[])
{
    new query[128], Cache:result;
    mysql_format(Database, query, sizeof(query), "SELECT id FROM users WHERE player_username = '%e' LIMIT 1;", nickname);
    result = mysql_query(Database, query);

    new exists = cache_num_rows();
    cache_delete(result);

    return exists > 0; // returns true if nickname exists, false if not
}

/*
* Updates by USERNAME
*/

stock UpdatePlayerDatabaseINT(columnName[], columnValue, nickname[], bool:isString=false)
{
    new query[512];
    mysql_format(Database, query, sizeof(query), "UPDATE `users` SET `%s` = '%d' WHERE `player_username` = '%s'", columnName, columnValue, nickname);
    mysql_tquery(Database, query);
}

stock UpdatePlayerDatabaseSTR(columnName[], columnValue[], nickname[], bool:isString=false)
{
    new query[512];
    mysql_format(Database, query, sizeof(query), "UPDATE `users` SET `%s` = '%s' WHERE `player_username` = '%s'", columnName, columnValue, nickname);
    mysql_tquery(Database, query);
}

/*
* Updates by PLAYERID
*/

stock UpdatePlayeridDatabaseSTR(const columnName[], columnValue[], playerid, bool:isString = false)
{
    new query[512];
    mysql_format(Database, query, sizeof(query), "UPDATE `users` SET `%s` = '%s' WHERE `player_username` = '%s'", columnName, columnValue, GetPlayerNickname(playerid));
    mysql_tquery(Database, query);
}

stock UpdatePlayeridDatabaseINT(const columnName[], columnValue, playerid, bool:isString = false)
{
    new query[512];
    mysql_format(Database, query, sizeof(query), "UPDATE `users` SET `%s` = '%d' WHERE `player_username` = '%s'", columnName, columnValue, GetPlayerNickname(playerid));
    mysql_tquery(Database, query);
}

/*
* Checks if nickname is not registered
*/
stock IsPlayerNotRegistered(playerid)
{
    new query[256];
    new Cache: resultCache;
    format(query, sizeof(query), "SELECT 1 FROM `users` WHERE `player_username` = '%s' LIMIT 1", GetPlayerNickname(playerid));
    resultCache = mysql_query(MySQL:Database, query);

    if (cache_num_rows() > 0)
    {
        return true;
    }
    return false;
}

/*
* Saves Player Nicknames for AKA by IP
*/
stock SavePlayerAka(playerid)
{
    new ip[16], name[MAX_PLAYER_NAME];
    GetPlayerIp(playerid, ip, sizeof(ip));
    GetPlayerName(playerid, name, sizeof(name));

    new query[256];
    mysql_format(Database, query, sizeof(query),
        "SELECT player_nicknames FROM aka WHERE player_ip = '%s' LIMIT 1;", ip);

    new Cache: result = mysql_query(Database, query);
    new rows = cache_num_rows();

    if (rows > 0)
    {
        new existingNicks[512];
        cache_get_value_name(0, "player_nicknames", existingNicks, sizeof(existingNicks));

        // проверяваме дали ника вече съществува
        if (strfind(existingNicks, name, true) == -1)
        {
            // добавяме ника със спейс
            new updated[600];
            format(updated, sizeof(updated), "%s %s", existingNicks, name);

            mysql_format(Database, query, sizeof(query),
                "UPDATE aka SET player_nicknames = '%s' WHERE player_ip = '%s';",
                updated, ip);

            mysql_tquery(Database, query, "", "");
        }
    }
    else
    {
        // нов IP - нов ред
        mysql_format(Database, query, sizeof(query),
            "INSERT INTO aka (player_ip, player_nicknames) VALUES ('%e', '%e');",
            ip, name);

        mysql_tquery(Database, query, "", "");
    }

    cache_delete(result);
    return 1;
}

/*
* Gets Player AKA Nicknames
*/
stock GetPlayerAka(playerid)
{
    new akaFormatted[512];
    new ip[16], query[256];
    GetPlayerIp(playerid, ip, sizeof(ip));

    mysql_format(Database, query, sizeof(query),
        "SELECT player_nicknames FROM aka WHERE player_ip = '%s' LIMIT 1", ip);

    new Cache: resultCache = mysql_query(Database, query);

    if (cache_num_rows() == 0)
    {
        cache_delete(resultCache);
        return akaFormatted;
    }

    new akaRaw[256];
    cache_get_value_name(0, "player_nicknames", akaRaw, sizeof(akaRaw));

    cache_delete(resultCache);

    new i = 0, j = 0;

    while (akaRaw[i] != '\0' && j < sizeof(akaFormatted) - 2)
    {
        if (akaRaw[i] == ' ')
        {
            akaFormatted[j++] = '\n';
            akaFormatted[j++] = '=';
        }
        else
        {
            akaFormatted[j++] = akaRaw[i];
        }
        i++;
    }
    akaFormatted[j] = '\0';

    return akaFormatted;
}

/*
* Block
*/
stock CheckPlayerForBlock(playerid)
{
    new name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));

    new query[128];
    new Cache: resultCache;
    format(query, sizeof(query), "SELECT warns, block FROM users WHERE player_username = '%s' LIMIT 1", GetPlayerNickname(playerid));

    resultCache = mysql_query(MySQL:Database, query);

    if (cache_num_rows() > 0)
    {
        new warns, block;
        cache_get_value_name_int(0, "warns", warns);
        cache_get_value_name_int(0, "block", block);

        PlayerInfo[playerid][pWarns] = warns;
        PlayerInfo[playerid][pBlock] = block;

    }
    else
    {
        PlayerInfo[playerid][pWarns] = 0;
        PlayerInfo[playerid][pBlock] = 0;
    }

    cache_delete(resultCache);
    return 1;
}

/*
* Gets player IP from DB
*/

stock GetPlayerIP(nickname[])
{
    new ip[115];
    new Cache: resultCache;
	new query[256];

	format(query, sizeof(query), "SELECT ip FROM users WHERE player_username = '%s' LIMIT 1", nickname);
	resultCache = mysql_query(MySQL:Database, query);

	if (cache_num_rows() > 0)
	{
        cache_get_value_name(0, "ip", ip, 115);
    }
    return ip;
}

/*
* Loads Stats
*/

stock LoadPlayerStats(playerid)
{
	new Cache: resultCache;
	new query[256];
    new loadBuffer[512]; // Буфер за зареждане на масиви

	format(query, sizeof(query), "SELECT * FROM users WHERE player_username = '%s' LIMIT 1", GetPlayerNickname(playerid));
	resultCache = mysql_query(MySQL:Database, query);

	if (cache_num_rows() > 0)
	{
        // --- INT Стойности ---
        cache_get_value_name_int(0, "admin", PlayerInfo[playerid][pAdmin]);
        cache_get_value_name_int(0, "admin_mute", PlayerInfo[playerid][pADMINMute]);
        cache_get_value_name_int(0, "time_mute", PlayerInfo[playerid][pTimeMute]);
        cache_get_value_name_int(0, "time_jail", PlayerInfo[playerid][pTimeJail]);
        cache_get_value_name_int(0, "t_goto", PlayerInfo[playerid][pTGoto]);
        cache_get_value_name_int(0, "tspec", PlayerInfo[playerid][pTSpec]);
        cache_get_value_name_int(0, "warns", PlayerInfo[playerid][pWarns]);
        cache_get_value_name_int(0, "player_refuel_timer", PlayerInfo[playerid][pPlayerRefuelTimer]);
        cache_get_value_name_int(0, "pizza_timer_work_again", PlayerInfo[playerid][pPizzaTimerWorkAgain]);
        cache_get_value_name_int(0, "boat_timer_work_again", PlayerInfo[playerid][pBoatTimerWorkAgain]);
        cache_get_value_name_int(0, "coalmine_timer_work_again", PlayerInfo[playerid][pCoalmineTimerWorkAgain]);
        cache_get_value_name_int(0, "sweeper_timer_work_again", PlayerInfo[playerid][pSweeperTimerWorkAgain]);
        cache_get_value_name_int(0, "pilot_timer_work_again", PlayerInfo[playerid][pPilotTimerWorkAgain]);
        cache_get_value_name_int(0, "deliver_timer_work_again", PlayerInfo[playerid][pDeliverTimerWorkAgain]);
        cache_get_value_name_int(0, "bus_timer_work_again", PlayerInfo[playerid][pBusTimerWorkAgain]);
        cache_get_value_name_int(0, "truck_timer_work_again", PlayerInfo[playerid][pTruckTimerWorkAgain]);
        cache_get_value_name_int(0, "office", PlayerInfo[playerid][pOffice]);
        cache_get_value_name_int(0, "cmn1", PlayerInfo[playerid][pCMN1]);
        cache_get_value_name_int(0, "street_race_success", PlayerInfo[playerid][pStreetRaceSuccess]);
        cache_get_value_name_int(0, "moneybox_success", PlayerInfo[playerid][pMoneyboxSuccess]);
        cache_get_value_name_int(0, "rnmute", PlayerInfo[playerid][pRNMute]);
        cache_get_value_name_int(0, "advert_time", PlayerInfo[playerid][pAdvertTime]);
        cache_get_value_name_int(0, "lodka", PlayerInfo[playerid][pLodka]);
        cache_get_value_name_int(0, "dmon_kills", PlayerInfo[playerid][pDMONKills]);
        cache_get_value_name_int(0, "hook", PlayerInfo[playerid][pHook]);
        cache_get_value_name_int(0, "style", PlayerInfo[playerid][pStyle]);
        cache_get_value_name_int(0, "armour2", PlayerInfo[playerid][pArmour2]);
        cache_get_value_name_int(0, "moonshine1", PlayerInfo[playerid][pMoonshine1]);
        cache_get_value_name_int(0, "weed1", PlayerInfo[playerid][pWeed1]);
        cache_get_value_name_int(0, "cocaine1", PlayerInfo[playerid][pCocaine1]);
        cache_get_value_name_int(0, "heroin1", PlayerInfo[playerid][pHeroin1]);
        cache_get_value_name_int(0, "vlak", PlayerInfo[playerid][pVlak]);
        cache_get_value_name_int(0, "g_leader", PlayerInfo[playerid][pGLeader]);
        cache_get_value_name_int(0, "helikopter", PlayerInfo[playerid][pHelikopter]);
        cache_get_value_name_int(0, "samolet", PlayerInfo[playerid][pSamolet]);
        cache_get_value_name_int(0, "manage", PlayerInfo[playerid][pManage]);
        cache_get_value_name_int(0, "event", PlayerInfo[playerid][pEvent]);
        cache_get_value_name_int(0, "ifc", PlayerInfo[playerid][pIFC]);
        cache_get_value_name_int(0, "special_force", PlayerInfo[playerid][pSpecialForce]);
        cache_get_value_name_int(0, "delta_force", PlayerInfo[playerid][pDeltaForce]);
        cache_get_value_name_int(0, "helper_leader", PlayerInfo[playerid][pHelperLeader]);
        cache_get_value_name_int(0, "awarns", PlayerInfo[playerid][pAWarns]);
        cache_get_value_name_int(0, "deathmatch_success", PlayerInfo[playerid][pDeathmatchSuccess]);
        cache_get_value_name_int(0, "weapon_s", PlayerInfo[playerid][pWeaponS]);
        cache_get_value_name_int(0, "house_o", PlayerInfo[playerid][pHouseO]);
        cache_get_value_name_int(0, "spawn_o", PlayerInfo[playerid][pSpawnO]);
        cache_get_value_name_int(0, "biz_o", PlayerInfo[playerid][pBizO]);
        cache_get_value_name_int(0, "vip", PlayerInfo[playerid][pVip]);
        cache_get_value_name_int(0, "team", PlayerInfo[playerid][pTeam]);
        cache_get_value_name_int(0, "rank", PlayerInfo[playerid][pRank]);
        cache_get_value_name_int(0, "level", PlayerInfo[playerid][pLevel]);
        cache_get_value_name_int(0, "bspec", PlayerInfo[playerid][pBSpec]);
        cache_get_value_name_int(0, "ep", PlayerInfo[playerid][pEP]);
        cache_get_value_name_int(0, "eps", PlayerInfo[playerid][pEPS]);
        cache_get_value_name_int(0, "ms", PlayerInfo[playerid][pMS]);
        cache_get_value_name_int(0, "cash", PlayerInfo[playerid][pCash]);
        cache_get_value_name_int(0, "account", PlayerInfo[playerid][pAccount]);
        cache_get_value_name_int(0, "afk", PlayerInfo[playerid][pAFK]);
        cache_get_value_name_int(0, "laser", PlayerInfo[playerid][pLaser]);
        cache_get_value_name_int(0, "wanted", PlayerInfo[playerid][pWanted]);
        cache_get_value_name_int(0, "tog_pm", PlayerInfo[playerid][pTogPM]);
        cache_get_value_name_int(0, "ignore_pm", PlayerInfo[playerid][pIgnorePM]);
        cache_get_value_name_int(0, "jail", PlayerInfo[playerid][pJail]);
        cache_get_value_name_int(0, "muted", PlayerInfo[playerid][pMuted]);
        cache_get_value_name_int(0, "biz_ep", PlayerInfo[playerid][pBizEP]);
        cache_get_value_name_int(0, "read_ta", PlayerInfo[playerid][pReadTA]);
        cache_get_value_name_int(0, "radio", PlayerInfo[playerid][pRadio]);
        cache_get_value_name_int(0, "cigarettes", PlayerInfo[playerid][pCigarettes]);
        cache_get_value_name_int(0, "briefcase", PlayerInfo[playerid][pBriefcase]);
        cache_get_value_name_int(0, "struv", PlayerInfo[playerid][pStruv]);
        cache_get_value_name_int(0, "chantichki", PlayerInfo[playerid][pChantichki]);
        cache_get_value_name_int(0, "fuelcase", PlayerInfo[playerid][pFuelcase]);
        cache_get_value_name_int(0, "dice", PlayerInfo[playerid][pDice]);
        cache_get_value_name_int(0, "reaction_tests_won", PlayerInfo[playerid][pReactionTestsWon]);
        cache_get_value_name_int(0, "biz_cash", PlayerInfo[playerid][pBizCash]);
        cache_get_value_name_int(0, "kills", PlayerInfo[playerid][pKills]);
        cache_get_value_name_int(0, "deaths", PlayerInfo[playerid][pDeaths]);
        cache_get_value_name_int(0, "l_muted", PlayerInfo[playerid][pLMuted]);
        cache_get_value_name_int(0, "a_muted", PlayerInfo[playerid][pAMuted]);
        cache_get_value_name_int(0, "f_muted", PlayerInfo[playerid][pFMuted]);
        cache_get_value_name_int(0, "f_warns", PlayerInfo[playerid][pFWarns]);
        cache_get_value_name_int(0, "gsm", PlayerInfo[playerid][pGSM]);
        cache_get_value_name_int(0, "pjail", PlayerInfo[playerid][pPJail]);
        cache_get_value_name_int(0, "block", PlayerInfo[playerid][pBlock]);
        cache_get_value_name_int(0, "vguns", PlayerInfo[playerid][pVGuns]);
        cache_get_value_name_int(0, "heal_t", PlayerInfo[playerid][pHealT]);
        cache_get_value_name_int(0, "fix_t", PlayerInfo[playerid][pFixT]);
        cache_get_value_name_int(0, "a_hide", PlayerInfo[playerid][pAHide]);
        cache_get_value_name_int(0, "test", PlayerInfo[playerid][pTest]);
        cache_get_value_name_int(0, "a_duty", PlayerInfo[playerid][pADuty]);
        cache_get_value_name_int(0, "a_skin", PlayerInfo[playerid][pASkin]);
        cache_get_value_name_int(0, "last_payday", PlayerInfo[playerid][pLastPayday]);
        cache_get_value_name_int(0, "coming_ban", PlayerInfo[playerid][pComingBan]);
        cache_get_value_name_int(0, "year", PlayerInfo[playerid][pYear]);
        cache_get_value_name_int(0, "month", PlayerInfo[playerid][pMonth]);
        cache_get_value_name_int(0, "day", PlayerInfo[playerid][pDay]);
        cache_get_value_name_int(0, "hours", PlayerInfo[playerid][pHours]);
        cache_get_value_name_int(0, "minutes", PlayerInfo[playerid][pMinutes]);
        cache_get_value_name_int(0, "seconds", PlayerInfo[playerid][pSeconds]);

        // --- FLOAT Стойности ---
        cache_get_value_name_float(0, "kasa_lv", PlayerInfo[playerid][pKasaLV]);

        // --- STRING/TEXT Стойности ---
        cache_get_value_name(0, "jail_reason", PlayerInfo[playerid][pJailReason], 256);
        cache_get_value_name(0, "mute_reason", PlayerInfo[playerid][pMuteReason], 256);
        cache_get_value_name(0, "reason_mute", PlayerInfo[playerid][pReasonMute], 256);

        // --- ARRAY Стойности (Парсване със sscanf) ---
        
        cache_get_value_name(0, "clothes", loadBuffer, sizeof(loadBuffer));
	    sscanf(loadBuffer, "p<,>ddddddddd", // Коригирано с разделител запетая, както е в Save функцията
            PlayerInfo[playerid][pClothes][0], PlayerInfo[playerid][pClothes][1], PlayerInfo[playerid][pClothes][2],
            PlayerInfo[playerid][pClothes][3], PlayerInfo[playerid][pClothes][4], PlayerInfo[playerid][pClothes][5],
            PlayerInfo[playerid][pClothes][6], PlayerInfo[playerid][pClothes][7], PlayerInfo[playerid][pClothes][8]);

        cache_get_value_name(0, "fishslot", loadBuffer, sizeof(loadBuffer));
	    sscanf(loadBuffer, "p<,>dddddddddd", // Коригирано с разделител запетая
            PlayerInfo[playerid][pFishslot][0], PlayerInfo[playerid][pFishslot][1], PlayerInfo[playerid][pFishslot][2],
            PlayerInfo[playerid][pFishslot][3], PlayerInfo[playerid][pFishslot][4], PlayerInfo[playerid][pFishslot][5],
            PlayerInfo[playerid][pFishslot][6], PlayerInfo[playerid][pFishslot][7], PlayerInfo[playerid][pFishslot][8],
            PlayerInfo[playerid][pFishslot][9]);

        cache_get_value_name(0, "fish_slot_weight", loadBuffer, sizeof(loadBuffer));
	    sscanf(loadBuffer, "p<,>dddddddddd", // Коригирано с разделител запетая
            PlayerInfo[playerid][pFishSlotWeight][0], PlayerInfo[playerid][pFishSlotWeight][1], PlayerInfo[playerid][pFishSlotWeight][2],
            PlayerInfo[playerid][pFishSlotWeight][3], PlayerInfo[playerid][pFishSlotWeight][4], PlayerInfo[playerid][pFishSlotWeight][5],
            PlayerInfo[playerid][pFishSlotWeight][6], PlayerInfo[playerid][pFishSlotWeight][7], PlayerInfo[playerid][pFishSlotWeight][8],
            PlayerInfo[playerid][pFishSlotWeight][9]);

	}
    else
    {
        printf("[MySQL] Грешка: Играчът '%s' не е намерен в базата данни.", GetPlayerNickname(playerid));
    }

	cache_delete(resultCache);
}

/*
* Register profile
*/

stock InsertPlayerToDB(playerid)
{
	new query[512];
	format(query, sizeof(query), "INSERT INTO `users` (`player_username`) VALUES ('%s')", GetPlayerNickname(playerid));
	mysql_tquery(MySQL:Database, query);
	printf("[MYSQL]: Играч: %s(%d) беше регистриран в базата данни", GetPlayerNickname(playerid), playerid);
}

/*
* Save profile
*/

stock SavePlayerLoginData(playerid)
{
    if (PlayerInfo[playerid][pRegistred] == 1)
    {
        getdate(year, month, day);
        gettime(hours, minutes, seconds);
        PlayerInfo[playerid][pHours] = hours;
        PlayerInfo[playerid][pMinutes] = minutes;
        PlayerInfo[playerid][pSeconds] = seconds;
        PlayerInfo[playerid][pDay] = day;
        PlayerInfo[playerid][pMonth] = month;
        PlayerInfo[playerid][pYear] = year;

        UpdatePlayeridDatabaseINT("year", PlayerInfo[playerid][pYear], playerid);
        UpdatePlayeridDatabaseINT("month", PlayerInfo[playerid][pMonth], playerid);
        UpdatePlayeridDatabaseINT("day", PlayerInfo[playerid][pDay], playerid);
        UpdatePlayeridDatabaseINT("hours", PlayerInfo[playerid][pHours], playerid);
        UpdatePlayeridDatabaseINT("minutes", PlayerInfo[playerid][pMinutes], playerid);
        UpdatePlayeridDatabaseINT("seconds", PlayerInfo[playerid][pSeconds], playerid);
    }
}

stock SavePlayerPassword(playerid, password[])
{
    new databaseLoad[512];
    format(databaseLoad, 512, "%s", MD5_Hash(password));
    UpdatePlayeridDatabaseSTR("password", databaseLoad, playerid);
}

stock SavePlayerStats(playerid)
{
    if (PlayerInfo[playerid][pRegistred] == 1)
    {
        // --- Всички INT/FLOAT стойности директно ---
        UpdatePlayeridDatabaseINT("admin", PlayerInfo[playerid][pAdmin], playerid);
        UpdatePlayeridDatabaseINT("admin_mute", PlayerInfo[playerid][pADMINMute], playerid);
        UpdatePlayeridDatabaseINT("time_mute", PlayerInfo[playerid][pTimeMute], playerid);
        UpdatePlayeridDatabaseINT("time_jail", PlayerInfo[playerid][pTimeJail], playerid);
        UpdatePlayeridDatabaseINT("t_goto", PlayerInfo[playerid][pTGoto], playerid);
        UpdatePlayeridDatabaseINT("tspec", PlayerInfo[playerid][pTSpec], playerid);
        UpdatePlayeridDatabaseINT("warns", PlayerInfo[playerid][pWarns], playerid);
        UpdatePlayeridDatabaseINT("player_refuel_timer", PlayerInfo[playerid][pPlayerRefuelTimer], playerid);
        UpdatePlayeridDatabaseINT("pizza_timer_work_again", PlayerInfo[playerid][pPizzaTimerWorkAgain], playerid);
        UpdatePlayeridDatabaseINT("boat_timer_work_again", PlayerInfo[playerid][pBoatTimerWorkAgain], playerid);
        UpdatePlayeridDatabaseINT("coalmine_timer_work_again", PlayerInfo[playerid][pCoalmineTimerWorkAgain], playerid);
        UpdatePlayeridDatabaseINT("sweeper_timer_work_again", PlayerInfo[playerid][pSweeperTimerWorkAgain], playerid);
        UpdatePlayeridDatabaseINT("pilot_timer_work_again", PlayerInfo[playerid][pPilotTimerWorkAgain], playerid);
        UpdatePlayeridDatabaseINT("deliver_timer_work_again", PlayerInfo[playerid][pDeliverTimerWorkAgain], playerid);
        UpdatePlayeridDatabaseINT("bus_timer_work_again", PlayerInfo[playerid][pBusTimerWorkAgain], playerid);
        UpdatePlayeridDatabaseINT("truck_timer_work_again", PlayerInfo[playerid][pTruckTimerWorkAgain], playerid);
        UpdatePlayeridDatabaseINT("office", PlayerInfo[playerid][pOffice], playerid);
        UpdatePlayeridDatabaseINT("cmn1", PlayerInfo[playerid][pCMN1], playerid);
        UpdatePlayeridDatabaseINT("street_race_success", PlayerInfo[playerid][pStreetRaceSuccess], playerid);
        UpdatePlayeridDatabaseINT("moneybox_success", PlayerInfo[playerid][pMoneyboxSuccess], playerid);
        UpdatePlayeridDatabaseINT("rnmute", PlayerInfo[playerid][pRNMute], playerid);
        UpdatePlayeridDatabaseINT("advert_time", PlayerInfo[playerid][pAdvertTime], playerid);
        UpdatePlayeridDatabaseINT("lodka", PlayerInfo[playerid][pLodka], playerid);
        UpdatePlayeridDatabaseINT("dmon_kills", PlayerInfo[playerid][pDMONKills], playerid);
        UpdatePlayeridDatabaseINT("hook", PlayerInfo[playerid][pHook], playerid);
        UpdatePlayeridDatabaseINT("style", PlayerInfo[playerid][pStyle], playerid);
        UpdatePlayeridDatabaseINT("armour2", PlayerInfo[playerid][pArmour2], playerid);
        UpdatePlayeridDatabaseINT("moonshine1", PlayerInfo[playerid][pMoonshine1], playerid);
        UpdatePlayeridDatabaseINT("weed1", PlayerInfo[playerid][pWeed1], playerid);
        UpdatePlayeridDatabaseINT("cocaine1", PlayerInfo[playerid][pCocaine1], playerid);
        UpdatePlayeridDatabaseINT("heroin1", PlayerInfo[playerid][pHeroin1], playerid);
        UpdatePlayeridDatabaseINT("vlak", PlayerInfo[playerid][pVlak], playerid);
        UpdatePlayeridDatabaseINT("kasa_lv", PlayerInfo[playerid][pKasaLV], playerid); // FLOAT
        UpdatePlayeridDatabaseINT("g_leader", PlayerInfo[playerid][pGLeader], playerid);
        UpdatePlayeridDatabaseINT("helikopter", PlayerInfo[playerid][pHelikopter], playerid);
        UpdatePlayeridDatabaseINT("samolet", PlayerInfo[playerid][pSamolet], playerid);
        UpdatePlayeridDatabaseINT("manage", PlayerInfo[playerid][pManage], playerid);
        UpdatePlayeridDatabaseINT("event", PlayerInfo[playerid][pEvent], playerid);
        UpdatePlayeridDatabaseINT("ifc", PlayerInfo[playerid][pIFC], playerid);
        UpdatePlayeridDatabaseINT("special_force", PlayerInfo[playerid][pSpecialForce], playerid);
        UpdatePlayeridDatabaseINT("delta_force", PlayerInfo[playerid][pDeltaForce], playerid);
        UpdatePlayeridDatabaseINT("helper_leader", PlayerInfo[playerid][pHelperLeader], playerid);
        UpdatePlayeridDatabaseINT("awarns", PlayerInfo[playerid][pAWarns], playerid);
        UpdatePlayeridDatabaseINT("deathmatch_success", PlayerInfo[playerid][pDeathmatchSuccess], playerid);
        UpdatePlayeridDatabaseINT("weapon_s", PlayerInfo[playerid][pWeaponS], playerid);
        UpdatePlayeridDatabaseINT("house_o", PlayerInfo[playerid][pHouseO], playerid);
        UpdatePlayeridDatabaseINT("spawn_o", PlayerInfo[playerid][pSpawnO], playerid);
        UpdatePlayeridDatabaseINT("biz_o", PlayerInfo[playerid][pBizO], playerid);
        UpdatePlayeridDatabaseINT("vip", PlayerInfo[playerid][pVip], playerid);
        UpdatePlayeridDatabaseINT("team", PlayerInfo[playerid][pTeam], playerid);
        UpdatePlayeridDatabaseINT("rank", PlayerInfo[playerid][pRank], playerid);
        UpdatePlayeridDatabaseINT("level", PlayerInfo[playerid][pLevel], playerid);
        UpdatePlayeridDatabaseINT("bspec", PlayerInfo[playerid][pBSpec], playerid);
        UpdatePlayeridDatabaseINT("ep", PlayerInfo[playerid][pEP], playerid);
        UpdatePlayeridDatabaseINT("eps", PlayerInfo[playerid][pEPS], playerid);
        UpdatePlayeridDatabaseINT("ms", PlayerInfo[playerid][pMS], playerid);
        UpdatePlayeridDatabaseINT("cash", PlayerInfo[playerid][pCash], playerid);
        UpdatePlayeridDatabaseINT("account", PlayerInfo[playerid][pAccount], playerid);
        UpdatePlayeridDatabaseINT("afk", PlayerInfo[playerid][pAFK], playerid);
        UpdatePlayeridDatabaseINT("laser", PlayerInfo[playerid][pLaser], playerid);
        UpdatePlayeridDatabaseINT("wanted", PlayerInfo[playerid][pWanted], playerid);
        UpdatePlayeridDatabaseINT("tog_pm", PlayerInfo[playerid][pTogPM], playerid);
        UpdatePlayeridDatabaseINT("ignore_pm", PlayerInfo[playerid][pIgnorePM], playerid);
        UpdatePlayeridDatabaseINT("jail", PlayerInfo[playerid][pJail], playerid);
        UpdatePlayeridDatabaseINT("muted", PlayerInfo[playerid][pMuted], playerid);
        UpdatePlayeridDatabaseINT("biz_ep", PlayerInfo[playerid][pBizEP], playerid);
        UpdatePlayeridDatabaseINT("read_ta", PlayerInfo[playerid][pReadTA], playerid);
        UpdatePlayeridDatabaseINT("radio", PlayerInfo[playerid][pRadio], playerid);
        UpdatePlayeridDatabaseINT("cigarettes", PlayerInfo[playerid][pCigarettes], playerid);
        UpdatePlayeridDatabaseINT("briefcase", PlayerInfo[playerid][pBriefcase], playerid);
        UpdatePlayeridDatabaseINT("struv", PlayerInfo[playerid][pStruv], playerid);
        UpdatePlayeridDatabaseINT("chantichki", PlayerInfo[playerid][pChantichki], playerid);
        UpdatePlayeridDatabaseINT("fuelcase", PlayerInfo[playerid][pFuelcase], playerid);
        UpdatePlayeridDatabaseINT("dice", PlayerInfo[playerid][pDice], playerid);
        UpdatePlayeridDatabaseINT("reaction_tests_won", PlayerInfo[playerid][pReactionTestsWon], playerid);
        UpdatePlayeridDatabaseINT("biz_cash", PlayerInfo[playerid][pBizCash], playerid);
        UpdatePlayeridDatabaseINT("kills", PlayerInfo[playerid][pKills], playerid);
        UpdatePlayeridDatabaseINT("deaths", PlayerInfo[playerid][pDeaths], playerid);
        UpdatePlayeridDatabaseINT("l_muted", PlayerInfo[playerid][pLMuted], playerid);
        UpdatePlayeridDatabaseINT("a_muted", PlayerInfo[playerid][pAMuted], playerid);
        UpdatePlayeridDatabaseINT("f_muted", PlayerInfo[playerid][pFMuted], playerid);
        UpdatePlayeridDatabaseINT("f_warns", PlayerInfo[playerid][pFWarns], playerid);
        UpdatePlayeridDatabaseINT("gsm", PlayerInfo[playerid][pGSM], playerid);
        UpdatePlayeridDatabaseINT("pjail", PlayerInfo[playerid][pPJail], playerid);
        UpdatePlayeridDatabaseINT("block", PlayerInfo[playerid][pBlock], playerid);
        UpdatePlayeridDatabaseINT("vguns", PlayerInfo[playerid][pVGuns], playerid);
        UpdatePlayeridDatabaseINT("heal_t", PlayerInfo[playerid][pHealT], playerid);
        UpdatePlayeridDatabaseINT("fix_t", PlayerInfo[playerid][pFixT], playerid);
        UpdatePlayeridDatabaseINT("a_hide", PlayerInfo[playerid][pAHide], playerid);
        UpdatePlayeridDatabaseINT("test", PlayerInfo[playerid][pTest], playerid);
        UpdatePlayeridDatabaseINT("a_duty", PlayerInfo[playerid][pADuty], playerid);
        UpdatePlayeridDatabaseINT("a_skin", PlayerInfo[playerid][pASkin], playerid);
        UpdatePlayeridDatabaseINT("last_payday", PlayerInfo[playerid][pLastPayday], playerid);
        UpdatePlayeridDatabaseINT("coming_ban", PlayerInfo[playerid][pComingBan], playerid);
        // --- Strings ---
        new databaseString[512]; // Една променлива за всички стрингове
        new ip[35];
        GetPlayerIp(playerid, ip, 35);
        format(databaseString, sizeof(databaseString), "%s", ip);
        UpdatePlayeridDatabaseSTR("ip", databaseString, playerid, true);

        format(databaseString, sizeof(databaseString), "%s", PlayerInfo[playerid][pReasonMute]);
        UpdatePlayeridDatabaseSTR("reason_mute", databaseString, playerid, true);

        format(databaseString, sizeof(databaseString), "%s", PlayerInfo[playerid][pJailReason]);
        UpdatePlayeridDatabaseSTR("jail_reason", databaseString, playerid, true);

        format(databaseString, sizeof(databaseString), "%s", PlayerInfo[playerid][pMuteReason]);
        UpdatePlayeridDatabaseSTR("mute_reason", databaseString, playerid, true);

        // --- Масиви, форматирани като стринг ---
        new arrayString[512];

        // pClothes
        format(arrayString, sizeof(arrayString), "%d,%d,%d,%d,%d,%d,%d,%d,%d",
            PlayerInfo[playerid][pClothes][0], PlayerInfo[playerid][pClothes][1], PlayerInfo[playerid][pClothes][2], PlayerInfo[playerid][pClothes][3], PlayerInfo[playerid][pClothes][4],
            PlayerInfo[playerid][pClothes][5], PlayerInfo[playerid][pClothes][6], PlayerInfo[playerid][pClothes][7], PlayerInfo[playerid][pClothes][8]);
        UpdatePlayeridDatabaseSTR("clothes", arrayString, playerid, true);

        // pFishslot
        format(arrayString, sizeof(arrayString), "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
            PlayerInfo[playerid][pFishslot][0], PlayerInfo[playerid][pFishslot][1], PlayerInfo[playerid][pFishslot][2],
            PlayerInfo[playerid][pFishslot][3], PlayerInfo[playerid][pFishslot][4], PlayerInfo[playerid][pFishslot][5],
            PlayerInfo[playerid][pFishslot][6], PlayerInfo[playerid][pFishslot][7], PlayerInfo[playerid][pFishslot][8],
            PlayerInfo[playerid][pFishslot][9]);
        UpdatePlayeridDatabaseSTR("fishslot", arrayString, playerid, true);

        // pFishSlotWeight
        format(arrayString, sizeof(arrayString), "%d,%d,%d,%d,%d,%d,%d,%d,%d,%d",
            PlayerInfo[playerid][pFishSlotWeight][0], PlayerInfo[playerid][pFishSlotWeight][1], PlayerInfo[playerid][pFishSlotWeight][2], PlayerInfo[playerid][pFishSlotWeight][3], PlayerInfo[playerid][pFishSlotWeight][4],
            PlayerInfo[playerid][pFishSlotWeight][5], PlayerInfo[playerid][pFishSlotWeight][6], PlayerInfo[playerid][pFishSlotWeight][7], PlayerInfo[playerid][pFishSlotWeight][8], PlayerInfo[playerid][pFishSlotWeight][9]);
        UpdatePlayeridDatabaseSTR("fish_slot_weight", arrayString, playerid, true);

    }
}

