#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/clientfield_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/array_shared;
#using scripts/shared/system_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/math_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace spider;

// Namespace spider
// Params 0, eflags: 0x2
// Checksum 0xa74609dc, Offset: 0x350
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("spider", &__init__, undefined, undefined);
}

// Namespace spider
// Params 0, eflags: 0x0
// Checksum 0xedff3f6d, Offset: 0x390
// Size: 0x4c
function __init__() {
    vehicle::add_main_callback("spider", &function_324383cf);
    /#
        setdvar("<unknown string>", 0);
    #/
}

// Namespace spider
// Params 0, eflags: 0x0
// Checksum 0x53836053, Offset: 0x3e8
// Size: 0x20
function function_cf5bff6d() {
    return getdvarint("debug_spider_noswitch", 0) === 1;
}

// Namespace spider
// Params 0, eflags: 0x0
// Checksum 0xfd7e6885, Offset: 0x410
// Size: 0x20c
function function_324383cf() {
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.delete_on_death = 1;
    self.health = self.healthdefault;
    self useanimtree(#generic);
    self vehicle::friendly_fire_shield();
    /#
        assert(isdefined(self.scriptbundlesettings));
    #/
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self enableaimassist();
    self setdrawinfrared(1);
    blackboard::createblackboardforentity(self);
    self blackboard::registervehicleblackboardattributes();
    self setneargoalnotifydist(40);
    self.goalradius = 999999;
    self.goalheight = 999999;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self function_2ea2374c(3);
    self.overridevehicledamage = &function_3a74b130;
    self thread vehicle_ai::nudge_collision();
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
    self asmrequestsubstate("locomotion@movement");
    defaultrole();
}

// Namespace spider
// Params 0, eflags: 0x0
// Checksum 0x8394e942, Offset: 0x628
// Size: 0x16c
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("combat").update_func = &function_871ab92b;
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    self vehicle_ai::get_state_callbacks("driving").update_func = &state_driving_update;
    self vehicle_ai::add_state("meleeCombat", undefined, &function_1336e598, undefined);
    vehicle_ai::add_utility_connection("combat", "meleeCombat", &function_e58a0df0);
    vehicle_ai::add_utility_connection("meleeCombat", "combat", &function_cc5dfd2b);
    self vehicle_ai::call_custom_add_state_callbacks();
    vehicle_ai::startinitialstate("combat");
}

// Namespace spider
// Params 1, eflags: 0x0
// Checksum 0xccb6ae92, Offset: 0x7a0
// Size: 0x84
function state_death_update(params) {
    self endon(#"death");
    self asmrequestsubstate("death@stationary");
    vehicle_ai::waittill_asm_complete("death@stationary", 2);
    self vehicle_death::death_fx();
    vehicle_death::deletewhensafe(10);
}

// Namespace spider
// Params 1, eflags: 0x0
// Checksum 0x72e28aa, Offset: 0x830
// Size: 0x3c
function state_driving_update(params) {
    self endon(#"change_state");
    self endon(#"death");
    self asmrequestsubstate("locomotion@aggressive");
}

// Namespace spider
// Params 1, eflags: 0x0
// Checksum 0x76b3f6c9, Offset: 0x878
// Size: 0x652
function function_4a95b514(enemy) {
    if (self.goalforced) {
        return self.goalpos;
    }
    selfdisttotarget = distance2d(self.origin, enemy.origin);
    gooddist = 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax);
    tooclosedist = -106;
    closedist = 1.2 * gooddist;
    fardist = 3 * gooddist;
    querymultiplier = mapfloat(closedist, fardist, 1, 3, selfdisttotarget);
    prefereddistawayfromorigin = 300;
    randomness = 30;
    queryresult = positionquery_source_navigation(self.origin, 80, 300 * querymultiplier, 150, 2 * self.radius * querymultiplier, self, 1 * self.radius * querymultiplier);
    positionquery_filter_distancetogoal(queryresult, self);
    vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
    positionquery_filter_inclaimedlocation(queryresult, self);
    vehicle_ai::positionquery_filter_engagementdist(queryresult, enemy, self.settings.engagementdistmin, self.settings.engagementdistmax);
    if (isdefined(self.avoidentities) && isdefined(self.avoidentitiesdistance)) {
        vehicle_ai::positionquery_filter_distawayfromtarget(queryresult, self.avoidentities, self.avoidentitiesdistance, -500);
    }
    best_point = undefined;
    best_score = -999999;
    foreach (point in queryresult.data) {
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<unknown string>"] = mapfloat(0, prefereddistawayfromorigin, 0, 300, point.disttoorigin2d);
        #/
        point.score += mapfloat(0, prefereddistawayfromorigin, 0, 300, point.disttoorigin2d);
        if (point.inclaimedlocation) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<unknown string>"] = -500;
            #/
            point.score += -500;
        }
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<unknown string>"] = randomfloatrange(0, randomness);
        #/
        point.score += randomfloatrange(0, randomness);
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<unknown string>"] = point.distawayfromengagementarea * -1;
        #/
        point.score += point.distawayfromengagementarea * -1;
        if (point.score > best_score) {
            best_score = point.score;
            best_point = point;
        }
    }
    self vehicle_ai::positionquery_debugscores(queryresult);
    /#
        self.debug_ai_move_to_points_considered = queryresult.data;
    #/
    if (!isdefined(best_point)) {
        return undefined;
    }
    /#
        if (isdefined(getdvarint("<unknown string>")) && getdvarint("<unknown string>")) {
            recordline(self.origin, best_point.origin, (0.3, 1, 0));
            recordline(self.origin, enemy.origin, (1, 0, 0.4));
        }
    #/
    return best_point.origin;
}

// Namespace spider
// Params 1, eflags: 0x0
// Checksum 0x1cd3a38f, Offset: 0xed8
// Size: 0x2a8
function function_871ab92b(params) {
    self endon(#"change_state");
    self endon(#"death");
    self.pathfailcount = 0;
    self.foundpath = 1;
    if (params.var_9665e95e === 1) {
        self vehicle_ai::clearallmovement(1);
        self asmrequestsubstate("exit@aggressive");
        self vehicle_ai::waittill_asm_complete("exit@aggressive", 1.6);
    }
    self vehicle_ai::cooldown("state_change", 15);
    self thread prevent_stuck();
    self thread nudge_collision();
    self thread function_fba2b8dc();
    self setspeed(self.settings.defaultmovespeed);
    self asmrequestsubstate("locomotion@movement");
    self.dont_move = undefined;
    for (;;) {
        if (!isdefined(self.enemy)) {
            self force_get_enemies();
            wait(0.1);
            continue;
        } else if (self.dont_move === 1) {
            wait(0.1);
            continue;
        }
        if (isdefined(self.var_26115c14)) {
            if (!self [[ self.var_26115c14 ]]()) {
                wait(0.1);
                continue;
            }
        }
        if (!self function_6d424c6f(self.enemy, 5)) {
            self.current_pathto_pos = function_c56b4eb5();
        } else {
            self.current_pathto_pos = function_4a95b514(self.enemy);
        }
        if (isdefined(self.current_pathto_pos)) {
            if (self setvehgoalpos(self.current_pathto_pos, 0, 1)) {
                self vehicle_ai::waittill_pathing_done();
            }
        }
        wait(0.05);
    }
}

// Namespace spider
// Params 0, eflags: 0x0
// Checksum 0xbaf6f0db, Offset: 0x1188
// Size: 0x2c8
function function_fba2b8dc() {
    self endon(#"change_state");
    self endon(#"death");
    for (;;) {
        if (!isdefined(self.enemy)) {
            wait(0.1);
            continue;
        }
        state_params = spawnstruct();
        state_params.var_9665e95e = 1;
        self vehicle_ai::evaluate_connections(undefined, state_params);
        var_877ce1c0 = 1;
        foreach (player in level.players) {
            self getperfectinfo(player, 0);
            if (player.b_is_designated_target === 1 && self.enemy.b_is_designated_target !== 1) {
                self getperfectinfo(player, 1);
                self setpersonalthreatbias(player, 100000, 2);
                var_877ce1c0 = 0;
            }
        }
        if (var_877ce1c0) {
            if (self function_4246bc05(self.enemy)) {
                self setlookatent(self.enemy);
                self setturrettargetent(self.enemy);
            }
            if (distance2dsquared(self.origin, self.enemy.origin) < self.settings.engagementdistmax * 1.5 * self.settings.engagementdistmax * 1.5 && vehicle_ai::iscooldownready("rocket") && self function_4246bc05(self.enemy)) {
                self function_8959bf3f(self.enemy);
                wait(0.5);
            }
        }
        wait(0.1);
    }
}

// Namespace spider
// Params 1, eflags: 0x0
// Checksum 0xf82d5c3, Offset: 0x1458
// Size: 0x2ce
function function_8959bf3f(enemy) {
    self notify(#"near_goal");
    self vehicle_ai::clearallmovement(1);
    self.dont_move = 1;
    self setlookatent(enemy);
    self setturrettargetent(enemy);
    self setvehgoalpos(enemy.origin, 0, 0);
    var_cd8c9d1a = 30;
    v_to_enemy = ((enemy.origin - self.origin)[0], (enemy.origin - self.origin)[1], 0);
    goalangles = vectortoangles(v_to_enemy);
    anglediff = absangleclamp180(self.angles[1] - goalangles[1]);
    var_278525e3 = gettime();
    while (anglediff > var_cd8c9d1a && vehicle_ai::timesince(var_278525e3) < 0.8) {
        anglediff = absangleclamp180(self.angles[1] - goalangles[1]);
        wait(0.05);
    }
    self vehicle_ai::clearallmovement(1);
    if (anglediff <= var_cd8c9d1a) {
        self asmrequestsubstate("fire@stationary");
        timedout = self util::waittill_notify_or_timeout("spider_fire", 5);
        if (timedout !== 1) {
            self fireweapon();
            self vehicle_ai::cooldown("rocket", 3);
            self vehicle_ai::waittill_asm_complete("fire@stationary", 5);
        }
    }
    self asmrequestsubstate("locomotion@movement");
    self.dont_move = undefined;
}

// Namespace spider
// Params 0, eflags: 0x0
// Checksum 0x19fac02d, Offset: 0x1730
// Size: 0x10
function function_31e4a04e() {
    self.var_31e4a04e = 1;
}

// Namespace spider
// Params 3, eflags: 0x0
// Checksum 0xd612e025, Offset: 0x1748
// Size: 0x118
function function_e58a0df0(from_state, to_state, connection) {
    /#
        if (function_cf5bff6d()) {
            return false;
        }
    #/
    if (!vehicle_ai::iscooldownready("state_change")) {
        return false;
    }
    if (!isdefined(self.enemy)) {
        return false;
    }
    if (distance2dsquared(self.origin, self.enemy.origin) < self.settings.meleedist * self.settings.meleedist && (self.var_31e4a04e === 1 || abs(self.origin[2] - self.enemy.origin[2]) < self.settings.meleedist)) {
        return true;
    }
    return false;
}

// Namespace spider
// Params 1, eflags: 0x0
// Checksum 0x7f7bf01b, Offset: 0x1868
// Size: 0x8fc
function function_1336e598(params) {
    self endon(#"change_state");
    self endon(#"death");
    if (params.var_9665e95e === 1) {
        self vehicle_ai::clearallmovement(1);
        self asmrequestsubstate("enter@aggressive");
        self vehicle_ai::waittill_asm_complete("enter@aggressive", 1.6);
    }
    self vehicle_ai::cooldown("state_change", 8);
    self thread prevent_stuck();
    self thread nudge_collision();
    self thread function_ba139f03();
    self.pathfailcount = 0;
    self.var_31e4a04e = undefined;
    self setspeed(self.settings.defaultmovespeed * 1.5);
    self asmrequestsubstate("locomotion@aggressive");
    self.dont_move = undefined;
    wait(0.5);
    for (;;) {
        foreach (player in level.players) {
            self getperfectinfo(player, 1);
            if (player.b_is_designated_target === 1) {
                self setpersonalthreatbias(player, 100000, 3);
            }
        }
        if (!isdefined(self.enemy)) {
            self force_get_enemies();
            wait(0.1);
            continue;
        } else if (self.dont_move === 1) {
            wait(0.1);
            continue;
        }
        if (isdefined(self.var_26115c14)) {
            if (!self [[ self.var_26115c14 ]]()) {
                wait(0.1);
                continue;
            }
        }
        self.foundpath = 0;
        targetpos = function_c56b4eb5();
        if (isdefined(targetpos)) {
            if (distancesquared(self.origin, targetpos) > 1000 * 1000 && self isposinclaimedlocation(targetpos)) {
                queryresult = positionquery_source_navigation(targetpos, 0, self.settings.max_move_dist, self.settings.max_move_dist, self.radius, self);
                positionquery_filter_inclaimedlocation(queryresult, self.enemy);
                best_point = undefined;
                best_score = -999999;
                foreach (point in queryresult.data) {
                    /#
                        if (!isdefined(point._scoredebug)) {
                            point._scoredebug = [];
                        }
                        point._scoredebug["<unknown string>"] = mapfloat(0, -56, 0, -200, distance(point.origin, queryresult.origin));
                    #/
                    point.score += mapfloat(0, -56, 0, -200, distance(point.origin, queryresult.origin));
                    /#
                        if (!isdefined(point._scoredebug)) {
                            point._scoredebug = [];
                        }
                        point._scoredebug["<unknown string>"] = mapfloat(50, -56, 0, -200, abs(point.origin[2] - queryresult.origin[2]));
                    #/
                    point.score += mapfloat(50, -56, 0, -200, abs(point.origin[2] - queryresult.origin[2]));
                    if (point.inclaimedlocation === 1) {
                        /#
                            if (!isdefined(point._scoredebug)) {
                                point._scoredebug = [];
                            }
                            point._scoredebug["<unknown string>"] = -500;
                        #/
                        point.score += -500;
                    }
                    if (point.score > best_score) {
                        best_score = point.score;
                        best_point = point;
                    }
                }
                self vehicle_ai::positionquery_debugscores(queryresult);
                if (isdefined(best_point)) {
                    targetpos = best_point.origin;
                }
            }
            self setvehgoalpos(targetpos, 0, 1);
            self.foundpath = self vehicle_ai::waittill_pathresult();
            if (self.foundpath) {
                self.current_pathto_pos = targetpos;
                self thread function_cb06aa1d();
                self.pathfailcount = 0;
                self vehicle_ai::waittill_pathing_done();
            }
        }
        if (!self.foundpath) {
            self.pathfailcount++;
            if (self.pathfailcount > 2) {
                if (isdefined(self.enemy)) {
                    self setpersonalthreatbias(self.enemy, -2000, 5);
                }
            }
            wait(0.1);
            queryresult = positionquery_source_navigation(self.origin, 0, self.settings.max_move_dist, self.settings.max_move_dist, self.radius, self);
            if (queryresult.data.size) {
                point = queryresult.data[randomint(queryresult.data.size)];
                self setvehgoalpos(point.origin, 0, 0);
                self.current_pathto_pos = undefined;
                self thread function_cb06aa1d();
                wait(2);
                self notify(#"near_goal");
            }
        }
        wait(0.2);
    }
}

// Namespace spider
// Params 0, eflags: 0x0
// Checksum 0x5eb596ae, Offset: 0x2170
// Size: 0x1f8
function function_ba139f03() {
    self endon(#"change_state");
    self endon(#"death");
    for (;;) {
        state_params = spawnstruct();
        state_params.var_9665e95e = 1;
        if (!isdefined(self.enemy)) {
            wait(0.1);
            self vehicle_ai::evaluate_connections(undefined, state_params);
            continue;
        }
        self vehicle_ai::evaluate_connections(undefined, state_params);
        if (self function_4246bc05(self.enemy)) {
            self setlookatent(self.enemy);
            self setturrettargetent(self.enemy);
        }
        if (distance2dsquared(self.origin, self.enemy.origin) < self.settings.var_52e9fd3c * self.settings.var_52e9fd3c && self function_4246bc05(self.enemy)) {
            if (bullettracepassed(self.origin + (0, 0, 10), self.enemy.origin + (0, 0, 20), 0, self, self.enemy, 0, 1)) {
                self function_e0748df2(self.enemy);
                wait(0.5);
            }
        }
        wait(0.1);
    }
}

// Namespace spider
// Params 1, eflags: 0x0
// Checksum 0x2d3d41e8, Offset: 0x2370
// Size: 0x186
function function_e0748df2(enemy) {
    self notify(#"near_goal");
    self vehicle_ai::clearallmovement(1);
    self.dont_move = 1;
    self asmrequestsubstate("melee@stationary");
    timedout = self util::waittill_notify_or_timeout("spider_melee", 3);
    if (timedout !== 1) {
        if (isalive(enemy) && distance2dsquared(self.origin, enemy.origin) < self.settings.var_52e9fd3c * 1.2 * self.settings.var_52e9fd3c * 1.2) {
            enemy dodamage(self.settings.meleedamage, self.origin, self, self);
        }
        self vehicle_ai::waittill_asm_complete("melee@stationary", 2);
    }
    self asmrequestsubstate("locomotion@aggressive");
    self.dont_move = undefined;
}

// Namespace spider
// Params 3, eflags: 0x0
// Checksum 0x77c1f3dd, Offset: 0x2500
// Size: 0x100
function function_cc5dfd2b(from_state, to_state, connection) {
    /#
        if (function_cf5bff6d()) {
            return false;
        }
    #/
    if (self.pathfailcount > 4) {
        return true;
    }
    if (!vehicle_ai::iscooldownready("state_change")) {
        return false;
    }
    if (isalive(self.enemy) && distance2dsquared(self.origin, self.enemy.origin) > self.settings.meleedist * 4 * self.settings.meleedist * 4) {
        return true;
    }
    if (!isdefined(self.enemy)) {
        return true;
    }
    return false;
}

// Namespace spider
// Params 0, eflags: 0x0
// Checksum 0x177167b9, Offset: 0x2608
// Size: 0xfa
function prevent_stuck() {
    self endon(#"change_state");
    self endon(#"death");
    self notify(#"end_prevent_stuck");
    self endon(#"end_prevent_stuck");
    wait(2);
    count = 0;
    previous_origin = undefined;
    while (true) {
        if (isdefined(previous_origin) && distancesquared(previous_origin, self.origin) < 0.1 * 0.1 && !(isdefined(level.bzm_worldpaused) && level.bzm_worldpaused)) {
            count++;
        } else {
            previous_origin = self.origin;
            count = 0;
        }
        if (count > 10) {
            self.pathfailcount = 10;
        }
        wait(1);
    }
}

// Namespace spider
// Params 0, eflags: 0x0
// Checksum 0xdef7e0b6, Offset: 0x2710
// Size: 0x376
function function_c56b4eb5() {
    if (self.goalforced) {
        return self.goalpos;
    }
    if (isdefined(self.settings.all_knowing)) {
        if (isdefined(self.enemy)) {
            target_pos = self.enemy.origin;
        }
    } else {
        target_pos = vehicle_ai::gettargetpos(vehicle_ai::getenemytarget());
    }
    enemy = self.enemy;
    if (isdefined(target_pos)) {
        target_pos_onnavmesh = getclosestpointonnavmesh(target_pos, self.settings.detonation_distance * 1.5, self.radius, 16777183);
    }
    if (!isdefined(target_pos_onnavmesh)) {
        if (isdefined(self.enemy)) {
            self setpersonalthreatbias(self.enemy, -2000, 5);
        }
        if (isdefined(self.current_pathto_pos) && distancesquared(self.origin, self.current_pathto_pos) > self.settings.var_52e9fd3c * self.settings.var_52e9fd3c) {
            return self.current_pathto_pos;
        } else {
            return undefined;
        }
    } else if (isdefined(self.enemy)) {
        if (distancesquared(target_pos, target_pos_onnavmesh) > self.settings.detonation_distance * 0.9 * self.settings.detonation_distance * 0.9) {
            self setpersonalthreatbias(self.enemy, -2000, 5);
        }
    }
    if (isdefined(enemy) && isplayer(enemy)) {
        enemy_vel_offset = enemy getvelocity() * 0.5;
        enemy_look_dir_offset = anglestoforward(enemy.angles);
        if (distance2dsquared(self.origin, enemy.origin) > 500 * 500) {
            enemy_look_dir_offset *= 110;
        } else {
            enemy_look_dir_offset *= 35;
        }
        offset = enemy_vel_offset + enemy_look_dir_offset;
        offset = (offset[0], offset[1], 0);
        if (tracepassedonnavmesh(target_pos_onnavmesh, target_pos + offset)) {
            target_pos += offset;
        } else {
            target_pos = target_pos_onnavmesh;
        }
    } else {
        target_pos = target_pos_onnavmesh;
    }
    return target_pos;
}

// Namespace spider
// Params 0, eflags: 0x0
// Checksum 0xa5c3f363, Offset: 0x2a90
// Size: 0x2e4
function function_cb06aa1d() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"near_goal");
    self endon(#"reached_end_node");
    self notify(#"hash_5ce56002");
    self endon(#"hash_5ce56002");
    wait(0.1);
    while (true) {
        if (isdefined(self.current_pathto_pos)) {
            if (distance2dsquared(self.current_pathto_pos, self.goalpos) > self.goalradius * self.goalradius) {
                wait(0.5);
                self notify(#"near_goal");
            }
            targetpos = function_c56b4eb5();
            if (isdefined(targetpos)) {
                if (distancesquared(self.origin, targetpos) > 1000 * 1000) {
                    repath_range = self.settings.repath_range * 2;
                    wait(0.1);
                } else {
                    repath_range = self.settings.repath_range;
                }
                if (distance2dsquared(self.current_pathto_pos, targetpos) > repath_range * repath_range) {
                    self notify(#"near_goal");
                }
            }
            if (isdefined(self.enemy) && isplayer(self.enemy)) {
                forward = anglestoforward(self.enemy getplayerangles());
                var_fa7adad9 = self.origin - self.enemy.origin;
                speedtouse = self.settings.defaultmovespeed * 2;
                if (vectordot(forward, var_fa7adad9) > 0) {
                    self setspeed(speedtouse);
                } else {
                    self setspeed(speedtouse * 0.75);
                }
            } else {
                speedtouse = self.settings.defaultmovespeed * 2;
                self setspeed(speedtouse);
            }
            wait(0.2);
            continue;
        }
        wait(0.4);
    }
}

// Namespace spider
// Params 0, eflags: 0x0
// Checksum 0x7ca8e1f4, Offset: 0x2d80
// Size: 0x118
function nudge_collision() {
    self endon(#"death");
    self endon(#"change_state");
    self notify(#"end_nudge_collision");
    self endon(#"end_nudge_collision");
    while (true) {
        velocity, normal = self waittill(#"veh_collision");
        ang_vel = self getangularvelocity() * 0.8;
        self setangularvelocity(ang_vel);
        if (isalive(self) && vectordot(normal, (0, 0, 1)) < 0.5) {
            self setvehvelocity(self.velocity + normal * 400);
        }
    }
}

// Namespace spider
// Params 0, eflags: 0x0
// Checksum 0xf2ef97a5, Offset: 0x2ea0
// Size: 0xbc
function force_get_enemies() {
    foreach (player in level.players) {
        if (self util::isenemyplayer(player) && !player.ignoreme) {
            self getperfectinfo(player, 1);
            return;
        }
    }
}

// Namespace spider
// Params 15, eflags: 0x0
// Checksum 0x3ff0a9ea, Offset: 0x2f68
// Size: 0xb8
function function_3a74b130(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isalive(eattacker) && eattacker.team === self.team) {
        return 0;
    }
    return idamage;
}

