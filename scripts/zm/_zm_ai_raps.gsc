#using scripts/shared/ai/zombie_utility;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_stats;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_powerups;
#using scripts/zm/_zm_net;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm;
#using scripts/zm/_util;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/vehicles/_raps;
#using scripts/shared/vehicle_ai_shared;
#using scripts/shared/vehicle_shared;
#using scripts/shared/util_shared;
#using scripts/shared/trigger_shared;
#using scripts/shared/system_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/array_shared;
#using scripts/shared/aat_shared;
#using scripts/codescripts/struct;

#namespace namespace_5ace0f0e;

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0x6c2c62c3, Offset: 0x810
// Size: 0x32c
function init() {
    level.var_a6025843 = 1;
    level.var_e55eed95 = 0;
    level.var_8d723b0c = 1;
    level.var_b15f9e1f = [];
    level flag::init("raps_round");
    level flag::init("raps_round_in_progress");
    level.var_8c0eb6e6 = getdvarstring("ai_meleeRange");
    level.var_75dc7ed5 = getdvarstring("ai_meleeWidth");
    level.var_be453360 = getdvarstring("ai_meleeHeight");
    if (!isdefined(level.var_1552cb98)) {
        level.var_1552cb98 = 21;
    }
    clientfield::register("toplayer", "elemental_round_fx", 1, 1, "counter");
    clientfield::register("toplayer", "elemental_round_ring_fx", 1, 1, "counter");
    visionset_mgr::register_info("visionset", "zm_elemental_round_visionset", 1, level.var_1552cb98, 31, 0, &visionset_mgr::ramp_in_out_thread, 0);
    level._effect["raps_meteor_fire"] = "zombie/fx_meatball_trail_sky_zod_zmb";
    level._effect["raps_ground_spawn"] = "zombie/fx_meatball_impact_ground_tell_zod_zmb";
    level._effect["raps_portal"] = "zombie/fx_meatball_portal_sky_zod_zmb";
    level._effect["raps_gib"] = "zombie/fx_meatball_explo_zod_zmb";
    level._effect["raps_trail_blood"] = "zombie/fx_meatball_trail_ground_zod_zmb";
    level._effect["raps_impact"] = "zombie/fx_meatball_impact_ground_zod_zmb";
    level thread aat::register_immunity("zm_aat_blast_furnace", "raps", 0, 1, 0);
    level thread aat::register_immunity("zm_aat_dead_wire", "raps", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_fire_works", "raps", 1, 1, 1);
    level thread aat::register_immunity("zm_aat_thunder_wall", "raps", 0, 0, 1);
    level thread aat::register_immunity("zm_aat_turned", "raps", 1, 1, 1);
    function_832f3a1d();
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xfd95145b, Offset: 0xb48
// Size: 0x44
function function_9eddef7d() {
    level.var_e55eed95 = 1;
    if (!isdefined(level.var_4800147b)) {
        level.var_4800147b = &function_6a5700a1;
    }
    level thread [[ level.var_4800147b ]]();
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0x9fc93947, Offset: 0xb98
// Size: 0x19c
function function_832f3a1d() {
    level.var_b15f9e1f = getentarray("zombie_raps_spawner", "script_noteworthy");
    var_987f1b28 = getentarray("later_round_raps_spawners", "script_noteworthy");
    level.var_b15f9e1f = arraycombine(level.var_b15f9e1f, var_987f1b28, 1, 0);
    if (level.var_b15f9e1f.size == 0) {
        return;
    }
    for (i = 0; i < level.var_b15f9e1f.size; i++) {
        if (zm_spawner::is_spawner_targeted_by_blocker(level.var_b15f9e1f[i])) {
            level.var_b15f9e1f[i].is_enabled = 0;
            continue;
        }
        level.var_b15f9e1f[i].is_enabled = 1;
        level.var_b15f9e1f[i].script_forcespawn = 1;
    }
    /#
        assert(level.var_b15f9e1f.size > 0);
    #/
    level.var_26944d = 100;
    vehicle::add_main_callback("spawner_enemy_zombie_vehicle_raps_suicide", &function_50aa1d36);
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0x8c951f3b, Offset: 0xd40
// Size: 0x218
function function_6a5700a1() {
    level.var_8d723b0c = 1;
    level.var_fe8c915f = randomintrange(9, 11);
    old_spawn_func = level.round_spawn_func;
    old_wait_func = level.round_wait_func;
    while (true) {
        level waittill(#"between_round_over");
        /#
            if (getdvarint("meatball_over") > 0) {
                level.var_fe8c915f = level.round_number;
            }
        #/
        if (level.round_number == level.var_fe8c915f) {
            level.var_1b7d7bb8 = 1;
            old_spawn_func = level.round_spawn_func;
            old_wait_func = level.round_wait_func;
            function_6b56a03d();
            level.round_spawn_func = &function_540e640;
            level.round_wait_func = &function_4a047c7d;
            if (isdefined(level.var_507242bb)) {
                level.var_fe8c915f = [[ level.var_507242bb ]]();
            } else {
                level.var_fe8c915f = 10 + level.var_8d723b0c * 10 + randomintrange(-1, 1);
            }
            /#
                getplayers()[0] iprintln("raps_location" + level.var_fe8c915f);
            #/
            continue;
        }
        if (level flag::get("raps_round")) {
            function_79f0236f();
            level.round_spawn_func = old_spawn_func;
            level.round_wait_func = old_wait_func;
            level.var_8d723b0c++;
        }
    }
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xfbd44935, Offset: 0xf60
// Size: 0xe4
function function_6b56a03d() {
    level flag::set("raps_round");
    level flag::set("special_round");
    if (!isdefined(level.var_a14d56dc)) {
        level.var_a14d56dc = 0;
    }
    level.var_a14d56dc = 1;
    level notify(#"hash_d87eecab");
    level thread zm_audio::sndmusicsystem_playstate("meatball_start");
    if (isdefined(level.var_cd95522)) {
        setdvar("ai_meleeRange", level.var_cd95522);
        return;
    }
    setdvar("ai_meleeRange", 100);
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xcee835b7, Offset: 0x1050
// Size: 0xd4
function function_79f0236f() {
    level flag::clear("raps_round");
    level flag::clear("special_round");
    if (!isdefined(level.var_a14d56dc)) {
        level.var_a14d56dc = 0;
    }
    level.var_a14d56dc = 0;
    level notify(#"hash_4e5d77b2");
    setdvar("ai_meleeRange", level.var_8c0eb6e6);
    setdvar("ai_meleeWidth", level.var_75dc7ed5);
    setdvar("ai_meleeHeight", level.var_be453360);
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xa875a308, Offset: 0x1130
// Size: 0x348
function function_540e640() {
    level endon(#"intermission");
    level endon(#"raps_round");
    level.var_bb7a82fa = getplayers();
    for (i = 0; i < level.var_bb7a82fa.size; i++) {
        level.var_bb7a82fa[i].hunted_by = 0;
    }
    level endon(#"restart_round");
    level endon(#"kill_round");
    /#
        if (getdvarint("<unknown string>") == 2 || getdvarint("<unknown string>") >= 4) {
            return;
        }
    #/
    if (level.intermission) {
        return;
    }
    array::thread_all(level.players, &function_493a8f7f);
    var_4fc9044f = function_66bb4851();
    function_2a8df909();
    level.zombie_total = int(var_4fc9044f);
    /#
        if (getdvarstring("meatball_over") != "<unknown string>" && getdvarint("meatball_over") > 0) {
            level.zombie_total = getdvarint("meatball_over");
            setdvar("meatball_over", 0);
        }
    #/
    wait(1);
    function_f7e328fa();
    visionset_mgr::activate("visionset", "zm_elemental_round_visionset", undefined, 1.5, 1.5, 2);
    playsoundatposition("vox_zmba_event_rapsstart_0", (0, 0, 0));
    wait(6);
    var_e3b7af42 = 0;
    level flag::set("raps_round_in_progress");
    level endon(#"hash_ddc0a71d");
    level thread function_3f53d4c9();
    while (true) {
        while (level.zombie_total > 0) {
            if (isdefined(level.bzm_worldpaused) && level.bzm_worldpaused) {
                util::wait_network_frame();
                continue;
            }
            if (isdefined(level.var_535a2969)) {
                [[ level.var_535a2969 ]]();
            } else {
                function_cce2311d();
            }
            util::wait_network_frame();
        }
        util::wait_network_frame();
    }
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xf0956d72, Offset: 0x1480
// Size: 0x184
function function_cce2311d() {
    while (!function_4a07067b()) {
        wait(0.1);
    }
    s_spawn_loc = undefined;
    var_78436f04 = get_favorite_enemy();
    if (!isdefined(var_78436f04)) {
        wait(randomfloatrange(0.333333, 0.666667));
        return;
    }
    if (isdefined(level.var_51593182)) {
        s_spawn_loc = [[ level.var_51593182 ]](var_78436f04);
    } else {
        s_spawn_loc = function_608b77a3(var_78436f04);
    }
    if (!isdefined(s_spawn_loc)) {
        wait(randomfloatrange(0.333333, 0.666667));
        return;
    }
    ai = zombie_utility::spawn_zombie(level.var_b15f9e1f[0]);
    if (isdefined(ai)) {
        ai.favoriteenemy = var_78436f04;
        ai.favoriteenemy.hunted_by++;
        s_spawn_loc thread function_5a37de3a(ai, s_spawn_loc);
        level.zombie_total--;
        function_725c1111();
    }
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0x8895cace, Offset: 0x1610
// Size: 0x86
function function_66bb4851() {
    switch (level.players.size) {
    case 1:
        var_4fc9044f = 10;
        break;
    case 2:
        var_4fc9044f = 18;
        break;
    case 3:
        var_4fc9044f = 28;
        break;
    case 4:
    default:
        var_4fc9044f = 34;
        break;
    }
    return var_4fc9044f;
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0x15f29129, Offset: 0x16a0
// Size: 0x80
function function_4a047c7d() {
    level endon(#"restart_round");
    level endon(#"kill_round");
    if (level flag::get("raps_round")) {
        level flag::wait_till("raps_round_in_progress");
        level flag::wait_till_clear("raps_round_in_progress");
    }
    level.var_1b7d7bb8 = 0;
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xcef90d98, Offset: 0x1728
// Size: 0xd6
function function_30f083dc() {
    raps = getentarray("zombie_raps", "targetname");
    var_138c4ec = raps.size;
    foreach (var_f7739dbb in raps) {
        if (!isalive(var_f7739dbb)) {
            var_138c4ec--;
        }
    }
    return var_138c4ec;
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0x6de4ac00, Offset: 0x1808
// Size: 0xb2
function function_f7e328fa() {
    foreach (player in level.players) {
        player clientfield::increment_to_player("elemental_round_fx");
        player clientfield::increment_to_player("elemental_round_ring_fx");
    }
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xe8964bb6, Offset: 0x18c8
// Size: 0x88
function show_hit_marker() {
    if (isdefined(self) && isdefined(self.hud_damagefeedback)) {
        self.hud_damagefeedback setshader("damage_feedback", 24, 48);
        self.hud_damagefeedback.alpha = 1;
        self.hud_damagefeedback fadeovertime(1);
        self.hud_damagefeedback.alpha = 0;
    }
}

// Namespace namespace_5ace0f0e
// Params 12, eflags: 0x0
// Checksum 0x33a004f4, Offset: 0x1958
// Size: 0x88
function function_cef064ba(inflictor, attacker, damage, dflags, mod, weapon, point, dir, hitloc, offsettime, boneindex, modelindex) {
    if (isdefined(attacker)) {
        attacker show_hit_marker();
    }
    return damage;
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0x13e4ff16, Offset: 0x19e8
// Size: 0x90
function function_4a07067b() {
    var_e3b7af42 = function_30f083dc();
    var_8dfe7b93 = var_e3b7af42 >= 13;
    var_7297db97 = var_e3b7af42 >= level.players.size * 4;
    if (var_8dfe7b93 || var_7297db97 || !level flag::get("spawn_zombies")) {
        return false;
    }
    return true;
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xb879ff61, Offset: 0x1a80
// Size: 0x88
function function_725c1111() {
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
    wait(n_default_wait);
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0x6cca7e17, Offset: 0x1b10
// Size: 0x134
function function_3f53d4c9() {
    var_100f3800 = level waittill(#"hash_ddc0a71d");
    level thread zm_audio::sndmusicsystem_playstate("meatball_over");
    if (isdefined(level.var_716fc13e)) {
        [[ level.var_716fc13e ]](var_100f3800, level.var_1414f4e7);
    } else {
        var_f1aa36cd = level.var_1414f4e7;
        trace = groundtrace(var_f1aa36cd + (0, 0, 100), var_f1aa36cd + (0, 0, -1000), 0, undefined);
        var_f1aa36cd = trace["position"];
        if (isdefined(var_f1aa36cd)) {
            level thread zm_powerups::specific_powerup_drop("full_ammo", var_f1aa36cd);
        }
    }
    wait(2);
    level.var_1b7d7bb8 = 0;
    wait(6);
    level flag::clear("raps_round_in_progress");
}

// Namespace namespace_5ace0f0e
// Params 2, eflags: 0x0
// Checksum 0xc19c348, Offset: 0x1c50
// Size: 0x68c
function function_5a37de3a(ai, ent) {
    ai endon(#"death");
    if (!isdefined(ent)) {
        ent = self;
    }
    ai vehicle_ai::set_state("scripted");
    trace = bullettrace(ent.origin, ent.origin + (0, 0, -720), 0, ai);
    var_fcde5d10 = trace["position"];
    angle = vectortoangles(ai.favoriteenemy.origin - ent.origin);
    angles = (ai.angles[0], angle[1], ai.angles[2]);
    ai.origin = var_fcde5d10;
    ai.angles = angles;
    ai hide();
    pos = var_fcde5d10 + (0, 0, 720);
    if (!bullettracepassed(ent.origin, pos, 0, ai)) {
        trace = bullettrace(ent.origin, pos, 0, ai);
        pos = trace["position"];
    }
    var_6e6b55ca = spawn("script_model", pos);
    var_6e6b55ca setmodel("tag_origin");
    playfxontag(level._effect["raps_portal"], var_6e6b55ca, "tag_origin");
    var_a5728ff8 = spawn("script_model", var_fcde5d10);
    var_a5728ff8 setmodel("tag_origin");
    playfxontag(level._effect["raps_ground_spawn"], var_a5728ff8, "tag_origin");
    var_a5728ff8 playsound("zmb_meatball_spawn_tell");
    playsoundatposition("zmb_meatball_spawn_rise", pos);
    ai thread function_adfe5353(var_6e6b55ca, var_a5728ff8);
    wait(0.5);
    var_a367560 = spawn("script_model", pos);
    model = ai.model;
    var_a367560 setmodel(model);
    var_a367560.angles = angles;
    var_a367560 playloopsound("zmb_meatball_spawn_loop", 0.25);
    playfxontag(level._effect["raps_meteor_fire"], var_a367560, "tag_origin");
    var_854001e9 = sqrt(distancesquared(pos, var_fcde5d10));
    fall_time = var_854001e9 / 720;
    var_a367560 moveto(var_fcde5d10, fall_time);
    var_a367560.ai = ai;
    var_a367560 thread function_b7e23df6();
    wait(fall_time);
    var_a367560 delete();
    if (isdefined(var_6e6b55ca)) {
        var_6e6b55ca delete();
    }
    if (isdefined(var_a5728ff8)) {
        var_a5728ff8 delete();
    }
    ai vehicle_ai::set_state("combat");
    ai.origin = var_fcde5d10;
    ai.angles = angles;
    ai show();
    playfx(level._effect["raps_impact"], var_fcde5d10);
    playsoundatposition("zmb_meatball_spawn_impact", var_fcde5d10);
    earthquake(0.3, 0.75, var_fcde5d10, 512);
    /#
        assert(isdefined(ai), "<unknown string>");
    #/
    /#
        assert(isalive(ai), "<unknown string>");
    #/
    ai function_4739891b();
    ai setvisibletoall();
    ai.ignoreme = 0;
    ai notify(#"visible");
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xd667e70d, Offset: 0x22e8
// Size: 0x34
function function_b7e23df6() {
    self endon(#"death");
    self.ai waittill(#"death");
    self delete();
}

// Namespace namespace_5ace0f0e
// Params 2, eflags: 0x0
// Checksum 0xbb561483, Offset: 0x2328
// Size: 0x64
function function_adfe5353(portal_fx, var_831b20fe) {
    self waittill(#"death");
    if (isdefined(portal_fx)) {
        portal_fx delete();
    }
    if (isdefined(var_831b20fe)) {
        var_831b20fe delete();
    }
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xb5849964, Offset: 0x2398
// Size: 0x17a
function function_31124f04() {
    if (!isdefined(level.var_64fb0c79)) {
        level.var_64fb0c79 = [];
        keys = getarraykeys(level.zones);
        for (i = 0; i < keys.size; i++) {
            zone = level.zones[keys[i]];
            foreach (loc in zone.a_locs["raps_location"]) {
                if (!isdefined(level.var_64fb0c79)) {
                    level.var_64fb0c79 = [];
                } else if (!isarray(level.var_64fb0c79)) {
                    level.var_64fb0c79 = array(level.var_64fb0c79);
                }
                level.var_64fb0c79[level.var_64fb0c79.size] = loc;
            }
        }
    }
}

// Namespace namespace_5ace0f0e
// Params 1, eflags: 0x0
// Checksum 0xc1acc1be, Offset: 0x2520
// Size: 0x118
function function_8c43583a(var_78436f04) {
    var_3d7bf00d = 0;
    var_494687ca = distancesquared(level.var_64fb0c79[var_3d7bf00d].origin, var_78436f04.origin);
    for (i = 0; i < level.var_64fb0c79.size; i++) {
        if (level.var_64fb0c79[i].is_enabled) {
            dist_squared = distancesquared(level.var_64fb0c79[i].origin, var_78436f04.origin);
            if (dist_squared < var_494687ca) {
                var_3d7bf00d = i;
                var_494687ca = dist_squared;
            }
        }
    }
    return level.var_64fb0c79[var_3d7bf00d];
}

// Namespace namespace_5ace0f0e
// Params 1, eflags: 0x0
// Checksum 0x9afd7a01, Offset: 0x2640
// Size: 0x236
function function_608b77a3(var_78436f04) {
    position = var_78436f04.last_valid_position;
    if (!isdefined(position)) {
        position = var_78436f04.origin;
    }
    if (level.players.size == 1) {
        var_9a071e92 = 450;
        var_1cf2609c = 900;
    } else if (level.players.size == 2) {
        var_9a071e92 = 450;
        var_1cf2609c = 850;
    } else if (level.players.size == 3) {
        var_9a071e92 = 700;
        var_1cf2609c = 1000;
    } else {
        var_9a071e92 = 800;
        var_1cf2609c = 1200;
    }
    var_48f8d555 = positionquery_source_navigation(position, var_9a071e92, var_1cf2609c, -56, 32, 16);
    if (var_48f8d555.data.size) {
        a_s_locs = array::randomize(var_48f8d555.data);
        if (isdefined(a_s_locs)) {
            foreach (s_loc in a_s_locs) {
                if (zm_utility::check_point_in_enabled_zone(s_loc.origin, 1, level.active_zones)) {
                    s_loc.origin += (0, 0, 16);
                    return s_loc;
                }
            }
        }
    }
    return undefined;
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xf0646d4c, Offset: 0x2880
// Size: 0x124
function get_favorite_enemy() {
    var_bb7a82fa = getplayers();
    e_least_hunted = undefined;
    for (i = 0; i < var_bb7a82fa.size; i++) {
        e_target = var_bb7a82fa[i];
        if (!isdefined(e_target.hunted_by)) {
            e_target.hunted_by = 0;
        }
        if (!zm_utility::is_player_valid(e_target)) {
            continue;
        }
        if (isdefined(level.var_979a9287) && ![[ level.var_979a9287 ]](e_target)) {
            continue;
        }
        if (!isdefined(e_least_hunted)) {
            e_least_hunted = e_target;
            continue;
        }
        if (e_target.hunted_by < e_least_hunted.hunted_by) {
            e_least_hunted = e_target;
        }
    }
    return e_least_hunted;
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xc9fc147e, Offset: 0x29b0
// Size: 0x50
function function_2a8df909() {
    players = getplayers();
    level.var_26944d = level.round_number * 50;
    if (level.var_26944d > 1600) {
        level.var_26944d = 1600;
    }
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xddef4989, Offset: 0x2a08
// Size: 0xb4
function function_493a8f7f() {
    self playlocalsound("zmb_raps_round_start");
    variation_count = 5;
    wait(4.5);
    players = getplayers();
    num = randomintrange(0, players.size);
    players[num] zm_audio::create_and_play_dialog("general", "raps_spawn");
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xe0118ea8, Offset: 0x2ac8
// Size: 0x400
function function_50aa1d36() {
    self.inpain = 1;
    thread raps::raps_initialize();
    self.inpain = 0;
    self.targetname = "zombie_raps";
    self.script_noteworthy = undefined;
    self.animname = "zombie_raps";
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
    self.holdfire = 1;
    self.grenadeawareness = 0;
    self.badplaceawareness = 0;
    self.ignoresuppression = 1;
    self.suppressionthreshold = 1;
    self.nododgemove = 1;
    self.dontshootwhilemoving = 1;
    self.pathenemylookahead = 0;
    self.test_failed_path = 1;
    self.badplaceawareness = 0;
    self.chatinitialized = 0;
    self.missinglegs = 0;
    self.isdog = 0;
    self.teslafxtag = "tag_origin";
    self.custom_player_shellshock = &function_aab333e2;
    self.var_f9127ea5 = 2;
    self setgrapplabletype(self.var_f9127ea5);
    self.team = level.zombie_team;
    self.sword_kill_power = 2;
    health_multiplier = 1;
    if (getdvarstring("scr_raps_health_walk_multiplier") != "") {
        health_multiplier = getdvarfloat("scr_raps_health_walk_multiplier");
    }
    self.maxhealth = int(level.var_26944d * health_multiplier);
    if (isdefined(level.var_5a487977[self.archetype]) && level.var_5a487977[self.archetype].size > 0) {
        self.health = level.var_5a487977[self.archetype][0];
        arrayremovevalue(level.var_5a487977[self.archetype], level.var_5a487977[self.archetype][0]);
    } else {
        self.health = int(level.var_26944d * health_multiplier);
    }
    self thread function_4485f406();
    self setinvisibletoall();
    self thread function_aadb7d56();
    self thread function_b6ea838a(90);
    level thread zm_spawner::zombie_death_event(self);
    self thread zm_spawner::function_1612a0b8();
    self zm_spawner::zombie_history("zombie_raps_spawn_init -> Spawned = " + self.origin);
    if (isdefined(level.var_9aca36e2)) {
        self [[ level.var_9aca36e2 ]]();
    }
}

// Namespace namespace_5ace0f0e
// Params 1, eflags: 0x0
// Checksum 0x44e7196, Offset: 0x2ed0
// Size: 0x5c
function function_b6ea838a(timeout) {
    self endon(#"death");
    wait(timeout);
    self dodamage(self.health + 100, self.origin, self, undefined, "none", "MOD_UNKNOWN");
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xc9d28211, Offset: 0x2f38
// Size: 0x1ec
function function_aadb7d56() {
    attacker = self waittill(#"death");
    if (function_30f083dc() == 0 && level.zombie_total == 0) {
        if (!isdefined(level.var_30b36b7b) || [[ level.var_30b36b7b ]]()) {
            level.var_1414f4e7 = self.origin;
            level notify(#"hash_ddc0a71d", self);
        }
    }
    if (isplayer(attacker)) {
        if (!(isdefined(self.deathpoints_already_given) && self.deathpoints_already_given)) {
            attacker zm_score::player_add_points("death_raps", 70);
        }
        if (isdefined(level.hero_power_update)) {
            [[ level.hero_power_update ]](attacker, self);
        }
        if (randomintrange(0, 100) >= 80) {
            attacker zm_audio::create_and_play_dialog("kill", "hellhound");
        }
        attacker zm_stats::increment_client_stat("zraps_killed");
        attacker zm_stats::increment_player_stat("zraps_killed");
    }
    if (isdefined(attacker) && isai(attacker)) {
        attacker notify(#"killed", self);
    }
    if (isdefined(self)) {
        self stoploopsound();
        self thread function_977dfbe0(self.origin);
    }
}

// Namespace namespace_5ace0f0e
// Params 5, eflags: 0x0
// Checksum 0x5d55e2df, Offset: 0x3130
// Size: 0x54
function function_aab333e2(damage, attacker, direction_vec, point, mod) {
    if (mod == "MOD_EXPLOSIVE") {
        self thread function_9a2ced9d();
    }
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xc58aa36, Offset: 0x3190
// Size: 0x8c
function function_9a2ced9d() {
    self endon(#"death");
    if (!isdefined(self.var_55afb930)) {
        self.var_55afb930 = 0;
    }
    self.var_55afb930++;
    if (self.var_55afb930 >= 4) {
        self shellshock("explosion_elementals", 2);
    }
    self util::waittill_any_timeout(20, "death");
    self.var_55afb930--;
}

// Namespace namespace_5ace0f0e
// Params 1, eflags: 0x0
// Checksum 0x5b7c5fae, Offset: 0x3228
// Size: 0x34
function function_977dfbe0(origin) {
    playfx(level._effect["raps_gib"], origin);
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xf20030cd, Offset: 0x3268
// Size: 0x54
function function_4739891b() {
    self zm_spawner::zombie_history("zombie_setup_attack_properties()");
    self.ignoreall = 0;
    self.meleeattackdist = 64;
    self.disablearrivals = 1;
    self.disableexits = 1;
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0xcf7cc83c, Offset: 0x32c8
// Size: 0x24
function function_a44dcf57() {
    self waittill(#"death");
    self stopsounds();
}

// Namespace namespace_5ace0f0e
// Params 3, eflags: 0x0
// Checksum 0xff9f9fe2, Offset: 0x32f8
// Size: 0x22c
function function_ad853d21(n_to_spawn, s_spawn_loc, var_a3a87d80) {
    if (!isdefined(n_to_spawn)) {
        n_to_spawn = 1;
    }
    raps = getentarray("zombie_raps", "targetname");
    if (isdefined(raps) && raps.size >= 9) {
        return false;
    }
    count = 0;
    while (count < n_to_spawn) {
        players = getplayers();
        var_78436f04 = get_favorite_enemy();
        if (!isdefined(var_78436f04)) {
            wait(randomfloatrange(0.666667, 1.33333));
            continue;
        }
        if (isdefined(level.var_51593182)) {
            s_spawn_loc = [[ level.var_51593182 ]](var_78436f04);
        } else {
            s_spawn_loc = function_608b77a3(var_78436f04);
        }
        if (!isdefined(s_spawn_loc)) {
            wait(randomfloatrange(0.666667, 1.33333));
            continue;
        }
        ai = zombie_utility::spawn_zombie(level.var_b15f9e1f[0]);
        if (isdefined(ai)) {
            ai.favoriteenemy = var_78436f04;
            ai.favoriteenemy.hunted_by++;
            s_spawn_loc thread function_5a37de3a(ai, s_spawn_loc);
            count++;
            if (isdefined(var_a3a87d80)) {
                ai thread [[ var_a3a87d80 ]]();
            }
        }
        function_725c1111();
    }
    return true;
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0x3e529835, Offset: 0x3530
// Size: 0x118
function function_4485f406() {
    self endon(#"death");
    self waittill(#"visible");
    if (self.health > level.var_26944d) {
        self.maxhealth = level.var_26944d;
        self.health = level.var_26944d;
    }
    while (true) {
        if (!zm_utility::is_player_valid(self.favoriteenemy) && self.var_ffab6a26 !== 1 || self function_91453ab6(self.favoriteenemy)) {
            potential_target = get_favorite_enemy();
            if (isdefined(potential_target)) {
                self.favoriteenemy = potential_target;
                self.favoriteenemy.hunted_by++;
                self.var_93e05b23 = undefined;
            } else {
                self.var_93e05b23 = 1;
            }
        }
        wait(0.1);
    }
}

// Namespace namespace_5ace0f0e
// Params 1, eflags: 0x0
// Checksum 0xc9244c05, Offset: 0x3650
// Size: 0x5c
function function_91453ab6(player) {
    if (isdefined(level.var_66c4cad4) && self [[ level.var_66c4cad4 ]]()) {
        return false;
    }
    if (isdefined(level.var_979a9287) && ![[ level.var_979a9287 ]](player)) {
        return true;
    }
    return false;
}

// Namespace namespace_5ace0f0e
// Params 0, eflags: 0x0
// Checksum 0x53ac9673, Offset: 0x36b8
// Size: 0x50
function function_49ddd1fa() {
    self endon(#"death");
    while (true) {
        self playsound("zmb_hellhound_vocals_amb");
        wait(randomfloatrange(3, 6));
    }
}

// Namespace namespace_5ace0f0e
// Params 2, eflags: 0x0
// Checksum 0xc9765c0a, Offset: 0x3710
// Size: 0x8c
function function_584704f1(player, gib) {
    self endon(#"death");
    damage = int(self.maxhealth * 0.5);
    self dodamage(damage, player.origin, player, undefined, "none", "MOD_UNKNOWN");
}

