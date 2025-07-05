#using scripts/codescripts/struct;
#using scripts/cp/_dialog;
#using scripts/cp/_hacking;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_zurich_newworld_rooftops;
#using scripts/cp/cybercom/_cybercom_gadget;
#using scripts/cp/cybercom/_cybercom_tactical_rig;
#using scripts/cp/cybercom/_cybercom_util;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/weapons_shared;

#namespace newworld_util;

// Namespace newworld_util
// Params 0, eflags: 0x2
// Checksum 0xdccce049, Offset: 0xc90
// Size: 0x2a
function autoexec __init__sytem__() {
    system::register("newworld_util", &__init__, undefined, undefined);
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0xd21bed8d, Offset: 0xcc8
// Size: 0x12
function __init__() {
    init_client_field_callback_funcs();
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0xd4913570, Offset: 0xce8
// Size: 0x2a
function init_client_field_callback_funcs() {
    clientfield::register("toplayer", "postfx_futz", 1, 1, "counter");
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0xd1f3c088, Offset: 0xd20
// Size: 0x452
function function_be075359() {
    if (!isdefined(level.mobile_armory_used)) {
        level.mobile_armory_used = [];
    }
    var_c4ba82be = getweapon("ar_fastburst", "suppressed", "acog");
    var_7d2e8aba = getweapon("smg_fastfire", "extclip");
    var_a337836d = getweapon("lmg_light", "acog", "fmj", "fastreload");
    var_17d630df = getweapon("shotgun_pump", "steadyaim", "extbarrel");
    var_a0543d15 = getweapon("pistol_standard", "suppressed", "reflex");
    var_9254de0d = getweapon("pistol_standard", "steadyaim");
    var_ae16e040 = getweapon("pistol_standard", "steadyaim");
    var_6473fc51 = getweapon("pistol_standard", "steadyaim");
    var_ad27f51f = getweapon("frag_grenade");
    var_63d3226f = getweapon("emp_grenade");
    switch (level.var_fee90489[0]) {
    case "factory_alley":
    case "factory_factory_exterior":
    case "factory_factory_intro_igc":
    case "factory_foundry":
    case "factory_inside_man_igc":
    case "factory_vat_room":
    case "factory_warehouse":
    case "white_infinite_igc":
        self take_weapons();
        self.primaryloadoutweapon = var_c4ba82be;
        self giveweapon(var_a0543d15);
        self giveweapon(var_ad27f51f);
        self giveweapon(var_63d3226f);
        break;
    case "chase_apartment_igc":
    case "chase_bridge_collapse":
    case "chase_chase_start":
    case "chase_construction_site":
    case "chase_glass_ceiling_igc":
    case "chase_old_zurich":
    case "chase_rooftops":
        self take_weapons();
        self.primaryloadoutweapon = var_7d2e8aba;
        self giveweapon(var_9254de0d);
        self giveweapon(var_ad27f51f);
        self giveweapon(var_63d3226f);
        break;
    case "underground_construction":
    case "underground_crossroads":
    case "underground_maintenance":
    case "underground_pinned_down_igc":
    case "underground_staging_room_igc":
    case "underground_subway":
    case "underground_water_plant":
        if (!self flagsys::get("mobile_armory_in_use") && !isdefined(level.mobile_armory_used[self getentitynumber()])) {
            self take_weapons();
            self.primaryloadoutweapon = var_a337836d;
            self giveweapon(var_ae16e040);
            self giveweapon(var_ad27f51f);
            self giveweapon(var_63d3226f);
        } else {
            self thread function_3a7ee040();
        }
        break;
    case "train_detach_bomb_igc":
    case "train_inbound_igc":
    case "train_train_roof":
    case "train_train_start":
        self take_weapons();
        self.primaryloadoutweapon = var_17d630df;
        self giveweapon(var_6473fc51);
        self giveweapon(var_ad27f51f);
        self giveweapon(var_63d3226f);
        break;
    default:
        break;
    }
    if (isdefined(self.primaryloadoutweapon)) {
        self giveweapon(self.primaryloadoutweapon);
        self switchtoweapon(self.primaryloadoutweapon);
    }
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0xc3ebbbf0, Offset: 0x1180
// Size: 0x5a
function function_3a7ee040() {
    if (!isdefined(level.mobile_armory_used[self getentitynumber()])) {
        level.mobile_armory_used[self getentitynumber()] = 1;
        self waittill(#"disconnect");
        level.mobile_armory_used[self getentitynumber()] = undefined;
    }
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0x13cdcc15, Offset: 0x11e8
// Size: 0x7a
function on_player_loadout() {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    if (self function_c633d8fe()) {
        return;
    }
    self function_be075359();
    self function_dbf420c6();
    self cybercom_tacrig::function_78908229();
    self cybercom_tacrig::function_8ffa26e2("cybercom_playermovement", 0);
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0xf7f5e943, Offset: 0x1270
// Size: 0xa2
function take_weapons(var_ddaacf8f) {
    if (!isdefined(var_ddaacf8f)) {
        var_ddaacf8f = 1;
    }
    var_ce9fba38 = self getweaponslist();
    foreach (w_weapon in var_ce9fba38) {
        self takeweapon(w_weapon);
    }
    if (var_ddaacf8f) {
        self.var_ce9fba38 = var_ce9fba38;
    }
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0x6e3822cc, Offset: 0x1320
// Size: 0x279
function function_dbf420c6() {
    wait 0.05;
    self namespace_d00ec32::function_c219b381();
    switch (level.var_fee90489[0]) {
    case "factory_alley":
    case "factory_factory_exterior":
    case "factory_factory_intro_igc":
    case "factory_foundry":
    case "factory_inside_man_igc":
    case "factory_vat_room":
    case "factory_warehouse":
    case "white_infinite_igc":
        if (isdefined(level.var_b7a27741) && level.var_b7a27741) {
            self namespace_d00ec32::function_a724d44("cybercom_hijack", 0);
            self namespace_d00ec32::function_eb512967("cybercom_hijack", 1);
        }
        break;
    case "chase_apartment_igc":
    case "chase_bridge_collapse":
    case "chase_chase_start":
    case "chase_construction_site":
    case "chase_glass_ceiling_igc":
    case "chase_old_zurich":
    case "chase_rooftops":
        if (isdefined(level.var_ebe3b234) && level.var_ebe3b234) {
            self namespace_d00ec32::function_a724d44("cybercom_systemoverload", 0);
            self namespace_d00ec32::function_eb512967("cybercom_systemoverload", 1);
        }
        break;
    case "underground_construction":
    case "underground_crossroads":
    case "underground_maintenance":
    case "underground_pinned_down_igc":
    case "underground_staging_room_igc":
    case "underground_subway":
    case "underground_water_plant":
        if (isdefined(level.var_e120c906) && level.var_e120c906) {
            self namespace_d00ec32::function_a724d44("cybercom_fireflyswarm", 1);
        }
        if (isdefined(level.var_11d004e5) && level.var_11d004e5) {
            self namespace_d00ec32::function_a724d44("cybercom_immolation", 0);
            self namespace_d00ec32::function_eb512967("cybercom_immolation", 1);
        }
        break;
    case "train_detach_bomb_igc":
    case "train_inbound_igc":
    case "train_train_roof":
    case "train_train_start":
        if (isdefined(level.var_fbc6080) && level.var_fbc6080) {
            self namespace_d00ec32::function_a724d44("cybercom_concussive", 1);
        }
        self namespace_d00ec32::function_a724d44("cybercom_rapidstrike", 0);
        self namespace_d00ec32::function_eb512967("cybercom_rapidstrike");
        break;
    default:
        break;
    }
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0x9d968b55, Offset: 0x15a8
// Size: 0x76
function function_7ee91bc9() {
    foreach (player in level.players) {
        if (player != self) {
            if (isdefined(player.var_1e983b11) && player.var_1e983b11) {
                return true;
            }
        }
    }
    return false;
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0x328af9e2, Offset: 0x1628
// Size: 0x76
function function_1cf75ffb() {
    foreach (player in level.players) {
        if (player != self) {
            if (isdefined(player.var_d829fe9f) && player.var_d829fe9f) {
                return true;
            }
        }
    }
    return false;
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0xec7fc7d, Offset: 0x16a8
// Size: 0x1c2
function function_1943bf79() {
    var_33dcf6cf = 0;
    var_1dedaef1 = 0;
    switch (level.var_fee90489[0]) {
    case "factory_factory_exterior":
    case "factory_factory_intro_igc":
    case "white_infinite_igc":
        if (isdefined(level.var_9ef26e4f) && level.var_9ef26e4f) {
            var_1dedaef1 = 1;
        } else {
            var_1dedaef1 = 0;
        }
        var_33dcf6cf = 0;
        break;
    case "chase_apartment_igc":
    case "chase_bridge_collapse":
    case "chase_chase_start":
    case "chase_construction_site":
    case "chase_glass_ceiling_igc":
    case "chase_old_zurich":
    case "chase_rooftops":
    case "factory_alley":
    case "factory_foundry":
    case "factory_inside_man_igc":
    case "factory_vat_room":
    case "factory_warehouse":
    case "underground_construction":
    case "underground_crossroads":
    case "underground_pinned_down_igc":
    case "underground_subway":
        var_1dedaef1 = 1;
        if (isdefined(level.var_74f7a02e) && level.var_74f7a02e) {
            var_33dcf6cf = 1;
        } else {
            var_33dcf6cf = 0;
        }
        break;
    case "train_detach_bomb_igc":
    case "train_inbound_igc":
    case "train_train_roof":
    case "train_train_start":
    case "underground_maintenance":
    case "underground_staging_room_igc":
    case "underground_water_plant":
        var_1dedaef1 = 1;
        var_33dcf6cf = 1;
        break;
    default:
        break;
    }
    println("<dev string:x28>" + var_1dedaef1 + "<dev string:x35>" + var_33dcf6cf + "<dev string:x41>");
    self function_a7cfc593(var_1dedaef1);
    self function_ba1a260f(var_33dcf6cf);
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0xaa4b18ab, Offset: 0x1878
// Size: 0x191
function player_snow_fx() {
    switch (level.var_fee90489[0]) {
    case "white_infinite_igc":
        level clientfield::set("player_snow_fx", 4);
        break;
    case "factory_alley":
    case "factory_factory_exterior":
    case "factory_factory_intro_igc":
    case "factory_foundry":
    case "factory_inside_man_igc":
    case "factory_vat_room":
    case "factory_warehouse":
        level clientfield::set("player_snow_fx", 1);
        break;
    case "chase_apartment_igc":
    case "chase_bridge_collapse":
    case "chase_chase_start":
    case "chase_construction_site":
    case "chase_glass_ceiling_igc":
    case "chase_old_zurich":
    case "chase_rooftops":
        level clientfield::set("player_snow_fx", 2);
        break;
    case "underground_construction":
    case "underground_crossroads":
    case "underground_maintenance":
    case "underground_pinned_down_igc":
    case "underground_staging_room_igc":
    case "underground_subway":
    case "underground_water_plant":
        level clientfield::set("player_snow_fx", 3);
        break;
    case "train_inbound_igc":
    case "train_train_roof":
    case "train_train_start":
        level clientfield::set("player_snow_fx", 4);
        break;
    case "train_detach_bomb_igc":
    case "waking_up_igc":
        level clientfield::set("player_snow_fx", 0);
        break;
    default:
        break;
    }
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0x84c9327c, Offset: 0x1a18
// Size: 0x1a
function function_85d8906c() {
    level clientfield::set("player_snow_fx", 0);
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0xa4c48d62, Offset: 0x1a40
// Size: 0x32
function function_e340d355() {
    if (self function_84a7d8c()) {
        self thread function_44aa9d22();
        self thread function_efd62bc8();
    }
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0xa14580e6, Offset: 0x1a80
// Size: 0x12
function function_84a7d8c() {
    return !isvehicle(self);
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0xc6cb8211, Offset: 0x1aa0
// Size: 0x97
function function_44aa9d22() {
    self endon(#"hash_70947625");
    self waittill(#"actor_corpse", e_corpse);
    if (isdefined(level.player_on_top_of_train) && level.player_on_top_of_train) {
        wait 10;
    }
    if (isdefined(e_corpse)) {
        e_corpse clientfield::set("derez_ai_deaths", 1);
    }
    util::wait_network_frame();
    wait 0.1;
    if (isdefined(e_corpse)) {
        e_corpse delete();
    }
    if (isdefined(self)) {
        self notify(#"hash_70947625");
    }
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0x97d6895a, Offset: 0x1b40
// Size: 0xa3
function function_efd62bc8() {
    self endon(#"hash_70947625");
    self waittill(#"start_ragdoll");
    if (isdefined(level.player_on_top_of_train) && level.player_on_top_of_train) {
        wait 10;
    } else if (self.b_balcony_death === 1) {
        wait 4;
    }
    if (isdefined(self)) {
        self clientfield::set("derez_ai_deaths", 1);
    }
    util::wait_network_frame();
    wait 0.1;
    if (isdefined(self)) {
        self delete();
        self notify(#"hash_70947625");
    }
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0xfae9d046, Offset: 0x1bf0
// Size: 0xea
function function_523cdc93(var_9e5eb4d9) {
    if (!isdefined(var_9e5eb4d9)) {
        var_9e5eb4d9 = 1;
    }
    if (isdefined(var_9e5eb4d9) && var_9e5eb4d9) {
        self waittill(#"damage", damage, attacker);
        self thread function_91b16538();
        self thread function_4ccc51b5();
    }
    if (isdefined(self)) {
        self clientfield::set("derez_ai_deaths", 1);
    }
    util::wait_network_frame();
    wait 0.25;
    if (isdefined(attacker) && isplayer(attacker)) {
        attacker thread namespace_36358f9c::function_8e9219f();
    }
    if (isdefined(self)) {
        self notify(#"hash_ed74b5db");
        self delete();
    }
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0xb741e1bf, Offset: 0x1ce8
// Size: 0x3b
function function_91b16538() {
    self endon(#"hash_ed74b5db");
    self waittill(#"start_ragdoll");
    wait 0.25;
    if (isdefined(self)) {
        self delete();
        self notify(#"hash_ed74b5db");
    }
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0x5c4b6779, Offset: 0x1d30
// Size: 0x4f
function function_4ccc51b5() {
    self endon(#"hash_ed74b5db");
    self waittill(#"actor_corpse", e_corpse);
    wait 0.25;
    if (isdefined(e_corpse)) {
        e_corpse delete();
    }
    if (isdefined(self)) {
        self notify(#"hash_ed74b5db");
    }
}

// Namespace newworld_util
// Params 3, eflags: 0x0
// Checksum 0x50e2424e, Offset: 0x1d88
// Size: 0x52
function function_52c5e321(str_flag, str_aigroup, n_count) {
    if (flag::get(str_flag)) {
        return;
    }
    level endon(str_flag);
    spawner::waittill_ai_group_ai_count(str_aigroup, int(n_count));
}

// Namespace newworld_util
// Params 7, eflags: 0x0
// Checksum 0x7e96436b, Offset: 0x1de8
// Size: 0x2da
function function_948d4091(var_81a32895, var_2380d5c, str_endon, b_looping, var_6e6341cf, var_8cb8bcef, var_9e68f294) {
    if (!isdefined(var_2380d5c)) {
        var_2380d5c = 0;
    }
    if (!isdefined(b_looping)) {
        b_looping = 1;
    }
    self endon(#"death");
    level endon(str_endon);
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    self flag::init(var_81a32895 + "_WW_opened");
    self flag::init(var_81a32895 + "_WW_closed");
    self flag::init(var_81a32895 + "_WW_tutorial");
    if (var_81a32895 == "cybercom_fireflyswarm") {
        var_bcb7a46f = %CP_MI_ZURICH_NEWWORLD_SELECT_FIREFLY_LINE_1;
    } else if (var_81a32895 == "cybercom_concussive") {
        var_bcb7a46f = %CP_MI_ZURICH_NEWWORLD_SELECT_CONCUSSIVE_WAVE_LINE_1;
    }
    self thread function_8531ac12(var_81a32895, str_endon);
    self thread function_b95b168e(var_81a32895, str_endon);
    if (isdefined(var_9e68f294)) {
        var_36b473ab = array(var_9e68f294, var_81a32895 + "_WW_tutorial");
        self flag::wait_till_any(var_36b473ab);
    }
    a_flags = array(var_81a32895 + "_WW_tutorial", var_81a32895 + "_WW_closed");
    while (!self flag::get(var_81a32895 + "_WW_tutorial")) {
        self function_c585d78f(var_81a32895, str_endon);
        self thread util::hide_hint_text(1);
        wait 0.5;
        while (!self flag::get(var_81a32895 + "_WW_tutorial") && self flag::get(var_81a32895 + "_WW_opened")) {
            self thread function_e5122074(var_bcb7a46f, str_endon);
            self flag::wait_till_any_timeout(4, a_flags);
            if (!self flag::get(var_81a32895 + "_WW_tutorial") && self flag::get(var_81a32895 + "_WW_opened")) {
                self flag::wait_till_any_timeout(3, a_flags);
            }
        }
        self thread function_d81a8f6f();
    }
    self thread function_6062e90(var_81a32895, var_2380d5c, str_endon, b_looping, var_6e6341cf, undefined, var_8cb8bcef);
}

// Namespace newworld_util
// Params 2, eflags: 0x0
// Checksum 0x492bbf8e, Offset: 0x20d0
// Size: 0x115
function function_c585d78f(var_81a32895, str_endon) {
    self endon(#"death");
    level endon(str_endon);
    self endon(var_81a32895 + "_WW_opened");
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    self util::hide_hint_text(1);
    while (!self flag::get(var_81a32895 + "_WW_opened")) {
        self thread util::show_hint_text(%CP_MI_ZURICH_NEWWORLD_OPEN_CYBERCORE_ABILITY_WHEEL, 0, undefined, 4);
        self flag::wait_till_timeout(4, var_81a32895 + "_WW_opened");
        if (!self flag::get(var_81a32895 + "_WW_opened")) {
            self flag::wait_till_timeout(3, var_81a32895 + "_WW_opened");
        }
    }
}

// Namespace newworld_util
// Params 2, eflags: 0x0
// Checksum 0xbafeca7d, Offset: 0x21f0
// Size: 0x92
function function_e5122074(var_bcb7a46f, str_endon) {
    self endon(#"death");
    self endon(str_endon);
    self.var_bb5e2d77 = self openluimenu("CyberComTutorial");
    self setluimenudata(self.var_bb5e2d77, "tutorial_line_1", var_bcb7a46f);
    self setluimenudata(self.var_bb5e2d77, "tutorial_line_2", %CP_MI_ZURICH_NEWWORLD_EQUIP_CYBERCORE);
    wait 4;
    self thread function_d81a8f6f();
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0xa2fdc0a9, Offset: 0x2290
// Size: 0x52
function function_d81a8f6f() {
    self endon(#"death");
    if (isdefined(self.var_bb5e2d77)) {
        lui::play_animation(self.var_bb5e2d77, "fadeout");
        wait 0.1;
        self closeluimenu(self.var_bb5e2d77);
    }
}

// Namespace newworld_util
// Params 2, eflags: 0x0
// Checksum 0xdc8088e2, Offset: 0x22f0
// Size: 0xfd
function function_8531ac12(var_81a32895, str_endon) {
    self endon(#"death");
    level endon(str_endon);
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    while (!self flag::get(var_81a32895 + "_WW_tutorial")) {
        self waittill(#"menuresponse", menu, response);
        var_66700f08 = strtok(response, ",");
        if (var_66700f08[0] == "opened") {
            self flag::set(var_81a32895 + "_WW_opened");
            self flag::clear(var_81a32895 + "_WW_closed");
        }
    }
}

// Namespace newworld_util
// Params 2, eflags: 0x0
// Checksum 0x7e1b76f2, Offset: 0x23f8
// Size: 0x115
function function_b95b168e(var_81a32895, str_endon) {
    self endon(#"death");
    level endon(str_endon);
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    while (true) {
        self waittill(#"menuresponse", menu, response);
        var_66700f08 = strtok(response, ",");
        if (var_66700f08[0] == "opened") {
            continue;
        }
        if (var_66700f08[0] == var_81a32895) {
            self flag::set(var_81a32895 + "_WW_tutorial");
            break;
        }
        self flag::clear(var_81a32895 + "_WW_opened");
        self flag::set(var_81a32895 + "_WW_closed");
    }
}

// Namespace newworld_util
// Params 8, eflags: 0x0
// Checksum 0x9ee2b881, Offset: 0x2518
// Size: 0x2d5
function function_6062e90(var_81a32895, var_2380d5c, str_endon, b_looping, var_6e6341cf, var_e8551372, var_9e68f294, var_3945b2c8) {
    if (!isdefined(var_2380d5c)) {
        var_2380d5c = 0;
    }
    if (!isdefined(b_looping)) {
        b_looping = 1;
    }
    self endon(#"death");
    if (isarray(str_endon)) {
        foreach (var_9dcbe8f4 in str_endon) {
            level endon(var_9dcbe8f4);
        }
    } else {
        level endon(str_endon);
    }
    if (isdefined(var_3945b2c8)) {
        self endon(var_3945b2c8);
    }
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    self gadgetpowerset(0, 100);
    self gadgetpowerset(1, 100);
    var_279df5c8 = 0;
    if (var_81a32895 == "cybercom_fireflyswarm" || var_81a32895 == "cybercom_rapidstrike" || var_81a32895 == "cybercom_concussive") {
        var_279df5c8 = 1;
    }
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    if (!self flag::exists(var_81a32895 + "_use_ability_tutorial")) {
        self flag::init(var_81a32895 + "_use_ability_tutorial");
    } else {
        self flag::clear(var_81a32895 + "_use_ability_tutorial");
    }
    self thread function_a7a2da7e(var_81a32895, var_2380d5c, str_endon);
    if (isdefined(var_9e68f294)) {
        if (isfloat(var_9e68f294) || isint(var_9e68f294)) {
            n_wait = var_9e68f294;
            wait n_wait;
        } else if (self flag::exists(var_9e68f294)) {
            self flag::wait_till(var_9e68f294);
        } else if (level flag::exists(var_9e68f294)) {
            level flag::wait_till(var_9e68f294);
        }
    }
    while (!self flag::get(var_81a32895 + "_use_ability_tutorial")) {
        self function_c60fae50(var_81a32895, str_endon, b_looping, var_6e6341cf);
        if (!var_279df5c8) {
            self function_5dca74fc(var_81a32895, str_endon, var_e8551372);
        }
    }
}

// Namespace newworld_util
// Params 4, eflags: 0x0
// Checksum 0x8d12cbb6, Offset: 0x27f8
// Size: 0x18d
function function_c60fae50(var_81a32895, str_endon, b_looping, var_f069395f) {
    self endon(#"death");
    if (isarray(str_endon)) {
        foreach (var_9dcbe8f4 in str_endon) {
            level endon(var_9dcbe8f4);
        }
    } else {
        level endon(str_endon);
    }
    self endon(var_81a32895 + "_primed");
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    while (!self flag::get(var_81a32895 + "_use_ability_tutorial")) {
        if (isdefined(var_f069395f)) {
            self thread util::show_hint_text(var_f069395f, 0, undefined, 4);
        } else {
            self thread util::show_hint_text(%CP_MI_ZURICH_NEWWORLD_USE_CYBERCORE, 0, undefined, 4);
        }
        if (b_looping === 1) {
            if (!self flag::get(var_81a32895 + "_use_ability_tutorial")) {
                self flag::wait_till_timeout(3, var_81a32895 + "_use_ability_tutorial");
            }
            continue;
        }
        break;
    }
}

// Namespace newworld_util
// Params 3, eflags: 0x0
// Checksum 0xaa2b55fb, Offset: 0x2990
// Size: 0x14d
function function_5dca74fc(var_81a32895, str_endon, var_e8551372) {
    self endon(#"death");
    if (isarray(str_endon)) {
        foreach (var_9dcbe8f4 in str_endon) {
            level endon(var_9dcbe8f4);
        }
    } else {
        level endon(str_endon);
    }
    self endon(var_81a32895 + "_off");
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    self util::hide_hint_text(1);
    while (!self flag::get(var_81a32895 + "_use_ability_tutorial")) {
        level waittill(#"ccom_locked_on", ent, e_player);
        if (e_player == self) {
            self function_e52b73c0(var_81a32895, str_endon, var_e8551372);
        }
    }
}

// Namespace newworld_util
// Params 3, eflags: 0x0
// Checksum 0xa47833b7, Offset: 0x2ae8
// Size: 0x15a
function function_e52b73c0(var_81a32895, str_endon, var_f069395f) {
    self endon(#"death");
    if (isarray(str_endon)) {
        foreach (var_9dcbe8f4 in str_endon) {
            level endon(var_9dcbe8f4);
        }
    } else {
        level endon(str_endon);
    }
    self endon(var_81a32895 + "_off");
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    self endon(#"hash_5e2557e1");
    self thread function_e84823a9(var_81a32895, str_endon);
    wait 0.8;
    self util::show_hint_text(var_f069395f, 0, undefined, 4);
    if (!self flag::get(var_81a32895 + "_use_ability_tutorial")) {
        self flag::wait_till_timeout(3, var_81a32895 + "_use_ability_tutorial");
    }
}

// Namespace newworld_util
// Params 2, eflags: 0x0
// Checksum 0x3709538e, Offset: 0x2c50
// Size: 0x147
function function_e84823a9(var_81a32895, str_endon) {
    self endon(#"death");
    if (isarray(str_endon)) {
        foreach (var_9dcbe8f4 in str_endon) {
            level endon(var_9dcbe8f4);
        }
    } else {
        level endon(str_endon);
    }
    self endon(var_81a32895 + "_off");
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    while (true) {
        level waittill(#"ccom_lost_lock", ent, e_player);
        if (e_player == self) {
            if (isdefined(self.cybercom) && self.cybercom.var_d1460543.size < 1) {
                self notify(#"hash_5e2557e1");
                self util::hide_hint_text(1);
                return;
            }
        }
    }
}

// Namespace newworld_util
// Params 3, eflags: 0x0
// Checksum 0xe17c2306, Offset: 0x2da0
// Size: 0x14a
function function_a7a2da7e(var_81a32895, var_2380d5c, str_endon) {
    if (!isdefined(var_2380d5c)) {
        var_2380d5c = 0;
    }
    self endon(#"death");
    if (isarray(str_endon)) {
        foreach (var_9dcbe8f4 in str_endon) {
            level endon(var_9dcbe8f4);
        }
    } else {
        level endon(str_endon);
    }
    if (isdefined(30)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(30, "timeout");
    }
    weapon = function_71840183(var_81a32895, var_2380d5c);
    self waittill(weapon.name + "_fired");
    self flag::set(var_81a32895 + "_use_ability_tutorial");
    level notify(var_81a32895 + "_use_ability_tutorial");
    self util::hide_hint_text(1);
}

// Namespace newworld_util
// Params 2, eflags: 0x0
// Checksum 0xa539e482, Offset: 0x2ef8
// Size: 0x6a
function function_71840183(var_81a32895, var_2380d5c) {
    if (!isdefined(var_2380d5c)) {
        var_2380d5c = 0;
    }
    weapon = undefined;
    ability = namespace_d00ec32::function_85c33215(var_81a32895);
    if (var_2380d5c == 1) {
        weapon = ability.var_b3a36101;
    } else {
        weapon = ability.weapon;
    }
    return weapon;
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0x14916a2e, Offset: 0x2f70
// Size: 0xd5
function function_2e7b4007() {
    self endon(#"death");
    level endon(#"underground_combat_complete");
    self.var_8a320fc6 = 0;
    var_6d5d984c = function_71840183("cybercom_immolation");
    var_bb989cf4 = var_6d5d984c.name + "_fired";
    var_239727aa = function_71840183("cybercom_fireflyswarm", 1);
    var_aa2f1c54 = var_239727aa.name + "_fired";
    self thread function_6851db33(var_6d5d984c, var_239727aa);
    while (true) {
        self util::waittill_any(var_bb989cf4, var_aa2f1c54);
        self notify(#"cc_ability_used");
        self.var_8a320fc6++;
    }
}

// Namespace newworld_util
// Params 2, eflags: 0x0
// Checksum 0x34470c3f, Offset: 0x3050
// Size: 0xe1
function function_6851db33(var_3283f77e, var_239727aa) {
    self endon(#"death");
    level endon(#"underground_combat_complete");
    while (true) {
        wait 90;
        if (self.var_8a320fc6 < 1) {
            self notify(#"hash_6851db33");
            if (self._gadgets_player[0] === var_3283f77e) {
                self thread function_6062e90("cybercom_immolation", 0, "underground_combat_complete", 1, "CP_MI_ZURICH_NEWWORLD_IMMOLATION_TARGET", "CP_MI_ZURICH_NEWWORLD_IMMOLATION_RELEASE");
            } else if (self._gadgets_player[0] === var_239727aa) {
                self thread function_6062e90("cybercom_fireflyswarm", 1, "underground_combat_complete", 1, "CP_MI_ZURICH_NEWWORLD_FIREFLY_SWARM_TUTORIAL");
            }
            self util::waittill_any_timeout(4, "cc_ability_used");
            self thread util::hide_hint_text(1);
            continue;
        }
        return;
    }
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0xaad667d1, Offset: 0x3140
// Size: 0x99
function function_70176ad6() {
    self endon(#"death");
    if (self function_c633d8fe()) {
        return;
    }
    if (!isdefined(self.var_98bf72c3)) {
        self.var_98bf72c3 = 0;
    }
    while (self.var_98bf72c3 < 3) {
        self waittill(#"gadget_denied_activation", n_slot, var_2de327e8);
        if (var_2de327e8 == 1) {
            self.var_98bf72c3++;
            self util::show_hint_text(%CP_MI_ZURICH_NEWWORLD_CYBERCOM_RECHARGE, 0, undefined, 4);
            level notify(#"hash_76cbcc2f");
            wait 30;
        }
    }
}

// Namespace newworld_util
// Params 2, eflags: 0x0
// Checksum 0xaf4ee3f5, Offset: 0x31e8
// Size: 0x57
function function_520255e3(str_trigger, time) {
    str_notify = "mufc_" + str_trigger;
    level thread function_901793d(str_trigger, str_notify);
    level thread function_2ffbaa00(time, str_notify);
    level waittill(str_notify);
}

// Namespace newworld_util
// Params 2, eflags: 0x0
// Checksum 0xa68ef658, Offset: 0x3248
// Size: 0x4a
function function_901793d(str_trigger, str_notify) {
    level endon(str_notify);
    e_trigger = getent(str_trigger, "targetname");
    if (isdefined(e_trigger)) {
        e_trigger waittill(#"trigger");
    }
    level notify(str_notify);
}

// Namespace newworld_util
// Params 2, eflags: 0x0
// Checksum 0xd5cc20f0, Offset: 0x32a0
// Size: 0x1e
function function_2ffbaa00(time, str_notify) {
    level endon(str_notify);
    wait time;
    level notify(str_notify);
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0x4d373846, Offset: 0x32c8
// Size: 0x59
function function_f29e6c6d(var_7daa2a51) {
    a_spawners = getentarray(var_7daa2a51, "targetname");
    for (i = 0; i < a_spawners.size; i++) {
        a_spawners[i] thread function_9a829e81();
    }
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0x4b9e1b2e, Offset: 0x3330
// Size: 0x102
function function_9a829e81() {
    if (isdefined(self.script_delay)) {
        wait self.script_delay;
    }
    e_ent = self spawner::spawn();
    e_ent endon(#"death");
    if (isdefined(e_ent.script_noteworthy) && e_ent.script_noteworthy == "rusher_on_spawn") {
        e_ent ai::set_behavior_attribute("move_mode", "rusher");
        e_ent ai::set_behavior_attribute("sprint", 1);
    }
    if (isdefined(e_ent.target)) {
        e_ent waittill(#"goal");
    }
    if (isdefined(e_ent.script_noteworthy) && e_ent.script_noteworthy == "rusher_at_goal") {
        e_ent ai::set_behavior_attribute("move_mode", "rusher");
        e_ent ai::set_behavior_attribute("sprint", 1);
    }
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0xdc9dd4a3, Offset: 0x3440
// Size: 0x79
function function_68b8f4af(e_volume) {
    a_ai = getaiteamarray("axis");
    a_touching = [];
    for (i = 0; i < a_ai.size; i++) {
        if (a_ai[i] istouching(e_volume)) {
            a_touching[a_touching.size] = a_ai[i];
        }
    }
    return a_touching;
}

// Namespace newworld_util
// Params 4, eflags: 0x0
// Checksum 0x877bc93f, Offset: 0x34c8
// Size: 0x129
function function_c478189b(str_trigger, var_390543cc, var_9d774f5d, max_guys) {
    if (isdefined(str_trigger)) {
        e_trigger = getent(str_trigger, "targetname");
        e_trigger waittill(#"trigger");
    }
    var_441bd962 = getent(var_390543cc, "targetname");
    var_ee2fd889 = getent(var_9d774f5d, "targetname");
    a_ai = getaiteamarray("axis");
    if (!isdefined(max_guys)) {
        max_guys = a_ai.size;
    }
    if (max_guys > a_ai.size) {
        max_guys = a_ai.size;
    }
    for (i = 0; i < max_guys; i++) {
        e_ent = a_ai[i];
        if (e_ent istouching(var_441bd962)) {
            e_ent setgoalvolume(var_ee2fd889);
        }
    }
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0x4b07b3fc, Offset: 0x3600
// Size: 0x7e
function function_f5363f47(str_trigger) {
    a_triggers = getentarray(str_trigger, "targetname");
    str_notify = str_trigger + "_waiting";
    for (i = 0; i < a_triggers.size; i++) {
        level thread function_7eb8a7ab(a_triggers[i], str_notify);
    }
    level waittill(str_notify);
}

// Namespace newworld_util
// Params 2, eflags: 0x0
// Checksum 0x4a024b49, Offset: 0x3688
// Size: 0x26
function function_7eb8a7ab(e_trigger, str_notify) {
    level endon(str_notify);
    e_trigger waittill(#"trigger");
    level notify(str_notify);
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0x33aa952c, Offset: 0x36b8
// Size: 0x69
function function_fcb42941(e_volume) {
    a_players = getplayers();
    var_f04bd8f5 = 0;
    for (i = 0; i < a_players.size; i++) {
        if (a_players[i] istouching(e_volume)) {
            var_f04bd8f5++;
        }
    }
    return var_f04bd8f5;
}

// Namespace newworld_util
// Params 9, eflags: 0x0
// Checksum 0x233b1741, Offset: 0x3730
// Size: 0x32d
function function_e0fb6da9(str_struct, close_dist, var_376aa7b3, var_fa069c9d, var_d1b83750, max_ai, var_a70db4af, var_1813646e, var_98e9bc46) {
    a_players = getplayers();
    if (a_players.size > 1) {
        return;
    }
    s_struct = struct::get(str_struct, "targetname");
    var_37124366 = getent(var_1813646e, "targetname");
    var_7d22b48e = getent(var_98e9bc46, "targetname");
    v_forward = anglestoforward(s_struct.angles);
    s_struct.start_time = undefined;
    num_charges = 0;
    wait_time = randomintrange(var_376aa7b3, var_fa069c9d);
    while (true) {
        e_player = getplayers()[0];
        v_dir = s_struct.origin - e_player.origin;
        var_989d1f7c = vectordot(v_dir, v_forward);
        if (var_989d1f7c < -100) {
            return;
        }
        dist = distance(s_struct.origin, e_player.origin);
        if (dist < close_dist) {
            if (!isdefined(s_struct.start_time)) {
                s_struct.start_time = gettime();
            }
        } else {
            s_struct.start_time = undefined;
        }
        if (isdefined(s_struct.start_time)) {
            time = gettime();
            dt = (time - s_struct.start_time) / 1000;
            if (dt > wait_time) {
                a_ai = getaiteamarray("axis");
                a_touching = [];
                for (i = 0; i < a_ai.size; i++) {
                    e_ent = a_ai[i];
                    if (!isdefined(e_ent.var_db552f4)) {
                        if (e_ent istouching(var_37124366)) {
                            a_touching[a_touching.size] = e_ent;
                        }
                    }
                }
                var_d6f9eed8 = randomintrange(var_d1b83750, max_ai + 1);
                if (var_d6f9eed8 > a_touching.size) {
                    var_d6f9eed8 = a_touching.size;
                }
                for (i = 0; i < var_d6f9eed8; i++) {
                    a_touching[i] setgoal(var_7d22b48e);
                    a_touching[i].var_db552f4 = 1;
                }
                s_struct.start_time = undefined;
                num_charges++;
                if (num_charges >= var_a70db4af) {
                    return;
                }
                wait_time = randomintrange(var_376aa7b3, var_fa069c9d);
            }
        }
        wait 0.05;
    }
}

// Namespace newworld_util
// Params 3, eflags: 0x0
// Checksum 0x3c344ffc, Offset: 0x3a68
// Size: 0x101
function function_8f7b1e06(str_trigger, var_390543cc, var_9d774f5d) {
    if (isdefined(str_trigger)) {
        e_trigger = getent(str_trigger, "targetname");
        e_trigger waittill(#"trigger");
    }
    var_441bd962 = getent(var_390543cc, "targetname");
    var_ee2fd889 = getent(var_9d774f5d, "targetname");
    a_ai = getaiteamarray("axis");
    for (i = 0; i < a_ai.size; i++) {
        e_ent = a_ai[i];
        if (e_ent istouching(var_441bd962)) {
            e_ent setgoalvolume(var_ee2fd889);
        }
    }
}

// Namespace newworld_util
// Params 4, eflags: 0x0
// Checksum 0x9177b13c, Offset: 0x3b78
// Size: 0xe1
function function_bccc2e65(str_aigroup, var_6ec47843, str_node, goal_radius) {
    spawner::waittill_ai_group_ai_count("aig_water_treatment", var_6ec47843);
    nd_node = getnode(str_node, "targetname");
    a_ai = getentarray(str_aigroup, "script_aigroup");
    for (i = 0; i < a_ai.size; i++) {
        e_ent = a_ai[i];
        if (issentient(e_ent)) {
            e_ent.goalradius = goal_radius;
            e_ent setgoal(nd_node.origin);
        }
    }
}

// Namespace newworld_util
// Params 3, eflags: 0x0
// Checksum 0x9dc62407, Offset: 0x3c68
// Size: 0x62
function function_eaf9c027(var_6d8a08b3, var_e0017db3, var_43656dbb) {
    if (!isdefined(var_e0017db3)) {
        var_e0017db3 = "fullscreen";
    }
    if (!isdefined(var_43656dbb)) {
        var_43656dbb = 0;
    }
    if (!isdefined(var_e0017db3)) {
        var_e0017db3 = "fullscreen";
    }
    level function_dd048f8d(var_6d8a08b3, var_e0017db3, var_43656dbb);
}

// Namespace newworld_util
// Params 3, eflags: 0x0
// Checksum 0x4fdf5541, Offset: 0x3cd8
// Size: 0x113
function function_dd048f8d(var_6d8a08b3, var_e0017db3, var_43656dbb) {
    if (!isdefined(var_e0017db3)) {
        var_e0017db3 = "fullscreen";
    }
    if (var_43656dbb) {
        foreach (player in level.players) {
            player clientfield::increment_to_player("postfx_futz", 1);
        }
    }
    lui::play_movie(var_6d8a08b3, var_e0017db3);
    if (var_43656dbb) {
        foreach (player in level.players) {
            player clientfield::increment_to_player("postfx_futz", 1);
        }
    }
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0x2f746abd, Offset: 0x3df8
// Size: 0x1aa
function function_30ec5bf7(var_74cd64bc) {
    if (!isdefined(var_74cd64bc)) {
        var_74cd64bc = 0;
    }
    if (var_74cd64bc) {
        level flag::set("infinite_white_transition");
        function_c07e7f7d(1);
        util::screen_fade_out(0, "white", "infinite_white");
    } else {
        level flag::wait_till("infinite_white_transition");
        lui::prime_movie("cp_newworld_fs_whiteinfinite", 1);
        function_c07e7f7d(1);
        util::screen_fade_out(0.5, "white", "infinite_white");
        level thread lui::play_movie("cp_newworld_fs_whiteinfinite", "fullscreen", 0, 1);
    }
    level flag::wait_till_clear("infinite_white_transition");
    foreach (e_player in level.activeplayers) {
        e_player notify(#"menuresponse", "FullscreenMovie", "finished_movie_playback");
    }
    util::screen_fade_in(0.5, "white", "infinite_white");
    function_c07e7f7d(0);
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0x46fe74a1, Offset: 0x3fb0
// Size: 0x75
function function_43dfaf16(a_ents) {
    foreach (player in level.activeplayers) {
        player notify(#"menuresponse", "FullscreenMovie", "finished_movie_playback");
    }
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0x9b73c0bc, Offset: 0x4030
// Size: 0xa3
function function_c07e7f7d(var_a5efd39d) {
    if (!isdefined(var_a5efd39d)) {
        var_a5efd39d = 1;
    }
    foreach (player in level.activeplayers) {
        if (var_a5efd39d) {
            player enableinvulnerability();
        } else {
            player disableinvulnerability();
        }
        player util::freeze_player_controls(var_a5efd39d);
    }
}

// Namespace newworld_util
// Params 6, eflags: 0x0
// Checksum 0x4eba0e63, Offset: 0x40e0
// Size: 0x158
function function_16dd8c5f(var_d72a94c2, str_type, str_hint, var_8baec92b, var_2df3d133, var_d78830f5) {
    if (!isdefined(str_type)) {
        str_type = %cp_level_newworld_access_door;
    }
    if (!isdefined(str_hint)) {
        str_hint = %CP_MI_ZURICH_NEWWORLD_HACK;
    }
    if (!isdefined(var_d78830f5)) {
        var_d78830f5 = 0;
    }
    t_interact = getent(var_d72a94c2, "targetname");
    t_interact triggerenable(1);
    if (isdefined(var_8baec92b)) {
        var_69f96d87 = getentarray(var_8baec92b, "targetname");
    } else {
        var_69f96d87 = [];
    }
    if (!var_d78830f5) {
        var_dcf4cbb0 = util::function_14518e76(t_interact, str_type, str_hint, &function_e27a8082, var_69f96d87);
        var_dcf4cbb0.var_2df3d133 = var_2df3d133;
        level waittill(var_2df3d133, e_player);
    } else {
        t_interact hacking::function_68df65d8(1, str_type, str_hint, undefined, var_69f96d87);
        t_interact hacking::trigger_wait();
    }
    if (isdefined(var_2df3d133)) {
        level notify(var_2df3d133);
    }
    if (isdefined(e_player)) {
        return e_player;
    }
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0x2408dc3a, Offset: 0x4240
// Size: 0x27
function function_e27a8082(e_player) {
    self gameobjects::disable_object();
    level notify(self.var_2df3d133, e_player);
}

// Namespace newworld_util
// Params 2, eflags: 0x0
// Checksum 0x2ba0d3f, Offset: 0x4270
// Size: 0x133
function function_39c9b63e(b_enable, var_98011344) {
    if (!isdefined(b_enable)) {
        b_enable = 1;
    }
    var_cb82ab70 = getentarray("ammo_cache", "script_noteworthy");
    foreach (var_dee1c358 in var_cb82ab70) {
        if (var_dee1c358.script_objective === var_98011344 || isdefined(var_dee1c358.gameobject) && !isdefined(var_98011344)) {
            if (!b_enable) {
                var_dee1c358 oed::disable_thermal();
                var_dee1c358 oed::function_14ec2d71();
                var_dee1c358.gameobject gameobjects::disable_object();
                continue;
            }
            var_dee1c358.gameobject gameobjects::enable_object();
            var_dee1c358 oed::enable_thermal();
            var_dee1c358 oed::function_e228c18a();
        }
    }
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0x3a4b18e, Offset: 0x43b0
// Size: 0xb2
function function_95132241() {
    self endon(#"death");
    var_2540d664 = 0;
    while (var_2540d664 == 0) {
        wait 1;
        foreach (e_player in level.activeplayers) {
            if (e_player util::is_player_looking_at(self.origin) == 0) {
                var_2540d664 = 1;
                continue;
            }
            var_2540d664 = 0;
        }
    }
    self kill();
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0xb6e047f, Offset: 0x4470
// Size: 0x102
function function_c1c980d8(str_trigger) {
    a_enemies = getaiteamarray("axis");
    t_trigger = getent(str_trigger, "targetname");
    assert(isdefined(t_trigger), "<dev string:x4d>");
    foreach (enemy in a_enemies) {
        if (isalive(enemy) && enemy istouching(t_trigger)) {
            enemy thread function_95132241();
        }
    }
    t_trigger delete();
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0xf9dee767, Offset: 0x4580
// Size: 0x7a
function function_c949a8ed(var_b06baa1b) {
    if (!isdefined(var_b06baa1b)) {
        var_b06baa1b = 0;
    }
    self thread function_e44cc74b(var_b06baa1b);
    self playsound("evt_ai_derez");
    if (var_b06baa1b) {
        self clientfield::increment("cs_rez_in_fx", 2);
        return;
    }
    self clientfield::increment("cs_rez_in_fx", 1);
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0x5f8b6191, Offset: 0x4608
// Size: 0x13a
function function_e44cc74b(var_b06baa1b) {
    self endon(#"death");
    if (var_b06baa1b) {
        if (self.animname == "hall") {
            self setmodel("c_hro_sarah_salvation_reveal");
        } else if (!(isdefined(self.isdying) && self.isdying)) {
            self setmodel("c_hro_" + self.animname + "_base_rev");
        }
        util::wait_network_frame();
        self show();
        wait 0.5;
        if (self.animname == "hall") {
            self setmodel("c_hro_sarah_base");
        } else if (!(isdefined(self.isdying) && self.isdying)) {
            self setmodel("c_hro_" + self.animname + "_base");
        }
        return;
    }
    wait 0.4;
    self show();
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0xcfd58088, Offset: 0x4750
// Size: 0x7a
function function_4943984c(var_b06baa1b) {
    if (!isdefined(var_b06baa1b)) {
        var_b06baa1b = 0;
    }
    self thread function_9ab5a5ab(var_b06baa1b);
    self playsound("evt_ai_derez");
    if (var_b06baa1b) {
        self clientfield::increment("cs_rez_out_fx", 2);
        return;
    }
    self clientfield::increment("cs_rez_out_fx", 1);
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0xa622d7fc, Offset: 0x47d8
// Size: 0x12a
function function_9ab5a5ab(var_b06baa1b) {
    self endon(#"death");
    if (var_b06baa1b) {
        if (self.animname == "hall") {
            self setmodel("c_hro_sarah_salvation_reveal");
        } else if (!(isdefined(self.isdying) && self.isdying)) {
            self setmodel("c_hro_" + self.animname + "_base_rev");
        }
        wait 0.5;
        self ghost();
        if (self.animname == "hall") {
            self setmodel("c_hro_sarah_base");
        } else if (!(isdefined(self.isdying) && self.isdying)) {
            self setmodel("c_hro_" + self.animname + "_base");
        }
        return;
    }
    wait 0.4;
    self ghost();
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0xfe9f3446, Offset: 0x4910
// Size: 0x62
function function_d0aa2f4f(n_delay) {
    if (!isdefined(n_delay)) {
        n_delay = 0.25;
    }
    self endon(#"death");
    self function_4943984c();
    wait 0.4;
    self util::delay(n_delay, undefined, &function_c949a8ed);
}

// Namespace newworld_util
// Params 2, eflags: 0x0
// Checksum 0x1abf945, Offset: 0x4980
// Size: 0xea
function function_737d2864(str_location, var_f67e0ce6) {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    self endon(#"death");
    wait 3;
    self.var_55167309 = self openluimenu("LocationAndTime");
    self setluimenudata(self.var_55167309, "loctime_location", str_location);
    self setluimenudata(self.var_55167309, "loctime_date", var_f67e0ce6);
    wait 5;
    lui::play_animation(self.var_55167309, "fadeout");
    wait 1.3;
    self closeluimenu(self.var_55167309);
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0x8866dee9, Offset: 0x4a78
// Size: 0x61
function function_c633d8fe() {
    if (sessionmodeiscampaignzombiesgame()) {
        return 1;
    }
    assert(isplayer(self));
    return self getdstat("PlayerStatsByMap", "cp_mi_zurich_newworld", "hasBeenCompleted");
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0x98e18762, Offset: 0x4ae8
// Size: 0x7f
function function_81acf083() {
    var_ed60aa22 = 1;
    foreach (player in level.activeplayers) {
        if (!player function_c633d8fe()) {
            var_ed60aa22 = 0;
            break;
        }
    }
    return var_ed60aa22;
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0xbbab217d, Offset: 0x4b70
// Size: 0x7f
function function_70aba08e() {
    var_6a25d5b0 = 0;
    foreach (player in level.players) {
        if (player function_1a9006bd("cybercom_hijack")) {
            var_6a25d5b0 = 1;
            break;
        }
    }
    return var_6a25d5b0;
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0xafacb0de, Offset: 0x4bf8
// Size: 0x15a
function function_3e37f48b(b_enabled) {
    if (sessionmodeiscampaignzombiesgame()) {
        return;
    }
    level flag::wait_till("all_players_connected");
    if (b_enabled) {
        foreach (e_player in level.activeplayers) {
            if (e_player function_c633d8fe()) {
                continue;
            }
            level notify(#"enable_cybercom", e_player);
        }
        callback::remove_on_spawned(&function_d17cfcf8);
        return;
    }
    foreach (e_player in level.activeplayers) {
        if (e_player function_c633d8fe()) {
            continue;
        }
        level notify(#"disable_cybercom", e_player, 1);
    }
    callback::on_spawned(&function_d17cfcf8);
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0x21282f11, Offset: 0x4d60
// Size: 0x23
function function_d17cfcf8() {
    if (self function_c633d8fe()) {
        return;
    }
    level notify(#"disable_cybercom", self, 1);
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0xacec7178, Offset: 0x4d90
// Size: 0x7b
function function_3196eaee(b_enabled) {
    if (!isdefined(b_enabled)) {
        b_enabled = 1;
    }
    foreach (e_player in level.players) {
        e_player function_a7cfc593(b_enabled);
    }
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0xb91678ae, Offset: 0x4e18
// Size: 0x7b
function function_63c3869a(b_enabled) {
    if (!isdefined(b_enabled)) {
        b_enabled = 1;
    }
    foreach (e_player in level.players) {
        e_player function_ba1a260f(b_enabled);
    }
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0x45196925, Offset: 0x4ea0
// Size: 0x4a
function function_a7cfc593(b_enabled) {
    if (!isdefined(b_enabled)) {
        b_enabled = 1;
    }
    if (self function_c633d8fe()) {
        return;
    }
    self.var_1e983b11 = b_enabled;
    if (!b_enabled) {
        self oed::function_ffc82115(0);
    }
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0xc0ff7458, Offset: 0x4ef8
// Size: 0x7a
function function_ba1a260f(b_enabled) {
    if (!isdefined(b_enabled)) {
        b_enabled = 1;
    }
    if (self function_c633d8fe()) {
        return;
    }
    println("<dev string:x8a>" + b_enabled + "<dev string:xa0>" + level.var_d829fe9f);
    self.var_d829fe9f = b_enabled;
    if (!b_enabled) {
        self oed::function_35ce409(0);
    }
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0x13c1cb83, Offset: 0x4f80
// Size: 0x93
function function_2eded728(b_enabled) {
    if (!isdefined(b_enabled)) {
        b_enabled = 1;
    }
    if (b_enabled) {
        foreach (e_player in level.activeplayers) {
            e_player cybercom::function_f8669cbf(1);
            e_player clientfield::increment_to_player("hack_dni_fx");
        }
    }
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0xda48f31e, Offset: 0x5020
// Size: 0x5a
function scene_cleanup(str_scene_name) {
    if (scene::is_active(str_scene_name)) {
        scene::stop(str_scene_name, 1);
        util::wait_network_frame();
    }
    struct::function_368120a1("scene", str_scene_name);
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0xb03dc06f, Offset: 0x5088
// Size: 0x8d
function function_921d7387() {
    self endon(#"death");
    while (true) {
        level waittill(#"hash_921d7387");
        if (isdefined(self.var_30a16593) && self.var_30a16593) {
            continue;
        }
        wait 1;
        if (isdefined(self.is_talking) && self.is_talking) {
            continue;
        }
        self notify(#"hash_2605e152", "generic_encourage");
        self.var_30a16593 = 1;
        self thread function_9464547d();
    }
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0x76799a94, Offset: 0x5120
// Size: 0x16
function function_9464547d() {
    self endon(#"death");
    wait 30;
    self.var_30a16593 = 0;
}

// Namespace newworld_util
// Params 1, eflags: 0x0
// Checksum 0x9c3432ac, Offset: 0x5140
// Size: 0x47
function function_606dbca2(params) {
    if (self.team !== "axis") {
        return;
    }
    if (isplayer(params.eattacker)) {
        level notify(#"hash_921d7387");
    }
}

// Namespace newworld_util
// Params 0, eflags: 0x0
// Checksum 0xdeb6a3ae, Offset: 0x5190
// Size: 0x32
function function_83a7d040() {
    util::wait_network_frame();
    util::wait_network_frame();
    util::wait_network_frame();
}

