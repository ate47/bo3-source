#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_head_drama;

// Namespace zm_bgb_head_drama
// Params 0, eflags: 0x2
// Checksum 0x9fe15eba, Offset: 0x188
// Size: 0x34
function function_2dc19561() {
    system::register("zm_bgb_head_drama", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_head_drama
// Params 0, eflags: 0x1 linked
// Checksum 0xb61b5b28, Offset: 0x1c8
// Size: 0x5c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_head_drama", "rounds", 0, &enable, &disable, undefined);
}

// Namespace zm_bgb_head_drama
// Params 0, eflags: 0x1 linked
// Checksum 0x292ee1e3, Offset: 0x230
// Size: 0x24
function enable() {
    self setperk("specialty_locdamagecountsasheadshot");
}

// Namespace zm_bgb_head_drama
// Params 0, eflags: 0x1 linked
// Checksum 0x12cc76e3, Offset: 0x260
// Size: 0x24
function disable() {
    self unsetperk("specialty_locdamagecountsasheadshot");
}

