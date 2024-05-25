#using scripts/shared/ai/archetype_aivsaimelee;
#using scripts/shared/util_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/behavior_state_machine;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai_shared;

#namespace aiutility;

// Namespace aiutility
// Params 0, eflags: 0x2
// Checksum 0x81c2cedf, Offset: 0x11f8
// Size: 0xbc4
function autoexec registerbehaviorscriptfunctions() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("forceRagdoll", &function_ba976497);
    behaviortreenetworkutility::registerbehaviortreescriptapi("hasAmmo", &hasammo);
    behaviortreenetworkutility::registerbehaviortreescriptapi("hasLowAmmo", &function_23529b81);
    behaviortreenetworkutility::registerbehaviortreescriptapi("hasEnemy", &function_90d01729);
    behaviortreenetworkutility::registerbehaviortreescriptapi("isSafeFromGrenades", &issafefromgrenades);
    behaviortreenetworkutility::registerbehaviortreescriptapi("inGrenadeBlastRadius", &ingrenadeblastradius);
    behaviortreenetworkutility::registerbehaviortreescriptapi("recentlySawEnemy", &recentlysawenemy);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldBeAggressive", &shouldbeaggressive);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldOnlyFireAccurately", &shouldonlyfireaccurately);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldReactToNewEnemy", &shouldreacttonewenemy);
    behaviorstatemachine::registerbsmscriptapiinternal("shouldReactToNewEnemy", &shouldreacttonewenemy);
    behaviortreenetworkutility::registerbehaviortreescriptapi("hasWeaponMalfunctioned", &hasweaponmalfunctioned);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldStopMoving", &shouldstopmoving);
    behaviorstatemachine::registerbsmscriptapiinternal("shouldStopMoving", &shouldstopmoving);
    behaviortreenetworkutility::registerbehaviortreescriptapi("chooseBestCoverNodeASAP", &choosebestcovernodeasap);
    behaviortreenetworkutility::registerbehaviortreescriptapi("chooseBetterCoverService", &choosebettercoverservicecodeversion);
    behaviortreenetworkutility::registerbehaviortreescriptapi("trackCoverParamsService", &trackcoverparamsservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("refillAmmoIfNeededService", &refillammo);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tryStoppingService", &trystoppingservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("isFrustrated", &isfrustrated);
    behaviortreenetworkutility::registerbehaviortreescriptapi("updatefrustrationLevel", &updatefrustrationlevel);
    behaviortreenetworkutility::registerbehaviortreescriptapi("isLastKnownEnemyPositionApproachable", &islastknownenemypositionapproachable);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tryAdvancingOnLastKnownPositionBehavior", &tryadvancingonlastknownpositionbehavior);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tryGoingToClosestNodeToEnemyBehavior", &trygoingtoclosestnodetoenemybehavior);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tryRunningDirectlyToEnemyBehavior", &tryrunningdirectlytoenemybehavior);
    behaviortreenetworkutility::registerbehaviortreescriptapi("flagEnemyUnAttackableService", &flagenemyunattackableservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("keepClaimNode", &keepclaimnode);
    behaviorstatemachine::registerbsmscriptapiinternal("keepClaimNode", &keepclaimnode);
    behaviortreenetworkutility::registerbehaviortreescriptapi("releaseClaimNode", &releaseclaimnode);
    behaviortreenetworkutility::registerbehaviortreescriptapi("startRagdoll", &scriptstartragdoll);
    behaviortreenetworkutility::registerbehaviortreescriptapi("notStandingCondition", &notstandingcondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("notCrouchingCondition", &notcrouchingcondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("explosiveKilled", &explosivekilled);
    behaviortreenetworkutility::registerbehaviortreescriptapi("electrifiedKilled", &electrifiedkilled);
    behaviortreenetworkutility::registerbehaviortreescriptapi("burnedKilled", &burnedkilled);
    behaviortreenetworkutility::registerbehaviortreescriptapi("rapsKilled", &rapskilled);
    behaviortreenetworkutility::registerbehaviortreescriptapi("meleeAcquireMutex", &meleeacquiremutex);
    behaviortreenetworkutility::registerbehaviortreescriptapi("meleeReleaseMutex", &meleereleasemutex);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldMutexMelee", &shouldmutexmelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("prepareForExposedMelee", &prepareforexposedmelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("cleanupMelee", &cleanupmelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldNormalMelee", &shouldnormalmelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldMelee", &shouldmelee);
    behaviorstatemachine::registerbsmscriptapiinternal("shouldMelee", &shouldmelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("hasCloseEnemyMelee", &hascloseenemytomelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("isBalconyDeath", &isbalconydeath);
    behaviortreenetworkutility::registerbehaviortreescriptapi("balconyDeath", &balconydeath);
    behaviortreenetworkutility::registerbehaviortreescriptapi("useCurrentPosition", &usecurrentposition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("isUnarmed", &isunarmed);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldChargeMelee", &shouldchargemelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldAttackInChargeMelee", &shouldattackinchargemelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("cleanupChargeMelee", &cleanupchargemelee);
    behaviortreenetworkutility::registerbehaviortreescriptapi("cleanupChargeMeleeAttack", &cleanupchargemeleeattack);
    behaviortreenetworkutility::registerbehaviortreescriptapi("setupChargeMeleeAttack", &setupchargemeleeattack);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldChooseSpecialPain", &shouldchoosespecialpain);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldChooseSpecialPronePain", &shouldchoosespecialpronepain);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldChooseSpecialDeath", &shouldchoosespecialdeath);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldChooseSpecialProneDeath", &shouldchoosespecialpronedeath);
    behaviortreenetworkutility::registerbehaviortreescriptapi("setupExplosionAnimScale", &setupexplosionanimscale);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldStealth", &shouldstealth);
    behaviortreenetworkutility::registerbehaviortreescriptapi("stealthReactCondition", &stealthreactcondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("locomotionShouldStealth", &locomotionshouldstealth);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldStealthResume", &shouldstealthresume);
    behaviorstatemachine::registerbsmscriptapiinternal("locomotionShouldStealth", &locomotionshouldstealth);
    behaviorstatemachine::registerbsmscriptapiinternal("stealthReactCondition", &stealthreactcondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("stealthReactStart", &stealthreactstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("stealthReactTerminate", &stealthreactterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("stealthIdleTerminate", &stealthidleterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("isInPhalanx", &isinphalanx);
    behaviortreenetworkutility::registerbehaviortreescriptapi("isInPhalanxStance", &isinphalanxstance);
    behaviortreenetworkutility::registerbehaviortreescriptapi("togglePhalanxStance", &togglephalanxstance);
    behaviortreenetworkutility::registerbehaviortreescriptapi("tookFlashbangDamage", &tookflashbangdamage);
    behaviortreenetworkutility::registerbehaviortreescriptapi("isAtAttackObject", &isatattackobject);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldAttackObject", &shouldattackobject);
    behaviortreenetworkutility::registerbehaviortreeaction("defaultAction", undefined, undefined, undefined);
    archetype_aivsaimelee::registeraivsaimeleebehaviorfunctions();
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0xf7a30878, Offset: 0x1dc8
// Size: 0x1474
function function_89e1fc16() {
    blackboard::registerblackboardattribute(self, "_arrival_stance", undefined, &bb_getarrivalstance);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_context", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_context2", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_cover_concealed", undefined, &bb_getcoverconcealed);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_cover_direction", "cover_front_direction", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_cover_mode", "cover_mode_none", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_cover_type", undefined, &bb_getcurrentcovernodetype);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_current_location_cover_type", undefined, &bb_getcurrentlocationcovernodetype);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_exposed_type", undefined, &bb_getcurrentexposedtype);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_damage_direction", undefined, &bb_getdamagedirection);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_damage_location", undefined, &bb_actorgetdamagelocation);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_damage_weapon_class", undefined, &bb_getdamageweaponclass);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_damage_weapon", undefined, &bb_getdamageweapon);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_damage_mod", undefined, &bb_getdamagemod);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_damage_taken", undefined, &bb_getdamagetaken);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_desired_stance", "stand", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_enemy", undefined, &bb_actorhasenemy);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_enemy_yaw", undefined, &bb_actorgetenemyyaw);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_react_yaw", undefined, &bb_actorgetreactyaw);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_fatal_damage_location", undefined, &bb_actorgetfataldamagelocation);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_fire_mode", undefined, &getfiremode);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_gib_location", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_juke_direction", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_juke_distance", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_locomotion_arrival_distance", undefined, &bb_getlocomotionarrivaldistance);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_locomotion_arrival_yaw", undefined, &bb_getlocomotionarrivalyaw);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_locomotion_exit_yaw", undefined, &bb_getlocomotionexityaw);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_locomotion_face_enemy_quadrant", "locomotion_face_enemy_none", &bb_getlocomotionfaceenemyquadrant);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_locomotion_motion_angle", undefined, &bb_getlocomotionmotionangle);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_locomotion_face_enemy_quadrant_previous", "locomotion_face_enemy_none", &bb_getlocomotionfaceenemyquadrantprevious);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_locomotion_pain_type", undefined, &bb_getlocomotionpaintype);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_locomotion_turn_yaw", undefined, &bb_getlocomotionturnyaw);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_lookahead_angle", undefined, &bb_getlookaheadangle);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_patrol", undefined, &bb_actorispatroling);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_perfect_enemy_yaw", undefined, &bb_actorgetperfectenemyyaw);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_previous_cover_direction", "cover_front_direction", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_previous_cover_mode", "cover_mode_none", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_previous_cover_type", undefined, &bb_getpreviouscovernodetype);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_stance", "stand", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_traversal_type", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_melee_distance", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_tracking_turn_yaw", undefined, &bb_actorgettrackingturnyaw);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_weapon_class", "rifle", &bb_getweaponclass);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_throw_distance", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_yaw_to_cover", undefined, &bb_getyawtocovernode);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_special_death", "none", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_awareness", "combat", &bb_getawareness);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_awareness_prev", "combat", &bb_getawarenessprevious);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_melee_enemy_type", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_staircase_num_steps", 0, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_staircase_num_total_steps", 0, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_staircase_state", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_staircase_direction", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_staircase_exit_type", undefined, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    blackboard::registerblackboardattribute(self, "_staircase_skip_num", undefined, &bb_getstairsnumskipsteps);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("shouldOnlyFireAccurately");
        #/
    }
    /#
        self finalizetrackedblackboardattributes();
    #/
}

// Namespace aiutility
// Params 0, eflags: 0x5 linked
// Checksum 0xd13a6d5a, Offset: 0x3248
// Size: 0x172
function private bb_getstairsnumskipsteps() {
    assert(isdefined(self._stairsstartnode) && isdefined(self._stairsendnode));
    numtotalsteps = blackboard::getblackboardattribute(self, "_staircase_num_total_steps");
    stepssofar = blackboard::getblackboardattribute(self, "_staircase_num_steps");
    direction = blackboard::getblackboardattribute(self, "_staircase_direction");
    numoutsteps = 2;
    totalstepswithoutout = numtotalsteps - numoutsteps;
    assert(stepssofar < totalstepswithoutout);
    remainingsteps = totalstepswithoutout - stepssofar;
    if (remainingsteps >= 8) {
        return "staircase_skip_8";
    } else if (remainingsteps >= 6) {
        return "staircase_skip_6";
    }
    assert(remainingsteps >= 3);
    return "staircase_skip_3";
}

// Namespace aiutility
// Params 0, eflags: 0x5 linked
// Checksum 0x78059b88, Offset: 0x33c8
// Size: 0x32
function private bb_getawareness() {
    if (!isdefined(self.stealth) || !isdefined(self.awarenesslevelcurrent)) {
        return "combat";
    }
    return self.awarenesslevelcurrent;
}

// Namespace aiutility
// Params 0, eflags: 0x5 linked
// Checksum 0xb7c38009, Offset: 0x3408
// Size: 0x32
function private bb_getawarenessprevious() {
    if (!isdefined(self.stealth) || !isdefined(self.awarenesslevelprevious)) {
        return "combat";
    }
    return self.awarenesslevelprevious;
}

// Namespace aiutility
// Params 0, eflags: 0x5 linked
// Checksum 0xa809b14a, Offset: 0x3448
// Size: 0x104
function private bb_getyawtocovernode() {
    if (!isdefined(self.node)) {
        return 0;
    }
    disttonodesqr = distance2dsquared(self getnodeoffsetposition(self.node), self.origin);
    if (isdefined(self.keepclaimednode) && self.keepclaimednode) {
        if (disttonodesqr > 64 * 64) {
            return 0;
        }
    } else if (disttonodesqr > 24 * 24) {
        return 0;
    }
    angletonode = ceil(angleclamp180(self.angles[1] - self getnodeoffsetangles(self.node)[1]));
    return angletonode;
}

// Namespace aiutility
// Params 0, eflags: 0x0
// Checksum 0xe9e0e492, Offset: 0x3558
// Size: 0x7c
function bb_gethigheststance() {
    if (self isatcovernodestrict() && self shouldusecovernode()) {
        higheststance = gethighestnodestance(self.node);
        return higheststance;
    }
    return blackboard::getblackboardattribute(self, "_stance");
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0xa133a32a, Offset: 0x35e0
// Size: 0x8e
function bb_getlocomotionfaceenemyquadrantprevious() {
    if (isdefined(self.prevrelativedir)) {
        direction = self.prevrelativedir;
        switch (direction) {
        case 0:
            return "locomotion_face_enemy_none";
        case 1:
            return "locomotion_face_enemy_front";
        case 2:
            return "locomotion_face_enemy_right";
        case 3:
            return "locomotion_face_enemy_left";
        case 4:
            return "locomotion_face_enemy_back";
        }
    }
    return "locomotion_face_enemy_none";
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0x3873aa34, Offset: 0x3678
// Size: 0x1a
function bb_getcurrentcovernodetype() {
    return getcovertype(self.node);
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0xcef8cf82, Offset: 0x36a0
// Size: 0x2e
function bb_getcoverconcealed() {
    if (iscoverconcealed(self.node)) {
        return "concealed";
    }
    return "unconcealed";
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0xa330e2b, Offset: 0x36d8
// Size: 0x6a
function bb_getcurrentlocationcovernodetype() {
    if (isdefined(self.node) && distancesquared(self.origin, self.node.origin) < 48 * 48) {
        return bb_getcurrentcovernodetype();
    }
    return bb_getpreviouscovernodetype();
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0x9bff02aa, Offset: 0x3750
// Size: 0xda
function bb_getdamagedirection() {
    /#
        if (isdefined(level._debug_damage_direction)) {
            return level._debug_damage_direction;
        }
    #/
    if (self.damageyaw > -121 || self.damageyaw <= -135) {
        self.damage_direction = "front";
        return "front";
    }
    if (self.damageyaw > 45 && self.damageyaw <= -121) {
        self.damage_direction = "right";
        return "right";
    }
    if (self.damageyaw > -45 && self.damageyaw <= 45) {
        self.damage_direction = "back";
        return "back";
    }
    self.damage_direction = "left";
    return "left";
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0x59120ec0, Offset: 0x3838
// Size: 0x3b0
function bb_actorgetdamagelocation() {
    /#
        if (isdefined(level._debug_damage_pain_location)) {
            return level._debug_damage_pain_location;
        }
    #/
    shitloc = self.damagelocation;
    possiblehitlocations = array();
    if (isinarray(array("helmet", "head", "neck"), shitloc)) {
        possiblehitlocations[possiblehitlocations.size] = "head";
    }
    if (isinarray(array("torso_upper", "torso_mid"), shitloc)) {
        possiblehitlocations[possiblehitlocations.size] = "chest";
    }
    if (isinarray(array("torso_lower"), shitloc)) {
        possiblehitlocations[possiblehitlocations.size] = "groin";
    }
    if (isinarray(array("torso_lower"), shitloc)) {
        possiblehitlocations[possiblehitlocations.size] = "legs";
    }
    if (isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc)) {
        possiblehitlocations[possiblehitlocations.size] = "left_arm";
    }
    if (isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc)) {
        possiblehitlocations[possiblehitlocations.size] = "right_arm";
    }
    if (isinarray(array("right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot"), shitloc)) {
        possiblehitlocations[possiblehitlocations.size] = "legs";
    }
    if (isdefined(self.lastdamagetime) && gettime() > self.lastdamagetime && gettime() <= self.lastdamagetime + 1000) {
        if (isdefined(self.var_75e74b2f)) {
            arrayremovevalue(possiblehitlocations, self.var_75e74b2f);
        }
    }
    if (possiblehitlocations.size == 0) {
        possiblehitlocations = undefined;
        possiblehitlocations = [];
        possiblehitlocations[0] = "chest";
        possiblehitlocations[1] = "groin";
    }
    assert(possiblehitlocations.size > 0, possiblehitlocations.size);
    damagelocation = possiblehitlocations[randomint(possiblehitlocations.size)];
    self.var_75e74b2f = damagelocation;
    return damagelocation;
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0x9b9e2ad9, Offset: 0x3bf0
// Size: 0x186
function bb_getdamageweaponclass() {
    if (isdefined(self.damagemod)) {
        if (isinarray(array("mod_rifle_bullet"), tolower(self.damagemod))) {
            return "rifle";
        }
        if (isinarray(array("mod_pistol_bullet"), tolower(self.damagemod))) {
            return "pistol";
        }
        if (isinarray(array("mod_melee", "mod_melee_assassinate", "mod_melee_weapon_butt"), tolower(self.damagemod))) {
            return "melee";
        }
        if (isinarray(array("mod_grenade", "mod_grenade_splash", "mod_projectile", "mod_projectile_splash", "mod_explosive"), tolower(self.damagemod))) {
            return "explosive";
        }
    }
    return "rifle";
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0xac418644, Offset: 0x3d80
// Size: 0x6a
function bb_getdamageweapon() {
    if (isdefined(self.special_weapon) && isdefined(self.special_weapon.name)) {
        return self.special_weapon.name;
    }
    if (isdefined(self.damageweapon) && isdefined(self.damageweapon.name)) {
        return self.damageweapon.name;
    }
    return "unknown";
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0x651ace7b, Offset: 0x3df8
// Size: 0x32
function bb_getdamagemod() {
    if (isdefined(self.damagemod)) {
        return tolower(self.damagemod);
    }
    return "unknown";
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0x639efca2, Offset: 0x3e38
// Size: 0xec
function bb_getdamagetaken() {
    /#
        if (isdefined(level._debug_damage_intensity)) {
            return level._debug_damage_intensity;
        }
    #/
    damagetaken = self.damagetaken;
    maxhealth = self.maxhealth;
    damagetakentype = "light";
    if (isalive(self)) {
        ratio = damagetaken / self.maxhealth;
        if (ratio > 0.7) {
            damagetakentype = "heavy";
        }
        self.lastdamagetime = gettime();
    } else {
        ratio = damagetaken / self.maxhealth;
        if (ratio > 0.7) {
            damagetakentype = "heavy";
        }
    }
    return damagetakentype;
}

// Namespace aiutility
// Params 3, eflags: 0x1 linked
// Checksum 0x3c02b16f, Offset: 0x3f30
// Size: 0x2a6
function addaioverridedamagecallback(entity, callback, addtofront) {
    assert(isentity(entity));
    assert(isfunctionptr(callback));
    assert(!isdefined(entity.aioverridedamage) || isarray(entity.aioverridedamage));
    if (!isdefined(entity.aioverridedamage)) {
        entity.aioverridedamage = [];
    } else if (!isarray(entity.aioverridedamage)) {
        entity.aioverridedamage = array(entity.aioverridedamage);
    }
    if (isdefined(addtofront) && addtofront) {
        damageoverrides = [];
        damageoverrides[damageoverrides.size] = callback;
        foreach (override in entity.aioverridedamage) {
            damageoverrides[damageoverrides.size] = override;
        }
        entity.aioverridedamage = damageoverrides;
        return;
    }
    if (!isdefined(entity.aioverridedamage)) {
        entity.aioverridedamage = [];
    } else if (!isarray(entity.aioverridedamage)) {
        entity.aioverridedamage = array(entity.aioverridedamage);
    }
    entity.aioverridedamage[entity.aioverridedamage.size] = callback;
}

// Namespace aiutility
// Params 2, eflags: 0x1 linked
// Checksum 0x6242b1b, Offset: 0x41e0
// Size: 0x178
function removeaioverridedamagecallback(entity, callback) {
    assert(isentity(entity));
    assert(isfunctionptr(callback));
    assert(isarray(entity.aioverridedamage));
    currentdamagecallbacks = entity.aioverridedamage;
    entity.aioverridedamage = [];
    foreach (value in currentdamagecallbacks) {
        if (value != callback) {
            entity.aioverridedamage[entity.aioverridedamage.size] = value;
        }
    }
}

// Namespace aiutility
// Params 1, eflags: 0x0
// Checksum 0xebe463bb, Offset: 0x4360
// Size: 0x1c
function clearaioverridedamagecallbacks(entity) {
    entity.aioverridedamage = [];
}

// Namespace aiutility
// Params 2, eflags: 0x1 linked
// Checksum 0x91ee66fe, Offset: 0x4388
// Size: 0x156
function addaioverridekilledcallback(entity, callback) {
    assert(isentity(entity));
    assert(isfunctionptr(callback));
    assert(!isdefined(entity.aioverridekilled) || isarray(entity.aioverridekilled));
    if (!isdefined(entity.aioverridekilled)) {
        entity.aioverridekilled = [];
    } else if (!isarray(entity.aioverridekilled)) {
        entity.aioverridekilled = array(entity.aioverridekilled);
    }
    entity.aioverridekilled[entity.aioverridekilled.size] = callback;
}

// Namespace aiutility
// Params 2, eflags: 0x1 linked
// Checksum 0xcfb8cfac, Offset: 0x44e8
// Size: 0x1a0
function actorgetpredictedyawtoenemy(entity, lookaheadtime) {
    if (isdefined(entity.predictedyawtoenemy) && isdefined(entity.predictedyawtoenemytime) && entity.predictedyawtoenemytime == gettime()) {
        return entity.predictedyawtoenemy;
    }
    selfpredictedpos = entity.origin;
    moveangle = entity.angles[1] + entity getmotionangle();
    selfpredictedpos += (cos(moveangle), sin(moveangle), 0) * 200 * lookaheadtime;
    yaw = vectortoangles(entity lastknownpos(entity.enemy) - selfpredictedpos)[1] - entity.angles[1];
    yaw = absangleclamp360(yaw);
    entity.predictedyawtoenemy = yaw;
    entity.predictedyawtoenemytime = gettime();
    return yaw;
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0x6b31ee94, Offset: 0x4690
// Size: 0x66
function bb_actorispatroling() {
    entity = self;
    if (entity ai::has_behavior_attribute("patrol") && entity ai::get_behavior_attribute("patrol")) {
        return "patrol_enabled";
    }
    return "patrol_disabled";
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0xdd5dc8d1, Offset: 0x4700
// Size: 0x36
function bb_actorhasenemy() {
    entity = self;
    if (isdefined(entity.enemy)) {
        return "has_enemy";
    }
    return "no_enemy";
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0x60f0abe7, Offset: 0x4740
// Size: 0x54
function bb_actorgetenemyyaw() {
    enemy = self.enemy;
    if (!isdefined(enemy)) {
        return 0;
    }
    toenemyyaw = actorgetpredictedyawtoenemy(self, 0.2);
    return toenemyyaw;
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0x7bf7e136, Offset: 0x47a0
// Size: 0xc0
function bb_actorgetperfectenemyyaw() {
    enemy = self.enemy;
    if (!isdefined(enemy)) {
        return 0;
    }
    toenemyyaw = vectortoangles(enemy.origin - self.origin)[1] - self.angles[1];
    toenemyyaw = absangleclamp360(toenemyyaw);
    /#
        recordenttext("shouldOnlyFireAccurately" + toenemyyaw, self, (1, 0, 0), "shouldOnlyFireAccurately");
    #/
    return toenemyyaw;
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0x5d1480d, Offset: 0x4868
// Size: 0x13c
function bb_actorgetreactyaw() {
    result = 0;
    if (isdefined(self.var_5ded47f6)) {
        result = self.var_5ded47f6;
        self.var_5ded47f6 = undefined;
    } else {
        v_origin = self geteventpointofinterest();
        if (isdefined(v_origin)) {
            str_typename = self getcurrenteventtypename();
            e_originator = self getcurrenteventoriginator();
            if (str_typename == "bullet" && isdefined(e_originator)) {
                v_origin = e_originator.origin;
            }
            deltaorigin = v_origin - self.origin;
            var_9d3fe635 = vectortoangles(deltaorigin);
            result = absangleclamp360(self.angles[1] - var_9d3fe635[1]);
        }
    }
    return result;
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0x2d79fa1b, Offset: 0x49b0
// Size: 0x248
function bb_actorgetfataldamagelocation() {
    /#
        if (isdefined(level._debug_damage_location)) {
            return level._debug_damage_location;
        }
    #/
    shitloc = self.damagelocation;
    if (isdefined(shitloc)) {
        if (isinarray(array("helmet", "head", "neck"), shitloc)) {
            return "head";
        }
        if (isinarray(array("torso_upper", "torso_mid"), shitloc)) {
            return "chest";
        }
        if (isinarray(array("torso_lower"), shitloc)) {
            return "hips";
        }
        if (isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc)) {
            return "right_arm";
        }
        if (isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc)) {
            return "left_arm";
        }
        if (isinarray(array("right_leg_upper", "left_leg_upper", "right_leg_lower", "left_leg_lower", "right_foot", "left_foot"), shitloc)) {
            return "legs";
        }
    }
    randomlocs = array("chest", "hips");
    return randomlocs[randomint(randomlocs.size)];
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xf3fc01fd, Offset: 0x4c00
// Size: 0xca
function getangleusingdirection(direction) {
    directionyaw = vectortoangles(direction)[1];
    yawdiff = directionyaw - self.angles[1];
    yawdiff *= 0.00277778;
    flooredyawdiff = floor(yawdiff + 0.5);
    turnangle = (yawdiff - flooredyawdiff) * 360;
    return absangleclamp360(turnangle);
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0xef2633e8, Offset: 0x4cd8
// Size: 0xf8
function wasatcovernode() {
    if (isdefined(self.prevnode)) {
        if (self.prevnode.type == "Cover Crouch" || self.prevnode.type == "Cover Crouch Window" || self.prevnode.type == "Cover Stand" || self.prevnode.type == "Cover Left" || self.prevnode.type == "Cover Right" || self.prevnode.type == "Cover Pillar" || self.prevnode.type == "Conceal Stand" || self.prevnode.type == "Conceal Crouch") {
            return true;
        }
    }
    return false;
}

// Namespace aiutility
// Params 2, eflags: 0x1 linked
// Checksum 0x76af89d3, Offset: 0x4dd8
// Size: 0x4d8
function bb_getlocomotionexityaw(blackboard, yaw) {
    exityaw = undefined;
    if (self haspath()) {
        predictedlookaheadinfo = self predictexit();
        status = predictedlookaheadinfo["path_prediction_status"];
        if (!isdefined(self.pathgoalpos)) {
            return -1;
        }
        if (distancesquared(self.origin, self.pathgoalpos) <= 4096) {
            return -1;
        }
        if (status == 3) {
            start = self.origin;
            end = start + vectorscale((0, predictedlookaheadinfo["path_prediction_travel_vector"][1], 0), 100);
            angletoexit = vectortoangles(predictedlookaheadinfo["path_prediction_travel_vector"])[1];
            exityaw = absangleclamp360(angletoexit - self.prevnode.angles[1]);
        } else if (status == 4) {
            start = self.origin;
            end = start + vectorscale((0, predictedlookaheadinfo["path_prediction_travel_vector"][1], 0), 100);
            angletoexit = vectortoangles(predictedlookaheadinfo["path_prediction_travel_vector"])[1];
            exityaw = absangleclamp360(angletoexit - self.angles[1]);
        } else if (status == 0) {
            if (wasatcovernode() && distancesquared(self.prevnode.origin, self.origin) < 25) {
                end = self.pathgoalpos;
                angletodestination = vectortoangles(end - self.origin)[1];
                angledifference = absangleclamp360(angletodestination - self.prevnode.angles[1]);
                return angledifference;
            }
            start = predictedlookaheadinfo["path_prediction_start_point"];
            end = start + predictedlookaheadinfo["path_prediction_travel_vector"];
            exityaw = getangleusingdirection(predictedlookaheadinfo["path_prediction_travel_vector"]);
        } else if (status == 2) {
            if (distancesquared(self.origin, self.pathgoalpos) <= 4096) {
                return undefined;
            }
            if (wasatcovernode() && distancesquared(self.prevnode.origin, self.origin) < 25) {
                end = self.pathgoalpos;
                angletodestination = vectortoangles(end - self.origin)[1];
                angledifference = absangleclamp360(angletodestination - self.prevnode.angles[1]);
                return angledifference;
            }
            start = self.origin;
            end = self.pathgoalpos;
            exityaw = getangleusingdirection(vectornormalize(end - start));
        }
    }
    /#
        if (isdefined(exityaw)) {
            record3dtext("shouldOnlyFireAccurately" + int(exityaw), self.origin - (0, 0, 5), (1, 0, 0), "shouldOnlyFireAccurately", undefined, 0.4);
        }
    #/
    return exityaw;
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0x2ad31c48, Offset: 0x52b8
// Size: 0xfe
function bb_getlocomotionfaceenemyquadrant() {
    /#
        walkstring = getdvarstring("shouldOnlyFireAccurately");
        switch (walkstring) {
        case 8:
            return "shouldOnlyFireAccurately";
        case 8:
            return "shouldOnlyFireAccurately";
        case 8:
            return "shouldOnlyFireAccurately";
        }
    #/
    if (isdefined(self.relativedir)) {
        direction = self.relativedir;
        switch (direction) {
        case 0:
            return "locomotion_face_enemy_front";
        case 1:
            return "locomotion_face_enemy_front";
        case 2:
            return "locomotion_face_enemy_right";
        case 3:
            return "locomotion_face_enemy_left";
        case 4:
            return "locomotion_face_enemy_back";
        }
    }
    return "locomotion_face_enemy_front";
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0xad389b7d, Offset: 0x53c0
// Size: 0x292
function bb_getlocomotionpaintype() {
    if (self haspath()) {
        predictedlookaheadinfo = self predictpath();
        status = predictedlookaheadinfo["path_prediction_status"];
        startpos = self.origin;
        furthestpointtowardsgoalclear = 1;
        if (status == 2) {
            furthestpointalongtowardsgoal = startpos + vectorscale(self.lookaheaddir, 300);
            furthestpointtowardsgoalclear = self findpath(startpos, furthestpointalongtowardsgoal, 0, 0) && self maymovetopoint(furthestpointalongtowardsgoal);
        }
        if (furthestpointtowardsgoalclear) {
            forwarddir = anglestoforward(self.angles);
            possiblepaintypes = [];
            endpos = startpos + vectorscale(forwarddir, 300);
            if (self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0)) {
                possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_long";
            }
            endpos = startpos + vectorscale(forwarddir, -56);
            if (self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0)) {
                possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_med";
            }
            endpos = startpos + vectorscale(forwarddir, -106);
            if (self maymovetopoint(endpos) && self findpath(startpos, endpos, 0, 0)) {
                possiblepaintypes[possiblepaintypes.size] = "locomotion_moving_pain_short";
            }
            if (possiblepaintypes.size) {
                return array::random(possiblepaintypes);
            }
        }
    }
    return "locomotion_inplace_pain";
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0x6a3dea29, Offset: 0x5660
// Size: 0x42
function bb_getlookaheadangle() {
    return absangleclamp360(vectortoangles(self.lookaheaddir)[1] - self.angles[1]);
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0x82698b53, Offset: 0x56b0
// Size: 0x1a
function bb_getpreviouscovernodetype() {
    return getcovertype(self.prevnode);
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0x8407abe8, Offset: 0x56d8
// Size: 0x186
function bb_actorgettrackingturnyaw() {
    pixbeginevent("BB_ActorGetTrackingTurnYaw");
    if (isdefined(self.enemy)) {
        predictedpos = undefined;
        if (distance2dsquared(self.enemy.origin, self.origin) < -76 * -76) {
            predictedpos = self.enemy.origin;
            self.newenemyreaction = 0;
        } else if (!issentient(self.enemy) || self lastknowntime(self.enemy) + 5000 >= gettime()) {
            predictedpos = self lastknownpos(self.enemy);
        }
        if (isdefined(predictedpos)) {
            turnyaw = absangleclamp360(self.angles[1] - vectortoangles(predictedpos - self.origin)[1]);
            pixendevent();
            return turnyaw;
        }
    }
    pixendevent();
    return undefined;
}

// Namespace aiutility
// Params 0, eflags: 0x1 linked
// Checksum 0x64665720, Offset: 0x5868
// Size: 0xa
function bb_getweaponclass() {
    return "rifle";
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xaea3e2b8, Offset: 0x5880
// Size: 0x40
function notstandingcondition(behaviortreeentity) {
    if (blackboard::getblackboardattribute(behaviortreeentity, "_stance") != "stand") {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x4a7e164, Offset: 0x58c8
// Size: 0x40
function notcrouchingcondition(behaviortreeentity) {
    if (blackboard::getblackboardattribute(behaviortreeentity, "_stance") != "crouch") {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xc476784, Offset: 0x5910
// Size: 0x24
function scriptstartragdoll(behaviortreeentity) {
    behaviortreeentity startragdoll();
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x74f6c3f2, Offset: 0x5940
// Size: 0x124
function private prepareforexposedmelee(behaviortreeentity) {
    keepclaimnode(behaviortreeentity);
    meleeacquiremutex(behaviortreeentity);
    currentstance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
    if (isdefined(behaviortreeentity.enemy) && isdefined(behaviortreeentity.enemy.vehicletype) && issubstr(behaviortreeentity.enemy.vehicletype, "firefly")) {
        blackboard::setblackboardattribute(behaviortreeentity, "_melee_enemy_type", "fireflyswarm");
    }
    if (currentstance == "crouch") {
        blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
    }
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x34e788, Offset: 0x5a70
// Size: 0x32
function isfrustrated(behaviortreeentity) {
    return isdefined(behaviortreeentity.frustrationlevel) && behaviortreeentity.frustrationlevel > 0;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xc5eeee0b, Offset: 0x5ab0
// Size: 0x38
function clampfrustration(frustrationlevel) {
    if (frustrationlevel > 4) {
        return 4;
    } else if (frustrationlevel < 0) {
        return 0;
    }
    return frustrationlevel;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x12c279a4, Offset: 0x5af0
// Size: 0x3c8
function updatefrustrationlevel(entity) {
    if (!entity isbadguy()) {
        return false;
    }
    if (!isdefined(entity.frustrationlevel)) {
        entity.frustrationlevel = 0;
    }
    if (!isdefined(entity.enemy)) {
        entity.frustrationlevel = 0;
        return false;
    }
    /#
        record3dtext("shouldOnlyFireAccurately" + entity.frustrationlevel, entity.origin, (1, 0.5, 0), "shouldOnlyFireAccurately");
    #/
    if (isactor(entity.enemy) || isplayer(entity.enemy)) {
        if (entity.aggressivemode) {
            if (!isdefined(entity.lastfrustrationboost)) {
                entity.lastfrustrationboost = gettime();
            }
            if (entity.lastfrustrationboost + 5000 < gettime()) {
                entity.frustrationlevel++;
                entity.lastfrustrationboost = gettime();
                entity.frustrationlevel = clampfrustration(entity.frustrationlevel);
            }
        }
        isawareofenemy = gettime() - entity lastknowntime(entity.enemy) < 10000;
        if (entity.frustrationlevel == 4) {
            hasseenenemy = entity seerecently(entity.enemy, 2);
        } else {
            hasseenenemy = entity seerecently(entity.enemy, 5);
        }
        hasattackedenemyrecently = entity attackedrecently(entity.enemy, 5);
        if (!isawareofenemy || isactor(entity.enemy)) {
            if (!hasseenenemy) {
                entity.frustrationlevel++;
            } else if (!hasattackedenemyrecently) {
                entity.frustrationlevel += 2;
            }
            entity.frustrationlevel = clampfrustration(entity.frustrationlevel);
            return true;
        }
        if (hasattackedenemyrecently) {
            entity.frustrationlevel -= 2;
            entity.frustrationlevel = clampfrustration(entity.frustrationlevel);
            return true;
        } else if (hasseenenemy) {
            entity.frustrationlevel--;
            entity.frustrationlevel = clampfrustration(entity.frustrationlevel);
            return true;
        }
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x4763758c, Offset: 0x5ec0
// Size: 0x24
function flagenemyunattackableservice(behaviortreeentity) {
    behaviortreeentity flagenemyunattackable();
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x173546c, Offset: 0x5ef0
// Size: 0xa6
function islastknownenemypositionapproachable(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy)) {
        lastknownpositionofenemy = behaviortreeentity lastknownpos(behaviortreeentity.enemy);
        if (behaviortreeentity isingoal(lastknownpositionofenemy) && behaviortreeentity findpath(behaviortreeentity.origin, lastknownpositionofenemy, 1, 0)) {
            return true;
        }
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x7ca6e48f, Offset: 0x5fa0
// Size: 0x104
function tryadvancingonlastknownpositionbehavior(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy)) {
        if (isdefined(behaviortreeentity.aggressivemode) && behaviortreeentity.aggressivemode) {
            lastknownpositionofenemy = behaviortreeentity lastknownpos(behaviortreeentity.enemy);
            if (behaviortreeentity isingoal(lastknownpositionofenemy) && behaviortreeentity findpath(behaviortreeentity.origin, lastknownpositionofenemy, 1, 0)) {
                behaviortreeentity useposition(lastknownpositionofenemy, lastknownpositionofenemy);
                setnextfindbestcovertime(behaviortreeentity, undefined);
                return true;
            }
        }
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x85bc35a6, Offset: 0x60b0
// Size: 0xf4
function trygoingtoclosestnodetoenemybehavior(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy)) {
        closestrandomnode = behaviortreeentity findbestcovernodes(behaviortreeentity.engagemaxdist, behaviortreeentity.enemy.origin)[0];
        if (isdefined(closestrandomnode) && behaviortreeentity isingoal(closestrandomnode.origin) && behaviortreeentity findpath(behaviortreeentity.origin, closestrandomnode.origin, 1, 0)) {
            usecovernodewrapper(behaviortreeentity, closestrandomnode);
            return true;
        }
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xa78b0691, Offset: 0x61b0
// Size: 0xf4
function tryrunningdirectlytoenemybehavior(behaviortreeentity) {
    if (isdefined(behaviortreeentity.aggressivemode) && isdefined(behaviortreeentity.enemy) && behaviortreeentity.aggressivemode) {
        origin = behaviortreeentity.enemy.origin;
        if (behaviortreeentity isingoal(origin) && behaviortreeentity findpath(behaviortreeentity.origin, origin, 1, 0)) {
            behaviortreeentity useposition(origin, origin);
            setnextfindbestcovertime(behaviortreeentity, undefined);
            return true;
        }
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x9691d3c2, Offset: 0x62b0
// Size: 0x16
function shouldreacttonewenemy(behaviortreeentity) {
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xd77d1244, Offset: 0x6360
// Size: 0x2e
function hasweaponmalfunctioned(behaviortreeentity) {
    return isdefined(behaviortreeentity.malfunctionreaction) && behaviortreeentity.malfunctionreaction;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xfa60ebb0, Offset: 0x6398
// Size: 0x1a4
function issafefromgrenades(entity) {
    if (isdefined(entity.grenade) && isdefined(entity.grenade.weapon) && entity.grenade !== entity.knowngrenade && !entity issafefromgrenade()) {
        if (isdefined(entity.node)) {
            offsetorigin = entity getnodeoffsetposition(entity.node);
            percentradius = distance(entity.grenade.origin, offsetorigin);
            if (entity.grenadeawareness >= percentradius) {
                return true;
            }
        } else {
            percentradius = distance(entity.grenade.origin, entity.origin) / entity.grenade.weapon.explosionradius;
            if (entity.grenadeawareness >= percentradius) {
                return true;
            }
        }
        entity.knowngrenade = entity.grenade;
        return false;
    }
    return true;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x80cd33d0, Offset: 0x6548
// Size: 0x24
function ingrenadeblastradius(entity) {
    return !entity issafefromgrenade();
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x57588595, Offset: 0x6578
// Size: 0x56
function recentlysawenemy(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy) && behaviortreeentity seerecently(behaviortreeentity.enemy, 6)) {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x212c6e87, Offset: 0x65d8
// Size: 0x3a
function shouldonlyfireaccurately(behaviortreeentity) {
    if (isdefined(behaviortreeentity.accuratefire) && behaviortreeentity.accuratefire) {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xdcf501bb, Offset: 0x6620
// Size: 0x3a
function shouldbeaggressive(behaviortreeentity) {
    if (isdefined(behaviortreeentity.aggressivemode) && behaviortreeentity.aggressivemode) {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 2, eflags: 0x1 linked
// Checksum 0x4f334d66, Offset: 0x6668
// Size: 0xc4
function usecovernodewrapper(behaviortreeentity, node) {
    samenode = behaviortreeentity.node === node;
    behaviortreeentity usecovernode(node);
    if (!samenode) {
        blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_mode_none");
        blackboard::setblackboardattribute(behaviortreeentity, "_previous_cover_mode", "cover_mode_none");
    }
    setnextfindbestcovertime(behaviortreeentity, node);
}

// Namespace aiutility
// Params 2, eflags: 0x1 linked
// Checksum 0xee85b986, Offset: 0x6738
// Size: 0x58
function setnextfindbestcovertime(behaviortreeentity, node) {
    behaviortreeentity.nextfindbestcovertime = behaviortreeentity getnextfindbestcovertime(behaviortreeentity.engagemindist, behaviortreeentity.engagemaxdist, behaviortreeentity.coversearchinterval);
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xdabe682a, Offset: 0x6798
// Size: 0xaa
function trackcoverparamsservice(behaviortreeentity) {
    if (isdefined(behaviortreeentity.node) && behaviortreeentity isatcovernodestrict() && behaviortreeentity shouldusecovernode()) {
        if (!isdefined(behaviortreeentity.covernode)) {
            behaviortreeentity.covernode = behaviortreeentity.node;
            setnextfindbestcovertime(behaviortreeentity, behaviortreeentity.node);
        }
        return;
    }
    behaviortreeentity.covernode = undefined;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xd207e5bb, Offset: 0x6850
// Size: 0x6c
function choosebestcovernodeasap(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.enemy)) {
        return 0;
    }
    node = getbestcovernodeifavailable(behaviortreeentity);
    if (isdefined(node)) {
        usecovernodewrapper(behaviortreeentity, node);
    }
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x84e4a07f, Offset: 0x68c8
// Size: 0x45a
function shouldchoosebettercover(behaviortreeentity) {
    if (behaviortreeentity ai::has_behavior_attribute("stealth") && behaviortreeentity ai::get_behavior_attribute("stealth")) {
        return 0;
    }
    if (isdefined(behaviortreeentity.avoid_cover) && behaviortreeentity.avoid_cover) {
        return 0;
    }
    if (behaviortreeentity isinanybadplace()) {
        return 1;
    }
    if (isdefined(behaviortreeentity.enemy)) {
        shouldusecovernoderesult = 0;
        shouldbeboredatcurrentcover = 0;
        abouttoarriveatcover = 0;
        iswithineffectiverangealready = 0;
        islookingaroundforenemy = 0;
        if (behaviortreeentity shouldholdgroundagainstenemy()) {
            return 0;
        }
        if (behaviortreeentity haspath() && isdefined(behaviortreeentity.arrivalfinalpos) && isdefined(behaviortreeentity.pathgoalpos) && self.pathgoalpos == behaviortreeentity.arrivalfinalpos) {
            if (distancesquared(behaviortreeentity.origin, behaviortreeentity.arrivalfinalpos) < 4096) {
                abouttoarriveatcover = 1;
            }
        }
        shouldusecovernoderesult = behaviortreeentity shouldusecovernode();
        if (self isatgoal()) {
            if (shouldusecovernoderesult && isdefined(behaviortreeentity.node) && self isatgoal()) {
                lastknownpos = behaviortreeentity lastknownpos(behaviortreeentity.enemy);
                dist = distance2d(behaviortreeentity.origin, lastknownpos);
                if (dist > behaviortreeentity.engageminfalloffdist && dist <= behaviortreeentity.engagemaxfalloffdist) {
                    iswithineffectiverangealready = 1;
                }
            }
            shouldbeboredatcurrentcover = !iswithineffectiverangealready && behaviortreeentity isatcovernode() && gettime() > self.nextfindbestcovertime;
            if (!shouldusecovernoderesult) {
                if (isdefined(behaviortreeentity.frustrationlevel) && behaviortreeentity.frustrationlevel > 0 && behaviortreeentity haspath()) {
                    islookingaroundforenemy = 1;
                }
            }
        }
        shouldlookforbettercover = !shouldusecovernoderesult || shouldbeboredatcurrentcover || !islookingaroundforenemy && !abouttoarriveatcover && !iswithineffectiverangealready && !self isatgoal();
        /#
            if (shouldlookforbettercover) {
                color = (0, 1, 0);
            } else {
                color = (1, 0, 0);
            }
            recordenttext("shouldOnlyFireAccurately" + shouldusecovernoderesult + "shouldOnlyFireAccurately" + islookingaroundforenemy + "shouldOnlyFireAccurately" + abouttoarriveatcover + "shouldOnlyFireAccurately" + iswithineffectiverangealready + "shouldOnlyFireAccurately" + shouldbeboredatcurrentcover, behaviortreeentity, color, "shouldOnlyFireAccurately");
        #/
    } else {
        return !(behaviortreeentity shouldusecovernode() && behaviortreeentity isapproachinggoal());
    }
    return shouldlookforbettercover;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x962eba02, Offset: 0x6d30
// Size: 0x10e
function choosebettercoverservicecodeversion(behaviortreeentity) {
    if (isdefined(behaviortreeentity.stealth) && behaviortreeentity ai::get_behavior_attribute("stealth")) {
        return false;
    }
    if (isdefined(behaviortreeentity.avoid_cover) && behaviortreeentity.avoid_cover) {
        return false;
    }
    if (isdefined(behaviortreeentity.knowngrenade)) {
        return false;
    }
    if (!issafefromgrenades(behaviortreeentity)) {
        behaviortreeentity.nextfindbestcovertime = 0;
    }
    newnode = behaviortreeentity choosebettercovernode();
    if (isdefined(newnode)) {
        usecovernodewrapper(behaviortreeentity, newnode);
        return true;
    }
    setnextfindbestcovertime(behaviortreeentity, undefined);
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x4
// Checksum 0xdf22936e, Offset: 0x6e48
// Size: 0x1a6
function private choosebettercoverservice(behaviortreeentity) {
    shouldchoosebettercoverresult = shouldchoosebettercover(behaviortreeentity);
    if (shouldchoosebettercoverresult && !behaviortreeentity.keepclaimednode) {
        transitionrunning = behaviortreeentity asmistransitionrunning();
        substatepending = behaviortreeentity asmissubstatepending();
        transdecrunning = behaviortreeentity asmistransdecrunning();
        isbehaviortreeinrunningstate = behaviortreeentity getbehaviortreestatus() == 5;
        if (!transitionrunning && !substatepending && !transdecrunning && isbehaviortreeinrunningstate) {
            node = getbestcovernodeifavailable(behaviortreeentity);
            goingtodifferentnode = !isdefined(behaviortreeentity.node) || isdefined(node) && node != behaviortreeentity.node;
            if (goingtodifferentnode) {
                usecovernodewrapper(behaviortreeentity, node);
                return true;
            }
            setnextfindbestcovertime(behaviortreeentity, undefined);
        }
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xf244ab0e, Offset: 0x6ff8
// Size: 0x4c
function refillammo(behaviortreeentity) {
    if (behaviortreeentity.weapon != level.weaponnone) {
        behaviortreeentity.bulletsinclip = behaviortreeentity.weapon.clipsize;
    }
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xd093cac0, Offset: 0x7050
// Size: 0x30
function hasammo(behaviortreeentity) {
    if (behaviortreeentity.bulletsinclip > 0) {
        return 1;
    }
    return 0;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xb9bc8ddd, Offset: 0x7088
// Size: 0x5a
function function_23529b81(behaviortreeentity) {
    if (behaviortreeentity.weapon != level.weaponnone) {
        return (behaviortreeentity.bulletsinclip < behaviortreeentity.weapon.clipsize * 0.2);
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x174d6034, Offset: 0x70f0
// Size: 0x28
function function_90d01729(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy)) {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x979847b9, Offset: 0x7120
// Size: 0xbc
function getbestcovernodeifavailable(behaviortreeentity) {
    node = behaviortreeentity findbestcovernode();
    if (!isdefined(node)) {
        return undefined;
    }
    if (behaviortreeentity nearclaimnode()) {
        currentnode = self.node;
    }
    if (isdefined(currentnode) && node == currentnode) {
        return undefined;
    }
    if (isdefined(behaviortreeentity.covernode) && node == behaviortreeentity.covernode) {
        return undefined;
    }
    return node;
}

// Namespace aiutility
// Params 1, eflags: 0x0
// Checksum 0x7c5c7eef, Offset: 0x71e8
// Size: 0x124
function getsecondbestcovernodeifavailable(behaviortreeentity) {
    if (isdefined(behaviortreeentity.fixednode) && behaviortreeentity.fixednode) {
        return undefined;
    }
    nodes = behaviortreeentity findbestcovernodes(behaviortreeentity.goalradius, behaviortreeentity.origin);
    if (nodes.size > 1) {
        node = nodes[1];
    }
    if (!isdefined(node)) {
        return undefined;
    }
    if (behaviortreeentity nearclaimnode()) {
        currentnode = self.node;
    }
    if (isdefined(currentnode) && node == currentnode) {
        return undefined;
    }
    if (isdefined(behaviortreeentity.covernode) && node == behaviortreeentity.covernode) {
        return undefined;
    }
    return node;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xbd32b4c8, Offset: 0x7318
// Size: 0x176
function getcovertype(node) {
    if (isdefined(node)) {
        if (node.type == "Cover Pillar") {
            return "cover_pillar";
        } else if (node.type == "Cover Left") {
            return "cover_left";
        } else if (node.type == "Cover Right") {
            return "cover_right";
        } else if (node.type == "Cover Stand" || node.type == "Conceal Stand") {
            return "cover_stand";
        } else if (node.type == "Cover Crouch" || node.type == "Cover Crouch Window" || node.type == "Conceal Crouch") {
            return "cover_crouch";
        } else if (node.type == "Exposed" || node.type == "Guard") {
            return "cover_exposed";
        }
    }
    return "cover_none";
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x9515ee2f, Offset: 0x7498
// Size: 0x4c
function iscoverconcealed(node) {
    if (isdefined(node)) {
        return (node.type == "Conceal Crouch" || node.type == "Conceal Stand");
    }
    return false;
}

// Namespace aiutility
// Params 0, eflags: 0x0
// Checksum 0x3dae964, Offset: 0x74f0
// Size: 0x4bc
function canseeenemywrapper() {
    if (!isdefined(self.enemy)) {
        return 0;
    }
    if (!isdefined(self.node)) {
        return self cansee(self.enemy);
    }
    node = self.node;
    enemyeye = self.enemy geteye();
    yawtoenemy = angleclamp180(node.angles[1] - vectortoangles(enemyeye - node.origin)[1]);
    if (node.type == "Cover Left" || node.type == "Cover Right") {
        if (yawtoenemy > 60 || yawtoenemy < -60) {
            return 0;
        }
        if (isdefined(node.spawnflags) && (node.spawnflags & 4) == 4) {
            if (node.type == "Cover Left" && yawtoenemy > 10) {
                return 0;
            }
            if (node.type == "Cover Right" && yawtoenemy < -10) {
                return 0;
            }
        }
    }
    nodeoffset = (0, 0, 0);
    if (node.type == "Cover Pillar") {
        assert(!(isdefined(node.spawnflags) && (node.spawnflags & 2048) == 2048) || !(isdefined(node.spawnflags) && (node.spawnflags & 1024) == 1024));
        canseefromleft = 1;
        canseefromright = 1;
        nodeoffset = (-32, 3.7, 60);
        lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
        canseefromleft = sighttracepassed(lookfrompoint, enemyeye, 0, undefined);
        nodeoffset = (32, 3.7, 60);
        lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
        canseefromright = sighttracepassed(lookfrompoint, enemyeye, 0, undefined);
        return (canseefromright || canseefromleft);
    }
    if (node.type == "Cover Left") {
        nodeoffset = (-36, 7, 63);
    } else if (node.type == "Cover Right") {
        nodeoffset = (36, 7, 63);
    } else if (node.type == "Cover Stand" || node.type == "Conceal Stand") {
        nodeoffset = (-3.7, -22, 63);
    } else if (node.type == "Cover Crouch" || node.type == "Cover Crouch Window" || node.type == "Conceal Crouch") {
        nodeoffset = (3.5, -12.5, 45);
    }
    lookfrompoint = calculatenodeoffsetposition(node, nodeoffset);
    if (sighttracepassed(lookfrompoint, enemyeye, 0, undefined)) {
        return 1;
    }
    return 0;
}

// Namespace aiutility
// Params 2, eflags: 0x1 linked
// Checksum 0x4617ab94, Offset: 0x79b8
// Size: 0xaa
function calculatenodeoffsetposition(node, nodeoffset) {
    right = anglestoright(node.angles);
    forward = anglestoforward(node.angles);
    return node.origin + vectorscale(right, nodeoffset[0]) + vectorscale(forward, nodeoffset[1]) + (0, 0, nodeoffset[2]);
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xf815c3d0, Offset: 0x7a70
// Size: 0x186
function gethighestnodestance(node) {
    assert(isdefined(node));
    if (isdefined(node.spawnflags) && (node.spawnflags & 4) == 4) {
        return "stand";
    }
    if (isdefined(node.spawnflags) && (node.spawnflags & 8) == 8) {
        return "crouch";
    }
    if (isdefined(node.spawnflags) && (node.spawnflags & 16) == 16) {
        return "prone";
    }
    errormsg(node.type + "shouldOnlyFireAccurately" + node.origin + "shouldOnlyFireAccurately");
    if (node.type == "Cover Crouch" || node.type == "Cover Crouch Window" || node.type == "Conceal Crouch") {
        return "crouch";
    }
    return "stand";
}

// Namespace aiutility
// Params 2, eflags: 0x1 linked
// Checksum 0xd904a1, Offset: 0x7c00
// Size: 0x12e
function isstanceallowedatnode(stance, node) {
    assert(isdefined(stance));
    assert(isdefined(node));
    if (isdefined(node.spawnflags) && stance == "stand" && (node.spawnflags & 4) == 4) {
        return true;
    }
    if (isdefined(node.spawnflags) && stance == "crouch" && (node.spawnflags & 8) == 8) {
        return true;
    }
    if (isdefined(node.spawnflags) && stance == "prone" && (node.spawnflags & 16) == 16) {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x25bfe1d2, Offset: 0x7d38
// Size: 0x6a
function trystoppingservice(behaviortreeentity) {
    if (behaviortreeentity shouldholdgroundagainstenemy()) {
        behaviortreeentity clearpath();
        behaviortreeentity.keepclaimednode = 1;
        return true;
    }
    behaviortreeentity.keepclaimednode = 0;
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x8227f0cf, Offset: 0x7db0
// Size: 0x2e
function shouldstopmoving(behaviortreeentity) {
    if (behaviortreeentity shouldholdgroundagainstenemy()) {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xe3057e89, Offset: 0x7de8
// Size: 0x9c
function setcurrentweapon(weapon) {
    self.weapon = weapon;
    self.weaponclass = weapon.weapclass;
    if (weapon != level.weaponnone) {
        assert(isdefined(weapon.worldmodel), "shouldOnlyFireAccurately" + weapon.name + "shouldOnlyFireAccurately");
    }
    self.weaponmodel = weapon.worldmodel;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x93f55e66, Offset: 0x7e90
// Size: 0x84
function setprimaryweapon(weapon) {
    self.primaryweapon = weapon;
    self.primaryweaponclass = weapon.weapclass;
    if (weapon != level.weaponnone) {
        assert(isdefined(weapon.worldmodel), "shouldOnlyFireAccurately" + weapon.name + "shouldOnlyFireAccurately");
    }
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x7dca4ad1, Offset: 0x7f20
// Size: 0x84
function setsecondaryweapon(weapon) {
    self.secondaryweapon = weapon;
    self.secondaryweaponclass = weapon.weapclass;
    if (weapon != level.weaponnone) {
        assert(isdefined(weapon.worldmodel), "shouldOnlyFireAccurately" + weapon.name + "shouldOnlyFireAccurately");
    }
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xb3cadd44, Offset: 0x7fb0
// Size: 0x24
function keepclaimnode(behaviortreeentity) {
    behaviortreeentity.keepclaimednode = 1;
    return true;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xc0cdb3f, Offset: 0x7fe0
// Size: 0x20
function releaseclaimnode(behaviortreeentity) {
    behaviortreeentity.keepclaimednode = 0;
    return true;
}

// Namespace aiutility
// Params 3, eflags: 0x1 linked
// Checksum 0x97e0a87d, Offset: 0x8008
// Size: 0x8a
function getaimyawtoenemyfromnode(behaviortreeentity, node, enemy) {
    return angleclamp180(vectortoangles(behaviortreeentity lastknownpos(behaviortreeentity.enemy) - node.origin)[1] - node.angles[1]);
}

// Namespace aiutility
// Params 3, eflags: 0x1 linked
// Checksum 0xa36c0a17, Offset: 0x80a0
// Size: 0x82
function getaimpitchtoenemyfromnode(behaviortreeentity, node, enemy) {
    return angleclamp180(vectortoangles(behaviortreeentity lastknownpos(behaviortreeentity.enemy) - node.origin)[0] - node.angles[0]);
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x5d933fc0, Offset: 0x8130
// Size: 0x84
function choosefrontcoverdirection(behaviortreeentity) {
    coverdirection = blackboard::getblackboardattribute(behaviortreeentity, "_cover_direction");
    blackboard::setblackboardattribute(behaviortreeentity, "_previous_cover_direction", coverdirection);
    blackboard::setblackboardattribute(behaviortreeentity, "_cover_direction", "cover_front_direction");
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x1e201153, Offset: 0x81c0
// Size: 0x1e6
function shouldtacticalwalk(behaviortreeentity) {
    if (!behaviortreeentity haspath()) {
        return false;
    }
    if (ai::hasaiattribute(behaviortreeentity, "forceTacticalWalk") && ai::getaiattribute(behaviortreeentity, "forceTacticalWalk")) {
        return true;
    }
    if (ai::hasaiattribute(behaviortreeentity, "disablesprint") && !ai::getaiattribute(behaviortreeentity, "disablesprint")) {
        if (ai::hasaiattribute(behaviortreeentity, "sprint") && ai::getaiattribute(behaviortreeentity, "sprint")) {
            return false;
        }
    }
    goalpos = undefined;
    if (isdefined(behaviortreeentity.arrivalfinalpos)) {
        goalpos = behaviortreeentity.arrivalfinalpos;
    } else {
        goalpos = behaviortreeentity.pathgoalpos;
    }
    if (isdefined(behaviortreeentity.pathstartpos) && isdefined(goalpos)) {
        pathdist = distancesquared(behaviortreeentity.pathstartpos, goalpos);
        if (pathdist < 9216) {
            return true;
        }
    }
    if (behaviortreeentity shouldfacemotion()) {
        return false;
    }
    if (!behaviortreeentity issafefromgrenade()) {
        return false;
    }
    return true;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xf7d29263, Offset: 0x83b0
// Size: 0x11e
function shouldstealth(behaviortreeentity) {
    if (isdefined(behaviortreeentity.stealth)) {
        now = gettime();
        if (behaviortreeentity isinscriptedstate()) {
            return false;
        }
        if (behaviortreeentity hasvalidinterrupt("react")) {
            behaviortreeentity.var_7c966299 = now;
            return true;
        }
        if (isdefined(behaviortreeentity.var_7c966299) && (isdefined(behaviortreeentity.stealth_reacting) && behaviortreeentity.stealth_reacting || now - behaviortreeentity.var_7c966299 < -6)) {
            return true;
        }
        if (behaviortreeentity ai::has_behavior_attribute("stealth") && behaviortreeentity ai::get_behavior_attribute("stealth")) {
            return true;
        }
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xf981c168, Offset: 0x84d8
// Size: 0x1d6
function locomotionshouldstealth(behaviortreeentity) {
    if (!shouldstealth(behaviortreeentity)) {
        return false;
    }
    if (behaviortreeentity haspath()) {
        if (isdefined(behaviortreeentity.arrivalfinalpos) || isdefined(behaviortreeentity.pathgoalpos)) {
            var_905ca688 = isdefined(self.currentgoal) && isdefined(self.currentgoal.script_wait_min) && isdefined(self.currentgoal.script_wait_max);
            if (var_905ca688) {
                var_905ca688 = self.currentgoal.script_wait_min > 0 || self.currentgoal.script_wait_max > 0;
            }
            if (isdefined(self.currentgoal) && (var_905ca688 || !isdefined(self.currentgoal) || isdefined(self.currentgoal.scriptbundlename))) {
                goalpos = undefined;
                if (isdefined(behaviortreeentity.arrivalfinalpos)) {
                    goalpos = behaviortreeentity.arrivalfinalpos;
                } else {
                    goalpos = behaviortreeentity.pathgoalpos;
                }
                goaldistsq = distancesquared(behaviortreeentity.origin, goalpos);
                if (goaldistsq <= 1936 && goaldistsq <= behaviortreeentity.goalradius * behaviortreeentity.goalradius) {
                    return false;
                }
            }
        }
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x4edd2e40, Offset: 0x86b8
// Size: 0x62
function shouldstealthresume(behaviortreeentity) {
    if (!shouldstealth(behaviortreeentity)) {
        return false;
    }
    if (isdefined(behaviortreeentity.stealth_resume) && behaviortreeentity.stealth_resume) {
        behaviortreeentity.stealth_resume = undefined;
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xa46a95c1, Offset: 0x8728
// Size: 0x9c
function private stealthreactcondition(entity) {
    inscene = isdefined(self._o_scene) && isdefined(self._o_scene._str_state) && self._o_scene._str_state == "play";
    return !(isdefined(entity.stealth_reacting) && entity.stealth_reacting) && entity hasvalidinterrupt("react") && !inscene;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x5ace4537, Offset: 0x87d0
// Size: 0x20
function private stealthreactstart(behaviortreeentity) {
    behaviortreeentity.stealth_reacting = 1;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x1d064623, Offset: 0x87f8
// Size: 0x1a
function private stealthreactterminate(behaviortreeentity) {
    behaviortreeentity.stealth_reacting = undefined;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xdba3404c, Offset: 0x8820
// Size: 0x60
function private stealthidleterminate(behaviortreeentity) {
    behaviortreeentity notify(#"stealthidleterminate");
    if (isdefined(behaviortreeentity.stealth_resume_after_idle) && behaviortreeentity.stealth_resume_after_idle) {
        behaviortreeentity.stealth_resume_after_idle = undefined;
        behaviortreeentity.stealth_resume = 1;
    }
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xbf0ee21d, Offset: 0x8888
// Size: 0x8e
function locomotionshouldpatrol(behaviortreeentity) {
    if (shouldstealth(behaviortreeentity)) {
        return false;
    }
    if (behaviortreeentity haspath() && behaviortreeentity ai::has_behavior_attribute("patrol") && behaviortreeentity ai::get_behavior_attribute("patrol")) {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x7cde30c5, Offset: 0x8920
// Size: 0x40
function explosivekilled(behaviortreeentity) {
    if (blackboard::getblackboardattribute(behaviortreeentity, "_damage_weapon_class") == "explosive") {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xc541ec5b, Offset: 0x8968
// Size: 0x84
function private _dropriotshield(riotshieldinfo) {
    entity = self;
    entity shared::throwweapon(riotshieldinfo.weapon, riotshieldinfo.tag, 0);
    if (isdefined(entity)) {
        entity detach(riotshieldinfo.model, riotshieldinfo.tag);
    }
}

// Namespace aiutility
// Params 4, eflags: 0x1 linked
// Checksum 0x7eecc596, Offset: 0x89f8
// Size: 0xb8
function attachriotshield(entity, riotshieldweapon, riotshieldmodel, riotshieldtag) {
    riotshield = spawnstruct();
    riotshield.weapon = riotshieldweapon;
    riotshield.tag = riotshieldtag;
    riotshield.model = riotshieldmodel;
    entity attach(riotshieldmodel, riotshield.tag);
    entity.riotshield = riotshield;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xbce0508b, Offset: 0x8ab8
// Size: 0x64
function dropriotshield(behaviortreeentity) {
    if (isdefined(behaviortreeentity.riotshield)) {
        riotshieldinfo = behaviortreeentity.riotshield;
        behaviortreeentity.riotshield = undefined;
        behaviortreeentity thread _dropriotshield(riotshieldinfo);
    }
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x595de238, Offset: 0x8b28
// Size: 0x70
function electrifiedkilled(behaviortreeentity) {
    if (behaviortreeentity.damageweapon.rootweapon.name == "shotgun_pump_taser") {
        return true;
    }
    if (blackboard::getblackboardattribute(behaviortreeentity, "_damage_mod") == "mod_electrocuted") {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x5f01cdcf, Offset: 0x8ba0
// Size: 0x40
function burnedkilled(behaviortreeentity) {
    if (blackboard::getblackboardattribute(behaviortreeentity, "_damage_mod") == "mod_burned") {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xda17b8b3, Offset: 0x8be8
// Size: 0x50
function rapskilled(behaviortreeentity) {
    if (isdefined(self.attacker) && isdefined(self.attacker.archetype) && self.attacker.archetype == "raps") {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x7793b9af, Offset: 0x8c40
// Size: 0xf8
function meleeacquiremutex(behaviortreeentity) {
    if (isdefined(behaviortreeentity) && isdefined(behaviortreeentity.enemy)) {
        behaviortreeentity.melee = spawnstruct();
        behaviortreeentity.melee.enemy = behaviortreeentity.enemy;
        if (isplayer(behaviortreeentity.melee.enemy)) {
            if (!isdefined(behaviortreeentity.melee.enemy.meleeattackers)) {
                behaviortreeentity.melee.enemy.meleeattackers = 0;
            }
            behaviortreeentity.melee.enemy.meleeattackers++;
        }
    }
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x6f2f1142, Offset: 0x8d40
// Size: 0x11a
function meleereleasemutex(behaviortreeentity) {
    if (isdefined(behaviortreeentity.melee)) {
        if (isdefined(behaviortreeentity.melee.enemy)) {
            if (isplayer(behaviortreeentity.melee.enemy)) {
                if (isdefined(behaviortreeentity.melee.enemy.meleeattackers)) {
                    behaviortreeentity.melee.enemy.meleeattackers -= 1;
                    if (behaviortreeentity.melee.enemy.meleeattackers <= 0) {
                        behaviortreeentity.melee.enemy.meleeattackers = undefined;
                    }
                }
            }
        }
        behaviortreeentity.melee = undefined;
    }
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x12405f23, Offset: 0x8e68
// Size: 0xea
function shouldmutexmelee(behaviortreeentity) {
    if (isdefined(behaviortreeentity.melee)) {
        return false;
    }
    if (isdefined(behaviortreeentity.enemy)) {
        if (!isplayer(behaviortreeentity.enemy)) {
            if (isdefined(behaviortreeentity.enemy.melee)) {
                return false;
            }
        } else {
            if (!sessionmodeiscampaigngame()) {
                return true;
            }
            if (!isdefined(behaviortreeentity.enemy.meleeattackers)) {
                behaviortreeentity.enemy.meleeattackers = 0;
            }
            return (behaviortreeentity.enemy.meleeattackers < 1);
        }
    }
    return true;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x425658f2, Offset: 0x8f60
// Size: 0x22
function shouldnormalmelee(behaviortreeentity) {
    return hascloseenemytomelee(behaviortreeentity);
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xb7e6d289, Offset: 0x8f90
// Size: 0x320
function shouldmelee(entity) {
    if (isdefined(entity.lastshouldmeleeresult) && !entity.lastshouldmeleeresult && entity.lastshouldmeleechecktime + 50 >= gettime()) {
        return false;
    }
    entity.lastshouldmeleechecktime = gettime();
    entity.lastshouldmeleeresult = 0;
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (!entity.enemy.allowdeath) {
        return false;
    }
    if (!isalive(entity.enemy)) {
        return false;
    }
    if (!issentient(entity.enemy)) {
        return false;
    }
    if (isvehicle(entity.enemy) && !(isdefined(entity.enemy.good_melee_target) && entity.enemy.good_melee_target)) {
        return false;
    }
    if (isplayer(entity.enemy) && entity.enemy getstance() == "prone") {
        return false;
    }
    chargedistsq = isdefined(entity.var_31da95f4) ? entity.var_31da95f4 : -116 * -116;
    if (distancesquared(entity.origin, entity.enemy.origin) > chargedistsq) {
        return false;
    }
    if (!shouldmutexmelee(entity)) {
        return false;
    }
    if (ai::hasaiattribute(entity, "can_melee") && !ai::getaiattribute(entity, "can_melee")) {
        return false;
    }
    if (ai::hasaiattribute(entity.enemy, "can_be_meleed") && !ai::getaiattribute(entity.enemy, "can_be_meleed")) {
        return false;
    }
    if (shouldnormalmelee(entity) || shouldchargemelee(entity)) {
        entity.lastshouldmeleeresult = 1;
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xbcadd7d9, Offset: 0x92b8
// Size: 0x2a
function hascloseenemytomelee(entity) {
    return hascloseenemytomeleewithrange(entity, 64 * 64);
}

// Namespace aiutility
// Params 2, eflags: 0x1 linked
// Checksum 0x8fa7a46b, Offset: 0x92f0
// Size: 0x1c4
function hascloseenemytomeleewithrange(entity, melee_range_sq) {
    assert(isdefined(entity.enemy));
    if (!entity cansee(entity.enemy)) {
        return false;
    }
    predicitedposition = entity.enemy.origin + vectorscale(entity getenemyvelocity(), 0.25);
    distsq = distancesquared(entity.origin, predicitedposition);
    yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
    if (distsq <= 36 * 36) {
        return (abs(yawtoenemy) <= 40);
    }
    if (distsq <= melee_range_sq && entity maymovetopoint(entity.enemy.origin)) {
        return (abs(yawtoenemy) <= 80);
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xc0cc81f8, Offset: 0x94c0
// Size: 0x24c
function shouldchargemelee(entity) {
    assert(isdefined(entity.enemy));
    currentstance = blackboard::getblackboardattribute(entity, "_stance");
    if (currentstance != "stand") {
        return false;
    }
    if (isdefined(entity.nextchargemeleetime)) {
        if (gettime() < entity.nextchargemeleetime) {
            return false;
        }
    }
    enemydistsq = distancesquared(entity.origin, entity.enemy.origin);
    if (enemydistsq < 64 * 64) {
        return false;
    }
    offset = entity.enemy.origin - vectornormalize(entity.enemy.origin - entity.origin) * 36;
    chargedistsq = isdefined(entity.var_31da95f4) ? entity.var_31da95f4 : -116 * -116;
    if (enemydistsq < chargedistsq && entity maymovetopoint(offset, 1, 1)) {
        yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
        return (abs(yawtoenemy) <= 80);
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x8deab18, Offset: 0x9718
// Size: 0xf6
function private shouldattackinchargemelee(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy)) {
        if (distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) < 74 * 74) {
            yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]);
            if (abs(yawtoenemy) > 80) {
                return 0;
            }
            return 1;
        }
    }
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xaf37ec01, Offset: 0x9818
// Size: 0xc4
function private setupchargemeleeattack(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy) && isdefined(behaviortreeentity.enemy.vehicletype) && issubstr(behaviortreeentity.enemy.vehicletype, "firefly")) {
        blackboard::setblackboardattribute(behaviortreeentity, "_melee_enemy_type", "fireflyswarm");
    }
    meleeacquiremutex(behaviortreeentity);
    keepclaimnode(behaviortreeentity);
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xfd8d084b, Offset: 0x98e8
// Size: 0x5c
function private cleanupmelee(behaviortreeentity) {
    meleereleasemutex(behaviortreeentity);
    releaseclaimnode(behaviortreeentity);
    blackboard::setblackboardattribute(behaviortreeentity, "_melee_enemy_type", undefined);
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x75caa300, Offset: 0x9950
// Size: 0xb4
function private cleanupchargemelee(behaviortreeentity) {
    behaviortreeentity.nextchargemeleetime = gettime() + 2000;
    blackboard::setblackboardattribute(behaviortreeentity, "_melee_enemy_type", undefined);
    meleereleasemutex(behaviortreeentity);
    releaseclaimnode(behaviortreeentity);
    behaviortreeentity pathmode("move delayed", 1, randomfloatrange(0.75, 1.5));
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x53e02229, Offset: 0x9a10
// Size: 0x9c
function cleanupchargemeleeattack(behaviortreeentity) {
    meleereleasemutex(behaviortreeentity);
    releaseclaimnode(behaviortreeentity);
    blackboard::setblackboardattribute(behaviortreeentity, "_melee_enemy_type", undefined);
    behaviortreeentity pathmode("move delayed", 1, randomfloatrange(0.5, 1));
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xc2f3db4a, Offset: 0x9ab8
// Size: 0x54
function private shouldchoosespecialpronepain(behaviortreeentity) {
    stance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
    return stance == "prone_back" || stance == "prone_front";
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xabde30a1, Offset: 0x9b18
// Size: 0x4c
function private shouldchoosespecialpain(behaviortreeentity) {
    if (isdefined(behaviortreeentity.damageweapon)) {
        return (behaviortreeentity.damageweapon.specialpain || isdefined(behaviortreeentity.special_weapon));
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xcd9c3040, Offset: 0x9b70
// Size: 0x3a
function private shouldchoosespecialdeath(behaviortreeentity) {
    if (isdefined(behaviortreeentity.damageweapon)) {
        return behaviortreeentity.damageweapon.specialpain;
    }
    return 0;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x22a3b7e5, Offset: 0x9bb8
// Size: 0x54
function private shouldchoosespecialpronedeath(behaviortreeentity) {
    stance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
    return stance == "prone_back" || stance == "prone_front";
}

// Namespace aiutility
// Params 2, eflags: 0x5 linked
// Checksum 0x92ec95f1, Offset: 0x9c18
// Size: 0x48
function private setupexplosionanimscale(entity, asmstatename) {
    self.animtranslationscale = 2;
    self asmsetanimationrate(0.7);
    return 4;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x12de9861, Offset: 0x9c68
// Size: 0x270
function isbalconydeath(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.node)) {
        return false;
    }
    if (!(behaviortreeentity.node.spawnflags & 1024 || behaviortreeentity.node.spawnflags & 2048)) {
        return false;
    }
    covermode = blackboard::getblackboardattribute(behaviortreeentity, "_cover_mode");
    if (covermode == "cover_alert" || covermode == "cover_mode_none") {
        return false;
    }
    if (isdefined(behaviortreeentity.node.script_balconydeathchance) && randomint(100) > int(100 * behaviortreeentity.node.script_balconydeathchance)) {
        return false;
    }
    distsq = distancesquared(behaviortreeentity.origin, behaviortreeentity.node.origin);
    if (distsq > 16 * 16) {
        return false;
    }
    if (isdefined(level.players) && level.players.size > 0) {
        closest_player = util::get_closest_player(behaviortreeentity.origin, level.players[0].team);
        if (isdefined(closest_player)) {
            if (abs(closest_player.origin[2] - behaviortreeentity.origin[2]) < 100) {
                var_9eabeb39 = distance2dsquared(closest_player.origin, behaviortreeentity.origin);
                if (var_9eabeb39 < 600 * 600) {
                    return false;
                }
            }
        }
    }
    self.b_balcony_death = 1;
    return true;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x70b58874, Offset: 0x9ee0
// Size: 0xac
function balconydeath(behaviortreeentity) {
    behaviortreeentity.clamptonavmesh = 0;
    if (behaviortreeentity.node.spawnflags & 1024) {
        blackboard::setblackboardattribute(behaviortreeentity, "_special_death", "balcony");
        return;
    }
    if (behaviortreeentity.node.spawnflags & 2048) {
        blackboard::setblackboardattribute(behaviortreeentity, "_special_death", "balcony_norail");
    }
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xabdb06e6, Offset: 0x9f98
// Size: 0x2c
function usecurrentposition(entity) {
    entity useposition(entity.origin);
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xe3507cd, Offset: 0x9fd0
// Size: 0x30
function isunarmed(behaviortreeentity) {
    if (behaviortreeentity.weapon == level.weaponnone) {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x4351a17b, Offset: 0xa008
// Size: 0x24
function function_ba976497(entity) {
    entity startragdoll();
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x9e5a27a2, Offset: 0xa038
// Size: 0x1a8
function preshootlaserandglinton(ai) {
    self endon(#"death");
    if (!isdefined(ai.laserstatus)) {
        ai.laserstatus = 0;
    }
    sniper_glint = "lensflares/fx_lensflare_sniper_glint";
    while (true) {
        self waittill(#"about_to_fire");
        if (ai.laserstatus !== 1) {
            ai laseron();
            ai.laserstatus = 1;
            if (ai.team != "allies") {
                tag = ai gettagorigin("tag_glint");
                if (isdefined(tag)) {
                    playfxontag(sniper_glint, ai, "tag_glint");
                    continue;
                }
                type = isdefined(ai.classname) ? "" + ai.classname : "";
                println("shouldOnlyFireAccurately" + type + "shouldOnlyFireAccurately");
                playfxontag(sniper_glint, ai, "tag_eye");
            }
        }
    }
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x89933b5c, Offset: 0xa1e8
// Size: 0x70
function postshootlaserandglintoff(ai) {
    self endon(#"death");
    while (true) {
        self waittill(#"stopped_firing");
        if (ai.laserstatus === 1) {
            ai laseroff();
            ai.laserstatus = 0;
        }
    }
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xf795b6db, Offset: 0xa260
// Size: 0x2a
function private isinphalanx(entity) {
    return entity ai::get_behavior_attribute("phalanx");
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x761035c, Offset: 0xa298
// Size: 0xa6
function private isinphalanxstance(entity) {
    phalanxstance = entity ai::get_behavior_attribute("phalanx_force_stance");
    currentstance = blackboard::getblackboardattribute(entity, "_stance");
    switch (phalanxstance) {
    case 86:
        return (currentstance == "stand");
    case 207:
        return (currentstance == "crouch");
    }
    return true;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xbaf8aa62, Offset: 0xa348
// Size: 0xa6
function private togglephalanxstance(entity) {
    phalanxstance = entity ai::get_behavior_attribute("phalanx_force_stance");
    switch (phalanxstance) {
    case 86:
        blackboard::setblackboardattribute(entity, "_desired_stance", "stand");
        break;
    case 207:
        blackboard::setblackboardattribute(entity, "_desired_stance", "crouch");
        break;
    }
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xd9cb97ca, Offset: 0xa3f8
// Size: 0x10e
function private tookflashbangdamage(entity) {
    if (isdefined(entity.damageweapon) && isdefined(entity.damagemod)) {
        weapon = entity.damageweapon;
        return (issubstr(weapon.rootweapon.name, "flash_grenade") || issubstr(weapon.rootweapon.name, "concussion_grenade") || entity.damagemod == "MOD_GRENADE_SPLASH" && isdefined(weapon.rootweapon) && issubstr(weapon.rootweapon.name, "proximity_grenade"));
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x69a26ef, Offset: 0xa510
// Size: 0xd0
function isatattackobject(entity) {
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (isdefined(entity.attackable.is_active) && isdefined(entity.attackable) && entity.attackable.is_active) {
        if (!isdefined(entity.attackable_slot)) {
            return false;
        }
        if (entity isatgoal()) {
            entity.is_at_attackable = 1;
            return true;
        }
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xa0661012, Offset: 0xa5e8
// Size: 0xb2
function shouldattackobject(entity) {
    if (isdefined(entity.enemyoverride) && isdefined(entity.enemyoverride[1])) {
        return false;
    }
    if (isdefined(entity.attackable.is_active) && isdefined(entity.attackable) && entity.attackable.is_active) {
        if (isdefined(entity.is_at_attackable) && entity.is_at_attackable) {
            return true;
        }
    }
    return false;
}

