#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_tone_death;

// Namespace zm_bgb_tone_death
// Params 0, eflags: 0x2
// Checksum 0x1ff411dc, Offset: 0x140
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_tone_death", &__init__, undefined, undefined);
}

// Namespace zm_bgb_tone_death
// Params 0, eflags: 0x1 linked
// Checksum 0x543d2e8b, Offset: 0x180
// Size: 0x3c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_tone_death", "event");
}

