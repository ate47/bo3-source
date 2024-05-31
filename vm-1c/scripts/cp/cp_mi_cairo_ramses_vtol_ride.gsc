#using scripts/cp/cp_mi_cairo_ramses_utility;
#using scripts/cp/cp_mi_cairo_ramses_station_fight;
#using scripts/cp/cp_mi_cairo_ramses_station_walk;
#using scripts/cp/cp_mi_cairo_ramses_sound;
#using scripts/cp/cp_mi_cairo_ramses_fx;
#using scripts/cp/_util;
#using scripts/cp/_skipto;
#using scripts/cp/_oed;
#using scripts/cp/_objectives;
#using scripts/cp/_load;
#using scripts/cp/_dialog;
#using scripts/cp/_debug;
#using scripts/cp/gametypes/_battlechatter;
#using scripts/shared/turret_shared;
#using scripts/shared/vehicleriders_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/lui_shared;
#using scripts/shared/gameobjects_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/compass;
#using scripts/shared/colors_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/ai_shared;
#using scripts/codescripts/struct;

#namespace namespace_80a43443;

// Namespace namespace_80a43443
// Params 2, eflags: 0x1 linked
// Checksum 0x8bdff98d, Offset: 0x1940
// Size: 0x16c
function init(str_objective, var_74cd64bc) {
    function_51a2f97e();
    array::thread_all(getentarray("ammo_cache", "script_noteworthy"), &oed::function_e228c18a, 1);
    level._effect["vtol_thruster"] = "vehicle/fx_vtol_thruster_vista";
    battlechatter::function_d9f49fba(0, "bc");
    spawner::add_spawn_function_group("staging_area_jumpdirect_guy01", "targetname", &function_163908b8);
    spawner::add_spawn_function_group("staging_area_allies", "script_string", &function_d61ac79f);
    vehicle::add_spawn_function_by_type("veh_bo3_mil_vtol", &function_b946efd6);
    function_9520a3b9(str_objective, var_74cd64bc);
    main();
    skipto::function_be8adfb8("vtol_ride");
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x996e0f23, Offset: 0x1ab8
// Size: 0x124
function function_51a2f97e() {
    level flag::init("jumpdirect_loops_started");
    level flag::init("jumpdirect_scene_done");
    level flag::init("staging_area_enter_started");
    level flag::init("trucks_ready");
    level flag::init("heroes_start_truck_anims");
    level flag::init("player_enter_hero_truck_started");
    level flag::init("players_ready");
    level flag::init("vtol_ride_players_in_position");
    level flag::init("vtol_ride_temp_probe_linked");
}

// Namespace namespace_80a43443
// Params 2, eflags: 0x1 linked
// Checksum 0xa9a36198, Offset: 0x1be8
// Size: 0xec
function function_9520a3b9(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        load::function_73adcefc();
        level thread namespace_7434c6b7::function_bbd12ed2(0);
        exploder::exploder("fx_exploder_vtol_crash");
        namespace_bedc6a60::function_6327cae3();
        level thread scene::play("p7_fxanim_cp_ramses_lotus_towers_hunters_swarm_bundle");
    }
    level thread function_4492caaa();
    exploder::exploder("fx_exploder_staging_area_mortars");
    function_e29f0dd6(str_objective, var_74cd64bc);
    function_f87b2c29(var_74cd64bc);
}

// Namespace namespace_80a43443
// Params 4, eflags: 0x1 linked
// Checksum 0x6f0a2d59, Offset: 0x1ce0
// Size: 0x44
function done(str_objective, var_74cd64bc, var_e4cd2b8b, player) {
    level flag::set("vtol_ride_done");
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x50093671, Offset: 0x1d30
// Size: 0xb2
function main() {
    level flag::set("vtol_ride_event_started");
    level.var_e32d239b = 0;
    level.var_6b2d0ae6 = 0;
    level thread objectives();
    level thread scenes();
    level thread vo();
    function_e8e62f90();
    level notify(#"hash_f8453165");
    level.var_e32d239b = undefined;
    level.var_6b2d0ae6 = undefined;
}

// Namespace namespace_80a43443
// Params 2, eflags: 0x1 linked
// Checksum 0x3bfdb7e2, Offset: 0x1df0
// Size: 0x174
function function_e29f0dd6(str_objective, var_74cd64bc) {
    if (var_74cd64bc) {
        level.var_2fd26037 = util::function_740f8516("hendricks");
        level.var_9db406db = util::function_740f8516("khalil");
        skipto::teleport_ai(str_objective, level.heroes);
    }
    level.var_2fd26037 colors::disable();
    level.var_9db406db colors::disable();
    level.var_2fd26037.goalradius = 64;
    level.var_9db406db.goalradius = 64;
    level.var_2fd26037 ai::set_behavior_attribute("disablesprint", 1);
    level.var_2fd26037 ai::set_behavior_attribute("vignette_mode", "fast");
    level.var_9db406db ai::set_behavior_attribute("disablesprint", 1);
    level.var_9db406db ai::set_behavior_attribute("vignette_mode", "fast");
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0x58503a18, Offset: 0x1f70
// Size: 0x3b4
function function_f87b2c29(var_74cd64bc) {
    if (var_74cd64bc) {
        level scene::skipto_end("p7_fxanim_cp_ramses_station_ceiling_vtol_bundle");
        level scene::skipto_end("p7_fxanim_cp_ramses_station_ceiling_vtol_crashed_bundle");
        level scene::init("p_ramses_lift_wing_blockage");
        level thread scene::play("cin_ram_04_02_easterncheck_vign_jumpdirect_hendricks");
        level thread scene::play("cin_ram_04_02_easterncheck_vign_jumpdirect_khalil");
        level notify(#"hash_1ca7165");
        level notify(#"hash_77815dc");
        exploder::exploder("vtol_crash");
        exploder::exploder("fx_exploder_station_ambient_post_collapse");
        exploder::exploder("fx_exploder_dropship_hits_floor");
        exploder::exploder("fx_exploder_dropship_through_ceiling");
        exploder::exploder("fx_exploder_dropship_hits_column");
        exploder::exploder("fx_exploder_dropship_through_ceiling_02");
        exploder::exploder("fx_exploder_dropship_through_ceiling_03");
        level thread namespace_bedc6a60::function_e4e450c1();
        var_673a4bf = getentarray("station_ceiling_pristine", "targetname");
        foreach (piece in var_673a4bf) {
            piece delete();
        }
        var_2f5160f4 = getentarray("roof_hole_blocker", "targetname");
        foreach (e_blocker in var_2f5160f4) {
            e_blocker hide();
        }
        level util::function_d8eaed3d(3, 1);
        load::function_a2995f22(1);
        namespace_bedc6a60::function_eede49df();
        namespace_bedc6a60::function_c5b9bd41("_combat");
        namespace_bedc6a60::function_14b2c542();
        namespace_391e4301::function_e950228a();
        level flag::set("ceiling_collapse_complete");
        level notify(#"hash_eae489c0");
        level notify(#"hash_d758e82");
        level thread namespace_bedc6a60::function_1d0e7c11();
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xccfb315b, Offset: 0x2330
// Size: 0x8c
function function_b946efd6() {
    util::wait_network_frame();
    playfxontag(level._effect["vtol_thruster"], self, "tag_fx_engine_left");
    playfxontag(level._effect["vtol_thruster"], self, "tag_fx_engine_right");
    self vehicle::toggle_sounds(0);
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x12f265b8, Offset: 0x23c8
// Size: 0xe4
function function_d61ac79f() {
    self.goalradius = 64;
    self ai::set_ignoreall(1);
    self ai::set_ignoreme(1);
    self ai::set_behavior_attribute("disablearrivals", 1);
    self ai::set_behavior_attribute("disablesprint", 1);
    self ai::set_behavior_attribute("vignette_mode", "slow");
    if (self.script_noteworthy === "does_walk") {
        self ai::set_behavior_attribute("patrol", 1);
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x15cf88e0, Offset: 0x24b8
// Size: 0x21c
function function_e8e62f90() {
    level thread function_b7170f9e("staging_area_background_vtol", 3);
    function_4199310b();
    function_719a5145();
    objectives::complete("cp_level_ramses_protect_salim");
    objectives::set("cp_level_ramses_eastern_checkpoint");
    function_bb173a03();
    callback::on_spawned(&function_9778ae44);
    callback::on_spawned(&namespace_391e4301::function_c3080ff8);
    level.players function_9778ae44();
    level thread function_8ec9bf83();
    level thread function_4e3398e0();
    spawner::simple_spawn("staging_area_background_technical_01", &function_226410e6);
    level flag::wait_till("trucks_ready");
    objectives::set("cp_level_ramses_board");
    trigger::wait_till("staging_area_enter_trig");
    level thread function_b7170f9e("staging_area_overhead_vtol", 3);
    level flag::wait_till("players_ready");
    objectives::complete("cp_level_ramses_board");
    level notify(#"hash_e99a85b4");
    level util::clientnotify("sndLevelEnd");
    util::screen_fade_out(2);
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x99b9738d, Offset: 0x26e0
// Size: 0xb4
function function_719a5145() {
    level endon(#"hash_ddf95d21");
    level thread function_d3b86c9f(10);
    level thread function_637a00da();
    level thread function_5813f4ec();
    level flag::wait_till("jumpdirect_loops_started");
    level flag::wait_till("hendricks_jumpdirect_looping");
    level flag::wait_till("khalil_jumpdirect_looping");
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0x20c2e3b1, Offset: 0x27a0
// Size: 0x1e
function function_d3b86c9f(n_timer) {
    wait(n_timer);
    level notify(#"hash_ddf95d21");
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xcaa31cea, Offset: 0x27c8
// Size: 0x2c
function function_637a00da() {
    level waittill(#"hash_1910f11d");
    level flag::set("hendricks_jumpdirect_looping");
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xedf659bf, Offset: 0x2800
// Size: 0x2c
function function_5813f4ec() {
    level waittill(#"hash_2cca5b8f");
    level flag::set("khalil_jumpdirect_looping");
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x926ce03f, Offset: 0x2838
// Size: 0x112
function function_4e3398e0() {
    level waittill(#"hash_585a73e3");
    callback::remove_on_spawned(&function_9778ae44);
    callback::on_spawned(&function_a10d0d8a);
    level.players function_81f6093f();
    foreach (player in level.players) {
        player allowjump(1);
        player allowdoublejump(0);
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xd286d22f, Offset: 0x2958
// Size: 0x34
function function_a10d0d8a() {
    self allowjump(1);
    self allowdoublejump(0);
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0x2e5851e5, Offset: 0x2998
// Size: 0xf2
function function_9778ae44(var_d9cd2a00) {
    if (!isdefined(var_d9cd2a00)) {
        var_d9cd2a00 = 0.4;
    }
    if (isarray(self)) {
        a_e_players = self;
    } else {
        a_e_players = array(self);
    }
    foreach (e_player in a_e_players) {
        e_player thread function_bfaa9238(var_d9cd2a00);
    }
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0x4c4469a0, Offset: 0x2a98
// Size: 0xac
function function_bfaa9238(var_d9cd2a00) {
    if (!isdefined(var_d9cd2a00)) {
        var_d9cd2a00 = 0.4;
    }
    self endon(#"hash_fc969024");
    self endon(#"death");
    trigger::wait_till("trig_start_station_exit_tether", "targetname", self);
    self thread namespace_391e4301::function_24b86d60(level.var_9db406db, "stop_tether", 72, -112, var_d9cd2a00, 1, 66);
    self thread namespace_391e4301::function_c3080ff8();
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xbd94d847, Offset: 0x2b50
// Size: 0x152
function function_81f6093f() {
    if (isarray(self)) {
        a_e_players = self;
    } else {
        a_e_players = array(self);
    }
    foreach (e_player in a_e_players) {
        e_player notify(#"hash_fc969024");
    }
    wait(0.05);
    foreach (e_player in a_e_players) {
        e_player setmovespeedscale(1);
    }
}

// Namespace namespace_80a43443
// Params 4, eflags: 0x1 linked
// Checksum 0x46f65105, Offset: 0x2cb0
// Size: 0x2b0
function function_20a0583c(var_d0d78bd6, spawners, minwait, maxwait) {
    if (!isdefined(minwait)) {
        minwait = 2;
    }
    if (!isdefined(maxwait)) {
        maxwait = 3;
    }
    var_b53abf06 = 0;
    var_89e465d0 = 64;
    var_c6eac35a = 96;
    while (var_b53abf06 < var_d0d78bd6) {
        ais = spawner::simple_spawn(array::random(spawners));
        var_b53abf06++;
        foreach (ai in ais) {
            ai.goalradius = randomintrange(var_89e465d0, var_c6eac35a);
            if (randomint(100) < 30) {
                ai ai::set_behavior_attribute("sprint", 1);
            }
            if (randomint(100) < 25) {
                sndent = spawn("script_origin", ai.origin);
                sndent linkto(ai);
                sndent playloopsound("amb_walla_battlechatter", 1);
                ai thread function_587c5a03(sndent);
            }
        }
        if (var_b53abf06 == 1) {
            var_7000f414 = array::random(ais);
            if (isdefined(var_7000f414)) {
                var_7000f414 thread function_b8a391f4();
            }
        }
        wait(randomintrange(minwait, maxwait));
    }
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0x4410be52, Offset: 0x2f68
// Size: 0x2c
function function_587c5a03(sndent) {
    self waittill(#"death");
    sndent delete();
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x8853aa29, Offset: 0x2fa0
// Size: 0x15c
function function_28cbacfb() {
    var_300210d5 = getentarray("staging_area_sidewalk_guys_left", "targetname");
    var_abb4d038 = getentarray("staging_area_sidewalk_guys_right", "targetname");
    var_d0d78bd6 = 4;
    var_6e3117c = 6;
    level thread function_20a0583c(var_d0d78bd6, var_300210d5, 3, 6);
    level thread function_20a0583c(var_d0d78bd6, var_abb4d038, 3, 6);
    wait(var_6e3117c);
    level flag::wait_till("trucks_ready");
    trigger::wait_or_timeout(var_6e3117c, "staging_area_enter_trig", "targetname");
    level thread function_20a0583c(var_d0d78bd6, var_300210d5);
    level thread function_20a0583c(var_d0d78bd6, var_abb4d038);
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x72bb0dc5, Offset: 0x3108
// Size: 0x124
function function_749a5dc9() {
    var_300210d5 = getentarray("staging_area_background_runners_left", "targetname");
    var_abb4d038 = getentarray("staging_area_background_runners_right", "targetname");
    var_d0d78bd6 = 3;
    var_6e3117c = 10;
    level thread function_20a0583c(var_d0d78bd6, var_300210d5, 3, 6);
    level thread function_20a0583c(var_d0d78bd6, var_abb4d038, 3, 6);
    wait(var_6e3117c);
    level thread function_20a0583c(var_d0d78bd6, var_300210d5, 3, 6);
    level thread function_20a0583c(var_d0d78bd6, var_abb4d038, 3, 6);
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xb4c7d244, Offset: 0x3238
// Size: 0xa4
function function_7bac890d() {
    var_abb4d038 = getentarray("staging_area_background_runners2", "targetname");
    var_d0d78bd6 = 3;
    var_6e3117c = 10;
    level thread function_20a0583c(var_d0d78bd6, var_abb4d038, 3, 6);
    wait(var_6e3117c);
    level thread function_20a0583c(var_d0d78bd6, var_abb4d038, 3, 6);
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x5317ea4e, Offset: 0x32e8
// Size: 0x178
function function_ae408b2c() {
    var_ddb0d40f = 36;
    while (true) {
        if (getaiarray().size < var_ddb0d40f) {
            level thread function_28cbacfb();
        }
        level flag::wait_till("trucks_ready");
        minwaittime = 7;
        maxwaittime = 11;
        wait(randomintrange(minwaittime, maxwaittime));
        if (getaiarray().size < var_ddb0d40f) {
            level thread function_749a5dc9();
        }
        minwaittime = 11;
        maxwaittime = 13;
        wait(randomintrange(minwaittime, maxwaittime));
        if (getaiarray().size < var_ddb0d40f) {
            level thread function_7bac890d();
        }
        minwaittime = 10;
        maxwaittime = 14;
        wait(randomintrange(minwaittime, maxwaittime));
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x58a43413, Offset: 0x3468
// Size: 0x1cc
function function_bb173a03() {
    s_exit = struct::get("ramses_station_exit_obj", "targetname");
    t_exit = spawn("trigger_radius_use", s_exit.origin, 0, 50, 64);
    t_exit triggerignoreteam();
    t_exit setvisibletoall();
    t_exit setteamfortrigger("none");
    mdl_gameobject = util::function_14518e76(t_exit, %cp_level_ramses_exit_station, %CP_MI_CAIRO_RAMSES_MOVE_ASIDE, &function_9b7c2788);
    mdl_gameobject waittill(#"hash_c2b847e5");
    if (isdefined(level.var_71d5e545)) {
        level thread [[ level.var_71d5e545 ]]();
    }
    level flag::set("station_exit_removed");
    e_blocker = getent(s_exit.target, "targetname");
    e_blocker delete();
    mdl_gameobject gameobjects::disable_object();
    objectives::complete("cp_level_ramses_exit_station");
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xa5562c17, Offset: 0x3640
// Size: 0x90
function function_8ec9bf83() {
    level endon(#"hash_e99a85b4");
    var_c4a1b346 = getent("staging_area_ai_cleanup_aitrig", "targetname");
    while (true) {
        ai_cleanup = var_c4a1b346 waittill(#"trigger");
        if (isai(ai_cleanup)) {
            ai_cleanup delete();
        }
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x0
// Checksum 0x3ea2b140, Offset: 0x36d8
// Size: 0xc6
function function_5cb0e184() {
    var_3b0df191 = 0;
    str_name = "";
    foreach (var_8339cb0d in self) {
        if (str_name != var_8339cb0d.targetname) {
            var_3b0df191++;
        }
        str_name = var_8339cb0d.targetname;
    }
    return var_3b0df191;
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x0
// Checksum 0xad321806, Offset: 0x37a8
// Size: 0xe0
function function_7f4396ab(var_4b5be224) {
    var_186e2482 = [];
    for (i = 1; i < var_4b5be224 + 1; i++) {
        var_a1235c6c = getspawnerarray("staging_area_background_runners" + i, "targetname");
        if (!isdefined(var_186e2482)) {
            var_186e2482 = [];
        } else if (!isarray(var_186e2482)) {
            var_186e2482 = array(var_186e2482);
        }
        var_186e2482[var_186e2482.size] = var_a1235c6c;
    }
    return var_186e2482;
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x0
// Checksum 0x53b8f877, Offset: 0x3890
// Size: 0x74
function function_49a7f92a(var_6c5c89e1) {
    var_9de10fe3 = getnode(var_6c5c89e1, "targetname");
    self setgoal(var_9de10fe3, 1);
    self waittill(#"goal");
    self clearforcedgoal();
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xfec243fd, Offset: 0x3910
// Size: 0x122
function function_4199310b() {
    var_dfac08c2 = struct::get_array("vtol_ride_staging_area_prop_spots", "script_noteworthy");
    foreach (s in var_dfac08c2) {
        var_6be11642 = util::spawn_model(s.model, s.origin, s.angles);
        var_6be11642.targetname = s.targetname;
        var_6be11642.script_objective = "vtol_ride";
        util::wait_network_frame();
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x0
// Checksum 0x1bb52f6e, Offset: 0x3a40
// Size: 0xf4
function function_80a43443() {
    var_6e02a600 = getentarray("vtol_ride_trig", "script_noteworthy");
    level waittill(#"hash_3d44865d");
    var_6e02a600 init_flags("_ready");
    var_6e02a600 function_9b92c048("_ready");
    level flag::set("vtol_ride_started");
    level thread function_6c678d00();
    level flag::wait_till("mobile_wall_fxanim_start");
    level flag::set("dead_turret_stop_station_ambients");
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x21b3317c, Offset: 0x3b40
// Size: 0x4c
function function_6c678d00() {
    level thread function_8dfea4a5();
    level thread function_58382ac0();
    level thread function_aa774b42();
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xbc6d5481, Offset: 0x3b98
// Size: 0x46c
function function_8dfea4a5() {
    var_48964153 = [];
    foreach (e_turret in level.var_9657b09b) {
        if (isdefined(e_turret.script_int) && e_turret.script_int == 1) {
            var_48964153[var_48964153.size] = e_turret;
        }
    }
    var_bbfd71d6 = getvehiclenode("spawn_amb_vtol_1", "script_noteworthy");
    var_bbfd71d6 waittill(#"trigger");
    var_299edd3a = getentarray("amb_vtol_quads", "targetname");
    var_ed1d84d = getvehiclenode("vtol_1_crash_node", "script_noteworthy");
    var_6300e38d = util::spawn_model("script_origin", var_ed1d84d.origin, var_ed1d84d.angles);
    var_6300e38d setinvisibletoall();
    foreach (e_turret in var_48964153) {
        e_turret turret::set_target(var_6300e38d, undefined, 0);
    }
    var_ed1d84d waittill(#"trigger");
    foreach (e_turret in var_48964153) {
        e_turret thread turret::fire_for_time(4, 0);
    }
    var_34d452b6 = getvehiclenode("vtol_2_crash_node", "script_noteworthy");
    var_6300e38d = util::spawn_model("script_origin", var_34d452b6.origin, var_34d452b6.angles);
    var_6300e38d setinvisibletoall();
    foreach (e_turret in var_48964153) {
        e_turret turret::set_target(var_6300e38d, undefined, 0);
    }
    var_34d452b6 waittill(#"trigger");
    foreach (e_turret in var_48964153) {
        e_turret thread turret::fire_for_time(4, 0);
    }
    var_6300e38d delete();
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xb330e96a, Offset: 0x4010
// Size: 0x3fc
function function_58382ac0() {
    var_48964153 = [];
    foreach (e_turret in level.var_9657b09b) {
        if (isdefined(e_turret.script_int) && e_turret.script_int == 0) {
            var_48964153[var_48964153.size] = e_turret;
        }
    }
    var_1969a71e = getvehiclenode("vtol_3_crash_node", "script_noteworthy");
    var_6300e38d = util::spawn_model("script_origin", var_1969a71e.origin, var_1969a71e.angles);
    var_6300e38d setinvisibletoall();
    foreach (e_turret in var_48964153) {
        e_turret turret::set_target(var_6300e38d, undefined, 0);
    }
    var_1969a71e waittill(#"trigger");
    foreach (e_turret in var_48964153) {
        e_turret thread turret::fire_for_time(4, 0);
    }
    var_5b5d4311 = getvehiclenode("vtol_4_crash_node", "script_noteworthy");
    var_6300e38d = util::spawn_model("script_origin", var_5b5d4311.origin, var_5b5d4311.angles);
    var_6300e38d setinvisibletoall();
    foreach (e_turret in var_48964153) {
        e_turret turret::set_target(var_6300e38d, undefined, 0);
    }
    var_5b5d4311 waittill(#"trigger");
    foreach (e_turret in var_48964153) {
        e_turret thread turret::fire_for_time(4, 0);
    }
    var_6300e38d delete();
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x107293fa, Offset: 0x4418
// Size: 0x2b2
function function_aa774b42() {
    var_e416d54a = getvehiclenode("start_egypt_runners_1", "script_noteworthy");
    var_e416d54a waittill(#"trigger");
    var_f24c69d3 = getentarray("vtol_egyptian_runners_1", "targetname");
    foreach (var_8339cb0d in var_f24c69d3) {
        var_67440414 = var_8339cb0d spawner::spawn();
        var_67440414 thread function_e89af9c8();
    }
    var_be145ae1 = getvehiclenode("start_egypt_runners_2", "script_noteworthy");
    var_be145ae1 waittill(#"trigger");
    var_f24c69d3 = getentarray("vtol_egyptian_runners_2", "targetname");
    foreach (var_8339cb0d in var_f24c69d3) {
        var_67440414 = var_8339cb0d spawner::spawn();
        var_67440414 thread function_e89af9c8();
    }
    var_f24c69d3 = getentarray("vtol_egyptian_runners_3", "targetname");
    foreach (var_8339cb0d in var_f24c69d3) {
        var_67440414 = var_8339cb0d spawner::spawn();
        var_67440414 thread function_e89af9c8();
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x318228ee, Offset: 0x46d8
// Size: 0x7c
function function_e89af9c8() {
    self endon(#"death");
    var_9de10fe3 = getnode(self.target, "targetname");
    self thread ai::force_goal(var_9de10fe3, 32, 0);
    self waittill(#"goal");
    wait(5);
    self delete();
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xb1a380d0, Offset: 0x4760
// Size: 0x3c
function objectives() {
    level flag::wait_till("players_ready");
    objectives::complete("cp_level_ramses_eastern_checkpoint");
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x2327ca72, Offset: 0x47a8
// Size: 0x48c
function scenes() {
    level.var_9db406db flag::init("khalil_ready");
    level.var_9db406db flag::init("khalil_init");
    level clientfield::set("staging_area_intro", 1);
    scene::add_scene_func("p7_fxanim_cp_ramses_wall_carry_bundle", &function_ca7c574d, "init");
    scene::add_scene_func("cin_ram_04_01_staging_vign_finisher", &function_29d8f4e5, "done");
    level scene::init("p7_fxanim_cp_ramses_wall_carry_bundle");
    util::wait_network_frame();
    level scene::init("p7_fxanim_cp_ramses_wall_carry_02_bundle");
    util::wait_network_frame();
    level scene::init("p7_fxanim_cp_ramses_wall_carry_03_bundle");
    level scene::init("cin_ram_04_01_staging_vign_help");
    util::wait_network_frame();
    level scene::init("cin_ram_04_01_staging_vign_help_alt");
    util::wait_network_frame();
    level scene::init("cin_ram_04_01_staging_vign_logistics");
    util::wait_network_frame();
    level scene::init("cin_ram_04_01_staging_vign_trafficcop");
    level scene::init("cin_ram_04_02_easterncheck_vign_jumpdirect");
    level thread scene::play("staging_area_ambient_egyptians", "targetname");
    level flag::set("jumpdirect_loops_started");
    function_55051636();
    level thread function_429ae99d();
    level waittill(#"hash_55490bd7");
    level thread function_b33ae280();
    level flag::wait_till("staging_area_enter_started");
    level thread function_ca24177d(20);
    level flag::wait_till_timeout(20, "staging_area_ambient_start");
    level thread scene::play("p7_fxanim_cp_ramses_wall_carry_bundle");
    level clientfield::set("staging_area_intro", 0);
    level thread function_d8e0d27e();
    level waittill(#"hash_3d44865d");
    level thread scene::play("cin_ram_04_01_staging_vign_help_alt");
    scene::add_scene_func("p7_fxanim_cp_ramses_vtol_ride_bundle", &function_b8babc3, "init");
    level scene::init("p7_fxanim_cp_ramses_vtol_ride_bundle");
    level waittill(#"hash_e8369b0d");
    level thread scene::play("cin_ram_04_01_staging_vign_help");
    level thread scene::play("cin_ram_04_01_staging_vign_logistics");
    level thread scene::play("cin_ram_04_01_staging_vign_trafficcop");
    wait(randomfloatrange(2, 4));
    level thread scene::play("p7_fxanim_cp_ramses_wall_carry_03_bundle");
    wait(3);
    level thread function_ae408b2c();
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x8309c76f, Offset: 0x4c40
// Size: 0x10a
function function_ca7c574d() {
    level.var_7902293a = array(getent("wall_carry_wall", "targetname"), getent("wall_carry_doors", "targetname"), getent("wall_carry_harness", "targetname"));
    foreach (part in level.var_7902293a) {
        part setdedicatedshadow(1);
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x10c546bc, Offset: 0x4d58
// Size: 0x102
function function_55051636() {
    a_str_scenes = array("cin_sgen_12_02_corvus_vign_deadpose_robot01_ontummy", "cin_sgen_12_02_corvus_vign_deadpose_robot02_onback01", "cin_sgen_12_02_corvus_vign_deadpose_robot03_onback02", "cin_sgen_12_02_corvus_vign_deadpose_robot04_onside", "cin_sgen_12_02_corvus_vign_deadpose_robot05_onwallsitting");
    foreach (str_scene in a_str_scenes) {
        var_1479fabb = function_4c890267();
        level thread scene::play(str_scene, var_1479fabb);
        util::wait_network_frame();
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x98bbaf52, Offset: 0x4e68
// Size: 0x1c0
function function_4c890267() {
    var_58f06a18 = 80;
    var_7471f3fc = "c_nrc_robot_grunt_head";
    var_44bc45bf = array("c_nrc_robot_grunt_g_upclean", "c_nrc_robot_grunt_g_rarmoff", "c_nrc_robot_grunt_g_larmoff");
    var_1fee561d = array("c_nrc_robot_grunt_g_lowclean", "c_nrc_robot_grunt_g_blegsoff", "c_nrc_robot_grunt_g_rlegoff");
    var_1479fabb = util::spawn_model(array::random(var_44bc45bf), (0, 0, 0), (0, 0, 0));
    var_1bc1366 = array::random(var_1fee561d);
    var_1479fabb attach(var_1bc1366);
    if (var_1bc1366 == "c_nrc_robot_grunt_g_blegsoff") {
        var_1479fabb hidepart("j_knee_ri_dam");
    } else {
        var_1479fabb attach("c_nrc_robot_dam_1_g_llegspawn");
    }
    var_1479fabb attach("c_nrc_robot_dam_1_g_rlegspawn");
    if (randomint(100) < var_58f06a18) {
        var_1479fabb attach(var_7471f3fc);
    }
    return var_1479fabb;
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x942b88a2, Offset: 0x5030
// Size: 0x13c
function function_b33ae280() {
    if (scene::is_active("cin_ram_04_02_easterncheck_vign_jumpdirect_hendricks")) {
        scene::stop("cin_ram_04_02_easterncheck_vign_jumpdirect_hendricks");
    }
    if (scene::is_active("cin_ram_04_02_easterncheck_vign_jumpdirect_khalil")) {
        scene::stop("cin_ram_04_02_easterncheck_vign_jumpdirect_khalil");
    }
    if (!isdefined(level.var_2fd26037)) {
        level.var_2fd26037 = util::function_740f8516("hendricks");
    }
    scene::add_scene_func("cin_ram_04_02_easterncheck_vign_jumpdirect", &function_b1758ff5, "done");
    level thread scene::play("cin_ram_04_02_easterncheck_vign_jumpdirect");
    array::wait_till(array(level.var_2fd26037, level.var_9db406db), "ready_to_move");
    level flag::set("jumpdirect_scene_done");
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0x370e4550, Offset: 0x5178
// Size: 0x8c
function function_b1758ff5(a_ents) {
    var_edc5d3d5 = a_ents["staging_area_jumpdirect_guy02"];
    wait(randomintrange(11, 12));
    nd_path = getnode("node_jumpdirect_guy02_path", "targetname");
    var_edc5d3d5 ai::patrol(nd_path);
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xc82126df, Offset: 0x5210
// Size: 0xcc
function function_163908b8() {
    var_5dc95129 = getnode("node_jumpdirect_guy01_wait", "targetname");
    self setgoal(var_5dc95129, 1);
    level flag::wait_till("heroes_start_truck_anims");
    wait(randomintrange(2, 3));
    nd_path = getnode("node_jumpdirect_guy01_path", "targetname");
    self ai::patrol(nd_path);
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0x8ac116f5, Offset: 0x52e8
// Size: 0x1ec
function function_ca24177d(n_timeout) {
    str_scene_name = "cin_ram_04_01_staging_vign_finisher";
    var_b4d3a3bd = array("c_nrc_robot_grunt_g_blegsoff", "c_nrc_robot_grunt_head");
    var_5aac3d30 = array("j_hip_le_dam", "j_knee_ri_dam");
    var_db276508 = array("c_nrc_robot_grunt_g_rlegoff", "c_nrc_robot_grunt_head");
    var_b478c00a = util::spawn_model("c_nrc_robot_grunt_g_upclean", (0, 0, 0), (0, 0, 0));
    var_424a279d = util::spawn_model("c_nrc_robot_grunt_g_rarmoff", (0, 0, 0), (0, 0, 0));
    var_424a279d function_96449bd2(var_db276508);
    var_b478c00a function_96449bd2(var_b4d3a3bd, var_5aac3d30);
    var_fbbef3a["robot_crawler_01"] = var_424a279d;
    var_fbbef3a["robot_crawler_02"] = var_b478c00a;
    level scene::init(str_scene_name, var_fbbef3a);
    level flag::wait_till_any_timeout(n_timeout, array("staging_area_kills_start", "staging_area_ambient_start"));
    level scene::play(str_scene_name, var_fbbef3a);
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0x6c5cf40b, Offset: 0x54e0
// Size: 0xa4
function function_29d8f4e5(a_ents) {
    ai_guy = a_ents["staging_area_vign_finisher_guy"];
    ai_guy setgoal(self.origin);
    wait(randomintrange(8, 10));
    nd_path = getnode("node_vign_finisher_path", "targetname");
    ai_guy ai::patrol(nd_path);
}

// Namespace namespace_80a43443
// Params 2, eflags: 0x1 linked
// Checksum 0xfcfb395c, Offset: 0x5590
// Size: 0x132
function function_96449bd2(var_c2aab2dd, var_3a2aaa4f) {
    if (!isdefined(var_3a2aaa4f)) {
        var_3a2aaa4f = [];
    }
    foreach (str_part in var_c2aab2dd) {
        self attach(str_part);
    }
    foreach (str_tag in var_3a2aaa4f) {
        self hidepart(str_tag);
    }
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0x478d84d8, Offset: 0x56d0
// Size: 0xa2
function function_9b7c2788(e_player) {
    str_name = "p_ramses_lift_wing_blockage";
    scene::add_scene_func(str_name, &function_3031a196, "play");
    scene::add_scene_func(str_name, &function_75f74956, "done");
    level thread scene::play(str_name, e_player);
    self notify(#"hash_c2b847e5");
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0xeeaaa888, Offset: 0x5780
// Size: 0x44
function function_3031a196(a_ents) {
    level notify(#"hash_55490bd7");
    level waittill(#"hash_15aca665");
    level flag::set("staging_area_enter_started");
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0x65ab9c5c, Offset: 0x57d0
// Size: 0x1c
function function_75f74956(a_ents) {
    util::clear_streamer_hint();
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x5d05795e, Offset: 0x57f8
// Size: 0x34
function function_3e1010fa() {
    level notify(#"hash_585a73e3");
    level thread function_9f0cc2c4();
    function_6a212876();
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xcbaa0768, Offset: 0x5838
// Size: 0x134
function function_6a212876() {
    level scene::play("cin_ram_04_02_easterncheck_vign_jumpdirect_hendricks_end");
    level.var_2fd26037 ai::set_behavior_attribute("vignette_mode", "fast");
    level.var_2fd26037.goalradius = 64;
    level.var_2fd26037 setgoal(getnode("vtol_ride_temp_hendricks_goal", "targetname"));
    level.var_2fd26037 ai::set_behavior_attribute("disablearrivals", 1);
    level.var_2fd26037 waittill(#"goal");
    level flag::set("heroes_start_truck_anims");
    level.var_2fd26037 sethighdetail(1);
    level scene::play("cin_ram_04_02_easterncheck_1st_entertruck_demo_hendricks");
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x5fb9b291, Offset: 0x5978
// Size: 0x18c
function function_9f0cc2c4() {
    level scene::play("cin_ram_04_02_easterncheck_vign_jumpdirect_khalil_end");
    level.var_9db406db ai::set_behavior_attribute("vignette_mode", "fast");
    level.var_9db406db.goalradius = 64;
    level.var_9db406db setgoal(getnode("vtol_ride_temp_khalil_goal", "targetname"));
    level.var_9db406db ai::set_behavior_attribute("disablearrivals", 1);
    level.var_9db406db waittill(#"goal");
    level.var_9db406db sethighdetail(1);
    level thread scene::init("cin_ram_04_02_easterncheck_1st_entertruck_demo_khalil");
    level.var_9db406db waittill(#"hash_9ef0805");
    level.var_9db406db flag::set("khalil_init");
    level.var_9db406db waittill(#"hash_fecf35c0");
    level.var_9db406db flag::set("khalil_ready");
    level thread namespace_e4c0c552::function_973b77f9();
}

// Namespace namespace_80a43443
// Params 3, eflags: 0x1 linked
// Checksum 0xfc2f8fbc, Offset: 0x5b10
// Size: 0xba
function function_3ae58c71(e_player, str_tag, var_35a302af) {
    if (str_tag == "tag_antenna1") {
        var_35a302af thread scene::play("cin_ram_04_02_easterncheck_1st_entertruck_demo2", e_player);
    } else {
        var_35a302af thread scene::play("cin_ram_04_02_easterncheck_1st_entertruck_demo", e_player);
    }
    level flag::set("player_enter_hero_truck_started");
    e_player thread function_77af1dc();
    e_player waittill(#"hash_15add06c");
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xc314db67, Offset: 0x5bd8
// Size: 0x4c
function function_77af1dc() {
    self endon(#"disconnect");
    var_376c2899 = 0.85;
    self waittill(#"hash_b5142ba0");
    self startcameratween(var_376c2899);
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0xa3ea9ad6, Offset: 0x5c30
// Size: 0x17c
function function_b8babc3(a_ents) {
    var_2eb506d6 = array(a_ents["technical_left"], a_ents["technical_right"]);
    var_e0da190b = array("tag_antenna1", "tag_antenna2");
    foreach (var_35a302af in var_2eb506d6) {
        var_35a302af thread function_1d44997f(var_e0da190b);
    }
    array::wait_till(var_2eb506d6, "ready_to_board");
    level flag::set("trucks_ready");
    array::wait_till(var_2eb506d6, "seats_full");
    level flag::set("players_ready");
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0x9ffbabc6, Offset: 0x5db8
// Size: 0x3c2
function function_1d44997f(var_e0da190b) {
    self function_52f443ca();
    if (self.targetname == "technical_left") {
        level waittill(#"hash_3e1010fa");
        level thread function_3e1010fa();
    }
    self waittill(#"stopped");
    v_origin = self gettagorigin("tag_bumper_rear_d0");
    v_angles = self gettagangles("tag_bumper_rear_d0");
    e_collision = getent(self.targetname + "_boarding_collision", "targetname");
    e_collision moveto(v_origin, 0.05);
    e_collision rotateto(v_angles + (0, 90, 0), 0.5);
    wait(1);
    self notify(#"hash_7062b02b");
    if (self.targetname == "technical_left") {
        var_3ffc3e83 = spawn("trigger_radius", self.origin, 0, 666, 256);
        var_3ffc3e83 waittill(#"trigger");
        var_3ffc3e83 delete();
        level.var_9db406db flag::wait_till_timeout(10, "khalil_init");
        level thread scene::play("p7_fxanim_cp_ramses_wall_carry_02_bundle");
        level thread scene::play("cin_ram_04_02_easterncheck_1st_entertruck_demo_khalil");
    }
    level.var_9db406db flag::wait_till("khalil_ready");
    self.var_3c1d8edf = 0;
    self thread function_85aceb92(var_e0da190b);
    foreach (str_tag in var_e0da190b) {
        v_offset = v_origin + anglestoforward(v_angles) * 20;
        var_b3268be4 = spawn("trigger_box_use", v_offset, 0, 36, 32, 48);
        var_b3268be4.angles = v_angles;
        var_b3268be4.targetname = str_tag;
        var_b3268be4 function_9de6dff0(self, var_e0da190b);
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x4ca12015, Offset: 0x6188
// Size: 0x10e
function function_52f443ca() {
    var_39352a5 = [];
    var_2ffb0686 = array("driver", "passenger1");
    var_3f100131 = array("staging_area_rider_1", "staging_area_rider_2", "staging_area_rider_3");
    var_3f100131 = array::randomize(var_3f100131);
    for (i = 0; i < var_2ffb0686.size; i++) {
        var_39352a5[i] = spawner::simple_spawn_single(var_3f100131[i]);
        var_39352a5[i] vehicle::get_in(self, var_2ffb0686[i], 1);
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x0
// Checksum 0x8a939e2d, Offset: 0x62a0
// Size: 0x64
function function_c37f7fc3() {
    var_133e9095 = getent("lgt_test_probe", "targetname");
    level flag::set("vtol_ride_temp_probe_linked");
    var_133e9095 linkto(self);
}

// Namespace namespace_80a43443
// Params 2, eflags: 0x1 linked
// Checksum 0xd9220b0f, Offset: 0x6310
// Size: 0x74
function function_9de6dff0(var_35a302af, a_str_tags) {
    level notify(#"hash_c727333f");
    self setcursorhint("HINT_INTERACTIVE_PROMPT");
    self triggerignoreteam();
    self function_2bf40f1(var_35a302af, a_str_tags);
}

// Namespace namespace_80a43443
// Params 2, eflags: 0x1 linked
// Checksum 0x8e215e7a, Offset: 0x6390
// Size: 0xc4
function function_2bf40f1(var_35a302af, a_str_tags) {
    e_player = self function_c61be98c(var_35a302af);
    if (isdefined(e_player) && !e_player flag::get("linked_to_truck")) {
        self function_f132ee31(var_35a302af, e_player);
        level.var_e32d239b++;
        var_35a302af.var_3c1d8edf++;
        var_35a302af notify(#"hash_19304798");
        return;
    }
    self function_2bf40f1(var_35a302af, a_str_tags);
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0xe36203e4, Offset: 0x6460
// Size: 0xb8
function function_c61be98c(var_35a302af) {
    mdl_gameobject = util::function_14518e76(self, %cp_prompt_entervehicle_ramses_technical, %CP_MI_CAIRO_RAMSES_BOARD_TRUCK, &function_8ebbac0d);
    if (var_35a302af.targetname === "technical_right") {
        mdl_gameobject thread function_543c8d72(var_35a302af);
    }
    e_player = mdl_gameobject function_3bc165a2(var_35a302af);
    mdl_gameobject gameobjects::disable_object();
    return e_player;
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0x9ba73839, Offset: 0x6520
// Size: 0xe0
function function_543c8d72(var_35a302af) {
    level endon(#"hash_fed8530d");
    var_35a302af endon(#"hash_6815ed3f");
    self.is_enabled = 0;
    self gameobjects::disable_object();
    while (true) {
        if (level.players.size <= 2 && self.is_enabled) {
            self.is_enabled = 0;
            self gameobjects::disable_object();
        } else if (level.players.size > 2 && !self.is_enabled) {
            self.is_enabled = 1;
            self gameobjects::enable_object();
        }
        wait(0.5);
    }
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0xc323c8a6, Offset: 0x6608
// Size: 0x3c
function function_8ebbac0d(e_player) {
    self notify(#"hash_9292e8f0", e_player);
    objectives::complete("cp_level_ramses_eastern_checkpoint", e_player);
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0xbb5bbd61, Offset: 0x6650
// Size: 0x34
function function_3bc165a2(var_35a302af) {
    var_35a302af endon(#"hash_19304798");
    e_player = self waittill(#"hash_9292e8f0");
    return e_player;
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0xd67a6fa4, Offset: 0x6690
// Size: 0xae
function function_85aceb92(a_str_tags) {
    while (self.var_3c1d8edf < a_str_tags.size) {
        if (level.players.size == 1 && level.var_e32d239b >= level.players.size) {
            break;
        } else if (level.players.size > 1 && level.var_e32d239b >= 1 && level.var_e32d239b >= level.activeplayers.size) {
            break;
        }
        wait(0.25);
    }
    self notify(#"hash_6815ed3f");
}

// Namespace namespace_80a43443
// Params 2, eflags: 0x1 linked
// Checksum 0xdc814d29, Offset: 0x6748
// Size: 0xd4
function function_f132ee31(var_35a302af, e_player) {
    str_tag = self.targetname;
    e_player flag::set("linked_to_truck");
    if (var_35a302af.var_a8da2af9 === 1 && level scene::is_playing("cin_ram_04_02_easterncheck_1st_entertruck_demo")) {
        level waittill(#"hash_faa941cd");
    }
    var_35a302af.var_a8da2af9 = 1;
    var_35a302af function_3ae58c71(e_player, str_tag, var_35a302af);
    var_35a302af.var_a8da2af9 = 0;
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xcdaff842, Offset: 0x6828
// Size: 0x74
function function_d8e0d27e() {
    wait(15);
    trigger::use("trig_technical_01_go");
    wait(5);
    spawner::simple_spawn("staging_area_background_technical_02", &function_226410e6);
    wait(15);
    trigger::use("trig_technical_02_go");
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xdc622f16, Offset: 0x68a8
// Size: 0x14c
function function_226410e6() {
    nd_start = getvehiclenode(self.target, "targetname");
    if (self.script_noteworthy === "staging_area_background_technical_01") {
        level waittill(#"hash_3d44865d");
    }
    self thread vehicle::get_on_and_go_path(nd_start);
    self waittill(#"reached_path_end");
    foreach (var_eb2993cb in self.riders) {
        var_eb2993cb delete();
    }
    self.delete_on_death = 1;
    self notify(#"death");
    if (!isalive(self)) {
        self delete();
    }
}

// Namespace namespace_80a43443
// Params 2, eflags: 0x1 linked
// Checksum 0xc62130df, Offset: 0x6a00
// Size: 0x238
function function_b7170f9e(str_targetname, n_max) {
    level endon(#"hash_e99a85b4");
    var_67a453fb = getvehiclespawnerarray(str_targetname, "targetname");
    while (true) {
        var_67a453fb = array::randomize(var_67a453fb);
        foreach (var_1f3f1cb0 in var_67a453fb) {
            if (level.var_6b2d0ae6 < n_max) {
                if (isdefined(var_1f3f1cb0)) {
                    if (!(isdefined(var_1f3f1cb0.b_active) && var_1f3f1cb0.b_active)) {
                        var_1f3f1cb0.b_active = 1;
                        var_edc6e0e1 = spawner::simple_spawn_single(var_1f3f1cb0);
                        vnd_start = getvehiclenode(var_1f3f1cb0.target, "targetname");
                        var_edc6e0e1 vehicle::toggle_sounds(0);
                        var_1f3f1cb0.count++;
                        level.var_6b2d0ae6++;
                        var_edc6e0e1 playloopsound("evt_vtol_ambient");
                        var_edc6e0e1 thread function_bd103c67(var_1f3f1cb0);
                        var_edc6e0e1 thread vehicle::get_on_and_go_path(vnd_start);
                        wait(randomfloatrange(0.4, 0.75));
                    }
                }
                continue;
            }
            level waittill(#"hash_318f97c4");
        }
        wait(0.05);
    }
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0x371cd2b4, Offset: 0x6c40
// Size: 0x56
function function_bd103c67(sp) {
    level endon(#"hash_e99a85b4");
    self waittill(#"death");
    if (isdefined(sp)) {
        sp.b_active = 0;
    }
    level.var_6b2d0ae6--;
    level notify(#"hash_318f97c4");
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x0
// Checksum 0x3a60d171, Offset: 0x6ca0
// Size: 0x3c
function function_76b0226a(var_4e88691) {
    self waittill(#"death");
    if (isdefined(var_4e88691)) {
        var_4e88691 delete();
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xbd19151a, Offset: 0x6ce8
// Size: 0x174
function function_429ae99d() {
    level endon(#"hash_e99a85b4");
    var_8498e7d1 = array("helipad_liftoff_vtol_1", "helipad_liftoff_vtol_2", "helipad_liftoff_vtol_3", "helipad_liftoff_vtol_4", "helipad_liftoff_vtol_5", "helipad_liftoff_vtol_6", "helipad_liftoff_vtol_7", "helipad_liftoff_vtol_8", "helipad_liftoff_vtol_9", "helipad_liftoff_vtol_10");
    var_1d9b0ee8 = function_85a37f7(var_8498e7d1);
    foreach (vtol in var_1d9b0ee8) {
        vtol vehicle::toggle_sounds(0);
    }
    var_1d9b0ee8 function_501a0fde();
    level flag::wait_till("staging_area_ambient_start");
    var_1d9b0ee8 function_42a5525a();
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x0
// Checksum 0x59a9ed45, Offset: 0x6e68
// Size: 0x44
function function_f40e1b95(a_ents) {
    var_edc6e0e1 = a_ents["crowd_vtol"];
    var_edc6e0e1 flag::init("loaded");
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x0
// Checksum 0x1dc6a9f7, Offset: 0x6eb8
// Size: 0x44
function function_f1ae04cf(a_ents) {
    var_edc6e0e1 = a_ents["crowd_vtol"];
    var_edc6e0e1 flag::set("loaded");
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0xeb260b29, Offset: 0x6f08
// Size: 0x17e
function function_85a37f7(var_ab765abb) {
    var_1d9b0ee8 = [];
    foreach (str_name in var_ab765abb) {
        var_edc6e0e1 = spawner::simple_spawn_single(str_name);
        if (!isdefined(var_1d9b0ee8)) {
            var_1d9b0ee8 = [];
        } else if (!isarray(var_1d9b0ee8)) {
            var_1d9b0ee8 = array(var_1d9b0ee8);
        }
        var_1d9b0ee8[var_1d9b0ee8.size] = var_edc6e0e1;
        if (isdefined(var_edc6e0e1.script_noteworthy)) {
            var_edc6e0e1 flag::init("loaded");
            var_edc6e0e1 util::delay(randomintrange(10, 20), undefined, &flag::set, "loaded");
        }
    }
    return var_1d9b0ee8;
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x0
// Checksum 0xc895aab, Offset: 0x7090
// Size: 0xf4
function function_d2cc8ebf() {
    var_1d9b0ee8 = [];
    foreach (var_edc6e0e1 in self) {
        if (isdefined(var_edc6e0e1.script_noteworthy)) {
            if (!isdefined(var_1d9b0ee8)) {
                var_1d9b0ee8 = [];
            } else if (!isarray(var_1d9b0ee8)) {
                var_1d9b0ee8 = array(var_1d9b0ee8);
            }
            var_1d9b0ee8[var_1d9b0ee8.size] = var_edc6e0e1;
        }
    }
    return var_1d9b0ee8;
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x647e7402, Offset: 0x7190
// Size: 0xaa
function function_501a0fde() {
    foreach (var_edc6e0e1 in self) {
        level scene::init(var_edc6e0e1.script_string, var_edc6e0e1);
        util::wait_network_frame();
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x0
// Checksum 0xb8f83c99, Offset: 0x7248
// Size: 0xaa
function function_c9942484() {
    foreach (var_edc6e0e1 in self) {
        level scene::init(var_edc6e0e1.script_noteworthy, "targetname", var_edc6e0e1);
        util::wait_network_frame();
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xbbea79b8, Offset: 0x7300
// Size: 0x112
function function_42a5525a() {
    level endon(#"hash_e99a85b4");
    s_goal = struct::get("helipads_vtol_goal", "targetname");
    wait(5);
    foreach (var_edc6e0e1 in self) {
        var_edc6e0e1 thread function_aac7c5be(s_goal.origin);
        var_edc6e0e1 playloopsound("evt_vtol_ambient");
        wait(randomfloatrange(4, 8));
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x0
// Checksum 0x44c786a7, Offset: 0x7420
// Size: 0x102
function function_c3d24d16() {
    level endon(#"hash_e99a85b4");
    n_timeout = 60;
    trigger::wait_or_timeout(n_timeout, "staging_area_helipads_liftoff_trig");
    foreach (var_edc6e0e1 in self) {
        level thread scene::play(var_edc6e0e1.script_noteworthy, "targetname", var_edc6e0e1);
        wait(randomfloatrange(0.56, 1.25));
    }
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0x4bb20dcd, Offset: 0x7530
// Size: 0xcc
function function_aac7c5be(v_goal) {
    self endon(#"death");
    if (isdefined(self.script_noteworthy)) {
        self flag::wait_till("loaded");
    }
    level scene::play(self.script_string, self);
    self setvehgoalpos(v_goal);
    self waittill(#"goal");
    self.delete_on_death = 1;
    self notify(#"death");
    if (!isalive(self)) {
        self delete();
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x5e73b876, Offset: 0x7608
// Size: 0x332
function function_4492caaa() {
    level flag::wait_till("dead_turrets_initialized");
    level.var_e6786950 = [];
    level.var_4516597e = [];
    var_5b4c55a2 = struct::get_array("ramses_station_hunters", "targetname");
    var_da76440b = struct::get_array("ramses_station_vtols", "targetname");
    var_53a6979b = struct::get_array("ramses_station_hunters_turnaround", "targetname");
    var_c02e0aaa = arraycombine(var_5b4c55a2, var_da76440b, 0, 0);
    for (i = 1; i < 5; i++) {
        var_d9aaac41 = getvehiclearray("station_battery_" + i, "script_noteworthy");
        assert(var_d9aaac41.size == 3, "staging_area_allies" + "staging_area_allies" + i + "staging_area_allies" + var_d9aaac41.size + "staging_area_allies" + 3 + "staging_area_allies");
        level.var_e6786950[i] = var_d9aaac41;
    }
    level thread function_1a5d54fa();
    scene::add_scene_func("p7_fxanim_cp_ramses_lotus_towers_hunters_09_bundle_server", &function_73facefb, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_lotus_towers_hunters_10_bundle_server", &function_73facefb, "play");
    scene::add_scene_func("p7_fxanim_cp_ramses_lotus_towers_vtols_01_bundle_server", &function_73facefb, "play");
    var_53a6979b thread function_28437442();
    var_c02e0aaa function_62436a5a();
    foreach (s_fxanim in var_c02e0aaa) {
        s_fxanim scene::stop(1);
    }
    level.var_e6786950 = undefined;
    level.var_4516597e = undefined;
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x24535acc, Offset: 0x7948
// Size: 0x18a
function function_d6617e36() {
    level endon(#"hash_e99a85b4");
    while (self.var_3a03dd8d) {
        foreach (e_player in level.activeplayers) {
            if (distance2d(e_player getorigin(), self.origin) <= 894) {
                e_player function_a2361ae7();
                continue;
            }
            e_player function_a2361ae7(0);
        }
        wait(0.05);
    }
    foreach (e_player in level.activeplayers) {
        e_player function_a2361ae7(0);
    }
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0x27bf2127, Offset: 0x7ae0
// Size: 0x44
function function_a2361ae7(b_on) {
    if (!isdefined(b_on)) {
        b_on = 1;
    }
    self clientfield::set_to_player("filter_ev_interference_toggle", b_on);
}

/#

    // Namespace namespace_80a43443
    // Params 1, eflags: 0x0
    // Checksum 0x8d3de1a5, Offset: 0x7b30
    // Size: 0x58
    function function_d7d89699(n_distance) {
        self endon(#"_stop_turret");
        while (true) {
            debug::debug_sphere(self.origin, n_distance, (1, 0, 0), 0.5, 1);
            wait(0.05);
        }
    }

#/

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xb49588, Offset: 0x7b90
// Size: 0xca
function function_1a852d62() {
    level endon(#"hash_e99a85b4");
    var_b9fb5382 = getentarray("battery_fake_target", "targetname");
    foreach (var_b8f9a884 in self) {
        var_b8f9a884 setturrettargetent(array::random(var_b9fb5382));
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xe127b622, Offset: 0x7c68
// Size: 0x78
function function_62436a5a() {
    level endon(#"hash_e99a85b4");
    level.var_4516597e = array::random(level.var_e6786950);
    while (true) {
        function_66ded396();
        array::wait_till(level.var_4516597e, "_stop_turret");
        function_9f7ba147();
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x2983f2c9, Offset: 0x7ce8
// Size: 0x80
function function_28437442() {
    level endon(#"hash_e99a85b4");
    while (true) {
        s_fxanim = array::random(self);
        if (!s_fxanim scene::is_playing()) {
            s_fxanim thread scene::play();
        }
        wait(randomfloatrange(2, 4));
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xe822926c, Offset: 0x7d70
// Size: 0x86
function function_66ded396() {
    level endon(#"hash_e99a85b4");
    for (i = 0; i < 3; i++) {
        s_fxanim = function_7e1bae82();
        s_fxanim thread scene::play();
        wait(randomfloatrange(0.59, 1.2));
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xb06c264d, Offset: 0x7e00
// Size: 0x6c
function function_7e1bae82() {
    level endon(#"hash_e99a85b4");
    s_fxanim = undefined;
    while (true) {
        s_fxanim = array::random(self);
        if (!s_fxanim scene::is_playing()) {
            break;
        }
        wait(0.05);
    }
    return s_fxanim;
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x9a45abed, Offset: 0x7e78
// Size: 0x7a
function function_9f7ba147() {
    level endon(#"hash_e99a85b4");
    var_542ecdff = level.var_4516597e[0];
    level.var_4516597e function_1a852d62();
    do {
        level.var_4516597e = array::random(level.var_e6786950);
        wait(0.05);
    } while (level.var_4516597e[0] == var_542ecdff);
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0xdd41cce8, Offset: 0x7f00
// Size: 0x9a
function function_73facefb(a_ents) {
    level endon(#"hash_e99a85b4");
    foreach (mdl_target in a_ents) {
        mdl_target thread function_9d4c44e5();
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x582304cc, Offset: 0x7fa8
// Size: 0xbe
function function_9d4c44e5() {
    level endon(#"hash_e99a85b4");
    foreach (var_b8f9a884 in level.var_4516597e) {
        if (!(isdefined(var_b8f9a884.var_3a03dd8d) && var_b8f9a884.var_3a03dd8d)) {
            var_b8f9a884 function_70561437(self);
            break;
        }
    }
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0xe9cddf3c, Offset: 0x8070
// Size: 0xe0
function function_70561437(mdl_target) {
    level endon(#"hash_e99a85b4");
    self.var_3a03dd8d = 1;
    self setturrettargetent(mdl_target);
    self thread function_7f47b803(mdl_target);
    mdl_target util::waittill_either("hunter_explodes", "vtol_01_explodes");
    wait(randomfloatrange(0.15, 0.45));
    self notify(#"_stop_turret");
    self clearturrettarget();
    self laseroff();
    self.var_3a03dd8d = 0;
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0xee68ca9a, Offset: 0x8158
// Size: 0x4a
function function_179e06df(mdl_target) {
    return sighttracepassed(self gettagorigin("tag_flash"), mdl_target.origin, 0, self);
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0x276e412e, Offset: 0x81b0
// Size: 0x134
function function_7f47b803(mdl_target) {
    self endon(#"death");
    self endon(#"_stop_turret");
    mdl_target endon(#"death");
    self waittill(#"turret_on_target");
    wait(randomfloatrange(2, 4));
    if (mdl_target.targetname == "lotus_dropships") {
        wait(randomfloatrange(0.05, 0.25));
    } else {
        wait(randomfloatrange(1, 2));
    }
    while (!self function_179e06df(mdl_target)) {
        wait(0.05);
    }
    self laseron();
    if (self.script_string === "do_futz") {
        self thread function_d6617e36();
    }
    self turret::fire_for_time(100);
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0xd2e3ff6b, Offset: 0x82f0
// Size: 0x8c
function function_1a5d54fa() {
    var_19ec42b2 = getdvarint("bulletrange");
    setdvar("bulletrange", 65000);
    level flag::wait_till("dead_turret_stop_station_ambients");
    setdvar("bulletrange", var_19ec42b2);
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x4a997abc, Offset: 0x8388
// Size: 0xc4
function vo() {
    level flag::wait_till("jumpdirect_scene_done");
    level.var_9db406db dialog::say("khal_we_have_to_hurry_0", randomfloatrange(0.1, 0.25));
    level.var_9db406db flag::wait_till("khalil_ready");
    wait(1);
    level.var_9db406db thread do_nag("khal_get_in_0", 6, 9, "players_ready", "cin_ram_04_02_easterncheck_1st_entertruck_demo", 1);
}

// Namespace namespace_80a43443
// Params 6, eflags: 0x1 linked
// Checksum 0x5f8319a4, Offset: 0x8458
// Size: 0xd8
function do_nag(str_nag, n_time_min, n_time_max, str_ender, str_scene, var_d53650fe) {
    if (!isdefined(var_d53650fe)) {
        var_d53650fe = 1;
    }
    level endon(str_ender);
    n_count = 0;
    while (var_d53650fe > n_count) {
        if (!isdefined(str_scene) || !level scene::is_playing(str_scene)) {
            self dialog::say(str_nag);
            n_count++;
        }
        wait(randomfloatrange(n_time_min, n_time_max));
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x1 linked
// Checksum 0x3a0b3f4b, Offset: 0x8538
// Size: 0x3c
function function_b8a391f4() {
    self dialog::say("esl1_let_s_move_let_s_mo_0", randomfloatrange(4, 6));
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0xd2a0d91d, Offset: 0x8580
// Size: 0x5e
function init_flags(str) {
    for (i = 0; i < self.size; i++) {
        level flag::init(self[i].targetname + str);
    }
}

// Namespace namespace_80a43443
// Params 1, eflags: 0x1 linked
// Checksum 0x7e2a6ea8, Offset: 0x85e8
// Size: 0x5e
function function_9b92c048(str) {
    for (i = 0; i < self.size; i++) {
        level flag::wait_till(self[i].targetname + str);
    }
}

// Namespace namespace_80a43443
// Params 0, eflags: 0x0
// Checksum 0x62c4d246, Offset: 0x8650
// Size: 0x84
function egg() {
    var_c4aa66fd = getentarray("temp_egg_trig", "targetname");
    var_7005b138 = getentarray("temp_egg_cancel_trig", "targetname");
    array::thread_all(var_c4aa66fd, &function_2f762b15, var_7005b138);
}

// Namespace namespace_80a43443
// Params 2, eflags: 0x1 linked
// Checksum 0x3d633daf, Offset: 0x86e0
// Size: 0x3a
function function_2f762b15(var_c4aa66fd, var_7005b138) {
    while (!level flag::get("players_ready")) {
    }
}

