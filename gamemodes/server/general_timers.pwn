//==============================================================================
//          -- > /// GeneralTimer1s
//==============================================================================
public GeneralTimer1s()
{
    //open Generaltimer1s
    getdate(year, month, day);
    gettime(hours, minutes, seconds);

    GeneralTimer1sFaction();

    if (minutes == 36 && seconds == 30)
    {
        SendClientMessageToAll(0xE60000FF, "SERVER: - AUTO SAVE: Цялата статистика за сървъра в момента се ЗАПАМЕТЯВА АВТОМАТИЧНО!");
        SendClientMessageToAll(0xE60000FF, "SERVER: В момента всичко за акаунтите/къщите/бизнесите се запаметява!");
        SendClientMessageToAll(0xE60000FF, "SERVER: Докато всичко се запаметява сървъра ще изглежда че все едно не работи!");
        SendClientMessageToAll(0xE60000FF, "SERVER: Няма да можете да правите нищо в сървъра, но това е само докато нещата се запаметят!");
        SendClientMessageToAll(0xE60000FF, "SERVER: Моля,изчакайте докато всичко се запамети!");
        for (new i; i < MAX_PLAYERS; i++)
        {
            SavePlayerStats(i);
        }
        SendClientMessageToAll(0xE60000FF, "SERVER: Всичко се запамети успешно, благодарим за вашето търпение!");
    }



    if (minutes == 0 && seconds == 0)
    {
        new noerrorstring2[115];
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
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            zaplatakinti[i] = 0;
            lastpaydaykinti[i] = 0;
            format(noerrorstring2, 115, "SERVER: Часът е %d:00", hours);
            SendClientMessage(i, 0xFFFF84FF, noerrorstring2);
            if (PlayerInfo[i][pLastPayday] < 15)
            {
                SendClientMessage(i, 0xFFFFFFFF, "Ти не си играл достатъчно за да получиш Payday!");
            }
            else
            {
                SendClientMessage(i, 0xC6A2DEFF, "|____ LV BANK STATEMENT ____|");
                format(noerrorstring2, 115, "Обща сума: $%d", PlayerInfo[i][pAccount]);
                SendClientMessage(i, 0xF97804FF, noerrorstring2);
                if (PlayerInfo[i][pLastPayday] > 29)
                {}
                if (PlayerInfo[i][pLastPayday] > 29 && PlayerInfo[i][pLastPayday] < 100)
                {
                    if (PlayerInfo[i][pAFK] == 0)
                    {
                        GivePlayerEP(i, 1);
                    }
                    else
                    {
                        if (PlayerInfo[i][pAFK] < 30)
                        {
                            GivePlayerEP(i, 2);
                        }
                    }
                }
                if (PlayerInfo[i][pLastPayday] > 1799)
                {
                    if (PlayerInfo[i][pAFK] == 0)
                    {
                        GivePlayerEP(i, 2);
                    }
                }
                if (PlayerInfo[i][pAFK] >= 30)
                {
                    GivePlayerEP(i, 4);
                }
                PlayerInfo[i][pAccount] += PlayerInfo[i][pLastPayday] * 3;
                lastpaydaykinti[i] = PlayerInfo[i][pLastPayday];
                lastpaydaykinti[i] = lastpaydaykinti[i] * 3;
                if (PlayerInfo[i][pLevel] < 31)
                {
                    PlayerInfo[i][pAccount] += PlayerInfo[i][pLevel] * 1000;
                    zaplatakinti[i] = PlayerInfo[i][pLevel] * 1000;
                }
                else
                {
                    PlayerInfo[i][pAccount] += 30000;
                    zaplatakinti[i] = 30000;
                }
                format(noerrorstring2, 115, "Заплата: $%d", zaplatakinti[i]);
                SendClientMessage(i, 0xF97804FF, noerrorstring2);
                format(noerrorstring2, 115, "Онлайн бонус: $%d", PlayerInfo[i][pLastPayday] * 3);
                SendClientMessage(i, 0xF97804FF, noerrorstring2);
                if (PlayerInfo[i][pMS] > 0)
                {
                    format(noerrorstring2, 115, "Money Skill: + $%d", PlayerInfo[i][pMS] * 10000);
                    SendClientMessage(i, 0x80D5FF80, noerrorstring2);
                    PlayerInfo[i][pAccount] += PlayerInfo[i][pMS] * 10000;
                }
                if (PlayerInfo[i][pTeam] == FACTION_INTENSE_POLICE)
                {
                    if (PlayerInfo[i][pRank] == 1)
                    {
                        format(noerrorstring2, 115, "Intense Police Department: + 2 EP и 10000$");
                        SendClientMessage(i, COLOR_IPD_CHAT, noerrorstring2);
                        GivePlayerEP(i, 2);
                        PlayerInfo[i][pAccount] += 10000;
                    }
                    if (PlayerInfo[i][pRank] == 2)
                    {
                        format(noerrorstring2, 115, "Intense Police Department: + 4 EP и 20000$");
                        SendClientMessage(i, COLOR_IPD_CHAT, noerrorstring2);
                        GivePlayerEP(i, 4);
                        PlayerInfo[i][pAccount] += 20000;
                    }
                    if (PlayerInfo[i][pRank] == 3)
                    {
                        format(noerrorstring2, 115, "Intense Police Department: + 6 EP и 30000$");
                        SendClientMessage(i, COLOR_IPD_CHAT, noerrorstring2);
                        GivePlayerEP(i, 6);
                        PlayerInfo[i][pAccount] += 30000;
                    }
                    if (PlayerInfo[i][pRank] == 4)
                    {
                        format(noerrorstring2, 115, "Intense Police Department: + 8 EP и 40000$");
                        SendClientMessage(i, COLOR_IPD_CHAT, noerrorstring2);
                        GivePlayerEP(i, 8);
                        PlayerInfo[i][pAccount] += 40000;
                    }
                    if (PlayerInfo[i][pRank] == 5)
                    {
                        format(noerrorstring2, 115, "Intense Police Department: + 10 EP и 50000$");
                        SendClientMessage(i, COLOR_IPD_CHAT, noerrorstring2);
                        GivePlayerEP(i, 10);
                        PlayerInfo[i][pAccount] += 50000;
                    }
                    if (PlayerInfo[i][pRank] == 6)
                    {
                        format(noerrorstring2, 115, "Intense Police Department: + 50 EP и 1000000$");
                        SendClientMessage(i, COLOR_IPD_CHAT, noerrorstring2);
                        GivePlayerEP(i, 50);
                        PlayerInfo[i][pAccount] += 1000000;
                    }
                }
                if (PlayerInfo[i][pTeam] == FACTION_VIP)
                {
                    if (PlayerInfo[i][pRank] == 2)
                    {
                        format(noerrorstring2, 115, "VIP Gang: + 2 EP и 2000$");
                        SendClientMessage(i, 0xFF3737FF, noerrorstring2);
                        GivePlayerEP(i, 2);
                        PlayerInfo[i][pAccount] += 2000;
                    }
                    if (PlayerInfo[i][pRank] == 3)
                    {
                        format(noerrorstring2, 115, "VIP Gang: + 3 EP и 3000$");
                        SendClientMessage(i, 0xFF3737FF, noerrorstring2);
                        GivePlayerEP(i, 3);
                        PlayerInfo[i][pAccount] += 3000;
                    }
                    if (PlayerInfo[i][pRank] == 4)
                    {
                        format(noerrorstring2, 115, "VIP Gang: + 4 EP и 4000$");
                        SendClientMessage(i, 0xFF3737FF, noerrorstring2);
                        GivePlayerEP(i, 4);
                        PlayerInfo[i][pAccount] += 4000;
                    }
                    if (PlayerInfo[i][pRank] == 5)
                    {
                        format(noerrorstring2, 115, "VIP Gang: + 5 EP и 5000$");
                        SendClientMessage(i, 0xFF3737FF, noerrorstring2);
                        GivePlayerEP(i, 5);
                        PlayerInfo[i][pAccount] += 5000;
                    }
                    if (PlayerInfo[i][pRank] == 6)
                    {
                        format(noerrorstring2, 115, "VIP Gang: + 6 EP и 6000$");
                        SendClientMessage(i, 0xFF3737FF, noerrorstring2);
                        GivePlayerEP(i, 6);
                        PlayerInfo[i][pAccount] += 6000;
                    }
                }
                if (PlayerInfo[i][pBizO] > -1)
                {
                    format(noerrorstring2, 115, "Bizz: + %d$", BizInfo[PlayerInfo[i][pBizO]][bPayOut]);
                    SendClientMessage(i, 0x00CCCCFF, noerrorstring2);
                    PlayerInfo[i][pAccount] += BizInfo[PlayerInfo[i][pBizO]][bPayOut];
                }
                if (PlayerInfo[i][pBizO] > -1 && BizInfo[PlayerInfo[i][pBizO]][bEP] > 0)
                {
                    format(noerrorstring2, 115, "Bizz: + %d EP", BizInfo[PlayerInfo[i][pBizO]][bEP]);
                    SendClientMessage(i, 0x00CCCCFF, noerrorstring2);
                    GivePlayerEP(i, BizInfo[PlayerInfo[i][pBizO]][bEP]);
                }
                if (PlayerInfo[i][pOffice] > 0)
                {
                    new hisOffice = PlayerInfo[i][pOffice];
                    new bonusEP = OfficeInfo[hisOffice][BonusEP];
                    new bonusCash = OfficeInfo[hisOffice][BonusCash];
                    format(noerrorstring2, 115, "Office: + %d EP и %d$", bonusEP, bonusCash);
                    SendClientMessage(i, 0x00FF00FF, noerrorstring2);
                    GivePlayerEP(i, bonusEP);
                    PlayerInfo[i][pAccount] += bonusCash;
                }
                if (PlayerInfo[i][pVip] == 1)
                {
                    format(noerrorstring2, 115, "VIP Level 1: + 1 EP и 1000$");
                    SendClientMessage(i, 0xE65B00FF, noerrorstring2);
                    GivePlayerEP(i, 1);
                    PlayerInfo[i][pAccount] += 1000;
                }
                if (PlayerInfo[i][pVip] == 2)
                {
                    format(noerrorstring2, 115, "VIP Level 2: + 2 EP и 2000$");
                    SendClientMessage(i, 0xE65B00FF, noerrorstring2);
                    GivePlayerEP(i, 2);
                    PlayerInfo[i][pAccount] += 2000;
                }
                if (PlayerInfo[i][pVip] == 3)
                {
                    format(noerrorstring2, 115, "VIP Level 3: + 3 EP и 3000$");
                    SendClientMessage(i, 0xE65B00FF, noerrorstring2);
                    GivePlayerEP(i, 3);
                    PlayerInfo[i][pAccount] += 3000;
                }
                if (PlayerInfo[i][pVip] == 4)
                {
                    format(noerrorstring2, 115, "VIP Level 4: + 4 EP и 4000$");
                    SendClientMessage(i, 0xE65B00FF, noerrorstring2);
                    GivePlayerEP(i, 4);
                    PlayerInfo[i][pAccount] += 4000;
                }
                if (PlayerInfo[i][pVip] == 5)
                {
                    format(noerrorstring2, 115, "VIP Level 5: + 5 EP и 5000$");
                    SendClientMessage(i, 0xE65B00FF, noerrorstring2);
                    GivePlayerEP(i, 5);
                    PlayerInfo[i][pAccount] += 5000;
                }
                if (PlayerInfo[i][pVip] == 6 || CheckFreeVIP() == 1)
                {
                    format(noerrorstring2, 115, "VIP Level 6: + 6 EP и 6000$");
                    SendClientMessage(i, 0xE65B00FF, noerrorstring2);
                    GivePlayerEP(i, 6);
                    PlayerInfo[i][pAccount] += 6000;
                }
                if (PlayerInfo[i][pEPS] > 0)
                {
                    format(noerrorstring2, 115, "EP Skill: + %d EP", PlayerInfo[i][pEPS]);
                    SendClientMessage(i, 0x80D5FFFF, noerrorstring2);
                }
                GivePlayerEP(i, PlayerInfo[i][pEPS]);
                SendClientMessage(i, 0xC6A2DEFF, "|----------------------------|");
                format(noerrorstring2, 115, "Нова обща сума: $%d", PlayerInfo[i][pAccount]);
                SendClientMessage(i, 0x40BF00FF, noerrorstring2);
                format(noerrorstring2, 115, "~y~PAYDAY~n~~w~PAYCHECK:~n~~g~$%d", zaplatakinti[i]);
                GameTextForPlayer(i, noerrorstring2, 3000, 1);
                PlayerInfo[i][pLastPayday] = 0;
                if (PlayerInfo[i][pAFK] > 1)
                {
                    PlayerInfo[i][pAFK] = 1;
                }
            }
        }
    }

    if (minutes == 59 && seconds == 0)
    {
        new lottowinners;
        new lotteryWinningNum = randomex(1, 101);
        new lottostring[256];
        new oldLotteryWin = lottowin;
        format(lottostring, 256, "[Intense Lottery] печелившото число е %d", lotteryWinningNum);
        SendClientMessageToAll(0xFF00FFFF, lottostring);
        for (new i; i < MAX_PLAYERS; i++)
        {
            if (lottonumber[i] > 0)
            {
                format(lottostring, 256, "Твоето число е %d", lottonumber[i]);
                SendClientMessage(i, 0xFF00FFFF, lottostring);
            }
            if (lottonumber[i] == lotteryWinningNum)
            {
                lottowinners += 1;
            }
        }
        if (lottowinners >= 2)
        {
            format(lottostring, 115, "Имаме %d победители в лотарията! Стойността на джакпота е %d и всеки победител получава по $%d и 10 EP!", lottowinners, oldLotteryWin, oldLotteryWin / lottowinners);
            SendClientMessageToAll(0xFF80C0FF, lottostring);
            format(lottostring, 115, "Победители:");
            SendClientMessageToAll(0xFF80C0FF, lottostring);
        }
        for (new i; i < MAX_PLAYERS; i++)
        {
            if (lottonumber[i] == lotteryWinningNum)
            {
                GivePlayerCash(i, oldLotteryWin / lottowinners);
                if (lottowinners >= 2)
                {
                    SendClientMessageToAll(0xFF80C0FF, GetPlayerNickname(i));
                }
                else if (lottowinners == 1)
                {
                    format(lottostring, 115, "%s победи в лотарията! Стойността на джакпота е %d + 10 EP!", GetPlayerNickname(i), oldLotteryWin);
                    SendClientMessageToAll(0xFF80C0FF, lottostring);
                }
            }
        }
        if (lottowinners > 0)
        {
            lottowin = 5000;
        }
        else if (lottowinners == 0)
        {
            lottowin += 5000;
            format(lottostring, 115, "Няма победител за тази лотария. Следващият път стойността на джакпота ще е $%d", lottowin);
            SendClientMessageToAll(0xFF80C0FF, lottostring);
        }

    }

    if (minutes == 54 && seconds == 0)
    {
        SendClientMessageToAll(0xFF80C0FF, "Тегленето на лотарията ще е след 5 минути. Ако все още нямаш фиш използвай /lotto [1-100]");
    }
    if (minutes == 44 && seconds == 0)
    {
        SendClientMessageToAll(0xFF80C0FF, "Тегленето на лотарията ще е след 10 минути. Ако все още нямаш фиш използвай /lotto [1-100]");
    }
    if (minutes == 57 && seconds == 0)
    {
        SendClientMessageToAll(0xFF80C0FF, "Тегленето на лотарията ще е след 2 минути. Ако все още нямаш фиш използвай /lotto [1-100]");
    }

    if (minutes == 2 && seconds == 0)
    {
        SendClientMessageToAll(0x6BF7DEFF, "Announcement: Търсят се хора, готови да помогнат за развитието на гейммода. Discord: didkoandreevofficial");
    }
    if (minutes == 47 && seconds == 0)
    {
        SendClientMessageToAll(0x6BF7DEFF, "Announcement: За да се свържете със създателя на мода, потърсете Discord: didkoandreevofficial");
    }
    if (minutes == 20 && seconds == 0)
    {
        SendClientMessageToAll(0x6BF7DEFF, "Announcement: Ако имате нужда да говорите със скриптъра, потърсете Discord didkoandreevofficial");
    }

    if (hours == 0 && minutes == 0 && seconds == 0)
    {
        isMadeRefuel = 0;
    }

    if (serverrestarttimer > 0)
    {
        format(string115n2, sizeof string115n2, "~n~~w~The server will be restarted after %d seconds", serverrestarttimer);
        TextDrawSetString(RESTART, string115n2);
    }
    format(string115n2, sizeof string115n2, "~w~%d/%s%d/~g~%s%d-%s%d:~r~%s%d:%s%d", day, ((month < 10) ? ("0") : ("")), month, (year < 10) ? ("0") : (""), year, (hours < 10) ? ("0") : (""), hours, (minutes < 10) ? ("0") : (""), minutes, (seconds < 10) ? ("0") : (""), seconds);
    TextDrawSetString(ClockDate, string115n2);

    if (respawnVehsVoteTimer > 0)
    {
        if (respawnVehsVoteTimer > 0)
        {
            respawnVehsVoteTimer -= 1;
        }
        if (respawnVehsVoteTimer == 0)
        {
            if (voteResultsYes < voteResultsNo)
            {
                new stringvote[256];
                format(stringvote, 256, "SERVER: Резултат от гласуването - %d ДА срещу %d НЕ", voteResultsYes, voteResultsNo);
                SendClientMessageToAll(0x33CC00FF, stringvote);
                format(stringvote, 256, "SERVER: Превозните средства няма да бъдат RESPAWN-нати !");
                SendClientMessageToAll(0x33CC00FF, stringvote);
            }
            if (voteResultsYes > voteResultsNo)
            {
                new stringvote[256];
                format(stringvote, 256, "SERVER: Резултат от гласуването - %d ДА срещу %d НЕ", voteResultsYes, voteResultsNo);
                SendClientMessageToAll(0x33CC00FF, stringvote);
                format(stringvote, 256, "SERVER: Превозните средства ще се RESPAWN-нат след 10 секунди!");
                SendClientMessageToAll(0x33CC00FF, stringvote);
                respawnVehsTimer = 10;
            }
            voteResultsNo = 0;
            voteResultsYes = 0;
            respawnVehsVoteTimer = 0;
            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                PlayerInfo[i][pYes] = 0;
                PlayerInfo[i][pNo] = 0;
            }
        }
    }

    if (voteTimer > 0)
    {
        if (voteTimer > 0)
        {
            voteTimer -= 1;
        }
        if (voteTimer == 0)
        {
            new stringvote[256];
            format(stringvote, 256, "Резултатите от гласуванията на последния въпрос - %s са %d ДА %d НЕ", voteQuestion, voteResultsYes, voteResultsNo);
            SendClientMessageToAll(0x33CC00FF, stringvote);
            voteResultsNo = 0;
            voteResultsYes = 0;
            voteTimer = 0;
            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                PlayerInfo[i][pYes] = 0;
                PlayerInfo[i][pNo] = 0;
            }
        }
    }

    if (robberyToStopTimer > 0)
    {
        if (robberyToStopTimer > 0)
        {
            robberyToStopTimer -= 1;
        }
        if (robberyToStopTimer == 0)
        {
            SendClientMessageToAll(0xFF8200FF, "Robbery: Обирът спира автоматично, защото крадеца не успя да се върне навреме!");
            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                if (PlayerInfo[i][pRobber] == 1)
                {
                    GivePlayerCash(i, robCollectedMoney / robberyMembers);
                    format(string256, 256, "Robbery: Ти получи своя дял от обира - $%d.", robCollectedMoney / robberyMembers);
                    SendClientMessage(i, 0xFF8200FF, string256);
                    PlayerInfo[i][pRobber] = 0;
                    PlayerInfo[i][pRobberLead] = 0;
                }
            }
            robberyMembers = 0;
            robberyTimeToStartAgain = 30 * 60;
        }
    }

    if (robberyTimerToCollect > 0)
    {
        if (robberyTimerToCollect > 0)
        {
            robberyTimerToCollect -= 1;
        }
        if (robberyTimerToCollect == 0)
        {
            new stringrobbery[256];
            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                format(stringrobbery, 256, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~STOLEN CASH:~n~~g~$%d", robCollectedMoney);
                if (PlayerInfo[i][pRobber] == 1 || PlayerInfo[i][pRobberLead] == 1)
                {
                    GameTextForPlayer(i, stringrobbery, 3000, 3);
                }
                if (IsPlayerInRobPlace(i))
                {
                    if (PlayerInfo[i][pRobber] == 1 || PlayerInfo[i][pRobberLead] == 1)
                    {
                        robCollectedMoney += 70;
                    }
                    if (PlayerInfo[i][pRobberLead] == 1 && robberyToStopTimer > 0)
                    {
                        robberyToStopTimer = 0;
                    }
                }
                else if (!IsPlayerInRobPlace(i))
                {
                    if (PlayerInfo[i][pRobberLead] == 1)
                    {
                        if (robberyToStopTimer == 0)
                        {
                            robberyToStopTimer = 5 * 60;
                            SendClientMessage(i, 0xFF8200FF, "Robbery: Върни се на обира до 5 минути или той ще бъде спрян!");
                        }
                    }
                }
            }
            robberyTimerToCollect = 2;
        }
    }

    if (robberyTimeToStartAgain < 0)
    {
        if (robberyTimeToStartAgain > 0)
        {
            robberyTimeToStartAgain -= 1;
        }
        if (robberyTimeToStartAgain == 0)
        {
            SendClientMessageToAll(0xFF8200FF, "Robbery: Вече може да бъде стартиран нов обир!");
        }
    }

    if (respawnVehsTimer > 0)
    {
        if (respawnVehsTimer > 0)
        {
            respawnVehsTimer -= 1;
        }
        if (respawnVehsTimer == 0)
        {
            SendClientMessageToAll(0xFFFFFFFF, "SERVER: All vehicles has been respawned!");
            for (new cars = 0; cars < MAX_VEHICLES; cars++)
            {
                if (drive[cars] == 0)
                {
                    SetVehicleToRespawn(cars);
                }
            }
        }
    }
    if (robberyTimerRobberToStart < 0)
    {
        if (robberyTimerRobberToStart > 0)
        {
            robberyTimerRobberToStart -= 1;
        }
        if (robberyTimerRobberToStart == 0)
        {
            if (robCollectedMoney == 0)
            {
                SendClientMessageToAll(0xFF8200FF, "Robbery: Лидерът не започна да краде, заради това обирът е спрян!");
                for (new i5 = 0; i5 < MAX_PLAYERS; i5++)
                {
                    if (PlayerInfo[i5][pRobber] == 1 || PlayerInfo[i5][pRobberLead] == 1)
                    {
                        PlayerInfo[i5][pRobberLead] = 0;
                        PlayerInfo[i5][pRobber] = 0;
                    }
                }
                robberyMembers = 0;
                startedrob = 0;
                robberyTimeToStartAgain = 30 * 60;
            }
        }
    }

    if (derbyJoinTimer > 0)
    {
        if (derbyJoinTimer > 0) //
        {
            derbyJoinTimer--;
        }
    }

    if (derbyStartTimer > 0)
    {
        if (derbyStartTimer > 0) //
        {
            derbyStartTimer--;
        }
        if (derbyStartTimer == 10)
        {
            SendClientMessageToAll(0xE5503BFF, "Derby: Дербито ще започне след 10 секунди.");
        }
        if (derbyStartTimer == 0)
        {
            derbyStarted = 1;
            SendClientMessageToAll(0xE5503BFF, "Derby: Дербито започна успех на всички.");

            for (new i = 0; i < MAX_PLAYERS; i++)
            {
                if (isDerbyPlayer[i])
                {
                    TogglePlayerControllable(i, 1);
                    GameTextForPlayer(i, "~g~GO", 3000, 3);
                    PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
                }
            }

        }
    }


    if (lastDerbyTimer > 0)
    {
        if (lastDerbyTimer > 0) //
        {
            lastDerbyTimer--;
        }
        if (lastDerbyTimer == 0)
        {
            for (new i = 0; i < 10; i++)
            {
                SetVehicleToRespawn(derbytypecar1[i]);
                SetVehicleVirtualWorld(derbytypecar1[i], 4);
            }

            if (derbyPlayersCount == 1)
            {
                for (new i = 0; i < MAX_PLAYERS; i++)
                {
                    if (isDerbyPlayer[i])
                    {
                        PlayerLeaveDerby(i);
                    }
                }
            }

            derbyPlayersCount = 0;
            SendClientMessageToAll(0xE5503BFF, "Derby: Дербито приключи, ново дерби ще има след 10 минути.");
        }
    }

    if (newDerbyTimer > 0)
    {
        if (newDerbyTimer > 0) //
        {
            newDerbyTimer--;
        }
        if (newDerbyTimer == 0)
        {
            SendClientMessageToAll(0xE5503BFF, "Derby: Изтече нужното време и може да стартира ново дерби.");
            SendClientMessageToAll(0xE5503BFF, "Derby: Ако искаш да се присъединиш /derbyon");
            for (new cars = 0; cars < 11; cars++)
            {
                SetVehicleToRespawn(derbytypecar1[cars]);
                vehfuel[derbytypecar1[cars]] = 100;
            }
        }
    }

    if (lvpdB2Timer > 0)
    {
        if (lvpdB2Timer > 0)
        {
            lvpdB2Timer -= 1;
        }
        if (lvpdB2Timer == 0)
        {
            MoveObject(lvpd2, 2335.417236, 2444.029785, 6.957778, 5.00, 0.000000, 0.000000, 59.200016);
        }
    }
    if (lvpdB1Timer > 0)
    {
        if (lvpdB1Timer > 0)
        {
            lvpdB1Timer -= 1;
        }
        if (lvpdB1Timer == 0)
        {
            MoveObject(lvpd1, 2238.197509, 2450.464599, 10.341962, 2.00, -4.799997, -89.000000, -89.499954);
        }
    }
    if (eventCount0 > 0)
    {
        if (eventCount0 > 0)
        {
            eventCount0 -= 1;
        }
        if (eventCount0 == 0)
        {
            GameTextForAll("~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~-~b~ 2 ~r~-", 2500, 3);
            eventCount1 = 2;
        }
    }
    if (eventCount1 > 0)
    {
        if (eventCount1 > 0)
        {
            eventCount1 -= 1;
        }
        if (eventCount1 == 0)
        {
            GameTextForAll("~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~-~b~ 1 ~r~-", 2500, 3);
            eventCount2 = 2;
        }
    }
    if (eventCount2 > 0)
    {
        if (eventCount2 > 0)
        {
            eventCount2 -= 1;
        }
        if (eventCount2 == 0)
        {
            eventActiveCount = 0;
            GameTextForAll("~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~r~-]-~b~START~r~-]-", 2000, 3);
            for (new i33 = 0; i33 <= MAX_PLAYERS; i33++)
            {
                if (inevent[i33] == 1)
                {
                    TogglePlayerControllable(i33, 1);
                }
            }
        }
    }
    if (counttime0 > 0)
    {
        if (counttime0 > 0)
        {
            counttime0 -= 1;
        }
        if (counttime0 == 0)
        {
            GameTextForAll("~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~-~y~ 2 ~g~-", 2500, 3);
            counttime1 = 2;
        }
    }
    if (counttime1 > 0)
    {
        if (counttime1 > 0)
        {
            counttime1 -= 1;
        }
        if (counttime1 == 0)
        {
            GameTextForAll("~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~-~y~ 1 ~g~-", 2500, 3);
            counttime2 = 2;
        }
    }
    if (counttime2 > 0)
    {
        if (counttime2 > 0)
        {
            counttime2 -= 1;
        }
        if (counttime2 == 0)
        {
            activecount = 0;
            for (new allplayers = 0; allplayers < MAX_PLAYERS; allplayers++) PlayerPlaySound(allplayers, 1056, 0.0, 0.0, 0.0);
            GameTextForAll("~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~g~-]-~y~START~g~-]-", 2000, 3);
        }
    }
    if (minutes == 15 && seconds == 0 || minutes == 35 && seconds == 0 || minutes == 50 && seconds == 0)
    {
        if (dmonArena == 1)
        {
            dmonArena = 2;
        }
        if (dmonArena == 2)
        {
            dmonArena = 1;
        }
        SendClientMessageToAll(0xFFFF81FF, "DM Area: Арената на DM се смени!");
        for (new i = 0; i < MAX_PLAYERS; i++)
        {
            IfPlayerInDmonChangePos(i);
        }
    }
    if (deathmatchEndTimer > 0)
    {
        if (deathmatchEndTimer > 0)
        {
            deathmatchEndTimer--;
        }
        if (deathmatchEndTimer == 60)
        {
            SendClientMessageToAll(COLOR_DEATHMATCH, "Deathmatch: Битката ще свърши след 1 минута!");
        }
        if (deathmatchEndTimer == 0)
        {
            new mostKiller = BestDMKiller();
            GivePlayerCMN1Status(mostKiller);
            cmn1Mission[mostKiller] = MISSION_DEATHMATCH;
            SetPlayerToLastCoors(mostKiller);
            format(string256, 256, "Deathmatch: Победител в битката е %s с %d убийства и той/тя печели %d", GetPlayerNickname(mostKiller), cmn1Money);
            SendClientMessageToAll(COLOR_DEATHMATCH, string256);
            GivePlayerWantedLevel(mostKiller, 1, "Убийство");
            format(string256, 256, "CMN1: %s е заподозрян в убийства, убий го и ще получиш CMN1 Kill.", GetPlayerNickname(mostKiller));
            SendClientMessageToAll(0xF97804FF, string256);
            SendClientMessage(mostKiller, 0xF97804FF, "CMN1: Трябва да оцелееш 5 минути за да не си преследван повече.");
            if (missionActive == MISSION_DEATHMATCH)
            {
                missionActive = MISSION_NONE;
            }
        }
    }

    if (streetRaceStartTimer > 0)
    {
        if (streetRaceStartTimer > 0)
        {
            streetRaceStartTimer--;
        }
        if (streetRaceStartTimer == 2)
        {
            FreezeSRacePlayers();
            for (new i; i < MAX_PLAYERS; i++)
            {
                if (playerInStreetRace[i] == true)
                {
                    GameTextForPlayer(i, "~r~READY", 3000, 3);
                }
            }
        }
        if (streetRaceStartTimer == 1)
        {
            for (new i; i < MAX_PLAYERS; i++)
            {
                if (playerInStreetRace[i] == true)
                {
                    GameTextForPlayer(i, "~y~SET", 3000, 3);
                }
            }
        }
        if (streetRaceStartTimer == 0)
        {
            UnfreezeSRacePlayers();
            for (new i; i < MAX_PLAYERS; i++)
            {
                if (playerInStreetRace[i] == true)
                {
                    GameTextForPlayer(i, "~g~GO", 3000, 3);
                    GiveSRaceFirstCheckpoint(i);
                }
            }
            //streetRaceTimerToEnd=3*60;
            streetRacePositionIndex = 1;
            streetRaceStarted = true;
            SendClientMessageToAll(COLOR_STREETRACE, "Streetrace: Състезанието започна, успех на всички участници!");
        }
    }


    if (streetRaceTimerToEnd > 0)
    {
        if (streetRaceTimerToEnd > 0)
        {
            streetRaceTimerToEnd--;
        }
        if (streetRaceTimerToEnd == 0)
        {
            SendClientMessageToAll(COLOR_STREETRACE, "Streetrace: Състезанието завърши, поздравления на победителите!");
            streetRaceStarted = false;
            streetRacePlayers = 0;
            streetRaceStartTimer = 0;
            streetRaceTimerToEnd = 0;
            for (new i; i < MAX_PLAYERS; i++)
            {
                if (IsPlayerConnected(i))
                {
                    streetRacePlayerColorChange[i] = 0;
                    playerInStreetRace[i] = false;
                    RestartPlayerColor(i);
                }
            }
            if (missionActive == MISSION_STREETRACE)
            {
                missionActive = MISSION_NONE;
            }
        }
    }


    if (deathmatchStartTimer > 0)
    {
        if (deathmatchStartTimer > 0)
        {
            deathmatchStartTimer--;
        }
        if (deathmatchStartTimer == 2)
        {
            for (new i; i < MAX_PLAYERS; i++)
            {
                if (playerInDeathmatch[i] == true)
                {
                    GameTextForPlayer(i, "~r~READY", 3000, 3);
                }
            }
        }
        if (deathmatchStartTimer == 1)
        {
            for (new i; i < MAX_PLAYERS; i++)
            {
                if (playerInDeathmatch[i] == true)
                {
                    GameTextForPlayer(i, "~y~SET", 3000, 3);
                }
            }
        }
        if (deathmatchStartTimer == 0)
        {
            for (new i; i < MAX_PLAYERS; i++)
            {
                if (playerInDeathmatch[i] == true)
                {
                    GameTextForPlayer(i, "~g~GO", 3000, 3);
                }
            }
            deathmatchEndTimer = 3 * 60;
            deathmatchStarted = true;
            SendClientMessageToAll(COLOR_DEATHMATCH, "Deathmatch: Битката започна, успех на всички участници!");
        }
    }
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        //[i] > OPEN
        if (PlayerInfo[i][pFMuted] > 0 && PlayerInfo[i][pFMuted] < 1000000000000)
        {
            if (PlayerInfo[i][pFMuted] > 0)
            {
                PlayerInfo[i][pFMuted]--;
            }
            if (PlayerInfo[i][pFMuted] <= 0)
            {
                format(string256, 256, "[FACTION CHAT] %s was FACTION unmuted by THE SERVER. [Reason: Timed Out]");
                for (new allPlayersInGang = 0; allPlayersInGang < MAX_PLAYERS; allPlayersInGang++)
                {
                    if (PlayerInfo[allPlayersInGang][pTeam] == PlayerInfo[i][pTeam])
                    {
                        SendClientMessage(allPlayersInGang, 0x33CCFFFF, string256);
                    }
                }
            }
        }
        //goto 1s

        if (playerInStreetRace[i] == true && streetRaceStarted == true)
        {
            streetRaceSecondsCounter[i] += 1;
        }

        if (cmn1PlayerColorChange[i] > 0)
        {
            if (cmn1PlayerColorChange[i] > 0)
            {
                cmn1PlayerColorChange[i]--;
            }
            if (cmn1PlayerColorChange[i] == 1)
            {
                if (cmn1[i] == 1)
                {
                    SetPlayerColor(i, PLAYER_CMN1_GRAD);
                }
            }
            if (cmn1PlayerColorChange[i] == 0)
            {
                if (cmn1[i] == 1)
                {
                    SetPlayerColor(i, PLAYER_CMN1_ORANGE);
                    cmn1PlayerColorChange[i] = 2;
                }
            }
        }

        if (streetRacePlayerColorChange[i] > 0)
        {
            if (streetRacePlayerColorChange[i] > 0)
            {
                streetRacePlayerColorChange[i]--;
            }
            if (streetRacePlayerColorChange[i] == 1)
            {
                if (playerInStreetRace[i] == true)
                {
                    SetPlayerColor(i, PLAYER_RACE_GREEN);
                }
            }
            if (streetRacePlayerColorChange[i] == 0)
            {
                if (playerInStreetRace[i] == true)
                {
                    SetPlayerColor(i, PLAYER_RACE_BLUE);
                    streetRacePlayerColorChange[i] = 2;
                }
            }
        }

        if (gettime() - AFKDetect[i] > 1)
        {
            if (IsPlayerConnected(i))
            {
                GivePlayerAfkTimerSecond(i);
            }
        }

        if (PlayerInfo[i][pFuel] > 0)
        {
            if (PlayerInfo[i][pFuel] > 0)
            {
                PlayerInfo[i][pFuel]--;
            }
            if (PlayerInfo[i][pFuel] <= 0)
            {
                PlayerInfo[i][pFuel] = 70;
                if (vehfuel[GetPlayerVehicleID(i)] > -1)
                {
                    if (GetVehicleModel(GetPlayerVehicleID(i)) != 481 &&
                            GetVehicleModel(GetPlayerVehicleID(i)) != 509 &&
                            GetVehicleModel(GetPlayerVehicleID(i)) != 510 &&
                            GetVehicleModel(GetPlayerVehicleID(i)) != 481)
                    {
                        vehfuel[GetPlayerVehicleID(i)] -= 1;
                    }
                }
                GetVehicleHealth(GetPlayerVehicleID(i), vehhealth[i]);
                if (GetVehicleModel(GetPlayerVehicleID(i)) != 481 &&
                        GetVehicleModel(GetPlayerVehicleID(i)) != 509 &&
                        GetVehicleModel(GetPlayerVehicleID(i)) != 510 &&
                        GetVehicleModel(GetPlayerVehicleID(i)) != 481)
                {
                    if (speedo[i] == 0)
                    {
                        if (kmh[i] == 0)
                        {
                            format(stringvehicle[i], 115, "~w~Speed: %dkm/h~n~~g~Health: %.0f~n~~r~Fuel: %dL", GetVehicleKmh(GetPlayerVehicleID(i)), vehhealth[i], vehfuel[GetPlayerVehicleID(i)]);
                            TextDrawSetString(vehstatus[i], stringvehicle[i]);
                        }
                        else
                        {
                            new vehicleid, Float:speed_x, Float:speed_y, Float:speed_z, final_speed_int;
                            vehicleid = GetPlayerVehicleID(i);
                            GetVehicleVelocity(vehicleid, speed_x, speed_y, speed_z);
                            final_speed_int = GetVehicleKmh(vehicleid);
                            format(stringvehicle[i], 115, "~w~Speed: %dm/s~n~~g~Health: %.0f~n~~r~Fuel: %dL", final_speed_int, vehhealth[i], vehfuel[GetPlayerVehicleID(i)]);
                            TextDrawSetString(vehstatus[i], stringvehicle[i]);
                        }
                    }
                }
                else
                {
                    if (speedo[i] == 0)
                    {
                        if (kmh[i] == 0)
                        {
                            format(stringvehicle[i], 115, "~w~Speed: %dkm/h~n~~g~Health: %.0f", GetVehicleKmh(GetPlayerVehicleID(i)), vehhealth[i]);
                            TextDrawSetString(vehstatus[i], stringvehicle[i]);
                        }
                        else
                        {
                            new vehicleid, Float:speed_x, Float:speed_y, Float:speed_z, final_speed_int;
                            vehicleid = GetPlayerVehicleID(i);
                            GetVehicleVelocity(vehicleid, speed_x, speed_y, speed_z);
                            final_speed_int = GetVehicleKmh(vehicleid);
                            format(stringvehicle[i], 115, "~w~Speed: %dm/s~n~~g~Health: %.0f", final_speed_int, vehhealth[i]);
                            TextDrawSetString(vehstatus[i], stringvehicle[i]);
                        }
                    }
                }
            }
        }

        if (PlayerInfo[i][pAFKBack] > 0)
        {
            PlayerInfo[i][pAFKBack]--;
        }
        if (PlayerInfo[i][pBankSpawn] > 0)
        {
            if (PlayerInfo[i][pBankSpawn] > 0)
            {
                PlayerInfo[i][pBankSpawn]--;
            }
            if (PlayerInfo[i][pBankSpawn] <= 0)
            {
                TogglePlayerControllable(i, 1);
            }
        }
        if (PlayerInfo[i][pHealT] > 0)
        {
            if (PlayerInfo[i][pHealT] > 0)
            {
                PlayerInfo[i][pHealT]--;
            }
            if (PlayerInfo[i][pHealT] <= 0)
            {
                SendClientMessage(i, 0xFFFF00FF, "Вече можеш да се хелнеш отново!");
            }
        }
        if (PlayerInfo[i][pFixT] > 0)
        {
            if (PlayerInfo[i][pFixT] > 0)
            {
                PlayerInfo[i][pFixT]--;
            }
            if (PlayerInfo[i][pFixT] <= 0)
            {
                PlayerInfo[i][pFixT] = 0;
                SendClientMessage(i, 0xFFFF00FF, "Вече можеш да използваш /fix и /tires отново!");
            }
        }
        if (PlayerInfo[i][pVGuns] > 0)
        {
            if (PlayerInfo[i][pVGuns] > 0)
            {
                PlayerInfo[i][pVGuns]--;
            }
            if (PlayerInfo[i][pVGuns] <= 0)
            {
                PlayerInfo[i][pVGuns] = 0;
                SendClientMessage(i, 0xFFFF00FF, "Вече можеш да използваш /vguns отново!");
            }
        }
        if (PlayerInfo[i][pRefuel20LitTimer] > 0)
        {
            if (PlayerInfo[i][pRefuel20LitTimer] > 0)
            {
                PlayerInfo[i][pRefuel20LitTimer]--;
            }
            if (PlayerInfo[i][pRefuel20LitTimer] <= 0)
            {
                PlayerInfo[i][pRefuel20LitTimer] = 0;
                SendClientMessage(i, 0xFFFF00FF, "Вече можеш да презаредиш отново!");
            }
        }
        if (PlayerInfo[i][pKick] > 0)
        {
            if (PlayerInfo[i][pKick] > 0)
            {
                PlayerInfo[i][pKick]--;
            }
            if (PlayerInfo[i][pKick] <= 0)
            {
                hideexitserver[i] = 1;
                PlayerInfo[i][pKick] = 0;
                Kick(i);
            }
        }
        if (PlayerInfo[i][pReSpawn] > 0)
        {
            if (PlayerInfo[i][pReSpawn] > 0)
            {
                PlayerInfo[i][pReSpawn]--;
            }
            if (PlayerInfo[i][pReSpawn] <= 0)
            {
                SpawnPlayer(i);
            }
        }

        if (PlayerInfo[i][pStartIntro] > 0)
        {
            if (PlayerInfo[i][pStartIntro] > 0)
            {
                PlayerInfo[i][pStartIntro]--;
            }
            if (PlayerInfo[i][pStartIntro] <= 0)
            {
                TextDrawShowForPlayer(i, intensetext);
                PlayerInfo[i][pIntro] = 1;
            }
        }
        if (PlayerInfo[i][pIntro] > 0)
        {
            if (PlayerInfo[i][pIntro] > 0)
            {
                PlayerInfo[i][pIntro]--;
            }
            if (PlayerInfo[i][pIntro] <= 0)
            {
                new stringaaaa[256];
                format(stringaaaa, 115, "%s {FFFFFF}влезе в сървъра !", GetPlayerNickname(i));
                if (ingmx == 0)
                    SendClientMessageToAll(0x00e600FF, stringaaaa);
                for (new i2 = 0; i2 < 16; i2++)
                {
                    SendClientMessage(i, 0xFFFFFFFF, "");
                }
                TextDrawShowForPlayer(i, Intro[0]);
                PlayerInfo[i][pIntro1] = 2;
            }
        }
        if (PlayerInfo[i][pIntro1] > 0)
        {
            if (PlayerInfo[i][pIntro1] > 0)
            {
                PlayerInfo[i][pIntro1]--;
            }
            if (PlayerInfo[i][pIntro1] <= 0)
            {
                TextDrawShowForPlayer(i, Intro[1]);
                PlayerInfo[i][pIntro2] = 2;
            }
        }
        if (PlayerInfo[i][pIntro2] > 0)
        {
            if (PlayerInfo[i][pIntro2] > 0)
            {
                PlayerInfo[i][pIntro2]--;
            }
            if (PlayerInfo[i][pIntro2] <= 0)
            {
                TextDrawShowForPlayer(i, Intro[2]);
                PlayerInfo[i][pIntro3] = 2;
            }
        }
        if (PlayerInfo[i][pIntro3] > 0)
        {
            if (PlayerInfo[i][pIntro3] > 0)
            {
                PlayerInfo[i][pIntro3]--;
            }
            if (PlayerInfo[i][pIntro3] <= 0)
            {
                TextDrawShowForPlayer(i, Intro[3]);
                PlayerInfo[i][pIntro4] = 3;
            }
        }
        if (PlayerInfo[i][pIntro4] > 0)
        {
            if (PlayerInfo[i][pIntro4] > 0)
            {
                PlayerInfo[i][pIntro4]--;
            }
            if (PlayerInfo[i][pIntro4] <= 0)
            {
                TextDrawShowForPlayer(i, Intro[4]);
                PlayerInfo[i][pIntro5] = 3;
            }
        }
        if (PlayerInfo[i][pIntro5] > 0)
        {
            if (PlayerInfo[i][pIntro5] > 0)
            {
                PlayerInfo[i][pIntro5]--;
            }
            if (PlayerInfo[i][pIntro5] <= 0)
            {
                TextDrawShowForPlayer(i, Intro[5]);
                PlayerInfo[i][pIntro6] = 3;
            }
        }

        if (PlayerInfo[i][pIntro6] > 0)
        {
            if (PlayerInfo[i][pIntro6] > 0)
            {
                PlayerInfo[i][pIntro6]--;
            }
            if (PlayerInfo[i][pIntro6] <= 0)
            {
                TextDrawHideForPlayer(i, Intro[0]);
                TextDrawHideForPlayer(i, Intro[1]);
                TextDrawHideForPlayer(i, Intro[2]);
                TextDrawHideForPlayer(i, Intro[3]);
                TextDrawHideForPlayer(i, Intro[4]);
                TextDrawHideForPlayer(i, Intro[5]);
                TextDrawShowForPlayer(i, ClockDate);
                //ForceClassSelection(i);
                new randomcamera = random(15);
                if (randomcamera <= 7)
                {
                    InterpolateCameraPos(i, 2056.4150, 775.4052, 92.4422, 2108.5623, 2804.5188, 124.1592, 160000, CAMERA_MOVE);
                    InterpolateCameraLookAt(i, 2058.1169, 937.4815, 94.9746, 2113.9653, 3004.3350, 127.2826, 160000, CAMERA_MOVE);
                }
                if (randomcamera >= 8)
                {
                    InterpolateCameraPos(i, 2995.4114, -1630.6260, 108.6881, -11.1817, -1708.6993, 122.7864, 160000, CAMERA_MOVE);
                    InterpolateCameraLookAt(i, 2897.1233, -1633.1787, 109.1490, -99.3358, -1710.9866, 123.1997, 160000, CAMERA_MOVE);
                }
                if (!IsPlayerNotRegistered(i))
                {
                    format(string256, 256, "");
                    strins(string256, "{00FF00}Моля, прочетете условията и правилата на сървъра!\n\n", strlen(string256));
                    strins(string256, "{FFFFFF}1.Всякакъв флууд(повтаряне) е забранено и дразнещно!\n", strlen(string256));
                    strins(string256, "{008000}2.Всякакъв вид писане на неценцензурирани думи се наказва за неупределен период от време (по преценка на админа)!\n", strlen(string256));
                    strins(string256, "{FF0000}3.Използването на всякакви хакове е строго забранено и наказуемо!\n", strlen(string256));
                    strins(string256, "{FFFFFF}- Ако има хакери докладвайте с /report а не да пишете в чата!\n", strlen(string256));
                    strins(string256, "{008000}4.Всякакви моднати скинове/оръжия/превозни средства са забранени!\n", strlen(string256));
                    strins(string256, "{FF0000}5.Използването на имена като или близки до тези на админи се наказва!\n", strlen(string256));
                    strins(string256, "{FFFFFF}6.Даването на всякакви IP-та на сървъри в сървъра и карането на хора да влизат в тях е забранено!\n", strlen(string256));
                    strins(string256, "{008000}7.Забранено е използването на PEDSTATS и CHEAT ENGINE!\n", strlen(string256));
                    strins(string256, "{FF0000}- Също така са забранени всякакви бъгове като бърз скин, SAWNOFF, noreload и т.н.\n", strlen(string256));
                    strins(string256, "{FFFFFF}8.Забранено е да лъжете наказва се с заглушаване в чата.\n", strlen(string256));
                    strins(string256, "{008000}9.Забранено е биенето на играчи, които участват в Street Race!\n", strlen(string256));
                    strins(string256, "{FF0000}- Наказва се по преценка на админа\n\n", strlen(string256));
                    strins(string256, "{00FF00}За да видите всички правила на сървъра напишете {FF0000}/rules\n\n", strlen(string256));
                    strins(string256, "{808040}Ние можем по всяко едно време да забраним достъпа ви до една или друга наша услуга дори и тя да бъде платена.\n", strlen(string256));
                    strins(string256, "{808040}Ние можем да спрем сайта и сървъра по всяко едно време поради технически или други причини.\n", strlen(string256));
                    strins(string256, "{808040}Ние сме с пълното си право да блокираме достъпа ви до сайта и сървъра на всеки един играч, ако за нас той не спазва правилата.\n", strlen(string256));
                    strins(string256, "{808040}Ако не влизате повече от месец, вашият акаунт ще бъде блокиран от сървъра!\n\n", strlen(string256));
                    strins(string256, "{00FF00}Съгласявате ли се да спазвате правилата и условията на сървъра?\n", strlen(string256));
                    ShowPlayerDialog(i, 2, DIALOG_STYLE_MSGBOX, "{FFFFFF}ПРАВИЛА{008000} И {FF0000}УСЛОВИЯ", string256, "ДА", "НЕ");
                }
                else
                {
                    format(string256, 256, "{FFFFFF}Добре дошъл {40BF00}%s\n{FFFFFF}Моля влез в акаунта като въведеш паролата отдолу:", GetPlayerNickname(i));
                    ShowPlayerDialog(i, 1, DIALOG_STYLE_PASSWORD, "Влизане:", string256, "Влез", "Излез");
                }
            }
        }

        if (PlayerInfo[i][pTextSpamTimer] > 0)
        {
            if (PlayerInfo[i][pTextSpamTimer] > 0)
            {
                PlayerInfo[i][pTextSpamTimer]--;
            }
            if (PlayerInfo[i][pTextSpamTimer] <= 0)
            {
                textspam[i] = 0;
            }
        }
        if (PlayerInfo[i][pPlayerRefuelTimer] > 0)
        {
            if (PlayerInfo[i][pPlayerRefuelTimer] > 0)
            {
                PlayerInfo[i][pPlayerRefuelTimer]--;
            }
        }
        if (PlayerInfo[i][pInfiniteNosTimer] > 0)
        {
            if (PlayerInfo[i][pInfiniteNosTimer] > 0)
            {
                PlayerInfo[i][pInfiniteNosTimer]--;
            }
            if (PlayerInfo[i][pInfiniteNosTimer] <= 0)
            {
                if (PlayerInfo[i][pInfiniteNos] == 1)
                {
                    PlayerInfo[i][pInfiniteNosTimer] = 2;
                    if (IsPlayerInAnyVehicle(i))
                    {
                        AddVehicleComponent(GetPlayerVehicleID(i), 1010);
                    }
                }
            }
        }
        if (PlayerInfo[i][pCommandSpamTimer] > 0)
        {
            if (PlayerInfo[i][pCommandSpamTimer] > 0)
            {
                PlayerInfo[i][pCommandSpamTimer]--;
            }
            if (PlayerInfo[i][pCommandSpamTimer] <= 0)
            {
                commandspam[i] = 0;
            }
        }

        if (PlayerInfo[i][pHookT] > 0)
        {
            if (PlayerInfo[i][pHookT] > 0)
            {
                PlayerInfo[i][pHookT]--;
            }
            if (PlayerInfo[i][pHookT] <= 0)
            {
                CaughtFish(i);
            }
        }

        if (PlayerInfo[i][pMinigamesTimer] > 0)
        {
            if (PlayerInfo[i][pMinigamesTimer] > 0)
            {
                PlayerInfo[i][pMinigamesTimer]--;
            }
            if (PlayerInfo[i][pMinigamesTimer] <= 0)
            {
                //SendClientMessage(i,0xFFFF00FF, "Вече можеш да се хелнеш отново!");
            }
        }

        if (PlayerInfo[i][pMoonshineEffectTime] > 0)
        {
            if (PlayerInfo[i][pMoonshineEffectTime] > 0)
            {
                PlayerInfo[i][pMoonshineEffectTime]--;
            }
            if (PlayerInfo[i][pMoonshineEffectTime] <= 0)
            {
                if (rezachka[i] == 0) RemovePlayerWeapon(i, 9);
                SetPlayerWeather(i, 1);
                SendClientMessage(i, 0xFF2D2DFF, "Действието на спиртното питие премина!");
            }
        }
        if (PlayerInfo[i][pWeedEffectTime] > 0)
        {
            if (PlayerInfo[i][pWeedEffectTime] > 0)
            {
                PlayerInfo[i][pWeedEffectTime]--;
            }
            if (PlayerInfo[i][pWeedEffectTime] <= 0)
            {
                if (rezachka[i] == 0) RemovePlayerWeapon(i, 9);
                SetPlayerWeather(i, 1);
                SendClientMessage(i, 0xFF2D2DFF, "Действието на тревата премина!");
            }
        }
        if (PlayerInfo[i][pCocaineEffectTime] > 0)
        {
            if (PlayerInfo[i][pCocaineEffectTime] > 0)
            {
                PlayerInfo[i][pCocaineEffectTime]--;
            }
            if (PlayerInfo[i][pCocaineEffectTime] <= 0)
            {
                if (rezachka[i] == 0) RemovePlayerWeapon(i, 9);
                SetPlayerWeather(i, 1);
                SendClientMessage(i, 0xFF2D2DFF, "Действието на кокаина премина!");
            }
        }
        if (PlayerInfo[i][pHeroinEffectTime] > 0)
        {
            if (PlayerInfo[i][pHeroinEffectTime] > 0)
            {
                PlayerInfo[i][pHeroinEffectTime]--;
            }
            if (PlayerInfo[i][pHeroinEffectTime] <= 0)
            {
                if (rezachka[i] == 0) RemovePlayerWeapon(i, 9);
                SetPlayerWeather(i, 1);
                SendClientMessage(i, 0xFF2D2DFF, "Действието на хероина премина!");
            }
        }

        if (PlayerInfo[i][pHideDMONKillText] > 0)
        {
            if (PlayerInfo[i][pHideDMONKillText] > 0)
            {
                PlayerInfo[i][pHideDMONKillText]--;
            }
            if (PlayerInfo[i][pHideDMONKillText] <= 0)
            {
                TextDrawHideForPlayer(i, DMONKillText);
            }
        }
        if (PlayerInfo[i][pDmon20SecWait] > 0)
        {
            if (PlayerInfo[i][pDmon20SecWait] > 0)
            {
                PlayerInfo[i][pDmon20SecWait]--;
            }
        }

        if (PlayerInfo[i][pDuelCountTimer] > 0)
        {
            if (PlayerInfo[i][pDuelCountTimer] > 0)
            {
                PlayerInfo[i][pDuelCountTimer]--;
            }
            if (PlayerInfo[i][pDuelCountTimer] <= 0)
            {
                GameTextForPlayer(i, "~w~3", 3000, 3);
                GameTextForPlayer(duelsend[i], "~w~3", 3000, 3);
                PlayerInfo[i][pDuelCountTimer2] = 2;
            }
        }
        if (PlayerInfo[i][pDuelCountTimer2] > 0)
        {
            if (PlayerInfo[i][pDuelCountTimer2] > 0)
            {
                PlayerInfo[i][pDuelCountTimer2]--;
            }
            if (PlayerInfo[i][pDuelCountTimer2] <= 0)
            {
                GameTextForPlayer(i, "~w~2", 3000, 3);
                GameTextForPlayer(duelsend[i], "~w~2", 3000, 3);
                PlayerInfo[i][pDuelCountTimer3] = 2;
            }
        }
        if (PlayerInfo[i][pDuelCountTimer3] > 0)
        {
            if (PlayerInfo[i][pDuelCountTimer3] > 0)
            {
                PlayerInfo[i][pDuelCountTimer3]--;
            }
            if (PlayerInfo[i][pDuelCountTimer3] <= 0)
            {
                GameTextForPlayer(i, "~w~1", 3000, 3);
                GameTextForPlayer(duelsend[i], "~w~1", 3000, 3);
                PlayerInfo[i][pDuelCountTimer4] = 2;
            }
        }
        if (PlayerInfo[i][pDuelCountTimer4] > 0)
        {
            if (PlayerInfo[i][pDuelCountTimer4] > 0)
            {
                PlayerInfo[i][pDuelCountTimer4]--;
            }
            if (PlayerInfo[i][pDuelCountTimer4] <= 0)
            {
                GameTextForPlayer(i, "~r~FIGHT", 3000, 3);
                GameTextForPlayer(duelsend[i], "~r~FIGHT", 3000, 3);
                TogglePlayerControllable(i, 1);
                TogglePlayerControllable(duelsend[i], 1);
            }
        }

        if (PlayerInfo[i][pAdvertTime] > 0)
        {
            if (PlayerInfo[i][pAdvertTime] > 0)
            {
                PlayerInfo[i][pAdvertTime]--;
            }
            if (PlayerInfo[i][pAdvertTime] <= 0)
            {
                SendClientMessage(i, 0xFAF305FF, "Вече отново можеш да пуснеш обява!");
            }
        }
        if (PlayerInfo[i][pRefuelCan] > 0)
        {
            if (PlayerInfo[i][pRefuelCan] > 0)
            {
                PlayerInfo[i][pRefuelCan]--;
            }
            if (PlayerInfo[i][pRefuelCan] <= 0)
            {
                new string156[156];
                GameTextForPlayer(i, "  ", 1000, 3);
                TogglePlayerControllable(i, 1);
                vehfuel[GetPlayerVehicleID(i)] += refuelcan[i];
                format(string156, 156, "Превозното средство е заредено със {C14124}%d L.", refuelcan[i]);
                SendClientMessage(i, 0xFFFFFFFF, string156);
            }
        }
        if (PlayerInfo[i][pRefuelTankIFC] > 0)
        {
            if (PlayerInfo[i][pRefuelTankIFC] > 0)
            {
                PlayerInfo[i][pRefuelTankIFC]--;
            }
            if (PlayerInfo[i][pRefuelTankIFC] <= 0)
            {
                new string156[156];
                TogglePlayerControllable(i, 1);
                GameTextForPlayer(i, "  ", 1000, 3);
                vehfuel2[GetVehicleTrailer(GetPlayerVehicleID(i))] += refuelcisterna[i];
                format(string156, 156, "Цистерната е заредена със {C14124}%d L{FFFFFF}.", refuelcisterna[i]);
                SendClientMessage(i, 0xFFFFFFFF, string156);
                new stringveha[115];
                format(stringveha, 115, "~n~~n~~n~~y~PT: %dL", vehfuel2[GetVehicleTrailer(GetPlayerVehicleID(i))]);
                TextDrawSetString(vehstatus2[i], stringveha);
            }
        }
        if (PlayerInfo[i][pRefuelTube] > 0)
        {
            if (PlayerInfo[i][pRefuelTube] > 0)
            {
                PlayerInfo[i][pRefuelTube]--;
            }
            if (PlayerInfo[i][pRefuelTube] <= 0)
            {
                new string156[156];
                TogglePlayerControllable(i, 1);
                GameTextForPlayer(i, "  ", 1000, 3);
                PlayerInfo[i][pFuelcase] += refuelcan[i];
                format(string156, 156, "Тубата е заредена със {C14124}%d L{FFFFFF} за {00BF00}$%d.", refuelcan[i], refuelcan[i] * 5);
                SendClientMessage(i, 0xFFFFFFFF, string156);
            }
        }

        if (PlayerInfo[i][pAfterWork] > 0)
        {
            if (PlayerInfo[i][pAfterWork] > 0)
            {
                PlayerInfo[i][pAfterWork]--;
            }
        }

        if (PlayerInfo[i][pPizzaTimerWorkAgain] > 0)
        {
            if (PlayerInfo[i][pPizzaTimerWorkAgain] > 0)
            {
                PlayerInfo[i][pPizzaTimerWorkAgain]--;
            }
            if (PlayerInfo[i][pPizzaTimerWorkAgain] <= 0)
            {
                SendClientMessage(i, 0xB35900FF, "Вече можеш да работиш Pizza отново!");
            }
        }
        if (PlayerInfo[i][pDeliverTimerWorkAgain] > 0)
        {
            if (PlayerInfo[i][pDeliverTimerWorkAgain] > 0)
            {
                PlayerInfo[i][pDeliverTimerWorkAgain]--;
            }
            if (PlayerInfo[i][pDeliverTimerWorkAgain] <= 0)
            {
                SendClientMessage(i, 0xB35900FF, "Вече можеш да работиш Deliver отново!");
            }
        }
        if (PlayerInfo[i][pBusTimerWorkAgain] > 0)
        {
            if (PlayerInfo[i][pBusTimerWorkAgain] > 0)
            {
                PlayerInfo[i][pBusTimerWorkAgain]--;
            }
            if (PlayerInfo[i][pBusTimerWorkAgain] <= 0)
            {
                SendClientMessage(i, 0xB35900FF, "Вече можеш да работиш Bus отново!");
            }
        }
        if (PlayerInfo[i][pCoalmineTimerWorkAgain] > 0)
        {
            if (PlayerInfo[i][pCoalmineTimerWorkAgain] > 0)
            {
                PlayerInfo[i][pCoalmineTimerWorkAgain]--;
            }
            if (PlayerInfo[i][pCoalmineTimerWorkAgain] <= 0)
            {
                SendClientMessage(i, 0xB35900FF, "Вече можеш да работиш Coalmine отново!");
            }
        }
        if (PlayerInfo[i][pPilotTimerWorkAgain] > 0)
        {
            if (PlayerInfo[i][pPilotTimerWorkAgain] > 0)
            {
                PlayerInfo[i][pPilotTimerWorkAgain]--;
            }
            if (PlayerInfo[i][pPilotTimerWorkAgain] <= 0)
            {
                SendClientMessage(i, 0xB35900FF, "Вече можеш да работиш Pilot отново!");
            }
        }
        if (PlayerInfo[i][pSweeperTimerWorkAgain] > 0)
        {
            if (PlayerInfo[i][pSweeperTimerWorkAgain] > 0)
            {
                PlayerInfo[i][pSweeperTimerWorkAgain]--;
            }
            if (PlayerInfo[i][pSweeperTimerWorkAgain] <= 0)
            {
                SendClientMessage(i, 0xB35900FF, "Вече можеш да работиш Sweeper отново!");
            }
        }

        if (PlayerInfo[i][pActiveCheck] > 0)
        {
            if (PlayerInfo[i][pActiveCheck] > 0)
            {
                PlayerInfo[i][pActiveCheck]--;
            }
            if (PlayerInfo[i][pActiveCheck] <= 0)
            {
                if (PlayerInfo[i][pAFK] > 0)
                {
                    PlayerInfo[i][pAFK] += 1;
                }
                PlayerInfo[i][pLastPayday] += 1;
                PlayerInfo[i][pActiveCheck] = 60;
            }
        }

        if (PlayerInfo[i][pCmn1Timer] > 0)
        {
            if (PlayerInfo[i][pCmn1Timer] > 0)
            {
                PlayerInfo[i][pCmn1Timer]--;
            }
            if (PlayerInfo[i][pCmn1Timer] <= 0)
            {
                new cmn1string[256];
                format(cmn1string, 256, "CMN1: %s оцеля след 5 минутно преследване и вече не е заподозрян.", GetPlayerNickname(i));
                SendClientMessageToAll(0xF97804FF, cmn1string);
                if (cmn1Mission[i] == MISSION_MONEYBOX)
                {
                    PlayerInfo[i][pMoneyboxSuccess] += 1;
                    if (PlayerInfo[i][pMoneyboxSuccess] == 4)
                    {
                        SendClientMessage(i, 0xF2E93EFF, "Ти събра 4 успешни Moneybox мисии и за награда получаваш + 8EP");
                        GivePlayerEP(i, 8);
                        PlayerInfo[i][pMoneyboxSuccess] = 0;
                    }
                }
                if (cmn1Mission[i] == MISSION_DEATHMATCH)
                {
                    PlayerInfo[i][pDeathmatchSuccess] += 1;
                    if (PlayerInfo[i][pDeathmatchSuccess] == 4)
                    {
                        SendClientMessage(i, COLOR_DEATHMATCH, "Ти събра 4 успешни Deathmatch мисии и за награда получаваш + 8EP");
                        GivePlayerEP(i, 8);
                        PlayerInfo[i][pDeathmatchSuccess] = 0;
                    }
                }
                if (cmn1Mission[i] == MISSION_STREETRACE)
                {
                    PlayerInfo[i][pStreetRaceSuccess] += 1;
                    if (PlayerInfo[i][pStreetRaceSuccess] == 4)
                    {
                        SendClientMessage(i, COLOR_STREETRACE, "Ти събра 4 успешни Streetrace мисии и за награда получаваш + 8EP");
                        GivePlayerEP(i, 8);
                        PlayerInfo[i][pStreetRaceSuccess] = 0;
                    }
                }
                cmn1PlayerColorChange[i] = 0;
                cmn1[i] = 0;
                RestartPlayerColor(i);
            }
        }
        if (PlayerInfo[i][pMuted] > 0)
        {
            if (PlayerInfo[i][pMuteReason] < 6)
            {
                if (PlayerInfo[i][pMuted] > 0)
                {
                    PlayerInfo[i][pMuted]--;
                }
                if (PlayerInfo[i][pMuted] <= 0)
                {
                    PlayerInfo[i][pMuteReason] = 0;
                    for (new allPlayers; allPlayers < MAX_PLAYERS; allPlayers++)
                        SendClientMessage(allPlayers, 0x00E600FF, "SERVER: %s was unmuted by THE SERVER [Reason: Timed Out]");
                }
            }
        }
        if (PlayerInfo[i][pAMuted] > 0)
        {
            if (PlayerInfo[i][pAMuted] > 0)
            {
                PlayerInfo[i][pAMuted]--;
            }
            if (PlayerInfo[i][pAMuted] <= 0)
            {
                SendClientMessage(i, 0x00E600FF, "SERVER: Ти беше отглушен от админ чата!");
            }
        }
        if (PlayerInfo[i][pPJail] > 0)
        {
            if (PlayerInfo[i][pPJail] > 0)
            {
                PlayerInfo[i][pPJail]--;
            }
            if (PlayerInfo[i][pPJail] <= 0)
            {
                SetPlayerHealth(i, 0);
                SendClientMessage(i, 0x0040FFFF, "Jail: Ти си освободен от затвора, внимавай в бъдеще!");
            }
        }
        if (PlayerInfo[i][pJail] > 0)
        {
            if (PlayerInfo[i][pJail] > 0)
            {
                PlayerInfo[i][pJail]--;
            }
            if (PlayerInfo[i][pJail] <= 0)
            {
                SetPlayerHealth(i, 0);
                for (new allPlayers; allPlayers < MAX_PLAYERS; allPlayers++)
                {
                    SendClientMessage(allPlayers, 0x00E600FF, "SERVER: %s was unjailed by THE SERVER [Reason: Timed Out]");
                }
            }
        }
    } // [i] > CLOSE
    //other timers
    if (minutes == 50 && seconds == 0)
    {
        if (missionActive == MISSION_STREETRACE)
        {
            SendClientMessageToAll(COLOR_STREETRACE, "Streetrace: Streetrace свърши и никой не успя да го спечели!");
            EndStreetRaceBeforeNewMission();
        }
        deathmatchStartTimer = 0;
        deathmatchStarted = false;
        missionActive = MISSION_DEATHMATCH;
        for (new allPlayers; allPlayers < MAX_PLAYERS; allPlayers++)
        {
            if (IsPlayerConnected(allPlayers))
            {
                if (playerInStreetRace[allPlayers] == false)
                {
                    DisablePlayerRaceCheckpoint(allPlayers);
                }
                GivePlayerDeathmatchPoint(allPlayers);
                GameTextForPlayer(allPlayers, "~w~Mission~n~~r~Deathmatch", 1000, 1);
                PlayerPlaySound(allPlayers, 1056, 0.0, 0.0, 0.0);
            }
        }
        new randomGun = randomex(1, 5);
        new gunName[30];
        if (randomGun == 1)
        {
            format(gunName, 30, "Katana");
            deathmatchGun = 8;
        }
        if (randomGun == 2)
        {
            format(gunName, 30, "Chainsaw");
            deathmatchGun = 9;
        }
        if (randomGun == 3)
        {
            format(gunName, 30, "Molotov");
            deathmatchGun = 18;
        }
        if (randomGun == 4)
        {
            format(gunName, 30, "Deagle");
            deathmatchGun = 24;
        }
        if (randomGun == 5)
        {
            format(gunName, 30, "Uzi");
            deathmatchGun = 28;
        }
        format(string256, 256, "SERVER: Време е за Deathmatch с оръжие %s! Отиди до червения маркер и чакай битката да започне!", gunName);
        SendClientMessageToAll(COLOR_DEATHMATCH, string256);
    }
    if (minutes == 30 && seconds == 0)
    {
        if (missionActive == MISSION_MONEYBOX)
        {
            whoHaveMoneyBox = -1;
        }
        missionActive = MISSION_STREETRACE;
        for (new allPlayers; allPlayers < MAX_PLAYERS; allPlayers++)
        {
            if (IsPlayerConnected(allPlayers))
            {
                if (missionActive == MISSION_MONEYBOX)
                {
                    playerWithMoneyBox[allPlayers] = false;
                    DisableAllCheckPointsWithCon(allPlayers);
                    SendClientMessage(allPlayers, 0x40BF00FF, "SERVER: Moneybox-а свърши и никой не успя да занесе раницата!"); //todo streetrace
                }
                GameTextForPlayer(allPlayers, "~w~Mission~n~~b~StreetRace", 1000, 1);
                PlayerPlaySound(allPlayers, 1056, 0.0, 0.0, 0.0);
                new stringSRace[256];
                streetRaceTypeIndex = randomex(1, MAX_RACES);
                GivePlayerStreetRacePoint(allPlayers);
                format(stringSRace, 256, "SERVER: Време е за Streetrace тип %s! Отиди до червения маркер и чакай състезанието да започне!", StreetRaceInfo[streetRaceTypeIndex][stTypeName]);
                SendClientMessage(allPlayers, COLOR_STREETRACE, stringSRace);
                if (StreetRaceInfo[streetRaceTypeIndex][stWinTime] > 0)
                {
                    format(stringSRace, 256, "Streetrace: Най-доброто време на това състезание е %d секунди, отбелязано от %s", StreetRaceInfo[streetRaceTypeIndex][stWinTime], StreetRaceInfo[streetRaceTypeIndex][stWinner]);
                    SendClientMessage(allPlayers, COLOR_STREETRACE, stringSRace);
                }
                else if (StreetRaceInfo[streetRaceTypeIndex][stWinTime] == 0)
                {
                    format(stringSRace, 256, "Streetrace: Все още няма рекорд за това състезание");
                    SendClientMessage(allPlayers, COLOR_STREETRACE, stringSRace);
                }
            }
        }
    }
    if (minutes == 10 && seconds == 0)
    {
        if (missionActive == MISSION_DEATHMATCH && deathmatchEndTimer == 0)
        {
            for (new allPlayers; allPlayers < MAX_PLAYERS; allPlayers++)
            {
                SendClientMessage(allPlayers, COLOR_DEATHMATCH, "SERVER: Deathmatch свърши и никой не успя да го спечели!");
                DisableAllCheckPointsWithCon(allPlayers);
            }
        }
        missionActive = MISSION_MONEYBOX;
        moneyBoxCPID = random(allMoneyBoxCheckPoints);
        for (new allPlayers; allPlayers < MAX_PLAYERS; allPlayers++)
        {
            GivePlayerMoneyBoxPoint(allPlayers);
            GameTextForPlayer(allPlayers, "~w~Mission~n~~g~Moneybox", 1000, 1);
            PlayerPlaySound(allPlayers, 1056, 0.0, 0.0, 0.0);
            SendClientMessage(allPlayers, 0x40BF00FF, "SERVER: Време е за Moneybox! Отиди до червения маркер и вземи куфара с пари!");
        }
    }
    if (serverrestarttimer > 0)
    {
        if (serverrestarttimer > 0)
        {
            serverrestarttimer--;
        }
        if (serverrestarttimer == 3)
        {
            for (new alb = 1; alb < MAX_BIZZ; alb++)
            {
                SaveBiz(alb);
            }
            for (new allPlayers; allPlayers < MAX_PLAYERS; allPlayers++)
            {
                SavePlayerStats(allPlayers);
            }
            for (new i = 0; i < MAX_TEAMS; i++)
            {
                SaveFaction(i);
            }
        }
        if (serverrestarttimer == 0)
        {
            ingmx = 1;
            SendRconCommand("gmx");
        }
    }
}
//==============================================================================
//          -- > /// GeneralTimer1s ///
//==============================================================================



//==============================================================================
//          -- > GeneralTimer1sFaction
//==============================================================================
stock GeneralTimer1sFaction()
{
    for (new i = 0; i < MAX_TEAMS; i++)
    {
        if (TeamInfo[i][tAttackTurfTime] > 0)
        {
            if (TeamInfo[i][tAttackTurfTime] > 0)
            {
                TeamInfo[i][tAttackTurfTime]--;
            }
            if (TeamInfo[i][tAttackTurfTime] == 0)
            {
                SendFactionMessage(i, 0xC800FFFF, "[FACTION] Можете да атакувате отново територия.");
                SaveFaction(i);
            }
        }

        if (turfAttackTimer[i] > 0)
        {
            if (turfAttackTimer[i] > 0)
            {
                turfAttackTimer[i]--;
            }
            if (turfAttackTimer[i] == 0)
            {
                startturf = 0;
                new turfAttackedID = TeamInfo[i][tTurfAttacked];
                new oldTurfOwner = TurfInfo[turfAttackedID][TurfOwner];
                format(string256, 256, "[FACTION CHAT] Твоята банда/мафия превзе територията %s, която принадлежеше на {FF0000}%s", TurfInfo[turfAttackedID][TurfName],
                       TeamInfo[oldTurfOwner][tName]);
                format(string256, 256, "Turf War: Ти получи 5 EP и $10,000 за успешна атака на територия!", TeamInfo[i][tName]);
                for (new j = 0; j < MAX_PLAYERS; j++)
                {
                    if (isTurfMember[j] == true && PlayerInfo[j][pTeam] == i)
                    {
                        SendClientMessage(j, 0xC800FFFF, string256);
                        GivePlayerEP(j, 5);
                        isTurfMember[j] = false;
                        GivePlayerCash(j, 10000);
                    }
                }
                format(string256, 256, "Turf War: {FF0000}%s{C800FF} превзе успешно %s територията на %s!", TeamInfo[i][tName],
                       TurfInfo[turfAttackedID][TurfName], TeamInfo[oldTurfOwner][tName]);
                SendClientMessageToAll(0xC800FFFF, string256);
                TurfInfo[turfAttackedID][TurfWarGang] = 0;
                TurfInfo[turfAttackedID][TurfOwner] = i;
                TeamInfo[i][tTurfsCount] += 1;
                TeamInfo[oldTurfOwner][tTurfsCount] -= 1;
                SaveTurf(turfAttackedID);
                SaveFaction(oldTurfOwner);
                GangZoneStopFlashForAll(turfAttackedID);
                GangZoneHideForAll(turfAttackedID);
                GangZoneShowForAll(turfAttackedID, TeamInfo[i][tTCOLOR]);
                SaveFaction(i);
            }
        }
    }
}
//==============================================================================
//          -- > /// GeneralTimer1sFaction
//==============================================================================




//==============================================================================
//          -- > GeneralTimer5msPlayer
//==============================================================================
stock GeneralTimer5msPlayer()
{
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (playerAfkMinutes[i] >= 1 || playerAfkSeconds[i] >= 1)
        {
            if (AFKDetect[i] == gettime() && IsPlayerConnected(i))
            {
                playerAfkSeconds[i] = 0;
                playerAfkMinutes[i] = 0;
            }
        }

        if (isTurfMember[i] == true && isGangAttackingTurf[PlayerInfo[i][pTeam]] == true)
        {
            if (!IsPlayerInAttackedTurf(i))
            {
                startturf = 0;
                new attackerFaction = PlayerInfo[i][pTeam];
                new turfAttacked = TeamInfo[attackerFaction][tTurfAttacked];
                new turfOwner = TurfInfo[turfAttacked][TurfOwner];
                format(string256, 256, "[FACTION CHAT] {FF0000}%s{C800FF} Играчът напусна очертанията и отпадна от атака!", GetPlayerNickname(i));
                SendFactionMessage(attackerFaction, 0xC800FFFF, string256);
                inTurfAttackMembers[attackerFaction]--;
                isTurfMember[i] = false;
                if (inTurfAttackMembers[attackerFaction] == 0)
                {
                    format(string256, 256, "Turf War: {FF0000}%s{C800FF} не успя да превземе %s територията на %s!", TeamInfo[attackerFaction][tName], TurfInfo[turfAttacked][TurfName],
                           TeamInfo[turfOwner][tName]);
                    SendClientMessageToAll(0xC800FFFF, string256);
                    FailTurfAttack(attackerFaction);
                }
            }
        }
    }
}
//==============================================================================
//          -- > /// GeneralTimer5msPlayer
//==============================================================================




//==============================================================================
//          -- > GeneralTimer500ms
//==============================================================================
public GeneralTimer500ms()
{
    getdate(year, month, day);
    gettime(hours, minutes, seconds);

    //PlayerInfo timers - location - open

    GeneralTimer5msPlayer();

    //PlayerInfo timers - location - close
    return 1;
}
//==============================================================================
//          -- > /// GeneralTimer500ms
//==============================================================================