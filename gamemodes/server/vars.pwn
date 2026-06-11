/*
* General
*/

new vbike[MAX_PLAYERS];

/*
* AFK
*/

new gLastUpdate[MAX_PLAYERS];
new playerAfkSeconds[MAX_PLAYERS];
new playerAfkMinutes[MAX_PLAYERS];
new AFKDetect[MAX_PLAYERS];
new lastMoveTime[MAX_PLAYERS];

/*
* IPD
*/
new lvpd1;
new lvpd2;
new lvpdB1Timer;
new lvpdB2Timer;
new lspdCell1;
new lspdCell2;
new specialobject;
new bool: lspdCell1open = false;
new bool: lspdCell2open = false;

/*
* Jobs
*/
new afterwork[43];
new carpizza[7];
new carboat[7];
new carcoalmine[7];
new carsweeper[7];
new carpilot[7];
new cardeliver[7];
new carbus[7];
new cartruck[7];

/*
* Fishing
*/
new fishBoat1[6];
new fishBoat2[6];

/*
* IFC
*/
new refuelcisterna[MAX_PLAYERS] = 0;
new fueltruck[3];
new fuelremarke[3];
new fuelStationsFuel[25] = 5000;

/*
* Mechanic Duty
*/
new mechanicDutyVehs[8];
new mechanicDuty[MAX_PLAYERS];

/*
* Counter
*/
new activecount = 0;
new eventActiveCount = 0;

/*
* Clothes
*/
new bool: loadedClothes[MAX_PLAYERS] = false;
new selectedTmpClothID[MAX_PLAYERS] = 0;

/*
* Admin
*/
new adutyskinchanged[MAX_PLAYERS] = 0;
new hhrefuel, mmrefuel, ssrefuel, playerrefuel[115];
new Jump[MAX_PLAYERS] = 0;
new godmode[MAX_PLAYERS] = 0;
new acuffed[MAX_PLAYERS] = 0;
new AntiFallOfBike[MAX_PLAYERS] = 0;
new specing[MAX_PLAYERS] = 0;
new scripterMode[MAX_PLAYERS] = 0;
new fly[MAX_PLAYERS] = 0;
new Float:AX[MAX_PLAYERS], Float:AY[MAX_PLAYERS], Float:AZ[MAX_PLAYERS], Float:AZA[MAX_PLAYERS];
new AINT[MAX_PLAYERS], AVW[MAX_PLAYERS];
new adminprefix[501][35];
new marked[MAX_PLAYERS] = 0;

/*
* Payday
*/
new zaplatakinti[MAX_PLAYERS] = 0;
new lastpaydaykinti[MAX_PLAYERS] = 0;

/*
* Goto Teleport
*/
new GotoInvite[MAX_PLAYERS];
new bool: GotoInviteAccepted[MAX_PLAYERS];

/*
* Sell Vehicles
*/

/*
* Santa hat
*/
new bool: santaHat[MAX_PLAYERS] = false;
new santaHatObject[MAX_PLAYERS];

new carshopobjects[12];
new carshopcars[12];
new carshopcars2[12];
new vehInShop[MAX_VEHICLES] = false;
/*
* Keys
*/
new lastkey[MAX_PLAYERS] = -1;
new oldkey[MAX_PLAYERS] = -1;
/*
* Weapons
*/

new SavedWeapon[MAX_PLAYERS][13];
new SavedAmmo[MAX_PLAYERS][13];

/*
* Hitman
*/

new hitmaner[MAX_PLAYERS] = -1;
new hitmanprice[MAX_PLAYERS] = 0;
new hitmanby[MAX_PLAYERS] = -1;

/*
* Last Locations and Timers
*/

new lastCriminalDrug[MAX_PLAYERS];
new lastCriminalPoliceCar[MAX_PLAYERS];
new lastCriminalPoliceUser[MAX_PLAYERS];
new lastADuty[MAX_PLAYERS];

/*
* 3D Texts
*/

new Text3D: aztecascars12text;
new Text3D: cripzcars9text;
new Text3D: ballascars10text;
new Text3D:PlayerLabel[MAX_PLAYERS];
new VipText3D[MAX_PLAYERS][26];
new Text3D:fuelStationText[25];

/*
* Texts
*/

new Text: levelText[MAX_PLAYERS];
new Text: epText[MAX_PLAYERS];
new Text: msText[MAX_PLAYERS];
new Text: epsText[MAX_PLAYERS];
new Text:vehstatus[MAX_PLAYERS];
new Text:ifcFuelText[MAX_PLAYERS];
new Text:ClockDate;
new Text:intensetext;
new Text:RESTART;
new Text:DMONKillText;
new Text:DMON[MAX_PLAYERS];
new Text:Intro[6];

/*
* Robbery
*/
new robberyTimeToStartAgain = 0;
new robberyTimerToCollect = 0;
new robberyToStopTimer = 0;
new robberyTimerRobberToStart = 0;
new robCollectedMoney = 0;
new robberyMembers = 0;
new robberyPlace = 0;

/*
* Menu
*/
new gTotalItems = TOTAL_ITEMS;
new PlayerText:gCurrentPageTextDrawId[MAX_PLAYERS];
new PlayerText:gHeaderTextDrawId[MAX_PLAYERS];
new PlayerText:gBackgroundTextDrawId[MAX_PLAYERS];
new PlayerText:gNextButtonTextDrawId[MAX_PLAYERS];
new PlayerText:gPrevButtonTextDrawId[MAX_PLAYERS];
new PlayerText:gSelectionItems[MAX_PLAYERS][SELECTION_ITEMS];
new gSelectionItemsTag[MAX_PLAYERS][SELECTION_ITEMS];
new gItemAt[MAX_PLAYERS];
new
bool: g_bump[MAX_PLAYERS],
    g_veh[MAX_PLAYERS];
new gItemList[TOTAL_ITEMS] = {
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31,
    32,
    33,
    34,
    35,
    36,
    37,
    38,
    39,
    40,
    41,
    42,
    43,
    44,
    45,
    46,
    47,
    48,
    49,
    50,
    51,
    52,
    53,
    54,
    55,
    56,
    57,
    58,
    59,
    60,
    61,
    62,
    63,
    64,
    65,
    66,
    67,
    68,
    69,
    70,
    71,
    72,
    73,
    74,
    75,
    76,
    77,
    78,
    79,
    80,
    81,
    82,
    83,
    84,
    85,
    86,
    87,
    88,
    89,
    90,
    91,
    92,
    93,
    94,
    95,
    96,
    97,
    98,
    99,
    100,
    101,
    102,
    103,
    104,
    105,
    106,
    107,
    108,
    109,
    110,
    111,
    112,
    113,
    114,
    115,
    116,
    117,
    118,
    119,
    120,
    121,
    122,
    123,
    124,
    125,
    126,
    127,
    128,
    129,
    130,
    131,
    132,
    133,
    134,
    135,
    136,
    137,
    138,
    139,
    140,
    141,
    142,
    143,
    144,
    145,
    146,
    147,
    148,
    149,
    150,
    151,
    152,
    153,
    154,
    155,
    156,
    157,
    158,
    159,
    160,
    161,
    162,
    163,
    164,
    165,
    166,
    167,
    168,
    169,
    170,
    171,
    172,
    173,
    174,
    175,
    176,
    177,
    178,
    179,
    180,
    181,
    182,
    183,
    184,
    185,
    186,
    187,
    188,
    189,
    190,
    191,
    192,
    193,
    194,
    195,
    196,
    197,
    198,
    199,
    200,
    201,
    202,
    203,
    204,
    205,
    206,
    207,
    208,
    209,
    210,
    211,
    212,
    213,
    214,
    215,
    216,
    217,
    218,
    219,
    220,
    221,
    222,
    223,
    224,
    225,
    226,
    227,
    228,
    229,
    230,
    231,
    232,
    233,
    234,
    235,
    236,
    237,
    238,
    239,
    240,
    241,
    242,
    243,
    244,
    245,
    246,
    247,
    248,
    249,
    250,
    251,
    252,
    253,
    254,
    255,
    256,
    257,
    258,
    259,
    260,
    261,
    262,
    263,
    264,
    265,
    266,
    267,
    268,
    269,
    270,
    271,
    272,
    273,
    274,
    275,
    276,
    277,
    278,
    279,
    280,
    281,
    282,
    283,
    284,
    285,
    286,
    287,
    288,
    289,
    290,
    291,
    292,
    293,
    294,
    295,
    296,
    297,
    298,
    299,
    300,
    301,
    302,
    303,
    304,
    305,
    306,
    307,
    308,
    309,
    310,
    311
};

/*
* Audio Streams
*/
new audiostreams[][] = {
    {
        "http://k003.kiwi6.com/hotlink/rpxqi09ojz/Coolio_-_Gangsta_Paradise.mp3"
    },
    {
        "http://k003.kiwi6.com/hotlink/zpk5k464m4/50_Cent_-_Candy_Shop_ft._Olivia-_AudioTrimmer.com_.mp3"
    },
    {
        "http://k003.kiwi6.com/hotlink/7bv42eb2nz/Chamillionaire_-_Ridin_ft._Krayzie_Bone-_AudioTrimmer.com_.mp3"
    },
    {
        "http://k003.kiwi6.com/hotlink/ogmzy9sjat/Eminem_-_Phenomenal_Lyric_Video_-_AudioTrimmer.com_.mp3"
    },
    {
        "http://k003.kiwi6.com/hotlink/8sb17wkrqx/Roy_Jones_Jr._-_Can_t_Be_Touched.mp3"
    },
    {
        "http://k003.kiwi6.com/hotlink/7iyf4xb2fz/Tokyo_Drift_-_Teriyaki_Boyz_MUSIC_VIDEO_HD.mp3"
    },
    {
        "http://k003.kiwi6.com/hotlink/tcmbazycnr/Usher_-_Yeah_ft._Lil_Jon_Ludacris.mp3"
    },
    {
        "http://k003.kiwi6.com/hotlink/vmyupqresi/Wiz_Khalifa_-_Black_And_Yellow_G-Mix_ft._Snoop_Dogg_Juicy_J_and_T-Pain.mp3"
    }
};

/*
* Last Coordinates
*/
enum pLastCoor
{
    Float:Coords[3],
        Float:sPx,
        Float:sPy,
        Float:sPz,
        sPint,
        sLocal,
        Float:sAngle,
        sVw,
        sCam,
};
new LastCoor[MAX_PLAYERS][pLastCoor];

/*
* Last Entered Property
*/
new enteredbiz[MAX_PLAYERS] = 0;
new enteredhouse[MAX_PLAYERS] = 0;

/*
* Tuning Menus
*/
new Menu:TuningMenu;
new Menu:Paintjobs;
new Menu:Colors;
new Menu:Colors1;
new Menu:Exhausts;
new Menu:Frontbumper;
new Menu:Rearbumper;
new Menu:Roof;
new Menu:Spoilers;
new Menu:Sideskirts;
new Menu:Wheels;
new Menu:Wheels1;
new Menu:Nitro;
new Menu:Others;

/*
* Date
*/
new hours;
new minutes;
new seconds;
new day;
new month;
new year;

/*
* Restart GMX
*/
new ingmx = 0;

/*
* Lottery Reward
*/
new lottowin = 5000;

/*
* Switching Property
*/
new bool:bizSwitching[MAX_PLAYERS] = false;
new bool:houseSwitching[MAX_PLAYERS] = false;
new houseSwitchSender[MAX_PLAYERS] = -1;
new houseSwitchReceiver[MAX_PLAYERS] = -1;
new bizSwitchSender[MAX_PLAYERS] = -1;
new bizSwitchReceiver[MAX_PLAYERS] = -1;

/*
* Selling Property
*/
new bool:houseSelling[MAX_PLAYERS] = false;
new houseSellSenderPrice[MAX_PLAYERS] = -1;
new houseSellSender[MAX_PLAYERS] = -1;
new houseSellReceiver[MAX_PLAYERS] = -1;

/*
* Count
*/
new eventCount0;
new eventCount1;
new eventCount2;
new counttime0;
new counttime1;
new counttime2;

/*
* Vote
*/
new voteResultsYes = 0;
new voteResultsNo = 0;
new respawnVehsTimer;
new respawnVehsVoteTimer;
new voteTimer;
new voteQuestion[256];
new isMadeRefuel = 0;
new respawnVehsYes = 0;
new respawnVehsNo = 0;

/*
* General Vars
*/
new bool: ifcFuelTextOn[MAX_PLAYERS] = false;
new returnUsersCount = 0;
new spawnedcars = 0;
new attachobjecta;
new hideIPD = 0;
new Float:LX;
new Float:LY;
new Float:LZ;
new maxprivatevehs = 1;
new sfpermission = 0;
new bool: gpsOn[MAX_PLAYERS];
new bool:towTruckSkin[MAX_PLAYERS];
new bool: InTuneGarage[MAX_PLAYERS] = false;
new bool: replyPm[MAX_PLAYERS] = false;
new bool: passenger[MAX_PLAYERS] = false;
new onhousepick2[MAX_PLAYERS] = 0;
new onbizpick2[MAX_PLAYERS] = 0;
new playerInHousePickup[MAX_PLAYERS];
new playerInBizPickup[MAX_PLAYERS];
new objectright[MAX_PLAYERS] = 0;
new refuelcan[MAX_PLAYERS] = 0;
new firstskin[MAX_PLAYERS] = 0;
new BigEar[MAX_PLAYERS] = 0;
new logged[MAX_PLAYERS] = 0;
new onWork[MAX_PLAYERS] = 0;
new radioff[MAX_PLAYERS] = 0;
new driver[MAX_PLAYERS] = 0;
new WhatCar[MAX_PLAYERS] = 0;
new spawned[MAX_PLAYERS] = 0;
new firstspawn[MAX_PLAYERS] = 1;
new radion[MAX_PLAYERS] = 0;
new nospam2[MAX_PLAYERS] = 0;
new togchat[MAX_PLAYERS] = 0;
new hideexitserver[MAX_PLAYERS] = 0;
new rezachka[MAX_PLAYERS] = 0;
new cbchat[MAX_PLAYERS] = 0;
new commandspam[MAX_PLAYERS] = 0;
new nameon[MAX_PLAYERS] = 1;
new textspam[MAX_PLAYERS] = 0;
new statisticset[MAX_PLAYERS] = 0;
new Speed[MAX_PLAYERS] = 0;
new speedo[MAX_PLAYERS] = 0;
new kmh[MAX_PLAYERS] = 0;
new timeset[MAX_PLAYERS] = 0;
new dateset[MAX_PLAYERS] = 0;
new oldvehid[MAX_PLAYERS] = -1;
new drive[MAX_VEHICLES] = 0;
new vehfuel[MAX_VEHICLES] = 100;
new vehfuel2[MAX_VEHICLES] = 0;
new Float:vehhealth[MAX_PLAYERS];
new Float:X[MAX_PLAYERS], Float:Y[MAX_PLAYERS], Float:Z[MAX_PLAYERS];
new fignore[MAX_PLAYERS][MAX_PLAYERS];
new ignore[MAX_PLAYERS][MAX_PLAYERS];
new spawnselectedskin[MAX_PLAYERS] = 0;
new spawnselectedskin2[MAX_PLAYERS] = 0;
new wrongpassword[MAX_PLAYERS] = 0;
new pDrunkLevelLast[MAX_PLAYERS];
new pFPS[MAX_PLAYERS] = 30;
new loadedtexts[MAX_PLAYERS] = 0;
new loadedtext[MAX_PLAYERS] = 0;
new housetimer[MAX_PLAYERS];
new biztimer[MAX_PLAYERS];
new lottonumber[MAX_PLAYERS] = 0;
new requestspawn2[MAX_PLAYERS] = 0;
new timec[MAX_PLAYERS] = 0;
new sitec[MAX_PLAYERS] = 0;
new nospawnselect[MAX_PLAYERS] = 0;
new introon[MAX_PLAYERS] = 0;
new requestspawn[MAX_PLAYERS] = 0;
new afterjobcheckpoint[MAX_PLAYERS] = 0;
new isinhousepickup[MAX_PLAYERS] = 0;
new isinbizpickup[MAX_PLAYERS] = 0;
new para1[MAX_PLAYERS] = -1;
new spec[MAX_PLAYERS] = 0;

/*
* GMX
*/
new serverrestarttimer = 0;

/*
* General Timer
*/
new updatedseconds;

/*
* Robbery
*/
new startedrob = 0;