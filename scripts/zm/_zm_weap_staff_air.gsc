#using scripts/zm/zm_tomb_utility;
#using scripts/zm/_zm_weap_staff_common;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_audio;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;

#namespace namespace_589e3c80;

// Namespace namespace_589e3c80
// Params 0, eflags: 0x2
// Checksum 0xa3f2b770, Offset: 0x410
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_staff_air", &__init__, undefined, undefined);
}

// Namespace namespace_589e3c80
// Params 0, eflags: 0x1 linked
// Checksum 0xf1bfe87d, Offset: 0x450
// Size: 0x16c
function __init__() {
    level._effect["whirlwind"] = "weapon/zmb_staff/fx_zmb_staff_air_ug_impact_miss";
    clientfield::register("scriptmover", "whirlwind_play_fx", 21000, 1, "int");
    clientfield::register("actor", "air_staff_launch", 21000, 1, "int");
    clientfield::register("allplayers", "air_staff_source", 21000, 1, "int");
    callback::on_spawned(&onplayerspawned);
    level flag::init("whirlwind_active");
    zm_spawner::register_zombie_damage_callback(&function_86f6d957);
    zm_spawner::register_zombie_death_event_callback(&function_7f4d75d6);
    level.var_3481edfa = getweapon("staff_air");
    level.var_7830b075 = getweapon("staff_air_upgraded");
}

// Namespace namespace_589e3c80
// Params 0, eflags: 0x1 linked
// Checksum 0xb7c64e83, Offset: 0x5c8
// Size: 0x54
function onplayerspawned() {
    self endon(#"disconnect");
    self thread function_bb5cccb1();
    self thread function_218c2881();
    self thread namespace_d7c0ce12::function_56cd26ed();
}

// Namespace namespace_589e3c80
// Params 0, eflags: 0x1 linked
// Checksum 0x1e14aef2, Offset: 0x628
// Size: 0x2c
function function_19db306f() {
    self endon(#"death");
    wait(0.75);
    self delete();
}

// Namespace namespace_589e3c80
// Params 0, eflags: 0x1 linked
// Checksum 0x9b3f49f1, Offset: 0x660
// Size: 0xf8
function function_bb5cccb1() {
    self endon(#"disconnect");
    while (true) {
        e_projectile, w_weapon = self waittill(#"missile_fire");
        if (w_weapon.name == "staff_air_upgraded" || w_weapon.name == "staff_air") {
            e_projectile thread function_19db306f();
            function_98105149(w_weapon);
            self clientfield::set("air_staff_source", 1);
            util::wait_network_frame();
            self clientfield::set("air_staff_source", 0);
        }
    }
}

// Namespace namespace_589e3c80
// Params 0, eflags: 0x1 linked
// Checksum 0xce57585e, Offset: 0x760
// Size: 0xb0
function function_218c2881() {
    self endon(#"disconnect");
    while (true) {
        w_weapon, var_836ef144, n_radius, projectile = self waittill(#"projectile_impact");
        if (w_weapon.name == "staff_air_upgraded2" || w_weapon.name == "staff_air_upgraded3") {
            self thread function_aa83447e(var_836ef144, w_weapon);
        }
    }
}

// Namespace namespace_589e3c80
// Params 2, eflags: 0x1 linked
// Checksum 0xaa8ca3d7, Offset: 0x818
// Size: 0x184
function function_aa83447e(var_177e8ec4, w_weapon) {
    self endon(#"disconnect");
    if (!isdefined(var_177e8ec4)) {
        return;
    }
    a_zombies = getaiarray();
    a_zombies = util::get_array_of_closest(var_177e8ec4, a_zombies);
    if (a_zombies.size) {
        for (i = 0; i < a_zombies.size; i++) {
            if (isalive(a_zombies[i])) {
                if (isdefined(a_zombies[i].var_4a343f93) && a_zombies[i].var_4a343f93) {
                    continue;
                }
                if (distance2dsquared(var_177e8ec4, a_zombies[i].origin) <= 10000) {
                    self thread function_1ef3ceaf(a_zombies[0], w_weapon);
                    return;
                }
                self thread function_a1828a0e(var_177e8ec4, w_weapon);
                return;
            }
        }
        return;
    }
    self thread function_a1828a0e(var_177e8ec4, w_weapon);
}

// Namespace namespace_589e3c80
// Params 2, eflags: 0x1 linked
// Checksum 0xff8d0695, Offset: 0x9a8
// Size: 0xac
function function_1ef3ceaf(ai_zombie, w_weapon) {
    self endon(#"disconnect");
    ai_zombie.var_4a343f93 = 1;
    ai_zombie.var_33cf0f73 = 1;
    var_3b8de789 = ai_zombie.origin;
    self thread function_a1828a0e(var_3b8de789, w_weapon);
    if (!isdefined(ai_zombie.is_mechz)) {
        self thread function_bfa0fd24(ai_zombie);
    }
}

// Namespace namespace_589e3c80
// Params 2, eflags: 0x1 linked
// Checksum 0xdb61b19e, Offset: 0xa60
// Size: 0x23c
function function_a1828a0e(var_177e8ec4, w_weapon) {
    self endon(#"disconnect");
    if (!isdefined(var_177e8ec4)) {
        return;
    }
    if (level flag::get("whirlwind_active")) {
        level notify(#"hash_4bd80403");
        while (level flag::get("whirlwind_active")) {
            util::wait_network_frame();
        }
        wait(0.3);
    }
    level flag::set("whirlwind_active");
    n_time = self.chargeshotlevel * 3.5;
    var_5c96fe71 = spawn("script_model", var_177e8ec4 + (0, 0, 100));
    var_5c96fe71 setmodel("tag_origin");
    var_5c96fe71.angles = (-90, 0, 0);
    var_5c96fe71 thread namespace_d7c0ce12::function_5de0d079("X", (255, 255, 0));
    var_5c96fe71 moveto(zm_utility::groundpos_ignore_water_new(var_5c96fe71.origin), 0.05);
    var_5c96fe71 waittill(#"movedone");
    var_5c96fe71 clientfield::set("whirlwind_play_fx", 1);
    var_5c96fe71 thread namespace_d7c0ce12::function_8b1b140c("whirlwind_active");
    var_5c96fe71 thread function_27d095f1(n_time);
    wait(0.5);
    var_5c96fe71.player_owner = self;
    var_5c96fe71 thread function_54fe3f04(self.chargeshotlevel, w_weapon);
}

// Namespace namespace_589e3c80
// Params 2, eflags: 0x1 linked
// Checksum 0x654a88d6, Offset: 0xca8
// Size: 0xbc
function function_54fe3f04(n_level, w_weapon) {
    self endon(#"death");
    self.var_aacc71a8 = 0;
    n_range = function_bcea9293(n_level);
    while (true) {
        a_zombies = function_c2723cff(self.origin, n_range);
        if (a_zombies.size) {
            self.var_aacc71a8 = 1;
            self thread function_6491e52c(n_level, w_weapon);
            break;
        }
        wait(0.1);
    }
}

// Namespace namespace_589e3c80
// Params 1, eflags: 0x1 linked
// Checksum 0xbec17c94, Offset: 0xd70
// Size: 0xac
function function_27d095f1(n_time) {
    self endon(#"death");
    level util::waittill_any_timeout(n_time, "whirlwind_stopped");
    level notify(#"hash_4bd80403");
    self clientfield::set("whirlwind_play_fx", 0);
    self notify(#"stop_debug_position");
    level flag::clear("whirlwind_active");
    wait(1.5);
    self delete();
}

// Namespace namespace_589e3c80
// Params 2, eflags: 0x1 linked
// Checksum 0x69bcfa69, Offset: 0xe28
// Size: 0xac
function function_fcbb4f0(v_position, n_time) {
    v_diff = vectornormalize(v_position - self.origin);
    var_b8c2a0 = self.origin + v_diff * 50 + (0, 0, 50);
    v_ground = zm_utility::groundpos_ignore_water_new(var_b8c2a0);
    self moveto(v_ground, n_time);
}

// Namespace namespace_589e3c80
// Params 2, eflags: 0x1 linked
// Checksum 0x8bd63839, Offset: 0xee0
// Size: 0x2c8
function function_6491e52c(n_level, w_weapon) {
    self endon(#"death");
    n_range = function_bcea9293(n_level);
    self.n_charge_level = n_level;
    while (true) {
        a_zombies = function_c2723cff(self.origin, n_range);
        a_zombies = util::get_array_of_closest(self.origin, a_zombies);
        for (i = 0; i < a_zombies.size; i++) {
            if (!isdefined(a_zombies[i])) {
                continue;
            }
            if (!(isdefined(a_zombies[i].completed_emerging_into_playable_area) && a_zombies[i].completed_emerging_into_playable_area)) {
                continue;
            }
            if (isdefined(a_zombies[i].is_mechz) && a_zombies[i].is_mechz) {
                continue;
            }
            if (isdefined(self.var_8acb86fc) && self.var_8acb86fc) {
                continue;
            }
            v_offset = (10, 10, 32);
            if (!namespace_d7c0ce12::bullet_trace_throttled(self.origin + v_offset, a_zombies[i].origin + v_offset, undefined)) {
                continue;
            }
            if (!isdefined(a_zombies[i]) || !isalive(a_zombies[i])) {
                continue;
            }
            v_offset = (-10, -10, 64);
            if (!namespace_d7c0ce12::bullet_trace_throttled(self.origin + v_offset, a_zombies[i].origin + v_offset, undefined)) {
                continue;
            }
            if (!isdefined(a_zombies[i]) || !isalive(a_zombies[i])) {
                continue;
            }
            a_zombies[i] thread function_94d27f4f(self, w_weapon);
            wait(0.5);
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_589e3c80
// Params 2, eflags: 0x1 linked
// Checksum 0x9e4f41fc, Offset: 0x11b0
// Size: 0xcc
function function_94d27f4f(var_5c96fe71, w_weapon) {
    if (isdefined(self.var_e0d020c4)) {
        return;
    }
    self function_693d397c(var_5c96fe71);
    if (isdefined(self) && isdefined(var_5c96fe71) && level flag::get("whirlwind_active")) {
        player = var_5c96fe71.player_owner;
        self namespace_d7c0ce12::function_2f31684b(player, self.health, w_weapon, "MOD_IMPACT");
        level thread function_4bec2567(self);
    }
}

// Namespace namespace_589e3c80
// Params 1, eflags: 0x1 linked
// Checksum 0x93d1df45, Offset: 0x1288
// Size: 0x234
function function_693d397c(var_5c96fe71) {
    if (isdefined(self.var_e0d020c4)) {
        return;
    }
    self.var_e0d020c4 = spawn("script_origin", (0, 0, 0));
    self.var_e0d020c4.origin = self.origin;
    self.var_e0d020c4.angles = self.angles;
    self linkto(self.var_e0d020c4);
    self thread function_d3e3534d(var_5c96fe71);
    if (isdefined(var_5c96fe71)) {
        n_dist_sq = distance2dsquared(var_5c96fe71.origin, self.origin);
    }
    n_fling_range_sq = 900;
    while (isalive(self) && n_dist_sq > n_fling_range_sq && isdefined(var_5c96fe71) && level flag::get("whirlwind_active")) {
        n_dist_sq = distance2dsquared(var_5c96fe71.origin, self.origin);
        var_edb2490f = var_5c96fe71.n_charge_level == 3;
        self thread function_c5c33b11(var_5c96fe71.origin, var_edb2490f);
        n_movetime = 1;
        if (var_edb2490f) {
            n_movetime = 0.8;
        }
        self.var_e0d020c4 thread function_fcbb4f0(var_5c96fe71.origin, n_movetime);
        wait(0.05);
    }
    self notify(#"hash_466d5186");
    self.var_e0d020c4 delete();
}

// Namespace namespace_589e3c80
// Params 1, eflags: 0x1 linked
// Checksum 0xd89fdcb, Offset: 0x14c8
// Size: 0x3c
function function_d3e3534d(var_5c96fe71) {
    self endon(#"death");
    var_5c96fe71 waittill(#"death");
    self unlink();
}

// Namespace namespace_589e3c80
// Params 1, eflags: 0x1 linked
// Checksum 0x9e794768, Offset: 0x1510
// Size: 0xf4
function function_bfa0fd24(ai_zombie) {
    self endon(#"disconnect");
    n_range = function_bcea9293(self.chargeshotlevel);
    tag = "J_SpineUpper";
    if (ai_zombie.isdog) {
        tag = "J_Spine1";
    }
    v_source = ai_zombie gettagorigin(tag);
    ai_zombie thread function_5bc03d0(self);
    a_zombies = function_c2723cff(v_source, n_range);
    if (!isdefined(a_zombies)) {
        return;
    }
    self thread function_70088ca5(a_zombies);
}

// Namespace namespace_589e3c80
// Params 1, eflags: 0x1 linked
// Checksum 0xea0eef7f, Offset: 0x1610
// Size: 0x56
function function_bcea9293(n_charge) {
    switch (n_charge) {
    case 1:
        n_range = 100;
        break;
    default:
        n_range = -6;
        break;
    }
    return n_range;
}

// Namespace namespace_589e3c80
// Params 1, eflags: 0x1 linked
// Checksum 0xd6295f9c, Offset: 0x1670
// Size: 0x8e
function function_70088ca5(a_zombies) {
    self endon(#"disconnect");
    if (!isdefined(a_zombies)) {
        return;
    }
    for (i = 0; i < a_zombies.size; i++) {
        if (isalive(a_zombies[i])) {
            a_zombies[i] thread function_5bc03d0(self);
            wait(0.05);
        }
    }
}

// Namespace namespace_589e3c80
// Params 2, eflags: 0x1 linked
// Checksum 0x63312265, Offset: 0x1708
// Size: 0x15e
function function_c2723cff(v_source, n_range) {
    a_enemies = [];
    a_zombies = getaiarray();
    a_zombies = util::get_array_of_closest(v_source, a_zombies);
    n_range_sq = n_range * n_range;
    if (isdefined(a_zombies)) {
        for (i = 0; i < a_zombies.size; i++) {
            if (!isdefined(a_zombies[i])) {
                continue;
            }
            var_76dbd021 = a_zombies[i].origin;
            if (isdefined(a_zombies[i].var_4a343f93) && a_zombies[i].var_4a343f93 == 1) {
                continue;
            }
            if (distancesquared(v_source, var_76dbd021) > n_range_sq) {
                continue;
            }
            a_enemies[a_enemies.size] = a_zombies[i];
        }
    }
    return a_enemies;
}

// Namespace namespace_589e3c80
// Params 1, eflags: 0x1 linked
// Checksum 0xfbe45639, Offset: 0x1870
// Size: 0xbc
function function_5bc03d0(player) {
    player endon(#"disconnect");
    if (!isalive(self)) {
        return;
    }
    if (isdefined(self.var_33cf0f73) || math::cointoss()) {
        self thread function_46fb33db(player, level.var_7830b075);
        return;
    }
    self namespace_d7c0ce12::function_2f31684b(player, self.health, level.var_7830b075, "MOD_IMPACT");
    level thread function_4bec2567(self);
}

// Namespace namespace_589e3c80
// Params 2, eflags: 0x1 linked
// Checksum 0x2a57743e, Offset: 0x1938
// Size: 0xcc
function function_46fb33db(e_attacker, w_weapon) {
    self namespace_d7c0ce12::function_2f31684b(e_attacker, self.health, w_weapon, "MOD_IMPACT");
    if (isdefined(level.var_cfba6d83) && ![[ level.var_cfba6d83 ]]()) {
        level thread function_4bec2567(self);
        return;
    }
    if (isdefined(self.is_mechz) && self.is_mechz) {
        return;
    }
    self startragdoll();
    self clientfield::set("air_staff_launch", 1);
}

// Namespace namespace_589e3c80
// Params 2, eflags: 0x0
// Checksum 0x5007a274, Offset: 0x1a10
// Size: 0x8c
function function_6f04e424(e_attacker, ai_target) {
    v_launch = vectornormalize(ai_target.origin - e_attacker.origin) * randomintrange(125, -106) + (0, 0, randomintrange(75, -106));
    return v_launch;
}

// Namespace namespace_589e3c80
// Params 1, eflags: 0x1 linked
// Checksum 0xedb8979f, Offset: 0x1aa8
// Size: 0x4c
function function_4bec2567(ai_zombie) {
    if (math::cointoss()) {
        ai_zombie thread namespace_d7c0ce12::function_8a97fd20();
    }
    ai_zombie thread namespace_d7c0ce12::function_cc964a18();
}

// Namespace namespace_589e3c80
// Params 13, eflags: 0x1 linked
// Checksum 0xcf913ab6, Offset: 0x1b00
// Size: 0xbc
function function_86f6d957(mod, hit_location, var_8a2b6fe5, player, amount, weapon, direction_vec, tagname, modelname, partname, dflags, inflictor, chargelevel) {
    if (self function_3837465d(self.damageweapon) && mod != "MOD_MELEE") {
        self thread stun_zombie();
        return true;
    }
    return false;
}

// Namespace namespace_589e3c80
// Params 1, eflags: 0x1 linked
// Checksum 0xe2520e72, Offset: 0x1bc8
// Size: 0x60
function function_3837465d(weapon) {
    return (weapon.name == "staff_air" || isdefined(weapon) && weapon.name == "staff_air_upgraded") && !(isdefined(self.var_6fb1ac4a) && self.var_6fb1ac4a);
}

// Namespace namespace_589e3c80
// Params 1, eflags: 0x1 linked
// Checksum 0x622dc4f3, Offset: 0x1c30
// Size: 0xdc
function function_7f4d75d6(attacker) {
    if (function_3837465d(self.damageweapon) && self.damagemod != "MOD_MELEE") {
        if (isdefined(self.is_mechz) && self.is_mechz) {
            return;
        }
        self thread zombie_utility::zombie_eye_glow_stop();
        if (isdefined(level.var_cfba6d83) && ![[ level.var_cfba6d83 ]]()) {
            level thread function_4bec2567(self);
            return;
        }
        self startragdoll();
        self clientfield::set("air_staff_launch", 1);
    }
}

// Namespace namespace_589e3c80
// Params 1, eflags: 0x1 linked
// Checksum 0x7072f67a, Offset: 0x1d18
// Size: 0x212
function function_98105149(w_weapon) {
    fire_angles = self getplayerangles();
    fire_origin = self getplayercamerapos();
    a_targets = getaiarray();
    a_targets = util::get_array_of_closest(self.origin, a_targets, undefined, 12, 400);
    if (w_weapon.name == "staff_air_upgraded") {
        n_damage = 3300;
        var_199c7fe5 = 60;
    } else {
        n_damage = 2050;
        var_199c7fe5 = 45;
    }
    foreach (target in a_targets) {
        if (isai(target)) {
            if (util::within_fov(fire_origin, fire_angles, target gettagorigin("j_spine4"), cos(var_199c7fe5))) {
                if (self zm_powerups::is_insta_kill_active()) {
                    n_damage = target.health;
                }
                target namespace_d7c0ce12::function_2f31684b(self, n_damage, w_weapon, "MOD_IMPACT");
            }
        }
    }
}

// Namespace namespace_589e3c80
// Params 0, eflags: 0x1 linked
// Checksum 0x7a6f27bb, Offset: 0x1f38
// Size: 0xf8
function stun_zombie() {
    self endon(#"death");
    if (isdefined(self.is_mechz) && self.is_mechz) {
        return;
    }
    if (isdefined(self.is_electrocuted) && self.is_electrocuted) {
        return;
    }
    if (!isdefined(self.ai_state) || self.ai_state != "find_flesh") {
        return;
    }
    self.var_c61e3943 = 1;
    self.ignoreall = 1;
    self.is_electrocuted = 1;
    tag = "J_SpineUpper";
    if (self.isdog) {
        tag = "J_Spine1";
    }
    self zombie_shared::donotetracks("stunned");
    self.var_c61e3943 = 0;
    self.ignoreall = 0;
    self.is_electrocuted = 0;
}

// Namespace namespace_589e3c80
// Params 0, eflags: 0x1 linked
// Checksum 0x62b57c7c, Offset: 0x2038
// Size: 0x70
function function_c037051e() {
    self endon(#"death");
    while (level flag::get("whirlwind_active")) {
        util::wait_network_frame();
    }
    self.deathanim = undefined;
    self stopanimscripted();
    self.var_8acb86fc = 0;
}

// Namespace namespace_589e3c80
// Params 2, eflags: 0x1 linked
// Checksum 0xbc0feea6, Offset: 0x20b0
// Size: 0x1e0
function function_c5c33b11(var_2f3b20a8, var_2fedcecc) {
    if (!isdefined(var_2fedcecc)) {
        var_2fedcecc = 0;
    }
    self endon(#"death");
    level endon(#"hash_4bd80403");
    if (isdefined(self.var_8acb86fc) && self.var_8acb86fc) {
        return;
    }
    var_f1f294c8 = vectortoangles(var_2f3b20a8 - self.origin);
    var_e1460d03 = vectortoangles(self.origin - var_2f3b20a8);
    self.a.var_36ccf63e = 0.9;
    if (!(isdefined(self.missinglegs) && self.missinglegs)) {
        self.var_14b13709 = 1;
    } else {
        self.var_14b13709 = 0;
    }
    if (var_2fedcecc) {
        blackboard::setblackboardattribute(self, "_whirlwind_speed", "whirlwind_fast");
    } else {
        blackboard::setblackboardattribute(self, "_whirlwind_speed", "whirlwind_normal");
    }
    if (isdefined(self.nogravity) && self.nogravity) {
        self animmode("none");
        self.nogravity = undefined;
    }
    self.var_8acb86fc = 1;
    self.a.var_36ccf63e = self.var_4d88c921;
    self thread function_c037051e();
    self waittill(#"hash_466d5186");
}

