/*
* Loads street race record from db
*/
stock LoadStreetRaces()
{
    new Cache: resultCache;
    new query[128];
    format(query, sizeof(query), "SELECT * FROM races ORDER BY id ASC");
    resultCache = mysql_query(MySQL:Database, query);

    new rows = cache_num_rows();
    if (rows > 0)
    {
        for (new i = 0; i < rows; i++)
        {
            new dbID;
            cache_get_value_name_int(i, "id", dbID);
            
            // Проверка дали ID е валиден за нашия масив
            if (dbID > 0 && (dbID - 1) < MAX_RACES)
            {
                cache_get_value_name(i , "winner_name", StreetRaceInfo[dbID - 1][stWinner]); // <-- dbID - 1
                cache_get_value_name_int(i, "finish_time", StreetRaceInfo[dbID - 1][stWinTime]); // <-- dbID - 1
            }
            else
            {
                printf("[ГРЕШКА] Невалиден ID за състезание от базата: %d", dbID);
            }
        }
    }

    printf("[MYSQL] Заредени са %d на брой вида Street Race мисии.", rows);
}

/*
* Saves street race record into db
*/
stock SaveNewRaceFinishTime(racerID, raceIndex, finishTime)
{
    // Проверка за валидност на индекса
    if (raceIndex < 0 || raceIndex >= MAX_RACES) 
        return 0;

    format(StreetRaceInfo[raceIndex][stWinner], 50, GetPlayerNickname(racerID));
    StreetRaceInfo[raceIndex][stWinTime] = finishTime;

    new query[512];
    mysql_format(MySQL:Database, query, sizeof(query),
        "UPDATE races SET " \
        "winner_name = '%e', finish_time = %d " \
        "WHERE id = %d",
        StreetRaceInfo[raceIndex][stWinner], // или GetPlayerNickname(racerID) директно
        StreetRaceInfo[raceIndex][stWinTime],
        raceIndex + 1  // <-- +1 за съответствие с базата данни
    );

    mysql_tquery(MySQL:Database, query);
    return 1;
}

/*
* Insert street race into database (ако имате нужда)
*/
stock InsertRaceIntoDB(raceIndex)
{
    if (raceIndex < 0 || raceIndex >= MAX_RACES) 
        return 0;

    new query[256];
    mysql_format(MySQL:Database, query, sizeof(query),
        "INSERT INTO races (id, winner_name, finish_time) VALUES (%d, 'Никой', 0)",
        raceIndex + 1  // <-- +1 за съответствие с базата данни
    );
    
    mysql_tquery(MySQL:Database, query);
    return 1;
}