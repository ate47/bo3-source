#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;
#using scripts/zm/zm_sumpf;
#using scripts/zm/zm_sumpf_zipline;

#namespace zm_sumpf_trap_pendulum;

// Namespace zm_sumpf_trap_pendulum
// Params 0, eflags: 0x0
// Checksum 0x21d92f5e, Offset: 0x428
// Size: 0x210
function function_5b96904c() {
    var_3d5f2e06 = getentarray("pendulum_buy_trigger", "targetname");
    for (i = 0; i < var_3d5f2e06.size; i++) {
        var_3d5f2e06[i].lever = getent(var_3d5f2e06[i].target, "targetname");
        var_3d5f2e06[i].var_50551f5f = getent(var_3d5f2e06[i].lever.target, "targetname");
        var_3d5f2e06[i].var_16b12946 = getent(var_3d5f2e06[i].var_50551f5f.target, "targetname");
        var_3d5f2e06[i].var_d8ea4416 = getent(var_3d5f2e06[i].var_16b12946.target, "targetname");
        var_3d5f2e06[i]._trap_type = "flogger";
    }
    var_3d5f2e06[0].var_50551f5f enablelinkto();
    var_3d5f2e06[0].var_50551f5f linkto(var_3d5f2e06[0].var_16b12946);
    level thread zm_sumpf::function_e1aaca19("pendulum_light");
    level.var_99432870 = 0;
}

// Namespace zm_sumpf_trap_pendulum
// Params 0, eflags: 0x0
// Checksum 0x84a42404, Offset: 0x640
// Size: 0xe2
function function_c3dda1aa() {
    var_51d4996f = getent("switch_left", "targetname");
    var_1ddf50ca = getent("switch_right", "targetname");
    self.lever rotatepitch(-76, 0.5);
    var_51d4996f playsound("zmb_switch_on");
    var_1ddf50ca playsound("zmb_switch_on");
    self.lever waittill(#"rotatedone");
    self notify(#"hash_50f15d93");
}

// Namespace zm_sumpf_trap_pendulum
// Params 0, eflags: 0x0
// Checksum 0xdaa11660, Offset: 0x730
// Size: 0xe2
function function_60843de1() {
    var_51d4996f = getent("switch_left", "targetname");
    var_1ddf50ca = getent("switch_right", "targetname");
    self.lever rotatepitch(-180, 0.5);
    var_51d4996f playsound("zmb_switch_off");
    var_1ddf50ca playsound("zmb_switch_off");
    self.lever waittill(#"rotatedone");
    self notify(#"hash_6bfca09c");
}

// Namespace zm_sumpf_trap_pendulum
// Params 1, eflags: 0x0
// Checksum 0x2a2f17d1, Offset: 0x820
// Size: 0xa4
function hint_string(string) {
    if (string == %ZOMBIE_BUTTON_BUY_TRAP) {
        self.is_available = 1;
        self.zombie_cost = 750;
        self.in_use = 0;
        self sethintstring(string, self.zombie_cost);
    } else {
        self sethintstring(string);
    }
    self setcursorhint("HINT_NOICON");
}

// Namespace zm_sumpf_trap_pendulum
// Params 0, eflags: 0x0
// Checksum 0x98de429a, Offset: 0x8d0
// Size: 0x438
function function_46e4b0ba() {
    self sethintstring("");
    pa_system = getent("speaker_by_log", "targetname");
    wait 0.5;
    self.is_available = 1;
    self.zombie_cost = 750;
    self sethintstring(%ZOMBIE_BUTTON_BUY_TRAP, self.zombie_cost);
    self setcursorhint("HINT_NOICON");
    triggers = getentarray("pendulum_buy_trigger", "targetname");
    array::thread_all(triggers, &hint_string, %ZOMBIE_BUTTON_BUY_TRAP);
    while (true) {
        self waittill(#"trigger", who);
        self.var_ada0f5b2 = who;
        if (who zm_utility::in_revive_trigger() || level.var_99432870) {
            continue;
        }
        if (zombie_utility::is_player_valid(who)) {
            if (who zm_score::can_player_purchase(self.zombie_cost)) {
                if (!level.var_99432870) {
                    level.var_99432870 = 1;
                    level thread zm_sumpf::function_5ba3c6e5("pendulum_light");
                    array::thread_all(triggers, &hint_string, %ZOMBIE_TRAP_ACTIVE);
                    zm_utility::play_sound_at_pos("purchase", who.origin);
                    who thread zm_audio::create_and_play_dialog("level", "trap_log");
                    who zm_score::minus_to_player_score(self.zombie_cost);
                    self thread function_c3dda1aa();
                    self waittill(#"hash_50f15d93");
                    var_8121257c = getent("engine_loop_left", "targetname");
                    var_50955e53 = getent("engine_loop_right", "targetname");
                    playsoundatposition("zmb_motor_start_left", var_8121257c.origin);
                    playsoundatposition("zmb_motor_start_right", var_50955e53.origin);
                    wait 0.5;
                    self thread function_ac46b2f7(var_8121257c, var_50955e53, who);
                    self waittill(#"hash_f64cbe4e");
                    array::thread_all(triggers, &hint_string, %ZOMBIE_TRAP_COOLDOWN);
                    self thread function_60843de1();
                    self waittill(#"hash_6bfca09c");
                    wait 45;
                    pa_system playsound("zmb_warning");
                    level thread zm_sumpf::function_e1aaca19("pendulum_light");
                    level.var_99432870 = 0;
                    array::thread_all(triggers, &hint_string, %ZOMBIE_BUTTON_BUY_TRAP);
                }
            }
        }
    }
}

// Namespace zm_sumpf_trap_pendulum
// Params 3, eflags: 0x0
// Checksum 0xf4e47c6c, Offset: 0xd10
// Size: 0x344
function function_ac46b2f7(var_8121257c, var_50955e53, who) {
    wheel_left = spawn("script_origin", var_8121257c.origin);
    wheel_right = spawn("script_origin", var_50955e53.origin);
    util::wait_network_frame();
    var_8121257c playloopsound("zmb_motor_loop_left");
    var_50955e53 playloopsound("zmb_motor_loop_right");
    util::wait_network_frame();
    wheel_left playloopsound("zmb_wheel_loop");
    wheel_right playloopsound("zmb_belt_loop");
    self.var_16b12946 notify(#"hash_cca58996");
    self.var_16b12946 notsolid();
    self.var_50551f5f triggerenable(1);
    self.var_50551f5f thread function_ff47477d(self, who);
    self.var_f75b2a0c = 1;
    if (self.script_noteworthy == "1") {
        self.var_d8ea4416 rotatepitch(-14040, 30, 6, 6);
        self.var_16b12946 rotatepitch(-14040, 30, 6, 6);
    } else {
        self.var_d8ea4416 rotatepitch(14040, 30, 6, 6);
        self.var_16b12946 rotatepitch(14040, 30, 6, 6);
    }
    level thread function_832aabf(var_8121257c, var_50955e53, wheel_left, wheel_right);
    self.var_16b12946 thread function_ab6ace70();
    self.var_16b12946 waittill(#"rotatedone");
    self.var_50551f5f triggerenable(0);
    self.var_f75b2a0c = 0;
    self.var_16b12946 thread zm_sumpf_zipline::function_9ae0a79();
    self notify(#"hash_f64cbe4e");
    level notify(#"hash_1bcf775");
    wait 3;
    wheel_left delete();
    wheel_right delete();
}

// Namespace zm_sumpf_trap_pendulum
// Params 0, eflags: 0x0
// Checksum 0x3d95905d, Offset: 0x1060
// Size: 0x26a
function function_ab6ace70() {
    self endon(#"rotatedone");
    blade_left = getent("blade_left", "targetname");
    blade_right = getent("blade_right", "targetname");
    for (lastangle = self.angles[0]; ; lastangle = angle) {
        var_d9865ad0 = 90;
        wait 0.01;
        angle = self.angles[0];
        speed = int(abs(angle - lastangle)) % 360;
        var_c2f72a6c = int(abs(angle)) % 360;
        var_7965d00c = int(abs(lastangle)) % 360;
        if (var_c2f72a6c == var_7965d00c || speed < 7) {
            lastangle = angle;
            continue;
        }
        if (var_c2f72a6c > var_d9865ad0 && var_7965d00c <= var_d9865ad0) {
            blade_left playsound("zmb_blade_right");
            blade_right playsound("zmb_blade_right");
        }
        if ((var_c2f72a6c + -76) % 360 > var_d9865ad0 && (var_7965d00c + -76) % 360 <= var_d9865ad0) {
            blade_left playsound("zmb_blade_right");
            blade_right playsound("zmb_blade_right");
        }
    }
}

// Namespace zm_sumpf_trap_pendulum
// Params 4, eflags: 0x0
// Checksum 0xb9afc176, Offset: 0x12d8
// Size: 0xd4
function function_832aabf(var_8121257c, var_50955e53, wheel_left, wheel_right) {
    wait 13;
    var_8121257c stoploopsound(2);
    var_8121257c playsound("zmb_motor_stop_left");
    var_50955e53 stoploopsound(2);
    var_50955e53 playsound("zmb_motor_stop_right");
    wait 8;
    wheel_left stoploopsound(8);
    wheel_right stoploopsound(8);
}

// Namespace zm_sumpf_trap_pendulum
// Params 2, eflags: 0x0
// Checksum 0x76900d20, Offset: 0x13b8
// Size: 0xb8
function function_ff47477d(parent, who) {
    level thread function_49e0867();
    while (true) {
        self waittill(#"trigger", ent);
        if (parent.var_f75b2a0c == 1) {
            if (isplayer(ent)) {
                ent thread function_7d258b1c();
                continue;
            }
            ent thread function_24330aa3(parent, who);
        }
    }
}

// Namespace zm_sumpf_trap_pendulum
// Params 0, eflags: 0x0
// Checksum 0xf4bfac35, Offset: 0x1478
// Size: 0x44
function function_49e0867() {
    level.var_576d3a1d = 0;
    while (level.var_576d3a1d <= 20) {
        wait 0.1;
        level.var_576d3a1d += 0.1;
    }
}

// Namespace zm_sumpf_trap_pendulum
// Params 0, eflags: 0x0
// Checksum 0x866f0943, Offset: 0x14c8
// Size: 0xec
function function_7d258b1c() {
    self endon(#"death");
    self endon(#"disconnect");
    players = getplayers();
    if (players.size == 1) {
        self dodamage(80, self.origin + (0, 0, 20));
        self setstance("crouch");
        return;
    }
    if (!self laststand::player_is_in_laststand()) {
        radiusdamage(self.origin, 10, self.health + 100, self.health + 100);
    }
}

// Namespace zm_sumpf_trap_pendulum
// Params 2, eflags: 0x0
// Checksum 0xe12da9f6, Offset: 0x15c0
// Size: 0x264
function function_24330aa3(parent, who) {
    self endon(#"death");
    self.var_9a9a0f55 = parent;
    self.var_aa99de67 = who;
    parent.activated_by_player = who;
    if (level flag::get("dog_round")) {
        self.a.nodeath = 1;
        return;
    }
    if (!isdefined(level.var_960264ad)) {
        level thread function_25748d83();
    }
    if (!isdefined(self.flung)) {
        if (parent.script_noteworthy == "1") {
            x = randomintrange(-56, -6);
            y = randomintrange(-35, 35);
            z = randomintrange(95, 120);
        } else {
            x = randomintrange(-250, -200);
            y = randomintrange(-35, 35);
            z = randomintrange(95, 120);
        }
        if (level.var_576d3a1d < 6) {
            adjustment = level.var_576d3a1d / 6;
        } else if (level.var_576d3a1d > 24) {
            adjustment = (30 - level.var_576d3a1d) / 6;
        } else {
            adjustment = 1;
        }
        x *= adjustment;
        y *= adjustment;
        z *= adjustment;
        self thread function_8fec7f40(x, y, z, parent);
    }
}

// Namespace zm_sumpf_trap_pendulum
// Params 0, eflags: 0x0
// Checksum 0xcc78f9f3, Offset: 0x1830
// Size: 0x4c
function function_25748d83() {
    level.var_960264ad = 0;
    while (true) {
        util::wait_network_frame();
        util::wait_network_frame();
        level.var_960264ad = 0;
    }
}

// Namespace zm_sumpf_trap_pendulum
// Params 4, eflags: 0x0
// Checksum 0x11dafd2a, Offset: 0x1888
// Size: 0x13c
function function_8fec7f40(x, y, z, parent) {
    self.flung = 1;
    while (level.var_960264ad > 4) {
        util::wait_network_frame();
    }
    self thread function_6a5beb44();
    self startragdoll();
    self launchragdoll((x, y, z));
    util::wait_network_frame();
    self dodamage(self.health, self.origin, parent);
    if (isdefined(parent.activated_by_player) && isplayer(parent.activated_by_player)) {
        parent.activated_by_player zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_TRAP");
    }
    level.var_960264ad++;
}

// Namespace zm_sumpf_trap_pendulum
// Params 0, eflags: 0x0
// Checksum 0xaee0d34, Offset: 0x19d0
// Size: 0x40
function function_b866f920() {
    while (true) {
        level.var_266eb8ee = 0;
        util::wait_network_frame();
        util::wait_network_frame();
    }
}

// Namespace zm_sumpf_trap_pendulum
// Params 0, eflags: 0x0
// Checksum 0x427ed8a9, Offset: 0x1a18
// Size: 0xcc
function function_6a5beb44() {
    if (!isdefined(level.var_266eb8ee)) {
        level thread function_b866f920();
    }
    self playsound("zmb_flogger_death");
    if (level.var_266eb8ee < 5) {
        self playsound("zmb_vocals_zombie_death");
        self clientfield::set("zombie_flogger_trap", 1);
        level.var_266eb8ee++;
    }
    wait 0.75;
    self dodamage(self.health + 600, self.origin);
}

