#include <YSI_Coding/y_hooks>

hook OnGameModeInit()
{
    RESTART = TextDrawCreate(400.000000, 328.000000, " ");
    TextDrawBackgroundColor(RESTART, 250);
    TextDrawFont(RESTART, 1);
    TextDrawLetterSize(RESTART, 0.2700, 1.5500);
    TextDrawColor(RESTART, -1);
    TextDrawSetOutline(RESTART, 1);
    TextDrawSetProportional(RESTART, 1);

    ClockDate = TextDrawCreate(5.000000, 421.000000, "");
    TextDrawBackgroundColor(ClockDate, 250);
    TextDrawFont(ClockDate, 1);
    TextDrawLetterSize(ClockDate, 0.3, 1.8000);
    TextDrawColor(ClockDate, -1);
    TextDrawSetOutline(ClockDate, 1);
    TextDrawSetProportional(ClockDate, 1);

    DMONKillText = TextDrawCreate(528.000000, 328.000000, "~g~ + 1 Kill~n~+ 25 Armour");
    TextDrawAlignment(DMONKillText, 0);
    TextDrawBackgroundColor(DMONKillText, 0x000000ff);
    TextDrawFont(DMONKillText, 1);
    TextDrawLetterSize(DMONKillText, 0.2800, 1.8000);
    TextDrawSetProportional(DMONKillText, 1);
    TextDrawSetShadow(DMONKillText, 1);

    intensetext = TextDrawCreate(547.0, 24.0, "~w~in~g~te~r~nse");
    TextDrawBackgroundColor(intensetext, 250);
    TextDrawFont(intensetext, 1);
    TextDrawLetterSize(intensetext, 0.5, 2);
    TextDrawColor(intensetext, -1);
    TextDrawSetOutline(intensetext, 1);
    TextDrawSetProportional(intensetext, 1);

    Intro[0] = TextDrawCreate(642.0, 1.0, "~n~");
    TextDrawLetterSize(Intro[0], 0.5, 49.5);
    TextDrawUseBox(Intro[0], 1);
    TextDrawBoxColor(Intro[0], 0x000000FF);
    TextDrawTextSize(Intro[0], -2.0, 0.0);

    if (month == 1 && day < 10)
    {
        new stringYear[256];
        format(stringYear, 256, "~w~~h~HAPPY ~g~NEW ~r~YEAR ~y~%d", year);
        Intro[1] = TextDrawCreate(190.000000, 190.000000, stringYear);
        TextDrawFont(Intro[1], 2);
        TextDrawLetterSize(Intro[1], 0.570000, 1.799999);
    }
    else
    {
        Intro[1] = TextDrawCreate(190.000000, 190.000000, "~w~~h~INTENSE ~g~team");
        TextDrawFont(Intro[1], 2);
        TextDrawLetterSize(Intro[1], 0.570000, 1.799999);
        Intro[2] = TextDrawCreate(310.000000, 190.000000, "        ~r~presents...");
        TextDrawFont(Intro[2], 2);
        TextDrawColor(Intro[2], 0xFFFFFFFF);
        TextDrawLetterSize(Intro[2], 0.570000, 1.799999);
    }
    Intro[3] = TextDrawCreate(190.0, 202.0, ".");
    TextDrawFont(Intro[3], 1);
    TextDrawLetterSize(Intro[3], 23.250051, 1.099999);
    Intro[4] = TextDrawCreate(304.00, 223.0, "~w~B-u-l-g-a-r-i-a-n ~g~i-n-t-e-n-s-e ~r~s-e-r-v-e-r");
    TextDrawFont(Intro[4], 2);
    TextDrawLetterSize(Intro[4], 0.340000, 1.099999);
    Intro[5] = TextDrawCreate(331.0, 235.0, "~w~official ~g~site ~r~soon");
    TextDrawFont(Intro[5], 2);
    TextDrawLetterSize(Intro[5], 0.340000, 1.099999);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnGameModeExit()
{

    for (new i; i < MAX_PLAYERS; i++)
    {
        TextDrawHideForPlayer(i, Intro[0]);
        TextDrawHideForPlayer(i, Intro[1]);
        TextDrawHideForPlayer(i, Intro[2]);
        TextDrawHideForPlayer(i, Intro[3]);
        TextDrawHideForPlayer(i, Intro[4]);
        TextDrawHideForPlayer(i, Intro[5]);
        //TextDrawHideForPlayer(i, Clock);
        TextDrawHideForPlayer(i, epText[i]);
        TextDrawHideForPlayer(i, levelText[i]);
        TextDrawHideForPlayer(i, epsText[i]);
        TextDrawHideForPlayer(i, msText[i]);
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    if (GetPVarInt(playerid, "skinc_active") == 0) return 0;
    if (clickedid == Text:INVALID_TEXT_DRAW)
    {
        DestroySelectionMenu(playerid);
        SetPVarInt(playerid, "skinc_active", 0);
        PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
        return 1;
    }
    return 0;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
    if (GetPVarInt(playerid, "skinc_active") == 0) return 0;
    new curpage = GetPVarInt(playerid, "skinc_page");
    if (playertextid == gNextButtonTextDrawId[playerid])
    {
        if (curpage < (GetNumberOfPages() - 1))
        {
            SetPVarInt(playerid, "skinc_page", curpage + 1);
            ShowPlayerModelPreviews(playerid);
            UpdatePageTextDraw(playerid);
            PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
        }
        else
        {
            PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
        }
        return 1;
    }
    if (playertextid == gPrevButtonTextDrawId[playerid])
    {
        if (curpage > 0)
        {
            SetPVarInt(playerid, "skinc_page", curpage - 1);
            ShowPlayerModelPreviews(playerid);
            UpdatePageTextDraw(playerid);
            PlayerPlaySound(playerid, 1084, 0.0, 0.0, 0.0);
        }
        else
        {
            PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
        }
        return 1;
    }
    new x = 0;
    while (x != SELECTION_ITEMS)
    {
        if (playertextid == gSelectionItems[playerid][x])
        {
            HandlePlayerItemSelection(playerid, x);
            PlayerPlaySound(playerid, 1083, 0.0, 0.0, 0.0);
            DestroySelectionMenu(playerid);
            CancelSelectTextDraw(playerid);
            SetPVarInt(playerid, "skinc_active", 0);
            return 1;
        }
        x++;
    }
    return 0;
}