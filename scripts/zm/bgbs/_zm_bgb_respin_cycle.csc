#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_respin_cycle;

// Namespace zm_bgb_respin_cycle
// Params 0, eflags: 0x2
// Checksum 0x2517bb27, Offset: 0x1a8
// Size: 0x34
function function_2dc19561() {
    system::register("zm_bgb_respin_cycle", &__init__, undefined, undefined);
}

// Namespace zm_bgb_respin_cycle
// Params 0, eflags: 0x1 linked
// Checksum 0x8680f337, Offset: 0x1e8
// Size: 0x9e
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_respin_cycle", "activated");
    clientfield::register("zbarrier", "zm_bgb_respin_cycle", 1, 1, "counter", &function_74ecbbd7, 0, 0);
    level._effect["zm_bgb_respin_cycle"] = "zombie/fx_bgb_respin_cycle_box_flash_zmb";
}

// Namespace zm_bgb_respin_cycle
// Params 7, eflags: 0x1 linked
// Checksum 0xb7059d5c, Offset: 0x290
// Size: 0x9c
function function_74ecbbd7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
    playfx(localclientnum, level._effect["zm_bgb_respin_cycle"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
}

