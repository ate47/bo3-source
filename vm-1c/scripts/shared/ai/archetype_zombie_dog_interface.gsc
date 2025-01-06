#using scripts/shared/ai/behavior_zombie_dog;
#using scripts/shared/ai/systems/ai_interface;

#namespace namespace_273d1a1c;

// Namespace namespace_273d1a1c
// Params 0, eflags: 0x0
// Checksum 0x26b16e52, Offset: 0x110
// Size: 0xbc
function registerzombiedoginterfaceattributes() {
    ai::registermatchedinterface("zombie_dog", "gravity", "normal", array("low", "normal"), &namespace_1db6d2c9::zombiedoggravity);
    ai::registermatchedinterface("zombie_dog", "min_run_dist", 500);
    ai::registermatchedinterface("zombie_dog", "sprint", 0, array(1, 0));
}

