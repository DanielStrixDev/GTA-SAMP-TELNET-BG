stock IsPlayerInRobPlace(playerid)
{
    if (IsPlayerInRangeOfPoint(playerid, 7, ROB_CALIGULA_COORS) && robberyPlace == ROB_CALIGULA) return true;
    if (IsPlayerInRangeOfPoint(playerid, 7, ROB_ARTIUM_COORS) && robberyPlace == ROB_ARTIUM) return true;
    if (IsPlayerInRangeOfPoint(playerid, 7, ROB_BOAT_COORS) && robberyPlace == ROB_BOAT) return true;
    return false;
}
