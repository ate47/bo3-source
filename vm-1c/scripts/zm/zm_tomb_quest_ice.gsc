#using scripts/codescripts/struct;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/math_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_utility;
#using scripts/zm/zm_tomb_chamber;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_vo;

#namespace zm_tomb_quest_ice;

// Namespace zm_tomb_quest_ice
// Params 0, eflags: 0x0
// Checksum 0xac97beae, Offset: 0x460
// Size: 0x24c
function main() {
    level flag::init("ice_puzzle_1_complete");
    level flag::init("ice_puzzle_2_complete");
    level flag::init("ice_upgrade_available");
    level flag::init("ice_tile_flipping");
    zm_tomb_vo::function_446b06b3(4, "vox_sam_ice_puz_solve_0");
    zm_tomb_vo::function_446b06b3(4, "vox_sam_ice_puz_solve_1");
    zm_tomb_vo::function_446b06b3(4, "vox_sam_ice_puz_solve_2");
    level thread zm_tomb_vo::function_d22bb7("puzzle", "try_puzzle", "vo_try_puzzle_water1");
    level thread zm_tomb_vo::function_d22bb7("puzzle", "try_puzzle", "vo_try_puzzle_water2");
    function_2a704782();
    level thread function_6aa0b46f();
    level thread function_dd616543();
    level flag::wait_till("ice_puzzle_1_complete");
    playsoundatposition("zmb_squest_step1_finished", (0, 0, 0));
    level thread zm_tomb_utility::function_d0dc88b2(5, 3);
    function_f610cd68();
    level thread function_d0beb464();
    level flag::wait_till("ice_puzzle_2_complete");
    level flag::wait_till("staff_water_upgrade_unlocked");
}

// Namespace zm_tomb_quest_ice
// Params 0, eflags: 0x0
// Checksum 0x7e4eb168, Offset: 0x6b8
// Size: 0x414
function function_2a704782() {
    function_2d7101fc();
    var_13ae57c8 = getentarray("ice_ceiling_tile", "script_noteworthy");
    level.var_2f1dfdf1 = var_13ae57c8;
    foreach (tile in var_13ae57c8) {
        tile.var_11cf46f9 = 0;
        tile.value = int(tile.script_string);
        tile thread function_936dd5e5();
        tile thread function_9e56bf95();
    }
    var_36e5dd29 = getentarray("ice_chamber_digit", "targetname");
    foreach (digit in var_36e5dd29) {
        digit ghost();
        digit notsolid();
    }
    level.var_5108524b = [];
    level.var_5108524b[0] = array(-1, 0, -1);
    level.var_5108524b[1] = array(-1, 1, -1);
    level.var_5108524b[2] = array(-1, 2, -1);
    level.var_5108524b[3] = array(1, -1, 0);
    level.var_5108524b[4] = array(1, -1, 1);
    level.var_5108524b[5] = array(1, -1, 2);
    level.var_5108524b[6] = array(2, -1, 0);
    level.var_5108524b[7] = array(2, -1, 1);
    level.var_5108524b[8] = array(2, -1, 2);
    level.var_5108524b[9] = array(1, 0, 0);
    level.var_5108524b[10] = array(1, 0, 1);
    level.var_5108524b[11] = array(1, 0, 2);
    level thread function_24291691();
}

// Namespace zm_tomb_quest_ice
// Params 0, eflags: 0x0
// Checksum 0x1dcec447, Offset: 0xad8
// Size: 0xfc
function function_f610cd68() {
    var_13ae57c8 = getentarray("ice_ceiling_tile", "script_noteworthy");
    foreach (tile in var_13ae57c8) {
        tile thread function_936dd5e5(0);
    }
    var_36e5dd29 = getentarray("ice_chamber_digit", "targetname");
    array::delete_all(var_36e5dd29);
}

// Namespace zm_tomb_quest_ice
// Params 0, eflags: 0x0
// Checksum 0x75f73410, Offset: 0xbe0
// Size: 0x2bc
function function_2d7101fc() {
    var_3d58a6ce = getentarray("ice_tile_original", "targetname");
    var_3d58a6ce = array::sort_by_script_int(var_3d58a6ce, 1);
    var_b188e69d = [];
    foreach (var_21f69925 in var_3d58a6ce) {
        var_b188e69d[var_b188e69d.size] = var_21f69925.origin;
    }
    var_a0e23061 = getentarray("ice_ceiling_tile", "script_noteworthy");
    var_9a0023fc = var_a0e23061.size;
    n_index = 0;
    foreach (v_pos in var_b188e69d) {
        var_21f69925 = array::random(var_a0e23061);
        arrayremovevalue(var_a0e23061, var_21f69925, 0);
        var_21f69925 moveto(v_pos, 0.5);
        var_21f69925 waittill(#"movedone");
        str_model_name = "ice_ceiling_tile_model_" + n_index;
        var_fa4117e3 = getent(str_model_name, "targetname");
        var_fa4117e3 linkto(var_21f69925);
        n_index++;
    }
    assert(var_a0e23061.size == var_9a0023fc - var_b188e69d.size);
    array::delete_all(var_a0e23061);
}

// Namespace zm_tomb_quest_ice
// Params 0, eflags: 0x0
// Checksum 0xc8ca76da, Offset: 0xea8
// Size: 0xba
function function_3ae7c694() {
    var_13ae57c8 = getentarray("ice_ceiling_tile", "script_noteworthy");
    foreach (tile in var_13ae57c8) {
        tile thread function_936dd5e5(1);
    }
}

// Namespace zm_tomb_quest_ice
// Params 0, eflags: 0x0
// Checksum 0xa468ee0b, Offset: 0xf70
// Size: 0x186
function function_24291691() {
    var_36e5dd29 = getentarray("ice_chamber_digit", "targetname");
    level endon(#"ice_puzzle_1_complete");
    while (true) {
        level waittill(#"hash_bcc8b856", newval);
        foreach (digit in var_36e5dd29) {
            digit ghost();
            if (isdefined(newval)) {
                var_7218c003 = int(digit.script_noteworthy);
                var_97bc6a2a = level.var_5108524b[newval][var_7218c003];
                var_4daf2c9e = int(digit.script_string);
                if (var_97bc6a2a == var_4daf2c9e) {
                    digit show();
                }
            }
        }
    }
}

// Namespace zm_tomb_quest_ice
// Params 0, eflags: 0x0
// Checksum 0x14a9382d, Offset: 0x1100
// Size: 0xb2
function function_fd6544ff() {
    var_c7475fb2 = getent("ice_chamber_gem", "targetname");
    if (level.var_2f1dfdf1.size != 0) {
        var_ea0601a8 = array::random(level.var_2f1dfdf1);
        var_c7475fb2.value = var_ea0601a8.value;
        level notify(#"hash_bcc8b856", var_c7475fb2.value);
        return;
    }
    level notify(#"hash_bcc8b856", -1);
}

// Namespace zm_tomb_quest_ice
// Params 0, eflags: 0x0
// Checksum 0x685006d0, Offset: 0x11c0
// Size: 0x138
function function_2985fdd0() {
    level endon(#"ice_puzzle_1_complete");
    var_c7475fb2 = getent("ice_chamber_gem", "targetname");
    var_c7475fb2.value = -1;
    var_c7475fb2 setcandamage(1);
    var_83560def = level.var_b0d8f1fe["staff_water"].w_weapon;
    while (true) {
        self waittill(#"damage", damage, attacker, direction_vec, point, mod, tagname, modelname, partname, weapon);
        if (weapon.name == var_83560def) {
            function_fd6544ff();
        }
    }
}

// Namespace zm_tomb_quest_ice
// Params 0, eflags: 0x0
// Checksum 0xa027c18f, Offset: 0x1300
// Size: 0x2c
function function_dd616543() {
    level thread function_2985fdd0();
    function_fd6544ff();
}

// Namespace zm_tomb_quest_ice
// Params 1, eflags: 0x0
// Checksum 0x8224a24a, Offset: 0x1338
// Size: 0x150
function function_936dd5e5(var_7e740424) {
    if (!isdefined(var_7e740424)) {
        var_7e740424 = !self.var_11cf46f9;
    }
    if (var_7e740424 == self.var_11cf46f9) {
        return;
    }
    self.var_11cf46f9 = !self.var_11cf46f9;
    self rotateroll(-76, 0.5);
    self playsound("zmb_squest_ice_tile_flip");
    if (!self.var_11cf46f9) {
        arrayremovevalue(level.var_2f1dfdf1, self, 0);
    } else {
        array::add(level.var_2f1dfdf1, self, 0);
    }
    if (level.var_2f1dfdf1.size == 0 && !level flag::get("ice_puzzle_1_complete")) {
        self thread zm_tomb_vo::function_2af394fb(4);
        level flag::set("ice_puzzle_1_complete");
    }
    self waittill(#"rotatedone");
}

// Namespace zm_tomb_quest_ice
// Params 0, eflags: 0x0
// Checksum 0xc24b8987, Offset: 0x1490
// Size: 0x2ae
function function_9e56bf95() {
    level endon(#"ice_puzzle_1_complete");
    var_c7475fb2 = getent("ice_chamber_gem", "targetname");
    self setcandamage(1);
    var_c7475fb2 setcandamage(1);
    while (true) {
        self waittill(#"damage", damage, attacker, direction_vec, point, mod, tagname, modelname, partname, weaponname);
        var_f1415f17 = arraygetclosest(point, level.var_2f1dfdf1);
        if (issubstr(weaponname.name, "water") && self.var_11cf46f9 && var_f1415f17 == self) {
            if (!level flag::get("ice_tile_flipping")) {
                level notify(#"vo_try_puzzle_water1", attacker);
                level flag::set("ice_tile_flipping");
                if (var_c7475fb2.value == self.value) {
                    level notify(#"vo_puzzle_good", attacker);
                    self function_936dd5e5(0);
                    zm_tomb_utility::rumble_nearby_players(self.origin, 1500, 2);
                    wait 0.2;
                } else {
                    level notify(#"vo_puzzle_bad", attacker);
                    function_3ae7c694();
                    zm_tomb_utility::rumble_nearby_players(self.origin, 1500, 2);
                    wait 2;
                }
                function_fd6544ff();
                level flag::clear("ice_tile_flipping");
                continue;
            }
            level notify(#"vo_puzzle_confused", attacker);
        }
    }
}

// Namespace zm_tomb_quest_ice
// Params 0, eflags: 0x0
// Checksum 0x99ec1590, Offset: 0x1748
// Size: 0x4
function function_6aa0b46f() {
    
}

// Namespace zm_tomb_quest_ice
// Params 0, eflags: 0x0
// Checksum 0x93150d93, Offset: 0x1758
// Size: 0xd2
function function_d0beb464() {
    var_f3db01dd = struct::get_array("puzzle_stone_water", "targetname");
    level.var_b5073b52 = var_f3db01dd.size;
    foreach (s_stone in var_f3db01dd) {
        s_stone thread function_8bec872();
        util::wait_network_frame();
    }
}

// Namespace zm_tomb_quest_ice
// Params 0, eflags: 0x0
// Checksum 0xfd2782c1, Offset: 0x1838
// Size: 0x642
function function_8bec872() {
    v_up = anglestoup(self.angles);
    v_spawn_pos = self.origin - 64 * v_up;
    self.e_model = spawn("script_model", v_spawn_pos);
    self.e_model.angles = self.angles;
    self.e_model setmodel("p7_zm_ori_note_rock_01_anim_water");
    self.e_model moveto(self.origin, 1, 0.5, 0.5);
    playfx(level._effect["digging"], self.origin);
    self.e_model setcandamage(1);
    self.e_model playloopsound("zmb_squest_ice_stone_flow", 2);
    for (var_7aed76a = 0; !level flag::get("ice_puzzle_2_complete"); var_7aed76a = 1) {
        self.e_model waittill(#"damage", amount, inflictor, direction, point, type, tagname, modelname, partname, weaponname, idflags);
        level notify(#"vo_try_puzzle_water2", inflictor);
        if (issubstr(weaponname.name, "water")) {
            level notify(#"vo_puzzle_good", inflictor);
            break;
        }
        if (var_7aed76a) {
            level notify(#"vo_puzzle_bad", inflictor);
        }
    }
    self.e_model setmodel("p7_zm_ori_note_rock_01_anim");
    self.e_model clientfield::set("stone_frozen", 1);
    playsoundatposition("zmb_squest_ice_stone_freeze", self.origin);
    while (!level flag::get("ice_puzzle_2_complete")) {
        self.e_model waittill(#"damage", amount, inflictor, direction, point, type, tagname, modelname, partname, weaponname, idflags);
        if (!issubstr(weaponname.name, "staff") && issubstr(type, "BULLET")) {
            level notify(#"vo_puzzle_good", inflictor);
            break;
        }
        level notify(#"vo_puzzle_confused", inflictor);
    }
    self.e_model delete();
    playfx(level._effect["ice_explode"], self.origin, anglestoforward(self.angles), anglestoup(self.angles));
    playsoundatposition("zmb_squest_ice_stone_shatter", self.origin);
    level.var_b5073b52--;
    if (level.var_b5073b52 <= 0 && !level flag::get("ice_puzzle_2_complete")) {
        level flag::set("ice_puzzle_2_complete");
        e_player = zm_utility::get_closest_player(self.origin);
        e_player thread zm_tomb_vo::function_2af394fb(4);
        level thread zm_tomb_utility::function_95f226b8();
        level.var_c95eeed7 = 5;
        level.var_aa00c190 = 0;
        foreach (player in getplayers()) {
            player zm_tomb_utility::function_c6592f0e();
        }
        wait 5;
        level.var_c95eeed7 = 0;
        level.var_aa00c190 = 0;
        foreach (player in getplayers()) {
            player zm_tomb_utility::function_c6592f0e();
        }
    }
}

