
stock DefineOfficeCenterData()
{
    for (new alo = 1; alo < MAX_OFFICES; alo++)
    {
        OfficeInfo[alo][NeededCash] = alo * 100000000;
        OfficeInfo[alo][NeededLevel] = alo * 50;
        OfficeInfo[alo][NeededEPS] = alo * 10;
        OfficeInfo[alo][NeededMS] = alo * 10;
        OfficeInfo[alo][BonusEP] = alo * 10;
        OfficeInfo[alo][BonusCash] = alo * 50000;
    }
}

stock DefineOfficeCenterTexts()
{
    new stringoffices[21][70];
    for (new alo = 1; alo < MAX_OFFICES; alo++)
    {
        if (OfficeInfo[alo][isOwned] == 0)
        {
            format(stringoffices[alo], 70, "Етаж %d\nПритежател:{FF0000} Няма", alo);
        }
        if (OfficeInfo[alo][isOwned] == 1)
        {
            format(stringoffices[alo], 70, "Етаж %d\nПритежател:{FF0000} %s", alo, OfficeInfo[alo][OwnerName]);
        }
    }
    officeOwnerText[1] = Create3DTextLabel(stringoffices[1], 0x00FF00FF, 1786.4745, -1300.6366, 22.2109, 10, 0, 0);
    officeOwnerText[2] = Create3DTextLabel(stringoffices[2], 0x00FF00FF, 1786.4745, -1300.6366, 27.6719, 10, 0, 0);
    officeOwnerText[3] = Create3DTextLabel(stringoffices[3], 0x00FF00FF, 1786.4745, -1300.6366, 33.1250, 10, 0, 0);
    officeOwnerText[4] = Create3DTextLabel(stringoffices[4], 0x00FF00FF, 1786.4745, -1300.6366, 38.5781, 10, 0, 0);
    officeOwnerText[5] = Create3DTextLabel(stringoffices[5], 0x00FF00FF, 1786.4745, -1300.6366, 44.0391, 10, 0, 0);
    officeOwnerText[6] = Create3DTextLabel(stringoffices[6], 0x00FF00FF, 1786.4745, -1300.6366, 49.4453, 10, 0, 0);
    officeOwnerText[7] = Create3DTextLabel(stringoffices[7], 0x00FF00FF, 1786.4745, -1300.6366, 54.9063, 10, 0, 0);
    officeOwnerText[8] = Create3DTextLabel(stringoffices[8], 0x00FF00FF, 1786.4745, -1300.6366, 60.3594, 10, 0, 0);
    officeOwnerText[9] = Create3DTextLabel(stringoffices[9], 0x00FF00FF, 1786.4745, -1300.6366, 65.8125, 10, 0, 0);
    officeOwnerText[10] = Create3DTextLabel(stringoffices[10], 0x00FF00FF, 1786.4745, -1300.6366, 71.2734, 10, 0, 0);
    officeOwnerText[11] = Create3DTextLabel(stringoffices[11], 0x00FF00FF, 1786.4745, -1300.6366, 76.6719, 10, 0, 0);
    officeOwnerText[12] = Create3DTextLabel(stringoffices[12], 0x00FF00FF, 1786.4745, -1300.6366, 82.1328, 10, 0, 0);
    officeOwnerText[13] = Create3DTextLabel(stringoffices[13], 0x00FF00FF, 1786.4745, -1300.6366, 87.5859, 10, 0, 0);
    officeOwnerText[14] = Create3DTextLabel(stringoffices[14], 0x00FF00FF, 1786.4745, -1300.6366, 93.0391, 10, 0, 0);
    officeOwnerText[15] = Create3DTextLabel(stringoffices[16], 0x00FF00FF, 1786.4745, -1300.6366, 103.9188, 10, 0, 0);
    officeOwnerText[16] = Create3DTextLabel(stringoffices[15], 0x00FF00FF, 1786.4745, -1300.6366, 98.5145, 10, 0, 0);
    officeOwnerText[17] = Create3DTextLabel(stringoffices[17], 0x00FF00FF, 1786.4745, -1300.6366, 109.3594, 10, 0, 0);
    officeOwnerText[18] = Create3DTextLabel(stringoffices[18], 0x00FF00FF, 1786.4745, -1300.6366, 114.8227, 10, 0, 0);
    officeOwnerText[19] = Create3DTextLabel(stringoffices[19], 0x00FF00FF, 1786.4745, -1300.6366, 120.2656, 10, 0, 0);
    officeOwnerText[20] = Create3DTextLabel(stringoffices[20], 0x00FF00FF, 1786.4745, -1300.6366, 125.7335, 10, 0, 0);
    Create3DTextLabel("{FFFFFF}GTA{00FF00} INTENSE{FF0000} Office", 0xFFFFFFFF, 1786.5000, -1301.0005, 16.2408, 25, 0);
}
