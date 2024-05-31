#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/ai/archetype_cover_utility;
#using scripts/shared/ai/archetype_human_rpg_interface;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/spawner_shared;
#using scripts/shared/math_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/ai_shared;

#namespace archetype_human_rpg;

// Namespace archetype_human_rpg
// Params 0, eflags: 0x2
// namespace_7c02b67c<file_0>::function_d290ebfa
// Checksum 0xacb3173c, Offset: 0x388
// Size: 0x4c
function autoexec main() {
    spawner::add_archetype_spawn_function("human_rpg", &humanrpgbehavior::archetypehumanrpgblackboardinit);
    humanrpgbehavior::registerbehaviorscriptfunctions();
    humanrpginterface::registerhumanrpginterfaceattributes();
}

#namespace humanrpgbehavior;

// Namespace humanrpgbehavior
// Params 0, eflags: 0x1 linked
// namespace_384a282f<file_0>::function_a13b795c
// Checksum 0x99ec1590, Offset: 0x3e0
// Size: 0x4
function registerbehaviorscriptfunctions() {
    
}

// Namespace humanrpgbehavior
// Params 0, eflags: 0x5 linked
// namespace_384a282f<file_0>::function_f1c0fe37
// Checksum 0x71e239a7, Offset: 0x3f0
// Size: 0xa4
function private archetypehumanrpgblackboardinit() {
    entity = self;
    blackboard::createblackboardforentity(entity);
    ai::createinterfaceforentity(entity);
    entity aiutility::function_89e1fc16();
    self.___archetypeonanimscriptedcallback = &archetypehumanrpgonanimscriptedcallback;
    /#
        entity finalizetrackedblackboardattributes();
    #/
    entity asmchangeanimmappingtable(1);
}

// Namespace humanrpgbehavior
// Params 1, eflags: 0x5 linked
// namespace_384a282f<file_0>::function_b99d0ab1
// Checksum 0x90e3a80c, Offset: 0x4a0
// Size: 0x34
function private archetypehumanrpgonanimscriptedcallback(entity) {
    entity.__blackboard = undefined;
    entity archetypehumanrpgblackboardinit();
}

