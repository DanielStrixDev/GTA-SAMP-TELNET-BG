/*
* House Data
*/
enum hInfo
{
    Float:hX,
    Float:hY,
    Float:hZ,
    Float:hcX,
    Float:hcY,
    Float:hcZ,
    Float:hcA,
    hcC,
    hcC2,
    hcV,
    hcVeh,
    hOwner,
    hLocked,
    hOwnerName[256],
    hVeh,
    hLevel,
    hPrice,
    hInterior,
    hArmour,
    hHealth
}
new HouseInfo[MAX_HOUSES][hInfo];

/*
* Pickup
*/
new housepickup[MAX_HOUSES];
new HouseByPickup[MAX_PICKUPS];

/*
* Maximum Val
*/
new maxhouses = 1;