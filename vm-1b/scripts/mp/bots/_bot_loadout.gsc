#using scripts/mp/bots/_bot;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/array_shared;
#using scripts/shared/rank_shared;

#namespace bot_loadout;

// Namespace bot_loadout
// Params 0, eflags: 0x0
// Checksum 0x36331d28, Offset: 0x4e0
// Size: 0x92
function function_59ea1bbf() {
    level.var_bcb0659a = array("KILLSTREAK_RCBOMB", "KILLSTREAK_SUPPLY_DROP", "KILLSTREAK_MICROWAVE_TURRET", "KILLSTREAK_REMOTE_MISSILE", "KILLSTREAK_PLANEMORTAR", "KILLSTREAK_AUTO_TURRET", "KILLSTREAK_AI_TANK_DROP", "KILLSTREAK_HELICOPTER_COMLINK", "KILLSTREAK_EMP", "KILLSTREAK_DRONE_STRIKE", "KILLSTREAK_DART", "KILLSTREAK_COMBAT_ROBOT", "WEAPON_SATCHEL_CHARGE", "WEAPON_PDA_HACK", "WEAPON_TROPHY_SYSTEM");
}

// Namespace bot_loadout
// Params 0, eflags: 0x0
// Checksum 0xa56b4d20, Offset: 0x580
// Size: 0x2db
function function_1e1fb4f2() {
    primaryweapons = self function_5e918b2c(undefined, "primary");
    var_ba82ea28 = self function_5e918b2c(undefined, "secondary");
    var_51556676 = self function_5e918b2c(undefined, "primarygadget");
    var_5656857d = self function_5e918b2c(undefined, "secondarygadget");
    var_441a0b08 = self function_5e918b2c(undefined, "specialty1");
    var_b6217a43 = self function_5e918b2c(undefined, "specialty2");
    var_901effda = self function_5e918b2c(undefined, "specialty3");
    foreach (classname, var_7379401a in level.classmap) {
        if (!issubstr(classname, "custom")) {
            continue;
        }
        classindex = int(classname[classname.size - 1]);
        primaryweapon = array::random(primaryweapons);
        self botclassadditem(classindex, primaryweapon);
        if (randomint(100) < 95) {
            secondaryweapon = array::random(var_ba82ea28);
            self botclassadditem(classindex, secondaryweapon);
        }
        lethal = array::random(var_51556676);
        self botclassadditem(classindex, lethal);
        tactical = array::random(var_5656857d);
        self botclassadditem(classindex, tactical);
        specialty1 = array::random(var_441a0b08);
        self botclassadditem(classindex, specialty1);
        specialty2 = array::random(var_b6217a43);
        self botclassadditem(classindex, specialty2);
        specialty3 = array::random(var_901effda);
        self botclassadditem(classindex, specialty3);
    }
}

// Namespace bot_loadout
// Params 0, eflags: 0x0
// Checksum 0xcd8e080c, Offset: 0x868
// Size: 0x193
function function_ab35326f() {
    self.var_c77c87c9 = [];
    self.var_7b3583d0 = 0;
    foreach (classname, var_7379401a in level.classmap) {
        if (issubstr(classname, "custom")) {
            classindex = int(classname[classname.size - 1]);
        } else {
            continue;
        }
        primary = self getloadoutweapon(classindex, "primary");
        secondary = self getloadoutweapon(classindex, "secondary");
        if (primary == level.weaponnone && secondary == level.weaponnone) {
            continue;
        }
        var_593a2a94 = spawnstruct();
        var_593a2a94.name = classname;
        var_593a2a94.index = classindex;
        var_593a2a94.value = var_7379401a;
        var_593a2a94.primary = primary;
        var_593a2a94.secondary = secondary;
        if (var_593a2a94.secondary.isrocketlauncher) {
            self.var_7b3583d0++;
        }
        self.var_c77c87c9[self.var_c77c87c9.size] = var_593a2a94;
    }
}

// Namespace bot_loadout
// Params 0, eflags: 0x0
// Checksum 0xe5b390b3, Offset: 0xa08
// Size: 0x88
function function_bef7ccf4() {
    var_9dff2bc0 = self.pers["class"];
    if (!isdefined(var_9dff2bc0)) {
        return undefined;
    }
    foreach (var_593a2a94 in self.var_c77c87c9) {
        if (var_593a2a94.value == var_9dff2bc0) {
            return var_593a2a94;
        }
    }
    return undefined;
}

// Namespace bot_loadout
// Params 0, eflags: 0x0
// Checksum 0xa5834d9d, Offset: 0xa98
// Size: 0x52
function function_ad0db880() {
    var_d8dfa09c = self getheroweaponname();
    var_86a740f0 = self get_item_name(var_d8dfa09c);
    self botclassadditem(0, var_86a740f0);
}

// Namespace bot_loadout
// Params 0, eflags: 0x0
// Checksum 0xba2f10ce, Offset: 0xaf8
// Size: 0x71
function function_2169b982() {
    killstreaks = array::randomize(self function_5e918b2c("killstreak"));
    for (i = 0; i < 3 && i < killstreaks.size; i++) {
        self botclassadditem(0, killstreaks[i]);
    }
}

// Namespace bot_loadout
// Params 2, eflags: 0x0
// Checksum 0xbf8e2903, Offset: 0xb78
// Size: 0x1c3
function function_5e918b2c(var_8dea34c0, var_73e2eb57) {
    items = [];
    for (i = 0; i < 256; i++) {
        row = tablelookuprownum(level.var_f543dad1, 0, i);
        if (row < 0) {
            continue;
        }
        name = tablelookupcolumnforrow(level.var_f543dad1, row, 3);
        if (name == "" || array::contains(level.var_bcb0659a, name)) {
            continue;
        }
        allocation = int(tablelookupcolumnforrow(level.var_f543dad1, row, 12));
        if (allocation < 0) {
            continue;
        }
        number = int(tablelookupcolumnforrow(level.var_f543dad1, row, 0));
        if (self isitemlocked(number)) {
            continue;
        }
        if (isdefined(var_8dea34c0)) {
            group = tablelookupcolumnforrow(level.var_f543dad1, row, 2);
            if (group != var_8dea34c0) {
                continue;
            }
        }
        if (isdefined(var_73e2eb57)) {
            slot = tablelookupcolumnforrow(level.var_f543dad1, row, 13);
            if (slot != var_73e2eb57) {
                continue;
            }
        }
        items[items.size] = name;
    }
    return items;
}

// Namespace bot_loadout
// Params 1, eflags: 0x0
// Checksum 0x1b69c228, Offset: 0xd48
// Size: 0xae
function get_item_name(var_cf9f6a1f) {
    for (i = 0; i < 256; i++) {
        row = tablelookuprownum(level.var_f543dad1, 0, i);
        if (row < 0) {
            continue;
        }
        reference = tablelookupcolumnforrow(level.var_f543dad1, row, 4);
        if (reference != var_cf9f6a1f) {
            continue;
        }
        name = tablelookupcolumnforrow(level.var_f543dad1, row, 3);
        return name;
    }
    return undefined;
}

// Namespace bot_loadout
// Params 0, eflags: 0x0
// Checksum 0x7d0c3d68, Offset: 0xe00
// Size: 0x8d
function init() {
    level endon(#"game_ended");
    level.var_aec3d3b3 = array("KILLSTREAK_RCBOMB", "KILLSTREAK_QRDRONE", "KILLSTREAK_REMOTE_MISSILE", "KILLSTREAK_REMOTE_MORTAR", "KILLSTREAK_HELICOPTER_GUNNER");
    for (;;) {
        level waittill(#"connected", player);
        if (!player istestclient()) {
            continue;
        }
        player thread on_bot_connect();
    }
}

// Namespace bot_loadout
// Params 0, eflags: 0x0
// Checksum 0x4150c6e8, Offset: 0xe98
// Size: 0x203
function on_bot_connect() {
    self endon(#"disconnect");
    if (isdefined(self.pers["bot_loadout"])) {
        return;
    }
    wait 0.1;
    if (self getentitynumber() % 2 == 0) {
        wait 0.05;
    }
    self bot::set_rank();
    self botsetrandomcharactercustomization();
    if (level.onlinegame && !sessionmodeisprivate()) {
        self botsetdefaultclass(5, "class_assault");
        self botsetdefaultclass(6, "class_smg");
        self botsetdefaultclass(7, "class_lmg");
        self botsetdefaultclass(8, "class_cqb");
        self botsetdefaultclass(9, "class_sniper");
    } else {
        self botsetdefaultclass(5, "class_assault");
        self botsetdefaultclass(6, "class_smg");
        self botsetdefaultclass(7, "class_lmg");
        self botsetdefaultclass(8, "class_cqb");
        self botsetdefaultclass(9, "class_sniper");
    }
    max_allocation = 10;
    for (i = 1; i <= 3; i++) {
        if (self isitemlocked(rank::getitemindex("feature_allocation_slot_" + i))) {
            max_allocation--;
        }
    }
    self function_d4feb729(max_allocation);
    self.pers["bot_loadout"] = 1;
}

// Namespace bot_loadout
// Params 1, eflags: 0x0
// Checksum 0xb8f5d4e4, Offset: 0x10a8
// Size: 0x1a2
function function_d4feb729(var_35d85094) {
    if (self isitemlocked(rank::getitemindex("feature_cac"))) {
        return;
    }
    pixbeginevent("bot_construct_loadout");
    item_list = function_573d1306();
    function_dd28d63d(0, item_list, var_35d85094);
    function_dd28d63d(1, item_list, var_35d85094);
    function_dd28d63d(2, item_list, var_35d85094);
    function_dd28d63d(3, item_list, var_35d85094);
    function_dd28d63d(4, item_list, var_35d85094);
    killstreaks = item_list["killstreak1"];
    if (isdefined(item_list["killstreak2"])) {
        killstreaks = arraycombine(killstreaks, item_list["killstreak2"], 1, 0);
    }
    if (isdefined(item_list["killstreak3"])) {
        killstreaks = arraycombine(killstreaks, item_list["killstreak3"], 1, 0);
    }
    if (isdefined(killstreaks) && killstreaks.size) {
        function_78f4927d(0, killstreaks);
        function_78f4927d(0, killstreaks);
        function_78f4927d(0, killstreaks);
    }
    self.var_7ab7c7bd = undefined;
    pixendevent();
}

// Namespace bot_loadout
// Params 3, eflags: 0x0
// Checksum 0x38f30f6c, Offset: 0x1258
// Size: 0xb2
function function_dd28d63d(var_95b17b00, items, var_35d85094) {
    allocation = 0;
    var_a5ec04bc = function_966b5b74(items);
    self.var_7ab7c7bd = [];
    weapon = function_78f4927d(var_95b17b00, items["primary"]);
    var_a5ec04bc["primary"]++;
    allocation++;
    weapon = function_78f4927d(var_95b17b00, items["secondary"]);
    function_8952de8b(var_95b17b00, "camo", 1);
}

// Namespace bot_loadout
// Params 3, eflags: 0x0
// Checksum 0xe71987b6, Offset: 0x1318
// Size: 0x34
function function_45e42b6f(chance, claimed, var_5095dccc) {
    return claimed < var_5095dccc && randomint(100) < chance;
}

// Namespace bot_loadout
// Params 8, eflags: 0x0
// Checksum 0xa14ef026, Offset: 0x1358
// Size: 0x139
function function_312d0d00(action1, var_d7be317e, var_3e34d2bf, var_b1bbb715, var_18325856, var_8bb93cac, var_5a25f449, var_65b6c243) {
    var_d7be317e = int(var_d7be317e / 10);
    var_b1bbb715 = int(var_b1bbb715 / 10);
    var_8bb93cac = int(var_8bb93cac / 10);
    var_65b6c243 = int(var_65b6c243 / 10);
    actions = [];
    for (i = 0; i < var_d7be317e; i++) {
        actions[actions.size] = action1;
    }
    for (i = 0; i < var_b1bbb715; i++) {
        actions[actions.size] = var_3e34d2bf;
    }
    for (i = 0; i < var_8bb93cac; i++) {
        actions[actions.size] = var_18325856;
    }
    for (i = 0; i < var_65b6c243; i++) {
        actions[actions.size] = var_5a25f449;
    }
    return array::random(actions);
}

// Namespace bot_loadout
// Params 1, eflags: 0x0
// Checksum 0xeed56630, Offset: 0x14a0
// Size: 0x66
function function_efb47dd9(item) {
    foreach (claim in self.var_7ab7c7bd) {
        if (claim == item) {
            return true;
        }
    }
    return false;
}

// Namespace bot_loadout
// Params 2, eflags: 0x0
// Checksum 0xd4f391d, Offset: 0x1510
// Size: 0xb4
function function_78f4927d(weaponclass, items) {
    if (!isdefined(items) || !items.size) {
        return undefined;
    }
    start = randomint(items.size);
    for (i = 0; i < items.size; i++) {
        weapon = items[start];
        if (!function_efb47dd9(weapon)) {
            break;
        }
        start = (start + 1) % items.size;
    }
    self.var_7ab7c7bd[self.var_7ab7c7bd.size] = weapon;
    self botclassadditem(weaponclass, weapon);
    return weapon;
}

// Namespace bot_loadout
// Params 1, eflags: 0x0
// Checksum 0x17244fe1, Offset: 0x15d0
// Size: 0xfb
function function_188bc0d0(optiontype) {
    level.var_4a271a01[optiontype] = [];
    level.var_3e2e90a7[optiontype] = [];
    csv_filename = "gamedata/weapons/common/attachmentTable.csv";
    var_fdb208e4 = 0;
    for (row = 0; row < -1; row++) {
        if (tablelookupcolumnforrow(csv_filename, row, 1) == optiontype) {
            index = level.var_4a271a01[optiontype].size;
            level.var_4a271a01[optiontype][index] = int(tablelookupcolumnforrow(csv_filename, row, 0));
            var_fdb208e4 += int(tablelookupcolumnforrow(csv_filename, row, 15));
            level.var_3e2e90a7[optiontype][index] = var_fdb208e4;
        }
    }
}

// Namespace bot_loadout
// Params 3, eflags: 0x0
// Checksum 0x8f891d9c, Offset: 0x16d8
// Size: 0x173
function function_8952de8b(weaponclass, optiontype, primary) {
    if (!isdefined(level.var_4a271a01)) {
        level.var_4a271a01 = [];
        level.var_3e2e90a7 = [];
        function_188bc0d0("camo");
        function_188bc0d0("reticle");
    }
    if (!level.onlinegame && !level.systemlink) {
        return;
    }
    var_708ceb07 = level.var_3e2e90a7[optiontype].size;
    var_fd3c94fc = level.var_3e2e90a7[optiontype][var_708ceb07 - 1];
    if (!level.systemlink && self.pers["rank"] < 20) {
        var_fd3c94fc += 4 * var_fd3c94fc * (20 - self.pers["rank"]) / 20;
    }
    rnd = randomint(int(var_fd3c94fc));
    for (i = 0; i < var_708ceb07; i++) {
        if (level.var_3e2e90a7[optiontype][i] > rnd) {
            self botclasssetweaponoption(weaponclass, primary, optiontype, level.var_4a271a01[optiontype][i]);
            break;
        }
    }
}

// Namespace bot_loadout
// Params 4, eflags: 0x0
// Checksum 0xe01a9158, Offset: 0x1858
// Size: 0x2ae
function function_1cbb4eae(weaponclass, weapon, allocation, var_35d85094) {
    attachments = weapon.supportedattachments;
    remaining = var_35d85094 - allocation;
    if (!attachments.size || !remaining) {
        return 0;
    }
    var_57e9502f = function_312d0d00("3_attachments", 25, "2_attachments", 35, "1_attachments", 35, "none", 5);
    if (remaining >= 4 && var_57e9502f == "3_attachments") {
        a1 = array::random(attachments);
        self botclassaddattachment(weaponclass, weapon, a1, "primaryattachment1");
        count = 1;
        attachments = getweaponattachments(weapon, a1);
        if (attachments.size) {
            a2 = array::random(attachments);
            self botclassaddattachment(weaponclass, weapon, a2, "primaryattachment2");
            count++;
            attachments = getweaponattachments(weapon, a1, a2);
            if (attachments.size) {
                a3 = array::random(attachments);
                self botclassadditem(weaponclass, "BONUSCARD_PRIMARY_GUNFIGHTER");
                self botclassaddattachment(weaponclass, weapon, a3, "primaryattachment3");
                return 4;
            }
        }
        return count;
    } else if (remaining >= 2 && var_57e9502f == "2_attachments") {
        a1 = array::random(attachments);
        self botclassaddattachment(weaponclass, weapon, a1, "primaryattachment1");
        attachments = getweaponattachments(weapon, a1);
        if (attachments.size) {
            a2 = array::random(attachments);
            self botclassaddattachment(weaponclass, weapon, a2, "primaryattachment2");
            return 2;
        }
        return 1;
    } else if (remaining >= 1 && var_57e9502f == "1_attachments") {
        a = array::random(attachments);
        self botclassaddattachment(weaponclass, weapon, a, "primaryattachment1");
        return 1;
    }
    return 0;
}

// Namespace bot_loadout
// Params 4, eflags: 0x0
// Checksum 0x61699841, Offset: 0x1b10
// Size: 0x1ae
function function_c6cb18fa(weaponclass, weapon, allocation, var_35d85094) {
    attachments = weapon.supportedattachments;
    remaining = var_35d85094 - allocation;
    if (!attachments.size || !remaining) {
        return 0;
    }
    var_57e9502f = function_312d0d00("2_attachments", 10, "1_attachments", 40, "none", 50, "none", 0);
    if (remaining >= 3 && var_57e9502f == "2_attachments") {
        a1 = array::random(attachments);
        self botclassaddattachment(weaponclass, weapon, a1, "secondaryattachment1");
        attachments = getweaponattachments(weapon, a1);
        if (attachments.size) {
            a2 = array::random(attachments);
            self botclassadditem(weaponclass, "BONUSCARD_SECONDARY_GUNFIGHTER");
            self botclassaddattachment(weaponclass, weapon, a2, "secondaryattachment2");
            return 3;
        }
        return 1;
    } else if (remaining >= 1 && var_57e9502f == "1_attachments") {
        a = array::random(attachments);
        self botclassaddattachment(weaponclass, weapon, a, "secondaryattachment1");
        return 1;
    }
    return 0;
}

// Namespace bot_loadout
// Params 0, eflags: 0x0
// Checksum 0x5fd95ae5, Offset: 0x1cc8
// Size: 0x163
function function_573d1306() {
    items = [];
    for (i = 0; i < 256; i++) {
        row = tablelookuprownum(level.var_f543dad1, 0, i);
        if (row > -1) {
            slot = tablelookupcolumnforrow(level.var_f543dad1, row, 13);
            if (slot == "") {
                continue;
            }
            number = int(tablelookupcolumnforrow(level.var_f543dad1, row, 0));
            if (self isitemlocked(number)) {
                continue;
            }
            allocation = int(tablelookupcolumnforrow(level.var_f543dad1, row, 12));
            if (allocation < 0) {
                continue;
            }
            name = tablelookupcolumnforrow(level.var_f543dad1, row, 3);
            if (!isdefined(items[slot])) {
                items[slot] = [];
            }
            items[slot][items[slot].size] = name;
        }
    }
    return items;
}

// Namespace bot_loadout
// Params 2, eflags: 0x0
// Checksum 0x7f779ecf, Offset: 0x1e38
// Size: 0xd2
function function_d59039e2(slot, item) {
    if (item == "WEAPON_KNIFE_BALLISTIC") {
        return true;
    }
    if (getdvarint("tu6_enableDLCWeapons") == 0 && item == "WEAPON_PEACEKEEPER") {
        return true;
    }
    if (slot != "killstreak1" && slot != "killstreak2" && slot != "killstreak3") {
        return false;
    }
    foreach (var_81029d2d in level.var_aec3d3b3) {
        if (item == var_81029d2d) {
            return true;
        }
    }
    return false;
}

// Namespace bot_loadout
// Params 1, eflags: 0x0
// Checksum 0xe8dc4513, Offset: 0x1f18
// Size: 0x87
function function_966b5b74(items) {
    claimed = [];
    keys = getarraykeys(items);
    foreach (key in keys) {
        claimed[key] = 0;
    }
    return claimed;
}

