#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/ai/archetype_cover_utility;
#using scripts/shared/ai/archetype_human_riotshield_interface;
#using scripts/shared/ai/systems/shared;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/spawner_shared;
#using scripts/shared/math_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/ai_shared;

#namespace namespace_a0beb106;

// Namespace namespace_a0beb106
// Params 0, eflags: 0x2
// Checksum 0xa139f5f, Offset: 0x560
// Size: 0x74
function main() {
    spawner::add_archetype_spawn_function("human_riotshield", &namespace_6e11afc3::function_bd56fc7d);
    spawner::add_archetype_spawn_function("human_riotshield", &namespace_4cdbfe2b::function_6cd135fd);
    namespace_6e11afc3::registerbehaviorscriptfunctions();
    namespace_cbd97d62::function_8f5cbafa();
}

#namespace namespace_6e11afc3;

// Namespace namespace_6e11afc3
// Params 0, eflags: 0x1 linked
// Checksum 0x399f3948, Offset: 0x5e0
// Size: 0x194
function registerbehaviorscriptfunctions() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldShouldTacticalWalk", &function_5e70f8d);
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldNonCombatLocomotionCondition", &function_97d02621);
    behaviortreenetworkutility::registerbehaviortreescriptapi("unarmedWalkAction", &function_6bf49b30);
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldTacticalWalkStart", &function_32695b48);
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldAdvanceOnEnemyService", &function_8ff24c5c);
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldShouldFlinch", &function_d32282d7);
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldIncrementFlinchCount", &function_23fe9c46);
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldClearFlinchCount", &function_64075986);
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldUnarmedTargetService", &function_e8d37bce);
    behaviortreenetworkutility::registerbehaviortreescriptapi("riotshieldUnarmedAdvanceOnEnemyService", &function_27823c66);
}

// Namespace namespace_6e11afc3
// Params 0, eflags: 0x5 linked
// Checksum 0xe0d85ede, Offset: 0x780
// Size: 0xf4
function function_bd56fc7d() {
    entity = self;
    blackboard::createblackboardforentity(entity);
    ai::createinterfaceforentity(entity);
    entity aiutility::function_89e1fc16();
    self.___archetypeonanimscriptedcallback = &function_b589481b;
    /#
        entity finalizetrackedblackboardattributes();
    #/
    blackboard::registerblackboardattribute(self, "_move_mode", "normal", &function_ef5bd70a);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("riotshieldClearFlinchCount");
        #/
    }
}

// Namespace namespace_6e11afc3
// Params 1, eflags: 0x5 linked
// Checksum 0x5cb4a3a3, Offset: 0x880
// Size: 0x34
function function_b589481b(entity) {
    entity.__blackboard = undefined;
    entity function_bd56fc7d();
}

// Namespace namespace_6e11afc3
// Params 0, eflags: 0x5 linked
// Checksum 0xca29d82, Offset: 0x8c0
// Size: 0x46
function function_ef5bd70a() {
    entity = self;
    if (entity ai::get_behavior_attribute("phalanx")) {
        return "marching";
    }
    return "normal";
}

// Namespace namespace_6e11afc3
// Params 1, eflags: 0x5 linked
// Checksum 0x2bb56f5a, Offset: 0x910
// Size: 0xc4
function function_d32282d7(entity) {
    if (entity haspath() && entity ai::get_behavior_attribute("phalanx")) {
        return true;
    }
    if (entity.damagelocation != "riotshield") {
        return false;
    }
    if (entity.damagelocation == "riotshield" && entity.var_33646074 >= 5 && entity.var_b6532634 + 1500 >= gettime()) {
        return false;
    }
    return true;
}

// Namespace namespace_6e11afc3
// Params 1, eflags: 0x5 linked
// Checksum 0xeb7efa1c, Offset: 0x9e0
// Size: 0x2c
function function_23fe9c46(entity) {
    entity.var_33646074++;
    entity.var_b6532634 = gettime();
}

// Namespace namespace_6e11afc3
// Params 1, eflags: 0x5 linked
// Checksum 0xe64dadaf, Offset: 0xa18
// Size: 0x2c
function function_64075986(entity) {
    entity.var_b6532634 = gettime();
    entity.var_33646074 = 0;
}

// Namespace namespace_6e11afc3
// Params 1, eflags: 0x5 linked
// Checksum 0x5854faad, Offset: 0xa50
// Size: 0x10
function function_5e70f8d(behaviortreeentity) {
    return true;
}

// Namespace namespace_6e11afc3
// Params 1, eflags: 0x5 linked
// Checksum 0x6d867ab7, Offset: 0xa68
// Size: 0x70
function function_97d02621(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy)) {
        if (distancesquared(behaviortreeentity.origin, behaviortreeentity lastknownpos(behaviortreeentity.enemy)) > 490000) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_6e11afc3
// Params 1, eflags: 0x5 linked
// Checksum 0x279d9f40, Offset: 0xae0
// Size: 0x38e
function function_8ff24c5c(behaviortreeentity) {
    itsbeenawhile = gettime() > behaviortreeentity.nextfindbestcovertime;
    isatscriptgoal = behaviortreeentity isatgoal();
    var_89889720 = 0;
    if (behaviortreeentity ai::get_behavior_attribute("phalanx")) {
        return false;
    }
    if (isdefined(behaviortreeentity.var_3100f1e7)) {
        dist_sq = distancesquared(behaviortreeentity.origin, behaviortreeentity.var_3100f1e7.origin);
        if (dist_sq < 256) {
            if (!isdefined(behaviortreeentity.var_15f999a3)) {
                behaviortreeentity.var_15f999a3 = gettime();
            }
        }
    }
    if (isdefined(behaviortreeentity.var_15f999a3)) {
        if (gettime() - behaviortreeentity.var_15f999a3 > behaviortreeentity.var_30eff5f9) {
            var_89889720 = 1;
            behaviortreeentity.var_15f999a3 = undefined;
        }
    }
    shouldlookforbettercover = itsbeenawhile || !isatscriptgoal || var_89889720;
    if (shouldlookforbettercover && isdefined(behaviortreeentity.enemy)) {
        closestrandomnode = undefined;
        var_82379626 = behaviortreeentity findbestcovernodes(behaviortreeentity.goalradius, behaviortreeentity.goalpos);
        foreach (node in var_82379626) {
            if (isdefined(behaviortreeentity.var_3100f1e7) && behaviortreeentity.var_3100f1e7 == node) {
                continue;
            }
            if (aiutility::getcovertype(node) == "cover_exposed") {
                closestrandomnode = node;
                break;
            }
        }
        if (!isdefined(closestrandomnode)) {
            closestrandomnode = var_82379626[0];
        }
        if (isdefined(closestrandomnode) && behaviortreeentity findpath(behaviortreeentity.origin, closestrandomnode.origin, 1, 0)) {
            aiutility::releaseclaimnode(behaviortreeentity);
            aiutility::usecovernodewrapper(behaviortreeentity, closestrandomnode);
            behaviortreeentity.var_3100f1e7 = closestrandomnode;
            behaviortreeentity.var_30eff5f9 = randomintrange(behaviortreeentity.var_5147db9, behaviortreeentity.var_5fba5c47);
            behaviortreeentity.var_15f999a3 = undefined;
            return true;
        }
    }
    return false;
}

// Namespace namespace_6e11afc3
// Params 1, eflags: 0x5 linked
// Checksum 0xbd03ad94, Offset: 0xe78
// Size: 0x84
function function_32695b48(behaviortreeentity) {
    aiutility::resetcoverparameters(behaviortreeentity);
    aiutility::setcanbeflanked(behaviortreeentity, 0);
    blackboard::setblackboardattribute(behaviortreeentity, "_stance", "stand");
    behaviortreeentity orientmode("face enemy");
}

// Namespace namespace_6e11afc3
// Params 1, eflags: 0x5 linked
// Checksum 0x82351f01, Offset: 0xf08
// Size: 0x31c
function function_e8d37bce(behaviortreeentity) {
    if (!aiutility::shouldmutexmelee(behaviortreeentity)) {
        return false;
    }
    enemies = [];
    ai = getaiarray();
    foreach (index, value in ai) {
        if (value.team != behaviortreeentity.team && isactor(value)) {
            enemies[enemies.size] = value;
        }
    }
    if (enemies.size > 0) {
        closestenemy = undefined;
        closestenemydistance = 0;
        for (index = 0; index < enemies.size; index++) {
            enemy = enemies[index];
            enemydistance = distancesquared(behaviortreeentity.origin, enemy.origin);
            var_874bdbed = 0;
            if (enemydistance > behaviortreeentity.goalradius * behaviortreeentity.goalradius) {
                continue;
            }
            if (!isdefined(enemy.var_158ff9b3) || enemy.var_158ff9b3 == behaviortreeentity) {
                var_874bdbed = 1;
            } else {
                targetdistance = distancesquared(enemy.var_158ff9b3.origin, enemy.origin);
                if (enemydistance < targetdistance) {
                    var_874bdbed = 1;
                }
            }
            if (var_874bdbed) {
                if (!isdefined(closestenemy) || enemydistance < closestenemydistance) {
                    closestenemydistance = enemydistance;
                    closestenemy = enemy;
                }
            }
        }
        if (isdefined(behaviortreeentity.favoriteenemy)) {
            behaviortreeentity.favoriteenemy.var_158ff9b3 = undefined;
        }
        behaviortreeentity.favoriteenemy = closestenemy;
        if (isdefined(behaviortreeentity.favoriteenemy)) {
            behaviortreeentity.favoriteenemy.var_158ff9b3 = behaviortreeentity;
        }
        return true;
    }
    return false;
}

// Namespace namespace_6e11afc3
// Params 1, eflags: 0x5 linked
// Checksum 0x11bcfcc0, Offset: 0x1230
// Size: 0x13e
function function_27823c66(behaviortreeentity) {
    if (gettime() < behaviortreeentity.nextfindbestcovertime) {
        return false;
    }
    if (isdefined(behaviortreeentity.favoriteenemy)) {
        /#
            recordline(behaviortreeentity.favoriteenemy.origin, behaviortreeentity.origin, (1, 0.5, 0), "riotshieldClearFlinchCount", behaviortreeentity);
        #/
        enemydistance = distancesquared(behaviortreeentity.favoriteenemy.origin, behaviortreeentity.origin);
        if (enemydistance < behaviortreeentity.goalradius * behaviortreeentity.goalradius) {
            behaviortreeentity useposition(behaviortreeentity.favoriteenemy.origin);
            return true;
        }
    }
    behaviortreeentity clearuseposition();
    return false;
}

// Namespace namespace_6e11afc3
// Params 1, eflags: 0x5 linked
// Checksum 0x273d3683, Offset: 0x1378
// Size: 0x54
function function_6bf49b30(behaviortreeentity) {
    blackboard::setblackboardattribute(behaviortreeentity, "_stance", "stand");
    behaviortreeentity orientmode("face enemy");
}

// Namespace namespace_6e11afc3
// Params 8, eflags: 0x5 linked
// Checksum 0xcf029325, Offset: 0x13d8
// Size: 0x70
function function_f6b6cd67(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, offsettime) {
    entity = self;
    aiutility::dropriotshield(entity);
    return damage;
}

// Namespace namespace_6e11afc3
// Params 12, eflags: 0x5 linked
// Checksum 0xdc26b4e2, Offset: 0x1450
// Size: 0xf8
function function_b12197(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex) {
    entity = self;
    if (shitloc == "riotshield") {
        function_23fe9c46(entity);
        entity.health += 1;
        return 1;
    }
    if (sweapon.name == "incendiary_grenade") {
        idamage = entity.health;
    }
    return idamage;
}

#namespace namespace_4cdbfe2b;

// Namespace namespace_4cdbfe2b
// Params 0, eflags: 0x1 linked
// Checksum 0x8c52bd32, Offset: 0x1550
// Size: 0xe4
function function_6cd135fd() {
    entity = self;
    aiutility::attachriotshield(entity, getweapon("riotshield"), "wpn_t7_shield_riot_world_lh", "tag_weapon_left");
    entity.var_5147db9 = 2500;
    entity.var_5fba5c47 = 5000;
    entity.ignorerunandgundist = 1;
    aiutility::addaioverridedamagecallback(entity, &namespace_6e11afc3::function_b12197);
    aiutility::addaioverridekilledcallback(entity, &namespace_6e11afc3::function_f6b6cd67);
    namespace_6e11afc3::function_64075986(entity);
}

