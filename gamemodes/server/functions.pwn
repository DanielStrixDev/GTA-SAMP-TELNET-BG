#include <YSI_Coding\y_hooks>

/*
* GENERAL
*/
/*stock IsNull(const string[])
{
    return string[0] == '\0' || string[0] == ' ';
}*/

strtok(const string[], & index)
{
    new length = strlen(string);
    while ((index < length) && (string[index] <= ' '))
    {
        index++;
    }
    new offset = index;
    new result[20];
    while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1)))
    {
        result[index - offset] = string[index];
        index++;
    }
    result[index - offset] = EOS;
    return result;
}
IsNumeric(const string[])
{
    for (new i = 0, j = strlen(string); i < j; i++)
    {
        if (string[i] > '9' || string[i] < '0') return 0;
    }
    return 1;
}
ReturnUser(text[], playerid = INVALID_PLAYER_ID)
{
    new pos = 0;
    while (text[pos] < 0x21)
    {
        if (text[pos] == 0) return INVALID_PLAYER_ID;
        pos++;
    }
    new userid = INVALID_PLAYER_ID;
    if (IsNumeric(text[pos]))
    {
        userid = strval(text[pos]);
        if (userid >= 0 && userid < MAX_PLAYERS)
        {
            if (!IsPlayerConnected(userid))
            {
                userid = INVALID_PLAYER_ID;
            }
            else
            {
                return userid;
            }
        }
    }
    new len = strlen(text[pos]);
    new name[MAX_PLAYER_NAME];
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            GetPlayerName(i, name, sizeof(name));
            if (strcmp(name, text[pos], true, len) == 0)
            {
                if (len == strlen(name))
                {
                    return i;
                }
                else
                {
                    returnUsersCount++;
                    userid = i;
                }
            }
        }
    }
    if (returnUsersCount != 1)
    {
        if (playerid != INVALID_PLAYER_ID)
        {
            if (returnUsersCount)
            {
                SendClientMessage(playerid, 0xFF0000AA, "Multiple users found, please narrow search");
            }
            else
            {
                SendClientMessage(playerid, 0xFF0000AA, "No matching user found");
            }
        }
        userid = INVALID_PLAYER_ID;
    }
    return userid;
}

/*
* RANDOM
*/
stock randomex(min, max)
{
    //Credits to y_less
    new rand = random(max - min) + min;
    return rand;
}

/*
* STRING
*/
stock strreplace(string[], const search[], const replacement[], bool:ignorecase = false, pos = 0, limit = -1, maxlength = sizeof(string))
{
    // No need to do anything if the limit is 0.
    if (limit == 0)
        return 0;
    new sublen = strlen(search),
        replen = strlen(replacement),
        bool:packed = ispacked(string),
        maxlen = maxlength,
        len = strlen(string),
        returnUsersCount5 = 0;
    // "maxlen" holds the max string length (not to be confused with "maxlength", which holds the max. array size).
    // Since packed strings hold 4 characters per array slot, we multiply "maxlen" by 4.
    if (packed)
        maxlen *= 4;
    // If the length of the substring is 0, we have nothing to look for..
    if (!sublen)
        return 0;
    // In this line we both assign the return value from "strfind" to "pos" then check if it's -1.
    while (-1 != (pos = strfind(string, search, ignorecase, pos)))
    {
        // Delete the string we found
        strdel(string, pos, pos + sublen);
        len -= sublen;
        // If there's anything to put as replacement, insert it. Make sure there's enough room first.
        if (replen && len + replen < maxlen)
        {
            strins(string, replacement, pos, maxlength);
            pos += replen;
            len += replen;
        }
        // Is there a limit of number of replacements, if so, did we break it?
        if (limit != -1 && ++returnUsersCount5 >= limit)
            break;
    }
    return returnUsersCount5;
}

/*
* Weapons
*/
stock IsPlayerAiming(playerid)
{
    new anim = GetPlayerAnimationIndex(playerid);
    if (((anim >= 1160) && (anim <= 1163)) || (anim == 1167) || (anim == 1365) ||
            (anim == 1643) || (anim == 1453) || (anim == 220)) return 1;
    return 0;
}

/*
* Objects
*/
stock AddMapIconsForPlayer(playerid)
{
    SetPlayerMapIcon(playerid, 0, 2006.8207, 1167.4012, 10.8203, 55, 0);
    SetPlayerMapIcon(playerid, 1, 1175.7617, -2036.1178, 70.4141, 43, 0);
    SetPlayerMapIcon(playerid, 2, 1786.6913, -1303.6777, 13.7710, 44, 0);
    SetPlayerMapIcon(playerid, 3, 1411.5128, -1699.5909, 13.5395, 55, 0);
    SetPlayerMapIcon(playerid, 4, -1378.5165, 2111.5034, 42.2000, 9, 0);
    SetPlayerMapIcon(playerid, 5, 2127.8530, -87.0102, 2.1304, 51, 0);
    SetPlayerMapIcon(playerid, 6, 852.8712, 851.4919, 13.3516, 51, 0);
    SetPlayerMapIcon(playerid, 7, 587.8735, 1229.1365, 11.7188, 51, 0);
    SetPlayerMapIcon(playerid, 8, 402.0841, 2529.5537, 16.5748, 51, 0);
    SetPlayerMapIcon(playerid, 9, 76.4918, -258.7651, 1.5781, 51, 0);
    SetPlayerMapIcon(playerid, 10, 1363.4241, 249.8157, 19.5669, 51, 0);
    SetPlayerMapIcon(playerid, 11, -15.7992, -316.2803, 5.4229, 51, 0);
    SetPlayerMapIcon(playerid, 12, -543.4209, 2592.2168, 53.5156, 51, 0);
    SetPlayerMapIcon(playerid, 13, 2145.2683, 2834.1897, 10.8203, 36, 0);
    SetPlayerMapIcon(playerid, 14, 2447.7651, -1963.3743, 13.5469, 36, 0);
    SetPlayerMapIcon(playerid, 15, 2799.0291, -2393.8811, 13.9560, 23, 0);
}
/*
* Fuel
*/
stock FuelStationClose(playerid)
{
    if (IsPlayerInRangeOfPoint(playerid, 10, 1004.0327, -937.5370, 42.3281))
    {
        return 0;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 1942.3719, -1772.8666, 13.6406))
    {
        return 1;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, -1606.7223, -2713.3562, 48.5335))
    {
        return 2;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, -2026.7813, 156.5509, 29.0391))
    {
        return 3;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, -2243.8149, -2559.8899, 31.9219))
    {
        return 4;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, -1676.2601, 413.5443, 7.1797))
    {
        return 5;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 2201.8296, 2475.1350, 10.8203))
    {
        return 6;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 615.3391, 1690.0454, 6.9922))
    {
        return 7;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, -1328.2731, 2677.5278, 50.0625))
    {
        return 8;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 70.3842, 1219.0177, 18.8116))
    {
        return 9;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 2113.3835, 919.5655, 10.8203))
    {
        return 10;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 2641.0115, 1106.6252, 10.8203))
    {
        return 11;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 2146.7964, 2747.8115, 10.8203))
    {
        return 12;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 1595.7935, 2199.5996, 10.8203))
    {
        return 13;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, -1471.1836, 1863.7598, 32.6328))
    {
        return 14;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 655.7673, -565.0798, 16.3359))
    {
        return 15;
    }
    if (IsPlayerInRangeOfPoint(playerid, 10, 1381.8230, 459.1453, 20.3452))
    {
        return 16;
    }
    return 0;
}

/*
* Animations
*/
stock IsPlayerInWater(playerid)
{
    new anim = GetPlayerAnimationIndex(playerid);
    if (((anim >= 1538) && (anim <= 1542)) || (anim == 1544) || (anim == 1250) || (anim == 1062)) return 1;
    return 0;
}

/*
* Money
*/
stock GivePlayerCash(playerid, money)
{
    PlayerInfo[playerid][pCash] += money;
    ResetPlayerMoney(playerid);
    GivePlayerMoney(playerid, PlayerInfo[playerid][pCash]);
    return PlayerInfo[playerid][pCash];
}

/*
* TextDraws for Stats
*/
stock OnLoginShowTexts(playerid)
{
    format(string256, 256, "~g~EP: ~w~%d/~g~%d", PlayerInfo[playerid][pEP], PlayerInfo[playerid][pLevel] + 6, PlayerInfo[playerid][pEPS]);
    TextDrawSetString(epText[playerid], string256);
    format(string256, 256, "~g~LEVEL: ~w~%d", PlayerInfo[playerid][pLevel]);
    TextDrawSetString(levelText[playerid], string256);
    format(string256, 256, "~g~EPSKILL: ~w~%d", PlayerInfo[playerid][pEPS]);
    TextDrawSetString(epsText[playerid], string256);
    format(string256, 256, "~g~MSKILL: ~w~%d", PlayerInfo[playerid][pMS]);
    TextDrawSetString(msText[playerid], string256);
    TextDrawShowForPlayer(playerid, levelText[playerid]);
    TextDrawShowForPlayer(playerid, epText[playerid]);
    TextDrawShowForPlayer(playerid, epsText[playerid]);
    TextDrawShowForPlayer(playerid, msText[playerid]);
}

stock ActualizeDownStats(playerid)
{
    if (IsPlayerConnected(playerid))
    {
        format(string256, 256, "~g~Level: ~w~%d   ~r~EP Skill:~n~             ~w~%d", PlayerInfo[playerid][pLevel], PlayerInfo[playerid][pEPS]);
        TextDrawSetString(levelText[playerid], string256);
    }
}

/*
* Stats
*/
stock GivePlayerEP(playerid, ep)
{
    if (IsPlayerConnected(playerid))
    {
        PlayerInfo[playerid][pEP] += ep;
        format(string256, 256, "~g~EP: ~w~%d/~g~%d", PlayerInfo[playerid][pEP], PlayerInfo[playerid][pLevel] + 6, PlayerInfo[playerid][pEPS]);
        TextDrawSetString(epText[playerid], string256);
    }
}
stock GivePlayerLevel(playerid, level)
{
    if (IsPlayerConnected(playerid))
    {
        SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
        PlayerInfo[playerid][pLevel] += level;
        format(string256, 256, "~g~LEVEL: ~w~%d", PlayerInfo[playerid][pLevel]);
        TextDrawSetString(levelText[playerid], string256);
    }
}
stock GivePlayerMS(playerid, ms)
{
    if (IsPlayerConnected(playerid))
    {
        PlayerInfo[playerid][pMS] += ms;
        SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
        format(string256, 256, "~g~MSKILL: ~w~%d", PlayerInfo[playerid][pMS]);
        TextDrawSetString(msText[playerid], string256);
    }
}
stock GivePlayerEPS(playerid, eps)
{
    if (IsPlayerConnected(playerid))
    {
        PlayerInfo[playerid][pEPS] += eps;
        format(string256, 256, "~g~EPSKILL: ~w~%d", PlayerInfo[playerid][pEPS]);
        TextDrawSetString(epsText[playerid], string256);
    }
}

/*
* Dialog Menu
*/
GetNumberOfPages()
{
    if ((gTotalItems >= SELECTION_ITEMS) && (gTotalItems % SELECTION_ITEMS) == 0)
    {
        return (gTotalItems / SELECTION_ITEMS);
    }
    else return (gTotalItems / SELECTION_ITEMS) + 1;
}

PlayerText:CreateCurrentPageTextDraw(playerid, Float:Xpos, Float:Ypos)
{
    new PlayerText:txtInit;
    txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, "0/0");
    PlayerTextDrawUseBox(playerid, txtInit, 0);
    PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
    PlayerTextDrawFont(playerid, txtInit, 1);
    PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}
PlayerText:CreatePlayerDialogButton(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height, button_text[])
{
    new PlayerText:txtInit;
    txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, button_text);
    PlayerTextDrawUseBox(playerid, txtInit, 1);
    PlayerTextDrawBoxColor(playerid, txtInit, 0x000000FF);
    PlayerTextDrawBackgroundColor(playerid, txtInit, 0x000000FF);
    PlayerTextDrawLetterSize(playerid, txtInit, 0.4, 1.1);
    PlayerTextDrawFont(playerid, txtInit, 1);
    PlayerTextDrawSetShadow(playerid, txtInit, 0); // no shadow
    PlayerTextDrawSetOutline(playerid, txtInit, 0);
    PlayerTextDrawColor(playerid, txtInit, 0x4A5A6BFF);
    PlayerTextDrawSetSelectable(playerid, txtInit, 1);
    PlayerTextDrawAlignment(playerid, txtInit, 2);
    PlayerTextDrawTextSize(playerid, txtInit, Height, Width); // The width and height are reversed for centering.. something the game does <g>
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}
PlayerText:CreatePlayerHeaderTextDraw(playerid, Float:Xpos, Float:Ypos, header_text[])
{
    new PlayerText:txtInit;
    txtInit = CreatePlayerTextDraw(playerid, Xpos, Ypos, header_text);
    PlayerTextDrawUseBox(playerid, txtInit, 0);
    PlayerTextDrawLetterSize(playerid, txtInit, 1.25, 3.0);
    PlayerTextDrawFont(playerid, txtInit, 0);
    PlayerTextDrawSetShadow(playerid, txtInit, 0);
    PlayerTextDrawSetOutline(playerid, txtInit, 1);
    PlayerTextDrawColor(playerid, txtInit, 0xACCBF1FF);
    PlayerTextDrawShow(playerid, txtInit);
    return txtInit;
}
PlayerText:CreatePlayerBackgroundTextDraw(playerid, Float:Xpos, Float:Ypos, Float:Width, Float:Height)
{
    new PlayerText:txtBackground = CreatePlayerTextDraw(playerid, Xpos, Ypos, "                                            ~n~"); // enough space for everyone
    PlayerTextDrawUseBox(playerid, txtBackground, 1);
    PlayerTextDrawBoxColor(playerid, txtBackground, 0x4A5A6BBB);
    PlayerTextDrawLetterSize(playerid, txtBackground, 5.0, 5.0);
    PlayerTextDrawFont(playerid, txtBackground, 0);
    PlayerTextDrawSetShadow(playerid, txtBackground, 0);
    PlayerTextDrawSetOutline(playerid, txtBackground, 0);
    PlayerTextDrawColor(playerid, txtBackground, 0x000000FF);
    PlayerTextDrawTextSize(playerid, txtBackground, Width, Height);
    PlayerTextDrawBackgroundColor(playerid, txtBackground, 0x4A5A6BBB);
    PlayerTextDrawShow(playerid, txtBackground);
    return txtBackground;
}
PlayerText:CreateModelPreviewTextDraw(playerid, modelindex, Float:Xpos, Float:Ypos, Float:width, Float:height)
{
    new PlayerText:txtPlayerSprite = CreatePlayerTextDraw(playerid, Xpos, Ypos, ""); // it has to be set with SetText later
    PlayerTextDrawFont(playerid, txtPlayerSprite, TEXT_DRAW_FONT_MODEL_PREVIEW);
    PlayerTextDrawColor(playerid, txtPlayerSprite, 0xFFFFFFFF);
    PlayerTextDrawBackgroundColor(playerid, txtPlayerSprite, 0x88888899);
    PlayerTextDrawTextSize(playerid, txtPlayerSprite, width, height); // Text size is the Width:Height
    PlayerTextDrawSetPreviewModel(playerid, txtPlayerSprite, modelindex);
    PlayerTextDrawSetSelectable(playerid, txtPlayerSprite, 1);
    PlayerTextDrawShow(playerid, txtPlayerSprite);
    return txtPlayerSprite;
}
DestroyPlayerModelPreviews(playerid)
{
    new x = 0;
    while (x != SELECTION_ITEMS)
    {
        if (gSelectionItems[playerid][x] != PlayerText:INVALID_TEXT_DRAW)
        {
            PlayerTextDrawDestroy(playerid, gSelectionItems[playerid][x]);
            gSelectionItems[playerid][x] = PlayerText:INVALID_TEXT_DRAW;
        }
        x++;
    }
}
ShowPlayerModelPreviews(playerid)
{
    new x = 0;
    new Float:BaseX = DIALOG_BASE_X;
    new Float:BaseY = DIALOG_BASE_Y - (SPRITE_DIM_Y * 0.33); // down a bit
    new linetracker = 0;
    new itemat = GetPVarInt(playerid, "skinc_page") * SELECTION_ITEMS;
    // Destroy any previous ones created
    DestroyPlayerModelPreviews(playerid);
    while (x != SELECTION_ITEMS && itemat < gTotalItems)
    {
        if (linetracker == 0)
        {
            BaseX = DIALOG_BASE_X + 25.0; // in a bit from the box
            BaseY += SPRITE_DIM_Y + 1.0; // move on the Y for the next line
        }
        gSelectionItems[playerid][x] = CreateModelPreviewTextDraw(playerid, gItemList[itemat], BaseX, BaseY, SPRITE_DIM_X, SPRITE_DIM_Y);
        gSelectionItemsTag[playerid][x] = gItemList[itemat];
        BaseX += SPRITE_DIM_X + 1.0; // move on the X for the next sprite
        linetracker++;
        if (linetracker == ITEMS_PER_LINE) linetracker = 0;
        itemat++;
        x++;
    }
}
UpdatePageTextDraw(playerid)
{
    new PageText[64 + 1];
    format(PageText, 64, "%d/%d", GetPVarInt(playerid, "skinc_page") + 1, GetNumberOfPages());
    PlayerTextDrawSetString(playerid, gCurrentPageTextDrawId[playerid], PageText);
}
CreateSelectionMenu(playerid)
{
    gBackgroundTextDrawId[playerid] = CreatePlayerBackgroundTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y + 20.0, DIALOG_WIDTH, DIALOG_HEIGHT);
    gHeaderTextDrawId[playerid] = CreatePlayerHeaderTextDraw(playerid, DIALOG_BASE_X, DIALOG_BASE_Y, HEADER_TEXT);
    gCurrentPageTextDrawId[playerid] = CreateCurrentPageTextDraw(playerid, DIALOG_WIDTH - 30.0, DIALOG_BASE_Y + 15.0);
    gNextButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_WIDTH - 30.0, DIALOG_BASE_Y + DIALOG_HEIGHT + 100.0, 50.0, 16.0, NEXT_TEXT);
    gPrevButtonTextDrawId[playerid] = CreatePlayerDialogButton(playerid, DIALOG_WIDTH - 90.0, DIALOG_BASE_Y + DIALOG_HEIGHT + 100.0, 50.0, 16.0, PREV_TEXT);
    ShowPlayerModelPreviews(playerid);
    UpdatePageTextDraw(playerid);
}
DestroySelectionMenu(playerid)
{
    DestroyPlayerModelPreviews(playerid);
    PlayerTextDrawDestroy(playerid, gHeaderTextDrawId[playerid]);
    PlayerTextDrawDestroy(playerid, gBackgroundTextDrawId[playerid]);
    PlayerTextDrawDestroy(playerid, gCurrentPageTextDrawId[playerid]);
    PlayerTextDrawDestroy(playerid, gNextButtonTextDrawId[playerid]);
    PlayerTextDrawDestroy(playerid, gPrevButtonTextDrawId[playerid]);
    gHeaderTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gBackgroundTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gCurrentPageTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gNextButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
    gPrevButtonTextDrawId[playerid] = PlayerText:INVALID_TEXT_DRAW;
}
HandlePlayerItemSelection(playerid, selecteditem)
{
    // In this case we change the player's skin
    if (gSelectionItemsTag[playerid][selecteditem] >= 0 && gSelectionItemsTag[playerid][selecteditem] < 319)
    {
        if (PlayerInfo[playerid][pADuty] == 1)
        {
            SetPlayerSkin(playerid, gSelectionItemsTag[playerid][selecteditem]);
        }
        PlayerInfo[playerid][pASkin] = gSelectionItemsTag[playerid][selecteditem];
        return;
    }
}

/*
* Gets Date and Hours
*/
stock GetDateAndHours()
{
    getdate(year, month, day);
    gettime(hours, minutes, seconds);
    hours += 2;
    updatedseconds = seconds;
    if (hours == 0) SetWorldTime(0);
    if (hours == 6) SetWorldTime(0);
    if (hours == 12) SetWorldTime(12);
    if (hours == 18) SetWorldTime(23);
    if (hours == 1) SetWorldTime(0);
    if (hours == 7) SetWorldTime(6);
    if (hours == 13) SetWorldTime(12);
    if (hours == 19) SetWorldTime(23);
    if (hours == 2) SetWorldTime(0);
    if (hours == 8) SetWorldTime(6);
    if (hours == 14) SetWorldTime(12);
    if (hours == 20) SetWorldTime(0);
    if (hours == 3) SetWorldTime(0);
    if (hours == 9) SetWorldTime(12);
    if (hours == 15) SetWorldTime(12);
    if (hours == 21) SetWorldTime(0);
    if (hours == 4) SetWorldTime(0);
    if (hours == 10) SetWorldTime(12);
    if (hours == 16) SetWorldTime(12);
    if (hours == 22) SetWorldTime(0);
    if (hours == 5) SetWorldTime(0);
    if (hours == 11) SetWorldTime(12);
    if (hours == 17) SetWorldTime(12);
    if (hours == 23) SetWorldTime(0);
}

/*
* Tuning menu
*/
stock CreateTuneMenus()
{
    TuningMenu = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    AddMenuItem(TuningMenu, 0, "Paint Jobs");
    AddMenuItem(TuningMenu, 0, "Colors");
    AddMenuItem(TuningMenu, 0, "Exhausts");
    AddMenuItem(TuningMenu, 0, "Front Bumper");
    AddMenuItem(TuningMenu, 0, "Rear Bumper");
    AddMenuItem(TuningMenu, 0, "Roof");
    AddMenuItem(TuningMenu, 0, "Spoilers");
    AddMenuItem(TuningMenu, 0, "Side Skirts");
    AddMenuItem(TuningMenu, 0, "Wheels");
    AddMenuItem(TuningMenu, 0, "Others");
    // Paintjobs
    Paintjobs = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Paintjobs, 0, "PaintJobs");
    AddMenuItem(Paintjobs, 0, "Paintjob 1");
    AddMenuItem(Paintjobs, 0, "Paintjob 2");
    AddMenuItem(Paintjobs, 0, "Paintjob 3");
    AddMenuItem(Paintjobs, 0, "Paintjob 4");
    AddMenuItem(Paintjobs, 0, "Paintjob 5");
    AddMenuItem(Paintjobs, 0, "Main Menu");
    // Colors
    Colors = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Colors, 0, "Colors");
    AddMenuItem(Colors, 0, "Black");
    AddMenuItem(Colors, 0, "White");
    AddMenuItem(Colors, 0, "Red");
    AddMenuItem(Colors, 0, "Blue");
    AddMenuItem(Colors, 0, "Green");
    AddMenuItem(Colors, 0, "Yellow");
    AddMenuItem(Colors, 0, "Pink");
    AddMenuItem(Colors, 0, "Brown");
    AddMenuItem(Colors, 0, "Next Page");
    // Colors 2
    Colors1 = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Colors1, 0, "Colors");
    AddMenuItem(Colors1, 0, "Grey");
    AddMenuItem(Colors1, 0, "Gold");
    AddMenuItem(Colors1, 0, "Dark Blue");
    AddMenuItem(Colors1, 0, "Light Blue");
    AddMenuItem(Colors1, 0, "Green");
    AddMenuItem(Colors1, 0, "Light Grey");
    AddMenuItem(Colors1, 0, "Dark Red");
    AddMenuItem(Colors1, 0, "Dark Brown");
    AddMenuItem(Colors1, 0, "Main Menu");
    // Exhausts
    Exhausts = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Exhausts, 0, "Exhausts");
    AddMenuItem(Exhausts, 0, "Wheel Arch Alien Exhaust");
    AddMenuItem(Exhausts, 0, "Wheel Arch X-Flow Exhaust");
    AddMenuItem(Exhausts, 0, "Loco Low-Co Chromer Exhaust");
    AddMenuItem(Exhausts, 0, "Loco Low-Co Slamin Exhaust");
    AddMenuItem(Exhausts, 0, "Main Menu");
    // Front bumpers
    Frontbumper = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Frontbumper, 0, "Frontbumpers");
    AddMenuItem(Frontbumper, 0, "Wheel Arch Alien bumper");
    AddMenuItem(Frontbumper, 0, "Wheel Arch X-Flow bumper");
    AddMenuItem(Frontbumper, 0, "Loco Low-Co Chromer bumper");
    AddMenuItem(Frontbumper, 0, "Loco Low-Co Slamin bumper");
    AddMenuItem(Frontbumper, 0, "Main Menu");
    // Rear bumpers
    Rearbumper = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Rearbumper, 0, "Rearbumpers");
    AddMenuItem(Rearbumper, 0, "Wheel Arch Alien bumper");
    AddMenuItem(Rearbumper, 0, "Wheel Arch X-Flow bumper");
    AddMenuItem(Rearbumper, 0, "Loco Low-Co Chromer bumper");
    AddMenuItem(Rearbumper, 0, "Loco Low-Co Slamin bumper");
    AddMenuItem(Rearbumper, 0, "Main Menu");
    // Roof
    Roof = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Roof, 0, "Roof");
    AddMenuItem(Roof, 0, "Wheel Arch Alien Roof Vent");
    AddMenuItem(Roof, 0, "Wheel Arch X-Flow Roof Vent");
    AddMenuItem(Roof, 0, "Loco Low-Co Hardtop Roof");
    AddMenuItem(Roof, 0, "Loco Low-Co Softtop Roof");
    AddMenuItem(Roof, 0, "Main Menu");
    // Spoilers
    Spoilers = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Spoilers, 0, "Spoliers");
    AddMenuItem(Spoilers, 0, "Alien Spoiler");
    AddMenuItem(Spoilers, 0, "X-Flow Spoiler");
    AddMenuItem(Spoilers, 0, "Main Menu");
    // Side skirts
    Sideskirts = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Sideskirts, 0, "SideSkirts");
    AddMenuItem(Sideskirts, 0, "Wheel Arch Alien Side Skirts");
    AddMenuItem(Sideskirts, 0, "Wheel Arch X-Flow Side Skirts");
    AddMenuItem(Sideskirts, 0, "Loco Low-Co Chrome Strip");
    AddMenuItem(Sideskirts, 0, "Loco Low-Co Chrome Flames");
    AddMenuItem(Sideskirts, 0, "Loco Low-Co Chrome Arches");
    AddMenuItem(Sideskirts, 0, "Loco Low-Co Chrome Trim");
    AddMenuItem(Sideskirts, 0, "Loco Low-Co Wheelcovers");
    AddMenuItem(Sideskirts, 0, "Main Menu");
    // Wheels
    Wheels = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Wheels, 0, "Wheels");
    AddMenuItem(Wheels, 0, "Offroad");
    AddMenuItem(Wheels, 0, "Mega");
    AddMenuItem(Wheels, 0, "Wires");
    AddMenuItem(Wheels, 0, "Twist");
    AddMenuItem(Wheels, 0, "Grove");
    AddMenuItem(Wheels, 0, "Import");
    AddMenuItem(Wheels, 0, "Atomic");
    AddMenuItem(Wheels, 0, "Ahab");
    AddMenuItem(Wheels, 0, "Virtual");
    AddMenuItem(Wheels, 0, "Access");
    AddMenuItem(Wheels, 0, "Next Page");
    AddMenuItem(Wheels, 0, "Main Menu");
    // wheels 2
    Wheels1 = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Wheels1, 0, "Wheels");
    AddMenuItem(Wheels1, 0, "Trance");
    AddMenuItem(Wheels1, 0, "Shadow");
    AddMenuItem(Wheels1, 0, "Rimshine");
    AddMenuItem(Wheels1, 0, "Classic");
    AddMenuItem(Wheels1, 0, "Cutter");
    AddMenuItem(Wheels1, 0, "Switch");
    AddMenuItem(Wheels1, 0, "Dollar");
    AddMenuItem(Wheels1, 0, "Main Menu");
    // Nitro
    Nitro = CreateMenu("TuningMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Nitro, 0, "Nitro");
    AddMenuItem(Nitro, 0, "2x Nitrous");
    AddMenuItem(Nitro, 0, "5x Nitrous");
    AddMenuItem(Nitro, 0, "10x Nitrous");
    AddMenuItem(Nitro, 0, "Main Menu");
    // Others
    Others = CreateMenu("TuneMenu", 1, 20, 120, 150, 40);
    SetMenuColumnHeader(Others, 0, "Other addons");
    AddMenuItem(Others, 0, "Hydraulics");
    AddMenuItem(Others, 0, "Car Stereo");
    AddMenuItem(Others, 0, "Nitro");
    AddMenuItem(Others, 0, "Main Menu");
}

stock LoadFuelStations()
{
    for (new i = 0; i < 25; i++)
    {
        fuelStationsFuel[i] = 5000;
    }
    for (new aveh = 0; aveh < MAX_VEHICLES; aveh++)
    {
        VehicleInfo[aveh][vAdminVehSpawnedBy] = -1;
        vehfuel[aveh] = 100;
    }
}

stock LoadGamemodeFunctions()
{
    CreateTuneMenus();
    GetDateAndHours();
    DefineGangRankSkins();
    LoadFuelStations();
}

/*
* Compare player coordinates
*/
public CorDetector(Float:radi, playerid, targetid)
{
    if (IsPlayerConnected(playerid) && IsPlayerConnected(targetid))
    {
        new Float:posx, Float:posy, Float:posz;
        new Float:oldposx, Float:oldposy, Float:oldposz;
        new Float:tempposx, Float:tempposy, Float:tempposz;
        GetPlayerPos(playerid, oldposx, oldposy, oldposz);
        //radi = 2.0; //Trigger Radius
        GetPlayerPos(targetid, posx, posy, posz);
        tempposx = (oldposx - posx);
        tempposy = (oldposy - posy);
        tempposz = (oldposz - posz);
        printf("DEBUG: X:%f Y:%f Z:%f", posx, posy, posz);
        if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
        {
            return 1;
        }
    }
    return 0;
}

/*
* Formatted Message
*/
stock SendFormattedMessage(playerid, color, const format_str[], {Float,_}:...)
{
    new message[145];
    new const format_str_index = 2;
    for (new i = 0; i < numargs() - format_str_index; i++)
    {
        format(message, sizeof(message), format_str, getarg(format_str_index, i));
        SendClientMessage(playerid, color, message);
        return 1;
    }
    format(message, sizeof(message), format_str);
    SendClientMessage(playerid, color, message);
    return 1;
}
