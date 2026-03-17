/*
* Loads Private Vehs from DB
*/

stock LoadPrivateVehicles()
{
    LoadPrivateVehicleModels();

    new Cache: resultCache;
    new query[128];
    format(query, sizeof(query), "SELECT * FROM private_vehicles");
    resultCache = mysql_query(MySQL:Database, query);

    new rows = cache_num_rows();
    if (rows > 0)
    {
        for (new i = 0; i < rows; i++)
        {
            cache_get_value_name_int(i, "v_id", PrivateVeh[i][pvModel]);
            cache_get_value_name_int(i, "c1", PrivateVeh[i][pvColor1]);
            cache_get_value_name_int(i, "c2", PrivateVeh[i][pvColor2]);
            cache_get_value_name_int(i, "respawn_time", PrivateVeh[i][pvRespawnTime]);
            cache_get_value_name_float(i, "x", PrivateVeh[i][pvX]);
            cache_get_value_name_float(i, "y", PrivateVeh[i][pvY]);
            cache_get_value_name_float(i, "z", PrivateVeh[i][pvZ]);
            cache_get_value_name_float(i, "angle", PrivateVeh[i][pvAngle]);
            cache_get_value_name(i, "owner", PrivateVeh[i][pvOwner], 40);

            PrivateVeh[i][pvIsOwned] = 1; // всички записи от БД се считат за "активни"

            // Създаване на превозното средство
            PrivateVeh[i][pvID] = CreateVehicle(
                PrivateVeh[i][pvModel],
                PrivateVeh[i][pvX],
                PrivateVeh[i][pvY],
                PrivateVeh[i][pvZ],
                PrivateVeh[i][pvAngle],
                PrivateVeh[i][pvColor1],
                PrivateVeh[i][pvColor2],
                -1 // без автоматичен респаун
            );

            if (PrivateVeh[i][pvRespawnTime] == -1)
            {
                PrivateVeh[i][pvID] = AddStaticVehicle(PrivateVeh[i][pvModel], PrivateVeh[i][pvX], PrivateVeh[i][pvY], PrivateVeh[i][pvZ], PrivateVeh[i][pvAngle], PrivateVeh[i][pvColor1], PrivateVeh[i][pvColor2]);
                SetVehicleVirtualWorld(PrivateVeh[i][pvID], PrivateVeh[i][pvVirtualWorld]);
            }
            else
            {
                PrivateVeh[i][pvID] = CreateVehicle(PrivateVeh[i][pvModel], PrivateVeh[i][pvX], PrivateVeh[i][pvY], PrivateVeh[i][pvZ], PrivateVeh[i][pvAngle], PrivateVeh[i][pvColor1], PrivateVeh[i][pvColor2], PrivateVeh[i][pvRespawnTime]);
                SetVehicleVirtualWorld(PrivateVeh[i][pvID], PrivateVeh[i][pvVirtualWorld]);
            }
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
    new query[512];
    mysql_format(MySQL:Database, query, sizeof(query),
        "INSERT INTO `private_vehicles` " \
        "(`id`, `v_id`, `c1`, `c2`, `x`, `y`, `z`, `angle`, `owner`) " \
        "VALUES (%d, %d, %d, %d, %f, %f, %f, %f, '%s');",
        vehicleid+1,
        PrivateVeh[vehicleid][pvModel],
        PrivateVeh[vehicleid][pvColor1],
        PrivateVeh[vehicleid][pvColor2],
        PrivateVeh[vehicleid][pvX],
        PrivateVeh[vehicleid][pvY],
        PrivateVeh[vehicleid][pvZ],
        PrivateVeh[vehicleid][pvAngle],
        PrivateVeh[vehicleid][pvOwner]
    );

    mysql_tquery(MySQL:Database, query);
    return 1;
}

/*
* Saves Private Veh into DB
*/
stock SavePrivateVeh(vehicleid)
{
    new query[512];

    mysql_format(Database, query, sizeof(query),
        "UPDATE private_vehicles SET " \
        "model = '%d', " \
        "is_owned = '%d', " \
        "owner = '%e', " \
        "x = '%f', " \
        "y = '%f', " \
        "z = '%f', " \
        "angle = '%f', " \
        "virtual_world = '%d', " \
        "color1 = '%d', " \
        "color2 = '%d', " \
        "respawn_time = '%d' " \
        "WHERE id = '%d';",

        // integer values
        PrivateVeh[vehicleid][pvModel],
        PrivateVeh[vehicleid][pvIsOwned],

        // string (escaped)
        PrivateVeh[vehicleid][pvOwner],

        // float values
        PrivateVeh[vehicleid][pvX],
        PrivateVeh[vehicleid][pvY],
        PrivateVeh[vehicleid][pvZ],
        PrivateVeh[vehicleid][pvAngle],

        // more integers
        PrivateVeh[vehicleid][pvVirtualWorld],
        PrivateVeh[vehicleid][pvColor1],
        PrivateVeh[vehicleid][pvColor2],
        PrivateVeh[vehicleid][pvRespawnTime],

        // WHERE id = ...
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
        "UPDATE private_vehicles SET " \
        "respawn_time = '%d', " \
        "WHERE id = '%d';",
        
        time,
        vehicleid
    );
    
    // Изпълняваме заявката
    mysql_tquery(Database, query);
}

/*
* Set Private Veh Coords
*/
stock PrivateVehSetPos(vehicleid, Float:x, Float:y, Float:z, Float:angle)
{
    new query[512];
    
    mysql_format(Database, query, sizeof(query),
        "UPDATE private_vehicles SET " \
        "x = '%f', " \
        "y = '%f', " \
        "z = '%f', " \
        "angle = '%f', " \
        "WHERE id = '%d';",
        
        // integer values
        x,
        y,
        z,
        angle,
        vehicleid
    );
    
    // Изпълняваме заявката
    mysql_tquery(Database, query);
}

/*
* Set Private Veh Coords
*/
stock PrivateVehSetColor(vehicleid, color1, color2)
{
    new query[512];
    
    mysql_format(Database, query, sizeof(query),
        "UPDATE private_vehicles SET " \
        "c1 = '%d', " \
        "c2 = '%d', " \
        "WHERE id = '%d';",
        
        // integer values
        color1,
        color2,
        vehicleid
    );
    
    // Изпълняваме заявката
    mysql_tquery(Database, query);
}

/*
* Checks if private veh exists by id
*/

stock PrivateVehExists(vehid)
{
    new query[64];
    mysql_format(Database, query, sizeof(query),
        "SELECT id FROM private_vehicles WHERE id = '%d' LIMIT 1;",
        vehid
    );

    new Cache:result = mysql_query(Database, query);

    new bool:exists = (cache_num_rows() > 0);

    cache_delete(result);
    return exists;
}