stock CheckExistsCell(table[], id)
{
    new query[128];
new Cache:
    resultCache;
    new result = -1;
    format(query, sizeof(query), "SELECT EXISTS( SELECT 1 from `%s` WHERE id = '%d' LIMIT 1) ", table, id);
    resultCache = mysql_query(MySQL: Database, query);
    cache_get_value_index_int(0, 0, result);
    if (result == 0)
    {
        cache_delete(resultCache);
        return false;
    }
    cache_delete(resultCache);
    return true;
}

stock SQLConnect_FillEmptyTables()
{
    if (CONNECT_SQL_OPERATIONS)
    {
        for (new i = 0; i < MAX_RACES; i++)
        {
            if (!CheckExistsCell("races", i + 1))
            {
                InsertRacesIntoDB(i);
            }
        }
        for (new i = 0; i < MAX_RECORDS; i++)
        {
            if (!CheckExistsCell("records", i + 1))
            {
                InsertRecordsIntoDB(i);
            }
        }
        for (new i = 0; i < MAX_TURFS; i++)
        {
            if (!CheckExistsCell("turfs", i + 1))
            {
                InsertTurfIntoDB(i);
            }
        }

        for (new i = 0; i < MAX_TEAMS; i++)
        {
            if (!CheckExistsCell("factions", i + 1))
            {
                InsertFactionIntoDB(i);
            }
        }

        for (new i = 0; i < MAX_PRIVATEVEHS; i++)
        {
            if (!CheckExistsCell("private_vehicles", i + 1))
            {
                InsertPrivateVehIntoDB(i);
            }
        }

        for (new i = 0; i < MAX_OFFICES; i++)
        {
            if (!CheckExistsCell("offices", i + 1))
            {
                InsertOfficeIntoDB(i);
            }
        }
    }
}

stock SQLConnect_Operations()
{
    if (CONNECT_SQL_OPERATIONS)
    {
        // Creat all tables
        CreateEmptyTable("users");
        CreateEmptyTable("aka");
        CreateEmptyTable("houses");
        CreateEmptyTable("businesses");
        CreateEmptyTable("private_vehicles");
        CreateEmptyTable("turfs");
        CreateEmptyTable("factions");
        CreateEmptyTable("offices");
        CreateEmptyTable("races");
        CreateEmptyTable("records");

        // Records
        AlterTableStr("records", "record_player");
        AlterTableInt("records", "record");

        // Races
        AlterTableStr("races", "winner_name");
        AlterTableInt("races", "finish_time");

        // Offices
        AlterTableInt("offices", "is_owned");
        AlterTableStr("offices", "owner_name");

        // AKA
        AlterTableStr("aka", "player_ip");
        AlterTableStr("aka", "player_nicknames");

        //Users
        AlterTableStr("users", "player_username");         // username

        // --- STRING/VARCHAR Columns ---
        AlterTableStr("users", "password", 115);       // pPassword[115]
        AlterTableStr("users", "fishslot", 100);       // pFishslot[10] - Size adapted
        AlterTableStr("users", "fish_slot_weight", 100); // pFishSlotWeight[10] - Size adapted
        AlterTableStr("users", "reason_mute", 256);    // pReasonMute[256]
        AlterTableStr("users", "ip", 35);              // pIP[35]
        AlterTableStr("users", "clothes", 100);        // pClothes[9] - Size adapted
        AlterTableStr("users", "jail_reason", 256);    // pJailReason (Assumed string based on pReasonMute)
        AlterTableStr("users", "mute_reason", 256);    // pMuteReason (Assumed string based on pReasonMute)

        // --- FLOAT Column ---
        AlterTableFloat("users", "kasa_lv");              // Float:pKasaLV

        // --- INTEGER Columns (All remaining) ---
        AlterTableInt("users", "l_muted");                // pLMuted
        AlterTableInt("users", "a_muted");                // pAMuted
        AlterTableInt("users", "f_muted");                // pFMuted
        AlterTableInt("users", "admin");                  // pAdmin
        AlterTableInt("users", "minigames_timer");        // pMinigamesTimer
        AlterTableInt("users", "minigames");              // pMinigames
        AlterTableInt("users", "derby_possition");        // pDerbyPossition
        AlterTableInt("users", "tog_faction");            // pTogFaction
        AlterTableInt("users", "tog_leader");             // pTogLeader
        AlterTableInt("users", "struv");                  // pStruv
        AlterTableInt("users", "armour2");                // pArmour2
        AlterTableInt("users", "health2");                // pHealth2
        AlterTableInt("users", "hook_t");                 // pHookT
        AlterTableInt("users", "moonshine_effect_time");  // pMoonshineEffectTime
        AlterTableInt("users", "heroin_effect_time");     // pHeroinEffectTime
        AlterTableInt("users", "cocaine_effect_time");    // pCocaineEffectTime
        AlterTableInt("users", "weed_effect_time");       // pWeedEffectTime
        AlterTableInt("users", "refuel_tank_ifc");        // pRefuelTankIFC
        AlterTableInt("users", "tog_cb");                 // pTogCB
        AlterTableInt("users", "ipd_duty");               // pIPDDuty
        AlterTableInt("users", "organisator");            // pOrganisator
        AlterTableInt("users", "chantichki");             // pChantichki
        AlterTableInt("users", "special_force");          // pSpecialForce
        AlterTableInt("users", "delta_force");            // pDeltaForce
        AlterTableInt("users", "helper_leader");          // pHelperLeader
        AlterTableInt("users", "event");                  // pEvent
        AlterTableInt("users", "ifc");                    // pIFC
        AlterTableInt("users", "ifc_duty");               // pIFCDuty
        AlterTableInt("users", "manage");                 // pManage
        AlterTableInt("users", "read_ta");                // pReadTA
        AlterTableInt("users", "dice");                   // pDice
        AlterTableInt("users", "reaction_tests_won");     // pReactionTestsWon
        AlterTableInt("users", "cigarettes");             // pCigarettes
        AlterTableInt("users", "dmon_kills2");            // pDMONKills2
        AlterTableInt("users", "briefcase");              // pBriefcase
        AlterTableInt("users", "fuelcase");               // pFuelcase
        AlterTableInt("users", "radio");                  // pRadio
        AlterTableInt("users", "number_accs");            // pNumberAccs
        AlterTableInt("users", "admin_mute");             // pADMINMute
        AlterTableInt("users", "biz_ep");                 // pBizEP
        AlterTableInt("users", "biz_cash");               // pBizCash
        AlterTableInt("users", "samolet");                // pSamolet
        AlterTableInt("users", "vlak");                   // pVlak
        AlterTableInt("users", "duel_count_timer");       // pDuelCountTimer
        AlterTableInt("users", "duel_count_timer2");      // pDuelCountTimer2
        AlterTableInt("users", "duel_count_timer3");      // pDuelCountTimer3
        AlterTableInt("users", "duel_count_timer4");      // pDuelCountTimer4
        AlterTableInt("users", "invisible");              // pInvisible
        AlterTableInt("users", "helikopter");             // pHelikopter
        AlterTableInt("users", "g_leader");               // pGLeader
        AlterTableInt("users", "lodka");                  // pLodka
        AlterTableInt("users", "dmon_kills");             // pDMONKills
        AlterTableInt("users", "moonshine");              // pMoonshine
        AlterTableInt("users", "moonshine1");             // pMoonshine1
        AlterTableInt("users", "weed1");                  // pWeed1
        AlterTableInt("users", "cocaine1");               // pCocaine1
        AlterTableInt("users", "heroin1");                // pHeroin1
        AlterTableInt("users", "hook");                   // pHook
        AlterTableInt("users", "style");                  // pStyle
        AlterTableInt("users", "weed");                   // pWeed
        AlterTableInt("users", "heroin");                 // pHeroin
        AlterTableInt("users", "cocaine");                // pCocaine
        AlterTableInt("users", "rnmute");                 // pRNMute
        AlterTableInt("users", "job");                    // pJob
        AlterTableInt("users", "awarns");                 // pAWarns
        AlterTableInt("users", "advert_time");            // pAdvertTime
        AlterTableInt("users", "robber");                 // pRobber
        AlterTableInt("users", "robber_lead");            // pRobberLead
        AlterTableInt("users", "moneybox_success");       // pMoneyboxSuccess
        AlterTableInt("users", "vip_label");              // pVIPLabel
        AlterTableInt("users", "street_race_success");    // pStreetRaceSuccess
        AlterTableInt("users", "deathmatch_success");     // pDeathmatchSuccess
        AlterTableInt("users", "cmn1");                   // pCMN1
        AlterTableInt("users", "parrot");                 // pParrot
        AlterTableInt("users", "refuel_can");             // pRefuelCan
        AlterTableInt("users", "refuel_tube");            // pRefuelTube
        AlterTableInt("users", "biz_o");                  // pBizO
        AlterTableInt("users", "spawn_o");                // pSpawnO
        AlterTableInt("users", "none");                   // pNone
        AlterTableInt("users", "no");                     // pNo
        AlterTableInt("users", "pizza_timer_work_again"); // pPizzaTimerWorkAgain
        AlterTableInt("users", "boat_timer_work_again");  // pBoatTimerWorkAgain
        AlterTableInt("users", "coalmine_timer_work_again"); // pCoalmineTimerWorkAgain
        AlterTableInt("users", "sweeper_timer_work_again"); // pSweeperTimerWorkAgain
        AlterTableInt("users", "pilot_timer_work_again"); // pPilotTimerWorkAgain
        AlterTableInt("users", "deliver_timer_work_again"); // pDeliverTimerWorkAgain
        AlterTableInt("users", "bus_timer_work_again");   // pBusTimerWorkAgain
        AlterTableInt("users", "truck_timer_work_again"); // pTruckTimerWorkAgain
        AlterTableInt("users", "infinite_nos");           // pInfiniteNos
        AlterTableInt("users", "yes");                    // pYes
        AlterTableInt("users", "office");                 // pOffice
        AlterTableInt("users", "a_duty");                 // pADuty
        AlterTableInt("users", "a_skin");                 // pASkin
        AlterTableInt("users", "test");                   // pTest
        AlterTableInt("users", "vip");                    // pVip
        AlterTableInt("users", "kills");                  // pKills
        AlterTableInt("users", "deaths");                 // pDeaths
        AlterTableInt("users", "warns");                  // pWarns
        AlterTableInt("users", "time_mute");              // pTimeMute
        AlterTableInt("users", "time_jail");              // pTimeJail
        AlterTableInt("users", "tspec");                  // pTSpec
        AlterTableInt("users", "t_goto");                 // pTGoto
        AlterTableInt("users", "team");                   // pTeam
        AlterTableInt("users", "rank");                   // pRank
        AlterTableInt("users", "level");                  // pLevel
        AlterTableInt("users", "ep");                     // pEP
        AlterTableInt("users", "eps");                    // pEPS
        AlterTableInt("users", "ms");                     // pMS
        AlterTableInt("users", "cash");                   // pCash
        AlterTableInt("users", "bspec");                  // pBSpec
        AlterTableInt("users", "jail");                   // pJail
        AlterTableInt("users", "last_payday");            // pLastPayday
        AlterTableInt("users", "a_hide");                 // pAHide
        AlterTableInt("users", "weapon_s");               // pWeaponS
        AlterTableInt("users", "house_o");                // pHouseO
        AlterTableInt("users", "muted");                  // pMuted
        AlterTableInt("users", "f_warns");                // pFWarns
        AlterTableInt("users", "year");                   // pYear
        AlterTableInt("users", "month");                  // pMonth
        AlterTableInt("users", "day");                    // pDay
        AlterTableInt("users", "hours");                  // pHours
        AlterTableInt("users", "minutes");                // pMinutes
        AlterTableInt("users", "seconds");                // pSeconds
        AlterTableInt("users", "afk");                    // pAFK
        AlterTableInt("users", "active_check");           // pActiveCheck
        AlterTableInt("users", "account");                // pAccount
        AlterTableInt("users", "laser");                  // pLaser
        AlterTableInt("users", "wanted");                 // pWanted
        AlterTableInt("users", "pjail");                  // pPJail
        AlterTableInt("users", "gsm");                    // pGSM
        AlterTableInt("users", "tog_pm");                 // pTogPM
        AlterTableInt("users", "ignore_pm");              // pIgnorePM
        AlterTableInt("users", "last_pm");                // pLastPM
        AlterTableInt("users", "ban");                    // pBan
        AlterTableInt("users", "coming_ban");             // pComingBan
        AlterTableInt("users", "player_refuel_timer");    // pPlayerRefuelTimer
        AlterTableInt("users", "block");                  // pBlock
        AlterTableInt("users", "fix_t");                  // pFixT
        AlterTableInt("users", "heal_t");                 // pHealT
        AlterTableInt("users", "hide_dmon_kill_text");    // pHideDMONKillText
        AlterTableInt("users", "vguns");                  // pVGuns

        // Factions
        AlterTableStr("factions", "rank_name1");
        AlterTableStr("factions", "rank_name2");
        AlterTableStr("factions", "rank_name3");
        AlterTableStr("factions", "rank_name4");
        AlterTableStr("factions", "rank_name5");
        AlterTableStr("factions", "rank_name6");
        AlterTableInt("factions", "turf_owner");
        AlterTableInt("factions", "turf_attack_time");

        // Houses
        AlterTableFloat("houses", "x");          // hX
        AlterTableFloat("houses", "y");          // hY
        AlterTableFloat("houses", "z");          // hZ
        AlterTableFloat("houses", "cx");         // hcX
        AlterTableFloat("houses", "cy");         // hcY
        AlterTableFloat("houses", "cz");         // hcZ
        AlterTableFloat("houses", "ca");         // hcA
        AlterTableInt("houses", "cc");           // hcC
        AlterTableInt("houses", "c_c2");         // hcC2
        AlterTableInt("houses", "cv");           // hcV
        AlterTableInt("houses", "c_veh");        // hcVeh
        AlterTableInt("houses", "owner");        // hOwner
        AlterTableInt("houses", "locked");       // hLocked
        AlterTableInt("houses", "veh");          // hVeh
        AlterTableInt("houses", "level");        // hLevel
        AlterTableInt("houses", "price");        // hPrice
        AlterTableInt("houses", "interior");     // hInterior
        AlterTableInt("houses", "armour");       // hArmour
        AlterTableInt("houses", "health");       // hHealth
        AlterTableStr("houses", "owner_name", 256); // hOwnerName[256]

        //Biz
        AlterTableFloat("businesses", "x");         // bX
        AlterTableFloat("businesses", "y");         // bY
        AlterTableFloat("businesses", "z");         // bZ
        AlterTableFloat("businesses", "pay_out");   // bPayOut
        AlterTableInt("businesses", "owner");       // bOwner
        AlterTableInt("businesses", "locked");      // bLocked
        AlterTableInt("businesses", "ep");          // bEP
        AlterTableInt("businesses", "level");       // bLevel
        AlterTableInt("businesses", "ep_skill");    // bEPSkill
        AlterTableInt("businesses", "ms_skill");    // bMSkill
        AlterTableInt("businesses", "earnings");    // bEarnings
        AlterTableInt("businesses", "fee");         // bFee
        AlterTableInt("businesses", "price");       // bPrice
        AlterTableInt("businesses", "type");        // bType
        AlterTableStr("businesses", "text_3d", 256); // bText (Assuming string data storage)
        AlterTableStr("businesses", "owner_name", 256); // bOwnerName[256]
        AlterTableStr("businesses", "name", 256);       // bName[256]

        //Vehicles
        AlterTableInt("private_vehicles", "v_id");                   // vID
        AlterTableInt("private_vehicles", "c1");                   // vC1
        AlterTableInt("private_vehicles", "c2");                   // vC2
        AlterTableInt("private_vehicles", "respawn_time");         // vRespawnTime
        AlterTableFloat("private_vehicles", "x");                    // vX
        AlterTableFloat("private_vehicles", "y");                    // vY
        AlterTableFloat("private_vehicles", "z");                    // vZ
        AlterTableFloat("private_vehicles", "angle");                // vAngle
        AlterTableStr("private_vehicles", "owner", 256);                // vOwner

        //Turfs
        AlterTableInt("turfs", "turf_owner");   // TurfOwner

        // Data
        SQLConnect_FillEmptyTables();
    }
}

/*
* Load Database
*/
stock LoadDatabaseInformation()
{
    LoadRecords();
    LoadTurfs();
    LoadPrivateVehicles();
    LoadOfficeCenter();
    LoadStreetRaces();
    LoadFactions();
    LoadHouses();
    LoadBizz();
    LoadFreeVIP();
}