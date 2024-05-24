#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/archetype_apothicon_fury;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/ai_blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/util_shared;

#namespace namespace_55e12b83;

// Namespace namespace_55e12b83
// Params 0, eflags: 0x0
// Checksum 0xaea2fca8, Offset: 0x210
// Size: 0x114
function function_dbcea833() {
    ai::registermatchedinterface("apothicon_fury", "can_juke", 1, array(1, 0));
    ai::registermatchedinterface("apothicon_fury", "can_bamf", 1, array(1, 0));
    ai::registermatchedinterface("apothicon_fury", "can_be_furious", 1, array(1, 0));
    ai::registermatchedinterface("apothicon_fury", "move_speed", "walk", array("walk", "run", "sprint", "super_sprint"), &namespace_1be547d::function_20a7d744);
}

