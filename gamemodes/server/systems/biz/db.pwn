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
        
        new bizIndex = dbID - 1;
        
        if (bizIndex < 0 || bizIndex >= MAX_BIZZ) 
        {
            printf("[ГРЕШКА] Невалиден ID за бизнес: %d", dbID);
            continue;
        }

        cache_get_value_float(i, "x", BizInfo[bizIndex][bX]);
        cache_get_value_float(i, "y", BizInfo[bizIndex][bY]);
        cache_get_value_float(i, "z", BizInfo[bizIndex][bZ]);

        cache_get_value_int(i, "pay_out", BizInfo[bizIndex][bPayOut]);
        cache_get_value_int(i, "owner", BizInfo[bizIndex][bOwner]);
        cache_get_value_int(i, "locked", BizInfo[bizIndex][bLocked]);
        cache_get_value_int(i, "ep", BizInfo[bizIndex][bEP]);
        cache_get_value_int(i, "level", BizInfo[bizIndex][bLevel]);
        cache_get_value_int(i, "ep_skill", BizInfo[bizIndex][bEPSkill]);
        cache_get_value_int(i, "ms_skill", BizInfo[bizIndex][bMSkill]);
        cache_get_value_int(i, "earnings", BizInfo[bizIndex][bEarnings]);
        cache_get_value_int(i, "fee", BizInfo[bizIndex][bFee]);
        cache_get_value_int(i, "price", BizInfo[bizIndex][bPrice]);
        cache_get_value_int(i, "type", BizInfo[bizIndex][bType]);

        cache_get_value(i, "owner_name", BizInfo[bizIndex][bOwnerName], 256);
        cache_get_value(i, "name", BizInfo[bizIndex][bName], 256);

        bizpickup[bizIndex] = CreatePickup(1272, 1, BizInfo[bizIndex][bX], BizInfo[bizIndex][bY], BizInfo[bizIndex][bZ], 0);
        BizByPickup[bizpickup[bizIndex]] = bizIndex;
        new text[256];
        if (BizInfo[bizIndex][bEP] >= 1)
        {
            format(text, sizeof(text),
                "{00FF00}Ако притежаваш този бизнес\nще получаваш {FFFFFF}%d EP {00FF00}на всеки {FF0000}Payday",
                BizInfo[bizIndex][bEP]
            );
            BizInfo[bizIndex][bText] = Create3DTextLabel(text, 0x00FF00AA, BizInfo[bizIndex][bX], BizInfo[bizIndex][bY], BizInfo[bizIndex][bZ], 25.0, 0, 1);
        }
    }
    CheckMaxBizID();

    cache_delete(result);
    printf("[MySQL] Заредени са %d на брой бизнеса", rows);
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
