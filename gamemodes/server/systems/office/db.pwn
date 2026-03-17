/*
* Inserts office into database by ID
*/
stock InsertOfficeIntoDB(officeid)
{
    new query[512];
    mysql_format(MySQL:Database, query, sizeof(query),
        "INSERT INTO `offices` " \
        "(`id`, `is_owned`, `owner_name`) " \
        "VALUES (%d, 0, 'No Owner')", 
        officeid + 1 // <-- +1 за съответствие с базата данни
    );
    mysql_tquery(MySQL:Database, query);
}

/*
* Saves office into database
*/
stock SaveOffices()
{
    new query[256];
    for (new office_id = 0; office_id < MAX_OFFICES; office_id++) // <-- Променено от 1 на 0
    {
        mysql_format(MySQL:Database, query, sizeof(query),
            "UPDATE offices SET is_owned = %d, owner_name = '%e' WHERE id = %d;", // <-- '%e' за ескейпване
            OfficeInfo[office_id][isOwned], 
            OfficeInfo[office_id][OwnerName], 
            office_id + 1 // <-- +1 за съответствие с базата данни
        );
        mysql_tquery(MySQL:Database, query);
    }
}

/*
* Loads office from database
*/
stock LoadOfficeCenter()
{
    new Cache: resultCache;
    new query[256];

    format(query, sizeof(query), "SELECT * FROM offices ORDER BY id ASC");
    resultCache = mysql_query(MySQL:Database, query);

    new rows = cache_num_rows();
    if (rows > 0)
    {
        for (new i = 0; i < rows; i++)
        {
            new dbID;
            cache_get_value_name_int(i, "id", dbID);
            cache_get_value_name_int(i, "is_owned", OfficeInfo[dbID - 1][isOwned]); // <-- dbID - 1
            cache_get_value_name(i, "owner_name", OfficeInfo[dbID - 1][OwnerName]); // <-- dbID - 1
        }
    }
    cache_delete(resultCache);
    printf("[MYSQL] Заредени са %d на брой офиси базата.", rows);

    DefineOfficeCenterData();
    DefineOfficeCenterTexts();
}