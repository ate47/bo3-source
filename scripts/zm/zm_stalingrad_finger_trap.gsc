#using scripts/shared/ai/zombie_utility;
#using scripts/zm/zm_stalingrad_vo;
#using scripts/zm/zm_stalingrad_util;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_score;
#using scripts/shared/scene_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_b205ff9c;

// Namespace namespace_b205ff9c
// Params 0, eflags: 0x0
// Checksum 0xd62c8d92, Offset: 0x3c0
// Size: 0x64
function main() {
    level waittill(#"start_zombie_round_logic");
    level flag::init("finger_trap_on");
    level flag::init("finger_trap_cooldown");
    level function_7715178d();
}

// Namespace namespace_b205ff9c
// Params 0, eflags: 0x0
// Checksum 0x5a7b180b, Offset: 0x430
// Size: 0xb4
function function_7715178d() {
    level thread scene::init("p7_fxanim_zm_stal_finger_trap_bundle");
    level.var_79dbe0dd = [];
    scene::add_scene_func("p7_fxanim_zm_stal_finger_trap_bundle", &function_2d729696, "init");
    var_bbadd4a4 = struct::get_array("finger_trap_activate", "targetname");
    array::thread_all(var_bbadd4a4, &function_eeb24547);
}

// Namespace namespace_b205ff9c
// Params 1, eflags: 0x0
// Checksum 0x232797b3, Offset: 0x4f0
// Size: 0x124
function function_2d729696(a_ents) {
    wait(1);
    t_left = getent("finger_damage_trig_left", "targetname");
    t_right = getent("finger_damage_trig_right", "targetname");
    level.var_79dbe0dd[0] = t_right;
    level.var_79dbe0dd[1] = t_left;
    t_left enablelinkto();
    t_right enablelinkto();
    t_left linkto(a_ents["trap_finger_left"], "tag_mid_animate");
    t_right linkto(a_ents["trap_finger_right"], "tag_mid_animate");
}

// Namespace namespace_b205ff9c
// Params 0, eflags: 0x0
// Checksum 0x7d967a72, Offset: 0x620
// Size: 0x74
function function_eeb24547() {
    self zm_unitrigger::create_unitrigger("", 64, &function_512d92f4);
    self.s_unitrigger.hint_parm1 = 1500;
    self.s_unitrigger.require_look_at = 0;
    self thread function_891da2d8();
}

// Namespace namespace_b205ff9c
// Params 1, eflags: 0x0
// Checksum 0xf6d0e464, Offset: 0x6a0
// Size: 0x150
function function_512d92f4(e_player) {
    if (e_player.is_drinking > 0) {
        self sethintstring("");
        return false;
    } else if (!level flag::get("power_on")) {
        self sethintstring(%ZOMBIE_NEED_POWER);
        return false;
    } else if (level flag::get("finger_trap_on")) {
        self sethintstring(%ZOMBIE_TRAP_ACTIVE);
        return false;
    } else if (level flag::get("finger_trap_cooldown")) {
        self sethintstring(%ZM_STALINGRAD_TRAP_COOLDOWN);
        return false;
    } else {
        self sethintstring(%ZM_STALINGRAD_FINGER_TRAP, self.stub.hint_parm1);
    }
    return true;
}

// Namespace namespace_b205ff9c
// Params 0, eflags: 0x0
// Checksum 0xb1df054e, Offset: 0x7f8
// Size: 0x1c0
function function_891da2d8() {
    while (true) {
        if (level flag::get("finger_trap_cooldown")) {
            level flag::wait_till_clear("finger_trap_cooldown");
        }
        e_who = self waittill(#"trigger_activated");
        if (!level flag::get("finger_trap_on") && !level flag::get("finger_trap_cooldown")) {
            if (!e_who zm_score::can_player_purchase(1500)) {
                zm_utility::play_sound_at_pos("no_purchase", self.origin);
                e_who zm_audio::create_and_play_dialog("general", "outofmoney");
                continue;
            }
            level flag::set("finger_trap_on");
            e_who clientfield::increment_to_player("interact_rumble");
            e_who notify(#"hash_ad9aba38");
            e_who zm_score::minus_to_player_score(1500);
            self namespace_48c05c81::function_903f6b36(1);
            level function_ec450f14(e_who);
            self namespace_48c05c81::function_903f6b36(0);
        }
    }
}

// Namespace namespace_b205ff9c
// Params 1, eflags: 0x0
// Checksum 0xe368b4f4, Offset: 0x9c0
// Size: 0x13c
function function_ec450f14(var_3778532a) {
    var_3778532a thread namespace_dcf9c464::function_c0914f1b();
    array::run_all(level.var_79dbe0dd, &triggerenable, 1);
    array::thread_all(level.var_79dbe0dd, &function_f5af37c6, var_3778532a);
    level function_88a65f39();
    array::run_all(level.var_79dbe0dd, &triggerenable, 0);
    level flag::clear("finger_trap_on");
    level flag::set("finger_trap_cooldown");
    /#
        level endon(#"hash_f8b849b9");
    #/
    wait(90);
    level flag::clear("finger_trap_cooldown");
}

// Namespace namespace_b205ff9c
// Params 0, eflags: 0x0
// Checksum 0x749c5d48, Offset: 0xb08
// Size: 0x6c
function function_88a65f39() {
    n_start_time = gettime();
    for (n_total_time = 0; n_total_time < 15; n_total_time = (gettime() - n_start_time) / 1000) {
        level scene::play("p7_fxanim_zm_stal_finger_trap_bundle");
    }
}

// Namespace namespace_b205ff9c
// Params 1, eflags: 0x0
// Checksum 0x93ea2543, Offset: 0xb80
// Size: 0x1b0
function function_f5af37c6(var_3778532a) {
    level endon(#"hash_46e86024");
    while (true) {
        e_who = self waittill(#"trigger");
        if (!(isdefined(e_who.var_bd3a4420) && e_who.var_bd3a4420)) {
            if (e_who.health <= 20000) {
                if (!isplayer(e_who) && isdefined(var_3778532a)) {
                    var_3778532a notify(#"hash_2637f64f");
                    var_3778532a zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_KILL_TRAP");
                }
                if (e_who.archetype === "zombie") {
                    e_who thread zombie_utility::zombie_gut_explosion();
                }
            } else if (!isplayer(e_who)) {
                e_who.var_bd3a4420 = 1;
                e_who thread function_fe885d6b();
            }
            if (isplayer(e_who) && e_who issliding()) {
                continue;
            }
            e_who dodamage(20000, e_who.origin, self, undefined, "none", "MOD_IMPACT");
        }
    }
}

// Namespace namespace_b205ff9c
// Params 0, eflags: 0x0
// Checksum 0x19714132, Offset: 0xd38
// Size: 0x22
function function_fe885d6b() {
    self endon(#"death");
    wait(0.25);
    self.var_bd3a4420 = undefined;
}

/#

    // Namespace namespace_b205ff9c
    // Params 0, eflags: 0x0
    // Checksum 0x4f86fd8a, Offset: 0xd68
    // Size: 0x94
    function function_ddb9991b() {
        if (!level flag::get("<unknown string>")) {
            level flag::set("<unknown string>");
            level flag::clear("<unknown string>");
            level notify(#"hash_f8b849b9");
            level function_ec450f14(level.players[0]);
        }
    }

    // Namespace namespace_b205ff9c
    // Params 0, eflags: 0x0
    // Checksum 0xa66c5527, Offset: 0xe08
    // Size: 0x52
    function function_fc99caf5() {
        if (level flag::get("<unknown string>")) {
            level flag::clear("<unknown string>");
            level notify(#"hash_f8b849b9");
        }
    }

#/
