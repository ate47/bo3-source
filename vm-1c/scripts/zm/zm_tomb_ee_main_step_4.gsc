#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_ee_main;
#using scripts/zm/zm_tomb_chamber;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_sidequests;
#using scripts/zm/_zm_powerups;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/util_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_tomb_ee_main_step_4;

// Namespace zm_tomb_ee_main_step_4
// Params 0, eflags: 0x1 linked
// Checksum 0x25e1d4a0, Offset: 0x478
// Size: 0x54
function init() {
    namespace_6e97c459::function_5a90ed82("little_girl_lost", "step_4", &init_stage, &function_7747c56, &function_cc3f3f6a);
}

// Namespace zm_tomb_ee_main_step_4
// Params 0, eflags: 0x1 linked
// Checksum 0x76365c99, Offset: 0x4d8
// Size: 0x4c
function init_stage() {
    level.var_ca733eed = "step_4";
    level.var_afc7ad6b = 0;
    level.var_ef2b6bab = 0;
    level.var_10532e02 = 0;
    level.var_789c3e33 = &function_d8d82e7;
}

// Namespace zm_tomb_ee_main_step_4
// Params 0, eflags: 0x1 linked
// Checksum 0x4915408f, Offset: 0x530
// Size: 0x174
function function_7747c56() {
    /#
        iprintln(level.var_ca733eed + "<dev string:x28>");
    #/
    level flag::wait_till("ee_quadrotor_disabled");
    level thread function_c13f73a1();
    if (!level flag::get("ee_mech_zombie_fight_completed")) {
        while (level.var_10532e02 < 8) {
            if (level.var_ef2b6bab < 4) {
                ai = zombie_utility::spawn_zombie(level.var_6c15f1bc[0]);
                ai thread function_560a9669(level.var_10532e02 % 4);
                level.var_ef2b6bab++;
                level.var_10532e02++;
            }
            wait randomfloatrange(0.5, 1);
        }
    }
    level flag::wait_till("ee_mech_zombie_fight_completed");
    util::wait_network_frame();
    namespace_6e97c459::function_2f3ced1f("little_girl_lost", level.var_ca733eed);
}

// Namespace zm_tomb_ee_main_step_4
// Params 1, eflags: 0x1 linked
// Checksum 0xb08b2f8d, Offset: 0x6b0
// Size: 0x22
function function_cc3f3f6a(success) {
    level.var_789c3e33 = undefined;
    level notify(#"hash_4f3f0441");
}

// Namespace zm_tomb_ee_main_step_4
// Params 0, eflags: 0x1 linked
// Checksum 0x2691beb0, Offset: 0x6e0
// Size: 0x266
function function_d8d82e7() {
    s_goal = struct::get("ee_mech_hole_goal_0", "targetname");
    if (distance2dsquared(self.origin, s_goal.origin) < 250000) {
        self setvehgoalpos(s_goal.origin, 1, 2);
        self util::waittill_any("near_goal", "force_goal", "reached_end_node");
        s_goal = struct::get("ee_mech_hole_goal_1", "targetname");
        self setvehgoalpos(s_goal.origin, 1, 0);
        self util::waittill_any("near_goal", "force_goal", "reached_end_node");
        wait 2;
        s_goal = struct::get("ee_mech_hole_goal_2", "targetname");
        self setvehgoalpos(s_goal.origin, 1, 0);
        self util::waittill_any("near_goal", "force_goal", "reached_end_node");
        playsoundatposition("zmb_squest_maxis_folly", s_goal.origin);
        zm_tomb_vo::function_7dc74a72("vox_maxi_drone_upgraded_3", self);
        level flag::set("ee_quadrotor_disabled");
        self dodamage(-56, self.origin);
        self delete();
        level.var_461e417 = undefined;
    }
}

// Namespace zm_tomb_ee_main_step_4
// Params 1, eflags: 0x1 linked
// Checksum 0xa9efa350, Offset: 0x950
// Size: 0x2ec
function function_560a9669(var_c45ee422) {
    self endon(#"death");
    level endon(#"intermission");
    self.animname = "mechz_zombie";
    self.missinglegs = 0;
    self.no_gib = 1;
    self.ignore_all_poi = 1;
    self.is_mechz = 1;
    self.ignore_enemy_count = 1;
    self.no_damage_points = 1;
    self.meleedamage = 75;
    zm_utility::function_20fdac8();
    self setphysparams(20, 0, 80);
    self.zombie_init_done = 1;
    self notify(#"zombie_init_done");
    self.allowpain = 0;
    self animmode("normal");
    self orientmode("face enemy");
    self zm_spawner::zombie_setup_attack_properties();
    self.completed_emerging_into_playable_area = 1;
    self notify(#"completed_emerging_into_playable_area");
    self.no_powerups = 0;
    self setfreecameralockonallowed(0);
    self thread zombie_utility::zombie_eye_glow();
    waittillframeend();
    self clientfield::set("tomb_mech_eye", 1);
    self.health = level.var_53cc405d;
    level thread zm_spawner::zombie_death_event(self);
    self thread zm_spawner::function_1612a0b8();
    var_ed6191c0 = struct::get_array("mech_hole_spawner", "targetname");
    spawn_pos = var_ed6191c0[var_c45ee422];
    if (!isdefined(spawn_pos.angles)) {
        spawn_pos.angles = (0, 0, 0);
    }
    self thread function_c1e2974c();
    self forceteleport(spawn_pos.origin, spawn_pos.angles);
    self zombie_utility::set_zombie_run_cycle("walk");
    if (isdefined(level.var_424ca259)) {
        level thread [[ level.var_424ca259 ]]();
    }
    self function_c6ef7f82(spawn_pos);
}

// Namespace zm_tomb_ee_main_step_4
// Params 0, eflags: 0x1 linked
// Checksum 0x6aa3fd5c, Offset: 0xc48
// Size: 0xec
function function_c1e2974c() {
    self waittill(#"death");
    self clientfield::set("tomb_mech_eye", 0);
    level.var_afc7ad6b++;
    level.var_ef2b6bab--;
    if (level.var_afc7ad6b == 4) {
        var_e11a8658 = self.origin;
        level thread zm_powerups::specific_powerup_drop("full_ammo", var_e11a8658);
    }
    if (level.var_afc7ad6b == 8) {
        var_1c3d5cfc = self.origin;
        level thread zm_powerups::specific_powerup_drop("nuke", var_1c3d5cfc);
        level flag::set("ee_mech_zombie_fight_completed");
    }
}

// Namespace zm_tomb_ee_main_step_4
// Params 1, eflags: 0x1 linked
// Checksum 0xde5f350e, Offset: 0xd40
// Size: 0x358
function function_c6ef7f82(s_spawn_pos) {
    self endon(#"death");
    self endon(#"hash_517ec5c4");
    /#
        if (getdvarint("<dev string:x45>") > 0) {
            println("<dev string:x51>");
        }
    #/
    /#
        if (getdvarint("<dev string:x45>") > 1) {
            println("<dev string:x6b>");
        }
    #/
    self.var_d0ea20c0 = 1;
    self setfreecameralockonallowed(0);
    self animscripted("zm_fly_out", self.origin, self.angles, "ai_zombie_mech_exit");
    self zombie_shared::donotetracks("zm_fly_out");
    self ghost();
    if (isdefined(self.var_19cbb780)) {
        self.var_19cbb780 ghost();
    }
    var_b218b791 = self.var_34297332;
    self thread zombie_utility::zombie_eye_glow_stop();
    self animscripted("zm_fly_hover_finished", self.origin, self.angles, "ai_zombie_mech_exit_hover");
    wait level.var_2750d45b;
    s_landing_point = struct::get(s_spawn_pos.target, "targetname");
    if (!isdefined(s_landing_point.angles)) {
        s_landing_point.angles = (0, 0, 0);
    }
    self animscripted("zm_fly_in", s_landing_point.origin, s_landing_point.angles, "ai_zombie_mech_arrive");
    self show();
    self.var_34297332 = var_b218b791;
    self clientfield::set("mechz_fx", self.var_34297332);
    if (isdefined(self.var_19cbb780)) {
        self.var_19cbb780 show();
    }
    self zombie_shared::donotetracks("zm_fly_in");
    self.var_d0ea20c0 = 0;
    self setfreecameralockonallowed(1);
    /#
        if (getdvarint("<dev string:x45>") > 1) {
            println("<dev string:x90>");
        }
    #/
    self.var_2cd5dd3e = s_landing_point;
}

// Namespace zm_tomb_ee_main_step_4
// Params 0, eflags: 0x1 linked
// Checksum 0xbf2b1cf, Offset: 0x10a0
// Size: 0x10c
function function_c13f73a1() {
    var_97e27c72 = function_84a3ca09();
    if (!var_97e27c72) {
        return;
    }
    level.var_5738e0e5 = 1;
    level clientfield::set("mus_zmb_egg_snapshot_loop", 1);
    ent = spawn("script_origin", (0, 0, 0));
    ent playloopsound("mus_mechz_fight_loop");
    level flag::wait_till("ee_mech_zombie_fight_completed");
    level clientfield::set("mus_zmb_egg_snapshot_loop", 0);
    level.var_5738e0e5 = 0;
    wait 0.05;
    ent delete();
}

// Namespace zm_tomb_ee_main_step_4
// Params 0, eflags: 0x1 linked
// Checksum 0x25e7485, Offset: 0x11b8
// Size: 0x50
function function_84a3ca09() {
    counter = 0;
    while (isdefined(level.var_5738e0e5) && level.var_5738e0e5) {
        wait 1;
        counter++;
        if (counter >= 60) {
            return false;
        }
    }
    return true;
}

