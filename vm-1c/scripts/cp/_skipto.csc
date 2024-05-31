#using scripts/shared/audio_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/postfx_shared;
#using scripts/shared/load_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace skipto;

// Namespace skipto
// Params 0, eflags: 0x2
// namespace_1d795d47<file_0>::function_2dc19561
// Checksum 0xf6497cb8, Offset: 0x2f0
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("skipto", &__init__, &__main__, undefined);
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_8c87d8eb
// Checksum 0xb395c696, Offset: 0x338
// Size: 0x18c
function __init__() {
    level flag::init("running_skipto");
    level flag::init("level_has_skiptos");
    level flag::init("level_has_skipto_branches");
    level.var_fee90489 = [];
    clientfield::register("toplayer", "catch_up_transition", 1, 1, "counter", &catch_up_transition, 0, 0);
    clientfield::register("world", "set_last_map_dvar", 1, 1, "counter", &set_last_map_dvar, 0, 0);
    function_fcea19f2("_default");
    function_fcea19f2("no_game");
    function_7c1e8577("gamedata/tables/cp/cp_mapmissions.csv", getdvarstring("mapname"));
    level thread function_8ed81a86();
    level thread function_91c7f6af();
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_5b6b9132
// Checksum 0xdc31582f, Offset: 0x4d0
// Size: 0xcc
function __main__() {
    level thread handle();
    var_cb97644f = getuimodel(getglobaluimodel(), "nextMap");
    if (!util::is_safehouse()) {
        var_cb97644f = createuimodel(getglobaluimodel(), "nextMap");
        setuimodelvalue(var_cb97644f, getdvarstring("ui_mapname"));
    }
}

// Namespace skipto
// Params 6, eflags: 0x0
// namespace_1d795d47<file_0>::function_69554b3e
// Checksum 0xcfa0fcf, Offset: 0x5a8
// Size: 0x32c
function add(skipto, func, var_d01f133f, cleanup_func, var_46c5ea43, var_c3efda96) {
    if (!isdefined(level.var_574eb415)) {
        level.var_574eb415 = skipto;
    }
    if (is_dev(skipto)) {
        errormsg("world");
        return;
    }
    if (isdefined(var_46c5ea43) || isdefined(var_c3efda96)) {
        errormsg("world");
        return;
    }
    if (level flag::get("level_has_skipto_branches")) {
        errormsg("world");
    }
    if (!isdefined(var_46c5ea43)) {
        if (isdefined(level.var_8b767436)) {
            if (isdefined(level.var_e07f6589[level.var_8b767436])) {
                if (!isdefined(level.var_e07f6589[level.var_8b767436].var_c3efda96) || level.var_e07f6589[level.var_8b767436].var_c3efda96.size < 1) {
                    if (!isdefined(level.var_e07f6589[level.var_8b767436].var_c3efda96)) {
                        level.var_e07f6589[level.var_8b767436].var_c3efda96 = [];
                    } else if (!isarray(level.var_e07f6589[level.var_8b767436].var_c3efda96)) {
                        level.var_e07f6589[level.var_8b767436].var_c3efda96 = array(level.var_e07f6589[level.var_8b767436].var_c3efda96);
                    }
                }
                level.var_e07f6589[level.var_8b767436].var_c3efda96[level.var_e07f6589[level.var_8b767436].var_c3efda96.size] = skipto;
            }
        }
        if (isdefined(level.var_8b767436)) {
            var_46c5ea43 = level.var_8b767436;
        }
        level.var_8b767436 = skipto;
    }
    if (!isdefined(func)) {
        assert(isdefined(func), "world");
    }
    struct = function_fcea19f2(skipto, func, var_d01f133f, cleanup_func, var_46c5ea43, var_c3efda96);
    struct.public = 1;
    level flag::set("level_has_skiptos");
}

// Namespace skipto
// Params 6, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_731571ad
// Checksum 0xea0b4b2d, Offset: 0x8e0
// Size: 0x314
function function_731571ad(skipto, func, var_d01f133f, cleanup_func, var_46c5ea43, var_c3efda96) {
    if (!isdefined(level.var_574eb415)) {
        level.var_574eb415 = skipto;
    }
    if (is_dev(skipto)) {
        errormsg("world");
        return;
    }
    if (!isdefined(var_46c5ea43) && !isdefined(var_c3efda96)) {
        errormsg("world");
        return;
    }
    if (!isdefined(var_46c5ea43)) {
        if (isdefined(level.var_8b767436)) {
            if (isdefined(level.var_e07f6589[level.var_8b767436])) {
                if (!isdefined(level.var_e07f6589[level.var_8b767436].var_c3efda96) || level.var_e07f6589[level.var_8b767436].var_c3efda96.size < 1) {
                    if (!isdefined(level.var_e07f6589[level.var_8b767436].var_c3efda96)) {
                        level.var_e07f6589[level.var_8b767436].var_c3efda96 = [];
                    } else if (!isarray(level.var_e07f6589[level.var_8b767436].var_c3efda96)) {
                        level.var_e07f6589[level.var_8b767436].var_c3efda96 = array(level.var_e07f6589[level.var_8b767436].var_c3efda96);
                    }
                }
                level.var_e07f6589[level.var_8b767436].var_c3efda96[level.var_e07f6589[level.var_8b767436].var_c3efda96.size] = skipto;
            }
        }
        if (isdefined(level.var_8b767436)) {
            var_46c5ea43 = level.var_8b767436;
        }
        level.var_8b767436 = skipto;
    }
    if (!isdefined(func)) {
        assert(isdefined(func), "world");
    }
    struct = function_fcea19f2(skipto, func, var_d01f133f, cleanup_func, var_46c5ea43, var_c3efda96);
    struct.public = 1;
    level flag::set("level_has_skiptos");
    level flag::set("level_has_skipto_branches");
}

// Namespace skipto
// Params 6, eflags: 0x0
// namespace_1d795d47<file_0>::function_654c9dda
// Checksum 0x1e4797c, Offset: 0xc00
// Size: 0xd4
function add_dev(skipto, func, var_d01f133f, cleanup_func, var_46c5ea43, var_c3efda96) {
    if (!isdefined(level.var_574eb415)) {
        level.var_574eb415 = skipto;
    }
    if (is_dev(skipto)) {
        struct = function_fcea19f2(skipto, func, var_d01f133f, cleanup_func, var_46c5ea43, var_c3efda96);
        struct.var_3c612393 = 1;
        return;
    }
    errormsg("world");
}

// Namespace skipto
// Params 6, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_fcea19f2
// Checksum 0x3adc9a1f, Offset: 0xce0
// Size: 0xc6
function function_fcea19f2(msg, func, var_d01f133f, cleanup_func, var_46c5ea43, var_c3efda96) {
    assert(!isdefined(level._loadstarted), "world");
    msg = tolower(msg);
    struct = function_b545fa58(msg, func, var_d01f133f, cleanup_func, var_46c5ea43, var_c3efda96);
    level.var_e07f6589[msg] = struct;
    return struct;
}

// Namespace skipto
// Params 6, eflags: 0x0
// namespace_1d795d47<file_0>::function_5f5f81d1
// Checksum 0x1888b6dc, Offset: 0xdb0
// Size: 0x194
function change(msg, func, var_d01f133f, cleanup_func, var_46c5ea43, var_c3efda96) {
    struct = level.var_e07f6589[msg];
    if (isdefined(func)) {
        struct.var_1ca15390 = func;
    }
    if (isdefined(var_d01f133f)) {
        struct.var_4537ac00 = var_d01f133f;
    }
    if (isdefined(cleanup_func)) {
        struct.cleanup_func = cleanup_func;
    }
    if (isdefined(var_46c5ea43)) {
        if (!isdefined(struct.var_46c5ea43)) {
            struct.var_46c5ea43 = [];
        } else if (!isarray(struct.var_46c5ea43)) {
            struct.var_46c5ea43 = array(struct.var_46c5ea43);
        }
        struct.var_46c5ea43[struct.var_46c5ea43.size] = var_46c5ea43;
    }
    if (isdefined(var_c3efda96)) {
        struct.var_c3efda96 = strtok(var_c3efda96, ",");
        struct.next = struct.var_c3efda96;
    }
}

// Namespace skipto
// Params 1, eflags: 0x0
// namespace_1d795d47<file_0>::function_f578c05a
// Checksum 0x11ce4f04, Offset: 0xf50
// Size: 0x18
function function_f578c05a(func) {
    level.var_ba8dfc5d = func;
}

// Namespace skipto
// Params 6, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_b545fa58
// Checksum 0xfa7ca7cb, Offset: 0xf70
// Size: 0x1f8
function function_b545fa58(msg, func, var_d01f133f, cleanup_func, var_46c5ea43, var_c3efda96) {
    struct = spawnstruct();
    struct.name = msg;
    struct.var_1ca15390 = func;
    struct.var_4537ac00 = var_d01f133f;
    struct.cleanup_func = cleanup_func;
    struct.next = [];
    struct.prev = [];
    struct.var_f8c3deec = "";
    struct.var_46c5ea43 = [];
    if (isdefined(var_46c5ea43)) {
        if (!isdefined(struct.var_46c5ea43)) {
            struct.var_46c5ea43 = [];
        } else if (!isarray(struct.var_46c5ea43)) {
            struct.var_46c5ea43 = array(struct.var_46c5ea43);
        }
        struct.var_46c5ea43[struct.var_46c5ea43.size] = var_46c5ea43;
    }
    struct.var_c3efda96 = [];
    if (isdefined(var_c3efda96)) {
        struct.var_c3efda96 = strtok(var_c3efda96, ",");
        struct.next = struct.var_c3efda96;
    }
    struct.var_17618905 = [];
    return struct;
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_5771edb2
// Checksum 0x4df09a09, Offset: 0x1170
// Size: 0x71c
function function_5771edb2() {
    foreach (struct in level.var_e07f6589) {
        if (isdefined(struct.public) && struct.public) {
            if (struct.var_46c5ea43.size) {
                foreach (var_46c5ea43 in struct.var_46c5ea43) {
                    if (isdefined(level.var_e07f6589[var_46c5ea43])) {
                        if (!isinarray(level.var_e07f6589[var_46c5ea43].next, struct.name)) {
                            if (!isdefined(level.var_e07f6589[var_46c5ea43].next)) {
                                level.var_e07f6589[var_46c5ea43].next = [];
                            } else if (!isarray(level.var_e07f6589[var_46c5ea43].next)) {
                                level.var_e07f6589[var_46c5ea43].next = array(level.var_e07f6589[var_46c5ea43].next);
                            }
                            level.var_e07f6589[var_46c5ea43].next[level.var_e07f6589[var_46c5ea43].next.size] = struct.name;
                        }
                        continue;
                    }
                    if (!isdefined(level.var_e07f6589["_default"].next)) {
                        level.var_e07f6589["_default"].next = [];
                    } else if (!isarray(level.var_e07f6589["_default"].next)) {
                        level.var_e07f6589["_default"].next = array(level.var_e07f6589["_default"].next);
                    }
                    level.var_e07f6589["_default"].next[level.var_e07f6589["_default"].next.size] = struct.name;
                }
            } else {
                if (!isdefined(level.var_e07f6589["_default"].next)) {
                    level.var_e07f6589["_default"].next = [];
                } else if (!isarray(level.var_e07f6589["_default"].next)) {
                    level.var_e07f6589["_default"].next = array(level.var_e07f6589["_default"].next);
                }
                level.var_e07f6589["_default"].next[level.var_e07f6589["_default"].next.size] = struct.name;
            }
            foreach (var_c3efda96 in struct.var_c3efda96) {
                if (isdefined(level.var_e07f6589[var_c3efda96])) {
                    if (!isdefined(level.var_e07f6589[var_c3efda96].prev)) {
                        level.var_e07f6589[var_c3efda96].prev = [];
                    } else if (!isarray(level.var_e07f6589[var_c3efda96].prev)) {
                        level.var_e07f6589[var_c3efda96].prev = array(level.var_e07f6589[var_c3efda96].prev);
                    }
                    level.var_e07f6589[var_c3efda96].prev[level.var_e07f6589[var_c3efda96].prev.size] = struct.name;
                }
            }
        }
    }
    foreach (struct in level.var_e07f6589) {
        if (isdefined(struct.public) && struct.public) {
            if (struct.next.size < 1) {
                if (!isdefined(struct.next)) {
                    struct.next = [];
                } else if (!isarray(struct.next)) {
                    struct.next = array(struct.next);
                }
                struct.next[struct.next.size] = "_exit";
            }
        }
    }
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_a363b4b1
// Checksum 0x3ad732f, Offset: 0x1898
// Size: 0x60
function is_dev(skipto) {
    substr = tolower(getsubstr(skipto, 0, 4));
    if (substr == "dev_") {
        return true;
    }
    return false;
}

// Namespace skipto
// Params 0, eflags: 0x0
// namespace_1d795d47<file_0>::function_f170bfd5
// Checksum 0x101492ef, Offset: 0x1900
// Size: 0x22
function function_f170bfd5() {
    return level flag::get("level_has_skiptos");
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_8b19ec5d
// Checksum 0x5fbed789, Offset: 0x1930
// Size: 0x64
function function_8b19ec5d() {
    skiptos = tolower(getskiptos());
    result = strtok(skiptos, ",");
    return result;
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_bfb3493
// Checksum 0x934f972, Offset: 0x19a0
// Size: 0xb8
function handle() {
    function_b2c47917();
    function_5771edb2();
    function_3b25fd7e();
    skiptos = function_8b19ec5d();
    function_c4c27da4(skiptos, 1);
    while (true) {
        level waittill(#"skiptos_changed");
        skiptos = function_8b19ec5d();
        function_c4c27da4(skiptos, 0);
    }
}

// Namespace skipto
// Params 1, eflags: 0x0
// namespace_1d795d47<file_0>::function_2ece423b
// Checksum 0x17e5378, Offset: 0x1a60
// Size: 0x18
function function_2ece423b(func) {
    level.var_ba8dfc5d = func;
}

// Namespace skipto
// Params 1, eflags: 0x0
// namespace_1d795d47<file_0>::function_574eb415
// Checksum 0x4a331fdb, Offset: 0x1a80
// Size: 0x18
function function_574eb415(skipto) {
    level.var_574eb415 = skipto;
}

// Namespace skipto
// Params 3, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_6542f12c
// Checksum 0x3ce8a45c, Offset: 0x1aa0
// Size: 0x108
function function_6542f12c(str, var_2397f00d, var_3340d044) {
    sarray = strtok(str, var_2397f00d);
    var_e1dfd87d = "";
    first = 1;
    foreach (s in sarray) {
        if (!first) {
            var_e1dfd87d += var_3340d044;
        }
        first = 0;
        var_e1dfd87d += s;
    }
    return var_e1dfd87d;
}

// Namespace skipto
// Params 3, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_7c1e8577
// Checksum 0xbc62726f, Offset: 0x1bb0
// Size: 0x174
function function_7c1e8577(table, levelname, var_310b47e9) {
    if (!isdefined(var_310b47e9)) {
        var_310b47e9 = "";
    }
    index = 0;
    for (row = tablelookuprow(table, index); isdefined(row); row = tablelookuprow(table, index)) {
        if (row[0] == levelname && row[1] == var_310b47e9) {
            skipto = row[2];
            var_46c5ea43 = row[3];
            var_c3efda96 = row[4];
            var_c3efda96 = function_6542f12c(var_c3efda96, "+", ",");
            locstr = row[5];
            function_731571ad(skipto, &function_89a9b10f, locstr, undefined, var_46c5ea43, var_c3efda96);
        }
        index++;
    }
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_89a9b10f
// Checksum 0x99ec1590, Offset: 0x1d30
// Size: 0x4
function function_89a9b10f() {
    
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_b2c47917
// Checksum 0xd45890a5, Offset: 0x1d40
// Size: 0x24
function function_b2c47917() {
    level flag::wait_till("skipto_player_connected");
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_8ed81a86
// Checksum 0x7dbc5bf9, Offset: 0x1d70
// Size: 0x6c
function function_8ed81a86() {
    if (!level flag::exists("skipto_player_connected")) {
        level flag::init("skipto_player_connected");
    }
    callback::add_callback(#"hash_da8d7d74", &on_player_connect);
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_fb4f96b5
// Checksum 0x1f49fbec, Offset: 0x1de8
// Size: 0x2c
function on_player_connect(localclientnum) {
    level flag::set("skipto_player_connected");
}

// Namespace skipto
// Params 2, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_c4c27da4
// Checksum 0xc1f392ea, Offset: 0x1e20
// Size: 0x2a4
function function_c4c27da4(objectives, starting) {
    function_c951eb3d();
    if (starting) {
        foreach (objective in objectives) {
            if (isdefined(level.var_e07f6589[objective])) {
                function_2d700bc6(level.var_e07f6589[objective].prev, starting);
            }
        }
    } else {
        foreach (skipto in level.var_e07f6589) {
            if (isdefined(skipto.var_e27d380a) && skipto.var_e27d380a && !isinarray(objectives, skipto.name)) {
                function_2d700bc6(skipto.name, starting);
            }
        }
    }
    if (isdefined(level.var_ba8dfc5d)) {
        foreach (name in objectives) {
            thread [[ level.var_ba8dfc5d ]](name);
        }
    }
    function_bfe10ae8(objectives, starting);
    level.var_31aefea8 = level.var_fee90489[0];
    level notify(#"objective_changed", level.var_fee90489);
    level.var_fee90489 = objectives;
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_3b25fd7e
// Checksum 0x53504fc9, Offset: 0x20d0
// Size: 0xe6
function function_3b25fd7e(objectives) {
    foreach (skipto in level.var_e07f6589) {
        if (!(isdefined(skipto.var_b992dc79) && skipto.var_b992dc79)) {
            skipto.var_b992dc79 = 1;
            if (isdefined(skipto.var_4dfe0d36)) {
                thread [[ skipto.var_4dfe0d36 ]](skipto.name);
            }
        }
    }
}

// Namespace skipto
// Params 2, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_bfe10ae8
// Checksum 0x546751aa, Offset: 0x21c0
// Size: 0x220
function function_bfe10ae8(name, starting) {
    if (isarray(name)) {
        foreach (element in name) {
            function_bfe10ae8(element, starting);
        }
        return;
    }
    if (isdefined(level.var_e07f6589[name])) {
        if (!(isdefined(level.var_e07f6589[name].var_e27d380a) && level.var_e07f6589[name].var_e27d380a)) {
            if (!isinarray(level.var_fee90489, name)) {
                if (!isdefined(level.var_fee90489)) {
                    level.var_fee90489 = [];
                } else if (!isarray(level.var_fee90489)) {
                    level.var_fee90489 = array(level.var_fee90489);
                }
                level.var_fee90489[level.var_fee90489.size] = name;
            }
            level notify(name + "_init");
            level.var_e07f6589[name].var_e27d380a = 1;
            function_b342abc7(name, starting);
            if (isdefined(level.var_e07f6589[name].var_1ca15390)) {
                thread [[ level.var_e07f6589[name].var_1ca15390 ]](name, starting);
            }
        }
    }
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_c951eb3d
// Checksum 0x67897d1c, Offset: 0x23e8
// Size: 0x86
function function_c951eb3d() {
    foreach (skipto in level.var_e07f6589) {
        skipto.var_62e39772 = 0;
    }
}

// Namespace skipto
// Params 2, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_2d700bc6
// Checksum 0x43e8b003, Offset: 0x2478
// Size: 0x2e4
function function_2d700bc6(name, starting) {
    if (isarray(name)) {
        foreach (element in name) {
            function_2d700bc6(element, starting);
        }
        return;
    }
    if (isdefined(level.var_e07f6589[name])) {
        cleaned = 0;
        if (isdefined(level.var_e07f6589[name].var_e27d380a) && level.var_e07f6589[name].var_e27d380a) {
            cleaned = 1;
            level.var_e07f6589[name].var_e27d380a = 0;
            if (isinarray(level.var_fee90489, name)) {
                arrayremovevalue(level.var_fee90489, name);
            }
            if (isdefined(level.var_e07f6589[name].cleanup_func)) {
                thread [[ level.var_e07f6589[name].cleanup_func ]](name, starting);
            }
            function_77ff537d(name, starting);
            level notify(name + "_terminate");
        }
        if (starting && !(isdefined(level.var_e07f6589[name].var_62e39772) && level.var_e07f6589[name].var_62e39772)) {
            level.var_e07f6589[name].var_62e39772 = 1;
            function_2d700bc6(level.var_e07f6589[name].prev, starting);
            if (!cleaned) {
                if (isdefined(level.var_e07f6589[name].cleanup_func)) {
                    thread [[ level.var_e07f6589[name].cleanup_func ]](name, starting);
                }
                function_77ff537d(name, starting);
            }
        }
    }
}

// Namespace skipto
// Params 7, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_7bb63f2f
// Checksum 0xd4574b8d, Offset: 0x2768
// Size: 0x7c
function set_last_map_dvar(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    missionname = getdvarstring("ui_mapname");
    setdvar("last_map", missionname);
}

// Namespace skipto
// Params 2, eflags: 0x5 linked
// namespace_1d795d47<file_0>::function_b342abc7
// Checksum 0x27dddc59, Offset: 0x27f0
// Size: 0x14
function private function_b342abc7(objective, starting) {
    
}

// Namespace skipto
// Params 2, eflags: 0x5 linked
// namespace_1d795d47<file_0>::function_77ff537d
// Checksum 0x281598c5, Offset: 0x2810
// Size: 0x14
function private function_77ff537d(objective, starting) {
    
}

// Namespace skipto
// Params 7, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_697ada60
// Checksum 0x4fc21311, Offset: 0x2830
// Size: 0x54
function catch_up_transition(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    postfx::playpostfxbundle("pstfx_cp_transition_sprite");
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// namespace_1d795d47<file_0>::function_91c7f6af
// Checksum 0xaae5bfd5, Offset: 0x2890
// Size: 0x2c
function function_91c7f6af() {
    level waittill(#"aar");
    audio::snd_set_snapshot("cmn_aar_screen");
}

