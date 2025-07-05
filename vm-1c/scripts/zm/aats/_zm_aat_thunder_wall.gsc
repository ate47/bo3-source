#using scripts/codescripts/struct;
#using scripts/shared/aat_shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;

#namespace zm_aat_thunder_wall;

// Namespace zm_aat_thunder_wall
// Params 0, eflags: 0x2
// Checksum 0xe4285d40, Offset: 0x2b8
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_aat_thunder_wall", &__init__, undefined, "aat");
}

// Namespace zm_aat_thunder_wall
// Params 0, eflags: 0x0
// Checksum 0x1d65d2ca, Offset: 0x2f8
// Size: 0x86
function __init__() {
    if (!(isdefined(level.aat_in_use) && level.aat_in_use)) {
        return;
    }
    aat::register("zm_aat_thunder_wall", 0.25, 0, 10, 0, 1, &result, "t7_hud_zm_aat_thunderwall", "wpn_aat_thunder_wall_plr");
    level._effect["zm_aat_thunder_wall" + "_break_fx"] = "zombie/fx_aat_thunderwall_zmb";
}

// Namespace zm_aat_thunder_wall
// Params 4, eflags: 0x0
// Checksum 0x1c0f7f83, Offset: 0x388
// Size: 0x3c
function result(death, attacker, mod, weapon) {
    self thread function_c2f2c617(attacker);
}

// Namespace zm_aat_thunder_wall
// Params 1, eflags: 0x0
// Checksum 0xfedd4197, Offset: 0x3d0
// Size: 0x536
function function_c2f2c617(attacker) {
    var_9c9f175d = self.origin;
    var_83cb75f0 = vectortoangles(var_9c9f175d - attacker.origin);
    var_660fc956 = attacker getweaponforwarddir();
    var_384d5a7e = attacker.angles;
    a_ai_zombies = array::get_all_closest(var_9c9f175d, getaiteamarray("axis"), undefined, undefined, 360);
    if (!isdefined(a_ai_zombies)) {
        return;
    }
    var_7353f506 = 32400;
    var_e45b3978 = 291600;
    end_pos = var_9c9f175d + vectorscale(var_660fc956, -76);
    self playsound("wpn_aat_thunderwall_impact");
    level thread function_e0860fc8(var_9c9f175d, var_384d5a7e);
    n_flung_zombies = 0;
    for (i = 0; i < a_ai_zombies.size; i++) {
        if (!isdefined(a_ai_zombies[i]) || !isalive(a_ai_zombies[i])) {
            continue;
        }
        if (isdefined(level.aat["zm_aat_thunder_wall"].immune_result_direct[a_ai_zombies[i].archetype]) && level.aat["zm_aat_thunder_wall"].immune_result_direct[a_ai_zombies[i].archetype]) {
            continue;
        }
        if (a_ai_zombies[i] == self) {
            v_curr_zombie_origin = self.origin;
            var_3a80ff09 = 0;
        } else {
            v_curr_zombie_origin = a_ai_zombies[i] getcentroid();
            var_3a80ff09 = distancesquared(var_9c9f175d, v_curr_zombie_origin);
            var_76b65463 = vectornormalize(v_curr_zombie_origin - var_9c9f175d);
            var_6a651c7a = vectordot(var_660fc956, var_76b65463);
            if (var_6a651c7a < 0) {
                continue;
            }
            radial_origin = pointonsegmentnearesttopoint(var_9c9f175d, end_pos, v_curr_zombie_origin);
            if (distancesquared(v_curr_zombie_origin, radial_origin) > var_e45b3978) {
                continue;
            }
        }
        if (var_3a80ff09 < var_7353f506) {
            a_ai_zombies[i] dodamage(a_ai_zombies[i].health, v_curr_zombie_origin, attacker, attacker, "none", "MOD_IMPACT");
            if (isdefined(attacker) && isplayer(attacker)) {
                attacker zm_stats::increment_challenge_stat("ZOMBIE_HUNTER_THUNDER_WALL");
            }
            if (!(isdefined(level.aat["zm_aat_thunder_wall"].immune_result_indirect[self.archetype]) && level.aat["zm_aat_thunder_wall"].immune_result_indirect[self.archetype])) {
                n_random_x = randomfloatrange(-3, 3);
                n_random_y = randomfloatrange(-3, 3);
                a_ai_zombies[i] startragdoll(1);
                a_ai_zombies[i] launchragdoll(100 * vectornormalize(v_curr_zombie_origin - var_9c9f175d + (n_random_x, n_random_y, 30)), "torso_lower");
            }
            n_flung_zombies++;
        }
        if (-1 && n_flung_zombies >= 6) {
            break;
        }
    }
}

// Namespace zm_aat_thunder_wall
// Params 2, eflags: 0x0
// Checksum 0x81ea2a9d, Offset: 0x910
// Size: 0x4c
function function_e0860fc8(v_blast_origin, var_384d5a7e) {
    fx::play("zm_aat_thunder_wall" + "_break_fx", v_blast_origin, var_384d5a7e, 1);
}

