CMD:top(playerid, params[])
{
    if (RecordInfo[0][record] == 20)
    {
        return SendClientMessage(playerid, 0x80FF80FF, "Все-още няма рекорд по най-много убийства без умиране в DM Area!");
    }
    new stringa[256];
    format(stringa, 256, ">>>>>>>>>> %s - %d убийства <<<<<<<<<<", RecordInfo[0][recordPlayer], RecordInfo[0][record]);
    SendClientMessage(playerid, 0x80FF80FF, stringa);
    return 1;
}
