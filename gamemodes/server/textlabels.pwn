#include <YSI_Coding\y_hooks>

/*
* Add All Text Labels
*/
hook OnGameModeInit()
{
    CreateDynamic3DTextLabel("Такса за вход $50\n{FFFF00}/enter", 0x3FBF03AA, 478.2492, -19.3125, 1000.6797, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, -1, -1, -1, 5.0);
    Create3DTextLabel("{FF0000}За да влезеш в бизнеса {FFFFFF}24/7{FF0000} отиди до синята къщичка и напиши {FFFFFF}/enter\n{FF0000}За да излезеш от бизнеса напиши {FFFFFF}/exit{FF0000} до вратата.\n{FF0000}Като влезеш в бизнеса отиди до жълтия удивителен и напиши {FFFFFF}/buy{FF0000} за да видиш какво можеш да си купиш.", 0x08FF08FF, 2181.8801, 1991.3766, 10.8203, 20, 0);
    Create3DTextLabel("{FF0000}За да влезеш в{FFFFFF} бизнеса за шофьорски книжки{FF0000} отиди до синята къщичка и напиши {FFFFFF}/enter\n{FF0000}За да излезеш от бизнеса напиши {FFFFFF}/exit {FF0000}до вратата\nКато влезеш в бизнеса отиди до монитора с въртяща се книжка и \nнапиши {FFFFFF}/dmv{FF0000} за да видиш каква шофьорска книжка може да си вземеш.", 0x08FF08FF, 1933.1718, 2184.6824, 10.8125, 20, 0);
    Create3DTextLabel("{0040FF}Само за Intense Police Department\n{00FF00}Натисни {FF0000}SCROLL{00FF00} за да отвориш портата, ако си пеша.\nНатисни {FF0000}2 (над W){00FF00} за да отвориш портата, ако си с превозно средство. ", 0x08FF08FF, 2336.8582, 2443.3186, 6.1081, 20, 0);
    Create3DTextLabel("{0040FF}Само за Intense Police Department\n{00FF00}Натисни {FF0000}SCROLL{00FF00} за да отвориш бариерата, ако си пеша.\nНатисни {FF0000}2 (над W){00FF00} за да отвориш бариерата, ако си с превозно средство. ", 0x08FF08FF, 2237.7688, 2453.5955, 10.7848, 20, 0);
    Create3DTextLabel("{FF0000}VIP's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", 0xFFFFFFFF, 1230.4954, -2005.5513, 60.8984, 10, 0);
    Create3DTextLabel("San Fierro Triads's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", COLOR_RTRIADS, 1969.2216, 953.4484, 10.8203, 10, 0);
    Create3DTextLabel("Italian Mafia's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", COLOR_RITALIAN, -691.5956, 935.6432, 13.6328, 10, 0);
    Create3DTextLabel("{0040FF}IPD's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", 0xFFFFFFFF, 252.5214, 70.3983, 1003.6406, 10, 1); //ipd gun
    Create3DTextLabel("{33AA33}Grove's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", 0xFFFFFFFF, 2497.0251, -1703.2537, 1014.7422, 10, 1);
    Create3DTextLabel("{276BA9}Syndicate Texas's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", 0xFFFFFFFF, 2497.0251, -1703.2537, 1014.7422, 10, 2);
    Create3DTextLabel("{0080FF}Rifa's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", 0xFFFFFFFF, 2449.6282, -1696.3843, 1013.5078, 10, 1);
    Create3DTextLabel("{FF40FF}Bulgarian Mafia's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", 0xFFFFFFFF, 1267.0983, -784.8137, 1091.9063, 10, 1);
    Create3DTextLabel("Mara Salvatrucha 13's Gun Machine\n{FF4000}Натисни {FFFF00}SCROLL{FF4000} за да си вземеш оръжие", COLOR_RMS13, -38.7398, 1078.9197, 20.2060, 10, 0);
    Create3DTextLabel("{33AA33}Grove Street Families\n{FF4000}Натисни {FFFF00}ENTER{FF4000} за да влезеш", 0xFFFFFFFF, 2495.3496, -1690.8401, 14.7656, 10, 0, 0);
    Create3DTextLabel("{33AA33}Grove Street Families\n{FF4000}Натисни {FFFF00}ENTER{FF4000} за да излезеш", 0xFFFFFFFF, 2496.0054, -1692.1809, 1014.7422, 10, 1, 0); //2496.049804,-1695.238159,1014.742187
    Create3DTextLabel("{FF0000}Напиши {FFFFFF}/plate{FF0000} за да смениш номера на твоята кола", 0xFFFFFFFF, 1838.5139, -1856.2627, 13.3828, 10, 0);
    Create3DTextLabel("{FF0000}Напиши {FFFFFF}/plate{FF0000} за да смениш номера на твоята кола", 0xFFFFFFFF, -1786.8502, 1205.3788, 25.1250, 10, 0);
    Create3DTextLabel("{FF0000}Напиши {FFFFFF}/plate{FF0000} за да смениш номера на твоята кола", 0xFFFFFFFF, 2005.9323, 2298.5537, 10.8203, 10, 0);
    Create3DTextLabel("{FF0000}За да влезете в бизнеса напишете {FFFFFF}/enter", 0xFFFFFFFF, 1942.1660, 2184.6045, 10.8203, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да влезете в бизнеса напишете {FFFFFF}/enter\n{FF0000}Когато искате да излезете от него напишете {FFFFFF}/exit ", 0xFFFFFFFF, 1122.7079, -2037.0201, 69.8942, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 1203.2736, -2011.3766, 85.1735, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 1706.1938, 1448.5729, 10.8181, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 1240.1112, -2038.7124, 61.8419, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 1125.4641, -2029.7620, 75.8093, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 1510.7715, -1607.2186, 15.3986, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 1176.9319, -2037.2865, 69.1413, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 1152.7411, 1342.2012, 10.8203, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да видите правилата на сървъра използвайте командата {FFFFFF}/rules ", 0xFFFFFFFF, 1125.4333, -2044.1055, 75.8093, 20, 0, 0);
    //Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ",0xFFFFFFFF,1538.7894,-1690.8087,13.5469,20,0,0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 1480.1886, -1639.7046, 14.1484, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ", 0xFFFFFFFF, 2115.0881, 962.9519, 15.7348, 20, 0, 0);
    Create3DTextLabel("{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 1347.9866, -1742.0200, 13.3906, 20, 0, 0);
    Create3DTextLabel("{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 1174.8677, -2037.0220, 77.3178, 20, 0, 0);
    Create3DTextLabel("{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 1246.3448, -2052.0242, 64.5867, 20, 0, 0);
    Create3DTextLabel("{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 2097.7795, 963.0507, 15.7348, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да влезете в бизнеса напишете {FFFFFF}/enter ", 0xFFFFFFFF, 2194.6130, 1990.9689, 12.2969, 15, 0, 0);
    //Create3DTextLabel("{FF0000}За да станете VIP потребител и да имате повече команди прочетете {FFFFFF}/viphelp ",0xFFFFFFFF,1481.1449,-1739.6332,13.5469,20,0,0);
    Create3DTextLabel("{FF0000}За да си тунинговате колата влезте вътре и пишете {FFFFFF}/tune ", 0xFFFFFFFF, 1249.7540, -2058.7312, 59.7104, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да си тунинговате колата влезте вътре и пишете {FFFFFF}/tune ", 0xFFFFFFFF, 1248.7421, -2051.7422, 59.7570, 20, 0, 0);
    Create3DTextLabel("{FF0000}{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 1262.4489, -2026.9534, 59.3499, 20, 0, 0);
    Create3DTextLabel("{FF0000}{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 1262.4489, -2026.9534, 59.3499, 20, 0, 0);
    Create3DTextLabel("{FF0000}{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 1538.1416, -1674.9762, 13.5469, 20, 0, 0);
    Create3DTextLabel("{FF0000}{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 2397.0432, 1019.7305, 10.8203, 20, 0, 0);
    Create3DTextLabel("{FF0000}{FF0000}Сайт на сървъра -{FFFFFF} soon\n{FF0000}Форум на сървъра -{FFFFFF} soon", 0xFFFFFFFF, 2005.7382, 1545.0450, 13.5198, 20, 0, 0);
    Create3DTextLabel("{C600C6}Натисни {FFFFFF}ENTER{C600C6} за да преминеш в другия {FFFFFF}Virtual World", 0xFFFFFFFF, -1392.2205, 2111.2021, 42.1264, 20, 0, 0);
    Create3DTextLabel("{C600C6}Натисни {FFFFFF}ENTER{C600C6} за да преминеш в другия {FFFFFF}Virtual World", 0xFFFFFFFF, -1392.2205, 2111.2021, 42.1264, 20, 1, 0);
    Create3DTextLabel("{FF0000}Ако искате да се телепортирате можете да използвате някой от тези телепорти:\n{FFFFFF}/dm /dm2 /ls /lv ", 0xFFFFFFFF, 1240.0763, -2036.8870, 59.9441, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да се качите в колата като шофьор използвайте {FFFFFF}F {FF0000}или {FFFFFF}ENTER\n{FF0000}За да се качите като пътник натиснете {FFFFFF}G\n{FF0000}За да се покажете през прозореца натиснете {FFFFFF}CAPS LOCK{FF0000} или {FFFFFF}H", 0xFFFFFFFF, 1240.4271, -2007.6287, 59.9621, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да се качите в колата като шофьор използвайте {FFFFFF}F {FF0000}или {FFFFFF}ENTER\n{FF0000}За да се качите като пътник натиснете {FFFFFF}G\n{FF0000}За да се покажете през прозореца натиснете {FFFFFF}CAPS LOCK{FF0000} или {FFFFFF}H", 0xFFFFFFFF, 1240.7898, -2049.2617, 59.9841, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да се качите в колата като шофьор използвайте {FFFFFF}F {FF0000}или {FFFFFF}ENTER\n{FF0000}За да се качите като пътник натиснете {FFFFFF}G\n{FF0000}За да се покажете през прозореца натиснете {FFFFFF}CAPS LOCK{FF0000} или {FFFFFF}H", 0xFFFFFFFF, 1279.9983, -2045.3997, 59.1966, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да се качите в колата като шофьор използвайте {FFFFFF}F {FF0000}или {FFFFFF}ENTER\n{FF0000}За да се качите като пътник натиснете {FFFFFF}G\n{FF0000}За да се покажете през прозореца натиснете {FFFFFF}CAPS LOCK{FF0000} или {FFFFFF}H", 0xFFFFFFFF, 1278.9470, -2007.0658, 59.0642, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да пишете в сървъра натиснете {FFFFFF}T {FF0000}или {FFFFFF}~\n{FF0000}За да видите всички команди напишете {FFFFFF}/help", 0xFFFFFFFF, 1203.2736, -2011.3766, 85.1735, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да пишете в сървъра натиснете {FFFFFF}T {FF0000}или {FFFFFF}~\n{FF0000}За да видите всички команди напишете {FFFFFF}/help", 0xFFFFFFFF, 1183.0652, -2011.4884, 85.1735, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да пишете в сървъра натиснете {FFFFFF}T {FF0000}или {FFFFFF}~\n{FF0000}За да видите всички команди напишете {FFFFFF}/help", 0xFFFFFFFF, 1183.2747, -2062.8635, 85.1735, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да пишете в сървъра натиснете {FFFFFF}T {FF0000}или {FFFFFF}~\n{FF0000}За да видите всички команди напишете {FFFFFF}/help", 0xFFFFFFFF, 1204.5096, -2063.1487, 84.7134, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да пишете в сървъра натиснете {FFFFFF}T {FF0000}или {FFFFFF}~\n{FF0000}За да видите всички команди напишете {FFFFFF}/help", 0xFFFFFFFF, 1243.5411, -2044.7922, 75.9834, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да пишете в сървъра натиснете {FFFFFF}T {FF0000}или {FFFFFF}~\n{FF0000}За да видите всички команди напишете {FFFFFF}/help", 0xFFFFFFFF, 1241.7443, -2007.1014, 76.0035, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да пишете в сървъра натиснете {FFFFFF}T {FF0000}или {FFFFFF}~\n{FF0000}За да видите всички команди напишете {FFFFFF}/help", 0xFFFFFFFF, 1280.7434, -2006.4984, 74.9713, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да пишете в сървъра натиснете {FFFFFF}T {FF0000}или {FFFFFF}~\n{FF0000}За да видите всички команди напишете {FFFFFF}/help", 0xFFFFFFFF, 1280.3582, -2041.9338, 75.0235, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да започнеш {FFFFFF}Boat Job {FF0000}влез в някоя от лодките и напиши {FFFFFF}/boat", -1, 2127.8530, -87.0102, 2.1304, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}За да започнеш {FFFFFF}Coalmine Job {FF0000}влез в някой от самосвалите и напиши {FFFFFF}/coalmine", -1, 852.7022, 851.3765, 13.3516, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}За да започнеш {FFFFFF}Pilot Job {FF0000}влез в някой от самолетите и напиши {FFFFFF}/pilot", -1, 402.0841, 2529.5537, 16.5748, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}За да започнеш {FFFFFF}Truck Job {FF0000}влез в някой от камионите и напиши {FFFFFF}/truck", -1, 76.4991, -258.7651, 1.5781, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}За да започнеш {FFFFFF}Bus Job {FF0000}влез в някой от автобусите и напиши {FFFFFF}/bus", -1, -543.4083, 2592.2168, 53.5156, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}За да започнеш {FFFFFF}Pizzaboy Job {FF0000}влез в някой от моторите и напиши {FFFFFF}/pizza", -1, 1363.4863, 249.8157, 19.5669, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}За да започнеш {FFFFFF}Deliver Job {FF0000}влез в някой от камионите и напиши {FFFFFF}/deliver", -1, -15.7992, -316.2803, 5.4229, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}За да вдигате левел трябва да събирате {FFFFFF}EP.\n {FF0000}На всеки кръгъл час има Payday и получавате {FFFFFF}1 EP\n{FF0000}EP можете да събирате от мисиите Moneybox, Streetrace, Deathmatch.\nОт {FFFFFF}/stats{FF0000} може да видите колко EP имате.\nЗа да вдигнете вашия левел напишете {FFFFFF}/buylevel\n{FF0000}За повече информация моля посетете нашия форум!", 0xFFFFFFFF, 1210.2579, -2036.9921, 69.0078, 20, 0, 0);
    Create3DTextLabel("{FFFFFF}Използвай {008000}/tow\n{FF0000}за да закачите кола", -1, 1015.7611, -1025.3098, 32.1016, 20.0, 0, 0);
    Create3DTextLabel("{FFFFFF}Използвай {008000}/tow\n{FF0000}за да закачите кола", -1, 1652.8636, 2200.3342, 12.1981, 20.0, 0, 0);
    Create3DTextLabel("{FFFFFF}Механик\n{FF4000}Напиши {FFFF00}/mduty{FF4000} за да си смениш скина\nИзползвай {FFFF00}/mdutyoff{FF4000} за да го премахнеш", -1, 1015.9524, -1026.5002, 32.1016, 20.0, 0, 0);
    Create3DTextLabel("{FFFFFF}Механик\n{FF4000}Напиши {FFFF00}/mduty{FF4000} за да си смениш скина\nИзползвай {FFFF00}/mdutyoff{FF4000} за да го премахнеш", -1, 1652.8765, 2199.9587, 10.8203, 20.0, 0, 0);
    Create3DTextLabel("{FF0000}Зареди цистерната\n{FFFF00}/refillpt", -1, 264.4190, 1455.0266, 10.5859, 30.0, 0, 0);

    //vip teleports - open
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}Boat Job\n{FF0000}Трябва да си {FFFFFF}8 левел{FF0000} за да работиш тази работа!", -1, 1237.1945, -2004.9026, 59.8630, 40.0, 0, 1);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}мястото за ловене на риба", -1, 1247.4926, -2047.3232, 59.9830, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}Coalmine Job", -1, 1226.9058, -2004.3683, 62.9966, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}бизнеса 24/7", -1, 1213.1379, -2004.4064, 68.9335, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}бизнеса за шофьорски книжки", -1, 1213.1505, -2068.9939, 68.9775, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш във {FFFFFF}VIP базата", -1, -1334.0717, 2061.0530, 52.7941, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш във {FFFFFF}VIP базата", -1, 849.7452, 849.4290, 13.2172, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}Sweeper Job", -1, 1221.8916, -2004.3669, 65.1029, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш във {FFFFFF}VIP базата", -1, 592.5229, 1232.9878, 11.7188, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}Pilot Job", -1, 1216.6649, -2004.4821, 65.1027, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш във {FFFFFF}VIP базата", -1, 396.6920, 2529.6890, 16.5576, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}Truck Job", -1, 1237.1299, -2068.8193, 59.8614, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш във {FFFFFF}VIP базата", -1, 76.3090, -263.6589, 1.5781, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}Bus Job", -1, 1226.6023, -2069.1226, 62.9998, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш във {FFFFFF}VIP базата", -1, -542.4196, 2586.2869, 53.5156, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}Pizzaboy Job", -1, 1232.2550, -2068.9458, 60.8984, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш във {FFFFFF}VIP базата", -1, 1363.7058, 253.9488, 19.5669, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш до {FFFFFF}Deliver Job", -1, 1216.4745, -2069.0505, 65.1019, 40.0, 0, 0);
    Create3DTextLabel("{FF0000}Натисни {FFFFFF}ENTER {FF0000}в стрелката за да се телепортираш във {FFFFFF}VIP базата", -1, -15.7632, -319.8665, 5.4229, 40.0, 0, 0);
    //vip teleports - close

    //fish - open
    Create3DTextLabel("{C600C6}Натисни {FFFFFF}ENTER{C600C6} за да преминеш в другия {FFFFFF}Virtual World", 0xFFFFFFFF, -1392.2205, 2111.2021, 42.1264, 20, 0, 0);
    Create3DTextLabel("{C600C6}Натисни {FFFFFF}ENTER{C600C6} за да преминеш в другия {FFFFFF}Virtual World", 0xFFFFFFFF, -1392.2205, 2111.2021, 42.1264, 20, 1, 0);
    Create3DTextLabel("{C600C6}Напиши {FFFFFF}/buy{C600C6} за да купиш въдица или стръв\n{C600C6}Напиши {FFFFFF}/sellfish{C600C6} за да продадеш рибата\n\nЕдин килограм риба - {00BF00}$10", 0xFFFFFFFF, -1354.0990, 2057.6885, 53.1172, 20, 0, 0);
    Create3DTextLabel("{FF0000}За да почнеш да ловиш риба трябва да си купиш въдица и стръв от бизнеса срещу теб.\nПосле трябва да си до кея или в лодка за да ловиш риба.\nЗа да метнеш въдицата напиши {FFFFFF}/fish{FF0000},а за да видиш твоите риби напиши {FFFFFF}/fish\n{FF0000}За да изхвърлиш риба напиши {FFFFFF}/putback{FF0000}, а за да изхвърлиш всички риби напиши {FFFFFF}/putallback", 0xFFFFFFFF, -1334.7002, 2057.7271, 52.9066, 20, 0, 0);
    //fish - close

    //gas stations texts - location - open
    fuelStationText[0] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 1004.0327, -937.5370, 42.3281, 40, 0, 0);
    fuelStationText[1] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 1942.3719, -1772.8666, 13.6406, 40, 0, 0);
    fuelStationText[2] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, -1606.7223, -2713.3562, 48.5335, 40, 0, 0);
    fuelStationText[3] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, -2026.7813, 156.5509, 29.0391, 40, 0, 0);
    fuelStationText[4] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, -2243.8149, -2559.8899, 31.9219, 40, 0, 0);
    fuelStationText[5] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, -1676.2601, 413.5443, 7.1797, 40, 0, 0);
    fuelStationText[6] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 2201.8296, 2475.1350, 10.8203, 40, 0, 0);
    fuelStationText[7] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 615.3391, 1690.0454, 6.9922, 40, 0, 0);
    fuelStationText[8] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, -1328.2731, 2677.5278, 50.0625, 40, 0, 0);
    fuelStationText[9] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 70.3842, 1219.0177, 18.8116, 40, 0, 0);
    fuelStationText[10] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 2113.3835, 919.5655, 10.8203, 40, 0, 0);
    fuelStationText[11] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 2641.0115, 1106.6252, 10.8203, 40, 0, 0);
    fuelStationText[12] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 2146.7964, 2747.8115, 10.8203, 40, 0, 0);
    fuelStationText[13] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 1595.7935, 2199.5996, 10.8203, 40, 0, 0);
    fuelStationText[14] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, -1471.1836, 1863.7598, 32.6328, 40, 0, 0);
    fuelStationText[15] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 655.7673, -565.0798, 16.3359, 40, 0, 0);
    fuelStationText[16] = Create3DTextLabel("{0040FF}[ Бензиностанция ]\n{FF0000}5000/5000 литра\n{C14124}1 литър {FFFFFF}= {00BF00}1 долар\n{F97804}Напиши {FFFF00}/refuel {F97804}за да заредиш", 0xFFFFFFFF, 1381.8230, 459.1453, 20.3452, 40, 0, 0);
    //gas stations texts - location - close
    Create3DTextLabel("{FF0000}Cell 2\n{FFFFFF}ENTER", 0x08FF08FF, 266.2491, 84.4284, 1001.7091, 6, 1);
    Create3DTextLabel("{FF0000}Cell 1\n{FFFFFF}ENTER", 0x08FF08FF, 266.2492, 88.6102, 1001.7091, 6, 1);
    //3dtextlabels - location - close
    //IFC cars - location - open
    Create3DTextLabel("{FFFF00}Информация:\n{FF0000}Всички превозни средства могат да се закупят за определен играч и за банда.\nКогато го закупите за банда цената е по евтина с 5 лв.\nДо всяко превозно средство са написани цените, които струват за определен играч!\nАко имате идеи за нови превозни средства споделете ги на дискорд {FFFFFF}didkoandreevofficial", 0xFFFFFFFF, -1444.0856, 1087.5129, 1040.7969, 10, 1);
    Create3DTextLabel("{FFFF00}Информация:\n{FF0000}Всички превозни средства могат да се закупят за определен играч и за банда.\nКогато го закупите за банда цената е по евтина с 5 лв.\nДо всяко превозно средство са написани цените, които струват за определен играч!\nАко имате идеи за нови превозни средства споделете ги на дискорд {FFFFFF}didkoandreevofficial", 0xFFFFFFFF, -1444.0856, 1087.5129, 1040.7969, 10, 0);
    Create3DTextLabel("{FF0000}Ако искате да закупите кола пишете на дискорд - {FFFFFF}didkoandreevofficial", 0xFFFFFFFF, 2006.8207, 1167.4012, 10.8203, 10, 0);
    Create3DTextLabel("{FF0000}Ако искате да закупите кола пишете на дискорд - {FFFFFF}didkoandreevofficial", 0xFFFFFFFF, 1411.5128, -1699.5909, 13.5395, 10, 0);
    Create3DTextLabel("{FFFF00}Infernus с тунинг\n{FFFFFF}Цена: {40BF00}20 лв. по касата\n{FF0000}ВНИМАНИЕ: Колата може да е само черна, защото броните са черни!", 0xFFFFFFFF, -1443.0841, 1091.4852, 1040.2311, 20, 0);
    Create3DTextLabel("{FFFF00}Cheetah с полицейски буркан отвътре\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Бурканът свети само когато е тъмно!", 0xFFFFFFFF, -1431.2561, 1097.3242, 1040.2306, 20, 0);
    Create3DTextLabel("{FFFF00}Infernus с полицейски буркан отвътре\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Бурканът свети само когато е тъмно!", 0xFFFFFFFF, -1423.4561, 1099.3093, 1040.2233, 20, 0);
    Create3DTextLabel("{FFFF00}Sultan с Minigun и RPG\n{FFFFFF}Цена: {40BF00}10 лв. по касата\n{FF0000}ВНИМАНИЕ: Minigun-ните и RPG-то НЕ стрелят!", 0xFFFFFFFF, -1415.6876, 1101.0677, 1040.2094, 20, 0);
    Create3DTextLabel("{FFFF00}Patriot с оръдие за ракети\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Оръдието с ракети НЕ стреля!", 0xFFFFFFFF, -1406.2703, 1102.2839, 1040.2030, 20, 0);
    Create3DTextLabel("{FFFF00}DFT-30 с контейнер\n{FFFFFF}Цена: {40BF00}15 лв. по касата\n{FF0000}ВНИМАНИЕ: Вратите на контейнера могат да се отварят и затварят с команда!", 0xFFFFFFFF, -1395.2511, 1103.4880, 1040.1986, 20, 0);
    Create3DTextLabel("{FFFF00}Turismo с огън\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Огъня може да се слага на всяка кола!", 0xFFFFFFFF, -1381.5884, 1101.3951, 1040.1764, 20, 0);
    Create3DTextLabel("{FFFF00}Лимозина с рога\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Рогата може да се слага на всяка кола!", 0xFFFFFFFF, -1369.5228, 1098.7689, 1040.1676, 20, 0);
    Create3DTextLabel("{FFFF00}Infernus с тунинг\n{FFFFFF}Цена: {40BF00}20 лв. по касата\n{FF0000}ВНИМАНИЕ: Колата може да е само черна, защото броните са черни!", 0xFFFFFFFF, -1443.0841, 1091.4852, 1040.2311, 20, 1);
    Create3DTextLabel("{FFFF00}Cheetah с полицейски буркан отвътре\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Бурканът свети само когато е тъмно!", 0xFFFFFFFF, -1431.2561, 1097.3242, 1040.2306, 20, 1);
    Create3DTextLabel("{FFFF00}Infernus с полицейски буркан отвътре\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Бурканът свети само когато е тъмно!", 0xFFFFFFFF, -1423.4561, 1099.3093, 1040.2233, 20, 1);
    Create3DTextLabel("{FFFF00}Sultan с Minigun и RPG\n{FFFFFF}Цена: {40BF00}10 лв. по касата\n{FF0000}ВНИМАНИЕ: Minigun-ните и RPG-то НЕ стрелят!", 0xFFFFFFFF, -1415.6876, 1101.0677, 1040.2094, 20, 1);
    Create3DTextLabel("{FFFF00}Patriot с оръдие за ракети\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Оръдието с ракети НЕ стреля!", 0xFFFFFFFF, -1406.2703, 1102.2839, 1040.2030, 20, 1);
    Create3DTextLabel("{FFFF00}DFT-30 с контейнер\n{FFFFFF}Цена: {40BF00}15 лв. по касата\n{FF0000}ВНИМАНИЕ: Вратите на контейнера могат да се отварят и затварят с команда!", 0xFFFFFFFF, -1395.2511, 1103.4880, 1040.1986, 20, 1);
    Create3DTextLabel("{FFFF00}Turismo с огън\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Огъня може да се слага на всяка кола!", 0xFFFFFFFF, -1381.5884, 1101.3951, 1040.1764, 20, 1);
    Create3DTextLabel("{FFFF00}Лимозина с рога\n{FFFFFF}Цена: {40BF00}7,50 лв. по касата\n{FF0000}ВНИМАНИЕ: Рогата може да се слага на всяка кола!", 0xFFFFFFFF, -1369.5228, 1098.7689, 1040.1676, 20, 1);

    return Y_HOOKS_CONTINUE_RETURN_1;
}