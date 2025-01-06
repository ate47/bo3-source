#using scripts/codescripts/struct;
#using scripts/cp/doa/_doa_dev;
#using scripts/cp/doa/_doa_fx;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_score;
#using scripts/cp/doa/_doa_sfx;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#using_animtree("critter");

#namespace namespace_5e6c5d1f;

// Namespace namespace_5e6c5d1f
// Params 1, eflags: 0x0
// Checksum 0x34411106, Offset: 0x5e0
// Size: 0x289
function function_cdfa9ce8(bird) {
    bird notify(#"hash_cf62504");
    bird endon(#"hash_cf62504");
    bird endon(#"death");
    bird useanimtree(#critter);
    curanim = critter%a_chicken_react_up_down;
    lastanim = critter%a_chicken_idle_peck;
    bird thread namespace_1a381543::function_90118d8c("zmb_dblshot_squawk");
    while (isdefined(bird)) {
        if (randomint(100) > 15) {
            bird thread namespace_1a381543::function_90118d8c("zmb_dblshot_squawk");
        }
        if (isdefined(self.var_3424aae1) && self.var_3424aae1) {
            curanim = critter%a_chicken_react_up_down;
            bird thread namespace_1a381543::function_90118d8c("zmb_dblshot_squawk");
        } else if (isdefined(self.var_a732885d) && self.var_a732885d) {
            curanim = critter%a_chicken_react_up_down;
            bird thread namespace_1a381543::function_90118d8c("zmb_dblshot_squawk");
        } else if (isdefined(self.var_7d36ff94) && self.var_7d36ff94) {
            curanim = critter%a_chicken_react_up_down;
            self.var_7d36ff94 = undefined;
            bird thread namespace_1a381543::function_90118d8c("zmb_dblshot_squawk");
        } else if (isdefined(self.var_efa2b784) && self.var_efa2b784) {
            curanim = critter%a_chicken_react_to_front_notrans;
        } else if (isdefined(self.is_moving) && self.is_moving) {
            curanim = critter%a_chicken_run;
        }
        bird animscripted("chicken_anim", bird.origin, bird.angles, curanim);
        animlength = getanimlength(curanim);
        wait animlength;
        lastanim = curanim;
        switch (randomint(3)) {
        case 0:
            curanim = critter%a_chicken_idle_peck;
            break;
        case 1:
            curanim = critter%a_chicken_idle_a;
            break;
        case 2:
            curanim = critter%a_chicken_idle;
            break;
        }
    }
}

// Namespace namespace_5e6c5d1f
// Params 4, eflags: 0x0
// Checksum 0x59d493b3, Offset: 0x878
// Size: 0x44a
function add_a_chicken(model, scale, var_c34952ed, var_5c667593) {
    if (!isdefined(self.doa)) {
        return;
    }
    if (!mayspawnentity()) {
        return;
    }
    orb = spawn("script_model", self.origin + (0, 0, 50));
    orb.targetname = "add_a_chicken";
    orb setmodel("tag_origin");
    orb enablelinkto();
    orb notsolid();
    bird = spawn("script_model", orb.origin);
    bird.targetname = "chicken";
    bird setmodel(model);
    bird linkto(orb, "tag_origin");
    bird notsolid();
    orb.basescale = scale;
    bird setscale(scale);
    orb.bird = bird;
    bird.orb = orb;
    orb.player = self;
    orb.owner = self;
    orb.team = self.team;
    orb.special = var_c34952ed;
    orb.var_cdf31c46 = 0;
    orb.var_fe6ede28 = 0;
    orb.var_947e1f34 = self.doa.var_3cdd8203.size == 0 ? self : self.doa.var_3cdd8203[self.doa.var_3cdd8203.size - 1];
    orb enablelinkto();
    orb thread function_cdfa9ce8(bird);
    if (isdefined(orb.special) && orb.special && self.doa.var_3cdd8203.size > 0) {
        arrayinsert(self.doa.var_3cdd8203, orb, 0);
        var_bd097d49 = self;
        foreach (chicken in self.doa.var_3cdd8203) {
            chicken.var_947e1f34 = var_bd097d49;
            var_bd097d49 = chicken;
        }
    } else {
        self.doa.var_3cdd8203[self.doa.var_3cdd8203.size] = orb;
    }
    if (self.doa.var_3cdd8203.size > getdvarint("scr_doa_max_chickens", 5)) {
        foreach (chicken in self.doa.var_3cdd8203) {
            if (!(isdefined(chicken.special) && chicken.special)) {
                chicken notify(#"spin_out");
                break;
            }
        }
    }
    orb thread function_d7142cd(self);
    orb thread function_3118ca4d(self);
    orb thread function_8b81d592(self);
    orb thread function_8fb467a7(self);
    orb thread function_4ef3ec52();
    orb thread function_da8e9c9b();
    orb thread function_44ff9baa(self);
    orb thread function_e636d9c5(self);
    if (isdefined(var_5c667593) && var_5c667593) {
        orb thread function_cff32183(self);
    }
}

// Namespace namespace_5e6c5d1f
// Params 0, eflags: 0x0
// Checksum 0xfef73da9, Offset: 0xcd0
// Size: 0x95
function function_8397461e() {
    if (!isdefined(self.doa.var_3cdd8203)) {
        return;
    }
    foreach (bird in self.doa.var_3cdd8203) {
        if (isdefined(bird.special) && bird.special) {
            continue;
        }
        bird notify(#"spin_out", 1);
    }
}

// Namespace namespace_5e6c5d1f
// Params 1, eflags: 0x0
// Checksum 0xf4feb3c3, Offset: 0xd70
// Size: 0x77
function function_d7142cd(player) {
    self endon(#"death");
    player waittill(#"disconnect");
    if (isdefined(self.special) && self.special) {
        if (isdefined(self.bird)) {
            self.bird delete();
        }
        self delete();
        return;
    }
    self notify(#"spin_out");
}

// Namespace namespace_5e6c5d1f
// Params 1, eflags: 0x0
// Checksum 0x1fa99d68, Offset: 0xdf0
// Size: 0x252
function function_3118ca4d(player) {
    if (isdefined(self.special) && self.special) {
        return;
    }
    self notify(#"hash_3118ca4d");
    self endon(#"hash_3118ca4d");
    self endon(#"death");
    self waittill(#"spin_out", immediate);
    waittillframeend();
    self notify(#"spinning_out");
    arrayremovevalue(player.doa.var_3cdd8203, self);
    if (!(isdefined(immediate) && immediate)) {
        self.var_3424aae1 = 1;
        var_46d4563e = player;
        foreach (chicken in player.doa.var_3cdd8203) {
            chicken.var_947e1f34 = var_46d4563e;
            var_46d4563e = chicken;
        }
        weapon = function_4d01b327(player);
        self.var_f13ce5fc = randomfloatrange(5, 8);
        firetime = 0.15;
        while (self.var_f13ce5fc > 0) {
            var_2e036f52 = 1;
            self rotateto(self.angles + (0, 180, 0), var_2e036f52);
            for (var_cf478564 = var_2e036f52; var_cf478564 > 0; var_cf478564 -= firetime) {
                self function_cea0c915(player, weapon);
                wait firetime;
            }
            self.var_f13ce5fc = self.var_f13ce5fc - var_2e036f52;
        }
    }
    self thread namespace_1a381543::function_90118d8c("zmb_dblshot_end");
    self.bird thread namespace_eaa992c::function_285a2999("chicken_explode");
    util::wait_network_frame();
    if (isdefined(self.bird)) {
        self.bird delete();
    }
    self delete();
}

// Namespace namespace_5e6c5d1f
// Params 2, eflags: 0x0
// Checksum 0xf680660a, Offset: 0x1050
// Size: 0x39
function function_4dd46e10(&var_86e68a1c, var_a16e9241) {
    for (i = 0; i < var_a16e9241; i++) {
        var_86e68a1c[i] = self.origin;
    }
}

// Namespace namespace_5e6c5d1f
// Params 1, eflags: 0x0
// Checksum 0xbd7465d3, Offset: 0x1098
// Size: 0xc9
function function_e636d9c5(player) {
    self endon(#"death");
    player endon(#"disconnect");
    while (true) {
        level waittill(#"hash_31680c6");
        if (!isdefined(player)) {
            return;
        }
        if (isdefined(self.var_3424aae1) && self.var_3424aae1) {
            self.var_f13ce5fc = 0;
        }
        self.var_6fdb49e0 = 1;
        var_7bb420a0 = self function_bd97e9ba(player) + 1;
        forward = anglestoforward(player.angles);
        offset = forward * (24 * var_7bb420a0, 0, 0);
        self.origin = player.origin - offset;
    }
}

// Namespace namespace_5e6c5d1f
// Params 1, eflags: 0x0
// Checksum 0xb93788cd, Offset: 0x1170
// Size: 0x275
function function_44ff9baa(player) {
    self endon(#"death");
    self endon(#"spinning_out");
    var_137307 = 0;
    next_index = var_137307 + 1;
    var_a16e9241 = getdvarint("scr_doa_max_chicken_points", 5);
    var_86e68a1c = [];
    self.var_6fdb49e0 = 1;
    while (true) {
        util::wait_network_frame();
        if (isdefined(self.var_efa2b784) && self.var_efa2b784) {
            self.var_6fdb49e0 = 1;
            continue;
        }
        if (isdefined(self.var_a732885d) && self.var_a732885d) {
            self.var_6fdb49e0 = 1;
            continue;
        }
        if (self.var_6fdb49e0) {
            self.var_6fdb49e0 = 0;
            function_4dd46e10(var_86e68a1c, var_a16e9241);
        }
        if (isdefined(self.var_947e1f34)) {
            if (isplayer(self.var_947e1f34)) {
                angles = self.var_947e1f34 getplayerangles();
            } else {
                angles = self.var_947e1f34.angles;
            }
            self.angles = (angles[0], angles[1], 0);
            self.bird.angles = self.angles;
            self.bird.origin = self.origin;
            self.is_moving = 0;
            if (distance2dsquared(self.var_947e1f34.origin, var_86e68a1c[var_137307]) > getdvarint("scr_doa_follow_point_spacing", 4 * 4)) {
                var_eea105d9 = self.var_947e1f34.origin;
                if (isplayer(self.var_947e1f34)) {
                    var_eea105d9 += (0, 0, 50);
                }
                var_86e68a1c[next_index] = var_eea105d9;
                var_137307 = next_index;
                next_index++;
                next_index %= var_a16e9241;
                self.is_moving = 1;
                self moveto(var_86e68a1c[next_index], getdvarfloat("scr_doa_chicken_speed", 0.15), 0, 0);
            }
        }
    }
}

// Namespace namespace_5e6c5d1f
// Params 1, eflags: 0x0
// Checksum 0xbdc04f23, Offset: 0x13f0
// Size: 0x127
function function_8b81d592(player) {
    self endon(#"spinning_out");
    self endon(#"death");
    time = level.doa.rules.var_da7e08a6 * 1000;
    if (player.doa.fate == 3 || player.doa.fate == 12) {
        time *= level.doa.rules.var_ef3d9a29;
    }
    level namespace_49107f3a::function_c8f4d63a();
    timeout = gettime() + time;
    while (gettime() < timeout) {
        if (!isdefined(player)) {
            self notify(#"spin_out");
        }
        if (level flag::get("doa_game_is_over")) {
            self notify(#"spin_out");
        }
        wait 0.05;
    }
    while (isdefined(self.var_efa2b784) && (isdefined(self.var_a732885d) && self.var_a732885d || self.var_efa2b784)) {
        wait 1;
    }
    self notify(#"spin_out");
}

// Namespace namespace_5e6c5d1f
// Params 1, eflags: 0x0
// Checksum 0x7cfabba6, Offset: 0x1520
// Size: 0x1e3
function function_4d01b327(player) {
    weapon = level.doa.var_362a104d;
    switch (self.var_cdf31c46) {
    case 0:
        if (isdefined(player)) {
            weapon = player.doa.var_d898dd8e;
        }
        if (!isdefined(weapon) || weapon.name == "none") {
            weapon = player.doa.var_ca0a87c8;
        }
        if (isdefined(player.doa.vehicle)) {
            if (isdefined(player.doa.vehicle.var_aaffbea7) && player.doa.vehicle.var_aaffbea7) {
                weapon = level.doa.var_c1b50f26;
            } else {
                weapon = level.doa.var_e6a7c945;
            }
        }
        break;
    case 1:
        weapon = level.doa.var_1f6dff3d;
        break;
    case 2:
        weapon = level.doa.var_dce7830f;
        break;
    case 3:
        weapon = level.doa.var_eb58a672;
        break;
    case 4:
        weapon = level.doa.var_b6808b5a;
        break;
    case 5:
        weapon = level.doa.var_a9c9b20;
        break;
    case 6:
        weapon = level.doa.var_e00fcc77;
        break;
    case 7:
        weapon = level.doa.var_69899304;
        break;
    case 8:
        weapon = level.doa.var_ccb54987;
        break;
    }
    return weapon;
}

// Namespace namespace_5e6c5d1f
// Params 1, eflags: 0x0
// Checksum 0xd2f1131, Offset: 0x1710
// Size: 0xbf
function function_be58e20c(player) {
    self endon(#"death");
    self endon(#"spinning_out");
    while (true) {
        if (isdefined(player.doa.vehicle)) {
            msg = player.doa.vehicle util::waittill_any_timeout(0.1, "weapon_fired", "gunner_weapon_fired");
        } else {
            msg = player util::waittill_any_timeout(0.1, "weapon_fired", "gunner_weapon_fired");
        }
        if (isdefined(msg) && msg != "timeout") {
            self notify(#"chicken_fire");
        }
    }
}

// Namespace namespace_5e6c5d1f
// Params 1, eflags: 0x0
// Checksum 0xb148135a, Offset: 0x17d8
// Size: 0xaf
function function_8fb467a7(player) {
    self endon(#"death");
    self endon(#"spinning_out");
    self thread function_be58e20c(player);
    while (true) {
        self waittill(#"chicken_fire");
        if (isdefined(self.var_18845184) && self.var_18845184) {
            continue;
        }
        weapon = function_4d01b327(player);
        self function_cea0c915(player, weapon);
        extrawait = weapon.firetime - 0.05;
        if (extrawait > 0) {
            wait extrawait;
        }
    }
}

// Namespace namespace_5e6c5d1f
// Params 2, eflags: 0x4
// Checksum 0x1a073aaa, Offset: 0x1890
// Size: 0x11a
function private function_cea0c915(player, weapon) {
    forward = anglestoforward(self.angles);
    offset = forward * 12 + (0, 0, 6);
    scale = self.basescale + self.var_fe6ede28;
    offset *= scale;
    start = self.bird.origin + offset;
    if (getdvarint("scr_doa_debug_chicken_fire", 0)) {
        level thread namespace_2f63e553::function_a0e51d80(start, 5, 20, (1, 0, 0));
        level thread namespace_2f63e553::debugline(start, self.origin + forward * 1000, 5, (1, 0, 0));
    }
    magicbullet(weapon, start, start + forward * 1000, isdefined(player) ? player : self.bird);
}

// Namespace namespace_5e6c5d1f
// Params 0, eflags: 0x0
// Checksum 0xd6234dbf, Offset: 0x19b8
// Size: 0x85
function function_da8e9c9b() {
    self endon(#"spinning_out");
    self endon(#"death");
    while (isdefined(self)) {
        rand = randomintrange(0, 100);
        if (rand > 30) {
            self thread namespace_1a381543::function_90118d8c("zmb_dblshot_wingflap");
        }
        if (rand > 70) {
            self thread namespace_1a381543::function_90118d8c("zmb_dblshot_squawk");
        }
        wait randomfloatrange(1, 3);
    }
}

// Namespace namespace_5e6c5d1f
// Params 0, eflags: 0x0
// Checksum 0xd55e3c54, Offset: 0x1a48
// Size: 0x65
function function_4ef3ec52() {
    self endon(#"death");
    self waittill(#"spinning_out");
    while (isdefined(self)) {
        self thread namespace_1a381543::function_90118d8c("zmb_dblshot_wingflap");
        self thread namespace_1a381543::function_90118d8c("zmb_dblshot_death");
        wait randomfloatrange(0.5, 1);
    }
}

// Namespace namespace_5e6c5d1f
// Params 0, eflags: 0x0
// Checksum 0x9a879942, Offset: 0x1ab8
// Size: 0xc1
function function_9d2031fa() {
    self notify(#"chicken_disconnect_watch");
    self endon(#"chicken_disconnect_watch");
    msg = self util::waittill_any_return("death", "disconnect");
    foreach (chicken in self.doa.var_3cdd8203) {
        if (msg == "disconnect" || !(isdefined(chicken.special) && chicken.special)) {
            chicken notify(#"spin_out");
        }
    }
}

// Namespace namespace_5e6c5d1f
// Params 3, eflags: 0x0
// Checksum 0x3aaeb845, Offset: 0x1b88
// Size: 0xc2
function function_d35a405a(model, var_c34952ed, var_c29d1327) {
    if (!isdefined(var_c34952ed)) {
        var_c34952ed = 0;
    }
    if (!isdefined(var_c29d1327)) {
        var_c29d1327 = 1;
    }
    if (!isdefined(self.doa.var_3cdd8203)) {
        self.doa.var_3cdd8203 = [];
    }
    self thread function_9d2031fa();
    def = namespace_a7e6beb5::function_bac08508(5);
    if (!isdefined(model)) {
        model = level.doa.var_8d63e734;
    }
    self add_a_chicken(model, def.scale * var_c29d1327, var_c34952ed != 0, var_c34952ed == 2);
}

// Namespace namespace_5e6c5d1f
// Params 0, eflags: 0x0
// Checksum 0x67a4239b, Offset: 0x1c58
// Size: 0x83
function function_83df0c19() {
    number = 0;
    foreach (chicken in self.doa.var_3cdd8203) {
        if (!(isdefined(chicken.special) && chicken.special)) {
            number++;
        }
    }
    return number;
}

// Namespace namespace_5e6c5d1f
// Params 1, eflags: 0x0
// Checksum 0xa8c7c966, Offset: 0x1ce8
// Size: 0x83
function function_bd97e9ba(player) {
    number = 0;
    foreach (chicken in player.doa.var_3cdd8203) {
        if (chicken == self) {
            break;
        }
        number++;
    }
    return number;
}

// Namespace namespace_5e6c5d1f
// Params 1, eflags: 0x0
// Checksum 0x354259d9, Offset: 0x1d78
// Size: 0x165
function function_c397fab3(player) {
    self endon(#"death");
    self endon(#"spinning_out");
    while (true) {
        player waittill(#"player_died");
        namespace_49107f3a::debugmsg("Egglaying Chicken penalty reduction");
        var_141b6128 = self.var_fe6ede28 * 0.98;
        self.var_1f6fdc8f = 1;
        while (self.var_fe6ede28 > var_141b6128) {
            self.var_fe6ede28 = self.var_fe6ede28 - 0.05;
            self.bird setscale(self.basescale + self.var_fe6ede28);
            namespace_49107f3a::debugmsg("Egglaying Chicken " + self getentitynumber() + " current plumplness: " + self.var_fe6ede28);
            wait 0.05;
        }
        namespace_49107f3a::debugmsg("Egglaying Chicken " + self getentitynumber() + " final plumplness: " + self.var_fe6ede28);
        self.var_fe6ede28 = math::clamp(var_141b6128, 0, getdvarfloat("scr_doa_chicken_max_plump", 3));
        self.var_1f6fdc8f = undefined;
    }
}

// Namespace namespace_5e6c5d1f
// Params 1, eflags: 0x0
// Checksum 0x306135d6, Offset: 0x1ee8
// Size: 0x2c5
function function_cff32183(player) {
    self endon(#"death");
    self endon(#"spinning_out");
    self.var_fe6ede28 = 0;
    self thread function_c397fab3(player);
    while (true) {
        wait getdvarfloat("scr_doa_chicken_inc_interval", 15);
        if (level flag::get("doa_round_active")) {
            var_7cfd4c5f = player function_83df0c19() + 1;
            increment = getdvarfloat("scr_doa_chicken_inc_plump", 0.035) * var_7cfd4c5f;
            if (!(isdefined(self.var_1f6fdc8f) && self.var_1f6fdc8f)) {
                self.var_fe6ede28 = math::clamp(self.var_fe6ede28 + increment, 0, getdvarfloat("scr_doa_chicken_max_plump", 3));
                namespace_49107f3a::debugmsg("Egglaying Chicken " + self getentitynumber() + " current plumplness: " + self.var_fe6ede28);
            }
            self.bird setscale(self.basescale + self.var_fe6ede28);
            var_cdf31c46 = 0;
            frac = self.var_fe6ede28 / getdvarfloat("scr_doa_chicken_max_plump", 3);
            if (frac > 0.03) {
                var_cdf31c46 = 1;
            }
            if (frac > 0.12) {
                var_cdf31c46 = 2;
            }
            if (frac > 0.3) {
                var_cdf31c46 = 3;
            }
            if (frac > 0.5) {
                var_cdf31c46 = 4;
            }
            if (frac > 0.7) {
                var_cdf31c46 = 5;
            }
            if (frac > 0.82) {
                var_cdf31c46 = 6;
            }
            if (frac > 0.94) {
                var_cdf31c46 = 7;
            }
            if (self.var_cdf31c46 != var_cdf31c46) {
                self thread namespace_1a381543::function_90118d8c("zmb_golden_chicken_grow");
                self.var_7d36ff94 = 1;
                self.var_cdf31c46 = var_cdf31c46;
            }
            if (self.var_fe6ede28 == getdvarfloat("scr_doa_chicken_max_plump", 3)) {
                wait getdvarfloat("scr_doa_chicken_waitfull_plump", 30);
                self function_2d0f96ef(player);
                self.var_fe6ede28 = 0;
                self.var_cdf31c46 = 0;
                self.bird setscale(self.basescale + self.var_fe6ede28);
            }
        }
    }
}

// Namespace namespace_5e6c5d1f
// Params 1, eflags: 0x0
// Checksum 0xdeba6953, Offset: 0x21b8
// Size: 0x2b9
function function_2d0f96ef(player) {
    self endon(#"death");
    self endon(#"spinning_out");
    namespace_49107f3a::debugmsg("Chicken is EggLaying:  " + self getentitynumber());
    self.var_a732885d = 1;
    self.var_18845184 = 1;
    var_ff37339 = 32;
    pos = 0;
    i = 0;
    var_fb842d4e = gettime() + getdvarfloat("scr_doa_chicken_egg_lay_duration", 12) * 1000;
    self thread namespace_1a381543::function_90118d8c("zmb_golden_chicken_dance");
    while (gettime() < var_fb842d4e) {
        foreach (chicken in player.doa.var_3cdd8203) {
            if (isdefined(chicken.var_a732885d) && chicken.var_a732885d) {
                continue;
            }
            if (isdefined(chicken.var_efa2b784) && chicken.var_efa2b784) {
                continue;
            }
            i++;
            offset = 48 + var_ff37339 * floor(i / 4);
            chicken thread function_5af02c44(self, i, offset);
        }
        self rotateto(self.angles + (0, 180, 0), 1);
        wait 1;
    }
    self thread namespace_1a381543::function_90118d8c("zmb_golden_chicken_pop");
    level namespace_a7e6beb5::function_3238133b("zombietron_egg", self.origin);
    while (self.var_fe6ede28 > 0) {
        self.var_fe6ede28 = self.var_fe6ede28 - 0.05;
        self.bird setscale(self.basescale + self.var_fe6ede28);
        wait 0.05;
    }
    foreach (chicken in player.doa.var_3cdd8203) {
        chicken.var_a732885d = undefined;
        chicken.var_efa2b784 = undefined;
        chicken.var_18845184 = undefined;
        chicken notify(#"hash_e6885d7c");
    }
}

// Namespace namespace_5e6c5d1f
// Params 3, eflags: 0x4
// Checksum 0x27eaa8fd, Offset: 0x2480
// Size: 0x172
function private function_5af02c44(target, num, offset) {
    self endon(#"death");
    self endon(#"spinning_out");
    self.var_efa2b784 = 1;
    self.var_18845184 = 1;
    anim_ang = vectortoangles(target.origin - self.origin);
    self rotateto((0, anim_ang[1], 0), 0.5);
    pos = num % 4;
    switch (pos) {
    case 0:
        spot = (offset, 0, 50);
        break;
    case 1:
        spot = (0, offset, 50);
        break;
    case 2:
        spot = (offset * -1, 0, 50);
        break;
    case 3:
        spot = (0, offset * -1, 50);
        break;
    }
    self moveto(target.origin, 1);
    self util::waittill_any_timeout(2, "movedone");
    self linkto(target, "tag_origin", spot);
    self waittill(#"hash_e6885d7c");
    self unlink();
}

// Namespace namespace_5e6c5d1f
// Params 0, eflags: 0x4
// Checksum 0x784e91e7, Offset: 0x2600
// Size: 0xaa
function private function_e4f21fa9() {
    roll = randomint(100);
    prize = "none";
    if (roll < 2) {
        prize = level.doa.var_890f74c0;
    } else if (roll < 6) {
        prize = level.doa.var_501f85b4;
    } else if (roll < 16) {
        prize = level.doa.var_37366651;
    } else if (roll <= 40) {
        prize = level.doa.var_8d63e734;
    } else {
        prize = "zombietron_diamond";
    }
    return prize;
}

// Namespace namespace_5e6c5d1f
// Params 1, eflags: 0x0
// Checksum 0xe1cd8961, Offset: 0x26b8
// Size: 0x62
function function_d63bdb9(hop) {
    if (hop) {
        self physicslaunch(self.origin, (randomintrange(-10, 10), randomintrange(-10, 10), 30));
        self thread namespace_1a381543::function_90118d8c("zmb_egg_shake");
    }
}

// Namespace namespace_5e6c5d1f
// Params 0, eflags: 0x0
// Checksum 0x27e9e17f, Offset: 0x2728
// Size: 0x1ed
function function_4c41e6af() {
    self endon(#"death");
    while (true) {
        closezombies = namespace_49107f3a::function_a7eabaf(self.origin, getaiteamarray("axis"), 2304);
        for (i = 0; i < closezombies.size; i++) {
            zombie = closezombies[i];
            if (isdefined(zombie.var_2d8174e3) && zombie.var_2d8174e3) {
                continue;
            }
            zombie setentitytarget(self);
            dir = vectornormalize(self.origin - zombie.origin) * 30;
            self physicslaunch(self.origin, (dir[0], dir[1], dir[2] + 10));
            self.health = self.health - 40;
            if (self.health < 0) {
                self thread namespace_1a381543::function_90118d8c("zmb_explode");
                self thread namespace_eaa992c::function_285a2999("egg_explode");
                physicsexplosionsphere(self.origin, -56, -128, 2);
                self radiusdamage(self.origin, 72, 2000, 1000);
                playrumbleonposition("explosion_generic", self.origin);
                self waittill(#"hash_6a404ade");
                self delete();
            }
        }
        wait 1;
        self.var_111c7bbb = getclosestpointonnavmesh(self.origin, 64, 16);
    }
}

// Namespace namespace_5e6c5d1f
// Params 0, eflags: 0x0
// Checksum 0x92e4998d, Offset: 0x2920
// Size: 0x17a
function function_7b8c015c() {
    self endon(#"death");
    self physicslaunch(self.origin, (0, 0, 10));
    self.health = 1000;
    self thread function_4c41e6af();
    wait 1;
    self makesentient();
    self.threatbias = 0;
    namespace_49107f3a::addpoi(self);
    self.var_b2290d2d = 1;
    self waittill(#"pickup_timeout");
    self thread namespace_1a381543::function_90118d8c("zmb_egg_hatch");
    self thread namespace_eaa992c::function_285a2999("egg_hatch");
    if (isdefined(self.prize)) {
        prize = self.prize;
    } else {
        prize = function_e4f21fa9();
    }
    origin = namespace_49107f3a::function_1c0abd70(self.origin, 72, self);
    if (prize != "zombietron_diamond") {
        level namespace_a7e6beb5::function_3238133b(prize, origin + (0, 0, 32));
    } else {
        level thread namespace_a7e6beb5::function_16237a19(origin, 1 + randomintrange(2, 6), 0, 1);
    }
    self waittill(#"hash_6a404ade");
    self delete();
}

