#include <YSI_Coding\y_hooks>

/*
* Turfing
*/
stock PlayerLeaveTurfAttackZone(playerid)
{
    if (isTurfMember[playerid] == true && isGangAttackingTurf[PlayerInfo[playerid][pTeam]] == true)
    {
        startturf = 0;
        new attackerFaction = PlayerInfo[playerid][pTeam];
        new turfAttacked = TeamInfo[attackerFaction][tTurfAttacked];
        new turfOwner = TurfInfo[turfAttacked][TurfOwner];
        format(string256, 256, "[FACTION CHAT] {FF0000}%s{C800FF} Играчът напусна очертанията и отпадна от атака!", GetPlayerNickname(playerid));
        SendFactionMessage(attackerFaction, 0xC800FFFF, string256);
        inTurfAttackMembers[attackerFaction]--;
        isTurfMember[playerid] = false;
        if (inTurfAttackMembers[attackerFaction] == 0)
        {
            format(string256, 256, "Turf War: {FF0000}%s{C800FF} не успя да превземе %s територията на %s!", TeamInfo[attackerFaction][tName], TurfInfo[turfAttacked][TurfName],
                TeamInfo[turfOwner][tName]);
            SendClientMessageToAll(0xC800FFFF, string256);
            FailTurfAttack(attackerFaction);
        }
    }
}

stock DeathInTurfAttack(playerid)
{
    new attackerFaction = PlayerInfo[playerid][pTeam];
    if (isTurfMember[playerid] == true && isGangAttackingTurf[attackerFaction] == true)
    {
        new turfAttacked = TeamInfo[attackerFaction][tTurfAttacked];
        new turfOwner = TurfInfo[turfAttacked][TurfOwner];
        format(string256, 256, "[FACTION CHAT] {FF0000}%s{C800FF} умря и отпадна от атаката на %s!", GetPlayerNickname(playerid), TeamInfo[turfOwner][tName]);
        SendFactionMessage(attackerFaction, 0xC800FFFF, string256);
        inTurfAttackMembers[attackerFaction]--;
        isTurfMember[playerid] = false;
        if (inTurfAttackMembers[attackerFaction] == 0)
        {
            startturf = 0;
            format(string256, 256, "Turf War: {FF0000}%s{C800FF} не успя да превземе %s територията на %s!", TeamInfo[attackerFaction][tName], TurfInfo[turfAttacked][TurfName],
                   TeamInfo[turfOwner][tName]);
            SendClientMessageToAll(0xC800FFFF, string256);
            FailTurfAttack(attackerFaction);
        }
    }
}


stock ExitInTurfAttack(playerid)
{
    new attackerFaction = PlayerInfo[playerid][pTeam];
    if (isTurfMember[playerid] == true && isGangAttackingTurf[attackerFaction] == true)
    {
        new turfAttacked = TeamInfo[attackerFaction][tTurfAttacked];
        new turfOwner = TurfInfo[turfAttacked][TurfOwner];
        format(string256, 256, "[FACTION CHAT] {FF0000}%s{C800FF} излезе от сървъра и отпадна от атаката на %s!", GetPlayerNickname(playerid), TeamInfo[turfOwner][tName]);
        SendFactionMessage(attackerFaction, 0xC800FFFF, string256);
        inTurfAttackMembers[attackerFaction]--;
        if (inTurfAttackMembers[attackerFaction] == 0)
        {
            startturf = 0;
            format(string256, 256, "Turf War: {FF0000}%s{C800FF} не успя да превземе %s територията на %s!", TeamInfo[attackerFaction][tName], TurfInfo[turfAttacked][TurfName],
                   TeamInfo[turfOwner][tName]);
            SendClientMessageToAll(0xC800FFFF, string256);
            FailTurfAttack(attackerFaction);
        }
    }
}

stock FailTurfAttack(attackerFaction)
{
    new turfAttacked = TeamInfo[attackerFaction][tTurfAttacked];
    new turfOwner = TurfInfo[turfAttacked][TurfOwner];
    TurfInfo[turfAttacked][TurfWarGang] = 0;
    GangZoneStopFlashForAll(turfAttacked);
    TeamInfo[attackerFaction][tTurfAttacked] = 0;
    turfAttackTimer[attackerFaction] = 0;
}

/*
* Location
*/
public IsPlayerInAttackedTurf(playerid)
{
    new playerFaction = PlayerInfo[playerid][pTeam];
    if (isGangAttackingTurf[playerFaction] == true)
    {
        new attackedTurf = TeamInfo[playerFaction][tTurfAttacked];
        if (IsPlayerInTurf(playerid, TurfInfo[attackedTurf][zMinX], TurfInfo[attackedTurf][zMinY], TurfInfo[attackedTurf][zMaxX], TurfInfo[attackedTurf][zMaxY])) return 1;
    }
    return 0;
}

public IsPlayerInTurf(playerid, Float:min_x, Float:min_y, Float:max_x, Float:max_y)
{
    new Float:X3, Float:Y3, Float:Z3;
    GetPlayerPos(playerid, X3, Y3, Z3);
    if ((X3 <= max_x && X3 >= min_x) && (Y3 <= max_y && Y3 >= min_y)) return 1;
    return 0;
}

/*
* Show Turfs for Player
*/

stock ShowPlayerTurfs(playerid)
{
    new turfWarGang;
    new turfOwner;
    for (new t = 0; t < MAX_TURFS; t++)
    {
        turfWarGang = TurfInfo[t][TurfWarGang];
        turfOwner = TurfInfo[t][TurfOwner];
        if (turfWarGang > 0)
        {
            GangZoneCreate(TurfInfo[t][zMinX], TurfInfo[t][zMinY], TurfInfo[t][zMaxX], TurfInfo[t][zMaxY]);
            GangZoneShowForPlayer(playerid, t, TeamInfo[turfOwner][tTCOLOR]);
            GangZoneFlashForPlayer(playerid, t, TeamInfo[turfWarGang][tTCOLOR]);
        }
        if (turfWarGang == 0)
        {
            GangZoneCreate(TurfInfo[t][zMinX], TurfInfo[t][zMinY], TurfInfo[t][zMaxX], TurfInfo[t][zMaxY]);
            GangZoneShowForPlayer(playerid, t, TeamInfo[turfOwner][tTCOLOR]);
        }
    }

}

/*
* On player death
*/
hook OnPlayerDeath(playerid, killerid, reason)
{
    DeathInTurfAttack(playerid);
    PlayerLeaveTurfAttackZone(playerid);
    
    return Y_HOOKS_CONTINUE_RETURN_1;
}