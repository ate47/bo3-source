#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/math_shared;
#using scripts/shared/ai_shared;

#namespace aiutility;

// Namespace aiutility
// Params 0, eflags: 0x2
// Checksum 0xafb593fb, Offset: 0x658
// Size: 0x504
function registerbehaviorscriptfunctions() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("isAtCrouchNode", &isatcrouchnode);
    behaviortreenetworkutility::registerbehaviortreescriptapi("isAtCoverCondition", &function_f09741fa);
    behaviortreenetworkutility::registerbehaviortreescriptapi("isAtCoverStrictCondition", &isatcoverstrictcondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("isAtCoverModeOver", &isatcovermodeover);
    behaviortreenetworkutility::registerbehaviortreescriptapi("isAtCoverModeNone", &isatcovermodenone);
    behaviortreenetworkutility::registerbehaviortreescriptapi("isExposedAtCoverCondition", &isexposedatcovercondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("keepClaimedNodeAndChooseCoverDirection", &keepclaimednodeandchoosecoverdirection);
    behaviortreenetworkutility::registerbehaviortreescriptapi("resetCoverParameters", &resetcoverparameters);
    behaviortreenetworkutility::registerbehaviortreescriptapi("cleanupCoverMode", &cleanupcovermode);
    behaviortreenetworkutility::registerbehaviortreescriptapi("canBeFlankedService", &canbeflankedservice);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldCoverIdleOnly", &shouldcoveridleonly);
    behaviortreenetworkutility::registerbehaviortreescriptapi("isSuppressedAtCoverCondition", &issuppressedatcovercondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverIdleInitialize", &coveridleinitialize);
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverIdleUpdate", &coveridleupdate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverIdleTerminate", &coveridleterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("isFlankedByEnemyAtCover", &isflankedbyenemyatcover);
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverFlankedActionStart", &coverflankedinitialize);
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverFlankedActionTerminate", &coverflankedactionterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("supportsOverCoverCondition", &supportsovercovercondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldOverAtCoverCondition", &shouldoveratcovercondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverOverInitialize", &coveroverinitialize);
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverOverTerminate", &coveroverterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("supportsLeanCoverCondition", &supportsleancovercondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("shouldLeanAtCoverCondition", &shouldleanatcovercondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("continueLeaningAtCoverCondition", &continueleaningatcovercondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverLeanInitialize", &coverleaninitialize);
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverLeanTerminate", &coverleanterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("supportsPeekCoverCondition", &supportspeekcovercondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverPeekInitialize", &coverpeekinitialize);
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverPeekTerminate", &coverpeekterminate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("coverReloadInitialize", &coverreloadinitialize);
    behaviortreenetworkutility::registerbehaviortreescriptapi("refillAmmoAndCleanupCoverMode", &refillammoandcleanupcovermode);
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x6a6fdd18, Offset: 0xb68
// Size: 0x4c
function coverreloadinitialize(behaviortreeentity) {
    blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_alert");
    keepclaimnode(behaviortreeentity);
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x61db8b36, Offset: 0xbc0
// Size: 0x54
function refillammoandcleanupcovermode(behaviortreeentity) {
    if (isalive(behaviortreeentity)) {
        refillammo(behaviortreeentity);
    }
    cleanupcovermode(behaviortreeentity);
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xfe942645, Offset: 0xc20
// Size: 0x1c
function supportspeekcovercondition(behaviortreeentity) {
    return isdefined(behaviortreeentity.node);
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x64c072a5, Offset: 0xc48
// Size: 0x64
function coverpeekinitialize(behaviortreeentity) {
    blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_alert");
    keepclaimnode(behaviortreeentity);
    choosecoverdirection(behaviortreeentity);
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xae796100, Offset: 0xcb8
// Size: 0x3c
function coverpeekterminate(behaviortreeentity) {
    choosefrontcoverdirection(behaviortreeentity);
    cleanupcovermode(behaviortreeentity);
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xe70ef4a6, Offset: 0xd00
// Size: 0x124
function supportsleancovercondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.node)) {
        if (behaviortreeentity.node.type == "Cover Left" || behaviortreeentity.node.type == "Cover Right") {
            return true;
        } else if (behaviortreeentity.node.type == "Cover Pillar") {
            if (!(isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 1024) == 1024) || !(isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 2048) == 2048)) {
                return true;
            }
        }
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xa1c27aec, Offset: 0xe30
// Size: 0x340
function shouldleanatcovercondition(behaviortreeentity) {
    if (!isdefined(behaviortreeentity.node) || !isdefined(behaviortreeentity.node.type) || !isdefined(behaviortreeentity.enemy) || !isdefined(behaviortreeentity.enemy.origin)) {
        return 0;
    }
    yawtoenemyposition = getaimyawtoenemyfromnode(behaviortreeentity, behaviortreeentity.node, behaviortreeentity.enemy);
    legalaimyaw = 0;
    if (behaviortreeentity.node.type == "Cover Left") {
        aimlimitsforcover = behaviortreeentity getaimlimitsfromentry("cover_left_lean");
        legalaimyaw = yawtoenemyposition <= aimlimitsforcover["aim_left"] + 10 && yawtoenemyposition >= -10;
    } else if (behaviortreeentity.node.type == "Cover Right") {
        aimlimitsforcover = behaviortreeentity getaimlimitsfromentry("cover_right_lean");
        legalaimyaw = yawtoenemyposition >= aimlimitsforcover["aim_right"] - 10 && yawtoenemyposition <= 10;
    } else if (behaviortreeentity.node.type == "Cover Pillar") {
        aimlimitsforcover = behaviortreeentity getaimlimitsfromentry("cover");
        supportsleft = !(isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 1024) == 1024);
        supportsright = !(isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 2048) == 2048);
        angleleeway = 10;
        if (supportsright && supportsleft) {
            angleleeway = 0;
        }
        if (supportsleft) {
            legalaimyaw = yawtoenemyposition <= aimlimitsforcover["aim_left"] + 10 && yawtoenemyposition >= angleleeway * -1;
        }
        if (!legalaimyaw && supportsright) {
            legalaimyaw = yawtoenemyposition >= aimlimitsforcover["aim_right"] - 10 && yawtoenemyposition <= angleleeway;
        }
    }
    return legalaimyaw;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xec2360e2, Offset: 0x1178
// Size: 0x42
function continueleaningatcovercondition(behaviortreeentity) {
    if (behaviortreeentity asmistransitionrunning()) {
        return 1;
    }
    return shouldleanatcovercondition(behaviortreeentity);
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x562801cd, Offset: 0x11c8
// Size: 0x7c
function coverleaninitialize(behaviortreeentity) {
    setcovershootstarttime(behaviortreeentity);
    keepclaimnode(behaviortreeentity);
    blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_lean");
    choosecoverdirection(behaviortreeentity);
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x98ea0a0e, Offset: 0x1250
// Size: 0x54
function coverleanterminate(behaviortreeentity) {
    choosefrontcoverdirection(behaviortreeentity);
    cleanupcovermode(behaviortreeentity);
    clearcovershootstarttime(behaviortreeentity);
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x2fef1789, Offset: 0x12b0
// Size: 0x1b4
function supportsovercovercondition(behaviortreeentity) {
    stance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
    if (isdefined(behaviortreeentity.node)) {
        if (!isinarray(getvalidcoverpeekouts(behaviortreeentity.node), "over")) {
            return false;
        }
        if (behaviortreeentity.node.type == "Cover Crouch" || behaviortreeentity.node.type == "Cover Crouch Window" || behaviortreeentity.node.type == "Cover Left" || behaviortreeentity.node.type == "Cover Right" || behaviortreeentity.node.type == "Conceal Crouch") {
            if (stance == "crouch") {
                return true;
            }
        } else if (behaviortreeentity.node.type == "Cover Stand" || behaviortreeentity.node.type == "Conceal Stand") {
            if (stance == "stand") {
                return true;
            }
        }
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xf1209478, Offset: 0x1470
// Size: 0x1f2
function shouldoveratcovercondition(entity) {
    if (!isdefined(entity.node) || !isdefined(entity.node.type) || !isdefined(entity.enemy) || !isdefined(entity.enemy.origin)) {
        return false;
    }
    aimtable = iscoverconcealed(entity.node) ? "cover_concealed_over" : "cover_over";
    aimlimitsforcover = entity getaimlimitsfromentry(aimtable);
    yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
    legalaimyaw = yawtoenemyposition >= aimlimitsforcover["aim_right"] - 10 && yawtoenemyposition <= aimlimitsforcover["aim_left"] + 10;
    if (!legalaimyaw) {
        return false;
    }
    pitchtoenemyposition = getaimpitchtoenemyfromnode(entity, entity.node, entity.enemy);
    legalaimpitch = pitchtoenemyposition >= aimlimitsforcover["aim_up"] + 10 && pitchtoenemyposition <= aimlimitsforcover["aim_down"] + 10;
    if (!legalaimpitch) {
        return false;
    }
    return true;
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x9f66328f, Offset: 0x1670
// Size: 0x64
function coveroverinitialize(behaviortreeentity) {
    setcovershootstarttime(behaviortreeentity);
    keepclaimnode(behaviortreeentity);
    blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_over");
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x30598ad9, Offset: 0x16e0
// Size: 0x3c
function coveroverterminate(behaviortreeentity) {
    cleanupcovermode(behaviortreeentity);
    clearcovershootstarttime(behaviortreeentity);
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x317799c8, Offset: 0x1728
// Size: 0x4c
function coveridleinitialize(behaviortreeentity) {
    keepclaimnode(behaviortreeentity);
    blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_alert");
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xd4cc29c4, Offset: 0x1780
// Size: 0x3c
function coveridleupdate(behaviortreeentity) {
    if (!behaviortreeentity asmistransitionrunning()) {
        releaseclaimnode(behaviortreeentity);
    }
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x3cbad582, Offset: 0x17c8
// Size: 0x3c
function coveridleterminate(behaviortreeentity) {
    releaseclaimnode(behaviortreeentity);
    cleanupcovermode(behaviortreeentity);
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xf3337e03, Offset: 0x1810
// Size: 0x6c
function isflankedbyenemyatcover(behaviortreeentity) {
    return canbeflanked(behaviortreeentity) && behaviortreeentity isatcovernodestrict() && behaviortreeentity isflankedatcovernode() && !behaviortreeentity haspath();
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x43c9e4ea, Offset: 0x1888
// Size: 0x24
function canbeflankedservice(behaviortreeentity) {
    setcanbeflanked(behaviortreeentity, 1);
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0x34b27321, Offset: 0x18b8
// Size: 0xd4
function coverflankedinitialize(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy)) {
        behaviortreeentity getperfectinfo(behaviortreeentity.enemy);
        behaviortreeentity pathmode("move delayed", 0, 2);
    }
    setcanbeflanked(behaviortreeentity, 0);
    cleanupcovermode(behaviortreeentity);
    keepclaimnode(behaviortreeentity);
    blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
}

// Namespace aiutility
// Params 1, eflags: 0x5 linked
// Checksum 0xc476c8e3, Offset: 0x1998
// Size: 0x34
function coverflankedactionterminate(behaviortreeentity) {
    behaviortreeentity.newenemyreaction = 0;
    releaseclaimnode(behaviortreeentity);
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x40ce1bf0, Offset: 0x19d8
// Size: 0x11e
function isatcrouchnode(behaviortreeentity) {
    if (behaviortreeentity.node.type == "Exposed" || behaviortreeentity.node.type == "Guard" || isdefined(behaviortreeentity.node) && behaviortreeentity.node.type == "Path") {
        if (distancesquared(behaviortreeentity.origin, behaviortreeentity.node.origin) <= 24 * 24) {
            return (!isstanceallowedatnode("stand", behaviortreeentity.node) && isstanceallowedatnode("crouch", behaviortreeentity.node));
        }
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xe95d1fce, Offset: 0x1b00
// Size: 0x54
function function_f09741fa(behaviortreeentity) {
    return behaviortreeentity isatcovernodestrict() && behaviortreeentity shouldusecovernode() && !behaviortreeentity haspath();
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xa8964d68, Offset: 0x1b60
// Size: 0x3c
function isatcoverstrictcondition(behaviortreeentity) {
    return behaviortreeentity isatcovernodestrict() && !behaviortreeentity haspath();
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x5ed99ea0, Offset: 0x1ba8
// Size: 0x44
function isatcovermodeover(behaviortreeentity) {
    covermode = blackboard::getblackboardattribute(behaviortreeentity, "_cover_mode");
    return covermode == "cover_over";
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x61592cae, Offset: 0x1bf8
// Size: 0x44
function isatcovermodenone(behaviortreeentity) {
    covermode = blackboard::getblackboardattribute(behaviortreeentity, "_cover_mode");
    return covermode == "cover_mode_none";
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xed85490d, Offset: 0x1c48
// Size: 0x3c
function isexposedatcovercondition(behaviortreeentity) {
    return behaviortreeentity isatcovernodestrict() && !behaviortreeentity shouldusecovernode();
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x80415f0e, Offset: 0x1c90
// Size: 0x72
function shouldcoveridleonly(behaviortreeentity) {
    if (behaviortreeentity ai::get_behavior_attribute("coverIdleOnly")) {
        return true;
    }
    if (isdefined(behaviortreeentity.node.script_onlyidle) && behaviortreeentity.node.script_onlyidle) {
        return true;
    }
    return false;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x6a05b019, Offset: 0x1d10
// Size: 0x28
function issuppressedatcovercondition(behaviortreeentity) {
    return behaviortreeentity.suppressionmeter > behaviortreeentity.suppressionthreshold;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x5d1ff9d, Offset: 0x1d40
// Size: 0x3c
function keepclaimednodeandchoosecoverdirection(behaviortreeentity) {
    keepclaimnode(behaviortreeentity);
    choosecoverdirection(behaviortreeentity);
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xd9a5c848, Offset: 0x1d88
// Size: 0x54
function resetcoverparameters(behaviortreeentity) {
    choosefrontcoverdirection(behaviortreeentity);
    cleanupcovermode(behaviortreeentity);
    clearcovershootstarttime(behaviortreeentity);
}

// Namespace aiutility
// Params 2, eflags: 0x1 linked
// Checksum 0x34827db8, Offset: 0x1de8
// Size: 0xac
function choosecoverdirection(behaviortreeentity, stepout) {
    if (!isdefined(behaviortreeentity.node)) {
        return;
    }
    coverdirection = blackboard::getblackboardattribute(behaviortreeentity, "_cover_direction");
    blackboard::setblackboardattribute(behaviortreeentity, "_previous_cover_direction", coverdirection);
    blackboard::setblackboardattribute(behaviortreeentity, "_cover_direction", calculatecoverdirection(behaviortreeentity, stepout));
}

// Namespace aiutility
// Params 2, eflags: 0x1 linked
// Checksum 0x34d777bd, Offset: 0x1ea0
// Size: 0x494
function calculatecoverdirection(behaviortreeentity, stepout) {
    if (isdefined(behaviortreeentity.treatallcoversasgeneric)) {
        if (!isdefined(stepout)) {
            stepout = 0;
        }
        coverdirection = "cover_front_direction";
        if (behaviortreeentity.node.type == "Cover Left") {
            if (isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 4) == 4 || math::cointoss() || stepout) {
                coverdirection = "cover_left_direction";
            }
        } else if (behaviortreeentity.node.type == "Cover Right") {
            if (isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 4) == 4 || math::cointoss() || stepout) {
                coverdirection = "cover_right_direction";
            }
        } else if (behaviortreeentity.node.type == "Cover Pillar") {
            if (isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 1024) == 1024) {
                return "cover_right_direction";
            }
            if (isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 2048) == 2048) {
                return "cover_left_direction";
            }
            coverdirection = "cover_left_direction";
            if (isdefined(behaviortreeentity.enemy)) {
                yawtoenemyposition = getaimyawtoenemyfromnode(behaviortreeentity, behaviortreeentity.node, behaviortreeentity.enemy);
                aimlimitsfordirectionright = behaviortreeentity getaimlimitsfromentry("pillar_right_lean");
                legalrightdirectionyaw = yawtoenemyposition >= aimlimitsfordirectionright["aim_right"] - 10 && yawtoenemyposition <= 0;
                if (legalrightdirectionyaw) {
                    coverdirection = "cover_right_direction";
                }
            }
        }
        return coverdirection;
    } else {
        coverdirection = "cover_front_direction";
        if (behaviortreeentity.node.type == "Cover Pillar") {
            if (isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 1024) == 1024) {
                return "cover_right_direction";
            }
            if (isdefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 2048) == 2048) {
                return "cover_left_direction";
            }
            coverdirection = "cover_left_direction";
            if (isdefined(behaviortreeentity.enemy)) {
                yawtoenemyposition = getaimyawtoenemyfromnode(behaviortreeentity, behaviortreeentity.node, behaviortreeentity.enemy);
                aimlimitsfordirectionright = behaviortreeentity getaimlimitsfromentry("pillar_right_lean");
                legalrightdirectionyaw = yawtoenemyposition >= aimlimitsfordirectionright["aim_right"] - 10 && yawtoenemyposition <= 0;
                if (legalrightdirectionyaw) {
                    coverdirection = "cover_right_direction";
                }
            }
        }
    }
    return coverdirection;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xba8f02c, Offset: 0x2340
// Size: 0x1a
function clearcovershootstarttime(behaviortreeentity) {
    behaviortreeentity.covershootstarttime = undefined;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x9ac73f53, Offset: 0x2368
// Size: 0x1c
function setcovershootstarttime(behaviortreeentity) {
    behaviortreeentity.covershootstarttime = gettime();
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0x7902730e, Offset: 0x2390
// Size: 0x2e
function canbeflanked(behaviortreeentity) {
    return isdefined(behaviortreeentity.canbeflanked) && behaviortreeentity.canbeflanked;
}

// Namespace aiutility
// Params 2, eflags: 0x1 linked
// Checksum 0xff7096cb, Offset: 0x23c8
// Size: 0x28
function setcanbeflanked(behaviortreeentity, canbeflanked) {
    behaviortreeentity.canbeflanked = canbeflanked;
}

// Namespace aiutility
// Params 1, eflags: 0x1 linked
// Checksum 0xb57632bd, Offset: 0x23f8
// Size: 0xec
function cleanupcovermode(behaviortreeentity) {
    if (function_f09741fa(behaviortreeentity)) {
        covermode = blackboard::getblackboardattribute(behaviortreeentity, "_cover_mode");
        blackboard::setblackboardattribute(behaviortreeentity, "_previous_cover_mode", covermode);
        blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_mode_none");
        return;
    }
    blackboard::setblackboardattribute(behaviortreeentity, "_previous_cover_mode", "cover_mode_none");
    blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_mode_none");
}

