stock CheckFreeVIP()
{
    if (freevip == 1)
    {
        new y, m, d;
        getdate(y, m, d);

        if ((y > freevip_end_year) ||
            (y == freevip_end_year && m > freevip_end_month) ||
            (y == freevip_end_year && m == freevip_end_month && d >= freevip_end_day))
        {
            return 1;
        }
        return 1;
    }
    return 0;
}