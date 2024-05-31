#using scripts/zm/zm_theater_amb;
#using scripts/zm/zm_theater;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_utility;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_39123edc;

// Namespace namespace_39123edc
// Params 0, eflags: 0x1 linked
// namespace_39123edc<file_0>::function_4675a945
// Checksum 0x5481440d, Offset: 0x398
// Size: 0x34
function function_4675a945() {
    level thread function_bdabe901();
    level thread function_fdb6bd42();
}

// Namespace namespace_39123edc
// Params 0, eflags: 0x1 linked
// namespace_39123edc<file_0>::function_bdabe901
// Checksum 0xd7aca72a, Offset: 0x3d8
// Size: 0xcc
function function_bdabe901() {
    level flag::wait_till("power_on");
    var_ae105d19 = getent("theater_curtains_clip", "targetname");
    var_ae105d19 notsolid();
    var_ae105d19 connectpaths();
    level namespace_aed37ba8::function_ce6ee03b();
    wait(3);
    level thread function_a643b290();
    wait(6);
    level flag::set("curtains_done");
}

// Namespace namespace_39123edc
// Params 1, eflags: 0x0
// namespace_39123edc<file_0>::function_add8a139
// Checksum 0x916091bb, Offset: 0x4b0
// Size: 0xf8
function function_add8a139(var_9c1ef06b) {
    clip = getent(self.target, "targetname");
    while (isdefined(clip)) {
        if (abs(var_9c1ef06b[0] - self.origin[0]) >= 38) {
            clip connectpaths();
            clip notsolid();
            if (isdefined(clip.target)) {
                clip = getent(clip.target, "targetname");
            } else {
                clip = undefined;
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_39123edc
// Params 0, eflags: 0x0
// namespace_39123edc<file_0>::function_d27fb578
// Checksum 0xa7e5f4e8, Offset: 0x5b0
// Size: 0x12c
function function_d27fb578() {
    level flag::wait_till("power_on");
    var_a4088989 = getent("left_curtain", "targetname");
    if (isdefined(var_a4088989)) {
        wait(2);
        var_78470c06 = getentarray("left_curtain_clip", "targetname");
        for (i = 0; i < var_78470c06.size; i++) {
            var_78470c06[i] connectpaths();
            var_78470c06[i] notsolid();
        }
        var_a4088989 connectpaths();
        var_a4088989 movex(-300, 2);
    }
}

// Namespace namespace_39123edc
// Params 0, eflags: 0x0
// namespace_39123edc<file_0>::function_2e915265
// Checksum 0x6f37431a, Offset: 0x6e8
// Size: 0x12c
function function_2e915265() {
    level flag::wait_till("power_on");
    var_a4088989 = getent("right_curtain", "targetname");
    if (isdefined(var_a4088989)) {
        wait(2);
        var_78470c06 = getentarray("right_curtain_clip", "targetname");
        for (i = 0; i < var_78470c06.size; i++) {
            var_78470c06[i] connectpaths();
            var_78470c06[i] notsolid();
        }
        var_a4088989 connectpaths();
        var_a4088989 movex(300, 2);
    }
}

// Namespace namespace_39123edc
// Params 0, eflags: 0x1 linked
// namespace_39123edc<file_0>::function_a643b290
// Checksum 0x4d8083b8, Offset: 0x820
// Size: 0xbc
function function_a643b290() {
    var_d647fedd = getentarray("movie_screen", "targetname");
    var_d647fedd[0] playsound("evt_screen_lower");
    array::run_all(var_d647fedd, &movez, -466, 6);
    wait(8);
    level clientfield::set("zm_theater_screen_in_place", 1);
    util::clientnotify("sip");
}

// Namespace namespace_39123edc
// Params 0, eflags: 0x1 linked
// namespace_39123edc<file_0>::function_fdb6bd42
// Checksum 0xc444409a, Offset: 0x8e8
// Size: 0x2c4
function function_fdb6bd42() {
    var_f2c5297f = getentarray("trigger_movie_reel_clean_bedroom", "targetname");
    var_4c1a7cbc = getentarray("trigger_movie_reel_bear_bedroom", "targetname");
    var_79d94e18 = getentarray("trigger_movie_reel_interrogation", "targetname");
    var_927f3b8f = getentarray("trigger_movie_reel_pentagon", "targetname");
    level.var_9f5178d6 = [];
    array::add(level.var_9f5178d6, var_f2c5297f, 0);
    array::add(level.var_9f5178d6, var_4c1a7cbc, 0);
    array::add(level.var_9f5178d6, var_79d94e18, 0);
    array::add(level.var_9f5178d6, var_927f3b8f, 0);
    level.var_9f5178d6 = array::randomize(level.var_9f5178d6);
    var_25aefcc0 = function_a746b881(level.var_9f5178d6[0], "ps1");
    var_4bb17729 = function_a746b881(level.var_9f5178d6[1], "ps2");
    var_71b3f192 = function_a746b881(level.var_9f5178d6[2], "ps3");
    var_5b5719c0 = arraycombine(var_f2c5297f, var_4c1a7cbc, 0, 0);
    var_81599429 = arraycombine(var_79d94e18, var_927f3b8f, 0, 0);
    var_a087998c = arraycombine(var_5b5719c0, var_81599429, 0, 0);
    array::thread_all(var_a087998c, &function_ae207a39);
    level thread function_6a294474();
}

// Namespace namespace_39123edc
// Params 2, eflags: 0x1 linked
// namespace_39123edc<file_0>::function_a746b881
// Checksum 0x155000c5, Offset: 0xbb8
// Size: 0xa0
function function_a746b881(var_e54b650d, var_fdf99429) {
    if (!isdefined(var_e54b650d)) {
        return;
    } else if (var_e54b650d.size <= 0) {
        return;
    } else if (!isdefined(var_fdf99429)) {
        return;
    }
    var_ccd39ad2 = array::randomize(var_e54b650d);
    var_ccd39ad2[0].script_string = var_fdf99429;
    var_ccd39ad2[0].var_835fe44e = 1;
    return var_ccd39ad2[0];
}

// Namespace namespace_39123edc
// Params 0, eflags: 0x1 linked
// namespace_39123edc<file_0>::function_ae207a39
// Checksum 0xec88ec94, Offset: 0xc60
// Size: 0x22c
function function_ae207a39() {
    if (!isdefined(self.target)) {
        assert(isdefined(self.target), "movie_screen");
        return;
    }
    self.var_8d6195c7 = getent(self.target, "targetname");
    if (!isdefined(self.var_835fe44e)) {
        self.var_835fe44e = 0;
    }
    if (self.var_835fe44e === 0) {
        self.var_8d6195c7 hide();
        self setcursorhint("HINT_NOICON");
        self sethintstring("");
        self triggerenable(0);
        return;
    } else if (isdefined(self.var_835fe44e) && self.var_835fe44e == 1) {
        self.var_8d6195c7 setmodel("p7_zm_kin_movie_reel_case_vintage_logo");
        self setcursorhint("HINT_NOICON");
    }
    level flag::wait_till("power_on");
    who = self waittill(#"trigger");
    who playsound("zmb_reel_pickup");
    self.var_8d6195c7 hide();
    self triggerenable(0);
    self thread function_63d5f7f2(who);
    who.var_3887989d = self.script_string;
    who thread function_11e8d57e();
}

// Namespace namespace_39123edc
// Params 1, eflags: 0x1 linked
// namespace_39123edc<file_0>::function_63d5f7f2
// Checksum 0x4ab87ed7, Offset: 0xe98
// Size: 0x74
function function_63d5f7f2(e_player) {
    level endon(#"end_game");
    e_player waittill(#"disconnect");
    self.var_8d6195c7 show();
    self triggerenable(1);
    self.var_835fe44e = 1;
    self thread function_ae207a39();
}

// Namespace namespace_39123edc
// Params 0, eflags: 0x1 linked
// namespace_39123edc<file_0>::function_6a294474
// Checksum 0xa1c7f78a, Offset: 0xf18
// Size: 0x240
function function_6a294474() {
    var_846b23bf = struct::get("struct_theater_screen", "targetname");
    var_d80866de = getent("trigger_change_projector_reels", "targetname");
    var_d80866de setcursorhint("HINT_NOICON");
    if (!isdefined(var_846b23bf.script_string)) {
        var_846b23bf.script_string = "ps0";
    }
    while (true) {
        who = var_d80866de waittill(#"trigger");
        if (isdefined(who.var_3887989d) && isstring(who.var_3887989d)) {
            switch (who.var_3887989d) {
            case 16:
                level clientfield::set("zm_theater_movie_reel_playing", 1);
                break;
            case 17:
                level clientfield::set("zm_theater_movie_reel_playing", 2);
                break;
            case 18:
                level clientfield::set("zm_theater_movie_reel_playing", 3);
                break;
            }
            who notify(#"hash_1937c9a0");
            who thread function_306059f8();
            var_d80866de thread namespace_6d4f3e39::function_4e682575(2);
            who playsound("zmb_reel_place");
            level notify(#"play_movie", who.var_3887989d);
            who.var_3887989d = undefined;
            wait(3);
        } else {
            wait(0.1);
        }
        wait(0.1);
    }
}

// Namespace namespace_39123edc
// Params 0, eflags: 0x1 linked
// namespace_39123edc<file_0>::function_11e8d57e
// Checksum 0x66f6031d, Offset: 0x1160
// Size: 0x3c
function function_11e8d57e() {
    self namespace_6e97c459::function_f72f765e(undefined, "movieReel");
    self thread function_9b4925f5();
}

// Namespace namespace_39123edc
// Params 0, eflags: 0x1 linked
// namespace_39123edc<file_0>::function_306059f8
// Checksum 0x587ab918, Offset: 0x11a8
// Size: 0x24
function function_306059f8() {
    self namespace_6e97c459::function_9f2411a3(undefined, "movieReel");
}

// Namespace namespace_39123edc
// Params 0, eflags: 0x1 linked
// namespace_39123edc<file_0>::function_9b4925f5
// Checksum 0x4bb5f8ba, Offset: 0x11d8
// Size: 0x4c
function function_9b4925f5() {
    self endon(#"hash_1937c9a0");
    self util::waittill_either("death", "_zombie_game_over");
    self thread function_306059f8();
}

