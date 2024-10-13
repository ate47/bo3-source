#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_im_feelin_lucky;

// Namespace zm_bgb_im_feelin_lucky
// Params 0, eflags: 0x2
// Checksum 0x1ffc7134, Offset: 0x150
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_im_feelin_lucky", &__init__, undefined, undefined);
}

// Namespace zm_bgb_im_feelin_lucky
// Params 0, eflags: 0x1 linked
// Checksum 0xe6b211e9, Offset: 0x190
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_im_feelin_lucky", "activated");
}

