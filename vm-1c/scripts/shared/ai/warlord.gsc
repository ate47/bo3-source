#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/ai_blackboard;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/util_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/math_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/ai_shared;

#namespace warlord;

// Namespace warlord
// Params 0, eflags: 0x2
// Checksum 0x297f0d08, Offset: 0x728
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("warlord", &__init__, undefined, undefined);
}

// Namespace warlord
// Params 0, eflags: 0x1 linked
// Checksum 0x4cc9924b, Offset: 0x768
// Size: 0x13c
function __init__() {
    spawner::add_archetype_spawn_function("warlord", &namespace_c7ab8fce::function_ad72c974);
    spawner::add_archetype_spawn_function("warlord", &namespace_b4645fec::function_b65f3cc0);
    if (ai::shouldregisterclientfieldforarchetype("warlord")) {
        clientfield::register("actor", "warlord_damage_state", 1, 2, "int");
        clientfield::register("actor", "warlord_thruster_direction", 1, 3, "int");
        clientfield::register("actor", "warlord_type", 1, 2, "int");
        clientfield::register("actor", "warlord_lights_state", 1, 1, "int");
    }
    namespace_69ee7109::function_65180251();
}

#namespace namespace_c7ab8fce;

// Namespace namespace_c7ab8fce
// Params 0, eflags: 0x2
// Checksum 0x8b1e11dc, Offset: 0x8b0
// Size: 0x1ac
function autoexec registerbehaviorscriptfunctions() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("warlordCanJukeCondition", &function_80e7735);
    behaviortreenetworkutility::registerbehaviortreescriptapi("warlordCanTacticalJukeCondition", &function_f663699c);
    behaviortreenetworkutility::registerbehaviortreescriptapi("warlordShouldBeAngryCondition", &function_cb636409);
    behaviortreenetworkutility::registerbehaviortreescriptapi("warlordShouldNormalMelee", &function_c532c1b0);
    behaviortreenetworkutility::registerbehaviortreescriptapi("warlordCanTakePainCondition", &function_47cb87ef);
    behaviortreenetworkutility::registerbehaviortreescriptapi("warlordExposedPainActionStart", &function_a778e8e3);
    behaviortreenetworkutility::registerbehaviortreeaction("warlordDeathAction", &function_5e6a5213, undefined, undefined);
    behaviortreenetworkutility::registerbehaviortreeaction("warlordJukeAction", &function_296ed07c, undefined, &function_4daf9b71);
    behaviortreenetworkutility::registerbehaviortreescriptapi("chooseBetterPositionService", &function_655ad686);
    behaviortreenetworkutility::registerbehaviortreescriptapi("WarlordAngryAttack", &function_9de5522f);
}

// Namespace namespace_c7ab8fce
// Params 0, eflags: 0x5 linked
// Checksum 0x66861b70, Offset: 0xa68
// Size: 0x7c
function private function_ad72c974() {
    blackboard::createblackboardforentity(self);
    ai::createinterfaceforentity(self);
    self aiutility::function_89e1fc16();
    self.___archetypeonanimscriptedcallback = &function_327511a;
    /#
        self finalizetrackedblackboardattributes();
    #/
}

// Namespace namespace_c7ab8fce
// Params 1, eflags: 0x5 linked
// Checksum 0x725e3da9, Offset: 0xaf0
// Size: 0x34
function private function_327511a(entity) {
    entity.__blackboard = undefined;
    entity function_ad72c974();
}

// Namespace namespace_c7ab8fce
// Params 1, eflags: 0x5 linked
// Checksum 0x6819054a, Offset: 0xb30
// Size: 0x50
function private function_5a83bc0a(entity) {
    if (isdefined(entity.enemy) && isdefined(entity.var_ce767dbd) && gettime() < entity.var_ce767dbd) {
        return true;
    }
    return false;
}

// Namespace namespace_c7ab8fce
// Params 1, eflags: 0x5 linked
// Checksum 0x310dc509, Offset: 0xb88
// Size: 0x3ac
function private function_9b66e9bc(entity) {
    /#
        namespace_e585b400::function_3f561bff(entity, 3, 1);
    #/
    if (distance2dsquared(entity.origin, self lastknownpos(self.enemy)) <= -6 * -6) {
        return false;
    }
    if (isdefined(entity.var_c9cd0861) && gettime() < entity.var_c9cd0861) {
        return false;
    }
    if (entity.var_b654f978) {
        /#
            namespace_e585b400::function_3d68d6d1(3, (1, 0, 1), "warlordCanTacticalJukeCondition");
        #/
        return false;
    }
    positiononnavmesh = getclosestpointonnavmesh(self lastknownpos(self.enemy), -56);
    if (!isdefined(positiononnavmesh)) {
        positiononnavmesh = self lastknownpos(self.enemy);
    }
    queryresult = positionquery_source_navigation(positiononnavmesh, -106, -6, 45, 36, entity, 36);
    positionquery_filter_inclaimedlocation(queryresult, entity);
    positionquery_filter_distancetogoal(queryresult, entity);
    if (queryresult.data.size > 0) {
        closestpoint = undefined;
        closestdistance = undefined;
        foreach (point in queryresult.data) {
            if (!point.inclaimedlocation && point.disttogoal == 0) {
                newclosestdistance = distance2dsquared(entity.origin, point.origin);
                if (!isdefined(closestpoint) || newclosestdistance < closestdistance) {
                    closestpoint = point.origin;
                    closestdistance = newclosestdistance;
                }
            }
        }
        if (isdefined(closestpoint)) {
            /#
                namespace_e585b400::function_4160d34d(entity, 3, 1);
            #/
            entity useposition(closestpoint);
            entity.var_c9cd0861 = gettime() + randomintrange(500, 1500);
            return true;
        }
    }
    /#
        namespace_e585b400::function_c2db5ca5(entity, 3);
    #/
    entity.var_ce767dbd = undefined;
    return false;
}

// Namespace namespace_c7ab8fce
// Params 1, eflags: 0x1 linked
// Checksum 0xb162a48f, Offset: 0xf40
// Size: 0x1284
function function_655ad686(entity) {
    if (entity asmistransitionrunning() || entity getbehaviortreestatus() != 5 || entity asmissubstatepending() || entity asmistransdecrunning()) {
        return 0;
    }
    shouldrepath = 0;
    var_cb05c034 = 0;
    searchorigin = undefined;
    var_976ace1e = entity isapproachinggoal();
    if (!var_976ace1e) {
        namespace_b4645fec::function_e4f394f5(entity);
        /#
            namespace_e585b400::function_4160d34d(entity, 6);
        #/
        if (isdefined(entity.goalent) || entity.goalradius < 72) {
            var_e972a672 = getclosestpointonnavmesh(self.goalpos, -56);
            if (!isdefined(var_e972a672)) {
                var_e972a672 = self.goalpos;
            }
            entity useposition(var_e972a672);
            return 1;
        }
    }
    if (var_976ace1e && function_5a83bc0a(entity)) {
        return function_9b66e9bc(entity);
    } else if (var_976ace1e && namespace_b4645fec::function_69380127(entity)) {
        return 1;
    } else if (isdefined(entity.lastenemysightpos) && !namespace_b4645fec::function_d55b9558(entity)) {
        searchorigin = entity.lastenemysightpos;
    } else {
        /#
            entity namespace_e585b400::function_3d68d6d1(undefined, (1, 0, 0), "warlordCanTacticalJukeCondition");
        #/
        searchorigin = entity.goalpos;
    }
    if (isdefined(searchorigin)) {
        searchorigin = getclosestpointonnavmesh(searchorigin, -56);
    }
    if (!isdefined(searchorigin)) {
        return 0;
    }
    if (!var_976ace1e || !isdefined(entity.var_26ca18bb) || gettime() > entity.var_26ca18bb) {
        shouldrepath = 1;
    }
    if (isdefined(entity.enemy) && !entity seerecently(entity.enemy, 2) && isdefined(entity.lastenemysightpos)) {
        /#
            entity namespace_e585b400::function_3d68d6d1(undefined, (1, 1, 1), "warlordCanTacticalJukeCondition");
        #/
        var_cb05c034 = 1;
        if (isdefined(entity.pathgoalpos)) {
            distancetogoalsqr = distancesquared(searchorigin, entity.pathgoalpos);
            if (distancetogoalsqr < -56 * -56) {
                shouldrepath = 0;
            }
        } else {
            shouldrepath = 1;
        }
    }
    if (!shouldrepath) {
        if (isdefined(entity.var_ecf7b5b1)) {
            entity.var_ecf7b5b1 = undefined;
            shouldrepath = 1;
        }
    }
    if (shouldrepath) {
        queryresult = positionquery_source_navigation(searchorigin, 0, entity.engagemaxdist, 45, 72, entity, 72);
        positionquery_filter_inclaimedlocation(queryresult, entity);
        positionquery_filter_distancetogoal(queryresult, entity);
        if (isdefined(entity.var_568222a9) && isdefined(entity.enemy) && var_cb05c034 && entity.var_568222a9) {
            positionquery_filter_sight(queryresult, self lastknownpos(self.enemy), self geteye() - self.origin, self, 20);
        }
        var_e84d15a1 = [];
        randompoints = [];
        var_20e1d4f5 = 0;
        var_8259f71c = 0;
        var_1d39aec2 = 0;
        var_c713e0ba = 36;
        foreach (point in queryresult.data) {
            if (point.inclaimedlocation) {
                continue;
            }
            var_20e1d4f5++;
            if (point.disttogoal > 0) {
                continue;
            }
            var_8259f71c++;
            if (isdefined(point.visibility) && !point.visibility) {
                continue;
            }
            var_1d39aec2++;
            if (point.disttoorigin2d < var_c713e0ba) {
                continue;
            }
            randompoints[randompoints.size] = point.origin;
        }
        if (!(isdefined(entity.var_568222a9) && isdefined(entity.enemy) && var_cb05c034 && entity.var_568222a9)) {
            var_e84d15a1 = namespace_b4645fec::function_78670b61(entity);
        }
        if (randompoints.size == 0 && var_e84d15a1.size == 0) {
            if (var_20e1d4f5 == 0) {
                return 0;
            } else if (var_8259f71c == 0) {
                var_fe3237cf = entity.goalpos + vectornormalize(searchorigin - entity.goalpos) * entity.goalradius;
                queryresult = positionquery_source_navigation(var_fe3237cf, 0, entity.engagemaxdist, 45, 72, entity, 108);
                positionquery_filter_inclaimedlocation(queryresult, entity);
                positionquery_filter_distancetogoal(queryresult, entity);
                var_20e1d4f5 = 0;
                var_8259f71c = 0;
                var_1d39aec2 = 0;
                foreach (point in queryresult.data) {
                    if (point.inclaimedlocation) {
                        continue;
                    }
                    var_20e1d4f5++;
                    if (point.disttogoal > 0) {
                        continue;
                    }
                    var_8259f71c++;
                    if (isdefined(point.visibility) && !point.visibility) {
                        continue;
                    }
                    var_1d39aec2++;
                    if (point.disttoorigin2d < var_c713e0ba) {
                        continue;
                    }
                    randompoints[randompoints.size] = point.origin;
                }
                if (randompoints.size == 0) {
                    foreach (point in queryresult.data) {
                        if (point.inclaimedlocation) {
                            continue;
                        }
                        if (point.disttogoal > 0) {
                            continue;
                        }
                        if (var_1d39aec2 > 0 && isdefined(point.visibility) && !point.visibility) {
                            continue;
                        }
                        randompoints[randompoints.size] = point.origin;
                    }
                }
            } else {
                foreach (point in queryresult.data) {
                    if (point.inclaimedlocation) {
                        continue;
                    }
                    if (point.disttogoal > 0) {
                        continue;
                    }
                    if (var_1d39aec2 > 0 && isdefined(point.visibility) && !point.visibility) {
                        continue;
                    }
                    randompoints[randompoints.size] = point.origin;
                }
            }
            if (randompoints.size == 0) {
                if (!var_976ace1e) {
                    if (!isdefined(randompoints)) {
                        randompoints = [];
                    } else if (!isarray(randompoints)) {
                        randompoints = array(randompoints);
                    }
                    randompoints[randompoints.size] = entity.goalpos;
                } else {
                    /#
                        namespace_e585b400::function_c2db5ca5(entity, 5);
                    #/
                    return 0;
                }
            }
        }
        goalweight = -10000;
        var_c3fc0358 = entity.engageminfalloffdist * entity.engageminfalloffdist;
        var_4b54d64a = entity.engagemindist * entity.engagemindist;
        var_c9068104 = entity.engagemaxdist * entity.engagemaxdist;
        var_a3945c26 = entity.engagemaxfalloffdist * entity.engagemaxfalloffdist;
        if (isdefined(entity.enemy) && issentient(entity.enemy)) {
            var_7b1a8986 = vectornormalize(anglestoforward(entity.enemy.angles));
        }
        for (index = 0; index < randompoints.size; index++) {
            var_ec0332d3 = distance2dsquared(randompoints[index], searchorigin);
            var_6c2b207a = 1;
            if (isdefined(entity.var_568222a9) && (isdefined(var_cb05c034) || entity.var_568222a9)) {
                var_6c2b207a = -1;
            }
            var_1fe6d199 = 0;
            if (var_ec0332d3 < var_c3fc0358) {
                var_1fe6d199 = -1 * var_6c2b207a;
            } else if (var_ec0332d3 < var_4b54d64a) {
                var_1fe6d199 = -0.5 * var_6c2b207a;
            } else if (var_ec0332d3 > var_a3945c26) {
                var_1fe6d199 = 1 * var_6c2b207a;
            } else if (var_ec0332d3 > var_c9068104) {
                var_1fe6d199 = 1 * var_6c2b207a;
            }
            if (isdefined(var_7b1a8986)) {
                var_f8b1c22d = acos(math::clamp(vectordot(vectornormalize(var_1fe6d199 - entity.enemy.origin), var_7b1a8986), -1, 1));
                if (var_f8b1c22d > 80) {
                    var_1fe6d199 += -0.5;
                }
            }
            var_1fe6d199 += randomfloatrange(-0.25, 0.25);
            if (goalweight < var_1fe6d199) {
                goalweight = var_1fe6d199;
                goalposition = randompoints[index];
            }
            /#
                if (getdvarint("warlordCanTacticalJukeCondition") > 0 && isdefined(getentbynum(getdvarint("warlordCanTacticalJukeCondition"))) && entity == getentbynum(getdvarint("warlordCanTacticalJukeCondition"))) {
                    as_debug::debugdrawweightedpoint(entity, randompoints[index], var_1fe6d199, -1.25, 1.75);
                }
            #/
        }
        var_cfb305f0 = goalweight;
        foreach (point in var_e84d15a1) {
            if (point === entity.var_541cb3cf) {
                continue;
            }
            var_1fe6d199 = randomfloatrange(var_cfb305f0 - 0.25, var_cfb305f0 + 0.5);
            if (goalweight < var_1fe6d199) {
                goalweight = var_1fe6d199;
                goalposition = point.origin;
                var_34862dbe = point;
            }
            /#
                if (getdvarint("warlordCanTacticalJukeCondition") > 0 && isdefined(getentbynum(getdvarint("warlordCanTacticalJukeCondition"))) && entity == getentbynum(getdvarint("warlordCanTacticalJukeCondition"))) {
                    as_debug::debugdrawweightedpoint(entity, point.origin, var_1fe6d199, -1.25, 1.75);
                }
            #/
        }
        if (isdefined(goalposition)) {
            if (entity findpath(entity.origin, goalposition, 1, 0)) {
                entity useposition(goalposition);
                entity.var_26ca18bb = gettime() + entity.coversearchinterval;
                if (isdefined(var_34862dbe)) {
                    /#
                        namespace_e585b400::function_4160d34d(entity, 4);
                    #/
                    namespace_b4645fec::function_29afe468(entity, var_34862dbe);
                }
                /#
                    if (!isdefined(var_34862dbe)) {
                        namespace_e585b400::function_4160d34d(entity, 5);
                    }
                #/
                return 1;
            }
        }
    }
    return 0;
}

// Namespace namespace_c7ab8fce
// Params 1, eflags: 0x1 linked
// Checksum 0xe169c2f2, Offset: 0x21d0
// Size: 0x4a
function function_80e7735(behaviortreeentity) {
    if (isdefined(behaviortreeentity.var_b948f7a) && gettime() < behaviortreeentity.var_b948f7a) {
        return 0;
    }
    return namespace_b4645fec::function_96271879(behaviortreeentity);
}

// Namespace namespace_c7ab8fce
// Params 1, eflags: 0x1 linked
// Checksum 0x4e3031fe, Offset: 0x2228
// Size: 0x4a
function function_f663699c(behaviortreeentity) {
    if (isdefined(behaviortreeentity.var_b948f7a) && gettime() < behaviortreeentity.var_b948f7a) {
        return 0;
    }
    return namespace_b4645fec::function_34d050ea(behaviortreeentity);
}

// Namespace namespace_c7ab8fce
// Params 1, eflags: 0x1 linked
// Checksum 0xac318479, Offset: 0x2280
// Size: 0x298
function function_c532c1b0(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemy) && !(isdefined(behaviortreeentity.enemy.allowdeath) && behaviortreeentity.enemy.allowdeath)) {
        return false;
    }
    if (aiutility::function_90d01729(behaviortreeentity) && !isalive(behaviortreeentity.enemy)) {
        return false;
    }
    if (!issentient(behaviortreeentity.enemy)) {
        return false;
    }
    if (isvehicle(behaviortreeentity.enemy) && !(isdefined(behaviortreeentity.enemy.good_melee_target) && behaviortreeentity.enemy.good_melee_target)) {
        return false;
    }
    if (!aiutility::shouldmutexmelee(behaviortreeentity)) {
        return false;
    }
    if (behaviortreeentity ai::has_behavior_attribute("can_melee") && !behaviortreeentity ai::get_behavior_attribute("can_melee")) {
        return false;
    }
    if (behaviortreeentity.enemy ai::has_behavior_attribute("can_be_meleed") && !behaviortreeentity.enemy ai::get_behavior_attribute("can_be_meleed")) {
        return false;
    }
    if (!isplayer(behaviortreeentity.enemy) && !(isdefined(behaviortreeentity.enemy.magic_bullet_shield) && behaviortreeentity.enemy.magic_bullet_shield)) {
        return false;
    }
    if (aiutility::hascloseenemytomeleewithrange(behaviortreeentity, 100 * 100)) {
        if (namespace_b4645fec::function_54978bb4(behaviortreeentity.enemy)) {
            namespace_b4645fec::function_c17a57a6(behaviortreeentity);
            return false;
        }
        return true;
    }
    return false;
}

// Namespace namespace_c7ab8fce
// Params 1, eflags: 0x1 linked
// Checksum 0x4e15c437, Offset: 0x2520
// Size: 0x1c
function function_47cb87ef(behaviortreeentity) {
    return gettime() >= behaviortreeentity.var_2ac908f2;
}

// Namespace namespace_c7ab8fce
// Params 2, eflags: 0x1 linked
// Checksum 0x5c456c57, Offset: 0x2548
// Size: 0x1c0
function function_296ed07c(behaviortreeentity, asmstatename) {
    if (namespace_b4645fec::function_d55b9558(behaviortreeentity)) {
        var_b948f7a = 1000;
    } else {
        var_b948f7a = 3000;
    }
    behaviortreeentity.var_b948f7a = gettime() + var_b948f7a;
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    jukedirection = blackboard::getblackboardattribute(behaviortreeentity, "_juke_direction");
    switch (jukedirection) {
    case 20:
        clientfield::set("warlord_thruster_direction", 4);
        break;
    case 21:
        clientfield::set("warlord_thruster_direction", 3);
        break;
    }
    behaviortreeentity clearpath();
    jukeinfo = spawnstruct();
    jukeinfo.origin = behaviortreeentity.origin;
    jukeinfo.entity = behaviortreeentity;
    blackboard::addblackboardevent("actor_juke", jukeinfo, 2000);
    jukeinfo.entity playsound("fly_jetpack_juke_warlord");
    return 5;
}

// Namespace namespace_c7ab8fce
// Params 2, eflags: 0x1 linked
// Checksum 0xfdcc7ffa, Offset: 0x2710
// Size: 0xb0
function function_4daf9b71(behaviortreeentity, asmstatename) {
    blackboard::setblackboardattribute(behaviortreeentity, "_juke_direction", undefined);
    clientfield::set("warlord_thruster_direction", 0);
    positiononnavmesh = getclosestpointonnavmesh(behaviortreeentity.origin, -56);
    if (!isdefined(positiononnavmesh)) {
        positiononnavmesh = behaviortreeentity.origin;
    }
    behaviortreeentity useposition(positiononnavmesh);
    return 4;
}

// Namespace namespace_c7ab8fce
// Params 2, eflags: 0x1 linked
// Checksum 0x5e96bec8, Offset: 0x27c8
// Size: 0x50
function function_5e6a5213(behaviortreeentity, asmstatename) {
    clientfield::set("warlord_damage_state", 3);
    animationstatenetworkutility::requeststate(behaviortreeentity, asmstatename);
    return 5;
}

// Namespace namespace_c7ab8fce
// Params 1, eflags: 0x1 linked
// Checksum 0xfa8d1e45, Offset: 0x2820
// Size: 0x54
function function_a778e8e3(behaviortreeentity) {
    behaviortreeentity.var_2ac908f2 = gettime() + randomintrange(500, 2500);
    aiutility::keepclaimnode(behaviortreeentity);
}

// Namespace namespace_c7ab8fce
// Params 1, eflags: 0x1 linked
// Checksum 0xf09d1caa, Offset: 0x2880
// Size: 0x12a
function function_cb636409(behaviortreeentity) {
    if (isdefined(behaviortreeentity.var_1fe9366e) && gettime() < behaviortreeentity.var_1fe9366e) {
        return 0;
    }
    if (!isdefined(behaviortreeentity.var_84bdb4be) || behaviortreeentity.var_84bdb4be.size == 0) {
        return 0;
    } else if (behaviortreeentity.var_84bdb4be.size == 1 && isdefined(behaviortreeentity.enemy) && behaviortreeentity.var_84bdb4be[0].attacker == behaviortreeentity.enemy) {
        return 0;
    }
    if (isdefined(behaviortreeentity.var_9366282a) && behaviortreeentity.var_9366282a > namespace_b4645fec::function_5f046d4(-56, 1.5, 2, 2.5)) {
        return 1;
    }
    return behaviortreeentity.var_b654f978;
}

// Namespace namespace_c7ab8fce
// Params 1, eflags: 0x1 linked
// Checksum 0xf2d3e11f, Offset: 0x29b8
// Size: 0x2e0
function function_9de5522f(entity) {
    /#
        namespace_e585b400::function_3d68d6d1(1, (0, 1, 0), "warlordCanTacticalJukeCondition");
    #/
    entity.var_b654f978 = 1;
    entity.forcefire = 1;
    entity.var_9366282a = 0;
    entity.var_1fe9366e = gettime() + 13000;
    namespace_b4645fec::function_af40242(entity);
    var_7d0a379a = [];
    for (i = 0; i < entity.var_84bdb4be.size; i++) {
        for (j = i + 1; j < entity.var_84bdb4be.size; j++) {
            if (entity.var_84bdb4be[i].threat < entity.var_84bdb4be[j].threat) {
                tmp = entity.var_84bdb4be[j].threat;
                entity.var_84bdb4be[j].threat = entity.var_84bdb4be[i].threat;
                entity.var_84bdb4be[i].threat = tmp;
            }
        }
    }
    foreach (data in entity.var_84bdb4be) {
        if (!isdefined(var_7d0a379a)) {
            var_7d0a379a = [];
        } else if (!isarray(var_7d0a379a)) {
            var_7d0a379a = array(var_7d0a379a);
        }
        var_7d0a379a[var_7d0a379a.size] = data.attacker;
    }
    thread function_c698ce8a(entity, var_7d0a379a);
    return true;
}

// Namespace namespace_c7ab8fce
// Params 2, eflags: 0x1 linked
// Checksum 0xc6cc73fa, Offset: 0x2ca0
// Size: 0x14c
function function_c698ce8a(entity, var_7d0a379a) {
    entity endon(#"disconnect");
    entity endon(#"death");
    entity notify(#"hash_b160390f");
    shoottime = getdvarfloat("warlordangryattack", 3);
    foreach (attacker in var_7d0a379a) {
        if (isdefined(attacker)) {
            entity ai::shoot_at_target("normal", attacker, undefined, shoottime, undefined, 1);
        }
    }
    /#
        namespace_e585b400::function_3d68d6d1(1, (0, 0, 1), "warlordCanTacticalJukeCondition");
    #/
    entity.forcefire = 0;
    entity.var_b654f978 = 0;
}

#namespace namespace_b4645fec;

// Namespace namespace_b4645fec
// Params 1, eflags: 0x0
// Checksum 0xcad3d077, Offset: 0x2df8
// Size: 0x52
function function_a7bb7dfd(entity) {
    if (entity.team == "allies") {
        return level.alivecount["axis"];
    }
    return level.alivecount["allies"];
}

// Namespace namespace_b4645fec
// Params 2, eflags: 0x1 linked
// Checksum 0x3aa3d7c8, Offset: 0x2e58
// Size: 0x15a
function function_13ed0a8b(entity, var_ef60116) {
    entity.var_568222a9 = var_ef60116;
    if (isdefined(var_ef60116) && var_ef60116) {
        foreach (player in level.players) {
            entity setpersonalthreatbias(player, 1000);
        }
        return;
    }
    foreach (player in level.players) {
        entity setpersonalthreatbias(player, 0, 1);
    }
}

// Namespace namespace_b4645fec
// Params 5, eflags: 0x1 linked
// Checksum 0xe8d220cf, Offset: 0x2fc0
// Size: 0x1d6
function function_da308a83(entity, position, min_duration, max_duration, name) {
    positiononnavmesh = getclosestpointonnavmesh(position, -56, 25);
    if (!isdefined(positiononnavmesh)) {
        println("warlordCanTacticalJukeCondition" + position);
        return;
    } else {
        position = positiononnavmesh;
    }
    if (!entity isposatgoal(position)) {
        println("warlordCanTacticalJukeCondition" + position);
    }
    point = spawnstruct();
    point.origin = position;
    point.min_duration = min_duration;
    point.max_duration = max_duration;
    point.name = name;
    if (!isdefined(entity.var_a3fbe34e)) {
        entity.var_a3fbe34e = [];
    } else if (!isarray(entity.var_a3fbe34e)) {
        entity.var_a3fbe34e = array(entity.var_a3fbe34e);
    }
    entity.var_a3fbe34e[entity.var_a3fbe34e.size] = point;
}

// Namespace namespace_b4645fec
// Params 2, eflags: 0x1 linked
// Checksum 0x1f35d680, Offset: 0x31a0
// Size: 0x1c2
function function_8883eda1(entity, name) {
    if (isdefined(entity.var_a3fbe34e)) {
        var_18648ef7 = [];
        foreach (point in entity.var_a3fbe34e) {
            if (point.name === name) {
                if (!isdefined(var_18648ef7)) {
                    var_18648ef7 = [];
                } else if (!isarray(var_18648ef7)) {
                    var_18648ef7 = array(var_18648ef7);
                }
                var_18648ef7[var_18648ef7.size] = point;
            }
        }
        if (var_18648ef7.size > 0) {
            foreach (point in var_18648ef7) {
                arrayremovevalue(entity.var_a3fbe34e, point);
            }
            return true;
        }
    }
    return false;
}

// Namespace namespace_b4645fec
// Params 1, eflags: 0x1 linked
// Checksum 0x9836f391, Offset: 0x3370
// Size: 0x34
function function_94b1213d(entity) {
    function_e4f394f5(entity);
    entity.var_a3fbe34e = [];
}

// Namespace namespace_b4645fec
// Params 1, eflags: 0x1 linked
// Checksum 0xea480d72, Offset: 0x33b0
// Size: 0x1a2
function function_102f0bec(entity) {
    var_18648ef7 = [];
    foreach (point in entity.var_a3fbe34e) {
        if (!entity isposatgoal(point.origin)) {
            if (!isdefined(var_18648ef7)) {
                var_18648ef7 = [];
            } else if (!isarray(var_18648ef7)) {
                var_18648ef7 = array(var_18648ef7);
            }
            var_18648ef7[var_18648ef7.size] = point;
        }
    }
    foreach (point in var_18648ef7) {
        arrayremovevalue(entity.var_a3fbe34e, point);
    }
}

// Namespace namespace_b4645fec
// Params 2, eflags: 0x5 linked
// Checksum 0xdbfff006, Offset: 0x3560
// Size: 0x44
function private function_29afe468(entity, point) {
    entity.var_541cb3cf = entity.var_4a9d2541;
    entity.var_4a9d2541 = point;
}

// Namespace namespace_b4645fec
// Params 1, eflags: 0x5 linked
// Checksum 0x7fa14ed5, Offset: 0x35b0
// Size: 0x52
function private function_e4f394f5(entity) {
    /#
        namespace_e585b400::function_4160d34d(entity, undefined);
    #/
    entity.var_7e5dd3e4 = undefined;
    entity.var_a2230d1b = undefined;
    entity.var_4a9d2541 = undefined;
}

// Namespace namespace_b4645fec
// Params 1, eflags: 0x5 linked
// Checksum 0x884ef31c, Offset: 0x3610
// Size: 0xb0
function private function_eae6dfb3(entity) {
    if (distancesquared(entity.var_4a9d2541.origin, entity.origin) < 36 * 36 && isdefined(entity.var_4a9d2541) && abs(self.var_4a9d2541.origin[2] - entity.origin[2]) < 45) {
        return true;
    }
    return false;
}

// Namespace namespace_b4645fec
// Params 1, eflags: 0x5 linked
// Checksum 0x9a2e3624, Offset: 0x36c8
// Size: 0x88
function private function_40eb14cb(entity) {
    if (!isdefined(entity.var_4a9d2541)) {
        return false;
    }
    if (function_eae6dfb3(entity)) {
        return true;
    }
    if (isdefined(entity.pathgoalpos) && entity.pathgoalpos == entity.var_4a9d2541.origin) {
        return true;
    }
    return false;
}

// Namespace namespace_b4645fec
// Params 1, eflags: 0x5 linked
// Checksum 0xf0f30c96, Offset: 0x3758
// Size: 0x204
function private function_69380127(entity) {
    if (isdefined(entity.var_4a9d2541)) {
        if (function_eae6dfb3(entity)) {
            if (isdefined(entity.var_a2230d1b)) {
                if (gettime() > entity.var_a2230d1b) {
                    function_e4f394f5(entity);
                    return false;
                }
                return true;
            } else if (isdefined(entity.var_4a9d2541.min_duration)) {
                entity.var_7e5dd3e4 = gettime();
                if (!isdefined(entity.var_4a9d2541.max_duration) || entity.var_4a9d2541.max_duration == entity.var_4a9d2541.min_duration) {
                    entity.var_a2230d1b = gettime() + entity.var_4a9d2541.min_duration;
                } else {
                    duration = randomintrange(entity.var_4a9d2541.min_duration, entity.var_4a9d2541.max_duration);
                    entity.var_a2230d1b = gettime() + duration;
                }
                return true;
            } else {
                function_e4f394f5(entity);
                return false;
            }
            return true;
        } else if (!function_40eb14cb(entity)) {
            entity useposition(entity.var_4a9d2541.origin);
        }
        return true;
    }
    return false;
}

// Namespace namespace_b4645fec
// Params 1, eflags: 0x5 linked
// Checksum 0xb5364e33, Offset: 0x3968
// Size: 0x244
function private function_78670b61(entity) {
    validpoints = [];
    if (isdefined(entity.var_a3fbe34e)) {
        foreach (point in entity.var_a3fbe34e) {
            if (!entity isposatgoal(point.origin)) {
                distance = distance2dsquared(entity.origin, point.origin);
                distance = sqrt(distance);
                continue;
            }
            if (entity isposinclaimedlocation(point.origin)) {
                continue;
            }
            if (isdefined(entity.var_568222a9) && isdefined(entity.enemy) && entity.var_568222a9) {
                if (!bullettracepassed(entity geteye(), entity.enemy.origin + (0, 0, 50), 0, entity, entity.enemy)) {
                    continue;
                }
            }
            if (!isdefined(validpoints)) {
                validpoints = [];
            } else if (!isarray(validpoints)) {
                validpoints = array(validpoints);
            }
            validpoints[validpoints.size] = point;
        }
    }
    return validpoints;
}

// Namespace namespace_b4645fec
// Params 4, eflags: 0x1 linked
// Checksum 0xa539659f, Offset: 0x3bb8
// Size: 0xa8
function function_5f046d4(val, var_99d71ba5, var_73d4a13c, var_4dd226d3) {
    if (!isdefined(level.players)) {
        return val;
    }
    if (level.players.size == 2) {
        return (val * var_99d71ba5);
    }
    if (level.players.size == 3) {
        return (val * var_73d4a13c);
    }
    if (level.players.size == 4) {
        return (val * var_4dd226d3);
    }
    return val;
}

// Namespace namespace_b4645fec
// Params 1, eflags: 0x1 linked
// Checksum 0x52dea568, Offset: 0x3c68
// Size: 0x154
function function_96271879(entity) {
    if (!isdefined(entity.enemy)) {
        return false;
    }
    distancesqr = distancesquared(entity.enemy.origin, entity.origin);
    if (distancesqr < 300 * 300) {
        jukedistance = 72.5;
    } else {
        jukedistance = -111;
    }
    jukedirection = aiutility::calculatejukedirection(entity, 18, jukedistance);
    if (jukedirection != "forward") {
        blackboard::setblackboardattribute(entity, "_juke_direction", jukedirection);
        if (jukedistance == -111) {
            blackboard::setblackboardattribute(entity, "_juke_distance", "long");
        } else {
            blackboard::setblackboardattribute(entity, "_juke_distance", "short");
        }
        return true;
    }
    return false;
}

// Namespace namespace_b4645fec
// Params 1, eflags: 0x1 linked
// Checksum 0xdcaace65, Offset: 0x3dc8
// Size: 0xf4
function function_34d050ea(entity) {
    if (entity haspath()) {
        var_26383879 = aiutility::bb_getlocomotionfaceenemyquadrant();
        if (var_26383879 == "locomotion_face_enemy_front" || var_26383879 == "locomotion_face_enemy_back") {
            jukedirection = aiutility::calculatejukedirection(entity, 50, -111);
            if (jukedirection != "forward") {
                blackboard::setblackboardattribute(entity, "_juke_direction", jukedirection);
                blackboard::setblackboardattribute(entity, "_juke_distance", "long");
                return true;
            }
        }
    }
    return false;
}

// Namespace namespace_b4645fec
// Params 1, eflags: 0x1 linked
// Checksum 0xee04b64, Offset: 0x3ec8
// Size: 0xa4
function function_54978bb4(enemy) {
    if (isplayer(enemy)) {
        if (isdefined(enemy.laststand) && enemy.laststand) {
            return true;
        }
        playerstance = enemy getstance();
        if (playerstance == "prone" || isdefined(playerstance) && playerstance == "crouch") {
            return true;
        }
    }
    return false;
}

// Namespace namespace_b4645fec
// Params 1, eflags: 0x1 linked
// Checksum 0xd70c1a6c, Offset: 0x3f78
// Size: 0x54
function function_d55b9558(entity) {
    if (!isdefined(entity.var_db9be359)) {
        return false;
    }
    if (gettime() - entity.var_db9be359 <= 4000) {
        return true;
    }
    entity.var_db9be359 = undefined;
    return false;
}

// Namespace namespace_b4645fec
// Params 1, eflags: 0x1 linked
// Checksum 0xe8fc266e, Offset: 0x3fd8
// Size: 0x4c
function function_c17a57a6(entity) {
    if (function_d55b9558(entity)) {
        return;
    }
    entity.var_db9be359 = gettime();
    entity.var_ecf7b5b1 = 1;
}

// Namespace namespace_b4645fec
// Params 2, eflags: 0x1 linked
// Checksum 0xdb8c660c, Offset: 0x4030
// Size: 0x1c4
function function_bc580b21(entity, attackerinfo) {
    if (attackerinfo.damage < -6) {
        return 0;
    }
    threat = 1;
    var_600fee07 = isplayer(attackerinfo.attacker);
    if (var_600fee07) {
        threat *= 10;
    }
    var_bfbf28f9 = distance2dsquared(entity.origin, attackerinfo.attacker.origin);
    var_1742c12e = 0;
    if (var_600fee07) {
        if (var_bfbf28f9 <= 100 * 100) {
            threat *= 1000;
        } else {
            var_1742c12e = var_bfbf28f9 / entity.engagemaxfalloffdist * entity.engagemaxfalloffdist;
            if (var_1742c12e > 1) {
                var_1742c12e = 1;
            }
            var_1742c12e = 1 - var_1742c12e;
        }
    }
    var_e864ad90 = attackerinfo.damage / 1000;
    if (var_e864ad90 > 1) {
        var_e864ad90 = 1;
    }
    threat *= (var_1742c12e * 0.65 + var_e864ad90 * 0.35) * 100;
    return threat;
}

// Namespace namespace_b4645fec
// Params 3, eflags: 0x1 linked
// Checksum 0xfa89e166, Offset: 0x4200
// Size: 0xb2
function function_5530167b(entity, attacker, threat) {
    if (entity.enemy === attacker) {
        return false;
    }
    if (!isdefined(entity.var_f8d4f481)) {
        return true;
    }
    if (entity.var_f8d4f481.health <= 0) {
        return true;
    }
    if (entity.var_f8d4f481 == attacker) {
        return false;
    }
    if (gettime() - entity.var_8af76ae5 < 1) {
        return false;
    }
    return true;
}

// Namespace namespace_b4645fec
// Params 3, eflags: 0x1 linked
// Checksum 0x23f4b590, Offset: 0x42c0
// Size: 0x49c
function function_af40242(entity, newattacker, damage) {
    if (!isdefined(entity.var_84bdb4be)) {
        entity.var_84bdb4be = [];
    }
    maxthreat = 0;
    var_a75ea562 = 0;
    for (i = 0; i < entity.var_84bdb4be.size; i++) {
        attacker = entity.var_84bdb4be[i].attacker;
        if (!isdefined(attacker) || !isentity(attacker) || attacker.health <= 0 || gettime() - entity.var_84bdb4be[i].lastattacktime > 5000) {
            arrayremoveindex(entity.var_84bdb4be, i);
            i--;
            continue;
        }
        entity.var_84bdb4be[i].threat = function_bc580b21(entity, entity.var_84bdb4be[i]);
        if (entity.var_84bdb4be[i].threat > maxthreat) {
            maxthreat = entity.var_84bdb4be[i].threat;
            var_64e4a88a = entity.var_84bdb4be[i];
        }
    }
    if (isdefined(newattacker)) {
        for (i = 0; i < entity.var_84bdb4be.size; i++) {
            if (entity.var_84bdb4be[i].attacker == newattacker) {
                var_5b90059d = entity.var_84bdb4be[i];
                var_5b90059d.lastattacktime = gettime();
                var_5b90059d.damage += damage;
                break;
            }
        }
        if (!isdefined(var_5b90059d)) {
            var_5b90059d = spawnstruct();
            var_5b90059d.attacker = newattacker;
            var_5b90059d.lastattacktime = gettime();
            var_5b90059d.damage = damage;
            var_5b90059d.threat = 0;
            if (!isdefined(entity.var_84bdb4be)) {
                entity.var_84bdb4be = [];
            } else if (!isarray(entity.var_84bdb4be)) {
                entity.var_84bdb4be = array(entity.var_84bdb4be);
            }
            entity.var_84bdb4be[entity.var_84bdb4be.size] = var_5b90059d;
        }
        var_5b90059d.threat = function_bc580b21(entity, var_5b90059d);
        if (var_5b90059d.threat > maxthreat) {
            maxthreat = var_5b90059d.threat;
            var_64e4a88a = var_5b90059d;
        }
    }
    if (isdefined(var_64e4a88a) && maxthreat > 0) {
        if (function_5530167b(entity, var_64e4a88a.attacker, maxthreat)) {
            thread function_c55ceac8(entity, var_64e4a88a.attacker, maxthreat);
        }
    }
    function_3168f4d8(entity);
}

// Namespace namespace_b4645fec
// Params 1, eflags: 0x1 linked
// Checksum 0xbc7908aa, Offset: 0x4768
// Size: 0x24c
function function_3168f4d8(entity) {
    if (!isdefined(entity.var_84bdb4be) || entity.var_84bdb4be.size <= 1) {
        return;
    }
    var_a8e832eb = 0;
    if (function_eae6dfb3(entity)) {
        if (!isdefined(entity.var_7e5dd3e4) || gettime() - entity.var_7e5dd3e4 < 1) {
            return;
        }
        var_a8e832eb = 1;
    }
    if (!var_a8e832eb) {
        if (isdefined(entity.pathgoalpos)) {
            if (distance2dsquared(entity.pathgoalpos, entity.origin) < 36 * 36 && abs(entity.pathgoalpos[2] - entity.origin[2]) < 45) {
                var_a8e832eb = 1;
            }
        }
    }
    if (var_a8e832eb) {
        if (function_d55b9558(entity)) {
            var_a94cf21a = 1;
        } else {
            var_a94cf21a = 0;
            foreach (attackerinfo in entity.var_84bdb4be) {
                if (attackerinfo.damage > -56) {
                    var_a94cf21a++;
                }
            }
        }
        if (var_a94cf21a > 1) {
            function_e4f394f5(entity);
            entity.var_26ca18bb = 0;
        }
    }
}

// Namespace namespace_b4645fec
// Params 3, eflags: 0x1 linked
// Checksum 0xb8e19204, Offset: 0x49c0
// Size: 0x14c
function function_c55ceac8(entity, attacker, threat) {
    entity endon(#"disconnect");
    entity endon(#"death");
    attacker endon(#"death");
    entity endon(#"hash_b160390f");
    entity notify(#"hash_beb03d5e");
    entity endon(#"hash_beb03d5e");
    entity.var_8af76ae5 = gettime();
    entity.var_f8d4f481 = attacker;
    entity.var_3968f41e = threat;
    /#
        namespace_e585b400::function_3d68d6d1(0, (0, 1, 0), "warlordCanTacticalJukeCondition");
    #/
    shoottime = getdvarfloat("warlordangryattack", 3);
    entity ai::shoot_at_target("normal", attacker, undefined, shoottime, undefined, 1);
    entity.var_f8d4f481 = undefined;
    /#
        namespace_e585b400::function_3d68d6d1(0, (0, 0, 1), "warlordCanTacticalJukeCondition");
    #/
}

// Namespace namespace_b4645fec
// Params 15, eflags: 0x1 linked
// Checksum 0x81ab499e, Offset: 0x4b18
// Size: 0x2f4
function function_fe54fdc3(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, timeoffset, boneindex, modelindex, surfacetype, surfacenormal) {
    entity = self;
    if (!isplayer(eattacker)) {
        idamage = int(idamage * 0.05);
    }
    if (smeansofdeath == "MOD_PROJECTILE" || smeansofdeath == "MOD_PROJECTILE_SPLASH" || smeansofdeath == "MOD_EXPLOSIVE" || isdefined(smeansofdeath) && smeansofdeath == "MOD_GRENADE") {
        idamage = int(idamage * 0.25);
    }
    function_af40242(entity, eattacker, idamage);
    if (entity.health <= entity.var_538edf9c) {
        clientfield::set("warlord_damage_state", 2);
    } else if (entity.health <= entity.var_3f5986f) {
        clientfield::set("warlord_damage_state", 1);
    } else {
        clientfield::set("warlord_damage_state", 0);
    }
    if (!isdefined(entity.lastdamagetime)) {
        entity.lastdamagetime = 0;
    }
    if (gettime() - entity.lastdamagetime > 1500) {
        entity.var_9366282a = idamage;
    } else {
        entity.var_9366282a += idamage;
    }
    var_9dcbd3e = getdvarint("warlordhuntdamage", 350);
    if (entity.var_9366282a > function_5f046d4(var_9dcbd3e, 1.5, 2, 2.5)) {
        self.var_ce767dbd = gettime() + 15000;
    }
    entity.lastdamagetime = gettime();
    return idamage;
}

// Namespace namespace_b4645fec
// Params 0, eflags: 0x1 linked
// Checksum 0x70401228, Offset: 0x4e18
// Size: 0x236
function function_b65f3cc0() {
    entity = self;
    entity.var_568222a9 = 0;
    entity.var_b654f978 = 0;
    entity.var_2ac908f2 = 0;
    entity.var_8af76ae5 = 0;
    entity.var_3968f41e = 0;
    entity.ignorerunandgundist = 1;
    entity.combatmode = "no_cover";
    aiutility::addaioverridedamagecallback(entity, &function_fe54fdc3);
    entity.health = int(function_5f046d4(entity.health, 2, 2.5, 3));
    entity.fullhealth = entity.health;
    entity.var_3f5986f = int(entity.fullhealth * 0.5);
    entity.var_538edf9c = int(entity.fullhealth * 0.25);
    entity function_afb9d85b();
    clientfield::set("warlord_damage_state", 0);
    clientfield::set("warlord_lights_state", 1);
    switch (entity.classname) {
    case 42:
        clientfield::set("warlord_type", 2);
        break;
    default:
        clientfield::set("warlord_type", 1);
        break;
    }
}

// Namespace namespace_b4645fec
// Params 0, eflags: 0x1 linked
// Checksum 0xefbfe8fe, Offset: 0x5058
// Size: 0x54
function function_afb9d85b() {
    if (!isdefined(self.var_3ab5b78c)) {
        self.var_3ab5b78c = missile_createrepulsorent(self, 40000, 256, 1);
    }
    self thread function_4d94f2a0();
}

// Namespace namespace_b4645fec
// Params 0, eflags: 0x1 linked
// Checksum 0xba2d75e4, Offset: 0x50b8
// Size: 0x64
function function_dd8d3882() {
    self endon(#"death");
    if (isdefined(self.var_3ab5b78c)) {
        missile_deleteattractor(self.var_3ab5b78c);
        self.var_3ab5b78c = undefined;
    }
    wait(0.5);
    if (isdefined(self)) {
        self function_afb9d85b();
    }
}

// Namespace namespace_b4645fec
// Params 0, eflags: 0x1 linked
// Checksum 0x9b179a14, Offset: 0x5128
// Size: 0xce
function function_4d94f2a0() {
    self endon(#"death");
    self endon(#"hash_85c65e4");
    while (true) {
        self util::waittill_any("projectile_applyattractor", "play_meleefx");
        playfxontag("vehicle/fx_quadtank_airburst", self, "tag_origin");
        playfxontag("vehicle/fx_quadtank_airburst_ground", self, "tag_origin");
        self playsound("wpn_trophy_alert");
        self thread function_dd8d3882();
        self notify(#"hash_85c65e4");
    }
}

// Namespace namespace_b4645fec
// Params 0, eflags: 0x0
// Checksum 0xca21c26e, Offset: 0x5200
// Size: 0x54
function function_8334ee5f() {
    if (!isdefined(self.var_88858d28)) {
        self.var_88858d28 = 0;
    }
    self.var_88858d28 = !self.var_88858d28;
    self clientfield::set_to_player("player_shock_fx", self.var_88858d28);
}

#namespace namespace_e585b400;

/#

    // Namespace namespace_e585b400
    // Params 3, eflags: 0x1 linked
    // Checksum 0x90caf4ec, Offset: 0x5260
    // Size: 0x274
    function function_3d68d6d1(state, color, string) {
        if (getdvarint("warlordCanTacticalJukeCondition") > 0) {
            if (!isdefined(string)) {
                string = "warlordCanTacticalJukeCondition";
            }
            if (!isdefined(state)) {
                if (!isdefined(self) || !isdefined(self.lastmessage) || self.lastmessage != string) {
                    self.lastmessage = string;
                    printtoprightln(string + gettime(), color, -1);
                }
                return;
            }
            if (state == 0) {
                printtoprightln("warlordCanTacticalJukeCondition" + string + gettime(), color, -1);
                return;
            }
            if (state == 1) {
                printtoprightln("warlordCanTacticalJukeCondition" + string + gettime(), color, -1);
                return;
            }
            if (state == 2) {
                printtoprightln("warlordCanTacticalJukeCondition" + string + gettime(), color, -1);
                return;
            }
            if (state == 3) {
                printtoprightln("warlordCanTacticalJukeCondition" + string + gettime(), color, -1);
                return;
            }
            if (state == 4) {
                printtoprightln("warlordCanTacticalJukeCondition" + string + gettime(), color, -1);
                return;
            }
            if (state == 5) {
                printtoprightln("warlordCanTacticalJukeCondition" + string + gettime(), color, -1);
                return;
            }
            if (state == 6) {
                printtoprightln("warlordCanTacticalJukeCondition" + string + gettime(), color, -1);
            }
        }
    }

    // Namespace namespace_e585b400
    // Params 3, eflags: 0x1 linked
    // Checksum 0x656e1237, Offset: 0x54e0
    // Size: 0x94
    function function_3f561bff(entity, state, var_db3a489f) {
        if (getdvarint("warlordCanTacticalJukeCondition") > 0) {
            if (!(isdefined(var_db3a489f) && isnewstate(entity, state))) {
                color = (1, 1, 1);
                entity function_3d68d6d1(state, color);
            }
        }
    }

#/

// Namespace namespace_e585b400
// Params 3, eflags: 0x1 linked
// Checksum 0x51c59591, Offset: 0x5580
// Size: 0x118
function function_4160d34d(entity, state, var_4b0cc01e) {
    if (!isdefined(var_4b0cc01e)) {
        var_4b0cc01e = 0;
    }
    /#
        if (getdvarint("warlordCanTacticalJukeCondition") > 0) {
            if (!isdefined(var_4b0cc01e) || isnewstate(entity, state)) {
                color = (0, 1, 0);
            } else {
                color = (0, 1, 1);
            }
            if (!isdefined(state)) {
                color = (0, 0, 1);
                entity function_3d68d6d1(entity.currentstate, color, "warlordCanTacticalJukeCondition");
            }
            entity function_3d68d6d1(state, color);
        }
    #/
    entity.currentstate = state;
}

/#

    // Namespace namespace_e585b400
    // Params 2, eflags: 0x1 linked
    // Checksum 0x5896e1e2, Offset: 0x56a0
    // Size: 0x6c
    function function_c2db5ca5(entity, state) {
        if (getdvarint("warlordCanTacticalJukeCondition") > 0) {
            color = (1, 1, 0);
            entity function_3d68d6d1(state, color);
        }
    }

#/

// Namespace namespace_e585b400
// Params 2, eflags: 0x1 linked
// Checksum 0xdb5aa654, Offset: 0x5718
// Size: 0x7e
function isnewstate(entity, state) {
    var_42b6f508 = 0;
    if (!isdefined(entity.currentstate)) {
        var_42b6f508 = 1;
    } else if (!isdefined(state)) {
        return 0;
    } else if (entity.currentstate != state) {
        var_42b6f508 = 1;
    }
    return var_42b6f508;
}

