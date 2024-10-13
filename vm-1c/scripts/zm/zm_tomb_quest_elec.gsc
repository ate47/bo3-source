#using scripts/zm/zm_tomb_vo;
#using scripts/zm/zm_tomb_utility;
#using scripts/zm/zm_tomb_chamber;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_unitrigger;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/util_shared;
#using scripts/shared/math_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/array_shared;
#using scripts/codescripts/struct;

#namespace zm_tomb_quest_elec;

// Namespace zm_tomb_quest_elec
// Params 0, eflags: 0x1 linked
// Checksum 0x92b02ee3, Offset: 0x4a0
// Size: 0x22c
function main() {
    callback::on_connect(&onplayerconnect);
    level flag::init("electric_puzzle_1_complete");
    level flag::init("electric_puzzle_2_complete");
    level flag::init("electric_upgrade_available");
    zm_tomb_vo::function_446b06b3(3, "vox_sam_lightning_puz_solve_0");
    zm_tomb_vo::function_446b06b3(3, "vox_sam_lightning_puz_solve_1");
    zm_tomb_vo::function_446b06b3(3, "vox_sam_lightning_puz_solve_2");
    level thread zm_tomb_vo::function_d22bb7("puzzle", "try_puzzle", "vo_try_puzzle_lightning1");
    level thread zm_tomb_vo::function_d22bb7("puzzle", "try_puzzle", "vo_try_puzzle_lightning2");
    function_9ab612a8();
    function_1fe92091();
    level thread function_69295049();
    level flag::wait_till("electric_puzzle_1_complete");
    playsoundatposition("zmb_squest_step1_finished", (0, 0, 0));
    level thread zm_tomb_utility::function_d0dc88b2(5, 3);
    level thread function_4d80ac56();
    level flag::wait_till("electric_puzzle_2_complete");
    level thread function_c2723d51();
}

// Namespace zm_tomb_quest_elec
// Params 0, eflags: 0x1 linked
// Checksum 0x16ee5889, Offset: 0x6d8
// Size: 0x1c
function onplayerconnect() {
    self thread function_3dcfa4d8();
}

// Namespace zm_tomb_quest_elec
// Params 0, eflags: 0x1 linked
// Checksum 0x456293c8, Offset: 0x700
// Size: 0x200
function function_3dcfa4d8() {
    self endon(#"disconnect");
    var_4446253b = struct::get_array("piano_key", "script_noteworthy");
    var_dc8ace48 = level.var_b0d8f1fe["staff_lightning"].w_weapon;
    while (true) {
        w_weapon, var_836ef144, n_radius, e_projectile, var_94351942 = self waittill(#"projectile_impact");
        if (w_weapon == var_dc8ace48) {
            if (!level flag::get("electric_puzzle_1_complete") && zm_tomb_chamber::function_55f62409()) {
                n_index = zm_utility::get_closest_index(var_836ef144, var_4446253b, 20);
                if (isdefined(n_index)) {
                    var_4446253b[n_index] notify(#"hash_3a803777");
                    a_players = getplayers();
                    foreach (e_player in a_players) {
                        if (e_player hasweapon(var_dc8ace48)) {
                            level notify(#"vo_try_puzzle_lightning1", e_player);
                        }
                    }
                }
            }
        }
    }
}

// Namespace zm_tomb_quest_elec
// Params 0, eflags: 0x1 linked
// Checksum 0x31e294e3, Offset: 0x908
// Size: 0x24
function function_9ab612a8() {
    level flag::init("piano_chord_ringing");
}

// Namespace zm_tomb_quest_elec
// Params 0, eflags: 0x1 linked
// Checksum 0x78a802e9, Offset: 0x938
// Size: 0x74
function function_69295049() {
    var_4446253b = struct::get_array("piano_key", "script_noteworthy");
    level.var_84ed0374 = [];
    array::thread_all(var_4446253b, &function_96e839a6);
    level thread function_6132b1a8();
}

// Namespace zm_tomb_quest_elec
// Params 0, eflags: 0x1 linked
// Checksum 0x47ca3d0f, Offset: 0x9b8
// Size: 0x1c
function function_434bc0fe() {
    level notify(#"hash_434bc0fe");
    level.var_84ed0374 = [];
}

/#

    // Namespace zm_tomb_quest_elec
    // Params 1, eflags: 0x1 linked
    // Checksum 0x6ebe0578, Offset: 0x9e0
    // Size: 0x16c
    function function_745dff15(var_9204b76f) {
        if (!isdefined(var_9204b76f)) {
            var_9204b76f = [];
        }
        var_4446253b = struct::get_array("<dev string:x28>", "<dev string:x32>");
        foreach (e_key in var_4446253b) {
            e_key notify(#"stop_debug_position");
            foreach (note in var_9204b76f) {
                if (note == e_key.script_string) {
                    e_key thread zm_tomb_utility::function_5de0d079();
                    break;
                }
            }
        }
    }

#/

// Namespace zm_tomb_quest_elec
// Params 0, eflags: 0x1 linked
// Checksum 0xe591d5d6, Offset: 0xb58
// Size: 0x5dc
function function_6132b1a8() {
    var_a3517334 = struct::get_array("piano_chord", "targetname");
    foreach (var_6b1a5b5b in var_a3517334) {
        var_6b1a5b5b.notes = strtok(var_6b1a5b5b.script_string, " ");
        assert(var_6b1a5b5b.notes.size == 3);
    }
    var_dc8ace48 = level.var_b0d8f1fe["staff_lightning"].w_weapon;
    var_732b5f80 = array("a_minor", "e_minor", "d_minor");
    foreach (var_4272ea31 in var_732b5f80) {
        var_6b1a5b5b = struct::get("piano_chord_" + var_4272ea31, "script_noteworthy");
        /#
            function_745dff15(var_6b1a5b5b.notes);
        #/
        var_2c1470a7 = 0;
        while (!var_2c1470a7) {
            level waittill(#"hash_969e75ce");
            if (level.var_84ed0374.size == 3) {
                var_5a37fd8c = 0;
                foreach (var_f246c89b in level.var_84ed0374) {
                    foreach (var_4c707002 in var_6b1a5b5b.notes) {
                        if (var_4c707002 == var_f246c89b) {
                            var_5a37fd8c++;
                        }
                    }
                }
                if (var_5a37fd8c == 3) {
                    var_2c1470a7 = 1;
                    continue;
                }
                a_players = getplayers();
                foreach (e_player in a_players) {
                    if (e_player hasweapon(var_dc8ace48)) {
                        level notify(#"vo_puzzle_bad", e_player);
                    }
                }
            }
        }
        a_players = getplayers();
        foreach (e_player in a_players) {
            if (e_player hasweapon(var_dc8ace48)) {
                level notify(#"vo_puzzle_good", e_player);
            }
        }
        level flag::set("piano_chord_ringing");
        zm_tomb_utility::rumble_nearby_players(var_a3517334[0].origin, 1500, 2);
        wait 4;
        level flag::clear("piano_chord_ringing");
        function_434bc0fe();
        /#
            function_745dff15();
        #/
    }
    e_player = zm_utility::get_closest_player(var_a3517334[0].origin);
    e_player thread zm_tomb_vo::function_2af394fb(3);
    level flag::set("electric_puzzle_1_complete");
}

// Namespace zm_tomb_quest_elec
// Params 0, eflags: 0x1 linked
// Checksum 0x93db79ba, Offset: 0x1140
// Size: 0x188
function function_96e839a6() {
    var_fbad02cf = self.script_string;
    while (true) {
        self waittill(#"hash_3a803777");
        if (!level flag::get("piano_chord_ringing")) {
            if (level.var_84ed0374.size >= 3) {
                function_434bc0fe();
            }
            self.e_fx = spawn("script_model", self.origin);
            self.e_fx playloopsound("zmb_kbd_" + var_fbad02cf);
            self.e_fx.angles = self.angles;
            self.e_fx setmodel("tag_origin");
            playfxontag(level._effect["elec_piano_glow"], self.e_fx, "tag_origin");
            level.var_84ed0374[level.var_84ed0374.size] = var_fbad02cf;
            level notify(#"hash_969e75ce", self, var_fbad02cf);
            level waittill(#"hash_434bc0fe");
            self.e_fx delete();
        }
    }
}

// Namespace zm_tomb_quest_elec
// Params 0, eflags: 0x1 linked
// Checksum 0x6404b8c3, Offset: 0x12d0
// Size: 0x4ec
function function_1fe92091() {
    level.var_5fbedd25 = [];
    level.var_5fbedd25["bunker"] = spawnstruct();
    level.var_5fbedd25["tank_platform"] = spawnstruct();
    level.var_5fbedd25["start"] = spawnstruct();
    level.var_5fbedd25["elec"] = spawnstruct();
    level.var_5fbedd25["ruins"] = spawnstruct();
    level.var_5fbedd25["air"] = spawnstruct();
    level.var_5fbedd25["ice"] = spawnstruct();
    level.var_5fbedd25["village"] = spawnstruct();
    foreach (var_42b04582 in level.var_5fbedd25) {
        var_42b04582.connections = [];
    }
    level.var_5fbedd25["tank_platform"].connections[0] = "ruins";
    level.var_5fbedd25["start"].connections[1] = "tank_platform";
    level.var_5fbedd25["elec"].connections[0] = "ice";
    level.var_5fbedd25["ruins"].connections[2] = "chamber";
    level.var_5fbedd25["air"].connections[2] = "start";
    level.var_5fbedd25["ice"].connections[3] = "village";
    level.var_5fbedd25["village"].connections[2] = "air";
    level.var_5fbedd25["bunker"].position = 2;
    level.var_5fbedd25["tank_platform"].position = 1;
    level.var_5fbedd25["start"].position = 3;
    level.var_5fbedd25["elec"].position = 1;
    level.var_5fbedd25["ruins"].position = 3;
    level.var_5fbedd25["air"].position = 0;
    level.var_5fbedd25["ice"].position = 1;
    level.var_5fbedd25["village"].position = 1;
    var_30ca4735 = getentarray("puzzle_relay_switch", "script_noteworthy");
    foreach (e_switch in var_30ca4735) {
        level.var_5fbedd25[e_switch.script_string].e_switch = e_switch;
    }
    array::thread_all(level.var_5fbedd25, &function_b15cfb65);
}

// Namespace zm_tomb_quest_elec
// Params 0, eflags: 0x1 linked
// Checksum 0x17a3a64, Offset: 0x17c8
// Size: 0x14
function function_4d80ac56() {
    function_8edc43();
}

// Namespace zm_tomb_quest_elec
// Params 0, eflags: 0x1 linked
// Checksum 0x41296cd6, Offset: 0x17e8
// Size: 0x10a
function function_c2723d51() {
    foreach (var_42b04582 in level.var_5fbedd25) {
        if (isdefined(var_42b04582.trigger_stub)) {
            zm_unitrigger::register_unitrigger(var_42b04582.trigger_stub);
        }
        if (isdefined(var_42b04582.e_switch)) {
            var_42b04582.e_switch stoploopsound(0.5);
        }
        if (isdefined(var_42b04582.e_fx)) {
            var_42b04582.e_fx delete();
        }
    }
}

// Namespace zm_tomb_quest_elec
// Params 0, eflags: 0x1 linked
// Checksum 0x1ed839f6, Offset: 0x1900
// Size: 0x96
function function_fdc6c20d() {
    foreach (var_42b04582 in level.var_5fbedd25) {
        var_42b04582.var_95762923 = 0;
        var_42b04582.var_5f2c4e23 = 0;
    }
}

// Namespace zm_tomb_quest_elec
// Params 1, eflags: 0x1 linked
// Checksum 0x364effea, Offset: 0x19a0
// Size: 0x15c
function function_cddd4212(var_42b04582) {
    if (!level flag::get("electric_puzzle_1_complete")) {
        return;
    }
    if (!isdefined(var_42b04582)) {
        function_fdc6c20d();
        var_42b04582 = level.var_5fbedd25["elec"];
    }
    var_42b04582.var_95762923 = 1;
    var_a734aa18 = var_42b04582.connections[var_42b04582.position];
    if (isdefined(var_a734aa18)) {
        if (var_a734aa18 == "chamber") {
            var_42b04582.e_switch thread zm_tomb_vo::function_2af394fb(3);
            level thread zm_tomb_utility::function_95f226b8();
            level flag::set("electric_puzzle_2_complete");
            return;
        }
        var_42b04582.var_5f2c4e23 = 1;
        var_870a4ff2 = level.var_5fbedd25[var_a734aa18];
        function_cddd4212(var_870a4ff2);
    }
}

// Namespace zm_tomb_quest_elec
// Params 0, eflags: 0x1 linked
// Checksum 0x2c9364ad, Offset: 0x1b08
// Size: 0x2c2
function function_a7ecedb7() {
    if (!level flag::get("electric_puzzle_1_complete")) {
        return;
    }
    foreach (var_42b04582 in level.var_5fbedd25) {
        if (var_42b04582.var_5f2c4e23) {
            if (isdefined(var_42b04582.e_fx)) {
                var_42b04582.e_fx delete();
            }
            var_42b04582.e_switch playloopsound("zmb_squest_elec_switch_hum", 1);
            continue;
        }
        if (var_42b04582.var_95762923) {
            if (!isdefined(var_42b04582.e_fx)) {
                v_offset = anglestoright(var_42b04582.e_switch.angles) * 1;
                var_42b04582.e_fx = spawn("script_model", var_42b04582.e_switch.origin + v_offset);
                var_42b04582.e_fx.angles = var_42b04582.e_switch.angles + (0, 0, -90);
                var_42b04582.e_fx setmodel("tag_origin");
                playfxontag(level._effect["fx_tomb_sparks_sm"], var_42b04582.e_fx, "tag_origin");
            }
            var_42b04582.e_switch playloopsound("zmb_squest_elec_switch_spark", 1);
            continue;
        }
        if (isdefined(var_42b04582.e_fx)) {
            var_42b04582.e_fx delete();
        }
        var_42b04582.e_switch stoploopsound(1);
    }
}

// Namespace zm_tomb_quest_elec
// Params 0, eflags: 0x1 linked
// Checksum 0x31a39bc7, Offset: 0x1dd8
// Size: 0x96
function function_e17ece2d() {
    self.e_switch rotateto((self.position * 90, self.e_switch.angles[1], self.e_switch.angles[2]), 0.1, 0, 0);
    self.e_switch playsound("zmb_squest_elec_switch");
    self.e_switch waittill(#"rotatedone");
}

// Namespace zm_tomb_quest_elec
// Params 0, eflags: 0x1 linked
// Checksum 0x602c0544, Offset: 0x1e78
// Size: 0x24
function function_8edc43() {
    function_cddd4212();
    function_a7ecedb7();
}

// Namespace zm_tomb_quest_elec
// Params 0, eflags: 0x1 linked
// Checksum 0x403b30d6, Offset: 0x1ea8
// Size: 0x250
function function_b15cfb65() {
    assert(isdefined(self.e_switch));
    self.trigger_stub = spawnstruct();
    self.trigger_stub.origin = self.e_switch.origin;
    self.trigger_stub.radius = 50;
    self.trigger_stub.cursor_hint = "HINT_NOICON";
    self.trigger_stub.hint_string = "";
    self.trigger_stub.script_unitrigger_type = "unitrigger_radius_use";
    self.trigger_stub.require_look_at = 1;
    zm_unitrigger::register_unitrigger(self.trigger_stub, &function_20d54c0c);
    level endon(#"electric_puzzle_2_complete");
    self thread function_e17ece2d();
    n_tries = 0;
    while (true) {
        e_user = self.trigger_stub waittill(#"trigger");
        n_tries++;
        level notify(#"vo_try_puzzle_lightning2", e_user);
        self.position = (self.position + 1) % 4;
        var_a734aa18 = self.connections[self.position];
        if (isdefined(var_a734aa18)) {
            if (var_a734aa18 == "village" || var_a734aa18 == "ruins") {
                level notify(#"vo_puzzle_good", e_user);
            }
        } else if (n_tries % 8 == 0) {
            level notify(#"vo_puzzle_confused", e_user);
        } else if (n_tries % 4 == 0) {
            level notify(#"vo_puzzle_bad", e_user);
        }
        self function_e17ece2d();
        function_8edc43();
    }
}

// Namespace zm_tomb_quest_elec
// Params 0, eflags: 0x1 linked
// Checksum 0xe07869e8, Offset: 0x2100
// Size: 0x4c
function function_20d54c0c() {
    self endon(#"kill_trigger");
    while (true) {
        player = self waittill(#"trigger");
        self.stub notify(#"trigger", player);
    }
}

