/*
* Private Veh Data
*/
enum pvInfo
{
    pvID,
    pvModel,
    pvIsOwned,
    pvOwner[40],
    Float: pvX,
    Float: pvY,
    Float: pvZ,
    Float: pvAngle,
    pvVirtualWorld,
    pvColor1,
    pvColor2,
    pvRespawnTime,
    pvObject[15],
    Text3D: pv3DText
}
new PrivateVeh[MAX_PRIVATEVEHS+1][pvInfo];
new VehicleToPrivateSlot[MAX_VEHICLES];
