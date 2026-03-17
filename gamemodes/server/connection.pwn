
/* 
* MYSQL OPERATIONS 
*/
stock CreateEmptyTable(table[])
{
    new query[1024];

    format(query, sizeof(query),
           "CREATE TABLE IF NOT EXISTS `%s` (id INT AUTO_INCREMENT PRIMARY KEY) CHARACTER SET cp1251 COLLATE cp1251_general_ci;",
		              table);

    mysql_tquery(MySQL:Database, query);
}


stock ColumnExists(table[], column[])
{
    new query[256];
    new resultCache;

    format(query, sizeof(query), "SHOW COLUMNS FROM `%s` LIKE '%s';", table, column);
    resultCache = mysql_query(MySQL:Database, query);

    if (cache_num_rows() > 0)
    {
		cache_delete(resultCache);
        return true;
    }
    cache_delete(resultCache);
    return false;
}

stock AlterTableInt(table[], name[])
{
    AlterTable(table, name, "integer");
}

stock AlterTableStr(table[], name[], longLen = false)
{
    if (longLen)
    {
        AlterTable(table, name, "varchar(800)");
    }
    else
    {
        AlterTable(table, name, "varchar(60)");
    }
}

stock AlterTableFloat(table[], name[])
{
    AlterTable(table, name, "float");
}

stock AlterTableBool(table[], name[])
{
    AlterTable(table, name, "boolean");
}

stock AlterTable(table[], name[], type[], notNull = false)
{
    if (ColumnExists(table, name))
    {
        //printf("[MYSQL]: Column `%s` already exists in table `%s`. No changes made.", name, table);
        return false;
    }

    new query[256];
    if (!notNull)
    {
        format(query, sizeof(query), "ALTER TABLE `%s` ADD %s %s;", table, name, type);
    }
    else
    {
        format(query, sizeof(query), "ALTER TABLE `%s` ADD %s %s NOT NULL;", table, name, type);
    }
    
    mysql_tquery(MySQL:Database, query);
    return true;
}

stock CloseDB()
{
	mysql_close(MySQL: Database);
	printf("------------------------------------------------------------------------------");
	printf("[MYSQL]: DB CLOSE: Database Connection `%s`@'%s' closed by a function!", DB_NAME, DB_HOST);
	printf("------------------------------------------------------------------------------");
}

public OnQueryError(errorid, const error[], const callback[], const query[], MySQL:handle)
{
	switch(errorid)
	{
		case CR_SERVER_GONE_ERROR:
		{
			printf("Lost connection to server, trying reconnect...");
		}
		case ER_SYNTAX_ERROR:
		{
			printf("[MYSQL]: SYNTAX ERROR: %s",query);
		}
	}
	new str[400];
	format(str, sizeof(str), "[MYSQL ERROR]: ID: %d", errorid);
	print(str);
	format(str, sizeof(str), "[MYSQL ERROR]: Error: %s", error);
	print(str);
	format(str, sizeof(str), "[MYSQL ERROR]: Query: %s", query);
	print(str);
	
	return 1;
}

forward MySQLConnect();
public MySQLConnect()
{    
    mysql_log(ALL);

    // Attempt to connect to the MySQL database
    Database = mysql_connect(
        DB_HOST,   // Host
        DB_USER,   // User
        DB_PASSWORD, // Password
        DB_NAME    // Database Name,
		
    );

    // Check if the connection was successful
    if (Database != -1 && mysql_errno(Database) == 0)
    {
        printf("------------------------------------------------------------------------------");
        printf("[MYSQL]: Connection to `%s`@'%s' successful!", DB_NAME, DB_HOST);
        printf("------------------------------------------------------------------------------");

        // Initialize and set options if connection is successful
        new MySQLOpt:option_id = mysql_init_options();
        mysql_set_option(option_id, AUTO_RECONNECT, true);
		//mysql_set_option(option_id, SERVER_PORT, "3307");
        mysql_set_charset("cp1251");
    }
    else
    {
        // Print error message and details if connection fails
        printf("------------------------------------------------------------------------------");
        printf("[MYSQL]: ERROR: Connection to `%s`@'%s' failed!", DB_NAME, DB_HOST);
        printf("[MYSQL]: Error Code: %d", mysql_errno(Database));
        printf("------------------------------------------------------------------------------");
        return 1;
    }

    return 0;
}

stock GetUserValueInt(const nickname[], const columnName[])
{
    new query[256], Cache:result, value = 0;

    mysql_format(Database, query, sizeof(query),
        "SELECT %s FROM users WHERE player_username = '%s' LIMIT 1;",
        columnName, nickname
    );

    result = mysql_query(Database, query);

    if (cache_num_rows())
    {
        cache_get_value_name_int(0, columnName, value);
    }

    cache_delete(result);
    return value;
}


stock GetUserValueString(const nickname[], const columnName[], output[], size = 64)
{
    new query[256], Cache:result;

    mysql_format(Database, query, sizeof(query),
        "SELECT `%s` FROM `users` WHERE `player_username` = '%e' LIMIT 1;",
        columnName, nickname
    );

    result = mysql_query(Database, query);

    if (cache_num_rows())
    {
        cache_get_value_name(0, columnName, output, size);
        cache_delete(result);
        return 1;
    }

    cache_delete(result);
    return 0;
}

stock Float:GetUserValueFloat(const nickname[], const columnName[])
{
    new query[256], Cache:result, Float:value = 0.0;

    mysql_format(Database, query, sizeof(query),
        "SELECT `%s` FROM `users` WHERE `player_username` = '%e' LIMIT 1;",
        columnName, nickname
    );

    result = mysql_query(Database, query);

    if (cache_num_rows())
    {
        cache_get_value_float(0, columnName, value);
    }

    cache_delete(result);
    return value;
}
