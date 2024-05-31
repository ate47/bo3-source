#using scripts/cp/cybercom/_cybercom_util;
#using scripts/cp/teams/_teams;
#using scripts/cp/gametypes/_save;
#using scripts/cp/_util;
#using scripts/cp/_challenges;
#using scripts/cp/gametypes/_dev;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/util_shared;
#using scripts/shared/tweakables_shared;
#using scripts/shared/system_shared;
#using scripts/shared/loadout_shared;
#using scripts/shared/player_shared;
#using scripts/shared/array_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/codescripts/struct;

#namespace loadout;

// Namespace loadout
// Params 0, eflags: 0x2
// namespace_a249d1db<file_0>::function_2dc19561
// Checksum 0x3f238f1c, Offset: 0xa20
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("loadout", &__init__, undefined, undefined);
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_8c87d8eb
// Checksum 0x55852f9b, Offset: 0xa60
// Size: 0x8c
function __init__() {
    level.var_a2b79791 = "c_usa_cia_masonjr_viewbody";
    callback::on_start_gametype(&init);
    callback::on_connect(&on_connect);
    callback::on_disconnect(&function_ef129246);
    level thread function_adca0ced();
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_eb99da89
// Checksum 0x99ec1590, Offset: 0xaf8
// Size: 0x4
function on_connect() {
    
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_c35e6aab
// Checksum 0xfaebfa54, Offset: 0xb08
// Size: 0x7f4
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
    level.prestigenumber = 5;
    level.defaultclass = "CLASS_CUSTOM1";
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
    level thread onplayerconnecting();
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_adca0ced
// Checksum 0x123a8588, Offset: 0x1308
// Size: 0x34
function function_adca0ced() {
    level flag::wait_till("all_players_spawned");
    savegame::function_37ae30c6();
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_ef129246
// Checksum 0x439d2521, Offset: 0x1348
// Size: 0x124
function function_ef129246() {
    self savegame::set_player_data("playerClass", undefined);
    self savegame::set_player_data("altPlayerID", undefined);
    self savegame::set_player_data("saved_weapon", undefined);
    self savegame::set_player_data("saved_weapondata", undefined);
    self savegame::set_player_data("lives", undefined);
    self savegame::set_player_data("saved_rig1", undefined);
    self savegame::set_player_data("saved_rig1_upgraded", undefined);
    self savegame::set_player_data("saved_rig2", undefined);
    self savegame::set_player_data("saved_rig2_upgraded", undefined);
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_344147a4
// Checksum 0x21dc74d3, Offset: 0x1478
// Size: 0xfc
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
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_c49c010
// Checksum 0xa940ae62, Offset: 0x1580
// Size: 0x68
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
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_2358da67
// Checksum 0x7fe68aea, Offset: 0x15f0
// Size: 0x3c
function function_2358da67() {
    if (!isdefined(level.var_f543dad1)) {
        level.var_f543dad1 = tablelookupfindcoreasset(util::function_bc37a245());
    }
}

// Namespace loadout
// Params 1, eflags: 0x0
// namespace_a249d1db<file_0>::function_5cd00b1b
// Checksum 0xd9d32469, Offset: 0x1638
// Size: 0x7c
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
// namespace_a249d1db<file_0>::function_8428dec1
// Checksum 0xfc8e1e19, Offset: 0x16c0
// Size: 0xcc
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
// Params 2, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_450af4b6
// Checksum 0x607c0abc, Offset: 0x1798
// Size: 0x26
function load_default_loadout(weaponclass, classnum) {
    level.classtoclassnum[weaponclass] = classnum;
}

// Namespace loadout
// Params 2, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_20fe6790
// Checksum 0x3388cae8, Offset: 0x17c8
// Size: 0x174
function weapon_class_register(weaponname, weapon_type) {
    if (issubstr("weapon_smg weapon_cqb weapon_assault weapon_lmg weapon_sniper weapon_shotgun weapon_launcher weapon_special", weapon_type)) {
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
    assert(0, "CLASS_LMG" + weapon_type);
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_cd945d1d
// Checksum 0x7cb62687, Offset: 0x1948
// Size: 0x4cc
function function_cd945d1d() {
    level.tbl_weaponids = [];
    function_2358da67();
    for (i = 0; i < 256; i++) {
        var_c04d8f24 = tablelookuprownum(level.var_f543dad1, 0, i);
        if (var_c04d8f24 > -1) {
            group_s = tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 2);
            if (issubstr(group_s, "weapon_") || group_s == "hero") {
                reference_s = tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 4);
                if (reference_s != "") {
                    weapon = getweapon(reference_s);
                    level.tbl_weaponids[i]["reference"] = reference_s;
                    level.tbl_weaponids[i]["group"] = group_s;
                    level.tbl_weaponids[i]["count"] = int(tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 5));
                    level.tbl_weaponids[i]["attachment"] = tablelookupcolumnforrow(level.var_f543dad1, var_c04d8f24, 8);
                }
            }
        }
    }
    level.perknames = [];
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
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_29da5080
// Checksum 0x371bba63, Offset: 0x1e20
// Size: 0x40
function getclasschoice(response) {
    assert(isdefined(level.classmap[response]));
    return level.classmap[response];
}

// Namespace loadout
// Params 2, eflags: 0x0
// namespace_a249d1db<file_0>::function_bb59b4b7
// Checksum 0xcff28077, Offset: 0x1e68
// Size: 0x88
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
// namespace_a249d1db<file_0>::function_5933877
// Checksum 0x1b070991, Offset: 0x1ef8
// Size: 0x1a
function function_5933877() {
    if (!isdefined(level.var_b65167f1)) {
        return 0;
    }
    return level.var_b65167f1;
}

// Namespace loadout
// Params 2, eflags: 0x0
// namespace_a249d1db<file_0>::function_14f4f303
// Checksum 0x6cdaafd1, Offset: 0x1f20
// Size: 0x94
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
// namespace_a249d1db<file_0>::function_fc32096
// Checksum 0xcc2134da, Offset: 0x1fc0
// Size: 0x2a
function function_fc32096(perkname) {
    return isdefined(perkname) && isstring(perkname);
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_5262aa0d
// Checksum 0x64c94f7, Offset: 0x1ff8
// Size: 0x18
function reset_specialty_slots(class_num) {
    self.specialty = [];
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_1088c9f
// Checksum 0xb12d28c9, Offset: 0x2018
// Size: 0x10
function function_1088c9f() {
    self.staticweaponsstarttime = gettime();
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_1c374fc1
// Checksum 0xeb3e3950, Offset: 0x2030
// Size: 0x36
function function_1c374fc1(equipment_name) {
    if (equipment_name == level.weapontacticalinsertion.name && level.disabletacinsert) {
        return false;
    }
    return true;
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_9afb7ce8
// Checksum 0x5dd6cf09, Offset: 0x2070
// Size: 0x2e
function function_9afb7ce8(item) {
    if (level.leaguematch) {
        return isitemrestricted(item);
    }
    return 0;
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_db96b564
// Checksum 0x7cd601ec, Offset: 0x20a8
// Size: 0x44
function function_db96b564(var_dc236bc8) {
    if (level.gametype === "coop") {
        self thread cybercom::function_674d724c(0, !(isdefined(var_dc236bc8) && var_dc236bc8));
    }
}

// Namespace loadout
// Params 2, eflags: 0x0
// namespace_a249d1db<file_0>::function_5edb1868
// Checksum 0xe0e214d9, Offset: 0x20f8
// Size: 0x74
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
// Params 4, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_a61641c6
// Checksum 0x74e170fe, Offset: 0x2178
// Size: 0x19c4
function giveloadout(team, weaponclass, var_dc236bc8, var_5a13c491) {
    pixbeginevent("giveLoadout");
    self takeallweapons();
    primaryindex = 0;
    self.specialty = [];
    self.killstreak = [];
    self notify(#"give_map");
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
        if (isdefined(var_5a13c491)) {
            self.var_6f9a6c8e = 1;
        } else {
            self.var_6f9a6c8e = undefined;
        }
        self reset_specialty_slots(class_num);
        playerrenderoptions = self calcplayeroptions(class_num);
        class_num_for_global_weapons = class_num;
        var_e7b1aca8 = 1;
        pixendevent();
    } else {
        pixbeginevent("default class");
        assert(isdefined(self.pers["CLASS_LMG"]), "CLASS_LMG");
        class_num = level.classtoclassnum[weaponclass];
        if (!isdefined(class_num)) {
            if (self util::is_bot()) {
                class_num = array::random(level.classtoclassnum);
            } else {
                assert(0, "CLASS_LMG" + weaponclass + "CLASS_LMG");
            }
        }
        self.class_num = class_num;
        pixendevent();
    }
    var_bb5ce82a = self calcweaponoptions(class_num, 2);
    println("CLASS_LMG" + self.name + "CLASS_LMG" + level.weaponbasemelee.name + "CLASS_LMG");
    self giveweapon(level.weaponbasemelee, var_bb5ce82a);
    self.specialty = self getloadoutperks(class_num);
    if (level.leaguematch) {
        for (i = 0; i < self.specialty.size; i++) {
            if (function_9afb7ce8(self.specialty[i])) {
                arrayremoveindex(self.specialty, i);
                i--;
            }
        }
    }
    self setplayerstateloadoutweapons(class_num);
    self register_perks();
    self setactionslot(3, "altMode");
    self setactionslot(4, "");
    spawnweapon = "";
    var_1ddab10 = 0;
    if (isdefined(self.pers["weapon"]) && self.pers["weapon"] != level.weaponnone && !self.pers["weapon"].iscarriedkillstreak) {
        primaryweapon = self.pers["weapon"];
    } else {
        primaryweapon = self getloadoutweapon(class_num, "primary");
        if (isdefined(var_5a13c491)) {
            primaryweapon = var_5a13c491 getloadoutweapon(class_num, "primary");
        }
    }
    if (primaryweapon.iscarriedkillstreak) {
        primaryweapon = level.weaponnull;
    }
    sidearm = self getloadoutweapon(class_num, "secondary");
    if (isdefined(var_5a13c491)) {
        sidearm = var_5a13c491 getloadoutweapon(class_num, "secondary");
    }
    if (sidearm.iscarriedkillstreak) {
        sidearm = level.weaponnull;
    }
    self.var_bf3e36ed = 0;
    self.var_779cc3c1 = 0;
    if (sidearm != level.weaponnull) {
        secondaryweaponoptions = self calcweaponoptions(class_num, 1);
        if (isdefined(var_5a13c491)) {
            secondaryweaponoptions = var_5a13c491 calcweaponoptions(class_num, 1);
        }
        println("CLASS_LMG" + self.name + "CLASS_LMG" + sidearm.name + "CLASS_LMG");
        var_65ce895e = self getattachmentcosmeticvariantforweapon(class_num, "secondary");
        if (isdefined(var_5a13c491)) {
            var_65ce895e = var_5a13c491 getattachmentcosmeticvariantforweapon(class_num, "secondary");
        }
        self giveweapon(sidearm, secondaryweaponoptions, var_65ce895e);
        self.secondaryloadoutweapon = sidearm;
        self.var_f8a642e8 = sidearm.altweapon;
        self.secondaryloadoutgunsmithvariantindex = self getloadoutgunsmithvariantindex(self.class_num, 1);
        if (isdefined(var_5a13c491)) {
            self.secondaryloadoutgunsmithvariantindex = var_5a13c491 getloadoutgunsmithvariantindex(self.class_num, 1);
        }
        self givemaxammo(sidearm);
        spawnweapon = sidearm;
        var_1ddab10++;
    }
    self.pers["primaryWeapon"] = primaryweapon;
    if (primaryweapon != level.weaponnull) {
        primaryweaponoptions = self calcweaponoptions(class_num, 0);
        if (isdefined(var_5a13c491)) {
            primaryweaponoptions = var_5a13c491 calcweaponoptions(class_num, 0);
        }
        println("CLASS_LMG" + self.name + "CLASS_LMG" + primaryweapon.name + "CLASS_LMG");
        var_65ce895e = self getattachmentcosmeticvariantforweapon(class_num, "primary");
        if (isdefined(var_5a13c491)) {
            var_65ce895e = var_5a13c491 getattachmentcosmeticvariantforweapon(class_num, "primary");
        }
        self giveweapon(primaryweapon, primaryweaponoptions, var_65ce895e);
        self.primaryloadoutweapon = primaryweapon;
        self.var_367ea154 = primaryweapon.altweapon;
        self.primaryloadoutgunsmithvariantindex = self getloadoutgunsmithvariantindex(self.class_num, 0);
        if (isdefined(var_5a13c491)) {
            self.primaryloadoutgunsmithvariantindex = var_5a13c491 getloadoutgunsmithvariantindex(self.class_num, 0);
        }
        self givemaxammo(primaryweapon);
        spawnweapon = primaryweapon;
        var_1ddab10++;
    }
    if (isdefined(self.var_82325a18)) {
        var_82325a18 = strtok(self.var_82325a18, ",");
        foreach (weaponname in var_82325a18) {
            heroweapon = getweapon(weaponname);
            self giveweapon(heroweapon);
            self givemaxammo(heroweapon);
        }
    }
    if (!self hasmaxprimaryweapons()) {
        if (!isusingt7melee()) {
            println("CLASS_LMG" + self.name + "CLASS_LMG" + level.weaponbasemeleeheld.name + "CLASS_LMG");
            self giveweapon(level.weaponbasemeleeheld, var_bb5ce82a);
        }
        if (var_1ddab10 == 0) {
            spawnweapon = level.weaponbasemeleeheld;
        }
    }
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
    self.grenadetypeprimary = level.weaponnone;
    self.grenadetypeprimarycount = 0;
    self.grenadetypesecondary = level.weaponnone;
    self.grenadetypesecondarycount = 0;
    primaryoffhand = level.weaponnone;
    primaryoffhandcount = 0;
    secondaryoffhand = level.weaponnone;
    secondaryoffhandcount = 0;
    specialoffhand = level.weaponnone;
    specialoffhandcount = 0;
    if (getdvarint("gadgetEnabled") == 1 || getdvarint("equipmentAsGadgets") == 1) {
        primaryoffhand = self getloadoutweapon(class_num, "primaryGadget");
        if (isdefined(var_5a13c491)) {
            primaryoffhand = var_5a13c491 getloadoutweapon(class_num, "primaryGadget");
        }
        primaryoffhandcount = primaryoffhand.startammo;
    } else {
        primaryoffhandname = self getloadoutitemref(class_num, "primarygrenade");
        if (isdefined(var_5a13c491)) {
            primaryoffhandname = var_5a13c491 getloadoutitemref(class_num, "primarygrenade");
        }
        if (primaryoffhandname != "" && primaryoffhandname != "weapon_null") {
            primaryoffhand = getweapon(primaryoffhand);
            primaryoffhandcount = self getloadoutitem(class_num, "primarygrenadecount");
            if (isdefined(var_5a13c491)) {
                primaryoffhandcount = var_5a13c491 getloadoutitem(class_num, "primarygrenadecount");
            }
        }
    }
    if (function_9afb7ce8(primaryoffhand.name) || !function_1c374fc1(primaryoffhand.name)) {
        primaryoffhand = level.weaponnone;
        primaryoffhandcount = 0;
    }
    if (primaryoffhand == level.weaponnone) {
        primaryoffhand = level.weapons["frag"];
        primaryoffhandcount = 0;
    }
    if (primaryoffhand != level.weaponnull) {
        println("CLASS_LMG" + self.name + "CLASS_LMG" + primaryoffhand.name + "CLASS_LMG");
        self giveweapon(primaryoffhand);
        self setweaponammoclip(primaryoffhand, primaryoffhandcount);
        self switchtooffhand(primaryoffhand);
        self.grenadetypeprimary = primaryoffhand;
        self.grenadetypeprimarycount = primaryoffhandcount;
        self ability_util::gadget_reset(primaryoffhand, changedclass, roundbased, firstround);
    }
    if (getdvarint("gadgetEnabled") == 1 || getdvarint("equipmentAsGadgets") == 1) {
        secondaryoffhand = self getloadoutweapon(class_num, "secondaryGadget");
        if (isdefined(var_5a13c491)) {
            secondaryoffhand = var_5a13c491 getloadoutweapon(class_num, "secondaryGadget");
        }
        secondaryoffhandcount = secondaryoffhand.startammo;
    } else {
        secondaryoffhandname = self getloadoutitemref(class_num, "specialgrenade");
        if (isdefined(var_5a13c491)) {
            secondaryoffhandname = var_5a13c491 getloadoutitemref(class_num, "specialgrenade");
        }
        if (secondaryoffhandname != "" && secondaryoffhandname != "weapon_null") {
            secondaryoffhand = getweapon(secondaryoffhand);
            secondaryoffhandcount = self getloadoutitem(class_num, "specialgrenadecount");
            if (isdefined(var_5a13c491)) {
                secondaryoffhandcount = var_5a13c491 getloadoutitem(class_num, "specialgrenadecount");
            }
        }
    }
    if (function_9afb7ce8(secondaryoffhand.name) || !function_1c374fc1(secondaryoffhand.name)) {
        secondaryoffhand = level.weaponnone;
        secondaryoffhandcount = 0;
    }
    if (secondaryoffhand == level.weaponnone) {
        secondaryoffhand = level.weapons["flash"];
        secondaryoffhandcount = 0;
    }
    if (secondaryoffhand != level.weaponnull) {
        println("CLASS_LMG" + self.name + "CLASS_LMG" + secondaryoffhand.name + "CLASS_LMG");
        self giveweapon(secondaryoffhand);
        self setweaponammoclip(secondaryoffhand, secondaryoffhandcount);
        self switchtooffhand(secondaryoffhand);
        self.grenadetypesecondary = secondaryoffhand;
        self.grenadetypesecondarycount = secondaryoffhandcount;
        self ability_util::gadget_reset(secondaryoffhand, changedclass, roundbased, firstround);
    }
    if (getdvarint("gadgetEnabled") == 1 || getdvarint("equipmentAsGadgets") == 1) {
        specialoffhand = self getloadoutweapon(class_num, "specialGadget");
        if (isdefined(var_5a13c491)) {
            specialoffhand = var_5a13c491 getloadoutweapon(class_num, "specialGadget");
        }
        specialoffhandcount = specialoffhand.startammo;
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
        println("CLASS_LMG" + self.name + "CLASS_LMG" + specialoffhand.name + "CLASS_LMG");
        self giveweapon(specialoffhand);
        self setweaponammoclip(specialoffhand, specialoffhandcount);
        self switchtooffhand(specialoffhand);
        self.var_66cb8722 = specialoffhand;
        self.var_877b90bf = specialoffhandcount;
        self ability_util::gadget_reset(specialoffhand, changedclass, roundbased, firstround);
    }
    if (level.gametype === "coop") {
        cybercom::function_4b8ac464(class_num, class_num_for_global_weapons, !(isdefined(var_dc236bc8) && var_dc236bc8), var_5a13c491);
    }
    self bbclasschoice(class_num, primaryweapon, sidearm);
    for (i = 0; i < 3; i++) {
        if (level.loadoutkillstreaksenabled && isdefined(self.killstreak[i]) && isdefined(level.killstreakindices[self.killstreak[i]])) {
            killstreaks[i] = level.killstreakindices[self.killstreak[i]];
            continue;
        }
        killstreaks[i] = 0;
    }
    self recordloadoutperksandkillstreaks(primaryweapon, sidearm, self.grenadetypeprimary, self.grenadetypesecondary, killstreaks[0], killstreaks[1], killstreaks[2]);
    self teams::function_37fd0a0f(team, primaryweapon);
    self function_1088c9f();
    self thread initweaponattachments(spawnweapon);
    self setplayerrenderoptions(playerrenderoptions);
    if (isdefined(self.movementspeedmodifier)) {
        self setmovespeedscale(self.movementspeedmodifier * self getmovespeedscale());
    }
    if (isdefined(level.givecustomloadout)) {
        spawnweapon = self [[ level.givecustomloadout ]]();
        if (isdefined(spawnweapon)) {
            self thread initweaponattachments(spawnweapon);
        }
    }
    self cac_selector();
    if (!isdefined(self.firstspawn)) {
        if (isdefined(spawnweapon)) {
            self initialweaponraise(spawnweapon);
        } else {
            self initialweaponraise(primaryweapon);
        }
    } else {
        self seteverhadweaponall(1);
    }
    var_f0b98892 = self savegame::function_36adbb9c("saved_weapon", undefined);
    if (isdefined(var_f0b98892) && !(isdefined(level.is_safehouse) && level.is_safehouse)) {
        self player::take_weapons();
        self._current_weapon = util::get_weapon_by_name(var_f0b98892);
        self._weapons = self savegame::function_36adbb9c("saved_weapondata", undefined);
        self.lives = self savegame::function_36adbb9c("lives", 0);
        self player::give_back_weapons(0);
    }
    self.firstspawn = 0;
    self.switchedteamsresetgadgets = 0;
    if (system::function_85aec44f("cybercom")) {
        self flagsys::wait_till("cybercom_init");
    }
    self.initialloadoutgiven = 1;
    self flagsys::set("loadout_given");
    callback::callback(#"hash_33bba039");
    pixendevent();
}

// Namespace loadout
// Params 2, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_8de272c8
// Checksum 0x597d816b, Offset: 0x3b48
// Size: 0xd4
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
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_af2160d3
// Checksum 0x878c629, Offset: 0x3c28
// Size: 0xf0
function onplayerconnecting() {
    for (;;) {
        player = level waittill(#"connecting");
        if (!level.oldschool) {
            if (!isdefined(player.pers["class"])) {
                player.pers["class"] = "";
            }
            player.curclass = player.pers["class"];
            player.lastclass = "";
        }
        player.detectexplosives = 0;
        player.var_d1c344c9 = [];
        player.var_7d22ed55 = [];
        player.var_6964b90 = [];
        player.var_9f7edcf8 = [];
    }
}

// Namespace loadout
// Params 2, eflags: 0x0
// namespace_a249d1db<file_0>::function_5ab95f3d
// Checksum 0x31393425, Offset: 0x3d20
// Size: 0x40
function fadeaway(waitdelay, fadedelay) {
    wait(waitdelay);
    self fadeovertime(fadedelay);
    self.alpha = 0;
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_93a49c9d
// Checksum 0x5f10957a, Offset: 0x3d68
// Size: 0x18
function setclass(newclass) {
    self.curclass = newclass;
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_e4a4bdf7
// Checksum 0x8d23c057, Offset: 0x3d88
// Size: 0xf4
function initperkdvars() {
    level.cac_armorpiercing_data = getdvarint("perk_armorpiercing", 40) / 100;
    level.cac_bulletdamage_data = getdvarint("perk_bulletDamage", 35);
    level.cac_fireproof_data = getdvarint("perk_fireproof", 95);
    level.cac_armorvest_data = getdvarint("perk_armorVest", 80);
    level.cac_flakjacket_data = getdvarint("perk_flakJacket", 35);
    level.cac_flakjacket_hardcore_data = getdvarint("perk_flakJacket_hardcore", 9);
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_5d88bb60
// Checksum 0x60bcfef8, Offset: 0x3e88
// Size: 0x82
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
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_f03301a4
// Checksum 0xa24ff510, Offset: 0x3f18
// Size: 0x134
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
        println("CLASS_LMG" + self.name + "CLASS_LMG" + perk + "CLASS_LMG");
        self setperk(perk);
    }
    /#
        dev::giveextraperks();
    #/
}

// Namespace loadout
// Params 6, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_4c74de55
// Checksum 0x1b85a4a2, Offset: 0x4058
// Size: 0x1ea
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
            if (getdvarint("CLASS_LMG")) {
                println("CLASS_LMG" + attacker.name + "CLASS_LMG");
            }
        #/
    } else {
        final_damage = old_damage;
    }
    /#
        if (getdvarint("CLASS_LMG")) {
            println("CLASS_LMG" + final_damage / old_damage + "CLASS_LMG" + old_damage + "CLASS_LMG" + final_damage);
        }
    #/
    return int(final_damage);
}

// Namespace loadout
// Params 7, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_923da066
// Checksum 0xa2d23203, Offset: 0x4250
// Size: 0x6b4
function cac_modified_damage(victim, attacker, damage, mod, weapon, inflictor, hitloc) {
    assert(isdefined(victim));
    assert(isdefined(attacker));
    assert(isplayer(victim));
    if (damage <= 0) {
        return damage;
    }
    /#
        debug = 0;
        if (getdvarint("CLASS_LMG")) {
            debug = 1;
        }
    #/
    final_damage = damage;
    if (isplayer(attacker) && attacker hasperk("specialty_bulletdamage") && isprimarydamage(mod)) {
        if (victim hasperk("specialty_armorvest") && !function_1b2a8c(hitloc)) {
            /#
                if (debug) {
                    println("CLASS_LMG" + victim.name + "CLASS_LMG" + attacker.name + "CLASS_LMG");
                }
            #/
        } else {
            final_damage = damage * (100 + level.cac_bulletdamage_data) / 100;
            /#
                if (debug) {
                    println("CLASS_LMG" + attacker.name + "CLASS_LMG" + victim.name);
                }
            #/
        }
    } else if (victim hasperk("specialty_armorvest") && isprimarydamage(mod) && !function_1b2a8c(hitloc)) {
        final_damage = damage * level.cac_armorvest_data * 0.01;
        /#
            if (debug) {
                println("CLASS_LMG" + attacker.name + "CLASS_LMG" + victim.name);
            }
        #/
    } else if (victim hasperk("specialty_fireproof") && isfiredamage(weapon, mod)) {
        final_damage = damage * (100 - level.cac_fireproof_data) / 100;
        /#
            if (debug) {
                println("CLASS_LMG" + attacker.name + "CLASS_LMG" + victim.name);
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
                println("CLASS_LMG" + victim.name + "CLASS_LMG" + attacker.name + "CLASS_LMG");
            }
        #/
    }
    /#
        victim.cac_debug_damage_type = tolower(mod);
        victim.cac_debug_original_damage = damage;
        victim.cac_debug_final_damage = final_damage;
        victim.cac_debug_location = tolower(hitloc);
        victim.cac_debug_weapon = tolower(weapon.name);
        victim.cac_debug_range = int(distance(attacker.origin, victim.origin));
        if (debug) {
            println("CLASS_LMG" + final_damage / damage + "CLASS_LMG" + damage + "CLASS_LMG" + final_damage);
        }
    #/
    final_damage = int(final_damage);
    if (final_damage < 1) {
        final_damage = 1;
    }
    return final_damage;
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_261a5dc5
// Checksum 0xf7bad875, Offset: 0x4910
// Size: 0x44
function isexplosivedamage(meansofdeath) {
    switch (meansofdeath) {
    case 124:
    case 125:
    case 126:
    case 127:
        return true;
    }
    return false;
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_bb61b344
// Checksum 0x608f1dc, Offset: 0x4960
// Size: 0x6a
function function_bb61b344(player) {
    return player hasperk("specialty_stunprotection") || player hasperk("specialty_flashprotection") || player hasperk("specialty_proximityprotection");
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_dd0f4246
// Checksum 0xb68b04cb, Offset: 0x49d8
// Size: 0x28
function isprimarydamage(meansofdeath) {
    return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET";
}

// Namespace loadout
// Params 2, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_7b1ff84a
// Checksum 0x4340341d, Offset: 0x4a08
// Size: 0x60
function isfiredamage(weapon, meansofdeath) {
    if (meansofdeath == "MOD_BURNED" || meansofdeath == "MOD_GRENADE" || weapon.doesfiredamage && meansofdeath == "MOD_GRENADE_SPLASH") {
        return true;
    }
    return false;
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_1b2a8c
// Checksum 0xda8b9793, Offset: 0x4a70
// Size: 0x38
function function_1b2a8c(hitloc) {
    return hitloc == "helmet" || hitloc == "head" || hitloc == "neck";
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_c44068e7
// Checksum 0x4e4cd6fd, Offset: 0x4ab0
// Size: 0x3a
function function_c44068e7(inflictor) {
    return isdefined(inflictor) && isdefined(inflictor.stucktoplayer) && inflictor.stucktoplayer == self;
}

