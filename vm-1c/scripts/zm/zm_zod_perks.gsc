#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_power;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_magicbox;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_util;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_bb738c6;

// Namespace namespace_bb738c6
// Params 0, eflags: 0x1 linked
// namespace_bb738c6<file_0>::function_c35e6aab
// Checksum 0xd342191d, Offset: 0x4f0
// Size: 0x1f4
function init() {
    clientfield::register("world", "perk_light_speed_cola", 1, 2, "int");
    clientfield::register("world", "perk_light_juggernog", 1, 2, "int");
    clientfield::register("world", "perk_light_doubletap", 1, 2, "int");
    clientfield::register("world", "perk_light_quick_revive", 1, 1, "int");
    clientfield::register("world", "perk_light_widows_wine", 1, 1, "int");
    clientfield::register("world", "perk_light_mule_kick", 1, 1, "int");
    clientfield::register("world", "perk_light_staminup", 1, 1, "int");
    clientfield::register("scriptmover", "perk_bottle_speed_cola_fx", 1, 1, "int");
    clientfield::register("scriptmover", "perk_bottle_juggernog_fx", 1, 1, "int");
    clientfield::register("scriptmover", "perk_bottle_doubletap_fx", 1, 1, "int");
    thread function_9a03e439();
}

// Namespace namespace_bb738c6
// Params 0, eflags: 0x1 linked
// namespace_bb738c6<file_0>::function_9a03e439
// Checksum 0xfac6088e, Offset: 0x6f0
// Size: 0x3f4
function function_9a03e439() {
    level.var_44ebf6d = 1;
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("zones_initialized");
    thread function_5508b348();
    thread function_4a2261fa();
    thread function_6753e7bb();
    thread function_55b919e6();
    var_58b16a23 = getentarray("random_perk_machine", "script_notify");
    a_s_random_perk_locs = struct::get_array("perk_random_machine_location", "targetname");
    foreach (var_5bca5a82 in var_58b16a23) {
        str_zone = zm_zonemgr::get_zone_from_position(var_5bca5a82.origin, 1);
        switch (str_zone) {
        case 20:
            n_loc = 1;
            break;
        case 19:
            n_loc = 2;
            break;
        case 21:
            n_loc = 3;
            break;
        }
        foreach (var_d2fb40be in a_s_random_perk_locs) {
            if (zm_zonemgr::get_zone_from_position(var_d2fb40be.origin, 1) == str_zone) {
                var_8de7611a = var_d2fb40be;
                break;
            }
        }
        arrayremovevalue(a_s_random_perk_locs, var_8de7611a);
        var_575e35b2 = struct::get(var_8de7611a.target, "targetname");
        var_bcc9fed = util::spawn_model("tag_origin", var_575e35b2.origin, (0, 0, 0));
        switch (var_5bca5a82.script_string) {
        case 24:
            thread function_e840e164(n_loc);
            var_bcc9fed thread clientfield::set("perk_bottle_speed_cola_fx", 1);
            break;
        case 23:
            thread function_588068b3(n_loc);
            var_bcc9fed thread clientfield::set("perk_bottle_juggernog_fx", 1);
            break;
        case 25:
            thread function_8b929f79(n_loc);
            var_bcc9fed thread clientfield::set("perk_bottle_doubletap_fx", 1);
            break;
        }
    }
}

// Namespace namespace_bb738c6
// Params 0, eflags: 0x1 linked
// namespace_bb738c6<file_0>::function_5508b348
// Checksum 0xe0fd8dca, Offset: 0xaf0
// Size: 0x2c
function function_5508b348() {
    level waittill(#"hash_a7912f12");
    clientfield::set("perk_light_quick_revive", 1);
}

// Namespace namespace_bb738c6
// Params 0, eflags: 0x1 linked
// namespace_bb738c6<file_0>::function_4a2261fa
// Checksum 0xb3fb7d4c, Offset: 0xb28
// Size: 0x2c
function function_4a2261fa() {
    level waittill(#"hash_609d22d4");
    clientfield::set("perk_light_widows_wine", 1);
}

// Namespace namespace_bb738c6
// Params 0, eflags: 0x1 linked
// namespace_bb738c6<file_0>::function_6753e7bb
// Checksum 0xc7000354, Offset: 0xb60
// Size: 0x2c
function function_6753e7bb() {
    level waittill(#"hash_62ee2b14");
    clientfield::set("perk_light_mule_kick", 1);
}

// Namespace namespace_bb738c6
// Params 0, eflags: 0x1 linked
// namespace_bb738c6<file_0>::function_55b919e6
// Checksum 0xbf64466, Offset: 0xb98
// Size: 0x34
function function_55b919e6() {
    level waittill(#"hash_ec4676f1");
    level clientfield::set("perk_light_staminup", 1);
}

// Namespace namespace_bb738c6
// Params 1, eflags: 0x1 linked
// namespace_bb738c6<file_0>::function_e840e164
// Checksum 0x7b9b9062, Offset: 0xbd8
// Size: 0x3c
function function_e840e164(var_d80a2da2) {
    level waittill(#"hash_2680d19f");
    level clientfield::set("perk_light_speed_cola", var_d80a2da2);
}

// Namespace namespace_bb738c6
// Params 1, eflags: 0x1 linked
// namespace_bb738c6<file_0>::function_588068b3
// Checksum 0x75b15369, Offset: 0xc20
// Size: 0x3c
function function_588068b3(var_d80a2da2) {
    level waittill(#"hash_ce46a7cd");
    level clientfield::set("perk_light_juggernog", var_d80a2da2);
}

// Namespace namespace_bb738c6
// Params 1, eflags: 0x1 linked
// namespace_bb738c6<file_0>::function_8b929f79
// Checksum 0xd8053f79, Offset: 0xc68
// Size: 0x3c
function function_8b929f79(var_d80a2da2) {
    level waittill(#"hash_bd00857f");
    level clientfield::set("perk_light_doubletap", var_d80a2da2);
}

