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
#using scripts/shared/exploder_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/demo_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_912a86f7;

// Namespace namespace_912a86f7
// Params 0, eflags: 0x1 linked
// Checksum 0xc2be8130, Offset: 0x450
// Size: 0x174
function init() {
    clientfield::register("world", "perk_light_doubletap", 5000, 1, "int");
    clientfield::register("world", "perk_light_juggernaut", 5000, 1, "int");
    clientfield::register("world", "perk_light_mule_kick", 5000, 1, "int");
    clientfield::register("world", "perk_light_quick_revive", 5000, 1, "int");
    clientfield::register("world", "perk_light_speed_cola", 5000, 1, "int");
    clientfield::register("world", "perk_light_staminup", 5000, 1, "int");
    clientfield::register("world", "perk_light_widows_wine", 5000, 1, "int");
    thread function_9a03e439();
    thread function_b5c4c30e();
}

// Namespace namespace_912a86f7
// Params 0, eflags: 0x1 linked
// Checksum 0x2898fd17, Offset: 0x5d0
// Size: 0xbc
function function_9a03e439() {
    level.var_44ebf6d = 1;
    level flag::wait_till("all_players_spawned");
    level flag::wait_till("zones_initialized");
    thread function_5508b348();
    thread function_4a2261fa();
    thread function_6753e7bb();
    thread function_55b919e6();
    thread function_e840e164();
    thread function_a41cf549();
    thread function_8b929f79();
}

// Namespace namespace_912a86f7
// Params 0, eflags: 0x1 linked
// Checksum 0x380ee4da, Offset: 0x698
// Size: 0x72
function function_b5c4c30e() {
    wait(1);
    level flag::wait_till("start_zombie_round_logic");
    wait(1);
    if (!level flag::get("solo_game")) {
        level flag::wait_till("power_on");
    }
    level notify(#"hash_a7912f12");
}

// Namespace namespace_912a86f7
// Params 0, eflags: 0x1 linked
// Checksum 0x83a9fdd1, Offset: 0x718
// Size: 0x9c
function function_5508b348() {
    level waittill(#"hash_a7912f12");
    exploder::exploder("lgt_vending_quick_revive_castle");
    clientfield::set("perk_light_quick_revive", 1);
    level flag::wait_till("solo_revive");
    exploder::exploder_stop("lgt_vending_quick_revive_castle");
    clientfield::set("perk_light_quick_revive", 0);
}

// Namespace namespace_912a86f7
// Params 0, eflags: 0x1 linked
// Checksum 0x788f0ae5, Offset: 0x7c0
// Size: 0x2c
function function_4a2261fa() {
    level waittill(#"hash_609d22d4");
    clientfield::set("perk_light_widows_wine", 1);
}

// Namespace namespace_912a86f7
// Params 0, eflags: 0x1 linked
// Checksum 0x80708ecb, Offset: 0x7f8
// Size: 0x2c
function function_6753e7bb() {
    level waittill(#"hash_62ee2b14");
    clientfield::set("perk_light_mule_kick", 1);
}

// Namespace namespace_912a86f7
// Params 0, eflags: 0x1 linked
// Checksum 0x1847f248, Offset: 0x830
// Size: 0x34
function function_55b919e6() {
    level waittill(#"hash_ec4676f1");
    level clientfield::set("perk_light_staminup", 1);
}

// Namespace namespace_912a86f7
// Params 0, eflags: 0x1 linked
// Checksum 0x51e79376, Offset: 0x870
// Size: 0x34
function function_e840e164() {
    level waittill(#"hash_2680d19f");
    level clientfield::set("perk_light_speed_cola", 1);
}

// Namespace namespace_912a86f7
// Params 0, eflags: 0x1 linked
// Checksum 0x5510f6a1, Offset: 0x8b0
// Size: 0x34
function function_a41cf549() {
    level waittill(#"hash_ce46a7cd");
    level clientfield::set("perk_light_juggernaut", 1);
}

// Namespace namespace_912a86f7
// Params 0, eflags: 0x1 linked
// Checksum 0x789fc7fb, Offset: 0x8f0
// Size: 0x34
function function_8b929f79() {
    level waittill(#"hash_bd00857f");
    level clientfield::set("perk_light_doubletap", 1);
}

