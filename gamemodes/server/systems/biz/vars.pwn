/*
* Biz Data
*/

enum bInfo
{
    Float:bX,
    Float:bY,
    Float:bZ,
    bOwner,
    bLocked,
    bEP,
    Text3D:bText,
    bOwnerName[256],
    bLevel,
    bPayOut,
    bEPSkill,
    bMSkill,
    bEarnings,
    bFee,
    bName[256],
    bPrice,
    bType
}
new BizInfo[MAX_BIZZ][bInfo];

/*
* Pickup
*/
new bizpickup[MAX_BIZZ];
new BizByPickup[MAX_PICKUPS];
/*
* Maximum Val
*/
new maxbiz = 1;
