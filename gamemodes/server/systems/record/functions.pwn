stock SaveRecords()
{
    new query[128];

    for (new i = 1; i <= MAX_RECORDS; i++)
    {
        mysql_format(MySQL:Database, query, sizeof(query),
            "UPDATE records SET record = '%d', record_player = '%s' WHERE id = '%d'",
            RecordInfo[i][record],
            RecordInfo[i][recordPlayer],
            i
            );

        mysql_tquery(MySQL:Database, query);
    }
}

stock LoadRecords()
{
    new Cache:result, rows;
    result = mysql_query(Database, "SELECT * FROM records");
    rows = cache_num_rows();
    for (new i = 0; i < rows; i++)
    {
        cache_get_value_name(i , "record", RecordInfo[i][record]);
        cache_get_value_name(i , "record_player", RecordInfo[i][recordPlayer]);
    }
}