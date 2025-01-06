#using scripts/codescripts/struct;
#using scripts/cp/_objectives;
#using scripts/cp/_oed;
#using scripts/cp/gametypes/_globallogic_ui;
#using scripts/shared/ai/blackboard_vehicle;
#using scripts/shared/ai/systems/blackboard;
#using scripts/shared/clientfield_shared;
#using scripts/shared/damagefeedback_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/gameskill_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/statemachine_shared;
#using scripts/shared/system_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_death_shared;
#using scripts/shared/vehicle_shared;

#using_animtree("generic");

#namespace quadtank;

// Namespace quadtank
// Params 0, eflags: 0x2
// Checksum 0x3bb21369, Offset: 0x8e0
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("quadtank", &__init__, undefined, undefined);
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0x58dd96e9, Offset: 0x920
// Size: 0x8c
function __init__() {
    vehicle::add_main_callback("quadtank", &function_58d90469);
    clientfield::register("toplayer", "player_shock_fx", 1, 1, "int");
    clientfield::register("vehicle", "quadtank_trophy_state", 1, 1, "int");
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0x24b7e787, Offset: 0x9b8
// Size: 0x3dc
function function_58d90469() {
    self useanimtree(#generic);
    self enableaimassist();
    self setneargoalnotifydist(50);
    blackboard::createblackboardforentity(self);
    self blackboard::registervehicleblackboardattributes();
    self.var_f5d48615 = 1;
    self.fovcosine = 0;
    self.fovcosinebusy = 0;
    self.maxsightdistsqrd = 10000 * 10000;
    self.var_a670ac2a = 0;
    self.var_4e5b312b = 1;
    self.var_9d0e9d5e = 0;
    self.var_31e90786 = 0;
    self.var_de9eba31 = 0;
    self.allow_movement = 1;
    assert(isdefined(self.scriptbundlesettings));
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    objectives::set("cp_quadtank_rocket_icon", self);
    objectives::function_66c6f97b("cp_quadtank_rocket_icon", self);
    self.variant = "cannon";
    if (issubstr(self.vehicletype, "mlrs")) {
        self.variant = "rocketpod";
    }
    self.goalradius = 9999999;
    self.goalheight = 512;
    self setgoal(self.origin, 0, self.goalradius, self.goalheight);
    self setspeed(self.settings.defaultmovespeed, 10, 10);
    self setmindesiredturnyaw(45);
    self function_6daea2f7(0);
    turret::_init_turret(1);
    turret::_init_turret(2);
    turret::function_1c6038d9(&function_1870af4, 1);
    turret::function_1c6038d9(&function_1870af4, 2);
    self function_28a3b4bc();
    self function_acb4f83c();
    self.overridevehicledamage = &function_efc2d52f;
    if (isdefined(level.vehicle_initializer_cb)) {
        [[ level.vehicle_initializer_cb ]](self);
    }
    self.var_375cf54a = 1;
    self.var_3a087745 = 1;
    self vehicle_ai::function_a767f9b4();
    self.disableelectrodamage = 1;
    self.disableburndamage = 1;
    self thread vehicle_ai::target_hijackers();
    self hidepart("tag_defense_active");
    defaultrole();
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0x515ea16, Offset: 0xda0
// Size: 0x13c
function function_28a3b4bc() {
    if (isdefined(level.players)) {
        value = level.players.size;
    } else {
        value = 1;
    }
    var_7b6ddca7 = mapfloat(1, 4, 1, 1.5, value);
    var_fc916d4 = mapfloat(1, 4, 1, 0.75, value);
    turret::set_burst_parameters(1.5, 2.5 * var_7b6ddca7, 0.25 * var_fc916d4, 0.75 * var_fc916d4, 1);
    turret::set_burst_parameters(1.5, 2.5 * var_7b6ddca7, 0.25 * var_fc916d4, 0.75 * var_fc916d4, 2);
    self.var_cf0b2b03 = var_7b6ddca7;
    self.var_e8674008 = var_fc916d4;
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0xa7ea5204, Offset: 0xee8
// Size: 0x20c
function defaultrole() {
    self.state_machine = self vehicle_ai::init_state_machine_for_role("default");
    self vehicle_ai::get_state_callbacks("pain").update_func = &function_f71fc8b7;
    self vehicle_ai::get_state_callbacks("emped").update_func = &function_8ec0e22c;
    self vehicle_ai::get_state_callbacks("off").enter_func = &state_off_enter;
    self vehicle_ai::get_state_callbacks("off").exit_func = &state_off_exit;
    self vehicle_ai::get_state_callbacks("scripted").update_func = &state_scripted_update;
    self vehicle_ai::get_state_callbacks("driving").update_func = &state_driving_update;
    self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
    self vehicle_ai::get_state_callbacks("combat").exit_func = &state_combat_exit;
    self vehicle_ai::get_state_callbacks("death").update_func = &quadtank_death;
    self vehicle_ai::call_custom_add_state_callbacks();
    self vehicle_ai::startinitialstate();
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0xaf1a9dd7, Offset: 0x1100
// Size: 0x30
function function_a389866() {
    self vehicle_ai::set_state("off");
    self.var_4e5b312b = 0;
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0xc2bec379, Offset: 0x1138
// Size: 0x30
function function_fefa9078() {
    self vehicle_ai::set_state("combat");
    self.var_4e5b312b = 1;
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0xb0a2e301, Offset: 0x1170
// Size: 0x1e4
function state_off_enter(params) {
    self playsound("veh_quadtank_power_down");
    self laseroff();
    self cleartargetentity();
    self cancelaimove();
    self clearvehgoalpos();
    vehicle_ai::turnoffalllightsandlaser();
    vehicle_ai::turnoffallambientanims();
    self vehicle::toggle_tread_fx(0);
    self vehicle::toggle_sounds(0);
    self vehicle::toggle_exhaust_fx(0);
    angles = self gettagangles("tag_flash");
    target_vec = self.origin + anglestoforward((0, angles[1], 0)) * 1000;
    target_vec += (0, 0, -500);
    self function_63f13a8e(target_vec);
    self function_e672a8ad(0);
    self thread function_5d17667f();
    if (!isdefined(self.emped)) {
        self disableaimassist();
    }
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0xaece5e52, Offset: 0x1360
// Size: 0x9c
function state_off_exit(params) {
    self vehicle::lights_on();
    self vehicle::toggle_tread_fx(1);
    self vehicle::toggle_sounds(1);
    self thread function_4ebb4502();
    self vehicle::toggle_exhaust_fx(1);
    self enableaimassist();
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0x6bd57b2c, Offset: 0x1408
// Size: 0x128
function function_4ebb4502() {
    self endon(#"death");
    self playsound("veh_quadtank_power_up");
    self vehicle_ai::blink_lights_for_time(1.5);
    angles = self gettagangles("tag_flash");
    target_vec = self.origin + anglestoforward((0, angles[1], 0)) * 1000;
    self.turretrotscale = 0.3;
    driver = self getseatoccupant(0);
    if (!isdefined(driver)) {
        self function_63f13a8e(target_vec);
    }
    wait 1;
    self.turretrotscale = 1 * self.var_cf0b2b03;
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0x8403abf0, Offset: 0x1538
// Size: 0x1cc
function function_f71fc8b7(params) {
    self endon(#"change_state");
    self endon(#"death");
    var_da74c6a7 = params.var_6e0794d4[0];
    if (var_da74c6a7 === 1) {
        asmstate = "trophy_disabled@stationary";
    } else {
        asmstate = "pain@stationary";
    }
    self asmrequestsubstate(asmstate);
    playsoundatposition("prj_quad_impact", self.origin);
    self cancelaimove();
    self clearvehgoalpos();
    self clearturrettarget();
    self setbrake(1);
    self vehicle_ai::waittill_asm_complete(asmstate, 6);
    self setbrake(0);
    self asmrequestsubstate("locomotion@movement");
    driver = self getseatoccupant(0);
    if (!isdefined(driver)) {
        self vehicle_ai::set_state("combat");
        return;
    }
    self vehicle_ai::set_state("driving");
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0xbe84bad3, Offset: 0x1710
// Size: 0xbc
function state_scripted_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    self function_e672a8ad(0);
    self laseroff();
    self cleartargetentity();
    self cancelaimove();
    self clearvehgoalpos();
    self vehicle::toggle_ambient_anim_group(2, 1);
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0xd65fa606, Offset: 0x17d8
// Size: 0x1cc
function state_driving_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    self function_e672a8ad(0);
    self laseroff();
    self cleartargetentity();
    self cancelaimove();
    self clearvehgoalpos();
    self vehicle::toggle_ambient_anim_group(2, 1);
    objectives::function_66c6f97b("cp_quadtank_rocket_icon", self);
    driver = self getseatoccupant(0);
    if (isdefined(driver)) {
        self.turretrotscale = 1;
        self disableaimassist();
        self thread function_ced547f7(driver.team);
        self setbrake(0);
        self asmrequestsubstate("locomotion@movement");
        self thread function_644777c8();
        self thread function_bda33f7a();
        self.var_de9eba31 = 3;
        self thread function_5d17667f();
    }
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0x1b9d90c7, Offset: 0x19b0
// Size: 0x24
function function_86fe5c5e() {
    self setgoal(self.origin);
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0xd0489819, Offset: 0x19e0
// Size: 0x12e
function state_combat_update(params) {
    self endon(#"death");
    self endon(#"change_state");
    if (isalive(self)) {
    }
    if (isalive(self) && !function_fcd2c4ce()) {
        self thread function_ce00e5c0();
    }
    if (self.allow_movement) {
        self thread function_350cca63();
    } else {
        self setbrake(1);
    }
    switch (self.variant) {
    case "cannon":
        vehicle_ai::cooldown("main_cannon", 4);
        self thread function_9196ecf2();
        break;
    case "rocketpod":
        self thread function_76333d5f();
        break;
    }
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0xa900c375, Offset: 0x1b18
// Size: 0x54
function state_combat_exit(params) {
    self notify(#"end_attack_thread");
    self notify(#"end_movement_thread");
    self clearturrettarget();
    self clearlookatent();
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0x74c7bddc, Offset: 0x1b78
// Size: 0x28c
function quadtank_death(params) {
    self endon(#"death");
    self endon(#"nodeath_thread");
    self function_e9d5fa52(0);
    self function_4c6ee4cc(0);
    objectives::function_66c6f97b("cp_quadtank_rocket_icon", self);
    self function_dd8d3882();
    self hidepart("tag_lidar_null", "", 1);
    self vehicle::set_damage_fx_level(0);
    streamermodelhint(self.deathmodel, 6);
    if (!isdefined(self.var_1e2e82d9)) {
        playsoundatposition("prj_quad_impact", self.origin);
        self playsound("veh_quadtank_power_down");
        self playsound("veh_quadtank_sparks");
        self asmrequestsubstate("death@stationary");
        self waittill(#"hash_6efb9b88");
    } else {
        self [[ self.var_1e2e82d9 ]]();
    }
    if (isdefined(level.disable_thermal)) {
        [[ level.disable_thermal ]]();
    }
    if (isdefined(self.stun_fx)) {
        self.stun_fx delete();
    }
    badplace_box("", 0, self.origin, 90, "neutral");
    self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
    self vehicle_death::death_radius_damage();
    vehicle_ai::waittill_asm_complete("death@stationary", 5);
    self thread vehicle_death::cleanup();
    vehicle_death::freewhensafe();
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0x2a37805b, Offset: 0x1e10
// Size: 0x20c
function function_8ec0e22c(params) {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"emped");
    if (isdefined(self.emped)) {
        return;
    }
    self.emped = 1;
    playsoundatposition("veh_quadtankemp_down", self.origin);
    self.turretrotscale = 0.2;
    if (!isdefined(self.stun_fx)) {
        self.stun_fx = spawn("script_model", self.origin);
        self.stun_fx setmodel("tag_origin");
        self.stun_fx linkto(self, "tag_turret", (0, 0, 0), (0, 0, 0));
    }
    time = params.var_6e0794d4[0];
    assert(isdefined(time));
    vehicle_ai::cooldown("emped_timer", time);
    while (!vehicle_ai::iscooldownready("emped_timer")) {
        timeleft = max(vehicle_ai::getcooldownleft("emped_timer"), 0.5);
        wait timeleft;
    }
    self.stun_fx delete();
    self.emped = undefined;
    self playsound("veh_boot_quadtank");
    self vehicle_ai::evaluate_connections();
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0x240566e0, Offset: 0x2028
// Size: 0x36
function function_fcd2c4ce() {
    if (self.trophy_down === 1) {
        return true;
    }
    if (trophy_destroyed()) {
        return true;
    }
    return false;
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0x985fc96b, Offset: 0x2068
// Size: 0x1c
function trophy_destroyed() {
    if (self.var_de9eba31 >= 4) {
        return true;
    }
    return false;
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0xaa72dc4b, Offset: 0x2090
// Size: 0x2c
function function_e9d5fa52(ison) {
    self clientfield::set("quadtank_trophy_state", ison);
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0xf48fc13f, Offset: 0x20c8
// Size: 0x4a4
function function_5d17667f() {
    self endon(#"death");
    self notify(#"hash_505da6e2");
    self endon(#"hash_505da6e2");
    self notify(#"hash_1b5e6193");
    function_e9d5fa52(0);
    if (function_fcd2c4ce()) {
        return;
    }
    self.trophy_down = 1;
    driver = self getseatoccupant(0);
    if (!isdefined(driver) && self vehicle_ai::get_current_state() != "off" && self vehicle_ai::get_next_state() !== "off") {
        self notify(#"pain", 1);
    }
    target_set(self, (0, 0, 60));
    self hidepart("tag_defense_active");
    self.attackeraccuracy = 0.5;
    self.var_9d0e9d5e = 0;
    self.var_31e90786 = 0;
    self.var_de9eba31 += 1;
    self function_4c6ee4cc(0);
    self function_dd8d3882();
    driver = self getseatoccupant(0);
    if (!isdefined(driver) && self vehicle_ai::get_current_state() != "off" && self vehicle_ai::get_next_state() !== "off") {
        objectives::function_c0eaea6e("cp_quadtank_rocket_icon", self);
    } else {
        objectives::function_66c6f97b("cp_quadtank_rocket_icon", self);
    }
    self function_e672a8ad(0);
    if (isdefined(level.var_3be61296)) {
        [[ level.var_3be61296 ]](self, 0);
    }
    if (trophy_destroyed()) {
        self notify(#"trophy_system_destroyed");
        level notify(#"trophy_system_destroyed", self);
        self playsound("wpn_trophy_disable");
        playfxontag(self.settings.trophydetonationfx, self, "tag_target_lower");
        self hidepart("tag_lidar_null", "", 1);
        return;
    }
    self notify(#"trophy_system_disabled");
    level notify(#"trophy_system_disabled", self);
    self playsound("wpn_trophy_disable");
    self vehicle_ai::cooldown("trophy_down", self.settings.var_f5c1a5ef);
    while (!self vehicle_ai::iscooldownready("trophy_down") || self vehicle_ai::get_current_state() === "off") {
        if (self.var_9d0e9d5e >= self.settings.var_f99b9c5 || vehicle_ai::getcooldownleft("trophy_down") < 0.5 * self.settings.var_f5c1a5ef && self.var_31e90786 >= 5) {
            self vehicle_ai::clearcooldown("trophy_down");
        }
        wait 1;
    }
    driver = self getseatoccupant(0);
    if (isdefined(driver)) {
        self.var_de9eba31 = 4;
    }
    if (!trophy_destroyed()) {
        self thread function_ce00e5c0();
    }
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0xc2bd8fbf, Offset: 0x2578
// Size: 0x29a
function function_ce00e5c0() {
    self endon(#"death");
    self notify(#"hash_1b5e6193");
    self endon(#"hash_1b5e6193");
    function_e9d5fa52(1);
    time = isdefined(self.settings.var_5a624323) ? self.settings.var_5a624323 : 0.1;
    wait time;
    driver = self getseatoccupant(0);
    self.trophy_down = 0;
    self.attackeraccuracy = 1;
    self showpart("tag_defense_active");
    objectives::function_66c6f97b("cp_quadtank_rocket_icon", self);
    self function_a093b43b();
    self thread function_17b8332e();
    if (!isdefined(driver)) {
        self function_4c6ee4cc(1);
    } else {
        self function_4c6ee4cc(0);
    }
    if (target_istarget(self)) {
        target_remove(self);
    }
    if (!isdefined(driver)) {
        self function_e672a8ad(1);
    }
    self.var_ef5ed6ae = self.settings.var_fe71d83a;
    if (isdefined(level.players) && level.players.size > 0) {
        var_742707f2 = 0.75;
        if (level.players.size == 2) {
            var_742707f2 = 1;
        }
        if (level.players.size == 3) {
            var_742707f2 = 1.25;
        }
        if (level.players.size >= 4) {
            var_742707f2 = 1.5;
        }
        self.var_ef5ed6ae *= var_742707f2;
    }
    if (isdefined(level.var_3be61296)) {
        [[ level.var_3be61296 ]](self, 1);
    }
    self notify(#"hash_f015cdf7");
    level notify(#"hash_f015cdf7", self);
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0xe3312b7a, Offset: 0x2820
// Size: 0x68
function function_acb4f83c() {
    self function_d013f7fa((10, -90, 0), 1);
    self function_d013f7fa((10, 90, 0), 2);
    self.turretrotscale = 1 * self.var_cf0b2b03;
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0xb6b66a13, Offset: 0x2890
// Size: 0x2c0
function function_bcd490eb(var_dcf15942) {
    self endon(#"death");
    self endon(#"change_state");
    self.turretrotscale = 0.3;
    while (!isdefined(self.enemy) || var_dcf15942 || !self function_4246bc05(self.enemy)) {
        if (self.turretontarget && self.var_f5d48615 != 0) {
            self.var_f5d48615++;
            if (self.var_f5d48615 >= 5) {
                self.var_f5d48615 = 1;
            }
        }
        switch (self.var_f5d48615) {
        case 0:
            if (isdefined(self.enemy)) {
                self setlookatent(self.enemy);
                target_vec = self.enemy.origin + (0, 0, 40);
                self function_63f13a8e(target_vec);
                wait 1;
                self clearlookatent();
                self.var_f5d48615++;
            }
        case 1:
            target_vec = self.origin + anglestoforward((0, self.angles[1], 0)) * 1000;
            break;
        case 2:
            target_vec = self.origin + anglestoforward((0, self.angles[1] + 30, 0)) * 1000;
            break;
        case 3:
            target_vec = self.origin + anglestoforward((0, self.angles[1], 0)) * 1000;
            break;
        case 4:
            target_vec = self.origin + anglestoforward((0, self.angles[1] - 30, 0)) * 1000;
            break;
        }
        target_vec += (0, 0, 40);
        self function_63f13a8e(target_vec);
        wait 0.2;
    }
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0x499ab7cf, Offset: 0x2b58
// Size: 0x74
function function_e672a8ad(on) {
    if (on) {
        turret::enable(1, 0);
        turret::enable(2, 0);
        return;
    }
    turret::disable(1);
    turret::disable(2);
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0x908fa68, Offset: 0x2bd8
// Size: 0x44
function function_6daea2f7(show) {
    if (show) {
        self vehicle::toggle_exhaust_fx(1);
        return;
    }
    self vehicle::toggle_exhaust_fx(0);
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0xd37057ed, Offset: 0x2c28
// Size: 0x13c
function function_bb3e5dc7(target) {
    self endon(#"change_state");
    self playsound("veh_quadtank_cannon_charge");
    self waittill(#"weapon_fired", proj);
    self thread function_af1bc2b1(proj);
    if (isdefined(target) && isdefined(proj)) {
        vel = proj getvelocity();
        var_644fe094 = length(vel);
        dist = distance(proj.origin, target.origin) + randomfloatrange(0, 40);
        var_72f8d61b = dist / var_644fe094;
        proj resetmissiledetonationtime(var_72f8d61b);
    }
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0xc2115316, Offset: 0x2d70
// Size: 0x620
function function_9196ecf2() {
    self endon(#"death");
    self endon(#"change_state");
    var_65801466 = 0;
    self function_e672a8ad(1);
    self function_2ea2374c(10);
    self.var_872042b7 = undefined;
    while (true) {
        if (self.var_10c2e50a === 1 || !vehicle_ai::iscooldownready("main_cannon")) {
            if (isdefined(self.enemy) && self function_4246bc05(self.enemy)) {
                self setturrettargetent(self.enemy);
                self setlookatent(self.enemy);
            }
            wait 0.2;
            continue;
        }
        if (isdefined(self.enemy) && self function_4246bc05(self.enemy)) {
            self.turretrotscale = 1 * self.var_cf0b2b03;
            self setturrettargetent(self.enemy);
            self setlookatent(self.enemy);
            if (var_65801466 >= 2) {
                wait 0.1;
                self cancelaimove();
                self clearvehgoalpos();
                self notify(#"near_goal");
            }
            var_65801466 = 0;
            fired = 0;
            if (isdefined(self.enemy) && self function_4246bc05(self.enemy)) {
                if (distancesquared(self.origin, self.enemy.origin) > 72900 && self.turretontarget) {
                    var_23696bc8 = anglestoforward(self.angles);
                    v_to_enemy = self.enemy.origin - self.origin;
                    v_to_enemy = vectornormalize(v_to_enemy);
                    dot = vectordot(v_to_enemy, var_23696bc8);
                    if (dot > 0.707) {
                        self asmrequestsubstate("fire@stationary");
                        self setturrettargetent(self.enemy);
                        self thread function_bb3e5dc7(self.enemy);
                        if (isdefined(level.players) && level.players.size < 3) {
                            self function_e672a8ad(0);
                        }
                        self function_6daea2f7(1);
                        self.var_872042b7 = 1;
                        fired = 1;
                        self cancelaimove();
                        self clearvehgoalpos();
                        self notify(#"near_goal");
                        self.turretrotscale = 0.7;
                        wait 1;
                        level notify(#"hash_7d88204f");
                        self vehicle_ai::waittill_asm_complete("fire@stationary", 6);
                        self function_e672a8ad(1);
                        self.turretrotscale = 1;
                    }
                }
            }
            self.var_872042b7 = undefined;
            if (isdefined(self.enemy)) {
                self setturrettargetent(self.enemy);
                self setlookatent(self.enemy);
            }
            if (fired) {
                self function_6daea2f7(0);
                vehicle_ai::cooldown("main_cannon", randomfloatrange(5, 7.5));
            } else {
                wait 0.25;
            }
            continue;
        }
        var_65801466++;
        wait 0.5;
        if (var_65801466 > 40) {
            self function_bcd490eb(0);
            continue;
        }
        if (var_65801466 > 30) {
            self clearlookatent();
            self cleartargetentity();
            continue;
        }
        if (isdefined(self.enemy)) {
            self setturrettargetent(self.enemy);
            self clearlookatent();
            continue;
        }
        self clearlookatent();
        self function_bcd490eb(0);
    }
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0x79b1937f, Offset: 0x3398
// Size: 0x566
function function_76333d5f() {
    self endon(#"death");
    self endon(#"end_attack_thread");
    self vehicle::toggle_ambient_anim_group(2, 0);
    while (true) {
        var_447f1b87 = 0;
        if (isdefined(self.enemy)) {
            self setturrettargetent(self.enemy);
            self setlookatent(self.enemy);
        }
        if (isdefined(self.enemy) && vehicle_ai::iscooldownready("javelin_rocket_launcher", 0.5)) {
            if (isvehicle(self.enemy) || distance2dsquared(self.origin, self.enemy.origin) >= 800 * 800) {
                var_447f1b87 = !self function_6d424c6f(self.enemy, 3) || randomint(100) < 3;
            }
        }
        if (isdefined(self.enemy) && vehicle_ai::iscooldownready("rocket_launcher", 0.5)) {
            if (isdefined(level.players) && level.players.size < 3) {
                self function_e672a8ad(0);
            }
            self clearvehgoalpos();
            self notify(#"near_goal");
            self function_6daea2f7(1);
            self vehicle::toggle_ambient_anim_group(2, 1);
            if (!var_447f1b87) {
                self setvehweapon(getweapon("quadtank_main_turret_rocketpods_straight"));
                offset = (0, 0, -50);
                if (isplayer(self.enemy)) {
                    origin = self.enemy.origin;
                    eye = self.enemy geteye();
                    offset = (0, 0, origin[2] - eye[2] - 5);
                }
                vehicle_ai::setturrettarget(self.enemy, 0, offset);
            } else {
                self playsound("veh_quadtank_mlrs_plant_start");
                self setvehweapon(getweapon("quadtank_main_turret_rocketpods_javelin"));
                vehicle_ai::setturrettarget(self.enemy, 0, (0, 0, 300));
            }
            wait 1;
            msg = self util::waittill_any_timeout(2, "turret_on_target");
            if (isdefined(self.enemy) && distance2dsquared(self.origin, self.enemy.origin) > 350 * 350) {
                fired = 0;
                for (i = 0; i < 4 && isdefined(self.enemy); i++) {
                    if (var_447f1b87) {
                        if (isplayer(self.enemy)) {
                            self thread vehicle_ai::javelin_losetargetatrighttime(self.enemy);
                        }
                        self thread function_c73f719e(getweapon("quadtank_main_turret_rocketpods_javelin"));
                    }
                    self fireweapon(0, self.enemy);
                    fired = 1;
                    wait 0.8;
                }
                if (fired) {
                    vehicle_ai::cooldown("rocket_launcher", randomfloatrange(8, 10));
                    if (var_447f1b87) {
                        vehicle_ai::cooldown("javelin_rocket_launcher", 20);
                    }
                }
            }
            self function_e672a8ad(1);
            self vehicle::toggle_ambient_anim_group(2, 0);
        }
        wait 1;
    }
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0x7838d4dd, Offset: 0x3908
// Size: 0x54
function function_8334ee5f() {
    if (!isdefined(self.var_88858d28)) {
        self.var_88858d28 = 0;
    }
    self.var_88858d28 = !self.var_88858d28;
    self clientfield::set_to_player("player_shock_fx", self.var_88858d28);
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0xddfc8e6a, Offset: 0x3968
// Size: 0x190
function path_update_interrupt() {
    self endon(#"death");
    self endon(#"change_state");
    self endon(#"near_goal");
    self endon(#"reached_end_node");
    wait 1;
    var_b5465829 = 0;
    while (true) {
        if (isdefined(self.current_pathto_pos)) {
            if (isdefined(self.enemy)) {
                if (distance2dsquared(self.enemy.origin, self.current_pathto_pos) < 62500) {
                    self.var_29b7382f = 1;
                    self notify(#"near_goal");
                }
                if (!self function_4246bc05(self.enemy)) {
                    if (!self vehicle_ai::canseeenemyfromposition(self.current_pathto_pos, self.enemy, 80)) {
                        var_b5465829++;
                        if (var_b5465829 > 5) {
                            self.var_29b7382f = 1;
                            self notify(#"near_goal");
                        }
                    }
                }
            }
            if (distance2dsquared(self.current_pathto_pos, self.goalpos) > self.goalradius * self.goalradius) {
                wait 1;
                self.var_29b7382f = 1;
                self notify(#"near_goal");
            }
        }
        wait 0.3;
    }
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0x9987bf0f, Offset: 0x3b00
// Size: 0x50a
function function_52951bdf() {
    self endon(#"death");
    self endon(#"change_state");
    self notify(#"end_movement_thread");
    self endon(#"end_movement_thread");
    if (self.goalforced) {
        return self.goalpos;
    }
    minsearchradius = 0;
    maxsearchradius = 2000;
    halfheight = 300;
    innerspacing = 90;
    outerspacing = innerspacing * 2;
    var_fc9d1e61 = 15;
    self asmrequestsubstate("locomotion@movement");
    wait 0.5;
    self setbrake(0);
    while (true) {
        self setspeed(self.settings.defaultmovespeed, 5, 5);
        pixbeginevent("_quadtank::Movement_Thread_Wander");
        queryresult = positionquery_source_navigation(self.origin, minsearchradius, maxsearchradius, halfheight, innerspacing, self, outerspacing);
        pixendevent();
        positionquery_filter_distancetogoal(queryresult, self);
        vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
        vehicle_ai::positionquery_filter_random(queryresult, -56, -6);
        foreach (point in queryresult.data) {
            if (distance2dsquared(self.origin, point.origin) < 28900) {
                /#
                    if (!isdefined(point._scoredebug)) {
                        point._scoredebug = [];
                    }
                    point._scoredebug["<dev string:x28>"] = -100;
                #/
                point.score += -100;
            }
        }
        self vehicle_ai::positionquery_debugscores(queryresult);
        vehicle_ai::positionquery_postprocess_sortscore(queryresult);
        foundpath = 0;
        goalpos = self.origin;
        count = queryresult.data.size;
        if (count > 3) {
            count = 3;
        }
        for (i = 0; i < count && !foundpath; i++) {
            goalpos = queryresult.data[i].origin;
            foundpath = self setvehgoalpos(goalpos, 0, 1);
        }
        if (foundpath) {
            self.current_pathto_pos = goalpos;
            self thread path_update_interrupt();
            self asmrequestsubstate("locomotion@movement");
            msg = self util::waittill_any_timeout(var_fc9d1e61, "near_goal", "force_goal", "reached_end_node", "goal");
            self cancelaimove();
            self clearvehgoalpos();
            if (isdefined(self.var_29b7382f)) {
                self.var_29b7382f = undefined;
                wait 0.1;
            } else {
                wait 0.5;
            }
            continue;
        }
        self.current_pathto_pos = undefined;
        goalyaw = self getgoalyaw();
        wait 1;
    }
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0x37c5c0af, Offset: 0x4018
// Size: 0x248
function function_350cca63() {
    self endon(#"death");
    self endon(#"change_state");
    self asmrequestsubstate("locomotion@movement");
    wait 0.5;
    self setbrake(0);
    while (self.allow_movement) {
        if (self.var_872042b7 !== 1) {
            goalpos = vehicle_ai::function_4796e657(80);
            if (distance2dsquared(goalpos, self.origin) > 50 * 50 || isdefined(goalpos) && abs(goalpos[2] - self.origin[2]) > self.height) {
                self setspeed(self.settings.defaultmovespeed, 5, 5);
                self setvehgoalpos(goalpos, 0, 1);
                self.current_pathto_pos = goalpos;
                self thread path_update_interrupt();
                self asmrequestsubstate("locomotion@movement");
                result = self util::waittill_any_return("near_goal", "reached_end_node", "force_goal");
            } else {
                self notify(#"goal");
            }
            self cancelaimove();
            self clearvehgoalpos();
            if (isdefined(self.var_29b7382f)) {
                self.var_29b7382f = undefined;
                wait 0.1;
            } else {
                wait 0.5;
            }
            continue;
        }
        while (isdefined(self.var_872042b7)) {
            wait 0.2;
        }
    }
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0xc79e01f7, Offset: 0x4268
// Size: 0xce
function function_644777c8() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    weapon = self seatgetweapon(1);
    firetime = weapon.firetime;
    while (true) {
        self function_6521eb5d(self function_d24a7ea9(0), 1);
        if (self isgunnerfiring(0)) {
            self fireweapon(2);
        }
        wait firetime;
    }
}

// Namespace quadtank
// Params 2, eflags: 0x0
// Checksum 0x7f972227, Offset: 0x4340
// Size: 0x438
function function_867556e3(shoulddodamage, enemy) {
    if (!isalive(enemy) || distancesquared(enemy.origin, self.origin) > 270 * 270) {
        return false;
    }
    if (vehicle_ai::entityisarchetype(enemy, "quadtank") || vehicle_ai::entityisarchetype(enemy, "raps")) {
        return false;
    }
    if (isplayer(enemy) && enemy laststand::player_is_in_laststand()) {
        return false;
    }
    self notify(#"play_meleefx");
    if (shoulddodamage) {
        players = getplayers();
        foreach (player in players) {
            player.var_31d70948 = player.takedamage;
            player.takedamage = 0;
        }
        radiusdamage(self.origin + (0, 0, 40), 270, 400, 400, self);
        foreach (player in players) {
            player.takedamage = player.var_31d70948;
            player.var_31d70948 = undefined;
        }
    }
    if (isdefined(enemy) && isplayer(enemy)) {
        direction = ((enemy.origin - self.origin)[0], (enemy.origin - self.origin)[1], 0);
        if (abs(direction[0]) < 0.01 && abs(direction[1]) < 0.01) {
            direction = (randomfloatrange(1, 2), randomfloatrange(1, 2), 0);
        }
        direction = vectornormalize(direction);
        strength = 1000;
        enemy setvelocity(enemy getvelocity() + direction * strength);
        enemy function_8334ee5f();
        enemy dodamage(15, self.origin, self);
    }
    self playsound("veh_quadtank_emp");
    return true;
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0x1cfe72e2, Offset: 0x4780
// Size: 0x140
function function_17b8332e() {
    self endon(#"death");
    assert(isdefined(self.team));
    while (!function_fcd2c4ce()) {
        enemies = self getenemies();
        meleed = 0;
        foreach (enemy in enemies) {
            if (enemy isnotarget()) {
                continue;
            }
            meleed = meleed || self function_867556e3(!meleed, enemy);
            if (meleed) {
                break;
            }
        }
        wait 0.3;
    }
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0xc32e6eb5, Offset: 0x48c8
// Size: 0xbc
function function_bf3a7a0d(index) {
    turret::disable(index);
    if (index == 1) {
        self hidepart("tag_gunner_barrel1");
        self hidepart("tag_gunner_turret1");
        return;
    }
    if (index == 2) {
        self hidepart("tag_gunner_barrel2");
        self hidepart("tag_gunner_turret2");
    }
}

// Namespace quadtank
// Params 15, eflags: 0x0
// Checksum 0xedce8c5c, Offset: 0x4990
// Size: 0x6dc
function function_efc2d52f(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    var_71449320 = weapon.weapclass == "grenade";
    if (issubstr(weapon.name, "spike")) {
        if (eattacker.team !== self.team) {
            self.var_31e90786 += 1;
        }
        var_71449320 = 0;
    }
    if (isplayer(eattacker) && eattacker.usingvehicle && (eattacker == self || isdefined(eattacker) && eattacker.viewlockedentity === self)) {
        return 0;
    }
    if (smeansofdeath === "MOD_MELEE" || smeansofdeath === "MOD_MELEE_WEAPON_BUTT" || smeansofdeath === "MOD_MELEE_ASSASSINATE" || smeansofdeath === "MOD_ELECTROCUTED" || smeansofdeath === "MOD_CRUSH" || weapon.isemp) {
        return 0;
    }
    if (vehicle_ai::entityisarchetype(eattacker, "raps") && !function_fcd2c4ce()) {
        self.var_ef5ed6ae = 0;
        self.var_de9eba31 = 3;
        self thread function_5d17667f();
        if (isplayer(eattacker) && damagefeedback::dodamagefeedback(weapon, einflictor)) {
            eattacker thread damagefeedback::update(smeansofdeath, einflictor);
        }
    }
    if (partname == "tag_target_lower" || partname == "tag_target_upper" || partname == "tag_defense_active" || partname == "tag_body_animate") {
        if (isdefined(eattacker) && isplayer(eattacker) && eattacker.team != self.team) {
            if (!isdefined(self.var_ef5ed6ae)) {
                self.var_ef5ed6ae = self.settings.var_fe71d83a;
            }
            if (!function_fcd2c4ce()) {
                self.var_ef5ed6ae -= idamage;
                function_7e50e8da();
                if (self.var_ef5ed6ae <= 0) {
                    self thread function_5d17667f();
                }
                if (isplayer(eattacker) && damagefeedback::dodamagefeedback(weapon, einflictor)) {
                    if (idamage > 0) {
                        eattacker thread damagefeedback::update(smeansofdeath, einflictor);
                    }
                }
            }
        }
    } else if (var_71449320) {
        idamage = int(idamage * 3);
    }
    self.var_f5d48615 = 0;
    self.turretrotscale = 1 * self.var_cf0b2b03;
    self.turret_on_target = 1;
    if (smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PISTOL_BULLET") {
        return idamage;
    }
    if (isactor(eattacker) && idamage > -6) {
        idamage = -6;
    }
    num_players = getplayers().size;
    maxdamage = self.healthdefault * (0.2 - 0.025 * num_players);
    if (smeansofdeath !== "MOD_UNKNOWN" && idamage > maxdamage) {
        idamage = maxdamage;
    }
    var_7aaca1e8 = vehicle::update_damage_fx_level(self.health, idamage, self.healthdefault);
    driver = self getseatoccupant(0);
    if (smeansofdeath != "MOD_UNKNOWN" && !vehicle_ai::entityisarchetype(eattacker, "quadtank")) {
        if (self.var_9d0e9d5e + idamage > self.settings.var_f99b9c5 && self.var_de9eba31 < 4 && !isdefined(driver)) {
            idamage = max(1, self.settings.var_f99b9c5 - self.var_9d0e9d5e);
        }
        self.var_9d0e9d5e += idamage;
    }
    if ((!isdefined(eattacker) || var_7aaca1e8 && smeansofdeath != "MOD_MELEE_ASSASSINATE" && eattacker.team !== self.team) && !isdefined(driver)) {
        playsoundatposition("prj_quad_impact", self.origin);
    }
    idamage = vehicle_ai::shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
    return idamage;
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0x88f3f29f, Offset: 0x5078
// Size: 0x54
function function_ced547f7(team) {
    self.team = team;
    if (!self vehicle_ai::is_instate("off")) {
        self vehicle_ai::blink_lights_for_time(0.5);
    }
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0xfda320df, Offset: 0x50d8
// Size: 0x42
function function_dd8d3882() {
    if (isdefined(self.var_3ab5b78c)) {
        missile_deleteattractor(self.var_3ab5b78c);
        self.var_3ab5b78c = undefined;
    }
    self notify(#"hash_d27732d2");
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0xc9cd5a6e, Offset: 0x5128
// Size: 0x120
function function_4d94f2a0() {
    self notify(#"hash_d27732d2");
    self endon(#"hash_d27732d2");
    self endon(#"death");
    self endon(#"change_state");
    while (true) {
        self util::waittill_any("projectile_applyattractor", "play_meleefx");
        if (vehicle_ai::iscooldownready("repulsorfx_interval")) {
            playfxontag(self.settings.var_27def451, self, "tag_body");
            self vehicle::impact_fx(self.settings.var_8f04a73d);
            vehicle_ai::cooldown("repulsorfx_interval", 0.5);
            self playsound("wpn_quadtank_shield_impact");
            function_7e50e8da();
        }
    }
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0x6f0864c8, Offset: 0x5250
// Size: 0x64
function function_a093b43b() {
    if (!isdefined(self.var_3ab5b78c)) {
        self.var_3ab5b78c = missile_createrepulsorent(self, 40000, self.settings.var_316e3dc7, 1);
    }
    self thread function_4d94f2a0();
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0xc333d3f7, Offset: 0x52c0
// Size: 0x4c
function function_8440fad9(time) {
    self notify(#"hash_f7122e99");
    self endon(#"hash_f7122e99");
    self endon(#"death");
    wait time;
    self laseroff();
}

// Namespace quadtank
// Params 2, eflags: 0x0
// Checksum 0x455084d8, Offset: 0x5318
// Size: 0x246
function function_13b96489(v_target, n_index) {
    s_turret = turret::_get_turret_data(n_index);
    var_ef4a39d3 = self gettagorigin(s_turret.str_tag_pivot);
    var_abd92018 = vectortoangles(v_target - var_ef4a39d3);
    var_d433358d = s_turret.var_d433358d + self.angles[0];
    var_c0de8e7a = s_turret.var_c0de8e7a + self.angles[1];
    var_fbd3a8cf = angleclamp180(var_abd92018[0] - var_d433358d);
    var_f202ddd4 = angleclamp180(var_abd92018[1] - var_c0de8e7a);
    var_87b830c2 = 0;
    if (var_fbd3a8cf > 0) {
        if (var_fbd3a8cf > s_turret.bottomarc) {
            var_87b830c2 = 1;
        }
    } else if (abs(var_fbd3a8cf) > s_turret.toparc) {
        var_87b830c2 = 1;
    }
    if (var_f202ddd4 > 0) {
        if (var_f202ddd4 > s_turret.leftarc) {
            var_87b830c2 = 1;
        }
    } else if (abs(var_f202ddd4) > s_turret.rightarc) {
        var_87b830c2 = 1;
    }
    if (var_87b830c2) {
        return 0;
    }
    return abs(var_f202ddd4) / 90 * 800;
}

// Namespace quadtank
// Params 2, eflags: 0x0
// Checksum 0x33d44f02, Offset: 0x5568
// Size: 0x3e4
function function_1870af4(a_potential_targets, n_index) {
    var_ee85b72c = mapfloat(0, 4, 800, 0, level.gameskill);
    if (n_index === 1) {
        var_928adba = turret::get_target(2);
    } else if (n_index === 2) {
        var_928adba = turret::get_target(1);
    }
    e_best_target = undefined;
    var_f8425fd9 = 100000;
    s_turret = turret::_get_turret_data(n_index);
    foreach (e_target in a_potential_targets) {
        var_99f70b32 = distance(self.origin, e_target.origin);
        b_current_target = turret::is_target(e_target, n_index);
        if (b_current_target) {
            var_99f70b32 -= 100;
        }
        if (e_target === self.enemy) {
            var_99f70b32 += 300;
        }
        if (e_target === var_928adba) {
            var_99f70b32 += 100 + var_ee85b72c;
        }
        if (issentient(e_target) && e_target attackedrecently(self, 2)) {
            var_99f70b32 -= -56;
        }
        if (isalive(self.var_5001b74f) && e_target === self.var_5001b74f) {
            var_99f70b32 -= 1000;
        }
        v_offset = turret::_get_default_target_offset(e_target, n_index);
        var_d6542a89 = function_13b96489(e_target.origin + v_offset, n_index);
        if (var_d6542a89 != 0) {
            var_99f70b32 += var_d6542a89;
            b_trace_passed = turret::trace_test(e_target, v_offset, n_index);
            if (b_current_target && !b_trace_passed && !isdefined(s_turret.n_time_lose_sight)) {
                s_turret.n_time_lose_sight = gettime();
            }
            if (b_trace_passed) {
                var_99f70b32 -= 500;
            }
        } else if (b_current_target) {
            s_turret.var_20de07b0 = 1;
            var_99f70b32 += 5000;
        }
        if (var_99f70b32 < var_f8425fd9) {
            var_f8425fd9 = var_99f70b32;
            e_best_target = e_target;
        }
    }
    return e_best_target;
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0x6d2b8381, Offset: 0x5958
// Size: 0x34
function function_7e50e8da() {
    if (isdefined(self.var_da1f4811) && self.var_da1f4811) {
        self globallogic_ui::function_2d11c5e4(%tag_target_lower);
    }
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0xac007ae0, Offset: 0x5998
// Size: 0x104
function function_4c6ee4cc(state) {
    if (self.var_da1f4811 !== state) {
        self.var_da1f4811 = state;
        if (!self.var_da1f4811 && self.var_a670ac2a === 1) {
            self.var_a670ac2a = 0;
            self globallogic_ui::function_d66e4079(%tag_target_lower);
        }
        player = level.players[0];
        if (!isdefined(player) || self.var_da1f4811 && self.var_4e5b312b && self.var_a670ac2a !== 1 && player.team !== self.team) {
            self.var_a670ac2a = 1;
            self globallogic_ui::function_8ee5a301(%tag_target_lower);
        }
    }
}

// Namespace quadtank
// Params 0, eflags: 0x0
// Checksum 0xc1dfc1df, Offset: 0x5aa8
// Size: 0x140
function function_bda33f7a() {
    self endon(#"death");
    self endon(#"exit_vehicle");
    while (true) {
        note = self util::waittill_any_return("footstep_front_left", "footstep_front_right", "footstep_rear_left", "footstep_rear_right");
        switch (note) {
        case "footstep_front_left":
            bone = "tag_foot_fx_left_front";
            break;
        case "footstep_front_right":
            bone = "tag_foot_fx_right_front";
            break;
        case "footstep_rear_left":
            bone = "tag_foot_fx_left_back";
            break;
        case "footstep_rear_right":
            bone = "tag_foot_fx_right_back";
            break;
        }
        position = self gettagorigin(bone) + (0, 0, 15);
        self radiusdamage(position, 60, 50, 50, self, "MOD_CRUSH");
    }
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0xd7799efb, Offset: 0x5bf0
// Size: 0x124
function function_c73f719e(projectile) {
    self endon(#"entityshutdown");
    self endon(#"death");
    self waittill(#"weapon_fired", projectile);
    distance = 1400;
    alias = "prj_quadtank_javelin_incoming";
    wait 5;
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
        wait 0.2;
    }
}

// Namespace quadtank
// Params 1, eflags: 0x0
// Checksum 0x687b9220, Offset: 0x5d20
// Size: 0x124
function function_af1bc2b1(projectile) {
    self endon(#"entityshutdown");
    self endon(#"death");
    self waittill(#"weapon_fired", projectile);
    distance = 900;
    var_7f2a8cb = "wpn_quadtank_railgun_fire_rocket_flux";
    players = level.players;
    while (isdefined(projectile) && isdefined(projectile.origin)) {
        if (isdefined(players[0]) && isdefined(players[0].origin)) {
            var_24d263dd = distancesquared(projectile.origin, players[0].origin);
            if (var_24d263dd <= distance * distance) {
                projectile playsound(var_7f2a8cb);
                return;
            }
        }
        wait 0.2;
    }
}

