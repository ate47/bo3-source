#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/spawner_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_castle_cleanup_mgr;
#using scripts/zm/zm_castle_zombie;

#namespace zm_castle_ffotd;

// Namespace zm_castle_ffotd
// Params 0, eflags: 0x0
// Checksum 0x31b116ff, Offset: 0x400
// Size: 0x10
function main_start() {
    level.var_42792b8b = 1;
}

// Namespace zm_castle_ffotd
// Params 0, eflags: 0x0
// Checksum 0xacc763f1, Offset: 0x418
// Size: 0x814
function main_end() {
    spawncollision("collision_monster_wall_256x256x10", "collider", (1519, 1051.5, -46), (0, 5.49973, 0));
    spawncollision("collision_monster_wall_128x128x10", "collider", (1763.25, 1340.5, 307), (0, 335.598, 0));
    spawncollision("collision_monster_wall_128x128x10", "collider", (1685, 1245, 296.75), (0, 305.119, 0));
    spawncollision("collision_monster_wall_128x128x10", "collider", (1574.5, 1193.75, 270.25), (0, 283.009, 0));
    spawncollision("collision_monster_wall_128x128x10", "collider", (1555, 871.75, 191.75), (0, 21.1991, 0));
    spawncollision("collision_clip_32x32x128", "collider", (-710.68, 2255.49, 401.158), (32.1356, 340.445, 17.6571));
    spawncollision("collision_clip_32x32x128", "collider", (-710.816, 2257.55, 401.282), (31.048, 25.5567, -10.7585));
    spawncollision("collision_clip_wall_256x256x10", "collider", (1180, 2991, 633), (0, 0, 0));
    spawncollision("collision_clip_wall_256x256x10", "collider", (-350.335, 2012.8, 834), (270, 0.2, 33.5993));
    spawncollision("collision_clip_wall_256x256x10", "collider", (-392.558, 1842.61, 834), (270, 359.8, 27.3984));
    spawncollision("collision_clip_32x32x128", "collider", (-472, 1950, 823), (270, 284.042, -14.0418));
    spawncollision("collision_clip_64x64x256", "collider", (-192.968, 1677.31, 968), (0, 334.399, 0));
    spawncollision("collision_clip_wedge_32x128", "collider", (-1630.27, 2540.83, 330.354), (295, 342.199, -89.999));
    spawncollision("collision_clip_wall_256x256x10", "collider", (724, 2835, 332), (0, 270, 0));
    spawncollision("collision_clip_64x64x256", "collider", (1144, 1869, 803), (0, 45, 0));
    spawncollision("collision_clip_ramp_256x24", "collider", (-852, 1808, -19), (0, -76, 90));
    spawncollision("collision_clip_ramp_256x24", "collider", (48.4593, 784.8, 280.078), (89.999, 252.348, -72.6515));
    spawncollision("collision_clip_ramp_256x24", "collider", (-954.754, 2905.79, 792), (270, 0.2, 8.59951));
    spawncollision("collision_clip_ramp_256x24", "collider", (-759.689, 2907.04, 792), (89.9997, 357.416, 1.61555));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-589.48, 2435.78, 399.528), (3.79981, 210.2, 0));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-550, 2414.02, 399.528), (3.79986, 270, -6.15847e-07));
    spawncollision("collision_clip_wall_128x128x10", "collider", (-513.245, 2434.79, 399.528), (3.79981, 327.799, -1.35792e-06));
    zm::spawn_kill_brush((864, 2664, 408), 72, -128);
    zm::spawn_kill_brush((960, 2680, 408), 72, -128);
    zm::spawn_kill_brush((1080, 2672, 408), 72, -128);
    zm::spawn_kill_brush((1328, 928, 64), 92, 43);
    zm::spawn_kill_brush((-616, 2160, 616), 75, -128);
    zm::spawn_kill_brush((-544, 2160, 616), 75, -128);
    spawncollision("collision_clip_ramp_256x24", "collider", (456, 3459, 816), (0, 0, -90));
    spawncollision("collision_clip_wall_128x128x10", "collider", (456, 3442, 844), (0, 270, 0));
    zm::spawn_kill_brush((1200, 928, 64), 92, 43);
    level thread function_965d5385();
    level thread function_78328cd0();
    level.no_target_override = &function_c428951;
    level.player_score_override = &function_d6da0785;
    level.player_intersection_tracker_override = &function_401305fb;
}

// Namespace zm_castle_ffotd
// Params 0, eflags: 0x0
// Checksum 0x9b2077ee, Offset: 0xc38
// Size: 0x236
function function_965d5385() {
    a_s_spawn_pos = struct::get_array("zone_tram_to_gatehouse_spawners", "targetname");
    for (i = 0; i < a_s_spawn_pos.size; i++) {
        if (a_s_spawn_pos[i].origin == (1550.5, 1291.7, 243.239)) {
            a_s_spawn_pos[i].angles = (0, 180, 0);
        }
    }
    var_5381c01a = struct::get_array("player_respawn_point", "targetname");
    foreach (s_respawn in var_5381c01a) {
        if (s_respawn.script_noteworthy === "zone_gatehouse") {
            var_e50cc92f = struct::get_array(s_respawn.target, "targetname");
            foreach (s_player_respawn in var_e50cc92f) {
                function_b1c9999(s_player_respawn);
            }
            s_respawn.origin = (1504, 1536, 480);
        }
    }
}

// Namespace zm_castle_ffotd
// Params 1, eflags: 0x0
// Checksum 0xe7ef05f5, Offset: 0xe78
// Size: 0xe6
function function_b1c9999(s_player_respawn) {
    switch (s_player_respawn.script_noteworthy) {
    case "player_1":
        s_player_respawn.origin = (1472, 1568, 470.609);
        break;
    case "player_2":
        s_player_respawn.origin = (1536, 1568, 470.609);
        break;
    case "player_3":
        s_player_respawn.origin = (1472, 1504, 465.043);
        break;
    case "player_4":
        s_player_respawn.origin = (1536, 1504, 465.043);
        break;
    default:
        break;
    }
}

// Namespace zm_castle_ffotd
// Params 0, eflags: 0x0
// Checksum 0xfc1a3f67, Offset: 0xf68
// Size: 0x74
function function_78328cd0() {
    var_7f68d264 = (5426, -2802, -2253);
    level thread function_f9f5dbb3(var_7f68d264);
    var_f170419f = (5521, -2364, -2253);
    level thread function_f9f5dbb3(var_f170419f);
}

// Namespace zm_castle_ffotd
// Params 1, eflags: 0x0
// Checksum 0xc9825762, Offset: 0xfe8
// Size: 0x144
function function_f9f5dbb3(v_origin) {
    var_640a9eac = spawn("trigger_box", v_origin, 9, 100, -128, -128);
    var_640a9eac.angles = (0, 75.7984, 0);
    var_640a9eac setteamfortrigger(level.zombie_team);
    while (true) {
        var_640a9eac waittill(#"trigger", e_who);
        e_who.no_powerups = 1;
        while (isalive(e_who) && e_who istouching(var_640a9eac)) {
            wait 1;
        }
        if (isalive(e_who) && !level flag::get("rocket_firing")) {
            e_who.no_powerups = 0;
        }
    }
}

// Namespace zm_castle_ffotd
// Params 1, eflags: 0x0
// Checksum 0x6733f32f, Offset: 0x1138
// Size: 0x64
function function_c428951(ai_zombie) {
    if (isdefined(self.var_c74f5ce8) && self.var_c74f5ce8) {
        return;
    }
    var_b52b26b9 = ai_zombie get_escape_position();
    ai_zombie thread function_dc683d01(var_b52b26b9);
}

// Namespace zm_castle_ffotd
// Params 0, eflags: 0x4
// Checksum 0x89805c5f, Offset: 0x11a8
// Size: 0x146
function private get_escape_position() {
    str_zone = zm_zonemgr::get_zone_from_position(self.origin + (0, 0, 32), 1);
    if (!isdefined(str_zone)) {
        str_zone = self.zone_name;
    }
    if (isdefined(str_zone)) {
        a_zones = castle_cleanup::get_adjacencies_to_zone(str_zone);
        a_wait_locations = get_wait_locations_in_zones(a_zones);
        arraysortclosest(a_wait_locations, self.origin);
        a_wait_locations = array::reverse(a_wait_locations);
        for (i = 0; i < a_wait_locations.size; i++) {
            if (a_wait_locations[i] function_eadbcbdb()) {
                return a_wait_locations[i].origin;
            }
        }
    }
    return self.origin;
}

// Namespace zm_castle_ffotd
// Params 1, eflags: 0x4
// Checksum 0xa78befff, Offset: 0x12f8
// Size: 0xd2
function private get_wait_locations_in_zones(a_zones) {
    a_wait_locations = [];
    foreach (zone in a_zones) {
        a_wait_locations = arraycombine(a_wait_locations, level.zones[zone].a_loc_types["wait_location"], 0, 0);
    }
    return a_wait_locations;
}

// Namespace zm_castle_ffotd
// Params 0, eflags: 0x4
// Checksum 0x918d5c91, Offset: 0x13d8
// Size: 0x5e
function private function_eadbcbdb() {
    if (!isdefined(self)) {
        return 0;
    }
    if (!ispointonnavmesh(self.origin) || !zm_utility::check_point_in_playable_area(self.origin)) {
        return 0;
    }
    return 1;
}

// Namespace zm_castle_ffotd
// Params 1, eflags: 0x4
// Checksum 0x95c923e8, Offset: 0x1440
// Size: 0xca
function private function_dc683d01(var_b52b26b9) {
    self endon(#"death");
    self notify(#"stop_find_flesh");
    self notify(#"zombie_acquire_enemy");
    self.ignoreall = 1;
    self.var_c74f5ce8 = 1;
    self thread function_30b905e5();
    self setgoal(var_b52b26b9);
    self util::waittill_any_timeout(30, "goal", "reaquire_player", "death");
    self.ai_state = "find_flesh";
    self.ignoreall = 0;
    self.var_c74f5ce8 = undefined;
}

// Namespace zm_castle_ffotd
// Params 0, eflags: 0x4
// Checksum 0xddd3520a, Offset: 0x1518
// Size: 0x78
function private function_30b905e5() {
    self endon(#"death");
    while (isdefined(self.var_c74f5ce8) && self.var_c74f5ce8) {
        wait randomfloatrange(0.2, 0.5);
        if (self function_9de8a8db()) {
            self.var_c74f5ce8 = undefined;
            self notify(#"reaquire_player");
            return;
        }
    }
}

// Namespace zm_castle_ffotd
// Params 0, eflags: 0x4
// Checksum 0x90e2e4cd, Offset: 0x1598
// Size: 0x80
function private function_9de8a8db() {
    for (i = 0; i < level.activeplayers.size; i++) {
        if (zombie_utility::is_player_valid(level.activeplayers[i])) {
            if (self zm_castle_zombie::function_7b63bf24(level.activeplayers[i])) {
                return true;
            }
        }
        wait 0.1;
    }
    return false;
}

// Namespace zm_castle_ffotd
// Params 2, eflags: 0x0
// Checksum 0x6cbcc355, Offset: 0x1620
// Size: 0x5c
function function_d6da0785(var_2f7fd5db, n_points) {
    if (!isdefined(n_points)) {
        return 0;
    }
    if (var_2f7fd5db === getweapon("hero_gravityspikes_melee") && n_points > 20) {
        n_points = 20;
    }
    return n_points;
}

// Namespace zm_castle_ffotd
// Params 1, eflags: 0x0
// Checksum 0x2e76bbf5, Offset: 0x1688
// Size: 0x4e
function function_401305fb(var_3c6a24bf) {
    if (isdefined(var_3c6a24bf.is_flung) && (isdefined(self.is_flung) && self.is_flung || var_3c6a24bf.is_flung)) {
        return true;
    }
    return false;
}

