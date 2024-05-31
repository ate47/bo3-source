#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_4754119d;

// Namespace namespace_4754119d
// Params 0, eflags: 0x2
// namespace_4754119d<file_0>::function_2dc19561
// Checksum 0xb735fb7a, Offset: 0x1e8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_armamental_accomplishment", &__init__, undefined, "bgb");
}

// Namespace namespace_4754119d
// Params 0, eflags: 0x1 linked
// namespace_4754119d<file_0>::function_8c87d8eb
// Checksum 0x75406cc4, Offset: 0x228
// Size: 0x5c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_armamental_accomplishment", "rounds", 3, &enable, &disable, undefined);
}

// Namespace namespace_4754119d
// Params 0, eflags: 0x1 linked
// namespace_4754119d<file_0>::function_bae40a28
// Checksum 0x403e80bf, Offset: 0x290
// Size: 0x84
function enable() {
    self setperk("specialty_fastmeleerecovery");
    self setperk("specialty_fastweaponswitch");
    self setperk("specialty_fastequipmentuse");
    self setperk("specialty_fasttoss");
}

// Namespace namespace_4754119d
// Params 0, eflags: 0x1 linked
// namespace_4754119d<file_0>::function_54bdb053
// Checksum 0x7bba458a, Offset: 0x320
// Size: 0x84
function disable() {
    self unsetperk("specialty_fastmeleerecovery");
    self unsetperk("specialty_fastweaponswitch");
    self unsetperk("specialty_fastequipmentuse");
    self unsetperk("specialty_fasttoss");
}

