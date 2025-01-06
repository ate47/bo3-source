#using scripts/codescripts/struct;
#using scripts/cp/_ammo_cache;
#using scripts/cp/_collectibles;
#using scripts/cp/_dialog;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_biodomes2_fx;
#using scripts/cp/cp_mi_sing_biodomes2_sound;
#using scripts/cp/cp_mi_sing_biodomes_accolades;
#using scripts/cp/cp_mi_sing_biodomes_supertrees;
#using scripts/cp/cp_mi_sing_biodomes_swamp;
#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/gametypes/_save;
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

#namespace cp_mi_sing_biodomes2;

// Namespace cp_mi_sing_biodomes2
// Params 0, eflags: 0x0
// Checksum 0x9b1017cd, Offset: 0xc60
// Size: 0x32
function function_243693d4() {
    util::add_gametype("coop");
    util::add_gametype("cpzm");
}

// Namespace cp_mi_sing_biodomes2
// Params 0, eflags: 0x0
// Checksum 0x48067140, Offset: 0xca0
// Size: 0x1ba
function main() {
    if (sessionmodeiscampaignzombiesgame() && -1) {
        setclearanceceiling(34);
    } else {
        setclearanceceiling(30);
    }
    savegame::function_8c0c4b3a("biodomes");
    namespace_769dc23f::function_4d39a2af();
    precache();
    function_b37230e4();
    flag_init();
    level_init();
    cp_mi_sing_biodomes2_fx::main();
    cp_mi_sing_biodomes2_sound::main();
    cp_mi_sing_biodomes_supertrees::main();
    cp_mi_sing_biodomes_swamp::main();
    function_673254cc();
    callback::on_connect(&on_player_connect);
    callback::on_spawned(&on_player_spawned);
    spawner::add_global_spawn_function("axis", &function_8b005d7f);
    load::main();
    createthreatbiasgroup("heroes");
    objectives::complete("cp_level_biodomes_mainobj_capture_data_drives");
    objectives::complete("cp_level_biodomes_mainobj_upload_data");
}

// Namespace cp_mi_sing_biodomes2
// Params 0, eflags: 0x0
// Checksum 0x8ebf2ff0, Offset: 0xe68
// Size: 0x93
function precache() {
    level._effect["explosion_zipline_up"] = "explosions/fx_exp_elvsft_biodome";
    level._effect["boat_sparks"] = "electric/fx_elec_sparks_boat_scrape_biodomes";
    level._effect["depth_charge"] = "explosions/fx_exp_underwater_depth_charge";
    level._effect["boat_trail"] = "vehicle/fx_spray_fan_boat";
    level._effect["boat_land_splash"] = "vehicle/fx_splash_front_fan_boat";
    level._effect["boat_grass"] = "vehicle/fx_grass_front_fan_boat";
}

// Namespace cp_mi_sing_biodomes2
// Params 0, eflags: 0x0
// Checksum 0x323d5b16, Offset: 0xf08
// Size: 0x39a
function function_b37230e4() {
    clientfield::register("toplayer", "dive_wind_rumble_loop", 1, 1, "int");
    clientfield::register("toplayer", "set_underwater_fx", 1, 1, "int");
    clientfield::register("toplayer", "sound_evt_boat_rattle", 1, 1, "counter");
    clientfield::register("toplayer", "zipline_speed_blur", 1, 1, "int");
    clientfield::register("toplayer", "zipline_rumble_loop", 1, 1, "int");
    clientfield::register("toplayer", "supertree_jump_debris_play", 1, 1, "int");
    clientfield::register("world", "boat_explosion_play", 1, 1, "int");
    clientfield::register("world", "elevator_top_debris_play", 1, 1, "int");
    clientfield::register("world", "elevator_bottom_debris_play", 1, 1, "int");
    clientfield::register("world", "tall_grass_init", 1, 1, "int");
    clientfield::register("world", "tall_grass_play", 1, 1, "int");
    clientfield::register("world", "supertree_fall_init", 1, 1, "counter");
    clientfield::register("world", "supertree_fall_play", 1, 1, "counter");
    clientfield::register("world", "ferriswheel_fall_play", 1, 1, "int");
    clientfield::register("allplayers", "zipline_sound_loop", 1, 1, "int");
    clientfield::register("vehicle", "boat_disable_sfx", 1, 1, "int");
    clientfield::register("vehicle", "sound_evt_boat_scrape_impact", 1, 1, "counter");
    clientfield::register("vehicle", "sound_veh_airboat_jump", 1, 1, "counter");
    clientfield::register("vehicle", "sound_veh_airboat_jump_air", 1, 1, "counter");
    clientfield::register("vehicle", "sound_veh_airboat_land", 1, 1, "counter");
    clientfield::register("vehicle", "sound_veh_airboat_ramp_hit", 1, 1, "counter");
    clientfield::register("vehicle", "sound_veh_airboat_start", 1, 1, "counter");
    clientfield::register("scriptmover", "clone_control", 1, 1, "int");
}

// Namespace cp_mi_sing_biodomes2
// Params 0, eflags: 0x0
// Checksum 0xdd0a66b1, Offset: 0x12b0
// Size: 0x25a
function flag_init() {
    level flag::init("start_slide");
    level flag::init("supertrees_intro_done");
    level flag::init("supertrees_intro_vo_complete");
    level flag::init("supertrees_hunter_arrival");
    level flag::init("hunter_missiles_go");
    level flag::init("hendricks_dive");
    level flag::init("player_dive_done");
    level flag::init("hendricks_boat_waiting");
    level flag::init("hendricks_onboard");
    level flag::init("boats_init");
    level flag::init("all_players_on_boats");
    level flag::init("boats_ready_to_depart");
    level flag::init("boat_rail_begin");
    level flag::init("boats_go");
    level flag::init("swamp_tanker_exploded");
    level flag::init("supertrees_tree1_started");
    level flag::init("hendricks_played_supertree_takedown");
    level flag::init("hendricks_reached_finaltree");
    level flag::init("player_reached_final_zipline");
    level flag::init("any_player_reached_bottom_finaltree");
    level flag::init("player_reached_bottom_finaltree");
    level flag::init("start_hendricks_dive");
    level flag::init("player_reached_top_finaltree");
    level flag::init("supertree_fall_played");
    level flag::init("dock_enemies_take_cover");
}

// Namespace cp_mi_sing_biodomes2
// Params 0, eflags: 0x0
// Checksum 0xe24e516b, Offset: 0x1518
// Size: 0x93
function level_init() {
    level.var_b06e31c0 = 1;
    var_4698236 = getentarray("start_hidden", "script_noteworthy");
    foreach (ent in var_4698236) {
        ent hide();
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 0, eflags: 0x0
// Checksum 0x415f058, Offset: 0x15b8
// Size: 0x3a
function function_8b005d7f() {
    if (isdefined(self.script_label)) {
        self.var_fd3ee5eb = self.script_label;
    } else {
        self.var_fd3ee5eb = "tree1";
    }
    self.var_23304c9e = 0;
}

// Namespace cp_mi_sing_biodomes2
// Params 0, eflags: 0x0
// Checksum 0x5c48caec, Offset: 0x1600
// Size: 0x6a
function on_player_connect() {
    self flag::init("player_on_boat");
    self.b_bled_out = 0;
    self thread function_f1059e87();
    self.var_23304c9e = 0;
    if (level flag::get("supertree_fall_played")) {
        exploder::exploder("fx_expl_supertree_collapse");
    }
}

// Namespace cp_mi_sing_biodomes2
// Params 0, eflags: 0x0
// Checksum 0x7d9c30ce, Offset: 0x1678
// Size: 0x17a
function on_player_spawned() {
    self endon(#"death");
    if (level.var_31aefea8 === "objective_descend") {
        self thread function_68f49e09();
    }
    if (level.var_31aefea8 === "objective_descend" || level.var_31aefea8 === "objective_supertrees") {
        self.var_fd3ee5eb = "tree1";
    }
    self thread cp_mi_sing_biodomes_swamp::function_9850e9ee();
    if (level.var_31aefea8 == "objective_swamps") {
        self thread cp_mi_sing_biodomes_swamp::function_39af75ef("boats_go");
    }
    if (level.var_31aefea8 == "objective_swamps" || level.var_31aefea8 == "dev_swamp_rail" || level.var_31aefea8 == "dev_swamp_rail_final_scene") {
        if (level.activeplayers.size > 2 && !level flag::get("boats_go")) {
            cp_mi_sing_biodomes_swamp::function_c98db861(0);
        } else if (level.activeplayers.size > 2 && level flag::get("boats_go")) {
            cp_mi_sing_biodomes_swamp::function_e5108e73(0);
        }
        if (level flag::get("boats_ready_to_depart")) {
            self thread cp_mi_sing_biodomes_swamp::function_1bd42852();
        }
    }
    cp_mi_sing_biodomes_util::function_d28654c9();
}

// Namespace cp_mi_sing_biodomes2
// Params 0, eflags: 0x0
// Checksum 0x4651a5f4, Offset: 0x1800
// Size: 0x1aa
function function_68f49e09() {
    self endon(#"death");
    level flag::wait_till("start_slide");
    s_start = struct::get("descend_player" + self getentitynumber(), "targetname");
    if (!isdefined(s_start)) {
        return;
    }
    var_79785795 = util::spawn_model("tag_origin", s_start.origin, s_start.angles);
    var_79785795 thread scene::play("cin_bio_12_05_descend_1st_planc_player_slideloop", self);
    while (isdefined(s_start.target)) {
        s_end = struct::get(s_start.target, "targetname");
        n_dist = distance(s_start.origin, s_end.origin);
        n_time = n_dist / 16 * 17.6;
        var_79785795 moveto(s_end.origin, n_time);
        wait n_time - 0.05;
        s_start = s_end;
    }
    v_velocity = var_79785795 getvelocity();
    self setvelocity(v_velocity);
    var_79785795 scene::stop("cin_bio_12_05_descend_1st_planc_player_slideloop");
    var_79785795 delete();
}

// Namespace cp_mi_sing_biodomes2
// Params 0, eflags: 0x0
// Checksum 0x89390f45, Offset: 0x19b8
// Size: 0x1e
function function_f1059e87() {
    self endon(#"disconnect");
    self waittill(#"bled_out");
    self.b_bled_out = 1;
}

// Namespace cp_mi_sing_biodomes2
// Params 0, eflags: 0x0
// Checksum 0x5ae06ad8, Offset: 0x19e0
// Size: 0x15a
function function_673254cc() {
    skipto::function_d68e678e("objective_descend", &cp_mi_sing_biodomes_supertrees::function_765faa8e, undefined, &cp_mi_sing_biodomes_supertrees::function_9aee8548);
    skipto::add("objective_supertrees", &cp_mi_sing_biodomes_supertrees::function_6ab1d04e, undefined, &cp_mi_sing_biodomes_supertrees::function_657c0308);
    skipto::function_d68e678e("objective_dive", &cp_mi_sing_biodomes_supertrees::function_e83c544, undefined, &cp_mi_sing_biodomes_supertrees::function_975cf43a);
    skipto::function_d68e678e("objective_swamps", &cp_mi_sing_biodomes_swamp::function_46a6d6ab, undefined, &cp_mi_sing_biodomes_swamp::function_b898dce1);
    /#
        skipto::add_dev("<dev string:x28>", &cp_mi_sing_biodomes_supertrees::function_86a08a81);
        skipto::add_dev("<dev string:x41>", &cp_mi_sing_biodomes_supertrees::function_6e6908bc);
        skipto::add_dev("<dev string:x5b>", &cp_mi_sing_biodomes_swamp::function_7220010f);
    #/
}

