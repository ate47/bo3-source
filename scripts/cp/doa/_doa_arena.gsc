#using scripts/cp/doa/_doa_enemy_boss;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_player_challenge_room;
#using scripts/cp/doa/_doa_hazard;
#using scripts/cp/doa/_doa_round;
#using scripts/cp/doa/_doa_fate;
#using scripts/cp/doa/_doa_enemy;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/math_shared;
#using scripts/shared/array_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_3ca3c537;

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x5 linked
// Checksum 0x4c598588, Offset: 0x818
// Size: 0x1fc
function function_a55a134f() {
    arenas = struct::get_array("arena_center");
    for (i = 0; i < arenas.size; i++) {
        if (isdefined(arenas[i].script_parameters) && (isdefined(arenas[i].var_e121d9e4) && arenas[i].var_e121d9e4 || issubstr(arenas[i].script_parameters, "player_challenge"))) {
            level.doa.var_3c04d3df[level.doa.var_3c04d3df.size] = arenas[i];
            arenas[i].script_parameters = "99999";
            arenas[i].var_e121d9e4 = 1;
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
// Params 0, eflags: 0x1 linked
// Checksum 0xf565b438, Offset: 0xa20
// Size: 0x42c
function init() {
    /#
        assert(isdefined(level.doa));
    #/
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
    function_abd3b624("righteous", 36, 10, %DOA_RIGHTEOUS_ROOM, 36, "temple", undefined, 2);
    foreach (arena in level.doa.var_3c04d3df) {
        function_abd3b624(arena.script_noteworthy, 999, 13, istring("DOA_" + toupper(arena.script_noteworthy) + "_ROOM"), 999, arena.script_noteworthy, 120);
    }
    level.spawn_start["allies"][0] = level.doa.arenas[0];
    level.spawn_start["axis"][0] = level.doa.arenas[0];
    level thread namespace_49107f3a::set_lighting_state(0);
}

// Namespace namespace_3ca3c537
// Params 8, eflags: 0x5 linked
// Checksum 0xf0a5d45c, Offset: 0xe58
// Size: 0x26c
function function_abd3b624(name, minround, type, text, maxround, var_c9a1f25a, var_c92c30d9, var_6f369ab4) {
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
        /#
            assert(room.var_b1370bf0.size);
        #/
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0x59c952eb, Offset: 0x10d0
// Size: 0x128
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
    if (isdefined(level.doa.var_771e3915)) {
        level thread [[ level.doa.var_771e3915 ]]();
    }
}

// Namespace namespace_3ca3c537
// Params 2, eflags: 0x1 linked
// Checksum 0x69aacfc0, Offset: 0x1200
// Size: 0xfc
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
// Params 0, eflags: 0x1 linked
// Checksum 0xb3d96c9e, Offset: 0x1308
// Size: 0x1bc
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
        var_6f369ab4 = isdefined(room.var_6f369ab4) ? room.var_6f369ab4 : 1;
        if (isdefined(room.maxround) && room.var_57ce7582.size < var_6f369ab4 && level.doa.round_number >= room.maxround) {
            level.doa.var_161fb2a1 = room.type;
            level.doa.var_94073ca5 = room.name;
            return;
        }
    }
}

// Namespace namespace_3ca3c537
// Params 2, eflags: 0x5 linked
// Checksum 0x2b745c96, Offset: 0x14d0
// Size: 0x3c2
function function_6b351e04(type, var_436ba068) {
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
// Params 1, eflags: 0x1 linked
// Checksum 0xa025189, Offset: 0x18a0
// Size: 0x38
function function_85c94f67(room) {
    return room.type == 2 || room.type == 4;
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x1 linked
// Checksum 0x180b68d0, Offset: 0x18e0
// Size: 0x38
function function_35f13fc4(room) {
    return room.type == 9 || room.type == 10;
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x1 linked
// Checksum 0x40e1bc0a, Offset: 0x1920
// Size: 0x20
function function_b9e4794c(room) {
    return room.type == 13;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0x134f4e28, Offset: 0x1948
// Size: 0x16a
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
// Params 1, eflags: 0x5 linked
// Checksum 0x2f1e4221, Offset: 0x1ac0
// Size: 0xd70
function function_1c54aa82(room) {
    level.doa.var_677d1262 = 0;
    players = namespace_831a4a7c::function_5eb6e4d1();
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
    namespace_831a4a7c::function_82e3b1cb(1);
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
        level thread namespace_a7e6beb5::function_3238133b(level.doa.var_37366651, undefined, 2);
        level thread namespace_a7e6beb5::function_3238133b(level.doa.var_501f85b4, undefined, 1);
        break;
    case 1:
        flag::set("doa_bonusroom_active");
        function_8274c029();
        var_4833a640 = 1;
        level thread namespace_a7e6beb5::function_22d0e830(0, 2, randomfloatrange(2, 4));
        level thread namespace_a7e6beb5::function_3238133b(level.doa.var_37366651, undefined, 2);
        level thread namespace_a7e6beb5::function_3238133b(level.doa.var_501f85b4, undefined, 1);
        break;
    case 3:
        flag::set("doa_bonusroom_active");
        level thread namespace_a7e6beb5::function_22d0e830(0, 2, randomfloatrange(2, 4));
        level thread namespace_a7e6beb5::function_3238133b(level.doa.var_8d63e734, undefined, 1);
        level thread namespace_a7e6beb5::function_3238133b(level.doa.var_37366651, undefined, 2);
        level thread namespace_a7e6beb5::function_3238133b(level.doa.var_501f85b4, undefined, 1);
        spot = namespace_a7e6beb5::function_ac410a13();
        if (isdefined(spot)) {
            level namespace_a7e6beb5::function_3238133b(level.doa.var_43922ff2, spot.origin + (randomfloatrange(-30, 30), randomfloatrange(-30, 30), 0), 7);
            room.cooloff = gettime() + 30 * 60000;
        }
        if (randomint(100) < 5) {
            level namespace_a7e6beb5::function_3238133b(level.doa.var_468af4f0, spot.origin + (randomfloatrange(-30, 30), randomfloatrange(-30, 30), 0), 1 + randomintrange(0, 2));
        }
        break;
    case 4:
        flag::set("doa_bonusroom_active");
        level thread namespace_a7e6beb5::function_22d0e830(1, 5, 0.1);
        level thread namespace_a7e6beb5::function_22d0e830(0, 2, randomfloatrange(2, 4));
        level thread namespace_a7e6beb5::function_3238133b(level.doa.var_37366651, undefined, 2);
        level thread namespace_a7e6beb5::function_3238133b(level.doa.var_501f85b4, undefined, 1);
        room.cooloff = gettime() + 30 * 60000;
        break;
    case 6:
        flag::set("doa_bonusroom_active");
        foreach (player in getplayers()) {
            player notify(#"hash_d28ba89d");
        }
        level thread namespace_a7e6beb5::function_22d0e830(0, 2, randomfloatrange(2, 4));
        level namespace_a7e6beb5::function_3238133b(level.doa.var_f6947407, undefined, 2);
        level namespace_a7e6beb5::function_3238133b(level.doa.var_97bbae9c, undefined, 4);
        level namespace_a7e6beb5::function_3238133b(level.doa.var_f6e22ab8, undefined, 3);
        level thread namespace_a7e6beb5::function_3238133b(level.doa.var_37366651, undefined, 2);
        level thread namespace_a7e6beb5::function_3238133b(level.doa.var_501f85b4, undefined, 1);
        break;
    case 5:
        flag::set("doa_bonusroom_active");
        function_8274c029();
        var_4833a640 = 1;
        level.doa.var_a3a11449 = 1;
        level thread namespace_a7e6beb5::function_22d0e830(0, 2, randomfloatrange(2, 4));
        level thread namespace_a7e6beb5::function_3238133b(level.doa.var_37366651, undefined, 2);
        level thread namespace_a7e6beb5::function_3238133b(level.doa.var_501f85b4, undefined, 1);
        break;
    case 7:
        flag::set("doa_bonusroom_active");
        function_8274c029();
        var_4833a640 = 1;
        level thread namespace_a7e6beb5::function_22d0e830(0, 2, randomfloatrange(2, 4));
        level thread namespace_a7e6beb5::function_3238133b(level.doa.var_37366651, undefined, 2);
        level thread namespace_a7e6beb5::function_3238133b(level.doa.var_501f85b4, undefined, 1);
        break;
    case 8:
        flag::set("doa_bonusroom_active");
        function_8274c029();
        var_4833a640 = 1;
        level thread namespace_a7e6beb5::function_22d0e830(0, 2, randomfloatrange(2, 4));
        level thread namespace_a7e6beb5::function_3238133b(level.doa.var_37366651, undefined, 2);
        break;
    case 10:
        room.minround += 64;
        room.maxround += 64;
        function_ba9c838e();
        level.doa.var_6f2c52d8 = undefined;
        namespace_23f188a4::function_833dad0d();
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
        if (mayspawnentity()) {
            level.voice playsound("vox_doaa_bonus_room");
        }
        wait(1);
        level thread namespace_49107f3a::function_37fb5c23(room.text);
        wait(6);
        function_f64e4b70("all");
    }
    flag::clear("doa_bonusroom_active");
    function_5af67667(level.doa.var_e9339daa, 1);
    return true;
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x1 linked
// Checksum 0xfc08676f, Offset: 0x2838
// Size: 0x18c
function function_b0e9983(name) {
    count = 28;
    switch (name) {
    case 37:
        count = 33;
        break;
    case 38:
        count = 33;
        break;
    case 21:
        count = 23;
        break;
    case 41:
        count = 20;
        break;
    case 44:
        count = 18;
        break;
    case 43:
        count = 38;
        break;
    case 39:
        count = 40;
        break;
    case 42:
        count = 24;
        break;
    case 40:
        count = 38;
        break;
    }
    count += level.doa.var_da96f13c * 4;
    if (getplayers().size > 1) {
        count -= int(getplayers().size * 1.5);
    }
    count = math::clamp(count, 0, 40);
    return count;
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x5 linked
// Checksum 0x7dc3981a, Offset: 0x29d0
// Size: 0x10a
function function_9b67513c(name) {
    switch (name) {
    case 50:
        return 1;
    case 49:
        return 2;
    case 37:
        return 3;
    case 38:
        return 4;
    case 21:
        return 5;
    case 41:
        return 6;
    case 46:
        return 7;
    case 18:
        return 8;
    case 44:
        return 9;
    case 43:
        return 10;
    case 45:
        return 11;
    case 42:
        return 12;
    case 39:
        return 13;
    case 48:
        return 14;
    case 40:
        return 15;
    case 47:
        return 16;
    default:
        break;
    }
}

// Namespace namespace_3ca3c537
// Params 3, eflags: 0x5 linked
// Checksum 0xa8b851cc, Offset: 0x2ae8
// Size: 0x942
function function_b7dafa0c(name, center, valid) {
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
    /#
        if (isdefined(struct.var_160ae6c6)) {
            if (!struct.var_f616a3b7["DOA_ARMORY"].size && getdvarint("DOA_ARMORY", 0)) {
                namespace_49107f3a::debugmsg("DOA_ARMORY" + name);
            } else {
                /#
                    assert(struct.var_f616a3b7["DOA_ARMORY"].size);
                #/
            }
            if (!struct.var_f616a3b7["DOA_ARMORY"].size && getdvarint("DOA_ARMORY", 0)) {
                namespace_49107f3a::debugmsg("DOA_ARMORY" + name);
            } else {
                /#
                    assert(struct.var_f616a3b7["DOA_ARMORY"].size);
                #/
            }
            if (!struct.var_f616a3b7["DOA_ARMORY"].size && getdvarint("DOA_ARMORY", 0)) {
                namespace_49107f3a::debugmsg("DOA_ARMORY" + name);
            } else {
                /#
                    assert(struct.var_f616a3b7["DOA_ARMORY"].size);
                #/
            }
            if (!struct.var_f616a3b7["DOA_ARMORY"].size && getdvarint("DOA_ARMORY", 0)) {
                namespace_49107f3a::debugmsg("DOA_ARMORY" + name);
            } else {
                /#
                    assert(struct.var_f616a3b7["DOA_ARMORY"].size);
                #/
            }
            if (!struct.var_b1370bf0.size && getdvarint("DOA_ARMORY", 0)) {
                namespace_49107f3a::debugmsg("DOA_ARMORY" + name);
            } else {
                /#
                    assert(struct.var_b1370bf0.size);
                #/
            }
        }
    #/
    var_5fabae4f = struct::get(name + "_camera_fixed_point");
    if (isdefined(var_5fabae4f) && isdefined(var_5fabae4f.script_parameters)) {
        campos = strtok(var_5fabae4f.script_parameters, " ");
        /#
            assert(isdefined(campos.size == 3), "DOA_ARMORY" + name + "DOA_ARMORY");
        #/
        struct.var_2ac7f133 = (float(campos[0]), float(campos[1]), float(campos[2])) + center;
    }
    var_5fabae4f = struct::get(name + "_camera_fixed_point_flip");
    if (isdefined(var_5fabae4f) && isdefined(var_5fabae4f.script_parameters)) {
        campos = strtok(var_5fabae4f.script_parameters, " ");
        /#
            assert(isdefined(campos.size == 3), "DOA_ARMORY" + name + "DOA_ARMORY");
        #/
        struct.var_5a97f5e9 = (float(campos[0]), float(campos[1]), float(campos[2])) + center;
    }
    /#
        assert(isdefined(struct.var_d88cc53c), "DOA_ARMORY" + name + "DOA_ARMORY");
    #/
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
// Params 0, eflags: 0x1 linked
// Checksum 0x9b3e9add, Offset: 0x3438
// Size: 0x2e
function function_5295ea97() {
    return level.doa.arenas[level.doa.var_90873830].var_160ae6c6;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0x258a26e9, Offset: 0x3470
// Size: 0x2e
function function_dc34896f() {
    return level.doa.arenas[level.doa.var_90873830].var_d88cc53c;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0xd6c726c4, Offset: 0x34a8
// Size: 0x12a
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
// Params 0, eflags: 0x1 linked
// Checksum 0x2ecccc96, Offset: 0x35e0
// Size: 0x50
function function_d2d75f5d() {
    if (isdefined(level.doa.arenas)) {
        return level.doa.arenas[level.doa.var_90873830].name;
    }
    return "island";
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x1 linked
// Checksum 0x19c108d8, Offset: 0x3638
// Size: 0x70
function function_5835533a(name) {
    for (i = 0; i < level.doa.arenas.size; i++) {
        if (level.doa.arenas[i].name == name) {
            return i;
        }
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0x205c40a0, Offset: 0x36b0
// Size: 0x74
function function_5147636f() {
    if (level.doa.flipped) {
        return level.doa.arenas[level.doa.var_90873830].var_5a97f5e9;
    }
    return level.doa.arenas[level.doa.var_90873830].var_2ac7f133;
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0x27f58862, Offset: 0x3730
// Size: 0x2e
function function_a8f91d6f() {
    return level.doa.arenas[level.doa.var_90873830].exits;
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x1 linked
// Checksum 0x51f5039f, Offset: 0x3768
// Size: 0x7c
function function_ba9c838e(var_c56d15c4) {
    if (!isdefined(var_c56d15c4)) {
        var_c56d15c4 = 0;
    }
    level.doa.flipped = 0;
    level clientfield::set("flipCamera", var_c56d15c4 == 0 ? 1 : 0);
    settopdowncamerayaw(0);
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0x2b6528bc, Offset: 0x37f0
// Size: 0x54
function function_8274c029() {
    level.doa.flipped = 1;
    level clientfield::set("flipCamera", 2);
    settopdowncamerayaw(-76);
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x1 linked
// Checksum 0xa0671406, Offset: 0x3850
// Size: 0x410
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
// Params 1, eflags: 0x1 linked
// Checksum 0xf15759ee, Offset: 0x3c68
// Size: 0x70
function function_a6c926fc(holdtime) {
    level.var_3259f885 = 1;
    level clientfield::set("overworld", 1);
    wait(holdtime);
    level clientfield::set("overworld", 0);
    level.var_3259f885 = 0;
}

// Namespace namespace_3ca3c537
// Params 2, eflags: 0x1 linked
// Checksum 0x19c20796, Offset: 0x3ce0
// Size: 0x2bc
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
        level.doa.var_5bd7f25a -= 2000;
        if (level.doa.var_5bd7f25a < 2000) {
            level.doa.var_5bd7f25a = 2000;
        }
        level.doa.var_c061227e += 0.05;
        if (level.doa.var_c061227e > 1.15) {
            level.doa.var_c061227e = 1.15;
        }
        function_8b90b6a7();
        level flag::clear("doa_game_is_completed");
    }
    level.doa.var_90873830 = var_7dd30d23;
    level notify(#"hash_ec7ca67b");
    level clientfield::set("arenaUpdate", level.doa.var_90873830);
    util::wait_network_frame();
    level thread function_a50a72db();
    level thread function_1c812a03();
    level thread function_fd84aa1f();
    level.doa.var_3361a074 = struct::get_array(function_d2d75f5d() + "_pickup", "targetname");
    level thread namespace_49107f3a::set_lighting_state(level.doa.var_458c27d);
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0xd95e3b1d, Offset: 0x3fa8
// Size: 0x30
function function_fd84aa1f() {
    if (isdefined(level.var_fd84aa1f)) {
        [[ level.var_fd84aa1f ]](function_d2d75f5d());
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0xed32f78c, Offset: 0x3fe0
// Size: 0x1f8
function function_a50a72db() {
    level endon(#"hash_ec7ca67b");
    level endon(#"hash_24d3a44");
    level notify(#"hash_a50a72db");
    level endon(#"hash_a50a72db");
    level waittill(#"hash_3b6e1e2");
    var_d88cc53c = function_dc34896f();
    wait(1);
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
        wait(0.05);
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0x2716e4b4, Offset: 0x41e0
// Size: 0xae
function function_1c812a03() {
    platforms = getentarray(function_d2d75f5d() + "_moving_platform", "targetname");
    for (i = 0; i < platforms.size; i++) {
        platforms[i] thread function_573ad24e();
        platforms[i] thread function_7d65367c();
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0xad42c605, Offset: 0x4298
// Size: 0x2b2
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
        self thread function_852998f1(trigger);
    }
    switch (self.script_noteworthy) {
    case 82:
        target = getent(self.target, "targetname");
        if (!isdefined(target)) {
            target = struct::get(self.target, "targetname");
        }
        /#
            assert(isdefined(target));
        #/
        while (true) {
            self moveto(target.origin, self.script_parameters);
            self util::waittill_any_timeout(self.script_parameters + 2, "movedone");
            wait(1);
            self moveto(var_febfbf3a, self.script_parameters);
            self util::waittill_any_timeout(self.script_parameters + 2, "movedone");
        }
        break;
    }
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x1 linked
// Checksum 0x1e648ed8, Offset: 0x4558
// Size: 0x344
function function_852998f1(trigger) {
    level endon(#"hash_ec7ca67b");
    wait(0.4);
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
        wait(0.05);
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0xa4c02f11, Offset: 0x48a8
// Size: 0x18a
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
// Params 0, eflags: 0x5 linked
// Checksum 0x2f4c56e6, Offset: 0x4a40
// Size: 0x4a
function function_47f8f274() {
    wait(0.1);
    level util::waittill_any("exit_taken", "doa_game_is_over");
    wait(0.05);
    self notify(#"trigger");
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x5 linked
// Checksum 0x938a7459, Offset: 0x4a98
// Size: 0xa8
function function_17665174(trigger) {
    level endon(#"exit_taken");
    level endon(#"doa_game_is_over");
    trigger waittill(#"trigger");
    level.doa.var_c03fe5f1 = function_6b351e04(level.doa.var_161fb2a1, level.doa.var_94073ca5);
    if (isdefined(level.doa.var_c03fe5f1)) {
        level.doa.var_f2108348 = level.doa.round_number;
    }
}

// Namespace namespace_3ca3c537
// Params 1, eflags: 0x1 linked
// Checksum 0x733ff9c3, Offset: 0x4b48
// Size: 0x5bc
function function_f64e4b70(specific) {
    while (isdefined(level.doa.var_9b77ca48) && level.doa.var_9b77ca48) {
        wait(0.25);
    }
    level notify(#"hash_31b5dd0d");
    level.doa.var_53d0f8a7 = [];
    if (!isdefined(level.doa.var_c03fe5f1)) {
        level clientfield::set("roundMenu", 1);
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
                var_46876357[i] thread namespace_49107f3a::function_a4d1f25e("DOA_ARMORY", randomfloatrange(0.5, 1));
            }
        #/
        wait(0.2);
    }
    level notify(#"hash_7a1b7ce7");
    /#
        assert(level.doa.var_53d0f8a7.size != 0, "DOA_ARMORY");
    #/
    level clientfield::set("numexits", level.doa.var_53d0f8a7.size);
    if (level.doa.var_53d0f8a7.size > 1) {
    }
    var_43605624 = level waittill(#"exit_taken");
    level.doa.var_161fb2a1 = undefined;
    level.doa.var_94073ca5 = undefined;
    level notify(#"hash_b96c96ac");
    level notify(#"hash_97276c43");
    level.doa.var_53d0f8a7 = [];
    if (isdefined(var_43605624)) {
        namespace_49107f3a::function_44eb090b();
        playsoundatposition("zmb_exit_taken", var_43605624.origin);
        level.doa.var_3f3f577d = var_43605624.script_noteworthy;
    }
    level clientfield::set("roundMenu", 0);
    level clientfield::set("teleportMenu", 0);
    level clientfield::set("numexits", 0);
}

// Namespace namespace_3ca3c537
// Params 2, eflags: 0x1 linked
// Checksum 0x3f744b63, Offset: 0x5110
// Size: 0x34a
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
    while (true) {
        guy = trigger waittill(#"trigger");
        if (isdefined(guy) && !isplayer(guy)) {
            continue;
        }
        break;
    }
    trigger.open = 0;
    trigger triggerenable(0);
    foreach (blocker in blockers) {
        blocker.origin += (0, 0, 5000);
    }
    objective_delete(objective_id);
    wait(0.1);
    level notify(#"exit_taken", trigger);
    foreach (player in getplayers()) {
        player notify(#"exit_taken");
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0x51c3cd3, Offset: 0x5468
// Size: 0x4e
function rotate() {
    self endon(#"death");
    while (true) {
        self rotateto(self.angles + (0, 180, 0), 4);
        wait(4);
    }
}

// Namespace namespace_3ca3c537
// Params 0, eflags: 0x1 linked
// Checksum 0x3a47301f, Offset: 0x54c0
// Size: 0x84
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
// Params 1, eflags: 0x1 linked
// Checksum 0xda3cdf23, Offset: 0x5550
// Size: 0x6ca
function function_4586479a(var_57e102cb) {
    if (!isdefined(var_57e102cb)) {
        var_57e102cb = 1;
    }
    while (isdefined(level.doa.var_9b77ca48) && level.doa.var_9b77ca48) {
        wait(0.25);
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
        level clientfield::set("roundMenu", 1);
        level clientfield::set("teleportMenu", 1);
    }
    start_point = location + (0, 0, -50);
    level.doa.teleporter = spawn("script_model", start_point);
    level.doa.teleporter endon(#"death");
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
            level.doa.teleporter.trigger thread namespace_49107f3a::function_a4d1f25e("DOA_ARMORY", randomfloatrange(0.1, 1));
        }
    #/
    player = level.doa.teleporter.trigger waittill(#"trigger");
    level notify(#"hash_6df89d17");
    level notify(#"hash_3b432f18");
    foreach (player in getplayers()) {
        player notify(#"hash_d28ba89d");
    }
    if (var_57e102cb) {
        level notify(#"hash_b96c96ac");
        level notify(#"hash_97276c43");
    }
    playrumbleonposition("artillery_rumble", location);
    level.doa.teleporter stoploopsound(2);
    level.doa.teleporter thread namespace_1a381543::function_4f06fb8("zmb_teleporter_spawn");
    level notify(#"hash_ba37290e", "arenatransition");
    level.doa.teleporter thread namespace_1a381543::function_90118d8c("zmb_teleporter_tele_out");
    namespace_49107f3a::function_44eb090b();
    level clientfield::set("roundMenu", 0);
    level clientfield::set("teleportMenu", 0);
    level clientfield::set("numexits", 0);
    level namespace_49107f3a::set_lighting_state(0);
    level clientfield::set("arenaRound", 5);
    namespace_d88e3a06::function_116bb43();
    level.doa.teleporter.trigger delete();
    level.doa.teleporter delete();
    level.doa.teleporter = undefined;
}

