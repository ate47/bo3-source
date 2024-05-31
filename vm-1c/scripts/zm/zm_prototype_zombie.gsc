#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_devgui;
#using scripts/zm/zm_remaster_zombie;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie;
#using scripts/shared/laststand_shared;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_b61b7316;

// Namespace namespace_b61b7316
// Params 0, eflags: 0x2
// namespace_b61b7316<file_0>::function_c35e6aab
// Checksum 0xdd362c52, Offset: 0x3a8
// Size: 0x64
function autoexec init() {
    setdvar("scr_zm_use_code_enemy_selection", 0);
    level.closest_player_override = &namespace_1d57720d::function_3ff94b60;
    level thread namespace_1d57720d::function_72e6c1d6();
    level.var_11c66679 = 1;
    level.var_1ace2307 = 2;
}

