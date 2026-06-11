/*
* Checks Max Biz ID
*/
stock CheckMaxBizID()
{
    new Cache:result, last_id;
    result = mysql_query(Database, "SELECT MAX(id) AS lastid FROM businesses;");
    
    if (cache_num_rows())
    {
        cache_get_value_int(0, "lastid", last_id);
        cache_delete(result);
        maxbiz = last_id - 1;
        return maxbiz;
    }

    cache_delete(result);
    maxbiz = 0;
    return 0;
}

/*
* Return Next ID
*/
stock ReturnNextUnusedBizID()
{
    new Cache:result, last_id;
    result = mysql_query(Database, "SELECT MAX(id) AS lastid FROM businesses;");
    
    if (cache_num_rows())
    {
        cache_get_value_int(0, "lastid", last_id);
        cache_delete(result);
        return last_id;
    }

    cache_delete(result);
    return 0;
}

/*
* Load bizz
*/
stock LoadBizz()
{
    new Cache:result, rows;
    result = mysql_query(Database, "SELECT * FROM businesses;");
    rows = cache_num_rows();

    for (new i = 0; i < rows; i++)
    {
        new dbID;
        cache_get_value_int(i, "id", dbID);
        
        // Проверка за валиден ID
        if (dbID < 1 || dbID > MAX_BIZZ) 
        {
            printf("[ГРЕШКА] Невалиден ID за бизнес: %d (приемливи са 1..%d)", dbID, MAX_BIZZ);
            continue;
        }
        
        // Използваме ID-то директно като индекс
        cache_get_value_float(i, "x", BizInfo[dbID][bX]);
        cache_get_value_float(i, "y", BizInfo[dbID][bY]);
        cache_get_value_float(i, "z", BizInfo[dbID][bZ]);

        cache_get_value_int(i, "pay_out", BizInfo[dbID][bPayOut]);
        cache_get_value_int(i, "owner", BizInfo[dbID][bOwner]);
        cache_get_value_int(i, "locked", BizInfo[dbID][bLocked]);
        cache_get_value_int(i, "ep", BizInfo[dbID][bEP]);
        cache_get_value_int(i, "level", BizInfo[dbID][bLevel]);
        cache_get_value_int(i, "ep_skill", BizInfo[dbID][bEPSkill]);
        cache_get_value_int(i, "ms_skill", BizInfo[dbID][bMSkill]);
        cache_get_value_int(i, "earnings", BizInfo[dbID][bEarnings]);
        cache_get_value_int(i, "fee", BizInfo[dbID][bFee]);
        cache_get_value_int(i, "price", BizInfo[dbID][bPrice]);
        cache_get_value_int(i, "type", BizInfo[dbID][bType]);

        cache_get_value(i, "owner_name", BizInfo[dbID][bOwnerName], 256);
        cache_get_value(i, "name", BizInfo[dbID][bName], 256);

        // Създаване на пикап
        bizpickup[dbID] = CreatePickup(1272, 1, BizInfo[dbID][bX], BizInfo[dbID][bY], BizInfo[dbID][bZ], 0);
        BizByPickup[bizpickup[dbID]] = dbID;
        
        // Създаване на 3D текст
        if (BizInfo[dbID][bEP] >= 1)
        {
            new text[256];
            format(text, sizeof(text),
                "{00FF00}Ако притежаваш този бизнес\nще получаваш {FFFFFF}%d EP {00FF00}на всеки {FF0000}Payday",
                BizInfo[dbID][bEP]
            );
            BizInfo[dbID][bText] = Create3DTextLabel(text, 0x00FF00AA, BizInfo[dbID][bX], BizInfo[dbID][bY], BizInfo[dbID][bZ], 25.0, 0, 1);
        }
    }
    
    CheckMaxBizID();

    cache_delete(result);
    printf("[MySQL] Заредени са %d на брой бизнеса (ID: 1..%d)", rows, rows);
    return 1;
}

/*
* Checks if biz exists by id
*/

stock BizExists(bizid)
{
    new query[64];
    mysql_format(Database, query, sizeof(query),
        "SELECT id FROM businesses WHERE id = %d LIMIT 1;",
        bizid + 1
    );

    new Cache:result = mysql_query(Database, query);

    new bool:exists = (cache_num_rows() > 0);

    cache_delete(result);
    return exists;
}

/*
* Updates biz table in db
*/
stock UpdateBizDatabaseINT(bizid, const columnName[], columnValue)
{
    new query[512];
    mysql_format(Database, query, sizeof(query), 
        "UPDATE businesses SET `%s` = %d WHERE id = %d;", 
        columnName, columnValue, bizid + 1);
    mysql_tquery(Database, query);
}

stock UpdateBizDatabaseSTR(bizid, const columnName[], columnValue[])
{
    new query[512];
    mysql_format(Database, query, sizeof(query), 
        "UPDATE businesses SET `%s` = '%e' WHERE id = %d;", 
        columnName, columnValue, bizid + 1);
    mysql_tquery(Database, query);
}

/*
* Saves biz in db
*/
stock SaveBiz(bizID)
{
    new query[512];

    mysql_format(MySQL:Database, query, sizeof(query),
        "UPDATE businesses SET owner_name = '%e', owner = %d, locked = %d, fee = %d, earnings = %d, name = '%e' WHERE id = %d;",
        BizInfo[bizID][bOwnerName],
        BizInfo[bizID][bOwner],
        BizInfo[bizID][bLocked],
        BizInfo[bizID][bFee],
        BizInfo[bizID][bEarnings],
        BizInfo[bizID][bName],
        bizID + 1
    );

    mysql_tquery(MySQL:Database, query);
}

/*
* Destroys Biz
*/
stock DestroyBiz(bizid)
{
    new query[128];
    
    mysql_format(MySQL:Database, query, sizeof(query),
        "DELETE FROM businesses WHERE id = %d;",
        bizid + 1
    );

    mysql_tquery(MySQL:Database, query);

    format(BizInfo[bizid][bOwnerName], 256, "None");
    BizInfo[bizid][bOwner] = 0;
    
    Delete3DTextLabel(BizInfo[bizid][bText]);
    DestroyPickup(bizpickup[bizid]);
}
