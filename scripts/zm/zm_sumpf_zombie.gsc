#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_devgui;
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

#namespace namespace_e1bd9dd;

// Namespace namespace_e1bd9dd
// Params 0, eflags: 0x2
// Checksum 0x4788eca5, Offset: 0x3e8
// Size: 0x64
function autoexec init() {
    function_ee90a52a();
    setdvar("tu5_zmPathDistanceCheckTolarance", 20);
    setdvar("scr_zm_use_code_enemy_selection", 0);
    level.var_11c66679 = 1;
    level.var_1ace2307 = 2;
}

// Namespace namespace_e1bd9dd
// Params 0, eflags: 0x5 linked
// Checksum 0x442110ad, Offset: 0x458
// Size: 0x84
function private function_ee90a52a() {
    animationstatenetwork::registeranimationmocomp("mocomp_teleport_traversal@zombie", &function_5683b5d5, undefined, undefined);
    behaviortreenetworkutility::registerbehaviortreescriptapi("zodShouldMove", &function_d0ef2cea);
    spawner::add_archetype_spawn_function("zombie", &function_5bf6989a);
}

// Namespace namespace_e1bd9dd
// Params 5, eflags: 0x1 linked
// Checksum 0xa12ef3a8, Offset: 0x4e8
// Size: 0x19c
function function_5683b5d5(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("normal");
    if (isdefined(entity.traverseendnode)) {
        /#
            print3d(entity.traversestartnode.origin, "<unknown string>", (1, 0, 0), 1, 1, 60);
            print3d(entity.traverseendnode.origin, "<unknown string>", (0, 1, 0), 1, 1, 60);
            line(entity.traversestartnode.origin, entity.traverseendnode.origin, (0, 1, 0), 1, 0, 60);
        #/
        entity forceteleport(entity.traverseendnode.origin, entity.traverseendnode.angles, 0);
    }
}

// Namespace namespace_e1bd9dd
// Params 1, eflags: 0x1 linked
// Checksum 0x98bdd08b, Offset: 0x690
// Size: 0x18a
function function_d0ef2cea(entity) {
    if (isdefined(entity.var_128cd975) && entity.var_128cd975 && !(isdefined(entity.tesla_death) && entity.tesla_death)) {
        return false;
    }
    if (isdefined(entity.pushed) && entity.pushed) {
        return false;
    }
    if (isdefined(entity.knockdown) && entity.knockdown) {
        return false;
    }
    if (isdefined(entity.grapple_is_fatal) && entity.grapple_is_fatal) {
        return false;
    }
    if (level.wait_and_revive) {
        if (!(isdefined(entity.var_1e3fb1c) && entity.var_1e3fb1c)) {
            return false;
        }
    }
    if (isdefined(entity.stumble)) {
        return false;
    }
    if (zombiebehavior::zombieshouldmeleecondition(entity)) {
        return false;
    }
    if (entity haspath()) {
        return true;
    }
    if (isdefined(entity.keep_moving) && entity.keep_moving) {
        return true;
    }
    return false;
}

// Namespace namespace_e1bd9dd
// Params 0, eflags: 0x5 linked
// Checksum 0x98553d4c, Offset: 0x828
// Size: 0x1c
function private function_5bf6989a() {
    self.cant_move_cb = &function_9f18c3b1;
}

// Namespace namespace_e1bd9dd
// Params 0, eflags: 0x5 linked
// Checksum 0x57fab375, Offset: 0x850
// Size: 0x2c
function private function_9f18c3b1() {
    self function_1762804b(0);
    self.enablepushtime = gettime() + 1000;
}

