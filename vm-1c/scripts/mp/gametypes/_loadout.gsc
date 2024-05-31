#using scripts/mp/teams/_teams;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_killstreak_weapons;
#using scripts/mp/gametypes/_weapons;
#using scripts/mp/gametypes/_globallogic_utils;
#using scripts/mp/gametypes/_globallogic_score;
#using scripts/mp/gametypes/_dev;
#using scripts/mp/_util;
#using scripts/mp/_challenges;
#using scripts/mp/_armor;
#using scripts/shared/abilities/gadgets/_gadget_roulette;
#using scripts/shared/weapons/_weapon_utils;
#using scripts/shared/abilities/_ability_util;
#using scripts/shared/util_shared;
#using scripts/shared/tweakables_shared;
#using scripts/shared/system_shared;
#using scripts/shared/loadout_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/dev_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace loadout;

// Namespace loadout
// Params 0, eflags: 0x2
// namespace_a249d1db<file_0>::function_2dc19561
// Checksum 0xa024a300, Offset: 0xe08
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("loadout", &__init__, undefined, undefined);
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_8c87d8eb
// Checksum 0x7a239e71, Offset: 0xe48
// Size: 0x44
function __init__() {
    callback::on_start_gametype(&init);
    callback::on_connect(&on_connect);
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_eb99da89
// Checksum 0x99ec1590, Offset: 0xe98
// Size: 0x4
function on_connect() {
    
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_c35e6aab
// Checksum 0x5ffc14c0, Offset: 0xea8
// Size: 0x1554
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
    level.weaponknifeloadout = getweapon("knife_loadout");
    level.var_dbfc7979 = getweapon("melee_knuckles");
    level.var_4b668568 = getweapon("melee_butterfly");
    level.var_ed508918 = getweapon("melee_wrench");
    level.var_9d6d34a6 = getweapon("melee_sword");
    level.var_2506cce1 = getweapon("melee_crowbar");
    level.weaponspecialcrossbow = getweapon("special_crossbow");
    level.var_a37fcb5 = getweapon("melee_dagger");
    level.var_87abc71c = getweapon("melee_bat");
    level.var_50ef580f = getweapon("melee_bowie");
    level.var_fcab6539 = getweapon("melee_mace");
    level.var_680e11a1 = getweapon("melee_fireaxe");
    level.var_d81e42fb = getweapon("melee_boneglass");
    level.var_b6eabba5 = getweapon("melee_improvise");
    level.weaponshotgunenergy = getweapon("shotgun_energy");
    level.weaponpistolenergy = getweapon("pistol_energy");
    level.var_ad509f1b = getweapon("melee_shockbaton");
    level.var_155e5036 = getweapon("melee_nunchuks");
    level.var_41b6ad46 = getweapon("melee_boxing");
    level.var_3fc29189 = getweapon("melee_katana");
    level.var_6ac28ae6 = getweapon("melee_shovel");
    level.var_ba044fb0 = getweapon("melee_prosthetic");
    level.var_ce518589 = getweapon("melee_chainsaw");
    level.var_a0d4ce4d = getweapon("special_discgun");
    level.var_5f8b749e = getweapon("smg_nailgun");
    level.var_bb8c1d00 = getweapon("launcher_multi");
    level.var_a3dc5f22 = getweapon("melee_crescent");
    level.var_75c8bd53 = getweapon("launcher_ex41");
    level.meleeweapons = [];
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.weaponknifeloadout;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_dbfc7979;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_4b668568;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_ed508918;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_9d6d34a6;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_2506cce1;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_a37fcb5;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_87abc71c;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_50ef580f;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_fcab6539;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_680e11a1;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_d81e42fb;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_b6eabba5;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_ad509f1b;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_155e5036;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_41b6ad46;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_3fc29189;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_6ac28ae6;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_ba044fb0;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_ce518589;
    if (!isdefined(level.meleeweapons)) {
        level.meleeweapons = [];
    } else if (!isarray(level.meleeweapons)) {
        level.meleeweapons = array(level.meleeweapons);
    }
    level.meleeweapons[level.meleeweapons.size] = level.var_a3dc5f22;
    level.var_7937f010 = getweapon("bouncingbetty");
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
    var_47c38c35 = -109;
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
    callback::add_weapon_damage(level.var_a0d4ce4d, &function_b8689fdc);
}

// Namespace loadout
// Params 5, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_b8689fdc
// Checksum 0x13235f1a, Offset: 0x2408
// Size: 0x5c
function function_b8689fdc(eattacker, einflictor, weapon, meansofdeath, damage) {
    if (weapon != level.var_a0d4ce4d) {
        return;
    }
    playsoundatposition("wpn_disc_bounce_fatal", self.origin);
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_344147a4
// Checksum 0x16100275, Offset: 0x2470
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
// Checksum 0x56e26c26, Offset: 0x2578
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
// Checksum 0x3ef66feb, Offset: 0x25e8
// Size: 0x4c
function function_2358da67() {
    if (!isdefined(level.var_f543dad1)) {
        var_a804a5cf = util::function_bc37a245();
        level.var_f543dad1 = tablelookupfindcoreasset(var_a804a5cf);
    }
}

// Namespace loadout
// Params 1, eflags: 0x0
// namespace_a249d1db<file_0>::function_5cd00b1b
// Checksum 0x5b3e2a1, Offset: 0x2640
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
// Checksum 0x3ba676f5, Offset: 0x26c8
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
// Checksum 0xaa24fae2, Offset: 0x27a0
// Size: 0x26
function load_default_loadout(weaponclass, classnum) {
    level.classtoclassnum[weaponclass] = classnum;
}

// Namespace loadout
// Params 2, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_20fe6790
// Checksum 0x65673028, Offset: 0x27d0
// Size: 0x18c
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
    if (weapon_type != "hero") {
        assert(0, "class_lmg" + weapon_type);
    }
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_571ecd1a
// Checksum 0x99cf728f, Offset: 0x2968
// Size: 0x4a
function function_571ecd1a(weapon) {
    readyvo = weapon.name + "_ready";
    game["dialog"][readyvo] = readyvo;
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_cd945d1d
// Checksum 0x909a0343, Offset: 0x29c0
// Size: 0x5bc
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
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_29da5080
// Checksum 0xa7b3dcbd, Offset: 0x2f88
// Size: 0x40
function getclasschoice(response) {
    assert(isdefined(level.classmap[response]));
    return level.classmap[response];
}

// Namespace loadout
// Params 2, eflags: 0x0
// namespace_a249d1db<file_0>::function_bb59b4b7
// Checksum 0x9fda5f30, Offset: 0x2fd0
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
// Checksum 0x382956c5, Offset: 0x3060
// Size: 0x1a
function function_5933877() {
    if (!isdefined(level.var_b65167f1)) {
        return 0;
    }
    return level.var_b65167f1;
}

// Namespace loadout
// Params 2, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_14f4f303
// Checksum 0xfde1aff8, Offset: 0x3088
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
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_66234473
// Checksum 0xa13713bc, Offset: 0x3128
// Size: 0x546
function function_66234473() {
    self.killstreak = [];
    if (!level.loadoutkillstreaksenabled) {
        return;
    }
    classnum = self.class_num_for_global_weapons;
    sortedkillstreaks = [];
    currentkillstreak = 0;
    for (killstreaknum = 0; killstreaknum < level.maxkillstreaks; killstreaknum++) {
        killstreakindex = getkillstreakindex(classnum, killstreaknum);
        if (isdefined(killstreakindex) && killstreakindex > 0) {
            assert(isdefined(level.tbl_killstreakdata[killstreakindex]), "class_lmg" + killstreakindex + "class_lmg");
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
// namespace_a249d1db<file_0>::function_fc32096
// Checksum 0xe75c382d, Offset: 0x3678
// Size: 0x2a
function function_fc32096(perkname) {
    return isdefined(perkname) && isstring(perkname);
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_5262aa0d
// Checksum 0x533e9206, Offset: 0x36b0
// Size: 0x18
function reset_specialty_slots(class_num) {
    self.specialty = [];
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_1088c9f
// Checksum 0x876a0fa9, Offset: 0x36d0
// Size: 0x10
function function_1088c9f() {
    self.staticweaponsstarttime = gettime();
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_1c374fc1
// Checksum 0xafb972, Offset: 0x36e8
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
// Checksum 0xa3d98562, Offset: 0x3728
// Size: 0x2e
function function_9afb7ce8(item) {
    if (level.leaguematch) {
        return isitemrestricted(item);
    }
    return 0;
}

// Namespace loadout
// Params 2, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_5edb1868
// Checksum 0xb01c2b0e, Offset: 0x3760
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
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_79d05183
// Checksum 0xc9a9bd06, Offset: 0x37e0
// Size: 0xa2
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
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_d23c71b9
// Checksum 0x457ea9b8, Offset: 0x3890
// Size: 0x22c
function giveperks() {
    pixbeginevent("givePerks");
    self.specialty = self getloadoutperks(self.class_num);
    self setplayerstateloadoutbonuscards(self.class_num);
    self setplayerstateloadoutweapons(self.class_num);
    if (level.leaguematch) {
        for (i = 0; i < self.specialty.size; i++) {
            if (function_9afb7ce8(self.specialty[i])) {
                arrayremoveindex(self.specialty, i);
                i--;
            }
        }
    }
    self register_perks();
    anteup_bonus = getdvarint("perk_killstreakAnteUpResetValue");
    momentum_at_spawn_or_game_end = isdefined(self.pers["momentum_at_spawn_or_game_end"]) ? self.pers["momentum_at_spawn_or_game_end"] : 0;
    var_c95a3982 = !(self.hasdonecombat === 1);
    if (level.ingraceperiod && (level.inprematchperiod || var_c95a3982) && momentum_at_spawn_or_game_end < anteup_bonus) {
        new_momentum = self hasperk("specialty_anteup") ? anteup_bonus : momentum_at_spawn_or_game_end;
        globallogic_score::_setplayermomentum(self, new_momentum, 0);
    }
    pixendevent();
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_1d84af77
// Checksum 0xd5f38cce, Offset: 0x3ac8
// Size: 0x1d4
function function_1d84af77(weaponclass) {
    if (issubstr(weaponclass, "CLASS_CUSTOM")) {
        pixbeginevent("custom class");
        self.class_num = int(weaponclass[weaponclass.size - 1]) - 1;
        if (-1 == self.class_num) {
            self.class_num = 9;
        }
        self.class_num_for_global_weapons = self.class_num;
        self reset_specialty_slots(self.class_num);
        playerrenderoptions = self calcplayeroptions(self.class_num);
        self setplayerrenderoptions(playerrenderoptions);
        pixendevent();
    } else {
        pixbeginevent("default class");
        assert(isdefined(self.pers["class_lmg"]), "class_lmg");
        self.class_num = level.classtoclassnum[weaponclass];
        self.class_num_for_global_weapons = 0;
        self setplayerrenderoptions(0);
        pixendevent();
    }
    self recordloadoutindex(self.class_num);
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_a6ea9349
// Checksum 0x27ef5f50, Offset: 0x3ca8
// Size: 0xc0
function function_a6ea9349() {
    self.spawnweapon = level.weaponbasemeleeheld;
    var_bb5ce82a = self calcweaponoptions(self.class_num, 2);
    self giveweapon(level.weaponbasemeleeheld, var_bb5ce82a);
    self.pers["spawnWeapon"] = self.spawnweapon;
    switchimmediate = isdefined(self.alreadysetspawnweapononce);
    self setspawnweapon(self.spawnweapon, switchimmediate);
    self.alreadysetspawnweapononce = 1;
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_86d76f45
// Checksum 0xab1880c1, Offset: 0x3d70
// Size: 0x60c
function function_86d76f45() {
    pixbeginevent("giveWeapons");
    spawnweapon = level.weaponnull;
    var_1ddab10 = 0;
    if (isdefined(self.pers["weapon"]) && self.pers["weapon"] != level.weaponnone && !self.pers["weapon"].iscarriedkillstreak) {
        primaryweapon = self.pers["weapon"];
    } else {
        primaryweapon = self getloadoutweapon(self.class_num, "primary");
    }
    if (primaryweapon.iscarriedkillstreak) {
        primaryweapon = level.weaponnull;
    }
    self.pers["primaryWeapon"] = primaryweapon;
    if (primaryweapon != level.weaponnull) {
        primaryweaponoptions = self calcweaponoptions(self.class_num, 0);
        var_65ce895e = self getattachmentcosmeticvariantforweapon(self.class_num, "primary");
        self giveweapon(primaryweapon, primaryweaponoptions, var_65ce895e);
        self weapons::function_5be8b6af(primaryweapon, primaryweaponoptions, var_65ce895e);
        self.primaryloadoutweapon = primaryweapon;
        self.var_367ea154 = primaryweapon.altweapon;
        self.primaryloadoutgunsmithvariantindex = self getloadoutgunsmithvariantindex(self.class_num, 0);
        if (self hasperk("specialty_extraammo")) {
            self givemaxammo(primaryweapon);
        }
        spawnweapon = primaryweapon;
        var_1ddab10++;
    }
    sidearm = self getloadoutweapon(self.class_num, "secondary");
    if (sidearm.iscarriedkillstreak) {
        sidearm = level.weaponnull;
    }
    if (sidearm.name == "bowie_knife") {
        sidearm = level.weaponnull;
    }
    if (sidearm != level.weaponnull) {
        secondaryweaponoptions = self calcweaponoptions(self.class_num, 1);
        var_65ce895e = self getattachmentcosmeticvariantforweapon(self.class_num, "secondary");
        self giveweapon(sidearm, secondaryweaponoptions, var_65ce895e);
        self.secondaryloadoutweapon = sidearm;
        self.var_f8a642e8 = sidearm.altweapon;
        self.secondaryloadoutgunsmithvariantindex = self getloadoutgunsmithvariantindex(self.class_num, 1);
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
            var_bb5ce82a = self calcweaponoptions(self.class_num, 2);
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
    self thread initweaponattachments(spawnweapon);
    self.pers["changed_class"] = 0;
    self.spawnweapon = spawnweapon;
    self.pers["spawnWeapon"] = self.spawnweapon;
    switchimmediate = isdefined(self.alreadysetspawnweapononce);
    self setspawnweapon(spawnweapon, switchimmediate);
    self.alreadysetspawnweapononce = 1;
    self function_1088c9f();
    self bbclasschoice(self.class_num, primaryweapon, sidearm);
    pixendevent();
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_af9cf7d0
// Checksum 0x6881a1e8, Offset: 0x4388
// Size: 0x2ec
function function_af9cf7d0() {
    pixbeginevent("givePrimaryOffhand");
    changedclass = self.pers["changed_class"];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    primaryoffhand = level.weaponnone;
    primaryoffhandcount = 0;
    if (getdvarint("gadgetEnabled") == 1 || getdvarint("equipmentAsGadgets") == 1) {
        primaryoffhand = self getloadoutweapon(self.class_num, "primaryGadget");
        primaryoffhandcount = primaryoffhand.startammo;
    } else {
        primaryoffhandname = self getloadoutitemref(self.class_num, "primarygrenade");
        if (primaryoffhandname != "" && primaryoffhandname != "weapon_null") {
            primaryoffhand = getweapon(primaryoffhand);
            primaryoffhandcount = self getloadoutitem(self.class_num, "primarygrenadecount");
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
    if (primaryoffhand != level.weaponnull) {
        self giveweapon(primaryoffhand);
        self setweaponammoclip(primaryoffhand, primaryoffhandcount);
        self switchtooffhand(primaryoffhand);
        self.grenadetypeprimary = primaryoffhand;
        self.grenadetypeprimarycount = primaryoffhandcount;
        self ability_util::gadget_reset(primaryoffhand, changedclass, roundbased, firstround);
    }
    pixendevent();
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_76b01f20
// Checksum 0xdd23e178, Offset: 0x4680
// Size: 0x2ec
function function_76b01f20() {
    pixbeginevent("giveSecondaryOffhand");
    changedclass = self.pers["changed_class"];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    secondaryoffhand = level.weaponnone;
    secondaryoffhandcount = 0;
    if (getdvarint("gadgetEnabled") == 1 || getdvarint("equipmentAsGadgets") == 1) {
        secondaryoffhand = self getloadoutweapon(self.class_num, "secondaryGadget");
        secondaryoffhandcount = secondaryoffhand.startammo;
    } else {
        secondaryoffhandname = self getloadoutitemref(self.class_num, "specialgrenade");
        if (secondaryoffhandname != "" && secondaryoffhandname != "weapon_null") {
            secondaryoffhand = getweapon(secondaryoffhand);
            secondaryoffhandcount = self getloadoutitem(self.class_num, "specialgrenadecount");
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
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_e193f5c5
// Checksum 0xfcd5d577, Offset: 0x4978
// Size: 0x31c
function function_e193f5c5() {
    pixbeginevent("giveSpecialOffhand");
    changedclass = self.pers["changed_class"];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    classnum = self.class_num_for_global_weapons;
    specialoffhand = level.weaponnone;
    specialoffhandcount = 0;
    specialoffhand = self getloadoutweapon(self.class_num_for_global_weapons, "herogadget");
    specialoffhandcount = specialoffhand.startammo;
    /#
        if (getdvarstring("class_lmg") != "class_lmg") {
            var_c4697642 = getdvarstring("class_lmg");
            specialoffhand = level.weaponnone;
            if (var_c4697642 != "class_lmg") {
                specialoffhand = getweapon(var_c4697642);
            }
        }
    #/
    if (isdefined(self.pers[#"hash_65987563"])) {
        assert(specialoffhand.name == "class_lmg");
        specialoffhand = self.pers[#"hash_65987563"];
        roulette::function_41f588ae(specialoffhand, 0);
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
    pixendevent();
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_4ddd42ba
// Checksum 0x27818157, Offset: 0x4ca0
// Size: 0x224
function function_4ddd42ba() {
    pixbeginevent("giveHeroWeapon");
    changedclass = self.pers["changed_class"];
    roundbased = !util::isoneround();
    firstround = util::isfirstround();
    classnum = self.class_num_for_global_weapons;
    heroweapon = level.weaponnone;
    var_86a740f0 = self getloadoutitemref(self.class_num_for_global_weapons, "heroWeapon");
    /#
        if (getdvarstring("class_lmg") != "class_lmg") {
            var_86a740f0 = getdvarstring("class_lmg");
        }
    #/
    if (var_86a740f0 != "" && var_86a740f0 != "weapon_null") {
        if (var_86a740f0 == "hero_minigun") {
            model = self getcharacterbodymodel();
            if (isdefined(model) && issubstr(model, "body3")) {
                var_86a740f0 = "hero_minigun_body3";
            }
        }
        heroweapon = getweapon(var_86a740f0);
    }
    if (heroweapon != level.weaponnone) {
        self.heroweapon = heroweapon;
        self giveweapon(heroweapon);
        self ability_util::gadget_reset(heroweapon, changedclass, roundbased, firstround);
    }
    pixendevent();
}

// Namespace loadout
// Params 2, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_a61641c6
// Checksum 0x9fb6effa, Offset: 0x4ed0
// Size: 0x294
function giveloadout(team, weaponclass) {
    pixbeginevent("giveLoadout");
    if (isdefined(level.givecustomloadout)) {
        spawnweapon = self [[ level.givecustomloadout ]]();
        if (isdefined(spawnweapon)) {
            self thread initweaponattachments(spawnweapon);
        }
        self.spawnweapon = spawnweapon;
    } else {
        self function_79d05183(1);
        function_1d84af77(weaponclass);
        self setactionslot(3, "altMode");
        self setactionslot(4, "");
        allocationspent = self getloadoutallocation(self.class_num);
        overallocation = allocationspent > level.maxallocation;
        if (!overallocation) {
            giveperks();
            function_86d76f45();
            function_af9cf7d0();
        } else {
            function_a6ea9349();
        }
        function_76b01f20();
        if (getdvarint("tu11_enableClassicMode") == 0) {
            function_e193f5c5();
            function_4ddd42ba();
        }
        function_66234473();
    }
    self teams::function_37fd0a0f(undefined, undefined);
    if (isdefined(self.movementspeedmodifier)) {
        self setmovespeedscale(self.movementspeedmodifier * self getmovespeedscale());
    }
    self cac_selector();
    self function_68857c5f(self.spawnweapon, self.pers["primaryWeapon"]);
    pixendevent();
}

// Namespace loadout
// Params 2, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_68857c5f
// Checksum 0x408b0f04, Offset: 0x5170
// Size: 0xbc
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
// Params 2, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_8de272c8
// Checksum 0x262d3dda, Offset: 0x5238
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
// namespace_a249d1db<file_0>::function_888cb133
// Checksum 0x66f725dc, Offset: 0x5318
// Size: 0x9c
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
// namespace_a249d1db<file_0>::function_5ab95f3d
// Checksum 0x516a7b5e, Offset: 0x53c0
// Size: 0x40
function fadeaway(waitdelay, fadedelay) {
    wait(waitdelay);
    self fadeovertime(fadedelay);
    self.alpha = 0;
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_93a49c9d
// Checksum 0xeca5592d, Offset: 0x5408
// Size: 0x18
function setclass(newclass) {
    self.curclass = newclass;
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_e4a4bdf7
// Checksum 0x7296d380, Offset: 0x5428
// Size: 0xf4
function initperkdvars() {
    level.cac_armorpiercing_data = getdvarint("perk_armorpiercing", 40) / 100;
    level.cac_bulletdamage_data = getdvarint("perk_bulletDamage", 35);
    level.cac_fireproof_data = getdvarint("perk_fireproof", 20);
    level.cac_armorvest_data = getdvarint("perk_armorVest", 80);
    level.cac_flakjacket_data = getdvarint("perk_flakJacket", 35);
    level.cac_flakjacket_hardcore_data = getdvarint("perk_flakJacket_hardcore", 9);
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_5d88bb60
// Checksum 0x9eeac2c2, Offset: 0x5528
// Size: 0x8e
function cac_selector() {
    self.detectexplosives = 0;
    if (isdefined(self.specialty)) {
        perks = self.specialty;
        for (i = 0; i < perks.size; i++) {
            perk = perks[i];
            if (perk == "specialty_detectexplosive") {
                self.detectexplosives = 1;
            }
        }
    }
}

// Namespace loadout
// Params 0, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_f03301a4
// Checksum 0xcb5b5876, Offset: 0x55c0
// Size: 0xf4
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
// Params 6, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_4c74de55
// Checksum 0x1b5520eb, Offset: 0x56c0
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
            if (getdvarint("class_lmg")) {
                println("class_lmg" + attacker.name + "class_lmg");
            }
        #/
    } else {
        final_damage = old_damage;
    }
    /#
        if (getdvarint("class_lmg")) {
            println("class_lmg" + final_damage / old_damage + "class_lmg" + old_damage + "class_lmg" + final_damage);
        }
    #/
    return int(final_damage);
}

// Namespace loadout
// Params 7, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_923da066
// Checksum 0x7aa99c79, Offset: 0x58b8
// Size: 0x70c
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
        if (getdvarint("class_lmg")) {
            debug = 1;
            if (!isdefined(attacker.name)) {
                attacker.name = "class_lmg";
            }
        }
    #/
    final_damage = damage;
    if (victim != attacker) {
        if (attacker_is_player && attacker hasperk("specialty_bulletdamage") && isprimarydamage(mod)) {
            if (victim hasperk("specialty_armorvest") && !function_1b2a8c(hitloc)) {
                /#
                    if (debug) {
                        println("class_lmg" + victim.name + "class_lmg" + attacker.name + "class_lmg");
                    }
                #/
            } else {
                final_damage = damage * (100 + level.cac_bulletdamage_data) / 100;
                /#
                    if (debug) {
                        println("class_lmg" + attacker.name + "class_lmg" + victim.name);
                    }
                #/
            }
        } else if (victim hasperk("specialty_armorvest") && isprimarydamage(mod) && !function_1b2a8c(hitloc)) {
            final_damage = damage * level.cac_armorvest_data * 0.01;
            /#
                if (debug) {
                    println("class_lmg" + attacker.name + "class_lmg" + victim.name);
                }
            #/
        } else if (victim hasperk("specialty_fireproof") && isfiredamage(weapon, mod)) {
            final_damage = damage * level.cac_fireproof_data * 0.01;
            /#
                if (debug) {
                    println("class_lmg" + attacker.name + "class_lmg" + victim.name);
                }
            #/
        } else if (victim hasperk("specialty_flakjacket") && isexplosivedamage(mod) && !weapon.ignoresflakjacket && !victim function_c44068e7(inflictor)) {
            cac_data = level.hardcoremode ? level.cac_flakjacket_hardcore_data : level.cac_flakjacket_data;
            if (victim util::has_flak_jacket_perk_purchased_and_equipped()) {
                if (level.teambased && attacker.team != victim.team) {
                    victim thread challenges::flakjacketprotectedmp(weapon, attacker);
                } else if (attacker != victim) {
                    victim thread challenges::flakjacketprotectedmp(weapon, attacker);
                }
            }
            final_damage = int(damage * cac_data / 100);
            /#
                if (debug) {
                    println("class_lmg" + victim.name + "class_lmg" + attacker.name + "class_lmg");
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
            println("class_lmg" + final_damage / damage + "class_lmg" + damage + "class_lmg" + final_damage);
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
// Checksum 0xf4d9f7dc, Offset: 0x5fd0
// Size: 0x4c
function isexplosivedamage(meansofdeath) {
    switch (meansofdeath) {
    case 165:
    case 166:
    case 167:
    case 168:
    case 169:
        return true;
    }
    return false;
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_bb61b344
// Checksum 0x8c35470, Offset: 0x6028
// Size: 0x6a
function function_bb61b344(player) {
    return player hasperk("specialty_stunprotection") || player hasperk("specialty_flashprotection") || player hasperk("specialty_proximityprotection");
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_dd0f4246
// Checksum 0x1e56d988, Offset: 0x60a0
// Size: 0x28
function isprimarydamage(meansofdeath) {
    return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET";
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_ad3d706
// Checksum 0x3d3df362, Offset: 0x60d0
// Size: 0x38
function isbulletdamage(meansofdeath) {
    return meansofdeath == "MOD_RIFLE_BULLET" || meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_HEAD_SHOT";
}

// Namespace loadout
// Params 3, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_ee96878f
// Checksum 0xc611d287, Offset: 0x6110
// Size: 0x7a
function isfmjdamage(sweapon, smeansofdeath, attacker) {
    return isdefined(attacker) && isplayer(attacker) && attacker hasperk("specialty_armorpiercing") && isdefined(smeansofdeath) && isbulletdamage(smeansofdeath);
}

// Namespace loadout
// Params 2, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_7b1ff84a
// Checksum 0x76b21971, Offset: 0x6198
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
// Checksum 0x78284d8e, Offset: 0x6200
// Size: 0x38
function function_1b2a8c(hitloc) {
    return hitloc == "helmet" || hitloc == "head" || hitloc == "neck";
}

// Namespace loadout
// Params 1, eflags: 0x1 linked
// namespace_a249d1db<file_0>::function_c44068e7
// Checksum 0xa616eda, Offset: 0x6240
// Size: 0x3a
function function_c44068e7(inflictor) {
    return isdefined(inflictor) && isdefined(inflictor.stucktoplayer) && inflictor.stucktoplayer == self;
}

