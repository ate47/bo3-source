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
// Checksum 0x5c3827f6, Offset: 0x4b0
// Size: 0x52
function init() {
    clientfield::register("vehicle", "flak_drone_camo", 1, 3, "int");
    vehicle::add_main_callback("veh_flak_drone_mp", &initflakdrone);
}

// Namespace flak_drone
// Params 0, eflags: 0x0
// Checksum 0xc81727b, Offset: 0x510
// Size: 0x222
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
// Checksum 0xdfbc374, Offset: 0x740
// Size: 0xa
function state_off_enter(params) {
    
}

// Namespace flak_drone
// Params 1, eflags: 0x0
// Checksum 0xc9d53892, Offset: 0x758
// Size: 0x36d
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
            if (self setvehgoalpos(self.current_pathto_pos, 1, 0)) {
                self playsound("veh_wasp_vox");
            } else {
                self setspeed(400 * 3);
                self.current_pathto_pos = self getclosestpointonnavvolume(self.origin, 999999);
                self setvehgoalpos(self.current_pathto_pos, 1, 0);
            }
        } else {
            self setspeed(400 * 3);
            if (isdefined(self.parent.heligoalpos)) {
                self.current_pathto_pos = self.parent.heligoalpos;
            } else {
                self.current_pathto_pos = queryorigin;
            }
            self setvehgoalpos(self.current_pathto_pos, 1, 0);
        }
        wait randomfloatrange(0.2, 0.3);
    }
}

// Namespace flak_drone
// Params 1, eflags: 0x0
// Checksum 0x48228b55, Offset: 0xad0
// Size: 0xa
function state_combat_enter(params) {
    
}

// Namespace flak_drone
// Params 1, eflags: 0x0
// Checksum 0xe9b5b9f6, Offset: 0xae8
// Size: 0x62
function state_combat_update(params) {
    drone = self;
    drone endon(#"change_state");
    drone endon(#"death");
    drone thread spawnflakrocket(drone.incoming_missile, drone.origin, drone.parent);
    drone delete();
}

// Namespace flak_drone
// Params 3, eflags: 0x0
// Checksum 0x10e23598, Offset: 0xb58
// Size: 0x1f9
function spawnflakrocket(missile, spawnpos, parent) {
    missile endon(#"death");
    missile missile_settarget(parent);
    rocket = magicbullet(getweapon("flak_drone_rocket"), spawnpos, missile.origin, parent, missile);
    rocket.team = parent.team;
    rocket setteam(parent.team);
    rocket clientfield::set("enemyvehicle", 1);
    rocket missile_settarget(missile);
    prevdist = distancesquared(missile.origin, rocket.origin);
    distdelta = 0;
    itercount = 1;
    var_44f86afb = distdelta;
    while (true) {
        wait 0.05;
        curdist = distancesquared(missile.origin, rocket.origin);
        distdelta = prevdist - curdist;
        var_44f86afb += distdelta;
        if (curdist < prevdist) {
            prevdist = curdist;
        }
        var_685d92dc = var_44f86afb / itercount;
        predicteddist = curdist - var_685d92dc;
        if (predicteddist < var_685d92dc || curdist > prevdist) {
            rocket detonate();
            missile thread heatseekingmissile::_missiledetonate(missile.target_attacker, missile.target_weapon, missile.target_weapon.explosionradius, 10, -56);
            return;
        }
        itercount++;
    }
}

// Namespace flak_drone
// Params 1, eflags: 0x0
// Checksum 0xbf482a72, Offset: 0xd60
// Size: 0x162
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
// Checksum 0xf6681d5f, Offset: 0xed0
// Size: 0x152
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
// Checksum 0x8227103b, Offset: 0x1030
// Size: 0xfa
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
// Checksum 0x93d71024, Offset: 0x1138
// Size: 0xbc
function flakdronedamageoverride(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(eattacker) && isdefined(eattacker.team) && eattacker.team != self.team) {
        drone_pain(eattacker, smeansofdeath, vpoint, vdir, shitloc, partname);
    }
    return idamage;
}

// Namespace flak_drone
// Params 2, eflags: 0x0
// Checksum 0x1bd90545, Offset: 0x1200
// Size: 0xfc
function spawn(parent, ondeathcallback) {
    if (!isnavvolumeloaded()) {
        /#
            iprintlnbold("<dev string:x35>");
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
// Checksum 0x4277522a, Offset: 0x1308
// Size: 0x8e
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
// Checksum 0x4431a3b4, Offset: 0x13a0
// Size: 0x6a
function watchgameevents() {
    drone = self;
    drone endon(#"death");
    drone.parent.owner util::waittill_any("game_ended", "emp_jammed", "disconnect", "joined_team");
    drone shutdown(1);
}

// Namespace flak_drone
// Params 0, eflags: 0x0
// Checksum 0x91f61e30, Offset: 0x1418
// Size: 0x3a
function watchdeath() {
    drone = self;
    drone.parent endon(#"death");
    drone waittill(#"death");
    drone shutdown(1);
}

// Namespace flak_drone
// Params 0, eflags: 0x0
// Checksum 0x50403751, Offset: 0x1460
// Size: 0x3a
function watchparentdeath() {
    drone = self;
    drone endon(#"death");
    drone.parent waittill(#"death");
    drone shutdown(1);
}

// Namespace flak_drone
// Params 0, eflags: 0x0
// Checksum 0x719fc494, Offset: 0x14a8
// Size: 0xa2
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
// Checksum 0x638009a7, Offset: 0x1558
// Size: 0x22
function setcamostate(state) {
    self clientfield::set("flak_drone_camo", state);
}

// Namespace flak_drone
// Params 1, eflags: 0x0
// Checksum 0xf94cad8a, Offset: 0x1588
// Size: 0xea
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

