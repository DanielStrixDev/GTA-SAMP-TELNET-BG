CMD:admins(playerid, params[])
{
    new adminsonline = 0;
    new admintext[501];
    new string2230result[1500];
    new adminprefix2[30];

    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            if (PlayerInfo[i][pTest] == 1)
            {
                adminprefix2 = "Test Admin";
            }
            if (PlayerInfo[i][pAdmin] == 1)
            {
                adminprefix2 = "Helper";
            }
            if (PlayerInfo[i][pAdmin] == 2)
            {
                adminprefix2 = "Administrator";
            }
            if (PlayerInfo[i][pAdmin] == 3)
            {
                adminprefix2 = "Moderator";
            }
            if (PlayerInfo[i][pAdmin] == 4)
            {
                adminprefix2 = "Grand Admin";
            }
            if (PlayerInfo[i][pManage] == 1)
            {
                adminprefix2 = "Manage Admin";
            }
            if (PlayerInfo[i][pAdmin] == 5)
            {
                adminprefix2 = "Owner";
            }
            if (PlayerInfo[i][pAdmin] == 6)
            {
                adminprefix2 = "Scripter";
            }

            // Форматиране на текста за всеки администратор
            if (PlayerInfo[i][pTest] == 1)
            {
                adminsonline += 1;
                format(admintext, sizeof(admintext), "{33CCFF}%s: {FFFFFF}%s (ID: %d)       Status: {F2E93E}Test Admin\n", adminprefix2, GetPlayerNickname(i), i);
                strcat(string2230result, admintext);
            }

            if (PlayerInfo[i][pAdmin] > 0)
            {
                adminsonline += 1;
                if (PlayerInfo[i][pADuty] == 1)
                {
                    format(admintext, sizeof(admintext), "{33CCFF}%s: {FFFFFF}%s (ID: %d)       Status: {00E600}On-Duty\n", adminprefix2, GetPlayerNickname(i), i);
                    strcat(string2230result, admintext);
                }
                else if (PlayerInfo[i][pADuty] == 0 && PlayerInfo[i][pAFK] == 0)
                {
                    format(admintext, sizeof(admintext), "{33CCFF}%s: {FFFFFF}%s (ID: %d)       Status: {E60000}Off-Duty\n", adminprefix2, GetPlayerNickname(i), i);
                    strcat(string2230result, admintext);
                }
                else if (PlayerInfo[i][pADuty] == 0 && PlayerInfo[i][pAFK] > 0)
                {
                    format(admintext, sizeof(admintext), "{33CCFF}%s: {FFFFFF}%s (ID: %d)       Status: {F97804}Away From Keyboard\n", adminprefix2, GetPlayerNickname(i), i);
                    strcat(string2230result, admintext);
                }
            }
        }
    }

    new dialogclosestring[256];
    new closeddialog = 3500;
    format(dialogclosestring, sizeof(dialogclosestring), "{40BF00}Онлайн администратори (%d):", adminsonline);

    if (adminsonline > 0)
    {
        ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, dialogclosestring, string2230result, "Затвори", "");
    }
    else
    {
        ShowPlayerDialog(playerid, closeddialog, DIALOG_STYLE_MSGBOX, dialogclosestring, "{E60000}Няма онлайн администратори в момента!", "Затвори", "");
    }

    return 1;
}

CMD:help(playerid, params[])
{
    new string2230[512];
    new string2230result[2230];
    format(string2230, 512, "{00FF00}---Основни команди---\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}/stats - показва вашата статистика\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}/pm - пращане на лично съобщение до играч\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}/ignore - игнорира даден играч от твоите лични съобщения\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}/unignore - маха игнорирането на играч от твоите лични съобщения\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}/buylevel - за да вдигнете вашия левел\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}/buyes - за да вдигнете вашия EP Skill левел\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}/buyms - за да вдигнете вашия Money Skill левел\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}/buyws - за да вдигнете вашия Weapon Skill левел\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}/buyhouse - за да купите къща\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}/buybiz - за да купите бизнес\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}/enter - за да влезете в къща или бизнес\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}/exit - за да излезете от къща или бизнес\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}/changepass - сменяне на паролата\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}/spawn - за да промениш твоя spawn\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}/report - докладване на хакери\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}/time - скрива/показва часовника на екрана\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}/site - скрива/показва сайта на екрана\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}/statistic - показва статистиката на екрана\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}/id - показва ID-то на играч\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}/admins - показва онлайн админите\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}/ifc - показва онлайн членовете на Intense Fuel Company\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}/lotto - залагане на тото\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}/checklotto - за да провериш стойността на джакпота на лотарията\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}/c - пуска брояч\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}/rules - показва правилата на сървъра\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}/vipusers - показва онлайн VIP играчите\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FF0000}/leaders - показва онлайн лидерите\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{FFFFFF}/idveh - за да видите ID-то на превозното средство\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}/bank - за да отворите менюто на банката\n");
    strcat(string2230result, string2230);
    ShowPlayerDialog(playerid, 12, DIALOG_STYLE_MSGBOX, "{FFFFFF}КО{008000}МАН{FF0000}ДИ", string2230result, "Други", "Затвори");
    return 1;
}
CMD:rules(playerid, params[])
{
    new string2230[512];
    new string2230result[2230];
    format(string2230, 512, "{FFFFFF}За да прегледате нашите правила, моля посетете Discord сървъра ни\n");
    strcat(string2230result, string2230);
    format(string2230, 512, "{008000}Линк към Discord: \n");
    strcat(string2230result, string2230);
    ShowPlayerDialog(playerid, 3500, DIALOG_STYLE_MSGBOX, "{FFFFFF}ПР{008000}АВИ{FF0000}ЛА", string2230result, "OK", "");
    return 1;
}

CMD:intro(playerid, params[])
{
    new song;
    if (sscanf(params, "i", song))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /intro [1-8]");
        return 1;
    }

    if (song < 1 || song > 8)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Песните са от 1 до 8!");
        return 1;
    }

    introon[playerid] = 1;
    
    switch(song)
    {
        case 1: PlayAudioStreamForPlayer(playerid, audiostreams[0]);
        case 2: PlayAudioStreamForPlayer(playerid, audiostreams[1]);
        case 3: PlayAudioStreamForPlayer(playerid, audiostreams[2]);
        case 4: PlayAudioStreamForPlayer(playerid, audiostreams[3]);
        case 5: PlayAudioStreamForPlayer(playerid, audiostreams[4]);
        case 6: PlayAudioStreamForPlayer(playerid, audiostreams[5]);
        case 7: PlayAudioStreamForPlayer(playerid, audiostreams[6]);
        case 8: PlayAudioStreamForPlayer(playerid, audiostreams[7]);
    }
    
    SendClientMessage(playerid, 0xFFFFFFFF, "* Ти пусна песен от интрото *");
    return 1;
}

CMD:id(playerid, params[])
{
    new searchName[MAX_PLAYER_NAME];
    if (sscanf(params, "s[24]", searchName))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /id [част от никнейма или целия]");
        return 1;
    }
    
    new foundCount = 0;
    new searchMessage[128];
    format(searchMessage, sizeof(searchMessage), "Търсене за: {FF0000}%s", searchName);
    SendClientMessage(playerid, 0xFFFFFFFF, searchMessage);
    
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i))
        {
            new playerName[MAX_PLAYER_NAME];
            GetPlayerName(i, playerName, sizeof(playerName));
            
            if (strfind(playerName, searchName, true) != -1)
            {
                foundCount++;
                new resultMessage[128];
                format(resultMessage, sizeof(resultMessage), "%d. %s (ID:%d)", foundCount, GetPlayerNickname(i), i);
                SendClientMessage(playerid, 0xFFFF00FF, resultMessage);
            }
        }
    }
    
    if (foundCount == 0)
    {
        SendClientMessage(playerid, 0xE60000FF, "Няма открити играчи с този никнейм в сървъра!");
    }
    
    return 1;
}

CMD:animlist(playerid, params[])
{
    SendClientMessage(playerid, 0xFFCC00FF, ". : : Анимации : : .");
    SendClientMessage(playerid, 0x99CEFFFF, "/fall /injured /push /handsup /kiss /cellin /cellout /aslap /bomber /drunk /laugh");
    SendClientMessage(playerid, 0x99CEFFFF, "/basket /medic /spray /robman /taichi /sit /lay /sup /crossarms");
    SendClientMessage(playerid, 0x99CEFFFF, "/deal /crack /smoke /speak /hike /dance /fuck /strip /lean /walk /rap /caract");
    SendClientMessage(playerid, 0x99CEFFFF, "/tired /box /scratch /ahide /vomit /eats /cop /stance /wave /run");
    SendClientMessage(playerid, 0x99CEFFFF, "/flag /giver /look /show /shout /endchat /pull /lookout /wank /arresta /adie");
    SendClientMessage(playerid, 0x99CEFFFF, "/ciggy /pee /rocky /glitched /gangshake /shake /hug /accept /reject");
    SendClientMessage(playerid, 0x33AA33FF, "За да спреш анимацията натисни SPACE, LMB или ENTER");
    return 1;
}

CMD:site(playerid, params[])
{
    if (sitec[playerid] == 0)
    {
        format(string256, 256, "* Вие премахнахте сайта от екрана *");
        SendClientMessage(playerid, 0xFFFF00FF, string256);
        TextDrawHideForPlayer(playerid, intensetext);
        sitec[playerid] = 1;
        return 1;
    }
    if (sitec[playerid] == 1)
    {
        format(string256, 256, "* Вие сложихте сайта на екрана *");
        SendClientMessage(playerid, 0xFFFF00FF, string256);
        TextDrawShowForPlayer(playerid, intensetext);
        sitec[playerid] = 0;
        return 1;
    }
    return 1;
}
CMD:time(playerid, params[])
{
    if (timec[playerid] == 0)
    {
        format(string256, 256, "* Вие премахнахте вашия часовника и дата от екрана *");
        SendClientMessage(playerid, 0xFFFF00FF, string256);
        TextDrawHideForPlayer(playerid, ClockDate);
        timec[playerid] = 1;
        return 1;
    }
    if (timec[playerid] == 1)
    {
        format(string256, 256, "* Вие сложихте вашия часовник и дата на екрана *");
        SendClientMessage(playerid, 0xFFFF00FF, string256);
        TextDrawShowForPlayer(playerid, ClockDate);
        timec[playerid] = 0;
        return 1;
    }
    return 1;
}
CMD:report(playerid, params[])
{
    new targetid, reason[128];
    if (sscanf(params, "ds[128]", targetid, reason))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /report [playerid] [text]");
        return 1;
    }
    
    if (!IsPlayerConnected(targetid))
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Посоченото ID не е в сървъра!");
        return 1;
    }
    
    if (playerid == targetid)
    {
        SendClientMessage(playerid, 0xB4B5B7FF, "Не можеш да изпратиш Report за себе си!");
        return 1;
    }
    
    if (strlen(reason) < 1)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /report [playerid] [text]");
        return 1;
    }
    
    // Send confirmation to the reporter
    SendClientMessage(playerid, 0xFFFF00FF, "Ти успешно изпрати своя доклад до онлайн администраторите!");
    
    // Send report to all online admins and testers
    new reportMessage[256];
    format(reportMessage, sizeof(reportMessage), "Report от %s(%d) за %s(%d) Причина: %s", 
        GetPlayerNickname(playerid), playerid, GetPlayerNickname(targetid), targetid, reason);
    
    for (new i = 0; i < MAX_PLAYERS; i++)
    {
        if (IsPlayerConnected(i) && (PlayerInfo[i][pTest] == 1 || PlayerInfo[i][pAdmin] > 0))
        {
            SendClientMessage(i, 0xF7AEC2FF, reportMessage);
        }
    }
    
    return 1;
}

CMD:intron(playerid, params[])
{
    new song;
    if (sscanf(params, "i", song))
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /intron [1-8]");
        return CMD_SUCCESS;
    }

    if (song < 1 || song > 8)
    {
        SendClientMessage(playerid, 0xFFFFFFFF, "Използвай: /intron [1-8]");
        return CMD_SUCCESS;
    }

    introon[playerid] = 1;

    switch(song)
    {
        case 1:
            PlayAudioStreamForPlayer(playerid, "http://k003.kiwi6.com/hotlink/rpxqi09ojz/Coolio_-_Gangsta_Paradise.mp3");
        
        case 2:
            PlayAudioStreamForPlayer(playerid, "http://k003.kiwi6.com/hotlink/zpk5k464m4/50_Cent_-_Candy_Shop_ft._Olivia-_AudioTrimmer.com_.mp3");
        
        case 3:
            PlayAudioStreamForPlayer(playerid, "http://k003.kiwi6.com/hotlink/7bv42eb2nz/Chamillionaire_-_Ridin_ft._Krayzie_Bone-_AudioTrimmer.com_.mp3");
        
        case 4:
            PlayAudioStreamForPlayer(playerid, "http://k003.kiwi6.com/hotlink/ogmzy9sjat/Eminem_-_Phenomenal_Lyric_Video_-_AudioTrimmer.com_.mp3");
        
        case 5:
            PlayAudioStreamForPlayer(playerid, "http://k003.kiwi6.com/hotlink/8sb17wkrqx/Roy_Jones_Jr._-_Can_t_Be_Touched.mp3");
        
        case 6:
            PlayAudioStreamForPlayer(playerid, "http://k003.kiwi6.com/hotlink/7iyf4xb2fz/Tokyo_Drift_-_Teriyaki_Boyz_MUSIC_VIDEO_HD.mp3");
        
        case 7:
            PlayAudioStreamForPlayer(playerid, "http://k003.kiwi6.com/hotlink/tcmbazycnr/Usher_-_Yeah_ft._Lil_Jon_Ludacris.mp3");
        
        case 8:
            PlayAudioStreamForPlayer(playerid, "http://k003.kiwi6.com/hotlink/vmyupqresi/Wiz_Khalifa_-_Black_And_Yellow_G-Mix_ft._Snoop_Dogg_Juicy_J_and_T-Pain.mp3");
    }

    SendClientMessage(playerid, 0xFFFFFFFF, "Ти пусна песен от интрото!");
    return CMD_SUCCESS;
}

CMD:introff(playerid, params[])
{
    if (introon[playerid] == 0)
    {
        return SendClientMessage(playerid, 0xB4B5B7FF, "Ти не си пуснал песен от интрото!");
    }
    introon[playerid] = 0;
    StopAudioStreamForPlayer(playerid);
    SendClientMessage(playerid, 0xFFFFFFFF, "Ти спря песента от интрото!");
    return 1;
}

CMD:vehelp(playerid, params[])
{
    SendClientMessage(playerid, 0xFFFF00AA, "{FF9900}/eon {FF0000}| {FF9900}/eoff {000000}- {66FF33}Включване {FF0000}| {66FF33}Изключване на двигателя");
    SendClientMessage(playerid, 0xFFFF00AA, "{FF9900}/lon {FF0000}| {FF9900}/loff {000000}- {66FF33}Включване {FF0000}| {66FF33}Изключване на фаровете");
    SendClientMessage(playerid, 0xFFFF00AA, "{FF9900}/aon {FF0000}| {FF9900}/aoff {000000}- {66FF33}Включване {FF0000}| {66FF33}Спиране на алармата");
    SendClientMessage(playerid, 0xFFFF00AA, "{FF9900}/bontetoon {FF0000}| {FF9900}/bontetooff {000000}- {66FF33}Включване {FF0000}| {66FF33}Спиране на предния капак");
    SendClientMessage(playerid, 0xFFFF00AA, "{FF9900}/booton {FF0000}| {FF9900}/bootoff {000000}- {66FF33}Включване {FF0000}| {66FF33}Затваряне на багажника");
    return 1;
}
