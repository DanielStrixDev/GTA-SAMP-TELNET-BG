/*
* Buy house
*/
stock BoughtHouse(playerid, houseid)
{
    // Проверка за валидност на houseid
    if (houseid < 0) return 0;

    new query[256];

    // Обновяваме информацията в масива
    format(HouseInfo[houseid][hOwnerName], 256, "%s", GetPlayerNickname(playerid));
    HouseInfo[houseid][hOwner] = 1;

    // Записваме в MySQL - houseid + 1 за съответствие с базата данни
    mysql_format(Database, query, sizeof(query),
                 "UPDATE houses SET owner_name = '%e', owner = 1 WHERE id = %d;",
                 HouseInfo[houseid][hOwnerName],
                 houseid + 1  // <-- Промяна: +1 за съответствие с базата данни
                );

    mysql_tquery(Database, query);
    return 1;
}

/*
* Saves house into db
*/
stock SaveHouse(houseid)
{
    // Проверка за валидност на houseid
    if (houseid < 0) return 0;

    new query[512];

    // Форматираме заявката
    mysql_format(Database, query, sizeof(query),
                 "UPDATE houses SET " \
                 "x = %f, y = %f, z = %f, cx = %f, cy = %f, cz = %f, ca = %f, " \
                 "cc = %d, c_c2 = %d, cv = %d, c_veh = %d, " \
                 "owner = %d, locked = %d, veh = %d, " \
                 "level = %d, price = %d, interior = %d, " \
                 "armour = %d, health = %d, owner_name = '%e' " \
                 "WHERE id = %d;",

                 // float values
                 HouseInfo[houseid][hX],
                 HouseInfo[houseid][hY],
                 HouseInfo[houseid][hZ],

                 // float values
                 HouseInfo[houseid][hcX],
                 HouseInfo[houseid][hcY],
                 HouseInfo[houseid][hcZ],
                 HouseInfo[houseid][hcA],

                 // integers
                 HouseInfo[houseid][hcC],
                 HouseInfo[houseid][hcC2],
                 HouseInfo[houseid][hcV],
                 HouseInfo[houseid][hcVeh],
                 HouseInfo[houseid][hOwner],
                 HouseInfo[houseid][hLocked],
                 HouseInfo[houseid][hVeh],
                 HouseInfo[houseid][hLevel],
                 HouseInfo[houseid][hPrice],
                 HouseInfo[houseid][hInterior],
                 HouseInfo[houseid][hArmour],
                 HouseInfo[houseid][hHealth],

                 // string (escaped with %e for safety)
                 HouseInfo[houseid][hOwnerName],

                 // WHERE id = ... +1 за съответствие с базата данни
                 houseid + 1  // <-- Промяна: +1 за съответствие с базата данни
                );

    // Изпълняваме заявката
    mysql_tquery(Database, query);
    return 1;
}

/*
* Return Next ID
*/
stock ReturnNextUnusedHouseID()
{
    new Cache:result, last_id;
    result = mysql_query(Database, "SELECT MAX(id) AS lastid FROM houses;");

    if (cache_num_rows()) // има резултат
    {
        cache_get_value_int(0, "lastid", last_id);
        cache_delete(result);
        // Трябва да върнем ID за масива (0-based), не за базата
        // Ако последният ID в базата е N, следващият в масива е (N - 1) + 1 = N
        return last_id; // <-- Промяна: просто last_id
    }

    cache_delete(result);
    return 0; // <-- Промяна: ако няма записи, започваме от 0
}

/*
* Load houses
*/
stock LoadHouses()
{
    new Cache:result, rows;
    result = mysql_query(Database, "SELECT * FROM houses ORDER BY id;");
    rows = cache_num_rows();

    for (new i = 0; i < rows; i++)
    {
        new dbID;
        cache_get_value_int(i, "id", dbID);

        // Преобразуваме dbID към индекс в масива
        new arrayIndex = dbID - 1; // <-- Промяна: -1 за масива

        if (arrayIndex < 0 || arrayIndex >= MAX_HOUSES)
        {
            printf("[ГРЕШКА] Невалиден ID за къща: %d (arrayIndex: %d)", dbID, arrayIndex);
            continue;
        }

        cache_get_value_float(i, "x", HouseInfo[arrayIndex][hX]);
        cache_get_value_float(i, "y", HouseInfo[arrayIndex][hY]);
        cache_get_value_float(i, "z", HouseInfo[arrayIndex][hZ]);

        cache_get_value_float(i, "cx", HouseInfo[arrayIndex][hcX]);
        cache_get_value_float(i, "cy", HouseInfo[arrayIndex][hcY]);
        cache_get_value_float(i, "cz", HouseInfo[arrayIndex][hcZ]);
        cache_get_value_float(i, "ca", HouseInfo[arrayIndex][hcA]);

        cache_get_value_int(i, "cc", HouseInfo[arrayIndex][hcC]);
        cache_get_value_int(i, "c_c2", HouseInfo[arrayIndex][hcC2]);
        cache_get_value_int(i, "cv", HouseInfo[arrayIndex][hcV]);
        cache_get_value_int(i, "c_veh", HouseInfo[arrayIndex][hcVeh]);

        cache_get_value_int(i, "owner", HouseInfo[arrayIndex][hOwner]);
        cache_get_value_int(i, "locked", HouseInfo[arrayIndex][hLocked]);
        cache_get_value_int(i, "veh", HouseInfo[arrayIndex][hcVeh]);
        cache_get_value_int(i, "level", HouseInfo[arrayIndex][hLevel]);
        cache_get_value_int(i, "price", HouseInfo[arrayIndex][hPrice]);
        cache_get_value_int(i, "interior", HouseInfo[arrayIndex][hInterior]);
        cache_get_value_int(i, "armour", HouseInfo[arrayIndex][hArmour]);
        cache_get_value_int(i, "health", HouseInfo[arrayIndex][hHealth]);

        cache_get_value(i, "owner_name", HouseInfo[arrayIndex][hOwnerName], 256);

        // Create pickup
        housepickup[arrayIndex] = CreatePickup(1273, 1, HouseInfo[arrayIndex][hX], HouseInfo[arrayIndex][hY], HouseInfo[arrayIndex][hZ], 0);
        HouseByPickup[housepickup[arrayIndex]] = arrayIndex;

        // Spawn house vehicle if needed
        if (HouseInfo[arrayIndex][hcV] != 0 && HouseInfo[arrayIndex][hcX] != 0.0)
        {
            HouseInfo[arrayIndex][hcVeh] = CreateVehicle(
                                               HouseInfo[arrayIndex][hcV],
                                               HouseInfo[arrayIndex][hcX],
                                               HouseInfo[arrayIndex][hcY],
                                               HouseInfo[arrayIndex][hcZ],
                                               HouseInfo[arrayIndex][hcA],
                                               HouseInfo[arrayIndex][hcC],
                                               HouseInfo[arrayIndex][hcC2],
                                               1800000
                                           );

            new houseVeh = HouseInfo[arrayIndex][hcVeh];
            VehicleInfo[houseVeh][vHouseID] = arrayIndex;
            VehicleInfo[houseVeh][vIsHouseVeh] = true;
        }
    }

    cache_delete(result);
    CheckMaxHouseID();
    printf("[MySQL] Заредени са %d на брой къщи", rows);
}

/*
* Checks if a house exists by ID
*/
stock HouseExists(houseid)
{
    if (houseid < 0) return false;

    new query[64];
    mysql_format(Database, query, sizeof(query),
                 "SELECT id FROM houses WHERE id = %d LIMIT 1;",
                 houseid + 1  // <-- Промяна: +1 за съответствие с базата данни
                );

    new Cache:result = mysql_query(Database, query);

    new bool:exists = (cache_num_rows() > 0);

    cache_delete(result);
    return exists;
}

/*
* Check Max House ID
*/
stock CheckMaxHouseID()
{
    new Cache:result, last_id;
    result = mysql_query(Database, "SELECT MAX(id) AS lastid FROM houses;");

    if (cache_num_rows()) // има резултат
    {
        cache_get_value_int(0, "lastid", last_id);
        cache_delete(result);
        // maxhouses трябва да съответства на индексите в масива
        // Ако последният ID в базата е N, maxhouses = N - 1
        maxhouses = last_id - 1; // <-- Промяна: -1 за масива
        return maxhouses;
    }

    cache_delete(result);
    maxhouses = 0; // <-- Промяна: 0 ако няма записи
    return 0;
}