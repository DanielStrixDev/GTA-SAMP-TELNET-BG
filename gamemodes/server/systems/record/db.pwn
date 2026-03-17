stock InsertRecordsIntoDB(recordid)
{
    new query[512];
    mysql_format(MySQL:Database, query, sizeof(query),
        "INSERT INTO `records` " \
        "(`id`, `record_player`, `record`) " \
        "VALUES (%d, '%s', '%s')",
        recordid+1,
        RecordInfo[0][recordPlayer],
        RecordInfo[0][record]
    );

    mysql_tquery(MySQL:Database, query);
}

stock InsertRacesIntoDB(raceid)
{
    new query[512];
    mysql_format(MySQL:Database, query, sizeof(query),
        "INSERT INTO `races` " \
        "(`id`, `finish_time`, `winner_name`) " \
        "VALUES (%d, '%d', '%s')",
        raceid+1,
        StreetRaceInfo[raceid][stWinTime],
        StreetRaceInfo[raceid][stWinner]
    );

    mysql_tquery(MySQL:Database, query);
}