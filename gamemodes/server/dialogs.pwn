public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    new noerrorstring4[115];
    if (dialogid <= -1)
    {
        if (!response)
        {}
        if (response)
        {}
    }
    if (dialogid == 0)
    {
        if (!response)
        {
            PlayerInfo[playerid][pKick] = 1;
        }
        if (!response)
        {}
        if (response)
        {
            if (strlen(inputtext) >= 4 && strlen(inputtext) <= 20)
            {
                PlayerInfo[playerid][pRegistred] = 1;
                PlayerInfo[playerid][pWeaponS] = 1;
                PlayerInfo[playerid][pSpawnO] = 2;
                PlayerInfo[playerid][pTeam] = 1;
                PlayerInfo[playerid][pRank] = 1;
                PlayerInfo[playerid][pLevel] = 1;
                SetPlayerScore(playerid, 1);
                TextDrawShowForPlayer(playerid, levelText[playerid]), TextDrawShowForPlayer(playerid, epText[playerid]);
                TextDrawShowForPlayer(playerid, epsText[playerid]), TextDrawShowForPlayer(playerid, msText[playerid]);
                GetPlayerCurrentIP(playerid);
                format(string256, 256, "SERVER: Ти успешно регистрира {40BF00}%s{FFFFFF} с парола {FFFF00}%s {FFFF00}{FFFFFF},ти автоматично влезе в акаунта си.", GetPlayerNickname(playerid), inputtext);
                SendClientMessage(playerid, 0xFFFFFFFF, string256);
                PlayerInfo[playerid][pActiveCheck] = 60;
                format(string115, 115, "");
                SendClientMessage(playerid, 0x00E600FF, string115);
                format(string115, 115, "SERVER: Ти влезе успешно в акаунта!");
                SendClientMessage(playerid, 0x00E600FF, string115);
                logged[playerid] = 1;
                format(string115, 115, "Nickname: %s | Admin Level: 0 | VIP Level: 0 | Player Level: 1 | EP: 0 | Faction: VIP(1)", GetPlayerNickname(playerid));
                SendClientMessage(playerid, 0x33CCFFFF, string115);

                year = PlayerInfo[playerid][pYear];
                day = PlayerInfo[playerid][pDay];
                month = PlayerInfo[playerid][pMonth];
                hours = PlayerInfo[playerid][pHours];
                seconds = PlayerInfo[playerid][pSeconds];
                minutes = PlayerInfo[playerid][pMinutes];

                InsertPlayerToDB(playerid);
                SavePlayerLoginData(playerid);
                SavePlayerAka(playerid);
                new nameofmounth[15];
                if (month == 1)
                {
                    nameofmounth = "Януари";
                }
                else if (month == 2)
                {
                    nameofmounth = "февруари";
                }
                else if (month == 3)
                {
                    nameofmounth = "Март";
                }
                else if (month == 4)
                {
                    nameofmounth = "Април";
                }
                else if (month == 5)
                {
                    nameofmounth = "Май";
                }
                else if (month == 6)
                {
                    nameofmounth = "Юни";
                }
                else if (month == 7)
                {
                    nameofmounth = "Юли";
                }
                else if (month == 8)
                {
                    nameofmounth = "Август";
                }
                else if (month == 9)
                {
                    nameofmounth = "Септември";
                }
                else if (month == 10)
                {
                    nameofmounth = "Октомври";
                }
                else if (month == 11)
                {
                    nameofmounth = "Ноември";
                }
                else if (month == 12)
                {
                    nameofmounth = "Декември";
                }
                format(string115, 115, "Последното ти влизане в този акаунт е било на %02d %02d %s в %02d:%02d:%02d часа.",
                       year, day, nameofmounth, hours, minutes, seconds);
                SendClientMessage(playerid, 0xFFFFFFFF, string115);
                SetPlayerColor(playerid, 0xFF3737FF);
                SendClientMessage(playerid, -1, "");
                TogglePlayerSpectating(playerid, false);
                GivePlayerCash(playerid, 500);
                OnLoginShowTexts(playerid);
                OnPlayerEnterGiveMission(playerid);
                SavePlayerStats(playerid);
                SavePlayerPassword(playerid, inputtext);
            }
            else
            {
                SendClientMessage(playerid, 0x00FF00FF, "SERVER: Паролата трябва да е от 4 до 20 символа !");
                new stringnewnew2[256];
                format(stringnewnew2, 256, "{FFFFFF}Добре дошъл {40BF00}%s\n{FFFFFF}Моля регистрирай акаунта като въведеш паролата отдолу:", GetPlayerNickname(playerid));
                ShowPlayerDialog(playerid, 0, DIALOG_STYLE_PASSWORD, "Регистрация:", stringnewnew2, "Регистрирай", "Излез");
            }
        }
    }
    if (dialogid == 1)
    {
        if (!response)
        {
            PlayerInfo[playerid][pKick] = 1;
        }
        if (response)
        {
            if (!strlen(inputtext))
            {
                SendClientMessage(playerid, 0xFFFFFFFF, "SERVER: Въведи парола !");
                format(string256, 256, "{FFFFFF}Добре дошъл {40BF00}%s\n{FFFFFF}Моля влез в акаунта като въведеш паролата отдолу:", GetPlayerNickname(playerid));
                ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "Влизане:", string256, "Влез", "Излез");
                return 1;
            }
            if (strlen(inputtext))
            {
                // --- MySQL Проверка на Парола ---
                new db_password_hash[256];
                new input_hash[256];
                new query[256];
new Cache:
                resultCache;

                // ПРОМЯНА: Заявката вече избира полето 'password', а не '1'
                format(query, sizeof(query), "SELECT 1 FROM users WHERE player_username = '%s' AND password = '%s' LIMIT 1", GetPlayerNickname(playerid), MD5_Hash(inputtext));
                resultCache = mysql_query(MySQL:Database, query);


                if (cache_num_rows() > 0)
                {
                    LoadPlayerStats(playerid);
                    GivePlayerCash(playerid, PlayerInfo[playerid][pCash]);
                    SetPlayerScore(playerid, PlayerInfo[playerid][pLevel]);
                    if (PlayerInfo[playerid][pLaser] > 0)
                    {
                        if (PlayerInfo[playerid][pTeam] == FACTION_VIP)
                        {
                            SetPVarInt(playerid, "color", 18643);
                        }
                        if (PlayerInfo[playerid][pTeam] == FACTION_GROVE)
                        {
                            SetPVarInt(playerid, "color", 19083);
                        }
                        if (PlayerInfo[playerid][pTeam] == FACTION_RIFA)
                        {
                            SetPVarInt(playerid, "color", 19080);
                        }
                        if (PlayerInfo[playerid][pTeam] == FACTION_INTENSE_POLICE)
                        {
                            SetPVarInt(playerid, "color", 19080);
                        }
                    }
                    if (PlayerInfo[playerid][pCash] > 999999999)
                    {
                        PlayerInfo[playerid][pCash] = 999999999;
                        GivePlayerCash(playerid, 0);
                    }
                    if (PlayerInfo[playerid][pTest] == 1)
                    {
                        adminprefix[playerid] = "Test Admin";
                    }
                    else if (PlayerInfo[playerid][pAdmin] == 1)
                    {
                        adminprefix[playerid] = "Helper";
                    }
                    else if (PlayerInfo[playerid][pAdmin] == 2)
                    {
                        adminprefix[playerid] = "Administrator";
                    }
                    else if (PlayerInfo[playerid][pAdmin] == 3)
                    {
                        adminprefix[playerid] = "Moderator";
                    }
                    else if (PlayerInfo[playerid][pAdmin] == 4)
                    {
                        adminprefix[playerid] = "Grand Admin";
                    }
                    else if (PlayerInfo[playerid][pAdmin] == 5)
                    {
                        adminprefix[playerid] = "Owner";
                    }
                    else if (PlayerInfo[playerid][pAdmin] == 6)
                    {
                        adminprefix[playerid] = "Scripter";
                    }
                    PlayerInfo[playerid][pRegistred] = 1;
                    PlayerInfo[playerid][pActiveCheck] = 60;
                    format(string115, 115, "SERVER: Ти влезе успешно в акаунта!");
                    SendClientMessage(playerid, 0x00E600FF, string115);
                    logged[playerid] = 1;
                    OnLoginShowTexts(playerid);
                    if (PlayerInfo[playerid][pTest] == 1)
                    {
                        format(string256, 256, "Nickname: %s | Admin Level: Test | VIP Level: %d | Player Level: %d | EP: %d | Faction: %s(%d)", GetPlayerNickname(playerid), PlayerInfo[playerid][pVip], PlayerInfo[playerid][pLevel], PlayerInfo[playerid][pEP], TeamInfo[PlayerInfo[playerid][pTeam]][tName], PlayerInfo[playerid][pRank]);
                        SendClientMessage(playerid, 0x33CCFFFF, string256);
                    }
                    if (PlayerInfo[playerid][pAdmin] < 6)
                    {
                        format(string256, 256, "Nickname: %s | Admin Level: %d | VIP Level: %d | Player Level: %d | EP: %d | Faction: %s(%d)", GetPlayerNickname(playerid), PlayerInfo[playerid][pAdmin], PlayerInfo[playerid][pVip], PlayerInfo[playerid][pLevel], PlayerInfo[playerid][pEP], TeamInfo[PlayerInfo[playerid][pTeam]][tName], PlayerInfo[playerid][pRank]);
                        SendClientMessage(playerid, 0x33CCFFFF, string256);
                    }
                    if (PlayerInfo[playerid][pAdmin] == 6)
                    {
                        format(string256, 256, "Nickname: %s | Admin Level: 5 | VIP Level: %d | Player Level: %d | EP: %d | Faction: %s(%d)", GetPlayerNickname(playerid), PlayerInfo[playerid][pVip], PlayerInfo[playerid][pLevel], PlayerInfo[playerid][pEP], TeamInfo[PlayerInfo[playerid][pTeam]][tName], PlayerInfo[playerid][pRank]);
                        SendClientMessage(playerid, 0x33CCFFFF, string256);
                    }
                    new nameofmounth[15];
                    if (PlayerInfo[playerid][pMonth] == 1)
                    {
                        nameofmounth = "Януари";
                    }
                    else if (PlayerInfo[playerid][pMonth] == 2)
                    {
                        nameofmounth = "февруари";
                    }
                    else if (PlayerInfo[playerid][pMonth] == 3)
                    {
                        nameofmounth = "Март";
                    }
                    else if (PlayerInfo[playerid][pMonth] == 4)
                    {
                        nameofmounth = "Април";
                    }
                    else if (PlayerInfo[playerid][pMonth] == 5)
                    {
                        nameofmounth = "Май";
                    }
                    else if (PlayerInfo[playerid][pMonth] == 6)
                    {
                        nameofmounth = "Юни";
                    }
                    else if (PlayerInfo[playerid][pMonth] == 7)
                    {
                        nameofmounth = "Юли";
                    }
                    else if (PlayerInfo[playerid][pMonth] == 8)
                    {
                        nameofmounth = "Август";
                    }
                    else if (PlayerInfo[playerid][pMonth] == 9)
                    {
                        nameofmounth = "Септември";
                    }
                    else if (PlayerInfo[playerid][pMonth] == 10)
                    {
                        nameofmounth = "Октомври";
                    }
                    else if (PlayerInfo[playerid][pMonth] == 11)
                    {
                        nameofmounth = "Ноември";
                    }
                    else if (PlayerInfo[playerid][pMonth] == 12)
                    {
                        nameofmounth = "Декември";
                    }
                    format(string115, 115, "Последното ти влизане в този акаунт е било на %d %d %s в %d:%d:%d часа.", PlayerInfo[playerid][pYear], PlayerInfo[playerid][pDay], nameofmounth, PlayerInfo[playerid][pHours], PlayerInfo[playerid][pMinutes], PlayerInfo[playerid][pSeconds]);
                    SendClientMessage(playerid, 0xFFFFFFFF, string115);
                    SendClientMessage(playerid, -1, "");
                    OnPlayerEnterGiveMission(playerid);
                    if (PlayerInfo[playerid][pADuty] == 1)
                    {
                        SetPlayerColor(playerid, 0x7BFFFFFF);
                    }
                    if (PlayerInfo[playerid][pTeam] == FACTION_CIVILIAN)
                    {
                        SetPlayerColor(playerid, 0xFFFFFFFF);
                    }
                    if (PlayerInfo[playerid][pTeam] == FACTION_VIP)
                    {
                        SetPlayerColor(playerid, 0xFF3737FF);
                    }
                    if (PlayerInfo[playerid][pTeam] == FACTION_GROVE)
                    {
                        SetPlayerColor(playerid, 0x33AA33FF);
                    }
                    if (PlayerInfo[playerid][pJail] > 0)
                    {
                        SendClientMessage(playerid, 0xE60000FF, "SERVER: Ти все-още си в админ затвора!");
                    }
                    if (PlayerInfo[playerid][pAFK] > 0)
                    {
                        SendClientMessage(playerid, 0xD6F34AFF, "AFK: Ти все-още си в режим AFK!");
                        SetPlayerColor(playerid, 0xD6F34AFF);
                    }

                    SavePlayerLoginData(playerid);
                    TogglePlayerSpectating(playerid, false);
                }
                else
                {
                    // Паролата е грешна
                    format(string256, 256, "{FFFFFF}Добре дошъл {40BF00}%s\n{FFFFFF}Моля влез в акаунта като въведеш паролата отдолу:", GetPlayerNickname(playerid));
                    ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "Влизане:", string256, "Влез", "Излез");
                    SendClientMessage(playerid, 0xFF1400FF, "SERVER: Грешна парола");
                    wrongpassword[playerid] += 1;
                    if (wrongpassword[playerid] > 3)
                    {
                        format(string115, 115, "SERVER: %s was kicked by THE SERVER [Reason: Wrong Password]", GetPlayerNickname(playerid));
                        SendClientMessageToAll(0xB4B5B7FF, string115);
                        PlayerInfo[playerid][pKick] = 1;
                    }
                }
                cache_delete(resultCache);
            }
        }
    }
    if (dialogid == 2)
    {
        if (!response)
        {
            SendClientMessage(playerid, 0xE60000FF, "За да играете в този сървър трябва да се съгласи с правилата и условията му!");
            PlayerInfo[playerid][pKick] = 1;
        }
        if (!response)
        {}
        if (response)
        {
            ShowPlayerDialog(playerid, 8, DIALOG_STYLE_INPUT, "GSM номер:", "Преди да се регистрирате за по-голяма сигурност на вашия акаунт може да въведете вашия GSM номер!\nАко ви бъде откраднат акаунта, чрез пращане на SMS от номера, който сте въвели, вие, че акаунта е ваш!\nЗа това трябва да въведете GSM номера, от който ще пращате SMS за потвърждение, ако случайно ви бъде откраднат!\n\nАко искате да пропуснете тази стъпка натиснете бутона 'Пропусни'", "Въведи", "{FFFFFF}Пропусни");
        }
    }
    if (dialogid == 4)
    {
        if (response)
        {
            new string2230[590];
            new string2230result[2070];
            format(string2230, 512, "{00FF00}--= Vip Level 1 =--\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/listguns - можете да погледнете оръжията на другите играчи\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/flip - преобръща вашето превозно средство\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/hyd - добавя хидравлика\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/nos - добавя нитро\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/vtimers - за да видите колко време ви остава до VIP unmute и т.н.\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/isafk - проверява от колко време е AFK даден играч\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/v - дава колело\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}--= Vip Level 2 =--\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/isactive - за да провериш дали играч е онлайн или AFK\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/fix - поправя вашето превозно средство\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/cnos - променя вашия режим на пускане на нитрото\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/r - директно отговаряне на лично съобщение (PM)\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/pj - пребоядисва вашата кола\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/jetpack - дава летяща раница\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/cc - променя цвета на вашето превозно средство\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/advert - пускане на рекламация за бизнес, къща и т.н.\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/kill - за да се самоубиете\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}--= Vip Level 3 =--\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/invisible - ставаш невидим на картата\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/mybank - проверяваш колко пари имаш в банката\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/para - дава парашут\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/lock - заключва вашето превозно средство\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/unlock - отключва вашето превозно средство\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/healme - за да си заредиш кръвта и жилетката\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/vrefuel - добавя 20 литра на вашето превозно средство\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/ramphelp - информация за ползване на рампите\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/vguns - дава оръжия, при цивилен - Sawnoff и M4, при банда - Knife и Sniper Rifle\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/tune - за да тунинговате вашата кола където и да сте\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}--= Vip Level 4 =--\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/laser - пуска/спира твоят лазер на оръжията ak-47 и m4\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/viplabel - закача/откача 3D текста 'VIP' от главата ти\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/parrot - закача/маха папагал от твоето рамо\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}--= Vip Level 5 =--\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/edit - местите закачен обжект от вашия скин\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/clothes - за да си слагаш кърпи/очила/маски и т.н.\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/sgchange - за да си смениш дали да получаваш чантички или гранати\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}--= Vip Level 6 =--\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/eject - за да изгониш някой от колата, която караш\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/viptext - за да смениш 3D текста на главата ти, струва $5000\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/tires - за да поправите гумите на вашето превозно средство\n");
            strcat(string2230result, string2230);
            new closeddialog = 3500;
            ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, "{FFFFFF}VIP{008000} MOD{FF0000} COMMANDS:", string2230result, "Затвори", "");
        }
    }
    if (dialogid == 12)
    {
        if (response)
        {
            new string2230[512];
            new string2230result[1500];
            format(string2230, 512, "{00FF00}---Основни команди---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/myfps - за да видиш твоето FPS\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/intro - за да пуснеш песен от интрото\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/introff - за да спреш песен от интрото\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/leavedm - за да напуснете, ако сте в Deathmatch мисия\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/leaverace - за да напуснете, ако се съзтезавате в Street Race мисия\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/dice - за да метнете зарче\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/refuel - за да заредите вашето превозно средство с бензин\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/mduty - за да си смените скина на механик\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/briefcase(/bcase) - всички опции за ползване на куфара\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/drop - за да изхвърлиш неща, които имаш в себе си\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/afk - за да преминете в режим AFK\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/back - за да се махнете от режим AFK\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/vote - за да гласувате, когато е пуснато гласуване за RESPAWN на превозните средства\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/poll - за да гласувате, когато е стартиран въпрос от админ\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/joinvip - за да влезеш в бандата VIP\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/togchat - забраняваш/махаш забраната за себе си да виждаш какво пишат другите в чата\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/hitman - за да заложиш цена на главата на даден играч\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/bounties - за да видиш онлайн играчите със заложени цени на главите им\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/transfer - внасяш пари в сумата на някой играч\n");
            strcat(string2230result, string2230);
            ShowPlayerDialog(playerid, 13, DIALOG_STYLE_MSGBOX, "{FFFFFF}КО{008000}МАН{FF0000}ДИ", string2230result, "Други", "Затвори");
        }
    }
    if (dialogid == 13)
    {
        if (!response)
        {}
        if (response)
        {
            new string2230[512];
            new string2230result[1500];
            format(string2230, 512, "{00FF00}---Команди за къща---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}От /househelp можете да видите всички команди за къща\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}---Команди за бизнес---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}От /bizhelp можете да видите всички команди за притежателя на бизнес\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/drink - за да поръчате нещо за пиене от бар\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/train - за да научите боен стил от фитнес\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/buy - за да купите нещо от бизнес/магазин\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/heal - за да купите живот или жилетка от бизнес\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/buyhealth - за да купите health пакети за вашата къща от бизнес\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/buyarmour - за да купите armour пакети за вашата къща от бизнес\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/bet - за да заложите на конно надбягване в бизнес\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/dmv - за да си вземете шофьорска книжка\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/plate - за да си смените номера на колата\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}---Команди за банда/мафия---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}От /factionhelp(/fhelp) можете да видите всички команди за банда/мафия\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}---VIP команди---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}От /viphelp можете да видите всички VIP команди\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}---Админ команди---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}От /ahelp(/ah) можете да видите всички админ команди, ако сте админ!\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}От /mhelp(/mh) можете да видите всички Manage Admin команди!\n");
            strcat(string2230result, string2230);
            ShowPlayerDialog(playerid, 15, DIALOG_STYLE_MSGBOX, "{FFFFFF}КО{008000}МАН{FF0000}ДИ", string2230result, "Други", "Затвори");
        }
    }
    if (dialogid == 15)
    {
        if (!response)
        {}
        if (response)
        {
            new string2230[512];
            new string2230result[1888];
            format(string2230, 512, "{00FF00}---Команди за превозно средство---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/detach - за да откачите ремаркето от вашия камион\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/tow - за да качите кола с вашия Tow Truck\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}От /vehelp можете да видите останалите команди за превозното средство!\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}---Команди за туба бензин---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/refillfc - за да заредите вашата туба с бензин\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/fuelcan - за да заредите бензин от вашата туба\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/fc - за да проверите колко бензин имате във вашата туба\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}---Команди за километража---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/speedo - за да сложите или премахнете километража\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/kph - за да настроите скоростта да ви я показва в km/h\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/mph - за да настроите скоростта да ви я показва в m/s\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}---Команди за анимации---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}От /animlist може да видите всички команди за анимациите\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}---Команди за обир---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/robbery - всички опции за обир\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/rob - за да почнеш да крадеш\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}---Команди за дрога---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/usedrug - за да изполваш дрога\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/drugs - за да видиш твоята дрога\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/selldrug - за да продадеш дрога\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/drugaccept(/da) - за да приемеш, ако някой ти продава дрога\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/drugcancel(/dc) - за да да откажеш, ако някой ти продава дрога\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}---Команди за тунинг гаража---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/tune - за да отворите менюто за тунинг\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/dm, /dm2 - за да се телепортирате на арената за битка - DM\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/tunehelp - повече информация за тунинг гаража\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}---Команди за евент---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/joinevent - за да се присъедините към евент\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/leftevent - за да излезете от евент\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/erefuel - за да добавите 100 литра на вашето превозно средство\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/nameon - за да ви се вижда никнейма над главата\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/nameoff - за да не ви се вижда никнейма над главата\n");
            strcat(string2230result, string2230);
            ShowPlayerDialog(playerid, 16, DIALOG_STYLE_MSGBOX, "{FFFFFF}КО{008000}МАН{FF0000}ДИ", string2230result, "Други", "Затвори");
        }
    }
    if (dialogid == 16)
    {
        if (!response)
        {}
        if (response)
        {
            new string2230[512];
            new string2230result[1750];
            format(string2230, 512, "{00FF00}---Команди за радио---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/radio - за да пуснете вашето радио\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/radioff - за да изкючите вашето радио\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}---Команди за работа---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/coalmine - за да започнеш работа като миньор\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/sweep - за да започнеш работа като чистач на улици\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/pizza - за да започнеш работа като доставчик на пици\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/bus - за да започнеш работа като автобусен шофьор\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/deliver - за да започнеш работа като доставчик\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/truck - за да започнеш работа като тираджия\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/boat - за да започнеш работа като лодкаджия\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/pilot - за да започнеш работа като пилот\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/leavejob - за да напуснеш твоята работа\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/jobs - за да видите колко време ви остава за да започнете отново работа\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}---Команди за членове на Intense Fuel Company---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}От /ifchelp можете да видите всички команди за Intense Fuel Company\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}---Команди за DM арената---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/dmon - за да влезете в DM арената\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/dmoff - за да излезете от DM арената\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/top - за да видите играчът, направил най-много убийства без умиране в DM зоната\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}---Команди за CB Chanel---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/cb - за да влезете в определен CB Chanel\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/cbp - за да видиш онлайн играчите, които са в твоя CB Chanel\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/cboff - за да излезеш от твоя CB Chanel\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{00FF00}---Команди за Duel---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/duel - за да изпратиш покана за дуел на някого\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/cduel - за да отмениш поканата за дуел, която си изпратил на някого\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/yes - за да приемеш покана за дуел\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/no - за да откажеш покана за дуел\n");
            strcat(string2230result, string2230);
            ShowPlayerDialog(playerid, 17, DIALOG_STYLE_MSGBOX, "{FFFFFF}КО{008000}МАН{FF0000}ДИ", string2230result, "Други", "Затвори");
        }
    }
    if (dialogid == 17)
    {
        if (!response)
        {}
        if (response)
        {
            new string2230[512];
            new string2230result[1850];
            format(string2230, 512, "{00FF00}---Команди за лично превозно средство---\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/vehsave - за да сейфате SPAWN позиция на вашето превозно средство\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/vehcolor - за да смените цвета на вашето превозно средство\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/vehrespawn - за да сложите определено време за RESPAWN на вашето превозно средство\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/vehnorespawn - за да премахнете RESPAWN на вашето превозно средство\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/vehres - за да RESPAWN-ете всички ваши превозни средства\n");
            strcat(string2230result, string2230);
            new closeddialog = 3500;
            ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, "{FFFFFF}КО{008000}МАН{FF0000}ДИ", string2230result, "Затвори", "");
        }
    }
    if (dialogid == 19)
    {
        if (!response)
        {}
        if (response) // If they clicked 'Select' or double-clicked a weapon
        {
            // Give them the weapon
            switch (listitem)
            {
                //            new noerrorstring4[115];
                case 0:
                {
                    format(noerrorstring4, 115, "{FFFFFF}Вашата обща сума е {40BF00}$%d\n", PlayerInfo[playerid][pAccount]);
                    new closeddialog = 3500;
                    ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, "Обща сума:", noerrorstring4, "Затвори", "");
                }
                case 1:
                {
                    format(noerrorstring4, 115, "{FFFFFF}Вие имате {40BF00}$%d\n{FFFFFF}Моля въведете отдолу колко долара искате да изтеглите от вашата сума:", PlayerInfo[playerid][pAccount]);
                    ShowPlayerDialog(playerid, 6, DIALOG_STYLE_INPUT, "Изтегли пари:", noerrorstring4, "Изтегли", "Назад");
                }
                case 2:
                {
                    format(string175, 175, "{FFFFFF}Вие имате {40BF00}$%d{FFFFFF} в себе си.\nМоля въведете отдоло колко долара искате да внесете във вашата сума:", PlayerInfo[playerid][pCash]);
                    ShowPlayerDialog(playerid, 20, DIALOG_STYLE_INPUT, "Плати нарушение:", string175, "Плати", "Назад");
                }
            }
        }
    }
    if (dialogid == 20)
    {
        if (!response)
        {}
        if (response) //Continue
        {
            if (strval(inputtext) <= 0) return SendClientMessage(playerid, 0xB4B5B7FF, "Сумата трябва да е по-голяма от $0!");
            if (strval(inputtext) > 1000000) return SendClientMessage(playerid, 0xB4B5B7FF, "Сумата трябва да е по-малка от $1000000!");
            if (PlayerInfo[playerid][pCash] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш толкова пари в себе си!");
            new stringBank[256];
            GivePlayerCash(playerid, -strval(inputtext));
            PlayerInfo[playerid][pAccount] += strval(inputtext);
            //ApplyAnimation(playerid, "PED", "ATM", 3.0,1,1,0,0,0);
            format(stringBank, sizeof(stringBank), "Вие успешно внесохте {40BF00}$%d {FFFFFF}във вашата обща сума", strval(inputtext));
            SendClientMessage(playerid, 0xFFFFFFFF, stringBank);
        }
        else ShowPlayerDialog(playerid, 19, DIALOG_STYLE_LIST, "Банка", "Обща сума\nИзтегли пари\nВнеси пари", "Избери", "Затвори");
    }
    //
    if (dialogid == 39)
    {
        if (strval(inputtext) < 1)
        {
            format(string256, 256, "Не можете да заредите 0 литра във вашето превозно средство.");
            SendClientMessage(playerid, 0xB4B5B7FF, string256);
            return 0;
        }
        if (vehfuel[GetPlayerVehicleID(playerid)] == 100)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Вашето превозно средство има 100 литра бензин.");
            return 0;
        }
        if (strval(inputtext) > 100 - vehfuel[GetPlayerVehicleID(playerid)])
        {
            format(string256, 256, "Можете да заредите до %d литра във вашето превозно средство.", 100 - vehfuel[GetPlayerVehicleID(playerid)]);
            SendClientMessage(playerid, 0xB4B5B7FF, string256);
            return 0;
        }
        refuelcan[playerid] = strval(inputtext);
        PlayerInfo[playerid][pRefuelCan] = 8;
        TogglePlayerControllable(playerid, 0);
        GameTextForPlayer(playerid, "~g~PLEASE WAIT", 8000, 3);
        SendClientMessage(playerid, 0xA4FFA4FF, "Моля, изчакайте, докато се зареди вашето превозно средство!");
    }
    if (dialogid == 38)
    {
        new refuelstring[500];
        if (strval(inputtext) < 1)
        {
            format(string256, 256, "Не можете да заредите 0 литра във вашата туба за бензин.", strval(inputtext));
            SendClientMessage(playerid, 0xB4B5B7FF, string256);
            return 0;
        }
        if (PlayerInfo[playerid][pFuelcase] == 100)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Вашата туба за бензин е пълна.");
            return 0;
        }
        if (strval(inputtext) > 100 - PlayerInfo[playerid][pFuelcase])
        {
            format(string256, 256, "Можете да заредите до %d литра във вашата туба за бензин.", 100 - PlayerInfo[playerid][pFuelcase]);
            SendClientMessage(playerid, 0xB4B5B7FF, string256);
            return 0;
        }
        if (IsPlayerInRangeOfPoint(playerid, 10, 1004.0327, -937.5370, 42.3281) && fuelStationsFuel[0] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 1942.3719, -1772.8666, 13.6406) && fuelStationsFuel[1] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -1606.7223, -2713.3562, 48.5335) && fuelStationsFuel[2] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -2026.7813, 156.5509, 29.0391) && fuelStationsFuel[3] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -2243.8149, -2559.8899, 31.9219) && fuelStationsFuel[4] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -1676.2601, 413.5443, 7.1797) && fuelStationsFuel[5] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 2201.8296, 2475.1350, 10.8203) && fuelStationsFuel[6] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 615.3391, 1690.0454, 6.9922) && fuelStationsFuel[7] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -1328.2731, 2677.5278, 50.0625) && fuelStationsFuel[8] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 70.3842, 1219.0177, 18.8116) && fuelStationsFuel[9] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 2113.3835, 919.5655, 10.8203) && fuelStationsFuel[10] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 2641.0115, 1106.6252, 10.8203) && fuelStationsFuel[11] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 2146.7964, 2747.8115, 10.8203) && fuelStationsFuel[12] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 1595.7935, 2199.5996, 10.8203) && fuelStationsFuel[13] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -1471.1836, 1863.7598, 32.6328) && fuelStationsFuel[14] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 655.7673, -565.0798, 16.3359) && fuelStationsFuel[15] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 1381.8230, 459.1453, 20.3452) && fuelStationsFuel[16] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (strval(inputtext) <= 100 - PlayerInfo[playerid][pFuelcase])
        {
            //tuk
            refuelcan[playerid] = strval(inputtext);
            PlayerInfo[playerid][pRefuelTube] = 4;
            TogglePlayerControllable(playerid, 0);
            GivePlayerCash(playerid, -strval(inputtext));
            GameTextForPlayer(playerid, "~g~PLEASE WAIT", 2000, 3);
            SendClientMessage(playerid, 0xA4FFA4FF, "Gas Station: Моля, изчакайте, докато заредим вашата туба!");
            if (IsPlayerInRangeOfPoint(playerid, 10, 1004.0327, -937.5370, 42.3281))
            {
                fuelStationsFuel[0] -= strval(inputtext);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 1942.3719, -1772.8666, 13.6406))
            {
                fuelStationsFuel[1] -= strval(inputtext);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, -1606.7223, -2713.3562, 48.5335))
            {
                fuelStationsFuel[2] -= strval(inputtext);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, -2026.7813, 156.5509, 29.0391))
            {
                fuelStationsFuel[3] -= strval(inputtext);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, -2243.8149, -2559.8899, 31.9219))
            {
                fuelStationsFuel[4] -= strval(inputtext);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, -1676.2601, 413.5443, 7.1797))
            {
                fuelStationsFuel[5] -= strval(inputtext);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 2201.8296, 2475.1350, 10.8203))
            {
                fuelStationsFuel[6] -= strval(inputtext);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 615.3391, 1690.0454, 6.9922))
            {
                fuelStationsFuel[7] -= strval(inputtext);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, -1328.2731, 2677.5278, 50.0625))
            {
                fuelStationsFuel[8] -= strval(inputtext);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 70.3842, 1219.0177, 18.8116))
            {
                fuelStationsFuel[9] -= strval(inputtext);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 2113.3835, 919.5655, 10.8203))
            {
                fuelStationsFuel[10] -= strval(inputtext);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 2641.0115, 1106.6252, 10.8203))
            {
                fuelStationsFuel[11] -= strval(inputtext);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 2146.7964, 2747.8115, 10.8203))
            {
                fuelStationsFuel[12] -= strval(inputtext);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 1595.7935, 2199.5996, 10.8203))
            {
                fuelStationsFuel[13] -= strval(inputtext);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, -1471.1836, 1863.7598, 32.6328))
            {
                fuelStationsFuel[14] -= strval(inputtext);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 655.7673, -565.0798, 16.3359))
            {
                fuelStationsFuel[15] -= strval(inputtext);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 1381.8230, 459.1453, 20.3452))
            {
                fuelStationsFuel[16] -= strval(inputtext);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 1004.0327, -937.5370, 42.3281))
            {
                Delete3DTextLabel(fuelStationText[0]);
                format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[0]);
                fuelStationText[0] = Create3DTextLabel(refuelstring, 0xFFFFFFFF, 1004.0327, -937.5370, 42.3281, 40, 0, 0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 1942.3719, -1772.8666, 13.6406))
            {
                Delete3DTextLabel(fuelStationText[1]);
                format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[1]);
                fuelStationText[1] = Create3DTextLabel(refuelstring, 0xFFFFFFFF, 1942.3719, -1772.8666, 13.6406, 40, 0, 0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, -1606.7223, -2713.3562, 48.5335))
            {
                Delete3DTextLabel(fuelStationText[2]);
                format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[2]);
                fuelStationText[2] = Create3DTextLabel(refuelstring, 0xFFFFFFFF, -1606.7223, -2713.3562, 48.5335, 40, 0, 0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, -2026.7813, 156.5509, 29.0391))
            {
                Delete3DTextLabel(fuelStationText[3]);
                format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[3]);
                fuelStationText[3] = Create3DTextLabel(refuelstring, 0xFFFFFFFF, -2026.7813, 156.5509, 29.0391, 40, 0, 0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, -2243.8149, -2559.8899, 31.9219))
            {
                Delete3DTextLabel(fuelStationText[4]);
                format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[4]);
                fuelStationText[4] = Create3DTextLabel(refuelstring, 0xFFFFFFFF, -2243.8149, -2559.8899, 31.9219, 40, 0, 0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, -1676.2601, 413.5443, 7.1797))
            {
                Delete3DTextLabel(fuelStationText[5]);
                format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[5]);
                fuelStationText[5] = Create3DTextLabel(refuelstring, 0xFFFFFFFF, -1676.2601, 413.5443, 7.1797, 40, 0, 0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 2201.8296, 2475.1350, 10.8203))
            {
                Delete3DTextLabel(fuelStationText[6]);
                format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[6]);
                fuelStationText[6] = Create3DTextLabel(refuelstring, 0xFFFFFFFF, 2201.8296, 2475.1350, 10.8203, 40, 0, 0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 615.3391, 1690.0454, 6.9922))
            {
                Delete3DTextLabel(fuelStationText[7]);
                format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[7]);
                fuelStationText[7] = Create3DTextLabel(refuelstring, 0xFFFFFFFF, 615.3391, 1690.0454, 6.9922, 40, 0, 0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, -1328.2731, 2677.5278, 50.0625))
            {
                Delete3DTextLabel(fuelStationText[8]);
                format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[8]);
                fuelStationText[8] = Create3DTextLabel(refuelstring, 0xFFFFFFFF, -1328.2731, 2677.5278, 50.0625, 40, 0, 0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 70.3842, 1219.0177, 18.8116))
            {
                Delete3DTextLabel(fuelStationText[9]);
                format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[9]);
                fuelStationText[9] = Create3DTextLabel(refuelstring, 0xFFFFFFFF, 70.3842, 1219.0177, 18.8116, 40, 0, 0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 2113.3835, 919.5655, 10.8203))
            {
                Delete3DTextLabel(fuelStationText[10]);
                format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[10]);
                fuelStationText[10] = Create3DTextLabel(refuelstring, 0xFFFFFFFF, 2113.3835, 919.5655, 10.8203, 40, 0, 0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 2641.0115, 1106.6252, 10.8203))
            {
                Delete3DTextLabel(fuelStationText[11]);
                format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[11]);
                fuelStationText[11] = Create3DTextLabel(refuelstring, 0xFFFFFFFF, 2641.0115, 1106.6252, 10.8203, 40, 0, 0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 2146.7964, 2747.8115, 10.8203))
            {
                Delete3DTextLabel(fuelStationText[12]);
                format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[12]);
                fuelStationText[12] = Create3DTextLabel(refuelstring, 0xFFFFFFFF, 2146.7964, 2747.8115, 10.8203, 40, 0, 0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 1595.7935, 2199.5996, 10.8203))
            {
                Delete3DTextLabel(fuelStationText[13]);
                format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[13]);
                fuelStationText[13] = Create3DTextLabel(refuelstring, 0xFFFFFFFF, 1595.7935, 2199.5996, 10.8203, 40, 0, 0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, -1471.1836, 1863.7598, 32.6328))
            {
                Delete3DTextLabel(fuelStationText[14]);
                format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[14]);
                fuelStationText[14] = Create3DTextLabel(refuelstring, 0xFFFFFFFF, -1471.1836, 1863.7598, 32.6328, 40, 0, 0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 655.7673, -565.0798, 16.3359))
            {
                Delete3DTextLabel(fuelStationText[15]);
                format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[15]);
                fuelStationText[15] = Create3DTextLabel(refuelstring, 0xFFFFFFFF, 655.7673, -565.0798, 16.3359, 40, 0, 0);
            }
            if (IsPlayerInRangeOfPoint(playerid, 10, 1381.8230, 459.1453, 20.3452))
            {
                Delete3DTextLabel(fuelStationText[16]);
                format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[16]);
                fuelStationText[16] = Create3DTextLabel(refuelstring, 0xFFFFFFFF, 1381.8230, 459.1453, 20.3452, 40, 0, 0);
            }
        }
    }
    if (dialogid == 18)
    {
        new refuelstring[500];
        if (strval(inputtext) < 1)
        {
            format(string256, 256, "Не можете да заредите 0 литра във вашето превозно средство.", strval(inputtext));
            SendClientMessage(playerid, 0xB4B5B7FF, string256);
            return 0;
        }
        if (vehfuel[GetPlayerVehicleID(playerid)] == 100)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Вашето превозно средство има 100 литра бензин.");
            return 0;
        }
        if (strval(inputtext) > 100 - vehfuel[GetPlayerVehicleID(playerid)])
        {
            format(string256, 256, "Можете да заредите до %d литра във вашето превозно средство.", 100 - vehfuel[GetPlayerVehicleID(playerid)]);
            SendClientMessage(playerid, 0xB4B5B7FF, string256);
            return 0;
        }
        if (IsPlayerInRangeOfPoint(playerid, 10, 1004.0327, -937.5370, 42.3281) && fuelStationsFuel[0] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 1942.3719, -1772.8666, 13.6406) && fuelStationsFuel[1] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -1606.7223, -2713.3562, 48.5335) && fuelStationsFuel[2] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -2026.7813, 156.5509, 29.0391) && fuelStationsFuel[3] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -2243.8149, -2559.8899, 31.9219) && fuelStationsFuel[4] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -1676.2601, 413.5443, 7.1797) && fuelStationsFuel[5] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 2201.8296, 2475.1350, 10.8203) && fuelStationsFuel[6] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 615.3391, 1690.0454, 6.9922) && fuelStationsFuel[7] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -1328.2731, 2677.5278, 50.0625) && fuelStationsFuel[8] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 70.3842, 1219.0177, 18.8116) && fuelStationsFuel[9] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 2113.3835, 919.5655, 10.8203) && fuelStationsFuel[10] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 2641.0115, 1106.6252, 10.8203) && fuelStationsFuel[11] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 2146.7964, 2747.8115, 10.8203) && fuelStationsFuel[12] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 1595.7935, 2199.5996, 10.8203) && fuelStationsFuel[13] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, -1471.1836, 1863.7598, 32.6328) && fuelStationsFuel[14] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 655.7673, -565.0798, 16.3359) && fuelStationsFuel[15] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (IsPlayerInRangeOfPoint(playerid, 10, 1381.8230, 459.1453, 20.3452) && fuelStationsFuel[16] < strval(inputtext)) return SendClientMessage(playerid, 0xB4B5B7FF, "В бензиностанцията няма толкова бензин.");
        if (strval(inputtext) <= 100 - vehfuel[GetPlayerVehicleID(playerid)])
        {
            format(string256, 256, "Вие заредихте успешно {FFFF00}%d{FFFFFF} литра във вашето превозно средство.", strval(inputtext));
            SendClientMessage(playerid, 0xFFFFFFFFF, string256);
            vehfuel[GetPlayerVehicleID(playerid)] += strval(inputtext);
            GivePlayerCash(playerid, -strval(inputtext));
            fuelStationsFuel[FuelStationClose(playerid)] -= strval(inputtext);
            format(refuelstring, 500, "{0040FF}[ Бензиностанция ]\n{FF0000}%d/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", fuelStationsFuel[FuelStationClose(playerid)]);
            Update3DTextLabelText(fuelStationText[FuelStationClose(playerid)], 0xFFFFFFFF, refuelstring);
        }
    }
    if (dialogid == 11)
    {
        //if(respawnVehsVoteTimer==0)
        //{
        if (response)
        {
            PlayerInfo[playerid][pYes] = 1;
            voteResultsYes += 1;
        }
        if (!response)
        {
            PlayerInfo[playerid][pNo] = 1;
            voteResultsNo += 1;
        }
        //}
        {
            if (response)
            {
                PlayerInfo[playerid][pYes] = 1;
                respawnVehsYes += 1;
                if (respawnVehsTimer > 0)
                {
                    SendClientMessage(playerid, 0xFFFFFFFF, "VOTE RESPAWN CARS: Ти гласува с ДА за да бъдат RESPAWN-нати превозните средства!");
                }
            }
            if (!response)
            {
                PlayerInfo[playerid][pNo] = 1;
                respawnVehsNo += 1;
                if (respawnVehsTimer > 0)
                {
                    SendClientMessage(playerid, 0xFFFFFFFF, "VOTE RESPAWN CARS: Ти гласува с НЕ за да бъдат НЕ RESPAWN-нати превозните средства!");
                }
            }
        }
    }
    if (dialogid == 44)
    {
        //        new refuelstring[500];
        if (strval(inputtext) < 1)
        {
            format(string256, 256, "Не можете да заредите 0 литра във вашата цистерна.", strval(inputtext));
            SendClientMessage(playerid, 0xB4B5B7FF, string256);
            return 0;
        }
        if (vehfuel2[GetVehicleTrailer(GetPlayerVehicleID(playerid))] == 10000)
        {
            SendClientMessage(playerid, 0xB4B5B7FF, "Вашата цистерна е пълна.");
            return 0;
        }
        if (strval(inputtext) > 10000 - vehfuel2[GetVehicleTrailer(GetPlayerVehicleID(playerid))])
        {
            format(string256, 256, "Можете да заредите до %d литра във вашата цистерна.", 10000 - vehfuel2[GetVehicleTrailer(GetPlayerVehicleID(playerid))]);
            SendClientMessage(playerid, 0xB4B5B7FF, string256);
            return 0;
        }
        if (strval(inputtext) <= 10000 - vehfuel2[GetVehicleTrailer(GetPlayerVehicleID(playerid))])
        {
            //tuk
            refuelcisterna[playerid] = strval(inputtext);
            PlayerInfo[playerid][pRefuelTankIFC] = 4;
            TogglePlayerControllable(playerid, 0);
            GameTextForPlayer(playerid, "~g~PLEASE WAIT", 2000, 3);
            SendClientMessage(playerid, 0xA4FFA4FF, "Intense Fuel Company: Моля, изчакайте, докато заредим цистерната!");
        }
    }
    if (dialogid == DIALOG_CLOTHES_2)
    {
        if (response)
        {
            new string2230[512];
            new string2230result[1500];
            format(string2230, 512, "{FFFFFF}\n");
            strcat(string2230result, string2230);
            ShowPlayerDialog(playerid, DIALOG_CLOTHES_3, DIALOG_STYLE_MSGBOX, "Clothes:", string2230result, "Избери", "Излез");
        }
    }
    if (dialogid == DIALOG_CLOTHES)
    {
        if (response)
        {
            if (PlayerInfo[playerid][pClothes][listitem] == 0)
            {
                //ShowPlayerDialog(playerid,closeddialog,DIALOG_STYLE_MSGBOX,"{FF0000}АДМИН КОМАНДИ:",string2230result,"Изход","");
                ShowPlayerDialog(playerid, DIALOG_CLOTHES_2, DIALOG_STYLE_MSGBOX, "Clothes:", "Този слот е свободен", "Напред", "Излез");
                selectedTmpClothID[playerid] = listitem;
            }
        }
    }

    if (dialogid == DIALOG_BUY_OFFICE)
    {
        new officeID = (listitem + 1);
        new string2230[512];

        if (OfficeInfo[officeID][isOwned] == 1)
        {
            format(string2230, 512, "Офис %d вече се притежава от друг играч и не можеш да го купиш!", officeID);
            SendClientMessage(playerid, COLOR_GRAD1, string2230);
            return 1;
        }

        if (PlayerInfo[playerid][pCash] < OfficeInfo[officeID][NeededCash])
        {
            format(string2230, 512, "Трябва да имаш поне $%d за да купиш офиса!", OfficeInfo[officeID][NeededCash]);
            SendClientMessage(playerid, COLOR_GRAD1, string2230);
            return 1;
        }

        if (PlayerInfo[playerid][pLevel] < OfficeInfo[officeID][NeededLevel])
        {
            format(string2230, 512, "Трябва да имаш поне %d ниво за да купиш офиса!", OfficeInfo[officeID][NeededLevel]);
            SendClientMessage(playerid, COLOR_GRAD1, string2230);
            return 1;
        }

        if (PlayerInfo[playerid][pEPS] < OfficeInfo[officeID][NeededEPS])
        {
            format(string2230, 512, "Трябва да имаш поне %d EP Skill за да купиш офиса!", OfficeInfo[officeID][NeededEPS]);
            SendClientMessage(playerid, COLOR_GRAD1, string2230);
            return 1;
        }

        if (PlayerInfo[playerid][pMS] < OfficeInfo[officeID][NeededMS])
        {
            format(string2230, 512, "Трябва да имаш поне %d Money Skill за да купиш офиса!", OfficeInfo[officeID][NeededMS]);
            SendClientMessage(playerid, COLOR_GRAD1, string2230);
            return 1;
        }

        PlayerInfo[playerid][pCash] -= OfficeInfo[officeID][NeededCash];
        OfficeInfo[officeID][isOwned] = 1;
        format(OfficeInfo[officeID][OwnerName], 50, "%s", GetPlayerNickname(playerid));
        SaveOffices();

        format(string2230, 512, "Честито! Ти си купи офис номер %d за $%d", officeID, OfficeInfo[officeID][NeededCash]);
        SendClientMessage(playerid, 0x00FF00FF, string2230);
    }

    if (dialogid == DIALOG_HELP_OFFICE)
    {
        if (response)
        {
            new officeID = (listitem + 1);
            new string2230[512];
            new string2230result[2230];
            new closeddialog = 3500;
            format(string2230, 512, "{00FF00}Етаж %d {FFFFFF}- Изисквания\n\n", officeID);
            strcat(string2230result, string2230);
            if (OfficeInfo[officeID][isOwned] == 1)
            {
                format(string2230, 512, "{FFFFFF}Притежател: {FF0000}%s\n", OfficeInfo[officeID][OwnerName]);
                strcat(string2230result, string2230);
            }
            else if (OfficeInfo[officeID][isOwned] == 0)
            {
                format(string2230, 512, "{FFFFFF}Притежател: {FF0000}Няма\n");
                strcat(string2230result, string2230);
            }
            format(string2230, 512, "{FFFFFF}Цена: {FF0000}%d\n", OfficeInfo[officeID][NeededCash]);
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}Левел: {FF0000}%d\n", OfficeInfo[officeID][NeededLevel]);
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}EP Skill: {FF0000}%d\n", OfficeInfo[officeID][NeededEPS]);
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}MoneySkill: {FF0000}%d\n\n", OfficeInfo[officeID][NeededMS]);
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}Бонус EP на Payday: {33AA33}%d\n", OfficeInfo[officeID][BonusEP]);
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}Бонус пари на Payday: {33AA33}$%d\n", OfficeInfo[officeID][BonusCash]);
            strcat(string2230result, string2230);

            new stringHeader[50];
            format(stringHeader, 50, "Етаж %d:", officeID);
            ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, stringHeader, string2230result, "Затоври", "");
        }
    }
    if (dialogid == 42)
    {
        if (!response)
        {
            ShowPlayerDialog(playerid, 41, DIALOG_STYLE_LIST, "House Vehicles:", "От Level 5 нагоре - {00BF00}$30,000\nОт Level 7 нагоре - {00BF00}$60,000\nОт Level 10 нагоре - {00BF00}$100,000\nОт Level 15 нагоре - {00BF00}$160, 000\nОт Level 17 нагоре - {00BF00}$200,000\nОт Level 20 нагоре - {00BF00}$250,000", "Избери", "Излез");
        }
        if (response)
        {
            switch (listitem)
            {
                case 0:
                {
                    if (PlayerInfo[playerid][pCash] < 30000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 5) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -30000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!");
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 481;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);

                    //UpdateDatabaseField("v_id", const columnName[], const columnValue, const nickname[], const table[], bool:isString);
                }
                case 1:
                {
                    if (PlayerInfo[playerid][pCash] < 30000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 5) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -30000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!");
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 462;
                }
                case 2:
                {
                    if (PlayerInfo[playerid][pCash] < 30000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 5) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -30000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!");
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 464;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 3:
                {
                    if (PlayerInfo[playerid][pCash] < 30000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 5) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -30000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!");
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 543;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 4:
                {
                    if (PlayerInfo[playerid][pCash] < 30000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 5) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -30000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!");
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 478;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 5:
                {
                    if (PlayerInfo[playerid][pCash] < 30000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 5) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -30000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!");
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 566;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 6:
                {
                    if (PlayerInfo[playerid][pCash] < 30000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 5) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -30000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!");
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 500;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 7:
                {
                    if (PlayerInfo[playerid][pCash] < 30000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 5) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -30000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!");
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 401;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 8:
                {
                    if (PlayerInfo[playerid][pCash] < 30000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 5) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -30000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!");
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 526;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 9:
                {
                    if (PlayerInfo[playerid][pCash] < 30000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 5) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -30000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!");
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 546;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 10:
                {
                    if (PlayerInfo[playerid][pCash] < 30000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 5) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -30000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!");
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 436;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 11:
                {
                    if (PlayerInfo[playerid][pCash] < 30000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 5) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -30000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!");
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 549;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 12:
                {
                    if (PlayerInfo[playerid][pCash] < 30000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 5) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -30000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!");
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 418;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
            }
        }
    }
    //
    if (dialogid == 45)
    {
        if (!response)
        {
            ShowPlayerDialog(playerid, 41, DIALOG_STYLE_LIST, "House Vehicles:", "От Level 5 нагоре - {00BF00}$30,000\nОт Level 7 нагоре - {00BF00}$60,000\nОт Level 10 нагоре - {00BF00}$100,000\nОт Level 15 нагоре - {00BF00}$160, 000\nОт Level 17 нагоре - {00BF00}$200,000\nОт Level 20 нагоре - {00BF00}$250,000", "Избери", "Излез");
        }
        if (response)
        {
            switch (listitem)
            {
                case 0:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!");
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 471;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 1:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!");
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 600;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 2:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); //
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 422;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 3:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 413;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 4:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 576;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 5:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 400;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 6:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 445;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 7:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 455;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 8:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 518;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 9:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 527;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 10:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 585;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 11:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 419;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 12:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 466;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 13:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 410;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 14:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 516;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 15:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 547;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 16:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); /// HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 529;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 17:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 404;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 18:
                {
                    if (PlayerInfo[playerid][pCash] < 60000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 7) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -60000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 479;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
            }
        }
    }
    //
    //
    if (dialogid == 46)
    {
        if (!response)
        {
            ShowPlayerDialog(playerid, 41, DIALOG_STYLE_LIST, "House Vehicles:", "От Level 5 нагоре - {00BF00}$30,000\nОт Level 7 нагоре - {00BF00}$60,000\nОт Level 10 нагоре - {00BF00}$100,000\nОт Level 15 нагоре - {00BF00}$160, 000\nОт Level 17 нагоре - {00BF00}$200,000\nОт Level 20 нагоре - {00BF00}$250,000", "Избери", "Излез");
        }
        if (response)
        {
            switch (listitem)
            {
                case 0:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 510;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 1:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 463;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 2:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 439;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 3:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 482;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 4:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 554;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 5:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 536;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 6:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 412;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 7:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 424;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 8:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 489;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 9:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 504;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 10:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 480;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 11:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 492;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 12:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 471;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 13:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 517;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 14:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 551;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 15:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 467;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 16:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 405;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 17:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 550;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 18:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 540;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 19:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 491;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 20:
                {
                    if (PlayerInfo[playerid][pCash] < 100000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 10) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -100000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 602;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
            }
        }
    }
    //
    //
    if (dialogid == 47)
    {
        if (!response)
        {
            ShowPlayerDialog(playerid, 41, DIALOG_STYLE_LIST, "House Vehicles:", "От Level 5 нагоре - {00BF00}$30,000\nОт Level 7 нагоре - {00BF00}$60,000\nОт Level 10 нагоре - {00BF00}$100,000\nОт Level 15 нагоре - {00BF00}$160, 000\nОт Level 17 нагоре - {00BF00}$200,000\nОт Level 20 нагоре - {00BF00}$250,000", "Избери", "Излез");
        }
        if (response)
        {
            switch (listitem)
            {
                case 0:
                {
                    if (PlayerInfo[playerid][pCash] < 160000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 15) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -160000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 533;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 1:
                {
                    if (PlayerInfo[playerid][pCash] < 160000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 15) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -160000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 575;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 2:
                {
                    if (PlayerInfo[playerid][pCash] < 160000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 15) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -160000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 568;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 3:
                {
                    if (PlayerInfo[playerid][pCash] < 160000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 15) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -160000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 562;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 4:
                {
                    if (PlayerInfo[playerid][pCash] < 160000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 15) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -160000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 559;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 5:
                {
                    if (PlayerInfo[playerid][pCash] < 160000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 15) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -160000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 494;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 6:
                {
                    if (PlayerInfo[playerid][pCash] < 160000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 15) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -160000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 502;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 7:
                {
                    if (PlayerInfo[playerid][pCash] < 160000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 15) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -160000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 503;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 8:
                {
                    if (PlayerInfo[playerid][pCash] < 160000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 15) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -160000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 558;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 9:
                {
                    if (PlayerInfo[playerid][pCash] < 160000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 15) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -160000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 477;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 10:
                {
                    if (PlayerInfo[playerid][pCash] < 160000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 15) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -160000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 434;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 11:
                {
                    if (PlayerInfo[playerid][pCash] < 160000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 15) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -160000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 571;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
            }
        }
    }
    //
    //
    if (dialogid == 48)
    {
        if (!response)
        {
            ShowPlayerDialog(playerid, 41, DIALOG_STYLE_LIST, "House Vehicles:", "От Level 5 нагоре - {00BF00}$30,000\nОт Level 7 нагоре - {00BF00}$60,000\nОт Level 10 нагоре - {00BF00}$100,000\nОт Level 15 нагоре - {00BF00}$160, 000\nОт Level 17 нагоре - {00BF00}$200,000\nОт Level 20 нагоре - {00BF00}$250,000", "Избери", "Излез");
        }
        if (response)
        {
            switch (listitem)
            {
                case 0:
                {
                    if (PlayerInfo[playerid][pCash] < 200000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 17) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -200000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 521;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 1:
                {
                    if (PlayerInfo[playerid][pCash] < 200000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 17) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -200000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 555;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 2:
                {
                    if (PlayerInfo[playerid][pCash] < 200000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 17) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -200000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 535;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 3:
                {
                    if (PlayerInfo[playerid][pCash] < 200000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 17) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -200000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 495;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 4:
                {
                    if (PlayerInfo[playerid][pCash] < 200000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 17) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -200000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 560;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 5:
                {
                    if (PlayerInfo[playerid][pCash] < 200000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 17) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -200000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 429;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 6:
                {
                    if (PlayerInfo[playerid][pCash] < 200000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 17) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -200000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 402;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 7:
                {
                    if (PlayerInfo[playerid][pCash] < 200000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 17) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -200000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 603;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 8:
                {
                    if (PlayerInfo[playerid][pCash] < 200000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 17) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -200000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 506;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 9:
                {
                    if (PlayerInfo[playerid][pCash] < 200000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 17) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -200000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // //HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 415;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 10:
                {
                    if (PlayerInfo[playerid][pCash] < 200000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 17) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -200000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 409;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 11:
                {
                    if (PlayerInfo[playerid][pCash] < 200000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 17) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -200000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 447;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
            }
        }
    }
    if (dialogid == 49)
    {
        if (!response)
        {
            ShowPlayerDialog(playerid, 41, DIALOG_STYLE_LIST, "House Vehicles:", "От Level 5 нагоре - {00BF00}$30,000\nОт Level 7 нагоре - {00BF00}$60,000\nОт Level 10 нагоре - {00BF00}$100,000\nОт Level 15 нагоре - {00BF00}$160, 000\nОт Level 17 нагоре - {00BF00}$200,000\nОт Level 20 нагоре - {00BF00}$250,000", "Избери", "Излез");
        }
        if (response)
        {
            switch (listitem)
            {
                case 0:
                {
                    if (PlayerInfo[playerid][pCash] < 250000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 20) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -250000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 522;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 1:
                {
                    if (PlayerInfo[playerid][pCash] < 250000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 20) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -250000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 567;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 2:
                {
                    if (PlayerInfo[playerid][pCash] < 250000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 20) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -250000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 556;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 3:
                {
                    if (PlayerInfo[playerid][pCash] < 250000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 20) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -250000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 557;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 4:
                {
                    if (PlayerInfo[playerid][pCash] < 250000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 20) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -250000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 541;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 5:
                {
                    if (PlayerInfo[playerid][pCash] < 250000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 20) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -250000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 411;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 6:
                {
                    if (PlayerInfo[playerid][pCash] < 250000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 20) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -250000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 451;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 7:
                {
                    if (PlayerInfo[playerid][pCash] < 250000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 20) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -250000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 480;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
                case 8:
                {
                    if (PlayerInfo[playerid][pCash] < 250000) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно пари за да си купиш това превозно средство!");
                    if (PlayerInfo[playerid][pLevel] < 20) return SendClientMessage(playerid, COLOR_GRAD1, "Ти нямаш достатъчно голям левел за това превозно средство!");
                    GivePlayerCash(playerid, -250000);
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC] = 1;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcC2] = 1;
                    SendClientMessage(playerid, 0x00FF40FF, "Новото превозно средство към къщата ти ще бъде валидно след рестарт на сървъра!"); // HouseInfo[PlayerInfo[playerid][pHouseO]][hcY]=HouseInfo[PlayerInfo[playerid][pHouseO]][hY]; HouseInfo[PlayerInfo[playerid][pHouseO]][hcZ]=HouseInfo[PlayerInfo[playerid][pHouseO]][hZ];  HouseInfo[PlayerInfo[playerid][pHouseO]][hcX]+=5;
                    HouseInfo[PlayerInfo[playerid][pHouseO]][hcV] = 487;
                    SaveHouse(PlayerInfo[playerid][pHouseO]);
                }
            }
        }
    }
    //

    if (dialogid == 51)
    {
        if (response)
        {
            //goto fish

            new fishSlotId = listitem;
            new fish = PlayerInfo[playerid][pFishslot][fishSlotId];
            if (fish > 0)
            {
                new stringFishName[50];
                format(stringFishName, 50, "%s", GetFishName(fish));
                new weight = PlayerInfo[playerid][pFishSlotWeight][fishSlotId];
                new price = GetFishPrice(fish, weight);
                format(string256, 256, "Sell Fish: Ти продаде %s с тегло %d кг. и получи $%d!", stringFishName, weight, price);
                SendClientMessage(playerid, 0xC600C6FF, string256);
                GivePlayerCash(playerid, price);
                PlayerInfo[playerid][pFishslot][fishSlotId] = 0;
                PlayerInfo[playerid][pFishSlotWeight][fishSlotId] = 0;
            }

        }
    }

    if (dialogid == 41)
    {
        if (response)
        {
            switch (listitem)
            {
                case 0:
                {
                    ShowPlayerDialog(playerid, 42, DIALOG_STYLE_LIST, "Level 5:", "BMX\nFaggio\nWayfarer\nSadler\nWalton\nTahoma\nMessa\nBravura\nFortune\nIntruder\nPrevion\nTampa\nMoonbeam", "Избери", "Назад");
                }
                case 1:
                {
                    ShowPlayerDialog(playerid, 45, DIALOG_STYLE_LIST, "Level 7:", "Quad\nPicador\nBobcat\nPony\nTornado\nLandstalker\nAdmiral\nBuccaneer\nCadrona\nEmperor\nEspertano\nGlendale\nManana\nNebula\nPrimo\nWillard\nPerenniel\nRegina", "Избери", "Назад");
                }
                case 2:
                {
                    ShowPlayerDialog(playerid, 46, DIALOG_STYLE_LIST, "Level 10:", "Mountain Bike\nFreeway\nStallion\nBurrito\nYosemite\nBlade\nVoodo\nBF Injection\nRancher\nBloodring Banger\nCover\nGreenwood\nHermes\nMajestic\nMerit\nOceanic\nSentinel\nSunrise\nVincent\nVirgo\nAlpha", "Избери", "Назад");
                }
                case 3:
                {
                    ShowPlayerDialog(playerid, 47, DIALOG_STYLE_LIST, "Level 15:", "PCJ-500\nFeltzer\nBroadway\nBandito\nElegy\nJester\nHotring Racer\nHotring Racer 2\nHotring Racer 3\nUranus\nZR-350\nHotknife\nKart", "Избери", "Назад");
                }
                case 4:
                {
                    ShowPlayerDialog(playerid, 48, DIALOG_STYLE_LIST, "Level 17:", "FCR-900\nWindsor\nSlamvan\nSandking\nSultan\nBanshee\nBuffalo\nPhoenix\nSuper GT\nCheetah\nStretch\nSparrow", "Избери", "Назад");
                }
                case 5:
                {
                    ShowPlayerDialog(playerid, 49, DIALOG_STYLE_LIST, "Level 20:", "NRG-500\nSavanna\nMonster\nMonster A\nMonster B\nBullet\nInfernus\nTursimo\nComet\nMaverick", "Избери", "Назад");
                }
            }
        }
    }

    if (dialogid == DIALOG_BUYFISH)
    {
        if (response)
        {
            switch (listitem)
            {
                case 0:
                {
                    if (PlayerInfo[playerid][pHook] == 1) return SendClientMessage(playerid, COLOR_GRAD1, "Ти вече имаш въдица за риболов!");
                    SendClientMessage(playerid, 0xC600C6FF, "Fishing Store: Ти си купи въдица за риболов за $350!");
                    PlayerInfo[playerid][pHook] = 1;
                    GivePlayerCash(playerid, -350);
                    BizInfo[0][bEarnings] += 350;
                }
                case 1:
                {
                    SendClientMessage(playerid, 0xC600C6FF, "Fishing Store: Ти си купи стръв(50 червея) за $100!");
                    PlayerInfo[playerid][pStruv] += 50;
                    GivePlayerCash(playerid, -100);
                    BizInfo[0][bEarnings] += 100;
                }
            }
        }
    }

    if (dialogid == 24)
    {
        if (response)
        {
            switch (listitem)
            {
                case 0:
                {
                    new string500[500];
                    format(string500, 500, "{FFFFFF}Патронът на оръжието 9mm струва {00BF00}$2\n{FFFFFF}Колко патрона искаш да купиш?");
                    ShowPlayerDialog(playerid, 25, DIALOG_STYLE_INPUT, "Патрони", string500, "Купи", "Затвори");
                }
                case 1:
                {
                    new string500[500];
                    format(string500, 500, "{FFFFFF}Патронът на оръжието Silenced 9mm струва {00BF00}$3\n{FFFFFF}Колко патрона искаш да купиш?");
                    ShowPlayerDialog(playerid, 26, DIALOG_STYLE_INPUT, "Патрони", string500, "Купи", "Затвори");
                }
                case 2:
                {
                    new string500[500];
                    format(string500, 500, "{FFFFFF}Патронът на оръжието Desert Eagle струва {00BF00}$5\n{FFFFFF}Колко патрона искаш да купиш?");
                    ShowPlayerDialog(playerid, 27, DIALOG_STYLE_INPUT, "Патрони", string500, "Купи", "Затвори");
                }
                case 3:
                {
                    new string500[500];
                    format(string500, 500, "{FFFFFF}Патронът на оръжието Shotgun струва {00BF00}$8\n{FFFFFF}Колко патрона искаш да купиш?");
                    ShowPlayerDialog(playerid, 28, DIALOG_STYLE_INPUT, "Патрони", string500, "Купи", "Затвори");
                }
                case 4:
                {
                    new string500[500];
                    format(string500, 500, "{FFFFFF}Патронът на оръжието Sawnoff струва {00BF00}$12\n{FFFFFF}Колко патрона искаш да купиш?");
                    ShowPlayerDialog(playerid, 29, DIALOG_STYLE_INPUT, "Патрони", string500, "Купи", "Затвори");
                }
                case 5:
                {
                    new string500[500];
                    format(string500, 500, "{FFFFFF}Патронът на оръжието Combat Shotgun струва {00BF00}$14\n{FFFFFF}Колко патрона искаш да купиш?");
                    ShowPlayerDialog(playerid, 30, DIALOG_STYLE_INPUT, "Патрони", string500, "Купи", "Затвори");
                }
                case 6:
                {
                    new string500[500];
                    format(string500, 500, "{FFFFFF}Патронът на оръжието MP5 струва {00BF00}$2\n{FFFFFF}Колко патрона искаш да купиш?");
                    ShowPlayerDialog(playerid, 31, DIALOG_STYLE_INPUT, "Патрони", string500, "Купи", "Затвори");
                }
                case 7:
                {
                    new string500[500];
                    format(string500, 500, "{FFFFFF}Патронът на оръжието Uzi струва {00BF00}$2\n{FFFFFF}Колко патрона искаш да купиш?");
                    ShowPlayerDialog(playerid, 32, DIALOG_STYLE_INPUT, "Патрони", string500, "Купи", "Затвори");
                }
                case 8:
                {
                    new string500[500];
                    format(string500, 500, "{FFFFFF}Патронът на оръжието Tec9 струва {00BF00}$3\n{FFFFFF}Колко патрона искаш да купиш?");
                    ShowPlayerDialog(playerid, 33, DIALOG_STYLE_INPUT, "Патрони", string500, "Купи", "Затвори");
                }
                case 9:
                {
                    new string500[500];
                    format(string500, 500, "{FFFFFF}Патронът на оръжието AK-47 струва {00BF00}$5\n{FFFFFF}Колко патрона искаш да купиш?");
                    ShowPlayerDialog(playerid, 34, DIALOG_STYLE_INPUT, "Патрони", string500, "Купи", "Затвори");
                }
                case 10:
                {
                    new string500[500];
                    format(string500, 500, "{FFFFFF}Патронът на оръжието M4 струва {00BF00}$6\n{FFFFFF}Колко патрона искаш да купиш?");
                    ShowPlayerDialog(playerid, 35, DIALOG_STYLE_INPUT, "Патрони", string500, "Купи", "Затвори");
                }
                case 11:
                {
                    new string500[500];
                    format(string500, 500, "{FFFFFF}Патронът на оръжието Country Rifle струва {00BF00}$67\n{FFFFFF}Колко патрона искаш да купиш?");
                    ShowPlayerDialog(playerid, 36, DIALOG_STYLE_INPUT, "Патрони", string500, "Купи", "Затвори");
                }
                case 12:
                {
                    new string500[500];
                    format(string500, 500, "{FFFFFF}Патронът на оръжието Sniper Rifle струва {00BF00}$400\n{FFFFFF}Колко патрона искаш да купиш?");
                    ShowPlayerDialog(playerid, 37, DIALOG_STYLE_INPUT, "Патрони", string500, "Купи", "Затвори");
                }
            }
        }
    }
    if (dialogid == 25)
    {
        if (response)
        {
            if (strval(inputtext) < 1 || strval(inputtext) > 10000) return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да вкараш от 1 до 10000 патроа!");
            GivePlayerCash(playerid, -strval(inputtext) * 2);
            GivePlayerWeapon(playerid, 22, strval(inputtext) * 2);
            BizInfo[enteredbiz[playerid]][bEarnings] += 2 * strval(inputtext);
        }
    }
    if (dialogid == 26)
    {
        if (response)
        {
            if (strval(inputtext) < 1 || strval(inputtext) > 10000) return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да вкараш от 1 до 10000 патроа!");
            GivePlayerCash(playerid, -strval(inputtext) * 3);
            GivePlayerWeapon(playerid, 22, strval(inputtext) * 3);
            BizInfo[enteredbiz[playerid]][bEarnings] += 3 * strval(inputtext);
        }
    }
    if (dialogid == 27)
    {
        if (response)
        {
            if (strval(inputtext) < 1 || strval(inputtext) > 10000) return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да вкараш от 1 до 10000 патроа!");
            GivePlayerCash(playerid, -strval(inputtext) * 5);
            GivePlayerWeapon(playerid, 22, strval(inputtext) * 5);
            BizInfo[enteredbiz[playerid]][bEarnings] += 5 * strval(inputtext);
        }
    }
    if (dialogid == 28)
    {
        if (response)
        {
            if (strval(inputtext) < 1 || strval(inputtext) > 10000) return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да вкараш от 1 до 10000 патроа!");
            GivePlayerCash(playerid, -strval(inputtext) * 8);
            GivePlayerWeapon(playerid, 22, strval(inputtext) * 8);
            BizInfo[enteredbiz[playerid]][bEarnings] += 8 * strval(inputtext);
        }
    }
    if (dialogid == 29)
    {
        if (response)
        {
            if (strval(inputtext) < 1 || strval(inputtext) > 10000) return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да вкараш от 1 до 10000 патроа!");
            GivePlayerCash(playerid, -strval(inputtext) * 12);
            GivePlayerWeapon(playerid, 22, strval(inputtext) * 12);
            BizInfo[enteredbiz[playerid]][bEarnings] += 12 * strval(inputtext);
        }
    }
    if (dialogid == 30)
    {
        if (response)
        {
            if (strval(inputtext) < 1 || strval(inputtext) > 10000) return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да вкараш от 1 до 10000 патроа!");
            GivePlayerCash(playerid, -strval(inputtext) * 14);
            GivePlayerWeapon(playerid, 22, strval(inputtext) * 14);
            BizInfo[enteredbiz[playerid]][bEarnings] += 14 * strval(inputtext);
        }
    }
    if (dialogid == 31)
    {
        if (response)
        {
            if (strval(inputtext) < 1 || strval(inputtext) > 10000) return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да вкараш от 1 до 10000 патроа!");
            GivePlayerCash(playerid, -strval(inputtext) * 2);
            GivePlayerWeapon(playerid, 22, strval(inputtext) * 2);
            BizInfo[enteredbiz[playerid]][bEarnings] += 2 * strval(inputtext);
        }
    }
    if (dialogid == 32)
    {
        if (response)
        {
            if (strval(inputtext) < 1 || strval(inputtext) > 10000) return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да вкараш от 1 до 10000 патроа!");
            GivePlayerCash(playerid, -strval(inputtext) * 2);
            GivePlayerWeapon(playerid, 22, strval(inputtext) * 2);
            BizInfo[enteredbiz[playerid]][bEarnings] += 2 * strval(inputtext);
        }
    }
    if (dialogid == 33)
    {
        if (response)
        {
            if (strval(inputtext) < 1 || strval(inputtext) > 10000) return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да вкараш от 1 до 10000 патроа!");
            GivePlayerCash(playerid, -strval(inputtext) * 3);
            GivePlayerWeapon(playerid, 22, strval(inputtext) * 3);
            BizInfo[enteredbiz[playerid]][bEarnings] += 3 * strval(inputtext);
        }
    }
    if (dialogid == 34)
    {
        if (response)
        {
            if (strval(inputtext) < 1 || strval(inputtext) > 10000) return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да вкараш от 1 до 10000 патроа!");
            GivePlayerCash(playerid, -strval(inputtext) * 5);
            GivePlayerWeapon(playerid, 22, strval(inputtext) * 5);
            BizInfo[enteredbiz[playerid]][bEarnings] += 5 * strval(inputtext);
        }
    }
    if (dialogid == 35)
    {
        if (response)
        {
            if (strval(inputtext) < 1 || strval(inputtext) > 10000) return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да вкараш от 1 до 10000 патроа!");
            GivePlayerCash(playerid, -strval(inputtext) * 6);
            GivePlayerWeapon(playerid, 22, strval(inputtext) * 6);
            BizInfo[enteredbiz[playerid]][bEarnings] += 6 * strval(inputtext);
        }
    }
    if (dialogid == 36)
    {
        if (response)
        {
            if (strval(inputtext) < 1 || strval(inputtext) > 10000) return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да вкараш от 1 до 10000 патроа!");
            GivePlayerCash(playerid, -strval(inputtext) * 67);
            GivePlayerWeapon(playerid, 22, strval(inputtext) * 67);
            BizInfo[enteredbiz[playerid]][bEarnings] += 67 * strval(inputtext);
        }
    }
    if (dialogid == 37)
    {
        if (response)
        {
            if (strval(inputtext) < 1 || strval(inputtext) > 10000) return SendClientMessage(playerid, 0xB4B5B7FF, "Можеш да вкараш от 1 до 10000 патроа!");
            GivePlayerCash(playerid, -strval(inputtext) * 400);
            GivePlayerWeapon(playerid, 22, strval(inputtext) * 400);
            BizInfo[enteredbiz[playerid]][bEarnings] += 400 * strval(inputtext);
        }
    }
    if (dialogid == 23)
    {
        if (response)
        {
            switch (listitem)
            {
                case 0:
                {
                    if (PlayerInfo[playerid][pCash] < 50) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $50!");
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
                    GivePlayerCash(playerid, -50);
                    BizInfo[enteredbiz[playerid]][bEarnings] += 50;
                }
                case 1:
                {
                    if (PlayerInfo[playerid][pCash] < 60) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $60!");
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
                    GivePlayerCash(playerid, -60);
                    BizInfo[enteredbiz[playerid]][bEarnings] += 60;
                    new bizz[64];
                    format(bizz, 64, "/Bizz/%d.ini", enteredbiz[playerid]);
                }
                case 2:
                {
                    if (PlayerInfo[playerid][pCash] < 100) return SendClientMessage(playerid, 0xB4B5B7FF, "Трябва да имаш поне $100!");
                    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
                    GivePlayerCash(playerid, -100);
                    BizInfo[enteredbiz[playerid]][bEarnings] += 100;
                }
            }
        }
    }
    if (dialogid == 10)
    {
        if (!response)
        {}
        if (response)
        {
            switch (listitem)
            {
                case 0: GivePlayerWeapon(playerid, WEAPON_KNIFE, 1);
                case 1: GivePlayerWeapon(playerid, WEAPON_BAT, 1);
                case 2: GivePlayerWeapon(playerid, WEAPON_COLT45, 100);
                case 3: GivePlayerWeapon(playerid, WEAPON_SILENCED, 100);
                case 4: GivePlayerWeapon(playerid, WEAPON_DEAGLE, 100);
                case 5: GivePlayerWeapon(playerid, WEAPON_SHOTGUN, 125);
                case 6: GivePlayerWeapon(playerid, WEAPON_SAWEDOFF, 125);
                case 7: GivePlayerWeapon(playerid, WEAPON_SHOTGSPA, 125);
                case 8: GivePlayerWeapon(playerid, WEAPON_UZI, 1150);
                case 9: GivePlayerWeapon(playerid, WEAPON_MP5, 500);
                case 10: GivePlayerWeapon(playerid, WEAPON_TEC9, 500);
                case 11: GivePlayerWeapon(playerid, WEAPON_AK47, 500);
                case 12: GivePlayerWeapon(playerid, WEAPON_M4, 500);
                case 13: GivePlayerWeapon(playerid, WEAPON_RIFLE, 300);
                case 14: GivePlayerWeapon(playerid, WEAPON_SNIPER, 20);
            }
        }
    }
    if (dialogid == 9)
    {
        if (response)
        {
            new string2230[512];
            new string2230result[2200];
            format(string2230, 512, "{00FF00}---Команди за лидер на банда/мафия---\n\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/invite - дава покана за банда/мафия до играч\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/cinvite - отменя покана на играч за банда/мафия\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/uninvite - гони играча от бандата/мафията\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/nuninvite - гони играча от бандата/мафията чрез въвеждане на никнейм\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/setrank - дава ранк на играч\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/setrankname - променя името на даден ранк\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/lc - за да пишеш в лидерския чат\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/checktogf - за да провериш дали даден играч вижда или не вижда FACTION чата\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/factionmute(/fmute) - слагате MUTE в FACTION CHAT-а на играч\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/factiotimenmute(/ftmute) - слагате TIMEMUTE в FACTION CHAT-а на играч\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/fmuted - проверявате кой е MUTE в FACTION CHAT-а\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/factionmuteall(/fmuteall) - заглушавате всички играчи от твоята банда/мафия в FACTION CHAT-а\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/factionunmuteall(/funmuteall) - отглушавате всички играчи от твоята банда/мафия в FACTION CHAT-а\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/nfmute - слагате MUTE в FACTION чата на играч по никнейм\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/nftmute - слагате TIME MUTE в FACTION чата на играч по никнейм\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/fwarn - слага FACTION предупреждение на даден играч\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/unfwarn - маха FACTION предупреждение на даден играч\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/nfwarn - слага FACTION предупреждение на даден акаунт\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/nunfwarn - маха FACTION предупреждение на даден акаунт\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/checkfwarn - да провериш колко FACTION предупреждения има даден играч\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/ismember - за да провериш даден играч дали е от твоята банда/мафия\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{008000}/turfattack - за да атакуваш територия\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FF0000}/turftime - за да провериш колко време остава до началото на нова атака\n");
            strcat(string2230result, string2230);
            format(string2230, 512, "{FFFFFF}/attackers - показва играчите, които са участници в атаката на територия\n");
            strcat(string2230result, string2230);
            new closeddialog = 3500;
            ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, "{33CCFF}FACTION HELP", string2230result, "Затвори", "");
        }
    }
    if (dialogid == 8)
    {
        if (!response)
        {
            format(string256, 256, "{FFFFFF}Добре дошъл {40BF00}%s\n{FFFFFF}Моля регистрирай акаунта като въведеш паролата отдолу:", GetPlayerNickname(playerid));
            ShowPlayerDialog(playerid, 0, DIALOG_STYLE_PASSWORD, "Регистрация:", string256, "Регистрирай", "Излез");
        }
        if (response)
        {
            if (!IsNumeric(inputtext))
            {
                ShowPlayerDialog(playerid, 8, DIALOG_STYLE_INPUT, "GSM номер:", "{FF0000}GSM номерът трябва да съдържа само цифри!", "Въведи", "Пропусни");
                return 1;
            }
            if (strlen(inputtext) != 10)
            {
                ShowPlayerDialog(playerid, 8, DIALOG_STYLE_INPUT, "GSM номер:", "{FF0000}GSM номерът трябва да съдържа точно 10 цифри!", "Въведи", "Пропусни");
            }
            else
            {
                PlayerInfo[playerid][pGSM] = strval(inputtext);
                format(string256, 256, "{FFFFFF}Добре дошъл {40BF00}%s\n{FFFFFF}Моля регистрирай акаунта като въведеш паролата отдолу:", GetPlayerNickname(playerid));
                ShowPlayerDialog(playerid, 0, DIALOG_STYLE_PASSWORD, "Регистрация:", string256, "Регистрирай", "Излез");
            }
        }
    }
    if (dialogid == 5)
    {
        if (!response)
        {}
        if (response) // If they clicked 'Select' or double-clicked a weapon
        {
            // Give them the weapon
            switch (listitem)
            {
                //          new noerrorstring4[115];
                case 0:
                {
                    format(noerrorstring4, 115, "{FFFFFF}Вашата обща сума е {40BF00}$%d\n", PlayerInfo[playerid][pAccount]);
                    new closeddialog = 3500;
                    ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, "Обща сума:", noerrorstring4, "Затвори", "");
                }
                case 1:
                {
                    format(noerrorstring4, 115, "{FFFFFF}Вие имате {40BF00}$%d\n{FFFFFF}Моля въведете отдолу колко долара искате да изтеглите от вашата сума:", PlayerInfo[playerid][pAccount]);
                    ShowPlayerDialog(playerid, 6, DIALOG_STYLE_INPUT, "Изтегли пари:", noerrorstring4, "Изтегли", "Назад");
                }
                case 2:
                {
                    format(string175, 175, "{FFFFFF}Вие имате {FF0000}%d{FFFFFF} нарушения. За да платите едно това ще ви струва {40BF00}$1000\n{FFFFFF}Моля въведете отдолу колко броя нарушения искате да платите:", PlayerInfo[playerid][pWanted]);
                    ShowPlayerDialog(playerid, 7, DIALOG_STYLE_INPUT, "Плати нарушение:", string175, "Плати", "Назад");
                }
            }
        }
    }
    if (dialogid == 6)
    {
        if (!response)
        {}
        if (response)
        {
            if (!IsNumeric(inputtext))
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Въведи само цифри !");
                return 1;
            }
            if (strval(inputtext) == 0)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Въведи число различно от 0 !");
                return 1;
            }
            if (PlayerInfo[playerid][pAccount] < strval(inputtext))
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш толкова пари !");
                return 1;
            }
            if (strval(inputtext) > 1000000) return SendClientMessage(playerid, 0xB4B5B7FF, "Сумата трябва да е по-малка от $1000000!");
            //new noerrorstring4[115];
            GivePlayerCash(playerid, strval(inputtext));
            PlayerInfo[playerid][pAccount] -= strval(inputtext);
            //ApplyAnimation(playerid, "PED", "ATM", 3.0,1,1,0,0,0);
            format(noerrorstring4, 115, "Вие успешно изтеглихте {40BF00}$%d {FFFFFF}от вашата обща сума.", strval(inputtext));
            SendClientMessage(playerid, 0xFFFFFFFF, noerrorstring4);
        }
        else
        {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "Банкомат", "Обща сума\nИзтегли пари\nВнеси пари", "Избери", "Затвори");
        }
    }
    if (dialogid == 7)
    {
        if (!response)
        {}
        if (response) //Continue
        {
            if (!IsNumeric(inputtext))
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Въведи само цифри !");
                return 1;
            }
            if (strval(inputtext) == 0)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Въведи число различно от 0 !");
                return 1;
            }
            if (strval(inputtext) > PlayerInfo[playerid][pWanted])
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш толкова звезди !");
                return 1;
            }
            if (PlayerInfo[playerid][pCash] < strval(inputtext) * 1000)
            {
                SendClientMessage(playerid, 0xB4B5B7FF, "Ти нямаш толкова пари !");
                return 1;
            }
            //new noerrorstring4[115];
            GivePlayerCash(playerid, -strval(inputtext) * 1000);
            format(noerrorstring4, 115, "Вие успешно платихте {40BF00}%d {FFFFFF}нарушение/я ", strval(inputtext), PlayerInfo[playerid][pAccount]);
            SendClientMessage(playerid, 0xFFFFFFFF, noerrorstring4);
            PlayerInfo[playerid][pWanted] -= strval(inputtext);
            SetPlayerWantedLevel(playerid, PlayerInfo[playerid][pWanted]);
            UpdatePlayerHeadText(playerid);
        }
        else
        {
            ShowPlayerDialog(playerid, 5, DIALOG_STYLE_LIST, "Банкомат", "Обща сума\nИзтегли пари\nПлати нарушение", "Избери", "Затвори");
        }
    }
    return 1;
}