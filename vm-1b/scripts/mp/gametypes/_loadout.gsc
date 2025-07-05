#using scripts/codescripts/struct;
#using scripts/mp/_armor;
#using scripts/mp/_challenges;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_dev;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_weapons;
#using scripts/mp/killstreaks/_killstreak_weapons;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/teams/_teams;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/dev_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/loadout_shared;
#using scripts/shared/system_shared;
#using scripts/shared/tweakables_shared;
#using scripts/shared/util_shared;
#using scripts/shared/weapons/_weapon_utils;

#namespace loadout;

// Namespace loadout
// Params 0, eflags: 0x2
// Checksum 0x492fb1b7, Offset: 0xc28
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("loadout", &__init__, undefined, undefined);
}

// Namespace loadout
// Params 0, eflags: 0x0
// Checksum 0x3fadaee0, Offset: 0xc60
// Size: 0x42
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_connect);
}

// Namespace loadout
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0xcb0
// Size: 0x2
function on_connect() {
    
}

// Namespace loadout
// Params 0, eflags: 0x0
// Checksum 0xd2e48e0e, Offset: 0xcc0
// Size: 0x6ea
function init() {
    level.classmap["class_smg"] = "CLASS_SMG";
    level.classmap["class_cqb"] = "CLASS_CQB";
    level.classmap["class_assault"] = "CLASS_ASSAULT";
    level.classmap["class_lmg"] = "CLASS_LMG";
    level.classmap["class_sniper"] = "CLASS_SNIPER";
    level.classmap["custom0"] = "CLASS_CUSTOM1";
    level.classmap["custom1"] = "CLASS_CUSTOM2";
    level.classmap["custom2"] = "CLASS_CUSTOM3";
    level.classmap["custom3"] = "CLASS_CUSTOM4";
    level.classmap["custom4"] = "CLASS_CUSTOM5";
    level.classmap["custom5"] = "CLASS_CUSTOM6";
    level.classmap["custom6"] = "CLASS_CUSTOM7";
    level.classmap["custom7"] = "CLASS_CUSTOM8";
    level.classmap["custom8"] = "CLASS_CUSTOM9";
    level.classmap["custom9"] = "CLASS_CUSTOM10";
    level.maxkillstreaks = 4;
    level.maxspecialties = 6;
    level.var_ab2ebd2b = 3;
    level.maxallocation = getgametypesetting("maxAllocation");
    level.loadoutkillstreaksenabled = getgametypesetting("loadoutKillstreaksEnabled");
    if (getdvarint("teamOpsEnabled") == 1) {
        level.loadoutkillstreaksenabled = 1;
    }
    level.weaponbasemeleeheld = getweapon("bare_hands");
    level.prestigenumber = 5;
    level.defaultclass = "CLASS_ASSAULT";
    if (tweakables::gettweakablevalue("weapon", "allowfrag")) {
        level.weapons["frag"] = getweapon("frag_grenade");
    } else {
        level.weapons["frag"] = "";
    }
    if (tweakables::gettweakablevalue("weapon", "allowsmoke")) {
        level.weapons["smoke"] = getweapon("smoke_grenade");
    } else {
        level.weapons["smoke"] = "";
    }
    if (tweakables::gettweakablevalue("weapon", "allowflash")) {
        level.weapons["flash"] = getweapon("flash_grenade");
    } else {
        level.weapons["flash"] = "";
    }
    level.weapons["concussion"] = getweapon("concussion_grenade");
    if (tweakables::gettweakablevalue("weapon", "allowsatchel")) {
        level.weapons["satchel_charge"] = getweapon("satchel_charge");
    } else {
        level.weapons["satchel_charge"] = "";
    }
    if (tweakables::gettweakablevalue("weapon", "allowbetty")) {
        level.weapons["betty"] = getweapon("mine_bouncing_betty");
    } else {
        level.weapons["betty"] = "";
    }
    if (tweakables::gettweakablevalue("weapon", "allowrpgs")) {
        level.weapons["rpg"] = getweapon("rpg");
    } else {
        level.weapons["rpg"] = "";
    }
    create_class_exclusion_list();
    function_cd945d1d();
    load_default_loadout("CLASS_SMG", 10);
    load_default_loadout("CLASS_CQB", 11);
    load_default_loadout("CLASS_ASSAULT", 12);
    load_default_loadout("CLASS_LMG", 13);
    load_default_loadout("CLASS_SNIPER", 14);
    level.primary_weapon_array = [];
    level.side_arm_array = [];
    level.grenade_array = [];
    level.inventory_array = [];
    var_47c38c35 = 99;
    for (i = 0; i < var_47c38c35; i++) {
        if (!isdefined(level.tbl_weaponids[i]) || level.tbl_weaponids[i]["group"] == "") {
            continue;
        }
        if (!isdefined(level.tbl_weaponids[i]) || level.tbl_weaponids[i]["reference"] == "") {
            continue;
        }
        weapon_type = level.tbl_weaponids[i]["group"];
        weapon = level.tbl_weaponids[i]["reference"];
        attachment = level.tbl_weaponids[i]["attachment"];
        weapon_class_register(weapon, weapon_type);
        if (isdefined(attachment) && attachment != "") {
            var_f4eabd6f = strtok(attachment, " ");
            if (isdefined(var_f4eabd6f)) {
                if (var_f4eabd6f.size == 0) {
                    weapon_class_register(weapon + "_" + attachment, weapon_type);
                    continue;
                }
                for (k = 0; k < var_f4eabd6f.size; k++) {
                    weapon_class_register(weapon + "_" + var_f4eabd6f[k], weapon_type);
                }
            }
        }
    }
    callback::on_connecting(&on_player_connecting);
}

// Namespace loadout
// Params 0, eflags: 0x0
// Checksum 0xf84efbe1, Offset: 0x13b8
// Size: 0xc1
function create_class_exclusion_list() {
    currentdvar = 0;
    level.itemexclusions = [];
    while (getdvarint("item_exclusion_" + currentdvar)) {
        level.itemexclusions[currentdvar] = getdvarint("item_exclusion_" + currentdvar);
        currentdvar++;
    }
    level.attachmentexclusions = [];
    for (currentdvar = 0; getdvarstring("attachment_exclusion_" + currentdvar) != ""; currentdvar++) {
        level.attachmentexclusions[currentdvar] = getdvarstring("attachment_exclusion_" + currentdvar);
    }
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0x1b15cf1d, Offset: 0x1488
// Size: 0x4e
function is_attachment_excluded(attachment) {
    numexclusions = level.attachmentexclusions.size;
    for (exclusionindex = 0; exclusionindex < numexclusions; exclusionindex++) {
        if (attachment == level.attachmentexclusions[exclusionindex]) {
            return true;
        }
    }
    return false;
}

// Namespace loadout
// Params 0, eflags: 0x0
// Checksum 0xb416309, Offset: 0x14e0
// Size: 0x3a
function function_2358da67() {
    if (!isdefined(level.var_f543dad1)) {
        var_a804a5cf = util::function_bc37a245();
        level.var_f543dad1 = tablelookupfindcoreasset(var_a804a5cf);
    }
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0x8d4248a5, Offset: 0x1528
// Size: 0x64
function function_5cd00b1b(var_cf9f6a1f) {
    function_2358da67();
    itemcount = int(tablelookup(level.var_f543dad1, 4, var_cf9f6a1f, 5));
    if (itemcount < 1) {
        itemcount = 1;
    }
    return itemcount;
}

// Namespace loadout
// Params 2, eflags: 0x0
// Checksum 0xfecdcae1, Offset: 0x1598
// Size: 0xa6
function function_8428dec1(classname, var_987227b8) {
    var_cf9f6a1f = getdefaultclassslot(classname, var_987227b8);
    function_2358da67();
    itemindex = int(tablelookup(level.var_f543dad1, 4, var_cf9f6a1f, 0));
    if (is_item_excluded(itemindex)) {
        var_cf9f6a1f = tablelookup(level.var_f543dad1, 0, 0, 4);
    }
    return var_cf9f6a1f;
}

// Namespace loadout
// Params 2, eflags: 0x0
// Checksum 0xe712aa39, Offset: 0x1648
// Size: 0x1f
function load_default_loadout(weaponclass, classnum) {
    level.classtoclassnum[weaponclass] = classnum;
}

// Namespace loadout
// Params 2, eflags: 0x0
// Checksum 0x199f29a1, Offset: 0x1670
// Size: 0x13a
function weapon_class_register(weaponname, weapon_type) {
    if (issubstr("weapon_smg weapon_cqb weapon_assault weapon_lmg weapon_sniper weapon_shotgun weapon_launcher weapon_knife weapon_special", weapon_type)) {
        level.primary_weapon_array[getweapon(weaponname)] = 1;
        return;
    }
    if (issubstr("weapon_pistol", weapon_type)) {
        level.side_arm_array[getweapon(weaponname)] = 1;
        return;
    }
    if (weapon_type == "weapon_grenade") {
        level.grenade_array[getweapon(weaponname)] = 1;
        return;
    }
    if (weapon_type == "weapon_explosive") {
        level.inventory_array[getweapon(weaponname)] = 1;
        return;
    }
    if (weapon_type == "weapon_rifle") {
        level.inventory_array[getweapon(weaponname)] = 1;
        return;
    }
    assert(0, "<dev string:x28>" + weapon_type);
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0x2e07056e, Offset: 0x17b8
// Size: 0x35
function function_571ecd1a(weapon) {
    readyvo = weapon.name + "_ready";
    InvalidOpCode(0xc8, "dialog", readyvo, readyvo);
    // Unknown operator (0xc8, t7_1b, PC)
}

// Namespace loadout
// Params 0, eflags: 0x0
// Checksum 0x750bfe51, Offset: 0x1800
// Size: 0x455
function function_cd945d1d() {
    level.tbl_weaponids = [];
    level.var_958170a4 = [];
    function_2358da67();
    for (i = 0; i < 256; i++) {
        var_c04d8f24 = tablelookuprownum(level.var_f543dad1, 0, i);
        if (var_c04d8f24 > -1) {
            group_s = tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 2);
            if (issubstr(group_s, "weapon_") || group_s == "hero") {
                reference_s = tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 4);
                if (reference_s != "") {
                    weapon = getweapon(reference_s);
                    if (weapon.inventorytype == "hero") {
                        level.var_958170a4[reference_s] = [];
                        level.var_958170a4[reference_s]["index"] = i;
                        function_571ecd1a(weapon);
                    }
                    level.tbl_weaponids[i]["reference"] = reference_s;
                    level.tbl_weaponids[i]["group"] = group_s;
                    level.tbl_weaponids[i]["count"] = int(tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 5));
                    level.tbl_weaponids[i]["attachment"] = tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 8);
                }
            }
        }
    }
    level.perknames = [];
    level.perkicons = [];
    level.perkspecialties = [];
    for (i = 0; i < 256; i++) {
        var_c04d8f24 = tablelookuprownum(level.var_f543dad1, 0, i);
        if (var_c04d8f24 > -1) {
            group_s = tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 2);
            if (group_s == "specialty") {
                reference_s = tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 4);
                if (reference_s != "") {
                    perkicon = tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 6);
                    perkname = tablelookupistring(level.var_f543dad1, 0, i, 3);
                    level.perknames[perkicon] = perkname;
                    perk_name = tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 3);
                    level.perkicons[perk_name] = perkicon;
                    level.perkspecialties[perk_name] = reference_s;
                    /#
                        dev::add_perk_devgui(perkname, reference_s);
                    #/
                }
            }
        }
    }
    level.var_41e73a09 = [];
    level.killstreakicons = [];
    level.killstreakindices = [];
    for (i = 0; i < 256; i++) {
        var_c04d8f24 = tablelookuprownum(level.var_f543dad1, 0, i);
        if (var_c04d8f24 > -1) {
            group_s = tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 2);
            if (group_s == "killstreak") {
                reference_s = tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 4);
                if (reference_s != "") {
                    level.tbl_killstreakdata[i] = reference_s;
                    level.killstreakindices[reference_s] = i;
                    icon = tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 6);
                    name = tablelookupistring(level.var_f543dad1, 0, i, 3);
                    level.var_41e73a09[reference_s] = name;
                    level.killstreakicons[reference_s] = icon;
                    level.killstreakindices[reference_s] = i;
                }
            }
        }
    }
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0xe32ac834, Offset: 0x1c60
// Size: 0x2a
function getclasschoice(response) {
    assert(isdefined(level.classmap[response]));
    return level.classmap[response];
}

// Namespace loadout
// Params 2, eflags: 0x0
// Checksum 0xdeb131fe, Offset: 0x1c98
// Size: 0x6a
function function_bb59b4b7(var_7d65157, var_26e2fb26) {
    attachmentstring = getitemattachment(var_7d65157, var_26e2fb26);
    if (attachmentstring != "none" && !is_attachment_excluded(attachmentstring)) {
        attachmentstring += "_";
    } else {
        attachmentstring = "";
    }
    return attachmentstring;
}

// Namespace loadout
// Params 0, eflags: 0x0
// Checksum 0x7eddcc8b, Offset: 0x1d10
// Size: 0x15
function function_5933877() {
    if (!isdefined(level.var_b65167f1)) {
        return 0;
    }
    return level.var_b65167f1;
}

// Namespace loadout
// Params 2, eflags: 0x0
// Checksum 0x4af9d38c, Offset: 0x1d30
// Size: 0x7a
function getkillstreakindex(weaponclass, killstreaknum) {
    killstreaknum++;
    killstreakstring = "killstreak" + killstreaknum;
    if (getdvarint("custom_killstreak_mode") == 2) {
        return getdvarint("custom_" + killstreakstring);
    }
    return self getloadoutitem(weaponclass, killstreakstring);
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0x8106b7b7, Offset: 0x1db8
// Size: 0x3c9
function function_66234473(classnum) {
    self.killstreak = [];
    if (!level.loadoutkillstreaksenabled) {
        return;
    }
    sortedkillstreaks = [];
    currentkillstreak = 0;
    for (killstreaknum = 0; killstreaknum < level.maxkillstreaks; killstreaknum++) {
        killstreakindex = getkillstreakindex(classnum, killstreaknum);
        if (isdefined(killstreakindex) && killstreakindex > 0) {
            assert(isdefined(level.tbl_killstreakdata[killstreakindex]), "<dev string:x5b>" + killstreakindex + "<dev string:x69>");
            if (isdefined(level.tbl_killstreakdata[killstreakindex])) {
                self.killstreak[currentkillstreak] = level.tbl_killstreakdata[killstreakindex];
                if (isdefined(level.usingmomentum) && level.usingmomentum) {
                    killstreaktype = killstreaks::get_by_menu_name(self.killstreak[currentkillstreak]);
                    if (isdefined(killstreaktype)) {
                        weapon = killstreaks::get_killstreak_weapon(killstreaktype);
                        self giveweapon(weapon);
                        if (isdefined(level.usingscorestreaks) && level.usingscorestreaks) {
                            if (weapon.iscarriedkillstreak) {
                                if (!isdefined(self.pers["held_killstreak_ammo_count"][weapon])) {
                                    self.pers["held_killstreak_ammo_count"][weapon] = 0;
                                }
                                if (!isdefined(self.pers["held_killstreak_clip_count"][weapon])) {
                                    self.pers["held_killstreak_clip_count"][weapon] = 0;
                                }
                                if (self.pers["held_killstreak_ammo_count"][weapon] > 0) {
                                    self setweaponammoclip(weapon, self.pers["held_killstreak_clip_count"][weapon]);
                                    self setweaponammostock(weapon, self.pers["held_killstreak_ammo_count"][weapon] - self.pers["held_killstreak_clip_count"][weapon]);
                                } else {
                                    self function_8de272c8(weapon, 0);
                                }
                            } else {
                                quantity = self.pers["killstreak_quantity"][weapon];
                                if (!isdefined(quantity)) {
                                    quantity = 0;
                                }
                                self setweaponammoclip(weapon, quantity);
                            }
                        }
                        sortdata = spawnstruct();
                        sortdata.cost = level.killstreaks[killstreaktype].momentumcost;
                        sortdata.weapon = weapon;
                        sortindex = 0;
                        for (sortindex = 0; sortindex < sortedkillstreaks.size; sortindex++) {
                            if (sortedkillstreaks[sortindex].cost > sortdata.cost) {
                                break;
                            }
                        }
                        for (i = sortedkillstreaks.size; i > sortindex; i--) {
                            sortedkillstreaks[i] = sortedkillstreaks[i - 1];
                        }
                        sortedkillstreaks[sortindex] = sortdata;
                    }
                }
                currentkillstreak++;
            }
        }
    }
    var_511313e9 = [];
    var_511313e9[0] = 4;
    var_511313e9[1] = 2;
    var_511313e9[2] = 1;
    if (isdefined(level.usingmomentum) && level.usingmomentum) {
        for (sortindex = 0; sortindex < sortedkillstreaks.size && sortindex < var_511313e9.size; sortindex++) {
            if (sortedkillstreaks[sortindex].weapon != level.weaponnone) {
                self setactionslot(var_511313e9[sortindex], "weapon", sortedkillstreaks[sortindex].weapon);
            }
        }
    }
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0x58d0a817, Offset: 0x2190
// Size: 0x21
function function_fc32096(perkname) {
    return isdefined(perkname) && isstring(perkname);
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0xda5d67d, Offset: 0x21c0
// Size: 0x12
function reset_specialty_slots(class_num) {
    self.specialty = [];
}

// Namespace loadout
// Params 0, eflags: 0x0
// Checksum 0xb5729c2f, Offset: 0x21e0
// Size: 0xa
function function_1088c9f() {
    self.staticweaponsstarttime = gettime();
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0x8ba662ca, Offset: 0x21f8
// Size: 0x2d
function function_1c374fc1(equipment_name) {
    if (equipment_name == level.weapontacticalinsertion.name && level.disabletacinsert) {
        return false;
    }
    return true;
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0xad90a2fc, Offset: 0x2230
// Size: 0x2b
function function_9afb7ce8(item) {
    if (level.leaguematch) {
        return isitemrestricted(item);
    }
    return 0;
}

// Namespace loadout
// Params 2, eflags: 0x0
// Checksum 0xbfddc93a, Offset: 0x2268
// Size: 0x62
function giveloadoutlevelspecific(team, weaponclass) {
    pixbeginevent("giveLoadoutLevelSpecific");
    if (isdefined(level.givecustomcharacters)) {
        self [[ level.givecustomcharacters ]]();
    }
    if (isdefined(level.givecustomloadout)) {
        self [[ level.givecustomloadout ]]();
    }
    pixendevent();
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0x3e2847cd, Offset: 0x22d8
// Size: 0x7b
function function_79d05183(takeallweapons) {
    if (takeallweapons) {
        self takeallweapons();
    }
    self.specialty = [];
    self.killstreak = [];
    self.var_bf3e36ed = 0;
    self.var_779cc3c1 = 0;
    self.grenadetypeprimary = level.weaponnone;
    self.grenadetypeprimarycount = 0;
    self.grenadetypesecondary = level.weaponnone;
    self.grenadetypesecondarycount = 0;
    self notify(#"give_map");
}

// Namespace loadout
// Params 2, eflags: 0x0
// Checksum 0x4c20b5ea, Offset: 0x2360
// Size: 0x11ea
function giveloadout(team, weaponclass) {
    pixbeginevent("giveLoadout");
    pixbeginevent("giveLoadout 1");
    self function_79d05183(1);
    primaryindex = 0;
    class_num_for_global_weapons = 0;
    primaryweaponoptions = 0;
    secondaryweaponoptions = 0;
    playerrenderoptions = 0;
    primarygrenadecount = 0;
    var_e7b1aca8 = 0;
    if (issubstr(weaponclass, "CLASS_CUSTOM")) {
        pixbeginevent("custom class");
        class_num = int(weaponclass[weaponclass.size - 1]) - 1;
        if (-1 == class_num) {
            class_num = 9;
        }
        self.class_num = class_num;
        self reset_specialty_slots(class_num);
        playerrenderoptions = self calcplayeroptions(class_num);
        class_num_for_global_weapons = class_num;
        var_e7b1aca8 = 1;
        pixendevent();
    } else {
        pixbeginevent("default class");
        assert(isdefined(self.pers["<dev string:x7e>"]), "<dev string:x84>");
        class_num = level.classtoclassnum[weaponclass];
        self.class_num = class_num;
        pixendevent();
    }
    allocationspent = self getloadoutallocation(self.class_num);
    if (allocationspent > level.maxallocation) {
        /#
            iprintlnbold("<dev string:xb2>");
        #/
        kick(self getentitynumber());
    }
    pixendevent();
    pixbeginevent("giveLoadout 2");
    var_bb5ce82a = self calcweaponoptions(class_num, 2);
    self giveweapon(level.weaponbasemelee, var_bb5ce82a);
    self.specialty = self getloadoutperks(class_num);
    self setplayerstateloadoutbonuscards(class_num);
    self setplayerstateloadoutweapons(class_num);
    if (level.leaguematch) {
        for (i = 0; i < self.specialty.size; i++) {
            if (function_9afb7ce8(self.specialty[i])) {
                arrayremoveindex(self.specialty, i);
                i--;
            }
        }
    }
    var_1eb44afc = getdvarint("perk_killstreakAnteUpResetValue");
    var_5cc155e4 = self hasperk("specialty_anteup");
    var_35dd2fa7 = self.pers["anteup_momentum_unused"] === 0;
    var_891d6ad9 = self.pers["momentum"] - (var_5cc155e4 && !var_35dd2fa7 ? var_1eb44afc : 0);
    pixendevent();
    pixbeginevent("giveLoadout 3");
    self register_perks();
    if (level.inprematchperiod && !var_35dd2fa7 && var_891d6ad9 < 400 - var_1eb44afc) {
        var_cfe78620 = self hasperk("specialty_anteup");
        if (var_5cc155e4 && !var_cfe78620) {
            globallogic_score::_setplayermomentum(self, var_891d6ad9, 0);
            self.pers["anteup_momentum_unused"] = undefined;
        } else if (!var_5cc155e4 && var_cfe78620) {
            globallogic_score::_setplayermomentum(self, var_891d6ad9 + var_1eb44afc, 0);
            self.pers["anteup_momentum_unused"] = 1;
        }
    }
    self setactionslot(3, "altMode");
    self setactionslot(4, "");
    function_66234473(class_num_for_global_weapons);
    spawnweapon = level.weaponnull;
    var_1ddab10 = 0;
    if (isdefined(self.pers["weapon"]) && self.pers["weapon"] != level.weaponnone && !self.pers["weapon"].iscarriedkillstreak) {
        primaryweapon = self.pers["weapon"];
    } else {
        primaryweapon = self getloadoutweapon(class_num, "primary");
    }
    if (primaryweapon.iscarriedkillstreak) {
        primaryweapon = level.weaponnull;
    }
    pixendevent();
    pixbeginevent("giveLoadout 4");
    sidearm = self getloadoutweapon(class_num, "secondary");
    if (sidearm.iscarriedkillstreak) {
        sidearm = level.weaponnull;
    }
    self.pers["primaryWeapon"] = primaryweapon;
    if (primaryweapon != level.weaponnull) {
        primaryweaponoptions = self calcweaponoptions(class_num, 0);
        acvi = self getattachmentcosmeticvariantforweapon(class_num, "primary");
        self giveweapon(primaryweapon, primaryweaponoptions, acvi);
        self weapons::function_5be8b6af(primaryweapon, primaryweaponoptions, acvi);
        self.primaryloadoutweapon = primaryweapon;
        self.var_367ea154 = primaryweapon.altweapon;
        if (self hasperk("specialty_extraammo")) {
            self givemaxammo(primaryweapon);
        }
        spawnweapon = primaryweapon;
        var_1ddab10++;
    }
    pixendevent();
    pixbeginevent("giveLoadout 5");
    if (sidearm != level.weaponnull) {
        secondaryweaponoptions = self calcweaponoptions(class_num, 1);
        acvi = self getattachmentcosmeticvariantforweapon(class_num, "secondary");
        self giveweapon(sidearm, secondaryweaponoptions, acvi);
        self.secondaryloadoutweapon = sidearm;
        self.var_f8a642e8 = sidearm.altweapon;
        if (self hasperk("specialty_extraammo")) {
            self givemaxammo(sidearm);
        }
        if (spawnweapon == level.weaponnull) {
            spawnweapon = sidearm;
        }
        var_1ddab10++;
    }
    if (!self hasmaxprimaryweapons()) {
        if (!isusingt7melee()) {
            self giveweapon(level.weaponbasemeleeheld, var_bb5ce82a);
        }
        if (var_1ddab10 == 0) {
            spawnweapon = level.weaponbasemeleeheld;
        }
    }
    pixendevent();
    pixbeginevent("giveLoadout 6");
    if (!isdefined(self.spawnweapon) && isdefined(self.pers["spawnWeapon"])) {
        self.spawnweapon = self.pers["spawnWeapon"];
    }
    if (isdefined(self.spawnweapon) && doesweaponreplacespawnweapon(self.spawnweapon, spawnweapon) && !self.pers["changed_class"]) {
        spawnweapon = self.spawnweapon;
    }
    changedclass = self.pers["changed_class"];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    self.pers["changed_class"] = 0;
    self.spawnweapon = spawnweapon;
    self.pers["spawnWeapon"] = self.spawnweapon;
    self setspawnweapon(spawnweapon);
    primaryoffhand = level.weaponnone;
    primaryoffhandcount = 0;
    secondaryoffhand = level.weaponnone;
    secondaryoffhandcount = 0;
    specialoffhand = level.weaponnone;
    specialoffhandcount = 0;
    if (getdvarint("gadgetEnabled") == 1 || getdvarint("equipmentAsGadgets") == 1) {
        primaryoffhand = self getloadoutweapon(class_num, "primaryGadget");
        primaryoffhandcount = primaryoffhand.startammo;
    } else {
        primaryoffhandname = self getloadoutitemref(class_num, "primarygrenade");
        if (primaryoffhandname != "" && primaryoffhandname != "weapon_null") {
            primaryoffhand = getweapon(primaryoffhand);
            primaryoffhandcount = self getloadoutitem(class_num, "primarygrenadecount");
        }
    }
    if (function_9afb7ce8(primaryoffhand.name) || !function_1c374fc1(primaryoffhand.name)) {
        primaryoffhand = level.weaponnone;
        primaryoffhandcount = 0;
    }
    if (primaryoffhand == level.weaponnone) {
        primaryoffhand = getweapon("null_offhand_primary");
        primaryoffhandcount = 0;
    }
    pixendevent();
    pixbeginevent("giveLoadout 7");
    if (primaryoffhand != level.weaponnull) {
        self giveweapon(primaryoffhand);
        self setweaponammoclip(primaryoffhand, primaryoffhandcount);
        self switchtooffhand(primaryoffhand);
        self.grenadetypeprimary = primaryoffhand;
        self.grenadetypeprimarycount = primaryoffhandcount;
        self ability_util::gadget_reset(primaryoffhand, changedclass, roundbased, firstround);
    }
    if (getdvarint("gadgetEnabled") == 1 || getdvarint("equipmentAsGadgets") == 1) {
        secondaryoffhand = self getloadoutweapon(class_num, "secondaryGadget");
        secondaryoffhandcount = secondaryoffhand.startammo;
    } else {
        secondaryoffhandname = self getloadoutitemref(class_num, "specialgrenade");
        if (secondaryoffhandname != "" && secondaryoffhandname != "weapon_null") {
            secondaryoffhand = getweapon(secondaryoffhand);
            secondaryoffhandcount = self getloadoutitem(class_num, "specialgrenadecount");
        }
    }
    if (function_9afb7ce8(secondaryoffhand.name) || !function_1c374fc1(secondaryoffhand.name)) {
        secondaryoffhand = level.weaponnone;
        secondaryoffhandcount = 0;
    }
    if (secondaryoffhand == level.weaponnone) {
        secondaryoffhand = getweapon("null_offhand_secondary");
        secondaryoffhandcount = 0;
    }
    if (secondaryoffhand != level.weaponnull) {
        self giveweapon(secondaryoffhand);
        self setweaponammoclip(secondaryoffhand, secondaryoffhandcount);
        self switchtooffhand(secondaryoffhand);
        self.grenadetypesecondary = secondaryoffhand;
        self.grenadetypesecondarycount = secondaryoffhandcount;
        self ability_util::gadget_reset(secondaryoffhand, changedclass, roundbased, firstround);
    }
    pixendevent();
    pixbeginevent("giveLoadout 8");
    specialoffhand = self getloadoutweapon(class_num_for_global_weapons, "herogadget");
    specialoffhandcount = specialoffhand.startammo;
    /#
        if (getdvarstring("<dev string:xea>") != "<dev string:x103>") {
            var_c4697642 = getdvarstring("<dev string:xea>");
            specialoffhand = level.weaponnone;
            if (var_c4697642 != "<dev string:x104>") {
                specialoffhand = getweapon(var_c4697642);
            }
        }
    #/
    if (isdefined(self.pers["isBot"]) && self.pers["isBot"]) {
        specialoffhand = level.weaponnull;
        specialoffhandcount = 0;
    }
    if (function_9afb7ce8(specialoffhand.name) || !function_1c374fc1(specialoffhand.name)) {
        specialoffhand = level.weaponnone;
        specialoffhandcount = 0;
    }
    if (specialoffhand == level.weaponnone) {
        specialoffhand = level.weaponnull;
        specialoffhandcount = 0;
    }
    if (specialoffhand != level.weaponnull) {
        self giveweapon(specialoffhand);
        self setweaponammoclip(specialoffhand, specialoffhandcount);
        self switchtooffhand(specialoffhand);
        self.var_66cb8722 = specialoffhand;
        self.var_877b90bf = specialoffhandcount;
        self ability_util::gadget_reset(specialoffhand, changedclass, roundbased, firstround);
    }
    heroweapon = level.weaponnone;
    var_86a740f0 = self getloadoutitemref(class_num_for_global_weapons, "heroWeapon");
    /#
        if (getdvarstring("<dev string:x110>") != "<dev string:x103>") {
            var_86a740f0 = getdvarstring("<dev string:x110>");
        }
    #/
    if (var_86a740f0 != "" && var_86a740f0 != "weapon_null") {
        heroweapon = getweapon(var_86a740f0);
    }
    pixendevent();
    pixbeginevent("giveLoadout 9");
    if (heroweapon != level.weaponnone) {
        self.heroweapon = heroweapon;
        self giveweapon(heroweapon);
        self ability_util::gadget_reset(heroweapon, changedclass, roundbased, firstround);
    }
    self bbclasschoice(class_num, primaryweapon, sidearm);
    pixendevent();
    pixbeginevent("giveLoadout 10");
    for (i = 0; i < 3; i++) {
        if (level.loadoutkillstreaksenabled && isdefined(self.killstreak[i]) && isdefined(level.killstreakindices[self.killstreak[i]])) {
            killstreaks[i] = level.killstreakindices[self.killstreak[i]];
            continue;
        }
        killstreaks[i] = 0;
    }
    self recordloadoutindex(self.class_num);
    pixendevent();
    pixbeginevent("giveLoadout 11");
    self teams::function_37fd0a0f(team, primaryweapon);
    self function_1088c9f();
    self thread initweaponattachments(spawnweapon);
    self setplayerrenderoptions(playerrenderoptions);
    pixendevent();
    pixbeginevent("giveLoadout 12");
    if (isdefined(self.movementspeedmodifier)) {
        self setmovespeedscale(self.movementspeedmodifier * self getmovespeedscale());
    }
    if (isdefined(level.givecustomloadout)) {
        spawnweapon = self [[ level.givecustomloadout ]]();
        if (isdefined(spawnweapon)) {
            self thread initweaponattachments(spawnweapon);
        }
    }
    pixendevent();
    pixbeginevent("giveLoadout 13");
    self cac_selector();
    self function_68857c5f(spawnweapon, primaryweapon);
    pixendevent();
    pixendevent();
}

// Namespace loadout
// Params 2, eflags: 0x0
// Checksum 0x60f99488, Offset: 0x3558
// Size: 0x8a
function function_68857c5f(spawnweapon, primaryweapon) {
    if (!isdefined(self.firstspawn)) {
        if (isdefined(spawnweapon)) {
            self initialweaponraise(spawnweapon);
        } else {
            self initialweaponraise(primaryweapon);
        }
    } else {
        self seteverhadweaponall(1);
    }
    self.firstspawn = 0;
    self.switchedteamsresetgadgets = 0;
    self flagsys::set("loadout_given");
}

// Namespace loadout
// Params 2, eflags: 0x0
// Checksum 0xbb290b20, Offset: 0x35f0
// Size: 0x9a
function function_8de272c8(weapon, amount) {
    if (weapon.iscliponly) {
        self setweaponammoclip(weapon, amount);
        return;
    }
    self setweaponammoclip(weapon, amount);
    diff = amount - self getweaponammoclip(weapon);
    assert(diff >= 0);
    self setweaponammostock(weapon, diff);
}

// Namespace loadout
// Params 0, eflags: 0x0
// Checksum 0x6827c0bb, Offset: 0x3698
// Size: 0x7e
function on_player_connecting() {
    if (!isdefined(self.pers["class"])) {
        self.pers["class"] = "";
    }
    self.curclass = self.pers["class"];
    self.lastclass = "";
    self.detectexplosives = 0;
    self.var_d1c344c9 = [];
    self.var_7d22ed55 = [];
    self.var_6964b90 = [];
    self.var_9f7edcf8 = [];
}

// Namespace loadout
// Params 2, eflags: 0x0
// Checksum 0x279ef632, Offset: 0x3720
// Size: 0x32
function fadeaway(waitdelay, fadedelay) {
    wait waitdelay;
    self fadeovertime(fadedelay);
    self.alpha = 0;
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0x4fc8c2f8, Offset: 0x3760
// Size: 0x12
function setclass(newclass) {
    self.curclass = newclass;
}

// Namespace loadout
// Params 0, eflags: 0x0
// Checksum 0x652d0fc9, Offset: 0x3780
// Size: 0xc2
function initperkdvars() {
    level.cac_armorpiercing_data = getdvarint("perk_armorpiercing", 40) / 100;
    level.cac_bulletdamage_data = getdvarint("perk_bulletDamage", 35);
    level.cac_fireproof_data = getdvarint("perk_fireproof", 20);
    level.cac_armorvest_data = getdvarint("perk_armorVest", 80);
    level.cac_flakjacket_data = getdvarint("perk_flakJacket", 35);
    level.cac_flakjacket_hardcore_data = getdvarint("perk_flakJacket_hardcore", 9);
}

// Namespace loadout
// Params 0, eflags: 0x0
// Checksum 0x6626043, Offset: 0x3850
// Size: 0x61
function cac_selector() {
    perks = self.specialty;
    self.detectexplosives = 0;
    for (i = 0; i < perks.size; i++) {
        perk = perks[i];
        if (perk == "specialty_detectexplosive") {
            self.detectexplosives = 1;
        }
    }
}

// Namespace loadout
// Params 0, eflags: 0x0
// Checksum 0xd3ecb647, Offset: 0x38c0
// Size: 0xba
function register_perks() {
    perks = self.specialty;
    self clearperks();
    for (i = 0; i < perks.size; i++) {
        perk = perks[i];
        if (perk == "specialty_null" || issubstr(perk, "specialty_weapon_") || perk == "weapon_null") {
            continue;
        }
        if (!level.perksenabled) {
            continue;
        }
        self setperk(perk);
    }
    /#
        dev::giveextraperks();
    #/
}

// Namespace loadout
// Params 6, eflags: 0x0
// Checksum 0x4469cd32, Offset: 0x3988
// Size: 0x179
function cac_modified_vehicle_damage(victim, attacker, damage, meansofdeath, weapon, inflictor) {
    if (!isdefined(victim) || !isdefined(attacker) || !isplayer(attacker)) {
        return damage;
    }
    if (!isdefined(damage) || !isdefined(meansofdeath) || !isdefined(weapon)) {
        return damage;
    }
    old_damage = damage;
    final_damage = damage;
    if (attacker hasperk("specialty_bulletdamage") && isprimarydamage(meansofdeath)) {
        final_damage = damage * (100 + level.cac_bulletdamage_data) / 100;
        /#
            if (getdvarint("<dev string:x129>")) {
                println("<dev string:x137>" + attacker.name + "<dev string:x13f>");
            }
        #/
    } else {
        final_damage = old_damage;
    }
    /#
        if (getdvarint("<dev string:x129>")) {
            println("<dev string:x16c>" + final_damage / old_damage + "<dev string:x183>" + old_damage + "<dev string:x193>" + final_damage);
        }
    #/
    return int(final_damage);
}

// Namespace loadout
// Params 7, eflags: 0x0
// Checksum 0xb74f8a0c, Offset: 0x3b10
// Size: 0x55c
function cac_modified_damage(victim, attacker, damage, mod, weapon, inflictor, hitloc) {
    assert(isdefined(victim));
    assert(isdefined(attacker));
    assert(isplayer(victim));
    attacker_is_player = isplayer(attacker);
    if (damage <= 0) {
        return damage;
    }
    /#
        debug = 0;
        if (getdvarint("<dev string:x129>")) {
            debug = 1;
            if (!isdefined(attacker.name)) {
                attacker.name = "<dev string:x1a4>";
            }
        }
    #/
    final_damage = damage;
    if (victim != attacker) {
        if (attacker_is_player && attacker hasperk("specialty_bulletdamage") && isprimarydamage(mod)) {
            if (victim hasperk("specialty_armorvest") && !function_1b2a8c(hitloc)) {
                /#
                    if (debug) {
                        println("<dev string:x137>" + victim.name + "<dev string:x1ac>" + attacker.name + "<dev string:x1c0>");
                    }
                #/
            } else {
                final_damage = damage * (100 + level.cac_bulletdamage_data) / 100;
                /#
                    if (debug) {
                        println("<dev string:x137>" + attacker.name + "<dev string:x1db>" + victim.name);
                    }
                #/
            }
        } else if (victim hasperk("specialty_armorvest") && isprimarydamage(mod) && !function_1b2a8c(hitloc)) {
            final_damage = damage * level.cac_armorvest_data * 0.01;
            /#
                if (debug) {
                    println("<dev string:x137>" + attacker.name + "<dev string:x201>" + victim.name);
                }
            #/
        } else if (victim hasperk("specialty_fireproof") && isfiredamage(weapon, mod)) {
            final_damage = damage * level.cac_fireproof_data * 0.01;
            /#
                if (debug) {
                    println("<dev string:x137>" + attacker.name + "<dev string:x226>" + victim.name);
                }
            #/
        } else if (victim hasperk("specialty_flakjacket") && isexplosivedamage(mod) && !weapon.ignoresflakjacket && !victim function_c44068e7(inflictor)) {
            cac_data = level.hardcoremode ? level.cac_flakjacket_hardcore_data : level.cac_flakjacket_data;
            if (level.teambased && attacker.team != victim.team) {
                victim thread challenges::flakjacketprotected(weapon, attacker);
            } else if (attacker != victim) {
                victim thread challenges::flakjacketprotected(weapon, attacker);
            }
            final_damage = int(damage * cac_data / 100);
            /#
                if (debug) {
                    println("<dev string:x137>" + victim.name + "<dev string:x244>" + attacker.name + "<dev string:x25e>");
                }
            #/
        }
    }
    /#
        victim.cac_debug_damage_type = tolower(mod);
        victim.cac_debug_original_damage = damage;
        victim.cac_debug_final_damage = final_damage;
        victim.cac_debug_location = tolower(hitloc);
        victim.cac_debug_weapon = tolower(weapon.name);
        victim.cac_debug_range = int(distance(attacker.origin, victim.origin));
        if (debug) {
            println("<dev string:x16c>" + final_damage / damage + "<dev string:x183>" + damage + "<dev string:x193>" + final_damage);
        }
    #/
    final_damage = int(final_damage);
    if (final_damage < 1) {
        final_damage = 1;
    }
    return final_damage;
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0xed007f0e, Offset: 0x4078
// Size: 0x3a
function isexplosivedamage(meansofdeath) {
    switch (meansofdeath) {
    case "MOD_EXPLOSIVE":
    case "MOD_GRENADE":
    case "MOD_GRENADE_SPLASH":
    case "MOD_PROJECTILE_SPLASH":
        return true;
    }
    return false;
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0xbe039dc3, Offset: 0x40c0
// Size: 0x51
function function_bb61b344(player) {
    return player hasperk("specialty_stunprotection") || player hasperk("specialty_flashprotection") || player hasperk("specialty_proximityprotection");
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0x65e39d87, Offset: 0x4120
// Size: 0x1e
function isprimarydamage(meansofdeath) {
    return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET";
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0x5295162c, Offset: 0x4148
// Size: 0x2a
function isbulletdamage(meansofdeath) {
    return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_HEAD_SHOT";
}

// Namespace loadout
// Params 3, eflags: 0x0
// Checksum 0x9e3788a9, Offset: 0x4180
// Size: 0x61
function isfmjdamage(sweapon, smeansofdeath, attacker) {
    return isdefined(attacker) && isplayer(attacker) && attacker hasperk("specialty_armorpiercing") && isdefined(smeansofdeath) && isbulletdamage(smeansofdeath);
}

// Namespace loadout
// Params 2, eflags: 0x0
// Checksum 0x743aabac, Offset: 0x41f0
// Size: 0x49
function isfiredamage(weapon, meansofdeath) {
    if (meansofdeath == "MOD_BURNED" || meansofdeath == "MOD_GRENADE" || weapon.doesfiredamage && meansofdeath == "MOD_GRENADE_SPLASH") {
        return true;
    }
    return false;
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0x49eaf704, Offset: 0x4248
// Size: 0x2a
function function_1b2a8c(hitloc) {
    return hitloc == "helmet" || hitloc == "head" || hitloc == "neck";
}

// Namespace loadout
// Params 1, eflags: 0x0
// Checksum 0x7adaaeee, Offset: 0x4280
// Size: 0x27
function function_c44068e7(inflictor) {
    return isdefined(inflictor) && isdefined(inflictor.stucktoplayer) && inflictor.stucktoplayer == self;
}

