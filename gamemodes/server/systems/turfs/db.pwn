/*
* Save Turf
*/
stock SaveTurf(turfID)
{
    new turfOwner = TurfInfo[turfID][TurfOwner];
    new query[128];

    // ID в базата данни = turfID + 1
    mysql_format(MySQL:Database, query, sizeof(query),
        "UPDATE turfs SET turf_owner = %d WHERE id = %d;",
        turfOwner, turfID + 1); // <-- Промяна тук: +1

    mysql_tquery(MySQL:Database, query);
    return 1;
}

/*
* Load Turfs
*/
stock LoadTurfs()
{
    new Cache: resultCache;
    new query[256];

    // Вземаме id и turf_owner за всички територии
    format(query, sizeof(query), "SELECT id, turf_owner FROM turfs ORDER BY id ASC");
    resultCache = mysql_query(MySQL:Database, query);

    new rows = cache_num_rows();
    if (rows > 0)
    {
        for (new i = 0; i < rows; i++)
        {
            new dbID, turfOwner;
            cache_get_value_name_int(i, "id", dbID);
            cache_get_value_name_int(i, "turf_owner", turfOwner);
            
            // Преобразуване: turfID в кода = dbID - 1
            TurfInfo[dbID - 1][TurfOwner] = turfOwner; // <-- Промяна тук: -1
        }
    }

    cache_delete(resultCache);

    printf("[MYSQL] Заредени са %d на брой територии на банди/мафии", rows);
    return 1;
}

/*
* Insert turf into db
*/
stock InsertTurfIntoDB(turfid)
{
    new query[256];
    // ID в базата данни = turfid + 1
    mysql_format(MySQL:Database, query, sizeof(query),
        "INSERT INTO `turfs` (`id`, `turf_owner`) VALUES (%d, %d)",
        turfid + 1, // <-- Промяна тук: +1
        TurfInfo[turfid][TurfOwner]);
    
    mysql_tquery(MySQL: Database, query);
    return 1;
}