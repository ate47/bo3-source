#using scripts/zm/_zm_devgui;
#using scripts/zm/zm_castle_vo;
#using scripts/zm/zm_castle_flingers;
#using scripts/zm/_zm_pack_a_punch_util;
#using scripts/zm/_zm_pack_a_punch;
#using scripts/zm/_zm_unitrigger;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/laststand_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flagsys_shared;
#using scripts/shared/scene_shared;
#using scripts/shared/util_shared;
#using scripts/shared/array_shared;
#using scripts/shared/system_shared;
#using scripts/shared/flag_shared;
#using scripts/codescripts/struct;

#namespace namespace_155a700c;

// Namespace namespace_155a700c
// Params 0, eflags: 0x2
// namespace_155a700c<file_0>::function_2dc19561
// Checksum 0x663618b, Offset: 0x540
// Size: 0x3c
function autoexec function_2dc19561() {
    system::register("zm_castle_pap_quest", &__init__, &__main__, undefined);
}

// Namespace namespace_155a700c
// Params 0, eflags: 0x1 linked
// namespace_155a700c<file_0>::function_8c87d8eb
// Checksum 0x5c1626b3, Offset: 0x588
// Size: 0xbc
function __init__() {
    clientfield::register("scriptmover", "pap_tp_fx", 5000, 1, "counter");
    level.var_e1ee8457 = 0;
    level flag::init("pap_reform_available");
    level flag::init("pap_reformed");
    level.pack_a_punch.custom_power_think = &function_c4641d12;
    level.zombiemode_reusing_pack_a_punch = 1;
    zm_pap_util::function_5e0cf34(-128);
}

// Namespace namespace_155a700c
// Params 0, eflags: 0x1 linked
// namespace_155a700c<file_0>::function_5b6b9132
// Checksum 0x1ab23914, Offset: 0x650
// Size: 0x1c
function __main__() {
    /#
        level thread function_42a3de0d();
    #/
}

// Namespace namespace_155a700c
// Params 1, eflags: 0x1 linked
// namespace_155a700c<file_0>::function_c4641d12
// Checksum 0xed75b347, Offset: 0x678
// Size: 0x8e0
function function_c4641d12(is_powered) {
    level.var_1c602ba8 = struct::get_array("s_pap_tp");
    level.pap_machine = self;
    self.zbarrier namespace_d0ad3850::set_state_hidden();
    array::thread_all(level.var_1c602ba8, &function_53bc4f86, self);
    level.var_164e92cf = 2;
    level.var_1e4d46e3 = 0;
    level.var_22ce1993 = [];
    level.var_22ce1993[0] = "fxexp_804";
    level.var_22ce1993[1] = "fxexp_805";
    level.var_22ce1993[2] = "fxexp_803";
    var_6eb9e3e5 = [];
    var_6eb9e3e5[0] = "lgt_undercroft_exp";
    var_6eb9e3e5[1] = "lgt_rocketpad_exp";
    var_6eb9e3e5[2] = "lgt_bastion_exp";
    var_e98af28a = [];
    var_e98af28a[0] = "fxexp_801";
    var_e98af28a[1] = "fxexp_802";
    var_e98af28a[2] = "fxexp_800";
    while (level.var_1e4d46e3 < level.var_164e92cf) {
        wait(0.05);
    }
    self.zbarrier show();
    pap_machine = getent("pap_prefab", "prefabname");
    self.zbarrier namespace_d0ad3850::set_state_initial();
    self.zbarrier namespace_d0ad3850::set_state_power_on();
    level waittill(#"hash_9d5be202");
    level.var_9b1767c1 = level.round_number + randomintrange(2, 4);
    var_94e7d6ca = undefined;
    var_3c7c9ebd = undefined;
    while (true) {
        level waittill(#"end_of_round");
        if (isdefined(var_94e7d6ca)) {
            var_94e7d6ca delete();
        }
        if (isdefined(var_3c7c9ebd)) {
            var_3c7c9ebd delete();
        }
        if (level.round_number >= level.var_9b1767c1) {
            while (self.zbarrier.state == "eject_gun" || self.zbarrier.state == "take_gun") {
                wait(0.05);
            }
            e_clip = getent("pap_" + level.var_94c82bf8[level.var_2eccab0d].script_noteworthy + "_clip", "targetname");
            e_clip function_2209afdf();
            e_clip solid();
            mdl_debris = getent("pap_debris_" + level.var_94c82bf8[level.var_2eccab0d].script_noteworthy, "targetname");
            mdl_debris show();
            var_92f094dc = var_6eb9e3e5[level.var_2eccab0d];
            var_b57a445e = level.var_22ce1993[level.var_2eccab0d];
            playrumbleonposition("zm_castle_pap_tp", self.origin);
            level.var_2eccab0d++;
            if (level.var_2eccab0d >= level.var_94c82bf8.size) {
                level.var_2eccab0d = 0;
            }
            var_528227ee = level.var_94c82bf8[level.var_2eccab0d].origin;
            var_39796348 = level.var_94c82bf8[level.var_2eccab0d].angles;
            self.zbarrier namespace_d0ad3850::set_state_leaving();
            var_3c7c9ebd = spawn("script_model", self.origin + (0, 0, 72));
            var_3c7c9ebd setmodel("tag_origin");
            var_3c7c9ebd.angles = self.angles;
            var_94e7d6ca = spawn("script_model", var_528227ee);
            var_94e7d6ca setmodel("tag_origin");
            var_94e7d6ca.angles = var_39796348;
            self.zbarrier waittill(#"leave_anim_done");
            mdl_debris = getent("pap_debris_" + level.var_94c82bf8[level.var_2eccab0d].script_noteworthy, "targetname");
            mdl_debris hide();
            e_clip = getent("pap_" + level.var_94c82bf8[level.var_2eccab0d].script_noteworthy + "_clip", "targetname");
            e_clip notsolid();
            var_3c7c9ebd clientfield::increment("pap_tp_fx");
            var_94e7d6ca clientfield::increment("pap_tp_fx");
            var_56f90684 = var_6eb9e3e5[level.var_2eccab0d];
            var_592384e6 = level.var_22ce1993[level.var_2eccab0d];
            exploder::exploder_stop(var_b57a445e);
            exploder::exploder_stop(var_92f094dc);
            exploder::exploder(var_592384e6);
            exploder::exploder(var_56f90684);
            self.origin = var_528227ee + (0, 0, 32);
            self.angles = var_39796348;
            self.zbarrier.origin = var_528227ee + (0, 0, -16);
            self.zbarrier.angles = var_39796348;
            self thread function_5f17a55c();
            wait(0.05);
            var_2b73a923 = getent("pap_clip", "targetname");
            var_f72d376e = vectornormalize(anglestoforward(level.var_94c82bf8[level.var_2eccab0d].angles + (0, -90, 0))) * 16;
            var_2b73a923.origin = var_528227ee + var_f72d376e + (0, 0, 64);
            var_2b73a923.angles = var_39796348 + (0, 90, 0);
            var_2b73a923 function_88c193db();
            self.zbarrier namespace_d0ad3850::set_state_arriving();
            level.var_9b1767c1 = level.round_number + randomintrange(2, 4);
        }
    }
}

// Namespace namespace_155a700c
// Params 0, eflags: 0x1 linked
// namespace_155a700c<file_0>::function_88c193db
// Checksum 0x8001bcb9, Offset: 0xf60
// Size: 0x44
function function_88c193db() {
    if (level.var_94c82bf8[level.var_2eccab0d].script_noteworthy === "under") {
        self.origin = (-256, 2500, 310);
    }
}

// Namespace namespace_155a700c
// Params 0, eflags: 0x1 linked
// namespace_155a700c<file_0>::function_2209afdf
// Checksum 0xc540c5ca, Offset: 0xfb0
// Size: 0x64
function function_2209afdf() {
    for (var_3a825beb = util::any_player_is_touching(self, "allies"); var_3a825beb; var_3a825beb = util::any_player_is_touching(self, "allies")) {
        wait(0.05);
    }
}

// Namespace namespace_155a700c
// Params 0, eflags: 0x1 linked
// namespace_155a700c<file_0>::function_5f17a55c
// Checksum 0x328e18c0, Offset: 0x1020
// Size: 0x22a
function function_5f17a55c() {
    a_players = array::get_all_closest(self.origin, level.players, undefined, 4, 95);
    foreach (e_player in a_players) {
        e_player dodamage(e_player.health + 100, e_player.origin + (0, 100, 0));
        if (self laststand::player_is_in_laststand()) {
            if (self.bleedout_time > 0) {
                self.bleedout_time = 0;
            }
            continue;
        }
        self.bleedout_time = 0.5;
    }
    a_ai_enemies = array::get_all_closest(self.origin, getaiteamarray(level.zombie_team), undefined, 40, 100);
    foreach (ai_zombie in a_ai_enemies) {
        ai_zombie dodamage(ai_zombie.health + 100, ai_zombie.origin + (0, 100, 0));
    }
}

// Namespace namespace_155a700c
// Params 1, eflags: 0x1 linked
// namespace_155a700c<file_0>::function_53bc4f86
// Checksum 0xe9b286bb, Offset: 0x1258
// Size: 0x4bc
function function_53bc4f86(pap_machine) {
    e_clip = getent(self.script_string, "targetname");
    e_clip.targetname = "pap_" + self.script_noteworthy + "_clip";
    mdl_debris = function_23193d81(self.script_noteworthy);
    mdl_debris hide();
    s_unitrigger_stub = spawnstruct();
    s_unitrigger_stub.origin = self.origin + (0, 0, 30);
    s_unitrigger_stub.radius = 70;
    s_unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_unitrigger_stub.script_unitrigger_type = "unitrigger_radius_use";
    s_unitrigger_stub.prompt_and_visibility_func = &function_99664e8;
    s_unitrigger_stub.parent_struct = self;
    s_unitrigger_stub.parent_struct.activated = 0;
    zm_unitrigger::register_static_unitrigger(s_unitrigger_stub, &namespace_4fd1ba2a::function_4029cf56);
    e_who = s_unitrigger_stub waittill(#"trigger");
    while (level.var_e1ee8457 > 0) {
        wait(0.05);
    }
    if (level.var_1e4d46e3 >= level.var_164e92cf) {
        return;
    }
    var_40cae301 = [];
    var_40cae301["under"] = "fxexp_811";
    var_40cae301["rocket"] = "fxexp_812";
    var_40cae301["roof"] = "fxexp_810";
    exploder::exploder(var_40cae301[self.script_noteworthy]);
    var_22ce1993 = [];
    var_22ce1993["under"] = "fxexp_801";
    var_22ce1993["rocket"] = "fxexp_802";
    var_22ce1993["roof"] = "fxexp_800";
    exploder::exploder(var_22ce1993[self.script_noteworthy]);
    playrumbleonposition("zm_castle_pap_tp", self.origin);
    for (i = 0; i < level.var_1c602ba8.size; i++) {
        if (level.var_1c602ba8[i] == self) {
            level.var_1c602ba8 = array::remove_index(level.var_1c602ba8, i);
        }
    }
    if (level.var_1e4d46e3 < level.var_164e92cf) {
        e_who thread namespace_97ddfc0d::function_ce6b93fc();
    }
    level.var_a8ca2bee = level.var_1c602ba8[0];
    level.var_1e4d46e3++;
    s_unitrigger_stub.parent_struct.activated = 1;
    self function_566e5eb4();
    if (level.var_1e4d46e3 >= level.var_164e92cf) {
        level.var_1c602ba8[0].activated = 1;
        level.var_54cd8d06 = level.var_1c602ba8[0];
        while (level.var_e1ee8457) {
            wait(0.05);
        }
        level flag::set("pap_reform_available");
    }
    mdl_debris = getent("pap_debris_" + self.script_noteworthy, "targetname");
    mdl_debris show();
    while (level.var_e1ee8457) {
        wait(0.05);
    }
    exploder::exploder_stop(var_22ce1993[self.script_noteworthy]);
}

// Namespace namespace_155a700c
// Params 1, eflags: 0x1 linked
// namespace_155a700c<file_0>::function_23193d81
// Checksum 0x94d69835, Offset: 0x1720
// Size: 0x174
function function_23193d81(str_location) {
    v_origin = undefined;
    v_angles = undefined;
    switch (str_location) {
    case 34:
        v_origin = (3890, -2587.36, -2155.74);
        v_angles = (359.934, 168.599, 0.997782);
        break;
    case 36:
        v_origin = (-106, 2446.97, 927.25);
        v_angles = (0, 0, 0);
        break;
    case 28:
        v_origin = (-256, 2485.48, 207.974);
        v_angles = (359.785, 136.597, 0.976539);
        break;
    default:
        break;
    }
    mdl_debris = util::spawn_model("p7_debris_metal_twisted_a_lrg", v_origin, v_angles);
    mdl_debris setscale(0.85);
    mdl_debris.targetname = "pap_debris_" + str_location;
    return mdl_debris;
}

// Namespace namespace_155a700c
// Params 0, eflags: 0x1 linked
// namespace_155a700c<file_0>::function_b9cca08f
// Checksum 0xd9ca6569, Offset: 0x18a0
// Size: 0x108
function function_b9cca08f() {
    level endon(#"hash_1c8f2071");
    self endon(#"death");
    self endon(#"disconnect");
    level flag::wait_till("pap_reform_available");
    var_4ff1b6c0 = level.var_54cd8d06;
    while (true) {
        self util::waittill_player_looking_at(var_4ff1b6c0.origin + (0, 0, 50), 90);
        if (distance(self.origin, var_4ff1b6c0.origin) < 400) {
            level thread function_eb56512();
            level flag::set("pap_reformed");
        }
        wait(0.05);
    }
}

// Namespace namespace_155a700c
// Params 0, eflags: 0x1 linked
// namespace_155a700c<file_0>::function_eb56512
// Checksum 0xce6cdd43, Offset: 0x19b0
// Size: 0x5d4
function function_eb56512() {
    var_4ff1b6c0 = level.var_54cd8d06;
    var_22ce1993 = [];
    var_22ce1993["under"] = "fxexp_801";
    var_22ce1993["rocket"] = "fxexp_802";
    var_22ce1993["roof"] = "fxexp_800";
    var_6eb9e3e5 = [];
    var_6eb9e3e5["under"] = "lgt_undercroft_exp";
    var_6eb9e3e5["rocket"] = "lgt_rocketpad_exp";
    var_6eb9e3e5["roof"] = "lgt_bastion_exp";
    var_9e129aa9 = var_22ce1993[var_4ff1b6c0.script_noteworthy];
    exploder::exploder(var_9e129aa9);
    playrumbleonposition("zm_castle_pap_tp", var_4ff1b6c0.origin);
    zm_pap_util::set_interaction_height(256);
    level.var_94c82bf8 = [];
    var_aa03df75 = struct::get_array("s_pap_location", "targetname");
    foreach (var_309749f1 in var_aa03df75) {
        level.var_94c82bf8[var_309749f1.script_int] = var_309749f1;
    }
    var_fc5d165 = arraygetclosest(var_4ff1b6c0.origin, level.var_94c82bf8);
    level.var_c9f5f61 = getentarray(var_4ff1b6c0.target, "targetname");
    scene::add_scene_func("p7_fxanim_zm_castle_pap_complete_reform_bundle", &function_335f66d5, "play");
    var_fc5d165.origin += (0, 0, -16);
    var_fc5d165 scene::play("p7_fxanim_zm_castle_pap_complete_reform_bundle");
    var_fc5d165.origin += (0, 0, 16);
    level.var_2eccab0d = var_fc5d165.script_int;
    var_528227ee = level.var_94c82bf8[level.var_2eccab0d].origin;
    var_39796348 = level.var_94c82bf8[level.var_2eccab0d].angles;
    level.pap_machine.origin = var_528227ee + (0, 0, 32);
    level.pap_machine.angles = var_39796348;
    level.pap_machine.zbarrier.origin = var_528227ee + (0, 0, -16);
    level.pap_machine.zbarrier.angles = var_39796348;
    var_2b73a923 = getent("pap_clip", "targetname");
    var_f72d376e = vectornormalize(anglestoforward(var_fc5d165.angles + (0, -90, 0))) * 16;
    var_2b73a923.origin = var_528227ee + var_f72d376e + (0, 0, 64);
    var_2b73a923.angles = var_39796348 + (0, 90, 0);
    var_2b73a923 function_88c193db();
    exploder::exploder(level.var_22ce1993[level.var_2eccab0d]);
    exploder::exploder_stop(var_9e129aa9);
    level.pap_machine.zbarrier thread function_a8c41b9();
    level.pap_machine.zbarrier namespace_d0ad3850::set_state_power_on();
    e_clip = getent("pap_" + var_4ff1b6c0.script_noteworthy + "_clip", "targetname");
    e_clip notsolid();
    exploder::exploder(var_6eb9e3e5[var_4ff1b6c0.script_noteworthy]);
}

// Namespace namespace_155a700c
// Params 0, eflags: 0x1 linked
// namespace_155a700c<file_0>::function_566e5eb4
// Checksum 0x8fb752ea, Offset: 0x1f90
// Size: 0x102
function function_566e5eb4() {
    var_cd9abb80 = getentarray(self.target, "targetname");
    n_loc_index = 0;
    foreach (var_c790d258 in var_cd9abb80) {
        var_b9d22a4b = level.var_1c602ba8[n_loc_index];
        n_loc_index++;
        if (n_loc_index >= level.var_1c602ba8.size) {
            n_loc_index = 0;
        }
        var_c790d258 thread function_6591f9c7(var_b9d22a4b);
    }
}

// Namespace namespace_155a700c
// Params 0, eflags: 0x1 linked
// namespace_155a700c<file_0>::function_335f66d5
// Checksum 0xe982f39b, Offset: 0x20a0
// Size: 0x92
function function_335f66d5() {
    wait(0.25);
    foreach (var_c790d258 in level.var_c9f5f61) {
        var_c790d258 delete();
    }
}

// Namespace namespace_155a700c
// Params 1, eflags: 0x1 linked
// namespace_155a700c<file_0>::function_6591f9c7
// Checksum 0xe1245b86, Offset: 0x2140
// Size: 0x1bc
function function_6591f9c7(var_b9d22a4b) {
    level.var_e1ee8457++;
    str_scenedef = "p7_fxanim_zm_castle_pap_part" + self.script_int + "_depart_bundle";
    scene::play(str_scenedef, self);
    var_f7c4d7b5 = "s_pap_chunk_" + var_b9d22a4b.script_noteworthy + self.script_int;
    var_5e73f984 = struct::get(var_f7c4d7b5, "targetname");
    self.origin = var_5e73f984.origin;
    self.angles = var_5e73f984.angles;
    str_scenedef = "p7_fxanim_zm_castle_pap_part" + self.script_int + "_arrive_bundle";
    scene::play(str_scenedef, self);
    foreach (var_4ff1b6c0 in level.var_1c602ba8) {
        if (var_4ff1b6c0.script_noteworthy == var_b9d22a4b.script_noteworthy) {
            self.targetname = var_4ff1b6c0.target;
        }
    }
    level.var_e1ee8457--;
}

// Namespace namespace_155a700c
// Params 0, eflags: 0x1 linked
// namespace_155a700c<file_0>::function_a8c41b9
// Checksum 0xadd30e0e, Offset: 0x2308
// Size: 0x108
function function_a8c41b9() {
    var_40cae301 = [];
    var_40cae301[0] = "fxexp_801";
    var_40cae301[1] = "fxexp_802";
    var_40cae301[2] = "fxexp_800";
    while (true) {
        while (self.state != "take_gun" && self.state != "eject_gun") {
            wait(0.05);
        }
        exploder::exploder(var_40cae301[level.var_2eccab0d]);
        while (self.state == "take_gun" || self.state == "eject_gun") {
            wait(0.05);
        }
        exploder::exploder_stop(var_40cae301[level.var_2eccab0d]);
    }
}

// Namespace namespace_155a700c
// Params 0, eflags: 0x1 linked
// namespace_155a700c<file_0>::function_99664e8
// Checksum 0xe508b05d, Offset: 0x2418
// Size: 0x192
function function_99664e8() {
    str_msg = %;
    str_msg = self.stub.hint_string;
    if (level.var_e1ee8457 > 0) {
        self sethintstring(%ZM_CASTLE_PAP_TP_UNAVAILABLE);
        return 0;
    }
    if (self.stub.parent_struct.activated === 1) {
        var_32a8ab39 = [];
        var_32a8ab39[0] = "under";
        var_32a8ab39[1] = "rocket";
        var_32a8ab39[2] = "roof";
        if (isdefined(level.var_2eccab0d) && self.stub.parent_struct.script_noteworthy == var_32a8ab39[level.var_2eccab0d]) {
            self sethintstring("");
        } else if (!isdefined(level.var_2eccab0d)) {
            self sethintstring("");
        } else {
            self sethintstring(%ZM_CASTLE_PAP_TP_AWAY);
        }
        return 0;
    }
    self sethintstring(%ZM_CASTLE_PAP_TP_ACTIVATE);
    return 1;
}

/#

    // Namespace namespace_155a700c
    // Params 0, eflags: 0x1 linked
    // namespace_155a700c<file_0>::function_2449723c
    // Checksum 0x9ff21716, Offset: 0x25b8
    // Size: 0x38
    function function_2449723c() {
        if (isdefined(self.var_8665ab89)) {
            if (self.var_8665ab89 == gettime()) {
                return 1;
            }
        }
        self.var_8665ab89 = gettime();
        return 0;
    }

    // Namespace namespace_155a700c
    // Params 0, eflags: 0x1 linked
    // namespace_155a700c<file_0>::function_42a3de0d
    // Checksum 0xbef82ce1, Offset: 0x25f8
    // Size: 0x64
    function function_42a3de0d() {
        level flagsys::wait_till("fxexp_805");
        wait(1);
        zm_devgui::add_custom_devgui_callback(&function_f04119b5);
        adddebugcommand("fxexp_805");
    }

    // Namespace namespace_155a700c
    // Params 1, eflags: 0x1 linked
    // namespace_155a700c<file_0>::function_f04119b5
    // Checksum 0x239f4b1c, Offset: 0x2668
    // Size: 0xce
    function function_f04119b5(cmd) {
        switch (cmd) {
        case 8:
            if (level function_2449723c()) {
                return 1;
            }
            level.var_1e4d46e3 = 10;
            wait(1);
            pap_machine = getent("fxexp_805", "fxexp_805");
            level.var_54cd8d06 = level.var_1c602ba8[0];
            array::thread_all(level.players, &function_b9cca08f, pap_machine);
            return 1;
        }
        return 0;
    }

#/
