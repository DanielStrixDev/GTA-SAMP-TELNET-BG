/*
* StreetRace
*/
new streetRaceSecondsCounter[MAX_PLAYERS];
new streetRaceTypeIndex;
new streetRaceStartTimer;
new streetRacePlayers;
new streetRaceTimerToEnd;
new streetRacePositionIndex = 1;
new streetRacePlayerColorChange[MAX_PLAYERS];
new cmn1PlayerColorChange[MAX_PLAYERS];
new bool: streetRaceStarted = false;
new bool: playerInStreetRace[MAX_PLAYERS];

enum streetRaceInfo
{
    stTypeName[50],
        stWinner[50],
        stWinTime
}
new StreetRaceInfo[MAX_RACES][streetRaceInfo] = {
    {
        "Invalid"
    },
    {
        "Sprint"
    },
    {
        "Drift"
    },
    {
        "Drag"
    },
    {
        "Laps"
    },
    {
        "Offroad"
    }
};

/*
* Deathmatch
*/
new deathmatchEndTimer;
new deathmatchStartTimer;
new deathmatchPlayers;
new deathmatchKills[MAX_PLAYERS];
new bool: deathmatchStarted = false;
new deathmatchFightArea;
new deathmatchGun;
new bool:playerInDeathmatch[MAX_PLAYERS] = false;

/*
* MoneyBox
*/
new allMoneyBoxCheckPoints = 4;
new allMoneyBoxDeliverPoints = 4;
new bool: playerWithMoneyBox[MAX_PLAYERS];
new bool: isMoneyBoxGet = false;
new whoHaveMoneyBox = -1;
new bool: lostMoneyBox;
new moneyBoxCPID;
new moneyBoxDPID;
new mbgetedpos = 0;

/*
* MISSION
*/
new missionActive = MISSION_NONE;

/*
* CMN1
*/
new cmn1Money;
new cmn1[MAX_PLAYERS] = 0;
new cmn1Mission[MAX_PLAYERS] = MISSION_NONE;

