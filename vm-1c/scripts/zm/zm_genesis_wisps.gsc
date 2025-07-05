#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/challenges_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_genesis_util;
#using scripts/zm/zm_genesis_vo;

#namespace zm_genesis_wisps;

// Namespace zm_genesis_wisps
// Params 0, eflags: 0x2
// Checksum 0xa9422abb, Offset: 0x570
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_genesis_wisps", &__init__, &__main__, undefined);
}

// Namespace zm_genesis_wisps
// Params 0, eflags: 0x0
// Checksum 0x849899ee, Offset: 0x5b8
// Size: 0x84
function __init__() {
    clientfield::register("toplayer", "set_funfact_fx", 15000, 3, "int");
    clientfield::register("scriptmover", "wisp_fx", 15000, 2, "int");
    callback::on_disconnect(&on_player_disconnect);
}

// Namespace zm_genesis_wisps
// Params 0, eflags: 0x0
// Checksum 0xfd7526cf, Offset: 0x648
// Size: 0xb4
function __main__() {
    /#
        if (getdvarint("<dev string:x28>") > 0) {
            level thread function_a9d6e3ef();
        }
    #/
    level waittill(#"start_zombie_round_logic");
    level flag::init("funfacts_started");
    level flag::init("funfacts_activated");
    level thread function_d1c51308();
    level thread function_bce246fa();
}

// Namespace zm_genesis_wisps
// Params 0, eflags: 0x0
// Checksum 0xa6142a01, Offset: 0x708
// Size: 0x24
function on_player_disconnect() {
    self clientfield::set_to_player("set_funfact_fx", 0);
}

// Namespace zm_genesis_wisps
// Params 0, eflags: 0x0
// Checksum 0xad96b3e, Offset: 0x738
// Size: 0x154
function function_d1c51308() {
    level.a_wisps = [];
    level.a_wisps["s_trig"] = struct::get_array("s_trig_wisp", "targetname");
    level.a_wisps["s_fx"] = struct::get_array("s_fx_wisp", "targetname");
    foreach (s_trig in level.a_wisps["s_trig"]) {
        s_unitrigger = s_trig zm_unitrigger::create_unitrigger(%, 64, &function_836f0458);
        s_unitrigger.require_look_at = 1;
    }
    level thread function_f61f49b0();
}

// Namespace zm_genesis_wisps
// Params 0, eflags: 0x0
// Checksum 0x4ca147c1, Offset: 0x898
// Size: 0x278
function function_f61f49b0() {
    var_96cdbf35 = array("abcd", "abcd", "shad");
    var_6cf8e556 = array("shad", "abcd");
    while (true) {
        str_notify = level util::waittill_any_return("wisps_on_abcd", "wisps_on_shad", "boss_round_end_vo_done", "chaos_round_end_vo_done", "wisps_off");
        if (str_notify == "wisps_on_abcd") {
            zm_genesis_vo::function_4821b1a3("abcd");
            function_719d3043(1, "abcd");
            continue;
        }
        if (str_notify == "wisps_on_shad") {
            zm_genesis_vo::function_4821b1a3("shad");
            function_719d3043(1, "shad");
            continue;
        }
        if (str_notify == "boss_round_end_vo_done" && var_6cf8e556.size > 0) {
            var_effd4dcc = var_6cf8e556[0];
            zm_genesis_vo::function_4821b1a3(var_effd4dcc);
            function_719d3043(1, var_effd4dcc);
            arrayremoveindex(var_6cf8e556, 0, 0);
            continue;
        }
        if (str_notify == "chaos_round_end_vo_done" && var_96cdbf35.size > 0) {
            var_effd4dcc = var_96cdbf35[0];
            zm_genesis_vo::function_4821b1a3(var_effd4dcc);
            function_719d3043(1, var_effd4dcc);
            arrayremoveindex(var_96cdbf35, 0, 0);
            continue;
        }
        if (str_notify == "wisps_off") {
            function_719d3043(0, undefined);
        }
    }
}

// Namespace zm_genesis_wisps
// Params 2, eflags: 0x0
// Checksum 0x40d31599, Offset: 0xb18
// Size: 0x1c2
function function_719d3043(b_on, var_46866c13) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    if (b_on) {
        assert(var_46866c13 == "<dev string:x35>" || var_46866c13 == "<dev string:x3a>", "<dev string:x3f>");
        level.var_c1feb276 = "wisp_" + var_46866c13;
        foreach (s_trig in level.a_wisps["s_trig"]) {
            s_trig thread function_26ed5998(1, var_46866c13);
        }
        return;
    }
    level.var_11db95ba = "wisp_off";
    foreach (s_trig in level.a_wisps["s_trig"]) {
        s_trig thread function_26ed5998(0, var_46866c13);
    }
}

// Namespace zm_genesis_wisps
// Params 2, eflags: 0x0
// Checksum 0x4e86553a, Offset: 0xce8
// Size: 0x194
function function_26ed5998(b_on, var_46866c13) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    if (!isdefined(var_46866c13)) {
        var_46866c13 = "abcd";
    }
    var_c4217816 = [];
    var_c4217816["abcd"] = 1;
    var_c4217816["shad"] = 2;
    if (isdefined(self)) {
        if (b_on && !isdefined(self.var_3dc2890d)) {
            s_fx = struct::get(self.target, "targetname");
            self.var_3dc2890d = util::spawn_model("tag_origin", s_fx.origin, s_fx.angles);
            self.var_3dc2890d clientfield::set("wisp_fx", var_c4217816[var_46866c13]);
            self.s_unitrigger.b_on = 1;
            self thread function_3bcaa1c();
            return;
        }
        if (isdefined(self.var_3dc2890d)) {
            self.var_3dc2890d delete();
            self notify(#"hash_d8f13b7d");
            self.s_unitrigger.b_on = 0;
        }
    }
}

// Namespace zm_genesis_wisps
// Params 0, eflags: 0x0
// Checksum 0xcd548e67, Offset: 0xe88
// Size: 0xd8
function function_3bcaa1c() {
    self endon(#"hash_d8f13b7d");
    while (true) {
        self waittill(#"trigger_activated", e_player);
        /#
            zm_utility::debug_print("<dev string:x77>");
        #/
        if (level.var_c1feb276 != "off" && !level flag::get("abcd_speaking") && !level flag::get("shadowman_speaking")) {
            level thread zm_genesis_vo::function_10b9b50e(level.var_c1feb276);
            self thread function_26ed5998(0);
        }
    }
}

// Namespace zm_genesis_wisps
// Params 1, eflags: 0x0
// Checksum 0x445df987, Offset: 0xf68
// Size: 0x98
function function_836f0458(e_player) {
    if (isdefined(self.stub.b_on) && self.stub.b_on && level.var_c1feb276 !== "off") {
        /#
            self sethintstring("<dev string:x86>");
        #/
        return 1;
    }
    /#
        self sethintstring("<dev string:x95>");
    #/
    return 0;
}

// Namespace zm_genesis_wisps
// Params 0, eflags: 0x0
// Checksum 0x47274cbb, Offset: 0x1008
// Size: 0x2fc
function function_bce246fa() {
    level.var_e2304a21 = [];
    level.var_e2304a21["s_trig"] = [];
    level.var_e2304a21["s_trig"][0] = struct::get("s_trig_funfact_demp", "targetname");
    level.var_e2304a21["s_trig"][1] = struct::get("s_trig_funfact_niko", "targetname");
    level.var_e2304a21["s_trig"][2] = struct::get("s_trig_funfact_rich", "targetname");
    level.var_e2304a21["s_trig"][3] = struct::get("s_trig_funfact_take", "targetname");
    level.var_e2304a21["s_fx"] = [];
    level.var_e2304a21["s_fx"][0] = struct::get("s_fx_funfact_demp", "targetname");
    level.var_e2304a21["s_fx"][1] = struct::get("s_fx_funfact_niko", "targetname");
    level.var_e2304a21["s_fx"][2] = struct::get("s_fx_funfact_rich", "targetname");
    level.var_e2304a21["s_fx"][3] = struct::get("s_fx_funfact_take", "targetname");
    foreach (s_trig in level.var_e2304a21["s_trig"]) {
        s_unitrigger = s_trig zm_unitrigger::create_unitrigger(%, 64, &function_caef395a);
        s_unitrigger.require_look_at = 1;
        s_unitrigger.script_int = s_trig.script_int;
    }
    level thread function_b177eb62();
}

// Namespace zm_genesis_wisps
// Params 0, eflags: 0x0
// Checksum 0x63526d55, Offset: 0x1310
// Size: 0xc0
function function_b177eb62() {
    var_76bf4ac6 = level.var_783db6ab;
    while (true) {
        str_wait = util::waittill_any_return("start_of_round");
        if (level.round_number > var_76bf4ac6) {
            while (level flag::get("abcd_speaking") || level flag::get("shadowman_speaking")) {
                wait 0.1;
            }
            level thread function_cf810f3f(1);
        }
    }
}

// Namespace zm_genesis_wisps
// Params 1, eflags: 0x0
// Checksum 0xea42dd23, Offset: 0x13d8
// Size: 0xb2
function function_cf810f3f(b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    foreach (s_trig in level.var_e2304a21["s_trig"]) {
        s_trig thread function_584171ff(b_on);
    }
}

// Namespace zm_genesis_wisps
// Params 1, eflags: 0x0
// Checksum 0xe163b0e0, Offset: 0x1498
// Size: 0x15e
function function_584171ff(b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    if (isdefined(self)) {
        if (b_on && !(isdefined(self.s_unitrigger.b_on) && self.s_unitrigger.b_on) && level.var_8c92b387["fun_facts"][self.script_int].size > 0) {
            e_player = zm_utility::function_a157d632(self.script_int);
            if (isdefined(e_player)) {
                e_player thread set_funfact_fx(1);
            }
            self.s_unitrigger.b_on = 1;
            self thread function_198aed06();
            return;
        }
        if (!b_on) {
            e_player = zm_utility::function_a157d632(self.script_int);
            if (isdefined(e_player)) {
                e_player thread set_funfact_fx(0);
            }
            self.s_unitrigger.b_on = 0;
            self notify(#"hash_d8f13b7d");
        }
    }
}

// Namespace zm_genesis_wisps
// Params 1, eflags: 0x0
// Checksum 0xe70b12f, Offset: 0x1600
// Size: 0x84
function set_funfact_fx(b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    if (b_on) {
        var_f111a90b = self.characterindex + 1;
        self clientfield::set_to_player("set_funfact_fx", var_f111a90b);
        return;
    }
    self clientfield::set_to_player("set_funfact_fx", 0);
}

// Namespace zm_genesis_wisps
// Params 0, eflags: 0x0
// Checksum 0xe8f4ec44, Offset: 0x1690
// Size: 0x1b8
function function_198aed06() {
    self endon(#"hash_77f5f32b");
    while (true) {
        self waittill(#"trigger_activated", e_player);
        /#
            zm_utility::debug_print("<dev string:x77>");
        #/
        if (self.script_int == e_player.characterindex && !level flag::get("abcd_speaking") && !level flag::get("shadowman_speaking")) {
            self thread function_584171ff(0);
            if (!level flag::get("funfacts_started")) {
                level thread zm_genesis_vo::function_36734069();
                level flag::set("funfacts_started");
                continue;
            }
            if (!level flag::get("funfacts_activated")) {
                level flag::set("funfacts_activated");
                level zm_genesis_vo::function_2050fb34();
                level thread zm_genesis_vo::function_bbeae714(e_player.characterindex);
                continue;
            }
            level thread zm_genesis_vo::function_bbeae714(e_player.characterindex);
        }
    }
}

// Namespace zm_genesis_wisps
// Params 1, eflags: 0x0
// Checksum 0x9105c1f1, Offset: 0x1850
// Size: 0xc8
function function_caef395a(e_player) {
    if (isdefined(self.stub.b_on) && self.stub.b_on) {
        if (self.stub.script_int == e_player.characterindex) {
            /#
                self sethintstring("<dev string:xa5>");
            #/
            return 1;
        } else {
            /#
                self sethintstring("<dev string:xb8>");
            #/
            return 0;
        }
        return;
    }
    /#
        self sethintstring("<dev string:xd7>");
    #/
    return 0;
}

/#

    // Namespace zm_genesis_wisps
    // Params 0, eflags: 0x0
    // Checksum 0x35244591, Offset: 0x1920
    // Size: 0x4ec
    function function_a9d6e3ef() {
        level thread zm_genesis_util::function_72260d3a("<dev string:xeb>", "<dev string:x11d>", 0, &function_d4b54e53);
        level thread zm_genesis_util::function_72260d3a("<dev string:x133>", "<dev string:x165>", 1, &function_d4b54e53);
        level thread zm_genesis_util::function_72260d3a("<dev string:x17b>", "<dev string:x1af>", 2, &function_d4b54e53);
        level thread zm_genesis_util::function_72260d3a("<dev string:x1c5>", "<dev string:x1f5>", 3, &function_d4b54e53);
        level thread zm_genesis_util::function_72260d3a("<dev string:x20b>", "<dev string:x234>", 0, &function_910a409b);
        level thread zm_genesis_util::function_72260d3a("<dev string:x244>", "<dev string:x26d>", 1, &function_910a409b);
        level thread zm_genesis_util::function_72260d3a("<dev string:x27d>", "<dev string:x2a8>", 2, &function_910a409b);
        level thread zm_genesis_util::function_72260d3a("<dev string:x2b8>", "<dev string:x2df>", 3, &function_910a409b);
        level thread zm_genesis_util::function_72260d3a("<dev string:x2ef>", "<dev string:x31c>", 0, &function_920920c8);
        level thread zm_genesis_util::function_72260d3a("<dev string:x331>", "<dev string:x35f>", 1, &function_920920c8);
        level thread zm_genesis_util::function_72260d3a("<dev string:x374>", "<dev string:x3a4>", 2, &function_920920c8);
        level thread zm_genesis_util::function_72260d3a("<dev string:x3b9>", "<dev string:x3e5>", 3, &function_920920c8);
        level thread zm_genesis_util::function_72260d3a("<dev string:x3fa>", "<dev string:x41d>", 1, &function_4701ab9e);
        level thread zm_genesis_util::function_72260d3a("<dev string:x42c>", "<dev string:x44f>", 2, &function_4701ab9e);
        level thread zm_genesis_util::function_72260d3a("<dev string:x45e>", "<dev string:x487>", 1, &function_76a93e50);
        level thread zm_genesis_util::function_72260d3a("<dev string:x495>", "<dev string:x4be>", 2, &function_76a93e50);
        level thread zm_genesis_util::function_72260d3a("<dev string:x4cd>", "<dev string:x4ee>", 1, &function_eaebf31c);
        level thread zm_genesis_util::function_72260d3a("<dev string:x4f9>", "<dev string:x51a>", 2, &function_eaebf31c);
        level thread zm_genesis_util::function_72260d3a("<dev string:x525>", "<dev string:x540>", 0, &function_eaebf31c);
        level thread zm_genesis_util::function_72260d3a("<dev string:x54a>", "<dev string:x57c>", 0, &function_371c89ce);
        level thread zm_genesis_util::function_72260d3a("<dev string:x589>", "<dev string:x5be>", 1, &function_371c89ce);
        level thread zm_genesis_util::function_72260d3a("<dev string:x5cc>", "<dev string:x600>", 2, &function_371c89ce);
        level thread zm_genesis_util::function_72260d3a("<dev string:x60e>", "<dev string:x644>", 3, &function_371c89ce);
    }

    // Namespace zm_genesis_wisps
    // Params 1, eflags: 0x0
    // Checksum 0xd65b0eb, Offset: 0x1e18
    // Size: 0x4c
    function function_68f439f5(n_val) {
        player = level.activeplayers[n_val];
        if (isdefined(player)) {
            player set_funfact_fx(1);
        }
    }

    // Namespace zm_genesis_wisps
    // Params 1, eflags: 0x0
    // Checksum 0x9e6993a2, Offset: 0x1e70
    // Size: 0x4c
    function function_12821101(n_val) {
        player = level.activeplayers[n_val];
        if (isdefined(player)) {
            player set_funfact_fx(0);
        }
    }

    // Namespace zm_genesis_wisps
    // Params 1, eflags: 0x0
    // Checksum 0x13a781ed, Offset: 0x1ec8
    // Size: 0xbe
    function function_910a409b(n_val) {
        foreach (s_trig in level.var_e2304a21["<dev string:x651>"]) {
            if (s_trig.script_int == n_val) {
                s_trig thread function_584171ff(1);
                break;
            }
        }
    }

    // Namespace zm_genesis_wisps
    // Params 1, eflags: 0x0
    // Checksum 0x11a5b386, Offset: 0x1f90
    // Size: 0x134
    function function_d4b54e53(n_val) {
        var_f0f08a9d = array("<dev string:x658>", "<dev string:x66a>", "<dev string:x67c>", "<dev string:x68e>");
        s_dest = struct::get(var_f0f08a9d[n_val], "<dev string:x6a0>");
        if (isdefined(s_dest)) {
            player = level.activeplayers[0];
            var_5d8a4d6d = util::spawn_model("<dev string:x6ab>", player.origin, player.angles);
            player linkto(var_5d8a4d6d);
            var_5d8a4d6d.origin = s_dest.origin;
            wait 0.5;
            player unlink();
        }
    }

    // Namespace zm_genesis_wisps
    // Params 1, eflags: 0x0
    // Checksum 0x492cca6c, Offset: 0x20d0
    // Size: 0x3c
    function function_96632750(n_val) {
        zm_genesis_vo::function_bbeae714(level.activeplayers[n_val].characterindex);
    }

    // Namespace zm_genesis_wisps
    // Params 1, eflags: 0x0
    // Checksum 0x6ea05532, Offset: 0x2118
    // Size: 0x24
    function function_920920c8(n_val) {
        zm_genesis_vo::function_bbeae714(n_val);
    }

    // Namespace zm_genesis_wisps
    // Params 1, eflags: 0x0
    // Checksum 0xf01863cd, Offset: 0x2148
    // Size: 0x54
    function function_4701ab9e(n_val) {
        if (n_val == 1) {
            zm_genesis_vo::function_10b9b50e("<dev string:x6b6>");
            return;
        }
        zm_genesis_vo::function_10b9b50e("<dev string:x6c0>");
    }

    // Namespace zm_genesis_wisps
    // Params 1, eflags: 0x0
    // Checksum 0x2c1b987e, Offset: 0x21a8
    // Size: 0x54
    function function_76a93e50(n_val) {
        if (n_val == 1) {
            zm_genesis_vo::function_4821b1a3("<dev string:x35>");
            return;
        }
        zm_genesis_vo::function_4821b1a3("<dev string:x3a>");
    }

    // Namespace zm_genesis_wisps
    // Params 1, eflags: 0x0
    // Checksum 0xce84eef1, Offset: 0x2208
    // Size: 0x66
    function function_eaebf31c(n_val) {
        if (n_val == 1) {
            level notify(#"wisps_on_abcd");
            return;
        }
        if (n_val == 2) {
            level notify(#"wisps_on_shad");
            return;
        }
        if (n_val == 0) {
            level notify(#"wisps_off");
        }
    }

    // Namespace zm_genesis_wisps
    // Params 1, eflags: 0x0
    // Checksum 0x920dd1c2, Offset: 0x2278
    // Size: 0x144
    function function_371c89ce(n_val) {
        var_f0f08a9d = array("<dev string:x6ca>", "<dev string:x6d6>", "<dev string:x6e2>", "<dev string:x6ee>");
        s_dest = struct::get(var_f0f08a9d[n_val]);
        if (isdefined(s_dest)) {
            player = level.activeplayers[0];
            var_5d8a4d6d = util::spawn_model("<dev string:x6ab>", player.origin, player.angles);
            player linkto(var_5d8a4d6d);
            var_5d8a4d6d.origin = s_dest.origin;
            wait 0.5;
            player unlink();
            var_5d8a4d6d delete();
        }
    }

#/
