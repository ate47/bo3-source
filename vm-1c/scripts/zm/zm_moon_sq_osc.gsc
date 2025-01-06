#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_equip_hacker;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/zm_moon_amb;
#using scripts/zm/zm_moon_sq;

#namespace zm_moon_sq_osc;

// Namespace zm_moon_sq_osc
// Params 0, eflags: 0x0
// Checksum 0xa6fb10fe, Offset: 0x588
// Size: 0x55c
function init() {
    level.var_b2abb2a6 = [];
    level.var_d744a793 = struct::get_array("struct_osc_button", "targetname");
    if (!isdefined(level.var_d744a793)) {
        println("<dev string:x28>");
        wait 1;
        return;
    }
    level.var_297ff327 = struct::get("struct_sq_osc", "targetname");
    if (!isdefined(level.var_297ff327)) {
        println("<dev string:x4d>");
        wait 1;
        return;
    }
    level.var_e2b442ed = strtok(level.var_297ff327.script_flag, ",");
    if (!isdefined(level.var_e2b442ed)) {
        println("<dev string:x75>");
        wait 1;
        return;
    }
    for (j = 0; j < level.var_e2b442ed.size; j++) {
        if (!isdefined(level.flag[level.var_e2b442ed[j]])) {
            level flag::init(level.var_e2b442ed[j]);
        }
    }
    level.var_e4106635 = array(level.var_e2b442ed[4], level.var_e2b442ed[5], level.var_e2b442ed[6], level.var_e2b442ed[7]);
    level.var_3f13c601 = struct::get_array("struct_osc_st", "targetname");
    for (k = 0; k < level.var_3f13c601.size; k++) {
        level.var_3f13c601[k].focus = spawnstruct();
        level.var_3f13c601[k].focus.origin = level.var_3f13c601[k].origin;
        level.var_3f13c601[k].focus.radius = 48;
        level.var_3f13c601[k].focus.height = 48;
        level.var_3f13c601[k].focus.script_float = 5;
        level.var_3f13c601[k].focus.script_int = 0;
        level.var_3f13c601[k].focus.var_57a3d42b = struct::get(level.var_3f13c601[k].target, "targetname");
    }
    level thread function_f65c74fe();
    level.var_41340ed3 = level.var_297ff327.script_wait_min;
    level.var_ba7e78bd = level.var_297ff327.script_wait_max;
    level.var_433abe28 = level.var_ba7e78bd - level.var_41340ed3;
    level.var_1ff9ed33 = 0;
    level.var_360652cc = undefined;
    if (getdvarint("jolie_greet_debug")) {
        level.var_182729e4 = getdvarint("jolie_greet_time");
    } else {
        if (!isdefined(level.var_297ff327.script_int)) {
            println("<dev string:x98>");
            wait 1;
            return;
        }
        level.var_182729e4 = level.var_297ff327.script_int;
    }
    level.var_8ed491d3 = struct::get("struct_cover", "targetname");
    level.var_86124304 = util::spawn_model("p7_zm_moo_glyph_dial_cap", level.var_8ed491d3.origin, level.var_8ed491d3.angles);
    level.var_9c56830d = 0;
    level thread function_87d7e93f();
    namespace_6e97c459::function_5a90ed82("sq", "osc", &init_stage, &function_7747c56, &function_cc3f3f6a);
}

// Namespace zm_moon_sq_osc
// Params 0, eflags: 0x0
// Checksum 0x1eff8fc6, Offset: 0xaf0
// Size: 0xaa
function function_f65c74fe() {
    level flag::wait_till("start_zombie_round_logic");
    foreach (var_c597f9d8 in level.var_3f13c601) {
        var_c597f9d8 function_27fd2e20(0);
    }
}

// Namespace zm_moon_sq_osc
// Params 0, eflags: 0x0
// Checksum 0x85e5ae95, Offset: 0xba8
// Size: 0x3e8
function function_87d7e93f() {
    level flagsys::wait_till("load_main_complete");
    level flag::wait_till("start_zombie_round_logic");
    for (i = 0; i < level.var_d744a793.size; i++) {
        var_40993cc2 = struct::get(level.var_d744a793[i].target, "targetname");
        level.var_d744a793[i].cover = spawn("script_model", var_40993cc2.origin);
        level.var_d744a793[i].cover.angles = var_40993cc2.angles;
        level.var_d744a793[i].cover setmodel("p7_zm_moo_console_button_lid");
        level.var_d744a793[i].cover_close = level.var_d744a793[i].cover.angles;
        level.var_d744a793[i].cover rotateroll(-90, 0.05);
        level.var_d744a793[i].cover waittill(#"rotatedone");
        level.var_d744a793[i].cover_open = level.var_d744a793[i].cover.angles;
        level.var_d744a793[i].cover.angles = level.var_d744a793[i].cover_close;
        level.var_d744a793[i].var_8d4f612 = spawnstruct();
        level.var_d744a793[i].var_8d4f612.origin = level.var_d744a793[i].origin;
        level.var_d744a793[i].var_8d4f612.radius = 48;
        level.var_d744a793[i].var_8d4f612.height = 48;
        level.var_d744a793[i].var_8d4f612.script_float = 4;
        level.var_d744a793[i].var_8d4f612.script_int = 500;
        level.var_d744a793[i].var_8d4f612.var_9aa3be3b = 1;
        level.var_d744a793[i].var_8d4f612.var_39787651 = 1;
        array::add(level.var_b2abb2a6, level.var_d744a793[i].var_8d4f612, 0);
    }
    level.var_8448824b = level.var_d744a793[0].cover_close - level.var_d744a793[0].cover_open;
}

// Namespace zm_moon_sq_osc
// Params 1, eflags: 0x0
// Checksum 0xd09cb99a, Offset: 0xf98
// Size: 0xc
function function_cc3f3f6a(success) {
    
}

// Namespace zm_moon_sq_osc
// Params 0, eflags: 0x0
// Checksum 0xcf047c4e, Offset: 0xfb0
// Size: 0x34
function function_7747c56() {
    level waittill(#"hash_55c3e89a");
    namespace_6e97c459::function_2f3ced1f("sq", "osc");
}

// Namespace zm_moon_sq_osc
// Params 0, eflags: 0x0
// Checksum 0x18dd0668, Offset: 0xff0
// Size: 0x64
function init_stage() {
    level thread function_dfa37980();
    level thread function_5654bc55();
    level thread function_83bc978e();
    level thread function_bfada798();
}

// Namespace zm_moon_sq_osc
// Params 0, eflags: 0x0
// Checksum 0x9a8416bc, Offset: 0x1060
// Size: 0x276
function function_5654bc55() {
    level endon(#"end_game");
    level endon(level.var_e2b442ed[1]);
    level endon(#"hash_536b5d01");
    level.var_bb599e6 = 0;
    var_8c1032a1 = 0;
    var_71066a4b = struct::get("struct_rb_dist_check", "targetname");
    while (!level flag::get(level.var_e2b442ed[1])) {
        level.var_360652cc = zm_utility::get_closest_player(var_71066a4b.origin);
        var_9660d23e = distance2d(level.var_360652cc.origin, var_71066a4b.origin);
        if (var_9660d23e > level.var_ba7e78bd) {
            var_9660d23e = level.var_ba7e78bd;
        } else if (var_9660d23e < level.var_41340ed3) {
            var_9660d23e = level.var_41340ed3;
        }
        scale = (var_9660d23e - level.var_41340ed3) / level.var_433abe28;
        var_7d609087 = level.var_8448824b * scale;
        for (i = 0; i < level.var_d744a793.size; i++) {
            level.var_d744a793[i].cover.angles = level.var_d744a793[i].cover_close - var_7d609087;
            if (level.var_d744a793[i].cover.angles == level.var_d744a793[i].cover_close && level.var_bb599e6 == 0) {
                level.var_bb599e6 = 1;
                level.var_d744a793[i].cover thread function_fbfbe1d9();
            }
        }
        wait 0.05;
        level.var_360652cc = undefined;
    }
}

// Namespace zm_moon_sq_osc
// Params 0, eflags: 0x0
// Checksum 0x13c024c1, Offset: 0x12e0
// Size: 0xdc
function function_fbfbe1d9() {
    for (i = 0; i < level.var_d744a793.size; i++) {
        level.var_d744a793[i].cover playsound("evt_sq_rbs_close");
        level.var_d744a793[i].cover playsoundwithnotify("vox_mcomp_quest_step3_0", "sounddone");
    }
    level.var_d744a793[0].cover waittill(#"sounddone");
    level thread function_44122484(self);
    wait 30;
    level.var_bb599e6 = 0;
}

// Namespace zm_moon_sq_osc
// Params 1, eflags: 0x0
// Checksum 0xb9dc2eb4, Offset: 0x13c8
// Size: 0x7c
function function_44122484(ent) {
    level notify(#"hash_84bc65c9");
    level endon(#"hash_84bc65c9");
    wait 0.5;
    player = zm_utility::get_closest_player(ent.origin);
    player thread zm_audio::create_and_play_dialog("eggs", "quest3", 0);
}

// Namespace zm_moon_sq_osc
// Params 0, eflags: 0x0
// Checksum 0x7d75db8d, Offset: 0x1450
// Size: 0x580
function function_dfa37980() {
    if (!isdefined(level.var_b2abb2a6) || level.var_b2abb2a6.size == 0) {
        println("<dev string:xc7>");
        wait 1;
        return;
    }
    while (!level flag::get(level.var_e2b442ed[1])) {
        for (i = 0; i < level.var_b2abb2a6.size; i++) {
            zm_equip_hacker::function_66764564(level.var_b2abb2a6[i], &function_ed044adf);
        }
        if (!isdefined(level.var_e2b442ed[2]) || !isdefined(level.var_e2b442ed[3])) {
            println("<dev string:xe5>");
            wait 1;
            return;
        }
        level flag::wait_till_any(array(level.var_e2b442ed[2], level.var_e2b442ed[3]));
        if (level flag::get(level.var_e2b442ed[2])) {
            if (level flag::get(level.var_e2b442ed[2])) {
                level flag::clear(level.var_e2b442ed[2]);
            } else if (level flag::get(level.var_e2b442ed[3])) {
                level flag::clear(level.var_e2b442ed[3]);
            }
            for (j = 0; j < level.var_3f13c601.size; j++) {
                zm_equip_hacker::function_fcbe2f17(level.var_3f13c601[j].focus);
                if (isdefined(level.var_3f13c601[j].focus._light)) {
                    level.var_3f13c601[j].focus._light delete();
                }
                if (isdefined(level.var_3f13c601[j].focus.script_flag)) {
                    level flag::clear(level.var_3f13c601[j].focus.script_flag);
                    level.var_3f13c601[j].focus.script_flag = "";
                }
            }
            continue;
        }
        if (level flag::get(level.var_e2b442ed[3])) {
            level flag::set(level.var_e2b442ed[1]);
            level notify(#"hash_536b5d01");
            for (l = 0; l < level.var_d744a793.size; l++) {
                level.var_d744a793[l].cover.angles = level.var_d744a793[l].cover_open;
                level.var_d744a793[l].cover playsound("evt_sq_rbs_open");
            }
            for (m = 0; m < level.var_3f13c601.size; m++) {
                if (isdefined(level.var_3f13c601[m].focus._light)) {
                    level.var_3f13c601[m].focus._light delete();
                }
                level.var_3f13c601[m].focus.script_flag = "";
                zm_equip_hacker::function_fcbe2f17(level.var_3f13c601[m].focus);
            }
            if (level flag::get(level.var_e2b442ed[2])) {
                level flag::clear(level.var_e2b442ed[2]);
                continue;
            }
            if (level flag::get(level.var_e2b442ed[3])) {
                level flag::clear(level.var_e2b442ed[3]);
            }
        }
    }
}

// Namespace zm_moon_sq_osc
// Params 1, eflags: 0x0
// Checksum 0x4551edc7, Offset: 0x19d8
// Size: 0x2e4
function function_ed044adf(var_6bedfec1) {
    level thread function_c750bdcc(var_6bedfec1);
    level.var_bb599e6 = 1;
    for (i = 0; i < level.var_b2abb2a6.size; i++) {
        zm_equip_hacker::function_fcbe2f17(level.var_b2abb2a6[i]);
    }
    level.var_9c56830d = 0;
    var_1ee315ea = level.var_3f13c601;
    var_1ee315ea = array::randomize(var_1ee315ea);
    for (j = 0; j < 4; j++) {
        println("<dev string:x10d>");
        var_1ee315ea[j].focus._light = spawn("script_model", var_1ee315ea[j].focus.var_57a3d42b.origin);
        var_1ee315ea[j].focus._light.angles = var_1ee315ea[j].focus.var_57a3d42b.angles;
        var_1ee315ea[j].focus._light setmodel("tag_origin");
        var_1ee315ea[j] function_27fd2e20(1);
        var_1ee315ea[j].focus._light playsound("evt_sq_rbs_light_on");
        var_1ee315ea[j].focus._light playloopsound("evt_sq_rbs_light_loop", 1);
        zm_equip_hacker::function_66764564(var_1ee315ea[j].focus, &function_63e4f806);
    }
    level thread function_8d6a3bb2();
    level thread function_f81a004e();
    array::thread_all(var_1ee315ea, &function_185a3c3e);
}

// Namespace zm_moon_sq_osc
// Params 1, eflags: 0x0
// Checksum 0x8e4aa3e3, Offset: 0x1cc8
// Size: 0x64
function function_27fd2e20(var_ad826a0f) {
    var_a58a7b24 = "struct_sq_osc0" + self.script_int;
    if (var_ad826a0f) {
        exploder::exploder(var_a58a7b24);
        return;
    }
    exploder::kill_exploder(var_a58a7b24);
}

// Namespace zm_moon_sq_osc
// Params 1, eflags: 0x0
// Checksum 0x181d0f01, Offset: 0x1d38
// Size: 0xfc
function function_63e4f806(var_6bedfec1) {
    level.var_9c56830d++;
    self.var_57a3d42b function_27fd2e20(0);
    if (isdefined(self._light)) {
        self._light playsound("evt_sq_rbs_light_off");
        self._light delete();
    }
    if (level.var_9c56830d < 4) {
        var_6bedfec1 thread zm_audio::create_and_play_dialog("eggs", "quest3", randomintrange(10, 12));
    } else {
        self thread function_eb271a5d(var_6bedfec1);
    }
    zm_equip_hacker::function_fcbe2f17(self);
}

// Namespace zm_moon_sq_osc
// Params 0, eflags: 0x0
// Checksum 0x81f603de, Offset: 0x1e40
// Size: 0xa2
function function_8d6a3bb2() {
    level endon(#"hash_8b302f35");
    level endon(#"hash_432f17a");
    level endon(level.var_e2b442ed[1]);
    while (level.var_9c56830d < 4) {
        println("<dev string:x136>" + level.var_9c56830d);
        wait 0.1;
    }
    level flag::set(level.var_e2b442ed[3]);
    level notify(#"hash_432f17a");
}

// Namespace zm_moon_sq_osc
// Params 0, eflags: 0x0
// Checksum 0x49259061, Offset: 0x1ef0
// Size: 0xfe
function function_f81a004e() {
    level endon(#"hash_8b302f35");
    level endon(#"hash_432f17a");
    level endon(level.var_e2b442ed[1]);
    wait level.var_182729e4;
    level flag::set(level.var_e2b442ed[2]);
    level thread function_cf472e21();
    foreach (var_c597f9d8 in level.var_3f13c601) {
        var_c597f9d8 function_27fd2e20(0);
    }
    level notify(#"hash_8b302f35");
}

// Namespace zm_moon_sq_osc
// Params 0, eflags: 0x0
// Checksum 0x908e65cb, Offset: 0x1ff8
// Size: 0x174
function function_185a3c3e() {
    level endon(#"hash_8b302f35");
    level endon(#"hash_432f17a");
    level endon(level.var_e2b442ed[1]);
    for (i = level.var_182729e4; i > 0; i--) {
        var_843607b8 = self.focus._light;
        if (!isdefined(var_843607b8)) {
            return;
        }
        if (i == 50) {
            var_843607b8 playsound("vox_mcomp_quest_step3_2");
        }
        if (i == 40) {
            var_843607b8 playsound("vox_mcomp_quest_step3_3");
        }
        if (i == 30) {
            var_843607b8 playsound("vox_mcomp_quest_step3_4");
        }
        if (i == 20) {
            var_843607b8 playsound("vox_mcomp_quest_step3_5");
        }
        if (i == 10) {
            var_843607b8 playsound("vox_mcomp_quest_step3_6");
        }
        if (i == 5) {
            var_843607b8 playsound("vox_mcomp_quest_step3_7");
        }
        wait 1;
    }
}

// Namespace zm_moon_sq_osc
// Params 0, eflags: 0x0
// Checksum 0x106c3480, Offset: 0x2178
// Size: 0x2f8
function function_83bc978e() {
    var_1259e947 = [];
    level flag::wait_till(level.var_e2b442ed[1]);
    for (i = 0; i < level.var_d744a793.size; i++) {
        trig = spawn("trigger_radius_use", level.var_d744a793[i].origin, 0, 48, 32);
        trig.radius = 48;
        trig setcursorhint("HINT_NOICON");
        trig triggerignoreteam();
        trig.var_7b78ce7e = 0;
        trig thread function_e4824cea();
        array::add(var_1259e947, trig, 0);
        trig = undefined;
    }
    level thread function_388b30fb(var_1259e947.size);
    while (!level flag::get(level.var_e2b442ed[9])) {
        level flag::wait_till(level.var_e2b442ed[8]);
        if (!isdefined(level.var_297ff327.script_float)) {
            println("<dev string:x148>");
            wait 1;
            return;
        }
        if (getdvarint("osc_access_time") > 0) {
            wait getdvarint("osc_access_time");
        } else {
            wait level.var_297ff327.script_float;
        }
        if (!level flag::get(level.var_e2b442ed[9])) {
            level.var_1ff9ed33 = 0;
            for (k = 0; k < var_1259e947.size; k++) {
                var_1259e947[k].var_7b78ce7e = 0;
                if (isdefined(var_1259e947[k]._active)) {
                    var_1259e947[k]._active delete();
                }
            }
            level flag::clear(level.var_e2b442ed[8]);
        }
    }
}

// Namespace zm_moon_sq_osc
// Params 1, eflags: 0x0
// Checksum 0xeac17162, Offset: 0x2478
// Size: 0x174
function function_388b30fb(var_78dee2d9) {
    level endon(#"end_game");
    level flag::wait_till(level.var_e2b442ed[1]);
    while (!level flag::get(level.var_e2b442ed[9])) {
        if (level.var_1ff9ed33 == var_78dee2d9) {
            level flag::set(level.var_e2b442ed[9]);
            for (l = 0; l < level.var_d744a793.size; l++) {
                level.var_d744a793[l].cover.angles = level.var_d744a793[l].cover_close;
                level.var_d744a793[l].cover playsound("evt_sq_rbs_close");
                if (l == 0) {
                    level.var_d744a793[l].cover playsound("evt_sq_rbs_button_complete");
                }
            }
        }
        wait 0.1;
    }
}

// Namespace zm_moon_sq_osc
// Params 0, eflags: 0x0
// Checksum 0xfe3fadd4, Offset: 0x25f8
// Size: 0x164
function function_e4824cea() {
    level endon(#"end_game");
    level endon(level.var_e2b442ed[9]);
    while (!level flag::get(level.var_e2b442ed[9])) {
        self waittill(#"trigger", who);
        if (self.var_7b78ce7e) {
            wait 0.1;
            continue;
        }
        if (zombie_utility::is_player_valid(who)) {
            level flag::set(level.var_e2b442ed[8]);
            self playsound("evt_sq_rbs_button");
            self._active = spawn("script_model", self.origin);
            self._active setmodel("tag_origin");
            playfxontag(level._effect["osc_button_glow"], self._active, "tag_origin");
            self.var_7b78ce7e = 1;
            level.var_1ff9ed33++;
        }
    }
}

// Namespace zm_moon_sq_osc
// Params 0, eflags: 0x0
// Checksum 0x5339c601, Offset: 0x2768
// Size: 0x9c
function function_bfada798() {
    level flag::wait_till(level.var_e2b442ed[9]);
    level.var_86124304 movez(-8, 1);
    level.var_86124304 playsound("evt_sq_rbs_open");
    level.var_86124304 waittill(#"movedone");
    level flag::set(level.var_e2b442ed[10]);
}

/#

    // Namespace zm_moon_sq_osc
    // Params 2, eflags: 0x0
    // Checksum 0x82f34dcf, Offset: 0x2810
    // Size: 0x70
    function function_9049492b(msg, color) {
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        while (true) {
            print3d(self.origin, msg, color, 1, 2, 10);
            wait 1;
        }
    }

#/

// Namespace zm_moon_sq_osc
// Params 1, eflags: 0x0
// Checksum 0x95e49f47, Offset: 0x2888
// Size: 0xc4
function function_c750bdcc(who) {
    for (i = 0; i < level.var_d744a793.size; i++) {
        level.var_d744a793[i].cover playsoundwithnotify("vox_mcomp_quest_step3_1", "rbs_sounddone");
    }
    level.var_d744a793[0].cover waittill(#"rbs_sounddone");
    if (isdefined(who)) {
        who thread zm_audio::create_and_play_dialog("eggs", "quest3", 9);
    }
}

// Namespace zm_moon_sq_osc
// Params 1, eflags: 0x0
// Checksum 0x744c2917, Offset: 0x2958
// Size: 0xe4
function function_eb271a5d(who) {
    playsoundatposition("vox_mcomp_quest_step5_26", self.origin);
    for (i = 0; i < level.var_d744a793.size; i++) {
        level.var_d744a793[i].cover playsoundwithnotify("vox_mcomp_quest_step5_26", "rbs_sounddone");
    }
    level.var_d744a793[0].cover waittill(#"rbs_sounddone");
    if (isdefined(who)) {
        who thread zm_audio::create_and_play_dialog("eggs", "quest3", 12);
    }
}

// Namespace zm_moon_sq_osc
// Params 0, eflags: 0x0
// Checksum 0xfa9f007a, Offset: 0x2a48
// Size: 0x90
function function_cf472e21() {
    for (i = 0; i < level.var_d744a793.size; i++) {
        level.var_d744a793[i].cover playsoundwithnotify("vox_mcomp_quest_step5_8", "rbs_sounddone");
    }
    level.var_d744a793[0].cover waittill(#"rbs_sounddone");
    level.var_bb599e6 = 0;
}

