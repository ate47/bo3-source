#using scripts/codescripts/struct;
#using scripts/shared/array_shared;

#namespace zm_game_module_utility;

// Namespace zm_game_module_utility
// Params 1, eflags: 0x0
// Checksum 0xc2ea6a80, Offset: 0xc8
// Size: 0x122
function move_ring(ring) {
    positions = struct::get_array(ring.target, "targetname");
    positions = array::randomize(positions);
    level endon(#"end_game");
    while (true) {
        foreach (position in positions) {
            self moveto(position.origin, randomintrange(30, 45));
            self waittill(#"movedone");
        }
    }
}

// Namespace zm_game_module_utility
// Params 1, eflags: 0x0
// Checksum 0x2b93d922, Offset: 0x1f8
// Size: 0x66
function rotate_ring(forward) {
    level endon(#"end_game");
    dir = -360;
    if (forward) {
        dir = 360;
    }
    while (true) {
        self rotateyaw(dir, 9);
        wait 9;
    }
}

