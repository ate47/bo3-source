#using scripts/zm/zm_island_planting;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_pers_upgrades_functions;
#using scripts/zm/_zm_pers_upgrades;
#using scripts/zm/_zm_melee_weapon;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_blockers;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/codescripts/struct;

#namespace namespace_e37c032f;

// Namespace namespace_e37c032f
// Params 0, eflags: 0x2
// Checksum 0x8345bcdc, Offset: 0x468
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_powerup_island_seed", &__init__, undefined, undefined);
}

// Namespace namespace_e37c032f
// Params 0, eflags: 0x1 linked
// Checksum 0xcc4d1b10, Offset: 0x4a8
// Size: 0x154
function __init__() {
    register_clientfields();
    zm_powerups::register_powerup("island_seed", &function_6adb5862);
    if (tolower(getdvarstring("g_gametype")) != "zcleansed") {
        zm_powerups::add_zombie_powerup("island_seed", "p7_zm_isl_plant_seed_pod_01", %ZM_ISLAND_SEED_POWERUP, &function_f766ae15, 1, 0, 0);
    }
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    /#
        thread function_7b74396f();
    #/
    level.var_9895ed0d = 0;
    level.var_325c412f = 2;
    level thread function_b2cb89c1();
    level thread function_68329bc5();
}

// Namespace namespace_e37c032f
// Params 0, eflags: 0x1 linked
// Checksum 0x86fe3bc0, Offset: 0x608
// Size: 0xf4
function register_clientfields() {
    clientfield::register("toplayer", "has_island_seed", 1, 2, "int");
    clientfield::register("clientuimodel", "zmInventory.widget_seed_parts", 9000, 1, "int");
    clientfield::register("toplayer", "bucket_seed_01", 9000, 1, "int");
    clientfield::register("toplayer", "bucket_seed_02", 9000, 1, "int");
    clientfield::register("toplayer", "bucket_seed_03", 9000, 1, "int");
}

// Namespace namespace_e37c032f
// Params 1, eflags: 0x1 linked
// Checksum 0x41946a61, Offset: 0x708
// Size: 0xa4
function function_6adb5862(player) {
    var_f65b973 = player clientfield::get_to_player("has_island_seed");
    if (var_f65b973 < 3) {
        var_b5c360bd = var_f65b973 + 1;
        player clientfield::set_to_player("has_island_seed", var_b5c360bd);
        player function_3968a493(1);
        player notify(#"hash_97e69ab7");
    }
}

// Namespace namespace_e37c032f
// Params 1, eflags: 0x1 linked
// Checksum 0x351dfc28, Offset: 0x7b8
// Size: 0xcc
function function_58b6724f(player) {
    var_f65b973 = player clientfield::get_to_player("has_island_seed");
    if (var_f65b973 > 0) {
        var_b5c360bd = var_f65b973 - 1;
        player clientfield::set_to_player("has_island_seed", var_b5c360bd);
        player function_3968a493(1);
        player notify(#"hash_9d289b3a");
        println("toplayer");
        return true;
    }
    return false;
}

// Namespace namespace_e37c032f
// Params 1, eflags: 0x1 linked
// Checksum 0xa485fad, Offset: 0x890
// Size: 0x2a
function function_735cfef2(player) {
    return player clientfield::get_to_player("has_island_seed");
}

// Namespace namespace_e37c032f
// Params 1, eflags: 0x1 linked
// Checksum 0x9f0c26e8, Offset: 0x8c8
// Size: 0x44
function function_aeda54f6(var_f65b973) {
    self clientfield::set_to_player("has_island_seed", var_f65b973);
    self function_3968a493();
}

// Namespace namespace_e37c032f
// Params 1, eflags: 0x1 linked
// Checksum 0xa2610a2e, Offset: 0x918
// Size: 0x234
function function_3968a493(var_b89973c8) {
    if (!isdefined(var_b89973c8)) {
        var_b89973c8 = 0;
    }
    var_f65b973 = function_735cfef2(self);
    switch (var_f65b973) {
    case 0:
        self clientfield::set_to_player("bucket_seed_01", 0);
        self clientfield::set_to_player("bucket_seed_02", 0);
        self clientfield::set_to_player("bucket_seed_03", 0);
        break;
    case 1:
        self clientfield::set_to_player("bucket_seed_01", 1);
        self clientfield::set_to_player("bucket_seed_02", 0);
        self clientfield::set_to_player("bucket_seed_03", 0);
        break;
    case 2:
        self clientfield::set_to_player("bucket_seed_01", 1);
        self clientfield::set_to_player("bucket_seed_02", 1);
        self clientfield::set_to_player("bucket_seed_03", 0);
        break;
    case 3:
        self clientfield::set_to_player("bucket_seed_01", 1);
        self clientfield::set_to_player("bucket_seed_02", 1);
        self clientfield::set_to_player("bucket_seed_03", 1);
        break;
    }
    if (var_b89973c8) {
        self thread namespace_f37770c8::function_97be99b3(undefined, "zmInventory.widget_seed_parts", 0);
    }
}

// Namespace namespace_e37c032f
// Params 0, eflags: 0x1 linked
// Checksum 0x3db0a595, Offset: 0xb58
// Size: 0xe8
function function_f766ae15() {
    if (isdefined(level.var_b426c9) && level.var_b426c9) {
        return false;
    }
    n_count = 0;
    foreach (player in level.activeplayers) {
        n_count += player clientfield::get_to_player("has_island_seed");
    }
    if (n_count == level.activeplayers.size * 3) {
        return false;
    }
    return true;
}

// Namespace namespace_e37c032f
// Params 0, eflags: 0x1 linked
// Checksum 0x2a0da4fa, Offset: 0xc48
// Size: 0x28
function function_68329bc5() {
    while (true) {
        level waittill(#"between_round_over");
        level.var_9895ed0d = 0;
    }
}

// Namespace namespace_e37c032f
// Params 0, eflags: 0x1 linked
// Checksum 0x88a92149, Offset: 0xc78
// Size: 0x9c
function function_b2cb89c1() {
    level flag::init("round_1_seed_spawned");
    level.var_e964b72 = 0;
    level.var_805d0ecc = &function_7a25b639;
    level flag::wait_till("round_1_seed_spawned");
    wait(1);
    level.var_805d0ecc = &function_1f5d3f75;
    level thread function_af95a19e();
}

// Namespace namespace_e37c032f
// Params 1, eflags: 0x1 linked
// Checksum 0xd1998637, Offset: 0xd20
// Size: 0xea
function function_7a25b639(drop_point) {
    if (!level function_f766ae15()) {
        return 0;
    }
    if (level flag::get("round_1_seed_spawned")) {
        return 0;
    }
    if (math::cointoss() || getaicount() < 1) {
        e_powerup = zm_powerups::specific_powerup_drop("island_seed", drop_point);
        level flag::set("round_1_seed_spawned");
        level thread function_ca5485fa(e_powerup);
        level.var_9895ed0d++;
        return 1;
    }
}

// Namespace namespace_e37c032f
// Params 1, eflags: 0x1 linked
// Checksum 0x6e529111, Offset: 0xe18
// Size: 0x124
function function_1f5d3f75(drop_point) {
    if (!level function_f766ae15()) {
        return 0;
    }
    if (level.var_9895ed0d >= level.var_325c412f) {
        return 0;
    }
    var_5da59d5c = randomint(100);
    if (var_5da59d5c > 2) {
        if (level.var_e964b72 == 0) {
            return;
        }
        println("toplayer");
    } else {
        println("toplayer");
    }
    e_powerup = zm_powerups::specific_powerup_drop("island_seed", drop_point);
    level thread function_ca5485fa(e_powerup);
    level.var_9895ed0d++;
    level.var_e964b72 = 0;
    return 1;
}

// Namespace namespace_e37c032f
// Params 0, eflags: 0x1 linked
// Checksum 0x974d9271, Offset: 0xf48
// Size: 0x14c
function function_af95a19e() {
    level endon(#"unloaded");
    players = level.players;
    level.var_e4f2021b = 2000;
    var_76d5c01 = players.size * level.zombie_vars["zombie_score_start_" + players.size + "p"] + level.var_e4f2021b;
    while (true) {
        players = level.players;
        var_47ca12e5 = 0;
        for (i = 0; i < players.size; i++) {
            if (isdefined(players[i].score_total)) {
                var_47ca12e5 += players[i].score_total;
            }
        }
        if (var_47ca12e5 > var_76d5c01) {
            level.var_e4f2021b *= 1.14;
            var_76d5c01 = var_47ca12e5 + level.var_e4f2021b;
            level.var_e964b72 = 1;
        }
        wait(0.5);
    }
}

// Namespace namespace_e37c032f
// Params 1, eflags: 0x1 linked
// Checksum 0xe86ac9f5, Offset: 0x10a0
// Size: 0x40
function function_ca5485fa(e_powerup) {
    e_powerup endon(#"powerup_grabbed");
    e_powerup waittill(#"powerup_timedout");
    if (level.var_9895ed0d > 0) {
        level.var_9895ed0d--;
    }
}

// Namespace namespace_e37c032f
// Params 2, eflags: 0x0
// Checksum 0x1c0ed810, Offset: 0x10e8
// Size: 0x54
function function_69e0fb83(var_55ce4248, n_duration) {
    self clientfield::set_to_player(var_55ce4248, 1);
    wait(n_duration);
    self clientfield::set_to_player(var_55ce4248, 0);
}

// Namespace namespace_e37c032f
// Params 3, eflags: 0x0
// Checksum 0x2b2ddee8, Offset: 0x1148
// Size: 0xc4
function function_ea405166(var_1d640f59, var_86a3391a, var_18bfcc38) {
    self notify(#"hash_6c34b226");
    self endon(#"hash_6c34b226");
    if (var_18bfcc38) {
        if (isdefined(var_1d640f59)) {
            self thread clientfield::set_player_uimodel(var_1d640f59, 1);
        }
        var_83c971ff = 3.5;
    } else {
        var_83c971ff = 3.5;
    }
    self thread clientfield::set_player_uimodel(var_86a3391a, 1);
    wait(var_83c971ff);
    self thread clientfield::set_player_uimodel(var_86a3391a, 0);
}

// Namespace namespace_e37c032f
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x1218
// Size: 0x4
function on_player_connect() {
    
}

// Namespace namespace_e37c032f
// Params 0, eflags: 0x1 linked
// Checksum 0xcf44f907, Offset: 0x1228
// Size: 0x24
function on_player_spawned() {
    self clientfield::set_to_player("has_island_seed", 0);
}

/#

    // Namespace namespace_e37c032f
    // Params 0, eflags: 0x1 linked
    // Checksum 0xcc347dcb, Offset: 0x1258
    // Size: 0x7c
    function function_7b74396f() {
        level flagsys::wait_till("toplayer");
        wait(1);
        zm_devgui::add_custom_devgui_callback(&function_903fbe7);
        adddebugcommand("toplayer");
        adddebugcommand("toplayer");
    }

    // Namespace namespace_e37c032f
    // Params 1, eflags: 0x1 linked
    // Checksum 0x18f95d4e, Offset: 0x12e0
    // Size: 0xc0
    function function_903fbe7(cmd) {
        players = getplayers();
        retval = 0;
        switch (cmd) {
        case 8:
            zm_devgui::zombie_devgui_give_powerup(cmd, 1);
            return 1;
        case 8:
            zm_devgui::zombie_devgui_give_powerup(getsubstr(cmd, 5), 0);
            return 1;
        }
        return retval;
    }

#/
