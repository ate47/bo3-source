#using scripts/zm/zm_castle_zombie;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_timer;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_util;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_8e89abe3;

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x2
// Checksum 0x77231b43, Offset: 0xba0
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_castle_low_grav", &__init__, &__main__, undefined);
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x59a673a3, Offset: 0xbe8
// Size: 0x16e
function __init__() {
    clientfield::register("scriptmover", "low_grav_powerup_triggered", 5000, 1, "counter");
    clientfield::register("toplayer", "player_screen_fx", 5000, 1, "int");
    clientfield::register("toplayer", "player_postfx", 5000, 1, "int");
    clientfield::register("scriptmover", "undercroft_emissives", 5000, 1, "int");
    clientfield::register("scriptmover", "undercroft_wall_panel_shutdown", 5000, 1, "counter");
    clientfield::register("scriptmover", "zombie_wall_dust", 5000, 1, "counter");
    clientfield::register("scriptmover", "floor_panel_emissives_glow", 5000, 1, "int");
    level._effect["low_grav_player_jump"] = "dlc1/castle/fx_plyr_115_liquid_trail";
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x926fe976, Offset: 0xd60
// Size: 0x1d4
function __main__() {
    level flag::init("low_grav_countdown");
    level flag::init("low_grav_on");
    level.var_a75d7260 = getent("trig_low_gravity_zone", "targetname");
    level.func_override_wallbuy_prompt = &function_efa3deb8;
    /#
        level thread function_ab786717();
    #/
    level flag::wait_till("start_zombie_round_logic");
    level flag::init("pressure_pads_activated");
    level flag::init("undercroft_powerup_available");
    level flag::init("grav_off_for_ee");
    var_4603701d = getentarray("undercroft_floater_scene", "targetname");
    level thread function_8b18e3ce();
    level function_3fa7f11a();
    level thread function_554db684();
    level thread function_644bd455();
    level thread function_2cb9125b();
    level thread function_8a1f0208();
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x3a9f449d, Offset: 0xf40
// Size: 0x244
function function_3fa7f11a() {
    level endon(#"hash_854ff4f5");
    var_15ed352b = getentarray("grav_pad_trigger", "targetname");
    level.var_d19d5236 = 0;
    level.var_cddeb078 = [];
    foreach (var_3b9a12e0 in var_15ed352b) {
        var_3b9a12e0 thread function_e49e9c09();
        var_8ecbce0a = getent(var_3b9a12e0.target, "targetname");
        var_4f15c74f = getent(var_8ecbce0a.target, "targetname");
        array::add(level.var_cddeb078, var_4f15c74f);
    }
    while (level.var_d19d5236 < var_15ed352b.size) {
        wait(0.05);
    }
    foreach (var_3b9a12e0 in var_15ed352b) {
        var_544a882 = getent(var_3b9a12e0.target, "targetname");
    }
    level thread function_ed0d48ca();
    level flag::set("pressure_pads_activated");
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x5ea78b1b, Offset: 0x1190
// Size: 0x6c
function function_ed0d48ca() {
    wait(5);
    exploder::exploder_stop("lgt_grav_pad_n");
    exploder::exploder_stop("lgt_grav_pad_s");
    exploder::exploder_stop("lgt_grav_pad_e");
    exploder::exploder_stop("lgt_grav_pad_w");
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x51b22, Offset: 0x1208
// Size: 0x2f8
function function_e49e9c09() {
    var_8ecbce0a = getent(self.target, "targetname");
    var_8ecbce0a enablelinkto();
    var_4f15c74f = getent(var_8ecbce0a.target, "targetname");
    var_4f15c74f enablelinkto();
    var_4f15c74f linkto(var_8ecbce0a);
    var_2e8e2853 = var_8ecbce0a.origin - (0, 0, 2);
    var_93f2a402 = var_8ecbce0a.origin;
    while (true) {
        e_who = self waittill(#"trigger");
        var_8ecbce0a moveto(var_2e8e2853, 0.5);
        playsoundatposition("evt_stone_plate_down", var_8ecbce0a.origin);
        var_8ecbce0a waittill(#"movedone");
        var_4f15c74f clientfield::set("undercroft_emissives", 1);
        n_start_time = gettime();
        n_end_time = n_start_time + 3000;
        while (e_who istouching(self)) {
            n_time = gettime();
            if (n_time >= n_end_time) {
                level.var_d19d5236++;
                exploder::exploder("lgt_" + self.script_string);
                playsoundatposition("evt_stone_plate_up", var_8ecbce0a.origin);
                e_who playrumbleonentity("zm_castle_low_grav_panel_rumble");
                return;
            }
            wait(0.05);
        }
        var_8ecbce0a moveto(var_93f2a402, 0.5);
        playsoundatposition("evt_stone_plate_down", var_8ecbce0a.origin);
        var_4f15c74f clientfield::set("undercroft_emissives", 0);
        var_4f15c74f clientfield::increment("undercroft_wall_panel_shutdown");
    }
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0xa78bcf0b, Offset: 0x1508
// Size: 0x11c
function function_554db684() {
    setdvar("wallrun_enabled", 1);
    setdvar("doublejump_enabled", 1);
    setdvar("playerEnergy_enabled", 1);
    setdvar("bg_lowGravity", 300);
    setdvar("wallRun_maxTimeMs_zm", 10000);
    setdvar("playerEnergy_maxReserve_zm", -56);
    setdvar("wallRun_peakTest_zm", 0);
    level.var_a75d7260 = getent("trig_low_gravity_zone", "targetname");
    level thread function_fceff7eb();
}

// Namespace namespace_8e89abe3
// Params 1, eflags: 0x1 linked
// Checksum 0x3a60ba2, Offset: 0x1630
// Size: 0x1ae
function function_fceff7eb(n_duration) {
    if (!isdefined(n_duration)) {
        n_duration = 50;
    }
    /#
        level endon(#"hash_9c3be857");
    #/
    level thread function_767bba0();
    while (true) {
        level flag::set("low_grav_on");
        level thread function_2f712e07();
        exploder::exploder("lgt_low_gravity_on");
        if (!(isdefined(level.var_513683a6) && level.var_513683a6)) {
            exploder::exploder("fxexp_117");
        }
        level clientfield::set("snd_low_gravity_state", 1);
        level clientfield::set("sndUEB", 1);
        wait(n_duration - 10);
        level function_e1998cb5();
        level flag::clear("low_grav_on");
        exploder::stop_exploder("lgt_low_gravity_on");
        level clientfield::set("snd_low_gravity_state", 0);
        level flag::wait_till_clear("grav_off_for_ee");
        wait(60);
    }
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x2fee2f8e, Offset: 0x17e8
// Size: 0x10c
function function_e1998cb5() {
    level clientfield::set("snd_low_gravity_state", 2);
    level flag::set("low_grav_countdown");
    exploder::exploder("lgt_low_gravity_flash");
    wait(7);
    exploder::stop_exploder("lgt_low_gravity_flash");
    exploder::stop_exploder("fxexp_117");
    exploder::exploder("lgt_low_gravity_flash_fast");
    level clientfield::set("sndUEB", 0);
    wait(3);
    exploder::stop_exploder("lgt_low_gravity_flash_fast");
    level flag::clear("low_grav_countdown");
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x9af2f114, Offset: 0x1900
// Size: 0x10c
function function_3ccd9604() {
    self endon(#"death");
    while (true) {
        if (self istouching(level.var_a75d7260) && level flag::get("low_grav_on") && self.low_gravity == 0) {
            self namespace_e9d5a0ce::set_gravity("low");
            self.low_gravity = 1;
        } else if (!self istouching(level.var_a75d7260) || !level flag::get("low_grav_on")) {
            self namespace_e9d5a0ce::set_gravity("normal");
            self.low_gravity = 0;
        }
        wait(0.5);
    }
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x85feb71a, Offset: 0x1a18
// Size: 0x124
function function_f4766f6() {
    self endon(#"death");
    while (true) {
        if (self istouching(level.var_a75d7260) && level flag::get("low_grav_on") && !(isdefined(self.low_gravity) && self.low_gravity)) {
            self ai::set_behavior_attribute("gravity", "low");
            self.low_gravity = 1;
        } else if (!self istouching(level.var_a75d7260) || !level flag::get("low_grav_on")) {
            self ai::set_behavior_attribute("gravity", "normal");
            self.low_gravity = 0;
        }
        wait(0.5);
    }
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x25e3c7d6, Offset: 0x1b48
// Size: 0x2b4
function function_c3f6aa22() {
    self endon(#"death");
    self endon(#"disconnect");
    level flag::wait_till("low_grav_on");
    self.var_7dd18a0 = 0;
    while (true) {
        while (self istouching(level.var_a75d7260)) {
            while (level flag::get("low_grav_on") && self istouching(level.var_a75d7260)) {
                if (self.var_7dd18a0 == 0) {
                    self allowwallrun(1);
                    self allowdoublejump(1);
                    self setperk("specialty_lowgravity");
                    self.var_7dd18a0 = 1;
                    self clientfield::set_to_player("player_screen_fx", 1);
                    self thread function_573a448e();
                    self clientfield::set_to_player("player_postfx", 1);
                    self thread function_e997f73a();
                    /#
                        if (getdvarint("undercroft_emissives") > 0) {
                            setdvar("undercroft_emissives", getdvarint("undercroft_emissives"));
                        }
                    #/
                }
                wait(0.1);
            }
            if (self.var_7dd18a0 == 1) {
                self allowdoublejump(0);
                self allowwallrun(0);
                self unsetperk("specialty_lowgravity");
                self clientfield::set_to_player("player_screen_fx", 0);
                self clientfield::set_to_player("player_postfx", 0);
                self notify(#"hash_eb16fe00");
                self.var_7dd18a0 = 0;
            }
            wait(0.1);
        }
        wait(0.1);
    }
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x4d40add7, Offset: 0x1e08
// Size: 0x80
function function_e997f73a() {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"hash_eb16fe00");
    while (true) {
        if (self isonground() || self iswallrunning()) {
            self setdoublejumpenergy(-56);
        }
        wait(0.05);
    }
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x4affb723, Offset: 0x1e90
// Size: 0x170
function function_573a448e() {
    self endon(#"death");
    self endon(#"disconnect");
    while (self.var_7dd18a0 == 1) {
        self waittill(#"jump_begin");
        var_5ed20759 = spawn("script_model", self.origin);
        var_5ed20759 setmodel("tag_origin");
        var_5ed20759 enablelinkto();
        var_5ed20759 linkto(self, "j_spineupper");
        playfxontag(level._effect["low_grav_player_jump"], var_5ed20759, "tag_origin");
        while ((!self isonground() || self iswallrunning()) && level flag::get("low_grav_on")) {
            wait(0.5);
        }
        var_5ed20759 delete();
        wait(0.5);
    }
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x3e802c8c, Offset: 0x2008
// Size: 0x480
function function_767bba0() {
    /#
        level endon(#"hash_9c3be857");
    #/
    var_470f053a = struct::get_array("wall_buy_trigger", "targetname");
    var_6ad23999 = getentarray("lowgrav_glow", "targetname");
    var_8ff7104f = getentarray("pyramid", "targetname");
    var_6ad23999 = arraycombine(var_8ff7104f, var_6ad23999, 0, 0);
    while (true) {
        level flag::wait_till("low_grav_on");
        var_89ba571 = [];
        foreach (var_7b3fce7b in var_470f053a) {
            if (!(isdefined(var_7b3fce7b.activated) && var_7b3fce7b.activated)) {
                var_b8ac84e8 = getent(var_7b3fce7b.target, "targetname");
                array::add(var_89ba571, var_b8ac84e8);
            }
        }
        if (level flag::get("undercroft_powerup_available")) {
            array::add(var_89ba571, level.var_6f0e5d4c);
        }
        array::thread_all(var_89ba571, &clientfield::set, "undercroft_emissives", 1);
        array::thread_all(var_6ad23999, &clientfield::set, "undercroft_emissives", 1);
        array::thread_all(level.var_cddeb078, &clientfield::set, "floor_panel_emissives_glow", 1);
        level flag::wait_till("low_grav_countdown");
        wait(10);
        var_89ba571 = [];
        foreach (var_7b3fce7b in var_470f053a) {
            if (!(isdefined(var_7b3fce7b.activated) && var_7b3fce7b.activated)) {
                var_b8ac84e8 = getent(var_7b3fce7b.target, "targetname");
                array::add(var_89ba571, var_b8ac84e8);
            }
        }
        if (level flag::get("undercroft_powerup_available")) {
            array::add(var_89ba571, level.var_6f0e5d4c);
        }
        array::thread_all(var_6ad23999, &clientfield::set, "undercroft_emissives", 0);
        array::thread_all(var_89ba571, &clientfield::set, "undercroft_emissives", 0);
        array::thread_all(level.var_cddeb078, &clientfield::set, "floor_panel_emissives_glow", 0);
        level flag::wait_till_clear("low_grav_on");
    }
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x4d70bbe8, Offset: 0x2490
// Size: 0x202
function function_2f712e07() {
    var_4603701d = getentarray("undercroft_floater_model", "targetname");
    if (getdvarint("splitscreen_playerCount") > 2) {
        array::run_all(var_4603701d, &delete);
        return;
    }
    array::thread_all(var_4603701d, &function_5f2da053);
    level flag::wait_till("low_grav_countdown");
    var_3bebe64c = var_4603701d.size;
    var_d1d3b1 = 5;
    var_29be1256 = 5;
    var_2916f722 = int(var_3bebe64c / var_29be1256);
    var_398a5cc1 = var_d1d3b1 / var_29be1256;
    var_4603701d = array::randomize(var_4603701d);
    while (var_4603701d.size > 0) {
        for (i = 0; i < var_2916f722; i++) {
            var_4603701d[i] notify(#"hash_2f498788");
            var_4603701d = array::remove_index(var_4603701d, i);
            if (var_4603701d.size <= 1) {
                break;
            }
            var_ffb35e3f = randomfloatrange(0, 0.5);
            wait(var_ffb35e3f);
        }
        wait(var_398a5cc1);
    }
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0xc0d5b972, Offset: 0x26a0
// Size: 0x16c
function function_5f2da053() {
    wait(randomfloatrange(0, 1));
    switch (self.model) {
    case 63:
        str_scene_name = "p7_fxanim_zm_castle_undercroft_floaters_books_bundle";
        break;
    case 64:
        str_scene_name = "p7_fxanim_zm_castle_undercroft_floaters_candles_bundle";
        break;
    case 65:
        str_scene_name = "p7_fxanim_zm_castle_undercroft_floaters_rocks_bundle";
        break;
    case 66:
        str_scene_name = "p7_fxanim_zm_castle_undercroft_floaters_skull_bundle";
        break;
    case 67:
        str_scene_name = "p7_fxanim_zm_castle_undercroft_floaters_toolbox_bundle";
        break;
    case 68:
        str_scene_name = "p7_fxanim_zm_castle_undercroft_floaters_urn_bundle";
        break;
    }
    self playloopsound("zmb_low_grav_item_loop");
    self scene::play(str_scene_name + "_up", self);
    self thread scene::play(str_scene_name + "_idle", self);
    self waittill(#"hash_2f498788");
    self thread scene::play(str_scene_name + "_down", self);
    self stoploopsound();
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x157637a5, Offset: 0x2818
// Size: 0x304
function function_8b18e3ce() {
    level endon(#"hash_6580ea04");
    function_7f2caa5(2, "pistol_burst");
    if (level.round_number != 2) {
        return;
    }
    function_7f2caa5(4, "ar_marksman");
    function_7f2caa5(5, "pistol_burst");
    e_floater = getent("zm_fam", "targetname");
    if (!isdefined(e_floater)) {
        return;
    }
    var_feb1d46b = struct::get("s_zm_fam_loc", "targetname");
    if (!isdefined(var_feb1d46b)) {
        return;
    }
    e_floor = getent("zm_fam_floor", "targetname");
    if (!isdefined(e_floor)) {
        return;
    }
    level thread function_f67d5866();
    level.players[0] util::waittill_player_looking_at(var_feb1d46b.origin + (0, 0, 50), 90);
    level notify(#"hash_d64d78d6");
    e_floater.origin = var_feb1d46b.origin + (0, 0, 64);
    e_floor.origin = var_feb1d46b.origin;
    e_floor enablelinkto();
    var_5ed20759 = spawn("script_model", var_feb1d46b.origin);
    var_5ed20759 setmodel("p7_zm_zod_stage_heart_frame");
    e_floor linkto(var_5ed20759);
    for (i = 0; i < 500; i++) {
        var_5ed20759 rotateto(var_5ed20759.angles + (0, 180, 0), 3);
        var_5ed20759 waittill(#"rotatedone");
    }
    e_floater delete();
    var_5ed20759 delete();
    e_floor delete();
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0xf34f77c4, Offset: 0x2b28
// Size: 0x22
function function_f67d5866() {
    level endon(#"hash_d64d78d6");
    wait(5);
    level notify(#"hash_6580ea04");
}

// Namespace namespace_8e89abe3
// Params 2, eflags: 0x1 linked
// Checksum 0x9ac0e36f, Offset: 0x2b58
// Size: 0x19a
function function_7f2caa5(n_num, var_42133686) {
    player, weapon = level waittill(#"weapon_bought");
    if (weapon.name != var_42133686) {
        level notify(#"hash_6580ea04");
        return;
    }
    foreach (barrier in level.exterior_goals) {
        if (issubstr(barrier.script_string, "start_set")) {
            var_c5f3d26a = 0;
            for (x = 0; x < barrier.zbarrier getnumzbarrierpieces(); x++) {
                if (barrier.zbarrier getzbarrierpiecestate(x) == "closed") {
                    var_c5f3d26a++;
                }
            }
            if (var_c5f3d26a != n_num) {
                level notify(#"hash_6580ea04");
                return;
            }
        }
    }
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0xd9c13d75, Offset: 0x2d00
// Size: 0x54
function function_644bd455() {
    a_traps = struct::get_array("low_grav_trap", "targetname");
    array::thread_all(a_traps, &function_d09bda12);
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x8fd43386, Offset: 0x2d60
// Size: 0x220
function function_d09bda12() {
    t_trap = getent(self.script_noteworthy, "targetname");
    self.var_cafd3848 = 1;
    var_c5728235 = getent(self.script_string, "targetname");
    var_6b2a60d = getent(self.target, "targetname");
    var_c5728235 enablelinkto();
    var_c5728235 linkto(var_6b2a60d);
    var_c5728235 thread trigger_damage();
    while (true) {
        e_player = t_trap waittill(#"trigger");
        n_distance = distance2d(e_player.origin, self.origin);
        if (e_player.var_b94b5f2f == 1 && self.var_cafd3848 == 1 && n_distance > 500 && n_distance < 1000 && e_player iswallrunning() && !level.dog_intermission) {
            e_player thread function_d04113df(3);
            n_rand = randomfloatrange(0, 1);
            if (n_rand < 0.33) {
                self thread function_30b0d4ab(8);
                self thread function_e7a4bc31(e_player);
            }
        }
    }
}

// Namespace namespace_8e89abe3
// Params 1, eflags: 0x1 linked
// Checksum 0xcf7b07e8, Offset: 0x2f88
// Size: 0x40c
function function_e7a4bc31(e_player) {
    var_6b2a60d = getent(self.target, "targetname");
    var_6b2a60d.var_d2f6fb2e = var_6b2a60d.origin;
    var_477663ed = anglestoforward(self.origin) * 25 + self.origin;
    var_6b2a60d moveto(var_477663ed, 1);
    var_286c5204 = struct::get(var_6b2a60d.target, "targetname");
    var_bb7b50d = zombie_utility::spawn_zombie(level.zombie_spawners[0], "wall_trap_zombie", var_286c5204, 1);
    var_bb7b50d.health = 5;
    var_bb7b50d thread function_f7d8fe24(var_6b2a60d);
    var_5ed20759 = spawn("script_model", var_286c5204.origin);
    var_5ed20759 setmodel("tag_origin");
    var_5ed20759.angles = var_286c5204.angles;
    util::wait_network_frame();
    var_5ed20759 clientfield::increment("zombie_wall_dust");
    if (self.script_int == 1) {
        var_5ed20759 playsound("zmb_zombie_wall_spawn");
        var_5ed20759 scene::play("cin_zm_castle_wall_zombie_right_intro", var_bb7b50d);
        var_5ed20759 scene::play("cin_zm_castle_wall_zombie_right_main", var_bb7b50d);
        var_6b2a60d moveto(var_6b2a60d.var_d2f6fb2e, 1);
        if (isalive(var_bb7b50d)) {
            var_5ed20759 scene::play("cin_zm_castle_wall_zombie_right_outro", var_bb7b50d);
            var_bb7b50d notify(#"hash_6815f745");
            var_bb7b50d delete();
            var_6b2a60d.origin = var_6b2a60d.var_d2f6fb2e;
        }
        return;
    }
    var_5ed20759 playsound("zmb_zombie_wall_spawn");
    var_5ed20759 scene::play("cin_zm_castle_wall_zombie_left_intro", var_bb7b50d);
    var_5ed20759 scene::play("cin_zm_castle_wall_zombie_left_main", var_bb7b50d);
    var_6b2a60d moveto(var_6b2a60d.var_d2f6fb2e, 1);
    if (isalive(var_bb7b50d)) {
        var_5ed20759 scene::play("cin_zm_castle_wall_zombie_left_outro", var_bb7b50d);
        var_bb7b50d notify(#"hash_6815f745");
        var_bb7b50d delete();
        var_6b2a60d.origin = var_6b2a60d.var_d2f6fb2e;
    }
    var_5ed20759 delete();
}

// Namespace namespace_8e89abe3
// Params 1, eflags: 0x1 linked
// Checksum 0x716b7bfd, Offset: 0x33a0
// Size: 0x5c
function function_d04113df(n_wait_time) {
    self notify(#"new_timer");
    self endon(#"new_timer");
    self endon(#"death");
    self endon(#"disconnect");
    self.var_b94b5f2f = 0;
    wait(n_wait_time);
    self.var_b94b5f2f = 1;
}

// Namespace namespace_8e89abe3
// Params 1, eflags: 0x1 linked
// Checksum 0x19149da5, Offset: 0x3408
// Size: 0x44
function function_30b0d4ab(n_wait_time) {
    self notify(#"new_timer");
    self endon(#"new_timer");
    self.var_cafd3848 = 0;
    wait(n_wait_time);
    self.var_cafd3848 = 1;
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x23a93e23, Offset: 0x3458
// Size: 0xd0
function trigger_damage() {
    while (true) {
        e_who = self waittill(#"trigger");
        if (isplayer(e_who) && !(isdefined(e_who.var_c54a399c) && e_who.var_c54a399c)) {
            e_who dodamage(25, e_who.origin, undefined, undefined, "none", "MOD_MELEE");
            e_who.var_c54a399c = 1;
            e_who thread function_266e5562();
        }
        wait(0.05);
    }
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0xde5884a7, Offset: 0x3530
// Size: 0x30
function function_266e5562() {
    self endon(#"death");
    self endon(#"disconnect");
    wait(0.5);
    self.var_c54a399c = 0;
}

// Namespace namespace_8e89abe3
// Params 1, eflags: 0x1 linked
// Checksum 0x6261afba, Offset: 0x3568
// Size: 0x6c
function function_f7d8fe24(var_6b2a60d) {
    self endon(#"hash_6815f745");
    self.no_powerups = 1;
    self waittill(#"death");
    var_6b2a60d.origin = var_6b2a60d.var_d2f6fb2e;
    level.zombie_total++;
    gibserverutils::annihilate(self);
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x6ccdc9d9, Offset: 0x35e0
// Size: 0x19c
function function_2cb9125b() {
    var_9369bf6c = struct::get("powerup_button", "targetname");
    s_unitrigger_stub = spawnstruct();
    s_unitrigger_stub.origin = var_9369bf6c.origin;
    s_unitrigger_stub.angles = var_9369bf6c.angles;
    s_unitrigger_stub.script_unitrigger_type = "unitrigger_box";
    s_unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_unitrigger_stub.require_look_at = 0;
    s_unitrigger_stub.script_length = 32;
    s_unitrigger_stub.script_width = 64;
    s_unitrigger_stub.script_height = 64;
    s_unitrigger_stub.var_bf3837fa = var_9369bf6c;
    level flag::set("undercroft_powerup_available");
    level.var_57c06a96 = 1;
    s_unitrigger_stub.prompt_and_visibility_func = &function_94073af5;
    level.var_6f0e5d4c = getent(var_9369bf6c.target, "targetname");
    thread zm_unitrigger::register_static_unitrigger(s_unitrigger_stub, &function_81be0b2f);
}

// Namespace namespace_8e89abe3
// Params 1, eflags: 0x1 linked
// Checksum 0x84492584, Offset: 0x3788
// Size: 0x2e
function function_94073af5(player) {
    if (level.round_number >= level.var_57c06a96) {
        return 1;
    }
    return 0;
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0x2c5b346b, Offset: 0x37c0
// Size: 0x1cc
function function_81be0b2f() {
    e_player = self.parent_player;
    if (e_player iswallrunning() && level flag::get("undercroft_powerup_available")) {
        level flag::clear("undercroft_powerup_available");
        var_7c68b1e = getent(self.stub.var_bf3837fa.target, "targetname");
        var_17ff3d6f = vectornormalize(anglestoforward(self.stub.var_bf3837fa.angles)) * 0;
        var_e16f14a2 = var_17ff3d6f + var_7c68b1e.origin;
        var_7c68b1e.old_origin = var_7c68b1e.origin;
        var_7c68b1e moveto(var_e16f14a2, 0.5);
        var_7c68b1e clientfield::increment("low_grav_powerup_triggered");
        e_player playrumbleonentity("zm_castle_low_grav_panel_rumble");
        level.var_6f0e5d4c clientfield::increment("undercroft_wall_panel_shutdown");
        self thread function_34091daf(var_7c68b1e);
    }
}

// Namespace namespace_8e89abe3
// Params 1, eflags: 0x1 linked
// Checksum 0xefe7059e, Offset: 0x3998
// Size: 0xb4
function function_34091daf(var_7c68b1e) {
    var_c21c2ac2 = struct::get("low_grav_powerup_spawn", "targetname");
    powerup = zm_powerups::specific_powerup_drop("minigun", var_c21c2ac2.origin);
    level thread function_42dee8e(var_7c68b1e, powerup, self.stub);
    level thread powerup_timer(var_7c68b1e, powerup, self.stub);
}

// Namespace namespace_8e89abe3
// Params 3, eflags: 0x1 linked
// Checksum 0x2b99500, Offset: 0x3a58
// Size: 0x84
function function_42dee8e(var_7c68b1e, powerup, unitrigger_stub) {
    level endon(#"hash_558a2606");
    powerup waittill(#"powerup_grabbed");
    level.var_57c06a96 = level.round_number + randomintrange(3, 5);
    level thread function_34029460(var_7c68b1e, unitrigger_stub);
}

// Namespace namespace_8e89abe3
// Params 2, eflags: 0x1 linked
// Checksum 0x1cbd848c, Offset: 0x3ae8
// Size: 0x8c
function function_34029460(var_7c68b1e, unitrigger_stub) {
    while (true) {
        level waittill(#"start_of_round");
        if (level.round_number >= level.var_57c06a96) {
            var_7c68b1e moveto(var_7c68b1e.old_origin, 0.5);
            level flag::set("undercroft_powerup_available");
            break;
        }
    }
}

// Namespace namespace_8e89abe3
// Params 3, eflags: 0x1 linked
// Checksum 0x6f8195c8, Offset: 0x3b80
// Size: 0xa4
function powerup_timer(var_7c68b1e, powerup, unitrigger_stub) {
    powerup endon(#"powerup_grabbed");
    wait(10);
    level notify(#"hash_558a2606");
    powerup zm_powerups::powerup_delete();
    wait(50);
    var_7c68b1e moveto(var_7c68b1e.old_origin, 0.5);
    level flag::set("undercroft_powerup_available");
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0xed2a5865, Offset: 0x3c30
// Size: 0x86
function function_8a1f0208() {
    level.var_aed784b3 = 0;
    var_15ed352b = struct::get_array("wall_buy_trigger", "targetname");
    for (i = 0; i < var_15ed352b.size; i++) {
        var_15ed352b[i] thread function_20c76956();
    }
}

// Namespace namespace_8e89abe3
// Params 0, eflags: 0x1 linked
// Checksum 0xd27ec534, Offset: 0x3cc0
// Size: 0x104
function function_20c76956() {
    s_unitrigger_stub = spawnstruct();
    s_unitrigger_stub.origin = self.origin;
    s_unitrigger_stub.angles = self.angles;
    s_unitrigger_stub.script_unitrigger_type = "unitrigger_box";
    s_unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_unitrigger_stub.require_look_at = 0;
    s_unitrigger_stub.script_length = 32;
    s_unitrigger_stub.script_width = 64;
    s_unitrigger_stub.script_height = 64;
    s_unitrigger_stub.var_bf3837fa = self;
    s_unitrigger_stub.var_bf3837fa.activated = 0;
    thread zm_unitrigger::register_static_unitrigger(s_unitrigger_stub, &function_147f328);
}

// Namespace namespace_8e89abe3
// Params 1, eflags: 0x1 linked
// Checksum 0xa4501eb, Offset: 0x3dd0
// Size: 0x1b4
function function_147f328(var_607fccfa) {
    e_player = self.parent_player;
    if (e_player iswallrunning() && self.stub.var_bf3837fa.activated == 0) {
        self.stub.var_bf3837fa.activated = 1;
        var_544a882 = getent(self.stub.var_bf3837fa.target, "targetname");
        playsoundatposition("evt_stone_plate_down", var_544a882.origin);
        e_player playrumbleonentity("zm_castle_low_grav_panel_rumble");
        level.var_aed784b3++;
        var_1b02ae62 = struct::get_array("wall_buy_trigger", "targetname");
        if (level.var_aed784b3 >= var_1b02ae62.size) {
            var_cd1d0af1 = getent("brm_door", "targetname");
            var_cd1d0af1 movez(-20, 2, 0, 1.5);
        }
        var_544a882 clientfield::increment("undercroft_wall_panel_shutdown");
    }
}

// Namespace namespace_8e89abe3
// Params 1, eflags: 0x1 linked
// Checksum 0xef298c9a, Offset: 0x3f90
// Size: 0xec
function function_efa3deb8(e_player) {
    if (self.weapon.name == "lmg_light") {
        var_15ed352b = struct::get_array("wall_buy_trigger", "targetname");
        if (level.var_aed784b3 >= var_15ed352b.size) {
            return true;
        } else {
            self.stub.hint_string = "";
            self sethintstring("");
            self.stub.cursor_hint = "HINT_NOICON";
            self setcursorhint("HINT_NOICON");
            return false;
        }
    }
    return true;
}

/#

    // Namespace namespace_8e89abe3
    // Params 0, eflags: 0x1 linked
    // Checksum 0xf1fdba37, Offset: 0x4088
    // Size: 0x38
    function function_2449723c() {
        if (isdefined(self.var_8665ab89)) {
            if (self.var_8665ab89 == gettime()) {
                return 1;
            }
        }
        self.var_8665ab89 = gettime();
        return 0;
    }

    // Namespace namespace_8e89abe3
    // Params 0, eflags: 0x1 linked
    // Checksum 0xabef71b8, Offset: 0x40c8
    // Size: 0x64
    function function_ab786717() {
        level flagsys::wait_till("undercroft_emissives");
        wait(1);
        zm_devgui::add_custom_devgui_callback(&function_e41a2453);
        adddebugcommand("undercroft_emissives");
    }

    // Namespace namespace_8e89abe3
    // Params 1, eflags: 0x1 linked
    // Checksum 0x5c1dbfbc, Offset: 0x4138
    // Size: 0x76
    function function_e41a2453(cmd) {
        switch (cmd) {
        case 8:
            if (level function_2449723c()) {
                return 1;
            }
            level notify(#"hash_9c3be857");
            level thread function_fceff7eb(9999);
            return 1;
        }
        return 0;
    }

#/
