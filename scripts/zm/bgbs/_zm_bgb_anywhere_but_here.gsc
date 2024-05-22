#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_anywhere_but_here;

// Namespace zm_bgb_anywhere_but_here
// Params 0, eflags: 0x2
// Checksum 0x7458abda, Offset: 0x310
// Size: 0x34
function function_2dc19561() {
    system::register("zm_bgb_anywhere_but_here", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_anywhere_but_here
// Params 0, eflags: 0x1 linked
// Checksum 0x872df9d7, Offset: 0x350
// Size: 0xd4
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    level._effect["teleport_splash"] = "zombie/fx_bgb_anywhere_but_here_teleport_zmb";
    level._effect["teleport_aoe"] = "zombie/fx_bgb_anywhere_but_here_teleport_aoe_zmb";
    level._effect["teleport_aoe_kill"] = "zombie/fx_bgb_anywhere_but_here_teleport_aoe_kill_zmb";
    bgb::register("zm_bgb_anywhere_but_here", "activated", 2, undefined, undefined, &validation, &activation);
    bgb::function_4cda71bf("zm_bgb_anywhere_but_here", 1);
}

// Namespace zm_bgb_anywhere_but_here
// Params 0, eflags: 0x1 linked
// Checksum 0x68ee913a, Offset: 0x430
// Size: 0x534
function activation() {
    zm_utility::function_139befeb();
    playsoundatposition("zmb_bgb_abh_teleport_out", self.origin);
    if (isdefined(level.var_2c12d9a6)) {
        s_respawn_point = self [[ level.var_2c12d9a6 ]]();
    } else {
        s_respawn_point = self function_728dfe3();
    }
    self function_2cb3d5c8();
    self setvelocity((0, 0, 0));
    self setorigin(s_respawn_point.origin);
    self freezecontrols(1);
    v_return_pos = self.origin + (0, 0, 60);
    a_ai = getaiteamarray(level.zombie_team);
    a_closest = [];
    ai_closest = undefined;
    if (a_ai.size) {
        a_closest = arraysortclosest(a_ai, self.origin);
        foreach (ai in a_closest) {
            n_trace_val = ai sightconetrace(v_return_pos, self);
            if (n_trace_val > 0.2) {
                ai_closest = ai;
                break;
            }
        }
        if (isdefined(ai_closest)) {
            self setplayerangles(vectortoangles(ai_closest getcentroid() - v_return_pos));
        }
    }
    self playsound("zmb_bgb_abh_teleport_in");
    if (isdefined(level.var_2300a8ad)) {
        self [[ level.var_2300a8ad ]]();
    }
    wait(0.5);
    self show();
    playfx(level._effect["teleport_splash"], self.origin);
    playfx(level._effect["teleport_aoe"], self.origin);
    a_ai = getaiarray();
    a_aoe_ai = arraysortclosest(a_ai, self.origin, a_ai.size, 0, -56);
    foreach (ai in a_aoe_ai) {
        if (isactor(ai)) {
            if (ai.archetype === "zombie") {
                playfx(level._effect["teleport_aoe_kill"], ai gettagorigin("j_spineupper"));
            } else {
                playfx(level._effect["teleport_aoe_kill"], ai.origin);
            }
            ai.marked_for_recycle = 1;
            ai.has_been_damaged_by_player = 0;
            ai dodamage(ai.health + 1000, self.origin, self);
        }
    }
    wait(0.2);
    self freezecontrols(0);
    self zm_stats::increment_challenge_stat("GUM_GOBBLER_ANYWHERE_BUT_HERE");
    wait(3);
    zm_utility::function_36f941b3();
}

// Namespace zm_bgb_anywhere_but_here
// Params 0, eflags: 0x1 linked
// Checksum 0x63f86335, Offset: 0x970
// Size: 0x24
function validation() {
    if (isdefined(level.zm_bgb_anywhere_but_here_validation_override)) {
        return [[ level.zm_bgb_anywhere_but_here_validation_override ]]();
    }
    return 1;
}

// Namespace zm_bgb_anywhere_but_here
// Params 0, eflags: 0x1 linked
// Checksum 0x24692623, Offset: 0x9a0
// Size: 0x2f0
function function_728dfe3() {
    var_a6abcc5d = zm_zonemgr::get_zone_from_position(self.origin + (0, 0, 32), 0);
    if (!isdefined(var_a6abcc5d)) {
        var_a6abcc5d = self.zone_name;
    }
    if (isdefined(var_a6abcc5d)) {
        var_c30975d2 = level.zones[var_a6abcc5d];
    }
    a_s_respawn_points = struct::get_array("player_respawn_point", "targetname");
    a_s_valid_respawn_points = [];
    foreach (s_respawn_point in a_s_respawn_points) {
        if (zm_utility::is_point_inside_enabled_zone(s_respawn_point.origin, var_c30975d2)) {
            if (!isdefined(a_s_valid_respawn_points)) {
                a_s_valid_respawn_points = [];
            } else if (!isarray(a_s_valid_respawn_points)) {
                a_s_valid_respawn_points = array(a_s_valid_respawn_points);
            }
            a_s_valid_respawn_points[a_s_valid_respawn_points.size] = s_respawn_point;
        }
    }
    if (isdefined(level.var_2d4e3645)) {
        a_s_valid_respawn_points = [[ level.var_2d4e3645 ]](a_s_valid_respawn_points);
    }
    s_player_respawn = undefined;
    if (a_s_valid_respawn_points.size > 0) {
        var_90551969 = array::random(a_s_valid_respawn_points);
        var_46b9bbf8 = struct::get_array(var_90551969.target, "targetname");
        foreach (var_dbd59eb2 in var_46b9bbf8) {
            n_script_int = self getentitynumber() + 1;
            if (var_dbd59eb2.script_int === n_script_int) {
                s_player_respawn = var_dbd59eb2;
            }
        }
    }
    return s_player_respawn;
}

