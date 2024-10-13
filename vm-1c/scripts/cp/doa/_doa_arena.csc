#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_core;
#using scripts/cp/cp_doa_bo3_sound;
#using scripts/cp/cp_doa_bo3_fx;
#using scripts/cp/_util;
#using scripts/shared/exploder_shared;
#using scripts/shared/array_shared;
#using scripts/cp/doa/_doa_camera;
#using scripts/shared/callbacks_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace namespace_3ca3c537;

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x5 linked
// Checksum 0xa3ea456e, Offset: 0x3c0
// Size: 0x19c
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
// Params 1, eflags: 0x1 linked
// Checksum 0x48fa5778, Offset: 0x568
// Size: 0x2c
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
// Params 0, eflags: 0x1 linked
// Checksum 0xaeb9eedd, Offset: 0x5d0
// Size: 0xae
function function_61e2e743() {
    if (isdefined(level.doa.var_708cc739)) {
        switch (level.doa.var_708cc739) {
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
    return level.doa.arenas[level.doa.var_90873830].camheight;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0x9c963ec, Offset: 0x688
// Size: 0x2e
function function_382c20a3() {
    return level.doa.arenas[level.doa.var_90873830].var_bfa5d6ae;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0x6db052ac, Offset: 0x6c0
// Size: 0xf84
function init() {
    level.doa.arenas = [];
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
        if (arena.name == "vault" || arena.name == "tankmaze" || arena.name == "coop" || arena.name == "armory" || arena.name == "alien_armory" || arena.name == "wolfhole" || arena.name == "bomb_storage" || arena.name == "hangar" || arena.name == "redins" || arena.name == "truck_soccer" || arena.name == "tankmaze") {
            arena.var_869acbe6 = 1;
        }
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
        level.doa.arenas[level.doa.arenas.size] = arena;
    }
    level.doa.var_90873830 = 0;
    level.doa.var_95e3fdf9 = -1;
    level.doa.var_1a75d02b = 1;
    level.doa.var_d94564a5 = "morning";
    level thread function_a83dfb2c();
    var_e1016b39 = [];
    var_e1016b39["targetname"] = [];
    if (!isdefined(var_e1016b39["targetname"])) {
        var_e1016b39["targetname"] = [];
    } else if (!isarray(var_e1016b39["targetname"])) {
        var_e1016b39["targetname"] = array(var_e1016b39["targetname"]);
    }
    var_e1016b39["targetname"][var_e1016b39["targetname"].size] = "_spot";
    if (!isdefined(var_e1016b39["targetname"])) {
        var_e1016b39["targetname"] = [];
    } else if (!isarray(var_e1016b39["targetname"])) {
        var_e1016b39["targetname"] = array(var_e1016b39["targetname"]);
    }
    var_e1016b39["targetname"][var_e1016b39["targetname"].size] = "_hazard";
    if (!isdefined(var_e1016b39["targetname"])) {
        var_e1016b39["targetname"] = [];
    } else if (!isarray(var_e1016b39["targetname"])) {
        var_e1016b39["targetname"] = array(var_e1016b39["targetname"]);
    }
    var_e1016b39["targetname"][var_e1016b39["targetname"].size] = "_pickup";
    if (!isdefined(var_e1016b39["targetname"])) {
        var_e1016b39["targetname"] = [];
    } else if (!isarray(var_e1016b39["targetname"])) {
        var_e1016b39["targetname"] = array(var_e1016b39["targetname"]);
    }
    var_e1016b39["targetname"][var_e1016b39["targetname"].size] = "_teleporter";
    if (!isdefined(var_e1016b39["targetname"])) {
        var_e1016b39["targetname"] = [];
    } else if (!isarray(var_e1016b39["targetname"])) {
        var_e1016b39["targetname"] = array(var_e1016b39["targetname"]);
    }
    var_e1016b39["targetname"][var_e1016b39["targetname"].size] = "_loot";
    if (!isdefined(var_e1016b39["targetname"])) {
        var_e1016b39["targetname"] = [];
    } else if (!isarray(var_e1016b39["targetname"])) {
        var_e1016b39["targetname"] = array(var_e1016b39["targetname"]);
    }
    var_e1016b39["targetname"][var_e1016b39["targetname"].size] = "_spawn";
    if (!isdefined(var_e1016b39["targetname"])) {
        var_e1016b39["targetname"] = [];
    } else if (!isarray(var_e1016b39["targetname"])) {
        var_e1016b39["targetname"] = array(var_e1016b39["targetname"]);
    }
    var_e1016b39["targetname"][var_e1016b39["targetname"].size] = "_destructible";
    var_e1016b39["script_noteworthy"] = [];
    if (!isdefined(var_e1016b39["script_noteworthy"])) {
        var_e1016b39["script_noteworthy"] = [];
    } else if (!isarray(var_e1016b39["script_noteworthy"])) {
        var_e1016b39["script_noteworthy"] = array(var_e1016b39["script_noteworthy"]);
    }
    var_e1016b39["script_noteworthy"][var_e1016b39["script_noteworthy"].size] = "tankmaze_gemspot";
    level function_d6bfcb75(var_e1016b39);
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x1 linked
// Checksum 0xda9815d, Offset: 0x1650
// Size: 0x200
function function_d6bfcb75(var_e1016b39) {
    var_3c8074ad = getarraykeys(var_e1016b39);
    for (i = 0; i < level.struct.size; i++) {
        if (function_a5b9b9b9(var_e1016b39, var_3c8074ad, level.struct[i])) {
            arrayremoveindex(level.struct, i, 0);
            i--;
        }
    }
    var_e5c5b3d2 = level.struct_class_names;
    var_7234d8ce = getarraykeys(var_e5c5b3d2);
    for (i = 0; i < var_7234d8ce.size; i++) {
        var_df94bc60 = var_e5c5b3d2[var_7234d8ce[i]];
        keys = getarraykeys(var_df94bc60);
        for (j = 0; j < keys.size; j++) {
            values = var_df94bc60[keys[j]];
            for (k = 0; k < values.size; k++) {
                if (function_a5b9b9b9(var_e1016b39, var_3c8074ad, values[k])) {
                    arrayremoveindex(values, k, 0);
                    k--;
                }
            }
        }
    }
}

// Namespace namespace_3ca3c537
// Params 3, eflags: 0x1 linked
// Checksum 0xb627411b, Offset: 0x1858
// Size: 0xfa
function function_a5b9b9b9(var_92804e37, var_b092b293, struct) {
    for (i = 0; i < var_b092b293.size; i++) {
        key = var_b092b293[i];
        var_cd3c820 = var_92804e37[key];
        for (j = 0; j < var_cd3c820.size; j++) {
            field = function_e8ef6cb0(struct, key);
            if (isdefined(field) && issubstr(field, var_cd3c820[j])) {
                return true;
            }
        }
    }
    return false;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0xb4e26b98, Offset: 0x1960
// Size: 0x202
function restart() {
    level.doa.var_90873830 = 0;
    level.doa.var_95e3fdf9 = -1;
    level.doa.var_708cc739 = undefined;
    level.doa.var_1a75d02b = 1;
    level.doa.flipped = 0;
    namespace_ad544aeb::function_d22ceb57((75, 0, 0), function_61e2e743());
    if (isdefined(level.doa.arenas[level.doa.var_90873830].var_2ac7f133)) {
        level.doa.arenas[level.doa.var_90873830].var_7526f3f5 = level.doa.arenas[level.doa.var_90873830].var_2ac7f133;
    }
    if (isdefined(level.doa.arenas[level.doa.var_90873830].var_5fec1234)) {
        level.doa.arenas[level.doa.var_90873830].var_790aac0e = level.doa.arenas[level.doa.var_90873830].var_5fec1234;
    }
    cleanupspawneddynents();
    if (isdefined(level.doa.var_1a3f3152)) {
        exploder::kill_exploder(level.doa.var_1a3f3152);
        level.doa.var_1a3f3152 = undefined;
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0xe91ca488, Offset: 0x1b70
// Size: 0x176
function function_a83dfb2c() {
    while (!clienthassnapshot(0)) {
        wait 0.016;
    }
    foreach (arena in level.doa.arenas) {
        arena.exits = getentarray(0, arena.name + "_doa_exit", "targetname");
    }
    var_99ccb8b4 = getentarray(0);
    foreach (entity in var_99ccb8b4) {
        wait 0.01;
    }
}

// Namespace namespace_3ca3c537
// Params 7, eflags: 0x1 linked
// Checksum 0x32aee30d, Offset: 0x1cf0
// Size: 0x384
function flipcamera(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    level.doa.var_1a75d02b = newval;
    switch (level.doa.var_1a75d02b) {
    case 0:
    case 1:
        level.doa.flipped = 0;
        namespace_ad544aeb::function_d22ceb57(function_c530afc5((75, 0, 0)), function_61e2e743());
        if (isdefined(level.doa.arenas[level.doa.var_90873830].var_2ac7f133)) {
            level.doa.arenas[level.doa.var_90873830].var_7526f3f5 = level.doa.arenas[level.doa.var_90873830].var_2ac7f133;
        }
        if (isdefined(level.doa.arenas[level.doa.var_90873830].var_5fec1234)) {
            level.doa.arenas[level.doa.var_90873830].var_790aac0e = level.doa.arenas[level.doa.var_90873830].var_5fec1234;
        }
        level.doa.var_1a75d02b = 1;
        break;
    case 2:
        level.doa.flipped = 1;
        namespace_ad544aeb::function_d22ceb57(function_c530afc5((75, -76, 0)), function_61e2e743());
        if (isdefined(level.doa.arenas[level.doa.var_90873830].var_5a97f5e9)) {
            level.doa.arenas[level.doa.var_90873830].var_7526f3f5 = level.doa.arenas[level.doa.var_90873830].var_5a97f5e9;
        }
        if (isdefined(level.doa.arenas[level.doa.var_90873830].var_a8b67ea4)) {
            level.doa.arenas[level.doa.var_90873830].var_790aac0e = level.doa.arenas[level.doa.var_90873830].var_a8b67ea4;
        }
        break;
    }
    cleanupspawneddynents();
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x1 linked
// Checksum 0x3adab3b6, Offset: 0x2080
// Size: 0x78
function function_c530afc5(angles) {
    if (function_61e2e743() == 400 || function_382c20a3() == 1) {
        if (level.doa.var_1a75d02b != 2) {
            return (88, 0, 0);
        } else {
            return (88, -76, 0);
        }
    }
    return angles;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0x4fd50d38, Offset: 0x2100
// Size: 0x4e
function function_be152c54() {
    if (function_61e2e743() == 400) {
        return 99;
    }
    return level.doa.arenas[level.doa.var_90873830].var_aad78940;
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x1 linked
// Checksum 0x52345715, Offset: 0x2158
// Size: 0x10a
function function_9f1a0b26(var_c3479584) {
    localplayers = getlocalplayers();
    if (localplayers.size > 1) {
        if (level.doa.arenas[level.doa.var_90873830].var_dd94482c & 4) {
            return 2;
        }
    }
    cameramode = level.doa.arenas[level.doa.var_90873830].var_ecf7ec70;
    if (isdefined(cameramode)) {
        return cameramode;
    }
    if (isdefined(var_c3479584) && level.doa.arenas[level.doa.var_90873830].var_dd94482c & 1 << var_c3479584) {
        return var_c3479584;
    }
    return 0;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0x87b50ee1, Offset: 0x2270
// Size: 0x60
function function_61d60e0b() {
    if (isdefined(level.doa.arenas) && level.doa.arenas.size > 0) {
        return level.doa.arenas[level.doa.var_90873830].center;
    }
    return (0, 0, 0);
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0xa1309fcf, Offset: 0x22d8
// Size: 0x2e
function function_d2d75f5d() {
    return level.doa.arenas[level.doa.var_90873830].name;
}

// Namespace namespace_3ca3c537
// Params 7, eflags: 0x1 linked
// Checksum 0x24e95917, Offset: 0x2310
// Size: 0x8e
function killweather(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.var_c065e9ed) && isdefined(level.var_c065e9ed[localclientnum])) {
        stopfx(localclientnum, level.var_c065e9ed[localclientnum]);
        level.var_c065e9ed[localclientnum] = 0;
    }
}

// Namespace namespace_3ca3c537
// Params 7, eflags: 0x1 linked
// Checksum 0xd86cd486, Offset: 0x23a8
// Size: 0x54
function killfog(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    setworldfogactivebank(localclientnum, 0);
}

// Namespace namespace_3ca3c537
// Params 7, eflags: 0x1 linked
// Checksum 0x146d6662, Offset: 0x2408
// Size: 0x3a4
function arenaRound(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (isdefined(level.doa.var_1a3f3152)) {
        stopradiantexploder(localclientnum, level.doa.var_1a3f3152);
        level.doa.var_1a3f3152 = undefined;
    }
    level.doa.var_d94564a5 = "morning";
    switch (newval) {
    case 0:
        level.doa.var_d94564a5 = "morning";
        setworldfogactivebank(localclientnum, 1);
        break;
    case 1:
        level.doa.var_d94564a5 = "noon";
        setworldfogactivebank(localclientnum, 2);
        break;
    case 2:
        level.doa.var_d94564a5 = "dusk";
        setworldfogactivebank(localclientnum, 4);
        break;
    case 3:
        level.doa.var_d94564a5 = "night";
        setworldfogactivebank(localclientnum, 8);
        break;
    default:
        level.doa.var_d94564a5 = "morning";
        setworldfogactivebank(localclientnum, 1);
        break;
    }
    if (function_d2d75f5d() == "temple" || function_d2d75f5d() == "tankmaze" || function_d2d75f5d() == "sgen" || function_d2d75f5d() == "blood" || function_d2d75f5d() == "vengeance" || function_d2d75f5d() == "boss") {
        setworldfogactivebank(localclientnum, 0);
    }
    level.doa.var_1a3f3152 = "fx_exploder_" + level.doa.arenas[level.doa.var_90873830].name + "_" + level.doa.var_d94564a5;
    /#
        namespace_693feb87::debugmsg("<dev string:xa2>" + level.doa.var_1a3f3152 + "<dev string:xb8>" + localclientnum);
    #/
    playradiantexploder(localclientnum, level.doa.var_1a3f3152);
    level function_43141563(localclientnum);
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x1 linked
// Checksum 0x402df781, Offset: 0x27b8
// Size: 0x68
function function_43141563(localclientnum) {
    if (isdefined(level.var_1f314fb9)) {
        [[ level.var_1f314fb9 ]](localclientnum, level.doa.arenas[level.doa.var_90873830].name, level.doa.var_d94564a5);
    }
}

// Namespace namespace_3ca3c537
// Params 7, eflags: 0x1 linked
// Checksum 0x69176b69, Offset: 0x2828
// Size: 0x2ec
function setarena(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    if (level.doa.var_90873830 == newval && level.doa.var_95e3fdf9 != -1) {
        return;
    }
    level.doa.var_708cc739 = undefined;
    level notify(#"hash_ec7ca67b");
    /#
        namespace_693feb87::debugmsg("<dev string:xcb>" + level.doa.arenas[level.doa.var_90873830].name + "<dev string:xda>" + level.doa.arenas[newval].name);
    #/
    level.doa.var_95e3fdf9 = level.doa.var_90873830;
    level.doa.var_90873830 = newval;
    if (level.doa.arenas[level.doa.var_90873830].var_37d3a53b) {
        namespace_ad544aeb::function_d22ceb57((75, 0, 0), function_61e2e743());
    } else {
        namespace_ad544aeb::function_d22ceb57(undefined, function_61e2e743());
    }
    cleanupspawneddynents();
    if (isdefined(level.doa.arenas[level.doa.var_90873830].var_f3114f93)) {
        level thread [[ level.doa.arenas[level.doa.var_90873830].var_f3114f93 ]](localclientnum);
    }
    players = getlocalplayers();
    while (players.size == 0) {
        players = getlocalplayers();
        wait 0.016;
    }
    players[0].cameramode = function_9f1a0b26(players[0].cameramode);
    function_986ae2b3(localclientnum);
    players[0] cameraforcedisablescriptcam(0);
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x1 linked
// Checksum 0xf75aa969, Offset: 0x2b20
// Size: 0xa4
function function_986ae2b3(localclientnum) {
    var_46caea66 = level.doa.var_1a75d02b == 1 ? (75, 0, 0) : (75, -76, 0);
    namespace_ad544aeb::function_d22ceb57(function_c530afc5(var_46caea66), function_61e2e743());
    level function_43141563(localclientnum);
}

