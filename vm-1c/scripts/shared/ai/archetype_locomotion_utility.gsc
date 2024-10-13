#using scripts/shared/math_shared;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/archetype_cover_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/behavior_state_machine;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai_shared;

#namespace aiutility;

// Namespace aiutility
// Params 0, eflags: 0x2
// Checksum 0x993aee67, Offset: 0x618
// Size: 0x55c
function autoexec registerbehaviorscriptfunctions() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("locomotionBehaviorCondition", &locomotionBehaviorCondition);
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionBehaviorCondition", &locomotionBehaviorCondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("nonCombatLocomotionCondition", &noncombatlocomotioncondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("setDesiredStanceForMovement", &setdesiredstanceformovement);
    behaviortreenetworkutility::registerbehaviortreescriptapi("clearPathFromScript", &clearpathfromscript);
    behaviortreenetworkutility::registerbehaviortreescriptapi("locomotionShouldPatrol", &locomotionshouldpatrol);
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionShouldPatrol", &locomotionshouldpatrol);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldTacticalWalk", &shouldtacticalwalk);
    behaviorstatemachine::registerbsmscriptapiinternal("shouldTacticalWalk", &shouldtacticalwalk);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldAdjustStanceAtTacticalWalk", &shouldadjuststanceattacticalwalk);
    behaviortreenetworkutility::registerbehaviortreescriptapi("adjustStanceToFaceEnemyInitialize", &adjuststancetofaceenemyinitialize);
    behaviortreenetworkutility::registerbehaviortreescriptapi("adjustStanceToFaceEnemyTerminate", &adjuststancetofaceenemyterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tacticalWalkActionStart", &tacticalwalkactionstart);
    behaviorstatemachine::registerbsmscriptapiinternal("tacticalWalkActionStart", &tacticalwalkactionstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("clearArrivalPos", &cleararrivalpos);
    behaviorstatemachine::registerbsmscriptapiinternal("clearArrivalPos", &cleararrivalpos);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldStartArrival", &shouldstartarrivalcondition);
    behaviorstatemachine::registerbsmscriptapiinternal("shouldStartArrival", &shouldstartarrivalcondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("locomotionShouldTraverse", &locomotionshouldtraverse);
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionShouldTraverse", &locomotionshouldtraverse);
    behaviortreenetworkutility::registerbehaviortreeaction("traverseActionStart", &traverseactionstart, undefined, undefined);
    behaviorstatemachine::registerbsmscriptapiinternal("traverseSetup", &traversesetup);
    behaviortreenetworkutility::registerbehaviortreescriptapi("disableRepath", &disablerepath);
    behaviortreenetworkutility::registerbehaviortreescriptapi("enableRepath", &enablerepath);
    behaviortreenetworkutility::registerbehaviortreescriptapi("canJuke", &canjuke);
    behaviortreenetworkutility::registerbehaviortreescriptapi("chooseJukeDirection", &choosejukedirection);
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionPainBehaviorCondition", &locomotionpainbehaviorcondition);
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionIsOnStairs", &locomotionisonstairs);
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionShouldLoopOnStairs", &locomotionshouldlooponstairs);
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionShouldSkipStairs", &locomotionshouldskipstairs);
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionStairsStart", &locomotionstairsstart);
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionStairsEnd", &locomotionstairsend);
    behaviortreenetworkutility::registerbehaviortreescriptapi("delayMovement", &delaymovement);
    behaviorstatemachine::registerbsmscriptapiinternal("delayMovement", &delaymovement);
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x5e696457, Offset: 0xb80
// Size: 0xa6
function private locomotionisonstairs(behaviortreeentity) {
    startnode = behaviortreeentity.traversestartnode;
    if (isdefined(startnode) && behaviortreeentity shouldstarttraversal()) {
        if (isdefined(startnode.animscript) && issubstr(tolower(startnode.animscript), "stairs")) {
            return true;
        }
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x4cdd98fa, Offset: 0xc30
// Size: 0x15a
function private locomotionshouldskipstairs(behaviortreeentity) {
    assert(isdefined(behaviortreeentity._stairsstartnode) && isdefined(behaviortreeentity._stairsendnode));
    numtotalsteps = blackboard::getblackboardattribute(behaviortreeentity, "_staircase_num_total_steps");
    stepssofar = blackboard::getblackboardattribute(behaviortreeentity, "_staircase_num_steps");
    direction = blackboard::getblackboardattribute(behaviortreeentity, "_staircase_direction");
    if (direction != "staircase_up") {
        return false;
    }
    numoutsteps = 2;
    totalstepswithoutout = numtotalsteps - numoutsteps;
    if (stepssofar >= totalstepswithoutout) {
        return false;
    }
    remainingsteps = totalstepswithoutout - stepssofar;
    if (remainingsteps >= 3 || remainingsteps >= 6 || remainingsteps >= 8) {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x31e6d82d, Offset: 0xd98
// Size: 0x18c
function private locomotionshouldlooponstairs(behaviortreeentity) {
    assert(isdefined(behaviortreeentity._stairsstartnode) && isdefined(behaviortreeentity._stairsendnode));
    numtotalsteps = blackboard::getblackboardattribute(behaviortreeentity, "_staircase_num_total_steps");
    stepssofar = blackboard::getblackboardattribute(behaviortreeentity, "_staircase_num_steps");
    exittype = blackboard::getblackboardattribute(behaviortreeentity, "_staircase_exit_type");
    direction = blackboard::getblackboardattribute(behaviortreeentity, "_staircase_direction");
    numoutsteps = 2;
    if (direction == "staircase_up") {
        switch (exittype) {
        case "staircase_up_exit_l_3_stairs":
        case "staircase_up_exit_r_3_stairs":
            numoutsteps = 3;
            break;
        case "staircase_up_exit_l_4_stairs":
        case "staircase_up_exit_r_4_stairs":
            numoutsteps = 4;
            break;
        }
    }
    if (stepssofar >= numtotalsteps - numoutsteps) {
        behaviortreeentity setstairsexittransform();
        return false;
    }
    return true;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x17cadfe5, Offset: 0xf30
// Size: 0x390
function private locomotionstairsstart(behaviortreeentity) {
    startnode = behaviortreeentity.traversestartnode;
    endnode = behaviortreeentity.traverseendnode;
    assert(isdefined(startnode) && isdefined(endnode));
    behaviortreeentity._stairsstartnode = startnode;
    behaviortreeentity._stairsendnode = endnode;
    if (startnode.type == "Begin") {
        direction = "staircase_down";
    } else {
        direction = "staircase_up";
    }
    blackboard::setblackboardattribute(behaviortreeentity, "_staircase_type", behaviortreeentity._stairsstartnode.animscript);
    blackboard::setblackboardattribute(behaviortreeentity, "_staircase_state", "staircase_start");
    blackboard::setblackboardattribute(behaviortreeentity, "_staircase_direction", direction);
    numtotalsteps = undefined;
    if (isdefined(startnode.script_int)) {
        numtotalsteps = int(endnode.script_int);
    } else if (isdefined(endnode.script_int)) {
        numtotalsteps = int(endnode.script_int);
    }
    assert(isdefined(numtotalsteps) && isint(numtotalsteps) && numtotalsteps > 0);
    blackboard::setblackboardattribute(behaviortreeentity, "_staircase_num_total_steps", numtotalsteps);
    blackboard::setblackboardattribute(behaviortreeentity, "_staircase_num_steps", 0);
    exittype = undefined;
    if (direction == "staircase_up") {
        switch (int(behaviortreeentity._stairsstartnode.script_int) % 4) {
        case 0:
            exittype = "staircase_up_exit_r_3_stairs";
            break;
        case 1:
            exittype = "staircase_up_exit_r_4_stairs";
            break;
        case 2:
            exittype = "staircase_up_exit_l_3_stairs";
            break;
        case 3:
            exittype = "staircase_up_exit_l_4_stairs";
            break;
        }
    } else {
        switch (int(behaviortreeentity._stairsstartnode.script_int) % 2) {
        case 0:
            exittype = "staircase_down_exit_l_2_stairs";
            break;
        case 1:
            exittype = "staircase_down_exit_r_2_stairs";
            break;
        }
    }
    blackboard::setblackboardattribute(behaviortreeentity, "_staircase_exit_type", exittype);
    return true;
}

// Namespace aiutility
// Params 1, eflags: 0x4
// Checksum 0xc865e4bb, Offset: 0x12c8
// Size: 0x6c
function private locomotionstairloopstart(behaviortreeentity) {
    assert(isdefined(behaviortreeentity._stairsstartnode) && isdefined(behaviortreeentity._stairsendnode));
    blackboard::setblackboardattribute(behaviortreeentity, "_staircase_state", "staircase_loop");
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x40084f0d, Offset: 0x1340
// Size: 0x4c
function private locomotionstairsend(behaviortreeentity) {
    blackboard::setblackboardattribute(behaviortreeentity, "_staircase_state", undefined);
    blackboard::setblackboardattribute(behaviortreeentity, "_staircase_direction", undefined);
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xded5d031, Offset: 0x1398
// Size: 0x42
function private locomotionpainbehaviorcondition(entity) {
    return entity haspath() && entity hasvalidinterrupt("pain");
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x8733d9c1, Offset: 0x13e8
// Size: 0x24
function clearpathfromscript(behaviortreeentity) {
    behaviortreeentity clearpath();
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x40c8cc88, Offset: 0x1418
// Size: 0x70
function private noncombatlocomotioncondition(behaviortreeentity) {
    if (!behaviortreeentity haspath()) {
        return false;
    }
    if (isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
        return true;
    }
    if (isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    return true;
}

// Namespace aiutility
// Params 1, eflags: 0x4
// Checksum 0x7e130122, Offset: 0x1490
// Size: 0x6c
function private combatlocomotioncondition(behaviortreeentity) {
    if (!behaviortreeentity haspath()) {
        return false;
    }
    if (isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
        return false;
    }
    if (isdefined(behaviortreeentity.enemy)) {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x95d61dda, Offset: 0x1508
// Size: 0x22
function locomotionBehaviorCondition(behaviortreeentity) {
    return behaviortreeentity haspath();
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x35ce5fb6, Offset: 0x1538
// Size: 0x5c
function private setdesiredstanceformovement(behaviortreeentity) {
    if (blackboard::getblackboardattribute(behaviortreeentity, "_stance") != "stand") {
        blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
    }
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x82f37e3f, Offset: 0x15a0
// Size: 0x56
function private locomotionshouldtraverse(behaviortreeentity) {
    startnode = behaviortreeentity.traversestartnode;
    if (isdefined(startnode) && behaviortreeentity shouldstarttraversal()) {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x30c97292, Offset: 0x1600
// Size: 0x68
function traversesetup(behaviortreeentity) {
    blackboard::setblackboardattribute(behaviortreeentity, "_stance", "stand");
    blackboard::setblackboardattribute(behaviortreeentity, "_traversal_type", behaviortreeentity.traversestartnode.animscript);
    return true;
}

// Namespace aiutility
// Params 2, eflags: 0x1 linked
// Checksum 0x9da120ed, Offset: 0x1670
// Size: 0x100
function traverseactionstart(behaviortreeentity, asmstatename) {
    traversesetup(behaviortreeentity);
    /#
        var_be841c75 = behaviortreeentity astsearch(istring(asmstatename));
        assert(isdefined(var_be841c75["<dev string:x28>"]), behaviortreeentity.archetype + "<dev string:x32>" + behaviortreeentity.traversestartnode.animscript + "<dev string:x57>" + behaviortreeentity.traversestartnode.origin + "<dev string:x5b>");
    #/
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x87e3aa3f, Offset: 0x1778
// Size: 0x20
function private disablerepath(entity) {
    entity.disablerepath = 1;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x52d28ee, Offset: 0x17a0
// Size: 0x1c
function private enablerepath(entity) {
    entity.disablerepath = 0;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xeae52fe1, Offset: 0x17c8
// Size: 0x2e
function shouldstartarrivalcondition(behaviortreeentity) {
    if (behaviortreeentity shouldstartarrival()) {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x1d818f77, Offset: 0x1800
// Size: 0x60
function cleararrivalpos(behaviortreeentity) {
    if (isdefined(behaviortreeentity.isarrivalpending) && (!isdefined(behaviortreeentity.isarrivalpending) || behaviortreeentity.isarrivalpending)) {
        self clearuseposition();
    }
    return true;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xe3da1a7f, Offset: 0x1868
// Size: 0x48
function delaymovement(entity) {
    entity pathmode("move delayed", 0, randomfloatrange(1, 2));
    return true;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x18005f1c, Offset: 0x18b8
// Size: 0x50
function private shouldadjuststanceattacticalwalk(behaviortreeentity) {
    stance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
    if (stance != "stand") {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x7b3442d, Offset: 0x1910
// Size: 0x68
function private adjuststancetofaceenemyinitialize(behaviortreeentity) {
    behaviortreeentity.newenemyreaction = 0;
    blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
    behaviortreeentity orientmode("face enemy");
    return true;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x5b09bfac, Offset: 0x1980
// Size: 0x34
function private adjuststancetofaceenemyterminate(behaviortreeentity) {
    blackboard::setblackboardattribute(behaviortreeentity, "_stance", "stand");
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x1f79ea79, Offset: 0x19c0
// Size: 0xa0
function private tacticalwalkactionstart(behaviortreeentity) {
    cleararrivalpos(behaviortreeentity);
    resetcoverparameters(behaviortreeentity);
    setcanbeflanked(behaviortreeentity, 0);
    blackboard::setblackboardattribute(behaviortreeentity, "_stance", "stand");
    behaviortreeentity orientmode("face enemy");
    return true;
}

// Namespace aiutility
// Params 4, eflags: 0x5 linked
// Checksum 0xda2b73a9, Offset: 0x1a68
// Size: 0x14e
function private validjukedirection(entity, entitynavmeshposition, forwardoffset, lateraloffset) {
    jukenavmeshthreshold = 6;
    forwardposition = entity.origin + lateraloffset + forwardoffset;
    backwardposition = entity.origin + lateraloffset - forwardoffset;
    forwardpositionvalid = ispointonnavmesh(forwardposition, entity) && tracepassedonnavmesh(entity.origin, forwardposition);
    backwardpositionvalid = ispointonnavmesh(backwardposition, entity) && tracepassedonnavmesh(entity.origin, backwardposition);
    if (!isdefined(entity.ignorebackwardposition)) {
        return (forwardpositionvalid && backwardpositionvalid);
    } else {
        return forwardpositionvalid;
    }
    return 0;
}

// Namespace aiutility
// Params 3, eflags: 0x1 linked
// Checksum 0x260240ea, Offset: 0x1bc0
// Size: 0x31c
function calculatejukedirection(entity, entityradius, jukedistance) {
    jukenavmeshthreshold = 6;
    defaultdirection = "forward";
    if (isdefined(entity.defaultjukedirection)) {
        defaultdirection = entity.defaultjukedirection;
    }
    if (isdefined(entity.enemy)) {
        navmeshposition = getclosestpointonnavmesh(entity.origin, jukenavmeshthreshold);
        if (!isvec(navmeshposition)) {
            return defaultdirection;
        }
        vectortoenemy = entity.enemy.origin - entity.origin;
        vectortoenemyangles = vectortoangles(vectortoenemy);
        forwarddistance = anglestoforward(vectortoenemyangles) * entityradius;
        rightjukedistance = anglestoright(vectortoenemyangles) * jukedistance;
        preferleft = undefined;
        if (entity haspath()) {
            rightposition = entity.origin + rightjukedistance;
            leftposition = entity.origin - rightjukedistance;
            preferleft = distancesquared(leftposition, entity.pathgoalpos) <= distancesquared(rightposition, entity.pathgoalpos);
        } else {
            preferleft = math::cointoss();
        }
        if (preferleft) {
            if (validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance * -1)) {
                return "left";
            } else if (validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance)) {
                return "right";
            }
        } else if (validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance)) {
            return "right";
        } else if (validjukedirection(entity, navmeshposition, forwarddistance, rightjukedistance * -1)) {
            return "left";
        }
    }
    return defaultdirection;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xbf77357, Offset: 0x1ee8
// Size: 0x9a
function private calculatedefaultjukedirection(entity) {
    jukedistance = 30;
    entityradius = 15;
    if (isdefined(entity.jukedistance)) {
        jukedistance = entity.jukedistance;
    }
    if (isdefined(entity.entityradius)) {
        entityradius = entity.entityradius;
    }
    return calculatejukedirection(entity, entityradius, jukedistance);
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xabdaaff4, Offset: 0x1f90
// Size: 0xe4
function canjuke(entity) {
    if (isdefined(self.is_disabled) && self.is_disabled) {
        return false;
    }
    if (isdefined(entity.jukemaxdistance) && isdefined(entity.enemy)) {
        maxdistsquared = entity.jukemaxdistance * entity.jukemaxdistance;
        if (distance2dsquared(entity.origin, entity.enemy.origin) > maxdistsquared) {
            return false;
        }
    }
    jukedirection = calculatedefaultjukedirection(entity);
    return jukedirection != "forward";
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xa9c71271, Offset: 0x2080
// Size: 0x54
function choosejukedirection(entity) {
    jukedirection = calculatedefaultjukedirection(entity);
    blackboard::setblackboardattribute(entity, "_juke_direction", jukedirection);
}

