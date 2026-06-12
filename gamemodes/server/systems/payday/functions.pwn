stock ProcessFactionBonus(playerid, team, rank, &account, &ep)
{
    new bonusEP = 0, bonusCash = 0;
    new message[256];

    switch (team)
    {
        case FACTION_INTENSE_POLICE:
        {
            switch (rank)
            {
                case 1:
                {
                    bonusEP = 2;
                    bonusCash = 10000;
                }
                case 2:
                {
                    bonusEP = 4;
                    bonusCash = 20000;
                }
                case 3:
                {
                    bonusEP = 6;
                    bonusCash = 30000;
                }
                case 4:
                {
                    bonusEP = 8;
                    bonusCash = 40000;
                }
                case 5:
                {
                    bonusEP = 10;
                    bonusCash = 50000;
                }
                case 6:
                {
                    bonusEP = 50;
                    bonusCash = 1000000;
                }
            }
            if (bonusEP > 0)
            {
                format(message, sizeof(message), "Intense Police Department: + %d EP è %d$", bonusEP, bonusCash);
                SendClientMessage(playerid, COLOR_IPD_CHAT, message);
                ep += bonusEP;
                account += bonusCash;
            }
        }
        case FACTION_VIP:
        {
            if (rank >= 2 && rank <= 6)
            {
                bonusEP = rank;
                bonusCash = rank * 1000;
                format(message, sizeof(message), "VIP Gang: + %d EP è %d$", bonusEP, bonusCash);
                SendClientMessage(playerid, 0xFF3737FF, message);
                ep += bonusEP;
                account += bonusCash;
            }
        }
    }
    return 1;
}

stock ProcessVIPBonus(playerid, vipLevel, &account, &ep)
{
    new bonusEP = 0, bonusCash = 0;
    new freeVIP = CheckFreeVIP();

    if (freeVIP == 1 && vipLevel != 6)
    {
        vipLevel = 6;
    }

    switch (vipLevel)
    {
        case 1:
        {
            bonusEP = 1;
            bonusCash = 1000;
        }
        case 2:
        {
            bonusEP = 2;
            bonusCash = 2000;
        }
        case 3:
        {
            bonusEP = 3;
            bonusCash = 3000;
        }
        case 4:
        {
            bonusEP = 4;
            bonusCash = 4000;
        }
        case 5:
        {
            bonusEP = 5;
            bonusCash = 5000;
        }
        case 6:
        {
            bonusEP = 6;
            bonusCash = 6000;
        }
    }

    if (bonusEP > 0)
    {
        new message[64];
        format(message, sizeof(message), "VIP Level %d: + %d EP è %d$", vipLevel, bonusEP, bonusCash);
        SendClientMessage(playerid, 0xE65B00FF, message);
        ep += bonusEP;
        account += bonusCash;
    }
    return 1;
}

stock ProcessEPBonuses(playerid, lastPayday, afk)
{
    new epGained = 0;

    if (lastPayday > 29 && lastPayday < 100)
    {
        if (afk == 0) epGained += 1;
        else if (afk < 30) epGained += 2;
    }

    if (lastPayday > 1799 && afk == 0) epGained += 2;

    if (afk >= 30) epGained += 4;

    if (epGained > 0) GivePlayerEP(playerid, epGained);

    return epGained;
}

stock ProcessBizBonus(playerid, bizID, &account, &ep)
{
    if (bizID > -1)
    {
        new message[64];

        if (BizInfo[bizID][bPayOut] > 0)
        {
            format(message, sizeof(message), "Bizz: + %d$", BizInfo[bizID][bPayOut]);
            SendClientMessage(playerid, 0x00CCCCFF, message);
            account += BizInfo[bizID][bPayOut];
        }

        if (BizInfo[bizID][bEP] > 0)
        {
            format(message, sizeof(message), "Bizz: + %d EP", BizInfo[bizID][bEP]);
            SendClientMessage(playerid, 0x00CCCCFF, message);
            ep += BizInfo[bizID][bEP];
        }
    }
    return 1;
}

stock ProcessOfficeBonus(playerid, &account, &ep)
{
    new hisOffice = GetPlayerOfficeID(playerid);
    if (hisOffice > 0)
    {
        new bonusEP = OfficeInfo[hisOffice][BonusEP];
        new bonusCash = OfficeInfo[hisOffice][BonusCash];
        new message[64];
        format(message, sizeof(message), "Office: + %d EP è %d$", bonusEP, bonusCash);
        SendClientMessage(playerid, 0x00FF00FF, message);
        ep += bonusEP;
        account += bonusCash;
    }
    return 1;
}

stock CalculateSalary(level)
{
    return (level < 31) ? (level * 1000) : 30000;
}
