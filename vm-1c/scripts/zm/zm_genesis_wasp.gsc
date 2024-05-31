#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/archetype_utility;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_util;
#using scripts/shared/ai_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/vehicles/_parasite;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/shared/aat_shared;
#using scripts/codescripts/struct;

#namespace namespace_3425d4b9;

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x7301, Offset: 0x748
// Size: 0x37c
function init() {
    level.var_3ea86e6a = 1;
    level.var_c5e6b80a = 0;
    level.var_479b039 = 1;
    level.var_c03323ec = [];
    level.var_95315b60 = [];
    level flag::init("wasp_round");
    level flag::init("wasp_round_in_progress");
    level.var_8c0eb6e6 = getdvarstring("ai_meleeRange");
    level.var_75dc7ed5 = getdvarstring("ai_meleeWidth");
    level.var_be453360 = getdvarstring("ai_meleeHeight");
    if (!isdefined(level.var_88ee4b51)) {
        level.var_88ee4b51 = 22;
    }
    clientfield::register("toplayer", "parasite_round_fx", 15000, 1, "counter");
    clientfield::register("toplayer", "parasite_round_ring_fx", 15000, 1, "counter");
    clientfield::register("world", "toggle_on_parasite_fog", 15000, 2, "int");
    clientfield::register("toplayer", "genesis_parasite_damage", 15000, 1, "counter");
    visionset_mgr::register_info("visionset", "zm_wasp_round_visionset", 15000, level.var_88ee4b51, 31, 0, &visionset_mgr::ramp_in_out_thread, 0);
    level._effect["lightning_wasp_spawn"] = "zombie/fx_parasite_spawn_buildup_zod_zmb";
    callback::on_connect(&function_f44ca0ad);
    callback::on_spawned(&function_8783c1f1);
    callback::on_ai_spawned(&function_a0684cd2);
    level thread aat::register_immunity("zm_aat_blast_furnace", "parasite", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_dead_wire", "parasite", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_fire_works", "parasite", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_thunder_wall", "parasite", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_turned", "parasite", 1, 1, 1);
    function_b6720c26();
    function_eb2708d6();
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x111fe24f, Offset: 0xad0
// Size: 0x54
function function_a0684cd2() {
    if (self.archetype == "parasite") {
        self.var_7c26245 = 1;
        self.var_345b17e3 = 4;
        self.var_e5a45dc0 = 1;
        self.var_f6999f70 = &function_64f645c3;
    }
}

// Namespace namespace_3425d4b9
// Params 1, eflags: 0x1 linked
// Checksum 0x4b5794b9, Offset: 0xb30
// Size: 0x7c
function function_64f645c3(target) {
    self.zone_name = zm_utility::get_current_zone();
    if (isdefined(self.zone_name) && self.zone_name == "apothicon_interior_zone") {
        if (isdefined(target.zone_name) && target.zone_name != "apothicon_interior_zone") {
            return false;
        }
    }
    return true;
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x0
// Checksum 0x8a9954f4, Offset: 0xbb8
// Size: 0x44
function function_9160f2b2() {
    level.var_c5e6b80a = 1;
    if (!isdefined(level.var_4f69df64)) {
        level.var_4f69df64 = &function_5b578250;
    }
    level thread [[ level.var_4f69df64 ]]();
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0xa1cbf790, Offset: 0xc08
// Size: 0x144
function function_b6720c26() {
    level.var_c03323ec = getentarray("zombie_wasp_spawner", "script_noteworthy");
    if (level.var_c03323ec.size == 0) {
        return;
    }
    for (i = 0; i < level.var_c03323ec.size; i++) {
        if (zm_spawner::is_spawner_targeted_by_blocker(level.var_c03323ec[i])) {
            level.var_c03323ec[i].is_enabled = 0;
            continue;
        }
        level.var_c03323ec[i].is_enabled = 1;
        level.var_c03323ec[i].script_forcespawn = 1;
    }
    assert(level.var_c03323ec.size > 0);
    level.var_cf0a39cd = 100;
    vehicle::add_main_callback("spawner_bo3_parasite_enemy_tool", &function_90604bb9);
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x4a9d9b92, Offset: 0xd58
// Size: 0xec
function function_eb2708d6() {
    level.var_c200ab6 = getentarray("zombie_wasp_elite_spawner", "script_noteworthy");
    for (i = 0; i < level.var_c200ab6.size; i++) {
        level.var_c200ab6[i].is_enabled = 1;
        level.var_c200ab6[i].script_forcespawn = 1;
    }
    assert(level.var_c200ab6.size > 0);
    level.var_cf0a39cd = 100;
    vehicle::add_main_callback("spawner_bo3_parasite_elite_enemy_tool", &function_7353fa6d);
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x1c0542b1, Offset: 0xe50
// Size: 0xd6
function function_acc1c531() {
    var_ba59b973 = getentarray("zombie_wasp", "targetname");
    var_abe6bb44 = var_ba59b973.size;
    foreach (wasp in var_ba59b973) {
        if (!isalive(wasp)) {
            var_abe6bb44--;
        }
    }
    return var_abe6bb44;
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x15d7e4d9, Offset: 0xf30
// Size: 0x390
function function_ad29af1f() {
    level endon(#"intermission");
    level endon(#"hash_55617c11");
    level.var_11b54123 = level.players;
    for (i = 0; i < level.var_11b54123.size; i++) {
        level.var_11b54123[i].hunted_by = 0;
    }
    level endon(#"restart_round");
    level endon(#"kill_round");
    /#
        if (getdvarint("parasite_round_ring_fx") == 2 || getdvarint("parasite_round_ring_fx") >= 4) {
            return;
        }
    #/
    if (level.intermission) {
        return;
    }
    array::thread_all(level.players, &function_ddeddb8a);
    var_4fc9044f = 10;
    if (level.players.size > 1) {
        var_4fc9044f *= level.players.size * 0.75;
    }
    function_343220d8();
    level.zombie_total = int(var_4fc9044f * 1);
    /#
        if (getdvarstring("parasite_round_ring_fx") != "parasite_round_ring_fx" && getdvarint("parasite_round_ring_fx") > 0) {
            level.zombie_total = getdvarint("parasite_round_ring_fx");
            setdvar("parasite_round_ring_fx", 0);
        }
    #/
    wait(1);
    function_2daf7170();
    visionset_mgr::activate("visionset", "zm_wasp_round_visionset", undefined, 1.5, 1.5, 2);
    level clientfield::set("toggle_on_parasite_fog", 1);
    playsoundatposition("vox_zmba_event_waspstart_0", (0, 0, 0));
    wait(6);
    var_f747e67a = 0;
    level flag::set("wasp_round_in_progress");
    level endon(#"hash_ddc0a71d");
    level thread function_ed222974();
    while (true) {
        while (level.zombie_total > 0) {
            if (isdefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
                util::wait_network_frame();
                continue;
            }
            if (isdefined(level.var_535a2969)) {
                [[ level.var_535a2969 ]]();
            } else {
                function_b820d8(1);
            }
            util::wait_network_frame();
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_3425d4b9
// Params 2, eflags: 0x1 linked
// Checksum 0x8df7561d, Offset: 0x12c8
// Size: 0x5f0
function function_b820d8(var_6237035c, var_eecf48f9) {
    var_420916f7 = 0;
    while (!var_420916f7) {
        if (isdefined(var_6237035c) && var_6237035c) {
            while (!function_5bf63224()) {
                wait(1);
            }
        }
        spawn_point = undefined;
        while (!isdefined(spawn_point)) {
            var_78436f04 = get_favorite_enemy();
            spawn_enemy = var_78436f04;
            if (!isdefined(spawn_enemy)) {
                spawn_enemy = getplayers()[0];
            }
            if (isdefined(level.var_52f3c7b5)) {
                spawn_point = [[ level.var_52f3c7b5 ]](spawn_enemy);
            } else {
                spawn_point = function_e76b0f73(spawn_enemy);
            }
            if (!isdefined(spawn_point)) {
                wait(randomfloatrange(0.666667, 1.33333));
            }
        }
        var_6a724b3a = spawn_point.origin;
        v_ground = bullettrace(spawn_point.origin + (0, 0, 60), spawn_point.origin + (0, 0, 60) + (0, 0, -100000), 0, undefined)["position"];
        if (distancesquared(v_ground, spawn_point.origin) < 3600) {
            var_6a724b3a = v_ground + (0, 0, 60);
        }
        queryresult = positionquery_source_navigation(var_6a724b3a, 0, 80, 80, 15, "navvolume_small");
        a_points = array::randomize(queryresult.data);
        var_8d090f42 = [];
        var_4eb24b0 = 0;
        foreach (point in a_points) {
            if (bullettracepassed(point.origin, spawn_point.origin, 0, spawn_enemy)) {
                if (!isdefined(var_8d090f42)) {
                    var_8d090f42 = [];
                } else if (!isarray(var_8d090f42)) {
                    var_8d090f42 = array(var_8d090f42);
                }
                var_8d090f42[var_8d090f42.size] = point.origin;
                var_4eb24b0++;
                if (var_4eb24b0 >= 1) {
                    break;
                }
            }
        }
        if (var_8d090f42.size >= 1) {
            n_spawn = 0;
            while (n_spawn < 1 && level.zombie_total > 0) {
                for (i = var_8d090f42.size - 1; i >= 0; i--) {
                    v_origin = var_8d090f42[i];
                    if (isdefined(var_eecf48f9) && var_eecf48f9) {
                        sp_wasp = level.var_c200ab6[0];
                    } else {
                        sp_wasp = level.var_c03323ec[0];
                    }
                    sp_wasp.origin = v_origin;
                    ai = zombie_utility::spawn_zombie(sp_wasp);
                    if (isdefined(ai)) {
                        ai parasite::function_61692488(var_78436f04);
                        level thread function_198fe8b9(ai, v_origin);
                        arrayremoveindex(var_8d090f42, i);
                        if (isdefined(level.var_300c5ed6)) {
                            ai thread [[ level.var_300c5ed6 ]]();
                        }
                        ai.ignore_nuke = 1;
                        ai.heroweapon_kill_power = 2;
                        n_spawn++;
                        level.zombie_total--;
                        wait(randomfloatrange(0.0666667, 0.133333));
                        if (isdefined(ai)) {
                            ai.ignore_nuke = undefined;
                        }
                        break;
                    }
                    wait(randomfloatrange(0.0666667, 0.133333));
                }
            }
            var_420916f7 = 1;
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0xf1b8fde8, Offset: 0x18c0
// Size: 0xb2
function function_2daf7170() {
    foreach (player in level.players) {
        player clientfield::increment_to_player("parasite_round_fx");
        player clientfield::increment_to_player("parasite_round_ring_fx");
    }
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x895ef1bb, Offset: 0x1980
// Size: 0x88
function show_hit_marker() {
    if (isdefined(self) && isdefined(self.hud_damagefeedback)) {
        self.hud_damagefeedback setshader("damage_feedback", 24, 48);
        self.hud_damagefeedback.alpha = 1;
        self.hud_damagefeedback fadeovertime(1);
        self.hud_damagefeedback.alpha = 0;
    }
}

// Namespace namespace_3425d4b9
// Params 12, eflags: 0x0
// Checksum 0x3e015bf1, Offset: 0x1a10
// Size: 0x88
function function_28a344cb(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (isdefined(attacker)) {
        attacker show_hit_marker();
    }
    return damage;
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0xfa4d64ca, Offset: 0x1aa0
// Size: 0x90
function function_5bf63224() {
    var_f747e67a = function_acc1c531();
    var_db6ffd10 = var_f747e67a >= 16;
    var_edf34246 = var_f747e67a >= level.players.size * 5;
    if (var_db6ffd10 || var_edf34246 || !level flag::get("spawn_zombies")) {
        return false;
    }
    return true;
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0xc193161f, Offset: 0x1b38
// Size: 0x12c
function function_ed222974() {
    var_dedf403c = level waittill(#"hash_ddc0a71d");
    level thread zm_audio::sndmusicsystem_playstate("parasite_over");
    if (isdefined(level.var_716fc13e)) {
        [[ level.var_716fc13e ]](var_dedf403c, level.var_1414f4e7);
    } else if (isdefined(level.var_1414f4e7)) {
        enemy = var_dedf403c.favoriteenemy;
        if (!isdefined(enemy)) {
            enemy = array::random(level.players);
        }
        enemy function_7297d7dc(level.var_1414f4e7);
    }
    wait(2);
    level clientfield::set("toggle_on_parasite_fog", 2);
    level.var_1b7d7bb8 = 0;
    wait(6);
    level flag::clear("wasp_round_in_progress");
}

// Namespace namespace_3425d4b9
// Params 1, eflags: 0x1 linked
// Checksum 0x15564f0, Offset: 0x1c70
// Size: 0x38c
function function_7297d7dc(var_b431a344) {
    if (!zm_utility::check_point_in_enabled_zone(var_b431a344, 1, level.active_zones)) {
        var_fe1e2b36 = level zm_powerups::specific_powerup_drop("full_ammo", var_b431a344);
        current_zone = self zm_utility::get_current_zone();
        if (isdefined(current_zone)) {
            v_start = var_fe1e2b36.origin;
            e_closest_player = arraygetclosest(v_start, level.activeplayers);
            if (isdefined(e_closest_player)) {
                v_target = e_closest_player.origin + (0, 0, 20);
                var_74e586e9 = distance(v_start, v_target);
                v_dir = vectornormalize(v_target - v_start);
                n_step = 50;
                var_54af6f01 = 0;
                v_position = v_start;
                while (var_54af6f01 <= var_74e586e9) {
                    v_position += v_dir * n_step;
                    if (zm_utility::check_point_in_enabled_zone(v_position, 1, level.active_zones)) {
                        n_height_diff = abs(v_target[2] - v_position[2]);
                        if (n_height_diff < 60) {
                            break;
                        }
                    }
                    var_54af6f01 += n_step;
                }
                trace = bullettrace(v_position, v_position + (0, 0, -256), 0, undefined);
                var_80f08819 = trace["position"];
                if (isdefined(var_80f08819)) {
                    v_position = (v_position[0], v_position[1], var_80f08819[2] + 20);
                }
                var_75db6f3a = distance(v_start, v_position) / 100;
                if (var_75db6f3a > 4) {
                    var_75db6f3a = 4;
                }
                var_fe1e2b36 moveto(v_position, var_75db6f3a);
            } else {
                var_20b4bda6 = getclosestpointonnavmesh(var_fe1e2b36.origin, 2000, 32);
            }
        }
        return;
    }
    level zm_powerups::specific_powerup_drop("full_ammo", getclosestpointonnavmesh(var_b431a344, 1000, 30));
}

// Namespace namespace_3425d4b9
// Params 3, eflags: 0x1 linked
// Checksum 0x2618aa7, Offset: 0x2008
// Size: 0x2ac
function function_198fe8b9(ai, origin, var_f53e88f5) {
    if (!isdefined(var_f53e88f5)) {
        var_f53e88f5 = 1;
    }
    ai endon(#"death");
    ai setinvisibletoall();
    if (isdefined(origin)) {
        v_origin = origin;
    } else {
        v_origin = ai.origin;
    }
    if (var_f53e88f5) {
        playfx(level._effect["lightning_wasp_spawn"], v_origin);
    }
    wait(1.5);
    earthquake(0.3, 0.5, v_origin, 256);
    if (isdefined(ai.favoriteenemy)) {
        angle = vectortoangles(ai.favoriteenemy.origin - v_origin);
    } else {
        angle = ai.angles;
    }
    angles = (ai.angles[0], angle[1], ai.angles[2]);
    ai.origin = v_origin;
    ai.angles = angles;
    assert(isdefined(ai), "parasite_round_ring_fx");
    assert(isalive(ai), "parasite_round_ring_fx");
    ai thread function_c26d5716();
    if (isdefined(level.var_45145796)) {
        ai callback::add_callback(#"hash_acb66515", level.var_45145796);
    }
    ai.overridevehicledamage = &damage_callback;
    ai setvisibletoall();
    ai.ignoreme = 0;
    ai notify(#"visible");
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0xc7349723, Offset: 0x22c0
// Size: 0x17a
function function_c620c427() {
    if (!isdefined(level.var_8580c6ea)) {
        level.var_8580c6ea = [];
        keys = getarraykeys(level.zones);
        for (i = 0; i < keys.size; i++) {
            zone = level.zones[keys[i]];
            foreach (loc in zone.a_locs["wasp_location"]) {
                if (!isdefined(level.var_8580c6ea)) {
                    level.var_8580c6ea = [];
                } else if (!isarray(level.var_8580c6ea)) {
                    level.var_8580c6ea = array(level.var_8580c6ea);
                }
                level.var_8580c6ea[level.var_8580c6ea.size] = loc;
            }
        }
    }
}

// Namespace namespace_3425d4b9
// Params 1, eflags: 0x1 linked
// Checksum 0x1390720b, Offset: 0x2448
// Size: 0x118
function function_e97b4687(var_78436f04) {
    var_3d7bf00d = 0;
    var_494687ca = distancesquared(level.var_8580c6ea[var_3d7bf00d].origin, var_78436f04.origin);
    for (i = 0; i < level.var_8580c6ea.size; i++) {
        if (level.var_8580c6ea[i].is_enabled) {
            dist_squared = distancesquared(level.var_8580c6ea[i].origin, var_78436f04.origin);
            if (dist_squared < var_494687ca) {
                var_3d7bf00d = i;
                var_494687ca = dist_squared;
            }
        }
    }
    return level.var_8580c6ea[var_3d7bf00d];
}

// Namespace namespace_3425d4b9
// Params 1, eflags: 0x1 linked
// Checksum 0x7340252b, Offset: 0x2568
// Size: 0x398
function function_e76b0f73(var_78436f04) {
    if (!getdvarint("zm_wasp_open_spawning", 0)) {
        var_53c1778e = level.zm_loc_types["wasp_location"];
        if (var_53c1778e.size == 0) {
            function_c620c427();
            return function_e97b4687(var_78436f04);
        }
        if (isdefined(level.var_dd2b81b2)) {
            dist_squared = distancesquared(level.var_dd2b81b2.origin, var_78436f04.origin);
            if (dist_squared > 160000 && dist_squared < 360000) {
                return level.var_dd2b81b2;
            }
        }
        foreach (loc in var_53c1778e) {
            dist_squared = distancesquared(loc.origin, var_78436f04.origin);
            if (dist_squared > 160000 && dist_squared < 360000) {
                level.var_dd2b81b2 = loc;
                return loc;
            }
        }
    }
    switch (level.players.size) {
    case 4:
        var_e010863a = 600;
        break;
    case 3:
        var_e010863a = 700;
        break;
    case 2:
        var_e010863a = 900;
        break;
    case 1:
    default:
        var_e010863a = 1200;
        break;
    }
    queryresult = positionquery_source_navigation(var_78436f04.origin + (0, 0, randomintrange(40, 100)), 300, var_e010863a, 10, 10, "navvolume_small");
    a_points = array::randomize(queryresult.data);
    foreach (point in a_points) {
        if (bullettracepassed(point.origin, var_78436f04.origin, 0, var_78436f04)) {
            level.var_dd2b81b2 = point;
            return point;
        }
    }
    return a_points[0];
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x79686c79, Offset: 0x2908
// Size: 0xa4
function get_favorite_enemy() {
    if (level.var_95315b60.size > 0) {
        e_enemy = level.var_95315b60[0];
        if (isdefined(e_enemy)) {
            arrayremovevalue(level.var_95315b60, e_enemy);
            return e_enemy;
        }
    }
    if (isdefined(level.var_e863f304)) {
        e_enemy = [[ level.var_e863f304 ]]();
        return e_enemy;
    }
    target = parasite::function_d3d4f77c();
    return target;
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x2ebafcc0, Offset: 0x29b8
// Size: 0x50
function function_343220d8() {
    players = getplayers();
    level.var_cf0a39cd = level.round_number * 50;
    if (level.var_cf0a39cd > 1600) {
        level.var_cf0a39cd = 1600;
    }
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x305deea3, Offset: 0x2a10
// Size: 0x74
function function_cab4d930() {
    level endon(#"restart_round");
    level endon(#"kill_round");
    if (level flag::get("wasp_round")) {
        level flag::wait_till("wasp_round_in_progress");
        level flag::wait_till_clear("wasp_round_in_progress");
    }
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x527f304b, Offset: 0x2a90
// Size: 0x22c
function function_5b578250() {
    level.var_479b039 = 1;
    level.var_ef0c0bfd = level.round_number + randomintrange(7, 10);
    old_spawn_func = level.round_spawn_func;
    old_wait_func = level.round_wait_func;
    while (true) {
        level waittill(#"between_round_over");
        /#
            if (getdvarint("parasite_round_ring_fx") > 0) {
                level.var_ef0c0bfd = level.round_number;
            }
        #/
        if (level.round_number == level.var_ef0c0bfd) {
            level.var_1b7d7bb8 = 1;
            old_spawn_func = level.round_spawn_func;
            old_wait_func = level.round_wait_func;
            function_3084f670();
            level.round_spawn_func = &function_ad29af1f;
            level.round_wait_func = &function_cab4d930;
            if (isdefined(level.var_ad6409de)) {
                level.var_ef0c0bfd = [[ level.var_ad6409de ]]();
            } else {
                level.var_ef0c0bfd = 5 + level.var_479b039 * 10 + randomintrange(-1, 1);
            }
            /#
                getplayers()[0] iprintln("parasite_round_ring_fx" + level.var_ef0c0bfd);
            #/
            continue;
        }
        if (level flag::get("wasp_round")) {
            function_b483bfbc();
            level.round_spawn_func = old_spawn_func;
            level.round_wait_func = old_wait_func;
            level.var_479b039 += 1;
        }
    }
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x545056f6, Offset: 0x2cc8
// Size: 0xe4
function function_3084f670() {
    level flag::set("wasp_round");
    level flag::set("special_round");
    if (!isdefined(level.var_62832933)) {
        level.var_62832933 = 0;
    }
    level.var_62832933 = 1;
    level notify(#"hash_1cf867e8");
    level thread zm_audio::sndmusicsystem_playstate("parasite_start");
    if (isdefined(level.var_75f5d7b3)) {
        setdvar("ai_meleeRange", level.var_75f5d7b3);
        return;
    }
    setdvar("ai_meleeRange", 100);
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0xd7c2f236, Offset: 0x2db8
// Size: 0xd4
function function_b483bfbc() {
    level flag::clear("wasp_round");
    level flag::clear("special_round");
    if (!isdefined(level.var_62832933)) {
        level.var_62832933 = 0;
    }
    level.var_62832933 = 0;
    level notify(#"hash_c6d41add");
    setdvar("ai_meleeRange", level.var_8c0eb6e6);
    setdvar("ai_meleeWidth", level.var_75dc7ed5);
    setdvar("ai_meleeHeight", level.var_be453360);
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x55075a3f, Offset: 0x2e98
// Size: 0x40
function function_ddeddb8a() {
    self playlocalsound("zmb_wasp_round_start");
    variation_count = 5;
    wait(4.5);
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0xba9bb318, Offset: 0x2ee0
// Size: 0x400
function function_90604bb9() {
    self.targetname = "zombie_wasp";
    self.script_noteworthy = undefined;
    self.animname = "zombie_wasp";
    self.ignoreall = 1;
    self.ignoreme = 1;
    self.allowdeath = 1;
    self.allowpain = 0;
    self.no_gib = 1;
    self.is_zombie = 1;
    self.gibbed = 0;
    self.head_gibbed = 0;
    self.default_goalheight = 40;
    self.ignore_inert = 1;
    self.no_eye_glow = 1;
    self.lightning_chain_immune = 1;
    self.holdfire = 0;
    self.grenadeawareness = 0;
    self.badplaceawareness = 0;
    self.ignoresuppression = 1;
    self.suppressionthreshold = 1;
    self.nododgemove = 1;
    self.dontshootwhilemoving = 1;
    self.pathenemylookahead = 0;
    self.badplaceawareness = 0;
    self.chatinitialized = 0;
    self.missinglegs = 0;
    self.isdog = 0;
    self.teslafxtag = "tag_origin";
    self.var_f9127ea5 = 2;
    self setgrapplabletype(self.var_f9127ea5);
    self.team = level.zombie_team;
    self.sword_kill_power = 2;
    if (!isdefined(self.heroweapon_kill_power)) {
        self.heroweapon_kill_power = 2;
    }
    parasite::function_41ba5057();
    health_multiplier = 1;
    if (getdvarstring("scr_wasp_health_walk_multiplier") != "") {
        health_multiplier = getdvarfloat("scr_wasp_health_walk_multiplier");
    }
    self.maxhealth = int(level.var_cf0a39cd * health_multiplier);
    if (isdefined(level.var_5a487977[self.archetype]) && level.var_5a487977[self.archetype].size > 0) {
        self.health = level.var_5a487977[self.archetype][0];
        arrayremovevalue(level.var_5a487977[self.archetype], level.var_5a487977[self.archetype][0]);
    } else {
        self.health = int(level.var_cf0a39cd * health_multiplier);
    }
    self thread function_77be2d1b();
    self thread function_fbbc7f73();
    self setinvisibletoall();
    self thread function_1b18c607();
    self thread function_a5ceec2f();
    level thread zm_spawner::zombie_death_event(self);
    self thread zm_spawner::function_1612a0b8();
    self zm_spawner::zombie_history("zombie_wasp_spawn_init -> Spawned = " + self.origin);
    if (isdefined(level.var_9aca36e2)) {
        self [[ level.var_9aca36e2 ]]();
    }
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x6068b3d8, Offset: 0x32e8
// Size: 0x420
function function_7353fa6d() {
    self.targetname = "zombie_wasp";
    self.script_noteworthy = undefined;
    self.animname = "zombie_wasp";
    self.ignoreall = 1;
    self.ignoreme = 1;
    self.allowdeath = 1;
    self.allowpain = 0;
    self.no_gib = 1;
    self.is_zombie = 1;
    self.gibbed = 0;
    self.head_gibbed = 0;
    self.default_goalheight = 40;
    self.ignore_inert = 1;
    self.no_eye_glow = 1;
    self.var_18ee8d81 = 1;
    self.lightning_chain_immune = 1;
    self.holdfire = 0;
    self.grenadeawareness = 0;
    self.badplaceawareness = 0;
    self.ignoresuppression = 1;
    self.suppressionthreshold = 1;
    self.nododgemove = 1;
    self.dontshootwhilemoving = 1;
    self.pathenemylookahead = 0;
    self.badplaceawareness = 0;
    self.chatinitialized = 0;
    self.missinglegs = 0;
    self.isdog = 0;
    self.teslafxtag = "tag_origin";
    self.var_f9127ea5 = 2;
    self setgrapplabletype(self.var_f9127ea5);
    self.team = level.zombie_team;
    self.sword_kill_power = 2;
    if (!isdefined(self.heroweapon_kill_power)) {
        self.heroweapon_kill_power = 2;
    }
    parasite::function_41ba5057();
    health_multiplier = 2;
    if (getdvarstring("scr_wasp_health_walk_multiplier") != "") {
        health_multiplier = getdvarfloat("scr_wasp_health_walk_multiplier");
    }
    self.maxhealth = int(level.var_cf0a39cd * health_multiplier);
    if (isdefined(level.var_5a487977[self.archetype]) && level.var_5a487977[self.archetype].size > 0) {
        self.health = level.var_5a487977[self.archetype][0];
        arrayremovevalue(level.var_5a487977[self.archetype], level.var_5a487977[self.archetype][0]);
    } else {
        self.health = int(level.var_cf0a39cd * health_multiplier);
    }
    self thread function_77be2d1b();
    self thread function_fbbc7f73();
    self setinvisibletoall();
    self thread function_1b18c607();
    self thread function_a5ceec2f();
    level thread zm_spawner::zombie_death_event(self);
    self thread zm_spawner::function_1612a0b8();
    self.thundergun_knockdown_func = &function_59cb9292;
    self zm_spawner::zombie_history("zombie_wasp_spawn_init -> Spawned = " + self.origin);
    if (isdefined(level.var_9aca36e2)) {
        self [[ level.var_9aca36e2 ]]();
    }
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0xd777320b, Offset: 0x3710
// Size: 0x164
function function_a5ceec2f() {
    self endon(#"death");
    var_bdc1f530 = gettime();
    n_check_time = var_bdc1f530;
    var_bf3517b2 = self.origin;
    while (true) {
        n_current_time = gettime();
        if (isdefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
            n_check_time = n_current_time;
            wait(1);
            continue;
        }
        n_dist = distance(var_bf3517b2, self.origin);
        if (n_dist > 100) {
            n_check_time = n_current_time;
            var_bf3517b2 = self.origin;
        } else {
            n_delta_time = (n_current_time - n_check_time) / 1000;
            if (n_delta_time >= 20) {
                break;
            }
        }
        n_delta_time = (n_current_time - var_bdc1f530) / 1000;
        if (n_delta_time >= -106) {
            break;
        }
        wait(1);
    }
    self dodamage(self.health + 100, self.origin);
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0xceb0de95, Offset: 0x3880
// Size: 0x19c
function function_1b18c607() {
    attacker = self waittill(#"death");
    if (function_acc1c531() == 0 && level.zombie_total == 0) {
        if (!isdefined(level.var_30b36b7b) || [[ level.var_30b36b7b ]]()) {
            level.var_1414f4e7 = self.origin;
            level notify(#"hash_ddc0a71d", self);
        }
    }
    if (isplayer(attacker)) {
        if (isdefined(attacker.var_65f06b5) && attacker.var_65f06b5) {
            attacker notify(#"hash_7cbe31f2");
        }
        attacker zm_score::player_add_points("death_wasp", 70);
        if (isdefined(level.hero_power_update)) {
            [[ level.hero_power_update ]](attacker, self);
        }
        attacker zm_stats::increment_client_stat("zwasp_killed");
        attacker zm_stats::increment_player_stat("zwasp_killed");
    }
    if (isdefined(attacker) && isai(attacker)) {
        attacker notify(#"killed", self);
    }
    self stoploopsound();
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0xff84372f, Offset: 0x3a28
// Size: 0xdc
function function_c26d5716() {
    self zm_spawner::zombie_history("zombie_setup_attack_properties()");
    self thread function_e0de0394();
    self.ignoreall = 0;
    self.meleeattackdist = 64;
    self.disablearrivals = 1;
    self.disableexits = 1;
    if (level.var_479b039 == 2) {
        self ai::set_behavior_attribute("firing_rate", "medium");
        return;
    }
    if (level.var_479b039 > 2) {
        self ai::set_behavior_attribute("firing_rate", "fast");
    }
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x1d723d41, Offset: 0x3b10
// Size: 0x24
function function_e2635cb0() {
    self waittill(#"death");
    self stopsounds();
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x1190d382, Offset: 0x3b40
// Size: 0x1b0
function function_e0de0394() {
    self thread function_e2635cb0();
    self endon(#"death");
    self util::waittill_any("wasp_running", "wasp_combat");
    wait(3);
    while (true) {
        players = getplayers();
        for (i = 0; i < players.size; i++) {
            var_c5c1c831 = angleclamp180(vectortoangles(self.origin - players[i].origin)[1] - players[i].angles[1]);
            if (isalive(players[i]) && !isdefined(players[i].revivetrigger)) {
                if (abs(var_c5c1c831) > 90 && distance2d(self.origin, players[i].origin) > 100) {
                    wait(3);
                }
            }
        }
        wait(0.75);
    }
}

// Namespace namespace_3425d4b9
// Params 7, eflags: 0x1 linked
// Checksum 0xb3030567, Offset: 0x3cf8
// Size: 0x34c
function function_8aeb3564(n_to_spawn, spawn_point, n_radius, n_half_height, var_effeecc4, spawn_fx, var_a3ed4587) {
    if (!isdefined(n_to_spawn)) {
        n_to_spawn = 1;
    }
    if (!isdefined(n_radius)) {
        n_radius = 32;
    }
    if (!isdefined(n_half_height)) {
        n_half_height = 32;
    }
    if (!isdefined(spawn_fx)) {
        spawn_fx = 1;
    }
    if (!isdefined(var_a3ed4587)) {
        var_a3ed4587 = 0;
    }
    wasp = getentarray("zombie_wasp", "targetname");
    if (isdefined(wasp) && wasp.size >= 9) {
        return 0;
    }
    count = 0;
    while (count < n_to_spawn) {
        players = getplayers();
        var_78436f04 = get_favorite_enemy();
        spawn_enemy = var_78436f04;
        if (!isdefined(spawn_enemy)) {
            spawn_enemy = players[0];
        }
        if (isdefined(level.var_52f3c7b5)) {
            spawn_point = [[ level.var_52f3c7b5 ]](spawn_enemy);
        }
        while (!isdefined(spawn_point)) {
            if (!isdefined(spawn_point)) {
                spawn_point = function_e76b0f73(spawn_enemy);
            }
            if (isdefined(spawn_point)) {
                break;
            }
            wait(0.05);
        }
        ai = zombie_utility::spawn_zombie(level.var_c03323ec[0]);
        var_6a724b3a = spawn_point.origin;
        if (isdefined(ai)) {
            queryresult = positionquery_source_navigation(var_6a724b3a, 0, n_radius, n_half_height, 15, "navvolume_small");
            if (queryresult.data.size) {
                point = queryresult.data[randomint(queryresult.data.size)];
                var_6a724b3a = point.origin;
            }
            ai parasite::function_61692488(var_78436f04);
            ai.var_a3c425d1 = var_effeecc4;
            level thread function_198fe8b9(ai, var_6a724b3a, spawn_fx);
            count++;
        }
        wait(level.zombie_vars["zombie_spawn_delay"]);
    }
    if (var_a3ed4587) {
        return ai;
    }
    return 1;
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x922b9f9c, Offset: 0x4050
// Size: 0x84
function function_77be2d1b() {
    self endon(#"death");
    self waittill(#"visible");
    if (self.health > level.var_cf0a39cd) {
        self.maxhealth = level.var_cf0a39cd;
        self.health = level.var_cf0a39cd;
    }
    while (true) {
        if (zm_utility::is_player_valid(self.favoriteenemy)) {
        }
        wait(0.2);
    }
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x1c230c9, Offset: 0x40e0
// Size: 0x1d8
function function_fbbc7f73() {
    self endon(#"death");
    self waittill(#"visible");
    while (isdefined(self)) {
        player, weapon = level waittill(#"player_melee");
        var_87af6626 = player geteye();
        dist2 = distance2dsquared(var_87af6626, self.origin);
        if (dist2 > 5184) {
            continue;
        }
        if (abs(var_87af6626[2] - self.origin[2]) > 64) {
            continue;
        }
        var_9d0ec586 = player getweaponforwarddir();
        tome = self.origin - var_87af6626;
        tome = vectornormalize(tome);
        dot = vectordot(var_9d0ec586, tome);
        if (dot < 0.5) {
            continue;
        }
        damage = -106;
        if (isdefined(weapon)) {
            damage = weapon.meleedamage;
        }
        self dodamage(damage, var_87af6626, player, player, "none", "MOD_MELEE", 0, weapon);
    }
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0x1e8dfb32, Offset: 0x42c0
// Size: 0x3e
function function_f44ca0ad() {
    self endon(#"disconnect");
    for (;;) {
        weapon = self waittill(#"weapon_melee");
        level notify(#"player_melee", self, weapon);
    }
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x0
// Checksum 0xba673e02, Offset: 0x4308
// Size: 0x50
function function_a830d157() {
    self endon(#"death");
    self endon(#"hash_bf7a82d4");
    self endon(#"hash_e1fbc263");
    while (true) {
        wait(randomfloatrange(3, 6));
    }
}

// Namespace namespace_3425d4b9
// Params 2, eflags: 0x1 linked
// Checksum 0xa63c7213, Offset: 0x4360
// Size: 0x7c
function function_59cb9292(player, gib) {
    self endon(#"death");
    damage = int(self.maxhealth * 0.5);
    self dodamage(damage, player.origin, player);
}

// Namespace namespace_3425d4b9
// Params 1, eflags: 0x0
// Checksum 0x401bcef4, Offset: 0x43e8
// Size: 0x3c
function function_c93c5341(var_c1c8e05) {
    if (isdefined(var_c1c8e05)) {
        array::add(level.var_95315b60, var_c1c8e05);
    }
    level.zombie_total++;
}

// Namespace namespace_3425d4b9
// Params 15, eflags: 0x1 linked
// Checksum 0x81eae405, Offset: 0x4430
// Size: 0xe4
function damage_callback(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
    if (isdefined(eattacker.var_e8e8daad) && isplayer(eattacker) && eattacker.var_e8e8daad) {
        idamage = int(idamage * 1.5);
    }
    return idamage;
}

// Namespace namespace_3425d4b9
// Params 0, eflags: 0x1 linked
// Checksum 0xf6933090, Offset: 0x4520
// Size: 0xa0
function function_8783c1f1() {
    self notify(#"hash_ca45e24c");
    self endon(#"hash_ca45e24c");
    self endon(#"death");
    while (true) {
        var_45e53fb5, e_attacker = self waittill(#"damage");
        if (isdefined(e_attacker.var_8a1ad3bb) && e_attacker.var_8a1ad3bb) {
            self clientfield::increment_to_player("genesis_parasite_damage");
        }
    }
}

