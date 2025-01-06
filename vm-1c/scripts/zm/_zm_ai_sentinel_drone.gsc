#using scripts/codescripts/struct;
#using scripts/shared/aat_shared;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai_shared;
#using scripts/shared/array_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/fx_shared;
#using scripts/shared/scoreevents_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/util_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/vehicles/_sentinel_drone;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_util;
#using scripts/zm/_zm;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_devgui;
#using scripts/zm/_zm_elemental_zombies;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_utility;
#using scripts/zm/zm_stalingrad_util;
#using scripts/zm/zm_stalingrad_vo;

#namespace zm_ai_sentinel_drone;

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x2
// Checksum 0x3ce44d05, Offset: 0x808
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_ai_sentinel_drone", &__init__, &__main__, undefined);
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x1871fee4, Offset: 0x850
// Size: 0x1cc
function __init__() {
    level.var_8a3cc09a = 1;
    level.var_fef7211a = 0;
    level.var_e476eac3 = 0;
    level.var_d6d4b6f9 = 2500;
    zm_score::register_score_event("death_sentinel", &function_c35ddec4);
    level flag::init("sentinel_round");
    level flag::init("sentinel_round_in_progress");
    level flag::init("sentinel_rez_in_progress");
    register_clientfields();
    level thread aat::register_immunity("zm_aat_blast_furnace", "sentinel_drone", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_dead_wire", "sentinel_drone", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_fire_works", "sentinel_drone", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_thunder_wall", "sentinel_drone", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_turned", "sentinel_drone", 1, 1, 1);
    function_1e5d8e69();
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xd58066, Offset: 0xa28
// Size: 0x6c
function __main__() {
    /#
        execdevgui("<dev string:x28>");
        thread function_5715a7cc();
    #/
    visionset_mgr::register_info("visionset", "zm_sentinel_round_visionset", 12000, 22, 31, 0, &visionset_mgr::ramp_in_out_thread, 0);
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xd0cccf09, Offset: 0xaa0
// Size: 0xf4
function register_clientfields() {
    clientfield::register("world", "sentinel_round_fog", 12000, 1, "int");
    clientfield::register("toplayer", "sentinel_round_fx", 12000, 1, "int");
    clientfield::register("vehicle", "necro_sentinel_fx", 12000, 1, "int");
    clientfield::register("vehicle", "sentinel_spawn_fx", 12000, 1, "int");
    clientfield::register("actor", "sentinel_zombie_spawn_fx", 12000, 1, "int");
}

// Namespace zm_ai_sentinel_drone
// Params 5, eflags: 0x0
// Checksum 0xde989a3e, Offset: 0xba0
// Size: 0x64
function function_c35ddec4(str_event, str_mod, var_5afff096, var_48d0b2fe, var_2f7fd5db) {
    if (str_event === "death_sentinel") {
        scoreevents::processscoreevent("kill_sentinel", self, undefined, var_2f7fd5db);
        return 100;
    }
    return 0;
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xbe5500d1, Offset: 0xc10
// Size: 0xbc
function function_2f7416e5() {
    level.var_fef7211a = 1;
    level.var_35078afd = 0;
    level.var_a657e360 = spawnstruct();
    level.var_a657e360.origin = (0, 0, 0);
    level.var_a657e360.angles = (0, 0, 0);
    level.var_a657e360.script_noteworthy = "riser_location";
    level.var_a657e360.script_string = "find_flesh";
    if (!isdefined(level.var_c7979e0a)) {
        level.var_c7979e0a = &function_e38b964d;
    }
    level thread [[ level.var_c7979e0a ]]();
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x95c3aef5, Offset: 0xcd8
// Size: 0x17a
function function_1e5d8e69() {
    level.var_fda4b3f3 = getspawnerarray("zombie_sentinel_spawner", "script_noteworthy");
    level.var_34fd66c3 = getspawnerarray("zombie_sentinel_zombie_spawner", "script_noteworthy");
    array::thread_all(level.var_34fd66c3, &spawner::add_spawn_function, &zm_spawner::zombie_spawn_init);
    if (level.var_fda4b3f3.size == 0) {
        assertmsg("<dev string:x4e>");
        return;
    }
    foreach (var_5631b793 in level.var_fda4b3f3) {
        var_5631b793.is_enabled = 1;
        var_5631b793.script_forcespawn = 1;
        var_5631b793 spawner::add_spawn_function(&function_3b40bf32);
    }
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xc031b788, Offset: 0xe60
// Size: 0x228
function function_e38b964d() {
    if (level.players.size == 1) {
        level.var_a78effc7 = randomintrange(12, 16);
    } else {
        level.var_a78effc7 = randomintrange(9, 12);
    }
    old_spawn_func = level.round_spawn_func;
    old_wait_func = level.round_wait_func;
    while (true) {
        level waittill(#"between_round_over");
        /#
            if (getdvarint("<dev string:x91>") > 0) {
                level.var_a78effc7 = level.round_number;
            }
        #/
        if (level.round_number == level.var_a78effc7) {
            level.var_1b7d7bb8 = 1;
            old_spawn_func = level.round_spawn_func;
            old_wait_func = level.round_wait_func;
            function_71f8e359();
            level.round_spawn_func = &function_7766fb04;
            level.round_wait_func = &function_989acb59;
            if (isdefined(level.var_a1ca5313)) {
                level.var_a78effc7 = [[ level.var_a1ca5313 ]]();
            } else {
                level.var_a78effc7 += randomintrange(7, 10);
            }
            /#
                level.players[0] iprintln("<dev string:xa0>" + level.var_a78effc7);
            #/
            continue;
        }
        if (level flag::get("sentinel_round")) {
            function_5cf4e163();
            level.round_spawn_func = old_spawn_func;
            level.round_wait_func = old_wait_func;
        }
    }
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xe457a466, Offset: 0x1090
// Size: 0xc4
function function_71f8e359() {
    level flag::set("sentinel_round");
    level flag::set("special_round");
    level.var_35078afd++;
    level.var_e476eac3 = 1;
    level notify(#"hash_90d1f5ef");
    level thread zm_audio::sndmusicsystem_playstate("sentinel_roundstart");
    level.var_a61a9af4 = getdvarint("Sentinel_Move_Speed");
    setdvar("Sentinel_Move_Speed", 5);
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x4039be20, Offset: 0x1160
// Size: 0x7e
function function_5cf4e163() {
    level flag::clear("sentinel_round");
    level flag::clear("special_round");
    setdvar("Sentinel_Move_Speed", level.var_a61a9af4);
    level.var_e476eac3 = 0;
    level notify(#"hash_d32683ce");
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xf325e9e3, Offset: 0x11e8
// Size: 0x340
function function_7766fb04() {
    level endon(#"intermission");
    level endon(#"sentinel_round");
    level.var_6693a532 = getplayers();
    for (i = 0; i < level.var_6693a532.size; i++) {
        level.var_6693a532[i].hunted_by = 0;
    }
    level endon(#"restart_round");
    /#
        level endon(#"kill_round");
        if (getdvarint("<dev string:xb6>") == 2 || getdvarint("<dev string:xb6>") >= 4) {
            return;
        }
    #/
    if (level.intermission) {
        return;
    }
    array::thread_all(level.players, &function_6a866be7);
    function_e930da45();
    level.zombie_total = function_e9be6289();
    /#
        if (getdvarstring("<dev string:x91>") != "<dev string:xc3>" && getdvarint("<dev string:x91>") > 0) {
            level.zombie_total = getdvarint("<dev string:x91>");
            setdvar("<dev string:x91>", 0);
        }
    #/
    wait 1;
    sentinel_round_fx(1);
    visionset_mgr::activate("visionset", "zm_sentinel_round_visionset", undefined, 1.5, 1.5, 2);
    playsoundatposition("vox_zmba_event_sentinelstart_0", (0, 0, 0));
    level thread zm_stalingrad_vo::function_3800b6e0();
    wait 3;
    level flag::set("sentinel_round_in_progress");
    level endon(#"last_ai_down");
    level thread function_53547f4d();
    while (true) {
        while (level.zombie_total > 0) {
            if (isdefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
                util::wait_network_frame();
                continue;
            }
            var_c94972aa = level.var_35078afd > 1 && level.zombie_total % 2 == 0;
            function_23a30f49(var_c94972aa);
            util::wait_network_frame();
        }
        util::wait_network_frame();
    }
}

// Namespace zm_ai_sentinel_drone
// Params 2, eflags: 0x0
// Checksum 0x50f4c45a, Offset: 0x1530
// Size: 0x74
function function_fded8158(spawner, s_spot) {
    var_663b2442 = zombie_utility::spawn_zombie(level.var_fda4b3f3[0], "sentinel", s_spot);
    if (isdefined(var_663b2442)) {
        var_663b2442.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
    }
    return var_663b2442;
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x34d06f9e, Offset: 0x15b0
// Size: 0x2cc
function function_f9c9e7e0() {
    a_s_spawn_locs = [];
    s_spawn_loc = undefined;
    foreach (s_zone in level.zones) {
        if (s_zone.is_enabled && isdefined(s_zone.a_loc_types["sentinel_location"]) && s_zone.a_loc_types["sentinel_location"].size) {
            foreach (s_loc in s_zone.a_loc_types["sentinel_location"]) {
                foreach (player in level.activeplayers) {
                    n_dist_sq = distancesquared(player.origin, s_loc.origin);
                    if (n_dist_sq > 65536 && n_dist_sq < 2250000) {
                        if (!isdefined(a_s_spawn_locs)) {
                            a_s_spawn_locs = [];
                        } else if (!isarray(a_s_spawn_locs)) {
                            a_s_spawn_locs = array(a_s_spawn_locs);
                        }
                        a_s_spawn_locs[a_s_spawn_locs.size] = s_loc;
                        break;
                    }
                }
            }
        }
    }
    s_spawn_loc = array::random(a_s_spawn_locs);
    if (!isdefined(s_spawn_loc)) {
        s_spawn_loc = array::random(level.zm_loc_types["sentinel_location"]);
    }
    return s_spawn_loc;
}

// Namespace zm_ai_sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0xb32843f5, Offset: 0x1888
// Size: 0x1d4
function function_23a30f49(var_c94972aa) {
    if (!isdefined(var_c94972aa)) {
        var_c94972aa = 0;
    }
    while (!function_74ab7484()) {
        wait 0.1;
    }
    s_spawn_loc = undefined;
    if (isdefined(level.var_2babfade)) {
        s_spawn_loc = [[ level.var_2babfade ]]();
    } else {
        /#
            if (level.zm_loc_types["<dev string:xc4>"].size == 0) {
                iprintlnbold("<dev string:xd6>");
            }
        #/
        s_spawn_loc = function_f9c9e7e0();
    }
    if (!isdefined(s_spawn_loc)) {
        wait randomfloatrange(0.333333, 0.666667);
        return;
    }
    ai = function_fded8158(level.var_fda4b3f3[0]);
    if (isdefined(ai)) {
        ai.nuke_damage_func = &function_306f9403;
        ai.instakill_func = &function_306f9403;
        ai.s_spawn_loc = s_spawn_loc;
        ai thread function_b27530eb(s_spawn_loc.origin);
        if (var_c94972aa) {
            ai.var_c94972aa = 1;
            ai.var_580a32ea = 6;
        }
        level.zombie_total--;
        function_20c64325();
    }
}

// Namespace zm_ai_sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0xe3ec954f, Offset: 0x1a68
// Size: 0x24c
function function_b27530eb(v_pos) {
    self endon(#"death");
    self sentinel_drone::function_ab6da2e2();
    self vehicle::toggle_sounds(0);
    var_92968756 = v_pos + (0, 0, 30);
    self.origin = v_pos + (0, 0, 5000);
    self.angles = (0, randomintrange(0, 360), 0);
    e_origin = spawn("script_origin", self.origin);
    e_origin.angles = self.angles;
    self linkto(e_origin);
    e_origin moveto(var_92968756, 3);
    e_origin playsound("zmb_sentinel_intro_spawn");
    e_origin util::delay(3, undefined, &function_e6bf0279);
    self clientfield::set("sentinel_spawn_fx", 1);
    wait 3;
    self clientfield::set("sentinel_spawn_fx", 0);
    wait 1;
    self vehicle::toggle_sounds(1);
    self.origin = var_92968756;
    self unlink();
    e_origin delete();
    self flag::set("completed_spawning");
    wait 0.2;
    self sentinel_drone::function_d5314e71();
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x5bc97d4b, Offset: 0x1cc0
// Size: 0x24
function function_e6bf0279() {
    self playsound("zmb_sentinel_intro_land");
}

// Namespace zm_ai_sentinel_drone
// Params 3, eflags: 0x0
// Checksum 0xf8638743, Offset: 0x1cf0
// Size: 0x20
function function_306f9403(player, mod, hit_location) {
    return true;
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x372fd239, Offset: 0x1d18
// Size: 0x7ae
function function_d600cb9a() {
    self endon(#"hash_d600cb9a");
    self endon(#"death");
    self thread function_caadf4b1();
    self flag::wait_till("completed_spawning");
    var_4b9c276c = function_5b91ab3a();
    while (true) {
        level flag::wait_till_clear("sentinel_rez_in_progress");
        while (zombie_utility::get_current_zombie_count() >= var_4b9c276c) {
            wait 0.1;
        }
        if (zombie_utility::get_current_actor_count() >= level.zombie_actor_limit) {
            zombie_utility::clear_all_corpses();
            wait 0.1;
            continue;
        }
        v_spawn_pos = undefined;
        if (isdefined(self.var_98bec529) && self.var_98bec529) {
            var_48f8d555 = positionquery_source_navigation(self.origin, 16, 768, -56, 40, 32);
            if (var_48f8d555.data.size) {
                a_s_locs = array::randomize(var_48f8d555.data);
                foreach (n_index, s_loc in a_s_locs) {
                    var_caae2f83 = [[ self.check_point_in_enabled_zone ]](s_loc.origin, 1);
                    if (var_caae2f83) {
                        continue;
                    }
                    var_e31f585b = getclosestpointonnavmesh(s_loc.origin, 96, 32);
                    if (isdefined(var_e31f585b)) {
                        var_c85c791d = 0;
                        foreach (player in level.activeplayers) {
                            n_dist_sq = distancesquared(self.origin, s_loc.origin);
                            if (n_dist_sq < 250000) {
                                var_c85c791d = 1;
                                break;
                            }
                        }
                        if (var_c85c791d) {
                            continue;
                        }
                        s_spawn_loc = arraygetclosest(var_e31f585b, level.exterior_goals);
                        if (isdefined(s_spawn_loc.script_string)) {
                            level.var_a657e360.script_string = s_spawn_loc.script_string;
                        }
                        var_5ddbdc32 = groundtrace(var_e31f585b + (0, 0, 64), var_e31f585b + (0, 0, -128), 0, undefined);
                        v_spawn_pos = var_5ddbdc32["position"];
                        break;
                    }
                }
            }
        } else {
            player = zombie_utility::get_closest_valid_player(self.origin);
            if (!isdefined(player)) {
                wait 3;
                continue;
            }
            var_48f8d555 = positionquery_source_navigation(self.origin, 500, 768, -56, 40, 32);
            if (var_48f8d555.data.size) {
                a_s_locs = array::randomize(var_48f8d555.data);
                foreach (s_loc in a_s_locs) {
                    var_caae2f83 = [[ self.check_point_in_enabled_zone ]](s_loc.origin, 1);
                    if (var_caae2f83) {
                        var_c85c791d = 0;
                        foreach (player in level.activeplayers) {
                            n_dist_sq = distancesquared(self.origin, s_loc.origin);
                            if (n_dist_sq < 250000) {
                                var_c85c791d = 1;
                                break;
                            }
                        }
                        if (var_c85c791d) {
                            continue;
                        }
                        level.var_a657e360.script_string = "find_flesh";
                        v_spawn_pos = s_loc.origin;
                        break;
                    }
                }
            }
        }
        if (isdefined(v_spawn_pos)) {
            if (level flag::get("sentinel_rez_in_progress")) {
                return;
            }
            level flag::set("sentinel_rez_in_progress");
            self.var_7e04bb3 = 1;
            self thread function_b7a02494();
            self sentinel_drone::function_aed5ff39(1, v_spawn_pos + (0, 0, 106));
            self waittill(#"goal");
            level.var_a657e360.origin = v_spawn_pos + (0, 0, 8);
            level.var_a657e360.angles = self.angles;
            self clientfield::set("necro_sentinel_fx", 1);
            self function_1a7787ed();
            self clientfield::set("necro_sentinel_fx", 0);
            self sentinel_drone::function_aed5ff39(0);
            wait 5;
            self.var_7e04bb3 = 0;
            level flag::clear("sentinel_rez_in_progress");
        }
        wait 1;
    }
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xe1d3f632, Offset: 0x24d0
// Size: 0x3c
function function_b7a02494() {
    self endon(#"sentinel_rez_in_progress");
    self waittill(#"death");
    level flag::clear("sentinel_rez_in_progress");
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x3e612246, Offset: 0x2518
// Size: 0x230
function function_1a7787ed() {
    self endon(#"death");
    self endon(#"hash_15969cec");
    var_4bb04d82 = get_zombie_spawn_delay();
    var_4b9c276c = function_5b91ab3a();
    n_num_to_spawn = randomintrange(6, 24);
    while (n_num_to_spawn) {
        while (zombie_utility::get_current_zombie_count() >= var_4b9c276c) {
            return;
        }
        if (zombie_utility::get_current_actor_count() >= level.zombie_actor_limit) {
            return;
        }
        if (flag::exists("world_is_paused") && level flag::get("world_is_paused")) {
            level flag::wait_till_clear("world_is_paused");
            continue;
        }
        if (!level flag::get("spawn_zombies")) {
            level flag::wait_till("spawn_zombies");
            continue;
        }
        ai_zombie = zombie_utility::spawn_zombie(level.var_34fd66c3[0], "sentinel_riser", level.var_a657e360);
        if (isdefined(ai_zombie)) {
            n_num_to_spawn--;
            ai_zombie clientfield::set("sentinel_zombie_spawn_fx", 1);
            ai_zombie thread function_fdd9c3df(self);
            playsoundatposition("zmb_sentinel_res_spawn", level.var_a657e360.origin);
            wait var_4bb04d82;
        }
        util::wait_network_frame();
    }
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x107f9853, Offset: 0x2750
// Size: 0x174
function function_caadf4b1() {
    self waittill(#"death");
    self clientfield::set("necro_sentinel_fx", 0);
    a_ai_zombies = getaiteamarray(level.zombie_team);
    var_7f0cc3c7 = [];
    foreach (ai_zombie in a_ai_zombies) {
        if (ai_zombie.var_ec3fb9eb === self) {
            if (!isdefined(var_7f0cc3c7)) {
                var_7f0cc3c7 = [];
            } else if (!isarray(var_7f0cc3c7)) {
                var_7f0cc3c7 = array(var_7f0cc3c7);
            }
            var_7f0cc3c7[var_7f0cc3c7.size] = ai_zombie;
            ai_zombie.nuked = 1;
        }
    }
    if (var_7f0cc3c7.size) {
        zm_stalingrad_util::function_adf4d1d0(var_7f0cc3c7);
    }
}

// Namespace zm_ai_sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0x97b96242, Offset: 0x28d0
// Size: 0x22c
function function_fdd9c3df(var_4e5c415e) {
    self endon(#"death");
    var_4e5c415e endon(#"death");
    self.b_ignore_cleanup = 1;
    self.exclude_cleanup_adding_to_total = 1;
    if (var_4e5c415e.var_580a32ea > 0) {
        var_4e5c415e.var_580a32ea--;
        self thread function_ea9730d8(var_4e5c415e);
    } else {
        self.no_damage_points = 1;
        self.deathpoints_already_given = 1;
    }
    self.var_ec3fb9eb = var_4e5c415e;
    self.var_bb98125f = 1;
    zm_elemental_zombie::function_1b1bb1b();
    self.health = int(level.zombie_health / 2);
    self waittill(#"completed_emerging_into_playable_area");
    self.no_powerups = 1;
    n_timeout = gettime() + 60000;
    while (!isdefined(self.enemy)) {
        wait 0.1;
    }
    if (!self canpath(self.origin, self.enemy.origin)) {
        var_4e5c415e notify(#"hash_15969cec");
        self kill();
        return;
    }
    n_dist_sq_max = randomfloatrange(1048448, 1048576);
    while (gettime() < n_timeout) {
        n_dist_sq = distancesquared(self.origin, var_4e5c415e.origin);
        if (n_dist_sq > 1048576) {
            break;
        }
        wait 1;
    }
    self kill();
}

// Namespace zm_ai_sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0xb380b8c9, Offset: 0x2b08
// Size: 0x78
function function_ea9730d8(var_4e5c415e) {
    self endon(#"hash_107a4ece");
    var_4e5c415e endon(#"death");
    self function_cb2c6547();
    if (!isdefined(self.attacker) || !isplayer(self.attacker)) {
        var_4e5c415e.var_580a32ea++;
    }
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xeea05561, Offset: 0x2b88
// Size: 0x6e
function function_cb2c6547() {
    self endon(#"death");
    while (true) {
        self waittill(#"damage", n_damage, e_attacker);
        if (isdefined(e_attacker) && isplayer(e_attacker)) {
            self notify(#"hash_107a4ece");
        }
    }
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x1414d126, Offset: 0x2c00
// Size: 0xc0
function function_e9be6289() {
    switch (level.players.size) {
    case 1:
        var_4fc9044f = 6;
        var_ebe16089 = 1;
        break;
    case 2:
        var_4fc9044f = 9;
        var_ebe16089 = 2;
        break;
    case 3:
        var_4fc9044f = 12;
        var_ebe16089 = 3;
        break;
    default:
        var_4fc9044f = 15;
        var_ebe16089 = 4;
        break;
    }
    return var_4fc9044f + (level.var_35078afd - 1) * var_ebe16089;
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x53d26c87, Offset: 0x2cc8
// Size: 0x7a
function function_5b91ab3a() {
    switch (level.players.size) {
    case 1:
        n_count = 10;
        break;
    case 2:
        n_count = 10;
        break;
    case 3:
        n_count = 10;
        break;
    default:
        n_count = 12;
        break;
    }
    return n_count;
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x7fdc9d96, Offset: 0x2d50
// Size: 0x82
function get_zombie_spawn_delay() {
    switch (level.players.size) {
    case 1:
        n_delay = 2.5;
        break;
    case 2:
        n_delay = 2;
        break;
    case 3:
        n_delay = 1.5;
        break;
    default:
        n_delay = 1;
        break;
    }
    return n_delay;
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x6fb57405, Offset: 0x2de0
// Size: 0x88
function function_989acb59() {
    level endon(#"restart_round");
    /#
        level endon(#"kill_round");
    #/
    if (level flag::get("sentinel_round")) {
        level flag::wait_till("sentinel_round_in_progress");
        level flag::wait_till_clear("sentinel_round_in_progress");
    }
    level.var_1b7d7bb8 = 0;
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xdb916b7f, Offset: 0x2e70
// Size: 0xd6
function function_41375d48() {
    var_8b442d22 = getentarray("zombie_sentinel", "targetname");
    var_5eecf676 = var_8b442d22.size;
    foreach (var_663b2442 in var_8b442d22) {
        if (!isalive(var_663b2442)) {
            var_5eecf676--;
        }
    }
    return var_5eecf676;
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xb87871bf, Offset: 0x2f50
// Size: 0x62
function function_e4aafac() {
    switch (level.players.size) {
    case 1:
        return 3;
    case 2:
        return 4;
    case 3:
        return 5;
    case 4:
        return 6;
    }
}

// Namespace zm_ai_sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0x616c4cd, Offset: 0x2fc0
// Size: 0xc4
function sentinel_round_fx(n_val) {
    if (n_val) {
        foreach (player in level.players) {
            player clientfield::set_to_player("sentinel_round_fx", n_val);
        }
    }
    level clientfield::set("sentinel_round_fog", n_val);
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xce20fa2c, Offset: 0x3090
// Size: 0x78
function function_74ab7484() {
    var_8d70c285 = function_41375d48();
    var_f285bab2 = function_e4aafac();
    if (var_8d70c285 >= var_f285bab2 || !level flag::get("spawn_zombies")) {
        return false;
    }
    return true;
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xb01bf704, Offset: 0x3110
// Size: 0x88
function function_20c64325() {
    switch (level.players.size) {
    case 1:
        n_default_wait = 2.25;
        break;
    case 2:
        n_default_wait = 1.75;
        break;
    case 3:
        n_default_wait = 1.25;
        break;
    default:
        n_default_wait = 0.75;
        break;
    }
    wait n_default_wait;
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x4d7c7907, Offset: 0x31a0
// Size: 0x18c
function function_53547f4d() {
    level waittill(#"last_ai_down", var_663b2442, e_attacker);
    level thread zm_audio::sndmusicsystem_playstate("sentinel_roundend");
    if (isdefined(level.var_716fc13e)) {
        [[ level.var_716fc13e ]](var_663b2442, level.var_6a6f912a);
    } else {
        var_4a50cb2a = level.var_6a6f912a;
        if (isdefined(var_4a50cb2a)) {
            mdl_powerup = level zm_powerups::specific_powerup_drop("full_ammo", var_4a50cb2a);
            if (isplayer(e_attacker)) {
                v_destination = e_attacker.origin;
            } else {
                e_player = zm_utility::get_closest_player(var_4a50cb2a);
                v_destination = e_player.origin;
            }
            mdl_powerup thread function_630f7ed5(v_destination);
        }
    }
    wait 2;
    level.var_1b7d7bb8 = 0;
    wait 6;
    level thread sentinel_round_fx(0);
    level flag::clear("sentinel_round_in_progress");
}

// Namespace zm_ai_sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0x98bb82b1, Offset: 0x3338
// Size: 0x7c
function function_630f7ed5(v_origin) {
    self endon(#"death");
    v_navmesh = getclosestpointonnavmesh(v_origin, 512, 16);
    if (isdefined(v_navmesh)) {
        wait 2;
        self moveto(v_navmesh + (0, 0, 40), 2);
    }
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x8e6978f4, Offset: 0x33c0
// Size: 0xac
function function_e930da45() {
    level.var_d6d4b6f9 = 2500 + level.round_number * -56;
    if (level.var_d6d4b6f9 < 4500) {
        level.var_d6d4b6f9 = 4500;
    } else if (level.var_d6d4b6f9 > 50000) {
        level.var_d6d4b6f9 = 50000;
    }
    level.var_d6d4b6f9 = int(level.var_d6d4b6f9 * (1 + 0.25 * (level.players.size - 1)));
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x5a6477a1, Offset: 0x3478
// Size: 0x8c
function function_6a866be7() {
    self playlocalsound("zmb_sentinel_round_start");
    wait 4.5;
    n_index = randomintrange(0, level.activeplayers.size);
    level.activeplayers[n_index] zm_audio::create_and_play_dialog("general", "sentinel_spawn");
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x999c0c26, Offset: 0x3510
// Size: 0x330
function function_3b40bf32() {
    self.targetname = "zombie_sentinel";
    self.script_noteworthy = undefined;
    self.animname = "zombie_sentinel";
    self.allowdeath = 1;
    self.allowpain = 1;
    self.force_gib = 1;
    self.is_zombie = 1;
    self.gibbed = 0;
    self.head_gibbed = 0;
    self.default_goalheight = 40;
    self.ignore_inert = 1;
    self.no_eye_glow = 1;
    self.no_powerups = 1;
    self.lightning_chain_immune = 1;
    self.holdfire = 1;
    self.grenadeawareness = 0;
    self.badplaceawareness = 0;
    self.ignoresuppression = 1;
    self.suppressionthreshold = 1;
    self.nododgemove = 1;
    self.dontshootwhilemoving = 1;
    self.pathenemylookahead = 0;
    self.chatinitialized = 0;
    self.missinglegs = 0;
    self.team = level.zombie_team;
    self.sword_kill_power = 4;
    self.var_45689097 = &function_c72cf6e1;
    self.var_cafbb1d0 = &function_49b3a408;
    if (isdefined(level.var_97596556)) {
        self.var_c3cb9d57 = level.var_97596556;
    }
    self.var_b6ccbfe2 = 1;
    self.maxhealth = level.var_d6d4b6f9;
    if (isdefined(level.var_5a487977[self.archetype]) && level.var_5a487977[self.archetype].size > 0) {
        self.health = level.var_5a487977[self.archetype][0];
        arrayremovevalue(level.var_5a487977[self.archetype], level.var_5a487977[self.archetype][0]);
    } else {
        self.health = self.maxhealth;
    }
    self thread function_d0769312();
    self thread function_6cb24476();
    self flag::init("completed_spawning");
    level thread zm_spawner::zombie_death_event(self);
    self thread zm_spawner::function_1612a0b8();
    if (self.var_c94972aa === 1) {
        self thread function_d600cb9a();
    }
    self zm_spawner::zombie_history("zombie_sentinel_spawn_init -> Spawned = " + self.origin);
    if (isdefined(level.var_9aca36e2)) {
        self thread [[ level.var_9aca36e2 ]]();
    }
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x95852347, Offset: 0x3848
// Size: 0x1cc
function function_d0769312() {
    self waittill(#"death", attacker);
    if (function_41375d48() == 0 && level.zombie_total <= 0) {
        if (!isdefined(level.var_30b36b7b) || [[ level.var_30b36b7b ]]()) {
            level.var_6a6f912a = self.origin;
            level notify(#"last_ai_down", self, attacker);
        }
    }
    if (isplayer(attacker)) {
        if (!(isdefined(self.deathpoints_already_given) && self.deathpoints_already_given)) {
            attacker zm_score::player_add_points("death_sentinel");
        }
        if (isdefined(level.hero_power_update)) {
            [[ level.hero_power_update ]](attacker, self);
        }
        attacker zm_audio::create_and_play_dialog("kill", "sentinel");
        attacker zm_stats::increment_client_stat("zsentinel_killed");
        attacker zm_stats::increment_player_stat("zsentinel_killed");
    }
    if (isdefined(attacker) && isai(attacker)) {
        attacker notify(#"killed", self);
    }
    if (isdefined(self)) {
        self stoploopsound();
        self thread function_acaa3ee4(self.origin);
    }
}

// Namespace zm_ai_sentinel_drone
// Params 1, eflags: 0x0
// Checksum 0x45213080, Offset: 0x3a20
// Size: 0xc
function function_acaa3ee4(origin) {
    
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x88a4a165, Offset: 0x3a38
// Size: 0xc0
function function_6cb24476() {
    self endon(#"death");
    var_a249f7c3 = getent("sentinel_compact", "targetname");
    while (true) {
        if (self istouching(var_a249f7c3)) {
            self sentinel_drone::function_4c8bb04a(1);
            while (self istouching(var_a249f7c3)) {
                wait 0.5;
            }
            self sentinel_drone::function_4c8bb04a(0);
        }
        wait 0.2;
    }
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0xf5fcc519, Offset: 0x3b00
// Size: 0x60
function function_60f92893() {
    self zm_spawner::zombie_history("zombie_setup_attack_properties()");
    self ai::set_ignoreall(0);
    self.meleeattackdist = 64;
    self.disablearrivals = 1;
    self.disableexits = 1;
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x912af253, Offset: 0x3b68
// Size: 0x24
function function_586ac2c3() {
    self waittill(#"death");
    self stopsounds();
}

// Namespace zm_ai_sentinel_drone
// Params 4, eflags: 0x0
// Checksum 0xce4fbc20, Offset: 0x3b98
// Size: 0x19c
function function_19d0b055(n_to_spawn, var_e41e673a, b_force_spawn, var_b7959229) {
    if (!isdefined(n_to_spawn)) {
        n_to_spawn = 1;
    }
    if (!isdefined(b_force_spawn)) {
        b_force_spawn = 0;
    }
    if (!isdefined(var_b7959229)) {
        var_b7959229 = undefined;
    }
    n_spawned = 0;
    while (n_spawned < n_to_spawn) {
        if (!b_force_spawn && !function_74ab7484()) {
            return n_spawned;
        }
        if (isdefined(var_b7959229)) {
            s_spawn_loc = var_b7959229;
        } else if (isdefined(level.var_809d579e)) {
            s_spawn_loc = [[ level.var_809d579e ]](level.var_fda4b3f3);
        } else {
            s_spawn_loc = function_f9c9e7e0();
        }
        if (!isdefined(s_spawn_loc)) {
            return 0;
        }
        ai = function_fded8158(level.var_fda4b3f3[0]);
        if (isdefined(ai)) {
            ai thread function_b27530eb(s_spawn_loc.origin);
            n_spawned++;
            if (isdefined(var_e41e673a)) {
                ai thread [[ var_e41e673a ]]();
            }
        }
        function_20c64325();
    }
    return 1;
}

// Namespace zm_ai_sentinel_drone
// Params 0, eflags: 0x0
// Checksum 0x250479b5, Offset: 0x3d40
// Size: 0x50
function function_9a59090e() {
    self endon(#"death");
    while (true) {
        self playsound("zmb_hellhound_vocals_amb");
        wait randomfloatrange(3, 6);
    }
}

// Namespace zm_ai_sentinel_drone
// Params 3, eflags: 0x0
// Checksum 0x7e2c6c52, Offset: 0x3d98
// Size: 0x2b2
function function_c72cf6e1(origin, zombie, radius) {
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"delete");
    if (isdefined(zombie.zombie_think_done) && isdefined(zombie) && zombie.zombie_think_done) {
        if (zombie.var_6c653628 !== 1 && zombie.var_3531cf2b !== 1) {
            zombie zm_elemental_zombie::function_1b1bb1b();
        }
    }
    if (isdefined(radius) && radius > 0) {
        var_199ecc3a = zm_elemental_zombie::function_4aeed0a5("sparky");
        if (!isdefined(level.var_1ae26ca5) || var_199ecc3a < level.var_1ae26ca5) {
            var_82aacc64 = zm_elemental_zombie::function_d41418b8();
            var_82aacc64 = arraysortclosest(var_82aacc64, origin);
            radius_sq = radius * radius;
            foreach (ai_zombie in var_82aacc64) {
                if (!isdefined(ai_zombie)) {
                    continue;
                }
                if (!isalive(ai_zombie)) {
                    continue;
                }
                if (!(isdefined(ai_zombie.zombie_think_done) && ai_zombie.zombie_think_done)) {
                    continue;
                }
                if (!(ai_zombie.var_6c653628 !== 1 && ai_zombie.var_3531cf2b !== 1)) {
                    continue;
                }
                dist_sq = distance2dsquared(origin, ai_zombie.origin);
                if (dist_sq <= radius_sq) {
                    ai_zombie zm_elemental_zombie::function_1b1bb1b();
                    continue;
                }
                break;
            }
        }
    }
}

// Namespace zm_ai_sentinel_drone
// Params 4, eflags: 0x0
// Checksum 0x45bf4aba, Offset: 0x4058
// Size: 0x2c0
function function_49b3a408(origin, var_1ec2ee0c, var_c6731da, radius) {
    if (!isdefined(var_1ec2ee0c)) {
        var_1ec2ee0c = 1;
    }
    if (!isdefined(var_c6731da)) {
        var_c6731da = 1;
    }
    if (!isdefined(radius)) {
        radius = 2000;
    }
    self endon(#"death");
    self endon(#"disconnect");
    self endon(#"delete");
    if (isdefined(radius) && radius > 0) {
        var_199ecc3a = zm_elemental_zombie::function_4aeed0a5("sparky");
        if (!isdefined(level.var_1ae26ca5) || var_199ecc3a < level.var_1ae26ca5) {
            var_82aacc64 = zm_elemental_zombie::function_d41418b8();
            var_82aacc64 = arraysortclosest(var_82aacc64, origin);
            radius_sq = radius * radius;
            foreach (ai_zombie in var_82aacc64) {
                if (!isdefined(ai_zombie)) {
                    continue;
                }
                if (!isalive(ai_zombie)) {
                    continue;
                }
                if (!(isdefined(ai_zombie.zombie_think_done) && ai_zombie.zombie_think_done)) {
                    continue;
                }
                if (isdefined(ai_zombie.var_3531cf2b) && ai_zombie.var_3531cf2b) {
                    continue;
                }
                if (isdefined(ai_zombie.var_6c653628) && var_1ec2ee0c && ai_zombie.var_6c653628) {
                    continue;
                }
                if (isdefined(ai_zombie.var_cc6115d2) && ai_zombie.var_cc6115d2) {
                    continue;
                }
                dist_sq = distance2dsquared(origin, ai_zombie.origin);
                if (dist_sq <= radius_sq) {
                    return ai_zombie;
                }
            }
        }
    }
    return undefined;
}

/#

    // Namespace zm_ai_sentinel_drone
    // Params 0, eflags: 0x0
    // Checksum 0x11362bb3, Offset: 0x4320
    // Size: 0x134
    function function_5715a7cc() {
        level flagsys::wait_till("<dev string:xfc>");
        adddebugcommand("<dev string:x115>");
        adddebugcommand("<dev string:x176>");
        adddebugcommand("<dev string:x1d8>");
        adddebugcommand("<dev string:x23f>");
        adddebugcommand("<dev string:x299>");
        adddebugcommand("<dev string:x2fb>");
        adddebugcommand("<dev string:x34c>");
        adddebugcommand("<dev string:x39d>");
        adddebugcommand("<dev string:x3f8>");
        adddebugcommand("<dev string:x449>");
        zm_devgui::add_custom_devgui_callback(&function_c630bba3);
    }

    // Namespace zm_ai_sentinel_drone
    // Params 1, eflags: 0x0
    // Checksum 0x1eee3a65, Offset: 0x4460
    // Size: 0x5e6
    function function_c630bba3(cmd) {
        if (level.var_fda4b3f3.size == 0) {
            return;
        }
        switch (cmd) {
        case "<dev string:x4a4>":
            player = level.players[0];
            v_direction = player getplayerangles();
            v_direction = anglestoforward(v_direction) * 8000;
            v_eye = player geteye();
            trace = bullettrace(v_eye, v_eye + v_direction, 0, undefined);
            var_feba5c63 = positionquery_source_navigation(trace["<dev string:x4b9>"], -128, 256, -128, 20);
            s_spot = spawnstruct();
            if (isdefined(var_feba5c63) && var_feba5c63.data.size > 0) {
                s_spot.origin = var_feba5c63.data[0].origin;
            } else {
                s_spot.origin = player.origin;
            }
            s_spot.angles = (0, player.angles[1] - -76, 0);
            function_19d0b055(1, undefined, 1, s_spot);
            return 1;
        case "<dev string:x4c2>":
            zm_devgui::zombie_devgui_goto_round(level.var_a78effc7);
            return 1;
        case "<dev string:x4d9>":
            curvalue = getdvarint("<dev string:x4f3>", 0);
            if (curvalue == 0) {
                curvalue = 1;
            } else {
                curvalue = 0;
            }
            setdvar("<dev string:x4f3>", curvalue);
            return 1;
        case "<dev string:x50a>":
            curvalue = getdvarint("<dev string:x524>", 0);
            if (curvalue == 0) {
                curvalue = 1;
            } else {
                curvalue = 0;
            }
            setdvar("<dev string:x524>", curvalue);
            return 1;
        case "<dev string:x540>":
            curvalue = getdvarint("<dev string:x552>", 0);
            if (curvalue == 0) {
                curvalue = 1;
            } else {
                curvalue = 0;
            }
            setdvar("<dev string:x552>", curvalue);
            return 1;
        case "<dev string:x56b>":
            curvalue = getdvarint("<dev string:x581>", 0);
            if (curvalue == 0) {
                curvalue = 1;
            } else {
                curvalue = 0;
            }
            setdvar("<dev string:x581>", curvalue);
            return 1;
        case "<dev string:x59d>":
            curvalue = getdvarint("<dev string:x5ab>", 0);
            if (curvalue == 0) {
                curvalue = 1;
            } else {
                curvalue = 0;
            }
            setdvar("<dev string:x5ab>", curvalue);
            return 1;
        case "<dev string:x5c3>":
            curvalue = getdvarint("<dev string:x5d1>", 0);
            if (curvalue == 0) {
                curvalue = 1;
            } else {
                curvalue = 0;
            }
            setdvar("<dev string:x5d1>", curvalue);
            return 1;
        case "<dev string:x5e9>":
            curvalue = getdvarint("<dev string:x5fa>", 0);
            if (curvalue == 0) {
                curvalue = 1;
            } else {
                curvalue = 0;
            }
            setdvar("<dev string:x5fa>", curvalue);
            return 1;
        case "<dev string:x619>":
            curvalue = getdvarint("<dev string:x627>", 0);
            if (curvalue == 0) {
                curvalue = 1;
            } else {
                curvalue = 0;
            }
            setdvar("<dev string:x627>", curvalue);
            return 1;
        case "<dev string:x63f>":
            curvalue = getdvarint("<dev string:x652>", 0);
            if (curvalue == 0) {
                curvalue = 1;
            } else {
                curvalue = 0;
            }
            setdvar("<dev string:x652>", curvalue);
            return 1;
        default:
            return 0;
        }
    }

#/
