#using scripts/shared/ai_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;

#namespace _zm_weap_raygun_mark3;

// Namespace _zm_weap_raygun_mark3
// Params 0, eflags: 0x2
// Checksum 0x83ccf4e0, Offset: 0x3e0
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_weap_raygun_mark3", &__init__, &__main__, undefined);
}

// Namespace _zm_weap_raygun_mark3
// Params 0, eflags: 0x0
// Checksum 0xe6cd86ae, Offset: 0x428
// Size: 0x294
function __init__() {
    level.var_b0d33e26 = getweapon("raygun_mark3");
    level.var_6c1db712 = getweapon("raygun_mark3lh");
    level.var_f0cf2cc9 = getweapon("raygun_mark3_upgraded");
    level.var_88d25d2d = getweapon("raygun_mark3lh_upgraded");
    zm_utility::register_slowdown("raygun_mark3lh", 0.7, 2);
    zm_utility::register_slowdown("raygun_mark3lh_upgraded", 0.5, 3);
    zm_spawner::register_zombie_damage_callback(&function_aa1813ba);
    clientfield::register("scriptmover", "slow_vortex_fx", 12000, 2, "int");
    clientfield::register("actor", "ai_disintegrate", 12000, 1, "int");
    clientfield::register("vehicle", "ai_disintegrate", 12000, 1, "int");
    clientfield::register("actor", "ai_slow_vortex_fx", 12000, 2, "int");
    clientfield::register("vehicle", "ai_slow_vortex_fx", 12000, 2, "int");
    visionset_mgr::register_info("visionset", "raygun_mark3_vortex_visionset", 12000, 24, 30, 1, &visionset_mgr::ramp_in_out_thread_per_player, 1);
    visionset_mgr::register_info("overlay", "raygun_mark3_vortex_blur", 12000, 24, 30, 1, &visionset_mgr::ramp_in_out_thread_per_player, 1);
    callback::on_connect(&function_3aef849c);
}

// Namespace _zm_weap_raygun_mark3
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x6c8
// Size: 0x4
function __main__() {
    
}

// Namespace _zm_weap_raygun_mark3
// Params 1, eflags: 0x0
// Checksum 0x5a416114, Offset: 0x6d8
// Size: 0x34
function function_b2cc2acc(weapon) {
    if (weapon === level.var_6c1db712 || weapon === level.var_88d25d2d) {
        return true;
    }
    return false;
}

// Namespace _zm_weap_raygun_mark3
// Params 1, eflags: 0x0
// Checksum 0xdea183e6, Offset: 0x718
// Size: 0x34
function function_b08b743e(weapon) {
    if (weapon === level.var_b0d33e26 || weapon === level.var_f0cf2cc9) {
        return true;
    }
    return false;
}

// Namespace _zm_weap_raygun_mark3
// Params 1, eflags: 0x0
// Checksum 0x53f7ac4f, Offset: 0x758
// Size: 0x76
function function_4dc74fe3(var_48ea2f27) {
    v_nearest_navmesh_point = getclosestpointonnavmesh(var_48ea2f27, 50, 32);
    if (isdefined(v_nearest_navmesh_point)) {
        v_vortex_origin = v_nearest_navmesh_point + (0, 0, 32);
    } else {
        v_vortex_origin = var_48ea2f27;
    }
    return v_vortex_origin;
}

// Namespace _zm_weap_raygun_mark3
// Params 0, eflags: 0x0
// Checksum 0xf442aeec, Offset: 0x7d8
// Size: 0xd8
function function_3aef849c() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"projectile_impact", w_weapon, v_pos, n_radius, e_projectile, v_normal);
        var_7efa7e23 = function_4dc74fe3(v_pos + v_normal * 32);
        if (function_b2cc2acc(w_weapon)) {
            self thread function_ec91716c(w_weapon, v_pos, var_7efa7e23, n_radius, e_projectile, v_normal);
        }
    }
}

// Namespace _zm_weap_raygun_mark3
// Params 6, eflags: 0x0
// Checksum 0x49eb2492, Offset: 0x8b8
// Size: 0x18c
function function_ec91716c(w_weapon, v_pos, var_7efa7e23, n_radius, e_attacker, v_normal) {
    self endon(#"disconnect");
    mdl_vortex = spawn("script_model", v_pos);
    mdl_vortex setmodel("p7_fxanim_zm_stal_ray_gun_ball_mod");
    playsoundatposition("wpn_mk3_orb_created", mdl_vortex.origin);
    mdl_vortex.angles = (270, 0, 0);
    mdl_vortex clientfield::set("slow_vortex_fx", 1);
    util::wait_network_frame();
    mdl_vortex moveto(var_7efa7e23, 0.1);
    util::wait_network_frame();
    mdl_vortex.health = 100000;
    mdl_vortex.takedamage = 1;
    mdl_vortex thread function_64a32180(self, w_weapon);
    mdl_vortex thread function_38237edc();
}

// Namespace _zm_weap_raygun_mark3
// Params 2, eflags: 0x0
// Checksum 0xea3fdb37, Offset: 0xa50
// Size: 0x444
function function_64a32180(e_owner, w_weapon) {
    self endon(#"death");
    self.var_dfb28a5a = 1;
    self.n_end_time = gettime() + 3000;
    self.e_owner = e_owner;
    if (w_weapon == level.var_6c1db712) {
    } else {
        playsoundatposition("wpn_mk3_orb_zark_far", self.origin);
    }
    while (gettime() <= self.n_end_time) {
        if (self.var_dfb28a5a == 1) {
            n_radius = -128;
            if (w_weapon == level.var_6c1db712) {
                var_4f2446c1 = 50;
            } else {
                var_4f2446c1 = 100;
            }
        } else {
            n_radius = -128;
            playsoundatposition("wpn_mk3_orb_zark_far", self.origin);
            if (w_weapon == level.var_6c1db712) {
                var_4f2446c1 = 1000;
            } else {
                var_4f2446c1 = 5000;
            }
        }
        n_radius_squared = n_radius * n_radius;
        a_ai = getaiteamarray("axis");
        foreach (ai in a_ai) {
            if (isdefined(ai.var_d9730c9) && ai.var_d9730c9) {
                continue;
            }
            if (distancesquared(self.origin, ai.origin) <= n_radius_squared) {
                ai thread apply_vortex_fx(self.var_dfb28a5a, 2);
                if (ai.health > var_4f2446c1) {
                    ai dodamage(var_4f2446c1, self.origin, e_owner, self, undefined, "MOD_UNKNOWN", 0, w_weapon);
                    continue;
                }
                if (self.var_dfb28a5a == 2) {
                    ai thread function_43cd4a49(self, e_owner, w_weapon);
                }
            }
        }
        foreach (e_player in level.activeplayers) {
            if (isdefined(e_player) && !(isdefined(e_player.var_d1bcf259) && e_player.var_d1bcf259)) {
                if (distance(e_player.origin, self.origin) < float(n_radius / 2)) {
                    e_player thread player_vortex_visionset();
                }
            }
        }
        wait 0.5;
    }
    self clientfield::set("slow_vortex_fx", 0);
    playsoundatposition("wpn_mk3_orb_disappear", self.origin);
    self delete();
}

// Namespace _zm_weap_raygun_mark3
// Params 0, eflags: 0x0
// Checksum 0xae61586b, Offset: 0xea0
// Size: 0xbc
function player_vortex_visionset() {
    self notify(#"player_vortex_visionset");
    self endon(#"player_vortex_visionset");
    self endon(#"death");
    thread visionset_mgr::activate("visionset", "raygun_mark3_vortex_visionset", self, 0.25, 2, 0.25);
    thread visionset_mgr::activate("overlay", "raygun_mark3_vortex_blur", self, 0.25, 2, 0.25);
    self.var_d1bcf259 = 1;
    wait 2.5;
    self.var_d1bcf259 = 0;
}

// Namespace _zm_weap_raygun_mark3
// Params 0, eflags: 0x0
// Checksum 0x5a0afb37, Offset: 0xf68
// Size: 0x1c8
function function_38237edc() {
    self endon(#"death");
    self playloopsound("wpn_mk3_orb_loop");
    while (true) {
        self waittill(#"damage", n_damage, e_attacker, v_direction, v_point, str_means_of_death, str_tag_name, str_model_name, var_829b9480, w_weapon);
        if (function_b08b743e(w_weapon)) {
            self stoploopsound();
            self setmodel("tag_origin");
            self playloopsound("wpn_mk3_orb_loop_activated");
            self.takedamage = 0;
            self.var_dfb28a5a = 2;
            self clientfield::set("slow_vortex_fx", self.var_dfb28a5a);
            self.n_end_time = gettime() + 3000;
            wait 3;
            playsoundatposition("wpn_mk3_orb_disappear", self.origin);
            self delete();
            return;
        }
        self.health = 100000;
    }
}

// Namespace _zm_weap_raygun_mark3
// Params 13, eflags: 0x0
// Checksum 0xb6669e31, Offset: 0x1138
// Size: 0x154
function function_aa1813ba(str_mod, var_5afff096, var_7c5a4ee4, e_player, n_amount, w_weapon, v_direction, str_tag, str_model, str_part, n_flags, e_inflictor, var_9780eb62) {
    if (isdefined(w_weapon)) {
        if (w_weapon == level.var_6c1db712 || w_weapon == level.var_88d25d2d) {
            if (isdefined(self.var_5c201c5d)) {
                return [[ self.var_5c201c5d ]](str_mod, var_5afff096, var_7c5a4ee4, e_player, n_amount, w_weapon, v_direction, str_tag, str_model, str_part, n_flags, e_inflictor, var_9780eb62);
            }
            if (w_weapon == level.var_6c1db712) {
                self thread zm_utility::function_447d3917("raygun_mark3lh");
                return 1;
            } else if (w_weapon == level.var_88d25d2d) {
                self thread zm_utility::function_447d3917("raygun_mark3lh_upgraded");
                return 1;
            }
        }
    }
    return 0;
}

// Namespace _zm_weap_raygun_mark3
// Params 2, eflags: 0x0
// Checksum 0xa395dba5, Offset: 0x1298
// Size: 0x164
function apply_vortex_fx(var_dfb28a5a, n_time) {
    self notify(#"apply_vortex_fx");
    self endon(#"apply_vortex_fx");
    self endon(#"death");
    if (!(isdefined(self.var_9df1f7) && self.var_9df1f7)) {
        self.var_9df1f7 = 1;
        if (isdefined(self.allowpain) && self.allowpain) {
            self.var_9071df3c = 1;
            self ai::disable_pain();
        }
        if (var_dfb28a5a == 1) {
            self clientfield::set("ai_slow_vortex_fx", 1);
        } else {
            self clientfield::set("ai_slow_vortex_fx", 2);
        }
    }
    util::waittill_any_timeout(n_time, "death", "apply_vortex_fx");
    if (isdefined(self.var_9071df3c) && self.var_9071df3c) {
        self ai::enable_pain();
    }
    self clientfield::set("ai_slow_vortex_fx", 0);
}

// Namespace _zm_weap_raygun_mark3
// Params 3, eflags: 0x0
// Checksum 0xfc7ca3bc, Offset: 0x1408
// Size: 0x1ac
function function_43cd4a49(e_inflictor, e_attacker, w_weapon) {
    self endon(#"death");
    if (isdefined(self.var_53b01890) && self.var_53b01890) {
        return;
    }
    self.var_53b01890 = 1;
    self clientfield::set("ai_disintegrate", 1);
    if (isvehicle(self)) {
        self ai::set_ignoreall(1);
        wait 1.1;
        self ghost();
        self dodamage(self.health, self.origin, e_attacker, e_inflictor, undefined, "MOD_UNKNOWN", 0, w_weapon);
        return;
    }
    self scene::play("cin_zm_dlc3_zombie_dth_deathray_0" + randomintrange(1, 5), self);
    self clientfield::set("ai_slow_vortex_fx", 0);
    util::wait_network_frame();
    self ghost();
    self dodamage(self.health, self.origin, e_attacker, e_inflictor, undefined, "MOD_UNKNOWN", 0, w_weapon);
}

