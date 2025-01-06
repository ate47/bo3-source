#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_weap_staff_common;
#using scripts/zm/zm_tomb_utility;

#namespace zm_weap_staff_water;

// Namespace zm_weap_staff_water
// Params 0, eflags: 0x2
// Checksum 0xa6809fff, Offset: 0x4e0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_weap_staff_water", &__init__, undefined, undefined);
}

// Namespace zm_weap_staff_water
// Params 0, eflags: 0x0
// Checksum 0x25c708a2, Offset: 0x520
// Size: 0x1bc
function __init__() {
    level._effect["staff_water_blizzard"] = "weapon/zmb_staff/fx_zmb_staff_ice_ug_impact_hit";
    level._effect["staff_water_ice_shard"] = "weapon/zmb_staff/fx_zmb_staff_ice_trail_bolt";
    level._effect["staff_water_shatter"] = "weapon/zmb_staff/fx_zmb_staff_ice_exp";
    clientfield::register("scriptmover", "staff_blizzard_fx", 21000, 1, "int");
    clientfield::register("actor", "anim_rate", 21000, 2, "float");
    clientfield::register("actor", "attach_bullet_model", 21000, 1, "int");
    clientfield::register("actor", "staff_shatter_fx", 21000, 1, "int");
    callback::on_spawned(&onplayerspawned);
    level flag::init("blizzard_active");
    function_1e12cf34();
    level thread function_3d54156b();
    zm_spawner::register_zombie_death_event_callback(&function_b8850763);
    zm_spawner::add_custom_zombie_spawn_logic(&function_6380f3f7);
}

// Namespace zm_weap_staff_water
// Params 0, eflags: 0x0
// Checksum 0xa3c2d227, Offset: 0x6e8
// Size: 0xb2
function function_1e12cf34() {
    level.var_c2b9ea5a = [];
    level.var_c2b9ea5a[0] = "j_hip_le";
    level.var_c2b9ea5a[1] = "j_hip_ri";
    level.var_c2b9ea5a[2] = "j_spine4";
    level.var_c2b9ea5a[3] = "j_elbow_le";
    level.var_c2b9ea5a[4] = "j_elbow_ri";
    level.var_c2b9ea5a[5] = "j_clavicle_le";
    level.var_c2b9ea5a[6] = "j_clavicle_ri";
}

// Namespace zm_weap_staff_water
// Params 0, eflags: 0x0
// Checksum 0x2daed048, Offset: 0x7a8
// Size: 0x128
function function_3d54156b() {
    while (true) {
        a_grenades = getentarray("grenade", "classname");
        foreach (e_grenade in a_grenades) {
            if (isdefined(e_grenade.model) && e_grenade.model == "p6_zm_tm_staff_projectile_ice") {
                time = gettime();
                if (time - e_grenade.birthtime >= 1000) {
                    e_grenade delete();
                }
            }
        }
        wait 0.1;
    }
}

// Namespace zm_weap_staff_water
// Params 0, eflags: 0x0
// Checksum 0xff122f09, Offset: 0x8d8
// Size: 0x54
function onplayerspawned() {
    self endon(#"disconnect");
    self thread function_26edb358();
    self thread function_790d29ee();
    self thread zm_tomb_utility::function_56cd26ed();
}

// Namespace zm_weap_staff_water
// Params 0, eflags: 0x0
// Checksum 0xeddc2381, Offset: 0x938
// Size: 0xf0
function function_26edb358() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"missile_fire", e_projectile, str_weapon);
        if (str_weapon.name == "staff_water" || str_weapon.name == "staff_water_upgraded") {
            util::wait_network_frame();
            function_14e3beba(str_weapon);
            util::wait_network_frame();
            function_14e3beba(str_weapon);
            util::wait_network_frame();
            function_14e3beba(str_weapon);
        }
    }
}

// Namespace zm_weap_staff_water
// Params 0, eflags: 0x0
// Checksum 0x95d559a5, Offset: 0xa30
// Size: 0xf8
function function_790d29ee() {
    self endon(#"disconnect");
    while (true) {
        self waittill(#"projectile_impact", str_weapon, var_836ef144, n_radius, str_name, var_94351942);
        if (str_weapon.name == "staff_water_upgraded2" || str_weapon.name == "staff_water_upgraded3") {
            n_lifetime = 6;
            if (str_weapon.name == "staff_water_upgraded3") {
                n_lifetime = 9;
            }
            self thread function_ab71df6f(var_836ef144, n_lifetime, str_weapon);
        }
    }
}

// Namespace zm_weap_staff_water
// Params 2, eflags: 0x0
// Checksum 0x4cda01ea, Offset: 0xb30
// Size: 0xcc
function function_4baca731(player, str_weapon) {
    self freeze_zombie();
    self zm_tomb_utility::function_2f31684b(player, self.health, str_weapon, "MOD_RIFLE_BULLET");
    if (isdefined(self.deathanim)) {
        self waittillmatch(#"death_anim", "shatter");
    }
    if (isdefined(self)) {
        self thread function_6799822a();
    }
    player zm_score::player_add_points("death", "", "");
}

// Namespace zm_weap_staff_water
// Params 0, eflags: 0x0
// Checksum 0xe4be0919, Offset: 0xc08
// Size: 0x28
function freeze_zombie() {
    if (isdefined(self.is_mechz) && self.is_mechz) {
        return;
    }
    self.var_93022f09 = 1;
}

// Namespace zm_weap_staff_water
// Params 2, eflags: 0x0
// Checksum 0xf3657466, Offset: 0xc38
// Size: 0x34
function function_f2c9d08c(fx, v_origin) {
    playfx(fx, v_origin, (0, 0, 1), (1, 0, 0));
}

// Namespace zm_weap_staff_water
// Params 4, eflags: 0x0
// Checksum 0x2a996fd4, Offset: 0xc78
// Size: 0x64
function function_85b9ab21(id, max, fx, v_origin) {
    zm_net::network_safe_init(id, max);
    zm_net::network_choke_action(id, &function_f2c9d08c, fx, v_origin);
}

// Namespace zm_weap_staff_water
// Params 0, eflags: 0x0
// Checksum 0xcf59b722, Offset: 0xce8
// Size: 0xc4
function function_6799822a() {
    if (isdefined(self.is_mechz) && self.is_mechz) {
        return;
    }
    if (isdefined(self)) {
        if (true) {
            v_fx = self gettagorigin("J_SpineLower");
            level thread function_85b9ab21("frozen_shatter", 2, level._effect["staff_water_shatter"], v_fx);
            self thread function_e0c68997("normal");
            return;
        }
        self startragdoll();
    }
}

// Namespace zm_weap_staff_water
// Params 1, eflags: 0x0
// Checksum 0xc5e8ff03, Offset: 0xdb8
// Size: 0x8c
function function_e0c68997(var_c7875b84) {
    var_a833a2d8 = [];
    var_a833a2d8[var_a833a2d8.size] = level._zombie_gib_piece_index_all;
    self gib(var_c7875b84, var_a833a2d8);
    self ghost();
    wait 0.4;
    if (isdefined(self)) {
        self delete();
    }
}

// Namespace zm_weap_staff_water
// Params 3, eflags: 0x0
// Checksum 0xfe5293d9, Offset: 0xe50
// Size: 0x1ec
function function_ab71df6f(var_177e8ec4, var_64a5f747, str_weapon) {
    self endon(#"disconnect");
    if (isdefined(var_177e8ec4)) {
        level notify(#"hash_afaf158e");
        e_fx = spawn("script_model", var_177e8ec4 + (0, 0, 33));
        e_fx setmodel("tag_origin");
        e_fx clientfield::set("staff_blizzard_fx", 1);
        e_fx thread zm_tomb_utility::function_5de0d079("X", (0, 64, -1));
        wait 1;
        level flag::set("blizzard_active");
        e_fx thread function_27dea370(self, str_weapon);
        e_fx thread zm_tomb_utility::function_8b1b140c("blizzard_active");
        e_fx thread function_8f634b9a(var_64a5f747);
        e_fx thread function_43b7d930();
        e_fx waittill(#"hash_93c9265d");
        level flag::clear("blizzard_active");
        e_fx notify(#"stop_debug_position");
        wait 0.1;
        e_fx clientfield::set("staff_blizzard_fx", 0);
        wait 0.1;
        e_fx delete();
    }
}

// Namespace zm_weap_staff_water
// Params 2, eflags: 0x0
// Checksum 0xc1437ce4, Offset: 0x1048
// Size: 0x1a8
function function_27dea370(player, str_weapon) {
    player endon(#"disconnect");
    self endon(#"hash_93c9265d");
    while (true) {
        a_zombies = getaiarray();
        foreach (zombie in a_zombies) {
            if (!(isdefined(zombie.var_fa9f3027) && zombie.var_fa9f3027)) {
                if (distancesquared(self.origin, zombie.origin) <= 30625) {
                    if (isdefined(zombie.is_mechz) && zombie.is_mechz) {
                        zombie thread function_c94ef6a4(player, 1);
                        continue;
                    }
                    if (isalive(zombie)) {
                        zombie thread function_e5197b5b(str_weapon, player, 1);
                    }
                }
            }
        }
        wait 0.1;
    }
}

// Namespace zm_weap_staff_water
// Params 1, eflags: 0x0
// Checksum 0x7607e544, Offset: 0x11f8
// Size: 0x36
function function_8f634b9a(n_time) {
    self endon(#"death");
    self endon(#"hash_93c9265d");
    wait n_time;
    self notify(#"hash_93c9265d");
}

// Namespace zm_weap_staff_water
// Params 0, eflags: 0x0
// Checksum 0x71a531c0, Offset: 0x1238
// Size: 0x36
function function_43b7d930() {
    self endon(#"death");
    self endon(#"hash_93c9265d");
    level waittill(#"hash_afaf158e");
    self notify(#"hash_93c9265d");
}

// Namespace zm_weap_staff_water
// Params 1, eflags: 0x0
// Checksum 0xc943b665, Offset: 0x1278
// Size: 0x7a
function function_f30d345e(n_charge) {
    switch (n_charge) {
    case 0:
    case 1:
        n_range = 250000;
        break;
    case 2:
        n_range = 640000;
        break;
    case 3:
        n_range = 1000000;
        break;
    }
    return n_range;
}

// Namespace zm_weap_staff_water
// Params 2, eflags: 0x0
// Checksum 0x29e8de8f, Offset: 0x1300
// Size: 0x16c
function function_821042a0(v_source, n_range) {
    a_enemies = [];
    a_zombies = getaiarray();
    a_zombies = util::get_array_of_closest(v_source, a_zombies);
    if (isdefined(a_zombies)) {
        for (i = 0; i < a_zombies.size; i++) {
            if (!isdefined(a_zombies[i])) {
                continue;
            }
            var_76dbd021 = a_zombies[i] gettagorigin("j_head");
            if (distancesquared(v_source, var_76dbd021) > n_range) {
                continue;
            }
            if (!zm_tomb_utility::bullet_trace_throttled(v_source, var_76dbd021, undefined)) {
                continue;
            }
            if (isdefined(a_zombies[i]) && isalive(a_zombies[i])) {
                a_enemies[a_enemies.size] = a_zombies[i];
            }
        }
    }
    return a_enemies;
}

// Namespace zm_weap_staff_water
// Params 1, eflags: 0x0
// Checksum 0x2b0d4b32, Offset: 0x1478
// Size: 0x7c
function function_61c85f8e(weapon) {
    return (weapon.name == "staff_water" || weapon.name == "staff_water_upgraded" || isdefined(weapon) && weapon.name == "staff_water_fake_dart_zm") && !(isdefined(self.var_6fb1ac4a) && self.var_6fb1ac4a);
}

// Namespace zm_weap_staff_water
// Params 2, eflags: 0x0
// Checksum 0x3c21a1d9, Offset: 0x1500
// Size: 0xb0
function function_c94ef6a4(e_player, is_upgraded) {
    if (isdefined(self.var_fa9f3027) && self.var_fa9f3027) {
        return;
    }
    self.var_fa9f3027 = 1;
    if (is_upgraded) {
        self zm_tomb_utility::function_2f31684b(e_player, 3300, "staff_water_upgraded", "MOD_RIFLE_BULLET");
    } else {
        self zm_tomb_utility::function_2f31684b(e_player, 2050, "staff_water", "MOD_RIFLE_BULLET");
    }
    wait 1;
    self.var_fa9f3027 = 0;
}

// Namespace zm_weap_staff_water
// Params 4, eflags: 0x0
// Checksum 0x4eba9401, Offset: 0x15b8
// Size: 0x358
function function_e5197b5b(str_weapon, e_player, var_3c756289, n_mod) {
    if (!isdefined(str_weapon)) {
        str_weapon = "staff_water";
    }
    if (!isdefined(var_3c756289)) {
        var_3c756289 = 0;
    }
    if (!isdefined(n_mod)) {
        n_mod = 1;
    }
    self endon(#"death");
    instakill_on = e_player zm_powerups::is_insta_kill_active();
    if (str_weapon.name == "staff_water") {
        n_damage = 2050;
    } else if (str_weapon.name == "staff_water_upgraded" || str_weapon.name == "staff_water_upgraded2" || str_weapon.name == "staff_water_upgraded3") {
        n_damage = 3300;
    } else if (str_weapon.name == "one_inch_punch_ice") {
        n_damage = 11275;
    }
    if (isdefined(self.var_fa9f3027) && self.var_fa9f3027) {
        return;
    }
    self.var_fa9f3027 = 1;
    self clientfield::set("attach_bullet_model", 1);
    self thread function_de3654ba(1);
    n_speed = 0.3;
    self asmsetanimationrate(0.3);
    if (instakill_on || var_3c756289) {
        wait randomfloatrange(0.5, 0.7);
    } else {
        wait randomfloatrange(1.8, 2.3);
    }
    if (self.health < n_damage || instakill_on || var_3c756289) {
        self asmsetanimationrate(1);
        util::wait_network_frame();
        if (str_weapon.name != "one_inch_punch_ice") {
            function_4baca731(e_player, str_weapon);
        }
        return;
    }
    self zm_tomb_utility::function_2f31684b(e_player, n_damage, str_weapon, "MOD_RIFLE_BULLET");
    self.deathanim = undefined;
    self clientfield::set("attach_bullet_model", 0);
    wait 0.5;
    self thread function_de3654ba(0);
    self asmsetanimationrate(1);
    self.var_fa9f3027 = 0;
}

// Namespace zm_weap_staff_water
// Params 1, eflags: 0x0
// Checksum 0xd299af7e, Offset: 0x1918
// Size: 0x108
function function_857db15e(n_speed) {
    self clientfield::set("anim_rate", n_speed);
    n_rate = self clientfield::get("anim_rate");
    self setentityanimrate(n_rate);
    if (n_speed != 1) {
        self.var_56361fb5 = 1;
    }
    util::wait_network_frame();
    if (!(isdefined(self.is_traversing) && self.is_traversing)) {
        self.needs_run_update = 1;
        self notify(#"needs_run_update");
    }
    util::wait_network_frame();
    if (n_speed == 1) {
        self.var_56361fb5 = 0;
    }
}

// Namespace zm_weap_staff_water
// Params 0, eflags: 0x0
// Checksum 0x87550cc, Offset: 0x1a28
// Size: 0x6c
function function_6380f3f7() {
    self clientfield::set("anim_rate", 1);
    n_rate = self clientfield::get("anim_rate");
    self setentityanimrate(n_rate);
}

// Namespace zm_weap_staff_water
// Params 1, eflags: 0x0
// Checksum 0x5b2bcc29, Offset: 0x1aa0
// Size: 0xa4
function function_b8850763(attacker) {
    if (function_61c85f8e(self.damageweapon) && self.damagemod != "MOD_MELEE") {
        self.no_gib = 1;
        self.nodeathragdoll = 1;
        self freeze_zombie();
        if (isdefined(self.deathanim)) {
            self waittillmatch(#"death_anim", "shatter");
        }
        self thread function_6799822a();
    }
}

// Namespace zm_weap_staff_water
// Params 1, eflags: 0x0
// Checksum 0x60c23c50, Offset: 0x1b50
// Size: 0x33c
function function_14e3beba(str_weapon) {
    is_upgraded = str_weapon.name == "staff_water_upgraded";
    fire_angles = self getplayerangles();
    fire_origin = self getplayercamerapos();
    a_targets = getaiarray();
    a_targets = util::get_array_of_closest(self.origin, a_targets, undefined, undefined, 600);
    foreach (target in a_targets) {
        if (isdefined(target.var_fa9f3027) && target.var_fa9f3027) {
            continue;
        }
        if (util::within_fov(fire_origin, fire_angles, target gettagorigin("j_spine4"), cos(25))) {
            if (isai(target)) {
                a_tags = [];
                a_tags[0] = "j_hip_le";
                a_tags[1] = "j_hip_ri";
                a_tags[2] = "j_spine4";
                a_tags[3] = "j_elbow_le";
                a_tags[4] = "j_elbow_ri";
                a_tags[5] = "j_clavicle_le";
                a_tags[6] = "j_clavicle_ri";
                str_tag = a_tags[randomint(a_tags.size)];
                b_trace_pass = zm_tomb_utility::bullet_trace_throttled(fire_origin, target gettagorigin(str_tag), target);
                if (b_trace_pass && isdefined(target) && isalive(target)) {
                    if (isdefined(target.is_mechz) && target.is_mechz) {
                        target thread function_c94ef6a4(self, is_upgraded);
                        return;
                    }
                    target thread function_e5197b5b(str_weapon, self);
                    return;
                }
            }
        }
    }
}

// Namespace zm_weap_staff_water
// Params 1, eflags: 0x0
// Checksum 0x4928f32d, Offset: 0x1e98
// Size: 0xa6
function function_180ee7b2(n_spread) {
    n_x = randomintrange(n_spread * -1, n_spread);
    n_y = randomintrange(n_spread * -1, n_spread);
    n_z = randomintrange(n_spread * -1, n_spread);
    return (n_x, n_y, n_z);
}

// Namespace zm_weap_staff_water
// Params 1, eflags: 0x0
// Checksum 0xe3310b6, Offset: 0x1f48
// Size: 0x2e6
function function_de3654ba(var_4c13b45a) {
    if (self.archetype !== "zombie") {
        return;
    }
    if (var_4c13b45a && !issubstr(self.model, "_ice")) {
        self.no_gib = 1;
        if (!isdefined(self.old_model)) {
            self.old_model = self.model;
            self.var_f08c601 = self.head;
            self.var_7cff9f25 = self.hatmodel;
        }
        self setmodel(self.old_model + "_ice");
        if (isdefined(self.var_f08c601) && !(isdefined(self.head_gibbed) && self.head_gibbed)) {
            self detach(self.head);
            self attach(self.var_f08c601 + "_ice");
            self.head = self.var_f08c601 + "_ice";
        }
        if (isdefined(self.var_7cff9f25) && !(isdefined(self.hat_gibbed) && self.hat_gibbed)) {
            self detach(self.hatmodel);
            self attach(self.var_7cff9f25 + "_ice");
            self.hatmodel = self.var_7cff9f25 + "_ice";
        }
        return;
    }
    if (!var_4c13b45a && isdefined(self.old_model)) {
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

