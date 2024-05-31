#using scripts/shared/vehicles/_raps;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/destructible_character;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/behavior_state_machine;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/ai_squads;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/ai_blackboard;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/archetype_robot_interface;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/ai/archetype_cover_utility;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/math_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/ai_shared;

#namespace archetype_robot;

// Namespace archetype_robot
// Params 0, eflags: 0x2
// namespace_a814baaf<file_0>::function_2dc19561
// Checksum 0x21f84e4a, Offset: 0x14b8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("robot", &__init__, undefined, undefined);
}

// Namespace archetype_robot
// Params 0, eflags: 0x1 linked
// namespace_a814baaf<file_0>::function_8c87d8eb
// Checksum 0x216de72d, Offset: 0x14f8
// Size: 0x14c
function __init__() {
    spawner::add_archetype_spawn_function("robot", &robotsoldierbehavior::archetyperobotblackboardinit);
    spawner::add_archetype_spawn_function("robot", &robotsoldierserverutils::robotsoldierspawnsetup);
    if (ai::shouldregisterclientfieldforarchetype("robot")) {
        clientfield::register("actor", "robot_mind_control", 1, 2, "int");
        clientfield::register("actor", "robot_mind_control_explosion", 1, 1, "int");
        clientfield::register("actor", "robot_lights", 1, 3, "int");
        clientfield::register("actor", "robot_EMP", 1, 1, "int");
    }
    robotinterface::registerrobotinterfaceattributes();
    robotsoldierbehavior::registerbehaviorscriptfunctions();
}

#namespace robotsoldierbehavior;

// Namespace robotsoldierbehavior
// Params 0, eflags: 0x1 linked
// namespace_271fbeb5<file_0>::function_a13b795c
// Checksum 0x55ded62f, Offset: 0x1650
// Size: 0x105c
function registerbehaviorscriptfunctions() {
    behaviortreenetworkutility::registerbehaviortreeaction("robotStepIntoAction", &stepintoinitialize, undefined, &stepintoterminate);
    behaviortreenetworkutility::registerbehaviortreeaction("robotStepOutAction", &stepoutinitialize, undefined, &stepoutterminate);
    behaviortreenetworkutility::registerbehaviortreeaction("robotTakeOverAction", &takeoverinitialize, undefined, &takeoverterminate);
    behaviortreenetworkutility::registerbehaviortreeaction("robotEmpIdleAction", &robotempidleinitialize, &robotempidleupdate, &robotempidleterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotBecomeCrawler", &robotbecomecrawler);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotDropStartingWeapon", &robotdropstartingweapon);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotDontTakeCover", &robotdonttakecover);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotCoverOverInitialize", &robotcoveroverinitialize);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotCoverOverTerminate", &robotcoveroverterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotExplode", &robotexplode);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotExplodeTerminate", &robotexplodeterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotDeployMiniRaps", &robotdeployminiraps);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotMoveToPlayer", &movetoplayerupdate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotStartSprint", &robotstartsprint);
    behaviorstatemachine::registerbsmscriptapiinternal("robotStartSprint", &robotstartsprint);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotStartSuperSprint", &robotstartsupersprint);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotTacticalWalkActionStart", &robottacticalwalkactionstart);
    behaviorstatemachine::registerbsmscriptapiinternal("robotTacticalWalkActionStart", &robottacticalwalkactionstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotDie", &robotdie);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotCleanupChargeMeleeAttack", &robotcleanupchargemeleeattack);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotIsMoving", &robotismoving);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotAbleToShoot", &robotabletoshootcondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotCrawlerCanShootEnemy", &robotcrawlercanshootenemy);
    behaviortreenetworkutility::registerbehaviortreescriptapi("canMoveToEnemy", &canmovetoenemycondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("canMoveCloseToEnemy", &canmoveclosetoenemycondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("hasMiniRaps", &hasminiraps);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotIsAtCover", &robotisatcovercondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldTacticalWalk", &robotshouldtacticalwalk);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotHasCloseEnemyToMelee", &robothascloseenemytomelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotHasEnemyToMelee", &robothasenemytomelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotRogueHasCloseEnemyToMelee", &robotroguehascloseenemytomelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotRogueHasEnemyToMelee", &robotroguehasenemytomelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotIsCrawler", &robotiscrawler);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotIsMarching", &robotismarching);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotPrepareForAdjustToCover", &robotprepareforadjusttocover);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldAdjustToCover", &robotshouldadjusttocover);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldBecomeCrawler", &robotshouldbecomecrawler);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldReactAtCover", &robotshouldreactatcover);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldExplode", &robotshouldexplode);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldShutdown", &robotshouldshutdown);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotSupportsOverCover", &robotsupportsovercover);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldStepIn", &shouldstepincondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldTakeOver", &shouldtakeovercondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("supportsStepOut", &supportsstepoutcondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("setDesiredStanceToStand", &setdesiredstancetostand);
    behaviortreenetworkutility::registerbehaviortreescriptapi("setDesiredStanceToCrouch", &setdesiredstancetocrouch);
    behaviortreenetworkutility::registerbehaviortreescriptapi("toggleDesiredStance", &toggledesiredstance);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotMovement", &robotmovement);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotDelayMovement", &robotdelaymovement);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotInvalidateCover", &robotinvalidatecover);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldChargeMelee", &robotshouldchargemelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldMelee", &robotshouldmelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotScriptRequiresToSprint", &scriptrequirestosprintcondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotScanExposedPainTerminate", &robotscanexposedpainterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotTookEmpDamage", &robottookempdamage);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotNoCloseEnemyService", &robotnocloseenemyservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotWithinSprintRange", &robotwithinsprintrange);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotWithinSuperSprintRange", &robotwithinsupersprintrange);
    behaviorstatemachine::registerbsmscriptapiinternal("robotWithinSuperSprintRange", &robotwithinsupersprintrange);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotOutsideTacticalWalkRange", &robotoutsidetacticalwalkrange);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotOutsideSprintRange", &robotoutsidesprintrange);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotOutsideSuperSprintRange", &robotoutsidesupersprintrange);
    behaviorstatemachine::registerbsmscriptapiinternal("robotOutsideSuperSprintRange", &robotoutsidesupersprintrange);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotLightsOff", &robotlightsoff);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotLightsFlicker", &robotlightsflicker);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotLightsOn", &robotlightson);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldGibDeath", &robotshouldgibdeath);
    behaviortreenetworkutility::registerbehaviortreeaction("robotProceduralTraversal", &robottraversestart, &robotproceduraltraversalupdate, &robottraverseragdollondeath);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotCalcProceduralTraversal", &robotcalcproceduraltraversal);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotProceduralLanding", &robotprocedurallandingupdate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotTraverseEnd", &robottraverseend);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotTraverseRagdollOnDeath", &robottraverseragdollondeath);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldProceduralTraverse", &robotshouldproceduraltraverse);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotWallrunTraverse", &robotwallruntraverse);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotShouldWallrun", &robotshouldwallrun);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotSetupWallRunJump", &robotsetupwallrunjump);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotSetupWallRunLand", &robotsetupwallrunland);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotWallrunStart", &robotwallrunstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotWallrunEnd", &robotwallrunend);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotCanJuke", &robotcanjuke);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotCanTacticalJuke", &robotcantacticaljuke);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotCanPreemptiveJuke", &robotcanpreemptivejuke);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotJukeInitialize", &robotjukeinitialize);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotPreemptiveJukeTerminate", &robotpreemptivejuketerminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotCoverScanInitialize", &robotcoverscaninitialize);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotCoverScanTerminate", &robotcoverscanterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotIsAtCoverModeScan", &robotisatcovermodescan);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotExposedCoverService", &robotexposedcoverservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotPositionService", &robotpositionservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotTargetService", &robottargetservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotTryReacquireService", &robottryreacquireservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotRushEnemyService", &robotrushenemyservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotRushNeighborService", &robotrushneighborservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotCrawlerService", &robotcrawlerservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("robotMoveToPlayerService", &movetoplayerupdate);
    animationstatenetwork::registeranimationmocomp("mocomp_ignore_pain_face_enemy", &mocompignorepainfaceenemyinit, &mocompignorepainfaceenemyupdate, &mocompignorepainfaceenemyterminate);
    animationstatenetwork::registeranimationmocomp("robot_procedural_traversal", &mocomprobotproceduraltraversalinit, &mocomprobotproceduraltraversalupdate, &mocomprobotproceduraltraversalterminate);
    animationstatenetwork::registeranimationmocomp("robot_start_traversal", &mocomprobotstarttraversalinit, undefined, &mocomprobotstarttraversalterminate);
    animationstatenetwork::registeranimationmocomp("robot_start_wallrun", &mocomprobotstartwallruninit, &mocomprobotstartwallrunupdate, &mocomprobotstartwallrunterminate);
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x1 linked
// namespace_271fbeb5<file_0>::function_af565ab7
// Checksum 0x3f5a3671, Offset: 0x26b8
// Size: 0x5c
function robotcleanupchargemeleeattack(behaviortreeentity) {
    aiutility::meleereleasemutex(behaviortreeentity);
    aiutility::releaseclaimnode(behaviortreeentity);
    blackboard::setblackboardattribute(behaviortreeentity, "_melee_enemy_type", undefined);
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_6b67969b
// Checksum 0x2fdf2c1d, Offset: 0x2720
// Size: 0x58
function private robotlightsoff(entity, asmstatename) {
    entity ai::set_behavior_attribute("robot_lights", 2);
    clientfield::set("robot_EMP", 1);
    return 4;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_b2dce1c8
// Checksum 0x9a9989af, Offset: 0x2780
// Size: 0x68
function private robotlightsflicker(entity, asmstatename) {
    entity ai::set_behavior_attribute("robot_lights", 1);
    clientfield::set("robot_EMP", 1);
    entity notify(#"emp_fx_start");
    return 4;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_3b409b27
// Checksum 0xa13d03c4, Offset: 0x27f0
// Size: 0x50
function private robotlightson(entity, asmstatename) {
    entity ai::set_behavior_attribute("robot_lights", 0);
    clientfield::set("robot_EMP", 0);
    return 4;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_32ab11e
// Checksum 0x3bf60785, Offset: 0x2848
// Size: 0x22
function private robotshouldgibdeath(entity, asmstatename) {
    return entity.gibdeath;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_785ad63b
// Checksum 0xaa4fa4c6, Offset: 0x2878
// Size: 0x60
function private robotempidleinitialize(entity, asmstatename) {
    entity.empstoptime = gettime() + entity.empshutdowntime;
    animationstatenetworkutility::requeststate(entity, asmstatename);
    entity notify(#"emp_shutdown_start");
    return 5;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_2356a116
// Checksum 0x4f438208, Offset: 0x28e0
// Size: 0x8e
function private robotempidleupdate(entity, asmstatename) {
    if (gettime() < entity.empstoptime || entity ai::get_behavior_attribute("shutdown")) {
        if (entity asmgetstatus() == "asm_status_complete") {
            animationstatenetworkutility::requeststate(entity, asmstatename);
        }
        return 5;
    }
    return 4;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_f8d2f222
// Checksum 0xed902163, Offset: 0x2978
// Size: 0x28
function private robotempidleterminate(entity, asmstatename) {
    entity notify(#"emp_shutdown_end");
    return 4;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x1 linked
// namespace_271fbeb5<file_0>::function_a442e283
// Checksum 0x5c7f5b2a, Offset: 0x29a8
// Size: 0xfe
function robotproceduraltraversalupdate(entity, asmstatename) {
    assert(isdefined(entity.traversal));
    traversal = entity.traversal;
    t = min((gettime() - traversal.starttime) / traversal.totaltime, 1);
    curveremaining = traversal.curvelength * (1 - t);
    if (curveremaining < traversal.landingdistance) {
        traversal.landing = 1;
        return 4;
    }
    return 5;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x1 linked
// namespace_271fbeb5<file_0>::function_283c0cf4
// Checksum 0xf272cfcd, Offset: 0x2ab0
// Size: 0x40
function robotprocedurallandingupdate(entity, asmstatename) {
    if (isdefined(entity.traversal)) {
        entity finishtraversal();
    }
    return 5;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x1 linked
// namespace_271fbeb5<file_0>::function_c43de971
// Checksum 0x26170401, Offset: 0x2af8
// Size: 0xb58
function robotcalcproceduraltraversal(entity, asmstatename) {
    if (!isdefined(entity.traversestartnode) || !isdefined(entity.traverseendnode)) {
        return true;
    }
    entity.traversal = spawnstruct();
    traversal = entity.traversal;
    traversal.landingdistance = 24;
    traversal.minimumspeed = 18;
    traversal.startnode = entity.traversestartnode;
    traversal.endnode = entity.traverseendnode;
    startiswallrun = traversal.startnode.spawnflags & 2048;
    endiswallrun = traversal.endnode.spawnflags & 2048;
    traversal.startpoint1 = entity.origin;
    traversal.endpoint1 = traversal.endnode.origin;
    if (endiswallrun) {
        facenormal = getnavmeshfacenormal(traversal.endpoint1, 30);
        traversal.endpoint1 += facenormal * 30 / 2;
    }
    if (!isdefined(traversal.endpoint1)) {
        traversal.endpoint1 = traversal.endnode.origin;
    }
    traversal.distancetoend = distance(traversal.startpoint1, traversal.endpoint1);
    traversal.absheighttoend = abs(traversal.startpoint1[2] - traversal.endpoint1[2]);
    traversal.abslengthtoend = distance2d(traversal.startpoint1, traversal.endpoint1);
    speedboost = 0;
    if (traversal.abslengthtoend > -56) {
        speedboost = 16;
    } else if (traversal.abslengthtoend > 120) {
        speedboost = 8;
    } else if (traversal.abslengthtoend > 80 || traversal.absheighttoend > 80) {
        speedboost = 4;
    }
    if (isdefined(entity.traversalspeedboost)) {
        speedboost = entity [[ entity.traversalspeedboost ]]();
    }
    traversal.speedoncurve = (traversal.minimumspeed + speedboost) * 12;
    heightoffset = max(traversal.absheighttoend * 0.8, min(traversal.abslengthtoend, 96));
    traversal.startpoint2 = entity.origin + (0, 0, heightoffset);
    traversal.endpoint2 = traversal.endpoint1 + (0, 0, heightoffset);
    if (traversal.startpoint1[2] < traversal.endpoint1[2]) {
        traversal.startpoint2 += (0, 0, traversal.absheighttoend);
    } else {
        traversal.endpoint2 += (0, 0, traversal.absheighttoend);
    }
    if (startiswallrun || endiswallrun) {
        startdirection = robotstartjumpdirection();
        enddirection = robotendjumpdirection();
        if (startdirection == "out") {
            point2scale = 0.5;
            towardend = (traversal.endnode.origin - entity.origin) * point2scale;
            traversal.startpoint2 = entity.origin + (towardend[0], towardend[1], 0);
            traversal.endpoint2 = traversal.endpoint1 + (0, 0, traversal.absheighttoend * point2scale);
            traversal.angles = entity.angles;
        }
        if (enddirection == "in") {
            point2scale = 0.5;
            towardstart = (entity.origin - traversal.endnode.origin) * point2scale;
            traversal.startpoint2 = entity.origin + (0, 0, traversal.absheighttoend * point2scale);
            traversal.endpoint2 = traversal.endnode.origin + (towardstart[0], towardstart[1], 0);
            facenormal = getnavmeshfacenormal(traversal.endnode.origin, 30);
            direction = _calculatewallrundirection(traversal.startnode.origin, traversal.endnode.origin);
            movedirection = vectorcross(facenormal, (0, 0, 1));
            if (direction == "right") {
                movedirection *= -1;
            }
            traversal.angles = vectortoangles(movedirection);
        }
        if (endiswallrun) {
            traversal.landingdistance = 110;
        } else {
            traversal.landingdistance = 60;
        }
        traversal.speedoncurve *= 1.2;
    }
    /#
        recordline(traversal.startpoint1, traversal.startpoint2, (1, 0.5, 0), "robotStepOutAction", entity);
        recordline(traversal.startpoint1, traversal.endpoint1, (1, 0.5, 0), "robotStepOutAction", entity);
        recordline(traversal.endpoint1, traversal.endpoint2, (1, 0.5, 0), "robotStepOutAction", entity);
        recordline(traversal.startpoint2, traversal.endpoint2, (1, 0.5, 0), "robotStepOutAction", entity);
        record3dtext(traversal.abslengthtoend, traversal.endpoint1 + (0, 0, 12), (1, 0.5, 0), "robotStepOutAction", entity);
    #/
    segments = 10;
    previouspoint = traversal.startpoint1;
    traversal.curvelength = 0;
    for (index = 1; index <= segments; index++) {
        t = index / segments;
        nextpoint = calculatecubicbezier(t, traversal.startpoint1, traversal.startpoint2, traversal.endpoint2, traversal.endpoint1);
        /#
            recordline(previouspoint, nextpoint, (0, 1, 0), "robotStepOutAction", entity);
        #/
        traversal.curvelength += distance(previouspoint, nextpoint);
        previouspoint = nextpoint;
    }
    traversal.starttime = gettime();
    traversal.endtime = traversal.starttime + traversal.curvelength * 1000 / traversal.speedoncurve;
    traversal.totaltime = traversal.endtime - traversal.starttime;
    traversal.landing = 0;
    return true;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x1 linked
// namespace_271fbeb5<file_0>::function_e6f0d3db
// Checksum 0x87fb7673, Offset: 0x3658
// Size: 0xe0
function robottraversestart(entity, asmstatename) {
    entity.skipdeath = 1;
    traversal = entity.traversal;
    traversal.starttime = gettime();
    traversal.endtime = traversal.starttime + traversal.curvelength * 1000 / traversal.speedoncurve;
    traversal.totaltime = traversal.endtime - traversal.starttime;
    animationstatenetworkutility::requeststate(entity, asmstatename);
    return 5;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x1 linked
// namespace_271fbeb5<file_0>::function_d4473cb8
// Checksum 0xc3c5ff11, Offset: 0x3740
// Size: 0x54
function robottraverseend(entity) {
    robottraverseragdollondeath(entity);
    entity.skipdeath = 0;
    entity.traversal = undefined;
    entity notify(#"traverse_end");
    return 4;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_fefde9c9
// Checksum 0x8908868a, Offset: 0x37a0
// Size: 0x48
function private robottraverseragdollondeath(entity, asmstatename) {
    if (!isalive(entity)) {
        entity startragdoll();
    }
    return 4;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_b8ceedc5
// Checksum 0xa809d124, Offset: 0x37f0
// Size: 0xb2
function private robotshouldproceduraltraverse(entity) {
    if (isdefined(entity.traversestartnode) && isdefined(entity.traverseendnode)) {
        isprocedural = entity ai::get_behavior_attribute("traversals") == "procedural" || entity.traversestartnode.spawnflags & 1024 || entity.traverseendnode.spawnflags & 1024;
        return isprocedural;
    }
    return 0;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_74575538
// Checksum 0xa2c18bfb, Offset: 0x38b0
// Size: 0xbe
function private robotwallruntraverse(entity) {
    startnode = entity.traversestartnode;
    endnode = entity.traverseendnode;
    if (isdefined(startnode) && isdefined(endnode) && entity shouldstarttraversal()) {
        startiswallrun = startnode.spawnflags & 2048;
        endiswallrun = endnode.spawnflags & 2048;
        return (startiswallrun || endiswallrun);
    }
    return false;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_73b783d9
// Checksum 0x732bd2e0, Offset: 0x3978
// Size: 0x34
function private robotshouldwallrun(entity) {
    return blackboard::getblackboardattribute(entity, "_robot_traversal_type") == "wall";
}

// Namespace robotsoldierbehavior
// Params 5, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_81204251
// Checksum 0xa457a717, Offset: 0x39b8
// Size: 0xd4
function private mocomprobotstartwallruninit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity setrepairpaths(0);
    entity orientmode("face angle", entity.angles[1]);
    entity.blockingpain = 1;
    entity.clamptonavmesh = 0;
    entity animmode("normal_nogravity", 0);
    entity setavoidancemask("avoid none");
}

// Namespace robotsoldierbehavior
// Params 5, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_c62ed314
// Checksum 0x5e42ea20, Offset: 0x3a98
// Size: 0x1f4
function private mocomprobotstartwallrunupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    facenormal = getnavmeshfacenormal(entity.origin, 30);
    positiononwall = getclosestpointonnavmesh(entity.origin, 30, 0);
    direction = blackboard::getblackboardattribute(entity, "_robot_wallrun_direction");
    if (isdefined(facenormal) && isdefined(positiononwall)) {
        facenormal = (facenormal[0], facenormal[1], 0);
        facenormal = vectornormalize(facenormal);
        movedirection = vectorcross(facenormal, (0, 0, 1));
        if (direction == "right") {
            movedirection *= -1;
        }
        forwardpositiononwall = getclosestpointonnavmesh(positiononwall + movedirection * 12, 30, 0);
        anglestoend = vectortoangles(forwardpositiononwall - positiononwall);
        /#
            recordline(positiononwall, forwardpositiononwall, (1, 0, 0), "robotStepOutAction", entity);
        #/
        entity orientmode("face angle", anglestoend[1]);
    }
}

// Namespace robotsoldierbehavior
// Params 5, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_f1b69444
// Checksum 0x4e48d9bd, Offset: 0x3c98
// Size: 0x88
function private mocomprobotstartwallrunterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity setrepairpaths(1);
    entity setavoidancemask("avoid all");
    entity.blockingpain = 0;
    entity.clamptonavmesh = 1;
}

// Namespace robotsoldierbehavior
// Params 5, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_c4469db2
// Checksum 0x14cabede, Offset: 0x3d28
// Size: 0xd2
function private calculatecubicbezier(t, p1, p2, p3, p4) {
    return pow(1 - t, 3) * p1 + 3 * pow(1 - t, 2) * t * p2 + 3 * (1 - t) * pow(t, 2) * p3 + pow(t, 3) * p4;
}

// Namespace robotsoldierbehavior
// Params 5, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_5c863814
// Checksum 0xbeb34710, Offset: 0x3e08
// Size: 0x394
function private mocomprobotstarttraversalinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    startnode = entity.traversestartnode;
    startiswallrun = startnode.spawnflags & 2048;
    endnode = entity.traverseendnode;
    endiswallrun = endnode.spawnflags & 2048;
    if (!endiswallrun) {
        angletoend = vectortoangles(entity.traverseendnode.origin - entity.traversestartnode.origin);
        entity orientmode("face angle", angletoend[1]);
        if (startiswallrun) {
            entity animmode("normal_nogravity", 0);
        } else {
            entity animmode("gravity", 0);
        }
    } else {
        facenormal = getnavmeshfacenormal(endnode.origin, 30);
        direction = _calculatewallrundirection(startnode.origin, endnode.origin);
        movedirection = vectorcross(facenormal, (0, 0, 1));
        if (direction == "right") {
            movedirection *= -1;
        }
        /#
            recordline(endnode.origin, endnode.origin + facenormal * 20, (1, 0, 0), "robotStepOutAction", entity);
        #/
        /#
            recordline(endnode.origin, endnode.origin + movedirection * 20, (1, 0, 0), "robotStepOutAction", entity);
        #/
        angles = vectortoangles(movedirection);
        entity orientmode("face angle", angles[1]);
        if (startiswallrun) {
            entity animmode("normal_nogravity", 0);
        } else {
            entity animmode("gravity", 0);
        }
    }
    entity setrepairpaths(0);
    entity.blockingpain = 1;
    entity.clamptonavmesh = 0;
    entity pathmode("dont move");
}

// Namespace robotsoldierbehavior
// Params 5, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_c007b743
// Checksum 0xae69cdb5, Offset: 0x41a8
// Size: 0x2c
function private mocomprobotstarttraversalterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    
}

// Namespace robotsoldierbehavior
// Params 5, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_9779af3
// Checksum 0x55c2af72, Offset: 0x41e0
// Size: 0x12c
function private mocomprobotproceduraltraversalinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    traversal = entity.traversal;
    entity setavoidancemask("avoid none");
    entity orientmode("face angle", entity.angles[1]);
    entity setrepairpaths(0);
    entity animmode("noclip", 0);
    entity.blockingpain = 1;
    entity.clamptonavmesh = 0;
    if (isdefined(traversal) && traversal.landing) {
        entity animmode("angle deltas", 0);
    }
}

// Namespace robotsoldierbehavior
// Params 5, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_c7991c52
// Checksum 0x52e22152, Offset: 0x4318
// Size: 0x21c
function private mocomprobotproceduraltraversalupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    traversal = entity.traversal;
    if (isdefined(traversal)) {
        if (entity ispaused()) {
            traversal.starttime += 50;
            return;
        }
        endiswallrun = traversal.endnode.spawnflags & 2048;
        realt = (gettime() - traversal.starttime) / traversal.totaltime;
        t = min(realt, 1);
        if (t < 1 || realt == 1 || !endiswallrun) {
            currentpos = calculatecubicbezier(t, traversal.startpoint1, traversal.startpoint2, traversal.endpoint2, traversal.endpoint1);
            angles = entity.angles;
            if (isdefined(traversal.angles)) {
                angles = traversal.angles;
            }
            entity forceteleport(currentpos, angles, 0);
            return;
        }
        entity animmode("normal_nogravity", 0);
    }
}

// Namespace robotsoldierbehavior
// Params 5, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_3a35c9d6
// Checksum 0x715b485c, Offset: 0x4540
// Size: 0x114
function private mocomprobotproceduraltraversalterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    traversal = entity.traversal;
    if (isdefined(traversal) && gettime() >= traversal.endtime) {
        endiswallrun = traversal.endnode.spawnflags & 2048;
        if (!endiswallrun) {
            entity pathmode("move allowed");
        }
    }
    entity.clamptonavmesh = 1;
    entity.blockingpain = 0;
    entity setrepairpaths(1);
    entity setavoidancemask("avoid all");
}

// Namespace robotsoldierbehavior
// Params 5, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_d2e641c1
// Checksum 0xc6f197cf, Offset: 0x4660
// Size: 0xc4
function private mocompignorepainfaceenemyinit(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.blockingpain = 1;
    if (isdefined(entity.enemy)) {
        entity orientmode("face enemy");
    } else {
        entity orientmode("face angle", entity.angles[1]);
    }
    entity animmode("pos deltas");
}

// Namespace robotsoldierbehavior
// Params 5, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_c3b41944
// Checksum 0x537ba79b, Offset: 0x4730
// Size: 0xb4
function private mocompignorepainfaceenemyupdate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (isdefined(entity.enemy) && entity getanimtime(mocompanim) < 0.5) {
        entity orientmode("face enemy");
        return;
    }
    entity orientmode("face angle", entity.angles[1]);
}

// Namespace robotsoldierbehavior
// Params 5, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_965bf254
// Checksum 0x3dc4535e, Offset: 0x47f0
// Size: 0x3c
function private mocompignorepainfaceenemyterminate(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.blockingpain = 0;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_3f41bd4e
// Checksum 0xde67d908, Offset: 0x4838
// Size: 0x186
function private _calculatewallrundirection(startposition, endposition) {
    entity = self;
    facenormal = getnavmeshfacenormal(endposition, 30);
    /#
        recordline(startposition, endposition, (1, 0.5, 0), "robotStepOutAction", entity);
    #/
    if (isdefined(facenormal)) {
        /#
            recordline(endposition, endposition + facenormal * 12, (1, 0.5, 0), "robotStepOutAction", entity);
        #/
        angles = vectortoangles(facenormal);
        right = anglestoright(angles);
        d = vectordot(right, endposition) * -1;
        if (vectordot(right, startposition) + d > 0) {
            return "right";
        }
        return "left";
    }
    return "unknown";
}

// Namespace robotsoldierbehavior
// Params 0, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_b41ea7e6
// Checksum 0x996b3036, Offset: 0x49c8
// Size: 0x6c
function private robotwallrunstart() {
    entity = self;
    entity.skipdeath = 1;
    entity function_1762804b(0);
    entity pushplayer(1);
    entity.pushable = 0;
}

// Namespace robotsoldierbehavior
// Params 0, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_ef054a85
// Checksum 0xbe61e437, Offset: 0x4a40
// Size: 0x80
function private robotwallrunend() {
    entity = self;
    robottraverseragdollondeath(entity);
    entity.skipdeath = 0;
    entity function_1762804b(1);
    entity pushplayer(0);
    entity.pushable = 1;
}

// Namespace robotsoldierbehavior
// Params 0, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_67b49d31
// Checksum 0x429c844, Offset: 0x4ac8
// Size: 0x220
function private robotsetupwallrunjump() {
    entity = self;
    startnode = entity.traversestartnode;
    endnode = entity.traverseendnode;
    direction = "unknown";
    jumpdirection = "unknown";
    traversaltype = "unknown";
    if (isdefined(startnode) && isdefined(endnode)) {
        startiswallrun = startnode.spawnflags & 2048;
        endiswallrun = endnode.spawnflags & 2048;
        if (endiswallrun) {
            direction = _calculatewallrundirection(startnode.origin, endnode.origin);
        } else {
            direction = _calculatewallrundirection(endnode.origin, startnode.origin);
            if (direction == "right") {
                direction = "left";
            } else {
                direction = "right";
            }
        }
        jumpdirection = robotstartjumpdirection();
        traversaltype = robottraversaltype(startnode);
    }
    blackboard::setblackboardattribute(entity, "_robot_jump_direction", jumpdirection);
    blackboard::setblackboardattribute(entity, "_robot_wallrun_direction", direction);
    blackboard::setblackboardattribute(entity, "_robot_traversal_type", traversaltype);
    robotcalcproceduraltraversal(entity, undefined);
    return 5;
}

// Namespace robotsoldierbehavior
// Params 0, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_51b0baf6
// Checksum 0x1c65b6c6, Offset: 0x4cf0
// Size: 0x100
function private robotsetupwallrunland() {
    entity = self;
    startnode = entity.traversestartnode;
    endnode = entity.traverseendnode;
    landdirection = "unknown";
    traversaltype = "unknown";
    if (isdefined(startnode) && isdefined(endnode)) {
        landdirection = robotendjumpdirection();
        traversaltype = robottraversaltype(endnode);
    }
    blackboard::setblackboardattribute(entity, "_robot_jump_direction", landdirection);
    blackboard::setblackboardattribute(entity, "_robot_traversal_type", traversaltype);
    return 5;
}

// Namespace robotsoldierbehavior
// Params 0, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_7eaee72c
// Checksum 0x7340aae4, Offset: 0x4df8
// Size: 0x13a
function private robotstartjumpdirection() {
    entity = self;
    startnode = entity.traversestartnode;
    endnode = entity.traverseendnode;
    if (isdefined(startnode) && isdefined(endnode)) {
        startiswallrun = startnode.spawnflags & 2048;
        endiswallrun = endnode.spawnflags & 2048;
        if (startiswallrun) {
            abslengthtoend = distance2d(startnode.origin, endnode.origin);
            if (startnode.origin[2] - endnode.origin[2] > 48 && abslengthtoend < -6) {
                return "out";
            }
        }
        return "up";
    }
    return "unknown";
}

// Namespace robotsoldierbehavior
// Params 0, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_312f4715
// Checksum 0x64ac1ee3, Offset: 0x4f40
// Size: 0x13a
function private robotendjumpdirection() {
    entity = self;
    startnode = entity.traversestartnode;
    endnode = entity.traverseendnode;
    if (isdefined(startnode) && isdefined(endnode)) {
        startiswallrun = startnode.spawnflags & 2048;
        endiswallrun = endnode.spawnflags & 2048;
        if (endiswallrun) {
            abslengthtoend = distance2d(startnode.origin, endnode.origin);
            if (endnode.origin[2] - startnode.origin[2] > 48 && abslengthtoend < -6) {
                return "in";
            }
        }
        return "down";
    }
    return "unknown";
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_1d5e46fb
// Checksum 0xaac419b3, Offset: 0x5088
// Size: 0x42
function private robottraversaltype(node) {
    if (isdefined(node)) {
        if (node.spawnflags & 2048) {
            return "wall";
        }
        return "ground";
    }
    return "unknown";
}

// Namespace robotsoldierbehavior
// Params 0, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_f03f3ec3
// Checksum 0x3f77dbfd, Offset: 0x50d8
// Size: 0x454
function private archetyperobotblackboardinit() {
    entity = self;
    blackboard::createblackboardforentity(entity);
    ai::createinterfaceforentity(entity);
    entity aiutility::function_89e1fc16();
    blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_sprint", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("robotStepOutAction");
        #/
    }
    blackboard::registerblackboardattribute(self, "_mind_control", "normal", &robotismindcontrolled);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("robotStepOutAction");
        #/
    }
    blackboard::registerblackboardattribute(self, "_move_mode", "normal", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("robotStepOutAction");
        #/
    }
    blackboard::registerblackboardattribute(self, "_gibbed_limbs", undefined, &function_4ab7ac39);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("robotStepOutAction");
        #/
    }
    blackboard::registerblackboardattribute(self, "_robot_jump_direction", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("robotStepOutAction");
        #/
    }
    blackboard::registerblackboardattribute(self, "_robot_locomotion_type", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("robotStepOutAction");
        #/
    }
    blackboard::registerblackboardattribute(self, "_robot_traversal_type", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("robotStepOutAction");
        #/
    }
    blackboard::registerblackboardattribute(self, "_robot_wallrun_direction", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("robotStepOutAction");
        #/
    }
    blackboard::registerblackboardattribute(self, "_robot_mode", "normal", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("robotStepOutAction");
        #/
    }
    entity.___archetypeonanimscriptedcallback = &archetyperobotonanimscriptedcallback;
    /#
        entity finalizetrackedblackboardattributes();
    #/
    if (sessionmodeiscampaigngame() || sessionmodeiszombiesgame()) {
        self thread gameskill::function_bc280431(self);
    }
    if (self.accuratefire) {
        self thread aiutility::preshootlaserandglinton(self);
        self thread aiutility::postshootlaserandglintoff(self);
    }
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_50e1258e
// Checksum 0x88fd0ad2, Offset: 0x5538
// Size: 0x118
function private robotcrawlercanshootenemy(entity) {
    if (!isdefined(entity.enemy)) {
        return false;
    }
    aimlimits = entity getaimlimitsfromentry("robot_crawler");
    yawtoenemy = angleclamp180(vectortoangles(entity lastknownpos(entity.enemy) - entity.origin)[1] - entity.angles[1]);
    angleepsilon = 10;
    return yawtoenemy <= aimlimits["aim_left"] + angleepsilon && yawtoenemy >= aimlimits["aim_right"] + angleepsilon;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_16ddd18d
// Checksum 0xd8fe3e94, Offset: 0x5658
// Size: 0x34
function private archetyperobotonanimscriptedcallback(entity) {
    entity.__blackboard = undefined;
    entity archetyperobotblackboardinit();
}

// Namespace robotsoldierbehavior
// Params 0, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_4ab7ac39
// Checksum 0xb2237cdc, Offset: 0x5698
// Size: 0xa6
function private function_4ab7ac39() {
    entity = self;
    rightarmgibbed = gibserverutils::isgibbed(entity, 16);
    leftarmgibbed = gibserverutils::isgibbed(entity, 32);
    if (rightarmgibbed && leftarmgibbed) {
        return "both_arms";
    } else if (rightarmgibbed) {
        return "right_arm";
    } else if (leftarmgibbed) {
        return "left_arm";
    }
    return "none";
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_ce18c301
// Checksum 0xfe09b0f4, Offset: 0x5748
// Size: 0x3c
function private robotinvalidatecover(entity) {
    entity.steppedoutofcover = 0;
    entity pathmode("move allowed");
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_e40e2997
// Checksum 0x70589c81, Offset: 0x5790
// Size: 0x44
function private robotdelaymovement(entity) {
    entity pathmode("move delayed", 0, randomfloatrange(1, 2));
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_9c869f88
// Checksum 0x69377831, Offset: 0x57e0
// Size: 0x5c
function private robotmovement(entity) {
    if (blackboard::getblackboardattribute(entity, "_stance") != "stand") {
        blackboard::setblackboardattribute(entity, "_desired_stance", "stand");
    }
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_fdcce33d
// Checksum 0x56f5016f, Offset: 0x5848
// Size: 0xd0
function private robotcoverscaninitialize(entity) {
    blackboard::setblackboardattribute(entity, "_cover_mode", "cover_scan");
    blackboard::setblackboardattribute(entity, "_desired_stance", "stand");
    blackboard::setblackboardattribute(entity, "_robot_step_in", "slow");
    aiutility::keepclaimnode(entity);
    aiutility::choosecoverdirection(entity, 1);
    entity.steppedoutofcovernode = entity.node;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_ed94b640
// Checksum 0xd2a1f12d, Offset: 0x5920
// Size: 0x84
function private robotcoverscanterminate(entity) {
    aiutility::cleanupcovermode(entity);
    entity.steppedoutofcover = 1;
    entity.steppedouttime = gettime() - 8000;
    aiutility::releaseclaimnode(entity);
    entity pathmode("dont move");
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x1 linked
// namespace_271fbeb5<file_0>::function_ea3247ac
// Checksum 0xe1f5860b, Offset: 0x59b0
// Size: 0x156
function robotcanjuke(entity) {
    if (!entity ai::get_behavior_attribute("phalanx") && !(isdefined(entity.steppedoutofcover) && entity.steppedoutofcover) && aiutility::canjuke(entity)) {
        jukeevents = blackboard::getblackboardevents("actor_juke");
        tooclosejukedistancesqr = 57600;
        foreach (event in jukeevents) {
            if (distance2dsquared(entity.origin, event.data.origin) <= tooclosejukedistancesqr) {
                return false;
            }
        }
        return true;
    }
    return false;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x1 linked
// namespace_271fbeb5<file_0>::function_35881cbf
// Checksum 0xb5de2b0f, Offset: 0x5b10
// Size: 0x88
function robotcantacticaljuke(entity) {
    if (entity haspath() && aiutility::bb_getlocomotionfaceenemyquadrant() == "locomotion_face_enemy_front") {
        jukedirection = aiutility::calculatejukedirection(entity, 50, entity.jukedistance);
        return (jukedirection != "forward");
    }
    return false;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x1 linked
// namespace_271fbeb5<file_0>::function_2ed3e6d5
// Checksum 0xb5498acb, Offset: 0x5ba0
// Size: 0x3de
function robotcanpreemptivejuke(entity) {
    if (!isdefined(entity.enemy) || !isplayer(entity.enemy)) {
        return 0;
    }
    if (blackboard::getblackboardattribute(entity, "_stance") == "crouch") {
        return 0;
    }
    if (!entity.shouldpreemptivejuke) {
        return 0;
    }
    if (isdefined(entity.nextpreemptivejuke) && entity.nextpreemptivejuke > gettime()) {
        return 0;
    }
    if (entity.enemy playerads() < entity.nextpreemptivejukeads) {
        return 0;
    }
    jukemaxdistance = 600;
    if (isweapon(entity.enemy.currentweapon) && isdefined(entity.enemy.currentweapon.enemycrosshairrange) && entity.enemy.currentweapon.enemycrosshairrange > 0) {
        jukemaxdistance = entity.enemy.currentweapon.enemycrosshairrange;
        if (jukemaxdistance > 1200) {
            jukemaxdistance = 1200;
        }
    }
    if (distancesquared(entity.origin, entity.enemy.origin) < jukemaxdistance * jukemaxdistance) {
        angledifference = absangleclamp180(entity.angles[1] - entity.enemy.angles[1]);
        /#
            record3dtext(angledifference, entity.origin + (0, 0, 5), (0, 1, 0), "robotStepOutAction");
        #/
        if (angledifference > -121) {
            enemyangles = entity.enemy getgunangles();
            toenemy = entity.enemy.origin - entity.origin;
            forward = anglestoforward(enemyangles);
            dotproduct = abs(vectordot(vectornormalize(toenemy), forward));
            /#
                record3dtext(acos(dotproduct), entity.origin + (0, 0, 10), (0, 1, 0), "robotStepOutAction");
            #/
            if (dotproduct > 0.9848) {
                return robotcanjuke(entity);
            }
        }
    }
    return 0;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x1 linked
// namespace_271fbeb5<file_0>::function_253494f7
// Checksum 0x3e07442f, Offset: 0x5f88
// Size: 0x44
function robotisatcovermodescan(entity) {
    covermode = blackboard::getblackboardattribute(entity, "_cover_mode");
    return covermode == "cover_scan";
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_d5d87d50
// Checksum 0xb83b04c6, Offset: 0x5fd8
// Size: 0x4c
function private robotprepareforadjusttocover(entity) {
    aiutility::keepclaimnode(entity);
    blackboard::setblackboardattribute(entity, "_desired_stance", "crouch");
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_f4df422e
// Checksum 0x861e448c, Offset: 0x6030
// Size: 0x68
function private robotcrawlerservice(entity) {
    if (isdefined(entity.crawlerlifetime) && entity.crawlerlifetime <= gettime() && entity.health > 0) {
        entity kill();
    }
    return true;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x1 linked
// namespace_271fbeb5<file_0>::function_467f7305
// Checksum 0x389dde9d, Offset: 0x60a0
// Size: 0x1a
function robotiscrawler(entity) {
    return entity.iscrawler;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_e86e2430
// Checksum 0x1de27696, Offset: 0x60c8
// Size: 0xcc
function private robotbecomecrawler(entity) {
    if (!entity ai::get_behavior_attribute("can_become_crawler")) {
        return;
    }
    entity.iscrawler = 1;
    entity.becomecrawler = 0;
    entity allowpitchangle(1);
    entity setpitchorient();
    entity.crawlerlifetime = gettime() + randomintrange(10000, 20000);
    entity notify(#"bhtn_action_notify", "rbCrawler");
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x1 linked
// namespace_271fbeb5<file_0>::function_e7c6bbd3
// Checksum 0x8ed1e249, Offset: 0x61a0
// Size: 0x1a
function robotshouldbecomecrawler(entity) {
    return entity.becomecrawler;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_7b40dd18
// Checksum 0x11aec71, Offset: 0x61c8
// Size: 0x34
function private robotismarching(entity) {
    return blackboard::getblackboardattribute(entity, "_move_mode") == "marching";
}

// Namespace robotsoldierbehavior
// Params 0, eflags: 0x4
// namespace_271fbeb5<file_0>::function_ca2e3f4d
// Checksum 0xab9b95ec, Offset: 0x6208
// Size: 0xbe
function private robotlocomotionspeed() {
    entity = self;
    if (robotismindcontrolled() == "mind_controlled") {
        switch (ai::getaiattribute(entity, "rogue_control_speed")) {
        case 167:
            return "locomotion_speed_walk";
        case 165:
            return "locomotion_speed_run";
        case 166:
            return "locomotion_speed_sprint";
        }
    } else if (ai::getaiattribute(entity, "sprint")) {
        return "locomotion_speed_sprint";
    }
    return "locomotion_speed_walk";
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_ec68fa10
// Checksum 0x9c69a9cd, Offset: 0x62d0
// Size: 0x8c
function private robotcoveroverinitialize(behaviortreeentity) {
    aiutility::setcovershootstarttime(behaviortreeentity);
    aiutility::keepclaimnode(behaviortreeentity);
    blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
    blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_over");
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_ac961ac7
// Checksum 0xbf2c9c8b, Offset: 0x6368
// Size: 0x3c
function private robotcoveroverterminate(behaviortreeentity) {
    aiutility::cleanupcovermode(behaviortreeentity);
    aiutility::clearcovershootstarttime(behaviortreeentity);
}

// Namespace robotsoldierbehavior
// Params 0, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_8184b7d1
// Checksum 0xdf72676d, Offset: 0x63b0
// Size: 0x3a
function private robotismindcontrolled() {
    entity = self;
    if (entity.controllevel > 1) {
        return "mind_controlled";
    }
    return "normal";
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_89b67cc0
// Checksum 0xce5ea347, Offset: 0x63f8
// Size: 0x38
function private robotdonttakecover(entity) {
    entity.combatmode = "no_cover";
    entity.resumecover = gettime() + 4000;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_49592c39
// Checksum 0x47e979b0, Offset: 0x6438
// Size: 0xae
function private _isvalidplayer(player) {
    if (!isdefined(player) || !isalive(player) || !isplayer(player) || player.sessionstate == "spectator" || player.sessionstate == "intermission" || player laststand::player_is_in_laststand() || player.ignoreme) {
        return false;
    }
    return true;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_3e0a8858
// Checksum 0x5c2d94af, Offset: 0x64f0
// Size: 0xf4
function private robotrushenemyservice(entity) {
    if (!isdefined(entity.enemy)) {
        return 0;
    }
    distancetoenemy = distance2dsquared(entity.origin, entity.enemy.origin);
    if (distancetoenemy >= 360000 && distancetoenemy <= 1440000) {
        findpathresult = entity findpath(entity.origin, entity.enemy.origin, 1, 0);
        if (findpathresult) {
            entity ai::set_behavior_attribute("move_mode", "rusher");
        }
    }
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_98d0cd1
// Checksum 0x371f6b9f, Offset: 0x65f0
// Size: 0x184
function private _isvalidrusher(entity, neighbor) {
    return isdefined(neighbor) && isdefined(neighbor.archetype) && neighbor.archetype == "robot" && isdefined(neighbor.team) && entity.team == neighbor.team && entity != neighbor && isdefined(neighbor.enemy) && neighbor ai::get_behavior_attribute("move_mode") == "normal" && !neighbor ai::get_behavior_attribute("phalanx") && neighbor ai::get_behavior_attribute("rogue_control") == "level_0" && distancesquared(entity.origin, neighbor.origin) < 160000 && distancesquared(neighbor.origin, neighbor.enemy.origin) < 1440000;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_bf253144
// Checksum 0x34225f58, Offset: 0x6780
// Size: 0x1bc
function private robotrushneighborservice(entity) {
    actors = getaiarray();
    closestenemy = undefined;
    closestenemydistance = undefined;
    foreach (ai in actors) {
        if (_isvalidrusher(entity, ai)) {
            enemydistance = distancesquared(entity.origin, ai.origin);
            if (!isdefined(closestenemydistance) || enemydistance < closestenemydistance) {
                closestenemydistance = enemydistance;
                closestenemy = ai;
            }
        }
    }
    if (isdefined(closestenemy)) {
        findpathresult = entity findpath(closestenemy.origin, closestenemy.enemy.origin, 1, 0);
        if (findpathresult) {
            closestenemy ai::set_behavior_attribute("move_mode", "rusher");
        }
    }
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_6b628702
// Checksum 0x64b28d47, Offset: 0x6948
// Size: 0x142
function private _findclosest(entity, entities) {
    closest = spawnstruct();
    if (entities.size > 0) {
        closest.entity = entities[0];
        closest.distancesquared = distancesquared(entity.origin, closest.entity.origin);
        for (index = 1; index < entities.size; index++) {
            distancesquared = distancesquared(entity.origin, entities[index].origin);
            if (distancesquared < closest.distancesquared) {
                closest.distancesquared = distancesquared;
                closest.entity = entities[index];
            }
        }
    }
    return closest;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_32d4d3a1
// Checksum 0x4a07a9b9, Offset: 0x6a98
// Size: 0x5ec
function private robottargetservice(entity) {
    if (robotabletoshootcondition(entity)) {
        return 0;
    }
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
        return 0;
    }
    if (isdefined(entity.nexttargetserviceupdate) && entity.nexttargetserviceupdate > gettime() && isalive(entity.favoriteenemy)) {
        return 0;
    }
    positiononnavmesh = getclosestpointonnavmesh(entity.origin, -56);
    if (!isdefined(positiononnavmesh)) {
        return;
    }
    if (isdefined(entity.favoriteenemy) && isdefined(entity.favoriteenemy._currentroguerobot) && entity.favoriteenemy._currentroguerobot == entity) {
        entity.favoriteenemy._currentroguerobot = undefined;
    }
    aienemies = [];
    playerenemies = [];
    ai = getaiarray();
    players = getplayers();
    foreach (index, value in ai) {
        if (issentient(value) && entity getignoreent(value)) {
            continue;
        }
        if (value.team != entity.team && isactor(value) && !isdefined(entity.favoriteenemy)) {
            enemypositiononnavmesh = getclosestpointonnavmesh(value.origin, -56, 30);
            if (isdefined(enemypositiononnavmesh) && entity findpath(positiononnavmesh, enemypositiononnavmesh, 1, 0)) {
                aienemies[aienemies.size] = value;
            }
        }
    }
    foreach (value in players) {
        if (_isvalidplayer(value) && value.team != entity.team) {
            if (issentient(value) && entity getignoreent(value)) {
                continue;
            }
            enemypositiononnavmesh = getclosestpointonnavmesh(value.origin, -56, 30);
            if (isdefined(enemypositiononnavmesh) && entity findpath(positiononnavmesh, enemypositiononnavmesh, 1, 0)) {
                playerenemies[playerenemies.size] = value;
            }
        }
    }
    closestplayer = _findclosest(entity, playerenemies);
    closestai = _findclosest(entity, aienemies);
    if (!isdefined(closestplayer.entity) && !isdefined(closestai.entity)) {
        return;
    } else if (!isdefined(closestai.entity)) {
        entity.favoriteenemy = closestplayer.entity;
    } else if (!isdefined(closestplayer.entity)) {
        entity.favoriteenemy = closestai.entity;
        entity.favoriteenemy._currentroguerobot = entity;
    } else if (closestai.distancesquared < closestplayer.distancesquared) {
        entity.favoriteenemy = closestai.entity;
        entity.favoriteenemy._currentroguerobot = entity;
    } else {
        entity.favoriteenemy = closestplayer.entity;
    }
    entity.nexttargetserviceupdate = gettime() + randomintrange(2500, 3500);
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_9e05346c
// Checksum 0x74627b3, Offset: 0x7090
// Size: 0x6c
function private setdesiredstancetostand(behaviortreeentity) {
    currentstance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
    if (currentstance == "crouch") {
        blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
    }
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_99e19e1e
// Checksum 0x56950dc8, Offset: 0x7108
// Size: 0x6c
function private setdesiredstancetocrouch(behaviortreeentity) {
    currentstance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
    if (currentstance == "stand") {
        blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "crouch");
    }
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_69ffc3f9
// Checksum 0xa4925103, Offset: 0x7180
// Size: 0x94
function private toggledesiredstance(entity) {
    currentstance = blackboard::getblackboardattribute(entity, "_stance");
    if (currentstance == "stand") {
        blackboard::setblackboardattribute(entity, "_desired_stance", "crouch");
        return;
    }
    blackboard::setblackboardattribute(entity, "_desired_stance", "stand");
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_56495d04
// Checksum 0x7a400745, Offset: 0x7220
// Size: 0x2a
function private robotshouldshutdown(entity) {
    return entity ai::get_behavior_attribute("shutdown");
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_7b1bf82d
// Checksum 0x1e0228f1, Offset: 0x7258
// Size: 0xae
function private robotshouldexplode(entity) {
    if (entity.controllevel >= 3) {
        if (entity ai::get_behavior_attribute("rogue_force_explosion")) {
            return true;
        } else if (isdefined(entity.enemy)) {
            enemydistsq = distancesquared(entity.origin, entity.enemy.origin);
            return (enemydistsq < 3600);
        }
    }
    return false;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_4b79e029
// Checksum 0x987af481, Offset: 0x7310
// Size: 0x4c
function private robotshouldadjusttocover(entity) {
    if (!isdefined(entity.node)) {
        return false;
    }
    return blackboard::getblackboardattribute(entity, "_stance") != "crouch";
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_751ae449
// Checksum 0x74655515, Offset: 0x7368
// Size: 0x94
function private robotshouldreactatcover(behaviortreeentity) {
    return blackboard::getblackboardattribute(behaviortreeentity, "_stance") == "crouch" && aiutility::canbeflanked(behaviortreeentity) && behaviortreeentity isatcovernodestrict() && behaviortreeentity isflankedatcovernode() && !behaviortreeentity haspath();
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_1bd4c3b2
// Checksum 0x1055f9b6, Offset: 0x7408
// Size: 0x30
function private robotexplode(entity) {
    entity.allowdeath = 0;
    entity.nocybercom = 1;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_a668d043
// Checksum 0x3bd8284d, Offset: 0x7440
// Size: 0x164
function private robotexplodeterminate(entity) {
    blackboard::setblackboardattribute(entity, "_gib_location", "legs");
    entity radiusdamage(entity.origin + (0, 0, 36), 60, 100, 50, entity, "MOD_EXPLOSIVE");
    if (math::cointoss()) {
        gibserverutils::gibleftarm(entity);
    } else {
        gibserverutils::gibrightarm(entity);
    }
    gibserverutils::giblegs(entity);
    gibserverutils::gibhead(entity);
    clientfield::set("robot_mind_control_explosion", 1);
    if (isalive(entity)) {
        entity.allowdeath = 1;
        entity kill();
    }
    entity startragdoll();
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_49486993
// Checksum 0x7bb93282, Offset: 0x75b0
// Size: 0xfe
function private robotexposedcoverservice(entity) {
    if (!entity iscovervalid(entity.steppedoutofcovernode) || entity haspath() || isdefined(entity.steppedoutofcover) && isdefined(entity.steppedoutofcovernode) && !entity issafefromgrenade()) {
        entity.steppedoutofcover = 0;
        entity pathmode("move allowed");
    }
    if (isdefined(entity.resumecover) && gettime() > entity.resumecover) {
        entity.combatmode = "cover";
        entity.resumecover = undefined;
    }
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_d7d69a6c
// Checksum 0xfbb5e771, Offset: 0x76b8
// Size: 0x134
function private robotisatcovercondition(entity) {
    enemytooclose = 0;
    if (isdefined(entity.enemy)) {
        lastknownenemypos = entity lastknownpos(entity.enemy);
        distancetoenemysqr = distance2dsquared(entity.origin, lastknownenemypos);
        enemytooclose = distancetoenemysqr <= 57600;
    }
    return !enemytooclose && !entity.steppedoutofcover && entity isatcovernodestrict() && entity shouldusecovernode() && !entity haspath() && entity issafefromgrenade() && entity.combatmode != "no_cover";
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_ba043e7e
// Checksum 0x1b6e4d05, Offset: 0x77f8
// Size: 0x158
function private robotsupportsovercover(entity) {
    if (isdefined(entity.node)) {
        if (isdefined(entity.node.spawnflags) && (entity.node.spawnflags & 4) == 4) {
            return (entity.node.type == "Cover Stand" || entity.node.type == "Conceal Stand");
        }
        return (entity.node.type == "Cover Crouch" || entity.node.type == "Cover Crouch Window" || entity.node.type == "Cover Left" || entity.node.type == "Cover Right" || entity.node.type == "Conceal Crouch");
    }
    return false;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_3149c942
// Checksum 0xef59239d, Offset: 0x7958
// Size: 0x180
function private canmovetoenemycondition(entity) {
    if (!isdefined(entity.enemy) || entity.enemy.health <= 0) {
        return 0;
    }
    positiononnavmesh = getclosestpointonnavmesh(entity.origin, -56);
    enemypositiononnavmesh = getclosestpointonnavmesh(entity.enemy.origin, -56, 30);
    if (!isdefined(positiononnavmesh) || !isdefined(enemypositiononnavmesh)) {
        return 0;
    }
    findpathresult = entity findpath(positiononnavmesh, enemypositiononnavmesh, 1, 0);
    /#
        if (!findpathresult) {
            record3dtext("robotStepOutAction", enemypositiononnavmesh + (0, 0, 5), (1, 0.5, 0), "robotStepOutAction");
            recordline(positiononnavmesh, enemypositiononnavmesh, (1, 0.5, 0), "robotStepOutAction", entity);
        }
    #/
    return findpathresult;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_e6a91466
// Checksum 0xd21f67b1, Offset: 0x7ae0
// Size: 0xb8
function private canmoveclosetoenemycondition(entity) {
    if (!isdefined(entity.enemy) || entity.enemy.health <= 0) {
        return false;
    }
    queryresult = positionquery_source_navigation(entity.enemy.origin, 0, 120, 120, 20, entity);
    positionquery_filter_inclaimedlocation(queryresult, entity);
    return queryresult.data.size > 0;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_ca914469
// Checksum 0x42e423f0, Offset: 0x7ba0
// Size: 0x38
function private robotstartsprint(entity) {
    blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_sprint");
    return true;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_ee1443a6
// Checksum 0xf24fdfe5, Offset: 0x7be0
// Size: 0x38
function private robotstartsupersprint(entity) {
    blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_super_sprint");
    return true;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_1538394f
// Checksum 0xebca12b9, Offset: 0x7c20
// Size: 0x90
function private robottacticalwalkactionstart(entity) {
    aiutility::resetcoverparameters(entity);
    aiutility::setcanbeflanked(entity, 0);
    blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_walk");
    blackboard::setblackboardattribute(entity, "_stance", "stand");
    return true;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_c4f96403
// Checksum 0xf69d8c31, Offset: 0x7cb8
// Size: 0x3c
function private robotdie(entity) {
    if (isalive(entity)) {
        entity kill();
    }
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_c6fc9479
// Checksum 0xd20766a9, Offset: 0x7d00
// Size: 0x7c8
function private movetoplayerupdate(entity, asmstatename) {
    entity.keepclaimednode = 0;
    positiononnavmesh = getclosestpointonnavmesh(entity.origin, -56);
    if (!isdefined(positiononnavmesh)) {
        return 4;
    }
    if (isdefined(entity.ignoreall) && entity.ignoreall) {
        entity clearuseposition();
        return 4;
    }
    if (!isdefined(entity.enemy)) {
        return 4;
    }
    if (robotroguehascloseenemytomelee(entity)) {
        return 4;
    }
    if (entity.var_e44890d6) {
        if (isdefined(entity.enemy) && distancesquared(entity.origin, entity.enemy.origin) > 300 * 300) {
            entity function_1762804b(0);
        } else {
            entity function_1762804b(1);
        }
    }
    if (entity asmistransdecrunning() || entity asmistransitionrunning()) {
        return 4;
    }
    if (!isdefined(entity.lastknownenemypos)) {
        entity.lastknownenemypos = entity.enemy.origin;
    }
    shouldrepath = !isdefined(entity.lastvalidenemypos);
    if (!shouldrepath && isdefined(entity.enemy)) {
        if (isdefined(entity.nextmovetoplayerupdate) && entity.nextmovetoplayerupdate <= gettime()) {
            shouldrepath = 1;
        } else if (distancesquared(entity.lastknownenemypos, entity.enemy.origin) > 72 * 72) {
            shouldrepath = 1;
        } else if (distancesquared(entity.origin, entity.enemy.origin) <= 120 * 120) {
            shouldrepath = 1;
        } else if (isdefined(entity.pathgoalpos)) {
            distancetogoalsqr = distancesquared(entity.origin, entity.pathgoalpos);
            shouldrepath = distancetogoalsqr < 72 * 72;
        }
    }
    if (shouldrepath) {
        entity.lastknownenemypos = entity.enemy.origin;
        queryresult = positionquery_source_navigation(entity.lastknownenemypos, 0, 120, 120, 20, entity);
        positionquery_filter_inclaimedlocation(queryresult, entity);
        if (queryresult.data.size > 0) {
            entity.lastvalidenemypos = queryresult.data[0].origin;
        }
        if (isdefined(entity.lastvalidenemypos)) {
            entity useposition(entity.lastvalidenemypos);
            if (distancesquared(entity.origin, entity.lastvalidenemypos) > -16 * -16) {
                path = entity calcapproximatepathtoposition(entity.lastvalidenemypos, 0);
                /#
                    if (getdvarint("robotStepOutAction")) {
                        for (index = 1; index < path.size; index++) {
                            recordline(path[index - 1], path[index], (1, 0.5, 0), "robotStepOutAction", entity);
                        }
                    }
                #/
                deviationdistance = randomintrange(-16, 480);
                segmentlength = 0;
                for (index = 1; index < path.size; index++) {
                    currentseglength = distance(path[index - 1], path[index]);
                    if (segmentlength + currentseglength > deviationdistance) {
                        remaininglength = deviationdistance - segmentlength;
                        seedposition = path[index - 1] + vectornormalize(path[index] - path[index - 1]) * remaininglength;
                        /#
                            recordcircle(seedposition, 2, (1, 0.5, 0), "robotStepOutAction", entity);
                        #/
                        innerzigzagradius = 0;
                        outerzigzagradius = 64;
                        queryresult = positionquery_source_navigation(seedposition, innerzigzagradius, outerzigzagradius, 36, 16, entity, 16);
                        positionquery_filter_inclaimedlocation(queryresult, entity);
                        if (queryresult.data.size > 0) {
                            point = queryresult.data[randomint(queryresult.data.size)];
                            entity useposition(point.origin);
                        }
                        break;
                    }
                    segmentlength += currentseglength;
                }
            }
        }
        entity.nextmovetoplayerupdate = gettime() + randomintrange(2000, 3000);
    }
    return 5;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_9fceca26
// Checksum 0xe5675b53, Offset: 0x84d0
// Size: 0x46
function private robotshouldchargemelee(entity) {
    if (aiutility::shouldmutexmelee(entity) && robothasenemytomelee(entity)) {
        return true;
    }
    return false;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_f8ae9bac
// Checksum 0xde2b1c99, Offset: 0x8520
// Size: 0x194
function private robothasenemytomelee(entity) {
    if (isdefined(entity.enemy) && issentient(entity.enemy) && entity.enemy.health > 0) {
        enemydistsq = distancesquared(entity.origin, entity.enemy.origin);
        if (enemydistsq < entity.chargemeleedistance * entity.chargemeleedistance && abs(entity.enemy.origin[2] - entity.origin[2]) < 24) {
            yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
            return (abs(yawtoenemy) <= 80);
        }
    }
    return false;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_421ed8a4
// Checksum 0x82106044, Offset: 0x86c0
// Size: 0xea
function private robotroguehasenemytomelee(entity) {
    if (isdefined(entity.enemy) && issentient(entity.enemy) && entity.enemy.health > 0 && entity ai::get_behavior_attribute("rogue_control") != "level_3") {
        if (!entity cansee(entity.enemy)) {
            return false;
        }
        return (distancesquared(entity.origin, entity.enemy.origin) < -124 * -124);
    }
    return false;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_bea02ae6
// Checksum 0xa7ea7a0, Offset: 0x87b8
// Size: 0x46
function private robotshouldmelee(entity) {
    if (aiutility::shouldmutexmelee(entity) && robothascloseenemytomelee(entity)) {
        return true;
    }
    return false;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_dbd2bc7e
// Checksum 0x82162de5, Offset: 0x8808
// Size: 0x15c
function private robothascloseenemytomelee(entity) {
    if (isdefined(entity.enemy) && issentient(entity.enemy) && entity.enemy.health > 0) {
        if (!entity cansee(entity.enemy)) {
            return false;
        }
        enemydistsq = distancesquared(entity.origin, entity.enemy.origin);
        if (enemydistsq < 64 * 64) {
            yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
            return (abs(yawtoenemy) <= 80);
        }
    }
    return false;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_b7604a6
// Checksum 0xcfb35b13, Offset: 0x8970
// Size: 0xc2
function private robotroguehascloseenemytomelee(entity) {
    if (isdefined(entity.enemy) && issentient(entity.enemy) && entity.enemy.health > 0 && entity ai::get_behavior_attribute("rogue_control") != "level_3") {
        return (distancesquared(entity.origin, entity.enemy.origin) < 64 * 64);
    }
    return false;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_8246bdc2
// Checksum 0x3bf63f69, Offset: 0x8a40
// Size: 0x4c
function private scriptrequirestosprintcondition(entity) {
    return entity ai::get_behavior_attribute("sprint") && !entity ai::get_behavior_attribute("disablesprint");
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_ba0b95e5
// Checksum 0x5b428f6a, Offset: 0x8a98
// Size: 0x4c
function private robotscanexposedpainterminate(entity) {
    aiutility::cleanupcovermode(entity);
    blackboard::setblackboardattribute(entity, "_robot_step_in", "fast");
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_7d1a51f7
// Checksum 0xea7c44cb, Offset: 0x8af0
// Size: 0xae
function private robottookempdamage(entity) {
    if (isdefined(entity.damageweapon) && isdefined(entity.damagemod)) {
        weapon = entity.damageweapon;
        return (entity.damagemod == "MOD_GRENADE_SPLASH" && isdefined(weapon.rootweapon) && issubstr(weapon.rootweapon.name, "emp_grenade"));
    }
    return false;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_a1a88c73
// Checksum 0xa5caee9c, Offset: 0x8ba8
// Size: 0x54
function private robotnocloseenemyservice(entity) {
    if (isdefined(entity.enemy) && aiutility::shouldmelee(entity)) {
        entity clearpath();
        return true;
    }
    return false;
}

// Namespace robotsoldierbehavior
// Params 3, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_f7a368d1
// Checksum 0xb23c0e25, Offset: 0x8c08
// Size: 0x120
function private _robotoutsidemovementrange(entity, range, useenemypos) {
    assert(isdefined(range));
    if (!isdefined(entity.enemy) && !entity haspath()) {
        return 0;
    }
    goalpos = entity.pathgoalpos;
    if (isdefined(entity.enemy) && useenemypos) {
        goalpos = entity lastknownpos(entity.enemy);
    }
    if (!isdefined(goalpos)) {
        return 0;
    }
    outsiderange = distancesquared(entity.origin, goalpos) > range * range;
    return outsiderange;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_bc2252d0
// Checksum 0x18aaa216, Offset: 0x8d30
// Size: 0x24
function private robotoutsidesupersprintrange(entity) {
    return !robotwithinsupersprintrange(entity);
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_81c33582
// Checksum 0xc9767f8, Offset: 0x8d60
// Size: 0x76
function private robotwithinsupersprintrange(entity) {
    if (entity ai::get_behavior_attribute("supports_super_sprint") && !entity ai::get_behavior_attribute("disablesprint")) {
        return _robotoutsidemovementrange(entity, entity.supersprintdistance, 0);
    }
    return 0;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_7fd6ab7
// Checksum 0x7852671c, Offset: 0x8de0
// Size: 0x86
function private robotoutsidesprintrange(entity) {
    if (entity ai::get_behavior_attribute("supports_super_sprint") && !entity ai::get_behavior_attribute("disablesprint")) {
        return _robotoutsidemovementrange(entity, entity.supersprintdistance * 1.15, 0);
    }
    return 0;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_3339adbb
// Checksum 0xfe05f237, Offset: 0x8e70
// Size: 0xc2
function private robotoutsidetacticalwalkrange(entity) {
    if (entity ai::get_behavior_attribute("disablesprint")) {
        return 0;
    }
    if (isdefined(entity.enemy) && distancesquared(entity.origin, entity.goalpos) < entity.minwalkdistance * entity.minwalkdistance) {
        return 0;
    }
    return _robotoutsidemovementrange(entity, entity.runandgundist * 1.15, 1);
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_55141515
// Checksum 0xec87ffdb, Offset: 0x8f40
// Size: 0xb2
function private robotwithinsprintrange(entity) {
    if (entity ai::get_behavior_attribute("disablesprint")) {
        return 0;
    }
    if (isdefined(entity.enemy) && distancesquared(entity.origin, entity.goalpos) < entity.minwalkdistance * entity.minwalkdistance) {
        return 0;
    }
    return _robotoutsidemovementrange(entity, entity.runandgundist, 1);
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_ccf613aa
// Checksum 0xe943a261, Offset: 0x9000
// Size: 0x118
function private shouldtakeovercondition(entity) {
    switch (entity.controllevel) {
    case 0:
        return isinarray(array("level_1", "level_2", "level_3"), entity ai::get_behavior_attribute("rogue_control"));
    case 1:
        return isinarray(array("level_2", "level_3"), entity ai::get_behavior_attribute("rogue_control"));
    case 2:
        return (entity ai::get_behavior_attribute("rogue_control") == "level_3");
    }
    return 0;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_a097a0ea
// Checksum 0xee8f2833, Offset: 0x9120
// Size: 0x1c
function private hasminiraps(entity) {
    return isdefined(entity.miniraps);
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_e33b1e75
// Checksum 0xc8d5efdc, Offset: 0x9148
// Size: 0x80
function private robotismoving(entity) {
    velocity = entity getvelocity();
    velocity = (velocity[0], 0, velocity[1]);
    velocitysqr = lengthsquared(velocity);
    return velocitysqr > 24 * 24;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_1606f7ec
// Checksum 0x83cd6a80, Offset: 0x91d0
// Size: 0x20
function private robotabletoshootcondition(entity) {
    return entity.controllevel <= 1;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_846f2f66
// Checksum 0x679e3d16, Offset: 0x91f8
// Size: 0x44
function private robotshouldtacticalwalk(entity) {
    if (!entity haspath()) {
        return false;
    }
    return !robotismarching(entity);
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_c25bc6a0
// Checksum 0xe03bb6a8, Offset: 0x9248
// Size: 0x64c
function private _robotcoverposition(entity) {
    if (entity isflankedatcovernode()) {
        return false;
    }
    if (entity shouldholdgroundagainstenemy()) {
        return false;
    }
    shouldusecovernode = undefined;
    itsbeenawhile = gettime() > entity.nextfindbestcovertime;
    isatscriptgoal = undefined;
    if (isdefined(entity.robotnode)) {
        isatscriptgoal = entity isposatgoal(entity.robotnode.origin);
        shouldusecovernode = entity iscovervalid(entity.robotnode);
    } else {
        isatscriptgoal = entity isatgoal();
        shouldusecovernode = entity shouldusecovernode();
    }
    shouldlookforbettercover = !shouldusecovernode || itsbeenawhile || !isatscriptgoal;
    /#
        recordenttext("robotStepOutAction" + shouldusecovernode + "robotStepOutAction" + itsbeenawhile + "robotStepOutAction" + isatscriptgoal, entity, shouldlookforbettercover ? (0, 1, 0) : (1, 0, 0), "robotStepOutAction");
    #/
    if (shouldlookforbettercover && isdefined(entity.enemy) && !entity.keepclaimednode) {
        transitionrunning = entity asmistransitionrunning();
        substatepending = entity asmissubstatepending();
        transdecrunning = entity asmistransdecrunning();
        isbehaviortreeinrunningstate = entity getbehaviortreestatus() == 5;
        if (!transitionrunning && !substatepending && !transdecrunning && isbehaviortreeinrunningstate) {
            nodes = entity findbestcovernodes(entity.goalradius, entity.goalpos);
            node = undefined;
            for (nodeindex = 0; nodeindex < nodes.size; nodeindex++) {
                if (entity.robotnode === nodes[nodeindex] || !isdefined(nodes[nodeindex].robotclaimed)) {
                    node = nodes[nodeindex];
                    break;
                }
            }
            if (!isdefined(entity.robotnode) || isentity(entity.node) && entity.robotnode != entity.node) {
                entity.robotnode = entity.node;
                entity.robotnode.robotclaimed = 1;
            }
            goingtodifferentnode = !isdefined(entity.steppedoutofcovernode) || (!isdefined(entity.robotnode) || isdefined(node) && node != entity.robotnode) && entity.steppedoutofcovernode != node;
            aiutility::setnextfindbestcovertime(entity, node);
            if (goingtodifferentnode) {
                if (randomfloat(1) <= 0.75 || entity ai::get_behavior_attribute("force_cover")) {
                    aiutility::usecovernodewrapper(entity, node);
                } else {
                    searchradius = entity.goalradius;
                    if (searchradius > 200) {
                        searchradius = 200;
                    }
                    covernodepoints = util::positionquery_pointarray(node.origin, 30, searchradius, 72, 30);
                    if (covernodepoints.size > 0) {
                        entity useposition(covernodepoints[randomint(covernodepoints.size)]);
                    } else {
                        entity useposition(entity getnodeoffsetposition(node));
                    }
                }
                if (isdefined(entity.robotnode)) {
                    entity.robotnode.robotclaimed = undefined;
                }
                entity.robotnode = node;
                entity.robotnode.robotclaimed = 1;
                entity pathmode("move delayed", 0, randomfloatrange(0.25, 2));
                return true;
            }
        }
    }
    return false;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_92aecd01
// Checksum 0xba260f09, Offset: 0x98a0
// Size: 0x31c
function private _robotescortposition(entity) {
    if (entity ai::get_behavior_attribute("move_mode") == "escort") {
        escortposition = entity ai::get_behavior_attribute("escort_position");
        if (!isdefined(escortposition)) {
            return true;
        }
        if (distance2dsquared(entity.origin, escortposition) <= 22500) {
            return true;
        }
        if (isdefined(entity.escortnexttime) && gettime() < entity.escortnexttime) {
            return true;
        }
        if (entity getpathmode() == "dont move") {
            return true;
        }
        positiononnavmesh = getclosestpointonnavmesh(escortposition, -56);
        if (!isdefined(positiononnavmesh)) {
            positiononnavmesh = escortposition;
        }
        queryresult = positionquery_source_navigation(positiononnavmesh, 75, -106, 36, 16, entity, 16);
        positionquery_filter_inclaimedlocation(queryresult, entity);
        if (queryresult.data.size > 0) {
            closestpoint = undefined;
            closestdistance = undefined;
            foreach (point in queryresult.data) {
                if (!point.inclaimedlocation) {
                    newclosestdistance = distance2dsquared(entity.origin, point.origin);
                    if (!isdefined(closestpoint) || newclosestdistance < closestdistance) {
                        closestpoint = point.origin;
                        closestdistance = newclosestdistance;
                    }
                }
            }
            if (isdefined(closestpoint)) {
                entity useposition(closestpoint);
                entity.escortnexttime = gettime() + randomintrange(-56, 300);
            }
        }
        return true;
    }
    return false;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_7dbf6f86
// Checksum 0xa5a07a52, Offset: 0x9bc8
// Size: 0x404
function private _robotrusherposition(entity) {
    if (entity ai::get_behavior_attribute("move_mode") == "rusher") {
        entity pathmode("move allowed");
        if (!isdefined(entity.enemy)) {
            return true;
        }
        disttoenemysqr = distance2dsquared(entity.origin, entity.enemy.origin);
        if (disttoenemysqr <= entity.robotrushermaxradius * entity.robotrushermaxradius && disttoenemysqr >= entity.robotrusherminradius * entity.robotrusherminradius) {
            return true;
        }
        if (isdefined(entity.rushernexttime) && gettime() < entity.rushernexttime) {
            return true;
        }
        positiononnavmesh = getclosestpointonnavmesh(entity.enemy.origin, -56);
        if (!isdefined(positiononnavmesh)) {
            positiononnavmesh = entity.enemy.origin;
        }
        queryresult = positionquery_source_navigation(positiononnavmesh, entity.robotrusherminradius, entity.robotrushermaxradius, 36, 16, entity, 16);
        positionquery_filter_inclaimedlocation(queryresult, entity);
        positionquery_filter_sight(queryresult, entity.enemy.origin, entity geteye() - entity.origin, entity, 2, entity.enemy);
        if (queryresult.data.size > 0) {
            closestpoint = undefined;
            closestdistance = undefined;
            foreach (point in queryresult.data) {
                if (!point.inclaimedlocation && point.visibility === 1) {
                    newclosestdistance = distance2dsquared(entity.origin, point.origin);
                    if (!isdefined(closestpoint) || newclosestdistance < closestdistance) {
                        closestpoint = point.origin;
                        closestdistance = newclosestdistance;
                    }
                }
            }
            if (isdefined(closestpoint)) {
                entity useposition(closestpoint);
                entity.rushernexttime = gettime() + randomintrange(500, 1500);
            }
        }
        return true;
    }
    return false;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_eee2a916
// Checksum 0xa1481ffc, Offset: 0x9fd8
// Size: 0x418
function private _robotguardposition(entity) {
    if (entity ai::get_behavior_attribute("move_mode") == "guard") {
        if (entity getpathmode() == "dont move") {
            return true;
        }
        if (!isdefined(entity.guardposition) || distancesquared(entity.origin, entity.guardposition) < 60 * 60) {
            entity pathmode("move delayed", 1, randomfloatrange(1, 1.5));
            queryresult = positionquery_source_navigation(entity.goalpos, 0, entity.goalradius / 2, 36, 36, entity, 72);
            positionquery_filter_inclaimedlocation(queryresult, entity);
            if (queryresult.data.size > 0) {
                minimumdistancesq = entity.goalradius * 0.2;
                minimumdistancesq *= minimumdistancesq;
                distantpoints = [];
                foreach (point in queryresult.data) {
                    if (distancesquared(entity.origin, point.origin) > minimumdistancesq) {
                        distantpoints[distantpoints.size] = point;
                    }
                }
                if (distantpoints.size > 0) {
                    randomposition = distantpoints[randomint(distantpoints.size)];
                    entity.guardposition = randomposition.origin;
                    entity.intermediateguardposition = undefined;
                    entity.intermediateguardtime = undefined;
                }
            }
        }
        currenttime = gettime();
        if (!isdefined(entity.intermediateguardtime) || entity.intermediateguardtime < currenttime) {
            if (isdefined(entity.intermediateguardposition) && distancesquared(entity.intermediateguardposition, entity.origin) < 24 * 24) {
                entity.guardposition = entity.origin;
            }
            entity.intermediateguardposition = entity.origin;
            entity.intermediateguardtime = currenttime + 3000;
        }
        if (isdefined(entity.guardposition)) {
            entity useposition(entity.guardposition);
            return true;
        }
    }
    entity.guardposition = undefined;
    entity.intermediateguardposition = undefined;
    entity.intermediateguardtime = undefined;
    return false;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_b57c4ac3
// Checksum 0x2e9595c9, Offset: 0xa3f8
// Size: 0x28e
function private robotpositionservice(entity) {
    /#
        if (getdvarint("robotStepOutAction") && isdefined(entity.enemy)) {
            lastknownpos = entity lastknownpos(entity.enemy);
            recordline(entity.origin, lastknownpos, (1, 0.5, 0), "robotStepOutAction", entity);
            record3dtext("robotStepOutAction", lastknownpos + (0, 0, 5), (1, 0.5, 0), "robotStepOutAction");
        }
    #/
    if (!isalive(entity)) {
        if (isdefined(entity.robotnode)) {
            aiutility::releaseclaimnode(entity);
            entity.robotnode.robotclaimed = undefined;
            entity.robotnode = undefined;
        }
        return false;
    }
    if (entity.disablerepath) {
        return false;
    }
    if (!robotabletoshootcondition(entity)) {
        return false;
    }
    if (entity ai::get_behavior_attribute("phalanx")) {
        return false;
    }
    if (aisquads::isfollowingsquadleader(entity)) {
        return false;
    }
    if (_robotrusherposition(entity)) {
        return true;
    }
    if (_robotguardposition(entity)) {
        return true;
    }
    if (_robotescortposition(entity)) {
        return true;
    }
    if (!aiutility::issafefromgrenades(entity)) {
        aiutility::releaseclaimnode(entity);
        aiutility::choosebestcovernodeasap(entity);
    }
    if (_robotcoverposition(entity)) {
        return true;
    }
    return false;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_f45ed894
// Checksum 0x43e905ec, Offset: 0xa690
// Size: 0x84
function private robotdropstartingweapon(entity, asmstatename) {
    if (entity.weapon.name == level.weaponnone.name) {
        entity shared::placeweaponon(entity.startingweapon, "right");
        entity thread shared::dropaiweapon();
    }
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_f2dc2b1e
// Checksum 0xbd5f0289, Offset: 0xa720
// Size: 0xc4
function private robotjukeinitialize(entity) {
    aiutility::choosejukedirection(entity);
    entity clearpath();
    entity notify(#"bhtn_action_notify", "rbJuke");
    jukeinfo = spawnstruct();
    jukeinfo.origin = entity.origin;
    jukeinfo.entity = entity;
    blackboard::addblackboardevent("actor_juke", jukeinfo, 3000);
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_213b7eb6
// Checksum 0x7aeff500, Offset: 0xa7f0
// Size: 0x68
function private robotpreemptivejuketerminate(entity) {
    entity.nextpreemptivejuke = gettime() + randomintrange(4000, 6000);
    entity.nextpreemptivejukeads = randomfloatrange(0.5, 0.95);
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_d4856404
// Checksum 0x407a6089, Offset: 0xa860
// Size: 0x372
function private robottryreacquireservice(entity) {
    movemode = entity ai::get_behavior_attribute("move_mode");
    if (movemode == "rusher" || movemode == "escort" || movemode == "guard") {
        return false;
    }
    if (!isdefined(entity.reacquire_state)) {
        entity.reacquire_state = 0;
    }
    if (!isdefined(entity.enemy)) {
        entity.reacquire_state = 0;
        return false;
    }
    if (entity haspath()) {
        return false;
    }
    if (!robotabletoshootcondition(entity)) {
        return false;
    }
    if (entity ai::get_behavior_attribute("force_cover")) {
        return false;
    }
    if (entity cansee(entity.enemy) && entity canshootenemy()) {
        entity.reacquire_state = 0;
        return false;
    }
    dirtoenemy = vectornormalize(entity.enemy.origin - entity.origin);
    forward = anglestoforward(entity.angles);
    if (vectordot(dirtoenemy, forward) < 0.5) {
        entity.reacquire_state = 0;
        return false;
    }
    switch (entity.reacquire_state) {
    case 0:
    case 1:
    case 2:
        step_size = 32 + entity.reacquire_state * 32;
        reacquirepos = entity reacquirestep(step_size);
        break;
    case 4:
        if (!entity cansee(entity.enemy) || !entity canshootenemy()) {
            entity flagenemyunattackable();
        }
        break;
    default:
        if (entity.reacquire_state > 15) {
            entity.reacquire_state = 0;
            return false;
        }
        break;
    }
    if (isvec(reacquirepos)) {
        entity useposition(reacquirepos);
        return true;
    }
    entity.reacquire_state++;
    return false;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_ddfb257c
// Checksum 0xb0a829e8, Offset: 0xabe0
// Size: 0xc8
function private takeoverinitialize(entity, asmstatename) {
    switch (entity ai::get_behavior_attribute("rogue_control")) {
    case 196:
        entity robotsoldierserverutils::forcerobotsoldiermindcontrollevel1();
        break;
    case 195:
        entity robotsoldierserverutils::forcerobotsoldiermindcontrollevel2();
        break;
    case 189:
        entity robotsoldierserverutils::forcerobotsoldiermindcontrollevel3();
        break;
    }
    animationstatenetworkutility::requeststate(entity, asmstatename);
    return 5;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_8ed01e0b
// Checksum 0x41cb79fe, Offset: 0xacb0
// Size: 0x72
function private takeoverterminate(entity, asmstatename) {
    switch (entity ai::get_behavior_attribute("rogue_control")) {
    case 195:
    case 189:
        entity thread shared::dropaiweapon();
        break;
    }
    return 4;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_853dec33
// Checksum 0xf386f477, Offset: 0xad30
// Size: 0xb8
function private stepintoinitialize(entity, asmstatename) {
    aiutility::releaseclaimnode(entity);
    aiutility::usecovernodewrapper(entity, entity.steppedoutofcovernode);
    blackboard::setblackboardattribute(entity, "_desired_stance", "crouch");
    aiutility::keepclaimnode(entity);
    entity.steppedoutofcovernode = undefined;
    animationstatenetworkutility::requeststate(entity, asmstatename);
    return 5;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_bf05158a
// Checksum 0xf5dc206, Offset: 0xadf0
// Size: 0x60
function private stepintoterminate(entity, asmstatename) {
    entity.steppedoutofcover = 0;
    aiutility::releaseclaimnode(entity);
    entity pathmode("move allowed");
    return 4;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_fb0a3607
// Checksum 0xbe2bfc47, Offset: 0xae58
// Size: 0x100
function private stepoutinitialize(entity, asmstatename) {
    entity.steppedoutofcovernode = entity.node;
    aiutility::keepclaimnode(entity);
    if (math::cointoss()) {
        blackboard::setblackboardattribute(entity, "_desired_stance", "stand");
    } else {
        blackboard::setblackboardattribute(entity, "_desired_stance", "crouch");
    }
    blackboard::setblackboardattribute(entity, "_robot_step_in", "fast");
    aiutility::choosecoverdirection(entity, 1);
    animationstatenetworkutility::requeststate(entity, asmstatename);
    return 5;
}

// Namespace robotsoldierbehavior
// Params 2, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_4d716ef6
// Checksum 0xa7a33179, Offset: 0xaf60
// Size: 0x70
function private stepoutterminate(entity, asmstatename) {
    entity.steppedoutofcover = 1;
    entity.steppedouttime = gettime();
    aiutility::releaseclaimnode(entity);
    entity pathmode("dont move");
    return 4;
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_50754bbc
// Checksum 0x11c62bc1, Offset: 0xafd8
// Size: 0x74
function private supportsstepoutcondition(entity) {
    return entity.node.type == "Cover Left" || entity.node.type == "Cover Right" || entity.node.type == "Cover Pillar";
}

// Namespace robotsoldierbehavior
// Params 1, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_8b6d1606
// Checksum 0xdba8877b, Offset: 0xb058
// Size: 0xe6
function private shouldstepincondition(entity) {
    if (!isdefined(entity.steppedoutofcover) || !entity.steppedoutofcover || !isdefined(entity.steppedouttime) || !entity.steppedoutofcover) {
        return false;
    }
    exposedtimeinseconds = (gettime() - entity.steppedouttime) / 1000;
    exceededtime = exposedtimeinseconds >= 4 || exposedtimeinseconds >= 8;
    suppressed = entity.suppressionmeter > entity.suppressionthreshold;
    return exceededtime && (exceededtime || suppressed);
}

// Namespace robotsoldierbehavior
// Params 0, eflags: 0x5 linked
// namespace_271fbeb5<file_0>::function_e2fda40b
// Checksum 0xe6a24ff8, Offset: 0xb148
// Size: 0xd2
function private robotdeployminiraps() {
    entity = self;
    if (isdefined(entity) && isdefined(entity.miniraps)) {
        positiononnavmesh = getclosestpointonnavmesh(entity.origin, -56);
        raps = spawnvehicle("spawner_bo3_mini_raps", positiononnavmesh, (0, 0, 0));
        raps.team = entity.team;
        raps thread robotsoldierserverutils::rapsdetonatecountdown(raps);
        entity.miniraps = undefined;
    }
}

#namespace robotsoldierserverutils;

// Namespace robotsoldierserverutils
// Params 4, eflags: 0x5 linked
// namespace_8509e91d<file_0>::function_2ff664b7
// Checksum 0x464e3a, Offset: 0xb228
// Size: 0x134
function private _trygibbinghead(entity, damage, hitloc, isexplosive) {
    if (isexplosive && randomfloatrange(0, 1) <= 0.5) {
        gibserverutils::gibhead(entity);
        return;
    }
    if (isinarray(array("head", "neck", "helmet"), hitloc) && randomfloatrange(0, 1) <= 1) {
        gibserverutils::gibhead(entity);
        return;
    }
    if (entity.health - damage <= 0 && randomfloatrange(0, 1) <= 0.25) {
        gibserverutils::gibhead(entity);
    }
}

// Namespace robotsoldierserverutils
// Params 5, eflags: 0x5 linked
// namespace_8509e91d<file_0>::function_9a8871d5
// Checksum 0xced0797c, Offset: 0xb368
// Size: 0x28c
function private _trygibbinglimb(entity, damage, hitloc, isexplosive, ondeath) {
    if (gibserverutils::isgibbed(entity, 32) || gibserverutils::isgibbed(entity, 16)) {
        return;
    }
    if (isexplosive && randomfloatrange(0, 1) <= 0.25) {
        if (ondeath && math::cointoss()) {
            gibserverutils::gibrightarm(entity);
        } else {
            gibserverutils::gibleftarm(entity);
        }
        return;
    }
    if (isinarray(array("left_hand", "left_arm_lower", "left_arm_upper"), hitloc)) {
        gibserverutils::gibleftarm(entity);
        return;
    }
    if (ondeath && isinarray(array("right_hand", "right_arm_lower", "right_arm_upper"), hitloc)) {
        gibserverutils::gibrightarm(entity);
        return;
    }
    if (robotsoldierbehavior::robotismindcontrolled() == "mind_controlled" && isinarray(array("right_hand", "right_arm_lower", "right_arm_upper"), hitloc)) {
        gibserverutils::gibrightarm(entity);
        return;
    }
    if (ondeath && randomfloatrange(0, 1) <= 0.25) {
        if (math::cointoss()) {
            gibserverutils::gibleftarm(entity);
            return;
        }
        gibserverutils::gibrightarm(entity);
    }
}

// Namespace robotsoldierserverutils
// Params 5, eflags: 0x5 linked
// namespace_8509e91d<file_0>::function_5cde4a52
// Checksum 0x89ab4cd8, Offset: 0xb600
// Size: 0x404
function private _trygibbinglegs(entity, damage, hitloc, isexplosive, attacker) {
    if (!isdefined(attacker)) {
        attacker = entity;
    }
    cangiblegs = entity.health - damage <= 0 && entity.allowdeath;
    if (entity ai::get_behavior_attribute("can_become_crawler")) {
        cangiblegs = (entity.health - damage) / entity.maxhealth <= 0.25 && distancesquared(entity.origin, attacker.origin) <= 360000 && !robotsoldierbehavior::robotisatcovercondition(entity) && (cangiblegs || entity.allowdeath);
    }
    if (entity.gibdeath && entity.health - damage <= 0 && entity.allowdeath && !robotsoldierbehavior::robotiscrawler(entity)) {
        return;
    }
    if (entity.health - damage <= 0 && entity.allowdeath && isexplosive && randomfloatrange(0, 1) <= 0.5) {
        gibserverutils::giblegs(entity);
        entity startragdoll();
        return;
    }
    if (cangiblegs && isinarray(array("left_leg_upper", "left_leg_lower", "left_foot"), hitloc) && randomfloatrange(0, 1) <= 1) {
        if (entity.health - damage > 0) {
            becomecrawler(entity);
        }
        gibserverutils::gibleftleg(entity);
        return;
    }
    if (cangiblegs && isinarray(array("right_leg_upper", "right_leg_lower", "right_foot"), hitloc) && randomfloatrange(0, 1) <= 1) {
        if (entity.health - damage > 0) {
            becomecrawler(entity);
        }
        gibserverutils::gibrightleg(entity);
        return;
    }
    if (entity.health - damage <= 0 && entity.allowdeath && randomfloatrange(0, 1) <= 0.25) {
        if (math::cointoss()) {
            gibserverutils::gibleftleg(entity);
            return;
        }
        gibserverutils::gibrightleg(entity);
    }
}

// Namespace robotsoldierserverutils
// Params 12, eflags: 0x5 linked
// namespace_8509e91d<file_0>::function_8f8ab878
// Checksum 0xee873ad5, Offset: 0xba10
// Size: 0x208
function private robotgibdamageoverride(inflictor, attacker, damage, flags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    entity = self;
    if (isdefined(attacker) && attacker.team == entity.team) {
        return damage;
    }
    if (!entity ai::get_behavior_attribute("can_gib")) {
        return damage;
    }
    if ((entity.health - damage) / entity.maxhealth > 0.75) {
        return damage;
    }
    gibserverutils::togglespawngibs(entity, 1);
    destructserverutils::togglespawngibs(entity, 1);
    isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
    _trygibbinghead(entity, damage, hitloc, isexplosive);
    _trygibbinglimb(entity, damage, hitloc, isexplosive, 0);
    _trygibbinglegs(entity, damage, hitloc, isexplosive, attacker);
    return damage;
}

// Namespace robotsoldierserverutils
// Params 8, eflags: 0x5 linked
// namespace_8509e91d<file_0>::function_7153ea3f
// Checksum 0x5e889bf3, Offset: 0xbc20
// Size: 0x78
function private robotdeathoverride(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime) {
    entity = self;
    entity ai::set_behavior_attribute("robot_lights", 4);
    return damage;
}

// Namespace robotsoldierserverutils
// Params 8, eflags: 0x5 linked
// namespace_8509e91d<file_0>::function_d6ff5077
// Checksum 0x40b66bab, Offset: 0xbca0
// Size: 0x310
function private robotgibdeathoverride(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime) {
    entity = self;
    if (!entity ai::get_behavior_attribute("can_gib") || entity.skipdeath) {
        return damage;
    }
    gibserverutils::togglespawngibs(entity, 1);
    destructserverutils::togglespawngibs(entity, 1);
    isexplosive = 0;
    if (entity.controllevel >= 3) {
        clientfield::set("robot_mind_control_explosion", 1);
        destructserverutils::destructnumberrandompieces(entity);
        gibserverutils::gibhead(entity);
        if (math::cointoss()) {
            gibserverutils::gibleftarm(entity);
        } else {
            gibserverutils::gibrightarm(entity);
        }
        gibserverutils::giblegs(entity);
        velocity = entity getvelocity() / 9;
        entity startragdoll();
        entity launchragdoll((velocity[0] + randomfloatrange(-10, 10), velocity[1] + randomfloatrange(-10, 10), randomfloatrange(40, 50)), "j_mainroot");
        physicsexplosionsphere(entity.origin + (0, 0, 36), 120, 32, 1);
    } else {
        isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdeath);
        _trygibbinglimb(entity, damage, hitloc, isexplosive, 1);
    }
    return damage;
}

// Namespace robotsoldierserverutils
// Params 8, eflags: 0x5 linked
// namespace_8509e91d<file_0>::function_f6b76749
// Checksum 0x4fe93a46, Offset: 0xbfb8
// Size: 0x208
function private robotdestructdeathoverride(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime) {
    entity = self;
    if (entity.skipdeath) {
        return damage;
    }
    destructserverutils::togglespawngibs(entity, 1);
    piececount = destructserverutils::getpiececount(entity);
    possiblepieces = [];
    for (index = 1; index <= piececount; index++) {
        if (!destructserverutils::isdestructed(entity, index) && randomfloatrange(0, 1) <= 0.2) {
            possiblepieces[possiblepieces.size] = index;
        }
    }
    gibbedpieces = 0;
    for (index = 0; index < possiblepieces.size && possiblepieces.size > 1 && gibbedpieces < 2; index++) {
        randompiece = randomintrange(0, possiblepieces.size - 1);
        if (!destructserverutils::isdestructed(entity, possiblepieces[randompiece])) {
            destructserverutils::destructpiece(entity, possiblepieces[randompiece]);
            gibbedpieces++;
        }
    }
    return damage;
}

// Namespace robotsoldierserverutils
// Params 12, eflags: 0x5 linked
// namespace_8509e91d<file_0>::function_60251d0
// Checksum 0x95695e22, Offset: 0xc1c8
// Size: 0x396
function private robotdamageoverride(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    entity = self;
    if (hitloc != "helmet" || hitloc != "head" || hitloc != "neck") {
        if (isdefined(attacker) && !isplayer(attacker) && !isvehicle(attacker)) {
            dist = distancesquared(entity.origin, attacker.origin);
            if (dist < 65536) {
                damage = int(damage * 10);
            } else {
                damage = int(damage * 1.5);
            }
        }
    }
    if (hitloc == "helmet" || hitloc == "head" || hitloc == "neck") {
        damage = int(damage * 0.5);
    }
    if (isdefined(dir) && isdefined(meansofdamage) && isdefined(hitloc) && vectordot(anglestoforward(entity.angles), dir) > 0) {
        isbullet = isinarray(array("MOD_RIFLE_BULLET", "MOD_PISTOL_BULLET"), meansofdamage);
        istorsoshot = isinarray(array("torso_upper", "torso_lower"), hitloc);
        if (isbullet && istorsoshot) {
            damage = int(damage * 2);
        }
    }
    if (weapon.name == "sticky_grenade") {
        switch (meansofdamage) {
        case 230:
            entity.stuckwithstickygrenade = 1;
            break;
        case 192:
            if (isdefined(entity.stuckwithstickygrenade) && entity.stuckwithstickygrenade) {
                damage = entity.health;
            }
            break;
        }
    }
    if (meansofdamage == "MOD_TRIGGER_HURT" && entity.ignoretriggerdamage) {
        damage = 0;
    }
    return damage;
}

// Namespace robotsoldierserverutils
// Params 12, eflags: 0x5 linked
// namespace_8509e91d<file_0>::function_543a4a79
// Checksum 0xde7d49a2, Offset: 0xc568
// Size: 0xf8
function private robotdestructrandompieces(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    entity = self;
    isexplosive = isinarray(array("MOD_CRUSH", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE"), meansofdamage);
    if (isexplosive) {
        destructserverutils::destructrandompieces(entity);
    }
    return damage;
}

// Namespace robotsoldierserverutils
// Params 1, eflags: 0x4
// namespace_8509e91d<file_0>::function_c2c5b9e7
// Checksum 0x140a47ac, Offset: 0xc668
// Size: 0x8c
function private findclosestnavmeshpositiontoenemy(enemy) {
    enemypositiononnavmesh = undefined;
    for (tolerancelevel = 1; tolerancelevel <= 4; tolerancelevel++) {
        enemypositiononnavmesh = getclosestpointonnavmesh(enemy.origin, -56 * tolerancelevel, 30);
        if (isdefined(enemypositiononnavmesh)) {
            break;
        }
    }
    return enemypositiononnavmesh;
}

// Namespace robotsoldierserverutils
// Params 2, eflags: 0x4
// namespace_8509e91d<file_0>::function_f007a52c
// Checksum 0xd150017e, Offset: 0xc700
// Size: 0xac
function private robotchoosecoverdirection(entity, stepout) {
    if (!isdefined(entity.node)) {
        return;
    }
    coverdirection = blackboard::getblackboardattribute(entity, "_cover_direction");
    blackboard::setblackboardattribute(entity, "_previous_cover_direction", coverdirection);
    blackboard::setblackboardattribute(entity, "_cover_direction", aiutility::calculatecoverdirection(entity, stepout));
}

// Namespace robotsoldierserverutils
// Params 0, eflags: 0x5 linked
// namespace_8509e91d<file_0>::function_23cfe26f
// Checksum 0xc1ef79dd, Offset: 0xc7b8
// Size: 0x644
function private robotsoldierspawnsetup() {
    entity = self;
    entity.iscrawler = 0;
    entity.becomecrawler = 0;
    entity.combatmode = "cover";
    entity.fullhealth = entity.health;
    entity.controllevel = 0;
    entity.steppedoutofcover = 0;
    entity.ignoretriggerdamage = 0;
    entity.startingweapon = entity.weapon;
    entity.jukedistance = 90;
    entity.jukemaxdistance = 1200;
    entity.entityradius = 15;
    entity.empshutdowntime = 2000;
    entity.nofriendlyfire = 1;
    entity.ignorerunandgundist = 1;
    entity.disablerepath = 0;
    entity.robotrushermaxradius = -6;
    entity.robotrusherminradius = -106;
    entity.gibdeath = math::cointoss();
    entity.minwalkdistance = -16;
    entity.supersprintdistance = 300;
    entity.treatallcoversasgeneric = 1;
    entity.onlycroucharrivals = 1;
    entity.chargemeleedistance = 125;
    entity.var_e44890d6 = 1;
    entity.nextpreemptivejukeads = randomfloatrange(0.5, 0.95);
    entity.shouldpreemptivejuke = math::cointoss();
    destructserverutils::togglespawngibs(entity, 1);
    gibserverutils::togglespawngibs(entity, 1);
    clientfield::set("robot_mind_control", 0);
    /#
        if (getdvarint("robotStepOutAction")) {
            entity ai::set_behavior_attribute("robotStepOutAction", "robotStepOutAction");
        }
    #/
    entity thread cleanupequipment(entity);
    aiutility::addaioverridedamagecallback(entity, &destructserverutils::handledamage);
    aiutility::addaioverridedamagecallback(entity, &robotdamageoverride);
    aiutility::addaioverridedamagecallback(entity, &robotdestructrandompieces);
    aiutility::addaioverridedamagecallback(entity, &robotgibdamageoverride);
    aiutility::addaioverridekilledcallback(entity, &robotdeathoverride);
    aiutility::addaioverridekilledcallback(entity, &robotgibdeathoverride);
    aiutility::addaioverridekilledcallback(entity, &robotdestructdeathoverride);
    /#
        if (getdvarint("robotStepOutAction") == 1) {
            entity ai::set_behavior_attribute("robotStepOutAction", "robotStepOutAction");
        } else if (getdvarint("robotStepOutAction") == 2) {
            entity ai::set_behavior_attribute("robotStepOutAction", "robotStepOutAction");
        } else if (getdvarint("robotStepOutAction") == 3) {
            entity ai::set_behavior_attribute("robotStepOutAction", "robotStepOutAction");
        }
        if (getdvarint("robotStepOutAction") == 1) {
            entity ai::set_behavior_attribute("robotStepOutAction", "robotStepOutAction");
        } else if (getdvarint("robotStepOutAction") == 2) {
            entity ai::set_behavior_attribute("robotStepOutAction", "robotStepOutAction");
        } else if (getdvarint("robotStepOutAction") == 3) {
            entity ai::set_behavior_attribute("robotStepOutAction", "robotStepOutAction");
        }
    #/
    if (getdvarint("ai_robotForceCrawler") == 1) {
        entity ai::set_behavior_attribute("force_crawler", "gib_legs");
        return;
    }
    if (getdvarint("ai_robotForceCrawler") == 2) {
        entity ai::set_behavior_attribute("force_crawler", "remove_legs");
    }
}

// Namespace robotsoldierserverutils
// Params 1, eflags: 0x4
// namespace_8509e91d<file_0>::function_4f8dcbb1
// Checksum 0x62bca8e2, Offset: 0xce08
// Size: 0xd8
function private robotgivewasp(entity) {
    if (isdefined(entity) && !isdefined(entity.wasp)) {
        wasp = spawn("script_model", (0, 0, 0));
        wasp setmodel("veh_t7_drone_attack_red");
        wasp setscale(0.75);
        wasp linkto(entity, "j_spine4", (5, -15, 0), (0, 0, 90));
        entity.wasp = wasp;
    }
}

// Namespace robotsoldierserverutils
// Params 1, eflags: 0x4
// namespace_8509e91d<file_0>::function_6f89aedf
// Checksum 0x72dac310, Offset: 0xcee8
// Size: 0x132
function private robotdeploywasp(entity) {
    entity endon(#"death");
    wait(randomfloatrange(7, 10));
    if (isdefined(entity) && isdefined(entity.wasp)) {
        spawnoffset = (5, -15, 0);
        while (!ispointinnavvolume(entity.wasp.origin + spawnoffset, "small volume")) {
            wait(1);
        }
        entity.wasp unlink();
        wasp = spawnvehicle("spawner_bo3_wasp_enemy", entity.wasp.origin + spawnoffset, (0, 0, 0));
        entity.wasp delete();
    }
    entity.wasp = undefined;
}

// Namespace robotsoldierserverutils
// Params 1, eflags: 0x5 linked
// namespace_8509e91d<file_0>::function_cae74906
// Checksum 0x937bb8df, Offset: 0xd028
// Size: 0x44
function private rapsdetonatecountdown(entity) {
    entity endon(#"death");
    wait(randomfloatrange(20, 30));
    raps::detonate();
}

// Namespace robotsoldierserverutils
// Params 1, eflags: 0x5 linked
// namespace_8509e91d<file_0>::function_a9ae106
// Checksum 0xc93aa75e, Offset: 0xd078
// Size: 0x58
function private becomecrawler(entity) {
    if (!robotsoldierbehavior::robotiscrawler(entity) && entity ai::get_behavior_attribute("can_become_crawler")) {
        entity.becomecrawler = 1;
    }
}

// Namespace robotsoldierserverutils
// Params 1, eflags: 0x5 linked
// namespace_8509e91d<file_0>::function_929a26f9
// Checksum 0x441c4fa7, Offset: 0xd0d8
// Size: 0x82
function private cleanupequipment(entity) {
    entity waittill(#"death");
    if (!isdefined(entity)) {
        return;
    }
    if (isdefined(entity.miniraps)) {
        entity.miniraps = undefined;
    }
    if (isdefined(entity.wasp)) {
        entity.wasp delete();
        entity.wasp = undefined;
    }
}

// Namespace robotsoldierserverutils
// Params 0, eflags: 0x5 linked
// namespace_8509e91d<file_0>::function_6b7c4e44
// Checksum 0xe4268612, Offset: 0xd168
// Size: 0x9c
function private forcerobotsoldiermindcontrollevel1() {
    entity = self;
    if (entity.controllevel >= 1) {
        return;
    }
    entity.team = "team3";
    entity.controllevel = 1;
    clientfield::set("robot_mind_control", 1);
    entity ai::set_behavior_attribute("rogue_control", "level_1");
}

// Namespace robotsoldierserverutils
// Params 0, eflags: 0x5 linked
// namespace_8509e91d<file_0>::function_dd83bd7f
// Checksum 0x9c933b01, Offset: 0xd210
// Size: 0x2c4
function private forcerobotsoldiermindcontrollevel2() {
    entity = self;
    if (entity.controllevel >= 2) {
        return;
    }
    rogue_melee_weapon = getweapon("rogue_robot_melee");
    locomotiontypes = array("alt1", "alt2", "alt3", "alt4", "alt5");
    blackboard::setblackboardattribute(entity, "_robot_locomotion_type", locomotiontypes[randomint(locomotiontypes.size)]);
    entity asmsetanimationrate(randomfloatrange(0.95, 1.05));
    entity forcerobotsoldiermindcontrollevel1();
    entity.combatmode = "no_cover";
    entity setavoidancemask("avoid none");
    entity.controllevel = 2;
    entity shared::placeweaponon(entity.weapon, "none");
    entity.meleeweapon = rogue_melee_weapon;
    entity.dontdropweapon = 1;
    entity.ignorepathenemyfightdist = 1;
    if (entity ai::get_behavior_attribute("rogue_allow_predestruct")) {
        destructserverutils::destructrandompieces(entity);
    }
    if (entity.health > entity.maxhealth * 0.6) {
        entity.health = int(entity.maxhealth * 0.6);
    }
    clientfield::set("robot_mind_control", 2);
    entity ai::set_behavior_attribute("rogue_control", "level_2");
    entity ai::set_behavior_attribute("can_become_crawler", 0);
}

// Namespace robotsoldierserverutils
// Params 0, eflags: 0x5 linked
// namespace_8509e91d<file_0>::function_b7814316
// Checksum 0xd92e82f4, Offset: 0xd4e0
// Size: 0x9c
function private forcerobotsoldiermindcontrollevel3() {
    entity = self;
    if (entity.controllevel >= 3) {
        return;
    }
    forcerobotsoldiermindcontrollevel2();
    entity.controllevel = 3;
    clientfield::set("robot_mind_control", 3);
    entity ai::set_behavior_attribute("rogue_control", "level_3");
}

// Namespace robotsoldierserverutils
// Params 4, eflags: 0x1 linked
// namespace_8509e91d<file_0>::function_8494e898
// Checksum 0x1cbdf600, Offset: 0xd588
// Size: 0x38
function robotequipminiraps(entity, attribute, oldvalue, value) {
    entity.miniraps = value;
}

// Namespace robotsoldierserverutils
// Params 4, eflags: 0x1 linked
// namespace_8509e91d<file_0>::function_84bc3ebc
// Checksum 0x77ebd5c5, Offset: 0xd5c8
// Size: 0x104
function robotlights(entity, attribute, oldvalue, value) {
    if (value == 3) {
        clientfield::set("robot_lights", 3);
        return;
    }
    if (value == 0) {
        clientfield::set("robot_lights", 0);
        return;
    }
    if (value == 1) {
        clientfield::set("robot_lights", 1);
        return;
    }
    if (value == 2) {
        clientfield::set("robot_lights", 2);
        return;
    }
    if (value == 4) {
        clientfield::set("robot_lights", 4);
    }
}

// Namespace robotsoldierserverutils
// Params 1, eflags: 0x1 linked
// namespace_8509e91d<file_0>::function_facc77c
// Checksum 0xe2be951b, Offset: 0xd6d8
// Size: 0xf4
function randomgibroguerobot(entity) {
    gibserverutils::togglespawngibs(entity, 0);
    if (math::cointoss()) {
        if (math::cointoss()) {
            gibserverutils::gibrightarm(entity);
        } else if (math::cointoss()) {
            gibserverutils::gibleftarm(entity);
        }
        return;
    }
    if (math::cointoss()) {
        gibserverutils::gibleftarm(entity);
        return;
    }
    if (math::cointoss()) {
        gibserverutils::gibrightarm(entity);
    }
}

// Namespace robotsoldierserverutils
// Params 4, eflags: 0x1 linked
// namespace_8509e91d<file_0>::function_b8afd119
// Checksum 0x58c2ca, Offset: 0xd7d8
// Size: 0x176
function roguecontrolattributecallback(entity, attribute, oldvalue, value) {
    switch (value) {
    case 252:
        if (entity.controllevel <= 0) {
            forcerobotsoldiermindcontrollevel1();
        }
        break;
    case 253:
        if (entity.controllevel <= 1) {
            forcerobotsoldiermindcontrollevel2();
            destructserverutils::togglespawngibs(entity, 0);
            if (entity ai::get_behavior_attribute("rogue_allow_pregib")) {
                randomgibroguerobot(entity);
            }
        }
        break;
    case 254:
        if (entity.controllevel <= 2) {
            forcerobotsoldiermindcontrollevel3();
            destructserverutils::togglespawngibs(entity, 0);
            if (entity ai::get_behavior_attribute("rogue_allow_pregib")) {
                randomgibroguerobot(entity);
            }
        }
        break;
    }
}

// Namespace robotsoldierserverutils
// Params 4, eflags: 0x1 linked
// namespace_8509e91d<file_0>::function_9f706ada
// Checksum 0xcbb6752b, Offset: 0xd958
// Size: 0x146
function robotmovemodeattributecallback(entity, attribute, oldvalue, value) {
    entity.ignorepathenemyfightdist = 0;
    blackboard::setblackboardattribute(entity, "_move_mode", "normal");
    if (value != "guard") {
        entity.guardposition = undefined;
    }
    switch (value) {
    case 132:
        break;
    case 256:
        entity.ignorepathenemyfightdist = 1;
        break;
    case 160:
        entity.ignorepathenemyfightdist = 1;
        blackboard::setblackboardattribute(entity, "_move_mode", "marching");
        break;
    case 172:
        if (!entity ai::get_behavior_attribute("can_become_rusher")) {
            entity ai::set_behavior_attribute("move_mode", oldvalue);
        }
        break;
    }
}

// Namespace robotsoldierserverutils
// Params 4, eflags: 0x1 linked
// namespace_8509e91d<file_0>::function_6a7d7354
// Checksum 0x66a94c3b, Offset: 0xdaa8
// Size: 0x24c
function robotforcecrawler(entity, attribute, oldvalue, value) {
    if (robotsoldierbehavior::robotiscrawler(entity)) {
        return;
    }
    if (!entity ai::get_behavior_attribute("can_become_crawler")) {
        return;
    }
    switch (value) {
    case 132:
        return;
    case 235:
        gibserverutils::togglespawngibs(entity, 1);
        destructserverutils::togglespawngibs(entity, 1);
        break;
    case 237:
        gibserverutils::togglespawngibs(entity, 0);
        destructserverutils::togglespawngibs(entity, 0);
        break;
    }
    if (value == "gib_legs" || value == "remove_legs") {
        if (math::cointoss()) {
            if (math::cointoss()) {
                gibserverutils::gibrightleg(entity);
            } else {
                gibserverutils::gibleftleg(entity);
            }
        } else {
            gibserverutils::giblegs(entity);
        }
        if (entity.health > entity.maxhealth * 0.25) {
            entity.health = int(entity.maxhealth * 0.25);
        }
        destructserverutils::destructrandompieces(entity);
        if (value == "gib_legs") {
            becomecrawler(entity);
            return;
        }
        robotsoldierbehavior::robotbecomecrawler(entity);
    }
}

// Namespace robotsoldierserverutils
// Params 4, eflags: 0x1 linked
// namespace_8509e91d<file_0>::function_31598e4d
// Checksum 0xc2811623, Offset: 0xdd00
// Size: 0x114
function roguecontrolforcegoalattributecallback(entity, attribute, oldvalue, value) {
    if (!isvec(value)) {
        return;
    }
    roguecontrolled = isinarray(array("level_2", "level_3"), entity ai::get_behavior_attribute("rogue_control"));
    if (!roguecontrolled) {
        entity ai::set_behavior_attribute("rogue_control_force_goal", undefined);
        return;
    }
    entity.favoriteenemy = undefined;
    entity clearpath();
    entity useposition(entity ai::get_behavior_attribute("rogue_control_force_goal"));
}

// Namespace robotsoldierserverutils
// Params 4, eflags: 0x1 linked
// namespace_8509e91d<file_0>::function_bd55d65e
// Checksum 0xbe56418, Offset: 0xde20
// Size: 0xc6
function roguecontrolspeedattributecallback(entity, attribute, oldvalue, value) {
    switch (value) {
    case 167:
        blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_walk");
        break;
    case 165:
        blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_run");
        break;
    case 166:
        blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_sprint");
        break;
    }
}

// Namespace robotsoldierserverutils
// Params 4, eflags: 0x1 linked
// namespace_8509e91d<file_0>::function_62ac19bc
// Checksum 0xbb04acc1, Offset: 0xdef0
// Size: 0x72
function robottraversalattributecallback(entity, attribute, oldvalue, value) {
    switch (value) {
    case 132:
        entity.manualtraversemode = 0;
        break;
    case 109:
        entity.manualtraversemode = 1;
        break;
    }
}

