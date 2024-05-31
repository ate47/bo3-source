#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_perks;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace zm_bgb_perkaholic;

// Namespace zm_bgb_perkaholic
// Params 0, eflags: 0x2
// namespace_1b7b1237<file_0>::function_2dc19561
// Checksum 0xbdf1b86e, Offset: 0x178
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_perkaholic", &__init__, undefined, "bgb");
}

// Namespace zm_bgb_perkaholic
// Params 0, eflags: 0x1 linked
// namespace_1b7b1237<file_0>::function_8c87d8eb
// Checksum 0xc01fab7, Offset: 0x1b8
// Size: 0x54
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_perkaholic", "event", &event, undefined, undefined, undefined);
}

// Namespace zm_bgb_perkaholic
// Params 0, eflags: 0x1 linked
// namespace_1b7b1237<file_0>::function_279e4e97
// Checksum 0x1c9baa00, Offset: 0x218
// Size: 0x4c
function event() {
    self endon(#"disconnect");
    self endon(#"bgb_update");
    self zm_utility::function_82a5cc4();
    self bgb::do_one_shot_use(1);
    wait(0.05);
}

