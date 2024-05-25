#using scripts/zm/zm_stalingrad_util;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_elemental_zombies;
#using scripts/zm/_zm_ai_raps;
#using scripts/zm/_util;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/vehicles/_siegebot;
#using scripts/shared/weapons/_spike_charge_siegebot;
#using scripts/shared/turret_shared;
#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/ai_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/util_shared;
#using scripts/shared/array_shared;
#using scripts/shared/system_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/math_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/aat_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace namespace_48757881;

// Namespace namespace_48757881
// Params 0, eflags: 0x2
// Checksum 0xfe793309, Offset: 0x9e8
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_siegebot_nikolai", &__init__, undefined, undefined);
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0x5659df15, Offset: 0xa28
// Size: 0x3ec
function __init__() {
    vehicle::add_main_callback("siegebot_nikolai", &function_fcf49d56);
    clientfield::register("vehicle", "nikolai_destroyed_r_arm", 12000, 1, "int");
    clientfield::register("vehicle", "nikolai_destroyed_l_arm", 12000, 1, "int");
    clientfield::register("vehicle", "nikolai_destroyed_r_chest", 12000, 1, "int");
    clientfield::register("vehicle", "nikolai_destroyed_l_chest", 12000, 1, "int");
    clientfield::register("vehicle", "nikolai_weakpoint_l_fx", 12000, 1, "int");
    clientfield::register("vehicle", "nikolai_weakpoint_r_fx", 12000, 1, "int");
    clientfield::register("vehicle", "nikolai_gatling_tell", 12000, 1, "int");
    clientfield::register("missile", "harpoon_impact", 12000, 1, "int");
    clientfield::register("vehicle", "play_raps_trail_fx", 12000, 1, "int");
    clientfield::register("vehicle", "raps_landing", 12000, 1, "int");
    level thread aat::register_immunity("zm_aat_blast_furnace", "siegebot", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_dead_wire", "siegebot", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_fire_works", "siegebot", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_thunder_wall", "siegebot", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_turned", "siegebot", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_blast_furnace", "raps", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_dead_wire", "raps", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_fire_works", "raps", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_thunder_wall", "raps", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_turned", "raps", 1, 1, 1);
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0xfc5fe919, Offset: 0xe20
// Size: 0x3f4
function function_fcf49d56() {
    self flag::init("halt_thread_gun");
    level.var_b15f9e1f = getentarray("zombie_raps_spawner", "targetname");
    self useanimtree(#generic);
    blackboard::createblackboardforentity(self);
    self blackboard::registervehicleblackboardattributes();
    self.health = self.healthdefault;
    self.var_65850094 = [];
    self.var_65850094[1] = 7500;
    self.var_65850094[2] = 7500;
    self.var_65850094[3] = 8000;
    self.var_65850094[4] = 8000;
    self.var_65850094[5] = 11000;
    foreach (player in level.activeplayers) {
        player.var_b3a9099 = 0;
    }
    self.b_override_explosive_damage_cap = 1;
    self.var_a0e2dfff = 1;
    self vehicle::friendly_fire_shield();
    self setneargoalnotifydist(self.radius * 1.2);
    target_set(self, (0, 0, 150));
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.maxsightdistsqrd = 10000 * 10000;
    assert(isdefined(self.scriptbundlesettings));
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self.goalradius = 9999999;
    self.goalheight = 5000;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self.overridevehicledamage = &function_b9b039e0;
    self function_d56305c8(1);
    self function_5a6e3cac();
    self function_6e075bdf(0, self.settings.gunner_turret_on_target_range);
    self function_59d0ca33();
    self.damagelevel = 0;
    self.newdamagelevel = self.damagelevel;
    if (!isdefined(self.height)) {
        self.height = self.radius;
    }
    self.var_a5db58c6 = 1;
    self.nocybercom = 1;
    self.var_375cf54a = 1;
    self.var_3a087745 = 1;
    self.ignoreme = 1;
    self vehicle_ai::function_a767f9b4();
    defaultrole();
}

// Namespace namespace_48757881
// Params 0, eflags: 0x0
// Checksum 0xf4bf2298, Offset: 0x1220
// Size: 0x7c
function init_clientfields() {
    self vehicle::lights_on();
    self vehicle::toggle_lights_group(1, 1);
    self vehicle::toggle_lights_group(2, 1);
    self vehicle::toggle_lights_group(3, 1);
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0x3ee2a51b, Offset: 0x12a8
// Size: 0x1dc
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role();
    self vehicle_ai::get_state_callbacks("combat").update_func = &function_c05314da;
    self vehicle_ai::get_state_callbacks("combat").exit_func = &function_3b3e7a3d;
    self vehicle_ai::get_state_callbacks("pain").enter_func = &function_5b4ac0fe;
    self vehicle_ai::get_state_callbacks("pain").update_func = &function_f71fc8b7;
    self vehicle_ai::get_state_callbacks("pain").exit_func = &function_a3bf4514;
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    self vehicle_ai::add_state("special_attack", undefined, undefined, undefined);
    self vehicle_ai::add_state("jump", &function_bf7dfc58, &function_911f1aa5, &function_309fca92);
    vehicle_ai::add_utility_connection("jump", "combat");
    vehicle_ai::startinitialstate("combat");
}

// Namespace namespace_48757881
// Params 1, eflags: 0x1 linked
// Checksum 0x92195d1c, Offset: 0x1490
// Size: 0x132
function function_f7035c2f(var_b58fd987) {
    self endon(#"death");
    var_b58fd987 endon(#"death");
    self.var_b58fd987 = var_b58fd987;
    self enablelinkto();
    var_b58fd987.origin = self gettagorigin("tag_driver");
    var_b58fd987.angles = self gettagangles("tag_driver");
    var_b58fd987.targetname = "nikolai_driver";
    var_b58fd987 linkto(self, "tag_driver");
    while (true) {
        var_b58fd987 scene::play("cin_zm_stalingrad_nikolai_cockpit_drink");
        var_b58fd987 thread scene::play("cin_zm_stalingrad_nikolai_cockpit_idle");
        wait(10 + randomfloat(10));
    }
}

// Namespace namespace_48757881
// Params 1, eflags: 0x1 linked
// Checksum 0x118b434d, Offset: 0x15d0
// Size: 0x1e4
function state_death_update(params) {
    self endon(#"death");
    self endon(#"nodeath_thread");
    streamermodelhint(self.deathmodel, 6);
    self setturretspinning(0);
    self function_84e7c9e7();
    self function_144b90e8();
    self vehicle::set_damage_fx_level(0);
    self.turretrotscale = 3;
    self function_d013f7fa((0, 0, 0), 0);
    self function_d013f7fa((0, 0, 0), 1);
    self function_d013f7fa((0, 0, 0), 2);
    level flag::set("nikolai_complete");
    self asmrequestsubstate("death@stationary");
    self.var_b58fd987 thread scene::play("cin_zm_stalingrad_nikolai_cockpit_death");
    self waittill(#"model_swap");
    self vehicle_death::death_fx();
    wait(10);
    self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    self playsound("veh_quadtank_sparks");
    self vehicle_death::freewhensafe(-106);
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0x8dc6c62f, Offset: 0x17c0
// Size: 0x34
function function_84e7c9e7() {
    if (isdefined(self.jump)) {
        self.jump.linkent delete();
    }
}

// Namespace namespace_48757881
// Params 1, eflags: 0x1 linked
// Checksum 0xbf97604d, Offset: 0x1800
// Size: 0x18
function function_d56305c8(enabled) {
    self.var_72861401 = enabled;
}

// Namespace namespace_48757881
// Params 0, eflags: 0x0
// Checksum 0x28255848, Offset: 0x1820
// Size: 0x42
function function_c423e168() {
    state = vehicle_ai::get_current_state();
    return isdefined(state) && state != "pain" && self.var_72861401;
}

// Namespace namespace_48757881
// Params 1, eflags: 0x1 linked
// Checksum 0xc8255081, Offset: 0x1870
// Size: 0x24
function function_5b4ac0fe(params) {
    self function_144b90e8();
}

// Namespace namespace_48757881
// Params 1, eflags: 0x1 linked
// Checksum 0x91cbf7df, Offset: 0x18a0
// Size: 0x24
function function_a3bf4514(params) {
    self setbrake(0);
}

// Namespace namespace_48757881
// Params 1, eflags: 0x1 linked
// Checksum 0x92ad65fc, Offset: 0x18d0
// Size: 0xfc
function function_f71fc8b7(params) {
    self endon(#"death");
    if (1 <= self.damagelevel && self.damagelevel <= 4) {
        asmstate = "damage_" + self.damagelevel + "@pain";
    } else {
        asmstate = "normal@pain";
    }
    self asmrequestsubstate(asmstate);
    self vehicle_ai::waittill_asm_complete(asmstate, 5);
    previous_state = vehicle_ai::get_previous_state();
    self vehicle_ai::set_state(previous_state);
    self vehicle_ai::evaluate_connections();
}

// Namespace namespace_48757881
// Params 1, eflags: 0x1 linked
// Checksum 0x5512e890, Offset: 0x19d8
// Size: 0x174
function jump_to(target) {
    if (self vehicle_ai::get_current_state() === "jump") {
        return false;
    }
    if (!vehicle_ai::iscooldownready("jump_cooldown")) {
        return false;
    }
    if (isvec(target)) {
        self.jump.var_e8ce546f = target;
    } else if (isdefined(target.origin) && isvec(target.origin)) {
        self.jump.var_e8ce546f = target.origin;
    }
    distsqr = distance2dsquared(self.origin, self.jump.var_e8ce546f);
    if (isdefined(self.jump.var_e8ce546f) && 600 * 600 < distsqr && distsqr < 1800 * 1800) {
        self vehicle_ai::set_state("jump");
        return true;
    }
    return false;
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0xfbb79d4a, Offset: 0x1b58
// Size: 0x104
function function_5a6e3cac() {
    if (isdefined(self.jump)) {
        self unlink();
        self.jump.linkent delete();
        self.jump delete();
    }
    self.jump = spawnstruct();
    self.jump.linkent = spawn("script_origin", self.origin);
    self.jump.var_425f84b1 = 0;
    self.var_c8241452 = struct::get("boss_arena_center").origin;
    assert(isdefined(self.var_c8241452));
}

// Namespace namespace_48757881
// Params 1, eflags: 0x1 linked
// Checksum 0xe62cd6b0, Offset: 0x1c68
// Size: 0x14c
function function_bf7dfc58(params) {
    goal = self.jump.var_e8ce546f;
    trace = physicstrace(goal + (0, 0, 500), goal - (0, 0, 10000), (-10, -10, -10), (10, 10, 10), self, 2);
    if (trace["fraction"] < 1) {
        goal = trace["position"];
    }
    self.jump.var_44d87db5 = goal;
    self.jump.goal = goal;
    params.var_bc1a4954 = 70;
    params.var_a1e09ed6 = (0, 0, -5);
    params.var_3a388f84 = -5;
    self function_d56305c8(0);
    self function_144b90e8();
}

// Namespace namespace_48757881
// Params 1, eflags: 0x1 linked
// Checksum 0xd560c746, Offset: 0x1dc0
// Size: 0x24
function function_309fca92(params) {
    self function_d56305c8(1);
}

// Namespace namespace_48757881
// Params 1, eflags: 0x1 linked
// Checksum 0x890a2369, Offset: 0x1df0
// Size: 0xb5c
function function_911f1aa5(params) {
    self endon(#"change_state");
    self endon(#"death");
    goal = self.jump.goal;
    self face_target(goal);
    self.jump.linkent.origin = self.origin;
    self.jump.linkent.angles = self.angles;
    wait(0.05);
    self linkto(self.jump.linkent);
    self.jump.var_425f84b1 = 1;
    totaldistance = distance2d(goal, self.jump.linkent.origin);
    forward = (((goal - self.jump.linkent.origin) / totaldistance)[0], ((goal - self.jump.linkent.origin) / totaldistance)[1], 0);
    var_a2961d4 = mapfloat(500, 2000, 46, 52, totaldistance);
    var_920c55a7 = mapfloat(500, 2000, 0, 0.5, totaldistance);
    var_f1e5d209 = (0, 0, 1) * (var_a2961d4 + params.var_3a388f84);
    var_e6651399 = forward * params.var_bc1a4954 * mapfloat(500, 2000, 0.8, 1, totaldistance);
    velocity = var_f1e5d209 + var_e6651399;
    self asmrequestsubstate("inair@jump");
    self.jump.debug_state = "engine_startup";
    self util::waittill_notify_or_timeout("start_engine", 0.5);
    self vehicle::impact_fx(self.settings.var_2ba72ce7);
    self.jump.debug_state = "leave_ground";
    self util::waittill_notify_or_timeout("start_engine", 1);
    self vehicle::impact_fx(self.settings.var_f209c6c6);
    params.var_fb532e19 = "land@jump";
    var_d3ef7ffb = gettime();
    while (true) {
        distancetogoal = distance2d(self.jump.linkent.origin, goal);
        var_570dcf42 = mapfloat(0, 0.5, 0.6, 0, abs(0.5 - distancetogoal / totaldistance));
        var_7e526cf9 = mapfloat(self.radius * 1, self.radius * 3, 0, 1, distancetogoal);
        var_8ef0e611 = var_7e526cf9 * var_570dcf42 * params.var_a1e09ed6 * -1 + (0, 0, var_920c55a7);
        var_8a7223d3 = mapfloat(self.radius * 1, self.radius * 4, 0.2, 1, distancetogoal);
        var_9fc4c6cf = var_e6651399 * var_8a7223d3;
        var_588fc985 = velocity[2];
        velocity = (0, 0, velocity[2]);
        velocity += var_9fc4c6cf + params.var_a1e09ed6 + var_8ef0e611;
        if (var_588fc985 > 0 && velocity[2] <= 0) {
            self asmrequestsubstate("fall@jump");
        }
        if (velocity[2] <= 0 && self.jump.linkent.origin[2] + velocity[2] <= goal[2] || vehicle_ai::timesince(var_d3ef7ffb) > 10) {
            break;
        }
        var_f44f4d9 = goal[2] + 110;
        var_55f62e61 = self.jump.linkent.origin[2];
        self.jump.linkent.origin += velocity;
        if (var_588fc985 > 0 && (var_55f62e61 > var_f44f4d9 || self.jump.linkent.origin[2] < var_f44f4d9 && velocity[2] < 0)) {
            self notify(#"hash_7c145c4b");
            if (isdefined(self.enemy)) {
                forward = anglestoforward(self.angles);
                dir = vectornormalize(self.enemy.origin - self.origin);
                dot = vectordot(dir, forward);
                if (dot < -0.7) {
                    params.var_fb532e19 = "land_turn@jump";
                }
            }
            self asmrequestsubstate(params.var_fb532e19);
        }
        wait(0.05);
    }
    self.jump.linkent.origin = (self.jump.linkent.origin[0], self.jump.linkent.origin[1], 0) + (0, 0, goal[2]);
    self notify(#"hash_12789372");
    foreach (player in level.players) {
        if (distance2dsquared(self.origin, player.origin) < -56 * -56) {
            direction = ((player.origin - self.origin)[0], (player.origin - self.origin)[1], 0);
            if (abs(direction[0]) < 0.01 && abs(direction[1]) < 0.01) {
                direction = (randomfloatrange(1, 2), randomfloatrange(1, 2), 0);
            }
            direction = vectornormalize(direction);
            strength = 700;
            player setvelocity(player getvelocity() + direction * strength);
            player dodamage(50, self.origin, self);
        }
    }
    self vehicle::impact_fx(self.settings.var_9f4c9669);
    self function_144b90e8();
    playrumbleonposition("nikolai_siegebot_land", self.origin);
    wait(0.3);
    self unlink();
    wait(0.05);
    self.jump.var_425f84b1 = 0;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self vehicle_ai::waittill_asm_complete(params.var_fb532e19, 3);
    self vehicle_ai::cooldown("jump_cooldown", 3);
    self notify(#"hash_48269e0e");
    self function_59d0ca33();
    self vehicle_ai::evaluate_connections();
}

// Namespace namespace_48757881
// Params 0, eflags: 0x0
// Checksum 0xf64c9088, Offset: 0x2958
// Size: 0xb4
function function_f9508f9e() {
    self vehicle_ai::clearalllookingandtargeting();
    self function_d013f7fa((0, 0, 0), 0);
    self function_d013f7fa((0, 0, 0), 1);
    self function_d013f7fa((0, 0, 0), 2);
    self function_d013f7fa((0, 0, 0), 3);
    self function_d013f7fa((0, 0, 0), 4);
}

// Namespace namespace_48757881
// Params 0, eflags: 0x0
// Checksum 0x9400d642, Offset: 0x2a18
// Size: 0x274
function function_e5af3b61() {
    step_size = -76;
    var_e2d09319 = anglestoright(self.angles);
    start = self.origin + (0, 0, 10);
    tracedir = var_e2d09319;
    var_11b475f9 = "juke_r@movement";
    var_b274fc28 = "juke_l@movement";
    if (math::cointoss()) {
        tracedir *= -1;
        var_11b475f9 = "juke_l@movement";
        var_b274fc28 = "juke_r@movement";
    }
    trace = physicstrace(start, start + tracedir * step_size, 0.8 * (self.radius * -1, self.radius * -1, 0), 0.8 * (self.radius, self.radius, self.height), self, 2);
    if (trace["fraction"] < 1) {
        tracedir *= -1;
        trace = physicstrace(start, start + tracedir * step_size, 0.8 * (self.radius * -1, self.radius * -1, 0), 0.8 * (self.radius, self.radius, self.height), self, 2);
        var_11b475f9 = var_b274fc28;
    }
    if (trace["fraction"] >= 1) {
        self asmrequestsubstate(var_11b475f9);
        self vehicle_ai::waittill_asm_complete(var_11b475f9, 3);
        self function_59d0ca33();
        return true;
    }
    return false;
}

// Namespace namespace_48757881
// Params 1, eflags: 0x1 linked
// Checksum 0x96a3fa7c, Offset: 0x2c98
// Size: 0xa6
function function_c05314da(params) {
    self endon(#"death");
    self endon(#"change_state");
    self thread function_57c5370f();
    self thread movement_thread();
    self thread function_6f90eaa6();
    self thread function_7080094f();
    while (true) {
        self vehicle_ai::evaluate_connections();
        wait(1);
    }
}

// Namespace namespace_48757881
// Params 1, eflags: 0x1 linked
// Checksum 0x57a3f432, Offset: 0x2d48
// Size: 0x4c
function function_a812ea81(tag_name) {
    origin = self gettagorigin(tag_name);
    self function_75775e52(origin, 80);
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0xf85f7f4e, Offset: 0x2da0
// Size: 0x68
function function_6f90eaa6() {
    self endon(#"death");
    self endon(#"change_state");
    self notify(#"hash_9a439848");
    self endon(#"hash_9a439848");
    while (true) {
        self waittill(#"footstep_left_large_theia");
        function_a812ea81("tag_leg_left_foot_animate");
    }
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0x8d74778b, Offset: 0x2e10
// Size: 0x68
function function_7080094f() {
    self endon(#"death");
    self endon(#"change_state");
    self notify(#"hash_ca245721");
    self endon(#"hash_ca245721");
    while (true) {
        self waittill(#"footstep_right_large_theia");
        function_a812ea81("tag_leg_right_foot_animate");
    }
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0x6fb04aac, Offset: 0x2e80
// Size: 0x1f0
function movement_thread() {
    self endon(#"death");
    self endon(#"change_state");
    self notify(#"end_movement_thread");
    self endon(#"end_movement_thread");
    self.current_pathto_pos = self.origin;
    while (true) {
        self setspeed(self.settings.defaultmovespeed);
        e_enemy = self.enemy;
        if (isdefined(self.goalpos) && distancesquared(self.current_pathto_pos, self.goalpos) > self.radius * 0.8 * self.radius * 0.8) {
            self.current_pathto_pos = self.goalpos;
            self setvehgoalpos(self.current_pathto_pos, 0, 1);
            foundpath = self vehicle_ai::waittill_pathresult();
            if (foundpath) {
                if (isdefined(e_enemy)) {
                    self setlookatent(e_enemy);
                }
                self setbrake(0);
                function_59d0ca33();
                self vehicle_ai::waittill_pathing_done();
                self cancelaimove();
                self clearvehgoalpos();
                self setbrake(1);
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_48757881
// Params 1, eflags: 0x1 linked
// Checksum 0x2dfe1b7c, Offset: 0x3078
// Size: 0x3c
function function_3b3e7a3d(params) {
    self notify(#"end_attack_thread");
    self notify(#"end_movement_thread");
    self clearturrettarget();
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0x56a75ab2, Offset: 0x30c0
// Size: 0x260
function function_57c5370f() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    self notify(#"hash_1f81be6d");
    self endon(#"hash_1f81be6d");
    while (true) {
        e_enemy = self.enemy;
        if (!isdefined(e_enemy) || self.var_a7cd606 === 1) {
            self function_d013f7fa((0, 0, 0));
            wait(0.4);
            continue;
        }
        self vehicle_ai::setturrettarget(e_enemy, 0);
        self vehicle_ai::setturrettarget(e_enemy, 1);
        var_eb3cc6f2 = gettime();
        while (isdefined(e_enemy) && !self.gunner1ontarget && vehicle_ai::timesince(var_eb3cc6f2) < 2) {
            wait(0.4);
        }
        if (!isdefined(e_enemy)) {
            continue;
        }
        var_9e93cc65 = gettime();
        while (isdefined(e_enemy) && e_enemy === self.enemy && self function_6d424c6f(e_enemy, 1) && vehicle_ai::timesince(var_9e93cc65) < 5) {
            if (self flag::get("halt_thread_gun")) {
                break;
            }
            self vehicle_ai::fire_for_time(1 + randomfloat(0.4), 1);
            if (isdefined(e_enemy) && isplayer(e_enemy)) {
                wait(0.6 + randomfloat(0.2));
            }
            wait(0.1);
        }
        wait(0.1);
    }
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0x252a44af, Offset: 0x3328
// Size: 0x34
function function_59d0ca33() {
    locomotion = "locomotion@movement";
    self asmrequestsubstate(locomotion);
}

// Namespace namespace_48757881
// Params 0, eflags: 0x0
// Checksum 0xd853847d, Offset: 0x3368
// Size: 0x12
function function_7fcc2a80() {
    self notify(#"near_goal");
}

// Namespace namespace_48757881
// Params 3, eflags: 0x0
// Checksum 0x26ffb85a, Offset: 0x3388
// Size: 0x82
function function_9dfac374(left, right, point) {
    var_c8c31226 = distance2dsquared(left.origin, point);
    var_d69cdbbd = distance2dsquared(right.origin, point);
    return var_c8c31226 > var_d69cdbbd;
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0xb91ca6e3, Offset: 0x3418
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

// Namespace namespace_48757881
// Params 3, eflags: 0x1 linked
// Checksum 0x1f13fb41, Offset: 0x34b8
// Size: 0x23c
function face_target(position, var_cd8c9d1a, var_a39fa3d8) {
    if (!isdefined(var_a39fa3d8)) {
        var_a39fa3d8 = 1;
    }
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
    if (var_a39fa3d8) {
        self setturrettargetvec(position);
    }
    self function_59d0ca33();
    var_278525e3 = gettime();
    while (anglediff > var_cd8c9d1a && vehicle_ai::timesince(var_278525e3) < 4) {
        anglediff = absangleclamp180(self.angles[1] - goalangles[1]);
        wait(0.05);
    }
    self clearvehgoalpos();
    self clearlookatent();
    if (var_a39fa3d8) {
        self clearturrettarget();
    }
    self cancelaimove();
}

// Namespace namespace_48757881
// Params 2, eflags: 0x1 linked
// Checksum 0x4b48cb19, Offset: 0x3700
// Size: 0x16a
function function_75775e52(point, range) {
    a_zombies = getaiarchetypearray("zombie");
    foreach (zombie in a_zombies) {
        if (isalive(zombie) && zombie.knockdown !== 1 && distance2dsquared(point, zombie.origin) < range * range && (point[2] - zombie.origin[2]) * (point[2] - zombie.origin[2]) < 100 * 100) {
            zombie zombie_utility::setup_zombie_knockdown(self);
        }
    }
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0x7eb1b075, Offset: 0x3878
// Size: 0x5c
function function_86cc3c11() {
    count = 0;
    for (i = 1; i < 5; i++) {
        if (self.var_65850094[i] <= 0) {
            count++;
        }
    }
    return count;
}

// Namespace namespace_48757881
// Params 15, eflags: 0x1 linked
// Checksum 0xd8764e20, Offset: 0x38e0
// Size: 0x584
function function_b9b039e0(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (!isplayer(eattacker)) {
        return false;
    }
    if (level flag::get("world_is_paused")) {
        return false;
    }
    if (smeansofdeath === "MOD_MELEE") {
        return false;
    }
    if (isdefined(weapon)) {
        var_cf9744cb = strtok(weapon.name, "_");
        if (var_cf9744cb[0] === "shotgun") {
            idamage = int(float(idamage) / float(weapon.shotcount));
        }
    }
    idamage = int(float(idamage) / float(level.players.size));
    if (idamage < 1) {
        idamage = 1;
    }
    var_7e43f478 = strtok(partname, "_");
    if (var_7e43f478[1] == "heat" && var_7e43f478[2] == "vent") {
        n_index = int(var_7e43f478[3]);
        if (self.var_65850094[n_index] <= 0) {
            return false;
        }
    } else {
        return false;
    }
    var_2be8aff = partname;
    switch (n_index) {
    case 1:
        var_2be8aff = "tag_heat_vent_01_d0";
        break;
    case 2:
        var_2be8aff = "tag_heat_vent_02_d0";
        break;
    case 4:
        break;
    case 3:
        break;
    case 5:
        var_2be8aff = "tag_heat_vent_05_d1";
        break;
    default:
        return false;
    }
    if (n_index == 5 && function_86cc3c11() < 4) {
        return false;
    }
    var_cf402baf = self.var_65850094[n_index] > 0 && self.var_65850094[n_index] - idamage <= 0;
    self.var_65850094[n_index] = self.var_65850094[n_index] - idamage;
    eattacker.var_b3a9099 += idamage;
    eattacker show_hit_marker();
    if (var_cf402baf) {
        self notify(#"hash_d4ba4cd");
        if (n_index == 1) {
            self hidepart("tag_heat_vent_01_d0_col");
            self notify(#"hash_5eb926b6");
        } else if (n_index == 2) {
            self hidepart("tag_heat_vent_02_d0_col");
            self notify(#"hash_ae5c218");
        }
        mod = "MOD_MELEE";
        if (n_index == 5) {
            self.allowdeath = 1;
            mod = "MOD_IMPACT";
        }
        self finishvehicledamage(einflictor, eattacker, 10000 * 10000, idflags, mod, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, var_2be8aff, 1);
        if (n_index != 5) {
            self function_37a64cff(n_index);
        }
        if (function_86cc3c11() >= 4) {
            self finishvehicledamage(einflictor, eattacker, 4000, idflags, "MOD_IMPACT", weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, "tag_heat_vent_05_d0", 1);
            level notify(#"hash_f6982dc3");
        }
    }
    return false;
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0x9f774e71, Offset: 0x3e70
// Size: 0x88
function show_hit_marker() {
    if (isdefined(self) && isdefined(self.hud_damagefeedback)) {
        self.hud_damagefeedback setshader("damage_feedback", 24, 48);
        self.hud_damagefeedback.alpha = 1;
        self.hud_damagefeedback fadeovertime(1);
        self.hud_damagefeedback.alpha = 0;
    }
}

// Namespace namespace_48757881
// Params 2, eflags: 0x1 linked
// Checksum 0x968fa3b8, Offset: 0x3f00
// Size: 0x194
function function_efdfbbf7(var_9d838914, var_e7f2a029) {
    if (var_e7f2a029 == 2) {
        var_e6a3fdd7 = "tag_heat_vent_02_d0_col";
        var_2be8aff = "ai_zm_dlc3_russian_mech_heat_vent_l";
        var_7ae256a = 1;
        str_clientfield = "nikolai_weakpoint_l_fx";
    } else {
        var_e6a3fdd7 = "tag_heat_vent_01_d0_col";
        var_2be8aff = "ai_zm_dlc3_russian_mech_heat_vent_r";
        var_7ae256a = 2;
        str_clientfield = "nikolai_weakpoint_r_fx";
    }
    if (var_9d838914) {
        self showpart(var_e6a3fdd7);
        self setanim(var_2be8aff);
        self vehicle::toggle_ambient_anim_group(var_7ae256a, 1);
        self clientfield::set(str_clientfield, 1);
        return;
    }
    self hidepart(var_e6a3fdd7);
    self clearanim(var_2be8aff, 0.1);
    self vehicle::toggle_ambient_anim_group(var_7ae256a, 0);
    self clientfield::set(str_clientfield, 0);
}

// Namespace namespace_48757881
// Params 1, eflags: 0x1 linked
// Checksum 0x8899a5a5, Offset: 0x40a0
// Size: 0xa4
function function_37a64cff(var_ce1b5a05) {
    switch (var_ce1b5a05) {
    case 1:
        str_clientfield = "nikolai_destroyed_r_arm";
        break;
    case 2:
        str_clientfield = "nikolai_destroyed_l_arm";
        break;
    case 3:
        str_clientfield = "nikolai_destroyed_r_chest";
        break;
    case 4:
        str_clientfield = "nikolai_destroyed_l_chest";
        break;
    }
    self clientfield::set(str_clientfield, 1);
}

// Namespace namespace_48757881
// Params 1, eflags: 0x1 linked
// Checksum 0x7a8a2e53, Offset: 0x4150
// Size: 0x3fc
function function_a3258c2a(var_f8b7c9a1) {
    if (!isalive(self)) {
        return 0;
    }
    self endon(#"death");
    self vehicle_ai::set_state("special_attack");
    self endon(#"change_state");
    foreach (player in level.activeplayers) {
        self getperfectinfo(player, 0);
    }
    self function_59d0ca33();
    self clientfield::set("nikolai_gatling_tell", 1);
    if (isdefined(self.enemy)) {
        self vehicle_ai::setturrettarget(self.enemy, 0);
        self vehicle_ai::setturrettarget(self.enemy, 1);
    }
    if (self.var_65850094[2] > 0) {
        self function_efdfbbf7(1, 2);
    }
    var_a3f49a09 = 137.5;
    weapon = self seatgetweapon(1);
    fireinterval = weapon.firetime * 0.5;
    var_9e93cc65 = gettime();
    while (isdefined(self.enemy) && vehicle_ai::timesince(var_9e93cc65) < var_f8b7c9a1) {
        self setlookatent(self.enemy);
        self vehicle_ai::setturrettarget(self.enemy, 0);
        angleoffset = anglestoforward((0, randomint(100) * var_a3f49a09, 0)) * 100;
        velocityoffset = self.enemy getvelocity() * -0.3;
        targetposition = self.enemy.origin + angleoffset + velocityoffset;
        self vehicle_ai::setturrettarget(targetposition, 1);
        wait(fireinterval);
        self fireweapon(1, undefined, angleoffset + velocityoffset, self);
    }
    self notify(#"fire_stop");
    self clientfield::set("nikolai_gatling_tell", 0);
    if (self.var_65850094[2] > 0) {
        self function_efdfbbf7(0, 2);
    } else {
        self clientfield::set("nikolai_weakpoint_l_fx", 0);
    }
    self vehicle_ai::set_state("combat");
}

// Namespace namespace_48757881
// Params 1, eflags: 0x1 linked
// Checksum 0x7e69090d, Offset: 0x4558
// Size: 0x5ec
function function_59fe8c9c(targetposition) {
    if (!isalive(self)) {
        return 0;
    }
    self endon(#"death");
    self vehicle_ai::set_state("special_attack");
    self endon(#"change_state");
    self function_d013f7fa((0, 0, 0), 0);
    self function_d013f7fa((0, 0, 0), 1);
    self function_d013f7fa((0, 0, 0), 2);
    self face_target(targetposition, 30);
    self notify(#"hash_c72aec1e");
    if (self.var_65850094[1] > 0) {
        self function_efdfbbf7(1, 1);
    }
    if (self.var_65850094[2] > 0) {
        self function_efdfbbf7(1, 2);
    }
    self asmrequestsubstate("javelin@stationary");
    var_a3f49a09 = 137.5;
    for (i = 0; i < 6; i++) {
        if (i % 2 == 0) {
            self util::waittill_notify_or_timeout("fire_raps", 0.5);
        }
        var_3e32f05a = undefined;
        while (!isdefined(var_3e32f05a)) {
            if (level flag::get("world_is_paused")) {
                level flag::wait_till_clear("world_is_paused");
            }
            spawntag = self gettagorigin("tag_flash");
            tagangles = self gettagangles("tag_flash");
            var_5d7a8c53 = anglestoup(tagangles);
            var_3e32f05a = spawnvehicle("spawner_zm_dlc3_vehicle_raps_nikolai", spawntag, self.angles);
            if (!isdefined(var_3e32f05a)) {
                wait(0.1);
            }
        }
        var_3e32f05a.exclude_cleanup_adding_to_total = 1;
        var_3e32f05a.b_ignore_cleanup = 1;
        var_3e32f05a.no_eye_glow = 1;
        playfxontag("dlc3/stalingrad/fx_mech_wpn_raps_launcher_muz", self, "tag_flash");
        var_3e32f05a hide();
        var_3e32f05a.takedamage = 0;
        wait(0.05);
        var_3e32f05a.origin = spawntag + var_5d7a8c53 * 40;
        wait(0.05);
        var_3e32f05a show();
        wait(0.05);
        if (!isdefined(level.var_c3c3ffc5)) {
            level.var_c3c3ffc5 = [];
        } else if (!isarray(level.var_c3c3ffc5)) {
            level.var_c3c3ffc5 = array(level.var_c3c3ffc5);
        }
        level.var_c3c3ffc5[level.var_c3c3ffc5.size] = var_3e32f05a;
        level.var_6d27427c++;
        var_3e32f05a namespace_48c05c81::function_d48ad6b4();
        var_3e32f05a thread function_6deb3e8d();
        var_3e32f05a.takedamage = 1;
        var_3e32f05a thread function_3b145bbb();
        offset = anglestoforward((0, i * var_a3f49a09, 0));
        launchforce = var_5d7a8c53 * 300 + offset * 40;
        var_3e32f05a thread function_853d3b2b(targetposition + offset * 60, launchforce);
        wait(0.1);
    }
    if (self.var_65850094[1] > 0) {
        self function_efdfbbf7(0, 1);
    } else {
        self clientfield::set("nikolai_weakpoint_r_fx", 0);
    }
    if (self.var_65850094[2] > 0) {
        self function_efdfbbf7(0, 2);
    } else {
        self clientfield::set("nikolai_weakpoint_l_fx", 0);
    }
    self vehicle_ai::waittill_asm_complete("javelin@stationary", 4);
    self vehicle_ai::set_state("combat");
}

// Namespace namespace_48757881
// Params 2, eflags: 0x1 linked
// Checksum 0xbf633414, Offset: 0x4b50
// Size: 0x1dc
function function_853d3b2b(var_ff72f147, launchforce) {
    self endon(#"death");
    self clientfield::set("play_raps_trail_fx", 1);
    self vehicle_ai::set_state("scripted");
    self vehicle::toggle_sounds(0);
    launchstart = gettime();
    self launchvehicle(launchforce);
    wait(0.5);
    self applyballistictarget(var_ff72f147);
    self show();
    while (!isdefined(getclosestpointonnavmesh(self.origin, -56)) && vehicle_ai::timesince(launchstart) < 4) {
        wait(0.1);
    }
    self clientfield::set("play_raps_trail_fx", 0);
    self vehicle_ai::set_state("combat");
    self util::waittill_notify_or_timeout("veh_collision", 1);
    self vehicle::toggle_sounds(1);
    self clientfield::set("raps_landing", 1);
    self.test_failed_path = 1;
    self thread function_902a2c47();
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0xbeb2a4c, Offset: 0x4d38
// Size: 0x94
function function_902a2c47() {
    wait(10);
    while (level flag::get("world_is_paused")) {
        wait(1);
    }
    if (isdefined(self) && !(isdefined(self zm_zonemgr::entity_in_zone("boss_arena_zone", 0)) && self zm_zonemgr::entity_in_zone("boss_arena_zone", 0))) {
        self kill();
    }
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0xbcc39e64, Offset: 0x4dd8
// Size: 0xa8
function function_6deb3e8d() {
    self endon(#"death");
    while (isalive(self)) {
        otherent = self waittill(#"veh_predictedcollision");
        if (isalive(otherent) && otherent.archetype === "zombie" && otherent.knockdown !== 1) {
            otherent zombie_utility::setup_zombie_knockdown(self);
        }
    }
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0x595a59e2, Offset: 0x4e88
// Size: 0x32
function function_3b145bbb() {
    self waittill(#"death");
    level.var_6d27427c--;
    if (level.var_6d27427c < 1) {
        level.var_5fe02c5a = undefined;
    }
}

// Namespace namespace_48757881
// Params 2, eflags: 0x1 linked
// Checksum 0x3fbadc8f, Offset: 0x4ec8
// Size: 0x2e8
function function_ab984a0f(var_41ae2fa1, targetorigin) {
    var_41ae2fa1 endon(#"death");
    targetdist = distance2d(var_41ae2fa1.origin, targetorigin) - 400 + randomfloat(60);
    startorigin = var_41ae2fa1.origin;
    while (distance2dsquared(var_41ae2fa1.origin, startorigin) < targetdist * 0.4 * targetdist * 0.4) {
        wait(0.05);
    }
    fallspeed = 1;
    maxpitch = 10;
    while (distance2dsquared(var_41ae2fa1.origin, startorigin) < max(targetdist * targetdist, -106 * -106)) {
        pitch = angleclamp180(var_41ae2fa1.angles[0]);
        if (pitch < maxpitch) {
            pitch += min(fallspeed, maxpitch - pitch);
            var_41ae2fa1.angles = (pitch, var_41ae2fa1.angles[1], var_41ae2fa1.angles[2]);
        }
        wait(0.05);
    }
    fallspeed = 16;
    maxpitch = 76;
    while (var_41ae2fa1.angles[0] < maxpitch) {
        pitch = angleclamp180(var_41ae2fa1.angles[0]);
        pitch += fallspeed;
        if (pitch > maxpitch) {
            pitch = randomfloatrange(maxpitch, min(pitch, 90));
        }
        var_41ae2fa1.angles = (pitch, var_41ae2fa1.angles[1], var_41ae2fa1.angles[2]);
        wait(0.05);
    }
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0xfe739314, Offset: 0x51b8
// Size: 0xc8
function function_db9ecada() {
    self notify(#"hash_f7204730");
    self endon(#"hash_f7204730");
    self endon(#"change_state");
    while (true) {
        var_8e857deb, origin, normal = self waittill(#"grenade_stuck");
        var_8e857deb thread function_d7ef4d80();
        self function_75775e52(var_8e857deb.origin, 120);
        var_8e857deb clientfield::set("harpoon_impact", 1);
    }
}

// Namespace namespace_48757881
// Params 0, eflags: 0x1 linked
// Checksum 0x48cba058, Offset: 0x5288
// Size: 0x118
function function_d7ef4d80() {
    self endon(#"death");
    while (true) {
        a_ai_zombies = getaiarchetypearray("zombie");
        a_ai_zombies = arraysortclosest(a_ai_zombies, self.origin, undefined, undefined, -56);
        foreach (ai_zombie in a_ai_zombies) {
            if (!isdefined(ai_zombie.var_6c653628)) {
                ai_zombie.var_bb98125f = 1;
                ai_zombie thread namespace_57695b4d::function_1b1bb1b();
            }
        }
        wait(0.25);
    }
}

// Namespace namespace_48757881
// Params 1, eflags: 0x1 linked
// Checksum 0x5bd40020, Offset: 0x53a8
// Size: 0x39c
function function_dfc5ede1(targetent) {
    if (!isalive(self)) {
        return 0;
    }
    self endon(#"death");
    assert(isalive(targetent));
    target = targetent.origin;
    vectotarget = ((target - self.origin)[0], (target - self.origin)[1], 0);
    if (lengthsquared(vectotarget) < 0.01 * 0.01) {
        return 0;
    }
    self vehicle_ai::set_state("special_attack");
    self endon(#"change_state");
    var_bef46db0 = 600;
    var_5eead8e6 = 40;
    self function_d013f7fa((0, 0, 0), 0);
    self function_d013f7fa((0, 0, 0), 1);
    self function_d013f7fa((0, 0, 0), 2);
    self vehicle_ai::setturrettarget(targetent, 0);
    self face_target(target, 30, 0);
    self notify(#"hash_2eb273f0", target);
    if (self.var_65850094[1] > 0) {
        self function_efdfbbf7(1, 1);
    }
    self asmrequestsubstate("arm_rocket@stationary");
    self thread function_db9ecada();
    for (i = 0; i < 3; i++) {
        self waittill(#"hash_685ef1dd");
        var_41ae2fa1 = self fireweapon(2);
        self clearturrettarget();
        if (isdefined(var_41ae2fa1)) {
            self thread function_ab984a0f(var_41ae2fa1, target);
        }
    }
    self function_bb5f9faa(1);
    self clearturrettarget();
    if (self.var_65850094[1] > 0) {
        self function_efdfbbf7(0, 1);
    } else {
        self clientfield::set("nikolai_weakpoint_r_fx", 0);
    }
    self vehicle_ai::waittill_asm_complete("arm_rocket@stationary", 2);
    self vehicle_ai::set_state("combat");
}

// Namespace namespace_48757881
// Params 1, eflags: 0x0
// Checksum 0x913eef54, Offset: 0x5750
// Size: 0xd8
function is_valid_target(target) {
    if (isdefined(target.ignoreme) && target.ignoreme || target.health <= 0) {
        return false;
    } else if (isplayer(target) && target laststand::player_is_in_laststand()) {
        return false;
    } else if (target isnotarget() || issentient(target) && !isalive(target)) {
        return false;
    }
    return true;
}

