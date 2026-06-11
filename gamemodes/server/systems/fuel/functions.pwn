stock GetPlayerNearFuelStation(playerid, Float:range = 10.0)
{
    for (new i = 0; i < 17; i++)
    {
        if (IsPlayerInRangeOfPoint(playerid, range, g_FuelStationData[i][fsX], g_FuelStationData[i][fsY], g_FuelStationData[i][fsZ]))
        {
            return i;
        }
    }
    return -1;
}

stock GetFuelStationName(stationId)
{
    if (stationId < 0 || stationId >= 17) return "Invalid fuel station";
    return g_FuelStationData[stationId][fsName];
}

stock UpdateFuelStationLabel(stationId)
{
    if (stationId < 0 || stationId >= 17) return;

    new labelText[500];
    format(labelText, sizeof(labelText),
           "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш",
           fuelStationsFuel[stationId]);

    Delete3DTextLabel(fuelStationText[stationId]);
    fuelStationText[stationId] = Create3DTextLabel(labelText, 0xFFFFFFFF,
                                 g_FuelStationData[stationId][fsX],
                                 g_FuelStationData[stationId][fsY],
                                 g_FuelStationData[stationId][fsZ],
                                 40, 0, 0);
}