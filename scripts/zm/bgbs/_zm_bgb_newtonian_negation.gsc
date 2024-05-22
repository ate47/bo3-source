#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_bgb;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_newtonian_negation;

// Namespace zm_bgb_newtonian_negation
// Params 0, eflags: 0x2
// Checksum 0xe91d8a00, Offset: 0x1a8
// Size: 0x34
function function_2dc19561() {
    system::register("zm_bgb_newtonian_negation", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_newtonian_negation
// Params 0, eflags: 0x1 linked
// Checksum 0x17a758b2, Offset: 0x1e8
// Size: 0x5c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_newtonian_negation", "time", 1500, &enable, &disable, undefined);
}

// Namespace zm_bgb_newtonian_negation
// Params 0, eflags: 0x1 linked
// Checksum 0xc088cf25, Offset: 0x250
// Size: 0x34
function enable() {
    function_2b4ff13a(1);
    self thread function_7d6ddd3a();
}

// Namespace zm_bgb_newtonian_negation
// Params 0, eflags: 0x1 linked
// Checksum 0x7d77b374, Offset: 0x290
// Size: 0x2c
function function_7d6ddd3a() {
    self endon(#"hash_7e8cbf8f");
    self waittill(#"disconnect");
    thread disable();
}

// Namespace zm_bgb_newtonian_negation
// Params 0, eflags: 0x1 linked
// Checksum 0xb239c052, Offset: 0x2c8
// Size: 0xdc
function disable() {
    if (isdefined(self)) {
        self notify(#"hash_7e8cbf8f");
    }
    foreach (player in level.players) {
        if (player !== self && player bgb::is_enabled("zm_bgb_newtonian_negation")) {
            return;
        }
    }
    function_2b4ff13a(0);
    zombie_utility::clear_all_corpses();
}

// Namespace zm_bgb_newtonian_negation
// Params 1, eflags: 0x1 linked
// Checksum 0xd8054583, Offset: 0x3b0
// Size: 0x54
function function_2b4ff13a(var_365c612) {
    if (var_365c612) {
        setdvar("phys_gravity_dir", (0, 0, -1));
        return;
    }
    setdvar("phys_gravity_dir", (0, 0, 1));
}

