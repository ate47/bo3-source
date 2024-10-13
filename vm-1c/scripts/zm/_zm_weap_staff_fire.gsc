#using scripts/zm/zm_tomb_utility;
#using scripts/zm/_zm_weap_staff_common;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;

#namespace zm_weap_staff_fire;

// Namespace zm_weap_staff_fire
// Params 0, eflags: 0x2
// Checksum 0xfc988dc9, Offset: 0x378
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_staff_fire", &__init__, undefined, undefined);
}

// Namespace zm_weap_staff_fire
// Params 0, eflags: 0x1 linked
// Checksum 0xeb75acf4, Offset: 0x3b8
// Size: 0x104
function __init__() {
    clientfield::register("actor", "fire_char_fx", 21000, 1, "int");
    clientfield::register("toplayer", "fire_muzzle_fx", 21000, 1, "counter");
    callback::on_spawned(&onplayerspawned);
    zm_spawner::register_zombie_damage_callback(&function_7effcb1f);
    zm_spawner::register_zombie_death_event_callback(&function_e1c5d52e);
    level.var_32bc7eba = getweapon("staff_fire");
    level.var_a7e44c35 = getweapon("staff_fire_upgraded");
}

// Namespace zm_weap_staff_fire
// Params 0, eflags: 0x1 linked
// Checksum 0x2b10fe23, Offset: 0x4c8
// Size: 0x54
function onplayerspawned() {
    self endon(#"disconnect");
    self thread function_db4f0c5c();
    self thread function_3ff00371();
    self thread zm_tomb_utility::function_56cd26ed();
}

// Namespace zm_weap_staff_fire
// Params 0, eflags: 0x1 linked
// Checksum 0x583592a9, Offset: 0x528
// Size: 0xd8
function function_3ff00371() {
    self notify(#"hash_6843d18");
    self endon(#"disconnect");
    self endon(#"hash_6843d18");
    while (true) {
        e_projectile, w_weapon = self waittill(#"missile_fire");
        if (isdefined(e_projectile.var_a7ef7139) && e_projectile.var_a7ef7139) {
            continue;
        }
        if (w_weapon.name == "staff_fire" || w_weapon.name == "staff_fire_upgraded") {
            self function_52ec8b27(w_weapon);
        }
    }
}

// Namespace zm_weap_staff_fire
// Params 0, eflags: 0x1 linked
// Checksum 0x610aea1a, Offset: 0x608
// Size: 0x108
function function_db4f0c5c() {
    self notify(#"hash_50ab9129");
    self endon(#"disconnect");
    self endon(#"hash_50ab9129");
    while (true) {
        e_projectile, w_weapon = self waittill(#"grenade_fire");
        if (isdefined(e_projectile.var_a7ef7139) && e_projectile.var_a7ef7139) {
            continue;
        }
        if (w_weapon.name == "staff_fire_upgraded2" || w_weapon.name == "staff_fire_upgraded3") {
            e_projectile thread function_4268f623();
            e_projectile thread function_f98583de(self, w_weapon);
            self function_29e0fee1(w_weapon);
        }
    }
}

// Namespace zm_weap_staff_fire
// Params 1, eflags: 0x1 linked
// Checksum 0xd89373ba, Offset: 0x718
// Size: 0x2d4
function function_52ec8b27(w_weapon) {
    self clientfield::increment_to_player("fire_muzzle_fx", 1);
    util::wait_network_frame();
    util::wait_network_frame();
    v_fwd = self getweaponforwarddir();
    fire_angles = vectortoangles(v_fwd);
    fire_origin = self getweaponmuzzlepoint();
    trace = bullettrace(fire_origin, fire_origin + v_fwd * 100, 0, undefined);
    if (trace["fraction"] != 1) {
        return;
    }
    var_d73cb6be = (fire_angles[0], fire_angles[1] - 15, fire_angles[2]);
    v_left = anglestoforward(var_d73cb6be);
    var_e40110b0 = magicbullet(w_weapon, fire_origin + v_fwd * 50, fire_origin + v_left * 100, self);
    var_e40110b0.var_a7ef7139 = 1;
    util::wait_network_frame();
    util::wait_network_frame();
    v_fwd = self getweaponforwarddir();
    fire_angles = vectortoangles(v_fwd);
    fire_origin = self getweaponmuzzlepoint();
    var_72130751 = (fire_angles[0], fire_angles[1] + 15, fire_angles[2]);
    v_right = anglestoforward(var_72130751);
    var_e40110b0 = magicbullet(w_weapon, fire_origin + v_fwd * 50, fire_origin + v_right * 100, self);
    var_e40110b0.var_a7ef7139 = 1;
}

// Namespace zm_weap_staff_fire
// Params 2, eflags: 0x1 linked
// Checksum 0xfc77509f, Offset: 0x9f8
// Size: 0x2b4
function function_f98583de(e_attacker, w_weapon) {
    v_pos = self waittill(#"explode");
    ent = spawn("script_origin", v_pos);
    ent playloopsound("wpn_firestaff_grenade_loop", 1);
    /#
        level thread zm_tomb_utility::function_5de0d079("<dev string:x28>", (255, 0, 0), v_pos, undefined, 5);
    #/
    var_17c602a5 = 5;
    aoe_radius = 80;
    if (w_weapon.name == "staff_fire_upgraded3") {
        aoe_radius = 100;
    }
    var_97057cde = 0.2;
    while (var_17c602a5 > 0) {
        if (var_17c602a5 - var_97057cde <= 0) {
            aoe_radius *= 2;
        }
        a_targets = getaiarray();
        a_targets = util::get_array_of_closest(v_pos, a_targets, undefined, undefined, aoe_radius);
        wait var_97057cde;
        var_17c602a5 -= var_97057cde;
        foreach (e_target in a_targets) {
            if (isdefined(e_target) && isalive(e_target)) {
                if (!(isdefined(e_target.is_on_fire) && e_target.is_on_fire)) {
                    e_target thread function_e571e237(w_weapon, e_attacker);
                }
            }
        }
    }
    ent playsound("wpn_firestaff_proj_impact");
    ent delete();
}

// Namespace zm_weap_staff_fire
// Params 0, eflags: 0x1 linked
// Checksum 0x1fcd6f55, Offset: 0xcb8
// Size: 0x6c
function function_3e4aaf36() {
    self endon(#"death");
    self endon(#"grenade_bounce");
    wait 0.5;
    do {
        prev_origin = self.origin;
        util::wait_network_frame();
        util::wait_network_frame();
    } while (prev_origin != self.origin);
}

// Namespace zm_weap_staff_fire
// Params 0, eflags: 0x1 linked
// Checksum 0x34f479a8, Offset: 0xd30
// Size: 0x54
function function_4268f623() {
    self endon(#"death");
    self function_3e4aaf36();
    self notify(#"hash_cb26a24c", self.origin);
    self resetmissiledetonationtime(0);
}

// Namespace zm_weap_staff_fire
// Params 1, eflags: 0x1 linked
// Checksum 0x49f26318, Offset: 0xd90
// Size: 0x256
function function_29e0fee1(w_weapon) {
    self endon(#"disconnect");
    self endon(#"weapon_change");
    n_shots = 1;
    if (w_weapon.name == "staff_fire_upgraded3") {
        n_shots = 2;
    }
    for (i = 1; i <= n_shots; i++) {
        wait 0.35;
        if (isdefined(self) && self getcurrentweapon() == level.var_a7e44c35) {
            v_player_angles = vectortoangles(self getweaponforwarddir());
            var_96d51930 = v_player_angles[0];
            var_96d51930 += 5 * i;
            var_6687f71f = v_player_angles[1] + randomfloatrange(-15, 15);
            var_c7248cf = (var_96d51930, var_6687f71f, v_player_angles[2]);
            var_2f3a8891 = self getweaponmuzzlepoint();
            var_e7741e8a = var_2f3a8891 + anglestoforward(var_c7248cf);
            var_e40110b0 = magicbullet(w_weapon, var_2f3a8891, var_e7741e8a, self);
            var_e40110b0.var_a7ef7139 = 1;
            var_e40110b0 thread function_4268f623();
            var_e40110b0 thread function_f98583de(self, w_weapon);
            self clientfield::increment_to_player("fire_muzzle_fx", 1);
        }
    }
}

// Namespace zm_weap_staff_fire
// Params 13, eflags: 0x1 linked
// Checksum 0x402bb281, Offset: 0xff0
// Size: 0xd4
function function_7effcb1f(mod, hit_location, var_8a2b6fe5, player, amount, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
    if (self function_81557bff(self.damageweapon) && mod != "MOD_MELEE") {
        self thread function_1e34975d(mod, self.damageweapon, player, amount);
        return true;
    }
    return false;
}

// Namespace zm_weap_staff_fire
// Params 1, eflags: 0x1 linked
// Checksum 0x288fa6d1, Offset: 0x10d0
// Size: 0x98
function function_81557bff(weapon) {
    return (weapon.name == "staff_fire" || weapon.name == "staff_fire_upgraded" || weapon.name == "staff_fire_upgraded2" || isdefined(weapon) && weapon.name == "staff_fire_upgraded3") && !(isdefined(self.var_6fb1ac4a) && self.var_6fb1ac4a);
}

// Namespace zm_weap_staff_fire
// Params 4, eflags: 0x1 linked
// Checksum 0x78e7f6c1, Offset: 0x1170
// Size: 0x104
function function_1e34975d(mod, damageweapon, player, amount) {
    player endon(#"disconnect");
    if (!isalive(self)) {
        return;
    }
    if (mod != "MOD_BURNED" && mod != "MOD_GRENADE_SPLASH") {
        var_70416937 = (amount - 1) / 10;
        var_ca8e270a = 0.5 + 0.5 * var_70416937;
        if (isdefined(self.is_mechz) && self.is_mechz) {
            self thread function_d1aaab68(damageweapon, player, var_ca8e270a);
            return;
        }
        self thread function_e571e237(damageweapon, player, var_ca8e270a);
    }
}

// Namespace zm_weap_staff_fire
// Params 1, eflags: 0x1 linked
// Checksum 0xae97007a, Offset: 0x1280
// Size: 0x9c
function function_e1c5d52e(attacker) {
    if (function_81557bff(self.damageweapon) && self.damagemod != "MOD_MELEE") {
        self.var_1339189a = 1;
        self clientfield::set("fire_char_fx", 1);
        self thread function_50814f21(1);
        self thread zombie_utility::zombie_eye_glow_stop();
    }
}

// Namespace zm_weap_staff_fire
// Params 1, eflags: 0x1 linked
// Checksum 0x1e4297be, Offset: 0x1328
// Size: 0x36
function on_fire_timeout(n_duration) {
    self endon(#"death");
    wait n_duration;
    self.is_on_fire = 0;
    self notify(#"stop_flame_damage");
}

// Namespace zm_weap_staff_fire
// Params 3, eflags: 0x1 linked
// Checksum 0x7a8c7bea, Offset: 0x1368
// Size: 0x21c
function function_e571e237(damageweapon, e_attacker, var_ca8e270a) {
    if (!isdefined(var_ca8e270a)) {
        var_ca8e270a = 1;
    }
    var_93eb1403 = isdefined(self.is_on_fire) && self.is_on_fire;
    var_ea7e78d5 = function_4b513520(damageweapon) * var_ca8e270a;
    is_upgraded = damageweapon.name == "staff_fire_upgraded" || damageweapon.name == "staff_fire_upgraded2" || damageweapon.name == "staff_fire_upgraded3";
    if (is_upgraded && var_ca8e270a > 0.5 && var_ea7e78d5 > self.health && math::cointoss()) {
        self zm_tomb_utility::function_2f31684b(e_attacker, self.health, damageweapon, "MOD_BURNED");
        if (math::cointoss()) {
            self thread zm_tomb_utility::function_8a97fd20();
            return;
        }
        self thread zm_tomb_utility::function_cc964a18();
        return;
    }
    self endon(#"death");
    if (!var_93eb1403) {
        self.is_on_fire = 1;
        self thread function_55d1c405();
        wait 0.5;
        self thread function_cb3b7cb9(e_attacker, damageweapon, var_ca8e270a);
    }
    if (var_ea7e78d5 > 0) {
        self zm_tomb_utility::function_2f31684b(e_attacker, var_ea7e78d5, damageweapon, "MOD_BURNED");
    }
}

// Namespace zm_weap_staff_fire
// Params 2, eflags: 0x1 linked
// Checksum 0xea2694fa, Offset: 0x1590
// Size: 0x68
function function_d396e2c(do_stun, var_2d8e64d3) {
    if (!isalive(self)) {
        return;
    }
    if (!(isdefined(self.missinglegs) && self.missinglegs)) {
        self zombie_utility::set_zombie_run_cycle(var_2d8e64d3);
    }
    self.var_262d5062 = do_stun;
}

// Namespace zm_weap_staff_fire
// Params 0, eflags: 0x1 linked
// Checksum 0xf84305e0, Offset: 0x1600
// Size: 0x174
function function_55d1c405() {
    if (!isalive(self)) {
        return;
    }
    if (isdefined(self.is_mechz) && self.is_mechz) {
        return;
    }
    self clientfield::set("fire_char_fx", 1);
    self thread function_50814f21(1);
    self.var_9bdf0e65 = 1;
    var_e0d2c53 = self.zombie_move_speed;
    if (!(isdefined(self.missinglegs) && self.missinglegs)) {
        self.deathanim = "zm_death_fire";
    }
    if (self.ai_state == "find_flesh") {
        self.ignoremelee = 1;
        self function_d396e2c(1, "burned");
    }
    self waittill(#"stop_flame_damage");
    self.deathanim = undefined;
    self.var_9bdf0e65 = undefined;
    if (self.ai_state == "find_flesh") {
        self.ignoremelee = undefined;
        self function_d396e2c(0, var_e0d2c53);
    }
    self clientfield::set("fire_char_fx", 0);
}

// Namespace zm_weap_staff_fire
// Params 1, eflags: 0x1 linked
// Checksum 0xd146d702, Offset: 0x1780
// Size: 0x50
function function_4b513520(damageweapon) {
    str_name = damageweapon.name;
    switch (str_name) {
    case "staff_fire":
        return 2050;
    case "staff_fire_upgraded":
        return 3300;
    case "staff_fire_upgraded2":
        return 11500;
    case "staff_fire_upgraded3":
        return 20000;
    case "one_inch_punch_fire":
        return 0;
    default:
        return 0;
    }
}

// Namespace zm_weap_staff_fire
// Params 1, eflags: 0x1 linked
// Checksum 0x61eb51b7, Offset: 0x1818
// Size: 0x56
function function_42fcae3c(damageweapon) {
    str_name = damageweapon.name;
    switch (str_name) {
    case "staff_fire":
        return 75;
    case "staff_fire_upgraded":
        return -106;
    case "staff_fire_upgraded2":
        return 300;
    case "staff_fire_upgraded3":
        return 450;
    case "one_inch_punch_fire":
        return -6;
    default:
        return self.health;
    }
}

// Namespace zm_weap_staff_fire
// Params 1, eflags: 0x1 linked
// Checksum 0xe0f6bb4, Offset: 0x18b0
// Size: 0x54
function function_5ede48b0(damageweapon) {
    str_name = damageweapon.name;
    switch (str_name) {
    case "staff_fire":
        return 8;
    case "staff_fire_upgraded":
        return 8;
    case "staff_fire_upgraded2":
        return 8;
    case "staff_fire_upgraded3":
        return 8;
    case "one_inch_punch_fire":
        return 8;
    default:
        return 8;
    }
}

// Namespace zm_weap_staff_fire
// Params 3, eflags: 0x1 linked
// Checksum 0xae1688d9, Offset: 0x1948
// Size: 0x130
function function_cb3b7cb9(e_attacker, damageweapon, var_ca8e270a) {
    e_attacker endon(#"disconnect");
    self endon(#"death");
    self endon(#"stop_flame_damage");
    n_damage = function_42fcae3c(damageweapon);
    n_duration = function_5ede48b0(damageweapon);
    n_damage *= var_ca8e270a;
    self thread on_fire_timeout(n_duration);
    while (true) {
        if (isdefined(e_attacker) && isplayer(e_attacker)) {
            if (e_attacker zm_powerups::is_insta_kill_active()) {
                n_damage = self.health;
            }
        }
        self zm_tomb_utility::function_2f31684b(e_attacker, n_damage, damageweapon, "MOD_BURNED");
        wait 1;
    }
}

// Namespace zm_weap_staff_fire
// Params 3, eflags: 0x1 linked
// Checksum 0x3949c6ae, Offset: 0x1a80
// Size: 0x7c
function function_d1aaab68(damageweapon, e_attacker, var_ca8e270a) {
    self endon(#"death");
    var_ea7e78d5 = function_4b513520(damageweapon);
    if (var_ea7e78d5 > 0) {
        self zm_tomb_utility::function_2f31684b(e_attacker, var_ea7e78d5, damageweapon, "MOD_BURNED");
    }
}

// Namespace zm_weap_staff_fire
// Params 0, eflags: 0x0
// Checksum 0xd62c5cf1, Offset: 0x1b08
// Size: 0x94
function function_f59d7b4e() {
    var_e0d020c4 = spawn("script_origin", (0, 0, 0));
    var_e0d020c4.origin = self.origin;
    var_e0d020c4.angles = self.angles;
    self linkto(var_e0d020c4);
    self waittill(#"death");
    var_e0d020c4 delete();
}

// Namespace zm_weap_staff_fire
// Params 1, eflags: 0x1 linked
// Checksum 0x54b5971c, Offset: 0x1ba8
// Size: 0x2e6
function function_50814f21(is_on_fire) {
    if (self.archetype !== "zombie") {
        return;
    }
    if (is_on_fire && !issubstr(self.model, "_fire")) {
        self.no_gib = 1;
        if (!isdefined(self.old_model)) {
            self.old_model = self.model;
            self.var_f08c601 = self.head;
            self.var_7cff9f25 = self.hatmodel;
        }
        self setmodel(self.old_model + "_fire");
        if (isdefined(self.var_f08c601) && !(isdefined(self.head_gibbed) && self.head_gibbed)) {
            self detach(self.head);
            self attach(self.var_f08c601 + "_fire");
            self.head = self.var_f08c601 + "_fire";
        }
        if (isdefined(self.var_7cff9f25) && !(isdefined(self.hat_gibbed) && self.hat_gibbed)) {
            self detach(self.hatmodel);
            self attach(self.var_7cff9f25 + "_fire");
            self.hatmodel = self.var_7cff9f25 + "_fire";
        }
        return;
    }
    if (!is_on_fire && isdefined(self.old_model)) {
        self.no_gib = undefined;
        self setmodel(self.old_model);
        self.old_model = undefined;
        if (isdefined(self.var_f08c601) && !(isdefined(self.head_gibbed) && self.head_gibbed)) {
            self detach(self.head);
            self attach(self.var_f08c601);
            self.var_f08c601 = undefined;
        }
        if (isdefined(self.var_7cff9f25) && !(isdefined(self.hat_gibbed) && self.hat_gibbed)) {
            self detach(self.hatmodel);
            self attach(self.var_7cff9f25);
            self.var_7cff9f25 = undefined;
        }
    }
}

