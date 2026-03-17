/*
* Office Center Data
*/
enum offInfo
{
    isOwned,
    OwnerName[50],
    NeededLevel,
    NeededCash,
    NeededEPS,
    NeededMS,
    BonusEP,
    BonusCash
}
new OfficeInfo[MAX_OFFICES][offInfo];

/*
* 3D Text
*/
new Text3D:officeOwnerText[21];
