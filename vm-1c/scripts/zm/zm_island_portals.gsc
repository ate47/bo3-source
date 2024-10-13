#using scripts/shared/ai/zombie_death;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_audio;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#using_animtree("generic");

#namespace zm_island_portals;

// Namespace zm_island_portals
// Params 0, eflags: 0x2
// Checksum 0xacdf62f, Offset: 0x508
// Size: 0x34
function autoexec function_2dc19561() {
    system::register("zm_genesis_portals", &__init__, undefined, undefined);
}

// Namespace zm_island_portals
// Params 0, eflags: 0x1 linked
// Checksum 0x28888a75, Offset: 0x548
// Size: 0x1bc
function __init__() {
    n_bits = getminbitcountfornum(3);
    clientfield::register("toplayer", "player_stargate_fx", 9000, 1, "int");
    clientfield::register("world", "portal_state_ending_0", 9000, 1, "int");
    clientfield::register("world", "portal_state_ending_1", 9000, 1, "int");
    clientfield::register("world", "portal_state_ending_2", 9000, 1, "int");
    clientfield::register("world", "portal_state_ending_3", 9000, 1, "int");
    clientfield::register("world", "pulse_ee_boat_portal_top", 9000, 1, "counter");
    clientfield::register("world", "pulse_ee_boat_portal_bottom", 9000, 1, "counter");
    visionset_mgr::register_info("overlay", "zm_zod_transported", 9000, 20, 15, 1, &visionset_mgr::duration_lerp_thread_per_player, 0);
}

// Namespace zm_island_portals
// Params 0, eflags: 0x1 linked
// Checksum 0x99ec1590, Offset: 0x710
// Size: 0x4
function function_16616103() {
    
}

// Namespace zm_island_portals
// Params 2, eflags: 0x0
// Checksum 0xaf8b6022, Offset: 0x720
// Size: 0x44
function function_e4ff383e(var_49e3dd2e, var_d16ec704) {
    level flag::wait_till(var_49e3dd2e);
    level flag::set(var_d16ec704);
}

// Namespace zm_island_portals
// Params 3, eflags: 0x0
// Checksum 0xf618d29d, Offset: 0x770
// Size: 0x334
function create_portal(str_id, var_fc699b20, var_776628b2) {
    width = -64;
    height = -128;
    length = -64;
    var_d42f02cf = str_id;
    s_loc = struct::get(var_d42f02cf, "targetname");
    var_1693bd2 = getnodearray(var_d42f02cf + "_portal_node", "script_noteworthy");
    foreach (var_9110bac3 in var_1693bd2) {
        setenablenode(var_9110bac3, 0);
    }
    if (isdefined(var_fc699b20) && var_fc699b20) {
        s_loc.unitrigger_stub = spawnstruct();
        s_loc.unitrigger_stub.origin = s_loc.origin;
        s_loc.unitrigger_stub.angles = s_loc.angles;
        s_loc.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
        s_loc.unitrigger_stub.cursor_hint = "HINT_NOICON";
        s_loc.unitrigger_stub.script_width = width;
        s_loc.unitrigger_stub.script_height = height;
        s_loc.unitrigger_stub.script_length = length;
        s_loc.unitrigger_stub.require_look_at = 0;
        s_loc.unitrigger_stub.var_d42f02cf = var_d42f02cf;
        s_loc.unitrigger_stub.prompt_and_visibility_func = &function_16fca6d;
        zm_unitrigger::register_static_unitrigger(s_loc.unitrigger_stub, &function_a90ab0d7);
        return;
    }
    if (isdefined(var_776628b2)) {
        level flag::wait_till(var_776628b2);
        level thread function_e0c93f92(var_d42f02cf);
        return;
    }
    level thread function_e0c93f92(var_d42f02cf);
}

// Namespace zm_island_portals
// Params 1, eflags: 0x1 linked
// Checksum 0xfc02fca, Offset: 0xab0
// Size: 0xea
function function_16fca6d(player) {
    var_d42f02cf = self.stub.var_d42f02cf;
    var_8f5050e8 = level clientfield::get("portal_state_" + var_d42f02cf);
    if (var_8f5050e8 !== 1 && !(isdefined(player.beastmode) && player.beastmode)) {
        self sethintstring(%ZM_GENESIS_PORTAL_OPEN);
        b_is_invis = 0;
    } else {
        b_is_invis = 1;
    }
    self setinvisibletoplayer(player, b_is_invis);
    return !b_is_invis;
}

// Namespace zm_island_portals
// Params 0, eflags: 0x1 linked
// Checksum 0x6cbb6e6e, Offset: 0xba8
// Size: 0xa4
function function_a90ab0d7() {
    while (true) {
        player = self waittill(#"trigger");
        if (player zm_utility::in_revive_trigger()) {
            continue;
        }
        if (player.is_drinking > 0) {
            continue;
        }
        if (!zm_utility::is_player_valid(player)) {
            continue;
        }
        level thread function_e0c93f92(self.stub.var_d42f02cf);
        break;
    }
}

// Namespace zm_island_portals
// Params 1, eflags: 0x1 linked
// Checksum 0xdc85590a, Offset: 0xc58
// Size: 0x4c
function function_e0c93f92(var_d42f02cf) {
    level clientfield::set("portal_state_" + var_d42f02cf, 1);
    portal_open(var_d42f02cf);
}

// Namespace zm_island_portals
// Params 2, eflags: 0x1 linked
// Checksum 0x3df17376, Offset: 0xcb0
// Size: 0x36c
function portal_open(var_d42f02cf, var_14429fc9) {
    if (!isdefined(var_14429fc9)) {
        var_14429fc9 = 0;
    }
    if (var_14429fc9) {
        level clientfield::set("portal_state_" + var_d42f02cf, 2);
    }
    var_1693bd2 = getnodearray(var_d42f02cf + "_portal_node", "script_noteworthy");
    foreach (var_9110bac3 in var_1693bd2) {
        setenablenode(var_9110bac3, 1);
    }
    var_de1f2abc = getentarray(var_d42f02cf + "_portal_top", "script_noteworthy");
    var_ebfa395 = getentarrayfromarray(var_de1f2abc, "teleport_trigger", "targetname");
    var_58afe656 = getentarray(var_d42f02cf + "_portal_bottom", "script_noteworthy");
    var_50fc4fb = getentarrayfromarray(var_58afe656, "teleport_trigger", "targetname");
    var_ebfa395[0].var_dec5db15 = var_50fc4fb[0];
    var_50fc4fb[0].var_dec5db15 = var_ebfa395[0];
    foreach (var_9110bac3 in var_1693bd2) {
        var_e8b9ac31 = distancesquared(var_9110bac3.origin, var_ebfa395[0].origin);
        var_6d6d9e09 = distancesquared(var_9110bac3.origin, var_50fc4fb[0].origin);
        if (var_e8b9ac31 < var_6d6d9e09) {
            var_9110bac3.portal_trig = var_ebfa395[0];
            continue;
        }
        var_9110bac3.portal_trig = var_50fc4fb[0];
    }
    wait 2.5;
    var_ebfa395[0] thread portal_think();
    var_50fc4fb[0] thread portal_think();
}

// Namespace zm_island_portals
// Params 0, eflags: 0x1 linked
// Checksum 0x42817d02, Offset: 0x1028
// Size: 0x184
function portal_think() {
    if (!isdefined(self.target)) {
        return;
    }
    self.var_71abf438 = struct::get_array(self.target, "targetname");
    while (true) {
        var_5ee55fde = self waittill(#"trigger");
        level clientfield::increment("pulse_" + self.script_noteworthy);
        if (isdefined(var_5ee55fde.teleporting) && var_5ee55fde.teleporting) {
            continue;
        }
        if (isplayer(var_5ee55fde)) {
            if (var_5ee55fde getstance() != "prone") {
                playfx(level._effect["portal_3p"], var_5ee55fde.origin);
                var_5ee55fde playlocalsound("zmb_teleporter_teleport_2d");
                playsoundatposition("zmb_teleporter_teleport_out", var_5ee55fde.origin);
                self thread function_d0ff7e09(var_5ee55fde);
            }
        }
    }
}

// Namespace zm_island_portals
// Params 2, eflags: 0x1 linked
// Checksum 0x8d197902, Offset: 0x11b8
// Size: 0x8cc
function function_d0ff7e09(player, show_fx) {
    if (!isdefined(show_fx)) {
        show_fx = 1;
    }
    player endon(#"disconnect");
    level.var_6fe80781 = gettime();
    player.teleporting = 1;
    player.teleport_location = player.origin;
    if (show_fx) {
        player clientfield::set_to_player("player_stargate_fx", 1);
    }
    n_pos = player.characterindex;
    prone_offset = (0, 0, 49);
    crouch_offset = (0, 0, 20);
    var_7cac5f2f = (0, 0, 0);
    a_ai_enemies = getaiteamarray("axis");
    a_ai_enemies = arraysort(a_ai_enemies, self.origin, 1, 99, 768);
    array::thread_all(a_ai_enemies, &function_7807150a);
    level.n_cleanup_manager_restart_time = 2 + 15;
    level.n_cleanup_manager_restart_time += gettime() / 1000;
    var_594457ea = struct::get("teleport_room_" + n_pos, "targetname");
    player disableoffhandweapons();
    player disableweapons();
    player freezecontrols(1);
    util::wait_network_frame();
    if (player getstance() == "prone") {
        desired_origin = var_594457ea.origin + prone_offset;
    } else if (player getstance() == "crouch") {
        desired_origin = var_594457ea.origin + crouch_offset;
    } else {
        desired_origin = var_594457ea.origin + var_7cac5f2f;
    }
    player.teleport_origin = spawn("script_model", player.origin);
    player.teleport_origin setmodel("tag_origin");
    player.teleport_origin.angles = player.angles;
    player playerlinktoabsolute(player.teleport_origin, "tag_origin");
    player.teleport_origin.origin = desired_origin;
    player.teleport_origin.angles = var_594457ea.angles;
    util::wait_network_frame();
    player.teleport_origin.angles = var_594457ea.angles;
    if (isdefined(self.script_string)) {
        zm_zonemgr::enable_zone(self.script_string);
    }
    wait 2;
    if (show_fx) {
        player clientfield::set_to_player("player_stargate_fx", 0);
    }
    a_players = getplayers();
    arrayremovevalue(a_players, player);
    s_pos = array::random(self.var_71abf438);
    if (a_players.size > 0) {
        var_cefa4b63 = 0;
        while (!var_cefa4b63) {
            var_cefa4b63 = 1;
            s_pos = array::random(self.var_71abf438);
            foreach (var_3bc10d31 in a_players) {
                var_f2c93934 = distance(var_3bc10d31.origin, s_pos.origin);
                if (var_f2c93934 < 32) {
                    var_cefa4b63 = 0;
                }
            }
            wait 0.05;
        }
    }
    playfx(level._effect["portal_3p"], s_pos.origin);
    player unlink();
    playsoundatposition("zmb_teleporter_teleport_in", s_pos.origin);
    if (isdefined(player.teleport_origin)) {
        player.teleport_origin delete();
        player.teleport_origin = undefined;
    }
    player setorigin(s_pos.origin);
    player setplayerangles(s_pos.angles);
    level clientfield::increment("pulse_" + self.var_dec5db15.script_noteworthy);
    a_ai = getaiarray();
    a_aoe_ai = arraysortclosest(a_ai, s_pos.origin, a_ai.size, 0, -56);
    foreach (ai in a_aoe_ai) {
        if (isactor(ai)) {
            ai.marked_for_recycle = 1;
            ai.has_been_damaged_by_player = 0;
            ai.deathpoints_already_given = 1;
            ai.no_powerups = 1;
            ai dodamage(ai.health + 1000, s_pos.origin, player);
        }
    }
    player enableweapons();
    player enableoffhandweapons();
    player freezecontrols(level.intermission);
    player.teleporting = 0;
    player thread zm_audio::create_and_play_dialog("portal", "travel");
}

// Namespace zm_island_portals
// Params 0, eflags: 0x1 linked
// Checksum 0xae037f09, Offset: 0x1a90
// Size: 0x5e
function function_7807150a() {
    if (!(isdefined(self.b_ignore_cleanup) && self.b_ignore_cleanup)) {
        self notify(#"hash_450c36af");
        self endon(#"death");
        self endon(#"hash_450c36af");
        self.b_ignore_cleanup = 1;
        wait 10;
        self.b_ignore_cleanup = undefined;
    }
}

// Namespace zm_island_portals
// Params 1, eflags: 0x0
// Checksum 0x514f9da6, Offset: 0x1af8
// Size: 0x2c4
function function_eb1242c8(var_5ee55fde) {
    var_5ee55fde endon(#"death");
    var_5ee55fde.teleporting = 1;
    var_5ee55fde pathmode("dont move");
    playfx(level._effect["portal_3p"], var_5ee55fde.origin);
    playsoundatposition("zmb_teleporter_teleport_out", var_5ee55fde.origin);
    util::wait_network_frame();
    var_594457ea = struct::get("teleport_room_zombies", "targetname");
    if (isactor(var_5ee55fde)) {
        var_5ee55fde forceteleport(var_594457ea.origin, var_594457ea.angles);
    } else {
        var_5ee55fde.origin = var_594457ea.origin;
        var_5ee55fde.angles = var_594457ea.angles;
    }
    wait 2;
    var_97bf7ab1 = array::random(self.var_71abf438);
    if (isactor(var_5ee55fde)) {
        var_5ee55fde forceteleport(var_97bf7ab1.origin, var_97bf7ab1.angles);
    } else {
        var_5ee55fde.origin = var_97bf7ab1.origin;
        var_5ee55fde.angles = var_97bf7ab1.angles;
    }
    level clientfield::increment("pulse_" + self.var_dec5db15.script_noteworthy);
    playsoundatposition("zmb_teleporter_teleport_in", var_97bf7ab1.origin);
    playfx(level._effect["portal_3p"], var_97bf7ab1.origin);
    wait 1;
    var_5ee55fde pathmode("move allowed");
    var_5ee55fde.teleporting = 0;
}

