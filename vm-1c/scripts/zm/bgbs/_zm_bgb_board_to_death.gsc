#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_bgb;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_4a25f1d2;

// Namespace namespace_4a25f1d2
// Params 0, eflags: 0x2
// namespace_4a25f1d2<file_0>::function_2dc19561
// Checksum 0x36de24e4, Offset: 0x170
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_bgb_board_to_death", &__init__, undefined, "bgb");
}

// Namespace namespace_4a25f1d2
// Params 0, eflags: 0x1 linked
// namespace_4a25f1d2<file_0>::function_8c87d8eb
// Checksum 0xad1708bc, Offset: 0x1b0
// Size: 0x5c
function __init__() {
    if (!(isdefined(level.bgb_in_use) && level.bgb_in_use)) {
        return;
    }
    bgb::register("zm_bgb_board_to_death", "time", 300, &enable, &disable, undefined);
}

// Namespace namespace_4a25f1d2
// Params 0, eflags: 0x1 linked
// namespace_4a25f1d2<file_0>::function_bae40a28
// Checksum 0x283366a0, Offset: 0x218
// Size: 0x1c
function enable() {
    self thread function_3c61f2df();
}

// Namespace namespace_4a25f1d2
// Params 0, eflags: 0x1 linked
// namespace_4a25f1d2<file_0>::function_54bdb053
// Checksum 0x99ec1590, Offset: 0x240
// Size: 0x4
function disable() {
    
}

// Namespace namespace_4a25f1d2
// Params 0, eflags: 0x1 linked
// namespace_4a25f1d2<file_0>::function_3c61f2df
// Checksum 0x1c8c7534, Offset: 0x250
// Size: 0x78
function function_3c61f2df() {
    self endon(#"disconnect");
    self endon(#"bled_out");
    self endon(#"bgb_update");
    while (true) {
        s_window = self waittill(#"boarding_window");
        self bgb::do_one_shot_use();
        self thread function_64ea6cea(s_window);
    }
}

// Namespace namespace_4a25f1d2
// Params 1, eflags: 0x1 linked
// namespace_4a25f1d2<file_0>::function_64ea6cea
// Checksum 0x21a8fc74, Offset: 0x2d0
// Size: 0x166
function function_64ea6cea(s_window) {
    wait(0.3);
    a_ai = getaiteamarray(level.zombie_team);
    a_closest = arraysortclosest(a_ai, s_window.origin, a_ai.size, 0, -76);
    for (i = 0; i < a_closest.size; i++) {
        if (a_closest[i].archetype === "zombie" && isalive(a_closest[i])) {
            a_closest[i] dodamage(a_closest[i].health + 100, a_closest[i].origin);
            a_closest[i] playsound("zmb_bgb_boardtodeath_imp");
            wait(randomfloatrange(0.05, 0.2));
        }
    }
}

