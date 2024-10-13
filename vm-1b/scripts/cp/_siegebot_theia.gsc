#using scripts/cp/_util;
#using scripts/cp/cybercom/_cybercom_util;
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
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace siegebot_theia;

// Namespace siegebot_theia
// Params 0, eflags: 0x2
// Checksum 0xcdc49e6c, Offset: 0x660
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("siegebot_theia", &__init__, undefined, undefined);
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0xe12cd782, Offset: 0x698
// Size: 0x7a
function __init__() {
    vehicle::add_main_callback("siegebot_theia", &function_fcf49d56);
    clientfield::register("vehicle", "sarah_rumble_on_landing", 1, 1, "counter");
    clientfield::register("vehicle", "sarah_minigun_spin", 1, 1, "int");
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0x206a8f6f, Offset: 0x720
// Size: 0x27a
function function_fcf49d56() {
    self useanimtree(#generic);
    blackboard::createblackboardforentity(self);
    self blackboard::registervehicleblackboardattributes();
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self enableaimassist();
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
    self.overridevehicledamage = &function_93219dbe;
    self function_d56305c8(1);
    util::magic_bullet_shield(self);
    self function_5a6e3cac();
    self function_6e075bdf(0, self.settings.gunner_turret_on_target_range);
    self function_59d0ca33();
    self thread init_clientfields();
    self.damagelevel = 0;
    self.newdamagelevel = self.damagelevel;
    self function_a849d3e8();
    self function_fac6ca3e();
    if (isdefined(self.var_e35f8efa)) {
        self setgoal(self.var_e35f8efa);
    }
    if (!isdefined(self.height)) {
        self.height = self.radius;
    }
    self.nocybercom = 1;
    self.var_375cf54a = 1;
    self.var_3a087745 = 1;
    self vehicle_ai::function_a767f9b4();
    defaultrole();
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0x9353a324, Offset: 0x9a8
// Size: 0x72
function init_clientfields() {
    self vehicle::lights_on();
    self vehicle::toggle_lights_group(1, 1);
    self vehicle::toggle_lights_group(2, 1);
    self vehicle::toggle_lights_group(3, 1);
    self clientfield::set("sarah_minigun_spin", 0);
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0xa83c0fbe, Offset: 0xa28
// Size: 0x49a
function defaultrole() {
    self vehicle_ai::init_state_machine_for_role();
    self vehicle_ai::get_state_callbacks("combat").enter_func = &function_dbe3c90a;
    self vehicle_ai::get_state_callbacks("combat").update_func = &function_5151f00b;
    self vehicle_ai::get_state_callbacks("combat").exit_func = &function_3344e4e8;
    self vehicle_ai::get_state_callbacks("pain").enter_func = &function_5b4ac0fe;
    self vehicle_ai::get_state_callbacks("pain").update_func = &function_f71fc8b7;
    self vehicle_ai::get_state_callbacks("pain").exit_func = &function_a3bf4514;
    self vehicle_ai::get_state_callbacks("scripted").exit_func = &function_7901b73e;
    self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
    self vehicle_ai::add_state("jumpUp", &function_54c6085f, &function_911f1aa5, &function_309fca92);
    self vehicle_ai::add_state("jumpDown", &function_b76c2c48, &function_911f1aa5, &function_21ee6e62);
    self vehicle_ai::add_state("jumpGroundToGround", &function_b76c2c48, &function_911f1aa5, &function_309fca92);
    self vehicle_ai::add_state("groundCombat", undefined, &function_c05314da, &function_3b3e7a3d);
    self vehicle_ai::add_state("prepareDeath", undefined, &function_975d9d5f, undefined);
    vehicle_ai::add_interrupt_connection("groundCombat", "pain", "pain");
    vehicle_ai::add_utility_connection("emped", "groundCombat");
    vehicle_ai::add_utility_connection("pain", "groundCombat");
    vehicle_ai::add_utility_connection("combat", "jumpDown", &function_a4f97767);
    vehicle_ai::add_utility_connection("jumpDown", "groundCombat");
    vehicle_ai::add_utility_connection("groundCombat", "jumpGroundToGround", &function_d257637c);
    vehicle_ai::add_utility_connection("jumpGroundToGround", "groundCombat");
    vehicle_ai::add_utility_connection("groundCombat", "jumpUp", &function_d1c640f8);
    vehicle_ai::add_utility_connection("jumpUp", "combat");
    vehicle_ai::add_utility_connection("groundCombat", "prepareDeath", &function_3a70e7d7);
    vehicle_ai::cooldown("jump", 22);
    vehicle_ai::cooldown("jumpUp", 33);
    vehicle_ai::startinitialstate("groundCombat");
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0xe84e82a6, Offset: 0xed0
// Size: 0xb2
function state_death_update(params) {
    self endon(#"death");
    self endon(#"nodeath_thread");
    self setturretspinning(0);
    self function_84e7c9e7();
    self function_144b90e8();
    self function_d013f7fa((0, 0, 0));
    self vehicle_death::death_fx();
    self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    self vehicle::set_damage_fx_level(0);
    self playsound("veh_quadtank_sparks");
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0x682b04d4, Offset: 0xf90
// Size: 0xbb
function function_84e7c9e7() {
    if (isdefined(self.jump)) {
        self.jump.linkent delete();
    }
    if (isdefined(self.var_fa144784)) {
        self.var_fa144784 delete();
    }
    if (isdefined(self.var_b66afa28)) {
        foreach (target in self.var_b66afa28) {
            target delete();
        }
    }
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0xbb309767, Offset: 0x1058
// Size: 0x12
function function_d56305c8(enabled) {
    self.var_72861401 = enabled;
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0xa47ca503, Offset: 0x1078
// Size: 0x39
function function_c423e168() {
    state = vehicle_ai::get_current_state();
    return isdefined(state) && state != "pain" && self.var_72861401;
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0xf9d16950, Offset: 0x10c0
// Size: 0x1a
function function_5b4ac0fe(params) {
    self function_144b90e8();
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0xf5ef97a0, Offset: 0x10e8
// Size: 0x1a
function function_a3bf4514(params) {
    self setbrake(0);
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0xfaa5ed71, Offset: 0x1110
// Size: 0x102
function function_f71fc8b7(params) {
    self endon(#"death");
    if (1 <= self.damagelevel && self.damagelevel <= 4) {
        asmstate = "damage_" + self.damagelevel + "@pain";
    } else {
        asmstate = "normal@pain";
    }
    self asmrequestsubstate(asmstate);
    self vehicle_ai::waittill_asm_complete(asmstate, 5);
    vehicle_ai::addcooldowntime("jump", -4.4);
    vehicle_ai::addcooldowntime("jumpUp", -11);
    previous_state = vehicle_ai::get_previous_state();
    self vehicle_ai::set_state(previous_state);
    self vehicle_ai::evaluate_connections();
}

// Namespace siegebot_theia
// Params 3, eflags: 0x0
// Checksum 0x21c07cfd, Offset: 0x1220
// Size: 0x4b
function function_3a70e7d7(from_state, to_state, connection) {
    var_2a5d4f75 = self.healthdefault * 0.1;
    if (self.health < var_2a5d4f75) {
        return 99999999;
    }
    return 0;
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0xb10b8358, Offset: 0x1278
// Size: 0x182
function function_975d9d5f(params) {
    self endon(#"death");
    self endon(#"change_state");
    vehicle_ai::cooldown("spike_on_ground", 2);
    self thread function_57c5370f();
    self thread function_76333d5f();
    function_59d0ca33();
    starttime = gettime();
    while (distance2dsquared(self.origin, self.death_goal_point) > 1200 && vehicle_ai::timesince(starttime) < 8) {
        self setvehgoalpos(self.death_goal_point, 0, 1);
        self setbrake(0);
        wait 1;
    }
    self cancelaimove();
    self clearvehgoalpos();
    self setbrake(1);
    self notify(#"end_attack_thread");
    self notify(#"end_movement_thread");
    self.jump.var_79dc9b21 = self.jump.var_6829bbf7[0];
    self function_54c6085f(params);
    self function_911f1aa5(params);
    util::stop_magic_bullet_shield(self);
    self.var_12c7e390 = 1;
    self function_5151f00b(params);
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0xbef5f61f, Offset: 0x1408
// Size: 0x3a
function function_7901b73e(params) {
    vehicle_ai::cooldown("jump", 22);
    vehicle_ai::cooldown("jumpUp", 33);
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0x91a85e36, Offset: 0x1450
// Size: 0x1da
function function_5a6e3cac() {
    if (isdefined(self.jump)) {
        self unlink();
        self.jump.linkent delete();
        self.jump delete();
    }
    self.jump = spawnstruct();
    self.jump.linkent = spawn("script_origin", self.origin);
    self.jump.var_425f84b1 = 0;
    self.jump.var_6829bbf7 = struct::get_array("balcony_point");
    self.jump.groundpoints = struct::get_array("ground_point");
    self.arena_center = struct::get("arena_center").origin;
    self.death_goal_point = struct::get("death_goal_point").origin;
    self.var_e35f8efa = getent("theia_combat_region", "targetname");
    assert(self.jump.var_6829bbf7.size > 0);
    assert(self.jump.groundpoints.size > 0);
    assert(isdefined(self.arena_center));
}

// Namespace siegebot_theia
// Params 3, eflags: 0x0
// Checksum 0xb095169a, Offset: 0x1638
// Size: 0xa3
function function_d1c640f8(from_state, to_state, connection) {
    if (!vehicle_ai::iscooldownready("jump") || !vehicle_ai::iscooldownready("jumpUp")) {
        return 0;
    }
    target = function_44598626(800, 2000, self.jump.var_6829bbf7, 1200);
    if (isdefined(target)) {
        self.jump.var_79dc9b21 = target;
        return 500;
    }
    return 0;
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0x97b730b3, Offset: 0x16e8
// Size: 0x182
function function_54c6085f(params) {
    goal = self.jump.var_79dc9b21.origin;
    trace = physicstrace(goal + (0, 0, 500), goal - (0, 0, 10000), (-10, -10, -10), (10, 10, 10), self, 2);
    if (false) {
        /#
            debugstar(goal, 60000, (0, 1, 0));
        #/
        /#
            debugstar(trace["<dev string:x28>"], 60000, (0, 1, 0));
        #/
        /#
            line(goal, trace["<dev string:x28>"], (0, 1, 0), 1, 0, 60000);
        #/
    }
    if (trace["fraction"] < 1) {
        goal = trace["position"];
    }
    self.jump.var_79dc9b21 = goal;
    self.jump.goal = goal;
    params.var_bc1a4954 = 70;
    params.var_a1e09ed6 = (0, 0, -5);
    params.var_3a388f84 = 10;
    params.var_fb532e19 = "land_turn@jump";
    self function_d56305c8(0);
    self function_144b90e8();
}

// Namespace siegebot_theia
// Params 3, eflags: 0x0
// Checksum 0x2a6ab61c, Offset: 0x1878
// Size: 0x8b
function function_a4f97767(from_state, to_state, connection) {
    if (!vehicle_ai::iscooldownready("jump") || self.var_a92e753f === 1) {
        return 0;
    }
    target = function_c323eed7(800, 2000, 1300);
    if (isdefined(target)) {
        self.jump.var_44d87db5 = target;
        return 500;
    }
    return 0;
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0x48af7051, Offset: 0x1910
// Size: 0x17a
function function_b76c2c48(params) {
    goal = self.jump.var_44d87db5;
    trace = physicstrace(goal + (0, 0, 500), goal - (0, 0, 10000), (-10, -10, -10), (10, 10, 10), self, 2);
    if (false) {
        /#
            debugstar(goal, 60000, (0, 1, 0));
        #/
        /#
            debugstar(trace["<dev string:x28>"], 60000, (0, 1, 0));
        #/
        /#
            line(goal, trace["<dev string:x28>"], (0, 1, 0), 1, 0, 60000);
        #/
    }
    if (trace["fraction"] < 1) {
        goal = trace["position"];
    }
    self.jump.var_44d87db5 = goal;
    self.jump.goal = goal;
    params.var_bc1a4954 = 70;
    params.var_a1e09ed6 = (0, 0, -5);
    params.var_3a388f84 = -5;
    params.var_fb532e19 = "land@jump";
    self function_d56305c8(0);
    self function_144b90e8();
}

// Namespace siegebot_theia
// Params 3, eflags: 0x0
// Checksum 0xce9b1101, Offset: 0x1a98
// Size: 0x7b
function function_d257637c(from_state, to_state, connection) {
    if (!vehicle_ai::iscooldownready("jump")) {
        return 0;
    }
    target = function_c323eed7(800, 1800, 1300, 0, 0, 0);
    if (isdefined(target)) {
        self.jump.var_44d87db5 = target;
        return 400;
    }
    return 0;
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0xe34f5da1, Offset: 0x1b20
// Size: 0x1a
function function_309fca92(params) {
    self function_d56305c8(1);
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0xdccb2274, Offset: 0x1b48
// Size: 0x4a
function function_21ee6e62(params) {
    self function_d56305c8(1);
    self vehicle_ai::cooldown("jumpUp", 11 + randomfloatrange(-1, 3));
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0x976a1429, Offset: 0x1ba0
// Size: 0xa02
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
    var_920c55a7 = mapfloat(500, 2000, 0, 0.5, totaldistance);
    var_f1e5d209 = (0, 0, 1) * (var_a2961d4 + params.var_3a388f84);
    var_e6651399 = forward * params.var_bc1a4954 * mapfloat(500, 2000, 0.8, 1, totaldistance);
    velocity = var_f1e5d209 + var_e6651399;
    self asmrequestsubstate("inair@jump");
    self waittill(#"hash_34a180dd");
    self vehicle::impact_fx(self.settings.var_2ba72ce7);
    self waittill(#"hash_f1a0ad10");
    self vehicle::impact_fx(self.settings.var_f209c6c6);
    var_d3ef7ffb = gettime();
    while (true) {
        distancetogoal = distance2d(self.jump.linkent.origin, goal);
        var_570dcf42 = mapfloat(0, 0.5, 0.6, 0, abs(0.5 - distancetogoal / totaldistance));
        var_7e526cf9 = mapfloat(self.radius * 1, self.radius * 3, 0, 1, distancetogoal);
        var_8ef0e611 = var_7e526cf9 * var_570dcf42 * params.var_a1e09ed6 * -1 + (0, 0, var_920c55a7);
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
                continue;
            }
            player dodamage(20, self.origin, self);
        }
    }
    self vehicle::impact_fx(self.settings.var_9f4c9669);
    self function_144b90e8();
    self clientfield::increment("sarah_rumble_on_landing");
    wait 0.3;
    self unlink();
    wait 0.05;
    self.jump.var_425f84b1 = 0;
    self notify(#"hash_48269e0e");
    vehicle_ai::cooldown("jump", 11);
    vehicle_ai::cooldown("ignore_player", 12);
    self vehicle_ai::waittill_asm_complete(params.var_fb532e19, 3);
    self vehicle_ai::evaluate_connections();
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0xf16a288c, Offset: 0x25b0
// Size: 0x8a
function function_dbe3c90a(params) {
    self vehicle_ai::clearalllookingandtargeting();
    self function_d013f7fa((0, 0, 0), 0);
    self function_d013f7fa((0, 0, 0), 1);
    self function_d013f7fa((0, 0, 0), 2);
    self function_d013f7fa((0, 0, 0), 3);
    self function_d013f7fa((0, 0, 0), 4);
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0x2f212d1c, Offset: 0x2648
// Size: 0x245
function function_5151f00b(params) {
    self endon(#"change_state");
    self endon(#"death");
    var_1181b4ed = undefined;
    foreach (var_a1b61a44 in self.jump.var_6829bbf7) {
        if (distance2dsquared(var_a1b61a44.origin, self.origin) < self.radius * 6 * self.radius * 6) {
            var_1181b4ed = var_a1b61a44;
            break;
        }
    }
    if (!isdefined(var_1181b4ed)) {
        self vehicle_ai::clearcooldown("jump");
        self vehicle_ai::evaluate_connections();
    }
    forward = anglestoforward(var_1181b4ed.angles);
    while (true) {
        while (!isdefined(self.enemy)) {
            wait 1;
        }
        self face_target(self.origin + forward * 10000);
        var_35e1c37a = self.damagelevel * 0.15;
        if (randomfloat(1) < var_35e1c37a) {
            function_5e2157f5();
            level notify(#"hash_38559d8c");
            self vehicle_ai::evaluate_connections();
            wait 0.8;
        }
        function_6909a1a4();
        level notify(#"hash_38559d8c");
        self vehicle_ai::evaluate_connections();
        if (randomfloat(1) > 0.4 && self.var_12c7e390 !== 1) {
            wait 0.2;
            self function_e5af3b61();
        }
        wait 0.8;
        function_42fa8354();
        level notify(#"hash_38559d8c");
        self vehicle_ai::evaluate_connections();
        wait 0.8;
    }
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0xb422171b, Offset: 0x2898
// Size: 0x21e
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
    if (false) {
        /#
            line(start, start + tracedir * step_size, (1, 0, 0), 1, 0, 100);
        #/
    }
    if (trace["fraction"] < 1) {
        tracedir *= -1;
        trace = physicstrace(start, start + tracedir * step_size, 0.8 * (self.radius * -1, self.radius * -1, 0), 0.8 * (self.radius, self.radius, self.height), self, 2);
        var_11b475f9 = var_b274fc28;
        if (false) {
            /#
                line(start, start + tracedir * step_size, (1, 0, 0), 1, 0, 100);
            #/
        }
    }
    if (trace["fraction"] >= 1) {
        self asmrequestsubstate(var_11b475f9);
        self vehicle_ai::waittill_asm_complete(var_11b475f9, 3);
        self function_59d0ca33();
        return true;
    }
    return false;
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0xbfb70470, Offset: 0x2ac0
// Size: 0x8a
function function_3344e4e8(params) {
    self vehicle_ai::clearalllookingandtargeting();
    self function_d013f7fa((0, 0, 0), 0);
    self function_d013f7fa((0, 0, 0), 1);
    self function_d013f7fa((0, 0, 0), 2);
    self function_d013f7fa((0, 0, 0), 3);
    self function_d013f7fa((0, 0, 0), 4);
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0xe72f6ea, Offset: 0x2b58
// Size: 0xb9
function function_c05314da(params) {
    self endon(#"death");
    self endon(#"change_state");
    if (vehicle_ai::get_previous_state() === "jump") {
        vehicle_ai::cooldown("spike_on_ground", 2);
    }
    self thread function_57c5370f();
    self thread function_76333d5f();
    self thread movement_thread();
    self thread function_6f90eaa6();
    self thread function_7080094f();
    while (true) {
        self vehicle_ai::evaluate_connections();
        wait 1;
    }
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0x26246cae, Offset: 0x2c20
// Size: 0x163
function function_a812ea81(tag_name) {
    origin = self gettagorigin(tag_name);
    foreach (player in level.players) {
        player.var_31d70948 = player.takedamage;
        player.takedamage = 0;
    }
    self radiusdamage(origin + (0, 0, 10), self.radius, -56, -56, self, "MOD_EXPLOSIVE");
    foreach (player in level.players) {
        player.takedamage = player.var_31d70948;
        player.var_31d70948 = undefined;
        if (distance2dsquared(origin, player.origin) < self.radius * self.radius) {
            player dodamage(15, origin, self);
        }
    }
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0x5a17c897, Offset: 0x2d90
// Size: 0x4d
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

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0x452b49c7, Offset: 0x2de8
// Size: 0x4d
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

// Namespace siegebot_theia
// Params 4, eflags: 0x0
// Checksum 0x34d4324f, Offset: 0x2e40
// Size: 0x24f
function function_44598626(var_4ff43c77, var_34ff10c9, pointsarray, idealdist) {
    /#
        record3dtext("<dev string:x31>" + var_4ff43c77 + "<dev string:x3a>" + var_34ff10c9 + "<dev string:x3c>", self.origin, (1, 0.5, 0), "<dev string:x3e>", self);
    #/
    bestscore = 1000000;
    result = undefined;
    foreach (point in pointsarray) {
        distancetotarget = distance2d(point.origin, self.origin);
        if (distancetotarget < var_4ff43c77 || var_34ff10c9 < distancetotarget) {
            /#
                recordstar(point.origin, (1, 0.5, 0));
            #/
            /#
                record3dtext("<dev string:x45>" + distancetotarget, point.origin, (1, 0.5, 0), "<dev string:x3e>", self);
            #/
            continue;
        }
        score = abs(distancetotarget - idealdist);
        if (score < -56) {
            score = randomfloat(-56);
        }
        if (point === self.jump.var_79dc9b21) {
            score += 1000;
        }
        /#
            recordstar(point.origin, (1, 0.5, 0));
        #/
        /#
            record3dtext("<dev string:x54>" + distancetotarget + "<dev string:x5b>" + score, point.origin, (1, 0.5, 0), "<dev string:x3e>", self);
        #/
        if (score < bestscore) {
            bestscore = score;
            result = point;
        }
    }
    if (isdefined(result)) {
        return result;
    }
    return undefined;
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0x7e0d8e59, Offset: 0x3098
// Size: 0x3a
function function_3b3e7a3d(params) {
    self notify(#"end_attack_thread");
    self notify(#"end_movement_thread");
    self clearturrettarget();
    self setturretspinning(0);
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0xafc3d17f, Offset: 0x30e0
// Size: 0x5f
function function_ea8eac3c(player) {
    if (isplayer(player)) {
        if (player.usingvehicle && isdefined(player.viewlockedentity) && isvehicle(player.viewlockedentity)) {
            return player.viewlockedentity;
        }
    }
    return undefined;
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0x52811575, Offset: 0x3148
// Size: 0xee
function function_a9cc4c74() {
    targets = level.players;
    vehicles = [];
    foreach (player in level.players) {
        vehicle = function_ea8eac3c(player);
        if (isdefined(vehicle)) {
            if (!isdefined(vehicles)) {
                vehicles = [];
            } else if (!isarray(vehicles)) {
                vehicles = array(vehicles);
            }
            vehicles[vehicles.size] = vehicle;
        }
    }
    targets = arraycombine(targets, vehicles, 0, 0);
    return targets;
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0x26f063b5, Offset: 0x3240
// Size: 0xca
function function_9ce79c2c(player) {
    index = player getentitynumber();
    if (!isdefined(self.var_236a6361)) {
        self.var_236a6361 = [];
        for (i = 0; i < 4; i++) {
            self.var_236a6361[self.var_236a6361.size] = spawnstruct();
        }
    }
    if (!isdefined(self.var_236a6361[index].damage) || !isdefined(self.var_236a6361[index].var_b0ca0dd0) || !isdefined(self.var_236a6361[index].var_5b4cf339)) {
        function_cdc7d6d5(player);
    }
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0x22968fa2, Offset: 0x3318
// Size: 0xc3
function function_a849d3e8() {
    callback::on_spawned(&function_9ce79c2c, self);
    callback::on_player_killed(&function_9ce79c2c, self);
    callback::on_laststand(&function_9ce79c2c, self);
    foreach (player in level.players) {
        self function_9ce79c2c(player);
    }
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0xd0f7d87b, Offset: 0x33e8
// Size: 0x11a
function function_cdc7d6d5(player) {
    index = player getentitynumber();
    mindamage = self.var_236a6361[index].damage;
    if (!isdefined(mindamage)) {
        mindamage = 1000000;
    }
    if (self.var_236a6361.size > 0) {
        foreach (threat in self.var_236a6361) {
            if (isdefined(threat.damage)) {
                mindamage = min(mindamage, threat.damage);
            }
        }
    } else {
        mindamage = 0;
    }
    self.var_236a6361[index].damage = mindamage;
    self.var_236a6361[index].var_b0ca0dd0 = 0;
    self.var_236a6361[index].var_5b4cf339 = 0;
}

// Namespace siegebot_theia
// Params 2, eflags: 0x0
// Checksum 0x330e699, Offset: 0x3510
// Size: 0x52
function function_ffea59d7(player, damage) {
    index = player getentitynumber();
    self.var_236a6361[index].damage = self.var_236a6361[index].damage + damage;
}

// Namespace siegebot_theia
// Params 3, eflags: 0x0
// Checksum 0x8befa096, Offset: 0x3570
// Size: 0x9e
function function_b95b6735(player, boost, timeseconds) {
    index = player getentitynumber();
    if (self.var_236a6361[index].var_5b4cf339 <= gettime()) {
        self.var_236a6361[index].var_b0ca0dd0 = 0;
    }
    self.var_236a6361[index].var_b0ca0dd0 = self.var_236a6361[index].var_b0ca0dd0 + boost;
    self.var_236a6361[index].var_5b4cf339 = gettime() + timeseconds * 1000;
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0xb869aa19, Offset: 0x3618
// Size: 0x18d
function function_765debac(player) {
    if (!is_valid_target(player)) {
        return;
    }
    var_644f139c = 7;
    currenttime = gettime();
    if (isdefined(player.var_47b86c9b) && player.var_47b86c9b + var_644f139c * 1000 > currenttime) {
        return;
    }
    index = player getentitynumber();
    if (!isdefined(self.var_236a6361) || !isdefined(self.var_236a6361[index])) {
        return;
    }
    threat = self.var_236a6361[index].damage;
    if (self.var_236a6361[index].var_5b4cf339 > gettime()) {
        threat += self.var_236a6361[index].var_b0ca0dd0;
    }
    if (self.var_3e3e2c02 === player) {
        threat += 1000;
    }
    if (self function_6d424c6f(player, 3)) {
        threat += 1000;
    }
    if (player.health < 50) {
        threat -= 800;
    }
    distancesqr = distance2dsquared(self.origin, player.origin);
    if (distancesqr < 800 * 800) {
        threat += 800;
    } else if (distancesqr < 1500 * 1500) {
        threat += 400;
    }
    return threat;
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0xde80e3b1, Offset: 0x37b0
// Size: 0xab
function update_target_player() {
    var_1090957a = -1000000;
    self.var_3e3e2c02 = undefined;
    foreach (player in level.players) {
        threat = function_765debac(player);
        if (isdefined(threat) && threat > var_1090957a) {
            var_1090957a = threat;
            self.var_3e3e2c02 = player;
        }
    }
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0x94b8a9be, Offset: 0x3868
// Size: 0x6a
function function_50256641(target) {
    if (!isdefined(target)) {
        self function_d013f7fa((0, 0, 0), 3);
        self function_d013f7fa((0, 0, 0), 4);
        return;
    }
    self vehicle_ai::setturrettarget(target, 3);
    self vehicle_ai::setturrettarget(target, 4);
}

// Namespace siegebot_theia
// Params 3, eflags: 0x0
// Checksum 0x76c69ff0, Offset: 0x38e0
// Size: 0x8d
function function_347f88f3(target, time, color) {
    self endon(#"death");
    point1 = self.origin;
    point2 = target.origin;
    if (false) {
        stoptime = gettime() + time * 1000;
        while (gettime() <= stoptime) {
            /#
                line(point1, point2, color, 1, 0, 3);
            #/
            wait 0.05;
        }
    }
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0x2ed8516c, Offset: 0x3978
// Size: 0x71
function function_30ecb08(delay) {
    self endon(#"death");
    wait delay;
    for (i = 0; i < 3 && i < self.var_b66afa28.size; i++) {
        var_41ae2fa1 = self.var_b66afa28[i];
        var_41ae2fa1 function_d9cdf83c();
        wait 0.15;
    }
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0x9e2eecc4, Offset: 0x39f8
// Size: 0x2fd
function function_57c5370f() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    self notify(#"hash_1f81be6d");
    self endon(#"hash_1f81be6d");
    while (true) {
        enemy = self.enemy;
        if (!isdefined(enemy)) {
            self function_d013f7fa((0, 0, 0));
            wait 0.4;
            continue;
        }
        if (!enemy.allowdeath && !isplayer(enemy)) {
            self setpersonalthreatbias(enemy, -2000, 8);
            wait 0.4;
            continue;
        }
        distsq = distancesquared(enemy.origin, self.origin);
        if (-56 * -56 < distsq && (isplayer(enemy) || self function_4246bc05(enemy) && distsq < 2000 * 2000)) {
            self setpersonalthreatbias(enemy, 1000, 1);
        } else {
            self setpersonalthreatbias(enemy, -1000, 1);
        }
        self vehicle_ai::setturrettarget(enemy, 0);
        self vehicle_ai::setturrettarget(enemy, 1);
        self function_50256641(enemy);
        var_cc58fc9d = gettime();
        self setturretspinning(1);
        while (isdefined(enemy) && !self.gunner1ontarget && vehicle_ai::timesince(var_cc58fc9d) < 2) {
            wait 0.4;
        }
        if (!isdefined(enemy)) {
            self setturretspinning(0);
            continue;
        }
        var_2c0fecbc = gettime();
        while (isdefined(enemy) && enemy === self.enemy && self function_6d424c6f(enemy, 1) && vehicle_ai::timesince(var_2c0fecbc) < 5) {
            self vehicle_ai::fire_for_time(1 + randomfloat(0.4), 1);
            if (isdefined(enemy) && isplayer(enemy)) {
                wait 0.6 + randomfloat(0.2);
            }
            wait 0.1;
        }
        self setturretspinning(0);
        wait 0.1;
    }
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0x80220fc4, Offset: 0x3d00
// Size: 0x5e9
function function_76333d5f() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    self notify(#"hash_b0c6a8c1");
    self endon(#"hash_b0c6a8c1");
    while (true) {
        enemy = self.enemy;
        if (!isdefined(enemy)) {
            wait 0.4;
            continue;
        }
        if (vehicle_ai::iscooldownready("spike_on_ground", 2) && self.var_5c05fe94 !== 1) {
            self function_7e56865f(1);
        }
        if (!vehicle_ai::iscooldownready("spike_on_ground")) {
            wait 0.4;
            continue;
        }
        var_7136ec77 = enemy;
        targets = getaiteamarray("allies");
        targets = arraycombine(targets, level.players, 0, 0);
        var_bee1759b = vectornormalize(((var_7136ec77.origin - self.origin)[0], (var_7136ec77.origin - self.origin)[1], 0));
        var_702668a9 = 0;
        besttarget = undefined;
        foreach (target in targets) {
            if (target isnotarget() || target == var_7136ec77) {
                continue;
            }
            dirtotarget = vectornormalize(((target.origin - self.origin)[0], (target.origin - self.origin)[1], 0));
            var_93798797 = vectordot(dirtotarget, var_bee1759b);
            if (var_93798797 < 0.2) {
                continue;
            }
            var_de3e8c8c = distance2dsquared(target.origin, self.origin);
            if (var_de3e8c8c < 400 * 400 || var_de3e8c8c > 1200 * 1200) {
                continue;
            }
            var_1e946c1e = function_a22c73c2(target);
            var_1e946c1e += 1 - var_93798797;
            if (isplayer(target)) {
                var_1e946c1e += 0.5;
            }
            var_b091d6b4 = distance2dsquared(target.origin, var_7136ec77.origin);
            if (var_b091d6b4 < -56 * -56) {
                var_1e946c1e -= 0.3;
            }
            if (var_702668a9 <= var_1e946c1e) {
                var_702668a9 = var_1e946c1e;
                besttarget = target;
            }
        }
        enemy = besttarget;
        if (isalive(enemy)) {
            if (false) {
                self thread function_347f88f3(enemy, 5, (1, 0, 0));
            }
            turretorigin = self gettagorigin("tag_gunner_flash2");
            disttoenemy = distance2d(self.origin, enemy.origin);
            var_810d699b = math::clamp(disttoenemy * 0.35, 100, 350);
            points = generatepointsaroundcenter(enemy.origin + (0, 0, var_810d699b), 300, 80, 50);
            var_3e2886cb = mapfloat(300, 700, 0.1, 1, disttoenemy);
            var_41ae2fa1 = self.var_b66afa28[0];
            var_41ae2fa1.origin = points[0];
            self function_9af49228(var_41ae2fa1, (0, 0, 0), 1);
            var_7aa511a9 = gettime();
            while (!self.gunner2ontarget && vehicle_ai::timesince(var_7aa511a9) < 2) {
                wait 0.4;
            }
            self thread function_30ecb08(var_3e2886cb);
            for (i = 0; i < 3 && i < self.var_b66afa28.size && i < points.size; i++) {
                var_41ae2fa1 = self.var_b66afa28[i];
                var_41ae2fa1.origin = points[i];
                self function_9af49228(var_41ae2fa1, (0, 0, 0), 1);
                self fireweapon(2, enemy);
                vehicle_ai::cooldown("spike_on_ground", randomfloatrange(6, 10));
                if (false) {
                    /#
                        debugstar(var_41ae2fa1.origin, -56, (1, 0, 0));
                    #/
                    /#
                        circle(var_41ae2fa1.origin, -106, (1, 0, 0), 0, 1, -56);
                    #/
                }
                wait 0.1;
            }
            wait 0.5;
            self function_d013f7fa((0, 0, 0), 2);
            self function_7e56865f(0);
            continue;
        }
        wait 0.4;
    }
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0x6148a40c, Offset: 0x42f8
// Size: 0x22
function function_7e56865f(is_aiming) {
    self.var_5c05fe94 = is_aiming;
    self function_59d0ca33();
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0x488c0412, Offset: 0x4328
// Size: 0x42
function function_59d0ca33() {
    if (self.var_5c05fe94 === 1) {
        locomotion = "locomotion@movement";
    } else {
        locomotion = "locomotion_rocketup@movement";
    }
    self asmrequestsubstate(locomotion);
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0x3e4b5dd9, Offset: 0x4378
// Size: 0x13e
function function_13a5941d() {
    mindist = 400;
    ai_array = getaiteamarray("allies");
    ai_array = array::randomize(ai_array);
    foreach (ai in ai_array) {
        var_8fb7a6dc = 1;
        foreach (player in level.players) {
            if (is_valid_target(player) && distance2dsquared(ai.origin, player.origin) < mindist * mindist) {
                var_8fb7a6dc = 0;
                break;
            }
        }
        if (!var_8fb7a6dc) {
        }
    }
    return undefined;
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0x36adcfac, Offset: 0x44c0
// Size: 0x235
function movement_thread() {
    self endon(#"death");
    self endon(#"change_state");
    self notify(#"end_movement_thread");
    self endon(#"end_movement_thread");
    while (true) {
        self update_target_player();
        enemy = self.var_3e3e2c02;
        if (level.players.size <= 1 && vehicle_ai::iscooldownready("ignore_player")) {
            vehicle_ai::cooldown("ignore_player", 12);
            enemy = function_13a5941d();
            foreach (player in level.players) {
                self setpersonalthreatbias(player, -1000, 2);
            }
        }
        if (!isdefined(enemy)) {
            enemy = self.enemy;
        }
        if (!isdefined(enemy)) {
            wait 0.05;
            continue;
        }
        self.current_pathto_pos = self function_cbe64bb2(enemy);
        self.var_bd3ce0aa = enemy.origin;
        self setspeed(self.settings.defaultmovespeed);
        foundpath = self setvehgoalpos(self.current_pathto_pos, 0, 1);
        if (foundpath) {
            self setlookatent(enemy);
            self setbrake(0);
            function_59d0ca33();
            self thread path_update_interrupt();
            self vehicle_ai::waittill_pathing_done();
            self notify(#"hash_d19d4706");
            self cancelaimove();
            self clearvehgoalpos();
            self setbrake(1);
        }
        wait 0.05;
    }
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0xc065a68b, Offset: 0x4700
// Size: 0x8d
function path_update_interrupt() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_movement_thread");
    self notify(#"hash_d19d4706");
    self endon(#"hash_d19d4706");
    while (true) {
        if (isdefined(self.var_bd3ce0aa) && isdefined(self.var_3e3e2c02)) {
            if (distance2dsquared(self.var_bd3ce0aa, self.var_3e3e2c02.origin) > -56 * -56) {
                self notify(#"near_goal");
            }
        }
        wait 0.8;
    }
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0x21d39470, Offset: 0x4798
// Size: 0x525
function function_cbe64bb2(enemy) {
    if (self.goalforced) {
        return self.goalpos;
    }
    halfheight = 400;
    spacing = 80;
    queryorigin = self.origin;
    if (isdefined(enemy) && self canpath(self.origin, enemy.origin)) {
        queryorigin = enemy.origin;
    }
    queryresult = positionquery_source_navigation(queryorigin, 0, self.settings.engagementdistmax + -56, halfheight, spacing, self);
    if (isdefined(enemy)) {
        positionquery_filter_sight(queryresult, enemy.origin, self geteye() - self.origin, self, 0, enemy);
        vehicle_ai::positionquery_filter_engagementdist(queryresult, enemy, self.settings.engagementdistmin, self.settings.engagementdistmax);
    }
    positionquery_filter_distancetogoal(queryresult, self);
    vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
    forward = anglestoforward(self.angles);
    if (isdefined(enemy)) {
        enemydir = vectornormalize(enemy.origin - self.origin);
        forward = vectornormalize(forward + 5 * enemydir);
    }
    foreach (point in queryresult.data) {
        if (distance2dsquared(self.origin, point.origin) < 300 * 300) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x64>"] = -700;
            #/
            point.score += -700;
        }
        if (isdefined(enemy)) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x73>"] = point.distawayfromengagementarea * -1;
            #/
            point.score += point.distawayfromengagementarea * -1;
            if (!point.visibility) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["<dev string:x82>"] = -600;
                #/
                point.score += -600;
            }
        }
        pointdirection = vectornormalize(point.origin - self.origin);
        factor = vectordot(pointdirection, forward);
        if (factor > 0.7) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x8d>"] = 600;
            #/
            point.score += 600;
            continue;
        }
        if (factor > 0) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x8d>"] = 0;
            #/
            point.score += 0;
            continue;
        }
        if (factor > -0.5) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["<dev string:x8d>"] = -600;
            #/
            point.score += -600;
            continue;
        }
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["<dev string:x8d>"] = -1200;
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

// Namespace siegebot_theia
// Params 3, eflags: 0x0
// Checksum 0x9531fd6d, Offset: 0x4cc8
// Size: 0x69
function function_9dfac374(left, right, point) {
    var_c8c31226 = distance2dsquared(left.origin, point);
    var_d69cdbbd = distance2dsquared(right.origin, point);
    return var_c8c31226 > var_d69cdbbd;
}

// Namespace siegebot_theia
// Params 2, eflags: 0x0
// Checksum 0xe9b20e9e, Offset: 0x4d40
// Size: 0x92
function function_feedbcc3(point, mindistance) {
    foreach (var_a1b61a44 in self.jump.var_6829bbf7) {
        if (distance2dsquared(point, var_a1b61a44.origin) < mindistance * mindistance) {
            return true;
        }
    }
    return false;
}

// Namespace siegebot_theia
// Params 6, eflags: 0x0
// Checksum 0x8ab4d191, Offset: 0x4de0
// Size: 0x6c5
function function_c323eed7(var_4ff43c77, var_34ff10c9, idealdist, var_a83a9c, var_37cbd25e, var_b716a4e2) {
    targets = level.players;
    if (var_a83a9c === 1) {
        targets = arraycombine(targets, getaiteamarray("allies"), 0, 0);
        targets = array::merge_sort(targets, &function_9dfac374, self.origin);
    }
    angles = (0, self.angles[1], 0);
    forward = anglestoforward(angles);
    besttarget = undefined;
    bestscore = 1000000;
    var_1e5d41a4 = 300;
    var_50e99cbf = 1800;
    /#
        recordstar(self.origin, (1, 0.5, 0));
    #/
    /#
        record3dtext("<dev string:x9b>", self.origin, (1, 0.5, 0), "<dev string:x3e>", self);
    #/
    foreach (target in targets) {
        if (!is_valid_target(target) || !target.allowdeath || isairborne(target)) {
            continue;
        }
        if (distance2dsquared(self.arena_center, target.origin) > var_50e99cbf * var_50e99cbf) {
            /#
                recordstar(target.origin, (0, 0.5, 1));
            #/
            /#
                record3dtext("<dev string:xaa>" + distance2d(self.arena_center, target.origin), target.origin, (0, 0.5, 1), "<dev string:x3e>", self);
            #/
            continue;
        }
        if (function_feedbcc3(target.origin, var_1e5d41a4)) {
            /#
                recordstar(target.origin, (0, 0.5, 1));
            #/
            /#
                record3dtext("<dev string:xc0>", target.origin, (0, 0.5, 1), "<dev string:x3e>", self);
            #/
            continue;
        }
        distancetotarget = distance2d(target.origin, self.origin);
        if (distancetotarget < var_4ff43c77 || var_34ff10c9 < distancetotarget) {
            /#
                recordstar(target.origin, (1, 0.5, 0));
            #/
            /#
                record3dtext("<dev string:x45>" + distancetotarget, target.origin, (1, 0.5, 0), "<dev string:x3e>", self);
            #/
            continue;
        }
        vectortotarget = ((target.origin - self.origin)[0], (target.origin - self.origin)[1], 0);
        vectortotarget /= distancetotarget;
        if (isdefined(var_37cbd25e) && vectordot(forward, vectortotarget) < var_37cbd25e) {
            continue;
        }
        score = abs(distancetotarget - idealdist);
        if (score < -56) {
            score = randomfloat(-56);
        }
        /#
            recordstar(target.origin, (1, 0.5, 0));
        #/
        /#
            record3dtext("<dev string:x54>" + distancetotarget + "<dev string:x5b>" + score, target.origin, (1, 0.5, 0), "<dev string:x3e>", self);
        #/
        if (isplayer(target) && !isvehicle(target)) {
            minradius = 0;
            maxradius = 300;
        } else {
            minradius = -56;
            maxradius = 400;
        }
        queryresult = positionquery_source_navigation(target.origin, minradius, maxradius, 500, self.radius * 0.5, self.radius * 1.1);
        if (queryresult.data.size > 0) {
            element = queryresult.data[0];
            if (score < bestscore) {
                bestscore = score;
                besttarget = element;
            }
        }
    }
    if (isdefined(besttarget)) {
        return besttarget.origin;
    }
    if (var_b716a4e2 === 0) {
        return undefined;
    }
    queryresult = positionquery_source_navigation(self.arena_center, 100, 1300, 500, self.radius, self.radius * 1.1);
    assert(queryresult.data.size > 0);
    var_6ab55afd = array::randomize(queryresult.data);
    foreach (point in var_6ab55afd) {
        var_edf6415e = distance2dsquared(point.origin, self.origin);
        if (var_4ff43c77 * var_4ff43c77 < var_edf6415e && var_edf6415e < var_34ff10c9 * var_34ff10c9 && !function_feedbcc3(point.origin, var_1e5d41a4)) {
            return point.origin;
        }
    }
    return self.arena_center;
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0xabc3fcaa, Offset: 0x54b0
// Size: 0x62
function function_144b90e8() {
    self notify(#"end_movement_thread");
    self notify(#"near_goal");
    self cancelaimove();
    self clearvehgoalpos();
    self clearturrettarget();
    self clearlookatent();
    self setbrake(1);
}

// Namespace siegebot_theia
// Params 2, eflags: 0x0
// Checksum 0x9d3681f8, Offset: 0x5520
// Size: 0x192
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
        if (false) {
            /#
                line(self.origin, position, (1, 0, 1), 1, 0, 5);
            #/
        }
        anglediff = absangleclamp180(self.angles[1] - goalangles[1]);
        wait 0.05;
    }
    self clearvehgoalpos();
    self clearlookatent();
    self clearturrettarget();
    self cancelaimove();
}

// Namespace siegebot_theia
// Params 13, eflags: 0x0
// Checksum 0xd3311c00, Offset: 0x56c0
// Size: 0x1ec
function function_93219dbe(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname) {
    if (!isplayer(eattacker)) {
        idamage = 0;
        return idamage;
    }
    num_players = getplayers().size;
    var_64d030a4 = 1 / num_players;
    idamage *= var_64d030a4;
    if (smeansofdeath !== "MOD_UNKNOWN" && idamage > self.healthdefault * 8 * 0.01) {
        idamage = self.healthdefault * 8 * 0.01;
    }
    newdamagelevel = vehicle::should_update_damage_fx_level(self.health, idamage, self.healthdefault);
    if (newdamagelevel > self.damagelevel) {
        self.newdamagelevel = newdamagelevel;
    }
    if (self.newdamagelevel > self.damagelevel && function_c423e168()) {
        self.damagelevel = self.newdamagelevel;
        self notify(#"pain");
        vehicle::set_damage_fx_level(self.damagelevel);
        if (self.damagelevel >= 2) {
            self vehicle::toggle_lights_group(1, 0);
        }
    }
    if (isdefined(eattacker) && isplayer(eattacker)) {
        function_ffea59d7(eattacker, idamage);
        if (idamage > 500) {
            function_b95b6735(eattacker, 1000, 4);
        }
    }
    return idamage;
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0xd055a05f, Offset: 0x58b8
// Size: 0x24a
function function_5e2157f5() {
    if (level.players.size < 1) {
        return;
    }
    enemy = array::random(level.players);
    if (!isdefined(enemy)) {
        return;
    }
    forward = anglestoforward(self.angles);
    shootpos = self.origin + forward * -56 + (0, 0, 500);
    self asmrequestsubstate("javelin@stationary");
    self waittill(#"hash_91162229");
    level notify(#"hash_380ae1f4", enemy);
    current_weapon = self seatgetweapon(0);
    weapon = getweapon("siegebot_javelin_turret");
    self thread function_c73f719e(weapon);
    self setvehweapon(weapon);
    self thread vehicle_ai::javelin_losetargetatrighttime(enemy);
    self fireweapon(0, enemy);
    self vehicle_ai::waittill_asm_complete("javelin@stationary", 3);
    self setvehweapon(current_weapon);
    shootpos = self.origin + forward * 500;
    self setturrettargetvec(shootpos);
    self util::waittill_any_timeout(2, "turret_on_target");
    self clearturrettarget();
    if (isdefined(enemy) && !self function_4246bc05(enemy)) {
        forward = anglestoforward(self.angles);
        aimpos = self.origin + forward * 1000;
        self setturrettargetvec(aimpos);
        msg = self util::waittill_any_timeout(3, "turret_on_target");
        self clearturrettarget();
    }
    self function_59d0ca33();
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0x6085d1ab, Offset: 0x5b10
// Size: 0xdd
function function_c73f719e(projectile) {
    self endon(#"entityshutdown");
    self endon(#"death");
    projectile = self waittill(#"weapon_fired");
    distance = 1400;
    alias = "prj_javelin_incoming";
    wait 3;
    if (!isdefined(projectile)) {
        return;
    }
    while (isdefined(projectile) && isdefined(projectile.origin)) {
        if (isdefined(self.enemy) && isdefined(self.enemy.origin)) {
            var_24d263dd = distancesquared(projectile.origin, self.enemy.origin);
            if (var_24d263dd <= distance * distance) {
                projectile playsound(alias);
                return;
            }
        }
        wait 0.05;
    }
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0xce3c9382, Offset: 0x5bf8
// Size: 0x102
function function_fac6ca3e() {
    count = 6;
    if (!isdefined(self.var_b66afa28) || self.var_b66afa28.size < 1) {
        self.var_b66afa28 = [];
        for (i = 0; i < count; i++) {
            var_ea34311d = spawn("script_origin", self.origin);
            if (!isdefined(self.var_b66afa28)) {
                self.var_b66afa28 = [];
            } else if (!isarray(self.var_b66afa28)) {
                self.var_b66afa28 = array(self.var_b66afa28);
            }
            self.var_b66afa28[self.var_b66afa28.size] = var_ea34311d;
        }
    }
    if (!isdefined(self.var_fa144784)) {
        self.var_fa144784 = spawn("script_origin", self.origin);
    }
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0xb2ff8f51, Offset: 0x5d08
// Size: 0x8a
function function_d9cdf83c() {
    trace = bullettrace(self.origin, self.origin + (0, 0, -800), 0, self);
    if (trace["fraction"] < 1) {
        self.origin = trace["position"] + (0, 0, -20);
        return;
    }
    self.origin = self.origin + (0, 0, -500);
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0xe34b9ef1, Offset: 0x5da0
// Size: 0x14b
function function_ab984a0f() {
    self endon(#"death");
    wait 0.1;
    var_c07ddbf5 = array::randomize(self.var_b66afa28);
    foreach (target in var_c07ddbf5) {
        target function_d9cdf83c();
        wait randomfloatrange(0.05, 0.1);
    }
    if (false) {
        foreach (var_41ae2fa1 in var_c07ddbf5) {
            /#
                debugstar(var_41ae2fa1.origin, -56, (1, 0, 0));
            #/
            /#
                circle(var_41ae2fa1.origin, -106, (1, 0, 0), 0, 1, -56);
            #/
        }
    }
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0xe508587b, Offset: 0x5ef8
// Size: 0x7a
function function_a22c73c2(target) {
    score = 1;
    if (target isnotarget()) {
        score = 0.2;
    } else if (!target.allowdeath) {
        score = 0.4;
    } else if (isairborne(target)) {
        score = 0.2;
    }
    return score;
}

// Namespace siegebot_theia
// Params 3, eflags: 0x0
// Checksum 0x744147ad, Offset: 0x5f80
// Size: 0xcf
function function_ad4f5bb6(target, var_afd2f52a, radius) {
    var_1e946c1e = function_a22c73c2(target);
    foreach (var_707231aa in var_afd2f52a) {
        closeenough = distance2dsquared(target.origin, var_707231aa.origin) < radius * radius;
        if (closeenough) {
            var_1e946c1e += function_a22c73c2(var_707231aa);
        }
    }
    return var_1e946c1e;
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0xe9e7de45, Offset: 0x6058
// Size: 0x442
function function_6909a1a4() {
    var_bef46db0 = 600;
    var_5eead8e6 = 40;
    function_fac6ca3e();
    forward = anglestoforward(self.angles);
    self setturrettargetvec(self.origin + forward * 1000);
    self util::waittill_any_timeout(2, "turret_on_target");
    forward = anglestoforward(self.angles);
    targets = getaiteamarray("allies");
    targets = arraycombine(targets, level.players, 0, 0);
    var_702668a9 = 0;
    besttarget = undefined;
    foreach (target in targets) {
        if (target isnotarget() || isairborne(target)) {
            continue;
        }
        var_de3e8c8c = distance2dsquared(target.origin, self.origin);
        if (var_de3e8c8c < 500 * 500 || var_de3e8c8c > 2100 * 2100) {
            continue;
        }
        dirtotarget = ((target.origin - self.origin)[0], (target.origin - self.origin)[1], 0);
        if (vectordot(dirtotarget, forward) < 0.1) {
            continue;
        }
        var_1e946c1e = function_ad4f5bb6(target, targets, var_bef46db0);
        if (var_702668a9 <= var_1e946c1e) {
            var_702668a9 = var_1e946c1e;
            besttarget = target;
        }
    }
    if (!isdefined(besttarget)) {
        besttarget = array::random(generatepointsaroundcenter(self.arena_center, 2000, -56));
    } else {
        besttarget = besttarget.origin;
    }
    if (false) {
        /#
            debugstar(besttarget, -56, (1, 0, 0));
        #/
        /#
            circle(besttarget, var_bef46db0, (1, 0, 0), 0, 1, -56);
        #/
    }
    level notify(#"hash_879719b9", besttarget);
    targetorigin = (besttarget[0], besttarget[1], 0) + (0, 0, self.origin[2]);
    targetpoints = generatepointsaroundcenter(targetorigin, 1200, 120);
    var_e4ca448a = 0;
    for (i = 0; i < self.var_b66afa28.size && i < targetpoints.size; i++) {
        var_41ae2fa1 = self.var_b66afa28[i];
        var_41ae2fa1.origin = targetpoints[i];
        var_e4ca448a++;
    }
    self asmrequestsubstate("arm_rocket@stationary");
    self waittill(#"hash_e5fb1439");
    for (i = 0; i < var_e4ca448a; i++) {
        var_41ae2fa1 = self.var_b66afa28[i];
        self function_9af49228(var_41ae2fa1, (0, 0, 0), 1);
        self fireweapon(2);
        wait 0.05;
    }
    self thread function_ab984a0f();
    self function_bb5f9faa(1);
    self clearturrettarget();
    self vehicle_ai::waittill_asm_complete("arm_rocket@stationary", 3);
    self function_59d0ca33();
}

// Namespace siegebot_theia
// Params 3, eflags: 0x0
// Checksum 0x2aadd339, Offset: 0x64a8
// Size: 0x17a
function function_ea4bbd0d(point, enemy, var_5e1bf73c) {
    offset = (0, 0, 10);
    self.var_fa144784 unlink();
    if (distancesquared(self.var_fa144784.origin, enemy.origin) > 20 * 20) {
        self.var_fa144784.origin = point;
        self vehicle_ai::setturrettarget(self.var_fa144784, 1);
        self util::waittill_any_timeout(2, "turret_on_target");
        timestart = gettime();
        while (gettime() < timestart + var_5e1bf73c * 1000) {
            self.var_fa144784.origin = lerpvector(point, enemy.origin + offset, (gettime() - timestart) / var_5e1bf73c * 1000);
            if (false) {
                /#
                    debugstar(self.var_fa144784.origin, 100, (0, 1, 0));
                #/
            }
            wait 0.05;
        }
    }
    self.var_fa144784.origin = enemy.origin + offset;
    wait 0.05;
    self.var_fa144784 linkto(enemy);
}

// Namespace siegebot_theia
// Params 1, eflags: 0x0
// Checksum 0x87316059, Offset: 0x6630
// Size: 0xb1
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

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0x16a4af9, Offset: 0x66f0
// Size: 0x138
function get_enemy() {
    if (isdefined(self.enemy) && is_valid_target(self.enemy)) {
        return self.enemy;
    }
    targets = getaiteamarray("allies");
    targets = arraycombine(targets, level.players, 0, 0);
    validtargets = [];
    foreach (target in targets) {
        if (is_valid_target(target)) {
            if (!isdefined(validtargets)) {
                validtargets = [];
            } else if (!isarray(validtargets)) {
                validtargets = array(validtargets);
            }
            validtargets[validtargets.size] = target;
        }
    }
    targets = array::merge_sort(validtargets, &function_9dfac374, self.origin);
    return targets[0];
}

// Namespace siegebot_theia
// Params 0, eflags: 0x0
// Checksum 0xc6d984f2, Offset: 0x6830
// Size: 0x39a
function function_42fa8354() {
    duration = 4;
    interval = 1;
    self.turretrotscale = 0.4;
    self clearturrettarget();
    self function_bb5f9faa(1);
    self function_d013f7fa((0, 0, 0), 0);
    self function_d013f7fa((0, 0, 0), 1);
    self asmrequestsubstate("sweep@gun");
    self waittill(#"hash_36724a8");
    self clientfield::set("sarah_minigun_spin", 1);
    self setturretspinning(1);
    self waittill(#"hash_1a94e1e");
    enemy = get_enemy();
    vectorfromenemy = vectornormalize(((self.origin - enemy.origin)[0], (self.origin - enemy.origin)[1], 0));
    position = enemy.origin + vectorfromenemy * 500;
    stoptime = gettime() + duration * 1000;
    self thread vehicle_ai::fire_for_time(duration * 2, 1);
    while (gettime() < stoptime) {
        enemy = get_enemy();
        var_26ff9f6d = self gettagorigin("tag_gunner_flash1");
        var_3771204c = enemy.origin + (0, 0, 30);
        trace = bullettrace(var_26ff9f6d, var_3771204c, 1, enemy);
        if (trace["fraction"] == 1) {
            self getperfectinfo(enemy, 1);
        } else if (!isplayer(enemy)) {
            self setpersonalthreatbias(enemy, -2000, 3);
        }
        if (!enemy.allowdeath && !isplayer(enemy)) {
            self setpersonalthreatbias(enemy, -900, 8);
        }
        self vehicle_ai::setturrettarget(enemy, 0);
        if (isplayer(enemy)) {
            vectorfromenemy = vectornormalize(((self.origin - enemy.origin)[0], (self.origin - enemy.origin)[1], 0));
            self function_ea4bbd0d(enemy.origin + vectorfromenemy * 500, enemy, 0.7);
        } else {
            self vehicle_ai::setturrettarget(enemy, 1);
        }
        self util::waittill_any_timeout(interval, "enemy");
    }
    self setturretspinning(0);
    self notify(#"fire_stop");
    self function_59d0ca33();
    self waittill(#"hash_27c60d8b");
    self clientfield::set("sarah_minigun_spin", 0);
    self.turretrotscale = 1;
    wait 0.2;
}

