#using scripts/shared/ai/archetype_cover_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/ai_blackboard;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/laststand_shared;

#namespace archetype_human_cover;

// Namespace archetype_human_cover
// Params 0, eflags: 0x2
// Checksum 0x11fd381e, Offset: 0x568
// Size: 0x2d4
function autoexec registerbehaviorscriptfunctions() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldReturnToCoverCondition", &shouldreturntocovercondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldReturnToSuppressedCover", &shouldreturntosuppressedcover);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldAdjustToCover", &shouldadjusttocover);
    behaviortreenetworkutility::registerbehaviortreescriptapi("prepareForAdjustToCover", &prepareforadjusttocover);
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverBlindfireShootStart", &coverblindfireshootactionstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("canChangeStanceAtCoverCondition", &canchangestanceatcovercondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverChangeStanceActionStart", &coverchangestanceactionstart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("prepareToChangeStanceToStand", &preparetochangestancetostand);
    behaviortreenetworkutility::registerbehaviortreescriptapi("cleanUpChangeStanceToStand", &cleanupchangestancetostand);
    behaviortreenetworkutility::registerbehaviortreescriptapi("prepareToChangeStanceToCrouch", &preparetochangestancetocrouch);
    behaviortreenetworkutility::registerbehaviortreescriptapi("cleanUpChangeStanceToCrouch", &cleanupchangestancetocrouch);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldVantageAtCoverCondition", &shouldvantageatcovercondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("supportsVantageCoverCondition", &supportsvantagecovercondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverVantageInitialize", &covervantageinitialize);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldThrowGrenadeAtCoverCondition", &shouldthrowgrenadeatcovercondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverPrepareToThrowGrenade", &coverpreparetothrowgrenade);
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverCleanUpToThrowGrenade", &covercleanuptothrowgrenade);
    behaviortreenetworkutility::registerbehaviortreescriptapi("senseNearbyPlayers", &sensenearbyplayers);
}

// Namespace archetype_human_cover
// Params 2, eflags: 0x0
// Checksum 0x43557135, Offset: 0x848
// Size: 0x882
function shouldthrowgrenadeatcovercondition(behaviortreeentity, throwifpossible) {
    if (!isdefined(throwifpossible)) {
        throwifpossible = 0;
    }
    if (isdefined(level.aidisablegrenadethrows) && level.aidisablegrenadethrows) {
        return false;
    }
    if (!isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    if (!issentient(behaviortreeentity.enemy)) {
        return false;
    }
    if (isvehicle(behaviortreeentity.enemy) && behaviortreeentity.enemy.vehicleclass === "helicopter") {
        return false;
    }
    if (ai::hasaiattribute(behaviortreeentity, "useGrenades") && !ai::getaiattribute(behaviortreeentity, "useGrenades")) {
        return false;
    }
    entityangles = behaviortreeentity.angles;
    if ((behaviortreeentity.node.type == "Cover Crouch" || behaviortreeentity.node.type == "Cover Crouch Window" || behaviortreeentity.node.type == "Cover Stand" || behaviortreeentity.node.type == "Cover Left" || behaviortreeentity.node.type == "Cover Right" || behaviortreeentity.node.type == "Cover Pillar" || behaviortreeentity.node.type == "Conceal Stand" || isdefined(behaviortreeentity.node) && behaviortreeentity.node.type == "Conceal Crouch") && behaviortreeentity isatcovernodestrict()) {
        entityangles = behaviortreeentity.node.angles;
    }
    toenemy = behaviortreeentity.enemy.origin - behaviortreeentity.origin;
    toenemy = vectornormalize((toenemy[0], toenemy[1], 0));
    entityforward = anglestoforward(entityangles);
    entityforward = vectornormalize((entityforward[0], entityforward[1], 0));
    if (vectordot(toenemy, entityforward) < 0.5) {
        return false;
    }
    if (!throwifpossible) {
        if (behaviortreeentity.team === "allies") {
            foreach (player in level.players) {
                if (distancesquared(behaviortreeentity.enemy.origin, player.origin) <= 250000) {
                    return false;
                }
            }
        }
        foreach (player in level.players) {
            if (player laststand::player_is_in_laststand() && distancesquared(behaviortreeentity.enemy.origin, player.origin) <= 250000) {
                return false;
            }
        }
        grenadethrowinfos = blackboard::getblackboardevents("team_grenade_throw");
        foreach (grenadethrowinfo in grenadethrowinfos) {
            if (grenadethrowinfo.data.grenadethrowerteam === behaviortreeentity.team) {
                return false;
            }
        }
        grenadethrowinfos = blackboard::getblackboardevents("human_grenade_throw");
        foreach (grenadethrowinfo in grenadethrowinfos) {
            if (isdefined(grenadethrowinfo.data.grenadethrownat) && isalive(grenadethrowinfo.data.grenadethrownat)) {
                if (grenadethrowinfo.data.grenadethrower == behaviortreeentity) {
                    return false;
                }
                if (isdefined(grenadethrowinfo.data.grenadethrownat) && grenadethrowinfo.data.grenadethrownat == behaviortreeentity.enemy) {
                    return false;
                }
                if (isdefined(grenadethrowinfo.data.grenadethrownposition) && isdefined(behaviortreeentity.grenadethrowposition) && distancesquared(grenadethrowinfo.data.grenadethrownposition, behaviortreeentity.grenadethrowposition) <= 360000) {
                    return false;
                }
            }
        }
    }
    throw_dist = distance2dsquared(behaviortreeentity.origin, behaviortreeentity lastknownpos(behaviortreeentity.enemy));
    if (throw_dist < 500 * 500 || throw_dist > 1250 * 1250) {
        return false;
    }
    arm_offset = temp_get_arm_offset(behaviortreeentity, behaviortreeentity lastknownpos(behaviortreeentity.enemy));
    throw_vel = behaviortreeentity canthrowgrenadepos(arm_offset, behaviortreeentity lastknownpos(behaviortreeentity.enemy));
    if (!isdefined(throw_vel)) {
        return false;
    }
    return true;
}

// Namespace archetype_human_cover
// Params 1, eflags: 0x4
// Checksum 0x3a98b8d7, Offset: 0x10d8
// Size: 0x15a
function private sensenearbyplayers(entity) {
    players = getplayers();
    foreach (player in players) {
        distancesq = distancesquared(player.origin, entity.origin);
        if (distancesq <= 360 * 360) {
            distancetoplayer = sqrt(distancesq);
            chancetodetect = randomfloat(1);
            if (chancetodetect < distancetoplayer / 360) {
                entity getperfectinfo(player);
            }
        }
    }
}

// Namespace archetype_human_cover
// Params 1, eflags: 0x4
// Checksum 0x6fd0db0c, Offset: 0x1240
// Size: 0x190
function private coverpreparetothrowgrenade(behaviortreeentity) {
    aiutility::keepclaimednodeandchoosecoverdirection(behaviortreeentity);
    if (isdefined(behaviortreeentity.enemy)) {
        behaviortreeentity.grenadethrowposition = behaviortreeentity lastknownpos(behaviortreeentity.enemy);
    }
    grenadethrowinfo = spawnstruct();
    grenadethrowinfo.grenadethrower = behaviortreeentity;
    grenadethrowinfo.grenadethrownat = behaviortreeentity.enemy;
    grenadethrowinfo.grenadethrownposition = behaviortreeentity.grenadethrowposition;
    blackboard::addblackboardevent("human_grenade_throw", grenadethrowinfo, randomintrange(15000, 20000));
    grenadethrowinfo = spawnstruct();
    grenadethrowinfo.grenadethrowerteam = behaviortreeentity.team;
    blackboard::addblackboardevent("team_grenade_throw", grenadethrowinfo, randomintrange(1000, 2000));
    behaviortreeentity.preparegrenadeammo = behaviortreeentity.grenadeammo;
}

// Namespace archetype_human_cover
// Params 1, eflags: 0x4
// Checksum 0x8d8a6813, Offset: 0x13d8
// Size: 0x21c
function private covercleanuptothrowgrenade(behaviortreeentity) {
    aiutility::resetcoverparameters(behaviortreeentity);
    if (behaviortreeentity.preparegrenadeammo == behaviortreeentity.grenadeammo) {
        if (behaviortreeentity.health <= 0) {
            grenade = undefined;
            if (isactor(behaviortreeentity.enemy) && isdefined(behaviortreeentity.grenadeweapon)) {
                grenade = behaviortreeentity.enemy magicgrenadetype(behaviortreeentity.grenadeweapon, behaviortreeentity gettagorigin("j_wrist_ri"), (0, 0, 0), behaviortreeentity.grenadeweapon.aifusetime / 1000);
            } else if (isplayer(behaviortreeentity.enemy) && isdefined(behaviortreeentity.grenadeweapon)) {
                grenade = behaviortreeentity.enemy magicgrenadeplayer(behaviortreeentity.grenadeweapon, behaviortreeentity gettagorigin("j_wrist_ri"), (0, 0, 0));
            }
            if (isdefined(grenade)) {
                grenade.owner = behaviortreeentity;
                grenade.team = behaviortreeentity.team;
                grenade setcontents(grenade setcontents(0) & ~(32768 | 67108864 | 8388608 | 33554432));
            }
        }
    }
}

// Namespace archetype_human_cover
// Params 1, eflags: 0x4
// Checksum 0xb37ed1eb, Offset: 0x1600
// Size: 0x9c
function private canchangestanceatcovercondition(behaviortreeentity) {
    switch (blackboard::getblackboardattribute(behaviortreeentity, "_stance")) {
    case "stand":
        return aiutility::isstanceallowedatnode("crouch", behaviortreeentity.node);
    case "crouch":
        return aiutility::isstanceallowedatnode("stand", behaviortreeentity.node);
    }
    return 0;
}

// Namespace archetype_human_cover
// Params 1, eflags: 0x4
// Checksum 0x4847ede1, Offset: 0x16a8
// Size: 0x2e
function private shouldreturntosuppressedcover(entity) {
    if (!entity isatgoal()) {
        return true;
    }
    return false;
}

// Namespace archetype_human_cover
// Params 1, eflags: 0x4
// Checksum 0x584b1f1, Offset: 0x16e0
// Size: 0x1a6
function private shouldreturntocovercondition(behaviortreeentity) {
    if (behaviortreeentity asmistransitionrunning()) {
        return false;
    }
    if (isdefined(behaviortreeentity.covershootstarttime)) {
        if (gettime() < behaviortreeentity.covershootstarttime + 800) {
            return false;
        }
        if (isdefined(behaviortreeentity.enemy) && isplayer(behaviortreeentity.enemy) && behaviortreeentity.enemy.health < behaviortreeentity.enemy.maxhealth * 0.5) {
            if (gettime() < behaviortreeentity.covershootstarttime + 3000) {
                return false;
            }
        }
    }
    if (aiutility::issuppressedatcovercondition(behaviortreeentity)) {
        return true;
    }
    if (!behaviortreeentity isatgoal()) {
        if (isdefined(behaviortreeentity.node)) {
            offsetorigin = behaviortreeentity getnodeoffsetposition(behaviortreeentity.node);
            return !behaviortreeentity isposatgoal(offsetorigin);
        }
        return true;
    }
    if (!behaviortreeentity issafefromgrenade()) {
        return true;
    }
    return false;
}

// Namespace archetype_human_cover
// Params 1, eflags: 0x4
// Checksum 0x858e187c, Offset: 0x1890
// Size: 0x156
function private shouldadjusttocover(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.node)) {
        return false;
    }
    highestsupportedstance = aiutility::gethighestnodestance(behaviortreeentity.node);
    currentstance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
    if (currentstance == "crouch" && highestsupportedstance == "crouch") {
        return false;
    }
    covermode = blackboard::getblackboardattribute(behaviortreeentity, "_cover_mode");
    previouscovermode = blackboard::getblackboardattribute(behaviortreeentity, "_previous_cover_mode");
    if (covermode != "cover_alert" && previouscovermode != "cover_alert" && !behaviortreeentity.keepclaimednode) {
        return true;
    }
    if (!aiutility::isstanceallowedatnode(currentstance, behaviortreeentity.node)) {
        return true;
    }
    return false;
}

// Namespace archetype_human_cover
// Params 1, eflags: 0x4
// Checksum 0xff83653a, Offset: 0x19f0
// Size: 0x1c2
function private shouldvantageatcovercondition(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.node) || !isdefined(behaviortreeentity.node.type) || !isdefined(behaviortreeentity.enemy) || !isdefined(behaviortreeentity.enemy.origin)) {
        return 0;
    }
    yawtoenemyposition = aiutility::getaimyawtoenemyfromnode(behaviortreeentity, behaviortreeentity.node, behaviortreeentity.enemy);
    pitchtoenemyposition = aiutility::getaimpitchtoenemyfromnode(behaviortreeentity, behaviortreeentity.node, behaviortreeentity.enemy);
    aimlimitsforcover = behaviortreeentity getaimlimitsfromentry("cover_vantage");
    legalaim = 0;
    if (yawtoenemyposition < aimlimitsforcover["aim_left"] && yawtoenemyposition > aimlimitsforcover["aim_right"] && pitchtoenemyposition < 85 && pitchtoenemyposition > 25 && behaviortreeentity.node.origin[2] - behaviortreeentity.enemy.origin[2] >= 36) {
        legalaim = 1;
    }
    return legalaim;
}

// Namespace archetype_human_cover
// Params 1, eflags: 0x4
// Checksum 0x7623dba2, Offset: 0x1bc0
// Size: 0xe
function private supportsvantagecovercondition(behaviortreeentity) {
    return false;
}

// Namespace archetype_human_cover
// Params 2, eflags: 0x4
// Checksum 0x1af350a3, Offset: 0x1bd8
// Size: 0x54
function private covervantageinitialize(behaviortreeentity, asmstatename) {
    aiutility::keepclaimnode(behaviortreeentity);
    blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_vantage");
}

// Namespace archetype_human_cover
// Params 2, eflags: 0x4
// Checksum 0xa4c580a3, Offset: 0x1c38
// Size: 0x6c
function private coverblindfireshootactionstart(behaviortreeentity, asmstatename) {
    aiutility::keepclaimnode(behaviortreeentity);
    blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_blind");
    aiutility::choosecoverdirection(behaviortreeentity);
}

// Namespace archetype_human_cover
// Params 2, eflags: 0x4
// Checksum 0x7e67ccb5, Offset: 0x1cb0
// Size: 0x54
function private preparetochangestancetostand(behaviortreeentity, asmstatename) {
    aiutility::cleanupcovermode(behaviortreeentity);
    blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
}

// Namespace archetype_human_cover
// Params 2, eflags: 0x4
// Checksum 0xb664f0d0, Offset: 0x1d10
// Size: 0x3c
function private cleanupchangestancetostand(behaviortreeentity, asmstatename) {
    aiutility::releaseclaimnode(behaviortreeentity);
    behaviortreeentity.newenemyreaction = 0;
}

// Namespace archetype_human_cover
// Params 2, eflags: 0x4
// Checksum 0x1b2f02da, Offset: 0x1d58
// Size: 0x54
function private preparetochangestancetocrouch(behaviortreeentity, asmstatename) {
    aiutility::cleanupcovermode(behaviortreeentity);
    blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "crouch");
}

// Namespace archetype_human_cover
// Params 2, eflags: 0x4
// Checksum 0x41c91cee, Offset: 0x1db8
// Size: 0x3c
function private cleanupchangestancetocrouch(behaviortreeentity, asmstatename) {
    aiutility::releaseclaimnode(behaviortreeentity);
    behaviortreeentity.newenemyreaction = 0;
}

// Namespace archetype_human_cover
// Params 2, eflags: 0x4
// Checksum 0x67c54587, Offset: 0x1e00
// Size: 0x7c
function private prepareforadjusttocover(behaviortreeentity, asmstatename) {
    aiutility::keepclaimnode(behaviortreeentity);
    highestsupportedstance = aiutility::gethighestnodestance(behaviortreeentity.node);
    blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", highestsupportedstance);
}

// Namespace archetype_human_cover
// Params 2, eflags: 0x4
// Checksum 0x396022ea, Offset: 0x1e88
// Size: 0xde
function private coverchangestanceactionstart(behaviortreeentity, asmstatename) {
    blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_alert");
    aiutility::keepclaimnode(behaviortreeentity);
    switch (blackboard::getblackboardattribute(behaviortreeentity, "_stance")) {
    case "stand":
        blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "crouch");
        break;
    case "crouch":
        blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
        break;
    }
}

// Namespace archetype_human_cover
// Params 2, eflags: 0x0
// Checksum 0xfb9ebcb6, Offset: 0x1f70
// Size: 0x48e
function temp_get_arm_offset(behaviortreeentity, throwposition) {
    stance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
    arm_offset = undefined;
    if (stance == "crouch") {
        arm_offset = (13, -1, 56);
    } else {
        arm_offset = (14, -3, 80);
    }
    if (isdefined(behaviortreeentity.node) && behaviortreeentity isatcovernodestrict()) {
        if (behaviortreeentity.node.type == "Cover Left") {
            if (stance == "crouch") {
                arm_offset = (-38, 15, 23);
            } else {
                arm_offset = (-45, 0, 40);
            }
        } else if (behaviortreeentity.node.type == "Cover Right") {
            if (stance == "crouch") {
                arm_offset = (46, 12, 26);
            } else {
                arm_offset = (34, -21, 50);
            }
        } else if (behaviortreeentity.node.type == "Cover Stand" || behaviortreeentity.node.type == "Conceal Stand") {
            arm_offset = (10, 7, 77);
        } else if (behaviortreeentity.node.type == "Cover Crouch" || behaviortreeentity.node.type == "Cover Crouch Window" || behaviortreeentity.node.type == "Conceal Crouch") {
            arm_offset = (19, 5, 60);
        } else if (behaviortreeentity.node.type == "Cover Pillar") {
            leftoffset = undefined;
            rightoffset = undefined;
            if (stance == "crouch") {
                leftoffset = (-20, 0, 35);
                rightoffset = (34, 6, 50);
            } else {
                leftoffset = (-24, 0, 76);
                rightoffset = (24, 0, 76);
            }
            if (isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 1024) == 1024) {
                arm_offset = rightoffset;
            } else if (isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 2048) == 2048) {
                arm_offset = leftoffset;
            } else {
                yawtoenemyposition = angleclamp180(vectortoangles(throwposition - behaviortreeentity.node.origin)[1] - behaviortreeentity.node.angles[1]);
                aimlimitsfordirectionright = behaviortreeentity getaimlimitsfromentry("pillar_right_lean");
                legalrightdirectionyaw = yawtoenemyposition >= aimlimitsfordirectionright["aim_right"] - 10 && yawtoenemyposition <= 0;
                if (legalrightdirectionyaw) {
                    arm_offset = rightoffset;
                } else {
                    arm_offset = leftoffset;
                }
            }
        }
    }
    return arm_offset;
}

