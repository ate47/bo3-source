#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/sound_shared;
#using scripts/shared/system_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm_utility;

#using_animtree("zombie_cymbal_monkey");

#namespace _zm_weap_nesting_dolls;

// Namespace _zm_weap_nesting_dolls
// Params 0, eflags: 0x2
// Checksum 0x96bdbfe8, Offset: 0x380
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_weap_nesting_dolls", &__init__, undefined, undefined);
}

// Namespace _zm_weap_nesting_dolls
// Params 0, eflags: 0x0
// Checksum 0x93bc3f30, Offset: 0x3c0
// Size: 0x14c
function __init__() {
    level.w_nesting_dolls = getweapon("nesting_dolls");
    level.var_3a1d655b = getweapon("nesting_dolls_single");
    level.var_4cd1cc40 = 500;
    level.var_6e0ba488 = 45;
    level.var_f483f127 = 10000;
    level.var_a2b87344 = 0.25;
    level.var_c7ce5820 = cos(22.5);
    level.var_58ffdf1b = -76;
    gravity = getdvarfloat("bg_gravity");
    level.var_ea1cfe92 = level.var_4cd1cc40 * sin(level.var_6e0ba488) / abs(gravity) * 0.5;
    level.var_db1bba6e = 10;
    /#
        level.var_c1f3b949 = &function_f2e5f766;
    #/
    function_51c28247();
}

// Namespace _zm_weap_nesting_dolls
// Params 0, eflags: 0x0
// Checksum 0xabc3154b, Offset: 0x518
// Size: 0x2b0
function function_51c28247() {
    if (isdefined(level.var_fd27be9f)) {
        [[ level.var_fd27be9f ]]();
        return;
    }
    level._effect["nesting_doll_trail_blue"] = "dlc5/zmb_weapon/fx_zmb_trail_doll_blue";
    level._effect["nesting_doll_trail_green"] = "dlc5/zmb_weapon/fx_zmb_trail_doll_green";
    level._effect["nesting_doll_trail_red"] = "dlc5/zmb_weapon/fx_zmb_trail_doll_red";
    level._effect["nesting_doll_trail_yellow"] = "dlc5/zmb_weapon/fx_zmb_trail_doll_yellow";
    level.var_7379c29d = [];
    level.var_7379c29d[0] = spawnstruct();
    level.var_7379c29d[0].name = "dempsey";
    level.var_7379c29d[0].id = 127;
    level.var_7379c29d[0].trailfx = level._effect["nesting_doll_trail_blue"];
    level.var_7379c29d[1] = spawnstruct();
    level.var_7379c29d[1].name = "nikolai";
    level.var_7379c29d[1].id = -128;
    level.var_7379c29d[1].trailfx = level._effect["nesting_doll_trail_red"];
    level.var_7379c29d[2] = spawnstruct();
    level.var_7379c29d[2].name = "takeo";
    level.var_7379c29d[2].id = -126;
    level.var_7379c29d[2].trailfx = level._effect["nesting_doll_trail_green"];
    level.var_7379c29d[3] = spawnstruct();
    level.var_7379c29d[3].name = "richtofen";
    level.var_7379c29d[3].id = -127;
    level.var_7379c29d[3].trailfx = level._effect["nesting_doll_trail_yellow"];
}

// Namespace _zm_weap_nesting_dolls
// Params 0, eflags: 0x0
// Checksum 0x14483b93, Offset: 0x7d0
// Size: 0x16
function function_c025a1a5() {
    return isdefined(level.zombie_weapons["nesting_dolls"]);
}

// Namespace _zm_weap_nesting_dolls
// Params 0, eflags: 0x0
// Checksum 0x22da1dca, Offset: 0x7f0
// Size: 0x114
function function_f2e5f766() {
    self function_f4b4582d(0);
    var_1c3c9c82 = level.var_7379c29d[self.var_295a50c4[0][0]].id;
    weapon_options = self calcweaponoptions(var_1c3c9c82, 0, 0);
    if (self hasweapon(level.w_nesting_dolls)) {
        self updateweaponoptions(level.w_nesting_dolls, weapon_options);
    } else {
        self giveweapon(level.w_nesting_dolls, weapon_options);
    }
    self zm_utility::set_player_tactical_grenade(level.w_nesting_dolls);
    self thread function_6831d7();
}

// Namespace _zm_weap_nesting_dolls
// Params 0, eflags: 0x0
// Checksum 0x2ac1d21, Offset: 0x910
// Size: 0xb0
function function_6831d7() {
    self notify(#"hash_c3d84139");
    self endon(#"disconnect");
    self endon(#"hash_c3d84139");
    while (true) {
        grenade = function_cf5a6be4();
        if (isdefined(grenade)) {
            if (self laststand::player_is_in_laststand()) {
                grenade delete();
                continue;
            }
            self thread function_8bfa63a0(grenade);
        }
        wait 0.05;
    }
}

// Namespace _zm_weap_nesting_dolls
// Params 1, eflags: 0x0
// Checksum 0x10dcd8a3, Offset: 0x9c8
// Size: 0x1ce
function function_7c8b687(var_b8d1d71c) {
    self endon(#"disconnect");
    self endon(#"death");
    var_cf19c9e8 = 1;
    var_523515f2 = 4;
    self function_38be5ec1();
    self thread function_92b451d9();
    if (isdefined(var_b8d1d71c)) {
        var_b8d1d71c function_1499b9a4(self.var_b1cb3746, 0, self);
        var_b8d1d71c thread function_88994d32(self, self.var_b1cb3746, 0);
    }
    while (var_cf19c9e8 < var_523515f2) {
        self waittill(#"hash_e78f395e", origin, angles);
        var_f77662c1 = self get_launch_velocity(origin, 2000);
        if (var_f77662c1 == (0, 0, 0)) {
            var_f77662c1 = self function_e20585d3(origin, angles);
        }
        grenade = self magicgrenadetype(level.var_3a1d655b, origin, var_f77662c1);
        grenade function_1499b9a4(self.var_b1cb3746, var_cf19c9e8, self);
        grenade thread function_88994d32(self, self.var_b1cb3746, var_cf19c9e8);
        var_cf19c9e8++;
    }
}

// Namespace _zm_weap_nesting_dolls
// Params 1, eflags: 0x0
// Checksum 0xb452be0a, Offset: 0xba0
// Size: 0x208
function function_8bfa63a0(var_b8d1d71c) {
    self endon(#"disconnect");
    self endon(#"death");
    var_cf19c9e8 = 1;
    var_523515f2 = 4;
    self function_38be5ec1();
    self thread function_92b451d9();
    self thread function_f1cbce42(self.var_b1cb3746);
    self thread function_553c8cdb(self.var_b1cb3746);
    if (isdefined(var_b8d1d71c)) {
        var_b8d1d71c function_1499b9a4(self.var_b1cb3746, 0, self);
        var_b8d1d71c thread function_88994d32(self, self.var_b1cb3746, 0);
    }
    self waittill(#"hash_e78f395e", origin, angles);
    while (var_cf19c9e8 < var_523515f2) {
        var_f77662c1 = self function_58267558(angles, var_cf19c9e8);
        grenade = self magicgrenadetype(level.var_3a1d655b, origin, var_f77662c1);
        grenade function_1499b9a4(self.var_b1cb3746, var_cf19c9e8, self);
        grenade playsound("wpn_nesting_pop_npc");
        grenade thread function_88994d32(self, self.var_b1cb3746, var_cf19c9e8);
        var_cf19c9e8++;
        wait 0.25;
    }
}

// Namespace _zm_weap_nesting_dolls
// Params 4, eflags: 0x0
// Checksum 0x3df22e63, Offset: 0xdb0
// Size: 0x184
function function_e29d07ea(origin, owner, id, index) {
    self waittill(#"explode");
    zombies = zombie_utility::get_round_enemy_array();
    if (zombies.size == 0) {
        return;
    }
    var_45e7db0a = util::get_array_of_closest(origin, zombies, undefined, undefined, level.var_58ffdf1b);
    for (i = 0; i < var_45e7db0a.size; i++) {
        if (isalive(var_45e7db0a[i])) {
            if (var_45e7db0a[i] damageconetrace(origin, owner) == 1) {
                owner.var_2f6526f3[id][index] = owner.var_2f6526f3[id][index] + 1;
            }
        }
    }
    radiusdamage(origin, level.var_58ffdf1b, 95000, 95000, owner, "MOD_GRENADE_SPLASH", level.var_3a1d655b);
}

// Namespace _zm_weap_nesting_dolls
// Params 1, eflags: 0x0
// Checksum 0x2d9219b1, Offset: 0xf40
// Size: 0x8e
function function_2d17c595(angles) {
    random_yaw = randomintrange(-45, 45);
    var_aea0696b = randomintrange(-45, -35);
    random = (var_aea0696b, random_yaw, 0);
    var_4de4242e = angles + random;
    return var_4de4242e;
}

// Namespace _zm_weap_nesting_dolls
// Params 2, eflags: 0x0
// Checksum 0x6993eae4, Offset: 0xfd8
// Size: 0x114
function function_e20585d3(var_af0b25f3, angles) {
    angles = function_2d17c595(angles);
    trace_dist = level.var_4cd1cc40 * level.var_ea1cfe92;
    for (i = 0; i < 4; i++) {
        dir = anglestoforward(angles);
        if (bullettracepassed(var_af0b25f3, var_af0b25f3 + dir * trace_dist, 0, undefined)) {
            var_f77662c1 = dir * level.var_4cd1cc40;
            return var_f77662c1;
        }
        angles += (0, 90, 0);
    }
    return (0, 0, level.var_4cd1cc40);
}

// Namespace _zm_weap_nesting_dolls
// Params 2, eflags: 0x0
// Checksum 0x84f2cdea, Offset: 0x10f8
// Size: 0xc6
function function_58267558(angles, index) {
    var_aea0696b = randomintrange(-45, -35);
    offsets = array(45, 0, -45);
    angles += (var_aea0696b, offsets[index - 1], 0);
    dir = anglestoforward(angles);
    var_f77662c1 = dir * level.var_4cd1cc40;
    return var_f77662c1;
}

// Namespace _zm_weap_nesting_dolls
// Params 2, eflags: 0x0
// Checksum 0x4f696a79, Offset: 0x11c8
// Size: 0x106
function get_launch_velocity(var_af0b25f3, range) {
    velocity = (0, 0, 0);
    target = function_11d2fdaa(var_af0b25f3, range);
    if (isdefined(target)) {
        target_origin = target function_df2f3669();
        dir = vectortoangles(target_origin - var_af0b25f3);
        dir = (dir[0] - level.var_6e0ba488, dir[1], dir[2]);
        dir = anglestoforward(dir);
        velocity = dir * level.var_4cd1cc40;
    }
    return velocity;
}

// Namespace _zm_weap_nesting_dolls
// Params 0, eflags: 0x0
// Checksum 0x470943d5, Offset: 0x12d8
// Size: 0x1c
function function_df2f3669() {
    position = self.origin;
    return position;
}

// Namespace _zm_weap_nesting_dolls
// Params 3, eflags: 0x0
// Checksum 0x82d293df, Offset: 0x1300
// Size: 0x1b4
function function_1499b9a4(id, index, parent) {
    self hide();
    self.var_96967264 = spawn("script_model", self.origin);
    var_7bdf50dc = parent.var_295a50c4[id][index];
    name = level.var_7379c29d[var_7bdf50dc].name;
    model_index = index + 1;
    model_name = "wpn_t7_zmb_hd_nesting_dolls_" + name + "_doll" + model_index + "_world";
    self.var_96967264 setmodel(model_name);
    self.var_96967264 useanimtree(#zombie_cymbal_monkey);
    self.var_96967264 linkto(self);
    self.var_96967264.angles = self.angles;
    self.var_96967264 thread function_23b41a73(self);
    wait 0.1;
    playfxontag(level.var_7379c29d[var_7bdf50dc].trailfx, self.var_96967264, "tag_origin");
}

// Namespace _zm_weap_nesting_dolls
// Params 3, eflags: 0x0
// Checksum 0xdee34d19, Offset: 0x14c0
// Size: 0x184
function function_88994d32(parent, var_b1cb3746, index) {
    var_b7b39fb0 = 100000000;
    for (oldpos = self.origin; var_b7b39fb0 != 0; oldpos = self.origin) {
        wait 0.1;
        if (!isdefined(self)) {
            break;
        }
        var_b7b39fb0 = distancesquared(self.origin, oldpos);
    }
    if (isdefined(self)) {
        self.var_96967264 unlink();
        self.var_96967264.origin = self.origin;
        self.var_96967264.angles = self.angles;
        parent notify(#"hash_e78f395e", self.origin, self.angles);
        self thread function_e29d07ea(self.origin, parent, var_b1cb3746, index);
        self resetmissiledetonationtime(level.var_a2b87344);
        if (isdefined(index) && index == 3) {
            parent thread function_49591ea0(var_b1cb3746);
        }
    }
}

// Namespace _zm_weap_nesting_dolls
// Params 1, eflags: 0x0
// Checksum 0x836615aa, Offset: 0x1650
// Size: 0x30
function function_49591ea0(var_b1cb3746) {
    wait level.var_a2b87344 + 0.1;
    self notify("end_achievement_tracker" + var_b1cb3746);
}

// Namespace _zm_weap_nesting_dolls
// Params 1, eflags: 0x0
// Checksum 0x72dcc9c7, Offset: 0x1688
// Size: 0x296
function function_6485d610(range) {
    view_pos = self getweaponmuzzlepoint();
    zombies = util::get_array_of_closest(view_pos, zombie_utility::get_round_enemy_array(), undefined, undefined, range * 1.1);
    if (!isdefined(zombies)) {
        return;
    }
    range_squared = range * range;
    forward_view_angles = self getweaponforwarddir();
    end_pos = view_pos + vectorscale(forward_view_angles, range);
    best_dot = -999;
    best_target = undefined;
    for (i = 0; i < zombies.size; i++) {
        if (!isdefined(zombies[i]) || !isalive(zombies[i])) {
            continue;
        }
        test_origin = zombies[i] getcentroid();
        test_range_squared = distancesquared(view_pos, test_origin);
        if (test_range_squared > range_squared) {
            return;
        }
        normal = vectornormalize(test_origin - view_pos);
        dot = vectordot(forward_view_angles, normal);
        if (dot < 0) {
            continue;
        }
        if (dot < level.var_c7ce5820) {
            continue;
        }
        if (0 == zombies[i] damageconetrace(view_pos, self)) {
            continue;
        }
        if (dot > best_dot) {
            best_dot = dot;
            best_target = zombies[i];
        }
    }
    /#
    #/
    return best_target;
}

// Namespace _zm_weap_nesting_dolls
// Params 2, eflags: 0x0
// Checksum 0x8e42a65, Offset: 0x1928
// Size: 0x126
function function_11d2fdaa(origin, range) {
    zombies = getaiarray(level.zombie_team);
    if (zombies.size > 0) {
        var_45e7db0a = util::get_array_of_closest(origin, zombies, undefined, undefined, range);
        for (i = 0; i < var_45e7db0a.size; i++) {
            if (isdefined(var_45e7db0a[i]) && isalive(var_45e7db0a[i])) {
                centroid = var_45e7db0a[i] getcentroid();
                if (bullettracepassed(origin, centroid, 0, undefined)) {
                    return var_45e7db0a[i];
                }
            }
        }
    }
    return undefined;
}

// Namespace _zm_weap_nesting_dolls
// Params 1, eflags: 0x0
// Checksum 0x1ad87a5c, Offset: 0x1a58
// Size: 0x44
function function_23b41a73(parent) {
    while (true) {
        if (!isdefined(parent)) {
            zm_utility::self_delete();
            return;
        }
        wait 0.05;
    }
}

// Namespace _zm_weap_nesting_dolls
// Params 2, eflags: 0x0
// Checksum 0x74312b56, Offset: 0x1aa8
// Size: 0x7e
function function_aa44140a(model, info) {
    monk_scream_vox = 0;
    if (level.var_5738e0e5 == 0) {
        monk_scream_vox = 0;
        self playsound("zmb_monkey_song");
    }
    self waittill(#"explode", position);
    if (isdefined(model)) {
    }
    if (monk_scream_vox) {
    }
}

// Namespace _zm_weap_nesting_dolls
// Params 0, eflags: 0x0
// Checksum 0x1772a031, Offset: 0x1b30
// Size: 0x6c
function function_cf5a6be4() {
    self endon(#"disconnect");
    self endon(#"hash_c3d84139");
    while (true) {
        self waittill(#"grenade_fire", grenade, weapon);
        if (weapon == level.w_nesting_dolls) {
            return grenade;
        }
        wait 0.05;
    }
}

/#

    // Namespace _zm_weap_nesting_dolls
    // Params 2, eflags: 0x0
    // Checksum 0xac58e4b0, Offset: 0x1ba8
    // Size: 0x6c
    function function_ed6a01ce(msg, color) {
        if (!isdefined(color)) {
            color = (1, 1, 1);
        }
        print3d(self.origin + (0, 0, 60), msg, color, 1, 1, 40);
    }

#/

// Namespace _zm_weap_nesting_dolls
// Params 0, eflags: 0x0
// Checksum 0x2ccba0bd, Offset: 0x1c20
// Size: 0x54
function function_38be5ec1() {
    if (!isdefined(self.var_b1cb3746)) {
        self.var_b1cb3746 = 0;
        return;
    }
    self.var_b1cb3746 += 1;
    if (self.var_b1cb3746 >= level.var_db1bba6e) {
        self.var_b1cb3746 = 0;
    }
}

// Namespace _zm_weap_nesting_dolls
// Params 1, eflags: 0x0
// Checksum 0x85970470, Offset: 0x1c80
// Size: 0xa6
function function_f1cbce42(var_b1cb3746) {
    self endon("end_achievement_tracker" + var_b1cb3746);
    if (!isdefined(self.var_2f6526f3)) {
        self.var_2f6526f3 = [];
        for (i = 0; i < level.var_db1bba6e; i++) {
            self.var_2f6526f3[i] = [];
        }
    }
    for (i = 0; i < 4; i++) {
        self.var_2f6526f3[var_b1cb3746][i] = 0;
    }
}

// Namespace _zm_weap_nesting_dolls
// Params 1, eflags: 0x0
// Checksum 0x145525f6, Offset: 0x1d30
// Size: 0x78
function function_553c8cdb(var_b1cb3746) {
    self waittill("end_achievement_tracker" + var_b1cb3746);
    var_d704b2c3 = 1;
    for (i = 0; i < 4; i++) {
        if (self.var_2f6526f3[var_b1cb3746][i] < var_d704b2c3) {
            return;
        }
    }
}

// Namespace _zm_weap_nesting_dolls
// Params 1, eflags: 0x0
// Checksum 0x1396ab39, Offset: 0x1db0
// Size: 0x72
function function_f4b4582d(id) {
    if (!isdefined(self.var_295a50c4)) {
        self.var_295a50c4 = [];
    }
    var_7b2bee5c = array(0, 1, 2, 3);
    self.var_295a50c4[id] = array::randomize(var_7b2bee5c);
}

// Namespace _zm_weap_nesting_dolls
// Params 0, eflags: 0x0
// Checksum 0xc0252611, Offset: 0x1e30
// Size: 0xfc
function function_92b451d9() {
    self endon(#"death");
    self endon(#"disconnect");
    wait 0.5;
    var_10601dca = self.var_b1cb3746 + 1;
    if (var_10601dca >= level.var_db1bba6e) {
        var_10601dca = 0;
    }
    self function_f4b4582d(var_10601dca);
    if (self hasweapon(level.w_nesting_dolls)) {
        var_22cf119e = level.var_7379c29d[self.var_295a50c4[var_10601dca][0]].id;
        self updateweaponoptions(level.w_nesting_dolls, self calcweaponoptions(var_22cf119e, 0, 0));
    }
}

