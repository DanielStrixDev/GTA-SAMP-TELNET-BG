#include <YSI_Coding\y_hooks>

stock SetPlayerVipLaser(playerid)
{
    if (PlayerInfo[playerid][pLaser] == 1)
    {
        if (objectright[playerid] == 0)
        {
            objectright[playerid] = 1;
        }
    }

    RestartVIPLaser(playerid);
}

stock SetPlayerFightStyle(playerid)
{
    if (PlayerInfo[playerid][pStyle] == 0)
    {
        SetPlayerFightingStyle(playerid, FIGHT_STYLE_NORMAL);
    }
    if (PlayerInfo[playerid][pStyle] == 1)
    {
        SetPlayerFightingStyle(playerid, FIGHT_STYLE_GRABKICK);
    }
    if (PlayerInfo[playerid][pStyle] == 2)
    {
        SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING);
    }
    if (PlayerInfo[playerid][pStyle] == 3)
    {
        SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU);
    }
    if (PlayerInfo[playerid][pStyle] == 4)
    {
        SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD);
    }
    if (PlayerInfo[playerid][pStyle] == 5)
    {
        SetPlayerFightingStyle(playerid, FIGHT_STYLE_ELBOW);
    }
}

stock GivePlayerWeaponSkillGuns(playerid)
{
    if (PlayerInfo[playerid][pWeaponS] == 1)
    {
        GivePlayerWeapon(playerid, 23, 30);
        GivePlayerWeapon(playerid, 25, 50);
        GivePlayerWeapon(playerid, 29, 100);
        GivePlayerWeapon(playerid, 30, 60);
    }
    if (PlayerInfo[playerid][pWeaponS] == 2)
    {
        GivePlayerWeapon(playerid, 23, 50);
        GivePlayerWeapon(playerid, 25, 70);
        GivePlayerWeapon(playerid, 29, 200);
        GivePlayerWeapon(playerid, 30, 100);
    }
    if (PlayerInfo[playerid][pWeaponS] == 3)
    {
        GivePlayerWeapon(playerid, 23, 80);
        GivePlayerWeapon(playerid, 25, 80);
        GivePlayerWeapon(playerid, 29, 250);
        GivePlayerWeapon(playerid, 30, 150);
    }
    if (PlayerInfo[playerid][pWeaponS] == 4)
    {
        GivePlayerWeapon(playerid, 23, 100);
        GivePlayerWeapon(playerid, 25, 100);
        GivePlayerWeapon(playerid, 29, 300);
        GivePlayerWeapon(playerid, 30, 200);
    }
    if (PlayerInfo[playerid][pWeaponS] == 5)
    {
        GivePlayerWeapon(playerid, 22, 80);
        GivePlayerWeapon(playerid, 27, 50);
        GivePlayerWeapon(playerid, 28, 200);
        GivePlayerWeapon(playerid, 31, 70);
        GivePlayerWeapon(playerid, 5, 1);
    }
    if (PlayerInfo[playerid][pWeaponS] == 6)
    {
        GivePlayerWeapon(playerid, 22, 80);
        GivePlayerWeapon(playerid, 27, 70);
        GivePlayerWeapon(playerid, 28, 300);
        GivePlayerWeapon(playerid, 31, 100);
        GivePlayerWeapon(playerid, 33, 20);
        GivePlayerWeapon(playerid, 5, 1);
    }
    if (PlayerInfo[playerid][pWeaponS] == 7)
    {
        GivePlayerWeapon(playerid, 22, 100);
        GivePlayerWeapon(playerid, 27, 100);
        GivePlayerWeapon(playerid, 28, 500);
        GivePlayerWeapon(playerid, 31, 200);
        GivePlayerWeapon(playerid, 33, 40);
        GivePlayerWeapon(playerid, 5, 1);
    }
    if (PlayerInfo[playerid][pWeaponS] == 8)
    {
        GivePlayerWeapon(playerid, 24, 30);
        GivePlayerWeapon(playerid, 26, 50);
        GivePlayerWeapon(playerid, 32, 200);
        GivePlayerWeapon(playerid, 31, 100);
        GivePlayerWeapon(playerid, 34, 30);
        GivePlayerWeapon(playerid, 5, 1);
    }
    if (PlayerInfo[playerid][pWeaponS] == 9)
    {
        GivePlayerWeapon(playerid, 24, 50);
        GivePlayerWeapon(playerid, 26, 80);
        GivePlayerWeapon(playerid, 32, 300);
        GivePlayerWeapon(playerid, 31, 200);
        GivePlayerWeapon(playerid, 34, 40);
        GivePlayerWeapon(playerid, 5, 1);
    }
    if (PlayerInfo[playerid][pWeaponS] == 10)
    {
        GivePlayerWeapon(playerid, 24, 100);
        GivePlayerWeapon(playerid, 26, 100);
        GivePlayerWeapon(playerid, 32, 500);
        GivePlayerWeapon(playerid, 31, 300);
        GivePlayerWeapon(playerid, 34, 50);
        GivePlayerWeapon(playerid, 4, 1);
    }
}

stock GivePlayerVipWeapons(playerid)
{
    if (PlayerInfo[playerid][pVip] == 5 || CheckFreeVIP() == 1)
    {
        if (PlayerInfo[playerid][pChantichki] == 0)
        {
            GivePlayerWeapon(playerid, 16, 5);
        }
        else
        {
            GivePlayerWeapon(playerid, 39, 5);
        }
    }
    if (PlayerInfo[playerid][pVip] == 6 || CheckFreeVIP() == 1)
    {
        if (PlayerInfo[playerid][pChantichki] == 0)
        {
            GivePlayerWeapon(playerid, 16, 5);
        }
        else
        {
            GivePlayerWeapon(playerid, 39, 5);
        }
    }
}

/*
* Player Editing object for example parrot
*/
public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
    new Float:oldX, Float:oldY, Float:oldZ, Float:oldRotX, Float:oldRotY, Float:oldRotZ;
    GetObjectPos(objectid, oldX, oldY, oldZ);
    GetObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
    if (!playerobject)
    {
        if (!IsValidObject(objectid)) return 1;
        SetObjectPos(objectid, fX, fY, fZ);
        SetObjectRot(objectid, fRotX, fRotY, fRotZ);
    }
    if (response == EDIT_RESPONSE_FINAL)
    {
        //if(attachedPlayerObject[objectid]==true)
        //{
        SetObjectPos(objectid, fX, fY, fZ);
        SetObjectRot(objectid, fRotX, fRotY, fRotZ);
        //}
    }
    if (response == EDIT_RESPONSE_FINAL)
    {
        //	if(objectid==objectut[playerid])
        //	{
        //		AttachObjectToVehicle(objectut[playerid], GetPlayerVehicleID(playerid), fX, fY, fZ, fRotX, fRotY, fRotZ);
        //	}
    }
    if (response == EDIT_RESPONSE_CANCEL)
    {
        //The player cancelled, so put the object back to it's old position
        if (!playerobject) //Object is not a playerobject
        {
            SetObjectPos(objectid, oldX, oldY, oldZ);
            SetObjectRot(objectid, oldRotX, oldRotY, oldRotZ);
        }
        else
        {
            SetPlayerObjectPos(playerid, objectid, oldX, oldY, oldZ);
            SetPlayerObjectRot(playerid, objectid, oldRotX, oldRotY, oldRotZ);
        }
    }
    return 1;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid,
                                  Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ,
                                  Float:fRotX, Float:fRotY, Float:fRotZ,
                                  Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
    SetPlayerAttachedObject(playerid, index, modelid, boneid, fOffsetX, fOffsetY, fOffsetZ, fRotX, fRotY, fRotZ, fScaleX, fScaleY, fScaleZ);
    if (index == 9)
    {
        SendClientMessage(playerid, 0x33AA33FF, "SERVER:      !");
    }
    return 1;
}

/*
* Player Update
*/
hook OnPlayerUpdate(playerid)
{
    /*
    * Anti Spawn Fire
    */
    if (IsPlayerInRangeOfPoint(playerid, 250.0, 1204.3077, -2066.5664, 84.7134) && PlayerInfo[playerid][pIPDDuty] == 0) // VIP Gang Spawn
    {
        GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~TI SI BLIZO DO ~r~VIP BAZATA ~n~~w~I NE MOJESH DA POLZVASH ORUJIQ", 2000, 3);
        SetPlayerArmedWeapon(playerid, 0);
    }

    /*
    * Flying
    */
    new Float:x, Float:y, Float:z, Float:angle;
    new keys, updown, leftright;
    if (fly[playerid] == 1)
    {
        GetPlayerKeys(playerid, keys, updown, leftright);
        if (updown == KEY_UP)
        {
            if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
            {
                GetPlayerPos(playerid, x, y, z);
                GetXYInFrontOfPlayer(playerid, x, y, 5.0);
                SetPlayerPos(playerid, x, y, z);
                SetCameraBehindPlayer(playerid);
            }
            else if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                new playercar = GetPlayerVehicleID(playerid);
                GetVehiclePos(playercar, x, y, z);
                GetXYInFrontOfPlayer(playerid, x, y, 5.0);
                SetVehiclePos(playercar, x, y, z);
            }
        }
        else if (updown == KEY_DOWN)
        {
            if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
            {
                GetPlayerPos(playerid, x, y, z);
                GetXYBehindPlayer(playerid, x, y, 5.0);
                SetPlayerPos(playerid, x, y, z);
                SetCameraBehindPlayer(playerid);
            }
            else if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                new playercar = GetPlayerVehicleID(playerid);
                GetVehiclePos(playercar, x, y, z);
                GetXYBehindPlayer(playerid, x, y, 5.0);
                SetVehiclePos(playercar, x, y, z);
            }
        }
        if (leftright == KEY_LEFT)
        {
            if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
            {
                GetPlayerFacingAngle(playerid, angle);
                SetPlayerFacingAngle(playerid, angle + 10);
                SetCameraBehindPlayer(playerid);
            }
            else if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                new playercar = GetPlayerVehicleID(playerid);
                GetVehicleZAngle(playercar, angle);
                SetVehicleZAngle(playercar, angle + 10);
            }
        }
        else if (leftright == KEY_RIGHT)
        {
            if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
            {
                GetPlayerFacingAngle(playerid, angle);
                SetPlayerFacingAngle(playerid, angle - 10);
                SetCameraBehindPlayer(playerid);
            }
            else if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                new playercar = GetPlayerVehicleID(playerid);
                GetVehicleZAngle(playercar, angle);
                SetVehicleZAngle(playercar, angle - 10);
            }
        }
        if (keys == KEY_JUMP)
        {
            if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
            {
                GetPlayerPos(playerid, x, y, z);
                SetPlayerPos(playerid, x, y, z + 5);
                SetCameraBehindPlayer(playerid);
            }
            else if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                new playercar = GetPlayerVehicleID(playerid);
                GetVehiclePos(playercar, x, y, z);
                SetVehiclePos(playercar, x, y, z + 5);
            }
        }
        else if (keys == KEY_SPRINT)
        {
            if (GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
            {
                GetPlayerPos(playerid, x, y, z);
                SetPlayerPos(playerid, x, y, z - 5);
                SetCameraBehindPlayer(playerid);
            }
            else if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
            {
                new playercar = GetPlayerVehicleID(playerid);
                GetVehiclePos(playercar, x, y, z);
                SetVehiclePos(playercar, x, y, z - 5);
            }
        }
    }

    /*
    * Checks FPS Based on drug level
    */
    new drunknew;
    drunknew = GetPlayerDrunkLevel(playerid);
    if (drunknew < 100)
    {
        SetPlayerDrunkLevel(playerid, 2000);
    }
    else
    {
        if (pDrunkLevelLast[playerid] != drunknew)
        {
            new wfps = pDrunkLevelLast[playerid] - drunknew;
            if ((wfps > 0) && (wfps < 200))
                pFPS[playerid] = wfps;
            pDrunkLevelLast[playerid] = drunknew;
        }
    }

    /*
    * Speedo meter
    */
    if (GetPlayerVehicleID(playerid) > -1)
    {
        if (objectright[playerid] == 1)
        {
            objectright[playerid] = 0;
            RemovePlayerAttachedObject(playerid, 0);
        }
        GetVehicleHealth(GetPlayerVehicleID(playerid), vehhealth[playerid]);
        if (GetVehicleModel(GetPlayerVehicleID(playerid)) != 481 &&
                GetVehicleModel(GetPlayerVehicleID(playerid)) != 509 &&
                GetVehicleModel(GetPlayerVehicleID(playerid)) != 510 &&
                GetVehicleModel(GetPlayerVehicleID(playerid)) != 481)
        {
            if (speedo[playerid] == 0)
            {
                if (kmh[playerid] == 0)
                {
                    format(stringvehicle[playerid], 115, "~w~Speed: %dkm/h~n~~g~Health: %.0f~n~~r~Fuel: %dL", GetVehicleKmh(GetPlayerVehicleID(playerid)), vehhealth[playerid], vehfuel[GetPlayerVehicleID(playerid)]);
                    TextDrawSetString(vehstatus[playerid], stringvehicle[playerid]);
                }
                else
                {
                    new vehicleid, Float:speed_x, Float:speed_y, Float:speed_z, final_speed_int;
                    vehicleid = GetPlayerVehicleID(playerid);
                    GetVehicleVelocity(vehicleid, speed_x, speed_y, speed_z);
                    final_speed_int = GetVehicleKmh(vehicleid);
                    format(stringvehicle[playerid], 115, "~w~Speed: %dm/s~n~~g~Health: %.0f~n~~r~Fuel: %dL", final_speed_int, vehhealth[playerid], vehfuel[GetPlayerVehicleID(playerid)]);
                    TextDrawSetString(vehstatus[playerid], stringvehicle[playerid]);
                }
            }
        }
        else
        {
            if (speedo[playerid] == 0)
            {
                if (kmh[playerid] == 0)
                {
                    format(stringvehicle[playerid], 115, "~w~Speed: %dkm/h~n~~g~Health: %.0f", GetVehicleKmh(GetPlayerVehicleID(playerid)), vehhealth[playerid]);
                    TextDrawSetString(vehstatus[playerid], stringvehicle[playerid]);
                }
                else
                {
                    new vehicleid, Float:speed_x, Float:speed_y, Float:speed_z, final_speed_int;
                    vehicleid = GetPlayerVehicleID(playerid);
                    GetVehicleVelocity(vehicleid, speed_x, speed_y, speed_z);
                    final_speed_int = GetVehicleKmh(vehicleid);
                    format(stringvehicle[playerid], 115, "~w~Speed: %dm/s~n~~g~Health: %.0f", final_speed_int, vehhealth[playerid]);
                    TextDrawSetString(vehstatus[playerid], stringvehicle[playerid]);
                }
            }
        }
    }

    /*
    * Checks if laser to be activated
    */
    if (!IsPlayerInAnyVehicle(playerid))
    {
        if (PlayerInfo[playerid][pLaser] == 1)
        {
            if (PlayerInfo[playerid][pVip] > 3 || CheckFreeVIP() == 1)
            {
                if (objectright[playerid] == 0)
                {
                    objectright[playerid] = 1;
                }
                RemovePlayerAttachedObject(playerid, 0);
                if ((IsPlayerInAnyVehicle(playerid)) || (IsPlayerInWater(playerid))) return 1;
                switch (GetPlayerWeapon(playerid))
                {
                    case 31:
                    {
                        if (IsPlayerAiming(playerid))
                        {
                            if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
                            {
                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 standing aiming
                                                        0.528249, -0.020266, 0.068052, -6.621746, 352.552642, 355.084289);
                            }
                            else
                            {
                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 crouched aiming
                                                        0.528249, -0.020266, 0.068052, -1.621746, 356.202667, 355.084289);
                            }
                        }
                        else
                        {
                            if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
                            {
                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 standing not aiming
                                                        0.503249, -0.02376, 0.065051, -11.131746, 357.302734, 354.484222);
                            }
                            else
                            {
                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // M4 crouched not aiming
                                                        0.503249, -0.02376, 0.065051, -11.131746, 357.302734, 354.484222);
                            }
                        }
                    }
                    case 29:
                    {
                        if (IsPlayerAiming(playerid))
                        {
                            if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
                            {
                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 standing aiming
                                                        0.298249, -0.02776, 0.158052, -11.631746, 359.302673, 357.584259);
                            }
                            else
                            {
                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 crouched aiming
                                                        0.298249, -0.02776, 0.158052, 8.368253, 358.302673, 352.584259);
                            }
                        }
                        else
                        {
                            if (GetPlayerSpecialAction(playerid) != SPECIAL_ACTION_DUCK)
                            {
                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 standing not aiming
                                                        0.293249, -0.027759, 0.195051, -12.131746, 354.302734, 352.484222);
                            }
                            else
                            {
                                SetPlayerAttachedObject(playerid, 0, GetPVarInt(playerid, "color"), 6, // MP5 crouched not aiming
                                                        0.293249, -0.027759, 0.195051, -12.131746, 354.302734, 352.484222);
                            }
                        }
                    }
                }
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

/*
* Add player stats vars
*/
hook OnPlayerConnect(playerid)
{
    /*
    * General functions
    */
    PlayerJoins(playerid);

    //spawned[playerid] = 1;
    towTruckSkin[playerid] = false;
    SetPlayerVirtualWorld(playerid, 0);

    /*
    * Based on stats
    */
    ShowPlayerTurfs(playerid);
    SetPlayerFightStyle(playerid);
    SetPlayerVipLaser(playerid);
    GivePlayerWeaponSkillGuns(playerid);
    GivePlayerVipWeapons(playerid);

    /*
    * Faction functions
    */
    RestartPlayerColor(playerid);
    RestartPlayerSkin(playerid);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

/*
* Anti RCON Login
*/
hook OnRconLoginAttempt(ip[], password[], success)
{
    if (!success)
    {
        new pip[30];
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            GetPlayerIp(i, pip, 30);
            if (!strcmp(ip, pip, true))
            {
                SendClientMessage(i, 0xE60000FF, "SERVER: Ти се опита да влезеш с RCON паролата на сървъра и сега си KICKED!");
                PlayerInfo[i][pKick] = 1;
            }
        }
    }
    return Y_HOOKS_CONTINUE_RETURN_1;
}

/*
* Player Class Selection
*/


public OnPlayerRequestClass(playerid, classid)
{

    firstskin[playerid] = classid;
    SetPVarInt(playerid, "color", 0);
    switch (classid)
    {
        case 0..2:
        {
            SetPlayerPos(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerCameraPos(playerid, 2179.9398, 1284.6965, 43.4799);
            SetPlayerCameraLookAt(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerFacingAngle(playerid, 88.68);
            GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~Drug Dealer", 2300, 3);
        }
        case 3..6:
        {
            SetPlayerPos(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerCameraPos(playerid, 2179.9398, 1284.6965, 43.4799);
            SetPlayerCameraLookAt(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerFacingAngle(playerid, 88.68);
            GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~Drug Maker", 2300, 3);
        }
        case 7..10:
        {
            SetPlayerPos(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerCameraPos(playerid, 2179.9398, 1284.6965, 43.4799);
            SetPlayerCameraLookAt(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerFacingAngle(playerid, 88.68);
            GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Normal Ped Man", 2300, 3);
        }
        case 11..12:
        {
            SetPlayerPos(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerCameraPos(playerid, 2179.9398, 1284.6965, 43.4799);
            SetPlayerCameraLookAt(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerFacingAngle(playerid, 88.68);
            GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Normal Ped Woman", 2300, 3);
        }
        case 13:
        {
            SetPlayerPos(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerCameraPos(playerid, 2179.9398, 1284.6965, 43.4799);
            SetPlayerCameraLookAt(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerFacingAngle(playerid, 88.68);
            GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~BUSSINESMAN", 2300, 3);
        }
        case 14:
        {
            SetPlayerPos(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerCameraPos(playerid, 2179.9398, 1284.6965, 43.4799);
            SetPlayerCameraLookAt(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerFacingAngle(playerid, 88.68);
            GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~BUSSINESWOMAN", 2300, 3);
        }
        case 15..17:
        {
            SetPlayerPos(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerCameraPos(playerid, 2179.9302, 1284.6965, 43.4799);
            SetPlayerCameraLookAt(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerFacingAngle(playerid, 88.68);
            GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~p~PROSTITUTE", 2300, 3);
        }
        case 18..23:
        {
            SetPlayerPos(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerCameraPos(playerid, 2179.9398, 1284.6965, 43.4799);
            SetPlayerCameraLookAt(playerid, 2183.4976, 1284.9148, 43.0672);
            SetPlayerFacingAngle(playerid, 88.68);
            GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~p~WOMAN", 2300, 3);
        }
    }
    return 1;
}


stock DestroyPlayerRampObject(playerid)
{
    DestroyDynamicObject(rampobject[playerid]);
}

stock UnlockLockedPlayerVeh(playerid)
{
    if (vehLocker[playerid] != -1)
    {
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            SetVehicleParamsForPlayer(vehLocker[playerid], i, 0, 0);
        }
    }
    else
    {
        vehLocker[playerid] = -1;
    }
}

stock RemoveVarDriver(playerid)
{
    if (GetPlayerVehicleID(playerid) > -1)
    {
        drive[GetPlayerVehicleID(playerid)] = 0;
    }
}

stock DeletePlayer3DText(playerid)
{
    format(adminprefix[playerid], 35, "");
    format(adminprefix[playerid], 35, "");
    format(viptextformat[playerid], 35, "");
    format(stringvehicle[playerid], 115, "");

    /*
    * Reset VIP and Admin Label
    */
    if (PlayerInfo[playerid][pADuty] == 1)
    {
        UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, " ");
    }
    if (PlayerInfo[playerid][pVIPLabel] == 1)
    {
        UpdateDynamic3DTextLabelText(PlayerLabel[playerid], 0x800000FF, " ");
    }
}

stock PlayerExitRobbery(playerid)
{
    if (PlayerInfo[playerid][pRobberLead] == 1)
    {
        PlayerInfo[playerid][pRobber] = 0;
        PlayerInfo[playerid][pRobberLead] = 0;
        GameTextForPlayer(playerid, "   ", 1000, 3);
        for (new i; i < MAX_PLAYERS; i++)
        {
            if (PlayerInfo[i][pRobber] == 1)
            {
                GameTextForPlayer(i, "   ", 1000, 3);
                PlayerInfo[i][pRobber] = 0;
            }
        }
        if (inevent[playerid] == 1)
        {
            eventmembers -= 1;
        }
        robberyMembers = 0;
        robCollectedMoney = 0;
        startedrob = 0;
        robberyTimerToCollect = 0;
        robberyPlace = 0;
        robberyToStopTimer = 0;
        SendClientMessageToAll(0xFF8200FF, "Robbery: Обирът се спира автоматично, защото лидерът излезе от сървъра !");
    }
}

stock ResetPlayerDuel(playerid)
{
    if (playerInDuel[playerid] == 1)
    {
        RestartPlayerColor(duelprotivnik[playerid]);
        new stringduel[256];
        GivePlayerCash(playerid, -duelzalog[playerid]);
        GivePlayerCash(duelprotivnik[playerid], duelzalog[playerid]);
        PlayerInfo[duelprotivnik[playerid]][pDuelCountTimer] = 0;
        PlayerInfo[duelprotivnik[playerid]][pDuelCountTimer2] = 0;
        PlayerInfo[duelprotivnik[playerid]][pDuelCountTimer3] = 0;
        PlayerInfo[duelprotivnik[playerid]][pDuelCountTimer4] = 0;
        format(stringduel, 256, "Duel: Ти победи служебно, защото %s излезе от сървъра и получаваш $%d от залога", GetPlayerNickname(playerid), duelzalog[playerid]);
        SendClientMessage(duelprotivnik[playerid], 0xFFE400FF, stringduel);
        duelzalog[duelprotivnik[playerid]] = 0;
        SetPlayerPos(duelprotivnik[duelprotivnik[playerid]], prediduelX[duelprotivnik[playerid]], prediduelY[duelprotivnik[playerid]], prediduelZ[duelprotivnik[playerid]]);
        SetPlayerHealth(duelprotivnik[playerid], prediduelhealth[duelprotivnik[playerid]]);
        SetPlayerArmour(duelprotivnik[playerid], prediduelarmour[duelprotivnik[playerid]]);
        SetPlayerInterior(duelprotivnik[playerid], prediduelinterior[duelprotivnik[playerid]]);
        SetPlayerVirtualWorld(duelprotivnik[playerid], prediduelvw[duelprotivnik[playerid]]);
        duelsend[duelprotivnik[playerid]] = -1;
        duelsender[duelprotivnik[playerid]] = -1;
        duelprotivnik[duelprotivnik[playerid]] = -1;
    }
    if (duelsend[playerid] > -1)
    {
        new stringDuel[256];
        format(stringDuel, 256, "Duel: %s излезе от сървъра и поканата за дуел е отменена", GetPlayerNickname(duelsender[duelsend[playerid]]));
        SendClientMessage(duelsender[playerid], 0xFFE400FF, stringDuel);
        duelsend[playerid] = -1;
        playerInDuel[duelsend[playerid]] = 0;
        duelsender[duelsend[playerid]] = -1;
    }
    if (duelsender[playerid] > -1)
    {
        new stringDuel[256];
        format(stringDuel, 256, "Duel: %s излезе от сървъра и поканата за дуел е отменена", GetPlayerNickname(playerid));
        SendClientMessage(duelsender[playerid], 0xFFE400FF, stringDuel);
        duelsender[playerid] = -1;
        playerInDuel[duelsender[playerid]] = 0;
        duelsend[duelsender[playerid]] = -1;
    }
}

stock ResetPlayerHitman(playerid)
{
    if (hitmanby[playerid] != -1)
    {
        format(string256, 256, "Hitman: %s излезе от сървъра и цената за главата му е отменена", GetPlayerNickname(playerid));
        SendClientMessageToAll(0xA4A400FF, string256);
        GivePlayerCash(hitmanby[playerid], hitmanprice[playerid]);
        hitmaner[hitmanby[playerid]] = -1;
    }
    if (hitmaner[playerid] != -1)
    {
        format(string256, 256, "Hitman: %s излезе от сървъра и цената за главата на %s е отменена", GetPlayerNickname(playerid), GetPlayerNickname(hitmaner[playerid]));
        SendClientMessageToAll(0xA4A400FF, string256);
        GivePlayerCash(hitmaner[playerid], hitmanprice[para1[playerid]]);
        hitmanby[hitmaner[playerid]] = -1;
    }
}

stock ResetPlayerBizSell(playerid)
{
    if (bizSwitchSender[playerid] != -1)
    {
        new stringSender[256];
        new sendedBizInviteID = bizSwitchSender[playerid];
        bizSwitchReceiver[sendedBizInviteID] = -1;
        bizSwitching[sendedBizInviteID] = false;
        format(stringSender, 256, "%s излезе от сървъра и поканата му за размяна на бизнеси отпадна", GetPlayerNickname(playerid));
        SendClientMessage(sendedBizInviteID, 0x00CCCCFF, stringSender);
    }
    if (bizSwitchReceiver[playerid] != -1)
    {
        new stringReceiver[256];
        new receivedBizInviteID = bizSwitchReceiver[playerid];
        bizSwitchSender[receivedBizInviteID] = -1;
        bizSwitching[receivedBizInviteID] = false;
        format(stringReceiver, 256, "%s излезе от сървъра и поканата ти за размяна на бизнеси отпадна", GetPlayerNickname(playerid));
        SendClientMessage(receivedBizInviteID, 0x00CCCCFF, stringReceiver);
    }
}

stock ResetPlayerHouseSell(playerid)
{
    if (houseSellSender[playerid] != -1)
    {
        new stringSender[256];
        new sendedHouseInviteID = houseSellSender[playerid];
        houseSellReceiver[sendedHouseInviteID] = -1;
        houseSelling[sendedHouseInviteID] = false;
        format(stringSender, 256, "%s излезе от сървъра и поканата му за продажба на къща отпадна", GetPlayerNickname(playerid));
        SendClientMessage(sendedHouseInviteID, 0x00FF40FF, stringSender);
    }
    if (houseSellReceiver[playerid] != -1)
    {
        new stringReceiver[256];
        new receivedHouseInviteID = houseSellReceiver[playerid];
        houseSellSender[receivedHouseInviteID] = -1;
        houseSelling[receivedHouseInviteID] = false;
        format(stringReceiver, 256, "%s излезе от сървъра и поканата ти за продажба на къща отпадна", GetPlayerNickname(playerid));
        SendClientMessage(receivedHouseInviteID, 0x00FF40FF, stringReceiver);
    }
    if (houseSwitchSender[playerid] != -1)
    {
        new stringSender[256];
        new sendedHouseInviteID = houseSwitchSender[playerid];
        houseSwitchReceiver[sendedHouseInviteID] = -1;
        houseSwitching[sendedHouseInviteID] = false;
        format(stringSender, 256, "%s излезе от сървъра и поканата му за размяна на къщи отпадна", GetPlayerNickname(playerid));
        SendClientMessage(sendedHouseInviteID, 0x00FF40FF, stringSender);
    }
    if (houseSwitchReceiver[playerid] != -1)
    {
        new stringReceiver[256];
        new receivedHouseInviteID = houseSwitchReceiver[playerid];
        houseSwitchSender[receivedHouseInviteID] = -1;
        houseSwitching[receivedHouseInviteID] = false;
        format(stringReceiver, 256, "%s излезе от сървъра и поканата ти за размяна на къщи отпадна", GetPlayerNickname(playerid));
        SendClientMessage(receivedHouseInviteID, 0x00FF40FF, stringReceiver);
    }
}

stock SendLeaveServerMessage(playerid)
{
    if (ingmx == 0)
    {
        if (hideexitserver[playerid] == 0)
        {
            new noerrorstring2[115];
            format(noerrorstring2, 115, "%s {FFFFFF}излезе от сървъра !", GetPlayerNickname(playerid));
            SendClientMessageToAll(0xFF1400FF, noerrorstring2);
        }
    }
}

/*
* Respawn Timer
*/
public ReSpawnTimer(playerid)
{
    requestspawn2[playerid] = 0;
    SpawnPlayer(playerid);
    return 1;
}

/*
* Player Join Server
*/
stock PlayerJoins(playerid)
{
    ResetPlayerStats(playerid);
    CreateDMONText(playerid);
    LoadPlayerTexts(playerid);
    CheckPlayerForBlock(playerid);

    // Check if server is restarting soon
    if (serverrestarttimer > 0)
    {
        TextDrawShowForPlayer(playerid, RESTART);
    }

    // Check if player is blocked from the server
    if (PlayerInfo[playerid][pWarns] > 4 || PlayerInfo[playerid][pBlock] == 1)
    {
        SendClientMessage(playerid, 0xE60000FF, "Този акаунт е баннат от сървъра!");
        PlayerInfo[playerid][pKick] = 1;
        ForceClassSelection(playerid);
        return 1;
    }

    // Player joins the server
    SendClientMessage(playerid, 0xFFFF00FF, "Добре Дошъл в {FFFFFF}[> GTAINT <] {40BF00}[O-F-F-I-C-I-A-L] {FF0000}[0.3.7] {FFFFFF}[Версия: 1.5 © sTrIx 2026 - official site soon]");
    TogglePlayerSpectating(playerid, true);
    ForceClassSelection(playerid);
    PlayerInfo[playerid][pStartIntro] = 1;
    PlayAudioStreamForPlayer(playerid, audiostreams[random(sizeof(audiostreams))]);
    RemoveBuildingsForPlayer(playerid);
    AddMapIconsForPlayer(playerid);
    GetPlayerCurrentIP(playerid);
    return 1;
}

/*
* Player disconnects from the server
*/
hook OnPlayerDisconnect(playerid, reason)
{
    if (IsPlayerConnected(playerid))
    {
        SavePlayerStats(playerid);
        UnlockLockedPlayerVeh(playerid);
        DestroyPlayerRampObject(playerid);
        DeletePlayer3DText(playerid);
        RemoveVarDriver(playerid);

        // Player Exit Functions
        ExitWithCMN1(playerid);
        ExitInTurfAttack(playerid);
        LeaveStreetRace(playerid);
        PlayerLeaveDerby(playerid);
        LeaveDeathmatch(playerid);
        PlayerExitRobbery(playerid);

        // Resets player stats
        ResetPlayerStats(playerid);
        ResetPlayerHouseSell(playerid);
        ResetPlayerBizSell(playerid);
        ResetPlayerHitman(playerid);
        ResetPlayerDuel(playerid);

        // Messages
        SendLeaveServerMessage(playerid);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}