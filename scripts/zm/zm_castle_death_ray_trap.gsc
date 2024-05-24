#using scripts/shared/ai/zombie_utility;
#using scripts/zm/_zm_ai_mechz;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_traps;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_lightning_chain;
#using scripts/zm/_zm_audio;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_f2d05c13;

// Namespace namespace_f2d05c13
// Params 0, eflags: 0x0
// Checksum 0xe807c748, Offset: 0x648
// Size: 0x2c
function main() {
    register_clientfields();
    level thread function_b8bad181();
}

// Namespace namespace_f2d05c13
// Params 0, eflags: 0x0
// Checksum 0x3d019548, Offset: 0x680
// Size: 0x154
function register_clientfields() {
    clientfield::register("actor", "death_ray_shock_fx", 5000, 1, "int");
    clientfield::register("actor", "death_ray_shock_eye_fx", 5000, 1, "int");
    clientfield::register("actor", "death_ray_explode_fx", 5000, 1, "counter");
    clientfield::register("scriptmover", "death_ray_status_light", 5000, 2, "int");
    clientfield::register("actor", "tesla_beam_fx", 5000, 1, "counter");
    clientfield::register("toplayer", "tesla_beam_fx", 5000, 1, "counter");
    clientfield::register("actor", "tesla_beam_mechz", 5000, 1, "int");
}

// Namespace namespace_f2d05c13
// Params 0, eflags: 0x0
// Checksum 0x38cca624, Offset: 0x7e0
// Size: 0x84
function function_b8bad181() {
    level flag::init("tesla_coil_on");
    level flag::init("tesla_coil_cooldown");
    var_144aea6c = getent("tesla_coil_activate", "targetname");
    var_144aea6c thread function_26dbeb40();
}

// Namespace namespace_f2d05c13
// Params 0, eflags: 0x0
// Checksum 0x6dec6f65, Offset: 0x870
// Size: 0x164
function function_26dbeb40() {
    level waittill(#"power_on");
    exploder::exploder("fxexp_710");
    exploder::exploder("fxexp_720");
    self thread function_40bac98d();
    self thread function_66bab678();
    unitrigger_stub = spawnstruct();
    unitrigger_stub.origin = self.origin;
    unitrigger_stub.angles = self.angles;
    unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.hint_parm1 = 1000;
    unitrigger_stub.radius = 64;
    unitrigger_stub.require_look_at = 0;
    unitrigger_stub.var_42d723eb = self;
    unitrigger_stub.prompt_and_visibility_func = &function_1b068db6;
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_3d3feaa2);
}

// Namespace namespace_f2d05c13
// Params 0, eflags: 0x0
// Checksum 0xa84d0188, Offset: 0x9e0
// Size: 0xc8
function function_66bab678() {
    while (true) {
        level flag::wait_till("tesla_coil_on");
        self playsound("zmb_deathray_on");
        self playloopsound("zmb_deathray_lp", 2);
        level flag::wait_till_clear("tesla_coil_on");
        self stoploopsound(1);
        self playsound("zmb_deathray_off");
    }
}

// Namespace namespace_f2d05c13
// Params 0, eflags: 0x0
// Checksum 0x1844b06, Offset: 0xab0
// Size: 0x190
function function_40bac98d() {
    level thread function_79ce76bb();
    var_95e2b9fb = getent("tesla_coil_panel", "targetname");
    while (true) {
        var_95e2b9fb clientfield::set("death_ray_status_light", 1);
        level flag::wait_till("tesla_coil_on");
        self rotateroll(-120, 0.5);
        self playsound("evt_tram_lever");
        var_95e2b9fb clientfield::set("death_ray_status_light", 2);
        level thread function_2f45472d();
        level flag::wait_till("tesla_coil_cooldown");
        level flag::wait_till_clear("tesla_coil_cooldown");
        self rotateroll(120, 0.5);
        self playsound("evt_tram_lever");
    }
}

// Namespace namespace_f2d05c13
// Params 0, eflags: 0x0
// Checksum 0x1ed8adca, Offset: 0xc48
// Size: 0x1c
function function_79ce76bb() {
    exploder::exploder("lgt_deathray_green");
}

// Namespace namespace_f2d05c13
// Params 0, eflags: 0x0
// Checksum 0xb8c063e5, Offset: 0xc70
// Size: 0x9c
function function_2f45472d() {
    exploder::stop_exploder("lgt_deathray_green");
    while (level flag::get("tesla_coil_on")) {
        exploder::exploder("lgt_deathray_red");
        wait(0.25);
        exploder::stop_exploder("lgt_deathray_red");
        wait(0.25);
    }
    exploder::exploder("lgt_deathray_green");
}

// Namespace namespace_f2d05c13
// Params 1, eflags: 0x0
// Checksum 0x6b6a989d, Offset: 0xd18
// Size: 0xe2
function function_1b068db6(player) {
    if (level flag::get("tesla_coil_on") || player.is_drinking > 0) {
        self sethintstring("");
        return 0;
    }
    if (level flag::get("tesla_coil_cooldown")) {
        self sethintstring(%ZM_CASTLE_DEATH_RAY_COOLDOWN);
        return 0;
    }
    self sethintstring(%ZM_CASTLE_DEATH_RAY_TRAP, self.stub.hint_parm1);
    return 1;
}

// Namespace namespace_f2d05c13
// Params 0, eflags: 0x0
// Checksum 0x6931e360, Offset: 0xe08
// Size: 0x1f0
function function_3d3feaa2() {
    while (true) {
        e_who = self waittill(#"trigger");
        self setinvisibletoall();
        if (e_who.is_drinking > 0) {
            continue;
        }
        if (e_who zm_utility::in_revive_trigger()) {
            continue;
        }
        if (zm_utility::is_player_valid(e_who) && !level flag::get("tesla_coil_on") && !level flag::get("tesla_coil_cooldown")) {
            if (!e_who zm_score::can_player_purchase(1000)) {
                e_who zm_audio::create_and_play_dialog("general", "transport_deny");
            } else {
                e_who zm_score::minus_to_player_score(1000);
                self.stub.var_42d723eb thread function_f796bd32(e_who);
                level thread function_43b12d8e(self.origin);
                e_who thread function_90df19();
                e_who playrumbleonentity("zm_castle_interact_rumble");
                level flag::wait_till("tesla_coil_cooldown");
            }
        }
        self setvisibletoall();
    }
}

// Namespace namespace_f2d05c13
// Params 1, eflags: 0x0
// Checksum 0x8256fe6e, Offset: 0x1000
// Size: 0x16c
function function_f796bd32(player) {
    level flag::set("tesla_coil_on");
    exploder::exploder("fxexp_700");
    level flag::set("death_ray_trap_used");
    zombie_utility::set_zombie_var("tesla_head_gib_chance", 75);
    var_cb1f7664 = getentarray(self.target, "targetname");
    foreach (var_6ba90bc4 in var_cb1f7664) {
        var_6ba90bc4 thread function_65680b09(player);
    }
    level flag::wait_till_clear("tesla_coil_on");
    exploder::stop_exploder("fxexp_700");
}

// Namespace namespace_f2d05c13
// Params 1, eflags: 0x0
// Checksum 0xfbc2e72c, Offset: 0x1178
// Size: 0x40c
function function_65680b09(player) {
    var_9ffdb9e2 = struct::get(self.target, "targetname");
    n_start_time = gettime();
    n_total_time = 0;
    var_c998e88a = 0;
    self._trap_type = "death_ray";
    self.activated_by_player = player;
    while (n_total_time < 15) {
        if (var_c998e88a > 0) {
            var_c998e88a -= 0.1;
        } else {
            var_c998e88a = 0;
            var_1c7748 = self function_98484afb();
            foreach (ai_enemy in var_1c7748) {
                if (!(isdefined(ai_enemy.var_1ea49cd7) && ai_enemy.var_1ea49cd7)) {
                    ai_enemy thread function_991ffb6c(var_9ffdb9e2);
                }
                if (!(isdefined(ai_enemy.var_bce6e774) && ai_enemy.var_bce6e774)) {
                    ai_enemy thread function_120a8b07(player, self);
                }
                var_c998e88a = randomfloatrange(0.6, 1.8);
            }
        }
        foreach (e_player in level.activeplayers) {
            if (zm_utility::is_player_valid(e_player) && e_player function_55b881b7(self) && !(isdefined(e_player.var_1ea49cd7) && e_player.var_1ea49cd7)) {
                e_player thread function_383d6ca4(var_9ffdb9e2, self);
            }
        }
        wait(0.1);
        n_total_time = (gettime() - n_start_time) / 1000;
    }
    level flag::clear("tesla_coil_on");
    foreach (player in level.players) {
        player.var_1ea49cd7 = undefined;
        player.var_bf3163c8 = undefined;
    }
    level flag::set("tesla_coil_cooldown");
    level util::waittill_any_timeout(60, "between_round_over");
    level flag::clear("tesla_coil_cooldown");
}

// Namespace namespace_f2d05c13
// Params 0, eflags: 0x0
// Checksum 0xc7d1841b, Offset: 0x1590
// Size: 0x1ba
function function_98484afb() {
    a_ai_enemies = getaiteamarray(level.zombie_team);
    var_1c7748 = [];
    foreach (ai_zombie in a_ai_enemies) {
        if (ai_zombie function_55b881b7(self)) {
            array::add(var_1c7748, ai_zombie, 0);
        }
    }
    var_1c7748 = array::filter(var_1c7748, 0, &function_172d425, self);
    array::thread_all(var_1c7748, &function_9eaff330);
    var_1c7748 = array::randomize(var_1c7748);
    var_d5157ddf = [];
    for (i = 0; i < 4; i++) {
        array::add(var_d5157ddf, var_1c7748[i], 0);
    }
    return var_d5157ddf;
}

// Namespace namespace_f2d05c13
// Params 0, eflags: 0x0
// Checksum 0xf8310348, Offset: 0x1758
// Size: 0x76
function function_9eaff330() {
    self endon(#"death");
    if (isdefined(self.var_5e3b2ce3)) {
        return;
    }
    self.var_5e3b2ce3 = self.zombie_move_speed;
    self.zombie_move_speed = "walk";
    level flag::wait_till("tesla_coil_cooldown");
    self.zombie_move_speed = self.var_5e3b2ce3;
    self.var_5e3b2ce3 = undefined;
}

// Namespace namespace_f2d05c13
// Params 2, eflags: 0x0
// Checksum 0x4ee98181, Offset: 0x17d8
// Size: 0x6a
function function_172d425(ai_enemy, var_2c11866b) {
    return isalive(ai_enemy) && !(isdefined(ai_enemy.var_98056717) && ai_enemy.var_98056717) && !(ai_enemy.var_1ea49cd7 === 1);
}

// Namespace namespace_f2d05c13
// Params 2, eflags: 0x0
// Checksum 0xba8d40b5, Offset: 0x1850
// Size: 0x202
function function_383d6ca4(var_9ffdb9e2, var_2c11866b) {
    level endon(#"hash_4b40ae8");
    /#
        if (isgodmode(self)) {
            return;
        }
    #/
    n_damage = self.maxhealth / 4;
    while (zm_utility::is_player_valid(self) && self function_55b881b7(var_2c11866b)) {
        var_7929bbd6 = gettime();
        if (!isdefined(self.var_bf3163c8) || var_7929bbd6 - self.var_bf3163c8 > 2000) {
            self thread function_991ffb6c(var_9ffdb9e2);
            self.var_bf3163c8 = var_7929bbd6;
            if (n_damage >= self.health) {
                self dodamage(self.health + 100, self.origin, undefined, undefined, undefined, "MOD_ELECTROCUTED");
            } else {
                n_duration = 1.2;
                self setelectrified(n_duration);
                self shellshock("castle_electrocution_zm", n_duration);
                self playsound("wpn_teslatrap_zap");
                self playrumbleonentity("zm_castle_tesla_electrocution");
                self dodamage(n_damage, self.origin, undefined, undefined, undefined, "MOD_ELECTROCUTED");
            }
        }
        wait(0.1);
    }
    self.var_1ea49cd7 = undefined;
    self.var_bf3163c8 = undefined;
}

// Namespace namespace_f2d05c13
// Params 1, eflags: 0x0
// Checksum 0xa90d43da, Offset: 0x1a60
// Size: 0xb6
function function_55b881b7(var_2c11866b) {
    var_94ef9ffe = getent("tesla_coil_zone", "targetname");
    var_4ca7bb70 = getent("telsa_safety_zone", "targetname");
    if (isdefined(var_4ca7bb70) && self istouching(var_4ca7bb70)) {
        return false;
    }
    if (self istouching(var_94ef9ffe)) {
        return true;
    }
    return false;
}

// Namespace namespace_f2d05c13
// Params 2, eflags: 0x0
// Checksum 0x5b0e5259, Offset: 0x1b20
// Size: 0x3a4
function function_120a8b07(var_ecf98bb6, e_panel) {
    self endon(#"death");
    if (self.isdog) {
        self kill(self.origin, e_panel);
        return;
    }
    if (self.archetype == "mechz") {
        if (!(isdefined(self.var_bce6e774) && self.var_bce6e774)) {
            self clientfield::set("death_ray_shock_fx", 1);
            self clientfield::set("tesla_beam_mechz", 1);
            self thread function_41ecbdf9();
            wait(randomfloatrange(0.2, 0.5));
            self.var_ab0efcf6 = self.origin;
            self thread scene::play("cin_zm_dlc1_mechz_dth_deathray_01", self);
            level flag::wait_till_clear("tesla_coil_on");
            self scene::stop("cin_zm_dlc1_mechz_dth_deathray_01");
            self thread namespace_ef567265::function_bb84a54(self);
            self clientfield::set("death_ray_shock_fx", 0);
            self clientfield::set("tesla_beam_mechz", 0);
            self.var_bce6e774 = undefined;
            wait(randomfloatrange(0.5, 1.5));
            self.var_128cd975 = 0;
        }
        self.var_1ea49cd7 = undefined;
        return;
    }
    self clientfield::set("death_ray_shock_fx", 1);
    self thread function_41ecbdf9();
    self.no_damage_points = 1;
    self.deathpoints_already_given = 1;
    if (isdefined(self.var_1ea49cd7) && self.var_1ea49cd7) {
        if (math::cointoss()) {
            if (isdefined(self.tesla_head_gib_func) && !self.head_gibbed) {
                self [[ self.tesla_head_gib_func ]]();
            }
        } else {
            self clientfield::set("death_ray_shock_eye_fx", 1);
        }
    }
    self scene::play("cin_zm_dlc1_zombie_dth_deathray_0" + randomintrange(1, 5), self);
    self clientfield::set("death_ray_shock_eye_fx", 0);
    self clientfield::set("death_ray_shock_fx", 0);
    self.var_bce6e774 = undefined;
    if (isdefined(var_ecf98bb6) && isdefined(var_ecf98bb6.var_83a6b1fd)) {
        var_ecf98bb6.var_83a6b1fd++;
        var_ecf98bb6 notify(#"zombie_zapped");
    }
    self thread function_67cc41d(var_ecf98bb6, e_panel);
}

// Namespace namespace_f2d05c13
// Params 2, eflags: 0x0
// Checksum 0x10d33b70, Offset: 0x1ed0
// Size: 0xec
function function_67cc41d(attacker, e_panel) {
    self zombie_utility::zombie_eye_glow_stop();
    self clientfield::increment("death_ray_explode_fx");
    self notify(#"exploding");
    self notify(#"end_melee");
    self playsound("zmb_deathray_zombie_poof");
    if (isdefined(attacker)) {
        self notify(#"death", e_panel);
        level notify(#"trap_kill", self, attacker);
    }
    self ghost();
    self util::delay(0.25, undefined, &zm_utility::self_delete);
}

// Namespace namespace_f2d05c13
// Params 0, eflags: 0x0
// Checksum 0x307c02ac, Offset: 0x1fc8
// Size: 0x64
function function_41ecbdf9() {
    self endon(#"death");
    self.var_bce6e774 = 1;
    self.var_128cd975 = 1;
    while (isdefined(self.var_bce6e774) && self.var_bce6e774) {
        if (!self.var_128cd975) {
            self.var_128cd975 = 1;
        }
        wait(0.1);
    }
}

// Namespace namespace_f2d05c13
// Params 1, eflags: 0x0
// Checksum 0xd6807f8e, Offset: 0x2038
// Size: 0x6c
function function_991ffb6c(var_1a8c0e14) {
    self.var_1ea49cd7 = 1;
    if (isplayer(self)) {
        self clientfield::increment_to_player("tesla_beam_fx");
        return;
    }
    self clientfield::increment("tesla_beam_fx");
}

// Namespace namespace_f2d05c13
// Params 1, eflags: 0x0
// Checksum 0x9e6a59fa, Offset: 0x20b0
// Size: 0x8c
function function_43b12d8e(v_position) {
    playsoundatposition("vox_maxis_tesla_pa_begin_1", v_position);
    level flag::wait_till("tesla_coil_cooldown");
    level flag::wait_till_clear("tesla_coil_cooldown");
    playsoundatposition("vox_maxis_tesla_pa_begin_0", v_position);
}

// Namespace namespace_f2d05c13
// Params 0, eflags: 0x0
// Checksum 0xe09ef1eb, Offset: 0x2148
// Size: 0x44
function function_90df19() {
    self endon(#"death");
    self endon(#"disconnect");
    wait(3);
    self zm_audio::create_and_play_dialog("trap", "start");
}

/#

    // Namespace namespace_f2d05c13
    // Params 2, eflags: 0x0
    // Checksum 0xa0fb05b5, Offset: 0x2198
    // Size: 0x72
    function debug_line(v_start, v_end) {
                for (n_timer = 0; n_timer < 10; n_timer += 0.05) {
            line(v_start, v_end, (1, 0, 0));
            wait(0.05);
        }
    }

#/
