#using scripts/codescripts/struct;
#using scripts/cp/_load;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_cairo_ramses_fx;
#using scripts/cp/cp_mi_cairo_ramses_sound;
#using scripts/cp/cp_mi_cairo_ramses_station_walk;
#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/compass;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;

#namespace level_start;

// Namespace level_start
// Params 0, eflags: 0x0
// Checksum 0xedfaa306, Offset: 0x650
// Size: 0xb4
function main() {
    clientfield::set("hide_station_miscmodels", 1);
    clientfield::set("turn_on_rotating_fxanim_fans", 1);
    clientfield::set("start_fog_banks", 1);
    exploder::exploder("fx_exploder_sparks_off");
    level function_35e75862();
    level skipto::function_be8adfb8("level_start");
}

// Namespace level_start
// Params 1, eflags: 0x0
// Checksum 0xc5bbc2cf, Offset: 0x710
// Size: 0x64
function function_e29f0dd6(str_objective) {
    level.var_2fd26037 = util::function_740f8516("hendricks");
    level.var_7a9855f3 = util::function_740f8516("rachel");
    skipto::teleport_ai(str_objective);
}

// Namespace level_start
// Params 0, eflags: 0x0
// Checksum 0x1053f86d, Offset: 0x780
// Size: 0x3c
function function_e9d1564a() {
    self endon(#"death");
    self util::function_16c71b8(1);
    self thread function_51740d9d();
}

// Namespace level_start
// Params 0, eflags: 0x0
// Checksum 0x39443a4a, Offset: 0x7c8
// Size: 0x20c
function function_51740d9d() {
    self endon(#"disconnect");
    self endon(#"death");
    var_d30b00d2 = getent("trig_subway_area_mid", "targetname");
    while (!isdefined(level.var_2fd26037) || !isdefined(level.var_7a9855f3)) {
        wait 0.15;
    }
    var_28be2d2a = array(level.var_2fd26037);
    self thread ramses_util::function_24b86d60(var_28be2d2a, "kill_player_walkspeed_adjustment", -128, 256, 0.3, 0.8);
    do {
        wait 0.25;
    } while (!level.var_2fd26037 istouching(var_d30b00d2) && !self istouching(var_d30b00d2));
    self notify(#"kill_player_walkspeed_adjustment", 0);
    self thread ramses_util::function_24b86d60(var_28be2d2a, "kill_player_walkspeed_adjustment", -64, 512, 0.2, 0.6);
    do {
        wait 0.25;
    } while (!isdefined(level.var_9db406db) || !level flag::get("station_walk_past_stairs"));
    self notify(#"kill_player_walkspeed_adjustment", 0);
    var_28be2d2a = array(level.var_9db406db, level.var_2fd26037, level.var_7a9855f3);
    self thread ramses_util::function_24b86d60(var_28be2d2a, "kill_player_walkspeed_adjustment", -64, 512, 0.3, 0.8);
}

// Namespace level_start
// Params 0, eflags: 0x0
// Checksum 0x1cfdd3b0, Offset: 0x9e0
// Size: 0x4a
function function_8ae96a69() {
    self endon(#"death");
    self setmovespeedscale(1);
    self util::function_16c71b8(0);
    self notify(#"kill_player_walkspeed_adjustment");
}

// Namespace level_start
// Params 0, eflags: 0x0
// Checksum 0x5de001d8, Offset: 0xa38
// Size: 0x2b4
function function_35e75862() {
    level scene::init("cin_ram_01_01_enterstation_1st_ride");
    function_50fda83a();
    scene::add_scene_func("cin_ram_01_01_enterstation_1st_ride", &function_859915aa, "play");
    scene::add_scene_func("cin_ram_01_01_enterstation_1st_ride", &function_87629907, "play");
    scene::add_scene_func("cin_ram_01_01_enterstation_1st_ride", &ramses_util::function_3bc57aa8, "done");
    ramses_util::function_ac2b4535("cin_ram_01_01_enterstation_1st_ride", "enterstation_1st_ride_teleport");
    load::function_c32ba481();
    util::function_46d3a558(%CP_MI_CAIRO_RAMSES_INTRO_LINE_1_FULL, "", %CP_MI_CAIRO_RAMSES_INTRO_LINE_2_FULL, %CP_MI_CAIRO_RAMSES_INTRO_LINE_2_SHORT, %CP_MI_CAIRO_RAMSES_INTRO_LINE_3_FULL, %CP_MI_CAIRO_RAMSES_INTRO_LINE_3_SHORT, %CP_MI_CAIRO_RAMSES_INTRO_LINE_4_FULL, %CP_MI_CAIRO_RAMSES_INTRO_LINE_4_FULL);
    scene::add_scene_func("cin_ram_01_01_enterstation_vign_loading", &function_ba280036, "play");
    level thread util::delay(2, undefined, &scene::play, "cin_ram_01_01_enterstation_vign_loading");
    if (isdefined(level.var_af94f480)) {
        level thread [[ level.var_af94f480 ]]();
    }
    foreach (player in level.players) {
        player thread function_b7bac40f();
        player thread function_679d413a();
    }
    level thread namespace_e4c0c552::function_4f8bda39();
    level scene::play("cin_ram_01_01_enterstation_1st_ride");
    level clientfield::set("gameplay_started", 1);
}

// Namespace level_start
// Params 0, eflags: 0x0
// Checksum 0xea762ab5, Offset: 0xcf8
// Size: 0x3c
function function_1f8e97be() {
    level util::screen_fade_out(0);
    wait 1;
    level thread util::screen_fade_in(1);
}

// Namespace level_start
// Params 0, eflags: 0x0
// Checksum 0xf34634d3, Offset: 0xd40
// Size: 0x8c
function function_50fda83a() {
    var_f7ae14aa = getent("traincar_primary", "targetname");
    var_f7ae14aa.script_objective = "interview_dr_nasser";
    var_f7ae14aa link_ents("lgt_subway_car", "script_noteworthy");
    var_f7ae14aa link_ents("traincar_primary_cab");
}

// Namespace level_start
// Params 1, eflags: 0x0
// Checksum 0xbbf4445e, Offset: 0xdd8
// Size: 0x42
function function_859915aa(a_ents) {
    var_f7ae14aa = a_ents["traincar_primary"];
    var_f7ae14aa waittill(#"stopped");
    level notify(#"hash_30462a58");
}

// Namespace level_start
// Params 1, eflags: 0x0
// Checksum 0x857ef657, Offset: 0xe28
// Size: 0x54
function function_87629907(a_ents) {
    level waittill(#"hash_d73ff968");
    level.var_2fd26037 setdedicatedshadow(0);
    streamerrequest("clear", "cin_ram_01_01_enterstation_1st_ride");
}

// Namespace level_start
// Params 1, eflags: 0x0
// Checksum 0xa609a21f, Offset: 0xe88
// Size: 0x2c
function function_80df7cd(var_fcd89369) {
    var_fcd89369 clientfield::set("attach_cam_to_train", 1);
}

// Namespace level_start
// Params 0, eflags: 0x0
// Checksum 0x264b2f8b, Offset: 0xec0
// Size: 0x48
function function_b7bac40f() {
    self endon(#"disconnect");
    level endon(#"hash_88bd4b7");
    while (true) {
        self playrumbleonentity("tank_rumble");
        wait 1;
    }
}

// Namespace level_start
// Params 0, eflags: 0x0
// Checksum 0x2e7aa1a8, Offset: 0xf10
// Size: 0x3c
function function_679d413a() {
    self endon(#"disconnect");
    level waittill(#"hash_5ba360b8");
    self playrumbleonentity("tank_fire");
}

// Namespace level_start
// Params 1, eflags: 0x0
// Checksum 0x534c07b6, Offset: 0xf58
// Size: 0xfa
function function_ba280036(a_ents) {
    level waittill(#"hash_c466417");
    var_9224b839 = getentarray("elevator_door", "targetname");
    foreach (e_piece in var_9224b839) {
        e_piece movez(-108, 1.5);
        e_piece playsound("evt_postint_door_open");
    }
}

// Namespace level_start
// Params 0, eflags: 0x0
// Checksum 0xed6f33d2, Offset: 0x1060
// Size: 0x92
function function_6c8b50b0() {
    foreach (e_player in level.players) {
        e_player clientfield::set_to_player("intro_reflection_extracam", 1);
    }
}

// Namespace level_start
// Params 0, eflags: 0x0
// Checksum 0xbd71d8c7, Offset: 0x1100
// Size: 0x92
function function_d4fa36aa() {
    foreach (e_player in level.players) {
        e_player clientfield::set_to_player("intro_reflection_extracam", 0);
    }
}

// Namespace level_start
// Params 2, eflags: 0x0
// Checksum 0x73c21ea9, Offset: 0x11a0
// Size: 0xee
function link_ents(str_name, str_key) {
    if (!isdefined(str_key)) {
        str_key = "targetname";
    }
    a_e_ents = getentarray(str_name, str_key);
    foreach (e_ent in a_e_ents) {
        e_ent linkto(self);
        e_ent.script_objective = "interview_dr_nasser";
    }
}

// Namespace level_start
// Params 0, eflags: 0x0
// Checksum 0x742e52be, Offset: 0x1298
// Size: 0xe2
function function_ef108c0a() {
    foreach (e_player in level.players) {
        e_player setorigin(self.var_b3cfd3f2.origin);
        e_player setplayerangles(self.angles);
        e_player playerlinkto(self.var_b3cfd3f2, undefined, 0, 0, 0, 0, 0);
    }
}

