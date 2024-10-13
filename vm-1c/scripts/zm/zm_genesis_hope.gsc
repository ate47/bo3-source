#using scripts/zm/zm_genesis_util;
#using scripts/zm/zm_genesis_timer;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/animation_shared;
#using scripts/codescripts/struct;

#namespace zm_genesis_hope;

// Namespace zm_genesis_hope
// Params 0, eflags: 0x2
// Checksum 0x531d19bf, Offset: 0x430
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_genesis_hope", &__init__, &__main__, undefined);
}

// Namespace zm_genesis_hope
// Params 0, eflags: 0x1 linked
// Checksum 0xf78e035d, Offset: 0x478
// Size: 0x134
function __init__() {
    clientfield::register("world", "hope_state", 15000, getminbitcountfornum(4), "int");
    clientfield::register("clientuimodel", "zmInventory.super_ee", 15000, 1, "int");
    clientfield::register("toplayer", "hope_spark", 15000, 1, "int");
    clientfield::register("scriptmover", "hope_spark", 15000, 1, "int");
    level flag::init("hope_done");
    level.var_fa9755d7 = 0;
    /#
        if (getdvarint("<dev string:x28>") > 0) {
            level thread function_dfd4e9f8();
        }
    #/
}

// Namespace zm_genesis_hope
// Params 0, eflags: 0x1 linked
// Checksum 0xf73896c0, Offset: 0x5b8
// Size: 0xc
function __main__() {
    wait 0.1;
}

// Namespace zm_genesis_hope
// Params 0, eflags: 0x1 linked
// Checksum 0x9b872365, Offset: 0x5d0
// Size: 0x2a4
function start() {
    level waittill(#"start_zombie_round_logic");
    if (getdvarint("splitscreen_playerCount") > 2) {
        return;
    }
    var_d028d3a8 = array("ZOD", "FACTORY", "CASTLE", "ISLAND", "STALINGRAD");
    var_61d59a5a = [];
    foreach (player in level.players) {
        foreach (var_1493eda1 in var_d028d3a8) {
            var_dc163518 = player zm_stats::get_global_stat("DARKOPS_" + var_1493eda1 + "_SUPER_EE") > 0;
            var_9d5e869 = isinarray(var_61d59a5a, var_1493eda1);
            if (var_dc163518 && !var_9d5e869) {
                if (!isdefined(var_61d59a5a)) {
                    var_61d59a5a = [];
                } else if (!isarray(var_61d59a5a)) {
                    var_61d59a5a = array(var_61d59a5a);
                }
                var_61d59a5a[var_61d59a5a.size] = var_1493eda1;
            }
        }
    }
    /#
        iprintlnbold("<dev string:x35>" + var_61d59a5a.size + "<dev string:x4d>");
    #/
    if (var_61d59a5a.size == var_d028d3a8.size) {
        level clientfield::set("hope_state", 1);
        level thread function_bb1fbc7f();
    }
}

// Namespace zm_genesis_hope
// Params 0, eflags: 0x1 linked
// Checksum 0x9bb66ca9, Offset: 0x880
// Size: 0x11c
function function_bb1fbc7f() {
    if (isdefined(level.var_e8bba4d1) && level.var_e8bba4d1) {
        return;
    }
    level.var_e8bba4d1 = 1;
    var_4ea80194 = struct::get("hope_spark", "targetname");
    var_4ea80194 zm_unitrigger::create_unitrigger("", 64, &function_4903bec6, &function_ed25d0f2, "unitrigger_radius_use");
    var_8dc2ea89 = struct::get("special_box", "targetname");
    var_8dc2ea89 zm_unitrigger::create_unitrigger("", 64, &function_2650d73f, &function_46cfcb01, "unitrigger_radius_use");
}

// Namespace zm_genesis_hope
// Params 1, eflags: 0x1 linked
// Checksum 0xda506515, Offset: 0x9a8
// Size: 0x6c
function function_4903bec6(player) {
    var_5d0b57e4 = level clientfield::get("hope_state");
    if (var_5d0b57e4 == 1) {
        self sethintstring("");
        return true;
    }
    return false;
}

// Namespace zm_genesis_hope
// Params 0, eflags: 0x1 linked
// Checksum 0xf713338a, Offset: 0xa20
// Size: 0xc0
function function_ed25d0f2() {
    while (true) {
        e_triggerer = self waittill(#"trigger");
        if (e_triggerer zm_utility::in_revive_trigger()) {
            continue;
        }
        if (!zm_utility::is_player_valid(e_triggerer, 1, 1)) {
            continue;
        }
        var_5d0b57e4 = level clientfield::get("hope_state");
        if (var_5d0b57e4 != 1) {
            continue;
        }
        level thread function_b38baf01(e_triggerer);
    }
}

// Namespace zm_genesis_hope
// Params 1, eflags: 0x1 linked
// Checksum 0x58f2fe43, Offset: 0xae8
// Size: 0x64
function function_b38baf01(e_triggerer) {
    level clientfield::set("hope_state", 2);
    e_triggerer thread function_ba9b0148();
    e_triggerer playsound("zmb_overachiever_spark_pickup");
}

// Namespace zm_genesis_hope
// Params 0, eflags: 0x1 linked
// Checksum 0x76a7fbf3, Offset: 0xb58
// Size: 0xd4
function function_ba9b0148() {
    level endon(#"hope_done");
    self clientfield::set_to_player("hope_spark", 1);
    self clientfield::set_player_uimodel("zmInventory.super_ee", 1);
    self waittill(#"damage");
    self clientfield::set_to_player("hope_spark", 0);
    self clientfield::set_player_uimodel("zmInventory.super_ee", 0);
    self playsound("zmb_overachiever_spark_lose");
    /#
        iprintlnbold("<dev string:x58>");
    #/
}

// Namespace zm_genesis_hope
// Params 1, eflags: 0x1 linked
// Checksum 0x50a964c9, Offset: 0xc38
// Size: 0xd4
function function_2650d73f(player) {
    var_5d0b57e4 = level clientfield::get("hope_state");
    var_3d088ac6 = player clientfield::get_to_player("hope_spark");
    if (!var_3d088ac6) {
        return false;
    }
    if (var_5d0b57e4 == 2) {
        self sethintstring("");
        return true;
    } else if (var_5d0b57e4 == 3) {
        self sethintstring("");
        return true;
    }
    return false;
}

// Namespace zm_genesis_hope
// Params 0, eflags: 0x1 linked
// Checksum 0xc61d6b27, Offset: 0xd18
// Size: 0xf8
function function_46cfcb01() {
    while (true) {
        e_triggerer = self waittill(#"trigger");
        if (e_triggerer zm_utility::in_revive_trigger()) {
            continue;
        }
        if (!zm_utility::is_player_valid(e_triggerer, 1, 1)) {
            continue;
        }
        var_3d088ac6 = e_triggerer clientfield::get_to_player("hope_spark");
        if (!var_3d088ac6) {
            continue;
        }
        var_5d0b57e4 = level clientfield::get("hope_state");
        if (var_5d0b57e4 != 2) {
            continue;
        }
        level thread function_6143b210(e_triggerer);
    }
}

// Namespace zm_genesis_hope
// Params 1, eflags: 0x1 linked
// Checksum 0x39521246, Offset: 0xe18
// Size: 0x2b4
function function_6143b210(e_triggerer) {
    e_triggerer clientfield::set_to_player("hope_spark", 0);
    e_triggerer clientfield::set_player_uimodel("zmInventory.super_ee", 0);
    s_start = struct::get("hope_origin");
    var_8ccfc8c3 = util::spawn_model("tag_origin", s_start.origin, s_start.angles);
    util::wait_network_frame();
    var_8ccfc8c3 playsound("zmb_overachiever_spark_spawn");
    var_8ccfc8c3 clientfield::set("hope_spark", 1);
    wait 2;
    s_target = struct::get(s_start.target);
    var_8ccfc8c3 moveto(s_target.origin, 2);
    wait 3;
    s_target = struct::get(s_target.target);
    var_8ccfc8c3 moveto(s_target.origin, 2);
    var_8ccfc8c3 waittill(#"movedone");
    level clientfield::set("hope_state", 3);
    level flag::set("hope_done");
    playsoundatposition("zmb_overachiever_spark_success", (0, 0, 0));
    level.var_5d888f14 = &function_afddb902;
    level.magicbox_should_upgrade_weapon_override = &function_7e7eb906;
    zm_genesis_timer::function_cc8ae246(-56);
    level thread bgb::function_93da425("zm_bgb_crate_power", &function_f648c43);
    level thread bgb::function_93da425("zm_bgb_wall_power", &function_f648c43);
}

// Namespace zm_genesis_hope
// Params 2, eflags: 0x1 linked
// Checksum 0xec32bbab, Offset: 0x10d8
// Size: 0x18
function function_7e7eb906(e_player, w_weapon) {
    return true;
}

// Namespace zm_genesis_hope
// Params 0, eflags: 0x1 linked
// Checksum 0x987b40f3, Offset: 0x10f8
// Size: 0x8
function function_afddb902() {
    return true;
}

// Namespace zm_genesis_hope
// Params 0, eflags: 0x1 linked
// Checksum 0xe9909b22, Offset: 0x1108
// Size: 0x6
function function_f648c43() {
    return false;
}

/#

    // Namespace zm_genesis_hope
    // Params 0, eflags: 0x1 linked
    // Checksum 0x2bab5dca, Offset: 0x1118
    // Size: 0xec
    function function_dfd4e9f8() {
        level thread zm_genesis_util::function_72260d3a("<dev string:x82>", "<dev string:xc1>", 1, &function_7ecb414e);
        level thread zm_genesis_util::function_72260d3a("<dev string:xd1>", "<dev string:xf4>", 1, &function_3246e71d);
        level thread zm_genesis_util::function_72260d3a("<dev string:x103>", "<dev string:x128>", 1, &function_3ff1131a);
        level thread zm_genesis_util::function_72260d3a("<dev string:x139>", "<dev string:x15d>", 1, &function_8070468);
    }

    // Namespace zm_genesis_hope
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb1e1ccfc, Offset: 0x1210
    // Size: 0x4c
    function function_3246e71d(n_val) {
        level clientfield::set("<dev string:x16d>", 1);
        level thread function_bb1fbc7f();
    }

    // Namespace zm_genesis_hope
    // Params 1, eflags: 0x1 linked
    // Checksum 0xd74b28be, Offset: 0x1268
    // Size: 0x4c
    function function_3ff1131a(n_val) {
        level clientfield::set("<dev string:x16d>", 2);
        level thread function_bb1fbc7f();
    }

    // Namespace zm_genesis_hope
    // Params 1, eflags: 0x1 linked
    // Checksum 0xb8a5bb70, Offset: 0x12c0
    // Size: 0x6c
    function function_8070468(n_val) {
        level clientfield::set("<dev string:x16d>", 3);
        level thread function_bb1fbc7f();
        level flag::set("<dev string:x178>");
    }

    // Namespace zm_genesis_hope
    // Params 1, eflags: 0x1 linked
    // Checksum 0x18277b2f, Offset: 0x1338
    // Size: 0x6c
    function function_7ecb414e(n_val) {
        level clientfield::set("<dev string:x16d>", 1);
        level thread function_bb1fbc7f();
        /#
            iprintlnbold("<dev string:x182>");
        #/
    }

#/
