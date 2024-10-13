#using scripts/shared/weapons/_spike_charge_siegebot;
#using scripts/shared/turret_shared;
#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/array_shared;
#using scripts/shared/system_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/math_shared;
#using scripts/shared/gameskill_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace siegebot;

// Namespace siegebot
// Params 0, eflags: 0x2
// Checksum 0xe902de76, Offset: 0x498
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("siegebot", &__init__, undefined, undefined);
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0xe10f2703, Offset: 0x4d8
// Size: 0x2c
function __init__() {
    vehicle::add_main_callback("siegebot", &function_fcf49d56);
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0x34518660, Offset: 0x510
// Size: 0x3d4
function function_fcf49d56() {
    self useanimtree(#generic);
    blackboard::createblackboardforentity(self);
    self blackboard::registervehicleblackboardattributes();
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    target_set(self, (0, 0, 84));
    self enableaimassist();
    self setneargoalnotifydist(40);
    self.fovcosine = 0.5;
    self.fovcosinebusy = 0.5;
    self.maxsightdistsqrd = 10000 * 10000;
    assert(isdefined(self.scriptbundlesettings));
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self.goalradius = 9999999;
    self.goalheight = 5000;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self.overridevehicledamage = &function_3b05fc1b;
    self function_f3e02741();
    self function_6e075bdf(0, self.settings.gunner_turret_on_target_range);
    self asmrequestsubstate("locomotion@movement");
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(0.5);
        self hidepart("tag_turret_canopy_animate");
        self hidepart("tag_turret_panel_01_d0");
        self hidepart("tag_turret_panel_02_d0");
        self hidepart("tag_turret_panel_03_d0");
        self hidepart("tag_turret_panel_04_d0");
        self hidepart("tag_turret_panel_05_d0");
    } else if (self.vehicletype == "zombietron_veh_siegebot") {
        self asmsetanimationrate(1.429);
    }
    self function_5a6e3cac();
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
    self.var_375cf54a = 1;
    self.var_3a087745 = 1;
    self vehicle_ai::function_a767f9b4();
    self thread vehicle_ai::target_hijackers();
    if (!sessionmodeismultiplayergame()) {
        defaultrole();
    }
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0x1d50b3ce, Offset: 0x8f0
// Size: 0xa8
function function_f3e02741() {
    value = gameskill::function_1ef3d569();
    var_7b6ddca7 = mapfloat(0, 9, 0.8, 2, value);
    var_fc916d4 = mapfloat(0, 9, 1, 0.5, value);
    self.var_cf0b2b03 = var_7b6ddca7;
    self.var_e8674008 = var_fc916d4;
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0x77726ee1, Offset: 0x9a0
// Size: 0x2ac
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks("combat").exit_func = &state_combat_exit;
    self vehicle_ai::get_state_callbacks("driving").update_func = &function_dcb2cf5;
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    self vehicle_ai::get_state_callbacks("pain").update_func = &function_f71fc8b7;
    self vehicle_ai::get_state_callbacks("emped").enter_func = &function_881b0951;
    self vehicle_ai::get_state_callbacks("emped").update_func = &function_6b70970a;
    self vehicle_ai::get_state_callbacks("emped").exit_func = &function_4208588d;
    self vehicle_ai::get_state_callbacks("emped").reenter_func = &function_13a253c0;
    self vehicle_ai::add_state("jump", &function_bf7dfc58, &function_911f1aa5, &function_309fca92);
    vehicle_ai::add_utility_connection("combat", "jump", &function_ccaeca3);
    vehicle_ai::add_utility_connection("jump", "combat");
    self vehicle_ai::add_state("unaware", undefined, &state_unaware_update, undefined);
    vehicle_ai::startinitialstate("combat");
}

// Namespace siegebot
// Params 1, eflags: 0x1 linked
// Checksum 0x6a12456f, Offset: 0xc58
// Size: 0x2d4
function state_death_update(params) {
    self endon(#"death");
    self endon(#"nodeath_thread");
    streamermodelhint(self.deathmodel, 6);
    death_type = vehicle_ai::get_death_type(params);
    if (!isdefined(death_type)) {
        params.death_type = "gibbed";
        death_type = params.death_type;
    }
    self function_84e7c9e7();
    self setturretspinning(0);
    self function_144b90e8();
    self vehicle::set_damage_fx_level(0);
    self playsound("veh_quadtank_sparks");
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(1);
    }
    self.turretrotscale = 3;
    self function_d013f7fa((0, 0, 0), 0);
    self function_d013f7fa((0, 0, 0), 1);
    self function_d013f7fa((0, 0, 0), 2);
    self asmrequestsubstate("death@stationary");
    self waittill(#"model_swap");
    self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    self vehicle::do_death_dynents();
    self vehicle_death::death_radius_damage();
    self waittill(#"bodyfall large");
    self radiusdamage(self.origin + (0, 0, 10), self.radius * 0.8, -106, 60, self, "MOD_CRUSH");
    vehicle_ai::waittill_asm_complete("death@stationary", 3);
    self thread vehicle_death::cleanup();
    self vehicle_death::freewhensafe();
}

// Namespace siegebot
// Params 1, eflags: 0x1 linked
// Checksum 0x6ca3460, Offset: 0xf38
// Size: 0x84
function function_dcb2cf5(params) {
    self thread function_5beec115();
    self thread function_cc487332();
    self cleartargetentity();
    self cancelaimove();
    self clearvehgoalpos();
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0x5fcd1474, Offset: 0xfc8
// Size: 0x108
function function_cc487332() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    tilecount = 0;
    while (true) {
        var_6a22f6ec = anglestoup(self.angles);
        worldup = (0, 0, 1);
        if (vectordot(var_6a22f6ec, worldup) < 0.64) {
            tilecount += 1;
        } else {
            tilecount = 0;
        }
        if (tilecount > 20) {
            driver = self getseatoccupant(0);
            self kill(self.origin);
        }
        wait 0.05;
    }
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0x284d4062, Offset: 0x10d8
// Size: 0xe4
function function_5beec115() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    weapon = self seatgetweapon(2);
    firetime = weapon.firetime;
    driver = self getseatoccupant(0);
    self thread function_bd6a90ca();
    while (true) {
        if (driver attackbuttonpressed()) {
            self fireweapon(2);
            wait firetime;
            continue;
        }
        wait 0.05;
    }
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0x72912557, Offset: 0x11c8
// Size: 0x58
function function_bd6a90ca() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    while (true) {
        self function_6521eb5d(self function_d24a7ea9(0), 1);
        wait 0.05;
    }
}

// Namespace siegebot
// Params 1, eflags: 0x1 linked
// Checksum 0x2289f8fd, Offset: 0x1228
// Size: 0xac
function function_881b0951(params) {
    if (!isdefined(self.abnormal_status)) {
        self.abnormal_status = spawnstruct();
    }
    self.abnormal_status.emped = 1;
    self.abnormal_status.attacker = params.var_6e0794d4[1];
    self.abnormal_status.inflictor = params.var_6e0794d4[2];
    self vehicle::toggle_emp_fx(1);
}

// Namespace siegebot
// Params 1, eflags: 0x1 linked
// Checksum 0x9ca8b7ea, Offset: 0x12e0
// Size: 0xe4
function function_6b70970a(params) {
    self endon(#"death");
    self endon(#"change_state");
    self function_144b90e8();
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(1);
    }
    asmstate = "damage_2@pain";
    self asmrequestsubstate(asmstate);
    self vehicle_ai::waittill_asm_complete(asmstate, 3);
    self setbrake(0);
    self vehicle_ai::evaluate_connections();
}

// Namespace siegebot
// Params 1, eflags: 0x1 linked
// Checksum 0x5ef0a3ff, Offset: 0x13d0
// Size: 0xc
function function_4208588d(params) {
    
}

// Namespace siegebot
// Params 1, eflags: 0x1 linked
// Checksum 0xe3e19777, Offset: 0x13e8
// Size: 0xe
function function_13a253c0(params) {
    return false;
}

// Namespace siegebot
// Params 1, eflags: 0x1 linked
// Checksum 0xeab8827d, Offset: 0x1400
// Size: 0x18
function function_d56305c8(enabled) {
    self.var_72861401 = enabled;
}

// Namespace siegebot
// Params 1, eflags: 0x1 linked
// Checksum 0x2e78ed7e, Offset: 0x1420
// Size: 0x104
function function_f71fc8b7(params) {
    self endon(#"death");
    self endon(#"change_state");
    self function_144b90e8();
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(1);
    }
    if (self.newdamagelevel == 3) {
        asmstate = "damage_2@pain";
    } else {
        asmstate = "damage_1@pain";
    }
    self asmrequestsubstate(asmstate);
    self vehicle_ai::waittill_asm_complete(asmstate, 1.5);
    self setbrake(0);
    self vehicle_ai::evaluate_connections();
}

// Namespace siegebot
// Params 1, eflags: 0x1 linked
// Checksum 0x5093b5df, Offset: 0x1530
// Size: 0xae
function state_unaware_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    self function_d013f7fa((0, 90, 0), 1);
    self function_d013f7fa((0, 90, 0), 2);
    self thread function_ef0b7db5();
    while (true) {
        self vehicle_ai::evaluate_connections();
        wait 1;
    }
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0x67100bc3, Offset: 0x15e8
// Size: 0x12c
function function_ef0b7db5() {
    self endon(#"death");
    self endon(#"change_state");
    self notify(#"end_movement_thread");
    self endon(#"end_movement_thread");
    while (true) {
        self.current_pathto_pos = self function_d92aa446();
        foundpath = self setvehgoalpos(self.current_pathto_pos, 0, 1);
        if (foundpath) {
            function_59d0ca33();
            self thread path_update_interrupt();
            self vehicle_ai::waittill_pathing_done();
            self notify(#"near_goal");
            self cancelaimove();
            self clearvehgoalpos();
            scan();
        } else {
            wait 1;
        }
        wait 0.05;
    }
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0x58db2d59, Offset: 0x1720
// Size: 0x47e
function function_d92aa446() {
    if (self.goalforced) {
        return self.goalpos;
    }
    minsearchradius = 500;
    maxsearchradius = 1500;
    halfheight = 400;
    spacing = 80;
    queryresult = positionquery_source_navigation(self.origin, minsearchradius, maxsearchradius, halfheight, spacing, self, spacing);
    positionquery_filter_distancetogoal(queryresult, self);
    vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
    forward = anglestoforward(self.angles);
    foreach (point in queryresult.data) {
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x28>"] = randomfloatrange(0, 30);
        #/
        point.score += randomfloatrange(0, 30);
        pointdirection = vectornormalize(point.origin - self.origin);
        factor = vectordot(pointdirection, forward);
        if (factor > 0.7) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x2f>"] = 600;
            #/
            point.score += 600;
            continue;
        }
        if (factor > 0) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x2f>"] = 0;
            #/
            point.score += 0;
            continue;
        }
        if (factor > -0.5) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x2f>"] = -600;
            #/
            point.score += -600;
            continue;
        }
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x2f>"] = -1200;
        #/
        point.score += -1200;
    }
    vehicle_ai::positionquery_postprocess_sortscore(queryresult);
    self vehicle_ai::positionquery_debugscores(queryresult);
    if (queryresult.data.size == 0) {
        return self.origin;
    }
    return queryresult.data[0].origin;
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0x1868aeee, Offset: 0x1ba8
// Size: 0x44
function function_84e7c9e7() {
    if (isdefined(self.jump) && isdefined(self.jump.linkent)) {
        self.jump.linkent delete();
    }
}

// Namespace siegebot
// Params 1, eflags: 0x1 linked
// Checksum 0xa8be59e0, Offset: 0x1bf8
// Size: 0x3c
function function_e377aade(enttowatch) {
    self endon(#"death");
    enttowatch waittill(#"death");
    self delete();
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0x682d8d45, Offset: 0x1c40
// Size: 0x12c
function function_5a6e3cac() {
    if (isdefined(self.jump)) {
        self unlink();
        self.jump.linkent delete();
        self.jump delete();
    }
    self.jump = spawnstruct();
    self.jump.linkent = spawn("script_origin", self.origin);
    self.jump.linkent thread function_e377aade(self);
    self.jump.var_425f84b1 = 0;
    self.jump.var_6829bbf7 = struct::get_array("balcony_point");
    self.jump.groundpoints = struct::get_array("ground_point");
}

// Namespace siegebot
// Params 3, eflags: 0x1 linked
// Checksum 0xf5bc848e, Offset: 0x1d78
// Size: 0x48
function function_ccaeca3(from_state, to_state, connection) {
    if (isdefined(self.nojumping) && self.nojumping) {
        return false;
    }
    return self.vehicletype === "spawner_enemy_boss_siegebot_zombietron";
}

// Namespace siegebot
// Params 1, eflags: 0x1 linked
// Checksum 0xb1d23f0b, Offset: 0x1dc8
// Size: 0x1e4
function function_bf7dfc58(params) {
    goal = params.var_dbe18cc;
    trace = physicstrace(goal + (0, 0, 500), goal - (0, 0, 10000), (-10, -10, -10), (10, 10, 10), self, 2);
    if (false) {
        /#
            debugstar(goal, 60000, (0, 1, 0));
        #/
        /#
            debugstar(trace["<dev string:x3d>"], 60000, (0, 1, 0));
        #/
        /#
            line(goal, trace["<dev string:x3d>"], (0, 1, 0), 1, 0, 60000);
        #/
    }
    if (trace["fraction"] < 1) {
        goal = trace["position"];
    }
    self.jump.goal = goal;
    params.var_bc1a4954 = 40;
    params.var_a1e09ed6 = (0, 0, -6);
    params.var_3a388f84 = 50;
    params.var_fb532e19 = "land@jump";
    self function_d56305c8(0);
    self function_144b90e8();
}

// Namespace siegebot
// Params 1, eflags: 0x1 linked
// Checksum 0xacea8215, Offset: 0x1fb8
// Size: 0xbfc
function function_911f1aa5(params) {
    self endon(#"change_state");
    self endon(#"death");
    goal = self.jump.goal;
    self face_target(goal);
    self.jump.linkent.origin = self.origin;
    self.jump.linkent.angles = self.angles;
    wait 0.05;
    self linkto(self.jump.linkent);
    self.jump.var_425f84b1 = 1;
    if (false) {
        /#
            debugstar(goal, 60000, (0, 1, 0));
        #/
        /#
            debugstar(goal + (0, 0, 100), 60000, (0, 1, 0));
        #/
        /#
            line(goal, goal + (0, 0, 100), (0, 1, 0), 1, 0, 60000);
        #/
    }
    totaldistance = distance2d(goal, self.jump.linkent.origin);
    forward = (((goal - self.jump.linkent.origin) / totaldistance)[0], ((goal - self.jump.linkent.origin) / totaldistance)[1], 0);
    var_a2961d4 = mapfloat(500, 2000, 46, 52, totaldistance);
    var_920c55a7 = 0;
    var_f1e5d209 = (0, 0, 1) * (var_a2961d4 + params.var_3a388f84);
    var_e6651399 = forward * params.var_bc1a4954 * mapfloat(500, 2000, 0.8, 1, totaldistance);
    velocity = var_f1e5d209 + var_e6651399;
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(1);
    }
    self asmrequestsubstate("inair@jump");
    self waittill(#"hash_34a180dd");
    self vehicle::impact_fx(self.settings.var_2ba72ce7);
    self waittill(#"hash_f1a0ad10");
    self vehicle::impact_fx(self.settings.var_f209c6c6);
    while (true) {
        distancetogoal = distance2d(self.jump.linkent.origin, goal);
        var_570dcf42 = 1;
        var_7e526cf9 = 1;
        var_8ef0e611 = (0, 0, 0);
        if (false) {
            /#
                line(self.jump.linkent.origin, self.jump.linkent.origin + var_8ef0e611, (0, 1, 0), 1, 0, 60000);
            #/
        }
        var_8a7223d3 = mapfloat(self.radius * 1, self.radius * 4, 0.2, 1, distancetogoal);
        var_9fc4c6cf = var_e6651399 * var_8a7223d3;
        if (false) {
            /#
                line(self.jump.linkent.origin, self.jump.linkent.origin + var_9fc4c6cf, (0, 1, 0), 1, 0, 60000);
            #/
        }
        var_588fc985 = velocity[2];
        velocity = (0, 0, velocity[2]);
        velocity += var_9fc4c6cf + params.var_a1e09ed6 + var_8ef0e611;
        if (var_588fc985 > 0 && velocity[2] < 0) {
            self asmrequestsubstate("fall@jump");
        }
        if (velocity[2] < 0 && self.jump.linkent.origin[2] + velocity[2] < goal[2]) {
            break;
        }
        var_f44f4d9 = goal[2] + 110;
        var_55f62e61 = self.jump.linkent.origin[2];
        self.jump.linkent.origin += velocity;
        if (var_588fc985 > 0 && (var_55f62e61 > var_f44f4d9 || self.jump.linkent.origin[2] < var_f44f4d9 && velocity[2] < 0)) {
            self notify(#"hash_7c145c4b");
            self asmrequestsubstate(params.var_fb532e19);
        }
        if (false) {
            /#
                debugstar(self.jump.linkent.origin, 60000, (1, 0, 0));
            #/
        }
        wait 0.05;
    }
    self.jump.linkent.origin = (self.jump.linkent.origin[0], self.jump.linkent.origin[1], 0) + (0, 0, goal[2]);
    self notify(#"hash_12789372");
    foreach (player in level.players) {
        player.var_31d70948 = player.takedamage;
        player.takedamage = 0;
    }
    self radiusdamage(self.origin + (0, 0, 15), self.radiusdamageradius, self.radiusdamagemax, self.radiusdamagemin, self, "MOD_EXPLOSIVE");
    foreach (player in level.players) {
        player.takedamage = player.var_31d70948;
        player.var_31d70948 = undefined;
        if (distance2dsquared(self.origin, player.origin) < -56 * -56) {
            direction = ((player.origin - self.origin)[0], (player.origin - self.origin)[1], 0);
            if (abs(direction[0]) < 0.01 && abs(direction[1]) < 0.01) {
                direction = (randomfloatrange(1, 2), randomfloatrange(1, 2), 0);
            }
            direction = vectornormalize(direction);
            strength = 700;
            player setvelocity(player getvelocity() + direction * strength);
            if (player.health > 80) {
                player dodamage(player.health - 70, self.origin, self);
            }
        }
    }
    self vehicle::impact_fx(self.settings.var_9f4c9669);
    self function_144b90e8();
    wait 0.3;
    self unlink();
    wait 0.05;
    self.jump.var_425f84b1 = 0;
    self notify(#"hash_48269e0e");
    vehicle_ai::cooldown("jump", 7);
    self vehicle_ai::waittill_asm_complete(params.var_fb532e19, 3);
    self vehicle_ai::evaluate_connections();
}

// Namespace siegebot
// Params 1, eflags: 0x1 linked
// Checksum 0x8cf8834, Offset: 0x2bc0
// Size: 0xc
function function_309fca92(params) {
    
}

// Namespace siegebot
// Params 1, eflags: 0x1 linked
// Checksum 0xa13a50b5, Offset: 0x2bd8
// Size: 0x64
function state_combat_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    self thread movement_thread();
    self thread function_3a94fda4();
    self thread function_76333d5f();
}

// Namespace siegebot
// Params 1, eflags: 0x1 linked
// Checksum 0x203a2c7b, Offset: 0x2c48
// Size: 0x3c
function state_combat_exit(params) {
    self clearturrettarget();
    self setturretspinning(0);
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0xcb502c73, Offset: 0x2c90
// Size: 0x54
function function_59d0ca33() {
    if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
        self asmsetanimationrate(0.5);
    }
    self asmrequestsubstate("locomotion@movement");
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0xee2d92d1, Offset: 0x2cf0
// Size: 0x476
function getnextmoveposition_tactical() {
    if (self.goalforced) {
        return self.goalpos;
    }
    maxsearchradius = 800;
    halfheight = 400;
    innerspacing = 50;
    outerspacing = 60;
    queryresult = positionquery_source_navigation(self.origin, 0, maxsearchradius, halfheight, innerspacing, self, outerspacing);
    positionquery_filter_distancetogoal(queryresult, self);
    vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
    if (isdefined(self.enemy)) {
        positionquery_filter_sight(queryresult, self.enemy.origin, self geteye() - self.origin, self, 0, self.enemy);
        self vehicle_ai::positionquery_filter_engagementdist(queryresult, self.enemy, self.settings.engagementdistmin, self.settings.engagementdistmax);
    }
    foreach (point in queryresult.data) {
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x28>"] = randomfloatrange(0, 30);
        #/
        point.score += randomfloatrange(0, 30);
        if (point.disttoorigin2d < 120) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x46>"] = (120 - point.disttoorigin2d) * -1.5;
            #/
            point.score += (120 - point.disttoorigin2d) * -1.5;
        }
        if (isdefined(self.enemy)) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x55>"] = point.distawayfromengagementarea * -1;
            #/
            point.score += point.distawayfromengagementarea * -1;
            if (!point.visibility) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["<dev string:x64>"] = -600;
                #/
                point.score += -600;
            }
        }
    }
    vehicle_ai::positionquery_postprocess_sortscore(queryresult);
    self vehicle_ai::positionquery_debugscores(queryresult);
    if (queryresult.data.size == 0) {
        return self.origin;
    }
    return queryresult.data[0].origin;
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0xc9255d43, Offset: 0x3170
// Size: 0x484
function path_update_interrupt() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"near_goal");
    self endon(#"reached_end_node");
    var_9da987db = 0;
    old_enemy = self.enemy;
    startpath = gettime();
    old_origin = self.origin;
    var_755108a1 = 300;
    wait 1.5;
    while (true) {
        self setmaxspeedscale(1);
        self setmaxaccelerationscale(1);
        self setspeed(self.settings.defaultmovespeed);
        if (isdefined(self.enemy)) {
            selfdisttotarget = distance2d(self.origin, self.enemy.origin);
            var_5b28a10d = self.settings.engagementdistmax + -106;
            var_9f7fb26 = self.settings.engagementdistmin - -106;
            if (self function_4246bc05(self.enemy)) {
                self setlookatent(self.enemy);
                self setturrettargetent(self.enemy);
                if (selfdisttotarget < var_5b28a10d && selfdisttotarget > var_9f7fb26) {
                    var_9da987db++;
                    if (vehicle_ai::timesince(startpath) > 5 || var_9da987db > 3 && distance2dsquared(old_origin, self.origin) > var_755108a1 * var_755108a1) {
                        self notify(#"near_goal");
                    }
                } else {
                    self setmaxspeedscale(2.5);
                    self setmaxaccelerationscale(3);
                    self setspeed(self.settings.defaultmovespeed * 2);
                }
            } else if (!self function_6d424c6f(self.enemy, 1.5) && self function_6d424c6f(self.enemy, 15) || selfdisttotarget > var_5b28a10d) {
                self setmaxspeedscale(1.8);
                self setmaxaccelerationscale(2);
                self setspeed(self.settings.defaultmovespeed * 1.5);
            }
        } else {
            var_9da987db = 0;
        }
        if (isdefined(self.enemy)) {
            if (!isdefined(old_enemy)) {
                self notify(#"near_goal");
            } else if (self.enemy != old_enemy) {
                self notify(#"near_goal");
            }
            if (self function_4246bc05(self.enemy) && distance2dsquared(self.origin, self.enemy.origin) < -106 * -106 && distance2dsquared(old_origin, self.enemy.origin) > -105 * -105) {
                self notify(#"near_goal");
            }
        }
        wait 0.2;
    }
}

// Namespace siegebot
// Params 2, eflags: 0x1 linked
// Checksum 0xf578375e, Offset: 0x3600
// Size: 0x84
function function_92467705(isopen, waittime) {
    if (!isdefined(waittime)) {
        waittime = 0;
    }
    self endon(#"death");
    self notify(#"hash_92467705");
    self endon(#"hash_92467705");
    if (isdefined(waittime) && waittime > 0) {
        wait waittime;
    }
    self vehicle::toggle_ambient_anim_group(1, isopen);
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0x30d20917, Offset: 0x3690
// Size: 0x2d8
function movement_thread() {
    self endon(#"death");
    self endon(#"change_state");
    self notify(#"end_movement_thread");
    self endon(#"end_movement_thread");
    while (true) {
        self.current_pathto_pos = self getnextmoveposition_tactical();
        if (self.vehicletype === "spawner_enemy_boss_siegebot_zombietron") {
            if (vehicle_ai::iscooldownready("jump")) {
                params = spawnstruct();
                params.var_dbe18cc = self.current_pathto_pos;
                function_59d0ca33();
                wait 0.5;
                self vehicle_ai::evaluate_connections(undefined, params);
                wait 0.5;
            }
        }
        foundpath = self setvehgoalpos(self.current_pathto_pos, 0, 1);
        if (foundpath) {
            if (isdefined(self.enemy) && self function_6d424c6f(self.enemy, 1)) {
                self setlookatent(self.enemy);
                self setturrettargetent(self.enemy);
            }
            function_59d0ca33();
            self thread path_update_interrupt();
            self vehicle_ai::waittill_pathing_done();
            self notify(#"near_goal");
            self cancelaimove();
            self clearvehgoalpos();
            if (isdefined(self.enemy) && self function_6d424c6f(self.enemy, 2)) {
                self face_target(self.enemy.origin);
            }
        }
        wait 1;
        var_2d0a77d9 = gettime();
        while (isdefined(self.enemy) && self function_4246bc05(self.enemy) && vehicle_ai::timesince(var_2d0a77d9) < 1.5) {
            wait 0.4;
        }
    }
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0x44f81cac, Offset: 0x3970
// Size: 0x94
function function_144b90e8() {
    self notify(#"end_movement_thread");
    self notify(#"near_goal");
    self cancelaimove();
    self clearvehgoalpos();
    self clearturrettarget();
    self clearlookatent();
    self setbrake(1);
}

// Namespace siegebot
// Params 2, eflags: 0x1 linked
// Checksum 0x1ae049a9, Offset: 0x3a10
// Size: 0x20c
function face_target(position, var_cd8c9d1a) {
    if (!isdefined(var_cd8c9d1a)) {
        var_cd8c9d1a = 30;
    }
    v_to_enemy = ((position - self.origin)[0], (position - self.origin)[1], 0);
    v_to_enemy = vectornormalize(v_to_enemy);
    goalangles = vectortoangles(v_to_enemy);
    anglediff = absangleclamp180(self.angles[1] - goalangles[1]);
    if (anglediff <= var_cd8c9d1a) {
        return;
    }
    self function_b4518657(position);
    self setturrettargetvec(position);
    self function_59d0ca33();
    var_278525e3 = gettime();
    while (anglediff > var_cd8c9d1a && vehicle_ai::timesince(var_278525e3) < 4) {
        anglediff = absangleclamp180(self.angles[1] - goalangles[1]);
        wait 0.05;
    }
    self clearvehgoalpos();
    self clearlookatent();
    self clearturrettarget();
    self cancelaimove();
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0xe863cbd8, Offset: 0x3c28
// Size: 0x24c
function scan() {
    angles = self gettagangles("tag_barrel");
    angles = (0, angles[1], 0);
    rotate = 360;
    while (rotate > 0) {
        angles += (0, 30, 0);
        rotate -= 30;
        forward = anglestoforward(angles);
        aimpos = self.origin + forward * 1000;
        self setturrettargetvec(aimpos);
        msg = self util::waittill_any_timeout(0.5, "turret_on_target");
        wait 0.1;
        if (isdefined(self.enemy) && self function_4246bc05(self.enemy)) {
            self setturrettargetent(self.enemy);
            self setlookatent(self.enemy);
            self face_target(self.enemy);
            return;
        }
    }
    forward = anglestoforward(self.angles);
    aimpos = self.origin + forward * 1000;
    self setturrettargetvec(aimpos);
    msg = self util::waittill_any_timeout(3, "turret_on_target");
    self clearturrettarget();
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0xf813aa42, Offset: 0x3e80
// Size: 0x270
function function_3a94fda4() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    self notify(#"hash_eda479de");
    self endon(#"hash_eda479de");
    self.turretrotscale = 1 * self.var_cf0b2b03;
    spinning = 0;
    while (true) {
        if (isdefined(self.enemy) && self function_4246bc05(self.enemy)) {
            self setlookatent(self.enemy);
            self setturrettargetent(self.enemy);
            if (!spinning) {
                spinning = 1;
                self setturretspinning(1);
                wait 0.5;
                continue;
            }
            self function_9af49228(self.enemy, (0, 0, 0), 0);
            self function_9af49228(self.enemy, (0, 0, 0), 1);
            self vehicle_ai::fire_for_time(randomfloatrange(0.75, 1.5) * self.var_cf0b2b03, 1);
            if (isdefined(self.enemy) && isai(self.enemy)) {
                wait randomfloatrange(0.1, 0.2);
            } else {
                wait randomfloatrange(0.2, 0.3) * self.var_e8674008;
            }
            continue;
        }
        spinning = 0;
        self setturretspinning(0);
        self function_bb5f9faa(0);
        self function_bb5f9faa(1);
        wait 0.4;
    }
}

// Namespace siegebot
// Params 1, eflags: 0x1 linked
// Checksum 0x9ac79408, Offset: 0x40f8
// Size: 0xc4
function function_b04ee378(target) {
    if (isdefined(target)) {
        self setturrettargetent(target);
        self function_9af49228(target, (0, 0, -10), 2);
        msg = self util::waittill_any_timeout(1, "turret_on_target");
        self fireweapon(2, target, (0, 0, -10));
        self function_bb5f9faa(1);
    }
}

// Namespace siegebot
// Params 0, eflags: 0x1 linked
// Checksum 0xa6f411ce, Offset: 0x41c8
// Size: 0x230
function function_76333d5f() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    self notify(#"hash_77eb1a59");
    self endon(#"hash_77eb1a59");
    vehicle_ai::cooldown("rocket", 3);
    while (true) {
        if (isdefined(self.enemy) && self function_6d424c6f(self.enemy, 3) && vehicle_ai::iscooldownready("rocket", 1.5)) {
            self function_9af49228(self.enemy, (0, 0, 0), 0);
            self function_9af49228(self.enemy, (0, 0, -10), 2);
            self thread function_92467705(1);
            wait 1.5;
            if (isdefined(self.enemy) && self function_6d424c6f(self.enemy, 1)) {
                vehicle_ai::cooldown("rocket", 5);
                function_b04ee378(self.enemy);
                wait 1;
                if (isdefined(self.enemy)) {
                    function_b04ee378(self.enemy);
                }
                self thread function_92467705(0, 1);
            } else {
                self thread function_92467705(0);
            }
            continue;
        }
        self function_bb5f9faa(0);
        self function_bb5f9faa(1);
        wait 0.4;
    }
}

// Namespace siegebot
// Params 15, eflags: 0x1 linked
// Checksum 0x5f9f6681, Offset: 0x4400
// Size: 0x288
function function_3b05fc1b(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    num_players = getplayers().size;
    maxdamage = self.healthdefault * (0.4 - 0.02 * num_players);
    if (smeansofdeath !== "MOD_UNKNOWN" && idamage > maxdamage) {
        idamage = maxdamage;
    }
    if (vehicle_ai::should_emp(self, weapon, smeansofdeath, einflictor, eattacker)) {
        minempdowntime = 0.8 * self.settings.empdowntime;
        maxempdowntime = 1.2 * self.settings.empdowntime;
        self notify(#"emped", randomfloatrange(minempdowntime, maxempdowntime), eattacker, einflictor);
    }
    if (!isdefined(self.damagelevel)) {
        self.damagelevel = 0;
        self.newdamagelevel = self.damagelevel;
    }
    newdamagelevel = vehicle::should_update_damage_fx_level(self.health, idamage, self.healthdefault);
    if (newdamagelevel > self.damagelevel) {
        self.newdamagelevel = newdamagelevel;
    }
    if (self.newdamagelevel > self.damagelevel) {
        self.damagelevel = self.newdamagelevel;
        driver = self getseatoccupant(0);
        if (!isdefined(driver)) {
            self notify(#"pain");
        }
        vehicle::set_damage_fx_level(self.damagelevel);
    }
    return idamage;
}

