#using scripts/codescripts/struct;
#using scripts/cp/_util;
#using scripts/cp/cp_doa_bo3_fx;
#using scripts/cp/cp_doa_bo3_sound;
#using scripts/cp/doa/_doa_camera;
#using scripts/cp/doa/_doa_core;
#using scripts/cp/doa/_doa_fx;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#namespace namespace_3ca3c537;

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x4
// Checksum 0x6589bd2c, Offset: 0x308
// Size: 0x121
function private function_a55a134f() {
    arenas = struct::get_array("arena_center");
    for (i = 0; i < arenas.size; i++) {
        if (issubstr(arenas[i].script_parameters, "player_challenge")) {
            arenas[i].var_f869148f = arenas[i].script_parameters;
            arenas[i].script_parameters = "99999";
        }
    }
    var_d57bf957 = arenas;
    for (i = 1; i < var_d57bf957.size; i++) {
        for (j = i; j > 0 && int(var_d57bf957[j - 1].script_parameters) > int(var_d57bf957[j].script_parameters); j--) {
            array::swap(var_d57bf957, j, j - 1);
        }
    }
    return var_d57bf957;
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x0
// Checksum 0x2ecd6fdf, Offset: 0x438
// Size: 0x21
function function_bd3519f2(name) {
    switch (name) {
    case "safehouse":
        return 500;
    case "redins":
    case "tankmaze":
        return 1000;
    case "combat":
        return 1800;
    default:
        return 600;
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0xc3c17436, Offset: 0x498
// Size: 0x81
function function_61e2e743() {
    if (isdefined(level.var_e7f3233a)) {
        switch (level.var_e7f3233a) {
        case 1:
            return 400;
        case 2:
            return 800;
        case 3:
            return 1000;
        case 4:
            return 1800;
        }
        assert(0);
    }
    return level.var_72aa496e[level.var_6e76d849].camheight;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0xdf2dc515, Offset: 0x528
// Size: 0x19
function function_382c20a3() {
    return level.var_72aa496e[level.var_6e76d849].var_bfa5d6ae;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0xd4016760, Offset: 0x550
// Size: 0x66a
function init() {
    level.var_72aa496e = [];
    arenas = function_a55a134f();
    for (i = 0; i < arenas.size; i++) {
        arena = spawnstruct();
        arena.name = arenas[i].script_noteworthy;
        arena.center = arenas[i].origin;
        arena.camheight = function_bd3519f2(arena.name);
        arena.var_37d3a53b = isdefined(arenas[i].var_f869148f) ? 1 : 0;
        arena.var_aad78940 = 1.4;
        arena.var_bfa5d6ae = 0;
        arena.var_dd94482c = 1 + 2 + 16;
        arena.var_ecf7ec70 = undefined;
        if (isdefined(level.var_2eda2d85)) {
            [[ level.var_2eda2d85 ]](arena);
        }
        arena.exits = getentarray(0, arena.name + "_doa_exit", "targetname");
        arena.startpoints["left"] = struct::get_array(arena.name + "_exit_start_" + "left");
        arena.startpoints["right"] = struct::get_array(arena.name + "_exit_start_" + "right");
        arena.startpoints["top"] = struct::get_array(arena.name + "_exit_start_" + "top");
        arena.startpoints["bottom"] = struct::get_array(arena.name + "_exit_start_" + "bottom");
        arena.startpoints["player"] = struct::get_array(arena.name + "_player_spawnpoint");
        var_5fabae4f = struct::get(arena.name + "_camera_fixed_point");
        if (isdefined(var_5fabae4f) && isdefined(var_5fabae4f.script_parameters)) {
            campos = strtok(var_5fabae4f.script_parameters, " ");
            assert(isdefined(campos.size == 3), "<dev string:x28>" + arena.name + "<dev string:x2f>");
            arena.var_2ac7f133 = (float(campos[0]), float(campos[1]), float(campos[2]));
        } else {
            arena.var_2ac7f133 = (0, 0, 0);
        }
        if (isdefined(var_5fabae4f) && isdefined(var_5fabae4f.script_noteworthy)) {
            var_b5091c96 = strtok(var_5fabae4f.script_noteworthy, " ");
            assert(isdefined(var_b5091c96.size == 3), "<dev string:x28>" + arena.name + "<dev string:x65>");
            arena.var_5fec1234 = (float(var_b5091c96[0]), float(var_b5091c96[1]), float(var_b5091c96[2]));
        } else {
            arena.var_5fec1234 = (60, 0, 0);
        }
        arena.var_7526f3f5 = arena.var_2ac7f133;
        arena.var_790aac0e = arena.var_5fec1234;
        var_5fabae4f = struct::get(arena.name + "_camera_fixed_point_flip");
        if (isdefined(var_5fabae4f)) {
            if (isdefined(var_5fabae4f.script_parameters)) {
                campos = strtok(var_5fabae4f.script_parameters, " ");
                assert(isdefined(campos.size == 3), "<dev string:x28>" + arena.name + "<dev string:x2f>");
                arena.var_5a97f5e9 = (float(campos[0]), float(campos[1]), float(campos[2]));
            } else {
                arena.var_5a97f5e9 = (0, 0, 0);
            }
            if (isdefined(var_5fabae4f.script_noteworthy)) {
                var_b5091c96 = strtok(var_5fabae4f.script_noteworthy, " ");
                assert(isdefined(var_b5091c96.size == 3), "<dev string:x28>" + arena.name + "<dev string:x65>");
                arena.var_a8b67ea4 = (float(var_b5091c96[0]), float(var_b5091c96[1]), float(var_b5091c96[2]));
            } else {
                arena.var_5fec1234 = (60, -76, 0);
            }
        }
        if (isdefined(arena.var_f4f1abf3)) {
            if (arena.var_f4f1abf3 == 1) {
                arena.var_f4f1abf3 = arena.var_5fec1234;
            }
            if (arena.var_f4f1abf3 == 2) {
                arena.var_f4f1abf3 = arena.var_5a97f5e9;
            }
        }
        level.var_72aa496e[level.var_72aa496e.size] = arena;
    }
    level.var_6e76d849 = 0;
    level.var_a8f2912e = -1;
    level.var_aa4c76ca = 1;
    level.var_bfa66a8a = "morning";
    level thread function_a83dfb2c();
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0xc44b4183, Offset: 0xbc8
// Size: 0x119
function restart() {
    level.var_6e76d849 = 0;
    level.var_a8f2912e = -1;
    level.var_e7f3233a = undefined;
    level.var_aa4c76ca = 1;
    namespace_ad544aeb::function_d22ceb57((75, 0, 0), function_61e2e743());
    if (isdefined(level.var_72aa496e[level.var_6e76d849].var_2ac7f133)) {
        level.var_72aa496e[level.var_6e76d849].var_7526f3f5 = level.var_72aa496e[level.var_6e76d849].var_2ac7f133;
    }
    if (isdefined(level.var_72aa496e[level.var_6e76d849].var_5fec1234)) {
        level.var_72aa496e[level.var_6e76d849].var_790aac0e = level.var_72aa496e[level.var_6e76d849].var_5fec1234;
    }
    cleanupspawneddynents();
    if (isdefined(level.var_ba533099)) {
        exploder::kill_exploder(level.var_ba533099);
        level.var_ba533099 = undefined;
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0xd67c8240, Offset: 0xcf0
// Size: 0x10f
function function_a83dfb2c() {
    while (!clienthassnapshot(0)) {
        wait 0.016;
    }
    foreach (arena in level.var_72aa496e) {
        arena.exits = getentarray(0, arena.name + "_doa_exit", "targetname");
    }
    var_99ccb8b4 = getentarray(0);
    foreach (entity in var_99ccb8b4) {
        wait 0.01;
    }
}

// Namespace namespace_3ca3c537
// Params 7, eflags: 0x0
// Checksum 0x37a18832, Offset: 0xe08
// Size: 0x22a
function flipcamera(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.var_aa4c76ca = newval;
    switch (level.var_aa4c76ca) {
    case 0:
    case 1:
        namespace_ad544aeb::function_d22ceb57(function_c530afc5((75, 0, 0)), function_61e2e743());
        if (isdefined(level.var_72aa496e[level.var_6e76d849].var_2ac7f133)) {
            level.var_72aa496e[level.var_6e76d849].var_7526f3f5 = level.var_72aa496e[level.var_6e76d849].var_2ac7f133;
        }
        if (isdefined(level.var_72aa496e[level.var_6e76d849].var_5fec1234)) {
            level.var_72aa496e[level.var_6e76d849].var_790aac0e = level.var_72aa496e[level.var_6e76d849].var_5fec1234;
        }
        level.var_aa4c76ca = 1;
        break;
    case 2:
        namespace_ad544aeb::function_d22ceb57(function_c530afc5((75, -76, 0)), function_61e2e743());
        if (isdefined(level.var_72aa496e[level.var_6e76d849].var_5a97f5e9)) {
            level.var_72aa496e[level.var_6e76d849].var_7526f3f5 = level.var_72aa496e[level.var_6e76d849].var_5a97f5e9;
        }
        if (isdefined(level.var_72aa496e[level.var_6e76d849].var_a8b67ea4)) {
            level.var_72aa496e[level.var_6e76d849].var_790aac0e = level.var_72aa496e[level.var_6e76d849].var_a8b67ea4;
        }
        break;
    }
    cleanupspawneddynents();
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x0
// Checksum 0x41880894, Offset: 0x1040
// Size: 0x5a
function function_c530afc5(angles) {
    if (function_61e2e743() == 400 || function_382c20a3() == 1) {
        if (level.var_aa4c76ca != 2) {
            return (88, 0, 0);
        } else {
            return (88, -76, 0);
        }
    }
    return angles;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0x1815ba89, Offset: 0x10a8
// Size: 0x31
function function_be152c54() {
    if (function_61e2e743() == 400) {
        return 99;
    }
    return level.var_72aa496e[level.var_6e76d849].var_aad78940;
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x0
// Checksum 0xe2559f08, Offset: 0x10e8
// Size: 0xab
function function_9f1a0b26(var_c3479584) {
    localplayers = getlocalplayers();
    if (localplayers.size > 1) {
        if (!true) {
            return 2;
        }
        return 1;
    }
    cameramode = level.var_72aa496e[level.var_6e76d849].var_ecf7ec70;
    if (isdefined(cameramode)) {
        return cameramode;
    }
    InvalidOpCode(0xc1, var_c3479584, 1, level.var_72aa496e[level.var_6e76d849].var_dd94482c);
    // Unknown operator (0xc1, t7_1b, PC)
LOC_000000a2:
    if (isdefined(var_c3479584) && isdefined(var_c3479584)) {
        return var_c3479584;
    }
    return 0;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0x3544a77b, Offset: 0x11a0
// Size: 0x34
function function_61d60e0b() {
    if (isdefined(level.var_72aa496e) && level.var_72aa496e.size > 0) {
        return level.var_72aa496e[level.var_6e76d849].center;
    }
    return (0, 0, 0);
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0xc383b170, Offset: 0x11e0
// Size: 0x19
function function_d2d75f5d() {
    return level.var_72aa496e[level.var_6e76d849].name;
}

// Namespace namespace_3ca3c537
// Params 7, eflags: 0x0
// Checksum 0x1635e55f, Offset: 0x1208
// Size: 0x61
function killweather(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.var_ba533099)) {
        exploder::kill_exploder(level.var_ba533099);
        level.var_ba533099 = undefined;
    }
}

// Namespace namespace_3ca3c537
// Params 7, eflags: 0x0
// Checksum 0xc833265b, Offset: 0x1278
// Size: 0x152
function arenaRound(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.var_ba533099)) {
        exploder::kill_exploder(level.var_ba533099);
        level.var_ba533099 = undefined;
    }
    level.var_bfa66a8a = "morning";
    switch (newval) {
    case 0:
        level.var_bfa66a8a = "morning";
        break;
    case 1:
        level.var_bfa66a8a = "noon";
        break;
    case 2:
        level.var_bfa66a8a = "dusk";
        break;
    case 3:
        level.var_bfa66a8a = "night";
        break;
    }
    level.var_ba533099 = "fx_exploder_" + level.var_72aa496e[level.var_6e76d849].name + "_" + level.var_bfa66a8a;
    exploder::exploder(level.var_ba533099);
    level function_43141563(localclientnum);
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x0
// Checksum 0x2d73131d, Offset: 0x13d8
// Size: 0x40
function function_43141563(localclientnum) {
    if (isdefined(level.var_1f314fb9)) {
        [[ level.var_1f314fb9 ]](localclientnum, level.var_72aa496e[level.var_6e76d849].name, level.var_bfa66a8a);
    }
}

// Namespace namespace_3ca3c537
// Params 7, eflags: 0x0
// Checksum 0x4fa9bf2d, Offset: 0x1420
// Size: 0x1ca
function setarena(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (level.var_6e76d849 == newval && level.var_a8f2912e != -1) {
        return;
    }
    if (localclientnum != 0) {
        return;
    }
    level.var_e7f3233a = undefined;
    level notify(#"hash_ec7ca67b");
    namespace_693feb87::function_245e1ba2("Arena Change: " + level.var_72aa496e[level.var_6e76d849].name + " --> " + level.var_72aa496e[newval].name);
    level.var_a8f2912e = level.var_6e76d849;
    level.var_6e76d849 = newval;
    if (level.var_72aa496e[level.var_6e76d849].var_37d3a53b) {
        namespace_ad544aeb::function_d22ceb57((75, 0, 0), function_61e2e743());
    } else {
        namespace_ad544aeb::function_d22ceb57(undefined, function_61e2e743());
    }
    cleanupspawneddynents();
    if (isdefined(level.var_72aa496e[level.var_6e76d849].var_f3114f93)) {
        level thread [[ level.var_72aa496e[level.var_6e76d849].var_f3114f93 ]](localclientnum);
    }
    level.localplayers[0].cameramode = function_9f1a0b26(level.localplayers[0].cameramode);
    function_986ae2b3(localclientnum);
    level.localplayers[0] cameraforcedisablescriptcam(0);
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x0
// Checksum 0x3ad0bd87, Offset: 0x15f8
// Size: 0x72
function function_986ae2b3(localclientnum) {
    var_46caea66 = level.var_aa4c76ca == 1 ? (75, 0, 0) : (75, -76, 0);
    namespace_ad544aeb::function_d22ceb57(function_c530afc5(var_46caea66), function_61e2e743());
    level function_43141563(localclientnum);
}

