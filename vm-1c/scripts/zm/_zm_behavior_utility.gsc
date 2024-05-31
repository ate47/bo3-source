#using scripts/zm/_zm_spawner;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;

#namespace zm_behavior_utility;

// Namespace zm_behavior_utility
// Params 0, eflags: 0x1 linked
// namespace_e2cf0456<file_0>::function_8896f283
// Checksum 0x772e4ebb, Offset: 0x218
// Size: 0x1c
function setupattackproperties() {
    self.ignoreall = 0;
    self.meleeattackdist = 64;
}

// Namespace zm_behavior_utility
// Params 0, eflags: 0x1 linked
// namespace_e2cf0456<file_0>::function_50d970f7
// Checksum 0x308197b7, Offset: 0x240
// Size: 0x3c
function enteredplayablearea() {
    self zm_spawner::zombie_complete_emerging_into_playable_area();
    self.pushable = 1;
    self setupattackproperties();
}

