#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/array_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/ai_shared;

#namespace namespace_937d31fa;

// Namespace namespace_937d31fa
// Params 0, eflags: 0x2
// Checksum 0xf8ca25e9, Offset: 0x500
// Size: 0x64
function autoexec init() {
    initzombiebehaviorsandasm();
    spawner::add_archetype_spawn_function("zombie_quad", &function_deba043e);
    spawner::add_archetype_spawn_function("zombie_quad", &function_591dd6a0);
}

// Namespace namespace_937d31fa
// Params 0, eflags: 0x1 linked
// Checksum 0xea8ae66b, Offset: 0x570
// Size: 0x1ec
function function_deba043e() {
    blackboard::createblackboardforentity(self);
    self aiutility::function_89e1fc16();
    ai::createinterfaceforentity(self);
    blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_walk", &zombiebehavior::function_f8ae4008);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("normal");
        #/
    }
    blackboard::registerblackboardattribute(self, "_quad_wall_crawl", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("normal");
        #/
    }
    blackboard::registerblackboardattribute(self, "_quad_phase_direction", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("normal");
        #/
    }
    blackboard::registerblackboardattribute(self, "_quad_phase_distance", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("normal");
        #/
    }
    self.___archetypeonanimscriptedcallback = &function_7fcb8a90;
    /#
        self finalizetrackedblackboardattributes();
    #/
}

// Namespace namespace_937d31fa
// Params 1, eflags: 0x5 linked
// Checksum 0x9ba23d08, Offset: 0x768
// Size: 0x34
function private function_7fcb8a90(entity) {
    entity.__blackboard = undefined;
    entity function_deba043e();
}

// Namespace namespace_937d31fa
// Params 0, eflags: 0x5 linked
// Checksum 0x3fdcd04f, Offset: 0x7a8
// Size: 0x34
function private initzombiebehaviorsandasm() {
    animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@zombie_quad", &function_45557eb8, undefined, undefined);
}

// Namespace namespace_937d31fa
// Params 0, eflags: 0x1 linked
// Checksum 0x53578ec6, Offset: 0x7e8
// Size: 0x1c
function function_591dd6a0() {
    self setpitchorient();
}

// Namespace namespace_937d31fa
// Params 5, eflags: 0x1 linked
// Checksum 0x9e0e2c39, Offset: 0x810
// Size: 0x19c
function function_45557eb8(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("normal");
    if (isdefined(entity.traverseendnode)) {
        /#
            print3d(entity.traversestartnode.origin, "normal", (1, 0, 0), 1, 1, 60);
            print3d(entity.traverseendnode.origin, "normal", (0, 1, 0), 1, 1, 60);
            line(entity.traversestartnode.origin, entity.traverseendnode.origin, (0, 1, 0), 1, 0, 60);
        #/
        entity forceteleport(entity.traverseendnode.origin, entity.traverseendnode.angles, 0);
    }
}

