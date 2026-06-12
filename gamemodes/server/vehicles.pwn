#include <YSI_Coding\y_hooks>

/*
* Add All Vehicles
*/
hook OnGameModeInit()
{
    AddStaticVehicle(411, 253.5484, 1421.1823, 10.2937, 270.3137, 1, 1); // 1
    AddStaticVehicle(411, 252.2402, 1395.5558, 10.3130, 270.6192, 0, 0); // 2
    AddStaticVehicle(411, 251.1108, 1371.1488, 10.3136, 267.5901, 79, 79); // infernussin
    //IFC cars - location - close
    //порти - location - close
    mechanicDutyVehs[0] = AddStaticVehicle(525, 1013.5110, -1008.8167, 31.9396, 182.8166, 2, 2); // tow1
    mechanicDutyVehs[1] = AddStaticVehicle(525, 1013.4527, -1016.3772, 31.9344, 179.2090, 3, 3); // tow2
    mechanicDutyVehs[2] = AddStaticVehicle(525, 1013.4238, -1024.0668, 31.9341, 179.0988, 86, 86); // tow3
    mechanicDutyVehs[3] = AddStaticVehicle(525, 1649.4435, 2195.0776, 10.6423, 179.4986, 2, 2); // car1
    mechanicDutyVehs[4] = AddStaticVehicle(525, 1643.7000, 2194.9663, 10.6532, 179.4869, 3, 3); // car2
    mechanicDutyVehs[5] = AddStaticVehicle(525, 1638.0636, 2194.9373, 10.6503, 179.9552, 5, 5); // car3
    mechanicDutyVehs[6] = AddStaticVehicle(525, 1632.8521, 2194.8706, 10.6565, 186.1603, 6, 6); // car4
    mechanicDutyVehs[7] = AddStaticVehicle(525, 1626.6609, 2194.7981, 10.6556, 178.8269, 86, 86); // car5
    //carshop - location - open
    carshopcars2[0] = AddStaticVehicle(411, -1420.4337, 1100.1154, 1039.9402, 104.6863, 201, 201);
    carshopobjects[0] = CreateObject(18646, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars2[0], -0.43060, -0.07840, 0.75010, 0.00000, 0.00000, 0.00000);
    LinkVehicleToInterior(carshopcars2[0], 15);
    carshopcars2[1] = AddStaticVehicle(560, -1412.7379, 1101.3435, 1039.9102, 95.3560, 198, 198);
    carshopobjects[0] = CreateObject(359, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[1] = CreateObject(362, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[2] = CreateObject(362, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars2[1], -0.04339, -0.14813, 0.80910, 0.00000, 0.00000, 89.00000);
    AttachObjectToVehicle(carshopobjects[1], carshopcars2[1], -0.69998, 0.24154, 0.69210, 87.00000, 32.00000, 93.00000);
    AttachObjectToVehicle(carshopobjects[2], carshopcars2[1], 0.77690, 0.33100, 0.69210, -91.00000, 32.00000, 93.00000);
    LinkVehicleToInterior(carshopcars2[1], 15);
    carshopcars2[2] = AddStaticVehicle(470, -1403.6010, 1102.5607, 1040.1947, 95.9597, 0, 0);
    carshopobjects[0] = CreateObject(3267, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars2[2], -0.05540, -0.84780, 0.59140, 0.00000, 0.00000, 0.00000);
    LinkVehicleToInterior(carshopcars2[2], 15);
    carshopcars2[3] = AddStaticVehicle(578, -1390.5123, 1102.8654, 1040.8193, 82.5598, 160, 0);
    carshopobjects[0] = CreateObject(2669, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars2[3], 0.00780, -0.31770, 0.94820, 0.00000, 0.00000, 0.00000);
    LinkVehicleToInterior(carshopcars2[3], 15);
    carshopcars2[4] = AddStaticVehicle(451, -1378.7549, 1100.9178, 1039.8777, 80.6452, 3, 3);
    LinkVehicleToInterior(carshopcars2[4], 15);
    carshopcars2[5] = AddStaticVehicle(409, -1365.6467, 1097.3064, 1039.9639, 69.2179, 0, 0);
    carshopobjects[0] = CreateObject(19314, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars2[5], 0.00160, 3.57950, 0.21160, 120.00000, 90.00000, 0.00000);
    LinkVehicleToInterior(carshopcars2[5], 15);
    carshopcars2[6] = AddStaticVehicle(411, -1440.3612, 1092.9755, 1039.9569, 117.9431, 0, 0);
    LinkVehicleToInterior(carshopcars2[6], 15);
    carshopobjects[0] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[1] = CreateObject(1161, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[2] = CreateObject(1161, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[3] = CreateObject(1059, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[4] = CreateObject(1146, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[5] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[6] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[7] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[8] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[9] = CreateObject(1027, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[10] = CreateObject(1027, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars2[6], -0.300000, 0.000000, 0.675000, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[1], carshopcars2[6], 1.049999, 2.174999, -0.599999, 0.000005, 180.899887, 180.899963);
    AttachObjectToVehicle(carshopobjects[2], carshopcars2[6], -1.049999, -1.950001, -0.599999, 0.000005, 180.899887, 361.799743);
    AttachObjectToVehicle(carshopobjects[3], carshopcars2[6], 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[4], carshopcars2[6], -0.074999, -2.325000, 0.375000, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[5], carshopcars2[6], 0.225000, 0.000000, 0.674999, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[6], carshopcars2[6], 0.000000, 1.800000, 0.149999, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[7], carshopcars2[6], 0.000000, 1.650000, 0.150000, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[8], carshopcars2[6], 0.000000, 1.950000, 0.150000, -10.800001, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[9], carshopcars2[6], -1.049999, -0.824999, -0.599999, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[10], carshopcars2[6], 0.974999, -0.824999, -0.599999, 0.000000, 0.000000, 0.000000);
    carshopcars2[7] = AddStaticVehicle(415, -1428.3811, 1098.0699, 1039.9996, 103.7194, 74, 74);
    carshopobjects[0] = CreateObject(18646, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopcars2[7], carshopobjects[0], 0.30450, 0.46970, 0.26350, 0.00000, 0.00000, 0.00000);
    LinkVehicleToInterior(carshopcars2[7], 15);
    AttachObjectToVehicle(carshopcars2[8], carshopobjects[0], 0.00160, 3.57950, 0.21160, 120.00000, 90.00000, 0.00000);
    LinkVehicleToInterior(carshopcars2[8], 15);
    SetVehicleVirtualWorld(carshopcars2[0], 1);
    SetVehicleVirtualWorld(carshopcars2[1], 1);
    SetVehicleVirtualWorld(carshopcars2[2], 1);
    SetVehicleVirtualWorld(carshopcars2[3], 1);
    SetVehicleVirtualWorld(carshopcars2[4], 1);
    SetVehicleVirtualWorld(carshopcars2[5], 1);
    SetVehicleVirtualWorld(carshopcars2[6], 1);
    SetVehicleVirtualWorld(carshopcars2[7], 1);
    SetVehicleVirtualWorld(carshopcars2[8], 1);
    carshopcars[0] = AddStaticVehicle(411, -1420.4337, 1100.1154, 1039.9402, 104.6863, 201, 201);
    carshopobjects[0] = CreateObject(18646, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars[0], -0.43060, -0.07840, 0.75010, 0.00000, 0.00000, 0.00000);
    LinkVehicleToInterior(carshopcars[0], 15);
    carshopcars[1] = AddStaticVehicle(560, -1412.7379, 1101.3435, 1039.9102, 95.3560, 198, 198);
    carshopobjects[0] = CreateObject(359, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[1] = CreateObject(362, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[2] = CreateObject(362, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars[1], -0.04339, -0.14813, 0.80910, 0.00000, 0.00000, 89.00000);
    AttachObjectToVehicle(carshopobjects[1], carshopcars[1], -0.69998, 0.24154, 0.69210, 87.00000, 32.00000, 93.00000);
    AttachObjectToVehicle(carshopobjects[2], carshopcars[1], 0.77690, 0.33100, 0.69210, -91.00000, 32.00000, 93.00000);
    LinkVehicleToInterior(carshopcars[1], 15);
    carshopcars[2] = AddStaticVehicle(470, -1403.6010, 1102.5607, 1040.1947, 95.9597, 0, 0);
    carshopobjects[0] = CreateObject(3267, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars[2], -0.05540, -0.84780, 0.59140, 0.00000, 0.00000, 0.00000);
    LinkVehicleToInterior(carshopcars[2], 15);
    carshopcars[3] = AddStaticVehicle(578, -1390.5123, 1102.8654, 1040.8193, 82.5598, 160, 0);
    carshopobjects[0] = CreateObject(2669, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars[3], 0.00780, -0.31770, 0.94820, 0.00000, 0.00000, 0.00000);
    LinkVehicleToInterior(carshopcars[3], 15);
    carshopcars[4] = AddStaticVehicle(451, -1378.7549, 1100.9178, 1039.8777, 80.6452, 3, 3);
    LinkVehicleToInterior(carshopcars[4], 15);
    carshopcars[5] = AddStaticVehicle(409, -1365.6467, 1097.3064, 1039.9639, 69.2179, 0, 0);
    carshopobjects[0] = CreateObject(19314, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars[5], 0.00160, 3.57950, 0.21160, 120.00000, 90.00000, 0.00000);
    LinkVehicleToInterior(carshopcars[5], 15);
    carshopcars[6] = AddStaticVehicle(411, -1440.3612, 1092.9755, 1039.9569, 117.9431, 0, 0);
    LinkVehicleToInterior(carshopcars[6], 15);
    carshopobjects[0] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[1] = CreateObject(1161, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[2] = CreateObject(1161, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[3] = CreateObject(1059, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[4] = CreateObject(1146, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[5] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[6] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[7] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[8] = CreateObject(1006, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[9] = CreateObject(1027, 0, 0, -1000, 0, 0, 0, 100);
    carshopobjects[10] = CreateObject(1027, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopobjects[0], carshopcars[6], -0.300000, 0.000000, 0.675000, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[1], carshopcars[6], 1.049999, 2.174999, -0.599999, 0.000005, 180.899887, 180.899963);
    AttachObjectToVehicle(carshopobjects[2], carshopcars[6], -1.049999, -1.950001, -0.599999, 0.000005, 180.899887, 361.799743);
    AttachObjectToVehicle(carshopobjects[3], carshopcars[6], 0.000000, 0.000000, 0.000000, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[4], carshopcars[6], -0.074999, -2.325000, 0.375000, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[5], carshopcars[6], 0.225000, 0.000000, 0.674999, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[6], carshopcars[6], 0.000000, 1.800000, 0.149999, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[7], carshopcars[6], 0.000000, 1.650000, 0.150000, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[8], carshopcars[6], 0.000000, 1.950000, 0.150000, -10.800001, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[9], carshopcars[6], -1.049999, -0.824999, -0.599999, 0.000000, 0.000000, 0.000000);
    AttachObjectToVehicle(carshopobjects[10], carshopcars[6], 0.974999, -0.824999, -0.599999, 0.000000, 0.000000, 0.000000);
    carshopcars[7] = AddStaticVehicle(415, -1428.3811, 1098.0699, 1039.9996, 103.7194, 74, 74);
    carshopobjects[0] = CreateObject(18646, 0, 0, -1000, 0, 0, 0, 100);
    AttachObjectToVehicle(carshopcars[7], carshopobjects[0], 0.30450, 0.46970, 0.26350, 0.00000, 0.00000, 0.00000);
    LinkVehicleToInterior(carshopcars[7], 15);
    AttachObjectToVehicle(carshopcars[8], carshopobjects[0], 0.00160, 3.57950, 0.21160, 120.00000, 90.00000, 0.00000);
    LinkVehicleToInterior(carshopcars[8], 15);

    for (new id = 0; id<9; id++)
    {
        vehInShop[carshopcars2[id]] = true;
        vehInShop[carshopcars[id]] = true;
    }
    

    fishBoat1[0] = AddStaticVehicle(453, -1364.9620, 2105.0552, 40.2413, 312.2090, 1, 1); // lodka1
    fishBoat1[1] = AddStaticVehicle(453, -1361.4890, 2100.8291, 40.2132, 307.5796, 1, 1); // lodka2
    fishBoat1[2] = AddStaticVehicle(453, -1357.1643, 2096.5186, 40.2492, 314.6524, 1, 1); // lodka3
    fishBoat1[3] = AddStaticVehicle(453, -1379.9890, 2136.7983, 40.2849, 248.7483, 1, 1); // lodka4
    fishBoat1[4] = AddStaticVehicle(453, -1383.1028, 2130.6077, 40.2275, 242.2711, 1, 1); // lodka5
    fishBoat1[5] = AddStaticVehicle(453, -1358.2734, 2134.8970, 40.3629, 178.7726, 1, 1); // lodka6
    fishBoat2[0] = AddStaticVehicle(453, -1364.9620, 2105.0552, 40.2413, 312.2090, 1, 1); // lodka1
    fishBoat2[1] = AddStaticVehicle(453, -1361.4890, 2100.8291, 40.2132, 307.5796, 1, 1); // lodka2
    fishBoat2[2] = AddStaticVehicle(453, -1357.1643, 2096.5186, 40.2492, 314.6524, 1, 1); // lodka3
    fishBoat2[3] = AddStaticVehicle(453, -1379.9890, 2136.7983, 40.2849, 248.7483, 1, 1); // lodka4
    fishBoat2[4] = AddStaticVehicle(453, -1383.1028, 2130.6077, 40.2275, 242.2711, 1, 1); // lodka5
    fishBoat2[5] = AddStaticVehicle(453, -1358.2734, 2134.8970, 40.3629, 178.7726, 1, 1); // lodka6
    for (new i = 0; i < 6; i++)
    {
        SetVehicleVirtualWorld(fishBoat2[i], 1);
    }

    derbytypecar1[1] = AddStaticVehicle(559, -1967.6910, 3117.8047, 116.5250, 90.0189, 0, 0);
    derbytypecar1[2] = AddStaticVehicle(535, -2005.9907, 3077.5483, 116.6330, 269.8782, 21, 21);
    derbytypecar1[3] = AddStaticVehicle(600, -2007.1895, 3238.7617, 116.5942, 179.1579, 3, 3);
    derbytypecar1[4] = AddStaticVehicle(541, -1928.7631, 3279.7585, 116.5137, 180.3685, 52, 53);
    derbytypecar1[5] = AddStaticVehicle(415, -1896.2786, 3279.8789, 116.6600, 180.0912, 84, 84);
    derbytypecar1[6] = AddStaticVehicle(579, -1895.7048, 3153.5156, 101.4379, 89.1011, 22, 22);
    derbytypecar1[7] = AddStaticVehicle(412, -1935.4741, 3215.1226, 102.9278, 179.8446, 86, 86);
    derbytypecar1[8] = AddStaticVehicle(479, -2015.8408, 3184.5261, 102.8833, 270.5159, 2, 2);
    derbytypecar1[9] = AddStaticVehicle(560, -2015.9592, 3153.8970, 102.7897, 270.5407, 6, 6);
    derbytypecar1[10] = AddStaticVehicle(411, -2015.5110, 3122.3530, 102.8158, 270.1569, 1, 1);
    AddVehicleComponent(derbytypecar1[1], 1010);
    AddVehicleComponent(derbytypecar1[2], 1010);
    AddVehicleComponent(derbytypecar1[3], 1010);
    AddVehicleComponent(derbytypecar1[4], 1010);
    AddVehicleComponent(derbytypecar1[5], 1010);
    AddVehicleComponent(derbytypecar1[6], 1010);
    AddVehicleComponent(derbytypecar1[7], 1010);
    AddVehicleComponent(derbytypecar1[8], 1010);
    AddVehicleComponent(derbytypecar1[9], 1010);
    AddVehicleComponent(derbytypecar1[10], 1010);
    SetVehicleVirtualWorld(derbytypecar1[1], 4);
    SetVehicleVirtualWorld(derbytypecar1[2], 4);
    SetVehicleVirtualWorld(derbytypecar1[3], 4);
    SetVehicleVirtualWorld(derbytypecar1[4], 4);
    SetVehicleVirtualWorld(derbytypecar1[5], 4);
    SetVehicleVirtualWorld(derbytypecar1[6], 4);
    SetVehicleVirtualWorld(derbytypecar1[7], 4);
    SetVehicleVirtualWorld(derbytypecar1[8], 4);
    SetVehicleVirtualWorld(derbytypecar1[9], 4);
    SetVehicleVirtualWorld(derbytypecar1[10], 4);

    carpilot[1] = AddStaticVehicle(511, 382.7576, 2536.0332, 17.9922, 176.6510, 3, 3); // pilot1
    carpilot[2] = AddStaticVehicle(511, 359.8245, 2536.8083, 18.0109, 177.6166, 3, 3); // pilot2
    carpilot[3] = AddStaticVehicle(511, 268.3786, 2535.4526, 18.0536, 180.3932, 3, 3); // pilot3
    carpilot[4] = AddStaticVehicle(511, 243.3229, 2535.4875, 18.0442, 179.8697, 3, 3); // pilot4
    carpilot[5] = AddStaticVehicle(511, 363.8391, 2470.6494, 17.8039, 359.7092, 3, 3); // pilot5
    carsweeper[1] = AddStaticVehicle(574, 570.7686, 1217.6624, 11.5150, 212.5410, 1, 1); // sweepcar
    carsweeper[2] = AddStaticVehicle(574, 572.4439, 1218.8262, 11.4516, 211.8157, 1, 1); // sweepcar2
    carsweeper[3] = AddStaticVehicle(574, 577.4621, 1220.9525, 11.4364, 212.9591, 1, 1); // sweepcar3
    carsweeper[4] = AddStaticVehicle(574, 578.9632, 1221.9869, 11.4364, 212.8099, 1, 1); // sweepcar4
    carcoalmine[1] = AddStaticVehicleEx(406, 858.2269, 879.6721, 14.7627, 201.0449, 1, 1, 5); //
    carcoalmine[2] = AddStaticVehicleEx(406, 850.8806, 876.3572, 14.9247, 202.1210, 1, 1, 5); //
    carcoalmine[3] = AddStaticVehicleEx(406, 843.9622, 873.7372, 14.7720, 202.0721, 1, 1, 5); //
    carcoalmine[4] = AddStaticVehicleEx(406, 837.6867, 870.4841, 14.7916, 201.2635, 1, 1, 5); //
    afterwork[0] = CreateVehicle(411, 832.4344, 837.6809, 11.5070, 20.8823, 0, 0, 900); // veh1
    afterwork[1] = CreateVehicle(411, 835.9622, 838.5618, 11.8255, 21.4923, 1, 1, 900); // veh
    afterwork[2] = CreateVehicle(411, 839.2482, 839.3900, 12.1361, 19.7798, 7, 7, 900); // veh
    afterwork[3] = CreateVehicle(522, 841.9667, 840.9456, 12.2186, 22.4552, 0, 0, 900); // veh
    afterwork[4] = CreateVehicle(522, 843.3854, 841.7632, 12.3236, 26.6766, 1, 1, 900); // veh
    afterwork[5] = CreateVehicle(522, 845.2407, 842.2749, 12.5161, 14.0011, 7, 7, 900); // veh
    afterwork[6] = CreateVehicle(411, 615.0783, 1227.1151, 11.4458, 118.5010, 0, 0, 900); // veh
    afterwork[7] = CreateVehicle(411, 613.5852, 1230.2531, 11.4458, 118.3363, 1, 1, 900); // veh
    afterwork[8] = CreateVehicle(411, 611.6678, 1232.9268, 11.4458, 118.2612, 7, 7, 900); // veh
    afterwork[9] = CreateVehicle(522, 609.0194, 1236.0812, 11.2933, 115.5268, 0, 0, 900); // veh
    afterwork[10] = CreateVehicle(522, 608.2195, 1237.7094, 11.2850, 108.2882, 1, 1, 900); // veh
    afterwork[11] = CreateVehicle(522, 608.1815, 1238.8450, 11.2928, 115.8031, 7, 7, 900); // veh
    afterwork[12] = CreateVehicle(411, 425.6216, 2529.6577, 16.3437, 184.5891, 0, 0, 900); // veh
    afterwork[13] = CreateVehicle(411, 422.0308, 2528.8699, 16.3254, 185.0556, 1, 1, 900); // veh
    afterwork[14] = CreateVehicle(411, 418.9781, 2528.9233, 16.3172, 179.7733, 7, 7, 900); // veh
    afterwork[15] = CreateVehicle(522, 415.1333, 2528.9492, 16.1791, 175.1624, 0, 0, 900); // veh
    afterwork[16] = CreateVehicle(522, 414.0790, 2528.9260, 16.1763, 166.9628, 1, 1, 900); // veh
    afterwork[17] = CreateVehicle(522, 412.5888, 2528.7742, 16.1676, 171.5464, 7, 7, 900); // veh
    afterwork[18] = CreateVehicle(411, 47.3786, -253.7540, 1.3749, 265.0179, 0, 0, 900); // veh
    afterwork[19] = CreateVehicle(411, 46.9400, -256.5018, 1.4171, 270.1889, 1, 1, 900); // veh
    afterwork[20] = CreateVehicle(411, 47.0149, -259.3380, 1.4477, 268.6745, 7, 7, 900); // veh
    afterwork[21] = CreateVehicle(522, 46.4583, -262.1669, 1.3404, 262.7072, 0, 0, 900); // veh
    afterwork[22] = CreateVehicle(522, 46.8016, -263.2418, 1.3455, 263.0025, 1, 1, 900); // veh
    afterwork[23] = CreateVehicle(522, 46.7809, -264.1643, 1.3557, 262.4278, 7, 7, 900); // veh
    afterwork[24] = CreateVehicle(411, 1378.1586, 269.0237, 19.2940, 338.4818, 0, 0, 900); // veh
    afterwork[25] = CreateVehicle(411, 1381.5187, 267.4872, 19.2940, 337.8664, 1, 1, 900); // veh
    afterwork[26] = CreateVehicle(411, 1384.6252, 266.0334, 19.2940, 334.1597, 7, 7, 900); // veh
    afterwork[27] = CreateVehicle(522, 1387.2539, 263.5329, 19.1194, 337.2061, 0, 0, 900); // veh
    afterwork[28] = CreateVehicle(522, 1387.9193, 263.0052, 19.1409, 336.3415, 1, 1, 900); // veh
    afterwork[29] = CreateVehicle(522, 1388.9036, 262.2971, 19.1392, 335.0469, 7, 7, 900); // veh
    afterwork[30] = CreateVehicle(411, -539.4708, 2565.8433, 53.1425, 268.6549, 0, 0, 900); // veh
    afterwork[31] = CreateVehicle(411, -539.5480, 2563.2871, 53.1418, 268.1252, 1, 1, 900); // veh
    afterwork[32] = CreateVehicle(411, -539.3613, 2560.2180, 53.1418, 268.8858, 7, 7, 900); // veh
    afterwork[33] = CreateVehicle(522, -540.8374, 2556.6814, 52.9886, 269.0560, 0, 0, 900); // veh
    afterwork[34] = CreateVehicle(522, -540.7065, 2555.1716, 52.9886, 263.3294, 1, 1, 900); // veh
    afterwork[35] = CreateVehicle(522, -540.2985, 2553.9404, 52.9845, 260.8280, 7, 7, 900); // veh
    afterwork[36] = CreateVehicle(411, 0.4873, -333.9484, 5.1568, 93.2239, 0, 0, 900); // veh
    afterwork[37] = CreateVehicle(411, 0.5126, -336.6106, 5.1568, 88.4291, 1, 1, 900); // veh
    afterwork[38] = CreateVehicle(411, -0.2487, -339.4753, 5.1568, 86.2355, 7, 7, 900); // veh
    afterwork[39] = CreateVehicle(522, -1.0375, -343.6505, 5.0041, 89.6106, 0, 0, 900); // veh
    afterwork[40] = CreateVehicle(522, -1.4598, -344.5724, 5.0028, 92.8479, 1, 1, 900); // veh
    afterwork[41] = CreateVehicle(522, -2.0090, -346.2775, 5.0055, 85.8586, 7, 7, 900); // veh
    for (new i = 0; i < 42; i++)
    {
        VehicleToggleEngine(afterwork[i], VEHICLE_PARAMS_OFF);
    }
    fuelremarke[0] = AddStaticVehicle(584, 271.4840, 1341.2374, 11.7400, 0.5160, 0, 0); // remarke1
    fuelremarke[1] = AddStaticVehicle(584, 263.8116, 1340.9697, 11.7545, 0.3961, 0, 0); // remarke2
    fuelremarke[2] = AddStaticVehicle(584, 280.3829, 1341.1115, 11.7410, 1.0650, 0, 0); // remarke3
    fueltruck[0] = AddStaticVehicle(403, 284.3264, 1360.4240, 11.1927, 88.2289, 0, 0); // veh1
    //ToggleEngine(fueltruck[0], VEHICLE_PARAMS_OFF);
    fueltruck[1] = AddStaticVehicle(403, 284.4374, 1371.9625, 11.1927, 90.2667, 8, 8); // veh2
    //ToggleEngine(fueltruck[1], VEHICLE_PARAMS_OFF);
    fueltruck[2] = AddStaticVehicle(403, 284.4071, 1365.9193, 11.1926, 89.6312, 9, 9); // veh3
    //ToggleEngine(fueltruck[2], VEHICLE_PARAMS_OFF);
    carbus[1] = AddStaticVehicle(431, -521.3267, 2569.4219, 53.5132, 358.5933, 1, 1); // bus
    carbus[2] = AddStaticVehicle(431, -512.0872, 2553.7710, 53.5170, 88.0071, 1, 1); // bus
    carbus[3] = AddStaticVehicle(431, -513.0065, 2548.9106, 53.5151, 88.9376, 1, 1); // bus
    carbus[4] = AddStaticVehicle(431, -510.6169, 2579.8213, 53.5219, 87.5477, 1, 1); // bus
    carbus[5] = AddStaticVehicle(431, -511.0210, 2582.8525, 53.5136, 86.0736, 1, 1); // bus
    carpizza[1] = AddStaticVehicle(448, 1356.7051, 243.4740, 19.1688, 65.4089, 3, 6); // piza
    carpizza[2] = AddStaticVehicle(448, 1355.9683, 241.1347, 19.1421, 62.2654, 3, 6); // piza2
    carpizza[3] = AddStaticVehicle(448, 1356.5350, 242.4410, 19.1596, 63.2474, 3, 6); // piza3
    carpizza[4] = AddStaticVehicle(448, 1363.1876, 259.8902, 19.1605, 69.1960, 3, 6); // piza4
    carpizza[5] = AddStaticVehicle(448, 1364.0146, 260.9592, 19.1494, 63.5487, 3, 6); // piza5
    carpizza[6] = AddStaticVehicle(448, 1364.0315, 262.2966, 19.1587, 61.9309, 3, 6); // piza6
    cartruck[1] = AddStaticVehicle(515, 65.7177, -285.2350, 2.6372, 1.4777, 0, 0); // Job - Truck Car 1
    cartruck[2] = AddStaticVehicle(514, 53.2033, -285.1273, 2.3195, 358.3466, 3, 3); // Job - Truck Car 2
    cartruck[3] = AddStaticVehicle(403, 35.6616, -266.8764, 2.7455, 266.1551, 24, 24); // Job - Truck Car 3
    cartruck[4] = AddStaticVehicle(515, 43.0861, -231.5357, 2.6533, 266.6200, 3, 3); // Job - Truck Car 4
    cartruck[5] = AddStaticVehicle(514, 44.8290, -224.5736, 2.2295, 268.1153, 0, 0); // Job - Truck Car 5
    carboat[1] = AddStaticVehicle(493,2096.9822,-97.8148,-0.1926,108.7129,23,23); // boat1
    carboat[2] = AddStaticVehicle(493,2105.5818,-109.0842,-0.1664,125.1686,23,23); // boat2
    cardeliver[1] = AddStaticVehicle(609, -31.8258, -290.1678, 5.4251, 269.3731, 86, 86); // Deliver - Car1
    cardeliver[2] = AddStaticVehicle(609, -23.2258, -273.9886, 5.4273, 179.0741, 86, 86); // Deliver - Car2
    cardeliver[3] = AddStaticVehicle(609, 0.3479, -301.1396, 5.4233, 89.4623, 86, 86); // Deliver - Car3
    cardeliver[4] = AddStaticVehicle(609, 0.0413, -311.8060, 5.4393, 89.6039, 86, 86); // Deliver - Car4
    cardeliver[5] = AddStaticVehicle(609, -0.0081, -322.3448, 5.4393, 89.5987, 86, 86); // Deliver - Car5
    vipVehs[1] = CreateVehicle(579, 1140.7024, -2030.0927, 68.9443, 271.9881, 181, 181, 900); // vipcar1
    vipVehs[2] = CreateVehicle(409, 1243.9410, -2021.2043, 59.7309, 177.9704, 181, 181, 900); // vipcar2
    vipVehs[3] = CreateVehicle(409, 1243.9419, -2037.4746, 59.7307, 181.8856, 181, 181, 900); // vipcar3
    vipVehs[4] = CreateVehicle(468, 1274.2704, -2048.9709, 58.9283, 178.9933, 181, 181, 900); // vipcar4
    vipVehs[5] = CreateVehicle(468, 1276.4502, -2048.5881, 58.8944, 193.5808, 181, 181, 900); // vipcar5
    vipVehs[6] = CreateVehicle(468, 1279.2736, -2048.9507, 58.8003, 190.0562, 181, 181, 900); // vipcar6
    vipVehs[7] = CreateVehicle(560, 1277.1289, -2042.6338, 58.7295, 92.2990, 181, 181, 900); // vipcar7
    vipVehs[8] = CreateVehicle(560, 1277.3984, -2031.0327, 58.6496, 83.0665, 181, 181, 900); // vipcar8
    vipVehs[9] = CreateVehicle(560, 1277.5686, -2024.5355, 58.6122, 80.3641, 181, 181, 900); // vipcar9
    vipVehs[10] = CreateVehicle(411, 1277.0298, -2010.4761, 58.6602, 183.4705, 181, 181, 900); // vipcar10
    vipVehs[11] = CreateVehicle(411, 1270.0671, -2010.0409, 58.8562, 177.6457, 181, 181, 900); // vipcar11
    vipVehs[12] = CreateVehicle(411, 1244.2449, -2009.8389, 59.6042, 181.7225, 181, 181, 900); // vipcar12
    vipVehs[13] = CreateVehicle(522, 1237.1691, -2007.3179, 59.4209, 261.3344, 181, 181, 900); // vipcar13
    vipVehs[14] = CreateVehicle(522, 1237.4316, -2030.3452, 60.5957, 269.5838, 181, 181, 900); // vipcar14
    vipVehs[15] = CreateVehicle(522, 1237.6796, -2042.7904, 60.5584, 271.8774, 181, 181, 900); // vipcar15
    vipVehs[16] = CreateVehicle(522, 1175.1260, -2041.3722, 68.5540, 185.4893, 181, 181, 900); // vipcar16
    vipVehs[17] = CreateVehicle(522, 1175.0313, -2032.8108, 68.5775, 0.9233, 181, 181, 900); // vipcar17
    vipVehs[18] = CreateVehicle(579, 1140.4346, -2041.7124, 69.0015, 270.5126, 181, 181, 900); // vipcar18
    vipVehs[19] = CreateVehicle(562, 1138.6312, -2063.9949, 68.6584, 2.5424, 181, 181, 900);
    vipVehs[20] = CreateVehicle(559, 1138.4088, -2010.0665, 68.6807, 181.0400, 181, 181, 900);
    vipVehs[21] = CreateVehicle(513, 1264.4708, -2009.5179, 59.8866, 178.2558, 181, 0, 900);
    vipVehs[22] = CreateVehicle(513, 1252.4545, -2009.0323, 60.2322, 175.9293, 181, 0, 900);

    vipVehs[23] = CreateVehicle(565, 1369.3691, -2036.2728, 55.7907, 97.9695, 1, 1, 900);
    vipVehs[24] = CreateVehicle(560, 1368.1836, -2029.9252, 55.7226, 97.3020, 1, 1, 900);
    vipVehs[25] = CreateVehicle(576, 1366.6332, -2023.7151, 55.6430, 97.4405, 1, 1, 900);
    vipVehs[26] = CreateVehicle(535, 1366.3467, -2017.2739, 55.6911, 97.4858, 1, 1, 900);
    vipVehs[27] = CreateVehicle(534, 1365.0499, -2011.0005, 55.5734, 97.9078, 1, 1, 900);
    vipVehs[28] = CreateVehicle(575, 1364.4288, -2004.6128, 55.3218, 97.9375, 1, 1, 900);
    vipVehs[29] = CreateVehicle(561, 1363.7311, -1998.1807, 55.4385, 97.5317, 1, 1, 900);
    vipVehs[30] = CreateVehicle(603, 1338.6970, -2036.9438, 56.4600, 277.2449, 0, 0, 900);
    vipVehs[31] = CreateVehicle(567, 1338.1980, -2030.4966, 56.3650, 277.1607, 1, 1, 900);
    vipVehs[32] = CreateVehicle(567, 1337.4781, -2024.1407, 56.2766, 277.3607, 1, 1, 900);
    vipVehs[33] = CreateVehicle(483, 1336.2733, -2017.8456, 56.2976, 277.1776, 1, 1, 900);
    vipVehs[34] = CreateVehicle(562, 1334.8486, -2011.5480, 55.8763, 277.7780, 1, 1, 900);
    vipVehs[35] = CreateVehicle(558, 1334.3204, -2005.1951, 55.7860, 277.7154, 1, 1, 900);
    vipVehs[36] = CreateVehicle(415, 1333.3846, -1998.8451, 55.8204, 277.9221, 1, 1, 900);
    vipVehs[37] = CreateVehicle(480, 1332.7406, -1992.5273, 55.7602, 278.0070, 1, 3, 900);
    vipVehs[38] = CreateVehicle(562, 1168.7881, -2063.9421, 68.6574, 358.6059, 181, 181, 900);
    vipVehs[39] = CreateVehicle(559, 1168.9164, -2009.8586, 68.6512, 179.3755, 181, 181, 900);
    vipVehs[40] = CreateVehicle(510, 1237.1449, -2041.1643, 60.6230, 266.7683, 181, 181, 900);
    vipVehs[41] = CreateVehicle(510, 1237.3176, -2032.4642, 60.6253, 270.9919, 181, 181, 900);

    ChangeVehiclePaintjob(vipVehs[23], 1);
    ChangeVehiclePaintjob(vipVehs[24], 1);
    ChangeVehiclePaintjob(vipVehs[25], 0);
    ChangeVehiclePaintjob(vipVehs[26], 2);
    ChangeVehiclePaintjob(vipVehs[27], 1);
    ChangeVehiclePaintjob(vipVehs[28], 0);
    ChangeVehiclePaintjob(vipVehs[29], 1);
    ChangeVehiclePaintjob(vipVehs[31], 1);
    ChangeVehiclePaintjob(vipVehs[32], 2);
    ChangeVehiclePaintjob(vipVehs[33], 0);
    ChangeVehiclePaintjob(vipVehs[34], 1);
    ChangeVehiclePaintjob(vipVehs[35], 1);
    AddVehicleComponent(vipVehs[23], 1035);
    AddVehicleComponent(vipVehs[24], 1035);
    AddVehicleComponent(vipVehs[25], 1035);
    AddVehicleComponent(vipVehs[26], 1035);
    AddVehicleComponent(vipVehs[27], 1035);
    AddVehicleComponent(vipVehs[28], 1035);
    AddVehicleComponent(vipVehs[29], 1035);
    AddVehicleComponent(vipVehs[31], 1035);
    AddVehicleComponent(vipVehs[32], 1035);
    AddVehicleComponent(vipVehs[33], 1035);
    AddVehicleComponent(vipVehs[34], 1035);
    AddVehicleComponent(vipVehs[35], 1035);
    AddVehicleComponent(vipVehs[23], 1147);
    AddVehicleComponent(vipVehs[24], 1147);
    AddVehicleComponent(vipVehs[25], 1147);
    AddVehicleComponent(vipVehs[26], 1147);
    AddVehicleComponent(vipVehs[27], 1147);
    AddVehicleComponent(vipVehs[28], 1147);
    AddVehicleComponent(vipVehs[29], 1147);
    AddVehicleComponent(vipVehs[31], 1147);
    AddVehicleComponent(vipVehs[32], 1147);
    AddVehicleComponent(vipVehs[33], 1147);
    AddVehicleComponent(vipVehs[34], 1147);
    AddVehicleComponent(vipVehs[35], 1147);

    for (new i; i < sizeof(vipVehs); i++)
    {
        isVipGangVeh[vipVehs[i]] = true;
    }
    soldierVehs[1] = CreateVehicle(409, -1754.4410, 938.3846, 24.6129, 270.5095, 171, 171, 900); //Stretch
    soldierVehs[2] = CreateVehicle(560, -1777.6790, 957.8425, 24.5874, 269.9056, 171, 171, 900); //Sultan
    soldierVehs[3] = CreateVehicle(560, -1730.1558, 957.8041, 24.5873, 90.0371, 171, 171, 900); //Sultan
    soldierVehs[4] = CreateVehicle(411, -1764.1466, 947.2263, 24.5391, 269.7079, 171, 171, 900); //Infernus
    soldierVehs[5] = CreateVehicle(411, -1746.6165, 947.1942, 24.5377, 269.2019, 171, 171, 900); //Infernus
    soldierVehs[6] = CreateVehicle(579, -1730.8681, 945.4312, 24.7422, 178.1536, 171, 171, 900); //Huntley
    soldierVehs[7] = CreateVehicle(579, -1777.0849, 945.6668, 24.7440, 180.4462, 171, 171, 900); //Huntley
    soldierVehs[8] = CreateVehicle(487, -1724.0946, 955.3264, 25.0706, 179.4173, 171, 171, 900); //Maverick
    soldierVehs[9] = CreateVehicle(522, -1739.0638, 962.4121, 24.4531, 162.8123, 171, 171, 900); //NRG-500
    soldierVehs[10] = CreateVehicle(522, -1737.6507, 962.4368, 24.4540, 160.2843, 171, 171, 900); //NRG-500
    for (new i; i < sizeof(soldierVehs); i++)
    {
        isSoldierGangVeh[soldierVehs[i]] = true;
    }
    yakuzaVehs[1] = CreateVehicle(411, 2586.6418, 2780.4836, 10.5473, 89.7078, 251, 251, 900); //Infernus
    yakuzaVehs[2] = CreateVehicle(411, 2570.3603, 2791.9453, 10.5473, 180.6495, 251, 251, 900); //Infernus
    yakuzaVehs[3] = CreateVehicle(560, 2574.4729, 2768.8718, 10.5252, 359.9030, 251, 251, 900); //Sultan
    yakuzaVehs[4] = CreateVehicle(579, 2566.2109, 2769.1118, 10.7518, 359.2712, 251, 251, 900); //Huntley
    yakuzaVehs[5] = CreateVehicle(579, 2586.4331, 2772.6333, 10.7529, 89.5541, 251, 251, 900); //Huntley
    yakuzaVehs[6] = CreateVehicle(560, 2562.0100, 2792.0656, 10.5255, 179.2442, 251, 251, 900); //Sultan
    yakuzaVehs[7] = CreateVehicle(562, 2557.8300, 2768.9558, 10.4797, 359.6143, 251, 251, 900); //Elegy
    yakuzaVehs[8] = CreateVehicle(487, 2541.2998, 2769.2536, 11.1501, 359.7666, 251, 251, 900); //Maverick
    yakuzaVehs[9] = CreateVehicle(522, 2583.3645, 2794.2092, 10.3880, 128.7462, 251, 251, 900); //NRG-500
    yakuzaVehs[10] = CreateVehicle(522, 2585.6254, 2794.2553, 10.3881, 127.4658, 251, 251, 900); //NRG-500
    for (new i; i < sizeof(yakuzaVehs); i++)
    {
        isYakuzaGangVeh[yakuzaVehs[i]] = true;
    }
    syndicateVehs[1] = CreateVehicle(579, 1783.7011, 2821.2512, 10.7664, 343.0036, 79, 79, 900); //Huntley
    syndicateVehs[2] = CreateVehicle(579, 1749.5639, 2820.7910, 10.7672, 17.6556, 79, 79, 900); //Huntley
    syndicateVehs[3] = CreateVehicle(411, 1778.0570, 2801.7602, 10.5630, 344.4429, 79, 79, 900); //Infernus
    syndicateVehs[4] = CreateVehicle(560, 1755.2161, 2801.8525, 10.5383, 16.5927, 79, 79, 900); //Sultan
    syndicateVehs[5] = CreateVehicle(487, 1766.6214, 2767.2133, 10.9074, 0.0176, 79, 79, 900); //Maverick
    syndicateVehs[6] = CreateVehicle(451, 1766.5034, 2780.9904, 10.5423, 91.5007, 79, 79, 900); //Turismo
    syndicateVehs[7] = CreateVehicle(541, 1766.8874, 2853.9028, 10.4572, 271.1266, 79, 79, 900); //Bullet
    syndicateVehs[8] = CreateVehicle(522, 1779.9742, 2774.1992, 10.6723, 46.1928, 79, 79, 900); //NRG-500
    syndicateVehs[9] = CreateVehicle(522, 1779.6837, 2772.7128, 10.6914, 50.1116, 79, 79, 900); //NRG-500
    for (new i; i < sizeof(syndicateVehs); i++)
    {
        isSyndicateGangVeh[syndicateVehs[i]] = true;
    }
    bloodMafiaVehs[1] = CreateVehicle(487, 1131.1058, -1232.8121, 25.4786, 359.0727, 3, 3, 900); //Maverick
    bloodMafiaVehs[2] = CreateVehicle(560, 1092.8414, -1225.3471, 15.5251, 180.4128, 3, 3, 900); //Sultan
    bloodMafiaVehs[3] = CreateVehicle(578, 1116.0975, -1247.3536, 16.4970, 0.4791, 3, 3, 900); //DFT-30
    bloodMafiaVehs[4] = CreateVehicle(439, 1097.3837, -1225.5856, 15.7161, 181.0876, 3, 3, 900); //Stallion
    bloodMafiaVehs[5] = CreateVehicle(541, 1102.0024, -1225.0908, 15.4486, 180.2831, 3, 3, 900); //Bullet
    bloodMafiaVehs[6] = CreateVehicle(522, 1106.9692, -1224.3183, 15.3949, 183.6737, 3, 3, 900); //NRG-500
    bloodMafiaVehs[7] = CreateVehicle(522, 1105.3911, -1224.3166, 15.3949, 181.0514, 3, 3, 900); //NRG-500
    bloodMafiaVehs[8] = CreateVehicle(451, 1109.9226, -1225.4902, 15.5302, 179.8953, 3, 3, 900); //Turismo
    bloodMafiaVehs[9] = CreateVehicle(579, 1085.8339, -1250.1539, 15.7590, 269.1950, 3, 3, 900); //Huntley
    bloodMafiaVehs[10] = CreateVehicle(411, 1085.5162, -1241.4329, 15.5542, 269.3987, 3, 3, 900); //Infernus
    for (new i; i < sizeof(bloodMafiaVehs); i++)
    {
        isBloodMafiaGangVeh[bloodMafiaVehs[i]] = true;
    }
    ms13Vehs[1] = CreateVehicle(522, -43.7467, 1090.7900, 19.3100, 313.1989, 98, 98, 900); // mara car1
    ms13Vehs[2] = CreateVehicle(522, -41.3642, 1090.5417, 19.3100, 312.1312, 98, 98, 900); // mara car2
    ms13Vehs[3] = CreateVehicle(566, -25.8431, 1117.7206, 19.5322, 180.2623, 98, 98, 900); // mara car3
    ms13Vehs[4] = CreateVehicle(567, -9.1512, 1113.1694, 19.7791, 180.2317, 98, 98, 900); // mara car4
    ms13Vehs[5] = CreateVehicle(411, 4.9422, 1083.8176, 19.4745, 90.6888, 98, 98, 900); // mara car5
    ms13Vehs[6] = CreateVehicle(411, -2.7396, 1083.7994, 19.4710, 89.5072, 98, 98, 900); // mara car6
    ms13Vehs[7] = CreateVehicle(579, 0.4540, 1067.7860, 19.8970, 90.2868, 98, 98, 900); // mara car7
    ms13Vehs[8] = CreateVehicle(560, -30.3721, 1066.7074, 19.4498, 359.9763, 98, 98, 900); // mara car8
    ms13Vehs[9] = CreateVehicle(560, -30.3590, 1084.8069, 19.4481, 359.4691, 98, 98, 900); // mara car9
    ms13Vehs[10] = CreateVehicle(487, -43.7323, 1083.2986, 23.3676, 269.2445, 98, 98, 900); // mara car10
    for (new i; i < sizeof(ms13Vehs); i++)
    {
        isMS13GangVeh[ms13Vehs[i]] = true;
    }
    bgMafiaVehs[0] = CreateVehicle(487, 1291.2058, -789.7775, 96.6011, 179.8307, 0, 0, 900); // BGM Car 1
    bgMafiaVehs[1] = CreateVehicle(560, 1243.4724, -809.0154, 87.8661, 303.3171, 0, 0, 900); // BGM Car 2
    bgMafiaVehs[2] = CreateVehicle(560, 1235.8627, -811.3358, 87.5092, 275.4814, 0, 0, 900); // BGM Car 3
    bgMafiaVehs[3] = CreateVehicle(560, 1227.4371, -811.8135, 87.2921, 271.7863, 0, 0, 900); // BGM Car 4
    bgMafiaVehs[4] = CreateVehicle(579, 1225.8682, -803.0211, 88.5512, 271.9268, 0, 0, 900); // BGM Car 5
    bgMafiaVehs[5] = CreateVehicle(579, 1232.8867, -802.7137, 88.6010, 273.3310, 0, 0, 900); // BGM Car 6
    bgMafiaVehs[6] = CreateVehicle(562, 1213.3787, -830.7581, 84.7358, 52.4480, 0, 0, 900); // BGM Car 7
    bgMafiaVehs[7] = CreateVehicle(559, 1219.3944, -834.1917, 84.2755, 66.2540, 0, 0, 900); // BGM Car 8
    bgMafiaVehs[8] = CreateVehicle(411, 1242.9226, -803.3868, 83.8676, 178.9484, 0, 0, 900); // BGM Car 9
    bgMafiaVehs[9] = CreateVehicle(487, 1291.2115, -789.7786, 96.6327, 179.8968, 0, 0, 900); // BGM Car 10
    for (new i; i < sizeof(bgMafiaVehs); i++)
    {
        isBGMafiaGangVeh[bgMafiaVehs[i]] = true;
    }
    Gang343Vehs[0] = CreateVehicle(560, -813.5150, 1566.0947, 26.7411, 180.0169, 0, 30, -1); //Sultan
    Gang343Vehs[1] = CreateVehicle(567, -813.4089, 1555.0924, 26.9023, 359.1227, 0, 169, -1); //Savanna
    Gang343Vehs[2] = CreateVehicle(541, -820.8497, 1542.1290, 26.7335, 308.8533, 0, 0, -1); //Bullet
    Gang343Vehs[3] = CreateVehicle(451, -821.9215, 1577.9213, 26.7548, 228.5114, 0, 253, -1); //Turismo
    Gang343Vehs[4] = CreateVehicle(579, -793.9832, 1542.1098, 26.9094, 88.5361, 0, 118, -1); //Huntley
    Gang343Vehs[5] = CreateVehicle(411, -793.1918, 1572.3433, 26.7002, 91.5546, 0, 148, -1); //Infernus
    Gang343Vehs[6] = CreateVehicle(487, -822.4821, 1568.9770, 30.4314, 270.8357, 0, 0, -1); //Maverick
    Gang343Vehs[7] = CreateVehicle(487, -823.2189, 1555.6975, 30.8420, 270.8032, 0, 0, -1); //Maverick
    Gang343Vehs[8] = CreateVehicle(522, -794.7127, 1564.0701, 26.6853, 125.8678, 0, 0, -1); //NRG-500
    Gang343Vehs[9] = CreateVehicle(522, -795.6697, 1565.4379, 26.6849, 127.0733, 0, 0, -1); //NRG-500*
    for (new i; i < sizeof(Gang343Vehs); i++)
    {
        is343GangVeh[Gang343Vehs[i]] = true;
    }
    groveVehs[1] = CreateVehicle(522, 2482.3757, -1652.5487, 13.0282, 142.6509, 86, 86, 900);
    groveVehs[2] = CreateVehicle(566, 2498.3342, -1649.1823, 13.3081, 157.4072, 86, 86, 900);
    groveVehs[3] = CreateVehicle(492, 2515.5366, -1665.1935, 13.5741, 91.9201, 86, 86, 900);
    groveVehs[4] = CreateVehicle(429, 2516.7124, -1672.0027, 13.6131, 60.6237, 86, 0, 900);
    groveVehs[5] = CreateVehicle(411, 2509.9509, -1686.9349, 13.2954, 50.8308, 86, 86, 900);
    groveVehs[6] = CreateVehicle(567, 2488.0681, -1682.6639, 13.1949, 92.3377, 86, 86, 900);
    groveVehs[7] = CreateVehicle(560, 2473.2893, -1695.6903, 13.1662, 0.0001, 86, 86, 900);
    groveVehs[8] = CreateVehicle(560, 2473.2490, -1704.8604, 13.1925, 359.8790, 86, 86, 900);
    groveVehs[9] = CreateVehicle(482, 2466.2520, -1688.1406, 13.6778, 267.1897, 86, 86, 900);
    groveVehs[10] = CreateVehicle(579, 2470.4138, -1670.1687, 13.2181, 11.2582, 86, 86, 900);
    groveVehs[11] = CreateVehicle(409, 2443.2847, -1644.2251, 13.3183, 181.7236, 86, 86, 900);
    groveVehs[12] = CreateVehicle(562, 2425.2075, -1636.3978, 13.0753, 180.8151, 86, 86, 900);
    for (new i; i < sizeof(groveVehs); i++)
    {
        isGroveGangVeh[groveVehs[i]] = true;
    }
    ballasVehs[1] = CreateVehicle(517, 2142.6514, -1413.9413, 24.6928, 89.5360, 242, 0, 900); // kola1 - ballas
    ballasVehs[2] = CreateVehicle(522, 2150.4158, -1412.9873, 25.4909, 181.1308, 242, 0, 900); // motor - ballas
    ballasVehs[3] = CreateVehicle(522, 2150.4785, -1416.4919, 25.4929, 180.3405, 242, 0, 900); // motor2 - ballas
    ballasVehs[4] = CreateVehicle(560, 2157.7717, -1423.7246, 25.2054, 89.1576, 242, 242, 900); // sultan - ballas
    ballasVehs[5] = CreateVehicle(536, 2141.6545, -1429.4076, 24.3500, 89.7899, 242, 242, 900); // kola2 - ballas
    ballasVehs[6] = CreateVehicle(566, 2155.0444, -1454.5491, 25.3726, 90.0047, 242, 242, 900); // kola3 - ballas
    ballasVehs[7] = CreateVehicle(576, 2162.3745, -1454.5953, 25.1046, 90.2217, 242, 242, 900); // kola4 - ballas
    ballasVehs[8] = CreateVehicle(487, 2163.9646, -1465.8907, 25.7057, 1.0011, 242, 0, 900); // heli - ballas
    ballasVehs[9] = CreateVehicle(411, 2130.9939, -1491.8048, 23.5404, 359.6788, 242, 242, 900); // infernus - ballas
    ballasVehs[10] = CreateVehicle(508, 2121.8989, -1495.8799, 24.3548, 323.1362, 242, 242, 900); // kola za interior - ballas
    ballascars10text = Create3DTextLabel("{C2A2DA}Само за Rolling Heights Ballas\n{00FF00}Натисни {FF0000}G {00FF00}за да влезеш в караваната.\nНатисни {FF0000}ENTER {00FF00}за да излезеш, когато си в нея.", 0x00FF00FF, 0.0, 0.0, 0.0, 15.0, 0, 1);
    Attach3DTextLabelToVehicle(ballascars10text, ballasVehs[10], 0.0, 0.0, 0.0);
    ballasVehs[11] = CreateVehicle(481, 2128.7788, -1497.3928, 23.4840, 358.7587, 242, 242, 900); // kolelo - ballas
    ballasVehs[12] = CreateVehicle(481, 2130.0701, -1497.3970, 23.4555, 1.2986, 242, 242, 900); // kolelo2 - ballas
    for (new i; i < sizeof(ballasVehs); i++)
    {
        isBallasGangVeh[ballasVehs[i]] = true;
    }
    vagosVehs[1] = CreateVehicle(474, 1880.3109, 2286.1875, 10.7425, 269.7603, 6, 6, 900); // vagos1
    vagosVehs[2] = CreateVehicle(412, 1909.2897, 2289.5784, 10.6562, 91.3783, 6, 6, 900); // vagos2
    vagosVehs[3] = CreateVehicle(541, 1912.0590, 2302.3689, 10.4453, 0.6415, 6, 6, 900); // bulleta
    vagosVehs[4] = CreateVehicle(534, 1911.9614, 2309.6794, 10.5437, 359.1782, 6, 6, 900); // vagos4
    vagosVehs[5] = CreateVehicle(411, 1912.0503, 2318.0942, 10.5474, 356.3801, 6, 6, 900); // vagos5
    vagosVehs[6] = CreateVehicle(560, 1912.1449, 2325.5798, 10.5248, 356.6646, 6, 6, 900); // vagos6
    vagosVehs[7] = CreateVehicle(411, 1909.1853, 2348.1267, 10.6149, 273.3006, 6, 6, 900); // infernus
    vagosVehs[8] = CreateVehicle(487, 1875.9656, 2290.4939, 16.1995, 269.9442, 6, 0, 900); // helivagos1
    vagosVehs[9] = CreateVehicle(487, 1875.6268, 2339.5623, 16.1990, 269.4076, 6, 0, 900); // helivagos2
    vagosVehs[10] = CreateVehicle(506, 1890.2362, 2323.3767, 10.5249, 180.8689, 6, 6, 900); // vagoscar
    for (new i; i < sizeof(vagosVehs); i++)
    {
        isVagosGangVeh[vagosVehs[i]] = true;
    }
    triadsVehs[1] = CreateVehicle(522, 1947.9634, 949.1880, 10.3873, 230.9314, 0, 0, 900); // triads2
    triadsVehs[2] = CreateVehicle(522, 1949.7938, 950.5921, 10.3918, 232.6649, 0, 0, 900); // triads1
    triadsVehs[3] = CreateVehicle(409, 1964.9244, 938.4307, 10.5423, 269.1901, 0, 0, 900); // triads3
    triadsVehs[4] = CreateVehicle(560, 1957.6072, 938.5424, 10.4487, 268.5377, 0, 0, 900); // triads4
    triadsVehs[5] = CreateVehicle(579, 1951.4574, 938.7516, 10.6755, 268.7814, 0, 0, 900); // triads5
    triadsVehs[6] = CreateVehicle(409, 1882.8169, 963.8494, 10.6203, 270.8264, 0, 0, 900); // triads6
    triadsVehs[7] = CreateVehicle(409, 1882.9513, 957.3453, 10.6203, 270.1068, 0, 0, 900); // triads7
    triadsVehs[8] = CreateVehicle(560, 1911.7120, 963.5993, 10.5250, 184.1433, 0, 0, 900); // triads8
    triadsVehs[9] = CreateVehicle(411, 1916.3330, 963.6063, 10.5474, 183.2727, 0, 0, 900); // triads9
    triadsVehs[10] = CreateVehicle(578, 1930.8434, 949.9053, 11.4402, 90.0164, 0, 0, 900); // triads10
    for (new i; i < sizeof(triadsVehs); i++)
    {
        isTriadsGangVeh[triadsVehs[i]] = true;
    }
    aztecasVehs[1] = CreateVehicle(560, 752.0851, -503.2887, 16.9567, 180.3046, 2, 2, 900); // sultan - aztecas
    aztecasVehs[2] = CreateVehicle(560, 752.1932, -495.7025, 17.0342, 179.0867, 2, 2, 900); // sultan2 - aztecas
    aztecasVehs[3] = CreateVehicle(522, 748.9619, -522.2308, 15.9083, 180.3538, 2, 2, 900); // motor - aztecas
    aztecasVehs[4] = CreateVehicle(522, 747.5856, -521.9755, 15.9080, 180.3337, 2, 2, 900); // motor2 - aztecas
    aztecasVehs[5] = CreateVehicle(579, 762.8350, -514.2790, 16.7327, 180.0451, 2, 2, 900); // djipka - aztecas
    aztecasVehs[6] = CreateVehicle(579, 762.8936, -506.9639, 17.2283, 179.3087, 2, 2, 900); // djipka2 - aztecas
    aztecasVehs[7] = CreateVehicle(567, 771.9294, -545.5295, 16.6317, 358.3828, 2, 2, 900); // kola - aztecas
    aztecasVehs[8] = CreateVehicle(411, 785.6984, -502.3122, 16.9807, 180.6297, 2, 2, 900); // infernus - aztecas
    aztecasVehs[9] = CreateVehicle(411, 785.8930, -510.4932, 16.5555, 181.4656, 2, 2, 900); // infernus - aztecas
    aztecasVehs[10] = CreateVehicle(487, 743.9529, -541.0137, 16.6115, 358.6243, 2, 2, 900); // heli - aztecas
    aztecasVehs[11] = CreateVehicle(562, 750.7774, -545.9088, 16.4508, 359.3824, 2, 2, 900); // elegy - aztecas
    aztecasVehs[12] = CreateVehicle(573, 726.5473, -516.5283, 16.9103, 179.7132, 2, 2, 900); // interior - aztecas
    aztecascars12text = Create3DTextLabel("{33CCFF}Само за Varrio Los Aztecas\n{00FF00}Натисни {FF0000}G {00FF00}за да влезеш в камиона.\nНатисни {FF0000}ENTER {00FF00}за да излезеш, когато си в него.", 0x00FF00FF, 0.0, 0.0, 0.0, 15.0, 0, 1);
    Attach3DTextLabelToVehicle(aztecascars12text, aztecasVehs[12], 0.0, 0.0, 0.0);
    for (new i; i < sizeof(aztecasVehs); i++)
    {
        isAztecasGangVeh[aztecasVehs[i]] = true;
    }
    italianVehs[1] = CreateVehicle(533, -689.1786, 968.2943, 11.8831, 93.4251, 0, 0, 900); // Italian Mafia Car1
    italianVehs[2] = CreateVehicle(445, -688.9850, 963.5048, 12.0415, 88.5025, 0, 0, 900); // Italian Mafia Car2
    italianVehs[3] = CreateVehicle(579, -679.3967, 963.2996, 12.0695, 89.6264, 0, 0, 900); // Italian Mafia Car3
    italianVehs[4] = CreateVehicle(579, -679.9169, 968.8642, 12.0639, 92.4501, 0, 0, 900); // Italian Mafia Car4
    italianVehs[5] = CreateVehicle(487, -656.1565, 954.9906, 12.2760, 178.0132, 0, 0, 900); // Italian Mafia Car5
    italianVehs[6] = CreateVehicle(421, -674.0872, 946.0048, 12.0159, 28.7546, 0, 0, 900); // Italian Mafia Car6
    italianVehs[7] = CreateVehicle(545, -682.3112, 946.6027, 11.9397, 23.2160, 0, 0, 900); // Italian Mafia Car7
    italianVehs[8] = CreateVehicle(522, -693.6101, 944.4960, 11.8058, 271.0218, 0, 0, 900); // Italian Mafia Car8
    italianVehs[9] = CreateVehicle(522, -690.4867, 944.4437, 11.7571, 88.6222, 0, 0, 900); // Italian Mafia Car9
    for (new i; i < sizeof(italianVehs); i++)
    {
        isItalianGangVeh[italianVehs[i]] = true;
    }
    nangVehs[1] = CreateVehicle(487, 2622.4138, 1879.6233, 10.9970, 178.6253, 21, 21, 900); // nang1
    nangVehs[2] = CreateVehicle(409, 2619.7512, 1833.4093, 10.7184, 178.8567, 21, 21, 900); // nang2
    nangVehs[3] = CreateVehicle(409, 2619.5876, 1816.2043, 10.7149, 179.8992, 21, 21, 900); // nang3
    nangVehs[4] = CreateVehicle(522, 2633.1260, 1837.3751, 10.4041, 92.0362, 21, 21, 900); // nang4
    nangVehs[5] = CreateVehicle(522, 2633.3562, 1838.3010, 10.4482, 85.0043, 21, 21, 900); // nang5
    nangVehs[6] = CreateVehicle(518, 2631.2344, 1808.0491, 10.4913, 92.0208, 21, 21, 900); // nang6
    nangVehs[7] = CreateVehicle(560, 2630.7720, 1858.4489, 10.5257, 88.0735, 21, 21, 900); // nang7
    nangVehs[8] = CreateVehicle(562, 2630.7546, 1855.1859, 10.4795, 91.5200, 21, 21, 900); // nang8
    nangVehs[9] = CreateVehicle(559, 2631.0073, 1852.1052, 10.4766, 86.3341, 21, 21, 900); // nang9
    nangVehs[10] = CreateVehicle(567, 2602.9399, 1802.3368, 10.6974, 88.6509, 21, 21, 900); // nang10
    for (new i; i < sizeof(nangVehs); i++)
    {
        isNangGangVeh[nangVehs[i]] = true;
    }
    soaVehs[1] = CreateVehicle(463, 2607.5100, 2328.5344, 10.3606, 209.8055, 0, 0, 900); // soa1
    soaVehs[2] = CreateVehicle(463, 2609.4705, 2328.9753, 10.3566, 208.2699, 0, 0, 900); // soa2
    soaVehs[3] = CreateVehicle(463, 2610.9456, 2329.4771, 10.3568, 209.6774, 0, 0, 900); // soa3
    soaVehs[4] = CreateVehicle(463, 2612.0383, 2329.6987, 10.3569, 209.8093, 0, 0, 900); // soa4
    soaVehs[5] = CreateVehicle(463, 2613.3054, 2330.0266, 10.3569, 206.1571, 0, 0, 900); // soa5
    soaVehs[6] = CreateVehicle(463, 2614.3750, 2330.3340, 10.3566, 206.5669, 0, 0, 900); // soa6
    soaVehs[7] = CreateVehicle(461, 2619.5137, 2330.8586, 10.4088, 188.5789, 0, 0, 900); // soa7
    soaVehs[8] = CreateVehicle(554, 2624.4563, 2343.3042, 10.8312, 39.4545, 79, 0, 900); // soa8
    soaVehs[9] = CreateVehicle(554, 2640.7495, 2349.6467, 10.7933, 220.9568, 79, 0, 900); // soa9
    soaVehs[10] = CreateVehicle(434, 2632.3479, 2350.0049, 10.7170, 118.1949, 0, 0, 900); // soa10
    for (new i; i < sizeof(soaVehs); i++)
    {
        isSoaGangVeh[soaVehs[i]] = true;
    }
    rifaVehs[1] = CreateVehicle(496, -2197.5461, 965.4709, 79.7530, 270.4769, 152, 152, 900); // rifacar
    rifaVehs[2] = CreateVehicle(560, -2197.2048, 971.6678, 79.6639, 271.0227, 152, 152, 900); // rifacar
    rifaVehs[3] = CreateVehicle(560, -2197.3442, 977.9351, 79.6632, 271.3475, 152, 152, 900); // rifacar
    rifaVehs[4] = CreateVehicle(411, -2197.3025, 983.6387, 79.7338, 269.3553, 152, 152, 900); // rifacar
    rifaVehs[5] = CreateVehicle(567, -2196.9644, 989.8078, 79.8977, 269.2165, 152, 152, 900); // rifacar
    rifaVehs[6] = CreateVehicle(541, -2197.5020, 996.1154, 79.6346, 270.3678, 152, 152, 900); // rifacar
    rifaVehs[7] = CreateVehicle(495, -2197.2754, 1002.1566, 80.2880, 270.2743, 152, 152, 900); // rifacar
    rifaVehs[8] = CreateVehicle(522, -2198.6465, 1007.2259, 79.5743, 270.2843, 152, 152, 900); // rifacar
    rifaVehs[9] = CreateVehicle(522, -2198.4402, 1008.5887, 79.5686, 269.3019, 152, 152, 900); // rifacar
    rifaVehs[10] = CreateVehicle(487, -2214.6382, 1049.4929, 80.1886, 180.5292, 152, 152, 900); // rifacar
    rifaVehs[11] = CreateVehicle(513, -2205.5764, 973.1305, 85.4048, 2.3496, 0, 152, 900); // rifacar
    for (new i; i < sizeof(rifaVehs); i++)
    {
        isRifaGangVeh[rifaVehs[i]] = true;
    }

    // ID 411 (Infernus) - в началото
    intensePDVehs[0] = CreateVehicle(411, 1536.1382, -1670.6512, 13.0512, 0.7688, 0, 0, 900); // lspd
    intensePDVehs[1] = CreateVehicle(411, -1602.8589, 723.5639, 11.1457, 270.0789, 0, 0, 900);  // heli 1
    intensePDVehs[2] = CreateVehicle(411, -1609.1545, 723.7385, 12.2860, 270.2191, 0, 0, 900);  // heli 1
    intensePDVehs[3] = CreateVehicle(411, -1573.7810, 710.2883, -5.5151, 268.2603, 0, 0, 900); // sfp12
    intensePDVehs[4] = CreateVehicle(411, -1608.4790, 692.5464, -5.5151, 180.8416, 0, 0, 900);  // sfp13
    intensePDVehs[5] = CreateVehicle(411, -1616.5317, 691.5095, -5.5151, 179.1578, 0, 0, 900);

    // ID 522 - след това
    intensePDVehs[6] = CreateVehicle(522, 1578.6757, -1604.5576, 12.8507, 165.8881, 0, 0, 900); // lspd - sirena
    intensePDVehs[7] = CreateVehicle(522, 1541.5675, -1660.5764, 13.1191, 50.8811, 0, 0, 900); // lspd
    intensePDVehs[8] = CreateVehicle(522, 1540.3372, -1663.0706, 13.1191, 63.9225, 0, 0, 900); // lspd
    intensePDVehs[9] = CreateVehicle(522, -1625.6361, 692.4774, -5.6904, 0.0000, 0, 0, 900);
    intensePDVehs[10] = CreateVehicle(522, -1627.1006, 691.9947, -5.6656, 6.8663, 0, 0, 900);
    intensePDVehs[11] = CreateVehicle(522, -1628.2644, 692.0035, -5.6862, 11.3340, 0, 0, 900);

    // ID 560 - след това
    intensePDVehs[12] = CreateVehicle(560, 1536.1824, -1676.4670, 13.0971, 358.1916, 0, 0, 900); // lpd
    intensePDVehs[13] = CreateVehicle(560, 2294.8218, 2418.4224, 10.4658, 90.3843, 0, 0, 900);
    intensePDVehs[14] = CreateVehicle(560, 2287.3413, 2418.2878, 10.4668, 91.5691, 0, 0, 900);
    intensePDVehs[15] = CreateVehicle(560, 2279.9746, 2418.1211, 10.4656, 88.7879, 0, 0, 900);
    intensePDVehs[16] = CreateVehicle(560, 2273.6748, 2418.1306, 10.4486, 90.6060, 0, 0, 900);

    // Всички останали превозни средства
    intensePDVehs[17] = CreateVehicle(487, 1518.5498, -1657.1406, 13.6963, 268.7212, 0, 0, 900); // lspd heli
    intensePDVehs[18] = CreateVehicle(523, 1581.5049, -1604.4323, 12.9482, 157.5093, 1, 1, 900); // lspd
    intensePDVehs[19] = CreateVehicle(523, 1584.8009, -1604.6736, 12.9451, 146.7304, 0, 1, 900); // lspd
    intensePDVehs[20] = CreateVehicle(596, 1602.4288, -1615.0887, 13.1566, 89.2218, 0, 1, 900); // lspd
    intensePDVehs[21] = CreateVehicle(596, 1602.4105, -1620.5344, 13.1169, 91.2412, 0, 1, 900); // lspd
    intensePDVehs[22] = CreateVehicle(599, 1602.5525, -1630.8962, 13.6331, 87.6259, 0, 1, 900); // lspd
    intensePDVehs[23] = CreateVehicle(525, 1545.2478, -1609.5088, 13.2090, 268.9330, 53, 53, 900); // lspd tow truckl
    intensePDVehs[24] = CreateVehicle(599, 1602.6306, -1625.6815, 13.6845, 91.4508, 0, 1, 900); // veh new intensePDVehs[25] = CreateVehicle(497, -1673.6982, 697.5632, 30.7748, 87.0447, 0, 0, 900);  // heli 1
    intensePDVehs[26] = CreateVehicle(497, -1672.6749, 711.7892, 30.7710, 90.9230, 0, 0, 900);  // heli 2
    intensePDVehs[27] = CreateVehicle(497, -1688.7531, 704.7490, 30.8516, 0.0001, 0, 0, 900);  // heli 3
    intensePDVehs[28] = CreateVehicle(597, -1589.5455, 673.4875, 6.9573, 357.5952, 2, 1, 900);  // sfp1
    intensePDVehs[29] = CreateVehicle(597, -1594.3623, 673.0530, 6.9556, 357.5556, 2, 1, 900);  // sfp2
    intensePDVehs[30] = CreateVehicle(597, -1600.7976, 672.3998, 6.9558, 356.8631, 2, 1, 900);  // sfp3
    intensePDVehs[31] = CreateVehicle(601, -1616.9824, 651.7155, 6.9463, 179.8854, 0, 0, 900);  // sfp4
    intensePDVehs[32] = CreateVehicle(601, -1592.9884, 651.9330, 6.9463, 180.6861, 0, 0, 900);  // sfp5
    intensePDVehs[33] = CreateVehicle(581, -1581.0945, 674.6801, 6.7885, 358.0248, 0, 0, 900);  // sfp6
    intensePDVehs[34] = CreateVehicle(581, -1580.0282, 674.6340, 6.7739, 0.0020, 0, 0, 900);  // sfp7
    intensePDVehs[35] = CreateVehicle(581, -1582.3605, 674.4676, 6.7772, 7.3160, 0, 0, 900);  // sfp8
    intensePDVehs[36] = CreateVehicle(528, -1612.8768, 731.7792, -5.1970, 179.8327, 0, 0, 900);  // sfp9
    intensePDVehs[37] = CreateVehicle(528, -1600.6814, 750.5339, -5.1983, 359.3145, 0, 0, 900);  // sfp10
    intensePDVehs[38] = CreateVehicle(528, -1604.6685, 750.1108, -5.1990, 0.7827, 0, 0, 900);  // sfp11
    intensePDVehs[39] = CreateVehicle(598, 2251.6960, 2461.1604, 10.5647, 0.7289, 0, 1, 900);  // policecar1
    intensePDVehs[40] = CreateVehicle(598, 2281.7688, 2477.1084, 10.5665, 359.6116, 0, 1, 900);  // policecar2
    intensePDVehs[41] = CreateVehicle(599, 2278.2905, 2443.0581, 11.0037, 359.6354, 0, 1, 900);  // policecar3
    intensePDVehs[42] = CreateVehicle(599, 2269.5115, 2442.8984, 11.0052, 0.0001, 0, 1, 900);  // policecar4
    intensePDVehs[43] = CreateVehicle(427, 2313.4092, 2490.0430, 3.4570, 89.8919, 0, 1, 900);  // policecar5
    intensePDVehs[44] = CreateVehicle(427, 2300.4929, 2456.4758, 3.4689, 270.9489, 0, 1, 900);  // policecar6
    intensePDVehs[45] = CreateVehicle(601, 2315.9565, 2470.5745, 3.0322, 89.3433, 0, 1, 900);  // policecar7
    intensePDVehs[46] = CreateVehicle(598, 2241.8032, 2437.7478, 3.0233, 270.0572, 0, 1, 900);  // policecar8
    intensePDVehs[47] = CreateVehicle(523, 2277.7908, 2476.9065, 10.3955, 3.4096, 0, 1, 900);  // bike1
    intensePDVehs[48] = CreateVehicle(523, 2251.6497, 2441.2209, 10.3816, 181.8576, 0, 1, 900);  // bike2
    intensePDVehs[49] = CreateVehicle(497, 2312.0928, 2452.2563, 10.9972, 179.6904, 0, 1, 900);  // hili


    for (new i = 17; i <= 49; i++)
    {
        isIntensePDGangVehDUTY[intensePDVehs[i]] = true;
    }
    for (new i; i < sizeof(intensePDVehs); i++)
    {
        isIntensePDGangVeh[intensePDVehs[i]] = true;
    }

    crewVehs[1] = CreateVehicle(411, 311.4506, -1328.3651, 53.1399, 75.1864, 11, 11, 900); // nova
    crewVehs[2] = CreateVehicle(560, 312.0785, -1331.8235, 53.1406, 72.4239, 11, 11, 900); // nova
    crewVehs[3] = CreateVehicle(522, 295.1516, -1337.9702, 53.0159, 29.9148, 11, 11, 900); // nova
    crewVehs[4] = CreateVehicle(522, 294.4095, -1338.3842, 53.0166, 33.3519, 11, 11, 900); // nova
    crewVehs[5] = CreateVehicle(556, 291.3259, -1338.8458, 53.8150, 30.4666, 11, 11, 900); // nova
    crewVehs[6] = CreateVehicle(562, 283.6886, -1337.2506, 53.0961, 334.5271, 11, 11, 900); // nova
    crewVehs[7] = CreateVehicle(562, 299.2004, -1321.4900, 53.1074, 175.4064, 11, 11, 900); // nova
    crewVehs[8] = CreateVehicle(522, 304.9951, -1318.8513, 53.0205, 174.2306, 11, 11, 900); // nova
    crewVehs[9] = CreateVehicle(522, 305.8908, -1319.0862, 53.0156, 177.7132, 11, 11, 900); // nova

    for (new i; i < sizeof(crewVehs); i++)
    {
        isCrewGangVeh[crewVehs[i]] = true;
    }
    thugLifeVehs[1] = CreateVehicle(536, 499.1353, -1546.9138, 17.6004, 33.6026, 210, 210, 900); // car1
    thugLifeVehs[2] = CreateVehicle(411, 484.7022, -1538.8474, 18.8513, 23.5399, 210, 210, 900); // car1
    thugLifeVehs[3] = CreateVehicle(566, 489.4933, -1524.2977, 19.7925, 16.1943, 210, 210, 900); // car1
    thugLifeVehs[4] = CreateVehicle(482, 474.8501, -1511.5087, 20.6526, 305.0338, 210, 210, 900); // car1
    thugLifeVehs[5] = CreateVehicle(567, 488.0786, -1501.9819, 20.3090, 353.0443, 210, 210, 900); // car1
    thugLifeVehs[6] = CreateVehicle(522, 476.4594, -1488.7264, 19.7806, 279.6104, 210, 0, 900); // car1
    thugLifeVehs[7] = CreateVehicle(522, 475.9096, -1487.0114, 19.7075, 287.6581, 210, 0, 900); // car1
    thugLifeVehs[8] = CreateVehicle(566, 491.3945, -1482.8320, 19.4348, 15.3997, 210, 210, 900); // car1
    thugLifeVehs[9] = CreateVehicle(517, 487.2245, -1467.0896, 18.4881, 338.8649, 210, 0, 900); // car1
    thugLifeVehs[10] = CreateVehicle(560, 496.0072, -1470.9349, 18.3100, 332.8391, 210, 210, 900);

    for (new i; i < sizeof(thugLifeVehs); i++)
    {
        isThugLifeGangVeh[thugLifeVehs[i]] = true;
    }
    bountyVehs[1] = CreateVehicle(411, 660.6033, -1283.4000, 13.2719, 180.1347, 154, 154, 900); // bhunters1
    bountyVehs[2] = CreateVehicle(579, 660.3755, -1276.7418, 13.4738, 183.3500, 154, 154, 900); // bhunters2
    bountyVehs[3] = CreateVehicle(562, 660.0196, -1270.5104, 13.2035, 181.9810, 154, 154, 900); // bhunters3
    bountyVehs[4] = CreateVehicle(560, 669.5075, -1282.5005, 13.2498, 180.0450, 154, 154, 900); // bhunters4
    bountyVehs[5] = CreateVehicle(409, 669.4095, -1274.9530, 13.3426, 179.6351, 154, 154, 900); // bhunters5
    bountyVehs[6] = CreateVehicle(560, 669.6331, -1266.8650, 13.2453, 178.6060, 154, 154, 900); // bhunters6
    bountyVehs[7] = CreateVehicle(481, 688.2662, -1286.6830, 13.0898, 117.8503, 154, 154, 900); // bhunters7
    bountyVehs[8] = CreateVehicle(481, 688.2577, -1287.6053, 13.0891, 125.6551, 154, 154, 900); // bhunters8
    bountyVehs[9] = CreateVehicle(487, 742.4998, -1259.4336, 13.7324, 269.1596, 154, 154, 900); // bhunters9
    bountyVehs[10] = CreateVehicle(487, 765.3352, -1259.5431, 13.7472, 266.0747, 154, 154, 900); // bhunters10
    for (new i; i < sizeof(bountyVehs); i++)
    {
        isBountyGangVeh[bountyVehs[i]] = true;
    }
    cripzVehs[1] = CreateVehicle(411, 282.6102, -1160.0824, 80.6411, 225.3297, 53, 53, 900); // infernus - vcripz
    cripzVehs[2] = CreateVehicle(411, 286.7418, -1156.0349, 80.6380, 225.1132, 53, 53, 900); // infernus2 - vcripz
    cripzVehs[3] = CreateVehicle(487, 263.3456, -1171.7356, 79.6268, 278.1578, 53, 53, 900); // heli - cripz
    cripzVehs[4] = CreateVehicle(560, 278.0644, -1174.9341, 80.4535, 288.3980, 53, 53, 900); // sultan - vcripz
    cripzVehs[5] = CreateVehicle(560, 280.8209, -1177.5951, 80.5118, 290.0709, 53, 53, 900); // sultan2 - vcripz
    cripzVehs[6] = CreateVehicle(562, 286.8073, -1183.2435, 80.5736, 290.7241, 53, 53, 900); // elegy - cripz
    cripzVehs[7] = CreateVehicle(562, 283.8889, -1180.3596, 80.5570, 292.7408, 53, 53, 900); // elegy2 - cripz
    cripzVehs[8] = CreateVehicle(541, 273.3555, -1159.8564, 80.5399, 224.3608, 53, 53, 900); // kola - vcripz
    cripzVehs[9] = CreateVehicle(573, 288.1286, -1147.2111, 81.5615, 222.8329, 53, 53, 900); // interior - vcripz
    cripzcars9text = Create3DTextLabel("{000099}Само за Vinewood Cripz\n{00FF00}Натисни {FF0000}G {00FF00}за да влезеш в камиона.\nНатисни {FF0000}ENTER {00FF00}за да излезеш, когато си в него.", 0x00FF00FF, 0.0, 0.0, 0.0, 15.0, 0, 1);
    Attach3DTextLabelToVehicle(cripzcars9text, cripzVehs[9], 0.0, 0.0, 0.0);
    cripzVehs[10] = CreateVehicle(522, 305.4707, -1159.1051, 80.4810, 131.6496, 53, 53, 900); // motor - vcripz
    cripzVehs[11] = CreateVehicle(522, 304.4301, -1157.9576, 80.4809, 136.7975, 53, 53, 900); // motor2 - vcripz
    cripzVehs[12] = CreateVehicle(579, 317.2428, -1166.5176, 80.8455, 133.5803, 53, 53, 900); // djip - vcripz
    for (new i; i < sizeof(cripzVehs); i++)
    {
        isCripzGangVeh[cripzVehs[i]] = true;
    }
    AddStaticVehicleEx(537, 602.2946, 1285.0413, 13.3495, 300.1335, 1, 1, 900); // veh
    AddStaticVehicleEx(538, 2864.7500, 1343.2275, 12.1256, 0.0000, 1, 1, 900); // vlak
    AddStaticVehicleEx(449, 1449.6514, 2632.2500, 11.2473, 270.0000, 1, 74, 900); // 2
    AddStaticVehicleEx(449, 1417.1182, 2632.2500, 11.2473, 90.0000, 1, 74, 900); // 1
    CreateVehicle(492, 771.5253, -1334.1238, 13.2469, 359.8254, 64, 0, 900);
    CreateVehicle(467, 1376.2993, -993.1086, 29.0882, 354.3479, 48, 0, 900); // car1
    CreateVehicle(420, 2200.8689, 1277.5786, 10.6284, 90.6522, 6, 6, 900); // car1
    CreateVehicle(559, 2201.0156, 1285.6396, 10.4998, 90.2617, 11, 11, 900); // car2
    CreateVehicle(420, 2200.7776, 1293.7927, 10.6284, 89.2013, 6, 6, 900); // car3
    CreateVehicle(416, 1177.6736, -1308.3738, 13.9052, 269.5979, 1, 3, 900); // car
    CreateVehicle(463, 1419.7723, -1323.8895, 13.0992, 85.9360, 46, 0, 900); // car
    CreateVehicle(471, 1250.3735, -1229.2214, 13.0730, 183.1282, 51, 51, 900); // car
    CreateVehicle(522, 2099.8950, 943.9579, 10.3912, 268.7346, 5, 85, 900); // car
    CreateVehicle(521, 1994.6298, 1075.9277, 10.3904, 354.3320, 5, 6, 900); // car
    CreateVehicle(603, 1866.7584, 1179.1772, 10.5856, 179.8083, 0, 1, 900); // car
    CreateVehicle(471, 1707.7780, 1253.3064, 10.1819, 1.6518, 1, 3, 900); // car
    CreateVehicle(445, 1685.8378, 1316.6997, 10.6322, 179.6370, 66, 66, 900); // car
    CreateVehicle(541, 1640.8036, 1296.2123, 10.3646, 269.7993, 16, 0, 900); // car
    CreateVehicle(438, 1701.2408, 1406.9891, 10.5765, 322.9780, 6, 6, 900); // car
    CreateVehicle(420, 1698.8855, 1420.6882, 10.5292, 312.4913, 6, 6, 900); // car
    CreateVehicle(587, 1698.1412, 1471.9504, 10.4319, 262.1092, 98, 98, 900); // car
    CreateVehicle(522, 1698.4799, 1482.5646, 10.3257, 257.0431, 3, 1, 900); // car
    CreateVehicle(560, 1704.2808, 1498.6833, 10.4875, 245.7231, 80, 80, 900); // car
    CreateVehicle(416, 1624.0270, 1822.6215, 10.8584, 1.9184, 1, 3, 900); // car
    CreateVehicle(416, 1591.6675, 1821.1727, 11.0130, 359.5998, 3, 1, 900); // car
    CreateVehicle(468, 1609.7186, 1851.3127, 10.4882, 182.6533, 6, 6, 900); // car
    CreateVehicle(411, 1673.1298, 1834.5892, 10.4783, 179.0714, 61, 61, 900); // car
    CreateVehicle(451, 1685.2889, 1851.3425, 10.4465, 89.9739, 114, 114, 900); // car
    CreateVehicle(506, 1742.8035, 1912.5298, 10.4819, 271.3684, 3, 3, 900); // car
    CreateVehicle(544, 1763.7312, 2074.6404, 10.9848, 181.4266, 3, 3, 900); // car
    CreateVehicle(407, 1757.2053, 2075.1086, 10.9696, 180.9546, 3, 3, 900); // car
    CreateVehicle(522, 1527.8496, 2204.9924, 10.3920, 181.4801, 0, 0, 900); // car
    CreateVehicle(541, 1386.1497, 2249.2932, 10.4589, 89.6190, 3, 4, 900); // car
    CreateVehicle(506, 442.9023, -1802.7012, 5.2099, 354.2754, 72, 0, 900);
    CreateVehicle(562, 1465.7566, 2352.7119, 10.4478, 357.7283, 3, 4, 900); // car
    CreateVehicle(471, 1806.2070, 2623.6116, 10.2252, 178.7413, 6, 0, 900); // car
    CreateVehicle(481, 959.9683, -1522.0959, 13.0149, 359.8105, 57, 0, 900);
    CreateVehicle(418, 1849.3011, 2578.9045, 10.8492, 0.3017, 7, 7, 900); // car
    CreateVehicle(521, 367.5635, -1340.2676, 14.1076, 119.6715, 80, 0, 900);
    CreateVehicle(477, 1110.8416, -1630.7823, 13.2713, 90.0069, 53, 0, 900);
    CreateVehicle(507, 343.8066, -1808.6891, 4.2620, 179.5384, 73, 0, 900);
    CreateVehicle(522, 361.6628, -2029.4879, 7.3878, 307.3224, 43, 43, 900); //
    CreateVehicle(462, 361.6710, -2033.1227, 7.4226, 310.4334, 33, 33, 900); //
    CreateVehicle(510, 183.8260, -1581.6919, 13.1857, 48.3526, 76, 0, 900);
    CreateVehicle(411, 374.7554, -2024.4861, 7.4067, 357.6782, 50, 50, 900); //
    CreateVehicle(560, 375.0436, -2015.5992, 7.3990, 359.3605, 3, 3, 900); //
    CreateVehicle(462, 1422.0930, 2842.7683, 10.4136, 243.2839, 44, 44, 900); // car
    CreateVehicle(518, 437.6488, -1295.2046, 14.8682, 32.1277, 79, 0, 900);
    CreateVehicle(533, 1470.1700, 2839.4609, 10.5652, 180.2008, 12, 12, 900); // car
    CreateVehicle(415, 1529.5582, 2827.1646, 10.5410, 89.7498, 6, 6, 900); // car
    CreateVehicle(603, 1527.8746, 2858.9084, 10.6582, 265.3276, 125, 0, 900); // car
    CreateVehicle(439, 1682.0747, 2762.7502, 10.6553, 179.5395, 65, 65, 900); // car
    CreateVehicle(549, 2531.2766, 2511.3635, 10.4234, 91.4351, 2, 4, 900); // car
    CreateVehicle(535, 2460.6541, 2528.2312, 10.4951, 1.5184, 3, 3, 900); // car
    CreateVehicle(477, 2402.5583, 2557.0559, 10.6130, 270.3061, 1, 1, 900); // car
    CreateVehicle(562, 2239.6018, 2235.8860, 10.4459, 269.6897, 3, 0, 900); // car
    CreateVehicle(560, 2503.9712, 2238.2419, 10.3764, 89.0506, 0, 5, 900); // car
    CreateVehicle(522, 2441.2786, 2013.2446, 10.3922, 268.6646, 66, 66, 900); // car
    CreateVehicle(536, 2486.2520, 1991.3601, 10.6100, 359.6808, 6, 7, 900); // car
    CreateVehicle(559, 2363.2822, 2089.0911, 10.4186, 1.2506, 254, 2, 900); // car
    CreateVehicle(521, 2236.4492, 2130.2256, 10.3938, 271.5005, 3, 4, 900); // car
    CreateVehicle(510, 2100.4424, 2169.3293, 10.4026, 2.0098, 3, 0, 900); // car
    CreateVehicle(475, 2102.9392, 2082.5645, 10.6711, 89.0067, 0, 0, 900); // car
    CreateVehicle(411, 2186.5762, 1974.9695, 10.4760, 89.0564, 158, 158, 900); // car
    CreateVehicle(579, 2203.2639, 1788.1034, 10.6066, 1.9540, 17, 17, 900); // car
    CreateVehicle(461, 2156.2139, 1788.2894, 10.4033, 0.1878, 12, 12, 900); // car
    CreateVehicle(542, 2174.2043, 1821.9380, 10.5990, 179.8946, 22, 22, 900); // car
    CreateVehicle(422, 2604.6572, 1378.2987, 10.7430, 89.8924, 56, 4, 900); // car
    CreateVehicle(578, 2647.7517, 813.0166, 6.0297, 90.5862, 4, 4, 900); // car
    CreateVehicle(551, 2647.5747, 744.8439, 10.6319, 181.4257, 67, 67, 900); // car
    CreateVehicle(424, 981.2684, -1332.2112, 13.2060, 273.1884, 22, 22, 900); // car
    CreateVehicle(434, 1016.4972, -1360.9585, 13.2592, 90.3659, 100, 100, 900); // car2
    CreateVehicle(461, 2540.3374, 741.3383, 10.4002, 272.2441, 25, 25, 900); // car
    CreateVehicle(461, 1553.9242, -1785.0142, 13.1305, 90.0535, 43, 0, 900); // car
    CreateVehicle(475, 974.3016, -1305.6052, 13.2307, 179.8655, 131, 131, 900);
    CreateVehicle(570, 1749.2616, -1953.7760, 14.9954, 269.9383, 1, 1, 900); // train LS

    for (new cars = 0; cars < MAX_VEHICLES; cars++)
    {
        SetVehicleToRespawn(cars);
    }

    LockAllJobVehicles();

    return Y_HOOKS_CONTINUE_RETURN_1;
}

/*
* Tune Menu
*/
hook OnPlayerSelectedMenuRow(playerid, row)
{
    new Menu:Current = GetPlayerMenu(playerid);
    if (Current == TuningMenu)
    {
        switch (row)
        {
            case 0:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Paintjobs, playerid);
                }
            case 1:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Colors, playerid);
                }
            case 2:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Exhausts, playerid);
                }
            case 3:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Frontbumper, playerid);
                }
            case 4:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Rearbumper, playerid);
                }
            case 5:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Roof, playerid);
                }
            case 6:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Spoilers, playerid);
                }
            case 7:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Sideskirts, playerid);
                }
            case 8:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Wheels, playerid);
                }
            case 9:
                if (IsPlayerConnected(playerid))
                {
                    ShowMenuForPlayer(Others, playerid);
                }
        }
    }
    if (Current == Paintjobs)
    {
        switch (row)
        {
            case 0:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 560 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 || // Broadway
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 535 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehiclePaintjob(car, 0);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added paintjob to car");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] Paintjob is only for Wheel Arch Angrls and Loco Low Co types of cars");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 560 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 || // Broadway
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 535 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehiclePaintjob(car, 1);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added paintjob to car");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] Paintjob is only for Wheel Arch Angrls and Loco Low Co types of cars");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 560 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 || // Broadway
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 535 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehiclePaintjob(car, 2);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added paintjob to car");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] Paintjob is only for Wheel Arch Angrls and Loco Low Co types of cars");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 3:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 560 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 || // Broadway
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 535 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehiclePaintjob(car, 3);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added paintjob to car");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] Paintjob is only for Wheel Arch Angrls and Loco Low Co types of cars");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 4:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 560 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 || // Broadway
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 535 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehiclePaintjob(car, 4);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added paintjob to car");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] Paintjob is only for Wheel Arch Angrls and Loco Low Co types of cars");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 5:
            {
                ShowMenuForPlayer(TuningMenu, playerid);
            }
        }
    }
    if (Current == Colors)
    {
        switch (row)
        {
            case 0:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 0, 0);
                    ShowMenuForPlayer(Colors, playerid);
                }
                else
                {
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 1, 1);
                    ShowMenuForPlayer(Colors, playerid);
                }
                else
                {
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 3, 3);
                    ShowMenuForPlayer(Colors, playerid);
                }
                else
                {
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 3:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 79, 79);
                    ShowMenuForPlayer(Colors, playerid);
                }
                else
                {
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 4:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 86, 86);
                    ShowMenuForPlayer(Colors, playerid);
                }
                else
                {
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 5:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 6, 6);
                    ShowMenuForPlayer(Colors, playerid);
                }
                else
                {
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 6:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 126, 126);
                    ShowMenuForPlayer(Colors, playerid);
                }
                else
                {
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 7:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 66, 66);
                    ShowMenuForPlayer(Colors, playerid);
                }
            case 8: ShowMenuForPlayer(Colors1, playerid);
        }
    }
    if (Current == Colors1)
    {
        switch (row)
        {
            case 0:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 24, 24);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully repainted to car");
                    ShowMenuForPlayer(Colors1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 123, 123);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully repainted to car");
                    ShowMenuForPlayer(Colors1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 53, 53);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully repainted to car");
                    ShowMenuForPlayer(Colors1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 3:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 93, 93);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully repainted to car");
                    ShowMenuForPlayer(Colors1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 4:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 83, 83);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully repainted to car");
                    ShowMenuForPlayer(Colors1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 5:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 60, 60);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully repainted to car");
                    ShowMenuForPlayer(Colors1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 6:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 126, 126);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully repainted to car");
                    ShowMenuForPlayer(Colors1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 7:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    ChangeVehicleColor(car, 110, 110);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully repainted to car");
                    ShowMenuForPlayer(Colors1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 8: ShowMenuForPlayer(TuningMenu, playerid);
        }
    }
    if (Current == Exhausts)
    {
        switch (row)
        {
            case 0:
            {
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562)
                    {
                        AddVehicleComponent(car, 1034);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Exhaust component on Elegy");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565)
                    {
                        AddVehicleComponent(car, 1046);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Exhaust component on Flash");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559)
                    {
                        AddVehicleComponent(car, 1065);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Exhaust component on Jetser");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561)
                    {
                        AddVehicleComponent(car, 1064);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Exhaust component on Stratum");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                    {
                        AddVehicleComponent(car, 1028);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Exhaust component on Sultan");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
                    {
                        AddVehicleComponent(car, 1089);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Exhaust component on Uranus");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 1:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562)
                    {
                        AddVehicleComponent(car, 1037);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Exhaust component on Elegy");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565)
                    {
                        AddVehicleComponent(car, 1045);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Exhaust component on Flash");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559)
                    {
                        AddVehicleComponent(car, 1066);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow exaust component on Jester");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561)
                    {
                        AddVehicleComponent(car, 1059);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Exhaust component on Stratum");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                    {
                        AddVehicleComponent(car, 1029);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Exhaust component on Sultan");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558)
                    {
                        AddVehicleComponent(car, 1092);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Exhaust component on Uranus");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 535)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575) // Brodway
                    {
                        AddVehicleComponent(car, 1044);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer Exhaust component on Brodway");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534) // Remington
                    {
                        AddVehicleComponent(car, 1126);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer Exhaust component on Remington");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savanna
                    {
                        AddVehicleComponent(car, 1129);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer Exhaust component on Savana");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1104);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer Exhaust component on Blade");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) // Slamvan
                    {
                        AddVehicleComponent(car, 1113);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer Exhaust component on Slamvan");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 576) // Tornado
                    {
                        AddVehicleComponent(car, 1136);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer Exhaust component on Tornado");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 3:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 535)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575) // Brodway
                    {
                        AddVehicleComponent(car, 1043);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin Exhaust component on Brodway");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534) // Remington
                    {
                        AddVehicleComponent(car, 1127);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin Exhaust component on Remingon");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savanna
                    {
                        AddVehicleComponent(car, 1132);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin Exhaust component on Savana");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1105);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin Exhaust component on Blade");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) // Slamvan
                    {
                        AddVehicleComponent(car, 1114);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin Exhaust component on Slamvan");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 576) // Tornado
                    {
                        AddVehicleComponent(car, 1135);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin Exhaust component on Tornado");
                        ShowMenuForPlayer(Exhausts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 4: ShowMenuForPlayer(TuningMenu, playerid);
        }
    }
    if (Current == Frontbumper)
    {
        switch (row)
        {
            case 0:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1171);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien front bumper component on Elegy");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1153);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien front bumper component on Flash");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jester
                    {
                        AddVehicleComponent(car, 1160);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien front bumper component on Jester");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1155);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien front bumper component on Stratum");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1169);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien front bumper component on Sultan");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1166);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien front bumper component on Uraus");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1172);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow front bumper component on Elegy");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1152);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow front bumper component on Flash");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jetser
                    {
                        AddVehicleComponent(car, 1173);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow front bumper component on Jester");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1157);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow front bumper component on Stratum");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1170);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow front bumper component on Sultan");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1165);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow front bumper component on Uranus");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 535)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575) // Brodway
                    {
                        AddVehicleComponent(car, 1174);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer front bumper component on Brodway");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534) // Remington
                    {
                        AddVehicleComponent(car, 1179);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer front bumper component on Remington");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savanna
                    {
                        AddVehicleComponent(car, 1189);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer front bumper component on Savana");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1182);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer front bumper component on Blade");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) // Slamvan
                    {
                        AddVehicleComponent(car, 1115);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer front bumper component on Slamvan");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 576) // Tornado
                    {
                        AddVehicleComponent(car, 1191);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer front bumper component on Tornado");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 3:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 576)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575) // Brodway
                    {
                        AddVehicleComponent(car, 1175);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin front bumper component on Brodway");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534) // Remington
                    {
                        AddVehicleComponent(car, 1185);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin front bumper component on Remington");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savanna
                    {
                        AddVehicleComponent(car, 1188);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin front bumper component on Savana");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1181);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin front bumper component on Blade");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) // Slamvan
                    {
                        AddVehicleComponent(car, 1116);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin front bumper component on Slamvan");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 576) // Tornado
                    {
                        AddVehicleComponent(car, 1190);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin front bumper component on Tornado");
                        ShowMenuForPlayer(Frontbumper, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 4: ShowMenuForPlayer(TuningMenu, playerid);
        }
    }
    if (Current == Rearbumper)
    {
        switch (row)
        {
            case 0:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1149);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien rear bumper component on Elegy");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1150);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien rear bumper component on Flash");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jester
                    {
                        AddVehicleComponent(car, 1159);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien rear bumper component on Jester");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1154);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien rear bumper component on Stratum");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1141);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien rear bumper component on Sultan");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1168);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien rear bumper component on Uranus");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1148);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow rear bumper component on Elegy");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1151);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow rear bumper component on Flash");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jetser
                    {
                        AddVehicleComponent(car, 1161);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow rear bumper component on Jester");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1156);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow rear bumper component on Stratum");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1140);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow rear bumper component on Sultan");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1167);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch  X-Flow rear bumper component on Uranus");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 535)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575) // Brodway
                    {
                        AddVehicleComponent(car, 1176);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer rear bumper component on Brodway");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534) // Remington
                    {
                        AddVehicleComponent(car, 1180);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer rear bumper component on Remington");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savanna
                    {
                        AddVehicleComponent(car, 1187);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer rear bumper component on Savana");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1184);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer rear bumper component on Blade");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) // Slamvan
                    {
                        AddVehicleComponent(car, 1109);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer rear bumper component on Slamvan");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 576) // Tornado
                    {
                        AddVehicleComponent(car, 1192);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chromer rear bumper component on Tornado");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 3:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 535)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575) // Brodway
                    {
                        AddVehicleComponent(car, 1177);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin rear bumper component on Brodway");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534) // Remington
                    {
                        AddVehicleComponent(car, 1178);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin rear bumper component on Remington");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savanna
                    {
                        AddVehicleComponent(car, 1186);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin rear bumper component on Savana");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1183);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin rear bumper component on Blade");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) // Slamvan
                    {
                        AddVehicleComponent(car, 1110);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin rear bumper component on Slamvan");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 576) // Tornado
                    {
                        AddVehicleComponent(car, 1193);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Slamin rear bumper component on Tornado");
                        ShowMenuForPlayer(Rearbumper, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 4: ShowMenuForPlayer(TuningMenu, playerid);
        }
    }
    //==============================================================================
    //==============================================================================
    if (Current == Roof)
    {
        switch (row)
        {
            case 0:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1035);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien roof vent component on Elegy");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1054);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien roof vent component on Flash");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jester
                    {
                        AddVehicleComponent(car, 1067);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien roof vent component on Jester");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1055);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien roof vent component on Stratum");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1032);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien roof vent component on Sultan");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1088);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien roof vent component on Uranus");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1035);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow roof vent component on Elegy");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1053);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow roof vent component on Flash");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jetser
                    {
                        AddVehicleComponent(car, 1068);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow roof vent component on Jester");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1061);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow roof vent component on Stratum");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1033);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow roof vent component on Sultan");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1091);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow roof vent component on Uranus");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 536)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savana
                    {
                        AddVehicleComponent(car, 1130);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Hardtop Roof component on Brodway");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1128);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Hardtop Roof component on Blade");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types Savana and Blade");
                    ShowMenuForPlayer(Roof, playerid);
                }
            case 3:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 536)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savana
                    {
                        AddVehicleComponent(car, 1131);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Softtop Roof component on Brodway");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1103);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Softtop Roof component on Blade");
                        ShowMenuForPlayer(Roof, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types Savana and Blade");
                    ShowMenuForPlayer(Roof, playerid);
                }
            case 4:
            {
                ShowMenuForPlayer(TuningMenu, playerid);
            }
        }
    }
    if (Current == Spoilers)
    {
        switch (row)
        {
            case 0:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1147);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Spoilers component on Elegy");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1049);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Spoilers component on Flash");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jester
                    {
                        AddVehicleComponent(car, 1162);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Spoilers component on Jester");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1158);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Spoilers component on Stratum");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1138);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Spoilers component on Sultan");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1164);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Spoilers component on Uranus");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1146);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Spoilers component on Elegy");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1150);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Spoilers component on Flash");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jetser
                    {
                        AddVehicleComponent(car, 1158);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Spoilers component on Jester");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1060);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Spoilers component on Stratum");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1139);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Spoilers component on Sultan");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1163);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Spoilers component on Uranus");
                        ShowMenuForPlayer(Spoilers, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to X-Flow Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
            {
                ShowMenuForPlayer(TuningMenu, playerid);
            }
        }
    }
    if (Current == Sideskirts)
    {
        switch (row)
        {
            case 0:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1036);
                        AddVehicleComponent(car, 1040);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Side Skirts component on Elegy");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1047);
                        AddVehicleComponent(car, 1051);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Sideskirts vent component on Flash");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jester
                    {
                        AddVehicleComponent(car, 1069);
                        AddVehicleComponent(car, 1071);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Side Skirts component on Jester");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1056);
                        AddVehicleComponent(car, 1062);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Side Skirts component on Stratum");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1026);
                        AddVehicleComponent(car, 1027);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Side Skirts bumper component on Sultan");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1090);
                        AddVehicleComponent(car, 1094);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch Alien Side Skirts component on Uranus");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 565 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 559 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 561 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 560)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 562) // Elegy
                    {
                        AddVehicleComponent(car, 1039);
                        AddVehicleComponent(car, 1041);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Side Skirts component on Elegy");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 565) // Flash
                    {
                        AddVehicleComponent(car, 1048);
                        AddVehicleComponent(car, 1052);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Side Skirts component on Flash");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 559) // Jetser
                    {
                        AddVehicleComponent(car, 1070);
                        AddVehicleComponent(car, 1072);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Side Skirts component on Jester");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 561) // Stratum
                    {
                        AddVehicleComponent(car, 1057);
                        AddVehicleComponent(car, 1063);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Side Skirts component on Stratum");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 560) // Sultan
                    {
                        AddVehicleComponent(car, 1031);
                        AddVehicleComponent(car, 1030);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Side Skirts component on Sultan");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 558) // Uranus
                    {
                        AddVehicleComponent(car, 1093);
                        AddVehicleComponent(car, 1095);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wheel Arch X-Flow Side Skirts component on Uranus");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Wheel Arch Angels Car types");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 536 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 576 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 567)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 575) // Brodway
                    {
                        AddVehicleComponent(car, 1042);
                        AddVehicleComponent(car, 1099);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chrome Strip Side Skirts component on Brodway");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 567) // Savana
                    {
                        AddVehicleComponent(car, 1102);
                        AddVehicleComponent(car, 1133);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chrome Strip Side Skirts component on Savana");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 576) // Tornado
                    {
                        AddVehicleComponent(car, 1134);
                        AddVehicleComponent(car, 1137);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chrome Strip Side Skirts component on Tornado");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                    else if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 536) // Blade
                    {
                        AddVehicleComponent(car, 1108);
                        AddVehicleComponent(car, 1107);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chrome Strip Side Skirts component on Blade");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car types Brodway, Savana Tornado and Blade");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 3:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 534)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534) // Remington
                    {
                        AddVehicleComponent(car, 1122);
                        AddVehicleComponent(car, 1101);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chrome Flames Side Skirts component on Remington");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car type Remington ");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 4:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534 ||
                        GetVehicleModel(GetPlayerVehicleID(playerid)) == 534)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 534) // Remington
                    {
                        AddVehicleComponent(car, 1106);
                        AddVehicleComponent(car, 1124);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chrome Arches Side Skirts component on Remington");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car type Remington ");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 5:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) // Slamvan
                    {
                        AddVehicleComponent(car, 1118);
                        AddVehicleComponent(car, 1120);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chrome Trim Side Skirts component on Slamvan");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car type Slamvan ");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 6:
                if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535)
                {
                    new car = GetPlayerVehicleID(playerid);
                    if (GetVehicleModel(GetPlayerVehicleID(playerid)) == 535) // Slamvan
                    {
                        AddVehicleComponent(car, 1119);
                        AddVehicleComponent(car, 1121);
                        SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Loco Low-Co Chrome Wheelcovers component on Slamvan");
                        ShowMenuForPlayer(Sideskirts, playerid);
                    }
                }
                else
                {
                    SendClientMessage(playerid, COLOR_YELLOW, "[WARNING] You can only add this component to Loco Low-Co Car type Slamvan ");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 7: ShowMenuForPlayer(TuningMenu, playerid);
        }
    }
    if (Current == Wheels)
    {
        switch (row)
        {
            case 0:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1025);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Offroad Wheels ");
                    ShowMenuForPlayer(Wheels, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1074);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Mega Wheels");
                    ShowMenuForPlayer(Wheels, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 2:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1076);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Wires Wheels");
                    ShowMenuForPlayer(Wheels, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 3:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1078);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Twist Wheels");
                    ShowMenuForPlayer(Wheels, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(Wheels, playerid);
                }
            case 4:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1081);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Grove Wheels");
                    ShowMenuForPlayer(Wheels, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 5:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1082);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Import Wheels");
                    ShowMenuForPlayer(Wheels, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 6:
            {
                new car = GetPlayerVehicleID(playerid);
                AddVehicleComponent(car, 1085);
                SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Atomic Wheels");
                ShowMenuForPlayer(Wheels, playerid);
            }
            case 7:
            {
                new car = GetPlayerVehicleID(playerid);
                AddVehicleComponent(car, 1096);
                SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Ahab Wheels");
                ShowMenuForPlayer(Wheels, playerid);
            }
            case 8:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1097);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Virtual Wheels");
                    ShowMenuForPlayer(Wheels, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 9:
            {
                new car = GetPlayerVehicleID(playerid);
                AddVehicleComponent(car, 1098);
                SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Access Wheels");
                ShowMenuForPlayer(Wheels, playerid);
            }
            case 10:
            {
                ShowMenuForPlayer(Wheels1, playerid);
            }
            case 11:
            {
                ShowMenuForPlayer(TuningMenu, playerid);
            }
        }
    }
    if (Current == Wheels1)
    {
        switch (row)
        {
            case 0:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1084);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Trance Wheels ");
                    ShowMenuForPlayer(Wheels1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 1:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1073);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Shadow Wheels");
                    ShowMenuForPlayer(Wheels1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 2:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1075);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Rimshine Wheels");
                    ShowMenuForPlayer(Wheels1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 3:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1077);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Classic Wheels");
                    ShowMenuForPlayer(Wheels1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(Wheels, playerid);
                }
            }
            case 4:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1079);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Cutter Wheels");
                    ShowMenuForPlayer(Wheels1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 5:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1080);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Switch Wheels");
                    ShowMenuForPlayer(Wheels1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 6:
            {
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1083);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Dollar Wheels");
                    ShowMenuForPlayer(Wheels1, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
            case 7:
            {
                {
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            }
        }
    }
    if (Current == Nitro)
    {
        switch (row)
        {
            case 0:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1008);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added 2x Nitro to car ");
                    ShowMenuForPlayer(Others, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(TuningMenu, playerid);
                }
            case 1:
                if (GetPlayerMoney(playerid) >= -100000000000000)
                {
                    new car = GetPlayerVehicleID(playerid);
                    AddVehicleComponent(car, 1009);
                    SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added 5x Nitro to car");
                    ShowMenuForPlayer(Others, playerid);
                }
                else
                {
                    SendClientMessage(playerid, COLOR_RED, "Not enough money!");
                    ShowMenuForPlayer(Others, playerid);
                }
            case 2:
            {
                new car = GetPlayerVehicleID(playerid);
                AddVehicleComponent(car, 1010);
                SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added 10x Nitro to car");
                ShowMenuForPlayer(Others, playerid);
            }
            case 3:
            {
                ShowMenuForPlayer(Others, playerid);
            }
        }
    }
    if (Current == Others)
    {
        switch (row)
        {
            case 0:
            {
                new car = GetPlayerVehicleID(playerid);
                AddVehicleComponent(car, 1087);
                SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Hydraulics to car ");
                ShowMenuForPlayer(TuningMenu, playerid);
            }
            case 1:
            {
                new car = GetPlayerVehicleID(playerid);
                AddVehicleComponent(car, 1086);
                SendClientMessage(playerid, COLOR_DBLUE, "[SUCESS] You have succesfully added Stereo Bass bost system ");
                ShowMenuForPlayer(TuningMenu, playerid);
            }
            case 2:
            {
                ShowMenuForPlayer(Nitro, playerid);
            }
            case 3:
            {
                ShowMenuForPlayer(TuningMenu, playerid);
            }
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}


/*
* Gets vehicle speed
*/
stock GetVehicleKmh(vehicleid)
{
    new Float:x, Float:y, Float:z, vel;
    GetVehicleVelocity(vehicleid, x, y, z);
    vel = floatround(floatsqroot(x * x + y * y + z * z) * 180);
    return vel;
}


/*
* Load Tune for vehicles
*/
stock LoadVehTune(vehicleid)
{
    if (vehicleid == vipVehs[23])
    {
        ChangeVehiclePaintjob(vehicleid, 1);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[24])
    {
        ChangeVehiclePaintjob(vehicleid, 1);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[25])
    {
        ChangeVehiclePaintjob(vehicleid, 0);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[26])
    {
        ChangeVehiclePaintjob(vehicleid, 2);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[27])
    {
        ChangeVehiclePaintjob(vehicleid, 1);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[28])
    {
        ChangeVehiclePaintjob(vehicleid, 0);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[29])
    {
        ChangeVehiclePaintjob(vehicleid, 1);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[31])
    {
        ChangeVehiclePaintjob(vehicleid, 1);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[32])
    {
        ChangeVehiclePaintjob(vehicleid, 2);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[33])
    {
        ChangeVehiclePaintjob(vehicleid, 0);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[34])
    {
        ChangeVehiclePaintjob(vehicleid, 1);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
    if (vehicleid == vipVehs[35])
    {
        ChangeVehiclePaintjob(vehicleid, 1);
        AddVehicleComponent(vehicleid, 1035);
        AddVehicleComponent(vehicleid, 1147);
    }
}


/*
* Plate
*/
stock ProcessPlateChange(playerid, plateText[], businessID)
{
    GivePlayerCash(playerid, -500);
    
    new vehicleid = GetPlayerVehicleID(playerid);
    SetVehicleNumberPlate(vehicleid, plateText);
    
    new Float:x, Float:y, Float:z, Float:angle;
    GetVehiclePos(vehicleid, x, y, z);
    GetVehicleZAngle(vehicleid, angle);
    
    RemovePlayerFromVehicle(playerid);
    SetVehicleToRespawn(vehicleid);
    SetVehiclePos(vehicleid, x, y, z);
    SetVehicleZAngle(vehicleid, angle);
    
    SendClientMessage(playerid, 0xFFFFFFFF, "Ти промени текста на твоята кола!");
    
    // Respawn all vehicles (this seems odd - might want to review this logic)
    for (new i = GetVehiclePoolSize(); i > 0; i--)
    {
        if (GetVehicleModel(i) != 0) // Only respawn valid vehicles
        {
            SetVehicleToRespawn(i);
        }
    }
}

stock VehicleToggleEngine(vehicleid, toggle)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, toggle, lights, alarm, doors, bonnet, boot, objective);
}
stock ToggleAlarm(vehicleid, toggle)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, lights, toggle, doors, bonnet, boot, objective);
}
stock ToggleBonnet(vehicleid, toggle)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, toggle, boot, objective);
}
stock ToggleLights(vehicleid, toggle)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, toggle, alarm, doors, bonnet, boot, objective);
}
stock ToggleBoot(vehicleid, toggle)
{
    new engine, lights, alarm, doors, bonnet, boot, objective;
    GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
    SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, toggle, objective);
}
////////