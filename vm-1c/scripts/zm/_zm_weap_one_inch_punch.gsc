#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_utility;

#namespace _zm_weap_one_inch_punch;

// Namespace _zm_weap_one_inch_punch
// Params 0, eflags: 0x0
// Checksum 0x9c253e4a, Offset: 0x528
// Size: 0x1bc
function init() {
    clientfield::register("allplayers", "oneinchpunch_impact", 21000, 1, "int");
    clientfield::register("actor", "oneinchpunch_physics_launchragdoll", 21000, 1, "int");
    level.var_653c9585 = getweapon("one_inch_punch");
    level.var_4f241554 = getweapon("one_inch_punch_fire");
    level.var_e27d2514 = getweapon("one_inch_punch_air");
    level.var_590c486e = getweapon("one_inch_punch_lightning");
    level.var_af96dd85 = getweapon("one_inch_punch_ice");
    level.var_75ef78a0 = getweapon("one_inch_punch_upgraded");
    level.var_9d7b544c = getweapon("zombie_one_inch_punch_flourish");
    level.var_ee516197 = getweapon("zombie_one_inch_punch_upgrade_flourish");
    level._effect["oneinch_impact"] = "dlc5/tomb/fx_one_inch_punch_impact";
    level._effect["punch_knockdown_ground"] = "dlc5/zmb_weapon/fx_thundergun_knockback_ground";
    callback::on_connect(&function_d4260e2a);
}

// Namespace _zm_weap_one_inch_punch
// Params 0, eflags: 0x0
// Checksum 0xcf722742, Offset: 0x6f0
// Size: 0xe4
function function_82aee9e9() {
    if (!issubstr(self.var_6a22bdf4.name, "one_inch_punch")) {
        self takeweapon(self.var_6a22bdf4);
        if (self.var_6a22bdf4.name == "bowie_knife") {
            self giveweapon(level.var_43f0e707);
            self zm_utility::set_player_melee_weapon(level.var_43f0e707);
            return;
        }
        self giveweapon(level.var_85b560d4);
        self zm_utility::set_player_melee_weapon(level.var_85b560d4);
    }
}

// Namespace _zm_weap_one_inch_punch
// Params 0, eflags: 0x0
// Checksum 0x47f9af6a, Offset: 0x7e0
// Size: 0x4bc
function function_3898d995() {
    self endon(#"disconnect");
    self endon(#"hash_9f6b45c1");
    if (!(isdefined(self.var_5fc3c5c7) && self.var_5fc3c5c7)) {
        self flag::init("melee_punch_cooldown");
    }
    self.var_5fc3c5c7 = 1;
    self.var_82aee9e9 = &function_82aee9e9;
    current_melee_weapon = self zm_utility::get_player_melee_weapon();
    self takeweapon(current_melee_weapon);
    if (isdefined(self.var_21412003) && self.var_21412003) {
        w_weapon = self getcurrentweapon();
        self zm_utility::disable_player_move_states(1);
        self giveweapon(level.var_9d7b544c);
        self switchtoweapon(level.var_9d7b544c);
        self util::waittill_any("player_downed", "weapon_change_complete");
        self switchtoweapon(w_weapon);
        self zm_utility::enable_player_move_states();
        self takeweapon(level.var_9d7b544c);
        if (self.var_b37dabd2 == "air") {
            self giveweapon(level.var_e27d2514);
            self zm_utility::set_player_melee_weapon(level.var_e27d2514);
        } else if (self.var_b37dabd2 == "fire") {
            self giveweapon(level.var_4f241554);
            self zm_utility::set_player_melee_weapon(level.var_4f241554);
        } else if (self.var_b37dabd2 == "ice") {
            self giveweapon(level.var_af96dd85);
            self zm_utility::set_player_melee_weapon(level.var_af96dd85);
        } else if (self.var_b37dabd2 == "lightning") {
            self giveweapon(level.var_590c486e);
            self zm_utility::set_player_melee_weapon(level.var_590c486e);
        } else {
            self giveweapon(level.var_75ef78a0);
            self zm_utility::set_player_melee_weapon(level.var_75ef78a0);
        }
    } else {
        w_weapon = self getcurrentweapon();
        self zm_utility::disable_player_move_states(1);
        self giveweapon(level.var_9d7b544c);
        self switchtoweapon(level.var_9d7b544c);
        self util::waittill_any("player_downed", "weapon_change_complete");
        self switchtoweapon(w_weapon);
        self zm_utility::enable_player_move_states();
        self takeweapon(level.var_9d7b544c);
        self giveweapon(level.var_653c9585);
        self zm_utility::set_player_melee_weapon(level.var_653c9585);
        self thread zm_audio::create_and_play_dialog("perk", "one_inch");
    }
    self thread function_3208147f();
}

// Namespace _zm_weap_one_inch_punch
// Params 0, eflags: 0x0
// Checksum 0x91b2a17d, Offset: 0xca8
// Size: 0x358
function function_3208147f() {
    self endon(#"disconnect");
    self notify(#"hash_b046b644");
    self endon(#"hash_b046b644");
    self endon(#"bled_out");
    w_shield = getweapon("tomb_shield");
    while (true) {
        while (!self ismeleeing()) {
            wait 0.05;
        }
        if (self getcurrentweapon() == w_shield) {
            wait 0.1;
            continue;
        }
        var_cebbb65d = 1;
        self clientfield::set("oneinchpunch_impact", 1);
        util::wait_network_frame();
        self clientfield::set("oneinchpunch_impact", 0);
        var_fdf687e6 = anglestoforward(self getplayerangles());
        var_86ec6694 = get_2d_yaw((0, 0, 0), var_fdf687e6);
        if (isdefined(self.var_21412003) && self.var_21412003 && isdefined(self.var_b37dabd2) && self.var_b37dabd2 == "air") {
            var_cebbb65d *= 2;
        }
        a_zombies = getaispeciesarray(level.zombie_team, "all");
        a_zombies = util::get_array_of_closest(self.origin, a_zombies, undefined, undefined, 100);
        foreach (zombie in a_zombies) {
            if (self function_a8ec9424(zombie, var_86ec6694) && distancesquared(self.origin, zombie.origin) <= 4096 * var_cebbb65d) {
                self thread function_e3515922(zombie, 1);
                continue;
            }
            if (self function_a8ec9424(zombie, var_86ec6694)) {
                self thread function_e3515922(zombie, 0.5);
            }
        }
        while (self ismeleeing()) {
            wait 0.05;
        }
        wait 0.05;
    }
}

// Namespace _zm_weap_one_inch_punch
// Params 2, eflags: 0x0
// Checksum 0x51023ef5, Offset: 0x1008
// Size: 0x98
function function_a8ec9424(zombie, var_86ec6694) {
    var_7bf57a66 = get_2d_yaw(self.origin, zombie.origin);
    yaw_diff = var_7bf57a66 - var_86ec6694;
    if (yaw_diff < 0) {
        yaw_diff *= -1;
    }
    if (yaw_diff < 35) {
        return 1;
    }
    return 0;
}

// Namespace _zm_weap_one_inch_punch
// Params 0, eflags: 0x0
// Checksum 0x441d9c5d, Offset: 0x10a8
// Size: 0x20
function function_3df205a3() {
    return isdefined(self.damageweapon) && self.damageweapon == level.var_653c9585;
}

// Namespace _zm_weap_one_inch_punch
// Params 1, eflags: 0x0
// Checksum 0xcfa0a756, Offset: 0x10d0
// Size: 0x2c
function function_979d676e(player) {
    player endon(#"disconnect");
    self zombie_utility::zombie_head_gib();
}

// Namespace _zm_weap_one_inch_punch
// Params 0, eflags: 0x0
// Checksum 0x669dbf5e, Offset: 0x1108
// Size: 0x24
function function_9dea2b61() {
    wait 1;
    self flag::set("melee_punch_cooldown");
}

// Namespace _zm_weap_one_inch_punch
// Params 2, eflags: 0x0
// Checksum 0x8efc4d39, Offset: 0x1138
// Size: 0x38c
function function_e3515922(ai_zombie, n_mod) {
    self endon(#"disconnect");
    ai_zombie.var_5f42068e = &function_b8873df0;
    if (isdefined(n_mod)) {
        if (self hasperk("specialty_widowswine")) {
            n_mod *= 1.1;
        }
        if (isdefined(self.var_21412003) && self.var_21412003) {
            n_base_damage = 11275;
        } else {
            n_base_damage = 2250;
        }
        n_damage = int(n_base_damage * n_mod);
        if (!(isdefined(ai_zombie.is_mechz) && ai_zombie.is_mechz)) {
            if (n_damage >= ai_zombie.health) {
                self thread function_bde291a1(ai_zombie);
                self zm_utility::do_player_general_vox("kill", "one_inch_punch");
                if (isdefined(self.var_21412003) && self.var_21412003 && isdefined(self.var_b37dabd2)) {
                    switch (self.var_b37dabd2) {
                    case "fire":
                        ai_zombie clientfield::set("fire_char_fx", 1);
                        break;
                    case "ice":
                        ai_zombie clientfield::set("attach_bullet_model", 1);
                        break;
                    case "lightning":
                        if (isdefined(ai_zombie.is_mechz) && ai_zombie.is_mechz) {
                            return;
                        }
                        if (isdefined(ai_zombie.is_electrocuted) && ai_zombie.is_electrocuted) {
                            return;
                        }
                        tag = "J_SpineUpper";
                        ai_zombie clientfield::set("lightning_impact_fx", 1);
                        break;
                    }
                }
            } else {
                self zm_score::player_add_points("damage_light");
                if (isdefined(self.var_21412003) && self.var_21412003 && isdefined(self.var_b37dabd2)) {
                    switch (self.var_b37dabd2) {
                    case "fire":
                        ai_zombie clientfield::set("fire_char_fx", 1);
                        break;
                    case "ice":
                        ai_zombie clientfield::set("attach_bullet_model", 1);
                        break;
                    case "lightning":
                        ai_zombie clientfield::set("lightning_impact_fx", 1);
                        break;
                    }
                }
            }
        }
        ai_zombie dodamage(n_damage, ai_zombie.origin, self, self, 0, "MOD_MELEE", 0, self.current_melee_weapon);
    }
}

// Namespace _zm_weap_one_inch_punch
// Params 1, eflags: 0x0
// Checksum 0x5a636c7d, Offset: 0x14d0
// Size: 0xec
function function_bde291a1(ai_zombie) {
    ai_zombie thread function_979d676e(self);
    if (isdefined(level.var_cfba6d83) && ![[ level.var_cfba6d83 ]]()) {
        return;
    }
    if (isdefined(ai_zombie)) {
        ai_zombie startragdoll();
        v_launch = vectornormalize(ai_zombie.origin - self.origin) * randomintrange(125, -106) + (0, 0, randomintrange(75, -106));
        ai_zombie launchragdoll(v_launch);
    }
}

// Namespace _zm_weap_one_inch_punch
// Params 1, eflags: 0x0
// Checksum 0x7afb0fe6, Offset: 0x15c8
// Size: 0x74
function function_b8873df0(note) {
    if (note == "zombie_knockdown_ground_impact") {
        playfx(level._effect["punch_knockdown_ground"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
    }
}

// Namespace _zm_weap_one_inch_punch
// Params 0, eflags: 0x0
// Checksum 0x88fded42, Offset: 0x1648
// Size: 0x78
function function_d4260e2a() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"bled_out");
        self.var_5fc3c5c7 = 0;
        self.var_82aee9e9 = undefined;
        if (self flag::exists("melee_punch_cooldown")) {
            self flag::delete("melee_punch_cooldown");
        }
    }
}

// Namespace _zm_weap_one_inch_punch
// Params 0, eflags: 0x0
// Checksum 0x15d1cb11, Offset: 0x16c8
// Size: 0x43e
function function_60897a18() {
    self notify(#"hash_69167db5");
    self endon(#"killanimscript");
    self endon(#"death");
    self endon(#"hash_69167db5");
    if (isdefined(self.marked_for_death) && self.marked_for_death) {
        return;
    }
    self.allowpain = 0;
    var_510c41fb = undefined;
    var_e104524f = "";
    var_2f795199 = undefined;
    var_e1bb8348 = "_default";
    v_forward = vectordot(anglestoforward(self.angles), vectornormalize(self.var_36a949c6 - self.origin));
    if (v_forward > 0.6) {
        var_510c41fb = "back";
        if (isdefined(self.missinglegs) && self.missinglegs) {
            var_e104524f = "_crawl";
        }
        if (randomint(100) > 75) {
            var_2f795199 = "belly";
        } else {
            var_2f795199 = "back";
        }
    } else if (self.damageyaw > 75 && self.damageyaw < -121) {
        var_510c41fb = "left";
        var_2f795199 = "belly";
    } else if (self.damageyaw > -135 && self.damageyaw < -75) {
        var_510c41fb = "right";
        var_2f795199 = "belly";
    } else {
        var_510c41fb = "front";
        var_2f795199 = "belly";
    }
    self thread function_38561712();
    self setanimstatefromasd("zm_punch_fall_" + var_510c41fb + var_e104524f);
    self zombie_shared::donotetracks("punch_fall_anim", self.var_5f42068e);
    if (isdefined(self.marked_for_death) && (isdefined(self.missinglegs) && self.missinglegs || self.marked_for_death)) {
        return;
    }
    if (isdefined(self.a.gib_ref)) {
        if ((self.a.gib_ref == "left_arm" || self.a.gib_ref == "right_arm") && ((self.a.gib_ref == "left_leg" || self.a.gib_ref == "right_leg") && (self.a.gib_ref == "no_legs" || self.a.gib_ref == "no_arms" || randomint(100) > 25) || randomint(100) > 75)) {
            var_e1bb8348 = "_late";
        } else if (randomint(100) > 75) {
            var_e1bb8348 = "_early";
        }
    } else if (randomint(100) > 25) {
        var_e1bb8348 = "_early";
    }
    self zombie_shared::donotetracks("punch_getup_anim");
    self.allowpain = 1;
    self notify(#"back_up");
}

// Namespace _zm_weap_one_inch_punch
// Params 0, eflags: 0x0
// Checksum 0x3e41776a, Offset: 0x1b10
// Size: 0x50
function function_38561712() {
    self endon(#"death");
    self.var_bf74a81e = 1;
    self util::waittill_any("damage", "back_up");
    self.var_bf74a81e = 0;
}

// Namespace _zm_weap_one_inch_punch
// Params 2, eflags: 0x0
// Checksum 0x6483d1d1, Offset: 0x1b68
// Size: 0x5a
function get_2d_yaw(v_origin, v_target) {
    v_forward = v_target - v_origin;
    v_angles = vectortoangles(v_forward);
    return v_angles[1];
}

