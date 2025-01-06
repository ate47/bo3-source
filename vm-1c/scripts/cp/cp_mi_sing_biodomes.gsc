#using scripts/codescripts/struct;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_collectibles;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_mobile_armory;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_spawn_manager;
#using scripts/cp/_squad_control;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_biodomes_accolades;
#using scripts/cp/cp_mi_sing_biodomes_cloudmountain;
#using scripts/cp/cp_mi_sing_biodomes_fighttothedome;
#using scripts/cp/cp_mi_sing_biodomes_fx;
#using scripts/cp/cp_mi_sing_biodomes_init_spawn;
#using scripts/cp/cp_mi_sing_biodomes_markets;
#using scripts/cp/cp_mi_sing_biodomes_patch;
#using scripts/cp/cp_mi_sing_biodomes_sound;
#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/cp_mi_sing_biodomes_warehouse;
#using scripts/cp/cybercom/_cybercom;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai/archetype_warlord_interface;
#using scripts/shared/ai_shared;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/teamgather_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/visionset_mgr_shared;

#namespace cp_mi_sing_biodomes;

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0x6b3d8d3e, Offset: 0x12f0
// Size: 0x34
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0x57caed2f, Offset: 0x1330
// Size: 0x1fc
function main() {
    if (sessionmodeiscampaignzombiesgame() && 0) {
        setclearanceceiling(34);
    } else {
        setclearanceceiling(106);
    }
    savegame::function_8c0c4b3a("biodomes");
    util::function_286a5010(2);
    namespace_769dc23f::function_4d39a2af();
    precache();
    function_b37230e4();
    flag_init();
    level_init();
    cp_mi_sing_biodomes_fx::main();
    cp_mi_sing_biodomes_sound::main();
    cp_mi_sing_biodomes_markets::main();
    cp_mi_sing_biodomes_cloudmountain::main();
    cp_mi_sing_biodomes_fighttothedome::main();
    function_673254cc();
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    spawner::add_global_spawn_function("axis", &function_8b005d7f);
    if (sessionmodeiscampaignzombiesgame()) {
        level scene::init("server_room_access_start", "targetname");
    }
    load::main();
    cp_mi_sing_biodomes_patch::function_7403e82b();
    skipto::function_f3e035ef();
}

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0xe6d18cc7, Offset: 0x1538
// Size: 0x2ec
function function_673254cc() {
    skipto::add("objective_igc", &objective_igc, undefined, &objective_igc_done);
    skipto::function_d68e678e("objective_markets_start", &cp_mi_sing_biodomes_markets::objective_markets_start_init, undefined, &cp_mi_sing_biodomes_markets::objective_markets_start_done);
    skipto::function_d68e678e("objective_markets_rpg", &cp_mi_sing_biodomes_markets::objective_markets_rpg_init, undefined, &cp_mi_sing_biodomes_markets::objective_markets_rpg_done);
    skipto::function_d68e678e("objective_markets2_start", &cp_mi_sing_biodomes_markets::objective_markets2_start_init, undefined, &cp_mi_sing_biodomes_markets::objective_markets2_start_done);
    skipto::function_d68e678e("objective_warehouse", &cp_mi_sing_biodomes_warehouse::objective_warehouse_init, undefined, &cp_mi_sing_biodomes_warehouse::objective_warehouse_done);
    skipto::function_d68e678e("objective_cloudmountain", &cp_mi_sing_biodomes_cloudmountain::objective_cloudmountain_init, undefined, &cp_mi_sing_biodomes_cloudmountain::objective_cloudmountain_done);
    skipto::function_d68e678e("objective_cloudmountain_level_2", &cp_mi_sing_biodomes_cloudmountain::function_8ce887a2, undefined, &cp_mi_sing_biodomes_cloudmountain::objective_cloudmountain_level_2_done);
    skipto::function_d68e678e("objective_turret_hallway", &cp_mi_sing_biodomes_cloudmountain::function_df51ef25, undefined, &cp_mi_sing_biodomes_cloudmountain::function_9cfbecff);
    skipto::function_d68e678e("objective_xiulan_vignette", &cp_mi_sing_biodomes_cloudmountain::function_e696b86c, undefined, &cp_mi_sing_biodomes_cloudmountain::function_6be20b72);
    skipto::add("objective_server_room_defend", &cp_mi_sing_biodomes_cloudmountain::function_8dacf956, undefined, &cp_mi_sing_biodomes_cloudmountain::function_9ed4c7c0);
    skipto::function_d68e678e("objective_fighttothedome", &cp_mi_sing_biodomes_fighttothedome::objective_fighttothedome_init, undefined, &cp_mi_sing_biodomes_fighttothedome::objective_fighttothedome_done);
    /#
        skipto::add_dev("<dev string:x28>", &function_1a9d89e5);
        skipto::add_dev("<dev string:x39>", &cp_mi_sing_biodomes_warehouse::function_5e699ca2);
        skipto::add_dev("<dev string:x4c>", &cp_mi_sing_biodomes_warehouse::function_9989cb45);
    #/
}

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0x7ed9c1d6, Offset: 0x1830
// Size: 0x3a
function precache() {
    level._effect["ceiling_collapse"] = "destruct/fx_dest_ceiling_collapse_biodomes";
    level._effect["smoke_grenade"] = "explosions/fx_exp_grenade_smoke";
}

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0x4ab9d247, Offset: 0x1878
// Size: 0x334
function function_b37230e4() {
    clientfield::register("toplayer", "player_dust_fx", 1, 1, "int");
    clientfield::register("toplayer", "player_waterfall_pstfx", 1, 1, "int");
    clientfield::register("toplayer", "bullet_disconnect_pstfx", 1, 1, "int");
    clientfield::register("toplayer", "zipline_speed_blur", 1, 1, "int");
    clientfield::register("toplayer", "umbra_tome_markets2", 1000, 1, "counter");
    clientfield::register("scriptmover", "waiter_blood_shader", 1, 1, "int");
    clientfield::register("world", "set_exposure_bank", 1, 1, "int");
    clientfield::register("world", "party_house_shutter", 1, 1, "int");
    clientfield::register("world", "party_house_destruction", 1, 1, "int");
    clientfield::register("world", "dome_glass_break", 1, 1, "int");
    clientfield::register("world", "warehouse_window_break", 1, 1, "int");
    clientfield::register("world", "control_room_window_break", 1, 1, "int");
    clientfield::register("toplayer", "server_extra_cam", 1, 5, "int");
    clientfield::register("toplayer", "server_interact_cam", 1, 3, "int");
    clientfield::register("world", "cloud_mountain_crows", 1, 2, "int");
    clientfield::register("world", "fighttothedome_exfil_rope", 1, 2, "int");
    clientfield::register("world", "fighttothedome_exfil_rope_sim_player", 1, 1, "int");
}

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0x65026df, Offset: 0x1bb8
// Size: 0x644
function flag_init() {
    level flag::init("partyroom_igc_started");
    level flag::init("plan_b");
    level flag::init("dannyli_dead");
    level flag::init("gohbro_dead");
    level flag::init("bullet_start");
    level flag::init("bullet_over");
    level flag::init("party_scene_skipped");
    level flag::init("markets1_enemies_alert");
    level flag::init("hendricks_markets2_wallrun");
    level flag::init("hendricks_markets2_arch_throw");
    level flag::init("markets1_intro_dialogue_done");
    level flag::init("turret1");
    level flag::init("turret2");
    level flag::init("turret1_dead");
    level flag::init("turret2_dead");
    level flag::init("markets2_tower_destroyed");
    level flag::init("container_done");
    level flag::init("warehouse_intro_vo_started");
    level flag::init("warehouse_intro_vo_done");
    level flag::init("warehouse_warlord_friendly_goal");
    level flag::init("back_door_closed");
    level flag::init("warehouse_warlord");
    level flag::init("warehouse_warlord_dead");
    level flag::init("warehouse_warlord_retreated");
    level flag::init("back_door_opened");
    level flag::init("siegebot_damage_enabled");
    level flag::init("siegebot_alerted");
    level flag::init("warehouse_wasps");
    level flag::init("turret_hall_clear");
    level flag::init("hand_cut");
    level flag::init("elevator_light_on_server_room");
    level flag::init("elevator_light_on_cloudmountain");
    level flag::init("cloudmountain_flanker_disable");
    level flag::init("cloudmountain_left_cleared");
    level flag::init("cloudmountain_right_cleared");
    level flag::init("cloudmountain_siegebots_dead");
    level flag::init("cloudmountain_siegebots_skipped");
    level flag::init("cloudmountain_second_floor_vo");
    level flag::init("level_2_enemy_catwalk_spawned");
    level flag::init("cloudmountain_hunter_spawned");
    level flag::init("end_level_2_sniper_vo");
    level flag::init("cloudmountain_level_3_catwalk_vo");
    level flag::init("end_level_3_sniper_vo");
    level flag::init("window_broken");
    level flag::init("window_hooks");
    level flag::init("window_gone");
    level flag::init("server_room_failing");
    level flag::init("top_floor_breached");
    level flag::init("hendricks_on_dome");
    level flag::init("server_control_room_door_open");
}

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0x4030068, Offset: 0x2208
// Size: 0x254
function level_init() {
    createthreatbiasgroup("warlords");
    createthreatbiasgroup("heroes");
    level.var_b06e31c0 = 1;
    getent("back_door_look_trigger", "script_noteworthy") triggerenable(0);
    var_4698236 = getentarray("start_hidden", "script_noteworthy");
    foreach (ent in var_4698236) {
        ent hide();
    }
    var_c7f1d195 = getentarray("partyroom_destroyed", "targetname");
    foreach (prop in var_c7f1d195) {
        prop hide();
    }
    hidemiscmodels("partyroom_destroyed");
    var_b50d1047 = getentarray("waterfall_triggers", "script_noteworthy");
    array::thread_all(var_b50d1047, &function_2ec137d9);
    level thread function_a673776d();
}

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0x7e2d767, Offset: 0x2468
// Size: 0x1c
function function_8b005d7f() {
    self.var_2ddc2ef9 = 0;
    self.var_38c1e4c8 = 0;
}

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0x20743967, Offset: 0x2490
// Size: 0x44
function on_player_connect() {
    self.b_bled_out = 0;
    self thread function_f1059e87();
    self flag::init("player_bullet_over");
}

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0x48df4ed7, Offset: 0x24e0
// Size: 0x154
function on_player_spawned() {
    if (!getdvarint("art_review", 0)) {
        if (level.var_31aefea8 == "objective_igc" || level.var_31aefea8 == "dev_bullet_scene") {
            if (level flag::get("bullet_start")) {
                self flag::set("player_bullet_over");
            }
        } else if (level.var_31aefea8 == "objective_markets2_start") {
            level flag::set("turret1_dead");
            clientfield::increment_to_player("umbra_tome_markets2", 1);
        } else if (level.var_31aefea8 == "objective_warehouse" || level.var_31aefea8 == "objective_cloudmountain") {
            level flag::set("turret1_dead");
            level flag::set("turret2_dead");
        }
    }
    cp_mi_sing_biodomes_util::function_d28654c9();
}

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0xc54052fe, Offset: 0x2640
// Size: 0x28
function function_f1059e87() {
    self endon(#"disconnect");
    self waittill(#"bled_out");
    self.b_bled_out = 1;
}

// Namespace cp_mi_sing_biodomes
// Params 2, eflags: 0x0
// Checksum 0x306cfb5b, Offset: 0x2670
// Size: 0x12c
function function_cef897cf(str_objective, var_23d9a41a) {
    if (!isdefined(var_23d9a41a)) {
        var_23d9a41a = 4;
    }
    var_85556b78 = [];
    for (i = 0; i < var_23d9a41a; i++) {
        var_85556b78[i] = spawner::simple_spawn_single("friendly_robot_control", undefined, undefined, undefined, undefined, undefined, undefined, 1);
        var_85556b78[i].health = int(var_85556b78[i].health * 0.75);
        var_85556b78[i].start_health = var_85556b78[i].health;
    }
    skipto::teleport_ai(str_objective, var_85556b78);
    level thread squad_control::function_e56e9d7d(var_85556b78);
}

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0xa63134ca, Offset: 0x27a8
// Size: 0x48
function function_2ec137d9() {
    self endon(#"death");
    while (true) {
        self trigger::wait_till();
        self.who thread function_f952ddcc(self);
    }
}

// Namespace cp_mi_sing_biodomes
// Params 1, eflags: 0x0
// Checksum 0x208247de, Offset: 0x27f8
// Size: 0xcc
function function_f952ddcc(var_b35e56d0) {
    self endon(#"death");
    var_b35e56d0 setinvisibletoplayer(self);
    self clientfield::set_to_player("player_waterfall_pstfx", 1);
    while (self istouching(var_b35e56d0)) {
        n_delay = randomfloatrange(0, 1);
        wait n_delay;
    }
    var_b35e56d0 setvisibletoplayer(self);
    self clientfield::set_to_player("player_waterfall_pstfx", 0);
}

// Namespace cp_mi_sing_biodomes
// Params 1, eflags: 0x0
// Checksum 0xeaadf4b9, Offset: 0x28d0
// Size: 0x7a4
function function_69468f09(var_f45807af) {
    if (!isdefined(var_f45807af)) {
        var_f45807af = 0;
    }
    load::function_73adcefc();
    level thread scene::add_scene_func("cin_bio_02_04_gunplay_vign_stab_both", &function_7b5ce9a8, "done");
    level thread scene::add_scene_func("cin_bio_01_01_party_1st_drinks", &function_df65aec6, "play");
    level thread scene::add_scene_func("cin_bio_01_01_party_1st_drinks", &function_b361ad8b, "skip_started");
    level thread scene::init("cin_bio_03_01_market_vign_engage");
    level thread scene::init("cin_bio_03_01_market_aie_weapons");
    level thread scene::init("cin_gen_aie_table_react");
    if (var_f45807af) {
        var_ac204282 = struct::get_script_bundle("scene", "cin_bio_02_04_gunplay_vign_stab_both");
        foreach (s_object in var_ac204282.objects) {
            if (s_object.type === "player") {
                s_object.removeweapon = 0;
            }
        }
        level scene::init("cin_bio_02_04_gunplay_vign_stab_both");
        s_table = struct::get("skipto_intro_igc_table");
        util::spawn_model(s_table.model, s_table.origin, s_table.angles);
        load::function_c32ba481();
    } else {
        level scene::init("cin_bio_01_01_party_1st_drinks");
        level scene::init("cin_bio_01_01_party_1st_drinks_part2");
        util::set_lighting_state(1);
        load::function_c32ba481();
        util::function_46d3a558(%CP_MI_SING_BIODOMES_INTRO_LINE_1_FULL, %CP_MI_SING_BIODOMES_INTRO_LINE_1_SHORT, %CP_MI_SING_BIODOMES_INTRO_LINE_2_FULL, %CP_MI_SING_BIODOMES_INTRO_LINE_2_SHORT, %CP_MI_SING_BIODOMES_INTRO_LINE_3_FULL, %CP_MI_SING_BIODOMES_INTRO_LINE_3_SHORT, %CP_MI_SING_BIODOMES_INTRO_LINE_4_FULL, %CP_MI_SING_BIODOMES_INTRO_LINE_4_SHORT, "", "", 9);
    }
    level thread namespace_f1b4cbbc::function_f936f64e();
    function_484bc3aa(1);
    if (var_f45807af) {
        level thread scene::skipto_end("cin_bio_02_04_gunplay_vign_stab_both", undefined, undefined, 0.59, 1);
    } else {
        if (isdefined(level.var_6253d0f1)) {
            level thread [[ level.var_6253d0f1 ]]();
        }
        level thread function_8013ff12();
        level thread function_9cebd80e();
        level scene::play("cin_bio_01_01_party_1st_drinks");
    }
    foreach (player in level.players) {
        player.ignoreme = 1;
    }
    if (isdefined(level.var_e27ad46e)) {
        level thread [[ level.var_e27ad46e ]]();
    }
    level flag::set("bullet_start");
    level flag::set("bullet_over");
    var_c7f1d195 = getentarray("partyroom_destroyed", "targetname");
    foreach (prop in var_c7f1d195) {
        prop show();
    }
    level clientfield::set("party_house_destruction", 1);
    showmiscmodels("partyroom_destroyed");
    if (!var_f45807af) {
        level thread function_1fbdb441();
    }
    exploder::exploder("party_igc_bullets");
    level thread function_e4f0cf99();
    level clientfield::set("sndIGCsnapshot", 3);
    level util::clientnotify("no_party");
    foreach (player in level.players) {
        player allowcrouch(1);
        player allowprone(1);
    }
    while (!scene::is_active("cin_bio_02_04_gunplay_vign_stab_both")) {
        wait 0.05;
    }
    level notify(#"hash_7ee85209");
    if (!scene::function_b1f75ee9()) {
        cp_mi_sing_biodomes_markets::function_8387168c();
    }
    level clientfield::set("gameplay_started", 1);
}

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0xdc8870bb, Offset: 0x3080
// Size: 0x44
function function_8013ff12() {
    level waittill(#"hash_15b19b21");
    if (!scene::function_b1f75ee9()) {
        level scene::init("cin_bio_02_04_gunplay_vign_stab_both");
    }
}

// Namespace cp_mi_sing_biodomes
// Params 1, eflags: 0x0
// Checksum 0x274e9373, Offset: 0x30d0
// Size: 0x204
function function_b361ad8b(a_ents) {
    level flag::set("party_scene_skipped");
    level thread scene::add_scene_func("cin_gen_aie_table_react", &cp_mi_sing_biodomes_markets::function_c7cb9a93, "done");
    level thread scene::play("cin_gen_aie_table_react");
    level thread scene::play("cin_bio_03_01_market_vign_engage");
    level thread scene::play("cin_bio_03_01_market_aie_weapons");
    level thread scene::stop("p7_fxanim_cp_biodomes_party_house_drinks_bundle");
    level thread scene::stop("cin_bio_01_01_party_1st_drinks_part2");
    spawner::simple_spawn("sp_markets1_friendly_robot_start");
    spawn_manager::enable("sm_markets1_combat0");
    spawn_manager::enable("sm_markets1_combat1");
    level.turret_markets1 = spawner::simple_spawn_single("turret_markets1");
    level.turret_markets1 thread cp_mi_sing_biodomes_markets::function_70da4f9b();
    level thread cp_mi_sing_biodomes_markets::function_5d4c2323();
    level thread cp_mi_sing_biodomes_markets::function_b1e84c2();
    trigger::use("trig_markets1_combat1");
    wait 2;
    level flag::set("markets1_enemies_alert");
    level clientfield::set("sndIGCsnapshot", 0);
}

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0x1a5a529d, Offset: 0x32e0
// Size: 0x74
function function_9cebd80e() {
    level waittill(#"robot_overhead_throw_enemy");
    if (!scene::function_b1f75ee9()) {
        level thread function_5cb44f79("robot_graphic_kill", "robot_intro_robot", "robot_intro_guy");
        level thread function_5cb44f79("robot_overhead_throw_enemy");
    }
}

// Namespace cp_mi_sing_biodomes
// Params 3, eflags: 0x0
// Checksum 0xd56d88bb, Offset: 0x3360
// Size: 0x1c4
function function_5cb44f79(var_d83ebd04, var_42c1bd32, var_ae7d184a) {
    var_56af50be = [];
    var_f6c5842 = spawner::simple_spawn_single("markets1_robot_vign");
    var_f6c5842 squad_control::function_eb13b9c0();
    if (isdefined(var_42c1bd32)) {
        var_56af50be[var_42c1bd32] = var_f6c5842;
    } else {
        if (!isdefined(var_56af50be)) {
            var_56af50be = [];
        } else if (!isarray(var_56af50be)) {
            var_56af50be = array(var_56af50be);
        }
        var_56af50be[var_56af50be.size] = var_f6c5842;
    }
    ai_enemy = spawner::simple_spawn_single("markets1_enemy_vign");
    if (isdefined(var_ae7d184a)) {
        var_56af50be[var_ae7d184a] = ai_enemy;
    } else {
        if (!isdefined(var_56af50be)) {
            var_56af50be = [];
        } else if (!isarray(var_56af50be)) {
            var_56af50be = array(var_56af50be);
        }
        var_56af50be[var_56af50be.size] = ai_enemy;
    }
    s_align = struct::get(var_d83ebd04);
    s_align scene::play(s_align.scriptbundlename, var_56af50be);
}

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0x98df7cb7, Offset: 0x3530
// Size: 0x4c
function function_e4f0cf99() {
    level waittill(#"hash_480f0793");
    level clientfield::set("party_house_shutter", 1);
    util::set_lighting_state(0);
}

// Namespace cp_mi_sing_biodomes
// Params 1, eflags: 0x0
// Checksum 0xfd9b5d6, Offset: 0x3588
// Size: 0x9a
function function_484bc3aa(b_enable) {
    foreach (player in level.players) {
        player clientfield::set_to_player("player_dust_fx", b_enable);
    }
}

// Namespace cp_mi_sing_biodomes
// Params 1, eflags: 0x0
// Checksum 0x4c60050, Offset: 0x3630
// Size: 0x94
function function_df65aec6(a_ents) {
    level thread scene::play("p7_fxanim_cp_biodomes_party_house_drinks_bundle");
    level thread scene::play("cin_bio_01_01_party_1st_drinks_part2");
    var_ecc203c7 = a_ents["server"];
    var_ecc203c7 waittill(#"hash_a07a4e59");
    var_ecc203c7 clientfield::set("waiter_blood_shader", 1);
}

// Namespace cp_mi_sing_biodomes
// Params 1, eflags: 0x0
// Checksum 0xbc9520ef, Offset: 0x36d0
// Size: 0xf4
function function_7b5ce9a8(scene) {
    exploder::kill_exploder("party_igc_bullets");
    function_484bc3aa(0);
    foreach (player in level.players) {
        player.ignoreme = 0;
    }
    level util::function_93831e79("objective_markets_start");
    function_c506a743("objective_igc");
}

// Namespace cp_mi_sing_biodomes
// Params 2, eflags: 0x0
// Checksum 0xb7eb69b6, Offset: 0x37d0
// Size: 0x22c
function function_c506a743(str_objective, var_23d9a41a) {
    if (!isdefined(var_23d9a41a)) {
        var_23d9a41a = 4;
    }
    var_41b5ccc5 = struct::get_array("markets_combat_robot_squad_spawn");
    var_49ac7aba = [];
    var_64e85e6d = [];
    for (i = 0; i < 4; i++) {
        var_49ac7aba[i] = getent("robot0" + i + 1, "animname");
    }
    if (var_23d9a41a > 4) {
        for (i = 0; i < var_23d9a41a; i++) {
            var_64e85e6d[i] = spawner::simple_spawn_single("friendly_robot_control");
        }
    }
    a_squad = arraycombine(var_49ac7aba, var_64e85e6d, 0, 1);
    foreach (robot in a_squad) {
        robot.health = int(robot.health * 0.75);
        robot.start_health = robot.health;
    }
    level squad_control::function_e56e9d7d(a_squad);
}

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0x3c4f9335, Offset: 0x3a08
// Size: 0x74
function function_a673776d() {
    level flag::wait_till("turret1");
    if (isalive(level.turret_markets1)) {
        level thread squad_control::function_bb612155(level.turret_markets1);
        level.turret_markets1 thread function_2a7e0c30();
    }
}

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0x920691ac, Offset: 0x3a88
// Size: 0x54
function function_2a7e0c30() {
    self waittill(#"death");
    if (isdefined(self)) {
        if (isinarray(level.var_38f7500, self)) {
            arrayremovevalue(level.var_38f7500, self);
        }
    }
}

// Namespace cp_mi_sing_biodomes
// Params 2, eflags: 0x0
// Checksum 0x7563b3a2, Offset: 0x3ae8
// Size: 0x9c
function objective_igc(str_objective, var_74cd64bc) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_igc");
    cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
    level thread cp_mi_sing_biodomes_util::function_753a859(str_objective);
    level thread function_69468f09();
    level waittill(#"end_igc");
    level skipto::function_be8adfb8("objective_igc");
}

// Namespace cp_mi_sing_biodomes
// Params 4, eflags: 0x0
// Checksum 0xd1115f68, Offset: 0x3b90
// Size: 0x44
function objective_igc_done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_igc_done");
    if (var_74cd64bc) {
    }
}

// Namespace cp_mi_sing_biodomes
// Params 0, eflags: 0x0
// Checksum 0x8aae305f, Offset: 0x3be0
// Size: 0xee
function function_1fbdb441() {
    var_d7645744 = struct::get_array("igc_extra_bullets");
    for (i = 1; i <= 5; i++) {
        var_b324ff00 = getent("guard0" + i, "animname", 1);
        if (isalive(var_b324ff00)) {
            v_source = array::random(var_d7645744).origin;
            level thread function_ca12a0a4(var_b324ff00, v_source);
        }
    }
}

// Namespace cp_mi_sing_biodomes
// Params 2, eflags: 0x0
// Checksum 0xf0cd2ab5, Offset: 0x3cd8
// Size: 0x15a
function function_ca12a0a4(var_b324ff00, v_source) {
    var_f78ad07e = getweapon("lmg_cqb");
    v_dest = var_b324ff00.origin + (0, 0, 48);
    for (i = 0; i <= 3.5; i += 0.15) {
        var_de810370 = randomintrange(-2, 2);
        var_4837dd9 = randomintrange(-2, 2);
        var_2a85f842 = randomintrange(-20, 20);
        magicbullet(var_f78ad07e, v_source, v_dest + (var_de810370, var_4837dd9, var_2a85f842));
        wait 0.15;
    }
}

// Namespace cp_mi_sing_biodomes
// Params 2, eflags: 0x0
// Checksum 0x515f51e2, Offset: 0x3e40
// Size: 0x74
function function_1a9d89e5(str_objective, var_74cd64bc) {
    level thread function_69468f09(1);
    objectives::set("cp_waypoint_breadcrumb", struct::get("breadcrumb_markets1"));
    objectives::hide("cp_waypoint_breadcrumb");
}

