
stock DefineOfficeCenterData()
{
    for (new officeID = 1; officeID < MAX_OFFICES; officeID++)
    {
        OfficeInfo[officeID][NeededCash] = officeID * 100000000;
        OfficeInfo[officeID][NeededLevel] = officeID * 50;
        OfficeInfo[officeID][NeededEPS] = officeID * 10;
        OfficeInfo[officeID][NeededMS] = officeID * 10;
        OfficeInfo[officeID][BonusEP] = officeID * 10;
        OfficeInfo[officeID][BonusCash] = officeID * 50000;
    }
}

stock DefineFloorOwnerName(officeID)
{
    new officeString[256];

    if (OfficeInfo[officeID][isOwned] == 0)
    {
        format(officeString, 256, "Етаж %d\nПритежател:{FF0000} Няма", officeID);
    }
    else
    {
        format(officeString, 256, "Етаж %d\nПритежател:{00FF00} %s", officeID, OfficeInfo[officeID][OwnerName]);
    }

    Update3DTextLabelText(Office3DLabel[officeID], 0x00FF00FF, officeString);
}

stock DefineOfficeCenterTexts()
{
    Office3DLabel[1] = Create3DTextLabel(Office3DLabel[1], 0x00FF00FF, 1786.4745, -1300.6366, 22.2109, 10, 0, 0);
    Office3DLabel[2] = Create3DTextLabel(Office3DLabel[2], 0x00FF00FF, 1786.4745, -1300.6366, 27.6719, 10, 0, 0);
    Office3DLabel[3] = Create3DTextLabel(Office3DLabel[3], 0x00FF00FF, 1786.4745, -1300.6366, 33.1250, 10, 0, 0);
    Office3DLabel[4] = Create3DTextLabel(Office3DLabel[4], 0x00FF00FF, 1786.4745, -1300.6366, 38.5781, 10, 0, 0);
    Office3DLabel[5] = Create3DTextLabel(Office3DLabel[5], 0x00FF00FF, 1786.4745, -1300.6366, 44.0391, 10, 0, 0);
    Office3DLabel[6] = Create3DTextLabel(Office3DLabel[6], 0x00FF00FF, 1786.4745, -1300.6366, 49.4453, 10, 0, 0);
    Office3DLabel[7] = Create3DTextLabel(Office3DLabel[7], 0x00FF00FF, 1786.4745, -1300.6366, 54.9063, 10, 0, 0);
    Office3DLabel[8] = Create3DTextLabel(Office3DLabel[8], 0x00FF00FF, 1786.4745, -1300.6366, 60.3594, 10, 0, 0);
    Office3DLabel[9] = Create3DTextLabel(Office3DLabel[9], 0x00FF00FF, 1786.4745, -1300.6366, 65.8125, 10, 0, 0);
    Office3DLabel[10] = Create3DTextLabel(Office3DLabel[10], 0x00FF00FF, 1786.4745, -1300.6366, 71.2734, 10, 0, 0);
    Office3DLabel[11] = Create3DTextLabel(Office3DLabel[11], 0x00FF00FF, 1786.4745, -1300.6366, 76.6719, 10, 0, 0);
    Office3DLabel[12] = Create3DTextLabel(Office3DLabel[12], 0x00FF00FF, 1786.4745, -1300.6366, 82.1328, 10, 0, 0);
    Office3DLabel[13] = Create3DTextLabel(Office3DLabel[13], 0x00FF00FF, 1786.4745, -1300.6366, 87.5859, 10, 0, 0);
    Office3DLabel[14] = Create3DTextLabel(Office3DLabel[14], 0x00FF00FF, 1786.4745, -1300.6366, 93.0391, 10, 0, 0);
    Office3DLabel[15] = Create3DTextLabel(Office3DLabel[16], 0x00FF00FF, 1786.4745, -1300.6366, 103.9188, 10, 0, 0);
    Office3DLabel[16] = Create3DTextLabel(Office3DLabel[15], 0x00FF00FF, 1786.4745, -1300.6366, 98.5145, 10, 0, 0);
    Office3DLabel[17] = Create3DTextLabel(Office3DLabel[17], 0x00FF00FF, 1786.4745, -1300.6366, 109.3594, 10, 0, 0);
    Office3DLabel[18] = Create3DTextLabel(Office3DLabel[18], 0x00FF00FF, 1786.4745, -1300.6366, 114.8227, 10, 0, 0);
    Office3DLabel[19] = Create3DTextLabel(Office3DLabel[19], 0x00FF00FF, 1786.4745, -1300.6366, 120.2656, 10, 0, 0);
    Office3DLabel[20] = Create3DTextLabel(Office3DLabel[20], 0x00FF00FF, 1786.4745, -1300.6366, 125.7335, 10, 0, 0);
    for (new officeID = 1; officeID < MAX_OFFICES; officeID++)
    {
        DefineFloorOwnerName(officeID);
    }

    Create3DTextLabel("{FFFFFF}GTA{00FF00} INTENSE{FF0000} Office", 0xFFFFFFFF, 1786.5000, -1301.0005, 16.2408, 25, 0);
}
