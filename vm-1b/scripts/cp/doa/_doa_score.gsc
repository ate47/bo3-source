#using scripts/codescripts/struct;
#using scripts/cp/doa/_doa_pickups;
#using scripts/cp/doa/_doa_player_utility;
#using scripts/cp/doa/_doa_utility;
#using scripts/cp/gametypes/_globallogic_score;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;

#namespace namespace_64c6b720;

// Namespace namespace_64c6b720
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x218
// Size: 0x2
function init() {
    
}

// Namespace namespace_64c6b720
// Params 1, eflags: 0x0
// Checksum 0xc311a507, Offset: 0x228
// Size: 0x23
function function_acd89108(note) {
    self endon(#"hash_a49bc808");
    self waittill(note);
    self notify(#"hash_7c5410c4");
}

// Namespace namespace_64c6b720
// Params 0, eflags: 0x0
// Checksum 0x67188b74, Offset: 0x258
// Size: 0xbf
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
// Checksum 0x76e3cc09, Offset: 0x320
// Size: 0x16
function function_92c929ab(val) {
    InvalidOpCode(0xc1, 2, val);
    // Unknown operator (0xc1, t7_1b, PC)
}

// Namespace namespace_64c6b720
// Params 0, eflags: 0x0
// Checksum 0x347fcb8c, Offset: 0x350
// Size: 0x202
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
        var_24b562d = self.doa.respawning ? 1 : 0;
        self.score = int(self.doa.score / 25);
        InvalidOpCode(0xc1, 12, self.doa.lives);
        // Unknown operator (0xc1, t7_1b, PC)
    }
}

// Namespace namespace_64c6b720
// Params 2, eflags: 0x0
// Checksum 0x7da2274f, Offset: 0x560
// Size: 0x15a
function function_80eb303(points, var_c979daec) {
    if (!isdefined(var_c979daec)) {
        var_c979daec = 0;
    }
    if (!level flag::get("doa_game_is_running")) {
        return;
    }
    if (!(isdefined(var_c979daec) && var_c979daec)) {
        points *= self.doa.multiplier;
    }
    points = 25 * int(points / 25);
    self globallogic_score::incpersstat("score", points, 1, 1);
    self.doa.score = math::clamp(self.doa.score + points, 0, int(int(4e+06) * 25 - 1));
    if (self.doa.score >= self.doa.var_295df6ca) {
        self.doa.var_295df6ca += level.doa.rules.var_61b88ecb;
        self thread namespace_a7e6beb5::function_ab651d00(self, "zombietron_extra_life");
    }
}

// Namespace namespace_64c6b720
// Params 2, eflags: 0x0
// Checksum 0x10f4308d, Offset: 0x6c8
// Size: 0x2b6
function function_850bb47e(increment, forcex) {
    if (!isdefined(forcex)) {
        if (!isdefined(increment)) {
            self.doa.var_5d2140f2 = level.doa.rules.var_a9114441;
            self.doa.var_d55e6679 = 0;
            self.doa.multiplier = 1;
            if (self.doa.fate == 2) {
                self.doa.multiplier = 2;
            }
            if (self.doa.fate == 11) {
                self.doa.multiplier = 3;
            }
            return;
        }
        if (!increment) {
            return;
        }
        var_6281aed1 = self.doa.var_5d2140f2 / level.doa.rules.var_a9114441;
        var_9903a63d = int(increment * var_6281aed1);
        self.doa.var_d55e6679 = int(self.doa.var_d55e6679 + var_9903a63d);
        if (self.doa.var_d55e6679 > level.doa.rules.var_d55e6679) {
            self.doa.var_5d2140f2 = namespace_49107f3a::clamp(int(self.doa.var_5d2140f2 * 0.65 + 0.69), 1, level.doa.rules.var_a9114441);
            self.doa.var_d55e6679 -= level.doa.rules.var_d55e6679;
            max = level.doa.rules.max_multiplier;
            if (self.doa.fate == 11) {
                max += 1;
            }
            self.doa.multiplier = namespace_49107f3a::clamp(self.doa.multiplier + 1, 1, max);
        }
        return;
    }
    self.doa.multiplier = forcex;
    self.doa.var_d55e6679 = level.doa.rules.var_d55e6679;
}

