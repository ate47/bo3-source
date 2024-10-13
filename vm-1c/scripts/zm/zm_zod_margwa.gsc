#using scripts/zm/zm_zod_vo;
#using scripts/zm/zm_zod;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_ai_margwa;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/margwa;
#using scripts/shared/util_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_zod_margwa;

// Namespace zm_zod_margwa
// Params 0, eflags: 0x2
// Checksum 0x5839d463, Offset: 0x240
// Size: 0xd4
function autoexec init() {
    level.var_785a0d1e = &function_785a0d1e;
    level.var_3b3eeb2e = [];
    level.var_3b3eeb2e[level.var_3b3eeb2e.size] = "zone_subway_pap";
    level.var_3b3eeb2e[level.var_3b3eeb2e.size] = "zone_subway_pap_ritual";
    level.var_3b3eeb2e[level.var_3b3eeb2e.size] = "zone_subway_north";
    level.var_3b3eeb2e[level.var_3b3eeb2e.size] = "zone_subway_central";
    level.var_3b3eeb2e[level.var_3b3eeb2e.size] = "zone_subway_junction";
    level flag::init("can_spawn_margwa", 1);
}

// Namespace zm_zod_margwa
// Params 0, eflags: 0x5 linked
// Checksum 0x82cac2d5, Offset: 0x320
// Size: 0x9a
function private function_b68ea33d() {
    if (isdefined(self.zone_name)) {
        foreach (zone in level.var_3b3eeb2e) {
            if (self.zone_name == zone) {
                return true;
            }
        }
    }
    return false;
}

// Namespace zm_zod_margwa
// Params 0, eflags: 0x5 linked
// Checksum 0xe9b8069f, Offset: 0x3c8
// Size: 0xae
function private function_785a0d1e() {
    if (isdefined(self.favoriteenemy)) {
        if (!level flag::get("connect_subway_to_junction")) {
            if (self.favoriteenemy function_b68ea33d()) {
                if (!self function_b68ea33d()) {
                    return true;
                }
            } else if (self function_b68ea33d()) {
                return true;
            }
        }
        if (!self zm_zod::function_61b96f56(self.favoriteenemy)) {
            return true;
        }
    }
    return false;
}

// Namespace zm_zod_margwa
// Params 0, eflags: 0x1 linked
// Checksum 0x388fdb75, Offset: 0x480
// Size: 0x5c
function function_5e93cd08() {
    /#
        if (getdvarint("<dev string:x28>") >= 2) {
            return;
        }
    #/
    level.var_67b254fb = 1;
    level.var_b383deb1 = 0;
    level thread function_4575bd06();
}

// Namespace zm_zod_margwa
// Params 0, eflags: 0x1 linked
// Checksum 0x57fa69fc, Offset: 0x4e8
// Size: 0xd4
function function_4575bd06() {
    level.var_bf361dc0 = randomintrange(8, 9);
    level.var_6e63e659 = 0;
    while (true) {
        while (level.round_number < level.var_bf361dc0) {
            level waittill(#"between_round_over");
            /#
                if (level.round_number > level.var_bf361dc0) {
                    level.var_bf361dc0 = level.round_number + 1;
                }
            #/
        }
        function_c32a6dca();
        if (level.var_bf361dc0 == level.round_number) {
            function_aea74ccd();
        }
        level waittill(#"between_round_over");
    }
}

// Namespace zm_zod_margwa
// Params 0, eflags: 0x1 linked
// Checksum 0x1b5c91f, Offset: 0x5c8
// Size: 0x70
function function_c32a6dca() {
    if (level.var_bf361dc0 <= 12) {
        if (level.var_bf361dc0 == level.var_fe8c915f) {
            level.var_bf361dc0 += 2;
            return;
        }
        if (level.var_bf361dc0 == level.var_fe8c915f + 1) {
            level.var_bf361dc0 += 1;
        }
    }
}

// Namespace zm_zod_margwa
// Params 0, eflags: 0x1 linked
// Checksum 0x3c0a1e04, Offset: 0x640
// Size: 0xe4
function function_aea74ccd() {
    var_e0191376 = function_79c1b763();
    wait 5;
    while (var_e0191376 > 0) {
        while (!function_8303722e()) {
            wait 1;
        }
        var_225347e1 = function_8bcb72e9(1);
        if (isdefined(var_225347e1)) {
            var_e0191376--;
        }
        if (var_e0191376 > 0) {
            wait randomfloatrange(5, 10);
        }
    }
    level.var_bf361dc0 = level.round_number + randomintrange(5, 7);
}

// Namespace zm_zod_margwa
// Params 0, eflags: 0x1 linked
// Checksum 0x9d389f2d, Offset: 0x730
// Size: 0xa8
function function_8303722e() {
    var_f52ee0b1 = zombie_utility::get_current_zombie_count() >= level.zombie_ai_limit;
    var_73d2bce8 = level.zm_loc_types["margwa_location"].size < 1;
    if (var_f52ee0b1 || var_73d2bce8 || !level flag::get("spawn_zombies") || !level flag::get("can_spawn_margwa")) {
        return false;
    }
    return true;
}

// Namespace zm_zod_margwa
// Params 0, eflags: 0x1 linked
// Checksum 0x9ea99c7e, Offset: 0x7e0
// Size: 0xa0
function function_79c1b763() {
    level.var_b383deb1++;
    if (level.players.size == 1) {
        if (level.var_b383deb1 == 1 || level.var_b383deb1 == 2) {
            return 1;
        } else {
            return 1;
        }
        return;
    }
    if (level.var_b383deb1 == 1) {
        return 1;
    }
    if (level.var_b383deb1 == 2 || level.var_b383deb1 == 3) {
        return 2;
    }
    return 3;
}

// Namespace zm_zod_margwa
// Params 0, eflags: 0x1 linked
// Checksum 0xd68824d0, Offset: 0x888
// Size: 0x5a
function function_8d578a58() {
    level.var_6e63e659++;
    level.zombie_ai_limit--;
    self waittill(#"death");
    level thread zm_zod_vo::function_c11b8117(self.origin);
    level.var_6e63e659--;
    level.zombie_ai_limit++;
    level notify(#"hash_e332d537");
}

// Namespace zm_zod_margwa
// Params 2, eflags: 0x1 linked
// Checksum 0xf033f929, Offset: 0x8f0
// Size: 0x168
function function_8bcb72e9(var_8f401985, s_loc) {
    if (!isdefined(s_loc)) {
        if (level.zm_loc_types["margwa_location"].size == 0) {
            return undefined;
        }
        s_loc = array::random(level.zm_loc_types["margwa_location"]);
    }
    var_225347e1 = namespace_ca5ef87d::function_8a0708c2(s_loc);
    var_225347e1.var_26f9f957 = &function_26f9f957;
    level.var_95981590 = var_225347e1;
    level notify(#"hash_c484afcb");
    if (isdefined(var_225347e1)) {
        var_225347e1.b_ignore_cleanup = 1;
        var_225347e1 thread function_8d578a58();
        n_health = level.round_number * 100 + 100;
        var_225347e1 namespace_c96301ee::function_53ce09a(n_health);
    }
    if (!(isdefined(var_8f401985) && var_8f401985)) {
        level.var_bf361dc0 = level.round_number + randomintrange(5, 7);
    }
    return var_225347e1;
}

// Namespace zm_zod_margwa
// Params 2, eflags: 0x1 linked
// Checksum 0xc1690020, Offset: 0xa60
// Size: 0x44
function function_26f9f957(var_9c967ca3, e_attacker) {
    if (zm_utility::is_player_valid(e_attacker)) {
        e_attacker thread zm_zod_vo::function_7e398d3();
    }
}

