#using scripts/zm/zm_genesis_wasp;
#using scripts/zm/zm_genesis_vo;
#using scripts/zm/zm_genesis_util;
#using scripts/zm/zm_genesis_spiders;
#using scripts/zm/zm_genesis_shadowman;
#using scripts/zm/zm_genesis_power;
#using scripts/zm/zm_genesis_mechz;
#using scripts/zm/zm_genesis_keeper;
#using scripts/zm/zm_genesis_fx;
#using scripts/zm/zm_genesis_cleanup_mgr;
#using scripts/zm/zm_genesis_apothicon_fury;
#using scripts/zm/zm_genesis;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_shadow_zombie;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_light_zombie;
#using scripts/zm/_zm_elemental_zombies;
#using scripts/zm/_zm_genesis_spiders;
#using scripts/zm/_zm_ai_mechz;
#using scripts/zm/_zm_ai_margwa_no_idgun;
#using scripts/zm/_zm_ai_margwa_elemental;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/margwa;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_6929903c;

// Namespace namespace_6929903c
// Params 0, eflags: 0x2
// Checksum 0xc9782b84, Offset: 0x578
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_genesis_round_bosses", &__init__, undefined, undefined);
}

// Namespace namespace_6929903c
// Params 0, eflags: 0x0
// Checksum 0xf0124328, Offset: 0x5b8
// Size: 0x3c
function __init__() {
    level flag::init("can_spawn_margwa", 1);
    level thread function_755b4548();
}

// Namespace namespace_6929903c
// Params 0, eflags: 0x0
// Checksum 0x81f48886, Offset: 0x600
// Size: 0xf0
function function_755b4548() {
    level.var_b32a2aa0 = 0;
    level.var_ba0d6d40 = randomintrange(11, 13);
    while (true) {
        level waittill(#"between_round_over");
        if (level.round_number > level.var_ba0d6d40) {
            level.var_ba0d6d40 = level.round_number + 1;
        }
        if (level.round_number == level.var_ba0d6d40) {
            level.var_ba0d6d40 = level.round_number + randomintrange(7, 10);
            level thread function_c68599fd();
        }
        if (level.var_ba0d6d40 == level.var_783db6ab) {
            level.var_ba0d6d40 += 2;
        }
    }
}

// Namespace namespace_6929903c
// Params 0, eflags: 0x0
// Checksum 0x1e4a799, Offset: 0x6f8
// Size: 0x36e
function function_c68599fd() {
    level.var_b32a2aa0++;
    switch (level.var_b32a2aa0) {
    case 1:
        level thread spawn_boss("margwa");
        break;
    case 2:
        level thread spawn_boss("mechz");
        break;
    default:
        if (math::cointoss()) {
            level thread spawn_boss("margwa");
        } else {
            level thread spawn_boss("mechz");
        }
        break;
    }
    wait(1);
    a_players = getplayers();
    if (a_players.size == 1) {
        return;
    }
    switch (level.var_b32a2aa0) {
    case 1:
        break;
    case 2:
        if (a_players.size == 3) {
            spawn_boss("margwa");
        } else if (a_players.size == 4) {
            spawn_boss("margwa");
        }
        break;
    case 3:
        if (a_players.size == 2) {
            spawn_boss("mechz");
        } else if (a_players.size == 3) {
            spawn_boss("mechz");
            wait(1);
            spawn_boss("margwa");
        } else if (a_players.size == 4) {
            spawn_boss("mechz");
            wait(1);
            spawn_boss("margwa");
            wait(1);
            spawn_boss("margwa");
        }
        break;
    default:
        if (a_players.size == 1) {
            var_b3c4bbcc = 1;
        } else if (a_players.size == 2) {
            var_b3c4bbcc = 1;
        } else if (a_players.size == 3) {
            var_b3c4bbcc = 2;
        } else {
            var_b3c4bbcc = 3;
        }
        for (i = 0; i < var_b3c4bbcc; i++) {
            if (math::cointoss()) {
                spawn_boss("margwa");
            } else {
                spawn_boss("mechz");
            }
            wait(1);
        }
        break;
    }
}

// Namespace namespace_6929903c
// Params 2, eflags: 0x0
// Checksum 0x27a5f2dc, Offset: 0xa70
// Size: 0x244
function spawn_boss(str_enemy, v_pos) {
    s_loc = function_830cdf99();
    if (!isdefined(s_loc)) {
        return;
    }
    level thread namespace_c149ef1::function_79eeee03(str_enemy);
    if (str_enemy == "margwa") {
        if (math::cointoss()) {
            e_boss = namespace_3de4ab6f::function_75b161ab(undefined, s_loc);
        } else {
            e_boss = namespace_3de4ab6f::function_26efbc37(undefined, s_loc);
        }
        e_boss.var_26f9f957 = &function_26f9f957;
        level.var_95981590 = e_boss;
        level notify(#"hash_c484afcb");
        if (isdefined(e_boss)) {
            e_boss.b_ignore_cleanup = 1;
            n_health = level.round_number * 100 + 100;
            e_boss namespace_c96301ee::function_53ce09a(n_health);
        }
    } else if (str_enemy == "mechz") {
        if (isdefined(s_loc.script_string) && s_loc.script_string == "exterior") {
            e_boss = namespace_ef567265::function_53c37648(s_loc, 1);
        } else {
            e_boss = namespace_ef567265::function_53c37648(s_loc, 0);
        }
    }
    if (!isdefined(e_boss.maxhealth)) {
        e_boss.maxhealth = e_boss.health;
    }
    if (isdefined(v_pos)) {
        e_boss forceteleport(v_pos, e_boss.angles);
    }
    e_boss.var_953b581c = 1;
    return e_boss;
}

// Namespace namespace_6929903c
// Params 0, eflags: 0x0
// Checksum 0xe2cb723a, Offset: 0xcc0
// Size: 0x1ba
function function_830cdf99() {
    var_fffe05f0 = array::randomize(level.var_95810297);
    a_spawn_locs = [];
    for (i = 0; i < var_fffe05f0.size; i++) {
        s_loc = var_fffe05f0[i];
        str_zone = zm_zonemgr::get_zone_from_position(s_loc.origin, 1);
        if (isdefined(str_zone) && level.zones[str_zone].is_occupied) {
            a_spawn_locs[a_spawn_locs.size] = s_loc;
        }
    }
    if (a_spawn_locs.size == 0) {
        for (i = 0; i < var_fffe05f0.size; i++) {
            s_loc = var_fffe05f0[i];
            str_zone = zm_zonemgr::get_zone_from_position(s_loc.origin, 1);
            if (isdefined(str_zone) && level.zones[str_zone].is_active) {
                a_spawn_locs[a_spawn_locs.size] = s_loc;
            }
        }
    }
    if (a_spawn_locs.size > 0) {
        a_spawn_locs = array::randomize(a_spawn_locs);
        return a_spawn_locs[0];
    }
    return var_fffe05f0[0];
}

// Namespace namespace_6929903c
// Params 2, eflags: 0x0
// Checksum 0x814b8784, Offset: 0xe88
// Size: 0x2e
function function_26f9f957(var_9c967ca3, e_attacker) {
    if (zm_utility::is_player_valid(e_attacker)) {
    }
}

