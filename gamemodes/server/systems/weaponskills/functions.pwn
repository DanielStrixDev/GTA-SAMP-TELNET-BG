#include <YSI_Coding\y_hooks>

stock GivePlayerWeaponSkillWeapons(playerid)
{
    switch (PlayerInfo[playerid][pWeaponS])
    {
        case 1:
        {
            GivePlayerWeapon(playerid, 23, 30);
            GivePlayerWeapon(playerid, 25, 50);
            GivePlayerWeapon(playerid, 29, 100);
            GivePlayerWeapon(playerid, 30, 60);
        }
        case 2:
        {
            GivePlayerWeapon(playerid, 23, 50);
            GivePlayerWeapon(playerid, 25, 70);
            GivePlayerWeapon(playerid, 29, 200);
            GivePlayerWeapon(playerid, 30, 100);
        }
        case 3:
        {
            GivePlayerWeapon(playerid, 23, 80);
            GivePlayerWeapon(playerid, 25, 80);
            GivePlayerWeapon(playerid, 29, 250);
            GivePlayerWeapon(playerid, 30, 150);
        }
        case 4:
        {
            GivePlayerWeapon(playerid, 23, 100);
            GivePlayerWeapon(playerid, 25, 100);
            GivePlayerWeapon(playerid, 29, 300);
            GivePlayerWeapon(playerid, 30, 200);
        }
        case 5:
        {
            GivePlayerWeapon(playerid, 22, 80);
            GivePlayerWeapon(playerid, 27, 50);
            GivePlayerWeapon(playerid, 28, 200);
            GivePlayerWeapon(playerid, 31, 70);
            GivePlayerWeapon(playerid, 5, 1);
        }
        case 6:
        {
            GivePlayerWeapon(playerid, 22, 80);
            GivePlayerWeapon(playerid, 27, 70);
            GivePlayerWeapon(playerid, 28, 300);
            GivePlayerWeapon(playerid, 31, 100);
            GivePlayerWeapon(playerid, 33, 20);
            GivePlayerWeapon(playerid, 5, 1);
        }
        case 7:
        {
            GivePlayerWeapon(playerid, 22, 100);
            GivePlayerWeapon(playerid, 27, 100);
            GivePlayerWeapon(playerid, 28, 500);
            GivePlayerWeapon(playerid, 31, 200);
            GivePlayerWeapon(playerid, 33, 40);
            GivePlayerWeapon(playerid, 5, 1);
        }
        case 8:
        {
            GivePlayerWeapon(playerid, 24, 30);
            GivePlayerWeapon(playerid, 26, 50);
            GivePlayerWeapon(playerid, 32, 200);
            GivePlayerWeapon(playerid, 31, 100);
            GivePlayerWeapon(playerid, 34, 30);
            GivePlayerWeapon(playerid, 5, 1);
        }
        case 9:
        {
            GivePlayerWeapon(playerid, 24, 50);
            GivePlayerWeapon(playerid, 26, 80);
            GivePlayerWeapon(playerid, 32, 300);
            GivePlayerWeapon(playerid, 31, 200);
            GivePlayerWeapon(playerid, 34, 40);
            GivePlayerWeapon(playerid, 5, 1);
        }
        case 10:
        {
            GivePlayerWeapon(playerid, 24, 100);
            GivePlayerWeapon(playerid, 26, 100);
            GivePlayerWeapon(playerid, 32, 500);
            GivePlayerWeapon(playerid, 31, 300);
            GivePlayerWeapon(playerid, 34, 50);
            GivePlayerWeapon(playerid, 4, 1);
        }
    }
}