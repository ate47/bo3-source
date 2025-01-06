#using scripts/codescripts/struct;
#using scripts/mp/_util;
#using scripts/mp/gametypes/_shellshock;
#using scripts/mp/killstreaks/_airsupport;
#using scripts/mp/killstreaks/_killstreakrules;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/mp/killstreaks/_remote_weapons;
#using scripts/mp/teams/_teams;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/killstreaks_shared;
#using scripts/shared/math_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/weapons/_heatseekingmissile;

#namespace flak_drone;

// Namespace flak_drone
// Params 0, eflags: 0x0
// Checksum 0x37e19eb, Offset: 0x4c0
// Size: 0x5c
function init() {
    clientfield::register("vehicle", "flak_drone_camo", 1, 3, "int");
    vehicle::add_main_callback("veh_flak_drone_mp", &initflakdrone);
}

// Namespace flak_drone
// Params 0, eflags: 0x0
// Checksum 0x19a983d7, Offset: 0x528
// Size: 0x274
function initflakdrone() {
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self enableaimassist();
    self setneargoalnotifydist(40);
    self sethoverparams(50, 75, 100);
    self setvehicleavoidance(1);
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.vehaircraftcollisionenabled = 1;
    self.goalradius = 999999;
    self.goalheight = 999999;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self thread vehicle_ai::nudge_collision();
    self.overridevehicledamage = &flakdronedamageoverride;
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks("off").enter_func = &state_off_enter;
    self vehicle_ai::get_state_callbacks("off").update_func = &state_off_update;
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    self vehicle_ai::startinitialstate("off");
}

// Namespace flak_drone
// Params 1, eflags: 0x0
// Checksum 0xfce96088, Offset: 0x7a8
// Size: 0xc
function state_off_enter(params) {
    
}

// Namespace flak_drone
// Params 1, eflags: 0x0
// Checksum 0x54356057, Offset: 0x7c0
// Size: 0x498
function state_off_update(params) {
    self endon(#"change_state");
    self endon(#"death");
    while (!isdefined(self.parent)) {
        wait 0.1;
    }
    self.parent endon(#"death");
    while (true) {
        self setspeed(400);
        if (isdefined(self.inpain) && self.inpain) {
            wait 0.1;
        }
        self clearlookatent();
        self.current_pathto_pos = undefined;
        queryorigin = self.parent.origin + (0, 0, -75);
        queryresult = positionquery_source_navigation(queryorigin, 25, 75, 40, 40, self);
        if (isdefined(queryresult)) {
            positionquery_filter_distancetogoal(queryresult, self);
            vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
            best_point = undefined;
            best_score = -999999;
            foreach (point in queryresult.data) {
                randomscore = randomfloatrange(0, 100);
                disttooriginscore = point.disttoorigin2d * 0.2;
                point.score += randomscore + disttooriginscore;
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["<dev string:x28>"] = disttooriginscore;
                #/
                point.score += disttooriginscore;
                if (point.score > best_score) {
                    best_score = point.score;
                    best_point = point;
                }
            }
            self vehicle_ai::positionquery_debugscores(queryresult);
            if (isdefined(best_point)) {
                self.current_pathto_pos = best_point.origin;
            }
        }
        if (isdefined(self.current_pathto_pos)) {
            self updateflakdronespeed();
            if (self setvehgoalpos(self.current_pathto_pos, 1, 0)) {
                self playsound("veh_wasp_vox");
            } else {
                self setspeed(400 * 3);
                self.current_pathto_pos = self getclosestpointonnavvolume(self.origin, 999999);
                self setvehgoalpos(self.current_pathto_pos, 1, 0);
            }
        } else {
            if (isdefined(self.parent.heligoalpos)) {
                self.current_pathto_pos = self.parent.heligoalpos;
            } else {
                self.current_pathto_pos = queryorigin;
            }
            self updateflakdronespeed();
            self setvehgoalpos(self.current_pathto_pos, 1, 0);
        }
        wait randomfloatrange(0.1, 0.2);
    }
}

// Namespace flak_drone
// Params 0, eflags: 0x0
// Checksum 0x39139197, Offset: 0xc60
// Size: 0x16c
function updateflakdronespeed() {
    desiredspeed = 400;
    if (isdefined(self.parent)) {
        parentspeed = self.parent getspeed();
        desiredspeed = parentspeed * 0.9;
        if (distance2dsquared(self.parent.origin, self.origin) > 36 * 36) {
            if (isdefined(self.current_pathto_pos)) {
                flakdronedistancetogoalsquared = distance2dsquared(self.origin, self.current_pathto_pos);
                parentdistancetogoalsquared = distance2dsquared(self.parent.origin, self.current_pathto_pos);
                if (flakdronedistancetogoalsquared > parentdistancetogoalsquared) {
                    desiredspeed = parentspeed * 1.3;
                } else {
                    desiredspeed = parentspeed * 0.8;
                }
            }
        }
    }
    self setspeed(max(desiredspeed, 10));
}

// Namespace flak_drone
// Params 1, eflags: 0x0
// Checksum 0x3e966b2a, Offset: 0xdd8
// Size: 0xc
function state_combat_enter(params) {
    
}

// Namespace flak_drone
// Params 1, eflags: 0x0
// Checksum 0xc4a39e29, Offset: 0xdf0
// Size: 0x84
function state_combat_update(params) {
    drone = self;
    drone endon(#"change_state");
    drone endon(#"death");
    drone thread spawnflakrocket(drone.incoming_missile, drone.origin, drone.parent);
    drone ghost();
}

// Namespace flak_drone
// Params 3, eflags: 0x0
// Checksum 0x8e9090f1, Offset: 0xe80
// Size: 0x552
function spawnflakrocket(missile, spawnpos, parent) {
    drone = self;
    missile endon(#"death");
    missile missile_settarget(parent);
    rocket = magicbullet(getweapon("flak_drone_rocket"), spawnpos, missile.origin, parent, missile);
    rocket.team = parent.team;
    rocket setteam(parent.team);
    rocket clientfield::set("enemyvehicle", 1);
    rocket missile_settarget(missile);
    missile thread cleanupaftermissiledeath(rocket, drone);
    curdist = distance(missile.origin, rocket.origin);
    tooclosetopredictedparent = 0;
    /#
        debug_draw = getdvarint("<dev string:x35>", 0);
        debug_duration = getdvarint("<dev string:x51>", 400);
    #/
    while (true) {
        wait 0.05;
        prevdist = curdist;
        if (isdefined(rocket)) {
            curdist = distance(missile.origin, rocket.origin);
            distdelta = prevdist - curdist;
            predicteddist = curdist - distdelta;
        }
        /#
            if (debug_draw && isdefined(missile)) {
                util::debug_sphere(missile.origin, 6, (0.9, 0, 0), 0.9, debug_duration);
            }
            if (debug_draw && isdefined(rocket)) {
                util::debug_sphere(rocket.origin, 6, (0, 0, 0.9), 0.9, debug_duration);
            }
        #/
        if (isdefined(parent)) {
            parentvelocity = parent getvelocity();
            parentpredictedlocation = parent.origin + parentvelocity * 0.05;
            missilevelocity = missile getvelocity();
            missilepredictedlocation = missile.origin + missilevelocity * 0.05;
            if (distancesquared(parentpredictedlocation, missilepredictedlocation) < 1000 * 1000 || distancesquared(parent.origin, missilepredictedlocation) < 1000 * 1000) {
                tooclosetopredictedparent = 1;
            }
        }
        if (predicteddist < 0 || curdist > prevdist || tooclosetopredictedparent || !isdefined(rocket)) {
            /#
                if (debug_draw && isdefined(parent)) {
                    if (tooclosetopredictedparent && !(predicteddist < 0 || curdist > prevdist)) {
                        util::debug_sphere(parent.origin, 18, (0.9, 0, 0.9), 0.9, debug_duration);
                    } else {
                        util::debug_sphere(parent.origin, 18, (0, 0.9, 0), 0.9, debug_duration);
                    }
                }
            #/
            if (isdefined(rocket)) {
                rocket detonate();
            }
            missile thread heatseekingmissile::_missiledetonate(missile.target_attacker, missile.target_weapon, missile.target_weapon.explosionradius, 10, 20);
            return;
        }
    }
}

// Namespace flak_drone
// Params 2, eflags: 0x0
// Checksum 0xc9033e7, Offset: 0x13e0
// Size: 0x7c
function cleanupaftermissiledeath(rocket, flak_drone) {
    missile = self;
    missile waittill(#"death");
    wait 0.5;
    if (isdefined(rocket)) {
        rocket delete();
    }
    if (isdefined(flak_drone)) {
        flak_drone delete();
    }
}

// Namespace flak_drone
// Params 1, eflags: 0x0
// Checksum 0x8c585f2e, Offset: 0x1468
// Size: 0x1ac
function state_death_update(params) {
    self endon(#"death");
    dogibbeddeath = 0;
    if (isdefined(self.death_info)) {
        if (isdefined(self.death_info.weapon)) {
            if (self.death_info.weapon.dogibbing || self.death_info.weapon.doannihilate) {
                dogibbeddeath = 1;
            }
        }
        if (isdefined(self.death_info.meansofdeath)) {
            meansofdeath = self.death_info.meansofdeath;
            if (meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_PROJECTILE") {
                dogibbeddeath = 1;
            }
        }
    }
    if (dogibbeddeath) {
        self playsound("veh_wasp_gibbed");
        playfxontag("explosions/fx_vexp_wasp_gibb_death", self, "tag_origin");
        self ghost();
        self notsolid();
        wait 5;
        if (isdefined(self)) {
            self delete();
        }
        return;
    }
    self vehicle_death::flipping_shooting_death();
}

// Namespace flak_drone
// Params 3, eflags: 0x0
// Checksum 0xd2dbb037, Offset: 0x1620
// Size: 0x1c0
function drone_pain_for_time(time, stablizeparam, restorelookpoint) {
    self endon(#"death");
    self.painstarttime = gettime();
    if (!(isdefined(self.inpain) && self.inpain)) {
        self.inpain = 1;
        while (gettime() < self.painstarttime + time * 1000) {
            self setvehvelocity(self.velocity * stablizeparam);
            self setangularvelocity(self getangularvelocity() * stablizeparam);
            wait 0.1;
        }
        if (isdefined(restorelookpoint)) {
            restorelookent = spawn("script_model", restorelookpoint);
            restorelookent setmodel("tag_origin");
            self clearlookatent();
            self setlookatent(restorelookent);
            self setturrettargetent(restorelookent);
            wait 1.5;
            self clearlookatent();
            self clearturrettarget();
            restorelookent delete();
        }
        self.inpain = 0;
    }
}

// Namespace flak_drone
// Params 6, eflags: 0x0
// Checksum 0x78d06068, Offset: 0x17e8
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

// Namespace flak_drone
// Params 15, eflags: 0x0
// Checksum 0xa14d1829, Offset: 0x1918
// Size: 0xf8
function flakdronedamageoverride(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (smeansofdeath == "MOD_TRIGGER_HURT") {
        return 0;
    }
    if (isdefined(eattacker) && isdefined(eattacker.team) && eattacker.team != self.team) {
        drone_pain(eattacker, smeansofdeath, vpoint, vdir, shitloc, partname);
    }
    return idamage;
}

// Namespace flak_drone
// Params 2, eflags: 0x0
// Checksum 0x88b0c0fc, Offset: 0x1a18
// Size: 0x148
function spawn(parent, ondeathcallback) {
    if (!isnavvolumeloaded()) {
        /#
            iprintlnbold("<dev string:x76>");
        #/
        return undefined;
    }
    spawnpoint = parent.origin + (0, 0, -50);
    drone = spawnvehicle("veh_flak_drone_mp", spawnpoint, parent.angles, "dynamic_spawn_ai");
    drone.death_callback = ondeathcallback;
    drone configureteam(parent, 0);
    drone thread watchgameevents();
    drone thread watchdeath();
    drone thread watchparentdeath();
    drone thread watchparentmissiles();
    return drone;
}

// Namespace flak_drone
// Params 2, eflags: 0x0
// Checksum 0xa3fcef5b, Offset: 0x1b68
// Size: 0xc8
function configureteam(parent, ishacked) {
    drone = self;
    drone.team = parent.team;
    drone setteam(parent.team);
    if (ishacked) {
        drone clientfield::set("enemyvehicle", 2);
    } else {
        drone clientfield::set("enemyvehicle", 1);
    }
    drone.parent = parent;
}

// Namespace flak_drone
// Params 0, eflags: 0x0
// Checksum 0x9f9362de, Offset: 0x1c38
// Size: 0x7c
function watchgameevents() {
    drone = self;
    drone endon(#"death");
    drone.parent.owner util::waittill_any("game_ended", "emp_jammed", "disconnect", "joined_team");
    drone shutdown(1);
}

// Namespace flak_drone
// Params 0, eflags: 0x0
// Checksum 0xbed1327c, Offset: 0x1cc0
// Size: 0x54
function watchdeath() {
    drone = self;
    drone.parent endon(#"death");
    drone waittill(#"death");
    drone shutdown(1);
}

// Namespace flak_drone
// Params 0, eflags: 0x0
// Checksum 0x516321ab, Offset: 0x1d20
// Size: 0x54
function watchparentdeath() {
    drone = self;
    drone endon(#"death");
    drone.parent waittill(#"death");
    drone shutdown(1);
}

// Namespace flak_drone
// Params 0, eflags: 0x0
// Checksum 0x39f6565b, Offset: 0x1d80
// Size: 0xd4
function watchparentmissiles() {
    drone = self;
    drone endon(#"death");
    drone.parent endon(#"death");
    drone.parent waittill(#"stinger_fired_at_me", missile, weapon, attacker);
    drone.incoming_missile = missile;
    drone.incoming_missile.target_weapon = weapon;
    drone.incoming_missile.target_attacker = attacker;
    drone vehicle_ai::set_state("combat");
}

// Namespace flak_drone
// Params 1, eflags: 0x0
// Checksum 0x878a6971, Offset: 0x1e60
// Size: 0x2c
function setcamostate(state) {
    self clientfield::set("flak_drone_camo", state);
}

// Namespace flak_drone
// Params 1, eflags: 0x0
// Checksum 0xe815bb2b, Offset: 0x1e98
// Size: 0x13c
function shutdown(explode) {
    drone = self;
    if (isdefined(drone.death_callback)) {
        drone.parent thread [[ drone.death_callback ]]();
    }
    if (isdefined(drone) && !isdefined(drone.parent)) {
        drone ghost();
        drone notsolid();
        wait 5;
        if (isdefined(drone)) {
            drone delete();
        }
    }
    if (isdefined(drone)) {
        if (explode) {
            drone dodamage(drone.health + 1000, drone.origin, drone, drone, "none", "MOD_EXPLOSIVE");
            return;
        }
        drone delete();
    }
}

