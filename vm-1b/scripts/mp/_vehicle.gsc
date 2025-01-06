#using scripts/mp/_util;
#using scripts/mp/gametypes/_spawning;
#using scripts/mp/killstreaks/_qrdrone;
#using scripts/mp/killstreaks/_rcbomb;
#using scripts/shared/array_shared;
#using scripts/shared/hud_util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;

#using_animtree("mp_vehicles");

#namespace vehicle;

// Namespace vehicle
// Params 0, eflags: 0x2
// Checksum 0x55fccdf0, Offset: 0xad0
// Size: 0x2a
function autoexec function_2dc19561() {
    system::register("vehicle", &__init__, undefined, undefined);
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xbc05df7d, Offset: 0xb08
// Size: 0x6eb
function __init__() {
    setdvar("scr_veh_cleanupdebugprint", "0");
    setdvar("scr_veh_driversarehidden", "1");
    setdvar("scr_veh_driversareinvulnerable", "1");
    setdvar("scr_veh_alive_cleanuptimemin", "119");
    setdvar("scr_veh_alive_cleanuptimemax", "120");
    setdvar("scr_veh_dead_cleanuptimemin", "20");
    setdvar("scr_veh_dead_cleanuptimemax", "30");
    setdvar("scr_veh_cleanuptime_dmgfactor_min", "0.33");
    setdvar("scr_veh_cleanuptime_dmgfactor_max", "1.0");
    setdvar("scr_veh_cleanuptime_dmgfactor_deadtread", "0.25");
    setdvar("scr_veh_cleanuptime_dmgfraction_curve_begin", "0.0");
    setdvar("scr_veh_cleanuptime_dmgfraction_curve_end", "1.0");
    setdvar("scr_veh_cleanupabandoned", "1");
    setdvar("scr_veh_cleanupdrifted", "1");
    setdvar("scr_veh_cleanupmaxspeedmph", "1");
    setdvar("scr_veh_cleanupmindistancefeet", "75");
    setdvar("scr_veh_waittillstoppedandmindist_maxtime", "10");
    setdvar("scr_veh_waittillstoppedandmindist_maxtimeenabledistfeet", "5");
    setdvar("scr_veh_respawnafterhuskcleanup", "1");
    setdvar("scr_veh_respawntimemin", "50");
    setdvar("scr_veh_respawntimemax", "90");
    setdvar("scr_veh_respawnwait_maxiterations", "30");
    setdvar("scr_veh_respawnwait_iterationwaitseconds", "1");
    setdvar("scr_veh_disablerespawn", "0");
    setdvar("scr_veh_disableoverturndamage", "0");
    setdvar("scr_veh_explosion_spawnfx", "1");
    setdvar("scr_veh_explosion_doradiusdamage", "1");
    setdvar("scr_veh_explosion_radius", "256");
    setdvar("scr_veh_explosion_mindamage", "20");
    setdvar("scr_veh_explosion_maxdamage", "200");
    setdvar("scr_veh_ondeath_createhusk", "1");
    setdvar("scr_veh_ondeath_usevehicleashusk", "1");
    setdvar("scr_veh_explosion_husk_forcepointvariance", "30");
    setdvar("scr_veh_explosion_husk_horzvelocityvariance", "25");
    setdvar("scr_veh_explosion_husk_vertvelocitymin", "100");
    setdvar("scr_veh_explosion_husk_vertvelocitymax", "200");
    setdvar("scr_veh_explode_on_cleanup", "1");
    setdvar("scr_veh_disappear_maxwaittime", "60");
    setdvar("scr_veh_disappear_maxpreventdistancefeet", "30");
    setdvar("scr_veh_disappear_maxpreventvisibilityfeet", "150");
    setdvar("scr_veh_health_tank", "1350");
    level.vehicle_drivers_are_invulnerable = getdvarint("scr_veh_driversareinvulnerable");
    level.var_4892cc47 = &function_cbd74bac;
    level.var_9cc6b64c["panzer4_mp"] = 2600;
    level.var_9cc6b64c["t34_mp"] = 2600;
    setdvar("scr_veh_health_jeep", "700");
    if (function_f8e61088()) {
        level.var_654c5e35 = "_t6/vehicle/vexplosion/fx_vexplode_helicopter_exp_mp";
        level.var_16bc4847 = [];
        if (isdefined(level.var_5f89aa3a)) {
            level.var_16bc4847["t34_mp"] = "veh_t34_destroyed_mp";
        }
        if (isdefined(level.var_91704999)) {
            [[ level.var_91704999 ]]();
        }
    }
    var_770b3266 = mp_vehicles%int_huey_gunner_on;
    var_79adafe8 = mp_vehicles%v_huey_door_open;
    var_ceff16a2 = mp_vehicles%v_huey_door_open_state;
    var_88ed02ba = mp_vehicles%v_huey_door_close_state;
    killbrushes = getentarray("water_killbrush", "targetname");
    foreach (brush in killbrushes) {
        brush thread function_e003d8c2();
    }
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xaf1e82b2, Offset: 0x1200
// Size: 0xbd
function function_e003d8c2() {
    for (;;) {
        self waittill(#"trigger", entity);
        if (isdefined(entity)) {
            if (isdefined(entity.targetname)) {
                if (entity.targetname == "rcbomb") {
                    entity notify(#"rcbomb_shutdown");
                } else if (entity.targetname == "talon" && !(isdefined(entity.dead) && entity.dead)) {
                    entity notify(#"death");
                }
            }
            if (isdefined(entity.helitype) && entity.helitype == "qrdrone") {
                entity qrdrone::qrdrone_force_destroy();
            }
        }
    }
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x240ac6c9, Offset: 0x12c8
// Size: 0x46b
function function_5d7c99ca() {
    var_bdcc5bb2 = 0;
    var_e2b20eed = 1;
    var_7a41cd44 = 2;
    var_eb23fa84 = 3;
    var_817dbc8f = 0.85;
    var_867c9f4 = 0.55;
    var_9de57939 = 0.35;
    var_5111b79 = 0;
    level.var_817dbc8f = var_817dbc8f;
    level.var_867c9f4 = var_867c9f4;
    level.var_9de57939 = var_9de57939;
    level.var_5111b79 = var_5111b79;
    level.var_e07b3017 = [];
    level.var_d8c8ff6d = [];
    level.var_384d9931 = [];
    var_6726cb47 = function_564648a();
    level.var_e07b3017[var_6726cb47] = [];
    level.var_384d9931[var_6726cb47] = [];
    level.var_e07b3017[var_6726cb47][var_bdcc5bb2] = spawnstruct();
    level.var_e07b3017[var_6726cb47][var_bdcc5bb2].health_percentage = var_817dbc8f;
    level.var_e07b3017[var_6726cb47][var_bdcc5bb2].var_59563284 = [];
    level.var_e07b3017[var_6726cb47][var_bdcc5bb2].var_59563284[0] = spawnstruct();
    level.var_e07b3017[var_6726cb47][var_bdcc5bb2].var_59563284[0].var_5d63722 = "_t6/vehicle/vfire/fx_tank_sherman_smldr";
    level.var_e07b3017[var_6726cb47][var_bdcc5bb2].var_59563284[0].sound_effect = undefined;
    level.var_e07b3017[var_6726cb47][var_bdcc5bb2].var_59563284[0].var_7a93ee5a = "tag_origin";
    level.var_e07b3017[var_6726cb47][var_e2b20eed] = spawnstruct();
    level.var_e07b3017[var_6726cb47][var_e2b20eed].health_percentage = var_867c9f4;
    level.var_e07b3017[var_6726cb47][var_e2b20eed].var_59563284 = [];
    level.var_e07b3017[var_6726cb47][var_e2b20eed].var_59563284[0] = spawnstruct();
    level.var_e07b3017[var_6726cb47][var_e2b20eed].var_59563284[0].var_5d63722 = "_t6/vehicle/vfire/fx_vfire_med_12";
    level.var_e07b3017[var_6726cb47][var_e2b20eed].var_59563284[0].sound_effect = undefined;
    level.var_e07b3017[var_6726cb47][var_e2b20eed].var_59563284[0].var_7a93ee5a = "tag_origin";
    level.var_e07b3017[var_6726cb47][var_7a41cd44] = spawnstruct();
    level.var_e07b3017[var_6726cb47][var_7a41cd44].health_percentage = var_9de57939;
    level.var_e07b3017[var_6726cb47][var_7a41cd44].var_59563284 = [];
    level.var_e07b3017[var_6726cb47][var_7a41cd44].var_59563284[0] = spawnstruct();
    level.var_e07b3017[var_6726cb47][var_7a41cd44].var_59563284[0].var_5d63722 = "_t6/vehicle/vfire/fx_vfire_sherman";
    level.var_e07b3017[var_6726cb47][var_7a41cd44].var_59563284[0].sound_effect = undefined;
    level.var_e07b3017[var_6726cb47][var_7a41cd44].var_59563284[0].var_7a93ee5a = "tag_origin";
    level.var_e07b3017[var_6726cb47][var_eb23fa84] = spawnstruct();
    level.var_e07b3017[var_6726cb47][var_eb23fa84].health_percentage = var_5111b79;
    level.var_e07b3017[var_6726cb47][var_eb23fa84].var_59563284 = [];
    level.var_e07b3017[var_6726cb47][var_eb23fa84].var_59563284[0] = spawnstruct();
    level.var_e07b3017[var_6726cb47][var_eb23fa84].var_59563284[0].var_5d63722 = "_t6/vehicle/vexplosion/fx_vexplode_helicopter_exp_mp";
    level.var_e07b3017[var_6726cb47][var_eb23fa84].var_59563284[0].sound_effect = "vehicle_explo";
    level.var_e07b3017[var_6726cb47][var_eb23fa84].var_59563284[0].var_7a93ee5a = "tag_origin";
    var_c580d7ab = spawnstruct();
    var_c580d7ab.var_5d63722 = undefined;
    var_c580d7ab.sound_effect = undefined;
    var_c580d7ab.var_7a93ee5a = "tag_origin";
    level.var_d8c8ff6d[var_6726cb47] = var_c580d7ab;
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0xebb6d7bf, Offset: 0x1740
// Size: 0x3e
function function_89166848(vehicle) {
    name = "";
    if (isdefined(vehicle)) {
        if (isdefined(vehicle.vehicletype)) {
            name = vehicle.vehicletype;
        }
    }
    return name;
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x306cf871, Offset: 0x1788
// Size: 0x9
function function_564648a() {
    return "defaultvehicle_mp";
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0xfe4964e, Offset: 0x17a0
// Size: 0x46
function function_dd3249e9(vehicle) {
    var_6726cb47 = function_89166848(vehicle);
    if (!isdefined(level.var_e07b3017[var_6726cb47])) {
        var_6726cb47 = function_564648a();
    }
    return var_6726cb47;
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0x47e3d7ee, Offset: 0x17f0
// Size: 0x85
function function_237a0c0c(vehicle) {
    var_b761a495 = -1;
    var_6726cb47 = function_dd3249e9();
    for (test_index = 0; test_index < level.var_e07b3017[var_6726cb47].size; test_index++) {
        if (vehicle.var_5badf298 <= level.var_e07b3017[var_6726cb47][test_index].health_percentage) {
            var_b761a495 = test_index;
            continue;
        }
        break;
    }
    return var_b761a495;
}

// Namespace vehicle
// Params 2, eflags: 0x0
// Checksum 0x1a45f3f2, Offset: 0x1880
// Size: 0xf2
function update_damage_effects(vehicle, attacker) {
    if (vehicle.var_bb64fbd1.health > 0) {
        var_83ba14cd = function_237a0c0c(vehicle);
        vehicle.var_5badf298 = vehicle.health / vehicle.var_bb64fbd1.health;
        var_8b2b2ff3 = function_237a0c0c(vehicle);
        if (var_83ba14cd != var_8b2b2ff3) {
            vehicle notify(#"hash_33aaf06d");
            if (var_83ba14cd < 0) {
                var_fdbe515a = 0;
            } else {
                var_fdbe515a = var_83ba14cd + 1;
            }
            function_3a51499c(vehicle, var_fdbe515a, var_8b2b2ff3);
            if (vehicle.health <= 0) {
                vehicle kill_vehicle(attacker);
            }
        }
    }
}

// Namespace vehicle
// Params 3, eflags: 0x0
// Checksum 0x7f9a1cb0, Offset: 0x1980
// Size: 0xaf
function function_3a51499c(vehicle, var_fdbe515a, var_33c96657) {
    var_6726cb47 = function_dd3249e9(vehicle);
    for (var_b761a495 = var_fdbe515a; var_b761a495 <= var_33c96657; var_b761a495++) {
        for (var_b5b2fb6f = 0; var_b5b2fb6f < level.var_e07b3017[var_6726cb47][var_b761a495].var_59563284.size; var_b5b2fb6f++) {
            effects = level.var_e07b3017[var_6726cb47][var_b761a495].var_59563284[var_b5b2fb6f];
            vehicle thread function_bd0af061(effects);
        }
    }
}

// Namespace vehicle
// Params 2, eflags: 0x0
// Checksum 0x969084e7, Offset: 0x1a38
// Size: 0xc9
function function_bd0af061(effects, var_8962bd6e) {
    self endon(#"delete");
    self endon(#"removed");
    if (!isdefined(var_8962bd6e) || var_8962bd6e == 0) {
        self endon(#"hash_33aaf06d");
    }
    if (isdefined(effects.sound_effect)) {
        self playsound(effects.sound_effect);
    }
    waittime = 0;
    if (isdefined(effects.var_2bc551d9)) {
        waittime = effects.var_2bc551d9;
    }
    while (waittime > 0) {
        if (isdefined(effects.var_5d63722)) {
            playfxontag(effects.var_5d63722, self, effects.var_7a93ee5a);
        }
        wait waittime;
    }
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xd84de63e, Offset: 0x1b10
// Size: 0x56
function function_f8e61088() {
    vehicles = getentarray("script_vehicle", "classname");
    array::thread_all(vehicles, &function_3e8eeb3a);
    if (isdefined(vehicles)) {
        return vehicles.size;
    }
    return 0;
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x1b70
// Size: 0x2
function function_7e6704fe() {
    
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x321e2dc3, Offset: 0x1b80
// Size: 0x27
function register_vehicle() {
    if (!isdefined(level.var_f196620d)) {
        level.var_f196620d = [];
    }
    level.var_f196620d[level.var_f196620d.size] = self;
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x710ec70d, Offset: 0x1bb0
// Size: 0x146
function function_bd1ad094() {
    if (!isdefined(level.var_f196620d)) {
        return 1;
    }
    var_feb82343 = getmaxvehicles();
    newarray = [];
    for (i = 0; i < level.var_f196620d.size; i++) {
        if (isdefined(level.var_f196620d[i])) {
            newarray[newarray.size] = level.var_f196620d[i];
        }
    }
    level.var_f196620d = newarray;
    var_586ea2bc = level.var_f196620d.size + 1 - var_feb82343;
    if (var_586ea2bc > 0) {
        newarray = [];
        for (i = 0; i < level.var_f196620d.size; i++) {
            vehicle = level.var_f196620d[i];
            if (var_586ea2bc > 0) {
                if (isdefined(vehicle.is_husk) && !isdefined(vehicle.var_6526927c)) {
                    deleted = vehicle function_f7a07937();
                    if (deleted) {
                        var_586ea2bc--;
                        continue;
                    }
                }
            }
            newarray[newarray.size] = vehicle;
        }
        level.var_f196620d = newarray;
    }
    return level.var_f196620d.size < var_feb82343;
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x98b33ba5, Offset: 0x1d00
// Size: 0xf2
function init_vehicle() {
    self register_vehicle();
    if (isdefined(level.var_9cc6b64c) && isdefined(level.var_9cc6b64c[self.vehicletype])) {
        self.maxhealth = level.var_9cc6b64c[self.vehicletype];
    } else {
        self.maxhealth = getdvarint("scr_veh_health_tank");
        println("<dev string:x28>" + self.vehicletype + "<dev string:x4e>");
    }
    self.health = self.maxhealth;
    self function_96630c9();
    self function_545484e8();
    system::wait_till("spawning");
    self spawning::create_entity_masked_enemy_influencer("vehicle", 0);
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x3c87a9ce, Offset: 0x1e00
// Size: 0x6a
function function_7a69e87b() {
    if (self.var_bb64fbd1.health > 0) {
        self.var_5badf298 = self.health / self.var_bb64fbd1.health;
        self.var_bc804aae = self.health / self.var_bb64fbd1.health;
        return;
    }
    self.var_5badf298 = 1;
    self.var_bc804aae = 1;
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xc08e1440, Offset: 0x1e78
// Size: 0x1a
function function_3e8eeb3a() {
    self.var_19ac5a79 = 1;
    self init_vehicle();
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xf158b729, Offset: 0x1ea0
// Size: 0x65
function function_37bc279d() {
    self endon(#"hash_c0114f4e");
    self endon(#"death");
    self endon(#"delete");
    while (true) {
        self waittill(#"enter_vehicle", player);
        player thread function_de55df31();
        player function_8996c8a1(1, self);
    }
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x86037878, Offset: 0x1f10
// Size: 0x32
function function_de55df31() {
    self endon(#"disconnect");
    self waittill(#"exit_vehicle", vehicle);
    self function_8996c8a1(0, vehicle);
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xe238d979, Offset: 0x1f50
// Size: 0x85
function function_9636d8ba() {
    self endon(#"hash_c0114f4e");
    self endon(#"death");
    self endon(#"delete");
    while (true) {
        self waittill(#"damage");
        occupants = self getvehoccupants();
        if (isdefined(occupants)) {
            for (i = 0; i < occupants.size; i++) {
                occupants[i] function_8996c8a1(1, self);
            }
        }
    }
}

// Namespace vehicle
// Params 2, eflags: 0x0
// Checksum 0x8299065b, Offset: 0x1fe0
// Size: 0x21a
function function_8996c8a1(show, vehicle) {
    if (show) {
        if (!isdefined(self.vehiclehud)) {
            self.vehiclehud = hud::createbar((1, 1, 1), 64, 16);
            self.vehiclehud hud::setpoint("CENTER", "BOTTOM", 0, -40);
            self.vehiclehud.alpha = 0.75;
        }
        self.vehiclehud hud::updatebar(vehicle.health / vehicle.var_bb64fbd1.health);
    } else if (isdefined(self.vehiclehud)) {
        self.vehiclehud hud::destroyelem();
    }
    if (getdvarstring("scr_vehicle_healthnumbers") != "") {
        if (getdvarint("scr_vehicle_healthnumbers") != 0) {
            if (show) {
                if (!isdefined(self.var_f1741556)) {
                    self.var_f1741556 = hud::createfontstring("default", 2);
                    self.var_f1741556 hud::setparent(self.vehiclehud);
                    self.var_f1741556 hud::setpoint("LEFT", "RIGHT", 8, 0);
                    self.var_f1741556.alpha = 0.75;
                    self.var_f1741556.hidewheninmenu = 0;
                    self.var_f1741556.archived = 0;
                }
                self.var_f1741556 setvalue(vehicle.health);
                return;
            }
            if (isdefined(self.var_f1741556)) {
                self.var_f1741556 hud::destroyelem();
            }
        }
    }
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xd78c87a7, Offset: 0x2208
// Size: 0x10a
function function_545484e8() {
    self thread function_44e2076f();
    self thread function_345aa636();
    self thread function_df2e8ee8();
    self thread function_98cbada0();
    self thread function_521b9c81();
    self thread function_8da271e5();
    if (isdefined(level.var_59354625) && level.var_59354625) {
        self thread function_37bc279d();
        self thread function_9636d8ba();
    }
    self thread function_c73035a4();
    self thread function_766de9be();
    if (getdvarint("scr_veh_disableoverturndamage") == 0) {
        self thread function_4f6ab888();
    }
    /#
        self thread function_47d6caa6();
        self thread function_e7c8dc75();
    #/
}

// Namespace vehicle
// Params 3, eflags: 0x0
// Checksum 0x7c0fc82a, Offset: 0x2320
// Size: 0xaa
function build_template(type, model, typeoverride) {
    if (isdefined(typeoverride)) {
        type = typeoverride;
    }
    if (!isdefined(level.vehicle_death_fx)) {
        level.vehicle_death_fx = [];
    }
    if (!isdefined(level.vehicle_death_fx[type])) {
        level.vehicle_death_fx[type] = [];
    }
    level.vehicle_compassicon[type] = 0;
    level.vehicle_team[type] = "axis";
    level.var_b3fd46f4[type] = 999;
    level.var_eaf66653[model] = 0;
    level.var_d975a6c2[model] = [];
    level.vtmodel = model;
    level.vttype = type;
}

// Namespace vehicle
// Params 6, eflags: 0x0
// Checksum 0xba67e74e, Offset: 0x23d8
// Size: 0x9f
function build_rumble(rumble, scale, duration, radius, basetime, randomaditionaltime) {
    if (!isdefined(level.vehicle_rumble)) {
        level.vehicle_rumble = [];
    }
    struct = build_quake(scale, duration, radius, basetime, randomaditionaltime);
    assert(isdefined(rumble));
    struct.rumble = rumble;
    level.vehicle_rumble[level.vttype] = struct;
}

// Namespace vehicle
// Params 5, eflags: 0x0
// Checksum 0xff1904cc, Offset: 0x2480
// Size: 0x94
function build_quake(scale, duration, radius, basetime, randomaditionaltime) {
    struct = spawnstruct();
    struct.scale = scale;
    struct.duration = duration;
    struct.radius = radius;
    if (isdefined(basetime)) {
        struct.basetime = basetime;
    }
    if (isdefined(randomaditionaltime)) {
        struct.randomaditionaltime = randomaditionaltime;
    }
    return struct;
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0x8797a955, Offset: 0x2520
// Size: 0x1b
function build_exhaust(effect) {
    level.var_cdb497b8[level.vtmodel] = effect;
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x12d6fa65, Offset: 0x2548
// Size: 0x8d
function function_47d6caa6() {
    self endon(#"hash_c0114f4e");
    self endon(#"death");
    self endon(#"delete");
    /#
        while (true) {
            if (isdefined(self.debug_message) && getdvarint("<dev string:x61>") != 0) {
                print3d(self.origin + (0, 0, 150), self.debug_message, (0, 1, 0), 1, 1, 1);
            }
            wait 0.01;
        }
    #/
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x4aed1831, Offset: 0x25e0
// Size: 0x3d
function function_e7c8dc75() {
    self endon(#"hash_c0114f4e");
    self endon(#"death");
    self endon(#"delete");
    /#
        while (true) {
            self waittill(#"enter_vehicle");
            self.debug_message = undefined;
        }
    #/
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0xa454f9a6, Offset: 0x2628
// Size: 0x16
function function_5754ab8b(message) {
    /#
        self.debug_message = message;
    #/
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xeda35830, Offset: 0x2648
// Size: 0x3a
function function_44e2076f() {
    self endon(#"hash_c0114f4e");
    self endon(#"death");
    self endon(#"delete");
    self function_c648b1cc("Drift Test", "scr_veh_cleanupdrifted");
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x3da26c3d, Offset: 0x2690
// Size: 0x3a
function function_38cfcf2a() {
    self endon(#"hash_c0114f4e");
    self endon(#"death");
    self endon(#"delete");
    self function_c648b1cc("Abandon Test", "scr_veh_cleanupabandoned");
}

// Namespace vehicle
// Params 2, eflags: 0x0
// Checksum 0x5350327e, Offset: 0x26d8
// Size: 0x6a
function function_c648b1cc(test_name, var_ba2883c9) {
    self endon(#"enter_vehicle");
    self function_fbc9809f();
    self function_3d454a47(test_name);
    self function_c29fa4e6();
    self cleanup(test_name, var_ba2883c9, &function_53fc1461);
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x1ced520a, Offset: 0x2750
// Size: 0xb1
function function_fbc9809f() {
    while (true) {
        health_percentage = self.health / self.var_bb64fbd1.health;
        if (isdefined(level.var_9de57939)) {
            self function_5754ab8b("Damage Test: Still healthy - (" + health_percentage + " >= " + level.var_9de57939 + ") and working treads");
        } else {
            self function_5754ab8b("Damage Test: Still healthy and working treads");
        }
        self waittill(#"damage");
        health_percentage = self.health / self.var_bb64fbd1.health;
        if (health_percentage < level.var_9de57939) {
            break;
        }
    }
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0x8d10854, Offset: 0x2810
// Size: 0x88
function function_bb86b402(state) {
    var_1acb4899 = "scr_veh_" + state + "_cleanuptime";
    mintime = getdvarfloat(var_1acb4899 + "min");
    maxtime = getdvarfloat(var_1acb4899 + "max");
    if (maxtime > mintime) {
        return randomfloatrange(mintime, maxtime);
    }
    return maxtime;
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0x88cad329, Offset: 0x28a0
// Size: 0x1f1
function function_3d454a47(test_name) {
    var_48a61c34 = function_bb86b402("alive");
    var_b5d2021c = 0;
    var_657e084 = 1;
    while (true) {
        var_4477065c = getdvarfloat("scr_veh_cleanuptime_dmgfraction_curve_begin");
        curve_end = getdvarfloat("scr_veh_cleanuptime_dmgfraction_curve_end");
        var_64e1b8d = getdvarfloat("scr_veh_cleanuptime_dmgfactor_min");
        var_43b226a3 = getdvarfloat("scr_veh_cleanuptime_dmgfactor_max");
        var_5ba46817 = getdvarfloat("scr_veh_cleanuptime_dmgfactor_deadtread");
        var_e021b18c = 0;
        if (self is_vehicle()) {
            var_e021b18c = (self.var_bb64fbd1.health - self.health) / self.var_bb64fbd1.health;
        } else {
            var_e021b18c = 1;
        }
        damagefactor = 0;
        if (var_e021b18c <= var_4477065c) {
            damagefactor = var_43b226a3;
        } else if (var_e021b18c >= curve_end) {
            damagefactor = var_64e1b8d;
        } else {
            var_c226750c = (var_64e1b8d - var_43b226a3) / (curve_end - var_4477065c);
            damagefactor = var_43b226a3 + (var_e021b18c - var_4477065c) * var_c226750c;
        }
        var_77457d03 = var_48a61c34 * damagefactor;
        if (var_b5d2021c >= var_77457d03) {
            break;
        }
        self function_5754ab8b(test_name + ": Waiting " + var_77457d03 - var_b5d2021c + "s");
        wait var_657e084;
        var_b5d2021c += var_657e084;
    }
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0x171aba9f, Offset: 0x2aa0
// Size: 0x89
function function_e6f48d52(test_name) {
    var_1bc2b672 = function_bb86b402("dead");
    var_ceb2e4cf = 0;
    var_657e084 = 1;
    while (var_ceb2e4cf < var_1bc2b672) {
        self function_5754ab8b(test_name + ": Waiting " + var_1bc2b672 - var_ceb2e4cf + "s");
        wait var_657e084;
        var_ceb2e4cf += var_657e084;
    }
}

// Namespace vehicle
// Params 3, eflags: 0x0
// Checksum 0xa29358ad, Offset: 0x2b38
// Size: 0xab
function cleanup(test_name, var_ba2883c9, cleanup_func) {
    keep_waiting = 1;
    while (keep_waiting) {
        var_e7029056 = !isdefined(var_ba2883c9) || getdvarint(var_ba2883c9) != 0;
        if (var_e7029056 != 0) {
            self [[ cleanup_func ]]();
            break;
        }
        keep_waiting = 0;
        /#
            self function_5754ab8b("<dev string:x7b>" + test_name + "<dev string:x91>" + var_ba2883c9 + "<dev string:x9c>");
            wait 5;
            keep_waiting = 1;
        #/
    }
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xf61ac8b2, Offset: 0x2bf0
// Size: 0xe5
function function_c73035a4() {
    self endon(#"death");
    self endon(#"delete");
    var_6726cb47 = function_89166848(self);
    while (true) {
        self waittill(#"broken", brokennotify);
        if (brokennotify == "left_tread_destroyed") {
            if (isdefined(level.var_384d9931[var_6726cb47]) && isdefined(level.var_384d9931[var_6726cb47][0])) {
                self thread function_bd0af061(level.var_384d9931[var_6726cb47][0], 1);
            }
            continue;
        }
        if (brokennotify == "right_tread_destroyed") {
            if (isdefined(level.var_384d9931[var_6726cb47]) && isdefined(level.var_384d9931[var_6726cb47][1])) {
                self thread function_bd0af061(level.var_384d9931[var_6726cb47][1], 1);
            }
        }
    }
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xb0fbc225, Offset: 0x2ce0
// Size: 0x117
function function_c29fa4e6() {
    maxwaittime = getdvarfloat("scr_veh_waittillstoppedandmindist_maxtime");
    var_fb92acf8 = 1;
    var_634dc800 = 12 * getdvarfloat("scr_veh_waittillstoppedandmindist_maxtimeenabledistfeet");
    initialorigin = self.var_bb64fbd1.origin;
    for (var_85244ed4 = 0; var_85244ed4 < maxwaittime; var_85244ed4 += var_fb92acf8) {
        speedmph = self getspeedmph();
        var_3e10900f = getdvarfloat("scr_veh_cleanupmaxspeedmph");
        if (speedmph > var_3e10900f) {
            function_5754ab8b("(" + maxwaittime - var_85244ed4 + "s) Speed: " + speedmph + ">" + var_3e10900f);
        } else {
            break;
        }
        wait var_fb92acf8;
    }
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x60210428, Offset: 0x2e00
// Size: 0x75
function function_345aa636() {
    self endon(#"hash_c0114f4e");
    self endon(#"death");
    self endon(#"delete");
    while (true) {
        self waittill(#"exit_vehicle");
        occupants = self getvehoccupants();
        if (occupants.size == 0) {
            self function_eea7a1e1("tank_shutdown_sfx");
            self thread function_38cfcf2a();
        }
    }
}

// Namespace vehicle
// Params 2, eflags: 0x0
// Checksum 0xd2d0ebfe, Offset: 0x2e80
// Size: 0x3a
function function_eea7a1e1(sound_alias, var_ded831cb) {
    if (isdefined(self.var_fcf657c1)) {
    }
    self.var_fcf657c1 = self playsound(sound_alias);
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xcdad11df, Offset: 0x2ec8
// Size: 0xdd
function function_98cbada0() {
    self endon(#"hash_c0114f4e");
    self endon(#"death");
    self endon(#"delete");
    while (true) {
        self waittill(#"enter_vehicle", player, seat);
        isdriver = seat == 0;
        if (getdvarint("scr_veh_driversarehidden") != 0 && isdriver) {
            player ghost();
        }
        occupants = self getvehoccupants();
        if (occupants.size == 1) {
            self function_eea7a1e1("tank_startup_sfx");
        }
        player thread function_fddd6743(self);
        player thread function_87a60a3(self);
    }
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0xf79eedb4, Offset: 0x2fb0
// Size: 0x56
function player_is_occupant_invulnerable(smeansofdeath) {
    if (self isremotecontrolling()) {
        return 0;
    }
    if (!isdefined(level.vehicle_drivers_are_invulnerable)) {
        level.vehicle_drivers_are_invulnerable = 0;
    }
    invulnerable = level.vehicle_drivers_are_invulnerable && self player_is_driver();
    return invulnerable;
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x8a77a5aa, Offset: 0x3010
// Size: 0x67
function player_is_driver() {
    if (!isalive(self)) {
        return false;
    }
    vehicle = self getvehicleoccupied();
    if (isdefined(vehicle)) {
        seat = vehicle getoccupantseat(self);
        if (isdefined(seat) && seat == 0) {
            return true;
        }
    }
    return false;
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0x720821ea, Offset: 0x3080
// Size: 0x95
function function_fddd6743(vehicle) {
    self endon(#"disconnect");
    self endon(#"exit_vehicle");
    while (true) {
        self waittill(#"change_seat", vehicle, var_947b4ea3, var_fc8d1b62);
        isdriver = var_fc8d1b62 == 0;
        if (isdriver) {
            if (getdvarint("scr_veh_driversarehidden") != 0) {
                self ghost();
            }
            continue;
        }
        self show();
    }
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0x8a0eba03, Offset: 0x3120
// Size: 0x7a
function function_87a60a3(vehicle) {
    self endon(#"disconnect");
    self waittill(#"exit_vehicle");
    currentweapon = self getcurrentweapon();
    if (self.lastweapon != currentweapon && self.lastweapon != level.weaponnone) {
        self switchtoweapon(self.lastweapon);
    }
    self show();
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xdebc234d, Offset: 0x31a8
// Size: 0x4e
function function_97ea4621() {
    return self.vehicletype == "sherman_mp" || self.vehicletype == "panzer4_mp" || self.vehicletype == "type97_mp" || self.vehicletype == "t34_mp";
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x8df5a986, Offset: 0x3200
// Size: 0xa2
function function_96630c9() {
    if (!isdefined(self.var_bb64fbd1)) {
        self.var_bb64fbd1 = spawnstruct();
    }
    if (isdefined(self.origin)) {
        self.var_bb64fbd1.origin = self.origin;
    }
    if (isdefined(self.angles)) {
        self.var_bb64fbd1.angles = self.angles;
    }
    if (isdefined(self.health)) {
        self.var_bb64fbd1.health = self.health;
    }
    self function_7a69e87b();
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xb78be852, Offset: 0x32b0
// Size: 0x1b
function function_29874ffe() {
    return getdvarint("scr_veh_explode_on_cleanup") != 0;
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x1210f3c3, Offset: 0x32d8
// Size: 0x2a
function function_53fc1461() {
    self function_2f2c0be3();
    self.var_ad627c79 = 1;
    self suicide();
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x8f772da9, Offset: 0x3310
// Size: 0xbd
function function_73cacc65() {
    self endon(#"hash_c0114f4e");
    self endon(#"death");
    self endon(#"delete");
    worldup = anglestoup((0, 90, 0));
    var_fecd0441 = 0;
    while (!var_fecd0441) {
        if (isdefined(self.angles)) {
            up = anglestoup(self.angles);
            dot = vectordot(up, worldup);
            if (dot <= 0) {
                var_fecd0441 = 1;
            }
        }
        if (!var_fecd0441) {
            wait 1;
        }
    }
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x5e647ed5, Offset: 0x33d8
// Size: 0x41
function function_766de9be() {
    self endon(#"hash_c0114f4e");
    self endon(#"death");
    self endon(#"delete");
    for (;;) {
        self waittill(#"veh_ejectoccupants");
        if (isdefined(level.var_4892cc47)) {
            [[ level.var_4892cc47 ]]();
        }
        wait 0.25;
    }
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x499d7906, Offset: 0x3428
// Size: 0x61
function function_cbd74bac() {
    occupants = self getvehoccupants();
    if (isdefined(occupants)) {
        for (i = 0; i < occupants.size; i++) {
            if (isdefined(occupants[i])) {
                occupants[i] unlink();
            }
        }
    }
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xb229d150, Offset: 0x3498
// Size: 0x9a
function function_4f6ab888() {
    self endon(#"hash_c0114f4e");
    self endon(#"death");
    self endon(#"delete");
    self function_73cacc65();
    seconds = randomfloatrange(5, 7);
    wait seconds;
    damageorigin = self.origin + (0, 0, 25);
    self finishvehicleradiusdamage(self, self, 32000, 32000, 32000, 0, "MOD_EXPLOSIVE", level.weaponnone, damageorigin, 400, -1, (0, 0, 1), 0);
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x24a56d2b, Offset: 0x3540
// Size: 0x12
function suicide() {
    self kill_vehicle(self);
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0x7700a3e, Offset: 0x3560
// Size: 0x5a
function kill_vehicle(attacker) {
    damageorigin = self.origin + (0, 0, 1);
    self finishvehicleradiusdamage(attacker, attacker, 32000, 32000, 10, 0, "MOD_EXPLOSIVE", level.weaponnone, damageorigin, 400, -1, (0, 0, 1), 0);
}

// Namespace vehicle
// Params 2, eflags: 0x0
// Checksum 0xea93d3b8, Offset: 0x35c8
// Size: 0x1e
function function_7061b539(var_2ec685a, default_value) {
    if (isdefined(var_2ec685a)) {
        return var_2ec685a;
    }
    return default_value;
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0x3d6cf1de, Offset: 0x35f0
// Size: 0x31a
function function_85f2d4fb(attacker) {
    var_682b7fc7 = self.origin;
    var_cf028029 = self.angles;
    var_6726cb47 = function_dd3249e9(self);
    var_96b43d6a = spawnstruct();
    var_96b43d6a.origin = self.var_bb64fbd1.origin;
    var_96b43d6a.angles = self.var_bb64fbd1.angles;
    var_96b43d6a.health = self.var_bb64fbd1.health;
    var_96b43d6a.targetname = function_7061b539(self.targetname, "");
    var_96b43d6a.vehicletype = function_7061b539(self.vehicletype, "");
    var_96b43d6a.destructibledef = self.destructibledef;
    var_255b9567 = !isdefined(self.var_ad627c79);
    if (var_255b9567 || function_29874ffe()) {
        function_fe3ad775(var_682b7fc7);
        if (var_255b9567 && getdvarint("scr_veh_explosion_doradiusdamage") != 0) {
            explosionradius = getdvarint("scr_veh_explosion_radius");
            var_36e7219d = getdvarint("scr_veh_explosion_mindamage");
            var_214136eb = getdvarint("scr_veh_explosion_maxdamage");
            self kill_vehicle(attacker);
            self radiusdamage(var_682b7fc7, explosionradius, var_214136eb, var_36e7219d, attacker, "MOD_EXPLOSIVE", getweapon(self.vehicletype + "_explosion"));
        }
    }
    self notify(#"hash_c0114f4e");
    var_29c28b63 = 1;
    if (var_255b9567 && getdvarint("scr_veh_ondeath_createhusk") != 0) {
        if (getdvarint("scr_veh_ondeath_usevehicleashusk") != 0) {
            husk = self;
            self.is_husk = 1;
        } else {
            husk = function_66148c1f(var_682b7fc7, var_cf028029, self.vehmodel);
        }
        husk function_811ba2ba(var_6726cb47, var_96b43d6a);
        if (getdvarint("scr_veh_respawnafterhuskcleanup") != 0) {
            var_29c28b63 = 0;
        }
    }
    if (!isdefined(self.is_husk)) {
        self function_9294a2d2();
    }
    if (getdvarint("scr_veh_disablerespawn") != 0) {
        var_29c28b63 = 0;
    }
    if (var_29c28b63) {
        function_da95f656(var_96b43d6a);
    }
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0x5a36e99d, Offset: 0x3918
// Size: 0x1aa
function function_da95f656(var_96b43d6a) {
    mintime = getdvarint("scr_veh_respawntimemin");
    maxtime = getdvarint("scr_veh_respawntimemax");
    seconds = randomfloatrange(mintime, maxtime);
    wait seconds;
    function_db15022(var_96b43d6a.origin);
    if (!function_bd1ad094()) {
        /#
            iprintln("<dev string:x9f>");
        #/
        return;
    }
    if (isdefined(var_96b43d6a.destructibledef)) {
        vehicle = spawnvehicle(var_96b43d6a.vehicletype, var_96b43d6a.origin, var_96b43d6a.angles, var_96b43d6a.targetname, var_96b43d6a.destructibledef);
    } else {
        vehicle = spawnvehicle(var_96b43d6a.vehicletype, var_96b43d6a.origin, var_96b43d6a.angles, var_96b43d6a.targetname);
    }
    vehicle.vehicletype = var_96b43d6a.vehicletype;
    vehicle.destructibledef = var_96b43d6a.destructibledef;
    vehicle.health = var_96b43d6a.health;
    vehicle init_vehicle();
    vehicle function_fc65ded8(var_96b43d6a.origin);
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x610c1e91, Offset: 0x3ad0
// Size: 0x55
function function_9294a2d2() {
    self notify(#"removed");
    if (isdefined(self.var_19ac5a79)) {
        if (!isdefined(self.var_6526927c)) {
            self.var_6526927c = 1;
            self thread function_c372b430();
        }
        return 0;
    }
    self function_ae45d625();
    return 1;
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xb791b19c, Offset: 0x3b30
// Size: 0x12
function function_ae45d625() {
    /#
    #/
    self delete();
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x9566519c, Offset: 0x3b50
// Size: 0x53
function function_c372b430() {
    var_5dbea6ec = (self.origin[0], self.origin[1], self.origin[2] - 10000);
    self.origin = var_5dbea6ec;
    wait 0.1;
    self hide();
    self notify(#"hash_5a8ded57");
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x7deed1b9, Offset: 0x3bb0
// Size: 0x213
function function_2f2c0be3() {
    var_baa4306c = getdvarint("scr_veh_disappear_maxpreventdistancefeet");
    var_8193c675 = getdvarint("scr_veh_disappear_maxpreventvisibilityfeet");
    var_14621b80 = -112 * var_baa4306c * var_baa4306c;
    var_4f2accc1 = -112 * var_8193c675 * var_8193c675;
    var_1d3aea38 = getdvarfloat("scr_veh_disappear_maxwaittime");
    var_fb92acf8 = 1;
    for (var_b5d2021c = 0; var_b5d2021c < var_1d3aea38; var_b5d2021c += var_fb92acf8) {
        var_9fb66d33 = util::function_1edbd8();
        var_128322a4 = 1;
        for (j = 0; j < var_9fb66d33.a.size && var_128322a4; j++) {
            player = var_9fb66d33.a[j];
            var_df3426ad = distancesquared(self.origin, player.origin);
            if (var_df3426ad < var_14621b80) {
                self function_5754ab8b("(" + var_1d3aea38 - var_b5d2021c + "s) Player too close: " + var_df3426ad + "<" + var_14621b80);
                var_128322a4 = 0;
                continue;
            }
            if (var_df3426ad < var_4f2accc1) {
                var_ec00a4e0 = self sightconetrace(player.origin, player, anglestoforward(player.angles));
                if (var_ec00a4e0 > 0) {
                    self function_5754ab8b("(" + var_1d3aea38 - var_b5d2021c + "s) Player can see");
                    var_128322a4 = 0;
                }
            }
        }
        if (var_128322a4) {
            return;
        }
        wait var_fb92acf8;
    }
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0xc822cc55, Offset: 0x3dd0
// Size: 0x7f
function function_db15022(position) {
    var_ca01c20d = getdvarint("scr_veh_respawnwait_maxiterations");
    var_fb92acf8 = getdvarint("scr_veh_respawnwait_iterationwaitseconds");
    for (i = 0; i < var_ca01c20d; i++) {
        if (!function_cd2a44a9(position)) {
            return;
        }
        wait var_fb92acf8;
    }
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0x29b77a50, Offset: 0x3e58
// Size: 0x70
function function_cd2a44a9(position) {
    var_9fb66d33 = util::function_1edbd8();
    for (i = 0; i < var_9fb66d33.a.size; i++) {
        if (var_9fb66d33.a[i] function_9ecf45b5(position)) {
            return true;
        }
    }
    return false;
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0xdb502966, Offset: 0x3ed0
// Size: 0xb9
function function_fc65ded8(position) {
    attacker = self;
    inflictor = self;
    var_9fb66d33 = util::function_1edbd8();
    for (i = 0; i < var_9fb66d33.a.size; i++) {
        player = var_9fb66d33.a[i];
        if (player function_9ecf45b5(position)) {
            player dodamage(20000, player.origin + (0, 0, 1), attacker, inflictor, "none");
        }
    }
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0xc7d42ae7, Offset: 0x3f98
// Size: 0x51
function function_9ecf45b5(position) {
    distanceinches = -16;
    var_da0c53a7 = distanceinches * distanceinches;
    var_df3426ad = distancesquared(self.origin, position);
    return var_df3426ad < var_da0c53a7;
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x5d78f971, Offset: 0x3ff8
// Size: 0x32
function function_521b9c81() {
    self endon(#"delete");
    self waittill(#"death", attacker);
    if (isdefined(self)) {
        self function_85f2d4fb(attacker);
    }
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xb2fc1848, Offset: 0x4038
// Size: 0x1a
function function_5c667b0c() {
    self playsound("car_explo_large");
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xa53e502c, Offset: 0x4060
// Size: 0x1a3
function function_df2e8ee8() {
    self endon(#"delete");
    self endon(#"removed");
    for (;;) {
        self waittill(#"damage", damage, attacker);
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            if (!isalive(players[i])) {
                continue;
            }
            vehicle = players[i] getvehicleoccupied();
            if (isdefined(vehicle) && self == vehicle && players[i] player_is_driver()) {
                if (damage > 0) {
                    earthquake(damage / 400, 1, players[i].origin, 512, players[i]);
                }
                if (damage > 100) {
                    println("<dev string:x109>");
                    players[i] playrumbleonentity("tank_damage_heavy_mp");
                    continue;
                }
                if (damage > 10) {
                    println("<dev string:x11f>");
                    players[i] playrumbleonentity("tank_damage_light_mp");
                }
            }
        }
        update_damage_effects(self, attacker);
        if (self.health <= 0) {
            return;
        }
    }
}

// Namespace vehicle
// Params 3, eflags: 0x0
// Checksum 0x3ed9bcbf, Offset: 0x4210
// Size: 0x7c
function function_66148c1f(origin, angles, modelname) {
    husk = spawn("script_model", origin);
    husk.angles = angles;
    husk setmodel(modelname);
    husk.health = 1;
    husk setcandamage(0);
    return husk;
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x4f984c1c, Offset: 0x4298
// Size: 0xa
function is_vehicle() {
    return isdefined(self.vehicletype);
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0x4cb15f1f, Offset: 0x42b0
// Size: 0x42
function function_b0e63d6() {
    if (isdefined(self.vehicletype)) {
        var_54c338d8 = level.var_16bc4847[self.vehicletype];
        if (isdefined(var_54c338d8)) {
            self setmodel(var_54c338d8);
        }
    }
}

// Namespace vehicle
// Params 2, eflags: 0x0
// Checksum 0x911bdfea, Offset: 0x4300
// Size: 0x20a
function function_811ba2ba(var_6726cb47, var_96b43d6a) {
    self function_b0e63d6();
    effects = level.var_d8c8ff6d[var_6726cb47];
    self function_bd0af061(effects);
    self.var_96b43d6a = var_96b43d6a;
    forcepointvariance = getdvarint("scr_veh_explosion_husk_forcepointvariance");
    var_b11fa976 = getdvarint("scr_veh_explosion_husk_horzvelocityvariance");
    vertvelocitymin = getdvarint("scr_veh_explosion_husk_vertvelocitymin");
    vertvelocitymax = getdvarint("scr_veh_explosion_husk_vertvelocitymax");
    forcepointx = randomfloatrange(0 - forcepointvariance, forcepointvariance);
    forcepointy = randomfloatrange(0 - forcepointvariance, forcepointvariance);
    forcepoint = (forcepointx, forcepointy, 0);
    forcepoint += self.origin;
    var_b2575892 = randomfloatrange(0 - var_b11fa976, var_b11fa976);
    var_d859d2fb = randomfloatrange(0 - var_b11fa976, var_b11fa976);
    initialvelocityz = randomfloatrange(vertvelocitymin, vertvelocitymax);
    initialvelocity = (var_b2575892, var_d859d2fb, initialvelocityz);
    if (self is_vehicle()) {
        self launchvehicle(initialvelocity, forcepoint);
    } else {
        self physicslaunch(forcepoint, initialvelocity);
    }
    self thread function_e072fd92();
    /#
        self thread function_47d6caa6();
    #/
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xc50eb7b7, Offset: 0x4518
// Size: 0x62
function function_e072fd92() {
    self endon(#"death");
    self endon(#"delete");
    self endon(#"hash_5a8ded57");
    var_96b43d6a = self.var_96b43d6a;
    self function_e6f48d52("Husk Cleanup Test");
    self function_2f2c0be3();
    self thread function_814331c1(var_96b43d6a);
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0x18b1f15e, Offset: 0x4588
// Size: 0x62
function function_814331c1(var_96b43d6a) {
    self function_f7a07937();
    if (getdvarint("scr_veh_respawnafterhuskcleanup") != 0) {
        if (getdvarint("scr_veh_disablerespawn") == 0) {
            function_da95f656(var_96b43d6a);
        }
    }
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xc8b4b439, Offset: 0x45f8
// Size: 0x4d
function function_f7a07937() {
    self function_fe3ad775(self.origin);
    if (self is_vehicle()) {
        return self function_9294a2d2();
    }
    self function_ae45d625();
    return 1;
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0x33a6f99b, Offset: 0x4650
// Size: 0xc2
function function_fe3ad775(origin) {
    if (getdvarint("scr_veh_explosion_spawnfx") == 0) {
        return;
    }
    if (isdefined(level.var_654c5e35)) {
        forward = (0, 0, 1);
        rot = randomfloat(360);
        up = (cos(rot), sin(rot), 0);
        playfx(level.var_654c5e35, origin, forward, up);
    }
    thread function_e6027917("vehicle_explo", origin);
}

// Namespace vehicle
// Params 2, eflags: 0x0
// Checksum 0xab62430c, Offset: 0x4720
// Size: 0x7a
function function_e6027917(var_bbc0fbf0, origin) {
    org = spawn("script_origin", origin);
    org.origin = origin;
    org playsoundwithnotify(var_bbc0fbf0, "sounddone");
    org waittill(#"sounddone");
    org delete();
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xb574836, Offset: 0x47a8
// Size: 0xb
function function_29aa20ce() {
    self notify(#"hash_a2ded463");
}

// Namespace vehicle
// Params 0, eflags: 0x0
// Checksum 0xe9c07cd6, Offset: 0x47c0
// Size: 0x2
function function_8da271e5() {
    
}

// Namespace vehicle
// Params 1, eflags: 0x0
// Checksum 0xeae80b74, Offset: 0x47d0
// Size: 0x103
function follow_path(node) {
    self endon(#"death");
    assert(isdefined(node), "<dev string:x135>");
    self notify(#"newpath");
    if (isdefined(node)) {
        self.attachedpath = node;
    }
    pathstart = self.attachedpath;
    self.currentnode = self.attachedpath;
    if (!isdefined(pathstart)) {
        return;
    }
    self attachpath(pathstart);
    self startpath();
    self endon(#"newpath");
    nextpoint = pathstart;
    while (isdefined(nextpoint)) {
        self waittill(#"reached_node", nextpoint);
        self.currentnode = nextpoint;
        nextpoint notify(#"trigger", self);
        if (isdefined(nextpoint.script_noteworthy)) {
            self notify(nextpoint.script_noteworthy);
            self notify(#"noteworthy", nextpoint.script_noteworthy, nextpoint);
        }
        waittillframeend();
    }
}

