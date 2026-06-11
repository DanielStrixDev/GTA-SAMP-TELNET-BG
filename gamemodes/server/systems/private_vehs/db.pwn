/*
* Loads Private Vehs from DB
*/

stock LoadPrivateVehicles()
{
    LoadPrivateVehicleModels();

    // Инициализиране с -1 за празните слотове
    for (new i = 0; i < MAX_VEHICLES; i++)
    {
        VehicleToPrivateSlot[i] = -1;
    }

    new Cache:resultCache;
    new query[128];
    format(query, sizeof(query), "SELECT * FROM private_vehicles ORDER BY id");
    resultCache = mysql_query(MySQL:Database, query);

    new rows = cache_num_rows();
    if (rows > 0)
    {
        for (new i = 0; i < rows; i++)
        {
            new dbId;
            cache_get_value_name_int(i, "id", dbId);

            // Проверка за валиден индекс
            if (dbId < 1 || dbId > MAX_PRIVATEVEHS)
            {
                printf("Грешка: Невалиден ID %d при зареждане на private vehicle", dbId);
                continue;
            }

            cache_get_value_name_int(i, "model", PrivateVeh[dbId][pvModel]);
            cache_get_value_name_int(i, "c1", PrivateVeh[dbId][pvColor1]);
            cache_get_value_name_int(i, "c2", PrivateVeh[dbId][pvColor2]);
            cache_get_value_name_int(i, "respawn_time", PrivateVeh[dbId][pvRespawnTime]);
            cache_get_value_name_float(i, "x", PrivateVeh[dbId][pvX]);
            cache_get_value_name_float(i, "y", PrivateVeh[dbId][pvY]);
            cache_get_value_name_float(i, "z", PrivateVeh[dbId][pvZ]);
            cache_get_value_name_float(i, "angle", PrivateVeh[dbId][pvAngle]);
            cache_get_value_name(i, "owner", PrivateVeh[dbId][pvOwner], 40);
            PrivateVeh[dbId][pvIsOwned] = 1;

            // Създаване на превозното средство
            if (PrivateVeh[dbId][pvRespawnTime] == -1)
            {
                PrivateVeh[dbId][pvID] = AddStaticVehicle(
                                             PrivateVeh[dbId][pvModel],
                                             PrivateVeh[dbId][pvX],
                                             PrivateVeh[dbId][pvY],
                                             PrivateVeh[dbId][pvZ],
                                             PrivateVeh[dbId][pvAngle],
                                             PrivateVeh[dbId][pvColor1],
                                             PrivateVeh[dbId][pvColor2]
                                         );
            }
            else
            {
                PrivateVeh[dbId][pvID] = CreateVehicle(
                                             PrivateVeh[dbId][pvModel],
                                             PrivateVeh[dbId][pvX],
                                             PrivateVeh[dbId][pvY],
                                             PrivateVeh[dbId][pvZ],
                                             PrivateVeh[dbId][pvAngle],
                                             PrivateVeh[dbId][pvColor1],
                                             PrivateVeh[dbId][pvColor2],
                                             PrivateVeh[dbId][pvRespawnTime]
                                         );
            }

            VehicleToPrivateSlot[PrivateVeh[dbId][pvID]] = dbId;
            SetVehicleToRespawn(PrivateVeh[dbId][pvID]);
        }
    }

    cache_delete(resultCache);
    printf("[MYSQL] Заредени са %d лични превозни средства от базата.", rows);
    return 1;
}

/*
* Inserts Private Veh into DB
*/

stock InsertPrivateVehIntoDB(vehicleid)
{
    LoadPrivateVehicleModels();

    if (IsDefinedPrivateVehID(vehicleid))
    {
        LoadPrivateVehicleColors();

        new query[512];
        mysql_format(MySQL:Database, query, sizeof(query),
                     "INSERT INTO `private_vehicles` \
        (`model`, `c1`, `c2`, `x`, `y`, `z`, `angle`, `owner`, `respawn_time`) \
        VALUES (%d, %d, %d, %f, %f, %f, %f, '%s', %d);",
                     PrivateVeh[vehicleid][pvModel],
                     PrivateVeh[vehicleid][pvColor1],
                     PrivateVeh[vehicleid][pvColor2],
                     PrivateVeh[vehicleid][pvX],
                     PrivateVeh[vehicleid][pvY],
                     PrivateVeh[vehicleid][pvZ],
                     PrivateVeh[vehicleid][pvAngle],
                     PrivateVeh[vehicleid][pvOwner],
                     PrivateVeh[vehicleid][pvRespawnTime]
                    );

        // Вземете последния вмъкнат ID
        mysql_tquery(MySQL:Database, query, "OnPrivateVehicleInsert", "i", vehicleid);
    }
    return 1;
}

// Callback за получаване на ID-то
forward OnPrivateVehicleInsert(vehicleid);
public OnPrivateVehicleInsert(vehicleid)
{
    PrivateVeh[vehicleid][pvID] = cache_insert_id();
    printf("Създадено ново private vehicle с ID: %d", PrivateVeh[vehicleid][pvID]);
}

/*
* Saves Private Veh into DB
*/

stock SavePrivateVeh(vehicleid)
{
    new query[512];

    mysql_format(Database, query, sizeof(query),
                 "UPDATE private_vehicles SET \
        model = %d, \
        owner = '%e', \
        x = %f, \
        y = %f, \
        z = %f, \
        angle = %f, \
        c1 = %d, \
        c2 = %d, \
        respawn_time = %d \
        WHERE id = %d;",
                 PrivateVeh[vehicleid][pvModel],
                 PrivateVeh[vehicleid][pvOwner],
                 PrivateVeh[vehicleid][pvX],
                 PrivateVeh[vehicleid][pvY],
                 PrivateVeh[vehicleid][pvZ],
                 PrivateVeh[vehicleid][pvAngle],
                 PrivateVeh[vehicleid][pvColor1],
                 PrivateVeh[vehicleid][pvColor2],
                 PrivateVeh[vehicleid][pvRespawnTime],
                 vehicleid
                );

    mysql_tquery(Database, query);
}

/*
* Set Private Veh Respawn Time
*/

stock PrivateVehSetRespawn(vehicleid, time)
{
    new query[512];

    mysql_format(Database, query, sizeof(query),
                 "UPDATE private_vehicles SET respawn_time = %d WHERE id = %d;",
                 time,
                 vehicleid
                );

    mysql_tquery(Database, query);

    // Актуализира и локалната променлива
    PrivateVeh[vehicleid][pvRespawnTime] = time;
}

/*
* Set Private Veh Coords
*/

stock PrivateVehSetPos(vehicleid, Float:x, Float:y, Float:z, Float:angle)
{
    new query[512];

    mysql_format(Database, query, sizeof(query),
                 "UPDATE private_vehicles SET x = %f, y = %f, z = %f, angle = %f WHERE id = %d;",
                 x, y, z, angle, vehicleid
                );

    mysql_tquery(Database, query);

    // Актуализира и локалните променливи
    PrivateVeh[vehicleid][pvX] = x;
    PrivateVeh[vehicleid][pvY] = y;
    PrivateVeh[vehicleid][pvZ] = z;
    PrivateVeh[vehicleid][pvAngle] = angle;
}

/*
* Set Private Veh Color
*/

stock PrivateVehSetColor(vehicleid, color1, color2)
{
    new query[512];

    mysql_format(Database, query, sizeof(query),
                 "UPDATE private_vehicles SET c1 = %d, c2 = %d WHERE id = %d;",
                 color1,
                 color2,
                 vehicleid
                );

    mysql_tquery(Database, query);

    // Актуализира и локалните променливи
    PrivateVeh[vehicleid][pvColor1] = color1;
    PrivateVeh[vehicleid][pvColor2] = color2;
}

/*
* Checks if private veh exists by id
*/

stock PrivateVehExists(vehid)
{
    new query[64];
    mysql_format(Database, query, sizeof(query),
                 "SELECT id FROM private_vehicles WHERE id = %d LIMIT 1;",
                 vehid
                );

    new Cache:result = mysql_query(Database, query);
    new bool:exists = (cache_num_rows() > 0);
    cache_delete(result);

    return exists;
}

/*
* Checks if private veh exists by id
*/

stock IsDefinedPrivateVehID(vehicleid)
{
    if (PrivateVeh[vehicleid][pvModel] == 0)
    {
        return false;
    }
    return true;
}