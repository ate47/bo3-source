#using scripts/codescripts/struct;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_quadtank_util;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_zurich_coalescence_sound;
#using scripts/cp/cp_mi_zurich_coalescence_util;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_city;
#using scripts/cp/cp_mi_zurich_coalescence_zurich_hq;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/cp/gametypes/coop;
#using scripts/shared/_oob;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_quadtank;
#using scripts/shared/vehicles/_siegebot;

#namespace namespace_ca56958;

// Namespace namespace_ca56958
// Params 2, eflags: 0x0
// Checksum 0x689b5290, Offset: 0x1920
// Size: 0xf0c
function function_9c1fc2fd(str_objective, var_74cd64bc) {
    level flag::init("plaza_battle_hq_entrance_door_hacked");
    level flag::init("blast_doors_opened");
    level flag::init("plaza_battle_approach_reached");
    level flag::init("plaza_battle_blast_door_left" + "_opened");
    level flag::init("plaza_battle_blast_door_right" + "_opened");
    level flag::init("plaza_battle_blast_door_left" + "_ready");
    level flag::init("plaza_battle_blast_door_right" + "_ready");
    level flag::init("plaza_battle_exit_cleared");
    level flag::init("plaza_battle_front_defenses_broken");
    level flag::init("plaza_battle_hunter_destroyed");
    level flag::init("plaza_battle_intro_artillery_in_position");
    level flag::init("plaza_battle_intro_artillery_objective_start");
    level flag::init("plaza_battle_kane_enter_ready");
    level flag::init("plaza_battle_objective_started");
    level flag::init("plaza_boss_dead");
    level flag::init("plaza_battle_vtol_drop_crew_completed");
    level flag::init("plaza_battle_intro_battle_start");
    /#
        level.var_d21daa68 = 0;
    #/
    /#
        level thread function_65cbc694();
    #/
    level thread function_ad90c3f4();
    callback::on_spawned(&on_player_spawned);
    callback::on_actor_damage(&on_actor_damage);
    /#
        callback::on_actor_killed(&on_actor_killed);
    #/
    /#
        callback::on_vehicle_killed(&on_vehicle_killed);
    #/
    spawner::add_spawn_function_group("plaza_battle_artillery", "targetname", &function_29fa5d37);
    spawner::add_spawn_function_group("plaza_battle_intro_allies", "script_aigroup", &function_2b6c19a4);
    spawner::add_spawn_function_group("plaza_battle_reinforcements", "script_noteworthy", &function_f474e246);
    spawner::add_spawn_function_group("plaza_battle_siegebot", "script_noteworthy", &function_1dbc4cbb);
    spawner::add_spawn_function_group("plaza_battle_vehicle_ai_splined_entry", "script_noteworthy", &function_c89b08c9);
    spawner::add_spawn_function_group("plaza_vtol_robots", "targetname", &function_f474e246);
    spawner::add_spawn_function_group("robot_phalanx", "script_noteworthy", &function_4a1261ef);
    if (var_74cd64bc) {
        load::function_73adcefc();
        zurich_util::function_da579a5d(str_objective, 1);
        spawner::add_spawn_function_group("plaza_battle_boss", "targetname", &function_8fdd138);
        spawner::add_spawn_function_group("plaza_battle_alliies", "targetname", &function_adfa2b54);
        spawn_manager::enable("plaza_battle_allies_left_spawn_manager");
        spawn_manager::enable("plaza_battle_allies_right_spawn_manager");
        level.var_438d2fd9 = [];
        level.ai_boss = spawner::simple_spawn_single("plaza_battle_boss");
        exploder::exploder("streets_tower_wasp_swarm");
        level clientfield::set("zurich_city_ambience", 1);
        scene::add_scene_func("p7_fxanim_cp_zurich_coalescence_tower_door_open_bundle", &zurich_util::function_162b9ea0, "init");
        level scene::init("p7_fxanim_cp_zurich_coalescence_tower_door_open_bundle");
        load::function_a2995f22();
    } else {
        array::thread_all(level.activeplayers, &function_e204c270);
        array::thread_all(level.activeplayers, &function_424191b5);
    }
    hidemiscmodels("hq_entry_panel_hacked");
    if (isdefined(level.var_c50fbb10)) {
        level thread [[ level.var_c50fbb10 ]]();
    }
    level thread function_51e389ee(var_74cd64bc);
    level thread function_e0828083();
    level thread function_5e886797();
    level thread function_d9c927f6();
    level thread function_9590c294(var_74cd64bc);
    var_b8f9a884 = spawner::simple_spawn_single("plaza_battle_turret", &function_5268b119);
    level thread zurich_util::function_2361541e("plaza_battle");
    trigger::wait_till("plaza_battle_spawn_trig", undefined, undefined, 0);
    level thread namespace_67110270::function_228c7b0f();
    var_f7e53696 = getentarray("plaza_battle_intro_car_destroy_damagetrig", "targetname");
    array::thread_all(var_f7e53696, &function_a2b45d70);
    scene::add_scene_func("cin_zur_04_01_ext_vign_lockdown", &function_87ebab3e, "init");
    level scene::init("cin_zur_04_01_ext_vign_lockdown");
    battlechatter::function_d9f49fba(1);
    zurich_util::function_1b3dfa61("plaza_battle_train_exit_breadcrumb_struct_trig", undefined, -76, 1000);
    level flag::set("plaza_battle_approach_reached");
    savegame::checkpoint_save();
    level flag::wait_till("plaza_battle_intro_reached");
    level notify(#"rails_ambient_cleanup");
    umbragate_set("garage_umbra_gate", 0);
    trigger::wait_till("plaza_battle_midpoint_trig", undefined, undefined, 0);
    var_f7e53696 = getentarray("plaza_battle_intro_car_destroy_damagetrig", "targetname");
    array::delete_all(var_f7e53696);
    var_c4a1b346 = getent("garage_cleanup_trig", "targetname");
    var_c4a1b346 delete();
    level flag::wait_till_all(array("plaza_boss_dead", "plaza_battle_hunter_destroyed", "plaza_battle_intro_artillery_destroyed"));
    level flag::set("plaza_battle_cleared");
    level thread namespace_67110270::function_973b77f9();
    var_5cca3f31 = getent("plaza_battle_blast_door_open_trig", "targetname");
    var_5cca3f31 zurich_util::function_d1996775();
    showmiscmodels("hq_entry_panel_hacked");
    hidemiscmodels("hq_entry_panel");
    level flag::set("plaza_battle_hq_entrance_door_hacked");
    function_bc249f36();
    level flag::set("blast_doors_opened");
    trigger::wait_till("plaza_battle_enter_hq_gathertrig", undefined, level.var_3d556bcd);
    level thread namespace_67110270::function_ce97ecac();
    function_59999862();
    a_ai = getaiteamarray("axis", "allies");
    foreach (ai in a_ai) {
        if (!ai util::is_hero()) {
            ai delete();
        }
    }
    array::run_all(getcorpsearray(), &delete);
    level.ai_boss = undefined;
    level.var_e651620c = undefined;
    level.var_438d2fd9 = undefined;
    level.var_782205f8 = undefined;
    foreach (e_player in level.players) {
        e_player.var_33edeabe = 1;
    }
    foreach (e_player in level.activeplayers) {
        e_player util::player_frost_breath(0);
    }
    level notify(#"hash_73e5a63e");
    callback::remove_on_spawned(&on_player_spawned);
    callback::remove_on_actor_damage(&on_actor_damage);
    callback::remove_on_ai_spawned(&on_ai_spawned);
    /#
        callback::remove_on_actor_killed(&on_actor_killed);
    #/
    /#
        callback::remove_on_vehicle_killed(&on_vehicle_killed);
    #/
    /#
        level.var_d21daa68 = undefined;
    #/
    var_62e3398b = getspawnerarray("robot_phalanx", "script_noteworthy");
    array::thread_all(var_62e3398b, &spawner::remove_spawn_function, &function_4a1261ef);
    var_bf9f9fb8 = getspawnerarray("plaza_battle_boss", "targetname");
    array::thread_all(var_bf9f9fb8, &spawner::remove_spawn_function, &function_8fdd138);
    level clientfield::set("zurich_city_ambience", 0);
    level.var_3d556bcd thread zurich_util::function_4fb68dd5();
    array::thread_all(level.activeplayers, &function_cb30d060);
    skipto::function_be8adfb8(str_objective);
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x1a4228e4, Offset: 0x2838
// Size: 0xb8
function function_ad90c3f4() {
    level.var_a2319815 = spawn("trigger_box", (-5899, 34022, -4191), 0, 8000, 8000, 8000);
    level.var_a2319815 endon(#"death");
    ent = undefined;
    while (true) {
        level.var_a2319815 waittill(#"trigger", ent);
        if (isai(ent)) {
            ent kill();
        }
    }
}

// Namespace namespace_ca56958
// Params 4, eflags: 0x0
// Checksum 0x1c31b5f6, Offset: 0x28f8
// Size: 0x16c
function function_1a4dfaaa(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    zurich_util::function_4d032f25(0);
    if (!var_74cd64bc) {
        level.var_3d556bcd thread zurich_util::function_fe5160df(0);
    }
    level zurich_util::player_weather(0);
    level thread zurich_util::function_4a00a473("plaza_battle");
    if (var_74cd64bc) {
        objectives::complete("cp_level_zurich_assault_hq_obj");
        objectives::complete("cp_level_zurich_enter_hq_destroy_aspc_obj");
        objectives::complete("cp_level_zurich_enter_hq_destroy_hunter_obj");
        objectives::complete("cp_level_zurich_enter_hq_destroy_aspml_obj");
        objectives::complete("cp_level_zurich_enter_hq_awaiting_obj");
        objectives::complete("cp_level_zurich_enter_hq_hack_obj");
        objectives::complete("cp_level_zurich_enter_hq_obj");
    }
    if (isdefined(level.var_a2319815)) {
        level.var_a2319815 delete();
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xf1f896ea, Offset: 0x2a70
// Size: 0xd4
function function_5ea42950() {
    level flag::wait_till_any(array("plaza_battle_intro_artillery_destroyed", "plaza_boss_dead"));
    nd_spline = getvehiclenode("plaza_battle_hunter_combat_spline", "targetname");
    var_782205f8 = spawner::simple_spawn_single("zurich_ambient_hunter", &function_c89b08c9, nd_spline);
    var_782205f8 waittill(#"death");
    level flag::set("plaza_battle_hunter_destroyed");
    savegame::checkpoint_save();
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xf92b9a50, Offset: 0x2b50
// Size: 0xf0
function function_e204c270() {
    self endon(#"death");
    self notify(#"hash_1f15947d");
    self endon(#"hash_1f15947d");
    level endon(#"plaza_battle_cleared");
    do {
        self waittill(#"weapon_change_complete", var_81ad4fd7);
    } while (!(isdefined(var_81ad4fd7.isheroweapon) && var_81ad4fd7.isheroweapon));
    self waittill(#"weapon_change_complete");
    while (!(isdefined(self.var_a2168b36) && self.var_a2168b36)) {
        self coop::function_e9f7384d();
        level util::waittill_any("trophy_system_disabled", "trophy_system_destroyed");
        self thread function_2df89aaf();
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x8fa4dacc, Offset: 0x2c48
// Size: 0xae
function function_2df89aaf() {
    self notify(#"hash_87667d63");
    self endon(#"hash_87667d63");
    self endon(#"hash_1f15947d");
    level endon(#"plaza_battle_cleared");
    while (!(isdefined(self.var_a2168b36) && self.var_a2168b36)) {
        self waittill(#"weapon_change_complete", var_81ad4fd7);
        if (isdefined(var_81ad4fd7.isheroweapon) && var_81ad4fd7.isheroweapon) {
            self.var_a2168b36 = 1;
            self notify(#"hash_1f15947d");
        }
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x9c7d2953, Offset: 0x2d00
// Size: 0x4c
function on_player_spawned() {
    self thread function_2e5e657b();
    self function_424191b5();
    self function_e204c270();
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x71498006, Offset: 0x2d58
// Size: 0x160
function function_2e5e657b() {
    level endon(#"plaza_battle_train_exit_reached");
    self endon(#"death");
    if (level flag::get("plaza_battle_train_exit_reached")) {
        return;
    }
    while (true) {
        self waittill(#"weapon_fired");
        var_b893746c = spawner::get_ai_group_ai("robot_phalanx");
        foreach (ai in var_b893746c) {
            var_b8f6e26f = self util::is_player_looking_at(ai geteye(), 0.98, 1, self);
            if (var_b8f6e26f && self util::is_ads()) {
                level flag::set("plaza_battle_intro_battle_start");
                return;
            }
        }
    }
}

/#

    // Namespace namespace_ca56958
    // Params 0, eflags: 0x0
    // Checksum 0x82cffe3d, Offset: 0x2ec0
    // Size: 0xa4
    function function_d32cd515() {
        var_90911853 = getweapon("<dev string:x28>");
        if (!self hasweapon(var_90911853)) {
            self giveweapon(var_90911853);
            self setweaponammoclip(var_90911853, var_90911853.clipsize);
            self givemaxammo(var_90911853);
        }
    }

#/

// Namespace namespace_ca56958
// Params 1, eflags: 0x0
// Checksum 0xea04e259, Offset: 0x2f70
// Size: 0x9c
function on_actor_damage(params) {
    if (level.players.size > 1 || !(self.archetype === "robot") || !isdefined(params.eattacker) || !params.eattacker util::is_hero()) {
        return;
    }
    self util::stop_magic_bullet_shield();
    self kill();
}

/#

    // Namespace namespace_ca56958
    // Params 1, eflags: 0x0
    // Checksum 0x362a840b, Offset: 0x3018
    // Size: 0x5c
    function on_actor_killed(s_params) {
        if (!(self.archetype === "<dev string:x3a>") || !isplayer(s_params.eattacker)) {
            return;
        }
        self function_2f458d44();
    }

    // Namespace namespace_ca56958
    // Params 1, eflags: 0x0
    // Checksum 0xdb28b8a8, Offset: 0x3080
    // Size: 0x44
    function on_vehicle_killed(s_params) {
        if (!isplayer(s_params.eattacker)) {
            return;
        }
        self function_2f458d44();
    }

    // Namespace namespace_ca56958
    // Params 0, eflags: 0x0
    // Checksum 0x10e7e4f1, Offset: 0x30d0
    // Size: 0x10
    function function_2f458d44() {
        level.var_d21daa68++;
    }

    // Namespace namespace_ca56958
    // Params 0, eflags: 0x0
    // Checksum 0x11f51707, Offset: 0x30e8
    // Size: 0x50
    function function_65cbc694() {
        level endon(#"plaza_battle_exit_cleared");
        while (isdefined(level.var_d21daa68)) {
            wait 4;
            iprintln("<dev string:x40>" + level.var_d21daa68);
        }
    }

#/

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xe9d56688, Offset: 0x3140
// Size: 0x64
function on_ai_spawned() {
    if (self.archetype === "robot") {
        if (!level flag::get("plaza_battle_cleared")) {
            self function_4e20543d();
            return;
        }
        self function_d297683e();
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x308603ee, Offset: 0x31b0
// Size: 0x104
function function_4e20543d() {
    self endon(#"death");
    n_base = 22;
    if (level flag::get("plaza_battle_hunter_destroyed")) {
        n_base = 40;
    }
    var_56f344e5 = zurich_util::function_411dc61b(n_base, 18);
    if (randomint(100) <= var_56f344e5) {
        self colors::disable();
    }
    wait 0.05;
    var_bd24b897 = zurich_util::function_411dc61b(10, 5);
    if (randomint(100) <= var_bd24b897) {
        self function_bca2e7();
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xe9d97408, Offset: 0x32c0
// Size: 0xd4
function function_bca2e7() {
    self.script_health = zurich_util::function_411dc61b(int(self.health * 8), int(self.health / 2));
    self colors::disable();
    self ai::set_behavior_attribute("rogue_control", "forced_level_3");
    self ai::set_behavior_attribute("rogue_control_speed", "sprint");
    self.team = "axis";
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xa52051f6, Offset: 0x33a0
// Size: 0x84
function function_d297683e() {
    self endon(#"death");
    self colors::disable();
    wait 0.05;
    n_chance = zurich_util::function_411dc61b(30, 25);
    if (randomint(100) <= n_chance) {
        self function_bca2e7();
    }
}

// Namespace namespace_ca56958
// Params 15, eflags: 0x0
// Checksum 0x9f034580, Offset: 0x3430
// Size: 0x318
function function_3b05fc1b(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(level.var_7ebc8836) && isai(eattacker)) {
        if (level.var_7ebc8836) {
            var_df4257db = zurich_util::function_411dc61b(5, -1);
            idamage = int(idamage * var_df4257db);
        } else if (!level.var_7ebc8836) {
            idamage = 0;
        }
    }
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

// Namespace namespace_ca56958
// Params 1, eflags: 0x0
// Checksum 0x5ff73cca, Offset: 0x3750
// Size: 0x34c
function function_51e389ee(var_74cd64bc) {
    if (var_74cd64bc) {
        objectives::set("cp_level_zurich_assault_hq_obj");
        objectives::set("cp_level_zurich_assault_hq_awaiting_obj");
        objectives::hide("cp_level_zurich_assault_hq_obj");
    }
    level flag::wait_till("plaza_battle_approach_reached");
    objectives::hide("cp_level_zurich_assault_hq_awaiting_obj");
    objectives::show("cp_level_zurich_assault_hq_obj");
    objectives::breadcrumb("plaza_battle_intro_breadcrumb_trig", "cp_waypoint_breadcrumb");
    objectives::complete("cp_level_zurich_assault_hq_obj");
    objectives::set("cp_level_zurich_enter_hq_awaiting_obj");
    level flag::set("plaza_battle_objective_started");
    level flag::wait_till_all(array("plaza_battle_objective_started", "plaza_battle_intro_artillery_objective_start"));
    if (isalive(level.var_e651620c)) {
        objectives::hide("cp_level_zurich_enter_hq_awaiting_obj");
        objectives::set("cp_level_zurich_enter_hq_destroy_aspc_obj", level.var_e651620c);
        level.var_e651620c waittill(#"death");
        objectives::complete("cp_level_zurich_enter_hq_destroy_aspc_obj");
        objectives::show("cp_level_zurich_enter_hq_awaiting_obj");
    }
    level flag::wait_till("plaza_battle_cleared");
    wait 0.05;
    objectives::complete("cp_level_zurich_enter_hq_awaiting_obj");
    objectives::set("cp_level_zurich_enter_hq_hack_obj");
    level flag::wait_till("plaza_battle_hq_entrance_door_hacked");
    objectives::complete("cp_level_zurich_enter_hq_hack_obj");
    objectives::set("cp_level_zurich_enter_hq_awaiting_obj");
    level flag::wait_till_all(array("plaza_battle_kane_enter_ready", "blast_doors_opened"));
    objectives::set("cp_level_zurich_enter_hq_obj");
    objectives::set("cp_waypoint_breadcrumb", struct::get("plaza_battle_hq_enter_gatherpoint"));
    trigger::wait_till("plaza_battle_enter_hq_gathertrig", undefined, level.var_3d556bcd);
    objectives::complete("cp_waypoint_breadcrumb");
    objectives::complete("cp_level_zurich_enter_hq_obj");
}

// Namespace namespace_ca56958
// Params 1, eflags: 0x0
// Checksum 0x9085dbdc, Offset: 0x3aa8
// Size: 0x74
function function_3dc6a02c(str_objective) {
    objectives::hide("cp_level_zurich_enter_hq_awaiting_obj");
    objectives::set(str_objective, self);
    self waittill(#"death");
    objectives::complete(str_objective);
    objectives::show("cp_level_zurich_enter_hq_awaiting_obj");
}

// Namespace namespace_ca56958
// Params 1, eflags: 0x0
// Checksum 0xce2b67d8, Offset: 0x3b28
// Size: 0x1e4
function function_87ebab3e(a_ents) {
    level endon(#"hash_1fc32e88");
    a_ents["plaza_battle_intro_guy"] endon(#"death");
    var_7b7786bb = struct::get("plaza_battle_intro_sitrep_trig_spot");
    a_ents["plaza_battle_intro_guy"].allowbattlechatter["bc"] = 0;
    a_ents["plaza_battle_intro_guy"] colors::disable();
    var_9de10fe3 = getnode("plaza_battle_intro_guy_node", "targetname");
    a_ents["plaza_battle_intro_guy"] setgoal(var_9de10fe3);
    t_trig = spawn("trigger_radius", var_7b7786bb.origin, 0, 2292.3, -128);
    t_trig.script_objective = "plaza_battle";
    t_trig waittill(#"trigger");
    t_trig delete();
    scene::add_scene_func("cin_zur_04_01_ext_vign_lockdown", &function_da51418e, "play");
    scene::add_scene_func("cin_zur_04_01_ext_vign_lockdown", &function_7c1c218, "done");
    level thread scene::play("cin_zur_04_01_ext_vign_lockdown");
}

// Namespace namespace_ca56958
// Params 1, eflags: 0x0
// Checksum 0x14c2f05, Offset: 0x3d18
// Size: 0x64
function function_da51418e(a_ents) {
    a_ents["plaza_battle_intro_guy"] waittill(#"hash_499164c7");
    level dialog::function_13b3b16a("plyr_we_ll_see_about_that_0");
    level flag::set("plaza_battle_intro_artillery_objective_start");
}

// Namespace namespace_ca56958
// Params 1, eflags: 0x0
// Checksum 0x7bea0002, Offset: 0x3d88
// Size: 0xa4
function function_7c1c218(a_ents) {
    level endon(#"hash_1fc32e88");
    a_ents["plaza_battle_intro_guy"] endon(#"death");
    a_ents["plaza_battle_intro_guy"].allowbattlechatter["bc"] = 1;
    level.var_e651620c util::waittill_any("trophy_system_disabled", "trophy_system_destroyed", "death");
    a_ents["plaza_battle_intro_guy"] colors::enable();
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xd3ad7a48, Offset: 0x3e38
// Size: 0x6c
function function_5e886797() {
    level flag::wait_till("blast_doors_opened");
    level dialog::function_13b3b16a("plyr_you_still_with_me_k_0", 1);
    level.var_3d556bcd dialog::say("kane_i_m_still_with_you_0", 1);
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x6300813d, Offset: 0x3eb0
// Size: 0xa4
function function_d9c927f6() {
    level flag::wait_till("plaza_battle_hunter_destroyed");
    level dialog::function_13b3b16a("plyr_i_don_t_know_if_you_1", 1);
    level dialog::function_13b3b16a("plyr_it_s_not_too_late_to_0", 1);
    level dialog::function_13b3b16a("plyr_give_yourself_up_and_0", 1);
    level dialog::function_13b3b16a("plyr_you_know_me_you_can_0", 1);
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x515d1086, Offset: 0x3f60
// Size: 0x7c
function function_e0828083() {
    level flag::wait_till("plaza_battle_intro_reached");
    level flag::wait_till("plaza_battle_hunter_destroyed");
    if (isalive(level.ai_boss)) {
    }
    level flag::set("plaza_battle_kane_enter_ready");
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xf589d884, Offset: 0x3fe8
// Size: 0x10
function function_c635bfa2() {
    self waittill(#"death");
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x90d87d07, Offset: 0x4000
// Size: 0x2c
function function_9b61634f() {
    self endon(#"death");
    level flag::wait_till("plaza_battle_intro_artillery_in_position");
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xffdc218e, Offset: 0x4038
// Size: 0x10
function function_d0b419ee() {
    self waittill(#"death");
}

// Namespace namespace_ca56958
// Params 1, eflags: 0x0
// Checksum 0xa7d68852, Offset: 0x4050
// Size: 0x204
function function_c89b08c9(var_9c1a7bea) {
    self endon(#"death");
    if (!isdefined(var_9c1a7bea)) {
        var_9c1a7bea = getvehiclenodearray(self.target, "targetname");
    }
    if (!isarray(var_9c1a7bea)) {
        var_9c1a7bea = array(var_9c1a7bea);
    }
    nd_start = array::random(var_9c1a7bea);
    self vehicle_ai::start_scripted();
    self ai::set_ignoreme(1);
    self disableaimassist();
    if (self.script_startstate === "off") {
        return;
    }
    self setignoreent(level.var_3d556bcd, 1);
    if (isdefined(self.script_int)) {
        self setspeed(self.script_int);
    }
    self thread function_f8f7624b();
    self vehicle::get_on_and_go_path(nd_start);
    self enableaimassist();
    self vehicle_ai::stop_scripted();
    if (self.scriptvehicletype === "wasp") {
        self function_68e4ea91();
    }
    self ai::set_ignoreme(0);
    if (self.scriptvehicletype === "hunter") {
        self function_6c61fe9e();
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x24647ac1, Offset: 0x4260
// Size: 0xfc
function function_29fa5d37() {
    level.var_e651620c = self;
    /#
        if (isgodmode(level.players[0])) {
            self.health = 1;
        }
    #/
    self setignoreent(level.var_3d556bcd, 1);
    self namespace_855113f3::function_35209d64();
    self thread function_9200bc02();
    self function_e1159e2b();
    savegame::checkpoint_save();
    level flag::set("plaza_battle_intro_artillery_destroyed");
    level flag::set("plaza_battle_intro_artillery_in_position");
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xe1084110, Offset: 0x4368
// Size: 0x64
function function_2b6c19a4() {
    self endon(#"death");
    if (level flag::get("plaza_battle_intro_artillery_destroyed") && !level flag::get("plaza_battle_hunter_destroyed")) {
        self util::magic_bullet_shield();
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xec55592f, Offset: 0x43d8
// Size: 0x74
function function_adfa2b54() {
    if (!level flag::get("plaza_battle_train_exit_reached")) {
        self util::magic_bullet_shield();
        level flag::wait_till("plaza_battle_train_exit_reached");
        self util::stop_magic_bullet_shield();
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xaacd3e1d, Offset: 0x4458
// Size: 0x6c
function function_1dbc4cbb() {
    self.overridevehicledamage = &function_3b05fc1b;
    if (!isdefined(self.script_string)) {
        return;
    }
    self thread function_9683c997();
    if (isalive(self)) {
        self function_7f39a78b();
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xe610020a, Offset: 0x44d0
// Size: 0x5c
function function_91ec82e3() {
    self waittill(#"death");
    var_e936de8b = spawner::get_ai_group_ai(self.script_aigroup);
    array::run_all(var_e936de8b, &function_155239af);
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xcb146e2c, Offset: 0x4538
// Size: 0xd0
function function_155239af() {
    n_health = self.health;
    switch (level.players.size) {
    case 1:
        n_health = int(self.health / 10);
        break;
    case 2:
        n_health = int(self.health / 4);
        break;
    default:
        return;
    }
    if (n_health > 0 && n_health < self.health) {
        self.health = n_health;
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xc99b12e0, Offset: 0x4610
// Size: 0x5b4
function function_9683c997() {
    str_door = self.script_string;
    var_e26726e5 = getent(str_door + "_top", "targetname");
    var_53fda872 = getent(str_door + "_mid", "targetname");
    var_3b8a22ab = getent(str_door + "_bot", "targetname");
    if (!isdefined(var_e26726e5) || !isdefined(var_53fda872) || !isdefined(var_3b8a22ab)) {
        return;
    }
    /#
        recordent(var_e26726e5);
    #/
    /#
        recordent(var_53fda872);
    #/
    /#
        recordent(var_3b8a22ab);
    #/
    t_oob = getent(str_door + "_oob_trig", "targetname");
    if (isdefined(t_oob)) {
        t_oob delete();
    }
    var_e26726e5 endon(#"death");
    var_53fda872 endon(#"death");
    var_3b8a22ab endon(#"death");
    level flag::clear(str_door + "_ready");
    function_558d9f8d(var_e26726e5, var_53fda872, var_3b8a22ab);
    level flag::set(str_door + "_opened");
    b_wait = 1;
    do {
        wait 2;
        a_ai = getaiteamarray("axis", "allies");
        a_ents = arraycombine(a_ai, level.activeplayers, 0, 0);
        a_ents = arraysortclosest(a_ents, var_e26726e5.origin, 1);
        foreach (e_ent in a_ents) {
            if (distance2dsquared(e_ent.origin, var_e26726e5.origin) > 512 * 512) {
                b_wait = 0;
            }
        }
    } while (b_wait);
    var_c0b90cf4 = getentarray("plaza_battle_siegebot", "script_noteworthy");
    foreach (var_2221060d in var_c0b90cf4) {
        if (vehicle::is_corpse(var_2221060d)) {
            if (distance2dsquared(var_2221060d.origin, var_e26726e5.origin) <= -56 * -56) {
                var_2221060d delete();
            }
        }
    }
    function_558d9f8d(var_e26726e5, var_53fda872, var_3b8a22ab, -48, -24, 0.3, 0);
    t_oob = zurich_util::function_3789d4db(str_door, "trigger_box", 512, 512, 512);
    t_oob.targetname = str_door + "_oob_trig";
    t_oob.script_objective = "plaza_battle";
    if (!isdefined(level.oob_triggers)) {
        level.oob_triggers = [];
    } else if (!isarray(level.oob_triggers)) {
        level.oob_triggers = array(level.oob_triggers);
    }
    level.oob_triggers[level.oob_triggers.size] = t_oob;
    t_oob thread oob::waitforplayertouch();
    level flag::set(str_door + "_ready");
}

// Namespace namespace_ca56958
// Params 7, eflags: 0x0
// Checksum 0xbfd78eea, Offset: 0x4bd0
// Size: 0x1cc
function function_558d9f8d(var_e26726e5, var_53fda872, var_3b8a22ab, n_dist, var_cc2fbac4, n_time, n_delay) {
    if (!isdefined(n_dist)) {
        n_dist = 48;
    }
    if (!isdefined(var_cc2fbac4)) {
        var_cc2fbac4 = 24;
    }
    if (!isdefined(n_time)) {
        n_time = 0.6;
    }
    if (!isdefined(n_delay)) {
        n_delay = 0.1;
    }
    var_e26726e5 playsound("evt_siegebot_door_open");
    var_3b8a22ab movez(n_dist, n_time);
    var_3b8a22ab waittill(#"movedone");
    var_3b8a22ab linkto(var_53fda872);
    wait n_delay;
    var_53fda872 movez(n_dist, n_time);
    var_53fda872 waittill(#"movedone");
    var_53fda872 linkto(var_e26726e5);
    wait n_delay;
    var_e26726e5 movez(n_dist + var_cc2fbac4, n_time);
    var_e26726e5 waittill(#"movedone");
    var_e26726e5 unlink();
    var_53fda872 unlink();
    var_3b8a22ab unlink();
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x508a6947, Offset: 0x4da8
// Size: 0x154
function function_8fdd138() {
    level.ai_boss = self;
    self.var_5330ac94 = util::spawn_model("tag_origin", self gettagorigin("tag_target_upper"), self gettagangles("tag_target_upper"));
    self.var_5330ac94 linkto(self, "tag_target_upper", (0, 0, 256));
    /#
        if (isgodmode(level.players[0])) {
            self.health = 1;
        }
    #/
    self thread function_9200bc02();
    self namespace_855113f3::function_35209d64();
    self function_695f38a7();
    self.var_5330ac94 delete();
    savegame::checkpoint_save();
    level flag::set("plaza_boss_dead");
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x3d68dab7, Offset: 0x4f08
// Size: 0xac
function function_9200bc02() {
    self waittill(#"death");
    var_2c3a4ffd = util::spawn_model("tag_origin", self gettagorigin("tag_driver"), self gettagangles("tag_driver"));
    var_2c3a4ffd clientfield::set("quadtank_raven_explosion", 1);
    wait 10;
    var_2c3a4ffd delete();
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xd1830023, Offset: 0x4fc0
// Size: 0x24
function function_f474e246() {
    if (isdefined(self.target)) {
        self function_4ac5ac5a();
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xe0e0eed3, Offset: 0x4ff0
// Size: 0xb4
function function_4ac5ac5a() {
    self endon(#"death");
    for (s_scene = struct::get(self.target, "targetname"); isdefined(s_scene); s_scene = struct::get(s_scene.target, "targetname")) {
        level scene::play(s_scene.targetname, "targetname", self);
        if (!isdefined(s_scene.target)) {
            break;
        }
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xb366c5f8, Offset: 0x50b0
// Size: 0x1cc
function function_b8380f70() {
    self.health = 100000;
    self.team = "axis";
    self.var_7a04481c = zurich_util::function_411dc61b(4000, 1000);
    self.var_90937e6 = struct::get_array("plaza_battle_vtol_crash_point");
    var_e62c1231 = spawn("trigger_radius", self.origin + (0, 0, -128), 0, 850, 400);
    var_e62c1231 enablelinkto();
    var_e62c1231 linkto(self);
    if (!isdefined(level.oob_triggers)) {
        level.oob_triggers = [];
    } else if (!isarray(level.oob_triggers)) {
        level.oob_triggers = array(level.oob_triggers);
    }
    level.oob_triggers[level.oob_triggers.size] = var_e62c1231;
    var_e62c1231 thread oob::waitforplayertouch();
    self thread vehicle::get_on_and_go_path(getvehiclenode(self.target, "targetname"));
    self function_fbbb5f09();
    var_e62c1231 delete();
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xe795e1fa, Offset: 0x5288
// Size: 0x1f8
function function_fbbb5f09() {
    self endon(#"death");
    while (true) {
        self waittill(#"damage", n_damage, e_attacker, _, _, str_damage_type);
        self.health += n_damage;
        var_a4a673a9 = str_damage_type == "MOD_PROJECTILE" || str_damage_type === "MOD_EXPLOSIVE";
        if (isplayer(e_attacker) && var_a4a673a9) {
            self.var_7a04481c -= n_damage;
        }
        if (self.var_7a04481c <= 0) {
            var_6c5bbb3f = array::random(self.var_90937e6);
            self vehicle::god_on();
            self vehicle::get_off_path();
            self setspeed(42, 18, 12);
            self setvehgoalpos(var_6c5bbb3f.origin);
            self waittill(#"goal");
            self vehicle::god_off();
            array::run_all(self.riders, &kill);
            self dodamage(self.health + 100, self.origin, e_attacker);
        }
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x7a9cf46c, Offset: 0x5488
// Size: 0x13c
function function_4a1261ef() {
    self endon(#"death");
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self util::magic_bullet_shield(self);
    level flag::wait_till_any(array("plaza_battle_intro_battle_start", "plaza_battle_train_exit_reached"));
    self ai::set_ignoreall(0);
    self ai::set_ignoreme(0);
    self util::stop_magic_bullet_shield(self);
    level flag::wait_till_timeout(5, "plaza_battle_intro_reached");
    self ai::set_behavior_attribute("phalanx", 0);
    self ai::set_behavior_attribute("move_mode", "rusher");
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xb635d1b1, Offset: 0x55d0
// Size: 0x1c
function function_5268b119() {
    self vehicle::god_on();
}

// Namespace namespace_ca56958
// Params 1, eflags: 0x0
// Checksum 0xdbe7ea94, Offset: 0x55f8
// Size: 0x11c
function function_9590c294(var_74cd64bc) {
    var_cdbd94b1 = "plaza_battle_front_left_phalanx";
    var_7680f4ba = "plaza_battle_front_right_phalanx";
    if (var_74cd64bc) {
        var_cdbd94b1 = "plaza_battle_front_left_phalanx_skipto";
        var_7680f4ba = "plaza_battle_front_right_phalanx_skipto";
    }
    spawn_manager::function_41cd3a68(25);
    level thread function_a9380c64(var_cdbd94b1);
    level thread function_68fbe95d(var_7680f4ba);
    level.var_3d556bcd thread function_9d42d43b();
    function_e87739b();
    function_9c800460();
    function_c2827ec9();
    function_808ee2d6();
    function_a6915d3f();
    spawn_manager::function_41cd3a68(32);
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x71d9fa77, Offset: 0x5720
// Size: 0x2d4
function function_e87739b() {
    level.var_7ebc8836 = 0;
    trigger::use("plaza_battle_intro_allies_colortrig");
    var_bb164c73 = getentarray("plaza_battle_siegebot_back_spawn_trig", "targetname");
    foreach (t_spawn in var_bb164c73) {
        trigger::add_function(t_spawn, undefined, &function_55a7a759, var_bb164c73);
    }
    trigger::wait_till("plaza_battle_spawn_trig", undefined, undefined, 0);
    /#
        iprintln("<dev string:x48>");
    #/
    function_8f5c1780();
    spawn_manager::enable("plaza_battle_artillery_spawn_manager");
    var_ce8ca61d = zurich_util::function_b0dd51f4("plaza_battle_intro_back_enemy");
    level flag::wait_till_all(array("plaza_battle_reached", "plaza_battle_train_exit_reached"));
    var_edc6e0e1 = spawner::simple_spawn_single("plaza_vtol_back_nocrew", &function_b8380f70);
    trigger::use("plaza_battle_intro_axis_colortrig");
    zurich_util::function_2e1830eb("plaza_battle_robot_spawn_station_left", "plaza_battle");
    zurich_util::function_2e1830eb("plaza_battle_robot_spawn_station_right", "plaza_battle");
    zurich_util::function_2e1830eb("plaza_battle_robot_spawn_station_left2", "plaza_battle");
    zurich_util::function_2e1830eb("plaza_battle_robot_spawn_station_right2", "plaza_battle");
    level thread function_4ef26b6("plaza_battle_room_robot_spawn_vign_right", "spawn_right_room_charging_robot");
    level thread function_4ef26b6("plaza_battle_room_robot_spawn_vign_left", "spawn_left_room_charging_robot");
}

// Namespace namespace_ca56958
// Params 2, eflags: 0x0
// Checksum 0x7bcb31b0, Offset: 0x5a00
// Size: 0x114
function function_4ef26b6(str_scene, str_trigger) {
    level endon(#"hash_1fc32e88");
    trigger::wait_till(str_trigger, "script_noteworthy");
    var_ed98a51f = spawner::simple_spawn_single("sec_exploder", undefined, undefined, undefined, undefined, undefined, undefined, 1);
    v_pos = var_ed98a51f geteye();
    var_ed98a51f endon(#"death");
    level scene::init(str_scene, "targetname", var_ed98a51f);
    while (!var_ed98a51f zurich_util::player_can_see_me(406)) {
        wait 0.5;
    }
    level scene::play(str_scene, "targetname", var_ed98a51f);
}

// Namespace namespace_ca56958
// Params 1, eflags: 0x0
// Checksum 0x2cc26fa0, Offset: 0x5b20
// Size: 0xa2
function function_55a7a759(var_bb164c73) {
    wait 2;
    foreach (t_spawn in var_bb164c73) {
        if (!isdefined(t_spawn)) {
            break;
        }
        t_spawn trigger::use();
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x56b863c2, Offset: 0x5bd0
// Size: 0x2c4
function function_9c800460() {
    level flag::wait_till("plaza_battle_intro_artillery_in_position");
    /#
        iprintln("<dev string:x58>");
    #/
    spawn_manager::enable("plaza_battle_robot_left_spawn_manager");
    spawn_manager::enable("plaza_battle_robot_right_spawn_manager");
    callback::on_ai_spawned(&on_ai_spawned);
    level flag::wait_till("plaza_battle_intro_artillery_destroyed");
    a_ai_allies = spawner::get_ai_group_ai("plaza_battle_intro_allies");
    array::thread_all(a_ai_allies, &util::magic_bullet_shield);
    trigger::use("plaza_battle_intro_steps_allies_colortrig");
    trigger::use("plaza_battle_intro_steps_axis_colortrig");
    spawn_manager::kill("plaza_battle_robot_intro_left_spawn_manager", 1);
    spawn_manager::kill("plaza_battle_robot_intro_right_spawn_manager", 1);
    spawn_manager::function_41cd3a68(15);
    var_64e85e6d = getaispeciesarray("axis", "robot");
    foreach (ai in var_64e85e6d) {
        ai.overrideactordamage = &zurich_util::function_8ac3f026;
    }
    var_edc6e0e1 = spawner::simple_spawn_single("plaza_vtol_back", &function_b8380f70);
    level thread function_a30a9296();
    level flag::set("plaza_battle_vtol_drop_crew_completed");
    var_edc6e0e1 util::waittill_any("reached_end_node", "death");
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x3040c3cf, Offset: 0x5ea0
// Size: 0x44
function function_a30a9296() {
    level waittill(#"hash_594191c4");
    spawner::waittill_ai_group_ai_count("plaza_vtol_riders", 3);
    spawn_manager::function_41cd3a68(20);
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x6b8ebb60, Offset: 0x5ef0
// Size: 0x37c
function function_c2827ec9() {
    /#
        iprintln("<dev string:x6c>");
    #/
    level thread function_5ea42950();
    trigger::use("plaza_battle_center_allies_colortrig");
    trigger::use("plaza_battle_center_axis_colortrig");
    level flag::wait_till("plaza_battle_hunter_destroyed");
    level.var_7ebc8836 = 1;
    trigger::use("plaza_battle_center_hunter_colortrig");
    a_ai_allies = spawner::get_ai_group_ai("plaza_battle_intro_allies");
    array::thread_all(a_ai_allies, &util::stop_magic_bullet_shield);
    var_b1df9263 = zurich_util::function_411dc61b(1.5, -0.5);
    var_1c97712d = zurich_util::function_411dc61b(2, -0.5);
    level thread zurich_util::function_27904cd4("plaza_battle_robot_spawn_station_left", "plaza_battle", undefined, undefined, var_b1df9263, var_1c97712d);
    level thread zurich_util::function_27904cd4("plaza_battle_robot_spawn_station_right", "plaza_battle", undefined, undefined, var_b1df9263, var_1c97712d);
    level thread zurich_util::function_27904cd4("plaza_battle_robot_spawn_station_left2", "plaza_battle", undefined, undefined, var_b1df9263, var_1c97712d);
    level thread zurich_util::function_27904cd4("plaza_battle_robot_spawn_station_right2", "plaza_battle", undefined, undefined, var_b1df9263, var_1c97712d);
    level flag::wait_till_any(array("plaza_battle_blast_door_left" + "_opened", "plaza_battle_blast_door_right" + "_opened"));
    spawn_manager::disable("plaza_battle_robot_left_spawn_manager");
    spawn_manager::disable("plaza_battle_robot_right_spawn_manager");
    spawn_manager::enable("plaza_battle_robot_left_exit_spawn_manager");
    spawn_manager::enable("plaza_battle_robot_right_exit_spawn_manager");
    trigger::use("plaza_battle_buildings_allies_colortrig");
    level flag::wait_till_all(array("plaza_battle_blast_door_left" + "_opened", "plaza_battle_blast_door_right" + "_opened"));
    level thread function_68a21f36();
    function_781f3832();
    level.var_7ebc8836 = undefined;
    trigger::use("plaza_battle_boss_allies_colortrig");
    trigger::use("plaza_battle_boss_axis_colortrig");
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x4e309c04, Offset: 0x6278
// Size: 0x84
function function_781f3832() {
    wait 0.05;
    if (isdefined(10)) {
        __s = spawnstruct();
        __s endon(#"timeout");
        __s util::delay_notify(10, "timeout");
    }
    spawner::waittill_ai_group_ai_count("plaza_battle_back_siegebots", 1);
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xf5ef173d, Offset: 0x6308
// Size: 0x144
function function_68a21f36() {
    spawn_manager::kill("plaza_battle_allies_left_spawn_manager", 1);
    spawn_manager::kill("plaza_battle_allies_right_spawn_manager", 1);
    a_ai_allies = spawner::get_ai_group_ai("plaza_battle_intro_allies");
    foreach (ai in a_ai_allies) {
        self.overrideactordamage = &zurich_util::function_8ac3f026;
    }
    spawner::waittill_ai_group_ai_count("plaza_battle_intro_allies", 6);
    function_781f3832();
    spawn_manager::enable("plaza_battle_allies_left_center_spawn_manager");
    spawn_manager::enable("plaza_battle_allies_right_center_spawn_manager");
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xad363fa6, Offset: 0x6458
// Size: 0x13c
function function_808ee2d6() {
    level flag::wait_till("plaza_battle_cleared");
    /#
        iprintln("<dev string:x7d>");
    #/
    zurich_util::function_5b0d9c63("plaza_battle_robot_spawn_station_left");
    zurich_util::function_5b0d9c63("plaza_battle_robot_spawn_station_right");
    zurich_util::function_5b0d9c63("plaza_battle_robot_spawn_station_left2");
    zurich_util::function_5b0d9c63("plaza_battle_robot_spawn_station_right2");
    spawn_manager::enable("plaza_battle_robot_left_spawn_manager");
    spawn_manager::enable("plaza_battle_robot_right_spawn_manager");
    spawn_manager::enable("plaza_battle_robot_outro_left_spawn_manager");
    spawn_manager::enable("plaza_battle_robot_outro_right_spawn_manager");
    level thread function_b727abb6();
    spawn_manager::kill("plaza_battle_robot_center_spawn_manager", 1);
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x927d287f, Offset: 0x65a0
// Size: 0x1ac
function function_b727abb6() {
    level endon(#"plaza_battle_exit_cleared");
    wait 9;
    level thread function_3363e7dd();
    wait 21;
    spawn_manager::function_41cd3a68(8);
    var_b1df9263 = zurich_util::function_411dc61b(1, -0.2);
    var_1c97712d = zurich_util::function_411dc61b(1.5, -0.2);
    level thread zurich_util::function_27904cd4("plaza_battle_robot_spawn_station_left", "plaza_battle", undefined, undefined, var_b1df9263, var_1c97712d);
    level thread zurich_util::function_27904cd4("plaza_battle_robot_spawn_station_right", "plaza_battle", undefined, undefined, var_b1df9263, var_1c97712d);
    level thread zurich_util::function_27904cd4("plaza_battle_robot_spawn_station_left2", "plaza_battle", undefined, undefined, var_b1df9263, var_1c97712d);
    level thread zurich_util::function_27904cd4("plaza_battle_robot_spawn_station_right2", "plaza_battle", undefined, undefined, var_b1df9263, var_1c97712d);
    wait 24;
    level thread function_7e5ba0bd("plaza_battle_blast_door_left");
    level thread function_7e5ba0bd("plaza_battle_blast_door_right");
}

// Namespace namespace_ca56958
// Params 1, eflags: 0x0
// Checksum 0xfee4fb3a, Offset: 0x6758
// Size: 0x198
function function_7e5ba0bd(str_door) {
    level endon(#"plaza_battle_exit_cleared");
    while (true) {
        if (!level flag::get(str_door + "_ready")) {
            level flag::wait_till_clear(str_door + "_ready");
        }
        var_edad4a81 = getentarray(str_door, "script_string");
        foreach (var_c195d305 in var_edad4a81) {
            if (isspawner(var_c195d305)) {
                var_20331917 = var_c195d305;
            }
        }
        var_51a7831a = spawner::simple_spawn_single(var_20331917, undefined, undefined, undefined, undefined, undefined, undefined, 1);
        if (isalive(var_51a7831a)) {
            var_51a7831a waittill(#"death");
        }
        level flag::wait_till(str_door + "_ready");
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xccdbb00e, Offset: 0x68f8
// Size: 0x174
function function_3363e7dd() {
    level endon(#"plaza_battle_exit_cleared");
    var_8498e7d1 = array("plaza_vtol_front", "plaza_vtol_back");
    for (var_edc6e0e1 = spawner::simple_spawn_single("plaza_vtol_front", &function_b8380f70); true; var_edc6e0e1 = spawner::simple_spawn_single(array::random(var_8498e7d1), &function_b8380f70)) {
        var_edc6e0e1 waittill(#"death");
        wait randomfloatrange(8, 10);
        nd_spline = getvehiclenode("plaza_battle_hunter_combat_spline", "targetname");
        var_782205f8 = spawner::simple_spawn_single("zurich_ambient_hunter", &function_c89b08c9, nd_spline);
        var_782205f8 waittill(#"death");
        wait randomfloatrange(8, 10);
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xf37ffc7b, Offset: 0x6a78
// Size: 0x2c4
function function_a6915d3f() {
    level flag::wait_till("plaza_battle_hq_entrance_door_hacked");
    /#
        iprintln("<dev string:x8f>");
    #/
    level flag::wait_till("blast_doors_opened");
    spawn_manager::kill("plaza_battle_artillery_spawn_manager", 1);
    spawn_manager::kill("plaza_battle_allies_back_spawn_manager", 1);
    spawn_manager::kill("plaza_battle_allies_middle_spawn_manager", 1);
    spawn_manager::kill("plaza_battle_siegebot_right_middle_spawn_manager", 1);
    spawn_manager::kill("plaza_battle_siegebot_left_middle_spawn_manager", 1);
    var_edc6e0e1 = spawner::simple_spawn_single("plaza_vtol_back", &function_b8380f70);
    trigger::use("plaza_battle_facility_entrance_allies_colortrig");
    trigger::use("plaza_battle_facility_entrance_axis_colortrig");
    level flag::wait_till("plaza_battle_exit_cleared");
    spawn_manager::kill("plaza_battle_allies_left_center_spawn_manager");
    spawn_manager::kill("plaza_battle_allies_right_center_spawn_manager");
    spawn_manager::kill("plaza_battle_robot_left_exit_spawn_manager", 1);
    spawn_manager::kill("plaza_battle_robot_right_exit_spawn_manager", 1);
    spawn_manager::kill("plaza_battle_robot_outro_left_spawn_manager", 1);
    spawn_manager::kill("plaza_battle_robot_outro_right_spawn_manager", 1);
    spawn_manager::kill("plaza_battle_boss_wasp_spawn_manager");
    spawn_manager::kill("plaza_battle_boss_wasp_rocket_spawn_manager");
    spawn_manager::kill("plaza_battle_robot_left_spawn_manager", 1);
    spawn_manager::kill("plaza_battle_robot_right_spawn_manager", 1);
    spawn_manager::function_41cd3a68(32);
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xf0b436, Offset: 0x6d48
// Size: 0x54
function function_e111315c() {
    var_12e44341 = getentarray("plaza_battle_kane_choose_trig", "targetname");
    array::thread_all(var_12e44341, &function_f058728a, self);
}

// Namespace namespace_ca56958
// Params 1, eflags: 0x0
// Checksum 0x8e99d0e5, Offset: 0x6da8
// Size: 0xa4
function function_f058728a(var_3d556bcd) {
    self endon(#"death");
    level endon(#"plaza_battle_cleared");
    self waittill(#"trigger");
    var_3d556bcd colors::enable();
    var_3d556bcd colors::set_force_color(self.script_string);
    var_12e44341 = getentarray("plaza_battle_kane_choose_trig", "targetname");
    array::delete_all(var_12e44341);
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x285cb26d, Offset: 0x6e58
// Size: 0x1c4
function function_9d42d43b() {
    self endon(#"death");
    self pushplayer(1);
    self thread zurich_util::function_2a6e38e();
    level flag::wait_till("plaza_battle_approach_reached");
    self thread zurich_util::function_d0103e8d();
    self ai::set_ignoreall(0);
    level flag::wait_till("plaza_battle_intro_artillery_destroyed");
    self pushplayer(0);
    self function_e111315c();
    level flag::wait_till("plaza_battle_cleared");
    level.var_3d556bcd colors::disable();
    level.var_3d556bcd setgoal(getnode("plaza_battle_kane_door_node", "targetname"), 1);
    level flag::wait_till("blast_doors_opened");
    self zurich_util::function_121ba443();
    self setgoal(getnode("plaza_battle_kane_lobby_node", "targetname"), 1);
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xad2065e1, Offset: 0x7028
// Size: 0x21a
function function_17645f9b() {
    self endon(#"death");
    level endon(#"plaza_battle_cleared");
    var_c048597 = getnodearray("plaza_battle_kane_intro_node", "targetname");
    while (true) {
        e_player = arraygetclosest(self.origin, level.activeplayers);
        var_ebdbffd3 = randomfloatrange(1.2, 2.1);
        if (!isdefined(e_player)) {
            wait var_ebdbffd3;
            continue;
        }
        var_d031f937 = arraygetclosest(e_player.origin, var_c048597);
        if (!isdefined(var_d031f937)) {
            wait var_ebdbffd3;
            continue;
        }
        var_2b29ab06 = distancesquared(var_d031f937.origin, self.origin) > -128 * -128;
        var_7bc86f48 = distancesquared(e_player.origin, self.origin) > -66 * -66;
        if (!var_2b29ab06 && !var_7bc86f48) {
            wait var_ebdbffd3;
            continue;
        }
        if (!isdefined(getnodeowner(var_d031f937))) {
            self setgoal(var_d031f937, 0, -128);
            self waittill(#"goal");
        }
        wait var_ebdbffd3;
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x817eb1f7, Offset: 0x7250
// Size: 0xac
function function_aee0aa5d() {
    if (level.players.size > 2) {
        var_439371d = getspawnerarray("2_player_max", "script_string");
        array::run_all(var_439371d, &delete);
        return;
    }
    var_439371d = getspawnerarray("3_player_min", "script_string");
    array::run_all(var_439371d, &delete);
}

// Namespace namespace_ca56958
// Params 1, eflags: 0x0
// Checksum 0x6fc3807b, Offset: 0x7308
// Size: 0xc4
function function_a9380c64(var_cdbd94b1) {
    level endon(#"hash_1fc32e88");
    level thread zurich_util::function_e7fdcb95(var_cdbd94b1, "phanalx_wedge", 3, 1, 6, "plaza_battle_train_exit_reached", 1);
    level flag::wait_till_timeout(10, "plaza_battle_artillery_intro_stop");
    spawner::waittill_ai_group_ai_count("robot_phalanx", 4);
    level flag::set("plaza_battle_front_defenses_broken");
    spawn_manager::enable("plaza_battle_robot_intro_left_spawn_manager");
}

// Namespace namespace_ca56958
// Params 1, eflags: 0x0
// Checksum 0xdc06108f, Offset: 0x73d8
// Size: 0xc4
function function_68fbe95d(var_7680f4ba) {
    level endon(#"hash_1fc32e88");
    level thread zurich_util::function_e7fdcb95(var_7680f4ba, "phanalx_wedge", 3, 1, 7, "plaza_battle_train_exit_reached", 1);
    level flag::wait_till_timeout(10, "plaza_battle_artillery_intro_stop");
    spawner::waittill_ai_group_ai_count("robot_phalanx", 4);
    level flag::set("plaza_battle_front_defenses_broken");
    spawn_manager::enable("plaza_battle_robot_intro_right_spawn_manager");
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x2516c44e, Offset: 0x74a8
// Size: 0x2ac
function function_695f38a7() {
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    self setignoreent(level.var_3d556bcd, 1);
    self thread function_2686975a();
    self function_68cf1dc0();
    self thread function_d42cc4b0();
    self thread function_7d540ef1();
    self thread function_d1db5654();
    trigger::wait_till("plaza_battle_midpoint_trig", undefined, undefined, 0);
    if (!isalive(self)) {
        return;
    }
    self ai::set_ignoreall(0);
    level flag::wait_till("plaza_battle_hunter_destroyed");
    var_b3b33e02 = spawn_manager::function_423eae50("plaza_battle_boss_wasp_spawn_manager");
    var_8ba55d7b = spawn_manager::function_423eae50("plaza_battle_boss_wasp_spawn_manager");
    var_b3b33e02 = arraycombine(var_b3b33e02, var_8ba55d7b, 0, 0);
    array::thread_all(var_b3b33e02, &function_5a1e5a49);
    self thread function_3dc6a02c("cp_level_zurich_enter_hq_destroy_aspml_obj");
    if (isalive(self)) {
        self ai::set_ignoreme(0);
        self waittill(#"death");
    }
    var_b3b33e02 = spawn_manager::function_423eae50("plaza_battle_boss_wasp_spawn_manager");
    var_8ba55d7b = spawn_manager::function_423eae50("plaza_battle_boss_wasp_spawn_manager");
    var_b3b33e02 = arraycombine(var_b3b33e02, var_8ba55d7b, 0, 0);
    array::thread_all(var_b3b33e02, &function_c4b462a7);
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xf7708dc0, Offset: 0x7760
// Size: 0x18e
function function_2686975a() {
    self endon(#"death");
    var_2ef061f7 = getnodearray("plaza_battle_boss_patrol_node", "targetname");
    for (var_5576dc56 = undefined; true; var_5576dc56 = var_2ef061f7[var_2ef061f7.size - 1]) {
        do {
            var_2ef061f7 = array::randomize(var_2ef061f7);
            wait 0.05;
        } while (var_2ef061f7[0] === var_5576dc56);
        foreach (var_f2c09364 in var_2ef061f7) {
            self setgoal(var_f2c09364.origin, 0, randomfloatrange(96, -60));
            self waittill(#"near_goal");
            wait randomfloatrange(6, 8);
        }
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x1ddec30, Offset: 0x78f8
// Size: 0x284
function function_68cf1dc0() {
    level endon(#"hash_fbc32085");
    self endon(#"death");
    a_e_targets = [];
    a_s_targets = struct::get_array("plaza_battle_intro_boss_target_spots");
    foreach (n_index, var_1da6c387 in a_s_targets) {
        a_e_targets[n_index] = util::spawn_model("tag_origin", var_1da6c387.origin, var_1da6c387.angles);
        a_e_targets[n_index].script_objective = "plaza_battle";
        wait 0.05;
    }
    self setvehweapon(getweapon("quadtank_main_turret_rocketpods_javelin"));
    do {
        a_e_targets = array::randomize(a_e_targets);
        foreach (e_target in a_e_targets) {
            self setturrettargetent(e_target);
            self fireweapon(0, e_target);
            wait randomfloatrange(1, 1.4);
        }
    } while (!level flag::get("plaza_battle_intro_artillery_destroyed"));
    level util::delay(15, undefined, &array::delete_all, a_e_targets);
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x24168a2, Offset: 0x7b88
// Size: 0x160
function function_d42cc4b0() {
    self endon(#"death");
    while (true) {
        self ai::set_ignoreall(0);
        str_notify = self util::waittill_any_timeout(randomfloatrange(3, 5), "trophy_system_disabled", "trophy_system_destroyed", "damage");
        self ai::set_ignoreall(1);
        a_e_enemies = arraycopy(level.activeplayers);
        if (str_notify == "timeout") {
            a_ai_allies = getaiteamarray("allies");
            a_e_enemies = arraycombine(a_e_enemies, a_ai_allies, 0, 0);
        }
        a_e_enemies = array::randomize(a_e_enemies);
        self function_5aba74b(a_e_enemies);
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x7e4663cb, Offset: 0x7cf0
// Size: 0xb0
function function_58e04ffd() {
    self endon(#"death");
    level.ai_boss endon(#"death");
    while (true) {
        self util::waittill_any("trophy_system_disabled", "trophy_system_destroyed", "damage");
        a_e_enemies = arraycopy(level.activeplayers);
        a_e_enemies = array::randomize(a_e_enemies);
        level.ai_boss function_5aba74b(a_e_enemies);
    }
}

// Namespace namespace_ca56958
// Params 1, eflags: 0x0
// Checksum 0x44825c31, Offset: 0x7da8
// Size: 0x2ac
function function_5aba74b(a_e_enemies) {
    self endon(#"death");
    self endon(#"trophy_system_disabled");
    self endon(#"trophy_system_destroyed");
    var_c817078c = 0;
    self setvehweapon(getweapon("quadtank_main_turret_rocketpods_javelin"));
    foreach (e_target in a_e_enemies) {
        if (isalive(e_target) && !e_target util::is_hero()) {
            var_31362a8b = (randomintrange(256 * -1, 256), randomintrange(256 * -1, 256), randomintrange(256 * -1, 256));
            v_target_pos = e_target.origin + var_31362a8b;
            var_746111be = util::spawn_model("tag_origin", v_target_pos, e_target.angles);
            var_746111be.script_objective = "plaza_battle";
            self setturrettargetent(var_746111be);
            e_projectile = self fireweapon(0, var_746111be);
            e_projectile thread function_e15e7133(var_746111be);
            var_c817078c++;
            if (var_c817078c == 4) {
                break;
            }
            wait randomfloatrange(1, 1.4);
        }
    }
    self clearturrettarget();
}

// Namespace namespace_ca56958
// Params 1, eflags: 0x0
// Checksum 0x3dab030f, Offset: 0x8060
// Size: 0x2c
function function_e15e7133(e_target) {
    self waittill(#"death");
    e_target delete();
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x8fbfb038, Offset: 0x8098
// Size: 0x80
function function_7d540ef1() {
    self endon(#"death");
    var_b711578c = getweapon("quadtank_main_turret_rocketpods_javelin");
    while (true) {
        self waittill(#"weapon_fired", e_projectile);
        if (var_b711578c === e_projectile.item) {
            e_projectile thread javelin_think();
        }
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xcd6162f9, Offset: 0x8120
// Size: 0x1dc
function javelin_think() {
    e_target = self missile_gettarget();
    if (isdefined(self) && isdefined(e_target)) {
        if (isdefined(e_target.var_33edeabe) && e_target.var_33edeabe) {
        }
        if (e_target util::is_hero() || e_target.allowdeath === 0 || e_target.magic_bullet_shield === 1 || e_target.ignoreme === 1) {
            a_s_targets = struct::get_array("plaza_battle_intro_boss_target_spots");
            s_target = array::random(a_s_targets);
            var_746111be = util::spawn_model("tag_origin", s_target.origin, s_target.angles);
        } else if (isplayer(e_target)) {
            var_746111be = util::spawn_model("tag_origin", e_target.origin, e_target.angles);
        }
        if (isdefined(var_746111be)) {
            self missile_settarget(var_746111be);
            self waittill(#"death");
            var_746111be delete();
        }
    }
}

// Namespace namespace_ca56958
// Params 1, eflags: 0x0
// Checksum 0xe1fba901, Offset: 0x8308
// Size: 0x112
function function_336b6c3e(e_target) {
    n_radius_sq = 256 * 256;
    self function_71b5892a(e_target);
    if (isdefined(self) && isdefined(e_target)) {
        foreach (e_player in level.activeplayers) {
            if (distance2dsquared(e_player getorigin(), e_target getorigin()) <= n_radius_sq) {
            }
        }
    }
}

// Namespace namespace_ca56958
// Params 1, eflags: 0x0
// Checksum 0x759d812b, Offset: 0x8428
// Size: 0xa4
function function_71b5892a(e_target) {
    self endon(#"death");
    var_9633e6ca = 3000;
    while (isdefined(e_target)) {
        if (self getvelocity()[2] < -150 && distancesquared(self.origin, e_target getorigin()) < var_9633e6ca * var_9633e6ca) {
            break;
        }
        wait 0.1;
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x7a02b63d, Offset: 0x84d8
// Size: 0x364
function function_e1159e2b() {
    self endon(#"death");
    self flag::init("order_stop_fire");
    foreach (e_player in level.activeplayers) {
        self setignoreent(e_player, 1);
    }
    self.allow_movement = 0;
    level util::waittill_any_ents_two(self, "trophy_system_disabled", level, "plaza_battle_train_exit_reached");
    self thread function_58e04ffd();
    foreach (e_player in level.activeplayers) {
        self setignoreent(e_player, 0);
    }
    level util::waittill_any_ents_two(self, "trophy_system_disabled", level, "plaza_battle_artillery_intro_stop");
    level flag::wait_till("plaza_battle_front_defenses_broken");
    self.allow_movement = 1;
    self vehicle_ai::start_scripted();
    self vehicle_ai::stop_scripted();
    self thread function_c635bfa2();
    self thread function_303a9547();
    self util::waittill_any_timeout(20, "trophy_system_disabled", "trophy_system_destroyed", "near_goal");
    level flag::set("plaza_battle_intro_artillery_in_position");
    level flag::wait_till("plaza_boss_dead");
    self.var_5330ac94 = util::spawn_model("tag_origin", self gettagorigin("tag_target_upper"), self gettagangles("tag_target_upper"));
    self.var_5330ac94 linkto(self, "tag_target_upper", (0, 0, 256));
    self.var_5330ac94.script_objective = "plaza_battle";
    level.ai_boss = self;
    self thread function_2686975a();
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x14b2f16f, Offset: 0x8848
// Size: 0x166
function function_303a9547() {
    self endon(#"death");
    var_2ef061f7 = getnodearray("plaza_battle_artillery_patrol_node", "targetname");
    for (var_5576dc56 = undefined; true; var_5576dc56 = var_2ef061f7[var_2ef061f7.size - 1]) {
        do {
            var_2ef061f7 = array::randomize(var_2ef061f7);
            wait 0.05;
        } while (var_2ef061f7[0] === var_5576dc56);
        foreach (var_f2c09364 in var_2ef061f7) {
            self setgoal(var_f2c09364.origin);
            self waittill(#"near_goal");
            wait randomfloatrange(5, 7);
        }
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x7e0bc55b, Offset: 0x89b8
// Size: 0x64
function function_8f5c1780() {
    if (!spawn_manager::is_enabled("plaza_battle_siegebot_left_middle_spawn_manager")) {
        spawn_manager::enable("plaza_battle_siegebot_left_middle_spawn_manager");
    }
    if (!spawn_manager::is_enabled("plaza_battle_siegebot_right_middle_spawn_manager")) {
        spawn_manager::enable("plaza_battle_siegebot_right_middle_spawn_manager");
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x9be1760b, Offset: 0x8a28
// Size: 0x14a
function function_d645af75() {
    var_a44ce9b5 = spawner::get_ai_group_ai("plaza_battle_center_siegebots");
    foreach (ai in var_a44ce9b5) {
        if (isalive(ai)) {
            if (ai.target === "plaza_battle_artillery_left_goaltrig") {
                str_goal = "plaza_battle_siegebots_left_goaltrig";
            } else if (ai.target === "plaza_battle_artillery_right_goaltrig") {
                str_goal = "plaza_battle_siegebots_right_goaltrig";
            }
            var_284ca6ef = getent(str_goal, "targetname");
            ai setgoal(var_284ca6ef);
        }
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xbe6e71e9, Offset: 0x8b80
// Size: 0x13e
function function_7f39a78b() {
    self endon(#"death");
    var_1e0937da = getnodearray(self.script_string, "targetname");
    var_1528a05b = undefined;
    while (true) {
        do {
            var_1e0937da = array::randomize(var_1e0937da);
            wait 0.05;
        } while (var_1e0937da[0] === var_1528a05b);
        foreach (var_1528a05b in var_1e0937da) {
            self setvehgoalpos(var_1528a05b.origin, 1, 1);
            wait randomfloatrange(3, 4);
        }
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x70b5de43, Offset: 0x8cc8
// Size: 0xe4
function function_6c61fe9e() {
    /#
        if (isgodmode(level.players[0])) {
            self.health = 1;
        }
    #/
    level.var_782205f8 = self;
    self thread function_934d33a5();
    if (!level flag::get("plaza_battle_cleared")) {
        self thread function_3dc6a02c("cp_level_zurich_enter_hq_destroy_hunter_obj");
        self thread function_d0b419ee();
    }
    self setspeedimmediate(7);
    self function_d769b9ad();
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xf819ddf0, Offset: 0x8db8
// Size: 0x124
function function_934d33a5() {
    self.var_e62c1231 = spawn("trigger_radius", self.origin + (0, 0, -60), 0, 256, 256);
    self.var_e62c1231 enablelinkto();
    self.var_e62c1231 linkto(self);
    if (!isdefined(level.oob_triggers)) {
        level.oob_triggers = [];
    } else if (!isarray(level.oob_triggers)) {
        level.oob_triggers = array(level.oob_triggers);
    }
    level.oob_triggers[level.oob_triggers.size] = self.var_e62c1231;
    self.var_e62c1231 thread oob::waitforplayertouch();
    self waittill(#"death");
    self.var_e62c1231 delete();
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x4c2da67e, Offset: 0x8ee8
// Size: 0xf8
function function_6a38397a() {
    self endon(#"death");
    level endon(#"hash_1fc32e88");
    var_2ef061f7 = getvehiclenodearray("plaza_battle_hunter_patrol_node", "targetname");
    while (true) {
        trigger::wait_till("plaza_battle_hunter_nofly_trig", undefined, self);
        var_f2c09364 = arraygetclosest(self.origin, var_2ef061f7);
        self vehicle_ai::start_scripted();
        self setvehgoalpos(var_f2c09364.origin, 1);
        self waittill(#"near_goal");
        self vehicle_ai::stop_scripted();
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xc386be01, Offset: 0x8fe8
// Size: 0x33c
function function_d769b9ad() {
    var_75532e17 = undefined;
    var_2ef061f7 = getvehiclenodearray("plaza_battle_hunter_patrol_node", "targetname");
    var_fbae031 = getvehiclenode("plaza_battle_hunter_patrol_start", "script_noteworthy");
    self vehicle_ai::start_scripted();
    self sethoverparams(32, 12, 8);
    self setvehgoalpos(var_fbae031.origin, 1);
    self util::waittill_either("death", "near_goal");
    if (isdefined(self)) {
        self thread function_6a38397a();
    }
    while (isdefined(self)) {
        do {
            var_2ef061f7 = array::randomize(var_2ef061f7);
            wait 0.05;
        } while (var_2ef061f7[0] === var_75532e17);
        var_75532e17 = var_2ef061f7[var_2ef061f7.size - 1];
        foreach (var_f2c09364 in var_2ef061f7) {
            a_e_targets = getaiteamarray("allies");
            a_e_targets = arraycombine(a_e_targets, level.activeplayers, 1, 1);
            a_e_targets = arraysort(a_e_targets, self.origin, 0);
            var_f09d8d3c = randomfloatrange(1.5, 3);
            self vehicle_ai::start_scripted();
            self setlookatent(a_e_targets[0]);
            self setvehgoalpos(var_f2c09364.origin, 1);
            self util::waittill_either("death", "near_goal");
            self vehicle_ai::stop_scripted();
            wait var_f09d8d3c;
        }
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x4ff73bf2, Offset: 0x9330
// Size: 0x84
function function_68e4ea91() {
    if (isalive(level.var_782205f8)) {
        self function_5c638800();
        return;
    }
    if (isalive(level.ai_boss)) {
        self function_5a1e5a49();
        return;
    }
    self function_c4b462a7();
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xb4d7e05b, Offset: 0x93c0
// Size: 0xfc
function function_d1db5654() {
    level endon(#"death");
    var_965f3899 = undefined;
    level flag::wait_till("plaza_battle_vtol_drop_crew_completed");
    spawn_manager::enable("plaza_battle_boss_wasp_spawn_manager");
    self thread function_69458aa0();
    do {
        var_965f3899 = int(zurich_util::function_411dc61b(3, -0.5));
        self util::waittill_any("trophy_system_disabled", "trophy_system_destroyed");
    } while (self.var_de9eba31 < var_965f3899);
    spawn_manager::enable("plaza_battle_boss_wasp_rocket_spawn_manager");
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x2190ba0e, Offset: 0x94c8
// Size: 0x144
function function_69458aa0() {
    self endon(#"death");
    while (true) {
        a_e_players = arraycopy(level.activeplayers);
        a_e_players = array::randomize(a_e_players);
        foreach (e_player in a_e_players) {
            if (e_player util::is_player_looking_at(self.origin + (0, 0, 256), 0.8, 1, e_player) && !(isdefined(e_player.active_camo) && e_player.active_camo)) {
                e_player function_baaaa286();
            }
        }
        wait 4;
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x417856e2, Offset: 0x9618
// Size: 0x16c
function function_baaaa286() {
    level.ai_boss endon(#"death");
    var_b3b33e02 = spawn_manager::function_423eae50("plaza_battle_boss_wasp_spawn_manager");
    var_8ba55d7b = spawn_manager::function_423eae50("plaza_battle_boss_wasp_spawn_manager");
    var_b3b33e02 = arraycombine(var_b3b33e02, var_8ba55d7b, 0, 0);
    foreach (var_aaefedf3 in var_b3b33e02) {
        if (!(isdefined(var_aaefedf3.is_attacking) && var_aaefedf3.is_attacking)) {
            var_aaefedf3.is_attacking = 1;
            if (!isdefined(self.var_439c885e)) {
                return;
            }
            var_aaefedf3 setentitytarget(self);
            var_aaefedf3 setgoal(self.var_439c885e, 1);
            return;
        }
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x7dbdc56d, Offset: 0x9790
// Size: 0xf4
function function_424191b5() {
    if (isdefined(self.var_439c885e)) {
        return;
    }
    self.var_439c885e = util::spawn_model("tag_origin", self.origin, self getplayerangles());
    self.var_439c885e.script_objective = "plaza_battle";
    v_offset = anglestoright(self getplayerangles()) * -128;
    v_offset += (0, 0, 64);
    self.var_439c885e linkto(self, "tag_origin", v_offset);
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x9f7d3c04, Offset: 0x9890
// Size: 0x2c
function function_cb30d060() {
    if (!isdefined(self.var_439c885e)) {
        return;
    }
    self.var_439c885e delete();
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xe3e2a908, Offset: 0x98c8
// Size: 0x146
function function_f8f7624b() {
    self endon(#"death");
    self endon(#"reached_end_node");
    self waittill(#"fire_turret");
    wait randomfloatrange(0.1, 0.56);
    a_ai_allies = getaiteamarray("allies");
    a_ai_allies = array::randomize(a_ai_allies);
    foreach (ai in a_ai_allies) {
        if (!ai util::is_hero()) {
            self thread vehicle_ai::fire_for_time(randomfloatrange(8, 12), undefined, ai);
            break;
        }
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x62ba2fea, Offset: 0x9a18
// Size: 0x34
function function_5a1e5a49() {
    self setgoal(level.ai_boss.var_5330ac94, 0, 400, 96);
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xb302bf85, Offset: 0x9a58
// Size: 0x2c
function function_5c638800() {
    self setgoal(level.var_782205f8, 0, -128, 32);
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xadc413e7, Offset: 0x9a90
// Size: 0x54
function function_c4b462a7() {
    var_284ca6ef = getent("plaza_battle_wasp_goaltrig", "targetname");
    if (isdefined(var_284ca6ef)) {
        self setgoal(var_284ca6ef);
    }
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xa121e38f, Offset: 0x9af0
// Size: 0x9c
function function_bc249f36() {
    var_ccbdc630 = getent("coalescence_gate", "targetname");
    var_ccbdc630 notsolid();
    umbragate_set("hq_atrium_umbra_gate", 1);
    level scene::play("p7_fxanim_cp_zurich_coalescence_tower_door_open_bundle");
    level thread function_509fb0c4();
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xd4996ea1, Offset: 0x9b98
// Size: 0x9c
function function_59999862() {
    var_ccbdc630 = getent("coalescence_gate", "targetname");
    var_ccbdc630 solid();
    level scene::play("p7_fxanim_cp_zurich_coalescence_tower_door_close_bundle");
    umbragate_set("hq_atrium_umbra_gate", 0);
    level flag::set("plaza_battle_exit_cleared");
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0x2b856e82, Offset: 0x9c40
// Size: 0x2c
function function_509fb0c4() {
    wait 1;
    level clientfield::set("hq_amb", 1);
}

// Namespace namespace_ca56958
// Params 0, eflags: 0x0
// Checksum 0xe25cd29, Offset: 0x9c78
// Size: 0xe8
function function_a2b45d70() {
    self endon(#"death");
    var_b711578c = getweapon("quadtank_main_turret_rocketpods_javelin");
    level flag::wait_till("plaza_battle_train_exit_reached");
    while (true) {
        self waittill(#"damage", _, _, _, _, _, _, _, _, var_e285ce7a);
        if (var_e285ce7a === var_b711578c) {
            radiusdamage(self.origin, 64, 1200, 1100, self);
            self delete();
        }
    }
}

/#

    // Namespace namespace_ca56958
    // Params 4, eflags: 0x0
    // Checksum 0x868470c8, Offset: 0x9d68
    // Size: 0x160
    function function_6744b8e3(var_4d75b06, e_target, n_radius, v_color) {
        if (isdefined(e_target) && isdefined(var_4d75b06)) {
            e_target notify(#"hash_9aac4254");
            e_target notify(#"hash_dc898c8");
            e_target endon(#"hash_9aac4254");
            self endon(#"death");
            e_target endon(#"death");
            e_target thread zurich_util::function_9ff5370d(n_radius, v_color);
            var_4d75b06 thread zurich_util::function_68a764f6(32, v_color);
            var_4d75b06 thread zurich_util::function_ff016910("<dev string:x9c>" + e_target getentitynumber(), v_color);
            if (isdefined(e_target)) {
                e_target thread zurich_util::function_c7d0d818(e_target, var_4d75b06, undefined, v_color, "<dev string:xac>");
            }
            var_4d75b06 waittill(#"death");
            e_target notify(#"hash_dc898c8");
            var_4d75b06 notify(#"hash_5322c93b");
        }
    }

    // Namespace namespace_ca56958
    // Params 0, eflags: 0x0
    // Checksum 0xb2bd6a0a, Offset: 0x9ed0
    // Size: 0x68
    function function_c58f2dba() {
        self thread zurich_util::function_ff016910(self.script_friendname);
        while (true) {
            recordline(self.origin, self.goalpos, (0, 1, 0), "<dev string:xc7>", self);
            wait 0.05;
        }
    }

#/
