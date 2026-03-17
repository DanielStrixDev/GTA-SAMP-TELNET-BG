/*
* Free VIP
*/
stock SaveFreeVIP()
{
    dini_IntSet("scriptfiles/freevip.ini", "freevip", freevip);
    dini_IntSet("scriptfiles/freevip.ini", "day", freevip_end_day);
    dini_IntSet("scriptfiles/freevip.ini", "month", freevip_end_month);
    dini_IntSet("scriptfiles/freevip.ini", "year", freevip_end_year);
}

stock LoadFreeVIP()
{
    if (dini_Exists("scriptfiles/freevip.ini"))
    {
        freevip = dini_Int("scriptfiles/freevip.ini", "freevip");
        freevip_end_day = dini_Int("scriptfiles/freevip.ini", "day");
        freevip_end_month = dini_Int("scriptfiles/freevip.ini", "month");
        freevip_end_year = dini_Int("scriptfiles/freevip.ini", "year");

        printf("[FREE VIP] Безплатният VIP е наличен до %s.%d.%d г.",freevip_end_day, freevip_end_month, freevip_end_year);
    }
    else
    {
        freevip = 0;
    }
}