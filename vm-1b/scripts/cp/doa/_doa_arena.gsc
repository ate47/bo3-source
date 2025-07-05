#using scripts/codescripts/struct;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_enemy_boss;
#using scripts/cp/doa/_doa_fate;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_hazard;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_challenge_room;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace namespace_3ca3c537;

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x4
// Checksum 0xf204a2fb, Offset: 0x8e8
// Size: 0x169
function private function_a55a134f() {
    arenas = struct::get_array("arena_center");
    for (i = 0; i < arenas.size; i++) {
        if (isdefined(arenas[i].script_parameters) && (isdefined(arenas[i].player_challenge) && arenas[i].player_challenge || issubstr(arenas[i].script_parameters, "player_challenge"))) {
            level.doa.var_3c04d3df[level.doa.var_3c04d3df.size] = arenas[i];
            arenas[i].script_parameters = "99999";
            arenas[i].player_challenge = 1;
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
// Params 0, eflags: 0x0
// Checksum 0xbd0ca449, Offset: 0xa60
// Size: 0x35a
function init() {
    assert(isdefined(level.doa));
    level.doa.arenas = [];
    level.doa.var_3c04d3df = [];
    arenas = function_a55a134f();
    for (i = 0; i < arenas.size; i++) {
        arenas[i] function_b7dafa0c(arenas[i].script_noteworthy, arenas[i].origin, arenas[i].script_parameters == "99999");
    }
    level.doa.var_90873830 = 0;
    level.doa.var_ec2bff7b = [];
    function_abd3b624("vault", 5, 2, %DOA_VAULT, undefined, "vault");
    function_abd3b624("coop", 9, 3, %DOA_FARM, undefined, "coop");
    function_abd3b624("armory", 13, 1, %DOA_ARMORY, undefined, "armory");
    function_abd3b624("mystic_armory", 13, 7, %DOA_MYSTICAL_ARMORY, undefined, "alien_armory");
    function_abd3b624("wolfhole", 17, 6, %DOA_WOLFHOLE, undefined, "wolfhole");
    function_abd3b624("bomb_storage", 21, 8, %DOA_BOMB_STORAGE, undefined, "bomb_storage");
    function_abd3b624("hangar", 21, 5, %DOA_HANGAR, undefined, "hangar");
    function_abd3b624("mine", 28, 4, %DOA_MINE, undefined, "cave");
    function_abd3b624("righteous", 36, 10, %DOA_RIGHTEOUS_ROOM, 36, "temple", undefined, 1);
    foreach (arena in level.doa.var_3c04d3df) {
        function_abd3b624(arena.script_noteworthy, 999, 13, istring("DOA_" + toupper(arena.script_noteworthy) + "_ROOM"), 999, arena.script_noteworthy, 120);
    }
    level.spawn_start["allies"][0] = level.doa.arenas[0];
    level.spawn_start["axis"][0] = level.doa.arenas[0];
    level thread namespace_49107f3a::set_lighting_state(0);
}

// Namespace namespace_3ca3c537
// Params 8, eflags: 0x4
// Checksum 0x9a41b3a2, Offset: 0xdc8
// Size: 0x1e2
function private function_abd3b624(name, minround, type, text, maxround, var_c9a1f25a, var_c92c30d9, var_6f369ab4) {
    room = spawnstruct();
    room.name = name;
    room.minround = minround;
    room.type = type;
    room.text = text;
    room.timeout = var_c92c30d9;
    room.maxround = maxround;
    room.location = var_c9a1f25a;
    room.var_6f369ab4 = isdefined(var_6f369ab4) ? var_6f369ab4 : 999;
    room.var_57ce7582 = [];
    room.cooloff = 0;
    if (type == 13) {
        if (isdefined(level.doa.var_cefa8799)) {
            level thread [[ level.doa.var_cefa8799 ]](room);
        }
    }
    level.doa.var_ec2bff7b[level.doa.var_ec2bff7b.size] = room;
    location = isdefined(var_c9a1f25a) ? var_c9a1f25a : name;
    room.var_b1370bf0 = struct::get_array(location + "_player_spawnpoint");
    if (type != 13) {
        if (!room.var_b1370bf0.size && getdvarint("scr_doa_report_missing_struct", 0)) {
            namespace_49107f3a::debugmsg("MISSING _player_spawnpoint: for arena: " + name);
            return;
        }
        assert(room.var_b1370bf0.size);
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0x21df8eab, Offset: 0xfb8
// Size: 0xb7
function function_8b90b6a7() {
    foreach (room in level.doa.var_ec2bff7b) {
        if (room.type == 10) {
            continue;
        }
        if (room.type == 9) {
            continue;
        }
        if (room.type == 13) {
            continue;
        }
        if (room.minround == 999) {
            continue;
        }
        room.var_57ce7582 = [];
    }
}

// Namespace namespace_3ca3c537
// Params 2, eflags: 0x0
// Checksum 0x497460cf, Offset: 0x1078
// Size: 0xbf
function function_63bc3226(type, var_436ba068) {
    temp = namespace_49107f3a::function_4e9a23a9(level.doa.var_ec2bff7b);
    foreach (room in level.doa.var_ec2bff7b) {
        if (isdefined(var_436ba068)) {
            if (room.name != var_436ba068) {
                continue;
            }
        }
        if (room.type == type) {
            return room;
        }
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0xcffb4cf3, Offset: 0x1140
// Size: 0x117
function function_46b3be09() {
    foreach (room in level.doa.var_ec2bff7b) {
        if (room.type == 13) {
            continue;
        }
        if (level.doa.round_number < room.minround) {
            continue;
        }
        if (isdefined(room.var_5185e411) && !level [[ room.var_5185e411 ]](room)) {
            continue;
        }
        if (isdefined(room.maxround) && room.var_57ce7582.size == 0 && level.doa.round_number >= room.maxround) {
            level.doa.var_161fb2a1 = room.type;
            level.doa.var_94073ca5 = room.name;
            return;
        }
    }
}

// Namespace namespace_3ca3c537
// Params 2, eflags: 0x4
// Checksum 0xbf2056b4, Offset: 0x1260
// Size: 0x2b1
function private function_6b351e04(type, var_436ba068) {
    if (!isdefined(type)) {
        type = 0;
    }
    temp = namespace_49107f3a::function_4e9a23a9(level.doa.var_ec2bff7b);
    if (type != 0) {
        var_c50a98cb = function_63bc3226(type, var_436ba068);
    }
    if (!isdefined(var_c50a98cb)) {
        foreach (room in temp) {
            if (room.type == 13) {
                continue;
            }
            if (room.minround == 999) {
                continue;
            }
            if (room.var_6f369ab4 != 999 && room.var_57ce7582.size >= room.var_6f369ab4) {
                continue;
            }
            if (isdefined(room.var_5185e411) && !level [[ room.var_5185e411 ]](room)) {
                continue;
            }
            if (gettime() < room.cooloff) {
                continue;
            }
            if (isdefined(room.maxround) && level.doa.round_number >= room.maxround) {
                if (room.var_57ce7582.size == 0) {
                    var_c50a98cb = room;
                    break;
                }
            }
        }
    }
    if (!isdefined(var_c50a98cb)) {
        foreach (room in temp) {
            if (room.type == 13) {
                continue;
            }
            if (room.minround == 999) {
                continue;
            }
            if (room.var_6f369ab4 != 999 && room.var_57ce7582.size >= room.var_6f369ab4) {
                continue;
            }
            if (level.doa.round_number < room.minround) {
                continue;
            }
            if (gettime() < room.cooloff) {
                continue;
            }
            if (isdefined(room.var_5185e411) && !level [[ room.var_5185e411 ]](room)) {
                continue;
            }
            var_c50a98cb = room;
            break;
        }
    }
    if (isdefined(var_c50a98cb)) {
        var_c50a98cb.var_57ce7582[var_c50a98cb.var_57ce7582.size] = level.doa.round_number;
    }
    return var_c50a98cb;
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x0
// Checksum 0x64eec4c7, Offset: 0x1520
// Size: 0x28
function function_85c94f67(room) {
    return room.type == 2 || room.type == 4;
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x0
// Checksum 0xac9189fd, Offset: 0x1550
// Size: 0x28
function function_35f13fc4(room) {
    return room.type == 9 || room.type == 10;
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x0
// Checksum 0x361d9a01, Offset: 0x1580
// Size: 0x18
function function_b9e4794c(room) {
    return room.type == 13;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0xc16fd112, Offset: 0x15a0
// Size: 0x10b
function function_e88371e5() {
    loots = function_d2d75f5d() + "_loot";
    points = struct::get_array(loots);
    foreach (loot in points) {
        if (isdefined(loot.script_noteworthy)) {
            namespace_a7e6beb5::function_3238133b(loot.script_noteworthy, loot.origin, 1, 0, 1, 0, loot.angles);
            continue;
        }
        if (isdefined(loot.model)) {
            namespace_a7e6beb5::function_3238133b(loot.model, loot.origin, 1, 0, 1, 0, loot.angles);
        }
    }
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x4
// Checksum 0xd95358a, Offset: 0x16b8
// Size: 0x74c
function private function_1c54aa82(room) {
    players = doa_player_utility::function_5eb6e4d1();
    playercount = players.size;
    level.doa.var_e9339daa = level.doa.var_90873830;
    level thread namespace_49107f3a::clearallcorpses();
    level thread namespace_a7e6beb5::function_c1869ec8();
    level clientfield::increment("cleanUpGibs");
    level waittill(#"hash_229914a6");
    if (isdefined(room.location)) {
        function_5af67667(function_5835533a(room.location), 1);
    }
    points = struct::get_array(function_d2d75f5d() + "_player_spawnpoint");
    if (isdefined(points) && points.size) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (isdefined(players[i])) {
                if (isdefined(points[i])) {
                    origin = points[i].origin;
                } else {
                    origin = points[0].origin;
                }
                players[i] namespace_cdb9a8fe::function_fe0946ac(origin);
            }
        }
    }
    doa_player_utility::function_82e3b1cb();
    room.cooloff = gettime() + 10 * 60000;
    level.doa.var_6f2c52d8 = 1;
    level thread namespace_49107f3a::set_lighting_state(0);
    level thread function_e88371e5();
    switch (room.type) {
    case 2:
        flag::set("doa_bonusroom_active");
        function_8274c029();
        var_4833a640 = 1;
        level thread namespace_a7e6beb5::function_22d0e830(0, 15, 0.1);
        break;
    case 1:
        flag::set("doa_bonusroom_active");
        function_8274c029();
        var_4833a640 = 1;
        level thread namespace_a7e6beb5::function_22d0e830(0, 2, randomfloatrange(2, 4));
        break;
    case 3:
        flag::set("doa_bonusroom_active");
        level thread namespace_a7e6beb5::function_22d0e830(0, 2, randomfloatrange(2, 4));
        level thread namespace_a7e6beb5::function_3238133b(level.doa.var_8d63e734, undefined, 1);
        spot = namespace_a7e6beb5::function_ac410a13();
        if (isdefined(spot)) {
            level namespace_a7e6beb5::function_3238133b(level.doa.var_43922ff2, spot.origin + (randomfloatrange(-30, 30), randomfloatrange(-30, 30), 0), 7);
            room.cooloff = gettime() + 30 * 60000;
        }
        break;
    case 4:
        flag::set("doa_bonusroom_active");
        level thread namespace_a7e6beb5::function_22d0e830(1, 5, 0.1);
        level thread namespace_a7e6beb5::function_22d0e830(0, 2, randomfloatrange(2, 4));
        room.cooloff = gettime() + 30 * 60000;
        break;
    case 6:
        flag::set("doa_bonusroom_active");
        level thread namespace_a7e6beb5::function_22d0e830(0, 2, randomfloatrange(2, 4));
        level namespace_a7e6beb5::function_3238133b(level.doa.var_f6947407, undefined, 2);
        level namespace_a7e6beb5::function_3238133b(level.doa.var_97bbae9c, undefined, 4);
        level namespace_a7e6beb5::function_3238133b(level.doa.var_f6e22ab8, undefined, 3);
        break;
    case 5:
        flag::set("doa_bonusroom_active");
        function_8274c029();
        var_4833a640 = 1;
        level.doa.var_a3a11449 = 1;
        level thread namespace_a7e6beb5::function_22d0e830(0, 2, randomfloatrange(2, 4));
        break;
    case 7:
        flag::set("doa_bonusroom_active");
        function_8274c029();
        var_4833a640 = 1;
        level thread namespace_a7e6beb5::function_22d0e830(0, 2, randomfloatrange(2, 4));
        break;
    case 8:
        flag::set("doa_bonusroom_active");
        function_8274c029();
        var_4833a640 = 1;
        level thread namespace_a7e6beb5::function_22d0e830(0, 2, randomfloatrange(2, 4));
        break;
    case 10:
        function_ba9c838e();
        level.doa.var_6f2c52d8 = undefined;
        namespace_23f188a4::doRoomOfJudgement();
        break;
    case 13:
        function_ba9c838e();
        level.doa.var_6f2c52d8 = undefined;
        namespace_74ae326f::function_15a0c9b5(room);
        break;
    }
    if (!(isdefined(var_4833a640) && var_4833a640)) {
        function_ba9c838e();
    }
    if (!function_35f13fc4(room) && !function_b9e4794c(room)) {
        namespace_49107f3a::function_390adefe();
        level thread namespace_49107f3a::function_c5f3ece8(%DOA_BONUS_ROOM, undefined, 6);
        level.voice playsound("vox_doaa_bonus_room");
        wait 1;
        level thread namespace_49107f3a::function_37fb5c23(room.text);
        wait 6;
        function_f64e4b70("all");
    }
    flag::clear("doa_bonusroom_active");
    function_5af67667(level.doa.var_e9339daa, 1);
    return true;
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x0
// Checksum 0xf3de5628, Offset: 0x1e10
// Size: 0x7b
function function_b0e9983(name) {
    switch (name) {
    case "farm":
        return 31;
    case "graveyard":
        return 33;
    case "temple":
        return 23;
    case "safehouse":
        return 23;
    case "vengeance":
        return 14;
    case "sgen":
        return 38;
    case "metro":
        return 40;
    case "sector":
        return 24;
    case "boss":
        return 22;
    }
    return 28;
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x4
// Checksum 0x5cfc7b4a, Offset: 0x1e98
// Size: 0xd5
function private function_9b67513c(name) {
    switch (name) {
    case "island":
        return 1;
    case "dock":
        return 2;
    case "farm":
        return 3;
    case "graveyard":
        return 4;
    case "temple":
        return 5;
    case "safehouse":
        return 6;
    case "blood":
        return 7;
    case "cave":
        return 8;
    case "vengeance":
        return 9;
    case "sgen":
        return 10;
    case "apartments":
        return 11;
    case "sector":
        return 12;
    case "metro":
        return 13;
    case "clearing":
        return 14;
    case "newworld":
        return 15;
    case "boss":
        return 16;
    default:
        break;
    }
}

// Namespace namespace_3ca3c537
// Params 3, eflags: 0x4
// Checksum 0xae6b4a09, Offset: 0x1f78
// Size: 0x71b
function private function_b7dafa0c(name, center, valid) {
    struct = spawnstruct();
    struct.name = name;
    struct.center = center;
    struct.origin = center;
    struct.angles = (0, 0, 0);
    struct.var_160ae6c6 = function_9b67513c(name);
    struct.exits = getentarray(name + "_doa_exit", "targetname");
    struct.var_63b4dab3 = valid;
    struct.var_d88cc53c = getent(name + "_safezone", "targetname");
    struct.var_2ac7f133 = (0, 0, 2000) + center;
    struct.var_5a97f5e9 = (0, 0, 2000) + center;
    struct.entity = self;
    struct.var_fe390b01 = struct::get_array(name + "_flyer_spawn_loc", "targetname");
    struct.var_1d2ed40 = struct::get_array(name + "_safe_spot", "targetname");
    struct.var_f616a3b7 = [];
    struct.var_f616a3b7["top"] = [];
    struct.var_f616a3b7["bottom"] = [];
    struct.var_f616a3b7["left"] = [];
    struct.var_f616a3b7["right"] = [];
    struct.var_b1370bf0 = struct::get_array(name + "_player_spawnpoint");
    struct.var_f616a3b7["top"] = struct::get_array(name + "_exit_start_top");
    struct.var_f616a3b7["bottom"] = struct::get_array(name + "_exit_start_bottom");
    struct.var_f616a3b7["left"] = struct::get_array(name + "_exit_start_left");
    struct.var_f616a3b7["right"] = struct::get_array(name + "_exit_start_right");
    if (isdefined(struct.var_160ae6c6)) {
        if (!struct.var_f616a3b7["top"].size && getdvarint("scr_doa_report_missing_struct", 0)) {
            namespace_49107f3a::debugmsg("MISSING _exit_start_top for arena: " + name);
        } else {
            assert(struct.var_f616a3b7["<dev string:x28>"].size);
        }
        if (!struct.var_f616a3b7["bottom"].size && getdvarint("scr_doa_report_missing_struct", 0)) {
            namespace_49107f3a::debugmsg("MISSING _exit_start_bottom for arena: " + name);
        } else {
            assert(struct.var_f616a3b7["<dev string:x2c>"].size);
        }
        if (!struct.var_f616a3b7["left"].size && getdvarint("scr_doa_report_missing_struct", 0)) {
            namespace_49107f3a::debugmsg("MISSING _exit_start_left for arena: " + name);
        } else {
            assert(struct.var_f616a3b7["<dev string:x33>"].size);
        }
        if (!struct.var_f616a3b7["right"].size && getdvarint("scr_doa_report_missing_struct", 0)) {
            namespace_49107f3a::debugmsg("MISSING _exit_start_right for arena: " + name);
        } else {
            assert(struct.var_f616a3b7["<dev string:x38>"].size);
        }
        if (!struct.var_b1370bf0.size && getdvarint("scr_doa_report_missing_struct", 0)) {
            namespace_49107f3a::debugmsg("MISSING _player_spawnpoint for arena: " + name);
        } else {
            assert(struct.var_b1370bf0.size);
        }
    }
    var_5fabae4f = struct::get(name + "_camera_fixed_point");
    if (isdefined(var_5fabae4f) && isdefined(var_5fabae4f.script_parameters)) {
        campos = strtok(var_5fabae4f.script_parameters, " ");
        assert(isdefined(campos.size == 3), "<dev string:x3e>" + name + "<dev string:x45>");
        struct.var_2ac7f133 = (float(campos[0]), float(campos[1]), float(campos[2])) + center;
    }
    var_5fabae4f = struct::get(name + "_camera_fixed_point_flip");
    if (isdefined(var_5fabae4f) && isdefined(var_5fabae4f.script_parameters)) {
        campos = strtok(var_5fabae4f.script_parameters, " ");
        assert(isdefined(campos.size == 3), "<dev string:x3e>" + name + "<dev string:x45>");
        struct.var_5a97f5e9 = (float(campos[0]), float(campos[1]), float(campos[2])) + center;
    }
    assert(isdefined(struct.var_d88cc53c), "<dev string:x7b>" + name + "<dev string:x9c>");
    for (i = 0; i < struct.exits.size; i++) {
        struct.exits[i] triggerenable(0);
    }
    namespace_cdb9a8fe::function_c81e1083(name);
    if (isdefined(level.doa.var_62423327)) {
        [[ level.doa.var_62423327 ]](struct);
    }
    level.doa.arenas[level.doa.arenas.size] = struct;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0xdbc80487, Offset: 0x26a0
// Size: 0x29
function function_5295ea97() {
    return level.doa.arenas[level.doa.var_90873830].var_160ae6c6;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0xad316b99, Offset: 0x26d8
// Size: 0x29
function function_dc34896f() {
    return level.doa.arenas[level.doa.var_90873830].var_d88cc53c;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0x90d6f7af, Offset: 0x2710
// Size: 0xe1
function function_61d60e0b() {
    if (isdefined(level.doa.arenas)) {
        return level.doa.arenas[level.doa.var_90873830].center;
    } else {
        var_520dc677 = function_d2d75f5d();
        arenas = struct::get_array("arena_center");
        foreach (arena in arenas) {
            if (arena.script_noteworthy == var_520dc677) {
                return arena.origin;
            }
        }
    }
    return (0, 0, 0);
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0x51f3ef68, Offset: 0x2800
// Size: 0x4a
function function_d2d75f5d() {
    if (isdefined(level.doa.arenas)) {
        return level.doa.arenas[level.doa.var_90873830].name;
    }
    return "island";
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x0
// Checksum 0x2b4fdee9, Offset: 0x2858
// Size: 0x55
function function_5835533a(name) {
    for (i = 0; i < level.doa.arenas.size; i++) {
        if (level.doa.arenas[i].name == name) {
            return i;
        }
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0xf9153829, Offset: 0x28b8
// Size: 0x6a
function function_5147636f() {
    if (level.doa.flipped) {
        return level.doa.arenas[level.doa.var_90873830].var_5a97f5e9;
    }
    return level.doa.arenas[level.doa.var_90873830].var_2ac7f133;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0xc6086f1e, Offset: 0x2930
// Size: 0x29
function function_a8f91d6f() {
    return level.doa.arenas[level.doa.var_90873830].exits;
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x0
// Checksum 0x3dd59228, Offset: 0x2968
// Size: 0x5a
function function_ba9c838e(var_c56d15c4) {
    if (!isdefined(var_c56d15c4)) {
        var_c56d15c4 = 0;
    }
    level.doa.flipped = 0;
    level clientfield::set("flipCamera", var_c56d15c4 == 0 ? 1 : 0);
    settopdowncamerayaw(0);
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0xb367782e, Offset: 0x29d0
// Size: 0x3a
function function_8274c029() {
    level.doa.flipped = 1;
    level clientfield::set("flipCamera", 2);
    settopdowncamerayaw(-76);
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x0
// Checksum 0x6ced2c1b, Offset: 0x2a18
// Size: 0x374
function function_78c7b56e(cheat) {
    if (!isdefined(cheat)) {
        cheat = 0;
    }
    level notify(#"hash_78c7b56e");
    level endon(#"hash_78c7b56e");
    level endon(#"doa_game_is_over");
    if (!level flag::get("doa_game_is_completed") && level.doa.var_458c27d + 1 < level.doa.rules.var_88c0b67b) {
        if (cheat == 0) {
            function_f64e4b70();
            /#
                if (isdefined(level.doa.var_33749c8)) {
                    level.doa.var_c03fe5f1 = undefined;
                }
            #/
            if (isdefined(level.doa.var_c03fe5f1)) {
                level notify(#"hash_ba37290e", level.doa.var_c03fe5f1.name);
                function_1c54aa82(level.doa.var_c03fe5f1);
            }
        }
        if (level.doa.flipped) {
            function_ba9c838e();
        } else {
            function_8274c029();
        }
        level.doa.var_458c27d = math::clamp(level.doa.var_458c27d + 1, 0, level.doa.rules.var_88c0b67b - 1);
        level namespace_49107f3a::set_lighting_state(level.doa.var_458c27d);
        level clientfield::set("arenaRound", level.doa.var_458c27d);
        return false;
    }
    function_4586479a();
    if (level.doa.flipped) {
        level.doa.flipped = 0;
        level clientfield::set("flipCamera", 0);
        settopdowncamerayaw(0);
    }
    level.doa.var_458c27d = 0;
    if (isdefined(level.doa.var_b5c260bb)) {
        function_5af67667(level.doa.var_b5c260bb);
        level.doa.round_number = level.doa.var_b5c260bb * level.doa.rules.var_88c0b67b;
        level.doa.var_b5c260bb = undefined;
    } else {
        function_5af67667(level.doa.var_90873830 + 1);
    }
    level namespace_49107f3a::set_lighting_state(level.doa.var_458c27d);
    level clientfield::set("arenaRound", level.doa.var_458c27d);
    idx = function_5295ea97();
    if (isdefined(idx)) {
        level clientfield::set("overworldlevel", idx);
        util::wait_network_frame();
    }
    function_a6c926fc(5);
    return true;
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x0
// Checksum 0x9f60e35, Offset: 0x2d98
// Size: 0x4a
function function_a6c926fc(holdtime) {
    level.var_3259f885 = 1;
    level clientfield::set("overworld", 1);
    wait holdtime;
    level clientfield::set("overworld", 0);
    level.var_3259f885 = 0;
}

// Namespace namespace_3ca3c537
// Params 2, eflags: 0x0
// Checksum 0x1806cb0b, Offset: 0x2df0
// Size: 0x18a
function function_5af67667(var_7dd30d23, var_b4ca654f) {
    if (!isdefined(var_b4ca654f)) {
        var_b4ca654f = 0;
    }
    if (!(isdefined(var_b4ca654f) && var_b4ca654f) && (level flag::get("doa_game_is_completed") || level.doa.arenas[var_7dd30d23].var_63b4dab3)) {
        if (isdefined(level.doa.var_5ddb204f)) {
            [[ level.doa.var_5ddb204f ]]();
        }
        var_7dd30d23 = 0;
        level.doa.var_da96f13c++;
        function_8b90b6a7();
        level flag::clear("doa_game_is_completed");
    }
    level.doa.var_90873830 = var_7dd30d23;
    level notify(#"hash_ec7ca67b");
    level clientfield::set("arenaUpdate", level.doa.var_90873830);
    util::wait_network_frame();
    level thread function_a50a72db();
    level thread function_1c812a03();
    level.doa.var_3361a074 = struct::get_array(function_d2d75f5d() + "_pickup", "targetname");
    level thread namespace_49107f3a::set_lighting_state(level.doa.var_458c27d);
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0x71f1a0, Offset: 0x2f88
// Size: 0x16d
function function_a50a72db() {
    level endon(#"hash_ec7ca67b");
    level endon(#"doa_game_restart");
    level notify(#"hash_a50a72db");
    level endon(#"hash_a50a72db");
    level waittill(#"hash_3b6e1e2");
    var_d88cc53c = function_dc34896f();
    wait 1;
    while (!level flag::get("doa_game_is_over")) {
        foreach (player in getplayers()) {
            if (!isdefined(player.doa)) {
                continue;
            }
            if (!player istouching(var_d88cc53c) && !player isinmovemode("ufo", "noclip")) {
                namespace_49107f3a::debugmsg("Player " + player.entnum + " (" + player.name + ") is out of safety zone (" + var_d88cc53c.targetname + ") at:" + player.origin);
                player thread namespace_cdb9a8fe::function_fe0946ac(undefined);
            }
        }
        wait 0.05;
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0x12288d8e, Offset: 0x3100
// Size: 0x81
function function_1c812a03() {
    platforms = getentarray(function_d2d75f5d() + "_moving_platform", "targetname");
    for (i = 0; i < platforms.size; i++) {
        platforms[i] thread function_573ad24e();
        platforms[i] thread function_7d65367c();
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0xaac43e6a, Offset: 0x3190
// Size: 0x229
function function_573ad24e() {
    level endon(#"hash_ec7ca67b");
    if (!isdefined(self.script_noteworthy)) {
        self.script_noteworthy = "move_to_target";
    }
    if (!isdefined(self.script_parameters)) {
        self.script_parameters = 30;
    } else {
        self.script_parameters = int(self.script_parameters);
    }
    var_febfbf3a = self.origin;
    self setmovingplatformenabled(1);
    var_dce3037c = getentarray(function_d2d75f5d() + "_moving_platform_linktrigger", "targetname");
    foreach (trigger in var_dce3037c) {
        self thread movingPlatformOnOffTriggerWatch(trigger);
    }
    switch (self.script_noteworthy) {
    case "move_to_target":
        target = getent(self.target, "targetname");
        if (!isdefined(target)) {
            target = struct::get(self.target, "targetname");
        }
        assert(isdefined(target));
        while (true) {
            self moveto(target.origin, self.script_parameters);
            self util::waittill_any_timeout(self.script_parameters + 2, "movedone");
            wait 1;
            self moveto(var_febfbf3a, self.script_parameters);
            self util::waittill_any_timeout(self.script_parameters + 2, "movedone");
        }
        break;
    }
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x0
// Checksum 0x8c56f47d, Offset: 0x33c8
// Size: 0x281
function movingPlatformOnOffTriggerWatch(trigger) {
    level endon(#"hash_ec7ca67b");
    wait 0.4;
    trigger enablelinkto();
    trigger linkto(self);
    self.var_10d9457b = [];
    nodes = getnodearray(function_d2d75f5d() + "_platform_traversal_node", "targetname");
    foreach (node in nodes) {
        org = spawn("script_model", node.origin);
        org.targetname = "movingPlatformOnOffTriggerWatch";
        org.origin += (0, 0, 10);
        org setmodel("tag_origin");
        org.node = node;
        self.var_10d9457b[self.var_10d9457b.size] = org;
    }
    while (isdefined(self.var_10d9457b)) {
        foreach (ent in self.var_10d9457b) {
            if (ent istouching(trigger)) {
                if (!(isdefined(ent.node.activated) && ent.node.activated)) {
                    linktraversal(ent.node);
                    ent.node.activated = 1;
                }
                continue;
            }
            if (isdefined(ent.node.activated) && ent.node.activated) {
                unlinktraversal(ent.node);
                ent.node.activated = undefined;
            }
        }
        wait 0.05;
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0x92ef0904, Offset: 0x3658
// Size: 0x129
function function_7d65367c() {
    level waittill(#"hash_ec7ca67b");
    self setmovingplatformenabled(0);
    nodes = getnodearray(function_d2d75f5d() + "_platform_traversal_node", "targetname");
    foreach (node in nodes) {
        unlinktraversal(node);
    }
    if (isdefined(self.var_10d9457b)) {
        foreach (ent in self.var_10d9457b) {
            ent delete();
        }
        self.var_10d9457b = undefined;
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x4
// Checksum 0xea1b352e, Offset: 0x3790
// Size: 0x3b
function private function_47f8f274() {
    wait 0.1;
    level util::waittill_any("exit_taken", "doa_game_is_over");
    wait 0.05;
    self notify(#"trigger");
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x4
// Checksum 0xbd896700, Offset: 0x37d8
// Size: 0x96
function private function_17665174(trigger) {
    level endon(#"exit_taken");
    level endon(#"doa_game_is_over");
    trigger waittill(#"trigger");
    level.doa.var_c03fe5f1 = function_6b351e04(level.doa.var_161fb2a1, level.doa.var_94073ca5);
    if (isdefined(level.doa.var_c03fe5f1)) {
        level.doa.var_f2108348 = level.doa.round_number;
    }
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x0
// Checksum 0x9d24207d, Offset: 0x3878
// Size: 0x46e
function function_f64e4b70(specific) {
    while (isdefined(level.doa.var_9b77ca48) && level.doa.var_9b77ca48) {
        wait 0.25;
    }
    level notify(#"opening_exits");
    level.doa.var_53d0f8a7 = [];
    if (!isdefined(level.doa.var_c03fe5f1)) {
        result = sprintf(%DOA_ROUNDCOMPLETE, level.doa.round_number);
        level thread namespace_49107f3a::function_c5f3ece8(result, undefined, -1);
    }
    level.doa.var_c03fe5f1 = undefined;
    var_46876357 = function_a8f91d6f();
    if (isdefined(level.doa.var_638a5ffc)) {
        specific = level.doa.var_638a5ffc;
        level.doa.var_638a5ffc = undefined;
    }
    if (isdefined(specific)) {
        var_7d23c775 = specific == "all" ? var_46876357.size : 1;
        var_6e747c = [];
        for (i = 0; i < var_46876357.size; i++) {
            if (specific == "all" || var_46876357[i].script_noteworthy == specific) {
                var_6e747c[var_6e747c.size] = var_46876357[i];
            }
        }
        var_46876357 = var_6e747c;
    } else {
        var_46876357 = namespace_49107f3a::function_4e9a23a9(var_46876357);
        var_7d23c775 = 1 + randomint(var_46876357.size);
        if (namespace_49107f3a::function_5233dbc0()) {
            var_7d23c775 = math::clamp(var_7d23c775, 2, var_46876357.size);
        }
    }
    var_4293c8ed = undefined;
    if (level.doa.round_number - level.doa.var_f2108348 > 2) {
        if (var_7d23c775 > 1) {
            var_4293c8ed = randomint(var_7d23c775);
        }
    }
    var_b264324 = 0;
    playsoundatposition("zmb_exit_open", (0, 0, 0));
    namespace_74ae326f::function_471d1403();
    if (!isdefined(level.doa.var_161fb2a1)) {
        function_46b3be09();
    }
    for (i = 0; i < var_7d23c775; i++) {
        if (isdefined(var_4293c8ed) && (isdefined(level.doa.var_161fb2a1) || i == var_4293c8ed)) {
            level thread function_17665174(var_46876357[i]);
            var_4293c8ed = undefined;
        }
        level thread function_a8b0c139(var_46876357[i], i);
        level.doa.var_53d0f8a7[level.doa.var_53d0f8a7.size] = var_46876357[i];
        /#
            if (isdefined(level.doa.var_33749c8)) {
                var_46876357[i] thread namespace_49107f3a::function_a4d1f25e("<dev string:x9e>", randomfloatrange(0.5, 1));
            }
        #/
        wait 0.2;
    }
    level notify(#"hash_7a1b7ce7");
    assert(level.doa.var_53d0f8a7.size != 0, "<dev string:xa6>");
    if (level.doa.var_53d0f8a7.size > 1) {
        level thread namespace_49107f3a::function_37fb5c23(%DOA_CHOOSEPATH, undefined, -1);
    }
    level waittill(#"exit_taken", var_43605624);
    level.doa.var_161fb2a1 = undefined;
    level.doa.var_94073ca5 = undefined;
    level notify(#"title1Fade");
    level notify(#"title2Fade");
    level.doa.var_53d0f8a7 = [];
    if (isdefined(var_43605624)) {
        namespace_49107f3a::function_44eb090b();
        playsoundatposition("zmb_exit_taken", var_43605624.origin);
        level.doa.var_3f3f577d = var_43605624.script_noteworthy;
    }
}

// Namespace namespace_3ca3c537
// Params 2, eflags: 0x0
// Checksum 0x79f2f351, Offset: 0x3cf0
// Size: 0x1c7
function function_a8b0c139(trigger, objective_id) {
    objective_add(objective_id, "active", trigger.origin);
    function_4ccbe3a6(objective_id, 1, "default", "*");
    trigger thread function_47f8f274();
    level waittill(#"hash_7a1b7ce7");
    trigger triggerenable(1);
    trigger.open = 1;
    blockers = getentarray(trigger.target, "targetname");
    foreach (blocker in blockers) {
        blocker.origin -= (0, 0, 5000);
    }
    trigger waittill(#"trigger");
    trigger.open = 0;
    trigger triggerenable(0);
    foreach (blocker in blockers) {
        blocker.origin += (0, 0, 5000);
    }
    objective_delete(objective_id);
    wait 0.1;
    level notify(#"exit_taken", trigger);
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0x5d236d4, Offset: 0x3ec0
// Size: 0x39
function rotate() {
    self endon(#"death");
    while (true) {
        self rotateto(self.angles + (0, 180, 0), 4);
        wait 4;
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x0
// Checksum 0x3d33e4af, Offset: 0x3f08
// Size: 0x66
function function_2a9d778d() {
    location = struct::get(function_d2d75f5d() + "_doa_teleporter", "targetname");
    if (!isdefined(location)) {
        location = function_61d60e0b();
    } else {
        location = location.origin;
    }
    return location;
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x0
// Checksum 0x400d5a18, Offset: 0x3f78
// Size: 0x529
function function_4586479a(var_57e102cb) {
    if (!isdefined(var_57e102cb)) {
        var_57e102cb = 1;
    }
    location = struct::get(function_d2d75f5d() + "_doa_teleporter", "targetname");
    if (!isdefined(location)) {
        location = function_61d60e0b();
        if (!isdefined(location)) {
            return;
        }
    } else {
        location = location.origin;
    }
    if (var_57e102cb) {
        result = sprintf(%DOA_ROUNDCOMPLETE, level.doa.round_number);
        level thread namespace_49107f3a::function_c5f3ece8(result, undefined, -1);
        level thread namespace_49107f3a::function_37fb5c23(%DOA_TELEPORTER, undefined, -1);
    }
    start_point = location + (0, 0, -50);
    level.doa.teleporter = spawn("script_model", start_point);
    level.doa.teleporter setmodel("zombietron_teleporter");
    level.doa.teleporter enablelinkto();
    level.doa.teleporter thread namespace_eaa992c::function_285a2999("teleporter");
    level.doa.teleporter moveto(location + (0, 0, 5), 3, 0, 0);
    level.doa.teleporter thread rotate();
    physicsexplosionsphere(start_point, -56, -128, 4);
    level.doa.teleporter util::waittill_any_timeout(4, "movedone");
    physicsexplosionsphere(start_point, -56, -128, 3);
    level.doa.teleporter setmovingplatformenabled(1);
    level.doa.teleporter thread namespace_1a381543::function_90118d8c("zmb_teleporter_spawn");
    level.doa.teleporter playloopsound("zmb_teleporter_loop", 3);
    level.doa.teleporter.trigger = spawn("trigger_radius", location + (0, 0, -100), 0, 20, -56);
    level.doa.teleporter.trigger.targetname = "teleporter";
    /#
        if (isdefined(level.doa.var_33749c8)) {
            level.doa.teleporter.trigger thread namespace_49107f3a::function_a4d1f25e("<dev string:x9e>", randomfloatrange(0.1, 1));
        }
    #/
    level.doa.teleporter.trigger waittill(#"trigger", player);
    level notify(#"teleporter_triggered");
    foreach (player in getplayers()) {
        player notify(#"hash_d28ba89d");
    }
    if (var_57e102cb) {
        level notify(#"title1Fade");
        level notify(#"title2Fade");
    }
    playrumbleonposition("artillery_rumble", location);
    level.doa.teleporter stoploopsound(2);
    level.doa.teleporter thread namespace_1a381543::function_4f06fb8("zmb_teleporter_spawn");
    level notify(#"hash_ba37290e", "arenatransition");
    level.doa.teleporter thread namespace_1a381543::function_90118d8c("zmb_teleporter_tele_out");
    namespace_49107f3a::function_44eb090b();
    namespace_d88e3a06::function_116bb43();
    level.doa.teleporter.trigger delete();
    level.doa.teleporter delete();
    level.doa.teleporter = undefined;
}

