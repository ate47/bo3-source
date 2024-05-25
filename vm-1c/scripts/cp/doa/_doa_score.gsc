#using scripts/cp/gametypes/_globallogic_score;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_utility;
#using scripts/shared/math_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/util_shared;
#using scripts/codescripts/struct;

#namespace namespace_64c6b720;

// Namespace namespace_64c6b720
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x210
// Size: 0x4
function init() {
    
}

// Namespace namespace_64c6b720
// Params 1, eflags: 0x0
// Checksum 0x5f92d60b, Offset: 0x220
// Size: 0x2e
function function_acd89108(note) {
    self endon(#"hash_a49bc808");
    self waittill(note);
    self notify(#"hash_7c5410c4");
}

// Namespace namespace_64c6b720
// Params 0, eflags: 0x0
// Checksum 0x4be88cd, Offset: 0x258
// Size: 0xfe
function function_7c5410c4() {
    self endon(#"hash_acd89108");
    self waittill(#"hash_7c5410c4");
    foreach (player in namespace_831a4a7c::function_5eb6e4d1()) {
        if (isdefined(player.doa.timerhud)) {
            player closeluimenu(player.doa.timerhud);
            player.doa.timerhud = undefined;
        }
    }
    self notify(#"hash_a49bc808");
}

// Namespace namespace_64c6b720
// Params 1, eflags: 0x0
// Checksum 0xcd67ff51, Offset: 0x360
// Size: 0x32
function function_92c929ab(val) {
    ret = (val << 2) + self.entnum;
    return ret;
}

// Namespace namespace_64c6b720
// Params 0, eflags: 0x1 linked
// Checksum 0x3a7181e3, Offset: 0x3a0
// Size: 0x30c
function function_676edeb7() {
    self endon(#"disconnect");
    if (isdefined(self.doa)) {
        if (isdefined(self.doa.respawning) && self.doa.respawning) {
            var_132c0655 = math::clamp(self.var_9ea856f6 / 60, 0, 1);
            var_7d01b30f = 0;
            var_f63556d9 = 0;
        } else {
            var_132c0655 = math::clamp(self.doa.var_d55e6679 / level.doa.rules.var_d55e6679, 0, 1);
            var_7d01b30f = math::clamp(self.doa.var_91c268dc / getdvarint("scr_doa_weapon_increment_range", 1024), 0, 1);
            var_f63556d9 = self.doa.weaponlevel;
        }
        var_24b562d = (self.doa.var_db3637c0 << 2) + (self.doa.respawning ? 1 : 0);
        multiplier = self.doa.multiplier + self.doa.var_a3f61a60;
        max = level.doa.rules.var_385b385d;
        if (self.doa.fate == 11) {
            max++;
        }
        multiplier = math::clamp(multiplier, 0, max);
        self.score = int(self.doa.score / 25);
        self.headshots = (self.doa.lives << 12) + (self.doa.bombs << 8) + (self.doa.var_c5e98ad6 << 4) + multiplier;
        self.downs = (int(var_132c0655 * -1) << 2) + var_f63556d9;
        self.revives = (int(var_7d01b30f * -1) << 2) + self.doa.lightstate;
        self.assists = var_24b562d;
    }
}

// Namespace namespace_64c6b720
// Params 0, eflags: 0x1 linked
// Checksum 0x84bb0b6a, Offset: 0x6b8
// Size: 0x76
function getplayerscore() {
    if (!isdefined(self) || !isdefined(self.doa)) {
        return 0;
    }
    return self.doa.score + self.doa.var_db3637c0 * int(int(4e+06) * 25 - 1);
}

// Namespace namespace_64c6b720
// Params 2, eflags: 0x1 linked
// Checksum 0x61c78c40, Offset: 0x738
// Size: 0x3a4
function function_80eb303(points, var_c979daec) {
    if (!isdefined(var_c979daec)) {
        var_c979daec = 0;
    }
    if (!level flag::get("doa_game_is_running")) {
        return;
    }
    if (!(isdefined(var_c979daec) && var_c979daec)) {
        multiplier = self.doa.multiplier + self.doa.var_a3f61a60;
        max = level.doa.rules.var_385b385d;
        if (self.doa.fate == 11) {
            max++;
        }
        multiplier = math::clamp(multiplier, 0, max);
        points *= multiplier;
    }
    points = 25 * int(points / 25);
    self.doa.var_e1956fd2 += points;
    self.doa.score += points;
    if (self.doa.score > int(int(4e+06) * 25 - 1)) {
        if (self.doa.var_db3637c0 < 3) {
            self.doa.score = 0;
            self.doa.var_db3637c0++;
            self.doa.var_295df6ca = level.doa.rules.var_61b88ecb;
        } else {
            self.doa.score = int(int(4e+06) * 25 - 1);
        }
    }
    if (self.doa.score >= self.doa.var_295df6ca) {
        self.doa.var_295df6ca += level.doa.rules.var_61b88ecb;
        max = level.doa.rules.var_fd29bc1;
        if (self.doa.fate == 11) {
            max++;
        }
        if (self.doa.lives < max) {
            self thread namespace_a7e6beb5::function_ab651d00(self, "zombietron_extra_life");
            return;
        }
        if (randomint(100) > 50) {
            self thread namespace_a7e6beb5::function_ab651d00(self, level.doa.var_326cdb5e);
            return;
        }
        self thread namespace_a7e6beb5::function_ab651d00(self, level.doa.var_24fe9829);
    }
}

// Namespace namespace_64c6b720
// Params 1, eflags: 0x1 linked
// Checksum 0xb80dd6e7, Offset: 0xae8
// Size: 0x166
function function_126dc996(multiplier) {
    max = level.doa.rules.var_385b385d;
    if (self.doa.fate == 11) {
        max += 1;
    }
    self.doa.multiplier = namespace_49107f3a::clamp(multiplier, 1, max);
    self.doa.var_5d2140f2 = level.doa.rules.var_a9114441;
    if (self.doa.multiplier > 1) {
        for (var_29fc3c6b = self.doa.multiplier - 1; var_29fc3c6b; var_29fc3c6b--) {
            self.doa.var_5d2140f2 = namespace_49107f3a::clamp(int(self.doa.var_5d2140f2 * 0.65 + 0.69), 1, level.doa.rules.var_a9114441);
        }
    }
}

// Namespace namespace_64c6b720
// Params 2, eflags: 0x1 linked
// Checksum 0x4c4de764, Offset: 0xc58
// Size: 0x234
function function_850bb47e(increment, forcex) {
    if (!isdefined(forcex)) {
        if (!isdefined(increment)) {
            self.doa.var_d55e6679 = 0;
            self.doa.multiplier = 1;
            if (self.doa.fate == 2 || self.doa.fate == 11) {
                self.doa.multiplier = 2;
            }
            self function_126dc996(self.doa.multiplier);
            return;
        }
        if (!increment) {
            return;
        }
        var_6281aed1 = self.doa.var_5d2140f2 / level.doa.rules.var_a9114441;
        var_9903a63d = int(increment * var_6281aed1);
        self.doa.var_d55e6679 = int(self.doa.var_d55e6679 + var_9903a63d);
        if (self.doa.var_d55e6679 > level.doa.rules.var_d55e6679) {
            self function_126dc996(self.doa.multiplier + 1);
            self.doa.var_d55e6679 -= level.doa.rules.var_d55e6679;
        }
        return;
    }
    self.doa.multiplier = forcex;
    self.doa.var_d55e6679 = level.doa.rules.var_d55e6679;
}

