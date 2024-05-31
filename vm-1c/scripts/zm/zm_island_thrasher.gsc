#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_behavior;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_105f13a2;

// Namespace namespace_105f13a2
// Params 0, eflags: 0x2
// namespace_105f13a2<file_0>::function_c35e6aab
// Checksum 0x9963c57d, Offset: 0x2f8
// Size: 0x2c
function autoexec init() {
    spawner::add_archetype_spawn_function("thrasher", &function_f8333089);
}

// Namespace namespace_105f13a2
// Params 0, eflags: 0x5 linked
// namespace_105f13a2<file_0>::function_f8333089
// Checksum 0xc2819eff, Offset: 0x330
// Size: 0x1c
function private function_f8333089() {
    self thread function_9b57ea16();
}

// Namespace namespace_105f13a2
// Params 0, eflags: 0x5 linked
// namespace_105f13a2<file_0>::function_9b57ea16
// Checksum 0xbccb2b13, Offset: 0x358
// Size: 0x34
function private function_9b57ea16() {
    self endon(#"death");
    wait(1);
    self ai::set_behavior_attribute("use_attackable", 1);
}

