#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_powerups;
#using scripts/zm/zm_cosmodrome;
#using scripts/zm/zm_cosmodrome_amb;
#using scripts/zm/zm_cosmodrome_traps;

#namespace zm_cosmodrome_pack_a_punch;

// Namespace zm_cosmodrome_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xfbce430c, Offset: 0x5d8
// Size: 0x1ac
function function_11434d9() {
    level flag::init("lander_a_used");
    level flag::init("lander_b_used");
    level flag::init("lander_c_used");
    level flag::init("launch_activated");
    level flag::init("launch_complete");
    level.var_dae473ca = 0;
    level.var_35e4c5d2 = getent("rocket_room_bottom_door", "targetname");
    level.var_35e4c5d2.clip = getent(level.var_35e4c5d2.target, "targetname");
    level.var_35e4c5d2.clip linkto(level.var_35e4c5d2);
    var_62a180b9 = getent("trig_launch_rocket", "targetname");
    var_62a180b9 thread function_5879d337();
    level thread function_d1768dd1();
    level thread function_808b0397();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x8286dfc1, Offset: 0x790
// Size: 0x14c
function function_d1768dd1() {
    if (getdvarstring("rocket_test") != "") {
        level flag::set("lander_a_used");
        level flag::set("lander_b_used");
        level flag::set("lander_c_used");
    }
    level flag::wait_till("lander_a_used");
    level flag::wait_till("lander_b_used");
    level flag::wait_till("lander_c_used");
    level thread function_aa54d23a();
    wait 4;
    level flag::wait_till("launch_complete");
    function_46ff5b62("punch activate");
    level thread function_c680451d();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x8be524a0, Offset: 0x8e8
// Size: 0x5c
function function_aa54d23a() {
    wait 5.5;
    zm_cosmodrome_traps::function_3015c292();
    level thread zm_cosmodrome_traps::function_d1419acd();
    level zm_cosmodrome_traps::function_eee1cbd0();
    zm_cosmodrome_traps::function_b5bedb73();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x88860f33, Offset: 0x950
// Size: 0x4a
function function_808b0397() {
    level waittill(#"hash_7b168fce");
    exploder::exploder("fxexp_5601");
    level waittill(#"hash_7b168fce");
    wait 6;
    level notify(#"hash_526ede95");
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xda90f3c0, Offset: 0x9a8
// Size: 0x64
function function_da5288f1() {
    var_755108a1 = -228;
    level.var_35e4c5d2 movez(var_755108a1, 1.5);
    level.var_35e4c5d2 waittill(#"movedone");
    level.var_35e4c5d2 disconnectpaths();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x92244c3e, Offset: 0xa18
// Size: 0x1b4
function function_c680451d() {
    level flag::set("rocket_group");
    var_4cf008b0 = getent("rocket_room_top_door", "targetname");
    var_4cf008b0.clip = getent(var_4cf008b0.target, "targetname");
    var_4cf008b0.clip linkto(var_4cf008b0);
    var_4cf008b0 moveto(var_4cf008b0.origin + var_4cf008b0.script_vector, 1.5);
    level.var_35e4c5d2 moveto(level.var_35e4c5d2.origin + level.var_35e4c5d2.script_vector, 1.5);
    level.var_35e4c5d2.clip notsolid();
    var_4cf008b0 playsound("zmb_heavy_door_open");
    level.var_35e4c5d2.clip playsound("zmb_heavy_door_open");
    level.var_35e4c5d2 waittill(#"movedone");
    level.var_35e4c5d2.clip connectpaths();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 1, eflags: 0x0
// Checksum 0xb125d487, Offset: 0xbd8
// Size: 0x3c
function function_46ff5b62(str) {
    /#
        if (isdefined(level.var_dae473ca) && level.var_dae473ca) {
            iprintln(str);
        }
    #/
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x875e9c6e, Offset: 0xc20
// Size: 0x1c4
function function_5879d337() {
    panel = getent("rocket_launch_panel", "targetname");
    self usetriggerrequirelookat();
    self sethintstring(%ZOMBIE_NEED_POWER);
    self setcursorhint("HINT_NOICON");
    level waittill(#"pack_a_punch_on");
    self sethintstring(%ZM_COSMODROME_WAITING_AUTHORIZATION);
    level flag::wait_till("launch_activated");
    self sethintstring(%ZM_COSMODROME_LAUNCH_AVAILABLE);
    panel setmodel("p7_zm_asc_console_launch_key_full_green");
    /#
        self thread zm_cosmodrome::function_620401c0(self.origin, "<dev string:x28>", "<dev string:x3e>");
    #/
    self waittill(#"trigger", who);
    panel playsound("zmb_comp_activate");
    level thread zm_cosmodrome_amb::function_3cf7b8c9("vox_ann_launch_button");
    level thread function_fae804e8();
    self delete();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x16db88ca, Offset: 0xdf0
// Size: 0x174
function function_8010243c() {
    level endon(#"hash_3f1deee4");
    level.var_2d489c29 = getent("rocket_base_engine", "script_noteworthy");
    level.var_2d489c29 playloopsound("zmb_rocket_launch", 0.1);
    wait 2;
    level.var_4ba14d27 = spawn("script_origin", (0, 0, 0));
    level.var_d999ddec = spawn("script_origin", (0, 0, 0));
    level.var_4ba14d27 playloopsound("zmb_rocket_air_distf", 0.1);
    level.var_d999ddec playloopsound("zmb_rocket_air_distr", 0.1);
    wait 22;
    level.var_2d489c29 stoploopsound(1);
    wait 46;
    level.var_4ba14d27 stoploopsound(1);
    level.var_d999ddec stoploopsound(1);
    level thread function_aae7a344();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x6bb114d3, Offset: 0xf70
// Size: 0x5c
function function_aae7a344() {
    wait 5;
    if (isdefined(level.var_4ba14d27)) {
        level.var_4ba14d27 delete();
    }
    if (isdefined(level.var_d999ddec)) {
        level.var_d999ddec delete();
    }
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xce6b568e, Offset: 0xfd8
// Size: 0x1fc
function function_fae804e8() {
    level.var_36aa4be7 rotateyaw(60, 6);
    level.var_82af40b9 rotateyaw(-60, 6);
    level.var_82af40b9 playsound("zmb_rocket_disengage");
    level.var_82af40b9 playsound("zmb_rocket_start");
    wait 3;
    var_9b4cdcef = getent("rocket_base_engine", "script_noteworthy");
    level thread function_8010243c();
    zm_cosmodrome_traps::function_b16a68c0(level.claw_arm_l, "claw_l");
    zm_cosmodrome_traps::function_b16a68c0(level.claw_arm_r, "claw_r");
    wait 2;
    for (i = 5; i > 0; i--) {
        level thread zm_cosmodrome_amb::function_3cf7b8c9("vox_ann_launch_countdown_" + i, 1, 1);
        wait 1;
        if (i == 4) {
            level.claw_arm_r moveto(level.var_c234410e, 4);
            level.claw_arm_l moveto(level.var_eebefbf0, 4);
            exploder::exploder("fxexp_5602");
        }
    }
    function_c7ec6a1e();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xb4d5382c, Offset: 0x11e0
// Size: 0x2f4
function function_c7ec6a1e() {
    var_547ac401 = getentarray(level.rocket.target, "targetname");
    for (i = 0; i < var_547ac401.size; i++) {
        var_547ac401[i] linkto(level.rocket);
    }
    level endon(#"hash_3f1deee4");
    var_9b4cdcef = getent("rocket_base_engine", "script_noteworthy");
    exploder::stop_exploder("fxexp_5601");
    exploder::exploder("fxexp_5701");
    var_9b4cdcef clientfield::set("COSMO_ROCKET_FX", 1);
    level thread function_1187f9a0();
    wait 1;
    level thread zm_cosmodrome_amb::function_3cf7b8c9("vox_ann_engines_firing", 1);
    level.rocket setforcenocull();
    level.rocket moveto(level.rocket.origin + (0, 0, 50000), 50, 45);
    wait 5;
    zm_cosmodrome_traps::function_3b7290e2(level.claw_arm_l, "claw_l");
    zm_cosmodrome_traps::function_3b7290e2(level.claw_arm_r, "claw_r");
    level thread function_ae1ee1a6();
    wait 5;
    level flag::set("launch_complete");
    level thread zm_cosmodrome_amb::function_3cf7b8c9("vox_ann_after_launch");
    wait 20;
    level notify(#"stop_rumble");
    level.rocket waittill(#"movedone");
    var_547ac401 = getentarray(level.rocket.target, "targetname");
    for (i = 0; i < var_547ac401.size; i++) {
        var_547ac401[i] delete();
    }
    level.rocket delete();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x9b530cf2, Offset: 0x14e0
// Size: 0x1c4
function function_1187f9a0() {
    level endon(#"stop_rumble");
    level endon(#"hash_8ad7ea66");
    while (isdefined(level.rocket)) {
        players = getplayers();
        players_in_range = [];
        for (i = 0; i < players.size; i++) {
            if (distancesquared(players[i].origin, level.rocket.origin) < 30250000) {
                players_in_range[players_in_range.size] = players[i];
            }
        }
        if (players_in_range.size < 1) {
            wait 0.1;
            continue;
        }
        earthquake(randomfloatrange(0.15, 0.35), randomfloatrange(0.25, 0.5), level.rocket.origin, 5500);
        rumble = "slide_rumble";
        for (i = 0; i < players_in_range.size; i++) {
            players_in_range[i] playrumbleonentity(rumble);
        }
        wait 0.1;
    }
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x6a08b6c5, Offset: 0x16b0
// Size: 0x224
function function_ae1ee1a6() {
    level endon(#"stop_rumble");
    var_547ac401 = getentarray(level.rocket.target, "targetname");
    array::thread_all(var_547ac401, &function_d85238b3);
    level.rocket thread function_d85238b3();
    level waittill(#"hash_3f1deee4");
    playsoundatposition("zmb_rocket_destroyed", (0, 0, 0));
    level.rocket thread rocket_explode();
    level.rocket thread function_f748bf98();
    arrayremovevalue(var_547ac401, level.var_be9553f1);
    level.var_be9553f1 unlink();
    level.var_be9553f1 show();
    level.var_be9553f1 thread scene::play("p7_fxanim_zm_asc_rocket_explode_debris_bundle", level.var_be9553f1);
    var_8094093b = getent("rocket_base_engine", "script_noteworthy");
    var_8094093b clientfield::set("COSMO_ROCKET_FX", 0);
    for (i = 0; i < var_547ac401.size; i++) {
        var_547ac401[i] thread function_24d5fd7f();
    }
    wait 2;
    if (!level flag::get("launch_complete")) {
        level flag::set("launch_complete");
    }
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0x1480ab46, Offset: 0x18e0
// Size: 0x54
function function_24d5fd7f() {
    self unlink();
    self ghost();
    wait 5;
    self delete();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 1, eflags: 0x0
// Checksum 0xb11a85be, Offset: 0x1940
// Size: 0x25c
function function_f748bf98(num) {
    trace = bullettrace(self.origin, self.origin + (randomintrange(-100, 100), randomintrange(-100, 100), -20000), 0, self);
    ground_pos = trace["position"] + (0, 0, 1.5);
    self moveto(ground_pos, 3);
    self rotateto((randomintrange(-360, 360), randomintrange(-360, 360), randomintrange(-360, 360)), 3.9);
    wait 3.9;
    earthquake(randomfloatrange(0.25, 0.45), randomfloatrange(0.65, 0.75), self.origin, 5500);
    if (isdefined(num)) {
        if (num == 0) {
            self playsound("zmb_rocket_top_crash");
        } else if (num == 1) {
            self playsound("zmb_rocket_bottom_crash");
        }
    }
    if (self == level.rocket) {
        playfxontag(level._effect["rocket_exp_2"], self, "tag_origin");
    }
    wait 1;
    self hide();
    wait 10;
    self delete();
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xc50b2264, Offset: 0x1ba8
// Size: 0x16c
function function_d85238b3() {
    level endon(#"hash_af9831cd");
    self setcandamage(1);
    self waittill(#"damage", dmg_amount, attacker, dir, point, var_e5f012d6);
    if (var_e5f012d6 == "MOD_PROJECTILE" || var_e5f012d6 == "MOD_PROJECTILE_SPLASH" || var_e5f012d6 == "MOD_EXPLOSIVE" || var_e5f012d6 == "MOD_EXPLOSIVE_SPLASH" || var_e5f012d6 == "MOD_GRENADE" || isplayer(attacker) && var_e5f012d6 == "MOD_GRENADE_SPLASH") {
        level notify(#"hash_3f1deee4");
        level.var_2d489c29 stoploopsound(1);
        level.var_4ba14d27 stoploopsound(1);
        level.var_d999ddec stoploopsound(1);
        level thread function_aae7a344();
    }
}

// Namespace zm_cosmodrome_pack_a_punch
// Params 0, eflags: 0x0
// Checksum 0xb2f89a8c, Offset: 0x1d20
// Size: 0xac
function rocket_explode() {
    playfxontag(level._effect["rocket_exp_1"], self, "tag_origin");
    self playsound("zmb_rocket_stage_1_exp");
    wait 2;
    var_6d564cb6 = struct::get("pressure_pad", "targetname");
    zm_powerups::specific_powerup_drop("double_points", var_6d564cb6.origin);
}

