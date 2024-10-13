#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_alchemical_antithesis;

// Namespace zm_bgb_alchemical_antithesis
// Params 0, eflags: 0x2
// Checksum 0x5c89c7f2, Offset: 0x1b8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_alchemical_antithesis", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_alchemical_antithesis
// Params 0, eflags: 0x1 linked
// Checksum 0xf7a937ed, Offset: 0x1f8
// Size: 0xa4
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_alchemical_antithesis", "activated", 2, undefined, undefined, &validation, &activation);
    bgb::function_336ffc4e("zm_bgb_alchemical_antithesis");
    bgb::function_ff4b2998("zm_bgb_alchemical_antithesis", &add_to_player_score_override, 0);
}

// Namespace zm_bgb_alchemical_antithesis
// Params 0, eflags: 0x1 linked
// Checksum 0xa7310812, Offset: 0x2a8
// Size: 0x34
function validation() {
    return !(isdefined(self bgb::get_active()) && self bgb::get_active());
}

// Namespace zm_bgb_alchemical_antithesis
// Params 0, eflags: 0x1 linked
// Checksum 0xfe1733be, Offset: 0x2e8
// Size: 0x38
function activation() {
    self.ready_for_score_events = 0;
    self bgb::run_timer(60);
    self.ready_for_score_events = 1;
}

// Namespace zm_bgb_alchemical_antithesis
// Params 3, eflags: 0x1 linked
// Checksum 0x4f116cab, Offset: 0x328
// Size: 0x156
function add_to_player_score_override(points, str_awarded_by, var_1ed9bd9b) {
    if (!(isdefined(self.bgb_active) && self.bgb_active)) {
        return points;
    }
    var_4375ef8a = int(points / 10);
    current_weapon = self getcurrentweapon();
    if (zm_utility::is_offhand_weapon(current_weapon)) {
        return points;
    }
    if (isdefined(self.is_drinking) && self.is_drinking) {
        return points;
    }
    if (current_weapon == level.weaponrevivetool) {
        return points;
    }
    var_b8f62d73 = self getweaponammostock(current_weapon);
    var_b8f62d73 += var_4375ef8a;
    self setweaponammostock(current_weapon, var_b8f62d73);
    self thread function_a6bf711f();
    self zm_stats::increment_challenge_stat("GUM_GOBBLER_ALCHEMICAL_ANTITHESIS", var_4375ef8a);
    return 0;
}

// Namespace zm_bgb_alchemical_antithesis
// Params 0, eflags: 0x1 linked
// Checksum 0x6c1e26fe, Offset: 0x488
// Size: 0x70
function function_a6bf711f() {
    if (!isdefined(self.var_82764e33)) {
        self.var_82764e33 = 0;
    }
    if (!self.var_82764e33) {
        self.var_82764e33 = 1;
        self playsoundtoplayer("zmb_bgb_alchemical_ammoget", self);
        wait 0.5;
        if (isdefined(self)) {
            self.var_82764e33 = 0;
        }
    }
}

