#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_1aa2e27a;

// Namespace namespace_1aa2e27a
// Params 0, eflags: 0x2
// Checksum 0xf339e233, Offset: 0x430
// Size: 0x64
function autoexec init() {
    function_d83c7355();
    spawner::add_archetype_spawn_function("human_clone", &function_41b5516c);
    spawner::add_archetype_spawn_function("human_clone", &function_8a466c);
}

// Namespace namespace_1aa2e27a
// Params 0, eflags: 0x4
// Checksum 0x99ec1590, Offset: 0x4a0
// Size: 0x4
function private function_d83c7355() {
    
}

// Namespace namespace_1aa2e27a
// Params 0, eflags: 0x4
// Checksum 0xe5aaea65, Offset: 0x4b0
// Size: 0x94
function private function_41b5516c() {
    entity = self;
    blackboard::createblackboardforentity(entity);
    entity aiutility::function_89e1fc16();
    ai::createinterfaceforentity(entity);
    entity.___archetypeonanimscriptedcallback = &function_3be187c2;
    /#
        entity finalizetrackedblackboardattributes();
    #/
}

// Namespace namespace_1aa2e27a
// Params 1, eflags: 0x4
// Checksum 0xdf1c244, Offset: 0x550
// Size: 0x34
function private function_3be187c2(entity) {
    entity.__blackboard = undefined;
    entity function_41b5516c();
}

// Namespace namespace_1aa2e27a
// Params 0, eflags: 0x4
// Checksum 0x825610f3, Offset: 0x590
// Size: 0x70
function private function_8d660ab4() {
    entity = self;
    entity endon(#"death");
    while (true) {
        if (isdefined(entity.enemy)) {
            entity getperfectinfo(entity.enemy, 1);
        }
        wait(0.05);
    }
}

// Namespace namespace_1aa2e27a
// Params 0, eflags: 0x4
// Checksum 0xcf81c61d, Offset: 0x608
// Size: 0xa4
function private function_8a466c() {
    entity = self;
    entity.ignoreme = 1;
    entity.ignoreall = 1;
    entity setcontents(8192);
    entity setavoidancemask("avoid none");
    entity setclone();
    entity thread function_8d660ab4();
}

#namespace namespace_16383e98;

// Namespace namespace_16383e98
// Params 3, eflags: 0x0
// Checksum 0x977ddce7, Offset: 0x6b8
// Size: 0x244
function function_c80742de(clone, cloneplayer, targetplayer) {
    /#
        assert(isactor(clone));
    #/
    /#
        assert(isplayer(cloneplayer));
    #/
    /#
        assert(isplayer(targetplayer));
    #/
    clone.owner = cloneplayer;
    clone setentitytarget(targetplayer, 1);
    clone setentityowner(cloneplayer);
    clone detachall();
    bodymodel = cloneplayer getcharacterbodymodel();
    if (isdefined(bodymodel)) {
        clone setmodel(bodymodel);
    }
    headmodel = cloneplayer getcharacterheadmodel();
    if (isdefined(headmodel) && headmodel != "tag_origin") {
        if (isdefined(clone.head)) {
            clone detach(clone.head);
        }
        clone attach(headmodel);
    }
    var_f1a3fa15 = cloneplayer getcharacterhelmetmodel();
    if (isdefined(var_f1a3fa15) && headmodel != "tag_origin") {
        clone attach(var_f1a3fa15);
    }
}

