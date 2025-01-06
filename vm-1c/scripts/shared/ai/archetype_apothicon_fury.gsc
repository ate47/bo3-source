#using scripts/codescripts/struct;
#using scripts/shared/ai/archetype_apothicon_fury_interface;
#using scripts/shared/ai/archetype_locomotion_utility;
#using scripts/shared/ai/archetype_mocomps_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/shared/ai/systems/ai_blackboard;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/systems/animation_selector_table;
#using scripts/shared/ai/systems/animation_state_machine_mocomp;
#using scripts/shared/ai/systems/animation_state_machine_notetracks;
#using scripts/shared/ai/systems/animation_state_machine_utility;
#using scripts/shared/ai/systems/behavior_tree_utility;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/ai/systems/debug;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/ai/zombie;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/ai/zombie_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/util_shared;

#namespace namespace_53429ee4;

// Namespace namespace_53429ee4
// Method(s) 2 Total 2
class class_7d30a04a {

    // Namespace namespace_7d30a04a
    // Params 0, eflags: 0x0
    // Checksum 0xbc354e48, Offset: 0x18d8
    // Size: 0x1c
    function constructor() {
        self.adjustmentstarted = 0;
        self.var_dfd59afa = 0;
    }

}

// Namespace namespace_53429ee4
// Method(s) 2 Total 2
class jukeinfo {

}

// Namespace namespace_53429ee4
// Method(s) 2 Total 2
class class_f62488b9 {

    // Namespace namespace_f62488b9
    // Params 0, eflags: 0x0
    // Checksum 0xaf212837, Offset: 0x19a0
    // Size: 0x10
    function constructor() {
        self.adjustmentstarted = 0;
    }

}

// Namespace namespace_53429ee4
// Params 0, eflags: 0x2
// Checksum 0xeae8cb7b, Offset: 0xb08
// Size: 0x1b4
function autoexec init() {
    function_951f2929();
    namespace_55e12b83::function_dbcea833();
    spawner::add_archetype_spawn_function("apothicon_fury", &function_cc9eaa0f);
    spawner::add_archetype_spawn_function("apothicon_fury", &zombie_utility::zombiespawnsetup);
    spawner::add_archetype_spawn_function("apothicon_fury", &function_ae84bd66);
    if (ai::shouldregisterclientfieldforarchetype("apothicon_fury")) {
        clientfield::register("actor", "fury_fire_damage", 15000, getminbitcountfornum(7), "counter");
        clientfield::register("actor", "furious_level", 15000, 1, "int");
        clientfield::register("actor", "bamf_land", 15000, 1, "counter");
        clientfield::register("actor", "apothicon_fury_death", 15000, 2, "int");
        clientfield::register("actor", "juke_active", 15000, 1, "int");
    }
}

// Namespace namespace_53429ee4
// Params 0, eflags: 0x4
// Checksum 0xd5fdb009, Offset: 0xcc8
// Size: 0x464
function private function_951f2929() {
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconCanJuke", &apothiconCanJuke);
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconJukeInit", &apothiconJukeInit);
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconPreemptiveJukeService", &apothiconPreemptiveJukeService);
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconPreemptiveJukePending", &apothiconPreemptiveJukePending);
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconPreemptiveJukeDone", &apothiconPreemptiveJukeDone);
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconMoveStart", &apothiconMoveStart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconMoveUpdate", &apothiconMoveUpdate);
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconCanMeleeAttack", &apothiconCanMeleeAttack);
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconShouldMeleeCondition", &apothiconShouldMeleeCondition);
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconCanBamf", &apothiconCanBamf);
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconCanBamfAfterJuke", &apothiconCanBamfAfterJuke);
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconBamfInit", &apothiconBamfInit);
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconShouldTauntAtPlayer", &apothiconShouldTauntAtPlayer);
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconTauntAtPlayerEvent", &apothiconTauntAtPlayerEvent);
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconFuriousModeInit", &apothiconFuriousModeInit);
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconKnockdownService", &apothiconKnockdownService);
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconDeathStart", &apothiconDeathStart);
    behaviortreenetworkutility::registerbehaviortreescriptapi("apothiconDeathTerminate", &apothiconDeathTerminate);
    animationstatenetwork::registeranimationmocomp("mocomp_teleport@apothicon_fury", &function_ada7c6a6, undefined, &function_c5c85a6d);
    animationstatenetwork::registeranimationmocomp("mocomp_juke@apothicon_fury", &function_f7b15804, &function_9a6bdbed, &function_7db60953);
    animationstatenetwork::registeranimationmocomp("mocomp_bamf@apothicon_fury", &function_7e253d5, &function_320356b8, &function_2dbbd110);
    animationstatenetwork::registernotetrackhandlerfunction("start_effect", &function_76192844);
    animationstatenetwork::registernotetrackhandlerfunction("end_effect", &function_59f30845);
    animationstatenetwork::registernotetrackhandlerfunction("bamf_land", &function_eac19177);
    animationstatenetwork::registernotetrackhandlerfunction("start_dissolve", &function_1ff8e5b1);
    animationstatenetwork::registernotetrackhandlerfunction("dissolved", &function_5e2acc67);
}

// Namespace namespace_53429ee4
// Params 0, eflags: 0x4
// Checksum 0xba9f0669, Offset: 0x1138
// Size: 0x1fc
function private function_cc9eaa0f() {
    blackboard::createblackboardforentity(self);
    blackboard::registerblackboardattribute(self, "_locomotion_speed", "locomotion_speed_run", undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("<dev string:x28>");
        #/
    }
    blackboard::registerblackboardattribute(self, "_apothicon_bamf_distance", undefined, &function_a6019ee6);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("<dev string:x3a>");
        #/
    }
    blackboard::registerblackboardattribute(self, "_idgun_damage_direction", "back", &bb_idgungetdamagedirection);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("<dev string:x53>");
        #/
    }
    blackboard::registerblackboardattribute(self, "_variant_type", 0, undefined);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("<dev string:x6b>");
        #/
    }
    self aiutility::function_89e1fc16();
    ai::createinterfaceforentity(self);
    self.___archetypeonanimscriptedcallback = &function_e4af4799;
    /#
        self finalizetrackedblackboardattributes();
    #/
}

// Namespace namespace_53429ee4
// Params 0, eflags: 0x4
// Checksum 0x3c5afc7b, Offset: 0x1340
// Size: 0x164
function private function_ae84bd66() {
    self.entityradius = 30;
    self.jukemaxdistance = 1500;
    self.updatesight = 0;
    self allowpitchangle(1);
    self setpitchorient();
    self function_1762804b(1);
    self.skipautoragdoll = 1;
    aiutility::addaioverridedamagecallback(self, &function_b68605e4);
    aiutility::addaioverridekilledcallback(self, &function_9bed87a9);
    self.zigzag_distance_min = 300;
    self.zigzag_distance_max = 700;
    self.var_e78a1124 = 0;
    self.var_5598e222 = 0;
    self.var_e629fb97 = gettime();
    self.var_b948f7a = gettime();
    self.nextpreemptivejukeads = randomfloatrange(0.7, 0.95);
    blackboard::setblackboardattribute(self, "_variant_type", randomintrange(0, 3));
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x4
// Checksum 0x989fec2e, Offset: 0x14b0
// Size: 0x34
function private function_e4af4799(entity) {
    entity.__blackboard = undefined;
    entity function_cc9eaa0f();
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0x64760ec8, Offset: 0x14f0
// Size: 0x132
function function_1ff8e5b1(entity) {
    if (entity.archetype != "apothicon_fury") {
        return;
    }
    a_zombies = getaiarchetypearray("zombie");
    var_abbab1d4 = array::filter(a_zombies, 0, &function_9babb92c, entity, entity.origin);
    if (var_abbab1d4.size > 0) {
        foreach (zombie in var_abbab1d4) {
            function_6a78ff68(entity, zombie);
        }
    }
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0xe4aaa393, Offset: 0x1630
// Size: 0xc
function function_5e2acc67(entity) {
    
}

// Namespace namespace_53429ee4
// Params 5, eflags: 0x4
// Checksum 0xe9349e80, Offset: 0x1648
// Size: 0x188
function private function_ada7c6a6(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity orientmode("face angle", entity.angles[1]);
    entity setrepairpaths(0);
    locomotionspeed = blackboard::getblackboardattribute(entity, "_locomotion_speed");
    if (locomotionspeed == "locomotion_speed_walk") {
        rate = 1.6;
    } else {
        rate = 2;
    }
    entity asmsetanimationrate(rate);
    assert(isdefined(entity.traverseendnode));
    entity animmode("noclip", 0);
    entity notsolid();
    entity.blockingpain = 1;
    entity.usegoalanimweight = 1;
    entity.var_a5db58c6 = 1;
}

// Namespace namespace_53429ee4
// Params 5, eflags: 0x4
// Checksum 0x13a9b20a, Offset: 0x17d8
// Size: 0xf4
function private function_c5c85a6d(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    if (!isdefined(entity.traverseendnode)) {
        return;
    }
    entity forceteleport(entity.traverseendnode.origin, entity.angles);
    entity asmsetanimationrate(1);
    entity show();
    entity solid();
    entity.blockingpain = 0;
    entity.usegoalanimweight = 0;
    entity.var_a5db58c6 = 0;
}

// Namespace namespace_53429ee4
// Params 5, eflags: 0x0
// Checksum 0x9589d02b, Offset: 0x1a58
// Size: 0x824
function function_f7b15804(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.isjuking = 1;
    if (isdefined(entity.jukeinfo)) {
        entity orientmode("face angle", entity.jukeinfo.var_e3935316);
    } else {
        entity orientmode("face angle", entity.angles[1]);
    }
    entity animmode("noclip", 1);
    entity.usegoalanimweight = 1;
    entity.blockingpain = 1;
    entity function_1762804b(0);
    entity.pushable = 0;
    var_26689e5d = getmovedelta(mocompanim, 0, 1, entity);
    landpos = entity localtoworldcoords(var_26689e5d);
    velocity = entity getvelocity();
    predictedpos = entity.origin + velocity * 0.1;
    /#
        recordcircle(landpos, 8, (0, 0, 1), "<dev string:x79>", entity);
        record3dtext("<dev string:x80>" + distance(predictedpos, landpos), landpos, (0, 0, 1), "<dev string:x79>");
    #/
    var_c23f776 = entity.jukeinfo.var_c23f776;
    heightdiff = var_c23f776[2] - landpos[2];
    /#
        recordcircle(var_c23f776, 8, (0, 1, 0), "<dev string:x79>", entity);
        recordline(landpos, var_c23f776, (0, 1, 0), "<dev string:x79>", entity);
    #/
    assert(animhasnotetrack(mocompanim, "<dev string:x81>"));
    starttime = getnotetracktimes(mocompanim, "start_effect")[0];
    var_df235bea = getmovedelta(mocompanim, 0, starttime, entity);
    startpos = entity localtoworldcoords(var_df235bea);
    assert(animhasnotetrack(mocompanim, "<dev string:x8e>"));
    stoptime = getnotetracktimes(mocompanim, "end_effect")[0];
    var_5becc98c = getmovedelta(mocompanim, 0, stoptime, entity);
    stoppos = entity localtoworldcoords(var_5becc98c);
    /#
        recordsphere(startpos, 3, (0, 0, 1), "<dev string:x79>", entity);
        recordsphere(stoppos, 3, (0, 0, 1), "<dev string:x79>", entity);
        recordline(predictedpos, startpos, (0, 0, 1), "<dev string:x79>", entity);
        recordline(startpos, stoppos, (0, 0, 1), "<dev string:x79>", entity);
        recordline(stoppos, landpos, (0, 0, 1), "<dev string:x79>", entity);
    #/
    var_bf7e71d5 = stoppos + (0, 0, heightdiff);
    /#
        recordline(startpos, var_bf7e71d5, (1, 1, 0), "<dev string:x79>", entity);
        recordline(var_bf7e71d5, var_c23f776, (1, 1, 0), "<dev string:x79>", entity);
        recordsphere(var_bf7e71d5, 3, (1, 1, 0), "<dev string:x79>", entity);
    #/
    entity.var_7d30a04a = undefined;
    entity.var_7d30a04a = new class_7d30a04a();
    entity.var_7d30a04a.starttime = starttime;
    entity.var_7d30a04a.stoptime = stoptime;
    entity.var_7d30a04a.enemy = entity.enemy;
    animlength = getanimlength(mocompanim) * 1000;
    starttime *= animlength;
    stoptime *= animlength;
    starttime = floor(starttime / 50);
    stoptime = floor(stoptime / 50);
    adjustduration = stoptime - starttime;
    entity.var_7d30a04a.stepsize = heightdiff / adjustduration;
    entity.var_7d30a04a.var_c23f776 = var_c23f776;
    /#
        if (heightdiff < 0) {
            record3dtext("<dev string:x99>" + distance(landpos, var_c23f776) + "<dev string:x9b>" + entity.var_7d30a04a.stepsize + "<dev string:x9b>" + adjustduration, var_c23f776, (1, 0.5, 0), "<dev string:x79>");
            return;
        }
        record3dtext("<dev string:x9d>" + distance(landpos, var_c23f776) + "<dev string:x9b>" + entity.var_7d30a04a.stepsize + "<dev string:x9b>" + adjustduration, var_c23f776, (1, 0.5, 0), "<dev string:x79>");
    #/
}

// Namespace namespace_53429ee4
// Params 5, eflags: 0x0
// Checksum 0x867838a, Offset: 0x2288
// Size: 0x224
function function_9a6bdbed(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    times = getnotetracktimes(mocompanim, "end_effect");
    if (times.size) {
        time = times[0];
    }
    animtime = entity getanimtime(mocompanim);
    if (!entity.var_7d30a04a.adjustmentstarted) {
        if (animtime >= entity.var_7d30a04a.starttime) {
            entity.var_7d30a04a.adjustmentstarted = 1;
        }
    }
    if (entity.var_7d30a04a.adjustmentstarted && animtime < entity.var_7d30a04a.stoptime) {
        adjustedorigin = entity.origin + (0, 0, entity.var_7d30a04a.stepsize);
        entity forceteleport(adjustedorigin, entity.angles);
    } else if (isdefined(entity.enemy)) {
        entity orientmode("face direction", entity.enemy.origin - entity.origin);
    }
    /#
        recordcircle(entity.var_7d30a04a.var_c23f776, 8, (0, 1, 0), "<dev string:x79>", entity);
    #/
}

// Namespace namespace_53429ee4
// Params 5, eflags: 0x0
// Checksum 0xa17e420b, Offset: 0x24b8
// Size: 0x13c
function function_7db60953(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity.blockingpain = 0;
    entity solid();
    entity function_1762804b(1);
    entity.isjuking = 0;
    entity.usegoalanimweight = 0;
    entity.pushable = 1;
    entity.jukeinfo = undefined;
    /#
        recordcircle(entity.var_7d30a04a.var_c23f776, 8, (0, 1, 0), "<dev string:x79>", entity);
    #/
    if (isdefined(entity.enemy)) {
        entity orientmode("face direction", entity.enemy.origin - entity.origin);
    }
}

// Namespace namespace_53429ee4
// Params 5, eflags: 0x4
// Checksum 0x7cd58a24, Offset: 0x2600
// Size: 0x9c0
function private function_f6c42fd2(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    assert(isdefined(entity.var_7d30a04a.adjustmentstarted) && entity.var_7d30a04a.adjustmentstarted);
    if (isdefined(entity.var_7d30a04a.var_dfd59afa) && entity.var_7d30a04a.var_dfd59afa) {
        return;
    }
    var_cd2a2a0b = 0.45;
    animtime = entity getanimtime(mocompanim);
    if (animtime >= var_cd2a2a0b && entity.enemy === entity.var_7d30a04a.enemy) {
        var_5a2eb000 = entity.var_7d30a04a.var_c23f776;
        if (isdefined(entity.enemy.last_valid_position)) {
            var_5288fe83 = entity.enemy.last_valid_position;
        } else {
            var_5288fe83 = entity.enemy.origin;
            var_e65bdfeb = anglestoforward(entity.enemy.angles);
            var_1c8f8983 = var_5288fe83 + var_e65bdfeb * randomintrange(30, 50);
            var_1c8f8983 = getclosestpointonnavmesh(var_1c8f8983, 20, 50);
            if (isdefined(var_1c8f8983)) {
                var_5288fe83 = var_1c8f8983;
            }
        }
        if (distancesquared(var_5a2eb000, var_5288fe83) < 1024) {
            return;
        }
        if (!util::within_fov(var_5288fe83, entity.enemy.angles, entity.origin, 0.642)) {
            return;
        }
        if (!util::within_fov(var_5a2eb000, entity.angles, var_5288fe83, 0.642)) {
            return;
        }
        if (!ispointonnavmesh(var_5a2eb000, entity)) {
            return;
        }
        if (!ispointonnavmesh(var_5288fe83, entity)) {
            return;
        }
        if (!tracepassedonnavmesh(var_5a2eb000, var_5288fe83, entity.entityradius)) {
            return;
        }
        if (!entity findpath(var_5a2eb000, var_5288fe83)) {
            return;
        }
        landpos = entity.var_7d30a04a.var_c23f776;
        /#
            recordcircle(var_5288fe83, 8, (0, 1, 1), "<dev string:x79>", entity);
            recordcircle(landpos, 8, (0, 0, 1), "<dev string:x79>", entity);
        #/
        zdiff = landpos[2] - var_5288fe83[2];
        tracestart = undefined;
        traceend = undefined;
        if (zdiff < 0) {
            var_c4b297d4 = zdiff * -1 + 30;
            tracestart = var_5288fe83 + (0, 0, var_c4b297d4);
            traceend = var_5288fe83 + (0, 0, -70);
        } else {
            var_1ae5064c = zdiff * -1 - 30;
            tracestart = var_5288fe83 + (0, 0, 70);
            traceend = var_5288fe83 + (0, 0, var_1ae5064c);
        }
        trace = groundtrace(tracestart, traceend, 0, entity, 1, 1);
        var_c23f776 = trace["position"];
        var_c23f776 = getclosestpointonnavmesh(var_c23f776, 100, 50);
        if (!isdefined(var_c23f776)) {
            return;
        }
        /#
            recordcircle(var_c23f776, 8, (0, 1, 0), "<dev string:x79>", entity);
            recordline(landpos, var_c23f776, (0, 1, 0), "<dev string:x79>", entity);
        #/
        assert(isdefined(entity.var_7d30a04a));
        starttime = var_cd2a2a0b;
        stoptime = entity.var_7d30a04a.stoptime;
        entity.var_31fe535c = new class_7d30a04a();
        entity.var_31fe535c.starttime = var_cd2a2a0b;
        entity.var_31fe535c.stoptime = stoptime;
        entity.var_31fe535c.var_c23f776 = var_c23f776;
        animlength = getanimlength(mocompanim) * 1000;
        starttime *= animlength;
        stoptime *= animlength;
        starttime = floor(starttime / 50);
        stoptime = floor(stoptime / 50);
        adjustduration = stoptime - starttime;
        heightdiff = var_c23f776[2] - landpos[2];
        entity.var_31fe535c.stepsize = heightdiff / adjustduration;
        /#
            if (heightdiff < 0) {
                record3dtext("<dev string:x9f>" + entity.var_31fe535c.stepsize + "<dev string:x9b>" + adjustduration, var_c23f776, (1, 0.5, 0), "<dev string:x79>");
            } else {
                record3dtext("<dev string:xa2>" + entity.var_31fe535c.stepsize + "<dev string:x9b>" + adjustduration, var_c23f776, (1, 0.5, 0), "<dev string:x79>");
            }
        #/
        var_5288fe83 = (var_5288fe83[0], var_5288fe83[1], landpos[2]);
        var_cc809cdf = vectornormalize(var_5288fe83 - landpos);
        var_74b721bd = distance(var_5288fe83, landpos);
        entity.var_f62488b9 = new class_f62488b9();
        entity.var_f62488b9.starttime = starttime;
        entity.var_f62488b9.stoptime = stoptime;
        entity.var_f62488b9.stepsize = var_74b721bd / adjustduration;
        entity.var_f62488b9.var_cc809cdf = var_cc809cdf;
        entity.var_f62488b9.adjustmentstarted = 1;
        /#
            record3dtext("<dev string:x80>" + var_74b721bd + "<dev string:xa5>" + entity.var_f62488b9.stepsize + "<dev string:xad>", var_5288fe83, (0, 0, 1), "<dev string:x79>");
        #/
        entity.var_7d30a04a.var_dfd59afa = 1;
    }
}

// Namespace namespace_53429ee4
// Params 5, eflags: 0x0
// Checksum 0x52bd3b23, Offset: 0x2fc8
// Size: 0xa84
function function_7e253d5(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    assert(isdefined(entity.enemy));
    entity.var_7d30a04a = undefined;
    entity.var_31fe535c = undefined;
    entity.var_f62488b9 = undefined;
    entity clearpath();
    entity pathmode("dont move");
    entity.blockingpain = 1;
    entity.usegoalanimweight = 1;
    self function_1762804b(0);
    entity.var_cf47bc71 = 1;
    entity.pushable = 0;
    anglestoenemy = (0, vectortoangles(entity.enemy.origin - entity.origin)[1], 0);
    entity forceteleport(entity.origin, anglestoenemy);
    entity orientmode("face angle", anglestoenemy[1]);
    entity animmode("noclip", 1);
    var_26689e5d = getmovedelta(mocompanim, 0, 1, entity);
    landpos = entity localtoworldcoords(var_26689e5d);
    /#
        recordcircle(entity.enemy.origin, 8, (0, 1, 1), "<dev string:x79>", entity);
        recordline(landpos, entity.enemy.origin, (0, 1, 1), "<dev string:x79>", entity);
        recordcircle(landpos, 8, (0, 0, 1), "<dev string:x79>", entity);
        record3dtext("<dev string:x80>" + distance(entity.origin, landpos), landpos, (0, 0, 1), "<dev string:x79>");
    #/
    zdiff = entity.origin[2] - entity.enemy.origin[2];
    tracestart = undefined;
    traceend = undefined;
    if (zdiff < 0) {
        var_c4b297d4 = zdiff * -1 + 30;
        tracestart = landpos + (0, 0, var_c4b297d4);
        traceend = landpos + (0, 0, -70);
    } else {
        var_1ae5064c = zdiff * -1 - 30;
        tracestart = landpos + (0, 0, 70);
        traceend = landpos + (0, 0, var_1ae5064c);
    }
    trace = groundtrace(tracestart, traceend, 0, entity, 1, 1);
    var_c23f776 = trace["position"];
    var_c23f776 = getclosestpointonnavmesh(var_c23f776, 100, 25);
    if (!isdefined(var_c23f776)) {
        var_c23f776 = entity.enemy.origin;
    }
    /#
        recordcircle(var_c23f776, 8, (0, 1, 0), "<dev string:x79>", entity);
        recordline(landpos, var_c23f776, (0, 1, 0), "<dev string:x79>", entity);
    #/
    heightdiff = var_c23f776[2] - landpos[2];
    assert(animhasnotetrack(mocompanim, "<dev string:x81>"));
    starttime = getnotetracktimes(mocompanim, "start_effect")[0];
    var_df235bea = getmovedelta(mocompanim, 0, starttime, entity);
    startpos = entity localtoworldcoords(var_df235bea);
    assert(animhasnotetrack(mocompanim, "<dev string:x8e>"));
    stoptime = getnotetracktimes(mocompanim, "end_effect")[0];
    var_5becc98c = getmovedelta(mocompanim, 0, stoptime, entity);
    stoppos = entity localtoworldcoords(var_5becc98c);
    /#
        recordsphere(startpos, 3, (0, 0, 1), "<dev string:x79>", entity);
        recordsphere(stoppos, 3, (0, 0, 1), "<dev string:x79>", entity);
        recordline(entity.origin, startpos, (0, 0, 1), "<dev string:x79>", entity);
        recordline(startpos, stoppos, (0, 0, 1), "<dev string:x79>", entity);
        recordline(stoppos, landpos, (0, 0, 1), "<dev string:x79>", entity);
    #/
    var_bf7e71d5 = stoppos + (0, 0, heightdiff);
    /#
        recordline(startpos, var_bf7e71d5, (0, 1, 0), "<dev string:x79>", entity);
        recordline(var_bf7e71d5, var_c23f776, (0, 1, 0), "<dev string:x79>", entity);
        recordsphere(var_bf7e71d5, 3, (0, 1, 0), "<dev string:x79>", entity);
    #/
    entity.var_7d30a04a = new class_7d30a04a();
    entity.var_7d30a04a.starttime = starttime;
    entity.var_7d30a04a.stoptime = stoptime;
    entity.var_7d30a04a.enemy = entity.enemy;
    animlength = getanimlength(mocompanim) * 1000;
    starttime *= animlength;
    stoptime *= animlength;
    starttime = floor(starttime / 50);
    stoptime = floor(stoptime / 50);
    adjustduration = stoptime - starttime;
    entity.var_7d30a04a.stepsize = heightdiff / adjustduration;
    entity.var_7d30a04a.var_c23f776 = var_c23f776;
    /#
        if (heightdiff < 0) {
            record3dtext("<dev string:x99>" + distance(landpos, var_c23f776) + "<dev string:x9b>" + entity.var_7d30a04a.stepsize + "<dev string:x9b>" + adjustduration, var_c23f776, (1, 0.5, 0), "<dev string:x79>");
            return;
        }
        record3dtext("<dev string:x9d>" + distance(landpos, var_c23f776) + "<dev string:x9b>" + entity.var_7d30a04a.stepsize + "<dev string:x9b>" + adjustduration, var_c23f776, (1, 0.5, 0), "<dev string:x79>");
    #/
}

// Namespace namespace_53429ee4
// Params 5, eflags: 0x0
// Checksum 0x40a8a313, Offset: 0x3a58
// Size: 0x2b4
function function_320356b8(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    assert(isdefined(entity.var_7d30a04a));
    if (!isdefined(entity.enemy)) {
        return;
    }
    animtime = entity getanimtime(mocompanim);
    if (!entity.var_7d30a04a.adjustmentstarted) {
        if (animtime >= entity.var_7d30a04a.starttime) {
            entity.var_7d30a04a.adjustmentstarted = 1;
        }
    }
    if (entity.var_7d30a04a.adjustmentstarted && animtime < entity.var_7d30a04a.stoptime) {
        adjustedorigin = entity.origin + (0, 0, entity.var_7d30a04a.stepsize);
        function_f6c42fd2(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration);
        if (isdefined(entity.var_7d30a04a.var_dfd59afa) && entity.var_7d30a04a.var_dfd59afa) {
            if (isdefined(entity.var_31fe535c)) {
                adjustedorigin += (0, 0, entity.var_31fe535c.stepsize);
            }
            if (isdefined(entity.var_f62488b9)) {
                adjustedorigin += entity.var_f62488b9.var_cc809cdf * entity.var_f62488b9.stepsize;
            }
        }
        entity forceteleport(adjustedorigin, entity.angles);
        return;
    }
    if (isdefined(entity.enemy)) {
        entity orientmode("face direction", entity.enemy.origin - entity.origin);
    }
}

// Namespace namespace_53429ee4
// Params 5, eflags: 0x0
// Checksum 0x2b9201a7, Offset: 0x3d18
// Size: 0x1b4
function function_2dbbd110(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration) {
    entity pathmode("move allowed");
    entity solid();
    entity show();
    entity.blockingpain = 0;
    entity.usegoalanimweight = 0;
    entity orientmode("face angle", entity.angles[1]);
    entity animmode("gravity");
    entity.var_cf47bc71 = 0;
    entity.pushable = 1;
    self function_1762804b(1);
    entity.jukeinfo = undefined;
    if (!ispointonnavmesh(entity.origin)) {
        var_3fd72f96 = getclosestpointonnavmesh(entity.origin, 100, 25);
        if (isdefined(var_3fd72f96)) {
            entity forceteleport(var_3fd72f96);
        }
    }
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0x2bb21308, Offset: 0x3ed8
// Size: 0x3a
function apothiconCanMeleeAttack(entity) {
    return apothiconCanBamf(entity) || apothiconShouldMeleeCondition(entity);
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0xa2bba148, Offset: 0x3f20
// Size: 0x164
function apothiconShouldMeleeCondition(behaviortreeentity) {
    if (isdefined(behaviortreeentity.enemyoverride) && isdefined(behaviortreeentity.enemyoverride[1])) {
        return false;
    }
    if (!isdefined(behaviortreeentity.enemy)) {
        return false;
    }
    if (isdefined(behaviortreeentity.marked_for_death)) {
        return false;
    }
    if (isdefined(behaviortreeentity.ignoremelee) && behaviortreeentity.ignoremelee) {
        return false;
    }
    if (distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) > 10000) {
        return false;
    }
    yawtoenemy = angleclamp180(behaviortreeentity.angles[1] - vectortoangles(behaviortreeentity.enemy.origin - behaviortreeentity.origin)[1]);
    if (abs(yawtoenemy) > 60) {
        return false;
    }
    return true;
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0xad513294, Offset: 0x4090
// Size: 0x22
function apothiconCanBamfAfterJuke(entity) {
    return function_d0f50cb1(entity);
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0x1fea1b65, Offset: 0x40c0
// Size: 0x22
function apothiconCanBamf(entity) {
    return function_d0f50cb1(entity);
}

// Namespace namespace_53429ee4
// Params 2, eflags: 0x0
// Checksum 0x4eef90df, Offset: 0x40f0
// Size: 0x4da
function function_d0f50cb1(entity, var_9f9b11ec) {
    if (!isdefined(var_9f9b11ec)) {
        var_9f9b11ec = 0;
    }
    if (!ai::getaiattribute(entity, "can_bamf")) {
        return false;
    }
    if (!isdefined(entity.enemy)) {
        return false;
    }
    if (!isplayer(entity.enemy)) {
        return false;
    }
    if (isdefined(entity.var_f77c852b) && entity.var_f77c852b) {
        return false;
    }
    if (isdefined(entity.var_cf47bc71) && entity.var_cf47bc71) {
        return false;
    }
    if (!var_9f9b11ec) {
        if (gettime() < entity.var_e629fb97) {
            return false;
        }
        jukeevents = blackboard::getblackboardevents("apothicon_fury_bamf");
        tooclosejukedistancesqr = 400 * 400;
        foreach (event in jukeevents) {
            if (distance2dsquared(entity.origin, event.data.origin) <= tooclosejukedistancesqr) {
                return false;
            }
        }
    }
    assert(isdefined(entity.enemy));
    enemyorigin = entity.enemy.origin;
    var_1e735ae1 = getaiarchetypearray("apothicon_fury");
    var_cc119870 = 0;
    foreach (var_1b17e4fe in var_1e735ae1) {
        if (distancesquared(enemyorigin, var_1b17e4fe.origin) <= 6400) {
            var_cc119870++;
        }
    }
    if (var_cc119870 >= 4) {
        return false;
    }
    var_e0942fdd = distancesquared(enemyorigin, entity.origin);
    var_5d3404e5 = 400 * 400;
    if (var_9f9b11ec) {
        var_5d3404e5 = -6 * -6;
    }
    if (var_e0942fdd > var_5d3404e5 && var_e0942fdd < 750 * 750) {
        if (!util::within_fov(enemyorigin, entity.enemy.angles, entity.origin, 0.642)) {
            return false;
        }
        if (!util::within_fov(entity.origin, entity.angles, enemyorigin, 0.642)) {
            return false;
        }
        var_5a2eb000 = entity.origin;
        var_5288fe83 = enemyorigin;
        if (!ispointonnavmesh(var_5a2eb000, entity)) {
            return false;
        }
        if (!ispointonnavmesh(var_5288fe83, entity)) {
            return false;
        }
        if (!tracepassedonnavmesh(var_5a2eb000, var_5288fe83, entity.entityradius)) {
            return false;
        }
        if (!entity findpath(var_5a2eb000, var_5288fe83)) {
            return false;
        }
        return true;
    }
    return false;
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0xc0e1f14e, Offset: 0x45d8
// Size: 0x44
function function_a6019ee6(entity) {
    distancetoenemy = distance(self.enemy.origin, self.origin);
    return distancetoenemy;
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0x95fa6968, Offset: 0x4628
// Size: 0xf4
function apothiconBamfInit(entity) {
    jukeinfo = spawnstruct();
    jukeinfo.origin = entity.origin;
    jukeinfo.entity = entity;
    blackboard::addblackboardevent("apothicon_fury_bamf", jukeinfo, 4500);
    if (isdefined(level.var_6a4bce2d) && isdefined(level.var_a7afd943)) {
        entity.var_e629fb97 = gettime() + randomfloatrange(level.var_6a4bce2d, level.var_a7afd943);
        return;
    }
    entity.var_e629fb97 = gettime() + randomfloatrange(4500, 6000);
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0x37f2eead, Offset: 0x4728
// Size: 0x4c
function apothiconShouldTauntAtPlayer(entity) {
    var_3f463f4c = blackboard::getblackboardevents("apothicon_fury_taunt");
    if (isdefined(var_3f463f4c) && var_3f463f4c.size) {
        return false;
    }
    return true;
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0xe69994ed, Offset: 0x4780
// Size: 0x7c
function apothiconTauntAtPlayerEvent(entity) {
    jukeinfo = spawnstruct();
    jukeinfo.origin = entity.origin;
    jukeinfo.entity = entity;
    blackboard::addblackboardevent("apothicon_fury_taunt", jukeinfo, 9500);
}

// Namespace namespace_53429ee4
// Params 0, eflags: 0x0
// Checksum 0x5d2be2cc, Offset: 0x4808
// Size: 0x2a
function bb_idgungetdamagedirection() {
    if (isdefined(self.damage_direction)) {
        return self.damage_direction;
    }
    return self aiutility::bb_getdamagedirection();
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0xc391199c, Offset: 0x4840
// Size: 0x17c
function function_eac19177(entity) {
    if (entity.archetype != "apothicon_fury") {
        return;
    }
    if (isdefined(entity.enemy)) {
        entity orientmode("face direction", entity.enemy.origin - entity.origin);
    }
    entity clientfield::increment("bamf_land");
    if (isdefined(entity.enemy) && isplayer(entity.enemy) && distancesquared(entity.enemy.origin, entity.origin) <= -6 * -6) {
        entity.enemy dodamage(25, entity.origin, entity, entity, undefined, "MOD_MELEE");
    }
    physicsexplosionsphere(entity.origin, 100, 15, 10);
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0x15902495, Offset: 0x49c8
// Size: 0x38
function apothiconMoveStart(entity) {
    entity.movetime = gettime();
    entity.moveorigin = entity.origin;
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0xdcf170d, Offset: 0x4a08
// Size: 0x138
function apothiconMoveUpdate(entity) {
    if (isdefined(entity.move_anim_end_time) && gettime() >= entity.move_anim_end_time) {
        entity.move_anim_end_time = undefined;
        return;
    }
    if (!(isdefined(entity.missinglegs) && entity.missinglegs) && gettime() - entity.movetime > 1000) {
        distsq = distance2dsquared(entity.origin, entity.moveorigin);
        if (distsq < -112) {
            if (isdefined(entity.cant_move_cb)) {
                entity [[ entity.cant_move_cb ]]();
            }
        } else {
            entity.cant_move = 0;
        }
        entity.movetime = gettime();
        entity.moveorigin = entity.origin;
    }
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0xe5457c01, Offset: 0x4b48
// Size: 0x20a
function apothiconKnockdownService(entity) {
    if (isdefined(entity.isjuking) && entity.isjuking) {
        return;
    }
    if (isdefined(entity.var_cf47bc71) && entity.var_cf47bc71) {
        return;
    }
    velocity = entity getvelocity();
    var_43502fbc = 0.5;
    predicted_pos = entity.origin + velocity * var_43502fbc;
    move_dist_sq = distancesquared(predicted_pos, entity.origin);
    speed = move_dist_sq / var_43502fbc;
    if (speed >= 10) {
        a_zombies = getaiarchetypearray("zombie");
        var_abbab1d4 = array::filter(a_zombies, 0, &function_9babb92c, entity, predicted_pos);
        if (var_abbab1d4.size > 0) {
            foreach (zombie in var_abbab1d4) {
                function_6a78ff68(entity, zombie);
            }
        }
    }
}

// Namespace namespace_53429ee4
// Params 3, eflags: 0x4
// Checksum 0x529e817e, Offset: 0x4d60
// Size: 0x1d4
function private function_9babb92c(zombie, thrasher, predicted_pos) {
    if (zombie.knockdown === 1) {
        return false;
    }
    if (isdefined(zombie.missinglegs) && zombie.missinglegs) {
        return false;
    }
    var_780bea21 = 2304;
    dist_sq = distancesquared(predicted_pos, zombie.origin);
    if (dist_sq > var_780bea21) {
        return false;
    }
    origin = thrasher.origin;
    facing_vec = anglestoforward(thrasher.angles);
    enemy_vec = zombie.origin - origin;
    var_ef095088 = (enemy_vec[0], enemy_vec[1], 0);
    var_331bc04c = (facing_vec[0], facing_vec[1], 0);
    var_ef095088 = vectornormalize(var_ef095088);
    var_331bc04c = vectornormalize(var_331bc04c);
    enemy_dot = vectordot(var_331bc04c, var_ef095088);
    if (enemy_dot < 0) {
        return false;
    }
    return true;
}

// Namespace namespace_53429ee4
// Params 2, eflags: 0x0
// Checksum 0x9a05aa64, Offset: 0x4f40
// Size: 0x2b4
function function_6a78ff68(entity, zombie) {
    zombie.knockdown = 1;
    zombie.knockdown_type = "knockdown_shoved";
    var_663c85f3 = entity.origin - zombie.origin;
    var_60c0153c = vectornormalize((var_663c85f3[0], var_663c85f3[1], 0));
    zombie_forward = anglestoforward(zombie.angles);
    zombie_forward_2d = vectornormalize((zombie_forward[0], zombie_forward[1], 0));
    zombie_right = anglestoright(zombie.angles);
    zombie_right_2d = vectornormalize((zombie_right[0], zombie_right[1], 0));
    dot = vectordot(var_60c0153c, zombie_forward_2d);
    if (dot >= 0.5) {
        zombie.knockdown_direction = "front";
        zombie.getup_direction = "getup_back";
        return;
    }
    if (dot < 0.5 && dot > -0.5) {
        dot = vectordot(var_60c0153c, zombie_right_2d);
        if (dot > 0) {
            zombie.knockdown_direction = "right";
            if (math::cointoss()) {
                zombie.getup_direction = "getup_back";
            } else {
                zombie.getup_direction = "getup_belly";
            }
        } else {
            zombie.knockdown_direction = "left";
            zombie.getup_direction = "getup_belly";
        }
        return;
    }
    zombie.knockdown_direction = "back";
    zombie.getup_direction = "getup_belly";
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0x2f7a1da2, Offset: 0x5200
// Size: 0x18c
function function_fca24ca2(entity) {
    if (!ai::getaiattribute(entity, "can_be_furious")) {
        return false;
    }
    if (isdefined(entity.var_e78a1124) && entity.var_e78a1124) {
        return false;
    }
    var_1e735ae1 = getaiarchetypearray("apothicon_fury");
    count = 0;
    foreach (var_1b17e4fe in var_1e735ae1) {
        if (isdefined(var_1b17e4fe.var_e78a1124) && var_1b17e4fe.var_e78a1124) {
            count++;
        }
    }
    if (count >= 1) {
        return false;
    }
    var_85902fc3 = blackboard::getblackboardevents("apothicon_furious_mode");
    if (!var_85902fc3.size && entity.var_5598e222 >= 3) {
        return true;
    }
    return false;
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0xa45e8cb6, Offset: 0x5398
// Size: 0x140
function apothiconFuriousModeInit(entity) {
    if (!function_fca24ca2(entity)) {
        return;
    }
    var_d434d204 = spawnstruct();
    var_d434d204.origin = entity.origin;
    var_d434d204.entity = entity;
    blackboard::addblackboardevent("apothicon_furious_mode", var_d434d204, randomintrange(5000, 7000));
    entity function_1762804b(0);
    entity.var_e78a1124 = 1;
    blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_super_sprint");
    entity clientfield::set("furious_level", 1);
    entity.health *= 2;
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0x7b68c4df, Offset: 0x5590
// Size: 0xf8
function apothiconPreemptiveJukeService(entity) {
    if (!(isdefined(entity.var_e78a1124) && entity.var_e78a1124)) {
        return 0;
    }
    if (isdefined(entity.var_b948f7a) && entity.var_b948f7a > gettime()) {
        return 0;
    }
    if (isdefined(entity.enemy)) {
        if (!isplayer(entity.enemy)) {
            return 0;
        }
        if (entity.enemy playerads() < entity.nextpreemptivejukeads) {
            return 0;
        }
    }
    if (apothiconCanJuke(entity)) {
        entity.var_e88acff0 = 1;
    }
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0xaf69401, Offset: 0x5690
// Size: 0x2e
function apothiconPreemptiveJukePending(entity) {
    return isdefined(entity.var_e88acff0) && entity.var_e88acff0;
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0x4dcf272b, Offset: 0x56c8
// Size: 0x1c
function apothiconPreemptiveJukeDone(entity) {
    entity.var_e88acff0 = 0;
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0x2052786d, Offset: 0x56f0
// Size: 0x37a
function apothiconCanJuke(entity) {
    if (!ai::getaiattribute(entity, "can_juke")) {
        return false;
    }
    if (!isdefined(entity.enemy) || !isplayer(entity.enemy)) {
        return false;
    }
    if (isdefined(entity.isjuking) && entity.isjuking) {
        return false;
    }
    if (isdefined(entity.var_e88acff0) && entity.var_e88acff0) {
        return true;
    }
    if (isdefined(entity.var_b948f7a) && gettime() < entity.var_b948f7a) {
        return false;
    }
    jukeevents = blackboard::getblackboardevents("apothicon_fury_juke");
    tooclosejukedistancesqr = -6 * -6;
    foreach (event in jukeevents) {
        if (distance2dsquared(entity.origin, event.data.origin) <= tooclosejukedistancesqr) {
            return false;
        }
    }
    if (distance2dsquared(entity.origin, entity.enemy.origin) < -6 * -6) {
        return false;
    }
    if (!util::within_fov(entity.enemy.origin, entity.enemy.angles, entity.origin, 0.642)) {
        return false;
    }
    if (!util::within_fov(entity.origin, entity.angles, entity.enemy.origin, 0.642)) {
        return false;
    }
    if (isdefined(entity.jukemaxdistance) && isdefined(entity.enemy)) {
        maxdistsquared = entity.jukemaxdistance * entity.jukemaxdistance;
        if (distance2dsquared(entity.origin, entity.enemy.origin) > maxdistsquared) {
            return false;
        }
    }
    jukeinfo = function_e01b0078(entity);
    if (isdefined(jukeinfo)) {
        return true;
    }
    return false;
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0x49f6c65e, Offset: 0x5a78
// Size: 0x1dc
function apothiconJukeInit(entity) {
    jukeinfo = function_e01b0078(entity);
    assert(isdefined(jukeinfo));
    blackboard::setblackboardattribute(entity, "_juke_distance", jukeinfo.jukedistance);
    blackboard::setblackboardattribute(entity, "_juke_direction", jukeinfo.jukedirection);
    entity clearpath();
    entity notify(#"bhtn_action_notify", "apothicon_fury_juke");
    jukeinfo = spawnstruct();
    jukeinfo.origin = entity.origin;
    jukeinfo.entity = entity;
    blackboard::addblackboardevent("apothicon_fury_juke", jukeinfo, 6000);
    entity.nextpreemptivejukeads = randomfloatrange(0.6, 0.8);
    if (isdefined(level.var_d43705fc) && isdefined(level.var_1437a42)) {
        entity.var_64239c08 = gettime() + randomfloatrange(level.var_d43705fc, level.var_1437a42);
        return;
    }
    entity.var_b948f7a = gettime() + randomfloatrange(7000, 10000);
}

// Namespace namespace_53429ee4
// Params 3, eflags: 0x0
// Checksum 0x263b8263, Offset: 0x5c60
// Size: 0x2e4
function function_13fcf9f0(entity, entityradius, var_e7c0926f) {
    velocity = entity getvelocity();
    predictedpos = entity.origin + velocity * 0.1;
    var_a7e9532d = predictedpos + var_e7c0926f;
    if (!isdefined(var_a7e9532d)) {
        return undefined;
    }
    tracestart = var_a7e9532d + (0, 0, 70);
    traceend = var_a7e9532d + (0, 0, -70);
    trace = groundtrace(tracestart, traceend, 0, entity, 1, 1);
    var_c23f776 = trace["position"];
    if (!isdefined(var_c23f776)) {
        return undefined;
    }
    if (!ispointonnavmesh(var_c23f776)) {
        return undefined;
    }
    /#
        recordline(entity.origin, predictedpos, (0, 1, 0), "<dev string:x79>", entity);
    #/
    /#
        recordsphere(var_a7e9532d, 2, (1, 0, 0), "<dev string:x79>", entity);
    #/
    /#
        recordline(predictedpos, var_a7e9532d, (1, 0, 0), "<dev string:x79>", entity);
    #/
    if (ispointonnavmesh(var_c23f776, entity.entityradius * 2.5) && tracepassedonnavmesh(predictedpos, var_c23f776, entity.entityradius)) {
        if (!entity isposinclaimedlocation(var_c23f776) && entity maymovefrompointtopoint(predictedpos, var_c23f776, 0, 0)) {
            /#
                recordsphere(var_c23f776, 2, (0, 1, 0), "<dev string:x79>", entity);
            #/
            /#
                recordline(predictedpos, var_c23f776, (0, 1, 0), "<dev string:x79>", entity);
            #/
            return var_c23f776;
        }
    }
    return undefined;
}

// Namespace namespace_53429ee4
// Params 2, eflags: 0x4
// Checksum 0x5c33436, Offset: 0x5f50
// Size: 0xb4
function private function_66a87965(entity, var_414ee8c3) {
    var_59868845 = entity animmappingsearch(istring(var_414ee8c3));
    localdeltavector = getmovedelta(var_59868845, 0, 1, entity);
    endpoint = entity localtoworldcoords(localdeltavector);
    return endpoint - entity.origin;
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x4
// Checksum 0x26f833fa, Offset: 0x6010
// Size: 0x540
function private function_e01b0078(entity) {
    if (isdefined(entity.jukeinfo)) {
        return entity.jukeinfo;
    }
    directiontoenemy = vectornormalize(entity.enemy.origin - entity.origin);
    forwarddir = anglestoforward(entity.angles);
    var_ad84ab76 = [];
    var_c6b82dc9 = [];
    entityradius = entity.entityradius;
    var_e7c0926f = function_66a87965(entity, "anim_zombie_juke_left_long");
    var_c23f776 = function_13fcf9f0(entity, entityradius, var_e7c0926f);
    if (isdefined(var_c23f776)) {
        jukeinfo = new jukeinfo();
        jukeinfo.jukedirection = "left";
        jukeinfo.jukedistance = "long";
        jukeinfo.var_c23f776 = var_c23f776;
        if (!isdefined(var_ad84ab76)) {
            var_ad84ab76 = [];
        } else if (!isarray(var_ad84ab76)) {
            var_ad84ab76 = array(var_ad84ab76);
        }
        var_ad84ab76[var_ad84ab76.size] = jukeinfo;
    }
    var_e7c0926f = function_66a87965(entity, "anim_zombie_juke_right_long");
    var_c23f776 = function_13fcf9f0(entity, entityradius, var_e7c0926f);
    if (isdefined(var_c23f776)) {
        jukeinfo = new jukeinfo();
        jukeinfo.jukedirection = "right";
        jukeinfo.jukedistance = "long";
        jukeinfo.var_c23f776 = var_c23f776;
        if (!isdefined(var_ad84ab76)) {
            var_ad84ab76 = [];
        } else if (!isarray(var_ad84ab76)) {
            var_ad84ab76 = array(var_ad84ab76);
        }
        var_ad84ab76[var_ad84ab76.size] = jukeinfo;
    }
    var_e7c0926f = function_66a87965(entity, "anim_zombie_juke_left_front_long");
    var_c23f776 = function_13fcf9f0(entity, entityradius, var_e7c0926f);
    if (isdefined(var_c23f776)) {
        jukeinfo = new jukeinfo();
        jukeinfo.jukedirection = "left_front";
        jukeinfo.jukedistance = "long";
        jukeinfo.var_c23f776 = var_c23f776;
        if (!isdefined(var_ad84ab76)) {
            var_ad84ab76 = [];
        } else if (!isarray(var_ad84ab76)) {
            var_ad84ab76 = array(var_ad84ab76);
        }
        var_ad84ab76[var_ad84ab76.size] = jukeinfo;
    }
    var_e7c0926f = function_66a87965(entity, "anim_zombie_juke_right_front_long");
    var_c23f776 = function_13fcf9f0(entity, entityradius, var_e7c0926f);
    if (isdefined(var_c23f776)) {
        jukeinfo = new jukeinfo();
        jukeinfo.jukedirection = "right_front";
        jukeinfo.jukedistance = "long";
        jukeinfo.var_c23f776 = var_c23f776;
        if (!isdefined(var_ad84ab76)) {
            var_ad84ab76 = [];
        } else if (!isarray(var_ad84ab76)) {
            var_ad84ab76 = array(var_ad84ab76);
        }
        var_ad84ab76[var_ad84ab76.size] = jukeinfo;
    }
    if (var_ad84ab76.size) {
        jukeinfo = array::random(var_ad84ab76);
        jukeinfo.var_e3935316 = entity.angles;
        entity.var_c4140f42 = gettime();
        entity.jukeinfo = jukeinfo;
        return jukeinfo;
    }
    return undefined;
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0xa0a94412, Offset: 0x6558
// Size: 0x182
function function_76192844(entity) {
    if (entity.archetype != "apothicon_fury") {
        return;
    }
    entity ghost();
    entity notsolid();
    self clientfield::set("juke_active", 0);
    a_zombies = getaiarchetypearray("zombie");
    var_abbab1d4 = array::filter(a_zombies, 0, &function_9babb92c, entity, entity.origin);
    if (var_abbab1d4.size > 0) {
        foreach (zombie in var_abbab1d4) {
            function_6a78ff68(entity, zombie);
        }
    }
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0xfe1494fb, Offset: 0x66e8
// Size: 0x29a
function function_59f30845(entity) {
    if (entity.archetype != "apothicon_fury") {
        return;
    }
    if (isdefined(entity.traverseendnode)) {
        entity forceteleport(entity.traverseendnode.origin, entity.angles);
        entity unlink();
        entity.var_460cb1b3 = 0;
        entity notify(#"hash_4ce552e1");
        entity setrepairpaths(1);
        entity.blockingpain = 0;
        entity.usegoalanimweight = 0;
        entity.var_a5db58c6 = 0;
        entity asmsetanimationrate(1);
        entity finishtraversal();
        entity animmode("gravity", 1);
    }
    entity show();
    entity solid();
    self clientfield::set("juke_active", 1);
    a_zombies = getaiarchetypearray("zombie");
    var_abbab1d4 = array::filter(a_zombies, 0, &function_9babb92c, entity, entity.origin);
    if (var_abbab1d4.size > 0) {
        foreach (zombie in var_abbab1d4) {
            function_6a78ff68(entity, zombie);
        }
    }
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0xa5c82bb0, Offset: 0x6990
// Size: 0x64
function apothiconDeathStart(entity) {
    entity setmodel("c_zom_dlc4_apothicon_fury_dissolve");
    entity clientfield::set("apothicon_fury_death", 2);
    entity notsolid();
}

// Namespace namespace_53429ee4
// Params 1, eflags: 0x0
// Checksum 0xf2a9c16, Offset: 0x6a00
// Size: 0xc
function apothiconDeathTerminate(entity) {
    
}

// Namespace namespace_53429ee4
// Params 2, eflags: 0x0
// Checksum 0x9c467609, Offset: 0x6a18
// Size: 0x21c
function function_f4720f1b(entity, shitloc) {
    increment = 0;
    if (isinarray(array("helmet", "head", "neck"), shitloc)) {
        increment = 1;
    } else if (isinarray(array("torso_upper", "torso_mid"), shitloc)) {
        increment = 2;
    } else if (isinarray(array("torso_lower"), shitloc)) {
        increment = 3;
    } else if (isinarray(array("right_arm_upper", "right_arm_lower", "right_hand", "gun"), shitloc)) {
        increment = 4;
    } else if (isinarray(array("left_arm_upper", "left_arm_lower", "left_hand"), shitloc)) {
        increment = 5;
    } else if (isinarray(array("left_leg_upper", "left_leg_lower", "left_foot"), shitloc)) {
        increment = 7;
    } else {
        increment = 6;
    }
    entity clientfield::increment("fury_fire_damage", increment);
}

// Namespace namespace_53429ee4
// Params 13, eflags: 0x0
// Checksum 0xc3c3e5fa, Offset: 0x6c40
// Size: 0x120
function function_b68605e4(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
    if (!(isdefined(self.zombie_think_done) && self.zombie_think_done)) {
        return 0;
    }
    if (isdefined(eattacker) && isplayer(eattacker) && isdefined(shitloc)) {
        function_f4720f1b(self, shitloc);
    }
    if (isdefined(shitloc)) {
        if (!(isdefined(self.var_e78a1124) && self.var_e78a1124)) {
            self.var_5598e222 += 1;
        }
    }
    eattacker zombie_utility::show_hit_marker();
    return idamage;
}

// Namespace namespace_53429ee4
// Params 8, eflags: 0x0
// Checksum 0xc2ee274f, Offset: 0x6d68
// Size: 0x80
function function_9bed87a9(inflictor, attacker, damage, meansofdeath, weapon, dir, hitloc, var_3c7e9356) {
    self clientfield::set("apothicon_fury_death", 1);
    self notsolid();
    return damage;
}

#namespace namespace_1be547d;

// Namespace namespace_1be547d
// Params 4, eflags: 0x0
// Checksum 0xa8a8f42d, Offset: 0x6df0
// Size: 0x12a
function function_20a7d744(entity, attribute, oldvalue, value) {
    if (isdefined(entity.var_e78a1124) && entity.var_e78a1124) {
        return;
    }
    switch (value) {
    case "walk":
        blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_walk");
        break;
    case "run":
        blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_run");
        break;
    case "sprint":
        blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_sprint");
        break;
    case "super_sprint":
        blackboard::setblackboardattribute(entity, "_locomotion_speed", "locomotion_speed_super_sprint");
        break;
    default:
        break;
    }
}

