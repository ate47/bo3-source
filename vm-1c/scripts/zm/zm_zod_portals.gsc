#using scripts/codescripts/struct;
#using scripts/shared/ai/zombie_death;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/shared/visionset_mgr_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/zm_zod_quest;

#using_animtree("generic");

#namespace zm_zod_portals;

// Namespace zm_zod_portals
// Params 0, eflags: 0x2
// Checksum 0xb683972a, Offset: 0x600
// Size: 0x34
function autoexec __init__sytem__() {
    system::register("zm_zod_portals", &__init__, undefined, undefined);
}

// Namespace zm_zod_portals
// Params 0, eflags: 0x0
// Checksum 0x54a6fbbe, Offset: 0x640
// Size: 0x294
function __init__() {
    level._effect["portal_3p"] = "zombie/fx_quest_portal_trail_zod_zmb";
    n_bits = getminbitcountfornum(3);
    clientfield::register("toplayer", "player_stargate_fx", 1, 1, "int");
    clientfield::register("world", "portal_state_canal", 1, n_bits, "int");
    clientfield::register("world", "portal_state_slums", 1, n_bits, "int");
    clientfield::register("world", "portal_state_theater", 1, n_bits, "int");
    clientfield::register("world", "portal_state_ending", 1, 1, "int");
    clientfield::register("world", "pulse_canal_portal_top", 1, 1, "counter");
    clientfield::register("world", "pulse_canal_portal_bottom", 1, 1, "counter");
    clientfield::register("world", "pulse_slums_portal_top", 1, 1, "counter");
    clientfield::register("world", "pulse_slums_portal_bottom", 1, 1, "counter");
    clientfield::register("world", "pulse_theater_portal_top", 1, 1, "counter");
    clientfield::register("world", "pulse_theater_portal_bottom", 1, 1, "counter");
    visionset_mgr::register_info("overlay", "zm_zod_transported", 1, 20, 15, 1, &visionset_mgr::duration_lerp_thread_per_player, 0);
}

// Namespace zm_zod_portals
// Params 1, eflags: 0x0
// Checksum 0x3b736b57, Offset: 0x8e0
// Size: 0x2bc
function function_54ec766b(str_id) {
    width = -64;
    height = -128;
    length = -64;
    var_d42f02cf = function_7679b497(str_id);
    s_loc = function_42ed55f2(var_d42f02cf);
    var_1693bd2 = getnodearray(var_d42f02cf + "_portal_node", "script_noteworthy");
    foreach (var_9110bac3 in var_1693bd2) {
        setenablenode(var_9110bac3, 0);
    }
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
}

// Namespace zm_zod_portals
// Params 1, eflags: 0x0
// Checksum 0xe6446812, Offset: 0xba8
// Size: 0xf2
function function_16fca6d(player) {
    level endon(#"ritual_pap_complete");
    var_d42f02cf = self.stub.var_d42f02cf;
    var_8f5050e8 = level clientfield::get("portal_state_" + var_d42f02cf);
    if (var_8f5050e8 !== 1 && !(isdefined(player.beastmode) && player.beastmode)) {
        self sethintstring(%ZM_ZOD_PORTAL_OPEN);
        b_is_invis = 0;
    } else {
        b_is_invis = 1;
    }
    self setinvisibletoplayer(player, b_is_invis);
    return !b_is_invis;
}

// Namespace zm_zod_portals
// Params 0, eflags: 0x0
// Checksum 0x909f3271, Offset: 0xca8
// Size: 0xac
function function_a90ab0d7() {
    level endon(#"ritual_pap_complete");
    while (true) {
        self waittill(#"trigger", player);
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

// Namespace zm_zod_portals
// Params 1, eflags: 0x0
// Checksum 0xac2689b9, Offset: 0xd60
// Size: 0xe6
function function_42ed55f2(var_d42f02cf) {
    var_3842f06d = struct::get_array("teleport_effect_origin", "targetname");
    var_216e113e = undefined;
    foreach (s_portal_loc in var_3842f06d) {
        if (s_portal_loc.script_noteworthy === var_d42f02cf + "_portal_top") {
            var_216e113e = s_portal_loc;
        }
    }
    return var_216e113e;
}

// Namespace zm_zod_portals
// Params 1, eflags: 0x0
// Checksum 0x69b35316, Offset: 0xe50
// Size: 0x4c
function function_e0c93f92(var_d42f02cf) {
    level clientfield::set("portal_state_" + var_d42f02cf, 1);
    portal_open(var_d42f02cf);
}

// Namespace zm_zod_portals
// Params 2, eflags: 0x0
// Checksum 0x36c40ff2, Offset: 0xea8
// Size: 0x38c
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
    level flag::set("activate_underground");
}

// Namespace zm_zod_portals
// Params 1, eflags: 0x0
// Checksum 0x8ea2c018, Offset: 0x1240
// Size: 0xd2
function function_7679b497(str_input) {
    var_ab765abb = array("canal", "slums", "theater");
    foreach (str_name in var_ab765abb) {
        if (issubstr(str_input, str_name)) {
            return str_name;
        }
    }
}

// Namespace zm_zod_portals
// Params 0, eflags: 0x0
// Checksum 0x355a376, Offset: 0x1320
// Size: 0x174
function portal_think() {
    self.var_71abf438 = struct::get_array(self.target, "targetname");
    while (true) {
        self waittill(#"trigger", var_5ee55fde);
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

// Namespace zm_zod_portals
// Params 2, eflags: 0x0
// Checksum 0x733f4314, Offset: 0x14a0
// Size: 0x924
function function_d0ff7e09(player, show_fx) {
    if (!isdefined(show_fx)) {
        show_fx = 1;
    }
    player endon(#"disconnect");
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
                f_dist = distance(var_3bc10d31.origin, s_pos.origin);
                if (f_dist < 32) {
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
            if (ai.archetype === "zombie") {
                playfx(level._effect["beast_return_aoe_kill"], ai gettagorigin("j_spineupper"));
            } else {
                playfx(level._effect["beast_return_aoe_kill"], ai.origin);
            }
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

// Namespace zm_zod_portals
// Params 0, eflags: 0x0
// Checksum 0x7ffaffff, Offset: 0x1dd0
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

// Namespace zm_zod_portals
// Params 1, eflags: 0x0
// Checksum 0xeff1321, Offset: 0x1e38
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

