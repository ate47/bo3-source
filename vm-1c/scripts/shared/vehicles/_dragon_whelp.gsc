#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/systems/gib;
#using scripts/shared/animation_shared;
#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/array_shared;
#using scripts/shared/system_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/math_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_e81d2518;

// Namespace namespace_e81d2518
// Params 0, eflags: 0x2
// namespace_e81d2518<file_0>::function_2dc19561
// Checksum 0x95a02dce, Offset: 0x330
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("dragon", &__init__, undefined, undefined);
}

// Namespace namespace_e81d2518
// Params 0, eflags: 0x1 linked
// namespace_e81d2518<file_0>::function_8c87d8eb
// Checksum 0x19735ddb, Offset: 0x370
// Size: 0x2c
function __init__() {
    vehicle::add_main_callback("dragon", &function_20bd34e1);
}

// Namespace namespace_e81d2518
// Params 0, eflags: 0x1 linked
// namespace_e81d2518<file_0>::function_20bd34e1
// Checksum 0x6e1fc824, Offset: 0x3a8
// Size: 0x23c
function function_20bd34e1() {
    self useanimtree(#generic);
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    if (isdefined(self.scriptbundlesettings)) {
        self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    }
    assert(isdefined(self.settings));
    self setneargoalnotifydist(self.radius * 1.5);
    self sethoverparams(self.radius, self.settings.defaultmovespeed * 2, self.radius);
    self setspeed(self.settings.defaultmovespeed);
    blackboard::createblackboardforentity(self);
    self blackboard::registervehicleblackboardattributes();
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.vehaircraftcollisionenabled = 0;
    self.goalradius = 9999999;
    self.goalheight = 512;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self.delete_on_death = 1;
    self.overridevehicledamage = &function_110bfc7e;
    self.allowfriendlyfiredamageoverride = &function_cce3e8b4;
    self.ignoreme = 1;
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
    defaultrole();
}

// Namespace namespace_e81d2518
// Params 0, eflags: 0x1 linked
// namespace_e81d2518<file_0>::function_b272dd98
// Checksum 0xb07a22bd, Offset: 0x5f0
// Size: 0x178
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    if (sessionmodeiszombiesgame()) {
        self vehicle_ai::add_state("power_up", undefined, &function_b9f1655e, undefined);
        self vehicle_ai::add_utility_connection("combat", "power_up", &function_1d2da0bd);
        self vehicle_ai::add_utility_connection("power_up", "combat");
    }
    /#
        setdvar("sentinel_drone", 0);
    #/
    self thread function_cd3112cf();
    vehicle_ai::startinitialstate("combat");
    self.starttime = gettime();
}

// Namespace namespace_e81d2518
// Params 1, eflags: 0x5 linked
// namespace_e81d2518<file_0>::function_cb8b2163
// Checksum 0x301a319a, Offset: 0x770
// Size: 0x1be
function private function_cb8b2163(target) {
    if (!isdefined(target)) {
        return false;
    }
    if (!isalive(target)) {
        return false;
    }
    if (isdefined(self.intermission) && self.intermission) {
        return false;
    }
    if (isdefined(target.ignoreme) && target.ignoreme) {
        return false;
    }
    if (target isnotarget()) {
        return false;
    }
    if (isdefined(target.var_8f05bccc) && target.var_8f05bccc) {
        return false;
    }
    if (distancesquared(self.owner.origin, target.origin) > self.settings.var_1ca0fb66 * self.settings.var_1ca0fb66) {
        return false;
    }
    if (self function_4246bc05(target)) {
        return true;
    }
    if (isactor(target) && target cansee(self.owner)) {
        return true;
    }
    if (isvehicle(target) && target function_4246bc05(self.owner)) {
        return true;
    }
    return false;
}

// Namespace namespace_e81d2518
// Params 0, eflags: 0x5 linked
// namespace_e81d2518<file_0>::function_e2991906
// Checksum 0xc3db2b33, Offset: 0x938
// Size: 0x29c
function private function_e2991906() {
    var_e5d98e1 = getaiteamarray("axis");
    distsqr = 10000 * 10000;
    var_4faf77e2 = undefined;
    foreach (enemy in var_e5d98e1) {
        var_5e0faa15 = distance2dsquared(enemy.origin, self.owner.origin);
        if (function_cb8b2163(enemy)) {
            if (enemy.archetype === "raz") {
                var_5e0faa15 = max(distance2d(enemy.origin, self.owner.origin) - 700, 0);
                var_5e0faa15 *= var_5e0faa15;
            } else if (enemy.archetype === "sentinel_drone") {
                var_5e0faa15 = max(distance2d(enemy.origin, self.owner.origin) - 500, 0);
                var_5e0faa15 *= var_5e0faa15;
            } else if (enemy === self.var_a924686c) {
                var_5e0faa15 = max(distance2d(enemy.origin, self.owner.origin) - 300, 0);
                var_5e0faa15 *= var_5e0faa15;
            }
            if (var_5e0faa15 < distsqr) {
                distsqr = var_5e0faa15;
                var_4faf77e2 = enemy;
            }
        }
    }
    return var_4faf77e2;
}

// Namespace namespace_e81d2518
// Params 0, eflags: 0x5 linked
// namespace_e81d2518<file_0>::function_cd3112cf
// Checksum 0x9ce7bf64, Offset: 0xbe0
// Size: 0x100
function private function_cd3112cf() {
    self endon(#"death");
    for (;;) {
        if (!isdefined(self.owner)) {
            wait(0.25);
            continue;
        }
        if (isdefined(self.ignoreall) && self.ignoreall) {
            wait(0.25);
            continue;
        }
        /#
            if (getdvarint("sentinel_drone", 0)) {
                if (isdefined(self.var_a924686c)) {
                    line(self.origin, self.var_a924686c.origin, (1, 0, 0), 1, 0, 5);
                }
            }
        #/
        target = function_e2991906();
        if (!isdefined(target)) {
            self.var_a924686c = undefined;
        } else {
            self.var_a924686c = target;
        }
        wait(0.25);
    }
}

// Namespace namespace_e81d2518
// Params 1, eflags: 0x1 linked
// namespace_e81d2518<file_0>::function_b9f1655e
// Checksum 0x6ac2c56b, Offset: 0xce8
// Size: 0x264
function function_b9f1655e(params) {
    self endon(#"change_state");
    self endon(#"death");
    var_b60e80ad = 10000 * 10000;
    closest = undefined;
    foreach (powerup in level.active_powerups) {
        powerup.var_1f752edc = self getclosestpointonnavvolume(powerup.origin, 100);
        if (!isdefined(powerup.var_1f752edc)) {
            continue;
        }
        distsqr = distancesquared(powerup.origin, self.origin);
        if (distsqr < var_b60e80ad) {
            var_b60e80ad = distsqr;
            closest = powerup;
        }
    }
    if (isdefined(closest) && distsqr < 2000 * 2000) {
        self setvehgoalpos(closest.var_1f752edc, 1, 1);
        if (vehicle_ai::waittill_pathresult()) {
            self vehicle_ai::waittill_pathing_done();
        }
        if (isdefined(closest)) {
            trace = bullettrace(self.origin, closest.origin, 0, self);
            if (trace["fraction"] == 1) {
                self setvehgoalpos(closest.origin, 1, 0);
            }
        }
    }
    self vehicle_ai::evaluate_connections();
}

// Namespace namespace_e81d2518
// Params 3, eflags: 0x1 linked
// namespace_e81d2518<file_0>::function_1d2da0bd
// Checksum 0x5c589533, Offset: 0xf58
// Size: 0x5a
function function_1d2da0bd(from_state, to_state, connection) {
    if (level.var_9bcba4b8 === 1) {
        return false;
    }
    if (isdefined(self.var_a924686c)) {
        return false;
    }
    if (level.active_powerups.size < 1) {
        return false;
    }
    return true;
}

// Namespace namespace_e81d2518
// Params 1, eflags: 0x1 linked
// namespace_e81d2518<file_0>::function_c637f0c1
// Checksum 0x170a7e76, Offset: 0xfc0
// Size: 0x850
function state_combat_update(params) {
    self endon(#"change_state");
    self endon(#"death");
    var_b609e490 = 300;
    self asmrequestsubstate("locomotion@movement");
    while (!isdefined(self.owner)) {
        wait(0.05);
    }
    self thread function_a7242558();
    for (;;) {
        self setspeed(self.settings.defaultmovespeed);
        self asmrequestsubstate("locomotion@movement");
        if (isdefined(self.owner) && distance2dsquared(self.origin, self.owner.origin) < var_b609e490 * var_b609e490 && ispointinnavvolume(self.origin, "navvolume_small")) {
            if (!isdefined(self.current_pathto_pos)) {
                self.current_pathto_pos = self getclosestpointonnavvolume(self.origin, 100);
            }
            self setvehgoalpos(self.current_pathto_pos, 1, 0);
            wait(0.1);
            continue;
        }
        if (isdefined(self.owner)) {
            queryresult = positionquery_source_navigation(self.origin, 0, 256, 90, self.radius, self);
            sighttarget = undefined;
            if (isdefined(self.var_a924686c)) {
                sighttarget = self.var_a924686c geteye();
                positionquery_filter_sight(queryresult, sighttarget, (0, 0, 0), self, 4);
            }
            if (isdefined(queryresult.centeronnav) && queryresult.centeronnav) {
                ownerorigin = self.owner.origin;
                ownerforward = anglestoforward(self.owner.angles);
                best_point = undefined;
                best_score = -999999;
                foreach (point in queryresult.data) {
                    distsqr = distance2dsquared(point.origin, ownerorigin);
                    if (distsqr > var_b609e490 * var_b609e490) {
                        /#
                            if (!isdefined(point._scoredebug)) {
                                point._scoredebug = [];
                            }
                            point._scoredebug["sentinel_drone"] = sqrt(distsqr) * -1 * 2;
                        #/
                        point.score += sqrt(distsqr) * -1 * 2;
                    }
                    if (isdefined(point.visibility) && point.visibility) {
                        if (bullettracepassed(point.origin, sighttarget, 0, self)) {
                            /#
                                if (!isdefined(point._scoredebug)) {
                                    point._scoredebug = [];
                                }
                                point._scoredebug["sentinel_drone"] = 400;
                            #/
                            point.score += 400;
                        }
                    }
                    var_21402bcb = point.origin - ownerorigin;
                    var_3fb78d52 = vectornormalize((var_21402bcb[0], var_21402bcb[1], 0));
                    if (vectordot(ownerforward, var_3fb78d52) > 0.34) {
                        if (abs(var_21402bcb[2]) < 100) {
                            /#
                                if (!isdefined(point._scoredebug)) {
                                    point._scoredebug = [];
                                }
                                point._scoredebug["sentinel_drone"] = 300;
                            #/
                            point.score += 300;
                        } else if (abs(var_21402bcb[2]) < -56) {
                            /#
                                if (!isdefined(point._scoredebug)) {
                                    point._scoredebug = [];
                                }
                                point._scoredebug["sentinel_drone"] = 100;
                            #/
                            point.score += 100;
                        }
                    }
                    if (point.score > best_score) {
                        best_score = point.score;
                        best_point = point;
                    }
                }
                self vehicle_ai::positionquery_debugscores(queryresult);
                if (isdefined(best_point)) {
                    /#
                        if (isdefined(getdvarint("sentinel_drone")) && getdvarint("sentinel_drone")) {
                            recordline(self.origin, best_point.origin, (0.3, 1, 0));
                            recordline(self.origin, self.owner.origin, (1, 0, 0.4));
                        }
                    #/
                    if (distancesquared(self.origin, best_point.origin) > 50 * 50) {
                        self.current_pathto_pos = best_point.origin;
                        self setvehgoalpos(self.current_pathto_pos, 1, 1);
                        self vehicle_ai::waittill_pathing_done(5);
                    } else {
                        self vehicle_ai::cooldown("move_cooldown", 4);
                    }
                }
            } else {
                function_3f19103d();
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_e81d2518
// Params 0, eflags: 0x1 linked
// namespace_e81d2518<file_0>::function_a7242558
// Checksum 0x36fdcf4, Offset: 0x1818
// Size: 0x250
function function_a7242558() {
    self endon(#"change_state");
    self endon(#"death");
    for (;;) {
        wait(0.1);
        self vehicle_ai::evaluate_connections();
        if (!self vehicle_ai::iscooldownready("attack")) {
            continue;
        }
        if (!isdefined(self.var_a924686c)) {
            continue;
        }
        self setlookatent(self.var_a924686c);
        if (!self function_4246bc05(self.var_a924686c)) {
            continue;
        }
        if (distance2dsquared(self.var_a924686c.origin, self.owner.origin) > self.settings.var_1ca0fb66 * self.settings.var_1ca0fb66) {
            continue;
        }
        eyeoffset = (self.var_a924686c geteye() - self.var_a924686c.origin) * 0.6;
        if (!bullettracepassed(self.origin, self.var_a924686c geteye() - eyeoffset, 0, self, self.var_a924686c)) {
            self.var_a924686c = undefined;
            continue;
        }
        aimoffset = self.var_a924686c getvelocity() * 0.3 - eyeoffset;
        self setturrettargetent(self.var_a924686c, aimoffset);
        wait(0.2);
        if (isdefined(self.var_a924686c)) {
            self fireweapon(0, self.var_a924686c, (0, 0, 0), self);
            self vehicle_ai::cooldown("attack", 1);
        }
    }
}

// Namespace namespace_e81d2518
// Params 0, eflags: 0x1 linked
// namespace_e81d2518<file_0>::function_3f19103d
// Checksum 0x43d208c4, Offset: 0x1a70
// Size: 0x2ac
function function_3f19103d() {
    queryresult = positionquery_source_navigation(self.origin, 0, 100, 90, self.radius, self);
    for (multiplier = 2; queryresult.data.size < 1; multiplier += 2) {
        queryresult = positionquery_source_navigation(self.origin, 0, 100 * multiplier, 90 * multiplier, self.radius * multiplier, self);
    }
    if (queryresult.data.size && !queryresult.centeronnav) {
        best_point = undefined;
        best_score = 999999;
        foreach (point in queryresult.data) {
            point.score = abs(point.origin[2] - queryresult.origin[2]);
            if (point.score < best_score) {
                best_score = point.score;
                best_point = point;
            }
        }
        if (isdefined(best_point)) {
            self setneargoalnotifydist(2);
            point = best_point;
            self.current_pathto_pos = point.origin;
            foundpath = self setvehgoalpos(self.current_pathto_pos, 1, 0);
            if (foundpath) {
                self vehicle_ai::waittill_pathing_done(5);
            }
            self setneargoalnotifydist(self.radius);
        }
    }
}

// Namespace namespace_e81d2518
// Params 4, eflags: 0x1 linked
// namespace_e81d2518<file_0>::function_cce3e8b4
// Checksum 0xf44b4151, Offset: 0x1d28
// Size: 0x26
function function_cce3e8b4(einflictor, eattacker, smeansofdeath, weapon) {
    return false;
}

// Namespace namespace_e81d2518
// Params 15, eflags: 0x1 linked
// namespace_e81d2518<file_0>::function_110bfc7e
// Checksum 0x5610bcb2, Offset: 0x1d58
// Size: 0x94
function function_110bfc7e(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (self.var_3966756f !== 1) {
        return 0;
    }
    return idamage;
}

// Namespace namespace_e81d2518
// Params 1, eflags: 0x1 linked
// namespace_e81d2518<file_0>::function_c18559a5
// Checksum 0xb059842e, Offset: 0x1df8
// Size: 0xfc
function state_death_update(params) {
    self endon(#"death");
    attacker = params.inflictor;
    if (!isdefined(attacker)) {
        attacker = params.attacker;
    }
    if (isai(attacker) || (!isdefined(self.owner) || attacker !== self && self.owner !== attacker) && isplayer(attacker)) {
        self.damage_on_death = 0;
        wait(0.05);
        attacker = params.inflictor;
        if (!isdefined(attacker)) {
            attacker = params.attacker;
        }
    }
    self vehicle_ai::defaultstate_death_update();
}

