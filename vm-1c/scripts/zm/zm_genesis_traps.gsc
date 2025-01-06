#using scripts/codescripts/struct;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_trap_electric;
#using scripts/zm/_zm_traps;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;

#namespace zm_genesis_traps;

// Namespace zm_genesis_traps
// Params 0, eflags: 0x2
// Checksum 0x7d27cfdf, Offset: 0x5e0
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_genesis_traps", &__init__, &__main__, undefined);
}

// Namespace zm_genesis_traps
// Params 0, eflags: 0x0
// Checksum 0xadfe041f, Offset: 0x628
// Size: 0x10
function __init__() {
    level.var_671111f8 = 1;
}

// Namespace zm_genesis_traps
// Params 0, eflags: 0x0
// Checksum 0x21259ef7, Offset: 0x640
// Size: 0x84
function __main__() {
    level flag::wait_till("start_zombie_round_logic");
    function_f45953c();
    a_t_traps = getentarray("t_flogger_trap", "targetname");
    array::thread_all(a_t_traps, &function_835fd6d8);
}

// Namespace zm_genesis_traps
// Params 0, eflags: 0x0
// Checksum 0xa1d27a59, Offset: 0x6d0
// Size: 0x72
function function_f45953c() {
    level._effect["zapper"] = "dlc1/castle/fx_elec_trap_castle";
    level._effect["elec_md"] = "zombie/fx_elec_player_md_zmb";
    level._effect["elec_sm"] = "zombie/fx_elec_player_sm_zmb";
    level._effect["elec_torso"] = "zombie/fx_elec_player_torso_zmb";
}

// Namespace zm_genesis_traps
// Params 0, eflags: 0x0
// Checksum 0x780be34c, Offset: 0x750
// Size: 0x2e4
function function_835fd6d8() {
    self flag::init("trap_active");
    self flag::init("trap_cooldown");
    self.zombie_cost = 1000;
    level.var_1183e023 = 0;
    self.var_ad39b789 = [];
    self.var_aba4ba44 = [];
    a_e_parts = getentarray(self.target, "targetname");
    for (i = 0; i < a_e_parts.size; i++) {
        if (isdefined(a_e_parts[i].script_noteworthy)) {
            switch (a_e_parts[i].script_noteworthy) {
            case "pendulum":
                self.var_4b6ad173 = a_e_parts[i];
                self enablelinkto();
                self linkto(self.var_4b6ad173);
                break;
            case "gears":
                self.var_52f6a55f = a_e_parts[i];
                break;
            case "switch":
                self.var_ad39b789[self.var_ad39b789.size] = a_e_parts[i];
                break;
            }
        }
    }
    a_s_parts = struct::get_array(self.target, "targetname");
    for (i = 0; i < a_s_parts.size; i++) {
        if (isdefined(a_s_parts[i].script_noteworthy)) {
            switch (a_s_parts[i].script_noteworthy) {
            case "buy_trigger":
                self.var_aba4ba44[self.var_aba4ba44.size] = a_s_parts[i];
                break;
            case "motor_sound_left":
                self.var_f1693315 = a_s_parts[i];
                break;
            case "motor_sound_right":
                self.var_736c69e7 = a_s_parts[i];
                break;
            }
        }
    }
    self thread trap_move_switches();
    self triggerenable(0);
    array::thread_all(self.var_aba4ba44, &function_38d940ac, self);
}

// Namespace zm_genesis_traps
// Params 1, eflags: 0x0
// Checksum 0xcd3a2b81, Offset: 0xa40
// Size: 0x210
function function_38d940ac(t_trap) {
    s_unitrigger = self zm_unitrigger::create_unitrigger(%ZOMBIE_NEED_POWER, 64, &function_dc9dafb8);
    s_unitrigger.require_look_at = 1;
    zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger, 1);
    s_unitrigger.t_trap = t_trap;
    s_unitrigger.script_int = t_trap.script_int;
    t_trap._trap_type = "flogger";
    while (true) {
        self waittill(#"trigger_activated", e_player);
        if (e_player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (e_player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(e_player)) {
            continue;
        }
        if (e_player zm_score::can_player_purchase(1000)) {
            e_player zm_score::minus_to_player_score(1000);
            t_trap thread function_157a698(self, e_player);
            t_trap.activated_by_player = e_player;
            continue;
        }
        zm_utility::play_sound_at_pos("no_purchase", self.origin);
        if (isdefined(level.custom_generic_deny_vo_func)) {
            e_player thread [[ level.custom_generic_deny_vo_func ]](1);
            continue;
        }
        e_player zm_audio::create_and_play_dialog("general", "outofmoney");
    }
}

// Namespace zm_genesis_traps
// Params 1, eflags: 0x0
// Checksum 0xb65312ad, Offset: 0xc58
// Size: 0x192
function function_dc9dafb8(e_player) {
    if (isdefined(e_player.zombie_vars["zombie_powerup_minigun_on"]) && e_player.zombie_vars["zombie_powerup_minigun_on"]) {
        self sethintstring(%);
        return 0;
    }
    if (isdefined(self.stub.script_int) && !level flag::get("power_on" + self.stub.script_int)) {
        self sethintstring(%ZOMBIE_NEED_POWER);
        return 0;
    }
    if (self.stub.t_trap flag::get("trap_active")) {
        self sethintstring(%ZOMBIE_TRAP_ACTIVE);
        return 0;
    }
    if (self.stub.t_trap flag::get("trap_cooldown")) {
        self sethintstring(%ZOMBIE_TRAP_COOLDOWN);
        return 0;
    }
    self sethintstring(%ZOMBIE_BUTTON_BUY_TRAP, 1000);
    return 1;
}

// Namespace zm_genesis_traps
// Params 0, eflags: 0x0
// Checksum 0x433da91a, Offset: 0xdf8
// Size: 0x278
function trap_move_switches() {
    for (i = 0; i < self.var_ad39b789.size; i++) {
        self.var_ad39b789[i] rotatepitch(-170, 0.5);
    }
    self.var_ad39b789[0] waittill(#"rotatedone");
    if (isdefined(self.script_int) && !level flag::get("power_on" + self.script_int)) {
        level flag::wait_till("power_on" + self.script_int);
    }
    self trap_lights_green();
    while (true) {
        self flag::wait_till("trap_active");
        self trap_lights_red();
        for (i = 0; i < self.var_ad39b789.size; i++) {
            self.var_ad39b789[i] rotatepitch(-86, 0.5);
            self.var_ad39b789[i] playsound("evt_switch_flip_trap");
        }
        self.var_ad39b789[0] waittill(#"rotatedone");
        self flag::wait_till("trap_cooldown");
        for (i = 0; i < self.var_ad39b789.size; i++) {
            self.var_ad39b789[i] rotatepitch(-170, 0.5);
        }
        self.var_ad39b789[0] waittill(#"rotatedone");
        self flag::wait_till_clear("trap_cooldown");
        self trap_lights_green();
    }
}

// Namespace zm_genesis_traps
// Params 0, eflags: 0x0
// Checksum 0x51cf7b6a, Offset: 0x1078
// Size: 0x5c
function trap_lights_red() {
    if (isdefined(self.script_noteworthy)) {
        exploder::exploder(self.script_noteworthy + "_red");
        exploder::stop_exploder(self.script_noteworthy + "_green");
    }
}

// Namespace zm_genesis_traps
// Params 0, eflags: 0x0
// Checksum 0xde837d27, Offset: 0x10e0
// Size: 0x5c
function trap_lights_green() {
    if (isdefined(self.script_noteworthy)) {
        exploder::exploder(self.script_noteworthy + "_green");
        exploder::stop_exploder(self.script_noteworthy + "_red");
    }
}

// Namespace zm_genesis_traps
// Params 2, eflags: 0x0
// Checksum 0xb6286f6b, Offset: 0x1148
// Size: 0x144
function function_157a698(var_c4f1ee44, e_player) {
    self triggerenable(1);
    self flag::set("trap_active");
    playsoundatposition("zmb_flogger_motor_start_l", self.var_f1693315.origin);
    playsoundatposition("zmb_flogger_motor_start_r", self.var_736c69e7.origin);
    wait 0.5;
    self thread function_bb59d4d9(var_c4f1ee44, e_player);
    self waittill(#"trap_done");
    self flag::clear("trap_active");
    self flag::set("trap_cooldown");
    self triggerenable(0);
    wait 45;
    self flag::clear("trap_cooldown");
}

// Namespace zm_genesis_traps
// Params 2, eflags: 0x0
// Checksum 0x7f61f5b2, Offset: 0x1298
// Size: 0x21a
function function_bb59d4d9(var_c4f1ee44, e_player) {
    var_ffd9e7a0 = util::spawn_model("tag_origin", self.var_f1693315.origin);
    var_94be4c8f = util::spawn_model("tag_origin", self.var_736c69e7.origin);
    util::wait_network_frame();
    level notify(#"trap_activate", self);
    var_ffd9e7a0 playloopsound("zmb_flogger_motor_lp_l");
    var_94be4c8f playloopsound("zmb_flogger_motor_lp_r");
    self.var_4b6ad173 notsolid();
    self thread function_1f2a0da5(var_c4f1ee44, e_player);
    if (var_c4f1ee44.script_string === "reverse") {
        var_5faddb59 = -14040;
    } else {
        var_5faddb59 = 14040;
    }
    self.var_52f6a55f rotatepitch(var_5faddb59, 30, 6, 6);
    self.var_4b6ad173 rotatepitch(var_5faddb59, 30, 6, 6);
    level thread function_ec80dc42(self.var_4b6ad173);
    level thread function_e5b7e8b0(var_ffd9e7a0, var_94be4c8f);
    self.var_4b6ad173 waittill(#"rotatedone");
    self.var_4b6ad173 solid();
    self notify(#"trap_done");
}

// Namespace zm_genesis_traps
// Params 1, eflags: 0x0
// Checksum 0x491c9211, Offset: 0x14c0
// Size: 0x1c0
function function_ec80dc42(var_4b6ad173) {
    var_4b6ad173 endon(#"rotatedone");
    var_feed8b5b = var_4b6ad173.angles[0];
    var_dea46db3 = var_4b6ad173.angles[0];
    firsttime = 1;
    while (true) {
        wait 0.05;
        var_feed8b5b = var_4b6ad173.angles[0];
        var_b6c309e9 = var_dea46db3 - var_feed8b5b;
        if (firsttime) {
            if (var_b6c309e9 >= 80) {
                var_4b6ad173 playsound("zmb_flogger_blade_whoosh");
                firsttime = 0;
                var_dea46db3 -= 80;
            } else if (var_b6c309e9 <= -80) {
                var_4b6ad173 playsound("zmb_flogger_blade_whoosh");
                firsttime = 0;
                var_dea46db3 += 80;
            }
            continue;
        }
        if (var_b6c309e9 >= -76) {
            var_4b6ad173 playsound("zmb_flogger_blade_whoosh");
            var_dea46db3 -= -76;
            continue;
        }
        if (var_b6c309e9 <= -180) {
            var_4b6ad173 playsound("zmb_flogger_blade_whoosh");
            var_dea46db3 += -76;
        }
    }
}

// Namespace zm_genesis_traps
// Params 2, eflags: 0x0
// Checksum 0x13bc6868, Offset: 0x1688
// Size: 0xc4
function function_e5b7e8b0(var_ffd9e7a0, var_94be4c8f) {
    wait 24;
    var_ffd9e7a0 stoploopsound(4);
    var_ffd9e7a0 playsound("zmb_flogger_motor_stop_l");
    var_94be4c8f stoploopsound(4);
    var_94be4c8f playsound("zmb_flogger_motor_stop_r");
    wait 5;
    var_ffd9e7a0 delete();
    var_94be4c8f delete();
}

// Namespace zm_genesis_traps
// Params 2, eflags: 0x0
// Checksum 0x862e9c00, Offset: 0x1758
// Size: 0x90
function function_1f2a0da5(var_c4f1ee44, e_player) {
    self endon(#"trap_done");
    while (true) {
        self waittill(#"trigger", e_who);
        if (isplayer(e_who)) {
            e_who thread function_29cb39e6();
            continue;
        }
        e_who thread function_af6b7901(var_c4f1ee44, e_player);
    }
}

// Namespace zm_genesis_traps
// Params 0, eflags: 0x0
// Checksum 0x1dd40823, Offset: 0x17f0
// Size: 0xfc
function function_29cb39e6() {
    self endon(#"death");
    self endon(#"disconnect");
    if (level.activeplayers.size == 1) {
        if (!(isdefined(self.b_no_trap_damage) && self.b_no_trap_damage)) {
            self dodamage(80, self.origin + (0, 0, 20));
        }
        self setstance("crouch");
        return;
    }
    if (!self laststand::player_is_in_laststand()) {
        if (!(isdefined(self.b_no_trap_damage) && self.b_no_trap_damage)) {
            self dodamage(self.health + 100, self.origin + (0, 0, 20));
        }
    }
}

// Namespace zm_genesis_traps
// Params 2, eflags: 0x0
// Checksum 0x42cd2e1d, Offset: 0x18f8
// Size: 0xbc
function function_af6b7901(var_c4f1ee44, e_player) {
    self endon(#"death");
    if (self.archetype === "parasite") {
        self kill();
    } else if (self.archetype === "zombie") {
        level notify(#"flogger_killed_zombie", self, e_player);
        if (!isdefined(self.b_flung)) {
            self thread function_8fec7f40(var_c4f1ee44);
        }
    }
    if (isdefined(self.var_fbaea41d)) {
        self thread [[ self.var_fbaea41d ]](e_player);
    }
}

// Namespace zm_genesis_traps
// Params 1, eflags: 0x0
// Checksum 0x3ae67fd3, Offset: 0x19c0
// Size: 0x1dc
function function_8fec7f40(var_c4f1ee44) {
    self.b_flung = 1;
    self playsound("zmb_death_gibs");
    if (var_c4f1ee44.script_string === "reverse") {
        x = randomintrange(-56, -6);
        y = randomintrange(-35, 35);
        z = randomintrange(95, 120);
    } else {
        x = randomintrange(-250, -200);
        y = randomintrange(-35, 35);
        z = randomintrange(95, 120);
    }
    if (level.var_1183e023 > 8) {
        self do_zombie_explode();
        return;
    }
    self thread function_f5ad0ae6();
    self startragdoll();
    self launchragdoll((x, y, z));
    util::wait_network_frame();
    self dodamage(self.health, self.origin);
    level.zombie_total++;
}

// Namespace zm_genesis_traps
// Params 0, eflags: 0x0
// Checksum 0xf22f1e3, Offset: 0x1ba8
// Size: 0x20
function function_f5ad0ae6() {
    level.var_1183e023++;
    self waittill(#"death");
    level.var_1183e023--;
}

// Namespace zm_genesis_traps
// Params 0, eflags: 0x4
// Checksum 0xdc003b0f, Offset: 0x1bd0
// Size: 0x94
function private do_zombie_explode() {
    util::wait_network_frame();
    if (isdefined(self)) {
        self zombie_utility::zombie_eye_glow_stop();
        self clientfield::increment("skull_turret_explode_fx");
        self ghost();
        self util::delay(0.25, undefined, &zm_utility::self_delete);
    }
}

