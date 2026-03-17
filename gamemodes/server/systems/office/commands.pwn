CMD:helpoffice(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 3.0, 1794.0231, -1301.7737, 13.5050)) return SendClientMessage(playerid, COLOR_GRAD1, "Не си на мястото за преглеждане на офиси!");
    new string2230[512];
    new string2230result[2230];
    for (new i = 1; i < MAX_OFFICES; i++)
    {
        format(string2230, 512, "{00FF00}Етаж %d - {FFFF00}Информация\n", i);
        strcat(string2230result, string2230);
    }
    ShowPlayerDialog(playerid, DIALOG_HELP_OFFICE, DIALOG_STYLE_LIST, "Intense Office Center", string2230result, "Избери", "Излез");
    return 1;
}
CMD:office(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 3.0, 1794.0231, -1301.7737, 13.5050)) return SendClientMessage(playerid, COLOR_GRAD1, "Не си на мястото за преглеждане на офиси!");
    new string2230[512];
    new string2230result[2230];
    new closeddialog = 3500;

    for (new i = 1; i < MAX_OFFICES; i++)
    {
        if (OfficeInfo[i][isOwned] == 0)
        {
            format(string2230, 512, "{00FF00}Етаж %d - Притежател: {FF0000}Няма\n", i);
            strcat(string2230result, string2230);
        }
        else if (OfficeInfo[i][isOwned] == 1)
        {
            format(string2230, 512, "{00FF00}Етаж %d - Притежател: {FF0000}%s\n", i, OfficeInfo[i][OwnerName]);
            strcat(string2230result, string2230);
        }
    }

    ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, "Intense Office Center", string2230result, "OK", "");
    return 1;
}
CMD:buyoffice(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 3.0, 1794.0231, -1301.7737, 13.5050)) return SendClientMessage(playerid, COLOR_GRAD1, "Не си на мястото за купуване на офиси!");
    new string2230[512];
    new string2230result[2230];
    for (new i = 1; i < MAX_OFFICES; i++)
    {
        if (OfficeInfo[i][isOwned] == 0)
        {
            format(string2230, 512, "{00FF00}Етаж %d - Притежател: {FF0000}Няма\n", i);
            strcat(string2230result, string2230);
        }
        else if (OfficeInfo[i][isOwned] == 1)
        {
            format(string2230, 512, "{00FF00}Етаж %d - Притежател: {FF0000}%s\n", i, OfficeInfo[i][OwnerName]);
            strcat(string2230result, string2230);
        }
    }
    ShowPlayerDialog(playerid, DIALOG_BUY_OFFICE, DIALOG_STYLE_LIST, "Intense Office Center", string2230result, "OK", "");
    return 1;
}
