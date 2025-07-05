#using scripts/codescripts/struct;
#using scripts/shared/ai/margwa;
#using scripts/shared/ai/zombie_utility;
#using scripts/shared/animation_shared;
#using scripts/shared/array_shared;
#using scripts/shared/callbacks_shared;
#using scripts/shared/clientfield_shared;
#using scripts/shared/exploder_shared;
#using scripts/shared/flag_shared;
#using scripts/shared/laststand_shared;
#using scripts/shared/math_shared;
#using scripts/shared/system_shared;
#using scripts/shared/util_shared;
#using scripts/zm/_zm_ai_margwa;
#using scripts/zm/_zm_ai_raps;
#using scripts/zm/_zm_audio;
#using scripts/zm/_zm_equipment;
#using scripts/zm/_zm_laststand;
#using scripts/zm/_zm_score;
#using scripts/zm/_zm_timer;
#using scripts/zm/_zm_unitrigger;
#using scripts/zm/_zm_utility;
#using scripts/zm/_zm_weap_glaive;
#using scripts/zm/_zm_weapons;
#using scripts/zm/zm_zod_smashables;
#using scripts/zm/zm_zod_util;
#using scripts/zm/zm_zod_vo;

#using_animtree("generic");

#namespace zm_zod_sword;

// Namespace zm_zod_sword
// Params 0, eflags: 0x2
// Checksum 0x9e699491, Offset: 0xdf0
// Size: 0x3c
function autoexec __init__sytem__() {
    system::register("zm_zod_sword", &__init__, &__main__, undefined);
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0x48242844, Offset: 0xe38
// Size: 0x4b4
function __init__() {
    clientfield::register("scriptmover", "zod_egg_glow", 1, 1, "int");
    clientfield::register("scriptmover", "zod_egg_soul", 1, 1, "int");
    clientfield::register("scriptmover", "sword_statue_glow", 1, 1, "int");
    n_bits = getminbitcountfornum(5);
    clientfield::register("toplayer", "magic_circle_state_0", 1, n_bits, "int");
    clientfield::register("toplayer", "magic_circle_state_1", 1, n_bits, "int");
    clientfield::register("toplayer", "magic_circle_state_2", 1, n_bits, "int");
    clientfield::register("toplayer", "magic_circle_state_3", 1, n_bits, "int");
    n_bits = getminbitcountfornum(9);
    clientfield::register("world", "keeper_quest_state_0", 1, n_bits, "int");
    clientfield::register("world", "keeper_quest_state_1", 1, n_bits, "int");
    clientfield::register("world", "keeper_quest_state_2", 1, n_bits, "int");
    clientfield::register("world", "keeper_quest_state_3", 1, n_bits, "int");
    n_bits = getminbitcountfornum(4);
    clientfield::register("world", "keeper_egg_location_0", 1, n_bits, "int");
    clientfield::register("world", "keeper_egg_location_1", 1, n_bits, "int");
    clientfield::register("world", "keeper_egg_location_2", 1, n_bits, "int");
    clientfield::register("world", "keeper_egg_location_3", 1, n_bits, "int");
    clientfield::register("toplayer", "ZM_ZOD_UI_LVL1_SWORD_PICKUP", 1, 1, "int");
    clientfield::register("toplayer", "ZM_ZOD_UI_LVL1_EGG_PICKUP", 1, 1, "int");
    clientfield::register("toplayer", "ZM_ZOD_UI_LVL2_SWORD_PICKUP", 1, 1, "int");
    clientfield::register("toplayer", "ZM_ZOD_UI_LVL2_EGG_PICKUP", 1, 1, "int");
    callback::on_connect(&on_player_connect);
    callback::on_disconnect(&on_player_disconnect);
    callback::on_spawned(&on_player_spawned);
    zm_zod_util::function_2d5dfb29(&function_2d5dfb29);
    zm_zod_util::function_658879b1(&function_f64be40d);
    /#
        level thread function_9b87ec91();
    #/
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0x53c95607, Offset: 0x12f8
// Size: 0xac
function function_541cb3c4() {
    var_5a776f0d = getent("initial_egg_statue", "script_noteworthy");
    level.sword_quest.eggs[self.characterindex] setmodel(level.sword_quest.var_cc348d7d[0]);
    self function_abf3df35(var_5a776f0d.var_a72790d7);
    self clientfield::set_player_uimodel("zmInventory.player_sword_quest_egg_state", 0);
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0x30cede2d, Offset: 0x13b0
// Size: 0x24
function function_7f334fcd() {
    self clientfield::set_player_uimodel("zmInventory.player_sword_quest_egg_state", 0);
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x0
// Checksum 0x97de3266, Offset: 0x13e0
// Size: 0x3c
function function_ef548b70(b_show) {
    level.sword_quest.var_979d4987[self.characterindex] show();
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0x738c8ebc, Offset: 0x1428
// Size: 0x76c
function __main__() {
    level.sword_quest = spawnstruct();
    level.sword_quest.weapons = [];
    for (i = 0; i < 4; i++) {
        level.sword_quest.weapons[i] = [];
        level.sword_quest.weapons[i][1] = getweapon("glaive_apothicon" + "_" + i);
        level.sword_quest.weapons[i][2] = getweapon("glaive_keeper" + "_" + i);
        foreach (wpn in level.sword_quest.weapons[i]) {
            assert(wpn != level.weaponnone);
        }
    }
    level.sword_quest.var_2855c5c = getentarray("sword_upgrade_statue", "targetname");
    level.sword_quest.var_e91b9e85 = [];
    level.sword_quest.var_e91b9e85[0] = "wpn_t7_zmb_zod_sword1_box_no_egg_world";
    level.sword_quest.var_e91b9e85[1] = "wpn_t7_zmb_zod_sword1_det_no_egg_world";
    level.sword_quest.var_e91b9e85[2] = "wpn_t7_zmb_zod_sword1_fem_no_egg_world";
    level.sword_quest.var_e91b9e85[3] = "wpn_t7_zmb_zod_sword1_mag_no_egg_world";
    level.sword_quest.var_cc348d7d = array("zm_zod_sword_egg_apothicon_s1", "zm_zod_sword_egg_apothicon_s2", "zm_zod_sword_egg_apothicon_s3", "zm_zod_sword_egg_apothicon_s4", "zm_zod_sword_egg_apothicon_s5");
    for (var_a72790d7 = 0; var_a72790d7 < level.sword_quest.var_2855c5c.size; var_a72790d7++) {
        e_statue = level.sword_quest.var_2855c5c[var_a72790d7];
        if (e_statue.script_noteworthy === "initial_egg_statue") {
            e_statue.var_9f9da194 = array("j_egg_location_01", "j_egg_location_02", "j_egg_location_03", "j_egg_location_04");
            e_statue.var_13eaa54c = array("j_sword_location_01", "j_sword_location_02", "j_sword_location_03", "j_sword_location_04");
            level.sword_quest.eggs = [];
            foreach (str_tag in e_statue.var_9f9da194) {
                v_origin = e_statue gettagorigin(str_tag);
                v_angles = e_statue gettagangles(str_tag);
                var_42bd22b8 = util::spawn_model(level.sword_quest.var_cc348d7d[0], v_origin, v_angles);
                if (!isdefined(level.sword_quest.eggs)) {
                    level.sword_quest.eggs = [];
                } else if (!isarray(level.sword_quest.eggs)) {
                    level.sword_quest.eggs = array(level.sword_quest.eggs);
                }
                level.sword_quest.eggs[level.sword_quest.eggs.size] = var_42bd22b8;
            }
            level.sword_quest.var_979d4987 = [];
            for (i = 0; i < e_statue.var_13eaa54c.size; i++) {
                v_origin = e_statue gettagorigin(e_statue.var_13eaa54c[i]);
                v_angles = e_statue gettagangles(e_statue.var_13eaa54c[i]);
                e_sword = util::spawn_model(level.sword_quest.var_e91b9e85[i], v_origin, v_angles);
                level.sword_quest.var_979d4987[i] = e_sword;
                level.sword_quest.var_979d4987[i].var_c9c683e8 = 0;
            }
        } else {
            e_statue.var_9f9da194 = array("j_sword_egg_01", "j_sword_egg_02", "j_sword_egg_03", "j_sword_egg_04");
        }
        e_statue.var_a72790d7 = var_a72790d7;
        s_trigger_pos = struct::get(e_statue.target, "targetname");
        if (isdefined(s_trigger_pos.target)) {
            zm_zod_smashables::add_callback(s_trigger_pos.target, &function_2c009d2e, e_statue);
            continue;
        }
        level thread function_2c009d2e(e_statue);
    }
    level thread function_6505226c();
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0x8c4b985d, Offset: 0x1ba0
// Size: 0x284
function function_6505226c() {
    level.var_fdda19d8 = spawnstruct();
    level.var_fdda19d8.var_765ff5d4 = [];
    level.var_fdda19d8.var_765ff5d4 = struct::get_array("sword_quest_magic_circle_place", "targetname");
    level flag::wait_till("ritual_pap_complete");
    for (i = 0; i < 4; i++) {
        foreach (player in level.players) {
            player clientfield::set_to_player("magic_circle_state_" + i, 1);
        }
        s_loc = struct::get("keeper_spirit_" + i, "targetname");
        function_aa4e4fa4(s_loc, i);
    }
    level flag::init("magic_circle_in_progress");
    var_5306b772 = struct::get_array("sword_quest_magic_circle_place", "targetname");
    foreach (var_768e52e3 in var_5306b772) {
        function_41395dc5(var_768e52e3, var_768e52e3.script_int);
    }
    level thread function_e9bb9efa();
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0x4d640bbc, Offset: 0x1e30
// Size: 0x19e
function function_e9bb9efa() {
    while (true) {
        level util::waittill_any("between_round_over", "magic_circle_failed");
        foreach (player in level.players) {
            for (i = 0; i < 4; i++) {
                var_a5fe74e4 = player clientfield::get_to_player("magic_circle_state_" + i);
                if (var_a5fe74e4 === 0 && !player function_a7e71a86(i)) {
                    player clientfield::set_to_player("magic_circle_state_" + i, 1);
                    continue;
                }
                player clientfield::set_to_player("magic_circle_state_" + i, 0);
            }
            player flag::clear("magic_circle_wait_for_round_completed");
        }
    }
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x0
// Checksum 0x6ca21d4b, Offset: 0x1fd8
// Size: 0x8e
function function_2f36dd89(var_6b55cb3b) {
    if (!isdefined(var_6b55cb3b)) {
        self flag::set("magic_circle_wait_for_round_completed");
    }
    for (i = 0; i < 4; i++) {
        if (var_6b55cb3b !== i) {
            self clientfield::set_to_player("magic_circle_state_" + i, 0);
        }
    }
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0xafb02534, Offset: 0x2070
// Size: 0x84
function function_ed28cc7() {
    self endon(#"disconnect");
    level clientfield::set("keeper_quest_state_" + self.characterindex, 0);
    self waittill(#"hash_1867e603");
    level flag::wait_till("ritual_pap_complete");
    level clientfield::set("keeper_quest_state_" + self.characterindex, 1);
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x0
// Checksum 0x3cdf4341, Offset: 0x2100
// Size: 0xb4
function function_6c2f52e5(n_char_index) {
    players = getplayers();
    foreach (player in players) {
        if (player.characterindex === n_char_index) {
            return player;
        }
    }
}

// Namespace zm_zod_sword
// Params 2, eflags: 0x0
// Checksum 0x47345c5b, Offset: 0x21c0
// Size: 0x1e4
function function_aa4e4fa4(s_loc, n_char_index) {
    width = -128;
    height = -128;
    length = -128;
    s_loc.unitrigger_stub = spawnstruct();
    s_loc.unitrigger_stub.origin = s_loc.origin;
    s_loc.unitrigger_stub.angles = s_loc.angles;
    s_loc.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_loc.unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_loc.unitrigger_stub.script_width = width;
    s_loc.unitrigger_stub.script_height = height;
    s_loc.unitrigger_stub.script_length = length;
    s_loc.unitrigger_stub.require_look_at = 0;
    s_loc.unitrigger_stub.n_char_index = n_char_index;
    zm_unitrigger::unitrigger_force_per_player_triggers(s_loc.unitrigger_stub, 1);
    s_loc.unitrigger_stub.prompt_and_visibility_func = &function_ac03c228;
    zm_unitrigger::register_static_unitrigger(s_loc.unitrigger_stub, &function_4a3c552c);
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x0
// Checksum 0x9454219e, Offset: 0x23b0
// Size: 0xe0
function function_ac03c228(player) {
    b_can_see = 1;
    if (isdefined(player.beastmode) && player.beastmode) {
        b_can_see = 0;
    }
    if (b_can_see) {
        self setvisibletoplayer(player);
    } else {
        self setinvisibletoplayer(player);
    }
    var_a3338832 = self function_4a703d7c(player);
    if (isdefined(self.hint_string)) {
        self sethintstring(self.hint_string);
    }
    return var_a3338832;
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x0
// Checksum 0x400f16b8, Offset: 0x2498
// Size: 0x146
function function_4a703d7c(player) {
    n_char_index = self.stub.n_char_index;
    var_a5fe74e4 = level clientfield::get("keeper_quest_state_" + n_char_index);
    b_result = 0;
    if (isdefined(player.beastmode) && player.beastmode) {
        self.hint_string = %;
    } else if (var_a5fe74e4 === 2 || var_a5fe74e4 === 3) {
        self.hint_string = %;
    } else if (player.characterindex !== n_char_index) {
        self.hint_string = %ZM_ZOD_KEEPER_EGG_CANNOT_PICKUP;
    } else if (var_a5fe74e4 === 1 && player function_962dc2e9()) {
        self.hint_string = %ZM_ZOD_KEEPER_EGG_PICKUP;
        b_result = 1;
    }
    return b_result;
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0x10e50846, Offset: 0x25e8
// Size: 0xc4
function function_4a3c552c() {
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
        if (player.characterindex !== self.stub.n_char_index) {
            continue;
        }
        level thread function_5356f68f(self, player);
        break;
    }
}

// Namespace zm_zod_sword
// Params 2, eflags: 0x0
// Checksum 0xc2486f8c, Offset: 0x26b8
// Size: 0x12c
function function_5356f68f(trig, player) {
    level clientfield::set("keeper_quest_state_" + trig.stub.n_char_index, 2);
    trig zm_zod_util::function_c1947ff7();
    player clientfield::set_player_uimodel("zmInventory.player_sword_quest_completed_level_1", 1);
    player clientfield::set_player_uimodel("zmInventory.player_sword_quest_egg_state", 1);
    player thread zm_zod_util::function_55f114f9("zmInventory.widget_egg", 3.5);
    player thread zm_zod_util::function_69e0fb83("ZM_ZOD_UI_LVL2_EGG_PICKUP", 3.5);
    player playsound("zmb_zod_egg2_pickup");
    player thread zm_zod_vo::function_9bd30516();
}

// Namespace zm_zod_sword
// Params 2, eflags: 0x0
// Checksum 0x685ecc7e, Offset: 0x27f0
// Size: 0x1e4
function function_41395dc5(s_loc, n_char_index) {
    width = -128;
    height = -128;
    length = -128;
    s_loc.unitrigger_stub = spawnstruct();
    s_loc.unitrigger_stub.origin = s_loc.origin;
    s_loc.unitrigger_stub.angles = s_loc.angles;
    s_loc.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_loc.unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_loc.unitrigger_stub.script_width = width;
    s_loc.unitrigger_stub.script_height = height;
    s_loc.unitrigger_stub.script_length = length;
    s_loc.unitrigger_stub.require_look_at = 0;
    s_loc.unitrigger_stub.n_char_index = n_char_index;
    zm_unitrigger::unitrigger_force_per_player_triggers(s_loc.unitrigger_stub, 1);
    s_loc.unitrigger_stub.prompt_and_visibility_func = &function_329553cb;
    zm_unitrigger::register_static_unitrigger(s_loc.unitrigger_stub, &function_bd291c1d);
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x0
// Checksum 0xc211e321, Offset: 0x29e0
// Size: 0xc0
function function_329553cb(player) {
    self setinvisibletoplayer(player);
    if (isdefined(self.stub.activated) && self.stub.activated || !player function_962dc2e9()) {
        return 0;
    }
    var_a3338832 = self function_74e5c19(player);
    if (isdefined(self.hint_string)) {
        self sethintstring(self.hint_string);
    }
    return var_a3338832;
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x0
// Checksum 0xd9abc4ab, Offset: 0x2aa8
// Size: 0x1d0
function function_74e5c19(player) {
    n_char_index = self.stub.n_char_index;
    var_2ce85e2b = player function_a7e71a86(n_char_index);
    var_efb73168 = 1;
    var_bca28fa8 = 0;
    var_a5fe74e4 = level clientfield::get("keeper_quest_state_" + player.characterindex);
    if (var_a5fe74e4 === 2 || var_a5fe74e4 === 3) {
        var_bca28fa8 = 1;
    }
    if (var_2ce85e2b) {
        var_efb73168 = 0;
    }
    if (!var_bca28fa8) {
        var_efb73168 = 0;
    }
    if (isdefined(player.beastmode) && player.beastmode) {
        var_efb73168 = 0;
    }
    if (level flag::get("magic_circle_in_progress")) {
        var_efb73168 = 0;
    }
    if (player flag::get("magic_circle_wait_for_round_completed")) {
        var_efb73168 = 0;
    }
    if (var_efb73168) {
        self.hint_string = %ZM_ZOD_SWORD_DEFEND_PLACE;
        self setvisibletoplayer(player);
    } else {
        self.hint_string = "";
        self setinvisibletoplayer(player);
    }
    return var_efb73168;
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0x949973be, Offset: 0x2c80
// Size: 0xf4
function function_bd291c1d() {
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
        if (isdefined(self.stub.activated) && self.stub.activated) {
            continue;
        }
        if (level flag::get("magic_circle_in_progress")) {
            continue;
        }
        level thread function_d747cf54(self.stub, player);
        break;
    }
}

// Namespace zm_zod_sword
// Params 2, eflags: 0x0
// Checksum 0x586180f6, Offset: 0x2d80
// Size: 0x732
function function_d747cf54(var_91089b66, player) {
    level flag::set("magic_circle_in_progress");
    var_91089b66 notify(#"hash_15d0dfe4");
    var_91089b66 endon(#"hash_15d0dfe4");
    level endon(#"magic_circle_failed");
    var_91089b66.activated = 1;
    var_181b74a5 = var_91089b66.n_char_index;
    var_91089b66.player = player;
    foreach (e_player in level.players) {
        e_player function_2f36dd89(var_181b74a5);
    }
    level clientfield::set("keeper_egg_location_" + player.characterindex, var_181b74a5);
    level clientfield::set("keeper_quest_state_" + player.characterindex, 4);
    foreach (e_player in level.players) {
        e_player clientfield::set_to_player("magic_circle_state_" + var_181b74a5, 2);
    }
    zm_unitrigger::run_visibility_function_for_all_triggers();
    player playsound("zmb_zod_egg_place");
    player clientfield::set_player_uimodel("zmInventory.widget_egg", 0);
    str_endon = "magic_circle_" + var_181b74a5 + "_off";
    player thread function_278154b(var_91089b66.origin, var_181b74a5, 32, 0.01, str_endon);
    level thread function_47563199(var_91089b66, player, str_endon);
    level thread function_413de655(var_91089b66, player, str_endon);
    n_charges = player function_b7af29e0();
    if (n_charges == 0) {
        var_a757b9ed = 1;
    } else {
        var_a757b9ed = 2;
    }
    var_73fc403f = 0;
    var_91089b66.var_87b7360 = 0;
    var_fb35e9c2 = struct::get_array("sword_quest_margwa_spawnpoint", "targetname");
    player.var_c9265b2e = 1;
    player clientfield::set_player_uimodel("zmhud.swordEnergy", player.var_c9265b2e);
    player gadgetpowerset(0, 100);
    player clientfield::increment_uimodel("zmhud.swordChargeUpdate");
    while (true) {
        var_91089b66.var_bc9468eb = [];
        var_91089b66.var_2330d68c = array::filter(var_fb35e9c2, 0, &function_ed69c2a1, var_181b74a5);
        var_90e5cd72 = 0;
        while (var_90e5cd72 < 2 && var_73fc403f < var_a757b9ed) {
            var_91089b66.var_87b7360++;
            level thread function_7922af5f(player, var_91089b66, var_90e5cd72, str_endon);
            var_90e5cd72++;
            var_73fc403f++;
            wait 0.05;
        }
        while (var_91089b66.var_87b7360 > 0) {
            wait 0.05;
        }
        if (player.var_fdda19d8.kills[var_181b74a5] == var_a757b9ed) {
            level notify(str_endon);
            player.var_fdda19d8.var_db999762[var_181b74a5] = var_a757b9ed;
            n_charges = player function_b7af29e0();
            player clientfield::set_player_uimodel("zmInventory.player_sword_quest_egg_state", 1 + n_charges);
            player thread zm_zod_util::function_55f114f9("zmInventory.widget_egg", 3.5);
            player function_2f36dd89();
            level flag::clear("magic_circle_in_progress");
            if (n_charges == 4) {
                player.var_fdda19d8.var_b11b4a7a = 1;
                level clientfield::set("keeper_quest_state_" + player.characterindex, 5);
                wait 1;
                level clientfield::set("keeper_quest_state_" + player.characterindex, 6);
                wait 1;
                s_loc = struct::get("keeper_spirit_" + player.characterindex, "targetname");
                function_6f69a416(s_loc, player.characterindex);
            } else {
                level clientfield::set("keeper_quest_state_" + player.characterindex, 3);
            }
            var_91089b66.activated = 0;
            return;
        }
    }
}

// Namespace zm_zod_sword
// Params 4, eflags: 0x0
// Checksum 0x3dcf4e16, Offset: 0x34c0
// Size: 0x2cc
function function_7922af5f(player, var_91089b66, index, str_endon) {
    level endon(str_endon);
    level endon(#"magic_circle_failed");
    var_181b74a5 = var_91089b66.n_char_index;
    while (true) {
        var_cf8830de = array::random(var_91089b66.var_2330d68c);
        arrayremovevalue(var_91089b66.var_2330d68c, var_cf8830de);
        var_91089b66.var_bc9468eb[index] = namespace_ca5ef87d::function_8a0708c2(var_cf8830de);
        var_91089b66.var_bc9468eb[index].no_powerups = 1;
        var_91089b66.var_bc9468eb[index].var_89905c65 = 1;
        var_91089b66.var_bc9468eb[index].deathpoints_already_given = 1;
        var_91089b66.var_bc9468eb[index].var_2d5d7413 = 1;
        var_91089b66.var_bc9468eb[index].var_de609f65 = player;
        var_91089b66.var_bc9468eb[index] waittill(#"death", attacker, mod, var_13b27531);
        if (isdefined(var_13b27531 === level.sword_quest.weapons[player.characterindex][1])) {
            player.var_fdda19d8.kills[var_181b74a5]++;
            var_91089b66.var_87b7360--;
            break;
        }
        if (!isdefined(var_91089b66.var_2330d68c)) {
            var_91089b66.var_2330d68c = [];
        } else if (!isarray(var_91089b66.var_2330d68c)) {
            var_91089b66.var_2330d68c = array(var_91089b66.var_2330d68c);
        }
        var_91089b66.var_2330d68c[var_91089b66.var_2330d68c.size] = var_cf8830de;
        wait 4;
    }
}

// Namespace zm_zod_sword
// Params 3, eflags: 0x0
// Checksum 0x8d107198, Offset: 0x3798
// Size: 0x20c
function function_47563199(var_91089b66, player, str_endon) {
    level endon(str_endon);
    var_9c7aaa62 = player function_b7af29e0();
    var_181b74a5 = var_91089b66.n_char_index;
    n_char_index = player.characterindex;
    player util::waittill_any("entering_last_stand", "disconnect");
    level notify(#"hash_278154b");
    level notify(#"magic_circle_failed");
    for (i = 0; i < var_91089b66.var_bc9468eb.size; i++) {
        if (isalive(var_91089b66.var_bc9468eb[i])) {
            var_91089b66.var_bc9468eb[i] kill();
        }
    }
    level flag::clear("magic_circle_in_progress");
    level clientfield::set("keeper_egg_location_" + n_char_index, var_181b74a5);
    level clientfield::set("keeper_quest_state_" + n_char_index, 3);
    player.var_fdda19d8.kills[var_181b74a5] = 0;
    var_91089b66.activated = 0;
    var_91089b66.player = 0;
    level flag::clear("magic_circle_in_progress");
}

// Namespace zm_zod_sword
// Params 3, eflags: 0x0
// Checksum 0x7b1f5775, Offset: 0x39b0
// Size: 0xac
function function_413de655(var_91089b66, player, str_endon) {
    player endon(#"disconnect");
    level endon(str_endon);
    player waittill(#"bled_out");
    n_charges = player function_b7af29e0();
    player clientfield::set_player_uimodel("zmInventory.player_sword_quest_egg_state", 1 + n_charges);
    player thread zm_zod_util::function_55f114f9("zmInventory.widget_egg", 3.5);
}

// Namespace zm_zod_sword
// Params 5, eflags: 0x0
// Checksum 0x41b10a0d, Offset: 0x3a68
// Size: 0x3a0
function function_278154b(var_a246d2ec, var_181b74a5, n_radius, n_rate, str_endon) {
    level notify(#"hash_278154b");
    level endon(#"hash_278154b");
    level endon(str_endon);
    n_dist_max = n_radius * n_radius;
    while (true) {
        var_2108630b = 0;
        if (isdefined(self.var_c9265b2e)) {
            v_player_origin = self getorigin();
            if (isdefined(v_player_origin)) {
                var_30c97f9b = distancesquared(var_a246d2ec, v_player_origin);
                if (var_30c97f9b <= n_dist_max) {
                    var_2108630b = 1;
                    var_52baa43a = self zm_weap_glaive::function_c3226e09(1);
                    slot = self gadgetgetslot(var_52baa43a);
                    temp = self gadgetpowerget(slot) / 100;
                    temp += 0.01;
                    temp = math::clamp(temp, 0, 1);
                    self gadgetpowerset(slot, 100 * temp);
                    self.var_c9265b2e = temp;
                    self clientfield::set_player_uimodel("zmhud.swordEnergy", self.var_c9265b2e);
                    if (!isdefined(self.var_88d65f) || !(isdefined(self.var_88d65f) && self.var_88d65f)) {
                        self.var_88d65f = 1;
                        self thread function_9867bf60(var_a246d2ec, n_dist_max, str_endon);
                    }
                }
            }
        }
        if (var_2108630b) {
            foreach (e_player in level.players) {
                e_player clientfield::set_to_player("magic_circle_state_" + var_181b74a5, 3);
            }
            var_2108630b = 0;
        } else {
            foreach (e_player in level.players) {
                e_player clientfield::set_to_player("magic_circle_state_" + var_181b74a5, 2);
            }
        }
        wait 0.05;
    }
}

// Namespace zm_zod_sword
// Params 3, eflags: 0x0
// Checksum 0xe81f5e02, Offset: 0x3e10
// Size: 0xa4
function function_9867bf60(var_a246d2ec, n_dist_max, str_endon) {
    self endon(#"disconnect");
    level endon(#"hash_278154b");
    level endon(str_endon);
    self playsoundtoplayer("zmb_zod_sword2_charge", self);
    while (distancesquared(var_a246d2ec, self.origin) <= n_dist_max) {
        wait 0.1;
        if (!isdefined(self)) {
            return;
        }
    }
    self.var_88d65f = 0;
}

// Namespace zm_zod_sword
// Params 2, eflags: 0x0
// Checksum 0x225976b3, Offset: 0x3ec0
// Size: 0x48
function function_ed69c2a1(e_entity, n_script_int) {
    if (!isdefined(e_entity.script_int) || e_entity.script_int != n_script_int) {
        return false;
    }
    return true;
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0x936c4f65, Offset: 0x3f10
// Size: 0x6c
function function_b7af29e0() {
    n_charges = 0;
    for (i = 0; i < 4; i++) {
        if (self function_a7e71a86(i)) {
            n_charges += 1;
        }
    }
    return n_charges;
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x0
// Checksum 0xe02478b5, Offset: 0x3f88
// Size: 0xc4
function function_59d9e12a(n_index) {
    var_5306b772 = struct::get_array("sword_quest_magic_circle_place", "targetname");
    foreach (var_768e52e3 in var_5306b772) {
        if (var_768e52e3.script_int === n_index) {
            return var_768e52e3;
        }
    }
}

// Namespace zm_zod_sword
// Params 2, eflags: 0x0
// Checksum 0x7f90678a, Offset: 0x4058
// Size: 0xd4
function function_96ae1a10(var_181b74a5, n_character_index) {
    var_79d1dcf6 = struct::get_array("sword_quest_magic_circle_player_" + n_character_index, "targetname");
    foreach (var_87367d4f in var_79d1dcf6) {
        if (var_87367d4f.script_int === var_181b74a5) {
            return var_87367d4f;
        }
    }
}

// Namespace zm_zod_sword
// Params 2, eflags: 0x0
// Checksum 0xb76b1c7c, Offset: 0x4138
// Size: 0x1e4
function function_6f69a416(s_loc, n_char_index) {
    width = -128;
    height = -128;
    length = -128;
    s_loc.unitrigger_stub = spawnstruct();
    s_loc.unitrigger_stub.origin = s_loc.origin;
    s_loc.unitrigger_stub.angles = s_loc.angles;
    s_loc.unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
    s_loc.unitrigger_stub.cursor_hint = "HINT_NOICON";
    s_loc.unitrigger_stub.script_width = width;
    s_loc.unitrigger_stub.script_height = height;
    s_loc.unitrigger_stub.script_length = length;
    s_loc.unitrigger_stub.require_look_at = 0;
    s_loc.unitrigger_stub.n_char_index = n_char_index;
    zm_unitrigger::unitrigger_force_per_player_triggers(s_loc.unitrigger_stub, 1);
    s_loc.unitrigger_stub.prompt_and_visibility_func = &function_8ca48fdc;
    zm_unitrigger::register_static_unitrigger(s_loc.unitrigger_stub, &function_2bca570);
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x0
// Checksum 0x3d7b4dbd, Offset: 0x4328
// Size: 0x98
function function_8ca48fdc(player) {
    self setinvisibletoplayer(player);
    var_a3338832 = self function_c722bbbb(player);
    if (isdefined(self.hint_string)) {
        self sethintstring(self.hint_string);
    }
    if (var_a3338832) {
        self setvisibletoplayer(player);
    }
    return var_a3338832;
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x0
// Checksum 0x48006ef4, Offset: 0x43c8
// Size: 0x156
function function_c722bbbb(player) {
    if (isdefined(player.beastmode) && player.beastmode || player flag::get("waiting_for_upgraded_sword")) {
        self.hint_string = %;
        return false;
    }
    n_char_index = self.stub.n_char_index;
    var_a5fe74e4 = level clientfield::get("keeper_quest_state_" + n_char_index);
    if (var_a5fe74e4 === 6 && player function_962dc2e9(1)) {
        self.hint_string = %ZM_ZOD_KEEPER_SWORD_PLACE;
        return true;
    }
    if (var_a5fe74e4 === 7) {
        self.hint_string = %ZM_ZOD_KEEPER_SWORD_PICKUP;
        return true;
    }
    if (player.characterindex === n_char_index) {
        self.hint_string = %ZM_ZOD_KEEPER_EGG_CANNOT_PICKUP;
        return false;
    }
    self.hint_string = %;
    return false;
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0x4806e752, Offset: 0x4528
// Size: 0x144
function function_2bca570() {
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
        if (player.characterindex !== self.stub.n_char_index) {
            continue;
        }
        var_a5fe74e4 = level clientfield::get("keeper_quest_state_" + self.stub.n_char_index);
        if (var_a5fe74e4 !== 6 && var_a5fe74e4 !== 7) {
            continue;
        }
        if (player flag::get("waiting_for_upgraded_sword")) {
            continue;
        }
        level thread function_e5a7a0eb(self.stub, player, var_a5fe74e4);
        break;
    }
}

// Namespace zm_zod_sword
// Params 3, eflags: 0x0
// Checksum 0x9d5352c0, Offset: 0x4678
// Size: 0x2ce
function function_e5a7a0eb(stub, player, var_a5fe74e4) {
    if (var_a5fe74e4 == 6) {
        player function_c6e90f6e();
        player clientfield::set_player_uimodel("zmInventory.widget_egg", 0);
        level clientfield::set("keeper_quest_state_" + player.characterindex, 7);
        player flag::set("waiting_for_upgraded_sword");
        stub zm_zod_util::function_c1947ff7();
        wait 2;
        player flag::clear("waiting_for_upgraded_sword");
        stub zm_zod_util::function_c1947ff7();
        return;
    }
    if (var_a5fe74e4 == 7) {
        level clientfield::set("keeper_quest_state_" + player.characterindex, 8);
        player thread zm_zod_util::function_69e0fb83("ZM_ZOD_UI_LVL2_SWORD_PICKUP", 3.5);
        player function_8ae67230(2, 1);
        switch (player.characterindex) {
        case 0:
            level.sword_quest.var_979d4987[player.characterindex] setmodel("wpn_t7_zmb_zod_sword2_box_world");
            break;
        case 1:
            level.sword_quest.var_979d4987[player.characterindex] setmodel("wpn_t7_zmb_zod_sword2_det_world");
            break;
        case 2:
            level.sword_quest.var_979d4987[player.characterindex] setmodel("wpn_t7_zmb_zod_sword2_fem_world");
            break;
        case 3:
            level.sword_quest.var_979d4987[player.characterindex] setmodel("wpn_t7_zmb_zod_sword2_mag_world");
            break;
        }
    }
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x0
// Checksum 0x990a4625, Offset: 0x4950
// Size: 0x34e
function function_2f31f931(e_player) {
    self setinvisibletoplayer(e_player);
    n_statue = self.stub.var_a72790d7;
    e_statue = level.sword_quest.var_2855c5c[n_statue];
    var_c74a27b4 = !isdefined(e_player.sword_quest.var_f01fc13c);
    var_498e0c8c = e_player function_24978bad(n_statue);
    var_dbab1072 = e_player function_6dc5b484(n_statue);
    var_ea06f721 = e_statue.script_noteworthy === "initial_egg_statue";
    var_c9c683e8 = level.sword_quest.var_979d4987[e_player.characterindex].var_c9c683e8;
    var_5f66b0c7 = level clientfield::get("ee_quest_state");
    var_a5fe74e4 = level clientfield::get("keeper_quest_state_" + e_player.characterindex);
    if (var_a5fe74e4 === 7) {
        self.hint_string = %;
    } else if (e_player.sword_quest.var_b8ad68a0 >= 1) {
        if (var_ea06f721 && !e_player function_962dc2e9() && !var_c9c683e8) {
            if (var_c74a27b4 && e_player.var_b170d6d6 === 0) {
                self setvisibletoplayer(e_player);
                self.hint_string = %ZM_ZOD_SWORD_EGG_PLACE;
            } else if (var_5f66b0c7 < 1) {
                self setvisibletoplayer(e_player);
                self.hint_string = %ZM_ZOD_SWORD_EGG_RETRIEVE;
            } else {
                self.hint_string = %;
            }
        } else {
            self.hint_string = %;
        }
    } else if (var_dbab1072 && var_498e0c8c) {
        self setvisibletoplayer(e_player);
        self.hint_string = %ZM_ZOD_X_TO_PICK_UP_EGG;
    } else if (!var_dbab1072 && !var_498e0c8c && var_c74a27b4) {
        self setvisibletoplayer(e_player);
        self.hint_string = %ZM_ZOD_SWORD_EGG_PLACE;
    } else {
        self.hint_string = %;
    }
    return self.hint_string;
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0x981a10f1, Offset: 0x4ca8
// Size: 0x64
function function_19d7a318() {
    self clientfield::set_player_uimodel("zmInventory.player_sword_quest_egg_state", 0);
    self clientfield::set_player_uimodel("zmInventory.widget_egg", 0);
    self clientfield::set_player_uimodel("zmInventory.widget_sprayer", 0);
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0x390cad7, Offset: 0x4d18
// Size: 0x2fc
function on_player_connect() {
    self function_19d7a318();
    self.var_b170d6d6 = 0;
    self.sword_quest = spawnstruct();
    self.sword_quest.kills = [];
    self.sword_quest.var_b11b4a7a = 0;
    self.var_fdda19d8 = spawnstruct();
    self.var_fdda19d8.kills = [];
    self.var_fdda19d8.var_b11b4a7a = 0;
    self.var_fdda19d8.var_db999762 = [];
    self.sword_quest.var_b8ad68a0 = 0;
    self flag::init("waiting_for_upgraded_sword");
    self flag::init("magic_circle_wait_for_round_completed");
    var_78deabfc = getentarray("sword_upgrade_statue", "targetname");
    foreach (e_statue in var_78deabfc) {
        self.sword_quest.kills[e_statue.var_a72790d7] = 0;
        if (e_statue.script_noteworthy === "initial_egg_statue") {
            self.sword_quest.kills[e_statue.var_a72790d7] = 12;
        }
    }
    self waittill(#"spawned_player");
    function_541cb3c4();
    var_5306b772 = struct::get_array("sword_quest_magic_circle_place", "targetname");
    foreach (var_768e52e3 in var_5306b772) {
        self.var_fdda19d8.kills[var_768e52e3.script_int] = 0;
    }
    self thread function_ed28cc7();
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0x8f298363, Offset: 0x5020
// Size: 0x13c
function on_player_spawned() {
    if (isdefined(self.sword_quest) && self.sword_quest.var_b8ad68a0 < 1) {
        self function_abf3df35(self.sword_quest.var_f01fc13c);
    }
    self function_19d7a318();
    var_a5fe74e4 = level clientfield::get("keeper_quest_state_" + self.characterindex);
    if (var_a5fe74e4 !== 7) {
        function_ef548b70();
    }
    if (isdefined(self.sword_quest) && self.sword_quest.var_b8ad68a0 < 1) {
        function_541cb3c4();
    }
    if (self clientfield::get_to_player("pod_sprayer_held")) {
        return;
    }
    self clientfield::set_player_uimodel("zmInventory.widget_sprayer", 0);
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0x65e1c290, Offset: 0x5168
// Size: 0xac
function on_player_disconnect() {
    var_d95a0cf3 = self.characterindex;
    var_5a776f0d = getent("initial_egg_statue", "script_noteworthy");
    level.sword_quest.eggs[var_d95a0cf3] setmodel(level.sword_quest.var_cc348d7d[0]);
    level.sword_quest.var_979d4987[var_d95a0cf3] show();
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0x21d0b399, Offset: 0x5220
// Size: 0x3c
function function_f64be40d() {
    if (!isdefined(self.var_b170d6d6) && level flag::get("keeper_sword_locker")) {
        self.var_b170d6d6 = 1;
    }
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0xadc16c5, Offset: 0x5268
// Size: 0x1d2
function function_2d5dfb29() {
    foreach (e_statue in level.sword_quest.var_2855c5c) {
        dist_sq = distancesquared(self.origin, e_statue.origin);
        if (isdefined(e_statue.radius)) {
            var_d41ef8d1 = e_statue.radius * e_statue.radius;
        } else {
            var_d41ef8d1 = 589294;
        }
        if (dist_sq < var_d41ef8d1) {
            if (isdefined(self.attacker) && isplayer(self.attacker)) {
                if (self.attacker function_6dc5b484(e_statue.var_a72790d7) && !self.attacker function_24978bad(e_statue.var_a72790d7) && !self.attacker flag::get("in_beastmode")) {
                    self function_3e878547(self.attacker, e_statue);
                }
            }
        }
    }
}

// Namespace zm_zod_sword
// Params 2, eflags: 0x4
// Checksum 0x2e1d2337, Offset: 0x5448
// Size: 0x344
function private function_3e878547(e_player, e_statue) {
    e_player.sword_quest.kills[e_statue.var_a72790d7]++;
    e_player function_67bcb9d9();
    /#
        if (isdefined(e_player.sword_quest.cheat) && e_player.sword_quest.cheat) {
            e_player.sword_quest.kills[e_statue.var_a72790d7] = 12;
        }
    #/
    if (e_player function_24978bad(e_statue.var_a72790d7)) {
        e_statue thread function_ce7bc2ba();
        e_player.sword_quest.var_b11b4a7a = 1;
        var_7201907f = 0;
        foreach (e_statue in level.sword_quest.var_2855c5c) {
            n_kills = e_player.sword_quest.kills[e_statue.var_a72790d7];
            if (n_kills < 12) {
                e_player.sword_quest.var_b11b4a7a = 0;
                continue;
            }
            if (!(e_statue.script_noteworthy === "initial_egg_statue")) {
                var_7201907f++;
            }
        }
        str_model = level.sword_quest.var_cc348d7d[var_7201907f];
        e_model = level.sword_quest.eggs[e_player.characterindex];
        e_model setmodel(str_model);
        e_model clientfield::set("zod_egg_glow", 1);
        e_model playloopsound("zmb_zod_egg_glow_ready", 3);
        if (var_7201907f < 4) {
            e_model playsound("zmb_zod_soul_full");
        } else {
            e_model playsound("zmb_zod_soul_full_final");
        }
    }
    self thread function_dfd0ecb2(e_statue, e_player);
    e_player thread zm_audio::create_and_play_dialog("sword_quest", "charge_egg");
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x4
// Checksum 0x9439d2c0, Offset: 0x5798
// Size: 0x38
function private function_6dc5b484(var_a72790d7) {
    if (!isdefined(self.sword_quest.var_f01fc13c)) {
        return false;
    }
    return self.sword_quest.var_f01fc13c == var_a72790d7;
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x4
// Checksum 0xe4083ac, Offset: 0x57d8
// Size: 0x26
function private function_24978bad(var_a72790d7) {
    return self.sword_quest.kills[var_a72790d7] >= 12;
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x4
// Checksum 0x8ca1b12d, Offset: 0x5808
// Size: 0x4a
function private function_5fd6959f(var_a94aa7ef) {
    var_181b74a5 = level clientfield::get("keeper_egg_location_" + self.characterindex);
    return var_181b74a5 === var_a94aa7ef;
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x4
// Checksum 0xf52f245c, Offset: 0x5860
// Size: 0x22
function private function_a7e71a86(var_a94aa7ef) {
    return isdefined(self.var_fdda19d8.var_db999762[var_a94aa7ef]);
}

// Namespace zm_zod_sword
// Params 2, eflags: 0x4
// Checksum 0xc61b6dab, Offset: 0x5890
// Size: 0x174
function private function_dfd0ecb2(e_statue, e_killer) {
    v_start = self gettagorigin("J_SpineLower");
    e_fx = zm_zod_util::function_6c995606(v_start, self.angles);
    e_fx clientfield::set("zod_egg_soul", 1);
    e_fx playsound("zmb_zod_soul_release");
    var_408dd52f = e_statue gettagorigin(e_statue.var_9f9da194[e_killer.characterindex]);
    e_fx moveto(var_408dd52f, 1);
    e_fx waittill(#"movedone");
    e_fx playsound("zmb_zod_soul_impact");
    wait 0.25;
    e_fx clientfield::set("zod_egg_soul", 0);
    e_fx zm_zod_util::function_44a841();
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x4
// Checksum 0x960e980d, Offset: 0x5a10
// Size: 0xb8
function private function_31040961() {
    clone = spawn("script_model", self.origin);
    clone.angles = self.angles;
    clone setmodel(self.model);
    if (isdefined(self.headmodel)) {
        clone.headmodel = self.headmodel;
        clone attach(clone.headmodel, "", 1);
    }
    return clone;
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0xc5eb065b, Offset: 0x5ad0
// Size: 0x17c
function function_67bcb9d9() {
    if (self.sword_quest.var_b8ad68a0 == 0) {
        n_charges = 0;
        foreach (e_statue in level.sword_quest.var_2855c5c) {
            if (e_statue.script_noteworthy === "initial_egg_statue") {
                continue;
            }
            var_a72790d7 = e_statue.var_a72790d7;
            var_74ff1ab4 = self.sword_quest.kills[var_a72790d7];
            if (var_74ff1ab4 >= 12) {
                n_charges += 1;
            }
        }
    } else if (self.sword_quest.var_b8ad68a0 == 1) {
        n_charges = self function_b7af29e0();
    }
    self clientfield::set_player_uimodel("zmInventory.player_sword_quest_egg_state", 1 + n_charges);
}

// Namespace zm_zod_sword
// Params 2, eflags: 0x0
// Checksum 0xeb40e810, Offset: 0x5c58
// Size: 0x1ec
function function_abf3df35(var_88c5b977, b_completed) {
    if (!isdefined(b_completed)) {
        b_completed = 0;
    }
    self.sword_quest.var_f01fc13c = var_88c5b977;
    self.sword_quest.var_65b6d5b8 = gettime();
    var_42bd22b8 = level.sword_quest.eggs[self.characterindex];
    if (!isdefined(var_88c5b977)) {
        self thread zm_zod_util::function_55f114f9("zmInventory.widget_egg", 3.5);
        var_42bd22b8 ghost();
        var_42bd22b8 clientfield::set("zod_egg_glow", 0);
        var_42bd22b8 stoploopsound(1);
        return;
    }
    e_statue = level.sword_quest.var_2855c5c[var_88c5b977];
    var_42bd22b8.origin = e_statue gettagorigin(e_statue.var_9f9da194[self.characterindex]);
    var_42bd22b8.angles = e_statue gettagangles(e_statue.var_9f9da194[self.characterindex]);
    var_42bd22b8 show();
    e_statue thread function_ce7bc2ba();
    if (!(e_statue.script_noteworthy === "initial_egg_statue")) {
        self clientfield::set_player_uimodel("zmInventory.widget_egg", 0);
    }
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0x5eea0f2f, Offset: 0x5e50
// Size: 0x104
function function_ce7bc2ba() {
    self notify(#"hash_ce7bc2ba");
    self endon(#"hash_ce7bc2ba");
    b_is_active = 0;
    foreach (player in level.activeplayers) {
        if (player function_6dc5b484(self.var_a72790d7) && !player function_24978bad(self.var_a72790d7)) {
            b_is_active = 1;
        }
    }
    self thread function_3608024(b_is_active);
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x0
// Checksum 0x57998c2a, Offset: 0x5f60
// Size: 0xd4
function function_3608024(b_is_active) {
    self useanimtree(#generic);
    if (b_is_active) {
        self animation::play("p7_fxanim_zm_zod_statue_apothicon_start_anim", undefined, undefined, 1);
        self thread animation::play("p7_fxanim_zm_zod_statue_apothicon_idle_anim", undefined, undefined, 1);
        return;
    }
    self clearanim("p7_fxanim_zm_zod_statue_apothicon_start_anim", 0);
    self clearanim("p7_fxanim_zm_zod_statue_apothicon_idle_anim", 0);
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x0
// Checksum 0x7fd0f50a, Offset: 0x6040
// Size: 0xb4
function function_b6e437c3(e_player) {
    s_placement = level.sword_quest.defend.var_b526b07a[e_player.characterindex];
    if (e_player function_962dc2e9(1)) {
        return %ZM_ZOD_SWORD_DEFEND_PLACE;
    }
    if (isdefined(s_placement.var_ace0694a) && e_player.sword_quest.var_b8ad68a0 == 2) {
        return %ZM_ZOD_SWORD_DEFEND_RETRIEVE;
    }
    return %;
}

// Namespace zm_zod_sword
// Params 2, eflags: 0x0
// Checksum 0xd5bc8817, Offset: 0x6100
// Size: 0x2ac
function function_8ae67230(var_da3dac0c, var_74719138) {
    if (!isdefined(var_74719138)) {
        var_74719138 = 0;
    }
    self endon(#"disconnect");
    self function_91f4222f(var_da3dac0c);
    self notify(#"hash_b29853d8");
    wait 0.1;
    var_9313f38c = level.sword_quest.weapons[self.characterindex][var_da3dac0c];
    assert(isdefined(var_9313f38c));
    if (self function_962dc2e9()) {
        self function_c6e90f6e();
    }
    prev_weapon = self getcurrentweapon();
    self zm_weapons::weapon_give(var_9313f38c, 0, 0, 1);
    self.var_a0bd515a = self.current_hero_weapon;
    self.var_c9265b2e = 1;
    self gadgetpowerset(0, 100);
    self switchtoweapon(var_9313f38c);
    self waittill(#"weapon_change_complete");
    self thread function_29032940(var_da3dac0c, var_74719138);
    if (var_74719138) {
        self setlowready(1);
        self switchtoweapon(prev_weapon);
        self util::waittill_any_timeout(1, "weapon_change_complete", "disconnect");
        self setlowready(0);
        self.var_c9265b2e = 1;
        self clientfield::set_player_uimodel("zmhud.swordEnergy", self.var_c9265b2e);
        self gadgetpowerset(0, 100);
        self clientfield::increment_uimodel("zmhud.swordChargeUpdate");
    }
    self thread function_40f1b35b(var_9313f38c, var_da3dac0c);
}

// Namespace zm_zod_sword
// Params 2, eflags: 0x0
// Checksum 0xab7a6064, Offset: 0x63b8
// Size: 0xbc
function function_40f1b35b(var_9313f38c, var_da3dac0c) {
    self endon(#"disconnect");
    for (var_6f140d05 = 0; !var_6f140d05; var_6f140d05 = 1) {
        self waittill(#"weapon_change_complete");
        weapon = self getcurrentweapon();
        if (weapon === var_9313f38c) {
        }
    }
    zm_zod_vo::function_1f2b0c20(self.characterindex, var_da3dac0c);
    self thread zm_zod_vo::function_a543408d();
}

// Namespace zm_zod_sword
// Params 0, eflags: 0x0
// Checksum 0xd21391d0, Offset: 0x6480
// Size: 0x68
function function_c6e90f6e() {
    var_d53298a1 = self zm_utility::get_player_hero_weapon();
    self zm_weapons::weapon_take(var_d53298a1);
    self.current_hero_weapon = undefined;
    self.var_a0bd515a = undefined;
    self.var_c9265b2e = 0;
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x0
// Checksum 0xed8d695c, Offset: 0x64f0
// Size: 0x98
function function_962dc2e9(var_da3dac0c) {
    if (!isdefined(var_da3dac0c)) {
        var_da3dac0c = self.sword_quest.var_b8ad68a0;
    }
    if (!isdefined(level.sword_quest.weapons[self.characterindex][var_da3dac0c])) {
        return false;
    }
    if (self zm_utility::get_player_hero_weapon() === level.sword_quest.weapons[self.characterindex][var_da3dac0c]) {
        return true;
    }
    return false;
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x0
// Checksum 0xd7a7635d, Offset: 0x6590
// Size: 0x64
function function_dc5f350c(var_da3dac0c) {
    if (!isdefined(var_da3dac0c)) {
        var_da3dac0c = self.sword_quest.var_b8ad68a0;
    }
    return self getcurrentweapon() == level.sword_quest.weapons[self.characterindex][var_da3dac0c];
}

// Namespace zm_zod_sword
// Params 2, eflags: 0x0
// Checksum 0xe523132f, Offset: 0x6600
// Size: 0xfc
function function_29032940(var_da3dac0c, var_74719138) {
    if (!isdefined(self.var_75dcfb99)) {
        self.var_75dcfb99 = 0;
    }
    if (self.var_75dcfb99 >= var_da3dac0c) {
        return;
    }
    self.var_75dcfb99++;
    if (var_74719138) {
        while (self function_dc5f350c()) {
            self waittill(#"weapon_change_complete", weapon);
        }
    }
    while (!self function_dc5f350c()) {
        self waittill(#"weapon_change_complete", weapon);
    }
    if (var_da3dac0c == 1) {
        zm_equipment::show_hint_text(%ZM_ZOD_SWORD_1_INSTRUCTIONS, 5);
        return;
    }
    zm_equipment::show_hint_text(%ZM_ZOD_SWORD_2_INSTRUCTIONS, 5);
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x0
// Checksum 0x40215594, Offset: 0x6708
// Size: 0x7a0
function function_2c009d2e(e_statue) {
    if (isdefined(e_statue.trigger)) {
        return;
    }
    s_trigger_pos = struct::get(e_statue.target, "targetname");
    e_statue.trigger = zm_zod_util::function_d095318(s_trigger_pos.origin, 64, 1, &function_2f31f931);
    e_statue.trigger.var_a72790d7 = e_statue.var_a72790d7;
    while (true) {
        e_statue.trigger zm_zod_util::function_c1947ff7();
        e_statue.trigger waittill(#"trigger", e_who);
        if (!isdefined(e_who.var_b170d6d6) && !level flag::get("keeper_sword_locker")) {
            continue;
        }
        if (isdefined(e_who.sword_quest.var_f01fc13c)) {
            if (e_who.sword_quest.var_f01fc13c == e_statue.var_a72790d7) {
                if (e_who.sword_quest.kills[e_statue.var_a72790d7] >= 12) {
                    e_who function_abf3df35(undefined);
                    e_who thread zm_zod_vo::function_9bd30516();
                    e_who playsound("zmb_zod_egg_pickup");
                    if (e_statue.script_noteworthy === "initial_egg_statue") {
                        wait 0.1;
                        e_who clientfield::set_player_uimodel("zmInventory.player_sword_quest_egg_state", 1);
                        e_who thread zm_zod_util::function_69e0fb83("ZM_ZOD_UI_LVL1_EGG_PICKUP", 3.5);
                    } else {
                        e_who function_67bcb9d9();
                    }
                    if (e_who.sword_quest.var_b11b4a7a) {
                        e_who function_91f4222f(1);
                    }
                }
            }
            continue;
        }
        if (e_who.sword_quest.kills[e_statue.var_a72790d7] < 12) {
            e_who function_abf3df35(e_statue.var_a72790d7);
            e_who playsound("zmb_zod_egg_place");
            e_who clientfield::set_player_uimodel("zmInventory.widget_egg", 0);
            e_who thread zm_zod_vo::function_c10cc6c5();
            continue;
        }
        if (e_who.sword_quest.var_b8ad68a0 > 0 && e_statue.script_noteworthy === "initial_egg_statue" && e_who.var_b170d6d6 === 0) {
            e_who playsound("zmb_zod_egg_place");
            e_who clientfield::set_player_uimodel("zmInventory.widget_egg", 0);
            e_who.var_b170d6d6 = 1;
            e_who thread zm_zod_vo::function_c10cc6c5();
            e_who.sword_quest.var_f01fc13c = undefined;
            switch (e_who.characterindex) {
            case 0:
                level.sword_quest.var_979d4987[e_who.characterindex] setmodel("wpn_t7_zmb_zod_sword1_box_world");
                break;
            case 1:
                level.sword_quest.var_979d4987[e_who.characterindex] setmodel("wpn_t7_zmb_zod_sword1_det_world");
                break;
            case 2:
                level.sword_quest.var_979d4987[e_who.characterindex] setmodel("wpn_t7_zmb_zod_sword1_fem_world");
                break;
            case 3:
                level.sword_quest.var_979d4987[e_who.characterindex] setmodel("wpn_t7_zmb_zod_sword1_mag_world");
                break;
            }
            level.sword_quest.var_979d4987[e_who.characterindex].var_c9c683e8 = 1;
            e_statue.trigger zm_zod_util::function_c1947ff7();
            wait 0.75;
            level.sword_quest.var_979d4987[e_who.characterindex] thread clientfield::set("sword_statue_glow", 1);
            wait 0.75;
            level.sword_quest.var_979d4987[e_who.characterindex].var_c9c683e8 = 0;
            continue;
        }
        if (e_who.sword_quest.var_b8ad68a0 > 0 && e_statue.script_noteworthy === "initial_egg_statue" && e_who.var_b170d6d6 === 1) {
            e_who.var_b170d6d6 = undefined;
            level.sword_quest.var_979d4987[e_who.characterindex] thread clientfield::set("sword_statue_glow", 0);
            level.sword_quest.var_979d4987[e_who.characterindex] ghost();
            e_who function_8ae67230(e_who.sword_quest.var_b8ad68a0, 1);
            if (e_who.sword_quest.var_b8ad68a0 != 2) {
                e_who notify(#"hash_1867e603");
                e_who thread zm_zod_util::function_69e0fb83("ZM_ZOD_UI_LVL1_SWORD_PICKUP", 3.5);
                e_who function_67bcb9d9();
            }
        }
    }
}

// Namespace zm_zod_sword
// Params 1, eflags: 0x0
// Checksum 0xfa6a2d50, Offset: 0x6eb0
// Size: 0x68
function function_91f4222f(n_level) {
    if (self.sword_quest.var_b8ad68a0 == n_level) {
        return;
    }
    switch (self.sword_quest.var_b8ad68a0) {
    case 1:
        break;
    }
    self.sword_quest.var_b8ad68a0 = n_level;
}

/#

    // Namespace zm_zod_sword
    // Params 0, eflags: 0x0
    // Checksum 0x1ffa3f48, Offset: 0x6f20
    // Size: 0x790
    function function_9b87ec91() {
        setdvar("<dev string:x28>", 0);
        setdvar("<dev string:x38>", "<dev string:x48>");
        setdvar("<dev string:x49>", "<dev string:x48>");
        setdvar("<dev string:x57>", 0);
        adddebugcommand("<dev string:x6a>");
        adddebugcommand("<dev string:xa3>");
        adddebugcommand("<dev string:xdc>");
        adddebugcommand("<dev string:x11b>");
        adddebugcommand("<dev string:x153>");
        level thread zm_zod_util::function_72260d3a("<dev string:x190>", "<dev string:x1bf>", 0, &function_b3babd8c);
        level thread zm_zod_util::function_72260d3a("<dev string:x1d9>", "<dev string:x1bf>", 1, &function_b3babd8c);
        level thread zm_zod_util::function_72260d3a("<dev string:x206>", "<dev string:x1bf>", 2, &function_b3babd8c);
        level thread zm_zod_util::function_72260d3a("<dev string:x230>", "<dev string:x1bf>", 4, &function_b3babd8c);
        var_da3dac0c = 0;
        var_47719d0d = 0;
        var_511a9112 = getent("<dev string:x260>", "<dev string:x273>");
        while (true) {
            n_level = getdvarint("<dev string:x28>");
            if (n_level == 1) {
                foreach (e_player in level.activeplayers) {
                    e_player.var_c8364c36 = 0;
                    e_player zm_weap_glaive::function_24587ddb();
                    e_player notify(#"hash_b29853d8");
                    if (isdefined(e_player.var_c0d25105)) {
                        e_player.var_c0d25105 notify(#"returned_to_owner");
                    }
                    e_player function_8ae67230(n_level, 1);
                    e_player.var_86a785ad = 1;
                    e_player notify(#"hash_1867e603");
                    setdvar("<dev string:x28>", "<dev string:x285>");
                }
            } else if (n_level == 2) {
                foreach (e_player in level.activeplayers) {
                    e_player.var_c8364c36 = 0;
                    e_player zm_weap_glaive::function_24587ddb();
                    e_player notify(#"hash_b29853d8");
                    if (isdefined(e_player.var_c0d25105)) {
                        e_player.var_c0d25105 notify(#"returned_to_owner");
                    }
                    e_player function_8ae67230(n_level, 1);
                    e_player.var_86a785ad = 1;
                    setdvar("<dev string:x28>", "<dev string:x285>");
                }
            }
            var_dc464dee = getdvarstring("<dev string:x38>");
            switch (var_dc464dee) {
            case "<dev string:x287>":
                foreach (e_player in level.players) {
                    e_player.sword_quest.cheat = 1;
                }
                break;
            default:
                break;
            }
            var_dc464dee = getdvarstring("<dev string:x49>");
            switch (var_dc464dee) {
            case "<dev string:x28a>":
                foreach (e_player in level.players) {
                    if (!isdefined(e_player.var_8135101c)) {
                        e_player.var_8135101c = 1;
                        continue;
                    }
                    e_player.var_8135101c = !e_player.var_8135101c;
                }
                break;
            default:
                break;
            }
            setdvar("<dev string:x49>", "<dev string:x48>");
            var_e4b329eb = getdvarint("<dev string:x57>");
            if (var_e4b329eb > 0) {
                foreach (e_player in level.players) {
                    zm_weap_glaive::function_7855de72(e_player);
                }
            }
            setdvar("<dev string:x57>", "<dev string:x285>");
            util::wait_network_frame();
        }
    }

    // Namespace zm_zod_sword
    // Params 1, eflags: 0x0
    // Checksum 0xb29f2a65, Offset: 0x76b8
    // Size: 0x10
    function function_31880c32(var_27b0f0e4) {
        
    }

    // Namespace zm_zod_sword
    // Params 1, eflags: 0x0
    // Checksum 0x66881435, Offset: 0x76d0
    // Size: 0xd4
    function function_b3babd8c(var_5df86706) {
        foreach (player in level.players) {
            for (i = 0; i < 4; i++) {
                player clientfield::set_to_player("<dev string:x291>" + i, var_5df86706);
            }
        }
    }

#/
