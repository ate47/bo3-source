#using scripts/shared/ai/archetype_zombie_interface;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_utility;
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

#namespace namespace_9c39c8b3;

// Namespace namespace_9c39c8b3
// Params 0, eflags: 0x2
// namespace_9c39c8b3<file_0>::function_c35e6aab
// Checksum 0x22a25000, Offset: 0x598
// Size: 0x9c
function autoexec init() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("bonuszmZombieTraversalDoesAnimationExist", &function_6de9fa37);
    behaviortreenetworkutility::registerbehaviortreeaction("bonuszmSpecialTraverseAction", &function_88e9d5da, undefined, &function_dd1fc89b);
    animationstatenetwork::registeranimationmocomp("mocomp_bonuszm_special_traversal", &function_26c42b09, undefined, &function_47268b78);
}

// Namespace namespace_9c39c8b3
// Params 1, eflags: 0x5 linked
// namespace_9c39c8b3<file_0>::function_6de9fa37
// Checksum 0x7944fe09, Offset: 0x640
// Size: 0x316
function private function_6de9fa37(entity) {
    assert(isdefined(entity.traversestartnode));
    var_f6b30806 = isdefined(entity.traverseendnode) && (isdefined(entity.traversestartnode) && entity.traversestartnode.script_noteworthy === "custom_traversal" || entity.traverseendnode.script_noteworthy === "custom_traversal");
    if (var_f6b30806) {
        if (isdefined(entity.traversestartnode) && !issubstr(entity.traversestartnode.animscript, "human")) {
            /#
                if (isdefined(entity.traversestartnode.animscript)) {
                    iprintln("animation" + entity.traversestartnode.animscript);
                }
            #/
            return false;
        }
        if (isdefined(entity.traverseendnode) && !issubstr(entity.traversestartnode.animscript, "human")) {
            /#
                if (isdefined(entity.traversestartnode.animscript)) {
                    iprintln("animation" + entity.traversestartnode.animscript);
                }
            #/
            return false;
        }
        return true;
    }
    blackboard::setblackboardattribute(entity, "_traversal_type", entity.traversestartnode.animscript);
    if (entity.missinglegs === 1) {
        var_be841c75 = entity astsearch(istring("traverse_legless@zombie"));
    } else {
        var_be841c75 = entity astsearch(istring("traverse@zombie"));
    }
    if (isdefined(var_be841c75["animation"])) {
        return true;
    }
    /#
        if (isdefined(entity.traversestartnode.animscript)) {
            iprintln("animation" + entity.traversestartnode.animscript);
        }
    #/
    return false;
}

// Namespace namespace_9c39c8b3
// Params 2, eflags: 0x5 linked
// namespace_9c39c8b3<file_0>::function_88e9d5da
// Checksum 0xf705e76, Offset: 0x960
// Size: 0x80
function private function_88e9d5da(entity, asmstatename) {
    animationstatenetworkutility::requeststate(entity, asmstatename);
    entity ghost();
    entity notsolid();
    entity clientfield::set("zombie_appear_vanish_fx", 1);
    return 5;
}

// Namespace namespace_9c39c8b3
// Params 2, eflags: 0x5 linked
// namespace_9c39c8b3<file_0>::function_dd1fc89b
// Checksum 0x7f09f25d, Offset: 0x9e8
// Size: 0x68
function private function_dd1fc89b(entity, asmstatename) {
    entity clientfield::set("zombie_appear_vanish_fx", 3);
    entity show();
    entity solid();
    return 4;
}

// Namespace namespace_9c39c8b3
// Params 5, eflags: 0x5 linked
// namespace_9c39c8b3<file_0>::function_26c42b09
// Checksum 0xc47bc402, Offset: 0xa58
// Size: 0x1d0
function private function_26c42b09(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity setrepairpaths(0);
    locomotionspeed = blackboard::getblackboardattribute(entity, "_locomotion_speed");
    if (locomotionspeed == "locomotion_speed_walk") {
        rate = 1.5;
    } else if (locomotionspeed == "locomotion_speed_run") {
        rate = 2;
    } else {
        rate = 3;
    }
    entity asmsetanimationrate(rate);
    if (entity haspath()) {
        entity.var_51ea7126 = entity.pathgoalpos;
    }
    assert(isdefined(entity.traverseendnode));
    entity forceteleport(entity.traverseendnode.origin, entity.angles);
    entity animmode("noclip", 0);
    entity.blockingpain = 1;
}

// Namespace namespace_9c39c8b3
// Params 5, eflags: 0x5 linked
// namespace_9c39c8b3<file_0>::function_47268b78
// Checksum 0x22257f19, Offset: 0xc30
// Size: 0xbc
function private function_47268b78(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.blockingpain = 0;
    entity setrepairpaths(1);
    if (isdefined(entity.var_51ea7126)) {
        entity setgoal(entity.var_51ea7126);
    }
    entity asmsetanimationrate(1);
    entity finishtraversal();
}

