#using scripts/mp/killstreaks/_killstreak_bundles;
#using scripts/mp/killstreaks/_killstreaks;
#using scripts/shared/laststand_shared;
#using scripts/shared/callbacks_shared;
#using scripts/mp/vehicles/_siegebot;
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

#namespace namespace_a28cc5ab;

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x2
// namespace_a28cc5ab<file_0>::function_2dc19561
// Checksum 0xe64c428f, Offset: 0x670
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("siegebot_theia", &__init__, undefined, undefined);
}

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_8c87d8eb
// Checksum 0xf02c09f3, Offset: 0x6b0
// Size: 0x8c
function __init__() {
    vehicle::add_main_callback("siegebot_theia", &function_fcf49d56);
    clientfield::register("vehicle", "sarah_rumble_on_landing", 1, 1, "counter");
    clientfield::register("vehicle", "sarah_minigun_spin", 1, 1, "int");
}

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_fcf49d56
// Checksum 0x7fe42769, Offset: 0x748
// Size: 0x35c
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
    if (!sessionmodeismultiplayergame()) {
        self function_5a6e3cac();
    }
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
    killstreak_bundles::register_killstreak_bundle("siegebot_theia");
    self.maxhealth = killstreak_bundles::get_max_health("siegebot_theia");
    self.var_b1f078bb = self.maxhealth;
}

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_2ea898a8
// Checksum 0xc042d678, Offset: 0xab0
// Size: 0x9c
function init_clientfields() {
    self vehicle::lights_on();
    self vehicle::toggle_lights_group(1, 1);
    self vehicle::toggle_lights_group(2, 1);
    self vehicle::toggle_lights_group(3, 1);
    self clientfield::set("sarah_minigun_spin", 0);
}

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x0
// namespace_a28cc5ab<file_0>::function_b272dd98
// Checksum 0xf6ece250, Offset: 0xb58
// Size: 0x4b4
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

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_c18559a5
// Checksum 0xeee2e7f9, Offset: 0x1018
// Size: 0xfc
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

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_84e7c9e7
// Checksum 0xbab4823e, Offset: 0x1120
// Size: 0xf2
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

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_d56305c8
// Checksum 0xee9000fe, Offset: 0x1220
// Size: 0x18
function function_d56305c8(enabled) {
    self.var_72861401 = enabled;
}

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_c423e168
// Checksum 0x9dddb55, Offset: 0x1240
// Size: 0x42
function function_c423e168() {
    state = vehicle_ai::get_current_state();
    return isdefined(state) && state != "pain" && self.var_72861401;
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_5b4ac0fe
// Checksum 0xf2aa6147, Offset: 0x1290
// Size: 0x24
function function_5b4ac0fe(params) {
    self function_144b90e8();
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_a3bf4514
// Checksum 0x28ab4281, Offset: 0x12c0
// Size: 0x24
function function_a3bf4514(params) {
    self setbrake(0);
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_f71fc8b7
// Checksum 0xb96f4079, Offset: 0x12f0
// Size: 0x13c
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

// Namespace namespace_a28cc5ab
// Params 3, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_3a70e7d7
// Checksum 0x11ba8d6d, Offset: 0x1438
// Size: 0x56
function function_3a70e7d7(from_state, to_state, connection) {
    var_2a5d4f75 = self.healthdefault * 0.1;
    if (self.health < var_2a5d4f75) {
        return 99999999;
    }
    return 0;
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_975d9d5f
// Checksum 0x6627f5fa, Offset: 0x1498
// Size: 0x1f4
function function_975d9d5f(params) {
    self endon(#"death");
    self endon(#"change_state");
    vehicle_ai::cooldown("spike_on_ground", 2);
    self thread function_57c5370f();
    self thread function_76333d5f();
    function_59d0ca33();
    starttime = gettime();
    while (distance2dsquared(self.origin, self.var_d66ee1d2) > 1200 && vehicle_ai::timesince(starttime) < 8) {
        self setvehgoalpos(self.var_d66ee1d2, 0, 1);
        self setbrake(0);
        wait(1);
    }
    self cancelaimove();
    self clearvehgoalpos();
    self setbrake(1);
    self notify(#"end_attack_thread");
    self notify(#"end_movement_thread");
    self.jump.var_79dc9b21 = self.jump.var_6829bbf7[0];
    self function_54c6085f(params);
    self function_911f1aa5(params);
    self.var_12c7e390 = 1;
    self function_5151f00b(params);
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_7901b73e
// Checksum 0x6ac33a80, Offset: 0x1698
// Size: 0x4c
function function_7901b73e(params) {
    vehicle_ai::cooldown("jump", 22);
    vehicle_ai::cooldown("jumpUp", 33);
}

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_5a6e3cac
// Checksum 0x6d416bb5, Offset: 0x16f0
// Size: 0x354
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
    self.var_c8241452 = struct::get("arena_center").origin;
    self.var_d66ee1d2 = struct::get("death_goal_point").origin;
    self.var_e35f8efa = getent("theia_combat_region", "targetname");
    foreach (point in self.jump.var_6829bbf7) {
        if (distancesquared(point.origin, (-24566.2, 23972.5, -20000)) < 100 * 100) {
            point.origin += (20, -20, -100);
            continue;
        }
        if (distancesquared(point.origin, (-27291.2, 25825.6, -20072)) < 100 * 100) {
            point.origin += (0, 35, 0);
        }
    }
    assert(self.jump.var_6829bbf7.size > 0);
    assert(self.jump.groundpoints.size > 0);
    assert(isdefined(self.var_c8241452));
}

// Namespace namespace_a28cc5ab
// Params 3, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_d1c640f8
// Checksum 0xbebb8c61, Offset: 0x1a50
// Size: 0xc0
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

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_54c6085f
// Checksum 0x9c326b7d, Offset: 0x1b18
// Size: 0x1fc
function function_54c6085f(params) {
    goal = self.jump.var_79dc9b21.origin;
    trace = physicstrace(goal + (0, 0, 200), goal - (0, 0, 10000), (-10, -10, -10), (10, 10, 10), self, 2);
    if (false) {
        /#
            debugstar(goal, 60000, (0, 1, 0));
        #/
        /#
            debugstar(trace["pain"], 60000, (0, 1, 0));
        #/
        /#
            line(goal, trace["pain"], (0, 1, 0), 1, 0, 60000);
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

// Namespace namespace_a28cc5ab
// Params 3, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_a4f97767
// Checksum 0xf865765b, Offset: 0x1d20
// Size: 0xa0
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

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_b76c2c48
// Checksum 0x74b95fd5, Offset: 0x1dc8
// Size: 0x1f4
function function_b76c2c48(params) {
    goal = self.jump.var_44d87db5;
    trace = physicstrace(goal + (0, 0, 500), goal - (0, 0, 10000), (-10, -10, -10), (10, 10, 10), self, 2);
    if (false) {
        /#
            debugstar(goal, 60000, (0, 1, 0));
        #/
        /#
            debugstar(trace["pain"], 60000, (0, 1, 0));
        #/
        /#
            line(goal, trace["pain"], (0, 1, 0), 1, 0, 60000);
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

// Namespace namespace_a28cc5ab
// Params 3, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_d257637c
// Checksum 0x6b58f74c, Offset: 0x1fc8
// Size: 0x90
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

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_309fca92
// Checksum 0x6137176e, Offset: 0x2060
// Size: 0x24
function function_309fca92(params) {
    self function_d56305c8(1);
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_21ee6e62
// Checksum 0x263c14a9, Offset: 0x2090
// Size: 0x5c
function function_21ee6e62(params) {
    self function_d56305c8(1);
    self vehicle_ai::cooldown("jumpUp", 11 + randomfloatrange(-1, 3));
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_911f1aa5
// Checksum 0x2c870e74, Offset: 0x20f8
// Size: 0xd14
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
        wait(0.05);
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
    wait(0.3);
    self unlink();
    wait(0.05);
    self.jump.var_425f84b1 = 0;
    self notify(#"hash_48269e0e");
    vehicle_ai::cooldown("jump", 11);
    vehicle_ai::cooldown("ignore_player", 12);
    self vehicle_ai::waittill_asm_complete(params.var_fb532e19, 3);
    self vehicle_ai::evaluate_connections();
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_dbe3c90a
// Checksum 0x13d8a433, Offset: 0x2e18
// Size: 0xbc
function function_dbe3c90a(params) {
    self vehicle_ai::clearalllookingandtargeting();
    self function_d013f7fa((0, 0, 0), 0);
    self function_d013f7fa((0, 0, 0), 1);
    self function_d013f7fa((0, 0, 0), 2);
    self function_d013f7fa((0, 0, 0), 3);
    self function_d013f7fa((0, 0, 0), 4);
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_5151f00b
// Checksum 0x412db5d2, Offset: 0x2ee0
// Size: 0x2e8
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
            wait(1);
        }
        self face_target(self.origin + forward * 10000);
        var_35e1c37a = self.damagelevel * 0.15;
        if (randomfloat(1) < var_35e1c37a) {
            function_5e2157f5();
            level notify(#"hash_38559d8c");
            self vehicle_ai::evaluate_connections();
            wait(0.8);
        }
        function_6909a1a4();
        level notify(#"hash_38559d8c");
        self vehicle_ai::evaluate_connections();
        if (randomfloat(1) > 0.4 && self.var_12c7e390 !== 1) {
            wait(0.2);
            self function_e5af3b61();
        }
        wait(0.8);
        function_42fa8354();
        level notify(#"hash_38559d8c");
        self vehicle_ai::evaluate_connections();
        wait(0.8);
    }
}

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_e5af3b61
// Checksum 0x6aa6a686, Offset: 0x31d0
// Size: 0x2f4
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

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_3344e4e8
// Checksum 0x5d489f12, Offset: 0x34d0
// Size: 0xbc
function function_3344e4e8(params) {
    self vehicle_ai::clearalllookingandtargeting();
    self function_d013f7fa((0, 0, 0), 0);
    self function_d013f7fa((0, 0, 0), 1);
    self function_d013f7fa((0, 0, 0), 2);
    self function_d013f7fa((0, 0, 0), 3);
    self function_d013f7fa((0, 0, 0), 4);
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_c05314da
// Checksum 0xc55166ba, Offset: 0x3598
// Size: 0xfe
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
        wait(1);
    }
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_a812ea81
// Checksum 0xd03dd5a6, Offset: 0x36a0
// Size: 0x1fa
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

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_6f90eaa6
// Checksum 0xa301812b, Offset: 0x38a8
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

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_7080094f
// Checksum 0x3aae550a, Offset: 0x3918
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

// Namespace namespace_a28cc5ab
// Params 4, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_44598626
// Checksum 0x929fa4ef, Offset: 0x3988
// Size: 0x346
function function_44598626(var_4ff43c77, var_34ff10c9, pointsarray, idealdist) {
    /#
        record3dtext("pain" + var_4ff43c77 + "pain" + var_34ff10c9 + "pain", self.origin, (1, 0.5, 0), "pain", self);
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
                record3dtext("pain" + distancetotarget, point.origin, (1, 0.5, 0), "pain", self);
            #/
            continue;
        }
        score = abs(distancetotarget - idealdist);
        if (score < -56) {
            score = randomfloat(-56);
        }
        if (isdefined(self.jump.var_79dc9b21) && distance2dsquared(point.origin, self.jump.var_79dc9b21) < 50 * 50) {
            score += 1000;
        }
        /#
            recordstar(point.origin, (1, 0.5, 0));
        #/
        /#
            record3dtext("pain" + distancetotarget + "pain" + score, point.origin, (1, 0.5, 0), "pain", self);
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

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_3b3e7a3d
// Checksum 0x4e1b650c, Offset: 0x3cd8
// Size: 0x54
function function_3b3e7a3d(params) {
    self notify(#"end_attack_thread");
    self notify(#"end_movement_thread");
    self clearturrettarget();
    self setturretspinning(0);
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_ea8eac3c
// Checksum 0xefb756ba, Offset: 0x3d38
// Size: 0x76
function function_ea8eac3c(player) {
    if (isplayer(player)) {
        if (player.usingvehicle && isdefined(player.viewlockedentity) && isvehicle(player.viewlockedentity)) {
            return player.viewlockedentity;
        }
    }
    return undefined;
}

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x0
// namespace_a28cc5ab<file_0>::function_a9cc4c74
// Checksum 0xd5a6d768, Offset: 0x3db8
// Size: 0x144
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

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_9ce79c2c
// Checksum 0x44418681, Offset: 0x3f08
// Size: 0x10c
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

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_a849d3e8
// Checksum 0xddc9b7fb, Offset: 0x4020
// Size: 0xea
function function_a849d3e8() {
    callback::on_spawned(&function_9ce79c2c, self);
    callback::on_player_killed(&function_9ce79c2c, self);
    callback::on_laststand(&function_9ce79c2c, self);
    foreach (player in level.players) {
        self function_9ce79c2c(player);
    }
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_cdc7d6d5
// Checksum 0x6fe7bd61, Offset: 0x4118
// Size: 0x188
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

// Namespace namespace_a28cc5ab
// Params 2, eflags: 0x0
// namespace_a28cc5ab<file_0>::function_ffea59d7
// Checksum 0xb902752c, Offset: 0x42a8
// Size: 0x6c
function function_ffea59d7(player, damage) {
    index = player getentitynumber();
    self.var_236a6361[index].damage = self.var_236a6361[index].damage + damage;
}

// Namespace namespace_a28cc5ab
// Params 3, eflags: 0x0
// namespace_a28cc5ab<file_0>::function_b95b6735
// Checksum 0xcb51b727, Offset: 0x4320
// Size: 0xd4
function function_b95b6735(player, boost, timeseconds) {
    index = player getentitynumber();
    if (self.var_236a6361[index].var_5b4cf339 <= gettime()) {
        self.var_236a6361[index].var_b0ca0dd0 = 0;
    }
    self.var_236a6361[index].var_b0ca0dd0 = self.var_236a6361[index].var_b0ca0dd0 + boost;
    self.var_236a6361[index].var_5b4cf339 = gettime() + timeseconds * 1000;
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_765debac
// Checksum 0x2eb00ec5, Offset: 0x4400
// Size: 0x230
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

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_8ddb2a2e
// Checksum 0xb0f8f895, Offset: 0x4638
// Size: 0xe6
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

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_50256641
// Checksum 0xf2d40e4e, Offset: 0x4728
// Size: 0x94
function function_50256641(target) {
    if (!isdefined(target)) {
        self function_d013f7fa((0, 0, 0), 3);
        self function_d013f7fa((0, 0, 0), 4);
        return;
    }
    self vehicle_ai::setturrettarget(target, 3);
    self vehicle_ai::setturrettarget(target, 4);
}

// Namespace namespace_a28cc5ab
// Params 3, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_347f88f3
// Checksum 0xcf018020, Offset: 0x47c8
// Size: 0xc0
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
            wait(0.05);
        }
    }
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_30ecb08
// Checksum 0xaebd4631, Offset: 0x4890
// Size: 0x96
function function_30ecb08(delay) {
    self endon(#"death");
    wait(delay);
    for (i = 0; i < 3 && i < self.var_b66afa28.size; i++) {
        var_41ae2fa1 = self.var_b66afa28[i];
        var_41ae2fa1 function_d9cdf83c();
        wait(0.15);
    }
}

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_57c5370f
// Checksum 0x80ba572b, Offset: 0x4930
// Size: 0x3c0
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
            wait(0.4);
            continue;
        }
        if (!enemy.allowdeath && !isplayer(enemy)) {
            self setpersonalthreatbias(enemy, -2000, 8);
            wait(0.4);
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
            wait(0.4);
        }
        if (!isdefined(enemy)) {
            self setturretspinning(0);
            continue;
        }
        var_2c0fecbc = gettime();
        while (isdefined(enemy) && enemy === self.enemy && self function_6d424c6f(enemy, 1) && vehicle_ai::timesince(var_2c0fecbc) < 5) {
            self vehicle_ai::fire_for_time(1 + randomfloat(0.4), 1);
            if (isdefined(enemy) && isplayer(enemy)) {
                wait(0.6 + randomfloat(0.2));
            }
            wait(0.1);
        }
        self setturretspinning(0);
        wait(0.1);
    }
}

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_76333d5f
// Checksum 0x9debfe80, Offset: 0x4cf8
// Size: 0x7fc
function function_76333d5f() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"end_attack_thread");
    self notify(#"hash_b0c6a8c1");
    self endon(#"hash_b0c6a8c1");
    while (true) {
        enemy = self.enemy;
        if (!isdefined(enemy)) {
            wait(0.4);
            continue;
        }
        if (vehicle_ai::iscooldownready("spike_on_ground", 2) && self.var_5c05fe94 !== 1) {
            self function_7e56865f(1);
        }
        if (!vehicle_ai::iscooldownready("spike_on_ground")) {
            wait(0.4);
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
                wait(0.4);
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
                wait(0.1);
            }
            wait(0.5);
            self function_d013f7fa((0, 0, 0), 2);
            self function_7e56865f(0);
            continue;
        }
        wait(0.4);
    }
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_7e56865f
// Checksum 0x571a24a9, Offset: 0x5500
// Size: 0x2c
function function_7e56865f(is_aiming) {
    self.var_5c05fe94 = is_aiming;
    self function_59d0ca33();
}

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_59d0ca33
// Checksum 0x67407689, Offset: 0x5538
// Size: 0x54
function function_59d0ca33() {
    if (self.var_5c05fe94 === 1) {
        locomotion = "locomotion@movement";
    } else {
        locomotion = "locomotion_rocketup@movement";
    }
    self asmrequestsubstate(locomotion);
}

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_13a5941d
// Checksum 0x299ccad7, Offset: 0x5598
// Size: 0x1b0
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

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_53492b89
// Checksum 0x46579eb8, Offset: 0x5750
// Size: 0x2e8
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
            wait(0.05);
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
        wait(0.05);
    }
}

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_4891e8b4
// Checksum 0x5f1205e5, Offset: 0x5a40
// Size: 0xb4
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
        wait(0.8);
    }
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_cbe64bb2
// Checksum 0x66e0bcc0, Offset: 0x5b00
// Size: 0x6c6
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
                point._scoredebug["pain"] = -700;
            #/
            point.score += -700;
        }
        if (isdefined(enemy)) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["pain"] = point.distawayfromengagementarea * -1;
            #/
            point.score += point.distawayfromengagementarea * -1;
            if (!point.visibility) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["pain"] = -600;
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
                point._scoredebug["pain"] = 600;
            #/
            point.score += 600;
            continue;
        }
        if (factor > 0) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["pain"] = 0;
            #/
            point.score += 0;
            continue;
        }
        if (factor > -0.5) {
            /#
                if (!isdefined(point._scoredebug)) {
                    point._scoredebug = [];
                }
                point._scoredebug["pain"] = -600;
            #/
            point.score += -600;
            continue;
        }
        /#
            if (!isdefined(point._scoredebug)) {
                point._scoredebug = [];
            }
            point._scoredebug["pain"] = -1200;
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

// Namespace namespace_a28cc5ab
// Params 3, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_9dfac374
// Checksum 0x43de2bcf, Offset: 0x61d0
// Size: 0x82
function function_9dfac374(left, right, point) {
    var_c8c31226 = distance2dsquared(left.origin, point);
    var_d69cdbbd = distance2dsquared(right.origin, point);
    return var_c8c31226 > var_d69cdbbd;
}

// Namespace namespace_a28cc5ab
// Params 2, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_feedbcc3
// Checksum 0x7d076f1b, Offset: 0x6260
// Size: 0xcc
function function_feedbcc3(point, mindistance) {
    foreach (var_a1b61a44 in self.jump.var_6829bbf7) {
        if (distance2dsquared(point, var_a1b61a44.origin) < mindistance * mindistance) {
            return true;
        }
    }
    return false;
}

// Namespace namespace_a28cc5ab
// Params 6, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_c323eed7
// Checksum 0xd1e51f8, Offset: 0x6338
// Size: 0x8e6
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
        record3dtext("pain", self.origin, (1, 0.5, 0), "pain", self);
    #/
    foreach (target in targets) {
        if (!is_valid_target(target) || !target.allowdeath || isairborne(target)) {
            continue;
        }
        if (distance2dsquared(self.var_c8241452, target.origin) > var_50e99cbf * var_50e99cbf) {
            /#
                recordstar(target.origin, (0, 0.5, 1));
            #/
            /#
                record3dtext("pain" + distance2d(self.var_c8241452, target.origin), target.origin, (0, 0.5, 1), "pain", self);
            #/
            continue;
        }
        if (function_feedbcc3(target.origin, var_1e5d41a4)) {
            /#
                recordstar(target.origin, (0, 0.5, 1));
            #/
            /#
                record3dtext("pain", target.origin, (0, 0.5, 1), "pain", self);
            #/
            continue;
        }
        distancetotarget = distance2d(target.origin, self.origin);
        if (distancetotarget < var_4ff43c77 || var_34ff10c9 < distancetotarget) {
            /#
                recordstar(target.origin, (1, 0.5, 0));
            #/
            /#
                record3dtext("pain" + distancetotarget, target.origin, (1, 0.5, 0), "pain", self);
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
            record3dtext("pain" + distancetotarget + "pain" + score, target.origin, (1, 0.5, 0), "pain", self);
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
    queryresult = positionquery_source_navigation(self.var_c8241452, 100, 1300, 500, self.radius, self.radius * 1.1);
    assert(queryresult.data.size > 0);
    var_6ab55afd = array::randomize(queryresult.data);
    foreach (point in var_6ab55afd) {
        var_edf6415e = distance2dsquared(point.origin, self.origin);
        if (var_4ff43c77 * var_4ff43c77 < var_edf6415e && var_edf6415e < var_34ff10c9 * var_34ff10c9 && !function_feedbcc3(point.origin, var_1e5d41a4)) {
            return point.origin;
        }
    }
    return self.var_c8241452;
}

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_144b90e8
// Checksum 0x522f1823, Offset: 0x6c28
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

// Namespace namespace_a28cc5ab
// Params 2, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_5127887a
// Checksum 0xc48a11b8, Offset: 0x6cc8
// Size: 0x244
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
        wait(0.05);
    }
    self clearvehgoalpos();
    self clearlookatent();
    self clearturrettarget();
    self cancelaimove();
}

// Namespace namespace_a28cc5ab
// Params 14, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_93219dbe
// Checksum 0x260e6158, Offset: 0x6f18
// Size: 0x1e8
function function_93219dbe(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (!isplayer(eattacker)) {
        idamage = 0;
        return idamage;
    }
    idamage = self killstreaks::ondamageperweapon("siegebot_theia", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, 0, undefined, 1, 1);
    if (idamage == 0) {
        return 0;
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
    return idamage;
}

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_5e2157f5
// Checksum 0x40118291, Offset: 0x7108
// Size: 0x30c
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

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_c73f719e
// Checksum 0x81e15c6e, Offset: 0x7420
// Size: 0x124
function function_c73f719e(projectile) {
    self endon(#"entityshutdown");
    self endon(#"death");
    projectile = self waittill(#"weapon_fired");
    distance = 1400;
    alias = "prj_javelin_incoming";
    wait(3);
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
        wait(0.05);
    }
}

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_fac6ca3e
// Checksum 0x602f4710, Offset: 0x7550
// Size: 0x13c
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

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_d9cdf83c
// Checksum 0xfcdbccb1, Offset: 0x7698
// Size: 0xa8
function function_d9cdf83c() {
    trace = bullettrace(self.origin, self.origin + (0, 0, -800), 0, self);
    if (trace["fraction"] < 1) {
        self.origin = trace["position"] + (0, 0, -20);
        return;
    }
    self.origin += (0, 0, -500);
}

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_ab984a0f
// Checksum 0x1b841b2, Offset: 0x7748
// Size: 0x1ba
function function_ab984a0f() {
    self endon(#"death");
    wait(0.1);
    var_c07ddbf5 = array::randomize(self.var_b66afa28);
    foreach (target in var_c07ddbf5) {
        target function_d9cdf83c();
        wait(randomfloatrange(0.05, 0.1));
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

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_a22c73c2
// Checksum 0xd3be44e4, Offset: 0x7910
// Size: 0x98
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

// Namespace namespace_a28cc5ab
// Params 3, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_ad4f5bb6
// Checksum 0x5015b85d, Offset: 0x79b0
// Size: 0x11c
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

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_6909a1a4
// Checksum 0x68a330af, Offset: 0x7ad8
// Size: 0x5cc
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
        besttarget = array::random(generatepointsaroundcenter(self.var_c8241452, 2000, -56));
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
        wait(0.05);
    }
    self thread function_ab984a0f();
    self function_bb5f9faa(1);
    self clearturrettarget();
    self vehicle_ai::waittill_asm_complete("arm_rocket@stationary", 3);
    self function_59d0ca33();
}

// Namespace namespace_a28cc5ab
// Params 3, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_ea4bbd0d
// Checksum 0x137136d8, Offset: 0x80b0
// Size: 0x1e4
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
            wait(0.05);
        }
    }
    self.var_fa144784.origin = enemy.origin + offset;
    wait(0.05);
    self.var_fa144784 linkto(enemy);
}

// Namespace namespace_a28cc5ab
// Params 1, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_139e3a4a
// Checksum 0x7aada0a0, Offset: 0x82a0
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

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_367fdf4a
// Checksum 0xe14860e4, Offset: 0x8380
// Size: 0x1b0
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

// Namespace namespace_a28cc5ab
// Params 0, eflags: 0x1 linked
// namespace_a28cc5ab<file_0>::function_42fa8354
// Checksum 0x8338f27, Offset: 0x8538
// Size: 0x4cc
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
    wait(0.2);
}

