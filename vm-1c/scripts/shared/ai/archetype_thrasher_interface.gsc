#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/archetype_thrasher;

#namespace namespace_66565bbf;

// Namespace namespace_66565bbf
// Params 0, eflags: 0x1 linked
// namespace_66565bbf<file_0>::function_347a8745
// Checksum 0xfae534bd, Offset: 0x118
// Size: 0xcc
function function_347a8745() {
    ai::registermatchedinterface("thrasher", "stunned", 0, array(1, 0));
    ai::registermatchedinterface("thrasher", "move_mode", "normal", array("normal", "friendly"), &namespace_5d6075c6::function_91b1c35d);
    ai::registermatchedinterface("thrasher", "use_attackable", 0, array(1, 0));
}

