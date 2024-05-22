#using scripts/shared/ai/zombie_utility;
#using scripts/shared/ai/zombie_death;
#using scripts/zm/_zm_zonemgr;
#using scripts/zm/_zm_weap_ball;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_hero_weapon;
#using scripts/zm/_zm_audio;
#using scripts/shared/visionset_mgr_shared;
#using scripts/shared/util_shared;
#using scripts/shared/system_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/hud_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace namespace_766d6099;

// Namespace namespace_766d6099
// Params 0, eflags: 0x2
// Checksum 0xa22642ac, Offset: 0x8f0
// Size: 0x34
function function_2dc19561() {
    system::register("zm_genesis_portals", &__init__, undefined, undefined);
}

// Namespace namespace_766d6099
// Params 0, eflags: 0x1 linked
// Checksum 0x3ef0fd2b, Offset: 0x930
// Size: 0x2f4
function __init__() {
    clientfield::register("toplayer", "player_stargate_fx", 15000, 1, "int");
    clientfield::register("toplayer", "player_light_exploder", 15000, 4, "int");
    clientfield::register("world", "genesis_light_exposure", 15000, 1, "int");
    clientfield::register("world", "power_pad_sheffield", 15000, 1, "int");
    clientfield::register("world", "power_pad_prison", 15000, 1, "int");
    clientfield::register("world", "power_pad_asylum", 15000, 1, "int");
    clientfield::register("world", "power_pad_temple", 15000, 1, "int");
    clientfield::register("toplayer", "hint_verruckt_portal_top", 15000, 1, "int");
    clientfield::register("toplayer", "hint_verruckt_portal_bottom", 15000, 1, "int");
    clientfield::register("toplayer", "hint_temple_portal_top", 15000, 1, "int");
    clientfield::register("toplayer", "hint_temple_portal_bottom", 15000, 1, "int");
    clientfield::register("toplayer", "hint_sheffield_portal_top", 15000, 1, "int");
    clientfield::register("toplayer", "hint_sheffield_portal_bottom", 15000, 1, "int");
    clientfield::register("toplayer", "hint_prison_portal_top", 15000, 1, "int");
    clientfield::register("toplayer", "hint_prison_portal_bottom", 15000, 1, "int");
    callback::on_connect(&function_cfc89ca);
}

// Namespace namespace_766d6099
// Params 0, eflags: 0x1 linked
// Checksum 0xef055a8a, Offset: 0xc30
// Size: 0x1c4
function function_16616103() {
    level flag::init("verruct_portal");
    level thread create_portal("verruckt", "verruct_portal");
    level thread function_e4ff383e("power_on4", "verruct_portal");
    level flag::init("temple_portal");
    level thread create_portal("temple", "temple_portal");
    level thread function_e4ff383e("power_on3", "temple_portal");
    level flag::init("sheffield_portal");
    level thread create_portal("sheffield", "sheffield_portal");
    level thread function_e4ff383e("power_on2", "sheffield_portal");
    level flag::init("prison_portal");
    level thread create_portal("prison", "prison_portal");
    level thread function_e4ff383e("power_on1", "prison_portal");
}

// Namespace namespace_766d6099
// Params 2, eflags: 0x1 linked
// Checksum 0x195f9407, Offset: 0xe00
// Size: 0x44
function function_e4ff383e(var_49e3dd2e, var_d16ec704) {
    level flag::wait_till(var_49e3dd2e);
    level flag::set(var_d16ec704);
}

// Namespace namespace_766d6099
// Params 0, eflags: 0x0
// Checksum 0x155f5f4f, Offset: 0xe50
// Size: 0x9c
function function_ff160813() {
    while (true) {
        if (level flag::get("power_on1") && level flag::get("power_on3") && level flag::get("power_on4")) {
            break;
        }
        wait(1);
    }
    level flag::set("sheffield_portal");
}

// Namespace namespace_766d6099
// Params 2, eflags: 0x1 linked
// Checksum 0xb7fd06aa, Offset: 0xef8
// Size: 0x1f8
function create_portal(str_id, var_776628b2) {
    width = -64;
    height = -128;
    length = -64;
    var_d42f02cf = str_id;
    s_loc = struct::get(var_d42f02cf, "targetname");
    function_4a4784d4(var_d42f02cf, 0);
    if (isdefined(var_776628b2)) {
        level flag::wait_till(var_776628b2);
    }
    level thread portal_activate(var_d42f02cf);
    level thread portal_open(var_d42f02cf);
    var_6bca29ec = "close_portal_" + str_id;
    var_2c5f1c2a = "open_portal_" + str_id;
    while (true) {
        level util::waittill_any("close_all_portals", var_6bca29ec);
        level thread function_7fa2f44(var_d42f02cf);
        level.var_ccae6720 = 1;
        function_4a4784d4(var_d42f02cf, 0);
        level util::waittill_any("open_all_portals", var_2c5f1c2a);
        level thread portal_activate(var_d42f02cf);
        level.var_ccae6720 = 0;
        function_4a4784d4(var_d42f02cf, 1);
    }
}

// Namespace namespace_766d6099
// Params 0, eflags: 0x0
// Checksum 0xddd6991c, Offset: 0x10f8
// Size: 0xcc
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
        level thread portal_activate(self.stub.var_d42f02cf);
        level thread portal_open(self.stub.var_d42f02cf);
        break;
    }
}

// Namespace namespace_766d6099
// Params 1, eflags: 0x1 linked
// Checksum 0xdf02baf4, Offset: 0x11d0
// Size: 0x296
function portal_activate(var_d42f02cf) {
    switch (var_d42f02cf) {
    case 29:
        level clientfield::set("power_pad_prison", 1);
        if (getdvarint("splitscreen_playerCount") < 3) {
            level thread scene::play("prison_power_door", "targetname");
            level thread scene::play("prison_power_door2", "targetname");
        }
        break;
    case 26:
        level clientfield::set("power_pad_sheffield", 1);
        if (getdvarint("splitscreen_playerCount") < 3) {
            level thread scene::play("sheffield_power_door", "targetname");
            level thread scene::play("sheffield_power_door2", "targetname");
        }
        break;
    case 23:
        level clientfield::set("power_pad_temple", 1);
        if (getdvarint("splitscreen_playerCount") < 3) {
            level thread scene::play("temple_power_door", "targetname");
            level thread scene::play("temple_power_door2", "targetname");
        }
        break;
    case 20:
        level clientfield::set("power_pad_asylum", 1);
        if (getdvarint("splitscreen_playerCount") < 3) {
            level thread scene::play("verruckt_power_door", "targetname");
            level thread scene::play("verruckt_power_door2", "targetname");
        }
        break;
    }
}

// Namespace namespace_766d6099
// Params 1, eflags: 0x1 linked
// Checksum 0x8e9b3e1e, Offset: 0x1470
// Size: 0xb6
function function_7fa2f44(var_d42f02cf) {
    switch (var_d42f02cf) {
    case 26:
        exploder::stop_exploder("fxexp_212");
        break;
    case 23:
        exploder::stop_exploder("fxexp_242");
        break;
    case 20:
        exploder::stop_exploder("fxexp_232");
        break;
    case 29:
        exploder::stop_exploder("fxexp_222");
        break;
    }
}

// Namespace namespace_766d6099
// Params 1, eflags: 0x1 linked
// Checksum 0x3092c855, Offset: 0x1530
// Size: 0x422
function portal_open(var_d42f02cf) {
    function_4a4784d4(var_d42f02cf, 1);
    var_de1f2abc = getentarray(var_d42f02cf + "_portal_top", "script_noteworthy");
    var_ebfa395 = getentarrayfromarray(var_de1f2abc, "teleport_trigger", "targetname");
    var_a70f04bd = getentarrayfromarray(var_de1f2abc, "teleport_clip", "targetname");
    var_58afe656 = getentarray(var_d42f02cf + "_portal_bottom", "script_noteworthy");
    var_50fc4fb = getentarrayfromarray(var_58afe656, "teleport_trigger", "targetname");
    var_852a023 = getentarrayfromarray(var_58afe656, "teleport_clip", "targetname");
    var_ebfa395[0].var_dec5db15 = var_50fc4fb[0];
    var_50fc4fb[0].var_dec5db15 = var_ebfa395[0];
    var_1693bd2 = getnodearray(var_d42f02cf + "_portal_node", "script_noteworthy");
    foreach (var_9110bac3 in var_1693bd2) {
        var_e8b9ac31 = distancesquared(var_9110bac3.origin, var_ebfa395[0].origin);
        var_6d6d9e09 = distancesquared(var_9110bac3.origin, var_50fc4fb[0].origin);
        if (var_e8b9ac31 < var_6d6d9e09) {
            var_9110bac3.portal_trig = var_ebfa395[0];
            continue;
        }
        var_9110bac3.portal_trig = var_50fc4fb[0];
    }
    wait(2);
    var_ebfa395[0] thread portal_think();
    foreach (e_clip in var_a70f04bd) {
        e_clip delete();
    }
    var_50fc4fb[0] thread portal_think();
    foreach (e_clip in var_852a023) {
        e_clip delete();
    }
}

// Namespace namespace_766d6099
// Params 2, eflags: 0x1 linked
// Checksum 0x9aa5a641, Offset: 0x1960
// Size: 0xd2
function function_4a4784d4(var_d42f02cf, b_enabled) {
    var_1693bd2 = getnodearray(var_d42f02cf + "_portal_node", "script_noteworthy");
    foreach (var_9110bac3 in var_1693bd2) {
        setenablenode(var_9110bac3, b_enabled);
    }
}

// Namespace namespace_766d6099
// Params 1, eflags: 0x1 linked
// Checksum 0x71421e9, Offset: 0x1a40
// Size: 0x1f0
function portal_think(var_60dd615c) {
    self.var_71abf438 = struct::get_array(self.target, "targetname");
    if (!isdefined(var_60dd615c)) {
        var_60dd615c = 1;
    }
    if (isdefined(self.script_string)) {
        str_zone = self.script_string;
    }
    if (isdefined(self.var_dec5db15) && isdefined(self.var_dec5db15.script_noteworthy)) {
        var_759fb311 = self.var_dec5db15.script_noteworthy;
    }
    while (true) {
        var_5ee55fde = self waittill(#"trigger");
        if (isdefined(level.var_ccae6720) && level.var_ccae6720) {
            continue;
        }
        if (isdefined(var_5ee55fde.b_teleporting) && var_5ee55fde.b_teleporting) {
            continue;
        }
        if (isplayer(var_5ee55fde)) {
            if (var_5ee55fde getstance() != "prone") {
                playfx(level._effect["portal_3p"], var_5ee55fde.origin);
                var_5ee55fde playlocalsound("zmb_teleporter_teleport_2d");
                playsoundatposition("zmb_teleporter_teleport_out", var_5ee55fde.origin);
                var_5ee55fde thread function_d0ff7e09(var_60dd615c, self.var_71abf438, str_zone, self.origin, var_759fb311);
            }
        }
    }
}

// Namespace namespace_766d6099
// Params 5, eflags: 0x1 linked
// Checksum 0x28a715cc, Offset: 0x1c38
// Size: 0x97c
function function_d0ff7e09(show_fx, var_71abf438, str_zone, v_portal, var_759fb311) {
    if (!isdefined(show_fx)) {
        show_fx = 1;
    }
    self endon(#"disconnect");
    self notify(#"hash_6716a6e7");
    self.b_teleporting = 1;
    self.teleport_location = self.origin;
    self.var_71abf438 = var_71abf438;
    if (isdefined(var_759fb311)) {
        self clientfield::set_to_player("hint_" + var_759fb311, 1);
    }
    if (show_fx) {
        self clientfield::set_to_player("player_stargate_fx", 1);
    }
    n_pos = self.characterindex;
    prone_offset = (0, 0, 49);
    crouch_offset = (0, 0, 20);
    var_7cac5f2f = (0, 0, 0);
    a_ai_enemies = getaiteamarray("axis");
    a_ai_enemies = arraysort(a_ai_enemies, v_portal, 1, 99, 768);
    array::thread_all(a_ai_enemies, &function_7807150a);
    level.n_cleanup_manager_restart_time = 4 + 15;
    level.n_cleanup_manager_restart_time += gettime() / 1000;
    var_594457ea = struct::get("teleport_room_" + n_pos, "targetname");
    var_d9543609 = undefined;
    if (self hasweapon(level.ballweapon)) {
        var_d9543609 = self.carryobject;
    }
    if (zm_hero_weapon::function_f3451c9f()) {
        self switchtoweaponimmediate();
        wait(0.05);
    }
    self disableoffhandweapons();
    self disableweapons();
    self freezecontrols(1);
    util::wait_network_frame();
    if (self getstance() == "prone") {
        desired_origin = var_594457ea.origin + prone_offset;
    } else if (self getstance() == "crouch") {
        desired_origin = var_594457ea.origin + crouch_offset;
    } else {
        desired_origin = var_594457ea.origin + var_7cac5f2f;
    }
    self.teleport_origin = util::spawn_model("tag_origin", self.origin, self.angles);
    self playerlinktoabsolute(self.teleport_origin, "tag_origin");
    self.teleport_origin.origin = desired_origin;
    self.teleport_origin.angles = var_594457ea.angles;
    util::wait_network_frame();
    self.teleport_origin.angles = var_594457ea.angles;
    if (isdefined(str_zone)) {
        zm_zonemgr::enable_zone(str_zone);
    }
    if (isdefined(var_759fb311)) {
        switch (var_759fb311) {
        case 67:
        case 69:
        case 71:
        case 73:
            self function_eec1f014("prototype", 10, 1);
            break;
        case 70:
            self function_eec1f014("start", 2, 1);
            break;
        case 68:
            self function_eec1f014("prison", 4, 1);
            break;
        case 74:
            self function_eec1f014("asylum", 6, 1);
            break;
        case 72:
            self function_eec1f014("temple", 8, 1);
            break;
        }
    }
    wait(4);
    if (show_fx) {
        self clientfield::set_to_player("player_stargate_fx", 0);
    }
    a_players = getplayers();
    arrayremovevalue(a_players, self);
    s_pos = array::random(var_71abf438);
    if (a_players.size > 0) {
        var_cefa4b63 = 0;
        while (!var_cefa4b63) {
            var_cefa4b63 = 1;
            s_pos = array::random(var_71abf438);
            foreach (var_3bc10d31 in a_players) {
                var_f2c93934 = distance(var_3bc10d31.origin, s_pos.origin);
                if (var_f2c93934 < 32) {
                    var_cefa4b63 = 0;
                }
            }
            wait(0.05);
        }
    }
    playfx(level._effect["portal_3p"], s_pos.origin);
    self unlink();
    playsoundatposition("zmb_teleporter_teleport_in", s_pos.origin);
    self thread function_bfba39d8();
    self setorigin(s_pos.origin);
    self setplayerangles(s_pos.angles);
    if (isdefined(var_d9543609)) {
        var_d9543609 ball::function_98827162(0);
    }
    self.zone_name = self zm_utility::get_current_zone();
    self.last_valid_position = self.origin;
    if (!ispointonnavmesh(self.origin, self)) {
        position = getclosestpointonnavmesh(self.origin, 100, 15);
        if (isdefined(position)) {
            self.last_valid_position = position;
        }
    }
    level thread function_483df985(s_pos);
    self enableweapons();
    self enableoffhandweapons();
    self freezecontrols(level.intermission);
    if (isdefined(var_759fb311)) {
        self clientfield::set_to_player("hint_" + var_759fb311, 0);
        /#
            streamerskiptodebug("power_pad_prison" + var_759fb311);
        #/
    }
    self.b_teleporting = 0;
    self thread zm_audio::create_and_play_dialog("portal", "travel");
}

// Namespace namespace_766d6099
// Params 0, eflags: 0x1 linked
// Checksum 0xc8a2633, Offset: 0x25c0
// Size: 0x46
function function_bfba39d8() {
    util::wait_network_frame();
    if (isdefined(self.teleport_origin)) {
        self.teleport_origin delete();
        self.teleport_origin = undefined;
    }
}

// Namespace namespace_766d6099
// Params 1, eflags: 0x1 linked
// Checksum 0xd820df84, Offset: 0x2610
// Size: 0x464
function function_483df985(s_pos) {
    a_ai = getaiarray();
    a_aoe_ai = arraysortclosest(a_ai, s_pos.origin, a_ai.size, 0, 260);
    foreach (ai in a_aoe_ai) {
        if (!isdefined(level.var_e7aa252c) || isactor(ai) && ai != level.var_e7aa252c) {
            if (ai.archetype === "zombie") {
                playfx(level._effect["beast_return_aoe_kill"], ai gettagorigin("j_spineupper"));
            } else {
                playfx(level._effect["beast_return_aoe_kill"], ai.origin);
            }
            ai.has_been_damaged_by_player = 0;
            ai.deathpoints_already_given = 1;
            ai.no_powerups = 1;
            if (!(isdefined(ai.exclude_cleanup_adding_to_total) && ai.exclude_cleanup_adding_to_total)) {
                level.zombie_total++;
                level.zombie_respawns++;
                ai.var_4d11bb60 = 1;
                if (isdefined(ai.maxhealth) && ai.health < ai.maxhealth) {
                    if (!isdefined(level.var_5a487977[ai.archetype])) {
                        level.var_5a487977[ai.archetype] = [];
                    }
                    if (!isdefined(level.var_5a487977[ai.archetype])) {
                        level.var_5a487977[ai.archetype] = [];
                    } else if (!isarray(level.var_5a487977[ai.archetype])) {
                        level.var_5a487977[ai.archetype] = array(level.var_5a487977[ai.archetype]);
                    }
                    level.var_5a487977[ai.archetype][level.var_5a487977[ai.archetype].size] = ai.health;
                }
                ai zombie_utility::reset_attack_spot();
            }
            switch (ai.archetype) {
            case 81:
                if (isdefined(ai.var_894f701d) && ai.var_894f701d) {
                    ai.var_9e59b56e = 1;
                }
                break;
            case 82:
                if (!(isdefined(ai.stun) && ai.stun) && ai.var_e12b0a6c < gettime()) {
                    ai.stun = 1;
                }
                break;
            default:
                ai kill();
                break;
            }
        }
    }
}

// Namespace namespace_766d6099
// Params 0, eflags: 0x1 linked
// Checksum 0xb81affa0, Offset: 0x2a80
// Size: 0x72
function function_7807150a() {
    if (!(isdefined(self.b_ignore_cleanup) && self.b_ignore_cleanup)) {
        self notify(#"hash_450c36af");
        self endon(#"death");
        self endon(#"hash_450c36af");
        self.b_ignore_cleanup = 1;
        self.var_b6b1080c = 1;
        wait(10);
        self.b_ignore_cleanup = undefined;
        self.var_b6b1080c = undefined;
    }
}

// Namespace namespace_766d6099
// Params 1, eflags: 0x1 linked
// Checksum 0xaf790690, Offset: 0x2b00
// Size: 0x2c4
function function_eb1242c8(var_5ee55fde) {
    var_5ee55fde endon(#"death");
    var_5ee55fde.b_teleporting = 1;
    var_5ee55fde pathmode("dont move");
    playfx(level._effect["portal_3p"], var_5ee55fde.origin);
    playsoundatposition("zmb_teleporter_teleport_out", var_5ee55fde.origin);
    var_5ee55fde notsolid();
    util::wait_network_frame();
    var_594457ea = struct::get("teleport_room_zombies", "targetname");
    if (isactor(var_5ee55fde)) {
        var_5ee55fde forceteleport(var_594457ea.origin, var_594457ea.angles);
    } else {
        var_5ee55fde.origin = var_594457ea.origin;
        var_5ee55fde.angles = var_594457ea.angles;
    }
    wait(5);
    var_97bf7ab1 = array::random(self.var_71abf438);
    if (isactor(var_5ee55fde)) {
        var_5ee55fde forceteleport(var_97bf7ab1.origin, var_97bf7ab1.angles);
    } else {
        var_5ee55fde.origin = var_97bf7ab1.origin;
        var_5ee55fde.angles = var_97bf7ab1.angles;
    }
    playsoundatposition("zmb_teleporter_teleport_in", var_97bf7ab1.origin);
    playfx(level._effect["portal_3p"], var_97bf7ab1.origin);
    var_5ee55fde solid();
    wait(1);
    var_5ee55fde pathmode("move allowed");
    var_5ee55fde.b_teleporting = 0;
}

// Namespace namespace_766d6099
// Params 0, eflags: 0x1 linked
// Checksum 0xb88e4cf4, Offset: 0x2dd0
// Size: 0x464
function function_cfc89ca() {
    self endon(#"disconnect");
    level endon(#"hash_c9cb5160");
    level flag::wait_till("start_zombie_round_logic");
    self.var_fe12a779 = [];
    self.var_fe12a779["start"] = 0;
    self.var_fe12a779["prison"] = 0;
    self.var_fe12a779["asylum"] = 0;
    self.var_fe12a779["temple"] = 0;
    self.var_fe12a779["prototype"] = 0;
    while (true) {
        if (isdefined(self.var_a3d40b8) && !(isdefined(self.is_flung) && self.is_flung)) {
            switch (self.var_a3d40b8) {
            case 90:
                self function_eec1f014("start", 2, 1);
                self function_eec1f014("prison", 3, 0);
                self function_eec1f014("asylum", 5, 0);
                self function_eec1f014("temple", 7, 0);
                self function_eec1f014("prototype", 9, 0);
                break;
            case 88:
                self function_eec1f014("prison", 4, 1);
                self function_eec1f014("start", 1, 0);
                self function_eec1f014("asylum", 5, 0);
                self function_eec1f014("temple", 7, 0);
                self function_eec1f014("prototype", 9, 0);
                break;
            case 87:
                self function_eec1f014("asylum", 6, 1);
                self function_eec1f014("start", 1, 0);
                self function_eec1f014("prison", 3, 0);
                self function_eec1f014("temple", 7, 0);
                self function_eec1f014("prototype", 9, 0);
                break;
            case 91:
                self function_eec1f014("temple", 8, 1);
                self function_eec1f014("start", 1, 0);
                self function_eec1f014("prison", 3, 0);
                self function_eec1f014("asylum", 5, 0);
                self function_eec1f014("prototype", 9, 0);
                break;
            case 89:
                self function_eec1f014("prototype", 10, 1);
                self function_eec1f014("start", 1, 0);
                self function_eec1f014("prison", 3, 0);
                self function_eec1f014("asylum", 5, 0);
                self function_eec1f014("temple", 7, 0);
                break;
            }
        }
        wait(0.05);
    }
}

// Namespace namespace_766d6099
// Params 3, eflags: 0x1 linked
// Checksum 0xe219447f, Offset: 0x3240
// Size: 0x9e
function function_eec1f014(str_name, n_value, b_toggle) {
    if (self.var_fe12a779[str_name] == b_toggle) {
        self clientfield::set_to_player("player_light_exploder", n_value);
        util::wait_network_frame();
        if (self.var_fe12a779[str_name]) {
            self.var_fe12a779[str_name] = 0;
            return;
        }
        self.var_fe12a779[str_name] = 1;
    }
}

// Namespace namespace_766d6099
// Params 0, eflags: 0x1 linked
// Checksum 0x59da525d, Offset: 0x32e8
// Size: 0x6e
function function_b64d33a7() {
    level waittill(#"start_zombie_round_logic");
    wait(120);
    while (true) {
        level clientfield::set("genesis_light_exposure", 1);
        wait(5);
        level clientfield::set("genesis_light_exposure", 0);
        wait(120);
    }
}

