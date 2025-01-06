#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_spawner;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weapons;
#using scripts/zm/craftables/_zm_craftables;
#using scripts/zm/zm_island;
#using scripts/zm/zm_island_main_ee_quest;
#using scripts/zm/zm_island_pap_quest;

#namespace zm_island_craftables;

// Namespace zm_island_craftables
// Params 0, eflags: 0x0
// Checksum 0x8c92131d, Offset: 0x538
// Size: 0x35c
function function_3ebec56b() {
    level.var_29ae0891 = 0;
    var_2a7833c8 = getnumexpectedplayers() == 1;
    var_9967ff1 = "gasmask";
    var_a2709918 = zm_craftables::function_5cf75ff1(var_9967ff1, "part_visor", 32, 64, 0, undefined, &function_aef4c63, undefined, &function_3e3b2e02, undefined, undefined, undefined, "gasmask" + "_" + "part_visor", 1, undefined, undefined, %ZOMBIE_BUILD_PIECE_GRAB, 0);
    var_f113dd3d = zm_craftables::function_5cf75ff1(var_9967ff1, "part_filter", 32, 64, 0, undefined, &function_aef4c63, undefined, &function_3e3b2e02, undefined, undefined, undefined, "gasmask" + "_" + "part_filter", 1, undefined, undefined, %ZOMBIE_BUILD_PIECE_GRAB, 0);
    var_c4ee7b63 = zm_craftables::function_5cf75ff1(var_9967ff1, "part_strap", 32, 64, 0, undefined, &function_aef4c63, undefined, &function_3e3b2e02, undefined, undefined, undefined, "gasmask" + "_" + "part_strap", 1, undefined, undefined, %ZOMBIE_BUILD_PIECE_GRAB, 0);
    var_a2709918.var_dcc30f2f = undefined;
    var_f113dd3d.var_dcc30f2f = undefined;
    var_c4ee7b63.var_dcc30f2f = undefined;
    gasmask = spawnstruct();
    gasmask.name = var_9967ff1;
    gasmask zm_craftables::function_b0deb4e6(var_a2709918);
    gasmask zm_craftables::function_b0deb4e6(var_f113dd3d);
    gasmask zm_craftables::function_b0deb4e6(var_c4ee7b63);
    gasmask.var_41f0f8cd = &function_d2d29a1b;
    gasmask.var_78f38827 = 1;
    zm_craftables::function_ac4e44a7(gasmask);
    level flag::init(var_9967ff1 + "_" + "part_visor" + "_found");
    level flag::init(var_9967ff1 + "_" + "part_filter" + "_found");
    level flag::init(var_9967ff1 + "_" + "part_strap" + "_found");
}

// Namespace zm_island_craftables
// Params 0, eflags: 0x0
// Checksum 0x93ca2058, Offset: 0x8a0
// Size: 0x8c
function function_95743e9f() {
    register_clientfields();
    zm_craftables::function_8421d708("gasmask", %ZM_ISLAND_CRAFT_GASMASK, "", %ZM_ISLAND_TOOK_GASMASK, &function_4e02c665, 1);
    zm_craftables::function_c86d092("gasmask", "", (0, -90, 0), (0, 0, 0));
}

// Namespace zm_island_craftables
// Params 0, eflags: 0x0
// Checksum 0x8ce9a776, Offset: 0x938
// Size: 0x14c
function register_clientfields() {
    var_a0199abd = 1;
    registerclientfield("world", "gasmask" + "_" + "part_visor", 9000, var_a0199abd, "int", undefined, 0);
    registerclientfield("world", "gasmask" + "_" + "part_filter", 9000, var_a0199abd, "int", undefined, 0);
    registerclientfield("world", "gasmask" + "_" + "part_strap", 9000, var_a0199abd, "int", undefined, 0);
    clientfield::register("toplayer", "ZMUI_GRAVITYSPIKE_PART_PICKUP", 9000, 1, "int");
    clientfield::register("toplayer", "ZMUI_GRAVITYSPIKE_CRAFTED", 9000, 1, "int");
}

// Namespace zm_island_craftables
// Params 1, eflags: 0x0
// Checksum 0x79ed71d7, Offset: 0xa90
// Size: 0x16
function function_31edd14b(player) {
    self.var_77a0498d = undefined;
}

// Namespace zm_island_craftables
// Params 1, eflags: 0x0
// Checksum 0x7b96132a, Offset: 0xab0
// Size: 0x38
function function_66a9cb86(player) {
    player thread function_9708cb71(self.piecename);
    self.var_77a0498d = player;
}

// Namespace zm_island_craftables
// Params 1, eflags: 0x0
// Checksum 0x25384b93, Offset: 0xaf0
// Size: 0x64
function function_9708cb71(piecename) {
    var_983a0e9b = "zmb_craftable_pickup";
    switch (piecename) {
    default:
        var_983a0e9b = "zmb_craftable_pickup";
        break;
    }
    self playsound(var_983a0e9b);
}

// Namespace zm_island_craftables
// Params 2, eflags: 0x0
// Checksum 0x184fa016, Offset: 0xb60
// Size: 0x54
function function_69e0fb83(var_55ce4248, n_duration) {
    self clientfield::set_to_player(var_55ce4248, 1);
    wait n_duration;
    self clientfield::set_to_player(var_55ce4248, 0);
}

// Namespace zm_island_craftables
// Params 1, eflags: 0x0
// Checksum 0x2e18b0bb, Offset: 0xbc0
// Size: 0x9c
function function_aef4c63(player) {
    str_piece = self.var_dba2448c + "_" + self.piecename;
    level flag::set(str_piece + "_found");
    player thread function_9708cb71(self.piecename);
    player notify(#"player_got_gasmask_part");
    level thread function_f34bd805(str_piece);
}

// Namespace zm_island_craftables
// Params 1, eflags: 0x0
// Checksum 0x6a4db877, Offset: 0xc68
// Size: 0x2b6
function function_f34bd805(str_piece) {
    a_players = [];
    if (self == level) {
        a_players = level.players;
    } else if (isplayer(self)) {
        a_players = array(self);
    } else {
        return;
    }
    switch (str_piece) {
    case "gasmask_part_visor":
        foreach (player in a_players) {
            player thread clientfield::set_to_player("gaskmask_part_visor", 1);
            player thread zm_craftables::function_97be99b3("zmInventory.gaskmask_part_visor", "zmInventory.widget_gasmask_parts", 0);
        }
        break;
    case "gasmask_part_strap":
        foreach (player in a_players) {
            player thread clientfield::set_to_player("gaskmask_part_strap", 1);
            player thread zm_craftables::function_97be99b3("zmInventory.gaskmask_part_strap", "zmInventory.widget_gasmask_parts", 0);
        }
        break;
    case "gasmask_part_filter":
        foreach (player in a_players) {
            player thread clientfield::set_to_player("gaskmask_part_filter", 1);
            player thread zm_craftables::function_97be99b3("zmInventory.gaskmask_part_filter", "zmInventory.widget_gasmask_parts", 0);
        }
        break;
    }
}

// Namespace zm_island_craftables
// Params 1, eflags: 0x0
// Checksum 0xc944da77, Offset: 0xf28
// Size: 0x44
function function_3e3b2e02(player) {
    iprintlnbold(self.var_dba2448c + "_" + self.piecename + "_crafted");
}

// Namespace zm_island_craftables
// Params 1, eflags: 0x0
// Checksum 0xa4d1c662, Offset: 0xf78
// Size: 0x106
function function_4e02c665(player) {
    function_aa4f440c(self.origin, self.angles);
    var_6796a7a4 = getent("mask_display", "targetname");
    var_6796a7a4 setscale(1.5);
    var_6796a7a4 moveto(self.origin + anglestoforward(self.angles) + (-5, 0, -105), 0.05);
    var_6796a7a4 rotateto(self.angles + (0, 90, 0), 0.05);
    var_6796a7a4 waittill(#"movedone");
    return true;
}

// Namespace zm_island_craftables
// Params 2, eflags: 0x0
// Checksum 0xa0452c9b, Offset: 0x1088
// Size: 0x144
function function_aa4f440c(v_origin, v_angles) {
    width = -128;
    height = -128;
    length = -128;
    unitrigger_stub = spawnstruct();
    unitrigger_stub.origin = v_origin;
    unitrigger_stub.angles = v_angles;
    unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    unitrigger_stub.cursor_hint = "HINT_NOICON";
    unitrigger_stub.script_width = width;
    unitrigger_stub.script_height = height;
    unitrigger_stub.script_length = length;
    unitrigger_stub.require_look_at = 1;
    unitrigger_stub.prompt_and_visibility_func = &function_dbc8e9c0;
    zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_272fcc74);
}

// Namespace zm_island_craftables
// Params 1, eflags: 0x0
// Checksum 0x48afeb90, Offset: 0x11d8
// Size: 0x60
function function_dbc8e9c0(player) {
    if (!player.var_df4182b1) {
        self sethintstring(%ZM_ISLAND_GASMASK_PICKUP);
    } else {
        self sethintstring(%ZOMBIE_BUILD_PIECE_HAVE_ONE);
    }
    return true;
}

// Namespace zm_island_craftables
// Params 0, eflags: 0x0
// Checksum 0x5d1c85be, Offset: 0x1240
// Size: 0xb4
function function_272fcc74() {
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
        if (!player.var_df4182b1) {
            level thread function_b4c30297(self.stub, player);
        }
        break;
    }
}

// Namespace zm_island_craftables
// Params 2, eflags: 0x0
// Checksum 0x3924419a, Offset: 0x1300
// Size: 0x38
function function_b4c30297(var_91089b66, player) {
    player.var_df4182b1 = 1;
    player notify(#"player_has_gasmask");
}

// Namespace zm_island_craftables
// Params 0, eflags: 0x0
// Checksum 0xec9edbc6, Offset: 0x1340
// Size: 0x3c
function function_f89bb811() {
    level.var_f72b0650 = 0;
    while (true) {
        util::wait_network_frame();
        level.var_f72b0650 = 0;
    }
}

// Namespace zm_island_craftables
// Params 0, eflags: 0x0
// Checksum 0xcfe38987, Offset: 0x1388
// Size: 0x58
function function_e1832857() {
    if (!isdefined(level.var_f72b0650)) {
        level thread function_f89bb811();
    }
    while (level.var_f72b0650 >= 2) {
        util::wait_network_frame();
    }
    level.var_f72b0650++;
}

// Namespace zm_island_craftables
// Params 0, eflags: 0x0
// Checksum 0xc5314377, Offset: 0x13e8
// Size: 0x4c
function function_d2d29a1b() {
    function_e1832857();
    zm_craftables::function_4f91b11d("gasmask_zm_craftable_trigger", "gasmask", "gasmask", "", 1, 0);
}

// Namespace zm_island_craftables
// Params 1, eflags: 0x0
// Checksum 0x26509514, Offset: 0x1440
// Size: 0xc
function function_23472c70(var_2be8aff) {
    
}

// Namespace zm_island_craftables
// Params 1, eflags: 0x0
// Checksum 0x7ea55ec1, Offset: 0x1458
// Size: 0xc
function function_b0c6c75a(var_2be8aff) {
    
}

