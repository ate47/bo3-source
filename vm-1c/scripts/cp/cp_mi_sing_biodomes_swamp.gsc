#using scripts/codescripts/struct;
#using scripts/cp/_debug;
#using scripts/cp/_dialog;
#using scripts/cp/_hazard;
#using scripts/cp/_load;
#using scripts/cp/_objectives;
#using scripts/cp/_skipto;
#using scripts/cp/_util;
#using scripts/cp/cp_mi_sing_biodomes2_sound;
#using scripts/cp/cp_mi_sing_biodomes_accolades;
#using scripts/cp/cp_mi_sing_biodomes_supertrees;
#using scripts/cp/cp_mi_sing_biodomes_util;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/cp/gametypes/_save;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/audio_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/colors_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/hud_message_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/teamgather_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/turret_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicleriders_shared;

#using_animtree("generic");

#namespace cp_mi_sing_biodomes_swamp;

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x34e365ec, Offset: 0x1f98
// Size: 0x54
function main() {
    function_80f24610();
    spawner::add_spawn_function_group("attacking_wasp", "script_noteworthy", &function_2297c05c);
    function_7b244c18();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xd46e7321, Offset: 0x1ff8
// Size: 0x64
function function_7b244c18() {
    scene::add_scene_func("cin_bio_15_02_player_vign_ontoboat_portnear", &function_4a242f62, "play");
    scene::add_scene_func("cin_bio_15_02_player_vign_ontoboat_starboardnear", &function_4a242f62, "play");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xadebb4f9, Offset: 0x2068
// Size: 0x12c
function function_80f24610() {
    level.var_c141dfcb = [];
    level.var_de54cf10 = 0;
    level.var_242afa66 = 0;
    level.var_197b567a = 0;
    level.var_1205b0f3 = [];
    level.var_1205b0f3["boat1_seat1"] = getent("trigger_boat_1_seat1", "targetname");
    level.var_1205b0f3["boat1_seat2"] = getent("trigger_boat_1_seat2", "targetname");
    level.var_1205b0f3["boat2_seat1"] = getent("trigger_boat_2_seat1", "targetname");
    level.var_1205b0f3["boat2_seat2"] = getent("trigger_boat_2_seat2", "targetname");
    namespace_769dc23f::function_b5aa3655();
    namespace_769dc23f::function_10fc44d8();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2, eflags: 0x0
// Checksum 0xd166b023, Offset: 0x21a0
// Size: 0x504
function objective_swamps_init(str_objective, var_74cd64bc) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_swamps_init");
    exploder::exploder("fx_expl_swamp_swim");
    exploder::exploder("fx_expl_swamp_rail");
    exploder::stop_exploder("fx_expl_supertree_collapse");
    exploder::stop_exploder("fx_expl_lowerplatform_supertree");
    exploder::stop_exploder("fx_expl_fire_boat_explode");
    level thread function_2ebccf5();
    if (var_74cd64bc) {
        load::function_73adcefc();
        level.var_2fd26037 = util::function_740f8516("hendricks");
        cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
        level.var_2fd26037 thread function_dd9ded92();
        level flag::set("player_dive_done");
        level flag::set("hendricks_dive");
        level flag::set("player_reached_bottom_finaltree");
        level flag::set("player_reached_top_finaltree");
        level flag::set("any_player_reached_bottom_finaltree");
        level flag::set("hendricks_played_supertree_takedown");
        level thread function_b52b6eac();
        array::thread_all(level.players, &function_39af75ef, "boats_go");
        var_57a51f3c = getent("vista_water", "targetname");
        var_57a51f3c delete();
        load::function_a2995f22();
    }
    if (level.var_adcba170 !== 1) {
        objectives::set("cp_level_biodomes_jump_from_supertree");
        objectives::complete("cp_level_biodomes_jump_from_supertree");
        level.var_adcba170 = 1;
    }
    level thread function_59212f01();
    objectives::set("cp_level_biodomes_dock_hendricks", struct::get("dock_waypoint"));
    foreach (player in level.activeplayers) {
        player util::show_hint_text(%COOP_SWIM_INSTRUCTIONS);
    }
    trigger::wait_till("t_player_dock");
    objectives::complete("cp_level_biodomes_dock_hendricks");
    objectives::set("cp_level_biodomes_secure_the_dock");
    level waittill(#"hash_691476e5");
    objectives::complete("cp_level_biodomes_secure_the_dock");
    if (level.players.size == 1) {
        objectives::set("cp_level_biodomes_escape", struct::get("airboat_waypoint_solo"));
        function_310b4b12(0, 0, level.players.size);
        level thread function_1f65dbfc();
    } else {
        objectives::set("cp_level_biodomes_escape", struct::get("airboat_waypoint"));
        function_310b4b12(0, 0);
    }
    if (level.players.size > 2) {
        function_310b4b12(1, 0);
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x6ab4fd9a, Offset: 0x26b0
// Size: 0x9c
function function_1f65dbfc() {
    while (level.players.size == 1) {
        wait 0.05;
    }
    objectives::set("cp_level_biodomes_escape", struct::get("airboat_waypoint"));
    objectives::complete("cp_level_biodomes_escape", struct::get("airboat_waypoint_solo"));
    function_310b4b12(0, 0);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2, eflags: 0x0
// Checksum 0x35d9891f, Offset: 0x2758
// Size: 0x1bc
function function_7220010f(str_objective, var_74cd64bc) {
    level.b_debug = 1;
    setdvar("phys_buoyancy", 1);
    setdvar("cg_viewVehicleInfluenceGunner_mode", 1);
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_swamps_init");
    objectives::set("cp_level_biodomes_escape", struct::get("airboat_waypoint"));
    cp_mi_sing_biodomes_util::function_bff1a867(str_objective);
    level flag::set("hendricks_dive");
    function_d343057f(1);
    level thread function_2ebccf5();
    level.var_2fd26037 thread hendricks_board();
    function_310b4b12(0, 0);
    function_310b4b12(1, 0);
    var_57a51f3c = getent("vista_water", "targetname");
    var_57a51f3c delete();
    trigger::wait_till("dev_trig_checkpoint");
    savegame::checkpoint_save();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x736a5301, Offset: 0x2920
// Size: 0xa4
function function_b52b6eac() {
    setdvar("phys_buoyancy", 1);
    setdvar("cg_viewVehicleInfluenceGunner_mode", 1);
    level thread function_5c8dbd1b();
    level thread function_d343057f();
    level thread function_1d4f0199();
    hidemiscmodels("fxanim_supertree");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x907d7425, Offset: 0x29d0
// Size: 0x564
function function_2ebccf5() {
    level.vehicle_main_callback["hunter"] = &function_32bc987b;
    exploder::exploder("grd_twr_01");
    exploder::exploder("grd_twr_02");
    exploder::exploder("grd_twr_03");
    exploder::exploder("grd_twr_04");
    function_36e4a4e3("tall_grass_boat");
    function_35a6217a("guard_tower_1", &function_963be5f4);
    function_35a6217a("guard_tower_2", &function_a59a792b);
    function_35a6217a("guard_tower_3", &function_2f957a8e);
    function_35a6217a("guard_tower_4", &function_a101398d);
    function_3f50cfab(1);
    level scene::init("p7_fxanim_cp_biodomes_sky_bridge_bundle");
    level thread function_71c5569c();
    level thread function_f06f5bf7();
    level thread function_24ae79ca();
    level thread function_fc1824d4();
    level thread function_4195b656();
    level thread function_d0b5b3de();
    level thread function_22ebbed();
    level thread function_12ca763f();
    level thread function_beedc0e7();
    level thread function_b3f809ee();
    level thread function_28313656();
    level thread function_2eee0c9c();
    level thread function_a903f6c1();
    level thread function_eff4afac();
    level thread function_9dd4818b();
    level thread function_95d3fd43();
    level thread function_c4fa2d2a();
    level thread function_72c5c9fd();
    level thread function_d8a75b5f();
    level thread function_dffe67b3();
    level thread function_d54492e();
    level thread function_2b6be7f7();
    level thread function_7f6a680f();
    level thread function_6111ddb4();
    level thread function_cfcdf5f4();
    level thread function_97247f7c();
    level thread function_81aca4ee();
    level thread function_452c817b();
    level thread function_9051a477();
    level thread function_c211eb0f();
    level thread function_5d6e5b81();
    level thread function_e2a7176();
    level thread function_70d3e476();
    level thread outpost_crash();
    level thread function_dacdabc9();
    level thread function_e5f905bd();
    level thread function_400cc8f4();
    level thread function_7fea5e8b();
    level thread function_daab7239();
    level thread function_ca115f5b();
    level thread function_2b558db7();
    level thread function_d665973f();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x54971ecf, Offset: 0x2f40
// Size: 0xb2
function function_df945144() {
    var_60b2e0dc = getentarray("t_hendricks_boat_anim", "targetname");
    foreach (t_hendricks_boat_anim in var_60b2e0dc) {
        t_hendricks_boat_anim thread function_e46e9d15();
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x61dc88cc, Offset: 0x3000
// Size: 0x1a6
function function_e46e9d15() {
    while (true) {
        self trigger::wait_till();
        if (self.who == level.var_2fd26037) {
            switch (self.script_noteworthy) {
            case "left":
                level thread scene::init("cin_bio_15_03_waterpark_vign_lean_left");
                break;
            case "left_exit":
                level scene::play("cin_bio_15_03_waterpark_vign_lean_left");
                level thread scene::play("cin_bio_15_03_waterpark_vign_lean_center");
                break;
            case "right":
                level thread scene::init("cin_bio_15_03_waterpark_vign_lean_right");
                break;
            case "right_exit":
                level scene::play("cin_bio_15_03_waterpark_vign_lean_right");
                level thread scene::play("cin_bio_15_03_waterpark_vign_lean_center");
                break;
            case "shoot":
                level thread scene::init("cin_bio_15_03_waterpark_vign_shoot");
                break;
            case "shoot_exit":
                level scene::play("cin_bio_15_03_waterpark_vign_shoot");
                level thread scene::play("cin_bio_15_03_waterpark_vign_lean_center");
                break;
            }
            break;
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xbfb56b9, Offset: 0x31b0
// Size: 0x124
function function_5c8dbd1b() {
    level endon(#"boats_ready_to_depart");
    t_murky_water = getent("t_murky_water", "targetname");
    while (true) {
        foreach (player in level.activeplayers) {
            if (isdefined(player.active_camo) && (player istouching(t_murky_water) || player.active_camo)) {
                player.ignoreme = 1;
                continue;
            }
            player.ignoreme = 0;
        }
        wait 0.3;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x2566878a, Offset: 0x32e0
// Size: 0xba
function function_e5f905bd() {
    var_9ffce615 = getent("trigger_store_crash", "targetname");
    foreach (player in level.activeplayers) {
        player thread function_53ae4df(var_9ffce615);
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xb00d4cd1, Offset: 0x33a8
// Size: 0xac
function function_7f6a680f() {
    trigger::wait_till("t_stop_swamp_fire");
    exploder::stop_exploder("fx_expl_swamp_fire_tanker");
    exploder::stop_exploder("fx_expl_fire_prehunter_supertree");
    exploder::stop_exploder("fx_expl_fire_posthunter_supertree");
    exploder::stop_exploder("fx_expl_fire_arrivetop_supertree");
    exploder::stop_exploder("fx_expl_fire_deathtop_supertree");
    exploder::stop_exploder("fx_expl_fire_descendlast_supertree");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x64a5bea, Offset: 0x3460
// Size: 0xfa
function function_3f50cfab(b_hide) {
    if (!isdefined(b_hide)) {
        b_hide = 1;
    }
    var_8cc31d7a = getentarray("ferris_wheel_debris", "targetname");
    foreach (mdl in var_8cc31d7a) {
        if (b_hide == 1) {
            mdl hide();
            continue;
        }
        mdl show();
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x77012315, Offset: 0x3568
// Size: 0x24
function function_d2e5a108(a_ents) {
    function_3f50cfab(0);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xc671bf7f, Offset: 0x3598
// Size: 0x162
function function_cfcdf5f4() {
    trigger::wait_till("trigger_ferriswheel_collapse");
    scene::add_scene_func("p7_fxanim_cp_biodomes_ferris_wheel_bundle", &function_d2e5a108, "done");
    level thread scene::play("p7_fxanim_cp_biodomes_ferris_wheel_bundle");
    level waittill(#"hash_55a06ec6");
    s_ferris_wheel_rumble = struct::get("s_ferris_wheel_rumble", "targetname");
    playrumbleonposition("cp_biodomes_ferris_wheel_rumble", s_ferris_wheel_rumble.origin);
    foreach (player in level.activeplayers) {
        player dodamage(71, s_ferris_wheel_rumble.origin);
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 4, eflags: 0x0
// Checksum 0x7bf2e56c, Offset: 0x3708
// Size: 0x64
function objective_swamps_done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    cp_mi_sing_biodomes_util::function_ddb0eeea("objective_swamps_done");
    namespace_769dc23f::function_a057c38f();
    objectives::complete("cp_level_biodomes_extract");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x3e9061be, Offset: 0x3778
// Size: 0x3c
function function_ff8ed5e2(s_target) {
    self waittill(#"death");
    fx::play("depth_charge", s_target.origin);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0xf9e9c569, Offset: 0x37c0
// Size: 0x284
function function_d343057f(b_debug) {
    if (!isdefined(b_debug)) {
        b_debug = 0;
    }
    level.var_c141dfcb[0] = function_90baa7b5("airboat_1");
    level.var_c141dfcb[1] = function_90baa7b5("airboat_2");
    level thread function_bba989c4(b_debug);
    level thread function_247e9ab0();
    level thread function_3bb88e47();
    level thread function_381c90d7();
    function_312d4b85();
    level.var_c141dfcb[0] thread function_3d026c12();
    if (level.players.size <= 2 && b_debug == 0) {
        function_c98db861(1);
    }
    level.var_78a73398 = [];
    for (i = 0; i < 2; i++) {
        level.var_78a73398[i] = util::spawn_model("tag_origin", level.var_c141dfcb[i].origin, level.var_c141dfcb[i].angles);
        level.var_78a73398[i] linkto(level.var_c141dfcb[i], "tag_origin", (350, 0, 30));
        level.var_78a73398[i].team = "allies";
        level.var_78a73398[i].health = 10000;
        level.var_78a73398[i].takedamage = 0;
    }
    level flag::set("boats_init");
    /#
        level thread function_73defa42();
    #/
}

/#

    // Namespace cp_mi_sing_biodomes_swamp
    // Params 0, eflags: 0x0
    // Checksum 0x6a98ea5d, Offset: 0x3a50
    // Size: 0xb8
    function function_73defa42() {
        while (true) {
            foreach (mdl_target in level.var_78a73398) {
                debug::drawarrow(mdl_target.origin, mdl_target.angles);
            }
            wait 0.05;
        }
    }

#/

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x821fda70, Offset: 0x3b10
// Size: 0x1f8
function function_c98db861(b_hide) {
    var_ec8cfe95 = getent("boat_bottom_clip_02", "targetname");
    if (b_hide == 1) {
        if (level.var_de54cf10 == 0) {
            var_ec8cfe95 notsolid();
            level.var_c141dfcb[1] notsolid();
            level.var_c141dfcb[1] ghost();
            level.var_c141dfcb[1] makevehicleunusable();
            level.var_c141dfcb[1] clientfield::set("boat_disable_sfx", 1);
            function_310b4b12(1, 1);
            level.var_de54cf10 = 1;
        }
        return;
    }
    if (level.var_de54cf10 == 1) {
        var_ec8cfe95 solid();
        level.var_c141dfcb[1] solid();
        level.var_c141dfcb[1] show();
        level.var_c141dfcb[1] makevehicleusable();
        level.var_c141dfcb[1] clientfield::set("boat_disable_sfx", 0);
        function_310b4b12(1, 0);
        level.var_de54cf10 = 0;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x84eb7ba5, Offset: 0x3d10
// Size: 0x110
function function_e5108e73(b_hide) {
    if (b_hide == 1) {
        if (level.var_de54cf10 == 0) {
            level.var_c141dfcb[1] ghost();
            level.var_c141dfcb[1] clientfield::set("boat_disable_sfx", 1);
            level.var_de54cf10 = 1;
        }
        return;
    }
    if (level.var_de54cf10 == 1) {
        level.var_c141dfcb[1] show();
        level.var_c141dfcb[1] clientfield::set("boat_disable_sfx", 0);
        if (level.var_242afa66 == 0) {
        }
        if (level.var_197b567a == 1) {
        }
        level.var_de54cf10 = 0;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2, eflags: 0x0
// Checksum 0xa3a01296, Offset: 0x3e28
// Size: 0xc0
function function_90baa7b5(var_be93bd02, var_886ca8c3) {
    var_886ca8c3 = vehicle::simple_spawn_single(var_be93bd02);
    var_886ca8c3 setcandamage(0);
    var_886ca8c3 makevehicleusable();
    var_886ca8c3 thread function_5175e36a();
    var_886ca8c3 setseatoccupied(1, 1);
    var_886ca8c3 setseatoccupied(2, 1);
    return var_886ca8c3;
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x48ad48f6, Offset: 0x3ef0
// Size: 0x12a
function function_3bb88e47() {
    v_offset = (0, 0, 0);
    foreach (var_f2684ab8 in level.var_1205b0f3) {
        var_f2684ab8 show();
        var_f2684ab8.var_5356d2cc = util::function_14518e76(var_f2684ab8, %cp_prompt_entervehicle_biodomes_boat, %CP_MI_SING_BIODOMES_AIRBOAT, &function_5e1bcb15);
        var_f2684ab8.var_5356d2cc thread gameobjects::function_e0e2d0fe((1, 1, 1), 600, 0);
        var_f2684ab8.var_5356d2cc gameobjects::disable_object();
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x5bf13247, Offset: 0x4028
// Size: 0x362
function function_5e1bcb15(e_player) {
    switch (self.trigger.targetname) {
    case "trigger_boat_1_seat1":
        level.var_c141dfcb[0] setseatoccupied(1, 0);
        self gameobjects::disable_object();
        e_player.var_462738ee = level.var_c141dfcb[0].script_int;
        e_player.n_seat = 1;
        e_player thread function_d53a8683(level.var_c141dfcb[0]);
        e_player thread function_b7a3f7a0(1, self, level.var_c141dfcb[0]);
        break;
    case "trigger_boat_1_seat2":
        level.var_c141dfcb[0] setseatoccupied(2, 0);
        e_player.var_462738ee = level.var_c141dfcb[0].script_int;
        e_player.n_seat = 2;
        e_player thread function_d53a8683(level.var_c141dfcb[0]);
        self gameobjects::disable_object();
        e_player thread function_b7a3f7a0(2, self, level.var_c141dfcb[0]);
        break;
    case "trigger_boat_2_seat1":
        level.var_c141dfcb[1] setseatoccupied(1, 0);
        e_player.var_462738ee = level.var_c141dfcb[1].script_int;
        e_player.n_seat = 1;
        e_player thread function_d53a8683(level.var_c141dfcb[1]);
        self gameobjects::disable_object();
        e_player thread function_b7a3f7a0(1, self, level.var_c141dfcb[1]);
        break;
    case "trigger_boat_2_seat2":
        level.var_c141dfcb[1] setseatoccupied(2, 0);
        e_player.var_462738ee = level.var_c141dfcb[1].script_int;
        e_player.n_seat = 2;
        e_player thread function_d53a8683(level.var_c141dfcb[1]);
        self gameobjects::disable_object();
        e_player thread function_b7a3f7a0(2, self, level.var_c141dfcb[1]);
        break;
    default:
        break;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 3, eflags: 0x0
// Checksum 0xdfa0bfc9, Offset: 0x4398
// Size: 0xac
function function_b7a3f7a0(n_seat, e_gameobject, var_3608e520) {
    level endon(#"boats_go");
    util::wait_network_frame();
    self function_218bb1a9();
    var_3608e520 setseatoccupied(n_seat, 1);
    e_gameobject gameobjects::enable_object();
    level flag::clear("all_players_on_boats");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xe8b2ca0c, Offset: 0x4450
// Size: 0x26
function function_218bb1a9() {
    self endon(#"death");
    self waittill(#"exit_vehicle");
    self.overrideplayerdamage = undefined;
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xe5d90a75, Offset: 0x4480
// Size: 0xca
function function_381c90d7() {
    level flag::wait_till("boats_go");
    foreach (var_f2684ab8 in level.var_1205b0f3) {
        var_f2684ab8.var_5356d2cc gameobjects::destroy_object();
        var_f2684ab8 delete();
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 3, eflags: 0x0
// Checksum 0x9e8e7949, Offset: 0x4558
// Size: 0x106
function function_310b4b12(var_62f1cf67, b_hide, var_52c8d3d6) {
    if (!isdefined(var_52c8d3d6)) {
        var_52c8d3d6 = 2;
    }
    var_462738ee = var_62f1cf67 + 1;
    for (i = 1; i <= var_52c8d3d6; i++) {
        if (b_hide) {
            level.var_1205b0f3["boat" + var_462738ee + "_seat" + i].var_5356d2cc gameobjects::disable_object();
            continue;
        }
        level.var_1205b0f3["boat" + var_462738ee + "_seat" + i].var_5356d2cc gameobjects::enable_object();
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xce9a6e6d, Offset: 0x4668
// Size: 0xb2
function function_f06f5bf7() {
    var_20f79745 = getentarray("trigger_boat_rumble", "targetname");
    foreach (t_rumble in var_20f79745) {
        t_rumble thread function_b2aec1cf();
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xc2a6c192, Offset: 0x4728
// Size: 0xf0
function function_b2aec1cf() {
    level endon(#"hash_9c7f20b4");
    while (true) {
        self waittill(#"trigger", player);
        if (isplayer(player)) {
            player playrumbleonentity("cp_biodomes_airboat_start_rumble");
            player clientfield::increment_to_player("sound_evt_boat_rattle");
            wait 0.3;
            while (player istouching(self)) {
                player playrumbleonentity("cp_biodomes_airboat_rumble");
                wait 0.1;
            }
            player playrumbleonentity("cp_biodomes_airboat_stop_rumble");
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x12992c54, Offset: 0x4820
// Size: 0x140
function function_b3f809ee() {
    var_f2684ab8 = getent("trigger_boat_scrape", "targetname");
    var_f2684ab8 waittill(#"trigger");
    level.var_c141dfcb[1] clientfield::increment("sound_evt_boat_scrape_impact");
    while (level.var_c141dfcb[1] istouching(var_f2684ab8)) {
        v_forward = level.var_c141dfcb[1].origin + anglestoforward(level.var_c141dfcb[1].angles) * -106;
        v_pos = level.var_c141dfcb[1].origin + v_forward;
        if (level.var_de54cf10 == 0) {
            fx::play("boat_sparks", v_forward);
        }
        wait 0.1;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xcbacc870, Offset: 0x4968
// Size: 0x3cc
function function_1bd42852() {
    var_233fafd3 = [];
    var_233fafd3 = level.var_c141dfcb[0] getvehoccupants();
    var_b1384098 = [];
    var_b1384098 = level.var_c141dfcb[1] getvehoccupants();
    if (!var_233fafd3.size) {
        self.var_462738ee = level.var_c141dfcb[0].script_int;
        self.n_seat = 1;
        level.var_c141dfcb[0] setseatoccupied(1, 0);
        level.var_c141dfcb[0] usevehicle(self, 1);
        return;
    }
    if (var_233fafd3.size < 2) {
        self.var_462738ee = level.var_c141dfcb[0].script_int;
        n_seat = level.var_c141dfcb[0] getoccupantseat(var_233fafd3[0]);
        if (n_seat == 1) {
            self.n_seat = 2;
            level.var_c141dfcb[0] setseatoccupied(2, 0);
            level.var_c141dfcb[0] usevehicle(self, 2);
        } else {
            self.n_seat = 1;
            level.var_c141dfcb[0] setseatoccupied(1, 0);
            level.var_c141dfcb[0] usevehicle(self, 1);
        }
        return;
    }
    if (!var_b1384098.size) {
        self.var_462738ee = level.var_c141dfcb[1].script_int;
        self.n_seat = 1;
        level.var_c141dfcb[1] setseatoccupied(1, 0);
        level.var_c141dfcb[1] usevehicle(self, 1);
        return;
    }
    self.var_462738ee = level.var_c141dfcb[1].script_int;
    n_seat = level.var_c141dfcb[1] getoccupantseat(var_b1384098[0]);
    if (n_seat == 1) {
        self.n_seat = 2;
        level.var_c141dfcb[1] setseatoccupied(2, 0);
        level.var_c141dfcb[1] usevehicle(self, 2);
        return;
    }
    self.n_seat = 1;
    level.var_c141dfcb[1] setseatoccupied(1, 0);
    level.var_c141dfcb[1] usevehicle(self, 1);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 5, eflags: 0x0
// Checksum 0xfa81d17d, Offset: 0x4d40
// Size: 0x104
function function_ef3ef43d(var_ce657c90, var_6203c1b5, str_anim, str_trigger, n_delay) {
    if (!isdefined(n_delay)) {
        n_delay = 0;
    }
    level flag::wait_till(var_ce657c90);
    level thread scene::init(str_anim);
    trigger::wait_till(str_trigger);
    if (n_delay > 0) {
        wait n_delay;
    }
    level scene::play(str_anim);
    level flag::set(var_6203c1b5);
    var_c4a1b346 = getent(str_trigger, "targetname");
    var_c4a1b346 delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x68454987, Offset: 0x4e50
// Size: 0xd4
function function_dd9ded92() {
    self notify(#"hash_93bef291");
    self ai::set_ignoreme(1);
    self ai::set_ignoreall(1);
    level scene::init("cin_bio_15_01_waterpark_swim");
    level flag::wait_till("player_dive_done");
    level scene::play("cin_bio_15_01_waterpark_swim");
    self function_eb8032ff();
    self hendricks_board();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x10573584, Offset: 0x4f30
// Size: 0x74
function hendricks_board() {
    level endon(#"hendricks_onboard");
    level notify(#"hash_691476e5");
    s_board = struct::get("hendricks_board");
    self function_12803ed9(s_board, 3);
    self thread function_ee9bef99();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x2237bf23, Offset: 0x4fb0
// Size: 0x1e0
function function_eb8032ff() {
    self clearforcedgoal();
    self ai::set_ignoreme(0);
    self ai::set_ignoreall(0);
    level notify(#"hendricks_on_dock");
    level flag::set("dock_enemies_take_cover");
    if (level flag::get("all_players_on_boats")) {
        return;
    }
    level endon(#"all_players_on_boats");
    nd_dock_hendricks = getnode("nd_dock_hendricks", "targetname");
    self.goalradius = 16;
    self setgoal(nd_dock_hendricks);
    level flag::wait_till("dock_enemies_retreat");
    nd_dock_hendricks = getnode("nd_dock_hendricks_2", "targetname");
    self setgoal(nd_dock_hendricks);
    while (true) {
        var_d61030ed = getaiarray("dock_guard_ai", "targetname");
        var_291a362b = getaiarray("water_guard_ai", "targetname");
        if (var_d61030ed.size + var_291a362b.size == 0) {
            break;
        }
        wait 1;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2, eflags: 0x0
// Checksum 0x56e3afe0, Offset: 0x5198
// Size: 0x284
function function_12803ed9(s_goal, n_timeout) {
    self ai::set_ignoreall(1);
    self.goalradius = 4;
    self setgoal(s_goal.origin, 1);
    self endon(#"goal");
    wait n_timeout;
    level flag::wait_till("all_players_on_boats");
    var_8c9eabdb = 1;
    while (var_8c9eabdb) {
        var_8c9eabdb = 0;
        foreach (player in level.players) {
            var_f4f2d282 = player getlinkedent();
            if (isdefined(var_f4f2d282)) {
                n_seat = var_f4f2d282 getoccupantseat(player);
                var_38340604 = var_f4f2d282 getseatfiringangles(n_seat);
                var_28ec750e = vectornormalize(var_38340604);
                var_f2311802 = player geteye();
                var_d35bd1db = vectornormalize(self.origin - var_f2311802);
                if (vectordot(var_28ec750e, var_d35bd1db) < 0.7) {
                    var_8c9eabdb = 1;
                }
            }
        }
        wait 0.1;
    }
    wait 1;
    self forceteleport(s_goal.origin, s_goal.angles);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x2dd8898d, Offset: 0x5428
// Size: 0x14c
function function_ee9bef99() {
    self ai::set_ignoreme(1);
    self.takedamage = 0;
    self clearforcedgoal();
    level scene::init("cin_bio_15_02_hendricks_vign_ontoboat");
    level flag::set("hendricks_boat_waiting");
    level thread function_23901dfa();
    level flag::wait_till("boats_ready_to_depart");
    if (isdefined(level.var_9910c090)) {
        level thread [[ level.var_9910c090 ]]();
    }
    level scene::play("cin_bio_15_02_hendricks_vign_ontoboat");
    self linkto(level.var_c141dfcb[0]);
    level flag::set("hendricks_onboard");
    level scene::play("cin_bio_15_03_waterpark_vign_lean_center");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xacea7fa, Offset: 0x5580
// Size: 0x184
function function_85800b08() {
    if (level flag::get("boats_init")) {
        var_b0fe27c9 = level.var_c141dfcb[0] getvehoccupants();
        var_1cc0c750 = level.var_c141dfcb[1] getvehoccupants();
        if (var_b0fe27c9.size == 1 || level.var_31aefea8 == "dev_swamp_rail" && level.activeplayers.size == 1 && (level.activeplayers.size == 4 && (level.activeplayers.size == 3 && (level.activeplayers.size == 2 && (level.activeplayers.size == 1 && var_b0fe27c9.size == 1 || var_b0fe27c9.size == 2) || var_b0fe27c9.size + var_1cc0c750.size == 3) || var_b0fe27c9.size + var_1cc0c750.size == 4) || var_1cc0c750.size == 1)) {
            level flag::set("all_players_on_boats");
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xcdcae35d, Offset: 0x5710
// Size: 0xce
function function_7c14c2de() {
    var_afe3ada7 = 0;
    foreach (player in level.activeplayers) {
        if (player flag::exists("player_on_boat")) {
            if (player flag::get("player_on_boat")) {
                var_afe3ada7++;
            }
        }
    }
    return var_afe3ada7;
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x35bcb2f5, Offset: 0x57e8
// Size: 0x240
function function_9850e9ee() {
    self endon(#"death");
    level endon(#"boat_rail_begin");
    while (true) {
        if (self flag::get("player_on_boat")) {
            e_vehicle = self getvehicleoccupied();
            if (e_vehicle === level.var_c141dfcb[0] || e_vehicle === level.var_c141dfcb[1]) {
                if (level flag::get("all_players_on_boats")) {
                    level.var_c141dfcb[0] makevehicleunusable();
                    level.var_c141dfcb[1] makevehicleunusable();
                }
            }
        } else if (!self isinvehicle() && self flag::get("player_on_boat")) {
            self flag::clear("player_on_boat");
        }
        if (e_vehicle === level.var_c141dfcb[0] || e_vehicle === level.var_c141dfcb[1]) {
            if (level flag::get("all_players_on_boats") && level flag::get("hendricks_boat_waiting")) {
                level.var_c141dfcb[0] makevehicleunusable();
                level.var_c141dfcb[1] makevehicleunusable();
                while (level.activeplayers.size != function_7c14c2de()) {
                    wait 0.05;
                }
                level flag::set("boats_ready_to_depart");
            }
        }
        wait 0.05;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x3079334c, Offset: 0x5a30
// Size: 0x124
function function_d53a8683(var_3608e520) {
    self endon(#"death");
    n_seat = self.n_seat;
    self thread function_8f2be4cc(var_3608e520, n_seat);
    if (n_seat == 1) {
        var_3608e520 scene::play("cin_bio_15_02_player_vign_ontoboat_portnear", self);
    } else {
        var_3608e520 scene::play("cin_bio_15_02_player_vign_ontoboat_starboardnear", self);
    }
    self.overrideplayerdamage = &function_654111e3;
    var_3608e520 setseatoccupied(n_seat, 0);
    var_3608e520 usevehicle(self, n_seat);
    self flag::set("player_on_boat");
    function_85800b08();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 13, eflags: 0x0
// Checksum 0xaa99d34e, Offset: 0x5b60
// Size: 0x9c
function function_654111e3(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, iboneindex, vsurfacenormal) {
    if (weapon == getweapon("turret_mil_boat_mg")) {
        idamage = 0;
    }
    return idamage;
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x7fd8ede9, Offset: 0x5c08
// Size: 0x26
function function_4a242f62(a_ents) {
    a_ents["player 1"] notify(#"hash_b0451c8f");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2, eflags: 0x0
// Checksum 0xe6dcccd5, Offset: 0x5c38
// Size: 0x3c
function function_8f2be4cc(var_886ca8c3, n_seat) {
    self waittill(#"hash_b0451c8f");
    var_886ca8c3 setseatoccupied(n_seat, 1);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x6487ab5f, Offset: 0x5c80
// Size: 0x168
function function_bba989c4(b_debug) {
    while (true) {
        var_afe3ada7 = function_7c14c2de();
        if (level.activeplayers.size > 0) {
            if (b_debug == 1 && (var_afe3ada7 == level.activeplayers.size || var_afe3ada7 == 1) && level flag::get("hendricks_onboard")) {
                level flag::set("boats_go");
                function_df945144();
                t_swamp_oob = getent("t_swamp_oob", "targetname");
                t_swamp_oob delete();
                objectives::set("cp_level_biodomes_extract");
                break;
            } else if (level flag::get("boats_go")) {
                level flag::clear("boats_go");
            }
        }
        wait 0.05;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x738404d3, Offset: 0x5df0
// Size: 0x2b2
function function_5175e36a() {
    level flag::wait_till("hendricks_onboard");
    level flag::wait_till("boats_go");
    battlechatter::function_d9f49fba(0);
    self clientfield::increment("sound_veh_airboat_start");
    level thread namespace_76133733::function_11139d81();
    self.nd_start = getvehiclenode(self.target, "targetname");
    hidemiscmodels("fxanim_fish");
    level scene::stop("cin_bio_15_03_waterpark_vign_lean_center");
    level thread scene::play("cin_bio_15_03_waterpark_vign_lean_center");
    self thread vehicle::get_on_and_go_path(self.nd_start);
    function_c5f21db5();
    wait 3;
    level.var_c141dfcb[0] setmodel("veh_t7_mil_boat_fan_54i_wet");
    level.var_c141dfcb[1] setmodel("veh_t7_mil_boat_fan_54i_wet");
    self trigger::wait_till("t_grass_fx_on");
    if (self.targetname == "airboat_2_vh") {
        level.var_197b567a = 1;
    }
    if (self.targetname == "airboat_2_vh") {
        if (level.var_de54cf10 == 0) {
            self fx::play("boat_grass", undefined, undefined, "remove_boat_grass", 1, "tag_origin_animate");
        }
    } else {
        self fx::play("boat_grass", undefined, undefined, "remove_boat_grass", 1, "tag_origin_animate");
    }
    self trigger::wait_till("t_grass_fx_off");
    if (self.targetname == "airboat_2_vh") {
        level.var_197b567a = 0;
    }
    self notify(#"remove_boat_grass");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x7afc29d1, Offset: 0x60b0
// Size: 0xae
function function_71c5569c() {
    level flag::wait_till("boats_go");
    foreach (player in level.players) {
        player.overrideplayerdamage = &function_a4e31a4a;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 13, eflags: 0x0
// Checksum 0xf55118a7, Offset: 0x6168
// Size: 0x7a
function function_a4e31a4a(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, iboneindex, vsurfacenormal) {
    idamage = 1;
    return idamage;
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xec3bfd2a, Offset: 0x61f0
// Size: 0x2ba
function function_247e9ab0() {
    var_5ee9a746 = getentarray("trigger_ramp_start", "targetname");
    var_24944fc2 = getentarray("trigger_ramp_end", "targetname");
    var_1c2fed59 = getentarray("trigger_ramp_land", "targetname");
    foreach (var_8b856a66 in var_5ee9a746) {
        var_8b856a66 thread function_27b8574f(level.var_c141dfcb[0]);
        var_8b856a66 thread function_27b8574f(level.var_c141dfcb[1]);
    }
    foreach (var_7ee296e2 in var_24944fc2) {
        var_7ee296e2 thread function_3b6e15a3(level.var_c141dfcb[0]);
        var_7ee296e2 thread function_3b6e15a3(level.var_c141dfcb[1]);
    }
    foreach (var_c358c3f9 in var_1c2fed59) {
        var_c358c3f9 thread function_7ae7a0f6(level.var_c141dfcb[0]);
        var_c358c3f9 thread function_7ae7a0f6(level.var_c141dfcb[1]);
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0xa42297e2, Offset: 0x64b8
// Size: 0xc4
function function_27b8574f(var_3608e520) {
    level endon(#"hash_9c7f20b4");
    while (true) {
        self waittill(#"trigger", e_trigger);
        if (e_trigger == var_3608e520) {
            var_3608e520 clientfield::increment("sound_veh_airboat_ramp_hit");
            var_3608e520 clientfield::increment("sound_veh_airboat_jump");
            var_3608e520 notify(#"hash_22e59eef");
            if (var_3608e520.targetname == "airboat_2_vh") {
                level.var_242afa66 = 1;
            }
            break;
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0xbc57d6ea, Offset: 0x6588
// Size: 0x6c
function function_3b6e15a3(var_3608e520) {
    level endon(#"hash_9c7f20b4");
    while (true) {
        self waittill(#"trigger", e_trigger);
        if (e_trigger == var_3608e520) {
            var_3608e520 clientfield::increment("sound_veh_airboat_jump_air");
            break;
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0xc21820e9, Offset: 0x6600
// Size: 0x124
function function_7ae7a0f6(var_3608e520) {
    level endon(#"hash_9c7f20b4");
    while (true) {
        self waittill(#"trigger", e_trigger);
        if (e_trigger == var_3608e520) {
            var_3608e520 clientfield::increment("sound_veh_airboat_land");
            if (var_3608e520.targetname == "airboat_2_vh") {
                if (level.var_de54cf10 == 0) {
                    var_3608e520 fx::play("boat_land_splash", undefined, undefined, 4, 1, "tag_origin_animate");
                }
            } else {
                var_3608e520 fx::play("boat_land_splash", undefined, undefined, 4, 1, "tag_origin_animate");
            }
            if (var_3608e520.targetname == "airboat_2_vh") {
                level.var_242afa66 = 0;
            }
            break;
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 6, eflags: 0x0
// Checksum 0xb21f11e0, Offset: 0x6730
// Size: 0x2ce
function function_af6241e9(var_9eb6bd2f, var_4b32b0cc, var_be93bd02, str_notify, n_wave, var_f1faa031) {
    if (!isdefined(str_notify)) {
        str_notify = undefined;
    }
    if (!isdefined(n_wave)) {
        n_wave = 1;
    }
    if (!isdefined(var_f1faa031)) {
        var_f1faa031 = 0;
    }
    trigger::wait_till(var_9eb6bd2f);
    if (isdefined(str_notify)) {
        level notify(str_notify);
    }
    var_a2258aa5 = getvehiclenodearray(var_4b32b0cc, "targetname");
    n_path = var_a2258aa5.size;
    var_c8d85832 = [];
    for (j = 0; j < n_wave; j++) {
        for (i = 0; i < n_path; i++) {
            var_b94e7fe0 = j * n_path + i;
            if (!isdefined(var_c8d85832)) {
                var_c8d85832 = [];
            } else if (!isarray(var_c8d85832)) {
                var_c8d85832 = array(var_c8d85832);
            }
            var_c8d85832[var_c8d85832.size] = spawner::simple_spawn_single(var_be93bd02);
            var_c8d85832[var_b94e7fe0] setforcenocull();
            if (var_4b32b0cc == "nd_wheel_wasp_start" && var_b94e7fe0 == 1) {
                var_c8d85832[1] playsound("evt_wasp_group_wheel_flyby");
            }
            if (var_4b32b0cc == "nd_bridge_wasp_start" && var_b94e7fe0 == 1) {
                var_c8d85832[1] playsound("evt_wasp_group_bridge_flyby");
            }
            wait 0.05;
            var_c8d85832[var_b94e7fe0] vehicle_ai::start_scripted();
            var_c8d85832[var_b94e7fe0] thread function_38257688();
            var_c8d85832[var_b94e7fe0] thread vehicle::get_on_and_go_path(var_a2258aa5[i]);
        }
        wait var_f1faa031;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x2808ece6, Offset: 0x6a08
// Size: 0x74
function function_38257688() {
    self endon(#"death");
    self waittill(#"reached_end_node");
    self vehicle_ai::stop_scripted("combat");
    wait randomfloatrange(0, 0.25);
    self delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x7caf0ed9, Offset: 0x6a88
// Size: 0x34
function function_12ca763f() {
    function_af6241e9("t_bridge_wasps", "nd_bridge_wasp_start", "sp_bridge_wasp", undefined, 2, 1);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x18243857, Offset: 0x6ac8
// Size: 0x34
function function_2eee0c9c() {
    function_af6241e9("t_bridge_wasps_2", "nd_bridge_wasp_2_start", "sp_bridge_wasp_2", undefined, 1, 0);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x136b8830, Offset: 0x6b08
// Size: 0x34
function function_beedc0e7() {
    function_af6241e9("t_wheel_wasps", "nd_wheel_wasp_start", "sp_wheel_wasp", "wheel_attack");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xde435cfb, Offset: 0x6b48
// Size: 0x3c
function function_6111ddb4() {
    function_af6241e9("t_wheel_wasps_2", "nd_wheel_wasp_2_start", "sp_wheel_wasp_2", undefined, 2, 1.5);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x93e4e3ab, Offset: 0x6b90
// Size: 0x3c
function function_97247f7c() {
    function_af6241e9("t_plane_wasps", "nd_plane_wasp_start", "sp_plane_wasp", undefined, 3, 1.25);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x7d53e37e, Offset: 0x6bd8
// Size: 0x34
function function_81aca4ee() {
    function_af6241e9("t_fuselage_wasps", "nd_fuselage_wasp_start", "sp_fuselage_wasp", undefined, 1, 0);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x9671dbb2, Offset: 0x6c18
// Size: 0x7c
function function_1d4f0199() {
    spawner::simple_spawn("water_guard", &function_248ab21b);
    level util::waittill_either("hendricks_on_dock", "dock_enemies_take_cover");
    spawner::simple_spawn("dock_guard", &function_7e16f75d);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xa4be75ce, Offset: 0x6ca0
// Size: 0x54
function function_7e16f75d() {
    self endon(#"death");
    var_ab891f49 = getent("dock_retreat", "targetname");
    self setgoal(var_ab891f49, 1);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x65a2af4f, Offset: 0x6d00
// Size: 0x17c
function function_248ab21b() {
    self endon(#"death");
    self.var_c5e3e899 = self.goalradius;
    self.goalradius = 16;
    self thread function_2c27934b();
    self thread function_9a7ec3e7();
    level flag::wait_till("dock_enemies_take_cover");
    wait randomfloatrange(0.15, 0.95);
    self.goalradius = self.var_c5e3e899;
    var_ab891f49 = getent("dock_goal_volume", "targetname");
    self setgoal(var_ab891f49, 1);
    level flag::wait_till("dock_enemies_retreat");
    var_ab891f49 = getent("dock_retreat", "targetname");
    self setgoal(var_ab891f49, 1);
    wait 5;
    trigger::use("trig_dock_playerspawns", "targetname");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xf6fc6778, Offset: 0x6e88
// Size: 0xb0
function function_9a7ec3e7() {
    self endon(#"death");
    level endon(#"dock_enemies_take_cover");
    var_3b7123fc = getent("t_player_dock", "targetname");
    while (true) {
        self waittill(#"damage", n_damage, e_attacker);
        if (e_attacker istouching(var_3b7123fc)) {
            level flag::set("dock_enemies_take_cover");
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0xeae82d1e, Offset: 0x6f40
// Size: 0xec
function function_bad78721(var_9eb6bd2f) {
    self endon(#"death");
    self.goalradius = 16;
    if (self.script_string === "rocket_guard_boat_1") {
        self thread ai::shoot_at_target("shoot_until_target_dead", level.var_78a73398[0]);
    } else if (self.script_string === "rocket_guard_boat_2") {
        self thread ai::shoot_at_target("shoot_until_target_dead", level.var_78a73398[1]);
    }
    trigger::wait_till(var_9eb6bd2f);
    wait randomfloatrange(0.1, 0.15);
    self delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xef69e033, Offset: 0x7038
// Size: 0xa4
function function_59212f01() {
    level dialog::remote("kane_stay_with_it_beat_0", 3);
    level waittill(#"hash_691476e5");
    battlechatter::function_d9f49fba(0);
    level.var_2fd26037 dialog::say("hend_kane_we_re_commande_0");
    level dialog::remote("kane_copy_that_overwatch_0", 1.2);
    battlechatter::function_d9f49fba(1);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x46fbba15, Offset: 0x70e8
// Size: 0x2c
function function_5441f2aa() {
    level dialog::function_13b3b16a("plyr_you_better_drive_fas_0", 0.3);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xed0cd7da, Offset: 0x7120
// Size: 0x64
function function_7fea5e8b() {
    trigger::wait_till("t_vo_hend_kane_that_ferris_wh_0");
    level.var_2fd26037 dialog::say("hend_kane_that_ferris_wh_0");
    level dialog::remote("kane_on_it_hang_on_0", 0.6);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x698a4933, Offset: 0x7190
// Size: 0x3c
function function_ca115f5b() {
    trigger::wait_till("t_vo_hend_go_right_0");
    level.var_2fd26037 dialog::say("hend_go_right_0");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xc14d575, Offset: 0x71d8
// Size: 0x3c
function function_daab7239() {
    trigger::wait_till("t_vo_hend_go_left_go_left_0");
    level.var_2fd26037 dialog::say("hend_go_left_go_left_0");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x7cc748ac, Offset: 0x7220
// Size: 0x3c
function function_2b558db7() {
    trigger::wait_till("t_vo_hend_left_left_left_le_0");
    level.var_2fd26037 dialog::say("hend_left_left_left_le_0");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xd1c10fe2, Offset: 0x7268
// Size: 0x3c
function function_d665973f() {
    trigger::wait_till("t_vo_kane_hey_do_you_wanna_dr_0");
    level dialog::remote("kane_hey_do_you_wanna_dr_0");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x8ba0331e, Offset: 0x72b0
// Size: 0xce
function function_23901dfa() {
    level endon(#"boats_ready_to_depart");
    level flag::wait_till("hendricks_boat_waiting");
    wait 10;
    a_vo = array("hend_let_s_go_get_on_a_t_0", "hend_what_are_you_waiting_5", "hend_get_on_the_turret_w_0");
    for (i = 0; i < a_vo.size; i++) {
        level.var_2fd26037 dialog::say(a_vo[i]);
        wait randomfloatrange(10, 15);
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 3, eflags: 0x0
// Checksum 0x96951a6b, Offset: 0x7388
// Size: 0xd4
function function_fc2f856(var_d48a5688, str_vehicle, var_5dfe8937) {
    vehicle::add_spawn_function(str_vehicle, &function_c37f005a, var_5dfe8937);
    var_77f2b279 = vehicle::simple_spawn_single(str_vehicle);
    var_77f2b279 vehicle::lights_off();
    var_cf0db380 = spawner::simple_spawn_single(var_d48a5688, &function_c59c5367, var_5dfe8937);
    var_cf0db380 vehicle::get_in(var_77f2b279, "gunner1", 1);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0xef349324, Offset: 0x7468
// Size: 0x44
function function_c59c5367(var_9eb6bd2f) {
    self endon(#"death");
    trigger::wait_till(var_9eb6bd2f);
    self delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x99665537, Offset: 0x74b8
// Size: 0x9c
function function_c37f005a(var_9eb6bd2f) {
    self endon(#"death");
    if (isdefined(self.target)) {
        self.nd_start = getvehiclenode(self.target, "targetname");
        self thread vehicle::get_on_and_go_path(self.nd_start);
    }
    trigger::wait_till(var_9eb6bd2f);
    self delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xee093e3, Offset: 0x7560
// Size: 0x94
function function_12771210() {
    level thread function_fc2f856("sp_tech_gunner", "sp_tech_outpost_1_1", "t_cleanup_tech_outpost_1");
    level thread function_fc2f856("sp_tech_gunner", "sp_tech_outpost_1_2", "t_cleanup_tech_outpost_1");
    level thread function_fc2f856("sp_tech_gunner", "sp_tech_outpost_1_3", "t_cleanup_tech_outpost_1");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xc9f7ad38, Offset: 0x7600
// Size: 0x4c
function function_22ebbed() {
    trigger::wait_till("t_tech_bridge_1");
    level thread function_fc2f856("sp_tech_gunner", "sp_tech_bridge_1", "t_cleanup_tech_bridge_1");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x2b1f9f7d, Offset: 0x7658
// Size: 0x4c
function function_28313656() {
    trigger::wait_till("t_tech_bridge_2");
    level thread function_fc2f856("sp_tech_gunner", "sp_tech_bridge_2", "t_cleanup_tech_bridge_2");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xa24ff7f9, Offset: 0x76b0
// Size: 0x4c
function function_a903f6c1() {
    trigger::wait_till("t_guard_tower_1_tech");
    level thread function_fc2f856("sp_tech_gunner", "sp_guard_tower_1_tech", "t_cleanup_guard_tower_1_tech");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x1b071b3, Offset: 0x7708
// Size: 0x4c
function function_eff4afac() {
    trigger::wait_till("t_guard_tower_2_tech");
    level thread function_fc2f856("sp_tech_gunner", "sp_guard_tower_2_tech", "t_cleanup_guard_tower_2_tech");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x129b07d3, Offset: 0x7760
// Size: 0x4c
function function_9dd4818b() {
    trigger::wait_till("t_guard_tower_3_tech");
    level thread function_fc2f856("sp_tech_gunner", "sp_guard_tower_3_tech", "t_cleanup_guard_tower_3_tech");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xee4510e5, Offset: 0x77b8
// Size: 0x4c
function function_95d3fd43() {
    trigger::wait_till("t_guard_tower_1_spawn");
    spawner::simple_spawn("sp_guard_tower_1", &function_bad78721, "t_cleanup_guard_tower_1");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x326ff9e4, Offset: 0x7810
// Size: 0x4c
function function_c4fa2d2a() {
    trigger::wait_till("t_guard_tower_2_spawn");
    spawner::simple_spawn("sp_guard_tower_2", &function_bad78721, "t_cleanup_guard_tower_2");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x5f22193a, Offset: 0x7868
// Size: 0x4c
function function_72c5c9fd() {
    trigger::wait_till("t_guard_tower_3_spawn");
    spawner::simple_spawn("sp_guard_tower_3", &function_bad78721, "t_cleanup_guard_tower_3");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xa9776be4, Offset: 0x78c0
// Size: 0x64
function function_4195b656() {
    trigger::wait_till("t_outpost_1_guards");
    level thread function_12771210();
    spawner::simple_spawn("outpost_1_guard", &function_bad78721, "t_cleanup_outpost_1_guard");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x7b56f2fa, Offset: 0x7930
// Size: 0x4c
function function_c211eb0f() {
    trigger::wait_till("t_outpost_2_guards");
    spawner::simple_spawn("outpost_2_guard", &function_bad78721, "t_cleanup_outpost_2_guard");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x9a71efd5, Offset: 0x7988
// Size: 0x4c
function function_d8a75b5f() {
    trigger::wait_till("t_building_roof_guards");
    spawner::simple_spawn("building_roof_guard", &function_bad78721, "t_cleanup_building_roof_guards");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xa882ffc7, Offset: 0x79e0
// Size: 0x7c
function function_dffe67b3() {
    trigger::wait_till("t_building_roof_guards_ragdoll");
    start_ragdoll("building_roof_guard", (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(0, 10)));
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x86b21a23, Offset: 0x7a68
// Size: 0x4c
function function_452c817b() {
    trigger::wait_till("t_guard_plane");
    spawner::simple_spawn("sp_guard_plane", &function_bad78721, "t_cleanup_guard_plane");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x34ef4b7e, Offset: 0x7ac0
// Size: 0x7c
function function_5d6e5b81() {
    trigger::wait_till("t_outpost_2_guard_lower_a_ragdoll");
    start_ragdoll("outpost_2_guard_lower_a", (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(0, 10)));
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x2342179c, Offset: 0x7b48
// Size: 0x7c
function function_e2a7176() {
    trigger::wait_till("t_outpost_2_guard_lower_b_ragdoll");
    start_ragdoll("outpost_2_guard_lower_b", (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(0, 10)));
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x9fd4c094, Offset: 0x7bd0
// Size: 0x7c
function function_70d3e476() {
    trigger::wait_till("t_outpost_2_guard_upper_ragdoll");
    start_ragdoll("outpost_2_guard_upper", (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(0, 10)));
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x2046d421, Offset: 0x7c58
// Size: 0x94
function function_fc1824d4() {
    level thread function_f0265b78("t_outpost_01_s01", "p7_fxanim_cp_biodomes_outpost_01_s01_bundle", &function_ba87a724);
    level thread function_f0265b78("t_outpost_01_s02", "p7_fxanim_cp_biodomes_outpost_01_s02_bundle", &function_14648c5b);
    level thread function_f0265b78("t_outpost_01_s03", "p7_fxanim_cp_biodomes_outpost_01_s03_bundle", &function_1632053e);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x55183bbe, Offset: 0x7cf8
// Size: 0x34
function function_9051a477() {
    level thread function_f0265b78("t_outpost_02", "p7_fxanim_cp_biodomes_outpost_01_s04_bundle", &function_444a6a70);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 3, eflags: 0x0
// Checksum 0x4b657420, Offset: 0x7d38
// Size: 0x144
function function_f0265b78(var_5fffe0e3, var_88676d, var_65f020d3) {
    if (!isdefined(var_65f020d3)) {
        var_65f020d3 = undefined;
    }
    t_damage = getent(var_5fffe0e3, "targetname");
    if (isdefined(var_65f020d3)) {
        scene::add_scene_func(var_88676d, var_65f020d3, "play");
    }
    while (true) {
        t_damage waittill(#"damage", damage, attacker, direction, point, type, tagname, modelname, partname, weapon);
        if (isplayer(attacker)) {
            level thread scene::play(var_88676d);
            break;
        }
        wait 0.1;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x7fc27333, Offset: 0x7e88
// Size: 0x24
function function_963be5f4(a_ents) {
    function_5bd584eb("tower_guard_1");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0xbfee7f41, Offset: 0x7eb8
// Size: 0x3c
function function_a59a792b(a_ents) {
    function_5bd584eb("tower_guard_2");
    exploder::stop_exploder("grd_twr_02");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x48b3d4b0, Offset: 0x7f00
// Size: 0x3c
function function_2f957a8e(a_ents) {
    function_5bd584eb("tower_guard_3");
    exploder::stop_exploder("grd_twr_03");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x4f754e07, Offset: 0x7f48
// Size: 0x3c
function function_a101398d(a_ents) {
    function_5bd584eb("tower_guard_4");
    exploder::stop_exploder("grd_twr_01");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x2dc216ad, Offset: 0x7f90
// Size: 0x24
function function_ba87a724(a_ents) {
    function_5bd584eb("outpost_guard_s1");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0xd71d654d, Offset: 0x7fc0
// Size: 0x24
function function_14648c5b(a_ents) {
    function_5bd584eb("outpost_guard_s2");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x77dd61ff, Offset: 0x7ff0
// Size: 0x24
function function_1632053e(a_ents) {
    function_5bd584eb("outpost_guard_s3");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0xf9348149, Offset: 0x8020
// Size: 0x4c
function function_444a6a70(a_ents) {
    function_5bd584eb("tower_2_guard");
    exploder::stop_exploder("grd_twr_04");
    namespace_769dc23f::function_b5cf7b68();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2, eflags: 0x0
// Checksum 0x38e6ed96, Offset: 0x8078
// Size: 0xf2
function start_ragdoll(var_525ec887, v_force) {
    a_ai = getentarray(var_525ec887, "script_noteworthy", 1);
    foreach (ai in a_ai) {
        if (isalive(ai)) {
            ai startragdoll();
            ai launchragdoll(v_force);
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x80f0667a, Offset: 0x8178
// Size: 0x190
function function_5bd584eb(var_525ec887) {
    a_ai = getentarray(var_525ec887, "script_noteworthy", 1);
    foreach (ai in a_ai) {
        if (isalive(ai)) {
            var_d7f9ac76 = randomintrange(1, 4);
            switch (var_d7f9ac76) {
            case 1:
                ai thread scene::play("cin_gen_xplode_death_1", ai);
                break;
            case 2:
                ai thread scene::play("cin_gen_xplode_death_2", ai);
                break;
            case 3:
                ai thread scene::play("cin_gen_xplode_death_3", ai);
                break;
            default:
                break;
            }
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x9b656fa9, Offset: 0x8310
// Size: 0x19c
function function_2c27934b() {
    self endon(#"death");
    level endon(#"hendricks_on_dock");
    a_s_targets = struct::get_array("s_murky_water_target", "targetname");
    e_target = spawn("script_model", (0, 0, 0));
    e_target setmodel("tag_origin");
    e_target.health = 1000;
    e_target.takedamage = 0;
    while (true) {
        if (!isdefined(self.enemy)) {
            var_5908c36e = randomint(a_s_targets.size);
            n_duration = randomfloatrange(0.5, 1.5);
            e_target.origin = a_s_targets[var_5908c36e].origin;
            self thread ai::shoot_at_target("normal", e_target, "tag_origin", n_duration);
            wait n_duration;
            wait randomfloatrange(0.2, 0.8);
            continue;
        }
        wait 0.1;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x1cdc09e, Offset: 0x84b8
// Size: 0xd8
function function_d0b5b3de() {
    trigger::wait_till("trig_swamp_rail_rpg_warning");
    weapon = getweapon("smaw");
    var_11fd5f3f = struct::get("swamp_rail_rpg_warning_launch", "targetname");
    var_6beedec9 = struct::get("swamp_rail_rpg_warning_target", "targetname");
    var_3c91fda1 = magicbullet(weapon, var_11fd5f3f.origin, var_6beedec9.origin);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x1bcb35c9, Offset: 0x8598
// Size: 0x264
function function_32bc987b() {
    self endon(#"death");
    target_set(self, (0, 0, 0));
    self useanimtree(#generic);
    self.health = self.healthdefault;
    self vehicle::friendly_fire_shield();
    self.takedamage = 0;
    self enableaimassist();
    self setneargoalnotifydist(50);
    self sethoverparams(15, 100, 40);
    self.flyheight = getdvarfloat("g_quadrotorFlyHeight");
    self.fovcosine = 0;
    self.fovcosinebusy = 0.574;
    self.vehaircraftcollisionenabled = 1;
    self.original_vehicle_type = self.vehicletype;
    self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
    self.goalradius = 300;
    self.goalheight = 512;
    self function_49e9f3ca();
    self.overridevehicledamage = &function_8fff56d4;
    self thread vehicle_ai::nudge_collision();
    self turret::_init_turret(1);
    self turret::_init_turret(2);
    self turret::set_burst_parameters(1, 2, 1, 2, 1);
    self turret::set_burst_parameters(1, 2, 1, 2, 2);
    self turret::function_109c9f9(3, 1);
    self turret::function_109c9f9(3, 2);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 15, eflags: 0x0
// Checksum 0xb05b822f, Offset: 0x8808
// Size: 0xb4
function function_8fff56d4(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    var_7aaca1e8 = vehicle::update_damage_fx_level(self.health, idamage, self.healthdefault);
    return idamage;
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xfd0d9e96, Offset: 0x88c8
// Size: 0xee
function function_49e9f3ca() {
    self.missiletags = [];
    if (!isdefined(self.missiletags)) {
        self.missiletags = [];
    } else if (!isarray(self.missiletags)) {
        self.missiletags = array(self.missiletags);
    }
    self.missiletags[self.missiletags.size] = "tag_rocket1";
    if (!isdefined(self.missiletags)) {
        self.missiletags = [];
    } else if (!isarray(self.missiletags)) {
        self.missiletags = array(self.missiletags);
    }
    self.missiletags[self.missiletags.size] = "tag_rocket2";
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x9519681f, Offset: 0x89c0
// Size: 0x112
function function_24ae79ca() {
    level flag::wait_till("boats_ready_to_depart");
    level flag::set("boat_rail_begin");
    objectives::complete("cp_level_biodomes_escape");
    var_a03a2e28 = spawner::simple_spawn_single("sp_hunter_fuel_truck", &function_fb738343);
    foreach (player in level.players) {
        player.var_32218fc7 = 1;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xf72119c1, Offset: 0x8ae0
// Size: 0x48
function function_d54492e() {
    level waittill(#"wheel_attack");
    var_a03a2e28 = spawner::simple_spawn_single("sp_hunter_wheel_attack", &function_243196a7);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xaeb55b41, Offset: 0x8b30
// Size: 0x50
function function_2b6be7f7() {
    trigger::wait_till("t_hunter_water_explosion");
    var_a03a2e28 = spawner::simple_spawn_single("sp_hunter_water_explosion", &function_ce0e4988);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x329eb1ea, Offset: 0x8b88
// Size: 0x50
function function_dacdabc9() {
    trigger::wait_till("t_hunter_final_pursuit");
    var_a03a2e28 = spawner::simple_spawn_single("sp_hunter_final_pursuit", &function_e0476b5e);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xca50a10c, Offset: 0x8be0
// Size: 0xec
function function_fb738343() {
    self endon(#"death");
    self setforcenocull();
    nd_start = getvehiclenode(self.target, "targetname");
    self thread vehicle::get_on_and_go_path(nd_start);
    self waittill(#"fuel_truck_missile");
    level thread function_5441f2aa();
    self function_bb5ef028("fuel_truck_missile", &function_1393a04d);
    self waittill(#"hash_df3c116a");
    self setspeedimmediate(0);
    self delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x59b7309, Offset: 0x8cd8
// Size: 0x17c
function function_243196a7() {
    self endon(#"death");
    self setforcenocull();
    nd_start = getvehiclenode(self.target, "targetname");
    self thread vehicle::get_on_and_go_path(nd_start);
    self waittill(#"hash_36d05dc6");
    wait 0.1;
    self function_bb5ef028("so_ferris_wheel_missiles_1", &function_3cbc42d6);
    wait 0.15;
    self function_bb5ef028("so_ferris_wheel_missiles_1", &function_3cbc42d6);
    wait 0.15;
    self function_bb5ef028("so_ferris_wheel_missiles_2", &function_3cbc42d6);
    wait 0.15;
    self function_bb5ef028("so_ferris_wheel_missiles_3", &function_3cbc42d6);
    wait 0.15;
    self waittill(#"hash_df3c116a");
    self setspeedimmediate(0);
    self delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x19dd8516, Offset: 0x8e60
// Size: 0x14c
function function_ce0e4988() {
    self endon(#"death");
    self setforcenocull();
    nd_start = getvehiclenode(self.target, "targetname");
    self thread vehicle::get_on_and_go_path(nd_start);
    self waittill(#"hash_48964163");
    self function_bb5ef028("so_swamp_water_explosion_1", &function_8bc51e36);
    self waittill(#"hash_d68ed228");
    self function_bb5ef028("so_swamp_water_explosion_2", &function_8bc51e36);
    self waittill(#"hash_fc914c91");
    self function_bb5ef028("so_swamp_water_explosion_3", &function_8bc51e36);
    self waittill(#"hash_df3c116a");
    self setspeedimmediate(0);
    self delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2, eflags: 0x0
// Checksum 0x729103c, Offset: 0x8fb8
// Size: 0xd4
function function_bb5ef028(var_4e9a9978, var_5d4391a4) {
    e_target = getentarray(var_4e9a9978, "targetname");
    self setturrettargetent(e_target[0]);
    self thread function_fd8ffa73(0, e_target[0], undefined, 0, 0);
    e_missile = self thread function_fd8ffa73(1, e_target[1], undefined, 0, 0);
    e_missile thread [[ var_5d4391a4 ]](e_target[0], var_4e9a9978);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x316f76f3, Offset: 0x9098
// Size: 0x174
function function_e0476b5e() {
    self endon(#"death");
    self setforcenocull();
    nd_start = getvehiclenode(self.target, "targetname");
    self thread vehicle::get_on_and_go_path(nd_start);
    self waittill(#"hash_5e08d59e");
    self function_bb5ef028("so_swamp_final_water_explosion_1", &function_8bc51e36);
    self function_bb5ef028("so_swamp_final_water_explosion_1_b", &function_8bc51e36);
    self waittill(#"hash_38065b35");
    self function_bb5ef028("so_swamp_final_water_explosion_2", &function_8bc51e36);
    self waittill(#"hash_1203e0cc");
    self function_bb5ef028("so_swamp_final_water_explosion_3", &function_8bc51e36);
    self waittill(#"hash_df3c116a");
    self setspeedimmediate(0);
    self delete();
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 5, eflags: 0x0
// Checksum 0x33236ff2, Offset: 0x9218
// Size: 0x16e
function function_fd8ffa73(var_e569678c, target, offset, var_d5ccbff6, var_8d0a485e) {
    self endon(#"death");
    if (!isdefined(offset)) {
        offset = (0, 0, -10);
    }
    spawntag = self.missiletags[var_e569678c];
    origin = self gettagorigin(spawntag);
    angles = self gettagangles(spawntag);
    forward = anglestoforward(angles);
    up = anglestoup(angles);
    if (isdefined(spawntag)) {
        weapon = getweapon("hunter_rocket_turret_biodomes_cinematic");
        missile = magicbullet(weapon, origin, target.origin, self, target, offset);
        return missile;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2, eflags: 0x0
// Checksum 0xe8b72ed6, Offset: 0x9390
// Size: 0x84
function function_1393a04d(e_target, var_deb1fb4d) {
    self waittill(#"death");
    level thread scene::play("p7_fxanim_cp_biodomes_swamp_tanker_bundle");
    playrumbleonposition("cp_biodomes_fuel_truck_rumble", e_target.origin);
    level flag::set("swamp_tanker_exploded");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2, eflags: 0x0
// Checksum 0x328dcd6d, Offset: 0x9420
// Size: 0x3c
function function_8bc51e36(e_target, var_deb1fb4d) {
    self waittill(#"death");
    function_74d7b8e4(var_deb1fb4d, "explosions/fx_exp_rocket_water_lg");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2, eflags: 0x0
// Checksum 0xb65c61d5, Offset: 0x9468
// Size: 0x3c
function function_3cbc42d6(e_target, var_deb1fb4d) {
    self waittill(#"death");
    function_74d7b8e4(var_deb1fb4d, "explosions/fx_vexp_hunter_death");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2, eflags: 0x0
// Checksum 0x12c9521b, Offset: 0x94b0
// Size: 0x3c
function function_36910f4(e_target, var_deb1fb4d) {
    self waittill(#"death");
    function_74d7b8e4(var_deb1fb4d, "explosions/fx_exp_impact_ferriswheel_biodomes");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2, eflags: 0x0
// Checksum 0x24138277, Offset: 0x94f8
// Size: 0xbe
function function_74d7b8e4(var_deb1fb4d, str_fx_name) {
    var_38fa6e84 = getentarray(var_deb1fb4d, "targetname");
    for (i = 0; i < var_38fa6e84.size; i++) {
        playfx(str_fx_name, var_38fa6e84[i].origin, anglestoforward(var_38fa6e84[i].angles), (0, 0, 1));
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x8ea9fcf3, Offset: 0x95c0
// Size: 0x158
function function_2297c05c() {
    self endon(#"death");
    while (true) {
        if (isdefined(self.enemy) && self function_4246bc05(self.enemy)) {
            if (randomfloatrange(0, 1) < 0.45) {
                if (distancesquared(self.enemy.origin, self.origin) < 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax) * 3 * 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax) * 3) {
                    self setturrettargetent(self.enemy);
                    self vehicle_ai::fire_for_time(randomfloatrange(0.2, 0.4));
                }
            }
        }
        wait 0.45;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x71fb3860, Offset: 0x9720
// Size: 0x13c
function outpost_crash() {
    trigger::wait_till("trigger_outpost");
    var_41063076 = getentarray("outpost_clips", "script_noteworthy");
    foreach (clip in var_41063076) {
        clip delete();
    }
    var_a8ebd745 = getent("outpost_crash", "targetname");
    if (isdefined(var_a8ebd745)) {
        var_a8ebd745 delete();
    }
    level thread scene::play("p7_fxanim_cp_biodomes_outpost_boat_crash_bundle");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x366d259f, Offset: 0x9868
// Size: 0x64
function function_53ae4df(var_c358c3f9) {
    self endon(#"disconnect");
    var_c358c3f9 waittill(#"trigger");
    self playrumbleonentity("cp_biodomes_jump_land_rumble");
    self clientfield::increment_to_player("sound_evt_boat_rattle");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x7d8c0a10, Offset: 0x98d8
// Size: 0x142
function function_aa88dfc2(a_ents) {
    if (level.activeplayers.size < 3 && !(isdefined(level.b_debug) && level.b_debug)) {
        a_ents["boat2"] hide();
    }
    foreach (player in level.players) {
        var_a44e19db = "boat" + player.var_462738ee;
        str_scene = function_6150ee85(var_a44e19db, player.n_seat);
        if (isdefined(str_scene)) {
            level thread scene::play(str_scene, player);
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2, eflags: 0x0
// Checksum 0x345df16c, Offset: 0x9a28
// Size: 0xf4
function function_6150ee85(var_a44e19db, n_seat) {
    str_scene = undefined;
    if (var_a44e19db == "boat1" && n_seat == 1) {
        str_scene = "cin_bio_16_01_slide_1st_slammed_p1";
    } else if (var_a44e19db == "boat1" && n_seat == 2) {
        str_scene = "cin_bio_16_01_slide_1st_slammed_p3";
    } else if (var_a44e19db == "boat2" && n_seat == 1) {
        str_scene = "cin_bio_16_01_slide_1st_slammed_p2";
    } else if (var_a44e19db == "boat2" && n_seat == 2) {
        str_scene = "cin_bio_16_01_slide_1st_slammed_p4";
    }
    return str_scene;
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x80ebbf1d, Offset: 0x9b28
// Size: 0x39c
function function_3d026c12() {
    var_91904b90 = [];
    for (i = 0; i < 2; i++) {
        var_841b0143 = util::spawn_model("veh_t7_mil_boat_fan_54i_wet");
        var_841b0143 hide();
        if (!isdefined(var_91904b90)) {
            var_91904b90 = [];
        } else if (!isarray(var_91904b90)) {
            var_91904b90 = array(var_91904b90);
        }
        var_91904b90[var_91904b90.size] = var_841b0143;
        wait 0.05;
    }
    self waittill(#"play_end_igc");
    level clientfield::set("gameplay_started", 0);
    level thread audio::unlockfrontendmusic("mus_biodomes_battle_intro");
    level thread function_245722ce();
    level.var_2fd26037 delete();
    level.var_2fd26037 = undefined;
    a_scene_ents = [];
    a_scene_ents["boat1"] = var_91904b90[0];
    a_scene_ents["boat1"] show();
    if (level.var_c141dfcb.size > 1) {
        a_scene_ents["boat2"] = var_91904b90[1];
        a_scene_ents["boat2"] show();
    }
    foreach (player in level.activeplayers) {
        if (isdefined(player.usingvehicle) && player.usingvehicle && isdefined(player.viewlockedentity)) {
            player.viewlockedentity usevehicle(player, 0);
        }
    }
    thread function_7e40793c();
    level scene::stop("cin_bio_15_03_waterpark_vign_lean_center");
    if (isdefined(level.var_167fa382)) {
        level thread [[ level.var_167fa382 ]]();
    }
    level thread namespace_76133733::function_a6bf2d53();
    level scene::add_scene_func("cin_bio_16_01_slide_1st_slammed", &function_aa88dfc2, "play");
    level thread scene::play("cin_bio_16_01_slide_1st_slammed", a_scene_ents);
    level thread scene::play("p7_fxanim_cp_biodomes_sky_bridge_bundle");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x9b916054, Offset: 0x9ed0
// Size: 0x13a
function function_7e40793c() {
    foreach (var_3608e520 in level.var_c141dfcb) {
        if (isdefined(var_3608e520)) {
            var_3608e520 ghost();
            var_3608e520 notsolid();
        }
    }
    wait 1;
    foreach (var_3608e520 in level.var_c141dfcb) {
        if (isdefined(var_3608e520)) {
            var_3608e520 delete();
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x9c2fd8e5, Offset: 0xa018
// Size: 0x8e
function function_863f4586(a_ents) {
    if (isdefined(a_ents["sp_hunter_sky_bridge"])) {
        wait 0.5;
        for (i = 0; i < 3; i++) {
            a_ents["sp_hunter_sky_bridge"] function_bb5ef028("so_sky_bridge_missiles_1", &function_36910f4);
            wait 0.5;
        }
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xf50346b3, Offset: 0xa0b0
// Size: 0x8c
function function_245722ce() {
    namespace_769dc23f::function_ed573577();
    level waittill(#"hash_8fd3985");
    setdvar("phys_buoyancy", 0);
    setdvar("cg_viewVehicleInfluenceGunner_mode", 0);
    util::screen_fade_out(1);
    wait 0.5;
    skipto::function_be8adfb8("objective_swamps");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0xe3e2b02d, Offset: 0xa148
// Size: 0x64
function function_36e4a4e3(str_group) {
    var_c917e48d = struct::get_array(str_group, "targetname");
    level thread array::spread_all(var_c917e48d, &function_ea7f9b48);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x60cbc522, Offset: 0xa1b8
// Size: 0x104
function function_ea7f9b48() {
    scene::init(self.scriptbundlename);
    if (!isdefined(self.radius)) {
        self.radius = 448;
    }
    if (!isdefined(self.height)) {
        self.height = 400;
    }
    var_8b856a66 = function_5ec7eb7d(self.origin, self.radius, self.height);
    while (true) {
        var_8b856a66 waittill(#"trigger", var_886ca8c3);
        if (var_886ca8c3.targetname == "airboat_2_vh" && level.var_de54cf10) {
            continue;
        }
        scene::play(self.scriptbundlename);
        var_8b856a66 delete();
        break;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 2, eflags: 0x0
// Checksum 0x70f80b96, Offset: 0xa2c8
// Size: 0x6c
function function_35a6217a(str_name, var_65f020d3) {
    if (!isdefined(var_65f020d3)) {
        var_65f020d3 = undefined;
    }
    var_461bd72d = struct::get(str_name, "targetname");
    var_461bd72d thread function_81e1861d(var_65f020d3);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x6191ce1f, Offset: 0xa340
// Size: 0x154
function function_81e1861d(var_65f020d3) {
    scene::init(self.scriptbundlename);
    t_damage = getent("t_" + self.targetname + "_damage", "targetname");
    while (true) {
        t_damage waittill(#"damage", damage, attacker, direction, point, type, tagname, modelname, partname, weapon);
        if (isplayer(attacker)) {
            if (isdefined(var_65f020d3)) {
                level thread [[ var_65f020d3 ]]();
            }
            scene::play(self.scriptbundlename);
            namespace_769dc23f::function_b5cf7b68();
            break;
        }
        wait 0.1;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 5, eflags: 0x0
// Checksum 0xdf8cda40, Offset: 0xa4a0
// Size: 0x1a8
function function_5ec7eb7d(v_position, n_radius, n_height, var_9a868e4d, var_694b7da) {
    if (!isdefined(var_9a868e4d)) {
        var_9a868e4d = 0;
    }
    if (!isdefined(var_694b7da)) {
        var_694b7da = "trigger_radius";
    }
    assert(isdefined(v_position), "<dev string:x28>");
    assert(isdefined(n_radius), "<dev string:x5e>");
    assert(isdefined(n_height), "<dev string:x92>");
    t_use = spawn(var_694b7da, v_position, getvehicletriggerflags(), n_radius, n_height);
    t_use triggerignoreteam();
    t_use setvisibletoall();
    t_use setteamfortrigger("none");
    t_use usetriggerrequirelookat();
    if (var_694b7da == "trigger_radius_use") {
        t_use setcursorhint("HINT_NOICON");
    }
    return t_use;
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0xdddc7c52, Offset: 0xa650
// Size: 0x44
function function_1f3c3c34(str_group) {
    scene::init(self.scriptbundlename);
    level waittill(str_group);
    scene::play(self.scriptbundlename);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 1, eflags: 0x0
// Checksum 0x3d7aa528, Offset: 0xa6a0
// Size: 0x190
function function_39af75ef(str_endon) {
    self endon(#"disconnect");
    while (true) {
        if (isdefined(self.laststand) && self.laststand || !isalive(self)) {
            while (isdefined(self.laststand) && self.laststand || !isalive(self)) {
                wait 0.05;
            }
            self.var_5ea9c8b7 = undefined;
        }
        if (self isplayerunderwater() && !(isdefined(self.var_5ea9c8b7) && self.var_5ea9c8b7)) {
            self.var_5ea9c8b7 = 1;
            self thread clientfield::set_to_player("set_underwater_fx", 1);
            self thread hazard::function_e9b126ef();
        } else if (isdefined(self.var_5ea9c8b7) && !self isplayerunderwater() && self.var_5ea9c8b7) {
            self.var_5ea9c8b7 = undefined;
            self thread clientfield::set_to_player("set_underwater_fx", 0);
            self thread hazard::function_60455f28("o2");
        }
        wait 0.05;
    }
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xf08ee328, Offset: 0xa838
// Size: 0x3c
function function_400cc8f4() {
    trigger::wait_till("trig_hide_dock_fxanims", "targetname");
    hidemiscmodels("fxanim_swamp01");
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0x772ee117, Offset: 0xa880
// Size: 0xa4
function function_312d4b85() {
    level.var_c141dfcb[0] vehicle::toggle_ambient_anim_group(1, 1);
    level.var_c141dfcb[1] vehicle::toggle_ambient_anim_group(1, 1);
    level.var_c141dfcb[0] vehicle::toggle_ambient_anim_group(2, 0);
    level.var_c141dfcb[1] vehicle::toggle_ambient_anim_group(2, 0);
}

// Namespace cp_mi_sing_biodomes_swamp
// Params 0, eflags: 0x0
// Checksum 0xafe0f617, Offset: 0xa930
// Size: 0xa4
function function_c5f21db5() {
    level.var_c141dfcb[0] vehicle::toggle_ambient_anim_group(1, 0);
    level.var_c141dfcb[1] vehicle::toggle_ambient_anim_group(1, 0);
    level.var_c141dfcb[0] vehicle::toggle_ambient_anim_group(2, 1);
    level.var_c141dfcb[1] vehicle::toggle_ambient_anim_group(2, 1);
}

