#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_state_machine;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;

#namespace archetype_human_locomotion;

// Namespace archetype_human_locomotion
// Params 0, eflags: 0x2
// Checksum 0x40cf54e3, Offset: 0x558
// Size: 0x39c
function autoexec registerbehaviorscriptfunctions() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("prepareForMovement", &prepareformovement);
    behaviorstatemachine::registerbsmscriptapiinternal("prepareForMovement", &prepareformovement);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldTacticalArrive", &shouldtacticalarrivecondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("humanShouldSprint", &humanshouldsprint);
    behaviorstatemachine::registerbsmscriptapiinternal("planHumanArrivalAtCover", &planhumanarrivalatcover);
    behaviorstatemachine::registerbsmscriptapiinternal("shouldPlanArrivalIntoCover", &shouldplanarrivalintocover);
    behaviorstatemachine::registerbsmscriptapiinternal("shouldArriveExposed", &shouldarriveexposed);
    behaviorstatemachine::registerbsmscriptapiinternal("nonCombatLocomotionUpdate", &noncombatlocomotionupdate);
    behaviorstatemachine::registerbsmscriptapiinternal("combatLocomotionStart", &combatlocomotionstart);
    behaviorstatemachine::registerbsmscriptapiinternal("combatLocomotionUpdate", &combatlocomotionupdate);
    behaviorstatemachine::registerbsmscriptapiinternal("humanNonCombatLocomotionCondition", &humannoncombatlocomotioncondition);
    behaviorstatemachine::registerbsmscriptapiinternal("humanCombatLocomotionCondition", &humancombatlocomotioncondition);
    behaviorstatemachine::registerbsmscriptapiinternal("shouldSwitchToTacticalWalkFromRun", &shouldswitchtotacticalwalkfromrun);
    behaviortreenetworkutility::registerbehaviortreescriptapi("prepareToStopNearEnemy", &preparetostopnearenemy);
    behaviorstatemachine::registerbsmscriptapiinternal("prepareToStopNearEnemy", &preparetostopnearenemy);
    behaviortreenetworkutility::registerbehaviortreescriptapi("prepareToMoveAwayFromNearByEnemy", &preparetomoveawayfromnearbyenemy);
    behaviorstatemachine::registerbsmscriptapiinternal("shouldTacticalWalkPain", &shouldtacticalwalkpain);
    behaviorstatemachine::registerbsmscriptapiinternal("beginTacticalWalkPain", &begintacticalwalkpain);
    behaviorstatemachine::registerbsmscriptapiinternal("shouldContinueTacticalWalkPain", &shouldcontinuetacticalwalkpain);
    behaviorstatemachine::registerbsmscriptapiinternal("shouldTacticalWalkScan", &shouldtacticalwalkscan);
    behaviorstatemachine::registerbsmscriptapiinternal("continueTacticalWalkScan", &continuetacticalwalkscan);
    behaviorstatemachine::registerbsmscriptapiinternal("tacticalWalkScanTerminate", &tacticalwalkscanterminate);
    behaviorstatemachine::registerbsmscriptapiinternal("BSMLocomotionHasValidPainInterrupt", &bsmlocomotionhasvalidpaininterrupt);
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x221bbfa9, Offset: 0x900
// Size: 0x20
function private tacticalwalkscanterminate(entity) {
    entity.lasttacticalscantime = gettime();
    return true;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x6e9ebed3, Offset: 0x928
// Size: 0x130
function private shouldtacticalwalkscan(entity) {
    if (isdefined(entity.lasttacticalscantime) && entity.lasttacticalscantime + 2000 > gettime()) {
        return false;
    }
    if (!entity haspath()) {
        return false;
    }
    if (isdefined(entity.enemy)) {
        return false;
    }
    if (entity shouldfacemotion()) {
        if (ai::hasaiattribute(entity, "forceTacticalWalk") && !ai::getaiattribute(entity, "forceTacticalWalk")) {
            return false;
        }
    }
    animation = entity asmgetcurrentdeltaanimation();
    if (isdefined(animation)) {
        animtime = entity getanimtime(animation);
        return (animtime <= 0.05);
    }
    return false;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x724e8970, Offset: 0xa60
// Size: 0x150
function private continuetacticalwalkscan(entity) {
    if (!entity haspath()) {
        return false;
    }
    if (isdefined(entity.enemy)) {
        return false;
    }
    if (entity shouldfacemotion()) {
        if (ai::hasaiattribute(entity, "forceTacticalWalk") && !ai::getaiattribute(entity, "forceTacticalWalk")) {
            return false;
        }
    }
    animation = entity asmgetcurrentdeltaanimation();
    if (isdefined(animation)) {
        animlength = getanimlength(animation);
        animtime = entity getanimtime(animation) * animlength;
        normalizedtime = (animtime + 0.2) / animlength;
        return (normalizedtime < 1);
    }
    return false;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xae808487, Offset: 0xbb8
// Size: 0x76
function private shouldtacticalwalkpain(entity) {
    if ((!isdefined(entity.startpaintime) || entity.startpaintime + 3000 < gettime()) && randomfloat(1) > 0.25) {
        return bsmlocomotionhasvalidpaininterrupt(entity);
    }
    return 0;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x31754bab, Offset: 0xc38
// Size: 0x20
function private begintacticalwalkpain(entity) {
    entity.startpaintime = gettime();
    return true;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xd50db974, Offset: 0xc60
// Size: 0x24
function private shouldcontinuetacticalwalkpain(entity) {
    return entity.startpaintime + 100 >= gettime();
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xef2852b0, Offset: 0xc90
// Size: 0x2a
function private bsmlocomotionhasvalidpaininterrupt(entity) {
    return entity hasvalidinterrupt("pain");
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xdc6ba5ac, Offset: 0xcc8
// Size: 0xdc
function private shouldarriveexposed(behaviortreeentity) {
    if (behaviortreeentity ai::get_behavior_attribute("disablearrivals")) {
        return false;
    }
    if (behaviortreeentity haspath()) {
        if (isdefined(behaviortreeentity.node) && iscovernode(behaviortreeentity.node) && isdefined(behaviortreeentity.pathgoalpos) && distancesquared(behaviortreeentity.pathgoalpos, behaviortreeentity getnodeoffsetposition(behaviortreeentity.node)) < 8) {
            return false;
        }
    }
    return true;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x2ab3796a, Offset: 0xdb0
// Size: 0x38
function private preparetostopnearenemy(behaviortreeentity) {
    behaviortreeentity clearpath();
    behaviortreeentity.keepclaimednode = 1;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x4f1f9820, Offset: 0xdf0
// Size: 0x38
function private preparetomoveawayfromnearbyenemy(behaviortreeentity) {
    behaviortreeentity clearpath();
    behaviortreeentity.keepclaimednode = 1;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xd9d4d520, Offset: 0xe30
// Size: 0x1b8
function private shouldplanarrivalintocover(behaviortreeentity) {
    goingtocovernode = isdefined(behaviortreeentity.node) && iscovernode(behaviortreeentity.node);
    if (!goingtocovernode) {
        return false;
    }
    if (isdefined(behaviortreeentity.pathgoalpos)) {
        if (isdefined(behaviortreeentity.arrivalfinalpos)) {
            if (behaviortreeentity.arrivalfinalpos != behaviortreeentity.pathgoalpos) {
                return true;
            } else if (behaviortreeentity.replannedcoverarrival === 0 && isdefined(behaviortreeentity.exitpos) && isdefined(behaviortreeentity.predictedexitpos)) {
                behaviortreeentity.replannedcoverarrival = 1;
                exitdir = vectornormalize(behaviortreeentity.predictedexitpos - behaviortreeentity.exitpos);
                currentdir = vectornormalize(behaviortreeentity.origin - behaviortreeentity.exitpos);
                if (vectordot(exitdir, currentdir) < cos(30)) {
                    behaviortreeentity.predictedarrivaldirectionvalid = 0;
                    return true;
                }
            }
        }
    }
    return false;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xfe6a6802, Offset: 0xff0
// Size: 0x146
function private shouldswitchtotacticalwalkfromrun(behaviortreeentity) {
    if (!behaviortreeentity haspath()) {
        return false;
    }
    if (ai::hasaiattribute(behaviortreeentity, "forceTacticalWalk") && ai::getaiattribute(behaviortreeentity, "forceTacticalWalk")) {
        return true;
    }
    goalpos = undefined;
    if (isdefined(behaviortreeentity.arrivalfinalpos)) {
        goalpos = behaviortreeentity.arrivalfinalpos;
    } else {
        goalpos = behaviortreeentity.pathgoalpos;
    }
    if (isdefined(behaviortreeentity.pathstartpos) && isdefined(goalpos)) {
        pathdist = distancesquared(behaviortreeentity.pathstartpos, goalpos);
        if (pathdist < -6 * -6) {
            return true;
        }
    }
    if (!behaviortreeentity shouldfacemotion()) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x4f255d2f, Offset: 0x1140
// Size: 0x90
function private humannoncombatlocomotioncondition(behaviortreeentity) {
    if (!behaviortreeentity haspath()) {
        return false;
    }
    if (isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
        return true;
    }
    if (behaviortreeentity humanshouldsprint()) {
        return true;
    }
    if (isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    return true;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xb2eb04da, Offset: 0x11d8
// Size: 0x8c
function private humancombatlocomotioncondition(behaviortreeentity) {
    if (!behaviortreeentity haspath()) {
        return false;
    }
    if (isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
        return false;
    }
    if (behaviortreeentity humanshouldsprint()) {
        return false;
    }
    if (isdefined(behaviortreeentity.enemy)) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xacda02ef, Offset: 0x1270
// Size: 0xc8
function private combatlocomotionstart(behaviortreeentity) {
    randomchance = randomint(100);
    if (randomchance > 50) {
        blackboard::setblackboardattribute(behaviortreeentity, "_run_n_gun_variation", "variation_forward");
        return true;
    }
    if (randomchance > 25) {
        blackboard::setblackboardattribute(behaviortreeentity, "_run_n_gun_variation", "variation_strafe_1");
        return true;
    }
    blackboard::setblackboardattribute(behaviortreeentity, "_run_n_gun_variation", "variation_strafe_2");
    return true;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xb1b0623c, Offset: 0x1340
// Size: 0xfe
function private noncombatlocomotionupdate(behaviortreeentity) {
    if (!behaviortreeentity haspath()) {
        return false;
    }
    if (!(isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) && isdefined(behaviortreeentity.enemy) && !behaviortreeentity humanshouldsprint()) {
        return false;
    }
    if (!behaviortreeentity asmistransitionrunning()) {
        blackboard::setblackboardattribute(behaviortreeentity, "_stance", "stand");
        if (!isdefined(behaviortreeentity.replannedcoverarrival)) {
            behaviortreeentity.replannedcoverarrival = 0;
        }
    } else {
        behaviortreeentity.replannedcoverarrival = undefined;
    }
    return true;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x77c81a0a, Offset: 0x1448
// Size: 0xdc
function private combatlocomotionupdate(behaviortreeentity) {
    if (!behaviortreeentity haspath()) {
        return false;
    }
    if (behaviortreeentity humanshouldsprint()) {
        return false;
    }
    if (!behaviortreeentity asmistransitionrunning()) {
        blackboard::setblackboardattribute(behaviortreeentity, "_stance", "stand");
        if (!isdefined(behaviortreeentity.replannedcoverarrival)) {
            behaviortreeentity.replannedcoverarrival = 0;
        }
    } else {
        behaviortreeentity.replannedcoverarrival = undefined;
    }
    if (isdefined(behaviortreeentity.enemy)) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xde44eabb, Offset: 0x1530
// Size: 0x38
function private prepareformovement(behaviortreeentity) {
    blackboard::setblackboardattribute(behaviortreeentity, "_stance", "stand");
    return true;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x991c0b9c, Offset: 0x1570
// Size: 0x30
function private isarrivingfour(arrivalangle) {
    if (arrivalangle >= 45 && arrivalangle <= 120) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x562a9b33, Offset: 0x15a8
// Size: 0x30
function private isarrivingone(arrivalangle) {
    if (arrivalangle >= 120 && arrivalangle <= -91) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x77e6a1a3, Offset: 0x15e0
// Size: 0x30
function private isarrivingtwo(arrivalangle) {
    if (arrivalangle >= -91 && arrivalangle <= -61) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x11597442, Offset: 0x1618
// Size: 0x30
function private isarrivingthree(arrivalangle) {
    if (arrivalangle >= -61 && arrivalangle <= -16) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x2da9b06c, Offset: 0x1650
// Size: 0x30
function private isarrivingsix(arrivalangle) {
    if (arrivalangle >= -16 && arrivalangle <= 315) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xdfa41aea, Offset: 0x1688
// Size: 0x30
function private isfacingfour(facingangle) {
    if (facingangle >= 45 && facingangle <= -121) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x364207b9, Offset: 0x16c0
// Size: 0x30
function private isfacingeight(facingangle) {
    if (facingangle >= -45 && facingangle <= 45) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xd3a84200, Offset: 0x16f8
// Size: 0x2e
function private isfacingseven(facingangle) {
    if (facingangle >= 0 && facingangle <= 90) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x7e65c9cb, Offset: 0x1730
// Size: 0x30
function private isfacingsix(facingangle) {
    if (facingangle >= -135 && facingangle <= -45) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0x8fc3cfeb, Offset: 0x1768
// Size: 0x2e
function private isfacingnine(facingangle) {
    if (facingangle >= -90 && facingangle <= 0) {
        return true;
    }
    return false;
}

// Namespace archetype_human_locomotion
// Params 1, eflags: 0x4
// Checksum 0xc6224feb, Offset: 0x17a0
// Size: 0x400
function private shouldtacticalarrivecondition(behaviortreeentity) {
    if (getdvarint("enableTacticalArrival") != 1) {
        return false;
    }
    if (!isdefined(behaviortreeentity.node)) {
        return false;
    }
    if (!(behaviortreeentity.node.type == "Cover Left")) {
        return false;
    }
    stance = blackboard::getblackboardattribute(behaviortreeentity, "_arrival_stance");
    if (stance != "stand") {
        return false;
    }
    arrivaldistance = 35;
    /#
        arrivaldvar = getdvarint("<dev string:x28>");
        if (arrivaldvar != 0) {
            arrivaldistance = arrivaldvar;
        }
    #/
    nodeoffsetposition = behaviortreeentity getnodeoffsetposition(behaviortreeentity.node);
    if (distance(nodeoffsetposition, behaviortreeentity.origin) > arrivaldistance || distance(nodeoffsetposition, behaviortreeentity.origin) < 25) {
        return false;
    }
    entityangles = vectortoangles(behaviortreeentity.origin - nodeoffsetposition);
    if (abs(behaviortreeentity.node.angles[1] - entityangles[1]) < 60) {
        return false;
    }
    tacticalfaceangle = blackboard::getblackboardattribute(behaviortreeentity, "_tactical_arrival_facing_yaw");
    arrivalangle = blackboard::getblackboardattribute(behaviortreeentity, "_locomotion_arrival_yaw");
    if (isarrivingfour(arrivalangle)) {
        if (!isfacingsix(tacticalfaceangle) && !isfacingeight(tacticalfaceangle) && !isfacingfour(tacticalfaceangle)) {
            return false;
        }
    } else if (isarrivingone(arrivalangle)) {
        if (!isfacingnine(tacticalfaceangle) && !isfacingseven(tacticalfaceangle)) {
            return false;
        }
    } else if (isarrivingtwo(arrivalangle)) {
        if (!isfacingeight(tacticalfaceangle)) {
            return false;
        }
    } else if (isarrivingthree(arrivalangle)) {
        if (!isfacingseven(tacticalfaceangle) && !isfacingnine(tacticalfaceangle)) {
            return false;
        }
    } else if (isarrivingsix(arrivalangle)) {
        if (!isfacingfour(tacticalfaceangle) && !isfacingeight(tacticalfaceangle) && !isfacingsix(tacticalfaceangle)) {
            return false;
        }
    } else {
        return false;
    }
    return true;
}

// Namespace archetype_human_locomotion
// Params 0, eflags: 0x4
// Checksum 0xa6b2a3b8, Offset: 0x1ba8
// Size: 0x3c
function private humanshouldsprint() {
    currentlocomovementtype = blackboard::getblackboardattribute(self, "_human_locomotion_movement_type");
    return currentlocomovementtype == "human_locomotion_movement_sprint";
}

// Namespace archetype_human_locomotion
// Params 2, eflags: 0x4
// Checksum 0xb7b2b442, Offset: 0x1bf0
// Size: 0x57c
function private planhumanarrivalatcover(behaviortreeentity, arrivalanim) {
    if (behaviortreeentity ai::get_behavior_attribute("disablearrivals")) {
        return false;
    }
    blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
    if (!isdefined(arrivalanim)) {
        return false;
    }
    if (isdefined(behaviortreeentity.node) && isdefined(behaviortreeentity.pathgoalpos)) {
        if (!iscovernode(behaviortreeentity.node)) {
            return false;
        }
        nodeoffsetposition = behaviortreeentity getnodeoffsetposition(behaviortreeentity.node);
        if (nodeoffsetposition != behaviortreeentity.pathgoalpos) {
            return false;
        }
        if (isdefined(arrivalanim)) {
            isright = behaviortreeentity.node.type == "Cover Right";
            splittime = getarrivalsplittime(arrivalanim, isright);
            issplitarrival = splittime < 1;
            nodeapproachyaw = behaviortreeentity getnodeoffsetangles(behaviortreeentity.node)[1];
            angle = (0, nodeapproachyaw - getangledelta(arrivalanim), 0);
            if (issplitarrival) {
                forwarddir = anglestoforward(angle);
                rightdir = anglestoright(angle);
                animlength = getanimlength(arrivalanim);
                movedelta = getmovedelta(arrivalanim, 0, (animlength - 0.2) / animlength);
                premovedelta = getmovedelta(arrivalanim, 0, splittime);
                postmovedelta = movedelta - premovedelta;
                forward = vectorscale(forwarddir, postmovedelta[0]);
                right = vectorscale(rightdir, postmovedelta[1]);
                coverenterpos = nodeoffsetposition - forward + right;
                postenterpos = coverenterpos;
                forward = vectorscale(forwarddir, premovedelta[0]);
                right = vectorscale(rightdir, premovedelta[1]);
                coverenterpos = coverenterpos - forward + right;
                /#
                    recordline(postenterpos, nodeoffsetposition, (1, 0.5, 0), "<dev string:x3b>", behaviortreeentity);
                    recordline(coverenterpos, postenterpos, (1, 0.5, 0), "<dev string:x3b>", behaviortreeentity);
                #/
                if (!behaviortreeentity maymovefrompointtopoint(postenterpos, nodeoffsetposition, 1, 0)) {
                    return false;
                }
                if (!behaviortreeentity maymovefrompointtopoint(coverenterpos, postenterpos, 1, 0)) {
                    return false;
                }
            } else {
                forwarddir = anglestoforward(angle);
                rightdir = anglestoright(angle);
                movedeltaarray = getmovedelta(arrivalanim);
                forward = vectorscale(forwarddir, movedeltaarray[0]);
                right = vectorscale(rightdir, movedeltaarray[1]);
                coverenterpos = nodeoffsetposition - forward + right;
                if (!behaviortreeentity maymovefrompointtopoint(coverenterpos, nodeoffsetposition, 1, 1)) {
                    return false;
                }
            }
            if (!checkcoverarrivalconditions(coverenterpos, nodeoffsetposition)) {
                return false;
            }
            if (ispointonnavmesh(coverenterpos, behaviortreeentity)) {
                /#
                    recordcircle(coverenterpos, 2, (1, 0, 0), "<dev string:x46>", behaviortreeentity);
                #/
                behaviortreeentity useposition(coverenterpos, behaviortreeentity.pathgoalpos);
                return true;
            }
        }
    }
    return false;
}

// Namespace archetype_human_locomotion
// Params 2, eflags: 0x4
// Checksum 0x686df052, Offset: 0x2178
// Size: 0x2dc
function private checkcoverarrivalconditions(coverenterpos, coverpos) {
    distsqtonode = distancesquared(self.origin, coverpos);
    distsqfromnodetoenterpos = distancesquared(coverpos, coverenterpos);
    awayfromenterpos = distsqtonode >= distsqfromnodetoenterpos + -106;
    if (!awayfromenterpos) {
        return false;
    }
    trace = groundtrace(coverenterpos + (0, 0, 72), coverenterpos + (0, 0, -72), 0, 0, 0);
    if (isdefined(trace["position"]) && abs(trace["position"][2] - coverpos[2]) > 30) {
        /#
            if (getdvarint("<dev string:x4d>")) {
                recordcircle(coverenterpos, 1, (1, 0, 0), "<dev string:x3b>");
                record3dtext("<dev string:x5e>", coverenterpos, (1, 0, 0), "<dev string:x3b>", undefined, 0.4);
                recordcircle(trace["<dev string:x75>"], 1, (1, 0, 0), "<dev string:x3b>");
                record3dtext("<dev string:x7e>" + int(abs(trace["<dev string:x75>"][2] - coverpos[2])), trace["<dev string:x75>"] + (0, 0, 5), (1, 0, 0), "<dev string:x3b>", undefined, 0.4);
                record3dtext("<dev string:x93>" + 30, trace["<dev string:x75>"], (1, 0, 0), "<dev string:x3b>", undefined, 0.4);
                recordline(coverenterpos, trace["<dev string:x75>"], (1, 0, 0), "<dev string:x3b>");
            }
        #/
        return false;
    }
    return true;
}

// Namespace archetype_human_locomotion
// Params 2, eflags: 0x4
// Checksum 0xe2bf33c2, Offset: 0x2460
// Size: 0x2d6
function private getarrivalsplittime(arrivalanim, isright) {
    if (!isdefined(level.animarrivalsplittimes)) {
        level.animarrivalsplittimes = [];
    }
    if (isdefined(level.animarrivalsplittimes[arrivalanim])) {
        return level.animarrivalsplittimes[arrivalanim];
    }
    bestsplit = -1;
    if (animhasnotetrack(arrivalanim, "cover_split")) {
        times = getnotetracktimes(arrivalanim, "cover_split");
        assert(times.size > 0);
        bestsplit = times[0];
    } else {
        animlength = getanimlength(arrivalanim);
        var_be6be71a = (animlength - 0.2) / animlength;
        angledelta = getangledelta(arrivalanim, 0, var_be6be71a);
        var_a346de34 = getmovedelta(arrivalanim, 0, var_be6be71a);
        bestvalue = -100000000;
        for (i = 0; i < 100; i++) {
            splittime = 1 * i / (100 - 1);
            delta = getmovedelta(arrivalanim, 0, splittime);
            delta = deltarotate(var_a346de34 - delta, -76 - angledelta);
            if (isright) {
                delta = (delta[0], 0 - delta[1], delta[2]);
            }
            val = min(delta[0] - 32, delta[1]);
            if (val > bestvalue || bestsplit < 0) {
                bestvalue = val;
                bestsplit = splittime;
            }
        }
    }
    level.animarrivalsplittimes[arrivalanim] = bestsplit;
    return bestsplit;
}

// Namespace archetype_human_locomotion
// Params 2, eflags: 0x4
// Checksum 0x2d89b03d, Offset: 0x2740
// Size: 0x9c
function private deltarotate(delta, yaw) {
    cosine = cos(yaw);
    sine = sin(yaw);
    return (delta[0] * cosine - delta[1] * sine, delta[1] * cosine + delta[0] * sine, 0);
}

