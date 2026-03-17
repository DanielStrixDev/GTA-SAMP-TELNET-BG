stock ToggleEngine(vehicleid, toggle)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, toggle, lights, alarm, doors, bonnet, boot, objective);
}
stock ToggleAlarm(vehicleid, toggle)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, lights, toggle, doors, bonnet, boot, objective);
}
stock ToggleBonnet(vehicleid, toggle)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, toggle, boot, objective);
}
stock ToggleLights(vehicleid, toggle)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, toggle, alarm, doors, bonnet, boot, objective);
}
stock ToggleBoot(vehicleid, toggle)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, toggle, objective);
}

stock GetVehicleKmh(vehicleid)
{
    new Float:x, Float:y, Float:z, vel;
    GetVehicleVelocity(vehicleid, x, y, z);
    vel = floatround(floatsqroot(x * x + y * y + z * z) * 180);
    return vel;
}

/*
* Plate
*/
stock ProcessPlateChange(playerid, plateText[], businessID)
{
    GivePlayerCash(playerid, -500);
    
    new vehicleid = GetPlayerVehicleID(playerid);
    SetVehicleNumberPlate(vehicleid, plateText);
    
    new Float:x, Float:y, Float:z, Float:angle;
    GetVehiclePos(vehicleid, x, y, z);
    GetVehicleZAngle(vehicleid, angle);
    
    RemovePlayerFromVehicle(playerid);
    SetVehicleToRespawn(vehicleid);
    SetVehiclePos(vehicleid, x, y, z);
    SetVehicleZAngle(vehicleid, angle);
    
    SendClientMessage(playerid, 0xFFFFFFFF, "Ти промени текста на твоята кола!");
    
    // Respawn all vehicles (this seems odd - might want to review this logic)
    for (new i = GetVehiclePoolSize(); i > 0; i--)
    {
        if (GetVehicleModel(i) != 0) // Only respawn valid vehicles
        {
            SetVehicleToRespawn(i);
        }
    }
}

/*
* Load Tune for vehicles
*/
stock LoadVehTune(vehicleid)
{
    if (vehicleid == vipVehs[23])
    {
        ChangeVehiclePaintjob(vehicleid, 1);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[24])
    {
        ChangeVehiclePaintjob(vehicleid, 1);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[25])
    {
        ChangeVehiclePaintjob(vehicleid, 0);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[26])
    {
        ChangeVehiclePaintjob(vehicleid, 2);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[27])
    {
        ChangeVehiclePaintjob(vehicleid, 1);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[28])
    {
        ChangeVehiclePaintjob(vehicleid, 0);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[29])
    {
        ChangeVehiclePaintjob(vehicleid, 1);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[31])
    {
        ChangeVehiclePaintjob(vehicleid, 1);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[32])
    {
        ChangeVehiclePaintjob(vehicleid, 2);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[33])
    {
        ChangeVehiclePaintjob(vehicleid, 0);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[34])
    {
        ChangeVehiclePaintjob(vehicleid, 1);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[35])
    {
        ChangeVehiclePaintjob(vehicleid, 1);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
}