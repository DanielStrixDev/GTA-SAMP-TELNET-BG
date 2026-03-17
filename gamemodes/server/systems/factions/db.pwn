/*
* Load Factions
*/
stock LoadFactions()
{
    new Cache: resultCache;
    new query[256];

    format(query, sizeof(query), "SELECT * FROM factions");
    resultCache = mysql_query(MySQL:Database, query);

    new rows = cache_num_rows();
    if (rows > 0)
    {
        for (new i = 0; i < rows; i++)
        {
            new dbID;
            cache_get_value_name_int(i, "id", dbID);
            
            // Преобразуване на ID от базата към индекс в масива
            new factionIndex = dbID - 1; // <-- -1 за масива
            
            if (factionIndex < 0 || factionIndex >= MAX_TEAMS) 
            {
                printf("[ГРЕШКА] Невалиден ID за организация: %d (factionIndex: %d)", dbID, factionIndex);
                continue;
            }

            cache_get_value_name(i, "rank_name1", TeamInfo[factionIndex][tRank1]);
            cache_get_value_name(i, "rank_name2", TeamInfo[factionIndex][tRank2]);
            cache_get_value_name(i, "rank_name3", TeamInfo[factionIndex][tRank3]);
            cache_get_value_name(i, "rank_name4", TeamInfo[factionIndex][tRank4]);
            cache_get_value_name(i, "rank_name5", TeamInfo[factionIndex][tRank5]);
            cache_get_value_name(i, "rank_name6", TeamInfo[factionIndex][tRank6]);
            cache_get_value_name_int(i, "turf_owner", TeamInfo[factionIndex][tTurfsCount]);
            cache_get_value_name_int(i, "turf_attack_time", TeamInfo[factionIndex][tAttackTurfTime]);
        }
    }

    printf("[MYSQL] Заредени са %d на брой организации", rows);
    cache_delete(resultCache);
    return 1;
}

/*
* Save Factions
*/
stock SaveFaction(factionid)
{
    // Проверка за валидност на factionid
    if (factionid < 0 || factionid >= MAX_TEAMS) 
    {
        printf("[ГРЕШКА] Невалиден factionid: %d", factionid);
        return 0;
    }

    new query[512];
    mysql_format(MySQL:Database, query, sizeof(query),
        "UPDATE factions SET " \
        "rank_name1 = '%e', rank_name2 = '%e', rank_name3 = '%e', " \
        "rank_name4 = '%e', rank_name5 = '%e', rank_name6 = '%e', " \
        "turf_owner = %d, turf_attack_time = %d " \
        "WHERE id = %d",
        TeamInfo[factionid][tRank1],
        TeamInfo[factionid][tRank2],
        TeamInfo[factionid][tRank3],
        TeamInfo[factionid][tRank4],
        TeamInfo[factionid][tRank5],
        TeamInfo[factionid][tRank6],
        TeamInfo[factionid][tTurfsCount],
        TeamInfo[factionid][tAttackTurfTime],
        factionid + 1 // <-- +1 за съответствие с базата данни
    );

    mysql_tquery(MySQL:Database, query);
    return 1;
}

/*
* Inserts faction into db
*/
stock InsertFactionIntoDB(factionid)
{
    // Проверка за валидност на factionid
    if (factionid < 0 || factionid >= MAX_TEAMS) 
    {
        printf("[ГРЕШКА] Невалиден factionid за Insert: %d", factionid);
        return 0;
    }

    new query[512];
    mysql_format(MySQL:Database, query, sizeof(query),
        "INSERT INTO `factions` " \
        "(`id`, `rank_name1`, `rank_name2`, `rank_name3`, " \
        "`rank_name4`, `rank_name5`, `rank_name6`, `turf_owner`, `turf_attack_time`) " \
        "VALUES (%d, '%e', '%e', '%e', '%e', '%e', '%e', %d, %d)",
        factionid + 1, // <-- +1 за съответствие с базата данни
        TeamInfo[factionid][tRank1],
        TeamInfo[factionid][tRank2],
        TeamInfo[factionid][tRank3],
        TeamInfo[factionid][tRank4],
        TeamInfo[factionid][tRank5],
        TeamInfo[factionid][tRank6],
        TeamInfo[factionid][tTurfsCount],
        TeamInfo[factionid][tAttackTurfTime]
    );

    mysql_tquery(MySQL:Database, query);
    return 1;
}