#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/archetype_mannequin_interface;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie;
#using scripts/shared/spawner_shared;

#namespace mannequinbehavior;

// Namespace mannequinbehavior
// Params 0, eflags: 0x2
// Checksum 0x41c61abb, Offset: 0x1c8
// Size: 0x214
function autoexec init() {
    level.zm_variant_type_max = [];
    level.zm_variant_type_max["walk"] = [];
    level.zm_variant_type_max["run"] = [];
    level.zm_variant_type_max["sprint"] = [];
    level.zm_variant_type_max["walk"]["down"] = 14;
    level.zm_variant_type_max["walk"]["up"] = 16;
    level.zm_variant_type_max["run"]["down"] = 13;
    level.zm_variant_type_max["run"]["up"] = 12;
    level.zm_variant_type_max["sprint"]["down"] = 7;
    level.zm_variant_type_max["sprint"]["up"] = 6;
    spawner::add_archetype_spawn_function("mannequin", &zombiebehavior::archetypezombieblackboardinit);
    spawner::add_archetype_spawn_function("mannequin", &zombiebehavior::archetypezombiedeathoverrideinit);
    spawner::add_archetype_spawn_function("mannequin", &zombie_utility::zombiespawnsetup);
    spawner::add_archetype_spawn_function("mannequin", &mannequinspawnsetup);
    mannequininterface::registermannequininterfaceattributes();
    behaviortreenetworkutility::registerbehaviortreescriptapi("mannequinCollisionService", &mannequincollisionservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("mannequinShouldMelee", &mannequinshouldmelee);
}

// Namespace mannequinbehavior
// Params 1, eflags: 0x1 linked
// Checksum 0xc9c59dc4, Offset: 0x3e8
// Size: 0x9c
function mannequincollisionservice(entity) {
    if (isdefined(entity.enemy) && distancesquared(entity.origin, entity.enemy.origin) > 300 * 300) {
        entity function_1762804b(0);
        return;
    }
    entity function_1762804b(1);
}

// Namespace mannequinbehavior
// Params 1, eflags: 0x1 linked
// Checksum 0xedd38cba, Offset: 0x490
// Size: 0xc
function mannequinspawnsetup(entity) {
    
}

// Namespace mannequinbehavior
// Params 1, eflags: 0x5 linked
// Checksum 0xeb636fa1, Offset: 0x4a8
// Size: 0x18c
function private mannequinshouldmelee(entity) {
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (isdefined(entity.marked_for_death)) {
        return false;
    }
    if (isdefined(entity.ignoremelee) && entity.ignoremelee) {
        return false;
    }
    if (distance2dsquared(entity.origin, entity.enemy.origin) > 64 * 64) {
        return false;
    }
    if (abs(entity.origin[2] - entity.enemy.origin[2]) > 72) {
        return false;
    }
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
    if (abs(yawtoenemy) > 45) {
        return false;
    }
    return true;
}

