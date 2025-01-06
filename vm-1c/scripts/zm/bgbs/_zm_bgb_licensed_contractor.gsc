#using scripts/codescripts/struct;
#using scripts/shared/flag_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_bgb;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_utility;

#namespace zm_bgb_licensed_contractor;

// Namespace zm_bgb_licensed_contractor
// Params 0, eflags: 0x2
// Checksum 0xe47f214b, Offset: 0x180
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_licensed_contractor", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_licensed_contractor
// Params 0, eflags: 0x0
// Checksum 0x2f25e1ea, Offset: 0x1c0
// Size: 0x54
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_licensed_contractor", "activated", 3, undefined, undefined, undefined, &activation);
}

// Namespace zm_bgb_licensed_contractor
// Params 0, eflags: 0x0
// Checksum 0xd0c39e03, Offset: 0x220
// Size: 0x24
function activation() {
    self thread bgb::function_dea74fb0("carpenter");
}

