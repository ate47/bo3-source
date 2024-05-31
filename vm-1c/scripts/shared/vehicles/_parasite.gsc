#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/systems/ai_interface;
#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/util_shared;
#using scripts/shared/array_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/math_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace parasite;

// Namespace parasite
// Params 0, eflags: 0x2
// Checksum 0x5e487077, Offset: 0x480
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("parasite", &__init__, undefined, undefined);
}

// Namespace parasite
// Params 0, eflags: 0x1 linked
// Checksum 0x68cc67be, Offset: 0x4c0
// Size: 0x12c
function __init__() {
    vehicle::add_main_callback("parasite", &function_41ba5057);
    clientfield::register("vehicle", "parasite_tell_fx", 1, 1, "int");
    clientfield::register("vehicle", "parasite_secondary_deathfx", 1, 1, "int");
    clientfield::register("toplayer", "parasite_damage", 1, 1, "counter");
    callback::on_spawned(&function_5f6cf4b2);
    ai::registermatchedinterface("parasite", "firing_rate", "slow", array("slow", "medium", "fast"));
}

// Namespace parasite
// Params 0, eflags: 0x1 linked
// Checksum 0x9b4ff9fc, Offset: 0x5f8
// Size: 0xd0
function function_5f6cf4b2() {
    self notify(#"hash_f6527ca9");
    self endon(#"hash_f6527ca9");
    self endon(#"death");
    while (true) {
        var_45e53fb5, e_attacker = self waittill(#"damage");
        if (isdefined(e_attacker.var_8a1ad3bb) && isdefined(e_attacker) && e_attacker.var_8a1ad3bb && !(isdefined(e_attacker.var_7c26245) && e_attacker.var_7c26245)) {
            self clientfield::increment_to_player("parasite_damage");
        }
    }
}

// Namespace parasite
// Params 1, eflags: 0x5 linked
// Checksum 0xa9e4aac1, Offset: 0x6d0
// Size: 0x118
function private is_target_valid(target) {
    if (!isdefined(target)) {
        return 0;
    }
    if (!isalive(target)) {
        return 0;
    }
    if (isplayer(target) && target.sessionstate == "spectator") {
        return 0;
    }
    if (isplayer(target) && target.sessionstate == "intermission") {
        return 0;
    }
    if (isdefined(target.ignoreme) && target.ignoreme) {
        return 0;
    }
    if (target isnotarget()) {
        return 0;
    }
    if (isdefined(self.var_f6999f70)) {
        return self [[ self.var_f6999f70 ]](target);
    }
    return 1;
}

// Namespace parasite
// Params 0, eflags: 0x1 linked
// Checksum 0xe03e2b16, Offset: 0x7f0
// Size: 0x13c
function function_d3d4f77c() {
    var_3daa9d01 = getplayers();
    least_hunted = var_3daa9d01[0];
    for (i = 0; i < var_3daa9d01.size; i++) {
        if (!isdefined(var_3daa9d01[i].hunted_by)) {
            var_3daa9d01[i].hunted_by = 0;
        }
        if (!is_target_valid(var_3daa9d01[i])) {
            continue;
        }
        if (!is_target_valid(least_hunted)) {
            least_hunted = var_3daa9d01[i];
        }
        if (var_3daa9d01[i].hunted_by < least_hunted.hunted_by) {
            least_hunted = var_3daa9d01[i];
        }
    }
    if (!is_target_valid(least_hunted)) {
        return undefined;
    }
    return least_hunted;
}

// Namespace parasite
// Params 1, eflags: 0x1 linked
// Checksum 0x65ed600e, Offset: 0x938
// Size: 0x104
function function_61692488(enemy) {
    if (!is_target_valid(enemy)) {
        return;
    }
    if (isdefined(self.parasiteenemy)) {
        if (!isdefined(self.parasiteenemy.hunted_by)) {
            self.parasiteenemy.hunted_by = 0;
        }
        if (self.parasiteenemy.hunted_by > 0) {
            self.parasiteenemy.hunted_by--;
        }
    }
    self.parasiteenemy = enemy;
    if (!isdefined(self.parasiteenemy.hunted_by)) {
        self.parasiteenemy.hunted_by = 0;
    }
    self.parasiteenemy.hunted_by++;
    self setlookatent(self.parasiteenemy);
    self setturrettargetent(self.parasiteenemy);
}

// Namespace parasite
// Params 0, eflags: 0x5 linked
// Checksum 0x30175cb4, Offset: 0xa48
// Size: 0x118
function private function_ec393181() {
    self endon(#"change_state");
    self endon(#"death");
    for (;;) {
        if (isdefined(self.ignoreall) && self.ignoreall) {
            wait(0.5);
            continue;
        }
        if (is_target_valid(self.parasiteenemy)) {
            wait(0.5);
            continue;
        }
        target = function_d3d4f77c();
        if (!isdefined(target)) {
            self.parasiteenemy = undefined;
        } else {
            self.parasiteenemy = target;
            self.parasiteenemy.hunted_by += 1;
            self setlookatent(self.parasiteenemy);
            self setturrettargetent(self.parasiteenemy);
        }
        wait(0.5);
    }
}

// Namespace parasite
// Params 0, eflags: 0x1 linked
// Checksum 0x7aa832e2, Offset: 0xb68
// Size: 0x24c
function function_41ba5057() {
    self useanimtree(#generic);
    blackboard::createblackboardforentity(self);
    self blackboard::registervehicleblackboardattributes();
    ai::createinterfaceforentity(self);
    blackboard::registerblackboardattribute(self, "_parasite_firing_rate", "slow", &function_639ba96b);
    if (isactor(self)) {
        /#
            self trackblackboardattribute("fast");
        #/
    }
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self enableaimassist();
    self setneargoalnotifydist(25);
    self setdrawinfrared(1);
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.vehaircraftcollisionenabled = 1;
    assert(isdefined(self.scriptbundlesettings));
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self.goalradius = 999999;
    self.goalheight = 4000;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self.var_8a1ad3bb = 1;
    self thread vehicle_ai::nudge_collision();
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
    defaultrole();
}

// Namespace parasite
// Params 0, eflags: 0x1 linked
// Checksum 0x62c42a9d, Offset: 0xdc0
// Size: 0xe4
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    self vehicle_ai::call_custom_add_state_callbacks();
    vehicle_ai::startinitialstate("combat");
}

// Namespace parasite
// Params 0, eflags: 0x1 linked
// Checksum 0xbd541fa4, Offset: 0xeb0
// Size: 0x22
function function_639ba96b() {
    return self ai::get_behavior_attribute("firing_rate");
}

// Namespace parasite
// Params 1, eflags: 0x1 linked
// Checksum 0x6284f85c, Offset: 0xee0
// Size: 0x12c
function state_death_update(params) {
    self endon(#"death");
    self asmrequestsubstate("death@stationary");
    if (isdefined(self.parasiteenemy) && isdefined(self.parasiteenemy.hunted_by)) {
        self.parasiteenemy.hunted_by--;
    }
    self setphysacceleration((0, 0, -300));
    self.vehcheckforpredictedcrash = 1;
    self thread vehicle_death::death_fx();
    self playsound("zmb_parasite_explo");
    self util::waittill_notify_or_timeout("veh_predictedcollision", 4);
    self clientfield::set("parasite_secondary_deathfx", 1);
    wait(0.2);
    self delete();
}

// Namespace parasite
// Params 1, eflags: 0x1 linked
// Checksum 0x5dd13a44, Offset: 0x1018
// Size: 0x5c
function state_combat_enter(params) {
    if (isdefined(self.owner) && isdefined(self.owner.enemy)) {
        self.parasiteenemy = self.owner.enemy;
    }
    self thread function_ec393181();
}

// Namespace parasite
// Params 1, eflags: 0x1 linked
// Checksum 0x3e2505c, Offset: 0x1080
// Size: 0x480
function state_combat_update(params) {
    self endon(#"change_state");
    self endon(#"death");
    lasttimechangeposition = 0;
    self.shouldgotonewposition = 0;
    self.lasttimetargetinsight = 0;
    self.var_d475d13 = 0;
    self asmrequestsubstate("locomotion@movement");
    for (;;) {
        if (isdefined(self.var_2ef8c407)) {
            self setspeed(self.var_2ef8c407);
        } else {
            self setspeed(self.settings.defaultmovespeed);
        }
        if (isdefined(self.inpain) && self.inpain) {
            wait(0.1);
            continue;
        }
        if (!isdefined(self.parasiteenemy)) {
            wait(0.25);
            continue;
        }
        if (self.goalforced) {
            returndata = [];
            returndata["origin"] = self getclosestpointonnavvolume(self.goalpos, 100);
            returndata["centerOnNav"] = ispointinnavvolume(self.origin, "navvolume_small");
        } else if (isdefined(self.var_e62301a4) && (randomint(100) < self.settings.jukeprobability && !(isdefined(self.var_d475d13) && self.var_d475d13) || self.var_e62301a4)) {
            returndata = function_efac5bc3();
            self.var_d475d13 = 1;
            self.var_e62301a4 = undefined;
        } else {
            returndata = getnextmoveposition_tactical();
            self.var_d475d13 = 0;
        }
        self.current_pathto_pos = returndata["origin"];
        if (isdefined(self.current_pathto_pos)) {
            if (isdefined(self.stucktime)) {
                self.stucktime = undefined;
            }
            if (self setvehgoalpos(self.current_pathto_pos, 1, returndata["centerOnNav"])) {
                self thread path_update_interrupt();
                self playsound("zmb_vocals_parasite_juke");
                self vehicle_ai::waittill_pathing_done(5);
            } else {
                wait(0.1);
            }
        } else if (!(isdefined(returndata["centerOnNav"]) && returndata["centerOnNav"])) {
            if (!isdefined(self.stucktime)) {
                self.stucktime = gettime();
            }
            if (gettime() - self.stucktime > 10000) {
                self dodamage(self.health + 100, self.origin);
            }
        }
        if (isdefined(self.var_d475d13) && self.var_d475d13) {
            if (randomint(100) < 50 && isdefined(self.parasiteenemy) && distance2dsquared(self.origin, self.parasiteenemy.origin) < 64 * 64) {
                self.parasiteenemy dodamage(self.settings.meleedamage, self.parasiteenemy.origin, self);
            } else {
                self function_be283ba2(self.var_d475d13);
            }
            continue;
        }
        if (randomint(100) < 30) {
            self function_be283ba2(self.var_d475d13);
        }
    }
}

// Namespace parasite
// Params 1, eflags: 0x1 linked
// Checksum 0x6d287e87, Offset: 0x1508
// Size: 0x2cc
function function_be283ba2(var_1fc3b33b) {
    if (isdefined(self.parasiteenemy) && self function_4246bc05(self.parasiteenemy) && distance2dsquared(self.parasiteenemy.origin, self.origin) < 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax) * 3 * 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax) * 3) {
        self asmrequestsubstate("fire@stationary");
        self playsound("zmb_vocals_parasite_preattack");
        self clientfield::set("parasite_tell_fx", 1);
        self waittill(#"hash_ca2c801b");
        if (isdefined(self.parasiteenemy) && self function_4246bc05(self.parasiteenemy) && distance2dsquared(self.parasiteenemy.origin, self.origin) < 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax) * 3 * 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax) * 3) {
            self setturrettargetent(self.parasiteenemy, self.parasiteenemy getvelocity() * 0.3);
        }
        self vehicle_ai::waittill_asm_complete("fire@stationary", 5);
        self asmrequestsubstate("locomotion@movement");
        self clientfield::set("parasite_tell_fx", 0);
        if (!var_1fc3b33b) {
            wait(randomfloatrange(0.25, 0.5));
        }
        return;
    }
    wait(randomfloatrange(1, 2));
}

// Namespace parasite
// Params 0, eflags: 0x1 linked
// Checksum 0x943dfa33, Offset: 0x17e0
// Size: 0x72e
function getnextmoveposition_tactical() {
    self endon(#"change_state");
    self endon(#"death");
    selfdisttotarget = distance2d(self.origin, self.parasiteenemy.origin);
    gooddist = 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax);
    closedist = 1.2 * gooddist;
    fardist = 3 * gooddist;
    querymultiplier = mapfloat(closedist, fardist, 1, 3, selfdisttotarget);
    preferedheightrange = 0.5 * (self.settings.engagementheightmax - self.settings.engagementheightmin);
    randomness = 30;
    queryresult = positionquery_source_navigation(self.origin, 75, -31 * querymultiplier, 75, 20 * querymultiplier, self, 20 * querymultiplier);
    if (!(isdefined(queryresult.centeronnav) && queryresult.centeronnav)) {
        self.vehaircraftcollisionenabled = 0;
    } else {
        self.vehaircraftcollisionenabled = 1;
    }
    positionquery_filter_distancetogoal(queryresult, self);
    vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
    self vehicle_ai::positionquery_filter_engagementdist(queryresult, self.parasiteenemy, self.settings.engagementdistmin, self.settings.engagementdistmax);
    goalheight = self.parasiteenemy.origin[2] + 0.5 * (self.settings.engagementheightmin + self.settings.engagementheightmax);
    best_point = undefined;
    best_score = -999999;
    trace_count = 0;
    foreach (point in queryresult.data) {
        if (!(isdefined(queryresult.centeronnav) && queryresult.centeronnav)) {
            if (sighttracepassed(self.origin, point.origin, 0, undefined)) {
                trace_count++;
                if (trace_count > 3) {
                    wait(0.05);
                    trace_count = 0;
                }
                if (!bullettracepassed(self.origin, point.origin, 0, self)) {
                    continue;
                }
            } else {
                continue;
            }
        }
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["fast"] = randomfloatrange(0, randomness);
        #/
        point.score += randomfloatrange(0, randomness);
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["fast"] = point.distawayfromengagementarea * -1;
        #/
        point.score += point.distawayfromengagementarea * -1;
        distfrompreferredheight = abs(point.origin[2] - goalheight);
        if (distfrompreferredheight > preferedheightrange) {
            heightscore = mapfloat(0, 500, 0, 2000, distfrompreferredheight);
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["fast"] = heightscore * -1;
            #/
            point.score += heightscore * -1;
        }
        if (point.score > best_score) {
            best_score = point.score;
            best_point = point;
        }
    }
    self vehicle_ai::positionquery_debugscores(queryresult);
    /#
        if (isdefined(getdvarint("fast")) && getdvarint("fast")) {
            recordline(self.origin, best_point.origin, (0.3, 1, 0));
            recordline(self.origin, self.parasiteenemy.origin, (1, 0, 0.4));
        }
    #/
    returndata = [];
    returndata["origin"] = isdefined(best_point) ? best_point.origin : undefined;
    returndata["centerOnNav"] = queryresult.centeronnav;
    return returndata;
}

// Namespace parasite
// Params 0, eflags: 0x1 linked
// Checksum 0x6e44752, Offset: 0x1f18
// Size: 0x72e
function function_efac5bc3() {
    self endon(#"change_state");
    self endon(#"death");
    selfdisttotarget = distance2d(self.origin, self.parasiteenemy.origin);
    gooddist = 0.5 * (self.settings.forwardjukeengagementdistmin + self.settings.forwardjukeengagementdistmax);
    closedist = 1.2 * gooddist;
    fardist = 3 * gooddist;
    querymultiplier = mapfloat(closedist, fardist, 1, 3, selfdisttotarget);
    preferedheightrange = 0.5 * (self.settings.forwardjukeengagementheightmax - self.settings.forwardjukeengagementheightmin);
    randomness = 30;
    queryresult = positionquery_source_navigation(self.origin, 75, 300 * querymultiplier, 75, 20 * querymultiplier, self, 20 * querymultiplier);
    if (!(isdefined(queryresult.centeronnav) && queryresult.centeronnav)) {
        self.vehaircraftcollisionenabled = 0;
    } else {
        self.vehaircraftcollisionenabled = 1;
    }
    positionquery_filter_distancetogoal(queryresult, self);
    vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
    self vehicle_ai::positionquery_filter_engagementdist(queryresult, self.parasiteenemy, self.settings.forwardjukeengagementdistmin, self.settings.forwardjukeengagementdistmax);
    goalheight = self.parasiteenemy.origin[2] + 0.5 * (self.settings.forwardjukeengagementheightmin + self.settings.forwardjukeengagementheightmax);
    best_point = undefined;
    best_score = -999999;
    trace_count = 0;
    foreach (point in queryresult.data) {
        if (!(isdefined(queryresult.centeronnav) && queryresult.centeronnav)) {
            if (sighttracepassed(self.origin, point.origin, 0, undefined)) {
                trace_count++;
                if (trace_count > 3) {
                    wait(0.05);
                    trace_count = 0;
                }
                if (!bullettracepassed(self.origin, point.origin, 0, self)) {
                    continue;
                }
            } else {
                continue;
            }
        }
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["fast"] = randomfloatrange(0, randomness);
        #/
        point.score += randomfloatrange(0, randomness);
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["fast"] = point.distawayfromengagementarea * -1;
        #/
        point.score += point.distawayfromengagementarea * -1;
        distfrompreferredheight = abs(point.origin[2] - goalheight);
        if (distfrompreferredheight > preferedheightrange) {
            heightscore = mapfloat(0, 500, 0, 2000, distfrompreferredheight);
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["fast"] = heightscore * -1;
            #/
            point.score += heightscore * -1;
        }
        if (point.score > best_score) {
            best_score = point.score;
            best_point = point;
        }
    }
    self vehicle_ai::positionquery_debugscores(queryresult);
    /#
        if (isdefined(getdvarint("fast")) && getdvarint("fast")) {
            recordline(self.origin, best_point.origin, (0.3, 1, 0));
            recordline(self.origin, self.parasiteenemy.origin, (1, 0, 0.4));
        }
    #/
    returndata = [];
    returndata["origin"] = isdefined(best_point) ? best_point.origin : undefined;
    returndata["centerOnNav"] = queryresult.centeronnav;
    return returndata;
}

// Namespace parasite
// Params 0, eflags: 0x1 linked
// Checksum 0xfa8d0fa8, Offset: 0x2650
// Size: 0xb4
function path_update_interrupt() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"near_goal");
    self endon(#"reached_end_node");
    wait(1);
    while (true) {
        if (isdefined(self.current_pathto_pos)) {
            if (distance2dsquared(self.current_pathto_pos, self.goalpos) > self.goalradius * self.goalradius) {
                wait(0.2);
                self.var_e62301a4 = 1;
                self notify(#"near_goal");
            }
        }
        wait(0.2);
    }
}

// Namespace parasite
// Params 3, eflags: 0x1 linked
// Checksum 0xd13122f6, Offset: 0x2710
// Size: 0x1e0
function drone_pain_for_time(time, stablizeparam, restorelookpoint) {
    self endon(#"death");
    self.painstarttime = gettime();
    if (!(isdefined(self.inpain) && self.inpain)) {
        self.inpain = 1;
        self playsound("zmb_vocals_parasite_pain");
        while (gettime() < self.painstarttime + time * 1000) {
            self setvehvelocity(self.velocity * stablizeparam);
            self setangularvelocity(self getangularvelocity() * stablizeparam);
            wait(0.1);
        }
        if (isdefined(restorelookpoint)) {
            restorelookent = spawn("script_model", restorelookpoint);
            restorelookent setmodel("tag_origin");
            self clearlookatent();
            self setlookatent(restorelookent);
            self setturrettargetent(restorelookent);
            wait(1.5);
            self clearlookatent();
            self clearturrettarget();
            restorelookent delete();
        }
        self.inpain = 0;
    }
}

// Namespace parasite
// Params 6, eflags: 0x0
// Checksum 0x3b977153, Offset: 0x28f8
// Size: 0x124
function drone_pain(eattacker, damagetype, hitpoint, hitdirection, hitlocationinfo, partname) {
    if (!(isdefined(self.inpain) && self.inpain)) {
        yaw_vel = math::randomsign() * randomfloatrange(280, 320);
        ang_vel = self getangularvelocity();
        ang_vel += (randomfloatrange(-120, -100), yaw_vel, randomfloatrange(-200, -56));
        self setangularvelocity(ang_vel);
        self thread drone_pain_for_time(0.8, 0.7);
    }
}

