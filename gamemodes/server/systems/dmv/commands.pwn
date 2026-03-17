CMD:train(playerid, params[])
{
    if (!IsPlayerInRangeOfPoint(playerid, 4, 773.6641, -72.9778, 1000.6484) && !IsPlayerInRangeOfPoint(playerid, 4, 773.0745, -39.3959, 1000.6865))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да си в салон за да тренираш!");
        return 1;
    }

    if (BizInfo[enteredbiz[playerid]][bOwner] == 0)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Бизнесът няма притежател и не можеш да си тренираш тук!");
        return 1;
    }

    new style[32];
    if (sscanf(params, "s[32]", style))
    {
        if (IsPlayerInRangeOfPoint(playerid, 4, 773.6641, -72.9778, 1000.6484))
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /train [fighting style]");
            SendClientMessage(playerid, 0xFF8040FF, "Fighting Styles: normal $20000, grabkick $100000, boxing $200000");
        }
        else if (IsPlayerInRangeOfPoint(playerid, 4, 773.0745, -39.3959, 1000.6865))
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /train [fighting style]");
            SendClientMessage(playerid, 0xFF8040FF, "Fighting Styles: kungfu $300000, elbow $400000, kneehead $500000");
        }
        return 1;
    }

    // First gym location
    if (IsPlayerInRangeOfPoint(playerid, 4, 773.6641, -72.9778, 1000.6484))
    {
        if (strcmp(style, "normal", true) == 0)
        {
            if (PlayerInfo[playerid][pStyle] == 0)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече владееш този боен стил!");
                return 1;
            }
            if (PlayerInfo[playerid][pCash] < 20000)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш достатъчно пари за да научиш този боен стил!");
                return 1;
            }
            SendClientMessage(playerid, 0xFF8040FF, "Ти научи боен стил Normal и това ти струваше $20000!");
            PlayerInfo[playerid][pStyle] = 0;
            GivePlayerCash(playerid, -20000);
            BizInfo[enteredbiz[playerid]][bEarnings] += 20000;
            SetPlayerFightingStyle(playerid, FIGHT_STYLE_NORMAL);
        }
        else if (strcmp(style, "grabkick", true) == 0)
        {
            if (PlayerInfo[playerid][pStyle] == 1)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече владееш този боен стил!");
                return 1;
            }
            if (PlayerInfo[playerid][pCash] < 100000)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш достатъчно пари за да научиш този боен стил!");
                return 1;
            }
            SendClientMessage(playerid, 0xFF8040FF, "Ти научи боен стил Grab Kick и това ти струваше $100000!");
            PlayerInfo[playerid][pStyle] = 1;
            GivePlayerCash(playerid, -100000);
            BizInfo[enteredbiz[playerid]][bEarnings] += 100000;
            SetPlayerFightingStyle(playerid, FIGHT_STYLE_GRABKICK);
        }
        else if (strcmp(style, "boxing", true) == 0)
        {
            if (PlayerInfo[playerid][pStyle] == 2)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече владееш този боен стил!");
                return 1;
            }
            if (PlayerInfo[playerid][pCash] < 200000)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш достатъчно пари за да научиш този боен стил!");
                return 1;
            }
            SendClientMessage(playerid, 0xFF8040FF, "Ти научи боен стил Boxing и това ти струваше $200000!");
            PlayerInfo[playerid][pStyle] = 2;
            GivePlayerCash(playerid, -200000);
            BizInfo[enteredbiz[playerid]][bEarnings] += 200000;
            SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING);
        }
        else
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /train [fighting style]");
            SendClientMessage(playerid, 0xFF8040FF, "Fighting Styles: normal $20000, grabkick $100000, boxing $200000");
        }
    }
    // Second gym location
    else if (IsPlayerInRangeOfPoint(playerid, 4, 773.0745, -39.3959, 1000.6865))
    {
        if (strcmp(style, "kungfu", true) == 0)
        {
            if (PlayerInfo[playerid][pStyle] == 3)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече владееш този боен стил!");
                return 1;
            }
            if (PlayerInfo[playerid][pCash] < 300000)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш достатъчно пари за да научиш този боен стил!");
                return 1;
            }
            SendClientMessage(playerid, 0xFF8040FF, "Ти научи боен стил Kungfu и това ти струваше $300000!");
            PlayerInfo[playerid][pStyle] = 3;
            GivePlayerCash(playerid, -300000); // Fixed: was -30000, should be -300000
            BizInfo[enteredbiz[playerid]][bEarnings] += 300000;
            SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU);
        }
        else if (strcmp(style, "elbow", true) == 0)
        {
            if (PlayerInfo[playerid][pStyle] == 4)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече владееш този боен стил!");
                return 1;
            }
            if (PlayerInfo[playerid][pCash] < 400000)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш достатъчно пари за да научиш този боен стил!");
                return 1;
            }
            SendClientMessage(playerid, 0xFF8040FF, "Ти научи боен стил Elbow и това ти струваше $400000!");
            PlayerInfo[playerid][pStyle] = 4;
            GivePlayerCash(playerid, -400000);
            BizInfo[enteredbiz[playerid]][bEarnings] += 400000;
            SetPlayerFightingStyle(playerid, FIGHT_STYLE_ELBOW);
        }
        else if (strcmp(style, "kneehead", true) == 0)
        {
            if (PlayerInfo[playerid][pStyle] == 5)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти вече владееш този боен стил!");
                return 1;
            }
            if (PlayerInfo[playerid][pCash] < 500000)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш достатъчно пари за да научиш този боен стил!");
                return 1;
            }
            SendClientMessage(playerid, 0xFF8040FF, "Ти научи боен стил Kneehead и това ти струваше $500000!");
            PlayerInfo[playerid][pStyle] = 5;
            GivePlayerCash(playerid, -500000);
            BizInfo[enteredbiz[playerid]][bEarnings] += 500000;
            SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD);
        }
        else
        {
            SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /train [fighting style]");
            SendClientMessage(playerid, 0xFF8040FF, "Fighting Styles: kungfu $300000, elbow $400000, kneehead $500000");
        }
    }
    return 1;
}
