/*
* Team Data
*/
enum tInfo
{
    tName[256],
        tRank1[256],
        tRank2[256],
        tRank3[256],
        tRank4[256],
        tRank5[256],
        tRank6[256],
        tMute,
        tRCOLOR,
        tTCOLOR,
        tTurfsCount,
        tInTurfWar,
        tAttackTurfTime,
        tTurfAttacked
}
new TeamInfo[MAX_TEAMS][tInfo] = {
    {
        "Civilian",
        "Няма име",
        "Няма име",
        "Няма име",
        "Няма име",
        "Няма име",
        "Няма име",
        0,
        COLOR_TCIVIL,
        299
    },
    {
        "VIP",
        "Новак",
        "Напредващ новак",
        "Подобряващ",
        "Лява ръка на шефа",
        "Дясна ръка на шефа",
        "Шеф",
        0,
        COLOR_RVIP,
        COLOR_TVIP,
        0
    },
    {
        "Grove Street Families",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RGROVE,
        COLOR_TGROVE,
        0
    },
    {
        "Rolling Heights Ballas",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RBALLAS,
        COLOR_TBALLAS,
        0
    },
    {
        "Los Santos Vagos",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RVAGOS,
        COLOR_TVAGOS,
        0
    },
    {
        "Varrio Los Aztecas",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RAZTEC,
        COLOR_TAZTECAS,
        0
    },
    {
        "Vinewood Cripz",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RCRIPZ,
        COLOR_TCRIPZ,
        0
    },
    {
        "San Fierro Triads",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RTRIADS,
        COLOR_TTRIADS,
        0
    },
    {
        "San Fierro Rifa",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RRIFA,
        COLOR_TRIFA,
        0
    },
    {
        "Sons Of Anarchy",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RSOA,
        COLOR_TSOA,
        0
    },
    {
        "Da Nang Boys",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RNANG,
        COLOR_TNANG,
        0
    },
    {
        "Italian Mafia",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RITALIAN,
        COLOR_TITALIAN,
        0
    },
    {
        "Bounty Hunters",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RBOUNTY,
        COLOR_TBOUNTY,
        0
    },
    {
        "Thug Life",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RTHUGLIFE,
        COLOR_TTHUGLIFE,
        0
    },
    {
        "116th Street Crew",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_R116ST,
        COLOR_T116ST,
        0
    },
    {
        "Intense Police Department",
        "Полицай",
        "Главен полицай",
        "Инспектор",
        "Главен Инспектор",
        "Комисар",
        "Главен Секретар",
        0,
        COLOR_RIPD,
        COLOR_RCIVIL,
        0
    },
    {
        "Soldier Boys",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RSOLDIER,
        COLOR_TSOLDIER,
        0
    },
    {
        "Yakuza",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RYAKUZA,
        COLOR_TYAKUZA,
        0
    },
    {
        "Syndicate Texas",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RSYNDICATE,
        COLOR_TSYNDICATE,
        0
    },
    {
        "Blood Mafia",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RBLOODMAFIA,
        COLOR_TBLOODMAFIA,
        0
    },
    {
        "Mara Salvatrucha 13",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RMS13,
        COLOR_TMS13,
        0
    },
    {
        "Bulgarian Mafia",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_RBGM,
        COLOR_TBGM,
        0
    },
    {
        "343 Black Street Avenue",
        "Gangsta",
        "Original Gangsta",
        "Double OG",
        "Left Hand",
        "Right Hand",
        "Boss",
        0,
        COLOR_R343,
        COLOR_T343,
        0
    }
};

/*
* Vehicles
*/
new vipVehs[42];
new groveVehs[13];
new ballasVehs[13];
new vagosVehs[11];
new aztecasVehs[13];
new cripzVehs[13];
new triadsVehs[11];
new rifaVehs[12];
new soaVehs[11];
new nangVehs[11];
new italianVehs[10];
new bountyVehs[11];
new thugLifeVehs[11];
new crewVehs[10];
new intensePDVehs[50];
new soldierVehs[11];
new yakuzaVehs[11];
new syndicateVehs[10];
new bloodMafiaVehs[11];
new ms13Vehs[11];
new bgMafiaVehs[10];
new Gang343Vehs[10];

/*
* Dictonary
*/
new bool: isVipGangVeh[MAX_VEHICLES] = false;
new bool: isGroveGangVeh[MAX_VEHICLES] = false;
new bool: isBallasGangVeh[MAX_VEHICLES] = false;
new bool: isVagosGangVeh[MAX_VEHICLES] = false;
new bool: isAztecasGangVeh[MAX_VEHICLES] = false;
new bool: isCripzGangVeh[MAX_VEHICLES] = false;
new bool: isTriadsGangVeh[MAX_VEHICLES] = false;
new bool: isRifaGangVeh[MAX_VEHICLES] = false;
new bool: isSoaGangVeh[MAX_VEHICLES] = false;
new bool: isNangGangVeh[MAX_VEHICLES] = false;
new bool: isItalianGangVeh[MAX_VEHICLES] = false;
new bool: isBountyGangVeh[MAX_VEHICLES] = false;
new bool: isThugLifeGangVeh[MAX_VEHICLES] = false;
new bool: isCrewGangVeh[MAX_VEHICLES] = false;
new bool: isIntensePDGangVeh[MAX_VEHICLES] = false;
new bool: isIntensePDGangVehDUTY[MAX_VEHICLES] = false;
new bool: isSoldierGangVeh[MAX_VEHICLES] = false;
new bool: isYakuzaGangVeh[MAX_VEHICLES] = false;
new bool: isSyndicateGangVeh[MAX_VEHICLES] = false;
new bool: isBloodMafiaGangVeh[MAX_VEHICLES] = false;
new bool: isMS13GangVeh[MAX_VEHICLES] = false;
new bool: isBGMafiaGangVeh[MAX_VEHICLES] = false;
new bool: is343GangVeh[MAX_VEHICLES] = false;

/*
* Gang System
*/
new helperLeaderGangRankSkin[MAX_TEAMS];
new gangRankSkin[MAX_TEAMS][7];
new gangspawn[MAX_TEAMS][20][30];
new TeamInvite[MAX_PLAYERS] = -1;