#using scripts/cp/gametypes/_spawnlogic;
#using scripts/cp/gametypes/_spawning;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/_globallogic_player;
#using scripts/cp/_challenges;
#using scripts/cp/_bb;
#using scripts/cp/_util;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_decorations;
#using scripts/cp/_accolades;
#using scripts/cp/_achievements;
#using scripts/shared/player_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/rank_shared;
#using scripts/shared/music_shared;
#using scripts/shared/load_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace skipto;

// Namespace skipto
// Params 0, eflags: 0x2
// Checksum 0xb3e302f9, Offset: 0x1008
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("skipto", &__init__, &__main__, undefined);
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0xeb808336, Offset: 0x1050
// Size: 0x18
function function_97bb1111(mapname) {
    return mapname + "_nightmares";
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x5333694a, Offset: 0x1070
// Size: 0x178
function function_23eda99c() {
    var_cfc9cbb7 = [];
    array::add(var_cfc9cbb7, "cp_mi_cairo_aquifer");
    array::add(var_cfc9cbb7, "cp_mi_cairo_infection");
    array::add(var_cfc9cbb7, "cp_mi_cairo_lotus");
    array::add(var_cfc9cbb7, "cp_mi_cairo_ramses");
    array::add(var_cfc9cbb7, "cp_mi_eth_prologue");
    array::add(var_cfc9cbb7, "cp_mi_sing_biodomes");
    array::add(var_cfc9cbb7, "cp_mi_sing_blackstation");
    array::add(var_cfc9cbb7, "cp_mi_sing_sgen");
    array::add(var_cfc9cbb7, "cp_mi_sing_vengeance");
    array::add(var_cfc9cbb7, "cp_mi_zurich_coalescence");
    array::add(var_cfc9cbb7, "cp_mi_zurich_newworld");
    return var_cfc9cbb7;
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x6cd7d766, Offset: 0x11f0
// Size: 0x27c
function __init__() {
    level flag::init("start_skiptos");
    level flag::init("running_skipto");
    level flag::init("level_has_skiptos");
    level flag::init("level_has_skipto_branches");
    level flag::init("skip_safehouse_after_map");
    level flag::init("final_level");
    level flag::init("_exit");
    clientfield::register("toplayer", "catch_up_transition", 1, 1, "counter");
    clientfield::register("world", "set_last_map_dvar", 1, 1, "counter");
    function_fcea19f2("_default");
    function_fcea19f2("_exit", &function_eb66277b);
    function_fcea19f2("no_game", &function_7caf435a);
    function_7c1e8577("gamedata/tables/cp/cp_mapmissions.csv", level.script);
    level.filter_spawnpoints = &filter_spawnpoints;
    callback::on_finalize_initialization(&on_finalize_initialization);
    callback::on_spawned(&on_player_spawn);
    callback::on_connect(&on_player_connect);
    /#
        level thread function_7b06f432();
        callback::on_spawned(&function_c40086b6);
    #/
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x1296e8ca, Offset: 0x1478
// Size: 0x4c
function __main__() {
    level thread function_143fd222();
    level thread handle();
    level thread function_52904bc9();
}

// Namespace skipto
// Params 7, eflags: 0x1 linked
// Checksum 0x91513088, Offset: 0x14d0
// Size: 0x34c
function add(skipto, func, str_name, cleanup_func, var_46c5ea43, var_c3efda96, var_2bc8bbd9) {
    if (!isdefined(var_2bc8bbd9)) {
        var_2bc8bbd9 = 0;
    }
    if (!isdefined(level.var_574eb415)) {
        level.var_574eb415 = skipto;
    }
    if (is_dev(skipto)) {
        errormsg("cp_mi_sing_blackstation");
        return;
    }
    if (isdefined(var_46c5ea43) || isdefined(var_c3efda96)) {
        errormsg("cp_mi_sing_blackstation");
        return;
    }
    if (level flag::get("level_has_skipto_branches")) {
        errormsg("cp_mi_sing_blackstation");
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
                    level.var_e07f6589[level.var_8b767436].var_c3efda96[level.var_e07f6589[level.var_8b767436].var_c3efda96.size] = skipto;
                }
            }
        }
        if (isdefined(level.var_8b767436)) {
            var_46c5ea43 = level.var_8b767436;
        }
        level.var_8b767436 = skipto;
    }
    if (!isdefined(func)) {
        assert(isdefined(func), "cp_mi_sing_blackstation");
    }
    struct = function_fcea19f2(skipto, func, str_name, cleanup_func, var_46c5ea43, var_c3efda96, var_2bc8bbd9);
    struct.public = 1;
    level flag::set("level_has_skiptos");
}

// Namespace skipto
// Params 6, eflags: 0x0
// Checksum 0xf4ae8e96, Offset: 0x1828
// Size: 0x70
function function_d68e678e(skipto, func, str_name, cleanup_func, var_46c5ea43, var_c3efda96) {
    struct = add(skipto, func, str_name, cleanup_func, var_46c5ea43, undefined, 1);
}

// Namespace skipto
// Params 6, eflags: 0x1 linked
// Checksum 0xf40f861c, Offset: 0x18a0
// Size: 0x318
function function_731571ad(skipto, func, str_name, cleanup_func, var_46c5ea43, var_c3efda96) {
    if (!isdefined(level.var_574eb415)) {
        level.var_574eb415 = skipto;
    }
    if (is_dev(skipto)) {
        errormsg("cp_mi_sing_blackstation");
        return;
    }
    if (!isdefined(var_46c5ea43) && !isdefined(var_c3efda96)) {
        errormsg("cp_mi_sing_blackstation");
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
                    level.var_e07f6589[level.var_8b767436].var_c3efda96[level.var_e07f6589[level.var_8b767436].var_c3efda96.size] = skipto;
                }
            }
        }
        if (isdefined(level.var_8b767436)) {
            var_46c5ea43 = level.var_8b767436;
        }
        level.var_8b767436 = skipto;
    }
    if (!isdefined(func)) {
        assert(isdefined(func), "cp_mi_sing_blackstation");
    }
    struct = function_fcea19f2(skipto, func, str_name, cleanup_func, var_46c5ea43, var_c3efda96);
    struct.public = 1;
    level flag::set("level_has_skiptos");
    level flag::set("level_has_skipto_branches");
    return struct;
}

// Namespace skipto
// Params 6, eflags: 0x0
// Checksum 0x8ed1f06d, Offset: 0x1bc0
// Size: 0x84
function function_75d02344(skipto, func, str_name, cleanup_func, var_46c5ea43, var_c3efda96) {
    struct = function_731571ad(skipto, func, str_name, cleanup_func, var_46c5ea43, var_c3efda96);
    if (isdefined(struct)) {
        struct.looping = 1;
    }
}

// Namespace skipto
// Params 6, eflags: 0x0
// Checksum 0x5a135921, Offset: 0x1c50
// Size: 0xd4
function add_dev(skipto, func, str_name, cleanup_func, var_46c5ea43, var_c3efda96) {
    if (!isdefined(level.var_574eb415)) {
        level.var_574eb415 = skipto;
    }
    if (is_dev(skipto)) {
        struct = function_fcea19f2(skipto, func, str_name, cleanup_func, var_46c5ea43, var_c3efda96);
        struct.var_3c612393 = 1;
        return;
    }
    errormsg("cp_mi_sing_blackstation");
}

// Namespace skipto
// Params 1, eflags: 0x0
// Checksum 0x70d4a16a, Offset: 0x1d30
// Size: 0xfa
function function_8ada4a91(skipto) {
    if (!isdefined(level.var_e07f6589[skipto])) {
        assertmsg("cp_mi_sing_blackstation" + skipto + "cp_mi_sing_blackstation");
        return;
    }
    level.var_e07f6589[skipto].var_f001de64 = 0;
    foreach (player in level.players) {
        bb::function_bea1c67c(skipto, player, "leave_objective_incomplete");
    }
}

// Namespace skipto
// Params 5, eflags: 0x0
// Checksum 0xaa2ba3b0, Offset: 0x1e38
// Size: 0x72
function function_955393e(skipto, event_name, event_type, event_size, var_e201e11) {
    if (!isdefined(level.var_81fdc5c1)) {
        level.var_81fdc5c1 = [];
    }
    level.var_81fdc5c1[skipto] = array(event_name, event_type, event_size, var_e201e11);
}

// Namespace skipto
// Params 7, eflags: 0x1 linked
// Checksum 0x9cbeee9d, Offset: 0x1eb8
// Size: 0x108
function function_fcea19f2(msg, func, str_name, cleanup_func, var_46c5ea43, var_c3efda96, var_2bc8bbd9) {
    assert(!isdefined(level._loadstarted), "cp_mi_sing_blackstation");
    msg = tolower(msg);
    struct = function_b545fa58(msg, func, str_name, cleanup_func, var_46c5ea43, var_c3efda96, var_2bc8bbd9);
    level.var_e07f6589[msg] = struct;
    level flag::init(msg);
    level flag::init(msg + "_completed");
    return struct;
}

// Namespace skipto
// Params 6, eflags: 0x0
// Checksum 0x3ca0f9ee, Offset: 0x1fc8
// Size: 0x124
function change(msg, func, str_name, cleanup_func, var_46c5ea43, var_c3efda96) {
    struct = level.var_e07f6589[msg];
    if (isdefined(func)) {
        struct.var_1ca15390 = func;
    }
    if (isdefined(str_name)) {
        struct.str_name = str_name;
    }
    if (isdefined(cleanup_func)) {
        struct.cleanup_func = cleanup_func;
    }
    if (isdefined(var_46c5ea43)) {
        struct.var_f8c3deec = struct function_d4f0317b(var_46c5ea43);
    }
    if (isdefined(var_c3efda96)) {
        struct.var_c3efda96 = strtok(var_c3efda96, ",");
        struct.next = struct.var_c3efda96;
    }
}

// Namespace skipto
// Params 1, eflags: 0x0
// Checksum 0xd3fab905, Offset: 0x20f8
// Size: 0x18
function function_f578c05a(func) {
    level.var_ba8dfc5d = func;
}

// Namespace skipto
// Params 7, eflags: 0x1 linked
// Checksum 0x2fa11fab, Offset: 0x2118
// Size: 0x1e0
function function_b545fa58(msg, func, str_name, cleanup_func, var_46c5ea43, var_c3efda96, var_2bc8bbd9) {
    if (!isdefined(var_2bc8bbd9)) {
        var_2bc8bbd9 = 0;
    }
    struct = spawnstruct();
    struct.name = msg;
    struct.var_84e9618b = registerskipto(msg);
    struct.var_1ca15390 = func;
    struct.str_name = str_name;
    struct.cleanup_func = cleanup_func;
    struct.next = [];
    struct.prev = [];
    struct.var_f8c3deec = "";
    struct.var_46c5ea43 = [];
    struct.var_2bc8bbd9 = var_2bc8bbd9;
    if (isdefined(var_46c5ea43)) {
        struct.var_f8c3deec = struct function_d4f0317b(var_46c5ea43);
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
// Params 0, eflags: 0x0
// Checksum 0x553f2964, Offset: 0x2300
// Size: 0x22
function function_f170bfd5() {
    return level flag::get("level_has_skiptos");
}

/#

    // Namespace skipto
    // Params 1, eflags: 0x1 linked
    // Checksum 0x66db5c6c, Offset: 0x2330
    // Size: 0x2c
    function function_c3caf25(msg) {
        assertmsg(msg);
    }

#/

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0x46097ecf, Offset: 0x2368
// Size: 0x2f4
function function_b6a4291e(instring) {
    op = "";
    ret = [];
    outindex = 0;
    ret[outindex] = "";
    var_dccf2883 = 0;
    for (i = 0; i < instring.size; i++) {
        c = getsubstr(instring, i, i + 1);
        if (c == "(") {
            var_dccf2883++;
            ret[outindex] = ret[outindex] + c;
            continue;
        }
        if (c == ")") {
            var_dccf2883--;
            ret[outindex] = ret[outindex] + c;
            continue;
        }
        if (var_dccf2883 == 0 && c == "&") {
            if (op == "|") {
                /#
                    function_c3caf25("cp_mi_sing_blackstation" + instring);
                #/
            }
            op = "&";
            outindex++;
            ret[outindex] = "";
            continue;
        }
        if (var_dccf2883 == 0 && c == "|") {
            if (op == "&") {
                /#
                    function_c3caf25("cp_mi_sing_blackstation" + instring);
                #/
            }
            op = "|";
            outindex++;
            ret[outindex] = "";
            continue;
        }
        ret[outindex] = ret[outindex] + c;
    }
    if (var_dccf2883 != 0) {
        /#
            function_c3caf25("cp_mi_sing_blackstation" + instring);
        #/
    }
    for (j = 0; j <= outindex; j++) {
        ret[j] = function_e3af1c7b(ret[j]);
    }
    if (outindex == 0) {
        return ret[outindex];
    }
    ret["op"] = op;
    return ret;
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0x8a5da9d9, Offset: 0x2668
// Size: 0x16e
function function_e3af1c7b(instring) {
    c = getsubstr(instring, 0, 1);
    if (c == "(") {
        c2 = getsubstr(instring, instring.size - 1, instring.size);
        if (c2 != ")") {
            /#
                function_c3caf25("cp_mi_sing_blackstation" + instring);
            #/
        }
        s = getsubstr(instring, 1, instring.size - 1);
        return function_b6a4291e(s);
    }
    if (!isdefined(self.var_46c5ea43)) {
        self.var_46c5ea43 = [];
    } else if (!isarray(self.var_46c5ea43)) {
        self.var_46c5ea43 = array(self.var_46c5ea43);
    }
    self.var_46c5ea43[self.var_46c5ea43.size] = instring;
    return instring;
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0x9c926c7, Offset: 0x27e0
// Size: 0x52
function function_d4f0317b(var_46c5ea43) {
    retval = function_b6a4291e(var_46c5ea43);
    if (isarray(retval)) {
        return retval;
    }
    return "";
}

// Namespace skipto
// Params 2, eflags: 0x1 linked
// Checksum 0xb6056e57, Offset: 0x2840
// Size: 0x172
function function_e5ea5a62(conditions, adding) {
    if (!isarray(conditions)) {
        if (isdefined(level.var_e07f6589[conditions].var_e27d380a) && level.var_e07f6589[conditions].var_e27d380a || isdefined(level.var_e07f6589[conditions]) && isinarray(adding, conditions)) {
            return 0;
        }
        return 1;
    }
    if (conditions["op"] == "|") {
        for (i = 0; i < conditions.size - 1; i++) {
            if (function_e5ea5a62(conditions[i], adding)) {
                return 1;
            }
        }
        return 0;
    }
    for (i = 0; i < conditions.size - 1; i++) {
        if (!function_e5ea5a62(conditions[i], adding)) {
            return 0;
        }
    }
    return 1;
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0x9ae446ba, Offset: 0x29c0
// Size: 0x11c
function function_b72da2d(objectives) {
    result = [];
    foreach (name in objectives) {
        if (function_e5ea5a62(level.var_e07f6589[name].var_f8c3deec, result)) {
            if (!isdefined(result)) {
                result = [];
            } else if (!isarray(result)) {
                result = array(result);
            }
            result[result.size] = name;
        }
    }
    return result;
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x75a36697, Offset: 0x2ae8
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
// Checksum 0xeb6401ea, Offset: 0x3210
// Size: 0x52
function function_72453179(skipto_name) {
    if (isdefined(level.var_e07f6589[skipto_name])) {
        return level.var_e07f6589[skipto_name].next;
    }
    return level.var_e07f6589["_default"].next;
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0xf7edfe17, Offset: 0x3270
// Size: 0xd8
function function_943de2e(skiptos) {
    skiptostr = "";
    first = 1;
    foreach (skipto in skiptos) {
        if (!first) {
            skiptostr += ",";
        }
        first = 0;
        skiptostr += skipto;
    }
    return skiptostr;
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0xf3abb158, Offset: 0x3350
// Size: 0x124
function function_8b19ec5d(var_533a04a6) {
    var_c61bfb3e = getdvarstring("skipto_jump");
    if (isdefined(var_c61bfb3e) && var_c61bfb3e.size) {
        if (var_c61bfb3e == "_default") {
            var_c61bfb3e = "";
        }
        skiptos = [];
        skiptos[0] = var_c61bfb3e;
        return skiptos;
    }
    if (isdefined(var_533a04a6) && var_533a04a6) {
        skiptos = tolower(getdvarstring("sv_saveGameSkipto"));
    } else {
        skiptos = tolower(getskiptos());
    }
    result = strtok(skiptos, ",");
    return result;
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x89792aab, Offset: 0x3480
// Size: 0x4e
function function_52c50cb8() {
    if (!isdefined(level.var_31aefea8) || !isdefined(level.var_e07f6589[level.var_31aefea8])) {
        return -1;
    }
    return level.var_e07f6589[level.var_31aefea8].var_84e9618b;
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0x4b2d3652, Offset: 0x34d8
// Size: 0x9c
function function_677539fe(skipto) {
    if (skipto != "" && level.var_e07f6589[skipto].var_2bc8bbd9 === 1) {
        setskiptos(tolower(skipto), 1);
        return;
    }
    setskiptos(tolower(skipto), 0);
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0xb09513e, Offset: 0x3580
// Size: 0x34
function function_556029e1(skiptos) {
    function_677539fe(function_943de2e(skiptos));
}

// Namespace skipto
// Params 0, eflags: 0x0
// Checksum 0xb7f0b3fe, Offset: 0x35c0
// Size: 0x3c
function function_1b5a2a11() {
    if (!isdefined(level.var_574eb415)) {
        level.var_574eb415 = "";
    }
    function_677539fe(level.var_574eb415);
}

/#

    // Namespace skipto
    // Params 2, eflags: 0x1 linked
    // Checksum 0x9a685c4f, Offset: 0x3608
    // Size: 0x1f4
    function function_d71418c8(skipto, index) {
        if (isdefined(getdvarstring("cp_mi_sing_blackstation")) && getdvarint("cp_mi_sing_blackstation")) {
            return;
        }
        hudelem = newhudelem();
        hudelem.alignx = "cp_mi_sing_blackstation";
        hudelem.aligny = "cp_mi_sing_blackstation";
        hudelem.x = 125;
        hudelem.y = 20 * (index + 2);
        hudelem.fontscale = 1.5;
        hudelem.sort = 20;
        hudelem.alpha = 0;
        hudelem.color = (0.8, 0.8, 0.8);
        hudelem.font = "cp_mi_sing_blackstation";
        hudelem settext(skipto);
        wait(0.25 * (index + 1));
        hudelem fadeovertime(0.25);
        hudelem.alpha = 1;
        wait(0.25);
        wait(3);
        hudelem fadeovertime(0.75);
        hudelem.alpha = 0;
        wait(0.75);
        hudelem destroy();
    }

#/

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0x27646b6c, Offset: 0x3808
// Size: 0xf6
function function_bd4daf7b(skiptos) {
    done = 0;
    while (isdefined(skiptos) && skiptos.size && !done) {
        done = 1;
        foreach (skipto in skiptos) {
            if (!isdefined(level.var_e07f6589[skipto])) {
                arrayremovevalue(skiptos, skipto, 0);
                done = 0;
                break;
            }
        }
    }
    return skiptos;
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x5351eeed, Offset: 0x3908
// Size: 0x33c
function handle() {
    function_5771edb2();
    function_1d4d83a6();
    level flag::wait_till("start_skiptos");
    var_7405b464 = function_72453179("_default");
    skiptos = function_8b19ec5d(1);
    var_c61bfb3e = getdvarstring("skipto_jump");
    if (isdefined(var_c61bfb3e) && var_c61bfb3e.size) {
        setdvar("skipto_jump", "");
    }
    skiptos = function_bd4daf7b(skiptos);
    assert(isdefined(level.first_frame) && level.first_frame, "cp_mi_sing_blackstation");
    if (isdefined(level.var_31aefea8)) {
        skiptos = [];
        skiptos[0] = level.var_31aefea8;
    }
    level.var_fee90489 = skiptos;
    skipto = skiptos[0];
    if (isdefined(skipto) && isdefined(level.var_e07f6589[skipto])) {
        level.var_31aefea8 = skipto;
    }
    is_default = 0;
    start = level.var_fee90489;
    if (start.size < 1) {
        is_default = 1;
        start = var_7405b464;
        if (isdefined(level.var_574eb415)) {
            level.var_31aefea8 = level.var_574eb415;
        }
        savegame_create();
    }
    level.var_b0a9f843 = start;
    skipto = start[0];
    if (isdefined(skipto) && isdefined(level.var_e07f6589[skipto])) {
        level.var_31aefea8 = skipto;
    }
    if (start.size < 1) {
        return;
    }
    if (!is_default) {
        function_be04f9a5(var_7405b464);
    }
    level flagsys::set("scene_on_load_wait");
    function_c4c27da4(start, 1);
    if (is_default) {
        thread savegame::save();
    } else {
        thread savegame::load();
    }
    thread devgui();
    /#
        waittillframeend();
        thread menu();
        level thread function_f70934af();
    #/
}

// Namespace skipto
// Params 2, eflags: 0x1 linked
// Checksum 0xcb8396ec, Offset: 0x3c50
// Size: 0x1cc
function create(skipto, index) {
    alpha = 1;
    color = (0.9, 0.9, 0.9);
    if (index != -1) {
        if (index != 4) {
            alpha = 1 - abs(4 - index) / 4;
        } else {
            color = (1, 1, 0);
        }
    }
    if (alpha == 0) {
        alpha = 0.05;
    }
    hudelem = newhudelem();
    hudelem.alignx = "left";
    hudelem.aligny = "middle";
    hudelem.x = 80;
    hudelem.y = 80 + index * 18;
    hudelem settext(skipto);
    hudelem.alpha = 0;
    hudelem.foreground = 1;
    hudelem.color = color;
    hudelem.fontscale = 1.75;
    hudelem fadeovertime(0.5);
    hudelem.alpha = alpha;
    return hudelem;
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0xa5831ccc, Offset: 0x3e28
// Size: 0x2c
function function_1d4d83a6() {
    rootclear = "devgui_remove \"Map/Skipto\" \n";
    adddebugcommand(rootclear);
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x4556b1f4, Offset: 0x3e60
// Size: 0x2b8
function devgui() {
    var_fcdf780c = "devgui_cmd \"Map/Skipto/";
    var_67a5c424 = var_fcdf780c + "Jump to/";
    index = 1;
    adddebugcommand(var_67a5c424 + "Default:0\" \"set " + "skipto_jump" + " " + "_default" + "\" \n");
    foreach (struct in level.var_e07f6589) {
        name = struct.name + ":" + index;
        index++;
        adddebugcommand(var_67a5c424 + name + "\" \"set " + "skipto_jump" + " " + struct.name + "\" \n");
    }
    adddebugcommand(var_67a5c424 + "No Game:" + index + "\" \"set " + "skipto_jump" + " " + "no_game" + "\" \n");
    for (;;) {
        var_d7c02302 = getdvarstring("skipto_jump");
        if (isdefined(var_d7c02302) && var_d7c02302.size) {
            music::setmusicstate("death");
            map_restart();
            return;
        }
        complete = getdvarstring("skipto_complete");
        if (isdefined(complete) && complete.size) {
            setdvar("skipto_complete", "");
            level function_be8adfb8(complete, getplayers()[0]);
        }
        wait(0.05);
    }
}

/#

    // Namespace skipto
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa6dd03b9, Offset: 0x4120
    // Size: 0x160
    function menu() {
        level flag::wait_till("cp_mi_sing_blackstation");
        player = getplayers()[0];
        while (isdefined(player) && player buttonpressed("cp_mi_sing_blackstation")) {
            wait(0.05);
        }
        level thread function_32d804dd();
        for (;;) {
            if (isdefined(getdvarint("cp_mi_sing_blackstation")) && getdvarint("cp_mi_sing_blackstation")) {
                setdvar("cp_mi_sing_blackstation", 0);
                getplayers()[0] allowjump(0);
                display();
                getplayers()[0] allowjump(1);
            }
            wait(0.05);
        }
    }

#/

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0xdf90c5c, Offset: 0x4288
// Size: 0xbe
function function_5a20eade() {
    player = getplayers()[0];
    if (isdefined(player) && player buttonpressed("BUTTON_X") && player buttonpressed("DPAD_RIGHT") && player buttonpressed("BUTTON_LSHLDR") && player buttonpressed("BUTTON_RSHLDR")) {
        return true;
    }
    return false;
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x7f65fe6b, Offset: 0x4350
// Size: 0x68
function function_32d804dd() {
    for (;;) {
        while (!function_5a20eade()) {
            wait(0.05);
        }
        setdvar("debug_skipto", 1);
        while (function_5a20eade()) {
            wait(0.05);
        }
    }
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0x426a6b09, Offset: 0x43c0
// Size: 0x152
function function_73c9bef8(objectives) {
    rootclear = "devgui_remove \"Map/Skipto/Complete\" \n";
    adddebugcommand(rootclear);
    var_fcdf780c = "devgui_cmd \"Map/Skipto/";
    var_86373479 = var_fcdf780c + "Complete/";
    index = 1;
    foreach (objective in objectives) {
        name = objective + ":" + index;
        index++;
        adddebugcommand(var_86373479 + name + "\" \"set " + "skipto_complete" + " " + objective + "\" \n");
    }
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x993781fd, Offset: 0x4520
// Size: 0xc8
function function_d4de4cea() {
    index = 0;
    names = [];
    foreach (struct in level.var_e07f6589) {
        name = struct.name;
        names[index] = name;
        index++;
    }
    return names;
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0xaf9cb378, Offset: 0x45f0
// Size: 0x634
function display() {
    if (level.var_e07f6589.size <= 0) {
        return;
    }
    names = function_d4de4cea();
    elems = list_menu();
    title = create("Selected skipto:", -1);
    title.color = (1, 1, 1);
    strings = [];
    for (i = 0; i < names.size; i++) {
        var_903b73e = names[i];
        var_9f17f9b5 = "[" + names[i] + "]";
        strings[strings.size] = var_9f17f9b5;
    }
    selected = names.size - 1;
    up_pressed = 0;
    down_pressed = 0;
    var_229d7f5a = 0;
    while (selected > 0) {
        if (names[selected] == level.var_31aefea8) {
            var_229d7f5a = 1;
            break;
        }
        selected--;
    }
    if (!var_229d7f5a) {
        selected = names.size - 1;
    }
    function_59b1348d(elems, strings, selected);
    old_selected = selected;
    for (;;) {
        if (old_selected != selected) {
            function_59b1348d(elems, strings, selected);
            old_selected = selected;
        }
        if (!up_pressed) {
            if (getplayers()[0] buttonpressed("UPARROW") || getplayers()[0] buttonpressed("DPAD_UP") || getplayers()[0] buttonpressed("APAD_UP")) {
                up_pressed = 1;
                selected--;
            }
        } else if (!getplayers()[0] buttonpressed("UPARROW") && !getplayers()[0] buttonpressed("DPAD_UP") && !getplayers()[0] buttonpressed("APAD_UP")) {
            up_pressed = 0;
        }
        if (!down_pressed) {
            if (getplayers()[0] buttonpressed("DOWNARROW") || getplayers()[0] buttonpressed("DPAD_DOWN") || getplayers()[0] buttonpressed("APAD_DOWN")) {
                down_pressed = 1;
                selected++;
            }
        } else if (!getplayers()[0] buttonpressed("DOWNARROW") && !getplayers()[0] buttonpressed("DPAD_DOWN") && !getplayers()[0] buttonpressed("APAD_DOWN")) {
            down_pressed = 0;
        }
        if (selected < 0) {
            selected = names.size - 1;
        }
        if (selected >= names.size) {
            selected = 0;
        }
        if (getplayers()[0] buttonpressed("BUTTON_B")) {
            function_30a9834c(elems, title);
            break;
        }
        if (getplayers()[0] buttonpressed("kp_enter") || getplayers()[0] buttonpressed("BUTTON_A") || getplayers()[0] buttonpressed("enter")) {
            if (names[selected] == "cancel") {
                function_30a9834c(elems, title);
                break;
            }
            function_677539fe(names[selected]);
            map_restart();
            return;
        }
        wait(0.05);
    }
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x2d199890, Offset: 0x4c30
// Size: 0x78
function list_menu() {
    hud_array = [];
    for (i = 0; i < 8; i++) {
        hud = create("", i);
        hud_array[hud_array.size] = hud;
    }
    return hud_array;
}

// Namespace skipto
// Params 3, eflags: 0x1 linked
// Checksum 0x5a753745, Offset: 0x4cb0
// Size: 0xbe
function function_59b1348d(hud_array, strings, num) {
    for (i = 0; i < hud_array.size; i++) {
        index = i + num - 4;
        if (isdefined(strings[index])) {
            text = strings[index];
        } else {
            text = "";
        }
        hud_array[i] settext(text);
    }
}

// Namespace skipto
// Params 2, eflags: 0x1 linked
// Checksum 0x7e2eaceb, Offset: 0x4d78
// Size: 0x76
function function_30a9834c(elems, title) {
    title destroy();
    for (i = 0; i < elems.size; i++) {
        elems[i] destroy();
    }
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0xc77b9c1c, Offset: 0x4df8
// Size: 0x96
function function_7caf435a() {
    guys = getaiarray();
    guys = arraycombine(guys, getspawnerarray(), 1, 0);
    for (i = 0; i < guys.size; i++) {
        guys[i] delete();
    }
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x7e14ffb2, Offset: 0x4e98
// Size: 0x13c
function function_f70934af() {
    if (!function_492f0713()) {
        return;
    }
    hudelem = newhudelem();
    hudelem.alignx = "left";
    hudelem.aligny = "top";
    hudelem.x = 0;
    hudelem.y = 70;
    hudelem settext("This skipto is for development purposes only!  The level may not progress from this point.");
    hudelem.alpha = 1;
    hudelem.fontscale = 1.8;
    hudelem.color = (1, 0.55, 0);
    wait(7);
    hudelem fadeovertime(1);
    hudelem.alpha = 0;
    wait(1);
    hudelem destroy();
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0x3cf53c0d, Offset: 0x4fe0
// Size: 0x60
function is_dev(skipto) {
    substr = tolower(getsubstr(skipto, 0, 4));
    if (substr == "dev_") {
        return true;
    }
    return false;
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x5e4f9d2c, Offset: 0x5048
// Size: 0x1a
function function_492f0713() {
    return is_dev(level.var_31aefea8);
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0xfc91aad1, Offset: 0x5070
// Size: 0x32
function function_6be1cbfa() {
    if (!isdefined(level.var_31aefea8)) {
        return 0;
    }
    return issubstr(level.var_31aefea8, "no_game");
}

// Namespace skipto
// Params 0, eflags: 0x0
// Checksum 0x90f8584e, Offset: 0x50b0
// Size: 0xa0
function function_6f516a11() {
    if (!function_6be1cbfa()) {
        return;
    }
    level.stop_load = 1;
    if (isdefined(level.custom_no_game_setupfunc)) {
        level [[ level.custom_no_game_setupfunc ]]();
    }
    level thread load::all_players_spawned();
    array::thread_all(getentarray("water", "targetname"), &load::water_think);
    level waittill(#"eternity");
}

// Namespace skipto
// Params 1, eflags: 0x0
// Checksum 0xf1480212, Offset: 0x5158
// Size: 0x18
function function_2ece423b(func) {
    level.var_ba8dfc5d = func;
}

// Namespace skipto
// Params 1, eflags: 0x0
// Checksum 0xe0ec05b8, Offset: 0x5178
// Size: 0x18
function function_574eb415(skipto) {
    level.var_574eb415 = skipto;
}

// Namespace skipto
// Params 3, eflags: 0x0
// Checksum 0x8056e64e, Offset: 0x5198
// Size: 0x4c
function teleport(skipto_name, var_b8e76549, var_46031771) {
    teleport_ai(skipto_name, var_b8e76549);
    teleport_players(skipto_name, var_46031771);
}

// Namespace skipto
// Params 2, eflags: 0x1 linked
// Checksum 0x7c0d512d, Offset: 0x51f0
// Size: 0x2da
function teleport_ai(skipto_name, var_b8e76549) {
    if (!isdefined(var_b8e76549)) {
        if (isdefined(level.heroes)) {
            var_b8e76549 = level.heroes;
        } else {
            var_b8e76549 = getaiteamarray("allies");
        }
    }
    if (isstring(var_b8e76549)) {
        var_b8e76549 = getaiarray(var_b8e76549, "script_noteworthy");
    }
    if (!isarray(var_b8e76549)) {
        var_b8e76549 = array(var_b8e76549);
    }
    var_b8e76549 = array::remove_dead(var_b8e76549);
    var_40021c00 = arraycopy(struct::get_array(skipto_name + "_ai", "targetname"));
    assert(var_40021c00.size >= var_b8e76549.size, "cp_mi_sing_blackstation" + skipto_name + "cp_mi_sing_blackstation" + var_b8e76549.size + "cp_mi_sing_blackstation" + var_40021c00.size + "cp_mi_sing_blackstation");
    if (!var_40021c00.size) {
        return;
    }
    foreach (ai in var_b8e76549) {
        if (isdefined(ai)) {
            var_77d4425f = 0;
            if (isdefined(ai.script_int)) {
                for (j = 0; j < var_40021c00.size; j++) {
                    if (isdefined(var_40021c00[j].script_int)) {
                        if (var_40021c00[j].script_int == ai.script_int) {
                            var_77d4425f = j;
                            break;
                        }
                    }
                }
            }
            ai function_d9b1ee00(var_40021c00[var_77d4425f]);
            arrayremovevalue(var_40021c00, var_40021c00[var_77d4425f]);
        }
    }
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0xef432080, Offset: 0x54d8
// Size: 0x104
function function_d9b1ee00(var_6945be17) {
    if (isdefined(var_6945be17.angles)) {
        self forceteleport(var_6945be17.origin, var_6945be17.angles);
    } else {
        self forceteleport(var_6945be17.origin);
    }
    if (isdefined(var_6945be17.target)) {
        node = getnode(var_6945be17.target, "targetname");
        if (isdefined(node)) {
            self setgoal(node);
            return;
        }
    }
    self setgoal(var_6945be17.origin);
}

// Namespace skipto
// Params 2, eflags: 0x1 linked
// Checksum 0x688c44ed, Offset: 0x55e8
// Size: 0x186
function teleport_players(skipto_name, var_46031771) {
    level flag::wait_till("all_players_spawned");
    var_9dba424d = function_3529c409(skipto_name, var_46031771);
    assert(var_9dba424d.size >= level.players.size, "cp_mi_sing_blackstation");
    for (i = 0; i < level.players.size; i++) {
        var_ac126ac5 = var_9dba424d[i].origin;
        var_ac126ac5 = level.players[i] player::get_snapped_spot_origin(var_ac126ac5);
        level.players[i] setorigin(var_ac126ac5);
        if (isdefined(var_9dba424d[i].angles)) {
            level.players[i] util::delay_network_frames(2, "disconnect", &setplayerangles, var_9dba424d[i].angles);
        }
    }
}

// Namespace skipto
// Params 2, eflags: 0x1 linked
// Checksum 0x1f19ce7d, Offset: 0x5778
// Size: 0x206
function function_3529c409(skipto_name, var_46031771) {
    if (!isdefined(var_46031771)) {
        var_46031771 = 0;
    }
    var_9dba424d = struct::get_array(skipto_name, "targetname");
    if (!var_9dba424d.size) {
        var_9dba424d = spawnlogic::get_spawnpoint_array("cp_coop_spawn", 1);
        var_9dba424d = function_c13ce5f8(undefined, var_9dba424d, skipto_name);
    }
    if (var_46031771) {
        for (i = 0; i < var_9dba424d.size; i++) {
            for (j = i; j < var_9dba424d.size; j++) {
                assert(isdefined(var_9dba424d[j].script_int), "cp_mi_sing_blackstation" + var_9dba424d[j].origin + "cp_mi_sing_blackstation");
                assert(isdefined(var_9dba424d[i].script_int), "cp_mi_sing_blackstation" + var_9dba424d[i].origin + "cp_mi_sing_blackstation");
                if (var_9dba424d[j].script_int < var_9dba424d[i].script_int) {
                    temp = var_9dba424d[i];
                    var_9dba424d[i] = var_9dba424d[j];
                    var_9dba424d[j] = temp;
                }
            }
        }
    }
    return var_9dba424d;
}

// Namespace skipto
// Params 3, eflags: 0x1 linked
// Checksum 0x4927b4c7, Offset: 0x5988
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
// Checksum 0xba87a2f0, Offset: 0x5a98
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
// Checksum 0x99ec1590, Offset: 0x5c18
// Size: 0x4
function function_89a9b10f() {
    
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x25941dca, Offset: 0x5c28
// Size: 0x24
function on_finalize_initialization() {
    level flag::set("start_skiptos");
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0xadde746e, Offset: 0x5c58
// Size: 0x54
function on_player_spawn() {
    if (getdvarint("ui_blocksaves") == 0 && isdefined(self savegame::function_36adbb9c("savegame_score"))) {
        return;
    }
    globallogic_player::function_a5ac6877();
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0xf87eb6e1, Offset: 0x5cb8
// Size: 0x36
function function_f2b024f8() {
    self endon(#"disconnect");
    while (true) {
        self function_a5a105e8();
        wait(5);
    }
}

// Namespace skipto
// Params 4, eflags: 0x1 linked
// Checksum 0xa63a30c3, Offset: 0x5cf8
// Size: 0xa4
function function_bc7b05ac(var_87fe1234, var_a3b4af10, var_eece3936, var_5db7ef95) {
    var_a88ef0ad = 0;
    var_17986f3e = 0;
    if (isdefined(var_5db7ef95)) {
        var_17986f3e = var_5db7ef95;
    }
    if (isdefined(var_eece3936)) {
        var_a88ef0ad = var_eece3936;
    }
    var_96f7be40 = var_17986f3e - var_a88ef0ad;
    self matchrecordsetcheckpointstat(var_a3b4af10, var_87fe1234, var_96f7be40);
}

// Namespace skipto
// Params 2, eflags: 0x1 linked
// Checksum 0xa0acae66, Offset: 0x5da8
// Size: 0x744
function function_84008d8d(objectivename, player) {
    objectiveindex = level.var_e07f6589[objectivename].var_84e9618b;
    player function_bc7b05ac("kills_total", objectiveindex, player.var_dc615b.kills, player.kills);
    totalshots = player getdstat("PlayerStatsList", "TOTAL_SHOTS", "statValue");
    totalhits = player getdstat("PlayerStatsList", "HITS", "statValue");
    if (isdefined(totalshots)) {
        player function_bc7b05ac("shots_total", objectiveindex, player.var_dc615b.shots, totalshots);
    }
    if (isdefined(totalhits)) {
        player function_bc7b05ac("hits_total", objectiveindex, player.var_dc615b.hits, totalhits);
    }
    player function_bc7b05ac("incaps_total", objectiveindex, player.var_dc615b.incaps, player.incaps);
    player function_bc7b05ac("deaths_total", objectiveindex, player.var_dc615b.deaths, player.deaths);
    player function_bc7b05ac("revives_total", objectiveindex, player.var_dc615b.revives, player.revives);
    player function_bc7b05ac("headshots_total", objectiveindex, player.var_dc615b.headshots, player.headshots);
    player function_bc7b05ac("duration_total", objectiveindex, player.var_dc615b.timestamp, gettime());
    player function_bc7b05ac("score_total", objectiveindex, player.var_dc615b.score, player.score);
    player function_bc7b05ac("grenades_total", objectiveindex, player.var_dc615b.grenadesused, player.grenadesused);
    player function_bc7b05ac("igcSeconds", objectiveindex, player.var_dc615b.var_7479d3c, player.totaligcviewtime);
    player function_bc7b05ac("secondsPaused", objectiveindex, player.var_dc615b.var_adac7b4d, int(gettotalserverpausetime() / 1000));
    var_b1f1efe7 = 0;
    var_394190fb = 0;
    var_d88606f6 = 0;
    var_32d177c9 = 0;
    var_4dbe4ef9 = 0;
    if (isdefined(player.movementtracking)) {
        if (isdefined(player.movementtracking.wallrunning)) {
            var_394190fb = player.movementtracking.wallrunning.distance;
            var_32d177c9 = player.movementtracking.wallrunning.count;
        }
        if (isdefined(player.movementtracking.sprinting)) {
            var_b1f1efe7 = player.movementtracking.sprinting.distance;
        }
        if (isdefined(player.movementtracking.doublejump)) {
            var_d88606f6 = player.movementtracking.doublejump.distance;
            var_4dbe4ef9 = player.movementtracking.doublejump.count;
        }
    }
    player function_bc7b05ac("distance_wallrun", objectiveindex, player.var_dc615b.distance_wallrun, int(var_394190fb));
    player function_bc7b05ac("distance_sprinted", objectiveindex, player.var_dc615b.distance_sprinted, int(var_b1f1efe7));
    player function_bc7b05ac("distance_boosted", objectiveindex, player.var_dc615b.distance_boosted, int(var_d88606f6));
    player function_bc7b05ac("wallruns_total", objectiveindex, player.var_dc615b.wallruns_total, int(var_32d177c9));
    player function_bc7b05ac("boosts_total", objectiveindex, player.var_dc615b.boosts_total, int(var_4dbe4ef9));
    player matchrecordsetcheckpointstat(objectiveindex, "start_difficulty", player.var_dc615b.difficulty);
    player matchrecordsetcheckpointstat(objectiveindex, "end_difficulty", level.gameskill);
    if (isdefined(level.sceneskippedcount)) {
        player matchrecordsetcheckpointstat(objectiveindex, "igcSkippedNum", level.sceneskippedcount);
    }
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0x2cf64545, Offset: 0x64f8
// Size: 0x4d8
function function_723221dd(player) {
    if (!isdefined(player.var_dc615b)) {
        player.var_dc615b = spawnstruct();
    }
    player.var_dc615b.kills = player.kills;
    shots = player getdstat("PlayerStatsList", "TOTAL_SHOTS", "statValue");
    player.var_dc615b.shots = isdefined(shots) ? shots : 0;
    hits = player getdstat("PlayerStatsList", "HITS", "statValue");
    player.var_dc615b.hits = isdefined(hits) ? hits : 0;
    player.var_dc615b.incaps = player.incaps;
    player.var_dc615b.deaths = player.deaths;
    player.var_dc615b.revives = player.revives;
    player.var_dc615b.headshots = player.headshots;
    player.var_dc615b.timestamp = gettime();
    player.var_dc615b.score = player.score;
    player.var_dc615b.grenadesused = player.grenadesused;
    player.var_dc615b.var_7479d3c = player.totaligcviewtime;
    player.var_dc615b.var_adac7b4d = int(gettotalserverpausetime() / 1000);
    player.var_dc615b.difficulty = level.gameskill;
    var_b1f1efe7 = 0;
    var_394190fb = 0;
    var_d88606f6 = 0;
    var_32d177c9 = 0;
    var_4dbe4ef9 = 0;
    if (isdefined(player.movementtracking)) {
        if (isdefined(player.movementtracking.wallrunning)) {
            var_394190fb = player.movementtracking.wallrunning.distance;
            var_32d177c9 = player.movementtracking.wallrunning.count;
        }
        if (isdefined(player.movementtracking.sprinting)) {
            var_b1f1efe7 = player.movementtracking.sprinting.distance;
        }
        if (isdefined(player.movementtracking.doublejump)) {
            var_d88606f6 = player.movementtracking.doublejump.distance;
            var_4dbe4ef9 = player.movementtracking.doublejump.count;
        }
    }
    player.var_dc615b.distance_wallrun = int(var_394190fb);
    player.var_dc615b.distance_sprinted = int(var_b1f1efe7);
    player.var_dc615b.distance_boosted = int(var_d88606f6);
    player.var_dc615b.wallruns_total = int(var_32d177c9);
    player.var_dc615b.boosts_total = int(var_4dbe4ef9);
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0xe77c4dbf, Offset: 0x69d8
// Size: 0x58c
function on_player_connect() {
    if (util::is_safehouse()) {
        return;
    }
    if (isdefined(level.var_f0ca204d) && level.var_f0ca204d) {
        return;
    }
    if (!isdefined(getrootmapname())) {
        return;
    }
    self thread function_f2b024f8();
    if (getdvarint("ui_blocksaves") == 0) {
        if (self ishost()) {
            var_85f70d3f = 1;
            if (sessionmodeisonlinegame()) {
                var_85f70d3f = isdefined(self getdstat("scoreboard_migrated")) && self getdstat("scoreboard_migrated");
            } else {
                var_85f70d3f = isdefined(self getdstat("reserveBools", 0)) && self getdstat("reserveBools", 0);
            }
            if (!var_85f70d3f) {
                self savegame::set_player_data("savegame_score", self function_df7ef426("SCORE"));
                self savegame::set_player_data("savegame_kills", self function_df7ef426("KILLS"));
                self savegame::set_player_data("savegame_assists", self function_df7ef426("ASSISTS"));
                self savegame::set_player_data("savegame_incaps", self function_df7ef426("INCAPS"));
                self savegame::set_player_data("savegame_revives", self function_df7ef426("REVIVES"));
                if (sessionmodeisonlinegame()) {
                    self setdstat("scoreboard_migrated", 1);
                } else {
                    self setdstat("reserveBools", 0, 1);
                }
                uploadstats(self);
            }
            if (!isdefined(self savegame::function_36adbb9c("savegame_score"))) {
                self savegame::set_player_data("savegame_score", 0);
            }
            if (!isdefined(self savegame::function_36adbb9c("savegame_kills"))) {
                self savegame::set_player_data("savegame_kills", 0);
            }
            if (!isdefined(self savegame::function_36adbb9c("savegame_assists"))) {
                self savegame::set_player_data("savegame_assists", 0);
            }
            if (!isdefined(self savegame::function_36adbb9c("savegame_incaps"))) {
                self savegame::set_player_data("savegame_incaps", 0);
            }
            if (!isdefined(self savegame::function_36adbb9c("savegame_revives"))) {
                self savegame::set_player_data("savegame_revives", 0);
            }
            self.pers["score"] = self savegame::function_36adbb9c("savegame_score", 0);
            self.pers["kills"] = self savegame::function_36adbb9c("savegame_kills", 0);
            self.pers["assists"] = self savegame::function_36adbb9c("savegame_assists", 0);
            self.pers["incaps"] = self savegame::function_36adbb9c("savegame_incaps", 0);
            self.pers["revives"] = self savegame::function_36adbb9c("savegame_revives", 0);
            self.score = self.pers["score"];
            self.kills = self.pers["kills"];
            self.assists = self.pers["assists"];
            self.incaps = self.pers["incaps"];
            self.revives = self.pers["revives"];
        }
    }
    function_723221dd(self);
}

// Namespace skipto
// Params 2, eflags: 0x1 linked
// Checksum 0x6c067933, Offset: 0x6f70
// Size: 0x29c
function function_be8adfb8(name, player) {
    assert(isdefined(level.var_e07f6589[name]), "cp_mi_sing_blackstation" + name + "cp_mi_sing_blackstation");
    setdvar("NPCDeathTracking_Save", 1);
    foreach (statplayer in level.players) {
        if (statplayer istestclient()) {
            continue;
        }
        bb::function_bea1c67c(name, statplayer, "complete");
        statplayer globallogic_player::function_ece4ca01();
    }
    if (isdefined(name)) {
        if (isdefined(player)) {
            function_84008d8d(name, player);
        } else {
            foreach (var_63af5576 in level.players) {
                function_84008d8d(name, var_63af5576);
            }
        }
        level function_2d700bc6(name, 0, 1, player);
    }
    next = function_72453179(name);
    next = function_b72da2d(next);
    if (isdefined(next) && next.size > 0) {
        level function_c4c27da4(next, 0, player);
        level thread savegame::save();
    }
}

// Namespace skipto
// Params 0, eflags: 0x5 linked
// Checksum 0xa525a40f, Offset: 0x7218
// Size: 0xa2
function private function_52904bc9() {
    foreach (trig in trigger::get_all()) {
        if (isdefined(trig.var_22c28736)) {
            trig thread function_87fe8621();
        }
    }
}

// Namespace skipto
// Params 0, eflags: 0x5 linked
// Checksum 0xfc459ad6, Offset: 0x72c8
// Size: 0x272
function private function_87fe8621() {
    self endon(#"death");
    level flag::wait_till("all_players_spawned");
    var_717810f = function_659bb22b(self.var_22c28736);
    assert(var_717810f.size >= 3, "cp_mi_sing_blackstation");
    while (true) {
        lead_player = self waittill(#"trigger");
        if (isplayer(lead_player)) {
            self notify(#"hash_c0b9931e");
            foreach (player in level.players) {
                if (player != lead_player) {
                    if (player.sessionstate === "playing") {
                        n_dist = isdefined(self.script_regroup_distance) ? self.script_regroup_distance * self.script_regroup_distance : 2250000;
                        var_cacbf7e2 = distancesquared(player.origin, lead_player.origin);
                        if (var_cacbf7e2 > n_dist) {
                            if (!player istouching(self)) {
                                player thread function_61843b91(var_717810f, var_cacbf7e2);
                            }
                        }
                        continue;
                    }
                    if (isdefined(player.initialloadoutgiven) && player.sessionstate === "spectator" && player.initialloadoutgiven) {
                        player thread function_61843b91(var_717810f);
                    }
                }
            }
            break;
        }
    }
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0x3e12e959, Offset: 0x7548
// Size: 0x124
function function_659bb22b(var_3a36166b) {
    a_ret = [];
    var_717810f = spawnlogic::function_93d52c4f(1);
    foreach (loc in var_717810f) {
        if (loc.var_22c28736 === var_3a36166b) {
            if (!isdefined(a_ret)) {
                a_ret = [];
            } else if (!isarray(a_ret)) {
                a_ret = array(a_ret);
            }
            a_ret[a_ret.size] = loc;
        }
    }
    return a_ret;
}

// Namespace skipto
// Params 2, eflags: 0x5 linked
// Checksum 0xaf9f131a, Offset: 0x7678
// Size: 0x3d2
function private function_61843b91(var_717810f, var_cacbf7e2) {
    self endon(#"death");
    if (self isinvehicle()) {
        vh_occupied = self getvehicleoccupied();
        n_seat = vh_occupied getoccupantseat(self);
        vh_occupied usevehicle(self, n_seat);
        if (isdefined(self.hijacked_vehicle_entity)) {
            self waittill(#"hash_58a3879b");
        }
    }
    if (isdefined(self.hijacked_vehicle_entity)) {
        self.hijacked_vehicle_entity delete();
    }
    if (self.sessionstate === "spectator") {
        self thread [[ level.spawnplayer ]]();
        waittillframeend();
    } else if (self laststand::player_is_in_laststand()) {
        self notify(#"auto_revive");
    }
    if (self isplayinganimscripted()) {
        self stopanimscripted();
    }
    if (isdefined(self getlinkedent())) {
        self unlink();
        wait(0.1);
    }
    foreach (loc in var_717810f) {
        if (!(isdefined(loc.b_used) && loc.b_used)) {
            loc.b_used = 1;
            self.b_teleport_invulnerability = 1;
            self freezecontrols(1);
            self playsoundtoplayer("evt_coop_regroup_out", self);
            if (isdefined(var_cacbf7e2) && var_cacbf7e2 < 250000) {
                clientfield::increment_to_player("postfx_igc", 3);
            } else {
                clientfield::increment_to_player("postfx_igc", 1);
            }
            wait(0.5);
            self setorigin(loc.origin);
            if (isdefined(loc.angles)) {
                util::delay_network_frames(2, "disconnect", &setplayerangles, loc.angles);
            }
            self playsoundtoplayer("evt_coop_regroup_in", self);
            break;
        }
    }
    wait(2);
    self freezecontrols(0);
    wait(0.05);
    if (isdefined(level.var_1895e0f9)) {
        self [[ level.var_1895e0f9 ]]();
    }
    self util::streamer_wait(undefined, 0, 5);
    wait(5);
    self.b_teleport_invulnerability = undefined;
}

/#

    // Namespace skipto
    // Params 1, eflags: 0x1 linked
    // Checksum 0x4c8f1864, Offset: 0x7a58
    // Size: 0x12c
    function function_de4f5ef8(objectives) {
        setdvar("cp_mi_sing_blackstation", 1);
        index = 0;
        foreach (name in objectives) {
            var_c52d91a9 = level.var_e07f6589[name];
            if (isdefined(var_c52d91a9.str_name) && var_c52d91a9.str_name.size) {
                thread function_d71418c8(var_c52d91a9.str_name, index);
                index++;
            }
        }
        setdvar("cp_mi_sing_blackstation", 0);
    }

#/

// Namespace skipto
// Params 3, eflags: 0x1 linked
// Checksum 0x9c3965c4, Offset: 0x7b90
// Size: 0x2fc
function function_c4c27da4(objectives, starting, player) {
    function_c951eb3d();
    foreach (name in objectives) {
        if (isdefined(level.var_e07f6589[name])) {
            function_2d700bc6(level.var_e07f6589[name].prev, starting, 0, player);
        }
    }
    if (isdefined(level.var_ba8dfc5d)) {
        foreach (name in objectives) {
            thread [[ level.var_ba8dfc5d ]](name);
        }
    }
    /#
        thread function_de4f5ef8(objectives);
    #/
    function_bfe10ae8(objectives, starting);
    level.var_31aefea8 = level.var_fee90489[0];
    if (!(isdefined(level.level_ending) && level.level_ending)) {
        function_556029e1(level.var_fee90489);
    }
    level notify(#"objective_changed", level.var_fee90489);
    if (isdefined(level.var_26b4fb80)) {
        [[ level.var_26b4fb80 ]](level.var_fee90489);
    }
    function_73c9bef8(level.var_fee90489);
    if (isdefined(player)) {
        function_723221dd(player);
    } else {
        foreach (var_63af5576 in level.players) {
            function_723221dd(var_63af5576);
        }
    }
    level thread update_spawn_points(starting);
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0x6bbe60d6, Offset: 0x7e98
// Size: 0xac
function update_spawn_points(starting) {
    level notify(#"update_spawn_points");
    level endon(#"update_spawn_points");
    level endon(#"objective_changed");
    level flag::wait_till("first_player_spawned");
    spawnlogic::clear_spawn_points();
    spawnlogic::add_spawn_points("allies", "cp_coop_spawn");
    spawnlogic::add_spawn_points("allies", "cp_coop_respawn");
    spawning::updateallspawnpoints();
}

// Namespace skipto
// Params 2, eflags: 0x1 linked
// Checksum 0x4b808a76, Offset: 0x7f50
// Size: 0x392
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
            if (!getdvarint("art_review", 0)) {
                function_b342abc7(name, starting);
                if (isdefined(level.var_e07f6589[name].var_1ca15390)) {
                    thread [[ level.var_e07f6589[name].var_1ca15390 ]](name, starting);
                    savegame::checkpoint_save(level.var_e07f6589[name].var_2bc8bbd9);
                }
            }
        }
        if (!(isdefined(level.var_e07f6589[name].var_b992dc79) && level.var_e07f6589[name].var_b992dc79) && isdefined(level.var_e07f6589[name].var_4dfe0d36)) {
            level.var_e07f6589[name].var_b992dc79 = 1;
            thread [[ level.var_e07f6589[name].var_4dfe0d36 ]](name);
        }
    }
    foreach (player in level.players) {
        bb::function_bea1c67c(name, player, "start");
    }
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x2700a7fc, Offset: 0x82f0
// Size: 0x86
function function_c951eb3d() {
    foreach (skipto in level.var_e07f6589) {
        skipto.var_62e39772 = 0;
    }
}

// Namespace skipto
// Params 4, eflags: 0x1 linked
// Checksum 0xf07e784e, Offset: 0x8380
// Size: 0x404
function function_2d700bc6(name, starting, direct, player) {
    if (isarray(name)) {
        foreach (element in name) {
            function_2d700bc6(element, starting, direct, player);
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
            if (!getdvarint("art_review", 0)) {
                if (isdefined(level.var_e07f6589[name].cleanup_func)) {
                    thread [[ level.var_e07f6589[name].cleanup_func ]](name, starting, direct, player);
                }
                function_77ff537d(name, starting, direct, player);
            }
            level notify(name + "_terminate");
        }
        if (!(isdefined(level.var_e07f6589[name].var_62e39772) && level.var_e07f6589[name].var_62e39772)) {
            level.var_e07f6589[name].var_62e39772 = 1;
            if (!(isdefined(level.var_e07f6589[name].looping) && level.var_e07f6589[name].looping)) {
                prev = level.var_e07f6589[name].prev;
                foreach (element in prev) {
                    function_2d700bc6(element, starting, 0, player);
                }
            }
            if (starting && !cleaned) {
                if (!getdvarint("art_review", 0)) {
                    if (isdefined(level.var_e07f6589[name].cleanup_func)) {
                        thread [[ level.var_e07f6589[name].cleanup_func ]](name, starting, 0, player);
                    }
                    function_77ff537d(name, starting, 0, player);
                }
            }
        }
    }
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0xb6de3033, Offset: 0x8790
// Size: 0x22
function filter_spawnpoints(spawnpoints) {
    return function_c13ce5f8(undefined, spawnpoints);
}

// Namespace skipto
// Params 3, eflags: 0x1 linked
// Checksum 0xd1c03e7b, Offset: 0x87c0
// Size: 0x424
function function_c13ce5f8(player, spawnpoints, var_6194780b) {
    objectives = isdefined(var_6194780b) ? var_6194780b : level.var_fee90489;
    if (!isdefined(objectives) || !objectives.size) {
        objectives = function_8b19ec5d();
        if (!isdefined(objectives) || !objectives.size) {
            objectives = level.var_574eb415;
        }
    }
    filter = [];
    if (!isdefined(objectives)) {
        objectives = [];
    } else if (!isarray(objectives)) {
        objectives = array(objectives);
    }
    foreach (objective in objectives) {
        if (isdefined(level.var_e07f6589[objective])) {
            if (isdefined(level.var_e07f6589[objective].var_3c612393) && (isdefined(level.var_e07f6589[objective].public) && level.var_e07f6589[objective].public || level.var_e07f6589[objective].var_3c612393)) {
                if (!isdefined(filter)) {
                    filter = [];
                } else if (!isarray(filter)) {
                    filter = array(filter);
                }
                filter[filter.size] = objective;
            }
        }
    }
    if (isdefined(filter) && filter.size > 0) {
        var_1f96054 = [];
        var_b431a153 = [];
        foreach (point in spawnpoints) {
            point.var_9c98934d = 0;
            if (isdefined(point.script_objective) && isinarray(filter, point.script_objective)) {
                if (!isdefined(var_b431a153)) {
                    var_b431a153 = [];
                } else if (!isarray(var_b431a153)) {
                    var_b431a153 = array(var_b431a153);
                }
                var_b431a153[var_b431a153.size] = point;
                continue;
            }
            if (!isdefined(point.script_objective)) {
                if (!isdefined(var_1f96054)) {
                    var_1f96054 = [];
                } else if (!isarray(var_1f96054)) {
                    var_1f96054 = array(var_1f96054);
                }
                var_1f96054[var_1f96054.size] = point;
                continue;
            }
            point.var_9c98934d = 1;
        }
        if (var_b431a153.size > 0) {
            return var_b431a153;
        }
        return var_1f96054;
    }
    return spawnpoints;
}

// Namespace skipto
// Params 1, eflags: 0x0
// Checksum 0xba3a9eb1, Offset: 0x8bf0
// Size: 0x102
function function_85826560(var_6194780b) {
    a_spawns = spawnlogic::get_spawnpoint_array("cp_coop_spawn");
    foreach (spawn_point in a_spawns) {
        if (spawn_point.script_objective == var_6194780b) {
            if (spawn_point.classname === "script_model") {
                spawn_point delete();
                continue;
            }
            spawn_point struct::delete();
        }
    }
}

// Namespace skipto
// Params 0, eflags: 0x0
// Checksum 0xf2db3205, Offset: 0x8d00
// Size: 0x84
function function_b0e512a3() {
    level.var_696b1f33 = 1;
    str_next_map = function_c7f783fe();
    if (function_89664f42()) {
        switchmap_preload(str_next_map);
        return;
    }
    assert(0, "cp_mi_sing_blackstation");
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0xbb640eec, Offset: 0x8d90
// Size: 0x62
function function_2711019f() {
    while (true) {
        var_14bd4dfe = getlobbyclientcount();
        if (var_14bd4dfe <= level.var_897126b5) {
            level flag::set("all_players_closed_aar");
            break;
        }
        wait(1);
    }
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0xdcf51043, Offset: 0x8e00
// Size: 0x29c
function function_f380969b() {
    self endon(#"disconnect");
    self endon(#"hash_33722592");
    var_67bda5a5 = self getdstat("currentRankXP");
    var_72c4032 = self rank::getrankxpstat();
    var_9e54448b = self getdstat("hasSeenMaxLevelNotification");
    if (var_9e54448b != 1 && var_72c4032 >= rank::getrankinfominxp(level.ranktable.size - 1)) {
        self.var_a4c14d95 = self openluimenu("CPMaxLevelNotification");
        self setdstat("hasSeenMaxLevelNotification", 1);
    } else {
        self.var_a4c14d95 = self openluimenu("RewardsOverlayCP");
    }
    menu, response = self waittill(#"menuresponse");
    while (response != "closed") {
        menu, response = self waittill(#"menuresponse");
    }
    foreach (player in getplayers()) {
        if (player == self) {
            continue;
        }
        player notify(#"hash_33722592");
        player function_33722592();
    }
    self closeluimenu(self.var_a4c14d95);
    self.var_a4c14d95 = undefined;
    next_map = function_c7f783fe();
    if (isdefined(next_map)) {
        self globallogic_player::function_4cef9872(next_map);
    }
    level.var_897126b5++;
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0xc6eb198b, Offset: 0x90a8
// Size: 0xda
function function_c7f783fe() {
    str_next_map = getnextmap();
    if (isdefined(str_next_map) && sessionmodeiscampaignzombiesgame()) {
        tokens = strtok(str_next_map, "_");
        var_a2a8516f = "cp";
        for (i = 1; i < tokens.size - 1; i++) {
            var_a2a8516f = var_a2a8516f + "_" + tokens[i];
        }
        str_next_map = var_a2a8516f;
    }
    return str_next_map;
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0x514f4d9, Offset: 0x9190
// Size: 0x10c
function function_ab286e9e(stat_name) {
    var_8edaf582 = self function_df7ef426(stat_name);
    var_571a5472 = self savegame::function_36adbb9c("savegame_" + stat_name);
    var_aa6cf955 = self getdstat("PlayerStatsByMap", getrootmapname(), "currentStats", stat_name);
    var_a74fbb99 = var_8edaf582 - var_571a5472;
    var_aa6cf955 += var_a74fbb99;
    self setdstat("PlayerStatsByMap", getrootmapname(), "currentStats", stat_name, var_aa6cf955);
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x9ced6753, Offset: 0x92a8
// Size: 0xe4
function function_61688376() {
    self endon(#"disconnect");
    assert(isdefined(level.var_a7c3eb6f));
    assert(level flag::exists("cp_mi_sing_blackstation"));
    self function_a5a105e8();
    util::waittill_notify_or_timeout("stats_changed", 2);
    level.var_a7c3eb6f++;
    var_7fba07d2 = getlobbyclientcount();
    if (var_7fba07d2 <= level.var_a7c3eb6f) {
        level flag::set("all_players_set_aar_scoreboard");
    }
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x8f684282, Offset: 0x9398
// Size: 0x11c
function function_88bd85cc() {
    assert(isdefined(self));
    assert(isplayer(self));
    if (isdefined(self.var_40ac72fa)) {
        self closeluimenu(self.var_40ac72fa);
        self freezecontrols(0);
        if (self ishost()) {
            if (savegame::function_f6ab8f28()) {
                var_5fc3b52f = getmaporder();
                self setdstat("highestMapReached", var_5fc3b52f + 1);
            }
        }
    }
    level flag::set("credits_done");
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x5c044b6b, Offset: 0x94c0
// Size: 0x108
function function_33722592() {
    assert(isdefined(self));
    assert(isplayer(self));
    if (isdefined(self.var_a4c14d95)) {
        self closeluimenu(self.var_a4c14d95);
        self luinotifyevent(%close_cpaar, 0);
        self thread lui::screen_fade_out(0.1, "black");
        next_map = function_c7f783fe();
        if (isdefined(next_map)) {
            self globallogic_player::function_4cef9872(next_map);
        }
        self.var_a4c14d95 = undefined;
        level.var_897126b5++;
    }
}

// Namespace skipto
// Params 2, eflags: 0x1 linked
// Checksum 0x6ca61f8b, Offset: 0x95d0
// Size: 0x196c
function function_eb66277b(skipto, starting) {
    /#
        level thread function_27c2dde4();
    #/
    if (isdefined(level.level_ending) && level.level_ending) {
        return;
    }
    level.level_ending = 1;
    foreach (var_63af5576 in level.players) {
        bb::function_bea1c67c("_level", var_63af5576, "complete");
        bb::function_e7f3440(var_63af5576);
    }
    matchrecordsetcurrentlevelcomplete();
    matchrecordsetleveldifficultyforindex(1, level.gameskill);
    if (level.var_6e1075a2 !== 0) {
        level lui::screen_fade_out(1);
    }
    str_next_map = undefined;
    if (function_92b261a3()) {
        level thread function_9a7d9229();
        level flag::init("credits_done");
        foreach (player in level.players) {
            player thread function_4aa085d7();
        }
        str_next_map = getmapatindex(0);
        level flag::wait_till("credits_done");
    } else {
        str_next_map = function_c7f783fe();
    }
    if (isdefined(str_next_map)) {
        /#
            if (skipto == "cp_mi_sing_blackstation" && starting) {
                wait(4);
            }
        #/
        world.next_map = str_next_map;
        if ((!isdefined(world.var_33c691cb) || getmaporder(str_next_map) > getmaporder(world.var_33c691cb)) && savegame::function_f6ab8f28()) {
            world.var_33c691cb = str_next_map;
            var_5fc3b52f = getmaporder(str_next_map);
            foreach (player in level.players) {
                if (player ishost()) {
                    player setdstat("highestMapReached", var_5fc3b52f);
                    break;
                }
            }
        }
        world.last_map = level.script;
        level clientfield::increment("set_last_map_dvar");
        level accolades::commit(str_next_map);
        if (function_89664f42() || sessionmodeiscampaignzombiesgame()) {
            var_521f25b4 = getmapintromovie(str_next_map);
            if (isdefined(var_521f25b4)) {
                switchmap_setloadingmovie(var_521f25b4);
            }
            if (!(isdefined(level.var_696b1f33) && level.var_696b1f33)) {
                if (sessionmodeiscampaignzombiesgame()) {
                    if (!function_92b261a3()) {
                        switchmap_load(str_next_map);
                    }
                } else {
                    switchmap_load(str_next_map);
                }
                setskiptos("", 1);
            }
        } else {
            var_45e618b3 = getmapoutromovie();
            if (isdefined(var_45e618b3)) {
                switchmap_setloadingmovie(var_45e618b3);
            }
            if (!(isdefined(level.var_696b1f33) && level.var_696b1f33)) {
                setdvar("cp_queued_level", str_next_map);
                var_f26d4e96 = util::function_3eb32a89(str_next_map);
                switchmap_load(var_f26d4e96);
                setskiptos("", 1);
            }
        }
    }
    util::wait_network_frame();
    function_677539fe("");
    foreach (player in getplayers()) {
        player player::take_weapons();
        player savegame::set_player_data("saved_weapon", player._current_weapon.name);
        player savegame::set_player_data("saved_weapondata", player._weapons);
        player savegame::set_player_data("lives", player.lives);
        player._weapons = undefined;
        player.gun_removed = undefined;
    }
    if (sessionmodeiscampaignzombiesgame()) {
        next_map = function_c7f783fe();
        if (isdefined(next_map) && function_cb7247d8(next_map)) {
            foreach (player in level.players) {
                player globallogic_player::function_4cef9872(next_map);
            }
        }
    }
    uploadstats();
    if (!function_92b261a3()) {
        if (getdvarint("tu1_saveNextMapOnLevelComplete", 1)) {
            next_map = function_c7f783fe();
            if (isdefined(next_map)) {
                setskiptos("", 1);
                savegame_create(next_map);
            } else {
                savegame_create();
            }
        } else {
            savegame_create();
        }
    }
    if (!isdefined(str_next_map) || function_cb7247d8(str_next_map)) {
        foreach (e_player in level.players) {
            if (getdvarint("ui_blocksaves") == 0 && e_player ishost() && isdefined(e_player savegame::function_36adbb9c("savegame_score"))) {
                e_player savegame::set_player_data("savegame_score", e_player.pers["score"]);
                e_player savegame::set_player_data("savegame_kills", e_player.pers["kills"]);
                e_player savegame::set_player_data("savegame_assists", e_player.pers["assists"]);
                e_player savegame::set_player_data("savegame_incaps", e_player.pers["incaps"]);
                e_player savegame::set_player_data("savegame_revives", e_player.pers["revives"]);
                e_player function_ab286e9e("score");
                e_player function_ab286e9e("kills");
                e_player function_ab286e9e("assists");
                e_player function_ab286e9e("incaps");
                e_player function_ab286e9e("revives");
                e_player savegame::set_player_data("savegame_score", undefined);
                e_player savegame::set_player_data("savegame_kills", undefined);
                e_player savegame::set_player_data("savegame_assists", undefined);
                e_player savegame::set_player_data("savegame_incaps", undefined);
                e_player savegame::set_player_data("savegame_revives", undefined);
                e_player util::waittill_notify_or_timeout("stats_changed", 2);
            }
            if (!isdefined(getrootmapname())) {
            } else {
                e_player savegame::set_player_data("saved_weapon", undefined);
                e_player savegame::set_player_data("saved_weapondata", undefined);
                e_player savegame::set_player_data("lives", undefined);
                var_1e8a9261 = !e_player getdstat("PlayerStatsByMap", getrootmapname(), "hasBeenCompleted");
                if (isdefined(var_1e8a9261) && var_1e8a9261) {
                    e_player setdstat("PlayerStatsByMap", getrootmapname(), "hasBeenCompleted", 1);
                    if (sessionmodeisonlinegame()) {
                        e_player setdstat("PlayerStatsByMap", getrootmapname(), "firstTimeCompletedUTC", getutc());
                    }
                    e_player thread challenges::function_96ed590f("career_tokens");
                    e_player giveunlocktoken(1);
                }
                if (e_player function_8295f89d(level.var_57830ddc)) {
                    switch (level.var_57830ddc) {
                    case 0:
                        break;
                    case 1:
                        break;
                    case 2:
                        break;
                    case 3:
                        e_player givedecoration("cp_medal_complete_on_veteran");
                        break;
                    case 4:
                        e_player givedecoration("cp_medal_complete_on_veteran");
                        e_player givedecoration("cp_medal_complete_on_realistic");
                        break;
                    }
                }
            }
            e_player setdstat("PlayerStatsByMap", getrootmapname(), "completedDifficulties", level.var_57830ddc, 1);
            var_a4b6fa1f = e_player getdstat("PlayerStatsByMap", getrootmapname(), "highestStats", "HIGHEST_DIFFICULTY");
            if (sessionmodeisonlinegame()) {
                e_player setdstat("PlayerStatsByMap", getrootmapname(), "lastCompletedUTC", getutc());
                timescompleted = e_player getdstat("PlayerStatsByMap", getrootmapname(), "numCompletions");
                if (isdefined(timescompleted)) {
                    e_player setdstat("PlayerStatsByMap", getrootmapname(), "numCompletions", timescompleted + 1);
                }
            }
            recordcomscoreevent("defeat_level", "game_level", getrootmapname(), "game_difficulty_lowest", level.var_57830ddc, "game_difficulty_highest", level.var_a76de5fa, "game_difficulty", level.gameskill, "player_count", level.players.size, "level_duration", gettime() - level.starttime);
            if (level.var_57830ddc > var_a4b6fa1f) {
                e_player setdstat("PlayerStatsByMap", getrootmapname(), "highestStats", "HIGHEST_DIFFICULTY", level.var_57830ddc);
            }
            e_player function_178f7e85(getrootmapname(), level.var_57830ddc);
            achievements::function_733a6065(e_player, getrootmapname(), level.var_57830ddc, sessionmodeiscampaignzombiesgame());
            if (level.var_57830ddc >= 2) {
                e_player notify(#"hash_ee109657", level.var_31b95173);
                e_player addplayerstat("mission_diff_" + getsubstr(getmissionname(), 0, 3), 1);
            }
            e_player function_95093ed5();
            e_player savegame::set_player_data("last_mission", "");
            e_player clearallnoncheckpointdata();
            e_player setdstat("PlayerStatsByMap", getrootmapname(), "lastCompletedDifficulty", level.var_57830ddc);
            if (!e_player decorations::function_25328f50("cp_medal_no_deaths")) {
                if (level.var_57830ddc >= 3 && !(isdefined(world.var_bf966ebd) && world.var_bf966ebd)) {
                    e_player setdstat("PlayerStatsByMap", getrootmapname(), "checkpointUsed", 0);
                    if (e_player decorations::function_931263b1(3)) {
                        e_player givedecoration("cp_medal_no_deaths");
                    }
                } else if (var_a4b6fa1f >= 3 && !(isdefined(e_player getdstat("PlayerStatsByMap", getrootmapname(), "checkpointUsed")) && e_player getdstat("PlayerStatsByMap", getrootmapname(), "checkpointUsed"))) {
                } else {
                    e_player setdstat("PlayerStatsByMap", getrootmapname(), "checkpointUsed", 1);
                }
            }
            if (e_player decorations::function_bea4ff57()) {
                e_player givedecoration("cp_medal_all_weapon_unlocks");
            }
        }
    }
    level flag::init("all_players_set_aar_scoreboard");
    level.var_a7c3eb6f = 0;
    foreach (player in getplayers()) {
        player thread function_61688376();
    }
    level flag::wait_till_timeout(3, "all_players_set_aar_scoreboard");
    function_54fdc879();
    world.var_bf966ebd = undefined;
    recordgameresult("draw");
    globallogic_player::recordactiveplayersendgamematchrecordstats();
    finalizematchrecord();
    if (isdefined(str_next_map)) {
        if (isdefined(level.var_d086f08f) && level.var_d086f08f && !sessionmodeiscampaignzombiesgame()) {
            level accolades::commit(str_next_map);
            foreach (e_player in level.players) {
                e_player setdstat("PlayerStatsByMap", getrootmapname(), "lastCompletedDifficulty", level.var_57830ddc);
                if (e_player decorations::function_e72fc18()) {
                    e_player givedecoration("cp_medal_all_accolades");
                }
            }
            level flag::init("all_players_closed_aar");
            level.var_897126b5 = 0;
            level thread function_2711019f();
            for (i = 0; i < level.players.size; i++) {
                level.players[i] thread function_f380969b();
            }
            callback::on_spawned(&function_3fbee503);
            if (!function_92b261a3()) {
                util::clientnotify("aar");
                music::setmusicstate("aar");
            }
            level flag::wait_till("all_players_closed_aar");
        } else if (!sessionmodeiscampaignzombiesgame()) {
            if (function_cb7247d8(str_next_map)) {
                foreach (player in getplayers()) {
                    player savegame::set_player_data("show_aar", 1);
                }
            } else {
                world.show_aar = undefined;
            }
        }
        if (!function_92b261a3()) {
            switchmap_switch();
            uploadstats();
        } else {
            level notify(#"hash_504f6a41");
            music::setmusicstate("death");
            wait(1);
            if (sessionmodeiscampaignzombiesgame()) {
                uploadstats();
                exitlevel(0);
            } else {
                switchmap_switch();
                uploadstats();
            }
        }
        return;
    }
    uploadstats();
    exitlevel(0);
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x9a7a2330, Offset: 0xaf48
// Size: 0x38
function function_3d23f76a() {
    self endon(#"disconnect");
    while (true) {
        self freezecontrols(1);
        wait(0.05);
    }
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x35ebdac0, Offset: 0xaf88
// Size: 0xac
function function_3fbee503() {
    self endon(#"disconnect");
    level.var_897126b5++;
    self util::function_16c71b8(1);
    self thread function_3d23f76a();
    var_d21ab194 = self openluimenu("SpinnerFullscreenBlack");
    level flag::wait_till("all_players_closed_aar");
    self closeluimenu(var_d21ab194);
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0xa9660b8b, Offset: 0xb040
// Size: 0x194
function function_4aa085d7() {
    self endon(#"disconnect");
    self endon(#"hash_88bd85cc");
    if (isdefined(self)) {
        self.var_40ac72fa = self openluimenu("Credit_Fullscreen", 1);
        self freezecontrols(1);
        menu, response = self waittill(#"menuresponse");
        self closeluimenu(self.var_40ac72fa);
        self freezecontrols(0);
        self.var_40ac72fa = undefined;
        foreach (player in getplayers()) {
            if (player == self) {
                continue;
            }
            player notify(#"hash_88bd85cc");
            player function_88bd85cc();
        }
        level flag::set("credits_done");
    }
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x3f576d67, Offset: 0xb1e0
// Size: 0x6c
function function_9a7d9229() {
    level endon(#"hash_504f6a41");
    wait(59);
    music::setmusicstate("unstoppable_credits");
    wait(-108);
    music::setmusicstate("credits_song_3");
    wait(85);
    music::setmusicstate("credits_song_loop");
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0x6b704031, Offset: 0xb258
// Size: 0x24
function function_cb7247d8(var_b8fc874d) {
    return !ismapsublevel(var_b8fc874d);
}

// Namespace skipto
// Params 2, eflags: 0x1 linked
// Checksum 0x902ec35, Offset: 0xb288
// Size: 0xfa
function function_df7ef426(stat_name, map_name) {
    if (!isdefined(map_name)) {
        map_name = getrootmapname();
    }
    laststat = self getdstat("PlayerStatsByMap", map_name, "currentStats", stat_name);
    var_9948d116 = self getdstat("PlayerStatsList", stat_name, "statValue");
    assert(laststat <= var_9948d116);
    return int(abs(var_9948d116 - laststat));
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0xd4d3d9fa, Offset: 0xb390
// Size: 0x39c
function function_95093ed5(map_name) {
    if (!isdefined(map_name)) {
        map_name = getrootmapname();
    }
    var_32c2816f = [];
    array::add(var_32c2816f, "KILLS");
    array::add(var_32c2816f, "SCORE");
    array::add(var_32c2816f, "ASSISTS");
    array::add(var_32c2816f, "REVIVES");
    foreach (var_8dca536c in var_32c2816f) {
        var_43ea6c98 = function_df7ef426(var_8dca536c, map_name);
        assert(var_43ea6c98 >= 0);
        var_c2a4cf78 = self getdstat("PlayerStatsByMap", map_name, "highestStats", var_8dca536c);
        if (var_43ea6c98 > var_c2a4cf78) {
            self setdstat("PlayerStatsByMap", map_name, "highestStats", var_8dca536c, var_43ea6c98);
        }
    }
    var_43ea6c98 = function_df7ef426("INCAPS", map_name);
    if (!(isdefined(self getdstat("PlayerStatsByMap", map_name, "hasBeenCompleted") != 1) && self getdstat("PlayerStatsByMap", map_name, "hasBeenCompleted") != 1)) {
        self setdstat("PlayerStatsByMap", map_name, "highestStats", "INCAPS", var_43ea6c98);
    } else {
        var_c2a4cf78 = self getdstat("PlayerStatsByMap", map_name, "highestStats", "INCAPS");
        if (var_43ea6c98 < var_c2a4cf78) {
            self setdstat("PlayerStatsByMap", map_name, "highestStats", "INCAPS", var_43ea6c98);
        }
    }
    if (level.var_57830ddc >= 2) {
        var_c2a4cf78 = self getdstat("PlayerStatsByMap", getrootmapname(), "highestStats", "INCAPS");
        if (var_c2a4cf78 == 0) {
            self thread challenges::function_96ed590f("mission_diff_nodeaths");
        }
    }
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0x354b878d, Offset: 0xb738
// Size: 0x138
function function_8295f89d(difficulty) {
    if (self getdstat("PlayerStatsByMap", getrootmapname(), "completedDifficulties", difficulty) == 1) {
        return false;
    }
    var_cfc9cbb7 = function_23eda99c();
    foreach (mission in var_cfc9cbb7) {
        if (mission == getrootmapname()) {
            continue;
        }
        if (self getdstat("PlayerStatsByMap", mission, "completedDifficulties", difficulty) == 0) {
            return false;
        }
    }
    return true;
}

// Namespace skipto
// Params 2, eflags: 0x1 linked
// Checksum 0x41890999, Offset: 0xb878
// Size: 0x20e
function function_178f7e85(var_deb20b04, difficulty) {
    if (self getdstat("PlayerStatsByMap", var_deb20b04, "receivedXPForDifficulty", difficulty) != 0) {
        return;
    }
    for (i = difficulty; i >= 0; i--) {
        if (self getdstat("PlayerStatsByMap", var_deb20b04, "receivedXPForDifficulty", i) == 0) {
            switch (i) {
            case 0:
                self addrankxp("complete_mission_recruit");
                break;
            case 1:
                self addrankxp("complete_mission_regular");
                break;
            case 2:
                self addrankxp("complete_mission_hardened");
                self thread challenges::function_96ed590f("career_difficulty_hard");
                break;
            case 3:
                self addrankxp("complete_mission_veteran");
                self thread challenges::function_96ed590f("career_difficulty_vet");
                break;
            case 4:
                self addrankxp("complete_mission_heroic");
                self thread challenges::function_96ed590f("career_difficulty_real");
                break;
            }
            self setdstat("PlayerStatsByMap", var_deb20b04, "receivedXPForDifficulty", i, 1);
        }
    }
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x9ee42bb2, Offset: 0xba90
// Size: 0x25e
function function_a5a105e8() {
    playerlist = getplayers();
    for (i = 0; i < playerlist.size; i++) {
        e_player = playerlist[i];
        entnum = e_player getentitynumber();
        var_a4306248 = e_player function_df7ef426("score");
        var_aae80abd = e_player function_df7ef426("kills");
        var_8ce58b30 = e_player function_df7ef426("incaps");
        var_fcdd29fe = e_player function_df7ef426("assists");
        var_5c1478bc = e_player function_df7ef426("revives");
        self setdstat("AfterActionReportStats", "playerStats", entnum, "score", var_a4306248);
        self setdstat("AfterActionReportStats", "playerStats", entnum, "kills", var_aae80abd);
        self setdstat("AfterActionReportStats", "playerStats", entnum, "deaths", var_8ce58b30);
        self setdstat("AfterActionReportStats", "playerStats", entnum, "assists", var_fcdd29fe);
        self setdstat("AfterActionReportStats", "playerStats", entnum, "revives", var_5c1478bc);
    }
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x4e640d9, Offset: 0xbcf8
// Size: 0x17a
function function_54fdc879() {
    var_cfc9cbb7 = function_23eda99c();
    foreach (player in level.players) {
        var_6511b67a = 1;
        foreach (mission in var_cfc9cbb7) {
            if (player getdstat("PlayerStatsByMap", mission, "hasBeenCompleted") == 0) {
                var_6511b67a = 0;
                break;
            }
        }
        if (var_6511b67a) {
            player setdstat("zmCampaignData", "unlocked", 1);
        }
    }
}

// Namespace skipto
// Params 2, eflags: 0x5 linked
// Checksum 0x7a44328d, Offset: 0xbe80
// Size: 0x86
function private function_b342abc7(skipto, starting) {
    if (isdefined(level.var_dc323706)) {
        [[ level.var_dc323706 ]](skipto, starting);
    }
    level flag::set(skipto);
    level thread function_da2e7bff(skipto);
    level.var_c0e97bd = skipto;
    level notify(#"hash_7b06f432");
}

// Namespace skipto
// Params 1, eflags: 0x0
// Checksum 0x60df9955, Offset: 0xbf10
// Size: 0x24
function function_ab12ef82(str_flag) {
    util::function_ab12ef82(str_flag);
}

// Namespace skipto
// Params 4, eflags: 0x5 linked
// Checksum 0xbf3327c7, Offset: 0xbf40
// Size: 0x29a
function private function_77ff537d(skipto, starting, direct, player) {
    if (isdefined(level.var_e8899224)) {
        [[ level.var_e8899224 ]]();
    }
    level flag::clear(skipto);
    level flag::set(skipto + "_completed");
    if (!isdefined(level.var_e07f6589[skipto])) {
        assertmsg("cp_mi_sing_blackstation" + skipto);
    }
    if (!(isdefined(level.var_f6ded45a) && level.var_f6ded45a)) {
        waittillframeend();
        a_entities = getentarray(skipto, "script_objective");
        foreach (entity in a_entities) {
            if (issentient(entity)) {
                if (!isdefined(level.heroes) || !isinarray(level.heroes, entity)) {
                    entity thread util::auto_delete();
                }
                continue;
            }
            if (isvehicle(entity)) {
                entity.delete_on_death = 1;
                entity notify(#"death");
                if (!isalive(entity)) {
                    entity delete();
                }
                continue;
            }
            if (sessionmodeiscampaignzombiesgame() && entity.script_noteworthy === "bonuszm_magicbox") {
                if (isdefined(level.var_380bc8b7)) {
                    [[ level.var_380bc8b7 ]](entity);
                }
                continue;
            }
            entity delete();
        }
    }
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0xf10a5d87, Offset: 0xc1e8
// Size: 0x102
function function_da2e7bff(name) {
    var_f09f58e0 = undefined;
    var_41c34432 = getentarray("objective", "targetname");
    foreach (trigger in var_41c34432) {
        if (trigger.script_objective == name) {
            if (!isdefined(var_f09f58e0)) {
                var_f09f58e0 = trigger;
            }
            var_f09f58e0 thread function_397eb920(trigger, name);
        }
    }
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0xac583600, Offset: 0xc2f8
// Size: 0xac
function function_d61fbd4b(trigger) {
    foreach (player in getplayers()) {
        if (!player istouching(trigger)) {
            return false;
        }
    }
    return true;
}

// Namespace skipto
// Params 2, eflags: 0x1 linked
// Checksum 0xc5a7a133, Offset: 0xc3b0
// Size: 0x170
function function_eb0ecd7a(trigger, name) {
    trigger endon(#"death");
    level endon(name + "_terminate");
    if (trigger.script_noteworthy === "allplayers") {
        do {
            player = trigger waittill(#"trigger");
        } while (!function_d61fbd4b(trigger));
    } else {
        player = trigger waittill(#"trigger");
        if (trigger.script_noteworthy === "warpplayers") {
            foreach (other_player in level.players) {
                if (other_player != player) {
                    other_player thread function_eb7240f8();
                }
            }
        }
    }
    level thread function_be8adfb8(trigger.script_objective, player);
    return player;
}

// Namespace skipto
// Params 2, eflags: 0x1 linked
// Checksum 0x6782af96, Offset: 0xc528
// Size: 0x56
function function_397eb920(trigger, name) {
    self endon(#"hash_397eb920");
    player = function_eb0ecd7a(trigger, name);
    self notify(#"hash_397eb920");
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0xa7318d0, Offset: 0xc588
// Size: 0xa2
function function_eb7240f8() {
    self.suicide = 0;
    self.teamkilled = 0;
    timepassed = undefined;
    if (isdefined(self.respawntimerstarttime)) {
        timepassed = (gettime() - self.respawntimerstarttime) / 1000;
    }
    if (self laststand::player_is_in_laststand()) {
        self notify(#"auto_revive");
        waittillframeend();
    }
    self notify(#"death");
    self thread [[ level.spawnclient ]](timepassed);
    self.respawntimerstarttime = undefined;
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x7b557f5d, Offset: 0xc638
// Size: 0x248
function function_143fd222() {
    var_e276a329 = struct::get_array("entity_objective_loc");
    foreach (mover in var_e276a329) {
        if (!isdefined(mover.angles)) {
            mover.angles = (0, 0, 0);
        }
        if (isdefined(mover.script_objective) && isdefined(level.var_e07f6589[mover.script_objective])) {
            if (!isdefined(level.var_e07f6589[mover.script_objective].var_17618905)) {
                level.var_e07f6589[mover.script_objective].var_17618905 = [];
            } else if (!isarray(level.var_e07f6589[mover.script_objective].var_17618905)) {
                level.var_e07f6589[mover.script_objective].var_17618905 = array(level.var_e07f6589[mover.script_objective].var_17618905);
            }
            level.var_e07f6589[mover.script_objective].var_17618905[level.var_e07f6589[mover.script_objective].var_17618905.size] = mover;
        }
    }
    for (;;) {
        objectives = level waittill(#"objective_changed");
        function_be04f9a5(objectives);
    }
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0x38d1310f, Offset: 0xc888
// Size: 0x110
function function_be04f9a5(objectives) {
    foreach (objective in objectives) {
        foreach (mover in level.var_e07f6589[objective].var_17618905) {
            thread function_1c1454cd(mover);
        }
    }
}

// Namespace skipto
// Params 1, eflags: 0x1 linked
// Checksum 0x28dfc60a, Offset: 0xc9a0
// Size: 0x4e2
function function_1c1454cd(mover) {
    targets = getentarray(mover.target, "targetname");
    if (isdefined(mover.script_noteworthy) && mover.script_noteworthy == "relative") {
        speed = 0;
        if (isdefined(mover.script_int)) {
            speed = mover.script_int;
        }
        if (speed == 0) {
            speed = 0.05;
        }
        foreach (target in targets) {
            if (!isdefined(target.var_2c2e94d1)) {
                target.var_2c2e94d1 = mover;
                target.var_86803507 = mover;
            } else {
                var_2c2e94d1 = target.var_86803507;
            }
            if (!isdefined(var_2c2e94d1)) {
                var_2c2e94d1 = mover;
                speed = 0.05;
                continue;
            }
            assert(var_2c2e94d1 == target.var_86803507, "cp_mi_sing_blackstation");
        }
        if (!isdefined(var_2c2e94d1) || var_2c2e94d1 == mover) {
            return;
        }
        script_mover = spawn("script_origin", var_2c2e94d1.origin);
        script_mover.angles = var_2c2e94d1.angles;
        foreach (target in targets) {
            target linkto(script_mover, "", script_mover worldtolocalcoords(target.origin), target.angles - script_mover.angles);
        }
        util::wait_network_frame();
        script_mover moveto(mover.origin, speed);
        script_mover rotateto(mover.angles, speed);
        script_mover waittill(#"movedone");
        foreach (target in targets) {
            target.var_86803507 = mover;
            target unlink();
        }
        script_mover delete();
        return;
    }
    foreach (target in targets) {
        target.origin = mover.origin;
        if (isdefined(mover.angles)) {
            target.angles = mover.angles;
        }
    }
}

// Namespace skipto
// Params 0, eflags: 0x0
// Checksum 0xe4066b0e, Offset: 0xce90
// Size: 0x24
function function_f3e035ef() {
    level flag::set("skip_safehouse_after_map");
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x9234abc6, Offset: 0xcec0
// Size: 0x3a
function function_89664f42() {
    return level flag::get("skip_safehouse_after_map") || sessionmodeiscampaignzombiesgame();
}

// Namespace skipto
// Params 0, eflags: 0x0
// Checksum 0xd3f81f36, Offset: 0xcf08
// Size: 0x24
function function_272e1c8d() {
    level flag::set("final_level");
}

// Namespace skipto
// Params 0, eflags: 0x1 linked
// Checksum 0x1a5026a8, Offset: 0xcf38
// Size: 0x22
function function_92b261a3() {
    return level flag::get("final_level");
}

/#

    // Namespace skipto
    // Params 0, eflags: 0x1 linked
    // Checksum 0xce9aa465, Offset: 0xcf68
    // Size: 0xe2
    function function_27c2dde4() {
        if (isdefined(level.var_3f831f3b) && isdefined(level.var_3f831f3b["cp_mi_sing_blackstation"])) {
            foreach (scene in level.var_3f831f3b["cp_mi_sing_blackstation"]) {
                if (!isdefined(scene.used)) {
                    println("cp_mi_sing_blackstation" + scene.name);
                }
            }
        }
    }

    // Namespace skipto
    // Params 0, eflags: 0x1 linked
    // Checksum 0x41883b8, Offset: 0xd058
    // Size: 0x244
    function function_7b06f432() {
        self endon(#"death");
        while (true) {
            if (isdefined(level.var_81fdc5c1) && isdefined(level.var_81fdc5c1[level.var_c0e97bd])) {
                event_name = level.var_81fdc5c1[level.var_c0e97bd][0];
                var_f23fc04b = level.var_f2898bd7 === event_name;
                if (!var_f23fc04b) {
                    level.var_f2898bd7 = event_name;
                    level.var_c79b41f2 = level.var_81fdc5c1[level.var_c0e97bd][1];
                    level.var_5f835655 = level.var_81fdc5c1[level.var_c0e97bd][2];
                    level.var_8debf51 = level.var_81fdc5c1[level.var_c0e97bd][3];
                    foreach (player in level.players) {
                        player notify(#"hash_7b06f432");
                    }
                } else {
                    assert(level.var_c79b41f2 == level.var_81fdc5c1[level.var_c0e97bd][1], "cp_mi_sing_blackstation");
                    assert(level.var_5f835655 == level.var_81fdc5c1[level.var_c0e97bd][2], "cp_mi_sing_blackstation");
                    assert(level.var_8debf51 == level.var_81fdc5c1[level.var_c0e97bd][3], "cp_mi_sing_blackstation");
                }
            }
            level waittill(#"hash_7b06f432");
        }
    }

    // Namespace skipto
    // Params 0, eflags: 0x1 linked
    // Checksum 0xa6e94386, Offset: 0xd2a8
    // Size: 0x1a4
    function function_c40086b6() {
        self endon(#"death");
        lui_menu = undefined;
        while (true) {
            if (isdefined(level.var_f2898bd7)) {
                if (level.var_f2898bd7 == "cp_mi_sing_blackstation") {
                    if (isdefined(lui_menu)) {
                        self closeluimenu(lui_menu);
                        lui_menu = undefined;
                    }
                } else {
                    if (!isdefined(lui_menu)) {
                        lui_menu = self openluimenu("cp_mi_sing_blackstation");
                    }
                    self lui::play_animation(lui_menu, "cp_mi_sing_blackstation");
                    if (isdefined(level.var_8debf51)) {
                        self setluimenudata(lui_menu, "cp_mi_sing_blackstation", level.var_f2898bd7 + "cp_mi_sing_blackstation" + level.var_8debf51 + "cp_mi_sing_blackstation");
                    } else {
                        self setluimenudata(lui_menu, "cp_mi_sing_blackstation", level.var_f2898bd7);
                    }
                    self setluimenudata(lui_menu, "cp_mi_sing_blackstation", level.var_c79b41f2);
                    self setluimenudata(lui_menu, "cp_mi_sing_blackstation", level.var_5f835655);
                }
            }
            self waittill(#"hash_7b06f432");
        }
    }

#/
